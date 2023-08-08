Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8427F774CBE
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 23:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236045AbjHHVPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 17:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236285AbjHHVPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 17:15:12 -0400
Received: from mx0b-0039f301.pphosted.com (mx0b-0039f301.pphosted.com [148.163.137.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FEC2995F0;
        Tue,  8 Aug 2023 11:25:59 -0700 (PDT)
Received: from pps.filterd (m0174683.ppops.net [127.0.0.1])
        by mx0b-0039f301.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 378E6eP1003021;
        Tue, 8 Aug 2023 18:25:42 GMT
Received: from eur01-ve1-obe.outbound.protection.outlook.com (mail-ve1eur01lp2057.outbound.protection.outlook.com [104.47.1.57])
        by mx0b-0039f301.pphosted.com (PPS) with ESMTPS id 3sbpek1ayb-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Aug 2023 18:25:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HZ/A8DkHLhLsj4zfidkLOvfLRvWVP6CTJusFF0znqlFJzOHdRNQOtGhXcTLKz2fRyMcFfX4dkN0YIaVbo7FmE6mH/mPOQ0ZKj/nbvwxR9fct7FEXTJPWWDRv7HcMa6wPkFYbSzEJ5mdt0WlxosX5+j7hWZd9Wey0jOb/iRYoU/C7+aujNp/W10manXWZ83wyjP8HYuXfGlc37MPABj0D6aiQ53npxpqfXVhUHDIpNdPBh9BUiL0mYIP60JHAJY+x+db6ZX7edo2p2aFjPcBLtTS+PoTbn5ics0dxNdBQvh6br178T3BCiR+ivCngZvhSjTIuHfzHzK6BEc27vCAWFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+F1XrR7yfWjYQqJzvPiM3QMAnesCkkVwTqGks+SvCM8=;
 b=eEP+qnpfE/Tjnhz+NpUPb+gxhCaaJ7RSHZBjCzoXoeW4J18NAUO5kVwCaeIn8tA8RyH/TmKWm95QHrzoeEUwlHPw8uBKramMzQwo3PLg242yk8ftPBN8i/h++GpaVFF9V6y58djt/o3suYSBDoEunwI0qoPMqvZjVy0e8odlsAHz0UFtKA8gqOLneKH6+XPiTfVkSjNDdmFqO0XNeAiW6WMyFwZy38RiUrWtyna6zT7/SjjUQUz1UeXG5rBri1lw8tT2JIFen5Ypl/EWykPmQ1KAmKx19SL6XhW8MqTzXm1WKrQWxmpVcjAxKRNR1K07P9TpmLZUtAK19rQq0YkLxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+F1XrR7yfWjYQqJzvPiM3QMAnesCkkVwTqGks+SvCM8=;
 b=H8SEX41K55i5tAh7T1FjxHwHozz5sMsDExStHTmdP6fJxhy571qBwuF0DQ1dEcpRbZ9SlUC1siJnZph1lHcoPqftnZcGCb+6TIpQ2aeQGUqWEqV/kY/d2MkI8CDJCm0veOqon20gUGozMtk5lbpRDlVZxF/2XruBc8vfWQdT5EzJOdtRbuW6EABhQjp6lhE7A3shmDxRcwTIjZVll6SdLsMFi/UZLLCxmMorUdfwVRiY9rmlozBPmjpCfvKAo9bivuFH4PHYI8QxQ9vwUkETVdyS2qtFsNIUJsTkPlyQ4viQgpd0ECA/PrI/EM2c5/Av/guSHVSautbsrtu3Osv/sg==
Received: from PA4PR03MB7136.eurprd03.prod.outlook.com (2603:10a6:102:ea::23)
 by AS4PR03MB8458.eurprd03.prod.outlook.com (2603:10a6:20b:519::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Tue, 8 Aug
 2023 18:25:35 +0000
Received: from PA4PR03MB7136.eurprd03.prod.outlook.com
 ([fe80::ccb5:5aee:f10d:ab26]) by PA4PR03MB7136.eurprd03.prod.outlook.com
 ([fe80::ccb5:5aee:f10d:ab26%4]) with mapi id 15.20.6652.026; Tue, 8 Aug 2023
 18:25:35 +0000
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
Subject: [PATCH v4 2/4] firmware: arm_scmi: Add SCMI v3.2 pincontrol protocol
 basic support
Thread-Topic: [PATCH v4 2/4] firmware: arm_scmi: Add SCMI v3.2 pincontrol
 protocol basic support
Thread-Index: AQHZyiW5O6qQsCkaZE+uwCtArOPMQA==
Date:   Tue, 8 Aug 2023 18:25:35 +0000
Message-ID: <cde361d9d2b155c72fbd6aa85fd077864e36b6e3.1691518314.git.oleksii_moisieiev@epam.com>
References: <cover.1691518313.git.oleksii_moisieiev@epam.com>
In-Reply-To: <cover.1691518313.git.oleksii_moisieiev@epam.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR03MB7136:EE_|AS4PR03MB8458:EE_
x-ms-office365-filtering-correlation-id: 5bf622e4-f164-4afb-6f2a-08db983cdbd7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AuJ3H8UNO/XBOKkxv+JSrcj8V8hTHpCSZbQLt5ZJuiRAp/L4bfMaJzbRBibsrq8tEhrUmofN8TAcKVNIIF7N1Tk/Uj4EPHPXaIIeiTCK9FQ05u9m5jkHRd09NrpukcSkk1vgTfUnf77Qf8nRHzxu5TJwx+Zbs1XuhZJYK/fH0BdIrlgYrxWjmU6A15C47Nx96K2hMzOHQMO+CRTnK9psvwSZa+NvV1uxGuwYaKp+04P3f5ArBSvMKZvKmOGHGE0u/m5BLkNO+4JNZtjjg6mHNxH0KNyRG4lBeUD6lHz3wMx3j2h65zGoFvd5X2lgJllhE7JXv00WrbbkgNyLEhRZVOtzsI+V1IL0CvFl6DP/LY52IISz4BiYJWK8fwJrZUPnIuD4HLHtdEhuq5O5Nq2K+eBus2W/IlnrLFcbLTwF2qv5zdul6qyHsZaAC3gWkuN7od45u/kjwjrKdJM8kDNPq5GAxWNor+1U2YqVucaI3sCs0bvBLFfEfJpQs1ufZ1uvNEKgNKPuqh9ucCr9Ka/R3YgeGsiZfab3kB94COx6stZSpzkRxGmv4PPbSkn3ONn0HCjEcHhljwPVknAN/xdzxhFgZs8cRRG4vK8UatMeweZ+QT4r9VcxFLpX06nf4gHg
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR03MB7136.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(366004)(346002)(136003)(451199021)(1800799003)(186006)(7416002)(38070700005)(8936002)(8676002)(5660300002)(64756008)(4326008)(6916009)(41300700001)(316002)(83380400001)(86362001)(30864003)(2906002)(6512007)(6486002)(71200400001)(2616005)(6506007)(26005)(36756003)(76116006)(66476007)(91956017)(66556008)(66946007)(66446008)(478600001)(122000001)(54906003)(38100700002)(579004)(559001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?lAMovaUBhncou3zTuQe8GQy1oZYerSCN7VoSN60JK2uEK0yLbAhTu5I5PJ?=
 =?iso-8859-1?Q?SssDBooBNhAaGfaPIuRZ9MXSwI8L31SjRHCVH1LeuDMCNyyQS8sNmJ3nR3?=
 =?iso-8859-1?Q?R+SF1aQY07pluIeVXc0IzF88fUouANn2mWQbIe93+1asFcyqnt/+vz8jD1?=
 =?iso-8859-1?Q?vAVqLs48FbJ1rSC11iiTa4KD/TSSxu7HwrSUlv5fCiN8VqH4ejerrtu7Ad?=
 =?iso-8859-1?Q?NdKr/KLIEGgsbo6x8B8wVH13zQDtundx9kOqbjctNAT0vaP8j95b9TtSyx?=
 =?iso-8859-1?Q?nCbZUyj4YiNrcVIOqpg050+D9+9xf9APfG8nkwPcwt9cBQ+1g9BjenLpRw?=
 =?iso-8859-1?Q?fhASqBId4B5VBBKTzIxvSGWXEY4eA5mnAmzKnm7koPWaTrmobOhO97NDKc?=
 =?iso-8859-1?Q?EVGEYhHSRrjt67MSl+8PGIiFw1tp7GvQd1aYHufdX/FhHMqufrxpRF49UQ?=
 =?iso-8859-1?Q?igoLqrPadlyAkzyJr6PANZRXAJMSZhO1wUyjUBv95U81GSoOpNo7WwNF5I?=
 =?iso-8859-1?Q?LxPbe+sjzEvFg/yJsRgUQSCSQy4+V3jOWO1AI9vdiu81mwkVlXHJzWsnTm?=
 =?iso-8859-1?Q?/GfFP3hKqNeKBE7JOEqoB7hP/ujpLoyAYyyNyBvZqC6cdw29/Hu1OpWCXb?=
 =?iso-8859-1?Q?T9dw5IxB4p3bMk0fKTYIlFDgQNJFq1GcTuaFQfga84+s2hoiKaBGXpxmMZ?=
 =?iso-8859-1?Q?2+j7CYbOk5zML6Fy/8FC6VHiMb7eZak0VfVgMVSbWvgyawLE+bnDGFVz9P?=
 =?iso-8859-1?Q?2cBdVB2/Jamajwjt/znuxvHDqr9uZpfFoOdbp0u07Mqifm5uOv61zl7/zZ?=
 =?iso-8859-1?Q?8ls1w4zdNUrcQWk9rxT5w0qMJpFzvM+lKLDBouYtxZ2kyGXWJA9tuQljvv?=
 =?iso-8859-1?Q?2XHHoudvulgu4W8ZAkVNpo2RSgDrlC83D9Iu2c8wvKeDG3u0x0+/Nmtwpf?=
 =?iso-8859-1?Q?hHXDhdjqc5AYFAIEWCgORN0+pM+/pu+OL5qlwAs6KRhUSpEIUmqz2L2KyG?=
 =?iso-8859-1?Q?DaQ/6Lrik5MYLSgcveg2M8COtjRLvGtMFbnhzejfJTz4icxIkEDFGQOUQu?=
 =?iso-8859-1?Q?8fFvN+OTkHi7tV35hG/kvW0W6LExV4+6TH/AWmbLEddqf02hZqFEunsXzo?=
 =?iso-8859-1?Q?0ro4qZ8S+uYL0pfNa020NnOo0tlNBo47DU2yA7sH4U/WbXcX3txvCTiBcJ?=
 =?iso-8859-1?Q?PIBAKbhWgYNVrA7iJKEN2sa2bQN61UYP4l/p1MfmlgAjKF9KxgtpOof+jA?=
 =?iso-8859-1?Q?miIerJgbRHKQowZ51k6jOfL9NrJrklZ6WvkaFHlkl/okm4/hUc3FtmKdB7?=
 =?iso-8859-1?Q?Q85h0D8RrcWHSTecwD3MA9tjpe+8LO+crpSeMWQnri0DzuI1YzwXyVehf6?=
 =?iso-8859-1?Q?GAYivTivU58z4LLqFKlYKKgi1C1/u4BmqiDpDRM8vdhEFVmg0DMQ6RBv3U?=
 =?iso-8859-1?Q?8m8visowev3gwkelXo/Ke32NjS1MWQHwuoSkC4irv+HZD4IM/ChVZU8Bp6?=
 =?iso-8859-1?Q?w2q63qSaCjS7TEbNB1I+FlL1zXH2R4yw9eKjLK85utRJzEc8dIOaseuovc?=
 =?iso-8859-1?Q?W3kxKe3wHsBS3Ah4JkEYG7yYLDkISPxReK505ETZFkhsFTXwUX7/MLCLEL?=
 =?iso-8859-1?Q?bqXgTt4nTWjmn1HD7ZB+qFiGO6O20ca5UgylmaRX2GeDwFZV4U+sNXvA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR03MB7136.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bf622e4-f164-4afb-6f2a-08db983cdbd7
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2023 18:25:35.5985
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9SPR42z2ttg1pK//2fPb1+VYQ+geqqmGjC5p1vKIvtlymrpGgLejrq2xbN59zV9+Y06u7/UidiOVX5ptWV3QQHSY6OXoVyfrVX9xNK8xiIc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR03MB8458
X-Proofpoint-ORIG-GUID: 8kBzIMb5DoGLP60te3lY3IIa_HP45srk
X-Proofpoint-GUID: 8kBzIMb5DoGLP60te3lY3IIa_HP45srk
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

Add basic implementation of the SCMI v3.2 pincontrol protocol.

Signed-off-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
---
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
 drivers/firmware/arm_scmi/pinctrl.c   | 791 ++++++++++++++++++++++++++
 drivers/firmware/arm_scmi/protocols.h |   1 +
 include/linux/scmi_protocol.h         |  42 ++
 6 files changed, 843 insertions(+), 1 deletion(-)
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
index 729201d8f935..03686bff000e 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -3024,6 +3024,7 @@ static int __init scmi_driver_init(void)
 	scmi_voltage_register();
 	scmi_system_register();
 	scmi_powercap_register();
+	scmi_pinctrl_register();
=20
 	return platform_driver_register(&scmi_driver);
 }
@@ -3041,6 +3042,7 @@ static void __exit scmi_driver_exit(void)
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
index 000000000000..868a2f9821be
--- /dev/null
+++ b/drivers/firmware/arm_scmi/pinctrl.c
@@ -0,0 +1,791 @@
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
+	__le32 config_value;
+};
+
+struct scmi_msg_conf_get {
+	__le32 identifier;
+	__le32 attributes;
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
+static int scmi_pinctrl_config_get(const struct scmi_protocol_handle *ph,
+				   u32 selector,
+				   enum scmi_pinctrl_selector_type type,
+				   u8 config_type, unsigned long *config_value)
+{
+	int ret;
+	u32 attributes;
+	struct scmi_xfer *t;
+	struct scmi_msg_conf_get *tx;
+
+	if (!config_value || type =3D=3D FUNCTION_TYPE)
+		return -EINVAL;
+
+	ret =3D scmi_pinctrl_validate_id(ph, selector, type);
+	if (ret)
+		return ret;
+
+	ret =3D ph->xops->xfer_get_init(ph, PINCTRL_CONFIG_GET, sizeof(*tx), size=
of(__le32), &t);
+	if (ret)
+		return ret;
+
+	tx =3D t->tx.buf;
+	tx->identifier =3D cpu_to_le32(selector);
+	attributes =3D FIELD_PREP(REG_TYPE_BITS, type) |
+		FIELD_PREP(REG_CONFIG, config_type);
+	tx->attributes =3D cpu_to_le32(attributes);
+
+	ret =3D ph->xops->do_xfer(ph, t);
+	if (!ret)
+		*config_value =3D get_unaligned_le32(t->rx.buf);
+
+	ph->xops->xfer_put(ph, t);
+	return ret;
+}
+
+static int scmi_pinctrl_config_set(const struct scmi_protocol_handle *ph,
+				   u32 selector,
+				   enum scmi_pinctrl_selector_type type,
+				   u8 config_type, unsigned long config_value)
+{
+	struct scmi_xfer *t;
+	struct scmi_msg_conf_set *tx;
+	u32 attributes =3D 0;
+	int ret;
+
+	if (type =3D=3D FUNCTION_TYPE)
+		return -EINVAL;
+
+	ret =3D scmi_pinctrl_validate_id(ph, selector, type);
+	if (ret)
+		return ret;
+
+	ret =3D ph->xops->xfer_get_init(ph, PINCTRL_CONFIG_SET, sizeof(*tx), 0, &=
t);
+	if (ret)
+		return ret;
+
+	tx =3D t->tx.buf;
+	tx->identifier =3D cpu_to_le32(selector);
+	attributes =3D FIELD_PREP(REG_TYPE_BITS, type) |
+		FIELD_PREP(REG_CONFIG, config_type);
+	tx->attributes =3D cpu_to_le32(attributes);
+	tx->config_value =3D cpu_to_le32(config_value);
+
+	ret =3D ph->xops->do_xfer(ph, t);
+
+	ph->xops->xfer_put(ph, t);
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
index 0ce5746a4470..11bb69479076 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -676,6 +676,47 @@ struct scmi_powercap_proto_ops {
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
+	int (*config_set)(const struct scmi_protocol_handle *ph, u32 selector,
+			  enum scmi_pinctrl_selector_type type,
+			  u8 config_type, unsigned long config_value);
+	int (*pin_request)(const struct scmi_protocol_handle *ph, u32 pin);
+	int (*pin_free)(const struct scmi_protocol_handle *ph, u32 pin);
+};
+
 /**
  * struct scmi_notify_ops  - represents notifications' operations provided=
 by
  * SCMI core
@@ -783,6 +824,7 @@ enum scmi_std_protocol {
 	SCMI_PROTOCOL_RESET =3D 0x16,
 	SCMI_PROTOCOL_VOLTAGE =3D 0x17,
 	SCMI_PROTOCOL_POWERCAP =3D 0x18,
+	SCMI_PROTOCOL_PINCTRL =3D 0x19,
 };
=20
 enum scmi_system_events {
--=20
2.25.1
