Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DCAF7609F5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 08:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbjGYGD0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 02:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231931AbjGYGDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 02:03:23 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC75A10E7
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 23:03:21 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-51de9c2bc77so7273471a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 23:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690265000; x=1690869800;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gKw/y6xbJLHLrKoOqib8wE6g0TwzZr90wRZOEpTA+QM=;
        b=dNI26837h7Z5m0NpSRAEvJuTHCMrt52ddpJT/KP/SmM9gS2AlifEtXu8hfCiII80+6
         MOzZ2S8PMgpT/gp6fSkvkiiyWvp/Ob0Qr8Sb0f9Bt38bWZc+Sd1mnZnpeTVYnaEzm153
         3oJpljLbO/50dSg3zUfiZJVDMRAtYvknwId3JkXsAqFs94btqf1LvEkUAt9GDAMX7cr1
         GQshODgEtvdIe7IcWgTl9i1pC6HQzSDG4HkBINIVJtlDnWsZJ0vJ91IEeahD0ZKolSHz
         oWVc3FZ6WQ9MCIilIDA9k5BVW1NJTPM/VyoK+fLAFMPVWIKVcEynBMqshK5ILAUNtHeF
         ih6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690265000; x=1690869800;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gKw/y6xbJLHLrKoOqib8wE6g0TwzZr90wRZOEpTA+QM=;
        b=LlHiN4W4YidySiuxPVoVjUbr7XY1oHGwcvrzca6cFO20VCtQZXB4R3bTuL0OdbhCUe
         6PMLpg1ZTxmXpVSsMJrvjPyfNf0RQusXm3JUasezQQvsoHbPLDqjWyPgXsXNNgkM35E+
         qQWbU7A3bfuf0GhtCqa4CNeV7Ctm0mYeZ4Dg/khuZ1Br1YT8h63RJFfyy+/JyLE+hduL
         bTY4XIJ9LdI6EQykg3SXe1ZM3crl7JLRVLuyonRwdZkzhbODbb57c6HooOuLk/YxLk8o
         NU9NRFo5in0mC8gMD4quWmJit3JJOJqMUs4NRMPTs/KcfAHA5qS7SK5nSuQutqZvbsaJ
         b2HA==
X-Gm-Message-State: ABy/qLZ1oK66dPw7u29U1HE3v2dypKQ38njX5cONF0ZBnJKzabK5Fzui
        H8T+iZi+/ZQiB5SCQ1+STSpOOg==
X-Google-Smtp-Source: APBJJlEP7l6qFTgow+ggwKiOot4c+RCyryVYPqohvTQF/Ys7TpoCWLWFPrROZM2D/IBUsQ0xpJczzw==
X-Received: by 2002:a17:907:a070:b0:993:da91:6e0c with SMTP id ia16-20020a170907a07000b00993da916e0cmr11275219ejc.3.1690265000364;
        Mon, 24 Jul 2023 23:03:20 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id a6-20020a1709065f8600b0098ec690e6d7sm7723489eju.73.2023.07.24.23.01.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jul 2023 23:02:14 -0700 (PDT)
Message-ID: <db7ffc4b-54c5-6f54-51ae-03479576f2b8@linaro.org>
Date:   Tue, 25 Jul 2023 08:01:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 1/3] dt-bindings: arm: convert nested if-else construct
 to allOf
Content-Language: en-US
To:     Nikunj Kela <quic_nkela@quicinc.com>, sudeep.holla@arm.com
Cc:     cristian.marussi@arm.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20230718160833.36397-1-quic_nkela@quicinc.com>
 <20230724164419.16092-1-quic_nkela@quicinc.com>
 <20230724164419.16092-2-quic_nkela@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230724164419.16092-2-quic_nkela@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/07/2023 18:44, Nikunj Kela wrote:
> Nested if-else construct is not scalable therefore, convert
> it to allOf:if-else.
> 
> Signed-off-by: Nikunj Kela <quic_nkela@quicinc.com>
> ---
>  .../bindings/firmware/arm,scmi.yaml           | 55 +++++++++----------
>  1 file changed, 27 insertions(+), 28 deletions(-)
> 


Suggested-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

