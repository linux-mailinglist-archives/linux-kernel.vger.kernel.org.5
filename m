Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02DB77CDC29
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 14:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbjJRMpb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 08:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230476AbjJRMp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 08:45:26 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ECCF123
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 05:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697633124; x=1729169124;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=alldLmkQreYI4FeQqgnzSTJCYZ3EG4E1C8fJJzNjTp8=;
  b=ftZmBzl6i4ebuxXcqu409wmQ7jIc+1lyz3hfFbx2qp2oZhKNrFkAoxPw
   qnbi889jKDvBLsXFBrOqkd2yOZu59J3WMyVB49vHzoQX3XaGH+6p3WT4/
   nN2E4wHaqcK7O+s1x6jhNu92XhhZD3UhGdWKzk1MHIRGd+21CZUc1j72O
   nfXgTZx+PvX/drPYV+lpzuC8XCCYhGSJEj6TwRVU8TpwpN+3AdZCAMIkW
   bZEklccCtdn/nVxNMpRL7BzY85LZMmJJc+6QWjiyrP+zG6vMLKg/Sc1Bm
   KqrQILenlU0zJBmSyLXdz8uA1YgdOu5JHH3vImbN0Cppqx6Q9xFdl/bmQ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="365352704"
X-IronPort-AV: E=Sophos;i="6.03,235,1694761200"; 
   d="scan'208";a="365352704"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 05:45:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="785922328"
