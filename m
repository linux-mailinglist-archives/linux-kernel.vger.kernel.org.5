Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0982579C0FD
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355312AbjIKV5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243069AbjIKQr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 12:47:26 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FA5EF1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 09:47:20 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-401c90ed2ecso50510735e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 09:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1694450839; x=1695055639; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=MLi2NYLPm6QlVeP45t3wgNfRYbdJeJf3EXFD0UEeti0=;
        b=kG+c+hskCaJPO0tlisFVyDres3F0rVFxb0AsajmbY9A3iSJie6puebauGp0NYIM8Qt
         JgU2dB501+Lp9x08fFDRq478Mva3PFnqIExB9/UG0PYeBgVTmsKBAuQk4cf42hd/W0Tz
         gjbzJ7Yh7jR3YviNal1+sIvDkhWW0kPIz73c/PmuDV6NvIYcFylq9cjBmzpVV3dMnAJh
         DSYqRu2ILejrqHrWLRYQDcD5eNsQt2HuaL9E7TweaOvKXz1vcW23AVpSWDRMhggux99x
         chqoZRmeLe1mlaqtU5D1SS7CvCWcMqvxRNkaL0LMggxK0j0cLdffn46Dc1ToN9EiVjS2
         m2pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694450839; x=1695055639;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MLi2NYLPm6QlVeP45t3wgNfRYbdJeJf3EXFD0UEeti0=;
        b=ZozAa/7KIzFKJsUCsLbBr7XBDjCfdIgNoAm6QC926m9Q2ySrS1HxXA/fV9wvi/zm/3
         qXXlXBAIQ5KX8x8hIo6GNN0qxLG2m6XsDWh9HEna0WaJiMusHffCFt9/En4FFElKnfZ7
         zrzaIATUOD344FrqDJgW/gm0xb9YXwVaTbiIEFz8e66nooWztGKuwvp6yIHoJBS4tqzV
         HUyUu4lCAk3zoURTdf1j/3uUqoeFfYFN2Cd/fGiDLgnInYeIRK5G68mZDsuP7Fuu6jMH
         wvQB0biHkboi36Z7lLd5Fp3CkjQGAIdvjHD9ljZnsJEJ0faDMWKtZb//+j107WVzloEU
         9D2Q==
X-Gm-Message-State: AOJu0Yxe0FWtB5nOqPQJWT0cEoUQzBi3IM1awaGRpbHJI+2v0hK55/g1
        mAEJVVRmCcIJ8IlLC3Rp+Zjpsg==
X-Google-Smtp-Source: AGHT+IFkb0O/V7HCO+aYY6YxoLwvjjcsYi5plgGFEpi6ITWRePKQPNfgLMXwdf+kEXJSlctGXSdMlw==
X-Received: by 2002:a05:600c:214d:b0:3fe:ba7:f200 with SMTP id v13-20020a05600c214d00b003fe0ba7f200mr8179098wml.20.1694450838602;
        Mon, 11 Sep 2023 09:47:18 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:55be:8f7e:5f59:7ed1])
        by smtp.gmail.com with ESMTPSA id m23-20020a7bcb97000000b003fbe791a0e8sm10507045wmi.0.2023.09.11.09.47.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 09:47:18 -0700 (PDT)
References: <20230808100746.391365-1-jbrunet@baylibre.com>
 <20230808100746.391365-2-jbrunet@baylibre.com>
 <20230810231748.GA1543958-robh@kernel.org>
User-agent: mu4e 1.8.13; emacs 29.1
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Da Xue <da@libre.computer>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: usb: add device for Genesys Logic hub
 gl3510
Date:   Mon, 11 Sep 2023 18:46:24 +0200
In-reply-to: <20230810231748.GA1543958-robh@kernel.org>
Message-ID: <1ja5ts4pyi.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu 10 Aug 2023 at 17:17, Rob Herring <robh@kernel.org> wrote:

> On Tue, Aug 08, 2023 at 12:07:45PM +0200, Jerome Brunet wrote:
>> Add gl3510 USB 3 root hub device id
>> 
>> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
>> ---
>>  Documentation/devicetree/bindings/usb/genesys,gl850g.yaml | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>> 
>> diff --git a/Documentation/devicetree/bindings/usb/genesys,gl850g.yaml b/Documentation/devicetree/bindings/usb/genesys,gl850g.yaml
>> index cc4cf92b70d1..a7e7142651f8 100644
>> --- a/Documentation/devicetree/bindings/usb/genesys,gl850g.yaml
>> +++ b/Documentation/devicetree/bindings/usb/genesys,gl850g.yaml
>> @@ -4,7 +4,7 @@
>>  $id: http://devicetree.org/schemas/usb/genesys,gl850g.yaml#
>>  $schema: http://devicetree.org/meta-schemas/core.yaml#
>>  
>> -title: Genesys Logic GL850G USB 2.0 hub controller
>> +title: Genesys Logic USB hub controller
>>  
>>  maintainers:
>>    - Icenowy Zheng <uwu@icenowy.me>
>> @@ -17,6 +17,7 @@ properties:
>>      enum:
>>        - usb5e3,608
>>        - usb5e3,610
>> +      - usb5e3.626
>
> Should be a comma, not a period.
>

Good catch, thanks a lot

>>  
>>    reg: true
>>  
>> -- 
>> 2.40.1
>> 

