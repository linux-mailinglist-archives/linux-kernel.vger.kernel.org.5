Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22C0B7A9F5D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 22:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231723AbjIUUV2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 16:21:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231617AbjIUUUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:20:54 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C24864F90F
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:15:11 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9a6190af24aso153147166b.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695316509; x=1695921309; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sP96J04IzbNW8/aKdG0MvK5uH8GFs3cXDYFHxmwUfag=;
        b=AIp630QKwDK/alc7xQTOMjjCnPkgzIJwq9eB9Sx6WrO+3e0a6rYy2jrUDNdEcBym37
         mUlaTv6KvXPnHJst7rIMgzTs9e2l7+IvxRdGMKyqSpD3aJugBIODcomlvk9nNdDDguA8
         LJ9eCEpDhvHTrv54a+27/vmjWLJzo6x6v3AAxiY1CNMTDQ4kuXV8988Dn/XqBYoqpL9a
         iZ1ftcbVw7lMMhykeDn9Zey3cCU50KlNpmGEmMcB24Ub6lmjg3PWTAiVzfrF715zyZC7
         2tlkOAQAmwvy0XitidH8Du4QKB3Mo15UkcAzHSL8Gq3LY5LPnyP5616P+ECK1tosQWnH
         2tWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695316509; x=1695921309;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sP96J04IzbNW8/aKdG0MvK5uH8GFs3cXDYFHxmwUfag=;
        b=d1YQ6C2DSjvX3GnbKxFcDxT5t9GQZTb5aOWsEjQPTu1RTQMM/dqhdAQTrtx/pbCqTp
         n5EtRQwL34MaP/xGt0ibzhX5UWT5i2lh0A9YH0Vl7eNyrY2sgxqOVFSm5cfIKmb/AXkW
         sa0QpsuRdL1VH77PEOVJouLXR7ee+PXQVn7CHX1FZO1mN7IHlPdYMgC0wPF4ipo3yjg/
         8vS7ycVubQS5BnQcAG6A/8ZFTrMWokuNI1Kr+LsA9DnG+5ngJl0SwMexEHH9gFgSZ2wB
         zeW5o8vB29N4jHduglUR0Q3wUHDOBpVEdYqYDRiGta2198mZ+Izt6DIFpXRns2vanv+y
         qbfg==
X-Gm-Message-State: AOJu0Yzdy04yZa1wVtV+IlGZ5F869LMtFR1Q6ls6WOPgsA7o/rP91PnO
        BLXH8MGcu162VeqJZae1K7f4x3q698YrqJ72taGYFA==
X-Google-Smtp-Source: AGHT+IH4nZ6qomKmkIzyGievhJ1QFes7cUE8bqYM8WY8mDDFvKwHAwtezxXtG2UDZWhTLuO8RmRjcA==
X-Received: by 2002:aa7:c554:0:b0:523:102f:3ce0 with SMTP id s20-20020aa7c554000000b00523102f3ce0mr4836710edr.21.1695306704810;
        Thu, 21 Sep 2023 07:31:44 -0700 (PDT)
Received: from [172.20.34.61] (static-212-193-78-212.thenetworkfactory.nl. [212.78.193.212])
        by smtp.gmail.com with ESMTPSA id n23-20020aa7c697000000b0052ea9ad21bdsm919204edq.72.2023.09.21.07.31.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Sep 2023 07:31:44 -0700 (PDT)
Message-ID: <17989610-d069-40e2-9b4d-7ca6bdf2497e@linaro.org>
Date:   Thu, 21 Sep 2023 15:31:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mtd: micron-st: enable lock/unlock for mt25qu512a
Content-Language: en-US
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
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <084ed945-7674-280f-5866-9238473a294d@leica-geosystems.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Shukla,

Sorry, this email somehow got off my radar.

