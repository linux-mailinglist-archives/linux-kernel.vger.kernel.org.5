Return-Path: <linux-kernel+bounces-77075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68C8D8600E9
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:19:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D287E1F21B97
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5200915E5CB;
	Thu, 22 Feb 2024 18:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JFLqxQq3"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B800015DBC7;
	Thu, 22 Feb 2024 18:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708625687; cv=none; b=uFgmBLLJLbNsE62WrN0CTPtWXyNHf6aPIBDxVxlBiAbIc9sFZtCWHCS4eTPc+bDj+M39mCtYDl2RUtC7EKgEtVsV9fgoX/W1L85QcVOrHIHCCEy1q+MkYvWmR9Lj7M1KNPA8Syu22Wd6dfZ+J3404I+K20rYK1cZh65tRi9Dr0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708625687; c=relaxed/simple;
	bh=2VBnWtOUYOYZx3D0CXbbsv1cQZySxF7anmw1+oL7qNg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Caq5YU+ggAgWlDFjMx94GtiuwRGoUVINUqNqrigBYTV6VXCDv29bkL71ihb5H6PXbSF5Pl4J2WtgL7qsgJwcfH/5ZjzlLdTOWEa3lvKZy5cZH83Nukk8+6VRN8/5MbWBY67DJPoFat2IqWC/0btOKScaX1gpIdWum1hnstoDUKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JFLqxQq3; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d220ad10b3so807861fa.1;
        Thu, 22 Feb 2024 10:14:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708625684; x=1709230484; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+o0t5l+gbhBR5sr353Zx4OwnR+/NtUKsRVbiL7FnCuk=;
        b=JFLqxQq30iEscqR3gTzmDzKFdzYz8ayDFgzsDxEMxWTp946rEgYPjFDHvDr+YfU+cG
         ZnILvtQqOdV5HvfNITdNqdpPEA+oIfAXkEx6ulbDqdsqLwg/o8O2vHGcsn1C30JpnDhC
         paa264cO5YaHNVvySZnRC7jCHnkgNwNSUHzvIPugYrn12f/u6+jmcti8eqUWJ7+8oKIr
         HAijBBsoRtWKIcCpxYD4Rc34Lq+UP4OE/EpCvyZr4qkwK0nguhxwXr/uESAsjBSExmy1
         iYWDVyCrUa7rNZLcvjFElQBhbC6ctMH9XtL3jy4pX03nMx/7bmnQxR644VrUjte37MjQ
         oHEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708625684; x=1709230484;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+o0t5l+gbhBR5sr353Zx4OwnR+/NtUKsRVbiL7FnCuk=;
        b=hRaXoKYTuLrRLIqcqzyWCUhFSps1741Q46u2VxE/cHkKNMEHf3pOG6YFf0Vm8gxB9O
         n4zALjM1/kvwZ83gdufwL1hyJvskQeo0P8ySfYv//HAh0HjRSIyO/c0ybq9AQXokxXrM
         0Uz3nxgzSPLzy3cwXEm9pC4cd2UZ45XaH6icZ7fEPFlsDx/n67jDKwyTlcZzmWC7GmOV
         21hXiYWAOSa0++/IZsxBaL5QIPjOVjPF3ufnI8nDNRCagU6/MNotbzTPkr8XyVTioy4K
         4aIPZ2YvuK55hW5GYInR+FfM4JjOCVJbdDhfQbFdIz0c1AsRdcFmgiyiv2ONMDbFUGAp
         trPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKK+MYIyAPT34qeFicmmGJ59mA3+dtQprDYlTodqcm4HmyJvdg8YGrCXQec5DPGLYxtAj+ggygiPFDFPPITsh90cD2K44uqNE1Z+usRGpFeAPGJ22Osy27pNVHbkDCh1qidovXUq8Y9w==
X-Gm-Message-State: AOJu0Yz7WiaGgE9h+ed/sYyUa1XrxsXO+atjrFHPmj5YuWQxqOHKHdyK
	ifTfiuVhdPXW3p0qjn4/UDDihmdME6wilDgQtCi8PZzZNhEgW/jP
X-Google-Smtp-Source: AGHT+IHujCBUf3uP+SOmn6mxJZA8UNgrf2Op4NXH3LML5XVClyL6ZZ2opxWdtVcY7NGtBDIbf+PxtA==
X-Received: by 2002:a2e:8256:0:b0:2d2:5169:27f3 with SMTP id j22-20020a2e8256000000b002d2516927f3mr4079549ljh.34.1708625683925;
        Thu, 22 Feb 2024 10:14:43 -0800 (PST)
