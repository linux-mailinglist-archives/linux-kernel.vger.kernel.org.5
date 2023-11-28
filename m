Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF45D7FC2BF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:17:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346794AbjK1PcJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 10:32:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346002AbjK1PcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 10:32:07 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2040.outbound.protection.outlook.com [40.107.92.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDEC510DF;
        Tue, 28 Nov 2023 07:32:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cXLV28lfN6NmYCf0xXqZQpBnq7dn1/0CIxRsB7Ma+qxjhsf3qme0yUkJTSC2X9EIUMefFHjsogYQlgm1vYc2+qTUX4SHL8iYPTEzkRUxnrvvnpkuEH39mrruazDTTlEdK3wxc74wDWbwrfyzFktVSwDpoLejW8Y+SI1YTZlIjpGrEO1lJBr5E9DJHBT7HedguQYpqKV5y6u89QEU9ouCgR/E7nQEQxelyLjUk/yjXHRknOq3xSn6eL2N6n9JXDPYESML1oYundBQlOrNj+yv0aykFUWONOJQosd1KDNQjH0cFVtvMDyBWFRZHBUvUAuppdXvCgHYM5z8ylxzgBUzow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sB2e4M8QACtP5WLdv5mq79IxX3VIbmeBUEG6yKMzcgM=;
 b=EyZfexGF3LuIsj08UrQjb0ST4iEbJqE0YfOAOpMYjqbGc8/u1AKCm++3oL/88W40FRV+50kuskw6AAUbK7yiJRiYWuaSUggE1HJGhgv8OCP9MDQWzn+w/NUOE/E+brgYBEDwl62LlLeWQyY/KzXAfwpNXu0o2DBr6TaV5VSmMccg2jH0qCbJ48bUZc68j/u6/admbseTFWm7ARMLu8a9e43cAiDlUKy3gXMtX/jdMp8EghyUqsCvLA+ec3spZjqKBjH9yc4qEPd0jCKKwYJ9kZLCr6Aj7fRuHFAb2WReB9yTIAw80DD+EYSbgTfuRt34paWFdlGbFtQnuUCY1gINGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sB2e4M8QACtP5WLdv5mq79IxX3VIbmeBUEG6yKMzcgM=;
 b=E+ula4NvEB0H498vs6YPBMZAzoF6S8QBzOewJ7/osSqWT2aIiw7BPp+8yYq5RiJQlvCxDvCQaP1aNUy/85p8SqAeoLLTqIAKDzjxgYw4xpiB7NIYr9kaFWApmx1E2KomITtSGCcnzPvPSl5UzJF+aXEocKyHQudN7PYYwN4g2DI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BL1PR12MB5030.namprd12.prod.outlook.com (2603:10b6:208:313::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.28; Tue, 28 Nov
 2023 15:32:10 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::a9cf:f8b8:27bd:74d0]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::a9cf:f8b8:27bd:74d0%3]) with mapi id 15.20.7046.015; Tue, 28 Nov 2023
 15:32:10 +0000
Message-ID: <addebe1d-c08a-434e-9146-b6c10418a9d2@amd.com>
Date:   Tue, 28 Nov 2023 10:32:08 -0500
User-Agent: Mozilla Thunderbird
Cc:     yazen.ghannam@amd.com, Smita.KoralahalliChannabasappa@amd.com,
        dave.hansen@linux.intel.com, x86@kernel.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Subject: Re: [PATCH v9 2/3] x86/mce: Add per-bank CMCI storm mitigation
Content-Language: en-US
To:     Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>
References: <20230929181626.210782-1-tony.luck@intel.com>
 <20231004183623.17067-1-tony.luck@intel.com>
 <20231004183623.17067-3-tony.luck@intel.com>
 <20231019151211.GHZTFHS3osBIL1IJbF@fat_crate.local>
 <ZTa37L2nlnbok8dz@agluck-desk3>
 <20231114192324.GAZVPJLGZmfJBS181/@fat_crate.local>
 <ZVPu/hX9b7lUkrBY@agluck-desk3>
 <20231121115448.GCZVyaiNkNvb4t2NxB@fat_crate.local>
 <ZWTzAujHdrJ950F3@agluck-desk3> <ZWT4pAJ6g0i78wec@agluck-desk3>
 <ZWU3WkmUMz3Wk9wT@agluck-desk3>
From:   Yazen Ghannam <yazen.ghannam@amd.com>
In-Reply-To: <ZWU3WkmUMz3Wk9wT@agluck-desk3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0440.namprd03.prod.outlook.com
 (2603:10b6:408:113::25) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|BL1PR12MB5030:EE_
