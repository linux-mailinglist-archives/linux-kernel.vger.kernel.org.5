Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CAC1774963
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 21:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbjHHTx7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 15:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231668AbjHHTxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 15:53:45 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 293AE13945C;
        Tue,  8 Aug 2023 11:03:59 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fe2ba3e260so57075665e9.2;
        Tue, 08 Aug 2023 11:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691517837; x=1692122637;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3PeSe/GO6oNsx5WYr31WDuJ/pxid985m44XnUTfQZDY=;
        b=raYj3mFjJsVhqvQ2f6HG1Vqk1ialYg9hZ0Sl14PNuTYzOhaWbxr7fsByS81K/vP4zz
         4zD/2v+WpXJoh3wbm1o7iLY513lrSL/KxTJmqOTsmpoXNyhoXYPTsYMTUohiYtSJxHB1
         w0UTeruOXN54m6UqHXHpkFZc2XuEv8CxUPQ88Q+ESs0MA502075bcGrTkOMJ4y63uDbQ
         j/YX070Ud7/NHXUxLUmwolZT6oACdPScPmgT5CuR6iupKcW8l6bMlPexVG/lBBcs8rSj
         v3gzl8cgYk4/Suob6BnNcgKfRUtwNoLNFVqaLkJr1RN9A35hss37i71N0SMbO4qEMRVG
         dSew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691517837; x=1692122637;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3PeSe/GO6oNsx5WYr31WDuJ/pxid985m44XnUTfQZDY=;
        b=I+tuAMHBU4jFpowlJw5VO/TiU5ddNQseIRziiAJbZwV++WGKhCO5KBk/FdE5ZX208b
         uFu2n2j07YmN599KAR0N06QJsrJHCPwvu7dzNsIx9ZV0KEUgE1slgKArE2FBzplchvfw
         r9RRjoGVmYxTHpAJxkeLo77mO1KYTNweE2CQUYVN7iR8rK1KXkmllOnYdoz9niiayVuv
         nkkCHh+hkhj2WMJpFhhXI0Ok7ts4ejiBnez+p1zGSF7aBpibTZfvRa9Zm5pAeI99gYCz
         3juAj3Z9yYw0uUsvcubLLTyfwtp/duH7cFv11wu3XxxFQfmTGrBFgL+1ysdvWVexr3FA
         JG9Q==
X-Gm-Message-State: AOJu0Ywv4navyIZGNheLI0cwtYdJp2+Xwk1epOZEAlLqKqEEB6WKOgwH
        zCAoD3gOlF3589rSC6n0LLqY7oki6oU=
X-Google-Smtp-Source: AGHT+IGx8qpA8w2DCmIxsFRx1ZOpbeX44oV+zA8r9kZ2Jq+OZ4V6CmfzvpDQTtZ+ULkzH9Mu8g7QLA==
X-Received: by 2002:a05:6512:310c:b0:4fb:2c1e:4e03 with SMTP id n12-20020a056512310c00b004fb2c1e4e03mr6752682lfb.32.1691477570248;
        Mon, 07 Aug 2023 23:52:50 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f8:1500::5? (dc78bmyyyyyyyyyyyyyct-3.rev.dnainternet.fi. [2001:14ba:16f8:1500::5])
        by smtp.gmail.com with ESMTPSA id h25-20020a197019000000b004fe1fc5d0e3sm1752524lfc.206.2023.08.07.23.52.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Aug 2023 23:52:49 -0700 (PDT)
Message-ID: <8410ca04-71f1-ab16-76b9-0ebe07065a15@gmail.com>
Date:   Tue, 8 Aug 2023 09:52:48 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] dt-bindings: iio: rohm,bu27010: add missing vdd-supply to
 example
Content-Language: en-US, en-GB
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230808063223.80431-1-krzysztof.kozlowski@linaro.org>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20230808063223.80431-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/8/23 09:32, Krzysztof Kozlowski wrote:
> Bindings require vdd-supply but the example DTS was missing one.  This
> fixes dt_binding_check error:
> 
>    Documentation/devicetree/bindings/iio/light/rohm,bu27010.example.dtb: light-sensor@38: 'vdd-supply' is a required property
> 
> Fixes: ae8c47c51e5c ("dt-bindings: iio: ROHM BU27010 RGBC + flickering sensor")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Ah. Added supply to required ones when you pointed out it should be - 
and obviously didn't fix the example :/

Thanks a lot for fixing it!

Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

