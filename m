Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE0BC761002
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 11:59:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbjGYJ7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 05:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbjGYJ7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 05:59:38 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2599172A;
        Tue, 25 Jul 2023 02:59:36 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3fde57684d7so10177665e9.2;
        Tue, 25 Jul 2023 02:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690279175; x=1690883975;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MGdVpZtBmbwmhYgJpcNajCO1AQt0qi9mtHbUi3y1yvU=;
        b=csEqZMGPsaPiUebQL7JAjUFbe6oOJKpGlyNLie0FDka2+kDVdNdI53C+0dI0MdueLe
         /+IJP+E5AHh7lUkVud2TKZFGpuWENjrFw+DUz5d0eyWnyxZCd/PABldyfq3snhTcQQHL
         pj0g1BrwPKJxCPYGRP9gZxEJSrLlYhDxPnvIftwNgBkwMQTEU9jFvDZY4cqQk7JuY/6P
         8a8kJSaoD8Ba/6wn3SxbXYHMp2wHSy+/y2104kCV7GlTKtd/BhEu82wBAqIeJvdHCB9P
         zZSUaXO3BDW7mnJfj4QDoG0tdmLMEh8DRJ/azyjOK3oImCIa4GpK0YxPVfXbXg9KqmUE
         9+Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690279175; x=1690883975;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MGdVpZtBmbwmhYgJpcNajCO1AQt0qi9mtHbUi3y1yvU=;
        b=ZSseuTey/+LwmShSciXi4Ese4esGA9fFsUSFWhnptFDc+MkA23rPuf2rp5Qf00V4EF
         XpSNBVQQdyEHEuwsYfsQSwFiJpAZC1lU4M66LjtSRWyXdEGW7R/2LAvYn03EGbg8KMPi
         YeoUALvlQTePepoisiSj0bzcqHB8uLFL3yhEwwwkDRJ1utt8bJy3tXMY7Q0WP9LrCVp3
         WrqvNLqDC+el+jAFQS9l/TNZtTA7vKtIFWnFFZPfFhJOtVII12FxutHafET2SwdwBWOj
         n/F9Aetg70hiS+4VuF1Th93QxEWAAP1KYy0pQ2viogyDqVwpHmqtn9bPnFU0QzaJ40Ce
         PIrA==
X-Gm-Message-State: ABy/qLZzPQT4nC8LYZQKwFHhfUW90AHHeJNQQj4I08fi7h35VNNxCrrH
        SV3EMhzURnQ88S2qZCZ5KTY=
X-Google-Smtp-Source: APBJJlH6xbonNLwtaIDRwH9lt6LPIGBo3jPuLj7MJkwJ4FfH4MKN9vl6rM+OEgj1/5seah7ElkZ2wQ==
X-Received: by 2002:a1c:ed0f:0:b0:3fb:a506:5656 with SMTP id l15-20020a1ced0f000000b003fba5065656mr8376732wmh.32.1690279175073;
        Tue, 25 Jul 2023 02:59:35 -0700 (PDT)
Received: from [192.168.0.103] ([77.126.7.132])
        by smtp.gmail.com with ESMTPSA id f2-20020a7bc8c2000000b003fb225d414fsm15299499wml.21.2023.07.25.02.59.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jul 2023 02:59:34 -0700 (PDT)
Message-ID: <d950f4f6-6581-a99f-3375-c0359d45c9f5@gmail.com>
Date:   Tue, 25 Jul 2023 12:59:32 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [net 2/2] net/mlx5: Fix flowhash key set/get for custom RSS
Content-Language: en-US
To:     Joe Damato <jdamato@fastly.com>, netdev@vger.kernel.org,
        saeedm@nvidia.com, ecree@solarflare.com, andrew@lunn.ch,
        kuba@kernel.org, davem@davemloft.net, leon@kernel.org,
        pabeni@redhat.com, bhutchings@solarflare.com, arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org, Tariq Toukan <tariqt@nvidia.com>
References: <20230723150658.241597-1-jdamato@fastly.com>
 <20230723150658.241597-3-jdamato@fastly.com>
From:   Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20230723150658.241597-3-jdamato@fastly.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23/07/2023 18:06, Joe Damato wrote:
> mlx5 flow hash field retrieval and set only worked on the default
> RSS context, not custom RSS contexts.
> 
> For example, before this patch attempting to retrieve the flow hash fields
> for RSS context 1 fails:
> 

