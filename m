Return-Path: <linux-kernel+bounces-5538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B35818BD9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 17:08:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD15C2878C1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 16:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A01171D154;
	Tue, 19 Dec 2023 16:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="XP5UfiJi"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6781D12E;
	Tue, 19 Dec 2023 16:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 4C9E140E0030;
	Tue, 19 Dec 2023 16:08:14 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id drH7IP9qlJYB; Tue, 19 Dec 2023 16:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1703002092; bh=1z/4JUr8IsaIlo22yWuryzBjoAFXnRE1IzvaFpQDTUY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XP5UfiJiznTairzA59Gspo1oDSrU2kuXnP0VYclIW1Y07Fqhisp+hrh3xuPmWHAc2
	 n7dT3vrfXIaUXIMTUd8VoNIOFQLmazkZMAKJXmjF2FkHOBr2TrdY362vWSiFdAhNjo
	 QQcfkOEXmZ2b4O2sSvrf5kz6B7HBo1oTm1/3ATV5hdE+GxUUGLilvteiBB6A9q96pi
	 lsxtUzFGVhMTdYhHCkY8DUke2IyS9trygGhYTADwPDv1H1ghC0NfASq0lw+fcaoHhP
	 IlleVIFMNgtuIL1X+7c6cHbw0tDEcOmEclNi4cDdJf24weZwMN8+SSt6nBPHg6qRjd
	 GKod8eEotKEUIP2vQaW8F/9mjidK7qOl+oXO+7UL3M5v5ctOM4mjPoewYMBhfg7QZz
	 Sh6O9RA7MzCUUnijtpaGqN87K4nVAjMoOtd1e7evnHCK716+9hbbA1zyT22+JnOKEM
	 Sgs67pzuaOTFkRAVvazLbA1qYSk53mRPmpxkOnm9BuV3Dz9MLabJnNp28m5opKiblt
	 n5a7KziNBSUD+9TSEYJRWJajPcBJX1sN66j3RwTAM2EwJ3chTPqi4Rvh0sMFlAbiAY
	 iQbelZlYMM2s4o/EJKo7WBsdkvKkXQRZrgvRyb3hoOuIjERiFerNCdA2psPFEx61K+
	 eRlTXXPI3Hd10uiaDM+C1K4c=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1092D40E00C6;
	Tue, 19 Dec 2023 16:08:03 +0000 (UTC)
Date: Tue, 19 Dec 2023 17:07:56 +0100
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
	avadhut.naik@amd.com, tony.luck@intel.com, john.allen@amd.com,
	william.roche@oracle.com, muralidhara.mk@amd.com
Subject: Re: [PATCH v4 1/3] RAS: Introduce AMD Address Translation Library
Message-ID: <20231219160756.GSZYG/3LbgTPT30Zwc@fat_crate.local>
References: <20231218190406.27479-1-yazen.ghannam@amd.com>
 <20231218190406.27479-2-yazen.ghannam@amd.com>
 <42c6ed78-75bd-4b4b-8b59-e0562d4968aa@wanadoo.fr>
 <2f114c41-5dbb-4019-b0f1-046509521d44@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2f114c41-5dbb-4019-b0f1-046509521d44@amd.com>

On Mon, Dec 18, 2023 at 04:53:24PM -0500, Yazen Ghannam wrote:
> Yep, good points. Thanks for your feedback!

Diff ontop in case you have to resend. Folding it locally.

Thanks Christophe.

---
diff --git a/drivers/ras/amd/atl/map.c b/drivers/ras/amd/atl/map.c
index 8145b7bb2b40..d160662f534f 100644
--- a/drivers/ras/amd/atl/map.c
+++ b/drivers/ras/amd/atl/map.c
@@ -650,7 +650,7 @@ static void dump_address_map(struct dram_addr_map *map)
 
 int get_address_map(struct addr_ctx *ctx)
 {
-	int ret = 0;
+	int ret;
 
 	ret = get_address_map_common(ctx);
 	if (ret)
diff --git a/drivers/ras/amd/atl/system.c b/drivers/ras/amd/atl/system.c
index 37ad203bb93e..3b6b5a5ddaab 100644
--- a/drivers/ras/amd/atl/system.c
+++ b/drivers/ras/amd/atl/system.c
@@ -225,8 +225,6 @@ static void get_num_maps(void)
 		df_cfg.num_coh_st_maps	= 2;
 		break;
 	case DF4:
-		df_cfg.num_coh_st_maps	= 4;
-		break;
 	case DF4p5:
 		df_cfg.num_coh_st_maps	= 4;
 		break;

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

