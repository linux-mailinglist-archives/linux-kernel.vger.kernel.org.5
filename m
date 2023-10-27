Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 755767DA227
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 23:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232785AbjJ0VEJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 17:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232330AbjJ0VEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 17:04:07 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2072.outbound.protection.outlook.com [40.107.94.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F9021A5
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 14:04:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CPsR/0TrlQCW8+/favPRT+mGKfKByJTzbtO/U8tsPaC3jdrJod7hKovvKdHdGb3hyMyr0YYAqB8gHbCNgRJwNHhUluQ+z5UoENL62yacnIDGMaEb4cX/qdNCy3+id6ecEufrf/+GKLm6ke4onaHAfxQgws8xONZqvBnRU8UQJ78RYfUkCOtfyPpLkHFRlG0UnFM4NZ/Hir/OcKfFyfPLdrobfXhB06fnq3YQ4I4GJPaEraXT5O17VaGUWRqns7T2aOlSUcYasaVrQ4yi5bhYUUZjJZt8wlXLs5+gBm4uCPKPB6EtUXjdlUCRtqHyYKHmcF6Aff5UF5K89tFO5+TVMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kqW6hAXOqflKFr+FlKH9rL+gxleUuVQAvUGAtKdvzB8=;
 b=lJzd7iFdDwyfUMSvbFXFIxP6xemH5Q9zfLuRxvQ6CAGSs9vEcg1qlvHP0LCHozI2Z0ExHZxifysIRgPMKX95QsoiUJZwRiD9LDMfIfcZLoYWjGXRW+Tw+lqheBEYGlHSeVIGB48elVOdUcZCfG2YhMawANDMK8QYauEPDCq3JgIC8nsbRh4YZ/c5FWL/55NGKFhC2mXUByLJIU5oIY310S44BWxULhW+y3YLktwh2fBNjtbWIr05cOUStP6Xl4u7pCKg1mrJP4TooU+qxDFJe0AY7O7A//EmpwXwl/S2BOlXNiRG3OoWnPwiqRuI1sEva7pdN2UDtWe0thOO9JC4WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kqW6hAXOqflKFr+FlKH9rL+gxleUuVQAvUGAtKdvzB8=;
 b=cMxme6yInqoMCgtmThIja6gD51/SHNX58mRlj+ImxvHY/pJfTTNK/qaoQAeuJi1qoADytmqR0zpdngyqqrwbgqfFoJbaNDVcXd+EUCK2y1lB2KYuHu1Mlx/CVTB88CzawQzowYtThFGgEq/K3JcrtWohAtyiQlCFzobKh176VAmFEAqT0Pw25oMtkU1c+bIzxdfJT9eChnqehSPln86G5fX/5uniGu7kHyW9Tl9L3ENalVa/EvjowPUOTwD5lnnhCOZoCRhQYQkjKHzInTSf4Lq1yOyMJNdV5QGxnhyypkq3MCoGapU5REllJa1VEhHr1Pq2bTHG7zXXnMY154HjGg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB6604.namprd12.prod.outlook.com (2603:10b6:208:3a0::7)
 by BL1PR12MB5351.namprd12.prod.outlook.com (2603:10b6:208:317::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.24; Fri, 27 Oct
 2023 21:04:01 +0000
Received: from IA1PR12MB6604.namprd12.prod.outlook.com
 ([fe80::16f8:183d:56cb:ba69]) by IA1PR12MB6604.namprd12.prod.outlook.com
 ([fe80::16f8:183d:56cb:ba69%6]) with mapi id 15.20.6907.028; Fri, 27 Oct 2023
 21:04:01 +0000
Message-ID: <1594aa5d-8556-26f7-b4ce-d6c8289342fb@nvidia.com>
Date:   Fri, 27 Oct 2023 14:03:57 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v1 1/1] hte: Use kasprintf() instead of fixed buffer
 formatting
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     timestamp@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20231010141123.3909596-1-andriy.shevchenko@linux.intel.com>
 <59939570-3779-ef90-2a72-7be32a30e368@nvidia.com>
 <ZTuvjqYXxWPyHrVR@smile.fi.intel.com>
X-Nvconfidentiality: public
From:   Dipen Patel <dipenp@nvidia.com>
In-Reply-To: <ZTuvjqYXxWPyHrVR@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0019.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::24) To IA1PR12MB6604.namprd12.prod.outlook.com
 (2603:10b6:208:3a0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6604:EE_|BL1PR12MB5351:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a2ace20-f54d-4e20-0c51-08dbd7303e62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4kaqlozaa4HhywOEMW/l6MTQY1tfYjeVnjKWDYTtotTjpMCeyzSgJhZy5GOOSdvVX71IpvY37lDDq5OLyiov8X4mu1pY2ZafTyymUAVvOMAYae231F7gK+pDlb/8j10u/IsEYUsasRMCTSM5fYM1gNA29K6F8uyogZWVx2bopcPB4zKddgOeMv3Lg4ek+OogZR0SaFl8jRmYb+I/fUN6u0Qsx8pg507bWOIyJ3tuvBnwY2USmWjZRpvmEeeXPhakXMkIyGpWzdZt0Di5b3llJAuJ05sybPnmbqZb/6gsmmdJLwOfQ6v6rS8vkwFgbUGkzMCPoG10/M01T28bPU04erfgAHrgeiPt9ZL/DcgCu063Ph74Gg1plQl2uSe4j80+N4UtsCorolCEhROWlQl5y1YeSGKOfGR2TWEGFH+gqugEmXlvP3YJrHWJT5LeFvAYJzZgy7PtJc3tRjNWdRKug+HIl9JjXgvj+RVoiZdie1U3wwoJXBZ1wcbWkjeZYo2bgucAUz2xaOi7NiPgheB1SXaeWge0XeDXmRWL5m4INdw9MXJN6phbRPJ05LixUFMnrvYkJocamdBYHHYfK6eFEHDvo1eCQgT4hl/Oj67lYVslyVAStPGRXTAuseiGdBblElW2Q6bbQDA226si+HNW5g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6604.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(136003)(376002)(366004)(39860400002)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(31686004)(6512007)(26005)(38100700002)(36756003)(31696002)(86362001)(4744005)(83380400001)(2906002)(6486002)(6506007)(53546011)(2616005)(478600001)(6666004)(8936002)(8676002)(4326008)(6916009)(316002)(41300700001)(66556008)(66476007)(66946007)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L2VQamk4alRGdi81M3pDOE1Ncm94THBpcm03dk1BdWJMam5PYjVjeCtKelRX?=
 =?utf-8?B?NUVWcFRkT0crS1A1cElCT05hSDh5K205c1Q1YXp4SVRSNnlLMllsSHhVZzJT?=
 =?utf-8?B?K2V5VmRwUmtZRUlwZ09RRXR6TlNoL01TQUVNQkJMU3R1K3BMQURKdmF2RjdN?=
 =?utf-8?B?ZEVvMjRDSGJaU1cvdzA0SlB2SXlZTm9pQTZnbDh4bVBRUm1uWkUyMW0yWkJr?=
 =?utf-8?B?V0JQR1pyUEdLSzdXVXc1TTBaYjJHK051N3hlOHNLaVpMcnlaVlk5Z0JvUFhJ?=
 =?utf-8?B?MzVxYUIzY0RaQjMrY2s5eE4xeVM0d3d1MEtjVEgvRGxwNmx0L2RFbnpkKzky?=
 =?utf-8?B?UHFqRHFRMVZ3bTFMUnhVeWloYUo2VUl6emhHT2haelcrSkcrVnVIT2VGcnQ3?=
 =?utf-8?B?VnpWWDd3OUljTmNvRGxrYkZVTnh0cTJrOW9aRzJFZVdKM1pQQS9lUTB4N3p1?=
 =?utf-8?B?M0ZzeUpYeXFzYmtpaE1LbGJtRlp6czRma2ZiQmdQSFgya0JMMkZITURhbitV?=
 =?utf-8?B?Mno0eGJyS0wzekg4blJTdWROMDU1bDl5UnVqWW5PTHBiYm9TdnJIdGxpaG40?=
 =?utf-8?B?Kzh1Wlo2b0ZyWU5RWEdNZ2w2aU5rSXdDVHJYdDUwRXZ2dUdTVWhWY1B2cW5W?=
 =?utf-8?B?d0djUWxjK2FrQWwzUyt4ajVaZzI3YXlkaGlUN3F0UklwU1lpTHNsL3JzaFFa?=
 =?utf-8?B?ZjV1cEh6b2xDL0pZaElvditRU1JLdVF4aEJNaUhrTk5RM2lzSDFNaUpFczJV?=
 =?utf-8?B?V3pFOUxXNXhiY3pKN1ljNWEwNjZrb0Q2aWptTG0xTUNuaERWeDJHNGF5dU00?=
 =?utf-8?B?ZDBpVlBLbC9XMC8zb0o3ZGVuN05jZ1ZGd2dJeHNZNytxSmx3V3cvcWFLY1BH?=
 =?utf-8?B?bGkrM3IyN043ekljTTlQR2Z2VCttcWhXSGNVZGZOZ2dCaHRXNkVSUFc2K3pq?=
 =?utf-8?B?dXpZUkZxQzUvWHZRQTdzUHJ4YmtPUWRyMkRhNDZpQXZqVlQ2bStQeGRZNlF1?=
 =?utf-8?B?NDluTVNiZWU0VlQvSTRpMXJ1eGNRdVlrYk56c0NiNXZXSFB4c1haTCtDKzhr?=
 =?utf-8?B?cVRYSXFRN3VobVVXWmgxTUJaajZWR0xDR1FiSHA4MThBM2Q5aUFJY0dkZGRz?=
 =?utf-8?B?NDljZVluZFdxb3ltam1VZFNteUNKM0VJcFVkalFzY2NQemwvdzY4MzRtZkxu?=
 =?utf-8?B?ZkU2V0NYZGJHaWlxMkdNbXVMZnhkdkFCQ0NLaUp6ckZaa0RrcFB5aDdjRnRM?=
 =?utf-8?B?ZE8xS3IrL0R4ckplL1V3ajQxTTlsaU5Fd21CTGR5SmxrNzE1U0sweWRrU2VL?=
 =?utf-8?B?Qk1ORS9yM1hmc1BpV01OWW5WM21vK0ROcWk3Nm9vVmYzOFYvWmxIa1JWb2dR?=
 =?utf-8?B?dEdUM0pSWjVyRFFMZHNIMjNCSVhFeGc1V1V1WVc3TStGTTg4OHJISkE5N0wy?=
 =?utf-8?B?VVNvWkdzc09KTnZyVS9hYk1GcXJoN2hoYXFKNXhyZ2h6MHRzU1FsOWZla1d6?=
 =?utf-8?B?R0ZWYU9nNTlWS2pGYUNoekIzVE9jVXV2blBFQm1Yd3dZSmpzTTVjRm5BZjNj?=
 =?utf-8?B?SFNjYXpzcml4VFZGR2h5cmVrcEZIVEF4dkorRTY1WUxSY0EvWVh2aG8rMmdn?=
 =?utf-8?B?SjRib1hDMVRpQmR6engvRW1pU1BVbXpxZ1BQQXZPcFNEOEQzNGtCUHhzSHNP?=
 =?utf-8?B?emFOYkVFT2VZY0cycDY1bFZGM3MvYWljN0F5REhBdTR6ZndGSHZqTWdhVFhB?=
 =?utf-8?B?a2JDNFJHNWRvYXUydjVRTFcvZWY1Q3NTOS9MS3BvRzY0VTYvY1ZZMTdRSWdt?=
 =?utf-8?B?cGhjRmw2N1h6SlRrY01WYURWSXExcmNsUmovb1ZkZjEwTzJnU3hHTnhBeVhi?=
 =?utf-8?B?SmdNUy9xTEFHL0FvQ2JrL2ZRVzd4K256TVBWcjVpNlV3R2VCdEFyZGV6L1pW?=
 =?utf-8?B?akJzQW1yZzRxelo1VFZYanN2MnhkZHRYa2hTdGNXVm81ai90N1NobjlLU0J0?=
 =?utf-8?B?UDZLQXdMeTBmTk5mTUxtWUJKUks3VytKME1lZkF0RXJvZWVDdnh4YW9UbE1S?=
 =?utf-8?B?Y2FhUThBbHRkUXJFd3ZiaWNieDJIcDQ1TFFNYTRhQWNKZWJvbkU4NDN0VUNP?=
 =?utf-8?Q?wKJC0PTBQXTJ5BKOFIzsQ8aJw?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a2ace20-f54d-4e20-0c51-08dbd7303e62
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6604.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 21:04:01.0338
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: izHjBkuOt4/mv53kWAQyOyEMEGkfuwhs5hKSDwD6WBo3UsJDQj7wsLASgoVwHqD1Bb+3Ifc42v5uQJhko566KA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5351
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/27/23 5:39 AM, Andy Shevchenko wrote:
> On Tue, Oct 10, 2023 at 09:12:09AM -0700, Dipen Patel wrote:
>> On 10/10/23 7:11 AM, Andy Shevchenko wrote:
>>> Improve readability and maintainability by replacing a hardcoded string
>>> allocation and formatting by the use of the kasprintf() helper.
> 
> ...
> 
>>>  	hte_ts_dbgfs_init(desc->attr.name == NULL ?
>>>  			  ei->line_name : desc->attr.name, ei);
>> Reviewed-by: Dipen Patel <dipenp@nvidia.com>
> 
> Thanks!
> 
> Who is the maintainer of this code?
> If not you, shouldn't MAINTAINERS to be updated to reflect that?
> 
I am the maintainer, I am not sure how did I miss this patch for my for-next.
Let me push this right away.
