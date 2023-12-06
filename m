Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8933980769E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 18:31:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378542AbjLFRbb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 12:31:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378425AbjLFRba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 12:31:30 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FC41122;
        Wed,  6 Dec 2023 09:31:36 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-a1c7d8f89a5so151324066b.2;
        Wed, 06 Dec 2023 09:31:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701883895; x=1702488695; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:cc:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HUSnG7lR5r81demuoO793bBkL85YJnA56MLO1pgm758=;
        b=C/SnKAwMUsGStYMVfz/4u0puPhWFdHrAlD4yxWZHM9tSnF5SW8iN6pisgIHODApeKW
         jIZQ5d+ZuPAEJeHH2adDD2miJV2jJjbDQEJYHGEW5YgYO1sXQMaA73lKpEufHW8f6UeJ
         y7HPjrjDsq1zYHulJPzHPwdDL+S52aBG2QChOjWS6TjzlaU/e80QWeT1zKXNCdRUbfGN
         mgf/3YxQCY1XnTmISVOusPB80dn/2faDf+gNxp9SjrrmtREXXw4OxmrD38LZHmcEbL/s
         +hKPp8pJKWh1aIQmEdEcbLkOY82tu/1+qASG+rYbLdaS47lYS8GIc0VnEvzvKe+BFBZr
         3zBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701883895; x=1702488695;
        h=content-transfer-encoding:in-reply-to:cc:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HUSnG7lR5r81demuoO793bBkL85YJnA56MLO1pgm758=;
        b=VoP1FVVJuHdD+1o5hH5wO6i0/+QpwOkVIyuKFRU7bshOas0Nh0RmzPJOdaNhs3r5HY
         tHxyw7Iy0SomqKGlK5IWp9FjbdFFnUtmiBGcJapuncicKzALyU3yin2h8nqLt1t+1/2M
         izogzIfHVF9QJH5aJNXP1gr8Tu9shrhssaa+bb7Yu7eVRk6SaEJNIzOtiksAZLuingPv
         tdz6tSEUX2SQb3kZTQuEsqpNcrJoIlPW7oGuQ+cRd8+L6CjBTdXUYu3CQDy28Dgykq2D
         Yj5bTtla4hfQquoh80p84+tp5gBVdED3/nqL74O2tnIP8/NcaQ8/kqGhq4TxCC+xiOtk
         Ld5w==
X-Gm-Message-State: AOJu0YwA0XsEjmCbmNPH8mwcgmRz2LRUC5H8E83gfyxaXebZD40HQeHI
        CY/ByLv5C92MvvYWERv5DK4=
X-Google-Smtp-Source: AGHT+IFBQmRkUYCNl47dh4oLdxU29acm6/uc6RUaBp/PM2Mb50JrhUiHl12Bxmha7z85d+U8iVnxKw==
X-Received: by 2002:a17:906:ae9a:b0:a19:a1ba:da39 with SMTP id md26-20020a170906ae9a00b00a19a1bada39mr704039ejb.96.1701883894400;
        Wed, 06 Dec 2023 09:31:34 -0800 (PST)
Received: from [172.25.98.130] ([79.119.102.174])
        by smtp.gmail.com with ESMTPSA id o9-20020a1709061b0900b00a1aad4d92dbsm197798ejg.123.2023.12.06.09.31.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Dec 2023 09:31:33 -0800 (PST)
Message-ID: <7db777ae-3756-4672-b571-eafe9d8384d2@gmail.com>
Date:   Wed, 6 Dec 2023 19:31:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/2] iio: adc: ad7173: add AD7173 driver
Content-Language: en-US
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
References: <20231205134223.17335-1-mitrutzceclan@gmail.com>
 <20231205134223.17335-2-mitrutzceclan@gmail.com>
 <CAHp75VeKhR5y4AB=L5VVSrm=13Ruw7e86m+K9m9t-LZg5puDow@mail.gmail.com>
 <e72085fd-3203-4166-afab-73707d27d174@gmail.com>
 <ZW9bVDLZl4-QLIbg@smile.fi.intel.com>
 <e03e40b55f834d5cafb67bf728599688@analog.com>
From:   Ceclan Dumitru <mitrutzceclan@gmail.com>
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl, andy@kernel.org,
        linux-gpio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Arnd Bergmann <arnd@arndb.de>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        =?UTF-8?Q?Leonard_G=C3=B6hrs?= <l.goehrs@pengutronix.de>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        Haibo Chen <haibo.chen@nxp.com>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        Ceclan Dumitru <dumitru.ceclan@analog.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <e03e40b55f834d5cafb67bf728599688@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/5/23 19:18, Andy Shevchenko wrote:
> On Tue, Dec 05, 2023 at 06:12:18PM +0200, Ceclan Dumitru wrote:
>> On 12/5/23 17:28, Andy Shevchenko wrote:
>>>> +               ref_label = 
>>>> + ad7173_ref_sel_str[AD7173_SETUP_REF_SEL_INT_REF];
>>>> +
>>>> +               fwnode_property_read_string(child, "adi,reference-select",
>>>> +                                           &ref_label);
>>>> +               ref_sel = match_string(ad7173_ref_sel_str,
>>>> +                                      ARRAY_SIZE(ad7173_ref_sel_str), ref_label);
>>>> +               if (ref_sel < 0) {
>>> Can we use fwnode_property_match_property_string()?
>>
>> fwnode_property_match_string() searches a given string in a 
>> device-tree string array and returns the index. I do not think that 
>> this function fits here as the DT attribute is a single string.
> 
> I'm not talking about that. I mentioned different API call.
> 
> /**
>  * fwnode_property_match_property_string - find a property string value in an array and return index
>  * @fwnode: Firmware node to get the property of
>  * @propname: Name of the property holding the string value
>  * @array: String array to search in
>  * @n: Size of the @array
>  *
>  * Find a property string value in a given @array and if it is found return
>  * the index back.
>  *
>  * Return: index, starting from %0, if the string value was found in the @array (success),
>  *         %-ENOENT when the string value was not found in the @array,
>  *         %-EINVAL if given arguments are not valid,
>  *         %-ENODATA if the property does not have a value,
>  *         %-EPROTO or %-EILSEQ if the property is not a string,
>  *         %-ENXIO if no suitable firmware interface is present.
>  */
> 
> --
> With Best Regards,
> Andy Shevchenko
> 
> 

Yep, it can be used. I cannot seem to find it upstream but found the
thread, when the patch containing that function will be applied I'll
change to that.
