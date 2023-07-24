Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 412E775EE4B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 10:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231879AbjGXItE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 04:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231886AbjGXIs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 04:48:58 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ECDDE52
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 01:48:47 -0700 (PDT)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230724084844epoutp02d649670334fbc6b436c7169b524367cb~0wYIKhr6k2955129551epoutp02G
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 08:48:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230724084844epoutp02d649670334fbc6b436c7169b524367cb~0wYIKhr6k2955129551epoutp02G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1690188524;
        bh=H1GuU3ZOExXEI9JvstAqup0pY2g0iFIU8vTeOvhCwf8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QhSzoOMvE2cRdXmYIrpcqEckitjorOATWtrkxTyLJenGiZO+dNae1nTX8i7grflic
         Hu2+ZmNVPHE2xgKc/szH3P4U4PHDowVRrt31sRHzJwc15IyoWQ9hbBLRmKCWjDVhcV
         c8+2fyfVyuANxWunVE61NhnE68UgJTiON4zohMls=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20230724084842epcas5p31fa331d291a9ae653efd43f3e2ee90a6~0wYG0ZzOH1773117731epcas5p3i;
        Mon, 24 Jul 2023 08:48:42 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.177]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4R8YjP4tW9z4x9Py; Mon, 24 Jul
        2023 08:48:41 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        5A.1C.06099.9EA3EB46; Mon, 24 Jul 2023 17:48:41 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20230724084841epcas5p16f6df46aaffb860813412d19e2e8abb5~0wYFEo5qL0585405854epcas5p1F;
        Mon, 24 Jul 2023 08:48:41 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230724084841epsmtrp2e69503894af2274dbd413bed7e3930d8~0wYFD0kE52947729477epsmtrp2l;
        Mon, 24 Jul 2023 08:48:41 +0000 (GMT)
