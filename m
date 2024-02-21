Return-Path: <linux-kernel+bounces-73950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68BF685CDEE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 03:24:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA0501F25C16
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 02:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF047F9FF;
	Wed, 21 Feb 2024 02:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="gitt4S/C"
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F7546A4
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 02:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708482264; cv=fail; b=X/2TfbRdS2kYYU7Lne59En+BRrHOfGT1X0ha7rqaSAnBJl+FBgcNuCOgjasqsx5SoEE10cg62KW05CQWfhZWaroBhpizyz9Dy9Uh5URxSNAzlw2b/owzvUCvdL42n8tWLlHyMwSpBKy5BT6skqvFvxkJh8gRIacHkhYfNoYf4FQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708482264; c=relaxed/simple;
	bh=0wZ01ZxEJQUKXVgIscLIuzag/LcN+HEsW3HBCvRHbko=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mDQqiUyRz/Qabs+mtgRBhqM0DkOTTTz/IF7hgAtt26c4o5HJ2WsulGvrJymj8ZMysiVR1l3LjXXQrVV7ghyaB0ferpnrZp/DxtB8npBmbEALz54DfNoeHPCFXW5bm5czep/0iWRcN8aPzUM//ymsg8yYfYlTkqAYuoBQWFCebV4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=gitt4S/C; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41L1qm5d006859;
	Wed, 21 Feb 2024 02:23:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	PPS06212021; bh=0wZ01ZxEJQUKXVgIscLIuzag/LcN+HEsW3HBCvRHbko=; b=
	gitt4S/CtIdtLVkIIUVNpZIWN7DGdjywzyctpdGhYRBcG+Y8GEMhp3s5u9JYQ5TJ
	Y+khhqKHfqrk1OIXTFnGvXQN9pSfF+Pllcs+xAHHVdp6lDQdhB2AWQqNKLAb6ILe
	Ra12yq7mRjk2kqFd2xktM/6wU6Wl+s0uHYgG6K7JM1/oxEf+UoGyD2C6kfgaw2zb
	1rJSR3iJ12SLkgQZVdTYgWy1QqCfMqOcWA3RcqR3mDCsm6I6aTuOn89lUFEKbzFd
	XN7dWycMkcWfBZttaacwZQ8TB1WtSV18rB1j1SaFkGHwVekXm85pW3Obf/OkqHSl
	yUwpiCScqAvCrdX5gQEz4A==
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2168.outbound.protection.outlook.com [104.47.73.168])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3wd2178ag0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Feb 2024 02:23:32 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TPBahXN7RX37s1gumNsxsNIJ1cJ/uHfMzhzqKZviIRk0+fvI3dZkQT+NKczhH9XUwZcKhkUIHJE3gKMJ4ASmojTcgWsHs3O7uGzdvLlChUTEOtUQyP+I7Rvqy0jTcQcLFsqj57IqN17pnZKZcU5ChzYUbagLnMZTOgQG4vnTsqIkVR06D5Ug7CP0ohSAoVm/myUT6XOXeYoLtIa4IT+bfqQbEh4sxGRWF9rFbhYRdZ5SIh7BAzqp03agDx9iNTiwU7qMu99YV7BPTW13ZyAJGiJ/Z+4X/OmOfwNQc5hSRMuHMs2K/FiSOWIm7n5Rn3JnbaCF2irr86aXi3DHvpvN7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0wZ01ZxEJQUKXVgIscLIuzag/LcN+HEsW3HBCvRHbko=;
 b=PWZg2dwUw4K1oUU6L31sIdRgNs7cL0wavMObSrosx6DUtDvJuGfC6HDvFKLjAp2P8YPdoPtMjJYXjkXu7W8Py3UP5naAonFJ6phy8mWGhB7v8x/l47Wbt4pUY0YHTaO3vvI3AbDCtKALtJPRQmXd6sBxCqph+kbqk1rOrsDZkBOEA7BSVI6fDGtRJGQIyo2apeqzZLTrnT4749aLpnVu2ZG1hdXbU9sEnBL4fgMEsGmJC1Un+9OEfo0jAVnTLOKpR1pq1wtKuJVrTMx3CvbOnegJ6eySlDkMMH/zKk5rzaTBFjaBotbknEbKG8xDWu1gXWZqx/x/BMil5OTKj1GPqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from PH0PR11MB5192.namprd11.prod.outlook.com (2603:10b6:510:3b::9)
 by SJ2PR11MB8538.namprd11.prod.outlook.com (2603:10b6:a03:578::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Wed, 21 Feb
 2024 02:23:30 +0000
Received: from PH0PR11MB5192.namprd11.prod.outlook.com
 ([fe80::230c:58c0:c3f9:b5f3]) by PH0PR11MB5192.namprd11.prod.outlook.com
 ([fe80::230c:58c0:c3f9:b5f3%3]) with mapi id 15.20.7292.036; Wed, 21 Feb 2024
 02:23:30 +0000
From: "Song, Xiongwei" <Xiongwei.Song@windriver.com>
To: Vlastimil Babka <vbabka@suse.cz>, Christoph Lameter <cl@linux.com>,
        Pekka
 Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo
 Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo
	<42.hyeyoo@gmail.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander
 Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino
	<vincenzo.frascino@arm.com>
CC: Zheng Yejian <zhengyejian1@huawei.com>,
        Chengming Zhou
	<chengming.zhou@linux.dev>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>
Subject: RE: [PATCH 2/3] mm, slab: use an enum to define SLAB_ cache creation
 flags
Thread-Topic: [PATCH 2/3] mm, slab: use an enum to define SLAB_ cache creation
 flags
Thread-Index: AQHaZB4Vv6+1rZm7vkyKrrwrlEStt7EUEDaw
Date: Wed, 21 Feb 2024 02:23:30 +0000
Message-ID: 
 <PH0PR11MB51929679F8256CDE50F46F87EC572@PH0PR11MB5192.namprd11.prod.outlook.com>
References: <20240220-slab-cleanup-flags-v1-0-e657e373944a@suse.cz>
 <20240220-slab-cleanup-flags-v1-2-e657e373944a@suse.cz>
In-Reply-To: <20240220-slab-cleanup-flags-v1-2-e657e373944a@suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5192:EE_|SJ2PR11MB8538:EE_
x-ms-office365-filtering-correlation-id: ebc42f19-be8e-4ce6-b9a1-08dc3284185a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 6goCws9gV2w92aV3QNH8pu6i11gPyfzUpPO+1EztW0rPXuNrqDw0YaY3vPJYxbToR90+oU/G4GFFDGKfnGAkNlVFGQ4pYEruoEJ9t9jYAX+8ileUR51vpYBW0KSfKKF8H2NyhEnOZcrKmpJ4TcFRbLGNzzE8LeF3NFDE9wMv48Gs5NeE80oVdC6f2YJvKXTAKNGvcD7dXBeivnlaDf4d3VCpm1gsDoCwOE3EdEo4U8+xXXBX25ufxv3jZ1swk8RXa4eMF53hOmHtP/aKJaj7Gja+CUr7zMDJobqdx+U/+RLIpOKIMOkOeGTLT8UA3btOr/IPcVDRTCmIR7oY+NC7m6EjjWpVk1u65ACR3PUPQkzwwg5wiY/LnWO3Yu7FfEapADTSQ4KY9//ZxAJMuIBZ19gZM7LN8p6pAAggzA8vA4hAN3/lpqblKqcp/XarNhhmpGuhxWkKGC0htEcugkGq7bQP7dnWJz7QJ6sWXp0fPKfDcJx2baATGXxcOXg8E4zBXxLQr2Eg5riOMExpX3ZrbT/GCXw+S2HYahxS5uy8UeWin8+VMiry862mPLSIogCixIVFHlVh4YBsba8sD+h73gXUwd3z8knmDGLagVCKyEEJqyMEu7VOAgZ/as4c8WBgrHFRpSqJURW030bReuJi6Q==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5192.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(230273577357003)(921011)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?cEpodTJEd09zYkkxZ25Cc0I3SE9ZNEpSOXViQzhXYWFSY2hHaHNsZjhzUGhL?=
 =?utf-8?B?OXpRS09TeXJYZ2R3dFp5cVZ1M1FGcUc2dUlIRlJneXB6S1dEUm1ySnBlWG9p?=
 =?utf-8?B?NjR1WDhwOTYwM3F5dEhGcVBZVCt6SlR5M1lWWXpEV0NSV3hMMm5WVERpdEdX?=
 =?utf-8?B?UmMvTkJoVnBPc2Y4cGJ4UjFzendjUjhnQm5tUitFRFh5aG8welFVdm9zekFU?=
 =?utf-8?B?VHpvZW1oa2Rja3FuWGdjcEgvQkNQSkoyNC9lL3dzcUtVTUZsR0Y3dWNrVU8v?=
 =?utf-8?B?aFJud0pRSUcrK3EyQWJOcUJhY0hhcUVra0kxUnNUaG5UMkxtWnNTdkJqajR0?=
 =?utf-8?B?U01vRk0wWW84WkRjMkVXU2xXeDlvdUN2UE5DcTd3N1FUcnBYazIza1BtMWZH?=
 =?utf-8?B?ZWRqekJlVGZkZVA3UzlIZVpJWnJPY1BST3hmTkdzNTRXQzA2Y3RQM0l2Mlg1?=
 =?utf-8?B?VkUvMDZnckJsRXpVT25ubHpyQldjOHcrYzVua01jd2piVUlrS21FVm5GOGRV?=
 =?utf-8?B?amluWnN3NzMrVkpGOTlHMTdMQ3pmQm5mRGorL1NCQ25BZWhRUk1OWEM0b1I0?=
 =?utf-8?B?RzhlRk5NSU02Zzk1UzFpQnJ3anhJa0x3czdXbHpFS0g1eDJrU3l1Ty9lT1Ns?=
 =?utf-8?B?eUtFZDNkUTJWOUw5Q08vN2tObjcwMEptZXVQK09WaXpmQ2d0NEN6SmZ3QUlC?=
 =?utf-8?B?L0F6bFBVY0p5aStLTmM5ZlhrQXN1MmJUbXRyOCtJd3V2L0phNEF6eldTNzUy?=
 =?utf-8?B?QmlrOWxoYWpqalVBNDZNbndRYTI3eTlwa25IbWJSYitDZDlOcXV3YlR2L2tn?=
 =?utf-8?B?UlpXQVpKaXdBL0dTUFRJNUd0bk9hL3hDZWpxTFZQdWhkV284TitLSEhDRVU2?=
 =?utf-8?B?SG84NzNycFd4RGJGbGNxMGZKdzFibVcrRDlkenpOU0l5NjdrSVp5OXh1ekR2?=
 =?utf-8?B?MTh2NlFpS1RqVkJOb1VmRG9jTlJsaHpQYXh0ZHlzRjZuL1pSendBQ2s2ZmRH?=
 =?utf-8?B?ZU16YkV2ZnJ0ZmNYcmxPb3NGZUlUSEdUVGNjT3UzdDVFUlZISjJsTC9TcnRC?=
 =?utf-8?B?Z0srUWV5S3JNRjA4d2owYm1lajB6QXpXalFJTDJCRWRkbHRvNzRBUEl0L2M0?=
 =?utf-8?B?NWhkSHh4ZnFGTUoyL1krQTdyRE1yR1d0K3E3bHc1eGVTVFg5Qy9VUkgvMzNn?=
 =?utf-8?B?MTV4YkdZcHlpVmQ2V1JYYUtkZ05sTE82b1J0UkFLNGxPNWVBTm95QTc3QjVa?=
 =?utf-8?B?TWtYYkdxeEtUNk5uMjNXTW5ROVprRXVoeXBHVFJXaXVXbVBHQXJyMWdmeXQy?=
 =?utf-8?B?TkNFQzFxdCtyUFlkbnVKUS82ZDB2Z2hPSFlsckxleGFjUWZxeHYvU2I1cnJ1?=
 =?utf-8?B?cHF1MGQva0pWbHRGYk5mUWhSWFBjU1lKLzBSenhnWlh1RFlRNUFBcGttVHUz?=
 =?utf-8?B?N3ZmV1JwNVBTTjNNVXoyUDIwN3dFd3RBK3pBM0NsY1VEZE1GK1hVSmY2RmRV?=
 =?utf-8?B?eFBZQjJZSlQ1bGZjZVVVSzF5TVdqbTNYWHBWcG5kYi9DYjBxQ1pBM2hCS1Rj?=
 =?utf-8?B?VEhkd0E3b3JpdkdEODZiZ1FjemNmS2s0Q1M3R1BOZU50NW5mUWp0Ym51clRP?=
 =?utf-8?B?Ri92WUxWb2lNQjlEWEgyUFI4dDR5blg3UFNnV0lkY3BVaURReXpIYVFVNzBm?=
 =?utf-8?B?Ym9DM1VhVVNaVlJ2N2duaG0zUHRad0pHeWhKMktOem1iZ1djTW5xQ2lGY083?=
 =?utf-8?B?WkFiajhQdGk5S1NvOGI1RDQ0VXFRTEd5NC90b2lQTjJZOXp5SWNaV0RKamho?=
 =?utf-8?B?S0NJSWtuS2k2M0tkcTNmWlFWb2VESDVVTUMvOGlhd0RmRzhEOVQ5N0pqVEpj?=
 =?utf-8?B?RkVxcGVyODBQTlN5bmtQL2wvYjNDUnkrQkhBeUtoekhFRVdLeGpwY2hib2M0?=
 =?utf-8?B?WHJsM0hzNWJ5Z043UThrbFZFWUdYVHE2TGwwUVlmb25JRjRhN0hiaWlpUHVU?=
 =?utf-8?B?c0FsSHRmMHlvM0cxVDFOY1lNOVhvQ3RWL2doalpZMFRZT2dQRmxEdGVKb25P?=
 =?utf-8?B?OHRGenN5emdyOUQ4MFkvMjErTjVIVE1wdVlVZks2RWc4Qk1ZZWg4cDgyWjY0?=
 =?utf-8?B?ZWxqZEhLRTJPWFMwd3IrckJkTm5JMVhXYWphMVIvR08wMWdSQnhjTFVIU0Jp?=
 =?utf-8?B?L0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5192.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebc42f19-be8e-4ce6-b9a1-08dc3284185a
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2024 02:23:30.5378
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3mRYSuu4oyzLtkZbgWcWLwkCq2dyrAR5ZpcmJGiof2E2UmlArOq28YGpV/Y65Du58p3VHPzuER5saNTp8p++poQbmSPwQ8+09ti/KMfWwb8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8538
X-Proofpoint-GUID: 9sp9G0-TpCfdVYeyMRdhtZ2quAgPrmS5
X-Proofpoint-ORIG-GUID: 9sp9G0-TpCfdVYeyMRdhtZ2quAgPrmS5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0 bulkscore=0
 clxscore=1015 adultscore=0 mlxlogscore=548 lowpriorityscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402210014

DQo+IFRoZSB2YWx1ZXMgb2YgU0xBQl8gY2FjaGUgY3JlYXRpb24gZmxhZ3NhcmUgZGVmaW5lZCBi
eSBoYW5kLCB3aGljaCBpcw0KDQpBIGJsYW5rIHNwYWNlIG1pc3NlZCBiZXR3ZWVuIGZsYWdzIGFu
ZCBhcmUuDQoNCj4gdGVkaW91cyBhbmQgZXJyb3ItcHJvbmUuIFVzZSBhbiBlbnVtIHRvIGFzc2ln
biB0aGUgYml0IG51bWJlciBhbmQgYQ0KPiBfX1NGX0JJVCgpIG1hY3JvIHRvICNkZWZpbmUgdGhl
IGZpbmFsIGZsYWdzLg0KPiANCj4gVGhpcyByZW51bWJlcnMgdGhlIGZsYWcgdmFsdWVzLCB3aGlj
aCBpcyBPSyBhcyB0aGV5IGFyZSBvbmx5IHVzZWQNCj4gaW50ZXJuYWxseS4NCj4gDQo+IFNpZ25l
ZC1vZmYtYnk6IFZsYXN0aW1pbCBCYWJrYSA8dmJhYmthQHN1c2UuY3o+DQoNClJhbiBhIHJvdWdo
IHRlc3Qgd2l0aCBidWlsZCBhbmQgYm9vdHVwIHdpdGggdGhlIHJlbGF0ZWQgZGVidWcgY29uZmln
cyBlbmFibGVkLA0KZmVlbCBmcmVlIHRvIGFkZA0KDQpUZXN0ZWQtYnk6IFhpb25nd2VpIFNvbmcg
PHhpb25nd2VpLnNvbmdAd2luZHJpdmVyLmNvbT4NClJldmlld2VkLWJ5OiBYaW9uZ3dlaSBTb25n
IDx4aW9uZ3dlaS5zb25nQHdpbmRyaXZlci5jb20+DQoNClRoYW5rcywNClhpb2dud2VpDQo+IC0t
LQ0KPiAgaW5jbHVkZS9saW51eC9zbGFiLmggfCA4MSArKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tDQo+ICBtbS9zbHViLmMgICAgICAgICAgICB8ICA2
ICsrLS0NCj4gIDIgZmlsZXMgY2hhbmdlZCwgNjMgaW5zZXJ0aW9ucygrKSwgMjQgZGVsZXRpb25z
KC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9zbGFiLmggYi9pbmNsdWRlL2xp
bnV4L3NsYWIuaA0KPiBpbmRleCA2MjUyZjQ0MTE1YzIuLmY4OTNhMTMyZGQ1YSAxMDA2NDQNCj4g
LS0tIGEvaW5jbHVkZS9saW51eC9zbGFiLmgNCj4gKysrIGIvaW5jbHVkZS9saW51eC9zbGFiLmgN
Cj4gQEAgLTIxLDI5ICsyMSw2OCBAQA0KPiAgI2luY2x1ZGUgPGxpbnV4L2NsZWFudXAuaD4NCj4g
ICNpbmNsdWRlIDxsaW51eC9oYXNoLmg+DQo+IA0KPiArZW51bSBfc2xhYl9mbGFnX2JpdHMgew0K
PiArICAgICAgIF9TTEFCX0NPTlNJU1RFTkNZX0NIRUNLUywNCj4gKyAgICAgICBfU0xBQl9SRURf
Wk9ORSwNCj4gKyAgICAgICBfU0xBQl9QT0lTT04sDQo+ICsgICAgICAgX1NMQUJfS01BTExPQywN
Cj4gKyAgICAgICBfU0xBQl9IV0NBQ0hFX0FMSUdOLA0KPiArICAgICAgIF9TTEFCX0NBQ0hFX0RN
QSwNCj4gKyAgICAgICBfU0xBQl9DQUNIRV9ETUEzMiwNCj4gKyAgICAgICBfU0xBQl9TVE9SRV9V
U0VSLA0KPiArICAgICAgIF9TTEFCX1BBTklDLA0KPiArICAgICAgIF9TTEFCX1RZUEVTQUZFX0JZ
X1JDVSwNCj4gKyAgICAgICBfU0xBQl9UUkFDRSwNCj4gKyNpZmRlZiBDT05GSUdfREVCVUdfT0JK
RUNUUw0KPiArICAgICAgIF9TTEFCX0RFQlVHX09CSkVDVFMsDQo+ICsjZW5kaWYNCj4gKyAgICAg
ICBfU0xBQl9OT0xFQUtUUkFDRSwNCj4gKyAgICAgICBfU0xBQl9OT19NRVJHRSwNCj4gKyNpZmRl
ZiBDT05GSUdfRkFJTFNMQUINCj4gKyAgICAgICBfU0xBQl9GQUlMU0xBQiwNCj4gKyNlbmRpZg0K
PiArI2lmZGVmIENPTkZJR19NRU1DR19LTUVNDQo+ICsgICAgICAgX1NMQUJfQUNDT1VOVCwNCj4g
KyNlbmRpZg0KPiArI2lmZGVmIENPTkZJR19LQVNBTl9HRU5FUklDDQo+ICsgICAgICAgX1NMQUJf
S0FTQU4sDQo+ICsjZW5kaWYNCj4gKyAgICAgICBfU0xBQl9OT19VU0VSX0ZMQUdTLA0KPiArI2lm
ZGVmIENPTkZJR19LRkVOQ0UNCj4gKyAgICAgICBfU0xBQl9TS0lQX0tGRU5DRSwNCj4gKyNlbmRp
Zg0KPiArI2lmbmRlZiBDT05GSUdfU0xVQl9USU5ZDQo+ICsgICAgICAgX1NMQUJfUkVDTEFJTV9B
Q0NPVU5ULA0KPiArI2VuZGlmDQo+ICsgICAgICAgX1NMQUJfT0JKRUNUX1BPSVNPTiwNCj4gKyAg
ICAgICBfU0xBQl9DTVBYQ0hHX0RPVUJMRSwNCj4gKyAgICAgICBfU0xBQl9GTEFHU19MQVNUX0JJ
VA0KPiArfTsNCj4gKw0KPiArI2RlZmluZSBfX1NGX0JJVChucikgICAoKHNsYWJfZmxhZ3NfdCBf
X2ZvcmNlKSgxVSA8PCAobnIpKSkNCj4gDQo+ICAvKg0KPiAgICogRmxhZ3MgdG8gcGFzcyB0byBr
bWVtX2NhY2hlX2NyZWF0ZSgpLg0KPiAgICogVGhlIG9uZXMgbWFya2VkIERFQlVHIG5lZWQgQ09O
RklHX1NMVUJfREVCVUcgZW5hYmxlZCwgb3RoZXJ3aXNlIGFyZSBuby1vcA0KPiAgICovDQo+ICAv
KiBERUJVRzogUGVyZm9ybSAoZXhwZW5zaXZlKSBjaGVja3Mgb24gYWxsb2MvZnJlZSAqLw0KPiAt
I2RlZmluZSBTTEFCX0NPTlNJU1RFTkNZX0NIRUNLUyAgICAgICAgKChzbGFiX2ZsYWdzX3QgX19m
b3JjZSkweDAwMDAwMTAwVSkNCj4gKyNkZWZpbmUgU0xBQl9DT05TSVNURU5DWV9DSEVDS1MgICAg
ICAgIF9fU0ZfQklUKF9TTEFCX0NPTlNJU1RFTkNZX0NIRUNLUykNCj4gIC8qIERFQlVHOiBSZWQg
em9uZSBvYmpzIGluIGEgY2FjaGUgKi8NCj4gLSNkZWZpbmUgU0xBQl9SRURfWk9ORSAgICAgICAg
ICAoKHNsYWJfZmxhZ3NfdCBfX2ZvcmNlKTB4MDAwMDA0MDBVKQ0KPiArI2RlZmluZSBTTEFCX1JF
RF9aT05FICAgICAgICAgIF9fU0ZfQklUKF9TTEFCX1JFRF9aT05FKQ0KPiAgLyogREVCVUc6IFBv
aXNvbiBvYmplY3RzICovDQo+IC0jZGVmaW5lIFNMQUJfUE9JU09OICAgICAgICAgICAgKChzbGFi
X2ZsYWdzX3QgX19mb3JjZSkweDAwMDAwODAwVSkNCj4gKyNkZWZpbmUgU0xBQl9QT0lTT04gICAg
ICAgICAgICBfX1NGX0JJVChfU0xBQl9QT0lTT04pDQo+ICAvKiBJbmRpY2F0ZSBhIGttYWxsb2Mg
c2xhYiAqLw0KPiAtI2RlZmluZSBTTEFCX0tNQUxMT0MgICAgICAgICAgICgoc2xhYl9mbGFnc190
IF9fZm9yY2UpMHgwMDAwMTAwMFUpDQo+ICsjZGVmaW5lIFNMQUJfS01BTExPQyAgICAgICAgICAg
X19TRl9CSVQoX1NMQUJfS01BTExPQykNCj4gIC8qIEFsaWduIG9ianMgb24gY2FjaGUgbGluZXMg
Ki8NCj4gLSNkZWZpbmUgU0xBQl9IV0NBQ0hFX0FMSUdOICAgICAoKHNsYWJfZmxhZ3NfdCBfX2Zv
cmNlKTB4MDAwMDIwMDBVKQ0KPiArI2RlZmluZSBTTEFCX0hXQ0FDSEVfQUxJR04gICAgIF9fU0Zf
QklUKF9TTEFCX0hXQ0FDSEVfQUxJR04pDQo+ICAvKiBVc2UgR0ZQX0RNQSBtZW1vcnkgKi8NCj4g
LSNkZWZpbmUgU0xBQl9DQUNIRV9ETUEgICAgICAgICAoKHNsYWJfZmxhZ3NfdCBfX2ZvcmNlKTB4
MDAwMDQwMDBVKQ0KPiArI2RlZmluZSBTTEFCX0NBQ0hFX0RNQSAgICAgICAgIF9fU0ZfQklUKF9T
TEFCX0NBQ0hFX0RNQSkNCj4gIC8qIFVzZSBHRlBfRE1BMzIgbWVtb3J5ICovDQo+IC0jZGVmaW5l
IFNMQUJfQ0FDSEVfRE1BMzIgICAgICAgKChzbGFiX2ZsYWdzX3QgX19mb3JjZSkweDAwMDA4MDAw
VSkNCj4gKyNkZWZpbmUgU0xBQl9DQUNIRV9ETUEzMiAgICAgICBfX1NGX0JJVChfU0xBQl9DQUNI
RV9ETUEzMikNCj4gIC8qIERFQlVHOiBTdG9yZSB0aGUgbGFzdCBvd25lciBmb3IgYnVnIGh1bnRp
bmcgKi8NCj4gLSNkZWZpbmUgU0xBQl9TVE9SRV9VU0VSICAgICAgICAgICAgICAgICgoc2xhYl9m
bGFnc190IF9fZm9yY2UpMHgwMDAxMDAwMFUpDQo+ICsjZGVmaW5lIFNMQUJfU1RPUkVfVVNFUiAg
ICAgICAgICAgICAgICBfX1NGX0JJVChfU0xBQl9TVE9SRV9VU0VSKQ0KPiAgLyogUGFuaWMgaWYg
a21lbV9jYWNoZV9jcmVhdGUoKSBmYWlscyAqLw0KPiAtI2RlZmluZSBTTEFCX1BBTklDICAgICAg
ICAgICAgICgoc2xhYl9mbGFnc190IF9fZm9yY2UpMHgwMDA0MDAwMFUpDQo+ICsjZGVmaW5lIFNM
QUJfUEFOSUMgICAgICAgICAgICAgX19TRl9CSVQoX1NMQUJfUEFOSUMpDQo+ICAvKg0KPiAgICog
U0xBQl9UWVBFU0FGRV9CWV9SQ1UgLSAqKldBUk5JTkcqKiBSRUFEIFRISVMhDQo+ICAgKg0KPiBA
QCAtOTUsMTkgKzEzNCwxOSBAQA0KPiAgICogTm90ZSB0aGF0IFNMQUJfVFlQRVNBRkVfQllfUkNV
IHdhcyBvcmlnaW5hbGx5IG5hbWVkIFNMQUJfREVTVFJPWV9CWV9SQ1UuDQo+ICAgKi8NCj4gIC8q
IERlZmVyIGZyZWVpbmcgc2xhYnMgdG8gUkNVICovDQo+IC0jZGVmaW5lIFNMQUJfVFlQRVNBRkVf
QllfUkNVICAgKChzbGFiX2ZsYWdzX3QgX19mb3JjZSkweDAwMDgwMDAwVSkNCj4gKyNkZWZpbmUg
U0xBQl9UWVBFU0FGRV9CWV9SQ1UgICBfX1NGX0JJVChfU0xBQl9UWVBFU0FGRV9CWV9SQ1UpDQo+
ICAvKiBUcmFjZSBhbGxvY2F0aW9ucyBhbmQgZnJlZXMgKi8NCj4gLSNkZWZpbmUgU0xBQl9UUkFD
RSAgICAgICAgICAgICAoKHNsYWJfZmxhZ3NfdCBfX2ZvcmNlKTB4MDAyMDAwMDBVKQ0KPiArI2Rl
ZmluZSBTTEFCX1RSQUNFICAgICAgICAgICAgIF9fU0ZfQklUKF9TTEFCX1RSQUNFKQ0KPiANCj4g
IC8qIEZsYWcgdG8gcHJldmVudCBjaGVja3Mgb24gZnJlZSAqLw0KPiAgI2lmZGVmIENPTkZJR19E
RUJVR19PQkpFQ1RTDQo+IC0jIGRlZmluZSBTTEFCX0RFQlVHX09CSkVDVFMgICAgKChzbGFiX2Zs
YWdzX3QgX19mb3JjZSkweDAwNDAwMDAwVSkNCj4gKyMgZGVmaW5lIFNMQUJfREVCVUdfT0JKRUNU
UyAgICBfX1NGX0JJVChfU0xBQl9ERUJVR19PQkpFQ1RTKQ0KPiAgI2Vsc2UNCj4gICMgZGVmaW5l
IFNMQUJfREVCVUdfT0JKRUNUUyAgICAwDQo+ICAjZW5kaWYNCj4gDQo+ICAvKiBBdm9pZCBrbWVt
bGVhayB0cmFjaW5nICovDQo+IC0jZGVmaW5lIFNMQUJfTk9MRUFLVFJBQ0UgICAgICAgKChzbGFi
X2ZsYWdzX3QgX19mb3JjZSkweDAwODAwMDAwVSkNCj4gKyNkZWZpbmUgU0xBQl9OT0xFQUtUUkFD
RSAgICAgICBfX1NGX0JJVChfU0xBQl9OT0xFQUtUUkFDRSkNCj4gDQo+ICAvKg0KPiAgICogUHJl
dmVudCBtZXJnaW5nIHdpdGggY29tcGF0aWJsZSBrbWVtIGNhY2hlcy4gVGhpcyBmbGFnIHNob3Vs
ZCBiZSB1c2VkDQo+IEBAIC0xMTksMjMgKzE1OCwyMyBAQA0KPiAgICogLSBwZXJmb3JtYW5jZSBj
cml0aWNhbCBjYWNoZXMsIHNob3VsZCBiZSB2ZXJ5IHJhcmUgYW5kIGNvbnN1bHRlZCB3aXRoIHNs
YWINCj4gICAqICAgbWFpbnRhaW5lcnMsIGFuZCBub3QgdXNlZCB0b2dldGhlciB3aXRoIENPTkZJ
R19TTFVCX1RJTlkNCj4gICAqLw0KPiAtI2RlZmluZSBTTEFCX05PX01FUkdFICAgICAgICAgICgo
c2xhYl9mbGFnc190IF9fZm9yY2UpMHgwMTAwMDAwMFUpDQo+ICsjZGVmaW5lIFNMQUJfTk9fTUVS
R0UgICAgICAgICAgX19TRl9CSVQoX1NMQUJfTk9fTUVSR0UpDQo+IA0KPiAgLyogRmF1bHQgaW5q
ZWN0aW9uIG1hcmsgKi8NCj4gICNpZmRlZiBDT05GSUdfRkFJTFNMQUINCj4gLSMgZGVmaW5lIFNM
QUJfRkFJTFNMQUIgICAgICAgICAoKHNsYWJfZmxhZ3NfdCBfX2ZvcmNlKTB4MDIwMDAwMDBVKQ0K
PiArIyBkZWZpbmUgU0xBQl9GQUlMU0xBQiAgICAgICAgIF9fU0ZfQklUKF9TTEFCX0ZBSUxTTEFC
KQ0KPiAgI2Vsc2UNCj4gICMgZGVmaW5lIFNMQUJfRkFJTFNMQUIgICAgICAgICAwDQo+ICAjZW5k
aWYNCj4gIC8qIEFjY291bnQgdG8gbWVtY2cgKi8NCj4gICNpZmRlZiBDT05GSUdfTUVNQ0dfS01F
TQ0KPiAtIyBkZWZpbmUgU0xBQl9BQ0NPVU5UICAgICAgICAgICgoc2xhYl9mbGFnc190IF9fZm9y
Y2UpMHgwNDAwMDAwMFUpDQo+ICsjIGRlZmluZSBTTEFCX0FDQ09VTlQgICAgICAgICAgX19TRl9C
SVQoX1NMQUJfQUNDT1VOVCkNCj4gICNlbHNlDQo+ICAjIGRlZmluZSBTTEFCX0FDQ09VTlQgICAg
ICAgICAgMA0KPiAgI2VuZGlmDQo+IA0KPiAgI2lmZGVmIENPTkZJR19LQVNBTl9HRU5FUklDDQo+
IC0jZGVmaW5lIFNMQUJfS0FTQU4gICAgICAgICAgICAgKChzbGFiX2ZsYWdzX3QgX19mb3JjZSkw
eDA4MDAwMDAwVSkNCj4gKyNkZWZpbmUgU0xBQl9LQVNBTiAgICAgICAgICAgICBfX1NGX0JJVChf
U0xBQl9LQVNBTikNCj4gICNlbHNlDQo+ICAjZGVmaW5lIFNMQUJfS0FTQU4gICAgICAgICAgICAg
MA0KPiAgI2VuZGlmDQo+IEBAIC0xNDUsMTAgKzE4NCwxMCBAQA0KPiAgICogSW50ZW5kZWQgZm9y
IGNhY2hlcyBjcmVhdGVkIGZvciBzZWxmLXRlc3RzIHNvIHRoZXkgaGF2ZSBvbmx5IGZsYWdzDQo+
ICAgKiBzcGVjaWZpZWQgaW4gdGhlIGNvZGUgYW5kIG90aGVyIGZsYWdzIGFyZSBpZ25vcmVkLg0K
PiAgICovDQo+IC0jZGVmaW5lIFNMQUJfTk9fVVNFUl9GTEFHUyAgICAgKChzbGFiX2ZsYWdzX3Qg
X19mb3JjZSkweDEwMDAwMDAwVSkNCj4gKyNkZWZpbmUgU0xBQl9OT19VU0VSX0ZMQUdTICAgICBf
X1NGX0JJVChfU0xBQl9OT19VU0VSX0ZMQUdTKQ0KPiANCj4gICNpZmRlZiBDT05GSUdfS0ZFTkNF
DQo+IC0jZGVmaW5lIFNMQUJfU0tJUF9LRkVOQ0UgICAgICAgKChzbGFiX2ZsYWdzX3QgX19mb3Jj
ZSkweDIwMDAwMDAwVSkNCj4gKyNkZWZpbmUgU0xBQl9TS0lQX0tGRU5DRSAgICAgICBfX1NGX0JJ
VChfU0xBQl9TS0lQX0tGRU5DRSkNCj4gICNlbHNlDQo+ICAjZGVmaW5lIFNMQUJfU0tJUF9LRkVO
Q0UgICAgICAgMA0KPiAgI2VuZGlmDQo+IEBAIC0xNTYsOSArMTk1LDkgQEANCj4gIC8qIFRoZSBm
b2xsb3dpbmcgZmxhZ3MgYWZmZWN0IHRoZSBwYWdlIGFsbG9jYXRvciBncm91cGluZyBwYWdlcyBi
eSBtb2JpbGl0eSAqLw0KPiAgLyogT2JqZWN0cyBhcmUgcmVjbGFpbWFibGUgKi8NCj4gICNpZm5k
ZWYgQ09ORklHX1NMVUJfVElOWQ0KPiAtI2RlZmluZSBTTEFCX1JFQ0xBSU1fQUNDT1VOVCAgICgo
c2xhYl9mbGFnc190IF9fZm9yY2UpMHgwMDAyMDAwMFUpDQo+ICsjZGVmaW5lIFNMQUJfUkVDTEFJ
TV9BQ0NPVU5UICAgX19TRl9CSVQoX1NMQUJfUkVDTEFJTV9BQ0NPVU5UKQ0KPiAgI2Vsc2UNCj4g
LSNkZWZpbmUgU0xBQl9SRUNMQUlNX0FDQ09VTlQgICAoKHNsYWJfZmxhZ3NfdCBfX2ZvcmNlKTAp
DQo+ICsjZGVmaW5lIFNMQUJfUkVDTEFJTV9BQ0NPVU5UICAgMA0KPiAgI2VuZGlmDQo+ICAjZGVm
aW5lIFNMQUJfVEVNUE9SQVJZICAgICAgICAgU0xBQl9SRUNMQUlNX0FDQ09VTlQgICAgLyogT2Jq
ZWN0cyBhcmUgc2hvcnQtbGl2ZWQgKi8NCj4gDQo+IGRpZmYgLS1naXQgYS9tbS9zbHViLmMgYi9t
bS9zbHViLmMNCj4gaW5kZXggMmVmODhiYmY1NmEzLi5hOTNjNWExN2NiYmIgMTAwNjQ0DQo+IC0t
LSBhL21tL3NsdWIuYw0KPiArKysgYi9tbS9zbHViLmMNCj4gQEAgLTMwNiwxMyArMzA2LDEzIEBA
IHN0YXRpYyBpbmxpbmUgYm9vbCBrbWVtX2NhY2hlX2hhc19jcHVfcGFydGlhbChzdHJ1Y3QNCj4g
a21lbV9jYWNoZSAqcykNCj4gDQo+ICAvKiBJbnRlcm5hbCBTTFVCIGZsYWdzICovDQo+ICAvKiBQ
b2lzb24gb2JqZWN0ICovDQo+IC0jZGVmaW5lIF9fT0JKRUNUX1BPSVNPTiAgICAgICAgICAgICAg
ICAoKHNsYWJfZmxhZ3NfdCBfX2ZvcmNlKTB4ODAwMDAwMDBVKQ0KPiArI2RlZmluZSBfX09CSkVD
VF9QT0lTT04gICAgICAgICAgICAgICAgX19TRl9CSVQoX1NMQUJfT0JKRUNUX1BPSVNPTikNCj4g
IC8qIFVzZSBjbXB4Y2hnX2RvdWJsZSAqLw0KPiANCj4gICNpZmRlZiBzeXN0ZW1faGFzX2ZyZWVs
aXN0X2FiYQ0KPiAtI2RlZmluZSBfX0NNUFhDSEdfRE9VQkxFICAgICAgICgoc2xhYl9mbGFnc190
IF9fZm9yY2UpMHg0MDAwMDAwMFUpDQo+ICsjZGVmaW5lIF9fQ01QWENIR19ET1VCTEUgICAgICAg
X19TRl9CSVQoX1NMQUJfQ01QWENIR19ET1VCTEUpDQo+ICAjZWxzZQ0KPiAtI2RlZmluZSBfX0NN
UFhDSEdfRE9VQkxFICAgICAgICgoc2xhYl9mbGFnc190IF9fZm9yY2UpMFUpDQo+ICsjZGVmaW5l
IF9fQ01QWENIR19ET1VCTEUgICAgICAgMA0KPiAgI2VuZGlmDQo+IA0KPiAgLyoNCj4gDQo+IC0t
DQo+IDIuNDMuMQ0KDQo=

