Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 240EF7CC2E1
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 14:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235133AbjJQMSb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 08:18:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234341AbjJQMSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 08:18:06 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D5D41A6;
        Tue, 17 Oct 2023 05:18:04 -0700 (PDT)
Date:   Tue, 17 Oct 2023 12:18:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697545083;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Zc6GlekuIaWruxlY92BP4Vwz5FKNVgtXn0mapz3PSMk=;
        b=AiFhEcnKcFBlUPxppjSBgAuqlWHgVNN6+Wdnj82xoxc+MbIPFi3r/rSAC93GiGP9LBhOAe
        Z3GiAzYznFPAzwfHudDDxGktzmH3mykUJQVTiOcNXCC1WDh6gL6rCyba1tGWTp1ciVK4IP
        LIgIP6ldsp8bxKPskgLPA6rMtEvtsTn30L3YfwNKWKg8ORe96AB3Zv5Fsj/SqGz0i/xiNZ
        mTkxES5FImpF/3CpwFN+iakuQXuwosCQBpl6fB980OBhfDq96yUq+cIbgKQI4IxJHgJVgq
        X/X0R4zL5m7qMLXYulcxaB4/AMSoyzLytxv7vvJq4LEVYkyxnSBrVVgB2CijpQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697545083;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Zc6GlekuIaWruxlY92BP4Vwz5FKNVgtXn0mapz3PSMk=;
        b=D9XhXmUL3J4Ympzru/pshdT8UtxcdKZKhSQTNGBYqaqoq0klOZqbsyjQqup5hLCITDdCyi
        SoO6F80L93cNJYDw==
From:   "tip-bot2 for Babu Moger" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Simplify rftype flag definitions
Cc:     Babu Moger <babu.moger@amd.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Peter Newman <peternewman@google.com>,
        Tan Shaopeng <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        ilpo.jarvinen@linux.intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231017002308.134480-3-babu.moger@amd.com>
References: <20231017002308.134480-3-babu.moger@amd.com>
MIME-Version: 1.0
Message-ID: <169754508232.3135.14616801148439548823.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     6846dc1a31d1894a7acf52d8442fe73b34091022
Gitweb:        https://git.kernel.org/tip/6846dc1a31d1894a7acf52d8442fe73b340=
91022
Author:        Babu Moger <babu.moger@amd.com>
AuthorDate:    Tue, 03 Oct 2023 18:54:22 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 17 Oct 2023 11:51:16 +02:00

x86/resctrl: Simplify rftype flag definitions

The rftype flags are bitmaps used for adding files under the resctrl
filesystem. Some of these bitmap defines have one extra level of
indirection which is not necessary.

Drop the RF_* defines and simplify the macros.

  [ bp: Massage commit message. ]

Signed-off-by: Babu Moger <babu.moger@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Peter Newman <peternewman@google.com>
Reviewed-by: Tan Shaopeng <tan.shaopeng@jp.fujitsu.com>
Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
Tested-by: Peter Newman <peternewman@google.com>
Tested-by: Tan Shaopeng <tan.shaopeng@jp.fujitsu.com>
Link: https://lore.kernel.org/r/20231017002308.134480-3-babu.moger@amd.com
---
 arch/x86/kernel/cpu/resctrl/internal.h |  9 +++------
 arch/x86/kernel/cpu/resctrl/rdtgroup.c |  6 +++++-
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/res=
ctrl/internal.h
index c47ef2f..0ad970c 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -243,12 +243,9 @@ struct rdtgroup {
  */
 #define RFTYPE_INFO			BIT(0)
 #define RFTYPE_BASE			BIT(1)
-#define RF_CTRLSHIFT			4
-#define RF_MONSHIFT			5
-#define RF_TOPSHIFT			6
-#define RFTYPE_CTRL			BIT(RF_CTRLSHIFT)
-#define RFTYPE_MON			BIT(RF_MONSHIFT)
-#define RFTYPE_TOP			BIT(RF_TOPSHIFT)
+#define RFTYPE_CTRL			BIT(4)
+#define RFTYPE_MON			BIT(5)
+#define RFTYPE_TOP			BIT(6)
 #define RFTYPE_RES_CACHE		BIT(8)
 #define RFTYPE_RES_MB			BIT(9)
 #define RF_CTRL_INFO			(RFTYPE_INFO | RFTYPE_CTRL)
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/res=
ctrl/rdtgroup.c
index fe23969..09141f1 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -3260,7 +3260,11 @@ static int mkdir_rdt_prepare(struct kernfs_node *paren=
t_kn,
 		goto out_destroy;
 	}
=20
-	files =3D RFTYPE_BASE | BIT(RF_CTRLSHIFT + rtype);
+	if (rtype =3D=3D RDTCTRL_GROUP)
+		files =3D RFTYPE_BASE | RFTYPE_CTRL;
+	else
+		files =3D RFTYPE_BASE | RFTYPE_MON;
+
 	ret =3D rdtgroup_add_files(kn, files);
 	if (ret) {
 		rdt_last_cmd_puts("kernfs fill error\n");
