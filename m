Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFC307B67E2
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 13:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239936AbjJCL3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 07:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231337AbjJCL3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 07:29:43 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF3268E;
        Tue,  3 Oct 2023 04:29:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l+OIUbxV/uy+OiPeZGWNVJO0DubUzTBarbND9fTZ2xJdGi0KRzeq7SCKZwnoj1P9K1ZmoHzcEglR1IsxGH7DVHi+SmgHJ3XP3tLqh20H36Hh8RrtpG6zHfEFXhGneWJQAJC7T4stg5Au5n9um0OerO6OD/n3pFRAxixknvSxCC0cxJWg+1aChTLYDa1DrMBupwTcFtmmWsp6szegjia45d6DYZv2ZvCv6HZmWa/9hQMKe/LVARxCP5tztML7FAh09vT+AjqabfU5oDQOTzcOU6PHYXciLuMafK4YpZjmaqq5cNZcWmg9P1KgKeEzsciSKjSfoHBAMneW3RZ76mEMCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wp0cO8AXbHjX6b6tMvT7XIoNMrZTFquW8F8P5hE/zww=;
 b=Mk7i8XQv3t4j/Bh0/DE73jSi9bUgSkRjPQAbxSrv6WPCFIRMZ65zQABis7escOBZe4z5qvvg6wbGoib0Q4+OW1ehBoO2drFZDapoEqVXUxtdFHythssJF1xK3zqi2lYYWTJndGE75wbl8m/8Pn6htIxajtJGKVwnnfOCdiKQ47F9pVLK21Twly+gtyKWf/AlRqx0QnzQFtPEFiuevGKSUOfQ3gYmj1HKhgktI6N/lv2QBGA2G5NITQE6QcR52UePCKEvg8Q7kQB8/hjz+lt2u+D3VmxKTptrCdL10DXlCCD8Nm/ClKuvviFj/Lk3tzVwv1FcGBpHt26dPT7q4iao3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=micron.com; dmarc=pass action=none header.from=micron.com;
 dkim=pass header.d=micron.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wp0cO8AXbHjX6b6tMvT7XIoNMrZTFquW8F8P5hE/zww=;
 b=HdraHhA4ZC2oCvCaEt9iryISQrQSHJ66mBUdls3KftOuhsq/UrhBjTbcQJVvaSIGAd6YYdW4oZR65QGMwGM8cCKd39Y4JlV9uQZWqYbkz4IoDIyScgqUcpcAj2FcTYb9NbpXbJklqSRhwtCWYIneYm4g/AmThZKsIM1XJkdBUYR95awdbu7ed70EjO6FNhQbx8LhDxOHZVKktrml+V3Tq8EX1zM049eDrvPPF6ENJ3NEs3Ln0X9O1U8HVgxWp9dFDQGncPB+6jz0sZNhcgOQJPCHdRQ1tbL8n/AZRPWZ1TBO9buir9lJ0T1upSI07aY1364eV8o2+eA6H+BHTyiFiw==
