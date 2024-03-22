Return-Path: <linux-kernel+bounces-110905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC2D886577
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 04:34:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1FC1285E9D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 03:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D27D8C15;
	Fri, 22 Mar 2024 03:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="j94Y31tf"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704658C11;
	Fri, 22 Mar 2024 03:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711078437; cv=fail; b=sVNSxDci1nQb4vLVcWpBC3s3o5eepXNFrCJ8ds4P7uZtiKxuSn4twvR75e0yrMtbaxlGhBUdQuZTJdCWYypVjCHoGQtmO8UCTCpqWkraTNULJS2xVlZ1Hh31N8a/Y2T6cmGfdTNa4hcRu38KRBR/4NTK6qC27gFdIo0JkvEzxUA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711078437; c=relaxed/simple;
	bh=c9suYfHtjWZY2pTZdSWfgcVf35BV4fQb3PVLMPL9cg0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Qq0U2CTxe6l4kmnVmZkPyfjpGKIBkuARd+Ie/RSeSE0HRI11nLfVcnYhPWaz5ktMdOitLBiK/6AYm21yp8MDfMUtGGZj1Vo8xr9OFiEHPxq6cawcMjNWA50vxPLGmK+KMk7ad5UD7VEKX/Bz83kGya96f/sRbxTnpa5YK1qL//s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=j94Y31tf; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42LMhA1L006288;
	Thu, 21 Mar 2024 20:33:30 -0700
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3x0wx7gp22-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Mar 2024 20:33:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=URsanU0sqm2T8ub7+lZ7/nhp6mmTXYZWKUzNS55WZjKtgD5ZlLAwUqD1U8CLB5EJpCx7nrZ9ykUTtTowUXcWv4IM8wXVdFe7LEWUlq808MleT3jFt6LrqrheFL5oP+st7ViIC/4lLC79EeAOqDhKuW8mjbF5ILTL6TLMTNmLxksLyeYfqt7NgBjbquL7b5+oTI/i4lm4tMnLMD+eXr0vxOzhEWu+snp80oE7O/DIT+u4Q8b47Td97DE1SxrmlXk7XmWq4EFLUbeqilos5NJ/5X1lNYO3xi/EJ1SxMMgYk3puiQneBMSbEy/PfchWxpozep84WhLtGFw0z7UvYY3wFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c9suYfHtjWZY2pTZdSWfgcVf35BV4fQb3PVLMPL9cg0=;
 b=IOesEhsfzCr5HxHqdBpV3WfSRJbfOq/B4eLELd5hHmTeBP3v3nbf2hWJW07NvvU6T6qUsdgVIPKCGXCxCb+DMf1cZ0aTZL0KtozS8rlZmxQ4F31djQ6SJGPy81hc1Y3tjBNdJdCUBoh89q/0UjNljjrSBu4YUYFS/Z85qTB1G/5i3Bcn8mXV1rTuovtayxhH5KYWbdutU/xrb4hPtquTQEXP2uY3ld1ul54t02UuqKsiuqu1/FzF2Xwi21aJcvth+dbG3m3E1QedfZeDdDNDge5yBzdLWiRRJhh3MNvnqT1wreOld01WxFfNlKpRXAo8dwBEnn2G+z9jwYKOCX0Lnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c9suYfHtjWZY2pTZdSWfgcVf35BV4fQb3PVLMPL9cg0=;
 b=j94Y31tf+kSouEhak3ORjr7flV87NT2Eq2dy5NbjyfH9PBT+lYxuhCu5H035mwCVXyzLORUcGj4xupy6nOLlVO8Uh1cki1lIthg+iFQyLdu7jILvvaAh20yyOkLurOlX8qQcg98n4sebokEBiGYPqfRhuSJ9znu/+s1rke1qcRM=
