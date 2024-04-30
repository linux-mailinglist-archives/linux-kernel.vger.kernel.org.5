Return-Path: <linux-kernel+bounces-163356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D8B8B69C5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 07:15:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20226285BDE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 05:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9918718044;
	Tue, 30 Apr 2024 05:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jPrMGh9I"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474D517BBF;
	Tue, 30 Apr 2024 05:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714454122; cv=none; b=NNOV5PN9xz+aFXlUk+o9WPVk7gK4VIomJin3gZkIT213lkcJAqKExngIaTDR23DgmBL/6+bJ/3QtAnDwmKPcVsuctclJzXQjCw+xq/azyHh3HeqTQ1SBUTQKc4tPdhuxzZkxK5ilbQZdV54chQzX9S0xQRfXyJ9OEtd8oMOcqpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714454122; c=relaxed/simple;
	bh=Mrqb28j3cg1S8R/hkdlGfeMM4TLciHksWoU3jt4WOEc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F6Zk6R08kz7HiY1Ld0hCa7FMSK4MfIlZiPtWAw4NRtkrGaIoWLcIon/vEDxZvQnRzjyYQ5m0zjOU5hsQ3SR0gjsxjKfT9J2l3jm1vzTLL0zjsaez8TVB3IdRxQ/P7YbIEI+qG3qXBG65MvpSiHF5T3Xfpnf865W9CuwuosOTQis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jPrMGh9I; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-41bab13ca4eso25521505e9.1;
        Mon, 29 Apr 2024 22:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714454120; x=1715058920; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V5c0MrtuYndD4ZSoLwxQnnGXS/g1185v6hok/3pUhLs=;
        b=jPrMGh9I+iqwzJLhis5ubGiBMExbC7VH7+UiBQF6Acnox4mUte/CYDB5nKrN5Mn2vi
         XnCTqqshkBIyls482fclDUDOF3PlBLVKmelqgxc66uWcJqqlCem58uJtZWkPKLOcanQR
         F5ForAg4oONEEtYsS7OGlUtgPbV12Zk2K6buqedjXIf+dcCttVeBwETQpCvQUSaAA3Sq
         Iw2oH1Z6zXtMLDgE5x7Sn2E2UKUlmrNOsjL3gktq97GGiVoOXv/5KIrKxEkt4uFafsoM
         QTCLhkgFOwuGGzoYa5kVVpSbs1FprKuDO1UEBoRxAoKuKLD+T9tiee7hRxqvQ6wc4sZ+
         XJxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714454120; x=1715058920;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V5c0MrtuYndD4ZSoLwxQnnGXS/g1185v6hok/3pUhLs=;
        b=WRbxeze4YyY6+SRTtlw38p7MPvkJR9Q2NecDjmRFlBTHR9CaN7hfPyGJonslzl738X
         4wP09KyhFhrCFMCQvSa8XHfiqrNJzxdOwYPoUyw/qoMJd0HF0nuQbAz+MGjO7uyf6+AZ
         hkpAkinRM92obAkMphKOidiFDMFJRt7tVO1Gt7kfsUqkvyNq86NJPZg61tTG1DAWOsQm
         tsJB7NxdHz3O25B3Qa3lFvK9qwB5HghC8rm1K1ZwobG18D9CdhEku5Ati64TRuBqkRX/
         nfoODAKpSSoMakwE5tXa0tGzAn2Zb5Ea1ZOc5gSy4JjD3WjxSXnhTWq8R7Sag9IJnbE6
         9CeA==
X-Forwarded-Encrypted: i=1; AJvYcCXAx1paocs9xNR54g4IOdST9Z/s0VVIkTgGSXnUNvRSqVXUzNZ5h+d3TOs1vEJR9W+u8bbc9uE14KsO0OUxljOvSkV3lzvc
X-Gm-Message-State: AOJu0Yy+jF6EIE+WHBX+iODu4qO6VZCnkNEhlOtyg3wZexm6/ENGXEmp
	e0fMFveVXFLLsh7cN1EXBueD5X2QiOF4NerPwUD+Pr+Dd+CohtPT29XxxQ==
X-Google-Smtp-Source: AGHT+IG629YYhe/zAWAixthnGqw5lKcbI98CSQq0Ilbidef0mEkPXq/TxcjC/TvjSEsHwH2iKeGlmQ==
X-Received: by 2002:a05:600c:358c:b0:41b:13a3:6183 with SMTP id p12-20020a05600c358c00b0041b13a36183mr9207421wmq.24.1714454119402;
        Mon, 29 Apr 2024 22:15:19 -0700 (PDT)
Received: from [172.27.19.83] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id t20-20020a05600c199400b0041c012ca327sm9103986wmq.45.2024.04.29.22.15.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Apr 2024 22:15:18 -0700 (PDT)
Message-ID: <25a4890f-8b6f-4fb3-970f-b022b7ad5be8@gmail.com>
Date: Tue, 30 Apr 2024 08:15:14 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] net/mlx5e: flower: check for unsupported
 control flags
To: =?UTF-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>,
 netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>,
 Tariq Toukan <tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Jianbo Liu <jianbol@nvidia.com>
References: <20240422152728.175677-1-ast@fiberby.net>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20240422152728.175677-1-ast@fiberby.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 22/04/2024 18:27, Asbjørn Sloth Tønnesen wrote:
> Use flow_rule_is_supp_control_flags() to reject filters
> with unsupported control flags.
> 
> In case any unsupported control flags are masked,
> flow_rule_is_supp_control_flags() sets a NL extended
> error message, and we return -EOPNOTSUPP.
> 
> Remove FLOW_DIS_FIRST_FRAG specific error message,
> and treat it as any other unsupported control flag.
> 
> Only compile-tested.
> 
> Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
> ---
> 
> Changelog:
> 
> v2:
> - remove existing FLOW_DIS_FIRST_FRAG "support" (requested by Jianbo)
> 
> v1: https://lore.kernel.org/netdev/20240417135110.99900-1-ast@fiberby.net/
> 
>   drivers/net/ethernet/mellanox/mlx5/core/en_tc.c | 10 ++++------
>   1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
> index aeb32cb27182..30673292e15f 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
> @@ -2801,12 +2801,6 @@ static int __parse_cls_flower(struct mlx5e_priv *priv,
>   		flow_rule_match_control(rule, &match);
>   		addr_type = match.key->addr_type;
>   
> -		/* the HW doesn't support frag first/later */
> -		if (match.mask->flags & FLOW_DIS_FIRST_FRAG) {
> -			NL_SET_ERR_MSG_MOD(extack, "Match on frag first/later is not supported");
> -			return -EOPNOTSUPP;
> -		}
> -
>   		if (match.mask->flags & FLOW_DIS_IS_FRAGMENT) {
>   			MLX5_SET(fte_match_set_lyr_2_4, headers_c, frag, 1);
>   			MLX5_SET(fte_match_set_lyr_2_4, headers_v, frag,
> @@ -2819,6 +2813,10 @@ static int __parse_cls_flower(struct mlx5e_priv *priv,
>   			else
>   				*match_level = MLX5_MATCH_L3;
>   		}
> +
> +		if (!flow_rule_is_supp_control_flags(FLOW_DIS_IS_FRAGMENT,
> +						     match.mask->flags, extack))
> +			return -EOPNOTSUPP;
>   	}
>   
>   	if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_BASIC)) {

Acked-by: Tariq Toukan <tariqt@nvidia.com>

