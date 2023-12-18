Return-Path: <linux-kernel+bounces-2994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 144D58165B5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 05:41:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A128D2822FD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 04:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B758A6FA2;
	Mon, 18 Dec 2023 04:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PzcfqPTt"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2046.outbound.protection.outlook.com [40.107.244.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A125C6ADC
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 04:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SAVeSwvoJodtSZ8yxAFR8Nv9lwRr2g5LUCSC6Myh7dFRLN0Lq0xv+PL8czjwW2T0OJ8OqeLKWju8ts7IXqMzCq1+mFT+z+s0+plumsuclsUZN4OVJ885lo8E552t2poOjEL5yJ7yL11tzkSJKuj8lgd1bH+q/y+e3nrxLZz+kvTktoSxB9do1MitgJX8wyTjCx87nQdIoielE46zoRb+Rxhe/HRl3/ZOeNqG1icKF4ZhyBDZNSY1nwWhLfSJ6iRkGIPmZ/ZY+HmWCtDIEQDO00s8a2E6UGTcTGBpp5wxFdMGFO4WiaKq+9B8mJsgGdsVf0IpkLj6JQh5AB1KYiVN4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j21ZTaaLJZdj8ieHrCFzFRXU/MpYu7Amy5pbvoA8h5M=;
 b=gK7gfPGdlyKEpCoSnmn5Jf1GXrn8s11Y0yUuga5eujKwvsN8xT3tDqrF/79Q7Ne+zoH+ltVxjGfNohvFpyr8QXzDNpATlpHwgXtb032d4yLqyPzr5VrqqzDhq+xy8C/vhb5NIpTZRK2JoAHopnAPybkSr1H5Bpj7YeYDAkYLTvOJy78zMWITNWx1j/xREXizfWAkj2l8DY8oJzXPaMVCxwDh9tmyXMS6/9ZqYnNDrPGTDYnrQVFAYTRnkxrYnRed/DbFrNi5v3ekhDbfqDihTPNoiDnewAIwnPi8ErW4RxeDLOglNVSItEKMOkBFLPdDgBKJjxhxuuAN88qAtNx97A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j21ZTaaLJZdj8ieHrCFzFRXU/MpYu7Amy5pbvoA8h5M=;
 b=PzcfqPTttqPc0Z+nxUtSoSKPqHcHjhbvNCz5tM5VzrSHphvBuq27YneUYEJat3Oj7dibqqaPjNqI1+u7vh6ucgX0R943hrP6F3TFYI6z5vIWMPWGLQNJ0CInClEpoHYsXrOrPre0U+8/zlZTctTolvIDaeoh52BU+n8Gs4cMhJQ=
