Return-Path: <linux-kernel+bounces-133906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F65E89AA96
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 13:22:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A93728213E
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 11:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FF902C6AE;
	Sat,  6 Apr 2024 11:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="b8rcJjFk";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="emQd3feV"
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D5A2561F;
	Sat,  6 Apr 2024 11:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712402547; cv=fail; b=A2R7XBHfVnk3BjFWKLfub/rCsZLb42U3WU3arH3kpvoFYj63j7NEOBbQcB51w9hHZOWTXY1maYSP8M0T5QdrXmo28kU9/QLIdkZnuUfvnzX+hH5iDIw3A2x2ChqcSJbdI39g901M4HCzgUO2p5BK8YZQLEjOnYTw44h5mI5zYxA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712402547; c=relaxed/simple;
	bh=t7F3Kduu/Ge7g2G6kcjQQGFtfSUV/Q/edJSQ2Xyn7mc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KKgVZcd4Q5yc1rz9R52uAPMYG5UPlHJcwlTQMsJkOdRYqoRakyZZ4MOfcOofg+PWX+lmaNtlGfeojwcXgaUAGN/oOepPK02dLvu7IPcGFfNlT6kBjiMFfgzImBkLjQF0ygctwbrLnvzgtqZJ0LEEELPb8w3PfSXVs7ppYJ3g+qU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=b8rcJjFk; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=emQd3feV; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1712402544; x=1743938544;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=t7F3Kduu/Ge7g2G6kcjQQGFtfSUV/Q/edJSQ2Xyn7mc=;
  b=b8rcJjFkQTspAe9C9DiQjFcGOMVy83TTvECQHYh6gVajWNyIWs/F3dvC
   aO+i5wv0UYovOSTpfBfV9tKZmUdR49FdfBp/A7cZCT+ZtPapfvDVayBWj
   T7ssV2adEz2SYtPk7gSbTtLVloB2PaIaYXnIZKGgDKbXC4mBpKe3ZL8+N
   PwFpcXL0pWSdU8W4ggGNeoHpZST5/RpGJaJilJEiO64y3+4RDXdWMwPD8
   vtYkkUtNQVFmi1lUFOTvseOaVJXuJWrs+lSmbeZYIx/GIPiN3rnq1CVWH
   +rWi18SBCDdExO4XzuMgQUB5juNXaFpRn4VD+mfOI7PbYsyYWtPMQKLzP
   g==;
X-CSE-ConnectionGUID: emfxd178Qza9aiwZ2ho/vw==
X-CSE-MsgGUID: /pDGcQ1DTz+9kCaZcZe5fQ==
X-IronPort-AV: E=Sophos;i="6.07,183,1708358400"; 
   d="scan'208";a="13400240"
