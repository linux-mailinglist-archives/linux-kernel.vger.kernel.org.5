Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 805437D8039
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 12:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbjJZKEx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 06:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJZKEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 06:04:50 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2049.outbound.protection.outlook.com [40.107.94.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D5A293
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 03:04:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ljkntu51gJQtsBx8WiOktddKDvK7sxttNmfprQUiIM/dfbbaAlV3PSC3npzCfWdqZ6v+oAPmdfdSLtyH8W+1CR13xRTFXM90ozZFogbGdKbrihu5hvfJC9uXYDH99DPe+lzHaYkUWAE0Dre6MNRyGIEz8fhJ7q1BBEB3a8XaqupvrrQilVof1kfgmfknXZXr7ms9eLKcri1THXXqg7ZgGtMyfjiIz+oZJEaMiW6kkjjuOHxWwEXdkVRm9p1DX3DEEAyEaMtaJowkyEv7yA5nVw5vCWJD0XGpbnpCJgH2W/PIuRRetyo8swC3vCReDIcm8THs4HFHqFIJ56jG+Yv+3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qz8t2UuG/l/MXkszU2BG4OlWEdkLG15uH7gRvyDinE4=;
 b=UOYAH6TurLYjzx/Q5YudxBPvzBrRLZWo0+0p/ynh+DXvlN7ux+uAahEcM7zPjflMZkF2IXZmuLiZ2ZJxElnW3wbyYfOqQgXImdfzosil4CM+aBc6THRrC+s135Qf2T/GmwqWwtMu9S+b1U6blKlL5EuPMrkhnR+qvXHumUsMcBueMJlR3s8ceGpQQpMXQMLxU+HSLv6f/6/SUZsUPMd3406zJn6n0Yxgs6ZL5zizsvB+i1JOBMi9mHDgAQjRMcLJKUw/8p6PzIY+94Emw6M1YpcrqFozqyHTY6to8G7wyZcx10b8T8xwc4TTMJkRp0J/xXdotN8rKnG9FgdwKLohqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qz8t2UuG/l/MXkszU2BG4OlWEdkLG15uH7gRvyDinE4=;
 b=udfkWj1+i+NQ2iPlf7GpV1MR1294terQ8Wp+/9f3WOUvcE8/Ij2FBtvpgFIag+YpjwCyk5AaifaaH2FUCEotLJhcxwLTlDk7C8JDoi7fqOCgPFSi96h2Ka0Hzl3tgRXBQ2/bslV1CGRB1XTecqQ/nuAc9omZce0emzWuFoxxbHA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3661.namprd12.prod.outlook.com (2603:10b6:208:169::31)
 by CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.31; Thu, 26 Oct
 2023 10:04:45 +0000
Received: from MN2PR12MB3661.namprd12.prod.outlook.com
 ([fe80::7354:d327:ee4:dd79]) by MN2PR12MB3661.namprd12.prod.outlook.com
 ([fe80::7354:d327:ee4:dd79%4]) with mapi id 15.20.6907.032; Thu, 26 Oct 2023
 10:04:45 +0000
Message-ID: <9dbbf280-f8d4-466a-b582-a366b7bcb95c@amd.com>
Date:   Thu, 26 Oct 2023 15:34:34 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/13] ASoC: amd: acp: Add pci legacy driver support for
 acp7.0 platform
Content-Language: en-US
To:     =?UTF-8?Q?Amadeusz_S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        broonie@kernel.org, alsa-devel@alsa-project.org
Cc:     Vijendar.Mukunda@amd.com, Basavaraj.Hiregoudar@amd.com,
        Sunil-kumar.Dommati@amd.com, mario.limonciello@amd.com,
        venkataprasad.potturu@amd.com, arungopal.kondaveeti@amd.com,
        mastan.katragadda@amd.com, juan.martinez@amd.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        V Sujith Kumar Reddy <vsujithkumar.reddy@amd.com>,
        Marian Postevca <posteuca@mutex.one>,
        Jarkko Nikula <jarkko.nikula@bitmer.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Yang Li <yang.lee@linux.alibaba.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20231021145110.478744-1-Syed.SabaKareem@amd.com>
 <20231021145110.478744-12-Syed.SabaKareem@amd.com>
 <d5fba90c-24ab-4aff-8d6f-6d1443f4c10a@linux.intel.com>
