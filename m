Return-Path: <linux-kernel+bounces-27270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CE4082ECFA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 11:48:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB2721F23D6D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 10:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04D3118E32;
	Tue, 16 Jan 2024 10:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="Ygdbi2yR"
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E29175A0;
	Tue, 16 Jan 2024 10:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40G6QuHf022945;
	Tue, 16 Jan 2024 05:48:09 -0500
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3vkr17a80d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jan 2024 05:48:09 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DRFh4a+r+rR33sN0WBj37S1s38rRUm3Kdh7HwwxvEO47PY/TOsxpwndRe1TPG8yEZP93AQ5kL9BHo7VpbPp4A+VAfg8SjV8XpKuLbVx0b5TcUnjaMGs+Wl+WwUMo3k54puHM6uP/TXzePnWdkVrk4KIWf2ZCROLgvvzkDYyOVaGhRxByrwdjAUzDT6dUeNYHiOpsvh5iX6vBJ+mCK/IhXOJDdzfBOwp2wQzS1ag5UfCpK6nE0Ccvp1ELygpUT7GCIpIo0hDBR22x357V+xws6zrOwpJQvvfDuWn0OE4MOAWrYSfJFss5/Ly79SxX96xOGaavg6e8SiL58miKWlu7iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3v1NhnsqieuHyQLdg3IcVW6VXkAMeOlTQCQKHQX2J8o=;
 b=f6tML98opebqDjNOC4sTSmuPLaZhlqDWA+lRPS5X4goOUigXFiTSDTApIyxZhPu3HUusffDx5NCpWhB8z7kKZqhu/Du+nBcxuqUm3EgkT69rmcPJdCJV5K7UpirgEMySbIMzfxzi433k7SWdrp13TBMJ1EO8UY/CRfpeGivOoTbymF5jzyU0/7tWUVaIB9ndFy3FInYW8xrIR8PhLR96BQz1NHKkGVqA6jPa/38nhLaQDhyjzigjPOa1AC3jiMedIKO5P07zJqPEEZFnmYJlkCzcclFXV2nT950Or3Z7VWbhHwuwzlhI8ZJcXropceFBj7vcWXOTB62fql+xVPLw7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3v1NhnsqieuHyQLdg3IcVW6VXkAMeOlTQCQKHQX2J8o=;
 b=Ygdbi2yRwkVcWV2d68sI4qVq/b3xeTvUbCHHc1HaoYakz/uIlIkocqSThMOWhHSCpsEK2gqT8Fo8MrRco4LXVUo7HWjaZ0GBNadBezcRGAKKX2MXTXIkaeyDK58F7JOW8X3//WERixEmnz0gYHWY0VblWnnC81MfIOAed6Ugxhc=
Received: from CY4PR03MB3399.namprd03.prod.outlook.com (2603:10b6:910:57::13)
 by CH3PR03MB7385.namprd03.prod.outlook.com (2603:10b6:610:19a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Tue, 16 Jan
 2024 10:48:06 +0000
Received: from CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::3fc2:277b:9662:29e7]) by CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::3fc2:277b:9662:29e7%5]) with mapi id 15.20.7159.020; Tue, 16 Jan 2024
 10:48:06 +0000
From: "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>
To: "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>
CC: "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/2] rtc: max31335: use regmap_update_bits_check
Thread-Topic: [PATCH 2/2] rtc: max31335: use regmap_update_bits_check
Thread-Index: AQHaSAm2cgwBs+8IIUakAt0fxwHZXLDcQrWQ
Date: Tue, 16 Jan 2024 10:48:06 +0000
Message-ID: 
 <CY4PR03MB33993A5FF5F4B8C27E3DA2939B732@CY4PR03MB3399.namprd03.prod.outlook.com>
References: <20240115232215.273374-1-alexandre.belloni@bootlin.com>
 <20240115232215.273374-2-alexandre.belloni@bootlin.com>
