Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B80FA803AFF
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 17:58:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbjLDQ6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 11:58:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235395AbjLDQtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 11:49:19 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8633C0;
        Mon,  4 Dec 2023 08:49:25 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-3334a701cbbso978029f8f.0;
        Mon, 04 Dec 2023 08:49:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701708564; x=1702313364; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=s7FP95rE9QTVcfU2H6+B7dd6w71sV7PtM/IxstkThp4=;
        b=IjIifOXYcKU+Dp4S47CJ0RDdc1ETeVG+xnkr2HU9erJgD1NSLDw6PkE8ZeTmx+qJWT
         qn4hNgQldu9jMe0+L/qwUJPqY2RNjJiLfN7/9rQWs4qtuSEvr4kBiwvMAf25Vk5fmK+J
         5S6OidZgVokpBMvNVwSVCX/YQoWLV41gx+nR8i5Hm3akNZptYL+643NWSROO2aIhzc44
         pB5agQdN7R20ycB6FS31rEDYBoUtr0uzazl+Pzs6q3ApNFFkQYxeDXlF60lY+W17rLyp
         3ZxbaCUJ9A4p8RPxOWR7RTGR0WF1le6X16YqQ2eQ6dudIz/C3jtomvhooXK6A3dFv5vy
         oMHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701708564; x=1702313364;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s7FP95rE9QTVcfU2H6+B7dd6w71sV7PtM/IxstkThp4=;
        b=Eap+O4CWqbIzcUsqVIaXnJ/0nKj60HOTRlNqi/R2lnPUENNrIDdHazRP7xKltH/5/W
         KwEtVIEQdMTYsdeNMy1jzsF1tmZNn1539j125vimoWGsNYoC8G8ORbvU5IQ8nm2vXine
         McRQljefb765LsFD91rOpZuHkkl4zyn1G/Z74WFqRsPSGZTRMRRd9F+8ood7YSckInvr
         jWHgsj/fvi5ys0sim5vRyUC4aum7VqRxopezCNKKs1ZV4/F9+RSpSVquZu3Lru3VBgLs
         QiEIrJbvPe+N4w0rv9F/QEUQZ2dromtgwqIssW6JQ9Rj11gdp/rLtwpj1D/M0UEcO+Rl
         SOBw==
X-Gm-Message-State: AOJu0YzjsfxFdzKP4+l92lf+/pTfdRxNlaaxc2/i2mPMbXPWvL2is3O/
        IKoLHUfxxPH9/2Z70hFS8q0=
X-Google-Smtp-Source: AGHT+IHdOkgQRVHu3jcclKybvEYBcjOFHYhiXAMmLGis+CFMOi9Z9BZer6qBdzxQwfuA9OIsHCGSTA==
X-Received: by 2002:a5d:4643:0:b0:333:4156:2763 with SMTP id j3-20020a5d4643000000b0033341562763mr1332368wrs.140.1701708563864;
        Mon, 04 Dec 2023 08:49:23 -0800 (PST)
Received: from [172.25.98.130] ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id q4-20020a05600000c400b003333fa3d043sm5972220wrx.12.2023.12.04.08.49.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Dec 2023 08:49:23 -0800 (PST)
Message-ID: <9dbb81f8-7c75-411d-a77c-b670302f0dfe@gmail.com>
Date:   Mon, 4 Dec 2023 18:49:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Ceclan Dumitru <mitrutzceclan@gmail.com>
Subject: Re: [PATCH v6 2/2] iio: adc: ad7173: add AD7173 driver
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl, andy@kernel.org,
        linux-gpio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
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
References: <20231123152331.5751-1-user@HYB-hhAwRlzzMZb>
 <20231123152331.5751-2-user@HYB-hhAwRlzzMZb>
 <20231125172125.1b0f1ae7@jic23-huawei>
Content-Language: en-US
In-Reply-To: <20231125172125.1b0f1ae7@jic23-huawei>
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



On 11/25/23 19:21, Jonathan Cameron wrote:
> On Thu, 23 Nov 2023 17:23:22 +0200
> mitrutzceclan <mitrutzceclan@gmail.com> wrote:
> 
>> From: Dumitru Ceclan <mitrutzceclan@gmail.com>

...
>> +	st->regulators[0].supply = ad7173_ref_sel_str[AD7173_SETUP_REF_SEL_EXT_REF];
>> +	st->regulators[1].supply = ad7173_ref_sel_str[AD7173_SETUP_REF_SEL_EXT_REF2];
>> +	st->regulators[2].supply = ad7173_ref_sel_str[AD7173_SETUP_REF_SEL_AVDD1_AVSS];
>> +
>> +	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(st->regulators),
>> +				      st->regulators);
> 
> If only some of them are supplied, the driver works fine as long as no channel is using them?
> If so should probably get the optionally then check for availability of the ones you
> want.  I'm sure someone will just wire up ref.  Incidentally, ref2 isn't there for all chips
> I think, so we should not get it on the ones where it can't exist.
> 


This sets a dummy regulator in place if no proper supply is found. Then
the call regulator_get_voltage() on the dummy will fail. About getting
ref2, sure, I'll set the string only with the right ID.

...
>> +		ret = ad7173_get_ref_voltage_milli(st, (u8)ref_sel);
>> +		if (ret < 0)
>> +			return dev_err_probe(dev, ret,
>> +					     "Cannot use reference %u", ref_sel);

Here the probe would not continue if a channel selects a supply that is
not available in the DT.
