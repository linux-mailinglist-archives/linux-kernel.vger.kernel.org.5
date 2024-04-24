Return-Path: <linux-kernel+bounces-157185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D2F58B0E08
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 17:22:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DC2CB2496D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22FFC15FA68;
	Wed, 24 Apr 2024 15:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="JxkQt+FK"
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC6915E5CC;
	Wed, 24 Apr 2024 15:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713972159; cv=fail; b=fvFo0X3/k49UkbY+6Blq+4xGyWPexG27tnJgywpgpWp9sqeN27AeDCRKl+kvzGSelkg+A1sA90ulbG44Jqc00MdVwwGj6q6FaHZpeo/1IRZBPZtn7JQS/24hOY7OoFH+6fS4TwlhsSqnBEYnYKfJ/a0fw80RxsLQ8JG8wq+vohU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713972159; c=relaxed/simple;
	bh=I62ON5aaSemk8CwAx+/OLVqXs6IEK4aDrP3+emcQmVI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VlWd8Icytsgm7xUUuyGEl/f76wAS8X/8r9k1lbvo0Aob8q7DxSXsBKFd4tF78FORiU3wZuzsF9jZXWMJK0E3KsqfP+gQI9P1fxxYZ1LzJ5RZVyE6kbHDAauijpfyO6njXeZupgGF74inuJnEWwlSGpOwcgz5wzFsOqazUu8v2LM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=JxkQt+FK; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375854.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43OER52W026844;
	Wed, 24 Apr 2024 11:22:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=DKIM;
	 bh=EU4xnrUPcRiwF1jAEiSp4BONZH4zkYoYA774YU6bBXs=; b=JxkQt+FKItYl
	InW9crEPOuM6PTM0TqUyKZQ83iyN0FDN0bkMlhvzqBLdHpIxxJngfgdqFZ7FHj1e
	nmVaQyFZ2updui3iu9CkFLfXF24lhBTkGZCH1H06wHPR8tkCs9XOZxPoWBWO4q04
	eNyJ7Y2JmB2tm7n+KKo/RB5aaSuB55bFd3EHmC+KHuspC0aBY/6mEk91mLLjyx0j
	CR0yPvT/Y3BxoLk/NATJoDmsSUs5W77LKWH9SC48czQVMIEQTXXBh0wFEZAc9CoV
	TkXsSIla2hcTpS8rqLIjDeb1Dni4iO3GBKBDX6MamqFCiXzmaM2FdRFpWhnnyfB1
	uCA5Ygg96A==
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3xq3qjg7bv-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 11:22:11 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ENfZY2UPe/S/4FzKX8/moJglAYpOaL9XOteyggIUhIbO/rNicVsxtBUxfgruDIexvZ0MDcICxIrW7jcOgg8YKSwTPXoTOJ9Li5ODu3qyxRjBkRVcxfLOustDq+OwKJPTXktXOZ2KI37pbo2V4fWPDrXSpNh+BJudocpTBDJuNPbN8kdKtA8e2FYlg57+WZ+ZhaXzrfhywZFw4acryuboDWZR8KcOP7pvvdVWvgeq6tcoM61DOGevNZkdpAJHEBWU9dWJa4mkQQJNcpA5h9alPaFM53IzNhMy31FzzsWxv8FK7qAwrXFS7lYckyGFtvWERaQPsPlWOO0Fcu+X/6Ouag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EU4xnrUPcRiwF1jAEiSp4BONZH4zkYoYA774YU6bBXs=;
 b=HPwX5huBKk7lPo08a61STKQ9aieNHw/H+YSdJgUMF8Dzuy0jfj1Ur8e0etfMyTl3VNAMaA8bTQ1PfcAUq/CSvgYlB1CTrUAgqdYiM8PD2gz5BXObFcswZ/zW3XG4Q8LAxAApWqRlbPjeoEldF75d/h3plpWoxqit95R9yDDYP9kMtYFB45/6HXR66qu3yMhtb3mX8huxa84gRVVvL4NZXvj4toKwY4Yuk71V4fXhy5lZdbCatCJ5lpK0ygRAos9+uT15nfKYLmo7JeVDYi/RQ2Jm/qxvWymmLv88KIbS3yOXKsm8S7ZgpDhAe6iscf34SaTlmnow2uWTWLrDBWmssQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from CO3PR03MB6774.namprd03.prod.outlook.com (2603:10b6:303:178::18)
 by CO3PR03MB6709.namprd03.prod.outlook.com (2603:10b6:303:172::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Wed, 24 Apr
 2024 15:22:09 +0000
Received: from CO3PR03MB6774.namprd03.prod.outlook.com
 ([fe80::45e2:56ea:540e:cd60]) by CO3PR03MB6774.namprd03.prod.outlook.com
 ([fe80::45e2:56ea:540e:cd60%7]) with mapi id 15.20.7472.044; Wed, 24 Apr 2024
 15:22:08 +0000
From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
To: Jonathan Cameron <jic23@kernel.org>,
        Guillaume Stols
	<gstols@baylibre.com>,
        David Lechner <dlechner@baylibre.com>
CC: Lars-Peter Clausen <lars@metafoo.de>,
        "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        jstephan <jstephan@baylibre.com>
Subject: RE: [PATCH] iio: adc: ad7606: remove frstdata check
Thread-Topic: [PATCH] iio: adc: ad7606: remove frstdata check
Thread-Index: AQHakKdB1bhEQ3vcBkiNpSXNM2Wd0LFxB+6AgAaMbuA=
Date: Wed, 24 Apr 2024 15:22:08 +0000
Message-ID: 
 <CO3PR03MB6774929012D27900E8DAED458E102@CO3PR03MB6774.namprd03.prod.outlook.com>
References: <20240417-cleanup-ad7606-v1-1-5c2a29662c0a@baylibre.com>
 <20240420121933.13a0e22f@jic23-huawei>
In-Reply-To: <20240420121933.13a0e22f@jic23-huawei>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO3PR03MB6774:EE_|CO3PR03MB6709:EE_
x-ms-office365-filtering-correlation-id: 287f294e-6f65-44fb-7aa3-08dc64724eb0
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?53ysv/59RU0pSENd2mvhFyG8wpmBjI5N1zDym10IBuKAcSQjmIGLv+yhvwqO?=
 =?us-ascii?Q?3DpxI6uGSOe5M48VoPKzeyD4bTvLtAWjJSP1/mzho6Ku3tjG7E0lYl0lpKHf?=
 =?us-ascii?Q?8jc9rmmqas8NMqjFE8L62W8sy9JoZM/MlFP52Ylo7I3iGeDLKbVu2BD8KJm9?=
 =?us-ascii?Q?cj21rgEbdMPQZAk2BCcjXHK/KZGuG4Wo9nmIrIsZp3M8oJ5qdht+azRzgsKz?=
 =?us-ascii?Q?lE3xn77xzweOGUayegfMrJn3NnhTJcrxtzrUcS5U/tCvFODkQ5UmWswXxJob?=
 =?us-ascii?Q?cYqPrXA1el/Oemvr+Sgvj1W6yswzvqaT2i7W16E7llFUlLw9kTJZBnq7E4NC?=
 =?us-ascii?Q?4TmBPb+LanDuTWtwP3ZG5F1A1e1fHALkPuiBBwPuCImzFxTzgGSaluoHKH1X?=
 =?us-ascii?Q?CHpbeLkfW60IUOvAjvBkRA7xuVAgOZ2vq6ppKBKiR9uDF72wgDoN/GoZxPPT?=
 =?us-ascii?Q?CvHcYZ4YZhL5NaIpUDimMSmaDHBmHER0nmIc9e22RsyXlTCSj7T7dFsIlrL1?=
 =?us-ascii?Q?QqFpZvU7XUW9O1Omq9fZ1yUGplcLOl66Uo6tQ/wHvEuzMtf1XvV/T4nISmLY?=
 =?us-ascii?Q?NSw8ov5iaEMxVJqJ+tJhOQtTQDs5GkHzsCR2e2itMbQSTCxk0heBSdvsdl3N?=
 =?us-ascii?Q?Y9DSoWslvcgrbh6m2XKlACGqENzGIvFwr0EcdXkcXfueseB83GhU0g8HBZvx?=
 =?us-ascii?Q?v5poG/6lSyLg8IUe+NKEa+JDF7CV4JBkpng8UoCBYZpOsuhmrIRU2R+cD4Wi?=
 =?us-ascii?Q?AHpJwq4caMQs4HAOXydz5QSMR0CNiZOKpeJuI9uju8X6fz0vRI3hQjFo/4si?=
 =?us-ascii?Q?cSKZfxetzhGD3sMaJKy/IkXsbTF2DKSSZCY6mITPRkikrqmANM08tRtWSzJQ?=
 =?us-ascii?Q?wi5G/gSM07Lay0Bqr06vL2CXj0UevlzyDo6hbj3AQ2pwqIuujQ8st6aGrec1?=
 =?us-ascii?Q?RBcieqp3sFWiRwC6woZsqCGOueeMfOAYpPGZ4vrfN2XKOUo8qzRad/PiF7nP?=
 =?us-ascii?Q?ijtAgEYQ93FccY++3wlKgEKJOWRbtIsNAjhjBdkjgkQlVwxFePvgxETACPBt?=
 =?us-ascii?Q?cnpgs31MXJ77ZCz6ZTEVDhOCvf5WvU3+OkhQIpG0ZJ5SCSFTz71Oj11TfOhZ?=
 =?us-ascii?Q?zUEyA9Y7w0IdSfBUV/x04U2gbcENYdTI1kgR+5WKQI0HhvG7vLCKqdL0koiM?=
 =?us-ascii?Q?YphqQPFiF9tdTalY9V8zepG5nrFT1X0l0oCKqmiDmL6yd6vnChwPfgAO25SL?=
 =?us-ascii?Q?erZC8DJbk6f92Zg7jYuIou/h5h+CRyp2tmiGeXQH4A=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO3PR03MB6774.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?/5Vk4GdlwpQGsP1Rv1NvWdvD32z5OBV9ta9v7jxOr7VddD49Ib3QR3HxSwyl?=
 =?us-ascii?Q?0uJfpw86nHX5wE5gAxrTLa8mBxPKOXqPz7ZZ8nJalBC6hKkMD+oDm4/vqGf1?=
 =?us-ascii?Q?Jwss11ZWXo153XvPxbQXRXAUIW3qNNQ/AhUJuuCf1ednTj4kzZSFACcaneMo?=
 =?us-ascii?Q?JBp6Lvz7+u+gGuaDC269JCZt/mVp6XF3+3XVIKOPiOtlQkZdvwLcKgb/Qrty?=
 =?us-ascii?Q?jNPp9KdqoH4dGnlRdIU0vCNpwqZ0rManenGtD3PvVyNH10ziGBf4ujP9OLZA?=
 =?us-ascii?Q?E8yhST9zcGFoK0UXxueTJOcBputo7qV7xESJI27Zwk0tKpcHh2icNEwuBNet?=
 =?us-ascii?Q?/onhE+RD1xYMKXSPCZR9I2K1Nd632VtWr7zXWWuszXr7ra/x+Zm97XWBmr+T?=
 =?us-ascii?Q?BLuL55yS92ymhuu96FqpmIsysvv6oW9Nfl9SN5dgqBKAp5jDJNyz3PV7mFp0?=
 =?us-ascii?Q?P6t9JPkgOvnLqvgzvb8lWlotYyB0WgavGsvL8JlaX8H56N2Rc58/UHmWWjUx?=
 =?us-ascii?Q?XuC9JsDvxCm78xrX65dxaY5K/RKJ+1FzMRz8O/NRVrZRKkR8h1vhBUh2GEQQ?=
 =?us-ascii?Q?LgjGvwAPDU0iQFDrcLiI22gsHFBcY6rAubtAFsGgExhT+7sHqkWExDJRyxBr?=
 =?us-ascii?Q?z/zQP9F/bxxKm03HGg6qK/JJUA8Ms+n5FIm5WgYe+w9rhgp93Lwh0IUhzCeq?=
 =?us-ascii?Q?l/gmdRxygOZyXrgbtCWfiTqql/On1DEDhN6E+PaKCQGNoxYInuU2ElnLWTX5?=
 =?us-ascii?Q?Tj790I5/wKDy2LUfYMExsE3AwixpGRfzTv1ZW4TjJa2boki5WgNQmZWJbwF8?=
 =?us-ascii?Q?cpq0KhIQF1Nfj9SMwCI/V8XserTWS2N2XnJxDMMBxDTJ+0oJwWoAGVZ4d3pm?=
 =?us-ascii?Q?vasylBG32ZJv8vUdtY2ASJ8L55PYSyxCAbGYORGqDlI1gew961uD71LOhBZj?=
 =?us-ascii?Q?dOY0LUM/GJfXuYss7tO32oRQUzwcAfZSsS1HLscBRSYSj8ZYkPBQNXORjzsZ?=
 =?us-ascii?Q?zTBkECSjUXps4ZySAaTZlcLSGzUka62UGEVyr88B4dygeEoELlfOPqkKmMb2?=
 =?us-ascii?Q?PJndWmO2uVUV+vHil9tiNhmgQT5xIWstqTi0NFRpw3W2lMK6Y3YirPkrb/ST?=
 =?us-ascii?Q?QUVg/yoIfectuIyyVItiefComnI5LC5jBP65+kAXrSMApaRXSarL8MSeDkiQ?=
 =?us-ascii?Q?DagEuCWqcKgEOCdd6aycZezrqsU2BoIk4eKGdxe49guPCJlG8i1QdhxjttKH?=
 =?us-ascii?Q?ru7yQG4R1dTHPKJ/rwcu4TnR3xALBiYL8mpjjh6KFA5AYSTWuK/WH/PEHyuZ?=
 =?us-ascii?Q?oWmYJ/OTGpA7EbLrHW2Bb2/yavuJQVTKL4IRaL0nV9bikFzpvVoqHOKAsxCk?=
 =?us-ascii?Q?mP2b7RUzYlpENBX7Dkf7oJIM0nCtN8f3rNcpdP9sKdTvbPcCYBM8R8dHieVp?=
 =?us-ascii?Q?kUUgZCRMA8sni+4WGUuPTq3mZd92F78HhjnUpxbbD/dGeoD2gtmZeX4IwZBP?=
 =?us-ascii?Q?wAmAG7S9UV3aQGZvsSkF2hKeJPBC/Mhr7GI0aT0tCDTRy5UojtsBtCCHdNvj?=
 =?us-ascii?Q?czVNjtTM1LOfyr0tAgTXPzPO7MF4F3gUtPxaECw94wYTEUUQej1FnXwFK/bO?=
 =?us-ascii?Q?Kw=3D=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: CO3PR03MB6774.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 287f294e-6f65-44fb-7aa3-08dc64724eb0
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2024 15:22:08.8859
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dMAaZbYL88PktYS7KQd6M3HVFD7Jfqi9m+e15j/H/sMuBJxq4IGRcRhNI7rBbvFunxRb7NkLLA3U/HUHnnRoAG2CpWsSzLMN4wNflAtMjko=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO3PR03MB6709
X-Proofpoint-GUID: SCB8Qwnj1QaNTbpCe7p2ukM7HwhDxtux
X-Proofpoint-ORIG-GUID: SCB8Qwnj1QaNTbpCe7p2ukM7HwhDxtux
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-24_12,2024-04-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 priorityscore=1501 malwarescore=0 impostorscore=0 phishscore=0 spamscore=0
 bulkscore=0 mlxlogscore=999 lowpriorityscore=0 adultscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404240059



> -----Original Message-----
> From: Jonathan Cameron <jic23@kernel.org>
> Sent: Saturday, April 20, 2024 7:20 AM
> To: Guillaume Stols <gstols@baylibre.com>; David Lechner
> <dlechner@baylibre.com>
> Cc: Lars-Peter Clausen <lars@metafoo.de>; Hennerich, Michael
> <Michael.Hennerich@analog.com>; linux-iio@vger.kernel.org; linux-
> kernel@vger.kernel.org; jstephan <jstephan@baylibre.com>
> Subject: Re: [PATCH] iio: adc: ad7606: remove frstdata check
>=20
>=20
> On Wed, 17 Apr 2024 09:11:18 +0000
> Guillaume Stols <gstols@baylibre.com> wrote:
>=20
> > Frstdata pin is set high during the first sample's transmission and
> > then set low.
> > This code chunk attempts to recover from an eventual glitch in the
> > clock by checking frstdata state after reading the first channel's samp=
le.
> > Currently, in serial mode, this check happens AFTER the 16th pulse,
> > and if frstdata is not set it resets the device and returns EINVAL.
> > According to the datasheet, "The FRSTDATA output returns to a logic
> > low following the 16th SCLK falling edge.", thus after the 16th pulse,
> > the check will always be true, and the driver will not work as expected=
.
> > Even if it was working, the usefulness of this check is limited, since
> > it would only detect a glitch on the first channel, but not on the
> > following ones, and the convst pulse will reset the communication
> > sequence at each new conversion.
> >
> > Signed-off-by: Guillaume Stols <gstols@baylibre.com>
>=20
> Michael, I'm sure you remember this well - it was only 13 years ago you w=
rote
> this...
>=20
> https://urldefense.com/v3/__https://lore.kernel.org/all/1296744691-24320-=
1-
> git-send-email-
> michael.hennerich@analog.com/__;!!A3Ni8CS0y2Y!9ozMtBwfPYIYOUVmrg1oq
> aTFP9BHcnV5_ENZ7u1U3TSBRbcCor2p4gzWA1lsyjxN2sjgNvG2a7n-RHA4lLY$
>=20
> Anyhow, I'd like an Ack or a statement of you have no idea any more and i
> should go with what Guillaume has worked out...

Thanks for pulling me in here.
This code was originally put in place for the parallel interface.
So please don't remove it completely, just disable it for SPI.

-Michael=20
>=20
> Jonathan
>=20
> > ---
> > This is the first commit of cleanup series. It will be followed by
> > more cleanups and support for more parts and features.
>=20
> Sounds good.
>=20
> > ---
> >  drivers/iio/adc/ad7606.c | 30 ------------------------------
> > drivers/iio/adc/ad7606.h |  3 ---
> >  2 files changed, 33 deletions(-)
> >
> > diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c index
> > 1928d9ae5bcf..f85eb0832703 100644
> > --- a/drivers/iio/adc/ad7606.c
> > +++ b/drivers/iio/adc/ad7606.c
> > @@ -88,31 +88,6 @@ static int ad7606_read_samples(struct ad7606_state
> > *st)  {
> >  	unsigned int num =3D st->chip_info->num_channels - 1;
> >  	u16 *data =3D st->data;
> > -	int ret;
> > -
> > -	/*
> > -	 * The frstdata signal is set to high while and after reading the sam=
ple
> > -	 * of the first channel and low for all other channels. This can be u=
sed
> > -	 * to check that the incoming data is correctly aligned. During norma=
l
> > -	 * operation the data should never become unaligned, but some glitch
> or
> > -	 * electrostatic discharge might cause an extra read or clock cycle.
> > -	 * Monitoring the frstdata signal allows to recover from such failure
> > -	 * situations.
> > -	 */
> > -
> > -	if (st->gpio_frstdata) {
> > -		ret =3D st->bops->read_block(st->dev, 1, data);
> > -		if (ret)
> > -			return ret;
> > -
> > -		if (!gpiod_get_value(st->gpio_frstdata)) {
> > -			ad7606_reset(st);
> > -			return -EIO;
> > -		}
> > -
> > -		data++;
> > -		num--;
> > -	}
> >
> >  	return st->bops->read_block(st->dev, num, data);  } @@ -450,11
> > +425,6 @@ static int ad7606_request_gpios(struct ad7606_state *st)
> >  	if (IS_ERR(st->gpio_standby))
> >  		return PTR_ERR(st->gpio_standby);
> >
> > -	st->gpio_frstdata =3D devm_gpiod_get_optional(dev, "adi,first-data",
> > -						    GPIOD_IN);
> > -	if (IS_ERR(st->gpio_frstdata))
> > -		return PTR_ERR(st->gpio_frstdata);
> > -
> >  	if (!st->chip_info->oversampling_num)
> >  		return 0;
> >
> > diff --git a/drivers/iio/adc/ad7606.h b/drivers/iio/adc/ad7606.h index
> > 0c6a88cc4695..eacb061de6f8 100644
> > --- a/drivers/iio/adc/ad7606.h
> > +++ b/drivers/iio/adc/ad7606.h
> > @@ -80,8 +80,6 @@ struct ad7606_chip_info {
> >   * @gpio_range		GPIO descriptor for range selection
> >   * @gpio_standby	GPIO descriptor for stand-by signal (STBY),
> >   *			controls power-down mode of device
> > - * @gpio_frstdata	GPIO descriptor for reading from device when data
> > - *			is being read on the first channel
> >   * @gpio_os		GPIO descriptors to control oversampling on the
> device
> >   * @complete		completion to indicate end of conversion
> >   * @trig		The IIO trigger associated with the device.
> > @@ -108,7 +106,6 @@ struct ad7606_state {
> >  	struct gpio_desc		*gpio_reset;
> >  	struct gpio_desc		*gpio_range;
> >  	struct gpio_desc		*gpio_standby;
> > -	struct gpio_desc		*gpio_frstdata;
> >  	struct gpio_descs		*gpio_os;
> >  	struct iio_trigger		*trig;
> >  	struct completion		completion;
> >
> > ---
> > base-commit: 62d3fb9dcc091ccdf25eb3b716e90e07e3ed861f
> > change-id: 20240416-cleanup-ad7606-161e2ed9818b
> >
> > Best regards,


