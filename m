Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B60D7C4255
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 23:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234609AbjJJVWX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 17:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjJJVWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 17:22:20 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C600B9;
        Tue, 10 Oct 2023 14:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696972938; x=1728508938;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ku/7RprgdpatBpBmqGTSqE6iGqP+1z5Hd/XUqTl8geM=;
  b=a0uZfKwPMfEc39X+2Y3e5BFSg//qD8BpxIy0ZjsgAotdY9V/S9HzgcFf
   VKO+gSaxEIR4RnuVeVoLE5qXjfTvN8zwdK4e3gxtggek6ErthqwYlDS8J
   +gD0QRXULFXzTU6dDBS+jCnT7fgYIa9BYHsZBQ9kQVOdZ/P+dG6fUIBmi
   wMCnqBfBg5dqz8TXEZPTwcwgRmx2Ifm2wc6li70AA6M/g/z3SX57yrXPm
   EH5XizD5AtuoMitVr5MUq8aq8Q6flF0auGleX6CkvAjrQSF7OxQrB7BQl
   5mdewGZdWYou37uF/sO7q6K3wMTBExfPXzbfcxN3dLDmd7lpnCgeWP9v5
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="374851999"
X-IronPort-AV: E=Sophos;i="6.03,213,1694761200"; 
   d="scan'208";a="374851999"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 14:22:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="753551997"
