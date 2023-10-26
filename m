Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75E5F7D8C19
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 01:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232235AbjJZXPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 19:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjJZXPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 19:15:49 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBDAB1A7;
        Thu, 26 Oct 2023 16:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698362146; x=1729898146;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wNeokqvfaOc9XNwzT2ePS3D7j0/vu7QxoevMumKvL1A=;
  b=ZWyEDRYLFaGEUOR34pEHaxl0wQDj+4HEW6K5Khf/Ww/kAllU1BSenOWj
   Rwl6e9RdZB+W7qa9BtTK2qUuc38FFUR/+vdKh1SqsGbWGXa7SWB57JPST
   K/7XqhtEay7LO4OvbetGBpAdgpaYyeoOFzcFai5s9mPAevFDvGpqDxdbq
   Kb1A26fDUbdFLU89XYb3cVjdqa6pY1diORiV422P4iF7QrNYxcaL/3r6r
   ByBGZ0w4Efrl9r+ACrqKds4k/sERc759Ya1bG49k9OVLcwHS64vMItjM8
   RTIzWQ0pKi0mIUfkmlNMUIgLT2UW01uqsdD8D++8piNBZ72t48nofsq49
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="378037530"
X-IronPort-AV: E=Sophos;i="6.03,254,1694761200"; 
   d="scan'208";a="378037530"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 16:15:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="932881551"
X-IronPort-AV: E=Sophos;i="6.03,254,1694761200"; 
   d="scan'208";a="932881551"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Oct 2023 16:15:45 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 26 Oct 2023 16:15:45 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 26 Oct 2023 16:15:45 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 26 Oct 2023 16:15:45 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 26 Oct 2023 16:15:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P15QxSKELVGPGRza23U6OHgXvpL8MTnVHl5Z16CptE4q80D7/6uAHKomof4uM1kzu05C6nORLonx0OqPLfWWvDSq65l9u0y6Tfj/lj7z6sapKImgrKddH0heAt+tlBZvKDRr9ACKHaypcIyBPnaEWhIq2GN02S6KO+GZwd8whoafRGaPBKS8wDKLSNd2uwgexzMQzxLw6C2Y/b9fQ3C8SdUiPTj1MTRdc9T8KNE62ck7Sjh4kPpTZbRDjUP89GESL7wf/ICvBO5bQkRkgcDUlLh7rX3r/kLjcj15Sb2rz8inF0VD+VTm6+VsXhzZxFtN5cyWTwPcBpy1PP7KkVCJkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ipq2ybwJkf9NFhzU1sueMwrlDO4Q6ilYxT9H2KPpb0Y=;
 b=hDd+2mYh3+O98Ir6574BuNPmTBMBfg/uQbRrV1647ioeh699dBY8JcZzHqveBinj1TznGytmUKxW6a1v6Of/sz1zBhpxqtw21cuJnTGkeGEsSIPZoDYQcuNXWuhxlMRjfWGO12rOidJ4zeiXVEmC8Up8NzIGdSkUlPagMRE9SpsOGCGen7oeJRkfUj1LkAhSSU34yPjxLftyINO83eke6C/SJsykOyylQWAN1zk9XrSIYViuhv+Ph2HCO3hTQPuUZZsa1cOC6Wx7FyFfj1h3RmsFxN44JVPYHE6Xwlre0WS2cPRWGFlVGMZnWU1mLCI4R6q7fvwCxh7ZPZhUZAuKiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by CH3PR11MB8703.namprd11.prod.outlook.com (2603:10b6:610:1cd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.31; Thu, 26 Oct
 2023 23:15:42 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::f216:6b2b:3af0:35c1]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::f216:6b2b:3af0:35c1%4]) with mapi id 15.20.6907.032; Thu, 26 Oct 2023
 23:15:42 +0000
Message-ID: <de5e5529-7365-4ed4-9069-7912ad9bbdfb@intel.com>
Date:   Thu, 26 Oct 2023 16:15:39 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1 1/1] net: stmmac: xgmac: Enable support for
 multiple Flexible PPS outputs
Content-Language: en-US
To:     Furong Xu <0x1207@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Joao Pinto <jpinto@synopsys.com>,
        Simon Horman <horms@kernel.org>
CC:     <netdev@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <xfr@outlook.com>,
        <rock.xu@nio.com>
References: <20231026094856.986796-1-0x1207@gmail.com>
From:   Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20231026094856.986796-1-0x1207@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0300.namprd04.prod.outlook.com
 (2603:10b6:303:89::35) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|CH3PR11MB8703:EE_
