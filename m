Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB25D7EC01E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 11:06:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235019AbjKOJ75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 04:59:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234876AbjKOJ7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 04:59:18 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 644B61AB
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 01:59:04 -0800 (PST)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20231115095856epoutp023cc72b16c04ca9d136c528a501408758~Xw3_FrdD00279502795epoutp02B
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 09:58:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20231115095856epoutp023cc72b16c04ca9d136c528a501408758~Xw3_FrdD00279502795epoutp02B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1700042336;
        bh=L4X5k9N95plxe/sm6+xrWRntkwzqx8Lp81eXD24SrDU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=apCTkvomUbREReH3pWbjMAE0uazPlF61edKsZHc5IT35KDohRptEIYZPgfKa+YiJF
         t4xe+quSAYSkPAZGddRVnekJcwiejoBnvZgd35z46BHSIeFmFXP3jDnwYVriCq40gw
         4qYSgg50+bW0aGLL4J0rhq7TcMazcLUSmByY0FiE=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20231115095856epcas2p49d1df0d31e6cef2693331d4085143448~Xw39mP_AY0464704647epcas2p4t;
        Wed, 15 Nov 2023 09:58:56 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.98]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4SVdsq6wZbz4x9Pw; Wed, 15 Nov
        2023 09:58:55 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        1A.B1.09607.F5694556; Wed, 15 Nov 2023 18:58:55 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20231115095855epcas2p3fb87cfdf820587174cc6b4d97e7f1b45~Xw38zY3UB0132301323epcas2p3Y;
        Wed, 15 Nov 2023 09:58:55 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20231115095855epsmtrp27751bb0f918df5625086ddc428f6a5e7~Xw38ull6D2554225542epsmtrp2e;
        Wed, 15 Nov 2023 09:58:55 +0000 (GMT)