X-IronPort-AV: E=Sophos;i="6.03,213,1694761200"; 
   d="scan'208";a="753551997"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Oct 2023 14:22:17 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 10 Oct 2023 14:22:16 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 10 Oct 2023 14:22:16 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 10 Oct 2023 14:22:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lbTsCW+IqslghrgYL4bKXPCm0x0RpcccFClsHmOx9No3Ni6ATuG3FmwrycCtl71slEWzWDbLUUhFPiLbZYcsnt7qpPQ3IJQjAHcT4BiGNVPMe8Y4tHnyn6wes1n++Hw6PQMdiOn/NGrzMzNEMj/iDbUEsvf48tMvnofyFwKH5+NlY4NSXQeU835POWSUdWoLA1uN0D6zjJbVlZN+nm8Gn2UJcjmVHgJ1cdGp/zXyZVLPVUuoDJZYjFKtTXqhI4obUCnTMaZhJZWiySgH19ZvkjSu40x64MYfggakp2S98UMPdZW+kVK009VO9fwUVjSopreUq87CHOEvwBiWV76rQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PKxpgtcTBXLOilktjjH5v6PFAzp8Dv9gf7Sfp0QfcBU=;
 b=ZEMDYTbHPxevgRFC3Q56U4/UJyrlKji9fjr9R6QR1DMnCiIWsiLcZl3TSQIbmGw+OsnAc2/sBK2b92+m23QPLbpj5IozPLb/i9oMTY1IN3KjqiNncTB8Vamli7BiBFvJg++VeNdoMsMAKt3spUnSAH8iUEpI6Eii6E55ssvGI6dsZ93v0IeqMJHEGH4JUcC+2UmZMdrevJjj91AwANyHIUbfV7XeqaUyMTmJh3beo2Hf9dSEzpl3yiiZh3kw/tH8+vEc0ql+qkURO4J/rH+jDANmLVo1CU+OPODib5SQoqfMiWEAhE7hl+ITFpeLrA0V1uTzxSwHNjDkxeNg6pUwgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4914.namprd11.prod.outlook.com (2603:10b6:303:90::24)
 by DS0PR11MB7286.namprd11.prod.outlook.com (2603:10b6:8:13c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Tue, 10 Oct
 2023 21:22:13 +0000
Received: from CO1PR11MB4914.namprd11.prod.outlook.com
 ([fe80::b598:4b13:38aa:893e]) by CO1PR11MB4914.namprd11.prod.outlook.com
 ([fe80::b598:4b13:38aa:893e%6]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 21:22:13 +0000
Message-ID: <128f5692-982a-7bba-d9b3-174881cba49e@intel.com>
Date:   Tue, 10 Oct 2023 14:22:12 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.1
Subject: Re: [PATCH] igc: replace deprecated strncpy with strscpy
Content-Language: en-US
To:     Justin Stitt <justinstitt@google.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Eric Dumazet" <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
CC:     <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-hardening@vger.kernel.org>
References: <20231010-strncpy-drivers-net-ethernet-intel-igc-igc_main-c-v1-1-f1f507ecc476@google.com>
From:   Jesse Brandeburg <jesse.brandeburg@intel.com>
In-Reply-To: <20231010-strncpy-drivers-net-ethernet-intel-igc-igc_main-c-v1-1-f1f507ecc476@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0327.namprd03.prod.outlook.com
 (2603:10b6:303:dd::32) To CO1PR11MB4914.namprd11.prod.outlook.com
 (2603:10b6:303:90::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4914:EE_|DS0PR11MB7286:EE_
X-MS-Office365-Filtering-Correlation-Id: 98b9ef7f-a6e2-45d3-d668-08dbc9d6f8b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jKepu6k04N0w3RGuQb0kxZmDCDQCvvvxdrO1gqTt77LbPXy/7U58F/3g/IxpHII+dIasotTMuILQyQbosUzf5tWx5NPeUBB+QwtJmeYedvut5BbQA4RZlD0HQIDdKaaCXZUYo6c6n4E2u5JU9pnXRs+57aKYIbBbfsPKs4c9rP22/LgUooPuYrgMlaAQ9E3yGQQnyAiMIrWxKnbP0K8LkzbE0/mtqUkLpD236yAqHX5a6D2oRbTb+x3es++qttv9tzhej4PJ3tDQroMT+oqlxJQdHMMyl7QQOtvDUiv8mTJxJpX4Hav/IVOYJVRFmTa3weREtzC3RlxGEFBaHQu8HMWgLRttJm4+SctUYGG+GXoCSaNzB426Lk9fpK3SKcRrVMguC4ij9Zafbu9QBdHE65KTaO2dmHDSa8V5lBi+HcbxkVhRDwo17TLjouJjMDe2uKM/QPGlY+BYdoAeB1FfEk8he02TxiQlXdLFFwgBg7jGUOpg2l9LuANjaeMktNECRPTkiXoRfNbtgPeUi33tQGb06Xffzjq+uaUhFPCmsEPH3MXSnXOHnsqlEeaf5Ej6Xzt0Q9LcbgmJvJOrfbEHK/F9+OiKcigHhSZsfmjdC6eodC84baqtejAOUWN/77ZG2J2qwnPB5q1lMKpx7XAVifQxbkejq1e3WW85lQMe15OvzdQ+jPocPx3rkl9dXXjO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4914.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(136003)(39860400002)(396003)(376002)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(6512007)(53546011)(6506007)(478600001)(26005)(2616005)(66556008)(6486002)(44832011)(31696002)(83380400001)(2906002)(5660300002)(110136005)(66476007)(66946007)(8676002)(8936002)(4326008)(41300700001)(316002)(82960400001)(36756003)(38100700002)(86362001)(31686004)(156123004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bWtZWFVRODU1UGNEMG9BMGJ1Sjd2ejJ4eFlMbUJPRDg4b0piUjBkRm5Pc2Rk?=
 =?utf-8?B?S0ZuY0NCMnIvalNyT0E3WXlVc1BZcW5lNzR1bkxib28xdXhhNnd5ODZKcmpH?=
 =?utf-8?B?RWVoTklac2p4SWdyemdLeUxrbFZud2dvNHlvMTBoNUNxeVVvY1IxbzRUNUEz?=
 =?utf-8?B?SjFaOXhVeFY3WlZJWURmUGUxbGF0bmkrQUY5VzEzY1N3RmRqWUlINEc3d1dh?=
 =?utf-8?B?ZkpTaHhYeWJrWXlKS0VuME1wVHdxaGZIZi9QdVBaUGRLWUhnVkRrSVVpbzdE?=
 =?utf-8?B?ZnFPL3IxNnliQUtvM09LNDBobG5rYStXbTB6QXNTVG90cVFVNnJCK2kxN2VU?=
 =?utf-8?B?cUY4Lzd4MGtwaElWZW1tWUFwK292aEZPbHRZaXNkeUorckM1L1c2N2k4VGJV?=
 =?utf-8?B?RTcyd2JTL0doVU9DMGcwU0xXSitLMHdMbzB2ejYyWlNNYXA5Vld0cmhCV0Zr?=
 =?utf-8?B?Sy9SVWJOV3lFbjh6SDZiaGJSZklUVHVzWG1NWnlZbHZKU3NBcGRoUVdDdEcy?=
 =?utf-8?B?MnBHVmlMN2RuNko5ZHpKYnNGVVpOMHY3N0N6aVZGczluZTc2c2N0cGk2SWRv?=
 =?utf-8?B?ZUlackFQOXZIMVdBMEdUSTJjcUhmSmhabkZnOUQ2emtTNEQxcEtqaUR6bHZu?=
 =?utf-8?B?aTVoS1g0QjJEVFYxRkV4R2xuYmxqMVRPR2FKUXNGZUc4NUFyYWV6QldWQWV3?=
 =?utf-8?B?dU03N2FBM1UwcmNWbUpMMC9YWG5hdmhUam9JajYyanRscWd2b1IzN3FwTlZB?=
 =?utf-8?B?S2ZzVm1ySXNsdXVpbkZDaFZLYXU2STZYenJWc0pCbWxFdzJPOS9JWkN1eUZG?=
 =?utf-8?B?dXhIU1pZbjFzWUVPYndqRHl4dU9sQndvMzZOTmxXNk9Mdk1CWG93OVcycy85?=
 =?utf-8?B?T3hZTS9jdlh4TXRKLzlmUWx3d01OUWgrV3N2dXBJL1dESzArdG9oYzZ1QWo2?=
 =?utf-8?B?NGFzeGNsSlZzNEN3VFhsT3UzdDNaQVZaTnBSc3RNcGIwMC9RWkt3R25ZMGVz?=
 =?utf-8?B?VXdwT2V4UXB5ZzlRUVE4amFHUndWQ3k0eUx1QjNiT0NCNkVuaDFjUzkxNVp0?=
 =?utf-8?B?TTRvalZGa0VrSWUrK0V5Rit4ZUN0am5NWXVNOElOOHJWalZlZ3Z0blNjTmd1?=
 =?utf-8?B?TlhIYUZYZ0FqMU5sa3BpQllHbTlvSzN2OW1CdFlUcTV6TzVwY2RuRGVLZU5O?=
 =?utf-8?B?T2JHdDBIeXRPa2NJS25pUm91VkpDa0NWVnYxWEU0Znc5aFR5Y0xlazFKSTBr?=
 =?utf-8?B?OFluRzY2ZTd3dkRXQ1ZRdjF5ajFydTJOSHgwRGdGTi9LYU9URUc2VTQxR0Ev?=
 =?utf-8?B?QnVLeTFTWFJhNGZydndUN2Rmdjc0bC9wUXZ3RnY1bHhFeEJTZXhXbW5VUDFJ?=
 =?utf-8?B?T0o3bDhaa1pNV2Z1UmcxUVA3aFg2WWZib3VWK3c1aVptNTZML3VJWEdkMjgy?=
 =?utf-8?B?WCsxT3BHVjJ0N2ZzWmYvY0wwMUhuelhwU0Z2MTlHU3cyVnk0SnZ6enNRa0cv?=
 =?utf-8?B?OGhkT3BPY2N4TTFUN3hkaTVhUk9NcUx6WTg0TEhMMnFkM3FyckVVclFHMGlp?=
 =?utf-8?B?MWd3MWxUbFplRjBmK21SSkE4RHEvYmovS3BITWcxckRsN29BUlFIM1ZZWU5x?=
 =?utf-8?B?QWtRZ2dZS0wxN0R1WkR6c2FmZjlFTXNKNDl3cGg5disyakJrMlVUd25ib0ZO?=
 =?utf-8?B?bHBlUmp0alBwR1RNR2czUzgyT285Wk5UYWR6SHoxVVErZUQ0V2lBeDhnUEhy?=
 =?utf-8?B?eTcxSzZkYUlLaWVLWGd2VGVZT1YyRnNnbEJWT0lpKzBvbTliSTFCeEhrdDl4?=
 =?utf-8?B?MnIrNFhQbnBxaDlBK3A0b1BWMnJNdzRYcWd3UXFnVlkzODdNZTRlS3plWnJi?=
 =?utf-8?B?eFQvTVRXeG4vZlEyQWxEZWdkR1Z1SlpnL01vbUpUQ05iRlB2QnZqYzdnMS9L?=
 =?utf-8?B?amhSN2VBSFJYa0tXUjErbVkybWxZWmtGWGdrQk5ubEpmalRSa3FYY1NwWmFU?=
 =?utf-8?B?TGVWL0RlbTg3ZXRiUDhZM2c0OTJYZWpNaktyWlZQc3B3UURPNi9aRm9QdG9i?=
 =?utf-8?B?OUhVMWtwVXpJVXFYS3Z2VCtyZlNEalMwRXFlUHhYM1dob0JJU3FwYWpXNGRG?=
 =?utf-8?B?aDB6akpvMDBLeW9zUzYyelMzVXp1QzViOGd5YWQxaWVjM0ZnZERqVVNDS2h3?=
 =?utf-8?B?SXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 98b9ef7f-a6e2-45d3-d668-08dbc9d6f8b1
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4914.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 21:22:13.7010
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gSeAnjpOxt8P56RfzVyI1eWzrTdRIaegxAVUvCbKkknH+zyIXJwA8tMgs/3JD4YQ9NAACnckdLcKjXq/SgAIucNs2Xa+vwAaug/TPlbPoy4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7286
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/2023 2:15 PM, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> We expect netdev->name to be NUL-terminated based on its use with format
> strings:
> |       if (q_vector->rx.ring && q_vector->tx.ring)
> |               sprintf(q_vector->name, "%s-TxRx-%u", netdev->name,
> 
> Furthermore, we do not need NUL-padding as netdev is already
> zero-allocated:
> |       netdev = alloc_etherdev_mq(sizeof(struct igc_adapter),
> |                                  IGC_MAX_TX_QUEUES);
> ...
> alloc_etherdev() -> alloc_etherdev_mq() -> alloc_etherdev_mqs() ->
> alloc_netdev_mqs() ...
> |       p = kvzalloc(alloc_size, GFP_KERNEL_ACCOUNT | __GFP_RETRY_MAYFAIL);
> 
> Considering the above, a suitable replacement is `strscpy` [2] due to
> the fact that it guarantees NUL-termination on the destination buffer
> without unnecessarily NUL-padding.
> 
> Let's also opt for the more idiomatic strscpy usage of (dest, src,
> sizeof(dest)) instead of (dest, src, SOME_LEN).
> 


Please see my comments on the igbvf patch.