From:   syed saba kareem <ssabakar@amd.com>
In-Reply-To: <d5fba90c-24ab-4aff-8d6f-6d1443f4c10a@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0066.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::11) To MN2PR12MB3661.namprd12.prod.outlook.com
 (2603:10b6:208:169::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3661:EE_|CY5PR12MB6405:EE_
X-MS-Office365-Filtering-Correlation-Id: c009e53d-3468-4322-ba9a-08dbd60afab1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cJqBZlHctzgs3evm3HgDk6BXLyI09+GKzWkGtRhcWZZ4Cw2eGao64rwjCa5FP3zcCDYAPYeN/k7zTZJrfpMhIY4h/FttkJaYQvdeQ4KhG6Oh+9eI7BhHhTW+IYXZAeCkhDda4+oLkIVWOyL10c/D4b6fbIFYX3HX4I6/np0VTrO3eP5LRYUuxbesfjqt7ONWyfbnY9/JGKHXDOdOK43ylR3ChkRcV/u8j6+cut7UMnc8u0gcsYo9DvOTxsf4HgP+CgoqQ9TbbVHXcOgWTJGWZ4U21E1Coc+xN1SiWNdcNGROHLyhxQK9nhdDFTNV5fd42km2as6J/YDEoVtfffX712wXiV/ftQ+rapH8FBIIFfKoU6jpTRd+DpQKAo+SbYLPDBPu8HLH/kXglY1QG+RVw3phKj2C65NK2tj1b4Mys/+hQMXaDNpoXWWX36RRFKl+k0TE2ado9TUKcyXryRiLkiigpS/mmv2ec7XuhO36nQx0dzSAFciWGBHcmzn033enDaVA3KEUvEtRW+odFuBVZIYInSyzdwZoCLidAghEl+7LLkITo+LIvwwLFCqI2UjiTalwufDlxfNxA7S8iSCDujjRemmsNnxgc3fPPBHXqUOSSTnTTB6xh51pBHHiSkIaxKLBsnyzVOuv7fQ9tAnBzQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3661.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(396003)(136003)(376002)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(66476007)(2906002)(38100700002)(31696002)(66946007)(316002)(66574015)(66556008)(6666004)(6506007)(110136005)(478600001)(2616005)(6512007)(6486002)(53546011)(83380400001)(54906003)(5660300002)(7416002)(41300700001)(8676002)(4326008)(36756003)(8936002)(26005)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MGkzV3dUU1lzVTlHMGZ4KzJCK1JWRmlJSC9Gb2xsbFhrM3E2aWFxbTV0Q0I1?=
 =?utf-8?B?RXpkQVQvMUQzODN1WUxhVXVpTFJmaE9zWW9PR2YxODRpWS9kR2lPaVFGeG5a?=
 =?utf-8?B?ZlNKdzR6ZzVXb3RhNWZUWE9kNnRwL3VnendOa2d3Q2piRzA4enJZMUkzdWxj?=
 =?utf-8?B?Mm1ZNS9uQjM5V0dYTC9HQ01wKzJxTHU5TVY4ZkdFVmtiVVo2Tko2WHdCdmtU?=
 =?utf-8?B?azlCbk8xWERadUtZR3c1QnJhOC9qZERBWlNFdHh6S1Q2bDMyUXhJZnErMS9k?=
 =?utf-8?B?SnhVR21tUXJ5MTVtSHd3WVd4NWp6UFpiUG1oQmcvblFxUys2QlYwblpsSktD?=
 =?utf-8?B?eUZkMVg5Ryt1em1TajFKZ0VPTEJKZm80QnY5UlNvcXFjVWhONzc0RFVqdkNx?=
 =?utf-8?B?aDJaQ0xRZTc2anZacHNkeW1jUC9GaytxdHB4V1h1alRwVzRrc2hLQS9sNnpZ?=
 =?utf-8?B?a05Hb2tJbEpPWUZrQ0MzVDVjaE9ORWQxbTRLcFJkYm1KOXhwd0JqblR1dzNT?=
 =?utf-8?B?b2VHMVR1bTU4ZFF1dFI0Z1pPMk5uZm5iT2tTaU5pRVYwU0V2bFNkcWRDTVZF?=
 =?utf-8?B?U21hU0Z6ZnJXQ25Wc1hzd0ZHNjE1dHlsL3ZxcitJdXlhSXJNTCthQWNJR2lH?=
 =?utf-8?B?UEowQzVkR25uK0tSb3pyWk5ydUkzR1orQVJlV1FRTXZTNmNwRittUklZUmNQ?=
 =?utf-8?B?S1AxTVlKZndBcXVPWDFjRWc4TFdESGc5WU4yT3hVM0kvVFRSbUMwTFFXL2pQ?=
 =?utf-8?B?Zy9QUVI4NkRjQ21WY3Y2S3JDL0tsQ2N3bXFHU0RWclB4Rm5IbUVyTVhtai9O?=
 =?utf-8?B?REtPT1ZrWS9oWVZyZXBhN2Q3QldVUjVwaFI2eVNFdytIWXVKZDh0dXRvV0JX?=
 =?utf-8?B?elorc3IrbGdQeElqY2F1UkJ2WGNHTW1HQU5wWis2a3NFdStDdTJma3cwakNZ?=
 =?utf-8?B?bHhDU1hvN2tPSERCRjQ5MkpJemwwSHVVNmpDVmY5V01Xa1BGalBNbjdMQWlO?=
 =?utf-8?B?ajJsSS9RYWRzcDBxc21iV3l0aXhKaDRJQ1NQbTFlSFlkUU1OVWgyQXIwcnF0?=
 =?utf-8?B?Q1JkUlZ1OTNub1BJVVk1NXV4TWhGalVuNm1nZGZRYlpmRGR1WFA4V215WVIr?=
 =?utf-8?B?M05wdVc0eEdRL2ZkL3FyRng4M24wTzljWFBZRE5Kb3ZLaWN2d3ZuWFdRUVRv?=
 =?utf-8?B?bkVYNkZVdEp4SFZhQmEreFhtRlZEdFJOZ2pMa0h2L0lkUzVLeXZ2L2FFU1Rz?=
 =?utf-8?B?aVVpWGwzbXZZQjd4a3pUQ3N1WUoyMkppMXZMUG1IbENyUkQzeFFOQndMSzQ2?=
 =?utf-8?B?VmpSU1pGZFRWYnhiU2pQbEZXbFkvRFNrbTV2QzRjR0xVRjRIR2VyVTAveGNr?=
 =?utf-8?B?eCtxTExEZGRmYUhDL2E2WmpIU09lTHFmSzR6WEhXb2ZkSVV4dVcwYktVNmoy?=
 =?utf-8?B?TTJncjZKL3ozckg2dVFiTTZmdHA2SENSOTFDK0tpajg3MGhkUlh0UmlXdzB2?=
 =?utf-8?B?eWE2U2oyYkJ5OWVNbXN6TzVPRjc3YlR0WndDY0ZKVVh1cEZ5QVRISW1TN1hY?=
 =?utf-8?B?R1cxS3g3RkJ1aTMvWS81TEd0bk1TdkpySWRaZlB1RWowS2FjWVZKS1hzYjND?=
 =?utf-8?B?SEVweC9sYWRWZDVjeHRrV2EwRHlYcDF5UE9tQ2VkT2ZOMkJMRngwczJBQTRi?=
 =?utf-8?B?RHRaeEdpUlFLTm5Wb0NuVmhuZU5qWHVSZHJhWEpVQ3hRMWJQZjY4ZENjQ0tS?=
 =?utf-8?B?d3pKWTV1RmxhMmxac1M0T0YzOVI5SXhWWXJNOVgyK0d3YnhzUjViVWFTWDEv?=
 =?utf-8?B?eVZOck9iM0NvblN4UnRhaXEzalFod21OMlN0VThCcnQyTlJ4dU5qazJZVXh2?=
 =?utf-8?B?ZzFqbHFPOGtMTG5XOGpMd2kyV2pEZXFldEYzaE53T1BxU0pZcXBGdXo2QTRt?=
 =?utf-8?B?TSt0S2hZblg2Um5SaDFpMUdieG1HRzZwNlIwdldiNERmaDB1MU9TZkpvcU13?=
 =?utf-8?B?TXQ5Y0JSdVYwbDRISmhVcVNKdVVmRE0ySGRPZGdmV0ltMlR0QkwrcU0vWkgx?=
 =?utf-8?B?elpSalE1dVFweCtIcE9QcFJuMWxaZFJ5OXM3Vi9YR3VsejNpajhBU0cvU0kr?=
 =?utf-8?Q?xEw3r/ZZ8qRGHUqFjlx+86b9K?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c009e53d-3468-4322-ba9a-08dbd60afab1
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3661.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 10:04:45.0129
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mt2U1VAIZo9PYrjkzVMr2KMAWcYbrCGBTUpfs+lPKtUOAQ1iRj/BXYcHvCVrOgJcQ95DVvbzeYcMfJ4mhlphYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6405
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/23/23 13:20, Amadeusz Sławiński wrote:
> On 10/21/2023 4:50 PM, Syed Saba Kareem wrote:
>> Add pci legacy driver support and create platform driver for
>> acp7.0 platform.
>>
>> Signed-off-by: Syed Saba Kareem <Syed.SabaKareem@amd.com>
>> ---
>
> ...
>
>> +
>> +static struct snd_soc_dai_driver acp70_dai[] = {
>> +{
>> +    .name = "acp-i2s-sp",
>> +    .id = I2S_SP_INSTANCE,
>> +    .playback = {
>> +        .stream_name = "I2S SP Playback",
>> +        .rates = SNDRV_PCM_RATE_8000_96000,
>> +        .formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S8 |
>> +               SNDRV_PCM_FMTBIT_U8 | SNDRV_PCM_FMTBIT_S32_LE,
>
> Any reason to not go from lowest bit width to higher? Similarly in 
> further definitions.
>  This has to be corrected, will push the changes as an incremental patch.
>> +        .channels_min = 2,
>> +        .channels_max = 8,
>> +        .rate_min = 8000,
>> +        .rate_max = 96000,
>> +    },
>
> ...
>
>> +
>> +static int __maybe_unused acp70_pcm_resume(struct device *dev)
>> +{
>> +    struct acp_dev_data *adata = dev_get_drvdata(dev);
>> +    struct acp_stream *stream;
>> +    struct snd_pcm_substream *substream;
>> +    snd_pcm_uframes_t buf_in_frames;
>> +    u64 buf_size;
>> +
>> +    spin_lock(&adata->acp_lock);
>> +    list_for_each_entry(stream, &adata->stream_list, list) {
>> +        if (stream) {
>> +            substream = stream->substream;
>> +            if (substream && substream->runtime) {
>> +                buf_in_frames = (substream->runtime->buffer_size);
>> +                buf_size = frames_to_bytes(substream->runtime, 
>> buf_in_frames);
>> +                config_pte_for_stream(adata, stream);
>> +                config_acp_dma(adata, stream, buf_size);
>> +                if (stream->dai_id)
>> +                    restore_acp_i2s_params(substream, adata, stream);
>> +                else
>> +                    restore_acp_pdm_params(substream, adata);
>> +            }
>> +        }
>> +    }
>> +        spin_unlock(&adata->acp_lock);
>> +        return 0;
>
> Indentation is wrong in above two lines.
>   This has to be corrected, will push the changes as an incremental 
> patch.
>> +}
>> +
>> +static const struct dev_pm_ops acp70_dma_pm_ops = {
>> +    SET_SYSTEM_SLEEP_PM_OPS(NULL, acp70_pcm_resume)
>> +};
>> +
>
>
