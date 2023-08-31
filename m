Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7E278EE02
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 15:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346319AbjHaNC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 09:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236406AbjHaNC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 09:02:57 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30839E50;
        Thu, 31 Aug 2023 06:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693486972; x=1725022972;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=QD31K2NQnvPBTh0DMosr9bSDS4AW97TEeLmIzqSmFYo=;
  b=g6aafPv04e+lBd2VU3UMvpljf6ohxuMsBDIIXYKfaY7YZGoJMhctVugA
   bqT5C/SXiwOfuPd9M/uxVGQTGD7xeGfiGHWqrwjqZPSu8tcHqwPjBuVId
   SYr+fzpHmzyryScHdTOqhtcotztDfcvJYmkX0sb4E0fV06cUQy+V8KOgW
   NO1oSct1RfvWZixh9BblijH5X3+wJGO3lAIfvdIN64yaEl56NMUfTIzUH
   8azD3eUJDVpqe9OdsEIxwofMbJvJPe/ttxD9LYOmM5J68KuhB9F3HXN8w
   LLrV4T250KgST1wANbG7+ti+nGwM4GQclgw25H+4WExtiCpRAJ0CCJ3bc
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="374846683"
X-IronPort-AV: E=Sophos;i="6.02,216,1688454000"; 
   d="scan'208";a="374846683"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 06:02:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="1070269487"
X-IronPort-AV: E=Sophos;i="6.02,216,1688454000"; 
   d="scan'208";a="1070269487"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Aug 2023 06:02:36 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 31 Aug 2023 06:02:35 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 31 Aug 2023 06:02:35 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.104)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 31 Aug 2023 06:02:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gtJMu1flSb3j52speDHmNBlh+qcbT6PepsQrNIUrZosQw3Em0jqPbw9vdCpXUa8zOZJJHfeNdjGHuT0aibusyWNF7dQJqyd3fdCxeQ1AbEgSml4tHXwhDRvg1JfholgKZ7Zs4JbfD3ScCcAQIsWyZVyT0cXYbQZgFlCPSgU0W0a8vfHAoKp9GJUOYrpEUyuzgZy5rHQu0E3wQDwuA5bD0x5UGS/LGWgeshgEj3xLc9M1bnHpvq7TZsnndpO0YTTwMrhizHNtdxw81VJuJKBTcx9BwQYeqWS4EQczHcpVGbNXbjUmuSCWgrLPtlpLdvIbopjY8nivmhLN5Z4j6QSlkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yRcyTaN2DalIbgco+C7xk9xwIBD7dLIboqJQcGVKHUo=;
 b=Pk5hKhS4GHy2ci7PHLqFpHV+qlZD6jwSziA8VAnsWq9++30iWz3sL2wQaiRpO1kXbP7HJ0pfTlivkulNPagLXcskaqhNd3IAm6RyL1vLVcri6x6P1T1u1Nl3Xh9Qstdecj9CrU1Z5xVD0Rsiatk+A/5tXXKQ0LqKU6+wiOp6oBo29X4OGjb/d15b5K7Whxh75ti+4LnHlMf8rciqbeNPoFVZ5EPXSfvgZozG957PlelYbX126GjoY8H2//GqE5F56FG9kt07Vd/2EFkNZedWugmhx1G3O/LV3w7eLYwNejIHdVWCp/65LbjOhOfZkFidlBSIt6m35Z/fQ5g/ExpX1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by SJ2PR11MB7517.namprd11.prod.outlook.com (2603:10b6:a03:4cb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.22; Thu, 31 Aug
 2023 13:02:26 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::8824:ea30:b0ab:f107]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::8824:ea30:b0ab:f107%4]) with mapi id 15.20.6745.020; Thu, 31 Aug 2023
 13:02:26 +0000
Date:   Thu, 31 Aug 2023 15:02:16 +0200
From:   Maciej =?utf-8?Q?Wiecz=C3=B3r-Retman?= 
        <maciej.wieczor-retman@intel.com>
To:     "Luck, Tony" <tony.luck@intel.com>
CC:     "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        Peter Newman <peternewman@google.com>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        "Babu Moger" <babu.moger@amd.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: Re: [PATCH v5 1/8] x86/resctrl: Prepare for new domain scope
Message-ID: <4vvfwrtbwcxjx35lfogoiekuq77g5hqxcgskjt6dd6pf7ehg2v@edczy6764cyz>
References: <20230722190740.326190-1-tony.luck@intel.com>
 <20230829234426.64421-1-tony.luck@intel.com>
 <20230829234426.64421-2-tony.luck@intel.com>
 <bssbtlnjbytqoraiamg7igvawtmlnimzthud5mlacbmjotivhj@hrrabdpmkbjx>
 <SJ1PR11MB6083A9F0B30A6009BF00235EFCE6A@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SJ1PR11MB6083A9F0B30A6009BF00235EFCE6A@SJ1PR11MB6083.namprd11.prod.outlook.com>