On 8/22/23 13:16, SHUKLA Mamta Ramendra wrote:
> 
> On 14.07.23 10:15, SHUKLA Mamta Ramendra wrote:
>> Hello Tudor,
>>
>> On 13.07.23 05:43, Tudor Ambarus wrote:
>>> This email is not from Hexagon’s Office 365 instance. Please be careful while clicking links, opening attachments, or replying to this email.
>>>
>>>
>>> On 05.07.2023 18:49, Mamta Shukla wrote:
>>>> mt25qu512a[1] supports locking/unlocking through BP bits in SR.
>>>>
>>>> Tested using mtd-utils- flash_lock/flash_unlock for MT25QU512ABB8E12.
>>>>
>>>> Link: https://media-www.micron.com/-/media/client/global/documents/products/data-sheet/nor-flash/serial-nor/mt25q/die-rev-b/mt25q_qlkt_u_512_abb_0.pdf?rev=b259aadc3bea49ea8210a41c9ad58211
>>>> Signed-off-by: Mamta Shukla <mamta.shukla@leica-geosystems.com>
>>>> ---
>>>>    Changes in v2:
>>>>    - add Link tag
>>>>    - fix chip part number mt25ql512a->mt25qu512a
>>>>
>>>>    drivers/mtd/spi-nor/micron-st.c | 2 ++
>>>>    1 file changed, 2 insertions(+)
>>>>
>>>> diff --git a/drivers/mtd/spi-nor/micron-st.c b/drivers/mtd/spi-nor/micron-st.c
>>>> index 4b919756a205..08e94340ebaa 100644
>>>> --- a/drivers/mtd/spi-nor/micron-st.c
>>>> +++ b/drivers/mtd/spi-nor/micron-st.c
>>>> @@ -229,6 +229,8 @@ static const struct flash_info st_nor_parts[] = {
>>>>                 MFR_FLAGS(USE_FSR)
>>>>         },
>>>>         { "mt25qu512a",  INFO6(0x20bb20, 0x104400, 64 * 1024, 1024)
>>>> +             FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB | SPI_NOR_4BIT_BP |
>>>> +                   SPI_NOR_BP3_SR_BIT6)
>>>>                 NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)
>>>>                 FIXUP_FLAGS(SPI_NOR_4B_OPCODES)
>>>>                 MFR_FLAGS(USE_FSR)
>>>
>>> Can you try the following instead? We try to use SFDP parsing whenever
>>> possible.
>>>           { "mt25qu512a",  INFO6(0x20bb20, 0x104400, 0, 0)
>>>                   FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB | SPI_NOR_4BIT_BP |
>>>                   SPI_NOR_BP3_SR_BIT6)
>>>                   PARSE_SFDP
>>>                   MFR_FLAGS(USE_FSR)
>>
>>
>> I tested with SFDP Parsing Flag. It works fine.
>>
>> ---------------------------------------------------------------------------------
>> [  214.726090] ACPI: Host-directed Dynamic ACPI Table Load:
>> [  214.731482] ACPI: SSDT 0xFFFF892882D89800 0000EC (v02 ALASKA MT25QU
>> 00001000 INTL 20190509)
>> [  214.766082] spi-nor spi-PRP0001:00: mt25qu512a (65536 Kbytes)
>>
>>
>> cat /sys/bus/spi/devices/spi-PRP0001:00/spi-nor/jedec_id
>> 20bb20104400
>>
>> cat /sys/bus/spi/devices/spi-PRP0001:00/spi-nor/manufacturer
>> st
>>
>> cat /sys/bus/spi/devices/spi-PRP0001:00/spi-nor/partname
>> mt25qu512a
>>
>> xxd -p  /sys/bus/spi/devices/spi-PRP0001:00/spi-nor/sfdp
>> 53464450060101ff00060110300000ff84000102800000ffffffffffffff
>> ffffffffffffffffffffffffffffffffffffe520fbffffffff1f29eb276b
>> 273b27bbffffffffffff27bbffff29eb0c2010d80f520000244a99008b8e
>> 03e1ac0127387a757a75fbbdd55c4a0f82ff81bd3d36ffffffffffffffff
>> ffffffffffffffffffe7ffff21dcffff
>>
>> md5sum  /sys/bus/spi/devices/spi-PRP0001:00/spi-nor/sfdp
>> 610efba1647e00ac6db18beb11e84c04
>> /sys/bus/spi/devices/spi-PRP0001:00/spi-nor/sfdp
>>
>> dd if=/dev/urandom of=/tmp/qspi_write  bs=1M count=1
>> 1+0 records in
>> 1+0 records out
>> 1048576 bytes (1.0 MB, 1.0 MiB) copied, 0.0221391 s, 47.4 MB/s
>>
>> mtd_debug write /dev/mtd0 0 1048576 /tmp/qspi_write
>> Copied 1048576 bytes from /tmp/qspi_write to address 0x00000000 in flash
>>
>> mtd_debug erase /dev/mtd0 0 1048576
>> Erased 1048576 bytes from address 0x00000000 in flash
>>
>> mtd_debug read /dev/mtd0 0 1048576 /tmp/qspi_read
>> Copied 1048576 bytes from address 0x00000000 in flash to /tmp/qspi_read
>>
>> hexdump /tmp/qspi_read
>> 0000000 ffff ffff ffff ffff ffff ffff ffff ffff
>> *
>> 0100000
>>
>> mtd_debug write /dev/mtd0 0 1048576 /tmp/qspi_write
>> Copied 1048576 bytes from /tmp/qspi_write to address 0x00000000 in flash
>>
>> mtd_debug read /dev/mtd0 0 1048576 /tmp/qspi_read
>> Copied 1048576 bytes from address 0x00000000 in flash to /tmp/qspi_read
>>
>> sha1sum /tmp/qspi_write  /tmp/qspi_read
>> 4fe4e71b11f44e9672bd49e2e32c0fd94da4feb6  /tmp/qspi_write
>> 4fe4e71b11f44e9672bd49e2e32c0fd94da4feb6  /tmp/qspi_read
>>
>> ----------------------------------------------------------------------------------
>>
>> Shall I write a new commit for PARSE_SFDP Flag or update this commit as-
>> "Modify mt25qu512a Flags" ?
> 
> 
> Ping! Just to follow up on this.
> 