In-Reply-To: <20240115232215.273374-2-alexandre.belloni@bootlin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: 
 =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcYW1pY2xhdXNc?=
 =?us-ascii?Q?YXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRi?=
 =?us-ascii?Q?YTI5ZTM1Ylxtc2dzXG1zZy1iOWNhNTBkYS1iNDVjLTExZWUtYWViMS00MTU2?=
 =?us-ascii?Q?NDUwMDAwMzBcYW1lLXRlc3RcYjljYTUwZGMtYjQ1Yy0xMWVlLWFlYjEtNDE1?=
 =?us-ascii?Q?NjQ1MDAwMDMwYm9keS50eHQiIHN6PSIxNDYzIiB0PSIxMzM0OTg3NTY4NTIz?=
 =?us-ascii?Q?NTk1OTIiIGg9InBxL3ZuSW9zbHdDQndFOXl1aVlMYXVHa1Nsbz0iIGlkPSIi?=
 =?us-ascii?Q?IGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk5DZ1VBQUVvQ0FB?=
 =?us-ascii?Q?Q29JU1I4YVVqYUFYbjlvcjlnT1JhQ2VmMml2MkE1Rm9JREFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFIQUFBQURhQVFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFFQUFRQUJBQUFBRU9wbE9nQUFBQUFBQUFBQUFBQUFBSjRBQUFCaEFHUUFh?=
 =?us-ascii?Q?UUJmQUhNQVpRQmpBSFVBY2dCbEFGOEFjQUJ5QUc4QWFnQmxBR01BZEFCekFG?=
 =?us-ascii?Q?OEFaZ0JoQUd3QWN3QmxBRjhBWmdCdkFITUFhUUIwQUdrQWRnQmxBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBR0VBWkFCcEFGOEFjd0JsQUdNQWRR?=
 =?us-ascii?Q?QnlBR1VBWHdCd0FISUFid0JxQUdVQVl3QjBBSE1BWHdCMEFHa0FaUUJ5QURF?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FB?=
 =?us-ascii?Q?QUFBQUNlQUFBQVlRQmtBR2tBWHdCekFHVUFZd0IxQUhJQVpRQmZBSEFBY2dC?=
 =?us-ascii?Q?dkFHb0FaUUJqQUhRQWN3QmZBSFFBYVFCbEFISUFNZ0FBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFBPT0iLz48L21l?=
 =?us-ascii?Q?dGE+?=
