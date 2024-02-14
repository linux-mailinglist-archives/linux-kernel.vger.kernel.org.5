Return-Path: <linux-kernel+bounces-65775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 229938551AE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 19:11:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47CA11C21B2C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EBE2128368;
	Wed, 14 Feb 2024 18:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="h6yOHeqR"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0458127B43;
	Wed, 14 Feb 2024 18:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707933920; cv=none; b=Ot1zvxuvOKDTD09QAyyGpuKst5E6ZqceJx/uNAuqwfYTFdLvvYiyEk2m3GRgarW0rY7eSk6pzmvK7gj8VZ9Z7WtAZFsVIP8G8C+3h294Z/iVBystLqhNYAR7fYvqGyHD6gs8i1d3b82sinFIW8K5Bs3q5rylXry6pcVf0GftaGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707933920; c=relaxed/simple;
	bh=Xd4BEhdZCHi6lxYbCBeevCVswnWw5V1/9wwhFgLobf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qqlbFk4Ret9zjM8BKHN0SIiKFoUUTjpIL8yN8IuETH14XOuQznTeAq+memijM52/nqt+8AmBUkr1pzDFqIFO9Eq5qcIXIr5lYhIXLYkgyP9Cu5ozlIdgUBhI8mnx/EBitW9UEJNayUgbHV50bzbEGZy9zgnLVQRAFeWefTjfIPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=h6yOHeqR; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id CE52040E023B;
	Wed, 14 Feb 2024 18:05:15 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Tff3Nbi6-IIF; Wed, 14 Feb 2024 18:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1707933913; bh=lmJxXy7nb8sBnacq9D2cKP7cWPkayFurWJxqWo9+RgY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h6yOHeqRnaAEHK3JtmRuYoo9YfodlTuyuB570X3JbX01A+w9GSdSqtnbRvS+TFGF0
	 zbffrLevx0GR78XMRV3MMPUsD0ah0bOBTopu8uhZ62GrpghLl4PEfKoDe1OJKK9lm/
	 xu7Xn5BOMgET0cmof14X8VSJBwAKjUJWDQ9oS/HbR+H7oJqpy972TclPcBCM3fI8p4
	 OgdpngcKk5nkXEfFyUG4sTNrw8vhxV5J9g6MaQY/rbjTrsHL1DB4+ESkWSyLS5F6i/
	 Q15rP6t9IJyqEgsu1NoaXIZnJq9P9YUuVlItq1adzCzTKuxZ4yzM/sY8ZZDV7C+qKJ
	 A2dmiJbvN1gCttvjCiwy4Oa2RAVDk14vkNGf52pd4fYCBPVuecnSnOItI389dKVGYl
	 WXSFCNcC44AAvvckfa5lgyehKl/jBYy0Ft7xxr2Sm2ba/mXLJbfiE3sNyLeATEJhZr
	 y9NsPzPSRfYqHr0hqplYSJ6tR/8+LbqRQeMMXezWv+FGdcL5t4sXH/ebOyI2DTNq/d
	 ikwSCCqRA3+V1vieSD+LoKsaxYE4OWaPQc2i9ux5tHikGhqCWp47QUm0kbTNBE480b
	 sSY1rBPlatSPOWLFr+Au3fuGdlQqjkLxykQslXYvZZh48/net5HsQ7Kjmbj0QyYnSh
	 M5HA4pQ+ngSa4mVNI+ULUDMQ=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 79BAE40E01A9;
	Wed, 14 Feb 2024 18:05:04 +0000 (UTC)
Date: Wed, 14 Feb 2024 19:04:59 +0100
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: tony.luck@intel.com, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, avadhut.naik@amd.com,
	john.allen@amd.com, muralidhara.mk@amd.com,
	naveenkrishna.chatradhi@amd.com, sathyapriya.k@amd.com
Subject: Re: [PATCH 2/2] RAS: Introduce the FRU Memory Poison Manager
Message-ID: <20240214180459.GLZc0AywYypIVV1IQ7@fat_crate.local>
References: <20240214033516.1344948-1-yazen.ghannam@amd.com>
 <20240214033516.1344948-3-yazen.ghannam@amd.com>
 <20240214102926.GCZcyWBuEBe7WRXWYO@fat_crate.local>
 <2a83026c-ea36-44ca-a101-74a8b3a2ea89@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2a83026c-ea36-44ca-a101-74a8b3a2ea89@amd.com>

On Wed, Feb 14, 2024 at 09:45:14AM -0500, Yazen Ghannam wrote:
> Yes, we keep a local copy of the records within the module. That way
> we just need to update the local copy and write it down to the
> platform. This saves time and avoids interrupting the platform to do
> an extra read.

I guess this:

diff --git a/drivers/ras/amd/fmpm.c b/drivers/ras/amd/fmpm.c
index 901a1f0018fc..99499a37e9d5 100644
--- a/drivers/ras/amd/fmpm.c
+++ b/drivers/ras/amd/fmpm.c
@@ -142,8 +142,9 @@ static unsigned int max_nr_fru;
 static size_t max_rec_len;
 
 /*
- * Protect the local cache and prevent concurrent writes to storage.
- * This is only needed after init once notifier block registration is done.
+ * Protect the local records cache in fru_records and prevent concurrent
+ * writes to storage. This is only needed after init once notifier block
+ * registration is done.
  */
 static DEFINE_MUTEX(fmpm_update_mutex);
 
I'm still don't like the module param...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

