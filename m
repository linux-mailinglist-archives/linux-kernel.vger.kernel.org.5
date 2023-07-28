Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D57C766DC8
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 15:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235781AbjG1NBj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 09:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236669AbjG1NBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 09:01:36 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CD6A3A9A
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 06:01:35 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3fbc6ab5ff5so21613865e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 06:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1690549293; x=1691154093;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GHiawQpngVfU3Z6lAbvF/XFA4hRpbcAvvOhJloZt9Vs=;
        b=awllWdar0JnfZi5DTXXYlC2hQRqstsq4OagnOvDE4Y4dgS1nuIGsHmsgsIPkFO1t3J
         iCFiJqPRuQWI6hod3BhObT+26Y5r1Vjfu4ukCouCZ4VrA8E6CwMY6ZjA3o+l1hMb4AHF
         8GXsGhKOFGuM6+b/QIH3Jk5vpy6aKpIvO2sUafOsqqCerx9CRGYvA1MXUDz/DRrCv+Pb
         DLe9t7/gpBaIrYcFkAS+YAH0WuiKkFibdTsU7EfQKI/zfvZT55kbifsD83OV/+NiA9By
         c5mMuMTGuDSRi3A8iM4UxN5sx6ZQ/ZbJSa/pWb+5xqGErG61MWGbvkHSDNHoS588BwGx
         5mPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690549293; x=1691154093;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GHiawQpngVfU3Z6lAbvF/XFA4hRpbcAvvOhJloZt9Vs=;
        b=VVYjOMFIlhe/Cd4J3bdIN4cM46Vw6lOKQw7IerkLlGzEQrF5RtFZFU0Nphybh1vqyo
         tnlr47KEYEuBJHgrkNVabK9JRqHgLk8iSKBm+g90vDeAdIvatUqtsVLYsa1lb0MVJS8f
         oEjg2EWLmeuUFIVRUECrqTrUColUVlZIA6ugskh2jlj2EEMS7CSUR3zaBTIFKqLLTfVA
         pszG5SQg/dDHBQhW4JXxkIae54pGI9FVeQEvYK2xXLT1lwq9odOhRAsFWkRL6FL9Fen6
         gK1VfCoBLGiBuXCAZP8HyMWnW0tj7IA6ypIuEXpb7cmSby29L0TSzAJ/Y9yA+AfzL0Un
         epNQ==
X-Gm-Message-State: ABy/qLblGbsNyPR27CsIpqS8nk609/C2Q96UD1iTby5yqcp3IXrkgxe7
        OL8YT9CBQxwA4H6UeTjkYqMSLw==
X-Google-Smtp-Source: APBJJlFsN+yCMtYDAo87KgEo3nUVITs5qB6btu/td2eWZ7u9kpNIrrhvdquppQoWVobCDh5dBZDZAQ==
X-Received: by 2002:a7b:cc17:0:b0:3fd:2e93:c524 with SMTP id f23-20020a7bcc17000000b003fd2e93c524mr1690329wmh.26.1690549292943;
        Fri, 28 Jul 2023 06:01:32 -0700 (PDT)
Received: from [192.168.1.172] ([93.5.22.158])
        by smtp.gmail.com with ESMTPSA id p24-20020a05600c205800b003fc01189b0dsm4174594wmg.42.2023.07.28.06.01.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 06:01:32 -0700 (PDT)
Message-ID: <8b47f7ed-9d21-c244-716d-5a9c3cabd16e@baylibre.com>
Date:   Fri, 28 Jul 2023 15:01:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH RESEND v6 07/11] drm/mediatek: gamma: Support specifying
 number of bits per LUT component
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
 <20230727094633.22505-8-angelogioacchino.delregno@collabora.com>
From:   Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20230727094633.22505-8-angelogioacchino.delregno@collabora.com>
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
> New SoCs, like MT8195, not only may support bigger lookup tables, but
> have got a different register layout to support bigger precision:
> support specifying the number of `lut_bits` for each SoC and use it
> in mtk_gamma_set_common() to perform the right calculation.

-- 
Regards,
Alexandre
