Return-Path: <linux-kernel+bounces-128850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D496A896086
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 02:11:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C9DE1F241B1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 00:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A299EC7;
	Wed,  3 Apr 2024 00:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="jPEzuOIO"
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC57635
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 00:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712103089; cv=fail; b=QVb0GuLue8Rptpg+uZfvG0Z924EEs84rHmePP0KK+N3sDTjb+gXxYiDsKSsFqfzndQ66o/o0HguARSIe58b5EYeseBLc4KdaRu+hyCTL4ookG9Uzp48EKA+W1Gz80xFzVCdKGXui9HdazRtLVja4UsFL6tkOSGz6fX0G2UDBdWY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712103089; c=relaxed/simple;
	bh=KJKbcgW+hD0T9oBKFDT5dmMN+oRpA/5j+X47fRCGA00=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cWsIf7L+av3ggDpWiu4nEggqfKYc7OvA5nhgb+w7uR2vQ4+LNp6sWQLGyP1rF0iz6H+Hr7qgDKS/S48uVcoNpEZ35h7WUn+71ZpF+/CC2iDJ0hQ4u3KLoCZ9FbMmQSTNvepf0y05ZlzSMxvxQwSt1O9Olwv5wH6faOoeo2MVe58=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=jPEzuOIO; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 432NcRpG028113;
	Tue, 2 Apr 2024 17:10:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	PPS06212021; bh=KJKbcgW+hD0T9oBKFDT5dmMN+oRpA/5j+X47fRCGA00=; b=
	jPEzuOIOcDsBKWZ198evNS8zgpzwLGhvbI5fVpWem4Z3ofyUEIU4btYDamnNXvvl
	O5ON++DYOoOaMEtzeBp+EfVAtZ5zPNOvyS100U7glwRbfgvC1TJS92e3mDxidRKL
	xlbxZ4Vob8HlNpb04EgMHZq0tNDh8/iQ/Db+guxPegm35zs3zgdFPdnkKslIkGpa
	867o3/HhqTh1mCl5KIbMfBeTKNxEAw22nCxABATxi+IwrckezSdgVXOa9pclBK7z
	w9MBPYAgo2t0NyG/1G0qFK3kWJwLhB/UTjn/E1ZrHa0KLmybKMbr44yTQrXCW4J2
	XmGUbIrIUSh7NO2fEusqpw==
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2041.outbound.protection.outlook.com [104.47.73.41])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3x6j8fuedq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Apr 2024 17:10:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WSbaEWBm/dOvIGhGLklGhwfa85a0hLmYuWvI74tDVIS/Va2mTMMa3BLES8GakeM7grJiz8il5+1luQTlZ6VWfvOnnWfR15Kh49nhp32ygEdK9wto7a0CVHVLf5gEO6O5X7O/Ri+DfV82MnGvfSZC2ZIPFMEMvHXu9UJv4swovxDQrbIRuO61iwumhEzNM/gK/nkHq+sDRsOo57K8E9iYwm6NiMz5Cw61aTl0Tmc5VolsE/vSMLy18G6/x/MR1Li/coRhfIqYNo/lueu69/DsBmJ0Mk6VdC4nWAGYCOd6vr+31aBzaHHehIZ4l0cmiJRDWuYwFL5b8k3X3fvBCVAD6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KJKbcgW+hD0T9oBKFDT5dmMN+oRpA/5j+X47fRCGA00=;
 b=IhJj7j5IF8dhbrXhgUJ+zmtNrnlbxp9nYr2JI8DNPrCBGcf6eIftwt3nPp/3UtS90ZWBDl+lMNJ12ngr5TTVnQOU6N1jNeKL9WPXB/GXH6cmAwDZTYfn5Ifj2T/CPBQypm2CLEkg6tG5ROKLb7l3DS2J8TGXfb803XHrS9Wv9tOo8w09n7ryNeS+MFqOLj/llEk8qoPVm+FLym9B9xGtl/xuEHKx2JYaVJ/+rgrd0HF9Zz86BKP5d9mTtEOr5JN0i+tetm7bkX3EJ3dY274SFAdSOoE+fvNJnLSPEkNULrKJtnjUwMznpXqA8sN/Hee9M1yNz/4srTx9SoNpJRloNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from PH0PR11MB5192.namprd11.prod.outlook.com (2603:10b6:510:3b::9)
 by SJ0PR11MB5865.namprd11.prod.outlook.com (2603:10b6:a03:428::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26; Wed, 3 Apr
 2024 00:10:43 +0000
Received: from PH0PR11MB5192.namprd11.prod.outlook.com
 ([fe80::8cb4:86ac:461a:d683]) by PH0PR11MB5192.namprd11.prod.outlook.com
 ([fe80::8cb4:86ac:461a:d683%4]) with mapi id 15.20.7452.019; Wed, 3 Apr 2024
 00:10:43 +0000
From: "Song, Xiongwei" <Xiongwei.Song@windriver.com>
To: Vlastimil Babka <vbabka@suse.cz>,
        "rientjes@google.com"
	<rientjes@google.com>,
        "cl@linux.com" <cl@linux.com>,
        "penberg@kernel.org"
	<penberg@kernel.org>,
        "iamjoonsoo.kim@lge.com" <iamjoonsoo.kim@lge.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "roman.gushchin@linux.dev" <roman.gushchin@linux.dev>,
        "42.hyeyoo@gmail.com"
	<42.hyeyoo@gmail.com>
CC: "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "chengming.zhou@linux.dev"
	<chengming.zhou@linux.dev>
Subject: RE: [PATCH 1/4] mm/slub: remove the check of
 !kmem_cache_has_cpu_partial()
Thread-Topic: [PATCH 1/4] mm/slub: remove the check of
 !kmem_cache_has_cpu_partial()
Thread-Index: AQHagxH14quITHXAzku3ASSei3Yft7FUvu2AgADxhHA=
Date: Wed, 3 Apr 2024 00:10:42 +0000
Message-ID: 
 <PH0PR11MB5192481170379F35BF292E82EC3D2@PH0PR11MB5192.namprd11.prod.outlook.com>
References: <20240331021926.2732572-1-xiongwei.song@windriver.com>
 <20240331021926.2732572-2-xiongwei.song@windriver.com>
 <d5a7f24c-52e6-471c-893e-44448efccbd4@suse.cz>
In-Reply-To: <d5a7f24c-52e6-471c-893e-44448efccbd4@suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5192:EE_|SJ0PR11MB5865:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 gfQ+eXeIuvtfOMbcovzbIsvyu2VKDi2+ody2ChvYn11Wm3fh8HEWkdqafUzRavdSVCt3mc1nDVtw1WTvNF4u4ZhUfJR/Q3PelSKBCKVfTELl/mshAiSewUUjOjfdyp/rMD8Hd8JC931SEq+z33r4XSVRFfN8FVp7a8HKRxwfrvAKYmikHra8RHh/uvy4+lflRnpGKrHz6q4SIii/wfe29A2FuzVIw1nhGIx2yikCQbyWOcINgLvjtHoYvPC3++WzwvTX6aL7ot/f60QsT/PgjSbKaeiUQMBuXrNLsO+Dzxij3EoCCot3uNk5EoOaMQYqISqq6OlU7q7obrZS5YVh3Eh6V4koQlBr/zYAocNxvo57XU97aKy7reCHfna6qu7NVzts7igEYvf35le0F06WOhnorqx/eIY8TpasXbm56b7EUCqxVrLveaC7XQ414t6lgXtRdgojOW7uwQJnju5KhuoWkcovFiVUQdWYVOlPbxSZkMTrC+kp1Z9P/qDos2mKop6Mt6iS9t3KemXaRvNc23bY34H7J+M+EY33zatNtV/lscRAMcB5CepMRM5tTbd0ZxZveWG4zlYKU/QXk5V4qhBo+mXrJer1gav3Svqk13yBekZAyN9op4snmJeHGn280EfV54XKnSJ7yTFEO0Cj3AOyvOwjM/3XWs+qg41rOg0=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5192.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(7416005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?bmtaVy9zRU93VnY0blAva05KSWJsY1htYkh4Y1Q4UURKaUJWN1BBYnZCMGw5?=
 =?utf-8?B?aGVZamJheE8rOEZaaVZKMC91dGZEOUxoYkRYSDNRRlZSSitMbURCWG5SWFg1?=
 =?utf-8?B?c3ZnTzVlLzFjSHEwZjZuR3hBSUw5Z0pmY1A3VWRhTTBOdFBzcWZOR0Flckpi?=
 =?utf-8?B?c0dMMzR5VWhlQ0loT1doc2lyaWFVbW53aC9PRGd3L2tmVU81b0dCcVVodm5R?=
 =?utf-8?B?WlhaOVBUS0p4ejYxVUc1UnRNOEgySExiZTYvVEprVk5xeGJIall5ZkVDVXBl?=
 =?utf-8?B?OEFvQzRSU0prZ293YS96ek5XdE9TUS9JckFOTnEyQlRJakd4YXhNM0VOQzZU?=
 =?utf-8?B?OGJQNjVJRTZIUGF0T2ljK0JHK3RSZnpaUURoSEY5eEJPRi9Bbi93K25VYWtv?=
 =?utf-8?B?RHRQcDl2cXhtbnF6ZWdRb3oxOFV6cXd4ZWxIVVcyK1NSZVN4aU1OdUJmK21n?=
 =?utf-8?B?NExuejNMQ1NSb21XTmtvWnhscE8xYm4xZ3pqaHFrSWw2eWNFaE90OGtwRzdV?=
 =?utf-8?B?aUhpOGtXTGV3aW5uam90dXJPUnREeUZGOXRra1Q3bFBtT0N4Y0ZVZEVYd0Nl?=
 =?utf-8?B?ZUFiOGRCUXVDY1pJcHhUM3V3STRqSVlwaTJDaVJBd1dFYkYrYWtPdXRIMFNO?=
 =?utf-8?B?TFlvUjcxa3YxVE1RazF0MW8xa0JBTkloV2dTQXdMTElSR0JwUW1JczgxQmRq?=
 =?utf-8?B?RGMwZEI4SjhNRDlnNWlTT0RWY3NPZSt3amsvRWJteFhlTFgyMkxnUEUyV3la?=
 =?utf-8?B?WnRLWEt5UVlNaVk4NElKVWhUeWNtY05WVGJUREFtUFRUcEJ1R2gvbXVFYmxX?=
 =?utf-8?B?WUR6NFRYWlJhaFBTMkhuUjZNenczSUo4U2V6WHo1bkxGSkpoaG1aSnloUndl?=
 =?utf-8?B?S3JGVzZHcXAvYWp3bEtrYnJrRjVCOWJiZ1ZDOEpNT0s5OS9taldBa211Z29H?=
 =?utf-8?B?NlJnM3d3UGZQM0JWQWlRNDA2ZUdmT2tTUElLZlc2YjJIbXBINi9reHlhRnlq?=
 =?utf-8?B?UjdQclhSWXc4RjRsd1N0OXp0MDQ4M2dMTjJmMXBxbXJDd2ZlN25ubi9hWDQ1?=
 =?utf-8?B?SUNTZFBiMTRrbDhJdmlESm02ZVFvMVZuSDErWlBFaVhzcllOSUdLdit1SE1w?=
 =?utf-8?B?VGliYkd2UnFNTkpGSC96anVhYkVGZ25RckIvQUs2R1phcjBPUlZDY1FFMFhC?=
 =?utf-8?B?amhaWXFZYUFUOUN2b0VtTGFCbm5HMFNseTYzek9zOHBSY2pMRkJXSHJJdzhj?=
 =?utf-8?B?SWxMQ2VlNyt3OElIZDcrTDAyVTk4c0xxR2NVd0x3bDhzNDg1bzNOd1ZxRGFV?=
 =?utf-8?B?dEZRdHhxc05naURDTmZhYnVvL0toQUc2OGpkeFRqVlJEL050QmQ3MzBoRVFw?=
 =?utf-8?B?V1dQTk5CYVVUWWFKQmY3a1BWR290bXo0VTFuVy84REFQeUxkTnlBZ0ZqNWdF?=
 =?utf-8?B?eWhPSS9GRU5zRUFrMTl6a053VElUZ2hVSFd1Wk5pdHZUd3VhTlN5ZEIyNGxU?=
 =?utf-8?B?RVBpcVpLM3ZlYll5SUw1V2V1bHl0RFBCRjZPcTdENk5janBpbFJuTVRtaVVo?=
 =?utf-8?B?UlZQaUQrSUl3OUFzalUyRjNybUJWY3dWUkxObVduRThPVDdQM2h2WGVINTM4?=
 =?utf-8?B?S1grL3dTM0tBNXVueWJ2M1pheUNwZ3BqUjR4UGRWU3UyWDIvMTBmWlFXVVNq?=
 =?utf-8?B?WWk0bXhKOVhLNFBRdXRrZE1lUG9lTzFyOEpoQzBGRndIL0txamZHRm80a2sr?=
 =?utf-8?B?endXT0dQVW04ckhmb1lrMmI1Zkl4Y2FuVmVyTktKeUthOHYvazBzNm1UeW9i?=
 =?utf-8?B?cER1djEvYWJ0REthTnZWMG5QMmkxaTJobFMxbDVEcXlSR3pNZ2VqdGMzeGwx?=
 =?utf-8?B?eU1rTU1oZ3dFMVdVam52akNXUG1JbXRiaStIS2FPeEJNcmhDRytFdFI0cWFE?=
 =?utf-8?B?NkEzVUFtRWlvcFRVelpCdk81QU5aR0M3RFFodit1bituWnB0dDlXZmRsdDZk?=
 =?utf-8?B?YkJyMG9TY01GOHhGeGRobEhrbEl6ejU5NzNrdlpqUUxDRkZUTFdJd240c1I2?=
 =?utf-8?B?a2lwUEZZQjdXanVLOFdoRzdoWjRoRTZLZ01ubGcycEM3VWJwNmdITEZ0Nmp1?=
 =?utf-8?B?SjFFWk9PUkNBZzBLTzBCUmo4RlZROEp3RjJOanF1dW82UXR0ejMzU0Yzd216?=
 =?utf-8?B?NHc9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 955aec72-8549-40e5-f703-08dc537280a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2024 00:10:42.9020
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4JDbwwmq6+USadd+a+oQZgXHdwmOvK5ithw3anU1oVrtIGb9oUzmilzn7k06zBmqAJ02Vl35dNEIH8JALbo+kJjhtwf/NELmo4w4w63QzVQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5865
X-Proofpoint-ORIG-GUID: eA0jwXgbRZD9H3J4cj7jqp5Tj8L1IdW0
X-Proofpoint-GUID: eA0jwXgbRZD9H3J4cj7jqp5Tj8L1IdW0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-02_15,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 spamscore=0 suspectscore=0 clxscore=1015 mlxscore=0 lowpriorityscore=0
 adultscore=0 malwarescore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2403210001
 definitions=main-2404020178

PiANCj4gT24gMy8zMS8yNCA0OjE5IEFNLCB4aW9uZ3dlaS5zb25nQHdpbmRyaXZlci5jb20gd3Jv
dGU6DQo+ID4gRnJvbTogWGlvbmd3ZWkgU29uZyA8eGlvbmd3ZWkuc29uZ0B3aW5kcml2ZXIuY29t
Pg0KPiA+DQo+ID4gVGhlIGNoZWNrIG9mICFrbWVtX2NhY2hlX2hhc19jcHVfcGFydGlhbChzKSB3
aXRoDQo+ID4gQ09ORklHX1NMVUJfQ1BVX1BBUlRJQUwgZW5hYmxlZCBoZXJlIGlzIGFsd2F5cyBm
YWxzZS4gV2UgaGF2ZSBrbm93biB0aGUNCj4gPiByZXN1bHQgYnkgY2FsbGluZyBrbWVtX2NhY2tl
X2RlYnVnKCkuIEhlcmUgd2UgY2FuIHJlbW92ZSBpdC4NCj4gDQo+IENvdWxkIHdlIGJlIG1vcmUg
b2J2aW91cy4gV2UgaGF2ZSBhbHJlYWR5IGNoZWNrZWQga21lbV9jYWNoZV9kZWJ1ZygpIGVhcmxp
ZXINCj4gYW5kIGlmIGl0IHdhcyB0cnVlLCB0aGUgd2UgZWl0aGVyIGNvbnRpbnVlZCBvciBicm9r
ZSBmcm9tIHRoZSBsb29wIHNvIHdlDQo+IGNhbid0IHJlYWNoIHRoaXMgY29kZSBpbiB0aGF0IGNh
c2UgYW5kIGRvbid0IG5lZWQgdG8gY2hlY2sNCj4ga21lbV9jYWNoZV9kZWJ1ZygpIGFzIHBhcnQg
b2Yga21lbV9jYWNoZV9oYXNfY3B1X3BhcnRpYWwoKSBhZ2Fpbi4NCg0KT2ssIGxvb2tzIGJldHRl
ci4gV2lsbCB1cGRhdGUuDQoNClRoYW5rcywNClhpb25nd2VpDQoNCj4gDQo+ID4gU2lnbmVkLW9m
Zi1ieTogWGlvbmd3ZWkgU29uZyA8eGlvbmd3ZWkuc29uZ0B3aW5kcml2ZXIuY29tPg0KPiA+IC0t
LQ0KPiA+ICBtbS9zbHViLmMgfCAzICstLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRp
b24oKyksIDIgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvbW0vc2x1Yi5jIGIv
bW0vc2x1Yi5jDQo+ID4gaW5kZXggMWJiMmE5M2NmN2I2Li4wNTk5MjIwNDRhNGYgMTAwNjQ0DQo+
ID4gLS0tIGEvbW0vc2x1Yi5jDQo+ID4gKysrIGIvbW0vc2x1Yi5jDQo+ID4gQEAgLTI2MTAsOCAr
MjYxMCw3IEBAIHN0YXRpYyBzdHJ1Y3Qgc2xhYiAqZ2V0X3BhcnRpYWxfbm9kZShzdHJ1Y3Qga21l
bV9jYWNoZSAqcywNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgcGFydGlhbF9zbGFicysrOw0K
PiA+ICAgICAgICAgICAgICAgfQ0KPiA+ICAjaWZkZWYgQ09ORklHX1NMVUJfQ1BVX1BBUlRJQUwN
Cj4gPiAtICAgICAgICAgICAgIGlmICgha21lbV9jYWNoZV9oYXNfY3B1X3BhcnRpYWwocykNCj4g
PiAtICAgICAgICAgICAgICAgICAgICAgfHwgcGFydGlhbF9zbGFicyA+IHMtPmNwdV9wYXJ0aWFs
X3NsYWJzIC8gMikNCj4gPiArICAgICAgICAgICAgIGlmIChwYXJ0aWFsX3NsYWJzID4gcy0+Y3B1
X3BhcnRpYWxfc2xhYnMgLyAyKQ0KPiA+ICAgICAgICAgICAgICAgICAgICAgICBicmVhazsNCj4g
PiAgI2Vsc2UNCj4gPiAgICAgICAgICAgICAgIGJyZWFrOw0KDQo=

