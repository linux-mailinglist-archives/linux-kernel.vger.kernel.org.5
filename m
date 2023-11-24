Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E08617F69FA
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 01:54:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbjKXAyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 19:54:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjKXAyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 19:54:44 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AC39C1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 16:54:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700787291; x=1732323291;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=F2TRS/b4tNTqr4VJsiDl3YJIruPGaMWOX4jvDw5PzSk=;
  b=lArQc9Gqb2PZ+91zyMGyAcdqDoANE6gwFXZK7ZiMLYBNnCyFHhAvG92C
   842reBa+zKb+dHad5tPg7BPHIbVx3vC+nZt1hPDT5NlJmPmntnWAvzif4
   SZdJlkEV7uTJ/syyl0xmS/0s/3W6lEM5qq6vWl1ojo+yOKu2YuAu8oEVB
   s3I4ovPKR33NwTEx5OtJP7xA/5W9kfrLV1zFAJ9A3i87WmaBbambHLkS5
   Ab9CFDi8qa9i3pAGA8AH/GXVZl2DEfuKspry0c64E8fqs7ZPQ0ayfvPSh
   vycDSYf6BqDKE7IdbzYMy3G1v0Hn+67iq1GCun/sw2njy61rxHCWPegqQ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="478548141"
X-IronPort-AV: E=Sophos;i="6.04,223,1695711600"; 
   d="scan'208";a="478548141"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2023 16:54:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="802070697"
X-IronPort-AV: E=Sophos;i="6.04,223,1695711600"; 
   d="scan'208";a="802070697"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Nov 2023 16:54:45 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 23 Nov 2023 16:54:44 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 23 Nov 2023 16:54:44 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 23 Nov 2023 16:54:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EVNoBm7NclmN0tQ+BlHQjCQJdPr1dPLtX9yDYMdmKCecElsD+TsCzDseawHqbuZU67gw8PP3NBcujWotsOm5jFASuueHpu+Bwql4/tVljjRidNBHSWEZdgRCU6Qvke6Bo0FyLf9Wht5c0G02dMejVlFpWeghvX4wRrC+YAbXu13jMqtE3vtmxn+8d3n1o4oqTU5t/ZEPH4BJx9xtI/VDY9RcajjhHBmPNolvGEGse7Hw3PNsEIcciTnthKIKBdcaPKWQvHrj26eN0/AD0MjmqTOsgUZ1pOf1rWzAqa9mwnNeKTo4yd6o4uQ4PwdvSJOwPUfdNkceamOVOwPI9hAV5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0dqoKVhc5+sdR8QGU3tJAlLWkBNSGc9w4l0seMdfmm4=;
 b=fKW0iI35x00ZfzVkWngmKmgmXjOC57arzCAkicCLdHhirRQvCNEDZxFJD3VKz19KMsnoqKgj/PQpG2m+BGzHuHnl2YzJCsuEYU0LfiRK6qYgeygRiTzmcnx43V4Y3w5TL5aWiKd83hkMz3PxKTZheJSBXg1sdmMP32aMAXFFxhJ9tOu5lwHY/1sIf563dSLMzTylRVtUrsdWH5sh7ufrJxJnMKV5DSw7UK3xvrp4OH6/GoJGIxiqouoU2Xr9k2jcFnelTKtj9CZQOMaiRAM8Dhogy+HzJ68V67Tc3JIvQe0CGrkllu8cm+WbtOLoj/Uc+4qXmOkvP0HIGnyty7gx7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by BL1PR11MB5477.namprd11.prod.outlook.com (2603:10b6:208:31f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.20; Fri, 24 Nov
 2023 00:54:42 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::24ce:9f48:bce:5ade]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::24ce:9f48:bce:5ade%7]) with mapi id 15.20.7025.020; Fri, 24 Nov 2023
 00:54:42 +0000
Date:   Fri, 24 Nov 2023 08:45:38 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Andrey Konovalov <andreyknvl@gmail.com>
CC:     "andrey.konovalov@linux.dev" <andrey.konovalov@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marco Elver <elver@google.com>,
        "Alexander Potapenko" <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "Vlastimil Babka" <vbabka@suse.cz>,
        "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>,
        Evgenii Stepanov <eugenis@google.com>,
        "Oscar Salvador" <osalvador@suse.de>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH mm] slub, kasan: improve interaction of KASAN and
 slub_debug poisoning
