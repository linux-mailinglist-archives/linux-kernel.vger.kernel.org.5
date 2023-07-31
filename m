Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CEAA7690DD
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 10:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231794AbjGaIyh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 04:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231284AbjGaIyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 04:54:03 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E96E7C
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 01:53:05 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-317798b359aso3763358f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 01:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690793584; x=1691398384;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Ramj4YSnzjlXBa9BeMFid4H4KLnlWvwglhchgdb9pJQ=;
        b=l/VccmoBzlMOT1o3Wl9Mjxa3pmorkGuXy9sC3L4wJ32bJUrV5Ke5ximGyMQ+td0muc
         KDTOZIuMN0Prgv4h1KsYAft5qvJXhcLiRyyy/7szNt6RnWuDdUMi++4DwLNge33Z95Bs
         X2PjbuD3YCmgpA3YrKYnQZVhX0xwMPvApdeaujfS2NUgSoLAQXkDQuO+58IkvQc9NoyK
         0qe6tvPxs/vxPxp0hmMZ6x8284YAH4VFTnBNca8KIwWNNjHV87LjCsaVGElWirqwMshI
         L80fzIzZQqF2I95X/vTp0w+2zfwVGIfyfh8mcFY4UICtuM7tkb4wDhAn7thnleAVoyhF
         N35Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690793584; x=1691398384;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ramj4YSnzjlXBa9BeMFid4H4KLnlWvwglhchgdb9pJQ=;
        b=NvvAI0bDST+GbCjbMUKu/VW877OUAY9l+cw4kpYaUmBMIRG01ziU4eqPAiOVLTGpRx
         uIltUsb+37PBC2nthriBzMr9CPdUEfxi32ZEW2PKEQx4hkRsZH6UMK8WMsGDqHkCvGpq
         fWtt8HlsiCYQpNowkCuZ6ZZ8kfhHamXb4Vw7JGdgiMPiMeNZDOtIZABpzIlRI/EsVM6m
         W0KxBqLwBl8aYEQbCOiqdJclISsZs8BYwhKljVHUO4Oi5xLOQ1BkG4xvv+MobVzly2Po
         2UCSzUe7a/GxFrFnyXKRg/poPSWP7ZbQ71FT/5GN1lUn3E5yASgL137plmhPdHbN6ci/
         WrWw==
X-Gm-Message-State: ABy/qLZayhEGSN6dMIep0Fh++c9CL44ygz9Ww3LphOUxZJ3XcI2FG3jp
        xWArGdnwRI8hZttnXivqF5MXmQ==
X-Google-Smtp-Source: APBJJlHITvV64XzWf9SsC3Gc9f8URyA8qrsfJY0PwJLzJDE8ULmjuFQZ8qfCZnuilaE4S0mptQdgKw==
X-Received: by 2002:a5d:4e43:0:b0:313:f1ec:f429 with SMTP id r3-20020a5d4e43000000b00313f1ecf429mr4285517wrt.46.1690793583729;
        Mon, 31 Jul 2023 01:53:03 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:14b8:9aa7:6bf0:256d? ([2a01:e0a:982:cbb0:14b8:9aa7:6bf0:256d])
        by smtp.gmail.com with ESMTPSA id w10-20020a5d4b4a000000b003176c6e87b1sm12151354wrs.81.2023.07.31.01.53.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jul 2023 01:53:03 -0700 (PDT)
Message-ID: <768ae986-a67b-fedc-d43b-94096d1dd6bb@linaro.org>
Date:   Mon, 31 Jul 2023 10:53:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
From:   neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] firmware: meson_sm: fix to avoid potential NULL pointer
 dereference
Content-Language: en-US
To:     Zhang Shurong <zhang_shurong@foxmail.com>
Cc:     khilman@baylibre.com, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <tencent_AA08AAA6C4F34D53ADCE962E188A879B8206@qq.com>
Organization: Linaro Developer Services
In-Reply-To: <tencent_AA08AAA6C4F34D53ADCE962E188A879B8206@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/07/2023 16:13, Zhang Shurong wrote:
> of_match_device() may fail and returns a NULL pointer.
> 
> Fix this by checking the return value of of_match_device.
> 
> Fixes: 8cde3c2153e8 ("firmware: meson_sm: Rework driver as a proper platform driver")
> Signed-off-by: Zhang Shurong <zhang_shurong@foxmail.com>
> ---
>   drivers/firmware/meson/meson_sm.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/firmware/meson/meson_sm.c b/drivers/firmware/meson/meson_sm.c
> index 798bcdb05d84..9a2656d73600 100644
> --- a/drivers/firmware/meson/meson_sm.c
> +++ b/drivers/firmware/meson/meson_sm.c
> @@ -292,6 +292,8 @@ static int __init meson_sm_probe(struct platform_device *pdev)
>   		return -ENOMEM;
>   
>   	chip = of_match_device(meson_sm_ids, dev)->data;
> +	if (!chip)
> +		return -EINVAL;
>   
>   	if (chip->cmd_shmem_in_base) {
>   		fw->sm_shmem_in_base = meson_sm_map_shmem(chip->cmd_shmem_in_base,


Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
