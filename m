Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 345C17898F6
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 22:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbjHZUPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 16:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjHZUPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 16:15:33 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC7021AD
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 13:15:30 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-5007c8308c3so3125949e87.0
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 13:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693080929; x=1693685729;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fiClfjB25JQP+nvwhV5eVxfGres78QLziYRocpk7hNg=;
        b=r4mXYBsZgZu4XhHaE9QWRSqYR7q8IE+oEin5qfpD6Sf/J3TWFuEa/ViTN1VsdtHFzl
         aKOkLvPFGeuvP5g3fDazkDDX+isg9uywLXAzGIsjSVVgG717OlvIOWcYVzJ8W5UzR0cz
         yta2QTDhx1KDOLnw1YGXBvC9JxCouGvN3GEiOZDEqxf3Qza6F8SP5VrpfgVncP7QOUuw
         g64oR9ZWg4Y4xmzKeRPw9Opc4pYsfjCuhVSVoqTUjvHvqTb6cmmZBeJ4To1STVuFE6TW
         KZsjz9kdI9fJyWtRIDeX73jR8EATlD4knXtFGgqiKQ4LWVySfrOrTLGKt+qwO5HXCEZN
         E6JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693080929; x=1693685729;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fiClfjB25JQP+nvwhV5eVxfGres78QLziYRocpk7hNg=;
        b=cVUs+LUi7/ODyM0Jy47hQ6G+z2tcOIWtezZtgY8cJH6F1orUtMX4U7L6Le897e2mCW
         BMR/ZDyjDrQQEZsP7ZtyTGsGm9hGTuF9XnMu4K2b9VzHN/S8S5u9dGhAmnWHWQSOWMyF
         aS7RpcDLnjGh5VkoutNzAfH8Xk+pHLGkKhhWEwIS1F+SbIegF9vrSzUpioxBXSl04w0y
         t2wZuxOSvJMM9Gr4k6AwA1HkuDCdh1f0ETddwUUaYv5VE7cLylppHYMXu19Yiu5UFxuF
         zHZ1+mYpALfRJG989uDF/x5AP5Xp6p8kisAt7sENrQV5WaEBSxfpMPWNAYyl7aTfBx/V
         +6RA==
X-Gm-Message-State: AOJu0YwqdYNtRQqqUGAvwq2uK1anZ10YTIKaE1S3tSremOl0ol6P5V0x
        o47/74hFGBCVFDKQxI9WLxA=
X-Google-Smtp-Source: AGHT+IGqrFqmGE4oHqPCMDDR68XZhC2DGYJX9mBLn9ove4qTNG59NMxLTApREuKbJviG3CqQrT9bGg==
X-Received: by 2002:a05:6512:114d:b0:4f8:67f0:7253 with SMTP id m13-20020a056512114d00b004f867f07253mr21782588lfg.49.1693080928758;
        Sat, 26 Aug 2023 13:15:28 -0700 (PDT)
Received: from [192.168.26.149] (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.googlemail.com with ESMTPSA id j13-20020ac253ad000000b004fe119b0105sm825811lfh.272.2023.08.26.13.15.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Aug 2023 13:15:28 -0700 (PDT)
Message-ID: <ba3c419a-6511-480a-b5f2-6c418f9c02e7@gmail.com>
Date:   Sat, 26 Aug 2023 22:15:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "nvmem: add new config option"
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Alban Bedel <albeu@free.fr>,
        Christian Marangi <ansuelsmth@gmail.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20230718084804.20139-1-zajec5@gmail.com>
Content-Language: en-US
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
In-Reply-To: <20230718084804.20139-1-zajec5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Srini,

On 18.07.2023 10:48, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> This reverts commit 517f14d9cf3533d5ab4fded195ab6f80a92e378f.
> 
> It seems that "no_of_node" config option was added to help mtd's case.
> 
> DT nodes of MTD partitions (that are also NVMEM devices) may contain
> subnodes that SHOULD NOT be treated as NVMEM fixed cells. To prevent
> NVMEM core code from parsing them "no_of_node" was set to true and that
> made for_each_child_of_node() in NVMEM a no-op.
> 
> With the introduction of "add_legacy_fixed_of_cells" config option
> things got more explicit. MTD subsystem simply tells NVMEM when to look
> for fixed cells and there is no need to hack "of_node" pointer anymore.
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---
> Important: this is based on top of the
> [PATCH V4] nvmem: add explicit config option to read old syntax fixed OF cells

I see you skipped those two patches for 6.6.

Can you queue them for 6.7, please?


> ---
>   drivers/mtd/mtdcore.c          | 1 -
>   drivers/nvmem/core.c           | 2 +-
>   include/linux/nvmem-provider.h | 2 --
>   3 files changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
> index 9db8d7853639..3d781ffb8c32 100644
> --- a/drivers/mtd/mtdcore.c
> +++ b/drivers/mtd/mtdcore.c
> @@ -554,7 +554,6 @@ static int mtd_nvmem_add(struct mtd_info *mtd)
>   	config.read_only = true;
>   	config.root_only = true;
>   	config.ignore_wp = true;
> -	config.no_of_node = !of_device_is_compatible(node, "nvmem-cells");
>   	config.priv = mtd;
>   
>   	mtd->nvmem = nvmem_register(&config);
> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> index 58d8919e6682..a0c9153cda28 100644
> --- a/drivers/nvmem/core.c
> +++ b/drivers/nvmem/core.c
> @@ -1027,7 +1027,7 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
>   	nvmem->nkeepout = config->nkeepout;
>   	if (config->of_node)
>   		nvmem->dev.of_node = config->of_node;
> -	else if (!config->no_of_node)
> +	else
>   		nvmem->dev.of_node = config->dev->of_node;
>   
>   	switch (config->id) {
> diff --git a/include/linux/nvmem-provider.h b/include/linux/nvmem-provider.h
> index 1b81adebdb8b..e3930835235b 100644
> --- a/include/linux/nvmem-provider.h
> +++ b/include/linux/nvmem-provider.h
> @@ -89,7 +89,6 @@ struct nvmem_cell_info {
>    * @read_only:	Device is read-only.
>    * @root_only:	Device is accessibly to root only.
>    * @of_node:	If given, this will be used instead of the parent's of_node.
> - * @no_of_node:	Device should not use the parent's of_node even if it's !NULL.
>    * @reg_read:	Callback to read data.
>    * @reg_write:	Callback to write data.
>    * @size:	Device size.
> @@ -122,7 +121,6 @@ struct nvmem_config {
>   	bool			ignore_wp;
>   	struct nvmem_layout	*layout;
>   	struct device_node	*of_node;
> -	bool			no_of_node;
>   	nvmem_reg_read_t	reg_read;
>   	nvmem_reg_write_t	reg_write;
>   	int	size;

