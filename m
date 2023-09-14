Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44B1279FBB1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 08:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232741AbjINGMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 02:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbjINGMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 02:12:05 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BCB4F5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 23:12:00 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-400a087b0bfso5619815e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 23:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694671919; x=1695276719; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2a/PHWqxsvCjYvw/PrGstkPwApGUDTH1LI40pfCDPVU=;
        b=WyH8FAFbkA33GCBtaxJNxOd3NtHQfvMjpBVZLBhH87u4tT32p54ddHDYsL33JRrYZk
         iVAo3kxs/4SXHUuDgqZuWZSA/A7EtSZ9LoTbFz1tAItuoEVU8M9MNXAiCabW3dZWFQUh
         Ax8jKOkNqWBgboFrIvP6FaG85PHCZ4Ae01UR4bVd1rLlLV7wt8aNywNnzKybYPx+bfJh
         Vf/uI3NRbxQQvp5un2THZGjNKB8BKNjpzpaaMmXMyJji1pUWeSJGice5Fz9HOjpKEVD3
         XwxGkRJQ4aRFL42uLIt0HVyR+8ZKRIAwgzyH4PVvO3s7RfdMInLOw3Hu1NeC1w4a5OQl
         s86A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694671919; x=1695276719;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2a/PHWqxsvCjYvw/PrGstkPwApGUDTH1LI40pfCDPVU=;
        b=C4GFl3Xy6d0YW4B66kCXQZmWjeGzBJbUgk7WDHln7r+aqHW91C+TWcEPIp/iC0jk4Z
         F6J0dOryfOaotjfPsC4j8XsdbJ8Crv6zOojF+L5qNWIna92qhGW2kVlf6TiW5Z9pWAka
         bVo3uAj5betoKYAqDMVQi3LkF4OlN6JeZT1rDDc/tKaw6LIJvWn4cfge69jS8ExBWNxp
         AFYC9q3lEL07GhPr5Sf1aDyL94luU1BKpinqv5OMM+eI54GdVpniOcikF+viCdpkjatn
         7kgY6/rC2H3luNJukIuwRFor74aJGJ34daI3mwbIDQ5y2UrDa+D8hN8lgeJtv/x8UmfC
         FKkQ==
X-Gm-Message-State: AOJu0Yy+XuuteMI5s/IM/vh26RXawmfWArpfFYMCUKjIJG7fCHKpHBmx
        YLfClXNqrIiit/xgnejH5TBfVw==
X-Google-Smtp-Source: AGHT+IGw6rLBiZ/VZp782H6iiBB72aJIj5bR1ullvx8HbEIzsNDjz5tNRHSmEU1mgTSDc50+cIZokQ==
X-Received: by 2002:a05:600c:204c:b0:401:db82:3edf with SMTP id p12-20020a05600c204c00b00401db823edfmr3487074wmg.39.1694671918950;
        Wed, 13 Sep 2023 23:11:58 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id c20-20020a7bc854000000b003fee6f027c7sm3840112wml.19.2023.09.13.23.11.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Sep 2023 23:11:58 -0700 (PDT)
Message-ID: <f4dc58b3-b721-3081-6fed-66976b694217@linaro.org>
Date:   Thu, 14 Sep 2023 08:11:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 1/2] dt-bindings: arm-smmu: Add SM7150 GPU SMMUv2
Content-Language: en-US
To:     Danila Tikhonov <danila@jiaxyga.com>, will@kernel.org,
        robin.murphy@arm.com, joro@8bytes.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        dmitry.baryshkov@linaro.org, konrad.dybcio@linaro.org,
        quic_saipraka@quicinc.com, quic_bjorande@quicinc.com,
        a39.skl@gmail.com, robdclark@chromium.org, mani@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230913184526.20016-1-danila@jiaxyga.com>
 <20230913184526.20016-2-danila@jiaxyga.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230913184526.20016-2-danila@jiaxyga.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/09/2023 20:45, Danila Tikhonov wrote:
> SM7150 has a qcom,smmu-v2-style SMMU just for Adreno and friends.
> Document it.
> 
> Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
> ---

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

