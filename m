Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 601B079FD04
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 09:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236144AbjINHPa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 03:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235937AbjINHP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 03:15:29 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29563CCD
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 00:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694675725; x=1726211725;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=eIf7t0Z6ZPmGuFyHWya9XgQxDU3oCWpNWUKHWPPslbI=;
  b=HSjRQpR2352S9JUfHQ/JwewdenKvRalzAt+c8Zvj5hVRzAG9nzucBPqH
   hl22VsyKAJhcY6D0P3XS5x+FSDXzwy/jGz1JDnJnPuFxZHsFZ6CteIlvg
   ZeUuGT3foGAppPzhM0+G19dRR8ElL3i4F/oThl6+C/93MVpiddYJ3Fh5c
   hRGB8WFQyAUMOG7cFm386ZMXvsabhUP/94Smg1x+cr0bczjcA5WYV3Ihi
   Oa3tTkjJJJHT3SSiL4leERCseo9yDrdmKiWd3YIcCnZy8TCH2kpE/geT0
   B+xOIb9f31GXWE01AYONcpZ0MTOHCIBYMWQe+e8kww+mPvDHVftwEEm2/
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="378798863"
X-IronPort-AV: E=Sophos;i="6.02,145,1688454000"; 
   d="scan'208";a="378798863"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2023 00:15:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="887670172"
X-IronPort-AV: E=Sophos;i="6.02,145,1688454000"; 
   d="scan'208";a="887670172"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Sep 2023 00:14:38 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 14 Sep 2023 00:15:09 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 14 Sep 2023 00:15:09 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.49) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 14 Sep 2023 00:15:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gaXYJQyAGQrkwQq8MWjHeLMeWXrDsjUMTaljpcpWmGpsKjdhXYUo1aeNS/MTSoZakVB7YuXPkNkQeBDjaOFfZn6r+Q9GcVa+zzEbaqmdekWnQ+pGgnuc2zaYeBdnoaIzTpIl83grMvXDg/RkrNf66bBn7K/2wPQm14L3cH2NDqQxcqO/b0IRH5wB/QIalIqMAorvD03BKCp48NpNPP35Xfv6JuffP+HyqlqKg3Xf/d/dOc5P6srN9uQXQ8zQnHo+Jv8GLjm1kJET4FbpAwTQAAn7mwNAc9taBbfj3pZvnVYOj7pdfJztb/gg86An6Z8s+pQVSo84Z8L/vE1BRW52Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aPp4NX1QJqsQkz8sZ+CBeXmcxrfSZJNulmyh7GlqyXk=;
 b=eUyKIO0WcAW3UBPnfb88zgOxPPmdod6OJ8ULy0vTVD1jrUKEZa8hECB2cB0mI8av083K5dpk11r8vDJkKzlRt/hdh9BG4tTElpsbCNK6siy/eBaqXIoPyG1FZcVIGbWyd88a/dex5eqHSNjy06IqOBo5x+IXeuWRz/6w1VQNZNBhJHmlVQ4qwyoaEi24xY2sWHzpJDvjK+qAuOJ+rci1+wBHiQUJUo5OlgvInvmbjYtMDVJHSnHFuOo1V0iOuqmZvaonTdGfsBcaz1/7Q6n9LtTOs8v9sGvLRp/fHHkvlLxBERCi4vqfG8JrHBFslzHynY39X9p4CaQ9glSMFAMtug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by IA1PR11MB6537.namprd11.prod.outlook.com (2603:10b6:208:3a3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.31; Thu, 14 Sep
 2023 07:15:03 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::488d:7cde:d174:b775]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::488d:7cde:d174:b775%7]) with mapi id 15.20.6745.030; Thu, 14 Sep 2023
 07:15:03 +0000
Date:   Thu, 14 Sep 2023 15:05:31 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
CC:     Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC Patch 3/3] mm/slub: setup maxim per-node partial according
 to cpu numbers
