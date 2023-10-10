Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 533837C4251
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 23:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343707AbjJJVWG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 17:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343879AbjJJVWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 17:22:05 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DFDDAC;
        Tue, 10 Oct 2023 14:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696972923; x=1728508923;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NMjB3/BK7aTkWFr5x0bYSV1DcNIin2Mt6JrIyeJsyQs=;
  b=KcdZ1e/G9Ak8VVKC+DrFclPJdvSMb/X59G0OkDZUEugm2WShedsBHXlE
   ZnZyrIL0mmEJ2bo0F0Zj5fJPWJVOraWAjVIogYNdTnA7GiU+TuHXqWGk9
   mmP9v8Ro/8ip/an6laspEZrZ3HdYL7BrxcGSwaz3ajRdE4CyZuYaps6DV
   VOm07nejoNci94YaMfzUK6+n0tZfAgXUcitZwewpOKHCVttxTJ2Kn/nPx
   z5d0NeCPgNw2ZWMEDSlqJTQ+cCMojdYFZM5s+QCfdryfPsYcCeFQEZuvC
   JCGexfLEThGnTxoyBCrNBTAmxRcS79ES7eFCI/cIrNuFsICND4dDYc1v5
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="374851946"
X-IronPort-AV: E=Sophos;i="6.03,213,1694761200"; 
   d="scan'208";a="374851946"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 14:22:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="753551936"
