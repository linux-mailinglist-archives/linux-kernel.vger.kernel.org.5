Return-Path: <linux-kernel+bounces-150430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EA2308A9F2A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 17:53:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F61FB24F15
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 15:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D72A916F84A;
	Thu, 18 Apr 2024 15:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=motorola.com header.i=@motorola.com header.b="lrrVWQkf"
Received: from mx0b-00823401.pphosted.com (mx0b-00823401.pphosted.com [148.163.152.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49AF4C63A
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 15:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.152.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713455595; cv=fail; b=KalV8JDjSiCkb1sUtSMFoYcLmiCu33RJ/Yv6HBjz9M67jtmIqIPeLmVKlPwMJOR1m9+tEjwD0LaZT/bAGx2ySNRL6DKK6wMjSGCRWgI2YcIX3IGC+WbgrSUcMhNf6ltjYU3toGhLgYfozq3T+OUnaNUuAzqNdC5MRfUcB1+mMxc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713455595; c=relaxed/simple;
	bh=FAGqdSFVF/dFcFb1XSLM8GFLHkftE7WZTRa2nxgVqig=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oCz63di2WBfN2QSyBM78CMOo9wwKpl7ldYOYSHrhDDQjMN9O4FxhcvC991S37qRrrE1IuWnkAef1Xom+NbRox35ioqv6anm6xQddkyLviAbByygmOIQIs2DLld7h7ZTHZxtiBsFzfrwBfP/HDNgS/h1PfkjErO0295gOL8dYLCc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motorola.com; spf=pass smtp.mailfrom=motorola.com; dkim=pass (2048-bit key) header.d=motorola.com header.i=@motorola.com header.b=lrrVWQkf; arc=fail smtp.client-ip=148.163.152.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motorola.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motorola.com
Received: from pps.filterd (m0355089.ppops.net [127.0.0.1])
	by mx0b-00823401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43ICnRVU023242;
	Thu, 18 Apr 2024 15:52:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=motorola.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	DKIM202306; bh=FAGqdSFVF/dFcFb1XSLM8GFLHkftE7WZTRa2nxgVqig=; b=l
	rrVWQkfxDiM9xq9UkP3odcDAaEx4B5IRl0k09S5d3lfksUSMWHlEbzvVZlYGvX2w
	bjBwQtmr3lw3F+OzIwFRMGKV9+oSIeLec3b4mmeYrzTIix1bhYsaZkREgBG2LyCw
	DIbHx/rDYp1ZkJo5SJuDq/t/f/Y35L2HiWRDXulI6F9GHk9hv2I8sPpzslLpS6uX
	D4U6RnKGpWtDC4QpzHQa68ylQ/OIQUHeaRwbce3F0O05lhq5MJeiuP0pMThs8oGv
	WqNGJWnGmlu0dMwivjNGp5PDEK9378r5bmpYxiq6DHY/FtuzOkUoieVq43KWpiZh
	l4eEheQvP006K3NTQzMtQ==
Received: from apc01-sg2-obe.outbound.protection.outlook.com (mail-sgaapc01lp2112.outbound.protection.outlook.com [104.47.26.112])
	by mx0b-00823401.pphosted.com (PPS) with ESMTPS id 3xjq0p2012-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Apr 2024 15:52:52 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dZ1jciRTYR3HgA08XWTrC4aUgRaM421lnpDxADhkHlV5LN4vYzF6gtSpdNrM84fAczVZ0gHFGHfcXIh1AXAfSL7miNyG9IUhQfIeG1HIER0HIFZXnsEvfwxbLJpfdaAQaVCAWLwyTEUx5PXIKAQNUEI8lkJ6nStnQJF9BBs7YyVpbwdwHOHYqFLwBnJm6/99ZCYAduSbpuZaKgUIJOK9ypimCoCROtam+EMXc4C+bXPj/YIiQM8C9LoM6lJR/vWTDVH2Okc1sea8mTVClx0bqvAnk7vf3innvEUxdCHiwyJ1EgC13EYbAZ8i97NGRg0CLUuZrLWeBlBB8zQAcVfW1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FAGqdSFVF/dFcFb1XSLM8GFLHkftE7WZTRa2nxgVqig=;
 b=YDVifDXpukioRXXLP9ssqsbOcaiR22FXSOnJ4Pxb7iiTFAAqvMk/lJOhsq5bJx+KNYXv3AARgAYaQP8deiY4ZHyi9ixMhIi3o3NNxFAyLP+z6XIayrnezz1vv0HWAcmPdvQS5haJjvDVcVwywtI2RiiLghlOVqUjJyixSW9OsdU/ZBSy7mb+FoIWMwBmFfls6AMaTo+KlpR4+IHm9GFYvCkmiuUc4chMwjkxOelxL2lxFbBwJ1fxoElx/OkLKjZNylbSqw4WRJhXjsV3pacXmu8+f8TPPriE4G5a/yJhjQimGumq8euybayomsaGir6fPjUoL1/s4ee+k8N8twOq7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=motorola.com; dmarc=pass action=none header.from=motorola.com;
 dkim=pass header.d=motorola.com; arc=none
Received: from SEZPR03MB6786.apcprd03.prod.outlook.com (2603:1096:101:66::5)
 by SG2PR03MB6706.apcprd03.prod.outlook.com (2603:1096:4:1d5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.42; Thu, 18 Apr
 2024 15:52:49 +0000
Received: from SEZPR03MB6786.apcprd03.prod.outlook.com
 ([fe80::2071:df9c:5f50:a9a6]) by SEZPR03MB6786.apcprd03.prod.outlook.com
 ([fe80::2071:df9c:5f50:a9a6%4]) with mapi id 15.20.7472.037; Thu, 18 Apr 2024
 15:52:48 +0000
From: Maxwell Bland <mbland@motorola.com>
To: Uladzislau Rezki <urezki@gmail.com>
CC: "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>
Subject: Re: [PATCH 1/5] mm: allow arch refinement/skip for vmap alloc
Thread-Topic: [PATCH 1/5] mm: allow arch refinement/skip for vmap alloc
Thread-Index: AQHakah2SZhA7ojMHk6Wd5DQaw0h+g==
Date: Thu, 18 Apr 2024 15:52:48 +0000
Message-ID: 
 <SEZPR03MB6786A4990ADA94C29CE2D77BB40E2@SEZPR03MB6786.apcprd03.prod.outlook.com>
References: <20240416122254.868007168-1-mbland@motorola.com>
 <20240416122254.868007168-2-mbland@motorola.com> <ZiDf9AeFUG22CEU5@pc636>
In-Reply-To: <ZiDf9AeFUG22CEU5@pc636>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB6786:EE_|SG2PR03MB6706:EE_
x-ms-office365-filtering-correlation-id: 4e342eca-5b3e-4d1f-f305-08dc5fbf98d7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 =?utf-8?B?dkxKbmY0V1UvVnFVa1h2MHZQNGh5UFpQQnFYWkpLcU42UHpDajI3VkN5Z28x?=
 =?utf-8?B?cm5kdjFwRnI5enVqU1pXeTBFZnhydlROWWtqa0ZRd2hkenF2WVl6UUs4ZXBr?=
 =?utf-8?B?ZUtRQm81ZC9SaXJucGFDZlBYZGxqb2pRcGdkSmttb2ppSndPVTlKeEg2Q2gw?=
 =?utf-8?B?SjltRG9BQXY3ckttY1QvVUdjM25PSFYxZ3JTejBhT2QvVWk0REYvVit0aE9V?=
 =?utf-8?B?cFhjUWoxV09qallHbWFWc1dGcnp4S3NpWFFOdk4zeUZKTHU2SjdUWmF3blVZ?=
 =?utf-8?B?eXNSK3NGWTlhYXZGUmFoUHEyU25sWDd1aVVMMHVDWmg2WE9wc0FDb1NrUUVP?=
 =?utf-8?B?a2J1NXNrNi8wekhISVI3OHJ2b01HZXpaU3BkVVpjNnFrMEwzeW9ZNjR5Z0Ry?=
 =?utf-8?B?STFpSnNMbDFyVkZOTys5dkFIK2JuWTRpUjhXaWluNC9TanVua21HbC9pUXpw?=
 =?utf-8?B?NlorRHFCcTRETFF1UHhhQ0ZRSzAzYnNyNjZzTTF3bWl5SWZLcHpDRlNYNmVY?=
 =?utf-8?B?MFgxcFNXdk5pYzIyZE1vYklncENQM3Vnc1BKUWFOMjFJaEZYQU42QUhWSHFz?=
 =?utf-8?B?R2h1emk1TkRnQ0NMQjU3ajNkSFl6aURIV0RTRTZOQzZOYTJMcDFISFVvemhl?=
 =?utf-8?B?d1pJdG5zTmo3VVRuZGJVREovVTY3YTFQQ1hESGRXdDNkbmV0WGdLeDg4WVRR?=
 =?utf-8?B?UzRSZ2JUVE8rRW96TVJ1TnhuZ2QzNDVKNU9iaU55dGFHM2xodmlOa0pldEVn?=
 =?utf-8?B?ZWtNZzlNV3Z4akUwVG0vOVZYb2ZvZ1hSa2VPZjlKSGtLTXR1NzIzMGR5eXNT?=
 =?utf-8?B?UXpmQ3h4SFdMa0VJZ044SWFJei9HcmF5a3BLUFptSytvY092eXhHU2pERkJR?=
 =?utf-8?B?ZGlFdUozbEVZV09wRmZJdEtTamR4OFR3Z3VDUUx5Ym1ZUDF0aTVGT3EyNjhW?=
 =?utf-8?B?b21WVEhvUU1sOXJrVnVwcVZITVFuaW9jMjA1bFlaODBHZU5vTjhnaFhFQjQv?=
 =?utf-8?B?SGhIQkVXaXdsTkpTYmxnbk4zSjdVS3FUMWNLMGxUTTFOam43WVREemZWZnJM?=
 =?utf-8?B?MXVoeDVPNFlyeDR4MmhUQWhIbjkzcHlYdTMwWmdDRG5BU1VyZThwT1JEbzZ2?=
 =?utf-8?B?WEQzNmdTSkptWjBXRUs0TEpSSXYrMHo5RVV1V29OdkpqUm9iSmFBNER3RWpG?=
 =?utf-8?B?bElVKzByaDBraWFWWkZSeVNBbjhaVGJ3RytuR1lxVFB3U25RKzZrUkdTeHkx?=
 =?utf-8?B?aGcyZlVGaUV2SitzdjAyODc4NVBBQ1lqYW5QSUtEdHFRTHBsdmtwN0JBZ3ZX?=
 =?utf-8?B?bjVjbG9QUitISFN0RG93NEx6QjFvcFdkdktMRFQyMG4vT2ZTZVBPL2VOVnVp?=
 =?utf-8?B?OENvWUM0OEZzSnBwbldnaWJQdTlLVmhRZk50VmlBTFRud2NJbkJ6ZmpGcjVS?=
 =?utf-8?B?d3NwbTFrempOd0tNKzJwMlNCM3JuZEMwdEdIMTVWM1VsZi9SMDlwT2FUek1F?=
 =?utf-8?B?OHBoRFk2ci9nLzNUejYvczNtUmpKWkcvaDlOTUZqQTZlSi9tNktyUURUTVRz?=
 =?utf-8?B?SjlBMURTRFMveWZZdWcvbXo1Y0Q5K0JyS21WaW9iN0F2SkU3R2FTRkJYOFRV?=
 =?utf-8?B?Rm9BTlpKUGtVZjYvVXpVTHRMWGsyQjBSTVhCTGx6MDJhU1BQM2NYc2U3alRu?=
 =?utf-8?B?QmJlT211aXRPb2hxNVhwaTltZCtyTnNiMEYySjdsanB3RWcxVFkvNFc4Q3o4?=
 =?utf-8?B?bVplYzE0N2tPRWdWemlqZ2xKR1dHS0NQVkgvaU9CS0hRVzRUVGdJdi83QUNF?=
 =?utf-8?B?eVczRlRIeStoSzNTSkJUdz09?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR03MB6786.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?ZVYvV2tVMmIwemRPZGtXZWhNa1VoQUR4V043bHhSclBFMzZRcWRZTUJWanUx?=
 =?utf-8?B?SzM4cHVYRjZZSXlRdHlWdGpNblRTQ0JualdzOXpSWWxxTkkvaWcxUWk5VDVo?=
 =?utf-8?B?R3dxai81Wk9wMDJlcDVFOUpWdC9KU3VrVS9VNFQwUysxbm9tS251Z2dpM1Vw?=
 =?utf-8?B?b1ZmQWFuSnlSWHBpWFRod0RTRnBQMGkrS3hjTFo5bFFBVHk1NUxyVVBKV1N2?=
 =?utf-8?B?QWhrVUJKZDBmdnhpQ3NZbFN1WnprNWxXMzQ0UWJ5bGRZdDZYcnRtcmxMRURJ?=
 =?utf-8?B?NUo0a1I2K1ZkZEpPTjFjaUZsREFNMjEwQm5HSU5JaHJtNXRRdlNjZGJKL05C?=
 =?utf-8?B?YXRFdHpZQXVIMWpPVFVPN0ZsbHpSdjl1WFhVUXIzaCtZeTlkUHhFajV3TFR1?=
 =?utf-8?B?ekl5dnYvYjNZZFpNdzVTa3JYRjRyeG5jY3JOZzRuT3dEaXBDbDJ1eCtTM2Ja?=
 =?utf-8?B?MU9qakhWK1M1QXBmSkZlclIxY2dxWXNoUC9obll0MnBMTDIwZUlIUitkZWI0?=
 =?utf-8?B?UlJwRkdIOVcrdzVsTnhFZVZsUzVtU3ZxNGtkOXc0SXJPUUw1bnZCbTRMWnZ0?=
 =?utf-8?B?aG4xM2E3elZkUi9qNW01dlcySkZiQndZK1RjWm44TVVrR2hHbGhKRjBwNnRF?=
 =?utf-8?B?UGxCQjcySW9FYlR4V3h1ZFUzTXExN2dvWFhITXJhM1BoMTE1aWNxcmxiTnVj?=
 =?utf-8?B?all3b2lqUmFQNWVPdUl4b3ViZE1oOTNzNFIyYmE4d05ySEw2ZkpJd21OTWdi?=
 =?utf-8?B?RFROZ2ZYTExjbHVqZGxHaUxSbU11bUM5YUliTnppd0hxTStuQ09jbnpmbzZP?=
 =?utf-8?B?TERORncwUUt1STZiSHlUL2ZlREc2VGdOQ0NHRm4rako4c2FLWWZoRDN0UEZR?=
 =?utf-8?B?RlkyQTR3WWt1ZjVINi81ajdIUGljRC9kcXB4Zjc2d3hCNzNWVUVNNkc1WHJ3?=
 =?utf-8?B?TmpTMFB0Z1FDQmFHRTNCMTRaaE9DZEpWZjJNdUxVY3d4dDZWVWlOTC8raUVJ?=
 =?utf-8?B?Z1kwUEt4a292VzR3VEx6RUlPQkEzYUJ1Q0I4QmV4NUxsWG1rM3lMOE1aZ1hC?=
 =?utf-8?B?WGVSbVNpTFlBcHltWlR6ZkIyVndUcTVJY0h0VjNvL3ovU0pNdG1TdUJEZ2hB?=
 =?utf-8?B?ZW9YZis4blpxeEJyTFdUVGoyNVJBNzY3d1hGNElBODRHQUJiZDExWThlN0pj?=
 =?utf-8?B?alluTzlVVnNiaEQ5VUhLT213dWswOW5sOWUxc0VYQlFGSE1FTzRyZ00wdWtU?=
 =?utf-8?B?VHlDaWQ4L20rbUJLdnhEQWpyOElDZlNZeVBxK0VRMElUQ2d4cmV6TU05bFBt?=
 =?utf-8?B?L2pBMWplOHdGejVCYjc4Y0QyMDJ6dElwSUJUaU5ua0lxOTNubTBxSTh4U0d2?=
 =?utf-8?B?eG1JeDVXSUQ3ZXF1Q2pKaVliK1d1MUY0bUNNZlVvZDlYMVJnSHIzMFNNZ1Fj?=
 =?utf-8?B?UHFIbkxtSE5FRkRLL1l4aUNYSWhzRlRhWFVYaU1hMVZJVExGWTV3aTkyTktr?=
 =?utf-8?B?cC9KL3JCY3BjMGFxVzMxTkNsdk94Y2IyYkJwbUZCeHBJL3pYWDRSNTFjZC9i?=
 =?utf-8?B?S1NBUW5CLzg0azVibHkxaTVrVlVYRWMxRDAwbkNoOWRNTHFYM2VLdFV2cktV?=
 =?utf-8?B?cnRZL1JNTngydlEwNjVYTHlWdjIydEk4U0ZQQmw1cEFIaTRGL3FSS2xjakdV?=
 =?utf-8?B?WEtYYWEvRWVQMW5lL29CeTN6UlFHd29pSHBINk5WYUFIZkdYOTlYTUt2Yzlx?=
 =?utf-8?B?VUgvelYwVU12M2Z5dXp3OVlZL3VXNnFWb3RBZU04eWt3YTN1bTZYaGo2dGdS?=
 =?utf-8?B?Slg3dHJxVVJCVi9vYzZCWVpaK0VMVnBwTGhEMTJZRG5ORmRQZmcxaVJCczhU?=
 =?utf-8?B?T08ycTZYMmhDUC8rYWw1elRVdTZ5cUh5QzhUcGhXQ3IzdVN1dGtpdVJFOW4r?=
 =?utf-8?B?bjl0YWlObWdZV3laVmFwakhkUGRvN0NSdzRwRXF6RVg1cDBiTS9FdEZMR3E2?=
 =?utf-8?B?Vm5oUEg0RHRPOGxHU3pvU20zTXBRU2ZIR2VleWl0L2F4V3AyN2xZQW5raUVI?=
 =?utf-8?B?U2J1YlgyVzNQRUpkTStRd2dGR1prZjhxb2E0cEJBTHk2UEtMMWdyVm9DZHdX?=
 =?utf-8?Q?AGsx0Pw+aQWhbYvdlTC29NkFE?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: motorola.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB6786.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e342eca-5b3e-4d1f-f305-08dc5fbf98d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2024 15:52:48.7385
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3DHsoWSdbX6IrBN5YzJuIeuQ1KxaVypf0kzzRNyX0/US7rwKdnGiILeuOxB1JQ2T4lg85BBXPjdUHZJ8MsFc+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR03MB6706
X-Proofpoint-GUID: YGylWMxoxDuI2NmrODd0YBZgZjAWvJkP
X-Proofpoint-ORIG-GUID: YGylWMxoxDuI2NmrODd0YBZgZjAWvJkP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-18_13,2024-04-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 priorityscore=1501 mlxscore=0 bulkscore=0 lowpriorityscore=0
 suspectscore=0 adultscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404180112

T24gVGh1LCBBcHJpbCAxOCwgMjAyNCBhdCAzOjU1IEFNLCBVbGFkemlzbGF1IFJlemtpIHdyb3Rl
Og0KPiBPbiBUdWUsIEFwciAwMiwgMjAyNCBhdCAwMzoxNTowMVBNIC0wNTAwLCBNYXh3ZWxsIEJs
YW5kIHdyb3RlOg0KPiA+ICtleHRlcm4gdm9pZCBpbnNlcnRfdm1hcF9hcmVhX2F1Z21lbnQoc3Ry
dWN0IHZtYXBfYXJlYSAqdmEsIHN0cnVjdCByYl9ub2RlDQo+ID4gK2V4dGVybiBpbnQgdmFfY2xp
cChzdHJ1Y3QgcmJfcm9vdCAqcm9vdCwgc3RydWN0IGxpc3RfaGVhZCAqaGVhZCwgK2V4dGVybg0K
PiA+IHN0cnVjdCB2bWFwX2FyZWEgKl9fZmluZF92bWFwX2FyZWEodW5zaWduZWQgbG9uZyBhZGRy
LA0KPiBUbyBtZSBpdCBsb29rcyBsaWtlIHlvdSB3YW50IHRvIG1ha2UgaW50ZXJuYWwgZnVuY3Rp
b25zIGFzIHB1YmxpYyBmb3INCj4gZXZlcnlvbmUgd2hpY2ggaXMgbm90IGdvb2QsIGltaG8uDQoN
CkZpcnN0LCB0aGFuayB5b3UgZm9yIHRoZSBmZWVkYmFjay4gSSB0dXNzbGVkIHdpdGggc29tZSBv
ZiB0aGVzZSBpZGVhcyB0b28gd2hpbGUNCndyaXRpbmcuIEkgd2lsbCBjbGFyaWZ5IHNvbWUgbW90
aXZhdGlvbnMgYmVsb3cgYW5kIHRoZW4gcHJvcG9zZSBzb21lDQphbHRlcm5hdGl2ZXMgYmFzZWQg
dXBvbiB5b3VyIHJldmlldy4NCg0KPiBhcmNoX3NraXBfdmEoKSBpbmplY3Rpb25zIGludG8gdGhl
IHNlYXJjaCBhbGdvcml0aG0gc291bmRzIGxpa2UgYSBoYWNrIGFuZA0KPiBtaWdodCBsZWFkKGlm
IGkgZG8gbm90IG1pc3Mgc29tZXRoaW5nLCBuZWVkIHRvIGNoZWNrIGNsb3NlcikgdG8gYWxsb2MN
Cj4gZmFpbHVyZXMgd2hlbiB3ZSBnbyB0b3dhcmQgYSByZXNlcnZlZCBWQSBidXQgd2UgYXJlIG5v
dCBhbGxvd2VkIHRvIGFsbG9jYXRlDQo+IGZyb20uDQoNClRoaXMgaXMgYSBnb29kIGluc2lnaHQg
aW50byB0aGUgYXJjaGl0ZWN0dXJhbCBpbnRlbnRpb24gaGVyZS4gQXMgaXMgY2xlYXIsIHRoZQ0K
dW5kZXJseWluZyBnb2FsIG9mIHRoaXMgcGF0Y2ggaXMgdG8gcHJvdmlkZSBhIG1ldGhvZCBmb3Ig
YXJjaGl0ZWN0dXJlcyB0bw0KZW5mb3JjZSB0aGVpciBvd24gcHNldWRvLXJlc2VydmVkIHZtYWxs
b2MgcmVnaW9ucyBkeW5hbWljYWxseS4NCg0KVGhpcyBjb25zaWRlcmVkLCB0aGUgaGlnaGxpZ2h0
ZWQgcG90ZW50aWFsIGZhaWx1cmVzIHdvdWxkIHRlY2huaWNhbGx5IGJlDQpsZWdpdGltYXRlIHdp
dGggdGhlIGNhdmVhdCBvZiBtYWtpbmcgYXJjaGl0ZWN0dXJlcyB3aG8gaW1wbGVtZW50IHRoZSBp
bnRlcmZhY2UNCnJlc3BvbnNpYmxlIGZvciBtYWludGFpbmluZyBvbmx5IGNvcnJlY3QgYW5kIGFw
cHJvcHJpYXRlIHJlc2VydmF0aW9ucz8NCg0KSWYgc28sIHRoZW4gdGhlIHBhdGggZGl2ZXJnZXMg
Y29uZGl0aW9uZWQgb24gd2hldGhlciB3ZSBiZWxpZXZlIHRoYXQgY2F2ZWF0IGlzDQpyZWFzb25h
YmxlLiBJIGFtIG9uIHRoZSBmZW5jZSBhYm91dCB3aGV0aGVyIGZyZWVkb20gaXMgZ29vZCBoZXJl
LCBzbyBJIHRoaW5rIGl0DQppcyByZWFzb25hYmxlIHRvIGRpc2FsbG93IHRoaXMgZnJlZWRvbSwg
c2VlIGJlbG93Lg0KDQo+IFdoeSBkbyBub3QgeW91IGFsbG9jYXRlIGp1c3QgdXNpbmcgYSBzcGVj
aWZpYyByYW5nZSBmcm9tIE1PRFVMRVNfQVNMUl9TVEFSVA0KPiB0aWxsIFZNQUxMT0NfRU5EPw0K
DQpNYXJrIFJ1dGxhbmQgaGFzIGluZGljYXRlZCB0aGF0IGhlIGRvZXMgbm90IHN1cHBvcnQgYSBs
YXJnZSBmcmVlIHJlZ2lvbiBzaXplDQpyZWR1Y3Rpb24gaW4gZmF2b3Igb2YgZW5zdXJpbmcgcGFn
ZXMgYXJlIG5vdCBpbnRlcmxlYXZlZC4gVGhhdCBpcywgdGhpcyB3YXMgbXkNCmluaXRpYWwgYXBw
cm9hY2gsIGJ1dCBpdCB3YXMgZGVlbWVkIHVuZml0LiBTdHJpY3QgcGFydGl0aW9uaW5nIGNyZWF0
ZXMgYQ0KdHJhZGUtb2ZmIGJldHdlZW4gcmVnaW9uIHNpemUgYW5kIEFTTFIgcmFuZG9taXphdGlv
bi4NCg0KVG8gY2xhcmlmeSBhIHNlY29uZGFyeSBwb2ludCwgaW4gY2FzZSB0aGlzIHF1ZXN0aW9u
IHdhcyBtb3JlIGdlbmVyYWw6IGFsbG93aW5nDQppbnRlcmxlYXZpbmcgYmV0d2VlbiBWTUFMTE9D
X1NUQVJUIHRvIFZNQUxMT0NfRU5EIGFuZCBNT0RVTEVTX0FTTFJfU1RBUlQgdG8NCk1PRFVMRVNf
QVNMUl9FTkQgcmVnaW9ucyBicmVha3MgYSBrZXkgdXNlY2FzZSBvZiBiZWluZyBhYmxlIHRvIGVu
Zm9yY2UgbmV3DQpQTUQtbGV2ZWwgYW5kIGNvYXJzZS1ncmFpbmVkIHByb3RlY3Rpb25zIChlLmcu
IFBYTlRhYmxlKSBkeW5hbWljYWxseS4NCg0KSW4gY2FzZSB0aGUgcXVlc3Rpb24gaXMgbW9yZSBv
ZiBhICJ3aHkgYXJlIHlvdSBzdWJtaXR0aW5nIHRoaXMgaW4gdGhlIGZpcnN0DQpwbGFjZSI6IG5v
bi1pbnRlcmxlYXZpbmcgc2ltcGxpZmllcyBjb2RlIGZvY3VzZWQgb24gcHJldmVudGluZyBtYWxp
Y2lvdXMgcGFnZQ0KdGFibGUgdXBkYXRlcyBzaW5jZSB3ZSBkbyBub3QgbmVlZCB0byB0cmFjayBh
bGwgdXBkYXRlcyBvZiBQVEUgbGV2ZWwNCmRlc2NyaXB0b3JzLiBWZXJpZnlpbmcgaW5kaXZpZHVh
bCBQVEUgdXBkYXRlcyBjb21lcyBhdCBhIGhpZ2ggKHBlcmZvcm1hbmNlLA0KY29tcGxleGl0eSkg
Y29zdCBhbmQgaGFwcGVucyB0byBsZWFkIHRvIGhhcmR3YXJlLWxldmVsIHByaXZpbGVnZS1jaGVj
a2luZyByYWNlDQpjb25kaXRpb25zIG9uIGNlcnRhaW4gdmVyeSBwb3B1bGFyIGFybTY0IGNoaXBz
ZXRzLg0KDQpPSywgcHJlYW1ibGUgb3V0IG9mIHRoZSB3YXk6DQoNCigxKSBXb3VsZCBpdCBiZSBP
SyB0byBwb3RlbnRpYWxseSBleHBvcnQgYSBtb3JlIGdlbmVyaWMgdmVyc2lvbiBvZiB0aGUNCmZ1
bmN0aW9ucyB3cml0dGVuIGluIGFyY2gvYXJtNjQva2VybmVsL3ZtYWxsb2MuYyBmb3INCg0KaHR0
cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjQwNDE2MTIyMjU0Ljg2ODAwNzE2OC0zLW1ibGFu
ZEBtb3Rvcm9sYS5jb20vDQoNClRoYXQgaXMsIG1vdmUgYSB2ZXJzaW9uIG9mIHRoZXNlIGZ1bmN0
aW9ucyB0byB0aGUgbWFpbiB2bWFsbG9jLmM/IFRoaXMgd2F5DQp0aGVzZSBmdW5jdGlvbnMgYXJl
IHN0aWxsIG93bmVkIGJ5IHRoZSByaWdodCBwYXJ0IG9mIHRoZSBrZXJuZWwuDQoNCk9yICgyKSB0
aGUgZXhwb3J0ZWQgZnVuY3Rpb25zIGNvdWxkIGJlIGR1cGxpY2F0ZWQsIGVmZmVjdGl2ZWx5LCBp
bnRvDQphcmNoaXRlY3R1cmUtc3BlY2lmaWMgY29kZSwgYSBzb3J0IG9mICJhbGwgaW4iIHRvIHRo
ZSBjYXZlYXQgbWVudGlvbmVkIGFib3ZlIG9mDQptYWtpbmcgdGhlIGFyY2hpdGVjdHVyZXMgcmVz
cG9uc2libGUgZm9yIG1haW50YWluaW5nIGEgcmVzZXJ2ZWQgY29kZSByZWdpb24gaWYNCnRoZXkg
Y2hvb3NlIHRvIGltcGxlbWVudCB0aGUgaW50ZXJmYWNlLg0KDQooMykgUG90ZW50aWFsbHkgYSBk
aWZmZXJlbnQgYXBwcm9hY2ggdGhhdCBkb2VzIG5vdCBpbnZvbHZlIHNraXBwaW5nIHRoZQ0KYWxs
b2NhdGlvbiBvZiAiYmFkIiBWQSdzIGJ1dCBpbnN0ZWFkIGR5bmFtaWNhbGx5IHJlc3RydWN0dXJl
cyB0aGUgdHJlZSwNCnBvdGVudGlhbGx5IGp1c3QgY3JlYXRpbmcgdHdvIHRyZWVzLCBvbmUgZm9y
IGRhdGEgYW5kIG9uZSBmb3IgY29kZSwgaXMgaW4gbWluZC4NCg0KVGhhbmtzIGFuZCBSZWdhcmRz
LA0KTWF4d2VsbCBCbGFuZA0K

