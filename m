Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3206799DC4
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Sep 2023 12:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346621AbjIJK5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 06:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbjIJK5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 06:57:10 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFC99CD3
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 03:57:04 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-501bef6e0d3so5713348e87.1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 03:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694343423; x=1694948223; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NHuepiwfpiT5E2m84O/h2coQFZ+OoqbWElsLLeZ4r84=;
        b=nojQzmAXQvH5QclV0iztyq1J1kKeCe/qlHUQQC9b+MuR7CyxbLuXJ37QJnjzyMrkJ6
         o4W2utBtiE2gtx2rp8IgCYEdgtmVQjhsq/VDtQ9dFc5YOGZilvuUXPnREsrZQbbWW6Ai
         KFQsE+EeTh3uRyNEBP9E3Y+DQxKbrn+i4L0FSxZl/aZCTd5GJoV6CURYCyfX2qolGbv9
         R0RLsivuX8YY8YfsLyFbPcxxYtkMlTU6VmQRzuSYsAfW/EU+wNdRQQ+HAm8NQNAig7VB
         SntxvsoLlAJaVyJWtPhJigLFOFD5aIXUw4mmVLC0r/W528Ima9/0ezldsqyJkxPf8QCQ
         3i4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694343423; x=1694948223;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NHuepiwfpiT5E2m84O/h2coQFZ+OoqbWElsLLeZ4r84=;
        b=ENIkgvRx/e2CVQNgbvJqoxh0e457SsipZEGdfrayif0oMUpk42tT3tVFtwYis6aWNA
         zbD5NP7YqtxO1wD7OW5lfiXEJMhntTIcMtQrd9eRVQfeNNvic1w+Um9tkjPZG+ESOsBA
         XoE5EjnJjA+Cz84XKW/mLQED8cEaInF0MBE/thA/42gf9BP6riiudFl0K7caQ6vsUHYP
         XTB2YAfdjLgKNxhSuBa7q7J6qs3r89v1DFnU6Dh4eAF4aWNMkg5PIckzpRK6YNiDVoy1
         /yhs1GmBWKx4qHYwSqVtYj7NqZosU4xHDZv/8p28gVuXU5I5Vg+LR6EP1PywCHE1mUHA
         Ezrw==
X-Gm-Message-State: AOJu0Yy8TXAvQHuI69FsKRH2tnKmmXP/TX53q4eCD8RPfbvn6IDX+FNi
        Fc+L1AQOWRrZ42W2PdasXn7UCQ==
X-Google-Smtp-Source: AGHT+IENYOcIOKUXqh4Gp3/XzUedAb32p3g3zQAcg4rTgFr6JX7zn+UYrGyIuCNVk7/QwuvbUY26uQ==
X-Received: by 2002:a05:6512:14a:b0:4fd:d470:203b with SMTP id m10-20020a056512014a00b004fdd470203bmr5440584lfo.69.1694343422475;
        Sun, 10 Sep 2023 03:57:02 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id va17-20020a17090711d100b009929ab17be0sm3628305ejb.162.2023.09.10.03.57.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Sep 2023 03:57:01 -0700 (PDT)
Message-ID: <2318be3d-5687-8b6c-3669-1d2ae1c94d2c@linaro.org>
Date:   Sun, 10 Sep 2023 12:56:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v5 1/2] dt-bindings: arm64: dts: mediatek: add mt8395-evk
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
References: <20230909132819.21626-1-macpaul.lin@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230909132819.21626-1-macpaul.lin@mediatek.com>
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

On 09/09/2023 15:28, Macpaul Lin wrote:
> 1. Add compatible for MT8395.
> 2. Add bindings for the MediaTek mt8395-evk board, also known
> as the "Genio 1200-EVK".
> 
> The MT8195 and MT8395 belong to the same SoC family,
> with only minor differences in their physical characteristics.
> They utilize unique efuse values for differentiation.
> 
> The booting process and configurations are managed by boot
> loaders, firmware, and TF-A. Consequently, the part numbers
> and procurement channels vary.
> 
> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Confusing. You just sent a patch changing the same hunk - adding
description, without any explanation.

Best regards,
Krzysztof

