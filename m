Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDF0676E5C3
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 12:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235240AbjHCKcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 06:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233628AbjHCKcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 06:32:12 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27AC82109;
        Thu,  3 Aug 2023 03:32:11 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 373AVlZY004855;
        Thu, 3 Aug 2023 05:31:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691058707;
        bh=xoCZ1S4ULaFQQIN5aVx5V63su3NJPeCIqIsvFoExriY=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=VUB4IEXu/XtKIzYWJqveAPpKxvlnOwi4Qe2DYzs48g48UH1fgRWecK6CwGLLD2i4T
         0WpVRSSgyFwieRCZ6V5KRvVQ6zAQMZZBwgME2yEEQfGLquyekOcu3LuF+HIr9TuA7v
         PZYQGNMNNtV0rZFgmBYbacTzzU6RssJ2whtj28PY=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 373AVl0G033310
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 3 Aug 2023 05:31:47 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 3
 Aug 2023 05:31:47 -0500
Received: from DLEE107.ent.ti.com ([fe80::1c91:43d:d71:d7b6]) by
 DLEE107.ent.ti.com ([fe80::1c91:43d:d71:d7b6%17]) with mapi id
 15.01.2507.023; Thu, 3 Aug 2023 05:31:47 -0500
From:   "Kumar, Udit" <u-kumar1@ti.com>
To:     Esteban Blanc <eblanc@baylibre.com>, "Menon, Nishanth" <nm@ti.com>,
        "Raghavendra, Vignesh" <vigneshr@ti.com>,
        "kristo@kernel.org" <kristo@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jneanne@baylibre.com" <jneanne@baylibre.com>,
        "aseketeli@baylibre.com" <aseketeli@baylibre.com>,
        "jpanis@baylibre.com" <jpanis@baylibre.com>,
        "Achath, Vaishnav" <vaishnav.a@ti.com>
Subject: RE: [PATCH v4 2/6] arm64: dts: ti: k3-j721s2-som-p0: Add TP6594
 family PMICs
Thread-Topic: [PATCH v4 2/6] arm64: dts: ti: k3-j721s2-som-p0: Add TP6594
 family PMICs
Thread-Index: AQHZwIuODKqL1oXb3kG0QfHXqNB80K/YaVtg
Date:   Thu, 3 Aug 2023 10:31:46 +0000
Message-ID: <e9f9ebf13ee640daabd54a730e286193@ti.com>
References: <20230727130908.10656-1-eblanc@baylibre.com>
 <20230727130908.10656-3-eblanc@baylibre.com>
In-Reply-To: <20230727130908.10656-3-eblanc@baylibre.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.24.25.97]
x-exclaimer-md-config: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Esteban

> [...]
>Signed-off-by: Esteban Blanc <eblanc@baylibre.com>
>---
> arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi | 199 +++++++++++++++++++
> 1 file changed, 199 insertions(+)
>
>diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi
>b/arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi
>index d57dd43da0ef..5348aafe3277 100644
>--- a/arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi
>+++ b/arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi
>@@ -61,6 +61,15 @@ J721S2_WKUP_IOPAD(0x004, PIN_INPUT, 0) /* (E20)
>MCU_OSPI0_LBCLKO */
> 	};
> };
>
>+&wkup_pmx1 {
>+	pmic_irq_pins_default: pmic-irq-pins-default {
>+		pinctrl-single,pins =3D <
>+			/* (C21) MCU_OSPI1_CSn1.WKUP_GPIO0_39 */
>+			J721S2_WKUP_IOPAD(0x28, PIN_INPUT, 7)
>+		>;

I see, this pin is getting shared with OSPI-1 .
I think either OSPI or PMIC could be functional at one time ?=20

>+	};
>+};
>+
>  [...]

