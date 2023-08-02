Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 693A176CF06
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 15:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232556AbjHBNnd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 09:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232174AbjHBNna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 09:43:30 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E7A426A8
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 06:43:29 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-307d58b3efbso6092037f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 06:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690983808; x=1691588608;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wGJEBm4dQys0beO4Bm0mPgfPYBGDaDpTKYi50saQ/uA=;
        b=knokmoXugOTtLQBWN3e8aeYqcJvx2GR3L1faFmpjTGqC0zLQdu3wOrHa02gXLdrPsC
         1KYvA3SEgerxt6mpcET200sWT1doWORaDSTB7Smdq/vYezTDA/S9DkDve+ENpTmpN3GX
         yToMN6QFUDQPbIgKwM/o1a49km6e4GOr62S5NGFqU04gp7PUEhMb7ioQnLD/OKkboRuO
         byfTHeX6prnUUv68dv/dFcc+iCqK2RGF4DaQ/5oQe2OmOyc9Hr6oNQXWfkZZGByWrK12
         xvugDEDIf8jNw9U8cImcuE1iDsGYUhOeOVpfwmfT0Jt+AZe4XM5v9NyD0aHaRmvVBck7
         FGLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690983808; x=1691588608;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wGJEBm4dQys0beO4Bm0mPgfPYBGDaDpTKYi50saQ/uA=;
        b=gFA7hkt7oPXpTwpvM7Mrev7BFc9ynF2tyPUeny/aQhA8HRGkv8NsHcEsv+1vUg/2bU
         lVrBkLqbomoxZz3NdG8OH+qwBtbsyTepVBo7z7oNlIFSuxYX8g7+1Y19g+cEPsB7Nw+R
         tgQdUTg41Ctd5mbZg6ZvZln4kJFgvtA1eCI6CfouBYy4fhnm3gU8Xm0p+X48V/j6WNX7
         dCBPDcbT0CSu5dmxg+xOcBQ3/686tAcbeuqz/TxrT1HLIDtNnhHKzqdcZ/RYEE91kuBz
         wwWBsrpXgVOqENg6+RQ4KEGlw8Ybt10rNBERne9NgHUSMly96Bya6Q/ikuvxJ3tVOLvg
         x8wA==
X-Gm-Message-State: ABy/qLYZBjcK4TDAxyb14JFKrj6j8TxZneEK7/qiVNENytPMcEdYSLRc
        MyZFrBEv2ey2BUV20kFdZd47Ww==
X-Google-Smtp-Source: APBJJlHta3U/jq9uKyLui5LoG13PK/puAdJvu3OZxY8w7krdd53vHbw1TBTo18tiZELuw6M9TbPMyA==
X-Received: by 2002:a5d:54d2:0:b0:317:718a:e83f with SMTP id x18-20020a5d54d2000000b00317718ae83fmr4508067wrv.68.1690983807722;
        Wed, 02 Aug 2023 06:43:27 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id x2-20020adfdd82000000b0030e56a9ff25sm19013745wrl.31.2023.08.02.06.43.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Aug 2023 06:43:27 -0700 (PDT)
Message-ID: <4059684f-2e44-ccd6-4c65-5137cc76492c@linaro.org>
Date:   Wed, 2 Aug 2023 14:43:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3] misc: fastrpc: Fix incorrect DMA mapping unmap request
Content-Language: en-US
To:     Ekansh Gupta <quic_ekangupt@quicinc.com>,
        linux-arm-msm@vger.kernel.org
Cc:     ekangupt@qti.qualcomm.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, fastrpc.upstream@qti.qualcomm.com,
        stable <stable@kernel.org>
References: <1690953032-17070-1-git-send-email-quic_ekangupt@quicinc.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <1690953032-17070-1-git-send-email-quic_ekangupt@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/08/2023 06:10, Ekansh Gupta wrote:
> Scatterlist table is obtained during map create request and the same
> table is used for DMA mapping unmap. In case there is any failure
> while getting the sg_table, ERR_PTR is returned instead of sg_table.
> 
> When the map is getting freed, there is only a non-NULL check of
> sg_table which will also be true in case failure was returned instead
> of sg_table. This would result in improper unmap request. Add proper
> check before setting map table to avoid bad unmap request.
> 
> Fixes: c68cfb718c8f ("misc: fastrpc: Add support for context Invoke method")
> Cc: stable <stable@kernel.org>
> Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
> ---
> Changes in v2:
>    - Added fixes information to commit text
> Changes in v3:
>    - Set map->table only if attachment for successful
> 
>   drivers/misc/fastrpc.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index 9666d28..de7c812 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -756,6 +756,7 @@ static int fastrpc_map_create(struct fastrpc_user *fl, int fd,
>   {
>   	struct fastrpc_session_ctx *sess = fl->sctx;
>   	struct fastrpc_map *map = NULL;
> +	struct sg_table *table;
>   	int err = 0;
>   
>   	if (!fastrpc_map_lookup(fl, fd, ppmap, true))
> @@ -783,11 +784,12 @@ static int fastrpc_map_create(struct fastrpc_user *fl, int fd,
>   		goto attach_err;
>   	}
>   
> -	map->table = dma_buf_map_attachment_unlocked(map->attach, DMA_BIDIRECTIONAL);
> -	if (IS_ERR(map->table)) {
> -		err = PTR_ERR(map->table);
> +	table = dma_buf_map_attachment(map->attach, DMA_BIDIRECTIONAL);

Any reason why dma_buf_map_attachment_unlocked changed to 
dma_buf_map_attachment?

--srini
> +	if (IS_ERR(table)) {
> +		err = PTR_ERR(table);
>   		goto map_err;
>   	}
> +	map->table = table;
>   
>   	if (attr & FASTRPC_ATTR_SECUREMAP) {
>   		map->phys = sg_phys(map->table->sgl);
