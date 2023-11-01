Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66CED7DDC1D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 06:14:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347391AbjKAE5k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 00:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347601AbjKAE5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 00:57:36 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B39CFF4;
        Tue, 31 Oct 2023 21:57:31 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id 5614622812f47-3b2b1af09c5so3288518b6e.0;
        Tue, 31 Oct 2023 21:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698814651; x=1699419451; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=Dhn/IjeR74fkK1nLmuHR/OQjpqUpGvm8nym9w7HoSZk=;
        b=PkSVSZMkCOcuqu6oDyKEzzZt65dr7gQetZ+x+8a2131jniDtLXKv/gU1xEBKwH0QDL
         MDz7rB8rH1PKCDlsg9sOyrsDsN72g424PuIZrJUfjCYMnNfiX1FqekpHsXd3MrRGSbkU
         29AnbNjbNNCY+ciTgnEPbxE6H4KakQU4fmkfOv1kq/g6w76bdfM8tN3BO73CVut6KWrW
         pKEdPjNHBWyafvjIRrDgosq2b4DFkfA8i1f6syY7QIk0CXQ46bviyg/tnBH9xm1qiUpP
         +A78kTN8cuni1Dy6cNq7IwAsxFid88gH8JDvSJx/pKkf89Z9DJbFk8GHr+YfX0D40tHz
         MxMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698814651; x=1699419451;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dhn/IjeR74fkK1nLmuHR/OQjpqUpGvm8nym9w7HoSZk=;
        b=CsayvpZvZJ23/goA+reSbzi6OS8f1/ddQBaM1n58bWP5mYW+0lg96bttXi2DVI2RNL
         Xw9Hbx6/CL6pP9XHBTBZWe0GMM42GijcGPM3qw78PjT6cwySnF/OZaR6ZggLYuEDQ4s4
         HkN9kjGYWWMG1mpmy/nc2W6f3O0HMwz7DRfezuX4GYVthXtr6zblg4u16uZxQp66AfCi
         NJaaUAWXuUA6YOLaP2IDJhGo7QvVy4i+bXQGvXH+RwnxlbNVzyJbFgL7Ah26RycD664U
         tLKmV9iGQ5XwGe2D0L1xrFB/LmSTeKhyTK9bvE8Sdh5egwSte+B+4AhHfyC4MCAsL5Gj
         C5hQ==
X-Gm-Message-State: AOJu0YzY237/yjTVnHXV0evst+0WFxKblFEW6AV90kf79HAcNf1T9x3K
        9DvWres4zOF6je3/TYncIcshXzW1qWU=
X-Google-Smtp-Source: AGHT+IFC4iObFxWJKphIMbJfknYNGrxQGIa24teK7bB7vE2x5FDPRlImcte+PJFCBS35Ui+zK04NVg==
X-Received: by 2002:a05:6808:2a41:b0:3a9:cfb5:462a with SMTP id fa1-20020a0568082a4100b003a9cfb5462amr11760033oib.36.1698814650929;
        Tue, 31 Oct 2023 21:57:30 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x7-20020a056a00270700b00690c7552098sm431275pfv.44.2023.10.31.21.57.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Oct 2023 21:57:30 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <aa00e20a-03ee-4092-a477-6d952cdacf4e@roeck-us.net>
Date:   Tue, 31 Oct 2023 21:57:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] hwmon: emc1403: Add support for EMC1442
Content-Language: en-US
To:     Patrick Williams <patrick@stwcx.xyz>
Cc:     Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231031085807.618827-1-Delphine_CC_Chiu@wiwynn.com>
 <7d92d8ae-c247-4a71-a84d-4f9639a43fb8@roeck-us.net>
 <ZUG3fOnw8RE7JHsh@heinlein.vulture-banana.ts.net>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <ZUG3fOnw8RE7JHsh@heinlein.vulture-banana.ts.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/31/23 19:27, Patrick Williams wrote:
> On Tue, Oct 31, 2023 at 04:01:10PM -0700, Guenter Roeck wrote:
>> On Tue, Oct 31, 2023 at 04:58:06PM +0800, Delphine CC Chiu wrote:
>>> Add support for EMC1442 which is compatible with EMC1403.
>>>
>>
>> Unfortunately, almost no information is available about this chip
>> except that it ships in an 8-pin package. Are you sure the chip
>> supports two external temperature sensors like EMC1403 ?
>> The chip numbering and the number of pins would suggest that
>> it only supports a single external temperature sensor,
>> which would make it compatible to emc1402/emc1422.
>>
>> Guenter
> 
> The datasheet I've seen says:
> 
>>> The EMC1442 monitors two temperature channels (one
>>> external and one internal).
> 
> Based on this, I agree that emc1403 seems wrong.  The datasheet also
> says:
> 
>>> Pin compatible with EMC1412
> 
>>
>>> Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
>>> ---
>>>   	{ "emc1422", emc1402 },
>>>   	{ "emc1423", emc1403 },
>>>   	{ "emc1424", emc1404 },
>>> +	{ "emc1442", emc1403 },
> 
> So, emc1402?
> 

At the very least, if you are willing to confirm that formally
if/when v2 is submitted.

I previously rejected a similar patch adding emc1444 because it was
impossible to get a datasheet to confirm that the chips are really
register compatible. No idea why that has to be so secretive. It is a
temperature sensor, for heaven's sake :-(

Guenter

