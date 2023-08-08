Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8471B7749E4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 22:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232839AbjHHUFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 16:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232575AbjHHUFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 16:05:41 -0400
Received: from mx0b-0039f301.pphosted.com (mx0b-0039f301.pphosted.com [148.163.137.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41A21995E9;
        Tue,  8 Aug 2023 11:25:58 -0700 (PDT)
Received: from pps.filterd (m0174683.ppops.net [127.0.0.1])
        by mx0b-0039f301.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 378E6eP0003021;
        Tue, 8 Aug 2023 18:25:41 GMT
Received: from eur01-ve1-obe.outbound.protection.outlook.com (mail-ve1eur01lp2057.outbound.protection.outlook.com [104.47.1.57])
        by mx0b-0039f301.pphosted.com (PPS) with ESMTPS id 3sbpek1ayb-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Aug 2023 18:25:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KdvVdeu+RU6Sc6eEUsbQjPdeVbu4Oo/GL+N/cjKYEWq/hNPZy5i3vyRgvVQnwXFV9uSRgVHyYpp+v0QW3UIVfHeEl9zMENpzq1MZj4vGw+QPe7pgieG94vifryT71V7i6Nko8/YQ0XSGPoiY2tN9IIAkz1zOb0xN4KxaNKjMjriV3WkNDzJLKFVQFOIyrQKaeGLgq6mZJqAuL6qoSE0rgl+6kasQ3MCFo5wUnEn4mFz+gYxyyFhrkBmNxZbzZacFl7Aki1EJ7rtUds0vQ/uoLLkkJ/w5IdBwGHizVH733GB6Gz22uZGtbQ4kEiVEm4eOnWJNmY7SaqOdgdYAOUkL3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XbXUf6iwHQKvVKz2R1zpycWz3RU1c3HEs95mk4A/Ogo=;
 b=mlZQYLRRY1ztGDCnNw79cLA88Omio/p3Hrmr+sy/0CB+uZgUn2eqRXCkWbIoFU/wk6icz7L0vvVdeVyYbDmT/0sHnnxJJTeMIE5kp84+YHXV4ikBQiYJi27nkshztYsCQM3HTNai1oITINgAH4kGMK66F9pzg1e3gVUMfjwU2BHmslTE+Lxrew/8JpSm6yilwLO9zjUUkgEJlXHAtuSMdjSUjBa2RHjf4zoUglkfvfn3kM4N6dRFrl92Ipryi06l3GtLdpVB/sGv/u6JW+Oc8bVMqGVi0Q+HhwomTYvgSmakxIkcdA3Gex/3NfzFvnbUoY7oBSSBQURWP1IsimRlAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XbXUf6iwHQKvVKz2R1zpycWz3RU1c3HEs95mk4A/Ogo=;
 b=jd5Y+bkJ17z9ysfVUFujCdfvl3uv224F6pU1Jy61PFevwJwRhow3AqrD/cY6s+8w2yUtd4Wlc9tAdhmWZTvQC5blCIHpA/1tM0YvxvjjiVW2blZZT7M9hf0MCo69T9BeIKngva4SsxPDaTSMlArRIjJnrM8pUYTzgCqQ3DTKOTuuEqrrp+jm8IPEwbp/yzPAdCDdfPNZ0qzoLqd2jwvFxlKKpX9SAT0IxNQ/YkPzsdH/0kPHjKSK+jxaTHcew71TapnWil6wYrVo8GghqoQhllopiEjMrAXmVeC3np3B9KgnHwDupuSR/wO9+Cq70HKUgFUawgkerMlh2fmOZ33ekQ==
Received: from PA4PR03MB7136.eurprd03.prod.outlook.com (2603:10a6:102:ea::23)
 by AS4PR03MB8458.eurprd03.prod.outlook.com (2603:10a6:20b:519::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Tue, 8 Aug
 2023 18:25:36 +0000
Received: from PA4PR03MB7136.eurprd03.prod.outlook.com
 ([fe80::ccb5:5aee:f10d:ab26]) by PA4PR03MB7136.eurprd03.prod.outlook.com
 ([fe80::ccb5:5aee:f10d:ab26%4]) with mapi id 15.20.6652.026; Tue, 8 Aug 2023
 18:25:36 +0000
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
Subject: [PATCH v4 3/4] pinctrl: Implementation of the generic scmi-pinctrl
 driver
Thread-Topic: [PATCH v4 3/4] pinctrl: Implementation of the generic
 scmi-pinctrl driver
Thread-Index: AQHZyiW530DOZaR1WkuogwXI6KprGQ==
Date:   Tue, 8 Aug 2023 18:25:35 +0000
Message-ID: <a6cefa60500cd46313ad6cda4f13f4985c0f5237.1691518314.git.oleksii_moisieiev@epam.com>
References: <cover.1691518313.git.oleksii_moisieiev@epam.com>
In-Reply-To: <cover.1691518313.git.oleksii_moisieiev@epam.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR03MB7136:EE_|AS4PR03MB8458:EE_
x-ms-office365-filtering-correlation-id: 36488059-eb23-43e5-1bf4-08db983cdc07
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ie2vWbt50+c1Iu8/IB9XDqw4kkSvPHKdQ1YQ4DipyEFIE852iywu3JPV02Eq1R67A8tu+nvQkreGD+O7h0ndQ/mIq5BpjuEP2jVC2y2n/d6SnRjzRCtMUMyraWwvy47hHKx9eZoXED8k8Lw/4KHZsz38Dq5WOwVdYcIatQFAe+fXuS7pdB0NcTSqp4pyjyFekMnHoNbWN+qqDyln0tHqH9SF7l7+bg+epEa8WQonhM73exmfFWpCXK2cPZ5Gah6da0PQnXGHyDDy3tqMFefBqiy/py+Hot+xnGAp2pUnz9Xh5cguhM3jLqgi0XzKO9Lblv0ELZ1NidvxBKvVsHVhf9h2/p+T53xo+wKBECy0yHQM9F/SMEnPNky8e3VmW8tc035EqngtKLlckHWeydre25MDNCIcU3BxW+BZgmnRfiIektNPMwHMAzQUdriyI+fJpWoul6rgXBksk6QOXUPYslVxPABgaRy/I54U/Kj7rRWMsfyfLXxkifYAtd5KN+sXcPyJi/BDqPluzanFcmiDrmJeP1XxW9hvSey8Xc4qutEHfr+22QHRq+1QIE5XQlphjyeFjm9hBf3QDB/d2gtsl5/OyyCJZTcwU0AKc2fK79CxPTLqQQ3rxzBgwTc1vPKEIi326PCh6o+pX0DZbgFybw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR03MB7136.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(366004)(346002)(136003)(451199021)(1800799003)(186006)(7416002)(38070700005)(8936002)(8676002)(5660300002)(64756008)(4326008)(6916009)(41300700001)(316002)(83380400001)(86362001)(30864003)(2906002)(6512007)(6486002)(71200400001)(2616005)(6506007)(26005)(36756003)(76116006)(66476007)(91956017)(66556008)(66946007)(66446008)(478600001)(122000001)(54906003)(38100700002)(41533002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?I5j7qVA8Wr7xJ/s9hHbB4y5jO6FobDks/6P5NTxAoqWF2aovgBTQ62seeq?=
 =?iso-8859-1?Q?1XP3rFITAKv/wa1BenajZZDDzpld7/szI6QEUnGdwwDBDnzuLKPU53e1Ac?=
 =?iso-8859-1?Q?wzwtsFC3BBXIhQio2AGRanGTheGc+FNP01hosMEvpHXl1/jYdxaigQDKVd?=
 =?iso-8859-1?Q?FaFwmz/aLD6DMq8EZvycH9EJW95tDJwv5qZvz8GNEAGRH3ajwWlQ/Xgrby?=
 =?iso-8859-1?Q?ytF0UbNsCO54aUL7arFkzBUvWLfx9QVh81ecqk6J7FS7HAux3bnMPeFApp?=
 =?iso-8859-1?Q?6kg/QTP8SdP0xUoYCDK3iehWRQgN/2TKywco5+59WQN5iDOJgkcV6KCv6p?=
 =?iso-8859-1?Q?/ETtxC88EeOnEsifELa9H7aVSIv9EJvUenxDaWx0rQnN9n92YEGP4W+x28?=
 =?iso-8859-1?Q?ssUi+k1DjAoEUwfbPv8TzNnmybZ8Cfmo6i4OvAjTnZ3H6Imz7lpu3aqRif?=
 =?iso-8859-1?Q?YRSgvC8p8y69Bp26TvdoN3MvbgxGAxi4zkeShG0cbiai93DLbwe++Ncbmk?=
 =?iso-8859-1?Q?pPkE9QaJkkfvvviOC+wLVmKbD7zVtvBU0HnLarAAK3u+w8nsuS6P0wvVRc?=
 =?iso-8859-1?Q?rvYZz2eeWOB//RFfjD4iwCtYx90sIWWaV3I5erRqdbI5bl1GeXUvr+PUkt?=
 =?iso-8859-1?Q?s+11leBdowPatxhy3CeVCPLlGaMul549r0Me5IQr0VoAeRti+WsQUYd59W?=
 =?iso-8859-1?Q?MEeAuQoqMPFn6J2ZAjJgc/fi6EEkbzA9jFV0iNeVVDgJdvKmcKyDa0OsT5?=
 =?iso-8859-1?Q?uucG6CkNHmj5Sd5JzvoyOfI2x6y8kDIShdEWfhI3wUCHgIJ4itzaanxgaU?=
 =?iso-8859-1?Q?d0xjFALRTVZg2PHVMgDV9FYiOF9mX8GMkSn2JpJspyfVxC1+u5qRWG4PES?=
 =?iso-8859-1?Q?36HLfD52fb7yqiYsKnBaWtmuDddpOK+WT+SKiGQ6x4BkrfTykqQhdBF0ts?=
 =?iso-8859-1?Q?tdV81WsgdxkauHTslN+q+uaH+rP7t6Q52s/58nH0GSF8DoKCxTJrGK9Q6L?=
 =?iso-8859-1?Q?UcFhArGe3ChujBR4js0uPWIOzhqVxk0JzUpVLDi3KxJMLgTin6f/eTxI0r?=
 =?iso-8859-1?Q?Xrfxd69VYJEuyDKYXOlgiAwTUsvo5tEjVzmPIAbVvlySRdrYYwv1x9NoEX?=
 =?iso-8859-1?Q?zEl4VNQzCpOFzyCsGpPwp90R1TY5ur8usmrghKwH4XMG9KoSjifiPZP7N3?=
 =?iso-8859-1?Q?ACqvZuSPvOttY0/FL3jR3Pi7X1TYe4V8T9E20CxWxxVMuwhnYdeOxVoBNS?=
 =?iso-8859-1?Q?ctKF7G8eLI+9qvdrO4DEoP8E/DOyZujj5r9OARSfRd7+d7G17/GAeXK5P6?=
 =?iso-8859-1?Q?VvRY0x6eAnclZW4FDDllYX+HD8YjJO5lWV6IWzgQreYgs7UAgLIblROO7t?=
 =?iso-8859-1?Q?h5LiQYvuW4jrqgahdWmuAUAEaknFtsixjeDIcZNpKQDW32fZ3FxBG1iUhH?=
 =?iso-8859-1?Q?OxhZozB7fPu+PDHmF7ZqQl2BB0oG84TOfDiNnkhi187f/peE5aBDH/p9GL?=
 =?iso-8859-1?Q?uRpZbbOIob4ufilsoLwgNcoEMRTelYrCmzYD66JmA4vXgbgneeveRf4gTZ?=
 =?iso-8859-1?Q?a8/vlr9lED1dTeGAUA2BcYpJh/G++yoYULD9rbJIVt2e7oztj10xkwJMXx?=
 =?iso-8859-1?Q?7jtvnO8pk7mC4Q2t5h3moLqL6jP4QDn9/xbj9nhyt3to35Dmr6KK09wg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR03MB7136.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36488059-eb23-43e5-1bf4-08db983cdc07
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2023 18:25:35.9350
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mTONncRb8eJhbCMYqJzlHbxBUzjvClmpon8LU9m21wVVahZeWuh9kzIio54fNVV6OIMTN1v8+RxS5z7cXWKdnPSzHbn1lguUyF4YwWEgcCs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR03MB8458
X-Proofpoint-ORIG-GUID: 8egXJJ6ajsGjn_JGVIC3-ibR57kgAJGH
X-Proofpoint-GUID: 8egXJJ6ajsGjn_JGVIC3-ibR57kgAJGH
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
 drivers/pinctrl/pinctrl-scmi.c | 442 +++++++++++++++++++++++++++++++++
 4 files changed, 455 insertions(+)
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
index 000000000000..a9304402ddf1
--- /dev/null
+++ b/drivers/pinctrl/pinctrl-scmi.c
@@ -0,0 +1,442 @@
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
+			GFP_KERNEL);
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
+		ret =3D pinctrl_ops->config_set(pmx->ph, _pin, PIN_TYPE, config_type, co=
nfig_value);
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
+		ret =3D pinctrl_ops->config_set(pmx->ph, group, GROUP_TYPE, config_type,
+					      config_value);
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
