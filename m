Return-Path: <linux-kernel+bounces-28513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC3A82FF85
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 05:18:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EFA2282FEF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 04:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1CAC6FDC;
	Wed, 17 Jan 2024 04:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XD4VMnXs"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2080.outbound.protection.outlook.com [40.107.243.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC304522E;
	Wed, 17 Jan 2024 04:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705465103; cv=fail; b=MyIWc1FcYmIHtXWadFargsXWEOL+maBQwGxN5FJoIfxqgFFeFT0VHrcrHrvToGCBMzoEm3L91Dkvtamf1ZjQLNp7AFXz+MzMNqxzmEsrwroa5jEnsKKOV+/przFi5UDvq7FZgjBaoA/4A91x8scX89aE7cNlEV9KuV117p2BFTw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705465103; c=relaxed/simple;
	bh=4JQLsY9cX+4DmUzkADGeB0+Ith69q8tVPg05DaWR9wA=;
	h=ARC-Message-Signature:ARC-Authentication-Results:DKIM-Signature:
	 Received:Received:Message-ID:Date:User-Agent:Subject:
	 Content-Language:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=BgR8pLEEvs4dy/BzLO3HdL8MZDkPw13YJLHuuJXJ6RTmlPxmZfVTnWIR1Dh3MQbb7nUP5kK0a/luWrzqsycPPHftgvMdkbyJQYeY/U0LWTCfe7sZCuvEnXJnWhZyWByTQj5ZGqtiw9vs5/jgUn8v4SvR3oWo7LX4JzOWeNonVdk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XD4VMnXs; arc=fail smtp.client-ip=40.107.243.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lr71aFp7UijNTu91mQoPfdZgBfMDcMYFx2Bt/lDyn5jzXPpThbUDPg4C+KaY/tSkh5oFBrbQNM8luQxo9KyfiU7c3OfOWnp3en++y1NP/emWvj1WpKL1dFFNCfMjWrUvZfA20WD013XB+1/ddufNFLfC16Zsys80+BWDkHycFXKAJnGf2L8sNpBxMa57KpgjW9wG+S/lLkoMC++5AYhQSP+9g0FAY4TEu8m4I880Thryy7afSq4ltJruwY+HjJmIvsKZpTrvXRSgdeK68AB+ecYiv8MQhzfHhZwDtwUX8aIyYtNpRWnfFSbyRPvfc5vWbaSlL/NDe37Y3sG/AwVwVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r+LdiP284hQSpXTR3cpbcjM3mqB2LluK7C+u1uQIQyg=;
 b=cpq/4LpA5zUBas0kdugJRYPSfI+7t70Xo+qjPK6KBV5QGvDP5F8bu7WbV0mQmcVdkdFZ7qBhYN1JrV3BU3P0BtD9PJlXvJmOVMJjoH0Cid41X6apXZM6U6CzG2rd2396dE9BAVt9WZrhDOqdkzjDvvPZvGsYWCETS1hnUdEGTwokqG8SwjFkvqLT1YvxNVxXxFTrccqd0UIyckXGoMKMvSZ2ErkyaOhZdNJInlfeZLREC9sEbVTpqcT8I62GTeEtWS5mu65xfxWWI6FAPTjrGe0IP8CHPOE4ZcmEwgYq5a7VzYu7GIWmXsm4ANBUwJVfTh3y8FhCjWsYIZVzgPcreA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r+LdiP284hQSpXTR3cpbcjM3mqB2LluK7C+u1uQIQyg=;
 b=XD4VMnXs9ZNpGJffNDF9hL4uxy/PjO41DhIDC3orFwPFWQHUsyHN5jFcdT04agz3+RT3tn/5ZCQ7ddgZYSfQMzO7+dkQPgZ4XHw+QDLkCox1kbhP9oPzfqZcnSKE8nCuTppwHiElp62yMxynHHvVsHATzvgek4u82DA4g0wJpF0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SA0PR12MB4495.namprd12.prod.outlook.com (2603:10b6:806:70::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.28; Wed, 17 Jan
 2024 04:18:18 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::ce8d:7121:cb06:91ba]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::ce8d:7121:cb06:91ba%4]) with mapi id 15.20.7181.029; Wed, 17 Jan 2024
 04:18:18 +0000
