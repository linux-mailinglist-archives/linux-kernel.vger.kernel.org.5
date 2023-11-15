Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9D867EBFFE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 11:06:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234891AbjKOJ7X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 04:59:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234890AbjKOJ7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 04:59:07 -0500
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9AED12A
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 01:59:02 -0800 (PST)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20231115095856epoutp037c7b5d747ef1b79fe0d6f5994536b81e~Xw39d4w_l0640206402epoutp03-
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 09:58:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20231115095856epoutp037c7b5d747ef1b79fe0d6f5994536b81e~Xw39d4w_l0640206402epoutp03-
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1700042336;
        bh=Je4oVe2Ds5NyqjG75sDuOwZc3fdFC6A8pg4jNpKzco8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YridPgHMeARQbf0vDiqxhF0B33V1aakyfGuUp76smOUNv0GYENoi0SSd6enqxoXuc
         Zd28UuNZmk3p8aGJCC0oQ7era74S5l6zt8YOTFe33WpasKlZ6kP48DLjYmzBQ52pGT
         8tujO9UnU/1SEBNtaNmH+5IdJpJV6UKqWJrYRNo4=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20231115095855epcas2p25c8d92aea81d09ba5de5f4cdea1e8887~Xw39F_v8I3241632416epcas2p2J;
        Wed, 15 Nov 2023 09:58:55 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.97]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4SVdsq38LYz4x9Q5; Wed, 15 Nov
        2023 09:58:55 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        E2.47.10022.F5694556; Wed, 15 Nov 2023 18:58:55 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20231115095854epcas2p42af0a20bcc4fb98aee818c7b44d77c31~Xw377l54N0467204672epcas2p4J;
        Wed, 15 Nov 2023 09:58:54 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20231115095854epsmtrp10081d7f2f6ef018232bfef56fdbfa5e1~Xw376sIVT2856328563epsmtrp1L;
        Wed, 15 Nov 2023 09:58:54 +0000 (GMT)
