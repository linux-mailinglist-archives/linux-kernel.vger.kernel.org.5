Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 504EC7AED7E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 14:59:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234784AbjIZM7x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 08:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234749AbjIZM7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 08:59:44 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA5FB121
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 05:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1695733178; x=1727269178;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=gJEq3xCM+MN4CppR6YpkUVhhtT2FeWs1oJ6vU52TkJI=;
  b=0wvVeT3T2B5CVFQNuckgKU4PfAslteJ3gguCi7HSU3QvXRGGafqtf1PO
   qP8DVfTXAY++0OezIPC4799fKNp6m+mBjIKlBEjNf45zJIbuydbqecui5
   uvepF/oUn/3HroHRPih9CAceJnpAMKXDVKJpyn06iIjAjG8rMs7V37V+I
   BnOrXKhXcfXY9C5Vbrxtwtcex8iaf5kpaKtzukkcHNOX9+SPlZeJZmd7W
   K0F9NVMUVMK5Qs4N/tDYtK3DRP7MK+Y/M5qXoj+RI1DmpE+Y5nIKy5EW7
   l3TXm5B1bHIMRpqa2kxwRjaw3Sug/a1VAi1uJJ9vwCZgr2MooiShizPDo
   w==;
X-CSE-ConnectionGUID: ePx/Q2eXSludVcr6gQ8L0Q==
X-CSE-MsgGUID: zzeJAxAeTh++T8AVlpcvXQ==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="6658672"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Sep 2023 05:59:37 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 26 Sep 2023 05:59:29 -0700
Received: from [10.159.245.205] (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.21 via Frontend
 Transport; Tue, 26 Sep 2023 05:59:28 -0700
Message-ID: <925723a2-dc2d-9949-5b8f-4351b49d2f4b@microchip.com>
Date:   Tue, 26 Sep 2023 14:59:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] mtd: spi-nor: atmel: add at25ff321a entry
Content-Language: en-US, fr-FR
To:     Tudor Ambarus <tudor.ambarus@linaro.org>,
        <miquel.raynal@bootlin.com>, <linux-mtd@lists.infradead.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20230908151400.164470-1-nicolas.ferre@microchip.com>
 <8d72820d-bbaa-abc8-4448-87f0f054c381@linaro.org>
 <4c9b0dff-6350-376b-60ac-c36f98378a51@microchip.com>
 <306a6aa0-c608-418a-a591-6f8aa95817fb@linaro.org>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <306a6aa0-c608-418a-a591-6f8aa95817fb@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/09/2023 at 09:14, Tudor Ambarus wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
