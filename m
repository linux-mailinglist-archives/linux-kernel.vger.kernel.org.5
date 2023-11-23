Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E41C7F5F5A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 13:48:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345295AbjKWMsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 07:48:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345351AbjKWMsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 07:48:41 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE6DD1A8
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 04:48:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700743724; x=1732279724;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=2Zcg/PJV+VllyIuqyxOBq3ahjRS+odMnyj/NgOav0uQ=;
  b=eBSIle5gdSTzaBXRAK+GIfx6aif4j7q7bVqDY1uSXyJsFVTEXDclLHuL
   yrCoz6W8MyOPs1a3WRN0fSh+wOMwCg8viiWJMjoQOTIORR4/7u8E3yvMu
   4FXriFNj+aBSqN9+QVdrSIT2KjkizbxePUuzuXv7DHM5fAo2MuLDV79A5
   uqcF2gkLL0Cri7KaAkm1DwjQgI0WdyhQftTb5q3yMLkZu7DKZn3Ekc3PO
   kKGwNWQyGuUxlyVT9aoU26IG6ldxG5THq5qa0bXcAPzzkrQBoAbdQjL8z
   XOA0Mj7cYMsx8LlyG/QHxH149Yb0VNglp1Jrm3sL3uZvPqBA4ULcvqnkQ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="377285363"
X-IronPort-AV: E=Sophos;i="6.04,221,1695711600"; 
   d="scan'208";a="377285363"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2023 04:48:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="743596437"
X-IronPort-AV: E=Sophos;i="6.04,221,1695711600"; 
   d="scan'208";a="743596437"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Nov 2023 04:48:44 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 23 Nov 2023 04:48:43 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 23 Nov 2023 04:48:43 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 23 Nov 2023 04:48:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QGDt2jfRBenCQXJAf1XFcDxaGA8tcZ73hE2cDkdkY/OgltXc7eE3RpCXYsIZD8j0jiV5039kQQIH2LrbPOj1Xpo89eOH5dvEFBVUskYd2CzSR903J5I9aJlia0DWrar298zXesVHHra4O0rYMTpjP29sWOFuZbkaKNQCxXWE561t2uxntoKtq18wgUWb+jWg/YiVPybwFcCTtD+IQrHr1/hTKvcm8ONv5sthIzCYGtNhPDlRt+I/zJSo319j1tWdLPemdwlRhlWGv1eLFYL6yJqBQKNjiPwp94fv54ioqkmMuGeQxOtgUpE7Trg4rEmRtYXn8cOjA2XLta0Qiq1JAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DC35uQvQ8yxMj8kwSpVVj8U3bP+IaiusM48vApdMvfo=;
 b=oPNc2TBDPk8+bkWB8MmmupE/6tlQyv91lgfxAwtL9aU44OMKaYpgsOfrvmHwod1IjzBUT+VSEr0yXBnePH2IXZhuX248shkpcWJW0xqZ+GosjtdiA14mGSQV+WBS1JiSqZv60PBu2hYTW2ljSUySUmIdkxPS98OVzCoy4OvQkqb8/40jHqSnAKu7df6AO9NKI6e/0MfMTcNj9buiJzfSzKCvy8FUCdjQr8zmHiS+ArUtXZAf8bOzPCT/Kn9hDQs7h+4UX9THVDkbz7lz/qeIQwF7xI0GR7ADyGvtynVUbHh0E6plLpZcknP6u4HuqnkUa/7Vk/enNxT9aaeZgNXWrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by PH7PR11MB6882.namprd11.prod.outlook.com (2603:10b6:510:201::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.20; Thu, 23 Nov
 2023 12:48:35 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::24ce:9f48:bce:5ade]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::24ce:9f48:bce:5ade%7]) with mapi id 15.20.7025.020; Thu, 23 Nov 2023
 12:48:34 +0000
