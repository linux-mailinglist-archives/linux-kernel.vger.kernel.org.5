Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AFBC78FB5B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 11:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbjIAJqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 05:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231540AbjIAJql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 05:46:41 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59375173E;
        Fri,  1 Sep 2023 02:46:26 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3fbd33a57b6so17078765e9.2;
        Fri, 01 Sep 2023 02:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693561585; x=1694166385; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LJ5sMtYdIYKsrQCl5YLIcPHoNwIAIngA/Abzs2s406g=;
        b=HCYm/o/B7DscQCHies+Ijkf5Ql5lMSuWl/cEZsTOKyUoMYXVDjVPubogYd/duHJ09m
         Gau+0cqIy5GMCgq6fzIAARScPdxE+tS/0ZBIxOvhGBoSnIJQenx6gyxO+2mrQkGR5+9G
         BGvAmorcrTQoSJLs3e3o1dtH090Kagc148dmQvjA08vtA0cdlSSk7mNkTAJULZmHqYDu
         YHqHq8eqdFGotQUdqxc78HRWWLl3dPaOOzaolXK82qSUbqOb89Ia/RoTFUBbVFnirmA5
         12pxIv6fPuyGV/9ERkygoD56JekpVtml/Jn6IoS4miIfll5Dq9ft71OyPWyIvzUt1qps
         5qbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693561585; x=1694166385;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LJ5sMtYdIYKsrQCl5YLIcPHoNwIAIngA/Abzs2s406g=;
        b=Uc5xyHZBESmtKTXv2VYCwZcjM/heHT+5c7QVgbiDaVjhMzRQDcHhtarqT7TxQjweVE
         0zMb8T5fU7tVepl409RorR2JXWeMWwfPnEd9NzvAGwbBgzI2YNnLoLZT6rbegCyiX8Pc
         FPnUCSaTrbrkfclZsRe0R8hJIX6D8q1rouXXYNxCAYVNEXKY17VjFoibitB/b+fsWwwI
         fDE0TnuolP59O6rcuzgLCB80w+0VAQZiJGgdxcqEHGKhvycDGOU/gXUWS4oe392uAjEt
         QswriKr/yz1yQLlVdaQPDxFul8fiyTwbE6gCuvzfa8wSTa4ozsyvSv0k1PuqGxNSFKq3
         4Cgg==
X-Gm-Message-State: AOJu0Yx8gXC2j29zhOgikPL9mXRji48WFUOGSDcrtoD547llMJfbKK7F
        ec0xWAQu2lJmhE8/droDifQ=
X-Google-Smtp-Source: AGHT+IHeoEJza6WtyVE6WqFbM2nV6YWS4NSrpRVXvTFAGVosHG/sdf1zh2jYjGV/fjbQSxeC67kTfg==
X-Received: by 2002:a7b:ce88:0:b0:401:b204:3b98 with SMTP id q8-20020a7bce88000000b00401b2043b98mr1323127wmj.19.1693561584581;
        Fri, 01 Sep 2023 02:46:24 -0700 (PDT)
Received: from debian ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id y11-20020a05600c20cb00b003fc02e8ea68sm7439143wmm.13.2023.09.01.02.46.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Sep 2023 02:46:24 -0700 (PDT)
Date:   Fri, 1 Sep 2023 10:46:22 +0100
From:   "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com, srw@sladewatkins.net,
        rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 6.4 0/9] 6.4.14-rc1 review
Message-ID: <ZPGy7iBF+avgfn6Z@debian>
References: <20230831111127.667900990@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230831111127.667900990@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Thu, Aug 31, 2023 at 01:11:27PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.4.14 release.
> There are 9 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 02 Sep 2023 11:11:18 +0000.
> Anything received after that time might be too late.

Build test (gcc version 12.3.1 20230829):
mips: 52 configs -> no failure
arm: 70 configs -> no failure
arm64: 3 configs -> no failure
x86_64: 4 configs -> no failure
alpha allmodconfig -> no failure
csky allmodconfig -> no failure
powerpc allmodconfig -> no failure
riscv allmodconfig -> no failure
s390 allmodconfig -> no failure
xtensa allmodconfig -> no failure

Boot test:
x86_64: Booted on my test laptop. No regression.
x86_64: Booted on qemu. No regression. [1]
arm64: Booted on rpi4b (4GB model). No regression. [2]
mips: Booted on ci20 board. No regression. [3]

[1]. https://openqa.qa.codethink.co.uk/tests/4891
[2]. https://openqa.qa.codethink.co.uk/tests/4895
[3]. https://openqa.qa.codethink.co.uk/tests/4894

Tested-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>

-- 
Regards
Sudip
