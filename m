Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A888979C3F6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 05:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242711AbjILDTe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 23:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242545AbjILDTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 23:19:21 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9504944B6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 19:49:23 -0700 (PDT)
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230912024919epoutp0204db56a92e2a28517bf8ee77986ce858~EBulh7-TD2389023890epoutp02j
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 02:49:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230912024919epoutp0204db56a92e2a28517bf8ee77986ce858~EBulh7-TD2389023890epoutp02j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1694486959;
        bh=J3vjc1MlEpCgHPb593cMs7GqPe/HBS5l1vuBfQvuZz8=;
        h=From:To:Cc:Subject:Date:References:From;
        b=lF8cVIF9CoXgKA/xbrPOnXd+41Wi2+m2LDWBNwNcVKhaqpUW0Tl1stsGf/0/JkMZl
         TFWJKT2o+BWPtj4t5O+JQDNAe2FI93vrnUcXgTzjCSHmzjGw84f7B95QDGcIFpwOyc
         WwxmuLeVzZ7Szxcnf+593a27+ZEf0fFN1SjXaehM=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230912024918epcas1p1589fbca8bdfc6c1b60d5043cfca4163a~EBuk9zgfF0386603866epcas1p1e;
        Tue, 12 Sep 2023 02:49:18 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.36.136]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4Rl7Md4lHtz4x9Q0; Tue, 12 Sep
        2023 02:49:17 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        C6.29.09646.DA1DFF46; Tue, 12 Sep 2023 11:49:17 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230912024917epcas1p29a513dcf6019fb7c63275aa0e39b1c71~EBujusJ6v1134811348epcas1p2o;
        Tue, 12 Sep 2023 02:49:17 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230912024917epsmtrp2b7ecb178a158574f3b41766a81a29bf7~EBujtx6b31886418864epsmtrp2f;
        Tue, 12 Sep 2023 02:49:17 +0000 (GMT)
