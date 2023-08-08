Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB7B774DFC
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 00:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbjHHWIN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 18:08:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231774AbjHHWIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 18:08:06 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAC00114C97
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 09:47:45 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 378F5h5d030864;
        Tue, 8 Aug 2023 11:47:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding:content-type; s=PODMain02222019; bh=0
        0xMZj8YEMZyIQgL/8c62+rl+WEaMsRlVV3Zm+qzXig=; b=RP+OZ7bC5HlblkKe7
        wSKnvWn+gVxn3/PIrGwj+ylSXo360j7dk0V9tPTLD5NCjghwySKH0zllN4kHffhn
        z8qnfd/UsdujbmysnfJ8m8oAqcjJivYsxVA3Xue93WQE6tSb/Z5vc6RAvIku0N9m
        KLi3HZBqunSfGsd8NOV9ub4uSZSHrHZ3cPEz+JxXXs3pyIePZG7lE3bGraE7IdKn
        ooKODhlYFZsjYt4lgjiXJYjHYnpY6EIuLezH1zcjiWMpEGeXe2iAGjILs3vi70Xc
        xvI7BFACmbJxfz2YfhxCgqmBW2alX4HRPg2YfxEmny/Gxx55ExNUUdkwlOr9BH4k
        6G+0A==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3s9juhtucq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Aug 2023 11:47:06 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Tue, 8 Aug
 2023 17:47:04 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.30 via Frontend
 Transport; Tue, 8 Aug 2023 17:47:04 +0100
Received: from EDIN4L06LR3.ad.cirrus.com (EDIN4L06LR3.ad.cirrus.com [198.61.64.220])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 5519D3563;
        Tue,  8 Aug 2023 16:47:04 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 0/5] ASoC: cs35l56: Bugfixes
Date:   Tue, 8 Aug 2023 17:46:57 +0100
Message-ID: <20230808164702.21272-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: ZN6SGbbi5zjDOJx6-lRfFQNe1AU16ndT
X-Proofpoint-ORIG-GUID: ZN6SGbbi5zjDOJx6-lRfFQNe1AU16ndT
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Miscellaneous bugfixes for the cs35l56 codec driver.

Richard Fitzgerald (3):
  ASoC: cs35l56: Avoid uninitialized variable in
    cs35l56_set_asp_slot_positions()
  ASoC: cs35l56: Don't rely on GPIOD_OUT_LOW to set RESET initially low
  ASoC: cs35l56: Wait for control port ready during system-resume

Simon Trimmer (2):
  ASoC: wm_adsp: Expose the DSP power down actions as
    wm_adsp_power_down()
  ASoC: cs35l56: Call wm_adsp_power_down() before reloading firmware

 sound/soc/codecs/cs35l56.c | 33 +++++++++++++++++----------------
 sound/soc/codecs/wm_adsp.c |  8 +++++++-
 sound/soc/codecs/wm_adsp.h |  1 +
 3 files changed, 25 insertions(+), 17 deletions(-)

-- 
2.30.2