X-IronPort-AV: E=Sophos;i="6.03,235,1694761200"; 
   d="scan'208";a="785922328"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Oct 2023 05:45:23 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 18 Oct 2023 05:45:22 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 18 Oct 2023 05:45:22 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 18 Oct 2023 05:45:22 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 18 Oct 2023 05:45:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RW0fxH9mR35SJie8SMptpYlCfl6IG5pzJyKow4w1OuyJN+brEJvboAU/2BRJObO8L3bS8m7Wn8yBaHG93GQ8dqEJW2PmGyvtd4P8gPgfOd6CCKBmHbNwTxzuWjoXCOiAN3pPuXslegdpPRKthYCIuqXSY3rBS9ETKdy2o0nQCbs+8s8V215J2hxfVf1ULQIw4k+oFpxj57T2g+j0KYqreEyYkUZMd/cCv6FJ6+ruCh7euAUKuAqh2sIb+QP5qStDlEoXi2NDxcrk0L+CxlhqGsVUCPtcH4+I02WvHaqeE6xWvmVvbSA3s4DwYyNKDbthLBrp11rozgbcHMfUwDipcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nhu14WLj5yViqp4frJ2MfkDvKHqsvPy2Am6P4DKUNXY=;
 b=hM7n3jZb8RYmx+I9qR2pHKzcsdxnXyR5iY3YHDD4Bl3yEg2BBolakDVhcIRAXRHNpPcc1i+qjC9FeNj4Ex68fLz5NnLXQu+FwGFeb+hd9wzrZ/pqcTMyKkPi+HtBE2Ld8GL54J2s0gHNLQ3Np3R4RHr4mmn5qGTMvDVXDE3jfak1jE5GWbnAlKrOv+T+MXim6q30XYm3suEgmJl5OUqyNW19aTXRmBSwjuj0g/KJmK3DXyLhf4lHyzTLVOtZklhQWYwx06ySWt67GHACuVnF0vhvLbYW7WrcK46eoTJok4C10wDkellJ41islukyGIfOg13tKNbZk6EAN9aBm9kGZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB2995.namprd11.prod.outlook.com (2603:10b6:208:7a::28)
 by IA0PR11MB8397.namprd11.prod.outlook.com (2603:10b6:208:48b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23; Wed, 18 Oct
 2023 12:45:20 +0000
Received: from BL0PR11MB2995.namprd11.prod.outlook.com
 ([fe80::f64:17c0:d3ab:196]) by BL0PR11MB2995.namprd11.prod.outlook.com
 ([fe80::f64:17c0:d3ab:196%7]) with mapi id 15.20.6907.022; Wed, 18 Oct 2023
 12:45:19 +0000
Date:   Wed, 18 Oct 2023 20:45:08 +0800
From:   Philip Li <philip.li@intel.com>
To:     Baoquan He <bhe@redhat.com>
CC:     Dan Carpenter <dan.carpenter@linaro.org>,
        <oe-kbuild@lists.linux.dev>, Lorenzo Stoakes <lstoakes@gmail.com>,
        <lkp@intel.com>, <oe-kbuild-all@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: mm/vmalloc.c:3689 vread_iter() error: we previously assumed 'vm'
 could be null (see line 3667)
Message-ID: <ZS/TVMT9ed7OdyNy@rli9-mobl>
References: <f82be227-bfde-439a-b339-1b4ee370d59a@kadam.mountain>
 <ZS+dSd9Z6/2wU0Eg@MiWiFi-R3L-srv>
 <89caf59a-d3b9-409d-b1ae-9e370cb9ee7d@kadam.mountain>
 <ZS/LrhcxcMOgiiX5@MiWiFi-R3L-srv>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZS/LrhcxcMOgiiX5@MiWiFi-R3L-srv>
X-ClientProxiedBy: SG2PR04CA0156.apcprd04.prod.outlook.com (2603:1096:4::18)
 To BL0PR11MB2995.namprd11.prod.outlook.com (2603:10b6:208:7a::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB2995:EE_|IA0PR11MB8397:EE_
X-MS-Office365-Filtering-Correlation-Id: f4754557-25b8-40ce-8add-08dbcfd8156e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XxBGY8VqUad7kqqMe+vsxF8YG9J8t1AoaAeXDrbyvuvE0o9QHR3KYgNNzvWodAX77Kyo26Jqr/C21PXV3t12BmXXa9md3vg1cSldy3U9jKGiJUpulBkj55An0XouqGe46daCkloR0mXqThQiHSLJj6N6qUJ2C98wFq9Ou+95GnL6c0XvS1CBRJGc4PFGqdoaBm4UieXkFHZ6KH3/175E8Y51YGkzI6z9hhosmUFuhWWUb5TmQvT7uNqbOPJ/GLTFCURMrhChkYBoX8YYo+BXQYu9o1bMjQaLyo2DWNMF3BbV/gukPQQofHWjlkeLp2yymImqqToa7Tt8APAjQsBtoJhiBYcFYf+uLjrO40biWAM2c1FjFzB5HIp5Wc0PnMAfDnJmpbUQfUnLJmHh7LG52Ml9pY9E85q5vZi7lsDqUcHt7JCj8t3wD7lrnFsV7YRSdPI91NCmrX9zmKOLvYofA72idNfcAHltPmGMlAlJtMEoLTeO96d84yKyG6FU138jMxqrNkpkm4GMWRS2U4uGO+hiOtaSmZMPYF04n8HOJ88h+Z3rMllJ6eVcaCdcUPNM5TU18+3lw7jRqWqTNnWAcQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB2995.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(39860400002)(366004)(396003)(136003)(346002)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(54906003)(66476007)(6916009)(316002)(66946007)(66556008)(86362001)(38100700002)(82960400001)(83380400001)(26005)(9686003)(6506007)(6512007)(6666004)(2906002)(41300700001)(6486002)(966005)(33716001)(478600001)(44832011)(4326008)(8936002)(8676002)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XMS6oohZHkDHc4eF9B1JLtXI9n2kQ9vhyXlTiSsbJduZwKouuELxxeX+Fl6Q?=
 =?us-ascii?Q?bo4rmad7jSMdsJLjdZ/5pm/yL0tBrmsP0CJJhio7Q98yBtqKTMKdXs+68isZ?=
 =?us-ascii?Q?MOP3wAaqBEF7RyNqyS5zJDuVLLNq17aRZ3bpw5GK4QJczPTYHERYqPU5xD/h?=
 =?us-ascii?Q?TqHITqksKIzt/wjKLSfZOkH2oGS86oQ2FrxqMvt6BjpmiRwrKG2eFqrS2SO/?=
 =?us-ascii?Q?L0lekmr2hYjs+zq5iy3L+yOkl1KZqLEFVIHycAUyAiiohEfojAWZMUD2aZgD?=
 =?us-ascii?Q?Fn/RMOTg0a2cBmTSGpbjq5yRT7Xhp4r6+2Rr/kGvt5TIXw70WKDsJuKe3LYl?=
 =?us-ascii?Q?3lOg9lakRUCQsdmZj/sfPrf/Y6v35MZP33QMYjpXtAL/991BK8gIe9Gc4oaW?=
 =?us-ascii?Q?JDPG/TQHLqEn1tgA2E4gNwZU2bvd2NAMC5qirgVsNFBAHpprBcUemIa+BMUA?=
 =?us-ascii?Q?EQZ4JbJ/08AXKY4HDdnrrYBeG+TiFQ3w001YFBhGxPGcT91nTXL8t0Ry5sCE?=
 =?us-ascii?Q?ZuGmckv7nEl77KlmonwGpf/pkIFv1rC84onBIXDM8+gsbzseu3YM7F4ttMP4?=
 =?us-ascii?Q?B/d1qEYgZxdcVfyJBfivto8d3GR6CIna7zouJD1QW2EgO7/VV00aKs53ww5C?=
 =?us-ascii?Q?6LHLlc/UkqXviS5/khZVmvQTy+x6VwsxyHt1pMktQqy8mX4GqKqo29k1edRD?=
 =?us-ascii?Q?qr8JjgXAbV7gAlRGqNLN7LPdy1LAzPVUOhKeH5Xi/ntmN7OZsgFneGj0I9A7?=
 =?us-ascii?Q?Y11wA9AM6HYCkish6+3MMKZ53pjHbMtftMJmt6YCRUJbZwo5pSCtlm1xMUg0?=
 =?us-ascii?Q?Ysc8t/OsG0U+oJBNSS50RuO5Pv7LmZM9EpfR71NP85XPO2wmQh8In1Ar8JUo?=
 =?us-ascii?Q?fcZ9vIQ9WvfooBRKuOdYB9gCesfXyC6aa9yVMuWhIEuPhkkZo+DX6PJ3d7sL?=
 =?us-ascii?Q?s7MnrKbmS/a8yuBlP1zCHo+I/EOVwHEsUgimABfz633n6T9+VQDUYgSsAGJp?=
 =?us-ascii?Q?4nf3deBxNikGRjUBDlbhB0tXqms42YqkV1LDw8z+OWv1ZnBlLvRX74PxjU2N?=
 =?us-ascii?Q?/JSZ8+YtGDUTRdiglKqk4UyubV+6i9E1YqZuw8pPhv39waZqS/qIe5/E/7zx?=
 =?us-ascii?Q?QfRbFoVVBozNnxkvNdpZyZwBPo5EQEe598i6DJo/nUPt/QXgivJRhiXrw2sG?=
 =?us-ascii?Q?Z332GPr+AxPM36HUXJOADFhFUHtdMotU4jv3RWp+WV9/oG4A0QbIKD4oN48j?=
 =?us-ascii?Q?LPL0ofYQL7NM3wNtRx4pkWGtrrqkG+MMPJdh2ei01IMTKGkuYSj9PIfgU3Sg?=
 =?us-ascii?Q?0uLb3k7VLnOCFVq8412n0M3jFEN+G+rZ2rAwWs81VWVLssYi6cJL2eWcA7qY?=
 =?us-ascii?Q?wf2o3B3APupq8XshT87b2fgRtZ2/y21+EpFr5nyas5dxZ5iUKbgiUiKCYOLF?=
 =?us-ascii?Q?FG5LLnIf+tT5Jh0e0IM4t/tCIRfEELjCB5iIYxFlb3/FrUCCt1fF73dXUY6x?=
 =?us-ascii?Q?Fiyhkk66YnVVXAjWfAaFpTDP6uYh/0MKAzGqjXH3teghI5Tdr2vFm0IfZXa5?=
 =?us-ascii?Q?d2FwVVlFXS7mRegH4qTYCEs931NXrPl8hDAFHTLz?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f4754557-25b8-40ce-8add-08dbcfd8156e
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2995.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 12:45:19.1252
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /7jFZX0OhiHjH2u3qQf/e5Jid1IFiLn6FqTMEHBwN5iMgnk8eGAvBPVcSeU7I2rNTvsX3dIoE+kQjPKH0hVVCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8397
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 08:12:30PM +0800, Baoquan He wrote:
> Hi Dan,
> 
> On 10/18/23 at 01:32pm, Dan Carpenter wrote:
> > On Wed, Oct 18, 2023 at 04:54:33PM +0800, Baoquan He wrote:
> > > Hi,
> > > 
> > > On 10/17/23 at 05:26pm, Dan Carpenter wrote:
> > > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > > > head:   213f891525c222e8ed145ce1ce7ae1f47921cb9c
> > > > commit: 4c91c07c93bbbdd7f2d9de2beb7ee5c2a48ad8e7 mm: vmalloc: convert vread() to vread_iter()
> > > > config: x86_64-allnoconfig (https://download.01.org/0day-ci/archive/20231017/202310171600.WCrsOwFj-lkp@intel.com/config)
> > > > compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> > > > reproduce: (https://download.01.org/0day-ci/archive/20231017/202310171600.WCrsOwFj-lkp@intel.com/reproduce)
> > > > 
> > > > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > > > the same patch/commit), kindly add following tags
> > > > | Reported-by: kernel test robot <lkp@intel.com>
> > > > | Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> > > > | Closes: https://lore.kernel.org/r/202310171600.WCrsOwFj-lkp@intel.com/
> > > > 
> > > > smatch warnings:
> > > > mm/vmalloc.c:3689 vread_iter() error: we previously assumed 'vm' could be null (see line 3667)
> > > 
> > > I see the code deficit, while the reproduce link seems to be unavilable.
> > > Could you double check the link and provide a good one so that I can
> > > verify the code fix?
> > 
> > Here's a link.  :)
> > 
> > https://repo.or.cz/smatch.git/blob/HEAD:/Documentation/smatch.txt
> > 
> > Just build it and run:
> > 
> > ~/smatch/smatch_scripts/kchecker drivers/whatever/file.c
> 
> I don't know smatch and lkp well, and have no idea on how to use above

Hi Baoquan, sorry there's issue in the generation of reproduce step, but even
it is generated, it doesn't contain the detail to setup smatch. You can follow
the smatch.txt to do the setup.

> smatch.txt to build the target file.c. I meant in this lkp report, the
> config file is available, however, the reproduce file is empty. Could
> you help add an available reproduce file link? or give a little more
> detail guiding me how to make use of above smatch file to build .c file?

On the other side, Dan has added analysis to the report as below.
It's possible to resolve the issue without running the smatch check.
You can give this a try.

	06c8994626d1b7 Baoquan He              2023-02-06  3657  		if (!vm && !flags)

	NULL check

	...

	06c8994626d1b7 Baoquan He              2023-02-06 @3689  		else if (!(vm->flags & VM_IOREMAP))
                                                                                   ^^^^^^^^^
	Unchecked dereference

> Thanks a lot in advance.
> 
> config: x86_64-allnoconfig (https://download.01.org/0day-ci/archive/20231017/202310171600.WCrsOwFj-lkp@intel.com/config)
> reproduce: (https://download.01.org/0day-ci/archive/20231017/202310171600.WCrsOwFj-lkp@intel.com/reproduce)

Meanwhile, we will resolve the reproduce empty issue as early as possible.

> 
> Thanks
> Baoquan
> 
> 
