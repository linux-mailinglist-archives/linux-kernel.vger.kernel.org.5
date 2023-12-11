Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C5A880C846
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 12:42:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234608AbjLKLmW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 06:42:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234323AbjLKLmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 06:42:16 -0500
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFED6CD
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 03:42:19 -0800 (PST)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20231211114217epoutp0308dfb940c735934c1af975579770e398~fxDoEPmbv0402204022epoutp03X
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 11:42:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20231211114217epoutp0308dfb940c735934c1af975579770e398~fxDoEPmbv0402204022epoutp03X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1702294937;
        bh=jQWQUWzPxv0uZIMSlUDxzoXSveqRH1BJkEWvhggSG8U=;
        h=From:To:Cc:Subject:Date:References:From;
        b=e2Qi4E25NnsyyUFuxCVneXcYU/VvfIQ/y/iAdxrGrHUgkpKLpFmHEF2BHgd3XJNnB
         wPqrrhpdgLj0yLcliFlYzJ4A0deP9rPKFWuwyV2mDgHD8oepqr7xh053QzFOCYghR2
         HfEk2GvyVCW1PHI/0G+k1BVzwp2kSgpAp98kRgXk=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20231211114216epcas2p32b0c575b4a632ca8f60d79ac4044d36d~fxDnaN8MU0911509115epcas2p3T;
        Mon, 11 Dec 2023 11:42:16 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.97]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4Spfx42dT7z4x9Q0; Mon, 11 Dec
        2023 11:42:16 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        A7.EB.09607.895F6756; Mon, 11 Dec 2023 20:42:16 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
        20231211114215epcas2p226d66c6dd01a4414559272c648c3d464~fxDmZiIUm2599425994epcas2p2Z;
        Mon, 11 Dec 2023 11:42:15 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20231211114215epsmtrp1bcbaa9b4d46762ba5dc2e2ab5f132274~fxDmXoM8-0416704167epsmtrp1W;
        Mon, 11 Dec 2023 11:42:15 +0000 (GMT)
X-AuditID: b6c32a48-bcdfd70000002587-b1-6576f598f8f1
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
        92.A9.18939.795F6756; Mon, 11 Dec 2023 20:42:15 +0900 (KST)
