Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D9BA77B85E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 14:12:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbjHNMLz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 08:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233227AbjHNMLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 08:11:25 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2668DED
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 05:11:22 -0700 (PDT)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230814121119epoutp0413629f124fefcc12d0ae8665c6d0d4e9~7PsAD8dtZ0997909979epoutp04V
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 12:11:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230814121119epoutp0413629f124fefcc12d0ae8665c6d0d4e9~7PsAD8dtZ0997909979epoutp04V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1692015079;
        bh=Rjr03Bu9FUZKm0+7wnZqblJfU3eVTmIM2z74hNt1NMk=;
        h=From:To:Cc:Subject:Date:References:From;
        b=DCrUi2XnKzpTjLmno9kAKmm952SuRrseMraBc7PDohV4PM91Rkn7z9NAxRYGvdQfI
         p6a9JSK1ZbBMv0cntq36sTk4A+aF+6+u/RuAcckrmpsts95O0dLdNkEf02VLDAYOzp
         t2Vuuu1WmLJQ4jIQ2byNcM8cw5R82Gs4mipPcoeU=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20230814121118epcas5p2d26ea99d26a5aca2b3f970953f5aaf14~7Pr-Al46s0418204182epcas5p2a;
        Mon, 14 Aug 2023 12:11:18 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.180]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4RPYCS47sZz4x9Pq; Mon, 14 Aug
        2023 12:11:16 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        81.35.06099.4E91AD46; Mon, 14 Aug 2023 21:11:16 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20230814112600epcas5p49fe29a3ef85e2b0158f5ee3426652fc8~7PEb58t_81173811738epcas5p4K;
        Mon, 14 Aug 2023 11:26:00 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230814112600epsmtrp2440213a1a0d8e8a47d1792869822f6ea~7PEb43_sX1292612926epsmtrp2e;
        Mon, 14 Aug 2023 11:26:00 +0000 (GMT)
X-AuditID: b6c32a4b-d308d700000017d3-95-64da19e41ab2
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        C8.1E.34491.84F0AD46; Mon, 14 Aug 2023 20:26:00 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
        [107.109.115.53]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230814112557epsmtip2c503164ab25b1a49fb5615ebe8560f40~7PEY6bUNw0830008300epsmtip2I;
        Mon, 14 Aug 2023 11:25:57 +0000 (GMT)
