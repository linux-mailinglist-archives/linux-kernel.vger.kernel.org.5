Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 478BE7AC44C
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 20:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232131AbjIWSHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 14:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231831AbjIWSHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 14:07:16 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5624EFE
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 11:07:10 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-313e742a787so2791973f8f.1
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 11:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695492429; x=1696097229; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H149ZKwWnYhZ1xunGnnrQ+QQwSAWk1F1dR91/0OJmNc=;
        b=wIemnXWxQOpuB7ACQ/JqQL2PBdbGZHEX3Dvroir4APx3dmR/Hez34Selg94bt9ZZos
         yJua1MSyP8hE9bVkLUEK911CRSNZRisM7CP5jXJhDhSKoEd2DWi9n1c0Ntz+CiLKupzR
         bTcGROgy9sAfbAq4zwhqNCnwlxldT1KTC2mDvx7JB9klVlmLPXIteE3Th+IX2kTnmj7k
         F2BLjdhm66idVpjzADeaTHFHNV4lwRMDV330tApPfgj5eHnM7pBjtnBhu+YzbIBAIkjn
         p3vom+VmBWP/rtthk0Pt1fAz1BBbakPQG33S4BhfZrCMiWraZ2Ud5pG0il5xVkgYBUrd
         3KvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695492429; x=1696097229;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H149ZKwWnYhZ1xunGnnrQ+QQwSAWk1F1dR91/0OJmNc=;
        b=bMBzOkm70JvdzltHaF8WK+lP4tz5peNDczivnELI8D40N+g4mWg5uEtA/cGRyrOFxf
         g2naSE7WHJhfsYaEhyoiIpRt8QXAvv9KzLFPfcvJKZiw1leLK+nt+4XebCaokG9uAGHY
         pavCE3qGPrZDJ7i5aW9r1Fq2QZ21+UVYAKmnjGNDRH3rp/Fn6IyDIiHO1CPVdSGOOuku
         wFKGsHeQwqh9XiRsrzIDLOetG2i2WxqO7bIwO6zegLFTkQ1pp4SRdVqAiDz7t4m5MmSE
         3tZloN6iNl1dksaekM9ZKwFQ0b0N3FbG8u+BBBXpYAp839+xJaT/yDM2VaCF5nnJ5Ere
         puAQ==
X-Gm-Message-State: AOJu0Ywoh0nQfwbt7WxlWFvxiOWa6w+u24AOGTTlHlGPeHLLqrhSQptE
        zD0fueOObP9QTh40XVfuNZFv54EFW3Uh93DyD74=
X-Google-Smtp-Source: AGHT+IGGssrmYKQo06++hnwES4sRRwvQ+H+tZUVgGod48UpHafZ5lCkIM3LAng25TajcdA+SQMzndg==
X-Received: by 2002:a5d:4682:0:b0:319:5234:5c92 with SMTP id u2-20020a5d4682000000b0031952345c92mr1812474wrq.35.1695492428791;
        Sat, 23 Sep 2023 11:07:08 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.100])
        by smtp.gmail.com with ESMTPSA id p5-20020a056000018500b0031c855d52efsm7427661wrx.87.2023.09.23.11.07.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Sep 2023 11:07:08 -0700 (PDT)
Message-ID: <84655695-52bf-a67f-e0f1-7ad46fe44e6e@linaro.org>
Date:   Sat, 23 Sep 2023 20:07:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 06/15] mailbox: mediatek: Add cmdq_mbox_stop to disable
 GCE thread
Content-Language: en-US
To:     "Jason-JH.Lin" <jason-jh.lin@mediatek.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Conor Dooley <conor+dt@kernel.org>,
        Jason-ch Chen <jason-ch.chen@mediatek.com>,
        Johnson Wang <johnson.wang@mediatek.com>,
        Elvis Wang <Elvis.Wang@mediatek.com>,
        Singo Chang <singo.chang@mediatek.com>,
        Nancy Lin <nancy.lin@mediatek.com>,
        Shawn Sung <shawn.sung@mediatek.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        dri-devel@lists.freedesktop.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20230918192204.32263-1-jason-jh.lin@mediatek.com>
 <20230918192204.32263-7-jason-jh.lin@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230918192204.32263-7-jason-jh.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/09/2023 21:21, Jason-JH.Lin wrote:
> Add cmdq_mbox_stop to disable GCE thread.
> 
> To support the error handling or the stop flow of the GCE loopping
> thread, lopping thread user can call cmdq_mbox_stop to disable the
> GCE HW thread.
> 
> Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
> ---
>  drivers/mailbox/mtk-cmdq-mailbox.c       | 6 ++++++
>  include/linux/mailbox/mtk-cmdq-mailbox.h | 1 +
>  2 files changed, 7 insertions(+)
> 
> diff --git a/drivers/mailbox/mtk-cmdq-mailbox.c b/drivers/mailbox/mtk-cmdq-mailbox.c
> index 4d62b07c1411..8bd39fecbf00 100644
> --- a/drivers/mailbox/mtk-cmdq-mailbox.c
> +++ b/drivers/mailbox/mtk-cmdq-mailbox.c
> @@ -469,6 +469,12 @@ static void cmdq_mbox_shutdown(struct mbox_chan *chan)
>  	spin_unlock_irqrestore(&thread->chan->lock, flags);
>  }
>  
> +void cmdq_mbox_stop(struct mbox_chan *chan)
> +{
> +	cmdq_mbox_shutdown(chan);
> +}
> +EXPORT_SYMBOL(cmdq_mbox_stop);

Plus there are no users.

NAK. This is not code which should be posted upstream.

Best regards,
Krzysztof