Date:   Thu, 23 Nov 2023 20:39:30 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     "andrey.konovalov@linux.dev" <andrey.konovalov@linux.dev>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Oscar Salvador <osalvador@suse.de>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH mm] slub, kasan: improve interaction of KASAN and
 slub_debug poisoning
Message-ID: <ZV9IAnfUHq2lcCe0@feng-clx>
References: <20231122231202.121277-1-andrey.konovalov@linux.dev>
 <ZV7whSufeIqslzzN@feng-clx>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZV7whSufeIqslzzN@feng-clx>
X-ClientProxiedBy: SGXP274CA0003.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::15)
 To MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|PH7PR11MB6882:EE_
X-MS-Office365-Filtering-Correlation-Id: 790529ed-0d5e-4f9d-3edc-08dbec2280ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: te11htPwkZAmvd7ljnmFhJR0ogPkl7Xqpbc7cvC6A4zc9UPEiyn/jbYeeR0l+Ocd3pUydQQ6/gSV2YS4mfAkVpgj0fkTmu/D4ktKGzTOm+ZXVDzERQqmh1yOCKxul0VlnX/SUr9LIIfofmYMYTy6LvaLOpifMYlbDwYrcHyfi5PMtf3/mZt/n7p1HjdcEIgQf6ZmP7wbgjEy/i354v6mgs1j/cGKAXDOxqlEwai1YF0WvmFWC/yfzWZk1iTGhSmeRIFzqYZ3gBdDJ+q4eL3JtGFL0jKp7jS3knIBCtbrCXQEYCae9CmDNFFPWO23rvow+IZf9jds2KUCEojzvqSCBNK1Yu6A2Ev7jxBVw9809PPt+MUbvj3H2mcoVDIpefH407953RLbs/zm14BCiuTB3FLXUqxCOtJBxHSIEa6EodmubIbYlbpfCAtkkmfGFNSkG5rEzgM8e4Xkb9eANAVfj5OPPTM1nQCtxiMjg6hRfqS6LeaXYGrKniDxMQON5RBqmxk6ICcZSLTCVVwZ74OeWpzUkU+S0g9Dbr7C+GX2Y+8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(366004)(376002)(136003)(39860400002)(396003)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(86362001)(83380400001)(38100700002)(82960400001)(316002)(54906003)(66946007)(6916009)(66476007)(66556008)(4326008)(8676002)(8936002)(6486002)(33716001)(2906002)(41300700001)(7416002)(44832011)(5660300002)(9686003)(6512007)(26005)(6666004)(478600001)(966005)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?p0/3s+uEmCwMptg4Y3FmCs4UF4jdFibYOxcpV2RGFttG6EoRPIuJHqM0/xLW?=
 =?us-ascii?Q?AkxwWPcxY7czfoSAUsSVu4D+ad0uSc1Bx/KnQKk+KF6l+bWyP44a5ZcFOgLF?=
 =?us-ascii?Q?mQ0JM8U7gUP5qI8jrhSyd0L7Vsy7uPk3Gz1zKENABo8Ztiae9phXr/U3tgI6?=
 =?us-ascii?Q?i7SGQB2IApLlsuVnwvk+yhP21FBBsutPIFAKIHHB8dOXQpjezHRTCLJw6T62?=
 =?us-ascii?Q?M9DaBqrnO5DNFSGkPMZw+6A13QJinaX3BulvDIJnbtlXlLVdpcdPOx6l0YSs?=
 =?us-ascii?Q?TKcE7Y/XYjdsyINhoTQ+HLzOuV2CNyie3jkSAs7X1e7Uw2XaaANMFHb8ttMw?=
 =?us-ascii?Q?/hhk6XaSA0CAy/1rfS2+adcv60qmuh9j3o8vigWYj2RR9vA9vpXTHD3gg49X?=
 =?us-ascii?Q?ylnMG1eq9O1k1hyrkC8Dq0CRMBj5Nzq4+B/ZojdnGWhAzEli4fdjSQvSBzJn?=
 =?us-ascii?Q?uy0q/dXaQ6XIy7NO73h1AWuOEFCBzFdfW6OC47yvUiLoEy9VooajoCFU679W?=
 =?us-ascii?Q?yHTukVRuRFRPql7I2k8sFdLBOR5snQGul+09FUPrtGaN6QPOVEUnRa0VFgXp?=
 =?us-ascii?Q?t6xo+g51H9E5uuQqbrOS9deJx6f/IIAgnscAuOg1++WoBWEF3UpxaS4tXmNj?=
 =?us-ascii?Q?YA/FRTzD25p2cVARLem+4jcOKykl7PpOpFcJ8a5+Y/HuVjk0V/kFQcpYynGm?=
 =?us-ascii?Q?ktFOC4BNQkdW+lFkBEfPNxm11awuNiH+Hk0ofGP/df+Xp4ZtvlPDnRVQF7m5?=
 =?us-ascii?Q?0EX4yLmD98vKiHzjviDIZ+X2IcbaXUQXIOyytXJBZi5nDv41HfL31HUccUnI?=
 =?us-ascii?Q?te8/mmEh4b2cYfKPcF/UNE94X3Z8G6k3pzZZzsuGbnUKiTeM0zCe/hUHWlbi?=
 =?us-ascii?Q?dahEMNJcYQ5y7baPFHgP7EArUb3XRcm9n57XvGIQbbE7BLz4CrWE1o+ZIZCG?=
 =?us-ascii?Q?AM7uM3pnvjlqi79Oy8mch8lVtdKnHtWvU/iuBr48RgN2z4thsr5jO9qY57eq?=
 =?us-ascii?Q?ZOdkQecDnHdhCY4obXcTyo7X4WtuiyCiYMMm2f7gg3vK2FXfuCeIJvAdf6q+?=
 =?us-ascii?Q?KxRwEncJOyf37awS1GrJmzGWiQrut8UF7/GqixxKisDNEXnCD72RRTqnvdJv?=
 =?us-ascii?Q?IZnLFCa+iXDtt+WnfONkyA/tqFYY//qWVp9VUZzAUQanPAqtn4ibrVvEu1yN?=
 =?us-ascii?Q?59TLWmn0ARwf8jTpPgm4/v+For9rChDxrbIRnxPzSINdf1cpf8g6tcrhKMs7?=
 =?us-ascii?Q?KMHmHkveqIfZcc2o/xnY52l5Am5Fobd8m3P2bLAKSfjPW0lONJsrU1lnqXj2?=
 =?us-ascii?Q?FYC1edK1s5NNPgHNC9VnyeiBZWFNn7QlUYnXIaE0PtmZ1OjcyzOqNwxd1uU4?=
 =?us-ascii?Q?gojNP5rcucqJ3DESpwUp4r5Ic1BgFI9lg4Ya1BPRsgRjJT2UZQacOV01yVQO?=
 =?us-ascii?Q?15DyR8LDQ1+6CLDZg2co3ck/Y70Oz8PdFmP8+iOJ0/WYZApQnLjgmHXk+XJH?=
 =?us-ascii?Q?HqLi1nzjZjx/IHjF4ONy7duDFU9AIBJ+rsnBcdncZeanvJCs4AIzDmEX38S+?=
 =?us-ascii?Q?KIYU10lZPTV6sE8TECutYDIyea5L7FI6zTLAHi0P?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 790529ed-0d5e-4f9d-3edc-08dbec2280ed
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2023 12:48:34.0126
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ic6gl0OU6Nh8yTS2RY3TukxRJJ4WWx1ql6w03oV4L1g7ikitQdPHpNNxlL0TZvOQchC3nhsg0057yLf0qZf3DA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6882
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2023 at 02:26:13PM +0800, Tang, Feng wrote:
[...]
> > -#ifdef CONFIG_KASAN_GENERIC
> >  	/*
> > -	 * KASAN could save its free meta data in object's data area at
> > -	 * offset 0, if the size is larger than 'orig_size', it will
> > -	 * overlap the data redzone in [orig_size+1, object_size], and
> > -	 * the check should be skipped.
> > +	 * KASAN can save its free meta data inside of the object at offset 0.
> > +	 * If this meta data size is larger than 'orig_size', it will overlap
> > +	 * the data redzone in [orig_size+1, object_size]. Thus, we adjust
> > +	 * 'orig_size' to be as at least as big as KASAN's meta data.
> >  	 */
> > -	if (kasan_metadata_size(s, true) > orig_size)
> > -		orig_size = s->object_size;
> > -#endif
> > +	kasan_meta_size = kasan_metadata_size(s, true);
> > +	if (kasan_meta_size > orig_size)
> > +		orig_size = kasan_meta_size;
> 
> 'orig_size' is to save the orignal request size for kmalloc object,
> and its main purpose is to detect the memory wastage of kmalloc
> objects, see commit 6edf2576a6cc "mm/slub: enable debugging memory
> wasting of kmalloc"
> 
> Setting "orig_size = s->object_size" was to skip the wastage check
> and the redzone sanity check for this 'wasted space'.
> 
> So it's better not to set 'kasan_meta_size' to orig_size.
> 
> And from the below code, IIUC, the orig_size is not used in fixing
> the boot problem found by Hyeonggon?

