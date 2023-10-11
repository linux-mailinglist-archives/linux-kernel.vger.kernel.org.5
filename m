Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 869867C5E32
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 22:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376348AbjJKUS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 16:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235108AbjJKUSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 16:18:24 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BCB8C9;
        Wed, 11 Oct 2023 13:18:22 -0700 (PDT)
Date:   Wed, 11 Oct 2023 20:18:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697055500;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SkG/bnm24Hf8/nUqk6XKFx8MlzHMME0IVARW/kVok2g=;
        b=Lf0mMr+HPwHyU0lLCwezhTOWxP0z7SqbfYenrArRECCyZtUs3MPxAReFbTFEmryvrRLt1a
        djwQs99VAIW862LEv00eHe6rWG7NRHfusttE0SDH6yib3sHeOQI1xPb6wHsh80UNOaPyJo
        OMMkPI1IsLmvmRrEcWhr9MN24G5HlMoWPrj26GA9YeJ8FCeODxpPTCbUi+Ulnzalkm8U+A
        ri8BecTncl2T91uO+AajJAtECSvmll/+E6L9VNPK44vzdgYXWjdUCADv1JikankNDuTJ3i
        QzAOibH+hZwGvuBMrIOSEv80lWsiqiKVbtULmNFcQWshwHnV9rStin/Gp0+klg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697055500;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SkG/bnm24Hf8/nUqk6XKFx8MlzHMME0IVARW/kVok2g=;
        b=k/OiAgHc/xyYYjuZYCMlxcNmAqJZjKxReBr4q32Upu8a1pRNawSGUmjk6f1EJLs9I3miv3
        WF49kmZP8oMmqhBA==
From:   "tip-bot2 for Fenghua Yu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Add sparse_masks file in info
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        "Maciej Wieczor-Retman" <maciej.wieczor-retman@intel.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        ilpo.jarvinen@linux.intel.com,
        Peter Newman <peternewman@google.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Babu Moger <babu.moger@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C7300535160beba41fd8aa073749ec1ee29b4621f=2E16969?=
 =?utf-8?q?34091=2Egit=2Emaciej=2Ewieczor-retman=40intel=2Ecom=3E?=
References: =?utf-8?q?=3C7300535160beba41fd8aa073749ec1ee29b4621f=2E169693?=
 =?utf-8?q?4091=2Egit=2Emaciej=2Ewieczor-retman=40intel=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <169705549952.3135.4936488804307486003.tip-bot2@tip-bot2>
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

Commit-ID:     4dba8f10b8fef9c5b0f9ed83dd1af91a1795ead1
Gitweb:        https://git.kernel.org/tip/4dba8f10b8fef9c5b0f9ed83dd1af91a179=
5ead1
Author:        Fenghua Yu <fenghua.yu@intel.com>
AuthorDate:    Tue, 10 Oct 2023 12:42:38 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 11 Oct 2023 21:51:24 +02:00

x86/resctrl: Add sparse_masks file in info

Add the interface in resctrl FS to show if sparse cache allocation
bit masks are supported on the platform. Reading the file returns
either a "1" if non-contiguous 1s are supported and "0" otherwise.
The file path is /sys/fs/resctrl/info/{resource}/sparse_masks, where
{resource} can be either "L2" or "L3".

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Peter Newman <peternewman@google.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Babu Moger <babu.moger@amd.com>
Tested-by: Peter Newman <peternewman@google.com>
Link: https://lore.kernel.org/r/7300535160beba41fd8aa073749ec1ee29b4621f.1696=
934091.git.maciej.wieczor-retman@intel.com
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/res=
ctrl/rdtgroup.c
index a52cdf9..09848ff 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1117,6 +1117,17 @@ static enum resctrl_conf_type resctrl_peer_type(enum r=
esctrl_conf_type my_type)
 	}
 }
=20
+static int rdt_has_sparse_bitmasks_show(struct kernfs_open_file *of,
+					struct seq_file *seq, void *v)
+{
+	struct resctrl_schema *s =3D of->kn->parent->priv;
+	struct rdt_resource *r =3D s->res;
+
+	seq_printf(seq, "%u\n", r->cache.arch_has_sparse_bitmasks);
+
+	return 0;
+}
+
 /**
  * __rdtgroup_cbm_overlaps - Does CBM for intended closid overlap with other
  * @r: Resource to which domain instance @d belongs.
@@ -1839,6 +1850,13 @@ static struct rftype res_common_files[] =3D {
 		.seq_show	=3D rdtgroup_size_show,
 		.fflags		=3D RF_CTRL_BASE,
 	},
+	{
+		.name		=3D "sparse_masks",
+		.mode		=3D 0444,
+		.kf_ops		=3D &rdtgroup_kf_single_ops,
+		.seq_show	=3D rdt_has_sparse_bitmasks_show,
+		.fflags		=3D RF_CTRL_INFO | RFTYPE_RES_CACHE,
+	},
=20
 };
=20
