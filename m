Return-Path: <linux-kernel+bounces-19174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 335E6826943
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 09:16:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACADC1F219BF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 08:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15474B662;
	Mon,  8 Jan 2024 08:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="irIuub+K"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2047.outbound.protection.outlook.com [40.107.22.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8F89467;
	Mon,  8 Jan 2024 08:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VNI2MmnW5LPi00i+HtO7BbKtXG+chUPGs6sW3aIMMA2M8On6So/rD2+tKpAGGBGKFfT6tOiq12oIzEBh6g2sxihboa+NQYLxx8AuWa3iMrs26rs23tRtyUOe37jxjuqrNzegFHkWGR64r73LTuTg0MGmRH0pjQZmX0wzazIZkqVzib7ORDZ3hAH8jMlUBwVrf4eNUCMBr7PRncIdHOF9As+OAIp3NUxRV2IKyhT5GLWrTcPtKfogULzeaYverr6NimZEMnHYsW3nS9CUeFs5wE5TGxKQ6EQe/XNv6A8zub7pLiabTEkXD2dNQn5LmZJhY1RkXEtPqK0kLckqcFXXuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wD4l+bs1YMwoezaICyxoPVf1G8bh5/2Rd4/8Q0noj0s=;
 b=oCqCK5wbJHUH0yjGAdgCBgtbm4spoy1tcWo4MK7yqbwGZjSS6PVePGsiBZ0m5GTUMdURiAMyX40q6MiUGdIxpkmMt3KP7J62Vec/XU1J3WFj34IxDHzbe2v4BH6hjwI+zHf1QcJ63arQwIhUHTgGnhfR3Q4K+AgXiq21wqPvbDjaOqhy78lPXuEDCcNv05hC5LIwZT0uxgRXRZGbvB+z/iT2A4W5PSbx5lyxhcAcV+J/b8ZX+tE9nWnQON1xTYF9K+VyCD7wOOMa2cyZdMyuVzxXiBHqVkb1NdJxaPZIrSE8k4tYlRcNynPtZIywHBKWpaQEi4u3KlFR1mTJ6AYNtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wD4l+bs1YMwoezaICyxoPVf1G8bh5/2Rd4/8Q0noj0s=;
 b=irIuub+KV4DM5fNedplyqu+u7eDMyrDZ8dOObvPHB4j29wtWUEmb8GGqMeI1Wdp76GelOVlbSlkWZnx4yADwjyDC1PD/EJyyEpBWpbmZMymjflo/Hd5nkKd8f4815b6YGrj9AKp/Dgx8OBtaRftbMKBEXhTFg0Em6ZI5RrqIKdgybhDmGfrIG0+QKk9Z6Yil6NiU7PNKDDMDPf+CWy6LXSdMw3nEiW8Yt26mTJ8hiQZCF6HihKiuv21He7rGliLLdwgAHAy3jBWIeliMjT7Q5CP3VLDIETMF3xRsfw/zYrIX/hn8DxPZxPw3tL/a5TeB0kYkIq2pIHuPl80tTKvPuw==
Received: from AS8PR10MB6993.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5a4::10)
 by AM9PR10MB4055.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1cd::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21; Mon, 8 Jan
 2024 08:16:15 +0000
Received: from AS8PR10MB6993.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::11a5:fa0:85c9:ad4f]) by AS8PR10MB6993.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::11a5:fa0:85c9:ad4f%7]) with mapi id 15.20.7159.020; Mon, 8 Jan 2024
 08:16:15 +0000
From: "Li, Hua Qian" <HuaQian.Li@siemens.com>
To: Nishanth Menon <nm@ti.com>
CC: "wim@linux-watchdog.org" <wim@linux-watchdog.org>, "linux@roeck-us.net"
	<linux@roeck-us.net>, "robh+dt@kernel.org" <robh+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "huaqianlee@gmail.com"
	<huaqianlee@gmail.com>, "vigneshr@ti.com" <vigneshr@ti.com>,
	"kristo@kernel.org" <kristo@kernel.org>, "linux-watchdog@vger.kernel.org"
	<linux-watchdog@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "Kiszka, Jan"
	<jan.kiszka@siemens.com>, "Su, Bao Cheng" <baocheng.su@siemens.com>
