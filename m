Return-Path: <linux-kernel+bounces-17848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 445A1825389
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 14:01:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDF2C285464
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 13:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C748F2D610;
	Fri,  5 Jan 2024 13:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0fGdEGYp"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2067.outbound.protection.outlook.com [40.107.223.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4B72D052;
	Fri,  5 Jan 2024 13:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=faXkPNaZ12MfXRsYkSnVYgUmop+bqDv+vSzAWAy384T4a2TM15kN6Et2FXsHSeDL6jCGPXoh5k8RMeegrgMw3sbdGTbCq+1Zf/6wSsUo9gOpHoydSdBBtvywFW+v7vcur6M3JFWkq3PGoMFmn5LiJ7UBoF0QCjHJGrfTzA3iF9D7TA+QQMcBkBfQN4VvrPaIOlvSVToEKDzkxqJHFE3P+4H8GjeaeKKa6idOKuSVK94y3wGqj1dGftQgjlLNNiPrjdNuPJmRtUPbwZE/hMyVUnABzfMRb90nHL6Lr9XXTmSJGpM2knBRS56Wdn/PubRRuDqFywCAQSf3dc1q+/wfEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kp1iyqlnG9291NriL8DEtKmj5Gb7hTLnRnStXuwNcxE=;
 b=DiNZhDZz8TaMsqO5hbYi2oFSQe/UPyUsPBz0+NQBq6bIh7Ov/RyaYjmxoX9eHidtEmE7+NcBu8tZbxgs2uxw9S6+dZjUOAo49enYp3RW5Sn2Chz/iWr9pNC3T9mgrtAcZS+DOMOUwDkBVRSjyj5Uc7EvOotoShL929XWYfkgciYq8y61yzMSU+m18cggsdVCedKZ7tfEEDBm0yPPY0c3t+/EaITrNPYseuXlfoXjyRJJBgjVVfS4xud94HbXTEN6bjkCOXEtcFRdmEDtNbGLmCeKD8PoQtHAIFbqSKhzXUx+0OyHXvBq07sjOsStkwb+hFzGM1v6wTkhz8CRsf9cQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kp1iyqlnG9291NriL8DEtKmj5Gb7hTLnRnStXuwNcxE=;
 b=0fGdEGYpXLQBRrSIbxEdxE2R5LHH4dLaxI+VL2RPt9Ph6nsNgruqd/SedenMaaDnnoAf0loB2BxmNC23oE6irNBg7TKmFthoaJU1hmTMAXgioP3MH+aA2CG4NHHH+tYXltcq9o4GMEaFACMXTiuvnM2jX53p2rYlyzzAv9IW6cE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYXPR12MB9337.namprd12.prod.outlook.com (2603:10b6:930:d8::20)
 by SN7PR12MB8817.namprd12.prod.outlook.com (2603:10b6:806:347::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.17; Fri, 5 Jan
 2024 13:01:08 +0000
Received: from CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::2b19:2045:59c7:cde2]) by CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::2b19:2045:59c7:cde2%7]) with mapi id 15.20.7159.015; Fri, 5 Jan 2024
 13:01:08 +0000
Message-ID: <af88a16d-f1cd-48a1-b3d3-e410ed4e4b15@amd.com>
Date: Fri, 5 Jan 2024 14:00:55 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: rpmb: do not force a retune before RPMB switch
Content-Language: en-US
To: "Jorge Ramirez-Ortiz, Foundries" <jorge@foundries.io>,
 Adrian Hunter <adrian.hunter@intel.com>
