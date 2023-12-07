Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A99B8092AA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 21:46:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbjLGUqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 15:46:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjLGUqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 15:46:34 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E814A1715
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 12:46:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701982000; x=1733518000;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=V7nIAQ6zekgPb1NUoIXvuBPd7zdO5mhFKbkzWD2cr7I=;
  b=grqDCngYjzg3aVRCPfYDajple1EfEpyiKJsUisCEmss+065c64/xb9j5
   1OVC7u6m2yFWD2OI4WqnEtFo9ekdkDl2QbO1f0x8PKgkrJMHYW1iH1Xt6
   RrxoOFz+hjekm03Bzzflb56mtf3XzJR0x/N4itNMuKg/se43+gllfIxfl
   pve7kwzD1rtb35+zAWzqNBeo9jjfKAinP+YJduCluN/u83EdDHi1yehr/
   vNLA9tRowAZfGN79O05e56Si6MTKUrlEnReqlPwZgMBtyT8kfdVHNirce
   1VYo8DbQvs3MDGpOFtCsLzyhKVP3nLyThrLzqHSTrXABuDOZf3rkBePNN
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="373804690"
X-IronPort-AV: E=Sophos;i="6.04,258,1695711600"; 
   d="scan'208";a="373804690"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 12:46:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="800863704"
X-IronPort-AV: E=Sophos;i="6.04,258,1695711600"; 
   d="scan'208";a="800863704"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Dec 2023 12:46:40 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Dec 2023 12:46:40 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 7 Dec 2023 12:46:40 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 7 Dec 2023 12:46:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L0faDp21d8umdfn9EhgX5pTP26d9o+u0/nIdouEEhCP1iP3YcUUNcx8Js/5MmH0tKRg/DCTe1l0BeJ6aScMhOMCVt24xWjcKOf4+YaIq9zLvLvMM11bUYL1kZtIQzqsD2gKlJY02MjMnHYXRm4dzXpq3g5jGMnyt61C8U+2AZ/s+XaxQOYID0OA3lYVdL1TzE9cTU8U9Zrvc4q1xaV0R/d/INIXweZriWyeA0ydE/V1eMKZY/n69+EnYNf412Kl9bjkNWST8KIOkHHQiWn2/qjTTTElngFnSCc4e3aKQunssjGPCdh+7b3MrhN7RIJGgAkvDXehpwI3f6VE8EdzU3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OnUfVHARiA7ACY4wJftlN8gcAC+FzCYmePkfpG2sSWc=;
 b=I2joGfBM+h4nYQJOST2S1fEOYvs/wd6ZXPn4m8nVYDhucUorLSBaJS/pL69Q8gaVOx2F/PLAphUYSH+7MVRCZsYVgFpPkgFzDMbF50yNJ1qK5ZS8ozVDmophcL1Usg9c60NKxjzkKbw1IVLEyTCojWA7Dc4inJtnon+F+DKZFjbVdj7s3mSmuKfRVqsZYKj4XsxCJ7yR9P5NfbTKtlqF8UGVtERJqYLSvcQe9T+4t0OFt9REDZv1WZzM9sIH9ysjdTxrB9aeqgH+e7rYWwQkpbl5bUhslQovol7h1TflXs0k6t4iEeMMtfBym/qFcnHusZeje6/q+vQGLz5obnZj1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by CH3PR11MB7843.namprd11.prod.outlook.com (2603:10b6:610:124::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.25; Thu, 7 Dec
 2023 20:46:37 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::da91:dbe5:857c:fa9c]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::da91:dbe5:857c:fa9c%4]) with mapi id 15.20.7046.034; Thu, 7 Dec 2023
 20:46:37 +0000
Date:   Thu, 7 Dec 2023 12:46:34 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dave Jiang <dave.jiang@intel.com>,
        Dinghao Liu <dinghao.liu@zju.edu.cn>
CC:     Vishal Verma <vishal.l.verma@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>, <nvdimm@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nvdimm-btt: fix a potential memleak in btt_freelist_init
Message-ID: <65722f2a94d68_1c7b6229452@iweiny-mobl.notmuch>
References: <20231207034332.24107-1-dinghao.liu@zju.edu.cn>
 <23a91617-4562-4399-a8c6-df2f3f28c7a9@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <23a91617-4562-4399-a8c6-df2f3f28c7a9@intel.com>
