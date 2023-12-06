Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 253F08078B7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 20:36:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379363AbjLFTgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 14:36:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379274AbjLFTgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 14:36:35 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 337751BD;
        Wed,  6 Dec 2023 11:36:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1701891401; x=1733427401;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=lw4m3tZWoCjQul7waFqM4TgwGNlGq97XE+Qxa5VQJ8Q=;
  b=p879OKXZgFRmuA8Fr21yxfQJ4fYJPm7BRTLStVCKS4ssmS39ygRInZyI
   1PdoUOfHlFb/f889/Aoyq8arnw3xLf0LibFH9e2Vw3AWdnlR2bAfHaNTh
   QxsZ7s2Lk04YxmXvqr8G+ZJMampr5sgQp6lcL/ofWLLYVo5w+24W3xM6T
   Xuwp7KCrnMSMIo23ytRYfuYkYGneOpGiLeuFuKy2iNG3dabvFU3l9+1qc
   29mYJXPzJU0yhvrBQ2p5CQkIUG/QVJbJ1SAEWnVtyNe9se/rAn528ze2/
   6BdOgd4qnVC6dVLDG239ynQQbb65EQFhljCW1rfVo3XzLeT3AZEhEnhLx
   g==;
X-CSE-ConnectionGUID: gCu+TCKDSqeKtM7nkp9Oqw==
X-CSE-MsgGUID: +UUhVSuuRHmnFDvyfahLwg==
X-IronPort-AV: E=Sophos;i="6.04,256,1695657600"; 
   d="scan'208";a="4041478"
Received: from mail-bn1nam02lp2041.outbound.protection.outlook.com (HELO NAM02-BN1-obe.outbound.protection.outlook.com) ([104.47.51.41])
  by ob1.hgst.iphmx.com with ESMTP; 07 Dec 2023 03:36:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QcNNtzT/b1C8ZcFkCIFIxhsNnvKv/l77Ks1zMjo/3/sWfWsbP25d/RoBv5OGOgnVSdpiOP7RaToxpFvN0JbCFI/icZQQbx6BSQdiqzRCl4ly6ZpiUiAB8SztbllYLA7fd69YeHnKl984DmV2Y0qCLKm6BBkRE496GxZo2YD3LZBoKqH3ReSyDzdObpXd/XZH9UnxDMnZQ/VUsc4v/SBs62Mmf1iHrefDRTDyIX4P0udun8W1eyOLFMzxrxKbSuede3SPhATI/6RtDxl817pmQmLq5eyxI6Vmgmi3DfCVvdO6NRnbLH80EdVIPMbm2fpK4zG2deMt8DrftZIh2CIVxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lw4m3tZWoCjQul7waFqM4TgwGNlGq97XE+Qxa5VQJ8Q=;
 b=IdYXzQMmkXGXzDlL0+FgG3ItO5hblpTb5zhgo63XGAFSt/7+XLJ/dhQlDOx7U1BrGiRkdLuR5hHsh1qRC/gyl/Zt7xRAuGGqU9AtlJN4BjHbnufNu2DRI2u1mGfTFoJHMl/W3Kc/BV9CrVoTdKZK3IABNCGgaPZLEhYDbmZRIsxxInQMhgF5t6xMtJ2Nuvav0K3is8I+J7msyW6R65NDG63ytNm3xKZv+42P1A+n6hoqpx65OzHb2ZDvPg3Isc9Sopg8zgtM4VRAOXs4sTuqsIl+MXHbBLvQYXm38RsKE5Cvkojoaq7DcsFG1H08qDXjxsJSD6VYH9M7szmIG3o6pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lw4m3tZWoCjQul7waFqM4TgwGNlGq97XE+Qxa5VQJ8Q=;
 b=yZHzfAD89Q3gvHpxjt2P5GhQ+5tbd+KQW5G1HTuTuRUtKrNkp2wbAZpOk7srI49/uDZP4vognFyVYty+zo3Y3OjUmitNDs2a4XLrq679GrslvgGrUUut6tYkp8XiVUaz7AAxumb8jLSOh1Vrh5M4kSlP32ro2Q82iFrpWyJ2SYY=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 DM6PR04MB7019.namprd04.prod.outlook.com (2603:10b6:5:246::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7046.34; Wed, 6 Dec 2023 19:36:35 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::7d7a:2cd1:54e5:ebc4]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::7d7a:2cd1:54e5:ebc4%6]) with mapi id 15.20.7046.034; Wed, 6 Dec 2023
 19:36:35 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Bean Huo <beanhuo@iokpp.de>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "mani@kernel.org" <mani@kernel.org>,
        "quic_cang@quicinc.com" <quic_cang@quicinc.com>,
        "quic_asutoshd@quicinc.com" <quic_asutoshd@quicinc.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "thomas@t-8ch.de" <thomas@t-8ch.de>