X-IronPort-AV: E=Sophos;i="6.03,213,1694761200"; 
   d="scan'208";a="753551936"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Oct 2023 14:22:02 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 10 Oct 2023 14:22:01 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 10 Oct 2023 14:22:01 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 10 Oct 2023 14:22:01 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 10 Oct 2023 14:22:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dvq2MEwSPLIaUUAuQnZgWVtnb9lY3bgHFhGWZGL1hoh59gh7RjQRWzUE9Gw5SxiW2oLKY4hgg/bl7LXxr79bRVYN9mZU+qb5drZ+GWhuUlPqz3PeS+YQofninfjl/rZv6oqepfcmidDGbT4BV2MQCq2DQhTmRTbUxBbP0KYFbb4mJVhTsSE4sCh1Ca1RiL7aUMNkVPMU2AZ1zi4ypeUHqcoDy2Oi3N2r+Q9XVkbWhh+nzzucI+fbOebiCZgsEkdlla1WkAQx8y+kLW/GlhnP0sIgLKO4YqdmXAO5xXcQ/8cAxBVFgARzX5UNfMqPExvm2Jo8bpqU5i9E0lIwD71nPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SPZHmhwa8bJWLKB4wIreDZRsYD5HlmHpi5+m7IBALzo=;
 b=oX5saXKnioQt2DMhLiFpQvMbQ4HRI5Zqmt9P3wFczquN6v6Pf5b0QKhj5TsOSX+EKgIs7rAX/lLMDypVncPw8UXz4eavCwC7cVhQ0qb9Jm3vrpPCTAvQB5r5qsz2DxFetDcuKq7lnYZNh7oKucNpy870TnRhs5GCQlPbeCRZf+yDCe6ZIANh4Hf5DFEHdKy7WgsQVpb1jPBNNeexD5hZiwzF1vIXQROxTCiQ9mf1hoQZX8v6BDPj+OX2tQ6F3pvRCvQJIncWGajCLaVWEiNdQXVoCHb7xtq4+vLe5u/9stWqb88P6ws5cbdHKEiOwg1/hAWRopQ6RzKhXit+OwMoLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4914.namprd11.prod.outlook.com (2603:10b6:303:90::24)
 by DS0PR11MB7286.namprd11.prod.outlook.com (2603:10b6:8:13c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Tue, 10 Oct
 2023 21:21:59 +0000
Received: from CO1PR11MB4914.namprd11.prod.outlook.com
 ([fe80::b598:4b13:38aa:893e]) by CO1PR11MB4914.namprd11.prod.outlook.com
 ([fe80::b598:4b13:38aa:893e%6]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 21:21:59 +0000
Message-ID: <831a4363-40e6-55e8-8b66-6311e587581d@intel.com>
Date:   Tue, 10 Oct 2023 14:21:58 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.1
Subject: Re: [PATCH] igb: replace deprecated strncpy with strscpy
Content-Language: en-US
To:     Justin Stitt <justinstitt@google.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Eric Dumazet" <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
CC:     <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-hardening@vger.kernel.org>
References: <20231010-strncpy-drivers-net-ethernet-intel-igb-igb_main-c-v1-1-d796234a8abf@google.com>
From:   Jesse Brandeburg <jesse.brandeburg@intel.com>
In-Reply-To: <20231010-strncpy-drivers-net-ethernet-intel-igb-igb_main-c-v1-1-d796234a8abf@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0171.namprd04.prod.outlook.com
 (2603:10b6:303:85::26) To CO1PR11MB4914.namprd11.prod.outlook.com
 (2603:10b6:303:90::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4914:EE_|DS0PR11MB7286:EE_
X-MS-Office365-Filtering-Correlation-Id: f0e66fe0-5a33-4e83-a885-08dbc9d6effa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /OawjgZqhFmaQ2Nm9EBpHOqQcujTRQ1XOCwoTQRhV+XsRE+eyDUooSiF3LS62wJaHMytpgOKB/yzp41kTce9Co3lg3fRamj8OgIzhgEBRpETtRHb9wn0+HVIs1lxLQ8o5Bwfyk3fb/wMk6A+3LyP4IfbKja1ap9yMLwQ2J+4pupsdunMJ07r3EIOwGnIIZ+4qAgjFB4JydIPg/YL9Lp7lZRR/7L7a+2bvhVpTGyZ3Z1VLlt/Uc0nSEBbe4T2r1bUoMqx6lpPMLgZndfZ2lSfdwKqfjpX8H2+8zCpPu4zi/xzTp/zyagWdiKU3OZXimg8FmjvRfnPzAGaszAo2UHh3xwolBm2yObu6VZGhfXqrP0CBZCZtMLBSvVmUmQAd4HJ3nkaOMijRgh4ns72ImdW1inPSavXVH+9D4x2eAcKLbe1VNd5o12iV0T1w2W1qyQ9X2j3z/dg0IxFZY5hiK7FPxkqcEagKMDDornSRBrwC3GWh0YmFxiKtFKzJu5CS1rQyuCT2fuYJUXGtVbn4LWSj0P+JGB6RwT4tlZIN3n9UmRx3IGsMPj7SEaWqR/sbCRbtgOiu9DlZ5wXmUButl6tEC/esEA/dQKJz9caI5b34kDxZZ3C58/jlQcRbqFXENZcaNBY+lWmFiWyLw/UfNUqM21DvQoFs6CFeD+grDAqSYmkAMgFQUaAdjq+6K5EAXRQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4914.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(136003)(39860400002)(396003)(376002)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(6512007)(53546011)(6506007)(478600001)(26005)(2616005)(66556008)(6486002)(44832011)(31696002)(83380400001)(4744005)(2906002)(5660300002)(110136005)(66476007)(66946007)(8676002)(8936002)(4326008)(41300700001)(316002)(82960400001)(36756003)(38100700002)(86362001)(31686004)(156123004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dWVnbnFXNE5pVURGL0tXb0txM09JTU4vRjl6NDlKVkNnWkRuNDhiNVNnUUVW?=
 =?utf-8?B?dGxrcFo5UHBHcnBldGJXY2kwTzc0aEZJbDJLYmV2b3UvaDB3emRqQ2ZZN3pI?=
 =?utf-8?B?MVpFMko1ZmxDSGxPeW1xMmZqUGZ0bFRwV1ZrV0RkNElMbklrbHlzSzd0NGFF?=
 =?utf-8?B?a0diT2NuUnNWSENQSTlhVDB0Z0c0RXVqUm5sZ3J0RVZIYnpaTlB1VTg3TkYr?=
 =?utf-8?B?VWlsKzJWV1NYeTFqc0JWTmQ4Zmt4a2VZcmduaE94TDVkeUlVQVZON3FhVkxC?=
 =?utf-8?B?L2pBSjJlU2w4S2NJVU9mcVRSK1RxUERYU2VVQVduZEczWHBKUDBPZDEyWUtH?=
 =?utf-8?B?YUxtcFlscXNTbTVXOXBkK2NXRnpJaWlpWW84NFEvTGQwbFhrRHcrQ3BIVjJG?=
 =?utf-8?B?RURFNlorYVpvOThhOVpRajVqVXAyNzVQOWNCY3BzWVY5R25VQ0luc2U2akJt?=
 =?utf-8?B?YjRCL2NBUVB1QnovNDdBRHlSWkoyaEJzd1lMeTZUOG5YaHpGWXY0SUxJTDNU?=
 =?utf-8?B?U09QQ1l3THVUYjk3SlBlODVOTVJRSTlrKzY5cUs1WEp3MHEyUTdZMklwdW1r?=
 =?utf-8?B?Q0xSVEtXRXR3TWhPMUZLR2RxYkdkT0pHTDJNSGIwYWkzdTdMYlpaMGIwTTN0?=
 =?utf-8?B?MmZ2a0xKaFI2YzRvSWlZUDlrUUJpNUtTR1FwOVkyMXh2YzRVakxSWHl6Z3U4?=
 =?utf-8?B?THo0aXd5Q1ZyWnFtYVJrMUJQRzh0M1o1d2JBT05DTUM4YVo5ZSswZkZGMVdh?=
 =?utf-8?B?ZWk4R1ZmVWdrSFRDZ1JaZHAzcnhNWUJidG9FMWpVYmh4Ky9zUDk4djJaaXp3?=
 =?utf-8?B?MittcjVzSjV5V1FtVGF5ZEhScnFMWE5uSGlqak5iSXFkNHpzL3luRysxeUNQ?=
 =?utf-8?B?aEo5OHk3eWk3aUtjKzRGQlRlNWovbTZRalljWEhpMW0zdks3TVdNS0kxQXhV?=
 =?utf-8?B?RkhYRGVIUDVHbFJWU1dsK0hPbnNIWmxwdVF5M3d3V1M1T3FtSnF0czQ5QWdO?=
 =?utf-8?B?VkRGLzJuM1FvblE3VEdaM3BUTGZxelA4bG5MNm1zRUxvZnlhTnE0STRWb1hX?=
 =?utf-8?B?VUM1Q0ZGd1JKeGdKOGFaenVlT1g4bWxPYVBsYjY4R1NlbjNvZGNkUDA2eWhm?=
 =?utf-8?B?ODZpa2pzZzZ0Y240S1hxV0dWajZRTW54eTd6VWFxaUpnVUNEKzV5MEE4RDBS?=
 =?utf-8?B?K2x3MzNHUEV1YjZtNkxYdHJxMnk4Qm1HOGU0cVNVWGdMWjJ6SW5xVUwxRWtI?=
 =?utf-8?B?aGZycUg2cXZjV0ZXazNRL1EzZXNpV2FuOHluL252UXdpUjdsUWJBZnpXV1V1?=
 =?utf-8?B?MUcrdFliN1dqRE9jZXJjTnVaZnRvSXhoVjJodFp2Z05nZ0Fkam5kUDBBSEN1?=
 =?utf-8?B?Y1BSRTVFbW5VbVBtSTJSdUN4MlE1RThYWnErUjNUQ1NDUFV6aFluVkJacE1w?=
 =?utf-8?B?dkRqa1Q0a05XY3haTTRGY2FhV0M0WE9jUFVYMVpTc1E4SERtYysvVk02bmp5?=
 =?utf-8?B?ZHIwL2FVbmJvRjNTbURJV0R1ZVVKSGc2RXMvMEoranNKWnBDVFdjZTUwSlJw?=
 =?utf-8?B?RS9EQ3lOaXNLSzM3cHdqWU00RHcrNDlXQWFreFd5SVhONmg2ajZ4TTVUaXk5?=
 =?utf-8?B?WldYNnl6TU9GSks4d2ZBdUFtcVJ6VklvU21iOHNOdkZjNVdqSVlIZHlUNXIw?=
 =?utf-8?B?eDMvWE5PUHluendvcW1rMytvR3pUMlNMdjdOMHJPWU5VWEZGMkwyRzIrOVBX?=
 =?utf-8?B?T204aXM1a2wyVUdGNE9GejhVdERvb3VEMTlPSUdFV2xYaERwUHRaTGZ0d2Jh?=
 =?utf-8?B?SE5CNHdGOVR1bFpSQkE5YWJlekovZTVCNkNHbUJFRWQzeEFaRmg4R0hwSEVQ?=
 =?utf-8?B?ZGF3UExUZ3NOenhxKy9MbkZ4Lzlad0xrTE5GaGQya1lvdXFxNFFnKzZOelY1?=
 =?utf-8?B?WXB4b1h2bHNhYjg0K044QkF4V0NWdmhQUktDY2pQL0NveDJVOVpDVUpDckxL?=
 =?utf-8?B?M3BiY3pjaElwRUxZSjloZjhLWTNDZHYzOWZFcXIvZnRSajNUYVN1eCtjWEVJ?=
 =?utf-8?B?WlovdU4zbEdpeXNyY0JROUwzWkpmWktaRmJTOGZKcU5Cd2JxQW01YW5PWXhB?=
 =?utf-8?B?V3NrbngrSU1EdGV0TlRLWmxxYWpVZjlGTU5QcFdKSGVzajkxcTVGVno0VTNX?=
 =?utf-8?B?NGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f0e66fe0-5a33-4e83-a885-08dbc9d6effa
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4914.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 21:21:59.0421
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RAHUJkfBsyMTTc7JWkObSPtEU8XVx+0yjxZirWbX8CKbzU9WtSX7KULLe6OZDDfwnhtfOV/S79qoA++9gBaVdDDZj6dPo8zIqYqFmH6gLDM=
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

On 10/10/2023 2:07 PM, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> We see that netdev->name is expected to be NUL-terminated based on its
> usage with format strings:
> |       sprintf(q_vector->name, "%s-TxRx-%u", netdev->name,
> |               q_vector->rx.ring->queue_index);
> 
> Furthermore, NUL-padding is not required as netdev is already
> zero-allocated:
> |       netdev = alloc_etherdev_mq(sizeof(struct igb_adapter),
> |                                  IGB_MAX_TX_QUEUES);
> ...
> alloc_etherdev_mq() -> alloc_etherdev_mqs() -> alloc_netdev_mqs() ...
> |       p = kvzalloc(alloc_size, GFP_KERNEL_ACCOUNT | __GFP_RETRY_MAYFAIL);
> 
> Considering the above, a suitable replacement is `strscpy` [2] due to
> the fact that it guarantees NUL-termination on the destination buffer
> without unnecessarily NUL-padding.

Please see my comments on the igbvf patch.


