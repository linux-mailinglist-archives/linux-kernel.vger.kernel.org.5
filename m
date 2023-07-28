Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A10C766DC6
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 15:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236251AbjG1NB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 09:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235428AbjG1NBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 09:01:16 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4508C3C05
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 06:01:15 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3fbc5d5742bso23043255e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 06:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1690549274; x=1691154074;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QW6VR0xbVDGg7YcGByTjYohe8SAyF9UA/FukyNaJluU=;
        b=b6qmhCDLZx5ial+sDOWJFOT0dV5I0NmjgWyc+CLCN8TsuuB36X6UJ0KD1m46xSOI0G
         N+pgOSfKpGRLawHGfwESWZL7mLOF1GchjCOMiMkwk3rF1SIgMja4SGgc1YfebArTkVOT
         dfQz1DhOsQJb+UaVx7UMOUCfMRbEZdGpsCdSJc/SVNO+izFKzscpcFoWB1+t+d/Pcr/J
         Z+uzbSJHD5H+9vzoGZsRCZva5wktpM7d17yKww7w560AaNfOxRO5bduB7aLyysjDy/2Q
         J+L5MIbOpk9Em5q0B2E5dweFMsikV/Es4rZZq36NLKE09DgTisBf0erR74kH/0wdgO6O
         F7zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690549274; x=1691154074;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QW6VR0xbVDGg7YcGByTjYohe8SAyF9UA/FukyNaJluU=;
        b=fZduPjAHIs3LrESrdP9MoDvtqN+ZBDj2iqtnDlzD/xjGOB30PXaTy+kzD+a0M2QiOZ
         N/iYnmETzbovorrR5/QyJfKLnzM/1SU4+Hgxy4Pp53LhuuU0xvmg0PaqA2+BPU6sTk5p
         6MgO4oMeqJQOjG7FxB54zCKW0ZOcn4eyeY4EYepgMY8+LIkcrgvTesQ2/S/2BYdgYLUt
         0V+fRzGXrxJkJwWmGZHXvt34f7jEu5+1I+DLm+Oo90SpvwIvTNMulph6j/ApL4RLYvcv
         cMTCrcQINRQCvqOWaapgb+HWYdxr50pe9+QPE6zuQ2d8gs7BiF3biVlNWgoyNWIE6TUw
         ui3A==
X-Gm-Message-State: ABy/qLZ9WV5FajbNxmxgpeWnJ4467zZAOfrjv0/XS3+QULcoBqI2Br3m
        xywwMTVO5kQdb8ZMa9Abicml9A==
X-Google-Smtp-Source: APBJJlEmvDuoO6G/U6S079+Ig7EF8C9rgaePYvCOkc4Rlvpl1lXKFgFL1zUobv0qcSK4Q5YppqbAbA==
X-Received: by 2002:a05:600c:22c4:b0:3fb:c9f4:1506 with SMTP id 4-20020a05600c22c400b003fbc9f41506mr1917683wmg.1.1690549273790;
        Fri, 28 Jul 2023 06:01:13 -0700 (PDT)
Received: from [192.168.1.172] ([93.5.22.158])
        by smtp.gmail.com with ESMTPSA id v18-20020a05600c215200b003fe0bb31a6asm1216079wml.43.2023.07.28.06.01.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 06:01:13 -0700 (PDT)
Message-ID: <764aa9af-fbf2-5dfe-9816-bab8568a925d@baylibre.com>
Date:   Fri, 28 Jul 2023 15:01:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH RESEND v6 06/11] drm/mediatek: gamma: Use bitfield macros
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
 <20230727094633.22505-7-angelogioacchino.delregno@collabora.com>
From:   Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20230727094633.22505-7-angelogioacchino.delregno@collabora.com>
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
> Make the code more robust and improve readability by using bitfield
> macros instead of open coding bit operations.
> While at it, also add a definition for LUT_BITS_DEFAULT.

-- 
Regards,
Alexandre
