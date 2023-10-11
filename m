Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E63A57C5E30
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 22:18:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347027AbjJKUSZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 16:18:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233360AbjJKUSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 16:18:23 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7C569D;
        Wed, 11 Oct 2023 13:18:21 -0700 (PDT)
Date:   Wed, 11 Oct 2023 20:18:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697055499;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zaCIBCsVd4Wuoa1RVMA712obRlLRCJv6Yp3ESSZPfQE=;
        b=SrK3Bu0AuSLhwfcHf5PkuU+XP+Wfa41vbVSSBoiBRQVaH8dbfnYcIJvGuuSGNjC6BoD2hc
        HP1TZD6G8U18b4SCn/phm6mioPlmm+NM74uEhuWZH+1kapTlDNDCSC7sIXaj9P/sAqlFni
        O8XCTLUEqld89Oyj/jIgjn0DtPlQHiFdZCbFIXT5xvGxxPDvMZF0N4n7cSSnjPC48kGes/
        1z6/vNcZjUAFJHGoHLEsRmVv4TYvukHb/qYwg4GfF5CUPD9F2di3XezCJ7UpMYAtZhZ0oV
        fwdVS03mvUvJc3spMFhqMjToyI+KZTqlOPfVPde5j2b27aH7V6PQ8Vdno+4rAA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697055499;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zaCIBCsVd4Wuoa1RVMA712obRlLRCJv6Yp3ESSZPfQE=;
        b=+f31mnosN5M6K6qjw7mCTKzXQ+57p90O3wJYfonSTf+DMBRP7rGDZCvNUU1Wk6psokaMBL
        tJeMOHnN7deYOQBA==
From:   "tip-bot2 for Fenghua Yu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] Documentation/x86: Document resctrl's new sparse_masks
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        "Maciej Wieczor-Retman" <maciej.wieczor-retman@intel.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        ilpo.jarvinen@linux.intel.com,
        Peter Newman <peternewman@google.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Babu Moger <babu.moger@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C3e9610997164f648e15c5c2e90d4944ce36504fe=2E16969?=
 =?utf-8?q?34091=2Egit=2Emaciej=2Ewieczor-retman=40intel=2Ecom=3E?=
References: =?utf-8?q?=3C3e9610997164f648e15c5c2e90d4944ce36504fe=2E169693?=
 =?utf-8?q?4091=2Egit=2Emaciej=2Ewieczor-retman=40intel=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <169705549883.3135.3621026076011072533.tip-bot2@tip-bot2>
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

Commit-ID:     aaa5fa35743ab9f0726568611a85e3e15349b9bf
Gitweb:        https://git.kernel.org/tip/aaa5fa35743ab9f0726568611a85e3e1534=
9b9bf
Author:        Fenghua Yu <fenghua.yu@intel.com>
AuthorDate:    Tue, 10 Oct 2023 12:42:39 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 11 Oct 2023 21:52:10 +02:00

Documentation/x86: Document resctrl's new sparse_masks

The documentation mentions that non-contiguous bit masks are not
supported in Intel Cache Allocation Technology (CAT).

Update the documentation on how to determine if sparse bit masks are
allowed in L2 and L3 CAT.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Peter Newman <peternewman@google.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Babu Moger <babu.moger@amd.com>
Tested-by: Peter Newman <peternewman@google.com>
Link: https://lore.kernel.org/r/3e9610997164f648e15c5c2e90d4944ce36504fe.1696=
934091.git.maciej.wieczor-retman@intel.com
---
 Documentation/arch/x86/resctrl.rst | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resc=
trl.rst
index cb05d90..4c6421e 100644
--- a/Documentation/arch/x86/resctrl.rst
+++ b/Documentation/arch/x86/resctrl.rst
@@ -124,6 +124,13 @@ related to allocation:
 			"P":
 			      Corresponding region is pseudo-locked. No
 			      sharing allowed.
+"sparse_masks":
+		Indicates if non-contiguous 1s value in CBM is supported.
+
+			"0":
+			      Only contiguous 1s value in CBM is supported.
+			"1":
+			      Non-contiguous 1s value in CBM is supported.
=20
 Memory bandwidth(MB) subdirectory contains the following files
 with respect to allocation:
@@ -445,12 +452,13 @@ For cache resources we describe the portion of the cach=
e that is available
 for allocation using a bitmask. The maximum value of the mask is defined
 by each cpu model (and may be different for different cache levels). It
 is found using CPUID, but is also provided in the "info" directory of
-the resctrl file system in "info/{resource}/cbm_mask". Intel hardware
+the resctrl file system in "info/{resource}/cbm_mask". Some Intel hardware
 requires that these masks have all the '1' bits in a contiguous block. So
 0x3, 0x6 and 0xC are legal 4-bit masks with two bits set, but 0x5, 0x9
-and 0xA are not.  On a system with a 20-bit mask each bit represents 5%
-of the capacity of the cache. You could partition the cache into four
-equal parts with masks: 0x1f, 0x3e0, 0x7c00, 0xf8000.
+and 0xA are not. Check /sys/fs/resctrl/info/{resource}/sparse_masks
+if non-contiguous 1s value is supported. On a system with a 20-bit mask
+each bit represents 5% of the capacity of the cache. You could partition
+the cache into four equal parts with masks: 0x1f, 0x3e0, 0x7c00, 0xf8000.
=20
 Memory bandwidth Allocation and monitoring
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
