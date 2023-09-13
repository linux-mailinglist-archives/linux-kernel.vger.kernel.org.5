Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BFE279E049
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 08:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233257AbjIMG6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 02:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbjIMG6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 02:58:34 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60523173E
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 23:58:30 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9ada2e6e75fso38911466b.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 23:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694588309; x=1695193109; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gksMP3dK4wn2DN+b9H7lk6Rn6eIYazmOrqq6HYNSCKY=;
        b=xG6rvjh77+3nB3ZIxATyUZWPng+frA2mWRR03zED6J9ebA/MP2KmR5TPIXa5ZDgYpu
         8iz8u/fsD3kviw9j60xzGtuN1z3CGjUvYaD6CMlV1ctF6K+0zgEr11G8d9bZjMe3yeaC
         8l8t5TdYT9Jn1l/9UNUNazCikNjym2oM5/oLVmdtiN+TFEXeHKqp1L6NeTOy5H+xd0zi
         hGjU5UlzItxB5kwDwtiMeqRra13Ja8fKeuVzjL/3sBwwDOOC3ZY1DoDc3B3nfI143I++
         aFuL2gWNZqatyrbBZ6LZF807lShW/muEh3Bep9imodt3R5bijMLMMV5zw3JspHTUey9o
         DBjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694588309; x=1695193109;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gksMP3dK4wn2DN+b9H7lk6Rn6eIYazmOrqq6HYNSCKY=;
        b=P4PhM1nXiWm45lkW125lBKnrQHZ6ty7OFLutafWWyP0EJVpPGr3hWiSIRgp3zg9gBq
         BNDFKb311LnC+ByDn8EiXVhtUU8nFosZHfP6BxfUiHJyLs2Ag+gNTPln/ntEqlX9Q+sx
         Tdppy4rSv+AYi2eM+V4me5iQXAjW7Rr/W7s1q8lBEXMW54Cv8WKdDE5h8lXPlWaCQhUu
         vB7MKxvQcENqy+c+XablBJ3ZnQSupUL5f27iwGHfec/PsT1K5BLTTWo2WGBR9ZuW9ueW
         rxWVJcWjvuqGRTw2wuGQhH4KBU9SJEWZWufqzJ66JoZBbQ47mqbQgq0N3EJ6zURypFNM
         31eQ==
X-Gm-Message-State: AOJu0YwNYXYQSR7QZb/mzMOQqH9RF4uQGbdbbU4pcL80gA0lO8tzOKsd
        UPps/dsx3+DT9ONtq87zHZzbRw==
X-Google-Smtp-Source: AGHT+IHcnx3ReFLiLWludwupXN06aZgy6qjBtw6dUTISD1hUkXhOPqvhWes/iIH3f9Gbyv4kr1kGTw==
X-Received: by 2002:a17:907:2cf5:b0:99b:de31:6666 with SMTP id hz21-20020a1709072cf500b0099bde316666mr1013675ejc.22.1694588308855;
        Tue, 12 Sep 2023 23:58:28 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id d22-20020a170906371600b0099297c99314sm7872303ejc.113.2023.09.12.23.58.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Sep 2023 23:58:28 -0700 (PDT)
Message-ID: <ed2fe299-d8d1-4dfc-72ea-5e86a69b9f5c@linaro.org>
Date:   Wed, 13 Sep 2023 08:58:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] ASoC: dwc: Add Single DMA mode support
Content-Language: en-US
To:     Myunguk Kim <mwkim@gaonchips.com>
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        conor+dt@kernel.org, devicetree@vger.kernel.org, fido_max@inbox.ru,
        joabreu@synopsys.com, krzysztof.kozlowski+dt@linaro.org,
        kuninori.morimoto.gx@renesas.com, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, perex@perex.cz, robh+dt@kernel.org,
        tiwai@suse.com, u.kleine-koenig@pengutronix.de,
        xingyu.wu@starfivetech.com
References: <644e3564-994d-0b51-7d58-dac6afc1e0ec@linaro.org>
 <20230913064306.1862804-1-mwkim@gaonchips.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230913064306.1862804-1-mwkim@gaonchips.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/09/2023 08:43, Myunguk Kim wrote:
>>> This is not dependent on a specific vendor, 
>>> but is intended to describe 
>>> the properties of the signal(single/burst request) connection 
>>> relationship between i2s and dma.
>>
>> How does this relationship depend on hardware?
> 
> When designing a SoC, it depends on the RTL and Bus connection.
> My company has two types of configuration SoC: single and burst 
> to meet ASIC customer's requirements.

Then it is specific to SoC, thus can be deduced from compatible.

Best regards,
Krzysztof

