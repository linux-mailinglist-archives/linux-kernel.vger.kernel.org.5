Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 130FF7B6597
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 11:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239647AbjJCJem (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 05:34:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239649AbjJCJel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 05:34:41 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6319FB0
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 02:34:38 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3935eiRf001901;
        Tue, 3 Oct 2023 04:34:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding:content-type; s=PODMain02222019; bh=+
        x4NQb1d9mbAApEiNZTnO6OPZ2dnnHZ0KF4kLSPR8hI=; b=nUbs1eiLsCyzjw7wN
        G0i1ldKudnKkSsOVztNhjs+fnWPW/F6UGpMQIYebYX0sw9UJOG/MxyxgIEpFQtJI
        OlK99vsAw4KcSFqyERoOKCSKbBPaLc/Jpf7PbRFKA4dW3MTSRuFUUQW0Vdzhsbav
        x5IyCazLZIGwha3dlZIRzo5DaTXoBzDd5vdUIXe1r+g1+hPikq7whJXKMwFvk1I2
        hHeEaAaxfukrTkW+VQm9APfJNTNRccpbH37txAwQ06ufWjnGpn1Lyztm7T/mcFm0
        /2VVYoLexuMuQggB4t8nd4H/jJ+sxuPbxGafbL5Cnvh1N1RXmzsk3Tp5xT/32c68
        Nr4lQ==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3teh2xvbf2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Oct 2023 04:34:26 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Tue, 3 Oct
 2023 10:34:23 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.37 via Frontend Transport; Tue, 3 Oct 2023 10:34:23 +0100
Received: from EDIN4L06LR3.ad.cirrus.com (EDIN4L06LR3.ad.cirrus.com [198.61.64.133])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 6FD5246B;
        Tue,  3 Oct 2023 09:34:23 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        <alsa-devel@alsa-project.org>,
        Simon Trimmer <simont@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH] ASoC: cs35l56: Remove unused hibernate wake constants
Date:   Tue, 3 Oct 2023 10:34:18 +0100
Message-ID: <20231003093418.21600-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: J9UD8EF50h0AyDX4iDgBSOibNIJlH6ED
X-Proofpoint-ORIG-GUID: J9UD8EF50h0AyDX4iDgBSOibNIJlH6ED
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Simon Trimmer <simont@opensource.cirrus.com>

The two CS35L56_HIBERNATE_WAKE_* constants in cs35l56.h aren't used by
any of the driver code.

Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 include/sound/cs35l56.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/sound/cs35l56.h b/include/sound/cs35l56.h
index 3950322bf3cb..762b96b29211 100644
--- a/include/sound/cs35l56.h
+++ b/include/sound/cs35l56.h
@@ -242,8 +242,6 @@
 #define CS35L56_CONTROL_PORT_READY_US			2200
 #define CS35L56_HALO_STATE_POLL_US			1000
 #define CS35L56_HALO_STATE_TIMEOUT_US			50000
-#define CS35L56_HIBERNATE_WAKE_POLL_US			500
-#define CS35L56_HIBERNATE_WAKE_TIMEOUT_US		5000
 #define CS35L56_RESET_PULSE_MIN_US			1100
 
 #define CS35L56_SDW1_PLAYBACK_PORT			1
-- 
2.30.2

