Return-Path: <linux-kernel+bounces-73951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9992285CDF9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 03:26:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C95102858D9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 02:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C7DFBF4;
	Wed, 21 Feb 2024 02:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="IZKtgutL"
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96CE046A4
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 02:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708482401; cv=fail; b=Gc7ztc2xnmatr5nmJk/1yxI3U9uB9/FgSDDjUxDZdwKFCx8djps8Athb10HVg2xs2D/QGMkzcyPS0ApJmgjvYVZPJh4HFt1v4bpRu0yDqHfsRYqQuTWHfEejAlm3viUYEcop7bdEYyriSE9dVn1/7hh6XK0WTJDMeBUpPV3z2jw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708482401; c=relaxed/simple;
	bh=4fU47u97qBavmDdSa8bhVb0l0GHt9YAkuld4S8s+2TI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=u43D0Sst3nhdyvOPQu1hXy2T2d95+DUTp4gE2APUPTp5U1tAInMGrWDloQVHSYbMFpRDgCWiarEJgVo1B01gdx5tQZbSxKfCYOm0oDVvg3QcaruLJwqQxVIYHybh0/+fDTTN2H/kmHoaCCwJjvbUUOmNzEluFL37uA2tcLkI2/E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=IZKtgutL; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41L0alrR022271;
	Wed, 21 Feb 2024 02:26:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	PPS06212021; bh=4fU47u97qBavmDdSa8bhVb0l0GHt9YAkuld4S8s+2TI=; b=
	IZKtgutLtQtPoCfof+4FrVSdorpJ6aSpplBMIX+YMBTm5zW9K8aLPrF9KIRgPo9V
	ryNH8WT2gMgAL6rIuFeuBPsII5wrlNhuf8+KxGH7Pm9rFXV3+vZMHGqSOpAVLpqk
	M6ZM9V5YWXErdthqWxp0CWpnhadOh7CMNmqmYsjuwt8jcOkrXFROUU810MfgLJql
	3V+ey4Leihoj50eDTxEf5+HnbEkTrw1GdygcVtb9UaWeeVX82iwaQ5IZXHK+q3Fs
	g7r05CSBBShphMr+J3cVasnTe4BQe6UmwATGU4W016ryS5Fx7tKZFOE/cAhnuF/I
	p7FzCP2FwqSnpq0HSNfhEA==
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3wd218gagd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Feb 2024 02:26:00 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LR9T4aCxJoPe79K5X8cOb9vI5uK3FDpb6fZcXZr62PnrfIQmR6IzNp1PPb9wVGWoxNG8JSjp+MGaXECMlpAaFQU0a263t2WqWjTmZHqP+S9QnyWdaHInBGDlbmapx6VncVMZy2hGwRq2y9q6NcfECioccV25r8tyNuA4OEHKkLc/bMyhB2MWa6nec0U4QYJSArmUNrCQXBJO/Ma/o9X66jbRTnBBBUjb1bA1q9W1CZQHSHUT6TH52WlBdLabcG4zyPaCKXUTkYjh3VSqscYCA9ZCdVH24IXUpoZx+TXnZbUTZtZv7p8ADHJgOGbs0SQaOkEGvWVyojoKfTFFIif8kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4fU47u97qBavmDdSa8bhVb0l0GHt9YAkuld4S8s+2TI=;
 b=JAdL1ypUBbsmoKAjujIpUXidjXAngSSK9fSiGBvRjAxcxPMY+zAEsSgbszoqD9TJiJ5FIJ+CAUPWYJu56SRjoyMveldqbBVbev3/AaH82t0UOp1Jw47sSZDIuBFo1yqP3wEJ5qrWugy1F67SPHbx3/OAQSiWNroJegr3bxSTdWaURWNec4B8airKsbG0EXzR+6Me7KAL1WagJmQqfw3hH9WWnwVJspevsicGJYidZDhJc2j9HywAROvWkLlC2xNb3vmDoKLChvGGmoezVigQzDwXE3OXeKIRT3kVCCaC/9DnW+ocL1tiFg7xjz6mDPpVkgIgqLVuz827eXOYaGjOIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from PH0PR11MB5192.namprd11.prod.outlook.com (2603:10b6:510:3b::9)
 by SJ2PR11MB8538.namprd11.prod.outlook.com (2603:10b6:a03:578::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Wed, 21 Feb
 2024 02:25:58 +0000
Received: from PH0PR11MB5192.namprd11.prod.outlook.com
 ([fe80::230c:58c0:c3f9:b5f3]) by PH0PR11MB5192.namprd11.prod.outlook.com
 ([fe80::230c:58c0:c3f9:b5f3%3]) with mapi id 15.20.7292.036; Wed, 21 Feb 2024
 02:25:58 +0000
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
Subject: RE: [PATCH 3/3] mm, slab, kasan: replace kasan_never_merge() with
 SLAB_NO_MERGE
Thread-Topic: [PATCH 3/3] mm, slab, kasan: replace kasan_never_merge() with
 SLAB_NO_MERGE
Thread-Index: AQHaZB4W8cdfqy83J0yGhys5aQz/a7EUEbtQ
Date: Wed, 21 Feb 2024 02:25:58 +0000
Message-ID: 
 <PH0PR11MB51929A162277950399731E35EC572@PH0PR11MB5192.namprd11.prod.outlook.com>
References: <20240220-slab-cleanup-flags-v1-0-e657e373944a@suse.cz>
 <20240220-slab-cleanup-flags-v1-3-e657e373944a@suse.cz>
In-Reply-To: <20240220-slab-cleanup-flags-v1-3-e657e373944a@suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5192:EE_|SJ2PR11MB8538:EE_
x-ms-office365-filtering-correlation-id: 1157e4e4-bc73-4f7e-59db-08dc32847099
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 aRE0AidQDAM/DubXWQxw7jyln8XiEx8p/XA/OCiz6i/9oi5YDV1LTswBo4TSRU0WyuPSIYvtDGPg9ab+V4fYfLqo6QjXM0S8qLHeor8EGkHNT+mjp7Ij4lH3x0C1CigjGgl/kT89l4UE8c3XMrkuyqkiKlpe+kAt0PVh7r3qVOD2Libe7jY93VIO6B5r1pAB64TjNLn/QKf6ki1GWAy2Ba47XKDMwHjEmfTyEOUqWMErXJfJQ0blEjK8oNd5x93AvqRWk/qGc9SX1QBYsPh/KHm8rtEBzK8+Scj+ibRL0gUFQ9GtEoYS8jje6OjQ58KpQegjG/xcM86+Q6WADO+R1fuNKrAipwsZ6NtoIGkPHxpwmp3DoQXw/LLh3DLlZtTGBkMQybAeOw7FJDdlT83cEH9ceYzkNJIHNoXsoCaHd5qo2Tbf5vL3P+FswML5TXRIOXG9nlm0ggHuhGyx8vVkXsv/yw13b0vWjxKZW/HvlY1YaRSWuNu0S5i/CTQORev1jjhuQSj5uuy3HX4D4PtFu3Is9teRE41JqSjUzHscpziAzJ21pxLlOM2hFdStqjnZE7CQag1ixfsFfEUqu8FaZuSYJ5K+URTbocXvhWdVqw81psNSfvqcGF04RsfuK6sB
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5192.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(921011)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?K3VKNUw2KzIvSExFaVF0S3FqN1FjK05TNHNHUzZod0JiT2JMeC9WWmVselY4?=
 =?utf-8?B?dkFVKzFnMGNYVzkxK2NqdWJtMDRrYWlwcUZyRGJCQm1jOEtOWC9aNFFQaDMx?=
 =?utf-8?B?NlJ6UHlFcEtNRWZ0YzBQekEzV3hVUk9IUnlBcGxUa1pRY2ZJdzNNR3dlc3JJ?=
 =?utf-8?B?UTFGemRHUGlLSjRSblNSN093WEM2SmNSRlpGRlhrRGJJQ0xwaFFRMlBnUStC?=
 =?utf-8?B?QWZQSVQwTlRnZTRvMnpqT2kyK0FBSVlnWThzNkxSMEJadDFJOFZzUno0Q21w?=
 =?utf-8?B?MGhKODY4K3BWZ2I1N21HOW0vaGIzRDhuWVljNVhBcGxNWStXcmo0MktoZDY3?=
 =?utf-8?B?Z3RHdGdNNnVHczVQL1NmVlBMZjRxOCtSb0ljZTc2d2hJaktrOXVjYm9sZlhB?=
 =?utf-8?B?NGpkYW40Q20rOUw5TEc4ZWRDVzhyMjVtaWpqVWREa2hQSnN1eGFENEt0emww?=
 =?utf-8?B?TExxanlOSGZsWDBka1ZVVXlkckJyTE84Zkx6RUozbFN2Ly8rYjRoTFYycG9n?=
 =?utf-8?B?UmJEK2EzaWFHaVlvdUdXVm9Ba3JXSDFlTHlHdnZ2Z1ZVVFdBYURLeHN6VkRU?=
 =?utf-8?B?Ykc2clh0QTNKSVdqODB0WTB5TnZXdTFDZFZUWDRzd0dKN0lEKy9KZis5TmtS?=
 =?utf-8?B?YkdNbjFRenRTMllhM2taN3RJVjVLV0oyV016aXorekR5eTFWa3lxTEx3cXVN?=
 =?utf-8?B?YUNYTlJEWnRkZExETlp0cWI5dldJSStWeEU1bTdQWXlXcHU2Ukk5UCs3T0NR?=
 =?utf-8?B?Qitoa01KcGpXM2FZdVpjQzdwRGNsZnFJOWd5NzBNWllod3B5bUUxYnBEblpu?=
 =?utf-8?B?ZzBtVmp6Sm5NQXd4VFFGa254WHh1M0hzZWJraW4xRDFNYmpvOGsvbU9NZkJk?=
 =?utf-8?B?Wm0vWlEvYjZDWVZNcnFpOGhCM0JLaEtYbzlmUXlkZVFFdlg0N3RnUzIvaTQx?=
 =?utf-8?B?QU9SMTZPdWZkQjFVWUhodWlGd045bXUrQnVGN1F2YmJ1ODNNdjNIT29iTy8x?=
 =?utf-8?B?NVBlc3N6bmgwK1VjeDFFT3N1cExYdk1LR0JlMUtmTzhZb01UL280VTRySHE1?=
 =?utf-8?B?WEVRRDdWdU1GdUMxTGpwcWRuSklWaDNhM0dXa3VLZWQzREIveWFPS2IyQnZP?=
 =?utf-8?B?M2JSdGszMFNxUzJMUFFXcTQxVHZtbThNeDlBSWlxRVhOOWJuTTNyOENRTGNl?=
 =?utf-8?B?V0xmMVBNTW4vbmZuWXgvNSttT3hOU29OM3lXSVhQdjN3ZWVodlFoMGFJZXBT?=
 =?utf-8?B?WEk4Y3V1NEhIMkdSZXhTb3hrOGdvK0ZIb0JxNWZqUWF1L0NWWlBoSmJWU3E2?=
 =?utf-8?B?SjB1RFk2OHhqQVhEM0VTT3U3UXo0eXJ1NHAydFJtUlQxK3dIWlZ4K0MyZW8r?=
 =?utf-8?B?dEdKUnBhN20yMmp3THZ6dzlnZit2bE1XOGE5VkxrL1EzcGNnWThJclhzdnVK?=
 =?utf-8?B?TTlZOVhqd1ZFT1Qxajk5WnplR29wYnd6a084QnB2WTIvcjNRcElEMFY3S0RW?=
 =?utf-8?B?N0VDTGdBM0djRkVVUm81cmFUU3FmWGRYUmRuUUhSNkxpeWJNaFJJdVU2cjEv?=
 =?utf-8?B?Rmd1dXZMSndQMHRqekdKZU5ZMEh0TTlvRlVWOWJyRGVkYnQ0dHJHdEJmWlFJ?=
 =?utf-8?B?bDRVOG1ITVlqMGdhbW9GTXdwVG1FaHBPQ0N2OUFNeXltMEJReTdubEh6bGht?=
 =?utf-8?B?VEdWVTB1OGF4Yi9RK3luanJyb0lveTNTVDJGVGdsVlI5UjIrcGg0K0JGUVRw?=
 =?utf-8?B?U2xUV1llb2FJUy9NNlptam1lbm04d2FaaTVIUlN2YUZ1NmxOaWxiKzRQUy96?=
 =?utf-8?B?OUMrNHpCUDZLY0JmTlpESXpwVi80WThrQ0JlSVR0V3BaTXRsT001SG5udTNF?=
 =?utf-8?B?WkE3RHJzQ2ZPZHVYb3VpYjhwNllBQkVOU1NhWTB0NDlldzhwNERtVGxSZjhO?=
 =?utf-8?B?NEtUUGtmSFIyRDJGcGgwVTl3Yis1VnZjSENxMWE4R0Z5eUY2clVObUFKRzNm?=
 =?utf-8?B?K2xuWDZBK0Rnc1cvb2RNUUl4UUd5d2pGRmVRRHVsVnYzaUE3MjJiRFNsd3g5?=
 =?utf-8?B?L1hmVmtaUy9HdnlhVFFYa3BiMnY0MFJlMWtvRjlJWWIrZVNsMlNNMEdVcEZP?=
 =?utf-8?B?ZHhhMlNsdDRvYlRvZlk2Y0oxUUZSTGhDL1JKTWVvbk5pL0FtM2tLZVJwVUhL?=
 =?utf-8?B?Z1E9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1157e4e4-bc73-4f7e-59db-08dc32847099
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2024 02:25:58.5503
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: niaNkxNUiEcHvmGrB5h9YLUmAIwvBNc8ecBAW2bt+5hH0055joOUmvligXZVEuyDSDAE54wz6PJEVZnCCjAqQicQ5KEFk1FMSqCyEV58vNA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8538
X-Proofpoint-GUID: ZzzndM9eSNgGo8ksyQQwqEBmRwqAIHDU
X-Proofpoint-ORIG-GUID: ZzzndM9eSNgGo8ksyQQwqEBmRwqAIHDU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=859 mlxscore=0
 priorityscore=1501 suspectscore=0 impostorscore=0 clxscore=1015
 bulkscore=0 malwarescore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402210015

DQo+IFRoZSBTTEFCX0tBU0FOIGZsYWcgcHJldmVudHMgbWVyZ2luZyBvZiBjYWNoZXMgaW4gc29t
ZSBjb25maWd1cmF0aW9ucywNCj4gd2hpY2ggaXMgaGFuZGxlZCBpbiBhIHJhdGhlciBjb21wbGlj
YXRlZCB3YXkgdmlhIGthc2FuX25ldmVyX21lcmdlKCkuDQo+IFNpbmNlIHdlIG5vdyBoYXZlIGEg
Z2VuZXJpYyBTTEFCX05PX01FUkdFIGZsYWcsIHdlIGNhbiBpbnN0ZWFkIHVzZSBpdA0KPiBmb3Ig
S0FTQU4gY2FjaGVzIGluIGFkZGl0aW9uIHRvIFNMQUJfS0FTQU4gaW4gdGhvc2UgY29uZmlndXJh
dGlvbnMsDQo+IGFuZCBzaW1wbGlmeSB0aGUgU0xBQl9ORVZFUl9NRVJHRSBoYW5kbGluZy4NCj4g
DQo+IFNpZ25lZC1vZmYtYnk6IFZsYXN0aW1pbCBCYWJrYSA8dmJhYmthQHN1c2UuY3o+DQoNClJh
biBhIHJvdWdoIHRlc3Qgd2l0aCBidWlsZCBhbmQgYm9vdHVwIHdpdGggQ09ORklHX0tBU0FOX0dF
TkVSSUMgZW5hYmxlZCwNCmZlZWwgZnJlZSB0byBhZGQNCg0KVGVzdGVkLWJ5OiBYaW9uZ3dlaSBT
b25nIDx4aW9uZ3dlaS5zb25nQHdpbmRyaXZlci5jb20+DQoNClRoYW5rcywNClhpb25nd2VpDQoN
Cj4gLS0tDQo+ICBpbmNsdWRlL2xpbnV4L2thc2FuLmggfCAgNiAtLS0tLS0NCj4gIG1tL2thc2Fu
L2dlbmVyaWMuYyAgICB8IDE2ICsrKystLS0tLS0tLS0tLS0NCj4gIG1tL3NsYWJfY29tbW9uLmMg
ICAgICB8ICAyICstDQo+ICAzIGZpbGVzIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgMTkgZGVs
ZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9rYXNhbi5oIGIvaW5j
bHVkZS9saW51eC9rYXNhbi5oDQo+IGluZGV4IGRiYjA2ZDc4OWU3NC4uNzBkNmE4ZjZlMjVkIDEw
MDY0NA0KPiAtLS0gYS9pbmNsdWRlL2xpbnV4L2thc2FuLmgNCj4gKysrIGIvaW5jbHVkZS9saW51
eC9rYXNhbi5oDQo+IEBAIC00MjksNyArNDI5LDYgQEAgc3RydWN0IGthc2FuX2NhY2hlIHsNCj4g
IH07DQo+IA0KPiAgc2l6ZV90IGthc2FuX21ldGFkYXRhX3NpemUoc3RydWN0IGttZW1fY2FjaGUg
KmNhY2hlLCBib29sIGluX29iamVjdCk7DQo+IC1zbGFiX2ZsYWdzX3Qga2FzYW5fbmV2ZXJfbWVy
Z2Uodm9pZCk7DQo+ICB2b2lkIGthc2FuX2NhY2hlX2NyZWF0ZShzdHJ1Y3Qga21lbV9jYWNoZSAq
Y2FjaGUsIHVuc2lnbmVkIGludCAqc2l6ZSwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgc2xh
Yl9mbGFnc190ICpmbGFncyk7DQo+IA0KPiBAQCAtNDQ2LDExICs0NDUsNiBAQCBzdGF0aWMgaW5s
aW5lIHNpemVfdCBrYXNhbl9tZXRhZGF0YV9zaXplKHN0cnVjdCBrbWVtX2NhY2hlDQo+ICpjYWNo
ZSwNCj4gIHsNCj4gICAgICAgICByZXR1cm4gMDsNCj4gIH0NCj4gLS8qIEFuZCB0aHVzIG5vdGhp
bmcgcHJldmVudHMgY2FjaGUgbWVyZ2luZy4gKi8NCj4gLXN0YXRpYyBpbmxpbmUgc2xhYl9mbGFn
c190IGthc2FuX25ldmVyX21lcmdlKHZvaWQpDQo+IC17DQo+IC0gICAgICAgcmV0dXJuIDA7DQo+
IC19DQo+ICAvKiBBbmQgbm8gY2FjaGUtcmVsYXRlZCBtZXRhZGF0YSBpbml0aWFsaXphdGlvbiBp
cyByZXF1aXJlZC4gKi8NCj4gIHN0YXRpYyBpbmxpbmUgdm9pZCBrYXNhbl9jYWNoZV9jcmVhdGUo
c3RydWN0IGttZW1fY2FjaGUgKmNhY2hlLA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHVuc2lnbmVkIGludCAqc2l6ZSwNCj4gZGlmZiAtLWdpdCBhL21tL2thc2FuL2dl
bmVyaWMuYyBiL21tL2thc2FuL2dlbmVyaWMuYw0KPiBpbmRleCBkZjY2MjdmNjI0MDIuLmQ4Yjc4
ZDI3M2I5ZiAxMDA2NDQNCj4gLS0tIGEvbW0va2FzYW4vZ2VuZXJpYy5jDQo+ICsrKyBiL21tL2th
c2FuL2dlbmVyaWMuYw0KPiBAQCAtMzM0LDE0ICszMzQsNiBAQCBERUZJTkVfQVNBTl9TRVRfU0hB
RE9XKGYzKTsNCj4gIERFRklORV9BU0FOX1NFVF9TSEFET1coZjUpOw0KPiAgREVGSU5FX0FTQU5f
U0VUX1NIQURPVyhmOCk7DQo+IA0KPiAtLyogT25seSBhbGxvdyBjYWNoZSBtZXJnaW5nIHdoZW4g
bm8gcGVyLW9iamVjdCBtZXRhZGF0YSBpcyBwcmVzZW50LiAqLw0KPiAtc2xhYl9mbGFnc190IGth
c2FuX25ldmVyX21lcmdlKHZvaWQpDQo+IC17DQo+IC0gICAgICAgaWYgKCFrYXNhbl9yZXF1aXJl
c19tZXRhKCkpDQo+IC0gICAgICAgICAgICAgICByZXR1cm4gMDsNCj4gLSAgICAgICByZXR1cm4g
U0xBQl9LQVNBTjsNCj4gLX0NCj4gLQ0KPiAgLyoNCj4gICAqIEFkYXB0aXZlIHJlZHpvbmUgcG9s
aWN5IHRha2VuIGZyb20gdGhlIHVzZXJzcGFjZSBBZGRyZXNzU2FuaXRpemVyIHJ1bnRpbWUuDQo+
ICAgKiBGb3IgbGFyZ2VyIGFsbG9jYXRpb25zIGxhcmdlciByZWR6b25lcyBhcmUgdXNlZC4NCj4g
QEAgLTM3MiwxMyArMzY0LDEzIEBAIHZvaWQga2FzYW5fY2FjaGVfY3JlYXRlKHN0cnVjdCBrbWVt
X2NhY2hlICpjYWNoZSwgdW5zaWduZWQNCj4gaW50ICpzaXplLA0KPiAgICAgICAgIC8qDQo+ICAg
ICAgICAgICogU0xBQl9LQVNBTiBpcyB1c2VkIHRvIG1hcmsgY2FjaGVzIHRoYXQgYXJlIHNhbml0
aXplZCBieSBLQVNBTg0KPiAgICAgICAgICAqIGFuZCB0aGF0IHRodXMgaGF2ZSBwZXItb2JqZWN0
IG1ldGFkYXRhLg0KPiAtICAgICAgICAqIEN1cnJlbnRseSB0aGlzIGZsYWcgaXMgdXNlZCBpbiB0
d28gcGxhY2VzOg0KPiArICAgICAgICAqIEN1cnJlbnRseSB0aGlzIGZsYWcgaXMgdXNlZCBpbiBv
bmUgcGxhY2U6DQo+ICAgICAgICAgICogMS4gSW4gc2xhYl9rc2l6ZSgpIHRvIGFjY291bnQgZm9y
IHBlci1vYmplY3QgbWV0YWRhdGEgd2hlbg0KPiAgICAgICAgICAqICAgIGNhbGN1bGF0aW5nIHRo
ZSBzaXplIG9mIHRoZSBhY2Nlc3NpYmxlIG1lbW9yeSB3aXRoaW4gdGhlIG9iamVjdC4NCj4gLSAg
ICAgICAgKiAyLiBJbiBzbGFiX2NvbW1vbi5jIHZpYSBrYXNhbl9uZXZlcl9tZXJnZSgpIHRvIHBy
ZXZlbnQgbWVyZ2luZyBvZg0KPiAtICAgICAgICAqICAgIGNhY2hlcyB3aXRoIHBlci1vYmplY3Qg
bWV0YWRhdGEuDQo+ICsgICAgICAgICogQWRkaXRpb25hbGx5LCB3ZSB1c2UgU0xBQl9OT19NRVJH
RSB0byBwcmV2ZW50IG1lcmdpbmcgb2YgY2FjaGVzDQo+ICsgICAgICAgICogd2l0aCBwZXItb2Jq
ZWN0IG1ldGFkYXRhLg0KPiAgICAgICAgICAqLw0KPiAtICAgICAgICpmbGFncyB8PSBTTEFCX0tB
U0FOOw0KPiArICAgICAgICpmbGFncyB8PSBTTEFCX0tBU0FOIHwgU0xBQl9OT19NRVJHRTsNCj4g
DQo+ICAgICAgICAgb2tfc2l6ZSA9ICpzaXplOw0KPiANCj4gZGlmZiAtLWdpdCBhL21tL3NsYWJf
Y29tbW9uLmMgYi9tbS9zbGFiX2NvbW1vbi5jDQo+IGluZGV4IDIzODI5M2IxZGJlMS4uN2NmYTJm
MWNlNjU1IDEwMDY0NA0KPiAtLS0gYS9tbS9zbGFiX2NvbW1vbi5jDQo+ICsrKyBiL21tL3NsYWJf
Y29tbW9uLmMNCj4gQEAgLTUwLDcgKzUwLDcgQEAgc3RhdGljIERFQ0xBUkVfV09SSyhzbGFiX2Nh
Y2hlc190b19yY3VfZGVzdHJveV93b3JrLA0KPiAgICovDQo+ICAjZGVmaW5lIFNMQUJfTkVWRVJf
TUVSR0UgKFNMQUJfUkVEX1pPTkUgfCBTTEFCX1BPSVNPTiB8IFNMQUJfU1RPUkVfVVNFUiB8IFwN
Cj4gICAgICAgICAgICAgICAgIFNMQUJfVFJBQ0UgfCBTTEFCX1RZUEVTQUZFX0JZX1JDVSB8IFNM
QUJfTk9MRUFLVFJBQ0UgfCBcDQo+IC0gICAgICAgICAgICAgICBTTEFCX0ZBSUxTTEFCIHwgU0xB
Ql9OT19NRVJHRSB8IGthc2FuX25ldmVyX21lcmdlKCkpDQo+ICsgICAgICAgICAgICAgICBTTEFC
X0ZBSUxTTEFCIHwgU0xBQl9OT19NRVJHRSkNCj4gDQo+ICAjZGVmaW5lIFNMQUJfTUVSR0VfU0FN
RSAoU0xBQl9SRUNMQUlNX0FDQ09VTlQgfCBTTEFCX0NBQ0hFX0RNQSB8IFwNCj4gICAgICAgICAg
ICAgICAgICAgICAgICAgIFNMQUJfQ0FDSEVfRE1BMzIgfCBTTEFCX0FDQ09VTlQpDQo+IA0KPiAt
LQ0KPiAyLjQzLjENCg0K