Message-ID: <ZQKwu3TrorCvgH9b@feng-clx>
References: <20230905141348.32946-1-feng.tang@intel.com>
 <20230905141348.32946-4-feng.tang@intel.com>
 <CAB=+i9RWVvUb5LyoTpzZ0XXWoSNxbKJuA6fynvOd4U+P5q+uaA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAB=+i9RWVvUb5LyoTpzZ0XXWoSNxbKJuA6fynvOd4U+P5q+uaA@mail.gmail.com>
X-ClientProxiedBy: SG2PR02CA0136.apcprd02.prod.outlook.com
 (2603:1096:4:188::16) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|IA1PR11MB6537:EE_
X-MS-Office365-Filtering-Correlation-Id: b92f0ea2-4101-4cd0-70f9-08dbb4f25080
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IJZOMdUN+11m0SQdo/kHlseghTldh7PotncbGp4g3i5O/rSYZyaZX6KwLV4skWnDdxnDgNMRUOQtqSCijFZ0xuOOg3HytVb9rqcYLves+nEtoseEC6qpyGiipxBYkEKkK88axc4uWNScgIGoEhP2xef9nBHUg/Ow3UTCjvFU9pzGScpEE/Ti3/BrqSCVXPuAuwngS15YZ+m0KOKd+PV9T+4Rzaeym3cG7vSha0Ydq1Kf9MqGPCJx8Na3egNyZDYtLSC0jYW8BlPYfKqZpCkRtAxK5a/l+l5aqfPlHnel0J16zOxlKTC5M0PvKy5Wa85RHQH0jlSmjPPq/TtBic5wTu9gq9BDs5Dbq1CM6l5CWl4sqnRxLAu1X7OIUlpAZqpI48YUfFsxHSiQbxUJUevm4hfEseGLCyWTpWO/Uh4PW7Y0xkYqpnM2LI1JnKzwV2DNRs7X7NGAdEnHD67cp4a4ZCFdN8rZTzInKdFL3rLRwkEUcCSz1uOG/i2ZWVnUAra5SoVhfq+cAQ/0IqWII9KPkxVG3tWyHBKJ5LcAX5pWcAJOlI9nQRUhHzETMb4JpWSV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(39860400002)(366004)(346002)(136003)(396003)(186009)(1800799009)(451199024)(6506007)(33716001)(2906002)(38100700002)(82960400001)(86362001)(7416002)(6486002)(66946007)(66476007)(66556008)(41300700001)(6512007)(316002)(6916009)(4326008)(478600001)(9686003)(54906003)(8936002)(8676002)(53546011)(6666004)(83380400001)(44832011)(5660300002)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TFVFaVV5V21jRmJ2dEk1S1pOcTNmOGxWVFcxdENjYnh0SVhyd3d6My9CSWJC?=
 =?utf-8?B?Z1poVnBPR25ONnl0d0NOZFZtMTlEL2pCMFAxSUJ5aVRYOXBJUTQvQTJWVGh3?=
 =?utf-8?B?QTQxTzI2ZXNQS2g3bHBkeG1QQkN6Y2pQcC9qV3lCMGRQMzIzajQxa3pJL1Jp?=
 =?utf-8?B?SnR2MU9Pa1FyNzh1VnZQZmZQRHc5VlloTmZna0gwV3BuUVNCNHVSWWJKR2l1?=
 =?utf-8?B?dmtERXhpcFV4N2FmQ1JFRXNLaU52SDJUandOa0tXWElnYlhJNGNXTytmb0lZ?=
 =?utf-8?B?VG1zcUkrL010QzBZbWFtNUtNY21nK2JNRlBadnltNzBkT2d4N25yMTNpNVdC?=
 =?utf-8?B?RFRqYVhhZHdLTTA2V0t0NGFMNHp1c0draEU4UGVDZ1ZpR2QvSG45NHNUNDZH?=
 =?utf-8?B?eUxvNFdqWG9aKy9NQm9ITlU5WGZ6UG5vWEZlQzZScndHVnhBVzZoVXJ6dEgx?=
 =?utf-8?B?eEhXS2R5aXBmbzI3eG5ydktZamdRL1JWSDd3ZEVKSHlveE1WT0ppOUk1V1ZV?=
 =?utf-8?B?SGovWlJvZUorb2UvMWdVdWwyV2VlTFpqM00xSDhMN1ZZVXVZdmNsTy9DOXVp?=
 =?utf-8?B?OHIrVUpZNXcvcTg3VXQwKzNrZ09TMWwxNzBOUWRuZ3l2Y0YwdkROcGtjaTJr?=
 =?utf-8?B?NzFGUzZlZzU2MWREQVhSc2hHbHQ2MDdaSWc4cXJ6cTkvSFNNMXNqM21nNnlG?=
 =?utf-8?B?ZE8zTVNFNjVQcGFvNm85c1Fxc1pLNXJIdnZvNGJyclU5U2pKOVVFak95bDlK?=
 =?utf-8?B?YXFOYkt3a3FWcWlCTVI3UCtrRE1aL0VoUEtXaTlNdFIwYUJ1R3JyalJkeFZ5?=
 =?utf-8?B?aEJoNW5hTEZwdW9OYUhSK01NVlVabFhSeXowR2NPeEViZ2VzSFgxNU5xT0ZF?=
 =?utf-8?B?OFgzZ0sxQ3VvT0NlalVJMVVVUEQxV3BaTVdsNlg4SHJKT0xVTWNiM3FxakRr?=
 =?utf-8?B?ejkyQ0ljSE5nTDNuVjNPZ2tRTUZBTER1aUFORlViYllaRittNlZxeCsyTEtv?=
 =?utf-8?B?aFV6K0MyMy9oa2hJRUpqZklZWjdMd0lieU0xM0sxOUtvSnFuTTQyTDluQkM3?=
 =?utf-8?B?TUFSOCtGa3pYMnN2MjlrNEZzZUVtZExkMGoyV2J3TUdaUkkxVGc1UFA5Y085?=
 =?utf-8?B?MG9udER0eGg1QkpzSjRrSEhCQ0pJaXlsSERNMXI0eHBkYS8rRmt0Z3J6a1k4?=
 =?utf-8?B?bjN4WTd1KzVDNEVtNzJaZ0xpNHhjUjRvbDBERlJJOUZ0c1pSVGVuVTN3NHdO?=
 =?utf-8?B?cXFXcEFVai9Pd2VGbzFDODJyUzBZSVhrV2dRWS8xTXo3UnlvZFVoWXp2SzVH?=
 =?utf-8?B?eGZWNUg0M2N6YzZDS3BYbWJrUHFrVHpDNkl4RWl6M2hZT21mK1F4VnVaQVgr?=
 =?utf-8?B?elJlUDg2elJyRXRlRWR4NE16ZkRTd0ovRnVHdlRORDBjbVFRRzlqR25uYmpP?=
 =?utf-8?B?bG9oamw1eHhPUlFYQVBEbUVyN2tiU0MrOHhValdlODFMcWhVZzZWdldHMElt?=
 =?utf-8?B?QmthYzlLYmVGb0xOZnRNaDFXRHJyMjRtQnB3VU1YT2lta2E5QThUUU5wUlQ1?=
 =?utf-8?B?WG12Mm01aWF2MkpoM0plVzVRZkgzQzg5bm1WRktnOWp4d3hOekRncjNzTFRR?=
 =?utf-8?B?ZVNSNGJvUmJZcEJvbzhPb2ljUEJsSzRpUUl6dyttY1B1Y1FzVWpjS2IvZ3RX?=
 =?utf-8?B?M2gvRGsrWmU5cTZuaDhFUUpVNERTVnNLSjRrY2xzbXVHeGdWZElCalZGeXJL?=
 =?utf-8?B?aHEvOE50NkVuTzZXRGZYckRlVW5CWElsOVMvak1oeEhLYjJFV1pnTGxZMkc5?=
 =?utf-8?B?N0xDL1NMaUxCSTRqaHN2U2EyRE9BR0xqTmMveElMaDAyMHJqZTExdXZZaHBz?=
 =?utf-8?B?UTZ1NGh5d2JTVHIvSnFrUXkzNDlzcU5tM0NLWklPa2F1SjVUYXh5c2VjemNF?=
 =?utf-8?B?b0pXdXh0bnQvc2hoOUtGSkdEZys3Yjlyd1dsNnZSNGdIQ1Uwek1qL2l1TFYx?=
 =?utf-8?B?MXRJdmIwb1VIbVlnelRkOGt5ZnpPYmU5cFlTTkhVYlRhRFdDUWUyV0h1MSt5?=
 =?utf-8?B?U0ZodFJmaTk2ekxyU1B6TGtSbFJISlpQNGJOaXhpVTRtSDlGZE9uby9CcTE0?=
 =?utf-8?Q?m/8sp0RGUgkxw0iBG5zd9hsfn?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b92f0ea2-4101-4cd0-70f9-08dbb4f25080
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 07:15:02.9932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eWy9Q8r5vaAGxrESX20VN7SPUqjqL30/FFzhbW87xwoJsbXzGCyFFdff1Jb6ZrfBXJqafiwPV+yrwH6krJ6jOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6537
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hyeonggon,

