Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8676678244D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 09:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233620AbjHUHUa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 03:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231161AbjHUHU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 03:20:29 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2071.outbound.protection.outlook.com [40.107.13.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37ACBBA;
        Mon, 21 Aug 2023 00:20:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AsUhwccltlKoBtTgcfHEXV+tDKjeZgXGRvr/0dTQUKNpSLGaa+Sd0fl+qlvXGLXtlG2ua0S8bdhCJIVySo661p+pG1E27/CvOE0sZAHsWTQOTlKFISh9uX8+YXkBxsJApbsh2iuqhKKPE1b4OPn6jJ7uvqc2s+TMorl33Rt0GUlgd0+3/ekpgevkwOo/GtKqwkHwEeSVCKiQX+8oAxaZuNwQR9pegWZeLSmFTt5laTjqD/69ER0Xjt9LNyPv7VjYG49UDMu9Tqzy7cLH024wqtIIXieLMqADVTyzQoUNB7QGg/yEBoCSQJGECdcOlmgur9XTGe/iSOSTqzx7lj+JjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sP4msCjzcs7Q8zjrRIVX87/Sk0XcMax94epxF4ZzXdk=;
 b=BL2+u3LLAj9vhAw3rvUtn5i3jn/21sZHHRtwTmlMdKEwrpga17Dbx2lP+nevf2p3bAlM6LVnpaFGnPHeVcUVdLKXihrtA+vLmbo+ORBeYwLfG2yv+Ipcvxy2tbBAb2Jz4WZbpMJA2Ob+7AApYDhHDPc6SrVu+92GoE0bx4RmGleuh5EsKiDycXxUmexHLMw4FXPd11AjoDxTV5ONhtLgmRpMeOxH6xOSL59LwuENqG9EusERbScrWHv3g9eOEq+YLKftmzlFbusGPjGgkMScCbszDDj8mubEBl2a3esh9NXz2iyg2zI+FN1HbWAk7Hczqj4ParT8Q24g8Vc5HVNOmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 13.93.42.39) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=topic.nl;
 dmarc=bestguesspass action=none header.from=topic.nl; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sP4msCjzcs7Q8zjrRIVX87/Sk0XcMax94epxF4ZzXdk=;
 b=AMm2NIP5t1xUPUvmpQcMGQ0hQzbxWvu2/HwtqjClv18KSBXXMJWWdKnUJbhm1K5U/bWKJdgzH39O2OU9lViKVuSAG6hCjh6Iey3eJmS30t4RSTV9c5hZTdlPoOYPET90zeNRBkqZlc+qPHyQjIg6S5MwaTgV26+ZVaET5IKHu/yuUTSZFXD2daOC/Dym9OcQMU/oZceBVwKX+T6awKgq7jtnyPQ48hqhRx1zdgnV4FRh0YTjUzjOYqjHwFYCVwlcJ0YsGNr2CFJX/22BURsJRYjPs/EMxSubT9MSMuq/h6ex1ZvdM5D9cQwB3FLSgjj02/N+lDIV2AEr0G0qWqrZYg==
Received: from DUZPR01CA0172.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b3::29) by PAXPR04MB8671.eurprd04.prod.outlook.com
 (2603:10a6:102:21e::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Mon, 21 Aug
 2023 07:20:23 +0000
Received: from DB1PEPF00039230.eurprd03.prod.outlook.com
 (2603:10a6:10:4b3:cafe::97) by DUZPR01CA0172.outlook.office365.com
 (2603:10a6:10:4b3::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20 via Frontend
 Transport; Mon, 21 Aug 2023 07:20:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 13.93.42.39)
 smtp.mailfrom=topic.nl; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topic.nl designates
 13.93.42.39 as permitted sender) receiver=protection.outlook.com;
 client-ip=13.93.42.39; helo=westeu12-emailsignatures-cloud.codetwo.com; pr=C
Received: from westeu12-emailsignatures-cloud.codetwo.com (13.93.42.39) by
 DB1PEPF00039230.mail.protection.outlook.com (10.167.8.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.15 via Frontend Transport; Mon, 21 Aug 2023 07:20:22 +0000
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (104.47.18.109) by westeu12-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Mon, 21 Aug 2023 07:20:22 +0000
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from DB8PR04MB6523.eurprd04.prod.outlook.com (2603:10a6:10:10f::26)
 by AM7PR04MB7111.eurprd04.prod.outlook.com (2603:10a6:20b:118::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 07:20:20 +0000
Received: from DB8PR04MB6523.eurprd04.prod.outlook.com
 ([fe80::6b6e:1525:72e9:d02f]) by DB8PR04MB6523.eurprd04.prod.outlook.com
 ([fe80::6b6e:1525:72e9:d02f%4]) with mapi id 15.20.6699.020; Mon, 21 Aug 2023
 07:20:20 +0000
From:   Mike Looijmans <mike.looijmans@topic.nl>
To:     linux-rtc@vger.kernel.org
CC:     Mike Looijmans <mike.looijmans@topic.nl>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] rtc: pcf85363: Allow to wake up system without IRQ
Date:   Mon, 21 Aug 2023 09:20:13 +0200
Message-ID: <20230821072013.7072-1-mike.looijmans@topic.nl>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: AS4P250CA0012.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:5df::18) To DB8PR04MB6523.eurprd04.prod.outlook.com
 (2603:10a6:10:10f::26)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB8PR04MB6523:EE_|AM7PR04MB7111:EE_|DB1PEPF00039230:EE_|PAXPR04MB8671:EE_
