Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 243927DCA0B
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 10:51:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235922AbjJaJvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 05:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235919AbjJaJuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 05:50:55 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3FA6101
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 02:50:35 -0700 (PDT)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20231031095021epoutp01b47a047f55abc00ff44edf0910ff3375~TKFMGRf_o1097110971epoutp01a
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 09:50:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20231031095021epoutp01b47a047f55abc00ff44edf0910ff3375~TKFMGRf_o1097110971epoutp01a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1698745821;
        bh=vGEJOjivthvr73BNxlMLKnpgeM8pqA65OJWYGei4FeM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YrFm12Li1bdzDZAUgKuDbl6lNZ5li6SI4RdpjIpPkuPKb8/Q/sMGFl8MeqMPIEauh
         TEl7nesV7jsfhWUohYsYBxpQdRDeuO9l70mEMjwb/gW2mmTGqqHIuAeid4nTBHftd5
         pryA/cMmccl3S3zwQznGylI6ao5hv0dJTzB6dSC0=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20231031095020epcas2p3716209af969fdb038c896e2f4e3ccbbe~TKFLfA8_e1121511215epcas2p3A;
        Tue, 31 Oct 2023 09:50:20 +0000 (GMT)
Received: from epsmgec2p1.samsung.com (unknown [182.195.36.102]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4SKQNr3fkWz4x9Px; Tue, 31 Oct
        2023 09:50:20 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmgec2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        59.12.08648.CDDC0456; Tue, 31 Oct 2023 18:50:20 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
        20231031095019epcas2p245cd178dad2d97ccb974a6ba44820a2a~TKFKsh8_h1547915479epcas2p2x;
        Tue, 31 Oct 2023 09:50:19 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20231031095019epsmtrp170ec2be3db381ec0453068732b15e2c9~TKFKrlA5h2510125101epsmtrp1o;
        Tue, 31 Oct 2023 09:50:19 +0000 (GMT)
X-AuditID: b6c32a43-721fd700000021c8-46-6540cddc1778
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        5F.11.08817.BDDC0456; Tue, 31 Oct 2023 18:50:19 +0900 (KST)
Received: from localhost.localdomain (unknown [10.229.9.55]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20231031095018epsmtip1d3da0103a188d3180b6f91ef2dbff660~TKFJoWlef2325323253epsmtip1p;
        Tue, 31 Oct 2023 09:50:18 +0000 (GMT)
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
Subject: [PATCH 06/10] dt-bindings: arm: samsung: Document exynosautov920
 SADK board binding
Date:   Tue, 31 Oct 2023 18:47:48 +0900
Message-ID: <20231031094852.118677-7-jaewon02.kim@samsung.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231031094852.118677-1-jaewon02.kim@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMJsWRmVeSWpSXmKPExsWy7bCmme6dsw6pBst2i1o8mLeNzWLN3nNM
        FvOPnGO1aF68ns1iR8MRVot3c2Us9r7eym4x5c9yJotNj6+xWmye/4fR4vKuOWwWd++uYrSY
        cX4fk8WZxb3sFq17j7BbHH7Tzmrxc9c8FotVu4Dqbk+czOgg7LFz1l12j02rOtk87lzbw+ax
        f+4ado/NS+o9+v8aePRtWcXo8XmTXABHVLZNRmpiSmqRQmpecn5KZl66rZJ3cLxzvKmZgaGu
        oaWFuZJCXmJuqq2Si0+ArltmDtA7SgpliTmlQKGAxOJiJX07m6L80pJUhYz84hJbpdSClJwC
        8wK94sTc4tK8dL281BIrQwMDI1OgwoTsjF0NZxgLPrJXnPg0jbmBcTlbFyMnh4SAicSelp8s
        XYxcHEICOxglXuy8xgbhfGKUuLr4FVTmG6PE2183WWBaVq+5AVW1l1Hi1PEjTBDOR0aJ5g8N
        YFVsAtoS39cvZgWxRQS+MEtMf1QNUsQs0M4kMe/bS7AiYYE4iXM3p7GD2CwCqhJ33z8HauDg
        4BWwk9i5WBdim7zEnkXfmUBsTgF7iZ09TYwgNq+AoMTJmU/AxjAD1TRvnc0MMl9C4AKHxJPt
        /1khml0kGpYfhLKFJV4d38IOYUtJvOxvg7KzJdqn/4GqqZC4uGE2NGSMJWY9a2cEuYdZQFNi
        /S59EFNCQFniyC2otXwSHYf/skOEeSU62oQgGtUk7k89BzVERmLSkZVMECUeEo8v2ENCahKj
        RFfPN/YJjAqzkDwzC8kzsxD2LmBkXsUollpQnJuemmxUYAiP4OT83E2M4NSt5byD8cr8f3qH
        GJk4GA8xSnAwK4nwHjZ1SBXiTUmsrEotyo8vKs1JLT7EaAoM6YnMUqLJ+cDskVcSb2hiaWBi
        ZmZobmRqYK4kznuvdW6KkEB6YklqdmpqQWoRTB8TB6dUAxNPmeTHkDWq75PVfp/+vj7suxKT
        rvCGyphPHelSQqqbql1YjI6/WuG6hGHi7do8kQkFfWUHAzW1Hu/7e39vIyfrFZOnZ+YWR38O
        z2SYwZuzvP6qYLXkJ279BZ/5s9Xa7ol/6ilKkp5xV+PMlim8X3N+KeRt/zJRd2XwlFNXTKxK
        nGUmVqi9UJfQ3jK3+LtXx3aGvcUlx6z9zNJ5Fi5fdWOGkj3nr7z5jOdfOnr86DirqTvpXdy8
        6ZGLjq+/9vO15m9VK7G1i+yCOR/fvbj/X+VDvyMte0TsNR+wtLRv6lui1xAjpZ+x5vHD2RNv
        qzM1PZl5QvH30/P8ffL2e2X89/5a6pmVqylc9OLpQYOy+W+UWIozEg21mIuKEwHJE3vDZgQA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnkeLIzCtJLcpLzFFi42LZdlhJTvf2WYdUg5t/jC0ezNvGZrFm7zkm
        i/lHzrFaNC9ez2axo+EIq8W7uTIWe19vZbeY8mc5k8Wmx9dYLTbP/8NocXnXHDaLu3dXMVrM
        OL+PyeLM4l52i9a9R9gtDr9pZ7X4uWsei8WqXUB1tydOZnQQ9tg56y67x6ZVnWwed67tYfPY
        P3cNu8fmJfUe/X8NPPq2rGL0+LxJLoAjissmJTUnsyy1SN8ugStjV8MZxoKP7BUnPk1jbmBc
        ztbFyMkhIWAisXrNDSCbi0NIYDejxM4F3xghEjISy5/1QRUJS9xvOcIKUfSeUeLao8UsIAk2
        AW2J7+sXgyVEBH4xS+yecBesm1mgn0ni+qYEEFtYIEZi56UbYA0sAqoSd98/B2rg4OAVsJPY
        uVgXYoG8xJ5F35lAbE4Be4mdPU1gY4SASi5uuAkW5xUQlDg58wkLxHh5ieats5knMArMQpKa
        hSS1gJFpFaNkakFxbnpusWGBUV5quV5xYm5xaV66XnJ+7iZGcJxpae1g3LPqg94hRiYOxkOM
        EhzMSiK8h00dUoV4UxIrq1KL8uOLSnNSiw8xSnOwKInzfnvdmyIkkJ5YkpqdmlqQWgSTZeLg
        lGpgmpW186nifjsJl9NGcTNky/0rnZxtJt3S+GJ0RNn5BdeqdHHF2/PvXdsae/6B3boHjI8S
        Hx1NvKKicpX9BKeCoajw2us/XxyfvsVR3XaZwqIFeWkX+iKmCXjUaAvaXdBvu2UptvW6XHyK
        5DoX83N+9e9yykIunWP+dnthtezi5evaX12xa+TwZCmsq0xZxDyzQUo1Pvqg5D3Ni3XtfznU
        i3eEbj0ccLMqySp+Rsn7uSG9JXv7Ypje6StbbzAO9b/PUNlmfLHw69XPswOyj25T2vGqkJPl
        1H3esuMf271UW1caNHb8PlRutSK3vtGN7cfylk1u9TMEtHXflPY76zCpiqbvjNE98n6jwFth
        aXslluKMREMt5qLiRACdeVROIgMAAA==
X-CMS-MailID: 20231031095019epcas2p245cd178dad2d97ccb974a6ba44820a2a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231031095019epcas2p245cd178dad2d97ccb974a6ba44820a2a
References: <20231031094852.118677-1-jaewon02.kim@samsung.com>
        <CGME20231031095019epcas2p245cd178dad2d97ccb974a6ba44820a2a@epcas2p2.samsung.com>
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

Add binding for the ExynosAutov920 SADK(Samsung Automotive Development Kit)
board.

Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
---
 .../devicetree/bindings/arm/samsung/samsung-boards.yaml     | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/samsung/samsung-boards.yaml b/Documentation/devicetree/bindings/arm/samsung/samsung-boards.yaml
index e3ffd8159ab6..01dcbd8aa703 100644
--- a/Documentation/devicetree/bindings/arm/samsung/samsung-boards.yaml
+++ b/Documentation/devicetree/bindings/arm/samsung/samsung-boards.yaml
@@ -230,6 +230,12 @@ properties:
               - samsung,exynosautov9-sadk   # Samsung Exynos Auto v9 SADK
           - const: samsung,exynosautov9
 
+      - description: Exynos Auto v920 based boards
+        items:
+          - enum:
+              - samsung,exynosautov920-sadk   # Samsung Exynos Auto v920 SADK
+          - const: samsung,exynosautov920
+
 required:
   - compatible
 
-- 
2.42.0

