Return-Path: <linux-kernel+bounces-22836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A289D82A3C6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 23:06:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 173171F24AFF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 22:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA184F88B;
	Wed, 10 Jan 2024 22:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b="Fvg13xl2"
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2099.outbound.protection.outlook.com [40.107.14.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83EA64F882
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 22:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l9/PKv5XJ780gRwoa32wKbisdpF8fPJGriBWqtYaPjAT+Wbey0TUwKDf2YO+OPesiVJisu0PEXaOQNy95ICjiGDXYvqvrzlEzpACRbGPo7EO09vN+rMBXp5QD03D4xWO4TCPvs36/6fu57rEZi9m+t8EuF8Hldiinq74xSW2Fkk2Vp96dh9HIffi5MOTT6ALvLPFuW0AXCWrU0LyG6/NFXeij48950gz/EsH/VWE7w9u2v4I700qvpRlaEtqQOjjLwj/tox6P67EH3CDaLnznsx1MY3fWs1hWWOG4Szw5WVd0yBNYD6UlknrdZ9cqGRs6XBIvB4M7SOP3F9y1jusSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T4AoLuEqLmtCOSlUG0eF+IdyCKJt+LQVgnf2JnnmZ+w=;
 b=n+DOzdtTzpfZgOwvhtdgaRLTg1RZqhSOcgG0y27n4WPsOBrFL/YzWjJlfxbaHdjaYyzAOHZqe948fSyNxtpjbAepNrC5nk45EW2by61NtHLkV7FEa1QW1aCVuJFx21NXUsXXsDZIMQfQxxDiIK/+/AkHuK60wCyKMDk5lDi67vLnVIKonkyK+7HkPiylQyAOmkjh5it6TQ9ebcIBxw+BsA0kHwvmWc8Rxi0/6ci5+cVuaezikbZWqtXoshg5aXAU5OfZt9FtUqCLrh307ynGKxJKF3IOjFgvuwbnuLTeT8m3SXhtJivRtlpbQGZcbXNKWC/XGEbZwVqi+pOLYq46Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T4AoLuEqLmtCOSlUG0eF+IdyCKJt+LQVgnf2JnnmZ+w=;
 b=Fvg13xl2gLg+FQSR7XOSmNRhgpW9BybhTai96xCnsOcAlfl4GNXJ/ax2vxuSp5n4X04rtAQmToQkwfoBp4LUDuuYAXsPLqOBfaYlOIF4v8ToOZfd7rkX+05tZtExCzgWAbCko8MMRgj6fOjcLFymgJBpssC3HKVmxhScl+suDl4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by AS2PR10MB7478.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:592::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Wed, 10 Jan
 2024 22:06:25 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f059:23ad:b039:15de]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f059:23ad:b039:15de%7]) with mapi id 15.20.7159.020; Wed, 10 Jan 2024
 22:06:25 +0000
Message-ID: <f5ded466-cbe1-4a46-b042-1c65839c9e02@prevas.dk>
Date: Wed, 10 Jan 2024 23:06:22 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] workqueue.c: Increase workqueue name length
Content-Language: en-US, da
To: Rafael Aquini <aquini@redhat.com>
Cc: Audra Mitchell <audra@redhat.com>, linux-kernel@vger.kernel.org,
 tj@kernel.org, jiangshanlai@gmail.com, hirokazu.yamauchi.hk@hitachi.com,
 ddouwsma@redhat.com, loberman@redhat.com, raquini@redhat.com
