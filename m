Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3615E7DDC19
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 06:14:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344818AbjKAEWG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 00:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236299AbjKAEWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 00:22:03 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BBCDB7;
        Tue, 31 Oct 2023 21:21:59 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6be1bc5aa1cso6521529b3a.3;
        Tue, 31 Oct 2023 21:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698812519; x=1699417319; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pZje7TQ/ZEluQMkAlttorTMy20pqANNs00Qqi1mxzH4=;
        b=VsDiDbBhoedvNfWpJ9FsnKT8DqpS+ni+TFuW5dk52S2iijrMNvrBHBUHDV/0Ze18vA
         fcQlG9LezqvzrP/pXx1fi/SLaEoOrTSJEJtNHVFgLwztiElmc/Jrt4Ob46OfFU21c/rH
         8kfEM4x2NEn/c0mMfTQTqAgZ8MC1vKwZTUGjLhI3Jg9HXbHcEW/zGQeZqwGsv+MN1h35
         x48EhOHSHp3kVQ1keOpSfezyYBj/YsDgMwesi66A0yzw3GGj1CXK8AWFPwe8PJqUuDPl
         dAdXZ6pshHDf+rgCBc1Tu5+nzE4z+Ik1xvbgsCQVqQPDY+JzHHKH1unfsdRd0hgHtGXi
         +FDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698812519; x=1699417319;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pZje7TQ/ZEluQMkAlttorTMy20pqANNs00Qqi1mxzH4=;
        b=KBbhv2FqTk5aiRsZ9RHKWvxyeCSlu7DAG4CVtCebhETcWi34V41ipsrwjRiLMX1j0K
         dJqpl38HU6MfZtdxSKfpfws9jYhMYZJs3CHAuTgE4MGXsZN4xiIiulAuiwjOu4LR7WSg
         31Cl6kuCjmQedSgFL2S87PZd8THtW/07x4ZTQY574nlHWhIV8JPpNg/dpaXK3XzKBO7f
         iROSEoMjXSN6NI/BUO4XKWP6pmhTdVCBN1sU+npnSb6+gIGSbE1XaHAdlYquBKCB4Ff6
         sfiY7gw4tD/uhIPMbJSxsuO485zwo18J9lo1OL/HXD3rogEaa8oFRJ9pNqO1LqwLUa/0
         WolA==
X-Gm-Message-State: AOJu0YwdhtdRbIGlgXgwKnBsid+pNdngAFw/D1iheO8qSQqzDBXl6KKv
        WvoMKwHDFGl1ejATR58t6T8=
X-Google-Smtp-Source: AGHT+IFycs4ynpzgQCPJVIe0gKegH/PB1KIR2pxRM17SEbyyGsItILd2fM9wQxVYG4+KE+aVya45YQ==
X-Received: by 2002:a05:6a20:1587:b0:15d:b243:6131 with SMTP id h7-20020a056a20158700b0015db2436131mr18156809pzj.44.1698812518745;
        Tue, 31 Oct 2023 21:21:58 -0700 (PDT)
Received: from ?IPV6:2401:4900:6274:7b8d:58b:47c1:d32d:b04a? ([2401:4900:6274:7b8d:58b:47c1:d32d:b04a])
        by smtp.gmail.com with ESMTPSA id m11-20020a1709026bcb00b001c5eb2c4d8csm354261plt.160.2023.10.31.21.21.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Oct 2023 21:21:58 -0700 (PDT)
Message-ID: <152d15c4-10bb-45fe-9b9c-b323535a921f@gmail.com>
Date:   Wed, 1 Nov 2023 09:50:36 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/2] input: joystick: driver for Adafruit Seesaw
 Gamepad
Content-Language: en-US
To:     =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Cc:     =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jeff LaBundy <jeff@labundy.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
References: <20231027051819.81333-1-anshulusr@gmail.com>
 <20231027051819.81333-2-anshulusr@gmail.com>
 <d1dd2142-546f-42b7-8966-ab75fd4f8817@t-8ch.de>
 <efea5ae2-7e41-4b78-a283-1f907be560b0@gmail.com>
 <9c9f6171-f879-46f5-81d2-6764257a49eb@t-8ch.de>
