Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC387560E6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 12:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbjGQKtw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 06:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230412AbjGQKtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 06:49:49 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C02E10F1;
        Mon, 17 Jul 2023 03:49:47 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9928abc11deso619131366b.1;
        Mon, 17 Jul 2023 03:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689590985; x=1692182985;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Qa16i/7wXreM1XPm5VUwAx4KbT+PND+IKjgkjwF1pmM=;
        b=ZqE7722idPYuOeZQMCwC/uzDK4c1q56fL57sL1UBgNozIMQx6v4nFN9uW+hvzR4zu5
         m27aRXWsoTHtxNXd3TgfEvjSEOADpMXCTJNae36wZPHS2IOfUmVnDElqYp35uD5sXzY5
         9e8nV0U5qQO8fqA7k0SlYh6/wcfBpgZ7iS/Z5kG3S16fmKiguQYYrZSVDKtTHJbk+bIL
         0ld20pAYADjXXtBDEHZ66tYxNKV9vBeVxassuiNEwh4+0fn5LJoAMt5owyVXY2cgmXHo
         tDOIxbhxmea5nqiAgSQAvet6NGRN7yTj8Z3Ouxztoxch7tE291wE0r8xsYHZo/Tyxblj
         qnjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689590985; x=1692182985;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qa16i/7wXreM1XPm5VUwAx4KbT+PND+IKjgkjwF1pmM=;
        b=AkYBLv44t+wc0AWHl0UFj4iEYS3jP9vJFHsAWjKJTaWANC7nWrpzE+9RnEptFE/IRZ
         +G9ZhY80nIQASx1R8LM0kW7PTFvtviSxDwB1AP4SJYRRMPnnTh0LmEBPXA4scr11mjfh
         /Fg/VGybFl9WV1e7xk1L3u9CQMnKqu2Xu7+4wChRYV0lAgwImwvPLq7ALRnpKxLSzmKX
         msSeORH+NS34p6bwg/0fA+pXmhPyBR/6OkCCS9K3KwQXB8IDS/EPVdnH3Ff6YWBIfhuX
         jnRVUUi8C/kYQ93eVmGREuhMpXp2dYOi1ZpHhXuSe9LFOxbsiA1wU4+qTvEWG8r2cYvo
         1c5g==
X-Gm-Message-State: ABy/qLbCloqU3Tyk/qPKv6qsEwpCn/4CKWmqfEHmvQSMhDKAc70Cdi57
        Dhxhffx2t1/Uf1qT18tHvSA=
X-Google-Smtp-Source: APBJJlEWhmWn35hrYy0jF9wZjTDg+bvwe/myoKAbq4TI8tpZsEjUjQS0k5+CrUVKhtBS5Pr76ZeI3w==
X-Received: by 2002:a17:906:3f57:b0:94f:449e:75db with SMTP id f23-20020a1709063f5700b0094f449e75dbmr9046044ejj.52.1689590985266;
        Mon, 17 Jul 2023 03:49:45 -0700 (PDT)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id l9-20020a170906230900b0099342c87775sm9068788eja.20.2023.07.17.03.49.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jul 2023 03:49:44 -0700 (PDT)
Message-ID: <7448d35b-ce62-7e80-6467-ed929ad6838b@gmail.com>
Date:   Mon, 17 Jul 2023 12:49:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v1 2/2] mtd: rawnand: add nand-skip-bbtscan and
 nand-no-bbm-quirk DT options
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     richard@nod.at, vigneshr@ti.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <61c84262-cd98-1e60-d95b-9b0492083994@gmail.com>
 <2b0dc481-562f-c8df-545e-dcf6548adb07@gmail.com>
 <20230715175538.7142a141@xps-13>
