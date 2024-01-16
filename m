Return-Path: <linux-kernel+bounces-27268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E0382ECF6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 11:47:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC3B81F23F46
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 10:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A71C218E0A;
	Tue, 16 Jan 2024 10:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="ooPBPkec"
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1373317C97;
	Tue, 16 Jan 2024 10:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40G539bd024542;
	Tue, 16 Jan 2024 05:47:07 -0500
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3vkr17a7wb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jan 2024 05:47:06 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EVPqRrVphUgahuhkY7Gxx2HprqmyejKdpyufLGpxMBf5i0l8o8qi24GwVil9VX4Ga0iyh1b1J623Q0CcgA8gB+40I/yvKcyzXwa0ekE6DhjOMISxr8far6jESG1W7oUpgJ7+ugD2lUhWYfnNT7GKlrNhSpZUy+ov7LrqL/uMg/sQ5Ky+GCWYOGhssDef7Hyl9XbVjn3i6+v21afm6LvEC3lIZOKj3XUT59rTktdUwecJ+y2Wx6jFz8Liq4UioGtTMxsFPPtqiu7yI7KElZDq6fOC8wUn1THkUY/S6D4bQs+WcmcHdrCibYMdEKlavVDQaxxXY6ldSe0ZpalPr/W0kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D/flvc77ESAk1yoh2c/aksnbDdYa0Qctn45nggY5Nbw=;
 b=VFremSv1mss73KBnO0NdqrGUIPa3JxZm6FIb6ggBKlw55u6O7QSXcB1dlwV5JZ/7d2SpZaeR7yT4eQ6buXusPYeXivXbmKJmx+5zgbNammmkhkP5Mjx0tlpjqB4R50lzEW6nrFAqmpOLjZ0Gc3fNB1texIkuEMZ4DHr8Qy5YfZhHH//b9XxD8IaC8AfI3TPzN2kW9hI3xkb35Dr9ZjJGwoSzOjVNM6aHEXd442eQz7UanjI8vKL8wB0PetYtW32H+NukrSt+mlGTjI6/QH8h3nmj7JwRdNLgjbT/E3x8+dFXkhWj2mHSrYgdKdU8QMiOAwvPEHNgsCsjiysowf0EJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D/flvc77ESAk1yoh2c/aksnbDdYa0Qctn45nggY5Nbw=;
 b=ooPBPkecogAjT8XwTYBEkHXPC9mDwWVYorZunoq6kzJFul6Iu1yMTBGHV0roRRyw3ONWRpGC3b0h+HBOSJ6i5i+KTeIpEUsSqiXqqJ0KAy2X5EZbNFx3dBnEzXqiavXkPci4y2WnRQ/aWmH7Jh3gFBoSDD+oQztB8DAo942tg/k=
Received: from CY4PR03MB3399.namprd03.prod.outlook.com (2603:10b6:910:57::13)
 by SA1PR03MB6596.namprd03.prod.outlook.com (2603:10b6:806:1cb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.23; Tue, 16 Jan
 2024 10:47:05 +0000
Received: from CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::3fc2:277b:9662:29e7]) by CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::3fc2:277b:9662:29e7%5]) with mapi id 15.20.7159.020; Tue, 16 Jan 2024
 10:47:04 +0000
From: "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>
To: "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>
CC: "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] rtc: max31335: remove unecessary locking
Thread-Topic: [PATCH 1/2] rtc: max31335: remove unecessary locking
Thread-Index: AQHaSAm3Idf2yZ58R06bqymzr3MH47DcQiHg
Date: Tue, 16 Jan 2024 10:47:04 +0000
Message-ID: 
 <CY4PR03MB3399960604BF0CAAA108231F9B732@CY4PR03MB3399.namprd03.prod.outlook.com>
