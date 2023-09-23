Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33EF97AC451
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 20:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232210AbjIWSIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 14:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbjIWSI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 14:08:28 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9000A10C
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 11:08:22 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-40572aeb73cso3809425e9.3
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 11:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695492501; x=1696097301; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8RYcBLgXi2Usyjv8O8F7jTAVsfiwldX4rLiaCjIZSoY=;
        b=Ya8cEGNPvaBmDAun+1OhPyszgJVF6nAGJB0sRv8QEJg8kTpzgw6AP16J+HdM0I6lqT
         7qhNvDLyf+dYcSQIkctbUYhZtWaeVzhqG2fvhpnP4mNgVetcVgrhKial22hJb2WE1ogA
         HOaud75AC7sg6CGmNybM8+Zp12UFhUjQso6dKX+UDo6TYQlJRUgefVgy9lcH0eL3a/bw
         51l9CktWt+0qF7RBOypU2maxHrCqLgJIkcrjJqO9vaf5upO1LXBS5qWebc9KOZ4UMUO9
         PDH/4jPtz56jUkkB7na7/+p8HZUn8oD/bxvv+/kgPdW2t+nYEUSnRjju7Qoq9ZdPMf+z
         PHHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695492501; x=1696097301;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8RYcBLgXi2Usyjv8O8F7jTAVsfiwldX4rLiaCjIZSoY=;
        b=jgrFzD7lDcE7jCSz8SvPugIEy6rqNNPqj1Nlb1nmXKOGxkmi7dH/Qrmiyd8Q/Jv1ME
         //VAgkUdk7ruL+7bfHhgSY56c1tCt6fCIDKZMHy+PzGLuqnqp3sjpG6djYyodC1K5xYC
         5vvNZ6KHS4YhYDaAukr2XaN3LPvH2pZ02vqcqm/YSvkL0nfgAFjT8mPH1ulUZ9MLFgYO
         LEQuvdmvsQnfMHMlYyvp4yWCrxdJOnsp6IiADDl47kECT4MvgGEiElX6+KIfOLK7H/TO
         GhCO60u6kWVR0esPwKXmndwqfnpEAJ2ksafVl/XMCbvCCiMXdCJbyTdXpTBm12FDPsmS
         T5nA==
X-Gm-Message-State: AOJu0YwanuOylb4W4pWOGP3C1jAkXL2NSAKKhVgskpKhLVqEtfrQcAax
        DYBTE/X4pYTH/ik1Nn+nZ79zRA==
X-Google-Smtp-Source: AGHT+IHgTWwCB7z8DnJNi+Zreo84MahTyxYFZoaRGkQRiDLl6+zBS9mKeFPkwSsb23KkMMbqczLODw==
X-Received: by 2002:a5d:6b51:0:b0:31f:d95d:20a6 with SMTP id x17-20020a5d6b51000000b0031fd95d20a6mr2321405wrw.12.1695492500957;
        Sat, 23 Sep 2023 11:08:20 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.100])
        by smtp.gmail.com with ESMTPSA id m12-20020a056000008c00b0031f3b04e7cdsm7440226wrx.109.2023.09.23.11.08.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Sep 2023 11:08:20 -0700 (PDT)
Message-ID: <ecda52ed-1d17-45e8-ab90-a9070ceb2d1c@linaro.org>
Date:   Sat, 23 Sep 2023 20:08:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 08/15] soc: mediatek: Add cmdq_pkt_finalize_loop to CMDQ
 driver
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
 <20230918192204.32263-9-jason-jh.lin@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230918192204.32263-9-jason-jh.lin@mediatek.com>
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

On 18/09/2023 21:21, Jason-JH.Lin wrote:
> Add cmdq_pkt_finalize_loop to CMDQ driver.
> 
> cmdq_pkt_finalize_loop appends end of command(EOC) instruction and
> jump to start of command buffer instruction to make the command
> buffer loopable.
> 
> Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
> ---
>  drivers/soc/mediatek/mtk-cmdq-helper.c | 23 +++++++++++++++++++++++
>  include/linux/soc/mediatek/mtk-cmdq.h  |  8 ++++++++
>  2 files changed, 31 insertions(+)
> 
> diff --git a/drivers/soc/mediatek/mtk-cmdq-helper.c b/drivers/soc/mediatek/mtk-cmdq-helper.c
> index 4be2a18a4a02..bbb127620bb3 100644
> --- a/drivers/soc/mediatek/mtk-cmdq-helper.c
> +++ b/drivers/soc/mediatek/mtk-cmdq-helper.c
> @@ -475,6 +475,29 @@ int cmdq_pkt_finalize(struct cmdq_pkt *pkt)
>  }
>  EXPORT_SYMBOL(cmdq_pkt_finalize);
>  
> +int cmdq_pkt_finalize_loop(struct cmdq_pkt *pkt)
> +{
> +	struct cmdq_instruction inst = { {0} };
> +	int err;
> +
> +	/* insert EOC and generate IRQ for each command iteration */
> +	inst.op = CMDQ_CODE_EOC;
> +	inst.value = CMDQ_EOC_IRQ_EN;
> +	err = cmdq_pkt_append_command(pkt, inst);
> +	if (err < 0)
> +		return err;
> +
> +	/* JUMP to start of pkt */
> +	err = cmdq_pkt_jump(pkt, pkt->pa_base);
> +	if (err < 0)
> +		return err;
> +
> +	pkt->loop = true;
> +
> +	return err;
> +}
> +EXPORT_SYMBOL(cmdq_pkt_finalize_loop);

NAK. No users (and please carefully think before you answer that your
other patch uses it).

Best regards,
Krzysztof

