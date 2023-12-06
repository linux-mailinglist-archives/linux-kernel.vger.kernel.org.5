Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE9DA8075A6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 17:48:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379497AbjLFQsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 11:48:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378367AbjLFQsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 11:48:11 -0500
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 999B3139;
        Wed,  6 Dec 2023 08:48:17 -0800 (PST)
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3B6Cx1xJ023287;
        Wed, 6 Dec 2023 17:48:13 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding:content-type; s=selector1; bh=OyJnv+1
        l0Q6v/UEtKlkDjwaD6vRciCU1OCgHK5aMcVc=; b=IO7w7bgde0LPG4dTuCpIm8k
        HG2Bpps5Yl4y2rzRtyog39UCvGpgNBNi9wJVQ+mP55H8t80TgBX2u6sjGP6eIRWt
        GsIi1XN4opKGwdYUySM6OfYqTdxJgUBdZn6qhShE6qflShXifCOZUEpwQGjO3A73
        o2hYJecTPSADHmAvMll58mFRRQu+IAndub0zQjmZ92VuVIlGSsfdS4WME1a8n6PQ
        ETGz3kUo/uxFfV+nOqFk8SNnv4i7HiviVIj1nupq8jep4TlebDt0FGAn9vwK6RjY
        cSNbRDCuq9IPxdGU7FbwXjn+RkrSiaMIsOTAuXjbXZVymCjMR+iMziVVDPAhsAw=
        =
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3utd2jm0ev-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Dec 2023 17:48:13 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id ED9D8100052;
        Wed,  6 Dec 2023 17:48:12 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id CFD6826C9F0;
        Wed,  6 Dec 2023 17:48:12 +0100 (CET)
Received: from localhost (10.201.20.59) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 6 Dec
 2023 17:48:12 +0100
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
To:     <william.gray@linaro.org>
CC:     <fabrice.gasnier@foss.st.com>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 0/2] tools: counter: add counter_watch_events
Date:   Wed, 6 Dec 2023 17:47:24 +0100
Message-ID: <20231206164726.418990-1-fabrice.gasnier@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.201.20.59]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-06_15,2023-12-06_01,2023-05-22_02
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
- This is a split of another series [1].
[1] https://lore.kernel.org/lkml/20230922143920.3144249-1-fabrice.gasnier@foss.st.com/

Fabrice Gasnier (2):
  tools/counter: add a flexible watch events tool
  MAINTAINERS: add myself as counter watch events tool maintainer

 MAINTAINERS                          |   5 +
 tools/counter/Build                  |   1 +
 tools/counter/Makefile               |  12 +-
 tools/counter/counter_watch_events.c | 372 +++++++++++++++++++++++++++
 4 files changed, 388 insertions(+), 2 deletions(-)
 create mode 100644 tools/counter/counter_watch_events.c

-- 
2.25.1

