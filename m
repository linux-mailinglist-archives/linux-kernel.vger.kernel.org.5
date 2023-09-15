Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69DB67A1D4E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 13:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233876AbjIOLT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 07:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231745AbjIOLT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 07:19:57 -0400
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com (mail-zr0che01on2109.outbound.protection.outlook.com [40.107.24.109])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 471A4101
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 04:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=klq8fFKpPkCU9+Tvj7oG0LolUdRulW4uoNxZ/o/rQQU=;
 b=eGVQMPB29/+ougYKIYHCgrJVZ4727egRmlDDwZEvqDvfaHgZ1OZtkWVtC+5Zad5Ud2qqdh2NP7xIFrIY0zqLOYTadm38q4QoW6egPNBG7ncVtrpMNxaAb4/zkWK2JitVI2DQkfPAj8n654pz86Nwd4bpmNeICwzXwXpQiE5gmxQ=
Received: from AS9PR04CA0080.eurprd04.prod.outlook.com (2603:10a6:20b:48b::28)
 by ZR2P278MB1081.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:5f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21; Fri, 15 Sep
 2023 11:19:48 +0000
Received: from AMS1EPF00000044.eurprd04.prod.outlook.com
 (2603:10a6:20b:48b:cafe::26) by AS9PR04CA0080.outlook.office365.com
 (2603:10a6:20b:48b::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21 via Frontend
 Transport; Fri, 15 Sep 2023 11:19:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 77.74.96.169)
 smtp.mailfrom=duagon.com; dkim=pass (signature was verified)
 header.d=duagon.com;dmarc=pass action=none header.from=duagon.com;
Received-SPF: Pass (protection.outlook.com: domain of duagon.com designates
 77.74.96.169 as permitted sender) receiver=protection.outlook.com;
 client-ip=77.74.96.169; helo=securemail.duagon.com; pr=C
