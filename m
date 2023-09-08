Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C22F8799198
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 23:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344281AbjIHVpd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 17:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343744AbjIHVpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 17:45:31 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79D751FDE;
        Fri,  8 Sep 2023 14:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694209524; x=1725745524;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PVszhfBEev/fBLukNxrrbXYVAoq0NqDGuUO9CpdBPdU=;
  b=kEn9SSnZWWYkJpUplXW6WRva9unkl1inLTlqesJqw4KThMvfZsTanhMI
   Fx5cXQavIN0L99dP6Lzzo1zh8hcAtKgWtcu9QqkWL7MR079d82/U9vkl0
   vXDJBsEHsOKmz7DWqoXzxg5nPTEpLGAOFCEPwebcAE8s0idSmbgS1Y8ke
   s1gfjihUNzslbPBEMkUPcn1eFfA8NHCZfMJEgbwESToTrs5DK+sKr5+co
   0CsQ8u9H+8rP90VeXkL2MyeXt3f91GNM5jHm+66rm6gokHtzhmhvAODCM
   iqcDGYi5i+B8JkMIlnACQ2aYoS0UpK8rU3vjPuablGDnXqXdXdkhPxDK+
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10827"; a="464123750"
X-IronPort-AV: E=Sophos;i="6.02,237,1688454000"; 
   d="scan'208";a="464123750"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2023 14:44:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10827"; a="812706877"
X-IronPort-AV: E=Sophos;i="6.02,237,1688454000"; 
   d="scan'208";a="812706877"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Sep 2023 14:44:48 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 8 Sep 2023 14:44:48 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 8 Sep 2023 14:44:48 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 8 Sep 2023 14:44:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O37wpha1Y0Ush3ckTcgxEJ08GD/DMfPQKr2ylcf6Sy2LNAr7XuDT3LsHbCsjLdlrBA6M9iKV7Rue4TuahFwGIqxIVU5EML4Wk9j0LsCaMcn7DbXll80wtlOapC4By92YnZv+k3tymrd+OjpsKjmeQ+Fqa24oEv20CGL1hbxbN7A2Ur3LehilgRMtOcIa/iYZNkScEylT+RzguReQ6hgAvHx2d3P4jfP3qbTTJhiukapvwEg0myrUPIdUYdsqjcdvENbGcaZLaqhUVmfUQimeVm2/hWD0hmjTAmF+W0VxKB58QzwNnYeo7sEzQgug5XsqnvwCl81LTkihisVqEVaPQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J0pSSA7txplfFLJ30YtVf0+k0smzRfTZtdn2ZHEMalg=;
 b=Fld1WdCZdj5Bxyg9MKJ8jYzz3dVnFr6UFBc97WAKQkdU94neHKZXZjTgQtQbwGfjq+zolZ0t01pwj94YqRq6rPS2bI9amkGbVirzG2SBx+AtMsQlAhYSICs2KQdWXxA5NTak5pcFFJaLMhgcuS38faWdSvD5BHbG+8slQJ/GlA4q2rxAzCdnYb2sYSWFBx10/UNGY61BOFbfbAAOhSEJWIlw1Z5vOCqI6e/XLq9dKaCMBkeptwZ5RRXrLEUHBmF+7/TfVccUT0gAPKwaIXn5VAnkPJi9hIjjtuFx6E/rFsrZfHR2votd4+YjkERIRl/MYvOLI0NLx9IeP81P7617rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DS0PR11MB8020.namprd11.prod.outlook.com (2603:10b6:8:114::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Fri, 8 Sep
 2023 21:44:46 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::6a23:786d:65f7:ef0b]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::6a23:786d:65f7:ef0b%6]) with mapi id 15.20.6768.029; Fri, 8 Sep 2023
 21:44:46 +0000
Message-ID: <44f1815e-9949-9782-97ee-60c767709c31@intel.com>
Date:   Fri, 8 Sep 2023 14:44:43 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH AUTOSEL 6.1 01/26] devlink: remove reload failed checks in
 params get/set callbacks
Content-Language: en-US
To:     Sasha Levin <sashal@kernel.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>
CC:     Jiri Pirko <jiri@nvidia.com>, Ido Schimmel <idosch@nvidia.com>,
        "Jakub Kicinski" <kuba@kernel.org>,
        "David S . Miller" <davem@davemloft.net>, <edumazet@google.com>,
        <pabeni@redhat.com>, <jiri@resnulli.us>,
        <michal.wilczynski@intel.com>, <shayd@nvidia.com>,
        <netdev@vger.kernel.org>
