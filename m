Return-Path: <linux-kernel+bounces-166126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 171488B9694
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 10:37:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3ADE21C22079
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 08:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB31D46525;
	Thu,  2 May 2024 08:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="eURdxWXb"
Received: from mx0a-00549402.pphosted.com (mx0a-00549402.pphosted.com [205.220.166.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4610C1CD39;
	Thu,  2 May 2024 08:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714639015; cv=fail; b=LMLSepFTU4ML4WJ/D3R2JWo3CClpKk061CaqY5+nUhYz2kDVgxk5P584SgaJXxkbQzutPMBaCkjXh3cmeCZDfY31C38OJdKa1CiPw+QtM4BasPrzE2keO52yvNYyLwaR1X8GFDNJC7wYVk491VUXpK4lPj1IMWyHIi5rR1aU9Ic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714639015; c=relaxed/simple;
	bh=m0RDsPbL7gw8Rgevq9elI7oRE7GLZCRUjvgwXR/bzwY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lBwkG2F277yzAweHfZcynwKz/s9ECLCYC0mr1kHEY0zsfF8Z8nNyL+V5OsOmGR3y+lq08c60w7maUpLIPmbf8q8ERl2scnHbhNMyGSZV1Oh26xVS94Z9V8TOPY2BueSmlJePvApSkubi3kNhfYdowAm+kBYgY4zWCYm8DuPRA90=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=eURdxWXb; arc=fail smtp.client-ip=205.220.166.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233778.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4420NwSS008587;
	Thu, 2 May 2024 08:36:30 GMT
Received: from deu01-fr2-obe.outbound.protection.outlook.com (mail-fr2deu01lp2169.outbound.protection.outlook.com [104.47.11.169])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 3xrqr02yag-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 May 2024 08:36:29 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X8+yzy30UJvZcWLpybG30FBcLh9i1+yOxFi30ebk27lq9wEBKfmA/bRxy/OnsOhUESJWm28E70RffSFrAlXDB0Gu+bCQz20ZqTXG+bkNwqGty9r9Hw6p4Ft7WECTQAHvOFEFHomYzrQ88xVsMoXryA9OI6WQNPRDuNWAB5y7i0ZcSMOLinbS0iRnpBC6/aGYEDo4xgll7hy9wx1qaOYf7ZVz5wvbmnyGprXj+mqcUcjKqCDykPUm9WQoo59D9Kxlx+8hw8IjBSoFk6auR6ta3JqLD2u/KEIzcE06CuC62wTOcJrngZMqaClt37M00dEf7TXdae/UF2Y+VQtgbHehTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m0RDsPbL7gw8Rgevq9elI7oRE7GLZCRUjvgwXR/bzwY=;
 b=DSFhpxjlWdCE7ncPFVhy3SB1ftJ9gBI85MbW8cMgE/g3OGtei/7Z1EhbpbhE8zKA5RV2mglu1S0pVruFGh3sRmrPFWq2v8cZAKKRo/M003DII74m/TD4MW8klB5IrT3hEvXKqH+EkSvp0AGbWU9pL6S6eyl1cQQkT0El/lf4GrZGw1L/TeXMPNc4BYRNsVHXx7DOVaprK9X1omlRdoXo3ayQV+B5R3fh6QB8ozbK6749a7C4Gros7MNS/N1+uGUeCJZW5FhMt6sDA/8wxMzS7dKkum8HcRiy/m1SG8U2RAPY7b0tmTCGcQF7w1dra3XFs5lakAesBdlcRmDKROso2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m0RDsPbL7gw8Rgevq9elI7oRE7GLZCRUjvgwXR/bzwY=;
 b=eURdxWXblIAcTT+seho01Kg8y+l1i+r7HwZV8h3o+XvJERpJJ9Y5b27SF+XwGoJ6fVjLUnK5Az1FdLzrdRDyGW6nn/vU0aE/9FayDJCT1h1hjKk0C6VG2tRr6XZ6GVRlDh0zlD1/813vzM2nSR7cpHQiLQ7XxIK+BGffNt5RnRvZgplP9cpbbFKuW54uDed467OOFgrJVqc6RsPbb/ZXWNQwgXvCGadtr8KFILp/17sJ/iEB70NW8NUB42/doQMPlG/UYhSkuuR8JtDidymXxxHu4c39HBAKLMK6PHs3LNnhC1l7zjCYyQben81oU56Ra2TC/Z35R8+A1AzxAkoW4g==
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:7c::11)
 by FR2P281MB2427.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:3e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29; Thu, 2 May
 2024 08:36:24 +0000
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::ed6d:53c2:7987:ea18]) by FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::ed6d:53c2:7987:ea18%4]) with mapi id 15.20.7544.029; Thu, 2 May 2024
 08:36:23 +0000
