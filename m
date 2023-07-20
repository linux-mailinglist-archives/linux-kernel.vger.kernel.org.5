Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45B0E75B1F7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 17:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232399AbjGTPD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 11:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232395AbjGTPDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 11:03:54 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D40EC1BC6
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 08:03:52 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-314172bac25so731125f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 08:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1689865431; x=1690470231;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yk0+OfIBVrjxdxyJzd6k7bKe62s4LYJUT+/V2wesyK4=;
        b=HvrixRAIL67I2qRJlTd4cc4z9glJkuSXOv1aDPxuTIHyLZ5BSGbNepxqA3n9t43KgE
         LBNT82RTszenAssbCx8M1uPIjpd0Ga+VOzLnq6OyFtAzpVQFfyqIHXafX3CHjQQEd+NS
         VWcHimCa5DPA9BQDKkPGcgLs1H3rql+tVoNrRRc5mvp+uIQi1VNB+fldBjbuDabP6L+Y
         8dYfAF9ew641dJCCXIANGFdLugHY2oxVXI2bFgK7ZyX3PbaFwNVP35RxC7uFNQ9jBQt1
         UR5uKK+kQodIL8dGRKlnO40omGFnZ3LRz/tJ6pX+75Kh1+xxemuvvap0HTtLYhqILSpR
         v0Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689865431; x=1690470231;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yk0+OfIBVrjxdxyJzd6k7bKe62s4LYJUT+/V2wesyK4=;
        b=ALLIlRKyymKSAS6ZFJBRjTvAlXniRjXYS/ZQW0m0PibdXHYtZMCcnOd16elYvZtBIB
         YijvMtY6mYdM6EDPN2jENgy0rfYc9t/IogLxFRpLbZPG3w0K5r74B7d7pPOF0dosMi3k
         lpeidaR3nR0w03DoMDL2jzY/5v0vPgRCV/iIlzj54+97BuRjpX8ppOg3QZnucYjGRDJj
         l0L02NqijVM7X5gauCX6/POgSYtjTj+TesU6a0HlAbotQiqKmMzVtSOWMG+aVBf9zwnv
         /1zfbFF9VkzjPqrsjeDscxf/FNzJbmljKExk3mN7q+MdvAggQRaHBG57Oi2zxvqULRXC
         Ko9A==
X-Gm-Message-State: ABy/qLbJJR6uIvbS8J6zE+IxeaTlw0KNTi09gpcO9rGoK8gu++RWU4AC
        Nj0ZYgLpLkmRF6i43VMxrH3plA==
X-Google-Smtp-Source: APBJJlEnxpnc6Eg6VtavPczW2DTVI9oBNtJTq6mn0UUWeRqPv/nKBvuumDIPWZPdrtpXnWvrphAq/Q==
X-Received: by 2002:a5d:4c4b:0:b0:314:1f1e:3a85 with SMTP id n11-20020a5d4c4b000000b003141f1e3a85mr2051958wrt.61.1689865430880;
        Thu, 20 Jul 2023 08:03:50 -0700 (PDT)
Received: from [10.1.3.59] (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id n12-20020a5d6b8c000000b003143c6e09ccsm1589783wrx.16.2023.07.20.08.03.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jul 2023 08:03:50 -0700 (PDT)
Message-ID: <a3502c0b-d0e8-9166-b6b4-8f40650636c7@baylibre.com>
Date:   Thu, 20 Jul 2023 17:03:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v6 10/11] drm/mediatek: dp: Add .wait_hpd_asserted() for
 AUX bus
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, chunkuang.hu@kernel.org
Cc:     p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch,
        matthias.bgg@gmail.com, dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@collabora.com,
        wenst@chromium.org, nfraprado@collabora.com
References: <20230717141438.274419-1-angelogioacchino.delregno@collabora.com>
 <20230717141438.274419-11-angelogioacchino.delregno@collabora.com>
From:   Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20230717141438.274419-11-angelogioacchino.delregno@collabora.com>
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
> In order to support usecases in which the panel regulator can be
> switched on and off to save power, and usecases in which the panel
> regulator is off at boot, add a .wait_hpd_asserted() callback for
> the AUX bus: this will make sure to wait until the panel is fully
> ready after power-on before trying to communicate with it.
> 
> Also, parse the eDP display capabilities in that callback, so that
> we can also avoid using the .get_edid() callback from this bridge.
> 
> Since at this point the hpd machinery is performed in the new hpd
> callback and the detection and edid reading are done outside of
> this driver, assign the DRM_BRIDGE_OP_{DETECT, EDID, HPD} ops and
> register the bridge unconditionally at probe time only if we are
> probing full DisplayPort and not eDP while, for the latter, we
> register the bridge in the .done_probing() callback and only if
> the panel was found and triggered HPD.

-- 
Regards,
Alexandre
