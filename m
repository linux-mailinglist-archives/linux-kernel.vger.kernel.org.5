Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87B837F7868
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 16:57:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345881AbjKXP5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 10:57:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbjKXP5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 10:57:01 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 204CF1998
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 07:57:08 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-a00cbb83c80so299089366b.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 07:57:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700841426; x=1701446226; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZF6yae9bb5tDXC/CsnvGYPJ3X5s4815eVzyjB3BR8k8=;
        b=RVexKku5lciK7stmLKBVUIcyJ/EvkeoI2yvaHDdoUJrWwmzZNdDDN5uHDs+3VnMFUK
         zBUlvNmOZOoTfvEw+F9bI1F8MF3DxAz2eOJA6VwSbWpuICdjALsTbyICPaU7UwlIURCf
         ChQzkJLMRnAxm9d0WchcYDH0Ia6xuNTPitggNAZOMsMgPRiyHfuhkPN+NoVnM7QRJs7+
         bGEWyF+a7F6rWjqJGakN6yenzs3RhUv3GglOen0c+tNpbybGHhAhcQfoeuN00yVLEb1r
         WWAOiFUtnooVlUJMLZ/1BCCh6HlOhZG+NYmwEE6TXvVPiYo3hW+3KB6Ud8MzPPj4SKIL
         5RMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700841426; x=1701446226;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZF6yae9bb5tDXC/CsnvGYPJ3X5s4815eVzyjB3BR8k8=;
        b=XM+wKcAcik6y+9VDSifMpIl9BFc5ZNk9/C/M4DRVoGH8SvIv1n/7tjKt40O6reW2vO
         MxA7MVWdlE/HFieDUCsXUx2Tz4rxChSKj2m5WPG/W6d2+68tR3gWg4dJh64nZ5mRUMrl
         yOr1ZPzhujVwH1ilJq9UVmDUXJbpdKwd3EiKxke6s7KRlocKmmdHDv6edCK58W+lK3PQ
         PoQtwf6SPtC6CVKtWAvKMehLvaCip58UbI17T5ZBI6snSB8TsnULyuUobsW1uMEOL424
         DaSzGgBIMdVbO2/jaRCvFEFMq5EKIJGY9A0YMLWS8umhXVBNkpNtz5tsL2HXPkOTuAqO
         K3hQ==
X-Gm-Message-State: AOJu0YzmxPVITpUM9T+73BUkAM1NqMRBSVvgwGUMyiBuiclwBnHfjQJy
        V1Ptz8e1Bhg0CDPuFooQe7Efsw==
X-Google-Smtp-Source: AGHT+IFEf8Zmz3QMkGFpwb/grFbBwT9wDbpNPDHQrgCCp5UTdMYETULTAfdNeVMu4HrvKK4xKSxTEg==
X-Received: by 2002:a17:907:740a:b0:9e5:d618:d6c1 with SMTP id gj10-20020a170907740a00b009e5d618d6c1mr2310550ejc.19.1700841426518;
        Fri, 24 Nov 2023 07:57:06 -0800 (PST)
Received: from [192.168.2.107] ([79.115.63.75])
        by smtp.gmail.com with ESMTPSA id jj13-20020a170907984d00b009b65a834dd6sm2195878ejc.215.2023.11.24.07.57.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Nov 2023 07:57:06 -0800 (PST)
Message-ID: <42cc0ae2-d61a-41cc-b46e-132dace301b0@linaro.org>
Date:   Fri, 24 Nov 2023 15:57:04 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] docs: mtd: spi-nor: add sections about flash
 additions and testing
Content-Language: en-US
To:     Pratyush Yadav <pratyush@kernel.org>
Cc:     michael@walle.cc, linux-mtd@lists.infradead.org,
        linux-doc@vger.kernel.org, corbet@lwn.net,
        linux-kernel@vger.kernel.org
References: <20231123160721.64561-1-tudor.ambarus@linaro.org>
 <20231123160721.64561-2-tudor.ambarus@linaro.org>
 <mafs0sf4vdxqd.fsf@kernel.org>
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <mafs0sf4vdxqd.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/24/23 14:36, Pratyush Yadav wrote:
> Hi,
> 
> 
> On Thu, Nov 23 2023, Tudor Ambarus wrote:
> 
>> Add sections about how to propose a new flash addition and about the
>> minimum testing requirements.
>>
>> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
>> ---
>>  Documentation/driver-api/mtd/spi-nor.rst | 189 +++++++++++++++++++++++
>>  1 file changed, 189 insertions(+)
>>
>> diff --git a/Documentation/driver-api/mtd/spi-nor.rst b/Documentation/driver-api/mtd/spi-nor.rst
>> index c22f8c0f7950..cc8e81e09544 100644
>> --- a/Documentation/driver-api/mtd/spi-nor.rst
>> +++ b/Documentation/driver-api/mtd/spi-nor.rst
>> @@ -63,3 +63,192 @@ The main API is spi_nor_scan(). Before you call the hook, a driver should
>>  initialize the necessary fields for spi_nor{}. Please see
>>  drivers/mtd/spi-nor/spi-nor.c for detail. Please also refer to spi-fsl-qspi.c
>>  when you want to write a new driver for a SPI NOR controller.
> [...]
>> +4/ Use `mtd-utils <https://git.infradead.org/mtd-utils.git>`__
>> +and verify that erase, read and page program operations work fine.
>> +
>> +a/ Generate a 2 MB file::
>> +
>> +    root@1:~# dd if=/dev/urandom of=./spi_test bs=1M count=2
>> +    2+0 records in
>> +    2+0 records out
>> +    2097152 bytes (2.1 MB, 2.0 MiB) copied, 0.848566 s, 2.5 MB/s
>> +
>> +b/ Verify erase::
>> +
>> +    root@1:~# mtd_debug write /dev/mtd1 0 2097152 spi_test
>> +    Copied 2097152 bytes from spi_test to address 0x00000000 in flash
> 
> Perhaps mention that the 2 MiB region should already be erased.
> Otherwise some flashes might refuse the writes (like the ones with ECC

right, then maybe we could do a

/erase
/read
/dump and see 0xff
/sha1sum to have the 0xff checksum
/write
/read what was written
/sha1sum on the read to make it's different that the 0xff checksum and
that the write worked

> -- Cypress S28 family comes to mind). Experienced engineers should know
> this already but it might trip up some beginners.
> 
> Looks good otherwise. Thanks for working on this.
> 
> Reviewed-by: Pratyush Yadav <pratyush@kernel.org>
> 
>> +
>> +    root@1:~# mtd_debug erase /dev/mtd1 0 2097152
>> +    Erased 2097152 bytes from address 0x00000000 in flash
>> +
>> +    root@1:~# mtd_debug read /dev/mtd1 0 2097152 spi_read
>> +    Copied 2097152 bytes from address 0x00000000 in flash to spi_read
>> +
>> +    root@1:~# hexdump -C spi_read
>> +    00000000  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |................|
>> +    *
>> +    00200000
>> +
> [...]
> 
