Return-Path: <linux-kernel+bounces-17154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9ED78248FB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 20:25:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8D881C223B0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 19:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B88A42C699;
	Thu,  4 Jan 2024 19:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wLKtai1J"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2058.outbound.protection.outlook.com [40.107.100.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53BFB2C1A4;
	Thu,  4 Jan 2024 19:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C6JUL0PohmUNoXQuDXiyulQBc3BdniPxDkBZPRMNBadDwYYdZ16oQRzi1HBkmq12728+9fRXmpd8R+9e710QI/+2ctPzxHsQ8jEYcnibdibR1GlMtQWfwMiPcWAsgk/T/xQKzhHBd89eloAvWaq6KhU8Abk3vnYbdP6Qnh9jbGreOVt3WJ62sWsW8xtWRfsruLxn2fPXfRSzI5iK+h5HAFhPkdU95+L5+WQREDzjFGh1fpyU69d7yi9dnE0FpXTH+JcgI2nVcg02ObOAvs2WwDexX3kFzP0m0WMm0YCgZGfzGxJlBp1npbz5/z8wRd2xSuFjT9U5o3qOQzzhY+ZS5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fcuUiwCXR19KgdHmsiGldOuSz90y5PMZLcumaTUfDgg=;
 b=jvSqvo1UqqACdUbb/oAxHTifyTQlUilUO0iNUzihu7vMClGvF8SvV3FhgH0D1UGslIKRFHzmmWMMWctmr5JF6c4jIULweKaVYP21b3C81alxzRxFGDbuwRYXj5cem7YDUIObKGK+4MT6lBARYFC10h4l1gYlxeza86KFkoZAxVNgdsG0QMD3DcLOY3ak3bC6l4BtyUnvx5r9yWit3PhoMGr8siI2wESDHY2MheYjiSNCs8/MBUN9HZ1S+5yM+zEVxrQvhXYkRncHi5Jkr0ynAaUSwQ/rDeA2uyqD+palHQlE7tXl5JKOcZipcqfecq4/23vgSj1bvayqtjelhCZhAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fcuUiwCXR19KgdHmsiGldOuSz90y5PMZLcumaTUfDgg=;
 b=wLKtai1J6dsZ+9mR+Us7P9YUMNk7YIvUpRfYLkKMjglTJXTrG13bl5UPOK09uPGSxXcMe+8sbmyhIJVPhrQB1+hhdZqC4UwhpHYzOkyJBQ2xfZxeSaQiKyLXEA5mSgSgZ4IKCixMXZfmEccZkFYJrjneNr0TC3qflL1mo1Ui8UI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH0PR12MB7982.namprd12.prod.outlook.com (2603:10b6:510:28d::5)
 by IA0PR12MB7529.namprd12.prod.outlook.com (2603:10b6:208:441::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Thu, 4 Jan
 2024 19:24:29 +0000
Received: from PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::e9c7:35dd:23f8:74a1]) by PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::e9c7:35dd:23f8:74a1%4]) with mapi id 15.20.7135.023; Thu, 4 Jan 2024
 19:24:29 +0000
Message-ID: <f33f28c9-67cf-ef18-3c97-93c225025c5c@amd.com>
Date: Thu, 4 Jan 2024 11:24:27 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH net-next 4/8] pds_core: Prevent race issues involving the
 adminq
To: Simon Horman <horms@kernel.org>, Brett Creeley <brett.creeley@amd.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 shannon.nelson@amd.com
References: <20240104171221.31399-1-brett.creeley@amd.com>
 <20240104171221.31399-5-brett.creeley@amd.com>
 <20240104191643.GL31813@kernel.org>