Hi,

You are adding new driver functionality, please take it through net-next.

> $ sudo ethtool -u eth1 rx-flow-hash tcp4 context 1
> Cannot get RX network flow hashing options: Invalid argument
> 
> This patch fixes getting and setting the flow hash fields for contexts
> other than the default context.
> 
> Getting the flow hash fields for RSS context 1:
> 
> sudo ethtool -u eth1 rx-flow-hash tcp4 context 1
> For RSS context 1:
> TCP over IPV4 flows use these fields for computing Hash flow key:
> IP DA
> 
> Now, setting the flash hash fields to a custom value:
> 
> sudo ethtool -U eth1 rx-flow-hash tcp4 sdfn context 1
> 
> And retrieving them again:
> 
> sudo ethtool -u eth1 rx-flow-hash tcp4 context 1
> For RSS context 1:
> TCP over IPV4 flows use these fields for computing Hash flow key:
> IP SA
> IP DA
> L4 bytes 0 & 1 [TCP/UDP src port]
> L4 bytes 2 & 3 [TCP/UDP dst port]
> 
> Fixes: f01cc58c18d6 ("net/mlx5e: Support multiple RSS contexts")
> Signed-off-by: Joe Damato <jdamato@fastly.com>
> ---
>   .../ethernet/mellanox/mlx5/core/en/rx_res.c   | 23 ++++++++++---
>   .../ethernet/mellanox/mlx5/core/en/rx_res.h   |  5 +--
>   .../mellanox/mlx5/core/en_fs_ethtool.c        | 33 ++++++++++++++-----
>   3 files changed, 46 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.c b/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.c
> index e1095bc36543..bb189c92e4c0 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.c
> @@ -218,17 +218,32 @@ int mlx5e_rx_res_rss_set_rxfh(struct mlx5e_rx_res *res, u32 rss_idx,
>   	return mlx5e_rss_set_rxfh(rss, indir, key, hfunc, res->rss_rqns, res->rss_nch);
>   }
>   
> -u8 mlx5e_rx_res_rss_get_hash_fields(struct mlx5e_rx_res *res, enum mlx5_traffic_types tt)
> +int mlx5e_rx_res_rss_get_hash_fields(struct mlx5e_rx_res *res, enum mlx5_traffic_types tt,
> +				     u32 rss_idx)

For consistency with other functions, please keep the rss_idx next to 
the res argument.

>   {
> -	struct mlx5e_rss *rss = res->rss[0];
> +	struct mlx5e_rss *rss;
> +
> +	if (rss_idx >= MLX5E_MAX_NUM_RSS)
> +		return -EINVAL;
> +
> +	rss = res->rss[rss_idx];
> +	if (!rss)
> +		return -EINVAL;

return -ENOENT; in this case.

>   
>   	return mlx5e_rss_get_hash_fields(rss, tt);
>   }
>   
>   int mlx5e_rx_res_rss_set_hash_fields(struct mlx5e_rx_res *res, enum mlx5_traffic_types tt,
> -				     u8 rx_hash_fields)
> +				     u8 rx_hash_fields, u32 rss_idx)

