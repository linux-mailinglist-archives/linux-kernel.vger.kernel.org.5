Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B19E80A66C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 16:02:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574065AbjLHPCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 10:02:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574034AbjLHPB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 10:01:57 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEC53FB;
        Fri,  8 Dec 2023 07:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702047723; x=1733583723;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5lqQeIfBu2D1tg/eoabPuFEuzBGvKW3io4h/L46ps3Y=;
  b=CvL26UEWZV/R61WdZTd4cDC5K7e1rpyTSA6B5nwA+S9SCZW0LbsHvacA
   d/kklJZpyWQXQPnjL6J8eCe0Ov/prqcNV4N+MCep+6cUawJZnMWiRUBea
   0QWIQGU3QuxCx9ndiGCMQe6+TL2OZYzcIG4VqOg83zxChmXGu6WhHA7q3
   8x+YmdzSueohC1g+ULVsisCLrkZKXP0MU0DXDTanaKiLEcn0aXv4ej/lB
   n/bambSRpnCjE3rX5jL2bHDqbrSoXGd5G6eaoYvVRHRmuilHUPiPZh31Q
   a/aP9tm5dx64pPotAv+ld6hlmPCyDu9g1Oi85XLG19Jo18ZK6VP51M+8j
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10918"; a="458726072"
X-IronPort-AV: E=Sophos;i="6.04,261,1695711600"; 
   d="scan'208";a="458726072"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2023 07:01:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10918"; a="838144759"
X-IronPort-AV: E=Sophos;i="6.04,261,1695711600"; 
   d="scan'208";a="838144759"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Dec 2023 07:01:53 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 8 Dec 2023 07:01:51 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 8 Dec 2023 07:01:51 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 8 Dec 2023 07:01:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dnnTF4oLHg3rVGVMPNaN0oVf7wfM8PbIjh60vkGbKC4Dk0oGZ6NZrEH20KwBndsLYdBSCfQILgg/4WJoqrxu/ZJizUUPeLcUO490npz1JhAFbVOscohxbvYvhRrXNxSSdvsUBBov0UNwFY5pkLJbWgJv6S6n0rxXvHSO3oSRzM3jSc52/YOjzMXwdvzga5gFG+dU4qaoeoE+78Ps0Q0CCSPw7fFTYTL5oR7WQ0j4Ap+5MWJWJymSmLSv5Dujub4NQ5juuyO6ftS180wV5jvXlrtKLM5v8O+DqMkL7EQ2wiAIrG1MBxVDXLQDP/D/hjiM0R21X0y9ujey66HR4fTDgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RcUxedhO6qv19J5HQ3l7aRq+wmEp4OFKsPHPf/B83EU=;
 b=DL5lx1pEJXrvfcVpiEUCWucB9fqQDR5e+IXzHS9V+uwrv7CWHfwm9uW1fu1dDL+VRwVG78hOiWWj6aOavKmI9ApWOZP8sA9xWl6mb6t+W9wy+9ZKM3NWMX4HuO9hkHpv/Zq6rbEj2rVi4xH09m0hxuEALAnLrr7Iz7sXU12WjiZkV8sNEtCpIY4zL569l/dWm4afjDjWhrPT4f2wYHs8zsnegS+9PRJWuPFvbfLKF/T9BSiZPWOFDV0e9zOENJfgOsbJJEWw5OK6PTyohAoPTt+vWBqW+OfQS005Dckeq/0AzKJugOAPu4wDrB8JBXKxnoWteDj32C4HYJN7f4zb0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by PH0PR11MB4949.namprd11.prod.outlook.com (2603:10b6:510:31::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.28; Fri, 8 Dec
 2023 15:01:49 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::4ef8:c112:a0b4:90f2]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::4ef8:c112:a0b4:90f2%4]) with mapi id 15.20.7068.028; Fri, 8 Dec 2023
 15:01:49 +0000
Message-ID: <fa3cb4da-fce1-4496-ae5a-78133c4b540d@intel.com>
Date:   Fri, 8 Dec 2023 16:00:59 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 iwl-next] i40e: Use correct buffer size in
 i40e_dbg_command_read
Content-Language: en-US
To:     Kunwu Chan <chentao@kylinos.cn>
CC:     <jesse.brandeburg@intel.com>, <anthony.l.nguyen@intel.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <jeffrey.t.kirsher@intel.com>,
        <shannon.nelson@amd.com>, <intel-wired-lan@lists.osuosl.org>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Simon Horman <horms@kernel.org>,
        Kunwu Chan <kunwu.chan@hotmail.com>
