Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5079877125A
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 23:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjHEV2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 17:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjHEV2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 17:28:14 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 652251732
        for <linux-kernel@vger.kernel.org>; Sat,  5 Aug 2023 14:28:13 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-99c1c66876aso445571366b.2
        for <linux-kernel@vger.kernel.org>; Sat, 05 Aug 2023 14:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691270892; x=1691875692;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YtvPFDgNfswzHbL9qZOfB9rynxww/q/6ud2abj7JbK8=;
        b=VBr1Tb2Yiq8ob/mIUdpgau2IXz/a4XSV3JZYXD2ka5lshkTHgYMMnfeu+Wi+wYptdY
         XxHAlNQKRzztww2vdyP1MzdGv91rkagFUdEpuPcFWhjk4vp4SP104X8I4vRrHXbyhzb4
         LAtnnnh1cXMn6XyTHzYk6GCyH+/PMcJKYaDRf+STugC++6g3IjQ7jAs8v8dfO7ETlx2W
         Uqpk94z7925PbcEvvObZjWSehVJoohlwhbvGmv3bowNIrJId0epMQWA1+uYxis68ZMiC
         51IeXwxTZXS6XgpSpzOKP8IdJ/uuA52RHgeJ9lcUHNCxcCXf07AWQMBx4EENjZSUOj3O
         sBiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691270892; x=1691875692;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YtvPFDgNfswzHbL9qZOfB9rynxww/q/6ud2abj7JbK8=;
        b=F/tQUYoIF5siW9ciT4jlQH3f48NB4ueWTInGLsZ0cva7SgBnh9fgmUBq311FwOM7yQ
         larzsJtPr//c8lBU2ukEv5FdSnrBwZXTvNNKSbclAfCORIZzFCAtWQKRPJR9WPOhLu+4
         dpOhpNDTxuvliHqIydiK73XtJo/XtQdrQCC9kzCAOCyS6vc4enAUdIciKvH1xOnoW9fT
         p9GnwfNtrhHg+uCWdONhHMEH2sRCiZetHh3tGB9LJ/h1ngkSZtJck0LFDuaZFUoX2zXY
         ndcY370HmxoJ5b2tJoNwcGCugobZuK0rI3XbYHpVG7z8woI2cJF0v2Fj//QotREhF5Cv
         cBsw==
X-Gm-Message-State: AOJu0YytA+zxP+TjzCh1NPDGQnYs0u9c2fOKfAWAnouX96ly0goNTK/L
        KJHDKthfW4WQe56mRGuxIVEK8A==
X-Google-Smtp-Source: AGHT+IHa0zbQ+TdzVyNT6lxjGsGVE+BO2rJENfvHS6LbnRHDe5htn1ss+4jVmDEzb3LDRH9bKxiPZg==
X-Received: by 2002:a17:907:75f8:b0:98e:2b00:c509 with SMTP id jz24-20020a17090775f800b0098e2b00c509mr3926313ejc.30.1691270891919;
        Sat, 05 Aug 2023 14:28:11 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.245])
        by smtp.gmail.com with ESMTPSA id f8-20020a170906560800b00992b7ff3993sm3082361ejq.126.2023.08.05.14.28.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Aug 2023 14:28:11 -0700 (PDT)
Message-ID: <b1972443-926c-bc80-e665-df3827aa1115@linaro.org>
Date:   Sat, 5 Aug 2023 23:28:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v6 1/2] regulator: dt-bindings: rtq2208: Add Richtek
 RTQ2208 SubPMIC
Content-Language: en-US
To:     Alina Yu <alina_yu@richtek.com>, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <1691034645-11595-1-git-send-email-alina_yu@richtek.com>
 <1691034645-11595-2-git-send-email-alina_yu@richtek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1691034645-11595-2-git-send-email-alina_yu@richtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/08/2023 05:50, Alina Yu wrote:
> Add bindings for Richtek RTQ2208 IC controlled SubPMIC
> 
> Signed-off-by: Alina Yu <alina_yu@richtek.com>
> ---
> v6
> - Add "additionalProperties: false" to regulator node

With or without ChiYuan Huang comment on regulators subnode:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

