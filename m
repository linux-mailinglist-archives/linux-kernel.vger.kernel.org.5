Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE97D80BA0D
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 11:04:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231760AbjLJJvy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 04:51:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbjLJJvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 04:51:53 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21CFCE6;
        Sun, 10 Dec 2023 01:51:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eg2JAkUWJCTerTgRLpTWxF/NB9M073dN3UFLK4jLJh9yUWq792tgN95HOqbdEGq4UBtpMjoQbEHAoEkU6HnD7FXm5C/D4gbgloD8fNqHHHir8SemuFQBHZPWjv7tGmo8pqwrpcsWXjO/tW7K+HF33bs8T0Q7RXgm08qQg1lnw8LQD+CTJ0AD8MPS66bQwtlfMacikffreCjeZ0FHVqO36BqH5bmNY//Mglx7Dgt1u0Zq5Y4COSMHYSQl2MYfqC1Gwhkx9arrqYFJ7uU2AYQkrYDI7s/2hnX7viYjy5SvEYjvPIXME3dF474FvOUwTKVc4GCRt2hsmbrDj1E3WG8DYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e0DjopCfdAvGbaKaVuVM7UOWixue/l0/40NVd5aevbw=;
 b=esqLSnD6cLvmFxQQYDiUufKmmsAsIz4PndK5eQUZqlD0lU6Il0IPhywg5MB6wM2F9p8fQiibPsFDKX7SMYhscitWLr4fL6+NdqI0sODEZ+pEx5Ff38/sqF5qbuQi25K8Ps7M+gRHlU9OrS2CRZk7C2k8j3AkmGPZ+Up7o7hBw/ybN+yj4HR8UxLGqfD3+rAuq3dHa6xHdteiRRYNWm/EG99iXHBOvBJQwF4y7WUdRKlzkkzOkHFa/j0vxOOkGRTDGBDP7bKscQC5Y+NIofKrH8P+RTw9JfJnko81SH7FVsepu19tw1hlyWBvQEJyuYvTQFiH8g7F5eJshdFPPJ6pgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e0DjopCfdAvGbaKaVuVM7UOWixue/l0/40NVd5aevbw=;
 b=KAODlNqxjjLVKFrniKNiwwcfTuQxXxnEtR/9xY+lKs3XWZNyJ52wQ7q9oL6+wGQa6Pxqtesbjz/a62hrx/aohFSFZlOayPGPdd7h7MNcpdzjVzh7N1WBss74tYJGbM3oIaXnvgQO/8tGlgOWxgBA1QYBpVWRHkSPGLAUAvPgaaM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5951.namprd12.prod.outlook.com (2603:10b6:510:1da::16)
 by CY5PR12MB6574.namprd12.prod.outlook.com (2603:10b6:930:42::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.31; Sun, 10 Dec
 2023 09:51:55 +0000
Received: from PH7PR12MB5951.namprd12.prod.outlook.com
 ([fe80::e007:72f7:4102:9258]) by PH7PR12MB5951.namprd12.prod.outlook.com
 ([fe80::e007:72f7:4102:9258%4]) with mapi id 15.20.7068.030; Sun, 10 Dec 2023
 09:51:55 +0000
Message-ID: <318470ce-1631-4c46-b425-755c877dda65@amd.com>
Date:   Sun, 10 Dec 2023 15:21:44 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/11] ASoC: SOF: topology: Add new DAI type entry for
 SOF_DAI_AMD_BT
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
 <20231209205351.880797-12-cristian.ciocaltea@collabora.com>
 <fad8a055-eabb-4087-94d5-9e1de00933e4@amd.com>
 <aa830670-e544-43a2-9ba9-a64f1964a9f5@collabora.com>
