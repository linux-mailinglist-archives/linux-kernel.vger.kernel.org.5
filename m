Return-Path: <linux-kernel+bounces-164553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89EA28B7F39
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 19:49:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40D7D2856C5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D1E181D18;
	Tue, 30 Apr 2024 17:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=illinois.edu header.i=@illinois.edu header.b="NQjRBB9f"
Received: from mx0b-00007101.pphosted.com (mx0b-00007101.pphosted.com [148.163.139.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A00F1802CE;
	Tue, 30 Apr 2024 17:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714499327; cv=fail; b=jhQA2tYfypTJQwPFxDuRNeSoJCyNLf3KGVpMxkQvweSr5+9JojzzYko33Bw2RB/9Tg1xTYs2Etd3qDiCmyXuDJPFBbT0LgV9FgclepW5Xlp8joqhNbynFBpxn8sdG1gnrcOdfP0hMVS/qgqHFv6S+1Ab0zea5B6BsdFa9V+Dhk0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714499327; c=relaxed/simple;
	bh=osqa+3Vc2hs4Mx6lBkCAcXK2AKbrPXP6zWxQME0D6Fw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mpC5USI+4iJ67qEZqQVfk0lotvwoH2pIFDijnqn0Y9HcSXY+BYvHKFNVFsW5sZW41xJfWXFWChAVRqgEPRObJPqvjqd0GweyrOwNT7U7JwX9QDQe2ooIIgS38oNOf2f19oNtL+lykbeV8sZpGhsYeydylwadZm2wqQu0H0issIM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=illinois.edu; spf=pass smtp.mailfrom=illinois.edu; dkim=pass (2048-bit key) header.d=illinois.edu header.i=@illinois.edu header.b=NQjRBB9f; arc=fail smtp.client-ip=148.163.139.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=illinois.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=illinois.edu
Received: from pps.filterd (m0272703.ppops.net [127.0.0.1])
	by mx0b-00007101.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43UH1L3l021792;
	Tue, 30 Apr 2024 17:06:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=illinois.edu; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=campusrelays;
 bh=osqa+3Vc2hs4Mx6lBkCAcXK2AKbrPXP6zWxQME0D6Fw=;
 b=NQjRBB9f1uj6h7BpUxRVufHpal8ci24Q+iPO/AS1VQzvCqTaLDS0ll/qGlGSqj3fyDgD
 RH/ctV/tz/vwJpdQUtuMhDna9Y5pNPgVfSkktX2JH/CQ9whuIkQgep1vuQxScZcYyUCy
 U1gISnKODxaPJevOCGuXydblHsJcac9bIfqWJK7Ks2ZZRQy3sQOKVLK3iPoNr0QyY4ew
 GAqIEUYgYLGbhlG3uN3EpXrT+7Y9+OhviTif0n+u8diUA0jlgd4BXZqbuhERD2jI4EIW
 xhau4myGOWYNP4ctThC/kh4lSjzoEVG/uA0SjeZU0+sTx0LZIbbZ1HUqQTMn5CRGlkfe Yg== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by mx0b-00007101.pphosted.com (PPS) with ESMTPS id 3xteecjscg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 17:06:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UlMvoeNx1U1Bx0HSpm6wrEKQEa4kI9yjONIkx6xTuVj8lWVscqoZacDPGdYWlPzvbvBEo3V4fxcVl8sEK6tG8/R1TojklLUAPqiReYFW/cFW1oB5rHN2gOZ4qh06TvaBdjTSag4eKxBuYevjT/XD4BFS+/xUnstlMnX3/8v4cnWsHOLqk8Brx6yQ1b6CjkqZEA90vHJMlGi314YBM3wReSGXLVBsKy/jCvv+F59B1h7i0rSsDc+CFh45Es6JJJ2uCtdL29fe9zxOeFoY/+r2216d1UTBdwdZr8mKL7B6Wl/haHt6nQOlig5NG2HFehuiz1bUMD1wXsN4aVqOxSqD7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=osqa+3Vc2hs4Mx6lBkCAcXK2AKbrPXP6zWxQME0D6Fw=;
 b=d+/17dbl7LiASZUZ9x8O3ioYvtt9ckApthOO8gnx/Xml6rUyRKupeyaFBlZ48Hg/I+KEoroHbMef5JVL1aFJaJ5KWVJO2xVqC9bT8ElVN9cR58XFDsfLowOMpLgNjRYsheoAx3FISj8Jly2H2WITiVcGriW9lFQYJeUEJCBYWjbTwO2GUxHEJSUJXNL7jUSVbR91RVmIxiFcpiz6umMfOXpaI2RqfuG3IbAwjlxidM6EpzTGV8N0CaYFG10+v/9+BkPGPrW5tJuKXWkuHg1nkIbnir4rsy+veDjx4JfFahbla1vRW47p+bks1JWhT0Pm4jWWImP57pVNTY7oNdskrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=illinois.edu; dmarc=pass action=none header.from=illinois.edu;
 dkim=pass header.d=illinois.edu; arc=none
Received: from PH7PR11MB5768.namprd11.prod.outlook.com (2603:10b6:510:131::21)
 by PH7PR11MB7661.namprd11.prod.outlook.com (2603:10b6:510:27b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Tue, 30 Apr
 2024 17:06:52 +0000
Received: from PH7PR11MB5768.namprd11.prod.outlook.com
 ([fe80::d752:67a8:213:37dc]) by PH7PR11MB5768.namprd11.prod.outlook.com
 ([fe80::d752:67a8:213:37dc%4]) with mapi id 15.20.7519.031; Tue, 30 Apr 2024
 17:06:52 +0000
From: "Yang, Chenyuan" <cy54@illinois.edu>
To: Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        "linux-media@vger.kernel.org"
	<linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "jani.nikula@intel.com" <jani.nikula@intel.com>,
        "syzkaller@googlegroups.com" <syzkaller@googlegroups.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "Zhao, Zijie"
	<zijie4@illinois.edu>,
        "Zhang, Lingming" <lingming@illinois.edu>
Subject: Re: [Linux Kernel Bugs] KASAN: slab-use-after-free Read in
 cec_queue_msg_fh and 4 other crashes in the cec device (`cec_ioctl`)
Thread-Topic: [Linux Kernel Bugs] KASAN: slab-use-after-free Read in
 cec_queue_msg_fh and 4 other crashes in the cec device (`cec_ioctl`)
Thread-Index: 
 AQHaOS3lbHvq7Jnry0+S2folBlrDv7Dg7XiAgA77AQCAArhcAIAUcEOAgAE90QCAEAxSgIACE8sUgAIYTQCAWJMhgP//7EwAgAB2WgCACjLoAIABr2kA///6doA=
Date: Tue, 30 Apr 2024 17:06:52 +0000
Message-ID: <7E76BF48-21F3-4C96-B6A7-C0E9D107D61F@illinois.edu>
References: 
 <PH7PR11MB57688E64ADE4FE82E658D86DA09EA@PH7PR11MB5768.namprd11.prod.outlook.com>
 <f985d664-d907-48ed-9b3d-dc956c178b88@xs4all.nl>
 <526380BE-57AC-493D-A7B0-B8F0ECC0FE0A@illinois.edu>
 <f1855145-9562-4bef-800f-43bcacff6fc8@xs4all.nl>
 <2e5f1e92-7fad-4a74-b375-1e194ff08ce6@xs4all.nl>
 <F8D4A291-8CFB-4A25-B296-3CA07B56F459@illinois.edu>
 <49a68c10-9549-4fd8-b929-d4c7a9c8debf@xs4all.nl>
 <PH7PR11MB5768B0BC3C042A6EA4EC1EF0A0542@PH7PR11MB5768.namprd11.prod.outlook.com>
 <7E36CBBD-F2AD-4D98-8D4E-F52E62C3E812@illinois.edu>
 <f196c736-dbfe-4ca0-995b-1720bf530edf@xs4all.nl>
 <C84ADEF3-5553-41AF-B127-85D5630CC8A1@illinois.edu>
 <9e76f971-b2d7-424a-bf21-c6cf5cd4a3f3@xs4all.nl>
 <CA3D308A-ED29-440C-A6C5-C5450CDA2C84@illinois.edu>
 <ace1b749-9a4d-4c68-b5a7-530e0d3ff504@xs4all.nl>
In-Reply-To: <ace1b749-9a4d-4c68-b5a7-530e0d3ff504@xs4all.nl>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB5768:EE_|PH7PR11MB7661:EE_
x-ms-office365-filtering-correlation-id: 0e8c20af-febd-4590-4e8b-08dc6937ee83
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?YjdkcnFRTFhiRS9WUTJVdUt2OGVodlBBa2VmakhRamw2UGR1Z1FhZVFYRU5w?=
 =?utf-8?B?WElESG5VR2szOGFpeFdsb2VZdi9PSXBIc2JoOW45UlY1QXRxTGlORWhvb1Jj?=
 =?utf-8?B?UEFsS3NqbzdqNUxvamFobEZZSVhnT1UrdDArTitZam1Lbmc5TlV4a0Q4NTZm?=
 =?utf-8?B?U2tXVUY3WGprQXhqWTVudzBtK2xjMDg1UmQ1KzFMMEpRU3lCaGlUa29QeTlR?=
 =?utf-8?B?NDA2eHYwbGg3NU9YUDFHNGxuVFVlaWt3Z3JkZFRhODhFSWFhVnNmNmd1UXpu?=
 =?utf-8?B?RG83a0Z4MzZueGhsdTB1UjhvTzUyZVFLRFdybGdFVG0xSWRLSVpuRTcxRzVM?=
 =?utf-8?B?bkV6RlFJTTgyZVJLSlB6TjVyZUxEcFlqbUxuRjJENWNqM1RvOFpGdFFsUnFw?=
 =?utf-8?B?QWorOVVpTS9YdHJneStYbFhKakNXaTF6MEV6NGxTUUpJdWZ0RHk5Umh1MnhP?=
 =?utf-8?B?aWdYbmc2d1pKeVF6dGx2ZHN4a2NiL2FjcE9PcTB5bncwYUJEWVdNeXRJNWsy?=
 =?utf-8?B?TW5Ic01lamFuUjZIV3RlZ2I3eFpGSjFrdlJQWGJrTUdlR045cDJJT2JoMEUr?=
 =?utf-8?B?VnhsWEF0UDcxMHVSTSt2UDJ0c3JQcmlhNGtHaXgyN3p0YUlMU0ZHaFFBczF2?=
 =?utf-8?B?QStGZzVZSmRERnFBd2lGNENvZUJpUUoxT2RLU0NDQ1NaTTlGRDBGaWFVdkZN?=
 =?utf-8?B?Z0JYTUI4TjR2UGtZNTkwN2VMVHhVamxiUk9LVmlXQkFxc0V1bnVKcTA4dFlC?=
 =?utf-8?B?ek5nQkNEeE16eXpnVmNXdW8ybjdpaXRrM2xEUW1TQmUrQ1F3bjlyKzEySU0x?=
 =?utf-8?B?VDc4bGE2V2ozSzZKeDlqNlcwVGE0MG1vN00wN0s3ZkZmbFp1RDBZSG91akxi?=
 =?utf-8?B?S3pEQ2hFamhzUkJoNmxLa3hiaE9JK2ZuOWVQcTg3OUE0dkFuUzM2dkxwbjJU?=
 =?utf-8?B?SEJQaWJkdVRxNy9qMjhjbzdNZ1VzMDQvUUNaWlcxNnNkYjk2T0ZVL2FHU01D?=
 =?utf-8?B?ZnJVaEZBU0NVcE9tMkpMejNsY3BXREI3SFh2dFlWMVJtTk5jS1FrcmJ6V1Er?=
 =?utf-8?B?bEl6d3lmZmc5Y2w5UUpacmdyN3F1R1p3ZktNT0VjK1dBa24xYml5d3RXWkhD?=
 =?utf-8?B?bXVoVFdaMGxRQ2FlVTVmZUhEdVN5UHlRLzJVczZVWmU1QzZKOExXZHpPcUVI?=
 =?utf-8?B?WVRwYmR3a2R2Qk5makZpQkl3VHV6b01rSnNmbVYyeHQyK2NEZmxtZ2psdTNy?=
 =?utf-8?B?cDJPNmhHeWYvTXAyLzRObVNHeE52S2FtL2hmSytvbkpYWnBrd0NoNS8rOE9x?=
 =?utf-8?B?bzk5QkdUK1FNeTdBUTJldEJ5UDJiaDNseTY4amJ4OW5laytVN1lDaTlacnRE?=
 =?utf-8?B?QVovSEZ3Szd1aC9TRHl5Q1Z6dktzUnhjcWRtbGNTSjEyblgzMXB6TjZhS1BS?=
 =?utf-8?B?S0RjL000VEpLUERrU3g2Sm9wU3Z5RjRRRXdNTDc4VEc3a21WYk9EQkkzdHdS?=
 =?utf-8?B?SUhrL2lwRTd6R2JKRzEySHhVUWd1TmhzRHR6Si9Rd1hWMGhhMVpNajFqcmQ4?=
 =?utf-8?B?Y0V2dm56Tk1qYTNITVErZTBXYWJ5YnM3czBrZGgzR25SaFc3dEprMFhzQXBw?=
 =?utf-8?B?a09DVEU5UHlsSG90ZzFoRmczcEZkWkxIaEJyZGsrQlppb244ZTVzRUxzOEdZ?=
 =?utf-8?B?YkxwUEtCM2t5RWNJb2FSYm5iaHVvZXA2YThMTTd6SkR0VkRrVXlWMWVRPT0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5768.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?eTdsUzgzRXExY2JKTFlRMEdJUkVKQ3prNTRoeE45Rm5ZMklEOThRYXFwTGww?=
 =?utf-8?B?a0F0L3p3WE9kSUQ2K1JCU3JJRmNkMi91R3N5b0oxY2pFaGlpcExhaXNTSjFq?=
 =?utf-8?B?OGNWTUl1T3MrTXNZZWdlUzJ1YW5qMlJpNHBQS2NTK1pOSHRuNjNpRUYxc3lU?=
 =?utf-8?B?QS9MSWVTL3lPcGh1RlI3U0xKdi9GQ09JMlZSNzJ1Vnc5V0xlM2JyQXp0Q2ZT?=
 =?utf-8?B?YTNPU1Y5NE92cWlLOVQyR0VhQktMdkZqdC9VbXlqcVJqRG1LdnBLL21DQzVk?=
 =?utf-8?B?TjNNa2JUaFhNSHozNE4zOExJNHlzUmI5MW84dUVXcE5acmFWVnFJaWJCcWhT?=
 =?utf-8?B?MXNrMWRpdkxtaHBBTjc2L3Bkd0hmcDJnVDBpWEVrWnNsQXpQUzVmcDlnNzhv?=
 =?utf-8?B?QnFNK1JQMXYvT0RKQ0Y1R2ZsU3IwSzRtNldNOW5PMVkxbE96a0FNMjZZTkho?=
 =?utf-8?B?Y0xObGRCV0djRWgyZjRoNFdOU3paaEduYlNDMG1ua0ZQVGhmMHBrTmxBMCtS?=
 =?utf-8?B?NFBsSEtkQUJ4blBVMnFja3dtWTYrMDV3QnhwYzkycUxCbjdFZWlvNVNBanhw?=
 =?utf-8?B?bWRTQVVUa1hSVG5RTFdmNGZKbS92ZForcDV4bERuSzZsZ3dpSkJZN1h0Z1hM?=
 =?utf-8?B?ekVtRDdqSW1xZitRRktoYVYwSHhxMHlBS2RueVQrZ2d3OVJBVjRKT0JJY2Uv?=
 =?utf-8?B?K0JvTDNjMVhrRFVqSW9iMFBOZ3lrV1UwanZweHVpWGd4amxSUWt5ejdtd2tD?=
 =?utf-8?B?QnZnK3JIbDhlV1dLa2MxTzVHSGcvTktnQ0cvc3ZtektBSnk3dFIzcnZzbXVq?=
 =?utf-8?B?MUhGbEUzN05jWmxHYjZaMEV6OGdJL3RTdllVNnE4a1JCWW1sN1NBeUR6NHZq?=
 =?utf-8?B?UGYzd3d6YnI5Z1owU3AxOFNyV2tZWWRKTytpSnVhZmwvSkxta2UxWWVLc2xQ?=
 =?utf-8?B?Z3UvV3hsVStoSTUxUmpMVEM4Y3BKUnMwZ2JRMVIxNkxIWFdTY0hYdXprU09s?=
 =?utf-8?B?cVZxdUswclQzbHV4K3VTdUk1R05XS3R4Q0JMVnVqM0hEb1VCZ3M4SnhoT1k2?=
 =?utf-8?B?cU9Nb3dnTTgxblpqRXd5RGhHZjdjYlhXS0RRajBjcTB2YkhLWHZNMWdEZ3pk?=
 =?utf-8?B?SHRrQm5pTHd6aFI2TnlNT3VoVUExc3FONU9xaHZZWk9BU2pvTGk3WXVSS21Q?=
 =?utf-8?B?ZytKelZxL1h3dzhPK0F5VlV4eU41OFptQTJ2bEptOXBEeU1iK2JkZHMvUkhx?=
 =?utf-8?B?K09SUWFaWEV2OE5Md2IydWtINERIQks5MXNTQmpzd2VTaTJBZGV2ODZkZVQy?=
 =?utf-8?B?bkNPM3pjSzNBRHF2a0lwWWYzVXNROC9oQXdWcW1BbER5YnJFVGZLMWVDU2FV?=
 =?utf-8?B?TUF2Q3VHbVU1Zm45MDFsL1BpQ0pNVXV1dWR5Skg0RU9rUHJtempUUG1sZncw?=
 =?utf-8?B?SE1LbGlOVm9RZ2hlU3k5V09zT2E2K0MvbURVQjZtajJlQnJYb0wvVzgyeTZY?=
 =?utf-8?B?dE1yTWJ5b1RLa2JzbE5ZZ2hGRUMxNHJFS2pQM2poZTFrenIxRWFxNG42TWxG?=
 =?utf-8?B?VkZlaitaeGJKWFFvYzBQbmc1d0ZScktkQWZRS0hGdU9Oa0ZmaGRXY1VOV1ZM?=
 =?utf-8?B?VnZpblRtNkVGZUVENGl3TmVGSDgweHV5czRVb0NwdEk1aW84enpIUGJqc29j?=
 =?utf-8?B?cFdKa1o5QVVIUGNRd05CaGFLUnhlQ09UWndDKzhjOCtNTWtnQTJlVnBXRzdx?=
 =?utf-8?B?NzNhSzFvSzlKdnNMRDl0d2FYZ3MxcGg1SGZnc3MrT2ViNEhEZUphSzdudU1V?=
 =?utf-8?B?dld3eFBTQldSb3o2NU5nOC95VWI2NGpXWm1YT3dQZG5ydUR0bko4V1lrYkNT?=
 =?utf-8?B?L3hIZjZVMHE1Yk9kV0tkNUdBR2tEUW9zUERqcUdyVThKTGh3dXRMUDc3K1RH?=
 =?utf-8?B?Ym1QV2s2TFhvUkJwZ0lDWGZ2aXdBS2RZV1EzSExHRWFLTW9mbUhWWWxlMkhm?=
 =?utf-8?B?NmNMeGQ5dmZIdXNoRWRFbk5GbXhtWmhESWxlWG1UTWhReHBWMzFMVGdsSmU2?=
 =?utf-8?B?WnRVUGhoT0lrRUNXMjNOaGo1RzFmK3NEWWJjUFdWN0NPclhMdHpKazh3QllI?=
 =?utf-8?Q?x7k3ZjbxMMLD9G0BUi0CL63JH?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CDF8F9F9417542469A42849CD94C4531@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: illinois.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5768.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e8c20af-febd-4590-4e8b-08dc6937ee83
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2024 17:06:52.4779
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 44467e6f-462c-4ea2-823f-7800de5434e3
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vy8jabWKAX4DbgFmhELO0JHWkaQnL+k22dQcoFKt5vpvZ1jBeJbJroEClQ7XlxbuQysQ981hA1u2Ie8CD3qCbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7661
X-Proofpoint-GUID: eU0I1BdBau8O-ROf08ohAO8paf8tI9vj
X-Proofpoint-ORIG-GUID: eU0I1BdBau8O-ROf08ohAO8paf8tI9vj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-30_10,2024-04-30_01,2023-05-22_02
X-Spam-Details: rule=cautious_plus_nq_notspam policy=cautious_plus_nq score=0
 impostorscore=0 bulkscore=0 mlxlogscore=999 lowpriorityscore=0
 clxscore=1015 adultscore=0 suspectscore=0 malwarescore=0
 priorityscore=1501 phishscore=0 spamscore=0 mlxscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404300122
X-Spam-Score: 0
X-Spam-OrigSender: cy54@illinois.edu
X-Spam-Bar: 

SGkgSGFucywNCiANClRoYW5rcyBzbyBtdWNoIGZvciB5b3VyIHByb21wdCByZXNwb25zZSENClRo
aXMgcGF0Y2ggZG9lcyBmaXggdGhlIGVycm9yIGFuZCB0aGVyZSBpcyBubyAidHJhbnNtaXQgdGlt
ZWQgb3V0IiBtZXNzYWdlIGFueW1vcmUhDQoNCihTb3JyeSBJIHJlcGxpZWQgdGhpcyB0d2ljZSBz
aW5jZSBJIGZvcmdvdCB0byB0dXJuIG9uIHRoZSBwbGFpbiB0ZXh0IG1vZGUgaW4gbXkgZmlyc3Qg
cmVwbHkuKQ0KIA0KQmVzdCwNCkNoZW55dWFuDQoNCu+7v09uIDQvMzAvMjQsIDM6MjYgQU0sICJz
eXprYWxsZXJAZ29vZ2xlZ3JvdXBzLmNvbSA8bWFpbHRvOnN5emthbGxlckBnb29nbGVncm91cHMu
Y29tPiBvbiBiZWhhbGYgb2YgSGFucyBWZXJrdWlsIiA8c3l6a2FsbGVyQGdvb2dsZWdyb3Vwcy5j
b20gPG1haWx0bzpzeXprYWxsZXJAZ29vZ2xlZ3JvdXBzLmNvbT4gb24gYmVoYWxmIG9mIGh2ZXJr
dWlsLWNpc2NvQHhzNGFsbC5ubCA8bWFpbHRvOmh2ZXJrdWlsLWNpc2NvQHhzNGFsbC5ubD4+IHdy
b3RlOg0KDQoNCkhpIENoZW55dWFuLA0KDQoNCk9uIDI5LzA0LzIwMjQgMTc6NDIsIFlhbmcsIENo
ZW55dWFuIHdyb3RlOg0KPiBIaSBIYW5zLA0KPiANCj4gSGVyZSBpcyBteSBRRU1VIGJvb3Rpbmcg
Y29tbWFuZDoNCj4gDQo+IGBgYA0KPiBxZW11LXN5c3RlbS14ODZfNjQgXA0KPiAtbSAyRyBcDQo+
IC1zbXAgMiBcDQo+IC1rZXJuZWwgbGludXgvYXJjaC94ODYvYm9vdC9iekltYWdlIFwNCj4gLWFw
cGVuZCAiY29uc29sZT10dHlTMCByb290PS9kZXYvc2RhIGVhcmx5cHJpbnRrPXNlcmlhbCBuZXQu
aWZuYW1lcz0wIiBcDQo+IC1kcml2ZSBmaWxlPWltYWdlL2J1bGxzZXllLXFlbXUuaW1nLGZvcm1h
dD1yYXcgXA0KPiAtbmV0IHVzZXIsaG9zdD0xMC4wLjIuMTAsaG9zdGZ3ZD10Y3A6MTI3LjAuMC4x
OjEwMDIxLToyMiBcDQo+IC1uZXQgbmljLG1vZGVsPWUxMDAwIFwNCj4gLWVuYWJsZS1rdm0gXA0K
PiAtbm9ncmFwaGljIFwNCj4gLXBpZGZpbGUgdm0ucGkNCj4gYGBgDQo+IA0KPiBQbHVzLCBoZXJl
IGlzIHRoZSBjb25maWcgb2Ygdml2aWQgZnJvbSBteSBsaW51eCBrZXJuZWwgYnVpbGRpbmcgY29u
ZmlnOg0KPiANCj4gYGBgDQo+IENPTkZJR19WSURFT19WSVZJRD15DQo+IENPTkZJR19WSURFT19W
SVZJRF9DRUM9eQ0KPiBDT05GSUdfVklERU9fVklWSURfTUFYX0RFVlM9NjQNCj4gDQo+IENPTkZJ
R19DTURMSU5FPSIuLi4gdml2aWQubl9kZXZzPTE2IHZpdmlkLm11bHRpcGxhbmFyPTEsMiwxLDIs
MSwyLDEsMiwxLDIsMSwyLDEsMiwxLDIgLi4uIg0KPiANCj4gIyBIZXJlIGlzIHRoZSBmdWxsDQo+
IENPTkZJR19DTURMSU5FPSJlYXJseXByaW50az1zZXJpYWwgbmV0LmlmbmFtZXM9MCBzeXNjdGwu
a2VybmVsLmh1bmdfdGFza19hbGxfY3B1X2JhY2t0cmFjZT0xIGltYV9wb2xpY3k9dGNiIG5mLWNv
bm50cmFjay1mdHAucG9ydHM9MjAwMDAgbmYtY29ubnRyYWNrLXRmdHAucG9ydHM9MjAwMDAgbmYt
Y29ubnRyYWNrLXNpcC5wb3J0cz0yMDAwMCBuZi1jb25udHJhY2staXJjLnBvcnRzPTIwMDAwIG5m
LWNvbm50cmFjay1zYW5lLnBvcnRzPTIwMDAwIGJpbmRlci5kZWJ1Z19tYXNrPTAgcmN1cGRhdGUu
cmN1X2V4cGVkaXRlZD0xIHJjdXBkYXRlLnJjdV9jcHVfc3RhbGxfY3B1dGltZT0xIG5vX2hhc2hf
cG9pbnRlcnMgcGFnZV9vd25lcj1vbiBzeXNjdGwudm0ubnJfaHVnZXBhZ2VzPTQgc3lzY3RsLnZt
Lm5yX292ZXJjb21taXRfaHVnZXBhZ2VzPTQgc2VjcmV0bWVtLmVuYWJsZT0xIHN5c2N0bC5tYXhf
cmN1X3N0YWxsX3RvX3BhbmljPTEgbXNyLmFsbG93X3dyaXRlcz1vZmYgY29yZWR1bXBfZmlsdGVy
PTB4ZmZmZiByb290PS9kZXYvc2RhIGNvbnNvbGU9dHR5UzAgdnN5c2NhbGw9bmF0aXZlIG51bWE9
ZmFrZT0yIGt2bS1pbnRlbC5uZXN0ZWQ9MSBzcGVjX3N0b3JlX2J5cGFzc19kaXNhYmxlPXByY3Rs
IG5vcGNpZCB2aXZpZC5uX2RldnM9MTYgdml2aWQubXVsdGlwbGFuYXI9MSwyLDEsMiwxLDIsMSwy
LDEsMiwxLDIsMSwyLDEsMiBuZXRyb20ubnJfbmRldnM9MTYgcm9zZS5yb3NlX25kZXZzPTE2IHNt
cC5jc2RfbG9ja190aW1lb3V0PTEwMDAwMCB3YXRjaGRvZ190aHJlc2g9NTUgd29ya3F1ZXVlLndh
dGNoZG9nX3RocmVzaD0xNDAgc3lzY3RsLm5ldC5jb3JlLm5ldGRldl91bnJlZ2lzdGVyX3RpbWVv
dXRfc2Vjcz0xNDAgZHVtbXlfaGNkLm51bT04IGttc2FuLnBhbmljPTEiDQo+IGBgYA0KPiANCj4g
UGx1cywgSSBhdHRhY2hlZCB0aGUgY3VycmVudCBwYXRjaCAoZ2l0IGRpZmYgPiBwYXRjaCkuDQo+
IA0KPiBMZXQgbWUga25vdyBpZiB5b3UgbmVlZCBhbnkgZnVydGhlciBpbmZvcm1hdGlvbi4NCg0K
DQpBaCwgdGhhdCB3YXMgaGVscGZ1bC4gSSBhbHNvIGRpc2NvdmVyZWQgdGhhdCBJIGhhZCB0byBy
dW4gdGhlIHJlcHJvZHVjZXIgYXMgcm9vdCwNCnRoYXQgaGVscGVkIHRvbyA6LSkNCg0KDQpQbGVh
c2UgYWRkIHRoaXMgcGF0Y2ggb24gdG9wIG9mIHRoZSBkaWZmIHlvdSBhbHJlYWR5IGhhdmUgYW5k
IHRyeSBhZ2Fpbi4NCg0KDQpUaGUgcmVwcm9kdWNlciBraWxscyBlYWNoIGZvcmtlZCBwcm9jZXNz
IGFmdGVyIDUgc2Vjb25kcyBmcm9tIHdoYXQgSSBjYW4NCnRlbGwuIFRoYXQgY2F1c2VzIGEgZHJp
dmVyIHdhaXQgY2FsbCB0byByZXR1cm4gLUVSRVNUQVJUU1lTLCBhbmQgdGhhdCBjb3JuZXINCmNh
c2Ugd2FzIG5vdCBoYW5kbGVkIGNvcnJlY3RseS4gSXQgY2F1c2VkIHRoZSBoYXJtbGVzcyBidXQg
Y29uZnVzaW5nDQoidHJhbnNtaXQgdGltZWQgb3V0IiBtZXNzYWdlLg0KDQoNClJlZ2FyZHMsDQoN
Cg0KSGFucw0KDQoNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KW1BBVENIXSBjZWM6IGNvcmU6IGF2b2lkIGNvbmZ1
c2luZyAidHJhbnNtaXQgdGltZWQgb3V0IiBtZXNzYWdlDQoNCg0KSWYsIHdoZW4gd2FpdGluZyBm
b3IgYSB0cmFuc21pdCB0byBmaW5pc2gsIHRoZSB3YWl0IGlzIGludGVycnVwdGVkLA0KdGhlbiB5
b3UgbWlnaHQgZ2V0IGEgInRyYW5zbWl0IHRpbWVkIG91dCIgbWVzc2FnZSwgZXZlbiB0aG91Z2gg
dGhlDQp0cmFuc21pdCB3YXMgaW50ZXJydXB0ZWQgYW5kIGRpZCBub3QgYWN0dWFsbHkgdGltZSBv
dXQuDQoNCg0KU2V0IHRyYW5zbWl0X2luX3Byb2dyZXNzX2Fib3J0ZWQgdG8gdHJ1ZSBpZiB0aGUN
CndhaXRfZm9yX2NvbXBsZXRpb25fa2lsbGFibGUoKSBjYWxsIHdhcyBpbnRlcnJ1cHRlZCBhbmQg
ZW5zdXJlDQp0aGF0IHRoZSB0cmFuc21pdCBpcyBwcm9wZXJseSBtYXJrZWQgYXMgQUJPUlRFRC4N
Cg0KDQpTaWduZWQtb2ZmLWJ5OiBIYW5zIFZlcmt1aWwgPGh2ZXJrdWlsLWNpc2NvQHhzNGFsbC5u
bCA8bWFpbHRvOmh2ZXJrdWlsLWNpc2NvQHhzNGFsbC5ubD4+DQotLS0NCmRyaXZlcnMvbWVkaWEv
Y2VjL2NvcmUvY2VjLWFkYXAuYyB8IDE1ICsrKysrKysrKysrKysrLQ0KMSBmaWxlIGNoYW5nZWQs
IDE0IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCg0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9tZWRpYS9jZWMvY29yZS9jZWMtYWRhcC5jIGIvZHJpdmVycy9tZWRpYS9jZWMvY29yZS9jZWMt
YWRhcC5jDQppbmRleCBhNDkzY2JjZTI0NTY3Li5kYTA5ODM0OTkwYjg3IDEwMDY0NA0KLS0tIGEv
ZHJpdmVycy9tZWRpYS9jZWMvY29yZS9jZWMtYWRhcC5jDQorKysgYi9kcml2ZXJzL21lZGlhL2Nl
Yy9jb3JlL2NlYy1hZGFwLmMNCkBAIC00OTAsNiArNDkwLDE1IEBAIGludCBjZWNfdGhyZWFkX2Z1
bmModm9pZCAqX2FkYXApDQpnb3RvIHVubG9jazsNCn0NCg0KDQorIGlmIChhZGFwLT50cmFuc21p
dF9pbl9wcm9ncmVzcyAmJg0KKyBhZGFwLT50cmFuc21pdF9pbl9wcm9ncmVzc19hYm9ydGVkKSB7
DQorIGlmIChhZGFwLT50cmFuc21pdHRpbmcpDQorIGNlY19kYXRhX2NhbmNlbChhZGFwLT50cmFu
c21pdHRpbmcsDQorIENFQ19UWF9TVEFUVVNfQUJPUlRFRCwgMCk7DQorIGFkYXAtPnRyYW5zbWl0
X2luX3Byb2dyZXNzID0gZmFsc2U7DQorIGFkYXAtPnRyYW5zbWl0X2luX3Byb2dyZXNzX2Fib3J0
ZWQgPSBmYWxzZTsNCisgZ290byB1bmxvY2s7DQorIH0NCmlmIChhZGFwLT50cmFuc21pdF9pbl9w
cm9ncmVzcyAmJiB0aW1lb3V0KSB7DQovKg0KKiBJZiB3ZSB0aW1lb3V0LCB0aGVuIGxvZyB0aGF0
LiBOb3JtYWxseSB0aGlzIGRvZXMNCkBAIC03NzEsNiArNzgwLDcgQEAgaW50IGNlY190cmFuc21p
dF9tc2dfZmgoc3RydWN0IGNlY19hZGFwdGVyICphZGFwLCBzdHJ1Y3QgY2VjX21zZyAqbXNnLA0K
ew0Kc3RydWN0IGNlY19kYXRhICpkYXRhOw0KYm9vbCBpc19yYXcgPSBtc2dfaXNfcmF3KG1zZyk7
DQorIGludCBlcnI7DQoNCg0KaWYgKGFkYXAtPmRldm5vZGUudW5yZWdpc3RlcmVkKQ0KcmV0dXJu
IC1FTk9ERVY7DQpAQCAtOTM1LDEwICs5NDUsMTMgQEAgaW50IGNlY190cmFuc21pdF9tc2dfZmgo
c3RydWN0IGNlY19hZGFwdGVyICphZGFwLCBzdHJ1Y3QgY2VjX21zZyAqbXNnLA0KKiBSZWxlYXNl
IHRoZSBsb2NrIGFuZCB3YWl0LCByZXRha2UgdGhlIGxvY2sgYWZ0ZXJ3YXJkcy4NCiovDQptdXRl
eF91bmxvY2soJmFkYXAtPmxvY2spOw0KLSB3YWl0X2Zvcl9jb21wbGV0aW9uX2tpbGxhYmxlKCZk
YXRhLT5jKTsNCisgZXJyID0gd2FpdF9mb3JfY29tcGxldGlvbl9raWxsYWJsZSgmZGF0YS0+Yyk7
DQpjYW5jZWxfZGVsYXllZF93b3JrX3N5bmMoJmRhdGEtPndvcmspOw0KbXV0ZXhfbG9jaygmYWRh
cC0+bG9jayk7DQoNCg0KKyBpZiAoZXJyKQ0KKyBhZGFwLT50cmFuc21pdF9pbl9wcm9ncmVzc19h
Ym9ydGVkID0gdHJ1ZTsNCisNCi8qIENhbmNlbCB0aGUgdHJhbnNtaXQgaWYgaXQgd2FzIGludGVy
cnVwdGVkICovDQppZiAoIWRhdGEtPmNvbXBsZXRlZCkgew0KaWYgKGRhdGEtPm1zZy50eF9zdGF0
dXMgJiBDRUNfVFhfU1RBVFVTX09LKQ0KLS0gDQoyLjQzLjANCg0KDQoNCg0KLS0gDQpZb3UgcmVj
ZWl2ZWQgdGhpcyBtZXNzYWdlIGJlY2F1c2UgeW91IGFyZSBzdWJzY3JpYmVkIHRvIGEgdG9waWMg
aW4gdGhlIEdvb2dsZSBHcm91cHMgInN5emthbGxlciIgZ3JvdXAuDQpUbyB1bnN1YnNjcmliZSBm
cm9tIHRoaXMgdG9waWMsIHZpc2l0IGh0dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMvX19odHRwczov
L2dyb3Vwcy5nb29nbGUuY29tL2QvdG9waWMvc3l6a2FsbGVyL3dBSHdRbDVMOHhrL3Vuc3Vic2Ny
aWJlX187ISFEWjNmamchOFc3OGVPTTlsV3JYMm1lUUVVNW9zMHZJbHh5Vkt4VkhHc3R0b3NFVk1O
M0hOb1dmcDluX2t1YjFXSV9YcFRQWXNqMVN3TEN5YlA4bVEtM3E0V3JKNDdHalM1cjNYY28kIDxo
dHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly9ncm91cHMuZ29vZ2xlLmNvbS9kL3Rv
cGljL3N5emthbGxlci93QUh3UWw1TDh4ay91bnN1YnNjcmliZV9fOyEhRFozZmpnIThXNzhlT005
bFdyWDJtZVFFVTVvczB2SWx4eVZLeFZIR3N0dG9zRVZNTjNITm9XZnA5bl9rdWIxV0lfWHBUUFlz
ajFTd0xDeWJQOG1RLTNxNFdySjQ3R2pTNXIzWGNvJD4gLg0KVG8gdW5zdWJzY3JpYmUgZnJvbSB0
aGlzIGdyb3VwIGFuZCBhbGwgaXRzIHRvcGljcywgc2VuZCBhbiBlbWFpbCB0byBzeXprYWxsZXIr
dW5zdWJzY3JpYmVAZ29vZ2xlZ3JvdXBzLmNvbSA8bWFpbHRvOnN5emthbGxlcit1bnN1YnNjcmli
ZUBnb29nbGVncm91cHMuY29tPi4NClRvIHZpZXcgdGhpcyBkaXNjdXNzaW9uIG9uIHRoZSB3ZWIg
dmlzaXQgaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHBzOi8vZ3JvdXBzLmdvb2dsZS5j
b20vZC9tc2dpZC9zeXprYWxsZXIvYWNlMWI3NDktOWE0ZC00YzY4LWI1YTctNTMwZTBkM2ZmNTA0
IDxodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly9ncm91cHMuZ29vZ2xlLmNvbS9k
L21zZ2lkL3N5emthbGxlci9hY2UxYjc0OS05YTRkLTRjNjgtYjVhNy01MzBlMGQzZmY1MDQ+KjQw
eHM0YWxsLm5sX187SlEhIURaM2ZqZyE4Vzc4ZU9NOWxXclgybWVRRVU1b3MwdklseHlWS3hWSEdz
dHRvc0VWTU4zSE5vV2ZwOW5fa3ViMVdJX1hwVFBZc2oxU3dMQ3liUDhtUS0zcTRXcko0N0dqYUlI
X0dLdyQgLg0KDQoNCg0K

