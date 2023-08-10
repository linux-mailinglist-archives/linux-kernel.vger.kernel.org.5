Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4D3C77788A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 14:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235303AbjHJMfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 08:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231437AbjHJMfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 08:35:09 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A42F8213B;
        Thu, 10 Aug 2023 05:35:08 -0700 (PDT)
Date:   Thu, 10 Aug 2023 12:35:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691670906;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4AOA3juOIQNmrX4YecMJliaKSwuiLgc7BWVyKrv+dgw=;
        b=DJC7lwsXgKBIjUuVBSV4CeQ8cIp2UCrqz9iRn+CW5b8CRyWXg55gnTphy7qEzeLKZMmm4W
        f7Vlnhb7n0Hp0ZOteuReHl6DJ76Bj/a7bcf2rexuoVzWyyiHlPkr2O7YED8FbJOKMZQ/iy
        oJFpEZ7MX9rgg/Ud2JBYVUP+hCRC1Fdxt3tFQpxLs29OjANPJE4vDbSADlydmS1aEOjwSu
        nkWVi+bev3QXN7Z/LfyG4woeLqv9WHmPbSEmuPws4nWs5/OFwzv0sM5r8Kx328k7bzXAXd
        BNir2QKGIrBypL4Ebt4QinPc4rem/xW3nGERHdkvdUFBMvrmNk3QcMmy/Ol6EQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691670906;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4AOA3juOIQNmrX4YecMJliaKSwuiLgc7BWVyKrv+dgw=;
        b=jgiurzG1vy9C5oICQkvNIrUzQVpfZG301AIXmUVqVYZyveNqCZcusQpFOleulV8na/QZNd
        nq8uDdu3SOahqGBA==
From:   "tip-bot2 for Avadhut Naik" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/misc] EDAC/amd64: Add support for AMD family 1Ah models
 00h-1Fh and 40h-4Fh
Cc:     Avadhut Naik <Avadhut.Naik@amd.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230809035244.2722455-4-avadhut.naik@amd.com>
References: <20230809035244.2722455-4-avadhut.naik@amd.com>
MIME-Version: 1.0
Message-ID: <169167090547.27769.8367401801807081552.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/misc branch of tip:

Commit-ID:     c4d07c371283cb0453c8ce187551e4d064cc407e
Gitweb:        https://git.kernel.org/tip/c4d07c371283cb0453c8ce187551e4d064cc407e
Author:        Avadhut Naik <Avadhut.Naik@amd.com>
AuthorDate:    Tue, 08 Aug 2023 22:52:44 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 10 Aug 2023 14:25:21 +02:00

EDAC/amd64: Add support for AMD family 1Ah models 00h-1Fh and 40h-4Fh

Add support for family 1Ah-based models 00h-1Fh and 40h-4Fh.

  [ bp: Simplify. ]

Signed-off-by: Avadhut Naik <Avadhut.Naik@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20230809035244.2722455-4-avadhut.naik@amd.com
---
 drivers/edac/amd64_edac.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 597dae7..9b6642d 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -4150,6 +4150,20 @@ static int per_family_init(struct amd64_pvt *pvt)
 		}
 		break;
 
+	case 0x1A:
+		switch (pvt->model) {
+		case 0x00 ... 0x1f:
+			pvt->ctl_name           = "F1Ah";
+			pvt->max_mcs            = 12;
+			pvt->flags.zn_regs_v2   = 1;
+			break;
+		case 0x40 ... 0x4f:
+			pvt->ctl_name           = "F1Ah_M40h";
+			pvt->flags.zn_regs_v2   = 1;
+			break;
+		}
+		break;
+
 	default:
 		amd64_err("Unsupported family!\n");
 		return -ENODEV;
@@ -4344,6 +4358,7 @@ static const struct x86_cpu_id amd64_cpuids[] = {
 	X86_MATCH_VENDOR_FAM(AMD,	0x17, NULL),
 	X86_MATCH_VENDOR_FAM(HYGON,	0x18, NULL),
 	X86_MATCH_VENDOR_FAM(AMD,	0x19, NULL),
+	X86_MATCH_VENDOR_FAM(AMD,	0x1A, NULL),
 	{ }
 };
 MODULE_DEVICE_TABLE(x86cpu, amd64_cpuids);
