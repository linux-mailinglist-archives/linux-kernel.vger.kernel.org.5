Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 057CC7F34CF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 18:17:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234469AbjKURRf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 12:17:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234456AbjKURRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 12:17:22 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1C5010DA;
        Tue, 21 Nov 2023 09:17:08 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9fa45e75ed9so474060066b.1;
        Tue, 21 Nov 2023 09:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700587027; x=1701191827; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=swhdhjkQ4NCZZT2+5iCdL+NEq1b8GxVa0Me/RJxD8Hs=;
        b=ZXuj5ltuVb5wZ33auRp2oxBY8VPwiNJGv7c8WI3sPblFjXHNvFAtSCu7BWfivItF+r
         8jU0tyVz0gVDKzpu+etenBx4csLTQVBoYB2Geir8Y+Bz24wDaoJVUfCqAVskLL1UrHVn
         j+BCotxkXxA/yl3f6HxoAp27dBhWvS6Dcx9ijBOKbkvi3/pK1ujY1LsE+aC/06zWysyQ
         xrSlEtINQmfBtINRHwX9/wE4P1PzIy7gvg2CAzQyGtuWsIVuB+P09OebjIVVPXvpivuz
         B1EU466I/lRtqLHTlPgU6zNOHwItEbyYdnqwNI/i9fP90wBHY9zKQo5ME2gHLPJ/y7WA
         jbug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700587027; x=1701191827;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=swhdhjkQ4NCZZT2+5iCdL+NEq1b8GxVa0Me/RJxD8Hs=;
        b=Q+VkQ4/DyG3ylNojFauUcGMr5+yk6baCLC7LdwzkIM9/e+83QmprFFJQtD4qIi5S5B
         rFW91q3uUT2P+5SC93HyEzF+hOGKt65C+0LiWej2qfzAIkrQBrfGHOi/0G/K3p7uzqM8
         0K803TU5NZYfE4rlzyfcuzBLS2j9+FdlMmtvAH1ip2Cy32BwFxopsEFD1FM8O1Z2mOXR
         TOY2hLmxRbfSoMHkgsSqrtUp+xLNTmahuY3g9W2edmxxhPVq8UIbpYTEaHPBm0zUK14t
         0ASnbyY/puCpxwpJnCfuVX5IptPhEStDdva3btcMVuKideTrFKLlZwEFHdGRk7K3YIsq
         2dHw==
X-Gm-Message-State: AOJu0YzJTYt9wj8ShrCbOhItk/TkcImmMeaVf7oK3rVhJNi2AFVq4/pp
        Nl2w7QvLAAhCeDgZWhtHXbI=
X-Google-Smtp-Source: AGHT+IFnpq2tyXR/236QuDzP3r9GnwuVCYNJWclVkciClWmvYsMI6oPqg0/rnsmK3i7fIQrxgO45BQ==
X-Received: by 2002:a17:906:d28c:b0:9fe:5d39:41c6 with SMTP id ay12-20020a170906d28c00b009fe5d3941c6mr5201086ejb.51.1700587026775;
        Tue, 21 Nov 2023 09:17:06 -0800 (PST)
Received: from [172.25.98.130] ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id uz4-20020a170907118400b009fc2a76ddedsm3606927ejb.17.2023.11.21.09.17.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Nov 2023 09:17:06 -0800 (PST)
Message-ID: <7234efaa-58db-4a49-b422-27fc08d6b6e9@gmail.com>
Date:   Tue, 21 Nov 2023 19:17:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] iio: adc: ad7173: add AD7173 driver
Content-Language: en-US
To:     Andy Shevchenko <andy@kernel.org>
References: <20231116134655.21052-1-user@HYB-hhAwRlzzMZb>
 <20231116134655.21052-2-user@HYB-hhAwRlzzMZb>
 <ZVtYeWZmcDZ_SMPo@smile.fi.intel.com>
 <5cf3824f-6375-4c76-86ff-c5389ddf4196@gmail.com>
 <ZVuHcaUQL6xnchK-@smile.fi.intel.com>
 <643d2c2c8dd4490081c234b6831ee5dd@analog.com>
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl,
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
From:   Ceclan Dumitru <mitrutzceclan@gmail.com>
In-Reply-To: <643d2c2c8dd4490081c234b6831ee5dd@analog.com>
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



On 11/20/23 18:21, Andy Shevchenko wrote:> On Mon, Nov 20, 2023 at
05:55:12PM +0200, Ceclan Dumitru wrote:
>> On 11/20/23 15:00, Andy Shevchenko wrote:
>>> On Thu, Nov 16, 2023 at 03:46:55PM +0200, mitrutzceclan wrote:

> 
> Use struct_group() to show explicitly the group of members. If it's not an ABI in any sense, then memcmp() is fine.
> 

Alright

>>>> +	return vref / (MICRO/MILLI);
>>>
>>> What does the denominator mean and why you can't simply use MILL?
>>
>> Original vref values are in micro, I considered that it was adequate 
>> to represent the conversion from MICRO to MILLI as a fraction.
>>
>>>> +		*val = st->info->sinc5_data_rates[reg] / (MICRO/MILLI);
>>>> +		*val2 = (st->info->sinc5_data_rates[reg] % MILLI) * 
>>>> +(MICRO/MILLI);
>>>
>>> Same Q about denominator.
>>>
>> Here, a misunderstanding on my part of a suggestion from Jonathan in 
>> V2, will be removed.
> 
> You need to clarify with him that.
> 
My misunderstanding was that he only referred to the multiplication, not
the denominator. *val has a conversion from MILLI to no metric prefix
while *val2 converts from MILLI to MICRO.