From:   Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
In-Reply-To: <aa830670-e544-43a2-9ba9-a64f1964a9f5@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0135.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::6) To PH7PR12MB5951.namprd12.prod.outlook.com
 (2603:10b6:510:1da::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5951:EE_|CY5PR12MB6574:EE_
X-MS-Office365-Filtering-Correlation-Id: cdd72d50-d6e7-4d89-63eb-08dbf965a449
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ug9gcYv9SjkKYd4b3TfvB6CScJ41aHII40JA+Jbdnq8F8OA6cilpiRO7UIRm9tq1YBEvKYUMxmPP1S1SOPtZRqpJdfAXHvrh4Bei9zGkW8CjIGJYwj/JOuwo16weG0YvqEZJ2QpIxnbcAgS+N7MsTQbfSdBsHpyrOm1ExmAKHPIZDwUwxSIXORTyJ7y0lJCHyNcAmjrxYQqvp6L2af75bLRPFM6AErFNzzOKQ3mjcxt7sOs81QfVxy/pWekKv122QeY1R0dBXgMHXtrjW0aP6EM2euRqWsfJNL2fnbr5ynD0nfZs5dWzjIQDhagqBlqnXXFnkiWSVkFysmYXgIputzAxZRqKc9nad3Rr7a9iO1FIGCI1nuVeWxAFpmnxcrm5Frjoh2BgE0flfk4Qn6D5hvu1Qao4f4+lMf6qAxXGum4rQRKZyeR/MUG6wX+WIqF/NAtKxWh/+L4iNHa4+uW8avh+Vt0sgVx5qMqgSSiQICqXLkNB1f73xI6VdwuWCS0qLa5QLhuAFqRmDqAKCoY+ClOHeoEOOHiBavCbd3dP1RqqQAJbDwQ4x7v6uA+XSG22ig0xUqBW9EQiPUGvH6XFQYAO+cu1ebjvixWG0Bf2CNrdYh+C4FL1BOMV3sp1SPOoRJYWkEGrBykroH6dzxXUr/K1sWiliyzAoulJZIsoYB4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5951.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(366004)(396003)(376002)(39860400002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(31686004)(41300700001)(38100700002)(2906002)(7416002)(5660300002)(316002)(6636002)(4326008)(8676002)(8936002)(921008)(66946007)(66476007)(66556008)(2616005)(86362001)(36756003)(110136005)(31696002)(6486002)(26005)(478600001)(6666004)(6512007)(6506007)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OHdMZHVkU1pDdTkzcUxJVGZVTWRyS0cyaUhaUklxVjBEUWZSVFJZT3hCQmUv?=
 =?utf-8?B?Vm1CMlM2SXBmenI4NklxbDJnRGQxYXNWM2x2ZmRtUWVoZ2RyclRrTllkWGFF?=
 =?utf-8?B?QnRKbmZ1RWxrNlV6OHpsQm9BaFpFMzJBT2d6aFBKUzdlOHFyQXBNaWc0T2Ey?=
 =?utf-8?B?Vnk2eFhkTzhPblRLWlFvM1B6YnVvR3VGK0hoMUhRMklvMStDT1pmbEVDb1Uz?=
 =?utf-8?B?MGkvdG5yV2dMQVI2aFl2MWdGRSs0c0NvSm9uL2pBWHlDa2ZlR2VGRW1iZ1lV?=
 =?utf-8?B?ejNVZ1QyeGgxOHF5REEwZFlFbEJIUlBJV21UYzMxZUFzaW5HWVlyZldOU2dQ?=
 =?utf-8?B?ZEFUNE5tMGNSYkVJSnpPcytSRU4xcUdMTmx4RFlxRFlMMFh0KzlaWW4ySTVw?=
 =?utf-8?B?MWFqVEFEbWg5amlxSFdlbmVVQkw3U1RsZmp3M0VEUTB2b1hId1ZGeVlCZ3VQ?=
 =?utf-8?B?SzZPNDdhOVdCeHJTUnpIZ2dVU0h5N1JOcGhkV1ZXVGU2cHAyeFpWenpNSEhq?=
 =?utf-8?B?SXNub3BlcFRaRGhadHNrN1QrSlBrZjJ4RXprUU95WFVkaTB6ck12dXdGSnZz?=
 =?utf-8?B?a3o4ZWRaSnRqUEt2ZEprMlFVR2dLbHk4cisxbXZldGFpd2NsTVlMaGpFOGdK?=
 =?utf-8?B?RjBNMWxmc3Y4RHVCbkYyVDUwbkdHM0VETFA0WXNCbE5VcG9Sd3YyUCtUU3Yx?=
 =?utf-8?B?aDFOTGFNZ0gzVDJRSUNzSitaYjZkZlRwTHVnaW1aTlV1MXQ4OE9OYW8wWXpn?=
 =?utf-8?B?T21DdnNSeUY4YS9PM3VBckFWWjE1SlZWZk9lTUljTzNNK01SWVJUY1ZrSFdV?=
 =?utf-8?B?VGlnMDVuUldPWTNGZktKZ2tSVS8ybnZqOXlaWTZZK3YvUnhudk5EYWl4N3Nt?=
 =?utf-8?B?ZW80eXBoQVgwUlliR2UxWTlJN05UOHhCSVk0VmJNMlV5Qjg1L0JQby9zdndQ?=
 =?utf-8?B?WG5HR1YreE11RnV3aWhQdXNMWklBWDFGQkV1VHVQbllqZ2hVd1pXc2RLanU0?=
 =?utf-8?B?LzhaOHVRL01ET0QyeEpPTW90dEJ5M0Yrc2tQTThjV1h2QzJSN1NwSU1uUXRU?=
 =?utf-8?B?Q0pvMlJXUDJHdUd2ajBPTk9KYmxhMDZuUUo2dXp5QUNyUnNmZmVCYU1mWWRB?=
 =?utf-8?B?SWF4d09hZUdpSStZY2VzMlRMMDRqeWcyS0dzcFp1Nzg0aEw2RGsweXMySWtl?=
 =?utf-8?B?cGQzemdwbmU3RzRjenhDSVovZCtrK0NWRVQ3SWNXTjFhbkh3S05XV081QXh3?=
 =?utf-8?B?a2F0dm0zdUE4Rk44NXRUMWgrcHowUnZMcU9XdDdCeDl1a0kwTDhFZ3ZERUtR?=
 =?utf-8?B?T0RQa2RFQ1FHTi9rdVV4dHlrUTY2ZElTQWpnb2poWVFCYjF5SUZMMkh5Z2FB?=
 =?utf-8?B?d1A0VUZadmhZNEwrcWhxaXd6WjBqTno1OUVtSmRXbnltbEI3QmJuN0Rkbkpp?=
 =?utf-8?B?T081Sy9lcGJxMzhZd24zbXRKZWxHRFpHTG93YU1Yd3gzZmtjbFVJV1hqQStp?=
 =?utf-8?B?cXpvbVREdmRzcU04OUNlVVBzRkMrOTlrdlp0K1hFSFFBa010RFFIYTRKRDBV?=
 =?utf-8?B?QitPZFhkZE1IZTZHS0w0L0xuTTIyWU02aDkwaU1HWTF2Q0RQSnFoVjV4UUda?=
 =?utf-8?B?V1Q0SWRKZ0lEc2JPZDJXZWJwNHVld2VuM3VaWTlPYnNCMnlxWXMzT3NVY29z?=
 =?utf-8?B?OE9PQTVQLzVkak9mOWpNNjM2cVBONFJ0N1hDUUpxczVvTDI1MFpSZ09DZSti?=
 =?utf-8?B?SEVyMVZYNHRUY1JnTW85aEFkenNubDFkcHdDZEpiWnpZMjZod1B2RXY3QWFv?=
 =?utf-8?B?VkRLUnUzUmFjU0FBQ0dWMFpyaG1vZlhzUzJlYUdzRWtpL2FkQTJkckVFUW8y?=
 =?utf-8?B?Z1htY1RLQ0RjZUJQSFFHS0ZqMXVNTzVrdk8wdlozZkYvYytNWlVmemNXOW83?=
 =?utf-8?B?Q1AyMjhQalRqOWh4RW4yTHNuOG1WcWFsZGlRU2pxd2tPSmpickN6a1RNTHpB?=
 =?utf-8?B?Wnlyd01GQ0dDb0R3bVI5aS9OcWU4Zk9LT0Z1Nlh1TDZaeHBrQVdiZzRWYTlP?=
 =?utf-8?B?clV2S0RINUc0Q1JRU2FlWGZuUzBhcTROc3NVV3R3ZTdTZUg1dDNVWWFiNnMx?=
 =?utf-8?Q?NDsIAZsqAZ3lbOw4nrI6Fng3E?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdd72d50-d6e7-4d89-63eb-08dbf965a449
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5951.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2023 09:51:54.9829
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QlieGtXmA6N9Vm2OHF+Zjl3Fhw8gnUMa/2uEn4xFM99n/3Yw5AF/E/UfPzo4NA+Xy98qAOqD67ZFH8NAkgIyQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6574
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/10/23 14:38, Cristian Ciocaltea wrote:
> On 12/10/23 05:30, Venkata Prasad Potturu wrote:
>> On 12/10/23 02:23, Cristian Ciocaltea wrote:
>>> Commit efb931cdc4b9 ("ASoC: SOF: topology: Add support for AMD ACP
>>> DAIs") registered "ACP" name for SOF_DAI_AMD_BT DAI type.  However, some
>>> boards, i.e. Steam Deck OLED, seem to require "ACPBT" for the same type:
>>>
>>> [  467.489680] snd_sof_amd_vangogh 0000:04:00.5: ipc tx error for
>>> 0x30030000 (msg/reply size: 16/0): -22
>>> [  467.492775] snd_sof_amd_vangogh 0000:04:00.5: sof_ipc3_route_setup:
>>> route ACPBT2.IN -> BUF5.0 failed
>>> [  467.495839] snd_sof_amd_vangogh 0000:04:00.5:
>>> sof_ipc3_set_up_all_pipelines: route set up failed
>>> [  467.499128] snd_sof_amd_vangogh 0000:04:00.5: error: tplg component
>>> load failed -22
>>> [  467.502210] snd_sof_amd_vangogh 0000:04:00.5: error: failed to load
>>> DSP topology -22
>>> [  467.505289] snd_sof_amd_vangogh 0000:04:00.5: ASoC: error at
>>> snd_soc_component_probe on 0000:04:00.5: -22
>>> [  467.508430] sof_mach nau8821-max: ASoC: failed to instantiate card -22
>>> [  467.511725] sof_mach nau8821-max: error -EINVAL: Failed to register
>>> card(sof-nau8821-max)
>>> [  467.514861] sof_mach: probe of nau8821-max failed with error -22
>>>
>>> Add "ACPBT" alias for "ACP" SOF DAI type.
>>>
>>> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
>>> ---
>>>    sound/soc/sof/topology.c | 1 +
>>>    1 file changed, 1 insertion(+)
>>>
>>> diff --git a/sound/soc/sof/topology.c b/sound/soc/sof/topology.c
>>> index e3e7fbe40fa6..73bf791e7520 100644
>>> --- a/sound/soc/sof/topology.c
>>> +++ b/sound/soc/sof/topology.c
>>> @@ -290,6 +290,7 @@ static const struct sof_dai_types sof_dais[] = {
>>>        {"SAI", SOF_DAI_IMX_SAI},
>>>        {"ESAI", SOF_DAI_IMX_ESAI},
>>>        {"ACP", SOF_DAI_AMD_BT},
>>> +    {"ACPBT", SOF_DAI_AMD_BT},
>> No need to create the alias name, we can directly modify ACP to ACPBT as
>> ACP is not using anywhere.
> Great, thanks, will do in v2.
This should send to SOF git repo for rewiew, once SOF reviewers approved 
this, again need to send to broonie git.
All the changes in sound/soc/sof/ path should go to SOF git.
>
>>>        {"ACPSP", SOF_DAI_AMD_SP},
>>>        {"ACPDMIC", SOF_DAI_AMD_DMIC},
>>>        {"ACPHS", SOF_DAI_AMD_HS},
