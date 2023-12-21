Return-Path: <linux-kernel+bounces-7874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D91C581AE90
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 06:58:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 495A22852E0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 05:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22A36B671;
	Thu, 21 Dec 2023 05:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KkgyHtCi"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2062.outbound.protection.outlook.com [40.107.220.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C009477;
	Thu, 21 Dec 2023 05:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gvpTbkad8ZDzhaYMRkAerd0F15Q98tviaxvxwOl4TiblYvCf0vJ5Gv1ZTxvmiUgRLFtNl5KS/ULNZ5qn46U9ehotUsk19/bd6QxcL8PwS1WGzJkXYejnt74JDFALK1ZvIQPLcY9zPKcjOYYaT5qe4c9E9h41sFQPMeI1manMaVKzJVSLT0nEyfh8Ccdu9+mLX+hjLQDTwLbfRzY6xYDwb108o0qRBzULMlBenKKoewoCkg4d2F9Ao8ABclbMubtI/yqHQ15EPDPybUnAn98kQXPwV0E80JqFn2QJzcB3Z+6ZLi6zfecNyvM8s/AWj4GU0ANeCP2Pgw0CZF3MKG828g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QeSSgyp+q0gBQ2aJfXzCNu9DNdrdjMTrZVrVm8b0pP4=;
 b=MpugOWsH7m/dNNHwAWXylUsFgeaUMZVV5mDjCNXl4ZVo26RiaOfdIBOAhIvK+uAr6kUHShRhwjWVVB7Yusuxb6c1F1Adz1aajQnEplmL+fMSTA86uMHhFuLglj1JUiQMT20o/ujvi3J2oQmPXWYojmw3SrWBV5IdfdRv6wvQSSM7Km8yVhunuotB7QWdzC6s1bwB0RwAvYiHY12GthqgVFjyxEj39vTzyZ5yAYcKa0aMxv2h++qlv5xtMkzaFK2sw6vlnkhJcY2XJArbs7/M7pf2S1VYns+OtnwH219UkfbDwayVAvMxQq9p2ecoq+exBAskjOVO5kY5zYX8a9GlJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QeSSgyp+q0gBQ2aJfXzCNu9DNdrdjMTrZVrVm8b0pP4=;
 b=KkgyHtCitnR8/iL+SHxLEiQcxJADypYScuBgUueL3x3jiZ7ord8j4qSaHdh/PurzL7BW8KpG0wiE62/u1OHyUX8SZnMZa1FGjuW24IG0Tcq38TdKYBiNfdqLTPTV+9mhT7JomyqRpAMLxwiEgn0qfMD4P6yS8+1+gqPHdWHOvUg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6351.namprd12.prod.outlook.com (2603:10b6:8:a2::6) by
 CH0PR12MB5041.namprd12.prod.outlook.com (2603:10b6:610:e0::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7113.18; Thu, 21 Dec 2023 05:57:58 +0000
Received: from DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::8650:7935:179:f18c]) by DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::8650:7935:179:f18c%5]) with mapi id 15.20.7113.016; Thu, 21 Dec 2023
 05:57:58 +0000
Message-ID: <46bf6ed5-31f6-48f4-b63d-f532e163204e@amd.com>
Date: Thu, 21 Dec 2023 13:57:50 +0800
User-Agent: Mozilla Thunderbird
Cc: majun@amd.com, Johannes Berg <johannes@sipsolutions.net>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 "open list:MAC80211" <linux-wireless@vger.kernel.org>,
 "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>, Jun Ma <Jun.ma2@amd.com>
Subject: Re: [PATCH] wifi: mac80211: Use subsystem appropriate debug call
Content-Language: en-US
To: Kalle Valo <kvalo@kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>
References: <20231215145439.57286-1-mario.limonciello@amd.com>
 <87frzzsfoi.fsf@kernel.org>