Subject: RE: [PATCH v3 2/3] arm64: dts: ti: Add reserved memory for watchdog
Thread-Topic: [PATCH v3 2/3] arm64: dts: ti: Add reserved memory for watchdog
Thread-Index: AQHZtW+sFYwpuU0uCECG57sNkPRn36+5WswAgRdN6nA=
Date: Mon, 8 Jan 2024 08:16:15 +0000
Message-ID:
 <AS8PR10MB6993F047652F40675BDA689D9F6B2@AS8PR10MB6993.EURPRD10.PROD.OUTLOOK.COM>
References: <20230713095127.1230109-1-huaqian.li@siemens.com>
 <20230713095127.1230109-3-huaqian.li@siemens.com>
 <20230714225240.dvlwqaodp2l3cczm@disfigure>
In-Reply-To: <20230714225240.dvlwqaodp2l3cczm@disfigure>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=44f9358b-b336-4736-818a-7324bf52d61f;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2024-01-08T08:07:58Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6993:EE_|AM9PR10MB4055:EE_
x-ms-office365-filtering-correlation-id: cd1f3c1b-772d-4ca1-42c5-08dc10221542
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 6lMZPOzA+7q2JjrizCF9q4xRsM3dF43dNRqNz+B8Iuf6DLgnMqBmUUwXX7o+Rhwfrxud289Y8ptxcS0EtmQw/kn/eBPrXnjNWSCAem2SmKpCpe2FxRpBW5Om9uZQx2JF3owkZkr76joEoqWaHTZdQ/Y1JFJOG86rZ0EsovnDPgTT2K8M1kDYJ8RDZm4u2xLatXb/bXNljOhlDxxk5prgFc2SNCbPYtu5/lDXXBgSuRCErohWGjyLJLOhWURo0jIjOCVaIm2aWMIud8RMviNtQnnFrhAIisgj2erRgU1rBb3hgx1bd1YrtciWHAiy/9az+mM5FiL678s96Sq7vwulvOmQ1aSCkK92bGhKCEcrLt1OOV+dr6+TIRAbc60zQXJ/rFGLbu0JLHjh7VrIln4rQVP7ke8W64HQFNZKK1RZyT8aULTK6ShmalaMZRxcO3QKE4qHEKaw4ieRSgbicJES1sWL0qr6EIXRIBVMijeFL26AEa7Fnw5TUukFxbCTMGEA0wkX73mhA3VA0LmNHfbmxXuuYTHbrsWtIRQs6787p6duNJ7chiE0Pc0dnkjEjFoPkYkXT1Gh19iTiFFcU2E2iGzPI+LHIBEpxVyyNfTHgPdHr0P1Ibs2WSf3/9otNJMZo4Ug4PFO8WWz37d2SoR3gDruIbiCMHNajAFGgAk4CpA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6993.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(376002)(346002)(396003)(136003)(230922051799003)(230173577357003)(230273577357003)(451199024)(186009)(64100799003)(1800799012)(122000001)(38100700002)(4326008)(7416002)(5660300002)(2906002)(38070700009)(9686003)(478600001)(71200400001)(7696005)(6506007)(53546011)(966005)(83380400001)(33656002)(26005)(107886003)(54906003)(316002)(52536014)(76116006)(66946007)(66476007)(66446008)(64756008)(6916009)(66556008)(8936002)(8676002)(45080400002)(86362001)(41300700001)(82960400001)(55016003)(171213001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?TaAC/HZYMeFRBF90R5wR+rkpv43WW1/yuuycKSV7HEjM0KiIw+8uhhZT76ZY?=
 =?us-ascii?Q?Iw7kAIMaQW3bVnJ3bLTPZufcXuQd2qiDKCXlNMFEgFBbWrQ9Q7dHCf33g7N5?=
 =?us-ascii?Q?hZedaS98s+8Awgodd4EX+t7wbPYhYi6tWKmVTo76lKgo3qB/eO1c2MooihPb?=
 =?us-ascii?Q?RJv0kwlnG2OowP46/7NPb5KbU4msq6hTuiQXw1SodONEllE95NksfnZnRUp7?=
 =?us-ascii?Q?ABWjwjiv2UZkujPg+jYy5CQHG2JlBiz+oSkIDXWaqxP1DfZVAe+prK6efE9S?=
 =?us-ascii?Q?rf55bLUOzM9Q/H1p/fWWHtMt3/x+T0P5DOl0R2SPWT4b3I6QpJNvwTscOJAd?=
 =?us-ascii?Q?Csi/kbm+a8u1msHQlmHNuva/IG6liDBUk5wCADyd2i2dP5ofM9+F+uQRsTQ0?=
 =?us-ascii?Q?iSk9l6wGp4g5qI0jl4dXLUIcpvbxV80OI08VN3fK7E3oFWHfUxEnuCgT8V0v?=
 =?us-ascii?Q?+gMlUAEpXkYXJiau/vdyWefR5eOTdbcEVqJH4HLRxLOe5IPhQvK3E45S/EQc?=
 =?us-ascii?Q?Ttg2S8rBNBOoh6Qx/94K0uzteqKRgB3pyPpOuAez/wowmE6cwFS0aiXbe7Hd?=
 =?us-ascii?Q?bKmq6F9PzqN8wk6CcZCDYpZXQw5FUiSQo5tPH5lKttVCug1N/KNUG42Hc+Yr?=
 =?us-ascii?Q?KsqUAQASMj/Vos6Zo/kg/Ks0eD09knsd3ASv8bdoEJlZKjI6Jsqy2k7ogCtr?=
 =?us-ascii?Q?e94KQr3dfQLKkrWlgn7cRJm6RmcYo4+gba012YhMiMccIc3Gm3SzmnnGhEu5?=
 =?us-ascii?Q?QCCdu1DLRO0q7Qq1FH5gqc26DFOK/rIK1pbbQNH75Ry8yMLNKapR+ECtmXsP?=
 =?us-ascii?Q?rSo4byRNeDLbAbnQPCb6WmRh2O6x5k/0sukVFnGTf9IRHFCeQHXo1IShhsep?=
 =?us-ascii?Q?l187/bJxgC4L/PO1sjadLno7AGo3Fp8L7AHSUBtXdLXnNzaAdGa0WvoHpP2k?=
 =?us-ascii?Q?C1eAGlHU50mToqDc03IM7EEPR5KTSLsng9vRx/zgjPBD1tUkFAGt1/o92BNM?=
 =?us-ascii?Q?wAeUUsT9sytVyScT2bBWO5xhWsQxcXZ2O8Nsgq9O8fCCJafXqTHGAQFsjKzp?=
 =?us-ascii?Q?idbGHSqIAum8J2WTNYOF/qSiLwMyhs7T7Ja8lkAO7IQVGaGPqgAogI+l+4qP?=
 =?us-ascii?Q?Z9rjka5lYLe2tjxolLlfV/XuD8eszuaSsjOU/w9pLPAVeEwtoPxFAaqOicCx?=
 =?us-ascii?Q?6LCByJQZg7wAgKzwYMY2d0oeRF1myZU/hiGe0nSWkYlQpfzSsBR36wwqEjIP?=
 =?us-ascii?Q?sW6ILj6HjcOpTR5ev6Ucx0griaUOQb+SqG0D8qKgQw9ZfVgeDH6vqBIGGYze?=
 =?us-ascii?Q?QQ73DrPhaNZxZkiW6mD6CsHXu9JOENjeRv45xFiIRaSMbpDd7cJMY61DxjP+?=
 =?us-ascii?Q?ugQdX0VZn6As4jFv4r+0PoS2Qvgu292rsaXzk+2DcCOHOHWGiV0fjohcyv6H?=
 =?us-ascii?Q?mWGTGD4ljDY/Yz6y08n75tPUuSicQGHcfUCkEy3aPoYkIIkaafIR4KDltRkj?=
 =?us-ascii?Q?dgNTtN5hIvfP6QvVxk4PIfQtyj1VnxE+O1K2hG+bD9oPKmBu5kuI+M23WvUc?=
 =?us-ascii?Q?qaIM89FLLJyiHOf9w06hpct174L0Xv1x7yAH2rcd?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6993.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: cd1f3c1b-772d-4ca1-42c5-08dc10221542
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2024 08:16:15.0941
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Fp4qLb/JJ+55C3r7I8IaknHiz+fUE1rDVMeMWvpTFCjc71yrzAGBx+2OWq2t9o4fXkFgVmL9WXQm6mmm4v14dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR10MB4055

Hi Nishanth,

The maintainers have picked up the driver and bindings, as follows:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3D29057cc5bddc785ea0a11534d7ad2546fa0872d3

Do you have time to work on the "DONOTMERGE" dts patch?

-----Original Message-----
From: Nishanth Menon <nm@ti.com>
Sent: Saturday, July 15, 2023 6:53 AM
To: Li, Hua Qian (DI FA CTR IPC CN PRC4) <HuaQian.Li@siemens.com>
Cc: wim@linux-watchdog.org; linux@roeck-us.net; robh+dt@kernel.org; krzyszt=
of.kozlowski+dt@linaro.org; conor+dt@kernel.org; huaqianlee@gmail.com; vign=
eshr@ti.com; kristo@kernel.org; linux-watchdog@vger.kernel.org; devicetree@=
vger.kernel.org; linux-kernel@vger.kernel.org; linux-arm-kernel@lists.infra=
dead.org; Kiszka, Jan (T CED) <jan.kiszka@siemens.com>; Su, Bao Cheng (DI F=
A CTR IPC CN PRC4) <baocheng.su@siemens.com>
Subject: Re: [PATCH v3 2/3] arm64: dts: ti: Add reserved memory for watchdo=
g

On 17:51-20230713, huaqian.li@siemens.com wrote:
> From: Li Hua Qian <huaqian.li@siemens.com>

I guess I should be explicit about this: Lets keep this dts patch as "DONOT=
MERGE" in subject line for driver subsystem maintainer (I don't want a repe=
at of cpufreq maintainers picking up dts and associated warnings that are n=
ow pending fixes), resubmit at next rc1 and I can queue up the dts once the=
 maintainers pick up the driver and bindings.