References: <20230908181806.3460164-1-sashal@kernel.org>
From:   Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20230908181806.3460164-1-sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0343.namprd03.prod.outlook.com
 (2603:10b6:303:dc::18) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|DS0PR11MB8020:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bee0f6e-6968-4d5a-e846-08dbb0b4d1ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TjBb1fKdAB7tuD8I3NvBGJ5OFbSroilNfDZOh4o5SPv3b6bE0gizWltcqFJ5Y93yijySifSkkdydi9Jk32Kb2PefrFW7KCdWIWghCrBBlX+Jcmcb37ffPUxcHghZ+X2reZ/cAJjFnNsvqfTeD8OKvg9AvjkdvPCkmFQI4IAtZBhZR4deAyAPe85v90Ccv+KzLWfqXzkVtl/cSV3vWPOZQ3l3eee2UX1aObHNGBoARY2cX8tGScipEC9ZNTgh86+kjb+hNegMp3LxnS1q1U6cAE9vVAxPRWkQPf6fcpsVqqwKQ5V5QHybcH4WNDggY2cciLYKoJj/s8rgrWnOCQhHle4Z7PSkAfW/SLWRZ9kPo3ZplOaILkQzP86KTyHzahLZlsaqd/RGmlxMDeVoeYSz36NrzDwtfDXUznPFaYWe4m4MVn/tn/crZL7KON6VmhqsXdjvAmRZf8rAbGZzijgacaI/stTsTxkZ8UZQtnvVE9zcit5UPLJf1wC7YeXuB7HRIZWABH8mOX/lsDhAULXPQod2Zl9ZCfaKkIO7tayXQRjQ53ztC1QW7ley+3dvgRmUYcCBHvyqcYscRzH+4y3R5XJpfIDD0DX15VNXjYK4+A+MWSEswXW8XfrlnSvG9tdpVy1/DqEOCJlm5DQLe8+LIw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(39860400002)(136003)(396003)(186009)(1800799009)(451199024)(26005)(5660300002)(8936002)(2616005)(4326008)(8676002)(2906002)(83380400001)(7416002)(31696002)(86362001)(38100700002)(82960400001)(36756003)(53546011)(6506007)(66556008)(6486002)(66946007)(54906003)(66476007)(31686004)(6666004)(41300700001)(478600001)(6512007)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OE1Na2l6ekRpTzMrVzg3a0VaQW56TjFTRTZBNkxuN1ljV0xrRUhhYVBxRjVZ?=
 =?utf-8?B?ZjVxTjY3bmRZOTZMVEk0TFBia2JqQ0JyRFJtNEp3bTJjelArZENSY3VWWUti?=
 =?utf-8?B?eHNyUUZzSjRlcmZKR2RxeVBzUE12OXNucVJSeEFhRU8rVnhIRlhQeUwvTTUr?=
 =?utf-8?B?cklpY2I3UzNCWWgrVHc0MFMvUmg3V3pKVjZPOVFxZU03VklldjY1QW9SaUF0?=
 =?utf-8?B?eDBHS2N6emZpVDBSUzlJSDRRcXJ6UlRMdlluRmZON1ptR1dXMzRIR2hRUkZq?=
 =?utf-8?B?WUNFdkNEZmRkZVVORldieGZ6cGhrVFNLaDFXZ2g4TUE5NnBjS25OOGJNS3dK?=
 =?utf-8?B?citlWUJVTjBER0hlRXAvdlZJbWFHRmlPVU9KNU05UVVYSUJtd3kwQ1BBY2Nu?=
 =?utf-8?B?Q0NVVVJGNXNSL2Q3aWhrUi9jTy9iRTBPbVBncnF6QlFHV01YQlo0YkMzeHRV?=
 =?utf-8?B?K1ZrMGxJUVM4bkplVjZYLzBWbEtHVEFIbFg3Mnp2SFB2eWpYZ3B4Wkxrc21Q?=
 =?utf-8?B?bTE4c3F4ajN5UDN1SFFRNTNBM203U0ZrRmFiRHZEZ1RVNzNES1U2MXA3YVl1?=
 =?utf-8?B?d01sa0Y5Vzg1VC91S3o1RkxGZTQ3aGs1U09lS25HaTlMWGFQUUNZaWlKckl2?=
 =?utf-8?B?T2xqVUNkSmp3MTYwRDVvR3NsRi8yZEw4UDR2bC9KVDZhUmV3dkdrZDZ0eWww?=
 =?utf-8?B?eVA0aVpVaWl4T0kyUlk2RDdpUTlkVStjMnVIdGk5a1o0WnEwYnhMQ0M5YytS?=
 =?utf-8?B?MVlXbGM0a2l0WW4reGhGcUtyMFgzZkd5K3UrK1Q2cXd6endXcjJNTUVzaEY1?=
 =?utf-8?B?V0xVOTZtV1VqZlFaSWgyMGZUU1hZaWRwaFlYaks5YVFnS0tpMDhNWlJ6aUR6?=
 =?utf-8?B?M3RCMHhUamM3eU9BV3MwMWZUTENxcXZiQVJxc05oWEVFUDV3cG90YjFUZXJD?=
 =?utf-8?B?V3JYc2QyTngrcXd2b3pMZ1FhUThKRk1TcjgxMUNwell1ZjNWUEplRjJ5S2tB?=
 =?utf-8?B?aFlXVk1BbnNYVDBpWTd1OGNvZHlBMFlpVXdkT0xoUnNmM2ttNlpyWm44U3FV?=
 =?utf-8?B?QnlCVmNLWEVzTFFlL2hxK0Y0MEV3SWdZa1VNaDVwRXA0Z3Q3bmV5Zk9IS2xG?=
 =?utf-8?B?NU9UK2tSRWd6MHg1Umo0bWI0Z3dPdFkvRUZBYjBjL2kzQjZiQTZlUHp2QUpP?=
 =?utf-8?B?ZlVob1VtbW5YR1RYNmw1akJDeEh3SXBhQ0RzSjlneW5zeHZqK0N6Q3ZPR2sv?=
 =?utf-8?B?QThmT0ZNZ1ozY1R1WUFoZEptVVFwaEdJaXI4dlVZTEVoLzc0NXZvbTc1TENP?=
 =?utf-8?B?WWlXSFNXUEdvNE1ra2Ric3BGT3Q1UFVlczRWT0R0ZzVIK1liLzlJcHh6a1E2?=
 =?utf-8?B?UUhKK1hGaUZRZFhuMCtNWVZoTXNmcEJ2bW9EOFF3ZFl6NWlZbmYvWDJtSURC?=
 =?utf-8?B?VXRRb3VRMW1QZ1BLVmpoMlZUcG8ybkZjN29JeFhVU2lwNU83ZVBuaVRLbkFU?=
 =?utf-8?B?QVVxMnZPL3F6SHhQdmMxaGVlU3hGelVENzFyc3V4b2hSZ0RoNSt5ajVUUVA1?=
 =?utf-8?B?ViszcUVpOW0xOUxUaEFyKy9WNFRIdXFCbm1OOHFHa0FKMFhRZjJiSkNwQ3VG?=
 =?utf-8?B?MjRXaVRHbnJkdWFUYXMvdkpici9scVZZbFRaeXZJVm8rb3FVK0hlcWx4b2FB?=
 =?utf-8?B?T256RUVlQzBEaGExQU1qMytSSWVsemhqeGxjKzZLdTlwaHJWVUU5cnBRYnE4?=
 =?utf-8?B?WVUwdEZhcjdOSXNoVE1Jb2M0SnJ1bTR0eE5CV1dLcW16RTkrNk91Skw1amxP?=
 =?utf-8?B?Z3FiV0lSeXU2OHlDZnlZeTNlWFkyU3BZdyszR0Z2dGg5RStQZGFETUtBUWxm?=
 =?utf-8?B?eUtodG5sblYyYlRDVURnSDU1dXc0bm1qZHBpL2N2dmhsb2lBSmc5Z1p4Q2t3?=
 =?utf-8?B?RDJzaEtRaTlEeWd1c09HYjRjQ3VNemt1TTMzUzhNVUc4K250bFNFQWplLzNZ?=
 =?utf-8?B?VG1FNWN4OENtZVRQcE0wdG9KZDZIcGdibzN1OUgwU0R3UytJcTRsYkVxTVZk?=
 =?utf-8?B?anNSS0FiMFZ0bE5FN200TUFkeEtsN3c4NWFSZ0FTVUdFSzJ0b2NaVS80djdT?=
 =?utf-8?B?cEpSUTNMdW1xTThOcU9xOGxUZUh3Z0lBUWRyWGptTjNEZUM4ck1vVlFKaEtE?=
 =?utf-8?B?OGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bee0f6e-6968-4d5a-e846-08dbb0b4d1ed
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2023 21:44:46.6574
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yiyd/+wYJB885jak7ilFWpMNTfN2GiVh6gLsXTWPGlGnW8Sc1G3XCf3ZE9t423VduGXds9TmcfaxsxSoFDLDDf1XsDFF+tvdLg/COYnDW3E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8020
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/8/2023 11:17 AM, Sasha Levin wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> [ Upstream commit 633d76ad01ad0321a1ace3e5cc4fed06753d7ac4 ]
> 
> The checks in question were introduced by:
> commit 6b4db2e528f6 ("devlink: Fix use-after-free after a failed reload").
> That fixed an issue of reload with mlxsw driver.
> 
> Back then, that was a valid fix, because there was a limitation
> in place that prevented drivers from registering/unregistering params
> when devlink instance was registered.
> 
> It was possible to do the fix differently by changing drivers to
> register/unregister params in appropriate places making sure the ops
> operate only on memory which is allocated and initialized. But that,
> as a dependency, would require to remove the limitation mentioned above.
> 
> Eventually, this limitation was lifted by:
> commit 1d18bb1a4ddd ("devlink: allow registering parameters after the instance")
> 
> Also, the alternative fix (which also fixed another issue) was done by:
> commit 74cbc3c03c82 ("mlxsw: spectrum_acl_tcam: Move devlink param to TCAM code").
> 
> Therefore, the checks are no longer relevant. Each driver should make
> sure to have the params registered only when the memory the ops
> are working with is allocated and initialized.
> 
> So remove the checks.
> 
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> Reviewed-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: David S. Miller <davem@davemloft.net>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---


I believe my comments on the v5.4 backport apply here as well.

Thanks,
Jake