From: "Ma, Jun" <majun@amd.com>
In-Reply-To: <87frzzsfoi.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TY2PR04CA0016.apcprd04.prod.outlook.com
 (2603:1096:404:f6::28) To DM4PR12MB6351.namprd12.prod.outlook.com
 (2603:10b6:8:a2::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6351:EE_|CH0PR12MB5041:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c33fb51-72be-4970-9d3d-08dc01e9c85d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xYL5mGSvAE6LQ6VsSk+fMyBFixfvarNBX0LNaG7AgfnzXBzF3sERNt6FwPPysPFEUiUS9C4soCZx87nZ3Fg/YvAYDUIRa5/lhdLZzfogK4tQXndoOv9yO7LOVCOcTn6g2y4jOS0aWFPe653ti8NKgClIqzTchK5vyj/7aL9r9+EvPCnp0BywMxIjrlL1VJCTeJOTGkbv+2LAlFsY2uwUnOJGd8PHgONswaRd8a+Ppt5AuFSIU8BZQRr0cEf8EDZdWdOXkBNIxVnnyTp5Y47tmXJbCHaL35PLZEsLJ5irELLpfgvfByQfH2mpWUmBfaB0/Zo+qxy/LMx1DhyE+P0qHWxWX7Evs5lGxc1tOtCuvp41my3QghQqVZLTS0BXgKsD/vPlXcsFd3J5poUAGhel8UpK7Yy0usy6bCuq8Cp25Vx9Ud6p4frETibHQsf7jjDzQ+I4dlWAN/XQsbpwcKH0YsfhkNTxQ+Xdk6MuiwzpiNoNzRTJjJf95r38n4BN8UQTyuvweuF1245Q2ynNZrBqcjHXDdr3WGd9wGh6jvhO/fuaqibpOaSafAPG5QoJgfMNA+kIbiq2MCh8zFkrLX/afyFW4TzeO0rbWKos8zyTnyZN7f+DDKNe7GOc36EfNQDB4nqseZiyv470YVad2nDJqQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6351.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(376002)(39860400002)(396003)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(478600001)(38100700002)(110136005)(66556008)(66476007)(6636002)(66946007)(316002)(6666004)(36756003)(6512007)(41300700001)(31696002)(6506007)(53546011)(26005)(4326008)(5660300002)(83380400001)(2616005)(8936002)(54906003)(2906002)(8676002)(31686004)(6486002)(966005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZEduZDR3NmZZLzJhTGU5akpMUy9COUpjNW1zZDJPNFVxZk1NYUk3WGdpTy9U?=
 =?utf-8?B?OUtNRUkxa0lBY0FBSS9JbXVjQmFDTTRwTm9ONFJsWnNpS1ducS96ZElRU0pm?=
 =?utf-8?B?ZnJ0TWZOa00rdzFUWFYvUGpCcVBKV1NUcHBRT05GU0ZqS2puc3NuamFFTzJW?=
 =?utf-8?B?MThXV01tOW1RbHNMSGRDc2JtYVJOS2N0R3NEMWx4NW5paDhVbXlYbCsrbzlm?=
 =?utf-8?B?a2JiTUF6NDAzR21wRGZibEp5YjNWNlUzR1A3VXpia3pLWVEzdHg3elVzeWx5?=
 =?utf-8?B?dlQxWTRkM29PRFlrYnMvUU9TQ3ZPM2FkWWZjN1RYTzhhNEpUUUxPNDFQakZn?=
 =?utf-8?B?aUk1cmNiOWgvcGt5TW9lRW0vZ1ZITzRvNjVDQ2NnSzJXR3czSjNOdEp1UlhT?=
 =?utf-8?B?T1J6R0hpMEhodlMzVEczYWFyTjBTZnZHU0ZtT0pYZWVYZlRqMS9oQUd6QnBY?=
 =?utf-8?B?NWtaUXpWNHZPNk04VmV2VGo2UzFjT2N3ZnpvMnNBSWVrNGtUQ0dONm00NGh4?=
 =?utf-8?B?SnlBalQxQnhRYXN4dGF4Z3gzcEVHQlBIaW45Nm8zTFI0Yi93bDl0WnRpK0w3?=
 =?utf-8?B?bU91UXUwQWo2MUJiSC9ZeHhMVFQ4aGRla2lwYXJjNXB6ZVpJLyt6dlFPMjMx?=
 =?utf-8?B?UVpnWlJLamtWWVhMaXhUbUhSckVjK3M3Sk1LUTJFYm9nRDRjRmZvTnpCTkFJ?=
 =?utf-8?B?M0pydTBPbEFPQ0FWUU44ckZvNE9wbENMZEtXNW9ab2V5ZTk2S0NiSDJRbDNy?=
 =?utf-8?B?eG5TUEFUazkxTXVkaWhWMmRxcWorN0d4ZG5rOCtob01DYnlZVEc1ZjJ2b2J4?=
 =?utf-8?B?OERndDJzcTNzVmtIaTF2T0FmSFJLL2VlK0FpendVWlVOTE9QRENIcEJ5Ynpu?=
 =?utf-8?B?bENuWnlTTytTS0tKNWZNRCtJeS9Tamp6MkthT1o0SDZ0NGhsNFp6U29aVitR?=
 =?utf-8?B?ODM0Q0psTTVBWVpBTGxWN2hVZkNyVVhGS0FhellrWDZqWms1TmlBekl4Z3BY?=
 =?utf-8?B?dXdhN1hFVSttZjI3MnVZS1FOUWRWSTczN3dpQzYvRWJCR1FnOWNEZzBzaEZx?=
 =?utf-8?B?bWVTQUxmUmtTSUVwdG1tYTNxVE5zWDNuS2kxcDFPQzlFQWpsUTJZQ294NC8w?=
 =?utf-8?B?T1VMazV1VkpzRFJJMzBPVlFCTU5BUURBYnk1RW1hVkZ1bTBFaE5TS2w2elFi?=
 =?utf-8?B?Mkl5eFI1amlrN0duTWRrZEg0ak9wTzRSVDZXQ1plNEdRYkdoR09lTVVTcjdl?=
 =?utf-8?B?azhiQ3NFZzlvZStIWjR4M2tTS0NCRVE3M3crUXhtUS9lM1VTOXd0UTc2SUhX?=
 =?utf-8?B?Zk13Y0tYeFhMaC9LZU5wcWg0UXFLd0VkOWlJeTlHaHMrbEI4VjNlNG51ZXla?=
 =?utf-8?B?T1JtRE04aU13WkpjRjduYXhZVkhZaGFQLzRGUnhEcG5RNEI2cGlILzgzdFdD?=
 =?utf-8?B?WTRULzFqUHpQV0o2N2VkOStJY09rOGozT3pvOUpQRVJVZ1dlMDhNVVZJcGp3?=
 =?utf-8?B?WGpUTnJjc3NSSGhRYXo5UTh2NGJ2TEZPeHZBdWtYWVRVSVA5RktpY2NXTUpn?=
 =?utf-8?B?K3k0OFQ3eXNPR3pIN2k0TCtnUmlqVnRCcU1hWk95WXF6M1ZpemZRRzJNWUlZ?=
 =?utf-8?B?TUppTkoxdDh1aUREQ0xzamVrVUtMWGdLaWhEWGlxczd2R0ZZcHlHUUwrckNz?=
 =?utf-8?B?UEU2aTVWSFp6eUNRR0xUT3llamI4WjdldXJsajlxNC9UT2hhRGNkUnpIY0Fm?=
 =?utf-8?B?NE9xRytOZzlBdVlPdU9UOXFtMXBwMHAwdmQ0K05OK1NiN0UwTjVBUk1KTWNX?=
 =?utf-8?B?bGpORlZZcy9Pdmk5YmIvd1pwbWdzVi96RDlodlpSQ3FNTnlzNkRQeXIvbXdD?=
 =?utf-8?B?OUtCQVdaUk5rMmdDbFlacHgxbDA0bUNiRU5pcUpmTVZRSlpRY2s0UUYzaTd4?=
 =?utf-8?B?a2F2N0dKekNZdHF3TTM1VStNckFVZGdVOG1DZ2NIenhLaWsxVyt5dnF4VjVN?=
 =?utf-8?B?djNHTHJYV1VGU3FrWkZnTmpBQTdLSkhaeHRlUkJGNGNTcFVCeXdWM2pBV0JQ?=
 =?utf-8?B?SnRBTWllLytldGpDNVFVWVM5Qk9oVjVPQUhxalM3SGtUYTJZZlBYWFZIakYr?=
 =?utf-8?Q?BnFV2bETFV7nW5STqCEPUjSu1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c33fb51-72be-4970-9d3d-08dc01e9c85d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6351.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2023 05:57:58.2837
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5J0wQ40c7ypokZep8eGLsqR2AowVyamgkyMSbY7THGVkg/2+H1gkDflA2KcDwQpL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5041

Hi,

On 12/18/2023 11:17 PM, Kalle Valo wrote:
> Mario Limonciello <mario.limonciello@amd.com> writes:
> 
>> mac80211 doesn't use dev_dbg() but instead various macros from
>> net/mac80211/debug.h. Adjust wbrf code to use wiphy_dbg() instead.
>>
>> Cc: Jun Ma <Jun.ma2@amd.com>
>> Reported-by: kvalo@kernel.org
>> Closes:
>> https://lore.kernel.org/amd-gfx/8bd60010-7534-4c22-9337-c4219946d8d6@amd.com/T/#mfe2f29372c45130d27745912faf33d9f7ce50118
>> Fixes: d34be4310cbe ("wifi: mac80211: Add support for WBRF features")
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>  net/mac80211/wbrf.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/net/mac80211/wbrf.c b/net/mac80211/wbrf.c
>> index a05c5b971789..12c23e14f884 100644
>> --- a/net/mac80211/wbrf.c
>> +++ b/net/mac80211/wbrf.c
>> @@ -23,8 +23,8 @@ void ieee80211_check_wbrf_support(struct ieee80211_local *local)
>>  		return;
>>  
>>  	local->wbrf_supported = acpi_amd_wbrf_supported_producer(dev);
>> -	dev_dbg(dev, "WBRF is %s supported\n",
>> -		local->wbrf_supported ? "" : "not");
>> +	wiphy_dbg(wiphy, "WBRF is %s supported\n",
>> +		  local->wbrf_supported ? "" : "not");
>>  }
> 
> This won't work, I still see the debug message:
> 
> [  333.765867] ieee80211 phy0: WBRF is not supported
> 
> The issue seems to be that mac80211 defines DEBUG in
> net/mac80211/Makefile:
> 
> ccflags-y += -DDEBUG
> 
> That -DDEBUG should be cleaned up, but I think separately. It's just
> that I cannot come up with any good proposal, all the macros in
> net/mac80211/debug.h require sdata and we don't have that in this stage.
> Any ideas?

I will submit a patch that only compiles wbrf.c when CONFIG_AMD_WBRF=y

Regards,
Ma Jun


> 

