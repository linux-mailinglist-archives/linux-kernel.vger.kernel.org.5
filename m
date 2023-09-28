Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC7E7B267B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 22:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232183AbjI1UWx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 16:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230325AbjI1UWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 16:22:50 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEE531A2;
        Thu, 28 Sep 2023 13:22:48 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2c15463ddd4so155321311fa.3;
        Thu, 28 Sep 2023 13:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695932567; x=1696537367; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lb3fNYZA0xAkN3i8NbRXfjT74VUbIMsYox0aoT4QY3k=;
        b=lntd+c+HNdMXA0GR4+u8ipy3CCTxlvoMKAcN36+UgUYuYh8bOkv44GTY7Aal20zQvA
         4M8/0hJC1bcM0utdEvznpxw6UjNxFNCRiZ+TbcGhr4LRQ64tw5avhs8AzmKQ0mUBJRQk
         PNTskToK1vjcLhLPYSOVBDsAvMPvaTghGXxg6uyUT8hqAypbzKUKRMPhlVDr15Z1h8le
         1CJgYBzLrmQtyD0TFe2FiyO9QPSn6rXz3HJxUkrWWryeoSvuDmrcVV2qVWpW6+JmWfKd
         xRqwYbxekVX/ZtFSTRvaDcn2bkZ85oN1D4l6NbgIFIm40JuMa3Ax7eP97nPNzgONynXt
         6Fcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695932567; x=1696537367;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lb3fNYZA0xAkN3i8NbRXfjT74VUbIMsYox0aoT4QY3k=;
        b=iUEGtNcdt759RotFP1GxL3ligdjeVblZ+aceOZRZaEAIK8E0TeyoQ8DHL9StFFOXlr
         O8o852wJU5yr+k4tf6DY1Hh22RXE8TCdU0I2CT5GQ8Ec34o5oLtAZq+uUJ9XJkUiGjch
         56ECgX+6QZkT0OyaQy2QAEW8ZriuQJyoQo5IKyXoCdI3m0Lbz50xDjvH6zyoNOXSzavf
         9nU9jEbDO25eBiQ9th5jxDsjQtGLr0P9HHWVR7yC/8djscZPzTP3c99S21OYzmiN4pns
         NpufXqSk0vJ74gS4DMorrMripsL2vk8RFprJOhMBEgoyTgPl4T35Vwn98FicfyjP3DI9
         nQOA==
X-Gm-Message-State: AOJu0Yxziu3Qcy83hvo+08cBJh/lyFtTkAhkBh35yd9VBo1+J+Otn6eG
        5/cqgch8qn38vTiaUu/j2I5xucY2r2U=
X-Google-Smtp-Source: AGHT+IHJiNbVbCpmttVx9QirnoubmukF1zf4kFh8Hl2KM1YLJSELIPUO8XFg4gePbwCCcSNekFMN8w==
X-Received: by 2002:a2e:a163:0:b0:2bc:e51d:89a3 with SMTP id u3-20020a2ea163000000b002bce51d89a3mr2249598ljl.29.1695932566639;
        Thu, 28 Sep 2023 13:22:46 -0700 (PDT)
Received: from [192.168.1.8] ([37.55.203.63])
        by smtp.gmail.com with ESMTPSA id m25-20020a2e8719000000b002bcb9956a69sm3791155lji.41.2023.09.28.13.22.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Sep 2023 13:22:46 -0700 (PDT)
Message-ID: <06e71bb8-370d-4b66-bedb-3041d6e3b2c6@gmail.com>
Date:   Thu, 28 Sep 2023 23:22:42 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] input: generalize the Imagis touchscreen driver
To:     Karel Balej <karelb@gimli.ms.mff.cuni.cz>,
        Karel Balej <balejk@matfyz.cz>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Jeff LaBundy <jeff@labundy.com>, linmengbo0689@protonmail.com
References: <7b9864bf-2aa6-4510-ad98-276fbfaadc30@gmail.com>
 <72e02837-9a82-4007-8ba2-fa05f3c17670@gmail.com>
 <CVUR18U9FUME.XSF1MML0B1QN@gimli.ms.mff.cuni.cz>
Content-Language: en-US
From:   Markuss Broks <markuss.broks@gmail.com>
In-Reply-To: <CVUR18U9FUME.XSF1MML0B1QN@gimli.ms.mff.cuni.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Karel,

On 9/28/23 21:07, Karel Balej wrote:
> Hello, Markuss,
>
> thank you for your response and please forgive that my original emails
> didn't reach you - I am trying to see if I can get the SMTP server I use
> for my primary address officially authorized to send emails in its name
> so that Google does not reject them.
Yeah, I have not received your first series, only knew of it when the 
replies came. It's fine though :)
>
>> To be fair, this driver should work with all Imagis3 chips, which could
>> be a better name for it. However, I agree with Jeff here: the driver
>> doesn't necessarily need renaming.
> I will be sure to drop the renaming for v2.
>
>> Additionally, there used to be my series [1] that generalized the
>> driver, but it never got applied. I will re-send it. It introduces
>> `struct imagis_properties`, which contains register addresses for the
>> registers that we use to read the touch input. In your specific case, I
>> believe it should be:
>>
>> static const struct imagis_properties imagis_3032c_data =
>> {
>> 	.interrupt_msg_cmd = IST3038C_REG_INTR_MESSAGE,
>> 	.touch_coord_cmd = IST3038C_REG_TOUCH_COORD,
>> 	.whoami_cmd = IST3038C_REG_CHIPID,
>> 	.whoami_val = IST3032C_WHOAMI, /* change it to your whoami */
>> };
> I have come across your patch series and in fact my original experiments
> were based on it. However I thought it was abandoned and decided not to
> try to make any further generalizations to the driver for now, except
> making it work with IST3032C. Should I then perhaps wait before your
> series gets applied before sending v2 of my changes? Or should I send
> you a patch on top of your series, where I would add the `struct
> imagis_properties` for the IST3032C (which you surely could do yourself,
> but I can at least test it with my device). Please let me know if and
> how we should coordinate.

If you don't mind the extra hassle, I'm all in for my generalization 
thing going together with your series.

Alternatively, I can resend it myself, but I believe it would be better 
if they go in bulk since they need to be applied together.

>
>> As for the voltage set, I believe this does not belong in a kernel
>> driver. You should set it in device-tree with `regulator-max-microvolt`
>> and `regulator-min-microvolt`.
> Please see my response to Jeff regarding this. I will be happy to hear
> your thoughts on what I propose.

Actually, the regulator values belong to the device-tree, because the 
device-tree for the board is what describes the board's regulators, and 
since you know what components are installed on that specific board you 
can know which regulator values are supposed to be set for it. This 
manual voltage setting can cause conflicts with other drivers for 
example. Also some device can use a variable wide voltage range, and 
some only specific narrow one, and e.g. the driver with wide range would 
set it to voltage that isn't suitable for the narrow range device, so 
it's much better to just specify it manually than have it resolved.

The actual min/max values for regulators or its voltage table is 
provided by the regulator driver itself, so there's not much point in 
specifying those again in the device-tree.

>
> Kind regards,
> K. B.
- Markuss
