Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA3E57C5E34
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 22:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376414AbjJKUSf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 16:18:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235143AbjJKUSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 16:18:24 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F4E8BA;
        Wed, 11 Oct 2023 13:18:22 -0700 (PDT)
Date:   Wed, 11 Oct 2023 20:18:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697055501;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WMRlhd5/BeztItAr2sM+0O+AsVRu38np495eIUqn08Q=;
        b=GKsMhtQqntFVsqb+M4cLqPg8KXQ+PRaliC/Ovy/5gIKJJBG3HFEVgpdHEruSkc21CEvs4q
        hNXN/oE2FLo1Bap62VlYeqc5CDXuB5Y040GH4h4TIYv909EjA9WEvsR83+9wTVSdKJLVim
        6OIRhfxYxnLNzKSRrkSuLFNLHdqpYrLSxMle55l39DouefSCAUZkTwD/oIzniMm/HJSkmm
        wNozLGbiWKqKnBWqKndXQEpxugA1x/YcXuSBXE5x3ve38QVSqec1oq5LXVm17q7JH8y2TG
        YYGbiYKUAwq3OLkLq4L7YDXsJYZ+13nbl247uFJKcAsRS2gCniK71NWNVDzrWw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697055501;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WMRlhd5/BeztItAr2sM+0O+AsVRu38np495eIUqn08Q=;
        b=oyTc6VyjScIWhHjUjDEvIbHmTJNr1oCLiYUmc0I/SINHn9ewa4m/37vLfzHfYYq6l8wkki
        6xuBTnoqe1jdhWAw==
From:   "tip-bot2 for Maciej Wieczor-Retman" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Rename arch_has_sparse_bitmaps
Cc:     Reinette Chatre <reinette.chatre@intel.com>,
        "Maciej Wieczor-Retman" <maciej.wieczor-retman@intel.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        ilpo.jarvinen@linux.intel.com,
        Peter Newman <peternewman@google.com>,
        Babu Moger <babu.moger@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Ce330fcdae873ef1a831e707025a4b70fa346666e=2E16969?=
 =?utf-8?q?34091=2Egit=2Emaciej=2Ewieczor-retman=40intel=2Ecom=3E?=
References: =?utf-8?q?=3Ce330fcdae873ef1a831e707025a4b70fa346666e=2E169693?=
 =?utf-8?q?4091=2Egit=2Emaciej=2Ewieczor-retman=40intel=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <169705550059.3135.10557448470126798843.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     39c6eed1f61594f737160e498d29673edbd9eefd
Gitweb:        https://git.kernel.org/tip/39c6eed1f61594f737160e498d29673edbd=
9eefd
Author:        Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
AuthorDate:    Tue, 10 Oct 2023 12:42:36 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 11 Oct 2023 19:43:43 +02:00

x86/resctrl: Rename arch_has_sparse_bitmaps

Rename arch_has_sparse_bitmaps to arch_has_sparse_bitmasks to ensure
consistent terminology throughout resctrl.

Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Peter Newman <peternewman@google.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Babu Moger <babu.moger@amd.com>
Tested-by: Peter Newman <peternewman@google.com>
Link: https://lore.kernel.org/r/e330fcdae873ef1a831e707025a4b70fa346666e.1696=
934091.git.maciej.wieczor-retman@intel.com
---
 arch/x86/kernel/cpu/resctrl/core.c        | 4 ++--
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 4 ++--
 include/linux/resctrl.h                   | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl=
/core.c
index 030d3b4..c09e4fd 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -872,7 +872,7 @@ static __init void rdt_init_res_defs_intel(void)
=20
 		if (r->rid =3D=3D RDT_RESOURCE_L3 ||
 		    r->rid =3D=3D RDT_RESOURCE_L2) {
-			r->cache.arch_has_sparse_bitmaps =3D false;
+			r->cache.arch_has_sparse_bitmasks =3D false;
 			r->cache.arch_has_per_cpu_cfg =3D false;
 			r->cache.min_cbm_bits =3D 1;
 		} else if (r->rid =3D=3D RDT_RESOURCE_MBA) {
@@ -892,7 +892,7 @@ static __init void rdt_init_res_defs_amd(void)
=20
 		if (r->rid =3D=3D RDT_RESOURCE_L3 ||
 		    r->rid =3D=3D RDT_RESOURCE_L2) {
-			r->cache.arch_has_sparse_bitmaps =3D true;
+			r->cache.arch_has_sparse_bitmasks =3D true;
 			r->cache.arch_has_per_cpu_cfg =3D true;
 			r->cache.min_cbm_bits =3D 0;
 		} else if (r->rid =3D=3D RDT_RESOURCE_MBA) {
diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/=
resctrl/ctrlmondata.c
index b44c487..ab45012 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -113,8 +113,8 @@ static bool cbm_validate(char *buf, u32 *data, struct rdt=
_resource *r)
 	first_bit =3D find_first_bit(&val, cbm_len);
 	zero_bit =3D find_next_zero_bit(&val, cbm_len, first_bit);
=20
-	/* Are non-contiguous bitmaps allowed? */
-	if (!r->cache.arch_has_sparse_bitmaps &&
+	/* Are non-contiguous bitmasks allowed? */
+	if (!r->cache.arch_has_sparse_bitmasks &&
 	    (find_next_bit(&val, cbm_len, zero_bit) < cbm_len)) {
 		rdt_last_cmd_printf("The mask %lx has non-consecutive 1-bits\n", val);
 		return false;
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 8334eea..66942d7 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -94,7 +94,7 @@ struct rdt_domain {
  *			zero CBM.
  * @shareable_bits:	Bitmask of shareable resource with other
  *			executing entities
- * @arch_has_sparse_bitmaps:	True if a bitmap like f00f is valid.
+ * @arch_has_sparse_bitmasks:	True if a bitmask like f00f is valid.
  * @arch_has_per_cpu_cfg:	True if QOS_CFG register for this cache
  *				level has CPU scope.
  */
@@ -102,7 +102,7 @@ struct resctrl_cache {
 	unsigned int	cbm_len;
 	unsigned int	min_cbm_bits;
 	unsigned int	shareable_bits;
-	bool		arch_has_sparse_bitmaps;
+	bool		arch_has_sparse_bitmasks;
 	bool		arch_has_per_cpu_cfg;
 };
=20
