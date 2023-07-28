Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 685B1766DC0
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 15:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236613AbjG1NAl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 09:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235890AbjG1NAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 09:00:38 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B8F3ABF
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 06:00:35 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-3177163aa97so2181104f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 06:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1690549234; x=1691154034;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YRiix5Wbu8cUEwewXZbHXypVIH/8I/HGpsd1Ld0zKcA=;
        b=uHTsjZTdPbQOhN2xXT6vdB0e9iO2q8OEekgi3R6Xo0vBRxfuKAXOdM3HXC2odGRF6g
         5kH+wW4g1ClRUuR8clAablsRloAM2bbpa9geV5YCXqHdwwC5Ukq2oCs2TF+/zkAT/QQr
         TzlOqqsX4DFI+O0mCYWL76K/Km7TOj96/J4JfrcaOHHN6C+pjBhJxtT90ZZILcP1gsyt
         5eZHOG+BeJxR8jz9RpVGayWNNxlXU1KpLdNIoM4/nIdlSX73xh3G4E54Q6n4dQKRnh/P
         Rciqu/UaxuYOfL4tfruaUs+27zxYNsTJfKLEhmWxYGce3PoXcwg4MWJ+v9E1kj/ak/RP
         K1Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690549234; x=1691154034;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YRiix5Wbu8cUEwewXZbHXypVIH/8I/HGpsd1Ld0zKcA=;
        b=XY7HOyXUwzCrQPF+qOIHcQxLqHTrn1CusLAGsNiNSknIwmDfinV8VrZ/+xiR27YMPK
         zASEuNO4G/AyB04Q6mGjNTFPOsIbW25PLq1WB8SsJKL+xdKUG1oZ5Y99WKwwJKfrOAgT
         QRlOrFTd7M6DyU155cB0W8tuL7OyoHZ2wRZeZN0oDsMZc5m46fGR4uk9GmbUWS/zgPRR
         4+4QNNNz4XG/SLI77ToCeBH1u6lsNHapb+kiJpzCUZBrj7z6AM16fuOSxELnPsRwonHs
         F5sEzZVumsnGB7jyh2Nn5TGfzFBFUTRKtVyJaISCvXZWp74D107mqK2zAkwtBHefTV8o
         Us+Q==
X-Gm-Message-State: ABy/qLb77x3wKhGyCTK9eL+zxFzAGLzseGViGmkcmsuWHqt5E0u7NJjO
        nav/n77Tj+4IcqLEDKb9LXcKGQ==
X-Google-Smtp-Source: APBJJlGf644aS69IfHiGjdU78DPSh3l7c3O8DBAe3QaqLPykUWVJ56ZWmKuFuzDN/9JXfQ8Mwtgj9A==
X-Received: by 2002:adf:f009:0:b0:306:2e62:8d2e with SMTP id j9-20020adff009000000b003062e628d2emr2022404wro.1.1690549233876;
        Fri, 28 Jul 2023 06:00:33 -0700 (PDT)
Received: from [192.168.1.172] ([93.5.22.158])
        by smtp.gmail.com with ESMTPSA id l18-20020a05600012d200b0031753073abcsm4756456wrx.36.2023.07.28.06.00.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 06:00:33 -0700 (PDT)
Message-ID: <550b9775-e11a-7481-4b4a-0f4512d3bd26@baylibre.com>
Date:   Fri, 28 Jul 2023 15:00:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH RESEND v6 03/11] drm/mediatek: gamma: Support SoC specific
 LUT size
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, chunkuang.hu@kernel.org
Cc:     p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch,
        matthias.bgg@gmail.com, dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, wenst@chromium.org,
        kernel@collabora.com, ehristev@collabora.com,
        "Jason-JH . Lin" <jason-jh.lin@mediatek.com>
References: <20230727094633.22505-1-angelogioacchino.delregno@collabora.com>
 <20230727094633.22505-4-angelogioacchino.delregno@collabora.com>
From:   Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20230727094633.22505-4-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>

On 27/07/2023 11:46, AngeloGioacchino Del Regno wrote:
> Newer SoCs support a bigger Gamma LUT table: wire up a callback
> to retrieve the correct LUT size for each different Gamma IP.

-- 
Regards,
Alexandre