X-ClientProxiedBy: MW4PR03CA0053.namprd03.prod.outlook.com
 (2603:10b6:303:8e::28) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|CH3PR11MB7843:EE_
X-MS-Office365-Filtering-Correlation-Id: b044083f-d1cb-498d-8082-08dbf7659b67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 57N3y7HWQ8V6npKf1HZAgKfFNDKRUhxhARKB8m5YW23F5nZ1okUZ5xm2W0yafTfyKDA8G7e2RD2OWWHb2VUQYPUu8s4pZlQ/3B0GoTU9ibCybNFWWsZa2UjzvoZj5s5LyXl2H+BDLntoRZdVFkeREOpUVyNGVh91nmnNhkY4jnTLkVdI13MoUwv8cESMycrCrVj++B3UmRBlgQB9SyvnVtNUaicYi7/RGEFiRbcGp6gqWUiTNJ6tDEu8quwvmZuE//qw2ykIsbvQmG0qbTlKJqP67iD9X1fTdX45vEJAXRH5vBkIpYthSz10FJWstRtYlBkB1TRDNE02sPkI8jmum0gPavi0GAWgMpjewn9sQuhlwf1GNHQyCfh995BTZ8soS4uuZVt2RAF3eBgZ4zs//ANxVN676k2fvVURwm2DlcbNw020bIuvZZQoBLgp3XGaFZomCezseuGHPJMmvFlTQIsd3d+imr5V+XN7w7bDNn06x9vUA7CLi/YJthxWjvurqc9l7rINE5G2WJG8ZUrWxoazmCbpO34A3yspDUJbThQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(366004)(136003)(396003)(346002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(38100700002)(6666004)(478600001)(966005)(6486002)(66946007)(82960400001)(83380400001)(6506007)(53546011)(6512007)(9686003)(2906002)(8676002)(4326008)(8936002)(86362001)(5660300002)(44832011)(41300700001)(66556008)(66476007)(54906003)(110136005)(316002)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?E/ohY5pOSTE3uwFCjrrQ1bww5KD1P3WRY+dG+UNhQdqo56mapxfq5AcRghdY?=
 =?us-ascii?Q?tsm3d9yKkjmFFq0fAn03LKc0Xn6o+QeyHu8PqhPVt11+FgVBBSaAVeT3FKs6?=
 =?us-ascii?Q?4DaEEsuR5jL8ogdAe0R5op35+f4Arbjf7I6RkRp46clOdKCM6yVSqJewV//U?=
 =?us-ascii?Q?U3goN4ZQWQdd3gYZLex+SyI8KusnIK47IqH9iioDXmTopaAMv18IAG0gSxAP?=
 =?us-ascii?Q?Hj6rLInB+iE8GnsbKBOIcqeoHrOdVkm14lZHR2PFt9X4/86Y0K8PjSx/zfIL?=
 =?us-ascii?Q?fAXgFIYlCvSbalNk9nPdwtm4Net1LTjbbP1mJWtct+bsgbVkv6pktPT4eX7t?=
 =?us-ascii?Q?3jhPQh8k7zbaVVj96Cn8zBz7y1TJdYqBdKH3RVnPOvpjIJWhOhlkPa0s2RUT?=
 =?us-ascii?Q?M242zBnYOAx3lk19zrjn8a2LIBWgOn0sfuZdtVjmBGb/yxwzwkjsF9GVZBfG?=
 =?us-ascii?Q?GsLTn0TcaX1keuc+WC80/WLcORJHtch0uHXheetnBi3ZlxZMB/EN9YUwlgrr?=
 =?us-ascii?Q?eA3G54Q86z1c2m7fV83e/q8nI4Byo6K3nt9Q/DGTy+3fVRyoG5ux+5+vzHJG?=
 =?us-ascii?Q?UmEHadvHQ76w99gpJSludUgqiHNrzY0LsMFPi4cY3O2l+DjQ5fn+3X8b+jvW?=
 =?us-ascii?Q?hT1ZZnAecUOs7lrKZ73Hupp+nNCgQcSOkBN5TlqJVsh7lNZ4BVYAvNvzx9nb?=
 =?us-ascii?Q?V+iu6Iy8ghRwsp9XlYhG5LQ0TBHfXZqv07aXxWbGQqW/cT/oNyMcCOyuHKQz?=
 =?us-ascii?Q?sjZBsdZo1owa32Qxe8bK+1Bdgv9yBepOjcYZaCk5/dF5LeT+RuuLRtutYnE1?=
 =?us-ascii?Q?duegRTibBcy1sO8gJGbsXtD6WnA+D9jh7u3l0RH+CVe7jLusMvs9MqW+kcj0?=
 =?us-ascii?Q?PaFRk+IsY9DViuYeD/W6E4DXJ1iYWFuVYx0I92p0BqrLQtNv+7B31FFYrHOO?=
 =?us-ascii?Q?tfNLx03RhvVeC2S5pbBR8gN5KOeKksXnut0EKrPDzsy7N3ehqUjfZn7A+Mo3?=
 =?us-ascii?Q?acxEr6OOIYDWvqgpr08H+3pJh3l0NLLF2KtLkC4UBEyQ/vSve9rCsrjpRnRu?=
 =?us-ascii?Q?TRaBOumPz2v1S6DZdUGplqxlQX6ohOMAjMH2bdc/8N3xPzdq4YuRcM9RMWSa?=
 =?us-ascii?Q?l0mhDZVub/iJ+bm5Fh0MbQHHz7OFa8j5N8QUmxp6v2trq6bq5x1NySy5BQpU?=
 =?us-ascii?Q?vWaZxg4KuX58Zzd+NSLn7OeN2NwCMIigfxC8KnY0wM7ODVCmddhiOAgFrGm1?=
 =?us-ascii?Q?PlLDTftRQQk9noaJ66FwryalmQEoIx9CQihb1dHV3GV3S+ztwfl02LkybgUz?=
 =?us-ascii?Q?NMNI0Yw4PfKdczVPriLZwD8hXPzKBp9sZx2yZkaa4C62RzPJKEAYIKaUsrIN?=
 =?us-ascii?Q?vA/XnpBgqDECtiJsGL5v0tvFM5kfB0N06HW57Plm3aNW6joLIy4fuHIK1H43?=
 =?us-ascii?Q?A9/V1EuUYtAFc5UvpnUamLPfz0X6qBVm85jWFBnd86bNofT//Lb0kPvFOcSI?=
 =?us-ascii?Q?BZgZIAwt8kzQAGvDj3BqhSfhArCtQ2MItyIG82XO9eVqfPm8Uv59cKj+zp0D?=
 =?us-ascii?Q?B2M+wSRQFKQegOfZ2sbZNqd8nGlN90eLs9bSEtEz?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b044083f-d1cb-498d-8082-08dbf7659b67
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2023 20:46:37.5979
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +qD4L9US1wOlAIcU10VWoRR9BrL8eRluxb/s7koI+8uQRCcTSpzB1T56gtkO/6b/rfdNxY0lpWg3Y+hX18PgGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7843
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jiang wrote:
> 

