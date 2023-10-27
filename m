Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1C437D8EAA
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 08:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345216AbjJ0G2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 02:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjJ0G2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 02:28:36 -0400
Received: from mx0b-0039f301.pphosted.com (mx0b-0039f301.pphosted.com [148.163.137.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38A8C121;
        Thu, 26 Oct 2023 23:28:33 -0700 (PDT)
Received: from pps.filterd (m0174681.ppops.net [127.0.0.1])
        by mx0b-0039f301.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39QL6OQQ007652;
        Fri, 27 Oct 2023 06:28:16 GMT
Received: from eur04-he1-obe.outbound.protection.outlook.com (mail-he1eur04lp2050.outbound.protection.outlook.com [104.47.13.50])
        by mx0b-0039f301.pphosted.com (PPS) with ESMTPS id 3tywqm92ds-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Oct 2023 06:28:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q7ijHPTsMYyb4CaYQIZ1VnljxlzmbKreGCElw8oB24AuAEP7iGpJvK6UDro7JfQETRm8Axzf+X2d+OoyuvsQwVFmu23Yuh7gGsZhoLzuv+CU9igSTtMH3jpJaZxLhgoUd9oieYLIcReepOxceXpYl6vRAKgtuzX97Q1QNsuGFm2acys9gSJJiSg7yYyu4moNB8CGSxs6mNfpGGcOn3oZ4QpE1oNehDp5g+PeJeWy3lVWRcb7181QVtWUMD1kJshXjYNPktAU9M8ZU+iU08D/sIuqXuJKDNTz1T2lFhPSl6FU9Lv+nngmhdXRZ3oJpz5rF4mLcpkpjJSK3iOf+rv9nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RYtkAlEceO+yGuD0orl/DE8cb9I1O5xZ54JsWJKQAbc=;
 b=nf292aH73apVAEosZ7oUjFgluFmqwbLsv1L4GLUGf7e4zgosWyaXohs2P3qyPtX5hsCFyldFNcQz1dSXyy9FBGrbd+Y8iN4lu6uMbdt4XwGnTn1NKbCzOx9T/E7JDTxwUKymV/+Pj7aGwLt20YgBliZNq1h2F5Pf6XWxv2Hp+bMjKjpJGLbsyq+7ii/+WRJwDetXExRTiyZOt6OBQV/k0t4YR6JtkVJTc4rvmFiMKi7Ru6rcJCzftqVEZ7PqoZ+BqeY6HM7DuqEN9Xy2gEHEsfAK4KtoindYX+yecGzaUVBZQ4m5/WW32vUB33JlkIsCBIgQtLsB/6vliMGzKK1wZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RYtkAlEceO+yGuD0orl/DE8cb9I1O5xZ54JsWJKQAbc=;
 b=iC1fFLFX4/7mYuxhvjKJYZ+DsYbEfQaTgUrTIK3OKoXaq0jy086bSEL1Gj5XXSjrmoah5AOLqrD/uegYPx/6ZufGupHfCi/vdm17h04mMEKD5L6PTKM+0KcWFimJ8RV8FQ0ReIOVAXCjxV4E4lgkQ3xqDlI6Fwhsg18CvIlWH/51ZmD7Fx2UZ9wNIFxHKjbh7UKQD1laGiyBvdTRXYCBj+6GxSfFez+bR1sG/plGE7T30ec8+Q5qA/gZpEuybOUVqcZaJ/UB1zOFugwXy7O/R0V//wsFG9pazzlZzWTXcp0qJM4MYegFD4zQE40twtBig0wHYzOVyu1sv2Uku10VBQ==
Received: from PA4PR03MB7136.eurprd03.prod.outlook.com (2603:10a6:102:ea::23)
 by GV2PR03MB8876.eurprd03.prod.outlook.com (2603:10a6:150:c0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.23; Fri, 27 Oct
 2023 06:28:08 +0000
Received: from PA4PR03MB7136.eurprd03.prod.outlook.com
 ([fe80::2211:9053:228e:4e40]) by PA4PR03MB7136.eurprd03.prod.outlook.com
 ([fe80::2211:9053:228e:4e40%3]) with mapi id 15.20.6933.022; Fri, 27 Oct 2023
 06:28:08 +0000
From:   Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
To:     "sudeep.holla@arm.com" <sudeep.holla@arm.com>
CC:     Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Subject: [RFC v5 0/4] firmware: arm_scmi: Add SCMI v3.2 pincontrol protocol
 basic support
Thread-Topic: [RFC v5 0/4] firmware: arm_scmi: Add SCMI v3.2 pincontrol
 protocol basic support
Thread-Index: AQHaCJ7ACAlvqIOT5UmCfLuND/6RYA==
Date:   Fri, 27 Oct 2023 06:28:08 +0000
Message-ID: <cover.1698353854.git.oleksii_moisieiev@epam.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR03MB7136:EE_|GV2PR03MB8876:EE_
x-ms-office365-filtering-correlation-id: 78ea7828-0127-40d5-e1f4-08dbd6b5e2d4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Yt1g1FfCPe3DCHtX48TVkUBo8LzhKZm7Hm3biudaB+aEz7X7CziD0+J6lDgu6Qo2t4EBHKjKOKvWJHVlEYs6cUYRUGBgcl/c33RqgtjySKJPq0o3UXBTYtzdGsdivaDGM0vrJepFVd/2PJzLKquHs4YTsoAHZ0Vm6SvwfzwdlNY2S7C8ngSFQoUuy6/Hxlu9KqJdDmz8yHijr6jzIJBVPbfFc5CFiHJWnBst/OgqMX+Y1G2VFMT0bawr+LC5Alu0P1HImf113Pil2DvzHM/KgijDTBVz5kHxB3wyn1+l18nON4APJeRfBCZ2zHbrB/0sF/iRnddt1VrOag7WNOZ9C6vfbU3ZQLvUxiFXy+nzP0sM2KWiayCKdIplihCEusvDliSrlLCyaJUgvwyZa/Cg6lJgDyOxYYVStx5jUuneuQ7N4eS9ZvP1XqDhYGFTrVPc0nl2plTapfwAYZp251sr/vUX7iduJKY4hsMJSUSJrndzWwTOWSSk6spbtd5s02xWZxf2HxhFX+8xHSDl2xoAbNMNwOJDDr0Lu0/MZF6lXish0jKD/N/6KecaPM8cgC0kqNN97WUd8tenPI733u/P8KoS/tWPWMsoN0gEhu9gCNc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR03MB7136.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(376002)(396003)(346002)(366004)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(2906002)(478600001)(966005)(6486002)(83380400001)(36756003)(86362001)(8936002)(7416002)(4326008)(8676002)(26005)(5660300002)(38070700009)(41300700001)(2616005)(66476007)(66556008)(66446008)(64756008)(66946007)(54906003)(91956017)(6916009)(316002)(76116006)(38100700002)(6512007)(122000001)(71200400001)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?TikXYtf6QLp7pVWdJdDTMH4XR1zRe6NcV6fgXgItnvvruy4qSxQIASctfO?=
 =?iso-8859-1?Q?9pwabtwpSFvwCZqey7C/i7lleuxI2CzwbXYojNsdrV1usR/nm4JPyloqXk?=
 =?iso-8859-1?Q?vl9/krYnpiYXiFdKOxjtzREfokIkSHORwmIytiXYXOPWLsHPrp2wo9fFjl?=
 =?iso-8859-1?Q?4DpP4kXeOOtehNypbFpX3wfl62Sveo60T4H0CrkdFAdfDZLpgz20AgrpUk?=
 =?iso-8859-1?Q?Ld6AOsoYCdAz4JgX4MFD6h2HXXlnp1b29rSqJF2Pr7CrfM68kjJPQ4zebo?=
 =?iso-8859-1?Q?1jL5Ti6xZDPaGl2bU0PxNHO9JpZ06CrL69hHNU/pqw4i58oBAX7NkDyyB4?=
 =?iso-8859-1?Q?hizrK29aCgZxcy0p1DQH8gjsOchItxZx33Wc0diSwhgNDZIgUiFZNAbDD0?=
 =?iso-8859-1?Q?5Z4G3GvsYgzF4RIP8cXQNlYGaRu/UFA+9oySMme++QU2tLMS5rRYZA5Cyc?=
 =?iso-8859-1?Q?ISOi6w51a313HsZ45fpglFvqyCEFfvVU5nKD+o+qR6K9NB1+rQzH1hS14e?=
 =?iso-8859-1?Q?9RGLGbyNim4A3hnjjJSKUzxBqAWjHA0amiB6Z+YZdLFwArmG7zTjhWlcp0?=
 =?iso-8859-1?Q?kq3itwt2r/UfpzuAwWabtYpSUhwPB7jRFz/6u/F8Tdt8j2tFAy2u7ufgPo?=
 =?iso-8859-1?Q?A3ckKSJA92MViKUkx7FICTUAmQdnx6MwygOE/WvIFpGT9g9TkRaw+YyVdR?=
 =?iso-8859-1?Q?LdbZIpIHok5baVRH03msDz7cn68uRLXBX6mg2SNSxT47I0Aa8ImMZaHsZF?=
 =?iso-8859-1?Q?vdoUeNRQP/Fjtn/P6a2hJupCYMYkbdewC38IeENRQvDpAGMl+BgtbRcHrI?=
 =?iso-8859-1?Q?/cZXJsMfjkkzr5DU2U10nRZeImkAY1Hqvp5eKrJObPEMKNXCQbITrZE7Jk?=
 =?iso-8859-1?Q?vbO9hv7v44F7BsIVCZkRQok3i3SlfJW8pBYOmIQzj7EcAoFh1Wdo0IE+e7?=
 =?iso-8859-1?Q?mlVZ7PZTQEosalLfP+HZU9JofrTmxUT6oRylWSgNorYofrJ7jWrb9C2jqF?=
 =?iso-8859-1?Q?hMWM/O7QJOn0dyN7/BxO/oiRC+edX7ewg15hEtMJ/7uKY2OY/nM6ns2ij6?=
 =?iso-8859-1?Q?fJembe/8qbcr/oiFrWoUuX0mBlKSh0BHzT5ZVAgQB8X8q4ctkRbwZjOmC2?=
 =?iso-8859-1?Q?FV/hfKVf7qzHFvao+Gc3z5gushwQc+4N7mWVBeSz6CkcOmEXYG685MBUZk?=
 =?iso-8859-1?Q?LygfuVANkUh1pAzHe7xB8nl42Zg1E6EiCb1E+Ioe1kkXc65tgvh/F200S6?=
 =?iso-8859-1?Q?GG9XMAKKFhSsqrjAIVyaUe9MfPsRegloxnRTp9A808ieiQ9/EOHb/tgss2?=
 =?iso-8859-1?Q?ZM+P3qCQuXKIXEBbVWwNFOiJL86yzEFKnjdcaeQk1/T6PGKsMPcIrNLYVV?=
 =?iso-8859-1?Q?gs6daSxD1NgbQzozJ98rTAWybCPhZhMz3srp9Y7hx/7HozViRcgx+ejsF6?=
 =?iso-8859-1?Q?JU1XcyMGu6fAjd+ABYCe3tvvu2V80eTt3hZ6aQDEVQLZrParoqfptyYr+P?=
 =?iso-8859-1?Q?zBqZWnWqcfqq6iIl79AG/EVwI+l2ZRfkGdxfJaIpGX95jzz7/s2DsbWE1m?=
 =?iso-8859-1?Q?3nLGcPpzRG5ya/D8TYNh8A0CtrzovTeHv2OxjjCa8sja7GMiKM3Hs+2x8Q?=
 =?iso-8859-1?Q?HUUEhbkJ9RD4BfCzd54SrXr7cCAgxahqRHjGTZwo6djT4H62HMRuCbvg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR03MB7136.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78ea7828-0127-40d5-e1f4-08dbd6b5e2d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2023 06:28:08.5596
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d40bFyV33V9bRjPh1p+IN4Ntj0Ju4/o+2gGu5wWLckGhdv354DMo/H2XoT9DPq2tNp1vVW3/hg2A23+rInSirQBZlESAsw5EQe8tZzD6n5A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR03MB8876
X-Proofpoint-ORIG-GUID: DEwCY_cik6MKLdRFxSJ_EUs_ZSPLf6OV
X-Proofpoint-GUID: DEwCY_cik6MKLdRFxSJ_EUs_ZSPLf6OV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-27_03,2023-10-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 suspectscore=0 bulkscore=0 adultscore=0
 impostorscore=0 mlxlogscore=999 phishscore=0 spamscore=0
 priorityscore=1501 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2310240000 definitions=main-2310270057
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This RFC includes implementation of the new config_{get,set} according to t=
he latest version of
DEN0056E document (v3.2 beta2). Current RFC series covers the implementatio=
n of the SCMI protocol
functions without integration to the pinctrl driver, which is under develop=
ment.
Please review changes to start the review process before I'll be ready to p=
ost complete v5 version.

This Patch series is intended to introduce the generic driver for
pin controls over SCMI protocol, provided in the latest beta version of DEN=
0056 [0].

On ARM-based systems, a separate Cortex-M based System Control Processor (S=
CP)
provides control on pins, as well as with power, clocks, reset controllers.=
 In this case,
kernel should use one of the possible transports, described in [0] to acces=
s SCP and
control clocks/power-domains etc. This driver is using SMC transport to com=
municate with SCP via
SCMI protocol and access to the Pin Control Subsystem.

The provided driver consists of 2 parts:
 - firmware/arm_scmi/pinctrl.c - the SCMI pinctrl protocol inmplementation
   responsible for the communication with SCP firmware.

 - drivers/pinctrl/pinctrl-scmi.c - pinctrl driver, which is using pinctrl
  protocol implementation to access all necessary data.

Configuration:
The scmi-pinctrl driver can be configured using DT bindings.
For example:
/ {
	cpu_scp_shm: scp-shmem@0x53FF0000 {
		compatible =3D "arm,scmi-shmem";
		reg =3D <0x0 0x53FF0000 0x0 0x1000>;
	};

	firmware {
		scmi {
			compatible =3D "arm,scmi-smc";
			arm,smc-id =3D <0x82000002>;
			shmem =3D <&cpu_scp_shm>;
			#address-cells =3D <1>;
			#size-cells =3D <0>;

			scmi_pinctrl: protocol@19 {
				reg =3D <0x18>;
				#pinctrl-cells =3D <0>;

				i2c2_pins: i2c2 {
					groups =3D "i2c2_a";
					function =3D "i2c2";
				};
			};
		};
	};
};

&pfc {
	/delete-node/i2c2;
};

So basically, it's enough to move pfc subnode, which configures pin group t=
hat should work through
SCMI protocol to scmi_pinctrl node. The current driver implementation is us=
ing generic pinctrl dt_node
format.

I've tested this driver on the Renesas H3ULCB Kingfisher board with pinctrl=
 driver ported to the
Arm-trusted-firmware. Unfortunately, not all hardware was possible to test =
because the Renesas
pinctrl driver has gaps in pins and groups numeration, when Spec [0] requir=
es pins, groups and
functions numerations to be 0..n without gaps.

Also, sharing link to the ATF pinctrl driver I used for testing:
https://github.com/oleksiimoisieiev/arm-trusted-firmware/tree/pinctrl_rcar_=
m3_up

[0] https://developer.arm.com/documentation/den0056/latest

---
Changes v4 -> v5
   - add new calls to scmi_protocol description for config_{get,set}
Changes v3 -> v4:
   - Fixed MAINTAINERS file description
   - adjusted pinctrl ops position and callback names
   - add trailing coma in scmi_protocol list
   - removed unneeded pi checks
   - corrected selector check
   - resource allocation refactoring
   - scmi_*_info swap params to generate better code
   - style, add trailing coma in definitions
   - reworked protocol@19 format in device-tree bindings
   - ordered config option and object file alphabetically
   - rephrased PINCTRL_SCMI config description
   - formatting fixes, removed blank lines after get_drvdata call
   - code style adjustments
   - add set_drvdata call
   - removed goto label
   - refactoring of the devm resource management
   - removed pctldev !=3D NULL check
   - fix parameter name in pinconf-group-get
   - probe function refactoring
   - removed unneeded pmx checks

Changes v2 -> v3:
   - update get_name calls as suggested by Cristian Marussi
   - fixing comments
   - refactoring of the dt_bindings according to the comments
Changes v1 -> v2:
   - rebase patches to the latest kernel version
   - use protocol helpers in the pinctrl scmi protocol driver implementatio=
n
   - reworked pinctrl_ops. Removed similar calls to simplify the interface
   - implementation of the .instance_deinit callback to properly clean reso=
urces
   - add description of the pinctrl protocol to the device-tree schema

---
Cristian Marussi (1):
  firmware: arm_scmi: Add optional flags to extended names helper

Oleksii Moisieiev (4):
  drivers: firmware: scmi: Introduce scmi_get_max_msg_size function
  firmware: arm_scmi: Add SCMI v3.2 pincontrol protocol basic support
  pinctrl: Implementation of the generic scmi-pinctrl driver
  dt-bindings: firmware: arm,scmi: Add support for pinctrl protocol

 .../bindings/firmware/arm,scmi.yaml           |  53 +
 MAINTAINERS                                   |   7 +
 drivers/firmware/arm_scmi/Makefile            |   2 +-
 drivers/firmware/arm_scmi/clock.c             |   2 +-
 drivers/firmware/arm_scmi/common.h            |   3 +
 drivers/firmware/arm_scmi/driver.c            |  25 +-
 drivers/firmware/arm_scmi/perf.c              |   3 +-
 drivers/firmware/arm_scmi/pinctrl.c           | 922 ++++++++++++++++++
 drivers/firmware/arm_scmi/power.c             |   2 +-
 drivers/firmware/arm_scmi/powercap.c          |   2 +-
 drivers/firmware/arm_scmi/protocols.h         |   4 +-
 drivers/firmware/arm_scmi/reset.c             |   3 +-
 drivers/firmware/arm_scmi/sensors.c           |   2 +-
 drivers/firmware/arm_scmi/voltage.c           |   2 +-
 drivers/pinctrl/Kconfig                       |  11 +
 drivers/pinctrl/Makefile                      |   1 +
 drivers/pinctrl/pinctrl-scmi.c                | 445 +++++++++
 include/linux/scmi_protocol.h                 |  47 +
 18 files changed, 1525 insertions(+), 11 deletions(-)
 create mode 100644 drivers/firmware/arm_scmi/pinctrl.c
 create mode 100644 drivers/pinctrl/pinctrl-scmi.c

--=20
2.25.1
