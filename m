Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 166347E625B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 03:44:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232272AbjKICoo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 21:44:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232221AbjKICol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 21:44:41 -0500
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9239526A9;
        Wed,  8 Nov 2023 18:44:39 -0800 (PST)
Received: from pps.filterd (m0150245.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A91g8An006232;
        Thu, 9 Nov 2023 02:44:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=1sywxJVua6dYMGmGm3mNcBR+fZM+/B8ROrKI2bKHSHU=;
 b=T5l2oM7+V3GDmatTb2/jkBs2YyrQllxe8PMlRWUwq1iz55apVlHOyzkDv4/UkcOkSRcf
 qQJ1Zbty6jrpFaE17gzbLsechp0bMWXCgm5iii62ATH+diiymNFgESUhyNYUamP1PjAL
 Nfs3hsFHVq8zk/IoAru4WHtBuAW4Eh4AboNfZckzcr3fPL0xeI6neXmJcHoDJ007kucb
 h3jbkV6UXcwm5OI4ID+l48cUFl8Lp0rzFpQluC3GBE/tgE/SmYjtnsffUP5C1udmlkrY
 fmgWf/bmu/+IJ6WM/cfLdIqoxO70Q2UvnT+4uRXQ+oxGmBYDvEYlm8x9cf60tgg7vKrq 0A== 
Received: from p1lg14881.it.hpe.com ([16.230.97.202])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3u8cyanhn7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Nov 2023 02:44:20 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14881.it.hpe.com (Postfix) with ESMTPS id C6D74805E0F;
        Thu,  9 Nov 2023 02:44:19 +0000 (UTC)
Received: from anatevka.americas.hpqcorp.net (unknown [16.231.227.39])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id 6A83A806B76;
        Thu,  9 Nov 2023 02:44:19 +0000 (UTC)
From:   Jerry Hoemann <jerry.hoemann@hpe.com>
To:     linux@roeck-us.net, wim@linux-watchdog.org
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jerry Hoemann <jerry.hoemann@hpe.com>
Subject: [PATCH 2/2] watchdog/hpwdt: Remove checks on ilo5
Date:   Wed,  8 Nov 2023 19:44:07 -0700
Message-ID: <20231109024407.120856-3-jerry.hoemann@hpe.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231109024407.120856-1-jerry.hoemann@hpe.com>
References: <20231109024407.120856-1-jerry.hoemann@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: KDbwL8F3_ExFBepEmwFXziuv_ooM6KU5
X-Proofpoint-ORIG-GUID: KDbwL8F3_ExFBepEmwFXziuv_ooM6KU5
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-09_01,2023-11-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 priorityscore=1501 mlxlogscore=944 impostorscore=0 spamscore=0
 phishscore=0 adultscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311090020
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This test doesn't really do much.

ProLiant of vintage to have iLO 5, no longer send watchdog NMI as IO CHECK.
They are presented to hpwdt_pretimeout as UNKNOWN which is convered
by the preceding if statement.

Test could have been useful in the ERROR cases to validate FW set nmistat
register correctly but as the default value of "pretimeout" is true, this
test was almost always skipped during platform validation.

Without this if statment, we can remove all references to variable ilo5.

Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>
---
 drivers/watchdog/hpwdt.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
index 79ed1626d8ea..138dc8d8ca3d 100644
--- a/drivers/watchdog/hpwdt.c
+++ b/drivers/watchdog/hpwdt.c
@@ -33,7 +33,6 @@
 #define DEFAULT_MARGIN			30
 #define PRETIMEOUT_SEC			9
 
-static bool ilo5;
 static unsigned int soft_margin = DEFAULT_MARGIN;	/* in seconds */
 static bool nowayout = WATCHDOG_NOWAYOUT;
 static bool pretimeout = IS_ENABLED(CONFIG_HPWDT_NMI_DECODING);
@@ -181,9 +180,6 @@ static int hpwdt_pretimeout(unsigned int ulReason, struct pt_regs *regs)
 	if (ulReason == NMI_UNKNOWN && !mynmi)
 		return NMI_DONE;
 
-	if (ilo5 && !pretimeout && !mynmi)
-		return NMI_DONE;
-
 	if (kdumptimeout < 0)
 		hpwdt_stop();
 	else if (kdumptimeout == 0)
@@ -363,9 +359,6 @@ static int hpwdt_init_one(struct pci_dev *dev,
 				pretimeout ? "on" : "off");
 	dev_info(&dev->dev, "kdumptimeout: %d.\n", kdumptimeout);
 
-	if (dev->subsystem_vendor == PCI_VENDOR_ID_HP_3PAR)
-		ilo5 = true;
-
 	return 0;
 
 error_wd_register:
-- 
2.41.0

