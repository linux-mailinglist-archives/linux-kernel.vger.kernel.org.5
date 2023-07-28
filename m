Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0035766DBC
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 15:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236424AbjG1NAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 09:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236360AbjG1NAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 09:00:12 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 341E13A9A
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 06:00:08 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3fbc54cab6fso21323235e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 06:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1690549206; x=1691154006;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dcKLSf6eqeHNfF6j88elstYU7E8m3+v2pua4wp1GvKY=;
        b=Id2I/uZXCxhGf9uU5JGy2ExbghV75fhZ6VryidaP0Rm4p/HFiINjNvsZTqW+TTwG6E
         xj5V3JZ8OvvX0HZw97ct2sh03vk2b3UBBfYXsNgjdUlYMN6aAsT3fWCOjrnUIoVyUViR
         0/ippRm7XO4dhfIKpj4S7ygUnn/CIaj8OnC+DUUfs2s/qReboPkYT8Hroxqep3LqWTkP
         d8+C3wL3wehXODPOj2iuqhos8FMdR2Wz4RWw3oy78kdyHYjuth5tSYTbp03kmyoANkad
         /gTZ3QWuAJhDuLbXwsMGXRgr5MqfvF/wk9VdiXKr7u1uaoQRWsSUR5rDm5xGgQ9cl0iS
         MxPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690549207; x=1691154007;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dcKLSf6eqeHNfF6j88elstYU7E8m3+v2pua4wp1GvKY=;
        b=fzbTHIGi3ibpz6TdLH5c4yTzixq6dfuRxgro0OsN4L4/xIJ6Dr0VxoYcfXzgKOF1xT
         C6BPixfs5xKEJgz6m7PLHLpVSWp/olyuP4g09SvbsJYpxldHroXkg6m4l0VjcymI86ru
         6kNnN09tZptSrnxARzRwVYqFmz6UfO+wDzSPJ6K2iyrFxABZkmbEA8/PXLWeXy98p3he
         nonp8Xge7XPFutHgSYaqeJGrW5/apvtU2h3vt8fI3kqLKqn5OwR89oWHDMN7FcNuKXi8
         msOEzObw3EtmXhtwLrEQ6XYqMfz+imwhj3txdzkVg3zQMArFzTpNbBB7njpTZb+ktKFY
         TjWw==
X-Gm-Message-State: ABy/qLbDjyNYRWhMeExJyblVXvNJvlriIYCcV5D9XeYXyLgu5MuMuhGy
        zowbylsoiYDDt2jukB0AJWpDdw==
X-Google-Smtp-Source: APBJJlGuVwTkep94/YrL0o8XuTMW4QyNix57ZU5EauEPig4YFvwYocrHTQEry9NYmVRz7W36RYtFog==
X-Received: by 2002:a05:600c:2946:b0:3fe:6f7:60aa with SMTP id n6-20020a05600c294600b003fe06f760aamr1514434wmd.12.1690549206657;
        Fri, 28 Jul 2023 06:00:06 -0700 (PDT)
Received: from [192.168.1.172] ([93.5.22.158])
        by smtp.gmail.com with ESMTPSA id c22-20020a7bc856000000b003fbd0c50ba2sm6994646wml.32.2023.07.28.06.00.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 06:00:06 -0700 (PDT)
Message-ID: <e695ddf2-b129-3671-2aec-6e96da3f8be5@baylibre.com>
Date:   Fri, 28 Jul 2023 15:00:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH RESEND v6 01/11] drm/mediatek: gamma: Adjust
 mtk_drm_gamma_set_common parameters
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, chunkuang.hu@kernel.org
Cc:     p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch,
        matthias.bgg@gmail.com, dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, wenst@chromium.org,
        kernel@collabora.com, ehristev@collabora.com,
        "Jason-JH.Lin" <jason-jh.lin@mediatek.com>
References: <20230727094633.22505-1-angelogioacchino.delregno@collabora.com>
 <20230727094633.22505-2-angelogioacchino.delregno@collabora.com>
From:   Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20230727094633.22505-2-angelogioacchino.delregno@collabora.com>
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
> From: "Jason-JH.Lin"<jason-jh.lin@mediatek.com>
> 
> Adjust the parameters in mtk_drm_gamma_set_common()
>    - add (struct device *dev) to get lut_diff from gamma's driver data
>    - remove (bool lut_diff) and use false as default value in the function

-- 
Regards,
Alexandre
