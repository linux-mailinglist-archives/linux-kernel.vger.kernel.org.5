Return-Path: <linux-kernel+bounces-4944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09B5F818431
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 10:11:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2157E1C237DC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 09:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB0B12E73;
	Tue, 19 Dec 2023 09:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XZL9lbII"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2040.outbound.protection.outlook.com [40.107.93.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF5113FF6;
	Tue, 19 Dec 2023 09:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OpWezdG2AwWC9KlrbnvKXbs6siWDRuov/Yu6ZYPEXhf0pb5f/HBF23hAFEVLSK8zy1uZV4wLEfZFhHz6R9r5ejC9zgopzAczaDRtBPTYUpc99MlmmIhKxOGAHdtnR3W97pTiF9HzHHHdgdQTJ1MWkTa14g9brdonD6CHVRkPdgLC6MlUCCjhXYpz8qdsYdrw1s1PAYVOFeXITZX+iycKl4E1pq3AR/TIOm9CnXYavPH0CklnxirfavfGovQHVUyqEOPQE45Ny0TNPkjFDmFAp6c1tFdPApaHWOBDNPfW5G/EeOPland7qUNhKHUjpGjFV9WCV6NZYQ9XkA0KrjANYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MPMLwKpLHPuVPKP7dgDoUJVV9cNe6WRHjV2H9/tVY9c=;
 b=XP/R+7TKpbzak5HKf9T4knLn8tCtUgJytiS8STGDtvcmdFOfxYgb1/yFjggHiJl2Q3gWMRstnLbUCb486l0EM5ipb23bJeq38rOlOFQ3/YzrLzuocbYlbIT4p7eUBCReU1lA07s/2ElpWeHJ4BXuoRMUC2OQcqIOZribZYRqxr3bpUp3h0298U50hr8nEwhCBqgPiE5QuP6CA43p9vXrE3P8nf+CK8P1wiVNvrNHKhQInLAEjkhYA3isWRJCe8ZJnppJfu8aN74pEc/XZygaGLNJ1e1S5yOLRMwJb3LYS/uvzZvHB9oPglN4qy2mCMacHgNXdpgGTRpBM0Cx4kYpNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MPMLwKpLHPuVPKP7dgDoUJVV9cNe6WRHjV2H9/tVY9c=;
 b=XZL9lbIItq+uJ9rJfVsXCoxnSmw8gQ6tW0s3Qt+njGVmqxeSWIZtOkQKJXrzdexTtkFRE3BbYGoUYMkqmPh++cs5n9pZ+OdAf0K3kQ0T9C20TgEVCV6G7iwsVxuI8mWgP/sfniM8zKX+IcgfVfGE8vTitaaVeWF1PdZmUDO/J8A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB7016.namprd12.prod.outlook.com (2603:10b6:303:218::14)
 by CH3PR12MB8457.namprd12.prod.outlook.com (2603:10b6:610:154::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Tue, 19 Dec
 2023 09:11:27 +0000
Received: from MW4PR12MB7016.namprd12.prod.outlook.com
 ([fe80::1f1b:e85b:abf0:3d3c]) by MW4PR12MB7016.namprd12.prod.outlook.com
 ([fe80::1f1b:e85b:abf0:3d3c%6]) with mapi id 15.20.7091.034; Tue, 19 Dec 2023
 09:11:27 +0000
Message-ID: <0fd5c09f-1cf2-8813-a8f9-1bd856e3a298@amd.com>
Date: Tue, 19 Dec 2023 14:41:08 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [Patch v2 2/2] thunderbolt: Teardown tunnels and reset downstream
 ports created by boot firmware
Content-Language: en-US
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Sanath S <Sanath.S@amd.com>, mario.limonciello@amd.com,
 andreas.noever@gmail.com, michael.jamet@intel.com, YehezkelShB@gmail.com,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <ff143967-63ff-c4fb-9c88-8537a663c45b@amd.com>
 <20231215115521.GW1074920@black.fi.intel.com>
 <c7d174d3-028f-9ce4-7ef5-3e033c195159@amd.com>
 <20231215140224.GX1074920@black.fi.intel.com>
 <866cb714-b9a8-a7d4-4c59-6ba771ef325f@amd.com>
 <20231218104234.GB1074920@black.fi.intel.com>
 <c433f29b-597c-b6d6-aa48-2b84a26dc623@amd.com>
 <20231218113151.GC1074920@black.fi.intel.com>
 <20231218122312.GE1074920@black.fi.intel.com>
 <997f2a94-66d9-fb95-8f75-46d61937f7e8@amd.com>
 <20231218131840.GH1074920@black.fi.intel.com>
From: Sanath S <sanaths2@amd.com>
In-Reply-To: <20231218131840.GH1074920@black.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0181.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e8::7) To MW4PR12MB7016.namprd12.prod.outlook.com
 (2603:10b6:303:218::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7016:EE_|CH3PR12MB8457:EE_
X-MS-Office365-Filtering-Correlation-Id: f5853a1d-7881-41f5-f810-08dc00727aff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	O1l9G704xQez2l/dbHE6MdLRrQQySiLTpd9GCZ8elWvynJ1GM94q86lAec4h9pagbO7yMYBq57ehXVEK9bFD1HiHl4ej9zpoQs5XWhgdKCDtb5x/LWxIBVnGl4kKBvpUbfMpthN8o9U9bY8obNQZbf155ojXY4PuLDLJtDXjXxhYU8RQ1lWvZgBxc9zQQBfH+BM2BNvsL6bsvAFM6T2z8mCPEcXMXH703uOa8B1A0UEidH9MwTNYYlQfhsrpRd0zc/IHBcVPRmsMZsaG2PPreZ1gAWlkWTCo4n/36MoW0fbPEtHrCJcFjwlPfaDjPSzjPzYfvFC18MBgEJvJ14emPm0YgOIlh/+7qJTrd4oNGoxdxISsobv7BJphy4h3O9z7clhUSmE173KJ7tX4eaO1aeLNDjYed9/GklKKgys3iyBDJBWLXtNDfN52unkprrFJ95+gw87AflT5SY/k/k0XbOv62Qf5mgZRE1dd0EOC4h36kvcLGHrTRuGvczgo+cTzI0ZlQef3231n0ak5PnZ2+8W5yyxh7Jv0qzlpGrfK/TgyrF58GVEDsXY8ZZXCoYYwLmpdcehZIm9jeUUglB0T8GktlWmLWRtMN8UHdZqilWMV6yLGb2LlUqVGHyakwNOTcGXXs53L+lOs/NHf/IfnjQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7016.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(39860400002)(346002)(136003)(396003)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(66946007)(66556008)(2616005)(83380400001)(316002)(66476007)(6916009)(53546011)(38100700002)(478600001)(6486002)(26005)(4326008)(8676002)(8936002)(6506007)(31686004)(6512007)(6666004)(5660300002)(2906002)(31696002)(36756003)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZkI1M1pVaWtQTFRyaXBjQnNqUHNUaHZuc3hxVW1MMmppdGRDNGpIaW02Rmhk?=
 =?utf-8?B?Qko0RmpWSS9tY0I4ZmZ0RUtuUWlrSFhSc1lkUGN1Y0ptSG1pLzVNR3AyTi9h?=
 =?utf-8?B?TUwwQlZZVjJyTDFJYmZ3T3BkcElMb0VGR3N3cFdRRXZxdmg4azFJcE1iUEE4?=
 =?utf-8?B?OVJSQWJSWVZlRkZUQ1NoclVXRnYvcm5JZVlNcUZyK2psdDZ6SE1PRnEvV3Vp?=
 =?utf-8?B?cmU0U0haQ0lFQnlpQlMwczhQN1F4TmloVFdCaDljS2NEd2N1bWRDRXZZOEs4?=
 =?utf-8?B?cHg2VStIazBhM00xN1VvL1BzbmgzdTNBREV5clhRTlgyZVB5My9WTGNUdW5U?=
 =?utf-8?B?ejI2NWpkYjJuSVp0NmUrOXo0eVV1SlVuYTF1akxEaFExdkd5TWhHWnhDdjNR?=
 =?utf-8?B?c0xEMFcvR1lPYWlVLy96T05HRWdlTm5uNCs5VitmbHFheFFKNm1HRUhiM2Nj?=
 =?utf-8?B?SmszVFVRQ0V5THlqL3Y0OUc5dDM1Z3Z4cHYwczFlay9UbE5aZVFRNVl5Ulh6?=
 =?utf-8?B?MXdUL2tLTmE3b3NZQklLMVNTZnNLSGQzN3JaaHBjNWFkNk1PYUFITnQ3U1NU?=
 =?utf-8?B?aGhrYWEvNHZ0c21HZkdGT1IvdUM5ZGcyZnJXbHF6WlA4QktTZGRXU1Qxd2g1?=
 =?utf-8?B?ZGtadmZ0SWJiRzF2NUcvanVtUFVxSC9uYjJOcmVBMnI4Q1RVUEZsaTFrczNE?=
 =?utf-8?B?RnRaaStFZk5uMXVWMnZoaFc1NFF4S093cDA2SUZwU2NiK0N5dW5teTVjNjkz?=
 =?utf-8?B?cUYxV1pzU3RJN29ianJ6RjJMZWRIcGlqNmkrbXZNN05Vc0FOUmw0c05YTEtS?=
 =?utf-8?B?eUJiM281WGJERWpDckxyTHBySEFVNHVSWmhhd2lTbzJTMVJoQUFyOEJmNWN1?=
 =?utf-8?B?SWpKa01XNHpLQnkrNVAzUWhiUUlvTWtXWFZzNHBSaFRiMFdOQVFKM3NzMEdO?=
 =?utf-8?B?UkgrOXVDRURncEdHZUJZRUFvbmRvMW5NVmp1Uk5EMldXSUhWeE1EdHVMRGZT?=
 =?utf-8?B?SUlFNlV1ejcrQ3cvMHVHUEtwMk1SUnJudXFEY2dCYWJNemQ1b1ViRGY0K3Zw?=
 =?utf-8?B?M3g5MG5yYlhGdTluSy80cWprbE1HVUdrZzgzdlp3eEp1TTl4TjYvcnIyNThz?=
 =?utf-8?B?Z2FJSTNUZ0QwZmRzV29jVHhHMEtXRDVrNDZyb2ZjYWorbnlnYm56MWJwSzNa?=
 =?utf-8?B?WXZQYWsxVm5JdFliT2xITHpoa1Riamg2dmcxTktUR1JySnB4ZzFxOEpOTTA0?=
 =?utf-8?B?RG93bmpySVcvQkZoUkk4dEMyRjlocDVMMjZrOTduUkk4RGl2MTNiSVN3SDJk?=
 =?utf-8?B?SlU5QUVpd1pvSjA5SEJ0QTg0TDBBaGdabVJiK2ZESUhOd1FWQkVHWG50OWJj?=
 =?utf-8?B?VnRiUlUvV1RSRG10aTdSWGhQeUNrYm9SOWNjSkQ1RHNYRjloMElwdDFtcGEy?=
 =?utf-8?B?YjVHUVdxSGQ4UWtVd296aTdGc2NQRjEzWEwwRWNTZElXOC8rdDZFQ1dFZjEv?=
 =?utf-8?B?anJSdFFKWXRsTE1PMGVmclRpUUF0QnRsSnVNaFoyOHdCeUZFWmttK2Q3c2J4?=
 =?utf-8?B?R0xtVzBRRXEvdVdpTzBGMjM4YUpvWnhlQmNJeDhZTm96RTJyZlhCcDNpSXlK?=
 =?utf-8?B?V1o5UmhCMXFzYVdieFg3cFdGRU5mZFB4ZVVBVG9lbUVhTklPeVBUQk9nVHMv?=
 =?utf-8?B?UndCcnN3U0JKUUtsWjdGYTBSQ3p4VUoyWUp4ZzRYQjhERXJpT1MzR3RNT2pw?=
 =?utf-8?B?dHJzNEp2dDNhR2xQdHYrMnFZNkdBTEpuQ3Roa1plSkplME84TXdMZzVoTytq?=
 =?utf-8?B?cDdZeHU1eVNURm53ZDNySStCcUhoMkR6aDZCY1dKTWxpQ1N5V1FNRWM4dHJi?=
 =?utf-8?B?NWtkMVBwWUtWZ1ZIR1B2RFU0MmlSTWtyYnVrWHhvTUxldjFXSHowZGEzd2Vr?=
 =?utf-8?B?a2kwQmp4Mnh2YlluNFZSWW9BTmxoSCtCZUxuZ09Kb0VHTzFnUEdKWWFWRGdl?=
 =?utf-8?B?WWY0Tm9ZQk1EMG45dk02ZWpkYmNFUUhMVFdFMEY5WFNQNVJ0WEYwMU9TZkhq?=
 =?utf-8?B?aEg0cFdpcnRUV3FZUG04ZWZBZkplblBsMjVvdUM5dm04L2JMeHZGWlZXWEht?=
 =?utf-8?Q?Z5gsXuErTFhPMcYzLWZpNk/ju?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5853a1d-7881-41f5-f810-08dc00727aff
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7016.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2023 09:11:27.7245
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LzhQmDECxSjjNp9loCiSyGfwgI89X2CWXwP+TwblAitAyoNKIeGkwEAlXieWyEnlmwjsBNWzv32pa/NDM0FLeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8457


On 12/18/2023 6:48 PM, Mika Westerberg wrote:
> On Mon, Dec 18, 2023 at 06:35:13PM +0530, Sanath S wrote:
>> On 12/18/2023 5:53 PM, Mika Westerberg wrote:
>>> On Mon, Dec 18, 2023 at 01:31:51PM +0200, Mika Westerberg wrote:
>>>> On Mon, Dec 18, 2023 at 04:49:13PM +0530, Sanath S wrote:
>>>>>> The discover part should not do anything (like write the hardware) so
>>>>>> perhaps it is just some timing thing (but that's weird too).
>>>>>>
>>>>>> I think we should do something like this:
>>>>>>
>>>>>> 1. Disable all enabled protocol adapters (reset them to defaults).
>>>>>> 2. Clear all protocol adapter paths.
>>>>>> 3. Issue DPR over all enabled USB4 ports.
>>>>>>
>>>>>> BTW, what you mean "didn't work"?
>>>>> Path activation would go fine after DPR like below:
>>>>>
>>>>> [   15.090905] thunderbolt 0000:c4:00.5: 0:5 <-> 2:9 (PCI): activating
>>>>> [   15.090932] thunderbolt 0000:c4:00.5: activating PCIe Down path from 0:5
>>>>> to 2:9
>>>>> [   15.091602] thunderbolt 0000:c4:00.5: activating PCIe Up path from 2:9 to
>>>>> 0:5
>>>>>
>>>>> But, PCIE enumeration doesn't happen (pcie link up will not happen, will not
>>>>> see below logs)
>>>>> [   15.134223] pcieport 0000:00:03.1: pciehp: Slot(0-1): Card present
>>>>> [   15.134243] pcieport 0000:00:03.1: pciehp: Slot(0-1): Link Up
>>>> Okay, what if you like reset the PCIe adapter config spaces back to the
>>>> defaults? Just as an experiment.
>>> If this turns out to be really complex then I guess it is better to do
>>> it like you did originally using discovery but at least it would be nice
>>> to see what the end result of this experiment looks like :)
I feel it's better to go with discover and then reset for now (as v3).
I'll keep this experiment as "to do" and will send out when I crack it down.
>> Yes, I'll give a try.
>> As an experiment, I tried to compare the path deactivation that occurs at
>> two place.
>> 1. In tb_switch_reset where we are calling tb_path_deactivate_hop(port, i).
>> 2. While we get a unplug event after doing DPR.
>>
>> I observed both have different hop_index and port numbers.
>> So, are we calling tb_path_deactivate_hop with wrong hop ids ?
> Wrong adapters possibly.
>
>>  From deactivate tunnel (called while unplug) :
>> [    3.408268] thunderbolt 0000:c4:00.5: deactivating PCIe Down path from
>> 2:9 to 0:5
>> [    3.408282] deactivate hop port = 9 hop_index=8
>> [    3.408328] deactivate hop port = 2 hop_index=10
> Definitely should be port = 5 (that's PCIe down in your log) and
> hop_index = 8 (that's the one used with PCIe).
>
>> Deactivate from tb_switch_reset() :
>> deactivate hop port = 5 hop_index=8
> Can you add some more logging and provide me the dmesg or
> alternativively investigate it yourself. You can use tb_port_dbg() to
> get the port numbers to the log.
I've sent you complete dmesg.

Here is the log w.r.t port numbers and path clean up.

[    3.389038] thunderbolt 0000:c4:00.5: 0:3: Downstream port, setting DPR
[    3.389065] Calling usb4_port_reset
[    3.389068] thunderbolt 0000:c4:00.5: 0:4: Found USB3 DOWN
[    3.389193] thunderbolt 0000:c4:00.5: 0:4: In reset, cleaning up 
path, port->port = 4 hopid = 8
[    3.389203] thunderbolt 0000:c4:00.5: 0:4: deactivating_hop port = 4 
hop_index=8
[    3.389682] thunderbolt 0000:c4:00.5: 0:5: Found PCI Down
[    3.389811] thunderbolt 0000:c4:00.5: 0:5: In reset, cleaning up 
path, port->port = 5 hopid = 8
[    3.389817] thunderbolt 0000:c4:00.5: 0:5: deactivating_hop port = 5 
hop_index=8
[    3.390296] thunderbolt 0000:c4:00.5: 0:6: Found DP IN
[    3.390555] thunderbolt 0000:c4:00.5: 0:6: In reset, cleaning up 
path, port->port = 6 hopid = 8
[    3.390558] thunderbolt 0000:c4:00.5: 0:6: deactivating_hop port = 6 
hop_index=8
[    3.390686] thunderbolt 0000:c4:00.5: 0:6: In reset, cleaning up 
path, port->port = 6 hopid = 9
[    3.390689] thunderbolt 0000:c4:00.5: 0:6: deactivating_hop port = 6 
hop_index=9
[    3.390816] thunderbolt 0000:c4:00.5: 0:7: Found DP IN
[    3.391077] thunderbolt 0000:c4:00.5: 0:7: In reset, cleaning up 
path, port->port = 7 hopid = 8
[    3.391080] thunderbolt 0000:c4:00.5: 0:7: deactivating_hop port = 7 
hop_index=8
[    3.391213] thunderbolt 0000:c4:00.5: 0:7: In reset, cleaning up 
path, port->port = 7 hopid = 9
[    3.391217] thunderbolt 0000:c4:00.5: 0:7: deactivating_hop port = 7 
hop_index=9
[    3.391342] Reset success
[    3.391391] thunderbolt 0000:c4:00.5: 0:2: switch unplugged
[    3.391434] thunderbolt 0000:c4:00.5: 0:4 <-> 2:16 (USB3): deactivating
[    3.391471] thunderbolt 0000:c4:00.5: deactivating USB3 Down path 
from 0:4 to 2:16
[    3.391477] thunderbolt 0000:c4:00.5: 0:4: deactivating_hop port = 4 
hop_index=8
[    3.391641] thunderbolt 0000:c4:00.5: 2:1: deactivating_hop port = 1 
hop_index=9
[    3.391651] thunderbolt 0000:c4:00.5: deactivating USB3 Up path from 
2:16 to 0:4
[    3.391659] thunderbolt 0000:c4:00.5: 2:16: deactivating_hop port = 
16 hop_index=8
[    3.391664] thunderbolt 0000:c4:00.5: 0:2: deactivating_hop port = 2 
hop_index=9
[    3.391701] thunderbolt 0000:c4:00.6: total paths: 3
[    3.391720] thunderbolt 0000:c4:00.6: IOMMU DMA protection is disabled
[    3.392027] thunderbolt 0000:c4:00.5: 0:5 <-> 2:9 (PCI): deactivating
[    3.392154] thunderbolt 0000:c4:00.5: deactivating PCIe Down path 
from 2:9 to 0:5
[    3.392163] thunderbolt 0000:c4:00.5: 2:9: deactivating_hop port = 9 
hop_index=8
[    3.392170] thunderbolt 0000:c4:00.5: 0:2: deactivating_hop port = 2 
hop_index=10
[    3.392534] thunderbolt 0000:c4:00.5: deactivating PCIe Up path from 
0:5 to 2:9
[    3.392539] thunderbolt 0000:c4:00.5: 0:5: deactivating_hop port = 5 
hop_index=8
[    3.392637] thunderbolt 0000:c4:00.5: 2:1: deactivating_hop port = 1 
hop_index=10
[    3.392799] thunderbolt 0-2: device disconnected

But it seems like we are not cleaning up all the paths ?