Received: from mail-dm3nam02lp2041.outbound.protection.outlook.com (HELO NAM02-DM3-obe.outbound.protection.outlook.com) ([104.47.56.41])
  by ob1.hgst.iphmx.com with ESMTP; 06 Apr 2024 19:22:16 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AduLoesteLQvYw246+hctS+gZrfkv9+jMsdacQbXuzUhwyWPQcBBM6qh+nvjXRv0z8i2lrkLHOWkfoV+cH5XRPwFIjXIJr4/aT4EXIYf2G21AXVbQvqwrOBepiJJNWXh8kmcykvnJxe9QtGqEud/k9BxSgL/c9MxZ3v+yZ7AMf+W8CQzKYrQK9FNn3CEnt7m3zZJX+C8oILBZyXgpAbX7frIYeo2BSSqB32pN8wnbZ7QceBpqXJpy/DSM9dR/7GudvC5KrGpmpvVaD01uEixw7ZJaYQH0W+cNrJTn0DVFSdu7BMgOJsysHQLVbjypGBeRyr7vXetr/z1av2R68NUUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xOeRAqf5PVqSjo3WeY8lEr+4DLgugyD1SkoWalFiK9A=;
 b=IbhlqWDgnjZnYyyxFuJhDH7MuLWnZ8gNCcl9rkN/wTC+fmtSOoAXjRPoovTPkUkMgYy6/KlKYKftrW/GxppcAJTp+Y9aYqsNxpu+tJSC5rOexLYqC2wcWDJUvX+N4ci6QshROSYlaNfvrj27Kb4qqfxVM0pFClPWhGDvhaKCywgEiwDpCiOQkwVGiTaZ4NSYlmwKeoiHvj03q0D+7NaEHEyOkbMzA5zwRZFjxXsZoVniO0jjETHuAyD4wab/LlXjafWL4dql7NYYWsiB3L2KQJ/cUIU5oYbZ2elwFEV2qrDSMrRS0yaHPfmZu6wjrmCQ/8njgnCVEnEdvwYxagzssA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xOeRAqf5PVqSjo3WeY8lEr+4DLgugyD1SkoWalFiK9A=;
 b=emQd3feVJUzEo+hDiFt8LkjsOD8LEghDNmq9BLooRKYEoml74VnIjPWGF8BXvBuDQnDTbxBO8Z79RT6mtgz63ui8AVZH8cU2T6BZEup82g9HtyIcxUzb3ZtSHClcaZHQ/N68WqTPBnGbjpQBwkvblpLtVJxk+7EizXpPGhKT+go=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 SJ0PR04MB7837.namprd04.prod.outlook.com (2603:10b6:a03:301::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Sat, 6 Apr
 2024 11:22:15 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5395:f1:f080:8605]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5395:f1:f080:8605%3]) with mapi id 15.20.7409.042; Sat, 6 Apr 2024
 11:22:15 +0000
From: Avri Altman <Avri.Altman@wdc.com>
To: Jens Wiklander <jens.wiklander@linaro.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>, "op-tee@lists.trustedfirmware.org"
	<op-tee@lists.trustedfirmware.org>
CC: Shyam Saini <shyamsaini@linux.microsoft.com>, Ulf Hansson
	<ulf.hansson@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Jerome
 Forissier <jerome.forissier@linaro.org>, Sumit Garg <sumit.garg@linaro.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Bart Van Assche
	<bvanassche@acm.org>, Randy Dunlap <rdunlap@infradead.org>, Ard Biesheuvel
	<ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Tomas Winkler <tomas.winkler@intel.com>,
	Alexander Usyskin <alexander.usyskin@intel.com>
Subject: RE: [PATCH v4 2/3] mmc: block: register RPMB partition with the RPMB
 subsystem
Thread-Topic: [PATCH v4 2/3] mmc: block: register RPMB partition with the RPMB
 subsystem
Thread-Index: AQHah0/rlyon6MkfkEm8kUoKUDvm4LFa/LPw
Date: Sat, 6 Apr 2024 11:22:14 +0000
Message-ID:
 <DM6PR04MB657580885C16AE4F5743357EFC022@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20240405115318.904143-1-jens.wiklander@linaro.org>
 <20240405115318.904143-3-jens.wiklander@linaro.org>
