Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADC47809D79
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 08:50:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573334AbjLHHuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 02:50:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573294AbjLHHuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 02:50:22 -0500
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38390171F
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 23:50:24 -0800 (PST)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20231208075021epoutp01a2b5e6b1d8f36762c1c76780338517f7~ey9ROYtNe0145101451epoutp01Q
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 07:50:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20231208075021epoutp01a2b5e6b1d8f36762c1c76780338517f7~ey9ROYtNe0145101451epoutp01Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1702021821;
        bh=qjbIaClF8yopZN8015RmaLZ6gHoakv4UFGRQz8iXfWk=;
        h=From:To:Cc:Subject:Date:References:From;
        b=OEQKhaWS+MDNq7cni8S6nTKXwK0ebT2NdV/h/A7COTmm5h0XRtTJJuII0bc6g1BHe
         vVazIBZ7ZXv3aTCs3gplcdVZMRdpHOX2dlL4CPmC6JNxex8w48ZiFN8lItkGy0XUnc
         BDlC/snh49nnk4sZh6omN/b/BeClr4MFHJCU159U=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20231208075021epcas2p17b86ea1164128f3701a9151fe832dc1d~ey9QnzfO70844008440epcas2p1W;
        Fri,  8 Dec 2023 07:50:21 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.89]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4Smjwr4Hzwz4x9Q0; Fri,  8 Dec
        2023 07:50:20 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        34.D3.10006.CBAC2756; Fri,  8 Dec 2023 16:50:20 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20231208075019epcas2p4cef1190e41adeaaf47b7763cc86c3d26~ey9PZThlO1013010130epcas2p4p;
        Fri,  8 Dec 2023 07:50:19 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20231208075019epsmtrp25d9a523bfebdf6abd2feadc9931e8c3a~ey9PXkPcB0096800968epsmtrp2R;
        Fri,  8 Dec 2023 07:50:19 +0000 (GMT)
