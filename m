Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 724A17DCA1D
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 10:51:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236279AbjJaJvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 05:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234969AbjJaJu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 05:50:58 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBB60186
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 02:50:36 -0700 (PDT)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20231031095018epoutp03da54319791a48e63beec9dbcd1c1c3db~TKFJTQAIh1184711847epoutp03W
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 09:50:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20231031095018epoutp03da54319791a48e63beec9dbcd1c1c3db~TKFJTQAIh1184711847epoutp03W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1698745818;
        bh=biM3/KVU/4+iEafliT3OuoOp8BvOTktRr3DK1804jIs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MKMVOREskarrRDiCfk/bEWEBfBjBr+jltfIvWAyPzFoLQbsE9lT+pPbQreW2fafUE
         HOiAxexh+2AjDoQUsgMnQin1oTZbAYIvlV+pNSesYdF8HP06SUYHTaJzWVft1exDtj
         rLQu1AixcRIRsML+0BKHg6ULrxXnMtEzVhWC/9K8=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20231031095017epcas2p15bd3689c9cbbd63aa60dec2132f77c6b~TKFIx-cPP2926329263epcas2p1D;
        Tue, 31 Oct 2023 09:50:17 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.69]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4SKQNn2rsyz4x9QC; Tue, 31 Oct
        2023 09:50:17 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        19.1E.10022.9DDC0456; Tue, 31 Oct 2023 18:50:17 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20231031095016epcas2p4d975f6a3647d24da606ef168c2b234cf~TKFH5baKK0808208082epcas2p4L;
        Tue, 31 Oct 2023 09:50:16 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20231031095016epsmtrp2b0f7e79b0b753366159565e03fcda9b9~TKFH4c5E41473914739epsmtrp26;
        Tue, 31 Oct 2023 09:50:16 +0000 (GMT)
