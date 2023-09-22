Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBEF37AB0FC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 13:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233654AbjIVLef (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 07:34:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233903AbjIVLeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 07:34:16 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6644E54
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 04:33:37 -0700 (PDT)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230922113336epoutp02fedfe99623e14954128839fe59ab28a2~HNVMyLJVY2315623156epoutp02D
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 11:33:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230922113336epoutp02fedfe99623e14954128839fe59ab28a2~HNVMyLJVY2315623156epoutp02D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1695382416;
        bh=+UhfCjXK8/o7d2+XGpZvE8LX9JeG+bIOltN8rWnv/DQ=;
        h=From:To:Cc:Subject:Date:References:From;
        b=EQA3g2Eb5Z93RBKLubfyvyyalRQShwbaf+m7ifSGKy8z+VRPBF/9PcmuuvBPUVMeH
         vNjTuKnwN30RUbxxXTV+2AuhmpxTnbMyi4k+GnOucX1uF3BH/hAfZopIvBs1yM3dhe
         84OubQhvYYwFvsI2FIDTazrlqWGgw8QZfGgD5Lcc=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20230922113334epcas2p26564c634066561820b62293de853fa80~HNVLbX3iO2731327313epcas2p2g;
        Fri, 22 Sep 2023 11:33:34 +0000 (GMT)
Received: from epsmgec2p1-new.samsung.com (unknown [182.195.36.101]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4RsVWy1D2rz4x9Pt; Fri, 22 Sep
        2023 11:33:34 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmgec2p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
        B4.21.19471.D8B7D056; Fri, 22 Sep 2023 20:33:33 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
        20230922113333epcas2p293a8ed8218f7ed49feb97c737460aa6f~HNVKcin5P2731327313epcas2p2e;
        Fri, 22 Sep 2023 11:33:33 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230922113333epsmtrp284a57c3fe0bf03ac3359b37cca1eb782~HNVKbo3nF3046930469epsmtrp2G;
        Fri, 22 Sep 2023 11:33:33 +0000 (GMT)
X-AuditID: b6c32a4d-dc5ff70000004c0f-f6-650d7b8dc277
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
        EB.08.18916.D8B7D056; Fri, 22 Sep 2023 20:33:33 +0900 (KST)
Received: from jtpark-7920.dsn.sec.samsung.com (unknown [10.229.83.56]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230922113333epsmtip15dff9f0bebc86cd54457c10bec5cf4b2~HNVKJhJyD0328503285epsmtip1k;
        Fri, 22 Sep 2023 11:33:33 +0000 (GMT)
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
Subject: [PATCH v2 5/7] cxl: Fix block comment style
Date:   Fri, 22 Sep 2023 20:36:15 +0900
Message-Id: <20230922113615.3300815-1-jtp.park@samsung.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKJsWRmVeSWpSXmKPExsWy7bCmmW5fNW+qwY9ki7uPL7BZNE9ezGgx
        feoFRosTNxvZLFbfXMNo0bT6LqtF8+L1bBYf3vxjsTjwuoHd4szZl6wWqxZeY7M4svYqk8Xi
        ozOYLY7u4bA4P+sUi8XlXXPYLG5NOMZksfH+OzYHIY+ds+6ye7QcecvqsXjPSyaPTas62Tz2
        z13D7tG3ZRWjx9TZ9R6fN8kFcERl22SkJqakFimk5iXnp2TmpdsqeQfHO8ebmhkY6hpaWpgr
        KeQl5qbaKrn4BOi6ZeYAfaKkUJaYUwoUCkgsLlbSt7Mpyi8tSVXIyC8usVVKLUjJKTAv0CtO
        zC0uzUvXy0stsTI0MDAyBSpMyM44c1m54DhrRc/+e0wNjMdZuhg5OSQETCTuN88Dsrk4hAT2
        MEr8WdDKDJIQEvjEKLFoeTREAsh+NfsOI0xH3/E57BBFOxklHk1Nhyj6wyjx+Oc6JpAEm4CW
        xPSZDawgCRGBh0wSO1/1MYE4zAKPmCQ+nngFtkMYaNTpN7fBxrIIqEpsXHmRFcTmFbCW2Lt+
        FRvEOnmJ/QfPMkPEBSVOznwCdjgzULx562xmiJq1HBLru2S6GDmAbBeJHZOqIMLCEq+Ob2GH
        sKUkPr/bywZyg4RAM6PE6+dXWCCcFkaJdbd3QFUZS7y7+ZwVZBCzgKbE+l36EDOVJY7cglrL
        J9Fx+C87RJhXoqNNCKJRSWLe0nlQ10hIXJq7Bcr2kFiwbCELJLBiJVYumc4ygVF+FpJnZiF5
        ZhbC3gWMzKsYpVILinPTU5ONCgx181LL4fGanJ+7iRGcnrV8dzC+Xv9X7xAjEwfjIUYJDmYl
        Ed7kT1ypQrwpiZVVqUX58UWlOanFhxhNgUE8kVlKNDkfmCHySuINTSwNTMzMDM2NTA3MlcR5
        77XOTRESSE8sSc1OTS1ILYLpY+LglGpgEs1VOXzJtLDtb1S2M3+lza8Tz82OPpx7JWXyV7Nb
        whoXRN/fP5hz+t8lpxkqf6tib3l8m/mQ02rWhHVcDw4xhE07lP/Ryu/8z8qcu3revMqPDk8P
        37trntIVn18HNf5J7mPa8Ez4k7aXcuOB7d4P8pW23Y7+Htqf9ZfjOd+nkG+xspstLsX8kcxw
        a7JqPyGl1BnRtjhs39GHZ1kfvEuVuPpW6mHilOBZi2vn//11+l7olP53ItvT7Pp6ju9qXNZz
        4eXx//oHTh3KKPq9dxWLvX3jx0MtIurX+a/YTvW8zNlUsPHa9vWTudSYy2Iqzl974nT1kYx1
        09aM1wenSprOr/i8KLjh1O/e1pcuj1rn9ososRRnJBpqMRcVJwIAR8Rtl1gEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPLMWRmVeSWpSXmKPExsWy7bCSnG5vNW+qwbxZChZ3H19gs2ievJjR
        YvrUC4wWJ242slmsvrmG0aJp9V1Wi+bF69ksPrz5x2Jx4HUDu8WZsy9ZLVYtvMZmcWTtVSaL
        xUdnMFsc3cNhcX7WKRaLy7vmsFncmnCMyWLj/XdsDkIeO2fdZfdoOfKW1WPxnpdMHptWdbJ5
        7J+7ht2jb8sqRo+ps+s9Pm+SC+CI4rJJSc3JLEst0rdL4Mo4c1m54DhrRc/+e0wNjMdZuhg5
        OSQETCT6js9h72Lk4hAS2M4oMXd2GxNEQkJi+YYXULawxP2WI6wgtpDAL0aJhRN4QGw2AS2J
        6TMbWEGaRQSeM0mcfHOKEcRhFnjFJNH7/zozSJUw0IrTb24zgtgsAqoSG1deBJvEK2AtsXf9
        KjaIDfIS+w+eZYaIC0qcnPkE7DxmoHjz1tnMExj5ZiFJzUKSWsDItIpRNLWgODc9N7nAUK84
        Mbe4NC9dLzk/dxMjOE60gnYwLlv/V+8QIxMH4yFGCQ5mJRHe5E9cqUK8KYmVValF+fFFpTmp
        xYcYpTlYlMR5lXM6U4QE0hNLUrNTUwtSi2CyTBycUg1MywTklHdK8yWXBzI3F89uCZmguMFe
        7ZVC3zH5lq6fzTpr0kSra3Q9GCdvaLqunKsicN4rLZoxr6k8SXP1/e3fOR1rv+537l5RcLPi
        o92vVAfNwlNar53Ot8iIrDr59CnfTP08L1/1pUUivzoS+u9cWXOWx2rL62r+6XU+j6Vdvhj4
        zjn7+sFLdtdHfhsK5K6uMjAoz7jeV1H+/OARsc0fe0KFU8t6H885XPN/yZlpSUp9y4wZPH4V
        7bnYbv+5VrNzFqv4AQb+6xMPdjct+DfZ6v2JjD2Xn/s0seg9PLf/jVHbN81HNU5pUo+Cv+Yx
        iciumO6xcJmk5rITantfhJjf7It0YeGLF5soJKJW6q/EUpyRaKjFXFScCAAzBSYHAgMAAA==
X-CMS-MailID: 20230922113333epcas2p293a8ed8218f7ed49feb97c737460aa6f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230922113333epcas2p293a8ed8218f7ed49feb97c737460aa6f
References: <CGME20230922113333epcas2p293a8ed8218f7ed49feb97c737460aa6f@epcas2p2.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WARNING: Block comments should align the * on each line

Signed-off-by: Jeongtae Park <jtp.park@samsung.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/cxl.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 545381355efb..0bbe0c15bfa9 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -334,7 +334,7 @@ enum cxl_decoder_type {
  * @flags: memory type capabilities and locking
  * @commit: device/decoder-type specific callback to commit settings to hw
  * @reset: device/decoder-type specific callback to reset hw settings
-*/
+ */
 struct cxl_decoder {
 	struct device dev;
 	int id;
-- 
2.34.1

