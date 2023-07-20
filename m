Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 136E275B3A8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 17:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232223AbjGTP6y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 11:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbjGTP6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 11:58:51 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CFAF123
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 08:58:50 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3fbea14700bso7685505e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 08:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1689868729; x=1690473529;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=APInPB7RqnE96OD+GVxCziUT6IhjtDsuJ0KQfyBikKg=;
        b=U1XvacrrAcEXhZMWOEs1D1gXdFvBG7S7/Gx3vXiguI8p3v2ePMaObAOQ7V/JaoDCJI
         Zyq1cH0GP6m4oMOI7VO7yJVL8tXcSswAfJUq4SO9ns5tuc4WsG8tMzncIpDosSnDEsme
         mQvBAFW9njBOLCIDbUob6/xrsbHPsibQratHN3Ktorg+l54KFs8vdnUb8MOKdm2LngBE
         HnemVN/pMIrZCTt4kW0igczwYXEwMylgWAhiZ6Q7U9FddzkCmvrNk25w91N2Mt2Bc4GA
         Dp5DBrajp4H05GmZvGAPxZeRuJBOkyZRGsEvLIA6nHFznDWNPiyRkpGBA9fXa1FKl8W5
         JbQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689868729; x=1690473529;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=APInPB7RqnE96OD+GVxCziUT6IhjtDsuJ0KQfyBikKg=;
        b=gBGgN5tEYNqorSWqJsSeTXW+hA6h8V9W4OSztoCOIivGHE22xQr06EJU/1JZH2PEML
         pVtdJbxRV7DFO6CZjJSE8Y/tml06cudrNw7cXIUzV5TSh4qI+sxPdcCJ53GyZcWqFW7T
         7Koqx1Ab3aU9zwX+R6DWGf2mWto5Uy1lHPRYc4D/GctDjEYwbmDzRau4bsuq+0JPIFHY
         umfkx8LHICmoR0TUB6M4aRuk0i/2qPuUtj0NA6AtjysIKGtg9n3fKKJWeV02UNxFaFVD
         3PyA4yxAkcWTiZcQaCYhTD8/wS5pLUZoM7nP8FEtOUPn0r7skAA5czUqU/V6NJj2xnHx
         vxkg==
X-Gm-Message-State: ABy/qLa3yqzGm+x4Lk5Kt/fsRALQ6OQ2DpHSjc+BRSvKJlcXvh3JUpRv
        GpXDwz8vl2sigbIA+auJnrPNCA==
X-Google-Smtp-Source: APBJJlEW6ehSEwNUSYMtsbgzoCe6bXnwpN2+DywULbS7KdO346A4Zad5/hmiohby/H5JtNgF88pe6w==
X-Received: by 2002:a1c:7501:0:b0:3fc:21:2c43 with SMTP id o1-20020a1c7501000000b003fc00212c43mr2181991wmc.13.1689868728760;
        Thu, 20 Jul 2023 08:58:48 -0700 (PDT)
Received: from [10.1.3.131] (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id c22-20020a05600c0ad600b003fa98908014sm4228769wmr.8.2023.07.20.08.58.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jul 2023 08:58:48 -0700 (PDT)
Message-ID: <6a1218a6-5825-2366-f3cf-d44e1e9956ed@baylibre.com>
Date:   Thu, 20 Jul 2023 17:58:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v6 04/11] drm/mediatek: dp: Use devm variant of
 drm_bridge_add()
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, chunkuang.hu@kernel.org
Cc:     p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch,
        matthias.bgg@gmail.com, dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@collabora.com,
        wenst@chromium.org, nfraprado@collabora.com
References: <20230717141438.274419-1-angelogioacchino.delregno@collabora.com>
 <20230717141438.274419-5-angelogioacchino.delregno@collabora.com>
From:   Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20230717141438.274419-5-angelogioacchino.delregno@collabora.com>
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
> In preparation for adding support for aux-bus, which will add a code
> path that may fail after the drm_bridge_add() call, change that to
> devm_drm_bridge_add() to simplify failure paths later.

-- 
Regards,
Alexandre
