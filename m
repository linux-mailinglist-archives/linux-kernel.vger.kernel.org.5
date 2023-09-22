Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB1E7AB3DB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 16:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbjIVOkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 10:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbjIVOkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 10:40:10 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 528CD180;
        Fri, 22 Sep 2023 07:40:04 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38M9tQIl013784;
        Fri, 22 Sep 2023 16:39:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        selector1; bh=su2Pq6yXzJ+By01elmOLMUH+D+u4lMRIHEYBe4cjT9E=; b=o+
        x9kkY4xmDnZK0M+vArZ/C7/UaIDIv6hBxmfSdyH0GqKendyl1sjq3u6G8zbVIVgv
        BfMGmFF/mZodJ5RFcp1uez6UM8vz6K2DUPWlo9Utj/jXoTuw6ESKyHmkVbM61Roy
        dVB9PyM2qp7sLQnJ5mm6h6gcsQ02vNpBShHrqA8i0RSB3nQXineZws3QVrOyYMn6
        Zlx6gvcGNpWZoOph8mG4Q57YZKuPndGhC89UWHHETcKjSov5DfTqv3fruKCpDPNp
        GecWZBrevIp6kM/fYgX67ESevH3ugvAW7lg8JVLBomnTPfJ8JeKK1nNnIFHU20c2
        g5KQ6DTSJFHogzZ8n4bw==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3t8tt7kvsx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Sep 2023 16:39:45 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 79C07100051;
        Fri, 22 Sep 2023 16:39:45 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 7117C235F24;
        Fri, 22 Sep 2023 16:39:45 +0200 (CEST)
Received: from localhost (10.252.14.82) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 22 Sep
 2023 16:39:45 +0200
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
To:     <william.gray@linaro.org>
CC:     <lee@kernel.org>, <alexandre.torgue@foss.st.com>,
        <fabrice.gasnier@foss.st.com>, <linux-iio@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 3/6] counter: stm32-timer-cnt: rename counter
Date:   Fri, 22 Sep 2023 16:39:17 +0200
Message-ID: <20230922143920.3144249-4-fabrice.gasnier@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230922143920.3144249-1-fabrice.gasnier@foss.st.com>
References: <20230922143920.3144249-1-fabrice.gasnier@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.252.14.82]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-22_13,2023-09-21_01,2023-05-22_02
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The STM32 timer may count on various sources or channels. The counter
isn't specifically counting on channe1 1. So rename it to avoid a
confusion.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
 drivers/counter/stm32-timer-cnt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/counter/stm32-timer-cnt.c b/drivers/counter/stm32-timer-cnt.c
index 36d812ddf162..668e9d1061d3 100644
--- a/drivers/counter/stm32-timer-cnt.c
+++ b/drivers/counter/stm32-timer-cnt.c
@@ -302,7 +302,7 @@ static struct counter_synapse stm32_count_synapses[] = {
 
 static struct counter_count stm32_counts = {
 	.id = 0,
-	.name = "Channel 1 Count",
+	.name = "STM32 Timer Counter",
 	.functions_list = stm32_count_functions,
 	.num_functions = ARRAY_SIZE(stm32_count_functions),
 	.synapses = stm32_count_synapses,
-- 
2.25.1