Cc: Avri Altman <Avri.Altman@wdc.com>,
 "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, neal.frager@amd.com,
 sai.krishna.potthuri@amd.com,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <f83933d3-6426-425c-903e-abbd2691e84a@intel.com>
 <DM6PR04MB6575A30D162378E82B4D7DDEFC84A@DM6PR04MB6575.namprd04.prod.outlook.com>
 <ZXBGTxS7sUSILtLs@trax> <ZXbBhjZIn5sj6EYO@trax> <ZZPoRPxdWXuT+cEo@trax>
 <b88eca08-7f20-4287-802c-ae1c8e3cd5cf@intel.com> <ZZSH1ykwP45fZaLh@trax>
 <d1fac554-4a51-409e-bc52-100a6bb4f5dd@intel.com> <ZZUm68tU9zHsC+X+@trux>
 <29dc26a4-b95c-42d5-94f8-fbd23c589eaa@intel.com> <ZZfCrLr5isWF/bwN@trux>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <ZZfCrLr5isWF/bwN@trux>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VE1PR08CA0006.eurprd08.prod.outlook.com
 (2603:10a6:803:104::19) To CYXPR12MB9337.namprd12.prod.outlook.com
 (2603:10b6:930:d8::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9337:EE_|SN7PR12MB8817:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b9503e1-67f3-4b18-863f-08dc0dee624e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/Swbt3Md7nVoVy0b7mwVnvjNq+ULZFndMn7eviF5sO5e9aLJgw7PtuPnAAA+v5LFfVIHurkoGNXIs0B0uaGvH22dfb8hba2AGBsOG4EI3Ct2l9DNPTgdkrdEBhE47xrJe8yj2WYd3A94JTD2C8CjKht+YNHYNzjbSXJNwu8bYloDle7fBuXNX5WmmaQTH40QABOFZCw8lUZ957rtJ6d0gKpQXNwLnCtGbRbcMfM2NI6VLIlFkdoQAgKepS5IoZOm5ObI3cvQs/She3BAH4LQ5oPmVd+QYmNn/b6+MkHUpKcGVMYmtBxmk6qSWdAm2bx8OuzXib5vX5ku7DifBMnyX9vj2Ps0B2+KjnMM/qUnOWDVPZMfHWgY5BrLQo7nGOYiSYYkxr47ljfX46dfnSkEuO8X7QddeaJiB5wh2qWR9TJeCnQm5AUKVXl7W0pelB6wDshGCMQCXabNbt/ZJ3cDkNor/NlmmiFArxdz/ioIelrN8j0ov1lScJ0/UqqQMApucDmpVlaR6XhCO64hyYC/tDWOW9i8RsTuVUooc4GiJGXCioLfUB8v/AfVdT9s0TsSjAjc22NNHfy0KHVZbsXnZBW3FUjz/hLooWfbrAu7B6tLGSW1KdcA26ZYVIaO4mqR3Qpvqiu7PNntBpRuZCzv9A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYXPR12MB9337.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(396003)(366004)(376002)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(31686004)(66899024)(83380400001)(41300700001)(66946007)(36756003)(31696002)(86362001)(38100700002)(316002)(26005)(2616005)(6512007)(53546011)(6486002)(6666004)(2906002)(66476007)(110136005)(66556008)(54906003)(478600001)(6506007)(5660300002)(44832011)(8676002)(8936002)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U3E0TVE1VUVuSXkxcHR0M0xEczBQSE9URVFVL1d5S0laeG1pRGlOODM2S2lC?=
 =?utf-8?B?ZG5iY0pNeE5HdXF5dFRJdzJvZWVvZnZqaG1lRitSTmhQR2xLekJRUE9lcWxW?=
 =?utf-8?B?cTlBOXJneHNNSGlGUHFFNk5LbFNLNmVuUHR3VVFLQksvek53L1o0cnBYRGZs?=
 =?utf-8?B?TmRmdVVXN1hMS3ZpU09NSldqTkRlcXlSS0wyMlNSVmRCZk5SenkxNjlMcnBX?=
 =?utf-8?B?SzNReUlOaTFzeEQvaERrSHV4K1ZaL2xxbjl2WW1ydk5KYjJiTCt3QWFLVUp6?=
 =?utf-8?B?cWxHOG5iN0wybzZDNElyZ0VwT0p3UDl0N1pBcStYZ0wwZG02c2tOQUlIbVRh?=
 =?utf-8?B?blh0R3c4QjJwN2RzbGdWdGk5R0hYdmVpL1RUaThjV1QydWdZNUNZUmtRS01F?=
 =?utf-8?B?d1dMUjE0S1hxQlgvNS9vSDM0eUJrR0xVcXVQTWtqd3ptaUdDNmpXcm01QzVV?=
 =?utf-8?B?M2l3OERtVUp1UmVYVWRjNFQvdVU5VWtrelMyeHR2TWtPcjRYbmN2TzFVMG1o?=
 =?utf-8?B?NVJiNlpVakxrSmhiT2Y3OS9Ba1NFMVBUbUlVTmdnNWM2THY4bDRMcGJCMi8r?=
 =?utf-8?B?ZWUyVTBVY1N5bFR0T1FmM0JWSTZyeFJPSjM1TVdoYk5HTStBLy81NWh5LzN3?=
 =?utf-8?B?dHF1ZllzQ2VlNko0ak94NzhZeTVxbEk4VWVyM09vSlRFaHJSaGFkV3pnVkIr?=
 =?utf-8?B?Yzk2ZmxvekkxVXFqVmhRcEw1Q2hPSzNuZElYKzBtMmR3bHBQN3U1dXhjSGZz?=
 =?utf-8?B?aDZ3VjMwVUEvUGRPS1k3QkNLRkJTT05qNnRlRDYxR3ZzaG0wK1RxYzJjaGEr?=
 =?utf-8?B?NXJVbjE0aUpqbWlBS1pEZHo4UW9hT1dYaEpwb1laVlNGOGd2UjFnQ2dDY2kw?=
 =?utf-8?B?aUFiWUtqT0VHZVd0WTYzMEdENDZOckg1bFY3ejgxcWtZSkc4cWFxaC81S2hn?=
 =?utf-8?B?ZTdxc0tveTNUVzhHTldnSkcxcHUrRmloL0RFblRCTzZxOXc0RXhkOE81QkxU?=
 =?utf-8?B?dkR6cmNYakowWTZtNEZIOUlQNDVvY3lON1dKM3ZFVVN1TEQwQjc3ZHYxT2Fl?=
 =?utf-8?B?MStDcUxMUHowbi94TEYveENGVTc4MlhBaWhvWkgrMmlmS0psNTM3VUVtL3ky?=
 =?utf-8?B?cjY1eklpYWQxVURsUmhMRWtSelo1MGlUZWJtRWZZalFvUjFCUk5hZVdIWlEv?=
 =?utf-8?B?N3VUMEc1bTNsSEhHR1U1QXVJa1FERHZRUExBK0h0ZmY1Y0NWbHdDcERkY2Nu?=
 =?utf-8?B?SlpMMFMxMDAwTzFWK3l4WFJIODM3Ykt5ZDZLdHlkN0IwazI0Rms1NXZIODNE?=
 =?utf-8?B?M3k0WmJ2VmhLdE1pdEVXbzllY2dVTjJLSHZzcGthbFNpZWxPUjZIWnc3T3po?=
 =?utf-8?B?L0M4cllBUHVkREZWSlhoL0o4Y0dDcHo2THMyNm1odUNzZzRJTG0vZUtzVGk0?=
 =?utf-8?B?a0dpS3h2QXlOME9GODVqd2k4R0ZBOUdoTjJTVHF2LzNUODhtemZEV2wxZmZN?=
 =?utf-8?B?VEIvbExpY2lqSVlCT293UUNYd3NJVktTQkxYR3BpcXpTTDdTdTJMNXNqL1I4?=
 =?utf-8?B?TnFKOURmNWJPelVoSnRXZkNERVh5OFd1MUFFNWk1MHNtZDZlbWtRbjdSQTMr?=
 =?utf-8?B?ZVM5UzZLWktHblJxdXhLTnBTWUVnL0c1NVBTNGJOOWd1MEdiTHo5bERxWWxQ?=
 =?utf-8?B?eVlETHFqZDV2RDJDUXpreU5CN2g1TENVUzl4amd2dzNIZU5Ma3NwK0JkMEdt?=
 =?utf-8?B?SkVaNk5MNzIzdnZMWjBYUklEc1VzYThqS0I5M0F3UnpqY2VzVndrUnhDbFJP?=
 =?utf-8?B?VW0zbXFyY0p3ZkxVWDNwaGJMbkhsNXNhVHBJNWxtZUFPdkZJcU9hM3RuUFh1?=
 =?utf-8?B?OFRYNHhFWnBEYUtsWm81cFFpTVRjR3pxUUFwUGt4S3VaQXhTbGc5QTl5Q051?=
 =?utf-8?B?TWNaQTNNNHhUWUpDVkV3ZDA4M1EwT0FkUC9WdVdFQTVuRXNZNWpVcE1TTFJX?=
 =?utf-8?B?am1FRG1QZDd6ZTRIeUR4Z2NMTlJDdVRoQXFwVGJMKzAxL2RzZFNZdGtwWUpN?=
 =?utf-8?B?T0hReFhMV3NtTENWcEh2ajdqME1RSkdwYjNpcjYrb3k1M0VJTFcycEF5LzBh?=
 =?utf-8?Q?l+wVvJsytni9TfS7WJOSlf6YC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b9503e1-67f3-4b18-863f-08dc0dee624e
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9337.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2024 13:01:08.4643
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O80Tzlq1FM/aAyobROqRAvIQ/PVPo8fTSorAVIp7UPUalJgKaeaqk8XlknTIMHX2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8817



On 1/5/24 09:49, Jorge Ramirez-Ortiz, Foundries wrote:
> On 04/01/24 20:34:09, Adrian Hunter wrote:
>> On 3/01/24 11:20, Jorge Ramirez-Ortiz, Foundries wrote:
>>> On 03/01/24 10:03:38, Adrian Hunter wrote:
>>>> Thanks for doing that!  That seems to explain the mystery.
>>>>
>>>> You could hack the test to get an idea of how many successful
>>>> iterations there are before getting an error.
>>>>
>>>> For SDHCI, one difference between tuning and re-tuning is the
>>>> setting of bit-7 "Sampling Clock Select" of "Host Control 2 Register".
>>>> It is initially 0 and then set to 1 after the successful tuning.
>>>> Essentially, leaving it set to 1 is meant to speed up the re-tuning.
>>>> You could try setting it to zero instead, and see if that helps.
>>>> e.g.
>>>>
>>>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>>>> index c79f73459915..714d8cc39709 100644
>>>> --- a/drivers/mmc/host/sdhci.c
>>>> +++ b/drivers/mmc/host/sdhci.c
>>>> @@ -2732,6 +2732,7 @@ void sdhci_start_tuning(struct sdhci_host *host)
>>>>   	ctrl |= SDHCI_CTRL_EXEC_TUNING;
>>>>   	if (host->quirks2 & SDHCI_QUIRK2_TUNING_WORK_AROUND)
>>>>   		ctrl |= SDHCI_CTRL_TUNED_CLK;
>>>> +	ctrl &= ~SDHCI_CTRL_TUNED_CLK;
>>>>   	sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
>>>>
>>>>   	/*
>>>>
>>>
>>>
>>> Yes with that change, the re-tuning reliability test does pass.
>>>
>>> root@uz3cg-dwg-sec:/sys/kernel/debug/mmc0#  echo 52 > /sys/kernel/debug/mmc0/mmc0\:0001/test
>>> [  237.833585] mmc0: Starting tests of card mmc0:0001...
>>> [  237.838759] mmc0: Test case 52. Re-tuning reliability...
>>> [  267.845403] mmc0: Result: OK
>>> [  267.848365] mmc0: Tests completed.
>>>
>>>
>>> Unfortunately I still see the error when looping on RPMB reads.
>>>
>>> For instance with this test script
>>>   $ while true; do rpmb_read m4hash; usleep 300; done
>>>
>>> I can see the error triggering on the serial port after a minute or so.
>>> [  151.682907] sdhci-arasan ff160000.mmc: __mmc_blk_ioctl_cmd: data error -84
>>>
>>> Causing OP-TEE to panic since the RPMB read returns an error
>>> E/TC:? 0
>>> E/TC:? 0 TA panicked with code 0xffff0000
>>> E/LD:  Status of TA 22250a54-0bf1-48fe-8002-7b20f1c9c9b1
>>> E/LD:   arch: aarch64
>>> [...]
>>>
>>> if anything else springs to your mind I am happy to test of course - there are
>>> so many tunnables in this subsystem that experience is this area has exponential
>>> value (and I dont have much).
>>>
>>> Would it make sense if re-tuning requests are rejected unless a minimum number
>>> of jiffies have passed? should I try that as a change?
>>>
>>> or maybe delay a bit longer the RPMB access after a retune request?
>>
>> It seems re-tuning is not working properly, so ideally the
>> SoC vendor / driver implementer would provide a solution.
> 
> 
> Makes sense to me too. I am copying Michal on the DL.

We will take look at it.

Thanks,
Michal




