Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD4D4759ED9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 21:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbjGSTjc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 15:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjGSTja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 15:39:30 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B958911C;
        Wed, 19 Jul 2023 12:39:28 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4fb96e2b573so12315095e87.3;
        Wed, 19 Jul 2023 12:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689795567; x=1690400367;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4J5hSUWV8g1G/mLF/LKS95JQ6t1uO7RiOvw0BN1K0AU=;
        b=XTHdtCRbnkk8De8R8ayLzLgRYSP98h4DBJ2ksZ2o8/UOca/20Gu5Q+VeifhivEJA/v
         WYrT62Pe/8AqxDd146rWc16nREGvwkJ2TzxyQjzD7JLb7XbvMoli8icCpNKbdZjmamsh
         n3m+Q2Z+9EJEdffFx/qwGxxT+T739hQhMMjOZqTs7YPGIvZhLdMNPywH6Nr8MDmogpWP
         ibpaLaM6Z+GpVYj/x27Cnjt8/4x6QdSnE8sapDAMBSIOZmBWaZRCB7xWhA6aDNkiNbST
         8sBf9eyPWvamtVoBYVsfH6QBhaiNt+Lg/f2CeWK8MSH6WA4FiWki/FxWBbzkxwNq7/gX
         UngQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689795567; x=1690400367;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4J5hSUWV8g1G/mLF/LKS95JQ6t1uO7RiOvw0BN1K0AU=;
        b=TkTqy//RqrRq0LovC6XXJqcULlZqBZ1mRhn8AVqS6o30TDswgVS+5iBxyShMybOcoa
         NCcslahP0DnbqGUDIqg+QiwhWpvmi8pcsqHMzWxem6XP7hNzqdZS3QYznoxzO5eov1d7
         9fdURC2N+eZvi4rhSztGhHSQWaYV58vhde2ihugxUHsWxbu4wKOz3B7OTMmDnJ0fZq/c
         n8Er6HoV2XZspUeIsWHRVLDU3dku+a4VB1+D19CsUa0U3ArrG38r7MFRjj2OgPHZnq4a
         zW+OeNokxVWrwGVX98ZUGYY0YFK4ZZDqhokpA4E9H9HLKBPTTxhwNDCZJ78kOEUu4GFu
         mcMQ==
X-Gm-Message-State: ABy/qLZ1wnrZqtZ2NmluZn6SfaXqA0/WNd7+WTzXxIKI8QKTzxcLWigH
        qsZ3PSDbGpm4AskaCJogku3HvExCKOA=
X-Google-Smtp-Source: APBJJlEK2lZLBr0hVdf0l8BoBxBgARN38VQyzV2MGXJw7PWWBLISTw4nLpLv5qNUxhOgwEI0Htw8DQ==
X-Received: by 2002:a05:6512:34d3:b0:4fd:c882:bb42 with SMTP id w19-20020a05651234d300b004fdc882bb42mr587897lfr.15.1689795566637;
        Wed, 19 Jul 2023 12:39:26 -0700 (PDT)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id v5-20020aa7cd45000000b0051e069ebee3sm3076174edw.14.2023.07.19.12.39.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jul 2023 12:39:25 -0700 (PDT)
Message-ID: <c919ba00-f741-33ff-cc6f-18988c52f14d@gmail.com>
Date:   Wed, 19 Jul 2023 21:39:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v1 1/2] dt-bindings: mtd: nand-controller: add
 nand-skip-bbtscan and nand-no-bbm-quirk DT options
To:     Conor Dooley <conor@kernel.org>
Cc:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <61c84262-cd98-1e60-d95b-9b0492083994@gmail.com>
 <20230718-curfew-jumble-aeafe95c5cc7@spud>
Content-Language: en-US
From:   Johan Jonker <jbx6244@gmail.com>
In-Reply-To: <20230718-curfew-jumble-aeafe95c5cc7@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/18/23 17:46, Conor Dooley wrote:
> On Sat, Jul 15, 2023 at 12:48:16PM +0200, Johan Jonker wrote:
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
>>
>> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
>> ---
>>
>> Previous discussion:
>> [PATCH v3 3/3] mtd: rawnand: rockchip-nand-controller: add skipbbt option
>> https://lore.kernel.org/linux-mtd/1618382560.2326931.1689261435022.JavaMail.zimbra@nod.at/
>> ---
>>  .../devicetree/bindings/mtd/nand-controller.yaml    | 13 +++++++++++++
>>  1 file changed, 13 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/mtd/nand-controller.yaml b/Documentation/devicetree/bindings/mtd/nand-controller.yaml
>> index f70a32d2d9d4..ca04d06a0377 100644
>> --- a/Documentation/devicetree/bindings/mtd/nand-controller.yaml
>> +++ b/Documentation/devicetree/bindings/mtd/nand-controller.yaml
>> @@ -103,6 +103,19 @@ patternProperties:
>>            the boot ROM or similar restrictions.
>>          $ref: /schemas/types.yaml#/definitions/flag
>>
>> +      nand-no-bbm-quirk:
>> +        description:
>> +          Some controllers with pipelined ECC engines override the BBM marker with
>> +          data or ECC bytes, thus making bad block detection through bad block marker
>> +          impossible. Let's flag those chips so the core knows it shouldn't check the
>> +          BBM and consider all blocks good.
>> +        $ref: /schemas/types.yaml#/definitions/flag
> 
> While this seems okay, as it seems to describe facet of the hardware...
> 
>> +      nand-skip-bbtscan:
>> +        description:
>> +          This option skips the BBT scan during initialization.
>> +        $ref: /schemas/types.yaml#/definitions/flag
> 
> ...this seems to be used to control the behaviour of software, and does
> not describe the underlying hardware.
> 
> Maybe I'm off, but the description of the property does not hint at the
> aspect of the hardware that this addresses.

Hi Conor,


Thank you!
Your point is correct.
However I need both flags to change MTD software driver probe behavior in case of formatting.

Patch was made after comment by  Miquel:
'I would rather prefer a DT property which says "do not use the
standard pattern".'

DT should describe hardware and not software probe configuration.
Currently not aware what other options we have for module parameters.
Prefer my solution in the link. Could the MTD maintainer have a look again? Thanks!
Please advise.

Johan Jonker

> 
> Thanks,
> Conor.
> 
>> +
>>        nand-rb:
>>          description:
>>            Contains the native Ready/Busy IDs.
>> --
>> 2.30.2
>>
