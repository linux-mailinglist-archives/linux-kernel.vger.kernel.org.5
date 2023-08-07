Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53245771D55
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 11:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231659AbjHGJpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 05:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbjHGJpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 05:45:40 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9026D9F
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 02:45:38 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-3178dd771ceso3760873f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 02:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1691401537; x=1692006337;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ImTxFrGkAb789gW58cUuVJn9oePTNlXvzPB5nJrZCQ4=;
        b=F8E8v6VCabwPufDFg52rLMuhHjcVTlKRIkxSchTMvPMZvYyrHlb88+ruQSwa9aS8o+
         ecPuJfre8m1B3T9UCIUAWhmtm8WxAEJP/1vvCQulIVBvbuAvIcLrFAeIwG7fvHp6xYyW
         rS2Q/C/CaNvFsf2mvN/RElo/LPHvXfCZxeDnKOACOZFS1rN5USa+JIugANj1tKyraWz2
         lwnOwzQO0UoH01bs1joHvmBKFe27HdhKZxO2cxH97j51YKJKWkaqGSEe03V/Dhy5a3yR
         HWWq0IA29ZPUkeHH/kjNQH3mlNVUB9jY7+Fzsljudd5LBNYDTjEbAdD76wnUXJckbCWs
         92xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691401537; x=1692006337;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ImTxFrGkAb789gW58cUuVJn9oePTNlXvzPB5nJrZCQ4=;
        b=GyOtBC6KGT31lJEaAm5vigHQOlw3v6HsxxlieqPmsudr80ondHZRxu07EBvqYSUjdH
         WlTk6VY3QJQ7u5AfQaIKQ76Ly4x0reLbWSSbu0jXmo/rWVLJToVEaIf58Jc/HyUDajMW
         o+l+wrZh3l+RvnG3kttd9zQJ4dQ/PhYTBWqL1t5VU6tLpdyb7QrTpFTtXldXjnNdrNCX
         CNbzxQBpD6i/+VD8haZ9mccefKeAdi78BYKzaIelPvNAr0nSuWZNQV0V4yfNNGBJ20GL
         d2eJ/YVsTjtiPSciPIeB2j/GQKE0pSUuOd9832iAnit6NGOZIs8BrjaPGOYTblXia+Mj
         sxhQ==
X-Gm-Message-State: AOJu0Yw5KXZFyajZXOMWaYBp2y5vBQBSf493HPSZIXW5C6bqc6Evhr31
        y8ibqIMOzEMTnGuf8ht224a+8HU6AnLMEhi/Smc=
X-Google-Smtp-Source: AGHT+IHz363ez884R4/+bJfvf59hexuHu1VfipBNOcFTwW09jwsazFEehtYVAJh1NXc2ExFcVlICdw==
X-Received: by 2002:adf:ff8c:0:b0:317:df3e:13d with SMTP id j12-20020adfff8c000000b00317df3e013dmr3290134wrr.38.1691401536950;
        Mon, 07 Aug 2023 02:45:36 -0700 (PDT)
Received: from [192.168.3.194] ([89.226.188.45])
        by smtp.gmail.com with ESMTPSA id w17-20020adff9d1000000b00301a351a8d6sm10042906wrr.84.2023.08.07.02.45.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Aug 2023 02:45:36 -0700 (PDT)
Message-ID: <98fe8211-52b4-37ec-a0eb-7dc0ae5a0615@baylibre.com>
Date:   Mon, 7 Aug 2023 11:45:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH RESEND v4 2/2] drm/mediatek: Fix iommu fault during crtc
 enabling
To:     "Jason-JH.Lin" <jason-jh.lin@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Jason-ch Chen <jason-ch.chen@mediatek.com>,
        Johnson Wang <johnson.wang@mediatek.com>,
        Singo Chang <singo.chang@mediatek.com>,
        Nancy Lin <nancy.lin@mediatek.com>,
        Shawn Sung <shawn.sung@mediatek.com>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20230807015110.30579-1-jason-jh.lin@mediatek.com>
 <20230807015110.30579-3-jason-jh.lin@mediatek.com>
Content-Language: en-US
From:   Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20230807015110.30579-3-jason-jh.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

You forgot to put the Reviewed-by got from the V3 in your commit message.


On 07/08/2023 03:51, Jason-JH.Lin wrote:
> The plane_state of drm_atomic_state is not sync to the mtk_plane_state
> stored in mtk_crtc during crtc enabling.
> 
> So we need to update the mtk_plane_state stored in mtk_crtc by the
> drm_atomic_state carried from mtk_drm_crtc_atomic_enable().
> 
> While updating mtk_plane_state, OVL layer should be disabled when the fb
> in plane_state of drm_atomic_state is NULL.
> 
> Fixes: 119f5173628a ("drm/mediatek: Add DRM Driver for Mediatek SoC MT8173.")
> Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
> ---
> Change in RESEND v4:
> Remove redundant plane_state assigning.
> ---


-- 
Regards,
Alexandre