From:   Sriranjani P <sriranjani.p@samsung.com>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        richardcochran@gmail.com, alexandre.torgue@foss.st.com,
        joabreu@synopsys.com, mcoquelin.stm32@gmail.com,
        alim.akhtar@samsung.com, linux-fsd@tesla.com,
        pankaj.dubey@samsung.com, swathi.ks@samsung.com,
        ravi.patel@samsung.com
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sriranjani P <sriranjani.p@samsung.com>
Subject: [PATCH v3 0/4] net: stmmac: dwc-qos: Add FSD EQoS support
Date:   Mon, 14 Aug 2023 16:55:35 +0530
Message-Id: <20230814112539.70453-1-sriranjani.p@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPJsWRmVeSWpSXmKPExsWy7bCmpu4TyVspBt+XS1v8fDmN0eLBvG1s
        Fmv2nmOymHO+hcVi/pFzrBZPjz1it7i36B2rRd+Lh8wWF7b1sVpsenyN1eLhq3CLy7vmsFnM
        OL+PyWLe37WsFscWiFl8O/2G0WLR1i/sFg8/7GG3OHLmBbNF694j7Ba336xjtfiy8Sa7g5jH
        lpU3mTye9m9l99g56y67x4JNpR6bVnWyedy5tofNY/OSeo/3+66yefRtWcXosWX/Z0aPf01z
        2T0+b5IL4InKtslITUxJLVJIzUvOT8nMS7dV8g6Od443NTMw1DW0tDBXUshLzE21VXLxCdB1
        y8wBelhJoSwxpxQoFJBYXKykb2dTlF9akqqQkV9cYquUWpCSU2BSoFecmFtcmpeul5daYmVo
        YGBkClSYkJ3x7el+1oKZXBUrJq5hbWDs4ehi5OSQEDCR2P/iH2sXIxeHkMBuRok7N8+zQTif
        GCXOzuxkgXC+MUrMfrSAEaZl9sxPTBCJvYwSp1bcgKpqZZL4sGIKK0gVm4CuROu1z2BVIgJt
        zBJrPk1hBkkwC5xhlOjbpwdiCws4SSxsOc8OYrMIqEpcnrQDbAWvgK3ElUPtUOvkJVZvOMAM
        MkhC4AKHxJkN95khEi4Snx5tZoewhSVeHd8CZUtJfH63lw3CTpfYfGQzK4SdI9HR1AzVay9x
        4MocoLM5gA7SlFi/Sx8iLCsx9dQ6Jog7+SR6fz9hgojzSuyYB2OrSSx+1Ally0isffQJaryH
        RNefxywgtpBArETzlNXsExhlZyFsWMDIuIpRMrWgODc9tdi0wDgvtRweVcn5uZsYwSlZy3sH
        46MHH/QOMTJxMB5ilOBgVhLh7eG9lSLEm5JYWZValB9fVJqTWnyI0RQYZhOZpUST84FZIa8k
        3tDE0sDEzMzMxNLYzFBJnPd169wUIYH0xJLU7NTUgtQimD4mDk6pBqaMic9ij0v0xYXXn+Br
        kOL+Ut3yirUsQaQi22Z65h8ldY0dWy2nhB/wDdr/pbD4iGrb/BBLr2ulNWd844yCnEPd88ze
        OezMbplh93VvWUla8URz3QVPLPmYuRNWzJ4YlPtYxuTS/a/rNrOm99WLb/YOn3LJbp1qEV/v
        M3tGXe9FV8slhTOKFHRm3Vt/2+hOXunVbdP+fpLs8GF8xz9Hkrlkw9PqkKVKUkqyZ9UyXVZ3
        ppW+Fli8h/OqJ1P9G6YvM2P+OlYay25LOhB8XY3hWDt391ph7fzJBUsXqKtf+bM/0UUmeM0d
        e8WVnHzebxPzirmd9lVLz17xeuG2Ta8zFKOkp9ctkA6a5eO8P9pNiaU4I9FQi7moOBEAfTgu
        5FIEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNLMWRmVeSWpSXmKPExsWy7bCSvK4H/60Ug2fLRC1+vpzGaPFg3jY2
        izV7zzFZzDnfwmIx/8g5Vounxx6xW9xb9I7Vou/FQ2aLC9v6WC02Pb7GavHwVbjF5V1z2Cxm
        nN/HZDHv71pWi2MLxCy+nX7DaLFo6xd2i4cf9rBbHDnzgtmide8Rdovbb9axWnzZeJPdQcxj
        y8qbTB5P+7eye+ycdZfdY8GmUo9NqzrZPO5c28PmsXlJvcf7fVfZPPq2rGL02LL/M6PHv6a5
        7B6fN8kF8ERx2aSk5mSWpRbp2yVwZXx7up+1YCZXxYqJa1gbGHs4uhg5OSQETCRmz/zE1MXI
        xSEksJtR4vTVxewQCRmJkw+WMEPYwhIr/z1nhyhqZpJYvmAOE0iCTUBXovXaZ7BuEYFZzBLz
        Jq9gBnGYBS4wSqy+cxesSljASWJhy3mwsSwCqhKXJ+1gBLF5BWwlrhxqZ4RYIS+xesMB5gmM
        PAsYGVYxSqYWFOem5xYbFhjmpZbrFSfmFpfmpesl5+duYgTHh5bmDsbtqz7oHWJk4mA8xCjB
        wawkwtvDeytFiDclsbIqtSg/vqg0J7X4EKM0B4uSOK/4i94UIYH0xJLU7NTUgtQimCwTB6dU
        A1NVcP7XLU/yhNpz121hu331tJL19l/vpmRPuh015SjDRU6Z7XsCi+407twV8Zo5/Gu66AYD
        k/8F6p29Dkc/yTq/O7rtEtO21mfzKz20LgS7K3p+nuAzIyn7SFhmUXTptZ/xyn1lV2ZYXeW4
        ns3HaOa7pUhNOet2+2SB42etFx54VbHU8t+PGzszM5fcvbpi4625Sis/n/7Ed7BZ79nq02/W
        /mgSTquQuZCyf8pPo97XE3RT1Jeum1k4f8HJKf6v2GZqa3149nYlu6+F1cdqrQPfQ3cw3l91
        YDV/c80uyYbGxTMNLuwwv+NmYnBv1rGJod/NVy2p7f/SNOl9hsbOXclfzz+PXue296VxA8v2
        R6l5R5RYijMSDbWYi4oTARAQ0CH+AgAA
X-CMS-MailID: 20230814112600epcas5p49fe29a3ef85e2b0158f5ee3426652fc8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230814112600epcas5p49fe29a3ef85e2b0158f5ee3426652fc8
References: <CGME20230814112600epcas5p49fe29a3ef85e2b0158f5ee3426652fc8@epcas5p4.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

FSD platform has two instances of EQoS IP, one is in FSYS0 block and
another one is in PERIC block. This patch series add required DT binding,
DT file modifications and platform driver specific changes for the same.

Changes since v2:
1. Addressed all the review comments suggested by Krzysztof with respect to
DT binding and DTS files.
2. Added SOB Swathi for her contributions in this patch.

Sriranjani P (4):
  dt-bindings: net: Add FSD EQoS device tree bindings
  net: stmmac: dwc-qos: Add FSD EQoS support
  arm64: dts: fsd: Add Ethernet support for FSYS0 Block of FSD SoC
  arm64: dts: fsd: Add Ethernet support for PERIC Block of FSD SoC

 .../devicetree/bindings/net/snps,dwmac.yaml   |   5 +-
 .../devicetree/bindings/net/tesla,ethqos.yaml | 114 ++++++++++++
 arch/arm64/boot/dts/tesla/fsd-evb.dts         |  18 ++
 arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi    | 112 ++++++++++++
 arch/arm64/boot/dts/tesla/fsd.dtsi            |  51 ++++++
 .../stmicro/stmmac/dwmac-dwc-qos-eth.c        | 172 ++++++++++++++++++
 .../net/ethernet/stmicro/stmmac/stmmac_main.c |  28 ++-
 include/linux/stmmac.h                        |   1 +
 8 files changed, 497 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/tesla,ethqos.yaml

-- 
2.17.1

