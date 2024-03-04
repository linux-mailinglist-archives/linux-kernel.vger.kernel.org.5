Return-Path: <linux-kernel+bounces-90264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3078086FC9C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 10:01:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9FAE281270
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 09:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE2AC21A0C;
	Mon,  4 Mar 2024 09:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="OUuCtk7v"
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D911B1947D;
	Mon,  4 Mar 2024 09:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709542851; cv=none; b=isjfbUTU8c48NpCiFgoj3tKbqDkZ2JSMPl4n5ivZUCS37YgdwahYr/fPFev6mJeID/IRiLPSmEIdrwC1hEYJdAMpiGUDRacP0dYLlIkqWGc6CnvY7CbxlD9exdoZKD5Vlkbn2hiEVh2oZcRmA6J42/xYDr/VZYldmoxfb4tUafE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709542851; c=relaxed/simple;
	bh=kC/i6dh8xeQ/wHc0EIZeXuT9EMYEzuM7Q48zQ/NMRt8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZL4nnIIdnPx/Vt+uoksaNxC3Ya1NwOHzIw75bZT5rUPR4icsasTEaMbfJi9wl8s/dQevfC6AW4PrxJ3XvIrxJeJpLYqnamDa9coCF02XwCr+p5F1YcMWUheuUEBaaL5jAHhOGdx5ynG5Wxo3woYiz37hHeiBwsvNgfSR/dGJ8qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=OUuCtk7v; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709542838; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=9ahmIqK5qlatgPE40+G4aT0KoQpIaQEigate3V7w1Vc=;
	b=OUuCtk7vX/VZh0Df8GOtfvT4l2HYinkxHUd8copLJ063CIz5dyNmusQxjNaqNTmxrvoJkILnSFxs9QrIDskIGIEInmM809uxX+4FlK1Ug1rkiLKdaO/wZciByOSOI7+Ipfd//udgMwe5qCc2nmUgrWP2LcvZFPuTfwKNVltfGJI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0W1mkySt_1709542837;
Received: from 30.221.132.253(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0W1mkySt_1709542837)
          by smtp.aliyun-inc.com;
          Mon, 04 Mar 2024 17:00:38 +0800
Message-ID: <71aa847b-2edc-44a2-beb7-3610bf744937@linux.alibaba.com>
Date: Mon, 4 Mar 2024 17:00:36 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] net/smc: Avoid -Wflex-array-member-not-at-end
 warnings
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Wenjia Zhang <wenjia@linux.ibm.com>, Jan Karcher <jaka@linux.ibm.com>,
 "D. Wythe" <alibuda@linux.alibaba.com>, Tony Lu <tonylu@linux.alibaba.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-s390@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
 Kees Cook <keescook@chromium.org>
