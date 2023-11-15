Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FFB77EC023
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 11:06:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234955AbjKOJ71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 04:59:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234894AbjKOJ7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 04:59:09 -0500
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD861183
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 01:59:03 -0800 (PST)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20231115095855epoutp044994b2bcc398eec2a61ac9142e9b077b~Xw39D8EZ61160411604epoutp04s
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 09:58:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20231115095855epoutp044994b2bcc398eec2a61ac9142e9b077b~Xw39D8EZ61160411604epoutp04s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1700042335;
        bh=k7mJNHDakvAVgPYnB64+d/TRqNjPANAbIiAxJ4x7bYM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kQQPLrAk7QNHpGymRGYxHdbB5yR1BNw1TUYk9xe+5kcv6+3u2njkQyugYhMyfu3mo
         0gT7bH+rQQwTJSeM4H3z013prO7aq8i3wSuilOQ7u1GZJg+MzPhIB0VUVZIkwHxIUi
         Tjo9OOJoWY/eniH5r7QDpgY6YEWKzPJewYBS638M=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20231115095854epcas2p178cb95c1a824a4fabad4eaa1e4fbde58~Xw38XEDEE2129221292epcas2p1P;
        Wed, 15 Nov 2023 09:58:54 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.92]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4SVdsp4Ykfz4x9Q1; Wed, 15 Nov
        2023 09:58:54 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        BD.46.10006.E5694556; Wed, 15 Nov 2023 18:58:54 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
        20231115095854epcas2p2e48229f664c1de554f3ecf7075171b93~Xw37n4zOl3041230412epcas2p2E;
        Wed, 15 Nov 2023 09:58:54 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20231115095854epsmtrp1b74f588bd6759bc5da54e6b06c6d6430~Xw37m41rS2856328563epsmtrp1K;
        Wed, 15 Nov 2023 09:58:54 +0000 (GMT)
