Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19FC876C3DD
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 06:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbjHBEEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 00:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230325AbjHBEEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 00:04:41 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 498B52D71;
        Tue,  1 Aug 2023 21:04:26 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37244GAE007792;
        Tue, 1 Aug 2023 23:04:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1690949056;
        bh=L5rNntOZobIFbs6gTmshtr/XXkSzy2UOU3tMDPEwxT4=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=wuXy8n6KE+whjDVFhXQa4yo5/Pe9yAPIqBcWP+MM3MEIcXj6UjWfZ3+rr8D2L9GPQ
         ufLXS+NsiogKr1446x2BzTW/RTH7God20RMx7VIQ2cXY074Jq9wka/1r1KPp0Hy9Vj
         2dX12k06Xzz18CKmwt8ZLse4kC9IUF6SONOJWt94=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37244Gle023196
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 1 Aug 2023 23:04:16 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 1
 Aug 2023 23:04:15 -0500
Received: from DLEE107.ent.ti.com ([fe80::1c91:43d:d71:d7b6]) by
 DLEE107.ent.ti.com ([fe80::1c91:43d:d71:d7b6%17]) with mapi id
 15.01.2507.023; Tue, 1 Aug 2023 23:04:15 -0500
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
        "Tonking, Reid" <reidt@ti.com>
Subject: RE: [PATCH v4 1/6] arm64: dts: ti: k3-j7200-som-p0: Add TP6594 family
 PMICs
Thread-Topic: [PATCH v4 1/6] arm64: dts: ti: k3-j7200-som-p0: Add TP6594
 family PMICs
Thread-Index: AQHZwIuNdcGNTIhLsEagEEzPFiwzg6/WY4kQ
Date:   Wed, 2 Aug 2023 04:04:15 +0000
Message-ID: <4efd1c627a934915b4e9b313879d83e9@ti.com>
References: <20230727130908.10656-1-eblanc@baylibre.com>
 <20230727130908.10656-2-eblanc@baylibre.com>
In-Reply-To: <20230727130908.10656-2-eblanc@baylibre.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.249.141.75]
x-exclaimer-md-config: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Esteban,=20

>This patch adds support for TPS6594 PMIC family on wakup I2C0 bus.
>Theses devices provides regulators (bucks and LDOs), but also
>GPIOs, a RTC, a watchdog, an ESM (Error Signal Monitor)
>which monitors the SoC error output signal, and a PFSM
>(Pre-configurable Finite State Machine) which manages the
>operational modes of the PMIC.
>
>Signed-off-by: Esteban Blanc <eblanc@baylibre.com>
>---
> arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi | 157 ++++++++++++++++++++
> 1 file changed, 157 insertions(+)
>
>diff --git a/arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi
>b/arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi
>index b37f4f88ece4..e45d97cc41a5 100644
>--- a/arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi
>+++ b/arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi
>@@ -127,6 +127,14 @@ J721E_WKUP_IOPAD(0x9c, PIN_INPUT_PULLUP, 0) /*
>(H21) WKUP_I2C0_SDA */
> 	};
> };
>
>+&wkup_pmx3 {
>+	pmic_irq_pins_default: pmic-irq-pins-default {
>+		pinctrl-single,pins =3D <
>+			J721E_WKUP_IOPAD(0x1c, PIN_INPUT, 7) /* (E18)
>WKUP_GPIO0_84 */

Could you use 0x01c format instead of 0x1c,=20
and similar format in other patches in this series too. =20

Rest LGTM=20

>+		>;
>+	};
>+};
>+
[..]

