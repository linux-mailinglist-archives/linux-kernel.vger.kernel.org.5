Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 004887D8EB4
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 08:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345302AbjJ0G2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 02:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345249AbjJ0G2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 02:28:39 -0400
Received: from mx0b-0039f301.pphosted.com (mx0b-0039f301.pphosted.com [148.163.137.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAC761B2;
        Thu, 26 Oct 2023 23:28:34 -0700 (PDT)
Received: from pps.filterd (m0174681.ppops.net [127.0.0.1])
        by mx0b-0039f301.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39QL6OQT007652;
        Fri, 27 Oct 2023 06:28:18 GMT
Received: from eur04-he1-obe.outbound.protection.outlook.com (mail-he1eur04lp2050.outbound.protection.outlook.com [104.47.13.50])
        by mx0b-0039f301.pphosted.com (PPS) with ESMTPS id 3tywqm92ds-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Oct 2023 06:28:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XPk6tD0JuYSTyzzwnF7lT9yxbSYWaOXRus/c4s5dQTnMrXUkRUhysGBfRaMla86FbZafuQc5ASAXXsOFg1vvmMRnT2UvQFW9lOP4b7iClLouwiSqIrLPYUNna3408C/1gtCMnKdThES6P+JJaC1bJNWHeGPUZqNtBQ43JiJ7vt5unQF2q/A3oeNwCo0qTtzA/TcUlmBy+m1IG6e5X47G+QsuN3xGRlC+qqDroe/ZVbf0h2adti/68LhR9HThr3MJOpjNVmMUtttKXZwQTcOVIazTHFlnjlu2P6CNetzUd6F36ysLaWVrEsgTSh8BGKma2op1KBOQCF8cH3qAZzo18w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NiJhqbJDGb5nQk51MEC4+J959pM4bvnOjwcGaqiFbII=;
 b=Qw7qnbdkrbisYji/o2ixQaXlf5UhpwGWNUYlWPC/RkmkcFtD9UmaQT+OJOqRgH0GVsfpSAYzlpRSxeCKc/+ZVZp9weCiXvWc7nLOwAIyGDwCvBtPIeuNaMstN4XSfPMUnsMB2gxBBSAHbaMP/ym2HJEiyulavqYrhGGyQhPik2JTXsGfsrO/ots1SLf7VthsEa+oX/1NpADJRBPzFkIMjb2jsLv7nAHv+iZwH5hfYQDB4/lsCCPtSCkFKhXekgOrWHlWA4EodFX9tskVnZ9PnOH29DXZP1NWYqzp57wGDEN7dA/57TOB1XKG7+e4qOaEHbV4YZoA4fZMV2lfqTWrYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NiJhqbJDGb5nQk51MEC4+J959pM4bvnOjwcGaqiFbII=;
 b=roA+LWqxK6NCgzaBhnIFe4exr7GinjON7ZaAPolgsZARqrHgUOIpVunI4tAbZl93OD+h8Ups89KlmwGyVkeY1tHECYpsscrJOqd1Sp9T4EuCsoiDmjPM3ctjY39NVIYIBucswdgybIxuNFEEaPhXmXGV2jMEnLyibsOAJ7fvqEEBz8IdmwKkk5OjC0yQCW/B4rK8m7LV53L15mQEbSPprxE/WOeqttf/4DJNgUfVoShrMOWwisxaI+ga2gbGVNgE6JTmgSA0TcYN0dUOUSGJJG98px3XPt7SzlH6luL7yVCtSc+OkmiLWj3JF8xLQQf20E3Fc8NtFHwnR6LSJ4jR8Q==
Received: from PA4PR03MB7136.eurprd03.prod.outlook.com (2603:10a6:102:ea::23)
 by GV2PR03MB8876.eurprd03.prod.outlook.com (2603:10a6:150:c0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.23; Fri, 27 Oct
 2023 06:28:10 +0000
Received: from PA4PR03MB7136.eurprd03.prod.outlook.com
 ([fe80::2211:9053:228e:4e40]) by PA4PR03MB7136.eurprd03.prod.outlook.com
 ([fe80::2211:9053:228e:4e40%3]) with mapi id 15.20.6933.022; Fri, 27 Oct 2023
 06:28:10 +0000
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
Subject: [RFC v5 3/5] firmware: arm_scmi: Add SCMI v3.2 pincontrol protocol
 basic support
Thread-Topic: [RFC v5 3/5] firmware: arm_scmi: Add SCMI v3.2 pincontrol
 protocol basic support
Thread-Index: AQHaCJ7BHuNsuhxPVE26Nd9OsaeoYw==
Date:   Fri, 27 Oct 2023 06:28:10 +0000
Message-ID: <7300b8804396075d2ae565f46de51a980ce846e6.1698353854.git.oleksii_moisieiev@epam.com>
References: <cover.1698353854.git.oleksii_moisieiev@epam.com>
In-Reply-To: <cover.1698353854.git.oleksii_moisieiev@epam.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR03MB7136:EE_|GV2PR03MB8876:EE_
x-ms-office365-filtering-correlation-id: 3443c274-c8c9-408f-3cbe-08dbd6b5e42c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LSKWE6Od/PCXC2NHcsB3Cq4pueSyqojBjpekLJKOavYVJtSe8zlRY70BXMh5nIij+KQs7CsfzsCvssE5bzSJemFOOOByVtvBtYAQvojj8L34bswonLotndOmtK/Zc5fjCrsya0U+9AXTPyRGwB9Gl60tZLPPaWXQGT29L8JdW9lUTm07O46skavMLK9uQ+4l3ha/yJsgMqq0YQz2A2Q0MVWBQFlS7xNPlQ/sHCaL3TW7tXki+flr63y70LMo/DPLUqtK7Fu+0xuOhS/T5WviS9pOArwu3GlFS2/iR0INaIjVhz4Wrvo97e6ECtRBBZfb7oGUjcMfPP5+FW8oNs6TNqIU1UF6Ky+5UKhyW6nYnBXNMFsXyZtw+Bk7uRqjR9Ow0g7oI7QNqrIpEHYZ//3Kpy8cINzg/51h6eai8TWKH3NUj/WfVfQoi2DGm3bO7VW7zH+43mhhozWkUu5YQ5mDEdKiy9gZATsjrHrJBEEaM2BcJlAIWcFA09tPxjfmE8RMt9ZmFjdpePZxm3UY/t588WbTGzT16aDpfn7E89uAMdGwA4VwwoHKtF0aagzK07tyKDDhuhW1P7AyRXTHU/9EwXM4SpZFsG+BX8oOkE8z2TUyvxbsnyj4e8oMO4ZMF+wS
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR03MB7136.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(376002)(396003)(346002)(366004)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(2906002)(478600001)(6486002)(83380400001)(36756003)(86362001)(8936002)(7416002)(4326008)(30864003)(8676002)(26005)(5660300002)(38070700009)(41300700001)(2616005)(66476007)(66556008)(66446008)(64756008)(66946007)(54906003)(91956017)(6916009)(316002)(76116006)(38100700002)(6512007)(122000001)(71200400001)(6506007)(559001)(579004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?HiAcH20lHWYph71Dn1RWveBdjE3Urv3oE6WvUwbUJej5A86+CcsP6Jss/Z?=
 =?iso-8859-1?Q?czuquO+INZQB3PQPaFQny2kNYy9BwAAt4kQqrNqN3UQ9neNS8sF8MsYuv2?=
 =?iso-8859-1?Q?sr67b6VNlC+6Kt87k9snqv83KZ9fqoN3jYQLyHcsmCz7YlRpMhittoimMZ?=
 =?iso-8859-1?Q?hT1Y/gG7KxgwqqCKZki0cNlHhgBW+zBHjVjWQQEGduz0SbZ865NPxDWbjm?=
 =?iso-8859-1?Q?SYMZ7bDjY4qV594ZUVmuAKCDDc0hkHvfQske7c6xYhIcSVsMRjWQccOYdM?=
 =?iso-8859-1?Q?uAh4Qj/+kx72MkaLirgvaApoiMk3fWcgEmPiVhrsFZMf2eOIm5MlhjoJON?=
 =?iso-8859-1?Q?NUDFpDlfgestNKltaOWl9utyu3gZzCDA4LDO18PC7z2Z7FnK5j77C9IUAd?=
 =?iso-8859-1?Q?MKWpd0f2dvAqvN7jLsbj7qdm2wpK1yvJHuFgEEu/fJ/tNWLwLvSI1fvnqE?=
 =?iso-8859-1?Q?SAu3y3iThnyd8Cth18Dal4fEaSWr6oaKFRpU53FvMHg6S3DZKN5q+Gx0YF?=
 =?iso-8859-1?Q?S+f0fPrD1qSwQ80/ZnbOm3WW+2nSk/TU8RuW7jez15cKpQsNWWsDkOPFGu?=
 =?iso-8859-1?Q?NlZq3kH3MOo5TPV0F+PWZJavEbwoqoasu3ITFRFz31R5yI8oamRR3jWcgl?=
 =?iso-8859-1?Q?p0gfr7NlEQivp3AvRDdEdyVUR4FuPnaIb2sMozK59zhKOVFtOfbTygXrAx?=
 =?iso-8859-1?Q?Ofk3l28i44Ey9COpzrKKlXrEk8F132PSeYiEYpQLImkXII5WWxMC668IWB?=
 =?iso-8859-1?Q?MpgbHG6cvapCTGSTsQrrWZkq79EORNgaO1ieerf/B/4waPp6j/TohVWNrJ?=
 =?iso-8859-1?Q?IoZ9x/B/rtup+0FQIV0GhSqlt9v/tV/cmCzBpOnAHO2MROhY9cKaPmjfaC?=
 =?iso-8859-1?Q?F1PZZsI0Ogdd1K3nuBMt2wAO1ZyfTcuI7q43DAXMT6O+6hseJciS5lRWLr?=
 =?iso-8859-1?Q?Yimd6WbH24vMHrPEE6e1qnuSqjUDS87G779PXus04KHc8k4MKfBAKtaYJj?=
 =?iso-8859-1?Q?OH55eswSp+RXsS6FYyWLvhWPD1U5+Pyvi0AD+13oCl1v6jhvYGs/4i/3tL?=
 =?iso-8859-1?Q?DRNUIW7OIkf2oDCtE5KGJJKp63/Uhu7CopzxcSE7tvlnCmrOMRPYt58Cj8?=
 =?iso-8859-1?Q?KVUk5L4qNVlsOax/ibcmBK8VQcFEzzZ+t9DbYNYkVSIz3Ig5IUXhOwpQnn?=
 =?iso-8859-1?Q?J2qq/TZg5so8aLVbR5u6g0ZZZCoA16b46Yd4cRxPtL8EZdghJaI6C/3vlT?=
 =?iso-8859-1?Q?l7vb93mU7XuUeLxPUaM4FeOJrb89zxzOnuZdO899iqiO2O8BY9mn2HbM+p?=
 =?iso-8859-1?Q?jWrZpQ3JKTz5eW+Gcv3xqClxPrwsFE83DXUTNRK5Kkx/EblpwPcvA7uytl?=
 =?iso-8859-1?Q?DrzpfkI74MVEgAJw0XfythKFxTYkNN4ilZoWk/EziQcefS3JNtDGIlASYt?=
 =?iso-8859-1?Q?F//ZkAVqNh217GDTd634pgfhfAQxwMDZfPGEAV5xXzkjuuyKLJBggUq3JI?=
 =?iso-8859-1?Q?XS143rX1T9iiZJx5wk4nwicOu+9LmvpinMJ4iUxmp9AKRUW3RQnPllm+VB?=
 =?iso-8859-1?Q?EdbsEVflftcuDsP9QnOoJdS8nnMGsIip855aMmXghyU3pL0sYGR25an5Yj?=
 =?iso-8859-1?Q?j86FCAmJvufheYb3aM/JOGJFFRwdqaMdrMZV6X4+4zoOh0NC6QH2svwA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR03MB7136.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3443c274-c8c9-408f-3cbe-08dbd6b5e42c
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2023 06:28:10.8481
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WuhZRD4/s4TCmqEBCgMXp3ZSyB4PN+fwp3ox6m9cJUbTJvaqIovx86fpGeZOyxpIM8fshjGpcWEgi7vRY7uW1FiIkqmqXv3nDNMg3/rYwvM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR03MB8876
X-Proofpoint-ORIG-GUID: kpNVAHKMbdirEcqjvrVdS02FZJUlmP5g
X-Proofpoint-GUID: kpNVAHKMbdirEcqjvrVdS02FZJUlmP5g
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

Add basic implementation of the SCMI v3.2 pincontrol protocol.

Signed-off-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
---
Changes v4 -> v5
  - add new calls to scmi_protocol description for config_{get,set}
Changes v3 -> v4
  - Fixed MAINTAINERS file description
  - adjusted pinctrl ops position and callback names
  - add trailing coma in scmi_protocol list
  - removed unneeded pi checks
  - corrected selector check
  - resource allocation refactoring
  - scmi_*_info swap params to generate better code
  - style, add trailing coma in definitions

---
 MAINTAINERS                           |   6 +
 drivers/firmware/arm_scmi/Makefile    |   2 +-
 drivers/firmware/arm_scmi/driver.c    |   2 +
 drivers/firmware/arm_scmi/pinctrl.c   | 922 ++++++++++++++++++++++++++
 drivers/firmware/arm_scmi/protocols.h |   1 +
 include/linux/scmi_protocol.h         |  47 ++
 6 files changed, 979 insertions(+), 1 deletion(-)
 create mode 100644 drivers/firmware/arm_scmi/pinctrl.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 0dab9737ec16..2d81d00e5f4f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20522,6 +20522,12 @@ F:	include/linux/sc[mp]i_protocol.h
 F:	include/trace/events/scmi.h
 F:	include/uapi/linux/virtio_scmi.h
=20
+PINCTRL DRIVER FOR SYSTEM CONTROL MANAGEMENT INTERFACE (SCMI)
+M:	Oleksii Moisieiev <oleksii_moisieiev@epam.com>
+L:	linux-arm-kernel@lists.infradead.org
+S:	Maintained
+F:	drivers/firmware/arm_scmi/pinctrl.c
+
 SYSTEM RESET/SHUTDOWN DRIVERS
 M:	Sebastian Reichel <sre@kernel.org>
 L:	linux-pm@vger.kernel.org
diff --git a/drivers/firmware/arm_scmi/Makefile b/drivers/firmware/arm_scmi=
/Makefile
index b31d78fa66cc..603430ec0bfe 100644
--- a/drivers/firmware/arm_scmi/Makefile
+++ b/drivers/firmware/arm_scmi/Makefile
@@ -10,7 +10,7 @@ scmi-transport-$(CONFIG_ARM_SCMI_TRANSPORT_SMC) +=3D smc.=
o
 scmi-transport-$(CONFIG_ARM_SCMI_HAVE_MSG) +=3D msg.o
 scmi-transport-$(CONFIG_ARM_SCMI_TRANSPORT_VIRTIO) +=3D virtio.o
 scmi-transport-$(CONFIG_ARM_SCMI_TRANSPORT_OPTEE) +=3D optee.o
-scmi-protocols-y =3D base.o clock.o perf.o power.o reset.o sensors.o syste=
m.o voltage.o powercap.o
+scmi-protocols-y =3D base.o clock.o perf.o power.o reset.o sensors.o syste=
m.o voltage.o powercap.o pinctrl.o
 scmi-module-objs :=3D $(scmi-driver-y) $(scmi-protocols-y) $(scmi-transpor=
t-y)
=20
 obj-$(CONFIG_ARM_SCMI_PROTOCOL) +=3D scmi-core.o
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi=
/driver.c
index f15e9b2b21f3..31a0da37eeb3 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -3040,6 +3040,7 @@ static int __init scmi_driver_init(void)
 	scmi_voltage_register();
 	scmi_system_register();
 	scmi_powercap_register();
+	scmi_pinctrl_register();
=20
 	return platform_driver_register(&scmi_driver);
 }
@@ -3057,6 +3058,7 @@ static void __exit scmi_driver_exit(void)
 	scmi_voltage_unregister();
 	scmi_system_unregister();
 	scmi_powercap_unregister();
+	scmi_pinctrl_unregister();
=20
 	scmi_transports_exit();
=20
diff --git a/drivers/firmware/arm_scmi/pinctrl.c b/drivers/firmware/arm_scm=
i/pinctrl.c
new file mode 100644
index 000000000000..e5cbd976b6ae
--- /dev/null
+++ b/drivers/firmware/arm_scmi/pinctrl.c
@@ -0,0 +1,922 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * System Control and Management Interface (SCMI) Pinctrl Protocol
+ *
+ * Copyright (C) 2023 EPAM
+ */
+
+#include <linux/module.h>
+#include <linux/scmi_protocol.h>
+#include <linux/slab.h>
+
+#include "common.h"
+#include "protocols.h"
+
+#define REG_TYPE_BITS GENMASK(9, 8)
+#define REG_CONFIG GENMASK(7, 0)
+
+#define GET_GROUPS_NR(x)	le32_get_bits((x), GENMASK(31, 16))
+#define GET_PINS_NR(x)		le32_get_bits((x), GENMASK(15, 0))
+#define GET_FUNCTIONS_NR(x)	le32_get_bits((x), GENMASK(15, 0))
+
+#define EXT_NAME_FLAG(x)	le32_get_bits((x), BIT(31))
+#define NUM_ELEMS(x)		le32_get_bits((x), GENMASK(15, 0))
+
+#define REMAINING(x)		le32_get_bits((x), GENMASK(31, 16))
+#define RETURNED(x)		le32_get_bits((x), GENMASK(11, 0))
+
+enum scmi_pinctrl_protocol_cmd {
+	PINCTRL_ATTRIBUTES =3D 0x3,
+	PINCTRL_LIST_ASSOCIATIONS =3D 0x4,
+	PINCTRL_CONFIG_GET =3D 0x5,
+	PINCTRL_CONFIG_SET =3D 0x6,
+	PINCTRL_FUNCTION_SELECT =3D 0x7,
+	PINCTRL_REQUEST =3D 0x8,
+	PINCTRL_RELEASE =3D 0x9,
+	PINCTRL_NAME_GET =3D 0xa,
+	PINCTRL_SET_PERMISSIONS =3D 0xb
+};
+
+struct scmi_msg_conf_set {
+	__le32 identifier;
+	__le32 attributes;
+	__le32 configs[];
+};
+
+struct scmi_msg_conf_get {
+	__le32 identifier;
+	__le32 attributes;
+};
+
+struct scmi_resp_conf_get {
+	__le32 num_configs;
+	__le32 configs[];
+};
+
+struct scmi_msg_pinctrl_protocol_attributes {
+	__le32 attributes_low;
+	__le32 attributes_high;
+};
+
+struct scmi_msg_pinctrl_attributes {
+	__le32 identifier;
+	__le32 flags;
+};
+
+struct scmi_resp_pinctrl_attributes {
+	__le32 attributes;
+	u8 name[SCMI_SHORT_NAME_MAX_SIZE];
+};
+
+struct scmi_msg_pinctrl_list_assoc {
+	__le32 identifier;
+	__le32 flags;
+	__le32 index;
+};
+
+struct scmi_resp_pinctrl_list_assoc {
+	__le32 flags;
+	__le16 array[];
+};
+
+struct scmi_msg_func_set {
+	__le32 identifier;
+	__le32 function_id;
+	__le32 flags;
+};
+
+struct scmi_msg_request {
+	__le32 identifier;
+	__le32 flags;
+};
+
+struct scmi_group_info {
+	char name[SCMI_MAX_STR_SIZE];
+	bool present;
+	unsigned int *group_pins;
+	unsigned int nr_pins;
+};
+
+struct scmi_function_info {
+	char name[SCMI_MAX_STR_SIZE];
+	bool present;
+	unsigned int *groups;
+	unsigned int nr_groups;
+};
+
+struct scmi_pin_info {
+	char name[SCMI_MAX_STR_SIZE];
+	bool present;
+};
+
+struct scmi_pinctrl_info {
+	u32 version;
+	int nr_groups;
+	int nr_functions;
+	int nr_pins;
+	struct scmi_group_info *groups;
+	struct scmi_function_info *functions;
+	struct scmi_pin_info *pins;
+};
+
+static int scmi_pinctrl_attributes_get(const struct scmi_protocol_handle *=
ph,
+				       struct scmi_pinctrl_info *pi)
+{
+	int ret;
+	struct scmi_xfer *t;
+	struct scmi_msg_pinctrl_protocol_attributes *attr;
+
+	ret =3D ph->xops->xfer_get_init(ph, PROTOCOL_ATTRIBUTES, 0, sizeof(*attr)=
, &t);
+	if (ret)
+		return ret;
+
+	attr =3D t->rx.buf;
+
+	ret =3D ph->xops->do_xfer(ph, t);
+	if (!ret) {
+		pi->nr_functions =3D GET_FUNCTIONS_NR(attr->attributes_high);
+		pi->nr_groups =3D GET_GROUPS_NR(attr->attributes_low);
+		pi->nr_pins =3D GET_PINS_NR(attr->attributes_low);
+	}
+
+	ph->xops->xfer_put(ph, t);
+	return ret;
+}
+
+static int scmi_pinctrl_count_get(const struct scmi_protocol_handle *ph,
+				  enum scmi_pinctrl_selector_type type)
+{
+	struct scmi_pinctrl_info *pi =3D ph->get_priv(ph);
+
+	switch (type) {
+	case PIN_TYPE:
+		return pi->nr_pins;
+	case GROUP_TYPE:
+		return pi->nr_groups;
+	case FUNCTION_TYPE:
+		return pi->nr_functions;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int scmi_pinctrl_validate_id(const struct scmi_protocol_handle *ph,
+				    u32 identifier,
+				    enum scmi_pinctrl_selector_type type)
+{
+	int value;
+
+	value =3D scmi_pinctrl_count_get(ph, type);
+	if (value < 0)
+		return value;
+
+	if (identifier >=3D value)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int scmi_pinctrl_attributes(const struct scmi_protocol_handle *ph,
+				   enum scmi_pinctrl_selector_type type,
+				   u32 selector, char *name,
+				   unsigned int *n_elems)
+{
+	int ret;
+	struct scmi_xfer *t;
+	struct scmi_msg_pinctrl_attributes *tx;
+	struct scmi_resp_pinctrl_attributes *rx;
+
+	if (!name)
+		return -EINVAL;
+
+	ret =3D scmi_pinctrl_validate_id(ph, selector, type);
+	if (ret)
+		return ret;
+
+	ret =3D ph->xops->xfer_get_init(ph, PINCTRL_ATTRIBUTES, sizeof(*tx), size=
of(*rx), &t);
+	if (ret)
+		return ret;
+
+	tx =3D t->tx.buf;
+	rx =3D t->rx.buf;
+	tx->identifier =3D cpu_to_le32(selector);
+	tx->flags =3D cpu_to_le32(type);
+
+	ret =3D ph->xops->do_xfer(ph, t);
+	if (!ret) {
+		if (n_elems)
+			*n_elems =3D NUM_ELEMS(rx->attributes);
+
+		strscpy(name, rx->name, SCMI_SHORT_NAME_MAX_SIZE);
+	}
+
+	ph->xops->xfer_put(ph, t);
+
+	/*
+	 * If supported overwrite short name with the extended one;
+	 * on error just carry on and use already provided short name.
+	 */
+	if (!ret && EXT_NAME_FLAG(rx->attributes))
+		ph->hops->extended_name_get(ph, PINCTRL_NAME_GET, selector,
+					    (u32 *)&type, name,
+					    SCMI_MAX_STR_SIZE);
+	return ret;
+}
+
+struct scmi_pinctrl_ipriv {
+	u32 selector;
+	enum scmi_pinctrl_selector_type type;
+	unsigned int *array;
+};
+
+static void iter_pinctrl_assoc_prepare_message(void *message,
+					       unsigned int desc_index,
+					       const void *priv)
+{
+	struct scmi_msg_pinctrl_list_assoc *msg =3D message;
+	const struct scmi_pinctrl_ipriv *p =3D priv;
+
+	msg->identifier =3D cpu_to_le32(p->selector);
+	msg->flags =3D cpu_to_le32(p->type);
+	/* Set the number of OPPs to be skipped/already read */
+	msg->index =3D cpu_to_le32(desc_index);
+}
+
+static int iter_pinctrl_assoc_update_state(struct scmi_iterator_state *st,
+					   const void *response, void *priv)
+{
+	const struct scmi_resp_pinctrl_list_assoc *r =3D response;
+
+	st->num_returned =3D RETURNED(r->flags);
+	st->num_remaining =3D REMAINING(r->flags);
+
+	return 0;
+}
+
+static int
+iter_pinctrl_assoc_process_response(const struct scmi_protocol_handle *ph,
+				    const void *response,
+				    struct scmi_iterator_state *st, void *priv)
+{
+	const struct scmi_resp_pinctrl_list_assoc *r =3D response;
+	struct scmi_pinctrl_ipriv *p =3D priv;
+
+	p->array[st->desc_index + st->loop_idx] =3D
+		le16_to_cpu(r->array[st->loop_idx]);
+
+	return 0;
+}
+
+static int scmi_pinctrl_list_associations(const struct scmi_protocol_handl=
e *ph,
+					  u32 selector,
+					  enum scmi_pinctrl_selector_type type,
+					  u16 size, unsigned int *array)
+{
+	int ret;
+	void *iter;
+	struct scmi_iterator_ops ops =3D {
+		.prepare_message =3D iter_pinctrl_assoc_prepare_message,
+		.update_state =3D iter_pinctrl_assoc_update_state,
+		.process_response =3D iter_pinctrl_assoc_process_response,
+	};
+	struct scmi_pinctrl_ipriv ipriv =3D {
+		.selector =3D selector,
+		.type =3D type,
+		.array =3D array,
+	};
+
+	if (!array || !size || type =3D=3D PIN_TYPE)
+		return -EINVAL;
+
+	ret =3D scmi_pinctrl_validate_id(ph, selector, type);
+	if (ret)
+		return ret;
+
+	iter =3D ph->hops->iter_response_init(ph, &ops, size,
+					    PINCTRL_LIST_ASSOCIATIONS,
+					    sizeof(struct scmi_msg_pinctrl_list_assoc),
+					    &ipriv);
+
+	if (IS_ERR(iter))
+		return PTR_ERR(iter);
+
+	return ph->hops->iter_response_run(iter);
+}
+
+struct scmi_conf_get_ipriv {
+	u32 selector;
+	enum scmi_pinctrl_selector_type type;
+	u8 all;
+	u8 *config_types;
+	unsigned long *config_values;
+};
+
+static void iter_pinctrl_conf_get_prepare_message(void *message,
+						  unsigned int desc_index,
+						  const void *priv)
+{
+	struct scmi_msg_conf_get *msg =3D message;
+	const struct scmi_conf_get_ipriv *p =3D priv;
+	u32 attributes;
+
+	msg->identifier =3D cpu_to_le32(p->selector);
+	attributes =3D FIELD_PREP(BIT(18), p->all) |
+		     FIELD_PREP(GENMASK(17, 16), p->type);
+
+	if (p->all)
+		attributes |=3D FIELD_PREP(GENMASK(15, 8), desc_index);
+	else
+		attributes |=3D FIELD_PREP(GENMASK(7, 0), p->config_types[0]);
+
+	msg->attributes =3D cpu_to_le32(attributes);
+	msg->identifier =3D cpu_to_le32(p->selector);
+}
+
+static int iter_pinctrl_conf_get_update_state(struct scmi_iterator_state *=
st,
+					      const void *response, void *priv)
+{
+	const struct scmi_resp_conf_get *r =3D response;
+
+	st->num_returned =3D le32_get_bits(r->num_configs, GENMASK(7, 0));
+	st->num_remaining =3D le32_get_bits(r->num_configs, GENMASK(31, 24));
+
+	return 0;
+}
+
+static int iter_pinctrl_conf_get_process_response(const struct scmi_protoc=
ol_handle *ph,
+						  const void *response,
+						  struct scmi_iterator_state *st, void *priv)
+{
+	const struct scmi_resp_conf_get *r =3D response;
+	struct scmi_conf_get_ipriv *p =3D priv;
+
+	if (!p->all) {
+		if (p->config_types[0] !=3D
+		    le32_get_bits(r->configs[st->loop_idx * 2], GENMASK(7, 0)))
+			return -EINVAL;
+	} else {
+		p->config_types[st->desc_index + st->loop_idx] =3D
+			le32_get_bits(r->configs[st->loop_idx * 2], GENMASK(7, 0));
+	}
+
+	p->config_values[st->desc_index + st->loop_idx] =3D
+		le32_to_cpu(r->configs[st->loop_idx * 2 + 1]);
+
+	return 0;
+}
+
+static int scmi_pinctrl_config_get(const struct scmi_protocol_handle *ph,
+				   u32 selector,
+				   enum scmi_pinctrl_selector_type type,
+				   u8 config_type, unsigned long *config_value)
+{
+	int ret;
+	void *iter;
+	struct scmi_iterator_ops ops =3D {
+		.prepare_message =3D iter_pinctrl_conf_get_prepare_message,
+		.update_state =3D iter_pinctrl_conf_get_update_state,
+		.process_response =3D iter_pinctrl_conf_get_process_response,
+	};
+	struct scmi_conf_get_ipriv ipriv =3D {
+		.selector =3D selector,
+		.type =3D type,
+		.all =3D 0,
+		.config_types =3D &config_type,
+		.config_values =3D config_value,
+	};
+
+	if (!config_value || type =3D=3D FUNCTION_TYPE)
+		return -EINVAL;
+
+	ret =3D scmi_pinctrl_validate_id(ph, selector, type);
+	if (ret)
+		return ret;
+
+	iter =3D ph->hops->iter_response_init(ph, &ops, 1, PINCTRL_CONFIG_GET,
+					    sizeof(struct scmi_msg_conf_get),
+					    &ipriv);
+
+	if (IS_ERR(iter))
+		return PTR_ERR(iter);
+
+	return ph->hops->iter_response_run(iter);
+}
+
+static int scmi_pinctrl_config_get_all(const struct scmi_protocol_handle *=
ph,
+				       u32 selector,
+				       enum scmi_pinctrl_selector_type type,
+				       u16 size, u8 *config_types,
+				       unsigned long *config_values)
+{
+	int ret;
+	void *iter;
+	struct scmi_iterator_ops ops =3D {
+		.prepare_message =3D iter_pinctrl_conf_get_prepare_message,
+		.update_state =3D iter_pinctrl_conf_get_update_state,
+		.process_response =3D iter_pinctrl_conf_get_process_response,
+	};
+	struct scmi_conf_get_ipriv ipriv =3D {
+		.selector =3D selector,
+		.type =3D type,
+		.all =3D 1,
+		.config_types =3D config_types,
+		.config_values =3D config_values,
+	};
+
+	if (!config_values || !config_types || type =3D=3D FUNCTION_TYPE)
+		return -EINVAL;
+
+	ret =3D scmi_pinctrl_validate_id(ph, selector, type);
+	if (ret)
+		return ret;
+
+	iter =3D ph->hops->iter_response_init(ph, &ops, size, PINCTRL_CONFIG_GET,
+					    sizeof(struct scmi_msg_conf_get),
+					    &ipriv);
+
+	if (IS_ERR(iter))
+		return PTR_ERR(iter);
+
+	return ph->hops->iter_response_run(iter);
+}
+
+static int scmi_pinctrl_config_set(const struct scmi_protocol_handle *ph,
+				   u32 selector,
+				   enum scmi_pinctrl_selector_type type,
+				   unsigned int nr_configs, u8 *config_types,
+				   unsigned long *config_values)
+{
+	struct scmi_xfer *t;
+	struct scmi_msg_conf_set *tx;
+	u32 attributes;
+	int ret, i;
+	unsigned int configs_in_chunk, conf_num =3D 0;
+	unsigned int chunk;
+	int max_msg_size =3D scmi_get_max_msg_size(ph);
+
+	if (!config_types || !config_values || type =3D=3D FUNCTION_TYPE)
+		return -EINVAL;
+
+	ret =3D scmi_pinctrl_validate_id(ph, selector, type);
+	if (ret)
+		return ret;
+
+	configs_in_chunk =3D (max_msg_size - sizeof(*tx)) / (sizeof(unsigned long=
) * 2);
+	while (conf_num < nr_configs) {
+		chunk =3D (nr_configs - conf_num > configs_in_chunk) ? configs_in_chunk =
:
+			nr_configs - conf_num;
+
+		ret =3D ph->xops->xfer_get_init(ph, PINCTRL_CONFIG_SET,
+					      sizeof(*tx) + chunk * 2 * sizeof(unsigned long),
+					      0, &t);
+		if (ret)
+			return ret;
+
+		tx =3D t->tx.buf;
+		tx->identifier =3D cpu_to_le32(selector);
+		attributes =3D FIELD_PREP(GENMASK(1, 0), type) |
+			FIELD_PREP(GENMASK(9, 2), chunk);
+		tx->attributes =3D cpu_to_le32(attributes);
+
+		for (i =3D 0; i < chunk; i++) {
+			tx->configs[i * 2] =3D cpu_to_le32(config_types[i]);
+			tx->configs[i * 2 + 1] =3D cpu_to_le32(config_values[i]);
+		}
+
+		ret =3D ph->xops->do_xfer(ph, t);
+
+		ph->xops->xfer_put(ph, t);
+
+		if (ret)
+			break;
+
+		conf_num +=3D chunk;
+	}
+
+	return ret;
+}
+
+static int scmi_pinctrl_function_select(const struct scmi_protocol_handle =
*ph,
+					u32 identifier,
+					enum scmi_pinctrl_selector_type type,
+					u32 function_id)
+{
+	int ret;
+	struct scmi_xfer *t;
+	struct scmi_msg_func_set *tx;
+
+	if (type =3D=3D FUNCTION_TYPE)
+		return -EINVAL;
+
+	ret =3D scmi_pinctrl_validate_id(ph, identifier, type);
+	if (ret)
+		return ret;
+
+	ret =3D ph->xops->xfer_get_init(ph, PINCTRL_FUNCTION_SELECT, sizeof(*tx),=
 0, &t);
+	if (ret)
+		return ret;
+
+	tx =3D t->tx.buf;
+	tx->identifier =3D cpu_to_le32(identifier);
+	tx->function_id =3D cpu_to_le32(function_id);
+	tx->flags =3D cpu_to_le32(type);
+
+	ret =3D ph->xops->do_xfer(ph, t);
+	ph->xops->xfer_put(ph, t);
+
+	return ret;
+}
+
+static int scmi_pinctrl_request(const struct scmi_protocol_handle *ph,
+				u32 identifier,
+				enum scmi_pinctrl_selector_type type)
+{
+	int ret;
+	struct scmi_xfer *t;
+	struct scmi_msg_request *tx;
+
+	if (type =3D=3D FUNCTION_TYPE)
+		return -EINVAL;
+
+	ret =3D scmi_pinctrl_validate_id(ph, identifier, type);
+	if (ret)
+		return ret;
+
+	ret =3D ph->xops->xfer_get_init(ph, PINCTRL_REQUEST, sizeof(*tx), 0, &t);
+
+	tx =3D t->tx.buf;
+	tx->identifier =3D cpu_to_le32(identifier);
+	tx->flags =3D cpu_to_le32(type);
+
+	ret =3D ph->xops->do_xfer(ph, t);
+	ph->xops->xfer_put(ph, t);
+
+	return ret;
+}
+
+static int scmi_pinctrl_pin_request(const struct scmi_protocol_handle *ph,
+				    u32 pin)
+{
+	return scmi_pinctrl_request(ph, pin, PIN_TYPE);
+}
+
+static int scmi_pinctrl_free(const struct scmi_protocol_handle *ph,
+			     u32 identifier,
+			     enum scmi_pinctrl_selector_type type)
+{
+	int ret;
+	struct scmi_xfer *t;
+	struct scmi_msg_request *tx;
+
+	if (type =3D=3D FUNCTION_TYPE)
+		return -EINVAL;
+
+	ret =3D scmi_pinctrl_validate_id(ph, identifier, type);
+	if (ret)
+		return ret;
+
+	ret =3D ph->xops->xfer_get_init(ph, PINCTRL_RELEASE, sizeof(*tx), 0, &t);
+
+	tx =3D t->tx.buf;
+	tx->identifier =3D cpu_to_le32(identifier);
+	tx->flags =3D cpu_to_le32(type);
+
+	ret =3D ph->xops->do_xfer(ph, t);
+	ph->xops->xfer_put(ph, t);
+
+	return ret;
+}
+
+static int scmi_pinctrl_pin_free(const struct scmi_protocol_handle *ph, u3=
2 pin)
+{
+	return scmi_pinctrl_free(ph, pin, PIN_TYPE);
+}
+
+static int scmi_pinctrl_get_group_info(const struct scmi_protocol_handle *=
ph,
+				       u32 selector,
+				       struct scmi_group_info *group)
+{
+	int ret;
+
+	if (!group)
+		return -EINVAL;
+
+	ret =3D scmi_pinctrl_attributes(ph, GROUP_TYPE, selector,
+				      group->name,
+				      &group->nr_pins);
+	if (ret)
+		return ret;
+
+	if (!group->nr_pins) {
+		dev_err(ph->dev, "Group %d has 0 elements", selector);
+		return -ENODATA;
+	}
+
+	group->group_pins =3D kmalloc_array(group->nr_pins, sizeof(*group->group_=
pins), GFP_KERNEL);
+	if (!group->group_pins)
+		return -ENOMEM;
+
+	ret =3D scmi_pinctrl_list_associations(ph, selector, GROUP_TYPE,
+					     group->nr_pins, group->group_pins);
+	if (ret) {
+		kfree(group->group_pins);
+		return ret;
+	}
+
+	group->present =3D true;
+	return 0;
+}
+
+static int scmi_pinctrl_get_group_name(const struct scmi_protocol_handle *=
ph,
+				       u32 selector, const char **name)
+{
+	struct scmi_pinctrl_info *pi =3D ph->get_priv(ph);
+
+	if (!name)
+		return -EINVAL;
+
+	if (selector >=3D pi->nr_groups)
+		return -EINVAL;
+
+	if (!pi->groups[selector].present) {
+		int ret;
+
+		ret =3D scmi_pinctrl_get_group_info(ph, selector,
+						  &pi->groups[selector]);
+		if (ret)
+			return ret;
+	}
+
+	*name =3D pi->groups[selector].name;
+
+	return 0;
+}
+
+static int scmi_pinctrl_group_pins_get(const struct scmi_protocol_handle *=
ph,
+				       u32 selector, const unsigned int **pins,
+				       unsigned int *nr_pins)
+{
+	struct scmi_pinctrl_info *pi =3D ph->get_priv(ph);
+
+	if (!pins || !nr_pins)
+		return -EINVAL;
+
+	if (selector >=3D pi->nr_groups)
+		return -EINVAL;
+
+	if (!pi->groups[selector].present) {
+		int ret;
+
+		ret =3D scmi_pinctrl_get_group_info(ph, selector,
+						  &pi->groups[selector]);
+		if (ret)
+			return ret;
+	}
+
+	*pins =3D pi->groups[selector].group_pins;
+	*nr_pins =3D pi->groups[selector].nr_pins;
+
+	return 0;
+}
+
+static int scmi_pinctrl_get_function_info(const struct scmi_protocol_handl=
e *ph,
+					  u32 selector,
+					  struct scmi_function_info *func)
+{
+	int ret;
+
+	if (!func)
+		return -EINVAL;
+
+	ret =3D scmi_pinctrl_attributes(ph, FUNCTION_TYPE, selector,
+				      func->name,
+				      &func->nr_groups);
+	if (ret)
+		return ret;
+
+	if (!func->nr_groups) {
+		dev_err(ph->dev, "Function %d has 0 elements", selector);
+		return -ENODATA;
+	}
+
+	func->groups =3D kmalloc_array(func->nr_groups, sizeof(*func->groups), GF=
P_KERNEL);
+	if (!func->groups)
+		return -ENOMEM;
+
+	ret =3D scmi_pinctrl_list_associations(ph, selector, FUNCTION_TYPE,
+					     func->nr_groups, func->groups);
+	if (ret) {
+		kfree(func->groups);
+		return ret;
+	}
+
+	func->present =3D true;
+	return 0;
+}
+
+static int scmi_pinctrl_get_function_name(const struct scmi_protocol_handl=
e *ph,
+					  u32 selector, const char **name)
+{
+	struct scmi_pinctrl_info *pi =3D ph->get_priv(ph);
+
+	if (!name)
+		return -EINVAL;
+
+	if (selector >=3D pi->nr_functions)
+		return -EINVAL;
+
+	if (!pi->functions[selector].present) {
+		int ret;
+
+		ret =3D scmi_pinctrl_get_function_info(ph, selector,
+						     &pi->functions[selector]);
+		if (ret)
+			return ret;
+	}
+
+	*name =3D pi->functions[selector].name;
+	return 0;
+}
+
+static int scmi_pinctrl_function_groups_get(const struct scmi_protocol_han=
dle *ph,
+					    u32 selector,
+					    unsigned int *nr_groups,
+					    const unsigned int **groups)
+{
+	struct scmi_pinctrl_info *pi =3D ph->get_priv(ph);
+
+	if (!groups || !nr_groups)
+		return -EINVAL;
+
+	if (selector >=3D pi->nr_functions)
+		return -EINVAL;
+
+	if (!pi->functions[selector].present) {
+		int ret;
+
+		ret =3D scmi_pinctrl_get_function_info(ph, selector,
+						     &pi->functions[selector]);
+		if (ret)
+			return ret;
+	}
+
+	*groups =3D pi->functions[selector].groups;
+	*nr_groups =3D pi->functions[selector].nr_groups;
+
+	return 0;
+}
+
+static int scmi_pinctrl_mux_set(const struct scmi_protocol_handle *ph,
+				u32 selector, u32 group)
+{
+	return scmi_pinctrl_function_select(ph, group, GROUP_TYPE,
+					    selector);
+}
+
+static int scmi_pinctrl_get_pin_info(const struct scmi_protocol_handle *ph=
,
+				     u32 selector, struct scmi_pin_info *pin)
+{
+	int ret;
+
+	if (!pin)
+		return -EINVAL;
+
+	ret =3D scmi_pinctrl_attributes(ph, PIN_TYPE, selector,
+				      pin->name, NULL);
+	if (ret)
+		return ret;
+
+	pin->present =3D true;
+	return 0;
+}
+
+static int scmi_pinctrl_get_pin_name(const struct scmi_protocol_handle *ph=
,
+				     u32 selector, const char **name)
+{
+	struct scmi_pinctrl_info *pi =3D ph->get_priv(ph);
+
+	if (!name)
+		return -EINVAL;
+
+	if (selector >=3D pi->nr_pins)
+		return -EINVAL;
+
+	if (!pi->pins[selector].present) {
+		int ret;
+
+		ret =3D scmi_pinctrl_get_pin_info(ph, selector,
+						&pi->pins[selector]);
+		if (ret)
+			return ret;
+	}
+
+	*name =3D pi->pins[selector].name;
+
+	return 0;
+}
+
+static int scmi_pinctrl_name_get(const struct scmi_protocol_handle *ph,
+				 u32 selector,
+				 enum scmi_pinctrl_selector_type type,
+				 const char **name)
+{
+	switch (type) {
+	case PIN_TYPE:
+		return scmi_pinctrl_get_pin_name(ph, selector, name);
+	case GROUP_TYPE:
+		return scmi_pinctrl_get_group_name(ph, selector, name);
+	case FUNCTION_TYPE:
+		return scmi_pinctrl_get_function_name(ph, selector, name);
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct scmi_pinctrl_proto_ops pinctrl_proto_ops =3D {
+	.count_get =3D scmi_pinctrl_count_get,
+	.name_get =3D scmi_pinctrl_name_get,
+	.group_pins_get =3D scmi_pinctrl_group_pins_get,
+	.function_groups_get =3D scmi_pinctrl_function_groups_get,
+	.mux_set =3D scmi_pinctrl_mux_set,
+	.config_get =3D scmi_pinctrl_config_get,
+	.config_get_all =3D scmi_pinctrl_config_get_all,
+	.config_set =3D scmi_pinctrl_config_set,
+	.pin_request =3D scmi_pinctrl_pin_request,
+	.pin_free =3D scmi_pinctrl_pin_free,
+};
+
+static int scmi_pinctrl_protocol_init(const struct scmi_protocol_handle *p=
h)
+{
+	int ret;
+	u32 version;
+	struct scmi_pinctrl_info *pinfo;
+
+	ret =3D ph->xops->version_get(ph, &version);
+	if (ret)
+		return ret;
+
+	dev_dbg(ph->dev, "Pinctrl Version %d.%d\n",
+		PROTOCOL_REV_MAJOR(version), PROTOCOL_REV_MINOR(version));
+
+	pinfo =3D devm_kzalloc(ph->dev, sizeof(*pinfo), GFP_KERNEL);
+	if (!pinfo)
+		return -ENOMEM;
+
+	ret =3D scmi_pinctrl_attributes_get(ph, pinfo);
+	if (ret)
+		return ret;
+
+	pinfo->pins =3D devm_kcalloc(ph->dev, pinfo->nr_pins,
+				   sizeof(*pinfo->pins),
+				   GFP_KERNEL);
+	if (!pinfo->pins)
+		return -ENOMEM;
+
+	pinfo->groups =3D devm_kcalloc(ph->dev, pinfo->nr_groups,
+				     sizeof(*pinfo->groups),
+				     GFP_KERNEL);
+	if (!pinfo->groups)
+		return -ENOMEM;
+
+	pinfo->functions =3D devm_kcalloc(ph->dev, pinfo->nr_functions,
+					sizeof(*pinfo->functions),
+					GFP_KERNEL);
+	if (!pinfo->functions)
+		return -ENOMEM;
+
+	pinfo->version =3D version;
+
+	return ph->set_priv(ph, pinfo);
+}
+
+static int scmi_pinctrl_protocol_deinit(const struct scmi_protocol_handle =
*ph)
+{
+	int i;
+	struct scmi_pinctrl_info *pi =3D ph->get_priv(ph);
+
+	for (i =3D 0; i < pi->nr_groups; i++) {
+		if (pi->groups[i].present) {
+			kfree(pi->groups[i].group_pins);
+			pi->groups[i].present =3D false;
+		}
+	}
+
+	for (i =3D 0; i < pi->nr_functions; i++) {
+		if (pi->functions[i].present) {
+			kfree(pi->functions[i].groups);
+			pi->functions[i].present =3D false;
+		}
+	}
+
+	return 0;
+}
+
+static const struct scmi_protocol scmi_pinctrl =3D {
+	.id =3D SCMI_PROTOCOL_PINCTRL,
+	.owner =3D THIS_MODULE,
+	.instance_init =3D &scmi_pinctrl_protocol_init,
+	.instance_deinit =3D &scmi_pinctrl_protocol_deinit,
+	.ops =3D &pinctrl_proto_ops,
+};
+
+DEFINE_SCMI_PROTOCOL_REGISTER_UNREGISTER(pinctrl, scmi_pinctrl)
diff --git a/drivers/firmware/arm_scmi/protocols.h b/drivers/firmware/arm_s=
cmi/protocols.h
index b3c6314bb4b8..674f949354f9 100644
--- a/drivers/firmware/arm_scmi/protocols.h
+++ b/drivers/firmware/arm_scmi/protocols.h
@@ -346,5 +346,6 @@ DECLARE_SCMI_REGISTER_UNREGISTER(sensors);
 DECLARE_SCMI_REGISTER_UNREGISTER(voltage);
 DECLARE_SCMI_REGISTER_UNREGISTER(system);
 DECLARE_SCMI_REGISTER_UNREGISTER(powercap);
+DECLARE_SCMI_REGISTER_UNREGISTER(pinctrl);
=20
 #endif /* _SCMI_PROTOCOLS_H */
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index 0ce5746a4470..a9f5398ea4cc 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -676,6 +676,52 @@ struct scmi_powercap_proto_ops {
 					  u32 *power_thresh_high);
 };
=20
+enum scmi_pinctrl_selector_type {
+	PIN_TYPE =3D 0,
+	GROUP_TYPE,
+	FUNCTION_TYPE,
+};
+
+/**
+ * struct scmi_pinctrl_proto_ops - represents the various operations provi=
ded
+ * by SCMI Pinctrl Protocol
+ *
+ * @count_get: returns count of the registered elements in given type
+ * @name_get: returns name by index of given type
+ * @group_pins_get: returns the set of pins, assigned to the specified gro=
up
+ * @function_groups_get: returns the set of groups, assigned to the specif=
ied
+ *	function
+ * @mux_set: set muxing function for groups of pins
+ * @config_get: returns configuration parameter for pin or group
+ * @config_set: sets the configuration parameter for pin or group
+ * @pin_request: aquire pin before selecting mux setting
+ * @pin_free: frees pin, acquired by request_pin call
+ */
+struct scmi_pinctrl_proto_ops {
+	int (*count_get)(const struct scmi_protocol_handle *ph,
+			 enum scmi_pinctrl_selector_type type);
+	int (*name_get)(const struct scmi_protocol_handle *ph, u32 selector,
+			enum scmi_pinctrl_selector_type type, const char **name);
+	int (*group_pins_get)(const struct scmi_protocol_handle *ph, u32 selector=
,
+			      const unsigned int **pins, unsigned int *nr_pins);
+	int (*function_groups_get)(const struct scmi_protocol_handle *ph, u32 sel=
ector,
+				   unsigned int *nr_groups, const unsigned int **groups);
+	int (*mux_set)(const struct scmi_protocol_handle *ph, u32 selector, u32 g=
roup);
+	int (*config_get)(const struct scmi_protocol_handle *ph, u32 selector,
+			  enum scmi_pinctrl_selector_type type,
+			  u8 config_type, unsigned long *config_value);
+	int (*config_get_all)(const struct scmi_protocol_handle *ph,
+			      u32 selector,
+			      enum scmi_pinctrl_selector_type type, u16 size,
+			      u8 *config_types, unsigned long *config_values);
+	int (*config_set)(const struct scmi_protocol_handle *ph, u32 selector,
+			  enum scmi_pinctrl_selector_type type,
+			  unsigned int nr_configs, u8 *config_type,
+			  unsigned long *config_value);
+	int (*pin_request)(const struct scmi_protocol_handle *ph, u32 pin);
+	int (*pin_free)(const struct scmi_protocol_handle *ph, u32 pin);
+};
+
 /**
  * struct scmi_notify_ops  - represents notifications' operations provided=
 by
  * SCMI core
@@ -783,6 +829,7 @@ enum scmi_std_protocol {
 	SCMI_PROTOCOL_RESET =3D 0x16,
 	SCMI_PROTOCOL_VOLTAGE =3D 0x17,
 	SCMI_PROTOCOL_POWERCAP =3D 0x18,
+	SCMI_PROTOCOL_PINCTRL =3D 0x19,
 };
=20
 enum scmi_system_events {
--=20
2.25.1
