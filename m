Return-Path: <linux-kernel+bounces-56812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE2784CF90
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 18:13:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99F0D1F230DD
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 17:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39AF3823C7;
	Wed,  7 Feb 2024 17:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eYg8PzWZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2mdwdsVy"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1BE5823AD;
	Wed,  7 Feb 2024 17:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707325995; cv=none; b=B34K8IBwkEspxyxKjbY2XkKX4fqxV63/fjAv3mrdFOeabPiwOcHD6v/8OruELqMyDFqadlAWJxcOysh3A6X57VCFAwxd41urVrJBQGTJllnZFZkYEPD0mt3q0u9ycjpL2C98Y9CaCIwfnST995oaaM39mXcy8fYIEf2t2VLDdGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707325995; c=relaxed/simple;
	bh=BVNIe1kDhE4wJLuDeON0evrTQTP1yhyS10nZ1KpN5+U=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=qknAIRA6gqtNwormYM6SBP0EROE4qd3CsoEnN7ht10LI/Xb2DmAu/p1OVevEloFCCXyg+r5FFb5CJP7N85T34YfUmpKURUKoO2MCogQtylH5PcyeD36xjIKfFvnzVUlDD7cXKT3uxUqA98MzNauYc7yMXGtk/9ULSY9g2CLGCSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eYg8PzWZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2mdwdsVy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 07 Feb 2024 17:13:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707325989;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CFsgkB1zC7/VSK3pWwrvuz6GTg2EbUcNZu4MIdsRY+w=;
	b=eYg8PzWZqrrn4BTqvsaFzE8XsmIYBDARuAt6mbu5OX46Mdcx6kpmZs+e0NkOYuoZ7pfkty
	iTaoorv6xO4sHHAs6ITGnr0wsdRwVdQYG7C9XbOKMtSXNufbTBDYmeGSDxKnYOAOs47BKp
	Cjo/eUZvz1Lv6XNIFBMyTtYS9T6whhmBBqmhYzqFHTehHsq3i3LHYJZ27+fozUfpnCnfmb
	1ee1QzQAF1FfczNyBYFD9LD5MxR0XgkG/35ST3suJ2l6RPwPEyA7/VZ2rwDuBDgRYLh5n8
	DAnELXfp4FKKJxHnFjJyGMlkCF2aoxUJU2BSQeFqA3AfLEcWOL2uf/uwd4upvg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707325989;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CFsgkB1zC7/VSK3pWwrvuz6GTg2EbUcNZu4MIdsRY+w=;
	b=2mdwdsVyhaKMS9pQX9iYb03tGvt5qYpQ6EQOhNKISWkV2uKSXgsO3YmMACyA2V0oUFmUYT
	j8TOgb0+o1mhZbBw==
From: "tip-bot2 for Ashish Kalra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/sev] iommu/amd: Fix failure return from snp_lookup_rmpentry()
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
 Ashish Kalra <ashish.kalra@amd.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Joerg Roedel <jroedel@suse.com>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240126041126.1927228-20-michael.roth@amd.com>
References: <20240126041126.1927228-20-michael.roth@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170732598872.398.2550238673926493243.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     45ba5b3c0a02949a4da74ead6e11c43e9b88bdca
Gitweb:        https://git.kernel.org/tip/45ba5b3c0a02949a4da74ead6e11c43e9b88bdca
Author:        Ashish Kalra <ashish.kalra@amd.com>
AuthorDate:    Mon, 05 Feb 2024 21:06:54 
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 07 Feb 2024 17:27:03 +01:00

iommu/amd: Fix failure return from snp_lookup_rmpentry()

Commit

  f366a8dac1b8: ("iommu/amd: Clean up RMP entries for IOMMU pages during SNP shutdown")

leads to the following Smatch static checker warning:

  drivers/iommu/amd/init.c:3820 iommu_page_make_shared() error: uninitialized symbol 'assigned'.

Fix it.

  [ bp: Address the other error cases too. ]

Fixes: f366a8dac1b8 ("iommu/amd: Clean up RMP entries for IOMMU pages during SNP shutdown")
Closes: https://lore.kernel.org/linux-iommu/1be69f6a-e7e1-45f9-9a74-b2550344f3fd@moroto.mountain
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Cc: Joerg Roedel <jroedel@suse.com>
Link: https://lore.kernel.org/lkml/20240126041126.1927228-20-michael.roth@amd.com
---
 drivers/iommu/amd/init.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 88bb08a..480e768 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -3813,23 +3813,28 @@ static int iommu_page_make_shared(void *page)
 		bool assigned;
 
 		ret = snp_lookup_rmpentry(pfn, &assigned, &level);
-		if (ret)
-			pr_warn("IOMMU PFN %lx RMP lookup failed, ret %d\n",
-				pfn, ret);
+		if (ret) {
+			pr_warn("IOMMU PFN %lx RMP lookup failed, ret %d\n", pfn, ret);
+			return ret;
+		}
 
-		if (!assigned)
-			pr_warn("IOMMU PFN %lx not assigned in RMP table\n",
-				pfn);
+		if (!assigned) {
+			pr_warn("IOMMU PFN %lx not assigned in RMP table\n", pfn);
+			return -EINVAL;
+		}
 
 		if (level > PG_LEVEL_4K) {
 			ret = psmash(pfn);
-			if (ret) {
-				pr_warn("IOMMU PFN %lx had a huge RMP entry, but attempted psmash failed, ret: %d, level: %d\n",
-					pfn, ret, level);
-			}
+			if (!ret)
+				goto done;
+
+			pr_warn("PSMASH failed for IOMMU PFN %lx huge RMP entry, ret: %d, level: %d\n",
+				pfn, ret, level);
+			return ret;
 		}
 	}
 
+done:
 	return rmp_make_shared(pfn, PG_LEVEL_4K);
 }
 

