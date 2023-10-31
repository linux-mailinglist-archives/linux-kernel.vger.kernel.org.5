Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 794777DCA0C
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 10:51:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236106AbjJaJvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 05:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235921AbjJaJuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 05:50:55 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C13313D
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 02:50:36 -0700 (PDT)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20231031095022epoutp010e5d914e825a8d3842cc83f64c90f464~TKFM1crjI0894608946epoutp01I
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 09:50:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20231031095022epoutp010e5d914e825a8d3842cc83f64c90f464~TKFM1crjI0894608946epoutp01I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1698745822;
        bh=B+5v5F2JOOqOrd5gw6gtlehZc1Hm1qkQF/xdN2ruII4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VWT1jiYvK90URdRXscT95fYkgYHLJXFEZSCCpN17JO/CYJ+qZAy/pn2+eZxSLCX6l
         RGLtI3PinoK6qNf4XfpAi/wwGoXIZLPcb+8YtFS9cm1n4fbOUtZS1CSzUaxna/kqnS
         dWjtQegHDObEOyjzvGsZFWtdP8bFAJsuz3wq43WI=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20231031095021epcas2p38487b5fa743e7f2fa93a14840c314631~TKFMQ-gFq1121511215epcas2p3G;
        Tue, 31 Oct 2023 09:50:21 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.100]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4SKQNs0ktxz4x9Px; Tue, 31 Oct
        2023 09:50:21 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        0C.1E.10022.CDDC0456; Tue, 31 Oct 2023 18:50:20 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
        20231031095020epcas2p1b72264a38832dc2fcb9df8e6b968770f~TKFLTJd7M2926329263epcas2p1R;
        Tue, 31 Oct 2023 09:50:20 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20231031095020epsmtrp259e02aed1437c19019e7a84076e031b0~TKFLRHmSi1473914739epsmtrp2G;
        Tue, 31 Oct 2023 09:50:20 +0000 (GMT)
