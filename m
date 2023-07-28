Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8F85766DC2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 15:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236658AbjG1NAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 09:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236669AbjG1NAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 09:00:48 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E6473C03
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 06:00:46 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3fbd33a57b6so23467405e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 06:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1690549244; x=1691154044;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aQ7TENtsQkFhqj90o2fCA4gySBLYYAXohXgU0sJf+S4=;
        b=TdgjYD7E5glMNvLk6eOm8Wy4ecM1zmFsHffYKx7OaFpA70eMULEUlnhr6EL5yhYphW
         ZXgzaO13Wjwqi+BroISZ6BxBCOYa39GX3b9vqNLkACsaxu4Rw0XUYwypzCS1i6uPP4fV
         BZHq9PktFfwqULKVHpjNjOachoMGI7Fs5IbtzmHdqJnmKvQpb3qyXiMYwQtZq5y7pmpP
         USfLCCn74J/L4j285lKh2BfAh3Q5EgT44fgFVkVj2SW737O2dF2yiCo7MVfUxL/apsgc
         k5/ZGfkKcLpKJuUzSK00u49bww46McJbYi3k57a/JbSlZObpfe+UmTNo4rJmsYOJRmzM
         38tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690549244; x=1691154044;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aQ7TENtsQkFhqj90o2fCA4gySBLYYAXohXgU0sJf+S4=;
        b=K6z7NRZLWa3cda2IkZ8i7LDZEwlSfzhdG9l7UlZ6jhySh3wpkZUr93TDqBxlrNXVzo
         ACqbm3O5EqNBvL5ARR4sC2WLJLUxsDQgyB6drK0Efh+DcsEstIVAke7fBkSBuO6yMUId
         V8zGIFXcHeRIdd1r61gRLBSrWQG7Uuqn47aWwFjSWWpGRZhgMPell4Ag3yM9xU9l6djw
         9caFU/VGXv18E8ajtlsOzty2Vd1k4+hD2BpdMVgH+0fHTIUWKM5q5eF+ibnfx/dNaX4y
         IqH1eTYDf9eT6kTo0+poh/1yLniAtJbPjNbMCCRpVGFwkAakep+siHkV4KAExPNNU+NB
         C9kw==
X-Gm-Message-State: ABy/qLZCo1ESS+WyxO3ka6URbzdywp8kBv4ynMWDwRrNfg8sYByYsoMS
        6BNdaq555eoPbaiW/5Fo4oktrA==
X-Google-Smtp-Source: APBJJlEOKfW1ZGAJOsrsnkH2CgAX1ClU5jm83vu2VnugwVvxyESowVTnZPErdgM6iYKniY4urP6VQA==
X-Received: by 2002:a7b:cd0c:0:b0:3f9:b244:c294 with SMTP id f12-20020a7bcd0c000000b003f9b244c294mr1858283wmj.35.1690549244305;
        Fri, 28 Jul 2023 06:00:44 -0700 (PDT)
Received: from [192.168.1.172] ([93.5.22.158])
        by smtp.gmail.com with ESMTPSA id g17-20020adfe411000000b0031437299fafsm4818155wrm.34.2023.07.28.06.00.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 06:00:43 -0700 (PDT)
Message-ID: <06162f85-bb38-d07a-38f6-e7303c80996c@baylibre.com>
Date:   Fri, 28 Jul 2023 15:00:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH RESEND v6 04/11] drm/mediatek: gamma: Improve and simplify
 HW LUT calculation
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
 <20230727094633.22505-5-angelogioacchino.delregno@collabora.com>
From:   Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20230727094633.22505-5-angelogioacchino.delregno@collabora.com>
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
> Use drm_color_lut_extract() to avoid open-coding the bits reduction
> calculations for each color channel and use a struct drm_color_lut
> to temporarily store the information instead of an array of u32.
> 
> Also, slightly improve the precision of the HW LUT calculation in the
> LUT DIFF case by performing the subtractions on the 16-bits values and
> doing the 10 bits conversion later.

-- 
Regards,
Alexandre
