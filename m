Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10BCC7DC9F9
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 10:50:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235764AbjJaJuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 05:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234961AbjJaJug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 05:50:36 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82AB810F
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 02:50:28 -0700 (PDT)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20231031095016epoutp024c5a000efb814cb1b6c84b7ffc1697da~TKFHwnuMM0884508845epoutp02D
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 09:50:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20231031095016epoutp024c5a000efb814cb1b6c84b7ffc1697da~TKFHwnuMM0884508845epoutp02D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1698745816;
        bh=glVb1GBTrXpzNDm/igCf/YJKyV1h94GC7Kd76VrQGQw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C5amZkEihEkji1pY1kc+P6u7URdEUnw8/CWzc6itBakCUG2ObYwcsCE8dpPAXZOWL
         avfiQA2XHoa2n1exGhcz1ebmLOpUUwIMuga7mbpcisq0g3lHzGQ8iP4Fo5TzHVs8ob
         YcVTfTIQTKvsC3t4qfzUH7eAzvDen9PW+0ypL9Go=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20231031095016epcas2p1723fd47179e4024ebbb47e1e13291c40~TKFHPH6If0993809938epcas2p1q;
        Tue, 31 Oct 2023 09:50:16 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.68]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4SKQNl6qmPz4x9Q7; Tue, 31 Oct
        2023 09:50:15 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        52.1E.10022.7DDC0456; Tue, 31 Oct 2023 18:50:15 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20231031095015epcas2p3cc52b365b99a00bef3f75bea38ea91e9~TKFGg4ZbE0127001270epcas2p3m;
        Tue, 31 Oct 2023 09:50:15 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20231031095015epsmtrp19337e914479ebfdaf9166842d6c6bdd7~TKFGe2qbE2510125101epsmtrp1c;
        Tue, 31 Oct 2023 09:50:15 +0000 (GMT)
