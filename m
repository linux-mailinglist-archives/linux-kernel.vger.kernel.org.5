Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0C07AC3C3
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 18:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231991AbjIWQnI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 12:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbjIWQnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 12:43:07 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96A1E139
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 09:43:00 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-31f7638be6eso3712000f8f.3
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 09:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695487379; x=1696092179; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+ehvNyN1e8AcFsIaExWpUQQDC3O+XNhpuGUxABDsT1k=;
        b=lALM0hrH6G8U0itn2oxf/5bl9yJrYy/mxuWfwwu4bThd/Y0W4jdFammsnQws6Tl9jE
         lbUOik+LiMhJBqAoMZxLGDWneqF5Z9IUSa3FuwkCpGCpClONvAdXQ2CQ+YaAt+ERZ6oF
         4gKixWuh1kXSD5gCn1h/SzTiu/PX6uAQ72RzZrMohFOzajmSaZPpR2PaqoTUoCr28T8y
         pBGc1uvl3U2n6PsyGYsFMz+DuasCytfQvFaxxV+hiHu3oeNBLS8KQ8ygER49JlGo4n/4
         /UZOew1zTG+XnLdbsgTc61uNSVHC4zmbGSxkDiWHL3ucvL+7xETcjWv+zcbLCuVj039s
         stbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695487379; x=1696092179;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+ehvNyN1e8AcFsIaExWpUQQDC3O+XNhpuGUxABDsT1k=;
        b=r0qp/4wS31TFUwV0Yxc2gA9RQ2+inuwjhiM2FfxTOf+QMePgd2xvnyW07/3lg6h/5A
         Jyyioa1v1y/Io9TYBbZXcAytjQjluWkII1Fo1kDS+GaTEKU+Pj2i/oa+rnkkc4xcR6BX
         uilLToy1yzyXrPMmABAXQ4JXH/4dYRzcBXw5UkP1DRTnsC5XL7QFggSiFZUIlEWueH8J
         AoxAS2cZc7q9iYDyOyczpB00MUQLOF6jIilU1v7BIyZhSQxpDjf3h1QokLElwOFP3Wxr
         XEJpRhbZ5i6eYJSKwOHMD797UwH5palmsmJ9W5XQuE90e+2Aqv7mRBq6+BoFMSaebv09
         wkWg==
X-Gm-Message-State: AOJu0YzAb/ILx6UqoTGZK5AJIilPPPHlrDqBUp6XRDiJEfdcyWdY0Din
        8/81wH05WhUt7zVIQUH0usfJHg==
X-Google-Smtp-Source: AGHT+IHeYkcu/RtMUX5lf2uTUiwk5whv3Kim5HQRxv8v4Wkt6ThO4w/ApV1UJK2BVwSR7UZ8q2JpuQ==
X-Received: by 2002:adf:ea84:0:b0:319:6327:6adb with SMTP id s4-20020adfea84000000b0031963276adbmr2170369wrm.70.1695487378995;
        Sat, 23 Sep 2023 09:42:58 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.100])
        by smtp.gmail.com with ESMTPSA id x10-20020a05600c21ca00b004051b994014sm10434968wmj.19.2023.09.23.09.42.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Sep 2023 09:42:58 -0700 (PDT)
Message-ID: <4fdfe29b-aea7-8180-d2e3-5caa1beb7232@linaro.org>
Date:   Sat, 23 Sep 2023 18:42:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v6 02/16] dt-bindings: media: mediatek: mdp3: split out
 general properties
Content-Language: en-US
To:     Moudy Ho <moudy.ho@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230922072116.11009-1-moudy.ho@mediatek.com>
 <20230922072116.11009-3-moudy.ho@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230922072116.11009-3-moudy.ho@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/09/2023 09:21, Moudy Ho wrote:
> In order to minimize duplication and standardize the document style,
> it is necessary to separate the general properties specific to
> MediaTek MDP3 RDMA.
> 
> Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
> ---
>  .../media/mediatek,mdp3-rdma-common.yaml      | 72 +++++++++++++++++++
>  1 file changed, 72 insertions(+)

I don't understand why this is a separate patch. It's not used, not
effective and not visible for us how it extracts common parts.

Best regards,
Krzysztof

