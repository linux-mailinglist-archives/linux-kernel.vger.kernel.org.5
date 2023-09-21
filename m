Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E8F37A910F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 04:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbjIUCs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 22:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjIUCss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 22:48:48 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 935DDF9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 19:48:36 -0700 (PDT)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230921024833epoutp03387372ba70dfeb9170073e98c201d9ee~Gyhfw2ZWu0938609386epoutp03D
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 02:48:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230921024833epoutp03387372ba70dfeb9170073e98c201d9ee~Gyhfw2ZWu0938609386epoutp03D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1695264513;
        bh=O7iNbdID8iQ/79Odq72V5fkfmbULRg3yswt3BqBV67A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PRIA2/AP3T6N80J5LN7LXH8C/TsxIXw78wGU6gudy3wxfixEXY293DFgVFXdjY3rN
         +Uo4++XVOukenHxCSRcnxrO4mVD/8mWtN/rq/sEBQq3k43yWQTxz3kD2jh9pNm4c6R
         mwQNI0nz2JsbnBMPG/8ojQGEz9QubBedtguDKVZc=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20230921024833epcas2p3c088dad075c4b11c78b3dd659957c711~GyhfHMFYM2379423794epcas2p32;
        Thu, 21 Sep 2023 02:48:33 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.101]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4Rrfwc6Lt6z4x9Pw; Thu, 21 Sep
        2023 02:48:32 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        EB.AA.09765.00FAB056; Thu, 21 Sep 2023 11:48:32 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
        20230921024832epcas2p24325cdfdb6fbbcf489ea3d442258e86b~GyheTJvh20272002720epcas2p2k;
        Thu, 21 Sep 2023 02:48:32 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230921024832epsmtrp1693063717ad5492107522f5462faa634~GyheSQxo40473204732epsmtrp1H;
        Thu, 21 Sep 2023 02:48:32 +0000 (GMT)
