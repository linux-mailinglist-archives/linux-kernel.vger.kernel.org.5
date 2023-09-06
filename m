Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5443A793BBE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 13:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240246AbjIFLts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 07:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240216AbjIFLtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 07:49:40 -0400
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com (mail-zr0che01on2129.outbound.protection.outlook.com [40.107.24.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE8E8CFD;
        Wed,  6 Sep 2023 04:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tcBhdlB0UvTIrj22ntjc1FmuAPYvQOCMqkAmzEqP6qU=;
 b=jjVIt6064NqsGWu2+KFTGpHAGTHYtbPJlnNljFk2rF1HjK5BqpiV7YfxvJbQC/7bleL2ElrkPjis/yrVSqh1CLdecoo3RvnFDys13pFZzvoEFT8/owDZIRkauGAefudwAerlnoGFzhchUi5AtB5urrKvX+l6BR/4ftaWsF5ekGE=
Received: from DB7PR05CA0006.eurprd05.prod.outlook.com (2603:10a6:10:36::19)
 by ZR1P278MB1086.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:5c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Wed, 6 Sep
 2023 11:49:31 +0000
Received: from DB1PEPF00039231.eurprd03.prod.outlook.com
 (2603:10a6:10:36:cafe::46) by DB7PR05CA0006.outlook.office365.com
 (2603:10a6:10:36::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34 via Frontend
 Transport; Wed, 6 Sep 2023 11:49:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 77.74.96.169)
 smtp.mailfrom=duagon.com; dkim=pass (signature was verified)
 header.d=duagon.com;dmarc=pass action=none header.from=duagon.com;
Received-SPF: Pass (protection.outlook.com: domain of duagon.com designates
 77.74.96.169 as permitted sender) receiver=protection.outlook.com;
 client-ip=77.74.96.169; helo=securemail.duagon.com; pr=C
Received: from securemail.duagon.com (77.74.96.169) by
 DB1PEPF00039231.mail.protection.outlook.com (10.167.8.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6768.25 via Frontend Transport; Wed, 6 Sep 2023 11:49:31 +0000
Received: from securemail (localhost [127.0.0.1])
        by securemail.duagon.com (Postfix) with SMTP id 4Rggdk4X8LzxpF;
        Wed,  6 Sep 2023 13:49:30 +0200 (CEST)
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com (mail-zr0che01lp2111.outbound.protection.outlook.com [104.47.22.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by securemail.duagon.com (Postfix) with ESMTPS;
        Wed,  6 Sep 2023 13:49:29 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kxH03koB1cBhlsLEvKyEvFlhM1HxHm4VSSKbcBpuys90PKb3jMogWYLpwiV6pjpcXmgDj3ldJ90dX6o+iqovg1fdQxNAGKmCozQS3mLAa6vO7Yvu4YP0OAgSQOTyOwZ33PC7+Qm5ty7FOkOaM6alSLJ9ryMWX2xCClrmm9IMchMvRKGkGqKLwDHzF8zVDRulwPDjMhsNBJvT8N4npol0GXO01Hn1ojDnEJ3819MP4LWKSlIJTwWsh9M8/EkDysOyMB+mdKkcbKzxTJQFG9m+lxwDRXdag15qMofCsEeYV5FkDExN6Zj2B5Oo1yzT2XTWCFe55/n6Gb/KW0hrCjrksA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tcBhdlB0UvTIrj22ntjc1FmuAPYvQOCMqkAmzEqP6qU=;
 b=NbBDw3ydBK9WbirMUZaZoAVKwQSXTYbpRol1aWSxr4X9bl8w9zwLTz1tudJ8G9uXXP3mVt8xE50pQeTKBUiKviGyX1E4YqmFCkfwXZVfuJNaRhQ05r+AWJdW4tT7YZqqP+p3o1RcXV+RZtyiGbndJ3aocFLJGdJPGM21H0vwx4XU6+KSSF5tEz/VsFwiIBppNBPf98zk9vX/qyQk2pjUBCzrZkc/14V/uBZixptcKAZGtCGcbqyo2WuehWYB33zX1CmjCZAz0wpsmU7MKrNfSnHfB2xcanNP8gLobXTVQa2fmdk1OhgMShkQwsgycc+L4xRmkYwKLNE80e7o7E0K4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=duagon.com; dmarc=pass action=none header.from=duagon.com;
 dkim=pass header.d=duagon.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tcBhdlB0UvTIrj22ntjc1FmuAPYvQOCMqkAmzEqP6qU=;
 b=jjVIt6064NqsGWu2+KFTGpHAGTHYtbPJlnNljFk2rF1HjK5BqpiV7YfxvJbQC/7bleL2ElrkPjis/yrVSqh1CLdecoo3RvnFDys13pFZzvoEFT8/owDZIRkauGAefudwAerlnoGFzhchUi5AtB5urrKvX+l6BR/4ftaWsF5ekGE=
Received: from GV0P278MB0996.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:4f::13)
 by ZR0P278MB0774.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:4e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 6 Sep
 2023 11:49:28 +0000
Received: from GV0P278MB0996.CHEP278.PROD.OUTLOOK.COM
 ([fe80::a222:6d25:1fdb:a800]) by GV0P278MB0996.CHEP278.PROD.OUTLOOK.COM
 ([fe80::a222:6d25:1fdb:a800%3]) with mapi id 15.20.6745.030; Wed, 6 Sep 2023
 11:49:28 +0000
From:   =?iso-8859-1?Q?Rodr=EDguez_Barbarin=2C_Jos=E9_Javier?= 
        <JoseJavier.Rodriguez@duagon.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>
CC:     "morbidrsa@gmail.com" <morbidrsa@gmail.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jth@kernel.org" <jth@kernel.org>,
        =?iso-8859-1?Q?Sanju=E1n_Garc=EDa=2C_Jorge?= 
        <Jorge.SanjuanGarcia@duagon.com>,
        =?iso-8859-1?Q?Sanju=E1n_Garc=EDa=2C_Jorge?= 
        <Jorge.SanjuanGarcia@duagon.com>,
        =?iso-8859-1?Q?Rodr=EDguez_Barbarin=2C_Jos=E9_Javier?= 
        <JoseJavier.Rodriguez@duagon.com>
Subject: [PATCH v3 2/2] mcb: use short version for function pointer for
 mcb_free_bus
Thread-Topic: [PATCH v3 2/2] mcb: use short version for function pointer for
 mcb_free_bus
Thread-Index: AQHZ4LgxiyYmw8Q6ZUKWOFwaI/GpAw==
Date:   Wed, 6 Sep 2023 11:49:28 +0000
Message-ID: <20230906114901.63174-3-JoseJavier.Rodriguez@duagon.com>
References: <20230906114901.63174-1-JoseJavier.Rodriguez@duagon.com>
In-Reply-To: <20230906114901.63174-1-JoseJavier.Rodriguez@duagon.com>
Accept-Language: es-ES, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=duagon.com;
x-ms-traffictypediagnostic: GV0P278MB0996:EE_|ZR0P278MB0774:EE_|DB1PEPF00039231:EE_|ZR1P278MB1086:EE_
X-MS-Office365-Filtering-Correlation-Id: b9384965-261a-4c0e-4ca6-08dbaecf5524
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: kmrs2CtNLrZtn44xeUmtEVFU3fHOmb/fWPiXecNQGDWw9StKupM5Np6xGkSc+DrTeIVzuGMkaC9tw4qKb91kvwSF2Y9Z5eILMumqdefuo5Cayql3Tbg4GXWp0X9hHJNHB1AsTFy71eFG4tyDjfOyWPXrpVgoYENzsyNYKCK22CEz7jBJLnZNoMjA4WXUIaComNpaSX+MZod3Kb+KNQtIsl41sc9KDzp3V0H579Y7UVcqcPgxaFmjiB4pDwUqgcuHEM0zd5yOx1QlAhmA1fAc73JwRdIDaRnDCjLQz69QfWcRcjRlyw2EAbPXVGTedT7WOfb+L+I4V4uqLNb59ARK3mjRJCt4YG9GI9t4Ejbc9FotDpTxG1Mcfn4MGvFf/j1BdxhkC0u7oA4VJVeKB1V5JR9KDLu+tSpqV3lwDFzHcBQFPlN09Hdwq18G7BA96QINnovlNsMuVLbUe4fD9WrjpI5Q9+5qk46dOkusHIe8U4WnC10A788a/dOs7ueQAsOxACwREJCyGCvzTNioLpyucL4pq63mHXMztFMP5Sh1tI785L0mqpJ121zIlTn07dIrY04dLwLC9BccpDJQQlKo/XDw4f/UOsYBA1UJ3Ke9X6FGQ9FC9doxMnAKi0aj3aKD
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV0P278MB0996.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(376002)(136003)(396003)(346002)(366004)(451199024)(186009)(1800799009)(71200400001)(6506007)(6486002)(107886003)(478600001)(83380400001)(4744005)(2906002)(1076003)(26005)(66556008)(64756008)(54906003)(66446008)(41300700001)(66476007)(2616005)(316002)(91956017)(110136005)(8676002)(5660300002)(4326008)(8936002)(76116006)(38100700002)(36756003)(6512007)(122000001)(38070700005)(86362001)(66946007);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR0P278MB0774
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB1PEPF00039231.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 8f311bc5-f4f7-4879-f692-08dbaecf5393
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TqMC4eOG9Dkvi1S7GsaTaEa2VZoAzVGvRqlpYmSqfgj90gK+Lr0Qh2r1nyUlUJk2jd55a7qB83fpiXbcRoRf7B5JdVpyu6hNZEHVTeWhNkxS0BQhLA3UdoA8EHD2WQVmEgyHkibIPiFCuQrqsuUZSMf2xzFvKFF9z5bPUwwO33b8PfJ2jeZfr3TssMBFY2VGQug5DjnVtUT4ZUP5soL+vmKyHjh7g1nqZ3RKco8y7oDgh0WG/5cOyOwOfbBx1t624iAnc3AQJ/NYGomBWi2q+mZzEbn9nZ5dYDR1WmIuGLG5JFzwKXrgCdEPVnc2NJhh4KKGjl9QeTqU0NPh/5zMgGfUeow4xuhKcVvHzZUKOxvmgTzSlKBnm1CSYwZyqc5E+cZQGz83gCig7AAIMeFtqFUVZ5ZHayPsl3SJsULAHyudEmIrxh9V17QSv3dPEijcsmxV/nxirz7v1X/R+a3I7b6gBiL5R579KQf2P6b0knZyRVm9wAA9L/7HNE+uOqe8RHVosAiuRkozhaAY46djf7kgeezYoYzOam0f0DHyjjDTR3uZCGWKqB8duj31UxGK2MRozPUiDD3XegiN9mDSDopQEDMxDRWdJ1HQhY/ZFl+7y0hd2HpHeFZCAxMScC6/cDjojij23tvKQxSZDwxdlAkEpZT33KUTKUjiUBbNmT3D4A4eHxnhcQa7U7nZqmnHFxWWyLoZwYtsMzywTU74pLHmecxb8QVWZbijFC2ANrQj95G1RDX9Wus3RHIJsX11
X-Forefront-Antispam-Report: CIP:77.74.96.169;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:securemail.duagon.com;PTR:169.96.74.77.ftth.as8758.net;CAT:NONE;SFS:(13230031)(396003)(346002)(39850400004)(376002)(136003)(82310400011)(451199024)(186009)(1800799009)(36840700001)(46966006)(40470700004)(1076003)(8676002)(316002)(110136005)(54906003)(70206006)(4326008)(107886003)(2616005)(70586007)(8936002)(82740400003)(40480700001)(356005)(6486002)(81166007)(6506007)(41300700001)(6512007)(336012)(26005)(5660300002)(478600001)(2906002)(40460700003)(83380400001)(36860700001)(4744005)(47076005)(86362001)(36756003);DIR:OUT;SFP:1102;
X-OriginatorOrg: duagon.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 11:49:31.0150
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9384965-261a-4c0e-4ca6-08dbaecf5524
X-MS-Exchange-CrossTenant-Id: e5e7e96e-8a28-45d6-9093-a40dd5b51a57
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5e7e96e-8a28-45d6-9093-a40dd5b51a57;Ip=[77.74.96.169];Helo=[securemail.duagon.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF00039231.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR1P278MB1086
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jorge Sanjuan Garcia <jorge.sanjuangarcia@duagon.com>

Just a style change so that the device release callbacks are defined
in the same way for devices in mcb_bus and mcb_device.

Signed-off-by: Jorge Sanjuan Garcia <jorge.sanjuangarcia@duagon.com>
Co-developed-by: Jose Javier Rodriguez Barbarin <JoseJavier.Rodriguez@duago=
n.com>
Signed-off-by: Jose Javier Rodriguez Barbarin <JoseJavier.Rodriguez@duagon.=
com>
---
 drivers/mcb/mcb-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mcb/mcb-core.c b/drivers/mcb/mcb-core.c
index 0cac5bead84f..5c6157b0db75 100644
--- a/drivers/mcb/mcb-core.c
+++ b/drivers/mcb/mcb-core.c
@@ -288,7 +288,7 @@ struct mcb_bus *mcb_alloc_bus(struct device *carrier)
 	bus->dev.parent =3D carrier;
 	bus->dev.bus =3D &mcb_bus_type;
 	bus->dev.type =3D &mcb_carrier_device_type;
-	bus->dev.release =3D &mcb_free_bus;
+	bus->dev.release =3D mcb_free_bus;
=20
 	dev_set_name(&bus->dev, "mcb:%d", bus_nr);
 	rc =3D device_add(&bus->dev);
--=20
2.34.1