x-dg-rorf: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY4PR03MB3399:EE_|CH3PR03MB7385:EE_
x-ms-office365-filtering-correlation-id: 95b18d4f-7d42-41cb-fdfa-08dc16809f80
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 4Y4RIyBNt3kkB2oSNHSzPLXAeueqE5FH2dnVLx/LwzkqUe60HbkqNA4EDL8aXHt3AysHtsz+Jsp/vWmi8UaSxf+rzqdPQVx/TQwBeYJnj/fIgIEJ9U2FxtCadM7xCZRkdUaDQHEHZYxS+QudqKUnSXjtZzbU1HXZ+dI1OtRQG9yU0URVEJf2lLzaY3zX+7/Tcqmse2wim4fA2k3KhBqiNovZZmKigfuRxInFk9UdcSAF7GdXNZLgSXfWDNvPYwmes5ygZV6dJevwp9qvsMKzk9N7xDaGO35WjR+M2YTFHQxX83HEjSaZEGh7QKyM86HyZAhGIyL3xotAXwrXdG2k/qiDcvWUecU6Or54+22K7c4WPMP0cqZ+C6e1mvE93Kc0/j8LIdUGp9Pviv2mjo/22W8RPzSZIngM9aB7wolDl27Woismq7nB0balhkQBaGGvtutbVzUVbVwryka12uBQx+imt53GQ3YL/02VQXcHeiCeJTNYjSI/QdhLqwqJunn2EnBtTHOVL9nGRUJZ7ZolCedRobVrJ0LXgXsJqCSGAsAgbk9ZcAsfTLQisltYZfMMIxeIy0xwKZ52fHKecaFanVLqDMpF1t2BFLdNLr/GAxx/YHogpcqpekBJa6E/GO1r
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR03MB3399.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(376002)(396003)(346002)(366004)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(8676002)(8936002)(4326008)(52536014)(2906002)(5660300002)(33656002)(478600001)(86362001)(71200400001)(38070700009)(83380400001)(7696005)(41300700001)(9686003)(122000001)(6506007)(54906003)(316002)(6916009)(66946007)(76116006)(66446008)(64756008)(66556008)(66476007)(38100700002)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?JzCbbdIHDZe3Nw+A/YBChaGw6qLvDEO2xPK+AOp9I0ZezhpY62jLkiRLmgPH?=
 =?us-ascii?Q?uu9PygGRci0ebkyZ1CBzk9Rr2O6rR2RwxzX5l+QboS6Gfhert/t6mWRZ+Brf?=
 =?us-ascii?Q?dJjZYOzRBwEW3OEJEWWmAe2iwbGIOG8rJ7kF0Uln5GnUH+I+3bRCvEfbb3FI?=
 =?us-ascii?Q?FKvdz2pYFgbz9T8gZaxrolzBl4fu352DypuOw9DPALmhgkKUZqmY5TsVK0z/?=
 =?us-ascii?Q?Tve8tN55XXyYO1FkLWOlaW7MgFDCr1EQpKKD6eiNi/xmezBlHzatuTI+HxGO?=
 =?us-ascii?Q?2DeGYf8OFC5zU4rc6YBjw16McA4jbrgkOabmpa26WZ/XDmpNBDMMvlaHcq1A?=
 =?us-ascii?Q?JJ9aYRcxBwx+tyXYkvF/9CVLPt+yJSl/1UnLP4zP9WKZTSEpbM+b6a1dAiG8?=
 =?us-ascii?Q?O0eukLJW97WWNAmucsiPsWNu66TsUx6wkD5mkglHMExZyJBx/mO3RKyUmicP?=
 =?us-ascii?Q?RtY8XhppGG/VK6KL2afjZgJtGNeUg7izfLk2nzLZzfgI9/kLp4Fi+n9yCJ2Q?=
 =?us-ascii?Q?1t7qIx6twPUBewLgvY1pD/xKKGlBIShDcayyqPfFNaHuVxNTj1ET3tG/Bcx5?=
 =?us-ascii?Q?UAvcT4Qgb+7bMrLbgCqliETTLsYDfzb5E8zPs4rBvZD4gxDfFUretorqPFAc?=
 =?us-ascii?Q?8zvyJq4THbeWhHGX9ULZTh523B3rgQLV5NUKlvUDA+k46XmJ1wKHq65pPy//?=
 =?us-ascii?Q?2Mg79T/dmQ4jHTLmLFldMdf2xGJQjCP4Ij2EJcqBQhtTuoCsanQ4QEXIg9uj?=
 =?us-ascii?Q?fEbGkwOpBDTNk2pL8qyuZ54ai3SlqaiCOKNL8C38ImLucwzi0P3Ai/dh1/D7?=
 =?us-ascii?Q?M36730ywQzmIePdWuwHzdLz/UA9lXk/IStdUOZEgfkKTDCKI4QlOwIkbF2JC?=
 =?us-ascii?Q?ADThxXPrnGfnNO1ssJ+IbnaGBSByPdD2x4GlMyvSWzIbP5PPJvmst1SMKE5f?=
 =?us-ascii?Q?Ss8AIWTIU7CRxbymrrauT/4UNpsarQwsch5ODPRZ9J2ixbNSQw5PFJyrTAS2?=
 =?us-ascii?Q?SqESouUS89IpZ6y23poIuiCUHrrx8ZGtC8hlNEwPLawfVGkjYCpuy9JSBD6V?=
 =?us-ascii?Q?iWGuOQicRXJuCK0BElqyXYNQaCvkQCIJxngnHACl/sAxVA394Io82EWy8HsS?=
 =?us-ascii?Q?X5dN/UZrRim1lx0YC/6wangKRoX53CDGCPfMLCW/IidixPVFeuOw1a+4HXXY?=
 =?us-ascii?Q?xDgyWn4nV6NxLCf6yfHQbHPn45RX1NMCohhMWcpFaX43GrjRDpbiw9OPtfde?=
 =?us-ascii?Q?3GWLDU2xWBoMX2HiUDSSgKXx/WcrqJ96Bo7AC5+sxJGDE1yrvYDVmLqgLIhu?=
 =?us-ascii?Q?vgq7N3zhFZPNdP/zv8CCBr/mMZCLGqCmRyxkjYP+rqeTyzdMzrntOdmEoFcZ?=
 =?us-ascii?Q?6paw61KbXUCtj6dBtmEfaDnmLNqtq07cCr7e1SDh9M8G8sTMY2KikaBYLEd3?=
 =?us-ascii?Q?aCunmm6ONV2j2qyo6m7WkG0gxdK2ZfsEM3l0vDHJo37MqvZWWFX5wOS6S/uj?=
 =?us-ascii?Q?Em1kEzwirQZxtR/p71wt+u2sIyiumLQxHiWrNExua727m4Q7rS2jcCYO5+ER?=
 =?us-ascii?Q?hMrU4yJ2Ms12c1qI8GqkQopZJK0Mz+OifW31JFuEVj1E3lc03nyzVQuJZ5Qj?=
 =?us-ascii?Q?NiFsb3aQlLv17J9V5ZREjzgaBY09eL2AyBiU5RBxK9A1KrpTgN8IN0NwhvDM?=
 =?us-ascii?Q?LLWjRA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR03MB3399.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95b18d4f-7d42-41cb-fdfa-08dc16809f80
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2024 10:48:06.7177
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ejslgQCDCWHgUEkqZNCpNYgC1IsqAKSkG0TBICLvzwSx3osjM3NVUEVo6rmVxQxdm+ynZgDchvuhSsAqEnYgD9G1t3GMtQYg/BfZm7L2vhU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR03MB7385
X-Proofpoint-GUID: F6f6x4R50REifHqFCXOCjiLRdQoGNEq7
X-Proofpoint-ORIG-GUID: F6f6x4R50REifHqFCXOCjiLRdQoGNEq7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-02_01,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 clxscore=1015 priorityscore=1501 mlxlogscore=895 spamscore=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401160085

