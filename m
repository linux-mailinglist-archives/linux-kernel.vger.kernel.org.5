Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B34A277F541
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 13:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350332AbjHQL3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 07:29:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350382AbjHQL2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 07:28:48 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1209530FB
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 04:28:18 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 37HBMpDl018403;
        Thu, 17 Aug 2023 06:27:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding:content-type; s=PODMain02222019; bh=7
        1hP1qFBBQrsCWx8Ta62/z+hJB3mbnlDqwvJiEZuCyM=; b=jH+jOS65Dgle8IVg3
        OByfuXG/r2E4V4evtIxRTPXZo6JMseAIPCtaFsdoXFMUkQ0ltSyg5nl8mtpLPdeG
        zsO9ViNpFw/QXIDExmYZX9QdQ5/AAqZdKV3kZ2+H4+RCT9s9zGDfd35UqsPOgmtT
        dj3KtCvs7KHcrHIGhFb0Hv4PVyZfMlbksHSyEQV+zRpuiq0QCIjhksZNv/KK4YJn
        QsmfwXRc8nMGNKGbD7VgAD4072/+GGGZKVlcum3tzlzOMMulhxzDdG9TotR91e9z
        hBZoJaduE3krW7GYh53CNxNlCLrPjDNl1obbRMP8IcSmeSAutrftU/Ie5JK4gspz
        VYUhQ==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3se6uhn8td-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Aug 2023 06:27:16 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Thu, 17 Aug
 2023 12:27:15 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.30 via Frontend Transport; Thu, 17 Aug 2023 12:27:15 +0100
Received: from EDIN4L06LR3.ad.cirrus.com (EDIN4L06LR3.ad.cirrus.com [198.61.65.68])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 086B63575;
        Thu, 17 Aug 2023 11:27:15 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH v2 0/2] ASoC: cs35l56: Update ACPI HID and property
Date:   Thu, 17 Aug 2023 12:27:10 +0100
Message-ID: <20230817112712.16637-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: WwToYQLzcfST-iHR9Jef7H07jSR2nIfm
X-Proofpoint-ORIG-GUID: WwToYQLzcfST-iHR9Jef7H07jSR2nIfm
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These two patches add an ACPI HID and update the way the platform-
specific firmware identifier is extracted from the ACPI.

CHANGES SINCE V1:
- Rebased to apply on v6.4 and v6.5.
- Change kstrdup() to devm_kstrdup()

To apply on v6.6 a 1-line change is needed:

static int cs35l56_get_firmware_uid(struct cs35l56_private *cs35l56)
{
-       struct device *dev = cs35l56->dev;
+       struct device *dev = cs35l56->base.dev;

Maciej Strozek (1):
  ASoC: cs35l56: Read firmware uuid from a device property instead of
    _SUB

Simon Trimmer (1):
  ASoC: cs35l56: Add an ACPI match table

 sound/soc/codecs/cs35l56-i2c.c |  9 +++++++++
 sound/soc/codecs/cs35l56-spi.c |  9 +++++++++
 sound/soc/codecs/cs35l56.c     | 31 ++++++++++++-------------------
 3 files changed, 30 insertions(+), 19 deletions(-)

-- 
2.30.2

