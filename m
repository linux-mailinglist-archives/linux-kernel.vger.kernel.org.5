Return-Path: <linux-kernel+bounces-82481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC23868524
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 01:48:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0958C1F22083
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 00:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 391471847;
	Tue, 27 Feb 2024 00:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WS0u7/Wx";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ltEfwFC2"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A65136A
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 00:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708994910; cv=fail; b=F2nDWrVK8MS1+60GxVBMciUUIeBwwQl1P5B9/0QQ9w/x29io+iHzPdimdbcBZIxJ7FTau1wB9y/42dilW+LEWQD8YECUTbX6Pmmu929iHoxIiiWDYYUSjyGqqE/E7X+VVKcJIyfM+O0rumyjopjfYXJmgf5W7YDPsFEBCSDGdxY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708994910; c=relaxed/simple;
	bh=THIevVahoQTQMIBih18toYgcQCOK19vQpjDWrJFlDLg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MwXadUNIamP9u53jEDVeEsNh3pIPZXCzvr4vXpzOTEwtdxVME28LM9XxbhScLruLuPb7JdZTpOOMKjjYJIrVGRO5haP4S/OJRYEznJo58GbH3PtKV9pBZoqu/qH6b7goB9mmzqAJ4UVUxMrCqo9KYwHTNjLEnBl6BVoki5cABn8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WS0u7/Wx; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ltEfwFC2; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41QMRIir019520;
	Tue, 27 Feb 2024 00:48:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=THIevVahoQTQMIBih18toYgcQCOK19vQpjDWrJFlDLg=;
 b=WS0u7/WxvCGszJMoNr3xJ3g7mOU5q8gqARqnLVRKIV41WsCDZT4CjWCPJDK3trHYHJEW
 LmH74Uecr53t5tlR+shEEw1gQ7hrKSS55PvzBMeKtXbcaAJEMpX3C1TBdgF197dl33e1
 w9Hyf5r0ke2cgfn5kkAEs2mMWsNleuaI7TZm/9ujixdx0NfUG8a+EC6joUtPsaVkW5xu
 WGwYlhNVhq/s94uh06+Ej7KV5QTV/uE/Cv2ehch262ZKgaYJgAA1pZqeQUujP+0Vc64w
 c4nfs1WPtRwBYbOKmck5RF/f9Lv/pcDTawHy4voRerz8cNC7OxDJ1bSBkSpC6In6Mss8 RQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wf722dwx7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Feb 2024 00:48:19 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41R0DSNq015256;
	Tue, 27 Feb 2024 00:48:19 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wf6w6n737-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Feb 2024 00:48:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kluJrcRe9G2qIE8tduOtxmO96FvBv68dBBmpeJIMaO4MKaPUntKXRwV6Ol+j2vbdiOxOo4NrVUfcDIa0l1lq8o21qklbSwgAZc741CDJgybxAmlSFGHpSxLEW451mFNroHZvSlMreU3rowsFOkXHrhHHVjZf65AORTp1XyiTYLTuROu7NS3IlXO4AxKSBkGUq7csWe6hTRGm5/1ROTyaHEOCEHh+cEYWNFrL0q0n4C9oTjDlrU9IZYQj/tIAlLMiGZQKuBl/bI5N3TPHeTQZd9mD3BkAoKF/btpPGZdViqheh+zfmvxUI6zj1Gtp+h/oe9/UIZjzQeXt/IfWwtdFvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=THIevVahoQTQMIBih18toYgcQCOK19vQpjDWrJFlDLg=;
 b=TIRCyFJY6FTLoR+6yFgDkJQ7a9noahPGDKRLgaBc4+9wMUVzmfdLHB++Gz3E0SAILNFBamvqnyKKoPZ7fx3bWQiaQsCNi/DMKY9RmiuIXC7m5/5ag9Mj13+lUBDt1H8uNt3hNU8ZhfHpOt7yz6a3WSZY/Gwcp3Ygef8LTH3CAtgxnuDWg6VtDRT5Oed10F0wrm6Vmafuu8fGoo47hJqTr8mc6TNWsEkJeUwWZHFKre6AWfCsNxakoDVPoasM/npEBOSQmdOet72Hbx+4VeFLnjqtye/J9Vuv7v5BiR1+fWkRwfe02BG5+9byXs+tQX0/qC0vds8V+9/VB+vdMOjTcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=THIevVahoQTQMIBih18toYgcQCOK19vQpjDWrJFlDLg=;
 b=ltEfwFC2M4g+Y+zMtBQaZPF4yE9tFqy55M4OzigR2SH0rMGb0eK9Kqg8RtiVhYicA+9SzImqXsgyAD/OvZMsO3H44u6Rb2Dyfgbw/MfEG97sbwehwQ8o0BsqAKIowNXXRsVvBYlKbFc51OHxUAOpQTnLeI9Kzd5X79NNJIpVcDY=
