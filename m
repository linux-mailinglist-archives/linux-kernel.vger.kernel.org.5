Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E976878C707
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 16:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234666AbjH2ONR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 10:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236883AbjH2OMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 10:12:52 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC69A1BC;
        Tue, 29 Aug 2023 07:12:48 -0700 (PDT)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37TC82RY021636;
        Tue, 29 Aug 2023 15:40:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        selector1; bh=lxhEdzurpdkE9C1wxBVksd7Z8O/aa/66F4a3dEvFca0=; b=Al
        N1ipsgL8FqTCsJkQ6mW+WhqF1XjKDp5Ju+0RwDsM+/UflBpvBMd0IWaR9feRfDaQ
        rMyLFr03BLwIE9Nbhuyg3YAhJeJSDXnnPXOXkWvcVwB5zbWT5sfzF2RSvhbh9TfH
        ejh1JoSbkY09zszxliUsvKdzmsWLEE0D9hRdbSPMIQmpC6PDJcEbP8sRSa5yakNE
        9Np7J6ss5dv3iJfcDI7BMVg/V6LXsPRA7s9MnertKAKN0Nn7Vd8suW09MA0CLeUg
        koaLkPIrJhIVmprP3U47maFfJJXX2eXKjH89suWdawRWLF3y/bHa33+8SPyapd3l
        GXFDvNmLFuHWzg2ZMVoA==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3sq6h44p22-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Aug 2023 15:40:59 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A5ADE100057;
        Tue, 29 Aug 2023 15:40:58 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 9F04E2207DB;
        Tue, 29 Aug 2023 15:40:58 +0200 (CEST)
Received: from localhost (10.201.22.39) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Tue, 29 Aug
 2023 15:40:55 +0200
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
To:     <william.gray@linaro.org>, <lee@kernel.org>
CC:     <alexandre.torgue@foss.st.com>, <fabrice.gasnier@foss.st.com>,
        <linux-iio@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/8] counter: chrdev: remove a typo in header file comment
Date:   Tue, 29 Aug 2023 15:40:23 +0200
Message-ID: <20230829134029.2402868-3-fabrice.gasnier@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230829134029.2402868-1-fabrice.gasnier@foss.st.com>
References: <20230829134029.2402868-1-fabrice.gasnier@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.201.22.39]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-29_10,2023-08-29_01,2023-05-22_02
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace COUNTER_COUNT_SCOPE that doesn't exist by the defined
COUNTER_SCOPE_COUNT.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
 include/uapi/linux/counter.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/counter.h b/include/uapi/linux/counter.h
index fc248ef00e86..008a691c254b 100644
--- a/include/uapi/linux/counter.h
+++ b/include/uapi/linux/counter.h
@@ -38,7 +38,7 @@ enum counter_scope {
  *
  * For example, if the Count 2 ceiling extension of Counter device 4 is desired,
  * set type equal to COUNTER_COMPONENT_EXTENSION, scope equal to
- * COUNTER_COUNT_SCOPE, parent equal to 2, and id equal to the value provided by
+ * COUNTER_SCOPE_COUNT, parent equal to 2, and id equal to the value provided by
  * the respective /sys/bus/counter/devices/counter4/count2/ceiling_component_id
  * sysfs attribute.
  */
-- 
2.25.1

