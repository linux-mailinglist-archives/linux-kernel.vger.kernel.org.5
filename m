Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1514F7BB921
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 15:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232426AbjJFNdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 09:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232349AbjJFNdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 09:33:21 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CB7DBB
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 06:33:20 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9b27bc8b65eso365891966b.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 06:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696599198; x=1697203998; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qLF3FmUojqF6i31/VFtA/YxgmVJsIVWsss0oZC+5hPk=;
        b=flsaN+G1a9PjHs4S4W9XHACV55W39puUtNuQuarATRVi0JJiA+W3miXMPZ+Tn+KMkZ
         2PFx3WX7oGWfaohq2tUgVXqG/d0ZL8pE2bUdWOORJ7D9y8tNWB4emclVIZJnHnk4piLk
         m9GbHEUwsa8jatmney468/HRkoizeZpnsH9RiyQV18FxTncyjIYLA8vtNtdqAe/CjcdD
         CV+tGskUXkSNrEb0V5lLVoxnmzm72RxPLQl+pnwk2r6feBYLaYov7v/o2LiT/UPmprcL
         8a6quGRqxXNtTt76cNM+0DgMA6gJ+97O8BkB07417jCFDCsN/N6joI3dsStNY9sHsGWT
         u/7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696599198; x=1697203998;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qLF3FmUojqF6i31/VFtA/YxgmVJsIVWsss0oZC+5hPk=;
        b=d6U97GLod24dGkU6wUAsE4n7etpDKKedfO+cubcAR4QldrqUD9V+BvhNrQLra61++D
         ylPXbVG5EwoX2Ao95wpxt1nQq+r6up+8WoDe8TtKxetM5JVyuemTzmNYDkJkwR6NYwtb
         8Mg36ZhQQJDCLay/qqCG6iF9NiLQHpy4v7i9ZRYSANbpTN963sONFRm9mpgldaZl5HJ7
         E4SYMY6ivyc+s6Abk3/fJJijuUK0Ep9kRm73ivTwo0bZ1jPoB1ZXChu3gvrXPggyOG9x
         7ZqYVL/u9mZpTPYfpVIzsxFnb1envCtLqhp15tS1VCCnmL1/ss+TwLtk28mlSo1uPv0K
         veOg==
X-Gm-Message-State: AOJu0YyPx0tWH7dbHYqB4X/4HaUh74kyCjMo66Ce2jvmD5Gwc5kIXTLK
        OyGJdp+/oxomg+EUYztDnSOtKg==
X-Google-Smtp-Source: AGHT+IFbCF1v/pXs8yumng1U8WEpOC/dqt2bLSWBiJ0XZz0OdoS9TN6528aICAm1oaMwtWOr1bt+vw==
X-Received: by 2002:a17:907:c241:b0:9a1:6318:4d39 with SMTP id tj1-20020a170907c24100b009a163184d39mr6842293ejc.29.1696599198565;
        Fri, 06 Oct 2023 06:33:18 -0700 (PDT)
Received: from [192.168.2.107] ([79.115.63.123])
        by smtp.gmail.com with ESMTPSA id i11-20020a170906a28b00b009737b8d47b6sm2858073ejz.203.2023.10.06.06.33.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Oct 2023 06:33:17 -0700 (PDT)
Message-ID: <f0a7acb3-00b5-433d-af5c-724a509fb816@linaro.org>
Date:   Fri, 6 Oct 2023 14:33:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mtd: micron-st: enable lock/unlock for mt25qu512a
To:     SHUKLA Mamta Ramendra <mamta.shukla@leica-geosystems.com>,
        "pratyush@kernel.org" <pratyush@kernel.org>,
        "michael@walle.cc" <michael@walle.cc>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "richard@nod.at" <richard@nod.at>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     GEO-CHHER-bsp-development 
        <bsp-development.geo@leica-geosystems.com>
References: <20230705154942.3936658-1-mamta.shukla@leica-geosystems.com>
 <19800e51-a871-be9f-9eb5-5829237e2613@linaro.org>
 <a8271289-0611-4e37-cf37-0be19a85656b@leica-geosystems.com>
 <084ed945-7674-280f-5866-9238473a294d@leica-geosystems.com>
 <17989610-d069-40e2-9b4d-7ca6bdf2497e@linaro.org>
 <a24d7b3b-4077-9dbe-49ae-96f595b42223@leica-geosystems.com>
 <2d7271b3-dd60-44bb-9700-f6a5295ea873@linaro.org>
 <372046cb-9135-9a6c-fdb7-307a42f55b30@leica-geosystems.com>
 <a86b93c4-a507-47c7-bdce-4aed8dfcf929@linaro.org>
 <eb2a9138-a76e-4b1e-e001-315149c4dabd@leica-geosystems.com>
Content-Language: en-US
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <eb2a9138-a76e-4b1e-e001-315149c4dabd@leica-geosystems.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Thanks for the debugging info.

On 10/6/23 11:30, SHUKLA Mamta Ramendra wrote:

cut

> --------------------------------------------------------
> 
> IMO, HAS_16BIT_SR flag is causing lock/unlock failure,
> since BP bits are calculated wrong then.
> 
> I tested also for a case where I don't parse SFDP and
> reverted the condition in  micron_st_nor_default_init()
> for 16BIT Status Register Flag. And lock/unlock fails with
> same log as Non-working case.
> 
> And this mt25qu512 has 8-BIT SR as typical micron-st flash.
> 

Indeed, the problem is that HAS_16BIT_SR gets set when it shouldn't have
to. This means that the BFPT table of the flash is wrong and we should
fix the parsed settings via a post_bfpt hook.

Does the following fix your problem?

diff --git a/drivers/mtd/spi-nor/micron-st.c
b/drivers/mtd/spi-nor/micron-st.c
index 4afcfc57c896..733bbddc6829 100644
--- a/drivers/mtd/spi-nor/micron-st.c
+++ b/drivers/mtd/spi-nor/micron-st.c
@@ -180,6 +180,17 @@ static const struct flash_info micron_nor_parts[] = {
        },
 };

+static int mt25qu512a_post_bfpt_fixup(struct spi_nor *nor,
+                               const struct sfdp_parameter_header
*bfpt_header,
+                               const struct sfdp_bfpt *bfpt)
+{
+       nor->flags &= ~SNOR_F_HAS_16BIT_SR;
+}
+
+static struct spi_nor_fixups mt25qu512a_fixups = {
+       .post_bfpt = mt25qu512a_post_bfpt_fixup,
+}
+
 static const struct flash_info st_nor_parts[] = {
        {
                .name = "m25p05-nonjedec",
@@ -405,10 +416,10 @@ static const struct flash_info st_nor_parts[] = {
        }, {
                .id = SNOR_ID(0x20, 0xbb, 0x20, 0x10, 0x44, 0x00),
                .name = "mt25qu512a",
-               .size = SZ_64M,
-               .no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ |
SPI_NOR_QUAD_READ,
-               .fixup_flags = SPI_NOR_4B_OPCODES,
+               .flags = SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB |
SPI_NOR_4BIT_BP |
+                        SPI_NOR_BP3_SR_BIT6,
                .mfr_flags = USE_FSR,
+               .fixups = &mt25qu512a_fixups,
        }, {
                .id = SNOR_ID(0x20, 0xbb, 0x20),
                .name = "n25q512a",


If yes, please add some prints in sfdp.c to determine where it's set,
either in BFPT_DWORD15_QER_SR2_BIT1 or BFPT_DWORD15_QER_SR2_BIT1_NO_RD

Is the datasheet for this flash public? Would you send me a link to it
please?

Cheers,
ta
