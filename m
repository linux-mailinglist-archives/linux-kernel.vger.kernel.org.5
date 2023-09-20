Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B75DA7A8C67
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 21:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbjITTMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 15:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbjITTMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 15:12:20 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4CE518B;
        Wed, 20 Sep 2023 12:11:57 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-503056c8195so383855e87.1;
        Wed, 20 Sep 2023 12:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695237116; x=1695841916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v+zg14s+8ZGl4N+E2RwxXEDbGvXikDYsUs+6iexwq0A=;
        b=iMpwe/bGXZgSZUkhwQLh+QsCvlqioCJQEkzOK12DeX8qUVnQAQP0D1khwkclsOrqdQ
         iOPK1yuxBSH5rHfbw08zJFXS7+EgKTuY3sNbY6S0Lfl58asxXAeh+j952+4VBZv7Az1Z
         HwrciRcEm8p8j9Ksl732ua9xEhm9nl4TXtD5Hgy+QpbjPXjZdg30TgHz2b8jAIDGk4sd
         jrLTClyUDsVd8nJaJV+RwkDD/cktS7jdmg9sBC5U9/tUaDwtOrYhnmWd4KV1tzbzRs0/
         BaWlswllYHGw5ziY1W4Z/JDYp/8KzRNEDQZPPfj8WK5ONVbB4DocVmS2aTat3hxr/Jxl
         qLqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695237116; x=1695841916;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v+zg14s+8ZGl4N+E2RwxXEDbGvXikDYsUs+6iexwq0A=;
        b=Lrae2a1q3Ila5JelJGw2uDLoBH2BHX0OK81LN9Ox/8L+iyvgTQrRdo3CM6wtdLIj8X
         5OBLbDF6WkrmrUt+kuzp1VZss+B2oEUZ2CeO93xrx06RW2j5gMg/NJqKVwDmjJPsR+EC
         6R3VlXJY8goJWuXBYnD9F9eUXh9oObiT7cNClEYivxG4P+fm3ykzQw7QemTYFo2Tgp4B
         qGUcmDeQZCy5mywC45oj+4YwwbuRtK1QLgcuJzrJrRm5RGfCLKUzqx6m0ab0k6cbq7uI
         9FkH5DioF9WYPBf+O1DAg68WN06233eacu8OEKigMFPRnlV+OUXPfyF9f87zHGWk+okb
         toog==
X-Gm-Message-State: AOJu0YzjqUESjmokuc6bnBVtB4rjIcnYQz/QdB8blYT1xqnSbDhcoN6j
        FY4kV9ldAnn8uBdyWcRYu28=
X-Google-Smtp-Source: AGHT+IEKgVoHipql50H/RhjNA6phuGUygs8P02VerAp2mt48qJNC1iDtdTfRSAEsH+etmBYaawlTjg==
X-Received: by 2002:a19:a410:0:b0:503:3890:ca3a with SMTP id q16-20020a19a410000000b005033890ca3amr2685854lfc.66.1695237115765;
        Wed, 20 Sep 2023 12:11:55 -0700 (PDT)
Received: from localhost ([85.26.234.178])
        by smtp.gmail.com with ESMTPSA id p19-20020ac246d3000000b00504230986fbsm95145lfo.52.2023.09.20.12.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 12:11:55 -0700 (PDT)
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Michal Simek <michal.simek@amd.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Punnaiah Choudary Kalluri 
        <punnaiah.choudary.kalluri@xilinx.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 13/20] EDAC/mc: Init DIMM labels in MC registration method
Date:   Wed, 20 Sep 2023 22:10:37 +0300
Message-ID: <20230920191059.28395-14-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230920191059.28395-1-fancer.lancer@gmail.com>
References: <20230920191059.28395-1-fancer.lancer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
index 6faeb2ab3960..24814839d885 100644
--- a/drivers/edac/edac_mc.c
+++ b/drivers/edac/edac_mc.c
@@ -256,7 +256,6 @@ static int edac_mc_alloc_dimms(struct mem_ctl_info *mci)
 	unsigned int pos[EDAC_MAX_LAYERS];
 	unsigned int row, chn, idx;
 	int layer;
-	void *p;
 
 	/*
 	 * Allocate and fill the dimm structs
@@ -271,7 +270,6 @@ static int edac_mc_alloc_dimms(struct mem_ctl_info *mci)
 	for (idx = 0; idx < mci->tot_dimms; idx++) {
 		struct dimm_info *dimm;
 		struct rank_info *chan;
-		int n, len;
 
 		chan = mci->csrows[row]->channels[chn];
 
@@ -282,22 +280,9 @@ static int edac_mc_alloc_dimms(struct mem_ctl_info *mci)
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
@@ -510,6 +495,33 @@ void edac_mc_reset_delay_period(unsigned long value)
 
 
 
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
@@ -637,6 +649,8 @@ int edac_mc_add_mc_with_groups(struct mem_ctl_info *mci,
 		goto fail0;
 	}
 
+	edac_mc_init_labels(mci);
+
 	if (add_mc_to_global_list(mci))
 		goto fail0;
 
-- 
2.41.0