Received: from localhost.localdomain (unknown [10.229.9.55]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20231211114215epsmtip2b6acf38faa8291bbd2f8edc322642f1d~fxDmIqQr20289402894epsmtip2N;
        Mon, 11 Dec 2023 11:42:15 +0000 (GMT)
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
Subject: [PATCH v4 0/2] Introduce ExynosAutov920 SoC and SADK board
Date:   Mon, 11 Dec 2023 20:41:43 +0900
Message-ID: <20231211114145.106255-1-jaewon02.kim@samsung.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOJsWRmVeSWpSXmKPExsWy7bCmue6Mr2WpBsvO81k8mLeNzWLN3nNM
        FvOPnGO1aF68ns1iR8MRVot3c2Us9r7eym4x5c9yJotNj6+xWmye/4fR4vKuOWwWd++uYrSY
        cX4fk8WZxb3sFq17j7BbHH7Tzmrxc9c8FotVu4Dqbk+czOgg7LFz1l12j02rOtk87lzbw+ax
        f+4ado/NS+o9+v8aePRtWcXo8XmTXABHVLZNRmpiSmqRQmpecn5KZl66rZJ3cLxzvKmZgaGu
        oaWFuZJCXmJuqq2Si0+ArltmDtA7SgpliTmlQKGAxOJiJX07m6L80pJUhYz84hJbpdSClJwC
        8wK94sTc4tK8dL281BIrQwMDI1OgwoTsjEsfFjMXnOep2PO7j62BcTFXFyMnh4SAicS/3yuY
        uhi5OIQEdjBKLFi+jh3C+cQosfDcUyY4Z13ranaYlv/rrkNV7WSU+D/3AiuE85FRov3XESaQ
        KjYBbYnv6xezgtgiAveZJV63VYMUMQu0M0nM+/aSBSQhLOAs8artASOIzSKgKnH78HS2LkYO
        Dl4BO4n2uwIQ2+QlFu9Yzgxi8woISpyc+QSslRko3rx1NjPITAmBLRwSExc1MUE0uEgsXDOR
        DcIWlnh1fAvU2VISL/vboOx8ibYrZ6DsGomNCy4xQtj2EovO/GQHuYFZQFNi/S59EFNCQFni
        yC2otXwSHYf/skOEeSU62oQgGtUk7k89B7VURmLSkZVQx3hITGzYAdYqJBArsWXvKuYJjPKz
        kDwzC8kzsxD2LmBkXsUollpQnJueWmxUYAKP1OT83E2M4BSt5bGDcfbbD3qHGJk4GA8xSnAw
        K4nwyhwpThXiTUmsrEotyo8vKs1JLT7EaAoM3YnMUqLJ+cAskVcSb2hiaWBiZmZobmRqYK4k
        znuvdW6KkEB6YklqdmpqQWoRTB8TB6dUA9OSM2mPHWQU1TJrp+jmv3/kuC7Wds2HmuRNf24d
        3LZle/6eOLU7ly/oZhlZdi1z6VCaGjvtVsO8mJ4DIRNKc1nlbj7ffefY5R9bNso+Pb9WKHGW
        orT2PN4AqaOfK9y23XR+fqLezeDRgbnPEuq1He+wilhevjW5ZoJplMHU68ejdkwwT58uZavL
        05tx/NSamzvq/nn9WBf5MPXk8SpHB9nXlxi1C/S26zle1Lnv3OSzK+vpMofLE5fUsKgbbshb
        uq7Zx/qekrnF1zWKJrckeURucN72ChSfZrUx9LKH09FDlqclBAUueR5X5FgjHfhP2VHObCbb
        QZZvFV4P17rM7lu+ys3qlrezwxLPvxfOLDurxFKckWioxVxUnAgAZLnkB1oEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMLMWRmVeSWpSXmKPExsWy7bCSvO70r2WpBn/eaVk8mLeNzWLN3nNM
        FvOPnGO1aF68ns1iR8MRVot3c2Us9r7eym4x5c9yJotNj6+xWmye/4fR4vKuOWwWd++uYrSY
        cX4fk8WZxb3sFq17j7BbHH7Tzmrxc9c8FotVu4Dqbk+czOgg7LFz1l12j02rOtk87lzbw+ax
        f+4ado/NS+o9+v8aePRtWcXo8XmTXABHFJdNSmpOZllqkb5dAlfGpQ+LmQvO81Ts+d3H1sC4
        mKuLkZNDQsBE4v+66+xdjFwcQgLbGSVOXZ3IDJGQkVj+rI8NwhaWuN9yhBWi6D2jxLVHrWAJ
        NgFtie/rF4MlRASeM0uc/fMIrJtZoJ9J4vqmBBBbWMBZ4lXbA0YQm0VAVeL24elAzRwcvAJ2
        Eu13BSAWyEss3rEcrJVXQFDi5MwnLBBj5CWat85mnsDINwtJahaS1AJGplWMoqkFxbnpuckF
        hnrFibnFpXnpesn5uZsYwfGiFbSDcdn6v3qHGJk4GA8xSnAwK4nwyhwpThXiTUmsrEotyo8v
        Ks1JLT7EKM3BoiTOq5zTmSIkkJ5YkpqdmlqQWgSTZeLglGpg2jqtVl3ok1f2t00a2R6/zHhr
        gmJaorXTtp5WfSRrkdudnPPOWPtkZr78rl5GjawvH1wzlBnNWszyczX+cGb+nrXqgOPswF29
        p0tdNCpuJRzea/gg7IX4RLs9v55dNI+7vG6z3PELdRuWOfa0Z50X2lryPUoxecLrQ6b2LZxs
        gsEZdiZR+yNNA1RFHfap/TrP8uTdZvPz60JjC4V94tULf29i+HG+vNbi7tund36mrH38/Oye
        h6funyx7EPX65Magl62zL+xkXM/e0rvKsFtp30QD+ZCFC8043nJaneL28fvTmnN2H39v4JM/
        /XwlvRcynuv3Za61fnTZ6stby7mf/nyJqNau19lnukWjWumQEktxRqKhFnNRcSIAHm0J1QYD
        AAA=
X-CMS-MailID: 20231211114215epcas2p226d66c6dd01a4414559272c648c3d464
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231211114215epcas2p226d66c6dd01a4414559272c648c3d464
References: <CGME20231211114215epcas2p226d66c6dd01a4414559272c648c3d464@epcas2p2.samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ExynosAutov920[1] is ARMv8-based automotive-oriented SoC.
This SoC is the next generation of exynosautov9 and AE(Automotive Enhanced)
IPs are used for safety.

This patchset is the minimal set for ExynosAutov920 SoC and SADK board.
Currently, ramdisk console is available and Clock, UFS, and USI will be
added after this patchset.

[1] : https://semiconductor.samsung.com/processor/automotive-processor/exynos-auto-v920

---
Changes in v4:
 - Modify the comment for clear understanding
 - svc-related changes moved to exynosautov920 support patch
 - device-tree file merged in v3

Changes in v3:
 - Split pinctrl driver change patch and v920 support patch
 - Remove 'combine' variable and use offset variable
 - Fix coding style warning in checkpatch with --strict option
 - Fix CHECK_DTBS=y waring with W=1 option
 - dt-binding document merged in v2

Changes in v2:
 - Rebase to git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git
             branch : for-v6.8/samsung-bindings-compatibles
 - Specific exynosautov920 compatible
 - Add dt-binding patch for pmu, chipid


Jaewon Kim (2):
  pinctrl: samsung: support ExynosAuto GPIO structure
  pinctrl: samsung: add exynosautov920 pinctrl

 .../pinctrl/samsung/pinctrl-exynos-arm64.c    | 140 ++++++++++++++++++
 drivers/pinctrl/samsung/pinctrl-exynos.c      |  95 ++++++++++--
 drivers/pinctrl/samsung/pinctrl-exynos.h      |  25 ++++
 drivers/pinctrl/samsung/pinctrl-samsung.c     |   5 +
 drivers/pinctrl/samsung/pinctrl-samsung.h     |  13 ++
 5 files changed, 269 insertions(+), 9 deletions(-)

-- 
2.43.0

