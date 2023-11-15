Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D58D7EC86C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 17:21:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231859AbjKOQV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 11:21:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbjKOQVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 11:21:53 -0500
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF11BC7;
        Wed, 15 Nov 2023 08:21:49 -0800 (PST)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3AF8RK0C026572;
        Wed, 15 Nov 2023 10:21:27 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding:content-type; s=PODMain02222019; bh=O
        fI6CrE/9UJCZK4OYkAo2fAbStCJyzA/dUGw6hjQ0Wc=; b=bV9yySWdeRy2eRe45
        P476pDWaLZKvLfl4MM9Pm8lAAmYioCynF8tZbxB8PjFwi/eIq+HGQQD7H4o3o60d
        jWNOc87dQkiLHKt1YtFOHe5hSsbHi6IanOoQmYpn9PwCOW0vilRCW9AYtxb1Zjxx
        gR5sjle83yzFrTddFIiHzO+cERT1PFdDaCn/dgaL66tJN+7L5aqDmBa/RHbJsGy6
        aHNH5Wm0OR/aQBLgrU6oJIGRLNW/uamIoIzQif85e7G0yOMGz4FydtnHu+zUDSr8
        wmiQy304HpJhSNiyQNaPTSWM+M7DZDaouWZZWl0loInTV6NI6kTAjwB10N6gzMQN
        rVfKg==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3ua6wpcxwt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Nov 2023 10:21:26 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Wed, 15 Nov
 2023 16:21:25 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.39 via Frontend Transport; Wed, 15 Nov 2023 16:21:25 +0000
Received: from sbinding-cirrus-dsktp2.ad.cirrus.com (unknown [198.90.238.232])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id C081946B;
        Wed, 15 Nov 2023 16:21:24 +0000 (UTC)
From:   Stefan Binding <sbinding@opensource.cirrus.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>, <linux-sound@vger.kernel.org>,
        "Stefan Binding" <sbinding@opensource.cirrus.com>
Subject: [PATCH v1 0/2] Add quirks for various HP and ASUS laptops
Date:   Wed, 15 Nov 2023 16:21:14 +0000
Message-ID: <20231115162116.494968-1-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: pCrOX24X6tdxHldjdOo2IO8trr4rIyBd
X-Proofpoint-ORIG-GUID: pCrOX24X6tdxHldjdOo2IO8trr4rIyBd
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for CS35L41 HDA for ASUS Zenbook laptops and HP G11
laptops.

Stefan Binding (2):
  ALSA: hda/realtek: Add quirks for ASUS 2024 Zenbooks
  ALSA: hda/realtek: Add quirks for HP Laptops

 sound/pci/hda/patch_realtek.c | 7 +++++++
 1 file changed, 7 insertions(+)

-- 
2.34.1

