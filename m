Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DDC678D1E1
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 04:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241648AbjH3CB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 22:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238208AbjH3CBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 22:01:04 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5562719A;
        Tue, 29 Aug 2023 19:01:02 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id ca18e2360f4ac-7950fac19f2so45626539f.3;
        Tue, 29 Aug 2023 19:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693360861; x=1693965661; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uBJ3hYsypardy5bqovi6u1iDRftB1teY+ENziJZCw2U=;
        b=GVHYK3wFFqNgpHbzZsRJF2drNfPQi2MqxkOEi9Jj/aLlsmR6Gl2WWZHOQ5EY4Z8eN8
         9BMfHHBPNkDDA09ZnaHiSXN73XA+5VSrm/3PwAEAVeUFsSfvg2469DV+NsvN4Avcj/Wd
         me9igT5n5mb3/qZzupino6jnLaZ/UMPqbncKdmm8I49YwIJ5fs6/GFLb7OGf1FwGCwbb
         cgltHJonAcEbTYqzgbv/xe4fjJV5Kboz8fAZpiPxWrvibUBbtiv77e2pjvvRJpwpX74X
         oohNy2GjLaDc0B5Hna1OKVe49iomxpmn8GPXT6Z0fzbtrzhUTyx8j1jjK5aXaFtZHtIi
         OkQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693360861; x=1693965661;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uBJ3hYsypardy5bqovi6u1iDRftB1teY+ENziJZCw2U=;
        b=Bx31+f3H//gSTnaRevfgc+0RQx56USMxnT30iQtUDufzVuMo8qjDTNlR2cprQwsLjH
         3HmpRXExAJ+XRO5NHJRMWka9y4RKS7clIif2Q5stxg65+w/z95mcS5KIzH9K5bexw4WA
         W4hwf6tHDCGSUKPTB7IFgbnaSjBygo44r4uHg66BbaP6Xh6OIxoniXabVcM4ZqM73Q10
         Yhj7QOytGuoBSzztB8H6giG362Ysyg2gsIAaSq2HTkVjg41owzoJf53sNok2/NIETxGK
         Y2WTg79IXOnCB3yL/pK1jyl96pAwVG5aCFefnbQt+5kTmk2BB5Wc4MyFZdgqVFw1sM3H
         mVaA==
X-Gm-Message-State: AOJu0YzsQ7w9iyuqku7eYzI+R4qCDO6SHfcwOH1lJGPBIkr51QzzeGJ9
        kbyDt8jli467ePmwx8oTnKg=
X-Google-Smtp-Source: AGHT+IFdlpuCa4wtV8m0eRng+0OGcJQWEFhqL8ck+0oeWUOSlJixI0fx7ITrQM+GCCMpTlnajilveQ==
X-Received: by 2002:a5e:d713:0:b0:786:4795:30c9 with SMTP id v19-20020a5ed713000000b00786479530c9mr1220078iom.20.1693360861663;
        Tue, 29 Aug 2023 19:01:01 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k13-20020a6b6f0d000000b0078680780694sm3612024ioc.34.2023.08.29.19.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 19:01:01 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 29 Aug 2023 19:01:00 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 4.19 000/129] 4.19.293-rc1 review
Message-ID: <59f19613-990c-4e58-b53d-c5f764483119@roeck-us.net>
References: <20230828101153.030066927@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230828101153.030066927@linuxfoundation.org>
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

On Mon, Aug 28, 2023 at 12:11:34PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.293 release.
> There are 129 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 30 Aug 2023 10:11:30 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 149 pass: 144 fail: 5
Failed builds:
	arm:allmodconfig
	arm:omap2plus_defconfig
	arm:ep93xx_defconfig
	mips:mtx1_defconfig
	mips:db1xxx_defconfig
Qemu test results:
	total: 438 pass: 407 fail: 31
Failed tests:
	<lots of arm>

arm:allmodconfig and others

drivers/bus/ti-sysc.c: In function 'sysc_reset':
drivers/bus/ti-sysc.c:982:15: error: implicit declaration of function 'sysc_read_sysconfig'

arm boot tests fail with the same build error.

arm:ep93xx_defconfig

arch/arm/mach-ep93xx/timer-ep93xx.c:12:10: fatal error: platform.h

mips:mtx1_defconfig

arch/mips/alchemy/common/dbdma.c:33:10: fatal error: linux/dma-map-ops.h

Guenter