X-AuditID: b6c32a47-9a3ff70000002726-28-6540cdd9ad6f
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        AF.32.07368.8DDC0456; Tue, 31 Oct 2023 18:50:16 +0900 (KST)
Received: from localhost.localdomain (unknown [10.229.9.55]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20231031095016epsmtip1b1a154a2af3f614110ff1b92841ca099~TKFHDuFjx2314323143epsmtip11;
        Tue, 31 Oct 2023 09:50:16 +0000 (GMT)
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
Subject: [PATCH 03/10] dt-bindings: serial: samsung: add exynosautov920-uart
 compatible
Date:   Tue, 31 Oct 2023 18:47:45 +0900
Message-ID: <20231031094852.118677-4-jaewon02.kim@samsung.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231031094852.118677-1-jaewon02.kim@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMJsWRmVeSWpSXmKPExsWy7bCmue7Nsw6pBi07hS0ezNvGZrFm7zkm
        i/lHzrFaNC9ez2axo+EIq8W7uTIWe19vZbeY8mc5k8Wmx9dYLTbP/8NocXnXHDaLu3dXMVrM
        OL+PyeLM4l52i9a9R9gtDr9pZ7X4uWsei8WqXUB1tydOZnQQ9tg56y67x6ZVnWwed67tYfPY
        P3cNu8fmJfUe/X8NPPq2rGL0+LxJLoAjKtsmIzUxJbVIITUvOT8lMy/dVsk7ON453tTMwFDX
        0NLCXEkhLzE31VbJxSdA1y0zB+gdJYWyxJxSoFBAYnGxkr6dTVF+aUmqQkZ+cYmtUmpBSk6B
        eYFecWJucWleul5eaomVoYGBkSlQYUJ2xtEN85kK5rJXLPrwm6mB8SFrFyMnh4SAicSLQ58Z
        uxi5OIQEdjBKXH+8hQnC+cQose7qflYI5xujRM/Cd+wwLU/vnmaDSOxllFhwaRaU85FR4uC/
        LmaQKjYBbYnv6xeDLRER+MIsMf1RNUgRs0A7k8S8by9ZQBLCApESfX0ngBo4OFgEVCUe/mID
        CfMK2EncmbkJapu8xJ5F35lAbE4Be4mdPU2MEDWCEidnPgEbwwxU07x1NjNE/QUOiXknrSFs
        F4nLs86xQdjCEq+Ob4GaKSXx+d1eqHi2RPv0P9DAqJC4uGE2VNxYYtazdkaQ05gFNCXW79IH
        MSUElCWO3ILayifRcfgvO0SYV6KjTQiiUU3i/lSYpTISk46sZIKwPSR2dN1kgYTUJEaJrjlf
        mCcwKsxC8swsJM/MQli8gJF5FaNYakFxbnpqsVGBMTyCk/NzNzGCU7eW+w7GGW8/6B1iZOJg
        PMQowcGsJMJ72NQhVYg3JbGyKrUoP76oNCe1+BCjKTCkJzJLiSbnA7NHXkm8oYmlgYmZmaG5
        kamBuZI4773WuSlCAumJJanZqakFqUUwfUwcnFINTCIzHkwSdroqfPJYAZ+Pz7Hv3ExXbitX
        99TcPfuTQ2x3z3P/p0F3fVM81f693zI7f2LJ2x5vYUMpExn/1Jx2u+K5zL3RMdIcTz5mv0+9
        dLlWxrJvQ/MLlY1aq71sDDM/xJUueOKnEuYiLlQioHsr5tXO7XeXT7m3+OzSgiPq0T3Pg61D
        eFfveTR7a9DzfefquN5WfNQx/901X+VqjpEhXxb7/aVti78mBaw+PquMLcsyVfqrMb/qnHSX
        FQzxb1r+/3wvVPTwM/va7vQgLwtpD678OWcKN3+TcLLZqnWvI/3YUtYk4a7ZUjwPJ2ac3s+T
        EezeGLtJ4/KqJ94y1znYLObXi22Ym58pJX7U78YRJZbijERDLeai4kQABjEfp2YEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnkeLIzCtJLcpLzFFi42LZdlhJTvfGWYdUg43TTC0ezNvGZrFm7zkm
        i/lHzrFaNC9ez2axo+EIq8W7uTIWe19vZbeY8mc5k8Wmx9dYLTbP/8NocXnXHDaLu3dXMVrM
        OL+PyeLM4l52i9a9R9gtDr9pZ7X4uWsei8WqXUB1tydOZnQQ9tg56y67x6ZVnWwed67tYfPY
        P3cNu8fmJfUe/X8NPPq2rGL0+LxJLoAjissmJTUnsyy1SN8ugSvj6Ib5TAVz2SsWffjN1MD4
        kLWLkZNDQsBE4und02xdjFwcQgK7GSX+HNvPBpGQkVj+rA/KFpa433KEFaLoPaNE69U/jCAJ
        NgFtie/rF4MlRAR+MUvsnnAXLMEs0M8kcX1TAogtLBAuce7dduYuRg4OFgFViYe/wIbyCthJ
        3Jm5iR1igbzEnkXfmUBsTgF7iZ09TWBjhIBqLm64yQRRLyhxcuYTFojx8hLNW2czT2AUmIUk
        NQtJagEj0ypGydSC4tz03GTDAsO81HK94sTc4tK8dL3k/NxNjOA409LYwXhv/j+9Q4xMHIyH
        GCU4mJVEeA+bOqQK8aYkVlalFuXHF5XmpBYfYpTmYFES5zWcMTtFSCA9sSQ1OzW1ILUIJsvE
        wSnVwHT+2rkrfUYSVo8O7z/z5uzK0ln8n6Zd0bpvc27DSa9K56tX/kf7Lo7+IOQk8N1cevmR
        Q4eC9jGckf3DNavh+NJ0O5cXYiaXhSK2Lpapcme/23VodqJunJRE5vxqmTUuEwvtrRueTYt0
        0LunysP98r+0pbbrt+tfTNq3xV+TSp8Wfsu4W/D6RuFvui5C0dFfZI+zL3Q+tGii09N3scEl
        bUeXeJyY0nxZkv3TpNyyPe7rXyhOF1b4ElDPECn9udBI6ov9V46Xz7R4+dKu+2idOXDRYZ/W
        sX13P7O2KPjnL176pciROTEn3a6twbVuNrtlIbedS27aEu+e9r171n+MjdDlaz9oq/rkaq79
        lzXSckosxRmJhlrMRcWJAIlR9JIiAwAA
X-CMS-MailID: 20231031095016epcas2p4d975f6a3647d24da606ef168c2b234cf
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231031095016epcas2p4d975f6a3647d24da606ef168c2b234cf
References: <20231031094852.118677-1-jaewon02.kim@samsung.com>
        <CGME20231031095016epcas2p4d975f6a3647d24da606ef168c2b234cf@epcas2p4.samsung.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add samsung,exynosautov9-uart dedicated compatible for representing
uart of ExynosAutoV920 SoC.

Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
---
 Documentation/devicetree/bindings/serial/samsung_uart.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/serial/samsung_uart.yaml b/Documentation/devicetree/bindings/serial/samsung_uart.yaml
index 8bd88d5cbb11..3e88722d0793 100644
--- a/Documentation/devicetree/bindings/serial/samsung_uart.yaml
+++ b/Documentation/devicetree/bindings/serial/samsung_uart.yaml
@@ -19,7 +19,9 @@ properties:
   compatible:
     oneOf:
       - items:
-          - const: samsung,exynosautov9-uart
+          - enum:
+              - samsung,exynosautov9-uart
+              - samsung,exynosautov920-uart
           - const: samsung,exynos850-uart
       - enum:
           - apple,s5l-uart
-- 
2.42.0

