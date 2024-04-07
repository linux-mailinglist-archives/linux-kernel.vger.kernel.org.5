Return-Path: <linux-kernel+bounces-134125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C68CE89ADEC
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 03:48:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52BFE1F2252E
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 01:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C2BA139B;
	Sun,  7 Apr 2024 01:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="NPVVy+PK"
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89FABEA4
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 01:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712454507; cv=fail; b=uc3bTxdGBMFel3t9Bt1kos9RAK8GXAi80wi6uZ42o590tsIyy37Qi8UyXdyAOsCpDTD5r5o0ky6PBZN/+mV0iSCBGwNFt5/f1lEXsBvEMgcrl+hXlBH9DMTYHdJdpeSRFoKtGoChbf95/3wfhSVIIGD6N1Kw+B7/A+vZ9Jrr+tQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712454507; c=relaxed/simple;
	bh=itr3NxbiKB52TDqmy9Z2bEoSQ4i/ZDlOYMR6cINnp3Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=b2fju5AB9RzYcmf9Wijgn3hrCJsgUr+LeNICw48ok8HsAoOj65rPjTR8Dr2S7CQBv4x4aFnxnP6IFkvHf9lUI+fdDtxGM0vVnqyTphfTP2XMVTpQii00p1e53kWiinUWLKQVxBk3CLD+ozm3ZsOBzDOt+4J8Y5XwhO8D7kvOn98=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=NPVVy+PK; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4371HDp4017680;
	Sun, 7 Apr 2024 01:47:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	PPS06212021; bh=itr3NxbiKB52TDqmy9Z2bEoSQ4i/ZDlOYMR6cINnp3Q=; b=
	NPVVy+PKUrzbcKp9JUPUZ4nBL/tKko3qJ04+cIevcu8EGwdEQwtl39ryOsE2o0ka
	Bf/jmelSszzhZ1iMNekRSv4UFMWGnu8hE6Dgk6qQsqUy3rEiH0SBF1EeQx03ewoz
	XRPP54aE9YpKuP2tUvpjELP/e4ke71tLfEqoPD4obIn6EsRio0W5qdXGZgx+28IF
	wQZf7/xhn5lOYDrW4HJheJW0KRDWvIFhwmdcQ6MSsAnsUtoNhx3IjEgRJJ011INa
	CTB024mbhM4hhUyo1XSqkhYmXb3izQMC7ekSzWiL8NElqkrnsMU7DKqr5bjgkbdC
	/j8u/DwVet7i8kRZweC63A==
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3xaukxrp5h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 07 Apr 2024 01:47:43 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VtWclV4IJiv4pVmq66J1b2i4hB4xQ7KVc8q/7L4j43qodTIJ5O8lDOZocJAA0qnWbI9iOKCXtTtN7J7Ul1H0ROUt2mx0pJ+AzSAZDml1AknPK4H5bhVY/if2OyamrkW+LlZecHhs5kC4ZnUteu6dazF9v6sdFmMj3Lh7dZ1Rv9+aHZ7pRvavVNpNbGPKihcb8NDx4QkU/jvdR9gPoiiUH/dx53577dtAvbjzOc8PsDCPWmJKTAcxWAJQWDNc+AwEdkPJGogpczCOnlfnsbBU0fnEe3UHccKy1xyP2p5c+k+YG+lyi7VHlU0bKjC7X/X/LJLaIqcBhmAj/24YLPJ/nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=itr3NxbiKB52TDqmy9Z2bEoSQ4i/ZDlOYMR6cINnp3Q=;
 b=mDYxaYEMFZb9SivDTVNXdmDgfnHhtjjM9SAyiW3DeulUhtxrFotn2IfoFoav7p5i/EzTuzUiyS5LhOUXVAmayFqaYwIuBDNpnpTIKwE/YC0QJciKBN5QaQHKuP2JAvlpzYVdiOk3K0IN14mBnwS07txMvsU1naecZ7JbVfJtzVpFSKLWkXmhe/7UFJ2Vr0k7Qe/mqkSMeelqIlcZnuQTJ3E3rqhUmHKUyt4+CVVM0FAR5dIc3hbImC32diHzNyyLDCiz5gXHNARv5WN7u5obnJdQO3Cmy2sRMk/GnuoY8IjFTHtu6+WBaS/NLefhdnS/TIkYvbCGltBP/3EVlAyrAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from PH0PR11MB5192.namprd11.prod.outlook.com (2603:10b6:510:3b::9)
 by CY5PR11MB6533.namprd11.prod.outlook.com (2603:10b6:930:43::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26; Sun, 7 Apr
 2024 01:47:41 +0000
Received: from PH0PR11MB5192.namprd11.prod.outlook.com
 ([fe80::8cb4:86ac:461a:d683]) by PH0PR11MB5192.namprd11.prod.outlook.com
 ([fe80::8cb4:86ac:461a:d683%4]) with mapi id 15.20.7452.019; Sun, 7 Apr 2024
 01:47:40 +0000
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
Subject: RE: [PATCH v2 3/3] mm/slub: simplify get_partial_node()
Thread-Topic: [PATCH v2 3/3] mm/slub: simplify get_partial_node()
Thread-Index: AQHahlU8oH7TYsyYiUS3sM+9hrLmv7FX18OAgAQ2JlA=
Date: Sun, 7 Apr 2024 01:47:40 +0000
Message-ID: 
 <PH0PR11MB5192E2D674F7191C9571470DEC012@PH0PR11MB5192.namprd11.prod.outlook.com>
References: <20240404055826.1469415-1-xiongwei.song@windriver.com>
 <20240404055826.1469415-4-xiongwei.song@windriver.com>
 <8a2890f0-108f-4fca-98e1-913373aa2cff@suse.cz>
In-Reply-To: <8a2890f0-108f-4fca-98e1-913373aa2cff@suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5192:EE_|CY5PR11MB6533:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 Rh8v7Z0Q2/HjZAKT6y+GV9NtRH30pi6SoawE7nN3pZJmtu+az5tFMOHGGcSTJ14LwT5Rst0NVtnUQKtIs8Q+1lyWo5h6HK1udIsKgf80QzkvM1k46cCz3HJmIknOvryKENZWZiyORpzI9c+u8AJoE0n7zfRGnoFudkqO04uvHJAA8TBzK1IcjxsGrxcJwg5bc+t1qBHdzYOJPsizDaoiA+32ZLnqi96ON9R56PQA4u3QkKxqiwcIyZLvnxwoThwSozawOqm+6Ndnf2r5zOX28O8EA3lky3zRqnd91kwAqMgURXTADhSoS5ovsWGSa+PzX+ao1vBn8aSWloCQUrApMvWSzAEHVfFaGhfJDGnEEhi/TtCSzUZ47EkxGBTsS+u9Taejn2ivYKPfZUstOHW08Yxzp2YJdgyFFKuAjAtyBJBOXXrqMIkZhNR/EMJDzI2Gya46X3bWhaH9WStQN1sdYn99kkofZZI7Rj238ZBt0A7nrqvy8di5w34Z9khohIH+VgHSJrCcGzoGeYETwgk+PZQI1+7sLDPkahaQQtkhFzC7fZV6FGznCTPjpURIMaZM/IU8e/LWbFj7mIGOAdv/4hckiZx1ekfmUOhhB4olqeUIAGU3nrFScIzriEW41+hT0Fh5P8SXUvL/aC1312RieiwynBqgPbj+rtK3Qi8kRV0=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5192.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(366007)(1800799015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?NjlhbS8wblZXVXY0SnpYWnhoeVVXTnlySDNaV2ZoVmp1dVF2UVBZbGM3TlBL?=
 =?utf-8?B?aFdiUno5eWpuZmprcy82SGV6dDZoSjFBNUN0elJqQUZDKzd4dWZ1TnAvcy9y?=
 =?utf-8?B?blRqdDZva1ZaL2tZa3I3QlRIYVpIYzhIVGtZVkJhcTB2U1czRGpOUkpzeTNT?=
 =?utf-8?B?N2I5SkEvM0ZFMDFlZ3poc1JQVm13TDNuYmdpRExzTmF5cHlDREE1OHhqbTVG?=
 =?utf-8?B?VUh1YXVvdFdhVUUzZmZlS1htek1IbFQrV2VaQ0dNM0JlTngvYzBLUmRmTGZk?=
 =?utf-8?B?ODV4YUl5ZUUxWXUwNDB3QUdXanJxaG9YVUtydlhiSmVYYnNlTjVHa2NlcVhs?=
 =?utf-8?B?Rm56aTlWU1hiUlpkcld5NU5HRzY5RXh4QVFZdzkyNHY4d2NTc0o2VXhGbEFD?=
 =?utf-8?B?aWtOeHVldDg0dU52OTFUZUUxNWJOdmVIWGpTM1AxV3dNS2ZyNWVsK0J6S2lq?=
 =?utf-8?B?ZnRtR1kwR3B0Q0hqckhzMjh5ZGhvZFNTK2E3dDBhb0dFcGNzM001RkF1RDA0?=
 =?utf-8?B?ZW5OQXExN0oxbGNaK1p0MUZQd2d6ZHRzUm1wdXcxai9ROWltcklHOVBZMHo5?=
 =?utf-8?B?SzhhdWJKOURBSngrNWxkTkppYUMrWHdueXdHZGp4emFaSUFmSVoxb0JvWXFY?=
 =?utf-8?B?QTdTekNBUUk5dHZ5VDBpYm4ybDljdXQyZU9Rd3MyeHdWTG10U3pWcGJTS0pB?=
 =?utf-8?B?a2RUaXEwb2svVW1iSjR3emIzNE43WjRiNmppTGt4d2xMTlBRaUV0Vkg2R1Vr?=
 =?utf-8?B?NEVkaVpOZ2NkYlZ5QTRwa0xNSzlPSDlLdmVhNmJPSnU4RkRIemZvV1VLaWJX?=
 =?utf-8?B?NlF5WlBWNTRnNWYya3JKc1VSSzdJdjZkR1lDTUdqb0RJOUxiRGtsOXcvTHBO?=
 =?utf-8?B?bDRvMG1na1hyMnR5dWNrT0lmRFFQSGl4aDJiZHBuQ0NGNGZ6allaRHl0UFhy?=
 =?utf-8?B?Q0tGeWlWZW1UK1NSWU94dFgvR3U3VHpqbnhqcHhrZSt6eGk2Tk5DVDlMZWQw?=
 =?utf-8?B?UWNUNlJCOGUwcXRKcytvc3FKaGdTemRrRnJnSTlSYUtEVVZXdCtiNFpiYTVx?=
 =?utf-8?B?L2tOeEVlQUI4blFtRzdqek84a00vVXhwNFVuSW9VWGhtUkplM3h0R09LNGRo?=
 =?utf-8?B?ZnNmT3M0cG83Z3Jsb1lraGVsQWV2eHoyT3A4RTJuRi9IeS9GdlAyZVBIUEMx?=
 =?utf-8?B?cm9xcG9RbDZBV0Jyalh1SG1SZUVTWVM1N1NTU0I0a2FEcURmenlxblh0enJD?=
 =?utf-8?B?M3lrMDhEcmExa1hLLzZsMHZ4OFN5UVE2enozR25Cd3YxUlFyZnlUWi9uTmZt?=
 =?utf-8?B?Z2RSaVV2dis0UHNTU3hpMjNTZngyZWVTc2VVSWgwdmEveG1NRWdlQUdaWnZx?=
 =?utf-8?B?enlZbWQwbDhuNEp5RDdHSkE5TndDellweVFTMGZiWjM0MmttZExqdndDUnBP?=
 =?utf-8?B?MjRMMnRqRUZMeTFYdHRRVTdjM2ppMUEwRGJjbFgzMWVIUzlWUGNMaUxCNUNN?=
 =?utf-8?B?SmVvamZKckxhMzNrQVN5c05VOERwM1k5eUV2SWR3dWMxRkUydmo3M1dBK0dt?=
 =?utf-8?B?cmI2NjJFN29MQktMT3M1WE91bVdqdkxmZStibWdYckhoM1R6c0dJNXBwdzJT?=
 =?utf-8?B?SDRUQ1MycHZRT2dvN3k1dCtYcUhWQ2tibHNOVm80RjBZYW5IRG1CTmJPTnIy?=
 =?utf-8?B?T2kyRjI2VlhvaW0rV3JGdVdnNUVKNEFqYUY3d2tNSjBCcXhuKzFJck9jZW16?=
 =?utf-8?B?blNCNFRWWk9MTDQvU3gvWWNNR1BmWFhkNEZGbDl6WFZPckRHcER2Z3YyTDEw?=
 =?utf-8?B?UjNReHNzakN6Q09xMnExejlKaDJnMmlWSC9rK0NLVVNteFlaeURlUmV3WnJ3?=
 =?utf-8?B?c0dDdVJrVDFLTy9WcDErV3RkZlNpZk9jL3YvWCtpR2l1YUlld2oxbWdIWHE5?=
 =?utf-8?B?cGQ4THZqLy9LeEFqazErSlRhb054SU1oV0pNWHJKVlNFaHcyYTFRa04yME42?=
 =?utf-8?B?UGRDM0dqS1NtT0xzTG9Jc01HZjExRmVXUXJJVjFQS3pRNVlKc2RUenJmNFFw?=
 =?utf-8?B?OHNkN0drcExuaWUxYlNRV25RcmorMmRIeVdhRGp4M0pPNFhMczR2MEhYZHBU?=
 =?utf-8?Q?gVoT2xrBhR4R2inZmbC2uBmuR?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9456b597-7137-4282-d165-08dc56a4b5f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2024 01:47:40.7336
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l+ULTbz3dH0fwV2m0dEZTt1RJjx4/tU0A1+2IqUbHH7FXbeIlXV2oej7FVNDcXZ/yVxByKjHZSC7VLyIhOgFk3GXx6zA4eS2fw5rqXUXNUo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6533
X-Proofpoint-GUID: s8TUVfenke4Tft5NTtPOgQStNI7EkTvF
X-Proofpoint-ORIG-GUID: s8TUVfenke4Tft5NTtPOgQStNI7EkTvF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-06_20,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=999 priorityscore=1501 spamscore=0 clxscore=1015
 suspectscore=0 malwarescore=0 mlxscore=0 phishscore=0 adultscore=0
 bulkscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2404010003 definitions=main-2404070011

IA0KPiBPbiA0LzQvMjQgNzo1OCBBTSwgeGlvbmd3ZWkuc29uZ0B3aW5kcml2ZXIuY29tIHdyb3Rl
Og0KPiA+IEZyb206IFhpb25nd2VpIFNvbmcgPHhpb25nd2VpLnNvbmdAd2luZHJpdmVyLmNvbT4N
Cj4gPg0KPiA+IFRoZSBicmVhayBjb25kaXRpb25zIGZvciBmaWxsaW5nIGNwdSBwYXJ0aWFsIGNh
biBiZSBtb3JlIHJlYWRhYmxlIGFuZA0KPiA+IHNpbXBsZS4NCj4gPg0KPiA+IElmIHNsdWJfZ2V0
X2NwdV9wYXJ0aWFsKCkgcmV0dXJucyAwLCB3ZSBjYW4gY29uZmlybSB0aGF0IHdlIGRvbid0IG5l
ZWQNCj4gPiB0byBmaWxsIGNwdSBwYXJ0aWFsLCB0aGVuIHdlIHNob3VsZCBicmVhayBmcm9tIHRo
ZSBsb29wLiBPbiB0aGUgb3RoZXINCj4gPiBoYW5kLCB3ZSBhbHNvIHNob3VsZCBicmVhayBmcm9t
IHRoZSBsb29wIGlmIHdlIGhhdmUgYWRkZWQgZW5vdWdoIGNwdQ0KPiA+IHBhcnRpYWwgc2xhYnMu
DQo+ID4NCj4gPiBNZWFud2hpbGUsIHRoZSBsb2dpYyBhYm92ZSBnZXRzIHJpZCBvZiB0aGUgI2lm
ZGVmIGFuZCBhbHNvIGZpeGVzIGEgd2VpcmQNCj4gPiBjb3JuZXIgY2FzZSB0aGF0IGlmIHdlIHNl
dCBjcHVfcGFydGlhbF9zbGFicyB0byAwIGZyb20gc3lzZnMsIHdlIHN0aWxsDQo+ID4gYWxsb2Nh
dGUgYXQgbGVhc3Qgb25lIGhlcmUuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBYaW9uZ3dlaSBT
b25nIDx4aW9uZ3dlaS5zb25nQHdpbmRyaXZlci5jb20+DQo+ID4gLS0tDQo+ID4NCj4gPiBUaGUg
bWVhc3VyZW1lbnQgYmVsb3cgaXMgdG8gY29tcGFyZSB0aGUgcGVyZm9ybWFuY2UgZWZmZWN0cyB3
aGVuDQo+IGNoZWNraW5nDQo+ID4gaWYgd2UgbmVlZCB0byBicmVhayBmcm9tIHRoZSBmaWxsaW5n
IGNwdSBwYXJ0aWFsIGxvb3Agd2l0aCB0aGUgZm9sbG93aW5nDQo+ID4gZWl0aGVyLW9yIGNvbmRp
dGlvbjoNCj4gPg0KPiA+IENvbmRpdGlvbiAxOg0KPiA+IFdoZW4gdGhlIGNvdW50IG9mIGFkZGVk
IGNwdSBzbGFicyBpcyBncmVhdGVyIHRoYW4gY3B1X3BhcnRpYWxfc2xhYnMvMjoNCj4gPiAocGFy
dGlhbF9zbGFicyA+IHNsdWJfZ2V0X2NwdV9wYXJ0aWFsKHMpIC8gMikNCj4gPg0KPiA+IENvbmRp
dGlvbiAyOg0KPiA+IFdoZW4gdGhlIGNvdW50IG9mIGFkZGVkIGNwdSBzbGFicyBpcyBncmVhdGVy
IHRoYW4gb3IgZXF1YWwgdG8NCj4gPiBjcHVfcGFydGlhbF9zbGFicy8yOg0KPiA+IChwYXJ0aWFs
X3NsYWJzID49IHNsdWJfZ2V0X2NwdV9wYXJ0aWFsKHMpIC8gMikNCj4gPg0KPiA+IFRoZSBjaGFu
Z2Ugb2YgYnJlYWtpbmcgY29uZGl0aW9uIGNhbiBlZmZlY3QgaG93IG1hbnkgY3B1IHBhcnRpYWwg
c2xhYnMNCj4gPiB3b3VsZCBiZSBwdXQgb24gdGhlIGNwdSBwYXJ0aWFsIGxpc3QuDQo+ID4NCj4g
PiBSdW4gdGhlIHRlc3Qgd2l0aCBhICJJbnRlbChSKSBDb3JlKFRNKSBpNy0xMDcwMCBDUFUgQCAy
LjkwR0h6IiBjcHUgd2l0aA0KPiA+IDE2IGNvcmVzLiBUaGUgT1MgaXMgVWJ1bnR1IDIyLjA0Lg0K
PiA+DQo+ID4gaGFja2JlbmNoLXByb2Nlc3MtcGlwZXMNCj4gPiAgICAgICAgICAgICAgICAgICA2
LjktcmMyKHdpdGggIj4iKSAgICAgIDYuOS4wLXJjMih3aXRoICI+PSIpDQo+ID4gQW1lYW4gICAg
IDEgICAgICAgMC4wMzczICggICAwLjAwJSkgICAgICAwLjAzNTYgKiAgIDQuNjAlKg0KPiA+IEFt
ZWFuICAgICA0ICAgICAgIDAuMDk4NCAoICAgMC4wMCUpICAgICAgMC4xMDE0ICogIC0zLjA1JSoN
Cj4gPiBBbWVhbiAgICAgNyAgICAgICAwLjE4MDMgKCAgIDAuMDAlKSAgICAgIDAuMTg1MSAqICAt
Mi42OSUqDQo+ID4gQW1lYW4gICAgIDEyICAgICAgMC4yOTQ3ICggICAwLjAwJSkgICAgICAwLjMx
NDEgKiAgLTYuNTklKg0KPiA+IEFtZWFuICAgICAyMSAgICAgIDAuNDU3NyAoICAgMC4wMCUpICAg
ICAgMC40OTI3ICogIC03LjY1JSoNCj4gPiBBbWVhbiAgICAgMzAgICAgICAwLjYzMjYgKCAgIDAu
MDAlKSAgICAgIDAuNjY0OSAqICAtNS4xMCUqDQo+ID4gQW1lYW4gICAgIDQ4ICAgICAgMC45Mzk2
ICggICAwLjAwJSkgICAgICAwLjk4ODQgKiAgLTUuMjAlKg0KPiA+IEFtZWFuICAgICA2NCAgICAg
IDEuMjMyMSAoICAgMC4wMCUpICAgICAgMS4zMDA0ICogIC01LjU0JSoNCj4gPg0KPiA+IGhhY2ti
ZW5jaC1wcm9jZXNzLXNvY2tldHMNCj4gPiAgICAgICAgICAgICAgICAgICA2LjktcmMyKHdpdGgg
Ij4iKSAgICAgIDYuOS4wLXJjMih3aXRoICI+PSIpDQo+ID4gQW1lYW4gICAgIDEgICAgICAgMC4w
NjA5ICggICAwLjAwJSkgICAgICAwLjA2MjMgKiAgLTIuMzUlKg0KPiA+IEFtZWFuICAgICA0ICAg
ICAgIDAuMjEwNyAoICAgMC4wMCUpICAgICAgMC4yMTQwICogIC0xLjU2JSoNCj4gPiBBbWVhbiAg
ICAgNyAgICAgICAwLjM3NTQgKCAgIDAuMDAlKSAgICAgIDAuMzk2NiAqICAtNS42MyUqDQo+ID4g
QW1lYW4gICAgIDEyICAgICAgMC42NDU2ICggICAwLjAwJSkgICAgICAwLjY3MzQgKiAgLTQuMzIl
Kg0KPiA+IEFtZWFuICAgICAyMSAgICAgIDEuMTQ0MCAoICAgMC4wMCUpICAgICAgMS4xNzY5ICog
IC0yLjg3JSoNCj4gPiBBbWVhbiAgICAgMzAgICAgICAxLjY2MjkgKCAgIDAuMDAlKSAgICAgIDEu
NzAzMSAqICAtMi40MiUqDQo+ID4gQW1lYW4gICAgIDQ4ICAgICAgMi43MzIxICggICAwLjAwJSkg
ICAgICAyLjc4OTcgKiAgLTIuMTElKg0KPiA+IEFtZWFuICAgICA2NCAgICAgIDMuNzM5NyAoICAg
MC4wMCUpICAgICAgMy43NjQwICogIC0wLjY1JSoNCj4gPg0KPiA+IEl0IHNlZW1zIHRoZXJlIGlz
IGEgYml0IHBlcmZvcm1hbmNlIHBlbmFsdHkgd2hlbiB1c2luZyAiPj0iIHRvIGJyZWFrIHVwDQo+
ID4gdGhlIGxvb3AuIEhlbmNlLCB3ZSBzaG91bGQgc3RpbGwgdXNlICI+IiBoZXJlLg0KPiANCj4g
VGhhbmtzIGZvciBldmFsdWF0aW5nIHRoYXQsIEkgc3VzcGVjdGVkIHRoYXQgd291bGQgYmUgdGhl
IGNhc2Ugc28gd2Ugc2hvdWxkDQo+IG5vdCBjaGFuZ2UgdGhhdCBwZXJmb3JtYW5jZSBhc3BlY3Qg
YXMgcGFydCBvZiBhIGNsZWFudXAuDQo+IA0KPiA+IC0tLQ0KPiA+ICBtbS9zbHViLmMgfCA5ICsr
Ky0tLS0tLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9u
cygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL21tL3NsdWIuYyBiL21tL3NsdWIuYw0KPiA+IGlu
ZGV4IDU5MGNjOTUzODk1ZC4uNmJlZmYzYjFlMjJjIDEwMDY0NA0KPiA+IC0tLSBhL21tL3NsdWIu
Yw0KPiA+ICsrKyBiL21tL3NsdWIuYw0KPiA+IEBAIC0yNjE5LDEzICsyNjE5LDEwIEBAIHN0YXRp
YyBzdHJ1Y3Qgc2xhYiAqZ2V0X3BhcnRpYWxfbm9kZShzdHJ1Y3QNCj4ga21lbV9jYWNoZSAqcywN
Cj4gPiAgICAgICAgICAgICAgICAgICAgICAgc3RhdChzLCBDUFVfUEFSVElBTF9OT0RFKTsNCj4g
PiAgICAgICAgICAgICAgICAgICAgICAgcGFydGlhbF9zbGFicysrOw0KPiA+ICAgICAgICAgICAg
ICAgfQ0KPiA+IC0jaWZkZWYgQ09ORklHX1NMVUJfQ1BVX1BBUlRJQUwNCj4gPiAtICAgICAgICAg
ICAgIGlmIChwYXJ0aWFsX3NsYWJzID4gcy0+Y3B1X3BhcnRpYWxfc2xhYnMgLyAyKQ0KPiA+IC0g
ICAgICAgICAgICAgICAgICAgICBicmVhazsNCj4gPiAtI2Vsc2UNCj4gPiAtICAgICAgICAgICAg
IGJyZWFrOw0KPiA+IC0jZW5kaWYNCj4gPg0KPiA+ICsgICAgICAgICAgICAgaWYgKChzbHViX2dl
dF9jcHVfcGFydGlhbChzKSA9PSAwKSB8fA0KPiA+ICsgICAgICAgICAgICAgICAgIChwYXJ0aWFs
X3NsYWJzID4gc2x1Yl9nZXRfY3B1X3BhcnRpYWwocykgLyAyKSkNCj4gPiArICAgICAgICAgICAg
ICAgICAgICAgYnJlYWs7DQo+ID4gICAgICAgfQ0KPiA+ICAgICAgIHNwaW5fdW5sb2NrX2lycXJl
c3RvcmUoJm4tPmxpc3RfbG9jaywgZmxhZ3MpOw0KPiA+ICAgICAgIHJldHVybiBwYXJ0aWFsOw0K
PiANCj4gQWZ0ZXIgbG9va2luZyBhdCB0aGUgcmVzdWx0IGFuZCB5b3VyIHYxIGFnYWluLCBJIGFy
cml2ZWQgYXQgdGhpcw0KPiBtb2RpZmljYXRpb24gdGhhdCBpbmNvcnBvcmF0ZXMgdGhlIGNvcmUg
djEgaWRlYSB3aXRob3V0IHJlaW50cm9kdWNpbmcNCj4ga21lbV9jYWNoZV9oYXNfY3B1X3BhcnRp
YWwoKS4gVGhlIG1vZGlmaWVkIHBhdGNoIGxvb2tzIGxpa2UgYmVsb3cuIElzIGl0IE9LDQo+IHdp
dGggeW91PyBQdXNoZWQgdGhlIHdob2xlIHNlcmllcyB3aXRoIHRoaXMgbW9kaWZpY2F0aW9uIHRv
IHNsYWIvZm9yLW5leHQNCj4gZm9yIG5vdy4NCg0KU29ycnkgZm9yIHRoZSBsYXRlIHJlc3BvbnNl
LCBJIHdhcyBvbiB2YWNhdGlvbi4NCg0KSSdtIG9rIHdpdGggdGhlIHBhdGNoIGJlbG93Lg0KDQpU
aGFua3MsDQpYaW9uZ3dlaQ0KDQo+IA0KPiAtLS0tODwtLS0tLQ0KPiAtLS0gYS9tbS9zbHViLmMN
Cj4gKysrIGIvbW0vc2x1Yi5jDQo+IEBAIC0yNjE0LDE4ICsyNjE0LDE3IEBAIHN0YXRpYyBzdHJ1
Y3Qgc2xhYiAqZ2V0X3BhcnRpYWxfbm9kZShzdHJ1Y3QNCj4ga21lbV9jYWNoZSAqcywNCj4gICAg
ICAgICAgICAgICAgIGlmICghcGFydGlhbCkgew0KPiAgICAgICAgICAgICAgICAgICAgICAgICBw
YXJ0aWFsID0gc2xhYjsNCj4gICAgICAgICAgICAgICAgICAgICAgICAgc3RhdChzLCBBTExPQ19G
Uk9NX1BBUlRJQUwpOw0KPiArICAgICAgICAgICAgICAgICAgICAgICBpZiAoKHNsdWJfZ2V0X2Nw
dV9wYXJ0aWFsKHMpID09IDApKSB7DQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
YnJlYWs7DQo+ICsgICAgICAgICAgICAgICAgICAgICAgIH0NCj4gICAgICAgICAgICAgICAgIH0g
ZWxzZSB7DQo+ICAgICAgICAgICAgICAgICAgICAgICAgIHB1dF9jcHVfcGFydGlhbChzLCBzbGFi
LCAwKTsNCj4gICAgICAgICAgICAgICAgICAgICAgICAgc3RhdChzLCBDUFVfUEFSVElBTF9OT0RF
KTsNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgcGFydGlhbF9zbGFicysrOw0KPiAtICAgICAg
ICAgICAgICAgfQ0KPiAtI2lmZGVmIENPTkZJR19TTFVCX0NQVV9QQVJUSUFMDQo+IC0gICAgICAg
ICAgICAgICBpZiAocGFydGlhbF9zbGFicyA+IHMtPmNwdV9wYXJ0aWFsX3NsYWJzIC8gMikNCj4g
LSAgICAgICAgICAgICAgICAgICAgICAgYnJlYWs7DQo+IC0jZWxzZQ0KPiAtICAgICAgICAgICAg
ICAgYnJlYWs7DQo+IC0jZW5kaWYNCj4gDQo+ICsgICAgICAgICAgICAgICAgICAgICAgIGlmICgr
K3BhcnRpYWxfc2xhYnMgPiBzbHViX2dldF9jcHVfcGFydGlhbChzKSAvIDIpIHsNCj4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBicmVhazsNCj4gKyAgICAgICAgICAgICAgICAgICAg
ICAgfQ0KPiArICAgICAgICAgICAgICAgfQ0KPiAgICAgICAgIH0NCj4gICAgICAgICBzcGluX3Vu
bG9ja19pcnFyZXN0b3JlKCZuLT5saXN0X2xvY2ssIGZsYWdzKTsNCj4gICAgICAgICByZXR1cm4g
cGFydGlhbDsNCg0K

