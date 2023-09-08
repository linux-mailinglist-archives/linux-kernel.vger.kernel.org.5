Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 818207983B0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 10:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237766AbjIHII6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 04:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbjIHII5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 04:08:57 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DBD61BD3
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 01:08:53 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9a63b2793ecso222902766b.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Sep 2023 01:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694160531; x=1694765331; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IQZHnhIZueeFWlG/6gHerorkeeQAur+H/2aVbpZmvCw=;
        b=kYXMTyHBemdUCiBPuPqiW9BDj9YOQyJ+RAQJ7LjB6p5QZda7JE6DsHOCTB/LqVCucy
         HOpXku7BAPy6+CapGZjZ1zFJWxvT8cJdkZ9ammJu8qF+zf7lqda+QDDLuyxEjxrnaIqw
         sLoiu2LqO1S6zf5liQvKG7Bvtehosmzv1lCOoa4LbY7BR9KZBHVpIJtpBR2DmPoAlA4T
         e9VOtpQJcspvT8bs/DiFLN5Udp9UEUvkz7cK33vcsXpHjGnzN0/xMHS8KEG1ALi/FYGM
         hVn03rDUrPfCbBUi5jo3Fcwv2W3PCzxPtrsLuMexcD5Ha8Hd96UeIz3bZhXDFK1wPhrp
         bh0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694160531; x=1694765331;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IQZHnhIZueeFWlG/6gHerorkeeQAur+H/2aVbpZmvCw=;
        b=wdURQLTiPnDfy9t4A0uS+en9hAnYOKy/GFgYUC3Kq2HbWdwnIUmPJ0ccuBCNs6wlJw
         lQwiIjgrji9aM2m/MPrpGHrR88ntBZjN7QfyPCPbmoyvh8Ori6e5Bc+L1JL4twIS9swG
         AGX73pKgZQryOi1/EwRreR72gAA+JefW2wtZvWd9v71p57/WbNe1isW3bMZJVnvooJiM
         ErCxgtBcl7sUq7SxjSjjTE9NTbAisB0CYHQGfn10aH6tKxwsYqHumr9x3T0UTa5zggim
         BQf9yyze7YQzrjjrSl6HIV/L7EwayR5CNoC/W193ZmZDm+389xzhsxt0rAKVy6W5mct1
         4jjA==
X-Gm-Message-State: AOJu0YzedT3tFRC79wVKpHrCKPj7LRhm4ywIsOeuzUENxd1D1/0ve9NF
        tem9mGU1hkL/t0sRgYpOyefJwg==
X-Google-Smtp-Source: AGHT+IEz/m/mf+xS+5mWjpYpEQIPMWRT8M2mJFROODVg68FRYe/B0GQhkEA5DF+QoaHz2BO9s7VOxQ==
X-Received: by 2002:a17:907:a04d:b0:99c:6825:ca06 with SMTP id gz13-20020a170907a04d00b0099c6825ca06mr1305878ejc.12.1694160531482;
        Fri, 08 Sep 2023 01:08:51 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id w26-20020a170906131a00b009a1c4d04989sm659396ejb.217.2023.09.08.01.08.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Sep 2023 01:08:50 -0700 (PDT)
Message-ID: <1547a3c7-72ba-a7cc-fadf-5e5299e0b52c@linaro.org>
Date:   Fri, 8 Sep 2023 10:08:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 1/6] dt-bindings: firmware: document Qualcomm SM4450 SCM
Content-Language: en-US
To:     Tengfei Fan <quic_tengfan@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        tglx@linutronix.de, maz@kernel.org, lee@kernel.org
Cc:     robimarko@gmail.com, quic_gurus@quicinc.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_tsoni@quicinc.com,
        quic_shashim@quicinc.com, quic_kaushalk@quicinc.com,
        quic_tdas@quicinc.com, quic_tingweiz@quicinc.com,
        quic_aiquny@quicinc.com, kernel@quicinc.com,
        quic_bjorande@quicinc.com
References: <20230908065847.28382-1-quic_tengfan@quicinc.com>
 <20230908065847.28382-2-quic_tengfan@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230908065847.28382-2-quic_tengfan@quicinc.com>
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

On 08/09/2023 08:58, Tengfei Fan wrote:
> Document the compatible for Qualcomm SM4450 SCM.
> 
> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