Message-ID: <ZV/yMuH6jbfD6ZPi@feng-clx>
References: <20231122231202.121277-1-andrey.konovalov@linux.dev>
 <ZV7whSufeIqslzzN@feng-clx>
 <CA+fCnZcAnZh7H901SZFsaU=-XrpUeeJwUeThMpduDd1-Wt0gsA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+fCnZcAnZh7H901SZFsaU=-XrpUeeJwUeThMpduDd1-Wt0gsA@mail.gmail.com>
X-ClientProxiedBy: SGXP274CA0012.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::24)
 To MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|BL1PR11MB5477:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ab128ee-7f5e-46a2-d561-08dbec87f16b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MgSs9644aJIQUVMdWdNiF5tKTwpaNLeTSApKQN5QjdFNc3sTuq2f+hKtyAZKoSIsBvx53PHfbE6hzGpG4m2M4c4QSudW86xwVwfwheYxgw+EreN3VcNmBKU1XOXKEz2/tMVOKi38jPurWdAgIIRmCV33sWHC5624hoiD+aIo6TQi9OLrgkF6Wy8BPgmVI5aS45ezWqQShKyNgyDYkg2jYKqnuebCp8weaUXMcrIk1NEmNfwrqbX8F3LiAZzydyDswdEq9hqOYCx930Ctr97o4DMuyLROjKQ3MQq4X98fNBZ+DuIvaCilTaqPYr+DBt5TsNGv5m9AIoSXPVXoVWPklKP/cT69+UITrGStrsd2Asd1Jqipq2ygqmBisWS6xgJZ+LsjMxxXD1y72xHkq/wtJ1eIJ14gIi0fn3363mC4nrEZL+ON+F6ArSnUspiaF7mGTX8CBcaAHxAi3Mr7GdgEIKzXLroeTpoRENhtxb2J7KpEAFmB0zLJV1Ivk4IO7wOC8+5MwZlFnqsR4iQ7KLH7QGbZQihWBITjw0CiEtEkH1nBgl0I+BynfaNHqCjx3Efo
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(376002)(396003)(136003)(39860400002)(346002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(316002)(6916009)(66476007)(66556008)(54906003)(66946007)(6512007)(53546011)(6506007)(6666004)(26005)(478600001)(38100700002)(6486002)(9686003)(33716001)(82960400001)(83380400001)(86362001)(7416002)(5660300002)(44832011)(2906002)(41300700001)(8936002)(8676002)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N2RZalZKYmhSbDFKcHZ6czR2TGRVTWdhQ3hnUStnVEp3eVhwK1pKOFp1U3pj?=
 =?utf-8?B?Q0pLT1h6RmJkLzIrVjE5ZFEyeVdXbkpRaHZzbXdhSGErWnBiT0ltRnczUG5r?=
 =?utf-8?B?eHNCS1JwTGNJN2ZUWTBCU0xyQ2t0WDNUVWhyVmozMXdpNXpWMkJlb3hSMDlm?=
 =?utf-8?B?NUw2akhYVDc4eFJLbS94d3lRRnJJRy9nSHdFeHpZTDVoeW93dnBxblNUZVAz?=
 =?utf-8?B?MmxkdmgvSFNuam55NHlITjM5MmxZZVF2M0ZVMHA1MklUOUErbDhmQ24rVkpT?=
 =?utf-8?B?WVJLYWNMSVFJeXhPekVnKzJnTW5NM2I0Z2JMWS9IbzdPQ0M0SytWVWtoMHc2?=
 =?utf-8?B?QTZsMjUrWUtDK3cyVmdVMVgzZEVGN3FUUXpwM0gwNHhYNTErM3dGNUt3N1Jy?=
 =?utf-8?B?UEJaSGNMeXI1dHZneVZqM0pmR1FqYlpRNEdSc0g5K2xSSDN0KzNCSDRTdXlV?=
 =?utf-8?B?SmNvMmwvQzdidnh1ay8xTUNIdFZNOVZzaXNOV2hhMk5YNmVITWsrNEdiVWxS?=
 =?utf-8?B?OXlhWDlpUVM1OGlWY0RCN3ArV0lHaFBSdmhuZEc5OVlLK0lEWEQ4akhJSDlF?=
 =?utf-8?B?aXZXQldtVDZWUXo5RnFvSjN2YmRSYmIzUU5tRDNSNE1ySGFTMWpjaWNMV09B?=
 =?utf-8?B?WXFGTVBiTkg5MWJlNmlWYlVUOXRmMTRoQkQ0UTRQY2NPUUkvU0JkWHlTczND?=
 =?utf-8?B?N0k2M3JPVTc1NTNNSnBxeXhhZ2FJM3VUOStLS0Y5SVNLVG83WFNCWFJUQlJp?=
 =?utf-8?B?cHMvbi9EaVlrZ082ZDduWlpIeGZOZklSWGw0M3RsWEZhczYzNjFWVUFjbUpt?=
 =?utf-8?B?b1hhVXZDc0F4SC9La1p5QnVvMHZRbDNNd21IYUZRYm15enBPZFhReGs2UTZW?=
 =?utf-8?B?TnMyU3ZKbGkrVk82SVNvVklNcEUyK0xHVlFFTEludS9jdDJvaFE3QVBqTnBT?=
 =?utf-8?B?dnlHM0VGVGtqSmd6azBMTnpDNFBvS2JzU3JlYVNlcENibDlwS0JhdjRjb3Vl?=
 =?utf-8?B?RFFGMGc1RVZwelNvNEFuV1VvckdCaXdzUmFkNExHQ0xlZWpRUlFDMXorTU1y?=
 =?utf-8?B?OEM1RkJHdGRMUGkyaHJ6N1c1STFlaVZzYTI1RWtyNFZzNzB2REdrb2VwRkNZ?=
 =?utf-8?B?TUpuTWFNbGtySFZkdlU3YnBxZzQ4NjhMSDEyL0toVkR1Yi9SSjVhZXZkVjVh?=
 =?utf-8?B?dWh0TUFTMWlpSHNiUHcxZk9sYnVMaFRRRkVyY2pYb3JVSVBtaHZzakdVRnFM?=
 =?utf-8?B?b3VIcFg2R3N6SmF1cUpkblJZMXhyMDN5UDg2MkRnSGFQd0pkNnVUQWFUY05P?=
 =?utf-8?B?bnJWRDQyM0FJSEhyOEppdDlaRVY0UW1rZGErQjV4bEk0MlBwVC9uQkxpNWF6?=
 =?utf-8?B?WFQxejdJcHIramhPL2FaNHFCazI0eTJhd21IR3dsMDJ2ZGJFWGEvdjVZRmls?=
 =?utf-8?B?dnlNclJBZ242TVU5MmM3Qld5ZVFaZDRYWHdrT1hNWHE0NEZtT29vamZqOGth?=
 =?utf-8?B?S2w5UGk3NURXeVJ3bCs2eFk0RUVhQlliTlBndU12cUI2RlZwVFhUeTFtVzFX?=
 =?utf-8?B?UlJEKzRJSjBVYWR0bXQrY245V1JvU3RGR09LUCtYUk43UFFST25BcFJUUjJ0?=
 =?utf-8?B?WVZjS1ppbUxDZ0hrK1dUaFNyQUpmOHRpNEhuWWVBbHJtakIyb3Zvb1RWYVk3?=
 =?utf-8?B?UlVDVngwaHEvNzdpNEd0YlEzdlBNajFWVk05ZVJtekU4ODRsL3A5WWhlTHlH?=
 =?utf-8?B?WVZpN1ppb3ZXSkZOWFFxbllhMStLbWMzNGxqankrNHhUMVN4amkrdWNLZnB2?=
 =?utf-8?B?czhSVTNDL3E1SUY1WnhKUTRMUjBuWHJ3MFRaakNZN25kNWVpOXBQVm9tNHNS?=
 =?utf-8?B?cnFSVzNMbzRNWUszSlpDUTh5YlVqbUx2Q2ZpY0FjM3JGWU5ETytIWlYxUS9O?=
 =?utf-8?B?ajlteVRRY3N3RXpNTnl2VlJkbDdQa1NOTWduWm1MRXppcmRNc2JPSmtleUtk?=
 =?utf-8?B?S2U2cHFvd3FTMzd2REdSLzdGSUJuTGZCY2w0bk9KNUZkTUtYcTBkS0xwTEM5?=
 =?utf-8?B?UitYU3dMQVE1QkxKZ1IvdUlYandQSkd2NUw0RUE4M3U4a0FScGh1cVE2QUx6?=
 =?utf-8?Q?0uxhnJEQ4e5Z8dyA/nfKgsyLl?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ab128ee-7f5e-46a2-d561-08dbec87f16b
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2023 00:54:42.3443
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /nUxwmSeTmPbetsbrgFeBHPGSd2YXarcp+35n9B3OG+g5/znCo9IcZwNkIt69oQmfHzZu/Y8Oi/tlyOIH5T49g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5477
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrey,

On Thu, Nov 23, 2023 at 05:12:08PM +0100, Andrey Konovalov wrote:
> On Thu, Nov 23, 2023 at 7:35 AM Feng Tang <feng.tang@intel.com> wrote:
> >
> 
> Hi Feng,
> 
> > > --- a/mm/slub.c
> > > +++ b/mm/slub.c
> > > @@ -870,20 +870,20 @@ static inline void set_orig_size(struct kmem_cache *s,
> > >                               void *object, unsigned int orig_size)
> > >  {
> > >       void *p = kasan_reset_tag(object);
> > > +     unsigned int kasan_meta_size;
> > >
> > >       if (!slub_debug_orig_size(s))
> > >               return;
> > >
> > > -#ifdef CONFIG_KASAN_GENERIC
> > >       /*
> > > -      * KASAN could save its free meta data in object's data area at
> > > -      * offset 0, if the size is larger than 'orig_size', it will
> > > -      * overlap the data redzone in [orig_size+1, object_size], and
> > > -      * the check should be skipped.
> > > +      * KASAN can save its free meta data inside of the object at offset 0.
> > > +      * If this meta data size is larger than 'orig_size', it will overlap
> > > +      * the data redzone in [orig_size+1, object_size]. Thus, we adjust
> > > +      * 'orig_size' to be as at least as big as KASAN's meta data.
> > >        */
> > > -     if (kasan_metadata_size(s, true) > orig_size)
> > > -             orig_size = s->object_size;
> > > -#endif
> > > +     kasan_meta_size = kasan_metadata_size(s, true);
> > > +     if (kasan_meta_size > orig_size)
> > > +             orig_size = kasan_meta_size;
> >
> > 'orig_size' is to save the orignal request size for kmalloc object,
> > and its main purpose is to detect the memory wastage of kmalloc
> > objects, see commit 6edf2576a6cc "mm/slub: enable debugging memory
> > wasting of kmalloc"
> >
> > Setting "orig_size = s->object_size" was to skip the wastage check
> > and the redzone sanity check for this 'wasted space'.
> 
> Yes, I get that.
> 
> The point of my change was to allow slub_debug detecting overwrites in
> the [kasan_meta_size, object_size) range when KASAN stores its free
> meta in the [0, kasan_meta_size) range. If orig_size is set to
> object_size, writes to that area will not be detected. I also thought
> that using kasan_meta_size instead of object_size for orig_size might
> give the reader better understanding of the memory layout.
> 
> > So it's better not to set 'kasan_meta_size' to orig_size.
> 
> I don't have a strong preference here: slub_debug and KASAN are not
> really meant to be used together anyway. So if you prefer, I can
> revert this change and keep using object_size as before.

Thanks for the explanation! I got your point now. I'm fine with either
way, as this change can help to enforce the redzone check for all
kmalloc objects, while can make some debug wastage info less accurate. 

Thanks,
Feng

> 
> > And from the below code, IIUC, the orig_size is not used in fixing
> > the boot problem found by Hyeonggon?
> 
> No, this is a just a partially-related clean up. It just seemed
> natural to include it into the fix, as it also touches the code around
> a kasan_metadata_size call.
> 
> Thanks!