Content-Language: en-US
From: Brett Creeley <bcreeley@amd.com>
In-Reply-To: <20240104191643.GL31813@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0234.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::29) To PH0PR12MB7982.namprd12.prod.outlook.com
 (2603:10b6:510:28d::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7982:EE_|IA0PR12MB7529:EE_
X-MS-Office365-Filtering-Correlation-Id: cf11e152-cd40-43c6-119f-08dc0d5ac5b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	EI54hb1GRxhZZRMkO1VMRxwOzIm8WnjqFHAMxwr/6be7JekI8e4rp7KeKxm6EPx12kdTBUrI1D0yzbW2hmeKklRlEa04Y7L1KFxTjy5aXJ8UP0/sa87iXDvh/OoYF4vGauDhhqbiAuaAxBH+EB86XGB+2mNqh+gXXVBmWGv25Vaq1b8bxvSV8X9iDWoHU8Rz8ZPoeBg5vlMYDgYKMPAX0hUsDBaw15ZmnEOT03+4axvYS4oWZhesftjmz6NDGNfl90QfCHhyrgX6uwIvHfJbWLz/wuGoecs5J+qoGrHPiXDpjnKZKSSl16kZto9atCorVgug/E7zTL4gIT2UwgapTpZqNV+AU6zQHDOhDTIVntAn5U0QoS6seP0bmzLLp4nDKtoIwIaUdS962VMCpFHGOVOwmdaD5VaQ29KTixQaZnWBXP2TXQrH7NRUDfOyxm2WfYmyhTLxzd7Rk4QYgvYFuQn+ChJat81phsZuFoENDmruV3a+EmasQ8S/f1S1wdIwa1y0C1qugbqsh/3oSGndQ2uP4X8JIw+cw4b7y0bcXejkHmHPZICN2J/MR2f3hKR9pspatrVhMdp8pCB24vN1pD1OuBE+NOFXxUkHH/OANM2yv7EbTlAtf5+GVj2zlkZ/5PDbpGR/Rcvc+Ue3lleqBXZIGeEttj9hCyD650Suw+rMaVTWK+IDnCCz3zplLrlg
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7982.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(39860400002)(136003)(396003)(346002)(230173577357003)(230922051799003)(230273577357003)(64100799003)(186009)(451199024)(1800799012)(6486002)(478600001)(110136005)(8936002)(8676002)(316002)(6636002)(66556008)(66946007)(4326008)(83380400001)(66476007)(41300700001)(53546011)(6512007)(6506007)(2616005)(2906002)(5660300002)(26005)(36756003)(38100700002)(31696002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RWozWlA4cnZ6R00zeUFkdGl1a3VCZmFkZUhPaHJlZHVqTXVwT2JLRmsvVGVN?=
 =?utf-8?B?K1RoVDRtbThQU091VXZkY1I0cjNUb1FMVWZ1L1gvREFzbDh1YWZoRGtqeVpM?=
 =?utf-8?B?cWhPRytZd21YRE9PYk1ZS2pDZW5JbUJGRjdGcUtCb00rdlk5emEvYmIrNEl1?=
 =?utf-8?B?cWlTVWRiUFFwN0pkSUUxdDVlUzZLZkQvejQ2SmZpelVDRGM2RUNJdTNqMk0r?=
 =?utf-8?B?NUxHbnYxWTVYOEF6WHJLTDA0Q3VyRE1Kbko1cjNXMEpYQXV3TWVna0gyZ0Fq?=
 =?utf-8?B?VC9GU3pGaWNVRGlkWDlFWmp1ZnNZUTkwUzNtM3Bwcy8wWXVoRkUwR09QTllt?=
 =?utf-8?B?QThzMm9LUE1SUnJFUkpkK25aMGZNb2Yrb1dmeE5KVGdoZ29PYWhHdTV5WWlj?=
 =?utf-8?B?a1JNdjNSRWVXYTVmRTdhKzl0U2JUYTJ0Z3BtbEcxUDdnbHhrK0JXdnBDNmV6?=
 =?utf-8?B?bXU4eXlOZ2ZGblY5di9RVDdGL1pwTm1NaWovbFpOWG95Y3FjN2MrV29QSTFl?=
 =?utf-8?B?MGgyRWFqMk1KRDl6VUllcEpubDd0TlNVSVROTUVHT0JrTjJNQjlKYVozNzM0?=
 =?utf-8?B?RWQvek5KMFhPczhSWGsxbUhod1hpVVc3VDU5R3A1UjMvcG43bGFlUStuemdt?=
 =?utf-8?B?UlJtZkRIOHZSV0dTdU9GODVqaE8xaGxSRzR1YllkZ0dJam84cmdsV2Z6R05S?=
 =?utf-8?B?OVl0dS93ais0TFNOeUFhRXpVYy9BV3BxODVrZlF6MzJnZ2xETDhkVGpDL2JT?=
 =?utf-8?B?a0dKOVMzZjdPQ2wxejQxL0xXWXpSQ3FNaDMwR01IYkVLR0wxRzdzdmxBdXZh?=
 =?utf-8?B?aDVKdlZMcGdaV2dRaW1NOVp3eG1QNnNvM2FmMGtPT205TjgvdUY0UUhjdTk3?=
 =?utf-8?B?RW5JODlxMmtCVTFZT0Rsa2hpWFJlRTk4QTdPMEw3K1NiVVNBL3JUeTFLalNC?=
 =?utf-8?B?TTh2OU9sTFJSZTVsV3NwWi8yNGUvZCtDSEFBR0RsTm5CaFpWTnNSdGJJRWt0?=
 =?utf-8?B?VlhseHRoRzM0eWRaaG8vVnlxRWZOUlZEZjN1NFErTCs5dWhIaGxJMTFNOEVj?=
 =?utf-8?B?NGdwRFlocDlDdlZrT0dLcEFXL0R1UWxIUDZJdFE4NG5CM2huSXhNZmMzQVpY?=
 =?utf-8?B?QVgrSm51Z01WZWExU3hmakFobTJLbDZSYjZ5ZVlsYzZXMlVDamtXbG1URnR3?=
 =?utf-8?B?SEJFcGxnVEswN3FSOU56ZUk5dXBPV281eU9HckZrQ0ZMS01tTmZlMDk2ZTZ2?=
 =?utf-8?B?SHArSGt0YXhXUys1dVhYMlZObXJPUk10UHphWWJWdjBhNno2b1V5RnF0L0ky?=
 =?utf-8?B?K1d4Q0RBOHBSdEhMYXR4dDlLSEgyak5UU3dQc2RmbERLQnl1TC9DY2Z6K3VL?=
 =?utf-8?B?cGcvNmM1ZUxlblhaSjBqN3RiOC9wcHFQaXJRZzlvL1B2Ny9GSk9aRnM5ZUZM?=
 =?utf-8?B?OUNUTnVTSnlCYzVGYWMxdWh6NDllRUVyeE1tOGx2MzZrbU1lVVJmWnVWTUJQ?=
 =?utf-8?B?cENmdWZxUGhscTVlUHdLKzYzZFVYczdnbGdZVTNhdEM1VExWd0V1QXZ2NDRP?=
 =?utf-8?B?Y1lPdTBkRVhPdjNpYlJFamxIZE9pbEpSMkFGSXZka1dxVkFnVGtYdGhZT3Jw?=
 =?utf-8?B?WGNPOFJrclhBU3ZJY3V0SDNlUUdOdkFabFdTSGlMRFF2UUdmbExVT0tHb0hF?=
 =?utf-8?B?TXpyNGRmWUh3d1YvS052Z2VFNDh5TG03ZlJSczZzNFBYaWNBRmZNRFZ4VlJX?=
 =?utf-8?B?REhEcERtUTF6bHlIVWVwTnI1ZEFJQXh0TXVHRlhYUy80cVJETU5jcjd3WFll?=
 =?utf-8?B?S1B5dEpQVmF0bm5Wa2VhbVlqL3owWmtRVWMxN1NBUGdjYngvd1NqN002dDRx?=
 =?utf-8?B?TTR2UFhJV04vZkcrZ3dWc2pDTnRHbmsxbmpCRElPQ09na3BYWXFFQ21iSGNl?=
 =?utf-8?B?cHFrV3d1THdJV1BzYVVjdy80UXVoTXJaSXpXdVUzU0doNlRZa3puVnBkdXZ4?=
 =?utf-8?B?cm4rNjl6MGw4TTA5aDBHRTZWd1MvQUlOMVZTcG85V0cwY3lPNElJbzlrbmo1?=
 =?utf-8?B?czRvSFZvK1BBUURyRGZkeXVUZmdCbjBmUm5raDV1d0p6a3N4dnZGMVF1ZU10?=
 =?utf-8?Q?VkM0a2NnIhgWQyr5P8VsuoHn8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf11e152-cd40-43c6-119f-08dc0d5ac5b9
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7982.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 19:24:29.6650
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hHqvfLkEx08ZSYAJDksqGj/827doCIpBvrt4eBHYa/KMu/FJVAxsgpO66RUft5S6/YD+yppQVntGf/5mbbg9Vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7529



On 1/4/2024 11:16 AM, Simon Horman wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> On Thu, Jan 04, 2024 at 09:12:17AM -0800, Brett Creeley wrote:
>> There are multiple paths that can result in using the pdsc's
>> adminq.
>>
>> [1] pdsc_adminq_isr and the resulting work from queue_work(),
>>      i.e. pdsc_work_thread()->pdsc_process_adminq()
>>
>> [2] pdsc_adminq_post()
>>
>> When the device goes through reset via PCIe reset and/or
>> a fw_down/fw_up cycle due to bad PCIe state or bad device
>> state the adminq is destroyed and recreated.
>>
>> A NULL pointer dereference can happen if [1] or [2] happens
>> after the adminq is already destroyed.
>>
>> In order to fix this, add some further state checks and
>> implement reference counting for adminq uses. Reference
>> counting was used because multiple threads can attempt to
>> access the adminq at the same time via [1] or [2]. Additionally,
>> multiple clients (i.e. pds-vfio-pci) can be using [2]
>> at the same time.
>>
>> The adminq_refcnt is initialized to 1 when the adminq has been
>> allocated and is ready to use. Users/clients of the adminq
>> (i.e. [1] and [2]) will increment the refcnt when they are using
>> the adminq. When the driver goes into a fw_down cycle it will
>> set the PDSC_S_FW_DEAD bit and then wait for the adminq_refcnt
>> to hit 1. Setting the PDSC_S_FW_DEAD before waiting will prevent
>> any further adminq_refcnt increments. Waiting for the
>> adminq_refcnt to hit 1 allows for any current users of the adminq
>> to finish before the driver frees the adminq. Once the
>> adminq_refcnt hits 1 the driver clears the refcnt to signify that
>> the adminq is deleted and cannot be used. On the fw_up cycle the
>> driver will once again initialize the adminq_refcnt to 1 allowing
>> the adminq to be used again.
>>
>> Signed-off-by: Brett Creeley <brett.creeley@amd.com>
>> Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>
> 
> ...
> 
>> diff --git a/drivers/net/ethernet/amd/pds_core/core.c b/drivers/net/ethernet/amd/pds_core/core.c
>> index 0356e56a6e99..3b3e1541dd1c 100644
>> --- a/drivers/net/ethernet/amd/pds_core/core.c
>> +++ b/drivers/net/ethernet/amd/pds_core/core.c
>> @@ -450,6 +450,7 @@ int pdsc_setup(struct pdsc *pdsc, bool init)
>>                pdsc_debugfs_add_viftype(pdsc);
>>        }
>>
>> +     refcount_set(&pdsc->adminq_refcnt, 1);
>>        clear_bit(PDSC_S_FW_DEAD, &pdsc->state);
>>        return 0;
>>
>> @@ -514,6 +515,24 @@ void pdsc_stop(struct pdsc *pdsc)
>>                                           PDS_CORE_INTR_MASK_SET);
>>   }
>>
>> +void pdsc_adminq_wait_and_dec_once_unused(struct pdsc *pdsc)
> 
> Hi Brett,
> 
> a minor nit from my side: pdsc_adminq_wait_and_dec_once_unused is only used
> in this file so perhaps it should be static?

