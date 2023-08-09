Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C88957761E9
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 16:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231739AbjHIOBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 10:01:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbjHIOBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 10:01:15 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAB5898
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 07:01:14 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 379BTo13016955;
        Wed, 9 Aug 2023 09:00:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding:content-type; s=PODMain02222019; bh=k
        MzFI7LshscLz3RFU2EptoL35MGllDeBTDFZt7fveME=; b=qjadm/KtxuMgj+lx9
        eLH02zUEPwuvxRXpg3hJaHjyL5TdkM0aO0veU+imShlISfrVBmy0B8hvoX4OGEk/
        mA0C7IP006dOWwf98oCfzdmH2G/fFbxDRjDg4xHAhhiKESrARYuzPZGLVoVoloxu
        cRvdVdFmLMmJ9bkwqIC8JCWstimrp6ld+KUx8EYZdAiQ9ZEtyl2toor0R2nlczTH
        S4qb+86dA2kap3DZDCzt1vs7TBAgAX9g3zEmrNNBi3StRQ0VQ9Ku8sux5Det1s5w
        udWtHU+SpQ3osBXq/p4M16UUWFFd+iFT/Z6F+GDBJrFTXHmijXdh4tGLQWmGlF2G
        HIFug==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3sb7vtaggr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Aug 2023 09:00:58 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Wed, 9 Aug
 2023 15:00:56 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.30 via Frontend Transport; Wed, 9 Aug 2023 15:00:56 +0100
Received: from sbinding-cirrus-dsktp2.ad.cirrus.com (unknown [198.90.238.31])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 388A845D;
        Wed,  9 Aug 2023 14:00:56 +0000 (UTC)
From:   Stefan Binding <sbinding@opensource.cirrus.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH v1 0/2] Add HP G11 Quirks and update Dell Oasis Quirks
Date:   Wed, 9 Aug 2023 15:00:46 +0100
Message-ID: <20230809140048.669797-1-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: WjlZcFvkLV8wlhpr-ooS7MBg3kdTh5am
X-Proofpoint-ORIG-GUID: WjlZcFvkLV8wlhpr-ooS7MBg3kdTh5am
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add quirks to support HP G11 using CS35l41 HDA, using both SPI and I2C.
One older HP laptop has an SSID removed.
In addition, all Dell Oasis laptops using CS35L41 have been switch to
use SPI, with one SSID removed.

Stefan Binding (2):
  ALSA: hda/realtek: Add quirks for HP G11 Laptops
  ALSA: hda/realtek: Switch Dell Oasis models to use SPI

 sound/pci/hda/patch_realtek.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

-- 
2.34.1