References: <ZeIhOT44ON5rjPiP@neat>
From: Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <ZeIhOT44ON5rjPiP@neat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/3/2 02:40, Gustavo A. R. Silva wrote:
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
>          struct_group_tagged(smc_clc_smcd_v2_extension_hdr, hdr,
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
>          struct smc_clc_v2_extension_hdr		pclc_v2_ext;
>          ...
>          struct smc_clc_smcd_v2_extension_hdr	pclc_smcd_v2_ext;
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
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>   net/smc/smc_clc.c |  5 +++--
>   net/smc/smc_clc.h | 24 ++++++++++++++----------
>   2 files changed, 17 insertions(+), 12 deletions(-)
> 
> diff --git a/net/smc/smc_clc.c b/net/smc/smc_clc.c
> index e55026c7529c..3094cfa1c458 100644
> --- a/net/smc/smc_clc.c
> +++ b/net/smc/smc_clc.c
> @@ -853,8 +853,9 @@ int smc_clc_send_proposal(struct smc_sock *smc, struct smc_init_info *ini)
>   	pclc_smcd = &pclc->pclc_smcd;
>   	pclc_prfx = &pclc->pclc_prfx;
>   	ipv6_prfx = pclc->pclc_prfx_ipv6;
> -	v2_ext = &pclc->pclc_v2_ext;
> -	smcd_v2_ext = &pclc->pclc_smcd_v2_ext;
> +	v2_ext = container_of(&pclc->pclc_v2_ext, struct smc_clc_v2_extension, _hdr);
> +	smcd_v2_ext = container_of(&pclc->pclc_smcd_v2_ext,
> +				   struct smc_clc_smcd_v2_extension, hdr);
>   	gidchids = pclc->pclc_gidchids;
>   	trl = &pclc->pclc_trl;
>   
> diff --git a/net/smc/smc_clc.h b/net/smc/smc_clc.h
> index 7cc7070b9772..5b91a1947078 100644
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
> +	struct_group_tagged(smc_clc_v2_extension_hdr, _hdr,
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
> @@ -159,8 +161,10 @@ struct smc_clc_msg_smcd {	/* SMC-D GID information */
>   };
>   
>   struct smc_clc_smcd_v2_extension {
> -	u8 system_eid[SMC_MAX_EID_LEN];
> -	u8 reserved[16];
> +	struct_group_tagged(smc_clc_smcd_v2_extension_hdr, hdr,
> +		u8 system_eid[SMC_MAX_EID_LEN];
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
> +	struct smc_clc_v2_extension_hdr		pclc_v2_ext;
>   	u8			user_eids[SMC_CLC_MAX_UEID][SMC_MAX_EID_LEN];
> -	struct smc_clc_smcd_v2_extension	pclc_smcd_v2_ext;
> +	struct smc_clc_smcd_v2_extension_hdr	pclc_smcd_v2_ext;
>   	struct smc_clc_smcd_gid_chid
>   				pclc_gidchids[SMCD_CLC_MAX_V2_GID_ENTRIES];
>   	struct smc_clc_msg_trail		pclc_trl;

Thank you! Gustavo. This patch can fix this warning well, just the name
'*_hdr' might not be very accurate, but I don't have a good idea ATM.

Besides, I am wondering if this can be fixed by moving
user_eids of smc_clc_msg_proposal_area into smc_clc_v2_extension,
and
pclc_gidchids of smc_clc_msg_proposal_area into smc_clc_smcd_v2_extension.

so that we can avoid to use the flexible-array in smc_clc_v2_extension
and smc_clc_smcd_v2_extension.


diff --git a/net/smc/smc_clc.c b/net/smc/smc_clc.c
index e55026c7529c..971b4677b84d 100644
--- a/net/smc/smc_clc.c
+++ b/net/smc/smc_clc.c
@@ -855,7 +855,7 @@ int smc_clc_send_proposal(struct smc_sock *smc, struct smc_init_info *ini)
         ipv6_prfx = pclc->pclc_prfx_ipv6;
         v2_ext = &pclc->pclc_v2_ext;
         smcd_v2_ext = &pclc->pclc_smcd_v2_ext;
-       gidchids = pclc->pclc_gidchids;
+       gidchids = pclc->pclc_smcd_v2_ext.gidchid;
         trl = &pclc->pclc_trl;

         pclc_base->hdr.version = SMC_V2;
diff --git a/net/smc/smc_clc.h b/net/smc/smc_clc.h
index 7cc7070b9772..36c8432af73e 100644
--- a/net/smc/smc_clc.h
+++ b/net/smc/smc_clc.h
@@ -133,6 +133,14 @@ struct smc_clc_smcd_gid_chid {
                          * (https://www.ibm.com/support/pages/node/6326337)
                          */

+#define SMC_CLC_MAX_V6_PREFIX          8
+#define SMC_CLC_MAX_UEID               8
+#define SMCD_CLC_MAX_V2_GID_ENTRIES    8 /* max # of CHID-GID entries in CLC
+                                          * proposal SMC-Dv2 extension.
+                                          * each ISM device takes one entry and
+                                          * each Emulated-ISM takes two entries
+                                          */
+
  struct smc_clc_v2_extension {
         struct smc_clnt_opts_area_hdr hdr;
         u8 roce[16];            /* RoCEv2 GID */
@@ -140,7 +148,7 @@ struct smc_clc_v2_extension {
         u8 max_links;
         __be16 feature_mask;
         u8 reserved[12];
-       u8 user_eids[][SMC_MAX_EID_LEN];
+       u8 user_eids[SMC_CLC_MAX_UEID][SMC_MAX_EID_LEN];
  };

  struct smc_clc_msg_proposal_prefix {   /* prefix part of clc proposal message*/
@@ -161,7 +169,7 @@ struct smc_clc_msg_smcd {   /* SMC-D GID information */
  struct smc_clc_smcd_v2_extension {
         u8 system_eid[SMC_MAX_EID_LEN];
         u8 reserved[16];
-       struct smc_clc_smcd_gid_chid gidchid[];
+       struct smc_clc_smcd_gid_chid gidchid[SMCD_CLC_MAX_V2_GID_ENTRIES];
  };

  struct smc_clc_msg_proposal {  /* clc proposal message sent by Linux */
@@ -170,24 +178,13 @@ struct smc_clc_msg_proposal {     /* clc proposal message sent by Linux */
         __be16 iparea_offset;   /* offset to IP address information area */
  } __aligned(4);

-#define SMC_CLC_MAX_V6_PREFIX          8
-#define SMC_CLC_MAX_UEID               8
-#define SMCD_CLC_MAX_V2_GID_ENTRIES    8 /* max # of CHID-GID entries in CLC
-                                          * proposal SMC-Dv2 extension.
-                                          * each ISM device takes one entry and
-                                          * each Emulated-ISM takes two entries
-                                          */
-
  struct smc_clc_msg_proposal_area {
         struct smc_clc_msg_proposal             pclc_base;
         struct smc_clc_msg_smcd                 pclc_smcd;
         struct smc_clc_msg_proposal_prefix      pclc_prfx;
         struct smc_clc_ipv6_prefix      pclc_prfx_ipv6[SMC_CLC_MAX_V6_PREFIX];
         struct smc_clc_v2_extension             pclc_v2_ext;
-       u8                      user_eids[SMC_CLC_MAX_UEID][SMC_MAX_EID_LEN];
         struct smc_clc_smcd_v2_extension        pclc_smcd_v2_ext;
-       struct smc_clc_smcd_gid_chid
-                               pclc_gidchids[SMCD_CLC_MAX_V2_GID_ENTRIES];
         struct smc_clc_msg_trail                pclc_trl;
  };


Thanks!
Wen Gu