Simon,

Yep, looks like I missed that. Good catch.

Thanks,

Brett

> 
>> +{
>> +     /* The driver initializes the adminq_refcnt to 1 when the adminq is
>> +      * allocated and ready for use. Other users/requesters will increment
>> +      * the refcnt while in use. If the refcnt is down to 1 then the adminq
>> +      * is not in use and the refcnt can be cleared and adminq freed. Before
>> +      * calling this function the driver will set PDSC_S_FW_DEAD, which
>> +      * prevent subsequent attempts to use the adminq and increment the
>> +      * refcnt to fail. This guarantees that this function will eventually
>> +      * exit.
>> +      */
>> +     while (!refcount_dec_if_one(&pdsc->adminq_refcnt)) {
>> +             dev_dbg_ratelimited(pdsc->dev, "%s: adminq in use\n",
>> +                                 __func__);
>> +             cpu_relax();
>> +     }
>> +}
>> +
>>   void pdsc_fw_down(struct pdsc *pdsc)
>>   {
>>        union pds_core_notifyq_comp reset_event = {
>> @@ -529,6 +548,8 @@ void pdsc_fw_down(struct pdsc *pdsc)
>>        if (pdsc->pdev->is_virtfn)
>>                return;
>>
>> +     pdsc_adminq_wait_and_dec_once_unused(pdsc);
>> +
>>        /* Notify clients of fw_down */
>>        if (pdsc->fw_reporter)
>>                devlink_health_report(pdsc->fw_reporter, "FW down reported", pdsc);
> 
> ...

