Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 806B4757286
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 05:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbjGRDrr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 23:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230130AbjGRDre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 23:47:34 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C6FB134
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 20:47:28 -0700 (PDT)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230718034725epoutp03348e08b02270814f2d1cb93f4b330111~y2ZVXxHvh0156701567epoutp035
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 03:47:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230718034725epoutp03348e08b02270814f2d1cb93f4b330111~y2ZVXxHvh0156701567epoutp035
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1689652045;
        bh=tUyKv0Hx5nGnEiCI/vVeQR3a2nFshbnAB6TDUjUHNnc=;
        h=From:To:Cc:Subject:Date:References:From;
        b=MCVmxAM6TUzKnznSmPBridyWtGHfZK8bfyN1mpkHamXFhLZ7l4rIjVl405mtvdeag
         MbnSO58dnF3Z6Sa1F45SdjecFtqgikvUBMS2SQYbVXfqxElgdk0W/TR5A712XIBYFn
         UwbD1TwgxAAI2Xa/tqsXtj38wyBZh9DPObDg0rCo=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20230718034724epcas2p2499327aa298c73ad661ef91e98e2a930~y2ZUnXhoB0276202762epcas2p2q;
        Tue, 18 Jul 2023 03:47:24 +0000 (GMT)
Received: from epsmgec2p1.samsung.com (unknown [182.195.36.68]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4R4lJX3sYHz4x9Q3; Tue, 18 Jul
        2023 03:47:24 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmgec2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        75.66.55279.C4B06B46; Tue, 18 Jul 2023 12:47:24 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20230718034723epcas2p4f50be7f8669579b6e37e50516dee5ae1~y2ZTqq3sq1954119541epcas2p4Y;
        Tue, 18 Jul 2023 03:47:23 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230718034723epsmtrp1a79376c4454b6561ed63e98b025fdbb4~y2ZTp8phm2910429104epsmtrp1S;
        Tue, 18 Jul 2023 03:47:23 +0000 (GMT)
X-AuditID: b6c32a43-2f3ff7000001d7ef-33-64b60b4cef3a
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        49.2E.30535.B4B06B46; Tue, 18 Jul 2023 12:47:23 +0900 (KST)
Received: from localhost.localdomain (unknown [10.229.9.55]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230718034723epsmtip130c02e5a16473aa6bb731e018b03e950~y2ZTUTqmh2045420454epsmtip1W;
        Tue, 18 Jul 2023 03:47:23 +0000 (GMT)
From:   Jaewon Kim <jaewon02.kim@samsung.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        Jaewon Kim <jaewon02.kim@samsung.com>
Subject: [PATCH v5 0/2] support PWM for exynosautov9
Date:   Tue, 18 Jul 2023 12:41:59 +0900
Message-Id: <20230718034201.136800-1-jaewon02.kim@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIKsWRmVeSWpSXmKPExsWy7bCmua4P97YUg2s7pCwezNvGZrFm7zkm
        i/lHzrFa7Gg4wmrR9+Ihs8Wmx9dYLS7vmsNmcffuKkaLGef3MVm07j3CbvFz1zwWi9sTJzM6
        8HjsnHWX3WPTqk42jzvX9rB5bF5S79H/18Cjb8sqRo/Pm+QC2KOybTJSE1NSixRS85LzUzLz
        0m2VvIPjneNNzQwMdQ0tLcyVFPISc1NtlVx8AnTdMnOA7lRSKEvMKQUKBSQWFyvp29kU5ZeW
        pCpk5BeX2CqlFqTkFJgX6BUn5haX5qXr5aWWWBkaGBiZAhUmZGdc/bWCpeAea8XuR+dZGhhP
        snQxcnJICJhI3Dx+iLGLkYtDSGAHo8SiS+fZIJxPjBI3Tv+DynxjlDj4tgOu5fyXHlaIxF5G
        iVt3GqGqPjJKvDq+jwmkik1AW+L7+sWsILaIwEImiWf3y0CKmAVOM0qsvfUEbJQw0Kgfd54z
        gtgsAqoSjSsb2EBsXgE7if33+1kh1slLrN5wgBmkWULgHrvEl81noe5wkdi2qY8NwhYG2ryF
        HcKWknjZ3wZlZ0u0T/8DNahC4uKG2VD1xhKznrUDLeYAukhTYv0ufRBTQkBZ4sgtsOnMAnwS
        HYf/skOEeSU62oQgGtUk7k89BzVERmLSkZVMELaHxOfnh8EWCQnEStz9sIJlAqPsLIT5CxgZ
        VzGKpRYU56anJhsVGMJjKTk/dxMjOO1pOe9gvDL/n94hRiYOxkOMEhzMSiK831dtShHiTUms
        rEotyo8vKs1JLT7EaAoMronMUqLJ+cDEm1cSb2hiaWBiZmZobmRqYK4kznuvdW6KkEB6Yklq
        dmpqQWoRTB8TB6dUA9OkzUE+oX+VLUrcVddICfmbHJvsuvL1ks/FqtFeLd8sltnWL8+NVFzS
        vvO27+x9TC5NfLZGRnpP3CsFTv29k5jldGqlYvyOokWaCc/Tc9yktlVuUpQxrzqZyprNxtbu
        ZGgXYZ2y5bfw09t/c9/9KLh4b9m/aJlN5Vtlwlr2q0fHfbxRJSbzwJu3/Vv85OQPn1w9p1pG
        b3rU/jLljGDRj04Gt0UMp/5lWOqmrbm5/cTb+EvOMzI4d5rcKPSZxia7YIqbUuIZlaBdqjqu
        3+O/P330alPrikrpNYpqvzY+U0jaccaMryXX1Pr0yrfSmxVEk/McLy/Y21ZzJiXv1bHHulri
        a7XmFim+6RN5Z9ProsRSnJFoqMVcVJwIAAQ0Vs0EBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrELMWRmVeSWpSXmKPExsWy7bCSnK4397YUg0lHNCwezNvGZrFm7zkm
        i/lHzrFa7Gg4wmrR9+Ihs8Wmx9dYLS7vmsNmcffuKkaLGef3MVm07j3CbvFz1zwWi9sTJzM6
        8HjsnHWX3WPTqk42jzvX9rB5bF5S79H/18Cjb8sqRo/Pm+QC2KO4bFJSczLLUov07RK4Mq7+
        WsFScI+1Yvej8ywNjCdZuhg5OSQETCTOf+lh7WLk4hAS2M0o8XfdFnaIhIzE8md9bBC2sMT9
        liNQRe8ZJX6cPgVWxCagLfF9/WKwhIjAYiaJN90PwRxmgYuMEif+XAGrEgba8ePOc0YQm0VA
        VaJxZQPYWF4BO4n99/tZIVbIS6zecIB5AiPPAkaGVYySqQXFuem5xYYFRnmp5XrFibnFpXnp
        esn5uZsYwcGopbWDcc+qD3qHGJk4GA8xSnAwK4nwfl+1KUWINyWxsiq1KD++qDQntfgQozQH
        i5I477fXvSlCAumJJanZqakFqUUwWSYOTqkGJvlND04q/pU8eKWEQ88n6U0md/jLnTVv41/r
        uZy+JyghsG7eLMW2BflP+6vPSUhsynDxV7Ri0AjovDnplfvvgOvnDA9NWbd47V/Xl0/l9z6Q
        WBIj9sCzO8/7rWR43Vdx1ZSJjhfPn5teYR5yY+3TKQsd2hd0SWicn16l2nz0T5rPjLlvJ/bO
        Pvb5yeSFC2ceNzbxWvg/13v9+V8fJTfPnrazKP549IHnD3+uVtvy23Oxi+2Sz69kxL86z/q5
        QP9K3sdj3sHLbvKf3c73sOPet2mmsz6rh5kci1CwlI3ZF+ixYc2WrrluesKRv32NauXCT8kt
        Uqi6e2zLA+sd0z+ZSYvGvr164+zBiW6eASFmSTp7lFiKMxINtZiLihMBr+rCjbUCAAA=
X-CMS-MailID: 20230718034723epcas2p4f50be7f8669579b6e37e50516dee5ae1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230718034723epcas2p4f50be7f8669579b6e37e50516dee5ae1
References: <CGME20230718034723epcas2p4f50be7f8669579b6e37e50516dee5ae1@epcas2p4.samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pwm nodes to support PWM fan on exynosautov9-sadk board.

---
Changes in v5:
 - change const to enum in dt-bindings document
 - remove comment for exynosautov9

Changes in v4:
 - add document file.

Changes in v3:
 - removed adding compatible to driver.

Changes in v2:
 - add compatible string to driver.


Jaewon Kim (2):
  dt-bindings: pwm: samsung: add exynosautov9 compatible
  arm64: dts: exynos: add pwm node for exynosautov9-sadk

 .../devicetree/bindings/pwm/pwm-samsung.yaml    | 17 +++++++++++------
 .../arm64/boot/dts/exynos/exynosautov9-sadk.dts |  6 ++++++
 arch/arm64/boot/dts/exynos/exynosautov9.dtsi    | 10 ++++++++++
 3 files changed, 27 insertions(+), 6 deletions(-)

-- 
2.17.1

