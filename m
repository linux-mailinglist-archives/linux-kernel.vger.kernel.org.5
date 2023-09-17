Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1849A7A36D2
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 19:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237400AbjIQR2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 13:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237657AbjIQR1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 13:27:45 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB156135
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 10:27:30 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-991c786369cso505543766b.1
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 10:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694971649; x=1695576449; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HdLBqJ1/XBZxRf4JQ6QvBAuMVxo4MYCMdG9pNveKSiA=;
        b=v9KV4x3G+LeuKb7bsRNfpYo2nplPvatnfJwMLjQ+tSPROh6olEZsjIrwmv1tbWNxEm
         avbsqtMpvTIwgjdkzTXGB8i3/s7eJEfP0UlZ/HQ/5MmcgHkOX51Nrray197W0Lsj8iBl
         gDPlkm09UDyKXg6hfg2TBoYK3cZMKs0hzzxwM941nrYzEFagpOGynZGoIAlkPK+/Gas7
         pPi5Wo0n6F+ISeKcSPziB8HSxahj8o9G8hVt7WOXclNPRvUgJZ3JI8A7hP4VXeg+hLbD
         BmScDK7tHZl93LgzORI7R1l9bHWejTR9+0Ur6Y+9lRx5L8ophYml5OSvBjdAfkZYjmAy
         BSKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694971649; x=1695576449;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HdLBqJ1/XBZxRf4JQ6QvBAuMVxo4MYCMdG9pNveKSiA=;
        b=EPphYqy5s132n4KBSO0pocTKxHmd9u7idz/4Qaseik3quU0Ax+YJXv1gEnxlcLUZqX
         u0g2qrEjg0ofzQ6o99Xov7jo54UyBlcvqoOalIakcL6atY2P0zROjde0WFLtdCyzjdRt
         CVPdZFRWq8031fHXn+BtCv6QAZLwJH/5oIxjtbgWT7BVqIQ4TVoZFX3Sgtqwl3u9QdGj
         ZrEjmmxOuQv+j3DREEeD/9X02ZaNtJfC+w/shUbw2eUEoxuX4PGB8VYBMOJD0a3q7QVp
         kAUFVvjIv6IGYd77wajoBhjb1hW/jy5Ap8Ypsm9sWt50LQsJC0OraUYdqvsL+9VZYSdV
         79Cg==
X-Gm-Message-State: AOJu0YxW/iItNb9UfxEoCzvU3G4i7JIUHkXEZI2wFHv3+We+R+Jqipsu
        p1/c0+Qy1xEBo/5KWzZnGSk+gQ==
X-Google-Smtp-Source: AGHT+IFvLcVJHbKnJlIYkn714MsmrQLEWS8puQ0wzl+wdIBovDhjTwyXM1eo3dRPJJU+qBDTjCJvgA==
X-Received: by 2002:a17:906:224b:b0:9ad:786d:72ae with SMTP id 11-20020a170906224b00b009ad786d72aemr6039067ejr.75.1694971649429;
        Sun, 17 Sep 2023 10:27:29 -0700 (PDT)
Received: from [192.168.1.77] (150-140-187-31.ftth.glasoperator.nl. [31.187.140.150])
        by smtp.gmail.com with ESMTPSA id rp9-20020a170906d96900b0099e05fb8f95sm5203102ejb.137.2023.09.17.10.27.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Sep 2023 10:27:28 -0700 (PDT)
Message-ID: <6e163f4d-061d-3c20-4c2e-44c74d529f10@linaro.org>
Date:   Sun, 17 Sep 2023 19:27:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 1/2] Documentation: dt-bindings: media: i2c: Add ROHM
 BU64754 bindings
To:     Kieran Bingham <kieran.bingham@ideasonboard.com>,
        linux-media@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20230915165946.4183839-1-kieran.bingham@ideasonboard.com>
 <20230915165946.4183839-2-kieran.bingham@ideasonboard.com>
 <22bc83c7-17c3-f8a0-b1de-5d6b2e1e29b2@linaro.org>
 <169494678738.1922990.10472250640303677004@ping.linuxembedded.co.uk>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <169494678738.1922990.10472250640303677004@ping.linuxembedded.co.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/09/2023 12:33, Kieran Bingham wrote:
> Quoting Krzysztof Kozlowski (2023-09-17 10:37:07)
>> On 15/09/2023 18:59, Kieran Bingham wrote:
>>> Add YAML device tree bindings for the ROHM BU64754 VCM Motor Driver for
>>> Camera Autofocus.
>>>
>>> Signed-off-by: Kieran Bingham <kieran.bingham@ideasonboard.com>
>>> ---
>>
>> ...
>>
>>> +properties:
>>> +  compatible:
>>> +    items:
>>> +      - enum:
>>> +          - rohm,bu64754
>>> +
>>> +  reg:
>>> +    maxItems: 1
>>> +
>>> +  vdd-supply:
>>
>> If the supply is not required, how the driver gets any power?
> 
> It may not be controllable. It could be wired to be always on.

That's different. You talk now about board, I am talking about device.
Is the supply required for the device? If yes, then it should be
required by the bindings.

> 
> The device has a low power mode which is controllable by software, so it
> could be always powered on and controlled via software only if desired.
> The driver handles that already as if the regulator isn't specified the
> power down register bits will be set to put it in low power mode.

Best regards,
Krzysztof