X-AuditID: b6c32a48-963ff70000002587-72-6554965f63c6
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        6D.B2.07368.F5694556; Wed, 15 Nov 2023 18:58:55 +0900 (KST)
Received: from localhost.localdomain (unknown [10.229.9.55]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20231115095854epsmtip2761568fbbc0d8e5081e00a53702f595e~Xw38Sv_sJ2498624986epsmtip2f;
        Wed, 15 Nov 2023 09:58:54 +0000 (GMT)
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
Subject: [PATCH v2 08/12] dt-bindings: hwinfo: samsung,exynos-chipid: add
 exynosautov920 compatible
Date:   Wed, 15 Nov 2023 18:56:04 +0900
Message-ID: <20231115095609.39883-9-jaewon02.kim@samsung.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231115095609.39883-1-jaewon02.kim@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEJsWRmVeSWpSXmKPExsWy7bCmqW78tJBUg1PnzSwezNvGZrFm7zkm
        i/lHzrFaNC9ez2axo+EIq8W7uTIWe19vZbeY8mc5k8Wmx9dYLTbP/8NocXnXHDaLu3dXMVrM
        OL+PyeLM4l52i9a9R9gtDr9pZ7X4uWsei8WqXUB1tydOZnQQ9tg56y67x6ZVnWwed67tYfPY
        P3cNu8fmJfUe/X8NPPq2rGL0+LxJLoAjKtsmIzUxJbVIITUvOT8lMy/dVsk7ON453tTMwFDX
        0NLCXEkhLzE31VbJxSdA1y0zB+gdJYWyxJxSoFBAYnGxkr6dTVF+aUmqQkZ+cYmtUmpBSk6B
        eYFecWJucWleul5eaomVoYGBkSlQYUJ2xrR3jWwFl9gq+tbOYmpg3MraxcjJISFgItH9dzGQ
        zcUhJLCDUWL/rR5mCOcTo8TOlitsEM43Rolzf28DlXGAtdyfGgUR38soseFZE1THR0aJO7M/
        s4DMZRPQlvi+fjHYDhGB+8wSr9uqQYqYBdqZJOZ9ewlWJCyQKrG48z4ziM0ioCpx9dJpJpAN
        vAK2Ev/PaUDcJy+xZ9F3sDCngJ1E63ktkDCvgKDEyZlPwKYwA5U0b50NdoOEwBUOiZafO6F+
        c5GY1/6YBcIWlnh1fAs7hC0l8fndXjYIO1uiffofqPoKiYsbZkPFjSVmPWtnBNnLLKApsX6X
        PsTvyhJHbkGt5ZPoOPyXHSLMK9HRJgTRqAYMnXNQQ2QkJh1ZyQRhe0j8vfCWHRJSExkl3n18
        xD6BUWEWkm9mIflmFsLiBYzMqxjFUguKc9NTi40KTODxm5yfu4kRnLi1PHYwzn77Qe8QIxMH
        4yFGCQ5mJRFec7mQVCHelMTKqtSi/Pii0pzU4kOMpsCQnsgsJZqcD8wdeSXxhiaWBiZmZobm
        RqYG5krivPda56YICaQnlqRmp6YWpBbB9DFxcEo1ME1dtGyS3N1Jz3lP/fbXEtKQUkr44vRV
        9BETi0Hv9J0Tl4TJ/6/60/PBXazxW2tOW+iDllurMrnP1B1fa6QouqbB5kD/4YkmW7l9NI+1
        l0j6T02TtvlwQ0870GGjtxyzztZgT94uCb8feSFtFcw7Gx9fC9JKPlZ/lmlN46nFpl0b35V+
        Dokpee8Wmc4TusCW++53+yBnzp3+nE2XNty2WLtkTkipoVdC5oPvcxlkdl87fkp1bevWK28z
        Lp77vW/H2hlTH++eqbv/4ZGc1SVvP10Jr3zS3Wbuc/HzKhG3LWbxLJ9uyTy2/ql4OuJmhG+n
        20PN2Vsntr5wZc6ZyjW9bV1H5HZFVZFrhyofzvhyarYSS3FGoqEWc1FxIgD1wIELZQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphkeLIzCtJLcpLzFFi42LZdlhJXjd+WkiqwdQJ/BYP5m1js1iz9xyT
        xfwj51gtmhevZ7PY0XCE1eLdXBmLva+3sltM+bOcyWLT42usFpvn/2G0uLxrDpvF3burGC1m
        nN/HZHFmcS+7ReveI+wWh9+0s1r83DWPxWLVLqC62xMnMzoIe+ycdZfdY9OqTjaPO9f2sHns
        n7uG3WPzknqP/r8GHn1bVjF6fN4kF8ARxWWTkpqTWZZapG+XwJUx7V0jW8Eltoq+tbOYGhi3
        snYxcnBICJhI3J8a1cXIxSEksJtR4sKFD4xdjJxAcRmJ5c/62CBsYYn7LUdYQWwhgfeMEuvO
        lYHYbALaEt/XL2YFaRYReM4scfbPI2aQBLNAP5PE9U0JILawQLJE296FYENZBFQlrl46zQSy
        mFfAVuL/OQ2I+fISexZ9BwtzCthJtJ7XglhlK9G6+wfYRF4BQYmTM5+wQEyXl2jeOpt5AqPA
        LCSpWUhSCxiZVjFKphYU56bnJhsWGOallusVJ+YWl+al6yXn525iBEeYlsYOxnvz/+kdYmTi
        YDzEKMHBrCTCay4XkirEm5JYWZValB9fVJqTWnyIUZqDRUmc13DG7BQhgfTEktTs1NSC1CKY
        LBMHp1QDU873BcdmfNuu/VZhX71zVmlCblf8yn27p+7yfF2+47Da6+uWpZPLGMVMWFjScyd5
        Nf48dii6q9RScuepe4tMzpb94VUTv7/2cbjA7OjapT6vbB5OSur/brfnd4fdv1P1Eyvu8kqF
        KoUw9zjorFn75c8SofkZ/tzr5/7jOHvSVa5Dkj3L1P+92+nWBs88xt1CEXr/9Wfyb3Zx1nmS
        wRl4dg+jsK1/RFINvy8X36qt/WXcHzierzbobdE21srXmRPWteogo8zbgo1BZus1M1Y9NWhq
        eTJvdYF8ik9mlO3Ji248uUunfQ1a82TVtC027PIVD0/9D61/NmfDH+/gUqeaVybsBW0Tc/Wi
        1Q+ttK1QYinOSDTUYi4qTgQAETc4UR8DAAA=
X-CMS-MailID: 20231115095855epcas2p3fb87cfdf820587174cc6b4d97e7f1b45
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231115095855epcas2p3fb87cfdf820587174cc6b4d97e7f1b45
References: <20231115095609.39883-1-jaewon02.kim@samsung.com>
        <CGME20231115095855epcas2p3fb87cfdf820587174cc6b4d97e7f1b45@epcas2p3.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add "samsung,exynosautov920-chipid" compatible string to binding document.

Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
---
 .../devicetree/bindings/hwinfo/samsung,exynos-chipid.yaml        | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/hwinfo/samsung,exynos-chipid.yaml b/Documentation/devicetree/bindings/hwinfo/samsung,exynos-chipid.yaml
index 45f3d468db7c..780ccb5ee9b4 100644
--- a/Documentation/devicetree/bindings/hwinfo/samsung,exynos-chipid.yaml
+++ b/Documentation/devicetree/bindings/hwinfo/samsung,exynos-chipid.yaml
@@ -24,6 +24,7 @@ properties:
           - enum:
               - samsung,exynos7885-chipid
               - samsung,exynosautov9-chipid
+              - samsung,exynosautov920-chipid
           - const: samsung,exynos850-chipid
 
   reg:
-- 
2.42.0

