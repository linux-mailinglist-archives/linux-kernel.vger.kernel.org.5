Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06F00763032
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 10:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232955AbjGZIpu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 04:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233361AbjGZIpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 04:45:19 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0C3F9039;
        Wed, 26 Jul 2023 01:36:16 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-51e28b299adso10126032a12.2;
        Wed, 26 Jul 2023 01:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690360575; x=1690965375;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9lDtPwlnqFi+Pxc9eb2CzqT+KhOzB614cfcdljh8aNI=;
        b=ombDfrsmXFFx7tZTU95kSadB0aUjp8WUCTWnwC59B/PD43h2kApX322Wm7nTu5EgG9
         FtDXdFsjrng3fh5lEnwF6TTBOcgaX4Mpsw/Y56jhp/5PFwNVdLnktt3a5qsVL8DR26at
         lVWn3G5vOZHGoSOQjJMjPSkPymwsMyiz0Sk1AgABCN7LMpZuuMSg5+uBVR55aSDk+qGh
         IHSojOObt7z51QvpP3xUFQBNadCC6CzlqVhECyEY2Hhij/KviwaZg6t5+R71yDDQhvwS
         5i9VlpIh9YjyiYKjpc2NALWxtiwNrS+RtB0Fc8Noc08hqzKQxdcDgRQ35IePXn4rhBcI
         6hRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690360575; x=1690965375;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9lDtPwlnqFi+Pxc9eb2CzqT+KhOzB614cfcdljh8aNI=;
        b=WQHiL1ChkHWs81iaQd9o+5sSVC5C/ayg+9dRnUbwUggjnAqJX9qbbe9uBdQH8dHOj4
         xMIEAZf6HaKnQnfXaXa7fJ7Ir8Pc7ICPOpqHHNPGXUTaXQ4YUvpKaeSVKq/opexcDxfh
         ciX3CFFPmDJBB5NPhWW4kGMPuGIOmHjCiaskX8R9HJ40ZGorxAvuoLZKMsyTXBdoNcJm
         Pv6mJxdN6LbWe7MvBUb9yhxLK2ugP1f4wpd9116Nyac/7MzA54MEoCLABNV1Re5Iggt0
         f+m1T+aYaNp+kkIafYUHuSnEZD8KPKif7PT50n0u6pshePeWl68Rq7PpZBtBLK1TkoMo
         +Lqw==
X-Gm-Message-State: ABy/qLZm1/+cl9EwycMWY48yLMPNfTmA8cHf3bPkWtdk7/wNsI7QpYZK
        C49yAdv1K70i6SlEyNeOEck=
X-Google-Smtp-Source: APBJJlFO0wfm+kPK1wCwPdmV6q6+uN4GXUfE/lOLov165qfUKHF97CzGRZKoIaxyeJbUQDBKsTxpAA==
X-Received: by 2002:aa7:dcc6:0:b0:521:d75d:ef69 with SMTP id w6-20020aa7dcc6000000b00521d75def69mr1016913edu.31.1690360574779;
        Wed, 26 Jul 2023 01:36:14 -0700 (PDT)
Received: from [192.168.0.103] ([77.126.7.132])
        by smtp.gmail.com with ESMTPSA id h1-20020aa7de01000000b0051a4fcf7187sm8522805edv.62.2023.07.26.01.36.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 01:36:14 -0700 (PDT)
Message-ID: <e9fb9cc0-6e6f-ee78-8e7d-b4a1af38d5c2@gmail.com>
Date:   Wed, 26 Jul 2023 11:36:11 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [net-next v2 2/2] net/mlx5: Fix flowhash key set/get for custom
 RSS
Content-Language: en-US
To:     Joe Damato <jdamato@fastly.com>, netdev@vger.kernel.org,
        saeedm@nvidia.com, ecree@solarflare.com, andrew@lunn.ch,
        kuba@kernel.org, davem@davemloft.net, leon@kernel.org,
        pabeni@redhat.com, arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org, Tariq Toukan <tariqt@nvidia.com>
References: <20230725205655.310165-1-jdamato@fastly.com>
 <20230725205655.310165-3-jdamato@fastly.com>
