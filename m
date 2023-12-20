Return-Path: <linux-kernel+bounces-7361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A88581A688
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 18:44:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE2E31F24888
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 17:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B28481AC;
	Wed, 20 Dec 2023 17:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XcsEjzmy"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2047.outbound.protection.outlook.com [40.107.93.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991EA47A7B
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 17:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GMFGfelpu2AJ6el8CoUgRH+omfBMGFHXKtL7cFu8brZsEqANm/SmWq3BMFUop8MJVuBTgGD7S4Ev0N61ctzHr1qvEHojroQafm9DO2euoXTB7GrzWFwC71IbtLLL3TtLc62B0GHQ4sf5Xt5Z7Zc78Anml36bgznYE57J1JgnvmiubtNmRLX9rpJQYnBkzFeKMy9xAFRFJaaR01GwiksRVJS2X7aAJCSuBnuquUw4bbzMN3ukpuRitJfZaGnxa7yiaFgbfssbx95Cz1HyLpeqHWzUyAsg3cYX3vmiabJOhxuu7EAznS6fEk28NRzx0SZCpQQdMCCne/JkSxzi7k9z7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MPLI9Y4qRhqBkktfqUTNeZey5CQRku3L8xi1f1Ji3lo=;
 b=gJ4BFD79KGnL/olnRUTelI0ZJV2MU50kBqoIi4GZrpRZKT/VsBt4q5ERwxEgElW61YybRQG2mkypAyOMjKJPD/Iskgrv+YG3Qa4V0K2W8smjVWCR5E8NX/Q9cwW5txa+hRSKlsJsVBM5CCckswP/7al/OG9NanZivMGcDZ0gQS/bc0cqIpNgL09iQLAmuPWjKpabbFZxVgi+hDGlaBFXX9hhrt0+XOXgN6KsS8tT3kaeOIVY99uSF1WncAHICtfGYIZVU6iJk0mBSGJGGYjTsoHm8k3S3C9ygNBQptzl6atUyVFOP5EXG/AfBve818ZAWVgoOhddsMEpL628mytzZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MPLI9Y4qRhqBkktfqUTNeZey5CQRku3L8xi1f1Ji3lo=;
 b=XcsEjzmyeenFwgTMqIhuC8Vprla4PLO0tUHHfVmmPKWvChmbJEdZwr9PqvfykCRMnE+XZdFbBGsYPJkLYK8uXeDVWlnluflnOJJ/eqQRTgkyiCdD4xBjWI7L3xYwE5GIOewFkk/mq0hrq2jJK/ZauLV3PYGh4nl9IT884Jl5ZIk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA3PR12MB8021.namprd12.prod.outlook.com (2603:10b6:806:305::16)
 by PH7PR12MB7889.namprd12.prod.outlook.com (2603:10b6:510:27f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Wed, 20 Dec
 2023 17:44:38 +0000
Received: from SA3PR12MB8021.namprd12.prod.outlook.com
 ([fe80::c7c5:8d05:4f77:e335]) by SA3PR12MB8021.namprd12.prod.outlook.com
 ([fe80::c7c5:8d05:4f77:e335%7]) with mapi id 15.20.7113.016; Wed, 20 Dec 2023
 17:44:38 +0000
Message-ID: <caab8bb6-7e14-423b-ad97-7d193e6598bc@amd.com>
Date: Wed, 20 Dec 2023 09:44:36 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] mailbox: zynqmp: Move buffered IPI setup to of_match
 selected routine
Content-Language: en-US
To: Michal Simek <michal.simek@amd.com>, jassisinghbrar@gmail.com,
 linux-kernel@vger.kernel.org
Cc: shubhrajyoti.datta@amd.com, tanmay.shah@amd.com,
 linux-arm-kernel@lists.infradead.org
References: <20231214211354.348294-1-ben.levinsky@amd.com>
 <20231214211354.348294-3-ben.levinsky@amd.com>
 <c7ea6fd6-b4cd-45e5-b1b0-12c8e2aa8696@amd.com>
