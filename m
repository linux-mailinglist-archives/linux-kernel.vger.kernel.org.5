Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FF2081149D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 15:30:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441942AbjLMOaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 09:30:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441897AbjLMOaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 09:30:11 -0500
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31DCBF5;
        Wed, 13 Dec 2023 06:30:18 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id e9e14a558f8ab-35d718382b7so29060935ab.1;
        Wed, 13 Dec 2023 06:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702477817; x=1703082617; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BADNCYI7ARVEMi4bULCsWCLAvCC6uH/j3ttfZo4ZFh4=;
        b=JpwBG+r6ViYuc2zfnM0Y/1KCwmsh5MgzoPBPVX+VG+b56grLaQupZ5OeqQUw4Z+jj7
         FhF3WQQUSOoeQPT3bwrxrfq2pd7HkTHD+fSkUcT3kTB5q6QVCq8vEJsmmHC4v3I/s6To
         rQdy6EUIW5bveQVizs0jC449swDv3KrJbWpgQfdr1dCCr1uwIFVkKXLvlbln/m5wHMmt
         VnbxQU+TPIX5/GLEuwAKAwN4d8lEPgIjANXo65JbLmPdLpRP803x0NrhZpmiPr+EVSKd
         l0LquqNUz/7JIqZZs0YLdBdW1N1eipXJdbQbmOgS83OiVcT6rpwJ0BekxKw3fV8BoR7g
         hYxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702477817; x=1703082617;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BADNCYI7ARVEMi4bULCsWCLAvCC6uH/j3ttfZo4ZFh4=;
        b=RYkyUwIEo4RFMK9b1vjTv0ZSjVA/BGQi9qd0brTzJ+nJxxNG6fia9vWfgm7XI1aQHE
         yxUszLVGyFSoNX6MIPgBJ4gXBassCdGyQptMZ91Yyucuo4THO+bz4l/VwIpEIWWIW5th
         CYZ1i8ANE+heMOBBDFinQQpdJ9ywcGul95G5Dppt9Wmr7e3RqcUSO7MunZ/eSHOI8GjM
         HB8+5G8Y7QF8raYBDAZSn2WgA5J4LwcQIFM8yVBGYwvfICrx7EqburXdWMjGio2Zpijm
         id6zvAksIz4FsvmLmqjkrH+dQom9NAzGcLyhNNYh0FdqhpsFkin11jFla/oGZ9rgn9I5
         iw/A==
X-Gm-Message-State: AOJu0YzQRVgM8OcUhKMi0t0fGytCADOj6nfKAvKgk4V5BXQwwxe2hYWC
        jJoq1CfvUNGmLGS9DvENnG8=
X-Google-Smtp-Source: AGHT+IFbIak+XCynC6U6G+3v2hHkzbggZqbLN+akC1pLq4lzTugL9jWct41vx33M7rwpEl+oO7U3nw==
X-Received: by 2002:a05:6e02:184b:b0:35d:6d53:5439 with SMTP id b11-20020a056e02184b00b0035d6d535439mr12806246ilv.11.1702477817424;
        Wed, 13 Dec 2023 06:30:17 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q27-20020a63f95b000000b005c6746620cfsm10005338pgk.51.2023.12.13.06.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 06:30:16 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 13 Dec 2023 06:30:14 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        allen.lkml@gmail.com
Subject: Re: [PATCH 4.14 00/24] 4.14.333-rc2 review
Message-ID: <89626bb7-d3c4-467b-a905-59f4390bd383@roeck-us.net>
References: <20231212120146.831816822@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212120146.831816822@linuxfoundation.org>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2023 at 01:05:03PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.333 release.
> There are 24 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 14 Dec 2023 12:01:26 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 139 pass: 139 fail: 0
Qemu test results:
	total: 440 pass: 440 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