X-ClientProxiedBy: FR0P281CA0110.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::6) To MN0PR11MB6231.namprd11.prod.outlook.com
 (2603:10b6:208:3c4::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6231:EE_|SJ2PR11MB7517:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ff6067b-34fd-4ec2-e71f-08dbaa22860e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q9sKQGWJ41XC/GJHXRAc/GpH9SV2OeICwnKxug3B6AH/J4WJo2+RIKHdESwSFX8YALGWMjLPVXit29CxpC8F4du2ckvlPtcSySIsp+5wDvcYyhEHQkccUgNz3QwhsDBnLfcHb4ACdIia3lgqgrwBtfe9X7BOAkYhLKIghkJyJbfoJ10HTshI0Qd9AB3dYRy+chuip91Z+ijBgWbjFVZZpNYUoeKSyebJcYUGaMGq+JY1JL94CF63j6uzOFhgZvtYd1JNjRab/xbghwy851YYldwz9w4btBFZYAfFirvxcBwL5JP39JObmCZsLIBmAM3Jv2TJAx/W9lrWMGzNnDKQJ/W1WW/qdcLadmx3/VmHkxlG904yHlTr1FynO6HGQ7iURT6Gjcd9xx8uNhowpAEe+tuTVFQc0gmNXC3u9XE+7Tjx515G0Z1gNzBhT/2dKKbkve7MefSsla6NMUNGLRmyswO2vyNm5Xw52tssHXO9CsZ3LupEBUHdrgo/2Om307dOcj6cxRlZbLzYAmI1BPZZrSIO7G0EpevwD2+afYImOMmT7uWJY2TaIZCV/qy+rzD7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(366004)(376002)(39860400002)(346002)(136003)(186009)(1800799009)(451199024)(66574015)(33716001)(41300700001)(38100700002)(26005)(66556008)(66476007)(66946007)(83380400001)(54906003)(316002)(6636002)(82960400001)(478600001)(6666004)(2906002)(53546011)(5660300002)(86362001)(9686003)(6512007)(8936002)(7416002)(8676002)(6862004)(6506007)(6486002)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?BDzVff6YCQ0v8mbjgLSww3zch4YO+BQp8bUbuFEcE1WyXEQsRs71Rq1Eq7?=
 =?iso-8859-1?Q?ULdvERKR3eWDbk2yBgVnlMrTyqhu7sGmA0yVlOyj5ocHVg+9+xphOz/8rj?=
 =?iso-8859-1?Q?a2aF1ZwfYjcxu7r7zIp0WtJCcJXsejsrOTbQzPqh90iqk6umnbh1APLYKz?=
 =?iso-8859-1?Q?oewvltn51CYWoOtUKsZEowGWhlo68HHSvNoXkUeCsj9rgcGCEdWAG4Q5ex?=
 =?iso-8859-1?Q?vDYL6K8oAiiaWRfaX5fvT4PtPI74MVfbZtG5iW8ZrR7wAOqj8uCg/D3xN5?=
 =?iso-8859-1?Q?1oWZd96gyKqhjJNB7dOxiO8eo6B7S83tH0benf853iuUFdPjQOtTGesqZr?=
 =?iso-8859-1?Q?RMTZ142bnqDg57LzuJH3q5JsleASVeenyc48i3omyVpOc3GQoRjqR7KfU8?=
 =?iso-8859-1?Q?JL06F8wEc1pk/VjoLRi2DTxK80XyTL3tsOZMLhBo5hBl1hA87bFAlPZt5i?=
 =?iso-8859-1?Q?n0VluMnEy/ZEggO/7YAG1/wED0dTopZutrwOnabBpjrhaXB81vt4piw7+v?=
 =?iso-8859-1?Q?i1NCK1JPXWu7Fiqumik+xErekwEy7wIHZIXvF/6ayMS7cwhYWi/bk6ml6G?=
 =?iso-8859-1?Q?10efd74nqiZR8WojrRe6TfIYyDrZ7NufeOLR/Iax/7O6WpghWaf+UrYZVL?=
 =?iso-8859-1?Q?//2jhsRLaNyffTW35dt28QlQV6+l6IsTShUYHDR5ayLxZaaBImEUm7RWep?=
 =?iso-8859-1?Q?WeZJC5d3zw0o0xMrBj8Z+7S2Q2VyH68IDB8dBB2vmWDIUxDXf8dHfB5UAd?=
 =?iso-8859-1?Q?52iKqXa0qw9kacXXaS/BA8Nor+WN8KCoUBm/UOFT5T18+6ZObhd1e6b9d5?=
 =?iso-8859-1?Q?3zYnkVaorfYjQqRRZUBQmMPbt8PiuMl3UOMWBKT6UxgGOJpdyNvTkX9Dyn?=
 =?iso-8859-1?Q?SoI57OJGUpS1dzL77+WIucI0YJXHLgADAzn8IioaXF0lPsJ4Cvwg6jxyVj?=
 =?iso-8859-1?Q?KXie/P26eOd/oY7Kxq8syqSd6W9V0//vYU0xAvZpNMJ6hlWp94bgu/bS+9?=
 =?iso-8859-1?Q?IlAzgAbeUQ2oqUHJF1tan4/pbCgbOTnvbPHHIZCm2vcrn/kaMt1aOAXtiE?=
 =?iso-8859-1?Q?M8YfaYAMwIAG8ScHh8xWBmTf56WX8C6RFyE0jhcRq1hp1wHTF1mZMg0+2m?=
 =?iso-8859-1?Q?s29MYN8RjY9pqt5hCk8PbqL3hRyfVY76IRbHY3OoXu3sk1hpgFHuIqekfl?=
 =?iso-8859-1?Q?msNkMQ9CUUqkF/aKWY9L/NyptoUauz3jaIooaIfro0JNo5GfvJF+UbyLSx?=
 =?iso-8859-1?Q?Fs/2fK1Lcsa39pzdL3bQPvSxUkH5uTyPA4efy12uG0Dy6ib9iKaqLfsZNS?=
 =?iso-8859-1?Q?CvEJVlqRUKKBVRlKFyU0aXuJXNMYetgjMj7N4rruegZgazU+OKNNedM8Pl?=
 =?iso-8859-1?Q?m16oDl3sPgBmd8UKar410x4EFJcfDN9slH/ZGtq4JEcKTQW3PDYbPUeSrt?=
 =?iso-8859-1?Q?0Msg4I5P7poWnSqRD0XXJLURDx4sA9bD3UtcSXBv3UWUZMLkZtSE6etwD2?=
 =?iso-8859-1?Q?KAqvmsLD2l4x2u5kk8rCNALCpw7SzRYgdzAu7oUa7/YNKwwKXlwtAgX4of?=
 =?iso-8859-1?Q?vCoEFZDdjo3jumHg8YhwwqSH6iRGEcn8nwVJt/8gpS6oETN8NRbqVd0fOz?=
 =?iso-8859-1?Q?fFG6Di5gwr6bn/VDYSamdzyC20uOZqdsopzgfmywqU5opmGQ9AKYG5zu/4?=
 =?iso-8859-1?Q?DZG3KkQNV4pFRn+pJTI=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ff6067b-34fd-4ec2-e71f-08dbaa22860e
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 13:02:26.0809
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eBDiXUl1bNHwwtVMu0O8KNza5ya3Dxax17XgU/H8GAqRtrP0MvLQVJ9nDdm4yFYEsRT68PJRIUua9bpKfcW0jAsr1J4FwwhcZ7oX/BX5Dkg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7517
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-08-30 at 14:11:14 +0000, Luck, Tony wrote:
>> >+static int get_domain_id_from_scope(int cpu, enum resctrl_scope scope)
>> >+{
>> >+    switch (scope) {
>> >+    case RESCTRL_L3_CACHE:
>> >+            return get_cpu_cacheinfo_id(cpu, 3);
>> >+    case RESCTRL_L2_CACHE:
>> >+            return get_cpu_cacheinfo_id(cpu, 2);
>> >+    default:
>> >+            WARN_ON_ONCE(1);
>> >+            break;
>> >+    }
>> >+
>> >+    return -1;
>> >+}
>>
>> Is there some reason the "return -1" is outside of the default switch
>> case?
>>
>> Other switch statements in this patch do have returns inside the default
>> case, is this one different in some way?
>
>I've sometimes had compilers complain about code written:
>
>static int get_domain_id_from_scope(int cpu, enum resctrl_scope scope)
>{
>        switch (scope) {
>        case RESCTRL_L3_CACHE:
>                return get_cpu_cacheinfo_id(cpu, 3);
>        case RESCTRL_L2_CACHE:
>                return get_cpu_cacheinfo_id(cpu, 2);
>        default:
>                WARN_ON_ONCE(1);
>                return -1;
>        }
>}
>
>because they failed to notice that every path in the switch does a "return and they
>issue a warning that the function has no return value because they don't realize
>that the end of the function can't be reached.
>
>So it's defensive programming against possible complier issues.

I recall getting that error somewhere while playing around with a
language server protocol for neovim a while ago but I tried to cause
it today with gcc and clang and with some different flags and coulnd't.
Are there some particular compilers or compiler flags that trigger
that?

-- 
Kind regards
Maciej Wieczór-Retman
