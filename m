Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED2667D8EBA
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 08:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345321AbjJ0G3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 02:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345324AbjJ0G2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 02:28:54 -0400
Received: from mx0b-0039f301.pphosted.com (mx0b-0039f301.pphosted.com [148.163.137.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 864C21B9;
        Thu, 26 Oct 2023 23:28:39 -0700 (PDT)
Received: from pps.filterd (m0174681.ppops.net [127.0.0.1])
        by mx0b-0039f301.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39QL6OQS007652;
        Fri, 27 Oct 2023 06:28:18 GMT
Received: from eur04-he1-obe.outbound.protection.outlook.com (mail-he1eur04lp2050.outbound.protection.outlook.com [104.47.13.50])
        by mx0b-0039f301.pphosted.com (PPS) with ESMTPS id 3tywqm92ds-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Oct 2023 06:28:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B2EWMHc+VrDkkK9+vEbeJY6FgZU64Tr7ZGyW53P1nzHRnRBpC6Sc0D0TkDYqRY/ePLhDHHGiq90z9j0C6Xd496RZvGlHejborz1JzqMNoWkqIYgZGkw2lV0gEueRovTQ6LAiQTQWxlezlKfL5rxPiJlbL/mJIHXzgnfQRthGXHTQecn9FMs0BVddOLVuTk3HNckeTnKWuPKDGiTG6Z5HBowDg19N8Ohc7+wM8+T0tCcjwCi85fUvbxpkTPFty7J04/G4H8x9v7ihFJqpYpwi2fyJRwvhJKjO/mDfxLnNz3hI2y3saAyVQm1GX+gkGW+92jLT2ymu4W29S1zsKZcy9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RlSc8K3Mmr5EybySHWrf4kp5jxQCbevJVvJG2oBM9FI=;
 b=XgjF2FSoL05CNs1kUf/zwep0+uT7TzFpphdI3iBuC4El84l54Tctph3kre5nqylsrnKNigUW9ORzzj2pqkOVrR6cAy6KGlJp5cZUBmYM6musbjKhR3GMcmx7Q9v8S9038lVhLAosPba9bqfPtMEuqbdLB26IytUsAXhZNNfx86u8pOB/vWYt+TeVSRrhqLHITqJ0wzX9P+eAB+e17U648aeTW1s8qpzFgR8QYzM8nK6fJtHm98jJ+wCJAM559fZTpDctIpWNx9jef1VT95rcAw30UDwuTy/sVm6286NwLL+0qb3Xg6MNYsGU0iJRpopTteIRG20qOWRR0yHDd5iQzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RlSc8K3Mmr5EybySHWrf4kp5jxQCbevJVvJG2oBM9FI=;
 b=mR/jDq1VATR/vYmXo2fpJA7La5xxuOrh6uuTMhoAlPBg4Bw+F87bjXdH5VEIXVY91EbgZHDwOEbSiX6QE/IP57+b6AA4lgiHw+r/BmCD/baMJu1ChE/RzsJfxo4KD4Eg/xlwjrzP4s+1l6VSpFBJWe8F4t5xKIEgfKoO/5R5BV1NV4bexJMeANFOU2zAkHmC0ladeHNcrnHbaK+IQlHQ+0UUCjsfcgV1HcpafrabYygcFRoRNiCUmPJf+q9YINraQmExh/ArzT6Iz4TMHlNT6+NUBpCM0TtuKYA5IK4BHVE/UH8S6dAUgRvEDyqBOnxHgbnWXrlpx6RY+eckfrj5Bw==
Received: from PA4PR03MB7136.eurprd03.prod.outlook.com (2603:10a6:102:ea::23)
 by GV2PR03MB8876.eurprd03.prod.outlook.com (2603:10a6:150:c0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.23; Fri, 27 Oct
 2023 06:28:11 +0000
Received: from PA4PR03MB7136.eurprd03.prod.outlook.com
 ([fe80::2211:9053:228e:4e40]) by PA4PR03MB7136.eurprd03.prod.outlook.com
 ([fe80::2211:9053:228e:4e40%3]) with mapi id 15.20.6933.022; Fri, 27 Oct 2023
 06:28:11 +0000
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
Subject: [RFC v5 4/5] pinctrl: Implementation of the generic scmi-pinctrl
 driver
Thread-Topic: [RFC v5 4/5] pinctrl: Implementation of the generic scmi-pinctrl
 driver
Thread-Index: AQHaCJ7BvsPs7k1mWECVtUOTfrRG8A==
Date:   Fri, 27 Oct 2023 06:28:11 +0000
Message-ID: <18df975e571e0d81fc38b55626e8c4afbcf6a647.1698353854.git.oleksii_moisieiev@epam.com>
References: <cover.1698353854.git.oleksii_moisieiev@epam.com>
In-Reply-To: <cover.1698353854.git.oleksii_moisieiev@epam.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR03MB7136:EE_|GV2PR03MB8876:EE_
x-ms-office365-filtering-correlation-id: 0644f366-69c3-404b-eb08-08dbd6b5e45b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YRNi0ewaOy55iTCw4YndKw7VsgkT7xquUt83+chdoRtqfQtlEEdI9m9GxRsTZKvTRCX3xxZyH4HwV+eQlC9de1Hq/iw2wbVl21xqqA3jYq73ojSO/aE3/79zTg+IvKZfxRVdZwmlE69s5GoUCISGfgdmPF1K8bwsR7ma+M9IlYfnWpw6e9nwBwcqiDn9RrgP23KmrpMmlEhFwsB+e88LtGpRAt4g64RTkJCPQROgqfDMvw4oB9Ui4Zu2TeTdtiUgb4qUBEgVVMvQtnG/a850qw5mNPPTfF0HItbFQ2z5rupNd593WixQUn4CZs0syCMOrHeKnmxhqKF3eG3RMCl2m++w4QanQ7U7spvBbolhmxYN2KniOV56pRjqbshUwKBaG666vuGq0MVDFv3SkubnCpsVoW61i4x4qeAAun+E1aIe0NUQw97Guy+TkCiOyG72XKhRaB3m8gROkm2kpy/ZVg1yI7DfBSrIM5iN2J7ni+3o7okfQxwLqDYwffjhtVoON3J1RuQdYLcD7wU9JPJXl8ifXuFWm7UpNlWDMl+KZeJgMbb8TGtxRLpqqhbhdlTQGwQwpRpbBucuQwAj9kAYpxMLz4JG6IlfAle2u5hF+0NsJkfXcyN90YscvXfBj5bbljHD4jlmsVoscp+LBkoUlQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR03MB7136.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(376002)(396003)(346002)(366004)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(2906002)(478600001)(6486002)(83380400001)(36756003)(86362001)(8936002)(7416002)(4326008)(30864003)(8676002)(26005)(5660300002)(38070700009)(41300700001)(2616005)(66476007)(66556008)(66446008)(64756008)(66946007)(54906003)(91956017)(6916009)(316002)(76116006)(38100700002)(6512007)(122000001)(71200400001)(6506007)(41533002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?KHgq4xaFDyw35BYcTiGOATcsctSKqjxqOgGQF2E67+YjRRHy7n+58+zGUP?=
 =?iso-8859-1?Q?ksmeDtwlnc/FUWqkVzs56Xa2aIQ9JzLcHaQQUQ/nNDUBougoAcv/EMK4Ap?=
 =?iso-8859-1?Q?r74I4ER7Tw258OFPv54mrbnvDwGPHCX6srV9kxZhxNR2bx4Q9U2rMDgR71?=
 =?iso-8859-1?Q?bGdlaScBcuwa5vFQ4uaryMAaFE+TRjrAG+7lZbcDFdGzByQPtVq0RVeWWx?=
 =?iso-8859-1?Q?1ZdpuNvQ5aSnOH2cJnr87/Ox859dkAkkjfeVDIer9T6b4LFmzK7jisiZob?=
 =?iso-8859-1?Q?gr0KpMpYP23PW2gZqZ2igK0aUx2Y/683W8KNbB49jAaxfKUrYZ6vKT1YG8?=
 =?iso-8859-1?Q?ULcu2y4UO/c13swxq7it/W4dT5cXtkBwciDz60WqMmfkH6Vw44dEEgKdzI?=
 =?iso-8859-1?Q?iU3Oxsy5RvbM0zcgWjvA1PQnsymMvqhe9IKRrQpGGqBBr7ij+TmtiYO/Un?=
 =?iso-8859-1?Q?7lNGUz2KJik2YLysNCeg45i1s283t1CFJTjU+vY3mPhlEOpyiIRKLTO8hR?=
 =?iso-8859-1?Q?p5GjEKA3mN4Ki9UI5UoV0unZaFpExFwWG0j8AyfJT9p9yoM3C64xlYTe+P?=
 =?iso-8859-1?Q?hPP2WYYlfmR4LyFD7ajfge/12Rw/la8aVe+CnRbxeIMvl1fRqUaXGPs5xx?=
 =?iso-8859-1?Q?iKAaVU3AkISn0SxB67cFTmLiEloGte/etS6vJpuiAW5+FtGOZtegMqVluF?=
 =?iso-8859-1?Q?88B+DSTe0rwm61gxxclHDoiYQhsg2z3XsaRqJifHlgbYnrjYU25+a77UG9?=
 =?iso-8859-1?Q?LAzbNXt/0coRa5ObbtxbU86TsxctPA/fIJjcAWfQjcC3ks25Xkt/M7nJv1?=
 =?iso-8859-1?Q?+Cuq16Bfc4Xo/t8Cqoud40FHQzMMu17yAGEMprfvvNTFxZod41/oAT/XVF?=
 =?iso-8859-1?Q?edvHemNZzblleyawLvsTBSW8kxkswYAILS04HEN3Y9C/UJJzsfDrnCicTd?=
 =?iso-8859-1?Q?EyBmxDVtX2Pn6EPScTo5TaIhSxITaPPmO4NOiPnN3oqI1OcVxS36zYe9Pb?=
 =?iso-8859-1?Q?GN+1XTynf1boaR9h0RZh0gLUYcRkM/H5H1WCtGcPeGJREMiw3EX39zCLyH?=
 =?iso-8859-1?Q?xBB1JkjeNCkUBAbfm+FTrBhofC3+INGokl9jLMWY99Msdo/GWlo1q7Hp1r?=
 =?iso-8859-1?Q?RG8FMmqNU61SaE2rrtjKC4R9IkrqeQRWzlr4C0TgY0/1EYZ+4m4eR5OuKw?=
 =?iso-8859-1?Q?WhrxK+LqvJBOl0skxSFCfI1pNr8zM5xVCj3oUJL4ONHHV1Z9ESvQf9crs9?=
 =?iso-8859-1?Q?XTasRubDSOqOcfNhDA94pG7oO2pp1h787r6gm88CgVSt7GMHjDGUWGN/5z?=
 =?iso-8859-1?Q?4auvFeYnVmb1shD+mTbpflILi/yDCIruWJEAuEJaW+7tugoBvy3XCUOuDx?=
 =?iso-8859-1?Q?KZ0swYYWc50OxcBiD88E2WFU76S5pCx7N3DoZEFHtCYW6VohoOE40zNpzA?=
 =?iso-8859-1?Q?mYyhIC4GUjqI2X1PgVVl8tRw7vANbHKFZ+3VNEFFg74ibUBPJCcbxAznSn?=
 =?iso-8859-1?Q?iN8EmeWD10uHwJCJZsgBZF+EMD6JImSWVEgq7oCNKpZumu+tTB299TqBE9?=
 =?iso-8859-1?Q?gd2yVPwDdnun16H/6xzcogyAxnk3NG5Z4FC/SLooLfO9FkS9YCbsx9TsrS?=
 =?iso-8859-1?Q?CnWfl+Jr27YcZ0SYhWN0h/Dd1DAQ0+uMqeFon2+0IjGUnpxCzCbRQ24Q?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR03MB7136.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0644f366-69c3-404b-eb08-08dbd6b5e45b
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2023 06:28:11.1704
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mOykIjIEze7ZBQzhn9z8jMiWtZbFyRmH1qw8QEuPkYjuq8N0LWrNDvkhZQWrztp/gsy5c7TcaJb7+s3/+CrVTSG9ERaaRcnd/CntkM2Ot14=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR03MB8876
X-Proofpoint-ORIG-GUID: 8TIgnljtwuUq-O5H7OhR19eBWKl8rZ3o
X-Proofpoint-GUID: 8TIgnljtwuUq-O5H7OhR19eBWKl8rZ3o
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

scmi-pinctrl driver implements pinctrl driver interface and using
SCMI protocol to redirect messages from pinctrl subsystem SDK to
SCMI platform firmware, which does the changes in HW.

Signed-off-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
---
Changes v3 -> v4
  - ordered config option alphabetically
  - ordered object file alphabetically
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
---
 MAINTAINERS                    |   1 +
 drivers/pinctrl/Kconfig        |  11 +
 drivers/pinctrl/Makefile       |   1 +
 drivers/pinctrl/pinctrl-scmi.c | 445 +++++++++++++++++++++++++++++++++
 4 files changed, 458 insertions(+)
 create mode 100644 drivers/pinctrl/pinctrl-scmi.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 2d81d00e5f4f..c4e36f955e53 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20527,6 +20527,7 @@ M:	Oleksii Moisieiev <oleksii_moisieiev@epam.com>
 L:	linux-arm-kernel@lists.infradead.org
 S:	Maintained
 F:	drivers/firmware/arm_scmi/pinctrl.c
+F:	drivers/pinctrl/pinctrl-scmi.c
=20
 SYSTEM RESET/SHUTDOWN DRIVERS
 M:	Sebastian Reichel <sre@kernel.org>
diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
index 5787c579dcf6..956cfe76fbc6 100644
--- a/drivers/pinctrl/Kconfig
+++ b/drivers/pinctrl/Kconfig
@@ -428,6 +428,17 @@ config PINCTRL_ROCKCHIP
 	help
           This support pinctrl and GPIO driver for Rockchip SoCs.
=20
+config PINCTRL_SCMI
+	tristate "Pinctrl driver using SCMI protocol interface"
+	depends on ARM_SCMI_PROTOCOL || COMPILE_TEST
+	select PINMUX
+	select GENERIC_PINCONF
+	help
+	  This driver provides support for pinctrl which is controlled
+	  by firmware that implements the SCMI interface.
+	  It uses SCMI Message Protocol to interact with the
+	  firmware providing all the pinctrl controls.
+
 config PINCTRL_SINGLE
 	tristate "One-register-per-pin type device tree based pinctrl driver"
 	depends on OF
diff --git a/drivers/pinctrl/Makefile b/drivers/pinctrl/Makefile
index e196c6e324ad..25d67bac9ee0 100644
--- a/drivers/pinctrl/Makefile
+++ b/drivers/pinctrl/Makefile
@@ -44,6 +44,7 @@ obj-$(CONFIG_PINCTRL_PIC32)	+=3D pinctrl-pic32.o
 obj-$(CONFIG_PINCTRL_PISTACHIO)	+=3D pinctrl-pistachio.o
 obj-$(CONFIG_PINCTRL_RK805)	+=3D pinctrl-rk805.o
 obj-$(CONFIG_PINCTRL_ROCKCHIP)	+=3D pinctrl-rockchip.o
+obj-$(CONFIG_PINCTRL_SCMI)	+=3D pinctrl-scmi.o
 obj-$(CONFIG_PINCTRL_SINGLE)	+=3D pinctrl-single.o
 obj-$(CONFIG_PINCTRL_ST) 	+=3D pinctrl-st.o
 obj-$(CONFIG_PINCTRL_STMFX) 	+=3D pinctrl-stmfx.o
diff --git a/drivers/pinctrl/pinctrl-scmi.c b/drivers/pinctrl/pinctrl-scmi.=
c
new file mode 100644
index 000000000000..4d16f3c10eef
--- /dev/null
+++ b/drivers/pinctrl/pinctrl-scmi.c
@@ -0,0 +1,445 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * System Control and Power Interface (SCMI) Protocol based pinctrl driver
+ *
+ * Copyright (C) 2023 EPAM
+ */
+
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/module.h>
+#include <linux/seq_file.h>
+#include <linux/scmi_protocol.h>
+#include <linux/slab.h>
+
+#include <linux/pinctrl/machine.h>
+#include <linux/pinctrl/pinconf.h>
+#include <linux/pinctrl/pinconf-generic.h>
+#include <linux/pinctrl/pinctrl.h>
+#include <linux/pinctrl/pinmux.h>
+
+#include "pinctrl-utils.h"
+#include "core.h"
+#include "pinconf.h"
+
+#define DRV_NAME "scmi-pinctrl"
+
+static const struct scmi_pinctrl_proto_ops *pinctrl_ops;
+
+struct scmi_pinctrl_funcs {
+	unsigned int num_groups;
+	const char **groups;
+};
+
+struct scmi_pinctrl {
+	struct device *dev;
+	struct scmi_protocol_handle *ph;
+	struct pinctrl_dev *pctldev;
+	struct pinctrl_desc pctl_desc;
+	struct scmi_pinctrl_funcs *functions;
+	unsigned int nr_functions;
+	char **groups;
+	unsigned int nr_groups;
+	struct pinctrl_pin_desc *pins;
+	unsigned int nr_pins;
+};
+
+static int pinctrl_scmi_get_groups_count(struct pinctrl_dev *pctldev)
+{
+	struct scmi_pinctrl *pmx =3D pinctrl_dev_get_drvdata(pctldev);
+
+	return pinctrl_ops->count_get(pmx->ph, GROUP_TYPE);
+}
+
+static const char *pinctrl_scmi_get_group_name(struct pinctrl_dev *pctldev=
, unsigned int selector)
+{
+	int ret;
+	const char *name;
+	struct scmi_pinctrl *pmx =3D pinctrl_dev_get_drvdata(pctldev);
+
+	ret =3D pinctrl_ops->name_get(pmx->ph, selector, GROUP_TYPE, &name);
+	if (ret) {
+		dev_err(pmx->dev, "get name failed with err %d", ret);
+		return NULL;
+	}
+
+	return name;
+}
+
+static int pinctrl_scmi_get_group_pins(struct pinctrl_dev *pctldev,
+				       unsigned int selector,
+				       const unsigned int **pins,
+				       unsigned int *num_pins)
+{
+	struct scmi_pinctrl *pmx =3D pinctrl_dev_get_drvdata(pctldev);
+
+	return pinctrl_ops->group_pins_get(pmx->ph, selector, pins, num_pins);
+}
+
+#ifdef CONFIG_OF
+static int pinctrl_scmi_dt_node_to_map(struct pinctrl_dev *pctldev,
+				       struct device_node *np_config,
+				       struct pinctrl_map **map,
+				       u32 *num_maps)
+{
+	return pinconf_generic_dt_node_to_map(pctldev, np_config, map, num_maps,
+					      PIN_MAP_TYPE_INVALID);
+}
+
+static void pinctrl_scmi_dt_free_map(struct pinctrl_dev *pctldev, struct p=
inctrl_map *map,
+				     u32 num_maps)
+{
+	kfree(map);
+}
+
+#endif /* CONFIG_OF */
+
+static const struct pinctrl_ops pinctrl_scmi_pinctrl_ops =3D {
+	.get_groups_count =3D pinctrl_scmi_get_groups_count,
+	.get_group_name =3D pinctrl_scmi_get_group_name,
+	.get_group_pins =3D pinctrl_scmi_get_group_pins,
+#ifdef CONFIG_OF
+	.dt_node_to_map =3D pinctrl_scmi_dt_node_to_map,
+	.dt_free_map =3D pinctrl_scmi_dt_free_map,
+#endif
+};
+
+static int pinctrl_scmi_get_functions_count(struct pinctrl_dev *pctldev)
+{
+	struct scmi_pinctrl *pmx =3D pinctrl_dev_get_drvdata(pctldev);
+
+	return pinctrl_ops->count_get(pmx->ph, FUNCTION_TYPE);
+}
+
+static const char *pinctrl_scmi_get_function_name(struct pinctrl_dev *pctl=
dev,
+						  unsigned int selector)
+{
+	int ret;
+	const char *name;
+	struct scmi_pinctrl *pmx =3D pinctrl_dev_get_drvdata(pctldev);
+
+	ret =3D pinctrl_ops->name_get(pmx->ph, selector, FUNCTION_TYPE, &name);
+	if (ret) {
+		dev_err(pmx->dev, "get name failed with err %d", ret);
+		return NULL;
+	}
+
+	return name;
+}
+
+static int pinctrl_scmi_get_function_groups(struct pinctrl_dev *pctldev,
+					    unsigned int selector,
+					    const char * const **groups,
+					    unsigned int * const num_groups)
+{
+	const unsigned int *group_ids;
+	int ret, i;
+	struct scmi_pinctrl *pmx =3D pinctrl_dev_get_drvdata(pctldev);
+
+	if (!groups || !num_groups)
+		return -EINVAL;
+
+	if (selector < pmx->nr_functions &&
+	    pmx->functions[selector].num_groups) {
+		*groups =3D (const char * const *)pmx->functions[selector].groups;
+		*num_groups =3D pmx->functions[selector].num_groups;
+		return 0;
+	}
+
+	ret =3D pinctrl_ops->function_groups_get(pmx->ph, selector,
+					       &pmx->functions[selector].num_groups,
+					       &group_ids);
+	if (ret) {
+		dev_err(pmx->dev, "Unable to get function groups, err %d", ret);
+		return ret;
+	}
+
+	*num_groups =3D pmx->functions[selector].num_groups;
+	if (!*num_groups)
+		return -EINVAL;
+
+	pmx->functions[selector].groups =3D
+		devm_kcalloc(pmx->dev, *num_groups, sizeof(*pmx->functions[selector].gro=
ups),
+			     GFP_KERNEL);
+	if (!pmx->functions[selector].groups)
+		return -ENOMEM;
+
+	for (i =3D 0; i < *num_groups; i++) {
+		pmx->functions[selector].groups[i] =3D
+			pinctrl_scmi_get_group_name(pmx->pctldev,
+						    group_ids[i]);
+		if (!pmx->functions[selector].groups[i]) {
+			ret =3D -ENOMEM;
+			goto err_free;
+		}
+	}
+
+	*groups =3D (const char * const *)pmx->functions[selector].groups;
+
+	return 0;
+
+err_free:
+	devm_kfree(pmx->dev, pmx->functions[selector].groups);
+
+	return ret;
+}
+
+static int pinctrl_scmi_func_set_mux(struct pinctrl_dev *pctldev, unsigned=
 int selector,
+				     unsigned int group)
+{
+	struct scmi_pinctrl *pmx =3D pinctrl_dev_get_drvdata(pctldev);
+
+	return pinctrl_ops->mux_set(pmx->ph, selector, group);
+}
+
+static int pinctrl_scmi_request(struct pinctrl_dev *pctldev, unsigned int =
offset)
+{
+	struct scmi_pinctrl *pmx =3D pinctrl_dev_get_drvdata(pctldev);
+
+	return pinctrl_ops->pin_request(pmx->ph, offset);
+}
+
+static int pinctrl_scmi_free(struct pinctrl_dev *pctldev, unsigned int off=
set)
+{
+	struct scmi_pinctrl *pmx =3D pinctrl_dev_get_drvdata(pctldev);
+
+	return pinctrl_ops->pin_free(pmx->ph, offset);
+}
+
+static const struct pinmux_ops pinctrl_scmi_pinmux_ops =3D {
+	.request =3D pinctrl_scmi_request,
+	.free =3D pinctrl_scmi_free,
+	.get_functions_count =3D pinctrl_scmi_get_functions_count,
+	.get_function_name =3D pinctrl_scmi_get_function_name,
+	.get_function_groups =3D pinctrl_scmi_get_function_groups,
+	.set_mux =3D pinctrl_scmi_func_set_mux,
+};
+
+static int pinctrl_scmi_pinconf_get(struct pinctrl_dev *pctldev, unsigned =
int _pin,
+				    unsigned long *config)
+{
+	int ret;
+	struct scmi_pinctrl *pmx =3D pinctrl_dev_get_drvdata(pctldev);
+	enum pin_config_param config_type;
+	unsigned long config_value;
+
+	if (!config)
+		return -EINVAL;
+
+	config_type =3D pinconf_to_config_param(*config);
+
+	ret =3D pinctrl_ops->config_get(pmx->ph, _pin, PIN_TYPE, config_type, &co=
nfig_value);
+	if (ret)
+		return ret;
+
+	*config =3D pinconf_to_config_packed(config_type, config_value);
+
+	return 0;
+}
+
+static int pinctrl_scmi_pinconf_set(struct pinctrl_dev *pctldev,
+				    unsigned int _pin,
+				    unsigned long *configs,
+				    unsigned int num_configs)
+{
+	int i, ret;
+	struct scmi_pinctrl *pmx =3D pinctrl_dev_get_drvdata(pctldev);
+	enum pin_config_param config_type;
+	unsigned long config_value;
+
+	if (!configs || num_configs =3D=3D 0)
+		return -EINVAL;
+
+	for (i =3D 0; i < num_configs; i++) {
+		config_type =3D pinconf_to_config_param(configs[i]);
+		config_value =3D pinconf_to_config_argument(configs[i]);
+
+		ret =3D pinctrl_ops->config_set(pmx->ph, _pin, PIN_TYPE,
+					      num_configs, (u8 *)&config_type,
+					      &config_value);
+		if (ret) {
+			dev_err(pmx->dev, "Error parsing config %ld\n",
+				configs[i]);
+			break;
+		}
+	}
+
+	return ret;
+}
+
+static int pinctrl_scmi_pinconf_group_set(struct pinctrl_dev *pctldev,
+					  unsigned int group,
+					  unsigned long *configs,
+					  unsigned int num_configs)
+{
+	int i, ret;
+	struct scmi_pinctrl *pmx =3D  pinctrl_dev_get_drvdata(pctldev);
+	enum pin_config_param config_type;
+	unsigned long config_value;
+
+	if (!configs || num_configs =3D=3D 0)
+		return -EINVAL;
+
+	for (i =3D 0; i < num_configs; i++) {
+		config_type =3D pinconf_to_config_param(configs[i]);
+		config_value =3D pinconf_to_config_argument(configs[i]);
+
+		ret =3D pinctrl_ops->config_set(pmx->ph, group, GROUP_TYPE,
+					      num_configs, (u8 *)&config_type,
+					      &config_value);
+		if (ret) {
+			dev_err(pmx->dev, "Error parsing config =3D %ld",
+				configs[i]);
+			break;
+		}
+	}
+
+	return ret;
+};
+
+static int pinctrl_scmi_pinconf_group_get(struct pinctrl_dev *pctldev,
+					  unsigned int group,
+					  unsigned long *config)
+{
+	int ret;
+	struct scmi_pinctrl *pmx =3D pinctrl_dev_get_drvdata(pctldev);
+	enum pin_config_param config_type;
+	unsigned long config_value;
+
+	if (!config)
+		return -EINVAL;
+
+	config_type =3D pinconf_to_config_param(*config);
+
+	ret =3D pinctrl_ops->config_get(pmx->ph, group, GROUP_TYPE, config_type, =
&config_value);
+	if (ret)
+		return ret;
+
+	*config =3D pinconf_to_config_packed(config_type, config_value);
+
+	return 0;
+}
+
+static const struct pinconf_ops pinctrl_scmi_pinconf_ops =3D {
+	.is_generic =3D true,
+	.pin_config_get =3D pinctrl_scmi_pinconf_get,
+	.pin_config_set =3D pinctrl_scmi_pinconf_set,
+	.pin_config_group_set =3D pinctrl_scmi_pinconf_group_set,
+	.pin_config_group_get =3D pinctrl_scmi_pinconf_group_get,
+	.pin_config_config_dbg_show =3D pinconf_generic_dump_config,
+};
+
+static int pinctrl_scmi_get_pins(struct scmi_pinctrl *pmx,
+				 unsigned int *nr_pins,
+				 const struct pinctrl_pin_desc **pins)
+{
+	int ret, i;
+
+	if (!pins || !nr_pins)
+		return -EINVAL;
+
+	if (pmx->nr_pins) {
+		*pins =3D pmx->pins;
+		*nr_pins =3D pmx->nr_pins;
+		return 0;
+	}
+
+	*nr_pins =3D pinctrl_ops->count_get(pmx->ph, PIN_TYPE);
+
+	pmx->nr_pins =3D *nr_pins;
+	pmx->pins =3D devm_kmalloc_array(pmx->dev, *nr_pins, sizeof(*pmx->pins), =
GFP_KERNEL);
+	if (!pmx->pins)
+		return -ENOMEM;
+
+	for (i =3D 0; i < *nr_pins; i++) {
+		pmx->pins[i].number =3D i;
+		ret =3D pinctrl_ops->name_get(pmx->ph, i, PIN_TYPE, &pmx->pins[i].name);
+		if (ret) {
+			dev_err(pmx->dev, "Can't get name for pin %d: rc %d", i, ret);
+			pmx->nr_pins =3D 0;
+			return ret;
+		}
+	}
+
+	*pins =3D pmx->pins;
+	dev_dbg(pmx->dev, "got pins %d", *nr_pins);
+
+	return 0;
+}
+
+static const struct scmi_device_id scmi_id_table[] =3D {
+	{ SCMI_PROTOCOL_PINCTRL, "pinctrl" },
+	{ }
+};
+MODULE_DEVICE_TABLE(scmi, scmi_id_table);
+
+static int scmi_pinctrl_probe(struct scmi_device *sdev)
+{
+	int ret;
+	struct device *dev =3D &sdev->dev;
+	struct scmi_pinctrl *pmx;
+	const struct scmi_handle *handle;
+	struct scmi_protocol_handle *ph;
+
+	if (!sdev || !sdev->handle)
+		return -EINVAL;
+
+	handle =3D sdev->handle;
+
+	pinctrl_ops =3D handle->devm_protocol_get(sdev, SCMI_PROTOCOL_PINCTRL, &p=
h);
+	if (IS_ERR(pinctrl_ops))
+		return PTR_ERR(pinctrl_ops);
+
+	pmx =3D devm_kzalloc(dev, sizeof(*pmx), GFP_KERNEL);
+	if (!pmx)
+		return -ENOMEM;
+
+	pmx->ph =3D ph;
+
+	pmx->dev =3D dev;
+	pmx->pctl_desc.name =3D DRV_NAME;
+	pmx->pctl_desc.owner =3D THIS_MODULE;
+	pmx->pctl_desc.pctlops =3D &pinctrl_scmi_pinctrl_ops;
+	pmx->pctl_desc.pmxops =3D &pinctrl_scmi_pinmux_ops;
+	pmx->pctl_desc.confops =3D &pinctrl_scmi_pinconf_ops;
+
+	ret =3D pinctrl_scmi_get_pins(pmx, &pmx->pctl_desc.npins,
+				    &pmx->pctl_desc.pins);
+	if (ret)
+		return ret;
+
+	ret =3D devm_pinctrl_register_and_init(dev, &pmx->pctl_desc, pmx, &pmx->p=
ctldev);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to register pinctrl\n");
+
+	pmx->nr_functions =3D pinctrl_scmi_get_functions_count(pmx->pctldev);
+	pmx->nr_groups =3D pinctrl_scmi_get_groups_count(pmx->pctldev);
+
+	if (pmx->nr_functions) {
+		pmx->functions =3D
+			devm_kcalloc(dev, pmx->nr_functions, sizeof(*pmx->functions),
+				     GFP_KERNEL);
+		if (!pmx->functions)
+			return -ENOMEM;
+	}
+
+	if (pmx->nr_groups) {
+		pmx->groups =3D
+			devm_kcalloc(dev, pmx->nr_groups, sizeof(*pmx->groups), GFP_KERNEL);
+		if (!pmx->groups)
+			return -ENOMEM;
+	}
+
+	return pinctrl_enable(pmx->pctldev);
+}
+
+static struct scmi_driver scmi_pinctrl_driver =3D {
+	.name =3D DRV_NAME,
+	.probe =3D scmi_pinctrl_probe,
+	.id_table =3D scmi_id_table,
+};
+module_scmi_driver(scmi_pinctrl_driver);
+
+MODULE_AUTHOR("Oleksii Moisieiev <oleksii_moisieiev@epam.com>");
+MODULE_DESCRIPTION("ARM SCMI pin controller driver");
+MODULE_LICENSE("GPL");
--=20
2.25.1
