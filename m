Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77510807987
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 21:37:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379588AbjLFUhp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 15:37:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379535AbjLFUhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 15:37:43 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 442FD1A5;
        Wed,  6 Dec 2023 12:37:49 -0800 (PST)
Date:   Wed, 06 Dec 2023 20:37:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1701895067;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DmqzdnVSaCif9lTTSTkVjsGHjFLNC1T4J8dN+L6XEQ8=;
        b=HYaloY/ARCZuBMNr2/41ylKEnOoSAHT/v9TGDARGS+Rf+rMQSFgUTCPcwle6dv/Jy3nk2n
        S0rwjkWBju9dOZt2jOFba0vzXFv1APUKGYFzCZar2ktII/YYjTkLo6hHH/bp1mtpDIhpPV
        S4eL22+zcW4m3uRpPaWdLVW57cnn3Rv/wGkdJq7z0acMujkCtoXKVPqog4acpUhaV1Q8sS
        lR1+G19MN4iLieiVwl1qZCy5Uq6Zq8NY5EWkD9SXSIl+IXMVWMBjbY9ExnQRVqX3KWU7Pv
        zU7O4vGxFexmSjIvR3jC4LUpmXDR80pP1AgA8MK0zUgSv3C6eI4bLMnG5okoRw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1701895067;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DmqzdnVSaCif9lTTSTkVjsGHjFLNC1T4J8dN+L6XEQ8=;
        b=lHBePM279ireXq9m69xnC3Yi0IZ3KFRQ5DtkeaONeXVCXwUXDPBt81FQV9a4SaMxF3OCAi
        D6UhtBVTiTjkgMCQ==
From:   "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] Documentation: Begin a RAS section
Cc:     "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <+u53@fat_crate.local>
References: <+u53@fat_crate.local>
MIME-Version: 1.0
Message-ID: <170189506697.398.1918586195547486556.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     cf0573939d3f4ce822ceb742a8179f38697b1953
Gitweb:        https://git.kernel.org/tip/cf0573939d3f4ce822ceb742a8179f38697b1953
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Tue, 28 Nov 2023 15:20:49 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 06 Dec 2023 21:07:52 +01:00

Documentation: Begin a RAS section

Add some initial RAS documentation. The expectation is for this to
collect, among others, all the user-visible features for interaction
with the RAS features of the kernel.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20231128142049.GTZWX3QQTSaQk/+u53@fat_crate.local
---
 Documentation/RAS/ras.rst | 26 ++++++++++++++++++++++++++
 Documentation/index.rst   |  1 +
 2 files changed, 27 insertions(+)
 create mode 100644 Documentation/RAS/ras.rst

diff --git a/Documentation/RAS/ras.rst b/Documentation/RAS/ras.rst
new file mode 100644
index 0000000..2556b39
--- /dev/null
+++ b/Documentation/RAS/ras.rst
@@ -0,0 +1,26 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+Reliability, Availability and Serviceability features
+=====================================================
+
+This documents different aspects of the RAS functionality present in the
+kernel.
+
+Error decoding
+---------------
+
+* x86
+
+Error decoding on AMD systems should be done using the rasdaemon tool:
+https://github.com/mchehab/rasdaemon/
+
+While the daemon is running, it would automatically log and decode
+errors. If not, one can still decode such errors by supplying the
+hardware information from the error::
+
+        $ rasdaemon -p --status <STATUS> --ipid <IPID> --smca
+
+Also, the user can pass particular family and model to decode the error
+string::
+
+        $ rasdaemon -p --status <STATUS> --ipid <IPID> --smca --family <CPU Family> --model <CPU Model> --bank <BANK_NUM>
diff --git a/Documentation/index.rst b/Documentation/index.rst
index 9dfdc82..36e6178 100644
--- a/Documentation/index.rst
+++ b/Documentation/index.rst
@@ -113,6 +113,7 @@ to ReStructured Text format, or are simply too old.
    :maxdepth: 1
 
    staging/index
+   RAS/ras
 
 
 Translations