References: <20231215193954.1785069-1-audra@redhat.com>
 <20240110202959.249296-1-audra@redhat.com>
 <2f0efed5-f9f3-4a5c-9fd4-a4837cada298@prevas.dk>
 <ZZ8RtfKCmOQqj5KC@optiplex-fbsd>
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
In-Reply-To: <ZZ8RtfKCmOQqj5KC@optiplex-fbsd>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0027.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::34) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|AS2PR10MB7478:EE_
X-MS-Office365-Filtering-Correlation-Id: cfcacc7b-f8c9-4bc4-c37f-08dc12286331
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7dxs3xygXDYh9dI6yCIUIdpbkzOjJz/sM2aUDIAGn9xQrjjmbxRQCt3Jtp/DW2M/aDKZezIoFKXrxyBZRoC4n3QKZArUusNVijTZH++XTSXyDyFgrNqPNlHtHBVB0QZ7YaKcQ0IoZhLmckjYYy/TzRZ3BUjHOdm5PYCPxMT22ua775LH79Wb4tHScfGqtoJ9W89LZpOYPxHEGUjEPpyd9jpx1EMruP9HXIKYLwXBds+Frhw5icZ6SyrE4C6CIHdrE2Wl+yaDAbXTzY+4WDREhmE6l1R64OfRXZG7Rl1aXCD2jZF2T3RXJWF/UpUHjcHd/r7VnMqpNion/uXX3y4+NEhrShw+mnVhF5uPhyO32sehQRRjBo+1q8U8ofqR8FtRRfjw2z+8Jo28BVM0pBXzLsoUKlrrPBMrOX5t/4BSFVpMNqCN3/2eXrW/wkps7yB176zAmDe7Tj6VNXio3W3lWT6nr69hOPR9NM3o+PXVncVfgklBenA1j/iqnjMsch2dbEjAqP2Pelbo/GJUVMAHy0x6SUjKId0WwS61ydpi7N/Lw7NXnFQiWq/LqEExnsDNF4I8lt/yjtzx9P9mhwmZLEzUphuEMQj4vfS0YevYQWS+DdK+nRZ+QwG58XLvEyRT4T8hqkMY94f8QLEuK6OAtQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(376002)(136003)(396003)(366004)(346002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(6512007)(478600001)(8936002)(8976002)(6916009)(6666004)(8676002)(66556008)(316002)(66946007)(66476007)(6486002)(6506007)(26005)(83380400001)(2616005)(2906002)(5660300002)(4326008)(44832011)(41300700001)(36756003)(38100700002)(31696002)(86362001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N0dnWXRmV3RZeVZrMlFPOE5VbnBheTdFSFFocjNmMENwTnNXcmVkc3dNQUNw?=
 =?utf-8?B?bWs4ZzZzTDVCQzJ3MmdjTmJodlJUenJXWjM0NHY2N2lMM1hjeGNaQkFlWTV4?=
 =?utf-8?B?VDNNUFNkWThIZlVYczZIbkovVGZ0WHBERTZKdkhTWXZVdk5YM3FyTUI0d0ho?=
 =?utf-8?B?V1Y1ZjBkK1RFdEVrK0NlM2NtM3Q0SG1Ed1UvQTY2c3BtY2pwemI3RlR2Z0N3?=
 =?utf-8?B?U3FONHpLZkRJb3VRNnRxMmRmRENic2tYK3VoaWhRQ0ZWVVdOa2ZVZU41QnZX?=
 =?utf-8?B?dFk1bHJqTnhyNEwwZlNzOVpBN3J3Y2Zrbzg0VkY3MnJicWJqMDhQMDZtL3Ez?=
 =?utf-8?B?Rmt0ZlBXU0hDUDFOcjcvQ3kyRUNVVzIxTEkvUUtHSDhxcDIwcUFQRWRFVHpr?=
 =?utf-8?B?dGVGZzcxcE5YUlBFcmJYMFlNNmRZbDhBeTl4aTh2eWc0VlZ2eUxZSFd6eDVQ?=
 =?utf-8?B?ZGFIdFBkZVVQZXNYUTY4aXdGclEydkw4WFMrbjdKUHhHZ2Z0MTY4MTNuQi9Q?=
 =?utf-8?B?NG9EUHJPNjJxMWJ2M0p6SWpheDl4VjFMR1hSWHZqMmVEMk4vVUI5NlVPV0RW?=
 =?utf-8?B?NzAyV1piUDhaQ3lKWkhLSi9kQ09VL1dBaVZMU3VhVXB2QW5yUExJRjJkZU0w?=
 =?utf-8?B?MFhUVHlZVm1sbmh4Wmh4dmEvVkozQjk4SWFlNVNrUHVEZXVianAwbnlKQlBx?=
 =?utf-8?B?VmdCRmVvTFVyRHN6Rjl4bjkzVzVuSkkxRmRnNXVzelRyTHRnVm1rS3VFM2Vi?=
 =?utf-8?B?dmhUQi9pV2d5NWtXc2MySzd4cEgvbXZ5RHRXVUcvM1NqNHh4U0VKU09KQjRj?=
 =?utf-8?B?MXBhYkM4S0t3QkdFREZJd3BSMytaelVmaWNrR0hyMkNXeG8zNW1Dc1NabXBl?=
 =?utf-8?B?K1p2Y0ljVlcxTS90c005SVBVNWdwM0M1VE9tUm1rVkNJR1hManBaNGdLNjJT?=
 =?utf-8?B?QktqZ2hIVmxIc1N5TGJVQUgwVnA0RkRrTnNrb0tYd2VHRTRiK2dDZkhJck9U?=
 =?utf-8?B?QWxvNkJLWWsya0ZMZHl4ZFVJNVJWTzFRZHNsSkl6b0RHaTNoRVJ6ZnozdFdt?=
 =?utf-8?B?ZEpWeW5wdTk3bVhIaXhZUGhCRTZLaENpaXJQUHVpQ01BSmcrbXlTMXhYMThQ?=
 =?utf-8?B?OTNYazlRZzljTVpGZjJKSXl4MlhkSi9PQm00RkdCKytvQzBLTkl4UStGTWhS?=
 =?utf-8?B?QldNOTFFanJDbkVuSEtpOEFVV1RrSHdmUHBVYkJUOWtJN1grdmlSZjA1aVRn?=
 =?utf-8?B?WWpGbVUvbkcrMElGNERScEVKWE4vTi8ySEEvYXRuNHFHRndpbG05T2ZIaERj?=
 =?utf-8?B?eGwxY0k2Y1NtakgxTDV1QnNvc2YwSDBZNWptVG1SQ2tYd0hTSFRKVm1SWUVS?=
 =?utf-8?B?UUV2NVkxaUF5RlJqdEdRTXNBOGJWUzJJWmlhckt2TzJMbS9vRjR1Rms0Umx5?=
 =?utf-8?B?UGlXQ3NGSkJSMGlMT2FOWjNTYXJ4MFFQWDlsTHR0RmdvTFU3alkydVloeGdV?=
 =?utf-8?B?NDFTaXJNMFZNQXFVNWN5T1RqRFVuQlNOUTlTR1U4YVAxTlhsNmRycUZ2NTVx?=
 =?utf-8?B?YzRRMFNFWFN4TEJ6c0R4bW82L0ZIY3RnWmtDenAyTHh6eEVldFRPMy9WVXcv?=
 =?utf-8?B?WWgvcG9LcFFabkRTNHl2VGRoN2lGOUZZNHJIelh1aG15d1BhWHRsMFNiNXNS?=
 =?utf-8?B?UTl3WGJNc2NlOHQyZld5RFhLZGc3ZStaT0dyL2Zldk1ObisxUWtXRjZVdkFq?=
 =?utf-8?B?YTZuVlRHbU5zc2lJMHI3Z0lUcThrM0cxL3o5QUJDY3ZkZTczTGVUSlhUVTFV?=
 =?utf-8?B?eVFZSWU3REdrY2NXamJBc2ZYeWpDMnNiZDFCZDFHNTJLcUE1Z0l6T2ZKeUVp?=
 =?utf-8?B?MmxJck1tdVEwTitmSlJpNVpJaWFBSm53dnN5Zlc2MWtHMTFNUm5PSXlvQjY2?=
 =?utf-8?B?T1NIZm1jdUZiUXAyaE42cWpneVFrc0lhdFZOdWpQd3lJOVNlemJ4dFJ6VEZ4?=
 =?utf-8?B?SXIzb20wL2pLUjJEVjk2a0QzWUJyYUk0enFLa2tjdTVzMmlKL3dIL1o5NzdZ?=
 =?utf-8?B?THFESzdWNHJibk1tSzhFNEdNWHpnY3dhVGhuVzdMZDNxNjhCajFDbzQveXdk?=
 =?utf-8?B?NFN5VkxXb3o3OEtKYThPdk1OTnRvS2ZZNTBURG40bVBlOWtUUTVuZm9PbU80?=
 =?utf-8?B?T1E9PQ==?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: cfcacc7b-f8c9-4bc4-c37f-08dc12286331
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 22:06:25.3085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qkxq9S65SgepqCUtgc4KnnTV53vhp7Gvqs+MPSE709LLa6bk3ojr69aZ3E0zDMrMLQPo4eItd12yiJtqjxwNBRod5ES+Gi2tWWhOOTHC4m8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7478

On 10/01/2024 22.52, Rafael Aquini wrote:
> On Wed, Jan 10, 2024 at 09:47:56PM +0100, Rasmus Villemoes wrote:
>> On 10/01/2024 21.29, Audra Mitchell wrote:
>>
>>> @@ -4663,9 +4663,10 @@ struct workqueue_struct *alloc_workqueue(const char *fmt,
>>>  					 unsigned int flags,
>>>  					 int max_active, ...)
>>>  {
>>> -	va_list args;
>>> +	va_list args, args_copy;
>>>  	struct workqueue_struct *wq;
>>>  	struct pool_workqueue *pwq;
>>> +	int len;
>>>  
>>>  	/*
>>>  	 * Unbound && max_active == 1 used to imply ordered, which is no longer
>>> @@ -4692,6 +4693,13 @@ struct workqueue_struct *alloc_workqueue(const char *fmt,
>>>  	}
>>>  
>>>  	va_start(args, max_active);
>>> +	va_copy(args_copy, args);
>>> +	len = vsnprintf(NULL, 0, fmt, args_copy);
>>> +	WARN(len > WQ_NAME_LEN,
>>> +		"workqueue: wq->name too long (%d). Truncated to WQ_NAME_LEN (%d)\n",
>>> +		len, WQ_NAME_LEN);
>>> +
>>> +	va_end(args_copy);
>>>  	vsnprintf(wq->name, sizeof(wq->name), fmt, args);
>>
>> Eh, why not just _not_ throw away the return value from the existing
>> vsnprintf() and do "len >= sizeof(wq->name)" to know if truncation
>> happened? There's really no need need to do vsnprintf() twice. (And yes,
>> you want >=, not >).
>>
> 
> The extra vsnprintf call is required because the return of the existing 
> vsnprintf() is going to be already capped by sizeof(wq->name).

No, it is not. vsnprintf() returns the length of the would-be-created
string if the buffer was big enough. That is independent of whether one
does a dummy NULL,0 call or just calls it with a real, but possibly too
small, buffer.

This is true for userspace (as required by posix) as well as the kernel
implementation of vsnprintf(). What makes you think otherwise?

The kernel _also_ happens to have a non-standardized function called
vscnprintf (note the c) which returns the possibly-truncated result. But
that's irrelevant here.

>> Oh, and definitely not WARN,  pr_warn() or pr_warn_once() please.
>>
> 
> Then you lose the ability to figure out what was trying to create the
> wq with the inflated name. Also, the _once variants don't seem to do
> good here, because alloc_workqueue() can be called by different 
> drivers.

I assume that whatever creates the wq will do so on every boot, and the
name is most likely some fixed thing. So you're essentially setting up
some configurations to do a WARN on every single boot, not to mention
that for some machines that implies a panic... It really is not
something that warrants a WARN.

As for figuring out what caused that too-long name, well, I'd hope that
the 31 meaningful bytes that did get produced would provide a
sufficiently good hint.

Rasmus


