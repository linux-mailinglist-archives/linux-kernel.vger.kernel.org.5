Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB6A07B5A80
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 20:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238833AbjJBSoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 14:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232711AbjJBSoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 14:44:10 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B19CEAC;
        Mon,  2 Oct 2023 11:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1696272247; x=1727808247;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dpXNZR95GnQ7j7RZqvdqsZBjPPdbMMqTqMY0VziX0m8=;
  b=jF8M8/XxH7sn/1LurI3iUitZMzoc15GOSwsWwY9t8xUNxaSwLrS73JFH
   2jlC56ZwwqcDVzIcQyVLhiAUbgn7RXIdvJM5532aUNaeFL9ccwAeFohW8
   gDb5ca/TASl2GjWv14DVcTScf6jv8rGtm1UXhGzZU1w0R8YfR2mEyhBf0
   SoJJ4FUE9IEbxBoQHieJthKxcCnCHWUZ7aPR9ZO6XFJc4DpvQKOUaHiuE
   yjjV3BM5z7sRqQVGuOpkJqkh97BSEGInm6jDdVnAMmnJbTruVouyIBp4I
   k5Rey4mPjIQ92hb9jJx0Eu6C9avepQ6UxR4daT+LoyJzHb1P0UZjbVeoX
   g==;
X-CSE-ConnectionGUID: j6yRy87HTQezaaIfKK+fRQ==
X-CSE-MsgGUID: UdpcXLaMTqit7B5E2T04jQ==
X-IronPort-AV: E=Sophos;i="6.03,194,1694707200"; 
   d="scan'208";a="249993294"
Received: from mail-bn8nam04lp2043.outbound.protection.outlook.com (HELO NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.43])
  by ob1.hgst.iphmx.com with ESMTP; 03 Oct 2023 02:44:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GDkktMP8MvZSZb3FqTVDsspz8N+HyKb0WfwUgPkUpGLw5zZ9v5Hdgk0Xd1w2ii/+GUL9CFOOuMHIb80jk3icN++1JSJvDSJtui3gN4ehEMqA1RtB0eg5/6M8fqUlD40WVPjO78gQ0uXUD6r0zCi/JAryuuyhIfDPABG8nJiw6MdbNDroJFZnqhrTiVeekuhu8+6Pl1srmoDkYO/XRXuNAxPPgD12t7abwr36Yv+/I+UcjQCikM4/NrFrIWWdVGOtMDVbOpcLNHZ2N1Z4+mG3w40Pac6dqQSsyxQpQPUN8pAwAfCIpILh1Qa+4r37iFtcu0fxrPNf5v7dc0ytgtZ6ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dpXNZR95GnQ7j7RZqvdqsZBjPPdbMMqTqMY0VziX0m8=;
 b=Ya6fYsVoJqYZf7gswgqA4eElqsxvlyy9kp5yj2WLn2yBDAmvkt1lxSXbVgMQ3+zER0JfdVGhWDHeOrpzrEDnmwJRZVt8WViRR/VkGJxNKn1aIw+eIZ42uy3Q4wq0+5EG2vxD/W4Tk5D8Pqx0l1GJnPBavnTfozgbs8xJR6DX/RK5iT0xRnmeMgcbovceBlfc95xiHeISSc5kPoHS7uI1Dj4Lp2ewx/hXbyY7wyAvg5+rmV3kSSOrwOKDlVuPNfrNxrmd2I8D4O7tT6SqFD917MBO7OZ7wsY/Mt/XZOuT4ImOaR/4jvMDFEmnEO7EHzT+tM+xf5b89zSW6FXC+CTiXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dpXNZR95GnQ7j7RZqvdqsZBjPPdbMMqTqMY0VziX0m8=;
 b=afYOadWFHUY8b6XFVKTTwHRkgk2vi6MvIOHdtAz5q/AJHfUuJygD3KZHECgpHN0v2bpwSKxoH3RPwNGRwoulfYWBsuj1CfWeJp0dzyuuxQJF2b43MAHMcbGWPkIhlBX+C3fKvbQNt7PqU83wDZzx4122jpKlM2u1RBGvRaNYBrs=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 BN8PR04MB6402.namprd04.prod.outlook.com (2603:10b6:408:7a::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.19; Mon, 2 Oct 2023 18:44:03 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::8e15:c9a8:1531:8fbe]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::8e15:c9a8:1531:8fbe%3]) with mapi id 15.20.6838.016; Mon, 2 Oct 2023
 18:44:03 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "James E.J. Bottomley" <jejb@linux.ibm.com>
Subject: RE: [PATCH v1 1/1] scsi: ufs: ufs-pci: Switch to use
 acpi_evaluate_dsm_typed()
Thread-Topic: [PATCH v1 1/1] scsi: ufs: ufs-pci: Switch to use
 acpi_evaluate_dsm_typed()
