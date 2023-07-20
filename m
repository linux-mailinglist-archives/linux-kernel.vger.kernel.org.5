Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 886E375B3A5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 17:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231939AbjGTP6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 11:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233101AbjGTP6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 11:58:02 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE1D135
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 08:58:01 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-3128fcd58f3so840782f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 08:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1689868679; x=1690473479;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ScmE8r0rxxQCSuio4l33tUu3r4Tsu2mdETilqyHlA68=;
        b=A3exCasWYBk9MN1lB8jnIxVvIYr4390ayA7HijOrvQDBD/WZQTcZxCfhhaTK/dSRx7
         AknB73ZWYt+BFUyrwessOCVTrBcH1z60/QOQFXrQtWzH9Zmqvr5mXFNi7sC3dXNZOiGp
         nFRDgc/AFIZoqPmhnVKw05buL8OUCoEJfY06Z+fvPRDxTxFd10+4ikAkY0wgitmYMrBs
         9MvVw87BAPcBcd7vgBp1MelLgXwjyOkWtLYYAwYVgzbQflFvICZ4dWvRgTY03M1fzfSf
         aHKonVx1d+dKiNhnGMyYpQDsXgoHobkZyP4gqNvvWa0oHSOkbq0t4wEDZdgaion4k8re
         t6bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689868679; x=1690473479;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ScmE8r0rxxQCSuio4l33tUu3r4Tsu2mdETilqyHlA68=;
        b=jNMCA+Mqn9ml47gzGJJZH/k5uUsi2uzUuhioBj8izmClKSm7x/bzQzfSo5P+3Q4wqg
         k3tevgXLHB4Xa9HcYPv+0Nsan07l7tClqJeXd+OabrGGSIwUgKCkF3bMfw/ZiQcmutu6
         i9UXM4CX1nv16BuYpWheU/JVVBSnjiMF4Pm1XUqT5yo39U2+j1QmvnKvK8epdWy42awA
         49N03LxSU/NyxTYxHddE3JbkCZ+GFzq9k+jqxT+X3TG6pZq45vfycRMit5y/1SvhD78j
         6neJBoQJzRHyv1xAMiIimH5Y7FVJ+XZgNi8tq7IXU7fZn4d+r4JpcIVdtGTlWf6EIJFd
         Cimg==
X-Gm-Message-State: ABy/qLbZd1wRI+4PHnW9lhXxKwRkWq66dG5mVNxZM2JUTcOG9OheKhJ1
        9plSPsuJhI7d5ZEX2zcKlLpnQA==
X-Google-Smtp-Source: APBJJlGYC6yA01AOSEM/0mE5MXhgTzoU6ewGKF/cbW8YmGXhi7AkY7Gets4CXxis5J5YQaTN+4qPCA==
X-Received: by 2002:adf:ee0b:0:b0:313:f235:cd17 with SMTP id y11-20020adfee0b000000b00313f235cd17mr2257248wrn.40.1689868679497;
        Thu, 20 Jul 2023 08:57:59 -0700 (PDT)
Received: from [10.1.3.131] (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id o8-20020adfeac8000000b003143b7449ffsm1690412wrn.25.2023.07.20.08.57.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jul 2023 08:57:59 -0700 (PDT)
Message-ID: <d2817cd7-0d44-5572-8e38-da5478da5fe7@baylibre.com>
Date:   Thu, 20 Jul 2023 17:57:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v6 03/11] drm/mediatek: dp: Change logging to dev for
 mtk_dp_aux_transfer()
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, chunkuang.hu@kernel.org
Cc:     p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch,
        matthias.bgg@gmail.com, dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@collabora.com,
        wenst@chromium.org, nfraprado@collabora.com
References: <20230717141438.274419-1-angelogioacchino.delregno@collabora.com>
 <20230717141438.274419-4-angelogioacchino.delregno@collabora.com>
From:   Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20230717141438.274419-4-angelogioacchino.delregno@collabora.com>
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
> Change logging from drm_{err,info}() to dev_{err,info}() in functions
> mtk_dp_aux_transfer() and mtk_dp_aux_do_transfer(): this will be
> essential to avoid getting NULL pointer kernel panics if any kind
> of error happens during AUX transfers happening before the bridge
> is attached.
> 
> This may potentially start happening in a later commit implementing
> aux-bus support, as AUX transfers will be triggered from the panel
> driver (for EDID) before the mtk-dp bridge gets attached, and it's
> done in preparation for the same.

-- 
Regards,
Alexandre