Message-ID: <045bf616-f69b-4253-92ce-05744d72b084@amd.com>
Date: Tue, 16 Jan 2024 22:18:14 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] wifi: mt76: mt7921: Disable powersaving by default
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, Ben Greear
 <greearb@candelatech.com>, Lorenzo Bianconi <lorenzo@kernel.org>,
 Kalle Valo <kvalo@kernel.org>
Cc: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>,
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Deren Wu <deren.wu@mediatek.com>, Ming Yen Hsieh
 <mingyen.hsieh@mediatek.com>,
 "open list:MEDIATEK MT76 WIRELESS LAN DRIVER"
 <linux-wireless@vger.kernel.org>,
 "open list:ARM/Mediatek SoC support" <linux-kernel@vger.kernel.org>,
 "moderated list:ARM/Mediatek SoC support"
 <linux-mediatek@lists.infradead.org>, Sultan Alsawaf <sultan@kerneltoast.com>
References: <20231212090852.162787-1-mario.limonciello@amd.com>
 <874jgmnud8.fsf@kernel.org> <ZXmxD1foASMaCDIe@lore-desk>
 <d92c081e-47dd-5c57-a6f1-bd72b2748141@candelatech.com>
 <1ef12773-74ca-489c-b36b-d3cf7da22c43@amd.com>
 <e0fbe9cb-22de-462f-9123-14a220d5a9c6@gmail.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <e0fbe9cb-22de-462f-9123-14a220d5a9c6@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0049.namprd11.prod.outlook.com
 (2603:10b6:806:d0::24) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SA0PR12MB4495:EE_
