Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0D567F8D18
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 19:25:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231821AbjKYSZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 13:25:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjKYSZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 13:25:24 -0500
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 467BFD3;
        Sat, 25 Nov 2023 10:25:31 -0800 (PST)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3AP4pIvT029338;
        Sat, 25 Nov 2023 19:24:52 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        selector1; bh=V3Tv5qFFk5ZxQeDUxNUTAAu3mduf0PktUnlTC3Lmm5k=; b=3s
        zK15e0pA/ua5IMLkmESOskXzI7bY6AugncnVL/lxzRJVYmr+HJWEsow6/Jxfeaxk
        Vf1i1oEnGKsbJaMlVSks05cQ2qmBCvz043C1P1OxG7MqZ3sFoDv0gTg0OyLBrzpa
        83qHk40t2qbh+OpwyFvnthrKA9FlINPrEPV8IOnmlAoksnB9KHLCVsHi5Ndlld8/
        GCD21nlyDAZHtc53Nzpw/0SC59MxfgdczGPLTjOEanCaYeIL3sLQqqVCmHVyqUuT
        meWgs3zX+WzB5aIFJDQP7ZpLZlPzzlLzREJeX5uXjTtXgkmsz2zjA6WTUwAESVGo
        8JGb9nqNcKRp5kXnAwIQ==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3uk8pjhw1b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 25 Nov 2023 19:24:52 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D093510002A;
        Sat, 25 Nov 2023 19:24:51 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id C8CAB23C6B5;
        Sat, 25 Nov 2023 19:24:51 +0100 (CET)
Received: from localhost (10.129.178.213) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sat, 25 Nov
 2023 19:24:52 +0100
From:   Alain Volmat <alain.volmat@foss.st.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
        Sylvain Petinot <sylvain.petinot@foss.st.com>
CC:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Alain Volmat <alain.volmat@foss.st.com>,
        <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 6/7] media: i2c: st-mipid02: removal of unused link_frequency variable
Date:   Sat, 25 Nov 2023 19:20:54 +0100
Message-ID: <20231125182057.1379357-7-alain.volmat@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231125182057.1379357-1-alain.volmat@foss.st.com>
References: <20231125182057.1379357-1-alain.volmat@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.129.178.213]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-25_18,2023-11-22_01,2023-05-22_02
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

link_frequency variable within struct mipid02_dev seems to have never
been used hence remove it.

Signed-off-by: Alain Volmat <alain.volmat@foss.st.com>
---
 drivers/media/i2c/st-mipid02.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/media/i2c/st-mipid02.c b/drivers/media/i2c/st-mipid02.c
index 783c2848c584..ef0d7f8ba17d 100644
--- a/drivers/media/i2c/st-mipid02.c
+++ b/drivers/media/i2c/st-mipid02.c
@@ -96,7 +96,6 @@ struct mipid02_dev {
 	struct gpio_desc *reset_gpio;
 	/* endpoints info */
 	struct v4l2_fwnode_endpoint rx;
-	u64 link_frequency;
 	struct v4l2_fwnode_endpoint tx;
 	/* remote source */
 	struct v4l2_async_notifier notifier;
-- 
2.25.1