References: <20240115232215.273374-1-alexandre.belloni@bootlin.com>
In-Reply-To: <20240115232215.273374-1-alexandre.belloni@bootlin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: 
 =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcYW1pY2xhdXNc?=
 =?us-ascii?Q?YXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRi?=
 =?us-ascii?Q?YTI5ZTM1Ylxtc2dzXG1zZy05NDAwZDIzNS1iNDVjLTExZWUtYWViMS00MTU2?=
 =?us-ascii?Q?NDUwMDAwMzBcYW1lLXRlc3RcOTQwMGQyMzctYjQ1Yy0xMWVlLWFlYjEtNDE1?=
 =?us-ascii?Q?NjQ1MDAwMDMwYm9keS50eHQiIHN6PSIxNjMxIiB0PSIxMzM0OTg3NTYyMTg0?=
 =?us-ascii?Q?NDI1NzEiIGg9InBGYXJsY29zZlNMQ3QySG52RElpYzlTOCtjbz0iIGlkPSIi?=
 =?us-ascii?Q?IGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk5DZ1VBQUVvQ0FB?=
 =?us-ascii?Q?QkxVMXRXYVVqYUFkbEN0UURlblFWOTJVSzFBTjZkQlgwREFBQUFBQUFBQUFB?=
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
x-ms-traffictypediagnostic: CY4PR03MB3399:EE_|SA1PR03MB6596:EE_
x-ms-office365-filtering-correlation-id: ccba8462-8cd4-4b21-1470-08dc16807a7d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 zlE9p85WDX179a/pVoZe2mJkKXmcdwyTfJzGMI97K25n/iMjLU3qn6eVo5QHDDdCBKHm1dzRvAiacmO2JEtiodQqAI8g+oLLdb+kZQxhuQafukLiZS8GrPzOV3j/L7GNoFVTdp7Oae1idcdMe98BxEdeSSlbAOlSf/bfzpzQU+URSTzvNYSYI4eV0AJAl9ovc8lPny1LRb1ffnayTnEGogRIQjMLplDPWgHsGXB1nTZdQTxcNmguH6y9Du8/JLMDOE/41KVg/D4CW8KbwJJKkpIr7cj/EVO99Y2K3+wIR526ngzzRdVVQkv7/TqiTIrxGWpLXDtyD9jOjfgs7HtnC0stTc4BawyzI2KjMjpRixVTMhtVs4axy1X+65VqZueXR4dcTaw8GpQECsMS6rxeTX3rWniS1+O0rpN4Xvq+arNDx+15H+sCFTqtirjpPh67rHfqy/+Fe2AdUu3s2/NsHVqEq9PE9E8oCFtIw/2x3kGaON3v+EkNPjvxCbCBHR8m/2C62F6IDIrZay/vDnO2TCZZd97LjRQ60gpptKlg4XWpSH0Z60aK50IPXUqNlSel03g8LmV9tZGX75US51wQqSE7rnr7UKqcs24Lo19yWhaFwv701ZYYuuf8y3jRsgPV
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR03MB3399.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(136003)(366004)(39860400002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(38070700009)(41300700001)(2906002)(5660300002)(33656002)(86362001)(83380400001)(316002)(55016003)(9686003)(7696005)(6506007)(71200400001)(64756008)(54906003)(52536014)(66476007)(66556008)(66446008)(66946007)(76116006)(6916009)(122000001)(38100700002)(8676002)(478600001)(8936002)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?Rhm57EQiACyuFgakwnLZLg2fZ+LHILAIG4GdsRXSBmRYyjOE81BoZBWKIsHW?=
 =?us-ascii?Q?O7J5h9gQ7af2OPj3lyGXFZXaPrMZscfWtZ8WbPh8HJq3lExMu8j9zO3In2OE?=
 =?us-ascii?Q?kz2veaN2SEOStTTZb3N6QUWGI/9cRIo7X2zD9lncA5Cy+Z5GUpFzxo+sOHKf?=
 =?us-ascii?Q?FJJLBmWYyzQvTWG+2r5rhY/UTyEEIIndcfObeMjSVYQN5uyOreSDc+Yxt911?=
 =?us-ascii?Q?JbK6mEnj406y44cp3CnFxLkv2pydUWRnU4ORtFXKR9D6uokGuxHgqSIoPvnd?=
 =?us-ascii?Q?1H0QZLZaDMzSOhOFU4oi0Hl3b3GozseVjlEPnuaQe1gAPeddtSCQmVTgdPGn?=
 =?us-ascii?Q?3AtziPcn+1+cQTzce2sL0CYXFmpDsb4/rc1yct7Z0jjyGeA6LCEC/b876hhp?=
 =?us-ascii?Q?zOyxx6DVKHE9zmTKUXMYRLupw+6ButVq9xiJYzJTfBt6fkRpn6rhZVINQyvQ?=
 =?us-ascii?Q?kvoGXtapWo/NtfLwbkcCGiVJo90VCtw1Pq/rRM1utFCBIcbHxIm1pLtSROjg?=
 =?us-ascii?Q?L0OT2XUDl16iPtpGEnWqnqvJYoADZn2lfoZoFGwH8qcseCYfZjAZ13fWwkkv?=
 =?us-ascii?Q?6/DmJgMNancoMXGGpLB6+qe6iekYNGsaTByI0ZLvckrbJ3+gzBchzqLGyQqj?=
 =?us-ascii?Q?sSQo9Jjc1L4hTy8O04j73OK+ZAvV8RpNG6x1bGA3Q3UrPtevRUIPO3yX5M3h?=
 =?us-ascii?Q?PfV9vRL1Bbo9kWbVPOsbBMuLO6bvZzCgQKo3QNR9vgdBOcDzmUVyjDtB+3Hh?=
 =?us-ascii?Q?RUY4pSzy4jV3b9c22uC5zs5M8solo3NTIDvXZbWHyTa1rD1xg9e7gEklTbUo?=
 =?us-ascii?Q?M3mBgIT9Z+FXVjQlGevgdusgThqvBxmuQpIMCU7LzeORTcsgD+lWAtPlMqcG?=
 =?us-ascii?Q?pQ7angKKxnaH8dTmevsmFMAI9mce+HGpodYo6l6v9wA37JXPoverOO46vJwn?=
 =?us-ascii?Q?JGQwK4SBN1QegkF5c/oLSoKYyjcmTuCQDzZQSHHmU9eV85ZzHUsvUI7ihNmY?=
 =?us-ascii?Q?3ZfRd+dseIkqCpR+1GbcfbEaWb7kDu6Dc3GesvuFSdO2M7plOUnZPciHmMo0?=
 =?us-ascii?Q?cCh790OCK99Wu3FyNiGYGdeIAFk2PxTSppWIdzhpZIhFn0Qha07Tg5j4Hcwr?=
 =?us-ascii?Q?IyOnF6meShkfpFRraICIURIVAmmc+FmYTQicreCF1gzJxcSIMNhaE5MqzYsM?=
 =?us-ascii?Q?RqvD9+aCpI1oc3r3XZfq6h06r1PETBNw+aI8XlLC37FVTJG0xyn+LcVgNx2i?=
 =?us-ascii?Q?H73/Jqx/7PThDdYf5Y6M9dp4zPcY/BtDwATSFZ9MTKm8FVHmhPLjz6BcdxsK?=
 =?us-ascii?Q?LSptYTOTb3VHMtSJsCaQKmVrPPM7c4wMRymiLWrvffFOhXx9CBH1pP3ANQ9H?=
 =?us-ascii?Q?qnVQVAiscCvztBy3NtUTFKEcpjFbf7UnUJiHLTTj64uKxJhKJqq0U1pXHpTk?=
 =?us-ascii?Q?+ZGglB+BZFjsf0i6dRS9olxjTlU/CsvtFxubPY6BO1R42wK9g+B1RYxS/Xdz?=
 =?us-ascii?Q?lbUNIz0jZUu2+NPcUkzfaOc0GXGKV2paZ5WcTHPn6UVf8Av+s0H9px7VinXc?=
 =?us-ascii?Q?RK3b3fcVV/PHLC8mJrrNbip95AwGtB/q9Sf7683diToSONGPYsTGrEHPJXDC?=
 =?us-ascii?Q?L3ldC14yhQLxF18Xspu17OITrEeS5YhoWgzudgwz73HrepZ6nVh6CogYNEQz?=
 =?us-ascii?Q?3Y4bbw=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ccba8462-8cd4-4b21-1470-08dc16807a7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2024 10:47:04.5955
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vFYQY2LZKVcrsBLnvDxODuPjuDUPuRPjs53fWuOGE8CETnwFpZQWwyY3ZhHGgH1EyhDqdkHZkO+dKBJbEZkwAviO/X2PaQ+YX9CAho6ZpjU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR03MB6596
X-Proofpoint-GUID: rjZdafs7QZJJUXcrBRyvDlXubLOD4a9i
X-Proofpoint-ORIG-GUID: rjZdafs7QZJJUXcrBRyvDlXubLOD4a9i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-02_01,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 clxscore=1011 priorityscore=1501 mlxlogscore=942 spamscore=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401160085

> From: Alexandre Belloni <alexandre.belloni@bootlin.com>
>=20
> There is no race condition when accessing MAX31335_STATUS1 because it is
> always about clearing the alarm interrupt bit.
>=20
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Reviewed-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
>  drivers/rtc/rtc-max31335.c | 14 +++-----------
>  1 file changed, 3 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/rtc/rtc-max31335.c b/drivers/rtc/rtc-max31335.c
> index 3ddfe71bbb56..2ce23f60a7f3 100644
> --- a/drivers/rtc/rtc-max31335.c
> +++ b/drivers/rtc/rtc-max31335.c
> @@ -348,27 +348,19 @@ static int max31335_alarm_irq_enable(struct device
> *dev, unsigned int enabled)
>  static irqreturn_t max31335_handle_irq(int irq, void *dev_id)
>  {
>  	struct max31335_data *max31335 =3D dev_id;
> -	struct mutex *lock =3D &max31335->rtc->ops_lock;
>  	int ret, status;
>=20
> -	mutex_lock(lock);
> -
>  	ret =3D regmap_read(max31335->regmap, MAX31335_STATUS1,
> &status);
>  	if (ret)
> -		goto exit;
> +		return IRQ_HANDLED;
>=20
>  	if (FIELD_GET(MAX31335_STATUS1_A1F, status)) {
> -		ret =3D regmap_update_bits(max31335->regmap,
> MAX31335_STATUS1,
> -					 MAX31335_STATUS1_A1F, 0);
> -		if (ret)
> -			goto exit;
> +		regmap_update_bits(max31335->regmap,
> MAX31335_STATUS1,
> +				   MAX31335_STATUS1_A1F, 0);
>=20
>  		rtc_update_irq(max31335->rtc, 1, RTC_AF | RTC_IRQF);
>  	}
>=20
> -exit:
> -	mutex_unlock(lock);
> -
>  	return IRQ_HANDLED;
>  }
>=20
> --
> 2.43.0


