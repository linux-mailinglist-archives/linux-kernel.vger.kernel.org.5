Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B351B7B6596
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 11:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239642AbjJCJe2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 05:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231199AbjJCJe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 05:34:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D344090;
        Tue,  3 Oct 2023 02:34:23 -0700 (PDT)
Date:   Tue, 03 Oct 2023 09:34:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696325662;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wiaEifUQZM+72IROgiZLrf+fS5npBuehugw6N+3/MPA=;
        b=4IaB+AD9kQCJZoD8zsu8wudfovUnF5pDakpY2OOYNqQgt74qSQ+r81471OiDjFazbBt1YL
        yVAEA5YWqQmq1AWw42qbIJxW2LC2q7pW9wKXn5xTOIhbtS+cdIu8LMDLjFc2TUjSVGy5dp
        WDeUmK9li7dJ7OnhpFmXpyCZ7qm1SwEgBegj1Zf3PVN9VZiXbCRQV/oaRVMvh26BffTVYS
        AtDYtKQRKKe8bHatXNrL6+VMqPTPRSDBi3LwH91X29aBO4ZimdsQzF8/axkxCFTJxIANGA
        +pidHH2c13rQg7Nd7LsBWG5nmo5CScuoc2zRAsoDvY77sUjWSMXDPZqt2DIFkw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696325662;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wiaEifUQZM+72IROgiZLrf+fS5npBuehugw6N+3/MPA=;
        b=oJZ9AFF/qSaT1hMHEkpp0RC3cviUkFlExRZmV7XLQmKxMfsw+VUma9g/DEYq1pU4fx4PM9
        v8g6FR8oZWYqORCA==
From:   "tip-bot2 for Yazen Ghannam" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/platform] x86/amd_nb: Use Family 19h Models 60h-7Fh Function 4 IDs
Cc:     Yazen Ghannam <yazen.ghannam@amd.com>,
        Ingo Molnar <mingo@kernel.org>, stable@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230803150430.3542854-1-yazen.ghannam@amd.com>
References: <20230803150430.3542854-1-yazen.ghannam@amd.com>
MIME-Version: 1.0
Message-ID: <169632566187.3135.7497896905004308037.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/platform branch of tip:

Commit-ID:     2a565258b3f4bbdc7a3c09cd02082cb286a7bffc
Gitweb:        https://git.kernel.org/tip/2a565258b3f4bbdc7a3c09cd02082cb286a7bffc
Author:        Yazen Ghannam <yazen.ghannam@amd.com>
AuthorDate:    Thu, 03 Aug 2023 10:04:30 -05:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 03 Oct 2023 11:25:01 +02:00

x86/amd_nb: Use Family 19h Models 60h-7Fh Function 4 IDs

Three PCI IDs for DF Function 4 were defined but not used.

Add them to the "link" list.

Fixes: f8faf3496633 ("x86/amd_nb: Add AMD PCI IDs for SMN communication")
Fixes: 23a5b8bb022c ("x86/amd_nb: Add PCI ID for family 19h model 78h")
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20230803150430.3542854-1-yazen.ghannam@amd.com
---
 arch/x86/kernel/amd_nb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
index 10c2a3c..43238ac 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -116,6 +116,9 @@ static const struct pci_device_id amd_nb_link_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M10H_DF_F4) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M40H_DF_F4) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M50H_DF_F4) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M60H_DF_F4) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M70H_DF_F4) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M78H_DF_F4) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CNB17H_F4) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M00H_DF_F4) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_MI200_DF_F4) },
