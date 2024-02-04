Return-Path: <linux-kernel+bounces-51377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28DDC848A5B
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 03:07:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8365284720
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 02:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 126366FD1;
	Sun,  4 Feb 2024 02:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="DFoc+/ts"
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A944696
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 02:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707012468; cv=fail; b=a66bJvJFlKO3DnBjy48mfm/snzgCsq02WhaHd/EwHazOPfItUXWQIXvZAIJePy7hSKEin90yg1RyRTRg23mgMjUv44ku+c1s6LAItLfQ7otMsUwsxRqyyK04mzgFwTp/Ra7XEtxx/DbD278r++cyt5yCkIgFmtl2nsQ41wNsXb4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707012468; c=relaxed/simple;
	bh=CQqxy1pIHi1u17tS5jU3seOiW+cANoONqsqr5kp4SUo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=q/1TnQ8uMub8BC1iBRNZ7dcAGCA+d6AZnNA1u7nxE/y5dyxRYr6qOn3kUSGrcQJVWjAPOt3tP+EIAds5DGd6VwipumkbA//tRBLKL0ocikCoT6FbISmrNwvGFUX9MuB3mVNtZpisL0teHRNKS1LCP2Dr96t4wFdZ5RFxKkfRjVs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=DFoc+/ts; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4141sbXj024366;
	Sat, 3 Feb 2024 18:06:16 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	PPS06212021; bh=CQqxy1pIHi1u17tS5jU3seOiW+cANoONqsqr5kp4SUo=; b=
	DFoc+/tsYWgUOBJNQIvBywfH4Tmtboe/KF03b4omEKqNYcGrPwe2MmQn7Xn/CJOS
	M4A0Q/XImAAyHWtiG2XP5e6uNYMv+GpqBfVBrajug2mtij5Xi4vfpEow6B0ZuJOO
	JLdD60Smy/ZztUWsOiZfdNCmpsJolLWUtqD7d3U6MjvV2NAn2ErrezFSuXX8b9AT
	prf7htt7UIarXVZNDq+1bh2TlVzAb9K4lNWayQiXMUKF6WrGPJmnfB6MvrpeX+H6
	AbpsdOcvL8M/9ae2XZ0ki3O1D1YSDgX2WoPOSjDLFMvLZP/nzpiPX0rVJa9j+8BF
	r05TjLzD7+kI1DlVbid0kQ==
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2168.outbound.protection.outlook.com [104.47.73.168])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3w1nvm0cjq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 03 Feb 2024 18:06:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V0WytuANySkXABdItm5kotZh3HauJ5/UaR1/yvS93/oNFb7SgvZOyM+iItHUFHXKNMmdPjtf466ee3Y6KNNB/ODIyHOnrn7iOVmhT5dWutD65RHZhI+p5bGDSDnFdYKTfUqDv3odb+4nKPUOg0MFqcyrzD3Kt5qFHDAEs0N3InWCTxsGKMEZlSAgPgGPYst06sin/9b+PdX2OVQI3OhARpZNBjiuM3VWhqU/rnXYqvDBE8S2+OSZDeUwQOTESOnHhc8EgCDMgURDq8dfVzg9rRPE4z6BNF8x8YZFPfH2HlUe+UmHMkMas98PlQDho42UBGSSYsSx+o/HNzkRESoouA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CQqxy1pIHi1u17tS5jU3seOiW+cANoONqsqr5kp4SUo=;
 b=mNApdmV0ut/fxouSyvJ/VUbGqPMUzrhKBZ8XycyKsLnvw9ugbII/7Fd9E76+ISjseIwwiFZ72wuVvfumK4HIObQvTQM0RJ/I+yrTJRgjF8T06cknQ0EqcIXm+1DD71RdRhHZ/Pnk5401AHFfVCUhiMZnNERu39G/QFdDUE8sXoC+OY+ic99nbIxODg36WK269o2VkGMSQJwrNye/0ywEqVauNdNbhD7kFHTcw9FvAEcVyHtNkc9uq66wUqZLGXWzNF9N69qzfuBxnJRbXifOQBBYuvj7bE9/Sa8A5B3l1D2NxjI6R+oIgnXsaB6AgC7se6FB+EXTT9ACUOyU8pyCbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from PH0PR11MB5192.namprd11.prod.outlook.com (2603:10b6:510:3b::9)
 by PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.33; Sun, 4 Feb
 2024 02:06:11 +0000
