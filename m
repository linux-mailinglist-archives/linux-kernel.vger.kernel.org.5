Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88BB180C560
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 10:59:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234669AbjLKJ7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 04:59:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234646AbjLKJ65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 04:58:57 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D9B5C5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 01:59:03 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-336210c34ebso808397f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 01:59:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702288742; x=1702893542; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+8ZYGpDqXB7DKk7WEUaqFLKAG8Tztk8Kini09NyiSQw=;
        b=Bq2xxpudojIRDR9Axi0Zynr7a6N+FxOhR+CodkBmuIwUxWsC5Mqy6G89z4y6zNenqX
         h9gJMuHnHtdyigi0qTPiSGZuch1h9w/0P88TxdCg6ModcHuIEvFolIERF+1P4a7GQlUF
         e4T93f9dKzpbqLH0p3vA3yWcLuDuGP3vjST83P/4rG+g3jBnKVopN9AYdYUfIfnUd0+M
         jSOYGr1pqBaPetfZy8JhQOqimavhkY7poLWsd2Tx9uROn1lCGCjn5spp8FKlJ9UkdqSa
         2Uf+PPHzkWvGOzv1pVmPowgn4uZzuWK1l2XgoW3HyKOVP6c3EuSRHuJ5gJFZct/pnJsY
         jCQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702288742; x=1702893542;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+8ZYGpDqXB7DKk7WEUaqFLKAG8Tztk8Kini09NyiSQw=;
        b=VAlT7CE2N2fgjAjeC3XTCjsfcdDMNfS1fKQUZErFJ/iUugDTFlr7JzS9yruWiw5gUw
         78F2X2vhU3WhYva2GmzXusF9nSZLJOVWsxQIMh6/CJiqcnKXrbaohTy/v2gxlScGlh6d
         D+paYY5kQQBRXjaMhpqPFrzQtLIJQuaJkezV6fyTvT3Xwb+geB0pTf72H/j9hCnAHHTE
         R+x36G+e+lMmhanzcc+kKRTUGB8AvDx9Ms55cOhBDaR+8H/KnuBC4gsysDah/1/Mn4oO
         nKqvxXOwTpG3F4rj6SJ8+X2R3/pW4tA4aOLZhNf6e6K3C9U5NYj5AySHYzaDAWqRDcxU
         CCBA==
X-Gm-Message-State: AOJu0Yya9ZBJ/xmsehsMWQ69XuEkPvrJyYc+5TyzvQUvFyYlyxn6E0SW
        MSZXpR0pZvAhDBgirnq6lqLd7dVdW7UzFrzWtps=
X-Google-Smtp-Source: AGHT+IH0EDdrIWl1aQW1z4Yjlt3s2DKMEUoxlEu8XgspXqBEWQPoRn+4E7spd9DDtbuNjgEnAgCdnQ==
X-Received: by 2002:a05:6000:1b06:b0:334:b160:7e00 with SMTP id f6-20020a0560001b0600b00334b1607e00mr1483847wrz.151.1702288741937;
        Mon, 11 Dec 2023 01:59:01 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id g12-20020adfa48c000000b003335eded7f5sm8206605wrb.68.2023.12.11.01.59.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Dec 2023 01:59:01 -0800 (PST)
Message-ID: <f61a9382-a2b9-44a8-a33e-4c4f8d6cae50@linaro.org>
Date:   Mon, 11 Dec 2023 10:58:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] arm64: dts: rockchip: Add support for rk3588 based
 board Cool Pi CM5 EVB
To:     Andy Yan <andyshrk@163.com>
Cc:     heiko@sntech.de, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <20231210080313.1667013-1-andyshrk@163.com>
 <20231210080629.1667589-1-andyshrk@163.com>
 <2b58450a-1bde-424b-ab69-a3834914522c@linaro.org>
 <14ab4c8c.4fa1.18c58488bf2.Coremail.andyshrk@163.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <14ab4c8c.4fa1.18c58488bf2.Coremail.andyshrk@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/12/2023 10:49, Andy Yan wrote:
>>> +
>>> +	backlight: backlight {
>>> +		compatible = "pwm-backlight";
>>> +		power-supply = <&vcc12v_dcin>;
>>> +		pwms = <&pwm2 0 25000 0>;
>>> +		enable-gpios = <&gpio4 RK_PA3 GPIO_ACTIVE_HIGH>;
>>> +		pinctrl-names = "default";
>>> +		pinctrl-0 = <&bl_en>;
>>> +		status = "okay";
>>
>> This is a friendly reminder during the review process.
>>
>> It seems my or other reviewer's previous comments were not fully
>> addressed. Maybe the feedback got lost between the quotes, maybe you
>> just forgot to apply it. Please go back to the previous discussion and
>> either implement all requested changes or keep discussing them.
> 
> Yes， it seems that the comments were lost， I didn't get any comments about PATCH 5 in my V1.
> Anyway, I will check this patch again, and fix the issue I find by myself.

I don't have to repeat the same comment for every same thing to fix.
It's your task to fix all occurrences of the same issue.

Best regards,
Krzysztof

