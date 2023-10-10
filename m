Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C21B57C4248
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 23:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231749AbjJJVUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 17:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbjJJVUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 17:20:48 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44F5398;
        Tue, 10 Oct 2023 14:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696972847; x=1728508847;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OFrAlp0AjtFOdXwfmktFbHSh/sYR/ZJn9QAb54o/vbM=;
  b=GraIizM4zVVBPKg/scv5nvofD4yyzxXQinG+dWURLr9IzftCSPLDN7pU
   dImjb+4yCq0J0gbDdX8TafTixMMlekMQrS3XfS8NS+MQQ38Dydm1TmTIW
   Mp+Dd5rmNsq9YWfyOzOC+rlFhHWrFreR64d261epul2NxCOk3+hAKjhyZ
   T5sYjE8AW5oXhLn6XZiRrfU32AFzs821+lTJxkldwJn9sVgovaqOAjKYM
   GzhT0MKpwGK/6LpOJ+XWaHh3cZjbq6ozwyV/CwQbRysw6XF8LXlrKAc6Q
   etdmMzg/4iRvx5auefT6miRBxolhB85CynuDXKROfag2VAY4ZnB2Yc1Kh
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="374851758"
X-IronPort-AV: E=Sophos;i="6.03,213,1694761200"; 
   d="scan'208";a="374851758"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 14:20:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="753551661"