From: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>,
        Jonathan Cameron
	<Jonathan.Cameron@Huawei.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the iio tree with the iio-fixes tree
Thread-Topic: linux-next: manual merge of the iio tree with the iio-fixes tree
Thread-Index: AQHamr1qADjaTYXDjkmslH5t3BNgw7GDnPeI
Date: Thu, 2 May 2024 08:36:21 +0000
Message-ID: 
 <FR3P281MB1757A0D3F821CF506D79634ECE182@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
References: <20240430151510.0f49b40e@canb.auug.org.au>
In-Reply-To: <20240430151510.0f49b40e@canb.auug.org.au>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR3P281MB1757:EE_|FR2P281MB2427:EE_
x-ms-office365-filtering-correlation-id: f9bcabe8-7d3c-4461-a30b-08dc6a82f1c7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: 
 =?iso-8859-1?Q?r5GtgtRQUkyboklAUVNePzsFSs7jmZtlBpI9PM+C7yLBx1QSHSIcCzHMiU?=
 =?iso-8859-1?Q?xCLqjiu0wHgp7dID1KtFzCrj62dg0Dul24oSIVZZuD8LzBSAzD7TCN242C?=
 =?iso-8859-1?Q?YtU/Lha1CPde1RSQvmNcjSE/g7YK7yTwpuFQKN+az77EidlZlGvEgSu/SD?=
 =?iso-8859-1?Q?4YNwl6JQG90dpZogT9N8x5nhWu+/Pb/lChjpKXh1OdtHhRhbLBbm7zGxsQ?=
 =?iso-8859-1?Q?EBoaopvPyQ7b99poDY7S4fLMQxs5fI63kNuclk0ng5JVwzBqRiy4CNHlyE?=
 =?iso-8859-1?Q?Pn+TA/mi/W6RNJIY+6cDTHnhOdenpN0Jis8gXL1chJciw7EmmhPazm0+ab?=
 =?iso-8859-1?Q?FjCjBsxyZQ5pR7r6oWSm/pqfEieddUz4dG3gxz5V7aIahQITTAM8tMfqLf?=
 =?iso-8859-1?Q?nLiR76+PJtkMDmTob1nA6EsyEmB4roP1D+T49mJl7oT8lrUQRscdYkR+sx?=
 =?iso-8859-1?Q?N+D8tcBmh+boGHolHkIQcczrOoaTtj1jVS7lo7UyY/PGgEpws1bVW03qOg?=
 =?iso-8859-1?Q?GcDanAGAKZ/7DDwmxik4ez+8U8dSzvtDsgjKKEpeRiIM3X8hSO6h1qpOhj?=
 =?iso-8859-1?Q?mwAfRnaBXTanAETQ7qfRdEHU9lhvBVG7MAMVwepUjITrkbhbs6lROT/J7E?=
 =?iso-8859-1?Q?18wavp85tfAKlkN3/lEsA5kD4chHKO8U8edsYWKgDTaVW/VYFj71MkLE2G?=
 =?iso-8859-1?Q?Nx/+LH0O7kM0KigslZz1WbtRni1LSGI4cICt98SBlWIQvWopoP0BD3oSJv?=
 =?iso-8859-1?Q?htKIF9aeKQaWnWsXe/EkmaOubS1ZBz7lu3kQl8SSLSfNHu23vkaiz3Rhlt?=
 =?iso-8859-1?Q?JB1HTUkvVMVCGiL3pud6pmuhkvrSA4BX5KFRBHlMhizIZxGNHrUtS32nLP?=
 =?iso-8859-1?Q?KvVUtz8c9TncCux2gyph2kSU4ftEI2cgp0BePZVYyl9UctP49IXLgKLtTu?=
 =?iso-8859-1?Q?kpD01fFrsMkfKah6XvscaQV3XgTYUKAneA7jvgqgNB1rNx2bNGAf+Rny2W?=
 =?iso-8859-1?Q?wRIFvQF4f4J1CUOTSy2n+kBaRPcpBvZShZ0MEBE3eOsTeAlFns00WvaRLB?=
 =?iso-8859-1?Q?qdZKKYJQTf/QJRjMb9/gWnVzRUrzr5CYuzQWu86ifOFzROQ7IRkyyCT85a?=
 =?iso-8859-1?Q?mjkL6Bc+P9Qdae6NdWIfs7ykq4NmVMho82k8cB3LwNLYYrp/KFKWknK+IA?=
 =?iso-8859-1?Q?iZ9/JyBkENlD5GM0IbiMv5XWyObGO7qe3LnMuwsGdSx4A+7t6XmcuFnTgz?=
 =?iso-8859-1?Q?K4x9s1TKao6AYIFN9ZNLC1CAjwWe5KYgs6PQRBzjsGPSTKuw4AKXd75Hiw?=
 =?iso-8859-1?Q?begdsWu4ZiGZfq0Fn0ZCCWao3frsflnFXlbto3+JSsIBdl3m5xeoE/T7a4?=
 =?iso-8859-1?Q?M5qn//VRgRkUuqviEN/BqyfsOPQKd/hw=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?Nv7tHf7rQU//IwyCMqFWk24b3iEb0XWTIU8GHUyCxAlCf0sU8PqFv89grZ?=
 =?iso-8859-1?Q?osDtOEa9jTIinqhufMt39TdfAWA0eySJ2yvjfUR+bjJQsDoNb2hbnK3/zS?=
 =?iso-8859-1?Q?RitKeujhwL+QvKgL8wM4RzG3kKakNARkjZ54xlKVEpXeeHLKFAUTZJYuz8?=
 =?iso-8859-1?Q?cG7JO//IpsEIo4wL02ZtYjr3E3XqdsqKnV3n29Pfqb9qRD7d8R4wgBwkno?=
 =?iso-8859-1?Q?LGK3MJn0hqaz9uPBt0jcgNa/Iwp78pg++IIVR1Rjyaj5ybv985zYVOB9ny?=
 =?iso-8859-1?Q?S8dlR3xTYEaHJEs94mtKZtf4jDxX0dgGjP8k95W7MoALAqmziBCkwQs1Ln?=
 =?iso-8859-1?Q?Yodpx4l6nB8bBxhxevoX+OGrKF+f+I/+HEaHy66FznH0sWVIvXc0l4pYoD?=
 =?iso-8859-1?Q?hjx6tDDF15sh1ss1yHknei3irmKKX4sQ5vULe6pUso/ssgwdIawexLTP2+?=
 =?iso-8859-1?Q?Q1DBp97am8mwqPSfo4vw7tCCd10OdPL4QhwVJHerr3pxaXV++iXLRN8AYT?=
 =?iso-8859-1?Q?yLBRo1n/bDbx1kvDlXw6SqNwLzBBERGinWxDaKBqhe8IVLKBRfSJgAzSnR?=
 =?iso-8859-1?Q?8OM5tSRDri8GzGEWbSUsmZyfOeS/BuvMk7MmcsyzKYlqjQPQg4X/s5q9B1?=
 =?iso-8859-1?Q?1aJJ5xoyYvRCFDHIlrmtUJSrdL5HIYJt1gFC4t+iRSg9uSk++0XKvOI9J8?=
 =?iso-8859-1?Q?FPTug6/JWTGD1nU0Nx8m3OIslgMBWNicu3cf6vhNvx9Oj+d3QZJGSChiX7?=
 =?iso-8859-1?Q?sMU1InLr5YBRCYBYY/9yZos/cbfrHQamGJ4ITrXRcp1OdThw0CabbTywv4?=
 =?iso-8859-1?Q?+5Bwol08w1U9LiADIVN1iUN/Xwxqb7/PGCxAYZ9odeedfqQhdqSWOp4uuR?=
 =?iso-8859-1?Q?eB/KqghVVcJAuBfu+zrNlvz4k6BpijXJHUR4ukpPo2crYeXnQzeZOWfiBn?=
 =?iso-8859-1?Q?TlV2cg2wbWFGOquPW7BmFDltOIil5tlmgthrmlTqJAHGaQ7MXCESPVmceU?=
 =?iso-8859-1?Q?iwOSQT5/om9VfI/5Y5CeaqqldaWSOyMj5C5Pfj5DhfdL5RltBzUfyiy7gN?=
 =?iso-8859-1?Q?hQMuW4e9H5krPy3tiMTRqv59QAvhePJ2xWLQyqUDXfy1BEl0bkkWYqqhZo?=
 =?iso-8859-1?Q?iacnyRXWxxgB92SmjDPz/DzE38ef/jXWtJcO60Hhlxi1bENyphs6b7fTKR?=
 =?iso-8859-1?Q?BDZBO4RlcfKjBGicveArgr8gWRq8oyHz+RQYq9DYcKEv4/XEuKXKDASwc1?=
 =?iso-8859-1?Q?xx3HEevBuSeAF0rPKBIwr30AdLyybfBecjYx1ccM9V6a5aL63MCzkzMEfz?=
 =?iso-8859-1?Q?yRdD0k2KEIOl5RFOa1TyFlU3NnMhDryVMcLC6ZWTkjY/2slgJ9+hs8T7mg?=
 =?iso-8859-1?Q?cibjGYNofdN2+aFWUJvv03VQ92mFvLP7P/J/Gq8mFVCv5Wm77cDxGFnk71?=
 =?iso-8859-1?Q?p0RBzoFi2Qea3kGN9IxeoOOe7J6Ptaj+i/1k3vDiQf+QK+ED40NUC8O0nv?=
 =?iso-8859-1?Q?XR3zYb5wG03D6FpmtQkVPHHR0GHpbxpLSo83MO9D7FJDOZq8ngi/xpplNt?=
 =?iso-8859-1?Q?R+miAI0swtWbanXeCeVYcHcbc9wQpLsf2c9Y8XonfWGJq8HS6do+RnylDf?=
 =?iso-8859-1?Q?Eu5IbRG/j7c/Zb0B4rzirYCyeFWhb63tUkOXLpbnJRyecpoTfJJQceFw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f9bcabe8-7d3c-4461-a30b-08dc6a82f1c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2024 08:36:21.3961
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ks3NSxvHdOI0NSZOMPo42XF7IJdON3wkWJhUCU7M0opv8vWpfRGlkdyTgKCmNTbsDkFsodjWLSPzMSw66OcB0Twk/c6tU9Ju/T5S6yhERlc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR2P281MB2427
X-Proofpoint-ORIG-GUID: V-L_ge-uBzwqm7hYpcjOJwRGR_vCHD11
X-Proofpoint-GUID: V-L_ge-uBzwqm7hYpcjOJwRGR_vCHD11
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-01_16,2024-05-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1011 lowpriorityscore=0
 impostorscore=0 suspectscore=0 mlxscore=0 malwarescore=0 spamscore=0
 mlxlogscore=999 phishscore=0 priorityscore=1501 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2405020051