CC:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mikebi@micron.com" <mikebi@micron.com>,
        "lporzio@micron.com" <lporzio@micron.com>
Subject: RE: [PATCH v3 1/3] scsi: ufs: core: Add ufshcd_is_ufs_dev_busy()
Thread-Topic: [PATCH v3 1/3] scsi: ufs: core: Add ufshcd_is_ufs_dev_busy()
Thread-Index: AQHaJTkGejfbpfVnekmuyXhz+odsM7CcrHDA
Date:   Wed, 6 Dec 2023 19:36:35 +0000
Message-ID: <DM6PR04MB6575DEAB9D4937C9126819D7FC84A@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20231202160227.766529-1-beanhuo@iokpp.de>
 <20231202160227.766529-2-beanhuo@iokpp.de>
In-Reply-To: <20231202160227.766529-2-beanhuo@iokpp.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|DM6PR04MB7019:EE_
x-ms-office365-filtering-correlation-id: 1726d969-13d2-4f45-4af8-08dbf692a846
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eUZESwwGOzK+K9F1VMao0fLx4CT7lE/3c/b94MK5NcGeprzzExSU2i1fUuuXCA8+9YoNYCx5+2hIvdd/JIrHEublvnuTmgNQIEsdePTXbFCvwzSd5wwMCqRsluYnhWQirbNaWTht5d0X4GqJD8e6AIUA+0bgqC4n8Zdc45+TlkEjZqZpoAkTjyKPXmkw0Ev7jpVwQRywke2B9zYPW/9lo2CVVS3WwY04GtmgJj4eGuJ42p8+kwNIrPWF3BtbnXqMJLp3HKr2e/xxdkt8uvJifql3W+/9UGhGaMmDJhQbe9WFoHnQrw6xu68ooZwkTKZpPUYVSYUknoRB3oQvXX7Zc0QGcuIxUHOO751cOyYPuiyZ38Q2yXELCXWRT3OZXgrXThPDHnUpZCJJnu02RqNIorqvTPjfxbtfiJkVDp/TC3uWRa4bgd7nx0v0LwXuNNbdZiUNlvqteKdi1Bll9AE+0HhE/CN+7y/wxxBBgLwYVKUsNvqfg4MG0acBN6TcvtRMhmlY25dOZz5rfGGaXTu9eOaRDrXqL1TjJa8QMmaQLvT1BpePyaAr++RmpQIkibP3+1RzoV+vNg/fdlk99tLoOoAC21NKqTuJXl11HyRMOmKw9okPaP4i2itbWQIxK4D5GPqDzasN3I6l1RArR3b2QQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(136003)(366004)(396003)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(9686003)(82960400001)(26005)(38100700002)(6506007)(7696005)(122000001)(55016003)(478600001)(71200400001)(76116006)(66946007)(66476007)(66556008)(66446008)(64756008)(54906003)(110136005)(316002)(8676002)(8936002)(4326008)(33656002)(2906002)(558084003)(921008)(41300700001)(38070700009)(52536014)(86362001)(7416002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EzQKARuV4VVwdCFJ+Oi2SAkdSOXUT8hJWb1UTkGhLGvWpEAkV1Rxw7k8pg1p?=
 =?us-ascii?Q?ggjOgKHqUVRke4VHYm+uE9gQhAxM7xCQUIU57JaCW04ZaFPQUzl/ZpUc+en/?=
 =?us-ascii?Q?cozg8xigv0RkzR2GJmCCIO6n3Ow2QVmAUVe+8ObEcJX6/cy6w6CXnYrVcLh4?=
 =?us-ascii?Q?1MP3bjw374ziHt/QzZQFWAv3iAGi+GQH1M89v6tR7JfjjIlF8yjtt0i3KgmS?=
 =?us-ascii?Q?P5tUvi+rs9oSZdMZk4uGWMo50bO0iw1w2iocD/ApDP98XaXkNlGDBrrD9XA4?=
 =?us-ascii?Q?5weuQ4mojLzu5M/S3qY9LAIY5T6RCzI4YJatBQkIHrD5fAGOxJ5YtsRWcLGa?=
 =?us-ascii?Q?1ickTNHfg7Y9aomkQFvdKgbyfTJmu4F48JQ8VplHpzMQvpbMC+OENRP1jrum?=
 =?us-ascii?Q?KDtfZP1uLqMH0Te49a/kreID4GLYBiANrUCMOyspiP/yzmADxQH5msYqiZDl?=
 =?us-ascii?Q?frLDsDDHc4ZDK09LEnSqom3W60GcFFd1rU5xqWGMH3P9HflV6W7NpHpwi64u?=
 =?us-ascii?Q?WDT9mWf8m+Hxt3hNIzsLUSVHHz7+Q8LCIIoYJgrJ9ycpl1wSaN8ZgB4IgIF/?=
 =?us-ascii?Q?6yPmhGHjqp8VWU9daNyvcMXzIXr8aWOgBGkceEAm5QK36wYRhn6KwrfiWp1c?=
 =?us-ascii?Q?Et1p+eyCQxEb4ees4GNWDoWuSdHYnYcUYVHYeLM5dVM+t79qYnRwJF104NhC?=
 =?us-ascii?Q?yhtz9uNUxis8DIdKvIs5KxoTUOqkse3Xc5Axsj30x1ziwRg4MMGuDriBgq96?=
 =?us-ascii?Q?YaceGlhkQzZkYkWLMgOkdExUbkArylwRCxpvNVo2arSikJdCV0Wdps9uJd8m?=
 =?us-ascii?Q?ekpej2at9M+evIs9CxOp4GmbXuUKM58L7l0MMo4WzCIBeVu+PfnBmFeYkXNe?=
 =?us-ascii?Q?ugBb4WETh7HEEGflgWCoDOrKuiIUIgtBMvI/JbLEb8gWc4mbQXav4F3Y7Qii?=
 =?us-ascii?Q?E2xcUBzKAkowiuT60yZGIg6pz9XEdzrJIaPoDXl/0C+XPW9GIBJlKSW65SBT?=
 =?us-ascii?Q?ZfeMsDvwggkGuaB0NOtTnRQIQHX1KgxVq0CSG/rpBPIcAKK1awBrVwJkfW7J?=
 =?us-ascii?Q?lx20MteuQosF7vfy3/Ies3ExiDPaL/O0Z733f4E7ZgqA84Pa+Y8FnDsm2eQE?=
 =?us-ascii?Q?gUm7F4ZXnGvpeVqIbrQqmDTr6C+lA4BMHH+OVpOSUQoom+Si6oCYqYNYxgOo?=
 =?us-ascii?Q?d6mNP3AjDKbSnL16q726oO+6Bl3JZpUz9zEZkNGdbS5nTusoXm1zXjByPbhn?=
 =?us-ascii?Q?ApYEwrLRPBZ84zgno2+CpUW2Y7kdhDnw6bwI7Yro85WaQwMKSMR9EVQNbXPG?=
 =?us-ascii?Q?/NTpJCNuyLyq1dk/iGtlrxgiOnPw00bJG1vRaRgy95vdXb+lGcwfbmeDctvM?=
 =?us-ascii?Q?e/F7mdHi+w+IGNzjPyoeU/awJVE3Vx3HRx3ieRbC8u1Flo8MM/QnqKK/ti2R?=
 =?us-ascii?Q?IxDIbgS9/f5v8AX9ZKsYWrXMgvRKRJnWZXJrDFBkFh/btvMB4n5/+o1IEOvg?=
 =?us-ascii?Q?7yq4PrwyuNYf6mEI4PvVh8JRYA5rrTq91NsDcP8te2c/MnZ/dV/Z6vVTNcFD?=
 =?us-ascii?Q?MQMbo4BPMQ+r21EPGBGFrUGWJyQhdqKnn+fPqkzQ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?2pgNjHw3cHMLeG0T871hKA71cQVI7q9zDhmNkVyEHB2Zfmmz7Ogh3v2auv6N?=
 =?us-ascii?Q?3AH5iLxkrhJClQrBXnsN1wp7HG4tKl+Ujbqgxqo7PzXTE5zR3lz18n5+N6Jn?=
 =?us-ascii?Q?bqW1+Daql7vXJu4j0WaEyqazv4j6WLmd5FTUUPb4mYTM4am9X8MtO1Fob9He?=
 =?us-ascii?Q?9RrElw9MiRTmQSjlXzKGDOZX5WKWtYhGq/scBwQ7afBlrTeSK6CybOYbDexd?=
 =?us-ascii?Q?Lp7GIa+Sk8JlfcoCeVWgd7QvTqzXCBDR5pu+g6rlQmfo8Xp5d4Yk2W9RLPwg?=
 =?us-ascii?Q?IGOvTXo6lleijaZt4QPJzAezdjK4yFV1hEvrlGaLn10ixzJ4sXTkSW6jtZCy?=
 =?us-ascii?Q?huQiMeI07K/lpN1pPkxDCww77M+3yudtdXZ4ucfGF4KnS/qFzDtk6YAfYA0C?=
 =?us-ascii?Q?uH5D0Ay9ZCp9XTv5Y/RjTEUyDbi1zBPtdC+nJWTcCQGe8yUBgUGib2J4OA3E?=
 =?us-ascii?Q?S8IPSfxvlNAa7uAU3ymyeyoINxFVZY36bqFz9KvNpCLjTxHlDfLpskTPAt6o?=
 =?us-ascii?Q?P8zD16wwI0mCkyJVKxcdPGfEi0xIagDEJ6cpcSNZoiGDZZ4lqj3MJFewlMWF?=
 =?us-ascii?Q?95idFavNngnp0bXYWuBp6ERDN4NWU1SVboab5fcZf26mya0Aq9Cq3RaAZ9Tx?=
 =?us-ascii?Q?qEezO3wa+khaqMQu1OZ3An8962OChlDXsQHD4rUSZzhROKsucDuA75Z6HRSs?=
 =?us-ascii?Q?WtWxv+bziIhcYrrX3BHpXHvODyhJ/nBOLL6U9J7RAPJ6w1VOdPEN9zyDbr3x?=
 =?us-ascii?Q?eoKNbkUAwTLZCfu/NpAt68/FAxoe6VcZTv6DXo6B6MvCjhXgcekH8VQ5vPYk?=
 =?us-ascii?Q?bHHyFfmzXBXhgA/OWCmC0V76D8ghPGFlKlsKqDPo/1LPc5H/qU7vpgeyUG1K?=
 =?us-ascii?Q?CiwsXDhm63ilrIJfuCq5VAvlDAjAhxZIoof4GLznbILKLS+0MGP7cy3sZv4S?=
 =?us-ascii?Q?QQpAIPhXEIEvj6RX0GlEsx+Ni2bzWSTsDcIlary/1K/ZC0ja7SXrskIfdP/L?=
 =?us-ascii?Q?dKdNMSUVbc2hBPWyow8LLEpPAbMO3zfKynDCD1HDrf2uT2c=3D?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1726d969-13d2-4f45-4af8-08dbf692a846
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2023 19:36:35.1434
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X9jaBupsxNeXVKJMz0VH691b27mu8l2Lc9I/vvpvl6WrItjIsMLClMZpLbxkFPKxNbCOJ4ISPk7cHTsT/NrCLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB7019
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>=20
> From: Bean Huo <beanhuo@micron.com>
>=20
> Add helper inline for retrieving whether UFS device is busy or not.
>=20
> Signed-off-by: Bean Huo <beanhuo@micron.com>
Reviewed-by: Avri Altman <avri.altman@wdc.com>
