Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC2675B396
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 17:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbjGTPzV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 11:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231827AbjGTPzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 11:55:19 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95FC21FCD
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 08:55:10 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4fba86f069bso1442398e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 08:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1689868509; x=1690473309;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R/vajSz0EMzHxMTH4BJFALvBAcvnPkERwUPuHlbHS8Y=;
        b=GMKGYC43J5tI4ZHdzTaBI/o/alJd9YdIhB6mQCzf0Ewrhd6/KZNv4tDsSkOsaZ20qN
         O4K5O35MUgU4VN6yPLYbkNZXEiD0s7mpvRkzYRnUyzwDKQWITr1tTAO9JtRx1mmIvkWS
         KqoW72N6eu6cVUlR/nc7dTg2sKLp49PIsN2ocLCIca7vvwSW6ET/iXtFkh2EuL7kxcm5
         92R1jXNGkeHRXvuJCY+bKOeNBMCqXSKSYj9CE2lrkExjAOCzkMtC26JDlEQ8HU2LlJJr
         6iBgbKzPD5PkQyxmfjhj/5exLb6hJ7WTRc3c0idlcIx0AqNf61XVJdpdvZC7q/GDJMKk
         qvzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689868509; x=1690473309;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R/vajSz0EMzHxMTH4BJFALvBAcvnPkERwUPuHlbHS8Y=;
        b=khy8yZluBXR0T2mfZMJxw/yQ58yQA6I/5uQVoDaXf+n4KWAMTSz4RbqBFR6oUC4Q0p
         TNbLWrNGRKijcTdFTDz/SHuJUyt11QI2M/fzmP7KesVuPkXw8TaW8TJcQLHaXCg3kwrz
         3V3ZZW6AvFVsnlrkxFa/97tjr9SyN2DFqliwwjwtnxCnIwu0R0gKdjcximtKHFfYdHse
         XLQJ36pCPjgkk5pkrYQ+goi5x2HM7076m5dkv0sdcqGo8aOuITMuciua8cUbzNQb8tD+
         P73ogU8dhxp8wIeadkldmSAEP09p6Us739z1xfclmRYOWsqluT7Fz5TlhakcdB1qFr14
         h84A==
X-Gm-Message-State: ABy/qLYexhQEuqv6onRKWPF+QEIurLU6CpDHC9oon1rh9tXiIXKUJRQe
        nt7uZzYUn0OdupBaXKuOUIGyxw==
X-Google-Smtp-Source: APBJJlEBIY1TvT6KLSO+AQ7zN+qW0dTIKxqy0mEXcL2xvmxKlSGoTfz+JsEur/+Zh4XZ44l7bzIJlA==
X-Received: by 2002:a05:6512:3443:b0:4fb:8a0a:31f2 with SMTP id j3-20020a056512344300b004fb8a0a31f2mr2428594lfr.69.1689868508680;
        Thu, 20 Jul 2023 08:55:08 -0700 (PDT)
Received: from [10.1.3.131] (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id q17-20020adff511000000b0031272fced4dsm1695889wro.52.2023.07.20.08.55.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jul 2023 08:55:08 -0700 (PDT)
Message-ID: <f7234a53-2449-426c-4cff-91c89bada258@baylibre.com>
Date:   Thu, 20 Jul 2023 17:55:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v6 11/11] drm/mediatek: dp: Don't register HPD interrupt
 handler for eDP case
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, chunkuang.hu@kernel.org
Cc:     p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch,
        matthias.bgg@gmail.com, dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@collabora.com,
        wenst@chromium.org, nfraprado@collabora.com
References: <20230717141438.274419-1-angelogioacchino.delregno@collabora.com>
 <20230717141438.274419-12-angelogioacchino.delregno@collabora.com>
From:   Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20230717141438.274419-12-angelogioacchino.delregno@collabora.com>
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
> The interrupt handler for HPD is useful only if a display is actually
> supposed to be hotpluggable, as that manages the machinery to perform
> cable (un)plug detection, debouncing and setup for re-training.
> 
> Since eDP panels are not supposed to be hotpluggable we can avoid
> using the HPD interrupts altogether and rely on HPD polling only
> for the suspend/resume case, saving us some spinlocking action and
> the overhead of interrupts firing at every suspend/resume cycle,
> achieving a faster (even if just slightly) display resume.

-- 
Regards,
Alexandre
