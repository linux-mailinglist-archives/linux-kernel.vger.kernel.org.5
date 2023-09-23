Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70A827AC456
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 20:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232229AbjIWSJz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 14:09:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbjIWSJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 14:09:53 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89628FE
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 11:09:47 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-405361bb949so39221975e9.1
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 11:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695492586; x=1696097386; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l0OmVT82kVRhT6V7fBBibLFNJi2iRMus/lOyy9oKOW0=;
        b=qyMuo0b+3E5jVquxzTAT7sF9OFfnEMGyIOlFXcQcOv7KOVbCAYayLUjR/sybctRrnO
         ztS+CV1RRThVdMhFlqTkAV7lG74jzco8n1OeC5elmoZI2rMDR0oIR6dpHdZI76hlKIK9
         GnHVjdJP5Ujd5sE7WtGHWSZX9J0TljGYb7jYNRIHprbCYkDn1AprzhTc4giF+96MhZbE
         8peNjBYuBATUQGLQiJNbNpXiKragPNFRwXJtXLwRDhrGrHsanSwGbtfiSW9SCoI5lqHt
         e8jhVpZhwqKOx9iAv9kP2UyFxk+xWEpn8AHzdqgQkJsdBP0Q1GuBut+a73eUvW7nnLE0
         8ilw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695492586; x=1696097386;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l0OmVT82kVRhT6V7fBBibLFNJi2iRMus/lOyy9oKOW0=;
        b=Zws7VzdDB8dB40uuv1lOPwalrQKteD8+Nsa3PvWp3Y0FuY5IanDU4Wg43AYIYUvy7z
         c2ePtxpWHW/RzjrOtq2IFpxCqHtyzQWXNYQBuU7gB7VhfkQ5e3VEu1nRBd+67w8edyxK
         xaNl2wI8qjIprkMKgOcms7D0e5grrN8JLtKNj5SwupVrdqn9k0cd0RQXcKDXvb5e9Q80
         RcvHuKQDCzeHOGkXwuykuL+IgdVgJEuR22Ywi8cFz1oYjYp2hv+c+V+gXONMktY8RZUC
         Ef8yhixFX/8VIlv9CjBgByUvVc8wm3WJrZ/ZVkN3/byxIVfbJHqQH+cJ8vnJaQR234JL
         5ZEA==
X-Gm-Message-State: AOJu0YzSJzC1t+hiTOFa5RC8qjnfvb5/sJw7j3nXw3itFBfDh1TvaZPT
        VtJ+pnvbfrpIsPTWlv6VbQ6Okw==
X-Google-Smtp-Source: AGHT+IGbEDdCor3uAVvI6RHkOnvfxXv6QO0vC7iRLExeI+9NeOdG9D895dHQs60CsZTG3e2Zoj0+KA==
X-Received: by 2002:a5d:4c85:0:b0:321:5d87:5f7c with SMTP id z5-20020a5d4c85000000b003215d875f7cmr2665873wrs.30.1695492586036;
        Sat, 23 Sep 2023 11:09:46 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.100])
        by smtp.gmail.com with ESMTPSA id z12-20020a5d654c000000b0032148618cc4sm7447722wrv.29.2023.09.23.11.09.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Sep 2023 11:09:45 -0700 (PDT)
Message-ID: <87ae80c0-a09b-3642-e3e9-c753cd330bca@linaro.org>
Date:   Sat, 23 Sep 2023 20:09:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 13/15] mailbox: mediatek: Add mt8188 support for CMDQ
 secure driver
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
 <20230918192204.32263-14-jason-jh.lin@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230918192204.32263-14-jason-jh.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/09/2023 21:22, Jason-JH.Lin wrote:
> Add mt8188 support for CMDQ secure driver.
> 
> Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
> ---
>  drivers/mailbox/mtk-cmdq-mailbox.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mailbox/mtk-cmdq-mailbox.c b/drivers/mailbox/mtk-cmdq-mailbox.c
> index 3940b9f8e774..4e047dc916b9 100644
> --- a/drivers/mailbox/mtk-cmdq-mailbox.c
> +++ b/drivers/mailbox/mtk-cmdq-mailbox.c
> @@ -750,6 +750,7 @@ static const struct gce_plat gce_plat_v8 = {
>  	.thread_nr = 32,
>  	.shift = 3,
>  	.control_by_sw = true,
> +	.has_sec = true,

No, you just added it patch ago. Do not add broken code and fix it. Are
there some KPIs in Mediatek to have patch count?

Best regards,
Krzysztof

