Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD827B7782
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 07:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241359AbjJDFfd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 01:35:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232178AbjJDFfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 01:35:31 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2083.outbound.protection.outlook.com [40.107.243.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB768A7
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 22:35:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CLRkiawHO5Gj8tKa79GVpjCUZoMNG+JGgslPyzccU2rV3sSLZvusxFIIRsx+LUsBlamxKTv5r0HFvy0buYtXBCWSVJhbPVEogEtE5olIVnm43CwmF5+Rv0LLkqQN6QrJP33yJ0obKyPhw4FWNd5c4Evo6k7JzwuekkfBzOY3rlKKCLTO2R9N5HBuh13/XiUnrAhmdsatox3vcxhLPuJIlDNZWYO029Q9aXfF5O3iV0+K7fvIpqs6zhAHfAI0dUbEaPl4wPleFfGhf/Rc6epnnPH5bq8QyHVMfOBQUgRGgr0o79VKKvbK5BdW/gDjiE+WHWO9/FFy2sHgCKysPlfMUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5UiYYDnEZqe//oyZQE6lDtt41VEWei4zPF7ak984Jwo=;
 b=AYBudQA3076/MON2p6LtO59zHBe+fuEBKF3LIp0VQtoR7cUKBeckIjloaYEqKeeJZdPMSaV97th7cvlEqarCVJ0pYZ+fYkicD6VG7FPUeQvVvQ88i/c0OEneUWOpgv+sWf7/ap0N6GgzYVjI6s+hRFkm+YYtIP6MB1NNKCQrev4Nw+Is5h2AES9UnF1VS9g3GNJxeLymi/8Msn7plmq7TQqvqNbVNaZb9v0gYPP5MVaJ5v04xz0G5VGf5SHO+/K5Fz7VohbAKfHBS0cgix1vyJ/HgwFE+cR17BM3KTf8fvLxmLeUCMLtOltxLoI01xj0Ge5vqxQAmrMjoZR1Cbb24A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5UiYYDnEZqe//oyZQE6lDtt41VEWei4zPF7ak984Jwo=;
 b=hDAgUgFcmdMgBFM4eNSuv/k524T8YJFrbebjcJAysps7p1bHqwl4SQGzwhpjLR8fB4YtQp5uUgHk5bz7VnrEYr14RF2sigZdObVGpbnbhpXd+hvvnlI04Vy2L+rP3Rb+GSanUGYNgQpcEb3m+eST+p190C4wxWM/DfHhemvKtAA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6309.namprd12.prod.outlook.com (2603:10b6:8:96::19) by
 SN7PR12MB7934.namprd12.prod.outlook.com (2603:10b6:806:346::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Wed, 4 Oct
 2023 05:35:24 +0000
Received: from DS7PR12MB6309.namprd12.prod.outlook.com
 ([fe80::93cc:c27:4af6:b78c]) by DS7PR12MB6309.namprd12.prod.outlook.com
 ([fe80::93cc:c27:4af6:b78c%2]) with mapi id 15.20.6838.033; Wed, 4 Oct 2023
 05:35:24 +0000
Message-ID: <9a6af215-e696-5091-69fa-1cbebe772471@amd.com>
Date:   Wed, 4 Oct 2023 11:05:14 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4 00/14] Add Secure TSC support for SNP guests
From:   "Nikunj A. Dadhania" <nikunj@amd.com>
To:     thomas.lendacky@amd.com, x86@kernel.org
Cc:     dionnaglaze@google.com, pgonda@google.com, seanjc@google.com,
        pbonzini@redhat.com, bp@alien8.de, linux-kernel@vger.kernel.org
References: <20230814055222.1056404-1-nikunj@amd.com>
 <f200403b-c460-5ebb-fec5-c5caf0cdb006@amd.com>
Content-Language: en-US
In-Reply-To: <f200403b-c460-5ebb-fec5-c5caf0cdb006@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0028.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::7) To DS7PR12MB6309.namprd12.prod.outlook.com
 (2603:10b6:8:96::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6309:EE_|SN7PR12MB7934:EE_
X-MS-Office365-Filtering-Correlation-Id: 1247e123-e9a6-407d-02da-08dbc49bb513
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1qSwTs8LFxdHGLxVLOVHA23NjKzdy7tcghFuoqjqtUaxiqAuBZYin5uJ1kGBAn8x0g9tIP3+gmdFQdoxVZEIZu+TOWh6yJAgFF8KUMbvUgAyxOJLCDk3MAs4GOEuEr/zoPShgqRBZLxu/kG2WhJ4xtWgkILSdgVk11ZQIVeCqjrWK310xiZa0TrCW5Zj/s18Hqhz1sUvLfbsUSy4OuEY+zB8Orxm4TScx1W58TOpp/W6IRR1ieuaF1XUhAZ7rBwkosZvcAcbNl9JqXlnMHeAVvpMsFlOxgCDwMXWtgcPspL3dIdTRBpqJulPOkrUPrYzw75uE7bbv9Ixl4LN0BVf0jOoOfd+r54nGYhSlrclElLC/ptAb82i4A/14Hlq+umx7QBInHrPC0CIPyBGZ+fATIHO7xCmFNMqhYa+iBnN4RQ3whPSRjzXuFXF2kFNj9jQwAj2267HbPqb+CdRsArzDeA2QSDDvrZvEAppOEr7abv03KNGwz4FULpfa/awlYa5b4qbCPgUXK1BdLMkhg+LLu3Scz7Vt+ouzY27tb2MTJn0+2DADCTjC7YYIbNVeze/Nh2MWQ6AVMsQmqZX3Tj2N39A2YKjpnfDtwgyP8uVG3I+u2E5CT4vc0nzTao+OgDCr9LrBm6Im6MjA7DDuByAcQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6309.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(39860400002)(396003)(376002)(136003)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(31686004)(53546011)(6506007)(6486002)(6666004)(478600001)(6512007)(31696002)(38100700002)(2906002)(4744005)(83380400001)(26005)(2616005)(36756003)(66556008)(66946007)(5660300002)(66476007)(41300700001)(316002)(4326008)(8936002)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QlZIcldZUTdEUlRqaVIvckJ2MmZsTllFcmRaMTFpZ2VHdkZMSW8xQlVaeUZM?=
 =?utf-8?B?b0lucXB5NVJ5TkVzRjBSUFhDYkpaK0ExRnkwM2xuNUtNdWNrTVVaeDdiaWZJ?=
 =?utf-8?B?eGtCL3pXZkYrSDYxWEFCQW05eTB0dnZCTUt3MmNySTNFaXBVZUtiZTZqRmVi?=
 =?utf-8?B?YWE4a1B5WEdHa2xDWkkrZUZmdmFhU0tudHI4dzloTHhPWkhaZVNvZXNLNU9T?=
 =?utf-8?B?VHVwZk0rSGVEVFRhc0NYZE1wK1BtbnNxb29hN2hYVHV5aFN0UmVaZkJaU29h?=
 =?utf-8?B?aEZqVFlKcXFreENTNFcyU1hmZGp2Mi9hMVpYMGhNdktFb2dIYXVtSUVmd3Nr?=
 =?utf-8?B?bDVmdytkK1VCTHBUTi8zb1E2UDZnZ2R6Y0Y0YlF1WmpncHFwNmFnZHlKd0Yv?=
 =?utf-8?B?ZlBJN1N3MzZIZGlxTCtFcFY3Z0pOVGs2RldxRU1RcEZOdzhwQlhKY1Z5djJ3?=
 =?utf-8?B?aXRsdVFRd2h0TGlqZHFFc3I3WlY2QVpkUXphNXhiOTU3RzkzaHZTa0NvQ2dw?=
 =?utf-8?B?Z01kd1BMT1dDSlpQNExOWDNoK1VJeEFUbC85NFJZYXlVQTA1NUhpZ3daOUZh?=
 =?utf-8?B?Nnd4cGVCVXlqZFl3MmlrREhRYjkvc0hrM2JFdmgyY201Qjg2eTcyZ1JiRFlS?=
 =?utf-8?B?NmgxMG9XOUN1VGxYRm9Fa3JvTk9vU3lXSkliYnFPREpzYVBGVThZcG1iZHli?=
 =?utf-8?B?V1Z1bGJTeTlUT2tkbVBCem1wSldPNU5SWnZxU0hFclExZ255VkZLRGZFZmJu?=
 =?utf-8?B?WXVQYSsxSE81ZXByZGp3d1dzS0puMzhyMU5BMWJBUVFERDA3MUN5bkI5VjVO?=
 =?utf-8?B?VFZmdXMvZk5nV3dXMVRLdVJXWEgxcEJLWnNTMS8xSkgvc0JrRHl4OTBXOGxo?=
 =?utf-8?B?QkpOdlhFbGZQWC9hZGZpOGN6WDZ1NnJTZit4NDREanQ1T3hYNkdqcmxUejA5?=
 =?utf-8?B?L1g0NkxlQ25UbmZ2bXU3UlVXcCtHeGdianhidmc0SlJrOU1WclZPSnl1Rnhs?=
 =?utf-8?B?RjA2QXdUSVFTK053VzhyVGRyQWs4M0RiOUtMWUFOY0xGRHlRZ3A2alJGcDJl?=
 =?utf-8?B?ZUNMVXo4SXcwNGVOZGdHajA3VmpMekJ2MTAyRlhJRXdObldIRG43MlVtWXho?=
 =?utf-8?B?QTQ2WUdFS1R6RmJEdnFsOFZBSzNUaS9KcHFZVU9LSkU1WFduOVhuSW9sWmRI?=
 =?utf-8?B?bWRGNERzS1lRbUFoTEZWM1ZUTU1pMXE4TlpTRE5NWmtLb1dzMGJwc2UzTFdL?=
 =?utf-8?B?WDl3SEZMd0RhalBoaHFNMlRCbUkwSTArWGs2TE9PTVhpOXgwcUludmgzUXRQ?=
 =?utf-8?B?M2w2ejA2Q2hlU2lEdnNOY1pVQXVDKzljMUJhKzFmL012UzdORytXY2RGRC9S?=
 =?utf-8?B?NlpkV0lFalVIdS8rTldRMG5KU0VCZEtqb0txeFZsR3ZMdjZWdExESGVvYkFT?=
 =?utf-8?B?aFFLTTZsYk41ZktPa2t6ZEdUL0dFTUVOZnRIdDFGMmllck5Lb0VFU0JmaENK?=
 =?utf-8?B?SjBWc1JhczVjSkR0emRvVG5lVW05bmQzQmpnMkxGZUc3MzNjZmZ4QStHK2dU?=
 =?utf-8?B?S3M3TUJWUmVUbmxOdTN1ZHQ2VDhDbkEwbHEvNDN5OERpaVNIR3JRWExNZHRI?=
 =?utf-8?B?TE1DTTV6NklBWTRhRHRaNUtCY2ExTFloYjlKbXU4NjhHQUhKcWZNRytKK25x?=
 =?utf-8?B?aEtQaXNoM2NZYnhOZnVsWHF1aVBDVFk5Yi9nVHF3RVJZbkp4RmxQZElPTGtG?=
 =?utf-8?B?VFBGdmg5ZUhIWEE2bTI4MjFIaExDUWVkY3hKNjFYbDllM1RialNPeEgyS0sw?=
 =?utf-8?B?eTJicE9CdkNPeHBWTFdPZE5WV2pkTitlZlVRNDQxWXZOL1VkNDVjWTVkMUpr?=
 =?utf-8?B?OFQrOTR2K3dJc1N3WEFiQWxyZ1lUYkY2N3RyNGlBYXJRYUJvdEpOY01jQktr?=
 =?utf-8?B?ekNkMHJDMmRDWXhLMHFrZ1dUVURKazQ5eEdQeWFTZzBsUEtKQU4vRDFrTXRh?=
 =?utf-8?B?Wlo2c0tjc0lBb1lNOTZxTTBJUE95MU90NzJNbEcxVmRpWnJaYVdMZHdmTnlX?=
 =?utf-8?B?VjlqZ1h1T1FrQXl4eDhTazdJdXNISWRmU05jeDRIVmFIR3BZWUVUdXRHTlJS?=
 =?utf-8?Q?raGFHMwcr6grbhq1j2pgUeLhS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1247e123-e9a6-407d-02da-08dbc49bb513
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6309.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 05:35:24.4638
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yUJcIcAQvdxx1hu8zrsJe3TWOX6r8X+0GtQLvvFNWhMFUFAahZLNxQnfXzS7OxL8siaAqHYuDCXRdNZiIKyHbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7934
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/28/2023 9:17 AM, Nikunj A. Dadhania wrote:
> On 8/14/2023 11:22 AM, Nikunj A Dadhania wrote:
>> Secure TSC allows guests to securely use RDTSC/RDTSCP instructions as the
>> parameters being used cannot be changed by hypervisor once the guest is
>> launched. More details in the AMD64 APM Vol 2, Section "Secure TSC".
>>
...
>>
>> Changelog:
>> ----------
>> v4:
>> * Drop handle_guest_request() and handle_guest_request_ext()
>> * Drop NULL check for key
>> * Corrected commit subject
>> * Added Reviewed-by from Tom
> 
> A gentle reminder.


Ping ?

Regards
Nikunj

