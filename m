Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92B188043C2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 02:07:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbjLEBHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 20:07:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234709AbjLEBHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 20:07:10 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54FEB18F
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 17:06:38 -0800 (PST)
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20231205010634epoutp029a0b64038d68a018ab346119de334868~dyg2ykAbt1425614256epoutp02r
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 01:06:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20231205010634epoutp029a0b64038d68a018ab346119de334868~dyg2ykAbt1425614256epoutp02r
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1701738394;
        bh=POPorlO8ox1B9KkL93UjQX3CeDFZLgj4/lqlMbYaPvw=;
        h=From:To:Cc:Subject:Date:References:From;
        b=K420MGSCRtnsDWYWaiJNb01OFwV2y1a7L7c5wwwHPpeV94Wo/7xkO5qxm2CUVzS2z
         jMxpwcVP4tEYgxiq1FXt4xOb1pkA9MiJoQiP8EkQSN/6wKGrXkAL7LCdfbIvs1pFlQ
         Q6MLDIli4gtyVTOXzF4BlvVngVz9iakZFJz/Z+YM=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20231205010633epcas1p2c5e470bc14352ff0627d0929501a76db~dyg1pVZsc0462904629epcas1p2W;
        Tue,  5 Dec 2023 01:06:33 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.38.235]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4Skj6J1c4Fz4x9Py; Tue,  5 Dec
        2023 01:06:32 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        7F.BC.09739.8977E656; Tue,  5 Dec 2023 10:06:32 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20231205010631epcas1p48036e1b3f087f23807f69cc9c465cb07~dyg0cI3340091300913epcas1p4P;
        Tue,  5 Dec 2023 01:06:31 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20231205010631epsmtrp260423cdde09a025d30067f8d581ecd87~dyg0bjIGk2134921349epsmtrp2l;
        Tue,  5 Dec 2023 01:06:31 +0000 (GMT)
X-AuditID: b6c32a37-c0bff7000000260b-7d-656e77980297
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
        55.04.18939.7977E656; Tue,  5 Dec 2023 10:06:31 +0900 (KST)
