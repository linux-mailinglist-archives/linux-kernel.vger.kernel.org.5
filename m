Return-Path: <linux-kernel+bounces-8021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 559D981B0B9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 09:52:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 117BA281E6F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 08:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E3D200BD;
	Thu, 21 Dec 2023 08:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="tCl0HfaC"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A504171A4
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 08:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-553729ee917so606163a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 00:52:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1703148764; x=1703753564; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FTIeI4DoPouDjkk2jweCozK50yrWApKhZHnyb+L8pDY=;
        b=tCl0HfaC6gpWclJVr+uRVlaLWmt0SfABWXaVH0xERTEXjwgwQjs+6KKfWQ9izwXkqp
         GNssuQcbIqeBeG09t1O50sSlSyIKq1GWOAP7kdZcb4HMP/59tscVwoJQ0K17eFCXlE1I
         7zkxnUQQ6j0esiCoRrC9g02KI3r5LYzHIzXJWLaoB96FA5wyOOVdAtkIldXpDMmzYyXx
         oULUS8qVr40jna8sKGV3GCAuIxSy1Quo+RK/UvrtgM23bNJXMXBlH/VegEjPSuXTW2AX
         Ok5tZnqw/iUVz4opoNq5rVgAzhjxL26WB5hhWC6LtPeh7fN03/vAHxFFCfBynC0D48e0
         5rhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703148764; x=1703753564;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FTIeI4DoPouDjkk2jweCozK50yrWApKhZHnyb+L8pDY=;
        b=kCjmkDEkozCucg6kZcgoYTtNuy7cPU0/L724Hi+eEsBeDzHPWhviHcy0JVZT8KgZOc
         ZraoIcYVUJg9m3s4k60SKjiKljB+n7/aVe/pbGHddBW8bWRYzwBPHFV+G1DJokt9mB2m
         15+33ahGudBsg2kpcUAAxi20IXCKIiPmygyl+7cW9cY0eYVeXvwyRLD5bU7wmCXrivUp
         vOmdx+LkSd1S3zKDlq+kMT92bL58F1FX78Dma/cKgzUL40la+6OJ2zAZ5Tm7uu7nJzcQ
         3xFkAKwRTfg3vWqz30iXiXOpTsvQ+mkHQTZ5eu61MqWUyxw+u7JMHj27lV7/e0b6RVPe
         2I0A==
X-Gm-Message-State: AOJu0YzpB6Tuta6DbIc/jKYPRoovclUpWF8teMJnb5RFTwSeZWYlycg8
	iPOJcirwGdkd2AkI8GXCBi4XZw==
X-Google-Smtp-Source: AGHT+IEWMOTPB9r62Wb7FIh3oonVv5j6dbF/GZFxvecSF5+3yVgCdDo/ASxWxlvTlimQhzhpshBYqg==
X-Received: by 2002:a17:906:4e82:b0:a26:98ff:6464 with SMTP id v2-20020a1709064e8200b00a2698ff6464mr994115eju.17.1703148763984;
        Thu, 21 Dec 2023 00:52:43 -0800 (PST)
Received: from [192.168.0.161] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id rh9-20020a17090720e900b00a269e87ad84sm707136ejb.189.2023.12.21.00.52.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Dec 2023 00:52:43 -0800 (PST)
Message-ID: <dff34170-fc5d-4344-b6a2-6af2b2903208@blackwall.org>
Date: Thu, 21 Dec 2023 10:52:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] bridge: cfm: fix enum typo in
 br_cc_ccm_tx_parse
To: Lin Ma <linma@zju.edu.cn>, roopa@nvidia.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horatiu.vultur@microchip.com, henrik.bjoernlund@microchip.com,
 bridge@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, horms@kernel.org
References: <20231220163451.2720130-1-linma@zju.edu.cn>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20231220163451.2720130-1-linma@zju.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20/12/2023 18:34, Lin Ma wrote:
> It appears that there is a typo in the code where the nlattr array is
> being parsed with policy br_cfm_cc_ccm_tx_policy, but the instance is
> being accessed via IFLA_BRIDGE_CFM_CC_RDI_INSTANCE, which is associated
> with the policy br_cfm_cc_rdi_policy.
> 
> This problem was introduced by commit 2be665c3940d ("bridge: cfm: Netlink
> SET configuration Interface.").
> 
> Though it seems like a harmless typo since these two enum owns the exact
> same value (1 here), it is quite misleading hence fix it by using the
> correct enum IFLA_BRIDGE_CFM_CC_CCM_TX_INSTANCE here.
> 
> Signed-off-by: Lin Ma <linma@zju.edu.cn>
> Reviewed-by: Simon Horman <horms@kernel.org>
> ---
> V1 -> V2: remove Fixes tag as this patch resolves nothing but a typo.
> 
>  net/bridge/br_cfm_netlink.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/bridge/br_cfm_netlink.c b/net/bridge/br_cfm_netlink.c
> index 5c4c369f8536..2faab44652e7 100644
> --- a/net/bridge/br_cfm_netlink.c
> +++ b/net/bridge/br_cfm_netlink.c
> @@ -362,7 +362,7 @@ static int br_cc_ccm_tx_parse(struct net_bridge *br, struct nlattr *attr,
>  
>  	memset(&tx_info, 0, sizeof(tx_info));
>  
> -	instance = nla_get_u32(tb[IFLA_BRIDGE_CFM_CC_RDI_INSTANCE]);
> +	instance = nla_get_u32(tb[IFLA_BRIDGE_CFM_CC_CCM_TX_INSTANCE]);
>  	nla_memcpy(&tx_info.dmac.addr,
>  		   tb[IFLA_BRIDGE_CFM_CC_CCM_TX_DMAC],
>  		   sizeof(tx_info.dmac.addr));

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


