Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 765B5786918
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 09:56:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239010AbjHXH4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 03:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240359AbjHXH4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 03:56:07 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFCDE172A
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 00:56:02 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2bcde83ce9fso19725431fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 00:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692863761; x=1693468561;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JQ5a+a+DLZL8fu5vhZ5y8OBXDunDyHqp9ifQiH1QL7M=;
        b=UXVnHFfpZFq1LJb4ZWf/G2cEwHw+fJVt2zhM9hthVbvLSfgNUnFRRKuzQbqHWqTZUt
         zyZV06LRm9mSepyh2x4tcee3gcX5iSEPUzds0KZQ88tqlul76wcAPl/njtcmG1PTIewf
         jQv/7eiFCVnH9/1Y/ZaExN3P3UGKOonjHBuRzkvV7cChbTrwNv3ZLq5m+d42h+eEM7Su
         02spk8Fiw2aapuArfNPP0VzmuLyhY5aWfuirgv7kIMws9nbzIlMv2Q6BdaPdB5nFmWse
         6IOSTLxytvNT/ypw1wd0KJScxYpCn52VcoABWf/izxOnqkyMBlTj0yUEkaR/8L+P4ysF
         XVnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692863761; x=1693468561;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JQ5a+a+DLZL8fu5vhZ5y8OBXDunDyHqp9ifQiH1QL7M=;
        b=Ak8LNIe5n8RfdKeT61hUFjtZbJfWCM8/c+8FuACxi/pYeTWirPGI3LwP2ENLH15goY
         UW9jyjZYb81W4T80Xdbe5UOQw/Bfc5JB6rP+T3hMNip/utGZK0WOOY/ra/CzEMKgB5bl
         i+RVtDYUnoxJ10s1q25t7kpPmgbW6e7S5AsR7wEnt1X43bnRdiZJRyQUvNF5E6aAz7fP
         VeELXORBJRIU6pCTGe00ELTGOZCePzDh5M21IjcXSNDKxCAe55dckV0Px7ISyKGfZERM
         rsr75BHw6gClPTofPvRsa6nJXHeJja3PPd6XuTTrAaUzzfwEzpqT5TDLSCevHqy9jgXt
         EJYQ==
X-Gm-Message-State: AOJu0Yzr87fi/4ea6xn3bbLyDhvKa5S+EQ/dxY+Qqm9UigFTQbCfKmPx
        eY7ZhsY1CuljeeWvRtLwJQHif5LI9sxrvv74m7w=
X-Google-Smtp-Source: AGHT+IGC3XPafzP8NSdZ/hKJK7JbKy8UmB1lqAkMbRmd7SW14rIMO8s8arGdy0cESCpEpD7z2iRdQQ==
X-Received: by 2002:a2e:9185:0:b0:2bc:bb46:4fc7 with SMTP id f5-20020a2e9185000000b002bcbb464fc7mr8746839ljg.24.1692863760980;
        Thu, 24 Aug 2023 00:56:00 -0700 (PDT)
Received: from [192.168.2.107] ([79.115.63.239])
        by smtp.gmail.com with ESMTPSA id y11-20020a05600c364b00b003fe2a40d287sm1837211wmq.1.2023.08.24.00.55.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Aug 2023 00:56:00 -0700 (PDT)
Message-ID: <ea44da10-c9bd-22ba-576b-109670e3a63e@linaro.org>
Date:   Thu, 24 Aug 2023 08:55:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH v2 01/41] mtd: spi-nor: remove catalyst 'flashes'
Content-Language: en-US
To:     Michael Walle <mwalle@kernel.org>,
        Pratyush Yadav <pratyush@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