Same. let rss_idx come as second argument.
>   {
> -	struct mlx5e_rss *rss = res->rss[0];
> +	struct mlx5e_rss *rss;
> +
> +	if (rss_idx >= MLX5E_MAX_NUM_RSS)
> +		return -EINVAL;
> +
> +	rss = res->rss[rss_idx];
> +	if (!rss)
> +		return -EINVAL;

ENOENT

>   
>   	return mlx5e_rss_set_hash_fields(rss, tt, rx_hash_fields);
>   }
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.h b/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.h
> index 5d5f64fab60f..8ac9d67a9603 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.h
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.h
> @@ -48,9 +48,10 @@ int mlx5e_rx_res_rss_get_rxfh(struct mlx5e_rx_res *res, u32 rss_idx,
>   int mlx5e_rx_res_rss_set_rxfh(struct mlx5e_rx_res *res, u32 rss_idx,
>   			      const u32 *indir, const u8 *key, const u8 *hfunc);
>   
> -u8 mlx5e_rx_res_rss_get_hash_fields(struct mlx5e_rx_res *res, enum mlx5_traffic_types tt);
> +int mlx5e_rx_res_rss_get_hash_fields(struct mlx5e_rx_res *res, enum mlx5_traffic_types tt,
> +				     u32 rss_idx);
>   int mlx5e_rx_res_rss_set_hash_fields(struct mlx5e_rx_res *res, enum mlx5_traffic_types tt,
> -				     u8 rx_hash_fields);
> +				     u8 rx_hash_fields, u32 rss_idx);
>   int mlx5e_rx_res_packet_merge_set_param(struct mlx5e_rx_res *res,
>   					struct mlx5e_packet_merge_param *pkt_merge_param);
>   
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_fs_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_fs_ethtool.c
> index aac32e505c14..50b8f3da4db1 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_fs_ethtool.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_fs_ethtool.c
> @@ -902,8 +902,14 @@ static int mlx5e_set_rss_hash_opt(struct mlx5e_priv *priv,
>   	u8 rx_hash_field = 0;
>   	int err;
>   	int tt;
> +	u32 flow_type = 0;
> +	u32 rss_idx = 0;
>   
> -	tt = flow_type_to_traffic_type(nfc->flow_type);
> +	if (nfc->flow_type & FLOW_RSS)
> +		rss_idx = nfc->rss_context;
> +
> +	flow_type = flow_type_mask(nfc->flow_type);
> +	tt = flow_type_to_traffic_type(flow_type);
>   	if (tt < 0)
>   		return tt;
>   
> @@ -911,10 +917,10 @@ static int mlx5e_set_rss_hash_opt(struct mlx5e_priv *priv,
>   	 *  on src IP, dest IP, TCP/UDP src port and TCP/UDP dest
>   	 *  port.
>   	 */
> -	if (nfc->flow_type != TCP_V4_FLOW &&
> -	    nfc->flow_type != TCP_V6_FLOW &&
> -	    nfc->flow_type != UDP_V4_FLOW &&
> -	    nfc->flow_type != UDP_V6_FLOW)
> +	if (flow_type != TCP_V4_FLOW &&
> +	    flow_type != TCP_V6_FLOW &&
> +	    flow_type != UDP_V4_FLOW &&
> +	    flow_type != UDP_V6_FLOW)
>   		return -EOPNOTSUPP;
>   
>   	if (nfc->data & ~(RXH_IP_SRC | RXH_IP_DST |
> @@ -931,7 +937,7 @@ static int mlx5e_set_rss_hash_opt(struct mlx5e_priv *priv,
>   		rx_hash_field |= MLX5_HASH_FIELD_SEL_L4_DPORT;
>   
>   	mutex_lock(&priv->state_lock);
> -	err = mlx5e_rx_res_rss_set_hash_fields(priv->rx_res, tt, rx_hash_field);
> +	err = mlx5e_rx_res_rss_set_hash_fields(priv->rx_res, tt, rx_hash_field, rss_idx);
>   	mutex_unlock(&priv->state_lock);
>   
>   	return err;
> @@ -940,14 +946,23 @@ static int mlx5e_set_rss_hash_opt(struct mlx5e_priv *priv,
>   static int mlx5e_get_rss_hash_opt(struct mlx5e_priv *priv,
>   				  struct ethtool_rxnfc *nfc)
>   {
> -	u32 hash_field = 0;
> +	int hash_field = 0;
>   	int tt;
> +	u32 flow_type = 0;
> +	u32 rss_idx = 0;

Please maintain the reversed Christmas tree.

> +
> +	if (nfc->flow_type & FLOW_RSS)
> +		rss_idx = nfc->rss_context;
>   
> -	tt = flow_type_to_traffic_type(nfc->flow_type);
> +	flow_type = flow_type_mask(nfc->flow_type);
> +	tt = flow_type_to_traffic_type(flow_type);
>   	if (tt < 0)
>   		return tt;
>   
> -	hash_field = mlx5e_rx_res_rss_get_hash_fields(priv->rx_res, tt);
> +	hash_field = mlx5e_rx_res_rss_get_hash_fields(priv->rx_res, tt, rss_idx);
> +	if (hash_field < 0)
> +		return hash_field;
> +
>   	nfc->data = 0;
>   
>   	if (hash_field & MLX5_HASH_FIELD_SEL_SRC_IP)
