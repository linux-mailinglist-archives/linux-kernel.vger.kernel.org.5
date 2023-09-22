Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B01587AB0DA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 13:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233696AbjIVLdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 07:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233802AbjIVLdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 07:33:33 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F4206CCE
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 04:32:50 -0700 (PDT)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230922113249epoutp041703daee17bb893a0033840064d39bf7~HNUhB7yYR0954809548epoutp04Z
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 11:32:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230922113249epoutp041703daee17bb893a0033840064d39bf7~HNUhB7yYR0954809548epoutp04Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1695382369;
        bh=SynehnoUno02KBMksRymC9UvCWKHqA7im0x95Y6rCr0=;
        h=From:To:Cc:Subject:Date:References:From;
        b=TG4s12QkyTZ+8/6ZTeguImJEuoV39J55DTRKvQ+/uEK+ekm5e67yh9tGLMt43+PVQ
         ffFLqgys7XW48yDSlePWrk88oleYTs3FaMx6hNusFBjjxLwPWISSXwam2Q0tgUL0An
         w1B8Ne1dTtCUGT39PerU/Teto02+/U8wY9QuVYFc=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20230922113248epcas2p283061178a4cbacf16abd6962af1acc0c~HNUf9AzOI2731427314epcas2p2R;
        Fri, 22 Sep 2023 11:32:48 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.68]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4RsVW33vmtz4x9Pv; Fri, 22 Sep
        2023 11:32:47 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        C8.02.09660.F5B7D056; Fri, 22 Sep 2023 20:32:47 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
        20230922113247epcas2p1c22bf16ed783e3b4415ab3810758c109~HNUfCT3KN1098010980epcas2p14;
        Fri, 22 Sep 2023 11:32:47 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230922113247epsmtrp113b5ea66da3de7bdf2660499dd62235b~HNUfAMX0-1403814038epsmtrp1H;
        Fri, 22 Sep 2023 11:32:47 +0000 (GMT)
