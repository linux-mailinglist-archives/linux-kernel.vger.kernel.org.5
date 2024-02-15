Return-Path: <linux-kernel+bounces-66428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DD41855C93
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 09:36:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A22C91C2A096
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 08:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A77FB16415;
	Thu, 15 Feb 2024 08:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="hba4VDdp";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="ISTFAcTd"
Received: from mx0a-0014ca01.pphosted.com (mx0b-0014ca01.pphosted.com [208.86.201.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B330E125B6;
	Thu, 15 Feb 2024 08:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=208.86.201.193
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707986152; cv=fail; b=AER3lvJCazcj3bOXAqMZhDPefKhsyPsIfwhv2d+HVsGFEBF9LI1xY6p+3XbGxPZyUI7efIxMvqq/R1tL+saQa2BMClYzyQ9PzPsTCyjxxW/ZNQ9wxB+lGdQSpCrW63YbhqsUtc+R1BfyH4M/B7774RHFxz5DlP+ea/cekj7LxHc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707986152; c=relaxed/simple;
	bh=dDJH1/WkPgHdJZtXPyH4FxfAVZSgafoYXOEYPvq8tM0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nOM9yTuFgXMr+FtcgrOPavxz8QqA+ipnE+cOcYm0ebUFU3YFXpNcsD1pie++qXVkqa8MxVNIFVrDwl4g8Z9ZwXnaOBOh8c/742Ub6WG4L+pgMZfvO+R5qSiz0ICU1KlT+CWmGReFidJDBlTX6NQ1jSt81Ou66WEKq34B5WWc/Wg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cadence.com; spf=pass smtp.mailfrom=cadence.com; dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b=hba4VDdp; dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b=ISTFAcTd; arc=fail smtp.client-ip=208.86.201.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cadence.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cadence.com
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
	by mx0b-0014ca01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41F7SmW7024206;
	Wed, 14 Feb 2024 23:36:03 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	proofpoint; bh=CF8Ryloa3SJivFxF+Kmcgdn18UtsWbaO0qH0UHqsRD8=; b=h
	ba4VDdpv38oPjGhybYZYXWR1Ubr11Tf7RlYPJPZFBYZ6/80ys7Nq6WCS3dhlagll
	bmg/EN27jIUDNR01tn0/PHQRPHIXjIzUIlqgNYcEcuYjIikTrqSe5YuzVfBW7njG
	BSJI/EwA2FQ2L8/4lto6sOlhGrM/s3RLUAAnAm9il6N1jjkcmQ6i5C+GNtm3mMr+
	H8wtRHxXHMz1Fui+nR+ak7hwANdIcp9PBYgTCgtG/u+OCfO9lO1ZyqY7pXpTbdgL
	GDcw8/nnZksLA6Em1S/S71O1wXoTRUZOdzORMQL4UDE4cFFS2LbJsjNUvMXd4x2V
	JSqlZdav9F4RnC6f9R8bQ==
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by mx0b-0014ca01.pphosted.com (PPS) with ESMTPS id 3w9axpgj3b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Feb 2024 23:36:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kK8wAliIoaIzOyKUlfyE8tGpMUkIgWLk04/wpObe7TNeQa4UWJfvnjcgI9h+UvkBNBs6XXUVa9UvDkuYGT9Z2v+ibjnov1xcKFQIi9WVBhuVchwFdNwyOeryhqwLCcCbNRXoooIxEAIq6knSRT7WvNJ98O5M7bEZiVNoSJF5DizNvGLzhtKXSLMvG2WTciI/Ne0QjknNrkJ0ZfIuwsBkXZJNeRXw4L9oJ7BWy48vzmBiZ+Y59Oq6zhPdZ9gNCYtw0H7GSA/MMZkHU6FkcWyA4UOAHqdyAx4fUKwhrgn8iRFIGQEhadzbwZQuhGuClSFmsUXUyXZFdH4GyKKkOdEo4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CF8Ryloa3SJivFxF+Kmcgdn18UtsWbaO0qH0UHqsRD8=;
 b=XLGfnGp4Ynpt7rIbgZaRWbpv/DbpJAxL/zh8yDpLLd3Dd/XBH14F5A62BT8pYlvgg7/Q1Civ1ZccSc62R3ttD9QmEKVf3DXm4lsgb1HirJXipoerU554p1lLPh0RlqBdYt+42cL1WD5AurvUmKzfjJ+ykeAso3T/9SGXXJiTDx97kC5xV2NF76Xdgbo2EdzxXHMkJjpYdgVDNxB5DLc6dGI0NSt7I728d606dU8+XqaGzpC0ciBc/J5ZaciwpZK4aMVhg6Dm6xRfqKlVGTupKhOMBP4GEODQpU5g7PZOV9gnzMAFlt+h0aPfqVgM8oODbrA6VrJZyOGZDl58AMFIRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CF8Ryloa3SJivFxF+Kmcgdn18UtsWbaO0qH0UHqsRD8=;
 b=ISTFAcTd2V1aDdvN+AiTSqIwoN5+pYro32TqrEG5n60Xt2uAgyif8ZPW3GnthFSATHyLIGkoxt7d07rKgoQUnX73ygOyTwndsdXs/UVQ4eyi1ZQLhVf974MGva2Dtn1cTAsfuRB/cxBmtJEzXfqsJvP3n70kIB/GGGkgMx9fL7k=
Received: from BYAPR07MB5381.namprd07.prod.outlook.com (2603:10b6:a03:6d::24)
 by SJ0PR07MB9767.namprd07.prod.outlook.com (2603:10b6:a03:4e8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Thu, 15 Feb
 2024 07:36:01 +0000
Received: from BYAPR07MB5381.namprd07.prod.outlook.com
 ([fe80::8b86:19bf:6f8e:7489]) by BYAPR07MB5381.namprd07.prod.outlook.com
 ([fe80::8b86:19bf:6f8e:7489%5]) with mapi id 15.20.7270.036; Thu, 15 Feb 2024
 07:36:01 +0000
From: Pawel Laszczak <pawell@cadence.com>
To: Peter Chen <peter.chen@kernel.org>
CC: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] usb: cdnsp: blocked some cdns3 specific code
Thread-Topic: [PATCH] usb: cdnsp: blocked some cdns3 specific code
Thread-Index: AQHaX9+mxT8jO+heF0CzIFXGRuFRqLELAfOg
Date: Thu, 15 Feb 2024 07:36:01 +0000
Message-ID: 
 <BYAPR07MB5381ACBD4E6CAF76D86DB10FDD4D2@BYAPR07MB5381.namprd07.prod.outlook.com>
References: <20240215072138.GB1256251@nchen-desktop>
In-Reply-To: <20240215072138.GB1256251@nchen-desktop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: 
 PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctZGFlYTcxYTItY2JkNC0xMWVlLWE4OGYtMDBiZTQzMTQxNTFlXGFtZS10ZXN0XGRhZWE3MWE0LWNiZDQtMTFlZS1hODhmLTAwYmU0MzE0MTUxZWJvZHkudHh0IiBzej0iNTI2NCIgdD0iMTMzNTI0NTYxNTcxNDgzOTAxIiBoPSI2NjRvQU96cXhTYkJZR2JOTnR0SEpKcFdaSGs9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR07MB5381:EE_|SJ0PR07MB9767:EE_
x-ms-office365-filtering-correlation-id: c32faf29-c083-4f48-f1f2-08dc2df8c225
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 zYtgGe/y0dMDpOu4LUxN90hnE0fM2S3rdq1BeAjBk1MarxHme1ijpSQpCwS+gOagFVrM4iNH9cMNBGPUcZNcq2+Lb0VyxTad1EfXzoeD6kvCZzP4eyjvvDD4ReE88kLB1xMh42jqq6Qmxti1znX/Wya1aeC2CekHsdSfr27bwLbcaaSYVujbgw/to0S9M4qdoXY+ME0qAzGnMVGles8kZnQUvpgz0ssocPRfQoNm3RdzssymaNmwtHRDP2GSPaMBZ2WT2QKeHD9RSEdUVAysnrx3/iXZwi2lIo0h+bRBa0OfNK4k/77/l2pm5XClgj9VZjxOVVy0fMYMiwOsD4PnOeBusKlGxddrdgxLNKqJHDc+o2xrrlHEAGL2ILW1yAGAAVFcbHBFJV1Y7+ZKExKdi1gAsliT96lBeK+7BSpaGo6LN85Q1KbFDRGMQqrb2OebIOWtxnrFuwSyaxi2fCYWaULVzfTX5+oHAs0OfQVGOvLPrO5AO+YkIIbMH6rs5qSFP8Uo87+Dt/ScgYMVLAU/dts7BRbEp5ev3+fgoeDjbChEn1PUQKQ9hCPrQKjZd7WpCIIP70SzbbhX6bZpaFOdf6shhn5KGHQg/n4NcAqXF5XG8WOTVXFpVuxiauOiLDJO
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR07MB5381.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(346002)(366004)(39860400002)(376002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(2906002)(52536014)(15650500001)(66476007)(6916009)(76116006)(33656002)(64756008)(38100700002)(122000001)(66556008)(66446008)(4326008)(66946007)(8676002)(8936002)(5660300002)(38070700009)(41300700001)(86362001)(83380400001)(6506007)(316002)(26005)(7696005)(9686003)(54906003)(478600001)(71200400001)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?N7t0immPev90OAOb66iOvMbHRlRd9MRuY4d2ZJfqwto7tqpCBs+AUL7M7RGa?=
 =?us-ascii?Q?wJsyH6VTVN8CCkxVgAvQyALVJIeSWNyYXPlvDCdeXadsdL/OhTRRCaDSfxKN?=
 =?us-ascii?Q?cn6bUeJr+fRyBqq0UEQaJcw7xlDow7tmK4SjFYbSUbQ6/g+9+zPMsVpyoJkZ?=
 =?us-ascii?Q?jM8AjJrE1NgMhgPOzMPFudPThkLE2UQTGIO017NUyd6hihyMGJcLVfA7rZUd?=
 =?us-ascii?Q?BhW2x+shu6ipaWAo/Es/sGHohNyPNDJ/WY7ckDpp7ce8HNQyzN+ktC2DDmcp?=
 =?us-ascii?Q?g+Y6e9LnJbNlm2e8gmQ8g1DVC2ZiDPcOTmA8vfSRCSME/oz5wi8cYp+FFm2N?=
 =?us-ascii?Q?6k65yI+VXo8mYTJk44iWWbcTDw6H9ZUC2Ig+JO/yqczEaTv5aOQuIXb1HKm5?=
 =?us-ascii?Q?rxPsq7bIlYEz9VKc1RzVlfkDu7FogxeEO1QFHNjdDM2bpXeT0tv2n4PK8eAj?=
 =?us-ascii?Q?0z6AXeZLl1ZKFtCBRZ4r45KgBdiUenvpEIShsuvsRGUET8N12fvIAKhd+17Y?=
 =?us-ascii?Q?pVB8YWnHmFeaSklRiYFRdfVGycrZUFlpes8+gKG/sEBWk44HUcU/XUPFEhuz?=
 =?us-ascii?Q?lSkqKuZiVMe519Yc05/dV/UQvx+TV9D97uE7fKtxtXmXGXWTOMBgl6jJZ9Sk?=
 =?us-ascii?Q?MFXO+fPsEUw1ABpJ+95TsV+57CYT33rluEHHWe++3geQU3l62MJcxXJ8Wx3p?=
 =?us-ascii?Q?w6dLMyfD7U62Tip3HofeSDLTIyyVLh+296qN4ZaLDqughrsgS0mzjthKLTDC?=
 =?us-ascii?Q?73EYaMu9Nisnbk9H6QKTBsbm99Wv8EQ8Zm1W/Kclf205sPvHKx1yaXFGVKKS?=
 =?us-ascii?Q?xKQiANypKsH/UK05lm1++2qkQHFTD4+Ao/oqcblZk5h+AWbwQcT5jVoM1Cfo?=
 =?us-ascii?Q?BF/DUq471rwZR1hgPbEKe8nKXUj3c0eyYJUaXOb7V+CDOTZgeMx8HOiiIPDc?=
 =?us-ascii?Q?IAHxW0LNd4qdffPcux3iAK0GO1ceLq7WZ/RvrZUJ/+5TSSAFni2vnv+aVaGh?=
 =?us-ascii?Q?sulmjFMaJvVid/SHLG8w3o6liNPdDvtUgeSaRryi5QZ0CZ5BMCoL0InuBsSV?=
 =?us-ascii?Q?FgYzfda4F02DOhle5c0U+3+mZAoM/aMLxduOqotImlWZXmrkvgSIaLud/QCo?=
 =?us-ascii?Q?ku+HkJzO7sSTZjDRZOdRUdzRY3qPDMNBMImcujc7TD+lm94h2u38hpLsQDOG?=
 =?us-ascii?Q?mGBTF7eTLZ+Vq8lSzD6wRqpWTE3HYN0XzagMkkL07jMivXa+qSL2+z1qt9lw?=
 =?us-ascii?Q?8OAPRdhT8uo2pyNhV/MuJAYyRkGqKlMKGHHUgvZudjxmt85Fkbpts/EuAakU?=
 =?us-ascii?Q?Kve2/qxpBL7S+9/4YusvFzIXnFnzNO6qL394znqn704Klo+NWN7bQyGckv2O?=
 =?us-ascii?Q?5eWbAhVFujFQqY9xXMbWwGVCcLGaBG3DPseFdcno6DJSLtkN77ENaQ7kkU3D?=
 =?us-ascii?Q?FIrIc9n/C44yWFlRsIUjbt0ABkG7ZqUqNktJPDlhZS5BwX2hSXuHxHTPA9GH?=
 =?us-ascii?Q?+a97W5OZKLeeNu0UfQQ/VlrzAOTR9v+IS7b0Jolu0tr6Dg2tPg9ZZU9P4Caf?=
 =?us-ascii?Q?DpaQvgqNNVlZekPANIn5uHZvHvwJc/8LRtzR8trE?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR07MB5381.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c32faf29-c083-4f48-f1f2-08dc2df8c225
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2024 07:36:01.1791
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jQ8s42NB+0YWuskDiTXJTFt3mDLaulPmUDWxdiIGKKcHxd9NqdqwURK7ZZwkUTkSpO9vAvz7mq3FB2ZEQf5q6DokABwAikBlh+9kbjp/Mbk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR07MB9767
X-Proofpoint-ORIG-GUID: 2f9G7rUfyaWMsADaFaG-y5kNbJKJ7_-M
X-Proofpoint-GUID: 2f9G7rUfyaWMsADaFaG-y5kNbJKJ7_-M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-15_07,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 impostorscore=0
 clxscore=1015 mlxscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 adultscore=0 mlxlogscore=999 spamscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2401310000
 definitions=main-2402150058

>
>It is for both cdns3 and cdnsp.
>
>Reply-To:
>In-Reply-To: <20240206104018.48272-1-pawell@cadence.com>
>
>On 24-02-06 11:40:18, Pawel Laszczak wrote:
>> host.c file has some parts of code that were introduced for CDNS3
>> driver and should not be used with CDNSP driver.
>> This patch blocks using these parts of codes by CDNSP driver.
>> These elements include:
>> - xhci_plat_cdns3_xhci object
>> - cdns3 specific XECP_PORT_CAP_REG register
>> - cdns3 specific XECP_AUX_CTRL_REG1 register
>>
>> cc: <stable@vger.kernel.org>
>> Fixes: 3d82904559f4 ("usb: cdnsp: cdns3 Add main part of Cadence
>> USBSSP DRD Driver")
>> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
>> ---
>>  drivers/usb/cdns3/host.c | 16 ++++++++++++++--
>>  1 file changed, 14 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/usb/cdns3/host.c b/drivers/usb/cdns3/host.c index
>> 6164fc4c96a4..ceca4d839dfd 100644
>> --- a/drivers/usb/cdns3/host.c
>> +++ b/drivers/usb/cdns3/host.c
>> @@ -18,6 +18,11 @@
>>  #include "../host/xhci.h"
>>  #include "../host/xhci-plat.h"
>>
>> +/*
>> + * The XECP_PORT_CAP_REG and XECP_AUX_CTRL_REG1 exist only
>> + * in Cadence USB3 dual-role controller, so it can't be used
>> + * with Cadence CDNSP dual-role controller.
>> + */
>>  #define XECP_PORT_CAP_REG	0x8000
>>  #define XECP_AUX_CTRL_REG1	0x8120
>>
>> @@ -57,6 +62,8 @@ static const struct xhci_plat_priv xhci_plat_cdns3_xhc=
i =3D
>{
>>  	.resume_quirk =3D xhci_cdns3_resume_quirk,  };
>>
>> +static const struct xhci_plat_priv xhci_plat_cdnsp_xhci;
>> +
>>  static int __cdns_host_init(struct cdns *cdns)  {
>>  	struct platform_device *xhci;
>> @@ -81,8 +88,13 @@ static int __cdns_host_init(struct cdns *cdns)
>>  		goto err1;
>>  	}
>>
>> -	cdns->xhci_plat_data =3D kmemdup(&xhci_plat_cdns3_xhci,
>> -			sizeof(struct xhci_plat_priv), GFP_KERNEL);
>> +	if (cdns->version < CDNSP_CONTROLLER_V2)
>> +		cdns->xhci_plat_data =3D kmemdup(&xhci_plat_cdns3_xhci,
>> +				sizeof(struct xhci_plat_priv), GFP_KERNEL);
>> +	else
>> +		cdns->xhci_plat_data =3D kmemdup(&xhci_plat_cdnsp_xhci,
>> +				sizeof(struct xhci_plat_priv), GFP_KERNEL);
>> +
>
>You may explain why you duplicate another structure for cdnsp at commit lo=
g.

In my opinion it is more readable. If someone will review the code then eas=
ier to notice the difference between these driver.=20

Thanks
Pawel

>
>>  	if (!cdns->xhci_plat_data) {
>>  		ret =3D -ENOMEM;
>>  		goto err1;
>>
>
>Others are okay for me.
>
>--
>
>Thanks,
>Peter Chen