On Tue, Sep 12, 2023 at 01:48:23PM +0900, Hyeonggon Yoo wrote:
> On Tue, Sep 5, 2023 at 11:07 PM Feng Tang <feng.tang@intel.com> wrote:
> >
> > Currently most of the slab's min_partial is set to 5 (as MIN_PARTIAL
> > is 5). This is fine for older or small systesms, and could be too
> > small for a large system with hundreds of CPUs, when per-node
> > 'list_lock' is contended for allocating from and freeing to per-node
> > partial list.
> >
> > So enlarge it based on the CPU numbers per node.
> >
> > Signed-off-by: Feng Tang <feng.tang@intel.com>
> > ---
> >  include/linux/nodemask.h | 1 +
> >  mm/slub.c                | 9 +++++++--
> >  2 files changed, 8 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/linux/nodemask.h b/include/linux/nodemask.h
> > index 8d07116caaf1..6e22caab186d 100644
> > --- a/include/linux/nodemask.h
> > +++ b/include/linux/nodemask.h
> > @@ -530,6 +530,7 @@ static inline int node_random(const nodemask_t *maskp)
> >
> >  #define num_online_nodes()     num_node_state(N_ONLINE)
> >  #define num_possible_nodes()   num_node_state(N_POSSIBLE)
> > +#define num_cpu_nodes()                num_node_state(N_CPU)
> >  #define node_online(node)      node_state((node), N_ONLINE)
> >  #define node_possible(node)    node_state((node), N_POSSIBLE)
> >
> > diff --git a/mm/slub.c b/mm/slub.c
> > index 09ae1ed642b7..984e012d7bbc 100644
> > --- a/mm/slub.c
> > +++ b/mm/slub.c
> > @@ -4533,6 +4533,7 @@ static int calculate_sizes(struct kmem_cache *s)
> >
> >  static int kmem_cache_open(struct kmem_cache *s, slab_flags_t flags)
> >  {
> > +       unsigned long min_partial;
> >         s->flags = kmem_cache_flags(s->size, flags, s->name);
> >  #ifdef CONFIG_SLAB_FREELIST_HARDENED
> >         s->random = get_random_long();
> > @@ -4564,8 +4565,12 @@ static int kmem_cache_open(struct kmem_cache *s, slab_flags_t flags)
> >          * The larger the object size is, the more slabs we want on the partial
> >          * list to avoid pounding the page allocator excessively.
> >          */
> > -       s->min_partial = min_t(unsigned long, MAX_PARTIAL, ilog2(s->size) / 2);
> > -       s->min_partial = max_t(unsigned long, MIN_PARTIAL, s->min_partial);
> > +
> > +       min_partial = rounddown_pow_of_two(num_cpus() / num_cpu_nodes());
> > +       min_partial = max_t(unsigned long, MIN_PARTIAL, min_partial);
> > +
> > +       s->min_partial = min_t(unsigned long, min_partial * 2, ilog2(s->size) / 2);
> > +       s->min_partial = max_t(unsigned long, min_partial, s->min_partial);
> 
> Hello Feng,
> 
> How much memory is consumed by this change on your machine?

As the code touches mostly the per-node partial, I did some profiling
by checking the 'partial' of each slab in /sys/kernel/slab/, both
after boot and after running will-it-scale/mmap1 case with all cpu. 

The HW is a 2S 48C/96T platform, with CentOS 9. The kernel is
6.6-rc1 with and without this patch (effectively the MIN_PARTIL
increasing to 32).

There are 246 slabs in total for the system, and after boot, there
are 27 slabs show difference:

	6.6-rc1                         |    6.6-rc1 + node_paritl patch 
-----------------------------------------------------------------------------

anon_vma_chain/partial:8 N0=5 N1=3      | anon_vma_chain/partial:29 N0=22 N1=7
anon_vma/partial:1 N0=1                 | anon_vma/partial:22 N0=22
bio-184/partial:0                       | bio-184/partial:6 N0=6
buffer_head/partial:0                   | buffer_head/partial:29 N1=29
dentry/partial:2 N0=2                   | dentry/partial:3 N1=3
filp/partial:5 N0=5                     | filp/partial:44 N0=28 N1=16
ioat/partial:10 N0=5 N1=5               | ioat/partial:62 N0=31 N1=31
kmalloc-128/partial:0                   | kmalloc-128/partial:1 N0=1
kmalloc-16/partial:1 N1=1               | kmalloc-16/partial:0
kmalloc-1k/partial:5 N0=5               | kmalloc-1k/partial:12 N0=12
kmalloc-32/partial:2 N0=1 N1=1          | kmalloc-32/partial:0
kmalloc-512/partial:4 N0=4              | kmalloc-512/partial:5 N0=4 N1=1
kmalloc-64/partial:1 N0=1               | kmalloc-64/partial:0
kmalloc-8k/partial:6 N0=6               | kmalloc-8k/partial:28 N0=28
kmalloc-96/partial:24 N0=23 N1=1        | kmalloc-96/partial:44 N0=41 N1=3
kmalloc-cg-32/partial:1 N0=1            | kmalloc-cg-32/partial:0
maple_node/partial:10 N0=6 N1=4         | maple_node/partial:55 N0=27 N1=28
pool_workqueue/partial:1 N0=1           | pool_workqueue/partial:0
radix_tree_node/partial:0               | radix_tree_node/partial:2 N0=1 N1=1
sighand_cache/partial:4 N0=4            | sighand_cache/partial:0
signal_cache/partial:0                  | signal_cache/partial:2 N0=2
skbuff_head_cache/partial:4 N0=2 N1=2   | skbuff_head_cache/partial:27 N0=27
skbuff_small_head/partial:5 N0=5        | skbuff_small_head/partial:32 N0=32
task_struct/partial:1 N0=1              | task_struct/partial:17 N0=17
vma_lock/partial:6 N0=4 N1=2            | vma_lock/partial:32 N0=25 N1=7
vmap_area/partial:1 N0=1                | vmap_area/partial:53 N0=32 N1=21
vm_area_struct/partial:14 N0=8 N1=6     | vm_area_struct/partial:38 N0=15 N1=23


After running will-it-scale/mmap1 case with 96 proceses, 30 slab has diffs:

	6.6-rc1                         |    6.6-rc1 + node_paritl patch 
-----------------------------------------------------------------------------

anon_vma_chain/partial:8 N0=5 N1=3      | anon_vma_chain/partial:29 N0=22 N1=7
anon_vma/partial:1 N0=1                 | anon_vma/partial:22 N0=22
bio-184/partial:0                       | bio-184/partial:6 N0=6
buffer_head/partial:0                   | buffer_head/partial:29 N1=29
cred_jar/partial:0                      | cred_jar/partial:6 N1=6
dentry/partial:8 N0=3 N1=5              | dentry/partial:22 N0=6 N1=16
filp/partial:6 N0=1 N1=5                | filp/partial:48 N0=28 N1=20
ioat/partial:10 N0=5 N1=5               | ioat/partial:62 N0=31 N1=31
kmalloc-128/partial:0                   | kmalloc-128/partial:1 N0=1
kmalloc-16/partial:2 N0=1 N1=1          | kmalloc-16/partial:3 N0=3
kmalloc-1k/partial:94 N0=49 N1=45       | kmalloc-1k/partial:100 N0=58 N1=42
kmalloc-32/partial:2 N0=1 N1=1          | kmalloc-32/partial:0
kmalloc-512/partial:209 N0=120 N1=89    | kmalloc-512/partial:205 N0=156 N1=49
kmalloc-64/partial:1 N0=1               | kmalloc-64/partial:0
kmalloc-8k/partial:6 N0=6               | kmalloc-8k/partial:28 N0=28
kmalloc-8/partial:0                     | kmalloc-8/partial:1 N0=1
kmalloc-96/partial:25 N0=23 N1=2        | kmalloc-96/partial:36 N0=33 N1=3
kmalloc-cg-32/partial:1 N0=1            | kmalloc-cg-32/partial:0
lsm_inode_cache/partial:0               | lsm_inode_cache/partial:8 N0=8
maple_node/partial:89 N0=46 N1=43       | maple_node/partial:116 N0=63 N1=53
pool_workqueue/partial:1 N0=1           | pool_workqueue/partial:0
radix_tree_node/partial:0               | radix_tree_node/partial:2 N0=1 N1=1
sighand_cache/partial:4 N0=4            | sighand_cache/partial:0
signal_cache/partial:0                  | signal_cache/partial:2 N0=2
skbuff_head_cache/partial:4 N0=2 N1=2   | skbuff_head_cache/partial:27 N0=27
skbuff_small_head/partial:5 N0=5        | skbuff_small_head/partial:32 N0=32
task_struct/partial:1 N0=1              | task_struct/partial:41 N0=32 N1=9
vma_lock/partial:71 N0=40 N1=31         | vma_lock/partial:110 N0=65 N1=45
vmap_area/partial:1 N0=1                | vmap_area/partial:59 N0=38 N1=21
vm_area_struct/partial:106 N0=58 N1=48  | vm_area_struct/partial:151 N0=88 N1=63

There is meansurable increase for some slabs, but not that much.

> I won't argue that it would be huge for large machines but it
> increases the minimum value for every
> cache (even for those that are not contended) and there is no way to
> reclaim this.

For slabs with less contension, the per-node partial list may also
be less likely to grow? From above data, about 10% slabs get affect
by the change. Maybe we can also limit the change to large systems?

One reason I wanted to revisit the MIN_PARTIAL is, it was changed from
2 to 5 in 2007 by Christoph, in commit 76be895001f2 ("SLUB: Improve
hackbench speed"), the system has been much huger since then. 
Currently while a per-cpu partial can already have 5 or more slabs, 
the limit for a node with possible 100+ CPU could be reconsidered.  

> Maybe a way to reclaim a full slab on memory pressure (on buddy side)
> wouldn't hurt?


Sorry, I don't follow. Do you mean to reclaim a slab with 0 'inuse'
objects, like the work done in __kmem_cache_do_shrink()?

Thanks,
Feng

> 
> >         set_cpu_partial(s);
> >
> > --
> > 2.27.0
> >