X-AuditID: b6c32a47-d5dfa700000025bc-b1-650d7b5ff80f
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        48.44.08649.E5B7D056; Fri, 22 Sep 2023 20:32:46 +0900 (KST)
Received: from jtpark-7920.dsn.sec.samsung.com (unknown [10.229.83.56]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230922113246epsmtip2226059662e1e77284361ad75fe6ef292~HNUerB65n2200322003epsmtip2u;
        Fri, 22 Sep 2023 11:32:46 +0000 (GMT)
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
Subject: [PATCH v2 3/7] cxl/mem: Fix a checkpatch error
Date:   Fri, 22 Sep 2023 20:35:33 +0900
Message-Id: <20230922113533.3299401-1-jtp.park@samsung.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Ta0xTZxjed057ekCrZ1XsF5JJd8ymNAFaBHpUcKKoDU5lsD8aSG3osSW9
        pi3DXRwwhCjZuKjcBSSdg1SgjDEHDMaGRYGUQaYjQUDDbdIKrMicLkFd24Ob/573ed/nvX4f
        jvLsWCCepjPTRp1cQ2L+rBs3gyUhsk+5tGhmmU9NzoxgVM4lC6DKSkYA1T+WjVHXxxoB9cX1
        STaVY7FhlHvhBYv6+VEWh3IMOdmUtW4Uo+xNvyOUpa8cpfq6cGq4cpBF3em8glH3im4h1LcP
        lrB9PGlH5SRHes6+yJZaupyItNV6AZP2VDdypAVtViAtqcqUrrRuTcBPqqNVtFxBGwW0LlWv
        SNMpY8gjSbIDssgokThEvIuSkAKdXEvHkHHvJ4QcStN4RiEFH8k16R4qQW4ykWF7o436dDMt
        UOlN5hiSNig0Bokh1CTXmtJ1ylAdbd4tFonCIz2Bp9Sqhqf5iGGAfebifAnIAuOsfOCHQyIC
        rl6eYucDf5xHtAN4qXMe9Tp4xGMA6wf1jONvAMv/eAleKW6tjmOMoxvA2uGONcUqgE32FC/G
        CCEsq8jypd1MTCGww1WAeA2UmEbgcr/Lp9hESODVvlFfIyziHehuucz2Yi6xB9rsDWsNBsGe
        X4ZQhn8TDlTM+njUw+d8X4V6k0KiHYeDKz0YI4iDpVXPEQZvgq7bbRwGB0JnYR6HEeQA+Ojh
        XRZjnAOwebx9LWonXBp76GkD95QIhrbOMC+ExDZov7dWeAM8f/M5h6G58HwejxGSsOZaDcpg
        CH+rbkOZECn8tXADs6AUmDdsQ4tAUOVr01S+Nk3l/2WvAtQKttAGk1ZJm8INO/+7aqpe2wp8
        z1l4uB2UL7pDewGCg14AcZTczE197E/zuAr5x5/QRr3MmK6hTb0g0rPfYjQwIFXv+Q86s0wc
        sUsUERUlloRHiiQkn3s/t1rBI5RyM62maQNtfKVDcL/ALETm19noOnxclxh8bGDWObLRVfze
        B7lFK111thvOYl3swqEtcdri+BlZgXqqZWJ1fa+6+8uTb8frkYMBT6uW7j5JXJ+w/4ej1nVb
        y8tTKviqU8afMo/vuTgeu+3ZHNvxxgvhidKDyd8NNe+IHXt3bvFPsnt0/q2ydbf5mtr6uvjo
        l2fjE937rfOpHwZE/MX/fPsBBXsffidLdqQlIzule4D4bEdGkr8yqPTCwt6mbxxx4crIyeyV
        7bkZRadz0YlnzXOOE0kdxBN7QWZ/rrYm44G0sRZOuP5ZdvcVbjw9eP/r4oZrP56d3n3Maah3
        CJKPnpFNt7qSXSWzYcKvsoE9T2iZqK1dJFkmlVwsRI0m+b9vLuWtVwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrKLMWRmVeSWpSXmKPExsWy7bCSvG5cNW+qwbtNxhZ3H19gs2ievJjR
        YvrUC4wWJ242slmsvrmG0aJp9V1Wi+bF69ksPrz5x2Jx4HUDu8WZsy9ZLVYtvMZmcWTtVSaL
        xUdnMFsc3cNhcX7WKRaLy7vmsFncmnCMyWLj/XdsDkIeO2fdZfdoOfKW1WPxnpdMHptWdbJ5
        7J+7ht2jb8sqRo+ps+s9Pm+SC+CI4rJJSc3JLEst0rdL4MpY8b2LqeAka8WkF1MZGxhvs3Qx
        cnJICJhIHPtzm62LkYtDSGA3o8SdCQ2MEAkJieUbXjBB2MIS91uOsEIU/WKU+PFjBVg3m4CW
        xPSZDWAJEYHnTBIn35xiBHGYBV4xSfT+v84MUiUsYC6x4Og1sA4WAVWJDxumsILYvALWEuuP
        rIC6Q15i/8GzzBBxQYmTM5+AxZmB4s1bZzNPYOSbhSQ1C0lqASPTKkbJ1ILi3PTcZMMCw7zU
        cr3ixNzi0rx0veT83E2M4JjR0tjBeG/+P71DjEwcjIcYJTiYlUR4kz9xpQrxpiRWVqUW5ccX
        leakFh9ilOZgURLnNZwxO0VIID2xJDU7NbUgtQgmy8TBKdXAJHv9119pV5OMZ8dVZC6HXrtY
        JHngSb9AquCCJg3rJL/FeeUTAnOP5orW/964KLtv98HOF44yx2+l79p+oNO8MEBys1nTI9/G
        JWJLjKtSPhT0lQsHnLux/pTxIyP7om3Vyg+FJk+098+4VNnjFbJl2l3L7XtkXI/s+399Uaep
        Xu6CtZ+10073abPt8vyxp3XFlVkPp7SGHNQ8+MCD6XLX1C2mnqxyT3fp8d59fv/BzUXHTV6b
        H+WXn/uFf42+z6rAJfe5FBsqt1hsKmPLPrSFZdbMOyfD/vFNdE3yNe9tF9t6aXrWXN9p/LY3
        Ps1MWtA+01Ujye3Ih+dHljK8axbIPazsve11613fO78kus5ayiixFGckGmoxFxUnAgAvFVKE
        CAMAAA==
X-CMS-MailID: 20230922113247epcas2p1c22bf16ed783e3b4415ab3810758c109
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230922113247epcas2p1c22bf16ed783e3b4415ab3810758c109
References: <CGME20230922113247epcas2p1c22bf16ed783e3b4415ab3810758c109@epcas2p1.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ERROR: spaces required around that '=' (ctx:WxV)

Signed-off-by: Jeongtae Park <jtp.park@samsung.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/cxlmem.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 79e99c873ca2..1ac3eb2be84f 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -183,7 +183,7 @@ struct cxl_mbox_cmd_rc {
 };
 
 static const
-struct cxl_mbox_cmd_rc cxl_mbox_cmd_rctable[] ={ CMD_CMD_RC_TABLE };
+struct cxl_mbox_cmd_rc cxl_mbox_cmd_rctable[] = { CMD_CMD_RC_TABLE };
 #undef C
 
 static inline const char *cxl_mbox_cmd_rc2str(struct cxl_mbox_cmd *mbox_cmd)
-- 
2.34.1

