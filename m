Return-Path: <linux-kernel+bounces-116427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A70D3889C76
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:20:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DA882E40D7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBD3215B569;
	Mon, 25 Mar 2024 06:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Qfe96/kj"
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3FEE374727;
	Mon, 25 Mar 2024 03:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711335674; cv=none; b=bIRXb4pHOghrs2xkxkVzf9gPRvCxocb3rSOiHNgaHTf+XTDLI28pdCC+PIgbynVt7te4+f0ALRhecj1cmBXSpwYXMZxZV3m46iZPWREZB2G32ZluIQMloRwhsIldgzHJgWIvZgFaF1a3rYh8G6zLR1vrDFBcuEv4nIBaXNvXXOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711335674; c=relaxed/simple;
	bh=8Qfd+A8m4V1tqSb5szRlD3RAirI9yb2FDNe+L0MmL9I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sf18XiszyddsMCuIqCK7KQ7mpQF6aLqYHc7/TlWqCVRw1c3t/Hq2EmoxTfIFAIXQ03yeUDKznc0Mwfjt+e+mYQXYUyNH0BflqFwVX5QeGkRgUFbJDuiQOnhjwZVlnySGIgQgZT7fT6230Z4nx0lRgBsKVA3UxT6ob2pJpuX2S4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Qfe96/kj; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1711335666; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=XmVeqKOAT32nVC7FjBmUhKXxG89ac3vc9NUHAgKmK0w=;
	b=Qfe96/kjt9t6n7Fo4UD1SDcy5/CK8nyvyMHaAGKdygV5sC8P3vsC21zf9hWx7JjduTi/lJviBP7G5qa9CBobiG7p+FFiBv1S5qQBYR46dIlwKzZFzNJCv8PkwY88qbP6QZrOILYDnzSoUZIzDOmZrSNY8hcW0YN/RMHxtfv0Yc8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R861e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0W38Wexa_1711335664;
Received: from 30.221.130.215(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0W38Wexa_1711335664)
          by smtp.aliyun-inc.com;
          Mon, 25 Mar 2024 11:01:06 +0800
Message-ID: <f504328f-1fd2-4c85-a657-a14b272c321e@linux.alibaba.com>
Date: Mon, 25 Mar 2024 11:01:04 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2][next] net/smc: Avoid -Wflex-array-member-not-at-end
 warnings
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Wenjia Zhang <wenjia@linux.ibm.com>, Jan Karcher <jaka@linux.ibm.com>,
 "D. Wythe" <alibuda@linux.alibaba.com>, Tony Lu <tonylu@linux.alibaba.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-s390@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
 Kees Cook <keescook@chromium.org>
References: <ZfCXBykRw5XqBvf0@neat>
From: Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <ZfCXBykRw5XqBvf0@neat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/3/13 01:55, Gustavo A. R. Silva wrote:
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

Hi Gustavo,

Thank you for the v2. Some places may need improvement, see below.

> ---
> Changes in v2:
>   - Name the tagged struct *_fixed instead of *_hdr.
>   - Add Kees' RB tag.
> 
>   net/smc/smc_clc.c |  5 +++--
>   net/smc/smc_clc.h | 24 ++++++++++++++----------
>   2 files changed, 17 insertions(+), 12 deletions(-)
> 
> diff --git a/net/smc/smc_clc.c b/net/smc/smc_clc.c
> index e55026c7529c..63bb5745ab54 100644
> --- a/net/smc/smc_clc.c
> +++ b/net/smc/smc_clc.c
> @@ -853,8 +853,9 @@ int smc_clc_send_proposal(struct smc_sock *smc, struct smc_init_info *ini)
>   	pclc_smcd = &pclc->pclc_smcd;
>   	pclc_prfx = &pclc->pclc_prfx;
>   	ipv6_prfx = pclc->pclc_prfx_ipv6;
> -	v2_ext = &pclc->pclc_v2_ext;
> -	smcd_v2_ext = &pclc->pclc_smcd_v2_ext;
> +	v2_ext = container_of(&pclc->pclc_v2_ext, struct smc_clc_v2_extension, fixed);
checkpatch complained 'WARNING: line length of 86 exceeds 80 columns' here.

It can be reproduced by:

/scripts/checkpatch.pl --strict --max-line-length=80 
--ignore=COMMIT_LOG_LONG_LINE,MACRO_ARG_REUSE,ALLOC_SIZEOF_STRUCT,NO_AUTHOR_SIGN_OFF,GIT_COMMIT_ID,CAMELCASE xxx.patch

> +	smcd_v2_ext = container_of(&pclc->pclc_smcd_v2_ext,
> +				   struct smc_clc_smcd_v2_extension, fixed);
>   	gidchids = pclc->pclc_gidchids;
>   	trl = &pclc->pclc_trl;
>   
> diff --git a/net/smc/smc_clc.h b/net/smc/smc_clc.h
> index 7cc7070b9772..2bfb51daf468 100644
> --- a/net/smc/smc_clc.h
> +++ b/net/smc/smc_clc.h
> @@ -134,12 +134,14 @@ struct smc_clc_smcd_gid_chid {
>   			 */
>   
>   struct smc_clc_v2_extension {
> -	struct smc_clnt_opts_area_hdr hdr;
> -	u8 roce[16];		/* RoCEv2 GID */
> -	u8 max_conns;
> -	u8 max_links;
> -	__be16 feature_mask;
> -	u8 reserved[12];
> +	struct_group_tagged(smc_clc_v2_extension_fixed, fixed,
> +		struct smc_clnt_opts_area_hdr hdr;

checkpatch: 'CHECK: Alignment should match open parenthesis'

> +		u8 roce[16];		/* RoCEv2 GID */
> +		u8 max_conns;
> +		u8 max_links;
> +		__be16 feature_mask;
> +		u8 reserved[12];
> +	);
>   	u8 user_eids[][SMC_MAX_EID_LEN];
>   };
>   
> @@ -159,8 +161,10 @@ struct smc_clc_msg_smcd {	/* SMC-D GID information */
>   };
>   
>   struct smc_clc_smcd_v2_extension {
> -	u8 system_eid[SMC_MAX_EID_LEN];
> -	u8 reserved[16];
> +	struct_group_tagged(smc_clc_smcd_v2_extension_fixed, fixed,
> +		u8 system_eid[SMC_MAX_EID_LEN];

checkpatch: 'CHECK: Alignment should match open parenthesis'

Thanks!
Wen Gu

> +		u8 reserved[16];
> +	);
>   	struct smc_clc_smcd_gid_chid gidchid[];
>   };
>   
> @@ -183,9 +187,9 @@ struct smc_clc_msg_proposal_area {
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