Received: from BL1PR12MB5333.namprd12.prod.outlook.com (2603:10b6:208:31f::11)
 by DM4PR12MB7526.namprd12.prod.outlook.com (2603:10b6:8:112::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.37; Mon, 18 Dec
 2023 04:40:49 +0000
Received: from BL1PR12MB5333.namprd12.prod.outlook.com
 ([fe80::783c:98fc:819f:9c7d]) by BL1PR12MB5333.namprd12.prod.outlook.com
 ([fe80::783c:98fc:819f:9c7d%7]) with mapi id 15.20.7091.034; Mon, 18 Dec 2023
 04:40:49 +0000
From: "Agarwal, Nikhil" <nikhil.agarwal@amd.com>
To: Rob Herring <robh@kernel.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, "Gupta, Nipun" <Nipun.Gupta@amd.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Gangurde,
 Abhijit" <abhijit.gangurde@amd.com>
Subject: RE: [PATCH 1/2] cdx: Enable COMPILE_TEST
Thread-Topic: [PATCH 1/2] cdx: Enable COMPILE_TEST
Thread-Index: AQHaKSrfK397vJpt0UG67Mqdeevb4rCuhjkQ
Date: Mon, 18 Dec 2023 04:40:49 +0000
Message-ID:
 <BL1PR12MB53338735ECDCDC067DA689249D90A@BL1PR12MB5333.namprd12.prod.outlook.com>
References: <20231207163128.2707993-1-robh@kernel.org>
In-Reply-To: <20231207163128.2707993-1-robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_ActionId=11da4fc4-8f15-4fb9-9aad-9df2a66a9646;MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_ContentBits=0;MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_Enabled=true;MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_Method=Privileged;MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_Name=Non-Business-AIP
 2.0;MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_SetDate=2023-12-18T04:40:21Z;MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5333:EE_|DM4PR12MB7526:EE_
x-ms-office365-filtering-correlation-id: 56357ce4-1c97-4df2-b452-08dbff83825b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 /TWbKMk5ejiFIhD66+tq6JOcVeIGKTTopzX8dxIEMXO42gdqGVwm3Vu6iOu+jmnOMpQQTxlCbPtVlmwKbYp0zn9GZ1SykBpazhmdJZ8AicDa2zn6gilm+14iGvFUG5zTrgro7O28VbSJO1eWwNvQR85NqDPRsAoQC8j9xke6UCBJTQti94Jf/m34gskFkOUPPdhSELNvRviXa/y6wTu94wacFz3kSbCiPu2mh+Pp68xsHMBlYhcox7bHe2xYXYPqNqO2VpXHsg9HXFzLBlrqsAjV5wZpbyVm/BS884wDLTibKvOkuuKqlcMFje/aKo5HZKoGzN+dZaHPca38ms1o9V7lmrbrRaja0Nk3O7Ih8ACK16hVMJ4b2eK5a2vdrFFAaXZ4vPnqujWyi0ZA1tVp0yEBqQL9iKw1VJiR4TTi5w/xtSX/G9UeoeOW/nmGMellwCBP/fNVRMveI7GHCEFs/o0D25JlFqVXkhfI2OxKgIiwrbP+kWbmxO8jF0U4t+wglVJ2LEXE7uHpfXn+hBGkxSeGQANE2qpyefN8/sUeZBvqXalHsfeMm+EmI0zr4/q9YN1JCZQ+k2Xae9WAmIw2FY8GtlyeEF4CEJX1ond6pTGgVKhfo/u9SCa6FeOgLuB5
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5333.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(346002)(39860400002)(376002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(55016003)(38070700009)(76116006)(110136005)(86362001)(33656002)(38100700002)(122000001)(83380400001)(66946007)(26005)(53546011)(71200400001)(316002)(478600001)(2906002)(66556008)(66476007)(66446008)(64756008)(54906003)(6636002)(9686003)(7696005)(6506007)(8936002)(8676002)(5660300002)(4326008)(4744005)(41300700001)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?wd9wEQwNY114sWiSD3mjSDCn83SZcYUeNUZBqlw/XxBJDlsXpDLelLdI08hp?=
 =?us-ascii?Q?nDnEumoHv5CzNQL3jjaFwALNoOPuHhtpaIPi/I9c1gBhVxyZmV3WttjgTNf+?=
 =?us-ascii?Q?TBoIwXYz5i1XXFAS7CjdoKdVLij5I89yn5DJbDjV2rr/yTfkZkcAyY5iRuc7?=
 =?us-ascii?Q?heteKmtHGhv0t8LBfFaUmU3qlsu0WEqDMaezMPf+2/NE4IAaZJjamfwfbgae?=
 =?us-ascii?Q?tVbq0/itHZL1DsUwlS7zBrR6oYJjvYzw3X7Doxbg4M3g93gGYIbqKKFbhBku?=
 =?us-ascii?Q?s/8z1LKfrZhGp9Vdmhbls6o1O1Wv8LUz0TjsqARunR09r+TwhGip2jwKGuqA?=
 =?us-ascii?Q?Lnvx4QOI5f6DE9rS1UontNKyMyYxb+fMnU4J43EiGQiOJfzUU2Ds9E8yLkDb?=
 =?us-ascii?Q?epVdvmLw4pYFW8KeLZ0n3vE4zy8WRBxUXdxsTm9QdxvkFWyq3zY0hqDdrcNe?=
 =?us-ascii?Q?nZwsIA8F1QamXEWRi4aOgVd3WkiMAlqSgcPtllGaco5pOQM47qU90I44LJQc?=
 =?us-ascii?Q?+BfiRyXPS7CNcw6J1CozcbZM0fC3tBZkpVldBh8aqCgn+r9QYzWfNBXS2G8o?=
 =?us-ascii?Q?xHSOSKhTLDvKCfsp3XQjF+uWBBSqCtydbMlqJcANFwYQuCTbUimxxK7IPRPm?=
 =?us-ascii?Q?NKT4y6xuXSq0uXFP51V9tMwJYSAJ7qgy3z7ayECUWF0FTNG3QVXn2FDMtQry?=
 =?us-ascii?Q?cPFJVW2lJQraDg541ZLMjdb2JdSeRU+Rf9UkiJRnjFx5cAZqsCQTLkIA2W0p?=
 =?us-ascii?Q?YDU5Rkdg9a3XOptC1o6bPexWYV06brq19sA6zzKlwEY8aPooeaL0xaUk4JqX?=
 =?us-ascii?Q?upw+cYMnnqKkTrisGXJZ2xIJGeI4yUldt1+NB4H/Skh8D1ZrD6V1CkHVEKYN?=
 =?us-ascii?Q?ZIR4iRdI7sU7DETcrYd2myJLktUW8TYwcVglo+uMzYz64GGqTWyp617l2+Za?=
 =?us-ascii?Q?0W9LeLNkkt3VCTb5eUTRRy4B8HkQjI8DcqEdSadreepyHQJqLa+sgP2vuMIp?=
 =?us-ascii?Q?Dw//05o+Le3HT/NvJfrP/bwMqHXzMslptpsMWUMC/pTX8kQm5OUE40wJ7PAd?=
 =?us-ascii?Q?Gd5l6c01BjtBMUctSFmV9tGEpVcpZYYHTmwNrt09t70dZ7GvaDBuSti/BQrv?=
 =?us-ascii?Q?bisKI87LsrwenlZboEE1hg0cBHc0JM0UiJAbpZ62YVybqeZevlaHDmqprEeZ?=
 =?us-ascii?Q?nqQMib4SbqWKquzzYRM5jWtkJveZgWl3mUNmwMXkZNsQY22E/5B+M5J7zbpF?=
 =?us-ascii?Q?KCN686xP7wjlKQs2nfhGdKRnoBni7LmqxKbZ9yssREkGfxrjhofiXQrdyE0T?=
 =?us-ascii?Q?lId3omfIYlylkRBV7TljgUxTdlHjVr7R5gXPJTCnpvHKKwzqjUaoKPRfHfIH?=
 =?us-ascii?Q?yDP/GOdWSGHxhGkMmGvjEZ7QmLi/vcrau3HPbwSsgFMH9AHL4F2tWbj3rA4Q?=
 =?us-ascii?Q?RalGNCYFaM8197IRiy+EFLeNHLWhYOREAnAo/Nx6hD4I7JOgHcT3J8efbRII?=
 =?us-ascii?Q?oE4uK/7JsKXAmmzXFL5EDTTWLrifPUXCDE8sv9fBouFZKGtM7FEUegtkFqcp?=
 =?us-ascii?Q?pLgr00LbiMdhiww/I8o=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5333.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56357ce4-1c97-4df2-b452-08dbff83825b
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2023 04:40:49.5498
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b86OUDar4Bp3MKlMv0Qf820e1Y+wX7+b8XNWk0N7PghzBGoCpji57y9h4YeQWfn2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7526

> -----Original Message-----
> From: Rob Herring <robh@kernel.org>
> Sent: Thursday, December 7, 2023 10:01 PM
> To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>; Gupta, Nipun
> <Nipun.Gupta@amd.com>; Agarwal, Nikhil <nikhil.agarwal@amd.com>
> Cc: linux-kernel@vger.kernel.org
> Subject: [PATCH 1/2] cdx: Enable COMPILE_TEST
>=20
> There is no reason CDX needs to depend on ARM64 other than limiting
> visibility. So let's also enable building with COMPILE_TEST.
>=20
> The CONFIG_OF dependency is redundant as ARM64 always enables it and all
> the DT functions have empty stubs.
>=20
> Signed-off-by: Rob Herring <robh@kernel.org>

Acked-by: Nikhil Agarwal <Nikhil.agarwal@amd.com>

