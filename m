Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7107B79E02B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 08:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235799AbjIMGmw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 02:42:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231510AbjIMGmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 02:42:51 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA0DADA
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 23:42:46 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-401da71b7faso75076075e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 23:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694587365; x=1695192165; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=luACkZMQYaAff8AQJIHA/Ls5QqC1rb9Wh8NKaWNzkDk=;
        b=Ol0I1DXPnlOE3venSKf8Si2jBXMLs2NLYHCfSj2hf/3lXETMHay8RXNBPfwiR5ncdl
         lREIwZZTzLUA8XzNR2qOUQ/tBUONayG/vlugCIQOka8sVdd53m1ibeLsRG6mV9WfRYpl
         Ed/EvvStpFfOhfYn6YrUy6hKSlJCd7Lke5KDrRExSx9mBEhpsUprsxMMvV8IAQGT1eyr
         JFcVru+YERJBzkQhincouf5Hv2mj4na1P1g+yB5YLb6w1K6xqyAav3TOenIqMLkM6EHp
         x2ON/xi+Ux5uMaXa5wiUUR+toT0Hl0u/WvWEXO/nbUvImofzSO7E6/A4TDfsIRYqSbVo
         mUiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694587365; x=1695192165;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=luACkZMQYaAff8AQJIHA/Ls5QqC1rb9Wh8NKaWNzkDk=;
        b=sOa2hR9zjurV68YHKFUU3NAnubgTL/hivpJ4i7Ge+u554ZVCkpjaraI9qA/qJjcLE3
         15Sk4B5KW9GyKfjRYHq68bkdw+Q729syGDRWQjXWCGx5N/1HPBXWVKNbw5Ur70KrrH/h
         xMRmQ+dNVLoDCvFUgvXQ8xcjOpNIj/IYhE7dvaqfUGKsDkEQGXbzXMzaw2afVKD2aEAF
         sLWHW1vam+E0GwRYxqILZLDppgSWp4+SZ3k3pfztu0fFe0UmQNk48RIg2tnqSQP0SXk/
         2w3zzwZUwCzacvpQWxlq8B/Q03Vcsju+1IPtZldPyr1p8PJ6AFkzQ3V70+LHjVj/Kh/c
         O18A==
X-Gm-Message-State: AOJu0YxBZ+5KWfJwybTS2A1NmbCVyKkuTguOq4Ym5sqg2qjEnHqVM5e0
        u/vXa/Gst62KNjR9gSOsjflIEg==
X-Google-Smtp-Source: AGHT+IEAIxQH5qvSmuuETYLt+QKKyHAu3o6+POI2RoUl/25iI03HCsIv5WiySXLmuGaNLQvvl6o5UQ==
X-Received: by 2002:a1c:7210:0:b0:401:cbf6:e5cc with SMTP id n16-20020a1c7210000000b00401cbf6e5ccmr1291026wmc.22.1694587365204;
        Tue, 12 Sep 2023 23:42:45 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id l17-20020a7bc451000000b003fe29dc0ff2sm1043821wmi.21.2023.09.12.23.42.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Sep 2023 23:42:44 -0700 (PDT)
Message-ID: <be7d9ab7-9559-3f22-cc07-6fc3e018ef37@linaro.org>
Date:   Wed, 13 Sep 2023 08:42:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v2 1/2] dt-bindings: arm64: dts: mediatek: add mt8390-evk
 board
Content-Language: en-US
To:     Macpaul Lin <macpaul.lin@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?Q?Bernhard_Rosenkr=c3=a4nzer?= <bero@baylibre.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Cc:     Bear Wang <bear.wang@mediatek.com>,
        Pablo Sun <pablo.sun@mediatek.com>,
        Macpaul Lin <macpaul@gmail.com>
References: <20230913040449.29560-1-macpaul.lin@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230913040449.29560-1-macpaul.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/09/2023 06:04, Macpaul Lin wrote:
> 1. Add compatible for MT8390.
> 2. Add bindings for the MediaTek mt8390-evk board, also known
> as the "Genio 700-EVK".
> 

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

