Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D6E075B140
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 16:30:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232246AbjGTOay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 10:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232245AbjGTOax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 10:30:53 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E200826AD
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 07:30:48 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3fbc6ab5ff5so7028005e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 07:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1689863447; x=1690468247;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+p4cBe1pMgniHvXw2LuLYSKKIqQxquV7AY6YDbEUJdE=;
        b=oUUiGCS8pw8J7VoaCzy8JULE07XXLKQOywKwVV2oQdH9glG0suWrzfMxKYQOt3ySck
         Ts0lKmWd/zI8NUEFA7MocNG6AsBcCcndzq6dFmOETbgezPyI9Gt7rf2OlH64v+25Euau
         k9VG3h9NIkRhJXfLy3TxRJe9/sUX8C21mWgXHJYnipC/B0i+tTHZtGkiYoAC5Wa0BNTB
         6eJ3yjLPwsZqapd4dJadZng5ywjpfO4pFWOY51Zml2uoJZXQi29eGMyZhe/xuCT2mL5H
         YmT4g/d/TFxVLrKFvgheNOiI874jPDyzqzdVJJ2tOFcU+3kaW0OGccacJPta4HJuC8nb
         RDMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689863447; x=1690468247;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+p4cBe1pMgniHvXw2LuLYSKKIqQxquV7AY6YDbEUJdE=;
        b=WofHLg8APKYIYVv6mkKBRSSos0maSKyRjYhhLwD2JxlARg4FsLAwKmMspZuwr2FiJU
         Wo77zkEczasKSItRri51I0lZ0tOAGiQBSFrxxr2+rgYltUnS7kURW9RVvShTHFRd0M5Z
         CXR6XM/Ubqyu4MjgvandwsZrhFfglDB1k2UnfSZc9sfDNxSwxnYdR7zKKAfYdCxHqWKq
         QcD9GAvcqxjfJVJsMUFJdCVLp6eImy0+bPBrxT1yJU3iZZJ73RgXRIr8/pAGVCoG5MQ8
         8GhsiHlho0asUdBTOqmpkA8w6tCFdMhSE+A3V3qoK51pZI+dxJmvfWmLWxmr9ux7obmD
         02xw==
X-Gm-Message-State: ABy/qLbB4xAEKmyjE2YFpNN2VCgGisokCS1v+hshANfH1fZUngFX48eY
        xunpbe9rS5Nht+daBhm4yS2fyg==
X-Google-Smtp-Source: APBJJlGvGEcc3bxXa6+U1YfrxHHtDMiie6SxWyukbcPySyU+1GaZAiblUjugsW40vgKcbhSAJV0t3A==
X-Received: by 2002:a1c:7507:0:b0:3fc:f9c:a3e6 with SMTP id o7-20020a1c7507000000b003fc0f9ca3e6mr7262763wmc.9.1689863446765;
        Thu, 20 Jul 2023 07:30:46 -0700 (PDT)
Received: from [10.1.3.131] (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id m10-20020a7bca4a000000b003fc00702f65sm4028031wml.46.2023.07.20.07.30.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jul 2023 07:30:46 -0700 (PDT)
Message-ID: <a2bde8d7-8a30-3f29-b4bd-629416ae20c5@baylibre.com>
Date:   Thu, 20 Jul 2023 16:30:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v6 09/11] drm/mediatek: dp: Add support for embedded
 DisplayPort aux-bus
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, chunkuang.hu@kernel.org
Cc:     p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch,
        matthias.bgg@gmail.com, dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@collabora.com,
        wenst@chromium.org, nfraprado@collabora.com
References: <20230717141438.274419-1-angelogioacchino.delregno@collabora.com>
 <20230717141438.274419-10-angelogioacchino.delregno@collabora.com>
From:   Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20230717141438.274419-10-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>

On 17/07/2023 16:14, AngeloGioacchino Del Regno wrote:
> For the eDP case we can support using aux-bus on MediaTek DP: this
> gives us the possibility to declare our panel as generic "panel-edp"
> which will automatically configure the timings and available modes
> via the EDID that we read from it.
> 
> To do this, move the panel parsing at the end of the probe function
> so that the hardware is initialized beforehand and also initialize
> the DPTX AUX block and power both on as, when we populate the
> aux-bus, the panel driver will trigger an EDID read to perform
> panel detection.
> 
> Last but not least, since now the AUX transfers can happen in the
> separated aux-bus, it was necessary to add an exclusion for the
> cable_plugged_in check in `mtk_dp_aux_transfer()` and the easiest
> way to do this is to simply ignore checking that when the bridge
> type is eDP.

-- 
Regards,
Alexandre