X-MS-Office365-Filtering-Correlation-Id: 414757ec-e631-49ce-514b-08dba2171568
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 9ZXgRmq/cSnO28J5iU4FGJIW9vsGz3UqFy41dlIXrO7dxqL+0RNek2vSyBxbaPtvjMulvnWBOBWMt8LBkH6xGTqh+7U88FC4IqkUqS2+RNM1FREN0ogoX3pF86ZIld6y+/OsSvYt7Ykq+qLn/Ia3z8+0iKAppdI2thnO4h2CWv6i5y2xeAj6UyFZ3D5JM1OR/XY8rzEwOWzPQcCN8k/zqSZM6sgZwv8gq+WYPg+gm2nBShkUP6T0KncNfyINyCW4z61nxPCbcunr2l/7hayocX8JvgycOq0t7500z0GXI/Jabj/cMgv2FCj1c3ac4KQlE4KlnS1ZR5V0OJXezyOgP01eGKOVFHJNSXDc8I/CIlV3sOutvlc9zVo+BUTj5mh6BjUptzLfDZdmYTDzDC3T/VqAXCUinNqU+PJH371qzXOtxVuybKhfeFTjv5OaqBbub6OTiGak+BiuaqFktTduFZeeY96JyQydFeaSKJb31yUx+vbrwk7mhl6uF8YnywA7jpcrNvieGpPZszh2VuoQsBFwZ+MgGqxApXU7BmX1vl7u6rQ3y2Pd/vVE+ygsIZMd3wTQKDNUAPeLd+7zYymdYWXzvNS6l0PLRlPBxcJ4F1iNvgPWfzYrquFRS9ni3Qfx
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6523.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39830400003)(366004)(136003)(396003)(376002)(451199024)(186009)(1800799009)(2906002)(83380400001)(52116002)(38350700002)(38100700002)(6506007)(6486002)(5660300002)(44832011)(26005)(86362001)(8676002)(2616005)(8936002)(4326008)(66946007)(316002)(6512007)(6916009)(54906003)(66556008)(66476007)(478600001)(6666004)(36756003)(41300700001)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7111
X-CodeTwo-MessageID: 75d2392f-6928-4350-928c-1bbfb0cd6d39.20230821072022@westeu12-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
References: <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.ab3cda0d-1169-470b-8cf3-51ba15343c59@emailsignatures365.codetwo.com>
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB1PEPF00039230.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 6d4c8742-d66b-4d57-de84-08dba21713b3
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mdrC+SvkPNSYJ65jYrVbOpLACMTOtpUjluA3n6u2vGplY9zeyQIjnCLo8xa2T1lzzRdqtcmEKXMD1aqYEbUABCQ2pt+HnFkOvm0mGAwTBhWAzOmk80osVoEXNy+QQkZAHLhksZzc/zk/5AoCZVDpwN9mIoN/GMlVhENjg7TqfabY187vH9DAhh3/2I0oHK+dzNeIdxDYsp+EuXsA9ATF0LHj5c57nisi6/NviE+kSz/7FirMIdt4GT/DSWHG9xevCY+VgXek1INQLiIvkfwhvmUbuJ5bbxaToOAZS+HXMPMeINlTjcteKu6OzsZi2RwVKIy8gymbDXXtjov3gBWw1h2A3l1exvOjXVrsnqpE/7eaqUGiLWVhzJDMhC9/ynlloK37SH2PIhiGm6vBj52eNtteGNCvZBz3TOmJSryrsnLjKNeVMycmJaJGN8YKa/RtrPKyh0LJ0eIvSX1VqtAJKMXSo8RH5EZrJk/mVRE7YLesW39klmpt5zf1OnvqXPxahuM9Lx0sJvk1UMdawbbGBc2bzRNI40qIyxd21Ic3V2XrF2D7ELDjGvYp8tPfvFUyJJomjm8bZSGQUiPxLsPkfhS2HCiLhbcNkYsV703X7WvDYuBAsobtizG8FIs0CwPZGuzd5wz0NH/wLR7+EFfGMFtDgGQrzglKvaHHT0xa3ZxQkxkzouc5LhnMTejC+3r2
X-Forefront-Antispam-Report: CIP:13.93.42.39;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu12-emailsignatures-cloud.codetwo.com;PTR:westeu12-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(376002)(39830400003)(346002)(186009)(1800799009)(82310400011)(451199024)(36840700001)(46966006)(6916009)(54906003)(70586007)(70206006)(316002)(6512007)(8676002)(2616005)(8936002)(4326008)(7596003)(1076003)(36756003)(41300700001)(7636003)(356005)(478600001)(6666004)(6486002)(6506007)(40480700001)(15974865002)(2906002)(83380400001)(86362001)(36860700001)(47076005)(44832011)(5660300002)(336012)(26005);DIR:OUT;SFP:1101;
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 07:20:22.9225
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 414757ec-e631-49ce-514b-08dba2171568
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[13.93.42.39];Helo=[westeu12-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF00039230.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8671
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When wakeup-source is set in the devicetree, set up the device for
using the output as interrupt instead of clock. This is similar to
how other RTC devices handle this.

This allows the clock chip to turn on the board when wired to do
so in hardware.

Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>

---

Changes in v2:
Don't call device_init_wakeup when IRW request fails

 drivers/rtc/rtc-pcf85363.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/drivers/rtc/rtc-pcf85363.c b/drivers/rtc/rtc-pcf85363.c
index 8958eadf1c3e..f9370e00d4dc 100644
--- a/drivers/rtc/rtc-pcf85363.c
+++ b/drivers/rtc/rtc-pcf85363.c
@@ -403,6 +403,7 @@ static int pcf85363_probe(struct i2c_client *client)
 		},
 	};
 	int ret, i, err;
