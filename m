Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF9DE7C5F3F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 23:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233339AbjJKVoc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 17:44:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233552AbjJKVoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 17:44:30 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB07D9E;
        Wed, 11 Oct 2023 14:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697060668; x=1728596668;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=zEM63VLra8iqwPmei6NC+GfoViAP6rRlq7Vjgd7nUbM=;
  b=mXJxlGaU9TpUAdTV6a8h3+WYK/B/j8DlpwEg9uQvGqa/tfAL7lcoPTY0
   6m2BtQ6CAlaRmp8zZUzzhWBDVc3/jciB/4aPS3mkIimtjvMkR5FmjPrPz
   oUpMYRg9ZoEx9jK0OfZopzXcNtwjyDZo4XhMEs/ZITdLyB6myL4eFVTSm
   gpAXUPXByBPjmIz2mhHCrk8VQGGCty5e4Xy/rph/JBV9IJHzNwXqrdYeS
   uKy57Mg0akWCNG9IQ4B83sSorMU0LwDwWkHq8dRD6eYPfGRuEy2pH0izM
   D5V+b6JOv5vOD29GqulEtsIKDxHXeKMOGyPvGLtuizshZ9zXvk2HUr44S
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="384625654"
X-IronPort-AV: E=Sophos;i="6.03,217,1694761200"; 
   d="scan'208";a="384625654"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 14:44:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="819879167"
X-IronPort-AV: E=Sophos;i="6.03,217,1694761200"; 
   d="scan'208";a="819879167"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Oct 2023 14:44:28 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 11 Oct 2023 14:44:27 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 11 Oct 2023 14:44:26 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 11 Oct 2023 14:44:26 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 11 Oct 2023 14:44:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oeBqtaMZD4ymymyzDOVWkQFEVLtPi5BQiwkLGBcK3BCzZcOwRI+0q88eUYmnC6R+WACCz9nSmNtcxXWS/MICSZ0QhBtViPi1CHhMev3hLhdxqeWNBmvU3nPcl+HloJW3QRcotRxC7yvkvNPBQQv0WGNxCBYsrzFOo6dTcImHHuacmJdks9GWBMqrpjMYGcU68Xgd7ya5v3j4IOzvZKTL1K/sN7A5iToP1uLcX3W86UVPJPeWVRWBikpgPlqDTYwpC+ngA4ZuK1b7xRT01Dk2w5TITzqA4tvwfN0B66bnUy4Pd7L6n5Bk/uAQJtXQ/YQm3w3aAw2A/bkROYAZi38dSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t5rJwKztCjWe4DiWhwZXO1SpP8pn2Tko74a7ds1lppA=;
 b=gK7VuhRiqdUHkD8q7hSpv1j2CTArRs7SB9ZOk17ZvdIvTmFcW6Fs6fmITeHOdPWiEmtPsFu7HaGAXSkdszLxkkPHjXNZlhSRb7mFtyEz/cNppD/T2NUlHibDIROLptwQZ42y1LcDHzuzkIpVvi9iy6wXCkqNenk9AKncIR16/P8EWfsoxIVToeu15yImubeUFXDymYaLJRJ3dm1yVjBNS62iUfEDUJK4lFtMorKBHxh5jCb3Qe77yWkvlzA3TAQ1is96a8b6bW4eIgQwU3Wt2/F/dFVZnnACXa0zmJ+xUms10UR+1cxXOMct4w2kJz0LQezOCSXYAykJxarxdwkT0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ1PR11MB6131.namprd11.prod.outlook.com (2603:10b6:a03:45e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Wed, 11 Oct
 2023 21:44:20 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::acb0:6bd3:58a:c992]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::acb0:6bd3:58a:c992%5]) with mapi id 15.20.6838.040; Wed, 11 Oct 2023
 21:44:20 +0000
Date:   Wed, 11 Oct 2023 14:44:17 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Max Kellermann <max.kellermann@ionos.com>, <linux@roeck-us.net>,
        <joe@perches.com>, <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>
CC:     Max Kellermann <max.kellermann@ionos.com>,
        <workflows@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3] Documentation/process/coding-style.rst: space around
 const
Message-ID: <65271731e25f4_7258329472@dwillia2-xfh.jf.intel.com.notmuch>
References: <20231010125832.1002941-1-max.kellermann@ionos.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231010125832.1002941-1-max.kellermann@ionos.com>
X-ClientProxiedBy: MW4PR04CA0361.namprd04.prod.outlook.com
 (2603:10b6:303:81::6) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ1PR11MB6131:EE_
