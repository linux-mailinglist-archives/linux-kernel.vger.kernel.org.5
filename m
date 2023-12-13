Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 125A8811B06
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 18:31:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441850AbjLMRb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 12:31:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233671AbjLMRbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 12:31:23 -0500
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C85A2F2;
        Wed, 13 Dec 2023 09:31:29 -0800 (PST)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3BDEtGLb015229;
        Wed, 13 Dec 2023 18:31:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding:content-type; s=selector1; bh=ngdp73d
        AuDm5AN/748uVz+OSMkfWpN/pQEhJ8oclM3s=; b=TMNuGjk76NS32lDMVLYG+tV
        iMece0whzUF0sMv6jI42DJcDe1TLPgwSzMUK1GZ+cl6w+Cox3JSDGyeGgI3Zp/gs
        BMBKoTFrx/VTQrc+bsa9Y7TUcAD3dzek4ynsvf3P4sJaZbVme+bimTwvRmhBfOCR
        SOlkKG9Fy+fKAGtTnF6d4zO9DvP4PrdqvDiYFaAksaUyFB4WDMbm7hxZe5oAZxXm
        vGbws2zdFEMIlhEXkvqibTSS11pgKcBHgCkC5bRn8yBDVs9eJkwIW2P6EKeSGHDu
        vZRPYDM4rVpAvotoiXAeiNcVBRH+YreYcLyKP/r/YiIHPDtYHb/ffCIGV7n4x6A=
        =
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3uvgf1snjv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Dec 2023 18:31:27 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id DA334100057;
        Wed, 13 Dec 2023 18:31:25 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B099026598C;
        Wed, 13 Dec 2023 18:31:25 +0100 (CET)
Received: from localhost (10.252.26.85) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 13 Dec
 2023 18:31:24 +0100
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
To:     <william.gray@linaro.org>
CC:     <fabrice.gasnier@foss.st.com>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 0/2] tools: counter: add counter_watch_events
Date:   Wed, 13 Dec 2023 18:31:15 +0100
Message-ID: <20231213173117.4174511-1-fabrice.gasnier@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.252.26.85]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-13_10,2023-12-13_01,2023-05-22_02
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduces a new tool that can be used for testing. Also
add MAINTAINERS entry as per William's recommendations.

Changelog:
Changes in V4:
- Specify linux-iio mailing list in MAINTAINERS
- Revisit error path and handling in counter_watch_events

Series split, e.g. V3:
- This is a split of another series [1].
[1] https://lore.kernel.org/lkml/20230922143920.3144249-1-fabrice.gasnier@foss.st.com/

Fabrice Gasnier (2):
  tools/counter: add a flexible watch events tool
  MAINTAINERS: add myself as counter watch events tool maintainer

 MAINTAINERS                          |   6 +
 tools/counter/Build                  |   1 +
 tools/counter/Makefile               |  12 +-
 tools/counter/counter_watch_events.c | 406 +++++++++++++++++++++++++++
 4 files changed, 423 insertions(+), 2 deletions(-)
 create mode 100644 tools/counter/counter_watch_events.c

-- 
2.25.1

