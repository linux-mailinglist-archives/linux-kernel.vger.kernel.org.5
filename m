Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F188D77E6EF
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 18:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344766AbjHPQtl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 12:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344959AbjHPQtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 12:49:22 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0CAA272C
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 09:49:18 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 37GGbfku011492;
        Wed, 16 Aug 2023 11:49:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding:content-type; s=PODMain02222019; bh=L
        Qm5pyqjCHNodjZHHsVTjh/X9KbRW9yz771dpk1szQQ=; b=cEvcaHkSs62mRPptP
        nImOwZhw/eBhtwrQF9xS4lCP1qn3V/lNNl9mRZ5Xs0tztE6Rp+mm08DcxLdphfM9
        WOtjAMHut39Y036xoscDOhU4rSj8PhB8nwgDHPH8lhGZHRYwWsJOOkAdLBC9NQ/C
        fx75rbnOYeKMl9T60ogeKn44i8PYDZSySDi/gjOoKWmY387BxMKl6vCR5qP1ais7
        IaBBOThxp3Re6nEDKJymYmcD07Eg+TJqMDY+zUIUMk9Qs3UJQfLIBctuvPJ7ifq2
        XiTAcIdoCWd9Vx+8yOtWmNy8bmSfs2ceVe2+k/ftYqbNogkxK7bS4F5Gi4L97/bb
        Xwe6w==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3se6uhmdw1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Aug 2023 11:49:10 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Wed, 16 Aug
 2023 17:49:08 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.30 via Frontend
 Transport; Wed, 16 Aug 2023 17:49:08 +0100
Received: from EDIN4L06LR3.ad.cirrus.com (EDIN4L06LR3.ad.cirrus.com [198.61.65.68])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 8FF503578;
        Wed, 16 Aug 2023 16:49:08 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 0/2] ASoC: cs35l56: Update ACPI HID and property
Date:   Wed, 16 Aug 2023 17:49:04 +0100
Message-ID: <20230816164906.42-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: mgpguMEEgnmgvjTHO3mfI7_ZA4zKQhsh
X-Proofpoint-ORIG-GUID: mgpguMEEgnmgvjTHO3mfI7_ZA4zKQhsh
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These two patches add an ACPI HID and update the way the platform-
specific firmware identifier is extracted from the ACPI.

Maciej Strozek (1):
  ASoC: cs35l56: Read firmware uuid from a device property instead of
    _SUB

Simon Trimmer (1):
  ASoC: cs35l56: Add an ACPI match table

 sound/soc/codecs/cs35l56-i2c.c |  9 +++++++++
 sound/soc/codecs/cs35l56-spi.c |  9 +++++++++
 sound/soc/codecs/cs35l56.c     | 31 ++++++++++++++-----------------
 3 files changed, 32 insertions(+), 17 deletions(-)

-- 
2.30.2

