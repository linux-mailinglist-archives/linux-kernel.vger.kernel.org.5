Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A8A975AF13
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 15:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbjGTNDb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 09:03:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231513AbjGTNDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 09:03:23 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7B972D46
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 06:03:04 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4fba8f2197bso1212771e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 06:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1689858182; x=1690462982;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rUTFNNzxpz9uwH1NN747Wn6G7mosnJMsS5OABZdxOY0=;
        b=mYbSu1BjEcQ0to09bRKOeden10c8fmf60Z14TNO5q4AxtKBMUgSXli7MvsscGdm9Iu
         QKnaueckfNnGNRBSEw/YLQX1zgzGec0p4FGihilxzeujQFIKv7oOu/Im1mebBhjUoaOv
         X8N9PvNSLEn6TtBwtgKOQLw8HHIADQg8SXCZCgMVBCBLAXhfzV73vZIX+43mss3TBzyL
         EbK99wcmYDmGoXjyZciyMv7P4W/SRIIcOTsu9laugpFvErRohtA6H7JMSgAQ9VGWlqh3
         nFm9Y4G2KtqFOUCkutoQfAPyOZzutkuozCLOG4BbtBo/LZdiRFHJSVgLs/wVyTMMfLLs
         5Byg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689858182; x=1690462982;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rUTFNNzxpz9uwH1NN747Wn6G7mosnJMsS5OABZdxOY0=;
        b=h+O4Kw1T2zvUrZ21J3byZFmwEi7K9V7jEEOC1rhGNm57J/M/6yIrSX6bvs/pJEtjI+
         n5/lEGybtpWH3HrJlDmog6McnCWx7bfDwuUs7kFG7GzC0O8RGDZCqrfzrzf255dLv3on
         TV3lhhA+f6FGsbZ/nmiAVbzu6CeceHXyMtAC7GR/SB0jm+ZH4bV4ID1zYF+RDyyKpVEO
         bvpyc9BSrpWOXsmcsgq1dMlFSeIsKfCvaqQ1CFv+vknQ8F+2KCEjjkb09i+BpTjwuYvi
         P313ZGg4dCAQlVfMoTpsiLOTLo8ci/iMd3H7sWUv4l1Q0FqXIB6PvWMAhVjL645f6UJ0
         zXew==
X-Gm-Message-State: ABy/qLbUz9Qdxp8bImMA2203ItEa24+pp91ROP8iIheM5vT3tuk0FCzL
        L+wHe4hqApvA64YKQLiWZ4gYUw==
X-Google-Smtp-Source: APBJJlFkZFwqh4iAS4OEASUge9kO88VgdxXGm+cXnF0tKyKqeN44zff9Ug6bPKAeL6TZe9IEhiyqtw==
X-Received: by 2002:ac2:5b85:0:b0:4f8:770f:1b01 with SMTP id o5-20020ac25b85000000b004f8770f1b01mr1499575lfn.19.1689858182181;
        Thu, 20 Jul 2023 06:03:02 -0700 (PDT)
Received: from [10.1.3.131] (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id s2-20020aa7c542000000b0051a2d2f82fdsm745547edr.6.2023.07.20.06.03.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jul 2023 06:03:01 -0700 (PDT)
Message-ID: <7822b114-0ccd-0344-cea0-760b892c85e1@baylibre.com>
Date:   Thu, 20 Jul 2023 15:03:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v6 06/11] drm/mediatek: dp: Enable event interrupt only
 when bridge attached
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, chunkuang.hu@kernel.org
Cc:     p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch,
        matthias.bgg@gmail.com, dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@collabora.com,
        wenst@chromium.org, nfraprado@collabora.com
References: <20230717141438.274419-1-angelogioacchino.delregno@collabora.com>
 <20230717141438.274419-7-angelogioacchino.delregno@collabora.com>
From:   Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20230717141438.274419-7-angelogioacchino.delregno@collabora.com>
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



On 17/07/2023 16:14, AngeloGioacchino Del Regno wrote:
> It is useless and error-prone to enable the DisplayPort event interrupt
> before finishing to probe and install the driver, as the DP training
> cannot happen before the entire pipeline is correctly set up, as the
> interrupt handler also requires the full hardware to be initialized by
> mtk_dp_bridge_attach().
> 
> Anyway, depending in which state the controller is left from the
> bootloader, this may cause an interrupt storm and consequently hang
> the kernel during boot, so, avoid enabling the interrupt until we
> reach a clean state by adding the IRQ_NOAUTOEN flag before requesting
> it at probe time and manage the enablement of the ISR in the .attach()
> and .detach() handlers for the DP bridge.

Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>

-- 
Regards,
Alexandre