Yeah, please make 2 commits so that we can cleanly revert the switching
to SFDP, if ever needed.

So the first commit will look like:
diff --git a/drivers/mtd/spi-nor/micron-st.c
b/drivers/mtd/spi-nor/micron-st.c
index 4afcfc57c896..a8da1f18e335 100644
--- a/drivers/mtd/spi-nor/micron-st.c
+++ b/drivers/mtd/spi-nor/micron-st.c
@@ -405,9 +405,6 @@ static const struct flash_info st_nor_parts[] = {
        }, {
                .id = SNOR_ID(0x20, 0xbb, 0x20, 0x10, 0x44, 0x00),
                .name = "mt25qu512a",
-               .size = SZ_64M,
-               .no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ |
SPI_NOR_QUAD_READ,
-               .fixup_flags = SPI_NOR_4B_OPCODES,
                .mfr_flags = USE_FSR,
        }, {
                .id = SNOR_ID(0x20, 0xbb, 0x20),

and the second one will add just the BP support, something like:
diff --git a/drivers/mtd/spi-nor/micron-st.c
b/drivers/mtd/spi-nor/micron-st.c
index a8da1f18e335..fdafbfa0f936 100644
--- a/drivers/mtd/spi-nor/micron-st.c
+++ b/drivers/mtd/spi-nor/micron-st.c
@@ -405,6 +405,8 @@ static const struct flash_info st_nor_parts[] = {
        }, {
                .id = SNOR_ID(0x20, 0xbb, 0x20, 0x10, 0x44, 0x00),
                .name = "mt25qu512a",
+               .flags = SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB |
SPI_NOR_4BIT_BP |
+                        SPI_NOR_BP3_SR_BIT6,
                .mfr_flags = USE_FSR,
        }, {
                .id = SNOR_ID(0x20, 0xbb, 0x20),

Of course, I expect you to run again the mtd_debug tests and also verify
the locking. Thanks!

Cheers,
ta

