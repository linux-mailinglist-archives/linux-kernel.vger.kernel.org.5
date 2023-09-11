Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13D0F79B5A1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233826AbjIKUwb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 16:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236994AbjIKLtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 07:49:47 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22B24CDD
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 04:49:43 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-31dd10c2b8bso4250265f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 04:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694432981; x=1695037781; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7uTE277R9IUMWfpcxvhVYcRRY/+i4lXQdoTCf3ndW5s=;
        b=t6Wi/J03+QMNMqFU13HnVUdBpoX65x6JdV8UeKZGz5mgA6/D2MJdYB1kuZX/tjO1Pv
         DCyz+oSoTjYMC2jCcEqFxQatUqe2HQTw/X1UnuRJmE8eHLEcDLRtsIVdl5e56Yh0M0lq
         +SVp3JPEQ6YrOkU0MpRz9K6wqVlHmzkWdLRc4KnnavlDx5WRc3jBxmuzrsZ+53RSFVGt
         JYPBDvtuQr9QnUGP+Qp7CiFnqOyug8LVEhdMFhKd7Bc8OIXI6Bz05hYL+nipncUrnq79
         5lSwq1wn1RujgAjVhUb6ky/dvihQeXX1Oav2rLvpDRPBUdxePgp4XgdnQZEwds2s2j5P
         HzvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694432981; x=1695037781;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7uTE277R9IUMWfpcxvhVYcRRY/+i4lXQdoTCf3ndW5s=;
        b=IkWs3XKLdUmmJwSaKUP1ywT6rgyAbCmdQsFXIze4qYBQAaCucdEwZLDBDS+/bZPn8q
         cDrCeo8OSnn0hFSc8cBpIjAw+Rjc3SfLkBdftN7wF8ONrccexilfAnCxjAOLZQ4FB8Uu
         6Poufyz6taNpsaixjqL+nS8eVdOQ0evSLQGPVpit7hLal3OYOJ4FlVWtCmoUUiIGAqQ3
         A/Ubckfd8C7yg9zy2DI6thn0NZpG7MQIHAUA3ZorpWXfkF4nhKzUWekvjptY8CuwCdNG
         4/oDHu6Fy1rKkTEIfBl+CtVreGuADk8DKvLeH6OHCyU3AvQBDYEOUcKXR8Jjw8QzYFk1
         K/Rg==
X-Gm-Message-State: AOJu0YwfXsuTv87TCNz5DNYQlRa2GeiqW3rwSfhHK/aD7JOPaaLYpiHg
        wZ3wpK05LR5rUEvZKS0nkjL5xw==
X-Google-Smtp-Source: AGHT+IHLnKxjUB/zLnPuoIMc1DDrZGTbUd7F4GSTdG7pPu1CvVlKzmeIQ604ecyru6GcFidOBOTjFA==
X-Received: by 2002:adf:ef8d:0:b0:319:6e6a:66e with SMTP id d13-20020adfef8d000000b003196e6a066emr8388505wro.14.1694432981598;
        Mon, 11 Sep 2023 04:49:41 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id u24-20020adfa198000000b0031f8a59dbeasm6957022wru.62.2023.09.11.04.49.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Sep 2023 04:49:40 -0700 (PDT)
Message-ID: <c4d89d97-f8d4-da2e-dea9-6c054cf07eb3@linaro.org>
Date:   Mon, 11 Sep 2023 13:49:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [RFC PATCH 8/8] dt-bindings: display: panel: add Fascontek
 FS035VG158 panel
Content-Language: en-US
To:     John Watts <contact@jookia.org>
Cc:     dri-devel@lists.freedesktop.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Chris Morgan <macromorgan@hotmail.com>,
        Jagan Teki <jagan@edgeble.ai>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230911090206.3121440-1-contact@jookia.org>
 <20230911090206.3121440-9-contact@jookia.org>
 <e22e61e7-02b1-8127-888d-e470838f4a18@linaro.org> <ZP7il27e9cExVWaL@titan>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <ZP7il27e9cExVWaL@titan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/09/2023 11:49, John Watts wrote:
> Hello again,
> 
> On Mon, Sep 11, 2023 at 11:41:12AM +0200, Krzysztof Kozlowski wrote:
>>> +maintainers:
>>> +  - John Watts <contact@jookia.org>
>>> +
>>> +allOf:
>>> +  - $ref: panel-common.yaml#
>>> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
>>> +
>>> +properties:
>>> +  compatible:
>>> +    const: fascontek,fs035vg158
>>> +
>>> +  backlight: true
>>> +  port: true
>>> +  power-supply: true
>>> +  reg: true
>>> +  reset-gpios: true
>>
>> Why do you need all these 5? They are allowed by panel-common.
>>
>>> +
>>> +  spi-3wire: true
>>> +
>>> +required:
>>> +  - compatible
>>
>> Missing reg. Probably also port.
>>
>>
>>> +  - power-supply
>>> +  - reset-gpios
>>> +
> 
> I have just copy pasted the other panel's yaml, so these issues apply
> there too. Should I fix that panel's yaml up first then re-copy?

If the other panel has exactly the same case, then yes, you can do like
this. But it depends on the bindings - to which ones do you refer as
your tmeplate?

Best regards,
Krzysztof

