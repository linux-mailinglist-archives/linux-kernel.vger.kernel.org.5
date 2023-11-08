Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 519997E5902
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 15:31:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232641AbjKHObJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 09:31:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235520AbjKHOaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 09:30:46 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAB531FD5;
        Wed,  8 Nov 2023 06:30:26 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-53fa455cd94so4448274a12.2;
        Wed, 08 Nov 2023 06:30:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699453826; x=1700058626; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oTzaAd+2ZeXUVNzWH6rbuqYoCosvVtTThNRJO7A65wk=;
        b=gvaNZWnPLjDgYY76GrQpAFCyrUX24MDMZh+wnJlSzLojEKxUTu8S195v4lSEgsIAg2
         dX5Glf9ZN+4L0WKO8wS0vBA7cpuGro+G8TC6x0QClCWdpUbfECePOyU3Jz7hutmMeQcO
         g2MQb/Q0xX9d2CKzAmVot4pMwFh6GMtVJg0Ak6WBjj/sL6BGClgAGFUOvH1kitCSJY0R
         RYUl85eeICx+T3UWFCip6w4cBTI3GJ+3oM0qhgRWhkkNQW+jfJxsY+n+nJxHtXxg6DHb
         CDZApNLl0p0RW5YK7Tuo/Hf645mSzHbwC6m4fOFWxZJf/sofOG3AnmOHEfAAJdR48V08
         oT7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699453826; x=1700058626;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oTzaAd+2ZeXUVNzWH6rbuqYoCosvVtTThNRJO7A65wk=;
        b=dP6F9bVYay+4RWWb4N/1SaNiDy24oiecrxhV8TBzRNREH9hxXANm4JU+QxWoRRbGIW
         mEJPKwKTuzXzP9wc7BIdBXeyjKqeckZkjlqaoLDQP7TwiQdh9oiiaj3n/PTOyTOYkCgE
         oI35mJdqqlduKFG0BWhfEJRToGb2Wmfp3xHHj0JMGi1zJQnOBzMvBFglIDCMVUNOA88s
         9TNtyjhlsYS7PU2lB0QnqRvxv7CQQfQc8MLWFAGnF4p3v7sxL2jVz1TfJOLxcrJ/Re22
         UKJLQYsElObC1+gr6lf7aW27lsVtxiv91vNjwmJEGpDo42jR+VOb+QpX08XmtZYTeJo+
         yihQ==
X-Gm-Message-State: AOJu0YxoGpKIKT7AkOlrLpyGlya7YSa0GbZ3rYu4EcQu3+pMtwbvXSk9
        A7mY+URtYXYcECsU+VQUwSU=
X-Google-Smtp-Source: AGHT+IE1uqL8BwZwNN7KNjHJV5QEuRLukkj6KHdnddSGBgXFasdAN17kz17Qkm+qhcHYTLWZEPcjeA==
X-Received: by 2002:a05:6a20:1594:b0:152:1ce8:ce3a with SMTP id h20-20020a056a20159400b001521ce8ce3amr2278552pzj.18.1699453825902;
        Wed, 08 Nov 2023 06:30:25 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n1-20020aa78a41000000b0068fbaea118esm9077349pfa.45.2023.11.08.06.30.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 06:30:25 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 8 Nov 2023 06:30:24 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 5.15 000/125] 5.15.138-rc2 review
Message-ID: <7ae8d071-3541-485b-b45f-6e4eae527f43@roeck-us.net>
References: <20231107202324.434534294@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231107202324.434534294@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2023 at 09:24:45PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.138 release.
> There are 125 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 09 Nov 2023 20:22:58 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 160 pass: 160 fail: 0
Qemu test results:
	total: 509 pass: 509 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
