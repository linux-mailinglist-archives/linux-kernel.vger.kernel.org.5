Return-Path: <linux-kernel+bounces-126426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E55F8937CA
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 05:34:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E1EA1F214E5
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 03:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98509749F;
	Mon,  1 Apr 2024 03:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="tpa4oVSa"
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8470522E;
	Mon,  1 Apr 2024 03:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711942483; cv=none; b=aJLvaLHSAObTSj86iOQoVdxErZA+BC0+3fiBllTgQQC7UxQLvG3jkWmvXYhqgILvZjDxYAHBEzu8t9RxC3ynLbfXVKFVpCZDbLgG8OFVQmJmduhvCF/8h56AUHMR/Smgq9ygP66HL+Fl8h+zjaKi9MdrDJNKRrBM86HEFJxHLs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711942483; c=relaxed/simple;
	bh=TrJcj01Er00eAvFKR0jzYuUqobdc2zMMASuC79JwpO0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TaSBJlFInsLcxtPVY3mbmKjqlz0xmKoklnBEfqHieo06goLveeHSZoErymNPUDTmpxh8SW0BSuPGkuW++wvjmmKl/ZrbqwUgYorGLT/WxYSHRCzpEVkaS5QBNBYE7hqEhAnqOJ1xZx1H829dTHvgcOEDLiXszMwrzcTP6/P+Xro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=tpa4oVSa; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1711942477; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=u6JtRxYTExUsoUZBmyKeockMJYiorsrS2DZFcMH0Xu4=;
	b=tpa4oVSavKsoHQk2vDb6yBGWJ1VNgesGA+7BZzau0Tr8qCAvUFM/VjSBl/dbbXeRjX1CY3Sipv3HrM5Ym/EZ1ZrV3XldwJiA9IytTdSpXeF8qhaQWEwEJzAIhka4BW5GGbwcdI68GwbRMDqXxWyrCQXk2ajb41VyQoBT3oF/F9o=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0W3e3cIV_1711942465;
Received: from 30.221.128.183(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0W3e3cIV_1711942465)
          by smtp.aliyun-inc.com;
          Mon, 01 Apr 2024 11:34:37 +0800
Message-ID: <45c3042b-4446-40f2-af70-52b8c0f4b108@linux.alibaba.com>
Date: Mon, 1 Apr 2024 11:34:25 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4][next] net/smc: Avoid -Wflex-array-member-not-at-end
 warnings
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Wenjia Zhang <wenjia@linux.ibm.com>, Jan Karcher <jaka@linux.ibm.com>,
 "D. Wythe" <alibuda@linux.alibaba.com>, Tony Lu <tonylu@linux.alibaba.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-s390@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <ZgXmscAd6Y2iQQ6O@neat>
From: Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <ZgXmscAd6Y2iQQ6O@neat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/3/29 05:52, Gustavo A. R. Silva wrote:
> -Wflex-array-member-not-at-end is coming in GCC-14, and we are getting
> ready to enable it globally.
> 
> There are currently a couple of objects in `struct smc_clc_msg_proposal_area`
> that contain a couple of flexible structures:
> 
> struct smc_clc_msg_proposal_area {
> 	...
> 	struct smc_clc_v2_extension             pclc_v2_ext;
> 	...
> 	struct smc_clc_smcd_v2_extension        pclc_smcd_v2_ext;
> 	...
> };
> 
> So, in order to avoid ending up with a couple of flexible-array members
> in the middle of a struct, we use the `struct_group_tagged()` helper to
> separate the flexible array from the rest of the members in the flexible
> structure:
> 
> struct smc_clc_smcd_v2_extension {
>          struct_group_tagged(smc_clc_smcd_v2_extension_fixed, fixed,
>                              u8 system_eid[SMC_MAX_EID_LEN];
>                              u8 reserved[16];
>          );
>          struct smc_clc_smcd_gid_chid gidchid[];
> };
> 
> With the change described above, we now declare objects of the type of
> the tagged struct without embedding flexible arrays in the middle of
> another struct:
> 
> struct smc_clc_msg_proposal_area {
>          ...
>          struct smc_clc_v2_extension_fixed	pclc_v2_ext;
>          ...
>          struct smc_clc_smcd_v2_extension_fixed	pclc_smcd_v2_ext;
>          ...
> };
> 
> We also use `container_of()` when we need to retrieve a pointer to the
> flexible structures.
> 
> So, with these changes, fix the following warnings:
> 
> In file included from net/smc/af_smc.c:42:
> net/smc/smc_clc.h:186:49: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
>    186 |         struct smc_clc_v2_extension             pclc_v2_ext;
>        |                                                 ^~~~~~~~~~~
> net/smc/smc_clc.h:188:49: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
>    188 |         struct smc_clc_smcd_v2_extension        pclc_smcd_v2_ext;
>        |                                                 ^~~~~~~~~~~~~~~~
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thank you, Gustavo.