Hello Stephen and Jonathan,=0A=
=0A=
sorry for the mess, I should have warned Jonathan about it.=0A=
=0A=
The manual fix is obviously correct, no problem.=0A=
=0A=
Thanks and sorry for the inconvenience,=0A=
JB=0A=
=0A=
=0A=
________________________________________=0A=
From:=A0Stephen Rothwell=0A=
Sent:=A0Tuesday, April 30, 2024 07:15=0A=
To:=A0Jonathan Cameron=0A=
Cc:=A0Jean-Baptiste Maneyrol; Linux Kernel Mailing List; Linux Next Mailing=
 List=0A=
Subject:=A0linux-next: manual merge of the iio tree with the iio-fixes tree=
=0A=
=0A=
=0A=
Hi all,=0A=
=0A=
=0A=
=0A=
Today's linux-next merge of the iio tree got a conflict in:=0A=
=0A=
=0A=
=0A=
=A0 drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c=0A=
=0A=
=0A=
=0A=
between commit:=0A=
=0A=
=0A=
=0A=
=A0 d7230b995246 ("iio: invensense: fix timestamp glitches when switching f=
requency")=0A=
=0A=
=0A=
=0A=
from the iio-fixes tree and commit:=0A=
=0A=
=0A=
=0A=
=A0 a1432b5b4f4c ("iio: imu: inv_icm42600: add support of ICM-42686-P")=0A=
=0A=
=0A=
=0A=
from the iio tree.=0A=
=0A=
=0A=
=0A=
I fixed it up (see below) and can carry the fix as necessary. This=0A=
=0A=
is now fixed as far as linux-next is concerned, but any non trivial=0A=
=0A=
conflicts should be mentioned to your upstream maintainer when your tree=0A=
=0A=
is submitted for merging.=A0 You may also want to consider cooperating=0A=
=0A=
with the maintainer of the conflicting tree to minimise any particularly=0A=
=0A=
complex conflicts.=0A=
=0A=
=0A=
=0A=
--=0A=
=0A=
Cheers,=0A=
=0A=
Stephen Rothwell=0A=
=0A=
=0A=
=0A=
diff --cc drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c=0A=
=0A=
index 9cde9a9337ad,cfb4a41ab7c1..000000000000=0A=
=0A=
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c=0A=
=0A=
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c=0A=
=0A=
@@@ -509,20 -512,20 +512,20 @@@ int inv_icm42600_buffer_fifo_parse(stru=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return 0;=0A=
=0A=
=A0=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 /* handle gyroscope timestamp and FIFO data parsin=
g */=0A=
=0A=
=A0-=A0=A0=A0=A0=A0=A0 ts =3D &gyro_st->ts;=0A=
=0A=
=A0-=A0=A0=A0=A0=A0=A0 inv_sensors_timestamp_interrupt(ts, st->fifo.period,=
 st->fifo.nb.total,=0A=
=0A=
=A0-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 st->fifo.nb.gyro, st->timesta=
mp.gyro);=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 if (st->fifo.nb.gyro > 0) {=0A=
=0A=
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ts =3D iio_priv(st->indio_gy=
ro);=0A=
=0A=
++=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ts =3D &gyro_st->ts;=0A=
=0A=
=A0+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 inv_sensors_timestamp_interr=
upt(ts, st->fifo.nb.gyro,=0A=
=0A=
=A0+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 st->t=
imestamp.gyro);=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D inv_icm42600_gyro_=
parse_fifo(st->indio_gyro);=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (ret)=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 re=
turn ret;=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 }=0A=
=0A=
=A0=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 /* handle accelerometer timestamp and FIFO data pa=
rsing */=0A=
=0A=
=A0-=A0=A0=A0=A0=A0=A0 ts =3D &accel_st->ts;=0A=
=0A=
=A0-=A0=A0=A0=A0=A0=A0 inv_sensors_timestamp_interrupt(ts, st->fifo.period,=
 st->fifo.nb.total,=0A=
=0A=
=A0-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 st->fifo.nb.accel, st->timest=
amp.accel);=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 if (st->fifo.nb.accel > 0) {=0A=
=0A=
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ts =3D iio_priv(st->indio_ac=
cel);=0A=
=0A=
++=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ts =3D &accel_st->ts;=0A=
=0A=
=A0+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 inv_sensors_timestamp_interr=
upt(ts, st->fifo.nb.accel,=0A=
=0A=
=A0+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 st->t=
imestamp.accel);=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D inv_icm42600_accel=
_parse_fifo(st->indio_accel);=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (ret)=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 re=
turn ret;=0A=
=0A=
@@@ -549,16 -554,20 +554,16 @@@ int inv_icm42600_buffer_hwfifo_flush(st=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return 0;=0A=
=0A=
=A0=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 if (st->fifo.nb.gyro > 0) {=0A=
=0A=
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ts =3D iio_priv(st->indio_gy=
ro);=0A=
=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ts =3D &gyro_st->ts;=0A=
=0A=
=A0-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 inv_sensors_timestamp_interr=
upt(ts, st->fifo.period,=0A=
=0A=
=A0-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 st->f=
ifo.nb.total, st->fifo.nb.gyro,=0A=
=0A=
=A0-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 gyro_=
ts);=0A=
=0A=
=A0+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 inv_sensors_timestamp_interr=
upt(ts, st->fifo.nb.gyro, gyro_ts);=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D inv_icm42600_gyro_=
parse_fifo(st->indio_gyro);=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (ret)=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 re=
turn ret;=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 }=0A=
=0A=
=A0=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 if (st->fifo.nb.accel > 0) {=0A=
=0A=
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ts =3D iio_priv(st->indio_ac=
cel);=0A=
=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ts =3D &accel_st->ts;=0A=
=0A=
=A0-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 inv_sensors_timestamp_interr=
upt(ts, st->fifo.period,=0A=
=0A=
=A0-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 st->f=
ifo.nb.total, st->fifo.nb.accel,=0A=
=0A=
=A0-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 accel=
_ts);=0A=
=0A=
=A0+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 inv_sensors_timestamp_interr=
upt(ts, st->fifo.nb.accel, accel_ts);=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D inv_icm42600_accel=
_parse_fifo(st->indio_accel);=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (ret)=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 re=
turn ret;=0A=
=0A=