X-MS-Office365-Filtering-Correlation-Id: 44743a7b-c107-4006-9aca-08dc1713551a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3j3gNyoUs3QcJ7Qzb6axz2g2HgJoyUjcDZdOgxV+SfTmll7gN8lv+LQLu1JEZG+ITjdssFI90jS8hP5TfPNRPGU7L0Tn6EwAWcfLtsCj0Bjw6dyRrBppmvFHuVq0tynA1k9PuCbouMbiFSgJIekMKUttK2aOiYviUecX2DdJx+pQ58AuPHVHRXotdPzurwv6mCHcEKUZ7bIBA8KCtHeeApiDTh3Rkg8+cVRysbnox4em2aPZeSxeWI06zTyqfEeaAwNJ0mCwTjepOcWVXAKhz7Uo4Dk/oL1rXzyvmJQcuobH2KFZR5lJvSCajP/zZFX7pRZEHdua/hvQ4+/MewCB4HmTdXUunknZfvZx3XS0ypkaB27e+YBZp3mhL+tgnQcrOWS5DU6ulICrKC0Hpn+PqOIEI1WblVYjTbXpep469x2/8V0B2i3r7WADWfcqs8UsYnfiTbqs7hp+a9wrQtpHyef4OPxQqEVS/CkEGlbwA3GG++cHd4up/fp+xmQd2dJqHuzIohXDLaSn+Grbz4H3j2NAsPtPH6qMeI4Q3gpbfD/Wz7SXNDWjWsF2pvy1DAVviHjsvrxSvcsaYDmCmymsEeH5Oc3BtFRtOSiW1oaUEIKDbPflwqrmE/4GY5/e0pKdh6Nc26mqqq8jx9GRzwDmMQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(346002)(396003)(39860400002)(136003)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(31686004)(6666004)(83380400001)(478600001)(966005)(5660300002)(4326008)(7416002)(6506007)(8936002)(316002)(66946007)(54906003)(6512007)(66476007)(6486002)(66556008)(26005)(110136005)(44832011)(2616005)(8676002)(38100700002)(53546011)(41300700001)(2906002)(31696002)(86362001)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RDR0UVloZ052Tm4yR2s2Q2VtNWEwQ2ZOd0JJMjZxN3dRTURUb0FuKzhVR0JW?=
 =?utf-8?B?S0djWlZBM2kxV1EvbW1yclhIUmpLUjBObXI2UlZTcHpielc0S2RySGhDUHov?=
 =?utf-8?B?bnlCNllTM0dYaS8yMzFzNWs1UE9oR1UxV2tNSGR3N2RqbmV0RDFwejVOa0hH?=
 =?utf-8?B?RlBKa01KZSt6bnEyaVdMR3VyU0JtK05LWkJ4OUttRlJjbFpNOFFBQThSdmpR?=
 =?utf-8?B?YWFJNHJ3c3cxV1NSTHk0STdQVGlCRGVIUGFkRms3U2MxMnl2ZFdUTWhraXU5?=
 =?utf-8?B?bWxUYTE1by9TVHc3d1RBUVUwcklVbHUxWXlUVWlFakVFSEUwSnZpWHV1SURv?=
 =?utf-8?B?dnp1bTZMbWwyZkw3K1hPYmtpOUhwTWVUZlRrNkdLV282bS9ueXIvWUdhZm9J?=
 =?utf-8?B?S09YTGExZkFZS3hQRFIwS1JOY1FNazZtMjg5MGZNdHVXK3dEcFRyQ1NFUEpv?=
 =?utf-8?B?SVhBcmpsejBTVlBBcnJ2VXRNYmxCSHdzdngwRFluYmZPNHAraVkzOCtrTWFm?=
 =?utf-8?B?SGRxbmJRS2ZuUkJYM3B5d0MreFNPV1NlZ003MTFmSldieHVCbGROLytlOFZU?=
 =?utf-8?B?blRqSUlJeU12ZmVZd0Zwc1VNU2JLb0ZiQlZqeG4xWjlQWXRCeDZscW51MGd2?=
 =?utf-8?B?N25KUUloOFBMWmRVSmZFVXR0b3c0WnVidjlidE8rSks5UVR2dzNVcW9HSml1?=
 =?utf-8?B?alhKZ0Q5SmQvT0s5bFlTZlc5WVI2b042TG1MMXdWNmt5SVFWNkROMjloU3hh?=
 =?utf-8?B?OGw0YWl6Z0M0a3JzZ1Y2QkhPY3dOQis3eFVBOWFJL01NZmg2SG5NeklRZUJ4?=
 =?utf-8?B?bHlUekN6R082RGJBL2pNWXlzRk15aU41QlUrcERaeWlyTlJ3d2FxTnVwTXJ0?=
 =?utf-8?B?bTZhUUZNVGlTVlk1VTRnMXcyNU9BZStKa24wNzltZi9WU2dRNkk0dmIzd2NZ?=
 =?utf-8?B?Q2M1V084TFJzL2VTaHlzQWw3QkFPWlZMdytYVXdHRzRZQ2dTT0toU3N3MnFW?=
 =?utf-8?B?S1RBaFZlWVdQajZDeXJsVlBlT1JzeXBKZU1pTDdZVkV4RmliWTM0aEZhclB0?=
 =?utf-8?B?SVVTRFFuSEdMU2pDVVAzYitTa3VKQTFZZ2N3Z2R1d1NURHBwbmthTWdRSDZv?=
 =?utf-8?B?TFd4TXk5ZTAyeFQrZlU0bFVYVjlTSmVHSG5NMXlyTVlNbngrMzJSRVhGaUxZ?=
 =?utf-8?B?S01PMllJMTJUVXRzb1VvTmxubWUyRkVYdHZBQTFqaWpMSU9mN1ZTckZQVzRx?=
 =?utf-8?B?SEtlQ29oYlBHeHFBbm1iUFBYMHFKV2dicG15VW1ndWZsQS8zd0g2bXQvWkFP?=
 =?utf-8?B?czZ0KzhZNGlaQThLKzl2ZDR2SXRsNDhtQnV2VFlVd01sTlF1cUpGMkVySlh6?=
 =?utf-8?B?cG1TOWxMQXVvZnpsOExrc1FLcnlBUVdpKytRZWpwbE51WmJvQnBIRTJEdTdJ?=
 =?utf-8?B?QjRzMTN4MGNmZzJoWWxOSFdWRm5jNFVRemw0YlU2V2FkN2Y3OUg4WkR2Vkpv?=
 =?utf-8?B?K0I2MEpINnE5Szgxb1JEOXVhZnJwMDZ0SVlhSVRQYzFWbzdEeU4xeno1MHpM?=
 =?utf-8?B?TVlIcTRwM0xsTk1SaElYTzR3OHhydUpReGpsWFJhZStsenRHL01SMjVDSE5K?=
 =?utf-8?B?WnFFVUpuQ1k2R2V5ak5TM2lOdS84UXlaMEg5SENsYnduZlFIY3QwWmhISm1V?=
 =?utf-8?B?ZCtGdTVmekY5akFPcW4wOURiMGYrTy9BSG4xMzVKUU9vekl5cXNKR2lDZzZs?=
 =?utf-8?B?cmxyS3oycXR0Tkw5MXY4dHlrdThUa1BSKzdQM25KT2kwV3JvNlRkMy95aytL?=
 =?utf-8?B?VjFqMmtCV1Z0UWpWRVcweSsrWWtieTdvWUl1cmtIZWZ5TEx5WWs4VmF3L3FQ?=
 =?utf-8?B?ZW1xT09peEg1ZzAxOEVxZjVWV1JFSjI1NjhSQ2FCM0JOQlpPeFVISXpnYWZV?=
 =?utf-8?B?cVI0bDJFVFRYSklGaG5ueVFRdHNqazBZbWtVS1BLN0YzalIzTDB4TytZcGRL?=
 =?utf-8?B?d2puUjRhaTVVWGJLdWwwazVaazdtLzB1SWNhamRBc1Z1c3MrckhVWjFFallr?=
 =?utf-8?B?VWlEVzF6ZGU5amZzR20rckVPbmZYOUF3WVVSWFJzRWxsblYyaXdpM3YwT3lI?=
 =?utf-8?Q?Q3QlrHh+KngpF0SBgkDQa3mHP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44743a7b-c107-4006-9aca-08dc1713551a
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2024 04:18:18.0764
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PBF5b1fdCbNhyEwIGWhUCwYm892srfy6kNU2Tdp+myjgjH9w6nuD8YHrI+ldOoNu3FPpqrmDPm0Kst+og+S+bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4495

