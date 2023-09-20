Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51B957A73D6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 09:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233642AbjITHT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 03:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjITHTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 03:19:25 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28F51C9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 00:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695194358; x=1726730358;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=cM17Be+wMRKJvVoWlh2H+NyjBmeWMgRtX342W4iNmJA=;
  b=QqFq0wAlC83A9tGwFaOJhm+WCANTP7AJZQ11uEE+kvQyp72YEOnHb/nB
   0gfKHvU0LQc1w261abG1SrWUnSmwUmTnEZGjYzU4nNQ4m3bEoHdQQIkKj
   JcT8LT0TuM8iJpSVAJzOGypezbUF/0FspPE3DXagcbNwg+qZHbSXKVw94
   2jmLLjTyMxXMnuUYhXdEOr6Yi0ZKvttTu0SB5iNOEHof/DMlilysRymHe
   ykqsn+glfIhrYQ/frMZ4mqO6dDeZznNXisJNEeGNeN8L502d70SBIfh81
   1r3cjrPB3ekkl81Xu5Bi3eiKD86L6AV1EucVd0rvJtmclRjfgm1vFMDAR
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="383992982"
X-IronPort-AV: E=Sophos;i="6.02,161,1688454000"; 
   d="scan'208";a="383992982"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2023 00:19:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="740086231"
X-IronPort-AV: E=Sophos;i="6.02,161,1688454000"; 
   d="scan'208";a="740086231"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Sep 2023 00:19:16 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 20 Sep 2023 00:19:16 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 20 Sep 2023 00:19:15 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 20 Sep 2023 00:19:15 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 20 Sep 2023 00:19:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R+MNMIwyW6g5UxfKrEoaL/NnurDRVnvSdbjJNHF8aaBCAJZSD+ARcfrVN/M0TC/to/0L/6W7jQxPc3/q2qCzbuedtUU4arBD2l0N+dgzWTo3QGDTtGzwnnRTUICgGA99Azfyu7V679UqZif3h37/NTXo4E5Remg5/BsKR0c1dv8YmpGsWVe42Vm8nJhvEpSwvMbJhMP7lEibk0djNe8E3xYWtKDvf2uAh7eHvHAknNnXYj9JNO2J8Ay6f3DE4wCu2Hc2WLBFtMm+TLKQJC/2tlI4RhYyneR8aFxjcRsnKr/sRsHOnVvFkTakTaHQuCCSpp+3e6sDyzsYDI2OWNQp2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XLXFnoc+ilhhI3IrS7FRKqGKNEZpeeQMsI2DnVyoGYs=;
 b=SeqlEvQ2GS8mkqE3q+yGSpxhdk3WAnmZwcsW1Ru/nH3UWzSoHOx1uYqUaGQ6VvSfzHWjI/O3uJyOORHgmt1gDAmvHFIIreFE2LUFs48kIA3/eZZJZHyO4HAh3LWtHiFshFq6LHdeWvqoEjrCoNZF5kmITAScA7TKJ1ecRsb6MaJU1dg5UutX5GPCN4rnLHoznmb/RIA85Ep5nBbKbXM80vaSc5pdTrj41PFy4AMKSQfU3lk2bzO6vx4Bl1OmzRZQiHBKPs3XpYsNssU6DsGX7JDSLpnQXuH5rEOrVkHouNysWCUaWwVKgq55momqpdjdCDP2hpxJjpv6w0qSj7leVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by CH0PR11MB5377.namprd11.prod.outlook.com (2603:10b6:610:b8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Wed, 20 Sep
 2023 07:19:13 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::7edc:de45:7f2d:9ade]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::7edc:de45:7f2d:9ade%4]) with mapi id 15.20.6792.026; Wed, 20 Sep 2023
 07:19:13 +0000