X-MS-Office365-Filtering-Correlation-Id: 81c8d6ed-a32f-48ee-5b03-08dbf027300e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hh6c7TyXGL44uU1iVwwEQ1X1K2gmYDItTe9WCSgVEOn0qlW9wHVsLCYY/QseUUFKHB8nPFthoTl4BuB4z1ZYv4K97/hkYzFueKTrD4vWaXntfh+toy1Dr4CBaiAvrF+OLbF/g+R6MvQstyBFigCQ4UofcfHosbF7DqNeZpW7JUE/hD8fxjsxMYuF9+m7BNkL6OJv3DLfiIqYFJjd6X0e3XOpD0NqSnqjlXp8mFEYDNKgnHIOmYFXAyi4/2uSft0yc+Sv08fZIll602hZGb85WjoKtl7X6V4BeP6kWY4XvXdyTn4aN16rEaqIpalL00e6v7yUXVs25xrymQ+5Gel9aMz0AV49CR7penuL7REW07nXYKEiz1b0fxcj9j2x5Nm/MACNF5bc5xen/Wz6jqyvi1melPVU8ftHcVrp5fA8UxGtwdubBwQf+8uY5WrILoGRQcRdSvhL/beR0TBXqg+DHqlaTTv0FcdVC1orBjxCQlU0PQoQoWcNgT7/Tvn1VU1oWJwM/A18DMSFNHY8p0+BoJIFFfuct4WdaN+V0i0v8UVcrny5n25c4hkkC1kBvUcwYaubVOCxOtXQIsL0NKIVi5PsJE4euv4gEPOdJVoUO5Tqe8p9q2l6nqEf73RxbuOn3w+b4dPmpDSsRQjZ+TRzlw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(396003)(376002)(136003)(346002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(2616005)(8936002)(6506007)(6512007)(66946007)(4326008)(8676002)(478600001)(44832011)(5660300002)(15650500001)(31696002)(86362001)(6486002)(110136005)(66556008)(316002)(53546011)(66476007)(38100700002)(26005)(83380400001)(31686004)(41300700001)(2906002)(4744005)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?azJpM21SRUtCWmdIdkdZTUZUSGEvWitrbEFOODR5elFVR0t0VGMzaGc0YndW?=
 =?utf-8?B?c2RDTWdiSDc4NG90bk5vYWtCVU01MDFpb3RxUWpMbXZJU0R5b0xWR3VRR2ti?=
 =?utf-8?B?VGkxZDhZb05rcDVzUU5aWlNuMmNiaWtZNVFDZDVTSEpLN0o2eDg2UHZJdnVj?=
 =?utf-8?B?R1NQbjBDWEJVSTBDT25RVGk2eWlkUmg3NWUxUVF1MXMyMnkvUnkyam9lekVO?=
 =?utf-8?B?T01EcUZFSlpmcit4TVJybzEzenFaYlROeGtRZEg1aEdKaXl5SkRKMVNQV1h2?=
 =?utf-8?B?R3o3NU4wOXF4QjR2TjhYdnlQKytwTWx4QzlzaUMyRjJ0TytKcFpSbXpkeDFF?=
 =?utf-8?B?NU5JRlNRZXd1azJScGU2blVHYmhrVnpvTDZtc2JoRE9XRmZNejh1OFVsKzQ4?=
 =?utf-8?B?TFllVFN3RXBUZVlWUGVpd1FNemZwRitzbGtyU2ZGYll2ZFgwb3p6ZjV4WjJJ?=
 =?utf-8?B?TTRZWldTbFQwV0s5Z25YbXlodEh1ZUR1dmU5T2hwcmFrTjFWYTY4eFJPb2ti?=
 =?utf-8?B?WkFVVnJVaU5GRnUyRDNNQ3ZsNmtmWkkwMXNuTnF5Qm9jNk9DRlR3ZWpCNnBO?=
 =?utf-8?B?enI0WFZBQkUrUjVNMTFKdFN2OFNRTUh0TWwvRlFXTStXVUZ3TU1pYndxMnNI?=
 =?utf-8?B?aEpVOGMwR2Izb3NzalBXTnBOQlJZQ0RzdGp4TkF4VXdvdm5zR3RYa2FIYjFF?=
 =?utf-8?B?QUFrSkFqbDVjemgvWDlUeXhrdmZuWXBKVmkrTllXOEx6aHhPTjBIRkNucTFk?=
 =?utf-8?B?dWhMQUtRNE02bElaYmtjeW9MZWY0dXphakRzYzVPUjEzcWtlektRZlhrYUJZ?=
 =?utf-8?B?RGJZUnNxckp4SzdvUkJ5eVMvL3M3emovWnEvR1g5OGhGbExhbzBOYUl1R1F1?=
 =?utf-8?B?WWtOWXBPYjRsd2tNeDBrM0JZY3R4NnljVktKVXhScENmWWRCSy9MbnBrOXNz?=
 =?utf-8?B?dmxENmdlRFBOQlpkTHU1dFE5QTJoeE9COGE5SS9qUlhsbUZ3KysvRXZCVWNG?=
 =?utf-8?B?eG41dS9JaVJ5N3ZZL0IzdVN5ZFJ0M09uQVFoVk9vNUNHYmRjZDhkbU9KcXl3?=
 =?utf-8?B?dW5MZ2p1Smw1TUVMUTdBSEFYQmg1ekQ3b1FENTlhUFU0Yy9NczZDWjRBQ0Zp?=
 =?utf-8?B?UmpnTjdaTlMrQXI1RDVLTWVCNGhaUzhBbW85NXlvSmkwS1l6U3VkcmY5OVYw?=
 =?utf-8?B?QmloaFpjZHJtS05CTVdweG1LRC9IWEpQZVNHamRDbWhRSkgrcVh1OTAwVHVq?=
 =?utf-8?B?ZG1hNzdUVkRjSDg3cUVja0M0b1lTdkNZRWo4YkRqWjkzZmp3QkpzTXNldzdS?=
 =?utf-8?B?cFArcHV5UlZnTW5RZEtUV1lJRTRjTlpHTzN3S3VseC9tajBKSldjR2NvYllo?=
 =?utf-8?B?ekNFV0EyTEFuTUhsWjJKN2IxTTAvaW1zQlppaTI4bEZSM05kY2RoZWdVNHl3?=
 =?utf-8?B?Z2VCUmhtQjloc3dDR3E3d0RsOHUrNHRleCtDcWtRWndMRDdBNUFZOEc2ekZr?=
 =?utf-8?B?ZFF3aDdWajZqMm1RdnhjYi94VWVpcklGNTYzQUR3TC9rRTROS2s2VFJjbmJr?=
 =?utf-8?B?N25zTHdVNmFyRVlteVBCTlkxYkRNV1RpNUFPMnk5WUt1Lzc3azd4cEpKSEt6?=
 =?utf-8?B?WmxIMlJKajFmMW0veDRNUHhWZWRPaEwxbE5zS3VjMTVZYXcvdTA4eThkWW03?=
 =?utf-8?B?WngrZGtwK3RCZi9Qb3lQS3RjWDhqS09lSkZoUmdyaU5jNExVYkhsZVg3Wjdk?=
 =?utf-8?B?cURCaGwyeTVOemRjWUxldkhBVG1pZlpiTEVrYnNuNFl5dGlJS2ZYdWk5UlA0?=
 =?utf-8?B?WGQ4bU9ac3RSbjc0R21xemZpZWxvRGF6TisrYjNOZ05vZjgxVEpqTW1qNEtV?=
 =?utf-8?B?OW9ZZmpWcEVNdFNlUzZYSCtYQjE2K0hMdTFreW9NZEpPcXBNa3ZQTW1KdHpq?=
 =?utf-8?B?MGQrL29JRXNJeGFoOWN0cFBiejJwYzE2UHFsYlBwcVNYREQ3b1RRNWN0L3B1?=
 =?utf-8?B?c2RnKzUydkN1UEtvbGVQUnZTZGhpVk1Wd294TFkyUGF1YXB2MHhVTjlMVVZM?=
 =?utf-8?B?Z1E3ZmxZWFhmYTRvRFFTdnQ0L1FmVmloQTRvZjVlZFF2ZXpuLzk2UksvTmNB?=
 =?utf-8?Q?+b8350ErmcvcqMbB2ys+tluYi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81c8d6ed-a32f-48ee-5b03-08dbf027300e
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 15:32:10.4776
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F81mPL2qVXqTHusNj07gmQQjrn5MyEvfE6dmR9KhrgX5lFFknwQKHqI06C5LsHKchj8qqsukXgXGjMApgCcpWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5030
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/27/2023 7:42 PM, Tony Luck wrote:
> On Mon, Nov 27, 2023 at 12:14:28PM -0800, Tony Luck wrote:
>> On Mon, Nov 27, 2023 at 11:50:26AM -0800, Tony Luck wrote:
>>> On Tue, Nov 21, 2023 at 12:54:48PM +0100, Borislav Petkov wrote:
>>>> On Tue, Nov 14, 2023 at 02:04:46PM -0800, Tony Luck wrote:
>>> But it isn't doing the same thing.  The timer calls:
>>>
>>> 	machine_check_poll(0, this_cpu_ptr(&mce_poll_banks));
>>>
>>> and cmci_mc_poll_banks() calls:
>>>
>>> 	machine_check_poll(0, this_cpu_ptr(&mce_poll_banks));
> 
>          machine_check_poll(0, this_cpu_ptr(&mce_banks_owned));
> 
>>
>> Bah ... I've cut & pasted the same thing ... but I think there
>> are separate bit maps ... maybe I'm wrong. Will go back and
>> look again.
>>

This mutually exclusive behavior is not enforced on AMD systems. A bank 
can be polled and signaled using hardware interrupts.

I've been thinking to change this in order to save polling cycles. Now 
it seems there's another reason. :)

Thanks,
Yazen

