Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D878F7D7F9F
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 11:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344465AbjJZJeE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 05:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjJZJeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 05:34:03 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16D36184;
        Thu, 26 Oct 2023 02:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698312841; x=1729848841;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QhtoH3FZcu/shlpuqqT47FHTSFhS+vJ8y2+dxVZoTAo=;
  b=Q0TMwuw8PqQBHyYi99Z4LECSqdvMrH5aHG79NoIV+o4d+RSe5nNg4Vj1
   cB8lHX5c2FHwbgXwtQZQQzAOQM73tVsIzPmMlIKLF1JGADEClIdnaZJo4
   Yuoi/K3G+jFoCSjltWswInmYh1RX8aEo82U4XxmIkzLNukQiRkBA4j0aU
   ERsBGEHHXo8Ygz9aFcYjU0h89KrwqvYQphJTkgKxoxKjO5D52yVCtx5Ya
   6s10AUPv+OhxpKRE+SRfuDTNX3058s7JxO7MENB00G0Z4t74Hy4/HcK4U
   HDmv4YihHI1yOlTjxUOZgB1jXLuJWskZ/6riCpNAIxvEnxd23FefPPxXJ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="367711579"
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="367711579"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 02:34:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="902832719"
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="902832719"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Oct 2023 02:31:35 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 26 Oct 2023 02:33:59 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 26 Oct 2023 02:33:59 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 26 Oct 2023 02:33:59 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 26 Oct 2023 02:33:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lpkRLpPHPQjnAIbjHv9215r+N45w0qvIQQ1GHhxNqn/U9+urfmMGSbQ2eoYlr0e+ohviZLkuKaw9/2b9jjJflCbL1NnxAqEQ++yHZEzqncrvjTWvNlzi/kNSJadodf2BWPN9W4Mikf5ijC0tQ77v2pGmXsbNzv6Cyq3nsc3uWbsLjSQc+AJuFRnx23W6tU330x1mIp+8zlBXLlYZd87CFPIh53gVQF9Op3FKHCq+S4O10WSkKrWjRYlm5BY0bL+00iQHD9CeEC2vUrKfHgDCVJnx5bjFhUpjboBvmWl46JPJyDeWLkJuujkOj0tDgzFreVu4dQ4hQGeIc61NFe+3aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4o+yhZa05lIfu1Lvt4i3UzbJ2/WYvQzQJUo/GkTVisU=;
 b=clrITh1AxfUO1C0mpAww7EJG8Zmbgu+YQUNnlnl5Xal3ziDEotNjzhf6UErSKiBtZvYCOJWoRGaFVnjoc4V7G/LdaT4XqWds/7oS8VHsMtjy3VaBaXv+W/ZKPk57l4ojb60aSizl//gPkmGXeWfqGxtwAgr7IRneV8VUqTp35ZN4FzgSS64uA70zG0oPb6ZByAnoWV0f682fIRogrS6DUv9Ju5Ax+RjsMGpOwpfICAqwZWAWVubCt4k8abSQUAKXnqkVrG6RfMduXoqrXciFDZ0sV+WBSgnpgtneM53V/ZHngp5/s09MsHdskekS1SDjaGvzpVfLWKRH0FEop6/vIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3672.namprd11.prod.outlook.com (2603:10b6:a03:fa::30)
 by BY1PR11MB8077.namprd11.prod.outlook.com (2603:10b6:a03:527::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Thu, 26 Oct
 2023 09:33:57 +0000
Received: from BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::7666:c666:e6b6:6e48]) by BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::7666:c666:e6b6:6e48%4]) with mapi id 15.20.6907.021; Thu, 26 Oct 2023
 09:33:56 +0000