Date:   Wed, 20 Sep 2023 15:09:42 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Vlastimil Babka <vbabka@suse.cz>
CC:     David Rientjes <rientjes@google.com>,
        Christoph Lameter <cl@linux.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Jay Patel <jaypatel@linux.ibm.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] mm/slub: simplify the last resort slab order
 calculation
Message-ID: <ZQqatka0zPkk0B44@feng-clx>
References: <20230908145302.30320-6-vbabka@suse.cz>
 <20230908145302.30320-7-vbabka@suse.cz>
 <ZQlUKJXKYYY5fxL4@feng-clx>
 <9f0ac6a5-7b13-7ce0-ead3-03746a31040e@suse.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <9f0ac6a5-7b13-7ce0-ead3-03746a31040e@suse.cz>
X-ClientProxiedBy: SI2PR01CA0045.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::19) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|CH0PR11MB5377:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ca76432-84f6-4245-7594-08dbb9a9e39d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V5nGaXz6yChOHYB+Ed/T6q7oT7P8r7QRtQ7MhOgJxhlp8qTggvDd8HqIG2Vqko4H5+340/LWZmiEEpMeMVHoHDLDUGvDD1vXxGreh3M3a9fTfISTGj95g2UYMImWRwMPV4q6QV2A0o/i3m79Alk8apax6tnkQmJ7Dn6EmMjZ6eeN/4MLNBuW+ycV3qZCNdgrFxDK6qwindCg0SfmwkqiN+Nq1x94VtIFFmEl4kFMCdxCIhrjOvr1gEAhMO6cZSvOtbPp8QP1zaLbmvW1GAQs0BwLVfZE3f+zbSjf/udvh7Hsq/DQHiDAhARRNZOF+h7uT4d0gRuzM08vVReip1jnM4cpJ5iboY/6N4onfLzSwQ+UujwCaxQmHvSY6r7EVcUCsRWqyBbP7LnZenHdb5mK0u9wU/V7K9+6005EYL4ofPHmz10OyKUKpmFojbShqP2mNXjLCKNr2GSi3qAstU1w0YK73qdiWN+l9K4l+HFkN2KECTJM+0Xnh9/79EsKx2/LF8pE6CaaCHQ9TMOSKSUP8jlT+gZk2SWWGaJpdM0rJnw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(136003)(366004)(396003)(376002)(346002)(186009)(1800799009)(451199024)(316002)(54906003)(6916009)(66476007)(66556008)(478600001)(66946007)(2906002)(38100700002)(966005)(7416002)(8676002)(8936002)(4326008)(41300700001)(86362001)(5660300002)(44832011)(83380400001)(6486002)(9686003)(6666004)(82960400001)(53546011)(6506007)(6512007)(26005)(33716001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JzTnE4MihuJurS/uGcL7e4VFWfZiyifZpbemqIyvJr38wW9j5+WzqVr999tC?=
 =?us-ascii?Q?j2YJKxwflLwQQ3JqCTqxNqGaNhjwbNb03wBw9/0piuiKo85k1NesMH+INrET?=
 =?us-ascii?Q?SZMJevAv8YZ1pVhtQDwUVQsdMP/f1UKteja3jLHkGPmuViVw9+ElDDuREKPO?=
 =?us-ascii?Q?/jRA/bNLYjJBOY5p3YL+l6ZVGSJRZPjWocsJBNkLpqohaYuaT977xVRHrtvs?=
 =?us-ascii?Q?ATD6jWN33yJgGJF4eS+m1Ztbw9nbd2czkBdjGExh3+KQLYsf1hUYfCL+Ff8z?=
 =?us-ascii?Q?BWa4zn/0Q5/AVYpNBFMa/WknUgULIwZdsUpQQ5sjZo6ypaRG1FRBCHvojvH9?=
 =?us-ascii?Q?q+vrgu8fScysHyAgB2I4wxQ/6jl+9A0pbx4CMkVJRfQM4+QdjSuyjYagZwjH?=
 =?us-ascii?Q?tsV89rzmnyg0eFuDW+l0ekCXOI1ZHFr8QtYI4WdJY443U4PPDdhrPfpmsF2l?=
 =?us-ascii?Q?X3hHPWVLwj/hDoDNaO6dTX4CXYuayBfLLGdKQPrlubc3LTCUMq+nDzmcZbu+?=
 =?us-ascii?Q?Rf3V74G/DCBCna+HN7HgO9i4V2yAFsZdiFKmELcJnRaLDFP4OAY0Ws1QpivO?=
 =?us-ascii?Q?63ac74pxA6LPPn/FjvqOQ5lGa7Bczxg3Cob+ZTD0cNOlNkhnlyKd0UQE1i8j?=
 =?us-ascii?Q?TEhgrHTusDHDmHhxGVV6g6Csi5Mez/oVUcoc6XzCzFUUHxT0mTMQkHfJDWCH?=
 =?us-ascii?Q?1QnKv86NtDcnZZLuQLiwnOc8Pmzp24yj+L+/sKe75pBgcPbzrZc6A+yjbWno?=
 =?us-ascii?Q?FwdCne7wbCakBZU7hY3Bf3iG0XdOg1Kf7DSeZwEdZwlRM69PQGqJ+eaQa7xe?=
 =?us-ascii?Q?Drz23b+OKiQTTr5RYcIecWjD8llILp31iR96JLCnt3O9z/s8fS3O/VQ/F5a5?=
 =?us-ascii?Q?m9VlnAJa9zm1bjHOFjC+VqPxIVJZY+eyLx6bfFcKTz3qLAxxQosXHF495rJE?=
 =?us-ascii?Q?otIz/6na3p1EEmiNsEc/vxjJxSWawG0S21HapVowKrNzqeL+Wh1CrQJVKasZ?=
 =?us-ascii?Q?zal5SW+RNiDScKM1xFfzxvabHlbUEBKy8o22sPIDkGrUGaI6KSLFFv9frXC2?=
 =?us-ascii?Q?1Nd9VJPwV9XF3Ju+ADV5fjeLLHIciAB1VWWDwmSCsoFaEnUs6zAiCo1xrg/J?=
 =?us-ascii?Q?dCZkIiQVtxUzgRyjPV5sTEXbPUNyPEAOywcT40U8mnNioqL1VeTxFIJfLshq?=
 =?us-ascii?Q?biAzXbv4Py31i50vvrpFlPM1H9fnYamD6rnzQlr6Xa6/mfoRpr40mPa+3x5+?=
 =?us-ascii?Q?Rac0tfwVtdDLdH7Pd17GJbEiX1FnNuWUDNc3TL28ODs72uqRIECN82i+kTvm?=
 =?us-ascii?Q?JjsFEwOpehCHfUhd3XwF+ZLlI1xBtkSNhCBjORi8AM9G+t9BJ9HTNHpwRYTI?=
 =?us-ascii?Q?7z+Wi/+/HfOd1fRi6yn12yp18zp/1PPNOqZhW/KvoWN6FkXvIu4M8MRjq+XM?=
 =?us-ascii?Q?teOTaMZUsuK4Zphc3A/hMStA+uWfclK+fMcDv+sY1fJDz5UbLDYNAY3XIzFo?=
 =?us-ascii?Q?sMXEAlc/DLQ7KzLQJtY/XJdJzyR/NbkoSYuNnqgnBLfxsq5hXN+CSMtlS2HM?=
 =?us-ascii?Q?dt7yKu0CwWaxP7dm3zf7RjdDa98ALf/cPjV1VCUW?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ca76432-84f6-4245-7594-08dbb9a9e39d
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 07:19:12.3988
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 74liiNp2p7AokmSiDB8ifYwkQ4MEpDfgpMNahexcroS70Km72Is/rDBp2+2RUaAFZ+GCcA5eE257NOFz0rR1/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5377
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2023 at 08:38:05AM +0200, Vlastimil Babka wrote:
> On 9/19/23 09:56, Feng Tang wrote:
> > Hi Vlastimil,
> > 
> > On Fri, Sep 08, 2023 at 10:53:04PM +0800, Vlastimil Babka wrote:
> >> If calculate_order() can't fit even a single large object within
> >> slub_max_order, it will try using the smallest necessary order that may
> >> exceed slub_max_order but not MAX_ORDER.
> >> 
> >> Currently this is done with a call to calc_slab_order() which is
> >> unecessary. We can simply use get_order(size). No functional change.
> >> 
> >> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> >> ---
> >>  mm/slub.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >> 
> >> diff --git a/mm/slub.c b/mm/slub.c
> >> index f7940048138c..c6e694cb17b9 100644
> >> --- a/mm/slub.c
> >> +++ b/mm/slub.c
> >> @@ -4193,7 +4193,7 @@ static inline int calculate_order(unsigned int size)
> >>  	/*
> >>  	 * Doh this slab cannot be placed using slub_max_order.
> >>  	 */
> >> -	order = calc_slab_order(size, 1, MAX_ORDER, 1);
> >> +	order = get_order(size);
> > 
> > 
> > This patchset is a nice cleanup, and my previous test all looked fine. 
> > And one 'slub_min_order' setup reminded by Christopher [1] doesn't
> > work as not taking affect with this 1/4 patch.
> 
> Hmm I see. Well the trick should keep working if you pass both
> slab_min_order=9 slab_max_order=9 ? Maybe Christopher actually does that,
> but didn't type it fully in the mail.

Yes, that's possible. And "slub_min_order=9" alone also works to make
all slab's order be 9, as current code's final fallback will try
MAX_ORDER inside caculate_order():

	order = calc_slab_order(size, 1, MAX_ORDER, 1);

though the dmesg looks strange:

  SLUB: HWalign=64, Order=9-3, MinObjects=0, CPUs=16, Nodes=1

> 
> > The root cause seems to be, in current kernel, the 'slub_max_order'
> > is not ajusted  accordingly with 'slub_min_order', so there is case
> > that 'slub_min_order' is bigger than the default 'slub_max_order' (3).
> > 
> > And it could be fixed by the below patch 
> > 
> > diff --git a/mm/slub.c b/mm/slub.c
> > index 1c91f72c7239..dbe950783105 100644
> > --- a/mm/slub.c
> > +++ b/mm/slub.c
> > @@ -4702,6 +4702,9 @@ static int __init setup_slub_min_order(char *str)
> >  {
> >  	get_option(&str, (int *)&slub_min_order);
> >  
> > +	if (slub_min_order > slub_max_order)
> > +		slub_max_order = slub_min_order;
> > +
> >  	return 1;
> >  }
> 
> Sounds like a good idea. Would also do analogous thing in setup_slub_max_order.

Yes.

> > Though the formal fix may also need to cover case like this kind of
> > crazy setting "slub_min_order=6 slub_max_order=5" 
> 
> Doing both should cover even this, and AFAICS how param processing works the
> last one passed would "win" so it would set min=max=5 in that case. That's
> probably the most sane way we can handle such scenarios.

Agree. The latter setting should take privilage. My test code also
does this way.

> Want to set a full patch or should I finalize it? I would put it as a new
> 1/5 before the rest. Thanks!

I can try to make a patch with more detail in commit log, and resend. Thanks
for the review!

Thanks,
Feng

> 
> > [1]. https://lore.kernel.org/lkml/21a0ba8b-bf05-0799-7c78-2a35f8c8d52a@os.amperecomputing.com/
> > 
> > Thanks,
> > Feng
> > 
> >>  	if (order <= MAX_ORDER)
> >>  		return order;
> >>  	return -ENOSYS;
> >> -- 
> >> 2.42.0
> >> 
> >> 
> 