+	bool wakeup_source;
=20
 	if (data)
 		config =3D data;
@@ -432,25 +433,36 @@ static int pcf85363_probe(struct i2c_client *client)
 	pcf85363->rtc->ops =3D &rtc_ops;
 	pcf85363->rtc->range_min =3D RTC_TIMESTAMP_BEGIN_2000;
 	pcf85363->rtc->range_max =3D RTC_TIMESTAMP_END_2099;
-	clear_bit(RTC_FEATURE_ALARM, pcf85363->rtc->features);
+
+	wakeup_source =3D device_property_read_bool(&client->dev,
+						  "wakeup-source");
+	if (client->irq > 0 || wakeup_source) {
+		regmap_write(pcf85363->regmap, CTRL_FLAGS, 0);
+		regmap_update_bits(pcf85363->regmap, CTRL_PIN_IO,
+				   PIN_IO_INTA_OUT, PIN_IO_INTAPM);
+	}
=20
 	if (client->irq > 0) {
 		unsigned long irqflags =3D IRQF_TRIGGER_LOW;
=20
 		if (dev_fwnode(&client->dev))
 			irqflags =3D 0;
-
-		regmap_write(pcf85363->regmap, CTRL_FLAGS, 0);
-		regmap_update_bits(pcf85363->regmap, CTRL_PIN_IO,
-				   PIN_IO_INTA_OUT, PIN_IO_INTAPM);
 		ret =3D devm_request_threaded_irq(&client->dev, client->irq,
 						NULL, pcf85363_rtc_handle_irq,
 						irqflags | IRQF_ONESHOT,
 						"pcf85363", client);
-		if (ret)
-			dev_warn(&client->dev, "unable to request IRQ, alarms disabled\n");
-		else
-			set_bit(RTC_FEATURE_ALARM, pcf85363->rtc->features);
+		if (ret) {
+			dev_warn(&client->dev,
+				 "unable to request IRQ, alarms disabled\n");
+			client->irq =3D 0;
+		}
+	}
+
+	if (client->irq > 0 || wakeup_source) {
+		device_init_wakeup(&client->dev, true);
+		set_bit(RTC_FEATURE_ALARM, pcf85363->rtc->features);
+	} else {
+		clear_bit(RTC_FEATURE_ALARM, pcf85363->rtc->features);
 	}
=20
 	ret =3D devm_rtc_register_device(pcf85363->rtc);
--=20
2.17.1


Met vriendelijke groet / kind regards,=0A=
=0A=
Mike Looijmans=0A=
System Expert=0A=
=0A=
=0A=
TOPIC Embedded Products B.V.=0A=
Materiaalweg 4, 5681 RJ Best=0A=
The Netherlands=0A=
=0A=
T: +31 (0) 499 33 69 69=0A=
E: mike.looijmans@topic.nl=0A=
W: www.topic.nl=0A=
=0A=
Please consider the environment before printing this e-mail=0A=