> From: Alexandre Belloni <alexandre.belloni@bootlin.com>
>=20
> Simplify the IRQ handler by using regmap_update_bits_check.
>=20
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Reviewed-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
>  drivers/rtc/rtc-max31335.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/rtc/rtc-max31335.c b/drivers/rtc/rtc-max31335.c
> index 2ce23f60a7f3..a38d303d9df4 100644
> --- a/drivers/rtc/rtc-max31335.c
> +++ b/drivers/rtc/rtc-max31335.c
> @@ -348,18 +348,16 @@ static int max31335_alarm_irq_enable(struct device
> *dev, unsigned int enabled)
>  static irqreturn_t max31335_handle_irq(int irq, void *dev_id)
>  {
>  	struct max31335_data *max31335 =3D dev_id;
> -	int ret, status;
> +	bool status;
> +	int ret;
>=20
> -	ret =3D regmap_read(max31335->regmap, MAX31335_STATUS1,
> &status);
> +	ret =3D regmap_update_bits_check(max31335->regmap,
> MAX31335_STATUS1,
> +				       MAX31335_STATUS1_A1F, 0, &status);
>  	if (ret)
>  		return IRQ_HANDLED;
>=20
> -	if (FIELD_GET(MAX31335_STATUS1_A1F, status)) {
> -		regmap_update_bits(max31335->regmap,
> MAX31335_STATUS1,
> -				   MAX31335_STATUS1_A1F, 0);
> -
> +	if (status)
>  		rtc_update_irq(max31335->rtc, 1, RTC_AF | RTC_IRQF);
> -	}
>=20
>  	return IRQ_HANDLED;
>  }
> --
> 2.43.0


