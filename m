Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C461478D1DD
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 03:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241646AbjH3B5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 21:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238208AbjH3B44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 21:56:56 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 345EAFC;
        Tue, 29 Aug 2023 18:56:53 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id e9e14a558f8ab-34b4b2608e3so17918475ab.3;
        Tue, 29 Aug 2023 18:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693360612; x=1693965412; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dohu8JcCYbtfCQEoNAJu4CBtsaFe5TpGhloC7g3jQYI=;
        b=RcL7MDNw5n48pBvEJYQuCru+gd2xzFJJOsErgwMhwFK77PghjVX3+aT//P9bispxrD
         mDVlveDXJjK4SV7ZjVDCXa8KW21YokHEUfjSRm/YbQSAMsYXGymStczb7c1CD5l+ebo0
         EzM8UhLzpn2/h8QnYsdSVFwi1rmtRnasThnhlzqLnnLJxJ6Goy0SSBWVQ3mmP03p1Ced
         sjmEzPUJhb83e3orrjFjx+vVdbwo+zMkyM5Cxjbb5/zflOmItmjRohcVbVISDzL4MxUx
         NDA1XSjOqH1rtwOx6WFfctI65369v9LynWZsPBThEiyBkLBSta1i23pasqndcHpnTv6W
         e/cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693360612; x=1693965412;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dohu8JcCYbtfCQEoNAJu4CBtsaFe5TpGhloC7g3jQYI=;
        b=XVkTvz9qwIBd3P6LqXeVQEJbGdVfgNta1LFJX57gHvm/chsLBlzZBO2cV/e6k4IuIc
         +/cmcch13Wu0QOLtk+l6oTWb2K4gATv0tnQaZOwVIJKPs/v+YbbCoBsNS4/COaaSsNvm
         Dgow0kHB/3YQdYpqrGJA+BQS102IsLIMLY9Mvf81I6GcrRgJ+3f0h9uMeI9mCDDZpqiQ
         hqSqxrqOkyWXhPiZTGNRAEvFSrnNkGqBmk+ZXdroPriTCKGHVlR2bU2EovwXwHaa8dsV
         YoJ6B99Qawl7eoY/x+9E6Cn1E+BbJ5myXLsD64aXaf7rOCpl60K5vUqUY9D3leHNPYqB
         PbvQ==
X-Gm-Message-State: AOJu0YzsBUh6mN2R7MWtaHUn9OwuzxMbaYiXhNFywPP4Z+oqD+VmFhzK
        s8Q8AMJtf1TBiemh2CgbPsU=
X-Google-Smtp-Source: AGHT+IESZC0XichRF7tbayUE0qjAYkv7esnNqWRRnO232/hCeng+/RC1mg/YD9CIJhuoqmrh/uuIGg==
X-Received: by 2002:a92:dc87:0:b0:348:8576:15b5 with SMTP id c7-20020a92dc87000000b00348857615b5mr1017781iln.3.1693360612586;
        Tue, 29 Aug 2023 18:56:52 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u4-20020a02c044000000b0042b0ce92dddsm3560561jam.161.2023.08.29.18.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 18:56:52 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 29 Aug 2023 18:56:51 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 4.14 00/57] 4.14.324-rc1 review
Message-ID: <98dbc981-56fa-4919-afcc-fdf63e0a1c53@roeck-us.net>
References: <20230828101144.231099710@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230828101144.231099710@linuxfoundation.org>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2023 at 12:12:20PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.324 release.
> There are 57 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 30 Aug 2023 10:11:30 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 139 pass: 133 fail: 6
Failed builds:
	arm:ep93xx_defconfig
	mips:mtx1_defconfig
	mips:db1xxx_defconfig
	powerpc:defconfig
	powerpc:allmodconfig
	powerpc:cell_defconfig
Qemu test results:
	total: 431 pass: 414 fail: 17
Failed tests:
	<all ppc64:pseries>

arm:ep93xx_defconfig

Error log:
arch/arm/mach-ep93xx/timer-ep93xx.c:12:10: fatal error: platform.h

That is really an older problem, caused by commit 2e50d55578b0 ("ARM:
ep93xx: fix missing-prototype warnings") which instead of fixing
anything in v4.14.y broke its build.

mips:mtx1_defconfig

arch/mips/alchemy/common/dbdma.c:33:10: fatal error: linux/dma-map-ops.h: No such file or directory

Again, an older problem, caused by commit 10130470bb0 ("MIPS: Alchemy:
fix dbdma2").

powerpc:defconfig, powerpc:allmodconfig, powerpc:cell_defconfig

arch/powerpc/kernel/rtas_flash.c: In function 'rtas_flash_init':
arch/powerpc/kernel/rtas_flash.c:717:29: error: implicit declaration of function 'kmem_cache_create_usercopy'

ppc64 boot tests fail to compile with the same error.

Guenter
