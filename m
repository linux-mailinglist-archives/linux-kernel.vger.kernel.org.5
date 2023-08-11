Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9074877888E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 09:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234245AbjHKHuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 03:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231126AbjHKHuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 03:50:10 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D9A61FED;
        Fri, 11 Aug 2023 00:50:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NLzgh6TPIjDLQDP+rxeKNr1sk9YXmNy6RVYnZ3TN9KQey8bm1M5hO8Z23ouWlxUKlZPcJCamYRmdrtEofeZMAumUgFAujp25B+fWXwLyxHG5oQY+1H27UdmT8SVFtkZ62gRrr/It2P+FCqqlFIZ/Ij9UMCcOThP/MpjpkmC+Gn9ik2woL3kb4wtVNk8aEfiaR3XYu5HynsATE8azOEPGJOP+mzowMZv5zGC+14pyLL4TSXsWGep0OCjCGn2XT4lNvIr+OW0uM9q3oA9hky4BPGHFcpabOJKW2AuEHvkX9gPjW7GNq3ESdDhQapMCtr7Os9bQl3A/negzOD1LnK9ycA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hw5b61BK7kMsPz81vl1JsC74qAmCufX0vAw1h8yQLdE=;
 b=IL7jaLH8EzyBJ6YAtqix13v3BBZ8+0dGbKXbaP9rda0cPWZ+jsjWnrIXYIlRaYiAiFUC+9Q8IhUPYTM+N2qlBHEIS7Xgg4E2F4EUJyXqsmj2Y5I/jepynE3I90p95S0rA2MA+q1thWrO4mdBWDTON2e5QLHqmVNDGFbld/ntacdLxO0TAohydcmcv3dIgmsex6N1I/Rz9v7KZoiDr0lt9y+Ehk9lofUxrVrcc9Yxrky5GMeIA6JdSl+yOjfs+1OCkI+oVR3cJ7ao5PqY3kFhYwnbwvk3c0KLJ2hG7VWQSVb6q7OtTtqi5h4hpHOKeSdsDl4/xUiIEFkq8HxCfVBIwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hw5b61BK7kMsPz81vl1JsC74qAmCufX0vAw1h8yQLdE=;
 b=hXYCf2M41+wkEXGq5h32IioK5k/x1JLW5vI2Xa+c8Kl8poju6Nu6E9xAUeVlN3xe3pl7UjNx5aSTnEM8N8kzbkgxcTVZpuAlM3vSPWKRuTyckjx15NhD52cH3ng0JWjiuLQwzZTwhgTvZdUIlQNeLafRj/eBdq9VLjGHHJkX8Cw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6434.namprd12.prod.outlook.com (2603:10b6:208:3ae::10)
 by SN7PR12MB7348.namprd12.prod.outlook.com (2603:10b6:806:29b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 11 Aug
 2023 07:50:04 +0000
Received: from IA1PR12MB6434.namprd12.prod.outlook.com
 ([fe80::17b8:2ba3:147e:b8cd]) by IA1PR12MB6434.namprd12.prod.outlook.com
 ([fe80::17b8:2ba3:147e:b8cd%6]) with mapi id 15.20.6652.029; Fri, 11 Aug 2023
 07:50:04 +0000
Message-ID: <1d5a74b2-bab4-4876-5fa1-2c06e83b55bc@amd.com>
Date:   Fri, 11 Aug 2023 13:19:48 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH RESEND 0/4] memory tiering: calculate abstract distance
 based on ACPI HMAT
Content-Language: en-US
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alistair Popple <apopple@nvidia.com>, linux-mm@kvack.org,
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
 <6c8ed42d-ea71-c11e-2689-c4fc23845ccf@amd.com>
 <87il9mccxi.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Bharata B Rao <bharata@amd.com>
