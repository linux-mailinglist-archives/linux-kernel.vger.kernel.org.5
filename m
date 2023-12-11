Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A82180C0FE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 06:50:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233852AbjLKFuB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 00:50:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233831AbjLKFti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 00:49:38 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2060.outbound.protection.outlook.com [40.107.101.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1B1B1FC8;
        Sun, 10 Dec 2023 21:49:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BddHzgH66AHHx/SlVPjN71RgvHULFe6DECC2BxpYV7peMUbyOiLipOGUwSOPI5G1y9e8aQbW5wTifLFOBVBIbSTEgCXcg0RAhu1iqDQPuj/hoq1qSXGCn6WkhkVLVH8o4+eYQQ1W5PReSwDlxu1ZeBaxANBcdzO3YAsEGHqcw/vAhQ2TlQKAu6sj0l5iNHlnaOr38LYhnq/6r5mkFdBZtraBiMVQgmA25gwMzA+mmakzKjb5UjmLn9+C2bXR9e6V7DfubcsmlN17l27nqiJn6ngZA6wPbN5ow4n67zjdY+j91IeMSFfyF+vYyLIZFnYMtIvx9h3bBnQFjo38POcG5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NzpjPwY0DhYAT3tdhaka+vKYDqUmYmMCAGTqGmF5CMY=;
 b=J2Ehb6uHb84jBy3o6ris3AvMq7uqy66YuGErGQiCs9jOyq/VnKwF6miQEguEgfYgtKzU1YKQfCppWjEXAg6kzcV4dLBwLu7aV+34kXes62gKSiouHxjeMam1Nra6OO2oCHvJKE/en3S4eFrA8g3e7d6qp3tTtFHoyxRvahla5dd4W4iX49xWgSo9U/fYui545sd6UGv0fpuyMgY5Md5Y63CBBwofqw2RBc8f9ZlEOUj1DedrLhJPwxJYiSFqsSon4L7PNCvkMNp7A9Ry2024V6HkdGqHp7HSBK9xSj2q+Q8bS7cO6cSJFmfbEJdtCuoF/AlZCKG6QQf08lfT4GUGTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NzpjPwY0DhYAT3tdhaka+vKYDqUmYmMCAGTqGmF5CMY=;
 b=pvXOgbQi9BfqAs9yhXv8yKQxCfxOBtQYxrGL869ymWuqhwNpdLTow8KJNEQXvLz21Ke39F0cwkQxN0vv7FaNgll1Zb2oPDkoLhQB/3jxKa5bVeXW1Fs0YhWzOZHiNweVwrzamSWIXE0MqTO9bZ9OFQEkWicMullYnK9mxZFZbLc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5951.namprd12.prod.outlook.com (2603:10b6:510:1da::16)
 by DS0PR12MB8368.namprd12.prod.outlook.com (2603:10b6:8:fe::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 05:49:02 +0000
Received: from PH7PR12MB5951.namprd12.prod.outlook.com
 ([fe80::e007:72f7:4102:9258]) by PH7PR12MB5951.namprd12.prod.outlook.com
 ([fe80::e007:72f7:4102:9258%4]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 05:49:02 +0000
Message-ID: <a3357e1f-f354-4d4b-9751-6b2182dceea6@amd.com>
Date:   Mon, 11 Dec 2023 11:18:49 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/11] ASoC: amd: acp: Use correct DAI link ID for BT
 codec
Content-Language: en-US
To:     Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
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
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
Cc:     linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        sound-open-firmware@alsa-project.org, kernel@collabora.com
References: <20231209205351.880797-1-cristian.ciocaltea@collabora.com>
 <20231209205351.880797-11-cristian.ciocaltea@collabora.com>
 <8a218987-965b-4228-b1d1-f7c061d553ab@amd.com>
 <391d2476-8f4a-4670-a248-8d4d9c46ee09@collabora.com>
 <1de9b77a-5737-40e0-ba3b-79c8713be93e@amd.com>
 <41e63870-ab22-45d8-b8b0-c406dbcb07f0@collabora.com>
From:   Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
In-Reply-To: <41e63870-ab22-45d8-b8b0-c406dbcb07f0@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0013.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:95::9) To PH7PR12MB5951.namprd12.prod.outlook.com
 (2603:10b6:510:1da::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5951:EE_|DS0PR12MB8368:EE_
X-MS-Office365-Filtering-Correlation-Id: adf52483-f04e-4861-29e4-08dbfa0ce075
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fAjSDHurroHAjwkQSJxLjlHSxFzautK1yp99i8BVF1tC0428HXtY1QpB6/ZMSeHY2jfVedj1KgTuX8lMwYG+GbJAIDLteNPSXYi5cboCv+TuNi2+ZBQp3W8AnP1NqLNiCTYs9yQ67t9GbhPN/iVmNFtxviMlGIiszxrpjR2hmSA1TgezYMQcHVIGNBb9adhg2eTxkE6Zrj+06r3snjNTmiIeZlGNWT3St7Xu3Um/gthC8OWs8to/2RZKJyNmVaGoQUEMsA4NbsojookKJi/RG0OJmNLgRNFqKVcQWBxV8Ja4jlCw6aoQubVgfjZJ6D2HxL4QfEjDO4SDLNll4vpQL41HWv9dyqIoH2qBVzqSdDLTk9aFux0jIAsX2GyiZFokX7IfIr1eO0BWaAaFLzxcC3Hssqcisnlj6Sny6UEFiq+5HFIpzqhrRq+jVpLGgyPVCWTGlAYDsaGDO1QzPp5kOvldycXIDkURkW3M+2zRtu8kSALy0qpdGLYMelC1V54a2gop87ghIKY+vbEiGf2KT+10+wOR+UnCwbbJmGmDjFDUEFVKrfquSgYoySBjTYLMD7TdnTwaYcwdFVwWjnxVuu8bWhb61oYgGMwT8rRNWOkZK4HXACxKLThfzbi+9OMhMwALISolKzWoJoqBBmmwPLjFsSHfXCPQdxIqpF2TB4A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5951.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(396003)(136003)(376002)(346002)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(6512007)(6506007)(53546011)(5660300002)(26005)(2616005)(36756003)(7416002)(6636002)(66476007)(66556008)(66946007)(6486002)(2906002)(83380400001)(31686004)(921008)(41300700001)(478600001)(86362001)(8676002)(8936002)(4326008)(31696002)(110136005)(316002)(38100700002)(6666004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QTBnSVN3RFRTY0FmbVd6ZHhQd04rL0tDWjBMWXI3M1d2YkhTQ0hYbmFrNHdr?=
 =?utf-8?B?aC8xOEsxOGdPYkF1L0MzbGxaakxnK1g3am43RDBvRE1PaFd4bGNYM1Y5aHFS?=
 =?utf-8?B?SFkxQkgwdXJyam5YdlpPbW8vWmVjeGVFaGwzVWNNUk00Z1VhQnlGU3lHRmMx?=
 =?utf-8?B?Yys2QW1aV0FiUGY3cjUzaEhhRW9WRktRL2d6NGRtT3Y0RlROMCtVS1RaaDRR?=
 =?utf-8?B?cS9Ydk1lTHJKRTVUK1ltQ1FEeXRBNzJiSGI3dDNXblBoQXkxNGRXVTQxY3gw?=
 =?utf-8?B?UHd1UDFOekVrbGliMjhKK2pwbjZWY3lUcUpNeVkxejA3RG5Kc2N5bHpIdzlO?=
 =?utf-8?B?QW8zQ0Q2cnBHb3VsOHkyeWZZMjNiYkNPa1ZZM0JET0RhZFdDZTZncmdDK3pW?=
 =?utf-8?B?Unc3QTRDOUhuTHBHS1pVV1hiQnJ3NXFJUFJhMjlhNlZtSThIZ2p4emkrd1Rr?=
 =?utf-8?B?UUVEQlJ2cmpCdi9SWFNDaDlndmN6dXFSOWcyUW82emxQUmdMc0Z5clFpV1Iz?=
 =?utf-8?B?SDhQaS9Zam5TRnc4dSsrTnovL2Q2ZGNOc3hpQ012eXN0ajhlTU5lbzUxdXJQ?=
 =?utf-8?B?a0gwQ0hrSGFwSVgycklxTjREZWQ4WVJBbitraVcwZFh3Q0QrKzl0M1hjSjFk?=
 =?utf-8?B?dmkxRDVQK3EzRGVubmFhVEYrRjZzYzlUUE9lemNlYm1zMXd1Q0hta0tkdllW?=
 =?utf-8?B?d1VwZzNkZnRlckdYOTM0Qzl0eXpPSzBqMy83WTFMWXVRVUxCZTdEQktnaTF1?=
 =?utf-8?B?OSt2Qy9EOUp4cnpHWFFTMFp3SUVSN2JCR1JETEJGbUhOR2lUMmpLbC8wZER3?=
 =?utf-8?B?Sk9ZdUVPYXA4cEdYaTBVRnRPRnlRVllSaHl1bHpBbDR1c3JxU0lLOHZmK096?=
 =?utf-8?B?d3B0dzFqUVVZK1lIU0ZLanFTdWJ3djltc281Mm40c2Vxcyt6UWQ5MnNVNFJ4?=
 =?utf-8?B?d0dJT2o2Sk5MS05hN3ZWK0w4Qy8vNzF6R21zN0w4OTVQbUZxZHRwdnBYQk9z?=
 =?utf-8?B?bW95TjhXTEJxZE9PREwzWFVHZjluMVBzSUZjQ2R1YUJRYjcrMDZGZjhCeEtH?=
 =?utf-8?B?RUFtT1MxOVl6L0plZ0JtWnNtRFhhVVBrSnNoKzhlNE42Wi9yTnFUZEtjQW9q?=
 =?utf-8?B?eGNYcUVHVU44eTl6ZUVkWFBKR0tWY0pJc0tKUE5PK2x3VEdnUHlJMFAySS9H?=
 =?utf-8?B?WllWdnUxbGVWTEI3eGJWeDNrUUZnbHI1bTcvWkxYci9CS1Y3WFRLUVBoSGNX?=
 =?utf-8?B?bit1UEVrd3h4TFhYbDNGQ200N2g0YmlkYlNpQXZHSFVCRnlqTzdEdFdaUmIw?=
 =?utf-8?B?QUpoenRqQmNQV0xKQmJNZXB5VTJmVHQ0aFBoM2J6N3NnUkZiSXg2dW11ZWJN?=
 =?utf-8?B?R2lhNUVyRmE5QWdqTUREcWExOHhMVjgwWWtUcEtBeVFQcy9HYWZ5VzZIUnI1?=
 =?utf-8?B?NC85WHVtS0RyNlYrdXpHVCsvdDJzQUJVeU1KWVNmL2pLenlPK1JqUEJhMzVr?=
 =?utf-8?B?NEJqT1ZWaUVZZityR3k4SGtYRFN2SE5jZGhRb2VnRkg2M01TNm04b25jTHo2?=
 =?utf-8?B?eTB6UThqdmZiQklZck1sNzhGUE1yS1cwNU94Z3hxR1JJOGxaN2JENEE0WFpw?=
 =?utf-8?B?NHZnR1ZDdVkwVXJ2OEI2T2FxeW5MQnJiNzBWNXN0dXV0Q0ZTaDdJODcrQU1F?=
 =?utf-8?B?SmNVUjMrUzJlc2ZBMWpjMlVhRlBaMnFhY0tLOHVVc0tIQVVmM0VVbkRXNTJY?=
 =?utf-8?B?bE1SYUhaZXhCajlIRENYbWpqWFIrWndqTXgwVUcvODl5ZExUbWVkQXJGbGI3?=
 =?utf-8?B?aDR1QmJpdW82V0NoVGhteUNRY3pweUJQUEx4NE9PdzZwUU1OMFZFTUVQWlU2?=
 =?utf-8?B?VUhxYzdjbHFqTjRZM2FTYWdiVTFXOTAzRFNtQ29lQzZScnlBTkhmSGwxdWlx?=
 =?utf-8?B?bUROWFBUSG1rTnZ3V0VuWmlJc0tVZzdId3g5STM2NHBDK0dRcGxUbWlaM2Ey?=
 =?utf-8?B?Z0lnK242TlN1dUtBNWNKQ2JjY1ZyV295NlhpTXBFNkQ4RTZMcUQ1bVBWWGNi?=
 =?utf-8?B?V2VuZ2d3UVFQbEFUcFo0VEJ3L2pvZnlwYWlEcEEvRFFHK2MweVpNeFE5U2NW?=
 =?utf-8?Q?gAjDwFEyxVBWJV82EBpAMHRWO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adf52483-f04e-4861-29e4-08dbfa0ce075
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5951.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 05:49:01.9142
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cw78t5QW+sy/0PZNogyr0OTXCwqiTx7tmNrE6E+SBbnZmYgnI+AoXAMKkunztPor0sFEAWl8m3qv/H728FpEng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8368
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/10/23 16:02, Cristian Ciocaltea wrote:
> On 12/10/23 12:05, Venkata Prasad Potturu wrote:
>> On 12/10/23 14:36, Cristian Ciocaltea wrote:
>>> On 12/10/23 05:24, Venkata Prasad Potturu wrote:
>>>> On 12/10/23 02:23, Cristian Ciocaltea wrote:
>>>>> Commit 671dd2ffbd8b ("ASoC: amd: acp: Add new cpu dai and dailink
>>>>> creation for I2S BT instance") added I2S BT support in ACP common
>>>>> machine driver, but using a wrong BT_BE_ID, i.e. 3 instead of 2:
>>>>>
>>>>> [ 7.799659] snd_sof_amd_vangogh 0000:04:00.5: Firmware info: version
>>>>> 0:0:0-7863d
>>>>> [ 7.803906] snd_sof_amd_vangogh 0000:04:00.5: Firmware: ABI 3:26:0
>>>>> Kernel ABI 3:23:0
>>>>> [ 7.872873] snd_sof_amd_vangogh 0000:04:00.5: Topology: ABI 3:26:0
>>>>> Kernel ABI 3:23:0
>>>>> [ 8.508218] sof_mach nau8821-max: ASoC: physical link acp-bt-codec (id
>>>>> 2) not exist
>>>>> [ 8.513468] sof_mach nau8821-max: ASoC: topology: could not load
>>>>> header: -22
>>>>> [ 8.518853] snd_sof_amd_vangogh 0000:04:00.5: error: tplg component
>>>>> load failed -22
>>>>> [ 8.524049] snd_sof_amd_vangogh 0000:04:00.5: error: failed to load
>>>>> DSP topology -22
>>>>> [ 8.529230] snd_sof_amd_vangogh 0000:04:00.5: ASoC: error at
>>>>> snd_soc_component_probe on 0000:04:00.5: -22
>>>>> [ 8.534465] sof_mach nau8821-max: ASoC: failed to instantiate card -22
>>>>> [ 8.539820] sof_mach nau8821-max: error -EINVAL: Failed to register
>>>>> card(sof-nau8821-max)
>>>>> [ 8.545022] sof_mach: probe of nau8821-max failed with error -22
>>>>>
>>>>> Move BT_BE_ID to the correct position in the enum.
>>>>>
>>>>> Fixes: 671dd2ffbd8b ("ASoC: amd: acp: Add new cpu dai and dailink
>>>>> creation for I2S BT instance")
>>>>> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
>>>>> ---
>>>>>     sound/soc/amd/acp/acp-mach.h | 2 +-
>>>>>     1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/sound/soc/amd/acp/acp-mach.h
>>>>> b/sound/soc/amd/acp/acp-mach.h
>>>>> index a48546d8d407..0c18ccd29305 100644
>>>>> --- a/sound/soc/amd/acp/acp-mach.h
>>>>> +++ b/sound/soc/amd/acp/acp-mach.h
>>>>> @@ -27,8 +27,8 @@
>>>>>     enum be_id {
>>>>>         HEADSET_BE_ID = 0,
>>>>>         AMP_BE_ID,
>>>>> -    DMIC_BE_ID,
>>>>>         BT_BE_ID,
>>>>> +    DMIC_BE_ID,
>>>> This will break the other platforms as this same enum used in topology
>>>> to create dailink.
>>> If I understand this correctly, there is no consistency across firmware
>>> regarding the IDs used for DAI link identification.  What would be the
>>> suggested solution in this case?
>> These id values should be same in machine driver and topology file, then
>> only dailink can create without an error.
> Yes, my point was that some topology files seem to require different IDs
> for the same DAI link types.  In this case the topology expects ID 2 for
> BT, but other topologies would interpret that as DMIC.
>
>> Always new be_id should add at the end only.
>>
>> In this case BT_BE_ID should be at the end.
>>
>>    enum be_id {
>>        HEADSET_BE_ID = 0,
>>        AMP_BE_ID,
>>        DMIC_BE_ID,
>>        BT_BE_ID,
>>    }
> So you are basically stating the firmware is broken and needs an update
> to use ID 3 for BT, and there is nothing we can do about it on driver's
> side.  Is that correct?
Yes, id 3 should be used for BT_BE_ID in topology file.
>
>>
>>> Thanks,
>>> Cristian
>>>
>>>>>     };
>>>>>       enum cpu_endpoints {