In-Reply-To: <20240405115318.904143-3-jens.wiklander@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|SJ0PR04MB7837:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 uMlzgMDzFUV2eDotAbdgHZ+Z+5lHIR7RlyK5JQATFpbjVn/Ye4+1EHStIWTLtrhGgu2qmr+gqEGfNIBAAhaanWsTRg5qMBDDebfEAC9k0Y30qrFPc3jvlRbhT97XmaaiarZQqYlKtbXVcQTvrokMj5uM9J74ZHXLQDaltHLDdbppD+hrx+k0WIOuEWqWdmLP9Fa9ZO6i308Ok5Od3Sy0GyzlV/qfw7Mhup9UR9+5mZXGw1Ov6CwIdMjNRi3cpL47dEEmmveaQnpuwS58RCicgf0noYd1aeZxOe+PFATW2pGr/+l0UIUp9NDz+aiSuc1GoGvzO4m97z4JILy0Pjqqe1z3miAziG9IVjvx14nXqfwCuvZYzWFM2u7+njCuY+DkV3oLCvcxKxT27PBGWwvVchJqQSHAY40QRREOIjpcC7N9/da7QAjHsZ6T7PRVMHoHT2lE4EVZY8zjUdmOC0C0bQS7n1LqjzCoKn9OnvNeH5BtF1DfP8r9ZGcQC93wEPHyjE3f/K4PvUhaMUvmgchTM6tAVyohr57Chb0BBoebZYi5pNr/qxBUTIqAtCVZroKPF5rWa9e72QoxWmLHcqJCfXcNRbYPsdgx8AHQAYbSnKan4J6SMQuwJy7K6Uakmj8CCEtQ8jloswrB1Aw9nS/JMqSSgr4khjoNRPOYoY3UsWw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?AHNHkvuE41nFQdlvQt6UHhyIl+v7gpTXd2R11MkZdejip8pz1TNwciyaM+Py?=
 =?us-ascii?Q?gxLVq2qG6iM8dZhFFWxzj6MGTnrxilmdPo5fNeOypNLlKItQwnTKO9/JbUt2?=
 =?us-ascii?Q?vTvfkWxMHrMJ53qepMgj9pcPP4C2HHhR1j2xV/BGYX4zuG8mmFM97ptNA/0Y?=
 =?us-ascii?Q?PiHOQvGk/XeH2T52eVFmrANdfyvxA/40KLo7he6EkgwOZBB4hYwDAnEvVk4m?=
 =?us-ascii?Q?LG3pJbpJy6gr3ktkyOKppXB2ifE7cKbrYigV5XNPEJMBWvsZgMh0ARXPkhv3?=
 =?us-ascii?Q?hsze6TUNDn5aFHJ8GffV4Xn57a5Vsf+38+z+hc8tlaRbLnaQEToukE8eONZI?=
 =?us-ascii?Q?8itmi/X8LZooCoeb+/ynuih1qraZDfO0rzCsY+WB4FppmWWk0g9zY9IjsNf2?=
 =?us-ascii?Q?iIrBzVl12J3Mh3Df33bs5YjfrxPKZ+URK0qITWjLj35ONz2vgdofs6cj//yt?=
 =?us-ascii?Q?47rmUZJgTuXa+FVPRABuJTVAoYP2o/4iaK5QKrh4r9wkgfKqye5bdl0LdkZ3?=
 =?us-ascii?Q?nK5tMrUI6zrjvEmhaGecQuLEQV7IoSv4XVGUoTRGo6y+U8mp6fPpNoVLJ1n3?=
 =?us-ascii?Q?WPXcqWjHizRMJgbSoXKsSGR/QV7oQ8GcEyscD+ZNyCVieDUbQ7g/VN5QGk7e?=
 =?us-ascii?Q?n317JN3hpFDzsbi0FQhOr6ZF3fvMSLtVgCnhwUmDk/KsqVu/hhOS1nj1kwjD?=
 =?us-ascii?Q?A7a4oZkii02QrEBCWaZvXK22Ed+pyS6vYR73CMjM3ubRfYqnYIqeKMWbWp62?=
 =?us-ascii?Q?czbpvgAp6RxNG4vd37PM+DHKFPnYjKqhAFDGIXyu6VSj+q3k5yE3jlfEF3/p?=
 =?us-ascii?Q?4tPbtdmZUPLvlmwAWWx4mQNtGaBgP4N8T4859KLzgCCKmgfRjhhZlv6oMPsj?=
 =?us-ascii?Q?gAduKIVFQZkAxFQRrgl7BJBYyKmTPWFCJlgXnenivTtumYf7GgXvOgNvo8Mh?=
 =?us-ascii?Q?+DoejdUXeIqHzku/Oez5SbrW8P1Qgo2FYz5ZeoahMY8dDF1SnjuvQp9W5USU?=
 =?us-ascii?Q?EAm39sUtFOlhTvxQdlN++vXkrGecR/mTUI+nUnbd9m/2lrSdzjVMQQXwGVoe?=
 =?us-ascii?Q?BFSAFxh+PVk3f7m+wuvcEwrXY6nndLczKf80J5/AdxIGBC70JZfqyd7yMLUL?=
 =?us-ascii?Q?Z5dVoDLZ7Jz4oy1gsYgNwh4pavj+NzUSp+TQCsAhOpULYuuQW/GQO2Inr21u?=
 =?us-ascii?Q?j8HPjqSVHn7rWuLR0Pocw7Mlxnmo2KPcNQQOLkDKjMnsPn+d3Jj01UHGEP3G?=
 =?us-ascii?Q?yW7owB8IBGNvWWiOJBHZaXEOz91dl06ZGq9z7v9O/NUxop7UbbV1ZuPvhndv?=
 =?us-ascii?Q?D8NSSqcqvLlMr6DzfIAsFTOPhI6Uo4Yj1DL4n9aLlBSQeU7cz07fYbrbyJr5?=
 =?us-ascii?Q?xJ9cM3a6okfFRFmcD1ZNdpBVim1aGLT47N3RhMMhPU9+zEt6r9J4iqFT3XVh?=
 =?us-ascii?Q?MlVCPMkIyDv2c9B005aIwdwLn0FihFWnq4dYEZImtpE31uon+7h5pZl/o6vU?=
 =?us-ascii?Q?KoQBBrKc4tYtQO6Ni+VO+fX+S1Mrr6hDlvHJ1UF2Iq4bEikpZp0s5G/5XgcP?=
 =?us-ascii?Q?gf8zkGCQRn6BQQnr+220NTpmO8Bm7rFX40fO+Yiw?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	fYLE3inyq2vJMhKv0O1E0/n7moz8Hi2yvk+SmSEYQf9NvLALzM5ChV31EiyW+FULwIAeoSovIksX5w7wwLndZQm7iV6cNonlyjGsK8nZHJDLXQmvVfQlWUPV3f6WlFDhe6zwWdViF5RIK4pEVdzUVBqlQF8YoS4JaySo190RFBKjy8EJ0v+Fxey/N9d8nn2SApuCUM5gqd7XDrP//kIwTV135nhFJ+1BEG3duOUORhRk3JBJRoIZDnxS67eTt7n+Nn1yl2Alfx1VtTMGAQgH3p6RO9j4fBe/QT4wLg5lQPTkwC7iEBRL4tp8VyId99mZL+8dQadpi+tFRjpNf2gj2Rh6MbciiuMxGAsZKEPB3Kn6lmrsw1pCAkGdxeJ2JACLJI0JVkjY/d5kFbXrVzK+c2JkPZL8SgTXpnHu4OTANqXxtF3eYekPYsKn/1Ym5mqppBl919HLqTGqcFh9lRZXUTWcuWZLG4VgzUxgxMU9HDfn9QmyMmW7KdmbvaO8T/aqU5FgCZqh7P9vlvbmKkNC3owMNDPFzdQut2A8i1vJ6UjGmzbKTmlLDJkExfi9JRnwrnL75+GZXzhdhp/qYbmW3XT3s9+N+7YzRTMvh9wYoMKZkSTuZPRmL2peOdBs64RZ
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7b7e4c1-dc0b-434d-cf76-08dc562bcfd9
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2024 11:22:14.9966
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2prCrWW2+cfwycmEv4uyoO6IumPFKcGdIGyPcb/So/jnWFQV9Vy7/kqwvSxs9TsazH6ClxhQM0EZpxJEYH9pZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7837


