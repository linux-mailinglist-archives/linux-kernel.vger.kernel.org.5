Return-Path: <linux-kernel+bounces-7333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61FB881A5DE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 18:01:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 859841C231FC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 17:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 907FF47765;
	Wed, 20 Dec 2023 17:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3lrib97i"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0B547764;
	Wed, 20 Dec 2023 17:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PV/ElPGkhtU8s+bHxLyBheB1j9sUnKIRoZJkrEtHZMvRKNHT0iqW4okza1/BXXEVLcZGqQFoqs278SNCA0Y9zEeC6mwMT4pt2mVV4OCyuDgXTToqK21BGMe4ydAhnZz61o+MKH8C1dfMp9cc/27bKDWj5TqUwgudc0kzjRXQ4OECgYOyOpJ9/S+zvu1PG2LckhEMwM9onZKZ/42urb+Gd2pVqN0mT+nbrGTUfAdKCyjgoUH/fzZc0F1xT6ChkzW7jASf2IcjlF5wmqDeZMFAt8jumyQCn3q4KIRjqgcnvl8utXl5yx/PD6x/Nk6XQufflCc4D3HltdXnyAnpLvs+LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k8ZAJKyjmRTC66KtLMdpdNrjtZUAlWyw67Dl3gMFui8=;
 b=KMIibQebYHc7UXyjAq9JOfY/4y5uUhMbL3Yinlzl5O383Yq7UIUb3eaxlZHXufBnQH589f17gG3r/z9i6TYmHRVYZxFGJNIPwLpq5KgqiAFO1/4sVc39X0csQdsWJzE3ekqMXXaQs5nPyMmVfB3B/03eIENPLXmFCWA04vH2et126Aq49HkAJh1BRRpTgjCnoIs/pg45GIvX+pkH+AYHC3V2FadXpzoQndkKSYxLcSHNPUg89zVKr2ZfvAhgWVKDxGLB9YFG8FkpAjquQ7jCyjIsai5Ytswo0Wt2lHau65tnp9ZLV1Ua0U431X/zUIMuOGCs+s1SAXfslhN4YqI5Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k8ZAJKyjmRTC66KtLMdpdNrjtZUAlWyw67Dl3gMFui8=;
 b=3lrib97iENq3JQ740A+t1rgqYhontzblyuQNiljAuN/NApLsWbPJWU/AA8He/Wmp4BJ7nBFmnImdZDpJlB//SFHixHt6r8++qRhOZYBpU0mmE9ORRv3020cWwxJRofJSfU1XfCDJDniSf71caxF0sT8umOSH7ePJ/41VySvbIpA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB7016.namprd12.prod.outlook.com (2603:10b6:303:218::14)
 by DS7PR12MB8323.namprd12.prod.outlook.com (2603:10b6:8:da::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7113.18; Wed, 20 Dec 2023 17:01:29 +0000
Received: from MW4PR12MB7016.namprd12.prod.outlook.com
 ([fe80::1f1b:e85b:abf0:3d3c]) by MW4PR12MB7016.namprd12.prod.outlook.com
 ([fe80::1f1b:e85b:abf0:3d3c%6]) with mapi id 15.20.7113.016; Wed, 20 Dec 2023
 17:01:29 +0000
Message-ID: <5bfaa405-b15e-36ef-a4e0-04b93dd983b1@amd.com>
Date: Wed, 20 Dec 2023 22:31:20 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [Patch v2 2/2] thunderbolt: Teardown tunnels and reset downstream
 ports created by boot firmware
Content-Language: en-US
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Sanath S <Sanath.S@amd.com>, mario.limonciello@amd.com,
 andreas.noever@gmail.com, michael.jamet@intel.com, YehezkelShB@gmail.com,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231218104234.GB1074920@black.fi.intel.com>
 <c433f29b-597c-b6d6-aa48-2b84a26dc623@amd.com>
 <20231218113151.GC1074920@black.fi.intel.com>
 <20231218122312.GE1074920@black.fi.intel.com>
 <997f2a94-66d9-fb95-8f75-46d61937f7e8@amd.com>
 <20231218131840.GH1074920@black.fi.intel.com>
 <0fd5c09f-1cf2-8813-a8f9-1bd856e3a298@amd.com>
 <20231219122634.GJ1074920@black.fi.intel.com>
 <0816caa4-81b5-d0f9-2305-80c7fec6abb9@amd.com>
 <20231219180424.GL1074920@black.fi.intel.com>
 <20231220125857.GA2543524@black.fi.intel.com>
From: Sanath S <sanaths2@amd.com>
In-Reply-To: <20231220125857.GA2543524@black.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXP287CA0002.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:2c::17) To MW4PR12MB7016.namprd12.prod.outlook.com
 (2603:10b6:303:218::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7016:EE_|DS7PR12MB8323:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c6ec236-b48b-4245-2b99-08dc017d4ee3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	gmECyQvdoxEjGP0BZvIuxHZb+oPhrxJOUEWxR78SzgWuhmRE6gPf8hU9j3QqHZBQEJ7/gj+UpeyxrfJwpHdkiGQIFkxpFAGQdLe96VO6OfAIcP191gkRGCbk+3bW5u2KejeyeJl2Sz4kp7e2d3b2LqPfMPXNfWC+M8gKwIc6/FfHOzAeMp2rJdd8vTUHILgi6CQfoi2EEuZLi1oGhKBU+/li808JjkeUqgzZDh3i35/n4SHDRAXVc7LhIFpXkJo6zeTlvGPdkcloPmkgIWYInjkG1jD46pIbXFEMCqOj4OXSh4LvthyIfCmTEzlvaPVk8tHRVsqrs9WTWrp/u+61LCFiCdqFgKBPCZ9jtMT600xMREHm4huFO5JIOCV0eJCPI275LQXY5y/K+VQmcm+F5HMqIyEZQONjb1Q/3+BXT40ni7XZ4Dg0T8CPBJqsfsWlfNCkbJvQ+AU+wbYMqqxjqrt3agf4Yb9LsG6sr6SfOQW8qxrOfBSNxmorPbS0wc0xoUXHxF9SyhVgLeMILH7FNdlMBDYyRGwy8DthMvor0Mh7waFrCeZIzInD7MIdrsOxpQo1cUAiQwjE6xdYCufyFIRXtWhqCdgRfCrpEy/xbWogDSTCWSrEI57OObq3d7e1kua3hrNu1jK574yS8UFUmQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7016.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(136003)(39860400002)(366004)(346002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(31686004)(2906002)(5660300002)(8676002)(8936002)(4326008)(66946007)(316002)(66556008)(66476007)(6512007)(6506007)(6666004)(6916009)(31696002)(478600001)(83380400001)(53546011)(26005)(2616005)(41300700001)(38100700002)(36756003)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dTR3dDdGeExTS3g2UjFSNWJwbGpOcDBJWHZmc0ZsWCtuc2xJNWd0OGQrRTlx?=
 =?utf-8?B?bllYTTJQMFNRd1hvTFBSaUpTVFM0WTg0eFppcW9ibXpKMFpYVGZQZGZmNDRD?=
 =?utf-8?B?SlhnZ0loMkliV0RzRW9tSFg1U3ZEd21QaTdyT2tSZjNSaWM3b2dRbi80cWRt?=
 =?utf-8?B?STlSM3RUTmkvdjRVK1pnUXg3MEt2anF5QzEwV2kxUVRrYnlXUG1RZGJGaFA0?=
 =?utf-8?B?ZkQ3TDhYTE5MS2grd1Z2ZzkydFZrc09XckdyVTd5LzZQWWpqM0NMbGg1ZmEz?=
 =?utf-8?B?UHdvMmx6WkpoRzhqZ0NCUm5XbjNqaFNDWVhERHBNaWFtaGdoanphMWFUazFq?=
 =?utf-8?B?REtySVhoMks4aWZidVltaC9jd3Vyb0NjeHkxamtmSDlJdG5iTmF1eTlsdDlS?=
 =?utf-8?B?L1VPSVFXaTVOMWdvaTc0R0JVdzNDTDk3dERTcDJrWnF2TUl5RnoySlRIelR2?=
 =?utf-8?B?bDJuRVEyVTk5SlhJZHAwQmZQbVRIN0RoYStIUlVJa2RCbU9lTmVxdHptbkpr?=
 =?utf-8?B?ZGxXVmd6T2JnZ1hKNkQ2RGdCZXlXQUlvZjBjbGhNWlZlVC9zUGIrSFk1a2cx?=
 =?utf-8?B?SElDMG54bFdja1YweWRjazJQU2owaTEvRFdnTWh2OUwxQWNZU2ZtYm1KNTNG?=
 =?utf-8?B?VmVhazZmTVFseDBpbiticXJkenpSc1M5cytGbzZwSXdyUlZ3MmlJSmppUTJD?=
 =?utf-8?B?RHBnb2t2WXl1aWh1ak1RQ01id3Q2OExRTm1tQ3duaTIxWUNrb08zeC9zOU0y?=
 =?utf-8?B?UG9QSU1pV3I1TzcyZ2FmcDdld2NhQU9HSWEyVlVmQm0zYThzU3RUZUEyeHNJ?=
 =?utf-8?B?RUVYUTgwL3VUejVXYmlLUExVM0JLSDZMemFwZWlEaDFwbmhKN0VCYzhiSnRO?=
 =?utf-8?B?bDlWcUgrMFV3SXFBTXZra1JRYmxyZjdtcjg0bDE3Z1VGZGJFaXVlMzJMVEh0?=
 =?utf-8?B?TkV3dVQ4R3lTVXNmeEF0TjBCZURydFRnT01WVGRVZ3B4WDZlNWxCcTJIOVI0?=
 =?utf-8?B?cUF2NGg4QnFzSDRVelZteUl3UkhaQ0RuM28xOU5vRGVoYUxYbVBKUG1iZ3VX?=
 =?utf-8?B?TTAwek5tMm9LbXpFYVVaRWZpTmpuYldkV2luNzl1VUFDbCtZVWUxMHVQc2w0?=
 =?utf-8?B?ZERzZzcvL04xKzU0MTFnTkhuTk9SNjY0YXVFdlNjZG9KK0VROXBhZHVSYnpS?=
 =?utf-8?B?d0dwdDc2dVlVTER0ditkWVRDRDFpZmFQL29OM3hMRld1S0xySFJpT1BFTFBj?=
 =?utf-8?B?N2oya1JPMlRtcDZqR0JuTHR5aThaS2QyYVo5MTExazRZTTEwMytablc4T2xr?=
 =?utf-8?B?NnY3dkI0Y2pSY3BXbXFGRjBRZnhsMk4zSU9wWC9WWlhnUkxYUWFNeDdIdnQ1?=
 =?utf-8?B?UDMwL3VxUG52QjR6ZTRHbzNVRCswMjZzbzBXeStOZ1Q0a3VmMmRVNktCRTRB?=
 =?utf-8?B?Y3c5SmVPRVY0empwbzczWnRraHJ4bUNzTHJncTVsTm02UndOR0pDYXFZMkEr?=
 =?utf-8?B?TkJFQUNidUFEZXNBdk02ajBjaFpydEFzMWJodzJ4dHhFaUtzWDRFMWlQZDly?=
 =?utf-8?B?ODFiTUJIcVFHRDhxSFJEWlhxdWRTVjhKY2tuZ2pEYjVlNlZVMXE0bWtaNkln?=
 =?utf-8?B?czRuZjkrOXpzSzNMR2lMMnhjTjZSQmUzYnk5eExROW9TZXdYbkdGN1hBMmds?=
 =?utf-8?B?R0NJWEtXV0FZTG95STlXcm01RjIzOHF3Q1hQMk9xaFRaWjgvR0pST0FwczlC?=
 =?utf-8?B?U3hWQmZlcUZ2ZWE3UG5IRHpDcmZZUzIrcFhwRE9kR1hPNVFCR1BSTnBod05W?=
 =?utf-8?B?SkRFTjJpZkZqSjRzWGdwVTdhU3NxLzc2YUxSdGEyQzUxZTBBK0JiMmNPVjI5?=
 =?utf-8?B?QlFrQ1o2NC81RFpydUkzWDNweSs3ZFBPMERPSEpvVjBuUG9NUmpKTkw3ck5D?=
 =?utf-8?B?b3l1RGpqbUM2UXIzUGYrUmRyMTZMaTRyZE41UC9nMWtVVWtqNEdSWnJlOTlV?=
 =?utf-8?B?alpDUi9VN29UWm1IWThFRmowcEhoRlZvSlNBNVRxOGkwdXB4UVVPVS9CTjVO?=
 =?utf-8?B?OUtyVWZpVHE5RnRSVnZYeE5HYjFsMmJOQUwwL0FJemVOakNCZ1d6a1JNZVZD?=
 =?utf-8?Q?mDDgX8Es2hAvYqsCspkHrTSFG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c6ec236-b48b-4245-2b99-08dc017d4ee3
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7016.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 17:01:29.3139
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uiRKiBql7Y/g3yGgkEwV7jiyZsaw76xFERQDimIEteKBHezyuL0oectUpMHHJ6NAqB+uPpL5tpHy4EB7oqBJjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8323


On 12/20/2023 6:28 PM, Mika Westerberg wrote:
> On Tue, Dec 19, 2023 at 08:04:24PM +0200, Mika Westerberg wrote:
>>>> One additional question though, say we have PCIe tunnel established by
>>>> the BIOS CM and we do the "reset", that means there will be hot-remove
>>>> on the PCIe side and then hotplug again, does this slow down the boot
>>>> considerably? We have some delays there in the PCIe code that might hit
>>>> us here although I agree that we definitely prefer working system rather
>>>> than fast-booting non-working system but perhaps the delays are not
>>>> noticeable by the end-user?
>>> I've not observed any delay which is noticeable. As soon as I get the login
>>> screen
>>> and check dmesg, it would already be enumerated.
>> Okay, I need to try it on my side too.
> One additional thing that came to mind. Please check with some device
> with a real PCIe endpoint. For instance there is the integrated xHCI
> controller on Intel Titan Ridge and Goshen Ridge based docks. With TR it
> is easy because it does not support USB4 so xHCI is brought up
> immediately once there is PCIe tunnel. For GR (the OWC dock you have) it
> is disabled when the link is USB4 (because USB 3.x is tunneled as well)
> but you can get it enabled too if you connect it with an active TBT3
> cable.
Sure. I'll check with these combinations.

