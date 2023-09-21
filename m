Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 625C17AA54D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 00:55:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbjIUWz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 18:55:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbjIUWzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 18:55:22 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E058919E;
        Thu, 21 Sep 2023 15:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695336906; x=1726872906;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TXj4u6zPP3DzS1n1mKR1kqzmHODoPUKYfklWOe8q6NA=;
  b=Om3XP2BKOK+wEtG8NBe0ndSq/EIhZbLZBwDqifeDVRMsSX8WBb5/BsNy
   9/GPLAdQWSjl1V/ugbhGitUrcLbujlPeZgtcAmYIXl80l90qnkw+o+MJg
   kal0U0KrVhcUGMHdb8qgvDmtM+TmOJixDraXAPMVcOl7RRYwVEkzy/GMf
   Q1cX5bieSTKrGVCpQf+1ryn5BXcLlFmh/3xHFUH7en2aqJSHZgmXQAOB1
   +o3mK4zCBgx5mMKTGSTzVyHyFfASkdjfRglLurXPW1cKPpcTHKV2dprIu
   PVCU2pJIKZA53B/YN6Ir18SZ5zkrKF+YymLDVSG6ww5i8aMdekA14u1w1
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="383440361"
X-IronPort-AV: E=Sophos;i="6.03,166,1694761200"; 
   d="scan'208";a="383440361"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 15:55:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="920922890"
X-IronPort-AV: E=Sophos;i="6.03,166,1694761200"; 
   d="scan'208";a="920922890"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Sep 2023 15:55:06 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 21 Sep 2023 15:55:05 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 21 Sep 2023 15:55:05 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 21 Sep 2023 15:55:05 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 21 Sep 2023 15:55:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=devCU4OuQ7UeaXJIMrJuMk2bEvQw7SCtpQpqu2ISfCuwkvb56KgJVFJFVwQ1U7ipXAywIwZDDJNGKC7J8NXnfhoGuRi9CTn5FAPXRKYJHqFmJdtCoeRMZ3Tur3voLLzKHUNvypkexjbXC/cspOWnAWAB+dps/D3byXDMKbJvs2K28xUVJ2cpEp/tUsGf1FKepjMjrSXHjfoIFkkJraigrzFRfkwXm4AB/hLMtg+98s8y3feBFcJB/d/DZk8JI+zUyOUh2Qsh3Ivc8gftZbGEzUT7h+aI/uAD9LItaAR1fbxhGVlwJXQ/RyM+92ndSFAAn7d1BXF4oiB0YUljNix4JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F9sIoN1tlloLdL9cWwjbv8+KH7sYmdEZjbg2pJ+9/N4=;
 b=YxOsmlX47BX72uW5JgUFTIGCVavnNlXN1MuYTYYtoa0hDCb6KhlsrbBu/K90OalhcJmWXjo+Mt2gOVqDbrkhgizx4af6At2c6lsGXr4mpySESuLlIvCBMVm1bJhQDYrG9xdqU3giDxYZM1Zzl7ktblkvNHTOezlVmY5XUxO8y8FqfLbHzXltNw6l8a+1614aZjukUqe3sCX+iqwuEumdjUv+SR9J6nsSlE1nvEyPrLTO+w3IfbetEdb2ryiz7EX6eW8LndrOjht7QQUywTv1lyruMu5Ew8D/5/PJqQaLU/cx9vnik973WikA/Ocmtrsc8FiTv4x/NFU0zkqk8dfIYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by SA1PR11MB8325.namprd11.prod.outlook.com (2603:10b6:806:38c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.23; Thu, 21 Sep
 2023 22:55:02 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::e9ca:a5a7:ada1:6ee8]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::e9ca:a5a7:ada1:6ee8%5]) with mapi id 15.20.6813.017; Thu, 21 Sep 2023
 22:55:02 +0000
Message-ID: <bfe384c1-2d66-dc45-5758-87e04f1c8914@intel.com>
Date:   Thu, 21 Sep 2023 15:54:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.13.0
Subject: Re: [PATCH 1/7] cxl/trace: Fix improper SPDX comment style for header
 file
To:     Jeongtae Park <jtp.park@samsung.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Fan Ni <fan.ni@samsung.com>, <linux-cxl@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kyungsan Kim <ks0204.kim@samsung.com>,
        "Wonjae Lee" <wj28.lee@samsung.com>,
        Hojin Nam <hj96.nam@samsung.com>,
        Junhyeok Im <junhyeok.im@samsung.com>,
        Jehoon Park <jehoon.park@samsung.com>,
        "Jeongtae Park" <jeongtae.park@gmail.com>
References: <20230921025110.3717583-1-jtp.park@samsung.com>
 <CGME20230921024831epcas2p2580ed6d9ca4e6ade29e7fa6a5bafa881@epcas2p2.samsung.com>
 <20230921025110.3717583-2-jtp.park@samsung.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230921025110.3717583-2-jtp.park@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR04CA0013.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::23) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|SA1PR11MB8325:EE_
