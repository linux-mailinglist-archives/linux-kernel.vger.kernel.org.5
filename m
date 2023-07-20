Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEE3575B39D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 17:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232322AbjGTP4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 11:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233030AbjGTP4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 11:56:14 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7B4CE0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 08:56:11 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3fbc59de0e2so7861245e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 08:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1689868570; x=1690473370;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cDZiEbAryDtT6b4dJ7CPGyIFUH+xNqjsXBnjfT/64bw=;
        b=cSR12mqNhibdO0PRFT43zOAR0T3KpTWjOTJf6mtMCd5S2VfDkUvrRiHzfUN+ysC76G
         1Vz/wz9kexOGjG/HNgqMJ/Yt+K3aiYoN6SAElL4uUDDmi2msQiHOt2NLoOTDE3K0WhJx
         UltMt+hDQOlriTB0Be7nM5Qe7LSAmx7WnrYcXbW/mzt7LGAQuaVDcsTOjJ57sfWMpZYv
         5xK/WXx174ScXkHqFQAJvisYnu3Pqf4O9XbgOkbWw92Xq3CcdiJtzXEWV39OQGwvbmj5
         Kb1xH8cLb8wgUYjhbDABBgs082b/3ReRSdMP8DXtMqdrahQd8YEY4KW6xjrxW3SjkxRK
         qAjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689868570; x=1690473370;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cDZiEbAryDtT6b4dJ7CPGyIFUH+xNqjsXBnjfT/64bw=;
        b=WORwYd/KpXA/SP+ugLeH9CptBIS3N3vWM6gH0uhTL+VN9qCH80R1Qp0+G2Ng8NKSoO
         KU7J890Dk+5APFtvkkTPjgVLfp8KOf3mOzD4DYUTJye8e9uDZLLiiI2iZOIsMtTOY9s4
         rVow/ZBn8hN7DYUEG27CV8cB2xvirNNyeEyRqQvCWqilTO1+6yZTPv5djO3HUC3hggU+
         OCVgQsY8WRg9Zae0iwwWKHZtVFCXCYo2UKfC4XOBDpIDPIC1QeqhomSfRi0mxcDAttde
         BQZ0CMeTYcG8fd3aPmGOuwRYm54qJEbw8quGQWS2S2BjBXi8OfL8//Hp0Yf8eYxJUyLi
         6bxA==
X-Gm-Message-State: ABy/qLbADxq8VQmJmtRhrVGzb0Bn1FdMWUQdpORneBGUtwFGqiHAWz76
        YWKlU5FbhCxa2LJxhpc21yc6Hw==
X-Google-Smtp-Source: APBJJlHkaJLHeTVodXnfjyaWtUl9ixUdRLHPGNnR93G3Z+1iFPPtUHNv6avOf2uwAq+mH+s77ZG5Kw==
X-Received: by 2002:a1c:7507:0:b0:3fc:f9c:a3e6 with SMTP id o7-20020a1c7507000000b003fc0f9ca3e6mr7462943wmc.9.1689868570376;
        Thu, 20 Jul 2023 08:56:10 -0700 (PDT)
Received: from [10.1.3.131] (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id u6-20020a05600c00c600b003fbb5142c4bsm4285451wmm.18.2023.07.20.08.56.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jul 2023 08:56:09 -0700 (PDT)
Message-ID: <21596789-71c0-351e-bfc7-8e81c7b1b175@baylibre.com>
Date:   Thu, 20 Jul 2023 17:56:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v6 01/11] drm/mediatek: dp: Add missing error checks in
 mtk_dp_parse_capabilities
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, chunkuang.hu@kernel.org
Cc:     p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch,
        matthias.bgg@gmail.com, dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@collabora.com,
        wenst@chromium.org, nfraprado@collabora.com
References: <20230717141438.274419-1-angelogioacchino.delregno@collabora.com>
 <20230717141438.274419-2-angelogioacchino.delregno@collabora.com>
From:   Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20230717141438.274419-2-angelogioacchino.delregno@collabora.com>
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
> If reading the RX capabilities fails the training pattern will be set
> wrongly: add error checking for drm_dp_read_dpcd_caps() and return if
> anything went wrong with it.
> 
> While at it, also add a less critical error check when writing to
> clear the ESI0 IRQ vector.

-- 
Regards,
Alexandre
