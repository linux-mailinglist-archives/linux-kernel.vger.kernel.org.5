Return-Path: <linux-kernel+bounces-7795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A46A181AD14
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 04:15:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27A421F24D76
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 03:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85FDFD29D;
	Thu, 21 Dec 2023 03:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="6HMNgOcq"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2094.outbound.protection.outlook.com [40.107.93.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D267C63A5
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 03:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YmR0AJT4Wx1fDg6rJgD9ePAR6XGzSeFHQecIphUvi/Q1bJpWRiI1saNizEj1uzZcWDqY92Tk7ZZYOCT2rGZvxSzSh/tRoSO5rSndgcH3tmmdrnFShaKWr8Vht9LtFjSJimFSiAGEvqlpHB6ntCOhIbuTYzE9GFHTDlooeELIp0Lv/LGVljb0UJFQovGv603R1Ba+ctcZPD9HWTxQy4foRIgI1YPwXqG86/t2ZKACShiW7oERvgbdPgeNY8lnlMadU6dHtQvCBae2RJYmfWx2XUMr5SY4UGJB8UvMq5qDG97VmVeAuqHkODekjEMKwzfv/rD40uMlSUVAOt3TWOda/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nTqHmKm/fWCmGgiRigv99ARsObd9AK1TvS2C8GbAA3o=;
 b=BRnjMyf7YU38jWXSHcpX6jyRoiPoAn6kVthIiYzQK6UFehBQ2pVKLB4sAg2yhOM/uEr3w017z49r5NhScUWVa3JeV5HKgkrnjvM+0yQIOwKakSBdN64NhYOEnaBMDHjPqmV1qbNfJvjCavYuBTRMXDksOHC1eqxPuqLS+tjUkSDkJ2MVNoUX7o1TuaAGtIn1aP/Cez+BNm5jExe2T5fqNNQRII3weJ5jmIwabnsq0LlFbhL08EnKS2Dw1B/3CnIcjBgApP1ZodbZC42ur+sSdkhHWVLyS/L+yM6eHGrVFjWU3inlJvcDGHMdH0age+spYlCbRzOdPnA0ddZIdzellw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nTqHmKm/fWCmGgiRigv99ARsObd9AK1TvS2C8GbAA3o=;
 b=6HMNgOcqxbSV8qSVhB7g6EncjZnRLv5Isvg0hu/PVauTU0lU7k09U9hAc+umdOf3sWXWCmP72UhSE0Cm80pe1cTkvAA1aVJJTeusIf+PYP950JLxUElj1EVSp7EQyLM+54NfjmIr58wRZSM/6me0giDmM0NhSncqPFJiwQMd4l0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from PH0PR01MB7975.prod.exchangelabs.com (2603:10b6:510:26d::15) by
 DM4PR01MB7788.prod.exchangelabs.com (2603:10b6:8:6b::13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7091.38; Thu, 21 Dec 2023 03:11:30 +0000
Received: from PH0PR01MB7975.prod.exchangelabs.com
 ([fe80::3f45:6905:e017:3b77]) by PH0PR01MB7975.prod.exchangelabs.com
 ([fe80::3f45:6905:e017:3b77%7]) with mapi id 15.20.7113.019; Thu, 21 Dec 2023
 03:11:29 +0000
Message-ID: <0ada0e82-69ff-40b1-91b1-c928d4b66710@amperemail.onmicrosoft.com>
Date: Thu, 21 Dec 2023 11:11:20 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] crash_core: export vmemmap when CONFIG_SPARSEMEM_VMEMMAP
 is enabled
To: Baoquan He <bhe@redhat.com>, k-hagio-ab@nec.com
Cc: Huang Shijie <shijie@os.amperecomputing.com>, lijiang@redhat.com,
 akpm@linux-foundation.org, vgoyal@redhat.com, dyoung@redhat.com,
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
 patches@amperecomputing.com
References: <20231127020727.25296-1-shijie@os.amperecomputing.com>
 <ZWQEP4SczFh+GUHq@MiWiFi-R3L-srv>
 <33021b87-4c6a-45fc-a6ae-265765cfcd78@amperemail.onmicrosoft.com>
 <ZWVdxAv/PPHY3Ndl@MiWiFi-R3L-srv>
 <a7d85fee-23cd-4b85-adc6-16980b6e5e02@amperemail.onmicrosoft.com>
 <ZWWYCLb73RYXGcpG@MiWiFi-R3L-srv>
From: Shijie Huang <shijie@amperemail.onmicrosoft.com>
In-Reply-To: <ZWWYCLb73RYXGcpG@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR18CA0049.namprd18.prod.outlook.com
 (2603:10b6:610:55::29) To PH0PR01MB7975.prod.exchangelabs.com
 (2603:10b6:510:26d::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR01MB7975:EE_|DM4PR01MB7788:EE_
X-MS-Office365-Filtering-Correlation-Id: f343798e-77c8-4174-5cc4-08dc01d28694
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	u23QsZiYadZTTG5ZYHvCKAs5NQ/+kBCIo9yKXUpqj7VIW1YhJs3LpA/wwolafHWg6/JJfdKQvmsKUcXJXdEvBloZ5VRRMCtQgniR66YqNIHKTtZOigWl4vbpe5ddNJ+xA+2XoTlJzZ/5QTBDXDb5NVfUweIgBrUDe875eUAkdaUwOP5NXPhiShpdzSrMZJZ2NCxPboR5GjeWyD3PoaM0jaDEOtQjFl+BosNhq/Ublbgl31ku6Gq2SoHFjibzROiBN+6kYV9JjA45i2LzrbQOGwomVBzwkSJ92V6sysQerpPkvVbkCv0XybGVb743jmXGE1EDk/Lrbvh4tCrZT3tJ1ZNhEMuWrOLAEdbVbfAPCIQ3PnOeVz5rm0bvVnhTHWfH0BVkkQu8/4Jh67CO+74EQKS3ByXYbaAfJh6Ps9oy3+HwhgM/Teb/guBWnlZEgAJvepqADh/+kPORxKZj2J/o7t5lsVk3i2Nq8bRo5jafnH0neAc341FUuoPSDdI39ITw3WZrCENo00IAbwI73ztrE3aJ9t0996ZmWHD9EthlHHfKB0lguhoV2BWl5su1RFldqR+t7CgJKBCm7GjOJT7n0ER3WE6I9c4p2mHwkCuO2is=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB7975.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(366004)(376002)(39850400004)(136003)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(31686004)(107886003)(42882007)(26005)(2616005)(38100700002)(6666004)(31696002)(83170400001)(5660300002)(6512007)(8676002)(6506007)(966005)(6486002)(4326008)(66946007)(66476007)(66556008)(316002)(8936002)(2906002)(41300700001)(478600001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aGZCeTFuOGk3UmdWVjRWVWNOSUZkVDIzaW5qKzJ0aXdkZS9Md2dTa1RhWDZz?=
 =?utf-8?B?V0YxQTRYMFIwc0IxMHFUWGN5Sm1HOVBKTVVEWjBjYXJZb1lCVjRTSENkeW9I?=
 =?utf-8?B?NVg2anBmV2VvS25SREJCUGJSaGdaL2c3U0pKcUhjam5PNnJaQW5oRGxXV0Qv?=
 =?utf-8?B?aU1ITE1VWWNIejBMdXRqblA1WW81bFBUZzFMWGh1dVd3V2dZSzNNQjlxZHho?=
 =?utf-8?B?WXBXbG5OM3h2ZlVVSFd3QzJiWTVienk4MzJOaFRST2hoclhGQWRzV0h0WjRp?=
 =?utf-8?B?U251TjBQMnNKTHZ3ZTVyNDVBQnhDUTgwVWtKTFY5VlJNb2VWbHZoNHBGSXI2?=
 =?utf-8?B?M3JaNnRwaC9yTTRZOGMvMXlqNnAvVDlsdTlqNmZObkh5dlVhanVxUW8ycE56?=
 =?utf-8?B?dHdYcmxjN05aUlltb0Q1UmZuNWh6Rlh4Z0NtZGYwbk1FUHRoK2hYeHoyQnVw?=
 =?utf-8?B?eENkS2orOE5CaVd6aXNBOXRGQU1USlh0RlVsNXFTMERHOWpzNDlkSCthUWd0?=
 =?utf-8?B?ZXBRZmxDVExzbkQyS1FnL3NRVHVzbHp1NmRPc0hUb2ZPT3hBM0lsTXVYS1o2?=
 =?utf-8?B?KzM2dEl5L3MwWm05aEEvVlJ2Tk9TTGtSUGJlWk1BajQ4UkppT1hyTWp0NmVE?=
 =?utf-8?B?WWJwellsa3FQajFaampnU2gwN0cyUFVrWThGUlNMTDNGTFFuQkZJNlZQQ2s3?=
 =?utf-8?B?Ymo4QWVZOU03Z1M5bDJhbGF3elAxWGtjd3VjZ2Jja0RhdVcxcVdqZmhUajZU?=
 =?utf-8?B?d2JPWWZoU3JzTjVTbmYrYnQ3RjYzMjZ6MTd4VDE1MkZyTTlZU1pZdUFZM3lE?=
 =?utf-8?B?NDBnWVVKRVFBeGs0aFpWSjZyZWxLMDk4ZGsxNko2Zm9QZHJDTDVXYXA4YWhZ?=
 =?utf-8?B?T1pGQUg3bHlxL3FENkMyaThXdDdITWJaRklyMjc2KzhYMVZvOUFjU0dXUzM2?=
 =?utf-8?B?L2pwd3dkS3VLUVQzTnlOQXoyV3BjK0VFMU5ZMU5tcjFjUTc3QllWUmlwalpI?=
 =?utf-8?B?SFN4WWI0U3pBb0dBSms3aXo5dE80Vm1NSDV0ZDRmTFNXS3N6T0hhUU40MWdJ?=
 =?utf-8?B?Z0I4c1FMZEhzbXJUdFlTZk4ya2xwb1hwTW1aYktPTW5ka3RBcm5mS3NsVTNx?=
 =?utf-8?B?RmEwNkZ1LzRCOVpIMVFTTmVYMnZtc1VwNkhxRU4yQmdsWXJKbWFNMitVNHFV?=
 =?utf-8?B?UnQ3WGEra0RQMmg0QTZXSEMzUXB5MWdjdVVCT1FzaUdxMTMxZ0NaRk5NbkZT?=
 =?utf-8?B?VHRTS0F2c1NnSzB5VUpKT2dXbDVYUDBCRENibTdYSmFoOFhETVdnVVQ0b1Jz?=
 =?utf-8?B?ZHVBU0F0Z1ZwWGJ4Q09ZZENabU9TTGlIbUV0ay9XSmJqVEI5L0QyeVZVb21S?=
 =?utf-8?B?UzFQNUlVTkU5eVZRbDE2UFhMSlQzMzBCT04wY2lKT2wzWTBTNWwyMS9TUXRW?=
 =?utf-8?B?amJZQWZjcXhCMDl0VnF1YlpTUkYwRHd6Tmh4UEdGQlQ3SUVScmdNRzNDYTBH?=
 =?utf-8?B?RVZmN2FvYTJmeHVmN0NOTEp3QmZJd1FWbDdhd2R5SlRhdlJyMkExb0h4bEJ0?=
 =?utf-8?B?NGRnVFJ1WkZDdXU2SG03Q3JzNzFhNjB0T2t2Z3lRQXNKbFQ0TmltQXpuZVYx?=
 =?utf-8?B?NzYzdUcwTFNFTmNPTk04dFJ6Y01yOWhTMGdkaTBjYzY0RTQzVWtPOUpFbEk1?=
 =?utf-8?B?UksxZHRMRVJGOVVDV3laaW1IQjk3MXdHVldkVFc2QVpNS09rSEFrYmxSSERs?=
 =?utf-8?B?dGxmWWRZVmw1QlFCdmxIcHB1K3Zoek84RnMyMjl3cWZ0dXZHbGF4V1hWdEFh?=
 =?utf-8?B?MWVxdmh2dkdGZzRYR3g0RkxJdDZwbitrVGhMc1RmcUlqWWk4S1hvWWxMODhW?=
 =?utf-8?B?cU1KbEpQR0dTbkNYaXk5SDl3emhDV0FwS2MxSWJhZU9LdjhiWC94RlJueHRr?=
 =?utf-8?B?eCswaWhuZTN3ejlON1Q2QnFYeWFXK2FYNlp3OWRwQXFjalNyVExhZWFGTHdz?=
 =?utf-8?B?N0h2RFZNTjRzaHJkZG9xaUk3ZGJqWGNxRnpRbm9RK09KOGIvL3U1QlBlMGZj?=
 =?utf-8?B?ZjREVXRjaFNJSlNKY2pZbUI4bXZBSDQ1NHhvcGRPSmdRRkcwSXpJUDBldUlP?=
 =?utf-8?B?SXN5NzE5Z2VoWnVNUEFLa2ZpdGd4b0c1dWp2cytKSVlYVitZa1lESlNHZDFq?=
 =?utf-8?B?S3c9PQ==?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f343798e-77c8-4174-5cc4-08dc01d28694
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB7975.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2023 03:11:29.7076
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RcSTiXmLkl8+uqBpv4NvlbipnWNKzUCE6zP4nX476CRMZGsgus3DIXzHR17oapgqyNwDUf9amADdnDFtagBcchIk2drem6EO2OF1MmRkTwqebH2g2LQA238niFppTirA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR01MB7788

Hi Baoquan,

在 2023/11/28 15:34, Baoquan He 写道:
> On 11/28/23 at 11:31am, Shijie Huang wrote:
>> 在 2023/11/28 11:25, Baoquan He 写道:
>>> On 11/27/23 at 11:18am, Shijie Huang wrote:
>>>> 在 2023/11/27 10:51, Baoquan He 写道:
>>>>> Hi,
>>>>>
>>>>> On 11/27/23 at 10:07am, Huang Shijie wrote:
>>>>>> In memory_model.h, if CONFIG_SPARSEMEM_VMEMMAP is configed,
>>>>>> kernel will use vmemmap to do the __pfn_to_page/page_to_pfn,
>>>>>> and kernel will not use the "classic sparse" to do the
>>>>>> __pfn_to_page/page_to_pfn.
>>>>>>
>>>>>> So export the vmemmap when CONFIG_SPARSEMEM_VMEMMAP is configed.
>>>>>> This makes the user applications (crash, etc) get faster
>>>>>> pfn_to_page/page_to_pfn operations too.
>>>>> Are there Crash or makedupfile patches posted yet to make use of this?
>>>> I have patches for Crash to use the 'vmemmap', but after this patch is
>>>> merged, I will send it out.
>>>>
>>>> (I think Kazu will not merge a crash patch which depends on a kernel patch
>>>> which is not merged.)
>>> Maybe post these userspace patches too so that Kazu can evaluat if those
>>> improvement is necessary?
>> No problem.  I will send out them later.
> Thank, Shijie. Let's wait and see if Kazu has any comment about these.


Kazu is waiting for this patch to be merged now:

https://lists.crash-utility.osci.io/archives/list/devel@lists.crash-utility.osci.io/thread/IJB54DIDWEJVCSCOLDYLC5NJ5AUIJZDP/


Thanks

Huang Shijie

>