Received: from MWHPR1801MB1918.namprd18.prod.outlook.com
 (2603:10b6:301:68::33) by LV3PR18MB5615.namprd18.prod.outlook.com
 (2603:10b6:408:197::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.15; Fri, 22 Mar
 2024 03:33:25 +0000
Received: from MWHPR1801MB1918.namprd18.prod.outlook.com
 ([fe80::cfab:d22:63d2:6c72]) by MWHPR1801MB1918.namprd18.prod.outlook.com
 ([fe80::cfab:d22:63d2:6c72%4]) with mapi id 15.20.7386.025; Fri, 22 Mar 2024
 03:33:24 +0000
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: Mark <mark@yotsuba.nl>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Hans de Goede
	<hdegoede@redhat.com>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Breno Leitao <leitao@debian.org>, Ingo Molnar
	<mingo@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Paolo Abeni
	<pabeni@redhat.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [EXTERNAL] [PATCH] netpoll: support sending over raw IP
 interfaces
Thread-Topic: [EXTERNAL] [PATCH] netpoll: support sending over raw IP
 interfaces
Thread-Index: AQHaeSmEOc7lRsQg302gwrYwJRCanLE9g3JggASiIYCAAPoIMA==
Date: Fri, 22 Mar 2024 03:33:24 +0000
Message-ID: 
 <MWHPR1801MB191879162C145D958ECBA251D3312@MWHPR1801MB1918.namprd18.prod.outlook.com>
References: <20240313124613.51399-1-mark@yotsuba.nl>
 <20240313133602.GA1263314@maili.marvell.com>
 <7C42FC4B-D803-4194-8FBB-19A432D37124@yotsuba.nl>
 <MWHPR1801MB1918F15413BA4766F29A8581D3292@MWHPR1801MB1918.namprd18.prod.outlook.com>
 <57AE2A31-257C-4702-A571-C590A5DD234A@yotsuba.nl>
 <MWHPR1801MB191845C94DD80E4CD6C8C962D32D2@MWHPR1801MB1918.namprd18.prod.outlook.com>
 <4ACBB9C7-EFF5-47CA-9A8A-114209AE7953@yotsuba.nl>
In-Reply-To: <4ACBB9C7-EFF5-47CA-9A8A-114209AE7953@yotsuba.nl>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR1801MB1918:EE_|LV3PR18MB5615:EE_
x-ms-office365-filtering-correlation-id: d6e525fa-9e74-4371-6e63-08dc4a20d4cb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 YEIHAQ+Ts36UEDlttQepepfR+yxcqL/day7a0cINGVAl8nH342waIjZWQr9nNFmJtK+7ScQ7XwIKm9TqolXF8mjQ7rT5qGcf0QDeH22ZoQ1I1l5xPTkmGn1TPRlTMyppjibwdV5FtEHgOsLyPPM3Slx+RYZm626IhhFo7ejRuDNWyhZmJlVjWO2doOpnVuAXQUI0bq6bo2ofxySiYZIFS2L/RDfpuDQ7twfCsyxfOaEbSBDYV6orkLj/61FEZT50gr8ErBqGdgHj2RLWK6z3TpODDMZ4TGqaG7Lz0d1rud8VdMdXs0SXSa+MECj/2fbQTmvKi2WtEbXFCKqUsfIGdTq8A1NZXxqXG6TUZhAbVfT25qLCPbFYmSTdRxrLy4HKddy4EtRsU7z3tBdGEnNDz4TZxCRa1lUn/gX+4Q20d4rp9iRy87OYd6RUYqvDQnZjqbJQT+I45+zjazthtvhNN2kvNfFDFtCl4P2Y9hhw1hdYvGyX5Hi6cVd6XIQWfpT+2k4oDaV7OMcbW19TASej81u8Rbv4CC9qzUxLXYRgnll6SjLhoXbV2nP3Qow2uoaG50s1o1u1Ah/Rew8PDO9PWaxEtXAs/GRLKq2yjnI0R+uVuxnyFIjxTZZLpPAYk5BKyuDcRucr3pAqWPy41JTy/7fPknsLvTEy1WhmmMyUkPbnOuHqvLJOR0P1WKstY28yjONhp164woWUTk2uvYQZb+qwGLYb1jKYe2xr5kBIpcM=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1801MB1918.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?Q2tDRnFoYWZzRmQyQ1ZUL1E3UkkvU3M4RkpEdWhNQkE2bkNsQlgyUXpxbHcz?=
 =?utf-8?B?SG43UktjQ2FzWVRvUk1US2UwMWVMeDd0dXN2QVNRZDQ2RGp3aTR4UkFiMG5r?=
 =?utf-8?B?ems2RmdaeEErYnpRSjV6b0ZNSVhSWEpNRmJldnhnSUVSVW1PU0VFU0EwdXZq?=
 =?utf-8?B?aHpOR2hFdGJ6aDlMQUc5bjJxdFVWUkVVUDYzdWRtSmZaaUhHYWxYOEpvMGR5?=
 =?utf-8?B?bDJtTVEzZmpYSWlPS2w1SW56OTBRNGZMSUhhWEhpV2JZRGhkYmNTeVlCYjFx?=
 =?utf-8?B?NjhpZ1hBeUZKOXVqSkNXUDVKeU5Vc05aa1gyUmo5NXhnckhqaGVlMStMTWdG?=
 =?utf-8?B?VnNYRXduaXR2R2o1NmoyT0pxNmd5U0lvaVJVcitzWXpKNXFjSHNhS1B1SlVy?=
 =?utf-8?B?ejJDUGQrRmNveHphWkpXNEtqcGdxaGdZTnAwamJkVVV6bG90d0RLQm8ySzZR?=
 =?utf-8?B?eXVJOGhIVXhPVzRJSGl3SXJoYnVNRWl3UFdPNmd1NGJ5VTVUaWlNazM5dlUy?=
 =?utf-8?B?Z2I4RW5QUitQcFNQY1VoVGhNT1NGMVl1Sm1JdmFnU1ZENm5DTkFrOW53eGpx?=
 =?utf-8?B?RDlFSkZKQ2lhYWtiWGJlTS9FYUdqK0I1YXlHS1VOS2phb3kxUHFra1NrZ2Ir?=
 =?utf-8?B?LzJ5TUM3MklLZWgxQ2xJT0xMUlNmK0RGRWxzTVJrZXZ5ajQyVmt1VnREejJq?=
 =?utf-8?B?NXVyNC9wcllaSzVjTUMyc1RMUENFanp3T3lTQ2lBVlNuR2JncU1CaDB2cmJN?=
 =?utf-8?B?M3M1bjl3ekJMMGxhMXEwUk56RWlScEsxVWVQaURzOHdKNmRzMzZvekNhVVlv?=
 =?utf-8?B?SjhINE9EcWpQT3dwRGNzQXo0K0taS1VNd2dSUndQUnM2NjQwRU4vVXIzb2F2?=
 =?utf-8?B?WGhLSWV5VklpdEhXbVZsbEtqV3IxNGtWTlJYV2U4bmFWejFIY0pUUHFDUW5F?=
 =?utf-8?B?RzFFL0ZPZU43bzFjTjFvdFdUYW9teW4xTEVSUXlYY3hRVGlQYkkvRS9zam5W?=
 =?utf-8?B?UXBZRjhYMUU2MU5Uclg4RWFKRGtDSld3VlA5ellSMDg4L0U1SmNxUEYyL1FV?=
 =?utf-8?B?QlhySGFPZ2JRZFdvaVUzS1ZrOWxJbDFRVFlUM1BWNWpoSFo5aUNtNkROSXBu?=
 =?utf-8?B?UGMrUGV5Q0ErbXJkQzdud1JXb052ZC9iU3BYVW1FNGx5UnhEanlTaHd6bzNZ?=
 =?utf-8?B?QzJxaDV6aVJBL3BlK1hYczlES2JtK3Y1VElsTXFXZ1ZFaTVHQjhGTFlYeVow?=
 =?utf-8?B?UldwN2tyNnVoWEIxb3piUktrUFB3VVo2ZnU4WmV4S0poYXV6bUt6OHViVmNu?=
 =?utf-8?B?TXhPL1g0ZDEwUHVYT1pPWW1iYmplUElXUHdoeVNJZy9NazdBeWxueXRJejVY?=
 =?utf-8?B?WnhYMTA5Zk5rbXZwSGd4RjdLb2Jwdnl0Rm9idlQ4aHo3MlUzV0NoSjh5TmJr?=
 =?utf-8?B?Y2g1Z0EwNXZMazBIOUEvT0g2c0RQR3VOZGI4WGs5NkxEMFZxc0VERTlGRWs3?=
 =?utf-8?B?YUVwUHpDVmFVMjJPZWZiY3VaMUJHOXorRHA0ektPTDdSM0hpOVppc3JYTHJC?=
 =?utf-8?B?WUVTSkFGRXBiMVErNlBUWEFnV3M3YWZzQzIwNWNlRFZjblhQeWFpQ2JidnZo?=
 =?utf-8?B?YXI5UXU1eTVJYU5PMXNmSGlmUnhDL0diSkkvWmpHWGlSMy9XQmxHMTdmcWN4?=
 =?utf-8?B?WHlPMGdDeE1CSHdPZFVEcm1RQVZzeUVSZ2xZR1dQSXdONXB1a0ZoWVhNV3dw?=
 =?utf-8?B?bFhSNUxhMEdSYXNDM1pmbXdLZmVWZXlBNVlvSjB5RTFIYmZnRWNFbWd4a0hQ?=
 =?utf-8?B?ZDBNR3EvNStsdmxzbDIyWXNZbUlReE1xSFUwKzM2K0ppUnlha1RzODIxR3lE?=
 =?utf-8?B?NFNyU2N6VE1IY2pRUTJvdEZXUjVYNXVQS0hDWnJhd3V3T3FpUXZWUzljL29i?=
 =?utf-8?B?L2VtNTJBK2dXSWZYYzBpRTBOL25adlFOa0hZa0RqQlZPR3d0L0NQa3FZbzVE?=
 =?utf-8?B?ZFc0VUZGK29IMXZvS0hoZmNrRHRBT1VTVHNqZXh4eFFsRVgreTNBVnlUNlQ2?=
 =?utf-8?B?K0FFUzkwMGlmSlBKeE1OclhxYXAxWk9jZVBWQkFvSHFmTkhwcFU0V2VqbmV6?=
 =?utf-8?Q?cR0fc+ShON4+3ULtV7akEoUS1?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1801MB1918.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6e525fa-9e74-4371-6e63-08dc4a20d4cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2024 03:33:24.8762
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kSOZqHtAURUlY961HSAHlGy5cwUUCatphjMOGkfNz0/xdJGtPAiiSehEhyCYVKWKLGId9Q53XeXZFo0HEAigJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR18MB5615
X-Proofpoint-GUID: C4Zw3rhpF1ydUEA8KEJu4p6bPHUpsdun
X-Proofpoint-ORIG-GUID: C4Zw3rhpF1ydUEA8KEJu4p6bPHUpsdun
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-21_14,2024-03-21_02,2023-05-22_02

PiBGcm9tOiBNYXJrIDxtYXJrQHlvdHN1YmEubmw+DQo+IFNlbnQ6IFRodXJzZGF5LCBNYXJjaCAy
MSwgMjAyNCA2OjAzIFBNDQo+IFRvOiBSYXRoZWVzaCBLYW5ub3RoIDxya2Fubm90aEBtYXJ2ZWxs
LmNvbT4NCj4gQ2M6IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7IEhhbnMgZGUgR29lZGUgPGhkZWdv
ZWRlQHJlZGhhdC5jb20+OyBFcmljDQo+IER1bWF6ZXQgPGVkdW1hemV0QGdvb2dsZS5jb20+OyBK
YWt1YiBLaWNpbnNraSA8a3ViYUBrZXJuZWwub3JnPjsgQnJlbm8NCj4gTGVpdGFvIDxsZWl0YW9A
ZGViaWFuLm9yZz47IEluZ28gTW9sbmFyIDxtaW5nb0ByZWRoYXQuY29tPjsgRGF2aWQgUy4NCj4g
TWlsbGVyIDxkYXZlbUBkYXZlbWxvZnQubmV0PjsgUGFvbG8gQWJlbmkgPHBhYmVuaUByZWRoYXQu
Y29tPjsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtF
WFRFUk5BTF0gW1BBVENIXSBuZXRwb2xsOiBzdXBwb3J0IHNlbmRpbmcgb3ZlciByYXcgSVANCj4g
aW50ZXJmYWNlcw0KPiANCj4gSGkgUmF0aGVlc2gsDQo+IA0KPiA+IE9wIDE4IG1ydCA2IFJlaXdh
LCBvbSAxNTowNiBoZWVmdCBSYXRoZWVzaCBLYW5ub3RoDQo+IDxya2Fubm90aEBtYXJ2ZWxsLmNv
bT4gaGV0IHZvbGdlbmRlIGdlc2NocmV2ZW46DQo+ID4NCj4gPj4gW+KApl0NCj4gPiBJcyBiZWxv
dyBuZXR3b3JrIHRvcG9sb2d5IHBvc3NpYmxlID8NCj4gPiBOZXRwb2xsKCktIC0tLS0tLT4gbmV0
ZGV2IEEgLS0tLT4gcmF3IGludGVyZmFjZSBXaGVyZSBuZXRkZXYgQSdzDQo+ID4gbmV0ZGV2LT5o
ZWFkZXJfb3BzICE9IE5VTEwNCj4gDQo+IEkgYmVsaWV2ZSBzbywgdGhpcyBpcyBub3QgdW5jb21t
b24gaW4gdHVubmVsIGRldmljZXMgbGlrZSBncmV0YXAuDQo+IEhvd2V2ZXIsIHRob3NlIGZ1bGx5
IGVuY2Fwc3VsYXRlIHRoZSBsaW5rIGxheWVyIGhlYWRlciBpbiB0aGUgcGFja2V0IHRvIHRoZQ0K
PiBsb3dlciBpbnRlcmZhY2UuIEkgYW0gbm90IGF3YXJlIG9mIGEgaW50ZXJmYWNlIGRyaXZlciB0
aGF0IHJlbW92ZXMgYSBoZWFkZXINCj4gdXBvbiB4bWl0LCBzbyB0byBzcGVhay4gSG93ZXZlciwg
SSBoYXZlIGp1c3QgcG9zdGVkIGEgdjIgdGhhdCBpbnN0ZWFkIHVzZXMgdGhlDQo+IGRvY3VtZW50
ZWQgYGRldl9oYXNfaGVhZGVyKClgIEFQSSwgd2hpY2ggc2VlbXMgdG8gZml0IHRoZSBjaGVjayBl
eGFjdGx5LA0KPiBoZXJlOg0KQUNLLiAgSSB1bmRlcnN0YW5kIHRoZSBjb21wbGV4aXR5IHRvIGlt
cGxlbWVudCBpdCBpbiBkcml2ZXIgdGhhbiBhIGVhc3kgZml4IGluIG5ldHBvbGwuIA0KDQo=

