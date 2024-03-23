Return-Path: <linux-kernel+bounces-112284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB49F8877E4
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 11:06:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 999F02828BA
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 10:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C3611078F;
	Sat, 23 Mar 2024 10:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="YVpvCF4y";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="NXYkyOxY"
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4C22C80;
	Sat, 23 Mar 2024 10:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711188391; cv=fail; b=QuDVPNPn/A35+StrGIdLQLYiVtpuPSh5Ys6MTuKhh53qkF5dHgoXF85UtEOa44T/R27xr6tN63KndgsiFSSXE5wkdED7LpGwrhv6+DG7aFkL9pLe7Uzq+AL0QSGg29DyY0QdaWOjTM/cPajcBbm0OV4CFXuAZsLhTEAjuUn4j/Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711188391; c=relaxed/simple;
	bh=HgWiz6y6nSS+t9SLD/+eqtjUeqoO5gfi9OwQEXg/K4o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FoJKrzg1mysu8YVz1OMQEgDrj/4Gg7gA6X9JPJu1jEed7YMgN0IwV6aSQ1PYN0/gqczVGLUzSx2xqgrLcs2Wr6bTdhAM4TcyFy7b07dXgBoYbfr+GR4gextrIR6KUabH7VgUoTzeSyZ/WK5hQWAfy0BfgKkOdPDQJcatD5lE2j0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=YVpvCF4y; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=NXYkyOxY; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1711188388; x=1742724388;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HgWiz6y6nSS+t9SLD/+eqtjUeqoO5gfi9OwQEXg/K4o=;
  b=YVpvCF4ygSrcUA2FU+azYensaHXgFsgaeAjwJ8OOboxRpkGqrUroCnCu
   aEYRdpj0XVPyJZsia5h8rbOHnLcLBJMvam3ud49tKmawPJW51xt+wtHh3
   Rz5dbapeWtXajYYbXHPvLVakZuQrT4p/MJUgGbmRHm3b48bW7mgcgHXmp
   jFSSJHNf956pqwCNlsnAQPXrmL9J8wfCh+a0l3rVkFBg0ZaKNE/zQg6J8
   Q+yxG3zdYAluDB4ZMLBG5vrzYeSUhNvhn8Pw/xn5lY8U1svWfSJPULEuy
   4pBLfGHqwXT2Ei8w47zzdi8Ky8/+E+8RW21uI5B5MurtMyhjjQD9ep2iQ
   g==;
X-CSE-ConnectionGUID: RMHEbqIyQeiyujAMplePVA==
X-CSE-MsgGUID: EDt6M4+zTAmX/fb/P6fwYA==
X-IronPort-AV: E=Sophos;i="6.07,148,1708358400"; 
   d="scan'208";a="12544312"
