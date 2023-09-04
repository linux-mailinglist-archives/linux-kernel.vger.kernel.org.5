Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DED1791097
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 06:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351653AbjIDE0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 00:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230403AbjIDE0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 00:26:11 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEABF102
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 21:26:07 -0700 (PDT)
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230904042605epoutp01924000bc5e694d0d6f01aab561038d50~Bl4zIR1Ij2508125081epoutp01b
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 04:26:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230904042605epoutp01924000bc5e694d0d6f01aab561038d50~Bl4zIR1Ij2508125081epoutp01b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1693801565;
        bh=OSy5o9yX85w5RQCPwAL+giA9DSBSLLh+5TEdeJJKcaw=;
        h=From:To:Cc:Subject:Date:References:From;
        b=qdwTjDwnRRG9qoat/FV5LIRKBX+R5642zisXHExBBMisnjamDOKzjufC7mgXvggVX
         zEJ1PoAHu6l+l4nQjWaTkGCdYoC6roeJUaaRRyV4nDO0ljyUIIeqKii0brpMoN8FD6
         2T4ChNwIn+2KeCX6RmJeARo/33FbOUO1TTafHNQU=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230904042605epcas1p10333c599d6327646552f97e5a7d53e17~Bl4ynce752952229522epcas1p1g;
        Mon,  4 Sep 2023 04:26:05 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.36.134]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4RfFv00XnXz4x9Q7; Mon,  4 Sep
        2023 04:26:04 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        BB.D5.10012.B5C55F46; Mon,  4 Sep 2023 13:26:03 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20230904042603epcas1p40f732a0ac7871371126d229945cc0849~Bl4xG1t4P1347613476epcas1p4T;
        Mon,  4 Sep 2023 04:26:03 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230904042603epsmtrp24abae42dd979b0b36f1d697465a82f59~Bl4xEIMdD0179101791epsmtrp2G;
        Mon,  4 Sep 2023 04:26:03 +0000 (GMT)