From: Ben Levinsky <ben.levinsky@amd.com>
In-Reply-To: <c7ea6fd6-b4cd-45e5-b1b0-12c8e2aa8696@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR16CA0033.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::46) To SA3PR12MB8021.namprd12.prod.outlook.com
 (2603:10b6:806:305::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB8021:EE_|PH7PR12MB7889:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d0c42e5-27a5-4df1-771b-08dc01835684
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	oESnxy7oiToXOJkamSc5vq1vayZtPedgn7eHNV31vGhCW+ejF9ug6Z0iNtv8XiIPx4yBj4ZFR+zwBa5mB8bJWQs62IZnOnXjW+R+hrDxONxiQ7gQPV2jJNxfPe25SIgsx2lkewtqGAXmWF9uGb1VYHK3HRY3ZsbpB7Vf3niMZGGjhSa+coO5CMzMDKPZvaQPLz5XW1/nTLsNWHKFbdGXzKumMYTO8iFsvGDNB1BgrzRnsObWVat5F9b+Pl3SGJskIPfDyyg+ZrYg3MeY/T10l9n5ydAtjyi5md3abKnNoOHnvYxAbAqfttV3wTiqKnaZY2CmtEmxm/xbAGYi0BiU9UiBU8qjfjMYdIsjHlItzyGugNO1iPpzArC6IB4e6lHQLurNOw/YvALdvnBI3JCNy/DP9ijJcwM2MdqCTF/YFvjoXCGfrlFMAb1RtpJTWV6QY3KgqZNYGhZZXxAWZY7oPkbH5PLfWkLF+b9D1w33+OJXvf+Mf5OGiqOpuPGnGtVNxKahO3rLl96SBGBunEHVCbU+754VgBo1BGJffvfvhD8Rpl1NW9x7HtVEFbv2tQ8g21vXKaFt06ln6fOyCm62ro/o+cUAi1qfumbn2muv4GBRFcElcFr6pNwi73bM7667keWE2kbUlGIxGNrGGR6G9w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB8021.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(376002)(136003)(366004)(346002)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(2616005)(6512007)(31686004)(83380400001)(36756003)(86362001)(38100700002)(31696002)(6506007)(26005)(53546011)(478600001)(6486002)(4326008)(8936002)(316002)(5660300002)(44832011)(15650500001)(8676002)(2906002)(41300700001)(66556008)(66476007)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Sk5HdTZMcDdIejZ3eWhiU0FMb2FzNkIxTC9jNGd3aFhUblJMWmZmazVJM3J3?=
 =?utf-8?B?UFR5Kzd5YmtPTXIzbXlpeW96cVVINXBrKzZNMEo1alphVDlhcVR6SEVPVEN2?=
 =?utf-8?B?am5oaWl5NDZURENJdlFCT25RL0FNUDdBU1FvYURJQkpLN29RZER5NzRjeWFk?=
 =?utf-8?B?dmVkdnVRUzlTeU0yTXBJNVZ3ajJYSXcvY1VhbnlWS3grd2xqdmFkc0RobGZJ?=
 =?utf-8?B?K0FyRGZWb3VCMGhNRGtNdlFYaWNVd3p2Tk9NOU5oS0YrNHRsRHllN3daUE81?=
 =?utf-8?B?WERpbFp0eEdIa055R3NNb3pmWDg4eGFBbnB4OFZSMWgwOTRWL2NRM242SUg3?=
 =?utf-8?B?U004QkoxVFB0WTQrMlVLREJobFJhL3JoZTQ2dU53Z0x2OTBEU21sY1R4L1RZ?=
 =?utf-8?B?M3FidnZLckFJWm81SXQ0MmNRZmIzSGJlbnhJQU43U2w4K2VhZjErWndMaVRE?=
 =?utf-8?B?SjNTcTZNSEZuRnMxVDNVb3ljTUtVWHl4M3JZYkV0Tkhsa3JuS1FUT0REMTd3?=
 =?utf-8?B?ckM2dUNSWDNqdUxOZWNFbGNHNW15ZzUzWWpnMi9KZ0d1T3ZaQm10T2Z5Zm9r?=
 =?utf-8?B?NlpxbGlnYi9yVWR4UGs5b0liQ21ZbDNTMG5WUDZGTTFwcDkxNWpDakZySjZh?=
 =?utf-8?B?Uzd0Q3NrNTFYZkhEZStjZjdZQjZIZ25BYzliQUJ6YzF0eENMUnJadUpQUXZX?=
 =?utf-8?B?L1laSVh1MWIwVWZmSjlGa05VUXFJNDlGK21heUxMS2pYd0lvQ1NlVkVOL2hI?=
 =?utf-8?B?N3piQ0NRcG9QZTA1OVFvelJCMkhsMzJvOWE0dXVIOXFaZkRvRys5dXJwMlpK?=
 =?utf-8?B?VmlQYjJkU2x5SnFkSDA2SCt1dXR0aURXYWNCR2RxaERad2tMZHBSOHNFczdB?=
 =?utf-8?B?SFo5RGtYYkpBM1Bmc1ZaL3c1T2JjeG5aT1dpNTZ0eWpLRUxwR0grNTZ5dTdQ?=
 =?utf-8?B?L3A0Zm02MnRZOFlLaFh6eGNNVHc3WVZhemN5S0dFazFaaWh6cTQzTDRldDk1?=
 =?utf-8?B?R2E0QmlGY082R3lXckxNNUZNT0xUY2pFazZONVRmdzhrRGpENEdOU3RFUWQ2?=
 =?utf-8?B?YjJIMFgvd0VIMno2Rmd2UlFSWFZ1U0xiUEpsZkMrMkNoUGVxZzMxd0tHeGE0?=
 =?utf-8?B?NVpRQ0JJMTI0eVh0cXdCUlR0ZTRScXQwQTN2WnRHM01xMmVmOGRSdktOSGVl?=
 =?utf-8?B?V2FFTnUrbjh5bkU1aVRmT2phYkJ5Rjk2QVZueEJYaDVpdUpBUDlzL0JFcGw5?=
 =?utf-8?B?SFdVMVZkN0JVUUsvbStOK0F1V005cVl2c3VxS1lLYzNXOXAxeEdBYUM0UWpT?=
 =?utf-8?B?SGZidVEyQS9XakxZbGR2NWJwK3NKK3ZTUGRsK0lyNHZleG1DZGtaQnJxUlpT?=
 =?utf-8?B?WFAxSTMyTDcra1o0alpCTFp2N2FxTWEzcFphL1MwL3ZlcmlhZUdQODVIbEpm?=
 =?utf-8?B?N0dUaTdVbDNYWkJtNlY3dWtKQjJhT2wzNWpiVjJJSU1iVUNJejVyTk1wUlMz?=
 =?utf-8?B?QTYyRTJTTTE1WDMwWGVEdThST0pTSXJhNnNSME9zOENvV2g1MjlTaFpEZ1d6?=
 =?utf-8?B?RGROR1pwNVVjOVlJeHEveElRekVCTUZyd0JoRTd1U1VmOE5GYWRDU2NTMkRP?=
 =?utf-8?B?QkplcUFndzVKVUtYSU4wVXZpVW9ZTkR0Zis2QmhLMzRTWjZPano4UlFaOW1r?=
 =?utf-8?B?ZHRIRjhWdFFoRUhFWVlva3dOekhSNWt5UnRIZktSeVNEbE1tUGF6bkI3YlYv?=
 =?utf-8?B?eDdxazQ3d095TUVMWlZ0cWtTa2t1T2trRnlxT2Jxc1k2MFI1QnMvb1lsYTVR?=
 =?utf-8?B?Vm9hRlAwcTRwQ0toNkFOT0dvblNqa1BkRjhPYWUxMUVGMng4bHo1MDcwSEVR?=
 =?utf-8?B?S0MyYnVOblRSelBWMU82MjA3d0crR1lud3p4dUgxellmbXhDUlVLdjMwb0Jm?=
 =?utf-8?B?RmlGSkVkSXplUHp1NExkL3NFWlAxZ0dvaDYvSzh4TzBoK3NDWWozcHpqVDZl?=
 =?utf-8?B?dEV6SkJLcU5iYWhsNVl2L204bUFrSHM0b3pVQTBYU2M3U28rN1UxdWJQY1dt?=
 =?utf-8?B?SHdsZVZJLzhNbE5TNFF6djk2THNaTExVRXJXTlFBMUtyeDFucmpWMEJlL3dV?=
 =?utf-8?Q?nHeRB7nrPHsbhoOoc1gLYlclr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d0c42e5-27a5-4df1-771b-08dc01835684
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB8021.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 17:44:38.4626
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UTblwNFCzz0urKWYMu8JrDctRaXheT4em3M6uaicZsLbrNEAU+rnJBi2AmCaxxJjjVmEmHBMXxWsP/kBhxq/UQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7889


On 12/20/23 5:23 AM, Michal Simek wrote:
>
>
> On 12/14/23 22:13, Ben Levinsky wrote:
>> Move routine that initializes the mailboxes for send and receive to
>> a function pointer that is set based on compatible string.
>>
>> Signed-off-by: Ben Levinsky <ben.levinsky@amd.com>
>> ---
>>   drivers/mailbox/zynqmp-ipi-mailbox.c | 124 +++++++++++++++++++--------
>>   1 file changed, 89 insertions(+), 35 deletions(-)
>>
>> diff --git a/drivers/mailbox/zynqmp-ipi-mailbox.c b/drivers/mailbox/zynqmp-ipi-mailbox.c
>> index 2c10aa01b3bb..edefb80a6e47 100644
>> --- a/drivers/mailbox/zynqmp-ipi-mailbox.c
>> +++ b/drivers/mailbox/zynqmp-ipi-mailbox.c
>> @@ -72,6 +72,10 @@ struct zynqmp_ipi_mchan {
>>       unsigned int chan_type;
>>   };
>>   +struct zynqmp_ipi_mbox;
>> +
>> +typedef int (*setup_ipi_fn)(struct zynqmp_ipi_mbox *ipi_mbox, struct device_node *node);
>> +
>>   /**
>>    * struct zynqmp_ipi_mbox - Description of a ZynqMP IPI mailbox
>>    *                          platform data.
>> @@ -82,6 +86,7 @@ struct zynqmp_ipi_mchan {
>>    * @mbox:                 mailbox Controller
>>    * @mchans:               array for channels, tx channel and rx channel.
>>    * @irq:                  IPI agent interrupt ID
>> + * setup_ipi_fn:          Function Pointer to set up IPI Channels
>
> Here should be @setup_ipi_fn.
will fix.
>
>>    */
>>   struct zynqmp_ipi_mbox {
>>       struct zynqmp_ipi_pdata *pdata;
>> @@ -89,6 +94,7 @@ struct zynqmp_ipi_mbox {
>>       u32 remote_id;
>>       struct mbox_controller mbox;
>>       struct zynqmp_ipi_mchan mchans[2];
>> +    setup_ipi_fn setup_ipi_fn;
>>   };
>>     /**
>> @@ -466,12 +472,9 @@ static void zynqmp_ipi_mbox_dev_release(struct device *dev)
>>   static int zynqmp_ipi_mbox_probe(struct zynqmp_ipi_mbox *ipi_mbox,
>>                    struct device_node *node)
>>   {
>> -    struct zynqmp_ipi_mchan *mchan;
>>       struct mbox_chan *chans;
>>       struct mbox_controller *mbox;
>> -    struct resource res;
>>       struct device *dev, *mdev;
>> -    const char *name;
>>       int ret;
>>         dev = ipi_mbox->pdata->dev;
>> @@ -491,6 +494,75 @@ static int zynqmp_ipi_mbox_probe(struct zynqmp_ipi_mbox *ipi_mbox,
>>       }
>>       mdev = &ipi_mbox->dev;
>>   +    /* Get the IPI remote agent ID */
>> +    ret = of_property_read_u32(node, "xlnx,ipi-id", &ipi_mbox->remote_id);
>> +    if (ret < 0) {
>> +        dev_err(dev, "No IPI remote ID is specified.\n");
>> +        return ret;
>> +    }
>> +
>> +    ret = ipi_mbox->setup_ipi_fn(ipi_mbox, node);
>> +    if (ret) {
>> +        dev_err(dev, "Failed to set up IPI Buffers.\n");
>> +        return ret;
>> +    }
>> +
>> +    mbox = &ipi_mbox->mbox;
>> +    mbox->dev = mdev;
>> +    mbox->ops = &zynqmp_ipi_chan_ops;
>> +    mbox->num_chans = 2;
>> +    mbox->txdone_irq = false;
>> +    mbox->txdone_poll = true;
>> +    mbox->txpoll_period = 5;
>> +    mbox->of_xlate = zynqmp_ipi_of_xlate;
>> +    chans = devm_kzalloc(mdev, 2 * sizeof(*chans), GFP_KERNEL);
>> +    if (!chans)
>> +        return -ENOMEM;
>> +    mbox->chans = chans;
>> +    chans[IPI_MB_CHNL_TX].con_priv = &ipi_mbox->mchans[IPI_MB_CHNL_TX];
>> +    chans[IPI_MB_CHNL_RX].con_priv = &ipi_mbox->mchans[IPI_MB_CHNL_RX];
>> +    ipi_mbox->mchans[IPI_MB_CHNL_TX].chan_type = IPI_MB_CHNL_TX;
>> +    ipi_mbox->mchans[IPI_MB_CHNL_RX].chan_type = IPI_MB_CHNL_RX;
>> +    ret = devm_mbox_controller_register(mdev, mbox);
>> +    if (ret)
>> +        dev_err(mdev,
>> +            "Failed to register mbox_controller(%d)\n", ret);
>> +    else
>> +        dev_info(mdev,
>> +             "Registered ZynqMP IPI mbox with TX/RX channels.\n");
>> +    return ret;
>> +}
>> +
>> +/**
>> + * zynqmp_ipi_setup - set up IPI Buffers for classic flow
>> + *
>> + * @ipi_mbox: pointer to IPI mailbox private data structure
>> + * @node: IPI mailbox device node
>> + *
>> + * This will be used to set up IPI Buffers for ZynqMP SOC if user
>> + * wishes to use classic driver usage model on new SOC's with only
>> + * buffered IPIs.
>> + *
>> + * Note that bufferless IPIs and mixed usage of buffered and bufferless
>> + * IPIs are not supported with this flow.
>> + *
>> + * This will be invoked with compatible string "xlnx,zynqmp-ipi-mailbox".
>> + *
>> + * Return: 0 for success, negative value for failure
>> + */
>> +static int zynqmp_ipi_setup(struct zynqmp_ipi_mbox *ipi_mbox,
>> +                struct device_node *node)
>> +{
>> +    struct zynqmp_ipi_mchan *mchan;
>> +    struct device *mdev;
>> +    struct resource res;
>> +    struct device *dev;
>
> nit: you can put it to the same line mdev, dev.
will fix.
>
>> +    const char *name;
>> +    int ret;
>> +
>> +    mdev = &ipi_mbox->dev;
>> +    dev = ipi_mbox->pdata->dev;
>> +
>>       mchan = &ipi_mbox->mchans[IPI_MB_CHNL_TX];
>>       name = "local_request_region";
>>       ret = zynqmp_ipi_mbox_get_buf_res(node, name, &res);
>> @@ -565,37 +637,7 @@ static int zynqmp_ipi_mbox_probe(struct zynqmp_ipi_mbox *ipi_mbox,
>>       if (!mchan->rx_buf)
>>           return -ENOMEM;
>>   -    /* Get the IPI remote agent ID */
>> -    ret = of_property_read_u32(node, "xlnx,ipi-id", &ipi_mbox->remote_id);
>> -    if (ret < 0) {
>> -        dev_err(dev, "No IPI remote ID is specified.\n");
>> -        return ret;
>> -    }
>> -
>> -    mbox = &ipi_mbox->mbox;
>> -    mbox->dev = mdev;
>> -    mbox->ops = &zynqmp_ipi_chan_ops;
>> -    mbox->num_chans = 2;
>> -    mbox->txdone_irq = false;
>> -    mbox->txdone_poll = true;
>> -    mbox->txpoll_period = 5;
>> -    mbox->of_xlate = zynqmp_ipi_of_xlate;
>> -    chans = devm_kzalloc(mdev, 2 * sizeof(*chans), GFP_KERNEL);
>> -    if (!chans)
>> -        return -ENOMEM;
>> -    mbox->chans = chans;
>> -    chans[IPI_MB_CHNL_TX].con_priv = &ipi_mbox->mchans[IPI_MB_CHNL_TX];
>> -    chans[IPI_MB_CHNL_RX].con_priv = &ipi_mbox->mchans[IPI_MB_CHNL_RX];
>> -    ipi_mbox->mchans[IPI_MB_CHNL_TX].chan_type = IPI_MB_CHNL_TX;
>> -    ipi_mbox->mchans[IPI_MB_CHNL_RX].chan_type = IPI_MB_CHNL_RX;
>> -    ret = devm_mbox_controller_register(mdev, mbox);
>> -    if (ret)
>> -        dev_err(mdev,
>> -            "Failed to register mbox_controller(%d)\n", ret);
>> -    else
>> -        dev_info(mdev,
>> -             "Registered ZynqMP IPI mbox with TX/RX channels.\n");
>> -    return ret;
>> +    return 0;
>>   }
>>     /**
>> @@ -626,6 +668,7 @@ static int zynqmp_ipi_probe(struct platform_device *pdev)
>>       struct zynqmp_ipi_pdata *pdata;
>>       struct zynqmp_ipi_mbox *mbox;
>>       int num_mboxes, ret = -EINVAL;
>> +    setup_ipi_fn ipi_fn;
>>         num_mboxes = of_get_available_child_count(np);
>>       if (num_mboxes == 0) {
>> @@ -646,9 +689,18 @@ static int zynqmp_ipi_probe(struct platform_device *pdev)
>>           return ret;
>>       }
>>   +    ipi_fn = (setup_ipi_fn)device_get_match_data(&pdev->dev);
>> +    if (!ipi_fn) {
>> +        dev_err(dev,
>> +            "Mbox Compatible String is missing IPI Setup fn.\n");
>> +        return -ENODEV;
>> +    }
>> +
>>       pdata->num_mboxes = num_mboxes;
>>         mbox = pdata->ipi_mboxes;
>> +    mbox->setup_ipi_fn = ipi_fn;
>> +
>>       for_each_available_child_of_node(np, nc) {
>>           mbox->pdata = pdata;
>>           ret = zynqmp_ipi_mbox_probe(mbox, nc);
>> @@ -694,7 +746,9 @@ static int zynqmp_ipi_remove(struct platform_device *pdev)
>>   }
>>     static const struct of_device_id zynqmp_ipi_of_match[] = {
>> -    { .compatible = "xlnx,zynqmp-ipi-mailbox" },
>> +    { .compatible = "xlnx,zynqmp-ipi-mailbox",
>> +      .data = &zynqmp_ipi_setup,
>> +    },
>>       {},
>>   };
>>   MODULE_DEVICE_TABLE(of, zynqmp_ipi_of_match);
>
>
> M

