Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E8AB75B3AD
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 17:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232599AbjGTP7v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 11:59:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbjGTP7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 11:59:49 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D898B3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 08:59:48 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3fd18b1d924so7762425e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 08:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1689868787; x=1690473587;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UcoTh2sPWLNGHJ3Cv2AGwq+IgylpFtXMhSdz8hYISoE=;
        b=UmPa1+4v/9o9mWbgQ4+lTjHyeeBR6u7UK62B2H1gjePd9O4M5WG8vZ1+10En2Ioyht
         DQukURnmcZUFBpmE1xXeoKbtLz+nZffiIBRaLXOd1l5bv875j7Y2Cdoj4I8fzGfFqrDv
         y7CHlWO74e94RmAnpjS2RfG/G9ccZzWjI+6B64dprmx+qFwc7h/V8M/IplqFotElaQnO
         5M2XhPFrSM2KpYSY6I0T9BB9XatgwC8EPBZQR2YXgGKjq7X/cl8whnHow22WHEU4iVPd
         ww0CAnHyjJivEC8nxFwsV1d4w6mtiaUfK+RCeBZIBYJ55mk0+O16BrueLUcB92Eftq2v
         CtyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689868787; x=1690473587;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UcoTh2sPWLNGHJ3Cv2AGwq+IgylpFtXMhSdz8hYISoE=;
        b=N3O0n2o/EQ1MJ98Ji7JtAv95lMc+bfXPiuc3HYNysCIpadY3j0+cMK8LYbvA/wyvkk
         6uUnb2+3kM+SjXh/Tot2bZCVd73espxDwq35hH3eozQfInHRrjucrmW9F56AV4VnvrrJ
         5/6mQR5D1l5kV92Fm0IvRnmG0BeJ988L2qNzwhzgTXGwpQQY0mQ3TQqK8G4Do5O4uOWj
         t1ke6H5PRKLxdc8K+k52oxUEE3++av+UFXrkBQohY6LFoAQ8Jl8/hUN9IxEPLZO3LE7I
         gIXQW9vgHoFXzF0EqC3Ma5iBdduKUdfOsEI7bmNdN15QBFoqr0BpeTRQ7ImK9SNWepgV
         T2eg==
X-Gm-Message-State: ABy/qLZD9VM3UiDlzgEzf0jtvGj4p2Az9V3+P+Y6r9Qmyma8X+bC88Q0
        JhqwMdYYNIKPA/wojGZhBudcnA==
X-Google-Smtp-Source: APBJJlFJuKiSkpnQvuDgXExLT/wiie2rFVl7aKA4X/43U+4HxIZMk304KppNq+dx3eQW0WuzlLtphg==
X-Received: by 2002:a5d:530b:0:b0:317:ee5:b657 with SMTP id e11-20020a5d530b000000b003170ee5b657mr2227731wrv.44.1689868786711;
        Thu, 20 Jul 2023 08:59:46 -0700 (PDT)
Received: from [10.1.3.131] (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id j22-20020a5d6e56000000b003144b95e1ecsm1685245wrz.93.2023.07.20.08.59.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jul 2023 08:59:46 -0700 (PDT)
Message-ID: <89c36f34-5172-8a88-c389-0cd338458371@baylibre.com>
Date:   Thu, 20 Jul 2023 17:59:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v6 05/11] drm/mediatek: dp: Move AUX_P0 setting to
 mtk_dp_initialize_aux_settings()
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, chunkuang.hu@kernel.org
Cc:     p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch,
        matthias.bgg@gmail.com, dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@collabora.com,
        wenst@chromium.org, nfraprado@collabora.com
References: <20230717141438.274419-1-angelogioacchino.delregno@collabora.com>
 <20230717141438.274419-6-angelogioacchino.delregno@collabora.com>
From:   Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20230717141438.274419-6-angelogioacchino.delregno@collabora.com>
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

On 17/07/2023 16:14, AngeloGioacchino Del Regno wrote:
> Move the register write to MTK_DP_AUX_P0_3690 to set the AUX reply mode
> to function mtk_dp_initialize_aux_settings(), as this is effectively
> part of the DPTX AUX setup sequence.

-- 
Regards,
Alexandre