On 12/14/2023 06:39, James Prestwood wrote:
> On 12/13/23 11:27, Mario Limonciello wrote:
>> On 12/13/2023 08:45, Ben Greear wrote:
>>> On 12/13/23 5:26 AM, Lorenzo Bianconi wrote:
>>>>> Mario Limonciello <mario.limonciello@amd.com> writes:
>>>>>
>>>>>> Several users have reported awful latency when powersaving is enabled
>>>>>> with certain access point combinations.
>>>>>
>>>>> What APs are these exactly? In the past 802.11 Power Save Mode was
>>>>> challenging due to badly behaving APs. But nowadays with so many 
>>>>> mobile
>>>>> devices in the market I would assume that APs work a lot better. It
>>>>> would be best to investigate the issues in detail and try to fix 
>>>>> them in
>>>>> mt76, assuming the bugs are in mt76 driver or firmware.
>>>>>
>>>>>> It's also reported that the powersaving feature doesn't provide an
>>>>>> ample enough savings to justify being enabled by default with these
>>>>>> issues.
>>>>>
>>>>> Any numbers or how was this concluded?
>>>>>
>>>>>> Introduce a module parameter that would control the power saving
>>>>>> behavior.  Set it to default as disabled. This mirrors what some 
>>>>>> other
>>>>>> WLAN drivers like iwlwifi do.
>>>>>
>>>>> We have already several ways to control 802.11 power save mode:
>>>>>
>>>>> * NL80211_CMD_SET_POWER_SAVE (for example used by 'iw set power_save')
>>>>>
>>>>> * CONFIG_CFG80211_DEFAULT_PS (for kernel level default)
>>>>>
>>>>> * WIPHY_FLAG_PS_ON_BY_DEFAULT (for the driver to control the 
>>>>> default setting)
>>>>>
>>>>> Adding module parameters as a fourth method sounds confusing so not
>>>>> really a fan of this. And the bar is quite high for adding new module
>>>>> parameters anyway.
>>>>
>>>> agree, I think we do not need a new parameter for this, just use the 
>>>> current
>>>> APIs.
>>>
>>> Is there a convenient way for a user to make any of those options 
>>> above stick through
>>> reboots?
>>>
>>> To me, the ability to set system defaults through reboots is a nice 
>>> feature of
>>> module options.
>>>
>>> Thanks,
>>> Ben
>>>
>>
>> Some userspace has the ability to do this.  For example in Network 
>> Manager:
>>
>> https://unix.stackexchange.com/questions/595116/wi-fi-powersaving-in-networkmanager
> 
> And recently added to IWD for this very reason, there are no decent ways 
> to persist between reboots (except when using NM).
> 
> https://git.kernel.org/pub/scm/network/wireless/iwd.git/commit/?id=29edb1626d88bb713db71f7b374d8f24832fd94f
> 
> Thanks,
> 
> James
> 

All,

Just wanted to update you that I looked at this issue again over the 
holidays and it's fixed by upgrading the linux-firmware for the mt7921 
that was submitted in late November.

I get the correct performance and latency without modifying power saving 
now on my Unifi access points.

Thanks,