X-IronPort-AV: E=Sophos;i="6.03,213,1694761200"; 
   d="scan'208";a="753551661"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Oct 2023 14:20:41 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 10 Oct 2023 14:20:41 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 10 Oct 2023 14:20:40 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 10 Oct 2023 14:20:40 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 10 Oct 2023 14:20:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q0Q5bN6Yhf3GRrd5FUnySXHHzsSjj/+TsdEMmsYs3gg8y3kkcRHyLliPQyuxcdgj9NCWtvZ7IHWolWhrl5jMjCuDbBfl0LtkHU7tckpMNg95+t2zvYLYWjbB+T97ituUYb62Ao9GGN1lYDtGQLjGhmNoYt7kSFXqHohEkRt1sSam0f6Ux1fdlAALoeIMPVAfjYtxLGR7eNE0hiGfWqXCCkxSEHu+DX4MZpkflZ8nhkZpsNwveZjagOfpVJE5/ihZ0UC6srnmhRZIXfwFxXrm+TiBE3Yd+XG1Rph6bR6of5jgHqQj8qaKsDgUZ8BNSGEtiGoVuZSXnO5POyfYIsWYpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xIH9mFapxLB5QebjjN+wZKUj1UzL4btHFZ3UlzuhjLY=;
 b=IVKefDKKCTuLcfSyF27ZI+ksNu+6SYlfp9UaSL6mcq7F2YvWn1KizkNbS85Vw4QuSt90vmXd8Xcpn8iPotDS+VgUkCc4x5FJwe9aQoX+R+Gylj209/D1Lrz4SuM/TLqVQq0RB9RG0hchSqm3N44/4KN27cryDe0dv2fiiLqlA8ZZZyADiQ5YDdJDRsvqyt8t4APoCQm1H3/URtoeHCG6IO3meDSOm/cx4O0ocQaM4/UXk+dAgBBmZ/dMZscJDt09TPRauN1MTCZ2BN/x+2IatWdlQjNE1jDSRkk4HvVPv6qylKbrcEuEL9soFUOnw2pGHTGMVELV8zRr6xCxliVP/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4914.namprd11.prod.outlook.com (2603:10b6:303:90::24)
 by DS0PR11MB7286.namprd11.prod.outlook.com (2603:10b6:8:13c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Tue, 10 Oct
 2023 21:20:33 +0000
Received: from CO1PR11MB4914.namprd11.prod.outlook.com
 ([fe80::b598:4b13:38aa:893e]) by CO1PR11MB4914.namprd11.prod.outlook.com
 ([fe80::b598:4b13:38aa:893e%6]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 21:20:31 +0000
Message-ID: <5dc78e2f-62c1-083a-387f-9afabac02007@intel.com>
Date:   Tue, 10 Oct 2023 14:20:28 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.1
Subject: Re: [PATCH] igbvf: replace deprecated strncpy with strscpy
Content-Language: en-US
To:     Justin Stitt <justinstitt@google.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Eric Dumazet" <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
CC:     <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-hardening@vger.kernel.org>
References: <20231010-strncpy-drivers-net-ethernet-intel-igbvf-netdev-c-v1-1-69ccfb2c2aa5@google.com>
From:   Jesse Brandeburg <jesse.brandeburg@intel.com>
In-Reply-To: <20231010-strncpy-drivers-net-ethernet-intel-igbvf-netdev-c-v1-1-69ccfb2c2aa5@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0337.namprd03.prod.outlook.com
 (2603:10b6:303:dc::12) To CO1PR11MB4914.namprd11.prod.outlook.com
 (2603:10b6:303:90::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4914:EE_|DS0PR11MB7286:EE_
X-MS-Office365-Filtering-Correlation-Id: a048c498-7724-4cc9-ec02-08dbc9d6bb7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zk/6ko695FtbiRcJkCc9ThzXWKE02Uez4w++idQoxeVvrx+0hp6jkiecqlEvM8X/Eb2FYOkJbwnHf4sYwBfAfAaVxvr/xHONm/eR9mg8jdI+6Z3ROAS7ycyVb+sVtQrqamucXm+e3qN486+R0p7sWOc/2acJNsHefJTEbv8/pgxeAWlWf9nBYxFckYlXAvn0PgVtI6YdwIKe2wG3YFZOsk76VwBUq+FJqITtqo/HtAaFCK6LGK5hYDqtIAJBIkRAVxBD6Romnd2gjPepFVr52csBt5NAauKuTefZaOhKYffnG4mP1S7xJ1xXUgtUa5f5711/Ty+qv8vQN62tZCS1gpeJk77SevmG7OdSiXG3ZRrw+WVAgbmofYxuPIWn9VDUgGDcTQ/Tgp2NXm3lEBoTFxNnAwN46VT11bFyzzLLBIkrOzuSVp/1zO0y14IxODadUitjR5VeM4iSrnz47oEOEVom7j+m28cnZ8rdbX9SNuq0O+4bJEKMdNdNQY5ZjJ5zyVqk4dQcbhahz2r4WH+FBucXkQvro3fXIiWx+gjgyQbcTmsLxY9tQxOxTioJ4vsGOrI7/x8PCkvfKst48UienTRWerH0W+aIdjLI0u1aNzLH286BSME0urmkDZYrTw9olRUkP+/4IzskFXyEkYTgwGfN18eXSz7/w8r5d0KrKcMUYT6SrRQJz7H1I3Oii8nl/DQDjAjiuW6INqLgOfDe3Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4914.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(136003)(39860400002)(396003)(376002)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(6512007)(53546011)(6506007)(478600001)(26005)(966005)(6666004)(2616005)(66556008)(6486002)(44832011)(31696002)(83380400001)(2906002)(5660300002)(110136005)(66476007)(66946007)(8676002)(8936002)(4326008)(41300700001)(316002)(82960400001)(36756003)(38100700002)(86362001)(31686004)(156123004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?STdLVjUxU3VlbHFmRU8rdzNwRHo4TXNXYk10bkhRQ2RBVlpoamZmTXl5aHps?=
 =?utf-8?B?aVJLcU9ETmRHRzRvalkwOWpqSzNvRGpBc1NKUSt6YytZWWF2alJGZHdqWjhs?=
 =?utf-8?B?bVkzajJla0ZsRVNKWUtuTFJ3dDdGQ2tUTXQwNG1aUEhEQkVjLzd6RGQ1L1Y2?=
 =?utf-8?B?c0FXVjVUQzVXUjRsejRqMVdYSXRncHhoRm50bTk5RVVoRXFaaVRYNmRUbE45?=
 =?utf-8?B?aUFXaXhMQ0xZcWUralNTaXNwcWxpYW44cjViL2pYV0ptSytocFowOFNTUFE1?=
 =?utf-8?B?ZmFKNDBLVE5ESmwxQ3NGM2ZKZWs4L1NzQWFCRXZTL1NQcnRoOGk0Wjdiamt4?=
 =?utf-8?B?ZDVaKzhhTldGS0lRUE5lT0tHV2I3UXpTMGNSZ0k1SnJ5RTVaWXFKS3VvNFR0?=
 =?utf-8?B?ZFlSa1BKYWxsc1prcHN6WXdMN3dPQW1DYnZhOEg0R2Y2NC9VdGl5ZUsraXEv?=
 =?utf-8?B?bkVhTElxbytIRDlLM29vaURSSVQ2eFlJMVYzb2lOQTdNSTBNMFJwVFdxdCsr?=
 =?utf-8?B?Q3FsY3N4UlpycXJaNGpFUDBoR0E1UlB5aXFIOGpDekR4ZGxML2t3TGVMODFv?=
 =?utf-8?B?SWdZRE1iRWloaUpDdmNReS9ZdlRhWkMrVHROdXBOVkhFc3ZjVnZsY2JPQlBz?=
 =?utf-8?B?VUlqOHNoOC9yclVFSE5wVE96UHkzekdEOXRKeTJ1S3pYYnBzaXJjWEk4ejVk?=
 =?utf-8?B?STFyZWhFN3R0VGZJTmMyTHlDNGZjdFo5SVp5bUJQS3N5cGU0aWdIS0xqZWRG?=
 =?utf-8?B?cndSdjBHVU84Tm5qbjFFR3pjYjhPTXZRamJhek1ueEpZOTRHOFZrRG1ia043?=
 =?utf-8?B?T0psNk1zd1BNelRndXlmTjhWazh5dnJka1VRSmVKaVBidDlXTksyVkl1OWdK?=
 =?utf-8?B?TkFhZ05zR0FOU24wQzVpKzZVWTViWFg5MUVWS21FZEtrZXBFc2hvQjk0c1Fi?=
 =?utf-8?B?S29qYzBLWHEyQWhHMEYwSlNlK0xsdDJhdlc1dnZyR0oxbHdNdGM5dnJFc2cv?=
 =?utf-8?B?dUJUMWZWMmtjS0NLSEkyS3QxNXRsNlE2OXRqRXd3VU5Pd3VpWndwSXAwZ3ho?=
 =?utf-8?B?R3RPdGt3eGhNeFlVSlFocVFGeDJSVkIzdzRpZ0F6b3RZbHF4UXJlQWIweVpN?=
 =?utf-8?B?RnFSblVYanVKOWFYMDVXcFZ1bGZoSWV4RE9NOXM4NGd2Wk5JK1FHYUdNYmhm?=
 =?utf-8?B?N01KT3lScktSRzU3OExlZW44L1J1cThlbmNZby9tWnRtYXFDbjAwa25IWkN1?=
 =?utf-8?B?Q1ZTV0I3QkF2Nmx4T2YrcDd2MGJPamNidXQ2eDBSVFVLMVBZS3BSNy9pNFd5?=
 =?utf-8?B?TG1QWkVOWldIL203NXczYmtYbnVDMjRnUmliZGhBTjJpYkd6WVVrRDlwQVAw?=
 =?utf-8?B?dk9MYnpha0hXY0trQ2sxaUhIYk1ZYXFnV3J1UlVldk1PWDF0ZUs0c3lVUmk5?=
 =?utf-8?B?ZkIyMWMrazVvbGVySWs1dDl4N21DWE04UGNJWU00elhGc0VaSnVDL2dYenVY?=
 =?utf-8?B?QWJYTXBtbitldU4zT01hWjhHNkkvOCt4NHJqMWJKTFA3YmNFa2VmUExaczIy?=
 =?utf-8?B?NzY0VUVKcGJsUVh0Vzl6S0VCVXo5Ly9DZ1I5dlRoQnBsT2tvSUFuTmpkb3lE?=
 =?utf-8?B?NWJQVW1QcitpeHBEbnhuN1JwVWhlcHVDdzg0Wlo0TSs1VU9qQ29FN3JJYjI1?=
 =?utf-8?B?NEZhTWlHM2VYY2crcHIxNkphdWNweFNIbTVYWEpuRzBHSnh0enRqWGxDbXRC?=
 =?utf-8?B?QWNpME0vSjhrdGYrVUF5a29ZT0ZyQXFvY2FqSTBkYkJsNWs5MzJ4RVA5TjZW?=
 =?utf-8?B?NXdjc2p3L2ZFMWZUWlFSZkNwUldkNlRuUW55YTMxSmozaUVObVFoN20ybUdE?=
 =?utf-8?B?SnpMWE9lRElMWUFENWc3VXNzdGsrdGRSc0N1a21LRkxic0hqdmJCVDVZYmlC?=
 =?utf-8?B?djJtMm5pRTF1cm0vK1F1V25tUDA3Sk5NZVpyUm9PVFBaUHJjZy9DVHFLL21W?=
 =?utf-8?B?TWxDNmcyMDJHeXJqMmY2dndUbkhHeFBIMEh6c0xKenRaTnEwRHRJT0V5T2Jp?=
 =?utf-8?B?SlBaVnFMYzBYcUk4QlRpdEhKOWlIMkIyM2doQzQ1WWUzdzBNVHZHeUhDbkNO?=
 =?utf-8?B?MEp1enBLYnd2ajJ4UVRsQ25hQmxoWDlmM1VEcU95V2tIeUgxdEN2NzFkNlVt?=
 =?utf-8?B?Z1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a048c498-7724-4cc9-ec02-08dbc9d6bb7f
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4914.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 21:20:31.0258
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YBYQdi5ngCzEedjBjX/0R/8yA2cyQAx6ieIJOTrF/nBXCAu5pURylof6/p2uqjkPCtL4F9nPjteuRrokKSI2MVwT7ekrN3ecZK+OFqKFENo=
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

On 10/10/2023 2:12 PM, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> We expect netdev->name to be NUL-terminated based on its usage with
> `strlen` and format strings:
> |       if (strlen(netdev->name) < (IFNAMSIZ - 5)) {
> |               sprintf(adapter->tx_ring->name, "%s-tx-0", netdev->name);
> 
> Moreover, we do not need NUL-padding as netdev is already
> zero-allocated:
> |       netdev = alloc_etherdev(sizeof(struct igbvf_adapter));
> ...
> alloc_etherdev() -> alloc_etherdev_mq() -> alloc_etherdev_mqs() ->
> alloc_netdev_mqs() ...
> |       p = kvzalloc(alloc_size, GFP_KERNEL_ACCOUNT | __GFP_RETRY_MAYFAIL);
> 
> Considering the above, a suitable replacement is `strscpy` [2] due to
> the fact that it guarantees NUL-termination on the destination buffer
> without unnecessarily NUL-padding.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---

Thanks Justin for these patches, please make sure you mark the subject
line as per the netdev rules:
[PATCH net-next v1] etc etc

I'd also prefer they came in as part of one series with a good cover
letter, at the very least for the Intel drivers, and you probably could
combine any others (netdev) together up to the 15 patch limit.

Please mention how you found these issues, via automated tool or via
coccinelle script, manual grepping, etc?

Thanks,
Jesse

