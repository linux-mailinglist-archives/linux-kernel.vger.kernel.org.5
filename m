Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3CBE75E737
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 03:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbjGXBZl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 21:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231343AbjGXBZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 21:25:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC26BAF;
        Sun, 23 Jul 2023 18:23:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7027860F00;
        Mon, 24 Jul 2023 01:23:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01B89C433C7;
        Mon, 24 Jul 2023 01:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690161800;
        bh=nHWZK9OMB4vgpd9celiYc+Idn94CYrqmvfMCY/zp124=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T1oIdoaUm03p1Kvn5ptid/64maq+wq0KCF2yWrw1ajueUHaBIYxvoAMyeZb3SimTB
         xEA0Qds3BYafirY9bvDDuuePHtk0OxtnzzBD5bdCupeCIBzJj2OTMh5Sfx1gj7Od4Z
         MJKrTrkU20YIuPemQVzZJiZjZnPQhVFUO6E+SaM30bquNLrwT+0oDyaSeK0QnbIAzU
         KH8YGxLIrVv1C2ooYRFzzlPkKRRUQL8AsPGcL6NBJugof0InYaFYrD52TNgN8D0rWy
         d/pFowHgbiyJ/PMyjNJbRSv5RKReE3hMa/3EY6H8N1u8roglnizISq0Iovrzi6dht/
         7eTJQXx3sxShg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Even Xu <even.xu@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Jiri Kosina <jkosina@suse.cz>, Sasha Levin <sashal@kernel.org>,
        jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 35/41] HID: intel-ish-hid: ipc: Add Arrow Lake PCI device ID
Date:   Sun, 23 Jul 2023 21:21:08 -0400
Message-Id: <20230724012118.2316073-35-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230724012118.2316073-1-sashal@kernel.org>
References: <20230724012118.2316073-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.40
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Even Xu <even.xu@intel.com>

[ Upstream commit 4982126e3029cd59fbd1da0d9cc0365a0585fe64 ]

Add device ID of Arrow Lake-H into ishtp support list.

Signed-off-by: Even Xu <even.xu@intel.com>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/intel-ish-hid/ipc/hw-ish.h  | 1 +
 drivers/hid/intel-ish-hid/ipc/pci-ish.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/hid/intel-ish-hid/ipc/hw-ish.h b/drivers/hid/intel-ish-hid/ipc/hw-ish.h
index fc108f19a64c3..e99f3a3c65e15 100644
--- a/drivers/hid/intel-ish-hid/ipc/hw-ish.h
+++ b/drivers/hid/intel-ish-hid/ipc/hw-ish.h
@@ -33,6 +33,7 @@
 #define ADL_N_DEVICE_ID		0x54FC
 #define RPL_S_DEVICE_ID		0x7A78
 #define MTL_P_DEVICE_ID		0x7E45
+#define ARL_H_DEVICE_ID		0x7745
 
 #define	REVISION_ID_CHT_A0	0x6
 #define	REVISION_ID_CHT_Ax_SI	0x0
diff --git a/drivers/hid/intel-ish-hid/ipc/pci-ish.c b/drivers/hid/intel-ish-hid/ipc/pci-ish.c
index 7120b30ac51d0..55cb25038e632 100644
--- a/drivers/hid/intel-ish-hid/ipc/pci-ish.c
+++ b/drivers/hid/intel-ish-hid/ipc/pci-ish.c
@@ -44,6 +44,7 @@ static const struct pci_device_id ish_pci_tbl[] = {
 	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, ADL_N_DEVICE_ID)},
 	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, RPL_S_DEVICE_ID)},
 	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, MTL_P_DEVICE_ID)},
+	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, ARL_H_DEVICE_ID)},
 	{0, }
 };
 MODULE_DEVICE_TABLE(pci, ish_pci_tbl);
-- 
2.39.2

