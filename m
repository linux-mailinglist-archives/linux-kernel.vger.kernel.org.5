Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB03C787922
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 22:13:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243460AbjHXUMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 16:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243445AbjHXUM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 16:12:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01566CE;
        Thu, 24 Aug 2023 13:12:25 -0700 (PDT)
Date:   Thu, 24 Aug 2023 20:12:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1692907943;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4v26N/e7MwAvDdqriWJI++YZ4UBZmKSgwn13czBL9Ls=;
        b=NgL9R0spklTPnjcueKr6LoebJhh59WuLXRMh4hPnlX2cqVW0dhzXNzlpsIfoS9Pv2doK4g
        CVJiQ2e/Fo05Mz432i+eylqoyoMKL5LwT20EthBgwEem0yllm4/gPKTjpF5JBEVHyvz8ba
        9SJ4+Tfg0SXe1QQuMj3zgWbmuKhl20xej5B/OI2Q3PT/1aoJd0SxKkaZmm5QmGb4Qtqoqe
        q9eG5KJMR36zatSIc+qpjXcz3hfuggAT37w3Gqy7MwiGlz7ahgxmQ0NzJQSCoPLKuHFNOd
        GbDhHcUQGS8wiNV751dNKqlPOrcNf5RwTXAAmAsC1+BesiVn6CvUpAOxGoqK1A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1692907943;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4v26N/e7MwAvDdqriWJI++YZ4UBZmKSgwn13czBL9Ls=;
        b=l5JL1nn3UO54gIqhGGPqDnIYLogM8hNCeHt6LVy4G+fm90mKD3jPg0UquPdzQ2zEtKYyLd
        dUPItX2kpeYm19Bg==
From:   tip-bot2 for Ilpo =?utf-8?q?J=C3=A4rvinen?= 
        <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/uncore: Remove unnecessary ?: operator
 around pcibios_err_to_errno() call
Cc:     ilpo.jarvinen@linux.intel.com, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230824132832.78705-15-ilpo.jarvinen@linux.intel.com>
References: <20230824132832.78705-15-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Message-ID: <169290794282.27769.1361924280256053683.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     2c65477f14a359db9f1edee5dd8e683d3dae69e2
Gitweb:        https://git.kernel.org/tip/2c65477f14a359db9f1edee5dd8e683d3da=
e69e2
Author:        Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
AuthorDate:    Thu, 24 Aug 2023 16:28:32 +03:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 24 Aug 2023 21:25:24 +02:00

perf/x86/uncore: Remove unnecessary ?: operator around pcibios_err_to_errno()=
 call

If err =3D=3D 0, pcibios_err_to_errno(err) returns 0 so the ?: construct
can be removed.

Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20230824132832.78705-15-ilpo.jarvinen@linux.i=
ntel.com
---
 arch/x86/events/intel/uncore_snbep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/unc=
ore_snbep.c
index d49e90d..4d34998 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -1502,7 +1502,7 @@ static int snbep_pci2phy_map_init(int devid, int nodeid=
_loc, int idmap_loc, bool
=20
 	pci_dev_put(ubox_dev);
=20
-	return err ? pcibios_err_to_errno(err) : 0;
+	return pcibios_err_to_errno(err);
 }
=20
 int snbep_uncore_pci_init(void)
