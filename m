Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE011766DC4
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 15:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236659AbjG1NBK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 09:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236674AbjG1NBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 09:01:04 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61C2435BF
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 06:01:02 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-3177f520802so1372832f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 06:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1690549261; x=1691154061;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bf2mVoVflay+UuUZTM6QyCoyU7R8Oct66Mg/IJM6lZU=;
        b=JME2b3NVifOSLmvYqpLZ6dYV47f3XRbiSi+7NW889mMqzoXpdDGEKdZWATqZ7ftWdW
         4QWqynSN7bqiM8sQyoTErVMsn/rG7A2MKbUZPyqjqZVGf9D5S1RFFphW0fLwAFwG+bS3
         VS16Jzgi129OW50T+WKR6QWKjI2kmfRp5k/rUK0w3WHXJX8mUsw75CKr9kvDgn/tjXj5
         Vw0+jkIWkzGyjfAdvbhUtv2pG88ihXQEyhshq0MGMI050Ul05iL+DM4oPI9ZHQ+Bt/u3
         ytD+hMbSidKRGWarh7IvfUVqrcJBjwrQYFa+cYgIqW0TIFfuGftfuibIsLfBh9R/Bnw+
         SsnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690549261; x=1691154061;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bf2mVoVflay+UuUZTM6QyCoyU7R8Oct66Mg/IJM6lZU=;
        b=lUTy6jBwsoK/I2meyFd58kM+S+BAD4Owug95BbRhimTbLnTl6HjgV056sirxDHXaxQ
         t7LqlGtexfRq8SBDvkzfdTtnx3sQuM7QUwe1q1Kb66ezwNn0qVMibySpxpEIowKurHAZ
         etljK0bgAwtRV3HWjJJab6zK3BER0BfSxTFIXxKfbnGqqvS5PYOO7xBkQ5M+SD0jbiRh
         GuLv9RbDlRqjlxctY52hoqLax+7h9Ndt3ZqPZ2u59ypZdohzFVAZmeBP90EBgmA0iI2h
         b2mma7gn/1X42hiqnSghIm11EXrIGS2GcmLzYW6mWrCyqhuDF72vr7mpRyRU9S/2C525
         2cOQ==
X-Gm-Message-State: ABy/qLZ+EdnK4EiYg0034Et7Es9SXBzzrXpYEjRg1X6r6xOiooP/S8sS
        DlDx00G7Q9Cjwouu53kfl1ZBqA==
X-Google-Smtp-Source: APBJJlGVqDRGmbAbM0+sd1YryU2znrhwu0i4M4Xf/2epgtob/BhmHayOa5M7HaMRl38LctbCDO00tg==
X-Received: by 2002:adf:e489:0:b0:317:5f35:854a with SMTP id i9-20020adfe489000000b003175f35854amr4674582wrm.13.1690549260939;
        Fri, 28 Jul 2023 06:01:00 -0700 (PDT)
Received: from [192.168.1.172] ([93.5.22.158])
        by smtp.gmail.com with ESMTPSA id k8-20020a056000004800b003141a3c4353sm4809226wrx.30.2023.07.28.06.00.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 06:01:00 -0700 (PDT)
Message-ID: <05b6bfd6-5227-b146-f5c1-d47881300e6a@baylibre.com>
Date:   Fri, 28 Jul 2023 15:00:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH RESEND v6 05/11] drm/mediatek: gamma: Enable the Gamma LUT
 table only after programming
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
 <20230727094633.22505-6-angelogioacchino.delregno@collabora.com>
From:   Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20230727094633.22505-6-angelogioacchino.delregno@collabora.com>
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
> Move the write to DISP_GAMMA_CFG to enable the Gamma LUT to after
> programming the actual table to avoid potential visual glitches during
> table modification.
> 
> Note:
> GAMMA should get enabled in between vblanks, but this requires many
> efforts in order to make this happen, as that requires migrating all
> of the writes to make use of CMDQ instead of cpu writes and that's
> not trivial. For this reason, this patch only moves the LUT enable.
> The CMDQ rework will come at a later time.

-- 
Regards,
Alexandre
