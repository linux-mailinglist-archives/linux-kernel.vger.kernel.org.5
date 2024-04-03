Return-Path: <linux-kernel+bounces-128851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10A0A896087
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 02:12:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 416731C23AFA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 00:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D2A1109;
	Wed,  3 Apr 2024 00:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="rgN8/QRQ"
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44748161
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 00:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712103114; cv=fail; b=mks0nfeSYulnwjgKJMRgsZFCwng6IhOok8NDzgtgVn67hpXcPLnYHAG7FVFNBpXdJtm+oNztGTS1PbDc0DcijFswAILLBQv15fCYivKAX5N4EekkEi8D6Efb8EanzTVnw5Q//Ibu200E2IMlhFKIZQDwcKKVb4iAWoeZV3jaNQU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712103114; c=relaxed/simple;
	bh=fKRkOXuxeNQO+e95hxSRG7IECUGfE8BB0+i1CYr4lzo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oV/fKv5cFJGp5fV+dqxeiw+DfpXJF7TOtVVU2jVpWflCLxnM61fMdVJQa7ufIuZO1R6LbiBtYLUP0ryCIsgOYq6dO9iB5rCJsCCprfWPtGXgUJioVOK06Mf3pSRYZdTwyVy5e45lfcTTZnYXOXQWzBK5mtC4SvJSpTQhHHXJEWc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=rgN8/QRQ; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43300Mxt025829;
	Tue, 2 Apr 2024 17:11:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	PPS06212021; bh=fKRkOXuxeNQO+e95hxSRG7IECUGfE8BB0+i1CYr4lzo=; b=
	rgN8/QRQQS+K8k3FKilPvA50Q7/NKPY0iNiYZ0ZKz6hYBY6os6KOSI5CXxy/0xPC
	4E2d2PmEBv/SAjMdCR00bTHyFiWKME8e7slRlXYwb15gEsambBZN8mf30MY+C+fW
	LZahOUybyFSaqnwVP+UJZrAJihJ52Jmw+xBhPp577jS3amQcYpH+4anraf3NL0g0
	LscIVcbDAaNiLyJdQI2Yy3SfFHe4n0nHSwgrjiz/ZK4eVkcILnMgYvpkoFpkBB9s
	5PhZM3jleF450nca+bn36XBzfSBnNjoBYDXBVPqdfwLUDpueOqG0beCFO4S3Xn1K
	jgSnY+wD4s2vO3bwv8d9ag==
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3x6j8fuee3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Apr 2024 17:11:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J0Th7e51i/ZbgSiv/KTlrV03wvjC9kA/ZJWjbhDli1S94eYnJoEvacdmgW1BkIjzOZ7QWFewEHNrj4vmfqaGwjc5HlI/psA8N7AM+BQKRmDr6I306gvNE09tcmnyfndPDmKq7cznWhCin7+uL0h53eeoLnN856BC/tmpj7MZoT7MmPokDoqGxnT6b0llN3g0AJgS1Ynd4qISuTewu3Rd8PFjNBh5V6Jt71Ftx7UEd+1TyT4hCWRRmWyplo58Y20oiesTr09HhnN5oY1GxPJacLxhzgIbzZS3R7Q55Kiz0oxcZntu7SpgYXz7h9YkVGvjbpz4iCgrIrRin4y4epQPJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fKRkOXuxeNQO+e95hxSRG7IECUGfE8BB0+i1CYr4lzo=;
 b=bkGJ/JEwg/+NwJAE14x0N6JmtkAp7P+vLRIB3huXsXwwZUhutKPcYCqepQI/MNq2zzagIG5EPpJR5j91OTR741wREniIJIOGxpHXIU65RmoxngA0EUWWHayYVfIkJxPFlAcNEWXtbuCprZnn3Ql24bQ6PugaJGu66zTsy9s+R+l05itBhgyliB2Fei635c3rbbfFuJqV5Ch88MtLYhMY3cmpsH0d32Sn38K7hG8VIx+E5A8gTYANVSswsBFFXlYK4+HOOpsZiTrhee82ZJlTYQdlXVHGjhRk5oxTmOrPgDWO46znPMGOgxaipEnR5b+hRfBzWKYsr888ZS3nBDxfuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from PH0PR11MB5192.namprd11.prod.outlook.com (2603:10b6:510:3b::9)
 by SJ0PR11MB5865.namprd11.prod.outlook.com (2603:10b6:a03:428::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26; Wed, 3 Apr
 2024 00:11:32 +0000
Received: from PH0PR11MB5192.namprd11.prod.outlook.com
 ([fe80::8cb4:86ac:461a:d683]) by PH0PR11MB5192.namprd11.prod.outlook.com
 ([fe80::8cb4:86ac:461a:d683%4]) with mapi id 15.20.7452.019; Wed, 3 Apr 2024
 00:11:32 +0000
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
Subject: RE: [PATCH 4/4] mm/slub: don't read slab->cpu_partial_slabs directly
Thread-Topic: [PATCH 4/4] mm/slub: don't read slab->cpu_partial_slabs directly
Thread-Index: AQHagxH5yUWFMwvaUUqVBJRjiODRO7FUvg4AgADyqoA=
Date: Wed, 3 Apr 2024 00:11:32 +0000
Message-ID: 
 <PH0PR11MB5192EBD264C014279FABF30EEC3D2@PH0PR11MB5192.namprd11.prod.outlook.com>
References: <20240331021926.2732572-1-xiongwei.song@windriver.com>
 <20240331021926.2732572-5-xiongwei.song@windriver.com>
 <e531f01b-b459-4f98-81a6-86649322346f@suse.cz>
In-Reply-To: <e531f01b-b459-4f98-81a6-86649322346f@suse.cz>
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
 nUcHf3dCyHwSsSuOGmdCe9tnshO+AG9fcgJZ3j4Jlf/wrS3MlR14HZSRmgundG9JslikrB6dD/CsBBR50vN/+Z2r031C2v3XQ7EQYjXkuDyLjPs5eTf9UBCsHwUaMgliDvoXXZ0HwODt5suQkOxeEjwts0XvIIrRC3yaln05Yr/jNjMvh7hVl4gGOyKFCbf8B+sA21ygMi8vF8PliP0xNbqNn7261p+UuxLSdSsqDz9011VpkGEcWQuhL7yPttGPAATlweJvSuLtgYLJDxpi54cfR0b27hDBxLcf++DkiC3/VcGPDIyemcspVm1cLGlk2iYKxev1Jd0m5aO0tAMfqdf2/6B/v0lR+hIT4+AX2KAgDoDHqYp7jvhBvd5Vo0pXLPghNERsKbf9Wn295RkPD2dd6tjY15HHi6MYZpBJ4aaUicn7ElVgO1Qf/qjo28S8OJw7+RTGGIWD/f4X6P5v4OVzGudMP3feU3S8LVqq7wGmnlogfk52Gbba7kFbXTyyNxjIQBw2bakxA7EeC9/jVAYu1b5Qijuf1VAjVlT0SAC2Nge2osHSuqUMYtUGyA4qAncAegW1JG8sRotUI2pzt5vUiYyv2SfZ8QeKJ2qW1/x5OzIIiBYBnObvck2bkBngGeolrg0+eaWP30ysNH6fsTqN0iVdnWI9nYKBPRETVrM=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5192.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(7416005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?ZCsrZUg1NlhBZlZ5NzVhSFBBL09TdGlweUt2bDI1cWYxU3VPQUVNWk54UjVk?=
 =?utf-8?B?dXcxVjVocStubG5uY1ZSYi92U0pTK1RPL2Q2RXhEWnpFeHZnRFI5QnFMa3lW?=
 =?utf-8?B?NHJXUSt4SU5hNlN2TlZBempBdmRUalRESXVzS3Y0aVRLT1ZrMGpvUjhMUnJL?=
 =?utf-8?B?VjVJVXlmV09VRDM4c0lZYnJ0NlMvNGduV1FPemZDY3BkOEVDNnQ3V21rdU56?=
 =?utf-8?B?Sys1KzlQZXNGWGlKdzhUNzZlbzE2WUovM0I3ektNSDNpdk9PWUJrRHF6dVhq?=
 =?utf-8?B?TTNmeVRjK3hwNW9saDYxVDJCdmR1bm5wZUIvY3FadStFcHFtR0dqYmdtbHhB?=
 =?utf-8?B?UGVEYWRicUxrVjNUeHdWT20wdTd4ajcvRVNCYitzRWhrMlRDVlRNenlqSC9l?=
 =?utf-8?B?MXJ4d01yUStsMzArbWh3cEJ4L2RRaGRoY3BpaTl0MU1KWXJSbDBmUlhLelFV?=
 =?utf-8?B?SjdxUGRjdmdmODZqQzdiN3J4NFJ4NnhDTm94VlZpZXFvazNTeTlWamd4OTlM?=
 =?utf-8?B?MVp1aUd3Y29VamRkejllSnhwcXBGVnc1ai85bnBDaEFNQlBTcCtLNFEyUllw?=
 =?utf-8?B?OTIraFNlQTBRTjV1eUd1ZERNWWlyQ2NNK3RFUlBRMUtiSU5welVaUkFiTGRk?=
 =?utf-8?B?eWs1ZEJFTHE4M3dlUno2QU82OEk0Q2p6cFBwa2hOM3lPbGxFZ20vemdqQUxO?=
 =?utf-8?B?Y0ZEVGFyY25laUExM1hhajFjcGRTZGJabjMxRWpXZWlNS2xHaC9nR1hDRkE2?=
 =?utf-8?B?aERXa3pibEp5TWh6YisyK1lldzZRRW1BbVAwVFBWU3pSUm4ySmZ3RkYzQU8y?=
 =?utf-8?B?RDR4M3hXWFZySk5EZ3JkdEtidCtRd1RaZmdpakMrbVZvVFQwMjRzZXhkUlZw?=
 =?utf-8?B?Sy9NYTU1aUQ4UUN3OVprT1lkN1RqbDJvZ0plM05mNWg0NjJhTjBCbng4ay9C?=
 =?utf-8?B?Yit4aDNuK09wMTFQbGVkTlRSZWNNbjIvbTkxR3hOS0YyU0E3ME5VeHNCSXBJ?=
 =?utf-8?B?czRvcmlOMU9iSzJNNzFLd3ROWGc2MjdlMkFsWDRXRjB2VEN0bW4xc2N0UzJz?=
 =?utf-8?B?bGtYekJmc3hJL1BVR29SNUIzVFdqUWFkbmR2RHgzcVp0Y3VyR2g3ZVk4cy9v?=
 =?utf-8?B?Y2h6a2NDNUNVeXZzQ2tHSlNydFhITVcxeGxxTzFSanJNTUxnL0Z3MDljcTJ5?=
 =?utf-8?B?T1BPajJHcmppQysxRUZBTVpxaU01Zm15N3ZVcjMyU3FkN3B6UzBteHhBamp1?=
 =?utf-8?B?T0puSFBPeWw3aktBdkxjbFFyb2ZPS3JGOXJ3Wlp6cG84ZVBUdEUzNDdzWXpI?=
 =?utf-8?B?N1RvNTNzbk9GUE5RckY0TGFEWEEwaGs5L0VnaVVDSS80ei9mVDFyNURyTmlX?=
 =?utf-8?B?azMveCsvQVFPU1piM3pnRFRKaEkxQldLUXBpaTdvVStwVmdQQXNJWXMwUE84?=
 =?utf-8?B?OXBJc0xVcmx2dlROb1hFS1lpZXJRU2dVTDdHUFZCcGpoQU0wL2xhUFYxcWxN?=
 =?utf-8?B?WU1TVXg0YUEzUXVvZTRTNWVQL2JUa1hPQzUreSt6MllMT3d1aGxlSnpLNk1U?=
 =?utf-8?B?eU5ubE85S0ZRVWFhRHF0V3ZGVlhYazJ4Q2Fqck1jMUlCeUFjQ2IwTzJ2eUxV?=
 =?utf-8?B?NHhwOFU5Mmk1c0lTUENXN0tuSlVWMmJLNFV2eWZjWWE5c1l2WkZRS3hiZjBr?=
 =?utf-8?B?cnlhc3dGK2QvMjdpSmJPNzlhRTlMaVBlcElwWlRUYzdCZnJFNmNyVzVhemVD?=
 =?utf-8?B?WmYrYTRmZVFWUE9ua2loL3ZXOTlMdThPajBVZzlUcWFKRS9EMVROckc5Sk1D?=
 =?utf-8?B?Wm41Rzk4N3psT1grSFF0SG9SWHhDUG1YWEtydzl3WEhGMjZmTnA3YXZlM1Nn?=
 =?utf-8?B?NHRQTmpjakRvcm53NlNMSndwTXVPWU9qTjc2L2RnaTVIbjNWVm1hR25GRnVS?=
 =?utf-8?B?NmczeXZDV0grdmJVUjU2M3A3MmNJbDg0Y3dicThiRkd6V3JlYU0rNHYvMjdE?=
 =?utf-8?B?WUhsMjBNeHJQeEVLTHlacXltVVZRK3d2KzlzZGdxK0ljTVc1S3FBb2p1elZK?=
 =?utf-8?B?QWY4UVUwYUhLajQrQU9SMktFREFRQzB1V3g3MGo0WndLNVBMWkFGdlNHbnN6?=
 =?utf-8?B?WHlxeE9NR3gxTWM3ZkZHZ2w3QXZVdHRLS2V1MDJOQnJaMVFJRzZ6czZKTzRL?=
 =?utf-8?B?WlE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e5cc44e-6f6c-47a4-0137-08dc53729e5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2024 00:11:32.7928
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6OPdcT2q+IqaMqus91ghcCSh5eABPXBJ9UlrK5AmiVZ/oDqdjoLkdAGVPtuomPXfxnyrbczb0JBfgwTBzwKzd1QEjjGfzMs2TBN1QtKr2VE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5865
X-Proofpoint-ORIG-GUID: 4MiEBMmXcmnps7NWaJ23pXy4Pt2rd-LO
X-Proofpoint-GUID: 4MiEBMmXcmnps7NWaJ23pXy4Pt2rd-LO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-02_15,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=994
 spamscore=0 suspectscore=0 clxscore=1015 mlxscore=0 lowpriorityscore=0
 adultscore=0 malwarescore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2403210001
 definitions=main-2404020178

PiBDQVVUSU9OOiBUaGlzIGVtYWlsIGNvbWVzIGZyb20gYSBub24gV2luZCBSaXZlciBlbWFpbCBh
Y2NvdW50IQ0KPiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3Mg
eW91IHJlY29nbml6ZSB0aGUgc2VuZGVyIGFuZCBrbm93IHRoZSBjb250ZW50DQo+IGlzIHNhZmUu
DQo+IA0KPiBPbiAzLzMxLzI0IDQ6MTkgQU0sIHhpb25nd2VpLnNvbmdAd2luZHJpdmVyLmNvbSB3
cm90ZToNCj4gPiBGcm9tOiBYaW9uZ3dlaSBTb25nIDx4aW9uZ3dlaS5zb25nQHdpbmRyaXZlci5j
b20+DQo+ID4NCj4gPiBXZSBjYW4gdXNlIHNsdWJfZ2V0X2NwdV9wYXJ0aWFsKCkgdG8gcmVhZCBj
cHVfcGFydGlhbF9zbGFicy4NCj4gDQo+IFRoaXMgY29kZSBpcyB1bmRlciB0aGUgI2lmZGVmIHNv
IGl0J3Mgbm90IG5lY2Vzc2FyeSB0byB1c2UgdGhlIHdyYXBwZXIsIG9ubHkNCj4gbWFrZXMgaXQg
aGFyZGVyIHRvIHJlYWQgaW1oby4NCg0KT2ssIGdvdCBpdC4gV2lsbCBkcm9wIHRoaXMgb25lLg0K
DQpUaGFua3MuDQoNCj4gDQo+ID4gU2lnbmVkLW9mZi1ieTogWGlvbmd3ZWkgU29uZyA8eGlvbmd3
ZWkuc29uZ0B3aW5kcml2ZXIuY29tPg0KPiA+IC0tLQ0KPiA+ICBtbS9zbHViLmMgfCAyICstDQo+
ID4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiA+DQo+
ID4gZGlmZiAtLWdpdCBhL21tL3NsdWIuYyBiL21tL3NsdWIuYw0KPiA+IGluZGV4IGVjOTFjNzQz
NWQ0ZS4uNDdlYTA2ZDZmZWFlIDEwMDY0NA0KPiA+IC0tLSBhL21tL3NsdWIuYw0KPiA+ICsrKyBi
L21tL3NsdWIuYw0KPiA+IEBAIC0yOTY2LDcgKzI5NjYsNyBAQCBzdGF0aWMgdm9pZCBwdXRfY3B1
X3BhcnRpYWwoc3RydWN0IGttZW1fY2FjaGUgKnMsIHN0cnVjdCBzbGFiDQo+ICpzbGFiLCBpbnQg
ZHJhaW4pDQo+ID4gICAgICAgb2xkc2xhYiA9IHRoaXNfY3B1X3JlYWQocy0+Y3B1X3NsYWItPnBh
cnRpYWwpOw0KPiA+DQo+ID4gICAgICAgaWYgKG9sZHNsYWIpIHsNCj4gPiAtICAgICAgICAgICAg
IGlmIChkcmFpbiAmJiBvbGRzbGFiLT5zbGFicyA+PSBzLT5jcHVfcGFydGlhbF9zbGFicykgew0K
PiA+ICsgICAgICAgICAgICAgaWYgKGRyYWluICYmIG9sZHNsYWItPnNsYWJzID49IHNsdWJfZ2V0
X2NwdV9wYXJ0aWFsKHMpKSB7DQo+ID4gICAgICAgICAgICAgICAgICAgICAgIC8qDQo+ID4gICAg
ICAgICAgICAgICAgICAgICAgICAqIFBhcnRpYWwgYXJyYXkgaXMgZnVsbC4gTW92ZSB0aGUgZXhp
c3Rpbmcgc2V0IHRvIHRoZQ0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgKiBwZXIgbm9kZSBw
YXJ0aWFsIGxpc3QuIFBvc3Rwb25lIHRoZSBhY3R1YWwgdW5mcmVlemluZw0KPiANCg0K

