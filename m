Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 917C77749E3
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 22:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234285AbjHHUFw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 16:05:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233994AbjHHUFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 16:05:40 -0400
Received: from mx0b-0039f301.pphosted.com (mx0b-0039f301.pphosted.com [148.163.137.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06E9A995E5;
        Tue,  8 Aug 2023 11:25:57 -0700 (PDT)
Received: from pps.filterd (m0174683.ppops.net [127.0.0.1])
        by mx0b-0039f301.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 378E6eOx003021;
        Tue, 8 Aug 2023 18:25:40 GMT
Received: from eur01-ve1-obe.outbound.protection.outlook.com (mail-ve1eur01lp2057.outbound.protection.outlook.com [104.47.1.57])
        by mx0b-0039f301.pphosted.com (PPS) with ESMTPS id 3sbpek1ayb-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Aug 2023 18:25:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VB+UT3jkHqur7UgD2/mHA2jlK3mskdpnq8MN99nECYkE5+0uUEE+dIQ7h0t2R9Ii0Xi1AUknpUwB6UqRLnm8rfSK7ZdWMWXfdJ5wNzn0Km59+wjq/qOX4m8WOqbUve66GdwVVvZ8Y3B0lTVed5N4PTAmXCSYkl04THp28F5I4Lu3ReX7Cqd8LzM8X5364kWB1qRdupPrL+31Dunsd5OxePejTQGC5Uk01+a1vjKOTtG8F0jSOQ4lHeACL30c9R95DyqQ20jyRByehUrCiLSLDAc2iKWxLWgwQ2BUcpZzDICPa775INfYgM4A+oec3VWSZjdd92egWQb5pHcItiWmew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OMfte9DhB08hbs2PmBiEDR00GZEeLX85flz/q2FrBY0=;
 b=SGNbvW5ATS+SYPLOMgSWxIyMK+GJCWufJFPLz6RkKLylLUGRnA1t4yrWg7wQZhfAcTxdHO/VnslDugQUVi7txXwnCrRjSLvsAzzpf1vcI5JxKKeEWDnj1itM88L/WTqGt0mjMWwvEw/h0lpAaM13zgm5hPeNLdhBlpLubMwWuC8cmrFS41uFDkbyapkTt3/c/VkabYuybNUrjSSkPa7ZeYX5Bqe/EUMuMaDph4Wpqc0dGIffEl4qifie20L8FUlbwMeLYON0Knr9shA8SMQndctNTFaVyZs+ZGL45bQ/SjipFpTvtOejW1JUd6cxp/xVLDbxHof/0v3eLCStmV4zrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OMfte9DhB08hbs2PmBiEDR00GZEeLX85flz/q2FrBY0=;
 b=SRJ7FS/AnM/p0NepImFTh5Gsht71gSUbJUXEHJyXjzzj5IapFmrwuCHT5nNFDJ4ywusKOUxlRK4/hsbz1KZ8s6e2vh27z9cmDIyjakySAIQvYmfmjkBpkJn48ozRGHqt/HXy0bo07+HxlUzFJptFFAg2nmAnIe5Zr4jHd2G9mgN4RlZ5qIXdUFYutyFA13tFFSgqPBcWB/3kxBiDTVNYszUoRz+sbflOOUQ8IVZ/x8sxozc9M9W/ZfKPDPAuLE1JRDicmv2+S2ZA7o/QOmoBrkU01L/kS+FtL79HbJGAnY4HUqUZ3H3ePIQ4epjfqcFDDZI1wSyx63it9xTA1j/iMA==
Received: from PA4PR03MB7136.eurprd03.prod.outlook.com (2603:10a6:102:ea::23)
 by AS4PR03MB8458.eurprd03.prod.outlook.com (2603:10a6:20b:519::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Tue, 8 Aug
 2023 18:25:35 +0000
Received: from PA4PR03MB7136.eurprd03.prod.outlook.com
 ([fe80::ccb5:5aee:f10d:ab26]) by PA4PR03MB7136.eurprd03.prod.outlook.com
 ([fe80::ccb5:5aee:f10d:ab26%4]) with mapi id 15.20.6652.026; Tue, 8 Aug 2023
 18:25:34 +0000
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
Subject: [PATCH v4 0/4] firmware: arm_scmi: Add SCMI v3.2 pincontrol protocol
 basic support
Thread-Topic: [PATCH v4 0/4] firmware: arm_scmi: Add SCMI v3.2 pincontrol
 protocol basic support
Thread-Index: AQHZyiW4JT1gPXk7akOBuyCkkIz0Cw==
Date:   Tue, 8 Aug 2023 18:25:34 +0000
Message-ID: <cover.1691518313.git.oleksii_moisieiev@epam.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR03MB7136:EE_|AS4PR03MB8458:EE_
x-ms-office365-filtering-correlation-id: b0d9789d-62c9-4fdd-68a2-08db983cdb48
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QUGJLazb8+7b5r7EhVbMw5xx0IczQwBvOZCnmeiVWFBUPQxSlqFmEIOxhYr/RMASWeB2D95dzvdGH7SwX5Dr5fPwNV0+w1gDoDSCGV+4N0ctzgSsw85dsUFsrK+/mSV5ZfNzo/GgpKKviq1CrsSw10TATSqzBKtWV2wrpb/qTjs4/sLeCsqUkIoLj++/s/eU83JBxHAjCaClEetTZeduYSNouxSuO06QCB8ZcRFtdWENK0d0W5eWIV5b++f8VedyhajsYd6sJa6jZQn0wWa283tSv6SselH9DqY1nNQYdmGlBvEHxAGfJe7tSl5U0xZQ3lGHYDbm/nJBraz7c+erAn91Z/uB7hw8j5gZ7iDX67CT+KahwxHxBwKW8I+dRICHJCVUxP5BTEeCIAnnIzybs4IKwYnIiiCAkqoa0/HW0g9TZnkX3+keHvHKEgz+jhGuLktKbyiHRzsHteuQJb6/cGMIyjvPlsSoi7CQ6vMc1xGsFaBB1gfciuuNTI6ulyp2FY6Wu7axO0ENx0z2SQF0C/GY7MvM/XwoxbP0stLJhiNiDkbM9X3yIxxfSVAADHhLqup0Mytd0VjE6dzokYHOxNlD2CnjHbvlCrKtJpazVEU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR03MB7136.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(366004)(346002)(136003)(451199021)(1800799003)(186006)(7416002)(38070700005)(8936002)(8676002)(5660300002)(64756008)(4326008)(6916009)(41300700001)(316002)(83380400001)(86362001)(2906002)(6512007)(6486002)(71200400001)(966005)(2616005)(6506007)(26005)(36756003)(76116006)(66476007)(91956017)(66556008)(66946007)(66446008)(478600001)(122000001)(54906003)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?tjwQmSLAX5NNgZVRbaTNov1SEOusjDmpF4FvZxN8DrID0V3bvaO6Bqwptf?=
 =?iso-8859-1?Q?72Zan2v+VQcPY0xvXcP0acVPiJU/2EKlZnsmR5U9cerOUXoqP1JGEqyZ5C?=
 =?iso-8859-1?Q?DAr7iS9poNJAiJYofevIqwtYX45/osioxg1tIS6PCwtlWgn7K1y2Wadhnw?=
 =?iso-8859-1?Q?MX+E7d/aLny4n/qGqnXrPmPGNgHBbarTx6ySTfad606aRfH0FraevZj57k?=
 =?iso-8859-1?Q?7vxzB/1IkQAQ5l5VfK68DdMkJ+gIoH9wMksjH2xnAqMIXqVn1roZ5pPY5w?=
 =?iso-8859-1?Q?7XX5zpKuQFClQsex/3OKDzgqfaAJUEJG3Qd3OJYOkAjP2rHINYRpNLdk2B?=
 =?iso-8859-1?Q?hq1Jd6M5IBgy4pvLjRm1IEtoeL97sUo30LJL8sTo6/23X9SS/ZS29FipjB?=
 =?iso-8859-1?Q?NnqKZNKLZB7zTAHzZrWCYYHZNxZV4kz31ed18JKCCPdRr6u39f1p6iBExB?=
 =?iso-8859-1?Q?mMOuJ/t5rDIEqygTwz32Pk+48KsA+PazxVnSA1ElGZFL0gEQt74RqzUWbf?=
 =?iso-8859-1?Q?tgJ9ya73flxFK6sJGUKpon3SS9RWxyqNYXTEY1XcFl9OjHnl0n/Z1Jx3VC?=
 =?iso-8859-1?Q?OtmPemul/NpxD9/CsFGontKkulbAqZdqi8XQk1xUXYJOzNudbcAuEQ3LiN?=
 =?iso-8859-1?Q?18PcM0IIQpz94bUqw+p+eCPFbolAO+0hEeSBSzo2ez106t99QJoYrmTOhh?=
 =?iso-8859-1?Q?6WZT3fkR8ULaYSGIk055iKPws9nRwaWbpo4HhCnXbn/eN/JgJvWhBsHinz?=
 =?iso-8859-1?Q?pyx5JC24/gL+dOdzaf4ohBFAWSzsJPB0WXjqJb8KvEHyxte28Q+dt6sBcA?=
 =?iso-8859-1?Q?Zndm7zl6L9E/YqPvUyAa1y0kwDyVR3a5sU8sLeFQMjnWPqQyCVHcCBxa4/?=
 =?iso-8859-1?Q?2F/E4PPabYknMEKM46tdt/RjVqpMriPEMei08/FHB0NtkhZA+Q7jgjWyUD?=
 =?iso-8859-1?Q?YGOmsTE870bYrxcQ6UJWDtnmTl58uP+dXxGFmzNYgUm6GbsnbbE4z+JQ39?=
 =?iso-8859-1?Q?KHwKzjDUrhOGPuK0xcvqAR9wmntdYjnFeVAVW540qlMziSwcELPMVC4faU?=
 =?iso-8859-1?Q?tj1KWPI7DoyGfv4C/4P+Djf0dE/EIbIUBw57IDpKdkl2mh+wmWEBfYw2bs?=
 =?iso-8859-1?Q?vWjev7tDPOGSFgWR3k2ViasZEKA+oRnpRsxQgmVf/KA7NPNopvlhgnibkt?=
 =?iso-8859-1?Q?nMMqYHpU55o3+VDzLYpSr65MGABk5VDfyGzFGwYR2Gmjr6PnAzCuN1RhzN?=
 =?iso-8859-1?Q?vD7/1Ltlbs/pdD0hNrjzydthzJ8qU9K4FyKma3okisTEMHDM/s+ZR2M6r2?=
 =?iso-8859-1?Q?Q4nj/v/hsa1CVYZ5P9Bj0F0yeVCik2P9NtD5+lfiIQqXG0bpmvqdASw+BB?=
 =?iso-8859-1?Q?ETHrjl91uefB5nQEaPeq2OADaHuqBpbr6G23w7uxZa3uzYlYzwC/V0+YHl?=
 =?iso-8859-1?Q?XDcnxjcjRg1gMgOOAYOk/iTbd9SOfJu2YoxNOSy/jkJ9fUrSfMkAe/SlF3?=
 =?iso-8859-1?Q?62uEc3i4cQvYrM9uu12pBwm4sy2ygu3AY5feDyyjHUrV/lL1BTFltVu5mx?=
 =?iso-8859-1?Q?z1Rm9D0dsBRrI/mM/6Jaj+cVX4Nom2m6T+rYthh1A77VYjPSCGqv6pUcDc?=
 =?iso-8859-1?Q?XzL3BOItGhxhZx+oAE3wQ4q3mJHc2cuATHzLBUOPXFq7+HLBVbDYy5jA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR03MB7136.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0d9789d-62c9-4fdd-68a2-08db983cdb48
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2023 18:25:34.7146
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z2EumVU+SVekyF40Hwd2+yEN0pn3gGgdAjqm/ptg0opiffJiYSQlaIUX4RmcJf4GYDTz5pq9gKfNqUIU8CMNlCgZPrjzkS1a/pWqOkZw1L0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR03MB8458
X-Proofpoint-ORIG-GUID: O1GjMCwLO89JzjOUSJ9itAbBLffveSyM
X-Proofpoint-GUID: O1GjMCwLO89JzjOUSJ9itAbBLffveSyM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-08_15,2023-08-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 mlxlogscore=999 impostorscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 adultscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308080163
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Oleksii Moisieiev (3):
  firmware: arm_scmi: Add SCMI v3.2 pincontrol protocol basic support
  pinctrl: Implementation of the generic scmi-pinctrl driver
  dt-bindings: firmware: arm,scmi: Add support for pinctrl protocol

 .../bindings/firmware/arm,scmi.yaml           |  53 ++
 MAINTAINERS                                   |   7 +
 drivers/firmware/arm_scmi/Makefile            |   2 +-
 drivers/firmware/arm_scmi/clock.c             |   2 +-
 drivers/firmware/arm_scmi/driver.c            |   9 +-
 drivers/firmware/arm_scmi/perf.c              |   3 +-
 drivers/firmware/arm_scmi/pinctrl.c           | 791 ++++++++++++++++++
 drivers/firmware/arm_scmi/power.c             |   2 +-
 drivers/firmware/arm_scmi/powercap.c          |   2 +-
 drivers/firmware/arm_scmi/protocols.h         |   4 +-
 drivers/firmware/arm_scmi/reset.c             |   3 +-
 drivers/firmware/arm_scmi/sensors.c           |   2 +-
 drivers/firmware/arm_scmi/voltage.c           |   2 +-
 drivers/pinctrl/Kconfig                       |  11 +
 drivers/pinctrl/Makefile                      |   1 +
 drivers/pinctrl/pinctrl-scmi.c                | 442 ++++++++++
 include/linux/scmi_protocol.h                 |  42 +
 17 files changed, 1367 insertions(+), 11 deletions(-)
 create mode 100644 drivers/firmware/arm_scmi/pinctrl.c
 create mode 100644 drivers/pinctrl/pinctrl-scmi.c

--=20
2.25.1
