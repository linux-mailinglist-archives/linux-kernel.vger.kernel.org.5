Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 220E87CC9C1
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 19:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343694AbjJQRVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 13:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233940AbjJQRVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 13:21:41 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29923BA;
        Tue, 17 Oct 2023 10:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697563299; x=1729099299;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JtjEkEiXT/GKZKa2jjBbVMgbhwzBv07xwte1vfkLuLs=;
  b=jNTXxglccxAOFsUnNrNLCXEbhMB2FdbtiJo3j/MmxTt2/6mpdvHGso1x
   Mzy3A28wxKw+EYhKxhF6PWYQO2JeOKVWrFb5P09x7x3+NEsIGeGKwb48G
   2BOa0z/7nhVu1sUHpxsLln1MwNheA8BZ5WsDXJXaw1fJHJvhAVTF1dE7R
   Y8RJAzlpbB8qPtZ4PCxIvhgWcuquFLcE54IgDK2S1bFuI5AdpBzAC46di
   Fg6RQd5UOe2wh1usYW0rKt+lwd7l7P1Ns5YnInxGM1Npnfg7JFEFeV4G/
   hoVtHKRehvJT0MGFIX5oCG4cyLimVGGD2+iUo0NCgp8XvDGJ3jIyozSb9
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="388702985"
X-IronPort-AV: E=Sophos;i="6.03,232,1694761200"; 
   d="scan'208";a="388702985"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 10:21:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="785552963"
X-IronPort-AV: E=Sophos;i="6.03,232,1694761200"; 
   d="scan'208";a="785552963"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Oct 2023 10:21:38 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 17 Oct 2023 10:21:38 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 17 Oct 2023 10:21:38 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 17 Oct 2023 10:21:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k831GNEZHHc+rmT33s+MlY4CmmMhh03tLL4T9qdBEr6ArUHuYbdSEvQXfCI0FOlcHpYY+5QQ8IbKXgigQkFzK1E8rlOjZPhtOfxbIxFJFsOykw01moB2SVhnormMrI17Vzat1E/KoZJUb+9RJvSvfTNwvbpXZC6uZFxF6uBaZDitMmT9N2pwVXUP1sAoWFrVTfU059yLihRn2M6pISGmfdhHyR6MyAcxHgCUS9vA5vROGwc7CD+qfG3RqgycFeMLfeIgXyIDqfmfxLBS/OoN7J1413syizGgHlXpauUJ6az21xDSdJRZMx3yRK1Kmv6qx4GbscSP6X4GWsAdexrtVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VTVdMX3hXCGjDTSeljLv8/PBSpEg5yqZHHL45QEWTA4=;
 b=RQsY3fNO/7z7ieuLPYiydHhRVMHWicdaGh1pzuNBccWEcRVZirmkzr02SzpTnQIZCtYiKBz4aQ25xiS+axfy3dwoFlas88QKfDCfe/4rLfgkOppTo7ymRm0KSv0FSbOGmk1tQxiY4qIxqBSMSe922bXR9wG5CdLqzQTmIuD/zsuTrUyLxxSjkR4n5YXTJxTzTuYGJSF/QejJoZz4rsZ9XD4PpZaZtiR32RuP4WUOx7E6nAKD+IVFwi4su4xi8LUKEP9tOjcr2ckeDnpM4eIhvE6NzS6W3SiI2sUmpVIp9Q9eM6hGdsBPaR+IHwPLqVFCP1T42GPgBX2SQgnxyrJudQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SA3PR11MB7654.namprd11.prod.outlook.com (2603:10b6:806:305::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21; Tue, 17 Oct
 2023 17:21:34 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::34a7:52c3:3b8b:75f4]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::34a7:52c3:3b8b:75f4%4]) with mapi id 15.20.6907.021; Tue, 17 Oct 2023
 17:21:34 +0000
Message-ID: <94e5dce2-5db8-4c3d-b185-eccfc0262745@intel.com>
Date:   Tue, 17 Oct 2023 10:21:31 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 4/5] i40e: Refactor and rename
 i40e_read_pba_string()
Content-Language: en-US
To:     Ivan Vecera <ivecera@redhat.com>, <netdev@vger.kernel.org>
CC:     Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        "Eric Dumazet" <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        <linux-kernel@vger.kernel.org>, <intel-wired-lan@lists.osuosl.org>
References: <20231013170755.2367410-1-ivecera@redhat.com>
 <20231013170755.2367410-5-ivecera@redhat.com>