References: <20230807-mtd-flash-info-db-rework-v2-0-291a0f39f8d8@kernel.org>
 <20230807-mtd-flash-info-db-rework-v2-1-291a0f39f8d8@kernel.org>
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20230807-mtd-flash-info-db-rework-v2-1-291a0f39f8d8@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/22/23 08:09, Michael Walle wrote:
> CAT25xx are actually EEPROMs manufactured by Catalyst. The devices are
> ancient (DS are from 1998), there are not in-tree users, nor are there
> any device tree bindings. Remove it. The correct driver is the at25.
> 
> Signed-off-by: Michael Walle <mwalle@kernel.org>

Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>

> ---
>  drivers/mtd/spi-nor/Makefile   |  1 -
>  drivers/mtd/spi-nor/catalyst.c | 24 ------------------------
>  drivers/mtd/spi-nor/core.c     |  1 -
>  drivers/mtd/spi-nor/core.h     |  1 -
>  4 files changed, 27 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/Makefile b/drivers/mtd/spi-nor/Makefile
> index e347b435a038..496dae9ca0f3 100644
> --- a/drivers/mtd/spi-nor/Makefile
> +++ b/drivers/mtd/spi-nor/Makefile
> @@ -2,7 +2,6 @@
>  
>  spi-nor-objs			:= core.o sfdp.o swp.o otp.o sysfs.o
>  spi-nor-objs			+= atmel.o
> -spi-nor-objs			+= catalyst.o
>  spi-nor-objs			+= eon.o
>  spi-nor-objs			+= esmt.o
>  spi-nor-objs			+= everspin.o
> diff --git a/drivers/mtd/spi-nor/catalyst.c b/drivers/mtd/spi-nor/catalyst.c
> deleted file mode 100644
> index 6d310815fb12..000000000000
> --- a/drivers/mtd/spi-nor/catalyst.c
> +++ /dev/null
> @@ -1,24 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - * Copyright (C) 2005, Intec Automation Inc.
> - * Copyright (C) 2014, Freescale Semiconductor, Inc.
> - */
> -
> -#include <linux/mtd/spi-nor.h>
> -
> -#include "core.h"
> -
> -static const struct flash_info catalyst_nor_parts[] = {
> -	/* Catalyst / On Semiconductor -- non-JEDEC */
> -	{ "cat25c11", CAT25_INFO(16, 8, 16, 1) },
> -	{ "cat25c03", CAT25_INFO(32, 8, 16, 2) },
> -	{ "cat25c09", CAT25_INFO(128, 8, 32, 2) },
> -	{ "cat25c17", CAT25_INFO(256, 8, 32, 2) },
> -	{ "cat25128", CAT25_INFO(2048, 8, 64, 2) },
> -};
> -
> -const struct spi_nor_manufacturer spi_nor_catalyst = {
> -	.name = "catalyst",
> -	.parts = catalyst_nor_parts,
> -	.nparts = ARRAY_SIZE(catalyst_nor_parts),
> -};
> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> index 1b0c6770c14e..c44de69c4353 100644
> --- a/drivers/mtd/spi-nor/core.c
> +++ b/drivers/mtd/spi-nor/core.c
> @@ -1999,7 +1999,6 @@ int spi_nor_sr2_bit7_quad_enable(struct spi_nor *nor)
>  
>  static const struct spi_nor_manufacturer *manufacturers[] = {
>  	&spi_nor_atmel,
> -	&spi_nor_catalyst,
>  	&spi_nor_eon,
>  	&spi_nor_esmt,
>  	&spi_nor_everspin,
> diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
> index 9217379b9cfe..6d31af6c39ed 100644
> --- a/drivers/mtd/spi-nor/core.h
> +++ b/drivers/mtd/spi-nor/core.h
> @@ -631,7 +631,6 @@ struct sfdp {
>  
>  /* Manufacturer drivers. */
>  extern const struct spi_nor_manufacturer spi_nor_atmel;
> -extern const struct spi_nor_manufacturer spi_nor_catalyst;
>  extern const struct spi_nor_manufacturer spi_nor_eon;
>  extern const struct spi_nor_manufacturer spi_nor_esmt;
>  extern const struct spi_nor_manufacturer spi_nor_everspin;
> 