X-AuditID: b6c32a47-9a3ff70000002726-3d-6554965fb6a2
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        9F.71.08817.E5694556; Wed, 15 Nov 2023 18:58:54 +0900 (KST)
Received: from localhost.localdomain (unknown [10.229.9.55]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20231115095853epsmtip201b8da7c5249b86482d5b6bd2379b063~Xw37cXBab2713927139epsmtip2f;
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
Subject: [PATCH v2 05/12] dt-bindings: pwm: samsung: add exynosautov920
 compatible
Date:   Wed, 15 Nov 2023 18:56:01 +0900
Message-ID: <20231115095609.39883-6-jaewon02.kim@samsung.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231115095609.39883-1-jaewon02.kim@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMJsWRmVeSWpSXmKPExsWy7bCmmW78tJBUg4cPRSwezNvGZrFm7zkm
        i/lHzrFaNC9ez2axo+EIq8W7uTIWe19vZbeY8mc5k8Wmx9dYLTbP/8NocXnXHDaLu3dXMVrM
        OL+PyeLM4l52i9a9R9gtDr9pZ7X4uWsei8WqXUB1tydOZnQQ9tg56y67x6ZVnWwed67tYfPY
        P3cNu8fmJfUe/X8NPPq2rGL0+LxJLoAjKtsmIzUxJbVIITUvOT8lMy/dVsk7ON453tTMwFDX
        0NLCXEkhLzE31VbJxSdA1y0zB+gdJYWyxJxSoFBAYnGxkr6dTVF+aUmqQkZ+cYmtUmpBSk6B
        eYFecWJucWleul5eaomVoYGBkSlQYUJ2xqT+sywFV9gqNi59wdbAuJW1i5GTQ0LARGLS3WtA
        NheHkMAORokXbydCOZ8YJR7d2Q/lfGOU2PiiiR2m5f/02SwQib2MEkv/TGKHcD4ySqxvW8cC
        UsUmoC3xff1isCUiAveZJV63VYMUMQu0M0nM+/YSrEhYIETi1+NpYGNZBFQlPi1ZBhTn4OAV
        sJVo++sOsU1eYs+i70wgYU4BO4nW81ogYV4BQYmTM5+ATWEGKmneOpsZZLyEwBMOidsrWlgg
        el0kXm2aCmULS7w6vgXqAymJl/1tUHa2RPv0P9DAqJC4uGE2G4RtLDHrWTsjyF5mAU2J9bv0
        QUwJAWWJI7eg1vJJdBz+yw4R5pXoaBOCaFSTuD/1HNQQGYlJR1YyQdgeEo0P1jFDQmoio8TE
        /jUsExgVZiH5ZhaSb2YhLF7AyLyKUSy1oDg3PbXYqMAYHsHJ+bmbGMGpW8t9B+OMtx/0DjEy
        cTAeYpTgYFYS4TWXC0kV4k1JrKxKLcqPLyrNSS0+xGgKDOmJzFKiyfnA7JFXEm9oYmlgYmZm
        aG5kamCuJM57r3VuipBAemJJanZqakFqEUwfEwenVAOTjsCKb97vczfeFpcQe81fo2FY8Haa
        X2fL1Mv7JoeJLGENmPTkNcOd7kVL3BcHPlt4fV9FU9k8L8cFfYsPyGa9ecvRql+Vz3s8Z1WE
        IcfhZzqODM1Tfu24fTNBO47/zqfCzo+ulR857jw7fPHGl3aWS69WRCQ/tm1V/3dwKTfDZK59
        gWv19D5tzvSZ95Xt+OMMU7cQhYrlJqt2rbRfz7j9yPPPJRapKu1S9VLNRRO2661oW+rhGbn/
        9EeRtSLms+8tPPX247ltz/e0aPCvqe6vVKtaynz3xs9H9bfyf6xUyAqNWmnPMoXD7PU1PYuY
        sLCvTZFCbd0v39TfPdnKHZpb/eCb0VrZj4cSrH7LPVnFqsRSnJFoqMVcVJwIAOtCSMhmBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCIsWRmVeSWpSXmKPExsWy7bCSvG7ctJBUgwWXhC0ezNvGZrFm7zkm
        i/lHzrFaNC9ez2axo+EIq8W7uTIWe19vZbeY8mc5k8Wmx9dYLTbP/8NocXnXHDaLu3dXMVrM
        OL+PyeLM4l52i9a9R9gtDr9pZ7X4uWsei8WqXUB1tydOZnQQ9tg56y67x6ZVnWwed67tYfPY
        P3cNu8fmJfUe/X8NPPq2rGL0+LxJLoAjissmJTUnsyy1SN8ugStjUv9ZloIrbBUbl75ga2Dc
        ytrFyMkhIWAi8X/6bJYuRi4OIYHdjBInJ55jg0jISCx/1gdlC0vcbznCClH0nlHifuM/JpAE
        m4C2xPf1i8ESIgLPmSXO/nnEDJJgFuhnkri+KQHEFhYIkvj4Yxk7iM0ioCrxackyoHUcHLwC
        thJtf90hFshL7Fn0nQkkzClgJ9F6XgskLARU0br7B9hEXgFBiZMzn4B1MguoS6yfJwSxSF6i
        eets5gmMgrOQVM1CqJqFpGoBI/MqRsnUguLc9NxiwwKjvNRyveLE3OLSvHS95PzcTYzgiNTS
        2sG4Z9UHvUOMTByMhxglOJiVRHjN5UJShXhTEiurUovy44tKc1KLDzFKc7AoifN+e92bIiSQ
        nliSmp2aWpBaBJNl4uCUamAyMt6devMpT0rknKviWZn3xLZfui41tdsiw/s+u3llxu3TkQcC
        Npvoy+kVs8WHLrZ0f9/2tCC93N+6jHf6da5LebmKL6a1idcJ7fl5+NkVybudG2/vNF4c+XWV
        xcYKbvkMjhuTZ7XMKJq64UiB+AKNrv9/319wklodofvuefFK/blGS+5/10zhP1hx4HHw+taP
        G07WzZ5Tt7fnTaHXzovhJrUWnmcset1zb3oF/axkEQ6VTd+bKBcZOrWLhaFK6ci0yzwt08//
        0LSs/9yw46B+8Flx/cgdHKofHeomCTR2333uaXWzsemlkbf9BnuWtHzf8rNCqVuXXD9XHlt0
        +LWe6xq+tMyjnCEiHOtbDiixFGckGmoxFxUnAgBngwBsNwMAAA==
X-CMS-MailID: 20231115095854epcas2p42af0a20bcc4fb98aee818c7b44d77c31
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231115095854epcas2p42af0a20bcc4fb98aee818c7b44d77c31
References: <20231115095609.39883-1-jaewon02.kim@samsung.com>
        <CGME20231115095854epcas2p42af0a20bcc4fb98aee818c7b44d77c31@epcas2p4.samsung.com>
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

Add samsung,exynosautov920-pwm compatible string to binding document.

Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 Documentation/devicetree/bindings/pwm/pwm-samsung.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pwm/pwm-samsung.yaml b/Documentation/devicetree/bindings/pwm/pwm-samsung.yaml
index 89a3875cb50a..16de6434693b 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-samsung.yaml
+++ b/Documentation/devicetree/bindings/pwm/pwm-samsung.yaml
@@ -32,6 +32,7 @@ properties:
               - samsung,exynos5433-pwm
               - samsung,exynos7-pwm
               - samsung,exynosautov9-pwm
+              - samsung,exynosautov920-pwm
           - const: samsung,exynos4210-pwm
 
   reg:
-- 
2.42.0

