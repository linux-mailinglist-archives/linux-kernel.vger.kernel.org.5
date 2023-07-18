Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95DDF757617
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 10:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbjGRIBz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 04:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231810AbjGRIBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 04:01:34 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6983F268F
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 01:00:50 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-992f15c36fcso746527366b.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 01:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689667186; x=1692259186;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FxG/dgx1lJpw0Lc0GgA2hZzfp5EFCNWKYdqUEuovTVQ=;
        b=uwq1Bj9uJBZn+EMfsjTHtGo4gtCkN+HhVTk9FiB/tXndUT+0b/ZXAUsZNPjCdWHQMo
         CW+I3s7pNSJF0kQnvcKnRX0Eh7pTnJLZm6ZIHcDR8IZbUlNBJ5/GIoZIgtSUU7uSWm95
         7lpkEHTdVhBB+pLCtZfjKsGfUj8Hz474ZXpAkjZtArI6PxPqf+I4Pa8Fi3vHCJNTZLGi
         k1Yb+bPPnxN+GrfNuM+dMxHo+fiup7W+uOKOpZA/1IvqhSbwZ97CYXN7Vsg5ZLnQ7L2t
         LhIIDc3bgHhSF7w2ztNB/nLOc7aX9aRei0/J/AJqzaX3n9sWiWyiSgRKu4nk2EQc2z6K
         5B5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689667186; x=1692259186;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FxG/dgx1lJpw0Lc0GgA2hZzfp5EFCNWKYdqUEuovTVQ=;
        b=ZK5PaljhivQMza3rvWok7O2cWMCwv0qYj23B+40qI0QgquZK04a4UYJ4bzyTPNEy7k
         ysuECplNqpctFPkrAdEgZm8CwnGc4zx4m0Y8c5OadeVIDaHh/VtJxSCj9L4SIApiv9b0
         32rwg98S06JFSFYx6sfNIVHD4pgHC+sxLjTejp9sH1HQ+he8ZD8kRZS0LzSWhP6frgkl
         RkRAiOzz5gsQoh93wKZOtlMcNCdtjNSGPOwFjOTYbedgpIoeBxl9kb/vUXpvaibuJEyT
         yUmpV+dcgxT+g4XHhT0XN/qtRI8H925lQVXTqgGfC5BG0j/K1taNTZxa+FT6pb9gST3i
         DerA==
X-Gm-Message-State: ABy/qLZAarMwSBEFHmA3pYEkEl6Ph1we/UQI98XFzvuqLJArWLhFLntr
        VbNZE6ZqstkfsVfn8z40M/wRtA==
X-Google-Smtp-Source: APBJJlGvyotpbpSMeNWfrlnOSBa8BIfuSDUuHdp+6qgXvn3jbTe33GGd40wYCJJDEOYua3tnBBqsvw==
X-Received: by 2002:a17:907:310f:b0:991:e5a5:cd4b with SMTP id wl15-20020a170907310f00b00991e5a5cd4bmr11135118ejb.56.1689667186645;
        Tue, 18 Jul 2023 00:59:46 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id e21-20020a170906045500b0098cf565d98asm682840eja.22.2023.07.18.00.59.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jul 2023 00:59:46 -0700 (PDT)
Message-ID: <4287a5b2-698d-4c2d-46a1-4cdeb2ac28e6@linaro.org>
Date:   Tue, 18 Jul 2023 09:59:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH net-next 1/2] dt-bindings: net: snps,dwmac: add phy-supply
 support
Content-Language: en-US
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        peppe.cavallaro@st.com, alexandre.torgue@foss.st.com,
        joabreu@synopsys.com, mcoquelin.stm32@gmail.com,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
References: <20230717164307.2868264-1-m.felsch@pengutronix.de>
 <a34ef1ed-e204-77ba-a4b1-1a4bbabdac7a@linaro.org>
 <20230717165724.juh77dr4nmoxoehq@pengutronix.de>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230717165724.juh77dr4nmoxoehq@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/07/2023 18:57, Marco Felsch wrote:
> On 23-07-17, Krzysztof Kozlowski wrote:
>> On 17/07/2023 18:43, Marco Felsch wrote:
>>> Document the common phy-supply property to be able to specify a phy
>>> regulator.
>>>
>>> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
>>> ---
>>>  Documentation/devicetree/bindings/net/snps,dwmac.yaml | 3 +++
>>>  1 file changed, 3 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
>>> index 363b3e3ea3a60..f66d1839cf561 100644
>>> --- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
>>> +++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
>>> @@ -159,6 +159,9 @@ properties:
>>>        can be passive (no SW requirement), and requires that the MAC operate
>>>        in a different mode than the PHY in order to function.
>>>  
>>> +  phy-supply:
>>> +    description: PHY regulator
>>> +
>>
>> Isn't this property of the PHY? Why would the Ethernet controller play
>> with a supply of a phy?
> 
> Because this is the current state. Please check the all other MACs
> handling the phy-supply (if supported). Some of them handling it under
> the mdio-node (not the phy-node) but most bindings do specify this on
> MAC level (e.g. FEC, DWMAC (suni, rk)).
> 
> I agree that the phy sould handle this but this would be a lot more
> effort and since the dwmac-sun8i/rk bindings do support this on MAC
> level I would keep it that way.

Indeed phy bindings do not allow a supply.

Best regards,
Krzysztof

