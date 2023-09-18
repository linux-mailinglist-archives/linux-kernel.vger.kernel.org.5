Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 354047A4939
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 14:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241877AbjIRMHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 08:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241903AbjIRMHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 08:07:05 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBC9D191
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 05:06:25 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-530c9980556so2226438a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 05:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695038784; x=1695643584; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aumliCM8GUMBUS2SEdLGQ85Th+kHvEeQ+AEeZe5dib8=;
        b=N20TjYg6asMzJuXiW6gamB2XeFvdb38cr8PLB4IXFLK9kTyL4QdPwLoACockk3UdIE
         N9JTtJPAhD6TGRDN31oUFh6QcE12Us7ieciLtBJzElTOQQTDPob177iH4wg0vj170fg8
         jCHxUvF9BF/HIFLYFXNJgSkosoL0EB/U8I9BPJjyCRtP7X1kn8iw5Jlk6adjgJCgUysT
         J/3Zqg5dYfeZ7cgevvkRwgNV0wHhheIAnqHjATCslaj9ILZ9YhAdJha/OO6nN29LOAQc
         PjldruwmgbGSI+J/MmD9qPyC63wqPWI9PBDQfJvUlni9G8iSssYEIEF9pyg0WcPe2FPq
         0vKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695038784; x=1695643584;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aumliCM8GUMBUS2SEdLGQ85Th+kHvEeQ+AEeZe5dib8=;
        b=ou76QZK+heEDXqE0Y4F37K140TDZeSsYEFCASpuzK8wb+EzWRFEMwFdL2m8+eCSHEZ
         gIn8Ue+ryijmpQEXVotm0ak7OVowz09zS8OFYyXzfIB5iZwr6eykpwha+5+XjWV9zrjI
         NfNf0QykXBaVV0AkEpG8bZsxOEpn7PERTKEqqTn9pX3Kn1QC5UVNwcHDiZ2qY1ojtdov
         m6rxxAXucUeL7GRlP9zvSneTC/tyfUdDauJXqx5naWRw7kgvfEmZqXB3yW99qdpzkn+e
         jpphGJppY/J0JUxPhbGH9U53Sd5kaZOs7H0iFnSI8C8ar9hM5yT+DBbH8UoxjHXKFBc3
         ledQ==
X-Gm-Message-State: AOJu0YxHjetba21Lc/iMtkIwNIOZEWn4Cpa8F61jclT7Gd/M5ME1Rq/q
        GIqTFAGVDfaf5/m80RzbOZ4fDQ==
X-Google-Smtp-Source: AGHT+IF5uZI+RrO4UyOx4conpZwE0U5Px/QCIg8MSJ51Cyg3pLAceDda5BuKxe/6jm0PrW80qcEXBg==
X-Received: by 2002:a17:906:2255:b0:9a5:d972:af43 with SMTP id 21-20020a170906225500b009a5d972af43mr7668013ejr.65.1695038784221;
        Mon, 18 Sep 2023 05:06:24 -0700 (PDT)
Received: from [172.25.80.114] ([217.67.225.27])
        by smtp.gmail.com with ESMTPSA id sb4-20020a170906edc400b00992b8d56f3asm6357088ejb.105.2023.09.18.05.06.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Sep 2023 05:06:23 -0700 (PDT)
Message-ID: <837865e5-739e-72c2-140f-2299e9ae03ae@linaro.org>
Date:   Mon, 18 Sep 2023 14:06:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
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
 <e22e61e7-02b1-8127-888d-e470838f4a18@linaro.org> <ZQdgeA5tQA4xK5qL@titan>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <ZQdgeA5tQA4xK5qL@titan>
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

On 17/09/2023 22:24, John Watts wrote:
> On Mon, Sep 11, 2023 at 11:41:12AM +0200, Krzysztof Kozlowski wrote:
>> Missing reg. Probably also port.
> 
> Hello again,
> 
> I've been working on v2 of this series and done some initial cleanup.
> 
> Right now it looks a bit like this:
> 
>> allOf:
>>   - $ref: panel-common.yaml#
>>   - $ref: /schemas/spi/spi-peripheral-props.yaml#
>>
>> properties:
>>   compatible:
>>     const: fascontek,fs035vg158
>>
>>   spi-3wire: true
>>
>> required:
>>   - compatible
>>   - reg
>>   - port
>>   - power-supply
>>   - reset-gpios
> 
> Does this seem correct?
> - reg is required by spi-controller
> - port is listed in panel-common
> - power-supply is listed in panel-common
> 
> I'm guessing that the required section just lists the minimal
> properties needed for this specific device tree yaml?
> There's nothing implied by allOf?

Ah, then it is fine.

Best regards,
Krzysztof

