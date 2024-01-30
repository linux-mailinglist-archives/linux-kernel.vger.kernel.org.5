Return-Path: <linux-kernel+bounces-43858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A5384199E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 03:52:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A84102884F5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 02:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4509037160;
	Tue, 30 Jan 2024 02:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=illinois.edu header.i=@illinois.edu header.b="fvrSEtKI"
Received: from mx0b-00007101.pphosted.com (mx0b-00007101.pphosted.com [148.163.139.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B3836B1C;
	Tue, 30 Jan 2024 02:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706583119; cv=fail; b=CDWTWm64LIS5UxdZout57VWKPkCMOjEF/hRU1GhKpW1EWv+C/EyWapL3UXL5Hapjh+lqWbbpCk9FGEtY5xMzESv2cNUt84KFrdy4QRlgqfD6h1f/noCi+Hjn14DJbSTr2cIfS5ouQmG5ryk9BZKmq81lEVLwflkq6phHUfPT8X8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706583119; c=relaxed/simple;
	bh=zCj9syQHIjkt6RDhFFMu+u9jOia03VNSR6g8H8wn9DI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=r0ml2lJz+Bb1nFlt23rzgQ8I98iu6enHSmjr5K/u8y672msXk1EDu7SJ0iew/ooI7i/ij5wCcO2J2izUNEaSYTDkz9SXB2D/ZEEHG2Hz/HP2ZpFD2WlFpFtFr8m48ZzDMDVajaGuWxrqSSpXhghSlAx9unHppQkONpzvquRNScE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=illinois.edu; spf=pass smtp.mailfrom=illinois.edu; dkim=pass (2048-bit key) header.d=illinois.edu header.i=@illinois.edu header.b=fvrSEtKI; arc=fail smtp.client-ip=148.163.139.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=illinois.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=illinois.edu
Received: from pps.filterd (m0166260.ppops.net [127.0.0.1])
	by mx0b-00007101.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40TLLdD6030785;
	Tue, 30 Jan 2024 02:50:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=illinois.edu; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 mime-version; s=campusrelays;
 bh=pWzK9134IN6xzSZewc9I4JhW+EXbDP0PHDZ9Qti3xcs=;
 b=fvrSEtKI4am47lAGMwX9+NFRgd4ognonBnQSMU2ePeXqwU9+9+ummEDMB9oGOvuoKG6g
 d87UVDwA+t6jSafHcYzDyaO7T+ZjebsI+KPc1kora3NXM9zntYcu8UYo13q3nBfLIDz4
 jZqVFF5YLii3K4n5Ts0ClHogjR80efdvFqhW0rY+vtVWFWb/IiJRoT3+9NTt4Gt1WMVW
 uLQ94TqOEGWOlqXoxdkQOdidj6rA+IrYcR3Qymrp7Qp/3tXxCeIjIf2nxlSPMbPcARu4
 dB/6TSy2Lm2Mv+wsNFxeCaKxi7T5C8qGnuOn3lrZy05FRDkO6ZrCUsNHD3fK2WmWiKeZ SA== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by mx0b-00007101.pphosted.com (PPS) with ESMTPS id 3vxkv61xh4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 02:50:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eklK3pSNmJUJP1lBXFL8lThTN9Fht2umPzDyXzexemakDYwgmTjUdsGMiR2fV8T/k/zAmGZz6pcjOvynQwjjMRZzBKLyY5gy/WfigZgRhAk0H0u9XyMBBK36WXVmRhhy+qMszxFI5RVlwZq1MGeJrD8SF/yjAqay2GeFJeMsbLtA5p7u676FMcEvShDReTXWtwz+E8bgyXV/zSnwfCfJzmPQKRgVVsOSUTKk9nyKpWdEtDJZKnEm3RFGkkJEQZoKRWCED7QWtvuCSZV5cs9u6e106MAFlFzxPIaBFI9jI5hJcphLxIpkvP7r+lJ/KdmEbgiszEAEmRmQv3WPTgEQNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pWzK9134IN6xzSZewc9I4JhW+EXbDP0PHDZ9Qti3xcs=;
 b=EkbAZObKB9D97uhTzsQToFYgtMuNR9xqy32XuKIjdKmAZqFVjDpPhWFuDHmWuQPU+hHp+Vqysr2e8ESDJvNFiTmat7WixVR1JP4clCXpGHfsDbxxouJ1azHCeHK8SYDvpv/LizMf4I8T4pZx1jovS6Pjkq3CCgozRYGXrlf0TLNKnchtFOjvOdufSObFuY8zkkyb4Su8hJ6hoaoksnAnt9/a4taBeMwFTP+5PVZQFLK6V9gm08P2XNhXYxT9dur8VzDDvw6D0eHn3ylb4q4LLUKNxbJcjiLQWLHQ5Ho8AwJK/5Zg1z3uYXr4f6X1KGE5qE0LZHNF7Azeg81KAouxaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=illinois.edu; dmarc=pass action=none header.from=illinois.edu;
 dkim=pass header.d=illinois.edu; arc=none
Received: from DS0PR11MB7286.namprd11.prod.outlook.com (2603:10b6:8:13c::15)
 by BL1PR11MB5478.namprd11.prod.outlook.com (2603:10b6:208:31d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Tue, 30 Jan
 2024 02:50:41 +0000
Received: from DS0PR11MB7286.namprd11.prod.outlook.com
 ([fe80::df27:adc7:bb62:4690]) by DS0PR11MB7286.namprd11.prod.outlook.com
 ([fe80::df27:adc7:bb62:4690%4]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 02:50:40 +0000
Message-ID: <15690bf4-a803-4ce0-87bc-ec21727fa38e@illinois.edu>
Date: Mon, 29 Jan 2024 20:50:39 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] x86/kprobes: Prohibit kprobing on INT and UD
Content-Language: en-US
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240127044124.57594-1-jinghao7@illinois.edu>
 <20240127044124.57594-2-jinghao7@illinois.edu>
 <20240128101912.5ad6717347bd66089ecea03a@kernel.org>
 <8c29d66d-b17d-4185-988c-de078566d0da@illinois.edu>
 <20240130104414.4548b70ada33ea3180047423@kernel.org>
From: Jinghao Jia <jinghao7@illinois.edu>
Autocrypt: addr=jinghao7@illinois.edu; keydata=
 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
In-Reply-To: <20240130104414.4548b70ada33ea3180047423@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------6dN03QmBUgWHRy6Jsm3cFtp6"
X-ClientProxiedBy: CH0PR03CA0102.namprd03.prod.outlook.com
 (2603:10b6:610:cd::17) To DS0PR11MB7286.namprd11.prod.outlook.com
 (2603:10b6:8:13c::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7286:EE_|BL1PR11MB5478:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e5cb650-cff0-45cd-dd3f-08dc213e3ef2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	RVvRjCXib1g316s7UERu2j64MgWBKRdROdbHb09LFqRVkqoYt7ZtkgT/+bN9WCzYZYyHUALI9rVfzayLsK2/3WCwLKrZ3OpqH45DvqfE+IMnbHJPk7reYLP8P3PKeF9GsKA8gyzCWxZ+ne4xcpG9HKu2hvg+qLJwdOqJ9I36pLUlIyBs+6ea7i1B7QAL+LPl1uwA0U5fquWwUrA0h5enOLyYnMara3BRKQIPNxClYoO07RC88u/M9mzAFW7jxeH2INfLt2BeIG8lqaJDoLg6ZxFquFgrOsRMhLoCqU7G88zZnxy63VFja5uTQ2clBqOVb1j57K4Sbtg4OyckRssOF+AcL6NTY1+n7R2sYeOJ8/siInAG7boWuI+pKQ5wfXtLKL7acsvWzppjp2LIjjHx3oN/vu9PSLrm1GrdlBlqQmdMtrmGMw3Iy5VzwtWJIE2rImYSONVhcLsovAOgM1UOYAvzEW52axA3gia+diMjm8yye6A1Qhbzdi0OwSEaP0lhTIUQH3S/fNyir+tQtGoZEVbxfifNVsHs9wff21r/gMW8Xg7o+MvuDpJjxV/Jyyk4GYDYJ5svPt2a+FsQK4YQVl0Rh3Bc+UIGCU5SrxE8nXGz6Z/HaSlUOjA6iWG0ev5PzxC3p+/ICaOghWrnQ6gYIg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7286.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(396003)(346002)(376002)(136003)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(75432002)(316002)(31696002)(66556008)(83380400001)(36756003)(53546011)(54906003)(66946007)(6916009)(86362001)(6506007)(786003)(8676002)(8936002)(66476007)(33964004)(6486002)(478600001)(4326008)(2906002)(21480400003)(7416002)(5660300002)(6512007)(2616005)(235185007)(41300700001)(38100700002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MWFqYndnb25aLysvY05BampJU1BoRkZMVHdaeXFBc3UzRzdMa3htTUNVR0hj?=
 =?utf-8?B?d2lkM2hNd0YvdFZoemNyY2dTdXhFWDAwbXR1K21VOTcxd2kvRVRSZHJNUWVs?=
 =?utf-8?B?dkRCS1o4dWJYUHExMFRUd0Nrb0JyMXIvNEhiMkNsUERjZVk0Wk80N0RZaFFu?=
 =?utf-8?B?RUZVeEtZY2M1MEdyMTdxLzFXRnFRYnhIdmZBUmhDTVFEU2JGb2JvMnNHbm8z?=
 =?utf-8?B?VXRzd1JOUjVTc0t2aTNBUWpqdVR5TzFwd01VOVgreHlMT29MODhRSWltL1oz?=
 =?utf-8?B?aTR2WDhtVzI4ekdqTjlOL3FCWi9tRDlsVTJyaFd1YjI1NWJKUkM5NWkyU1pW?=
 =?utf-8?B?Q0dXb2d6bUQvMytJbUY3Y2IrUVNxN2VnU1pTSS9BS1dWUXI1djd6TnF4ajBj?=
 =?utf-8?B?QTRwcktHUDlmTllqa1VpdUY3Vi9YMDJmdTVxRzlMVnVZdWJKSWVteDl4bTNT?=
 =?utf-8?B?dUlncHR0T0JzaFhrd0I0b3VncXlQN2Zqc0ZoTHlnTlhvcDc0SXJqWWwzRXVO?=
 =?utf-8?B?YkhFeG9OSStMZytGa09wNDFPemRETHI3RFNwZGFZSk02ZnVjcTM1NjV0TEFv?=
 =?utf-8?B?ditQeUQzalIwVG03UEFSWnZUeG5RWCtpbG1NZU1LQXR3eTZxc1E4R3d2U3hI?=
 =?utf-8?B?UHpCbmVhbnpVcU1PVlhBWlZ0NkRaZVdqemhsZ3NVUjRyTHU5aUVzQjN3OC9V?=
 =?utf-8?B?eVB2WDMxTnNEUW1xZTBqN1UyUktrLy9WWERYNW1hWW9vYlpXUEJycFA4YmdE?=
 =?utf-8?B?ckVKYU1XRUplK3VRbWJTais3TmM4anNTbkZpQktOUHV0TUFRQjY4Z3pRc2JX?=
 =?utf-8?B?TDhtYS9neEJNdFZIQVBHMlpYUExnRmViTzNXL1ZqYUNxN3M5UVE1U0RLTTlW?=
 =?utf-8?B?M1pXL2NVSnZubklvYmRYZGNOOXVMN2Zud2tBVVpGenhHc0ducElQSDRVMDB1?=
 =?utf-8?B?RWdSekhha1A0Wms3S3lDMmZXUFZxMmlxVEMxWmZ5SHpUNGZSVUhWSDlSQkNy?=
 =?utf-8?B?TEZLRy9QeXZvM0hrdFlkT2N6V3FHdnNNUkcyVk1PZ3U0NGdDcC95eXNibm1m?=
 =?utf-8?B?M1huVlZhZHdBT0FJYmR5Qmdoem4ycGdZcWdLbnBVb2hCYXBHcEptTjRzZTdo?=
 =?utf-8?B?UzZFT1pSb1FIOG5vbXE5TTBTWjdRSEdRWnNveUJzcVVBTHJQTXhKYUlMUDVm?=
 =?utf-8?B?SUZTbFAvbk4vVHhMVjUzT0l6S1pOVWdBZmJaWEVXaTI5R3ByK3lhRnd0ZHdH?=
 =?utf-8?B?ZTY3M1NleURVKzJzbnRSNTZqQ1o5TEVPdnB0UUNXcVpYNFJHNjRmaEhuUGp0?=
 =?utf-8?B?UjRPV1NXNVBEOVlOejNyNE9TWDB1ek1hN1NJM1YvNlh3VE13ZkFIdVlnNmRh?=
 =?utf-8?B?Tm42YTN2eHNuRzQrcmxOdU90Y1I4V0R4Wnl2TFdwZGp5ZncvV1NKUEozL1RL?=
 =?utf-8?B?S2RmM0VvZjUwZkJNM3MwalBKQmp6aFVXY1lHU1JiYjBWMFRUT1MrZnlSUk9G?=
 =?utf-8?B?eXE5TzhCT0dHQ1JIQ2ZHeU51TWJkaHpxaTl3R3p1SFZiVmsrbGYwYWhnUDR3?=
 =?utf-8?B?aU9tY1grK2tHTytiYzNDVFB2YWtucFVVZ2VWVG1LMUVjNy9HKzNETmRRUUp1?=
 =?utf-8?B?V0F6eDZCcm5GQlZBcGF4YTd0RjhSM2JmOGNMT0xFeE4vMndxeWJDN2FzQWhu?=
 =?utf-8?B?YzNNUUt3OXhma21MN0NzMTFyWW9Mdiswb253ejJlYkhHMHBDenVhRHZpd2Jy?=
 =?utf-8?B?RWF1TWljS0dsQnJQc2oyR0tqZU9HbEprMmlyTWJBQUM4THQzYXN3V1d6K3Qr?=
 =?utf-8?B?Z1VjK2J2bUp5UTlGVS9hcWc1SndES242Y2dmSnh0QzRTUTZnckNaeGxaa1gx?=
 =?utf-8?B?WHRrQVdFMzIzdmoxUDNBVVZtNysxYkpzU1RncFZzSFhNZzIxQkIrOWZiNWgv?=
 =?utf-8?B?b2UwQ3NTaXIvVjFFNXFQTHo0QnNRTHliZkhXNTd3ak1GbEFKbk00eDE5SUZW?=
 =?utf-8?B?Q2d1aDk5Wk5CZWwxRXgrN1Jkei9SM2JEQkV6ZG8yS2JmOEFtNllnUUg5Y1hL?=
 =?utf-8?B?cTRQalZ4LzB5MEJQMUt4UlR0WCtuWlBWVHdXWGVkaFJnTVptUjdGK2xEU0cy?=
 =?utf-8?B?eDhZeWVBNTVPL01rRjk0SmRrOFViTkp4SllXWXNaZGNDK0lTOFJPNEc0ZkZw?=
 =?utf-8?Q?AwBD4GbWBJIDxMFZXEkr6QH+xGgCdqF1eMSAJddnJBjS?=
X-OriginatorOrg: illinois.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e5cb650-cff0-45cd-dd3f-08dc213e3ef2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7286.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 02:50:40.8966
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 44467e6f-462c-4ea2-823f-7800de5434e3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f5V6Fw8IG6F2d3YGBK3WEepJnG7Qdf59H/GS+/i2iIIQjLPQ2mPz+VfGuRyKfffzYoikU3wlA1PQjYDKQuoWQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5478
X-Proofpoint-ORIG-GUID: qHJRPKkQW8YxbUJrFRN0qOEu27BM51ma
X-Proofpoint-GUID: qHJRPKkQW8YxbUJrFRN0qOEu27BM51ma
X-Spam-Details: rule=cautious_plus_nq_notspam policy=cautious_plus_nq score=0 bulkscore=0
 mlxscore=0 malwarescore=0 suspectscore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 spamscore=0
 mlxlogscore=771 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311290000 definitions=main-2401300018
X-Spam-Score: 0
X-Spam-OrigSender: jinghao7@illinois.edu
X-Spam-Bar: 

--------------6dN03QmBUgWHRy6Jsm3cFtp6
Content-Type: multipart/mixed; boundary="------------iMeSB0tXMpbIt5T8u72D0UKG";
 protected-headers="v1"
From: Jinghao Jia <jinghao7@illinois.edu>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Peter Zijlstra <peterz@infradead.org>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-ID: <15690bf4-a803-4ce0-87bc-ec21727fa38e@illinois.edu>
Subject: Re: [RFC PATCH 1/2] x86/kprobes: Prohibit kprobing on INT and UD
References: <20240127044124.57594-1-jinghao7@illinois.edu>
 <20240127044124.57594-2-jinghao7@illinois.edu>
 <20240128101912.5ad6717347bd66089ecea03a@kernel.org>
 <8c29d66d-b17d-4185-988c-de078566d0da@illinois.edu>
 <20240130104414.4548b70ada33ea3180047423@kernel.org>
In-Reply-To: <20240130104414.4548b70ada33ea3180047423@kernel.org>

--------------iMeSB0tXMpbIt5T8u72D0UKG
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 1/29/24 19:44, Masami Hiramatsu (Google) wrote:
> On Sun, 28 Jan 2024 15:25:59 -0600
> Jinghao Jia <jinghao7@illinois.edu> wrote:
>=20
>>>>  /* Check if paddr is at an instruction boundary */
>>>>  static int can_probe(unsigned long paddr)
>>>>  {
>>>> @@ -294,6 +310,16 @@ static int can_probe(unsigned long paddr)
>>>>  #endif
>>>>  		addr +=3D insn.length;
>>>>  	}
>>>> +	__addr =3D recover_probed_instruction(buf, addr);
>>>> +	if (!__addr)
>>>> +		return 0;
>>>> +
>>>> +	if (insn_decode_kernel(&insn, (void *)__addr) < 0)
>>>> +		return 0;
>>>> +
>>>> +	if (is_exception_insn(&insn))
>>>> +		return 0;
>>>> +
>>>
>>> Please don't put this outside of decoding loop. You should put these =
in
>>> the loop which decodes the instruction from the beginning of the func=
tion.
>>> Since the x86 instrcution is variable length, can_probe() needs to ch=
eck
>>> whether that the address is instruction boundary and decodable.
>>>
>>> Thank you,
>>
>> If my understanding is correct then this is trying to decode the kprob=
e
>> target instruction, given that it is after the main decoding loop.  He=
re I
>> hoisted the decoding logic out of the if(IS_ENABLED(CONFIG_CFI_CLANG))=

>> block so that we do not need to decode the same instruction twice.  I =
left
>> the main decoding loop unchanged so it is still decoding the function =
from
>> the start and should handle instruction boundaries. Are there any cave=
ats
>> that I missed?
>=20
> Ah, sorry I misread the patch. You're correct!
> This is a good place to do that.
>=20
> But hmm, I think we should add another patch to check the addr =3D=3D p=
addr
> soon after the loop so that we will avoid decoding.
>=20
> Thank you,
>=20

Yes, that makes sense to me. At the same time, I'm also thinking about
changing the return type of can_probe() to bool, since we are just using
int as bool in this context.

--Jinghao

>>
>> --Jinghao
>>
>>>
>>>>  	if (IS_ENABLED(CONFIG_CFI_CLANG)) {
>>>>  		/*
>>>>  		 * The compiler generates the following instruction sequence
>>>> @@ -308,13 +334,6 @@ static int can_probe(unsigned long paddr)
>>>>  		 * Also, these movl and addl are used for showing expected
>>>>  		 * type. So those must not be touched.
>>>>  		 */
>>>> -		__addr =3D recover_probed_instruction(buf, addr);
>>>> -		if (!__addr)
>>>> -			return 0;
>>>> -
>>>> -		if (insn_decode_kernel(&insn, (void *)__addr) < 0)
>>>> -			return 0;
>>>> -
>>>>  		if (insn.opcode.value =3D=3D 0xBA)
>>>>  			offset =3D 12;
>>>>  		else if (insn.opcode.value =3D=3D 0x3)
>>>> --=20
>>>> 2.43.0
>>>>
>>>
>>>
>=20
>=20

--------------iMeSB0tXMpbIt5T8u72D0UKG--

--------------6dN03QmBUgWHRy6Jsm3cFtp6
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEE2/ZzTtJDFIshN/BBL9huahcPNUYFAmW4Y/8FAwAAAAAACgkQL9huahcPNUbl
SBAAz18r3RA6CNu/qchTOuyX5Up/LCjJACdfH3UCIZfbsLn0eeXMGLmJjYA9rJhFlMtDE096fWpz
ZwCDmEL5cMkGttfcs7jC/daVpeuJZSF5sy5Fiw7qoZ4YvNiyyWDItF778RYWu6XrrwECX4l3hBDI
cpuFp5hXZp+qM5e0BzfyDTHdZ/a/oaGjzLfwI46YsuWd1NdxIjBgV8I2jsMoIcXoQThdIpfm6x/U
jwDSaAXfyko+4V12Gty4HzlHAb3uvsa9VS7D2G5a6uni0WJV91IId5P+VcKUbYIv+56i0+jmh6kB
BG8Wkm+Rw7OmpBbJknazIbq2LqXWLKxhCOnU4m6lxiw+cdu4gKiC8tMNJq8LEsrSfJDuvb82r225
iXlD6HkPhFr0YYlgC6u09V8a8XL0kYMWadQaD76xXEYCdJFJwq0ESBoF3m94bNuVc45bposHnfkw
ao5iw8Oo6TFaXR2fJo7/Ig4Rgu+xbDENIgoEPYgZJAYp4m2K6JA9f4rUi104elXZBBDgtpqICc54
/5VmvfukjCF/Z6fky9hYbxpzglkCBHF2wQHQ3g/V7v5RQFB3GcqxxTkEAp3bhyX09MrLK4Cs1xhp
X0ZXHX6fzzgfXvFkMbGhN2Z0wF3Lfe+1KqLFOWRQVahoZw3rUZWuGuobzZtQ4/plT+u2CpSc+YW5
F0g=
=ix0z
-----END PGP SIGNATURE-----

--------------6dN03QmBUgWHRy6Jsm3cFtp6--