References: <20231208031950.47410-1-chentao@kylinos.cn>
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20231208031950.47410-1-chentao@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0011.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::23) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|PH0PR11MB4949:EE_
X-MS-Office365-Filtering-Correlation-Id: 06d52069-2a22-42c0-db35-08dbf7fe9a8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Lb6Rwm6Ndc8KLTIAimwLuQ6c6ySFEWNkXd0tC7QEBO0t6qVhHMQaFoWYt5Eu2W/E0exWnbI6maygAanx8mdSvy3j3mKf5UHTQfNhaT0V4/NZ8y91MoixxvC0gq8KdcF5K/zK+ifYk9UAXX2PM1z3qH6ZRTfQ0gJtrYjkySWxMFDNEFPTj/fQbZqv5u3PCkqrLWKG2lM3siC2Y5zWRcCo/BDb0wEQqgUUHaFN3rYplM4nTcS9Cxtbcamg8AaeogakY8wJSR/0mNDmetuNUK6j39p5kgzlLHHGBeHzURw1Tk37pLnn4KKUtRVjhmzPflbMuoS+fDqpZDzM79VJ4tk6lxnfrbAqcs/1NT+nf+ZYgcrXb4Jlc8IhBmPoLWP7NVHF4d7hE7t4k7LYrDNoqeQaipk7QTzwU0pAfVpcJuewDHYPWB8g9LIDLGlgqrRg4b0s18y20NrNYSj6agjYQ1tRqXqtxv7+NAgebDZvFfTTu8tMS/uUHaCzV7pfQ01YxQQ4OlyIO23v0FeZBK2+X/S6j0laHu2xUavkgt9EQTUwYQizzYFr9T8H+FrACEsq6I7IBlHciTAQYhQNsuViNn1b2JdjnlGcWWZjCqHO4J1VoIb9laRXWJECPPGOE9VbCI3CVhevnehOIUZt1bZVb3i9Sw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(136003)(346002)(376002)(366004)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(6512007)(26005)(2616005)(45080400002)(6486002)(478600001)(6506007)(6666004)(7416002)(2906002)(4744005)(5660300002)(41300700001)(54906003)(66476007)(66556008)(66946007)(4326008)(8676002)(8936002)(316002)(6916009)(38100700002)(31696002)(86362001)(82960400001)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eXZpVVlvZ0c4RHEvQnNKMkRuaVZPV3V0MTJBY0NSc0hJR2t4WVN4bU5XTVNo?=
 =?utf-8?B?emxWcHo1c2ZHUEV5ZC9oTHhJSmJUZk15cjg1Qi9PQmxxQzY3L0E5emZ5Y3Bt?=
 =?utf-8?B?bVF4Ymw4dkpzeWdjSnkxYlRwcUl3T2drNVBvYU4zUnRnbHpNNlBMU2ZaZ1Vt?=
 =?utf-8?B?bzFyM01oT1JKcGs3K1RwRExjRWVYYUhROFUzZEJjckxrTmhVaEhPRTd3N0FO?=
 =?utf-8?B?dldQK2VtdlY2YjhUcndJSzU4MjRBSWlkbkxhbER2WURUSVZ3UFp5SXdVVVY5?=
 =?utf-8?B?MTQyZmM4MmJoaFRyRWVBTDZyTWNaNnAvY2l6WlZUb1JVT3R6QTN0cEVWUkZ1?=
 =?utf-8?B?cjQ2RkpmRnRNQ09GQnppTWVFdDVjUzI3cFJsWElEQThRQTErMWFRaHFaczhN?=
 =?utf-8?B?ZnptaWZIZXFqMkVNd1hzSlJwNVpQUkFJbk56YmtvaWtJRlNMOGtTeU1VS3ZC?=
 =?utf-8?B?cXFHa0VRZVVUSG92QXpsVGdOdGZ3SnFBOEJ1MVZBK3dsaFlOdC8vbnpUSEQv?=
 =?utf-8?B?blRDTjg1dFowc3pjV3hsaGJ3dXVrZ0ZCUExOU25WVGdDZjQ3cFBOSGY5cmRQ?=
 =?utf-8?B?eHFWTUl2NHdxUkZ0QkdvUzFpdllyemVyUnBZY3JSYjVzNGpFdERZRENJWlF4?=
 =?utf-8?B?dEZjNjM5d1ZESUMzeUQrZ28xYWdCbWJLeUdIeFpVaU9YRVp6WlRlMnM5Ukts?=
 =?utf-8?B?ZmVSWEF6UG5UTDNobU9pMU1ZOGFvYW1LcGZTZ3hiU0J6RjJ1dWhIZFcrNVVR?=
 =?utf-8?B?MFBQaWFpNFlRWDZVZGhkNE5Md1Fyd1NOU2t0WkhOTVZpMGhnUlUvYW9PN0ZN?=
 =?utf-8?B?YTluajU5NHBjZ0R2b0VXR3RHQnRmYnBHRzA1WlN3TGROTi9vYXhGay9Rd2F1?=
 =?utf-8?B?QjdFMlYxcndyUmZoUUJNQ1Z6d2hrWlZOL2dHTVlMaEI4Y2Rzclk4bG5iNWtZ?=
 =?utf-8?B?blhNRzBGN2VsSlVQQVhublp6aWd4MXVCbHFFVFFLejk5WEJCZkNjTXArNFcx?=
 =?utf-8?B?bGtTVnhaNmdnL1JkV0NwWE1wOURDaVhwWisyRWNtNmRkdGdUUFIvdTFTd0Mx?=
 =?utf-8?B?a2NBYXI2emQ1aVJxWXZjUUx2RUV5Y0dteXYvdGdGVzZKTEY3TzdUSzNGay9E?=
 =?utf-8?B?b2pKQ2h5QndDeVhlWHRnME95OXBJbTU0YUpUemU4bmRTaDRUMjV3SDcvZ0I0?=
 =?utf-8?B?eldDSXhRR0M5ekx6SzZCZjJkb05NU1YyYWh4OUtLS2ZqUjBJWGYrSjVDd0E2?=
 =?utf-8?B?VWxGbDFzVkc0NnFIK0tlcnhSakNqSmw0NDMvQXF5WEFCWFlYYS9hS1hoakE1?=
 =?utf-8?B?aDNoaGpTTzB6ZHZwNUxSMEFhZVNtZFZ6bjNxQzNUb1pPeVA4bzYvSWhGdHRp?=
 =?utf-8?B?L0o1RkViNVBNbmFNQTVQWFFzd3B5ck56cWFKeWRBdmovdTlJd3IzV2ZxQ08x?=
 =?utf-8?B?TzFWZThPSWtvUm4wS0lZYU0wazBGWmtKOUVOVWxpWlpHRDZlbXNlN0ozbENj?=
 =?utf-8?B?U3dzZGF3S2RoaWhxdW9iS3ExbkY5ajNFYm9OeWlQUFRNVVRMZ0RzRjBnOXQw?=
 =?utf-8?B?YmdVNEFjUDZqODZrUkRBRGJUbzhNNDNiYmpkeVUwbHRhMjA2MjF5ZlUzdHNu?=
 =?utf-8?B?ZHZVSXlaS0oxakdiZGdBbm1RTzh4RDZnejJPSkpQSWxHeGpDTmpweGpJOC9H?=
 =?utf-8?B?dDI3N2NYRWMwTXRhalg0UjNSclhlUVlSNVVscWdsOUtucGNqM05IUDlaYmNm?=
 =?utf-8?B?WlE5UFdMNDl4M3g2dFhTeTVBRmN3TnN5aDZsU2xkcHIxTGpjb05VMll5UkRz?=
 =?utf-8?B?TnFJTW03NkxHSUxTLzdTdTd3RjVQbi91NWtROVRyUFJJVU8zeTRmVFBZSjg1?=
 =?utf-8?B?a1c4QksvZi9HVEFJZlJRZ2t3ZExhREhHaFpTRTI0SkRBcjAxTXJkK0htbXU3?=
 =?utf-8?B?VEJicG5yeXpLb1ZKS3kvM0JkUksxZTF5TWFaOWV1TllLbEFrSXR4N0tsckdY?=
 =?utf-8?B?QjVNQ2Q4VUZ0TTVjaEczWXNJbW9LVTJrOEc2UUJvRUt6VDl1eFlIYnpkS1Jm?=
 =?utf-8?B?NkU5MmZ3bWRpeU1DNDB2aDh1b0Q3VXo4SlNqeXZTNzdmYVNsQzVVOEZnV21W?=
 =?utf-8?B?YkJ1OElSOUJwajhaWjhMT2NQc3NldXIxZWNPYWgwK1F5Q1ZMcjV1MUlJRDIx?=
 =?utf-8?B?R3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 06d52069-2a22-42c0-db35-08dbf7fe9a8a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2023 15:01:49.6254
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3GGVl16Muq05KMJFru1iyP+3ySaFP64eB4t1NDnyDlFv1H/+lE0c0K0OcRlFWwUIyGxjcuxTq5fMPGwMNLW9utJiPFiU4ka6gCw/glea8M8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4949
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kunwu Chan <chentao@kylinos.cn>
Date: Fri, 8 Dec 2023 11:19:50 +0800

> The size of "i40e_dbg_command_buf" is 256, the size of "name"
> depends on "IFNAMSIZ", plus a null character and format size,
> the total size is more than 256.
> 
> Improve readability and maintainability by replacing a hardcoded string
> allocation and formatting by the use of the kasprintf() helper.
> 
> Fixes: 02e9c290814c ("i40e: debugfs interface")
> Suggested-by: Simon Horman <horms@kernel.org>
> Suggested-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> Suggested-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> Cc: Kunwu Chan <kunwu.chan@hotmail.com>
> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>

Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>

Thanks,
Olek