X-AuditID: b6c32a4b-d308d700000017d3-85-64be3ae960cd
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        37.B4.30535.8EA3EB46; Mon, 24 Jul 2023 17:48:41 +0900 (KST)
Received: from ws2030077039.sa.corp.samsungelectronics.net (unknown
        [107.99.235.14]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230724084839epsmtip1515b518958fd94bd3e89103a1a3b16a2~0wYDkkA5m2888928889epsmtip1S;
        Mon, 24 Jul 2023 08:48:39 +0000 (GMT)
From:   "sandeep.cs" <sandeep.cs@samsung.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     junwan.cho@samsung.com, jitender.s21@samsung.com,
        suhyun_.kim@samsung.com, ih0923.kim@samsung.com,
        gaudium.lee@samsung.com, sandeep.cs@samsung.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [HID Patchsets v1 2/2] HID: Removed USB Validation check
Date:   Mon, 24 Jul 2023 14:17:51 +0530
Message-Id: <20230724084752.371245-3-sandeep.cs@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230724084752.371245-1-sandeep.cs@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnk+LIzCtJLcpLzFFi42LZdlhTQ/el1b4Ug/lbVC2uT9nManF7gafF
        1iVzWS1uHW9ltHj5YAO7xebJj1gsbn76xmpxedccNov22c8YLR6t2MTkwOWxaVUnm8f7fVfZ
        PPq2rGL0+LxJLoAlKtsmIzUxJbVIITUvOT8lMy/dVsk7ON453tTMwFDX0NLCXEkhLzE31VbJ
        xSdA1y0zB+geJYWyxJxSoFBAYnGxkr6dTVF+aUmqQkZ+cYmtUmpBSk6BSYFecWJucWleul5e
        aomVoYGBkSlQYUJ2xu2WiywF6zkqZs29wdbA+Jeti5GTQ0LAROLM9lbWLkYuDiGB3YwSy5c8
        Z4FwPjFKfPtyAyrzjVGibd8cFpiWjRv/QlXtZZQ4t+oplNPJJNF44xMTSBWbgLbEjL/XmEFs
        EYEIiXcLNjGCFDELXGeUeD5jDliRsICjxI2Lj1hBbBYBVYlVj96DreAVsJF48XQpK8Q6eYmZ
        l76zg9icArYSR6fuY4eoEZQ4OfMJWD0zUE3z1tnMIAskBL6yS6zcuowZotlFYtnjRewQtrDE
        q+NboGwpic/v9rJBNHQzSiy9fYwdwpnBKNGy8ypUt73Ez9cTgKo4gFZoSqzfpQ+xjU+i9/cT
        JpCwhACvREebEES1isTTrt2sMPO/n9gIVeIhMfGOPySEJjBKPNhynnUCo/wsJD/MQvLDLIRl
        CxiZVzFKphYU56anFpsWGOellsPjNjk/dxMjOGVqee9gfPTgg94hRiYOxkOMEhzMSiK86em7
        UoR4UxIrq1KL8uOLSnNSiw8xmgIDeSKzlGhyPjBp55XEG5pYGpiYmZmZWBqbGSqJ875unZsi
        JJCeWJKanZpakFoE08fEwSnVwCTZ3xuftOV8U9yvlrZku/+fChrubeZ2ybZ+8/dumat1h8Sz
        pSvufRfW6dbaLHj0owvvpX2fT/Ptm7zm4VG/ndZyqy5XxfrE/VjUsGBGsXyGsekj5ynW06e9
        XWF/dUtz6E4NW8bOnMaeTYtrlp2vf89a2F368PGDJVERcXu7ruyYnbV3a8u7xu8SmoyRl9Va
        NKZN4k7btceU/c7n39Nqcv4pHp+SnbpB2mUDw3eWtS07Axo2q0w3PG13L6xARSrJ2V+L53Hy
        1/Oz3t0RnpNuarkzMJd5ofFXz4ls33OyXyQt2mS67HpOwO/Qvb8Ket8H8OxXem8cGRzLwevg
        KFyst3WnJHdpkes8o2phe10eQyWW4oxEQy3mouJEAC5GZ7YiBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrALMWRmVeSWpSXmKPExsWy7bCSnO5Lq30pBuv2MFlcn7KZ1eL2Ak+L
        rUvmslrcOt7KaPHywQZ2i82TH7FY3Pz0jdXi8q45bBbts58xWjxasYnJgctj06pONo/3+66y
        efRtWcXo8XmTXABLFJdNSmpOZllqkb5dAlfG7ZaLLAXrOSpmzb3B1sD4l62LkZNDQsBEYuPG
        vyxdjFwcQgK7GSVezbsJlZCSWHX9HiOELSyx8t9zdoiidiaJ6ecfghWxCWhLzPh7jRnEFhGI
        kJj2by1YA7PAfUaJkyuNQGxhAUeJGxcfsYLYLAKqEqsevWcBsXkFbCRePF3KCrFAXmLmpe/s
        IDangK3E0an7wGwhoJodx9ayQ9QLSpyc+YQFYr68RPPW2cwTGAVmIUnNQpJawMi0ilEytaA4
        Nz232LDAKC+1XK84Mbe4NC9dLzk/dxMjONC1tHYw7ln1Qe8QIxMH4yFGCQ5mJRHe9PRdKUK8
        KYmVValF+fFFpTmpxYcYpTlYlMR5v73uTRESSE8sSc1OTS1ILYLJMnFwSjUwbQrLXHr98q4z
        9Rk2Zd0swpu6hXf2fNYW1xCfoFqQ1d9qIO4ZErFyIkvkvCgnV4lfbE8XPVrfEGa0sm3nUskp
        si7FMTvk2J98uJb44cGN7Yw5WUyvpLiXcH2s1Zot4HSBu4NRvajgqNLitu35VpYLvvpMa/z3
        evL2glvTtpQudVklxBDp82+6c3yQsaK2jP+vrR//J6R7FOy77C3JN53P//zqAx0LTAqNZrNL
        7fwVKmrftMKdSb7o3ZdFM78tEfT5/On4p4jzc3wW3lttdoXv04xvByMuzz6fEcy8La7YSMdq
        LiN//cPT3i5Bwa96rkbYt68MSJuZPHl9+J9ZXzcc5uxtOrxTrP5S6N2CL14LlFiKMxINtZiL
        ihMBaxx2U+MCAAA=
X-CMS-MailID: 20230724084841epcas5p16f6df46aaffb860813412d19e2e8abb5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230724084841epcas5p16f6df46aaffb860813412d19e2e8abb5
References: <20230724084752.371245-1-sandeep.cs@samsung.com>
        <CGME20230724084841epcas5p16f6df46aaffb860813412d19e2e8abb5@epcas5p1.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Earlier Samsung driver only handles USB HID devices and returns an error if it encounters a Bluetooth type of HID device.
By removing this USB validation check, we allow the driver to handle other types of HID devices including Bluetooth HID devices, which were previously excluded.

This change improves driver compatibility and extends its support for a wide range of devices.

Signed-off-by: Sandeep C S<sandeep.cs@samsung.com>
Signed-off-by: Junwan Cho <junwan.cho@samsung.com>
Signed-off-by: Jitender Sajwan <jitender.s21@samsung.com>
---
 drivers/hid/hid-samsung.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/hid/hid-samsung.c b/drivers/hid/hid-samsung.c
index 33e963303d11..3cafbf4d9dc6 100644
--- a/drivers/hid/hid-samsung.c
+++ b/drivers/hid/hid-samsung.c
@@ -517,9 +517,6 @@ static int samsung_probe(struct hid_device *hdev,
 	int ret;
 	unsigned int cmask = HID_CONNECT_DEFAULT;
 
-	if (!hid_is_usb(hdev))
-		return -EINVAL;
-
 	ret = hid_parse(hdev);
 	if (ret) {
 		hid_err(hdev, "parse failed\n");
-- 
2.25.1