X-AuditID: b6c32a47-9a3ff70000002726-30-6540cddc0f89
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        C0.21.08817.CDDC0456; Tue, 31 Oct 2023 18:50:20 +0900 (KST)
Received: from localhost.localdomain (unknown [10.229.9.55]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20231031095019epsmtip14215fc8c0abd0124137d6b5d91a71163~TKFKmSILj2330523305epsmtip1L;
        Tue, 31 Oct 2023 09:50:19 +0000 (GMT)
From:   Jaewon Kim <jaewon02.kim@samsung.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-serial@vger.kernel.org,
        Jaewon Kim <jaewon02.kim@samsung.com>
Subject: [PATCH 07/10] soc: samsung: exynos-chipid: add exynosautov920 SoC
 support
Date:   Tue, 31 Oct 2023 18:47:49 +0900
Message-ID: <20231031094852.118677-8-jaewon02.kim@samsung.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231031094852.118677-1-jaewon02.kim@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCJsWRmVeSWpSXmKPExsWy7bCmqe6dsw6pBvObrC0ezNvGZrFm7zkm
        i/lHzrFaNC9ez2axo+EIq8W7uTIWe19vZbeY8mc5k8Wmx9dYLTbP/8NocXnXHDaLu3dXMVrM
        OL+PyeLM4l52i9a9R9gtDr9pZ7X4uWsei8WqXUB1tydOZnQQ9tg56y67x6ZVnWwed67tYfPY
        P3cNu8fmJfUe/X8NPPq2rGL0+LxJLoAjKtsmIzUxJbVIITUvOT8lMy/dVsk7ON453tTMwFDX
        0NLCXEkhLzE31VbJxSdA1y0zB+gdJYWyxJxSoFBAYnGxkr6dTVF+aUmqQkZ+cYmtUmpBSk6B
        eYFecWJucWleul5eaomVoYGBkSlQYUJ2xpvt29kKrrFWNLxaxNLA+Jyli5GTQ0LAROLQn8lA
        NheHkMAORoltj08xgySEBD4xSrRezoRIfGOU2Ll0ESNMx+6rv5ghEnsZJbqOnmWFcD4ySrz8
        dwOsik1AW+L7+sWsILaIwBdmiemPqkGKmAXamSTmfXsJtlxYIERi/Zv37CA2i4CqRPu1R2DN
        vAJ2Er2rr0EdKC+xZ9F3JhCbU8BeYmdPE1SNoMTJmU/AapiBapq3zgY7SULgDIdE/8mDzBDN
        LhKHJzRB2cISr45vYYewpSQ+v9vLBmFnS7RP/8MKYVdIXNwwGypuLDHrWTvQMg6gBZoS63fp
        g5gSAsoSR25BreWT6Dj8lx0izCvR0SYE0agmcX/qOaghMhKTjqxkgrA9JGZtnQYNq0mMEn/P
        3maawKgwC8k3s5B8Mwth8QJG5lWMYqkFxbnpqcVGBcbwGE7Oz93ECE7eWu47GGe8/aB3iJGJ
        g/EQowQHs5II72FTh1Qh3pTEyqrUovz4otKc1OJDjKbAsJ7ILCWanA/MH3kl8YYmlgYmZmaG
        5kamBuZK4rz3WuemCAmkJ5akZqemFqQWwfQxcXBKNTD1PWLg37VFJOp7pZGj5nbJI0s2LfyY
        oDPvtnzHzHldq7t5918S/2n1UbDj6M/f53XDX7Ctsep6aeW93T6Me/XDtO83WkoeNIhK5t0K
        Dpy7Q2P7yfPfv27aWylS99xG7+2F5UrM0+wKVMvdJ+3an++8lPmQdwa/yFEBFfM5BvVne5dk
        PGXW738aIezK7H815uns8/H/2EXLVHT6Hk2+qavEX8B3/lBP2+fvmoeT3h10FOJZqs3RfPi4
        kLKp4V+Dh3uNJqyxmf2UL7jk49ppk8zO93tylYs1HFo24/U8LoEJgdJ1FxeGFpZPvy1j7xu7
        V007ofvX01gH1+q9XhNN++T/+fT5P9S/2NL67O/63EQlluKMREMt5qLiRACqy2ugZwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAIsWRmVeSWpSXmKPExsWy7bCSnO6dsw6pBp8uKlo8mLeNzWLN3nNM
        FvOPnGO1aF68ns1iR8MRVot3c2Us9r7eym4x5c9yJotNj6+xWmye/4fR4vKuOWwWd++uYrSY
        cX4fk8WZxb3sFq17j7BbHH7Tzmrxc9c8FotVu4Dqbk+czOgg7LFz1l12j02rOtk87lzbw+ax
        f+4ado/NS+o9+v8aePRtWcXo8XmTXABHFJdNSmpOZllqkb5dAlfGm+3b2QqusVY0vFrE0sD4
        nKWLkZNDQsBEYvfVX8xdjFwcQgK7GSWe7p7ABJGQkVj+rI8NwhaWuN9yhBWi6D2jxPaXS8G6
        2QS0Jb6vXwyWEBH4xSyxe8JdRpAEs0A/k8T1TQkgtrBAkMTue01gU1kEVCXarz0Cq+EVsJPo
        XX0N6gx5iT2LvoPVcArYS+zsaQKrEQKqubjhJhNEvaDEyZlPWCDmy0s0b53NPIFRYBaS1Cwk
        qQWMTKsYJVMLinPTc4sNC4zyUsv1ihNzi0vz0vWS83M3MYIjTUtrB+OeVR/0DjEycTAeYpTg
        YFYS4T1s6pAqxJuSWFmVWpQfX1Sak1p8iFGag0VJnPfb694UIYH0xJLU7NTUgtQimCwTB6dU
        A5NzRfTF4vTiSSzbs/NmzHtZ+2Xz+ceP11mu5GDRWRXzJGeG5Nk+4RfiYinieuermLRTA/ZJ
        bFh5222pxRz3y3MP7vv/Q+nY33dTNCbPzvcQ5xJXZXgg9Ljf8I5oyXJBkR/8O75V+er2ZnFP
        aSs05ps729wztlnE9JzIYwOfy4vYb9b05BjqXrcXK51e5tWrWBgmodyueaH0/tuDrduY2srq
        u9es/vf8ye/qn7N9zGbFb218E9BwmyUgyOTx6TvPxa3O1a3XubplymYd8ZiD85P9Y04yJHLP
        VIm1X8chILKh1+U5S8dsgfofZz9pey4O2H/O/DhD2YwXHrWCmucnWJ7s7rMtTv605NXsL7p5
        f5RYijMSDbWYi4oTAbMzgVkjAwAA
X-CMS-MailID: 20231031095020epcas2p1b72264a38832dc2fcb9df8e6b968770f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231031095020epcas2p1b72264a38832dc2fcb9df8e6b968770f
References: <20231031094852.118677-1-jaewon02.kim@samsung.com>
        <CGME20231031095020epcas2p1b72264a38832dc2fcb9df8e6b968770f@epcas2p1.samsung.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add EXYNOSAUTOV920 information to soc_ids tables. This SoC product id
is "0x0A920000".

Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
---
 drivers/soc/samsung/exynos-chipid.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/samsung/exynos-chipid.c b/drivers/soc/samsung/exynos-chipid.c
index 7ba45c4aff97..3ee554595e49 100644
--- a/drivers/soc/samsung/exynos-chipid.c
+++ b/drivers/soc/samsung/exynos-chipid.c
@@ -59,6 +59,7 @@ static const struct exynos_soc_id {
 	{ "EXYNOS7885", 0xE7885000 },
 	{ "EXYNOS850", 0xE3830000 },
 	{ "EXYNOSAUTOV9", 0xAAA80000 },
+	{ "EXYNOSAUTOV920", 0x0A920000 },
 };
 
 static const char *product_id_to_soc_id(unsigned int product_id)
-- 
2.42.0