[snip]

First off thanks for the patch.  This code seems to have a few things to
clean up.

> 
> On 12/6/23 20:43, Dinghao Liu wrote:
> > When an error happens in btt_freelist_init(), its caller
> > discover_arenas() will directly free arena, which makes
> > arena->freelist allocated in btt_freelist_init() a leaked
> > memory. Fix this by freeing arena->freelist in all error
> > handling paths of btt_freelist_init().
> > 
> > Fixes: 5212e11fde4d ("nd_btt: atomic sector updates")
> > Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
> 
> How about use the new scope based resource management and we can avoid the goto mess altogether?
> https://lwn.net/Articles/934679/
> 

The freelist is returned as part of arena.  I've not traced both paths of
btt_freelist_init() completely but devm_kcalloc() looks like a better
solution here because this memory needs to live past the function scope.

That said, this patch does not completely fix freelist from leaking in the
following error path.

	discover_arenas()
		btt_freelist_init() -> ok (memory allocated)
		btt_rtt_init() -> fail
			goto out;
			(leak because arena is not yet on btt->arena_list)
		OR
		btt_maplocks_init() -> fail
			goto out;
			(leak because arena is not yet on btt->arena_list)

This error could be fixed by adding to arena_list earlier but devm_*()
also takes care of this without having to worry about that logic.

On normal operation all of this memory can be free'ed with the
corresponding devm_kfree() and/or devm_add_action_*() calls if arenas come
and go.  I'm not sure off the top of my head.

In addition, looking at this code.  discover_arenas() could make use of
the scoped based management for struct btt_sb *super!

Dinghao would you be willing to submit a series of 2 or 3 patches to fix
the above issues?

Thanks!
Ira
