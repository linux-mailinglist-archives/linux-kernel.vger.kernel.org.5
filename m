Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A56D8131D2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 14:41:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1572941AbjLNNlH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 08:41:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjLNNPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 08:15:51 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2043.outbound.protection.outlook.com [40.107.102.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 609C310E;
        Thu, 14 Dec 2023 05:15:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kN5hio25pRjV3ZZGbtf0LlV9bLSjlJJCP9HXzCMwxX5KOpXUbmbxayDL/0Cg0iA+UquRgGP+pXmmc8vOib8g+6UQ0bA5acyjMFHOmRwR0iDml2/KGFQbhA2bgwoLUEmyEm8rpSAjSeEwPltMFe9vXbyybEPJBLuOyex8lww5MjQJb0qD9xX/U77+bvumVw8JlaYXN4Ql1UKRpaiJGGP4Kph2Q7+dbDWUWviMvQ9UN5rIcwXbjOgrM/OG767UKdCVd6Gg19mM+sBN819Td2GLT/f5bj25tbVRVFTJURtFPJda0FYyWZZzX5sgwrxOb+T3qrik3kH3XPanyyxLgZpH5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BH//SW8obKaUXKpp6BuhZaDI+4MxdWZ/8HgXxpaBW3E=;
 b=TxhVfpHWgWJExpRzigIdlk6TMAxwnONQY5XZds0m67tC0bXXX4OOD5OFcw4l2UPvRMTl5b99C85sSaz3INkElhLKAFXNxI/mDRUeRzAmAVG20f1UYsoD4Bb4od17RIkmPTwik4XQmF2rVGwMeK0/IIe3c3mCvzN9VooqJWB/jtEZDiud3n/AdnaHLhpAc5ST0GseLG7z/ZKOs5SY7Wz5fO2qoYcibCK17Oq6nB1wmmG/ntnocC79b3edDf7tRLSz6DHFmQEWrCc9jXv9Bqn+2Szf6E+oK0uZRiCQ1tbKcTfC6sIrLG/WyKrLojZZMSjjHkXUJd/cimArqxwE36Bq6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BH//SW8obKaUXKpp6BuhZaDI+4MxdWZ/8HgXxpaBW3E=;
 b=vRi16wygtTDoWGD4w6UqmcVTm4Yr2nHHTZBTcf2v4IE93eyMUXkqYk1ujYIb8ZvdJgwS9VIBunG3WoBzgEghekLIRQihz7CSvuyMgto40esOab3fMAUi2xoSGvmYhtEFQ4EW7+G2m7zXed1u961IsPAg0r7ql4oYTuDW1iUzib0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5951.namprd12.prod.outlook.com (2603:10b6:510:1da::16)
 by CH3PR12MB9021.namprd12.prod.outlook.com (2603:10b6:610:173::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 13:15:55 +0000
Received: from PH7PR12MB5951.namprd12.prod.outlook.com
 ([fe80::e007:72f7:4102:9258]) by PH7PR12MB5951.namprd12.prod.outlook.com
 ([fe80::e007:72f7:4102:9258%4]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 13:15:55 +0000
Message-ID: <0de8f81b-e7d4-43f6-b011-eb6ee09cc7fe@amd.com>
Date:   Thu, 14 Dec 2023 18:45:42 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/11] ASoC: SOF: topology: Add new DAI type entry for
 SOF_DAI_AMD_BT
Content-Language: en-US
To:     Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
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
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        sound-open-firmware@alsa-project.org, kernel@collabora.com
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
From:   Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
In-Reply-To: <ca828ee1-93f7-432e-b95d-e67c35cdcdb5@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0191.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:be::15) To PH7PR12MB5951.namprd12.prod.outlook.com
 (2603:10b6:510:1da::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5951:EE_|CH3PR12MB9021:EE_
X-MS-Office365-Filtering-Correlation-Id: 1711bf00-f4c3-4d36-3615-08dbfca6cd99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6xEikv2bYaHgS+Hkbqur3p13M4ldTuWaA+p0NxBLU9VldSjV2razgl0MZWJMybDn6vlJ2vIRHwwDy9lHs8lDlJIeZB+muyPnkGCz7p356++2EPXAkRPsSxasqRckr7eh1DRvYE0cPJ1XOkeZBBC72u+Q1PqKPfj2O2ziIm3jCFgRMYW3U7eJZUEPpPqyvsDkN/zHDgOUmqe55Sn2Jj8EmOvCZUbPQJnhiTQIrnEuA/OGqeEH1s1y4UI6ORRmwXAB4P71+BlMSde9RgZLc3YJN3tmqjMP2IOiRz1g4msJDSeaQLFMB4bbCw0tMy0B3GJKdIZu2oGHlsNGqLsVp0a+PnIE46Ia9XhYy+x8ef5bj5vbf3ek9aWQZ0Kr+aFds2OErfVlqaHetHP5tYBzz4h3m2imWvu2NWkLtlUA7HRArwjsIzQFHSP3OLZREFqZAi8BW1bforgHAWSfEkChzJl9rX1cABRvZYRfXeueQnGHpR+p5kEuyX6M5LRC/jVHZv1zRS1EhPBFstLqNzF0ZOeJcClW/QrmKWwJkzIEPFnwUdWw+NWh7XhJ7mu4HukfSpI/F2CNHpARbFjE0IOBwLcKsgx3qiijdhgau48tmYW7y9qTRyySSb3aQfJTdaT0s2KUTN+sR7rItOQISdBbp0g/S6g6EQ//NwsezEnsAFHAPvSy/okU5nCRjqKg96DIXd9H
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5951.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(366004)(396003)(346002)(136003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(66556008)(110136005)(66946007)(54906003)(66476007)(316002)(8676002)(4326008)(83380400001)(6506007)(6666004)(6486002)(966005)(478600001)(53546011)(26005)(2616005)(6512007)(8936002)(7416002)(2906002)(5660300002)(41300700001)(36756003)(38100700002)(86362001)(31696002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mi9ZdE0raDU1QUNrZnNyQjJUOUgyZFJXUzRFVmRZYi9PRm45MVZoV3VoTmJz?=
 =?utf-8?B?TWpydVlEVEJ6Qmp2K0xndzQ1NHcrVXRsdlBTTnhLT3JDWmN2RklRbi9zUzlw?=
 =?utf-8?B?MkEvMXFHNWlVZGZZZC9HN2hNajQzMkFVcW1TVThpeFQxMytiN3daNUNEaWlW?=
 =?utf-8?B?bDI5R0hFM3dyVlVrQWJvZHFCWTRINVZWeVdYdXVlbUcyZnZCOWdXcXdNV0lz?=
 =?utf-8?B?YUtrR0dNSStwY3VrcTg0K2pndFRmZTh0em4vdnJpVDZYUllTcFd2cGVVZ2Ux?=
 =?utf-8?B?U0lZMzNQc1l0bG9YSHAvOWpQby9yUXlpbXNJYnBCUHZVUUN0Y0JFaU13RWRj?=
 =?utf-8?B?YTZnc3pEOTE0N0o1Tml3UWxMdSsyWG93S2ExeE9zMUxhSzAzcGhHcTBIbEJJ?=
 =?utf-8?B?TEVOR2llQnpHSERaZzZuLzNJYllpak9xUkZhY01LbFhqMnp4Q3Z0eE9BRFdl?=
 =?utf-8?B?T2pNMEYyVVhZNk14THNFTnNQdlYyQzk3MkxwV1NoKzBuZ0M2a0h6cVJncXlh?=
 =?utf-8?B?NVRmb2pwTkgzZGNwTVJ1RTQ3LzIxRGJQeG1pUlJ1YmV4SkNXckozY2hkQ0cz?=
 =?utf-8?B?QVhLOWFaS29UNjBpTS9kZmRxQ3lnRVVWUzMwVDkvQzVBenJZV3dBakFCSlAx?=
 =?utf-8?B?bmdMci95N2hRMXRpQXc0NTFsTEtMUURWUTZpaG1wSUwyazJxdXE2Yms2d2dO?=
 =?utf-8?B?NzZnMFQzTnY3dmFqcE5sVDlNZVp4RjlkZDY3RHFZOHhRSjFjZzgvUW1BbzFR?=
 =?utf-8?B?N2M2SnV4MXoxU1cxeG13TU1JdTk0ZWJIWmdxVVFacXVVWFoxdTVGaWFiVEUx?=
 =?utf-8?B?WEw0QlltSWNxdlVtd3pTRG40SG12cThoMFlRWDJhcjlzR2pwYTVScU04Z0hr?=
 =?utf-8?B?U2t3OUtKczdOVm5DUjBQTHoxd0YxdnBXc2hZVUlVcmRGVnM0cXZvVGhCdTRz?=
 =?utf-8?B?Y3FmaHc3S045dVRuSGlnc1g3V2E0aitBWUxQOUlkMmFOM2xtRzZneXhZZEtT?=
 =?utf-8?B?MjhNeGd4SVQzejdhUFRHUGl3bThtcVo1bFlKc0tNbUxYZ3BySUw4RDNqVSts?=
 =?utf-8?B?bGYyVHZ2KzRzN0xMK0ZaQTlpeVZiSEtQb1g0N3VIdzdaUTNLSUlpMWNlRE8w?=
 =?utf-8?B?ejl2OHNITHVnT29wdk1RbVkxWXd2Zzd0NGFRQ2FZU29RYWFVZnNLRnVyeEFO?=
 =?utf-8?B?UWtwU3FJSlBjSXpQcDIwRUhWS0RoQ1FINkt0M29ZSmVNT0J2b0dXMVRaelBp?=
 =?utf-8?B?SXI4VUMxQ3gvVVJmUlFjRWROZE1WTHM0UkRzejZrbHlXMGlCMjRUSmxOYnJ1?=
 =?utf-8?B?dGFMeWg1emRhdU56dEtaZVY1aXdvZjB6WFFGc0Rsekt5ZUk3eDUveXE3SjV5?=
 =?utf-8?B?Q3NSZzU3cEkwWEVZNVE3V3ZmRVdXWTY5QzltMjBYQzNJakVnaThUMEp0OVVF?=
 =?utf-8?B?dTB0WXpTZ25YRGdZV1prV2tvR3lVWjRsNXcveDV5M2tRWEdNQzFWeFlXRk1r?=
 =?utf-8?B?SzdqVjcvMVd2dE1KeHIvTGZUdG00dk4wbEduVEhWc0NFejBoOXdYaEhTUlpB?=
 =?utf-8?B?b01yL1J6MEo1NXdWbmp0RFMzUkF1UWYraTZUVTNJZy9oOXhrYjBqZVJocHBk?=
 =?utf-8?B?L1QxVzRHMEppK0txRTRxbXU2clZ1VThGSCtYQldGRllWc2dnb2xwWSt4ejkw?=
 =?utf-8?B?NUNKa0NzV1FmWEhyY3lrUWt3Z3ZFLy9GL0YwaGl2R3M3MWdSWnhjcjdEZDlB?=
 =?utf-8?B?UGdCMHpqR1pzaCtTT0dtMGk3cDF5SldFNGs1c21ueXpianVjSThCZTU0dVFi?=
 =?utf-8?B?cTFjQXZTSDJ4cEtHYnA5Zi85UWJnWVFXVlc2UnFqcUxYTGdzOFhjcWc1b1VL?=
 =?utf-8?B?Q04zdWI4aXdyamJ3dExhTDhXRllZRVdWWUwyNGlYTUc4S1cvTDBLb29jZzZU?=
 =?utf-8?B?Zit6Y0FpblZzU1NHWWI4ZUlLd0pZbXV0YXZ5TXVydUYwdGJSa0VyYnR0bU4y?=
 =?utf-8?B?emlxZC9DcUtCZkF5SXNsekN1aTNsWi9xSDlkRkN0ZGFqWStVK3VPajhTMW93?=
 =?utf-8?B?aitDY3dMb2VORzhPVHdUbmNOakYydnpyNEd5Q29YUWhzUkZxZ0ZacUxKc0NB?=
 =?utf-8?Q?COjBveF9vhASh3uuRHhjveEwt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1711bf00-f4c3-4d36-3615-08dbfca6cd99
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5951.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 13:15:55.1008
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ge/uq+mDy+ytXh9YR5BgQnP8vm6V/kopcJCIUdG+uqlxelc66hjwiexrd4gbYSyP0nD3gZmfbdWhM8d1nJLxsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9021
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/14/23 17:53, Cristian Ciocaltea wrote:
> On 12/11/23 07:58, Venkata Prasad Potturu wrote:
>> On 12/10/23 21:20, Cristian Ciocaltea wrote:
>>> On 12/10/23 16:01, Mark Brown wrote:
>>>> On Sun, Dec 10, 2023 at 12:12:53PM +0200, Cristian Ciocaltea wrote:
>>>>> On 12/10/23 11:51, Venkata Prasad Potturu wrote:
>>>>>> This should send to SOF git repo for rewiew, once SOF reviewers
>>>>>> approved
>>>>>> this, again need to send to broonie git.
>>>>>> All the changes in sound/soc/sof/ path should go to SOF git.
>>>>> Unfortunately I'm not familiar with the SOF dev workflow. So it's not
>>>>> enough to have this patch cc-ed to
>>>>> sound-open-firmware@alsa-project.org?
>>>> The SOF people basically do their own thing in github at
>>>>
>>>>      https://github.com/thesofproject/linux
>>>>
>>>> with a github workflow and submit their patches upstream in batches a
>>>> few times a release, however my understanding is that their workflow can
>>>> cope with things going in directly upstream as well.
>>> Thanks for clarifying, Mark!  That would greatly simplify and speedup
>>> the whole process, at least for trivial patches like this one.
>> Hi Cristian,
>>
>> We have created a Pull request in SOF git hub for I2S BT support.
>> please hold v2 version SOF patches till below PR get's merged.
>> PR:- https://github.com/thesofproject/linux/pull/4742
> Hi Venkata,
>
> If this is going to be handled via the github workflow, this patch
> should be removed from the series.  Since there is no dependency on it,
> I cannot see a reason to put v2 on hold.
>
> Do I miss something?
Non-sof driver related patches can directly send to broonie git ad v2 
series.
SOF driver patches should send to SOF github to avoid merge conflicts 
as  per guidelines of SOF community.
>
> Thanks,
> Cristian
