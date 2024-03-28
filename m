Return-Path: <linux-kernel+bounces-123689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A29890CB7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 22:53:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50C001C20F2B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 21:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A334113B287;
	Thu, 28 Mar 2024 21:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vxt7De9K"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA34681752;
	Thu, 28 Mar 2024 21:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711662772; cv=none; b=Qik0GSD8hd5UJEME8YQT47z3k3k2zsEoRhuKaGCDL1+0TK/tsRdhwe5LpSzATPyaC0/VfamvoKhduVbBpiJgmP0yAmFHGTt33ENhju4AM263p/2smAEEvIfT2mV6sBSa6r+cg+1pHHJ0EQzfwyHxUo7NUZxYUoAuSGRvRalav3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711662772; c=relaxed/simple;
	bh=w1K9Bufa+Z0DWgWQVs6wFMPxe2z5PQYgrvQtySXRNbg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=s2vxcRLL3XNfLsF9V0zS+hjz2OK40SNGHFEp4Tjt7yY0wE9vz8pHe0Ni1dAyPJjeixer3QCyzYiqnJm3RqQMV0/Nu8xlJw7cae7fTsLMAFvhvwZXQsSXTA9hhwInUKs7h03I0lkM9ImfxVTvJbZa8pa34ce1lX5EPiUTn+kaflg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vxt7De9K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F093C433F1;
	Thu, 28 Mar 2024 21:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711662772;
	bh=w1K9Bufa+Z0DWgWQVs6wFMPxe2z5PQYgrvQtySXRNbg=;
	h=Date:From:To:Cc:Subject:From;
	b=Vxt7De9KUA/wpnofxM25TWxdMwuHlkdatMeTbZvEJMj9CTj65Zvt4cksmtTzOo4NM
	 eL89Z1CkCdtKHKwM9tAMe5hI5zzGEl0vgPx3NU6EH2X33i/Gtc/qyR9yrLuNf6//6z
	 uHFRUh5TouYdvMeQYFSPsYep2KImwCYg945/lITW4vpvdBMV6E9VOHTtkMHNQph4wt
	 1qqmC6lpQnQuTvAlKnz0zOy/2BEvpk/Cft//io6nIL4m/rlqCAjHMqQYB03gr1Wkdv
	 kTB9th+SKeEafozFltA2A9OK2k7IOpgnKZiS7VJgMWP3QBK4d3ec+XfKMp6dnEUVU8
	 GaMW7hxePYVog==
Date: Thu, 28 Mar 2024 15:52:49 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Wenjia Zhang <wenjia@linux.ibm.com>, Jan Karcher <jaka@linux.ibm.com>,
	"D. Wythe" <alibuda@linux.alibaba.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-s390@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH v4][next] net/smc: Avoid -Wflex-array-member-not-at-end
 warnings
Message-ID: <ZgXmscAd6Y2iQQ6O@neat>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

-Wflex-array-member-not-at-end is coming in GCC-14, and we are getting
ready to enable it globally.

There are currently a couple of objects in `struct smc_clc_msg_proposal_area`
that contain a couple of flexible structures:

struct smc_clc_msg_proposal_area {
	...
	struct smc_clc_v2_extension             pclc_v2_ext;
	...
	struct smc_clc_smcd_v2_extension        pclc_smcd_v2_ext;
	...
};

So, in order to avoid ending up with a couple of flexible-array members
in the middle of a struct, we use the `struct_group_tagged()` helper to
separate the flexible array from the rest of the members in the flexible
structure:

struct smc_clc_smcd_v2_extension {
        struct_group_tagged(smc_clc_smcd_v2_extension_fixed, fixed,
                            u8 system_eid[SMC_MAX_EID_LEN];
                            u8 reserved[16];
        );
        struct smc_clc_smcd_gid_chid gidchid[];
};

With the change described above, we now declare objects of the type of
the tagged struct without embedding flexible arrays in the middle of
another struct:

struct smc_clc_msg_proposal_area {
        ...
        struct smc_clc_v2_extension_fixed	pclc_v2_ext;
        ...
        struct smc_clc_smcd_v2_extension_fixed	pclc_smcd_v2_ext;
        ...
};

We also use `container_of()` when we need to retrieve a pointer to the
flexible structures.

So, with these changes, fix the following warnings:

In file included from net/smc/af_smc.c:42:
net/smc/smc_clc.h:186:49: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
  186 |         struct smc_clc_v2_extension             pclc_v2_ext;
      |                                                 ^~~~~~~~~~~
