Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D37FD7C0310
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 19:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343519AbjJJRzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 13:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234135AbjJJRze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 13:55:34 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F35FBC4;
        Tue, 10 Oct 2023 10:55:31 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39AHtRjc118937;
        Tue, 10 Oct 2023 12:55:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1696960527;
        bh=fww2WBA0WYCQZxjeYF1kKySLXKrrRNFd6Q4wyHa8v6w=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=xGi/E810GrNr8q4GZTHRk5QFCJiitStQqx91WAkRBffir7wOyqcPb9a240HxNHC5D
         rFay8NioS0F78LRg8zR3kd5ubTz0WY/a4XCcwR5tiRyTE+PDdRPOYVge2t/zHXVslz
         rc5UiuQJz7IcDcSdkwBChqrQr2fTgGWTm3jXsNT0=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39AHtRSM097595
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 10 Oct 2023 12:55:27 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 10
 Oct 2023 12:55:26 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 10 Oct 2023 12:55:26 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39AHtQDR035433;
        Tue, 10 Oct 2023 12:55:26 -0500
From:   Bryan Brattlof <bb@ti.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
CC:     Vibhore Vardhan <vibhore@ti.com>, Dhruva Gole <d-gole@ti.com>,
        ARM Power Management <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bryan Brattlof <bb@ti.com>
Subject: [PATCH 1/2] cpufreq: dt-platdev: add am62p5 to blocklist
Date:   Tue, 10 Oct 2023 12:55:26 -0500
Message-ID: <20231010175524.558577-5-bb@ti.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231010175524.558577-4-bb@ti.com>
References: <20231010175524.558577-4-bb@ti.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=831; i=bb@ti.com; h=from:subject; bh=090NOy0/xtCeKibfJjv+Of8moUo2GTi6sbjdGFt1oN8=; b=owNCWmg5MUFZJlNZi/K8iQAAb3////frZ797r+alv/1PX7r3/zN6/31L7vc7/f/rnbvSuN+wA RsssdANDTRoBkaA0DQBiMQ0ADQBiaaAA0ZAaGgAPUaAGjTRoA0NMNT0JozRND1BkmQZADCD1DRk DJpoANDRoGmQDTQDQaNBkAaNqAHqMg0MgaGmgGR6mhkDRpoGhiR6mQwjQA9JoNDQNNAGQaA9RoB oAHqBoPUANGjQ0NAAAaAAGgNNGgyaNonqBBGys+VJjBAGFZazM6iXAP+74PBlscYUUMhmXgIHPe bV/mTQDRks9AO4ksMfQbTDUSWF7CuCcBTYrwQuX1NOzKmgotqVkPlwpAxgE7P+hmCGwz70AT99d 3Kmw64SYx+kNLvN0KtHzX0ZdbmoisUQQHE4gAs1atSMgVzWqSBVEuJGo2+CN2FSVztIuw6vcka7 tTBpMvBKF7vYCVEmWnr7q+aUk/CWDqRJMbysBdDpSs1qIRcebhGi6QWva8UvcMLZq0ShAnxTFF1 TOMdZg996gEeYKjReKuWp37UTMsH3Vzdepc5nJkGRHOaldE0ZUAnREHkftMt/nVvoF0LtUBI37G QTUPp/fxsG2uBoDMAMO89TY7GcBYHpdgC/NQ2L1KqnWIKA/g/84W1GfMoCEcKPULcohzTCNLHga uJAL3QtR1YqzFFOQc/4u5IpwoSEX5XkSA==
X-Developer-Key: i=bb@ti.com; a=openpgp; fpr=D3D177E40A38DF4D1853FEEF41B90D5D71D56CE0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The am62p5 family of SoCs is a variation of the am625 and am62a7 SoC
family. Add this device along with the devices which will use the
operating-points-v2 property.

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index 2016d47889c07..0b3776f558dbd 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -178,6 +178,7 @@ static const struct of_device_id blocklist[] __initconst = {
 	{ .compatible = "ti,omap3", },
 	{ .compatible = "ti,am625", },
 	{ .compatible = "ti,am62a7", },
+	{ .compatible = "ti,am62p5", },
 
 	{ .compatible = "qcom,ipq8064", },
 	{ .compatible = "qcom,apq8064", },
-- 
2.42.0