Reviewed-by: Wen Gu <guwen@linux.alibaba.com>

> ---
> Changes v4:
>   - Fix code comments (due to copy/paste error, aghhh).
> 
> Changes in v3:
>   - Adjust code to 80 columns. (Wen Gu)
>   - Add a couple of code comments.
>   - Link: https://lore.kernel.org/linux-hardening/ZgXlIADfiXSyRz8d@neat/
> 
> Changes in v2:
>   - Name the tagged struct *_fixed instead of *_hdr.
>   - Add Kees' RB tag.
>   - Link: https://lore.kernel.org/linux-hardening/ZfCXBykRw5XqBvf0@neat/
> 
> v1:
>   - Link: https://lore.kernel.org/linux-hardening/ZeIhOT44ON5rjPiP@neat/
> 
>   net/smc/smc_clc.c |  6 ++++--
>   net/smc/smc_clc.h | 26 ++++++++++++++++----------
>   2 files changed, 20 insertions(+), 12 deletions(-)
> 
> diff --git a/net/smc/smc_clc.c b/net/smc/smc_clc.c
> index e55026c7529c..33fa787c28eb 100644
> --- a/net/smc/smc_clc.c
> +++ b/net/smc/smc_clc.c
> @@ -853,8 +853,10 @@ int smc_clc_send_proposal(struct smc_sock *smc, struct smc_init_info *ini)
>   	pclc_smcd = &pclc->pclc_smcd;
>   	pclc_prfx = &pclc->pclc_prfx;
>   	ipv6_prfx = pclc->pclc_prfx_ipv6;
> -	v2_ext = &pclc->pclc_v2_ext;
> -	smcd_v2_ext = &pclc->pclc_smcd_v2_ext;
> +	v2_ext = container_of(&pclc->pclc_v2_ext,
> +			      struct smc_clc_v2_extension, fixed);
> +	smcd_v2_ext = container_of(&pclc->pclc_smcd_v2_ext,
> +				   struct smc_clc_smcd_v2_extension, fixed);
>   	gidchids = pclc->pclc_gidchids;
>   	trl = &pclc->pclc_trl;
>   
> diff --git a/net/smc/smc_clc.h b/net/smc/smc_clc.h
> index 7cc7070b9772..467effb50cd6 100644
> --- a/net/smc/smc_clc.h
> +++ b/net/smc/smc_clc.h
> @@ -134,12 +134,15 @@ struct smc_clc_smcd_gid_chid {
>   			 */
>   
>   struct smc_clc_v2_extension {
> -	struct smc_clnt_opts_area_hdr hdr;
> -	u8 roce[16];		/* RoCEv2 GID */
> -	u8 max_conns;
> -	u8 max_links;
> -	__be16 feature_mask;
> -	u8 reserved[12];
> +	/* New members must be added within the struct_group() macro below. */
> +	struct_group_tagged(smc_clc_v2_extension_fixed, fixed,
> +		struct smc_clnt_opts_area_hdr hdr;
> +		u8 roce[16];		/* RoCEv2 GID */
> +		u8 max_conns;
> +		u8 max_links;
> +		__be16 feature_mask;
> +		u8 reserved[12];
> +	);
>   	u8 user_eids[][SMC_MAX_EID_LEN];
>   };
>   
> @@ -159,8 +162,11 @@ struct smc_clc_msg_smcd {	/* SMC-D GID information */
>   };
>   
>   struct smc_clc_smcd_v2_extension {
> -	u8 system_eid[SMC_MAX_EID_LEN];
> -	u8 reserved[16];
> +	/* New members must be added within the struct_group() macro below. */
> +	struct_group_tagged(smc_clc_smcd_v2_extension_fixed, fixed,
> +		u8 system_eid[SMC_MAX_EID_LEN];
> +		u8 reserved[16];
> +	);
>   	struct smc_clc_smcd_gid_chid gidchid[];
>   };
>   
> @@ -183,9 +189,9 @@ struct smc_clc_msg_proposal_area {
>   	struct smc_clc_msg_smcd			pclc_smcd;
>   	struct smc_clc_msg_proposal_prefix	pclc_prfx;
>   	struct smc_clc_ipv6_prefix	pclc_prfx_ipv6[SMC_CLC_MAX_V6_PREFIX];
> -	struct smc_clc_v2_extension		pclc_v2_ext;
> +	struct smc_clc_v2_extension_fixed	pclc_v2_ext;
>   	u8			user_eids[SMC_CLC_MAX_UEID][SMC_MAX_EID_LEN];
> -	struct smc_clc_smcd_v2_extension	pclc_smcd_v2_ext;
> +	struct smc_clc_smcd_v2_extension_fixed	pclc_smcd_v2_ext;
>   	struct smc_clc_smcd_gid_chid
>   				pclc_gidchids[SMCD_CLC_MAX_V2_GID_ENTRIES];
>   	struct smc_clc_msg_trail		pclc_trl;