> On 9/20/23 17:16, Nicolas Ferre wrote:
>> On 19/09/2023 at 18:12, Tudor Ambarus wrote:
>>> On 08.09.2023 18:14, nicolas.ferre@microchip.com wrote:
>>>> From: Nicolas Ferre <nicolas.ferre@microchip.com>
>>>>
>>>> Add the at25ff321a 4MB SPI flash which is able to provide
>>>> SFDP informations.
>>>> Datasheet:
>>>> https://www.renesas.com/us/en/document/dst/at25ff321a-datasheet
>>>>
>>>> Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
>>>> ---
>>
>> [..]
>>
>>>>    drivers/mtd/spi-nor/atmel.c | 4 ++++
>>>>    1 file changed, 4 insertions(+)
>>>>
>>>> diff --git a/drivers/mtd/spi-nor/atmel.c b/drivers/mtd/spi-nor/atmel.c
>>>> index 58968c1e7d2f..c94d52951481 100644
>>>> --- a/drivers/mtd/spi-nor/atmel.c
>>>> +++ b/drivers/mtd/spi-nor/atmel.c
>>>> @@ -184,6 +184,10 @@ static const struct flash_info atmel_nor_parts[]
>>>> = {
>>>>                 FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_SWP_IS_VOLATILE)
>>>>                 NO_SFDP_FLAGS(SECT_4K)
>>>>                 .fixups = &atmel_nor_global_protection_fixups },
>>>> +     { "at25ff321a", INFO(0x1f4708, 0, 64 * 1024,  64)
>>>> +             FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_SWP_IS_VOLATILE)
>>>> +             PARSE_SFDP
>>>> +             .fixups = &atmel_nor_global_protection_fixups },
>>>
>>> We have recently changed how the flash entries are defined. Would you
>>> please try the following changes instead?
>>>
>>> diff --git a/drivers/mtd/spi-nor/atmel.c b/drivers/mtd/spi-nor/atmel.c
>>> index 95f0e139284e..44218716d81e 100644
>>> --- a/drivers/mtd/spi-nor/atmel.c
>>> +++ b/drivers/mtd/spi-nor/atmel.c
>>> @@ -213,6 +213,12 @@ static const struct flash_info atmel_nor_parts[] = {
>>>                   .flags = SPI_NOR_HAS_LOCK | SPI_NOR_SWP_IS_VOLATILE,
>>>                   .no_sfdp_flags = SECT_4K,
>>>                   .fixups = &atmel_nor_global_protection_fixups
>>> +       }, {
>>> +               .id = SNOR_ID(0x1f, 0x47, 0x08),
>>> +               .name = "at25ff321a",
>>> +               .flags = SPI_NOR_HAS_LOCK | SPI_NOR_SWP_IS_VOLATILE,
>>
>> Here, I added:
>>
>>                 .no_sfdp_flags = SECT_4K,
>>
>> to match the other devices of the family... I checked on the datasheet,
>> 4K sectors are okay, but I don't know exactly if this is eligible to the
>> "no_sfdb_flags" property... forgive me, I didn't check further knowing
>> that you might have better view on this than me ;-)
> 
> yeah, no worries. You should not specify 4k here, as it should already
> be set when parsing SFDP. You can use mtdinfo /dev/mtdx to check what
> erase size gets set. In the core we set the maximum supported erase size
> for speed considerations and making ubifs happy, so you'll probably see
> 64k when checking with mtdinfo. But you can try 4k erases as well by
> setting MTD_SPI_NOR_USE_4K_SECTORS.

Absolutely, here is what I'm experiencing:
# no_sfdp_flags not set / linux-next / sama5d27 wlsom1 ek
# CONFIG_MTD_SPI_NOR_USE_4K_SECTORS=y
root@sama5d27-wlsom1-ek-sd:~# mtdinfo /dev/mtd0
mtd0
Name:                           spi0.1
Type:                           nor
Eraseblock size:                4096 bytes, 4.0 KiB
Amount of eraseblocks:          1024 (4194304 bytes, 4.0 MiB)
Minimum input/output unit size: 1 byte
Sub-page size:                  1 byte
Character device major/minor:   90:0
Bad blocks are allowed:         false
Device is writable:             true

# no_sfdp_flags not set / linux-next / sama5d27 wlsom1 ek
# # CONFIG_MTD_SPI_NOR_USE_4K_SECTORS is not set
root@sama5d27-wlsom1-ek-sd:~# mtdinfo /dev/mtd0
mtd0
Name:                           spi0.1
Type:                           nor
Eraseblock size:                65536 bytes, 64.0 KiB
Amount of eraseblocks:          64 (4194304 bytes, 4.0 MiB)
Minimum input/output unit size: 1 byte
Sub-page size:                  1 byte
Character device major/minor:   90:0
Bad blocks are allowed:         false
Device is writable:             true

>>> +               .fixups = &atmel_nor_global_protection_fixups
>>> +       }, {
>>>           }, {
>>>                   .id = SNOR_ID(0x1f, 0x48, 0x00),
>>>                   .name = "at25df641",
>>
>> That works perfectly well (I can re-post the test results as my previous
>> patch if needed): do you want me to send the updated patch with your
>> Suggested-by tag or you can send yours, tell me what you prefer.
> 
> Send a new patch please, it was just a suggestion to speed the things up.

Sure, I'm on it ;-)

>> Thanks for the heads-up on this update that I hadn't noticed. Best regards,
>>    Nicolas
>>
> you're welcome! Cheers!

Best regards,
  Nicolas