Received: from cw00choi03 (unknown [10.113.111.106]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20231205010631epsmtip2c08e08c3b706798158a53954b9b5d080~dyg0OgtMv1430114301epsmtip2c;
        Tue,  5 Dec 2023 01:06:31 +0000 (GMT)
From:   "Chanwoo Choi" <cw00.choi@samsung.com>
To:     <linux-kernel@vger.kernel.org>
Cc:     "'Lukas Funke'" <lukas.funke-oss@weidmueller.com>,
        "'Signed-off-by: Chanwoo Choi'" <cw00.choi@samsung.com>,
        "'Chanwoo Choi'" <chanwoo@kernel.org>,
        "'MyungJoo Ham'" <myungjoo.ham@samsung.com>,
        "'Reported-by: kernel test robot'" <lkp@intel.com>
Subject: [PATCH v3] extcon: usbc-tusb320: Set interrupt polarity based on
 device-tree
Date:   Tue, 5 Dec 2023 10:06:31 +0900
Message-ID: <02a701da2717$48abf150$da03d3f0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdonFwr/WpDgEBW/QA+m3glVNgYOdQ==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCJsWRmVeSWpSXmKPExsWy7bCmvu6M8rxUgyO9nBYTb1xhsbj+5Tmr
        xeVdc9gsXjU/YrPY/uk2q8XtxhVsDmwei/e8ZPLYtKqTzaNvyypGj8+b5Dy2rFrEFsAalW2T
        kZqYklqkkJqXnJ+SmZduq+QdHO8cb2pmYKhraGlhrqSQl5ibaqvk4hOg65aZA3SBkkJZYk4p
        UCggsbhYSd/Opii/tCRVISO/uMRWKbUgJafAtECvODG3uDQvXS8vtcTK0MDAyBSoMCE7Y9LJ
        dcwFd/gqlr3aw9TAuIWni5GTQ0LARGLtwhaWLkYuDiGBHYwSSyeehnI+MUr0Nn5mhnM2/7/L
        BNPS/3cBG0RiJ6PErFdHoZyXjBJTF7SxdjFycLAJ6Egs+BEK0iAioCTx/Vo3I0gNs8AfRonp
        054wgiSEBcIlzhzbyQpiswioSExduRUszitgKXHoXSszhC0ocXLmExYQm1lAXmL72znMEFco
        SPx8uowVYoGexMl1V5ggakQkZne2gZ0tIfCVXeL5jiaoBheJpcvXsEPYwhKvjm+BsqUkPr/b
        ywbRMJlR4uLr11Dd6xklNq5sgeo2lti/dDITyGvMApoS63fpQ4QVJXb+nssIsZlP4t3XHrDv
        JQR4JTrahCBKlCUuP4AFnaTE4vZONogSD4nvb2UmMCrOQvLmLCRvzkLyziyEvQsYWVYxiqUW
        FOempxYbFhjDozs5P3cTIzh5apnvYJz29oPeIUYmDsZDjBIczEoivPNuZacK8aYkVlalFuXH
        F5XmpBYfYjQFBvxEZinR5Hxg+s4riTc0sTQwMTMyNrEwNDNUEue99aw3RUggPbEkNTs1tSC1
        CKaPiYNTqoHJI/7BmiNbK22v3JPr/fafvd6//MW+4xcX7jrcriNv1xw2h7fVd+YPrZle/4Im
        vJwZa9zaLLZh+4R1Hxgn9v5b/9L3Xc3O09GfwjUSl1+X017HayRU9Op3/46vy/KsJ/pv7lZ+
        +ff5QeGGhDhPyycqZh7S23fcCToXvSVAK8Vpr9uCG3mL6r5HbmCTfOw4za5/lnJgdytf95t1
        IqnL1ykf2PpxUuvVhblebRec1bdVsZrsca/7mj1t1z/FbR1Nvbnvjr2ebLNK0ZvrZs6nzqhX
        LEuWPCqVVCx/l73qQdzMeZFzRSbuE5LoOHVWole2K/xUkD7jtnvb5XrCr18/1LOgrrF8vcK1
        IPMIzXs2vmw9SizFGYmGWsxFxYkAYTwSpScEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPLMWRmVeSWpSXmKPExsWy7bCSvO708rxUgw+9+hYTb1xhsbj+5Tmr
        xeVdc9gsXjU/YrPY/uk2q8XtxhVsDmwei/e8ZPLYtKqTzaNvyypGj8+b5Dy2rFrEFsAaxWWT
        kpqTWZZapG+XwJUx6eQ65oI7fBXLXu1hamDcwtPFyMkhIWAi0f93AVsXIxeHkMB2RonvczvY
        IBKSEtMuHmXuYuQAsoUlDh8uhqh5zihx+PEsdpA4m4COxIIfoSDlIgJKEt+vdTOC1DAL/GOU
        ePzoIjtIQlggVKJ14TewmSwCKhJTV25lBLF5BSwlDr1rZYawBSVOznzCAjKTWUBPom0jWAmz
        gLzE9rdzmCHOUZD4+XQZK8QuPYmT664wQdSISMzubGOewCg4C8mkWQiTZiGZNAtJxwJGllWM
        oqkFxbnpuckFhnrFibnFpXnpesn5uZsYwXGgFbSDcdn6v3qHGJk4GA8xSnAwK4nwzruVnSrE
        m5JYWZValB9fVJqTWnyIUZqDRUmcVzmnM0VIID2xJDU7NbUgtQgmy8TBKdXANFPAu/ba4aPT
        skvW3nukaLj8t26GyqGd/HmCLCdS5DhnX9aKlMs2uLC0ns3RfXfFVsY/py/HP3pq7/xRSSr5
        AHsCO1uL0RLuNy2vXM73LxGTY5meGXa/NkhkfscJucoU/qurkqwvWGZwNn1+yvS9ZOYiM8ES
        VXavdXwm/c/f1H5P6GDiz8uZKvdh/fOvzlc2LeJt+XTsWJ94IYPux8wUiz+5i+vkZ2a2Kaqn
        qWofW+fQ68eVcOL7VJX759pfqPytsLH3yeDZ/d3w+vqzH3ntwpyvfX/64ihvlG+m9Oo47pz3
        rqIdCxco3T+cZnR7puX9s1Y/p6gcMVrsa7Rl7hLOKx53J/2WqBZc8Plt4ycLJZbijERDLeai
        4kQA89fjNvICAAA=
X-CMS-MailID: 20231205010631epcas1p48036e1b3f087f23807f69cc9c465cb07
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231205010631epcas1p48036e1b3f087f23807f69cc9c465cb07
References: <CGME20231205010631epcas1p48036e1b3f087f23807f69cc9c465cb07@epcas1p4.samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove 'IRQF_TRIGGER_FALLING' request which is not allowed on
every interrupt controller (i.e. arm64 GIC). Replace flag by a
request that depends on the actual device-tree setting.

Reported-by: kernel test robot <lkp@intel.com>
Closes:
https://lore.kernel.org/oe-kbuild-all/202311221355.yxYpTIw3-lkp@intel.com/
Signed-off-by: Lukas Funke <lukas.funke@weidmueller.com>
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
Changes from v2
- Use IRQF_TRIGGER_FALLING if there are no irq_data on devicetree

 drivers/extcon/extcon-usbc-tusb320.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/extcon/extcon-usbc-tusb320.c
b/drivers/extcon/extcon-usbc-tusb320.c
index 4d08c2123e59..2eab341de6b7 100644
--- a/drivers/extcon/extcon-usbc-tusb320.c
+++ b/drivers/extcon/extcon-usbc-tusb320.c
@@ -17,6 +17,7 @@
 #include <linux/usb/typec.h>
 #include <linux/usb/typec_altmode.h>
 #include <linux/usb/role.h>
+#include <linux/irq.h>
 
 #define TUSB320_REG8				0x8
 #define TUSB320_REG8_CURRENT_MODE_ADVERTISE	GENMASK(7, 6)
@@ -515,6 +516,8 @@ static int tusb320_probe(struct i2c_client *client)
 	const void *match_data;
 	unsigned int revision;
 	int ret;
+	u32 irq_trigger_type = IRQF_TRIGGER_FALLING;
+	struct irq_data *irq_d;
 
 	priv = devm_kzalloc(&client->dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -568,9 +571,13 @@ static int tusb320_probe(struct i2c_client *client)
 		 */
 		tusb320_state_update_handler(priv, true);
 
+	irq_d = irq_get_irq_data(client->irq);
+	if (irq_d)
+		irq_trigger_type = irqd_get_trigger_type(irq_d);
+
 	ret = devm_request_threaded_irq(priv->dev, client->irq, NULL,
 					tusb320_irq_handler,
-					IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
+					IRQF_ONESHOT | irq_trigger_type,
 					client->name, priv);
 	if (ret)
 		tusb320_typec_remove(priv);
-- 
2.25.1