X-AuditID: b6c32a45-3ebfd70000002716-79-6572cabc38c2
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        52.00.07368.BBAC2756; Fri,  8 Dec 2023 16:50:19 +0900 (KST)
Received: from localhost.localdomain (unknown [10.229.9.55]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20231208075019epsmtip259e371d900c1f9bba436b2999f5c312e~ey9PFghTm1345613456epsmtip2f;
        Fri,  8 Dec 2023 07:50:19 +0000 (GMT)
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
Subject: [PATCH v3 0/4] Introduce ExynosAutov920 SoC and SADK board
Date:   Fri,  8 Dec 2023 16:45:23 +0900
Message-ID: <20231208074527.50840-1-jaewon02.kim@samsung.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOJsWRmVeSWpSXmKPExsWy7bCmqe6eU0WpBjNuylk8mLeNzWLN3nNM
        FvOPnGO1aF68ns1iR8MRVot3c2Us9r7eym4x5c9yJotNj6+xWmye/4fR4vKuOWwWd++uYrSY
        cX4fk8WZxb3sFq17j7BbHH7Tzmrxc9c8FotVu4Dqbk+czOgg7LFz1l12j02rOtk87lzbw+ax
        f+4ado/NS+o9+v8aePRtWcXo8XmTXABHVLZNRmpiSmqRQmpecn5KZl66rZJ3cLxzvKmZgaGu
        oaWFuZJCXmJuqq2Si0+ArltmDtA7SgpliTmlQKGAxOJiJX07m6L80pJUhYz84hJbpdSClJwC
        8wK94sTc4tK8dL281BIrQwMDI1OgwoTsjPWTF7EWfOaveHzlC0sDYxdvFyMnh4SAicS9TzPY
        uxi5OIQEdjBKzFz6kwkkISTwiVHi810tiMQ3Rokdsw+ywHRMvLoNqmMvo8Sa3W+hnI+MEusf
        rmEDqWIT0Jb4vn4xK4gtInCfWeJ1WzVIEbNAO5PEvG8vwUYJCzhLnF/cBGazCKhKzF16CGw3
        r4CtxJdrJ5kh1slLLN6xnBkiLihxcuYTsHpmoHjz1tnMIEMlBPZwSFxs2gF1n4vEj7OH2SFs
        YYlXx7dA2VISn9/tZYOw8yXarpyBitdIbFxwiRHCtpeY9XsL0NUcQAs0Jdbv0gcxJQSUJY7c
        glrLJ9Fx+C87RJhXoqNNCKJRTeL+1HNQw2UkJh1ZyQRhe0hsfN7ADAnRWIm+NRdZJjDKz0Ly
        zCwkz8xC2LuAkXkVo1hqQXFuemqxUYEhPFKT83M3MYJTtJbrDsbJbz/oHWJk4mA8xCjBwawk
        wptzPj9ViDclsbIqtSg/vqg0J7X4EKMpMHgnMkuJJucDs0ReSbyhiaWBiZmZobmRqYG5kjjv
        vda5KUIC6YklqdmpqQWpRTB9TBycUg1Mp5WqbszaZfN5kcAW9yQ28Y1Z6RpTSnd9U82STWiJ
        lNw16cTLaa+/i6xLtm3e/+dVQWaQ3rG/K2uE08o3ujd9bPsnGHrt1mZVkSbfFxbfGbZUXHzi
        ets2r1zy071tVvpLL80VOzPvYsvt8niuuaxXTZrrj++bWNxsvMrg+oZUh9vfL/79cdrMlFuL
        9/29nWWpcy/+K9c8vE20v9+u4nuY5eXr9zav2K695pVh+ozdD72UO+O+B8oo67KsdHdiuHD7
        +qL9M6c9yLUUW3ZZOlHonHjliWm7dBmTV0RXqMkvZLvUNPNfede0uayeEvYbZK6WvbtZ4Vnn
        uqpm3vw9Cekfj1t1BNxhuHSs+06PyybeEiWW4oxEQy3mouJEAD5WIXFaBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOLMWRmVeSWpSXmKPExsWy7bCSvO7uU0WpBne26Fk8mLeNzWLN3nNM
        FvOPnGO1aF68ns1iR8MRVot3c2Us9r7eym4x5c9yJotNj6+xWmye/4fR4vKuOWwWd++uYrSY
        cX4fk8WZxb3sFq17j7BbHH7Tzmrxc9c8FotVu4Dqbk+czOgg7LFz1l12j02rOtk87lzbw+ax
        f+4ado/NS+o9+v8aePRtWcXo8XmTXABHFJdNSmpOZllqkb5dAlfG+smLWAs+81c8vvKFpYGx
        i7eLkZNDQsBEYuLVbexdjFwcQgK7GSX+7lnDBJGQkVj+rI8NwhaWuN9yhBXEFhJ4zygxdYke
        iM0moC3xff1iVpBmEYHnzBJn/zxiBkkwC/QzSVzflABiCws4S5xf3MQCYrMIqErMXXoIbAGv
        gK3El2snmSEWyEss3rGcGSIuKHFy5hMWiDnyEs1bZzNPYOSbhSQ1C0lqASPTKkbJ1ILi3PTc
        ZMMCw7zUcr3ixNzi0rx0veT83E2M4LjR0tjBeG/+P71DjEwcjIcYJTiYlUR4c87npwrxpiRW
        VqUW5ccXleakFh9ilOZgURLnNZwxO0VIID2xJDU7NbUgtQgmy8TBKdXAJK+0pGhi8uP4AJGc
        zhq51domG889eLmufK+z0z6xp/WSyQHFpxfZ2680lb52Wk3sYOzuW8bd3cEhE12u7dHJ4i/i
        sRfXaqgymCR5M/Pp1NA7isLMWuI39OfofCsXuzB3BdeaXQGaP24k7TqykrNTi9N1h+p7MZuv
        SjOP3o2PTs1tfMC+/Mm7oEPRJwUu+9gBvTh530zjlX7qdyYz9YaU/TzT9fD00Xmc+0LWam6v
        ZY71XPRTn/OM+4EfG/Y/2NZwxq6+/OVBcZdnRlXfGX2EPn8MmeNZv/Pp8jJ+ftacWUoLKxIl
        nJ7KP7opadf+0vZnbekOm0TJKbvdb99m//lRY+kfhquvWWWFS1zKfx9UYinOSDTUYi4qTgQA
        rDUZbAoDAAA=
X-CMS-MailID: 20231208075019epcas2p4cef1190e41adeaaf47b7763cc86c3d26
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231208075019epcas2p4cef1190e41adeaaf47b7763cc86c3d26
References: <CGME20231208075019epcas2p4cef1190e41adeaaf47b7763cc86c3d26@epcas2p4.samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
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
Changes in v3:
 - Split pinctrl driver change patch  and v920 support patch
 - Remove 'combine' variable and use offset variable
 - Fix coding style warning in checkpatch with --strict option
 - Fix CHECK_DTBS=y waring with W=1 option
 - dt-binding document merged in v2

Changes in v2:
 - Rebase to git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git
             branch : for-v6.8/samsung-bindings-compatibles
 - Specific exynosautov920 compatible
 - Add dt-binding patch for pmu, chipid


Jaewon Kim (4):
  arm64: dts: exynos: add initial support for exynosautov920 SoC
  arm64: dts: exynos: add minimal support for exynosautov920 sadk board
  pinctrl: samsung: support ExynosAuto GPIO structure
  pinctrl: samsung: add exynosautov920 pinctrl

 arch/arm64/boot/dts/exynos/Makefile           |    3 +-
 .../dts/exynos/exynosautov920-pinctrl.dtsi    | 1266 +++++++++++++++++
 .../boot/dts/exynos/exynosautov920-sadk.dts   |   88 ++
 .../arm64/boot/dts/exynos/exynosautov920.dtsi |  314 ++++
 .../pinctrl/samsung/pinctrl-exynos-arm64.c    |  140 ++
 drivers/pinctrl/samsung/pinctrl-exynos.c      |   99 +-
 drivers/pinctrl/samsung/pinctrl-exynos.h      |   25 +
 drivers/pinctrl/samsung/pinctrl-samsung.c     |    5 +
 drivers/pinctrl/samsung/pinctrl-samsung.h     |   13 +
 9 files changed, 1945 insertions(+), 8 deletions(-)
 create mode 100644 arch/arm64/boot/dts/exynos/exynosautov920-pinctrl.dtsi
 create mode 100644 arch/arm64/boot/dts/exynos/exynosautov920-sadk.dts
 create mode 100644 arch/arm64/boot/dts/exynos/exynosautov920.dtsi

-- 
2.43.0