I just tried Hyeonggon's reproducing method [1], and confirmed the
below change of check_object() itself can fix the problem.

[1]. https://lore.kernel.org/lkml/CAB=+i9RnOz0jDockOfw3oNageCUF5gmF+nzOzPpoTxtr7eqn7g@mail.gmail.com/

Thanks,
Feng

> 
> Thanks,
> Feng
> 
> >  
> >  	p += get_info_end(s);
> >  	p += sizeof(struct track) * 2;
> > @@ -1192,7 +1192,7 @@ static int check_object(struct kmem_cache *s, struct slab *slab,
> >  {
> >  	u8 *p = object;
> >  	u8 *endobject = object + s->object_size;
> > -	unsigned int orig_size;
> > +	unsigned int orig_size, kasan_meta_size;
> >  
> >  	if (s->flags & SLAB_RED_ZONE) {
> >  		if (!check_bytes_and_report(s, slab, object, "Left Redzone",
> > @@ -1222,12 +1222,23 @@ static int check_object(struct kmem_cache *s, struct slab *slab,
> >  	}
> >  
> >  	if (s->flags & SLAB_POISON) {
> > -		if (val != SLUB_RED_ACTIVE && (s->flags & __OBJECT_POISON) &&
> > -			(!check_bytes_and_report(s, slab, p, "Poison", p,
> > -					POISON_FREE, s->object_size - 1) ||
> > -			 !check_bytes_and_report(s, slab, p, "End Poison",
> > -				p + s->object_size - 1, POISON_END, 1)))
> > -			return 0;
> > +		if (val != SLUB_RED_ACTIVE && (s->flags & __OBJECT_POISON)) {
> > +			/*
> > +			 * KASAN can save its free meta data inside of the
> > +			 * object at offset 0. Thus, skip checking the part of
> > +			 * the redzone that overlaps with the meta data.
> > +			 */
> > +			kasan_meta_size = kasan_metadata_size(s, true);
> > +			if (kasan_meta_size < s->object_size - 1 &&
> > +			    !check_bytes_and_report(s, slab, p, "Poison",
> > +					p + kasan_meta_size, POISON_FREE,
> > +					s->object_size - kasan_meta_size - 1))
> > +				return 0;
> > +			if (kasan_meta_size < s->object_size &&
> > +			    !check_bytes_and_report(s, slab, p, "End Poison",
> > +					p + s->object_size - 1, POISON_END, 1))
> > +				return 0;
> > +		}
> >  		/*
> >  		 * check_pad_bytes cleans up on its own.
> >  		 */
> > -- 
> > 2.25.1
> > 
