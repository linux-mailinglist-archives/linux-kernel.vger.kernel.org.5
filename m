Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 662A780BA18
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 11:06:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231728AbjLJKF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 05:05:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231778AbjLJKF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 05:05:57 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2047.outbound.protection.outlook.com [40.107.101.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D54C111F;
        Sun, 10 Dec 2023 02:05:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ij6qmqcSRGqPDkt2YV+4C5qcWuK+ZOlTsfeJ72DJu46YyA1Bdo9+4q88muuKqPyq2npZ67BMDV+u8N9hkoIMtCR10r9CpSCWYUxl+be4hiFLan3IMKvx5MuIeXFS3CbdFGWn2Cy5Rji6uMdSlgrdgCYj1r24YHBwMPh0ItFKAeonsL5K9WBtYWKY9eVcqIXdMn8n+9GY5DW9CX7YlHRUGsZyNDABVxAigC8crIJY13M+wvglWyE2kIh3AGR7oeXDNkzm57gcqa6GyT5Q7Ktf1mdTPNUvOMJ5tiHgqX5Y7UTTmch0JxTz4KJKdcijx39caC5JWQhmuFYpkBfBo3nYWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g4KhXp3FebcdCA2W58CBXxXGXPgta9BhTlWoeUxnzDk=;
 b=j54kDKPfpvtUwuFdY3ljAilWmyZOU/RApXwq0aUJmGrmoOC7Z9144I2nYHbp/AhMeKxZCWldp7gIDAfHz/ZFBG+w5bmitFp6DNTVAo7Em0P1PlS1D/jNgpYCGxpr8g8ViAcUcMNB/qfL8pkYOj21jahwpB8+2Bh0B5xbwLUbihsIOY1avfAjJyqiS3xnD6L1R4GD1Piksg0nhm56AfXpVeOHBSbdd8OezZYaHfk+9Ng3crRTqQq/YXvHqfxTJoKIgsuUHgumh1LqwhxAHtjniH9vJlSJ92r8uIUBVIKWqeyFXjpGzCxmubGlAiV9jvqt/9PM8W/viI4fTZ1uqKV8Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g4KhXp3FebcdCA2W58CBXxXGXPgta9BhTlWoeUxnzDk=;
 b=JCkhc7yQPJZY7peV3CVoSVG6fapr8pzNXQRT6I1f6QNX5IBV0ICWgqVr2hrwsEv03DqOle0muS3VCjZds4hYp1QNOzunM1aT6gjskT/naB9zWMU8DGOMYU8f65US/i54PgU4i+4WSr6KDMeMSOZyN4gpgQlwV4nuoY9IMo/z0tA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5951.namprd12.prod.outlook.com (2603:10b6:510:1da::16)
 by DS0PR12MB7771.namprd12.prod.outlook.com (2603:10b6:8:138::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.31; Sun, 10 Dec
 2023 10:05:55 +0000
Received: from PH7PR12MB5951.namprd12.prod.outlook.com
 ([fe80::e007:72f7:4102:9258]) by PH7PR12MB5951.namprd12.prod.outlook.com
 ([fe80::e007:72f7:4102:9258%4]) with mapi id 15.20.7068.030; Sun, 10 Dec 2023
 10:05:55 +0000
Message-ID: <1de9b77a-5737-40e0-ba3b-79c8713be93e@amd.com>
Date:   Sun, 10 Dec 2023 15:35:40 +0530
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
From:   Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
In-Reply-To: <391d2476-8f4a-4670-a248-8d4d9c46ee09@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BM1P287CA0002.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:40::13) To PH7PR12MB5951.namprd12.prod.outlook.com
 (2603:10b6:510:1da::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5951:EE_|DS0PR12MB7771:EE_
X-MS-Office365-Filtering-Correlation-Id: 84b3bb51-1d68-4255-9341-08dbf96798e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8iRLO2MPCBZ8sbw4aDQOY2xzgJdGvT4pXhmPgp4WiJdxd8PLmP47yveteinRBD3NKxhzt9f7jqIz5QEK23FLmP+7gp6zr1TYzMtmQbkP4XydB57vN6EXGwlV7SSTelYR8mZSlDb+RWNC0TxHv3PeVASyqveCnekjfsbcd+NrlDRAIsVPhVFFjL8K/m2EQhr8MlqTG2vcq3cj4MqBbO6uF1w3idt45tlW+R4M7PzX1CuZxErnjSmyqf7NRYsYW6ew+BQxMnttG6XOoWnhvVVqusJUo1gsRKy1DvOMa7Cp60a47VnVUIKdMy1TF1F9B1B8TszivVR6Gge0o9Pdot8BfJS017iJ0NL9GDavFu10CeII8Hs1PfX3paxIa5zL3D/WPf/jb1jt44TLW8mZaErJQbdJQVRce3pOvaPvEGxJPuJO62RU4CjtGFaJLSEfBq1dqxjONNuwFO35tkesb6YQYD+MuWE2wHA4FVm65GtpCNVhaOtqfCQtBMS9bf3DQOhvX9eo5yJTTfmuj8I0fR/Qf3fBGqnrPUebTu5Oplr+Rh0ynzqTwHarT8dtFYPj0PMt5lrSjiw5hzlvtvrTZ3O0j/+7+u6wLUXpf8bO3+tLDSK1WHsO38AzpWnQxWH0wLY0AMUPtSTzwea18jqSzJ8Erh/VbfE1HcFiPtB9h9/MuGQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5951.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(366004)(396003)(376002)(39860400002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(31686004)(41300700001)(38100700002)(2906002)(7416002)(5660300002)(316002)(6636002)(4326008)(8676002)(8936002)(921008)(66946007)(66476007)(66556008)(2616005)(86362001)(36756003)(110136005)(31696002)(83380400001)(6486002)(26005)(478600001)(6666004)(6512007)(6506007)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b1JxbnB2RUNCZklJOXR6SFJsTEFsTXR3M2tBK0l1QUR4em1JbE9WOHF3azIz?=
 =?utf-8?B?MGFPZHJmK1hCakpVMlFScVo3V1VqNlVJWm5ZVEFwanUvR0FLTTFHaXRUdzRn?=
 =?utf-8?B?a05wVUVyMzlqNDNYbVpyUkZuWFgzL1Y2K3hkYzVEanhMYjBvSC94QVJVQ0pa?=
 =?utf-8?B?enFYVWJCWGdCcFBiV2JsblM1dEloR0FJT1NtK1hmYUVncWxQemlMbWQrWUlt?=
 =?utf-8?B?am1QZSs2Z01xbG9sczN4eEM4U2dDTFRoUlFxSkUrUEp4aE5wWkdjclg5ZGNR?=
 =?utf-8?B?SjRVZjBQMHV6NDRObnFEM2ZYMld0RU5mRnlPQ0Y3d1hvZDQxdm82cHRWd2Iz?=
 =?utf-8?B?SWZxT0EzNGUwNDREZ3NGSzB6UEhIaEVFWWZIcG9sTk5hazY1WC8rajJvVlht?=
 =?utf-8?B?RVl0VlMyamMzYzJFbDNEeVB2ZEZKUUJ6V0R2ZzdDaDYrZVFmaDRiRUlqMmt2?=
 =?utf-8?B?RlBzSUpPT2JiWUZIR3V0K3NYSmg1UStXY0xZQnR6dzJVdWlnbjR3S0dJSWhY?=
 =?utf-8?B?c2cyV0NYTHQvOXdTYlJLTHByaDJ6T0M2ZzBVeWM0a1o5dnlESXFUUHQwbmpV?=
 =?utf-8?B?djFtM1F0bGVQM3dGWGFjb0pLNHNsNU84d1hqaG50ODE5ditBZkErODk2VGtM?=
 =?utf-8?B?L1lSNEJpMmJXckFEQ2t2TDFzZndmYVZLbTdzM25hV0xKdGVnMDBaVFNZUlNn?=
 =?utf-8?B?cjhybE1VcG5QcXNUK3MrcUg0UDRPUGFISDlXTnVnQTFGelVRcWRtRWNwaUx4?=
 =?utf-8?B?V3hBd1FldldNTlc1SDRBMlFLYnQ3b09FbUZMcWxyRzMzQlhlYnFjaUkwTzBB?=
 =?utf-8?B?c3VVREZ3cUFJdE51bXI5U01qYTVBcjQ3WTNNbG1IcnRnaDJJb0c5MWNPUFY5?=
 =?utf-8?B?bUlGL1g5bWxyOENwWkduRkZsRzg4cXRha0Z4SFRUSGJTeDdRNDFtcGFzV3Bl?=
 =?utf-8?B?UnNZN2FudEJiY0RhN0pyUEdXRWZXeS94d3praVZjSURtZzZmVHdZWUZxUm9V?=
 =?utf-8?B?TTQ5REl5d3N2bjhYWHlHb2RtSExSQzF5R0N4SzNSb0x5UnFJdUZrRjQ3ZjNi?=
 =?utf-8?B?UjR5MGRIdzNIRjNQalJYKzBWK2FyOEdCTnZOSEROSmp6RkdyTm5hQXpSeDBY?=
 =?utf-8?B?NHU1L3dmTXM1TWpPbm9RckFRN0tJakNVdFMvcWQvNWo2WTlwNFhLelZWdWlC?=
 =?utf-8?B?SC9sTHY1Q1poVVRzczY0eG9tYVFEaXhCaFk0S0VsZXVrY0NGZnpmNlZPSWpE?=
 =?utf-8?B?bFZiTHdZcDZVaWdmOXpSR016cGFqY0FlSFdxMjlLVUs5LzRZS1BxZVp1Mks3?=
 =?utf-8?B?TnZYT21DemllMzUrRzN3QmxDUjVCc2lQS2VaTzE5RUk3WkgxQzVwUUxrLzNQ?=
 =?utf-8?B?Ylpsb0l5MUFRZmhjdlFaNkJOZ3ZXY1AxRS83MVM5SzU5VTB4MUNNS1g4bE1R?=
 =?utf-8?B?eEpmOTVXemFsa2thUjYwcVBZSzNvK2p2TDNTVStRenpPcjk4U0ZlUkxKUW1G?=
 =?utf-8?B?ZG1pdTc5NkFWSVlSemk2QWIwN0Uvai9hbzMxVGZpRitiT2s3RTZ4RGI0TTVM?=
 =?utf-8?B?SFczNVZhVGJRQTdsMWtQZmlpLytUWExiQWplUCtlK3JzT0VxVUo3TTg4UURF?=
 =?utf-8?B?VDBLNmczTGFMM0tHemZma1Z0ZTdLakFtTmQrejAyb2RnOW9yVUlGdHQweHVK?=
 =?utf-8?B?VWtSeERmMGsyejdqNHFvZGxDSWlRMi9pZ1puK1UwYnpGV3I3R3hZU3NTaG82?=
 =?utf-8?B?ODNIMzVCNGFDRGR5VW9pTk5Kc3F4U1JDdGlOOXNOb3gxc3pDdXZIdndKbGJN?=
 =?utf-8?B?cGVBMmxka3dvbUlJcVZTTS9WMUtoeUZQVDlweUlJV1lzbTdVMGNUQ2xFeXlh?=
 =?utf-8?B?S3RSWVcwUFhJdGNoOHljTE93OWdaWCsrVzc3SkcvaysvUGpvVEJxUFhsRnpQ?=
 =?utf-8?B?dkJBWmkrQ3ZlbEdud09lbm1OZVpkYmRLb0xuUFhwTEJwRjR0emp3bUVVMENW?=
 =?utf-8?B?VmJ1SmYxTmJ3ei9IRHRZWjgrN3ptMWcvVTZWY2QxYWtwNVlxRVIvdGxQSnlR?=
 =?utf-8?B?L2RVUlJmRDBDRWxhRGNzUDZIRlZqbnpvNENmNUM4Zkd5dEEwV29COGQwcEM2?=
 =?utf-8?Q?s0Ic3kIGWB8BsCANMKsmej1UT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84b3bb51-1d68-4255-9341-08dbf96798e2
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5951.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2023 10:05:55.1717
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xWzzZG5bSLIeJHMG00BCfXNtdLL7tzrrdVZLUNz/v4J4YYKcbYDim3e/gnSVC1Sf3IlRkKMJdFXJOsJ3fLaPng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7771
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/10/23 14:36, Cristian Ciocaltea wrote:
> On 12/10/23 05:24, Venkata Prasad Potturu wrote:
>> On 12/10/23 02:23, Cristian Ciocaltea wrote:
>>> Commit 671dd2ffbd8b ("ASoC: amd: acp: Add new cpu dai and dailink
>>> creation for I2S BT instance") added I2S BT support in ACP common
>>> machine driver, but using a wrong BT_BE_ID, i.e. 3 instead of 2:
>>>
>>> [ 7.799659] snd_sof_amd_vangogh 0000:04:00.5: Firmware info: version
>>> 0:0:0-7863d
>>> [ 7.803906] snd_sof_amd_vangogh 0000:04:00.5: Firmware: ABI 3:26:0
>>> Kernel ABI 3:23:0
>>> [ 7.872873] snd_sof_amd_vangogh 0000:04:00.5: Topology: ABI 3:26:0
>>> Kernel ABI 3:23:0
>>> [ 8.508218] sof_mach nau8821-max: ASoC: physical link acp-bt-codec (id
>>> 2) not exist
>>> [ 8.513468] sof_mach nau8821-max: ASoC: topology: could not load
>>> header: -22
>>> [ 8.518853] snd_sof_amd_vangogh 0000:04:00.5: error: tplg component
>>> load failed -22
>>> [ 8.524049] snd_sof_amd_vangogh 0000:04:00.5: error: failed to load
>>> DSP topology -22
>>> [ 8.529230] snd_sof_amd_vangogh 0000:04:00.5: ASoC: error at
>>> snd_soc_component_probe on 0000:04:00.5: -22
>>> [ 8.534465] sof_mach nau8821-max: ASoC: failed to instantiate card -22
>>> [ 8.539820] sof_mach nau8821-max: error -EINVAL: Failed to register
>>> card(sof-nau8821-max)
>>> [ 8.545022] sof_mach: probe of nau8821-max failed with error -22
>>>
>>> Move BT_BE_ID to the correct position in the enum.
>>>
>>> Fixes: 671dd2ffbd8b ("ASoC: amd: acp: Add new cpu dai and dailink
>>> creation for I2S BT instance")
>>> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
>>> ---
>>>    sound/soc/amd/acp/acp-mach.h | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/sound/soc/amd/acp/acp-mach.h b/sound/soc/amd/acp/acp-mach.h
>>> index a48546d8d407..0c18ccd29305 100644
>>> --- a/sound/soc/amd/acp/acp-mach.h
>>> +++ b/sound/soc/amd/acp/acp-mach.h
>>> @@ -27,8 +27,8 @@
>>>    enum be_id {
>>>        HEADSET_BE_ID = 0,
>>>        AMP_BE_ID,
>>> -    DMIC_BE_ID,
>>>        BT_BE_ID,
>>> +    DMIC_BE_ID,
>> This will break the other platforms as this same enum used in topology
>> to create dailink.
> If I understand this correctly, there is no consistency across firmware
> regarding the IDs used for DAI link identification.  What would be the
> suggested solution in this case?

These id values should be same in machine driver and topology file, then 
only dailink can create without an error.
Always new be_id should add at the end only.

In this case BT_BE_ID should be at the end.

   enum be_id {
       HEADSET_BE_ID = 0,
       AMP_BE_ID,
       DMIC_BE_ID,
       BT_BE_ID,
   }




>
> Thanks,
> Cristian
>
>>>    };
>>>      enum cpu_endpoints {