From:   Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20230725205655.310165-3-jdamato@fastly.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25/07/2023 23:56, Joe Damato wrote:
> mlx5 flow hash field retrieval and set only worked on the default
> RSS context as of commit f01cc58c18d6 ("net/mlx5e: Support multiple RSS
> contexts"), not custom RSS contexts.
> 
> For example, before this patch attempting to retrieve the flow hash fields
> for RSS context 1 fails:
> 
> $ sudo ethtool -u eth1 rx-flow-hash tcp4 context 1
> Cannot get RX network flow hashing options: Invalid argument
> 
> This patch fixes getting and setting the flow hash fields for contexts
> other than the default context.
> 
> Getting the flow hash fields for RSS context 1:
> 
> $ sudo ethtool -u eth1 rx-flow-hash tcp4 context 1
> For RSS context 1:
> TCP over IPV4 flows use these fields for computing Hash flow key:
> IP DA
> 
> Now, setting the flash hash fields to a custom value:
> 
> $ sudo ethtool -U eth1 rx-flow-hash tcp4 sdfn context 1
> 
> And retrieving them again:
> 
> $ sudo ethtool -u eth1 rx-flow-hash tcp4 context 1
> For RSS context 1:
> TCP over IPV4 flows use these fields for computing Hash flow key:
> IP SA
> IP DA
> L4 bytes 0 & 1 [TCP/UDP src port]
> L4 bytes 2 & 3 [TCP/UDP dst port]
> 
> Signed-off-by: Joe Damato <jdamato@fastly.com>

Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Thanks for your patch.

> ---
>   .../ethernet/mellanox/mlx5/core/en/rx_res.c   | 25 +++++++++++---
>   .../ethernet/mellanox/mlx5/core/en/rx_res.h   |  7 ++--
>   .../mellanox/mlx5/core/en_fs_ethtool.c        | 33 ++++++++++++++-----
>   3 files changed, 48 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.c b/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.c
> index e1095bc36543..56e6b8c7501f 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.c
> @@ -218,17 +218,32 @@ int mlx5e_rx_res_rss_set_rxfh(struct mlx5e_rx_res *res, u32 rss_idx,
>   	return mlx5e_rss_set_rxfh(rss, indir, key, hfunc, res->rss_rqns, res->rss_nch);
>   }
>   
> -u8 mlx5e_rx_res_rss_get_hash_fields(struct mlx5e_rx_res *res, enum mlx5_traffic_types tt)
> +int mlx5e_rx_res_rss_get_hash_fields(struct mlx5e_rx_res *res, u32 rss_idx,
> +				     enum mlx5_traffic_types tt)
>   {
> -	struct mlx5e_rss *rss = res->rss[0];
> +	struct mlx5e_rss *rss;
> +
> +	if (rss_idx >= MLX5E_MAX_NUM_RSS)
> +		return -EINVAL;
> +
> +	rss = res->rss[rss_idx];
> +	if (!rss)
> +		return -ENOENT;
>   
>   	return mlx5e_rss_get_hash_fields(rss, tt);
>   }
>   
> -int mlx5e_rx_res_rss_set_hash_fields(struct mlx5e_rx_res *res, enum mlx5_traffic_types tt,
> -				     u8 rx_hash_fields)
> +int mlx5e_rx_res_rss_set_hash_fields(struct mlx5e_rx_res *res, u32 rss_idx,
> +				     enum mlx5_traffic_types tt, u8 rx_hash_fields)
>   {
> -	struct mlx5e_rss *rss = res->rss[0];
> +	struct mlx5e_rss *rss;
> +
> +	if (rss_idx >= MLX5E_MAX_NUM_RSS)
> +		return -EINVAL;
> +
> +	rss = res->rss[rss_idx];
> +	if (!rss)
> +		return -ENOENT;
>   
>   	return mlx5e_rss_set_hash_fields(rss, tt, rx_hash_fields);
>   }
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.h b/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.h
> index 5d5f64fab60f..580fe8bc3cd2 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.h
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.h
> @@ -48,9 +48,10 @@ int mlx5e_rx_res_rss_get_rxfh(struct mlx5e_rx_res *res, u32 rss_idx,
>   int mlx5e_rx_res_rss_set_rxfh(struct mlx5e_rx_res *res, u32 rss_idx,
>   			      const u32 *indir, const u8 *key, const u8 *hfunc);
>   
> -u8 mlx5e_rx_res_rss_get_hash_fields(struct mlx5e_rx_res *res, enum mlx5_traffic_types tt);
> -int mlx5e_rx_res_rss_set_hash_fields(struct mlx5e_rx_res *res, enum mlx5_traffic_types tt,
> -				     u8 rx_hash_fields);
> +int mlx5e_rx_res_rss_get_hash_fields(struct mlx5e_rx_res *res, u32 rss_idx,
> +				     enum mlx5_traffic_types tt);
> +int mlx5e_rx_res_rss_set_hash_fields(struct mlx5e_rx_res *res, u32 rss_idx,
> +				     enum mlx5_traffic_types tt, u8 rx_hash_fields);
>   int mlx5e_rx_res_packet_merge_set_param(struct mlx5e_rx_res *res,
>   					struct mlx5e_packet_merge_param *pkt_merge_param);
>   
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_fs_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_fs_ethtool.c
> index aac32e505c14..aed599db9d84 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_fs_ethtool.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_fs_ethtool.c
> @@ -900,10 +900,16 @@ static int mlx5e_set_rss_hash_opt(struct mlx5e_priv *priv,
>   				  struct ethtool_rxnfc *nfc)
>   {
>   	u8 rx_hash_field = 0;
> +	u32 flow_type = 0;
> +	u32 rss_idx = 0;
>   	int err;
>   	int tt;
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
> +	err = mlx5e_rx_res_rss_set_hash_fields(priv->rx_res, rss_idx, tt, rx_hash_field);
>   	mutex_unlock(&priv->state_lock);
>   
>   	return err;
> @@ -940,14 +946,23 @@ static int mlx5e_set_rss_hash_opt(struct mlx5e_priv *priv,
>   static int mlx5e_get_rss_hash_opt(struct mlx5e_priv *priv,
>   				  struct ethtool_rxnfc *nfc)
>   {
> -	u32 hash_field = 0;
> +	int hash_field = 0;
> +	u32 flow_type = 0;
> +	u32 rss_idx = 0;
>   	int tt;
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
> -	hash_field = mlx5e_rx_res_rss_get_hash_fields(priv->rx_res, tt);
> +	hash_field = mlx5e_rx_res_rss_get_hash_fields(priv->rx_res, rss_idx, tt);
> +	if (hash_field < 0)
> +		return hash_field;
> +
>   	nfc->data = 0;
>   
>   	if (hash_field & MLX5_HASH_FIELD_SEL_SRC_IP)