X-MS-Office365-Filtering-Correlation-Id: 928e15bc-0a16-4684-3af8-08dbbaf5c9c5
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RKhtC1dzUBfLK3+CM1226g/A6sJ4zXS5atIB/J2AJyF40o2mzsqAqinQiao6STkJ+LQVW6vfvjfETsNBkrdEeKGwoViHFivK2ZTAvIt+LSLTxRT+m1UEP8V2E6ZtAjc0iL1TI/Lh95NJzZBUwSZi2i79BcGgssagYTMB1uQ/XtU7CbjK929aXqf17PF0koNQip5+U950bqCKaR5Oz/VPkKqEcGkR4MUiZbLrDDYgNZKsCT6fo+bvC8arw7IljbOm74V/Wnt3WweJJzBttNlfqcTT+iKie0ifICz1QyhbIMqR+GUN4fDbByRu7CnDOTNzRmvJ5u5/fnQUO6sAzdU/nNoGZA81v5uYij7N2zhwshu0CRj85Nt6d3lSyylghdytonaSsUtgCpP48sI7GqFqU3tr4HZc3rabZaBOOjHQgOk0YrB0Zt5I5h7KBgxdS0YWsubiz9WqbpMvyrR2PrhQeVke9axPL7HhY5aPeWg05f1+CF1NKZTdXgNsZzEoc1DaLSO3TRo9Nbgs/vGW29E8dm1QeNnmuectP1+kKhBXqjO0jo57jhB4sE6lWwRZ+VFN6eqf48X/bBkiJ1l6o1Db5tW6ZdnZkFNZ4mNYxKJpz8ZgvYBpWxkzZWvx+ddM45dg5hng72i+E5p4gVKS0dRd5Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(136003)(396003)(366004)(1800799009)(451199024)(186009)(31686004)(6506007)(6486002)(6666004)(53546011)(5660300002)(31696002)(36756003)(38100700002)(86362001)(2906002)(41300700001)(8936002)(316002)(83380400001)(478600001)(6512007)(8676002)(66476007)(4326008)(110136005)(2616005)(7416002)(82960400001)(26005)(44832011)(66556008)(54906003)(4744005)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MGlldGIvandlRGovTkxwNXBlMHVqTW5Sb1BJTFBvZ3FiRHg5WDhSSnZxcGMz?=
 =?utf-8?B?V2YzV1Z5VmlHR05iYmF0ZFNiNWFrMnpaQ0pieGJDak1zcnJyQTZ4TDYxWmd0?=
 =?utf-8?B?SVRaKzkxV2hvdjBib1BDV1lZakttNUYrRktEQkhWbk9CMXpOcDdaK2c1MVQ2?=
 =?utf-8?B?OE5TR0ZnTmVQYjRrR215SndqUmRlLzRER09Mb0cxNTRkdkJBaTI4OFQyVXE1?=
 =?utf-8?B?YmM3L2VRQUg2eUtjalRWWXpMdmcybmFlOCt6MGxIN0d1WmxDQ2tEL2FBanZP?=
 =?utf-8?B?ZEw2L1Mvb2NGWHFseVJlUmZ6c3EySi96M0xNbVRYMXZqRlBlNEUzM0FzRFp2?=
 =?utf-8?B?L1VwMERiUHoxWWhVdTNSN1RUa25QTCt4WTdyeENQa253SWFEbmlEN0RoamlZ?=
 =?utf-8?B?Wmw3dE1VZUNlZFJpZUFGWlBYbFZmS2VLcTEzcG5kbkk3cDBaRk83YmpjV3BF?=
 =?utf-8?B?eUxDWTZIWmRLSkRpOGV2RUwyQ3JwVzBHQ2pHbGtVY1NKMWlxWTVFZG94alFS?=
 =?utf-8?B?TVFXQ3A5WjVUV3Y4dkdRMXZNL1J3RStnVDZZbnkyaVlCc09UZ1pRU2lIV0ZU?=
 =?utf-8?B?WHRjTVJzZG9aL1JhL094TzZEUDlyT25JSElSQ0xFWjZPVE1Hays2cmlnc3BE?=
 =?utf-8?B?eGRzTnovcnIyaDhRL0xTam9VMVlmUGM3OXAxNHMySUdKeGNPcW5JRG5lZExN?=
 =?utf-8?B?MXlLenNURTlKb01CYVkrVzJtazU2akFZRmRCMlRCVXJKemQ4bW9RSGd0RkNs?=
 =?utf-8?B?cGpuQmU0ZitlMThzYit5MjBTNnZ6SDh3S3NXMFltUEFuck1IUkZaNk5CaUNI?=
 =?utf-8?B?bGZFMWw3OWpLb0hxQ1pGYm5tN3NxNnNLUkVmTUtOUnI5UTd6bW1DT1l5Tzll?=
 =?utf-8?B?cUtsREdzbkM3eW1SNDU4a01QaUp2MGNpbFNQZ1lvMjFyYXhVUVlqL1pQR0F3?=
 =?utf-8?B?ZWNnTjI3bnJhQ0N1RzQxTS9yS0twSlczRlpwVnRic0JnV0xCQ2I0TXl4MmdL?=
 =?utf-8?B?cms5eW9ORVllU3NNWUlhNGR2UDh3UTB0Vjc0M2ZvL2RSc0EvS0EyVHNFc0hu?=
 =?utf-8?B?QW1WUnhNNWEyM3NtTDlsMWlHSWx6MEV1dXVLbFJremdicXA3blhwUlpaeW9B?=
 =?utf-8?B?Y2tzUHFqNi84L3NSZ0VXTFNwckUrM2VUZlhJNExPeCt4ZEtuQUtaMkNiemJa?=
 =?utf-8?B?NmRWdGk0bU0zQ0wyd25wNTJ1aVRjckFXMzhDYmxBWVZuaGlsc1BpY3NBZ0Zn?=
 =?utf-8?B?ZmFLa2hOUURjUU9OVXh6Vk9zVjBSWmNqc1A4Z2lKMnB5QXVOWHZJN2x2MGRQ?=
 =?utf-8?B?dXpRNFhSTGJDQ0tGTHFVR1B4L3JWTWZuZFFKY3hUQlN6VWVUeDM5NFhLcXQr?=
 =?utf-8?B?Qi84d3FlV3libW94dmg4OGNKSDFaVFZBOGM5Y000RFVOc1hNMmtRTFFEbmJS?=
 =?utf-8?B?M0kxcVhWRnJSeHpOK0hDeGRocWljQTFMd0YxTjJNTnM4Qzh1ZEswVVR6aUFF?=
 =?utf-8?B?N1hjTWxrWW5KWkpzeWRxUEx1Q2dGNktEeWtWMUlwL3JxWDdvUmt2R1dCSlJ0?=
 =?utf-8?B?dlVJdVJ4ZE4rRlMvWWpxOU5TaXVKcjZuNFppMkJ4UFNub0hVWTFXcjc5THJ4?=
 =?utf-8?B?dlVNVndiMUdyekRyODlzTW42aHdZQngvaldDeitrTEkvZzlnQms3clQyeHJa?=
 =?utf-8?B?WjZNcE9ZVnF3U1B3K3NRWTlZSm5IbkVJamJHK0ZPTHRrYjhKa0FTY01ydS82?=
 =?utf-8?B?dHczS05BWmFmeXErTHdLZEtNWDBiZWZCa2RkeXowakRzR3k4Z3ZXQ3ZXSHlQ?=
 =?utf-8?B?ZUl2aC9LeUJYckJhUi9kbU5VVEl0RzlIREpqYjZyK1ZWRjlqTmRxVjd6eTZ5?=
 =?utf-8?B?Qkc0WE96MDdHWm5abVA2ZzI0REdXaWdsRXBHNVppSlNLT1lPZE11aXNPbjBP?=
 =?utf-8?B?U3JlSkJoWVNtTmw2bzdUNENKTkF3RjFZNEwyUm1HSHBUSWdpTzNMSk9CSnpF?=
 =?utf-8?B?RjM2c1BvVE5WTHNrN3FYYTNuY2Y4Tmd6Y1NncWk2WllzWmNXdE5mc2RPaXFM?=
 =?utf-8?B?R3k2RWNwS1JWcjlPOWRTTzdpMTJYWW9relFFK08zZnRZWGw5Z0w2dG41cmwr?=
 =?utf-8?Q?u+1iQRwd/PBrDkSXIYwA+p8mX?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 928e15bc-0a16-4684-3af8-08dbbaf5c9c5
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2023 22:55:02.0407
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nh0GSAY1/TLKDoYPj6S9WF8FyF6XIqcYKFNgPVR0h9aOuZ6XUoFJopT1oyYWVN8XOQKE52nTGJqGUCmGk/BK6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8325
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/20/23 19:51, Jeongtae Park wrote:
> The SPDX license identifier for C header have to be added
> in form of a C-like comment.
> 
> Signed-off-by: Jeongtae Park <jtp.park@samsung.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/cxl/core/trace.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
> index a0b5819bc70b..7aee7fb008a5 100644
> --- a/drivers/cxl/core/trace.h
> +++ b/drivers/cxl/core/trace.h
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0
> +/* SPDX-License-Identifier: GPL-2.0 */
>  /* Copyright(c) 2022 Intel Corporation. All rights reserved. */
>  #undef TRACE_SYSTEM
>  #define TRACE_SYSTEM cxl