Received: from BYAPR08MB4437.namprd08.prod.outlook.com (2603:10b6:a02:ff::32)
 by SN4PR0801MB8017.namprd08.prod.outlook.com (2603:10b6:806:219::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Tue, 3 Oct
 2023 11:29:33 +0000
Received: from BYAPR08MB4437.namprd08.prod.outlook.com
 ([fe80::3def:2b75:4cc1:76e8]) by BYAPR08MB4437.namprd08.prod.outlook.com
 ([fe80::3def:2b75:4cc1:76e8%5]) with mapi id 15.20.6838.030; Tue, 3 Oct 2023
 11:29:33 +0000
From:   Domenico Punzo <dpunzo@micron.com>
To:     =?utf-7?B?TWFydGluIEh1bmRlYitBUGctbGw=?= <martin@geanix.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
CC:     Rouven Czerwinski <r.czerwinski@pengutronix.de>,
        =?utf-7?B?TStBT1UtbnMgUnVsbGcrQU9VLXJk?= <mans@mansr.com>,
        Alexander Shiyan <eagle.alexander923@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        JaimeLiao <jaimeliao.tw@gmail.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-7?B?U2VhbiBOeWVraitBT1ktcg==?= <sean@geanix.com>,
        Bean Huo <beanhuo@micron.com>
Subject: RE: [EXT] Re: [PATCH v2] mtd: rawnand: Ensure the nand chip supports
 cached reads
Thread-Topic: [EXT] Re: [PATCH v2] mtd: rawnand: Ensure the nand chip supports
 cached reads
Thread-Index: AQHZ8GxsHk1a7lkdfEql/mFIunWFFbAuxzIAgAEQUgCACCDMIA==
Date:   Tue, 3 Oct 2023 11:29:33 +0000
Message-ID: <BYAPR08MB4437B83D7D50F4135D0D40A9BBC4A@BYAPR08MB4437.namprd08.prod.outlook.com>
References: <20230922141717.35977-1-r.czerwinski@pengutronix.de>
         <e911f5d9c7def8c80904a17ad3924ecba6625998.camel@geanix.com>
         <20230926132725.5d570e1b@xps-13> <20230927170516.2604e8f2@xps-13>
 <b8de26e243afa3e5920455a4d8e5a3451a06d074.camel@geanix.com>
In-Reply-To: <b8de26e243afa3e5920455a4d8e5a3451a06d074.camel@geanix.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_ActionId=ff92b0b2-554a-4c59-9865-27b19789fd97;MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_ContentBits=0;MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_Enabled=true;MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_Method=Standard;MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_Name=Confidential;MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_SetDate=2023-10-03T11:27:23Z;MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_SiteId=f38a5ecd-2813-4862-b11b-ac1d563c806f;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=micron.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR08MB4437:EE_|SN4PR0801MB8017:EE_
x-ms-office365-filtering-correlation-id: b00dd9a7-b67a-4162-19c9-08dbc404042c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: G337NCO5df1naERh8rP9sxdfDeI2L0zzNRP6Kd7nHBfRE3eMw8VbI/uIl3JoCDPR67zL8ryBhOkUaF3uCAprHndvdjq1Q95eO5uibvvdhIOIWBjiQYhVFsf8coxoLjjGHNrbGAfBzxN/hQhwKSZZqEJvbn21VvEN8CW7xIICkMceSSOunQhEUuYF2izuw+E1e96a/nI6SQ5HWu8y6eSgwhz9GpkHTMO/x+b/bDPYOcfwpGk/V55p2qiVI9L0OHIOZ2q7kRjCZ6NsZtl0+lfrYbhbweLAKbN0tnF+bURobc29QuhfRC/2PWqtw+et70hkObKBPfTofiVFXJ+YiynxNboC3HG9G3ZAbNcvaSa0++c1db2QUIYTjSgfEplhsVh/ChVz3zwPoTuN9dg5YSiMheUtge/e2oIHFbcxJmikySVbA6+J5ygPSHDRbCePOVCA7dUFE4e2VEEs4uaxhMSPdVPMP2OU696jRXl/H7lV1t3Mv+cPeJ+4E4xtI8tBa6YNlOiK3eqeVNnOnSf2u/A44mCw+Fw/75kUeGwCggCSCwPKBa7Gxe3vxLy4pTCvkO6f4ebWN5cYCoXtO+hGz6UV7nJh8hwtxVXFhkV+8xIHn5v8BKg85HWO3OKwG1cJXbS9
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR08MB4437.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(39860400002)(346002)(366004)(376002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(5660300002)(41300700001)(8936002)(4326008)(316002)(52536014)(110136005)(66446008)(54906003)(64756008)(66476007)(66556008)(8676002)(76116006)(7416002)(66946007)(2906002)(55016003)(33656002)(9686003)(53546011)(6506007)(7696005)(478600001)(26005)(107886003)(71200400001)(83380400001)(86362001)(38070700005)(38100700002)(122000001)(66574015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-7?B?blFpZmR1QzVkTkcyQ1M1Ky1qQ1hMZVViT0FsbEdERDBjdzlFckczMVgzV2RE?=
 =?utf-7?B?RjN1aUdmcW11MWcrLWt6enE3L1RPM1ZGd0NzMVF3OFNRcDdxM2N2dEtZRGJy?=
 =?utf-7?B?QVBUbmdtT25XUFBOQTdtaEVJaUlmbmw3ZkNrUnUxVEluVEJ0amhhZEY3WmRI?=
 =?utf-7?B?UXdpcUtTWG93cm9Ic0xpYkRwNHR0M0hPQ3RLRC9aTmVKL3FqcjI2VGxTemVy?=
 =?utf-7?B?bks2SzZQU1lZUGRab1h6TGtndUZHRmZrNDNvdWxROVRvT2YwWEw4NmpmZTN6?=
 =?utf-7?B?MDlpcWQ0dkx6SkRzMWUzMktVVXJoN2prczJHMWNHMFhkZVpRazQ2QmpkVHVZ?=
 =?utf-7?B?UzMyTHdqT3RUME93dkRsZFQ3dExpaUdxN0tlcWFTbmp5bTVqcktpNWQ2bXZv?=
 =?utf-7?B?NnBZSFdPWkhBYzk0YUpzYklrOFJPQ204Y2ZNaDZxVkxDTEtVcVc3Q0VrNnVr?=
 =?utf-7?B?amJuUGtVOXJHWFpZclE3RDNxVnJXUE0vd1Bya3hlM2ZFREhYMystTW9QSVg5?=
 =?utf-7?B?bjZJdDBkTHNSSUlTWVp2VGlIY2VidkUrLWw0Ym9aOWdBUmhIODY5eE9pemRB?=
 =?utf-7?B?UWZFcWR2TWV1T2JFRk0wSHMwMENyWEdDNGNGVmNHeU11YystNEU5UGhJN1VL?=
 =?utf-7?B?MkpEeFNnWlZhRGdueDNaUXN0ZzZCRDVqd2xERVBlVFJzMnRRT0lUS01MZXZW?=
 =?utf-7?B?WE55eENRZFp4UDM3ekkzZmlaZHdNKy14bzRVKy16NzA4cistRVBMOXNuUzBq?=
 =?utf-7?B?UTR5VUV1QWVTQzRUWTN3YndQRkVMSzNnUzlDYTczWmtGTVRhUmNRYVg0N3BP?=
 =?utf-7?B?VHd0NlNRZDhoMmh6azlPOU9kMjhKYXY0a2k5Y0t5ajUzbWF0Ky14TThUOVUy?=
 =?utf-7?B?QkNDVm9pTGR3SHUxZHduL1JZRUNFMzArLTdRN3licystNWRKV1ZBNUxOcCst?=
 =?utf-7?B?Z1Q4TjRURGYrLXRoV284dnowM1hlcVNPMEN6QUlKVDU0QWlEUkpkZmkrLURB?=
 =?utf-7?B?SzZCcE5JZGNZVU5penZsMExwY2FXS2ovcDFFVkk5a1paZTA1M2dlWWlsMUlB?=
 =?utf-7?B?Y1VCUnc5M0h4QkNmT3dsdHBwR0ZGZEZqcHZpeTA1WW5JR1ZYTUFyUzkwVFhF?=
 =?utf-7?B?ZUFURzRrTGk0Ky00UTdwM0pieFV4NGxlVmdjTSstb052SktYM3ZuM25LWXlt?=
 =?utf-7?B?bkI5bHRKSmlibFZpRCstKy1TWGh4Ky02M1lyTGRpOTg1djBXVkJ6cWtOcXBJ?=
 =?utf-7?B?UEppQ0VOUU9ha3lMYlM3cEhjcUlQL3dqbVI1UFRzUE9rdjZqSXFkOGdyQnFF?=
 =?utf-7?B?cHZWWFczcURpa0s3Ky1vNnloWFZXcFk4QVhKN09zMkpLY0FwRjE1c2ZncWg1?=
 =?utf-7?B?YUVjRystWUh1ZDJnZHBOa2t3YThPejhybXUrLTNRYTh0Q2ozSHhlb3FQcERw?=
 =?utf-7?B?UHB6aFIzdlNQVXdVKy1MQm91bmxnVXlVL3NmakxlSy9pb09wNlZLVSstYUZs?=
 =?utf-7?B?RGJ2dy9haG5OUktIaVd3UU1xN3ltR1A0MjZPajRJVzFia1FrN291UWpNTkVn?=
 =?utf-7?B?SWVxRGZvSnd1N0RLVDRhVmoxYS9yRTE5T2NUQUhISkRQY2lRT1d0NEY2ZC9z?=
 =?utf-7?B?SWhUVGMrLTdLNlZkd0xxMSstQi9zWkZYNG5rZkVDSFdIY3hNY2poKy1CNVZ4?=
 =?utf-7?B?VGdMKy1QRzFwZkJHanpSRzlvaVYva2ZEVVF5YjRhdGVIZG5NYmxudjExMUM0?=
 =?utf-7?B?MDBYdVdtNWhLb2REdWlxckxaVistbGl6STltNmxlQVp3Ky1hT0VVRCstQkFH?=
 =?utf-7?B?cG5PSU0rLW10Y3FvUUtwNVpUYzRZMER2aVI4V3dXd2VUSDVKL2dQSmIrLUxt?=
 =?utf-7?B?d2tRUHVPTFAweDh3Nzdpd3pJUlRlUmpaS0ZodUx4U3lvSU9nWE1GSlVyRGdp?=
 =?utf-7?B?VGNzL2ZXTWhwV2U2WGpwRnQ1bjlabVhwazFzYXptZmdhTTRpSUVTSUJ1VmNR?=
 =?utf-7?B?eVdUVDhpdkVXYlhrOTB4ZVlqOTFjUWoxc0JzeVl5azJkNlkxcWhFbVpIU0M4?=
 =?utf-7?B?c2ptNE9lOGJlRVBtMHJpOXhJbFNxb1hVS3k3ZXhpZmpzQ2dobXF6Y3FJTXlw?=
 =?utf-7?B?ODFrQkZrYzNpbVJYVzRGQTJiLystZUdWdWxVUGtiQzdiTVR3RUdvZ2NXeW9s?=
 =?utf-7?B?SUhlWnJZQjdJS1h3YzM=?=
Content-Type: text/plain; charset="utf-7"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR08MB4437.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b00dd9a7-b67a-4162-19c9-08dbc404042c
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2023 11:29:33.1409
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jz2zLzPkOZ1DqwnvW3e5NcCham1jG6Xvs/0hQ+BGEMtPfOKkm9qRGFCuL29D6NVokO2lTMQg0doirftRnBZU0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0801MB8017
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Micron Confidential

Hello Miquel,

Here is a short list of devices having cache read with ECC enabled.

MT29F2G08ABAGAH4, MT29F2G08ABBGAH4, MT29F2G16ABBGAH4
MT29F1G08ABAFAH4, MT29F1G08ABBFAH4, MT29F1G16ABBFAH4

Thanks.
Regards,
Domenico P.




Micron Confidential
-----Original Message-----
From: Martin Hundeb+APg-ll +ADw-martin+AEA-geanix.com+AD4-
Sent: Thursday, September 28, 2023 9:20 AM
To: Miquel Raynal +ADw-miquel.raynal+AEA-bootlin.com+AD4-
Cc: Rouven Czerwinski +ADw-r.czerwinski+AEA-pengutronix.de+AD4AOw- M+AOU-ns=
 Rullg+AOU-rd +ADw-mans+AEA-mansr.com+AD4AOw- Alexander Shiyan +ADw-eagle.a=
lexander923+AEA-gmail.com+AD4AOw- Richard Weinberger +ADw-richard+AEA-nod.a=
t+AD4AOw- Vignesh Raghavendra +ADw-vigneshr+AEA-ti.com+AD4AOw- JaimeLiao +A=
Dw-jaimeliao.tw+AEA-gmail.com+AD4AOw- kernel+AEA-pengutronix.de+ADs- stable=
+AEA-vger.kernel.org+ADs- linux-mtd+AEA-lists.infradead.org+ADs- linux-kern=
el+AEA-vger.kernel.org+ADs- Sean Nyekj+AOY-r +ADw-sean+AEA-geanix.com+AD4AO=
w- Domenico Punzo +ADw-dpunzo+AEA-micron.com+AD4AOw- Bean Huo +ADw-beanhuo+=
AEA-micron.com+AD4-
Subject: +AFs-EXT+AF0- Re: +AFs-PATCH v2+AF0- mtd: rawnand: Ensure the nand=
 chip supports cached reads

CAUTION: EXTERNAL EMAIL. Do not click links or open attachments unless you =
recognize the sender and were expecting this message.


Hi Miquel,

On Wed, 2023-09-27 at 17:05 +-0200, Miquel Raynal wrote:
+AD4- Hi Martin,
+AD4-
+AD4- miquel.raynal+AEA-bootlin.com wrote on Tue, 26 Sep 2023 13:27:25 +-02=
00:
+AD4-
+AD4- +AD4- Hi Martin,
+AD4- +AD4-
+AD4- +AD4- +- Bean and Domenico, there is a question for you below.
+AD4- +AD4-
+AD4- +AD4- martin+AEA-geanix.com wrote on Mon, 25 Sep 2023 13:01:06 +-0200=
:
+AD4- +AD4-
+AD4- +AD4- +AD4- Hi Rouven,
+AD4- +AD4- +AD4-
+AD4- +AD4- +AD4- On Fri, 2023-09-22 at 16:17 +-0200, Rouven Czerwinski wro=
te:
+AD4- +AD4- +AD4- +AD4- Both the JEDEC and ONFI specification say that read=
 cache
+AD4- +AD4- +AD4- +AD4- sequential support is an optional command. This mea=
ns that we
+AD4- +AD4- +AD4- +AD4- not only need to check whether the individual contr=
oller
+AD4- +AD4- +AD4- +AD4- supports the command, we also need to check the par=
ameter pages
+AD4- +AD4- +AD4- +AD4- for both ONFI and JEDEC NAND flashes before enablin=
g sequential
+AD4- +AD4- +AD4- +AD4- cache reads.
+AD4- +AD4- +AD4- +AD4-
+AD4- +AD4- +AD4- +AD4- This fixes support for NAND flashes which don't sup=
port enabling
+AD4- +AD4- +AD4- +AD4- cache reads, i.e. Samsung K9F4G08U0F or Toshiba TC5=
8NVG0S3HTA00.
+AD4- +AD4- +AD4- +AD4-
+AD4- +AD4- +AD4- +AD4- Sequential cache reads are now only available for O=
NFI and JEDEC
+AD4- +AD4- +AD4- +AD4- devices, if individual vendors implement this, it n=
eeds to be
+AD4- +AD4- +AD4- +AD4- enabled per vendor.
+AD4- +AD4- +AD4- +AD4-
+AD4- +AD4- +AD4- +AD4- Tested on i.MX6Q with a Samsung NAND flash chip tha=
t doesn't
+AD4- +AD4- +AD4- +AD4- support sequential reads.
+AD4- +AD4- +AD4- +AD4-
+AD4- +AD4- +AD4- +AD4- Fixes: 003fe4b9545b (+ACI-mtd: rawnand: Support for=
 sequential cache
+AD4- +AD4- +AD4- +AD4- reads+ACI-)
+AD4- +AD4- +AD4- +AD4- Cc: stable+AEA-vger.kernel.org
+AD4- +AD4- +AD4- +AD4- Signed-off-by: Rouven Czerwinski +ADw-r.czerwinski+=
AEA-pengutronix.de+AD4-
+AD4- +AD4- +AD4-
+AD4- +AD4- +AD4- Thanks for this. It works as expected for my Toshiba chip=
,
+AD4- +AD4- +AD4- obviously because it doesn't use ONFI or JEDEC.
+AD4- +AD4- +AD4-
+AD4- +AD4- +AD4- Unfortunately, my Micron chip does use ONFI, and it sets =
the
+AD4- +AD4- +AD4- cached-
+AD4- +AD4- +AD4- read-supported bit. It then fails when reading afterwords=
:
+AD4-
+AD4- I might have over reacted regarding my findings in Micron's datasheet=
,
+AD4- I need to know if you use the on-die ECC engine or if you use the one
+AD4- on the controller. In the former case the failure is expected. In the
+AD4- latter case, it's not.

I use the default, which seems to be the controller engine?

// Martin

+AD4- Thanks,
+AD4- Miqu+AOg-l
+AD4-
+AD4- +AD4- +AD4- kernel: ONFI+AF8-OPT+AF8-CMD+AF8-READ+AF8-CACHE +ACM- deb=
ug added by me
+AD4- +AD4- +AD4- kernel: nand: device found, Manufacturer ID: 0x2c, Chip I=
D: 0xdc
+AD4- +AD4- +AD4- kernel: nand: Micron MT29F4G08ABAFAWP
+AD4- +AD4- +AD4- kernel: nand: 512 MiB, SLC, erase size: 256 KiB, page siz=
e: 4096,
+AD4- +AD4- +AD4- OOB
+AD4- +AD4- +AD4- size: 256
+AD4- +AD4- +AD4- kernel: nand: continued read supported +ACM- debug added =
by me
+AD4- +AD4- +AD4- kernel: Bad block table found at page 131008, version 0x0=
1
+AD4- +AD4- +AD4- kernel: Bad block table found at page 130944, version 0x0=
1
+AD4- +AD4- +AD4- kernel: 2 fixed-partitions partitions found on MTD device=
 gpmi-
+AD4- +AD4- +AD4- nand
+AD4- +AD4- +AD4- kernel: Creating 2 MTD partitions on +ACI-gpmi-nand+ACI-:
+AD4- +AD4- +AD4- kernel: 0x000000000000-0x000000800000 : +ACI-boot+ACI-
+AD4- +AD4- +AD4- kernel: 0x000000800000-0x000020000000 : +ACI-ubi+ACI-
+AD4- +AD4- +AD4- kernel: gpmi-nand 1806000.nand-controller: driver registe=
red.
+AD4- +AD4- +AD4-
+AD4- +AD4- +AD4- ...
+AD4- +AD4- +AD4-
+AD4- +AD4- +AD4- kernel: ubi0: default fastmap pool size: 100
+AD4- +AD4- +AD4- kernel: ubi0: default fastmap WL pool size: 50
+AD4- +AD4- +AD4- kernel: ubi0: attaching mtd1
+AD4- +AD4- +AD4- kernel: ubi0: scanning is finished
+AD4- +AD4- +AD4- kernel: ubi0: attached mtd1 (name +ACI-ubi+ACI-, size 504=
 MiB)
+AD4- +AD4- +AD4- kernel: ubi0: PEB size: 262144 bytes (256 KiB), LEB size:=
 253952
+AD4- +AD4- +AD4- bytes
+AD4- +AD4- +AD4- kernel: ubi0: min./max. I/O unit sizes: 4096/4096, sub-pa=
ge size
+AD4- +AD4- +AD4- 4096
+AD4- +AD4- +AD4- kernel: ubi0: VID header offset: 4096 (aligned 4096), dat=
a
+AD4- +AD4- +AD4- offset: 8192
+AD4- +AD4- +AD4- kernel: ubi0: good PEBs: 2012, bad PEBs: 4, corrupted PEB=
s: 0
+AD4- +AD4- +AD4- kernel: ubi0: user volume: 9, internal volumes: 1, max. v=
olumes
+AD4- +AD4- +AD4- count:
+AD4- +AD4- +AD4- 128
+AD4- +AD4- +AD4- kernel: ubi0: max/mean erase counter: 4/2, WL threshold: =
4096,
+AD4- +AD4- +AD4- image sequence number: 1431497221
+AD4- +AD4- +AD4- kernel: ubi0: available PEBs: 12, total reserved PEBs: 20=
00, PEBs
+AD4- +AD4- +AD4- reserved for bad PEB handling: 36
+AD4- +AD4- +AD4- kernel: block ubiblock0+AF8-4: created from ubi0:4(rootfs=
.a)
+AD4- +AD4- +AD4- kernel: ubi0: background thread +ACI-ubi+AF8-bgt0d+ACI- s=
tarted, PID 36
+AD4- +AD4- +AD4- kernel: block ubiblock0+AF8-6: created from ubi0:6(appfs.=
a)
+AD4- +AD4- +AD4- kernel: block ubiblock0+AF8-7: created from ubi0:7(appfs.=
b)
+AD4- +AD4- +AD4-
+AD4- +AD4- +AD4- ...
+AD4- +AD4- +AD4-
+AD4- +AD4- +AD4- kernel: SQUASHFS error: Unable to read directory block
+AD4- +AD4- +AD4- +AFs-4b6d15c:ed1+AF0-
+AD4- +AD4- +AD4- kernel: SQUASHFS error: Unable to read directory block
+AD4- +AD4- +AD4- +AFs-4b6f15e:125+AF0-
+AD4- +AD4- +AD4- kernel: SQUASHFS error: Unable to read directory block
+AD4- +AD4- +AD4- +AFs-4b6d15c:1dae+AF0-
+AD4- +AD4- +AD4- kernel: SQUASHFS error: Unable to read directory block
+AD4- +AD4- +AD4- +AFs-4b6d15c:ed1+AF0-
+AD4- +AD4- +AD4- (d-sysctl)+AFs-55+AF0-: systemd-sysctl.service: Failed to=
 set up
+AD4- +AD4- +AD4- credentials:
+AD4- +AD4- +AD4- Protocol error
+AD4- +AD4- +AD4- kernel: SQUASHFS error: Unable to read directory block
+AD4- +AD4- +AD4- +AFs-4b73162:14f0+AF0-
+AD4- +AD4- +AD4- kernel: SQUASHFS error: Unable to read directory block
+AD4- +AD4- +AD4- +AFs-4b6f15e:838+AF0-
+AD4- +AD4- +AD4- systemd+AFs-1+AF0-: Starting Create Static Device Nodes i=
n /dev...
+AD4- +AD4- +AD4- kernel: SQUASHFS error: Unable to read directory block
+AD4- +AD4- +AD4- +AFs-4b6d15c:ed1+AF0-
+AD4- +AD4- +AD4- kernel: SQUASHFS error: Unable to read directory block
+AD4- +AD4- +AD4- +AFs-4b6d15c:ed1+AF0-
+AD4- +AD4- +AD4- kernel: SQUASHFS error: Unable to read directory block
+AD4- +AD4- +AD4- +AFs-4b6f15e:838+AF0-
+AD4- +AD4- +AD4- kernel: SQUASHFS error: Unable to read directory block
+AD4- +AD4- +AD4- +AFs-4b6d15c:1dae+AF0-
+AD4- +AD4- +AD4- kernel: SQUASHFS error: Unable to read directory block
+AD4- +AD4- +AD4- +AFs-4b6f15e:125+AF0-
+AD4- +AD4- +AD4-
+AD4- +AD4- +AD4- I've briefly tried adding some error info the the squashf=
s error
+AD4- +AD4- +AD4- messages, but it looks like it's getting bad data. I.e. o=
ne
+AD4- +AD4- +AD4- failure a sanity check of +AGA-dir+AF8-count+AGA-:
+AD4- +AD4- +AD4-
+AD4- +AD4- +AD4- if (dir+AF8-count +AD4- SQUASHFS+AF8-DIR+AF8-COUNT)
+AD4- +AD4- +AD4-         goto data+AF8-error+ADs-
+AD4- +AD4- +AD4-
+AD4- +AD4- +AD4- It fails with +AGA-dir+AF8-count+AGA- being 1952803684 ..=
.
+AD4- +AD4- +AD4-
+AD4- +AD4- +AD4- So is this a case of wrong/bad timings?
+AD4- +AD4- +AD4-
+AD4- +AD4- +AD4- Miquel:
+AD4- +AD4- +AD4- I can tell from the code, that the READCACHESEQ operation=
s are
+AD4- +AD4- +AD4- followed by NAND+AF8-OP+AF8-WAIT+AF8-RDY(tR+AF8-max, tRR+=
AF8-min). From the Micron
+AD4- +AD4- +AD4- datasheet+AFs-0+AF0-, it should be NAND+AF8-OP+AF8-WAIT+A=
F8-RDY(tRCBSY+AF8-max, tRR+AF8-min),
+AD4- +AD4- +AD4- where tRCBSY is defined to be between 3 and 25 +ALU-s.
+AD4- +AD4-
+AD4- +AD4- I found a place in the ONFI spec states taht tRCBSY+AF8-max sho=
uld be
+AD4- +AD4- between 3 and tR+AF8-max, so indeed we should be fine on that r=
egard.
+AD4- +AD4-
+AD4- +AD4- However, I asked myself whether we could have issues when cross=
ing
+AD4- +AD4- boundaries. Block boundaries should be fine, however your devic=
e
+AD4- +AD4- does not support crossing plane boundaries, as bit 4 (+ACI-read=
 cache
+AD4- +AD4- supported+ACI-) of byte 114 (+ACI-Multi-plane operation attribu=
tes+ACI-) in the
+AD4- +AD4- memory organization block of the parameter page is not set (the
+AD4- +AD4- value of the byte should be 0x0E if I get it right.
+AD4- +AD4-
+AD4- +AD4- Anyway, our main issue here does not seem related to the bounda=
ries.
+AD4- +AD4- It does not seem to be explicitly marked anywhere else but on t=
he
+AD4- +AD4- front
+AD4- +AD4- page:
+AD4- +AD4-         Advanced command set
+AD4- +AD4-         +IBM- Program page cache mode (4)
+AD4- +AD4-         +IBM- Read page cache mode (4)
+AD4- +AD4-         +IBM- Two-plane commands (4)
+AD4- +AD4-
+AD4- +AD4-         (4) These commands supported only with ECC disabled.
+AD4- +AD4-
+AD4- +AD4- Read page cache mode without ECC makes the feature pretty usele=
ss
+AD4- +AD4- IMHO.
+AD4- +AD4-
+AD4- +AD4- Bean, Domenico, how do we know which devices allow ECC correcti=
on
+AD4- +AD4- during sequential page reads and which don't? Is there a (vendo=
r?)
+AD4- +AD4- bit somewhere in the parameter page for that? Do we have any wa=
y to
+AD4- +AD4- know besides a list of devices allowing that? If so, can you pr=
ovide
+AD4- +AD4- one with a few IDs?
+AD4- +AD4-
+AD4- +AD4- Thanks,
+AD4- +AD4- Miqu+AOg-l