> +
> +#define RPMB_PROGRAM_KEY       0x1    /* Program RPMB Authentication
You expect the key to be already programmed - so you don't really need this=
 operation?

> Key */
> +#define RPMB_GET_WRITE_COUNTER 0x2    /* Read RPMB write counter */
> +#define RPMB_WRITE_DATA        0x3    /* Write data to RPMB partition */
> +#define RPMB_READ_DATA         0x4    /* Read data from RPMB partition *=
/
> +#define RPMB_RESULT_READ       0x5    /* Read result request  (Internal)=
 */
> +
>  static DEFINE_MUTEX(block_mutex);
>=20
>  /*
> @@ -163,6 +205,7 @@ struct mmc_rpmb_data {
>         int id;
>         unsigned int part_index;
>         struct mmc_blk_data *md;
> +       struct rpmb_dev *rdev;
>         struct list_head node;
>  };
>=20
> @@ -2672,7 +2715,6 @@ static int mmc_rpmb_chrdev_open(struct inode
> *inode, struct file *filp)
>=20
>         get_device(&rpmb->dev);
>         filp->private_data =3D rpmb;
> -       mmc_blk_get(rpmb->md->disk);
Maybe add a comment that this has moved to mmc_blk_alloc_rpmb_part?
For those who will look for it.

>=20
>         return nonseekable_open(inode, filp);  } @@ -2682,7 +2724,6 @@ st=
atic
> int mmc_rpmb_chrdev_release(struct inode *inode, struct file *filp)
>         struct mmc_rpmb_data *rpmb =3D container_of(inode->i_cdev,
>                                                   struct mmc_rpmb_data, c=
hrdev);
>=20
> -       mmc_blk_put(rpmb->md);
Ditto.

>         put_device(&rpmb->dev);
>=20
>         return 0;
> @@ -2703,10 +2744,157 @@ static void mmc_blk_rpmb_device_release(struct
> device *dev)  {
>         struct mmc_rpmb_data *rpmb =3D dev_get_drvdata(dev);
>=20
> +       rpmb_dev_unregister(rpmb->rdev);
> +       mmc_blk_put(rpmb->md);
>         ida_simple_remove(&mmc_rpmb_ida, rpmb->id);
>         kfree(rpmb);
>  }
>=20
> +static void free_idata(struct mmc_blk_ioc_data **idata, unsigned int
> +cmd_count) {
> +       unsigned int n;
> +
> +       for (n =3D 0; n < cmd_count; n++)
> +               kfree(idata[n]);
> +       kfree(idata);
> +}
> +
> +static struct mmc_blk_ioc_data **alloc_idata(struct mmc_rpmb_data *rpmb,
> +                                            unsigned int cmd_count) {
> +       struct mmc_blk_ioc_data **idata;
> +       unsigned int n;
> +
> +       idata =3D kcalloc(cmd_count, sizeof(*idata), GFP_KERNEL);
> +       if (!idata)
> +               return NULL;
> +
> +       for (n =3D 0; n < cmd_count; n++) {
> +               idata[n] =3D kcalloc(1, sizeof(**idata), GFP_KERNEL);
> +               if (!idata[n]) {
> +                       free_idata(idata, n);
> +                       return NULL;
> +               }
> +               idata[n]->rpmb =3D rpmb;
> +       }
> +
> +       return idata;
> +}
> +
> +static void set_idata(struct mmc_blk_ioc_data *idata, u32 opcode,
> +                     int write_flag, u8 *buf, unsigned int buf_bytes) {
> +       idata->ic.opcode =3D opcode;
> +       idata->ic.flags =3D MMC_RSP_R1 | MMC_CMD_ADTC;
> +       idata->ic.write_flag =3D write_flag;
> +       idata->ic.blksz =3D sizeof(struct rpmb_frame);
blksz =3D 512, so maybe add a compile-time check on sizeof(struct rpmb_fram=
e)?=20

> +       idata->ic.blocks =3D buf_bytes /  idata->ic.blksz;
> +       idata->buf =3D buf;
> +       idata->buf_bytes =3D buf_bytes;
> +}
> +
> +static int mmc_route_rpmb_frames(struct device *dev, u8 *req,
> +                                unsigned int req_len, u8 *resp,
> +                                unsigned int resp_len) {
> +       struct rpmb_frame *frm =3D (struct rpmb_frame *)req;
> +       struct mmc_rpmb_data *rpmb =3D dev_get_drvdata(dev);
> +       struct mmc_blk_data *md =3D rpmb->md;
> +       struct mmc_blk_ioc_data **idata;
> +       unsigned int cmd_count;
> +       struct request *rq;
> +       u16 req_type;
> +       bool write;
> +       int ret;
> +
> +       if (IS_ERR(md->queue.card))
> +               return PTR_ERR(md->queue.card);
> +
> +       if (req_len < sizeof(*frm))
> +               return -EINVAL;
> +
> +       req_type =3D be16_to_cpu(frm->req_resp);
> +       switch (req_type) {
> +       case RPMB_PROGRAM_KEY:
> +               if (req_len !=3D sizeof(struct rpmb_frame) ||
> +                   resp_len !=3D sizeof(struct rpmb_frame))
> +                       return -EINVAL;
> +               write =3D true;
> +               break;
> +       case RPMB_GET_WRITE_COUNTER:
> +               if (req_len !=3D sizeof(struct rpmb_frame) ||
> +                   resp_len !=3D sizeof(struct rpmb_frame))
> +                       return -EINVAL;
> +               write =3D false;
> +               break;
> +       case RPMB_WRITE_DATA:
> +               if (req_len % sizeof(struct rpmb_frame) ||
> +                   resp_len !=3D sizeof(struct rpmb_frame))
> +                       return -EINVAL;
> +               write =3D true;
> +               break;
> +       case RPMB_READ_DATA:
> +               if (req_len !=3D sizeof(struct rpmb_frame) ||
> +                   resp_len % sizeof(struct rpmb_frame))
> +                       return -EINVAL;
> +               write =3D false;
> +               break;
> +       default:
> +               return -EINVAL;
> +       }
Looks like the above input validation section can be reduced to is RPMB_WRI=
TE_DATA and default?

> +
> +       if (write)
> +               cmd_count =3D 3;
> +       else
> +               cmd_count =3D 2;
> +
> +       idata =3D alloc_idata(rpmb, cmd_count);
> +       if (!idata)
> +               return -ENOMEM;
> +
> +       if (write) {
> +               struct rpmb_frame *frm =3D (struct rpmb_frame *)resp;
> +
> +               /* Send write request frame(s) */
> +               set_idata(idata[0], MMC_WRITE_MULTIPLE_BLOCK,
> +                         1 | MMC_CMD23_ARG_REL_WR, req, req_len);
> +
> +               /* Send result request frame */
> +               memset(frm, 0, sizeof(*frm));
> +               frm->req_resp =3D cpu_to_be16(RPMB_RESULT_READ);
> +               set_idata(idata[1], MMC_WRITE_MULTIPLE_BLOCK, 1, resp,
> +                         resp_len);
> +
> +               /* Read response frame */
> +               set_idata(idata[2], MMC_READ_MULTIPLE_BLOCK, 0, resp,
> resp_len);
It is confusing to me that your response is holding 2 frame types:
The status frame and the response frame.