From:   Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20231013170755.2367410-5-ivecera@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P220CA0009.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::14) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SA3PR11MB7654:EE_
X-MS-Office365-Filtering-Correlation-Id: 553c3d4c-fe1a-4a7c-d3b2-08dbcf3582f5
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Lx1kuCLHd95DhuSy/7+SlEsFddPjAcQOnmdD1eOCaMefqWnjNM7LQq5r652FTJ48BYiHX7kOENI5umg+qNDKKdE+LI+Lbawv4Qgzc6Dmd22b6s+L0NT//yl03uOuV8V3Kt5CelsFegFL4CZ3nKfj9oAiAb0whItSzBBkZmWrKLR23hTbu6Adpdp97dbjl/m84SSNU+2YxXu4/C+2K1777uE9FSIGWUbKnFJRQ3P2226sbz1GVJTRRAW6ZzxA8sPCBWrNd72RVH3tsrkmCac2lxH8Ry2wFlnBICucT3WB0Z/yxELxDxoSLFTxU+LLA2shRjqXr39wyqIMZO0YhFL9D1aew+OIpvFPgpEVd5nijRM9h26yzUIAbPI7WpAYpxE8ZOfm6WtuH0KFdIAJK7Hw+fRliVP/Bx0LihtQmrWa+j3XhKHxBOF5DCXU2So1gP9N6VmEX4nEcMx1Y3o+3ROU7bHhJfFusVcz6RFKneB13+/EMDf+qZqoaVWpzRvVzUdQa8jj29IvcO2fHTEnEWCdQ6QoayE/9P2XqLVt5cBsFiYIH+FzsMh0M6i07WzME3jEyRu9lnU7KupiLN1gEAaaFP5ZLkKWI5+L73+IWaieM5Sc7+oWcL/flde9/ho+PgKjA/+SfZQDReqNj9mKvYpNCA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(39860400002)(396003)(346002)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(36756003)(31686004)(66476007)(66556008)(66946007)(316002)(54906003)(31696002)(86362001)(38100700002)(82960400001)(53546011)(83380400001)(6512007)(26005)(2616005)(8936002)(6506007)(6666004)(2906002)(6486002)(478600001)(5660300002)(41300700001)(8676002)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cXprSmJoblVvSDhpSzd2cVBXR0lMbG5NZ0dHaEFHem0vR1lxY2hlQmFpaG8v?=
 =?utf-8?B?dTlMc3Z0SGJtOTNrMU1WbDJ1eXpFWEJZSUxtTlYzQ0lJVklRWWo3OHA4SjhJ?=
 =?utf-8?B?WUhFZ0MxYmg3Y0pqV0F3RDJSTFNsUE9vTWdpQ2Z6MXRLd25rTUFtdWxUeG44?=
 =?utf-8?B?cXdTRnA5Yk05VXZqR0ZNK0JqUGxiZDU2NGpyT05TcS9sQVVjamtDQ2FWRWF0?=
 =?utf-8?B?OFVpb0pYL0tWTGhyZXR1SlB6RzFhMGxCQlBpLzVEZGZrZE1TaHYvdmtKWGhh?=
 =?utf-8?B?SWxUb0s4NmRadkZyOHdUSTIwWjREZFlYUU5ORXVPcjR4L3ErbnBVTmk3MEds?=
 =?utf-8?B?dzF5NmdUSXJSVDY3SnlRMXJTZ3c4SjlXY09yT3FBVGFFdzNsd1F1RE1pdGJC?=
 =?utf-8?B?Q2F2ZEhXTjRyYjFycmhCR0VVb2paV0txS2hTUWJzRVF3ZlozRmpvK0Zxc0lm?=
 =?utf-8?B?Slo4VThHRGZjTzBuRVlTTURYTEcrRkRKMTUwK3paeVdBajBZa2F3MGJxYXl2?=
 =?utf-8?B?bUltZzRUTTdVVy94cnNBa3g4TFpydXM3akVsaGtEbjNRT2JOMm1jTU5tMk5N?=
 =?utf-8?B?aFZzbi9hcHZqMDRoNHpRaUhiUVFscVFPQzJKWERGd3NQQTRwcWFkakQ0NXlI?=
 =?utf-8?B?Q0hVZVNGQkEwQjFyOEZDaTdjYTE0YitaRnBtYXBzcTlqbVRxd2RmQ2U3bDk5?=
 =?utf-8?B?cDl0alMvYTYyTDNjMUxyNzZLYXRxWmVUSVZpZ1ZDRExIZjlpNThIY0p4UWRG?=
 =?utf-8?B?d0dSL09yYkV2K1llelg1R1FXTzhaME9hcm1ORFVxNUd1OWFMMTloNWN2dGQx?=
 =?utf-8?B?MmxBVTVYOFNiRFBQYU5oZ2xuYU1kL05obDIzZ2VEcks1UzdLZWsxaTZmSHVM?=
 =?utf-8?B?aWFaWm1PdlkxeEFMQUlMVUdhNzFzcEo2M29LR25DanlXbnJkTWdwSlFNMk5p?=
 =?utf-8?B?YUlVS3BoTGNXYkJnTU10MU80RmVLZXk2VUx0ZmN3c0k5NXZ2cXYvZDFDL3Ev?=
 =?utf-8?B?UW12MkhKREJwQmZ5YStvYkZMTkF5NGlZZWVHMU5yRjg2S0Y5RnVwSmJKVmto?=
 =?utf-8?B?d3RBYzFxOWQvT2xuZG9GTTRHN1pSQ2lpWnI1bkkxTEdHN08xdlBQSFhGWTNV?=
 =?utf-8?B?UUlEK2U2SFFianpLVCs1Q3l5YnYzUFI2MmFvRWpkK0FiNWxZaGQxb3VmR21G?=
 =?utf-8?B?QklUc2N2cnM0STZKR2dJNUlWRXdERjB2K3BmVHI0aW1PVzhkWjcvZUFTS2xI?=
 =?utf-8?B?d3p3Z0l3UUI5TWcyaVp5aW5HZEFoc0IxTWJPRWlOUGdVTzNEYWxTWmJNSzlJ?=
 =?utf-8?B?ZnVQbWV1VmdjWHp2amZ3TU4rdXc4akQ3WTQ4LzR6NWFNNm93MnJ3dTR6SGsz?=
 =?utf-8?B?cnExdndKZjBxMG01eDlNRWxPTHcxNFk4RE5QMUlVVEgwd1JFWDFuOUJUckk2?=
 =?utf-8?B?dnlQeHBscFdaaCtBaTY1NS9UR3ZtVGdzUHgrMDJZSUVyYm1ZQi9ySi9SM2ZN?=
 =?utf-8?B?bE5Kd1dEZkFLaFlVR09pTFFHR0M1NDVDeW5VZjN2M3FGQXpkMUFJcDQ0cDNQ?=
 =?utf-8?B?d0YrczRMWFkvdzZKZ0ZWWmtqVlRIQ0ZUNE9NU3cwWU8wckduVkxhSWNsNGFw?=
 =?utf-8?B?TWJrekRVNm5POHR6MXQwTlg0em9EeXpNQzlhSkZsNUY2UnJ1OHEwT2Z3MHFL?=
 =?utf-8?B?ajFoQWpzTytoMG85MEdyM3l4ck9iSXU5U0Z1UzdlWm0zeVdPbkxpNHp3VHZB?=
 =?utf-8?B?VGJSdFpUVFlPWDkrZEhMaHFBUDRaTVF5THg5Q3JTRmZjT2p2S2xuNjV6OU00?=
 =?utf-8?B?dThmZTlOanVwbnNkRWZCN3lxUXRPdXNQNzhJV1ExWE1pL2dKN1NlWWNmU0R6?=
 =?utf-8?B?SGdQS3VqYjB2OGtwWC9Vc2ZvUDk0Vm9tVXJ6b3ZvUDdDeTJCVk9jQzhiNS9L?=
 =?utf-8?B?RUtyV1d4bVhYZHRxSnd4WVBWQjZYbkdDbEI2a2M1MVRTalJ2Z295UUVUeU1Z?=
 =?utf-8?B?UDhXQ1k1ZEV4OTcxMlkzQUxxby92RHlPT2xxamdhaExnSlNuL1dWajZDVWxG?=
 =?utf-8?B?UzVZcGhRc3V1amt1SlFNZkxRV2xvOFpmUUVMRnc0MDV0UEd2eWY0cjZNSGdZ?=
 =?utf-8?B?MWVsNHdiaFc4QnVaQ1ZiV3Jsb244cmZ2TjZNcU54d0VoYUVZVzJlMHV1b3dy?=
 =?utf-8?B?Z1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 553c3d4c-fe1a-4a7c-d3b2-08dbcf3582f5
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 17:21:34.1250
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uRAoFpW65X5chBkXVGbt7v6Eh5KTZMegoJpkODqd56Uqcj4Qf6iFKW6rG39EsndXAsp/dYkXbJ7hXEZL+26RtIIxC8wEJFFx8FxGxigEGBU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7654
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/13/2023 10:07 AM, Ivan Vecera wrote:
> Function i40e_read_pba_string() is currently unused but will be used
> by subsequent patch to provide board ID via devlink device info.
> 
> The function reads PBA block from NVM so it cannot be called during
> adapter reset and as we would like to provide PBA ID via devlink
> info it is better to read the PBA ID during i40e_probe() and cache
> it in i40e_hw structure to avoid a waiting for potential adapter
> reset in devlink info callback.
> 
> So...
> - Remove pba_num and pba_num_size arguments from the function,
>   allocate resource managed buffer to store PBA ID string and
>   save resulting pointer to i40e_hw->pba_id field
> - Make the function void as the PBA ID can be missing and in this
>   case (or in case of NVM reading failure) the i40e_hw->pba_id
>   will be NULL
> - Rename the function to i40e_get_pba_string() to align with other
>   functions like i40e_get_oem_version() i40e_get_port_mac_addr()...
> - Call this function on init during i40e_probe()
> 

