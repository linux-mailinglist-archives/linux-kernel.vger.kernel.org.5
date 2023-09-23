Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD427AC443
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 20:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232200AbjIWSDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 14:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232193AbjIWSC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 14:02:58 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E45E1AD
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 11:02:52 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9b1ebc80d0aso204613966b.0
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 11:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695492170; x=1696096970; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fyFVeqB6utZDh9GVjHOfgFse9+GghiI4681cEKbsRig=;
        b=Uendx0O+2XKgVzsabUdLBOB8xFf6hn6CvLk1UhXvjCWB/D5iOzLvWqfXYZBdSWLMTs
         kp0Rr+dOimGy5hZgfe4mE8k1MEhyaFstsXe3XRueKR742RJKeRstVsrvnscLMJfVEXqU
         f4+Yf1dB5CjTB7z8XQuU3mmRRThGtYHhcqdZXxdVguhNrIHiWrHYno8OklvXCFUc61yE
         0NPRTFjaBPI4bNkIX+LNsosrscQ5dK+2rfZz26yDnx1QkWvjdPiKXnoA7ORQMK9pAo5u
         1N1duRQZP5qfs8jgml3k7J4vGrl+Wd0Wz6D4DIEGjmjf5OLQWubDSvv7aDNktcRojbph
         T4LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695492170; x=1696096970;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fyFVeqB6utZDh9GVjHOfgFse9+GghiI4681cEKbsRig=;
        b=BD1Y97UpoxMDCm+qLCxkzrOaPNwQKN0A9/6zit5aFPwHiGNkZimQuz/bvApD1Q0MOk
         IWNt/QXacG2kvbyxeomyjNe//X9zphAVikX08IGfGzXgvswtLXIZJ1cmwtHrBo0HCdqo
         m65s0X2OQUBxGKZONZxZ3Me/XhysZiQZ75y1rT7XfvX1Wq3HPtmNSj8/I98kWub82ihw
         nAVFEImF5wZAFDBoZPQ0onBq9aZglYN7NF8jK3/hy+FkGDKF6K/QBZ76Oe7NFuieLe4M
         hnGxvrUntQukcmMSEt1YrUVNx1m/ou2l96yCIkaewMz2hf3kUNNQzH/HQ04GfkEogIIU
         EZZQ==
X-Gm-Message-State: AOJu0YzJwzybJpJhAuarteoahR0isv8evG5q1ODjZ7JDWLF9wIdwYy21
        OSRDEfDHo2bOcAFBxJj20RYAPw==
X-Google-Smtp-Source: AGHT+IEzoIT0eyHgVB5pvxp9pVgGOLU17x+cfcW4hEsmequbeIVUUbsvdCtIG8lzr/pdPnUj/8VHlw==
X-Received: by 2002:a17:907:7888:b0:9b2:6c31:c500 with SMTP id ku8-20020a170907788800b009b26c31c500mr1764699ejc.35.1695492170664;
        Sat, 23 Sep 2023 11:02:50 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.100])
        by smtp.gmail.com with ESMTPSA id e5-20020a170906080500b0099b76c3041csm4131586ejd.7.2023.09.23.11.02.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Sep 2023 11:02:50 -0700 (PDT)
Message-ID: <95f61cb0-f0a9-111c-1541-88d51c3e5748@linaro.org>
Date:   Sat, 23 Sep 2023 20:02:47 +0200
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

1. EXPORT_SYMBOL_GPL
2. Missing kernel doc (full doc)



Best regards,
Krzysztof