> +       } else {
> +               /* Send write request frame(s) */
> +               set_idata(idata[0], MMC_WRITE_MULTIPLE_BLOCK, 1, req,
> + req_len);
> +
> +               /* Read response frame */
> +               set_idata(idata[1], MMC_READ_MULTIPLE_BLOCK, 0, resp,
> resp_len);
> +       }
> +
> +       rq =3D blk_mq_alloc_request(md->queue.queue, REQ_OP_DRV_OUT, 0);
> +       if (IS_ERR(rq)) {
> +               ret =3D PTR_ERR(rq);
> +               goto out;
> +       }
> +
> +       req_to_mmc_queue_req(rq)->drv_op =3D MMC_DRV_OP_IOCTL_RPMB;
> +       req_to_mmc_queue_req(rq)->drv_op_result =3D -EIO;
> +       req_to_mmc_queue_req(rq)->drv_op_data =3D idata;
> +       req_to_mmc_queue_req(rq)->ioc_count =3D cmd_count;
Maybe have an additional struct mmc_queue_req *mq_rq =3D req_to_mmc_queue_r=
eq(rq);

> +       blk_execute_rq(rq, false);
> +       ret =3D req_to_mmc_queue_req(rq)->drv_op_result;
> +
> +       blk_mq_free_request(rq);
> +
> +out:
> +       free_idata(idata, cmd_count);
> +       return ret;
> +}
> +
>  static int mmc_blk_alloc_rpmb_part(struct mmc_card *card,
>                                    struct mmc_blk_data *md,
>                                    unsigned int part_index, @@ -2741,6 +2=
929,7 @@ static
> int mmc_blk_alloc_rpmb_part(struct mmc_card *card,
>         rpmb->dev.release =3D mmc_blk_rpmb_device_release;
>         device_initialize(&rpmb->dev);
>         dev_set_drvdata(&rpmb->dev, rpmb);
> +       mmc_blk_get(md->disk);
>         rpmb->md =3D md;
>=20
>         cdev_init(&rpmb->chrdev, &mmc_rpmb_fileops); @@ -3002,6 +3191,41
> @@ static void mmc_blk_remove_debugfs(struct mmc_card *card,
>=20
>  #endif /* CONFIG_DEBUG_FS */
>=20
> +static void mmc_blk_rpmb_add(struct mmc_card *card) {
> +       struct mmc_blk_data *md =3D dev_get_drvdata(&card->dev);
> +       struct mmc_rpmb_data *rpmb;
> +       struct rpmb_dev *rdev;
> +       unsigned int n;
> +       u32 cid[4];
> +       struct rpmb_descr descr =3D {
> +               .type =3D RPMB_TYPE_EMMC,
> +               .route_frames =3D mmc_route_rpmb_frames,
> +               .reliable_wr_count =3D card->ext_csd.raw_rpmb_size_mult,
> +               .capacity =3D card->ext_csd.rel_sectors,
The capacity is RPMB_SIZE_MULT and also limited to 16MB?
And you also need the region size you are writing to.
If I get your intention regarding reliable_wr_count, AFAIK, rpmb can be wri=
tten either as a single, double, or 32 frames.
And this should be induced from card->ext_csd.rel_param, and not card->ext_=
csd.rel_sectors.

> +               .dev_id =3D (void *)cid,
> +               .dev_id_len =3D sizeof(cid),
> +       };
> +
> +       /*
> +        * Provice CID as an octet array. The CID needs to be interpreted
> +        * when used as input to derive the RPMB key since some fields
> +        * will change due to firmware updates.
> +        */
Not sure how the CID register is related to RPMB?
Is this something internal to TEE?

> +       for (n =3D 0; n < 4; n++)
> +               cid[n] =3D be32_to_cpu(card->raw_cid[n]);
> +
> +       list_for_each_entry(rpmb, &md->rpmbs, node) {
> +               rdev =3D rpmb_dev_register(&rpmb->dev, &descr);
> +               if (IS_ERR(rdev)) {
> +                       pr_warn("%s: could not register RPMB device\n",
> +                               dev_name(&rpmb->dev));
> +                       continue;
> +               }
> +               rpmb->rdev =3D rdev;
> +       }
> +}
> +

Thanks,
Avri

