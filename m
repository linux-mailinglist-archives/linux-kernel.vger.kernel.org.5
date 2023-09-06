Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6416C793BBF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 13:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240142AbjIFLtu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 07:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240218AbjIFLtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 07:49:41 -0400
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com (mail-zr0che01on20702.outbound.protection.outlook.com [IPv6:2a01:111:f403:4023::702])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23EDEE6B;
        Wed,  6 Sep 2023 04:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=De3cPtu9VH+VDmatRh/wveHg5sRfTm1MXhQhyxzKYRQ=;
 b=lVKLIWUJBJwpirs8JQzsft2m10c3/YrI6QoENOZmqXkDr35b92AJvkykloV4j27ZJniMDa9VzJXFI+LRDnf7KJ1xgd4NK4NYvicaIrzUA14RRlZodrZTr9U9CsDaBNz2eux6z1j8iCZGB2IzXDC+Phlfd/dTBU7m4bi5hz7xuSU=
Received: from DUZPR01CA0001.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c3::10) by ZRAP278MB0922.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:4a::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 6 Sep
 2023 11:49:31 +0000
Received: from DB5PEPF00014B94.eurprd02.prod.outlook.com
 (2603:10a6:10:3c3:cafe::cc) by DUZPR01CA0001.outlook.office365.com
 (2603:10a6:10:3c3::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34 via Frontend
 Transport; Wed, 6 Sep 2023 11:49:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 77.74.96.169)
 smtp.mailfrom=duagon.com; dkim=pass (signature was verified)
 header.d=duagon.com;dmarc=pass action=none header.from=duagon.com;
Received-SPF: Pass (protection.outlook.com: domain of duagon.com designates
 77.74.96.169 as permitted sender) receiver=protection.outlook.com;
 client-ip=77.74.96.169; helo=securemail.duagon.com; pr=C