Received: from localhost ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id a16-20020a05651c211000b002d26782e8d9sm65176ljq.55.2024.02.22.10.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 10:14:43 -0800 (PST)
From: Serge Semin <fancer.lancer@gmail.com>
To: Michal Simek <michal.simek@amd.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Borislav Petkov <bp@alien8.de>,
	Tony Luck <tony.luck@intel.com>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>
Cc: Serge Semin <fancer.lancer@gmail.com>,
	Punnaiah Choudary Kalluri <punnaiah.choudary.kalluri@xilinx.com>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 13/20] EDAC/mc: Init DIMM labels in MC registration method
Date: Thu, 22 Feb 2024 21:12:58 +0300
Message-ID: <20240222181324.28242-14-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240222181324.28242-1-fancer.lancer@gmail.com>
References: <20240222181324.28242-1-fancer.lancer@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the DIMM labels initialization to the memory controller registration
method as a preparation before adding the generic procedure to allocate an
unique MC index. It's required because the DIMM labels contain the MC
index as the "mc%u" part of the string, which in case of the
auto-generated index isn't available at the moment of the MCI/csrow/dimms
descriptor allocation.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 drivers/edac/edac_mc.c | 48 +++++++++++++++++++++++++++---------------
 1 file changed, 31 insertions(+), 17 deletions(-)

diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
index d6eed727b0cd..c0b36349999f 100644
--- a/drivers/edac/edac_mc.c
+++ b/drivers/edac/edac_mc.c
@@ -257,7 +257,6 @@ static int edac_mc_alloc_dimms(struct mem_ctl_info *mci)
 	unsigned int pos[EDAC_MAX_LAYERS];
 	unsigned int row, chn, idx;
 	int layer;
-	void *p;
 
 	/*
 	 * Allocate and fill the dimm structs
@@ -272,7 +271,6 @@ static int edac_mc_alloc_dimms(struct mem_ctl_info *mci)
 	for (idx = 0; idx < mci->tot_dimms; idx++) {
 		struct dimm_info *dimm;
 		struct rank_info *chan;
-		int n, len;
 
 		chan = mci->csrows[row]->channels[chn];
 
@@ -283,22 +281,9 @@ static int edac_mc_alloc_dimms(struct mem_ctl_info *mci)
 		dimm->mci = mci;
 		dimm->idx = idx;
 
-		/*
-		 * Copy DIMM location and initialize it.
-		 */
-		len = sizeof(dimm->label);
-		p = dimm->label;
-		n = scnprintf(p, len, "mc#%u", mci->mc_idx);
-		p += n;
-		len -= n;
-		for (layer = 0; layer < mci->n_layers; layer++) {
-			n = scnprintf(p, len, "%s#%u",
-				      edac_layer_name[mci->layers[layer].type],
-				      pos[layer]);
-			p += n;
-			len -= n;
+		/* Copy DIMM location */
+		for (layer = 0; layer < mci->n_layers; layer++)
 			dimm->location[layer] = pos[layer];
-		}
 
 		/* Link it to the csrows old API data */
 		chan->dimm = dimm;
@@ -511,6 +496,33 @@ void edac_mc_reset_delay_period(unsigned long value)
 
 
 
+/**
+ * edac_mc_init_labels() - Initialize DIMM labels
+ *
+ * @mci: pointer to the mci structure which DIMM labels need to be initialized
+ *
+ * .. note::
+ *	locking model: must be called with the mem_ctls_mutex lock held
+ */
+static void edac_mc_init_labels(struct mem_ctl_info *mci)
+{
+	int n, len, layer;
+	unsigned int idx;
+	char *p;
+
+	for (idx = 0; idx < mci->tot_dimms; idx++) {
+		len = sizeof(mci->dimms[idx]->label);
+		p = mci->dimms[idx]->label;
+
+		n = scnprintf(p, len, "mc#%u", mci->mc_idx);
+		for (layer = 0; layer < mci->n_layers; layer++) {
+			n += scnprintf(p + n, len - n, "%s#%u",
+				      edac_layer_name[mci->layers[layer].type],
+				      mci->dimms[idx]->location[layer]);
+		}
+	}
+}
+
 /* Return 0 on success, 1 on failure.
  * Before calling this function, caller must
  * assign a unique value to mci->mc_idx.
@@ -638,6 +650,8 @@ int edac_mc_add_mc_with_groups(struct mem_ctl_info *mci,
 		goto fail0;
 	}
 
+	edac_mc_init_labels(mci);
+
 	if (add_mc_to_global_list(mci))
 		goto fail0;
 
-- 
2.43.0