Received: from PH0PR11MB5192.namprd11.prod.outlook.com
 ([fe80::230c:58c0:c3f9:b5f3]) by PH0PR11MB5192.namprd11.prod.outlook.com
 ([fe80::230c:58c0:c3f9:b5f3%3]) with mapi id 15.20.7249.032; Sun, 4 Feb 2024
 02:06:11 +0000
From: "Song, Xiongwei" <Xiongwei.Song@windriver.com>
To: Chengming Zhou <chengming.zhou@linux.dev>,
        Vlastimil Babka
	<vbabka@suse.cz>, Yosry Ahmed <yosryahmed@google.com>,
        Steven Rostedt
	<rostedt@goodmis.org>
CC: LKML <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org"
	<linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus
 Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>, Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Chengming Zhou
	<zhouchengming@bytedance.com>,
        Zheng Yejian <zhengyejian1@huawei.com>
Subject: RE: Do we still need SLAB_MEM_SPREAD (and possibly others)?
Thread-Topic: Do we still need SLAB_MEM_SPREAD (and possibly others)?
Thread-Index: AQHaVJOwDQcymv+I4UO4s807/1z5zrD0f7qAgAAEDwCAAIJ+gIAEbPWA
Date: Sun, 4 Feb 2024 02:06:10 +0000
Message-ID: 
 <PH0PR11MB519280092AA66FAE6BB3FACEEC402@PH0PR11MB5192.namprd11.prod.outlook.com>
References: <20240131172027.10f64405@gandalf.local.home>
 <CAJD7tkYCrFAXLey-WK8k1Nkt4SoUQ00GWNjU43HJgaLqycBm7Q@mail.gmail.com>
 <61af19ca-5f9a-40da-a04d-b04ed27b8754@suse.cz>
 <698633db-b066-4f75-b201-7b785819277b@linux.dev>