Received: from mail-bn7nam10lp2100.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.100])
  by ob1.hgst.iphmx.com with ESMTP; 23 Mar 2024 18:06:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PwJvEqZQBvduz7n99bl8ExFv8aGOzgexqaYypXzEt9d+fksS0aUJ96Rm2MQODpUzBGfQTl32Csyyuoc8zmz0hJ9P9q4V3S5TkLwiTDDRk904XyGoqBhP4bnqqmcSVYLoD1Gd324AyUOIyRSh0y/FXIDneCi3cC6Us4MuPMfgiQdqzC+zB0thFdaFZo1DN+UlgHiNcQBk2oc0X4X9VWWNuETBjT+DPLHvotjow5zZMqeZMuvk7OVlnGEKjfcvarwQCBzhY9Xwu8oYJOEprSvpf40rVt3SukaNaz90X/iZAkL9WTkyUUO959Nwj7HXrnWgMOMyswdI7wyl5tB1poNmdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s3plKZJbThHnIOlXE5JbpSB+KgMXg19Dr8bwN58O4XQ=;
 b=Nsl+87vtuffEyNOUQm9mFTomc5MB4XaKsOkKA5pbdqRRFL3tAbp+/udVSM9d6f8Jrst+8HLAS6j3o32OTn70raJk2iCD8ldlodRhr+6xPjZcQVFHoL2BjURyAJkYFZFKhTvTCDjwRIuCnSe6/L8rmg6mt6zItB9j3OCIbFhFeJRL71BHk5d6pfAY4ECP5jFyugx/mc74oMswlK4Sk/IgGXAesFyEXBCitVsu/QunY7yFldYTtVM3UakAACqlyYTUA2U6Z3BiDZLJ4u3tVyD0bLdUrHsFn/ws6PvopJMpa9duTw1oJQ74Uybq7zDio0mklD7iJNVo2AcERSTG3RRwSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s3plKZJbThHnIOlXE5JbpSB+KgMXg19Dr8bwN58O4XQ=;
 b=NXYkyOxYJjXMZP1PunuOl7GPZcbc35gmPomfGf0uD7gDK4GfiHbFgMCeSuirBwigrWR7mpIilb8P1t8bm3O/aNoghR4TR5wBB/0iwiMtq45q3lbbDKKWYBDtik7Kzy/YhViUlO2dh/09n7Sjs6WGLPN6CkfGtYlvxo4tTQ6Wt0g=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 DM6PR04MB6444.namprd04.prod.outlook.com (2603:10b6:5:1e3::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.26; Sat, 23 Mar 2024 10:06:18 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5395:f1:f080:8605]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5395:f1:f080:8605%3]) with mapi id 15.20.7409.026; Sat, 23 Mar 2024
 10:06:18 +0000
From: Avri Altman <Avri.Altman@wdc.com>
To: Avri Altman <Avri.Altman@wdc.com>, "James E . J . Bottomley"
	<jejb@linux.ibm.com>, "Martin K . Petersen" <martin.petersen@oracle.com>
CC: Bart Van Assche <bvanassche@acm.org>, Bean Huo <beanhuo@micron.com>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 0/4] Re-use device management code fragments
Thread-Topic: [PATCH v3 0/4] Re-use device management code fragments
Thread-Index: AQHacflatx7QX3r03U2kfjTRNTABIrFFLyzA
Date: Sat, 23 Mar 2024 10:06:17 +0000
Message-ID:
 <DM6PR04MB6575210C413DDBA9E5E3C7BFFC302@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20240309081104.5006-1-avri.altman@wdc.com>
