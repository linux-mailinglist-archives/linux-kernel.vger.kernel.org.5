Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C402A7AC452
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 20:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232218AbjIWSJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 14:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbjIWSJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 14:09:05 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F54810C
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 11:08:59 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-4053cb57f02so27000435e9.1
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 11:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695492538; x=1696097338; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lNuBtdApmtdUf0XvIROq9J8oEW88H73TUSgaToXrYf4=;
        b=Rv+sowg4t9Ny1FF0JWrurH6OL1yQKY2MNq/acECs8bGVSlmtA6+J2SJ9uiteE3TsSj
         +yYufRo4X8tKTiHWD+rnTHn7rjn41gy0Yw5RfW3dBFv26tJ5U9A192z8GmconF6q1Kyr
         FDo5dxuvpevEfNY9/TORkmt8rs1uL5UG3qugamnoDLKp3oq/ym5ijlVg1O+B6h0RwSWa
         2+m9a/o3X7rmJcwb9v3KCn4GwQnGbkxLjG8Fe93B9jrCat2k9Drq+030FyDJpJdN1f4S
         rIR9YNTbFjE9o1td49NxHeJ9TXvepZqc0fRxGh8xdlZStRQt7q3/ICB+ap2/WBOKl9o6
         ZgkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695492538; x=1696097338;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lNuBtdApmtdUf0XvIROq9J8oEW88H73TUSgaToXrYf4=;
        b=tW7RwkWyamW9ivsLyVpBc6Jk+FWI3b9CMrExugWwAD/gpEd//3k/SEh1Gc4aktIkg5
         7vd0B/vkNf6XvRf++irtL+kGbqbrAaIiekZkiadj0TA7HdoZL3XhlobhGu9mlalupAEZ
         Iixa7kbkRQC0lusKLGYYY/RiQ6V7ITKFRpmGwN9bGW3LqD/ZZ4FgbIUExHDtxzA3zHSE
         pbbvvewDLvA9zje0s6onWlNnTLdtBrv51Y96cx3pi/pZU8rbQdJAUqdlBtysdikcdLe1
         BcFe6GG4Fz/HqX9aBTQiy0db3rswUVtEh8f/bHsDxMVwWWUtEq6NqkWZoo8y0NiZr1hp
         vuDA==
X-Gm-Message-State: AOJu0YzccY/2kfES0vR8Z8YVpKOa0WUp8NAnPFKrTgMrACmPpaPFeRyC
        CmF2b89CXf0efCJe4F25psFHqA==
X-Google-Smtp-Source: AGHT+IGKEp63EtWq7UClnEUTgxHKAz2asZi2uiPoLLgcA6MXNaQLGed3QzNZ6A9pBoZIGrf4AgNtFA==
X-Received: by 2002:a7b:c409:0:b0:405:3d83:2b76 with SMTP id k9-20020a7bc409000000b004053d832b76mr2293124wmi.13.1695492537810;
        Sat, 23 Sep 2023 11:08:57 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.100])
        by smtp.gmail.com with ESMTPSA id c10-20020a5d4f0a000000b0031f3ad17b2csm7485185wru.52.2023.09.23.11.08.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Sep 2023 11:08:57 -0700 (PDT)
Message-ID: <a1dbb788-d2c8-c358-9f9e-54ca664dc6df@linaro.org>
Date:   Sat, 23 Sep 2023 20:08:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 14/15] mailbox: mediatek: Add mt8195 support for CMDQ
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
 <20230918192204.32263-15-jason-jh.lin@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230918192204.32263-15-jason-jh.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/09/2023 21:22, Jason-JH.Lin wrote:
> Add mt8195 support for CMDQ secure driver.

How is it anyhow related to your patch content?

> 
> Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
> ---
>  drivers/mailbox/mtk-cmdq-mailbox.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mailbox/mtk-cmdq-mailbox.c b/drivers/mailbox/mtk-cmdq-mailbox.c
> index 4e047dc916b9..d27d033c587d 100644
> --- a/drivers/mailbox/mtk-cmdq-mailbox.c
> +++ b/drivers/mailbox/mtk-cmdq-mailbox.c
> @@ -735,6 +735,7 @@ static const struct gce_plat gce_plat_v6 = {
>  	.thread_nr = 24,
>  	.shift = 3,
>  	.control_by_sw = true,
> +	.has_sec = true,

Really, how?

Best regards,
Krzysztof

