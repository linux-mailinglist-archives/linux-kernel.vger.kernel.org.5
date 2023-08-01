Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E55076A705
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 04:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbjHACfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 22:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbjHACfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 22:35:18 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2047.outbound.protection.outlook.com [40.107.94.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9916E1BEE;
        Mon, 31 Jul 2023 19:35:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eeMDSeu9G7uE/dKZLTHSK/4dEPWXnI0GXiil7pYzvGo335jWnAefSZAXc3FFLm/faTqkuEHQ//je0mSVGEYhYptJSP8xLRgsaLUCHhCW7a/cL1/bW74y93ZnZsEfkU8opHn3bmCKahTrOAKWtK68sSvduDEkOTpGB5u4dqHUWv3vDzTiPtGUFF6Nx/YjCFjbhtOjZspgIuKGbmi6oMOHF1R1tu9hLWeubADioHMLYRq2gI8Y+simDzE9WBrX0b1W5oKnU7NOCzFvIe2Q5M4BC78kq141eefsUUDXcATi5W4TCpHePcj8iqTWkaFQtnn7dSaZuY5c7Nrn6fixkaR3ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hc9wnEUveVBy3xFI44AvROoSTINLSfSGhGJ+7Mybwnw=;
 b=GsNOQfhxldbdCUx2tWk/+hhceK9KZMbDqaPOmiOoiejVNhWqRfPYKU5M9fc6tslGj//P1mVltM6yRlGjWd1iTuXyX/utLDtl1TtQGAAbYdazD/s64LYBvXFzX26DR2IXCLHsl/QJCmnnXPxhpTQZ53jYStvHKhtbEH9FWgup+BLWqU2bNn9rAIsV3igwZsLFd/yPgFGc5YdagmxBXTZ8pThJNNgfqWEe8I/cT88g2IPpyDJv4OXL+oxNMP0boIpCrhThs66sUt5Wro5rC1EDQVfmTcHKt3hFvD/rkPtPlMWDFgGMoGmSIKMcmFexfPeVKPwcubCBYFdUWRC+0UOQ6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hc9wnEUveVBy3xFI44AvROoSTINLSfSGhGJ+7Mybwnw=;
 b=h5z+MiofIaSAjQC72UOrjGF7mUqzldSkXhjcjcXtmZQovm6v6C32rlQzdndmSz7fvpQSHZRv1mmKU8bzaWLGqu8wpQrShtsuXLdhrvJmVd3Ejqo6gD7/Z5Muc3l6eXTQgJ9TvFNuughLHI5reOgm/ZUdy5BcyuhVamrNDLn0Ykg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6434.namprd12.prod.outlook.com (2603:10b6:208:3ae::10)
 by MW4PR12MB7016.namprd12.prod.outlook.com (2603:10b6:303:218::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Tue, 1 Aug
 2023 02:35:14 +0000
Received: from IA1PR12MB6434.namprd12.prod.outlook.com
 ([fe80::17b8:2ba3:147e:b8cd]) by IA1PR12MB6434.namprd12.prod.outlook.com
 ([fe80::17b8:2ba3:147e:b8cd%6]) with mapi id 15.20.6631.026; Tue, 1 Aug 2023
 02:35:14 +0000
Message-ID: <6c8ed42d-ea71-c11e-2689-c4fc23845ccf@amd.com>
Date:   Tue, 1 Aug 2023 08:05:00 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH RESEND 0/4] memory tiering: calculate abstract distance
 based on ACPI HMAT
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>,
        Alistair Popple <apopple@nvidia.com>
Cc:     Huang Ying <ying.huang@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-acpi@vger.kernel.org,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Wei Xu <weixugc@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Michal Hocko <mhocko@kernel.org>,
        Yang Shi <shy828301@gmail.com>,
        Rafael J Wysocki <rafael.j.wysocki@intel.com>
References: <20230721012932.190742-1-ying.huang@intel.com>
 <875y6dj3ok.fsf@nvdebian.thelocal>
 <20230724105818.6f7b10fc8c318ea5aae9e188@linux-foundation.org>
From:   Bharata B Rao <bharata@amd.com>
In-Reply-To: <20230724105818.6f7b10fc8c318ea5aae9e188@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MAXP287CA0017.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:49::35) To IA1PR12MB6434.namprd12.prod.outlook.com
 (2603:10b6:208:3ae::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6434:EE_|MW4PR12MB7016:EE_
X-MS-Office365-Filtering-Correlation-Id: cdfe916d-563b-4f6a-6c5d-08db9237ef5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7Eopx3LAgXQdoI4fXxP9V4sV39pbLeagtxMWlS4QDKsOhsC1fUEFGAMi02Wazhv2y1BarYx7pH0ioTRDRaRaLU6NYOLox0n4oQ5nGwdAscu0PX8AlCxx8iaIgeZBRPefu4wKw6jKnW+JlapqSAO1ntJ2fSVvgKtNpTV7r/LRl9ivkeaTkcqndasqarVwIO0REjPRgBPaCDvl2ANA/LLwT8axRogBkUNGbXjmfhaAIe59Ct8ifHqG/NAxkhl6J75ZOgD407qG/MuEDo3Dpi5hQWfwcEtD0VVmXfiOa83mvReIx/lDXKuD2vRR5h4ogW4vECoIzY1NfM3+URx1FGGx++6N+CxoLAEhVFCw6kVQO5RDv5tixswGEN4F27tDb3AwT9rL7MAYdqJ+XecF4y7FkCd5ctf02BGvpJl413SAyJFjLTyyZr+NgbSOOolqLWoyjrtKaJ7uPufxFU+L6U0ya1XEdi8CD0TdU1CN/B3m0yXkmF5iMG534VfD+3GkLbvfLJBLq4uMuFzB8LLljCezY3/nmIyEBmvgxUFWv9NVbVrgIm62MomZ4ua3X64lG9vOCF3k8YwkM81LUujwvQsTHH+PraHetUYr/8CKSSRRO4SDiI64wfh5tlPSoeoZMKD4DSgyf7iEbd1Y9tk72drgnA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6434.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(39860400002)(366004)(346002)(136003)(451199021)(53546011)(6506007)(26005)(186003)(54906003)(110136005)(6486002)(478600001)(6666004)(66476007)(4326008)(2616005)(31686004)(6512007)(38100700002)(66556008)(66946007)(5660300002)(7416002)(41300700001)(4744005)(8936002)(2906002)(86362001)(8676002)(316002)(31696002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Rm00NG5KUS9XeDN0TytnL3QzQytPY09hUml3dVNENUQwWDdIbTRyUExzd3dE?=
 =?utf-8?B?bFZpTGdaM1ZNODRaOVQ1UFlxa3RHUFkrVFR3dE92Z1U0S0NlbG5qZFoxYjBI?=
 =?utf-8?B?UXI3YUJZR1dueWtQRTYyVHpJbkZ1czlBL29ta2pnKyswTkNpWW1xWGpjQVd1?=
 =?utf-8?B?dU41SDFSYWRRWnU0M0lTVUo0Ykp5c3cyYzV0bTloZ1BMSUZHOWpDbnlPRWsv?=
 =?utf-8?B?Vk1xVHFVMW1tS0dLSlhKd2pTQnhWTVVFN2xEUHdLS3lqMmZWUTAvaStNTERS?=
 =?utf-8?B?RzVCczdyb1RJMncyUW1xL2JnUnVWVFhGVUMyckcrMm1SWG9UTUhkSTZNYW1m?=
 =?utf-8?B?VVVPc1FTMC9EYm0ySzBRU2thbVBqSDNoT0hTZFo4MG8zOStkTlhpTVYramtk?=
 =?utf-8?B?M1hzRTNJbUpoK2VCVWtobWNrd2NZMWgzYThSbEgrNExmWkZ6ZGcvcnpXUWNY?=
 =?utf-8?B?WFBzMkNKcXlnekFBVUZoeTBrMld0UTY5NU84R2lDelVwOHZNMlY0WUdsQVdU?=
 =?utf-8?B?UGVNSk8ydG9DcE9WUGtaQWhweEJVeXBIa2lDdDk2Nk1mdXdZUFNjMzNDSy90?=
 =?utf-8?B?SnBGQzJFbFFiVzliRWpMTlFqUk5SSXpDNGhMMDk5NTgvWktDZHVrMVoxeXBW?=
 =?utf-8?B?Vk14VXNpZUVEMjVaUTJHRGdVWHNGZkcyeWphb09nY0x6Qk5vcHZBUzhBOXFW?=
 =?utf-8?B?dW1UaWRuQkl3TzJHRHNnSzdmd2xGZG5OdytFZ1FtVnJZak0yaSs0ZGp0UDVo?=
 =?utf-8?B?S1dzRktkZEdXZGllSnltODN5RndrenVmL3R0TjRNYi96anovNHliYUVudUky?=
 =?utf-8?B?RmFUVXJrRVp3RW1ZaXJhTkxOa0wvRy9lWlVQc21qbzR4cmNHQUF1MTBOZ3Q1?=
 =?utf-8?B?MURFWGo3bE5IekxxRUxKUWpTSWFIUm5qb3dmbXNNaWNyNW1EQ2U4QUhTT2tz?=
 =?utf-8?B?RzRuUXNaeWJ1bzdPSTNyMVRCd2padjlNZzhHbWFnMW9ySUt6SHdLbEh1UGs5?=
 =?utf-8?B?RWdwc1FIMEFobVAyZUhxZ21vZHEyNXRKeDVQeWp5SldkbU1YM1Y0VlQ0RFVv?=
 =?utf-8?B?bXFQQnBXeU1VejMycUJtN1Bac0hKNkEybk02Q0h4V3Y3VkxCZlI2Y2M0eGVM?=
 =?utf-8?B?dVN6cnZFQTV2ZHFCSkJIZW1VeG5JRDU5eWNuS3IzaU1XUWVESDlTRmJKRTFJ?=
 =?utf-8?B?Q1RTMElOOUZWZXZDN3JCcjdxTVZTWnJtMU5tNlVJU1FVOUxWMjRMR2Jzc2NI?=
 =?utf-8?B?aTNZWW5vdjJVOTNDaUpCV2NKUGI3d21aQjlpZU92bWloRnlaY2NuYm9YK0g5?=
 =?utf-8?B?S3R1Q2pBUVJ1djdLS0Y4R3I1a3VPbEEvUjVGOWpOaEdWMG5jZEVwbC9yRC8r?=
 =?utf-8?B?V1Y4Nk5TWmszcWU3eEVsSkhia1BSMGxCM3kzUzNBajYrZzlYbi9PbUhKVXRz?=
 =?utf-8?B?d1g3Z3hTR2hBYkk1dkRsbkJhQzhud01yT0lveFZxRnZ6YndlQmJxa0c5bmFy?=
 =?utf-8?B?NWtYVktBVVEvQmllcjhiblVkTlUzcVhhK29sRDBxM29HbGwwbjg0L3dsbWRk?=
 =?utf-8?B?YlRBMlM5MHB2b01TU2dTRGh4a2hIbEdCM1hQalFTNE9hZTB2dkVRUE16L24r?=
 =?utf-8?B?cjB3S1FNa3ozajhKSmtMS0RCUDJqckFHK1ZLOHNrcjNJQnU5dzZ3Z0ZwVUlm?=
 =?utf-8?B?SGkwb1F0R25jdEdzbExXeEFDZzVCR2ZVejJINkpJUFZ6ekRPaHZ1ZGVGZXhK?=
 =?utf-8?B?VFFaYkVHRTY3dFRvQXFqUXVVZVgyNFRZRnVKaVN4dUh6T3hQWHZmbk5VSDg1?=
 =?utf-8?B?YjRDNThJV2Q5a2thc1BXTkRYTk90U0I1RldKdm1LM1JYU3hKV3JmRlVFVVZF?=
 =?utf-8?B?Z0VMNjVZbHZudmQvZVkyODBxYTVQL3N5aXV4aUo1SXR2cDY0SmdkZFJLRWFZ?=
 =?utf-8?B?QWRKNmZWUlhPRE4yT1hlb3NyVWFxOHpsNk5Fcmx1L1Q1Tjl2ME5Jd0Jpb3pl?=
 =?utf-8?B?K1lRNzVKQ0g1aHRVNmJDYjQ1RkwrSllmVGJyTk1MVW5oNlg2bHhnd3hJbDBo?=
 =?utf-8?B?VmcvdXozMHJNMzVvVmhHb2NjQ3RqejFJdmdlaUNVQmY4Y3J5Qmc0M1UxR0hB?=
 =?utf-8?Q?DmyGltxAuxamenZV1gUJG7hHo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdfe916d-563b-4f6a-6c5d-08db9237ef5d
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6434.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2023 02:35:14.4442
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MqCJcsWwfDCFop7JRQtOvYTUNo3qiTMq7hkzvrq1NAOQHRdMHfQuTn0mcYyV1du7S1eyoF9fYTztMSi8uToghw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7016
X-Spam-Status: No, score=-0.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24-Jul-23 11:28 PM, Andrew Morton wrote:
> On Fri, 21 Jul 2023 14:15:31 +1000 Alistair Popple <apopple@nvidia.com> wrote:
> 
>> Thanks for this Huang, I had been hoping to take a look at it this week
>> but have run out of time. I'm keen to do some testing with it as well.
> 
> Thanks.  I'll queue this in mm-unstable for some testing.  Detailed
> review and testing would be appreciated.

I gave this series a try on a 2P system with 2 CXL cards. I don't trust the
bandwidth and latency numbers reported by HMAT here, but FWIW, this patchset
puts the CXL nodes on a lower tier than DRAM nodes.

Regards,
Bharata.