From:   Anshul Dalal <anshulusr@gmail.com>
In-Reply-To: <9c9f6171-f879-46f5-81d2-6764257a49eb@t-8ch.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/31/23 07:53, Thomas Weißschuh wrote:
> Oct 31, 2023 03:10:50 Anshul Dalal <anshulusr@gmail.com>:
> 
>> Hello Thomas,
>>
>> Thanks for the review! The requested changes will be addressed in the
>> next patch version though I had a few comments below:
>>
>> On 10/27/23 11:44, Thomas Weißschuh wrote:
>>> Hi Anshul,
>>>
>>> thanks for the reworks!
>>>
>>> Some more comments inline.
>>>
>>> On 2023-10-27 10:48:11+0530, Anshul Dalal wrote:
> 
> [..]
> 
>>>> +struct seesaw_button_description {
>>>> +   unsigned int code;
>>>> +   unsigned int bit;
>>>> +};
>>>> +
>>>> +static const struct seesaw_button_description seesaw_buttons[] = {
>>>> +   {
>>>> +       .code = BTN_EAST,
>>>> +       .bit = SEESAW_BUTTON_A,
>>>> +   },
>>>> +   {
>>>> +       .code = BTN_SOUTH,
>>>> +       .bit = SEESAW_BUTTON_B,
>>>> +   },
>>>> +   {
>>>> +       .code = BTN_NORTH,
>>>> +       .bit = SEESAW_BUTTON_X,
>>>> +   },
>>>> +   {
>>>> +       .code = BTN_WEST,
>>>> +       .bit = SEESAW_BUTTON_Y,
>>>> +   },
>>>> +   {
>>>> +       .code = BTN_START,
>>>> +       .bit = SEESAW_BUTTON_START,
>>>> +   },
>>>> +   {
>>>> +       .code = BTN_SELECT,
>>>> +       .bit = SEESAW_BUTTON_SELECT,
>>>> +   },
>>>> +};
>>>
>>> This looks very much like a sparse keymap which can be implemented with
>>> the helpers from <linux/input/sparse-keymap.h>.
>>>
>>
>> When going through the API provided by sparse-keymap, I could only see
>> the use for sparse_keymap_report_entry here. Which leads to the
>> following refactored code:
>>
>> static const struct key_entry seesaw_buttons_new[] = {
>>     {KE_KEY, SEESAW_BUTTON_A, {BTN_SOUTH}},
>>     {KE_KEY, SEESAW_BUTTON_B, {BTN_EAST}},
> 
> No braces I think.
> 

Since the last field in key_entry is a union, the braces seem to be
required.

>>     ...
>> };
>>
>> for (i = 0; i < ARRAY_SIZE(seesaw_buttons_new); i++) {
>>     sparse_keymap_report_entry(input, &seesaw_buttons_new[i],
>>         data.button_state & BIT(seesaw_buttons_new[i].code),
>>         false);
>> }
>>
>> I don't think this significantly improves the code unless you had some
>> other way to use the API in mind.
> 
> I thought about sparse_keymap_setup() and sparse_keymap_report_event().
> 
> It does not significantly change the code but would be a standard API.
> 

Thanks for pointing me in the right direction, do you think the
following implementation of the API is acceptable for the driver. Since
I couldn't find a driver for any similar device using the API in this
manner.

inside seesaw_probe():

err = sparse_keymap_setup(seesaw->input_dev, seesaw_buttons_new, NULL);
if (err) {
	dev_err(&client->dev,
		"failed to set up input device keymap: %d\n", err);
	return err;
}

inside seesaw_poll():

for (i = 0; i < ARRAY_SIZE(seesaw_buttons_new); i++) {
	if (!sparse_keymap_report_event(
		input, seesaw_buttons_new[i].code,
		data.button_state & BIT(seesaw_buttons_new[i].code),
		false)) {
		dev_err_ratelimited(
			&input->dev,
			"failed to report event for keycode: %d",
			seesaw_buttons_new[i].keycode);
		return;
	}
}

> Thomas

Best regards,
Anshul
