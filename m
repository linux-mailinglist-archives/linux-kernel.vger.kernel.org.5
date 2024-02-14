Return-Path: <linux-kernel+bounces-65102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C9A8547CD
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 12:11:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD87E1F2146E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 11:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E72F3199D9;
	Wed, 14 Feb 2024 11:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="D6+DyW5y"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C77718EA2;
	Wed, 14 Feb 2024 11:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707909049; cv=none; b=UdgfTf/5a9wyLnEVGYzVuAQJV3cyKtRsljoHQcvbvAdEXW2Vs+vnZQsHfkhv5mctC/WMbZG4gG2OasA8jiW6cMuSLp780BYQSAEA8mgSW8O9wce4/wkuUl/7kwHfboOgrqhYIv+XfB+nqh0usXHmK6KtE8/E4vEbTASDZ2PquYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707909049; c=relaxed/simple;
	bh=TJq9COw6PDecnjnk1YApAb3gGy01Mt/c9IxmMSaHGGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WUr2ZxqbxXyZClmfltTkECJC4xeIkZcxMsDX8cMPpVdw4KYO2x79SbjGtNcUTX8eQ3qMUFhSTU/sx3coYCQ6aFyr/+fKecmfWVTEvas+KMowUV6DpLtJ+Im7WaiL2BX1BsI6aEvj1vqTUjBE0oZVeJQIYbGCmmvzJx9+4srSPAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=D6+DyW5y; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id DE6CD40E01A9;
	Wed, 14 Feb 2024 11:10:44 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Q-TUVYAXG5nX; Wed, 14 Feb 2024 11:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1707909042; bh=u8DgBZxZUU4PAy3YQROt3KGRvRieHIBBxlz3D9L7msU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D6+DyW5yeFF1Vckp55kkzEB2cOf+/5BNIsy+igBgyL2W4f8rtjHNGfqKfrlr5QUQY
	 FlfFp0R4FcXeBMQgjDlJqRCdW3xNZglwUXpnrbt/JnlsmqVXMnCXIzVvKC7IA+el6T
	 SmbL5+eE/CU9NCdVG9Tx52rG3Xhsrbn80ys3L19TYJmuOtDyu1sJYDPSBsMc1ghybr
	 GDbdofdYcIwy7PpCkWb1xb9LYcieIReu5rAbI5m84i4IKXE0XRh8tTPn8wJIQ3qFSB
	 IRq5gsPsThTrhQA+hpWNwg2ai+KROQcnRdJuJ4HpB5V/r2A97V6BS6YaY6qDJLmapN
	 DDPFL5i5zgWslYQVGNuPeoGQK2OfabdCxY8ZwPEySbHIU2akpVTMPLNOLodXXydsxY
	 vbdO7rP10CfhM2K8VTn9VlP1E6R+bycQZ6FWaooJB4DIgv4DZJvTLS+s/mFbGLQMbu
	 WAmVl/5FYzg1er8njJat8XaaS2DfIlzWoGZTp2O8ZObrk4diT4lS9O4LWpX6/+Cy0V
	 GO1Xqr8EnpXkSVgKBjJ9KvrsYT3Xi69xTiUZaoudVQ6HemLKSXpLdKTSuC2FUD/Zr6
	 TrNicAs5BQMNBFeCK2DrbM7WmD51s8vu5UZFIs1dg9+9W7yt7VpnABHq5xZ2/aGYND
	 OeGurmdexLQDCeBIRrKObYR4=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9750940E016C;
	Wed, 14 Feb 2024 11:10:33 +0000 (UTC)
Date: Wed, 14 Feb 2024 12:10:32 +0100
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: tony.luck@intel.com, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, avadhut.naik@amd.com,
	john.allen@amd.com, muralidhara.mk@amd.com,
	naveenkrishna.chatradhi@amd.com, sathyapriya.k@amd.com
Subject: Re: [PATCH 2/2] RAS: Introduce the FRU Memory Poison Manager
Message-ID: <20240214111032.GGZcyfqFqsW0j4Yy3a@fat_crate.local>
References: <20240214033516.1344948-1-yazen.ghannam@amd.com>
 <20240214033516.1344948-3-yazen.ghannam@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240214033516.1344948-3-yazen.ghannam@amd.com>

On Tue, Feb 13, 2024 at 09:35:16PM -0600, Yazen Ghannam wrote:
> +static void init_fpd(struct cper_fru_poison_desc *fpd,  struct mce *m)
> +{
> +	memset(fpd, 0, sizeof(struct cper_fru_poison_desc));
> +
> +	fpd->timestamp	= m->time;
> +	fpd->hw_id_type = FPD_HW_ID_TYPE_MCA_IPID;
> +	fpd->hw_id	= m->ipid;
> +	fpd->addr_type	= FPD_ADDR_TYPE_MCA_ADDR;
> +	fpd->addr	= m->addr;
> +}

Get rid of that one:

diff --git a/drivers/ras/amd/fmpm.c b/drivers/ras/amd/fmpm.c
index f8799beddcc4..090b60d269e7 100644
--- a/drivers/ras/amd/fmpm.c
+++ b/drivers/ras/amd/fmpm.c
@@ -221,17 +221,6 @@ static int update_record_on_storage(struct fru_rec *rec)
 	return ret;
 }
 
-static void init_fpd(struct cper_fru_poison_desc *fpd,  struct mce *m)
-{
-	memset(fpd, 0, sizeof(struct cper_fru_poison_desc));
-
-	fpd->timestamp	= m->time;
-	fpd->hw_id_type = FPD_HW_ID_TYPE_MCA_IPID;
-	fpd->hw_id	= m->ipid;
-	fpd->addr_type	= FPD_ADDR_TYPE_MCA_ADDR;
-	fpd->addr	= m->addr;
-}
-
 static bool has_valid_entries(struct fru_rec *rec)
 {
 	if (!(rec->fmp.validation_bits & FMP_VALID_LIST_ENTRIES))
@@ -288,7 +277,13 @@ static void update_fru_record(struct fru_rec *rec, struct mce *m)
 
 	mutex_lock(&fmpm_update_mutex);
 
-	init_fpd(&fpd, m);
+	memset(&fpd, 0, sizeof(struct cper_fru_poison_desc));
+
+	fpd.timestamp	= m->time;
+	fpd.hw_id_type = FPD_HW_ID_TYPE_MCA_IPID;
+	fpd.hw_id	= m->ipid;
+	fpd.addr_type	= FPD_ADDR_TYPE_MCA_ADDR;
+	fpd.addr	= m->addr;
 
 	/* This is the first entry, so just save it. */
 	if (!has_valid_entries(rec))

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