Received: from securemail.duagon.com (77.74.96.169) by
 AMS1EPF00000044.mail.protection.outlook.com (10.167.16.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.20 via Frontend Transport; Fri, 15 Sep 2023 11:19:47 +0000
Received: from securemail (localhost [127.0.0.1])
        by securemail.duagon.com (Postfix) with SMTP id 4RnBYH0mqpzxpF;
        Fri, 15 Sep 2023 13:19:47 +0200 (CEST)
Received: from CHE01-GV0-obe.outbound.protection.outlook.com (mail-gv0che01lp2049.outbound.protection.outlook.com [104.47.22.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by securemail.duagon.com (Postfix) with ESMTPS;
        Fri, 15 Sep 2023 13:19:46 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b2SQFEmQALzb8SXosfPC+gmXNiFr5/9qvx1m91aI2N2sI9viAky7peUOn9w49T9eU1iT2E5ycNQPUNOFAjcYNNg1gQy1dc6R0NxYoetPKxn8pFpziyIsjk71+8X0FWZBR74yP1Ifb3dl5KbtOONjhnotC8uLvT69jaq9IGSjvEMR3saWO6f1m46hxXieQklniyc8287L1AT8AqGOzt9olSaeaYPqrLiLdqfniDKL5eO/zK4VOG//I6gPqbd/xfUpUpWtfvl4oJXOlFWyMzvknlQDexBbtDjzPoJdSbPK3jrRZ8MrsKnk5l7MjNKcLWgl8ogQBLdhXJbU3LCou9TmAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=klq8fFKpPkCU9+Tvj7oG0LolUdRulW4uoNxZ/o/rQQU=;
 b=TU0VBaLVOSa8y5Cv8SfoGEDgr1WObh9RvAnoWmEu6Bi9evtlh8bnVrLvPF/LmWY9ezI0ACgKdEBiIdDAyiP8pVLf8sgepX1+ybxWuheJiEecdHaog/zeDyHWiDBL5L+eQOUR7FILOxfNzlDk3fZW+qsHK3hV1p7IHSTOKV5hrtfxeYbBqazupVRS/Kz0b0MvnyJNrGyItvCSYc1SqSixQ9AB/MAKW28usBjKu/6sUeMNY2ixCALalwg59Fhio7FR0SV33Ng4OMMiwtmLRiEr+6IExXHaFxp91vQ6eORysWDrCXEJjqGsL7A0/7TOfPiqRJj7VFUBZUVnb6si2Az9eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=duagon.com; dmarc=pass action=none header.from=duagon.com;
 dkim=pass header.d=duagon.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=klq8fFKpPkCU9+Tvj7oG0LolUdRulW4uoNxZ/o/rQQU=;
 b=eGVQMPB29/+ougYKIYHCgrJVZ4727egRmlDDwZEvqDvfaHgZ1OZtkWVtC+5Zad5Ud2qqdh2NP7xIFrIY0zqLOYTadm38q4QoW6egPNBG7ncVtrpMNxaAb4/zkWK2JitVI2DQkfPAj8n654pz86Nwd4bpmNeICwzXwXpQiE5gmxQ=
Received: from GV0P278MB0516.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:2e::11)
 by GVAP278MB0834.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:55::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21; Fri, 15 Sep
 2023 11:19:43 +0000
Received: from GV0P278MB0516.CHEP278.PROD.OUTLOOK.COM
 ([fe80::b5b0:c06f:32d2:7848]) by GV0P278MB0516.CHEP278.PROD.OUTLOOK.COM
 ([fe80::b5b0:c06f:32d2:7848%4]) with mapi id 15.20.6792.021; Fri, 15 Sep 2023
 11:19:43 +0000
From:   =?iso-8859-1?Q?Sanju=E1n_Garc=EDa=2C_Jorge?= 
        <Jorge.SanjuanGarcia@duagon.com>
To:     "morbidrsa@gmail.com" <morbidrsa@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jth@kernel.org" <jth@kernel.org>,
        =?iso-8859-1?Q?Rodr=EDguez_Barbarin=2C_Jos=E9_Javier?= 
        <josejavier.rodriguez@duagon.com>,
        =?iso-8859-1?Q?Sanju=E1n_Garc=EDa=2C_Jorge?= 
        <Jorge.SanjuanGarcia@duagon.com>
Subject: [PATCH] mcb: mcb-pci: detect IO mapped devices before requesting
 resources
Thread-Topic: [PATCH] mcb: mcb-pci: detect IO mapped devices before requesting
 resources
Thread-Index: AQHZ58aGo5gHo1jieUKIc0CNeNSULg==
Date:   Fri, 15 Sep 2023 11:19:43 +0000
Message-ID: <20230915111912.258075-1-jorge.sanjuangarcia@duagon.com>
Accept-Language: es-ES, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=duagon.com;
x-ms-traffictypediagnostic: GV0P278MB0516:EE_|GVAP278MB0834:EE_|AMS1EPF00000044:EE_|ZR2P278MB1081:EE_
X-MS-Office365-Filtering-Correlation-Id: 584a5490-86e5-423c-80c3-08dbb5ddabc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 8eAvmIm2G4RjcbFBz6pfy5hPcz2Ky6hCDk+DHe1diL1vFXNKua7MdXRVKBCUSCQYKsDemxIaPEFxSijot9BOUWDDL4ttX+hlb7hZ84GSZLP2Qz2AZbFwIKYEY6QNO3SJ6m3FUtswCi7cuxpJlHaKcXiAxK3kSYrMQ4lYbdGYgna2y4QxPCWAZAFkMbmZ0rqTVDXseFKQUdkygu9QdGEiQGMZxYllPKjQDs/jiH/VGrN2rBIDoYG0a2sqCT/6VO1Gyh+tp5T9bit5SQSfZRkYPLhA1Co3gUMYTAdA42CxXvL/OjmWINf3vEKY4jiLcl88lUetT/ETk4thTk6GSqLGRwC+1I18+DPUK08Enycf8cpW1vM9rDat9kfKdgnetRVrPa/koDlXBekVoLXxKwIh/s43+1T2L7gAucopFHB+UgKU6EjanMMIAEf7iLw4P0CMA1Hj87DOqzjEmJuVi6JrHPul2/oduRwfIwQUldNU8cZZYWzaBkgOm70rI2vCZ95rwr5Gj4mFJcRNYogRDev1Sr8YGxkv6A3KQOwALok3mtBRp+/klSUgLqHSn8Lny1F1cuNFo/x7lpJiQyx9eY9BHEl+pqBnfHrzgJsI+rDoXF1xixPqdGOlxm+GvrGiImnN
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV0P278MB0516.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(39850400004)(376002)(366004)(396003)(451199024)(186009)(1800799009)(122000001)(38100700002)(38070700005)(478600001)(83380400001)(1076003)(71200400001)(26005)(86362001)(2616005)(36756003)(107886003)(6512007)(6506007)(6486002)(66476007)(4326008)(54906003)(64756008)(66446008)(66946007)(66556008)(8936002)(91956017)(41300700001)(5660300002)(76116006)(8676002)(6916009)(316002)(2906002);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVAP278MB0834
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AMS1EPF00000044.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 43e3d6d1-9112-4c58-7c41-08dbb5dda92f
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tCaQfEqgrfeRwoS1l/eSdMWz+tdKIyDr6QDWrcvF9G7mrNs7l7LhBxC/Ht26ZQ7eFrZhLKEr2UMcJ154YnxTQuaem7qOCCKw6CIFdFW+Uepbx9MMFhiG+U73VA15hrdGtByl5wQ3ghj85+ecrGdYbyoo8ErO9fPj5XLeyMYt+dDmoVdSA5OytjsYG0iBi+2MdbdO2lXF606G5lp7KL9USssxmBn0ORLr8V68FjCxXojgySMQgF4wo27VazcMYvNEnNFIezV1qsTPi9nHxvASrLv3xReLvqnCPkQz7lrZQJ9GW/QkwgbgR7Q2h2EF4GMlsynAQQODMHaxU42TyxrvXNO9HOK2hlavSutofNXNITwWx8wzoQpzeOOi0entc96JSw0YI/YK1qjasmfdJqlwEe+1So30nVMAjfUEN/HZd+QQCnEXhYFh7bWxKJR+a7vYLtMFmJWkb+xzDKGryGxXNR1x2PV6FAggAHoBwPcEaqROtjlo4XobhykIynpFUukvQU+j1RLIuOhF88vXg2muhVNnCp77BqS4n172TXRNVTiofyzAGOQzs8ErWpQwdx0eaqxRya5C1yOjF0Yj7uRl7fuRhV9QRxwUh8U9TFQMnrWmJSmKvvaPNPqWzAAOwSQCsG26Pnvkgi4W0dYy0aOF59rXydWrkhhDKzqUkWBs7NCTVIjI3jCOZ/Aqp0mWi+Em7POOh3eC+piqt+3hvP52kg==
X-Forefront-Antispam-Report: CIP:77.74.96.169;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:securemail.duagon.com;PTR:169.96.74.77.ftth.as8758.net;CAT:NONE;SFS:(13230031)(136003)(346002)(396003)(376002)(39850400004)(451199024)(1800799009)(186009)(82310400011)(36840700001)(46966006)(6506007)(6486002)(36756003)(81166007)(86362001)(82740400003)(40480700001)(356005)(36860700001)(2616005)(1076003)(107886003)(26005)(2906002)(336012)(6512007)(478600001)(83380400001)(5660300002)(316002)(8676002)(47076005)(41300700001)(8936002)(4326008)(6916009)(54906003)(70586007)(70206006);DIR:OUT;SFP:1102;
X-OriginatorOrg: duagon.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 11:19:47.5001
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 584a5490-86e5-423c-80c3-08dbb5ddabc8
X-MS-Exchange-CrossTenant-Id: e5e7e96e-8a28-45d6-9093-a40dd5b51a57
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5e7e96e-8a28-45d6-9093-a40dd5b51a57;Ip=[77.74.96.169];Helo=[securemail.duagon.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS1EPF00000044.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR2P278MB1081
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the memory region is requested with devm_request_mem_region()
for an IO mapped device it will return an error and mcb-pci will
incorrectly report it with EBUSY code.

Make sure we identify if the reosure is IO mapped and fail early
with a correct ENOTSUPP code.

Reviewed-by: Jose Javier Rodriguez Barbarin <JoseJavier.Rodriguez@duagon.co=
m>
Signed-off-by: Jorge Sanjuan Garcia <jorge.sanjuangarcia@duagon.com>
---
 drivers/mcb/mcb-pci.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/mcb/mcb-pci.c b/drivers/mcb/mcb-pci.c
index 53d9202ff9a7..3b634ea318c7 100644
--- a/drivers/mcb/mcb-pci.c
+++ b/drivers/mcb/mcb-pci.c
@@ -45,6 +45,14 @@ static int mcb_pci_probe(struct pci_dev *pdev, const str=
uct pci_device_id *id)
 	}
 	pci_set_master(pdev);
=20
+	flags =3D pci_resource_flags(pdev, 0);
+	if (flags & IORESOURCE_IO) {
+		ret =3D -ENOTSUPP;
+		dev_err(&pdev->dev,
+			"IO mapped PCI devices are not supported\n");
+		goto out_disable;
+	}
+
 	priv->mapbase =3D pci_resource_start(pdev, 0);
 	if (!priv->mapbase) {
 		dev_err(&pdev->dev, "No PCI resource\n");
@@ -68,14 +76,6 @@ static int mcb_pci_probe(struct pci_dev *pdev, const str=
uct pci_device_id *id)
 		goto out_disable;
 	}
=20
-	flags =3D pci_resource_flags(pdev, 0);
-	if (flags & IORESOURCE_IO) {
-		ret =3D -ENOTSUPP;
-		dev_err(&pdev->dev,
-			"IO mapped PCI devices are not supported\n");
-		goto out_disable;
-	}
-
 	pci_set_drvdata(pdev, priv);
=20
 	priv->bus =3D mcb_alloc_bus(&pdev->dev);
--=20
2.34.1