And the PBA value shouldn't be changing even with a new NVM image
flashed to the device, so its not something that is likely to have
updated at run time, thus saving during probe is sufficient.

Makes sense.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_common.c | 58 +++++++++++--------
>  drivers/net/ethernet/intel/i40e/i40e_main.c   |  1 +
>  .../net/ethernet/intel/i40e/i40e_prototype.h  |  3 +-
>  drivers/net/ethernet/intel/i40e/i40e_type.h   |  3 +
>  4 files changed, 39 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_common.c b/drivers/net/ethernet/intel/i40e/i40e_common.c
> index 6d1042ca0317..04db9cdc7d94 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_common.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_common.c
> @@ -821,62 +821,72 @@ void i40e_pre_tx_queue_cfg(struct i40e_hw *hw, u32 queue, bool enable)
>  }
>  
>  /**
> - *  i40e_read_pba_string - Reads part number string from EEPROM
> + *  i40e_get_pba_string - Reads part number string from EEPROM
>   *  @hw: pointer to hardware structure
> - *  @pba_num: stores the part number string from the EEPROM
> - *  @pba_num_size: part number string buffer length
>   *
> - *  Reads the part number string from the EEPROM.
> + *  Reads the part number string from the EEPROM and stores it
> + *  into newly allocated buffer and saves resulting pointer
> + *  to i40e_hw->pba_id field.
>   **/
> -int i40e_read_pba_string(struct i40e_hw *hw, u8 *pba_num,
> -			 u32 pba_num_size)
> +void i40e_get_pba_string(struct i40e_hw *hw)
>  {
> +#define I40E_NVM_PBA_FLAGS_BLK_PRESENT	0xFAFA
>  	u16 pba_word = 0;
>  	u16 pba_size = 0;
>  	u16 pba_ptr = 0;
> -	int status = 0;
> -	u16 i = 0;
> +	int status;
> +	char *ptr;
> +	u16 i;
>  
>  	status = i40e_read_nvm_word(hw, I40E_SR_PBA_FLAGS, &pba_word);
> -	if (status || (pba_word != 0xFAFA)) {
> -		hw_dbg(hw, "Failed to read PBA flags or flag is invalid.\n");
> -		return status;
> +	if (status) {
> +		hw_dbg(hw, "Failed to read PBA flags.\n");
> +		return;
> +	}
> +	if (pba_word != I40E_NVM_PBA_FLAGS_BLK_PRESENT) {
> +		hw_dbg(hw, "PBA block is not present.\n");
> +		return;
>  	}
>  
>  	status = i40e_read_nvm_word(hw, I40E_SR_PBA_BLOCK_PTR, &pba_ptr);
>  	if (status) {
>  		hw_dbg(hw, "Failed to read PBA Block pointer.\n");
> -		return status;
> +		return;
>  	}
>  
>  	status = i40e_read_nvm_word(hw, pba_ptr, &pba_size);
>  	if (status) {
>  		hw_dbg(hw, "Failed to read PBA Block size.\n");
> -		return status;
> +		return;
>  	}
>  
>  	/* Subtract one to get PBA word count (PBA Size word is included in
> -	 * total size)
> +	 * total size) and advance pointer to first PBA word.
>  	 */
>  	pba_size--;
> -	if (pba_num_size < (((u32)pba_size * 2) + 1)) {
> -		hw_dbg(hw, "Buffer too small for PBA data.\n");
> -		return -EINVAL;
> +	pba_ptr++;
> +	if (!pba_size) {
> +		hw_dbg(hw, "PBA ID is empty.\n");
> +		return;
>  	}
>  
> +	ptr = devm_kzalloc(i40e_hw_to_dev(hw), pba_size * 2 + 1, GFP_KERNEL);
> +	if (!ptr)
> +		return;
> +	hw->pba_id = ptr;
> +
>  	for (i = 0; i < pba_size; i++) {
> -		status = i40e_read_nvm_word(hw, (pba_ptr + 1) + i, &pba_word);
> +		status = i40e_read_nvm_word(hw, pba_ptr + i, &pba_word);
>  		if (status) {
>  			hw_dbg(hw, "Failed to read PBA Block word %d.\n", i);
> -			return status;
> +			devm_kfree(i40e_hw_to_dev(hw), hw->pba_id);
> +			hw->pba_id = NULL;
> +			return;
>  		}
>  
> -		pba_num[(i * 2)] = (pba_word >> 8) & 0xFF;
> -		pba_num[(i * 2) + 1] = pba_word & 0xFF;
> +		*ptr++ = (pba_word >> 8) & 0xFF;
> +		*ptr++ = pba_word & 0xFF;
>  	}
> -	pba_num[(pba_size * 2)] = '\0';
> -
> -	return status;
>  }
>  
>  /**
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
> index ba8fb0556216..3157d14d9b12 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> @@ -15846,6 +15846,7 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  		goto err_pf_reset;
>  	}
>  	i40e_get_oem_version(hw);
> +	i40e_get_pba_string(hw);
>  
>  	/* provide nvm, fw, api versions, vendor:device id, subsys vendor:device id */
>  	i40e_nvm_version_str(hw, nvm_ver, sizeof(nvm_ver));
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_prototype.h b/drivers/net/ethernet/intel/i40e/i40e_prototype.h
> index 46b9a05ceb91..001162042050 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_prototype.h
> +++ b/drivers/net/ethernet/intel/i40e/i40e_prototype.h
> @@ -341,8 +341,7 @@ i40e_aq_configure_partition_bw(struct i40e_hw *hw,
>  			       struct i40e_aqc_configure_partition_bw_data *bw_data,
>  			       struct i40e_asq_cmd_details *cmd_details);
>  int i40e_get_port_mac_addr(struct i40e_hw *hw, u8 *mac_addr);
> -int i40e_read_pba_string(struct i40e_hw *hw, u8 *pba_num,
> -			 u32 pba_num_size);
> +void i40e_get_pba_string(struct i40e_hw *hw);
>  void i40e_pre_tx_queue_cfg(struct i40e_hw *hw, u32 queue, bool enable);
>  /* prototype for functions used for NVM access */
>  int i40e_init_nvm(struct i40e_hw *hw);
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_type.h b/drivers/net/ethernet/intel/i40e/i40e_type.h
> index dc7cd16ad8fb..aff6dc6afbe2 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_type.h
> +++ b/drivers/net/ethernet/intel/i40e/i40e_type.h
> @@ -493,6 +493,9 @@ struct i40e_hw {
>  	struct i40e_nvm_info nvm;
>  	struct i40e_fc_info fc;
>  
> +	/* PBA ID */
> +	const char *pba_id;
> +
>  	/* pci info */
>  	u16 device_id;
>  	u16 vendor_id;
