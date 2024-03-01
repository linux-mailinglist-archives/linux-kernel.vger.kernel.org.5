Return-Path: <linux-kernel+bounces-88641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC7C86E4B5
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 16:51:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4E0E1F238B9
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 15:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 587B87003E;
	Fri,  1 Mar 2024 15:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="bWH1B6ZK"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A0438DC3;
	Fri,  1 Mar 2024 15:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709308268; cv=none; b=JR/wMcVGvfbUxsnls75da7m5k2CV0UCmff+G6/dBWNtcvf6E47g2hcXucefYA997N5OEWYLQHlYwCvvjdzs02wtCWcqOPdzw0Czk6hFbDYGIXtv4iM13ev6Ra+uM31kpiqYsEegcFgGj5u8z9ovGHWYhKMqpr8riA9ekSg6bD9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709308268; c=relaxed/simple;
	bh=1NVr50xCqj8bNUqZUVBbqR/mLlQgrKJ5lyxXHMeB10A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HdKSi1ThRYY5p+ZIUVe4FerADon93OF6cRQIOzi0f4xK7qg/hSofLVaD/idQedceIRlc9FPS4i2kcVXVLj5bra8/Gn43FJMJopMqCdoy2xgT84vWnV7aLonr1nB9oP7W34Acl9S4zIeyrMFE7pUOcoxFjgSJQ3JJiZNoSbxrhI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=bWH1B6ZK; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 936D040E0028;
	Fri,  1 Mar 2024 15:50:56 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id hELV_6bbTa8F; Fri,  1 Mar 2024 15:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1709308253; bh=R8/DDqIKJ5vY+bniXhs9aL9h96pvuubAf51BT+x/gzo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bWH1B6ZKCMd/XJa/ZmBEXEErCh9M4Tvae5Z1mnmHVnm43per3TZvMsuYxLEKDS00G
	 lxdRR6SHTysDFSp3/ExSjA9S/IOVnHrNkmSJ2DV/9ZVT3pjzR45zrbj74d37K1tln3
	 rl9Q/R8if282SEVeX05FY0cBvNjIGFDnD4JxGhiYJqoOn1oZxV3iVeCbq0drEpCeJH
	 O8s/w4mEuELAE+zcePWJjD8e1G4OSF1sCXeUHFxLaFkefzOSfJ69aRXK71nq9t+Hcu
	 tcwLfSOf78nc4Sv+FS7gK/1jhOmFt8xCIj7WefVQLHfRB0b5EJLy4A9a3CgrLFwe5L
	 5dC5T5S7gnNiiTMp4jQXrcl6FwDJs82ReY32XCp9W1hF5meRU7EA5gQVRdLWqbMAnY
	 +MibdSepE7LdF+OS6YL4dqXLweQ3oEvObjmfhJsDgcCIQ07c8iCHDkDqmKCKU9e4Bj
	 sEGTWa9QeKZTgtA8IiNjHTvgLAEvhguJBK3y2oMfANiPQLvbYDRdeS5m/gKOxl5W3h
	 rAW0jzT8ntoIwpYdTKrefa0b6bqMynE1YgsKTIpVGTAzncrwMJh7iQj3bK9z2TMKR6
	 FvAUrwQ1ijffEO8He/Ak6/+oyfIyJUOJhbfvpkLF2vpVCEIU+HzrF4PmG8TKrJdroF
	 0gVxiMfDBMqXe/CBfhv6AMHU=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 60A0440E00B2;
	Fri,  1 Mar 2024 15:50:44 +0000 (UTC)
Date: Fri, 1 Mar 2024 16:50:34 +0100
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: tony.luck@intel.com, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, avadhut.naik@amd.com,
	john.allen@amd.com, muralidhara.mk@amd.com, sathyapriya.k@amd.com,
	naveenkrishna.chatradhi@amd.com
Subject: Re: [PATCH v2 2/3] RAS/AMD/FMPM: Save SPA values
Message-ID: <20240301155034.GAZeH5StN80cO15qq_@fat_crate.local>
References: <20240301143748.854090-1-yazen.ghannam@amd.com>
 <20240301143748.854090-3-yazen.ghannam@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240301143748.854090-3-yazen.ghannam@amd.com>

On Fri, Mar 01, 2024 at 08:37:47AM -0600, Yazen Ghannam wrote:
> The system physical address (SPA) of an error is not a stable value. It
> will change depending on the location of the memory: parts can be
> swapped. And it will change depending on memory topology: NUMA nodes
> and/or interleaving can be adjusted.
> 
> Therefore, the SPA value is not part of the "FRU Memory Poison" record
> format. And it will not be saved to persistent storage.
> 
> However, the SPA values can be helpful during debug and for system
> admins during run time.
> 
> Save the SPA values in a separate structure. This is updated when
> records are restored and when new errors are saved.
> 
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> ---
> Link:
> https://lore.kernel.org/r/20240226152941.2615007-3-yazen.ghannam@amd.com
> 
> v1->v2:
> * Changed variable names to remove "sys_" prefix. (Boris)
> * Used "spa_" prefix to highlight that these are for SPA values. (Yazen)
> * Added warning to "index out-of-bound" condition. (Boris)
> * Reworked save_spa() flow to get a valid array position before saving
>   SPA value (Yazen).
> 
>  drivers/ras/amd/fmpm.c | 68 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 68 insertions(+)

Fixups ontop:

---

diff --git a/drivers/ras/amd/fmpm.c b/drivers/ras/amd/fmpm.c
index a7bb36eb60cb..8c3188488673 100644
--- a/drivers/ras/amd/fmpm.c
+++ b/drivers/ras/amd/fmpm.c
@@ -125,7 +125,7 @@ static u64 *spa_entries;
 		  0x12, 0x0a, 0x44, 0x58)
 
 /**
- * DOC: fru_poison_entries (byte)
+ * DOC: max_nr_entries (byte)
  * Maximum number of descriptor entries possible for each FRU.
  *
  * Values between '1' and '255' are valid.
@@ -285,10 +285,12 @@ static void save_spa(struct fru_rec *rec, unsigned int entry,
 	unsigned long spa;
 
 	if (entry >= max_nr_entries) {
-		pr_warn_once("entry out-of-bounds\n");
+		pr_warn_once("FRU descriptor entry %d out-of-bounds (max: %d)\n",
+			     entry, max_nr_entries);
 		return;
 	}
 
+	/* spa_nr_entries is always multiple of max_nr_entries */
 	for (i = 0; i < spa_nr_entries; i += max_nr_entries) {
 		fru_idx = i / max_nr_entries;
 		if (fru_records[fru_idx] == rec)
@@ -296,7 +298,7 @@ static void save_spa(struct fru_rec *rec, unsigned int entry,
 	}
 
 	if (i >= spa_nr_entries) {
-		pr_warn_once("record not found");
+		pr_warn_once("FRU record %d not found\n", i);
 		return;
 	}
 
-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