Ref: https://lore.kernel.org/all/20230714084725.27847-1-krzysztof.kozlowski=
@linaro.org/

>
> This patch adds a reserved memory for the TI AM65X platform watchdog
> to reserve the specific info, triggering the watchdog reset in last
> boot, to know if the board reboot is due to a watchdog reset.
>
> Signed-off-by: Li Hua Qian <huaqian.li@siemens.com>
> ---
>  arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
> b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
> index e26bd988e522..4bb20d493651 100644
> --- a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
> @@ -63,6 +63,12 @@ rtos_ipc_memory_region: ipc-memories@a2000000 {
>                       alignment =3D <0x1000>;
>                       no-map;
>               };
> +
> +             /* To reserve the power-on(PON) reason for watchdog reset *=
/
> +             wdt_reset_memory_region: wdt-memory@a2200000 {
> +                     reg =3D <0x00 0xa2200000 0x00 0x1000>;
> +                     no-map;
> +             };
>       };
>
>       leds {
> @@ -718,3 +724,7 @@ &mcu_r5fss0_core1 {
>                       <&mcu_r5fss0_core1_memory_region>;
>       mboxes =3D <&mailbox0_cluster1>, <&mbox_mcu_r5fss0_core1>;  };
> +
> +&mcu_rti1 {
> +     memory-region =3D <&wdt_reset_memory_region>; };
> --
> 2.34.1
>

--
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5=
 849D 1736 249D

