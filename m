Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07A5880BEF6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 03:13:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232425AbjLKB66 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 20:58:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232355AbjLKB65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 20:58:57 -0500
X-Greylist: delayed 302 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 10 Dec 2023 17:59:03 PST
Received: from m228-63.mailgun.net (m228-63.mailgun.net [159.135.228.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE56ED8
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 17:59:03 -0800 (PST)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=michaelkloos.com;
 q=dns/txt; s=k1; t=1702259942; x=1702267142; h=Content-Transfer-Encoding:
 MIME-Version: Message-ID: Date: Subject: Subject: Cc: To: To: From: From:
 Sender: Sender; bh=1S+JBKzRPrgQ+DWtY3oDqgNdX3JGoElTw6Wl2Ji9RuQ=;
 b=CE/y5muJo9cVJHesMxgh1NthCBLZnHiOROe+NM1a8V7n28okZdJBtI3jU6XDtB0DGvBSb6lPLh22jqlp/L6HmYJCDrsT2CTJKNOB9ZPsvCgFIp+e0u8/iw0k42IZ9ov/HkbyoAs+vEAWy9abu4Yh4OFMNml10o8x6Ho68TzO6HA=
X-Mailgun-Sending-Ip: 159.135.228.63
X-Mailgun-Sid: WyI5NjYzNiIsImxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmciLCI0OGNjMCJd
Received: from drop1.michaelkloos.com (drop1.michaelkloos.com [67.205.190.89]) by
 a0d52d98d6af with SMTP id 65766bb81268d98757405a38 (version=TLS1.3,
 cipher=TLS_AES_128_GCM_SHA256); Mon, 11 Dec 2023 01:54:00 GMT
Sender: michael@michaelkloos.com
Received: from echelontp.home.michaelkloos.com (173-088-115-050.res.spectrum.com [173.88.115.50])
        by drop1.michaelkloos.com (Postfix) with ESMTPSA id E5AE54002A;
        Mon, 11 Dec 2023 01:53:59 +0000 (UTC)
From:   "Michael T. Kloos" <michael@michaelkloos.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Jeremy Soller <jeremy@system76.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        August Wikerfors <git@augustwikerfors.se>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc:     linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Michael T. Kloos" <michael@michaelkloos.com>
Subject: [PATCH] ASoC: Enable built-in microphone on Lenovo ThinkPad P14s Gen 4 (AMD)
Date:   Sun, 10 Dec 2023 20:52:25 -0500
Message-ID: <20231211015325.6793-1-michael@michaelkloos.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added System Board to Quirks List using model number prefix.
Replaced/Removed a duplicate entry in the list.
Added Yellow Carp Coprocessor Revision number to PCI revision check.

Signed-off-by: Michael T. Kloos <michael@michaelkloos.com>
---
 sound/soc/amd/yc/acp6x-mach.c | 2 +-
 sound/soc/amd/yc/pci-acp6x.c  | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index d83cb6e4c62a..c08605d99bc9 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -56,7 +56,7 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 		.driver_data = &acp6x_card,
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "21D0"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "21K5"),
 		}
 	},
 	{
diff --git a/sound/soc/amd/yc/pci-acp6x.c b/sound/soc/amd/yc/pci-acp6x.c
index 7af6a349b1d4..694b8e313902 100644
--- a/sound/soc/amd/yc/pci-acp6x.c
+++ b/sound/soc/amd/yc/pci-acp6x.c
@@ -162,6 +162,7 @@ static int snd_acp6x_probe(struct pci_dev *pci,
 	/* Yellow Carp device check */
 	switch (pci->revision) {
 	case 0x60:
+	case 0x63:
 	case 0x6f:
 		break;
 	default:
-- 
2.42.0