X-MS-Office365-Filtering-Correlation-Id: c478befb-ebdf-4ef0-9b38-08dbd67979de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S0jQ9fWv0CKS7qSN9bhoQaRBto/bC5VF6/Sksjgrq8wmbTa1Z47BdC8WP5yeoMMTlFgUq8+WbWcpVHOGcvj5IEnqo1T36wMJe7Me6NPNiPmNMCA1J171Kks6+qI4iO74VkEQxt3MPi+ysQctq63Y678BYoIh06PQNuk/Mkj4fjiQ6fzgBKZM8h6DaFdjFTGMZyt7DvSX7oqD8AqFj8zMJV4+N3duIIrY9uBsbxTyYY/1tgEUmB/7Icub+gd/80HntOBPLI4YatHzxriMw6lPpMUK18sf8PrQR5xpsDwt5rPyEAbf3FGBjA/4uMeHxzS32kvQhIoKOR0kuZ4pedxTw5mJhZT5LZT18Rm/klJ3b+N46oFlfYFtzbtqUoWh+YLWSx7I9PwMfzJ6J8uUBdqSQ2NFycG4BBJ2PWtlw6nXflkUmG48b5zhd6d2WzZbnIRoXQetxhd4akg0kJjrD+eaQt6LaIWitnM9m14kaO1KCclNssk+zCiePUC96od9eKqzAGFs86idh1+A3/O+sC6QA8WfUzDaRnnTBX90bJr98pWV3pPZO66rp/r4JxBQOy8Y0MLLGrujg+M6k4cPcSqgNudyaUiSUAIIcGfiO80eTDtfTyaijTh02jLSaXVc17trAz+6orQyrODzYPjeLi2Nm6i+NKDT7l4gNXlmYDR8Kws=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(136003)(376002)(396003)(366004)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(110136005)(6486002)(41300700001)(8936002)(8676002)(4326008)(478600001)(66556008)(2906002)(7416002)(31686004)(921008)(86362001)(5660300002)(316002)(66476007)(36756003)(66946007)(31696002)(26005)(53546011)(6512007)(6506007)(2616005)(6666004)(38100700002)(82960400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a0ZTbHFmSE1ETlpYdm5qVlJ0NTRNbXpsbmJVYThYNXU1VW1NRVQwa1FpS2kz?=
 =?utf-8?B?VXBvaWlHUjA3azNOUGlhWUErZlIxVnhuNzkzQURFZTB2aUhleW5BWHNHQ29W?=
 =?utf-8?B?bDBoaVY4KzA1ZUZDTFFIS3F1TE85ekpHZDZFZllhc2o3UHEvdVRsQllkTUll?=
 =?utf-8?B?OEFMQmszZ0lZRWRNRWE0b3lpWFVINW5Db0NvTzdpZTA4WjM3SnVsMGlvYmdE?=
 =?utf-8?B?KzRoektoRXJEYktQeHZZeUs4aE1aeTFoTzVHbnYyTDBBMmFXOXk1Q1pIbnV2?=
 =?utf-8?B?K0N3YWVvRlJPY0pvaWtRQ3ZsTVJMRkpueThYSW40VW8zVjNmWlhzNk1SeC9y?=
 =?utf-8?B?eXVmanZENzFKeFZrd3d3MzRDeTRCcUc5ZWpQRitYNWpyRG5sUnQ3a1NEc2E3?=
 =?utf-8?B?V2N1S2J6SFZrU1Jkb2tBL1FLNlpSRGk5N1ptSHAyVVBOZDJWWjY4WXJwVWlG?=
 =?utf-8?B?QXFwL1pzQWxROXpaUUVIWk5aSU1qRTRLeTRrSGFyWXNGUmpMcTFubi8vZHpy?=
 =?utf-8?B?ZElHL09PZmk1SEZycE5aNUpBaFBydVdMbVQ0bndnWE9Rbmc4MG80SEpZWFBT?=
 =?utf-8?B?a1ovTWJma1NGbVR2d0NEMlZHZUZ2TVZ2dzV1cTl3aVlucDdPVHV2Nk5DR2F1?=
 =?utf-8?B?NGt6cnlkdzNZOHhXU3ByMEFza1FYbGFtckJSRlIwL1R5cloxRW40dXpIZ0pV?=
 =?utf-8?B?S21wQkQreXhEcVc1bTFQOUQvYU9RQ1BPZkpqYllVYkNaY3EyMmpWdSs4SCs1?=
 =?utf-8?B?dW42K2FPbm9DZlAvZlc1RHF4V2tvQjlqWFVldWdydFpiZ09KRWxtSWladDZX?=
 =?utf-8?B?SXlSdXQ0aXJjUUZ4OS9YaE5zazBwTFE3WDAwNlU4UjBVazJBTnRVVzRpb2Jv?=
 =?utf-8?B?YjBjMHhSbm9vTDRBMlkrR0duNER1Z1F2MUFqMUtUSnhnTEJyMjQ1YXlLT0FB?=
 =?utf-8?B?RFR2K3l1ZWhsaUczSzdVTzRxQS84SnMzd1ZVVjMyQ3ErbXJNdzNyVzBvVDJI?=
 =?utf-8?B?S3F2eXNtbEQyb29ZWkdueVhINkxQeGFTeGV1c2h2YkVJVXN3alZmdnVHYzF2?=
 =?utf-8?B?TzAvVlVjejRxMFF5U2kxM1NpRWhVb05NaStzVWRya3A3L1dyYXdyeWVtcHpR?=
 =?utf-8?B?SnZoM0p6MlZoM2VwU3F0MlNKcFB5SDVqcjdnUGV2WTBPZktnMEJ4OU0zWjZX?=
 =?utf-8?B?MzEvNTJjZWhEdTRva0FmZFRtQTdVWUZKbFo5aEhhOU1qUkhNOWlhd2xrNzRC?=
 =?utf-8?B?VENVeU50alkzMFI5Z3l2cU03QW1MMCt5KzRLYWd6c0VnTDIxaVN0OTNOMDA2?=
 =?utf-8?B?Z2xWS0pnZEowRmhPdTNRd2R1REJJVTBpWmRBK2lDZ0VVenhBS0xQVW02V2ZP?=
 =?utf-8?B?MCtSRm4zbmRUK2N0TnEyU1BJSDZMT3RJeG9QYlZhR1N2TUs0VXdNdnlmTkFZ?=
 =?utf-8?B?UUNOL3pIZkpJMXBlazdKZVZwMU9ZYkk2Ui95WW9aZk5jYm1GL09UY3E2V2dU?=
 =?utf-8?B?VTl0RFJkeGFqeCtTUnpkVkorQThtbWRDQitmZUxRR2RjMVg0a0FlQlkwajda?=
 =?utf-8?B?MFNrNFg0WkhLb21qemk4UjFFTkVmYTRMWVhUQzZHRmRqd3llZ1ZobUVrMmV1?=
 =?utf-8?B?NThhcGZxaHQvSDNVU2tLWFYwS21kQjZYZnB4OEtBcHNTdUgyQUpZcEo2K1l4?=
 =?utf-8?B?dVUrT1JnVllqWStlKzlZbk1vOXdWVnpKblhZVm1STG8ydFpQSGpuTElwN29v?=
 =?utf-8?B?S3FMTW5na2k5VWhBTi9iUmZ3QXpES0NZMTZSS05LN1VBUW8wM1pTb0FKeXh2?=
 =?utf-8?B?YkhJTDdDdE40SmszRm56T01IUXVVQVVCTEd6VTRwTlcxYSswL0p4TDlVcEVu?=
 =?utf-8?B?UTZ6ZXZwV1pkckdHcWlPdzNMRzQyY0M5ZWdvL3NmcUgrazFlbUZKdmE3cmtr?=
 =?utf-8?B?R3dHWCsvbXY2TkNmbzlURWdQLzhiZ3RIWFBqTjZ0VVhaQVhNdDJXQlZxU2xP?=
 =?utf-8?B?b0s1cTBJZStpOG9JQ01Uclc1MU1rdmh5MzNRRjYxSDFtRjNrWEtWa3hrTXpG?=
 =?utf-8?B?YlNwN3ZVWlBXRXZsT1pYamc5ZHNMYzVqdGRTcld3SFFPS1huakVHWVFZSno1?=
 =?utf-8?B?eW1Ua1RHVDB1eGprRjR4NTZHZXZtS0VwZjdhR295ajY1U0k1RUtPazhCa25m?=
 =?utf-8?B?Z0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c478befb-ebdf-4ef0-9b38-08dbd67979de
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 23:15:42.8127
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zqiH/7Fe3wKIJDsH9xXn+hC4dDjAywKTi63vf6niLBxUgLkYj99nImnG8fsrlxFgndBAPp7HKqn/DLxzUshiwvEnGCdl1N+jtgofcLSwb3c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8703
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/26/2023 2:48 AM, Furong Xu wrote:
> From XGMAC Core 3.20 and later, each Flexible PPS has individual PPSEN bit
> to select Fixed mode or Flexible mode. The PPSEN must be set, or it stays
> in Fixed PPS mode by default.
> XGMAC Core prior 3.20, corresponding PPSEN bits are read-only reserved,
> always set PPSEN do not make things worse ;)
> 

Previous revisions the corresponding bits are always set, and don't get
modified by writes, so setting these bits for all hardware has no ill
effect.

In the previous code we always set BIT(4), but nwo we set BIT(4+x). This
won't affect XGMAC prior to 3.20, but corrects a mistake when
programming the newer XGMAC. Ok.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

The original code was added in 95eaf3cd0a90 ("net: stmmac: dwxgmac: Add
Flexible PPS support"), which landed in v5.4

It looks like XGMAC Core 3.20 support was not added until possibly
commit 669a55560e4b ("net: stmmac: Check more MAC HW features for XGMAC
Core 3.20") which appears to be new enough that its not in any official
Linux release, though it looks like it was already in net.

Perhaps this should be tagged Fixes: and sent through net, hopefully to
try and hit 6.6 or at least a stable release shortly after?

Thanks,
Jake
