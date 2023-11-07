Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 657177E48C3
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 19:53:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235261AbjKGSxA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 13:53:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbjKGSw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 13:52:58 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6D10119;
        Tue,  7 Nov 2023 10:52:56 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-280109daaaaso4516841a91.3;
        Tue, 07 Nov 2023 10:52:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699383176; x=1699987976; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2Q9inq432z5oHT34bxyt1VbDMPDDlVXPXNahD98Qs5U=;
        b=KQ2hGWnu4usE226rTjsrEoOtcjx1sxos90QzhnToQjpmbaQT6nCsTzMaIpDEK2uYLR
         NhgCipTozwV1Nv8VEUWOyZNxuSndGPOEfIB4v+JzbLxI37ZEtS0Dhx/8lZRMdi0aDD33
         Cmd4AkedvH3OfGHgjqkZznKRXsm12rQmDa9oOR4pMjfaq8COLuPBW9WdiU03t7rPtn1b
         wtfF0ODCbjaGDiHb+lqTFG5mW9BBMyM6AVZO+VHXWpU/y/SR8HVmzPGlrpV5iu8yITls
         RaVnogxwCJQYygWU15rwVzL/OkdlmURsG9pdfvTqtHzb2xoxKO2brz44H+ZrRbLzbue9
         sKVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699383176; x=1699987976;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Q9inq432z5oHT34bxyt1VbDMPDDlVXPXNahD98Qs5U=;
        b=AtcWxCukhp/yiAGUPtzy1UPHx5zpR0Dcp+7O3KAYVfTr9rG5zgHdqOF0GhXemtNhAD
         3eHI+otsEJfVcxDjBEAuZcV4Dx/C9DcdCLgwFb6ilL6rt9g6Y4tMJhgR33O7IfV2SLrC
         nBk3OsHEvhYWW4wr2dhsNs5eT0jAZP/SF0Xlg1h5xRUrztNQ3ig5FLYsgoEm6VyQPRYD
         K0Fg5sf4qPyPfMyKXp4fvB3hvK8RWgvi+BcTg6yh9SV/flO8VQaVUhrdn1kJYGxTVQbU
         GjcmgeWRfNnVVlHyvmDjJEaEhbR6HLMf2fpKWSTuR5MLQSm7KSrP46SHFjKfwbH5J633
         LSiA==
X-Gm-Message-State: AOJu0YzyzQn39fqEthoEFc7fI8ipG0fR8px3MKyCIrdSO1NsW/Mej+Zu
        Y1qJwW3lwPq+O8QzRwqbZNU=
X-Google-Smtp-Source: AGHT+IHMutGErqmrSjLk4urZUIoQ/J7YGHYvEJ+VyeukMn/gyM9fYHXc07S3NGbPmRSlIqORI2Re+w==
X-Received: by 2002:a17:90a:c90f:b0:280:256c:abae with SMTP id v15-20020a17090ac90f00b00280256cabaemr21310466pjt.40.1699383176083;
        Tue, 07 Nov 2023 10:52:56 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w7-20020a17090aad4700b00280fcbbe774sm152993pjv.10.2023.11.07.10.52.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 10:52:55 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 7 Nov 2023 10:52:54 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 4.14 00/48] 4.14.329-rc1 review
Message-ID: <3b7a2cda-412b-4875-9331-74112119e0af@roeck-us.net>
References: <20231106130257.862199836@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231106130257.862199836@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 06, 2023 at 02:02:51PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.329 release.
> There are 48 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 08 Nov 2023 13:02:46 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 139 pass: 139 fail: 0
Qemu test results:
	total: 440 pass: 440 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