X-AuditID: b6c32a45-3ebfd70000002716-f9-6554965e21ca
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        43.F6.08755.D5694556; Wed, 15 Nov 2023 18:58:53 +0900 (KST)
Received: from localhost.localdomain (unknown [10.229.9.55]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20231115095853epsmtip27aef11efdb45437ea5d29a117030e297~Xw37KDj412498224982epsmtip2Q;
        Wed, 15 Nov 2023 09:58:53 +0000 (GMT)
From:   Jaewon Kim <jaewon02.kim@samsung.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-serial@vger.kernel.org,
        Jaewon Kim <jaewon02.kim@samsung.com>
Subject: [PATCH v2 04/12] dt-bindings: serial: samsung: add
 exynosautov920-uart compatible
Date:   Wed, 15 Nov 2023 18:56:00 +0900
Message-ID: <20231115095609.39883-5-jaewon02.kim@samsung.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231115095609.39883-1-jaewon02.kim@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEJsWRmVeSWpSXmKPExsWy7bCmqW7ctJBUgz0P5SwezNvGZrFm7zkm
        i/lHzrFaNC9ez2axo+EIq8W7uTIWe19vZbeY8mc5k8Wmx9dYLTbP/8NocXnXHDaLu3dXMVrM
        OL+PyeLM4l52i9a9R9gtDr9pZ7X4uWsei8WqXUB1tydOZnQQ9tg56y67x6ZVnWwed67tYfPY
        P3cNu8fmJfUe/X8NPPq2rGL0+LxJLoAjKtsmIzUxJbVIITUvOT8lMy/dVsk7ON453tTMwFDX
        0NLCXEkhLzE31VbJxSdA1y0zB+gdJYWyxJxSoFBAYnGxkr6dTVF+aUmqQkZ+cYmtUmpBSk6B
        eYFecWJucWleul5eaomVoYGBkSlQYUJ2xu6rvxkLtrFXXH37i7mB8StrFyMnh4SAicTeJ3NZ
        uhi5OIQEdjBKPDn3mRXC+cQo8bXxGBuE841R4tb6SYwwLa0HjjFCJPYySrzcPYcJJCEk8JFR
        Yt/aFBCbTUBb4vv6xWA7RATuM0u8bqsGaWAWaGeSmPftJQtIQlggRqJ/7zMgm4ODRUBV4sPO
        BJAwr4CtxKLGBUwQy+Ql9iz6zgRSwilgJ9F6XguiRFDi5MwnYFOYgUqat85mBhkvIXCBQ6L5
        SR8LRK+LxMGja6D+FJZ4dXwLO4QtJfGyvw3KzpZon/4HqqZC4uKG2WwQtrHErGftjCB7mQU0
        Jdbv0gcxJQSUJY7cglrLJ9Fx+C87RJhXoqNNCKJRTeL+1HNQQ2QkJh1ZCfWIh0Tz/B/MkFCb
        yCjR/PI98wRGhVlIvpmF5JtZCIsXMDKvYhRLLSjOTU8tNiowhMdvcn7uJkZw4tZy3cE4+e0H
        vUOMTByMhxglOJiVRHjN5UJShXhTEiurUovy44tKc1KLDzGaAkN6IrOUaHI+MHfklcQbmlga
        mJiZGZobmRqYK4nz3mudmyIkkJ5YkpqdmlqQWgTTx8TBKdXAJNjFWPfn/9S552smGU5jNLQ7
        3rU0WdbcWUIxPO/as21sifKTvsb+3h8/63Rb62oF6Uqh2b9r6sq6+HUOZDEp+Ox9o6S+6Jzj
        SvtTksXusUlf9i2NVJkh8NX28FO3C3Wm8nomZ5rkg+I3aKwUOTyjW7LS0pk7QH1/xlVr5vUl
        nkL/5yolR908FPqmP3fPy+T6z5vyBG6X+Tp2RfFFuP04pdN85+4RpX3rky9kBRbVrTL44Cnc
        fMnzspD1u09Wp8QnrZ1y/MuR6Uss18+wYf7gFc5z0n7i3LPP3KKunPaKf77SctW1WXGV4f0K
        igLzbwUcUi8zzzl3oErEvt7ZPUP5B8uP3cV94b/kHt8XtNukxFKckWioxVxUnAgA/q6pdmUE
        AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphkeLIzCtJLcpLzFFi42LZdlhJXjduWkiqwb9MiwfztrFZrNl7jsli
        /pFzrBbNi9ezWexoOMJq8W6ujMXe11vZLab8Wc5ksenxNVaLzfP/MFpc3jWHzeLu3VWMFjPO
        72OyOLO4l92ide8RdovDb9pZLX7umsdisWoXUN3tiZMZHYQ9ds66y+6xaVUnm8eda3vYPPbP
        XcPusXlJvUf/XwOPvi2rGD0+b5IL4IjisklJzcksSy3St0vgyth99TdjwTb2iqtvfzE3MH5l
        7WLk5JAQMJFoPXCMEcQWEtjNKNExzxkiLiOx/FkfG4QtLHG/5QhQPRdQzXtGiXnfdrGAJNgE
        tCW+r18MlhAReM4scfbPI2aQBLNAP5PE9U0JILawQJTE79uLmLoYOThYBFQlPuwEC/MK2Eos
        alzABLFAXmLPou9gJZwCdhKt57Ug7rGVaN39gxmiXFDi5MwnLBDT5SWat85mnsAoMAtJahaS
        1AJGplWMkqkFxbnpucWGBYZ5qeV6xYm5xaV56XrJ+bmbGMERpqW5g3H7qg96hxiZOBgPMUpw
        MCuJ8JrLhaQK8aYkVlalFuXHF5XmpBYfYpTmYFES5xV/0ZsiJJCeWJKanZpakFoEk2Xi4JRq
        YJo9SyOAzeMgt7/9pcnTOK9s3j3pNr+/7a9PuQvdZr7yMFQ+c1cvYHuiw6aD17Zv2Mih4PXB
        VXKJ8eR2ufWaHouvqVnMfbri9ib2ZBuJL/OeukUdUd+xnSX6XdyOX8eeCH1Rr/sr8/Ktybrg
        IqNfUg9mJD3iYo08dHa3zjOVO9u2sQbPVpwz4/LktTq7jIsaz8YIbjWomsQ9y5Zd5xLLT+EM
        ry2iehLzLu6cZ6vTXrrR14Djp37MVQmBKV8FjYoNttoph7y2CJi52oM5j2OiUJPLq5eH7si5
        zxU8/4FFX3jhmVA5vc3JW/rP6kwxVTPI0C+KMry11aThnNSxnWFX41e6+3j89nisJK5W5v9D
        OlqJpTgj0VCLuag4EQA2vKKZHwMAAA==
X-CMS-MailID: 20231115095854epcas2p2e48229f664c1de554f3ecf7075171b93
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231115095854epcas2p2e48229f664c1de554f3ecf7075171b93
References: <20231115095609.39883-1-jaewon02.kim@samsung.com>
        <CGME20231115095854epcas2p2e48229f664c1de554f3ecf7075171b93@epcas2p2.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add samsung,exynosautov9-uart dedicated compatible for representing
uart of ExynosAutov920 SoC.

Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
---
 Documentation/devicetree/bindings/serial/samsung_uart.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/serial/samsung_uart.yaml b/Documentation/devicetree/bindings/serial/samsung_uart.yaml
index 0d0215b23ab7..e32c1b462836 100644
--- a/Documentation/devicetree/bindings/serial/samsung_uart.yaml
+++ b/Documentation/devicetree/bindings/serial/samsung_uart.yaml
@@ -35,7 +35,9 @@ properties:
               - samsung,exynos7885-uart
           - const: samsung,exynos5433-uart
       - items:
-          - const: samsung,exynosautov9-uart
+          - enum:
+              - samsung,exynosautov9-uart
+              - samsung,exynosautov920-uart
           - const: samsung,exynos850-uart
 
   reg:
-- 
2.42.0