In-Reply-To: <698633db-b066-4f75-b201-7b785819277b@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5192:EE_|PH0PR11MB4839:EE_
x-ms-office365-filtering-correlation-id: fe2cdb94-a818-479e-9486-08dc2525dbb8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 KFfQvtONS7lBYtlyxhnft96xEOHl/ww87Sa4E2yOyliAxJBSZftOX1E3oa+62vrT4+n5NgCm7sjtjGN8rP+CwBeIHj1dffTqWpnjiHJjah2qkNcrniALkew8YfFumaDScuX8MRaO3FWLctQvLnmHPbwjL/tkxiTKoAum44FQ2vVGHP3AO3k9aFazPKxe1HOvWmb4NH9KC0OeusH59XuPs6HLf3XNon8nKPUxLXfroDit+Ha6TIkrge1yHfws38AS+lBoOux3NeLfzHjMbgqczZzGM4pMY4Xec2xDlMX9t0scgOhUOJwb5/0zPhRpBXE23VTbPKbMq1tpaWQ6GANgE5qLvqda3YuA5CHDPsxyUSM6/UnMqxDmfDRkAg3aJybmdmub4sqpwFgcUMv4LyTPaDVmg1GKaVjQOd5AYgzKlZtHVfI9B9Pp70mI5ZypQEOgkLFw3X6V/C45q04uOjuXmjAaxNPvkLEx+XZtlg/wtVdWOiQOhP56EN/FMqalauxm+z2KSFbRK2JAwhFjgYnp0FvLfJcfNbbUsWC8btapquRW4W9TrjVeStmUgUMaEYnkBJx6Snfz5q4jsUtfFY1lrEAkGqDuG9hYltw8ATHciCdgaFzqhuzEnfMmcggEC6C2
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5192.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39840400004)(346002)(376002)(396003)(366004)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(55016003)(33656002)(41300700001)(9686003)(53546011)(478600001)(38070700009)(86362001)(26005)(83380400001)(7416002)(5660300002)(2906002)(54906003)(316002)(66946007)(64756008)(66556008)(66476007)(66446008)(6506007)(71200400001)(7696005)(52536014)(38100700002)(8936002)(8676002)(110136005)(76116006)(4326008)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?UWxKNGFnTHl4aXpmOG01TlBxOGo5VEpENEpTR1Jhd0VBeGhSZWRNRHNucDBx?=
 =?utf-8?B?UHl6ak5jei9PMXRuSDdpMHZBR2lxMzl2cTdINTRUMjhUNThoNE1LK3JNYUxv?=
 =?utf-8?B?ZVFsL3NIbnZSN0Q0aGI5SG5uNk5uVE80WFVYcWpueEkydUhwMHd6WndmSm84?=
 =?utf-8?B?Qm1hWGdyRzJaS1hMWDV2bk51Q0dWdkFBejNQM2NWSVdRaklBL3pIdm1oaWVZ?=
 =?utf-8?B?UUpWRnY4OTljTFM4d2NzSDkrVjhNK0pJTTdQanR6c3R5MFBhZC80dVRyMmlW?=
 =?utf-8?B?M2xNSmNvcUYzSmJmdlB0TnFZRnJ1dE1zc3JIcG1jL0wxK1NLS2pxdVVoalBw?=
 =?utf-8?B?dDZrOGoyNU1OQkEzZ2xUVkZHUnlVbmk2Z3hnVHBzMk5NZUxTc3dHZUJaZW82?=
 =?utf-8?B?cFFLcHRZQzdENVd1VTdhR2xNMDFzQWgrSDU0dTlsMzRVemNkajFnT2s3VThG?=
 =?utf-8?B?dHBZVG55bHR2dlNSVzlNSjZ3M1VNQTdPKzJzRmxNMVRjOGx5QmtVRVNJVS8v?=
 =?utf-8?B?ZXRUa2c4RG9uZmxrYnBsWTVVZWtkdCtPOTZvaUZreG9qTG54K1VKTFRIZVdS?=
 =?utf-8?B?YSswL0xERk53bUkvTU1KblErWEcvT0wrQnhPSVJDc2dRMjZpdzVFVDFua0xi?=
 =?utf-8?B?cjdnN0NQTUVQdzIxQXhtMkdGaEFoMUw1QjA5aFNYS0tHRkZ0Y3E4K0tVa1BF?=
 =?utf-8?B?YmJQZTQzbFc4d24wdStPNU9YOENnbitlQ0s2U2thN2tLVTBncTRLS0RHcEU2?=
 =?utf-8?B?SWlPaXJuOVhBVnZXSmhhcE9DUnVxTE9vLzZ3alFLTzM3N0RvWkpndmhDQUdJ?=
 =?utf-8?B?dENobEJKeDRPUWVZRFhIZmdrbTJVNklRTVZMU01jdnJwak5URFhpL3Rma3Rk?=
 =?utf-8?B?a0I5ZmlXTWZXeC9tL1JjRkN5dkd0T0xVcWg4L3UwL0ZrbTRxOTRvQ2pmTkQw?=
 =?utf-8?B?KzFSU2NRVUpDMHIyelhrSkZGNW5od0ZLdkUwK3BaQ3BPTVBJUFE5UmE1eWVq?=
 =?utf-8?B?K1RJY2pKbnVZSkFaMERjYWJIaHlheU55ajJ2bXd2QllnUVZEVGcrOThFenNV?=
 =?utf-8?B?TjlUZmNNSmFvaUNMSlFPaUJuZElMYlpmaTUrcC9VU0pXcUhhbGdIaHhLZ3ZZ?=
 =?utf-8?B?VjZCNWYwWkhROEE3RUd5OVlIOG5Ielh4dVBXWHdDejlpaFY1cHFEdzFqUFJP?=
 =?utf-8?B?Qlh4bXJnTDFlOWFvWGJqdmk3U2s1N3NheEFaZ3B6RkhMZ1NRV1RQbHZTS0xa?=
 =?utf-8?B?ZlYrbDhKUzltbW56UXZaR2N0UHZ6TWtlRjQ0VDRMUklwVHc3UmY0cmVMaWwy?=
 =?utf-8?B?NWxib3VnY2gweEhGTUZKUWlwZ0JpNlBGYmxnOEVkSGtCZExFdDV0UXZtcnhw?=
 =?utf-8?B?UEtyN0FsZWV1eDRMeHpPSlc1UTczR1U1ZmZKRk1lNmIvcEtRc2xST0h1R3dh?=
 =?utf-8?B?K2pOU3NSZnNBTWhNc3VUTytia0thaTBIWUxTYzNzeWRpaHRVQ1RZRTZVcG5z?=
 =?utf-8?B?dkc1L3BCZ0JXTi9ocStwLzJ1U0hFUHVBQ1A5S0pIY1UrbHllM2hOVUtEcTVk?=
 =?utf-8?B?MzF4NjlCRDBLZDgxMVpGdzA1amp2MWd0ZHAwTTlVRjUwcUNJMGk1dUlLNGlZ?=
 =?utf-8?B?Ri81WVR6Qm1SU0I2UjlJa0JwVUlLY1grdEhSaUV2cVNKVzEwZDdpRFd2UURi?=
 =?utf-8?B?dUxrK1QrUWk0aGJKVFBtVXdDb1NmdHI0UDJ1b1lTRHM1UnNMYk8yc3BtYW5s?=
 =?utf-8?B?RmY0WS9INVNwL3FYdFUxOTJGQW9BSkV0bkptSTR3SnRSWnV0RVA0dEcwSjhK?=
 =?utf-8?B?NkowK3pWZ1cvbTZoaDdVcjRGSDRPazFuRStkMzkwTUhGUlhtQlAzOG1sR0hT?=
 =?utf-8?B?OTgveVF3aGg0ZXZ3d0VtWk1nbFo1SEN6dmhNdlpkdG5Gb2xGVnJENmV2bkZW?=
 =?utf-8?B?VVp2dm9QdXZzeFJYVExhNnhIV0Z4NGxTNnMxZWVtWUdpaU1ZL1ZTUUk3b2FX?=
 =?utf-8?B?eks2Z0tnSlVsSzZXSmRtRHJxWXhBRlZOT1hzbW5qQkxBNExiQmtLZXgyOG50?=
 =?utf-8?B?NXFhVlQvVkxGZ3NaemxvUjJMMUZub0tZZTZWN1lKMUJSczBQbXF1WnJ3Uyth?=
 =?utf-8?B?MDkySnQ0em1CWkZDQW0yK2Z6MmdMazF4YkY0Y3BRbUppZ1lVQXVSU2p5cU9E?=
 =?utf-8?B?Z2c9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: fe2cdb94-a818-479e-9486-08dc2525dbb8
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2024 02:06:10.9994
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uK5UEE4zuRSZ/jbGueUgO/Vj0UKjnc0Yg84A3BOLuttd41dCKrQIleLZKa06In/ENYA1sTjByXHkjR50FCrA+QVy+xx+WD787FEvMjdpXpQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4839
X-Proofpoint-GUID: P84EIA7TYsgPDTAd1BUECqcrYz06ztWm
X-Proofpoint-ORIG-GUID: P84EIA7TYsgPDTAd1BUECqcrYz06ztWm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-03_18,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 clxscore=1011 impostorscore=0
 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402040014

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQ2hlbmdtaW5nIFpob3Ug
PGNoZW5nbWluZy56aG91QGxpbnV4LmRldj4NCj4gU2VudDogVGh1cnNkYXksIEZlYnJ1YXJ5IDEs
IDIwMjQgMjoyNyBQTQ0KPiBUbzogVmxhc3RpbWlsIEJhYmthIDx2YmFia2FAc3VzZS5jej47IFlv
c3J5IEFobWVkDQo+IDx5b3NyeWFobWVkQGdvb2dsZS5jb20+OyBTdGV2ZW4gUm9zdGVkdCA8cm9z
dGVkdEBnb29kbWlzLm9yZz4NCj4gQ2M6IExLTUwgPGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5v
cmc+OyBsaW51eC1tbUBrdmFjay5vcmc7IEFuZHJldw0KPiBNb3J0b24gPGFrcG1AbGludXgtZm91
bmRhdGlvbi5vcmc+OyBMaW51cyBUb3J2YWxkcyA8dG9ydmFsZHNAbGludXgtDQo+IGZvdW5kYXRp
b24ub3JnPjsgS2VlcyBDb29rIDxrZWVzY29va0BjaHJvbWl1bS5vcmc+OyBDaHJpc3RvcGggTGFt
ZXRlcg0KPiA8Y2xAbGludXguY29tPjsgRGF2aWQgUmllbnRqZXMgPHJpZW50amVzQGdvb2dsZS5j
b20+OyBIeWVvbmdnb24gWW9vDQo+IDw0Mi5oeWV5b29AZ21haWwuY29tPjsgU29uZywgWGlvbmd3
ZWkgPFhpb25nd2VpLlNvbmdAd2luZHJpdmVyLmNvbT47DQo+IENoZW5nbWluZyBaaG91IDx6aG91
Y2hlbmdtaW5nQGJ5dGVkYW5jZS5jb20+OyBaaGVuZyBZZWppYW4NCj4gPHpoZW5neWVqaWFuMUBo
dWF3ZWkuY29tPg0KPiBTdWJqZWN0OiBSZTogRG8gd2Ugc3RpbGwgbmVlZCBTTEFCX01FTV9TUFJF
QUQgKGFuZCBwb3NzaWJseSBvdGhlcnMpPw0KPiANCj4gDQo+IE9uIDIwMjQvMi8xIDA2OjQwLCBW
bGFzdGltaWwgQmFia2Egd3JvdGU6DQo+ID4gT24gMS8zMS8yNCAyMzoyNSwgWW9zcnkgQWhtZWQg
d3JvdGU6DQo+ID4+IE9uIFdlZCwgSmFuIDMxLCAyMDI0IGF0IDI6MjDigK9QTSBTdGV2ZW4gUm9z
dGVkdCA8cm9zdGVkdEBnb29kbWlzLm9yZz4NCj4gd3JvdGU6DQo+ID4+Pg0KPiA+Pj4gSSB3YXMg
bG9va2luZyBpbnRvIG1vdmluZyBldmVudGZzX2lub2RlIGludG8gYSBzbGFiLCBhbmQgYWZ0ZXIg
Y3V0dGluZyBhbmQNCj4gPj4+IHBhc3RpbmcgdGhlIHRyYWNlZnMgYWxsb2NhdG9yOg0KPiA+Pj4N
Cj4gPj4+ICAgICAgICAgdHJhY2Vmc19pbm9kZV9jYWNoZXAgPSBrbWVtX2NhY2hlX2NyZWF0ZSgi
dHJhY2Vmc19pbm9kZV9jYWNoZSIsDQo+ID4+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgc2l6ZW9mKHN0cnVjdCB0cmFjZWZzX2lub2RlKSwNCj4gPj4+
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAwLCAoU0xB
Ql9SRUNMQUlNX0FDQ09VTlR8DQo+ID4+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIFNMQUJfTUVNX1NQUkVBRHwNCj4gPj4+ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgU0xBQl9BQ0NPVU5UKSwN
Cj4gPj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBp
bml0X29uY2UpOw0KPiA+Pj4NCj4gPj4+IEkgZmlndXJlZCBJIHNob3VsZCBrbm93IHdoYXQgdGhv
c2Ugc2xhYiBmbGFncyBtZWFuLiBJIGFsc28gbG9va2VkIGF0IHdoYXQNCj4gPj4+IG90aGVycyBp
biBmcyB1c2UgZm9yIHRoZWlyIHNsYWJzLiBUaGUgYWJvdmUgaXMgcmF0aGVyIGNvbW1vbiAod2hp
Y2ggSQ0KPiA+Pj4gcHJvYmFibHkganVzdCBjb3BpZWQgZnJvbSBhbm90aGVyIGZpbGUgc3lzdGVt
KSwgYnV0IEkgd2FudGVkIHRvIGtub3cNCj4gd2hhdA0KPiA+Pj4gdGhleSBhcmUgZm9yLg0KPiA+
Pj4NCj4gPj4+IFdoZW4gSSBnb3QgdG8gU0xBQl9NRU1fU1BSRUFELCBJIGZvdW5kIHRoYXQgaXQn
cyBhIGNvbW1vbiBmbGFnIGFuZA0KPiB0aGVyZSdzDQo+ID4+PiBhIGxvdCBvZiBjYWNoZXMgdGhh
dCBqdXN0IHNldCB0aGF0IGFuZCBub3RoaW5nIGVsc2UuDQo+ID4+Pg0KPiA+Pj4gQnV0IEkgY291
bGRuJ3QgZmluZCBob3cgaXQgd2FzIHVzZWQuDQo+ID4+Pg0KPiA+Pj4gVGhlbiBJIGZvdW5kIHRo
aXMgY29tbWl0Og0KPiA+Pj4NCj4gPj4+ICAxNmExZDk2ODM1OGEgKCJtbS9zbGFiOiByZW1vdmUg
bW0vc2xhYi5jIGFuZCBzbGFiX2RlZi5oIikNCj4gPj4+DQo+ID4+PiBXaGljaCBJIHRoaW5rIHJl
bW92ZWQgdGhlIG9ubHkgdXNlIGNhc2Ugb2YgU0xBQl9NRU1fU1BSRUFELg0KPiA+Pj4NCj4gPj4+
ICAkIGdpdCBncmVwIFNMQUJfTUVNX1NQUkVBRCBtbQ0KPiA+Pj4gbW0vc2xhYi5oOiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBTTEFCX01FTV9TUFJFQUQgfCBcDQo+ID4+Pg0KPiA+Pj4gVGhh
dCdzIGFsbCBJIGZpbmQgaW4gdGhlIG1tIGRpcmVjdG9yeS4NCj4gPj4+DQo+ID4+PiBJcyBpdCBv
YnNvbGV0ZSBub3c/IENhbiB3ZSBkZWxldGUgaXQ/IE1heWJlIHRoZXJlJ3Mgb3RoZXIgU0xBQl8q
IGZsYWdzDQo+IHRoYXQNCj4gPj4+IGFyZSBubyBsb25nZXIgdXNlZC4gSSBkb24ndCBrbm93LCBJ
IGhhdmVuJ3QgYXVkaXRlZCB0aGVtLg0KPiA+Pg0KPiA+PiBQZXJoYXBzIGNwdXNldF9kb19zbGFi
X21lbV9zcHJlYWQoKSBhcyB3ZWxsLg0KPiA+DQo+ID4gWWVwLCBnb29kIGZpbmQuIFNob3cgaG93
IG9ic2N1cmUgbW0vc2xhYi5jIHdhcyBpbiB0aGUgZW5kIDopDQo+ID4NCj4gPiBDQ2luZyBhIGZl
dyBtb3JlIG5ldyBwZW9wbGUgd2hvIGRpZCBzbGFiIGNoYW5nZXMgcmVjZW50bHksIHdobydkIGxp
a2UNCj4gc29tZQ0KPiA+IGxvdyBoYW5naW5nIGZydWl0IG9mIG5lZ2F0aXZlIGRpZmZjb3VudD8g
OikNCj4gDQo+IFRoYW5rcyBmb3IgQ0NpbmcsIEkgY2FuIHByZXBhcmUgdGhlIHBhdGNoIHRvIGRv
IGl0LiBJSVVDLCB3aGF0IEkgbmVlZCB0byBkbyBpczoNCj4gDQo+IDEuIGRlbGV0ZSBTTEFCX01F
TV9TUFJFQUQgYW5kIGFsbCBpdHMgdXNlcy4NCj4gDQo+IDIuIGNwdXNldF9kb19zbGFiX21lbV9z
cHJlYWQoKSBpcyBub3QgdXNlZCBhbnltb3JlLCBzaG91bGQgd2Uga2VlcCB0aGUNCj4gaW50ZXJm
YWNlPw0KPiAgICBTaW5jZSBpdCdzIHRoZSBpbnRlcmZhY2UgZXhwb3J0ZWQgYnkgY2dyb3VwLXYx
DQo+ICJjcHVzZXQubWVtb3J5X3NwcmVhZF9zbGFiIi4NCg0KT25jZSBTTEFCX01FTV9TUFJFQUQg
aXMgcmVtb3ZlZCwgSU1PLCBjcHVzZXQubWVtb3J5X3NwcmVhZF9zbGFiIGlzIHVzZWxlc3MuDQoN
ClJlZ2FyZHMsDQpYaW9uZ3dlaQ0KDQo=