X-AuditID: b6c32a47-bfdfa70000002726-25-6540cdd7eaa8
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        4E.32.07368.7DDC0456; Tue, 31 Oct 2023 18:50:15 +0900 (KST)
Received: from localhost.localdomain (unknown [10.229.9.55]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20231031095014epsmtip185964591a6a2111a9a4b1345ec95ce14~TKFFtCcXR1599915999epsmtip1Z;
        Tue, 31 Oct 2023 09:50:14 +0000 (GMT)
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
Subject: [PATCH 01/10] dt-bindings: soc: samsung: exynos-sysreg: add
 exynosautov920 sysreg
Date:   Tue, 31 Oct 2023 18:47:43 +0900
Message-ID: <20231031094852.118677-2-jaewon02.kim@samsung.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231031094852.118677-1-jaewon02.kim@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMJsWRmVeSWpSXmKPExsWy7bCmme71sw6pBnNXmlg8mLeNzWLN3nNM
        FvOPnGO1aF68ns1iR8MRVot3c2Us9r7eym4x5c9yJotNj6+xWmye/4fR4vKuOWwWd++uYrSY
        cX4fk8WZxb3sFq17j7BbHH7Tzmrxc9c8FotVu4Dqbk+czOgg7LFz1l12j02rOtk87lzbw+ax
        f+4ado/NS+o9+v8aePRtWcXo8XmTXABHVLZNRmpiSmqRQmpecn5KZl66rZJ3cLxzvKmZgaGu
        oaWFuZJCXmJuqq2Si0+ArltmDtA7SgpliTmlQKGAxOJiJX07m6L80pJUhYz84hJbpdSClJwC
        8wK94sTc4tK8dL281BIrQwMDI1OgwoTsjN47XYwFM7kqep/OYm9gvMjexcjBISFgIvHjmnQX
        IxeHkMAORokFm7YxQzifGCW2PPkK5XxjlLh0dxNTFyMnWMf0C0sZIRJ7GSXWtbeyQzgfGSUa
        179jAaliE9CW+L5+MSuILSLwhVli+qNqkCJmgXYmiXnfXoIVCQvESBzseM4GYrMIqErs/f2e
        FeQoXgE7iTXz7CC2yUvsWfQdbDOngL3Ezp4mRhCbV0BQ4uTMJ2BjmIFqmrfOBjtVQuAKh8Sz
        k+tZIJpdJJad2c8MYQtLvDq+hR3ClpJ42d8GZWdLtE//wwphV0hc3DCbDcI2lpj1rJ0R5B5m
        AU2J9bv0IeGlLHHkFtRaPomOw3+hwcgr0dEmBNGoJnF/6jmoITISk46shIabh0TPjD5ogE5i
        lPj27x3bBEaFWUi+mYXkm1kIixcwMq9iFEstKM5NTy02KjCGR3Byfu4mRnDq1nLfwTjj7Qe9
        Q4xMHIyHGCU4mJVEeA+bOqQK8aYkVlalFuXHF5XmpBYfYjQFBvVEZinR5Hxg9sgriTc0sTQw
        MTMzNDcyNTBXEue91zo3RUggPbEkNTs1tSC1CKaPiYNTqoEpx4dr1fSdjtfiA0NFqlfaWPwx
        5CvOeFvedVr9i7Se6tRJhu2vDkUa9XFanev6vdqs6J1DKedkLS/dstzTwfOO3bx89lJFK0es
        4uP7PHZ9nkpZ+ROev1o/P2qpxB6eUjmm4kcaTJ+vx8cri12X2F6RFsGwMOr1w8rfsh+55Vby
        MSyt6zVafSRtU4LcLs/lb1TMFP5N+DGlLsze/gjbK9ttE+sT7b7FiMfxPH+jl9D6T2Ka+6J3
        zkF1/q89UkunnRRL3FvN/vj3xnjvrA8hRQ/iljGsMq4s1AjwOh3w0ajzjfH5FJ4QCcfqmOdB
        fi/YPFY+P3bUl+lPGL/jP/EypwcOrFfmzbYTecffMPP3EyWW4oxEQy3mouJEAClaQTRmBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnkeLIzCtJLcpLzFFi42LZdlhJTvf6WYdUg63TRS0ezNvGZrFm7zkm
        i/lHzrFaNC9ez2axo+EIq8W7uTIWe19vZbeY8mc5k8Wmx9dYLTbP/8NocXnXHDaLu3dXMVrM
        OL+PyeLM4l52i9a9R9gtDr9pZ7X4uWsei8WqXUB1tydOZnQQ9tg56y67x6ZVnWwed67tYfPY
        P3cNu8fmJfUe/X8NPPq2rGL0+LxJLoAjissmJTUnsyy1SN8ugSuj904XY8FMrorep7PYGxgv
        sncxcnJICJhITL+wlLGLkYtDSGA3o8TOeY1QCRmJ5c/62CBsYYn7LUdYIYreM0ocmbwBLMEm
        oC3xff1isISIwC9mid0T7jKCJJgF+pkkrm9KALGFBaIkZvf/ApvKIqAqsff3e6AGDg5eATuJ
        NfPsIBbIS+xZ9J0JxOYUsJfY2dMENkYIqOTihptgcV4BQYmTM5+wQIyXl2jeOpt5AqPALCSp
        WUhSCxiZVjFKphYU56bnJhsWGOallusVJ+YWl+al6yXn525iBMeZlsYOxnvz/+kdYmTiYDzE
        KMHBrCTCe9jUIVWINyWxsiq1KD++qDQntfgQozQHi5I4r+GM2SlCAumJJanZqakFqUUwWSYO
        TqkGpg1hJrnp6//lTjql9vhky6Lvm9K3alywf/Vpe3xM+eO89xX5x+/98hEpPd0x/+mL36Yt
        22tuBlRWpPXOD3T3e3TPqnWpYEgro+mudZGGgUpZW2s+zBfWmL0jjGdbox/j5dmr1tyaqF90
        aXHtsV9vFC5eWqd5l91w9sofIrpNb6a/z9wh0+z7yr9misukcq5ZqSssIq0bg2+c8bJ6uzbq
        2FSpgMDAPZ1qcWkRp/N/P4zY9mKaacaCqtZj748s1Dte9qFA0KmuYvX+kKUng6XYbRV+hise
        X8d/5OwC/dDeTvP1K+clLZ8//8/1s3Psj2x7t+HNsSkHmddKvVmt/NF75tFn/ctOVszvNft5
        xUKVc52VEktxRqKhFnNRcSIAyAX7dyIDAAA=
X-CMS-MailID: 20231031095015epcas2p3cc52b365b99a00bef3f75bea38ea91e9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231031095015epcas2p3cc52b365b99a00bef3f75bea38ea91e9
References: <20231031094852.118677-1-jaewon02.kim@samsung.com>
        <CGME20231031095015epcas2p3cc52b365b99a00bef3f75bea38ea91e9@epcas2p3.samsung.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible for ExynosAutov920 sysreg controllers.

Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
---
 .../bindings/soc/samsung/samsung,exynos-sysreg.yaml        | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-sysreg.yaml b/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-sysreg.yaml
index 163e912e9cad..aa2a29ec6072 100644
--- a/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-sysreg.yaml
+++ b/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-sysreg.yaml
@@ -35,6 +35,7 @@ properties:
               - samsung,exynos5433-sysreg
               - samsung,exynos850-sysreg
               - samsung,exynosautov9-sysreg
+              - samsung,exynosautov920-sysreg
           - const: syscon
         deprecated: true
       - items:
@@ -50,6 +51,12 @@ properties:
               - samsung,exynosautov9-peric1-sysreg
           - const: samsung,exynosautov9-sysreg
           - const: syscon
+      - items:
+          - enum:
+              - samsung,exynosautov920-peric0-sysreg
+              - samsung,exynosautov920-peric1-sysreg
+          - const: samsung,exynosautov920-sysreg
+          - const: syscon
 
   reg:
     maxItems: 1
-- 
2.42.0