X-AuditID: b6c32a48-40fff70000002625-99-650baf007af8
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        28.53.08649.00FAB056; Thu, 21 Sep 2023 11:48:32 +0900 (KST)
Received: from jtpark-7920.dsn.sec.samsung.com (unknown [10.229.83.56]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230921024832epsmtip2bb3229c3336ebab7ff45cf4d4bf3755f~GyheD7LqE1639116391epsmtip2N;
        Thu, 21 Sep 2023 02:48:32 +0000 (GMT)
From:   Jeongtae Park <jtp.park@samsung.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Fan Ni <fan.ni@samsung.com>, linux-cxl@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kyungsan Kim <ks0204.kim@samsung.com>,
        Wonjae Lee <wj28.lee@samsung.com>,
        Hojin Nam <hj96.nam@samsung.com>,
        Junhyeok Im <junhyeok.im@samsung.com>,
        Jehoon Park <jehoon.park@samsung.com>,
        Jeongtae Park <jeongtae.park@gmail.com>,
        Jeongtae Park <jtp.park@samsung.com>
Subject: [PATCH 6/7] cxl/memdev: Fix whitespace error/warnings
Date:   Thu, 21 Sep 2023 11:51:09 +0900
Message-Id: <20230921025110.3717583-7-jtp.park@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230921025110.3717583-1-jtp.park@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01TbUxTVxjm9La3F0jdtbJxUvlo7oITEvqBLVwHGCPG3UXmUOKWmCBr6B1l
        lLbrLZtsizK+hmRDmGMiWFbSLYbKZ1cNYBGBIkxwEAoqms6xORCwUCFu/hjLSls3/z3veZ8n
        z/u85xwM4TtRAZanMdB6jUJNoCHsK0Ox8vigjlBa8qxLQrp+n0TJ0rNmQJ6rmwTk6OznKHlp
        thWQJZdcHLLU3IGSnsf/sMnry8VccvzWIoe0NN9GSUfbDIs0D9cj5LAdIycabrJJZ+8FlLxX
        c4NFdj1YQffyqZ4GF5cqc7g5lNm+yKKsltMo1W9s5VLVNgug6hpPUevWqAzsWH6KilYoab2Q
        1uRolXma3FTiYGZ2WrY8USKNl+4mkwihRlFApxL70zPiD+SpvVEI4UcKdaH3KEPBMIR4T4pe
        W2ighSotY0glaJ1SrUvSiRhFAVOoyRVpaMPrUokkQe4lvpev2qhaQnR3gk9cvHydWwxWuVUg
        GIO4DPabVlhVIATj490A3p4uA/5iDcDa8Wscf/EngO1/PGI/l5QbVwKNPgBbqlp9DT7+N4CO
        qYhNjOJx8Nz5Yh8pDJ9jwZ6lap8Jgv/Ggk9Gl5BN1jZ8D5y0T7I2MRuPgRb3gA/z8GTo+tLN
        8dtFw/6BWz5+MJ4Cf340FeBshT+df+hzRryc0suNyKYBxMcx6OppQfzi/bCi/2vgx9vg0ogt
        EFsAF89UcP2CUgCXF6bZ/qLMm/R+d4C1C67MLnjHwLwWsbCjV7wJIf4qdNwLGG+BlUMbXP8x
        D1ZW8P1CAjb90BQYAcIpoy2AKTj81yriX90ZAHsulnNrgLDhhTwNL+Rp+N/YBBALeIXWMQW5
        NJOgk/13yTnaAivwve44qhs0uj2iQcDCwCCAGEKE8XLWQmg+T6ko+oTWa7P1hWqaGQRy77Zr
        EcHLOVrv99AYsqWy3RJZYqI0KUEuSSLCeb+UG5V8PFdhoPNpWkfrn+tYWLCgmFWVLso5snNE
        HOms67S3DCdX1gy8GZcWu6PoNBxbX1mQhw8VmRZ2CpxjMar5Q3eOW21HiXXKrKsfalauTpTs
        SiZuItcMpZGuj+cPNFFXn+rEUzalPOxT08GrJrH5Jc3c3ba3YxxR4aKJ7U+ygqyhbV0l7Z7t
        xNkT6VlLxw4fibZH/Pj9vMWzw7zsqP5iOWGm74Hns0FhtHSfat+G4LuEu6Hv0In1x2tmUjux
        ZFWv8SkYOPxY1hz2RnLBt4lpab+67e9vMUaNGYRTAyc7ma+YDlBYPqfm9Tg9NyKm56nM9lrx
        0RFnVh/61sNvMteenRzNC936oRoGvXb/gyuRp5i9ne8SbEalkMYhekbxL6s0SwhmBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplkeLIzCtJLcpLzFFi42LZdlhJXpdhPXeqwaqdAhZ3H19gs2ievJjR
        YvrUC4wWJ242slmsvrmG0aJp9V1Wi+bF69ksPrz5x2Jx4HUDu8WZsy9ZLVYtvMZmcWTtVSaL
        xUdnMFsc3cNhcX7WKRaLy7vmsFncmnCMyWLj/XdsDkIeO2fdZfdoOfKW1WPxnpdMHptWdbJ5
        7J+7ht2jb8sqRo+ps+s9Pm+SC+CI4rJJSc3JLEst0rdL4Mr42/WKueA6Z8XyrQfYGxjfs3cx
        cnJICJhItM59x9rFyMUhJLCbUeLd7FnMEAkJieUbXjBB2MIS91uOQBX9YpSY3TqbFSTBJqAl
        MX1mA1hCROA5k8TJN6cYQRxmgVdMEr3/r4ONEhawk7iw5wLYKBYBVYlVbw+C2bwC1hJ3e96y
        QqyQl9h/8CxYPaeAjcS5F5fAaoSAapZf2ssGUS8ocXLmExYQmxmovnnrbOYJjAKzkKRmIUkt
        YGRaxSiZWlCcm56bbFhgmJdarlecmFtcmpeul5yfu4kRHGNaGjsY783/p3eIkYmD8RCjBAez
        kghv8ieuVCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8hjNmpwgJpCeWpGanphakFsFkmTg4pRqY
        psqcbrHacL2aoVXhlqJtkrNk1/xTph87P39terWkJHPnrtbTV1ozXb/e/zfpz2E5rU2nVhzK
        NIxt3xclW7urM6Lf7l75Bm+W75ax/P6Tw/icz0zeuTb1fAJT9ef6VcWpkrqxjVa/ZSI2Gyf2
        3tgvlXbj+LnZ9afK52uUVb4vXiZ6iUfWwsrUfP9rl+uHTJ8mC3N76lwWZHEJmfI9VGNNsmLh
        zeqD9T9n6e3VazggmLvuvtKH7WWlDx8nfHl99p5r7o6ObUF1qZIVXxM8+L78FkrLsFvYdz0w
        PeD27v8zbletC7kTGeDE+v/wt/Qo2RfiM7bzV0UpbFlZv2QN578otvDgtR9Xluc1PLE586NL
        iaU4I9FQi7moOBEA2jxDTyADAAA=
X-CMS-MailID: 20230921024832epcas2p24325cdfdb6fbbcf489ea3d442258e86b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230921024832epcas2p24325cdfdb6fbbcf489ea3d442258e86b
References: <20230921025110.3717583-1-jtp.park@samsung.com>
        <CGME20230921024832epcas2p24325cdfdb6fbbcf489ea3d442258e86b@epcas2p2.samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ERROR: code indent should use tabs where possible
WARNING: please, no spaces at the start of a line

Signed-off-by: Jeongtae Park <jtp.park@samsung.com>
---
 drivers/cxl/core/memdev.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index f99e7ec3cc40..ce67df163452 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -935,11 +935,11 @@ static void cxl_fw_cancel(struct fw_upload *fwl)
 }
 
 static const struct fw_upload_ops cxl_memdev_fw_ops = {
-        .prepare = cxl_fw_prepare,
-        .write = cxl_fw_write,
-        .poll_complete = cxl_fw_poll_complete,
-        .cancel = cxl_fw_cancel,
-        .cleanup = cxl_fw_cleanup,
+	.prepare = cxl_fw_prepare,
+	.write = cxl_fw_write,
+	.poll_complete = cxl_fw_poll_complete,
+	.cancel = cxl_fw_cancel,
+	.cleanup = cxl_fw_cleanup,
 };
 
 static void devm_cxl_remove_fw_upload(void *fwl)
@@ -1010,7 +1010,7 @@ static int cxl_memdev_security_init(struct cxl_memdev *cxlmd)
 	}
 
 	return devm_add_action_or_reset(cxlds->dev, put_sanitize, mds);
- }
+}
 
 struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds)
 {
-- 
2.34.1

