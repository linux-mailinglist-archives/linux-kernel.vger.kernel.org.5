Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE46A77788D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 14:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235467AbjHJMfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 08:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230335AbjHJMfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 08:35:09 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D9542130;
        Thu, 10 Aug 2023 05:35:08 -0700 (PDT)
Date:   Thu, 10 Aug 2023 12:35:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691670906;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sAJkSh2BwW3GTXYSnuBKrLWQttQ8wrAhI5yb2xW0nWU=;
        b=oOAkaRQYAUpVSlY0kS2jBHM2Ded+OXAucprj30Jxvk0QxVPpGH+2Qapjcs+y2Xfv1vk01d
        IY8SrtajhJEj1/ft2t7nLXCunNxwz3srydUrndt/M+ctySPaVEgVQms2GqNzUCktRg4n3d
        0JaAw/i7jAmfmuf3CI+e6KV4yKyp6gNT4p0dPn0/Qb/nmQVQgHBUTWz9Nt8rjl4Nq5T7ST
        fXZRT2Q5ZaGRezwdGufR/ka05cCgZ0GS3KUeoWzEoQihuh5kjF3DHSYRLUVNU02Kkwac6E
        L6j+a4jOKDhiZnnMsNUqrF3nmcoJP3EggCkvRuW/JQMwbBh01fl86xyaxC9Fwg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691670906;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sAJkSh2BwW3GTXYSnuBKrLWQttQ8wrAhI5yb2xW0nWU=;
        b=zvrkAH5nvwuE7jFevdKKpAgDyexE2/LRxMG8mTGnuO0usFSffh7oq4k3jSf/0iiFMZtAsx
        /uLZqtHTCWQ4QFDA==
From:   "tip-bot2 for Avadhut Naik" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/misc] hwmon: (k10temp) Add thermal support for AMD Family
 1Ah-based models
Cc:     Mario Limonciello <mario.limonciello@amd.com>,
        Avadhut Naik <Avadhut.Naik@amd.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Guenter Roeck <linux@roeck-us.net>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230809035244.2722455-3-avadhut.naik@amd.com>
References: <20230809035244.2722455-3-avadhut.naik@amd.com>
MIME-Version: 1.0
Message-ID: <169167090605.27769.12406039487431326529.tip-bot2@tip-bot2>
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

Commit-ID:     3cd9da416d5b625d52053c816ee91daf4e97007c
Gitweb:        https://git.kernel.org/tip/3cd9da416d5b625d52053c816ee91daf4e97007c
Author:        Avadhut Naik <Avadhut.Naik@amd.com>
AuthorDate:    Tue, 08 Aug 2023 22:52:43 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 10 Aug 2023 14:23:57 +02:00

hwmon: (k10temp) Add thermal support for AMD Family 1Ah-based models

Add thermal info support for AMD Family 1Ah-based models. Support is
provided on a per-socket granularity.

Co-developed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Avadhut Naik <Avadhut.Naik@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Guenter Roeck <linux@roeck-us.net>
Link: https://lore.kernel.org/r/20230809035244.2722455-3-avadhut.naik@amd.com
---
 drivers/hwmon/k10temp.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
index a267b11..bae0bec 100644
--- a/drivers/hwmon/k10temp.c
+++ b/drivers/hwmon/k10temp.c
@@ -65,7 +65,7 @@ static DEFINE_MUTEX(nb_smu_ind_mutex);
 #define F15H_M60H_HARDWARE_TEMP_CTRL_OFFSET	0xd8200c64
 #define F15H_M60H_REPORTED_TEMP_CTRL_OFFSET	0xd8200ca4
 
-/* Common for Zen CPU families (Family 17h and 18h and 19h) */
+/* Common for Zen CPU families (Family 17h and 18h and 19h and 1Ah) */
 #define ZEN_REPORTED_TEMP_CTRL_BASE		0x00059800
 
 #define ZEN_CCD_TEMP(offset, x)			(ZEN_REPORTED_TEMP_CTRL_BASE + \
@@ -475,6 +475,10 @@ static int k10temp_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 			k10temp_get_ccd_support(pdev, data, 12);
 			break;
 		}
+	} else if (boot_cpu_data.x86 == 0x1a) {
+		data->temp_adjust_mask = ZEN_CUR_TEMP_RANGE_SEL_MASK;
+		data->read_tempreg = read_tempreg_nb_zen;
+		data->is_zen = true;
 	} else {
 		data->read_htcreg = read_htcreg_pci;
 		data->read_tempreg = read_tempreg_pci;
@@ -521,6 +525,8 @@ static const struct pci_device_id k10temp_id_table[] = {
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_19H_M60H_DF_F3) },
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_19H_M70H_DF_F3) },
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_19H_M78H_DF_F3) },
+	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_1AH_M00H_DF_F3) },
+	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_1AH_M20H_DF_F3) },
 	{ PCI_VDEVICE(HYGON, PCI_DEVICE_ID_AMD_17H_DF_F3) },
 	{}
 };