Message-ID: <1c87106e-c889-06d6-dab9-67f96f5ba044@intel.com>
Date:   Thu, 26 Oct 2023 11:33:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH iwl-next] i40e: Delete unused and useless i40e_pf fields
Content-Language: en-US
To:     Ivan Vecera <ivecera@redhat.com>, <netdev@vger.kernel.org>
CC:     Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Eric Dumazet" <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        <intel-wired-lan@lists.osuosl.org>, <linux-kernel@vger.kernel.org>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Wojciech Drewek <wojciech.drewek@intel.com>
References: <20231025145937.1873040-1-ivecera@redhat.com>
From:   Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <20231025145937.1873040-1-ivecera@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0211.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e4::7) To BYAPR11MB3672.namprd11.prod.outlook.com
 (2603:10b6:a03:fa::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3672:EE_|BY1PR11MB8077:EE_
X-MS-Office365-Filtering-Correlation-Id: be797f07-415d-4662-029b-08dbd606acf1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9OyBJ62OVNNJhbxMehnOfs4ByPJQQ7BNi8w4HKDGsN46zphAcQ8XW5TiBLQlymcWNeIJLniOoMVQ99YrJE9t6GcwvN4gWD9B2Ba1n05IU5fFaSVidwklAPn3Q6YEx6IpSJmCpifxcLou2hL6eswUFngjOnd23MpHd2GW+yByFGE6RWFUkBvPldf2rxsX85EGHVVCpeMwh9BBkx3K7RxUWTdNX15JKQMrGws8U50kcc2wHShAJu0rvsrDN3MMONMHqsV3d8ckhQ/PuRRQy1R3PJmiq2iheUm0ak9OkjBq7oeNSoo3f2bNc7Vbg8mVTfQttur1oowLM4wIn12YydXOkss8095zVANMF4cYfw3u/xgEVrH2IPGuQmj2I+dy0R7qY/aIVOg8chuouV0IBdeWkO9UVEfgPIZpLiQ2qXWznsqUv7s0Ww00djekIpqAlshjq/rRS8vjOkap+Xo43xllmMWVATVS1jmrCGxGONLOyhWcRrwogDnrChxwASsUbrud2n35QUnYJMUd6lHkfuQ1BHUxk42njNC/NZQdY9BC/zfeW1dHNoiF6TmQZ8zn60ux3bOF8M/Y3rj9BbA+V9LssUAMXOg2QHkZfuMsM9bhoJ73kCc3JeWpBEV8SylgTti3l40IF59X8UsRUHY3ydiyBA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3672.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(366004)(376002)(346002)(396003)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(36756003)(107886003)(6666004)(6512007)(6506007)(53546011)(26005)(2616005)(66556008)(478600001)(66946007)(41300700001)(316002)(82960400001)(6486002)(38100700002)(66476007)(54906003)(83380400001)(2906002)(31686004)(31696002)(86362001)(8936002)(4326008)(8676002)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MTdqRXR4cFJCMHRONG4wNFI3b3RVUFpVMmxhdkJLMFFnTkpCbFd0aWVlUy8y?=
 =?utf-8?B?M3VzU0lJRlhoY1o0V3hETVF1QVhMbUJEU2o1Q1o3cmVSQ3prb0FKUDhJZW1h?=
 =?utf-8?B?Qms1clk4a1RPVFRXNGxTZlM1UHZ1d2c3VW5YdDJHSnFEemEyUlc0dEp5MnZN?=
 =?utf-8?B?ZGVoOWRnaEgvR2JLQ2cyUGdueEJKWTI0bUMzOEhMMEh2bG44dnh0Q3NBVkdr?=
 =?utf-8?B?b3dGSFdBdlZ2NENpUnNXOHMzdmZVL1dvMFFrQWhmNnd2NUxEU2wySW1DLytW?=
 =?utf-8?B?RW9BS1lqT2xmaWgzV3NWVWZzbGpNbVlkMTFCcW5OTUt2eHZzM294NGNWamJW?=
 =?utf-8?B?ZkNPNU44TmIxcU9tait5RjJ3ZlVQbEFTYmI0NjVucU93cFp5cStEdnRPS1JR?=
 =?utf-8?B?S2dXUGRSRkl1bmkrenFPclhpcUxUSHlYMHR4QmRyYjU2RGRPa1FGVFZRVGFQ?=
 =?utf-8?B?U3ZWdGpKTGdMWlJaYlVTUXhPay8rcTNHTUgybWxJSFJoU2ZxdnVmNHNxbmY2?=
 =?utf-8?B?d2tvK2t3UVpBYjF5YWFjVGxxcTdyb0lQV0lYZktvTVRkc1AwNmpDTkN2VGd6?=
 =?utf-8?B?LzVzUzErdXl2R0czUmdHb3hpMWpKL2ZXQXJXM3V1WU5vK2pUeVppUWFOYnRi?=
 =?utf-8?B?UDJDUk54VXJ4aUhMMVNmdVJhMVd3K00zK2ZSUHFZMlZpeWJMckExUWZ3d0V5?=
 =?utf-8?B?b3B6S3ZuNG1lRFlneGxGTmJpMGtNcVNRdE9pWUZobCtBaDhuMWMwc1hrVGFv?=
 =?utf-8?B?SGcrV0wxTm1mbE1QeWEya054VVN3cGc4bC9seURVTkpyUUhCZldiWW5DRXhO?=
 =?utf-8?B?aE1IZEZQbnEyS3RoSlJLQ0x4RlF2eEt2YU91Y1EwSEorazQ3UnJuVGUxS3VW?=
 =?utf-8?B?ODBmaVlLZnZqeUc5aXgxV3VsVUM3S3BLSkpGMDFMUWxoc1NQS0hUcnJCOWFh?=
 =?utf-8?B?U2pHeUUvZHVmVHMzbHdaUHJTVGU4dHR0N1FjNE5wNTdaRFF6MXRwSnZFSTlm?=
 =?utf-8?B?R05DV3dGYmtwQ2JUdkUyUXlYWDNJY3dwOWZPS2oyTEJOMG1tZUpzUm1YY3B0?=
 =?utf-8?B?cnd5RjBpeWZJdURrbFFWVXZMQlRqVVgzbzAwbDIxQStPTm1ZUlUvbU1qSkIv?=
 =?utf-8?B?L2dqRjEvbDFJM01HbWQ2TXQzT0Y5V1U5dDdJTVhZb0Jua0p4QTU0L2RFQWVt?=
 =?utf-8?B?TWdsK2F2dWsxOG42bzZhNW9qSldlY05VbExkU2IwMWgzNFhPTFFUTTNPaXdw?=
 =?utf-8?B?b0xEeWVqRVpSTDFCaktwVXU3T0ZCWGJTS28zTVR2NzRmMmxjMzJCR1kvenVI?=
 =?utf-8?B?SnV6aklwTVh4a0tsUllyMW1sRWYxM3NNTDdERkNITitrUFlVbkN4OHFOM0R4?=
 =?utf-8?B?NXJteVRibWJwYzRDeVpuancrZVVaY1lTWmdTYVBJTGtmWDd0QUY5T25OL1VF?=
 =?utf-8?B?VCtNUUsyKzZyOVJaK0Y0anZIb3NERmo2QS9yMHpSZ2dGMkJRZjNQS1dUSnRx?=
 =?utf-8?B?WGE1cklTa0Y0Y3RmZ3dnWGg5c1NkaXpDTnVPVjVjdXl0UlhSd2JFeCtpUEg0?=
 =?utf-8?B?VEN3ZG9IK0hSeVpybG55dTNyVlcwVUtqMWFkc2tzMVBsZm1wbHpWYzc5eStr?=
 =?utf-8?B?eDhkTmhndGxYVjMrM1FkL3c1RDl0UHk1V0dleDkyY0hZQmsxRWgvMlRzQUVp?=
 =?utf-8?B?REg2R2FtbFBibzVOU05qeHRmSjdVV1gwNmdaN1BXRHhRNGxDTitjYU4zYVJr?=
 =?utf-8?B?SW1CL0N1NksvcjFQeUJjY0crZ3V2TWRNMEZsVTVWTUg3ZGg1NmJROHRwUzVw?=
 =?utf-8?B?K0Z4czNRSnc1QjA1NloyUG1rbm5nZTNDak9LV3pockE5cjYrTzdINitxMjNi?=
 =?utf-8?B?YjlQY2gzZnI0M3Rxc2h1dy83WitETXh3cGVMNjQyZFByenJ5YzBtRnNza0pK?=
 =?utf-8?B?Lys1VFdybTBYMDU0QVVoSHJqSWhSOVJ1dmczNEx4WDBJZ08xc2tmS3oxTUI2?=
 =?utf-8?B?dmIxd2JxQkJRSlU2Q2MvR1VWMTArWXMvUWNmNVp6RG00Ritkd0J3S3dWUklo?=
 =?utf-8?B?cUMwcm1XYWo0MktFQVV3cHh3ZlR3YkE1Z1hQcHZWV0Y1SDl0UGNhTlJSYStr?=
 =?utf-8?B?N2ZGQkFyQ29uSThSQzNjVUV6OE5Yc3RscldETllkTWFNMXNCcjJpK1UrenNl?=
 =?utf-8?B?Y1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: be797f07-415d-4662-029b-08dbd606acf1
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3672.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 09:33:56.3742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0fQ/wL5GkTt07aR1+ymb3Glo+WrvOkN0J1kUkqfYYMLlAWz2fnUZWVZ32sWi1YaXwg+hlDo+czgro+K0wpmEl09AUI1R33H2to8o/zN9+r8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8077
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/25/23 16:59, Ivan Vecera wrote:
> Removed fields:
> .fc_autoneg_status
>      Since commit c56999f94876 ("i40e/i40evf: Add set_fc and init of
>      FC settings") write-only and otherwise unused
> .eeprom_version
>      Write-only and otherwise unused
> .atr_sample_rate
>      Has only one possible value (I40E_DEFAULT_ATR_SAMPLE_RATE). Remove
>      it and replace its occurrences by I40E_DEFAULT_ATR_SAMPLE_RATE
> .adminq_work_limit
>      Has only one possible value (I40E_AQ_WORK_LIMIT). Remove it and
>      replace its occurrences by I40E_AQ_WORK_LIMIT
> .tx_sluggish_count
>      Unused, never written
> .pf_seid
>      Used to store VSI downlink seid and it is referenced only once
>      in the same codepath. There is no need to save it into i40e_pf.
>      Remove it and use downlink_seid directly in the mentioned log
>      message.
> .instance
>      Write only. Remove it as well as ugly static local variable
>      'pfs_found' in i40e_probe.
> .int_policy
> .switch_kobj
> .ptp_pps_work
> .ptp_extts1_work
> .ptp_pps_start
> .pps_delay
> .ptp_pin
> .override_q_count
>      All these unused at all
> 
> Prior the patch:
> pahole -Ci40e_pf drivers/net/ethernet/intel/i40e/i40e.ko | tail -5
>          /* size: 5368, cachelines: 84, members: 127 */
>          /* sum members: 5297, holes: 20, sum holes: 71 */
>          /* paddings: 6, sum paddings: 19 */
>          /* last cacheline: 56 bytes */
> };
> 
> After the patch:
> pahole -Ci40e_pf drivers/net/ethernet/intel/i40e/i40e.ko | tail -5
>          /* size: 4976, cachelines: 78, members: 112 */
>          /* sum members: 4905, holes: 17, sum holes: 71 */
>          /* paddings: 6, sum paddings: 19 */
>          /* last cacheline: 48 bytes */
> };
> 
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---
>   drivers/net/ethernet/intel/i40e/i40e.h         | 16 ----------------
>   drivers/net/ethernet/intel/i40e/i40e_debugfs.c |  3 ---
>   drivers/net/ethernet/intel/i40e/i40e_main.c    | 18 ++++--------------
>   3 files changed, 4 insertions(+), 33 deletions(-)
>

[...]

> @@ -12831,7 +12830,6 @@ static int i40e_sw_init(struct i40e_pf *pf)
>   					I40E_MAX_VF_COUNT);
>   	}
>   #endif /* CONFIG_PCI_IOV */
> -	pf->eeprom_version = 0xDEAD;

haha, dead indeed!

[...]

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