net/smc/smc_clc.h:188:49: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
  188 |         struct smc_clc_smcd_v2_extension        pclc_smcd_v2_ext;
      |                                                 ^~~~~~~~~~~~~~~~

Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
Changes v4:
 - Fix code comments (due to copy/paste error, aghhh).

Changes in v3:
 - Adjust code to 80 columns. (Wen Gu)
 - Add a couple of code comments.
 - Link: https://lore.kernel.org/linux-hardening/ZgXlIADfiXSyRz8d@neat/

Changes in v2:
 - Name the tagged struct *_fixed instead of *_hdr.
 - Add Kees' RB tag.
 - Link: https://lore.kernel.org/linux-hardening/ZfCXBykRw5XqBvf0@neat/

v1:
 - Link: https://lore.kernel.org/linux-hardening/ZeIhOT44ON5rjPiP@neat/

 net/smc/smc_clc.c |  6 ++++--
 net/smc/smc_clc.h | 26 ++++++++++++++++----------
 2 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/net/smc/smc_clc.c b/net/smc/smc_clc.c
index e55026c7529c..33fa787c28eb 100644
--- a/net/smc/smc_clc.c
+++ b/net/smc/smc_clc.c
@@ -853,8 +853,10 @@ int smc_clc_send_proposal(struct smc_sock *smc, struct smc_init_info *ini)
 	pclc_smcd = &pclc->pclc_smcd;
 	pclc_prfx = &pclc->pclc_prfx;
 	ipv6_prfx = pclc->pclc_prfx_ipv6;
-	v2_ext = &pclc->pclc_v2_ext;
-	smcd_v2_ext = &pclc->pclc_smcd_v2_ext;
+	v2_ext = container_of(&pclc->pclc_v2_ext,
+			      struct smc_clc_v2_extension, fixed);
+	smcd_v2_ext = container_of(&pclc->pclc_smcd_v2_ext,
+				   struct smc_clc_smcd_v2_extension, fixed);
 	gidchids = pclc->pclc_gidchids;
 	trl = &pclc->pclc_trl;
 
diff --git a/net/smc/smc_clc.h b/net/smc/smc_clc.h
index 7cc7070b9772..467effb50cd6 100644
--- a/net/smc/smc_clc.h
+++ b/net/smc/smc_clc.h
@@ -134,12 +134,15 @@ struct smc_clc_smcd_gid_chid {
 			 */
 
 struct smc_clc_v2_extension {
-	struct smc_clnt_opts_area_hdr hdr;
-	u8 roce[16];		/* RoCEv2 GID */
-	u8 max_conns;
-	u8 max_links;
-	__be16 feature_mask;
-	u8 reserved[12];
+	/* New members must be added within the struct_group() macro below. */
+	struct_group_tagged(smc_clc_v2_extension_fixed, fixed,
+		struct smc_clnt_opts_area_hdr hdr;
+		u8 roce[16];		/* RoCEv2 GID */
+		u8 max_conns;
+		u8 max_links;
+		__be16 feature_mask;
+		u8 reserved[12];
+	);
 	u8 user_eids[][SMC_MAX_EID_LEN];
 };
 
@@ -159,8 +162,11 @@ struct smc_clc_msg_smcd {	/* SMC-D GID information */
 };
 
 struct smc_clc_smcd_v2_extension {
-	u8 system_eid[SMC_MAX_EID_LEN];
-	u8 reserved[16];
+	/* New members must be added within the struct_group() macro below. */
+	struct_group_tagged(smc_clc_smcd_v2_extension_fixed, fixed,
+		u8 system_eid[SMC_MAX_EID_LEN];
+		u8 reserved[16];
+	);
 	struct smc_clc_smcd_gid_chid gidchid[];
 };
 
@@ -183,9 +189,9 @@ struct smc_clc_msg_proposal_area {
 	struct smc_clc_msg_smcd			pclc_smcd;
 	struct smc_clc_msg_proposal_prefix	pclc_prfx;
 	struct smc_clc_ipv6_prefix	pclc_prfx_ipv6[SMC_CLC_MAX_V6_PREFIX];
-	struct smc_clc_v2_extension		pclc_v2_ext;
+	struct smc_clc_v2_extension_fixed	pclc_v2_ext;
 	u8			user_eids[SMC_CLC_MAX_UEID][SMC_MAX_EID_LEN];
-	struct smc_clc_smcd_v2_extension	pclc_smcd_v2_ext;
+	struct smc_clc_smcd_v2_extension_fixed	pclc_smcd_v2_ext;
 	struct smc_clc_smcd_gid_chid
 				pclc_gidchids[SMCD_CLC_MAX_V2_GID_ENTRIES];
 	struct smc_clc_msg_trail		pclc_trl;
-- 
2.34.1