In-Reply-To: <20240309081104.5006-1-avri.altman@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|DM6PR04MB6444:EE_
x-ms-office365-filtering-correlation-id: 0ca4859a-608c-4292-e4bd-08dc4b20e1cc
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 +LwUPqrU5TMLZbHtTh4OsLuK7bG1lpxyaeDfW2Y0iPyRoeQeGNQP0RyrYu94GwXqWcDYGDJ2hMRodx9IpNyLGzR/KRXxTEM2aBVo8r4/QXW9C1sAc76Oju9MSnkU4vDo9Em2mgsQWcb9UNM7E2fV74ryAzcT0EbgR5PEtQ+UJrTT//Y2NUTbQ4QDeJ42m39MLRpTXIjUgq9LFaSIbbD/Yf+3yPQhGPUXF0G+7CObyL+7ruMeeavTGFKfKXCFnbOE206M2RH5M5cYwxKiu2IqfO8qY1O5/8+EKI5hqNCRcm7lvDUH+8yKKSb8vaBm+5nlcRK9ZFCkVWBH+2EYjVb6xlOiKMlJXzmNUHVrR99FiRwsjPETuG+oduOHJ+7fMpcnbaDc4TByOyvVzLc4ogLMf1w3zVskfxKFbf0sGpoogikwbkBcMSySxU/5HSSQK1CbzDpQ6zSRD9Dw/JvYzhTha+drjv4S/jYb7QWDJJIloforVaHbXRhFcVMRtL1FnzMe9ETToYQyFhs0RNXs81EkiSCbR+YyDGrdec3XyfDztyIJvFq/A5LFj+JMcHKMfeNrRoD645oJJmQVlUEhAn1GDQ13+pWZVdf5qYjWeoQfgXzrDFnUa9xTqhDBpMLx1vqGl4Kn+tr/eLmo/TGXfgoacyW/R63bnskUF8RSGu0FsCTDikdm9RH6vO6kOVYnuCmDs3u669YeJ3btEeJ2jG52Wg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?gjJ26l5E0gNF5jEZw5Du5ksD2xuyeAaACMkwmMOBaly4if5D3JFY2YPv4EYX?=
 =?us-ascii?Q?qCmbtkf44zVQDMZGCEQKUaE6UBBQPHljQ9/SW86zgz0RyjlhpJ+Xm24/xpo6?=
 =?us-ascii?Q?QrkO9l6g4hKWBjn9rjjQVnT5I/EETFohdwnLwML21cJ6v85UW6Fh8Wl9AV15?=
 =?us-ascii?Q?qQk5ZJAv+ohN9DKq3L5bC1/32lFd5bVm1EKmxoA4SzvveIryXnbKzlJBM7Hz?=
 =?us-ascii?Q?PhuUmnGB39JTnx1d5Zf+t/5W/B9IFSjaRDWKf4P6sMipGTDg5JnGAHc3SLgs?=
 =?us-ascii?Q?GzzpSxmMgtUEd26jmRx3qnmcRSD2to7GQVRfgmfIJBX8+yyjlUrJvSfc4Bh1?=
 =?us-ascii?Q?IrSEPt+3HuzDs8OiLC8M3kj4mFQHlQtM9dSrdNHLmvbq7l4cZbkFNS7WMpIm?=
 =?us-ascii?Q?rdue6DSvrasfkIBNPu/bSWU1g2UZqAwIIJy/CdxGiR7/mFwDQIJBCXGtx87/?=
 =?us-ascii?Q?et9qhJf9MHUuWT0mi1DoR3DTDH3FzV8TGWny2inZ+xQa5uykNrURxI8jhHvp?=
 =?us-ascii?Q?4bF/OZ6vUUiBcs8eLgYQeQtbgt4nHS94jI9cmSjROUBlRhCHklSZxIUP2TdG?=
 =?us-ascii?Q?vnJNwIzsB6XiWuGPrcavoGUcljhtPtALrpLE9eZjW2a62ROY2j9SJ5B3/mdA?=
 =?us-ascii?Q?eRREFI9iqiWjLVK9iNGM6jMd62lti8Y8/RQ0ryvEvRuDElv8Pja1tNkLAHeB?=
 =?us-ascii?Q?b76ABi6WUYe4cczE2gnetEe0RdI1F8HbaM41heUSq959OZpDUSN3neOKbrMy?=
 =?us-ascii?Q?KUTSIEWXuHdn6RFtSUWKNZEMPG57kstGIfr/ksjr5FOwyF6xlig7YSdRoISW?=
 =?us-ascii?Q?eiMI+8iICRtOC6sSbt5sjr0hbjO0o6ypFLDZ2wSheD4Jg7xOyaOX4joJFGRi?=
 =?us-ascii?Q?3uHyUFO/zv55mKGFINQ//6PFmxLPaw29BdqLLUIudX5CwUZirPTIfHPCsUys?=
 =?us-ascii?Q?ZiJhTKdusOBkVdJ7n00OvPFaneag6CxySVnDxKsRB9Oj2EnJ1by/rlJpTO+Z?=
 =?us-ascii?Q?+sEp/s75/37QUgmkTSZNv1ffxA+ILM0Rv+qRPSzFO9PT4eyfNBCw9wFAKR3z?=
 =?us-ascii?Q?rraVIrw7hhnyD1mSAoxAh3dyaTiWQvrUq0Ogue9Hu3XmF4kM3nKOAUwjxXVz?=
 =?us-ascii?Q?oXWJLlK4YQuk3vycMYnqyqa5q/KwUsbDVjqD4ohAgFtQh/aGm2Bt49S3fgKb?=
 =?us-ascii?Q?9Of615GfLa6LmtHEOnTbSZ7ISgzcLLEgVKK0H+xWNICkSxHpjF/2dxSmnS/G?=
 =?us-ascii?Q?ZAWBolvLZMsQi3zp0iekBu8tjvoyX6X7xz2UgSfK8GXQRoXIX+Fhm8z3WuC/?=
 =?us-ascii?Q?oXc2FX74a7dydTOmeyZnq5y1XnEoyWW+AkiJ+Sbu691CRYBn993ELYUKNQyW?=
 =?us-ascii?Q?wFPUMGwXWUuVJ0IheKExj6oHSKIF2+BxA3ImDHKOEEJ8ndMZ2BFJ/HZT213x?=
 =?us-ascii?Q?SbOOHF9hqUxnKaWyugdCteSDbeU32dQ+2v/dxYl06EwjzqgDyNzpa3jGFyyd?=
 =?us-ascii?Q?XRLuyk/UnvHDbY6u+3zo4dCcrCYQFVsf4UZO1VlOLiQKsZe6R9EpePWbcfqI?=
 =?us-ascii?Q?UWeXv20fUr0GTxabqzBRZ8d5+NL0zusuosVBE/Is?=
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
	59wmv4W6pTTElkLCHITQTB2X+TGEMuGtONS+v2w16bS8SmidOgd4y+G/E4wtn65+arKt2J0fyKQLtU7xUY2OpeNswnbfHswQaAsEyCbMmH1nfAv8uYZxt+I/UhFgxhGjuwxSVNt7T4fROpyQmN/1CLZjd5NzRUM9S4tDxaUE49DBDLCvgydXFHe8nZ93PxyYvkYeVdXe3wrSsC5w0bPrEy327C9J7f8p5NEniGGpCK5GrPLpeQGuHH+2sf3JGRDTQCryQmp5SAcf59yctaZJWh/Kr7xXp6rT/CbgNF8jyd1D69cF4a0lODGQAva9tICRcc7marOnAoL3b6ahCcMUa2aTYZ0VLzitTkT0qt+Cigu9eOp02wH1qbEKatliqsTCWWBTnCKkJXC7cB2nHwsvBfVePSkk8pPXP8Y3ur3cEF3kHsF1UwKfu+Y9cBrCy28XrkP5xWgwxBAkOElswtN8mLn2quf/C9+v7IHp1RGTn2u9tSyzHNId95TSM1QZ3FY94RazofQfSWgrteVUXnZiDYGVyO0CET6NBHEKH+zmvvBNPlbVPsaYg3/+Bq9w35/BkLDhSsf1Y1//Kv99i7V70gBtTBZVcBh7a3wcRCGN4ju97Xq5P/or7/Cxjg/DXun1
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ca4859a-608c-4292-e4bd-08dc4b20e1cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2024 10:06:17.8826
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i0UiGLOQDIFUcXInNTIA/bq79iEdYXB16YaDMtWLATRnojlXQMRM+TiHD92H6pg14aJ3Vx7nDV/9/2eJ8lp3hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6444

Martin,
Can you take a look at this?
I have a follow-up series waiting.

Thanks,
Avri

> v2->v3:
>  - 2/4 - Clarify commit log (Bean)
>  - 4/4 - pass cmd_type to ufshcd_prepare_req_desc_hdr (Bean)
>=20
> v1->v2:
>  - Attend Bart's comments
>=20
>=20
> Device management commands are constructed for query commands that are
> being issued by the driver, but also for raw device management commands
> originated by the bsg module, and recently, by the advanced rpmb handler.
> Thus, the same code fragments, e.g. locking, composing the command,
> composing the upiu etc., appear over and over. Remove those duplications.
> Theoretically, there should be no functional change.
>=20
> Avri Altman (4):
>   scsi: ufs: Re-use device management locking code
>   scsi: ufs: Re-use exec_dev_cmd
>   scsi: ufs: Re-use compose_dev_cmd
>   scsi: ufs: Re-use compose_devman_upiu
>=20
>  drivers/ufs/core/ufshcd.c | 204 ++++++++++++++++----------------------
>  include/ufs/ufshci.h      |   2 +-
>  2 files changed, 87 insertions(+), 119 deletions(-)
>=20
> --
> 2.42.0