Received: from securemail.duagon.com (77.74.96.169) by
 DB5PEPF00014B94.mail.protection.outlook.com (10.167.8.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6768.25 via Frontend Transport; Wed, 6 Sep 2023 11:49:30 +0000
Received: from securemail (localhost [127.0.0.1])
        by securemail.duagon.com (Postfix) with SMTP id 4Rggdj5mqdzxpD;
        Wed,  6 Sep 2023 13:49:29 +0200 (CEST)
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com (mail-zr0che01lp2111.outbound.protection.outlook.com [104.47.22.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by securemail.duagon.com (Postfix) with ESMTPS;
        Wed,  6 Sep 2023 13:49:28 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bUMVQKW2wI+dsYcN+8SkcJXRpFMCqPLOVad9sqYaSlTc1Thzohc08BuAoCUacQV7AzvtaUQHzVn8cqo7C45Jdn0VDpztc4ZIpviq+c2L6tGx+x7+PEOGpEI9ohZOMWJzUNaTu+qP7llvaa/dw4qt2UQ7P5qw6Tb5KQJ5IN03tJJGp2yRz9yYeElxkxiooT7R3YlynjqCcYEg8kbILDFRwoRyY35DtmV9ch46HbwNot9hNfS/k426mfNQiX5KAjI6AtzHdxa6hNgsjULRRtESStYdCHVsBehsj6xN/PeV9zkVawYry/0Zw1G+onCR7wt+6B8RVbYBTYJ0FSIXGZsK/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=De3cPtu9VH+VDmatRh/wveHg5sRfTm1MXhQhyxzKYRQ=;
 b=WPhxkgJ8/ZroZ93OnMzhFc89szOrv9qgTEYM9lv6uqGmcrhqfyjrxVP13mhz6ytRzYUdZLjxptcZzhoc0UXqacyZWqN2ybwjXHu7LnnsoU8qBzducOt1DIYbFGLlV39PltItoFM8VTZ0eq358cXuMw4q6PyzbXtzKcgmJYaF5ecxFirVaPTU2EszG9+/YzJF/nNHQZ38M1F15rlmG84lqQeGrL7T0jOKP3ksWVsefDdv6t6pMHODuK/1wzmEBHok0d6o8ggD0+yufbyx8VsEXdu8OARWYlf41EIVc+oONLDt4VQ9gplAjDD4FQafb1q+eP49oaVL6bCPJWp8+OJu1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=duagon.com; dmarc=pass action=none header.from=duagon.com;
 dkim=pass header.d=duagon.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=De3cPtu9VH+VDmatRh/wveHg5sRfTm1MXhQhyxzKYRQ=;
 b=lVKLIWUJBJwpirs8JQzsft2m10c3/YrI6QoENOZmqXkDr35b92AJvkykloV4j27ZJniMDa9VzJXFI+LRDnf7KJ1xgd4NK4NYvicaIrzUA14RRlZodrZTr9U9CsDaBNz2eux6z1j8iCZGB2IzXDC+Phlfd/dTBU7m4bi5hz7xuSU=
Received: from GV0P278MB0996.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:4f::13)
 by ZR0P278MB0774.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:4e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 6 Sep
 2023 11:49:27 +0000
Received: from GV0P278MB0996.CHEP278.PROD.OUTLOOK.COM
 ([fe80::a222:6d25:1fdb:a800]) by GV0P278MB0996.CHEP278.PROD.OUTLOOK.COM
 ([fe80::a222:6d25:1fdb:a800%3]) with mapi id 15.20.6745.030; Wed, 6 Sep 2023
 11:49:27 +0000
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
Subject: [PATCH v3 1/2] mcb: remove is_added flag from mcb_device struct
Thread-Topic: [PATCH v3 1/2] mcb: remove is_added flag from mcb_device struct
Thread-Index: AQHZ4LgwUDOZu8ybkEe1iQTcx6Hv6Q==
Date:   Wed, 6 Sep 2023 11:49:26 +0000
Message-ID: <20230906114901.63174-2-JoseJavier.Rodriguez@duagon.com>
References: <20230906114901.63174-1-JoseJavier.Rodriguez@duagon.com>
In-Reply-To: <20230906114901.63174-1-JoseJavier.Rodriguez@duagon.com>
Accept-Language: es-ES, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=duagon.com;
x-ms-traffictypediagnostic: GV0P278MB0996:EE_|ZR0P278MB0774:EE_|DB5PEPF00014B94:EE_|ZRAP278MB0922:EE_
X-MS-Office365-Filtering-Correlation-Id: 0448d536-77e7-4d9b-fe1e-08dbaecf54ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: SzUBe/kHHKR/at+x14fm6Iu3nMD8aShM7FxGQweZYWDyr+wtab6X4IlRRjC9KdF9UIDo3U67KX9DL3MatV/N+If4uWd+6THBKADEE3Mgsc2eMuhsMygMDds1E/CF0/SIWFYVhpxDAvWxHuUPCFQ4m6+/+P2YHq8lHQbMSmINx1hB30mfB1IMEs2XcRJ7pPUKn2OenwGabZX6yQfqnKCRGCauIj3xdjBFw8zqLstKE8FQrMCJ4LocFO5XLNBiIUQ5S0onWC1u0+wqr7/ddysWFbed7WoDrAT0s+lBIo7IzZH7LcIOvfdSpk/Po9JQDYU7UfVh3oRImfXf2d3IsmPgMsu+oqZp6OkQFKo+PkybYw7IgVkIz27EGSLULgA4OBTFE6r9iV3XSXFqLrL3r1DSvxp6AQ6KgNpKvFeBD3SpedLsfQ+yqMEfwoasYcShzVYX48FmeYtO3hGWdvjHFkkL2I0W+p7pvbinLT7ugZ+zzeNnSvtYAEXAdjsVKutXupf0hUrzEWOkfYqqEE3JMcomd5aJsscBfkoMNj/F3Ih/WZjdYmP0I7oG6acgnRYif4gGfN2sCOoUU3kS2W5JxpMsfRbh5n6GXu1oxcAHk7muWXBb0W68n5yfXjoIMDHJNFN1
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV0P278MB0996.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(376002)(136003)(396003)(346002)(366004)(451199024)(186009)(1800799009)(71200400001)(6506007)(6486002)(107886003)(478600001)(83380400001)(2906002)(1076003)(26005)(66556008)(64756008)(54906003)(66446008)(41300700001)(66476007)(2616005)(316002)(91956017)(110136005)(8676002)(5660300002)(4326008)(8936002)(76116006)(38100700002)(36756003)(6512007)(122000001)(38070700005)(86362001)(66946007);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR0P278MB0774
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5PEPF00014B94.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: db33a63b-81ee-45c4-35d3-08dbaecf5297
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tU6tqiowMxUewM9twjxnW3/LrwFMbwmiyrIVIIx4JLfIVf0IxhoOOYTvn+vIx05VannN3xK9BPFllqHqMykx90pIFuVq2Ul3fXIlfMJOddAoGmUHkb++pHwmCHa0kWPD0ASdYLzuThwAG26VLsjM6e6B1KY4ISjNiUIsZV28a9zz2bImRmt5rclmOhCW2t6NcBRWJ+HM9IUwOGYGh7SP3xLNAeX9s+wOAF9megnm2BvJETwVoUnmElfUni7c2TRGwGzbGwxpBEG9f4O8y8PxoWlvM6j93D3dfwZdaXcjKnVALreQBNEc7V/mrbD6Ax+MufYpUkZ3Zv36ZgDUrOWVCZ10rXbE2vifBRlky768VxuwFOqYx+VKZOadV/EVI6o/KGtkdfg1qzbog9BCqL4aU6GAePCZaAXQ5lN6vqjb+n5bgRPnCxkDsnBiM31YQJkfIShwgnFm2TnrOSHHfSnwOnAToZL293B9FrL9jeAPCm/uRns97NVb1Bv0idVamPWcA5CaV9vIHGQ2Tmg4FSG0PMBMHOIV2WJL4jEkQfuE0g7d4IUcd0WNZZYFpksFmPB3D0f7P6neZwN1Obk8elT1eBtWWdl5FGui4cG4F6UkjFuYeET57c6NfCeQObWozIiFIzlFgEcDOAzTy2AyxI8oYa70M3N17XnPikf2lRmo40sFwcIRls5FCeg6lzn3TVbR6rzOCoZ8cYRJXKxuM9h4coTQRwVtBqaVqdDd7C+9b/wDppznwkh4OsMM17OJOUWd
X-Forefront-Antispam-Report: CIP:77.74.96.169;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:securemail.duagon.com;PTR:169.96.74.77.ftth.as8758.net;CAT:NONE;SFS:(13230031)(376002)(396003)(346002)(136003)(39850400004)(1800799009)(82310400011)(186009)(451199024)(40470700004)(36840700001)(46966006)(356005)(82740400003)(81166007)(6486002)(6506007)(36756003)(36860700001)(86362001)(47076005)(40480700001)(40460700003)(107886003)(1076003)(2616005)(2906002)(478600001)(26005)(336012)(6512007)(83380400001)(110136005)(5660300002)(316002)(8936002)(8676002)(4326008)(70586007)(70206006)(54906003)(41300700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: duagon.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 11:49:30.2306
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0448d536-77e7-4d9b-fe1e-08dbaecf54ae
X-MS-Exchange-CrossTenant-Id: e5e7e96e-8a28-45d6-9093-a40dd5b51a57
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5e7e96e-8a28-45d6-9093-a40dd5b51a57;Ip=[77.74.96.169];Helo=[securemail.duagon.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5PEPF00014B94.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZRAP278MB0922
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jorge Sanjuan Garcia <jorge.sanjuangarcia@duagon.com>

When calling mcb_bus_add_devices(), both mcb devices and the mcb
bus will attempt to attach a device to a driver because they share
the same bus_type. This causes an issue when trying to cast the
container of the device to mcb_device struct using to_mcb_device(),
leading to a wrong cast when the mcb_bus is added. A crash occurs
when freing the ida resources as the bus numbering of mcb_bus gets
confused with the is_added flag on the mcb_device struct.

The only reason for this cast was to keep an is_added flag on the
mcb_device struct that does not seem necessary. The function
device_attach() handles already bound devices and the mcb subsystem
does nothing special with this is_added flag so remove it completely.

Fixes: 18d288198099 ("mcb: Correctly initialize the bus's device")
Signed-off-by: Jorge Sanjuan Garcia <jorge.sanjuangarcia@duagon.com>
Co-developed-by: Jose Javier Rodriguez Barbarin <JoseJavier.Rodriguez@duago=
n.com>
Signed-off-by: Jose Javier Rodriguez Barbarin <JoseJavier.Rodriguez@duagon.=
com>
---
 drivers/mcb/mcb-core.c  | 10 +++-------
 drivers/mcb/mcb-parse.c |  2 --
 include/linux/mcb.h     |  1 -
 3 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/mcb/mcb-core.c b/drivers/mcb/mcb-core.c
index 978fdfc19a06..0cac5bead84f 100644
--- a/drivers/mcb/mcb-core.c
+++ b/drivers/mcb/mcb-core.c
@@ -387,17 +387,13 @@ EXPORT_SYMBOL_NS_GPL(mcb_free_dev, MCB);
=20
 static int __mcb_bus_add_devices(struct device *dev, void *data)
 {
-	struct mcb_device *mdev =3D to_mcb_device(dev);
 	int retval;
=20
-	if (mdev->is_added)
-		return 0;
-
 	retval =3D device_attach(dev);
-	if (retval < 0)
+	if (retval < 0) {
 		dev_err(dev, "Error adding device (%d)\n", retval);
-
-	mdev->is_added =3D true;
+		return retval;
+	}
=20
 	return 0;
 }
diff --git a/drivers/mcb/mcb-parse.c b/drivers/mcb/mcb-parse.c
index 2aef990f379f..656b6b71c768 100644
--- a/drivers/mcb/mcb-parse.c
+++ b/drivers/mcb/mcb-parse.c
@@ -99,8 +99,6 @@ static int chameleon_parse_gdd(struct mcb_bus *bus,
 	mdev->mem.end =3D mdev->mem.start + size - 1;
 	mdev->mem.flags =3D IORESOURCE_MEM;
=20
-	mdev->is_added =3D false;
-
 	ret =3D mcb_device_register(bus, mdev);
 	if (ret < 0)
 		goto err;
diff --git a/include/linux/mcb.h b/include/linux/mcb.h
index 1e5893138afe..0b971b24a804 100644
--- a/include/linux/mcb.h
+++ b/include/linux/mcb.h
@@ -63,7 +63,6 @@ static inline struct mcb_bus *to_mcb_bus(struct device *d=
ev)
 struct mcb_device {
 	struct device dev;
 	struct mcb_bus *bus;
-	bool is_added;
 	struct mcb_driver *driver;
 	u16 id;
 	int inst;
--=20
2.34.1