Thread-Index: AQHZ9TeTgZoPXcBocE2e/jZl7qXvHLA21jqg
Date:   Mon, 2 Oct 2023 18:44:03 +0000
Message-ID: <DM6PR04MB65756AD44807B701ED1A5120FCC5A@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20231002135125.2602895-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20231002135125.2602895-1-andriy.shevchenko@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|BN8PR04MB6402:EE_
x-ms-office365-filtering-correlation-id: 99f5fb23-85d8-4562-6b54-08dbc3778cd8
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: O3kFBXy0AwVMUUHUtYj3lyMurVUw3xgzV0z5WZrZ0kiJwu9QfIt//QymnSsjb76EBTaI9wQDSFsMCSnLUyOCMozb9xYX1WXa5lditMH4Nvn+cCj2nWiR/1WzDiIvwQ4BOtTrBe1isaRVCURO4ytn6JMjBUoqgd6Zf99cGJhm6G6aI5DrpAAvxWZCw4DHdCrTJRcFt0huYMeRzIdY3/MUxDJiXN07s/TWtuIxQzKW5aM2SaFZXf249xvAqTC+LEQm8sQk9vKRpABAEki+m9vppKmLIOUFRntyPphCjlKfyncmKyjWZEuqU3EISE8mxvVRf57+QQNWsXYxcZvmgGjvPUIMjWLA0XMwW58lxRPqZ8B2aeKfLPAxSDrAyuSG/VL1hOEg4etNnBtbmDrg5IFfmvBHMuxg0i4y6q4af9K3V1Pugv3aLL0RhKmb2A7pULSQ1L8fiSrYjRxT0TyjI7eaQV1nMyOmRgldRWoGeE9Z1SyAH2dOfYMDJ9mo7XtMHTzljOtfcsVkzn58Sb+kB7ydpWSYaHyEulWshGfFHref4jqxgEczBCxZPS6ynkI14cCd1eT2OyxZ8F89ZOVxt55izb6klb/SfG/t1B/VZLQOb0hSJGZXrDCdofzdKdO7ZM8g
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(376002)(346002)(366004)(39860400002)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(55016003)(66446008)(2906002)(38070700005)(122000001)(82960400001)(38100700002)(66556008)(9686003)(76116006)(66946007)(4326008)(71200400001)(6506007)(7696005)(66476007)(52536014)(5660300002)(26005)(316002)(8676002)(41300700001)(64756008)(478600001)(8936002)(110136005)(33656002)(86362001)(558084003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?h8zDrdNSmFaFSa2evY7Zp7fOQV4Ih8lBWFKdoqcFeyrrx6bFK7n2KtWXhd02?=
 =?us-ascii?Q?IXJ6ikTaCQQKnOwZvg2Qkc6rtJC7+XEx2VrpP/FQ660B7BLwRXndBBm0mWAY?=
 =?us-ascii?Q?Hj4/buPvuKTaBKkx94/7FjBt3FXTAoG8a/9+nHeMyovDX21uM2UQkCZT9GC5?=
 =?us-ascii?Q?dny9HG85c461agpf9A0m1bYMDtU25aL204Ibc6yO514aYXE3r9JPBGmLPSk7?=
 =?us-ascii?Q?AOywWxNJqN7YEg0Ks4TUMnrZE8obZQ1hgtkA3lcOl94C8Qp0OOeiylhPxSbz?=
 =?us-ascii?Q?vpHGP8DkzP1u0e+dxyvbP8jn3KN7h8aA6M0OB0aXQEcUEON/YL38tuo1lsJj?=
 =?us-ascii?Q?bxFSvcyhheSWQLObpUnfVSXg7KqgOVVyiZynAHHDFTNZ+44Mll9b9Bn6JwWW?=
 =?us-ascii?Q?N/YYUChZz+z+BMfGsgX7bvXC0Kyt5gyyZ5QcFMnsGyTbCjWDDEMK/HH6BuI8?=
 =?us-ascii?Q?woJP3fQcckiL3Lq54du5nxWZdkaytaXdjj2HEEVcAseQOX11aPf+8p2f8e3U?=
 =?us-ascii?Q?FebMV/5taTheb/r8tzg49BfVraQYQ9aSvYBMHl+nywTscIDQeoflawh4SY68?=
 =?us-ascii?Q?ILAE4l44x+6vu4z0yWnjeo1b/puTIg57GCLQaJ3qRDuE89CrNOOVEiKp3dyA?=
 =?us-ascii?Q?9/QKzjmMLrOFmo05jk0JnXzkvteBJPUXZzknimK6pCkUEWiQOhgD6sQCBouP?=
 =?us-ascii?Q?qm20CiukAnbcNrd1gMaBP3R2hx88KbNOuPIElnFHbtOfCzlVn0DpkJ0kLv3T?=
 =?us-ascii?Q?te2dNt6WqDbV02teaT/pGsrgUkpto//SRId2N9Zzn6bOVwSnXB4q5xbsQmDu?=
 =?us-ascii?Q?qZ3FkxaymKtdyfkLplk6m/Ih0i+rSLU4Du8F2D4atUQ6MM05wfEFlF0LKcAA?=
 =?us-ascii?Q?Yta78G6+wpGzRxe9ACuVsLuqFS4ulv57vJYddq0OcdAJcN81XSpO6Go9WSWH?=
 =?us-ascii?Q?a80s48uzRNPSTFvgUi3oszOgVgFhOlB4IWEHid+BqASn00xq8qFHVKCg2ZGC?=
 =?us-ascii?Q?YPAIKlK5FugUGAIdw5QU22UlB9n27duHvZADdbyVUlzFWYrD8anhh6w+wv5H?=
 =?us-ascii?Q?5pHpP/mhTD8VuqKP32SxUhasgs1oHNy6sk8GGfYnxpCsUpkZqp1GVXbMl04i?=
 =?us-ascii?Q?Y42KAI9yG5rscmpjv3jQPa+1YgTZOfbLPGlTJZD8imxrHAr/iML0fvWXpcbM?=
 =?us-ascii?Q?xkmeE63OLDaIjt7ZDUuWcfly+CrAQW3UBRBhneHGm5ZK4cu8vgbhowjDn/0s?=
 =?us-ascii?Q?VlUy10+gIuC3xrKPWbVtxS5gVszFN7BmADsd9TKZZJUmFZHrMwGj3HIcs6Nz?=
 =?us-ascii?Q?IOvdxsIbayapWKcydwxB3tE+Gy6FsbXW3fgNFx+ZYUwSsp0xE+Pk9rpmtkVH?=
 =?us-ascii?Q?uiP6JJSG5Fz4kJfhY2eod3FSbSMQkrM0ztQoSY6yrVTIbdxNvQXNFFaDAzN+?=
 =?us-ascii?Q?QRvAi9Cn31lCEGtdDvwDtZpV3jwKWvdBJX1lGVHLdXrKXT+OwVCL9x3/KbHD?=
 =?us-ascii?Q?b5CvlRMwiLRRRshiatbi1xSYW8+hoqoxpTRZR0jaJYCxX7vk0eLHsuqjuVrd?=
 =?us-ascii?Q?xet28DZn4cDsvBfMzZWbBakOhVa6IETcbpzyjBLm?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 9GwUjQbTtnyHS1k0itifaIOswaWKgevFBZZx/VYSMdiPMHWxDGIhO9bvkOpdWVkzX0KCZX6S3uZntM9yKZenbmnWMbMopXESQf93OAWE5D5EycYQuC/IR8ns+gwAYDW2xT3D3YFfjxXtEc2NDBxRO9CiUQdx59tDAMxMFZG6+5YQ2vfK2KpV528lK8Ty57x26nicQ2dHSrCnA5sSawpwB3rNqH38YNHCKZi/8QwLCPJ8ZGHFUd/aXcrIBzj/nljiK7l4adK6FJroYixuJZFtShIFuIitwjMgrCHqhTPUEhLHPIC5qXJpvmuz7RPZvZ0iTFYHv6BnlHnl+JqtURvD/ji6dMGnlIFiAZNhKxk5JEasNEOBvuto1iqkvQt5nkdhm723v8LVpMeKLLhjQzckTZB7+oMfF3IfcbpXy9/TlcgShbGHjD3bFLeLVqtYjBxmW67buMhh3yJsMvpw+wiOqehQPw+46f1d6Pv15Q7kh2ET8AWAS0L7OwsWzhkKR/jg9KgjA6Z99hYwxGCDUwxqBzItEREsslw5hDFpGubNaJF5f9Ia/ggpU2cPEGEFTpcMqwc6Dv8ex5r9YXMp5bKOwmuZnog9NeoBNSd/jnmlnVGbRaGrpXx9mqlZzlnY8PHecIfg3gFP4ifDkSKx3jbRsIU5wEffwBsDqhEA9iZXD90Rl3meuc1EcKlgYK46xeU6p6nsxZBbr1q3F4QcNTGgkG94iyi3/1wu5vVu5dOq8t6RBb832vEtTlYpBawypQ4uX9qIJaJGRiGuQnX/YlmpLD2PDvRc6NC+YHztjU1MynWH1nHwje3oVSGkTysNIs4T2dPrb4sjI3tfKZrEgODSHaDIO4AR8c1ext7Iu/qF196R2KkxiLUN1tcSXZ82Qmulj/4w51aZ5HDLkbX+f2Q0N1XO2gJfH12VdkuwRTbSrx4=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99f5fb23-85d8-4562-6b54-08dbc3778cd8
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2023 18:44:03.4148
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9zgeosd7ZLs5NLnPTaK+PS3ere9CRJImZRRoAmrgWgAl/dSy6IB+NMPJzJ8GbQbBGfvzqwIsJBQAv5JT/YYzUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB6402
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The acpi_evaluate_dsm_typed() provides a way to check the type of the
> object evaluated by _DSM call. Use it instead of open coded variant.
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Avri Altman <avri.altman@wdc.com>