X-AuditID: b6c32a35-50fff7000000271c-0a-64f55c5b8c57
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        06.1A.08742.B5C55F46; Mon,  4 Sep 2023 13:26:03 +0900 (KST)
Received: from mediaserver.. (unknown [10.113.111.131]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230904042603epsmtip1dd79326365cf6747ba5b3ce823db0b4f~Bl4w0Rkjl1856018560epsmtip1e;
        Mon,  4 Sep 2023 04:26:03 +0000 (GMT)
From:   Kwanghoon Son <k.son@samsung.com>
To:     p.zabel@pengutronix.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jszhang@kernel.org, guoren@kernel.org, wefu@redhat.com,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, inki.dae@samsung.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [RFC PATCH 0/3] Introduce reset driver for T-HEAD th1520 SoC
Date:   Mon,  4 Sep 2023 04:25:56 +0000
Message-Id: <20230904042559.2322997-1-k.son@samsung.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBJsWRmVeSWpSXmKPExsWy7bCmgW50zNcUg2VfbSy2/p7FbrFm7zkm
        i/lHzrFavNjbyGIx6f4EFovmY+vZLPpePGS2uLxrDpvFts8tbBZ3751gsXh5uYfZom0Wv0Xr
        3iPsFi37p7A48Hm8efmSxeNwxxd2j02rOtk87lzbw+axeUm9R/9fA4/3+66yefRtWcXocan5
        OrvH501yAVxR2TYZqYkpqUUKqXnJ+SmZeem2St7B8c7xpmYGhrqGlhbmSgp5ibmptkouPgG6
        bpk5QPcrKZQl5pQChQISi4uV9O1sivJLS1IVMvKLS2yVUgtScgpMC/SKE3OLS/PS9fJSS6wM
        DQyMTIEKE7IzfnxtZi+YwF1xfelPpgbGExxdjJwcEgImEoueXmPqYuTiEBLYwSjR0D2fFSQh
        JPCJUeLDOheIxDdGiesLf7DBdCx5/40NIrGXUWLazWvsEM4bRonlZ/Yyg1SxCahLLGlbC5YQ
        EfjPKPHmTysTSIJZIF7ixLVzYEXCAq4SLz//BdvHIqAqMfPjOhYQm1fAQuJE6zRmiHXyEvsP
        nmWGiAtKnJz5hAVijrxE89bZzCALJASWckhc2j6NEaLBReLZxY3sELawxKvjW6BsKYnP7/ZC
        /ZAtcfQjjF0icX3WIlYI21hi/9LJQIdyAC3QlFi/Sx8irCix8/dcRoi9fBLvvvawgpRICPBK
        dLQJQZjyErc6yyGqRSXOPP0INdxDYv+d+UyQEI2VWP7iH9MERvlZSJ6ZheSZWQh7FzAyr2IU
        Sy0ozk1PLTYsMIRHanJ+7iZGcBLWMt3BOPHtB71DjEwcjIcYJTiYlUR45bQ/pQjxpiRWVqUW
        5ccXleakFh9iNAUG70RmKdHkfGAeyCuJNzSxNDAxMzI2sTA0M1QS52V+1JsiJJCeWJKanZpa
        kFoE08fEwSnVwHRt0lvbAyqlVV8uqXy4Oe3m2mVS22Wav62xVCkx18vqFRA4F7mznFejZqft
        GiUre6vMM8b3ldl8+q4XS9741pIQwfKQo336vWu+K9aJbDtc3GD59tyBZI7a+9FBOWwHfIsV
        lBlm3KjLjr359uBtba4jL/KahU8nXb98allV3j55h3d/fx14fbqm8dw77dU7Ii+d25jxz3el
        nbQPo0S8V8tzrisR8g0snAcvMq7p8Fw7Uft18J+9m9r383If4DzBlnUiYF29ybGyFQ/mVpfF
        bgjVzdeOD59/UbHFy+b82U0aLwy8Y19kq/BVtW6f92irxL5wp78/ugstYvYL7nFZcr8j8ZxE
        Q/v3Pz8/iWyRVFNiKc5INNRiLipOBAA1tvkVSwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBLMWRmVeSWpSXmKPExsWy7bCSnG50zNcUg7ObZS22/p7FbrFm7zkm
        i/lHzrFavNjbyGIx6f4EFovmY+vZLPpePGS2uLxrDpvFts8tbBZ3751gsXh5uYfZom0Wv0Xr
        3iPsFi37p7A48Hm8efmSxeNwxxd2j02rOtk87lzbw+axeUm9R/9fA4/3+66yefRtWcXocan5
        OrvH501yAVxRXDYpqTmZZalF+nYJXBk/vjazF0zgrri+9CdTA+MJji5GTg4JAROJJe+/sXUx
        cnEICexmlJh64gUzREJUouNyI2MXIweQLSxx+HAxRM0rRon5fa2sIDVsAuoSS9rWsoMkRAR6
        mSQ+fFzCBJJgFkiU2PL1NdggYQFXiZef/4I1sAioSsz8uI4FxOYVsJA40ToNapm8xP6DZ5kh
        4oISJ2c+YYGYIy/RvHU28wRGvllIUrOQpBYwMq1ilEwtKM5Nzy02LDDMSy3XK07MLS7NS9dL
        zs/dxAiODC3NHYzbV33QO8TIxMF4iFGCg1lJhFdO+1OKEG9KYmVValF+fFFpTmrxIUZpDhYl
        cV7xF70pQgLpiSWp2ampBalFMFkmDk6pBqb2xrVVWXNap+3Z9u/+hnVxIQWKiSWnzXXvL5Ji
        O12lI7Qm68G81TcKrh2J5V1Wev+TxDPmg4pccgd2Xy/+dS0yy0rI7nLFmi+yh5Y5KCql6/w8
        yqp1wdY8QZ3zypaUBbOmFxj/ZDpyl2f771lfxHcqhhXtczrutlmhcEtBlZXMrdyTMhbFPFvc
        losmbVllH881MzZFMuHorNMxBQ+6XvfeizkWXH1UX1En00X1m4x0nNShCfEa6xojTnfW2mm2
        3Pbfv31FYpbZm6arjFyT1xrcvKu4qlz17Zdcy2dXJgdMsF0lUXrYmNU1VPeC2JHwTzHZq9Rt
        ePLPBN93l/lqsuPBt5sxXgVXL/3jMTW/YqrEUpyRaKjFXFScCAAQxPSu+wIAAA==
X-CMS-MailID: 20230904042603epcas1p40f732a0ac7871371126d229945cc0849
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230904042603epcas1p40f732a0ac7871371126d229945cc0849
References: <CGME20230904042603epcas1p40f732a0ac7871371126d229945cc0849@epcas1p4.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds initial support for reset driver.
Register information is from vendor kernel [1].
I sent an e-mail to get permission the original author,
but there was no answer. So I upload patch since it has GPL license.

This patch also can be tested with watchdog simply with 
```
		watchdog0: watchdog@ffefc30000 {
			compatible = "snps,dw-wdt";
			reg = <0xff 0xefc30000 0x0 0x1000>;
			interrupts = <24 IRQ_TYPE_LEVEL_HIGH>;
			clocks = <&osc>;
			resets = <&rst TH1520_RESET_WDT0>;
			status = "disabled";
		};
```

[1] https://github.com/revyos/thead-kernel.git

Kwanghoon Son (3):
  dt-bindings: reset: Document th1520 reset control
  reset: Add th1520 reset driver support
  riscv: dts: Add th1520 reset device tree

 .../bindings/reset/thead,th1520-reset.yaml    |  39 +++++++
 .../dts/thead/th1520-lichee-module-4a.dtsi    |   4 +
 arch/riscv/boot/dts/thead/th1520.dtsi         |   8 ++
 drivers/reset/Kconfig                         |  10 ++
 drivers/reset/Makefile                        |   1 +
 drivers/reset/reset-th1520.c                  | 109 ++++++++++++++++++
 include/dt-bindings/reset/th1520-reset.h      |   9 ++
 7 files changed, 180 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/thead,th1520-reset.yaml
 create mode 100644 drivers/reset/reset-th1520.c
 create mode 100644 include/dt-bindings/reset/th1520-reset.h

-- 
2.34.1