X-AuditID: b6c32a37-b23ff700000025ae-25-64ffd1ad372b
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        61.A7.08649.DA1DFF46; Tue, 12 Sep 2023 11:49:17 +0900 (KST)
Received: from mediaserver.. (unknown [10.113.111.131]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230912024916epsmtip1708e1d09b1c490385c9cbac2943f215a~EBujalbgJ0070800708epsmtip1f;
        Tue, 12 Sep 2023 02:49:16 +0000 (GMT)
From:   k.son@samsung.com
To:     p.zabel@pengutronix.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jszhang@kernel.org, guoren@kernel.org, wefu@redhat.com,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, inki.dae@samsung.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Kwanghoon Son <k.son@samsung.com>
Subject: [PATCH 0/3] Introduce reset driver for T-HEAD th1520 SoC
Date:   Tue, 12 Sep 2023 02:49:11 +0000
Message-Id: <20230912024914.3769440-1-k.son@samsung.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLJsWRmVeSWpSXmKPExsWy7bCmru7ai/9TDC63qFps/T2L3WLN3nNM
        FvOPnGO1eLG3kcVi0v0JLBbNx9azWfSuucpk0ffiIbPF5V1z2Cy2fW5hs7h77wSLxcvLPcwW
        bbP4LVr3HmG3aNk/hcWB3+PNy5csHoc7vrB7bFrVyeZx59oeNo/NS+o9+v8aeLzfd5XNo2/L
        KkaPS83X2T0+b5IL4IrKtslITUxJLVJIzUvOT8nMS7dV8g6Od443NTMw1DW0tDBXUshLzE21
        VXLxCdB1y8wBekJJoSwxpxQoFJBYXKykb2dTlF9akqqQkV9cYquUWpCSU2BaoFecmFtcmpeu
        l5daYmVoYGBkClSYkJ2x+Mdi1oI5PBX9B0QbGI9zdjFyckgImEg82vmTvYuRi0NIYAejxKlF
        d1khnE+MEofuz2aGcL4xSpxY1M8G03J11w4miMReRolnX4+yQDhvGCXeXpnKAlLFJiAu0Xlt
        JSNIQkTgP6PEmz+tYC3MAk2MErPbZoDNEhZwlPjy4T2YzSKgKrHkxHcwm1fAQmLPg04miH3y
        EvsPnmWGiAtKnJz5BGwDM1C8eSvEgRICazkkDiybww7R4CKxaPErqGOFJV4d3wIVl5L4/G4v
        VDxb4uhHGLtE4vqsRawQtrHE/qWTgRZzAC3QlFi/Sx8irCix8/dcRoi9fBLvvvawgpRICPBK
        dLQJQZjyErc6yyGqRSXOPP0INdxD4s/JDcwgJUICsRLNV0MmMMrPQvLLLCS/zEJYu4CReRWj
        WGpBcW56arFhgTE8UpPzczcxgtOxlvkOxmlvP+gdYmTiYDzEKMHBrCTCW3Lob4oQb0piZVVq
        UX58UWlOavEhRlNg6E5klhJNzgdmhLySeEMTSwMTMyNjEwtDM0Mlcd5bz3pThATSE0tSs1NT
        C1KLYPqYODilGpgOnpUQu20/9zj3itWhr2dNtU/psuFXND/d+JDpbI9tfUfK8UrHRUIGHRsZ
        eXW8l0+6Pf122CObet7LafNk+mtDHPl3e1WL9F0slTRVvN7TdPPxRd8g0/s7LRqqLDU2ljTd
        nS/0adHumLSzC7bnHcpRW/1mkl3TPx+uSc68QfasZ49Ee+scXmYYYb2+IF5mzaoJvm0uqpt8
        Tb6bTrDWr95ae/hG0MwVzSqzJT7tZcj14i9efYDj0sOojOXB8aZ/W6c8sJ0z76Xou8jPhtdn
        bn83S4l7yqPL99ruZFYtiZVw7eTYEbkluzD8dt28DR5ibatTNiY+y3gW9uN7ywWJGKNWJ9YH
        iw4x8KgY/rPWVVJiKc5INNRiLipOBABV9yxiUAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLLMWRmVeSWpSXmKPExsWy7bCSnO7ai/9TDOY2cFps/T2L3WLN3nNM
        FvOPnGO1eLG3kcVi0v0JLBbNx9azWfSuucpk0ffiIbPF5V1z2Cy2fW5hs7h77wSLxcvLPcwW
        bbP4LVr3HmG3aNk/hcWB3+PNy5csHoc7vrB7bFrVyeZx59oeNo/NS+o9+v8aeLzfd5XNo2/L
        KkaPS83X2T0+b5IL4IrisklJzcksSy3St0vgylj8YzFrwRyeiv4Dog2Mxzm7GDk5JARMJK7u
        2sHUxcjFISSwm1Hi7+5rTBAJUYmOy42MXYwcQLawxOHDxRA1rxglfk24yAJSwyYgLtF5bSUj
        SEJEoJdJ4sPHJWCTmAXaGCVOfNjKDFIlLOAo8eXDezYQm0VAVWLJie9gNq+AhcSeB51Q2+Ql
        9h88ywwRF5Q4OfMJ2AZmoHjz1tnMExj5ZiFJzUKSWsDItIpRMrWgODc9N9mwwDAvtVyvODG3
        uDQvXS85P3cTIzhGtDR2MN6b/0/vECMTB+MhRgkOZiUR3pJDf1OEeFMSK6tSi/Lji0pzUosP
        MUpzsCiJ8xrOmJ0iJJCeWJKanZpakFoEk2Xi4JRqYHrQcOaPD//VpU7frt6IfCdnu5b/5slt
        8z6qeHNdCTwS915NNbksnXlNwY7SpLwfZW+cFGv28T69NydUoU3JecpE8UUX5+8Of/T+TFdk
        mznXD/5f4S8DWJbVnxbatzjEqc5+VbPO5jjlrReubgr8FfiKededkH/VdxtyvL0+77os1yI7
        R3nDggnOEzY/eijs+/tLScoipYVblrHyrU9PqZj0v9H7QjOTyLReo46zrSLvt/txRdirVD3b
        +sGcIX7nvaW3y4wcdxyZLdT6z0wip1U+IbOV6+DlJT1r707lzbrl1vlh46WCA+qfMgTmb52V
        +CAgx9r/ROeF1TJs2SWB+dsfftzoFJ7IWO46ozr9V6oSS3FGoqEWc1FxIgBp427iAAMAAA==
X-CMS-MailID: 20230912024917epcas1p29a513dcf6019fb7c63275aa0e39b1c71
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230912024917epcas1p29a513dcf6019fb7c63275aa0e39b1c71
References: <CGME20230912024917epcas1p29a513dcf6019fb7c63275aa0e39b1c71@epcas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kwanghoon Son <k.son@samsung.com>

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
			status = "okay";
		};
```

[1] https://github.com/revyos/thead-kernel.git

Changelog:
rfc:
https://lore.kernel.org/linux-riscv/20230904042559.2322997-1-k.son@samsung.com/
- dt_binding_check
- enable reset controller default

Kwanghoon Son (3):
  dt-bindings: reset: Document th1520 reset control
  reset: Add th1520 reset driver support
  riscv: dts: Add th1520 reset device tree

 .../bindings/reset/thead,th1520-reset.yaml    |  47 ++++++++
 arch/riscv/boot/dts/thead/th1520.dtsi         |   8 ++
 drivers/reset/Kconfig                         |  10 ++
 drivers/reset/Makefile                        |   1 +
 drivers/reset/reset-th1520.c                  | 109 ++++++++++++++++++
 include/dt-bindings/reset/th1520-reset.h      |   9 ++
 6 files changed, 184 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/thead,th1520-reset.yaml
 create mode 100644 drivers/reset/reset-th1520.c
 create mode 100644 include/dt-bindings/reset/th1520-reset.h

-- 
2.34.1

