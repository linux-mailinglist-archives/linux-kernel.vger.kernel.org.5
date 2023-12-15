Return-Path: <linux-kernel+bounces-712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00E3A8144F9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 10:58:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CBD81F21187
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 09:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6849E18C01;
	Fri, 15 Dec 2023 09:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="N4hg9uOg"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2048.outbound.protection.outlook.com [40.107.102.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA38A199C2;
	Fri, 15 Dec 2023 09:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mb0h9t2eiCNpXrDsfKRKEmE9NnOOkwHVO9EWDjdDqi/nEztEYoKnC41EzRnQAt9Ib0CxaoSVnPfQ14uJBIEpIQaJnxHSs1LL/OadO/pez+xacBcKlLw+QZ57+O8JyC66H2deAWVEO1gYLxsewCiKOQZe28h3WbsgX1jUqTIQkLZHwk0bfXY159uYOwoGV/frt+oG5BRQ1r/ilW5+u7OUV4gInWlNlLTF5Pp4S/r+QKbEm9Q5g8UdCq8+HJuEn2pzhf1DTPCGA97dQqE77vTRsHi6o3dS+iQZchSz1bGUilnwGUxB+ZCSC72DTKqqM/2uNLZ1uz/WK5srByWG525B2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lT25uZYzbnjSmeovmcd5o58GSCed4HckSbD6B/QjPhs=;
 b=e6DfVyKTcMK/e1ATbbabKnA8rizfQNEDfWaNpMlaRpjwltUHHcTqBepMrqAF1o+RBB1fEuEvjxjaUUKUil+yYgb5jgRo453951iOvI2UvFDEWxNT0Uq3qT7IY6KHxwvz33WfSsjauLhXIZHCt20WecpO7ZkjT6B+Y4zeVMBZZMuFpzw6A8TKtVZ3Lnn7kpEgDjehAlaYcWgn5m2kgge4URdxSGJEXSJVcGv/nF7nP4wOlvyq23g9SXDcDdQnEV9jmG31pPXgz4Qvuin5eJeApd/RQibt/XucNoaK1Nyy0RO0FjAMZcgVZUg8/FqxG4inieDpS9I3r5YhLuAkEWNE4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lT25uZYzbnjSmeovmcd5o58GSCed4HckSbD6B/QjPhs=;
 b=N4hg9uOgrOSe8Jy1NlwIDhN/hhX+h4GERnPexV6PawFFPFlAOW9HqvUYlcly6E0ljUqPF/zreEgZrNetd4I99iatUERuSirR7hNudEX9yQ7/Kc/xiOlZoitgj2f01YxET1COMvfpu+q1WbxOe0kdziYWJpA7m+cLefxSoIInJKM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5951.namprd12.prod.outlook.com (2603:10b6:510:1da::16)
 by SJ2PR12MB7961.namprd12.prod.outlook.com (2603:10b6:a03:4c0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Fri, 15 Dec
 2023 09:58:25 +0000
Received: from PH7PR12MB5951.namprd12.prod.outlook.com
 ([fe80::e007:72f7:4102:9258]) by PH7PR12MB5951.namprd12.prod.outlook.com
 ([fe80::e007:72f7:4102:9258%4]) with mapi id 15.20.7091.028; Fri, 15 Dec 2023
 09:58:25 +0000
Message-ID: <188ee32a-a201-4210-a8bc-bf3ba04e2f2b@amd.com>
Date: Fri, 15 Dec 2023 15:28:13 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/11] ASoC: SOF: topology: Add new DAI type entry for
 SOF_DAI_AMD_BT
Content-Language: en-US
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Daniel Baluta <daniel.baluta@nxp.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Syed Saba Kareem <Syed.SabaKareem@amd.com>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Marian Postevca <posteuca@mutex.one>,
 Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
 V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>,
 Mastan Katragadda <Mastan.Katragadda@amd.com>,
 Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, sound-open-firmware@alsa-project.org,
 kernel@collabora.com
References: <20231209205351.880797-1-cristian.ciocaltea@collabora.com>
 <20231209205351.880797-12-cristian.ciocaltea@collabora.com>
 <fad8a055-eabb-4087-94d5-9e1de00933e4@amd.com>
 <aa830670-e544-43a2-9ba9-a64f1964a9f5@collabora.com>
 <318470ce-1631-4c46-b425-755c877dda65@amd.com>
 <421128f7-6a17-4be9-a72b-272ea4017fbd@collabora.com>
 <ZXXEsyBUCrBULNgk@finisterre.sirena.org.uk>
 <5095ce7b-13bd-4805-b81e-f7565ab41b67@collabora.com>
 <dea5fb18-5fdc-4be4-9981-a6876cf531eb@amd.com>
 <ca828ee1-93f7-432e-b95d-e67c35cdcdb5@collabora.com>
 <0de8f81b-e7d4-43f6-b011-eb6ee09cc7fe@amd.com>
 <913257d4-75dc-4887-97d6-0f206c401057@collabora.com>
From: Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
In-Reply-To: <913257d4-75dc-4887-97d6-0f206c401057@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0038.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::6) To PH7PR12MB5951.namprd12.prod.outlook.com
 (2603:10b6:510:1da::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5951:EE_|SJ2PR12MB7961:EE_
X-MS-Office365-Filtering-Correlation-Id: 87ab0af2-e0bf-4426-b602-08dbfd5460a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VCIknOJVteyZNWn5BAg+UxqfMi3JK6DnXSz/FM0cbe8Z6GYqvkHuCE7FjYdtJWaicov5rkEI43zF2C6xaaS6+YPV655tcQYvSQnTVPzRAN7q76fi8AL29l+24lrZFPvO8FuuimHEpA/O18DlUYo2Y0JQRBczy96Ny+Eh+JGUB5+V+qw3iCX+mwsiILVlMrroVdrMr8WIda4qdWC0fGwroZ70W6AiscwxT4Hm7lUGyZVA+Bxm5UXapFlv9WuhkNPKsgfWKZXzQ3akSqO7ggSxctj2ZxzwS9dBfNOipGtcrXwU1uQbpRL1bsx2qqcUDwIC70e2OGj+X66hsEi3zIvZCHGYaeZfCublIAdNyAAqj+JQMJcn+eLM/ds36r3843hjdM2dYRRJgiQBraxiHiHtQIZ5BKTuJZacDxowdO49iUP0N2D9RrhY5dzftLvV99foEsigQmX5INtGD0wclwh++Hadi0YjfJc/1XTivfY+Dwcae0Z48f+ipNAX9UV26sdDkostxX8mPH40f6ilT3sKdNFjCCtRq8H73JQZgTqWOzUIbqTVIcXlStLYLcf0e4jA86QFs/vLAd+dHGl2t7Zrs1VJciZgJQOnhWqyhj9eeZnpYzAhqMSfiMtBHZcQkuo9IV9i93PjH+jvWhTNQz0iMbg9ykp9AK/eh5ErX21emiDpJiYm5K8xwtfpS6KiajtH
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5951.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(39860400002)(366004)(346002)(396003)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(31696002)(86362001)(36756003)(31686004)(41300700001)(6666004)(478600001)(6506007)(53546011)(66946007)(54906003)(66556008)(66476007)(26005)(6512007)(38100700002)(83380400001)(7416002)(2616005)(2906002)(966005)(6486002)(110136005)(316002)(5660300002)(8936002)(4326008)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a0FwZEE0cG5BQUlSTWFqZXBueFpIc0ZsZG9icmV1STRhUlp3OFM2OTdIc24z?=
 =?utf-8?B?NHVRempDSHNnRFhmTy9IaXhyWTNySjBsTTlVSXdPWURIdXhZQTN4ZVRIbUlj?=
 =?utf-8?B?cVNoVzJwckcrTi9YWGdQYXJ3TUVaSTlCQU5FS1Rsa2k4R1RkWXY4cEJRNExz?=
 =?utf-8?B?Q0hTTzdCVGhGVEkxVGlwWCt6Q3VMdjdjZlRwMGhsMVJqL0hlcHFkWkZVeWlG?=
 =?utf-8?B?NU1ZVlNCajlZMDhINXkwa2h0ZTJjMFRLaEw1d0ZTeWs1d2pkQXNsak9vS096?=
 =?utf-8?B?cTBRRG4zWFdPSlJZVEtVTzRpMHRtSExTbmNkWWx4cVhWOXpJS3k5Y1BIVW1Q?=
 =?utf-8?B?RCs1czBRcGtRUjZ5MHpsbVk5MHhXWUFYT2xmbCs5cktJbWtyNEMyOXdxVVRH?=
 =?utf-8?B?Sk10YnlyUVFZMzJNZHNoUWxvTjBlSmhNYVdmcVIra0Zrazd6a3N5WDdDWmlj?=
 =?utf-8?B?ZC85VFdpQXUybTM0QVl5enRxdGJST2l6NHJ5OFJKZURwbnZyN044dCs2cS9y?=
 =?utf-8?B?QWxjSCtEVlE3cEQvM0lETFczaUM5UWU5YXAvbDhZTEJHU2pwczc2aXhNbkZa?=
 =?utf-8?B?bXZDaGEwY2ZVOTdvSFFDZFYxQjdoTnNwR0MyM08rUWg0QmlMMFNXU1czZE9T?=
 =?utf-8?B?VnM3SEJHNndIa1BTbnMzNjBHSDJWK01NNjlKaGhaTFpaNzBpMlVXOUcwa0h3?=
 =?utf-8?B?c01rRlJVbHJ0SE92WVo1UGg2bzhiKzYwbUYreUNpVytsakRUUVpqZkNmUXoy?=
 =?utf-8?B?ZmF6NmZGbUhvRWM5N3RNeS9WbHo1MkJ4aFhIUU4wRW15SHZCaUJUOCs4MHh4?=
 =?utf-8?B?dDhIUTFzL0FkOG0vaWJKQUZSeVc1Si8rc0RTWGM4TEVqNHZrSXNoblR0TEJE?=
 =?utf-8?B?a0JKQUhWRzhsZFFhc2ZkWFlXWkZoU1V2aUhIUC9MdzdPU3dIaU9YNHZ0bWRZ?=
 =?utf-8?B?M1M0b1JkT1FZSGxoT1BrQmpJaUJLektBbmJtRjhPN0xnTGpRb3RKWUZYWmRi?=
 =?utf-8?B?ck5OZEZzcDMvQk1IeCtuQ01iNUNBRVpYU3ExeUlhQ0swbFpSWklXNjZybFFJ?=
 =?utf-8?B?Snc5UFFHUm5oSFFWdTlIRW5YRDJpVUQxRk85S1g4RTNrTG9TNEY5ajM0d0tB?=
 =?utf-8?B?S1VPY1lzVFBtRFJSUTl1bVFrNGE3M0xiME5GVVpKT3FaYzFvSDJyMDNybW5U?=
 =?utf-8?B?aGh2SmlVbFNjNmllY2pkekw4eFB6NHd5T2RwODJBTDdxR1dpUERsQmptZHdW?=
 =?utf-8?B?Q0JxSjdnejdvWnkrdktEZVlWS0JqN2lNTzdydFFBaGpWb2hqRDcrMUlnTllh?=
 =?utf-8?B?YXQwTVVPdnBHOVpnKytLTzk1OFgzN0wyZ3lMZVJYTnJBWGIvZzVJbzBzZHZw?=
 =?utf-8?B?aU9QbDRWNHhSNWNmajlVeU1rU0hjbVpBWU1FN1d0VEpQS2RQNWRkRUpUVURn?=
 =?utf-8?B?Y2hKR3d6K3NVMlNDNFFkUXFrT1BSNmQxOWtTQzFoRnQzTmdSMWFDaGdoS0s4?=
 =?utf-8?B?ZE9qenNpZ1lSSHArRlVGQWR1d2pRdlpjcHdrMFA5N09YSFFxbnRXVWtKdHAw?=
 =?utf-8?B?QUdXTFlGVXF0UzdTbFhNVCtKM2tBSU1hdjZqb3dPRnA3cjQ1UlZGNDgrRHNy?=
 =?utf-8?B?cVJVNVM5OFRVemI2RUZRQ1ZFQjZIWFoxM3U3UFgzVG1MdzdFWDh4ZjRQOFkz?=
 =?utf-8?B?UDRueFFsRE53TlZSZzVJbUNnWU12TXFaZm9UQktqSy90RE8zb3N1SGhHMHlh?=
 =?utf-8?B?UnNiNHM5bWNPOGVteWhvK1NxNUxkVU4vUzRVNmZ0UmJYN1RmS1NqUXYyTEU4?=
 =?utf-8?B?cFJLUHhDT1NmeU9DdFMycXU3SjRONGUyQlZoRENIRGp2QWdlOFRvMHFrbEs3?=
 =?utf-8?B?QXhhbkVZTTNQYlVBUjVCbHBrQ0U1MDJDTFhWSUtWeWpzV2I2aEg0VmMycHlp?=
 =?utf-8?B?TjZUTjI0YWFWdmFBV2NiYUpIRVBvSGlQb1c1WDRiZEo2VSs2VkhYNkpkbHdw?=
 =?utf-8?B?ZERXdGlJUHRMVFZlNlhrYkhmeU1zMTk1Nnp5cXNkTWk3MWhNOGFqZ3puQSsw?=
 =?utf-8?B?bHZuWnFvcWlXaXV3elVHZ2lCNG83UFd1REVEc1QwNU1LalFldGJiRUZEZGVS?=
 =?utf-8?Q?LgvCCmjXW3VpV6JzTyJJagsjP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87ab0af2-e0bf-4426-b602-08dbfd5460a9
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5951.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 09:58:24.7233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X+zlk1LSnf55pXvsoA+9anacTN7oBswgo2dykE8BXcLZDSJSaV063gSxjjmYX6xanoL+3ToeUu1kId1wK7k/Cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7961


On 12/14/23 22:12, Cristian Ciocaltea wrote:
> On 12/14/23 15:15, Venkata Prasad Potturu wrote:
>> On 12/14/23 17:53, Cristian Ciocaltea wrote:
>>> On 12/11/23 07:58, Venkata Prasad Potturu wrote:
>>>> On 12/10/23 21:20, Cristian Ciocaltea wrote:
>>>>> On 12/10/23 16:01, Mark Brown wrote:
>>>>>> On Sun, Dec 10, 2023 at 12:12:53PM +0200, Cristian Ciocaltea wrote:
>>>>>>> On 12/10/23 11:51, Venkata Prasad Potturu wrote:
>>>>>>>> This should send to SOF git repo for rewiew, once SOF reviewers
>>>>>>>> approved
>>>>>>>> this, again need to send to broonie git.
>>>>>>>> All the changes in sound/soc/sof/ path should go to SOF git.
>>>>>>> Unfortunately I'm not familiar with the SOF dev workflow. So it's not
>>>>>>> enough to have this patch cc-ed to
>>>>>>> sound-open-firmware@alsa-project.org?
>>>>>> The SOF people basically do their own thing in github at
>>>>>>
>>>>>>       https://github.com/thesofproject/linux
>>>>>>
>>>>>> with a github workflow and submit their patches upstream in batches a
>>>>>> few times a release, however my understanding is that their
>>>>>> workflow can
>>>>>> cope with things going in directly upstream as well.
>>>>> Thanks for clarifying, Mark!  That would greatly simplify and speedup
>>>>> the whole process, at least for trivial patches like this one.
>>>> Hi Cristian,
>>>>
>>>> We have created a Pull request in SOF git hub for I2S BT support.
>>>> please hold v2 version SOF patches till below PR get's merged.
>>>> PR:- https://github.com/thesofproject/linux/pull/4742
>>> Hi Venkata,
>>>
>>> If this is going to be handled via the github workflow, this patch
>>> should be removed from the series.  Since there is no dependency on it,
>>> I cannot see a reason to put v2 on hold.
>>>
>>> Do I miss something?
>> Non-sof driver related patches can directly send to broonie git ad v2
>> series.
>> SOF driver patches should send to SOF github to avoid merge conflicts
>> as  per guidelines of SOF community.
> Honestly, I don't really see a high risk of conflicts, the patches are
> not that complex and can be simply cherry-picked when needed.  Moreover,
> as we already had people reviewing this, splitting this up will only add
> confusion and unnecessary burden.
>
> Are there any specific changes you are concerned about and cannot be
> really handled here?
This is not the concern about this patch series,
Generally sof driver patches sends to SOF git hub as a PR, these are the 
guidelines by SOF maintainers.
If you still want to send alsa devel list directly, please discuss with 
SOF maintainers.

