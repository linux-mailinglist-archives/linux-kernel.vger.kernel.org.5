Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D666980C10C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 06:58:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233280AbjLKF6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 00:58:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjLKF6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 00:58:15 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2082.outbound.protection.outlook.com [40.107.237.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B2E2B3;
        Sun, 10 Dec 2023 21:58:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TJruvqBxE4P4H2tUr0aqx1acCzDrIFZZWwfHp1FRu8dZitsDfnQd2AY/Ac+WGVYdMU6ypfwPTeoNCLa52wZ1+o7/vIReeVd5kJL0T0fIPak9VwTxr8BQwqbScmjvEX8a4Y8Du5Mn8HJHtAreZD9JhcS30Cqfwbm44vdDE3ZlmxXu7/MHu4OdVpcZoszu00jYe9ubCyoCmosaO3EacA0UG6QS2vBOKCZ/GrSYC8NFnVnEY2Gg5HcMgCcOm2HLZPmPIOfHkqs9ID26jaTw0r6liffVVIoVyymmyHgcW31OnRIE/xgR9DyzWpS4O8pfdi97PJTl+WFdwEeSZd2DQynXbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=amX//vw/T4kFrWIGThNrSJ2PX+mkMHpkdnUMxJRtQqI=;
 b=P4mSfFMRwlS8H2ZPuaLpQgGIBlNHBTyOV/GeS9sNdGr6Q0faVBEamzzsa1L3nXw23/2ABQjcpxUHAMeHfTLtZ0faCxBpxvcokvT+dZrifn4aXeneuM/kkVgi1ccOLntiDGprYdQTEfSKjaaLy8zTtVdqFilYNJ/xr8b6px8WIp+NZdt4SJTq+6zQiOKhIJ+hlSGuw6B+SpRhhFJTxqBt5lIJj8zTyNXbeVHDBwzPeeb72fVBMoZ6w8maBH4YI+3m8+0j5Ba2/4oS/+C1I5lKPg38GrUpZ8WNNWuseYjkl63Cx0thEe3gZ0tuGDSFAKDRnC2kMLYLdQods83Wf+BA6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=amX//vw/T4kFrWIGThNrSJ2PX+mkMHpkdnUMxJRtQqI=;
 b=i5szTLX/5ol1PLzhK6UZdVw/r71SoLEVaufV3KaVCw4EcsQz8czu01vXNm5TbaMc4vmIg4M7LfPyjFOOV5S2k9lSLib+54I/0qgsodMldcBY5yupTLHgSNcW9IIXhWPDGNoNnhpu+PcWlbs6I4mkGrIoM9ooCCG7ZF4fGUg9r2Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5951.namprd12.prod.outlook.com (2603:10b6:510:1da::16)
 by DS0PR12MB9421.namprd12.prod.outlook.com (2603:10b6:8:1a1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 05:58:16 +0000
Received: from PH7PR12MB5951.namprd12.prod.outlook.com
 ([fe80::e007:72f7:4102:9258]) by PH7PR12MB5951.namprd12.prod.outlook.com
 ([fe80::e007:72f7:4102:9258%4]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 05:58:16 +0000
Message-ID: <dea5fb18-5fdc-4be4-9981-a6876cf531eb@amd.com>
Date:   Mon, 11 Dec 2023 11:28:04 +0530
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
From:   Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
In-Reply-To: <5095ce7b-13bd-4805-b81e-f7565ab41b67@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXP287CA0021.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:2c::25) To PH7PR12MB5951.namprd12.prod.outlook.com
 (2603:10b6:510:1da::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5951:EE_|DS0PR12MB9421:EE_
X-MS-Office365-Filtering-Correlation-Id: c2095dd5-a7de-4c13-6a11-08dbfa0e2b08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2vipTLlgMobcg2x9Ls6mS3JJFE8cHMdVqJs4oU+/cOwzqeKzGQ+ucSm9YY8+ICKnyh0aN0Zhii556DlJl7fCFh6mDxpDULTvvUVuQrBMtuh3TgWCf1heGZyHPHvPsh3waCGWOQ5GQAsht4XiE6BRvrTV09rS0ato3mMmA8LgskS1SU0GFzn8YIGcnCuGdw7r8bojuvGD1yuZfXhGilQ9hb0zBamMNj164FSMdmareMtr+SGSx279NgxnxX7EQr3/FX0Wjgd54XAaIADYzAPH1zQ1JTDUvfFvyOsZk/JQTysxBCZRiVp0302Q1sOohRz8vT85nasIRrH5SNKCQxrOAOltK/gMrSONbmLUUscDbIKSEdS2klqBnXD0lvDkroHWqbMTJuETZpPb0v0cfnz2tJBqo/VW2bf2PFY0/3hbUT1IIQGg6CKD+eZE1tedeFD40T2njZ6kwXiSCFXZFK7idDSUteAYk093qNmsrOpiSuMbWuBFxzqRzkaHldfJwWPCfrMM+3kmkD429PjLS1ikErvAHt92WOX7XBwz9Rp/gyYk3jjoCpBa01dA+qHOglBhcfq6MUF2e2mS+x+JdxLRM7Bt86ZILMH22hg+wssGqHtgeTRYyGSO7o8l0NJIBI9qpRcWsx2NIx4BPEXgJ31pKE+md0BZ64/bfcBnrbptuyQ1Xm2TKeqL1IfoRnOJfX+B
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5951.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(39860400002)(136003)(376002)(366004)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(7416002)(6506007)(6512007)(6666004)(2906002)(53546011)(54906003)(66476007)(66556008)(66946007)(38100700002)(31696002)(86362001)(36756003)(316002)(8936002)(4326008)(8676002)(5660300002)(31686004)(110136005)(966005)(6486002)(478600001)(41300700001)(26005)(2616005)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N3FnV3d1K2I1UHh6UjRyc01LNEdPdTl1Y1lHcU9vV0VlYkVKRG5QRDlvcnND?=
 =?utf-8?B?VCtQeEI0eFFTbXhpc0tRcU9BM0V2bEJ6d2NjQ1BUdmZrTGNRbWFxMHJlYVd2?=
 =?utf-8?B?WHI4alBBVkJZcDdOaVU0dkc4T0NJUlpqWXVHMVJqL25ybHhpWHBSeDlaMkFT?=
 =?utf-8?B?MEN3TTlvd1ZUMXRoYm9McHUrT3c5ZjN1aGdGdmtsSU5DQmVmYkRtY3lQVVJI?=
 =?utf-8?B?enpuY2xvTU9ycHZ1clhTR2RIZnhMQmR6cDRXRjRvb1FlQlVkeStyV3BsU09L?=
 =?utf-8?B?U0thUkpJRSs0RlV5a1NSVGF6TWpLUWtkTktBTTRVOFBXNlBPaWd3UENZNy9K?=
 =?utf-8?B?b1RTcVpwR1o4OWJJWDNhVCtVeWVHVFAzVFczcWRXQkZsRGZIdE5WcUU1ZFZo?=
 =?utf-8?B?ZktjaGJRWGlwNzZRTHZMWmtlZ3lvWUNGeTBtWkpHMG1Pc2xQd0pRdkxacnNO?=
 =?utf-8?B?WlcvSklvT3NhWW5JK0xlcGo5dmxnOXVZeFVEdDJndHVVc0dKTVF1TXE5S3ZJ?=
 =?utf-8?B?L3JpLy91QWVOYUozSFhnSW9KdHZjM2N1aHlIUkFrUHZOdWRxM2o3ck5mcXNO?=
 =?utf-8?B?NSt5azUwQlJOUEdhZS93OXZ6bHlIUHNRc2pNTnFPRWE3enRxY01WWDlxdURJ?=
 =?utf-8?B?WjJhUk95RS9BZGp1eUhpakJKWmlwZkl3YS8xR0hHM3Q5RXJVNXV2Q2hSd2cx?=
 =?utf-8?B?aGNCbENDZ0JSMG5hMWJmcm1BQTB3NFpqeEplOXNIM0JSSGsvYysvN0RPZzg0?=
 =?utf-8?B?QUdUSDRSMHgzbHVOL3ZvVXEvazNabHlqajhCcytGZEFsSnZodnVDSEl6YmFU?=
 =?utf-8?B?bmQzaGtCYjAwSGNrL3E3VWJPcjY4bEhYSkhjSGFhM29vTkYrZWsyZnNBZWJB?=
 =?utf-8?B?M2NUK29XN1BrcmpYRDVUN1ExZFc1aGMwODAwMmhEckVOSkUyZzNzWXQvS1lB?=
 =?utf-8?B?TVljYXlmeGR5czRwM09PemdUaUNJK1hEK0JtdkJzTmJnc0lvbndtN2paa0VT?=
 =?utf-8?B?aURqV0JuVGIyS3BybUY0RUdXVis0RmIzY0thRGJUdG9iZ2VTQWtnQWhGLzl2?=
 =?utf-8?B?NW9XYkhQaHVqTWVBK2xHbEl6OXovYlVvRkRnOCt6dThzWVJMYll4TUgvWXpE?=
 =?utf-8?B?OFVOb2k5eVBYbXFqL3U1Q0ZhVW5lYkhjb29DclZ3RFFmOSsrK3V5cWtyMjJF?=
 =?utf-8?B?NndxeEM4MnJ3MDB5bnlJR3dUZEUvRE13YVpmYUZPTjdpdWUzMm1GNEVSQXA5?=
 =?utf-8?B?OUZVNkMzYWdDSzc0OWZpaEovdXQ3QVZRVWlFQm55ZFBEZW1SMkRKY1hFODFT?=
 =?utf-8?B?UmpsU3VLcXdST3FWaVYxaXUzczluWVkwYnB1UE1hMm9ZUllFMzFkdVQyelli?=
 =?utf-8?B?L0ZhamZCb3ByV2g0Z0YxZFk4K3ZzSGRBUmtBdWVKNnFNeHVlbWlTQ3A3L1Ny?=
 =?utf-8?B?UlJ1djNuK3A4NVVSS3hJaFkvVTFhZm50SHpVbU93ZVQvZm5kQWp0cm9vSXFs?=
 =?utf-8?B?TWR6MWF2ejFncVBRVTVGdE5VWW9lVXFWSUIydFROcFhIWlBIN1BRTFp1Smxh?=
 =?utf-8?B?QW5TcUJRWkFsZ2FQNWc3RGw5azFueUhBQWhtVFVseXpuUGhHTlhYb1FJYSta?=
 =?utf-8?B?dHR0QUdOM05ZcXVoU3o5ajlsaVBEZy9CWVd0T2dXaFJ3NjhPem0wQ3ErR1RG?=
 =?utf-8?B?dWZHZUZXUXBxNldvU1plU053eVZOcWJ3Vnh1QTJjQmZjZ2prMzRvM3hwUVNI?=
 =?utf-8?B?cml0WWpBbCs5RDNvWVdsYTVLcE0ySGdxTVoxbmlrN0hXZVdTQ3BBQmJCQnlM?=
 =?utf-8?B?Vk9jZFM1TWFwdWV3MjRCMTlsU2tzM0VOQmJ4Q1I4T0ViMFAyWURJeG5JTkZx?=
 =?utf-8?B?a0h4RGlpOGJBM2dEL2lhRlZheHhLMmcvbHljQ0FnZjltLzJ2MnJOUzlXQzRS?=
 =?utf-8?B?WkhPZC9OZjdPdlJhM0FPRmVtaTd6U1VIcDFwODdRN1hZYTEyV1JmNktJQzFB?=
 =?utf-8?B?aWs5cUJFcHhPVEtuM2JNNCtNZXZDSDJkR3VRVUFGQm5HWC80YUFMb2FhaDAy?=
 =?utf-8?B?Z0xiOWc2VWFDVEZYS2svTW00SU5BQUxDQnVxVThmRE9MdUEzQWphYUhDV04x?=
 =?utf-8?Q?aa2BC17Fnzm8iYp1nKYGqacYV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2095dd5-a7de-4c13-6a11-08dbfa0e2b08
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5951.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 05:58:16.2803
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D2MuzOYM78lNSi+p2ao+Kz3I9gJi1OimnKymSHYGOEG+HEGulnVygCoxjr9Hx+qrvUIHOkUJ8cdsGf/3D850pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9421
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/10/23 21:20, Cristian Ciocaltea wrote:
> On 12/10/23 16:01, Mark Brown wrote:
>> On Sun, Dec 10, 2023 at 12:12:53PM +0200, Cristian Ciocaltea wrote:
>>> On 12/10/23 11:51, Venkata Prasad Potturu wrote:
>>>> This should send to SOF git repo for rewiew, once SOF reviewers approved
>>>> this, again need to send to broonie git.
>>>> All the changes in sound/soc/sof/ path should go to SOF git.
>>> Unfortunately I'm not familiar with the SOF dev workflow. So it's not
>>> enough to have this patch cc-ed to sound-open-firmware@alsa-project.org?
>> The SOF people basically do their own thing in github at
>>
>>     https://github.com/thesofproject/linux
>>
>> with a github workflow and submit their patches upstream in batches a
>> few times a release, however my understanding is that their workflow can
>> cope with things going in directly upstream as well.
> Thanks for clarifying, Mark!  That would greatly simplify and speedup
> the whole process, at least for trivial patches like this one.

Hi Cristian,

We have created a Pull request in SOF git hub for I2S BT support.
please hold v2 version SOF patches till below PR get's merged.
PR:- https://github.com/thesofproject/linux/pull/4742

