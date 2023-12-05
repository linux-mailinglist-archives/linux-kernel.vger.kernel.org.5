Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D0FA805B73
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:48:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235196AbjLEQzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 11:55:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235295AbjLEQz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 11:55:26 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 880A610C4;
        Tue,  5 Dec 2023 08:55:02 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id 46e09a7af769-6d83ff72dbbso1990246a34.1;
        Tue, 05 Dec 2023 08:55:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701795302; x=1702400102; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G9OxrBZgNphVEIKMq/OBJrIuosfHOMdhPrtNTXIWYyM=;
        b=XEBGg1xppZo1HdcPGjSQAtMe8Zw6Kf8XRBpohzUFBrdVYds865p1xzfpXvsUHaci85
         8Q4cqB5BGQt+GHrXuvSqCUAwidFDs0TA2u4DEQHAfQX2VChYK5lBWoFxeU0X4KfJIClk
         2dgl2hvysRRMFz0bk5vhtDdAOp8PKLl7Ljz/njhzQk3pWH4p9MljC7wghRIIEROhFGCF
         DhxlbGeDsNHC6PV9hmetjMDgcDjOIgoWRzvkOZhXTwqKCsQa8Q0Qyvfq413uE/L2pg7U
         +6S40HyTH8vq6vw6ZvsZ8ZeJ8goTn6snkITB9ehzzRjVxDtUk//p5LJMUAsJHncrHsNG
         IE4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701795302; x=1702400102;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G9OxrBZgNphVEIKMq/OBJrIuosfHOMdhPrtNTXIWYyM=;
        b=gAzaSo1Q1H62H70ynJiM+6li/YD4Tu61UUftxNQ4TF8oBpBxKq+W9/n/S6akAcwUeR
         mo4OtJQ9ymRiiYNjz2GDEpdsireHAf5T/E1Xz/QSh+2JeJLo4A9GFh5pNFMFEyfwAAKf
         5xNE2DsSixWpbCPs1l7PuV9MWm4y9GznHAimou4zDcOkqhDhU3pZJM3LFq8uYz5qANNH
         +PR23GDyGy3pMUfyJLkcJf+lqtNIIZr2ZD6lQFqerAs7z/sDpt8GukbwRGOUXr5Yj9x8
         YJ+b2udgxZlpbz6h8DacRCykX2b/xCPRa6+8n6fdFj0xwWUISt/wzHMNIsjL8gKbPZHp
         GlWA==
X-Gm-Message-State: AOJu0YzhtoZVnQrUZFBIsCIpR3mhl5qETQxycetAHzsCzytbogI3cxWp
        VxGPVyz03vI7dXcBL7ZrZTM=
X-Google-Smtp-Source: AGHT+IEBC/Md1Vt7qRHajPubEQ4P+Al1cYnLz+7MzGO+7kte/K8NgAKU1tSgv/bPF0GNxKXuH8kqKQ==
X-Received: by 2002:a9d:6a8e:0:b0:6d8:779a:1b1b with SMTP id l14-20020a9d6a8e000000b006d8779a1b1bmr856434otq.7.1701795301875;
        Tue, 05 Dec 2023 08:55:01 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z5-20020a9d65c5000000b006d679b53e8asm2289178oth.24.2023.12.05.08.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 08:55:01 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 5 Dec 2023 08:55:00 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        allen.lkml@gmail.com
Subject: Re: [PATCH 6.1 000/107] 6.1.66-rc1 review
Message-ID: <ca62c23a-ee16-404d-b983-a680857737b3@roeck-us.net>
References: <20231205031531.426872356@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205031531.426872356@linuxfoundation.org>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2023 at 12:15:35PM +0900, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.66 release.
> There are 107 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 07 Dec 2023 03:14:57 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 157 pass: 146 fail: 11
Failed builds:
	powerpc:defconfig
	powerpc:allmodconfig
	riscv32:defconfig
	riscv32:allmodconfig
	riscv:defconfig
	riscv:allmodconfig
	s390:defconfig
	s390:allmodconfig
	s390:allnoconfig
	s390:tinyconfig
	s390:debug_defconfig
Qemu test results:
	total: 537 pass: 467 fail: 70
Failed tests:
	<most ppc64>
	<all riscv32/riscv64>
	<all s390>

powerpc:

arch/powerpc/platforms/pseries/iommu.c: In function 'find_existing_ddw':
arch/powerpc/platforms/pseries/iommu.c:926:49: error: 'struct dma_win' has no member named 'direct'

riscv:

drivers/perf/riscv_pmu_sbi.c: In function 'pmu_sbi_ovf_handler':
drivers/perf/riscv_pmu_sbi.c:582:40: error: 'riscv_pmu_irq_num' undeclared

s390:

arch/s390/mm/page-states.c: In function 'cmma_init_nodat':
arch/s390/mm/page-states.c:198:30: error: 'invalid_pg_dir' undeclared

Guenter