In-Reply-To: <87il9mccxi.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0035.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::14) To IA1PR12MB6434.namprd12.prod.outlook.com
 (2603:10b6:208:3ae::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6434:EE_|SN7PR12MB7348:EE_
X-MS-Office365-Filtering-Correlation-Id: 847eeb60-4025-411b-c462-08db9a3f92bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cn/kuyTIObXecBSHn6XdvpI5ROxFfPAC0h1jz7de+0zmnOiLXSNlLgdWcA0MN7A4Rqyi9eUFXpZymratvMjxxB3iJnlTy7oUhv+KCl6UkPl3FWpuVbol0JxZQcF9MUIzaKt3lxbEGbCxurKFoKZRVdkkXeTK1+u/oFuVvVcVCQxzuaR3rSo8CiIf5D6ur9Ki9nbZHf3VhA4Dx9kLGANmYoLA9VaArUht5atZmYy2bh68y2VzaCo7wJhD8wouIpSzPFMbhD59Zzy1btpNLmAfhNgTwm7Pt5hLI2uzHKo9PvMYIkZYdYXdw8WnI1F3qPNF8A5detWE6Rf59vxpynKJbH3xz8rDj+D/dCSR93e1QMCQroQ1zXB+Ccm3mMK8yDbHxSRC8SPyzeiuR09mv6wT5v5+FiS3o775g/3dl9ULN0lJchDofMQK78II9giOy4DZM9hl9DOasUMs3vhJ4p/HxHFGeI7o+28OvlOBXrhEb8FBGW4ECADw/RGIR3776zLAkCNL3E+MXsm7PgEe89gNn5FVa3FTIJrjaessHEjLnmys3Go03zJ4YqCdgNKLZOXXkUDoaleGmt0DTQV/jmOY/0SIplPDSywXZI41dMBmXgbtTwvUQ9h9zJ76ERv5hHS1xEBDwY+wOr6q80/tygs9bw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6434.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(376002)(366004)(39860400002)(136003)(1800799006)(186006)(451199021)(8676002)(4326008)(54906003)(66476007)(66556008)(38100700002)(2906002)(6916009)(478600001)(66946007)(5660300002)(41300700001)(7416002)(8936002)(31686004)(4744005)(316002)(31696002)(86362001)(6666004)(6486002)(6512007)(36756003)(2616005)(53546011)(26005)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UGpxNkFrcnhDUHNabFFFVVNVZy9iSWJFbzhpRVZ3Q1RtQUV3Q25jRVYxZkRN?=
 =?utf-8?B?V3lUaWFIcG5veVVuRlRYMDN6d0JJQzNyVUNkL0Y4SlM2NjBKeW9JZmF5VStD?=
 =?utf-8?B?R1J1dnNwa0trU25EcTdoTThNRjFoOEJtVUVGMWdPb3hjcEpBc2JXUUpSSk1J?=
 =?utf-8?B?RytBWWhPWmtTVG9GQURqUUc1c1FYWE1pYlJZdFpQcGx5QmtyRnVmQkoyQWZx?=
 =?utf-8?B?U0pENEdmbzNmaU4zMTduTS9qWEhyc1ZzSlZuajFVQmdZQmFGL3pacHgyQ005?=
 =?utf-8?B?VFl4WHdMS08vbzRYZnA1NlM5Wjd6MzluRHU1S0tzRkkvcE5BT2UyR1RPWWh5?=
 =?utf-8?B?bms0S1NUQkdleit6NzkrcTFBNFdoMkNablNHVEVDRjVFYndaYmxvYzZzWlph?=
 =?utf-8?B?d1dtMGJLc1RjMlIwNkdrQXp0cHhrS0JCWUM0NlRBcWZFUmc1bm1MMnQwWFVn?=
 =?utf-8?B?Z2RXc2xROUlNV0pFQmpSbU80K2dINEdJOFFKMHd2R3BHZlFDTVFFMEthNVlK?=
 =?utf-8?B?ZUJiUnlRL0xscDEyQSs1c3QwKzdmRzNkWmxoc3lTbWpCNXpmYzl5Lzlxd1Fi?=
 =?utf-8?B?NlpkWTUzVWd0d0ZpWUxPdHlpZjF6bnNVTlRBc29TbHdlWXFuSDZtZUg3TWQw?=
 =?utf-8?B?V1BlVFh4UUVVeU5ZU3VZZ2tnMXYvdFA0TjliWlovV3QxU2YzeXhUUGtUNnM5?=
 =?utf-8?B?dGdtYXB3WkV1cVg5cVlKU2E0eXZWeHV0WGZiL1ZSVFh5anhwTGZXK2JYZUMw?=
 =?utf-8?B?VkVSZ1FtOVlGaTE2ekZpb1dQNXJlK0hJMnFVdlNqNEhSNlVqK0tKRFJ1dzBN?=
 =?utf-8?B?aTNLTXhxa0VTaXNNZ3NlN0dseVNGckVCYjltTS83ckNnWkF5NFhySU1wU0F5?=
 =?utf-8?B?R1ZSdENjWXdFNy8wdC9zYUN4OTIrenRnd1pXaFR4TnRZZy90eWcvcmtjREF6?=
 =?utf-8?B?QUFBMXF0SWZqMGJ6d3JaMERpTnZhUStLWUtDYzFwaTBoYi9EeUFNYmcxdUVH?=
 =?utf-8?B?N09xRVZQVEJiMnZSazBqbjhseHZPdVFUZzkxUDdmUE5DdzIxbUs2Q3FDWndY?=
 =?utf-8?B?TjdJRXVpNlRoSVVvdW9MU0xTbUI5VVlLVjg0QlJleXJqeEtqcFVmc3RYbTd6?=
 =?utf-8?B?SDN1RjZEd1N6QzkvYXVJekJZamxmYkRQaUVpbURJQ1dCT0pTRVdUcGVXOSt5?=
 =?utf-8?B?UlJqK3JQcVhMVEw3Qzg2Z0xPWTc4MlFkUDRQTy9FWlNBK0ZIR21zSGpubity?=
 =?utf-8?B?TVdaUGp6N2VDdEg2Q3JiY0lDQWJTd2pkaytsSnNzZ3A4NFRIOHV0eExGZXdB?=
 =?utf-8?B?VnRJeTBFSGFIZzUvaVFvSUQ3UnBMNi9SalhFcXVTZGFCUWM0TStIMVlXU2Zj?=
 =?utf-8?B?L1J5WEtKSEVnLzJFOGR6OG1FQktpMHU1QWYzMkxOcEtkVjVXZTdHNjVOQ1pU?=
 =?utf-8?B?b3lQZ3FIeGZqL2ZhejlSUUlnY3FJaGVYaTJqZUtsL2NnNjE2QVB3RlRJekE2?=
 =?utf-8?B?Yk12WThNZkcwYnU0YnBHQkx5UmoyN2NFVGZJWkowYklZN1p2VEpLNkIxOFBB?=
 =?utf-8?B?V1k1ZlJWM2dCSnM5WVgydGxkdjZNTEM4OEZSUU4vR09Ta0JlODdHTGVEaEtK?=
 =?utf-8?B?ZDVYeFdPSVpWREhNZ2Z1QkRFNUV3aThVNkxjd3JPdXFFZTZQVEVIUnJacXZC?=
 =?utf-8?B?a0dCcEt5NEFJSXlmczZFNDgwVWNFWXBVNUlUVjFjWmtDaFV3Nk02VnpxT3V4?=
 =?utf-8?B?cFY3MDQySXp5cXByeHVZS0xiY2VMNWlWOWZHaDFjR1EwTFVaNGpjTUNmTUtS?=
 =?utf-8?B?djRmN2VSZXNOSE00NDhoNStXbldjeG8zWGlnbXhMejRhL29FenhqRUlPV0h3?=
 =?utf-8?B?NU1tNXo0Rk4yTmlMSjM2SXZLVUJCejArRFQyTWhsSFNqMXBrakxqa2pqbjQ3?=
 =?utf-8?B?V2FYSzVYNk5TL2ZraVFTRWlJQ3BPc0FpQyswbTFteFY0YTBDVUorQnlJWXR0?=
 =?utf-8?B?S3ZDMXdPQlpjWXNFUVM2WkNyZ2xHNTVyNXp5YTQySXRIZjhPb1ZRS3FiQlJu?=
 =?utf-8?B?WWxGUVV1dlZHVXBDWE5JS3lWL0VUUUdkSDhrYjZqcURwMytpeUFxeUJaaVhZ?=
 =?utf-8?Q?jGaYeI5dNTbDqS9tQOCW9lFDM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 847eeb60-4025-411b-c462-08db9a3f92bc
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6434.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 07:50:04.2973
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M709VkpIQwGwXNN+NvLPG5GIUQcBK9NrKtheV4n+VLJwXiLBXBrQMjZZnoZQfbs61vc6kTi+HaQBgpqIvi+09Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7348
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11-Aug-23 11:56 AM, Huang, Ying wrote:
> Hi, Rao,
> 
> Bharata B Rao <bharata@amd.com> writes:
> 
>> On 24-Jul-23 11:28 PM, Andrew Morton wrote:
>>> On Fri, 21 Jul 2023 14:15:31 +1000 Alistair Popple <apopple@nvidia.com> wrote:
>>>
>>>> Thanks for this Huang, I had been hoping to take a look at it this week
>>>> but have run out of time. I'm keen to do some testing with it as well.
>>>
>>> Thanks.  I'll queue this in mm-unstable for some testing.  Detailed
>>> review and testing would be appreciated.
>>
>> I gave this series a try on a 2P system with 2 CXL cards. I don't trust the
>> bandwidth and latency numbers reported by HMAT here, but FWIW, this patchset
>> puts the CXL nodes on a lower tier than DRAM nodes.
> 
> Thank you very much!
> 
> Can I add your "Tested-by" for the series?

Yes if the above test qualifies for it, please go ahead.

Regards,
Bharata.
