Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4701B77D35D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 21:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239611AbjHOTYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 15:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239873AbjHOTYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 15:24:31 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F25A1FF1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 12:24:05 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-31792ac0fefso4889796f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 12:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692127443; x=1692732243;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eB2YdeaffFvKapTeu97tKDXHKtW8rfmRdezXiy0N6zs=;
        b=SAY2gmIGNEAiGgInuM1nDGvc/w31ckngzwPdU5Nqy5hC0Nh2Va91zmvCGoJguwvcGY
         20kRSVSGJXKP6DVme+avP+mwcYdlzcSUDrzWwPvB5dQFqt0dp/w9V4ASPFPW4ogmj4vh
         x3pE5ECuJREptlRY/PQ5DolWgEM1gYN8/r5QPaIgZwBnj4bC4q+KfKIrLK8qNd9mcvZ7
         ZHWQkA/8tCoe9HfDv6JqLPFLWGUJrKapW+0lccWL7ASniljFJpcv72pKauVvxCdq9bue
         afDATz3M4QhchabaBBQ5x0iaP7I28TZfZHV1IuvfYkJmJDCW0E5Xl2crAyvz1ETAjo0I
         B1eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692127443; x=1692732243;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eB2YdeaffFvKapTeu97tKDXHKtW8rfmRdezXiy0N6zs=;
        b=e6FawONNhJhPYPjxToIAnOdBdAK2Ty0+Mro5/XFj6n/NvO5cOMOU4wbK1R1yf1L6bG
         PcHD7AgMzoXzc4TcdCIoH1yDGtUJuo9YWODiKLkPZmRRjzyU+zzCgTPSuemNiFZwyKkN
         mjKUsQ98J1k8P5HFza93+Aw6HIcrkPhvm087yN7MHVsR0+XhIqR8MS/z3a1awQzK3BQy
         eNk+2qUoAp71V9H2JB0NNixcjzaU/Bf2JEUYdtGsp1l5CfGmSwyAZhm80Ut6kWbMBuEo
         gKzGMqswPgeGBe+nxdChoH+xpAkVKp//drtCjlfQ3DBxDyP2RRUMLTHrtYoa2stsQ+0Y
         h7ww==
X-Gm-Message-State: AOJu0YzWFfSNKM7+2wRx2OLoHXxls21giT7kLlbBiT52d6Y4AGYIuZRz
        hE0T0/Lzjuvr5tk3fAdXvN1/qg==
X-Google-Smtp-Source: AGHT+IHnCElvhjrz7ZJrHjNtJ31GOUgLq29EzBpHyKL8Ir+AdcbNQiYstFhuJeVysB7QpeLgwYuM6Q==
X-Received: by 2002:adf:ed41:0:b0:317:cdc4:762e with SMTP id u1-20020adfed41000000b00317cdc4762emr11427959wro.63.1692127443408;
        Tue, 15 Aug 2023 12:24:03 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id c13-20020a5d528d000000b003142c85fbcdsm18681305wrv.11.2023.08.15.12.24.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Aug 2023 12:24:02 -0700 (PDT)
Message-ID: <afefa654-4f9a-121e-7d1b-76d9dcd778f7@linaro.org>
Date:   Tue, 15 Aug 2023 21:23:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v3 2/2] Input: cs40l50 - Initial support for Cirrus Logic
 CS40L50
Content-Language: en-US
To:     James Ogletree <James.Ogletree@cirrus.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Fred Treven <Fred.Treven@cirrus.com>,
        Ben Bright <Ben.Bright@cirrus.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
        Jeff LaBundy <jeff@labundy.com>, Joel Stanley <joel@jms.id.au>,
        Arnd Bergmann <arnd@arndb.de>, Jacky Bai <ping.bai@nxp.com>,
        Jean Delvare <jdelvare@suse.de>,
        Eddie James <eajames@linux.ibm.com>,
        Markus Schneider-Pargmann <msp@baylibre.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        "patches@cirrus.com" <patches@cirrus.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230809191032.820271-1-james.ogletree@cirrus.com>
 <20230809191032.820271-3-james.ogletree@cirrus.com>
 <d1b9e063-54df-2dae-1487-c7c932fda145@linaro.org>
 <D4B53566-9F7D-46DA-8BAE-0572B9A8AA7A@cirrus.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <D4B53566-9F7D-46DA-8BAE-0572B9A8AA7A@cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/08/2023 17:56, James Ogletree wrote:
> 
> 
>> On Aug 10, 2023, at 1:17 AM, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 09/08/2023 21:10, James Ogletree wrote:
>>
>>> +
>>> +static int cs40l50_cs_dsp_init(struct cs40l50_private *cs40l50)
>>> +{
>>> + cs40l50->dsp.num = 1;
>>> + cs40l50->dsp.type = WMFW_HALO;
>>> + cs40l50->dsp.dev = cs40l50->dev;
>>> + cs40l50->dsp.regmap = cs40l50->regmap;
>>> + cs40l50->dsp.base = CS40L50_DSP1_CORE_BASE;
>>> + cs40l50->dsp.base_sysinfo = CS40L50_DSP1_SYS_INFO_ID;
>>> + cs40l50->dsp.mem = cs40l50_dsp_regions;
>>> + cs40l50->dsp.num_mems = ARRAY_SIZE(cs40l50_dsp_regions);
>>> + cs40l50->dsp.lock_regions = 0xFFFFFFFF;
>>> + cs40l50->dsp.no_core_startstop = true;
>>> + cs40l50->dsp.client_ops = &cs40l50_cs_dsp_client_ops;
>>> +
>>> + return cs_dsp_halo_init(&cs40l50->dsp);
>>> +}
>>> +
>>> +int cs40l50_probe(struct cs40l50_private *cs40l50)
>>> +{
>>> + int error, i, irq;
>>> + u32 val;
>>> +
>>> + mutex_init(&cs40l50->lock);
>>> +
>>> + error = devm_regulator_bulk_get(cs40l50->dev, ARRAY_SIZE(cs40l50_supplies),
>>> + cs40l50_supplies);
>>> + if (error)
>>> + return dev_err_probe(cs40l50->dev, error, "Failed to request supplies\n");
>>> +
>>> + error = regulator_bulk_enable(ARRAY_SIZE(cs40l50_supplies), cs40l50_supplies);
>>> + if (error)
>>> + return dev_err_probe(cs40l50->dev, error, "Failed to enable supplies\n");
>>> +
>>> + cs40l50->reset_gpio = devm_gpiod_get_optional(cs40l50->dev, "reset", GPIOD_OUT_HIGH);
>>
>> None of the lines above or below seem to be wrapped according to Linux
>> coding style (80).
> 
> This patch abides by the 100-column line length limit which checkpatch.pl enforces.

Checkpatch does not enforce 100, because it accepts also 80. It
complains if something is longer than 100, but coding style is still the
same. Format everything according to coding style and use 100 only if it
increases readability.

> However, I can see how some of the lines might be less jarring to the eyes if wrapped.
> That will be addressed in V4.
> 

Best regards,
Krzysztof

