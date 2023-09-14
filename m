Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12E087A08A6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 17:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240289AbjINPJd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 11:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232858AbjINPJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 11:09:32 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35133A8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 08:09:28 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38ECunMH020490;
        Thu, 14 Sep 2023 10:09:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding:content-type; s=PODMain02222019; bh=S
        2UpFO3lB2wyOwT/WGOW/cnqkjwF0wKC7PyTNKd0P38=; b=DmRsOdkuy3W3BezcB
        5Rh02PdcQCe+j1op82uw3Ej2v5dXcxSuhcYsY95W1ecqC8pYiqz+r7FmogLOvOru
        cXNHPWDWdGZnKkkK3U+xEOvlIKBhnDk8TtjREjL5NeTiheMnrcA66Y69k87GxSOc
        jBfg2/DeEhXIXS3Hd9okML6gnJaWDEGKCYZFSL1SJyqfho80QCwDopeRZ79V9rop
        IGUgQi1yLdjTXKeFRAcMLvjFm1utUcd1kydoruPJDIud4haJzte95bWch/02Wql7
        xmzUnJUsmDGz8pb3lx2qe/kxXlJboltnLBO5JOwasFLw97mCxuJv+T/r3KqN/6PG
        JOysw==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3t2y7sj90x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Sep 2023 10:09:21 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Thu, 14 Sep
 2023 16:09:20 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.37 via Frontend Transport; Thu, 14 Sep 2023 16:09:20 +0100
Received: from EDIN4L06LR3.ad.cirrus.com (EDIN4L06LR3.ad.cirrus.com [198.61.65.215])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id F1E913563;
        Thu, 14 Sep 2023 15:09:19 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 0/3] ASoC: cs35l56: Define and export I2C/SPI pm_ops only if needed
Date:   Thu, 14 Sep 2023 16:09:15 +0100
Message-ID: <20230914150918.14505-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: _QPw9Fkw16YQYjvTJXiCeOUVT2RyzeqM
X-Proofpoint-ORIG-GUID: _QPw9Fkw16YQYjvTJXiCeOUVT2RyzeqM
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These 3 patches update the pm_ops for I2C/SPI so that they are only built
and exported if they are needed.

Richard Fitzgerald (3):
  ASoC: cs35l56: Use pm_ptr()
  ASoC: cs35l56: Use new export macro for dev_pm_ops
  ASoC: cs35l56: Omit cs35l56_pm_ops_i2c_spi if I2C/SPI not enabled

 sound/soc/codecs/cs35l56-i2c.c | 2 +-
 sound/soc/codecs/cs35l56-sdw.c | 2 +-
 sound/soc/codecs/cs35l56-spi.c | 2 +-
 sound/soc/codecs/cs35l56.c     | 5 +++--
 4 files changed, 6 insertions(+), 5 deletions(-)

-- 
2.30.2

