Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F30B7BB5FF
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 13:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231978AbjJFLLC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 07:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231868AbjJFLK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 07:10:56 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8361CCE
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 04:10:51 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3965fxcd025983;
        Fri, 6 Oct 2023 06:10:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding:content-type; s=PODMain02222019; bh=c
        bDIOHk1TYtJQuis+jBuSG2cu07UQYOZQb2kDXNYLS0=; b=oCTI88omBaPp0KeCo
        eJXs71e5vjap34eZTUoiY4rWfub2tdnYvqSvRol7cmI1luo+Ik8rUw5jnuML8ar+
        tVV4El61EGTT4SjRjhY8JXzE/wgLYS6ZCI8Upgwl9okZbcJkhtlbhTUgchVOupPb
        7o9gXDHbE4rpe/rkVM/Em/XfKeDjv+OSoXY1SazcYT/1BSmwXCcHJ7pJe32kdRlQ
        OThfRuz1x2YsFGUhZflPkxtB0kb1rhEfysyKlEPvEyFF5S5sCTX9MPP+olOYop5r
        jPdf3e2pTUE/x+KjgL8Td4Is/mTjWmOxTfUo6mi85AmF1b2yFoMBGM2pDU2jI16h
        fRicA==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3th2dtbmxb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 Oct 2023 06:10:44 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Fri, 6 Oct
 2023 12:10:42 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.37 via Frontend
 Transport; Fri, 6 Oct 2023 12:10:42 +0100
Received: from work-debian.ad.cirrus.com (unknown [198.61.64.45])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id E6D7D11AA;
        Fri,  6 Oct 2023 11:10:41 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 0/4] ASoC: cs35l56: Update hibernate/wake sequences and enable hibernation
Date:   Fri, 6 Oct 2023 12:10:35 +0100
Message-ID: <20231006111039.101914-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: -jK31S8zeRlMnfxWOtMwC7ZGvMZ_jtZy
X-Proofpoint-GUID: -jK31S8zeRlMnfxWOtMwC7ZGvMZ_jtZy
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the hibernate and wake command sequences to meet the latest
datasheet specification and enable hibernation for I2C and SPI control
interfaces.

Richard Fitzgerald (1):
  ASoC: cs35l56: Enable low-power hibernation mode on SPI

Simon Trimmer (3):
  ASoC: cs35l56: Change hibernate sequence to use allow auto hibernate
  ASoC: cs35l56: Wake transactions need to be issued twice
  ASoC: cs35l56: Enable low-power hibernation mode on i2c

 include/sound/cs35l56.h           |  1 +
 sound/soc/codecs/cs35l56-i2c.c    |  1 +
 sound/soc/codecs/cs35l56-shared.c | 66 +++++++++++++++++++------------
 sound/soc/codecs/cs35l56-spi.c    |  1 +
 4 files changed, 43 insertions(+), 26 deletions(-)

-- 
2.30.2