X-MS-Office365-Filtering-Correlation-Id: 49c46004-50ae-4f2d-273b-08dbcaa339b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fnVBycszZW5NqMGpdfvsC+pcm39f4mWlEco+B/Am1BuKjhDaO7KVBR1+V038z53fW0VWI8qzx0KY2llMhThTUHfgEUKqDVm0L3mXkIfujHgHHkTZkpX8nnkCeP0mTq4Hc6zYZlh+IjzRk9M7mPbs4xNFF1zypYFBP4w+ZhWTPvVOUGYZm3pFAfyrUWvGKGPOSnDtPMgQTrHC/WOhtZCQ/YqHcZCUgSpkGjYHjmOV5pSaRxFwooHuMOfWIaPNIbvA+MbJM6TzjW3zlWo5+SYUSWe6v05vhaqRK37WuPW0oz71Lb6Seb1S4xkXBAxB7bUC8AEt6JJwEAPB191lwdZ52QBv61BBoIEClI8/e0JC8cBOfHE1YNR4tu9sJUyR8QvciHU7Qmqp0LGzISVzMVyhb0ePyr2yF/QV2cLw6Sq44LANptYpsUE7lV55rlpXJy4oDV7sr71BzWXMIyYFMwJmZwDOSg+gITLNyHWPQA8Ekt4YjQMZDhif2Yew+jv5641ZgHwDHARGR5Qqce67AyKWEiWtenar4/XfdpOkYL/Hq7tjjTAVtXyaZOS3f50Y0b3bUVfuePA2vudQuJtC+5Qv0A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(39860400002)(376002)(366004)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(26005)(478600001)(6486002)(966005)(86362001)(83380400001)(6506007)(6666004)(41300700001)(4326008)(8676002)(8936002)(5660300002)(66946007)(316002)(66476007)(66556008)(110136005)(2906002)(6512007)(9686003)(38100700002)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IOt98GPb8d0YrvivXi9uUnWkKvy4tKpDEltlj72rLaEPd/sdTTTLPUUGdJwQ?=
 =?us-ascii?Q?3bHVdehjc1tY2aJk4Do03JcBHWu3LgkyAKOV6GuljBUjppHREaMLtAXzfurh?=
 =?us-ascii?Q?/lnB1oC3iq2iKemQDS89cf8FmRp8zpDpr/dvBKYRu6kGZcC/N9jCdt5kZ6o8?=
 =?us-ascii?Q?Swe4JqFYSDvXB52ol3NK8Fl0tXH5obGtEiAGcaFu3IigoZn10aNZs7M7pD0F?=
 =?us-ascii?Q?HgXoMn4ULBOQROVTRUfQLVibSPR4mIfQ2IjcU9Ccdz/ssPID95VsS+iInSYM?=
 =?us-ascii?Q?fbCem3UXXI13TvY4dXgUQsTzGT2tNXvxTbsn/tkefhRBsYDrxkRxsZodWjK8?=
 =?us-ascii?Q?KMtk6Iprz+skjKjHdXM7MII2GXGr+05LCg2ZUPbwu4PYN7bH2XARoO3kWWRl?=
 =?us-ascii?Q?kn3AQq+U7jQIR3146/fNDZF254+16yuymUNxY92pqy4UX8fAWPGET6SBYTKr?=
 =?us-ascii?Q?idgkw0mU3Fa1FAVdol9NsgM5WENrQpmrN9L5sAK/8NFtvFaVGcZzhsuLuG+U?=
 =?us-ascii?Q?vS1ZCc1D1Adp6WMBZ0nX1lLaa9BjYiQEemzyo0DHTv9VPGiOV2ZXxx+09DBH?=
 =?us-ascii?Q?Z1307B11Q75sMHWXXwJui3Qfa20EUl8r5iI8GsSsiso+1VFT4KAL4POMRjo2?=
 =?us-ascii?Q?vQpyqQwfn+R+ba0WU263PsvwzojraYtntFyQlSILL/7RxCbK+uHPA3jjXi3h?=
 =?us-ascii?Q?w6sQWV0eZinlD/DeMRYApW8pg/hexAQMGJI7xYaliDTJ5ebhMZR+Qlipv6kr?=
 =?us-ascii?Q?auk6OsGqCcaKuQPWBs0IGZcR61qFAa15sR726t1s2Pc1btb3O4q77zLntBrr?=
 =?us-ascii?Q?qYWj+65a0qOTi8rjj4twMn59LJe3rWisrvPW5S/tQfqbFCnlwNi3A/+934d6?=
 =?us-ascii?Q?E2RDsNuudjpqMiI7Y1cE87yY7oxYo/r3us+9iFnCltmNO7xudLt7fxt+CNGX?=
 =?us-ascii?Q?fDOzFlga+4hwXOfXHc5R29reJI1ri4+FJOREqx1VElIYMGU0H0Jus2g6u/VZ?=
 =?us-ascii?Q?zsBHAy8uxbcZzhwa0w6cVRCOBuqUinQ/sDtqvAECJOMGvpX9zUrQP6iWzrev?=
 =?us-ascii?Q?lC2M/s+MmKDVa8IucXJnYt/LvGkRTVLjXiEHHlTmyr01XikgbJIE6j1y1feU?=
 =?us-ascii?Q?C3+ynDL9fNE6vDvysl+I9NejcTBlWMybLEVSRAYrvqFMb8Q+En0olGVnHYdb?=
 =?us-ascii?Q?Z8tVgGFR6DaQiyTCnvZchikHPfVDLKuMot8PMxNCM/6cUB9ZWyRf4MjbWB5Z?=
 =?us-ascii?Q?TatqWqOYObOVXc2ZqIr/ZcK2FwvS5FphGLPJTCgNRGxar3FaD/hobunudz40?=
 =?us-ascii?Q?LbHhHKbxDffsLKZfxBXj6x+Tec/c/B+kcGx4rZCLAWpMdWbCEsH9O5pd3G4Z?=
 =?us-ascii?Q?njUOg7XNJQXwodDioTd1Hg6m0hY7x+meAMtXhWYOg/DW15Y2YrK70Eoltze5?=
 =?us-ascii?Q?67L+FXhv3DLW6sURmDKfo13gpTlAa3P7vAOkLIYWegI2zaDmSmYRSoLV252H?=
 =?us-ascii?Q?9jztBiKayya9gkkJM7qOcqQ9igrU4naXfS6Id9bwjHuoytrbWUq4QiQIxFAa?=
 =?us-ascii?Q?NDyJ8np99LJhr8kjqL8gRHkyqjzcyWt4axD7UCgl+fzd+rBKm0wLUd6TB/K7?=
 =?us-ascii?Q?Sg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 49c46004-50ae-4f2d-273b-08dbcaa339b5
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 21:44:20.1711
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vK6S0W4L74i9F0EmCgDw5kQUy/XLJqdif6VhRErl4bc0TCpg0yY4jRDiWNl4KGzaSMXGQq85Pf+y//Tf2zUXKYEsoA67dA6dXF03xVFlmUE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6131
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Max Kellermann wrote:
> There are currently no rules on the placement of "const", but a recent
> code submission revealed that there is clearly a preference for spaces
> around it.
> 
> checkpatch.pl has no check at all for this; though it does sometimes
> complain, but only because it erroneously thinks that the "*" (on
> local variables) is an unary dereference operator, not a pointer type.
> 
> Current coding style for const pointers-to-pointers:
> 
>  "*const*": 2 occurrences
>  "* const*": 3
>  "*const *": 182
>  "* const *": 681
> 
> Just const pointers:
> 
>  "*const": 2833 occurrences
>  "* const": 16615
> 
> Link: https://lore.kernel.org/r/264fa39d-aed6-4a54-a085-107997078f8d@roeck-us.net/
> Link: https://lore.kernel.org/r/f511170fe61d7e7214a3a062661cf4103980dad6.camel@perches.com/
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
> ---
> V1 -> V2: removed "volatile" on gregkh's request.
> V2 -> V3: moved patch changelog below the "---" line
> ---
>  Documentation/process/coding-style.rst | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/Documentation/process/coding-style.rst b/Documentation/process/coding-style.rst
> index 6db37a46d305..71d62d81e506 100644
> --- a/Documentation/process/coding-style.rst
> +++ b/Documentation/process/coding-style.rst
> @@ -271,6 +271,17 @@ adjacent to the type name.  Examples:
>  	unsigned long long memparse(char *ptr, char **retptr);
>  	char *match_strdup(substring_t *s);
>  
> +Use space around the ``const`` keyword (except when adjacent to
> +parentheses).  Example:
> +
> +.. code-block:: c
> +
> +	const void *a;
> +	void * const b;
> +	void ** const c;
> +	void * const * const d;
> +	int strcmp(const char *a, const char *b);
> +
>  Use one space around (on each side of) most binary and ternary operators,
>  such as any of these::

I notice that clang-format reflows that example to:

     const void *a;
     void *const b;
     void **const c;
     void *const *const d;
     int strcmp(const char *a, const char *b);

...but someone more clang-format savvy than me would need to propose the
changes to the kernel's .clang-format template to match the style
suggestion.
