Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3667BB9BD
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 15:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232593AbjJFNsV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 09:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232609AbjJFNsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 09:48:05 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA647D6D
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 06:46:55 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-99bdcade7fbso377661366b.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 06:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696600014; x=1697204814; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4Kbdufx+AHXJ7bO+V5r5LajhsEMCAIPjaRpknMjUD+4=;
        b=tKtfW6F7BoL+r/nNs/tQ5QZoB1nKnth+/6UzJglFob9m2Yb9x4aEK2HtKhrvxcff9k
         pdlBnFMrTgqyXMIdqBxUP60gLFwZYdf8EeX7Xy5Ki7OL9V+JssL14W0n0JZJzVHl8r6p
         A6Y95KZA1rlbDsOmZb9xV0qvzrGJho+mrTRcwF/ExmrXkqUfESTVUB/1sK6Ttyfhbaez
         XneQoH2UwW3BDYfTnAvI0UUEsF8k/Rt/xhnS+ZjtrL4CxgkwNJguWJ68YwXA1jBw/RkK
         yzTgJFt5lcuDHYoxPxkfpob432J9giCfL5z27pXXM87n7pGSSW7Caad7forHVWWhrx1x
         DTrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696600014; x=1697204814;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4Kbdufx+AHXJ7bO+V5r5LajhsEMCAIPjaRpknMjUD+4=;
        b=K1I5NS026z8nA/4xKBiOfuVtfVIpjckhN1198MSdcayAeYH8v75i45ANp8KFJZVYsN
         jat7UdZ6VEjGprgwlhKyp53Inv/YFNJBq/g0c92dbPtMkp6vZF6JDyKsPjUI6alUrSrv
         UrTipTpd3c+wwdBjivzTmJzJUtbCFBrgiBMg5ncXXLR+XAm1Kc04tAXIm0kROxPcT59w
         EPA9EXbqv53vLdyFL0hL+6MsqMjOzY2XuVWpjXePMR5by1cidhcw/RQU/p/5CLk1VmyH
         jzsH0+BqYC7mBVXaFMJvU7mHQbo/VVE1LLEdVleCneU8IJSzkLew9Q1Z//jJvjE7CoC2
         uEJQ==
X-Gm-Message-State: AOJu0YzhTfwcRvYYmw8WrexkWrDYVo6y1vHwo3J7mAJthQhBgoc+qpsx
        1h7tS9kWgYl7ohFg8ruz35iZww==
X-Google-Smtp-Source: AGHT+IE0IHER02baeg64vD4NFKJGKKk9/C4zdTpjhZWXo8zy8VFiw5MCCPLhmr4wFqK6avJ7wDBI5Q==
X-Received: by 2002:a17:906:301a:b0:9a5:b814:8254 with SMTP id 26-20020a170906301a00b009a5b8148254mr7494241ejz.24.1696600013816;
        Fri, 06 Oct 2023 06:46:53 -0700 (PDT)
Received: from [192.168.2.107] ([79.115.63.123])
        by smtp.gmail.com with ESMTPSA id x26-20020a170906711a00b0099329b3ab67sm2918398ejj.71.2023.10.06.06.46.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Oct 2023 06:46:53 -0700 (PDT)
Message-ID: <bc76767e-00c1-47ca-9a27-2aa7d2a262f6@linaro.org>
Date:   Fri, 6 Oct 2023 14:46:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mtd: micron-st: enable lock/unlock for mt25qu512a
Content-Language: en-US
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
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
 <f0a7acb3-00b5-433d-af5c-724a509fb816@linaro.org>
In-Reply-To: <f0a7acb3-00b5-433d-af5c-724a509fb816@linaro.org>
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



On 10/6/23 14:33, Tudor Ambarus wrote:
> 
> Hi,
> 
> Thanks for the debugging info.
> 
> On 10/6/23 11:30, SHUKLA Mamta Ramendra wrote:
> 
> cut
> 
>> --------------------------------------------------------
>>
>> IMO, HAS_16BIT_SR flag is causing lock/unlock failure,
>> since BP bits are calculated wrong then.
>>
>> I tested also for a case where I don't parse SFDP and
>> reverted the condition in  micron_st_nor_default_init()
>> for 16BIT Status Register Flag. And lock/unlock fails with
>> same log as Non-working case.
>>
>> And this mt25qu512 has 8-BIT SR as typical micron-st flash.
>>
> 
> Indeed, the problem is that HAS_16BIT_SR gets set when it shouldn't have
> to. This means that the BFPT table of the flash is wrong and we should
> fix the parsed settings via a post_bfpt hook.
> 
> Does the following fix your problem?
> 

here it is again, this time compile tested:

diff --git a/drivers/mtd/spi-nor/micron-st.c
b/drivers/mtd/spi-nor/micron-st.c
index 4afcfc57c896..20f76e278095 100644
--- a/drivers/mtd/spi-nor/micron-st.c
+++ b/drivers/mtd/spi-nor/micron-st.c
@@ -180,6 +180,18 @@ static const struct flash_info micron_nor_parts[] = {
        },
 };

+static int mt25qu512a_post_bfpt_fixup(struct spi_nor *nor,
+                               const struct sfdp_parameter_header
*bfpt_header,
+                               const struct sfdp_bfpt *bfpt)
+{
+       nor->flags &= ~SNOR_F_HAS_16BIT_SR;
+       return 0;
+}
+
+static struct spi_nor_fixups mt25qu512a_fixups = {
+       .post_bfpt = mt25qu512a_post_bfpt_fixup,
+};
+
 static const struct flash_info st_nor_parts[] = {
        {
                .name = "m25p05-nonjedec",
@@ -405,10 +417,10 @@ static const struct flash_info st_nor_parts[] = {
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

cut

> If yes, please add some prints in sfdp.c to determine where it's set,
> either in BFPT_DWORD15_QER_SR2_BIT1 or BFPT_DWORD15_QER_SR2_BIT1_NO_RD
> 
> Is the datasheet for this flash public? Would you send me a link to it
> please?
> 
> Cheers,
> ta