Content-Language: en-US
From:   Johan Jonker <jbx6244@gmail.com>
In-Reply-To: <20230715175538.7142a141@xps-13>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/15/23 17:55, Miquel Raynal wrote:
> Hi Johan,
> 
> jbx6244@gmail.com wrote on Sat, 15 Jul 2023 12:49:18 +0200:
> 
>> A NAND chip can contain a different data format then the MTD framework
>> expects in the erase blocks for the Bad Block Table(BBT).
>> Result is a failed probe, while nothing wrong with the hardware.
>> Some MTD flags need to be set to gain access again.
>>
>> Skip the automatic BBT scan with the NAND_SKIP_BBTSCAN option
>> so that the original content is unchanged during the driver probe.
>> The NAND_NO_BBM_QUIRK option allows us to erase bad blocks with
>> the nand_erase_nand() function and the flash_erase command.
>>
>> Add nand-skip-bbtscan and nand-no-bbm-quirk Device Tree options,
>> so the user has the "freedom of choice" by neutral
>> access mode to read and write in whatever format is needed.
> 

> This sounds like a partial solution. How do you handle bad blocks?

Hi Miquel,

See below some Rockchip related links:

The file rk_ftl_arm_v7.S is marked GPL2, so I can freely refer/decode/hack to/in that.
For rk3066 a closed source piece called usbplug is still needed to program initial U-boot.
This usbplug contains similar code as in the S file and formats the NAND for FTL. 
U-boot is not small enough yet (WIP if I have the time) to replace that.
Long story short is that on Rockchip NAND's we can expect pages with various ECC and scrambled/randomized all over the place.

One effect is that when the MTD framework driver is probed a first time the BBT pages don't look what was expected.
For this first probe to be successful I must be able to turn of the MTD internal BBT scan and then erase/format all blocks except boot blocks of course.
During this first run bad blocks are handled by/tested/kept track of/set BBM in user space.
This is not meant as permanent mode.(except maybe if this S file is converted as open source FTL (WIP))

Richard doesn't like module parameters, so I can't simply do modprobe for example in a script.
After that the whole kernel/MTD must rebooted without these DT options.
 
This patch does make parameters/flags available for all.
If that is too much freedom to handle I can parse them in the Rockchip driver, let me know.
 
Linux always gets away with the "it must be generic functionality" excuse.
In U-boot there is the same driver with little or no interaction with the user, so we must deal with that.
Please advise how we can solve this in a simple nice automated way.


Johan

===

function FlashSetRandomizer()
https://github.com/rockchip-linux/kernel/blob/develop-4.4/drivers/rk_nand/rk_ftl_arm_v7.S#L120
https://github.com/rockchip-linux/u-boot/blob/next-dev/drivers/rknand/rk_ftl_arm_v7.S#L199

Proof of concept for U-boot:
[v2,06/11] rockchip: idb: add randomizer option
http://patchwork.ozlabs.org/project/uboot/patch/0b295d0e-53d6-b35a-3058-861e203b4d83@gmail.com/

> 
>> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
>> ---
>>
>> Previous discussion:
>> [PATCH v3 3/3] mtd: rawnand: rockchip-nand-controller: add skipbbt option
>> https://lore.kernel.org/linux-mtd/1618382560.2326931.1689261435022.JavaMail.zimbra@nod.at/
>> ---
>>  drivers/mtd/nand/raw/nand_base.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
>> index a6af521832aa..f0fa5c3519b1 100644
>> --- a/drivers/mtd/nand/raw/nand_base.c
>> +++ b/drivers/mtd/nand/raw/nand_base.c
>> @@ -5521,6 +5521,12 @@ static int rawnand_dt_init(struct nand_chip *chip)
>>  	if (of_property_read_bool(dn, "nand-is-boot-medium"))
>>  		chip->options |= NAND_IS_BOOT_MEDIUM;
>>
>> +	if (of_property_read_bool(dn, "nand-no-bbm-quirk"))
>> +		chip->options |= NAND_NO_BBM_QUIRK;
>> +
>> +	if (of_property_read_bool(dn, "nand-skip-bbtscan"))
>> +		chip->options |= NAND_SKIP_BBTSCAN;
>> +
>>  	if (of_property_read_bool(dn, "nand-on-flash-bbt"))
>>  		chip->bbt_options |= NAND_BBT_USE_FLASH;
>>
>> --
>> 2.30.2
>>
> 
> 
> Thanks,
> Miquèl