Received: from CO1PR10MB4705.namprd10.prod.outlook.com (2603:10b6:303:96::11)
 by SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.34; Tue, 27 Feb
 2024 00:48:02 +0000
Received: from CO1PR10MB4705.namprd10.prod.outlook.com
 ([fe80::de9b:77d0:6c34:db24]) by CO1PR10MB4705.namprd10.prod.outlook.com
 ([fe80::de9b:77d0:6c34:db24%4]) with mapi id 15.20.7316.035; Tue, 27 Feb 2024
 00:48:02 +0000
Message-ID: <e3da7191-d2c2-5c28-257e-7f52096c956e@oracle.com>
Date: Mon, 26 Feb 2024 19:47:55 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/2] How effective is numa_preferred_nid w.r.t. NUMA
 performance?
To: Peter Zijlstra <peterz@infradead.org>, Mel Gorman <mgorman@suse.de>,
        linux-kernel@vger.kernel.org
Cc: Konrad Wilk <konrad.wilk@oracle.com>, chris.hyser@oracle.com
References: <20231216001801.3015832-1-chris.hyser@oracle.com>
Content-Language: en-US
From: Chris Hyser <chris.hyser@oracle.com>
In-Reply-To: <20231216001801.3015832-1-chris.hyser@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1P222CA0025.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:2c7::30) To CO1PR10MB4705.namprd10.prod.outlook.com
 (2603:10b6:303:96::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4705:EE_|SJ0PR10MB4688:EE_
X-MS-Office365-Filtering-Correlation-Id: c9c70cd9-70d6-4308-a2ec-08dc372dc082
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	h+32Y/oTiSKewNXRz2oP8LtKkPAyaooqOCeqGSF2OwVDpRWh98kwEhsA0pVTc+TQjOGlxLezwrgeN4io+OeTH7VR7rcus3umoYMiDyhPl+veuIwTIZf1rDw8holSQ0ebIY6yZ+OwrCVOoMZKdIYwdKmxZ16lq/OLUvrUU90NBAkECj7woxXztpat5ugCz7CkZmAQKcyL5qSiEWWiyaOf072srVe2ccjUj1dMYkBywlvuzIsUDzd1KzSt065Md84KReThn3p2WQPtVJ68Vpov0u3+nxKbKInN09x8BKEAjAi6EDTjZVfx6gbawqzMEVuAJ9xWWEpVjqPlflmKeYCtzaZa55ndFTHXpef4wYQrclR9BwSZ0pkC4z5XPnGVJHPU/3L20eAEEtHZlo7+VSWzuT14aiJzaaP3O0/tahhA2P0bFgRs2LfPxIosLMhGYZclTUJmk7aelW2LekwC7irDSBZxjXTkv6Xsu5S6XOaK3n26f4eKu5dGAOaPchAsxWV+ZgI4Bj8RQi/+x/lV2Gj7F+mo9iphfk+RsMdch/VBG4fCuRd1cCAvyKgJ+n5EpDxfH3n6ZOZsJDQQYtQj/SnRS3GEcLdGy/ngrRRgqeHvkghLPuyoo6QuGCt57PraUV98
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4705.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?czZBeTY5UklZMEdYK0prR1M5WTZHQ3hVVU83cURmSGtsSXN4Zkl5YjV6SVpQ?=
 =?utf-8?B?NW1hYzU4czBYSXc2c1JJbTNMZ1B4dC93UmhUSjJqZy8wdG1vSnhscVlYNXpK?=
 =?utf-8?B?d3hMM0dkZUY2NFNWZmFSRFlzYStnWTZwTWUrU3BaMFp3OWRweTVoSzVOOWFD?=
 =?utf-8?B?Z2ZGWVNDNXQvL3p0S2p2TXEvNHlmNVovNVE4OUZUOG9Bczg3STFlS3gveEZn?=
 =?utf-8?B?NTNJNTM1NnB4bEVWTGtldnF0dFpLUWpZRFBYZkNnMHBmS0I5dnJveXhtRmZH?=
 =?utf-8?B?VmN0K0o4K0lIZTl3N0kzbWc1UGg3Sm1iYzRtaXVJYWkwWmZleExNcjRlWnpZ?=
 =?utf-8?B?VjU0SHphcGlTRkJGRkNrS3k0UEhUU2JDZ0VyWnZWNVdWVWhCYVErVW1aejBR?=
 =?utf-8?B?aDFXRW5CSWhZeVVKN0tzZ0YyeFNJMkErVDhJUjJUSkVuc0ZNaFNFS2JlNUt4?=
 =?utf-8?B?K0ZZc05aRXJrUWlYTCt3MlMyVisreWkzUThNb2gzL3lZMktLS1kyN0VnTWxT?=
 =?utf-8?B?NFZHcHpPU2RFV3BEdnhLTzBNaE85S0JJcjd3VHp6VDdoV1NDMjlSb1ZOdzU0?=
 =?utf-8?B?L3VyZUhvRVBMNC9TMS9jMWcwdEhzeHEzWnc0N3NmNmU0UkIwUFMwZUoweFhB?=
 =?utf-8?B?UThUakU4ZlNJNHZ0S0hkTEtlVWFRQVR4U3VUNVNoeTJkeGk3SUpEb3o0Q0Ry?=
 =?utf-8?B?RGZKNHZDN3hZbHRjeXBSK2huTTJoeGZiWC9adWVhZXQyMTNzOStNTHRGam5l?=
 =?utf-8?B?YnlTS003RHI2cmxjU244MU1EbVlBZ0dMRlhXNHNVc1ZvMjFDeXVRdnNnbTFw?=
 =?utf-8?B?K1Q4UHN5UWlwL05BVERQMTVhNUR3aDRNNWh5RXg4V3NIblE2eE1ZZW40TmRk?=
 =?utf-8?B?a0JvZVJTeUZERDhhVDZ1OHhSOUZ0bWthMlZPcDVmc3hyTXQrb2xPa0tTOXVI?=
 =?utf-8?B?ZXdDSktuRjNKYlRnVWtBd1FseFRvUnFRYkF2b2VRZUpuN2hpaXBTdGdSZnd2?=
 =?utf-8?B?QUdlL0VwVTBHM2FQcVhLVkFjai9MN0FEMTR0YlRUUXNwM0QzWTQ0MjhnTmM1?=
 =?utf-8?B?d1hzZWtwNFQ0MXhwZ2N4UGVSZjQ1RTZQSlNmZ3dMZWoyQUNpblBmZE56Ukpj?=
 =?utf-8?B?VDdMbXdTby9IYm45aEtPSUdDcVFIcDAvZ21aMmw5cUVGTWtweDB1MmZnVDZV?=
 =?utf-8?B?OW40eXgrMHk0blJaT2ZHS0h5R2Z2clF0dXVuSDYydElLY202YmJ0SnhJVERq?=
 =?utf-8?B?cFpIbVpWWTE0Z0NxUmhZcitZcytWOXpLNVJSRFd6WmV0YjJmUHlGZUV5ak95?=
 =?utf-8?B?c3QrZm93amFmaStlOTM2L3Vkc1hQTVh2RzNucjdoYlVSR1N5TlhnNkxqd0p2?=
 =?utf-8?B?S21zZms4ZEppdlFwYzF2S25wemU4c1Ztd2ZVbk9Hb0tJRnlXN2ZreGtGM1Vi?=
 =?utf-8?B?QVJjSzdGKzB3V2JjbEV4VGtuUVhRa3UxRmFmYmZVczJONTJqQmI0NjNqNWtX?=
 =?utf-8?B?WENCZUVUa21kN253WDNPWW8rYWNON3N6SXJWUjB6NjFpNGdKcjQ4Y1RnaHhn?=
 =?utf-8?B?eUhJYndyZUdDanNHZ3FaYURoaFNvb09zMnRMQVRpT1lrWHNZYjJTS3JnSmkw?=
 =?utf-8?B?SXJEUVBUYm54RE12NDhWZ1haZWhsbSthVGFPRHhDcDlMUlZNVGs3N1pRWHJP?=
 =?utf-8?B?ZVl1K1Q1LzBzU2thaDFpaUpSbTV0SkRrRnBWZ0JpN3RNMTlYRWNDR0s4U01h?=
 =?utf-8?B?TEQ4cU5VUkk4M1VDYXQ3YUtWRDh4TDJxY3F4UkdRY090Q1lGZ2ZlbWJ0ZjVp?=
 =?utf-8?B?emVraU5SWnUwYWQ5R3hib0NkMXlSSncxVkJNWmpBU05oTklMZzhLODh6NXp2?=
 =?utf-8?B?bGFNZWhjZFZzYU0wcUNPYS9VeldreUNPZFQzbDgvTVQxTTdUbXIxODBieTAy?=
 =?utf-8?B?dENwK1hRY2hwOVRBb2pvYkRGY3I2L21rNGVyYTZsVEtFdDQ3aWhEN3kzUTUw?=
 =?utf-8?B?TWpveFpWTEVEWml4VzlSbTVpUkxRdXdmcU92VllQa3RvLzdGS2YrNEhIYlBT?=
 =?utf-8?B?UkxFaXZ5OWhGTjAwVVUzTmtHdTRpS0MvN2FzRFJIRmd1K09ZSzB2eGRIaUVK?=
 =?utf-8?B?KzdJTUV3SVZNbkxUOU5QVDdYcWR5Vy8wdngreFlNZTFSVU95amd2bWxsSWox?=
 =?utf-8?B?Q0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	2po0g4PRrswtMVl1i7OkFBoSRLGD0IC3TGgVXoEpEhk8qBemFb5xky4XpMS2j+W+qIwoYHNeCrakzmyAMY1I3Z/Av2Pgc3MRZdQwnNl01He9Lh6FZ3DCqvINc7cZYKVPX8+Wxx77OezA/JMLn9yEAoDtUX0mO5Qv9mA0VKFWzX7gT+7Nwug2ZS3A+zedr9b63L771qi16gD204GeISAPl7UslDkYNpfm5UXHawDfxmiOLKRBrT9rC1zPS9tc9YuSqIB/1bzlLCU9W/BF4iYDThRHBJDrXfqBCElYO2nOu1g3VLj21Ub9Kfup6a3euUEVcc9uGskkyrS2XB81eMvMwsIbaKmI3Sp0ldb3i7AaR+ehHTNIfb214ebBYDt40ceP5aT31h/Jw/b8qz+7zFcT1DCEV19zy6I3SpHNx6+r1t+Sp9ghu26rUa6suf6LtITKmMBm4LGIshb4qVcIoGq4GbfFKQhpOVRXIMSZnHyTa4AfZndrx1JJ2Cl9UDmkp3KgTK76Ue9aVCrC8uj/TBFdbvKfllzfUFM64f+ycqT7DtNn6Sgktw4wumFnOzV5dr4Yl9DrZj7ivhSpsnyLyKp20xCjgGBbVP5Nnkpd8TvFqQQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9c70cd9-70d6-4308-a2ec-08dc372dc082
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4705.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 00:48:02.4241
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZH38opNwygx04p1GaBnFdmk3OUFtDI1MGrp/4oiu2Ai1Klc/E3ma5v4soJGK+eN73IfJqfkTeNNXt6+Leg9HVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4688
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_11,2024-02-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 phishscore=0
 spamscore=0 mlxlogscore=999 malwarescore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402270005
X-Proofpoint-ORIG-GUID: Czb7ztL1aaWKoRbGwk9H8VnmGtPZvJa0
X-Proofpoint-GUID: Czb7ztL1aaWKoRbGwk9H8VnmGtPZvJa0

Included is additional micro-benchmark data from an AMD 128 cpu machine
(EPYC 7551 processor) concerning the effectiveness of setting a task's
numa_preferred_nid with respect to improving the NUMA awareness of the
scheduler. The details of the test procedure are identical to that
described in the original RFC and while obviously this and the original
RFC are answers to a specific question asked by Peter, feedback on the
experimental setup as well as the data would be appreciated.

The original RFC can be found at:
[https://lore.kernel.org/lkml/20231216001801.3015832-1-chris.hyser@oracle.com/]

Key:
-----------------
NB   - auto-numa-balancing (0 - off, 1 - on)
PNID - the prctl() "forced" numa_preferred_nid, ie 'Preferred Node
             Affinity'.
            (given 8 nodes:  0, 1, 2, 3, 4, 5, 6, 7 and -1 for not_set)
Mem  - represents the Memory node when memory is bound, else 'F' floating,
            ie not set
CPU  - represents the CPUs of the node that the probe is hard-affined
            to, else 'F' floating, ie not set
Avg  - the average time of the probe's measurements in secs

NumSamples: 36
Load: 60
CPU_Model: AMD EPYC 7551 32-Core Processor
NUM_CPUS: 128
Migration Cost: 500000

       Avg     max     min     stdv        Test Parameters
-----------------------------------------------------------------
[00] 215.78  223.77  195.02   7.60  |  PNID: -1 NB: 0 Mem: 0 CPU 0
[01] 299.77  307.21  282.93   6.60  |  PNID: -1 NB: 0 Mem: 0 CPU 1
[02] 418.78  449.45  387.53  15.64  |  PNID: -1 NB: 0 Mem: 0 CPU F
[03] 301.27  311.84  280.22   8.98  |  PNID: -1 NB: 0 Mem: 1 CPU 0
[04] 213.60  221.36  190.10   6.53  |  PNID: -1 NB: 0 Mem: 1 CPU 1
[05] 396.37  418.58  376.10  10.15  |  PNID: -1 NB: 0 Mem: 1 CPU F
[06] 402.04  411.85  378.71   8.97  |  PNID: -1 NB: 0 Mem: F CPU 0
[07] 401.28  410.06  384.80   6.41  |  PNID: -1 NB: 0 Mem: F CPU 1
[08] 439.86  459.61  392.28  19.09  |  PNID: -1 NB: 0 Mem: F CPU F

[09] 214.81  225.35  199.34   5.38  |  PNID: -1 NB: 1 Mem: 0 CPU 0
[10] 299.15  314.84  274.00   8.18  |  PNID: -1 NB: 1 Mem: 0 CPU 1
[11] 395.70  425.22  340.33  21.54  |  PNID: -1 NB: 1 Mem: 0 CPU F
[12] 300.43  310.93  281.67   7.40  |  PNID: -1 NB: 1 Mem: 1 CPU 0
[13] 210.86  222.80  189.54   7.55  |  PNID: -1 NB: 1 Mem: 1 CPU 1
[14] 402.57  433.72  299.73  32.96  |  PNID: -1 NB: 1 Mem: 1 CPU F
[15] 390.04  410.10  370.63  10.72  |  PNID: -1 NB: 1 Mem: F CPU 0
[16] 393.32  418.43  370.52  10.71  |  PNID: -1 NB: 1 Mem: F CPU 1
[17] 370.07  424.58  255.16  43.26  |  PNID: -1 NB: 1 Mem: F CPU F

[18] 216.26  224.95  198.62   5.86  |  PNID:  0 NB: 1 Mem: 0 CPU 0
[19] 303.60  314.29  275.32   7.99  |  PNID:  0 NB: 1 Mem: 0 CPU 1
[20] 280.36  316.40  242.15  18.25  |  PNID:  0 NB: 1 Mem: 0 CPU F
[21] 301.17  315.03  283.77   8.07  |  PNID:  0 NB: 1 Mem: 1 CPU 0
[22] 209.34  218.63  187.69   9.11  |  PNID:  0 NB: 1 Mem: 1 CPU 1
[23] 342.34  369.42  311.99  12.79  |  PNID:  0 NB: 1 Mem: 1 CPU F
[24] 399.23  409.19  375.73   8.15  |  PNID:  0 NB: 1 Mem: F CPU 0
[25] 391.67  410.01  372.27  10.88  |  PNID:  0 NB: 1 Mem: F CPU 1
[26] 363.19  396.58  254.56  32.02  |  PNID:  0 NB: 1 Mem: F CPU F

[27] 215.29  224.59  193.76   8.16  |  PNID:  1 NB: 1 Mem: 0 CPU 0
[28] 300.19  312.95  280.26   9.32  |  PNID:  1 NB: 1 Mem: 0 CPU 1
[29] 340.97  362.79  323.94  10.69  |  PNID:  1 NB: 1 Mem: 0 CPU F
[30] 304.41  312.14  283.69   6.59  |  PNID:  1 NB: 1 Mem: 1 CPU 0
[31] 213.58  224.24  191.11   6.98  |  PNID:  1 NB: 1 Mem: 1 CPU 1
[32] 299.73  337.17  266.98  17.04  |  PNID:  1 NB: 1 Mem: 1 CPU F
[33] 395.56  411.33  359.70  12.24  |  PNID:  1 NB: 1 Mem: F CPU 0
[34] 398.52  409.42  377.33   7.28  |  PNID:  1 NB: 1 Mem: F CPU 1
[35] 355.64  377.61  279.13  26.71  |  PNID:  1 NB: 1 Mem: F CPU F

All data is present for completeness, however the analysis can be limited
to just comparing {00,01,02} (PNID=-1, NB=0), {09,10,11} (PNID=-1, NB=1)
and {18,19,20} (PNID=0, NB=1, mem=0, cpu=F).

{00,09,18} are all basically the same when memory and CPU are both
pinned to the same node as expected since neither PNID or NB should
affect scheduling in this case. We see basically the same pattern (values
being near equal) when memory and CPU are pinned in different nodes
{01,10,19}. The interesting analysis in terms of the original problem
(pinned RDMA buffers, tasks floating) is how NB and PNID affect the
case when memory is pinned and the CPU allowed to float. The base
value {02} (PNID=-1, NB=0) is quite a bit worse than when the CPU and
memory are pinned in different nodes. This is similar to the Intel case
where allowing the load balancer to load balance is worse than pinning
tasks and memory on different nodes and while this simply may be an
artifact of the micro benchmark, given that the benchmark is really just
a sum of a large number of access times by the task to memory, it is
representative of the NUMA awareness of scheduler/load-balancer.

We do see that enabling NB (with the default values) does provide some
help {11} versus {02} and that setting PNID to the node where the memory
is at does provide a significant benefit {20} 280.36 versus {11} 395.70
versus {02} 418.78. Unlike the prior Intel results, where PNID=0, NB=1,
mem=0, cpu=F was generally less than pinned on same node {20} 129.20
versus {00} 136.5, on the AMD platform we don't see nearly the same level
of improvement {20} 280.36 versus {00} 215.78.

This can be explained by the relatively small number of CPUs in a node
(16) and that said node contains two 8-CPU LLCs.

Analysis:

As mentioned in the RFC, the entire micro-benchmark can be traced and all
migrations of the benchmark task can be tabulated.  Obviously, a same-core
migration is also a same-llc migration which is also a same-node migration.
Cross-node migrations are however further broken into 'from node 0' and
'to node 0'.


     {00}            CPU: 0, Mem: 0, NB=0, PNID=-1
--------------------------------------------------------------------
     num_migrations_samecore : 1823 num_migrations_samecore : 1683
     num_migrations_same_llc : 3455 num_migrations_same_llc : 3277
     num_migrations_samenode : 914 num_migrations_samenode : 1016
     num_migrations_crossnode: 1 num_migrations_crossnode: 1
       num_migrations_to_0   : 1 num_migrations_to_0   : 1
       num_migrations_from_0 : 0 num_migrations_from_0 : 0
     num_migrations: 6193                  num_migrations: 5977

     {01}            CPU: 1, Mem: 0, NB=0, PNID=-1
---------------------------------------------------------------------
     num_migrations_samecore : 2453 num_migrations_samecore : 2579
     num_migrations_same_llc : 4693 num_migrations_same_llc : 4735
     num_migrations_samenode : 1429 num_migrations_samenode : 1466
     num_migrations_crossnode: 1 num_migrations_crossnode: 1
       num_migrations_to_0   : 0 num_migrations_to_0   : 0
       num_migrations_from_  : 1 num_migrations_from_0 : 1
     num_migrations: 8576                  num_migrations: 8781

In the two cases where both the task's CPU and the memory buffer is
pinned we do see no cross-node migrations (ignoring the first needed to get
on to the correct node in the first place which is due to the benchmark
starting the task in a different node). Why pinning cross-node results
in more migrations in general needs more investigation as this seems fairly
consistent.

     {02}            CPU: F, Mem: 0, NB=0, PNID=-1
---------------------------------------------------------------------
     num_migrations_samecore : 1620 num_migrations_samecore : 1744
     num_migrations_samecore : 1620 num_migrations_samecore : 1744
     num_migrations_same_llc : 3142 num_migrations_same_llc : 2818
     num_migrations_samenode : 853 num_migrations_samenode : 625
     num_migrations_crossnode: 6344 num_migrations_crossnode: 6778
       num_migrations_to_0   : 769 num_migrations_to_0   : 776
       num_migrations_from_0 : 769 num_migrations_from_0 : 777
     num_migrations: 11959                 num_migrations: 11965

     {11}            CPU: F, Mem: 0, NB=1, PNID=-1
---------------------------------------------------------------------
     num_migrations_samecore : 1966 num_migrations_samecore : 1963
     num_migrations_same_llc : 2803 num_migrations_same_llc : 3314
     num_migrations_samenode : 514 num_migrations_samenode : 721
     num_migrations_crossnode: 6833 num_migrations_crossnode: 6618
       num_migrations_to_0   : 818 num_migrations_to_0   : 630
       num_migrations_from_0 : 818 num_migrations_from_0 : 630
     num_migrations: 12116                 num_migrations: 12616

 From the data table, we see that {02} is slightly slower than {11} even
though there are more total migrations. Ultimately, what matters to the
total time is how much time the task spent running on node 0.

     {20}            CPU: F, Mem: 0, NB=1, PNID=0
---------------------------------------------------------------------
     num_migrations_samecore : 1706 num_migrations_samecore : 1663
     num_migrations_same_llc : 2185 num_migrations_same_llc : 2816
     num_migrations_samenode : 591 num_migrations_samenode : 980
     num_migrations_crossnode: 4621 num_migrations_crossnode: 4243
       num_migrations_to_0   : 480 num_migrations_to_0   : 419
       num_migrations_from_0 : 480 num_migrations_from_0 : 418
     num_migrations: 9103                  num_migrations: 9702

The trace results here are more representative of the observed performance
improvements. The cross-node migrations are significantly lower and the
number of migrations away from node 0 are much less.

In summary, the data (relevant copied below) shows that setting a task's
numa_preferred_nid results in a sizable improvement in completion times.

[00] 215.78  223.77  195.02   7.60  |  PNID: -1 NB: 0 Mem: 0 CPU 0
[01] 299.77  307.21  282.93   6.60  |  PNID: -1 NB: 0 Mem: 0 CPU 1
[02] 418.78  449.45  387.53  15.64  |  PNID: -1 NB: 0 Mem: 0 CPU F
[11] 395.70  425.22  340.33  21.54  |  PNID: -1 NB: 1 Mem: 0 CPU F
[20] 280.36  316.40  242.15  18.25  |  PNID:  0 NB: 1 Mem: 0 CPU F


