Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 872C377D4C1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 23:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239862AbjHOVDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 17:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240093AbjHOVDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 17:03:11 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8D68F2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 14:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692133390; x=1723669390;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=P51F780r7pTYMTpWoBDH9zYFQH3Q8QwUrqZTPqGRaO8=;
  b=cCL872bAAkSo144oxo2UzbVr0pq8vNtME8oTe5RLgPkEPx/zC6V4q+0X
   LtvD91PbWrVECjsQ+vFFwW+vyomW3wJhuUX0edwVN59sVHmqhhVg9P2pV
   +TqK/551T+R0d0xxpJ9VCc0pNUmGTTJNEVS+OBOHroP5si1sMeBNucEY3
   4PIGo3dpRBnJtB/Y7b7AEI7TRKund/rPqs37XehvzCGBwvZEOgSPmjWk8
   tP7Kag5GVWSM9ieLc5Mm/Hw56tYtv3c7fyNtuNNYsQZkMF59hM2NYWKlO
   5y8Kqd/1cbw7n1yU/qzja73oPeiJAyAhtyeIyIPzN8cOj13hkWWjpoWSe
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="458729726"
X-IronPort-AV: E=Sophos;i="6.01,175,1684825200"; 
   d="scan'208";a="458729726"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 14:03:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="980477295"
X-IronPort-AV: E=Sophos;i="6.01,175,1684825200"; 
   d="scan'208";a="980477295"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga006.fm.intel.com with ESMTP; 15 Aug 2023 14:03:10 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 15 Aug 2023 14:03:09 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 15 Aug 2023 14:03:09 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 15 Aug 2023 14:03:09 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 15 Aug 2023 14:03:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g4GAtOSD2a5ODhSoKCesBCzH4uW9zDUtlVGHluGavBfY+LtonK9wGUzDVQxDyT4P34U/Z7ZQFw2uxtBqPSQDLiX/uJxt4iND/MKL7xXFSXIsOOA7WJKX8GJQJf5ZpiagHuHwCfE93Iuypolbo2BHES3nlnDeIrnmtGx0bUOJb0FRR9utl6rhb/Kn9jA+esoGHLi5arE4/YDLnPVaXpbesKs1m0ErTy3d1uuVtz/fGVRIEaZJpoPCKoPOPZ/qD1iG+0iFM5bJXnvIWjNiM9JGhgm80Vaje/IqQFhsXowiznFkN9i3z5uJ7wfovIkTZ51Xtjrc0fsJCY4lMNTLBwfknA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xq5/Gp//xy93JgJAVKBwRWj61MSukzbQxympbxNybOI=;
 b=UDNduGol44FWigjaFgvh95zSdO9wb0cQkhpgaltpjCTJklQuWyMkfqKyGr0ZsVlBIFCELu8ElEu9T/tSkQIiBxqMg2y5krGcuF9zjLF2KhBGLde1Q8hEMp2n3nInrX3dnDVe9+BFCsX95AgsEz9u6FnLo2YPPH7IpnZb/jlyXmsu0GNLHzbgTfTCHiDMPcRbvHpSmU5nBNo9YX3X4xf3hnftQ/hbDNGZVNqeAMC48OSGXGfmxYqWZKI97a9LUOwu0RYH/GcvifCrACujh8E/UGIMKUUZMLX4D9lQ2kvr7b3wJJ+mamkoWOAu0tLDsAMJFb4mloA+yje9nMq1pvmwVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB5914.namprd11.prod.outlook.com (2603:10b6:510:138::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 21:03:07 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::acb0:6bd3:58a:c992]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::acb0:6bd3:58a:c992%5]) with mapi id 15.20.6678.022; Tue, 15 Aug 2023
 21:03:07 +0000
Date:   Tue, 15 Aug 2023 14:03:03 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dionna Amalie Glaze <dionnaglaze@google.com>
CC:     <linux-coco@lists.linux.dev>, Borislav Petkov <bp@alien8.de>,
        "Brijesh Singh" <brijesh.singh@amd.com>, <peterz@infradead.org>,
        <x86@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/5] virt: sevguest: Prep for kernel internal {get,
 get_ext}_report()
Message-ID: <64dbe8079511b_47b57294de@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <169199898909.1782217.10899362240465838600.stgit@dwillia2-xfh.jf.intel.com>
 <169199900677.1782217.12516417657696965559.stgit@dwillia2-xfh.jf.intel.com>
 <CAAH4kHbRkFdmdQyPHjOjnnyuYXPLT2GKmQTE8fU9aDFMtri8ew@mail.gmail.com>
 <64dab7a322eef_2138e29421@dwillia2-xfh.jf.intel.com.notmuch>
 <ed962dc3-1e7e-8959-7921-365fae705594@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ed962dc3-1e7e-8959-7921-365fae705594@amd.com>
X-ClientProxiedBy: MW2PR2101CA0024.namprd21.prod.outlook.com
 (2603:10b6:302:1::37) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB5914:EE_
X-MS-Office365-Filtering-Correlation-Id: d094ddd3-bcac-4aef-5e5b-08db9dd30663
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Nmyt8Mz+teGsHzAw/8D9X6M9NwdiI++FGxduglVPWkUC4Wnj0XGY+wpZre7Gm9NCCcwhTEGFsWaeItI6PB6AaRmnv6iVOCytwci7ZoPkPtp/Hn7+3l5+kZFaw3c7DEIbfrmCV3J1Y/0jP9zNuilnNmZ40ZRIuFh8L3dM6yc+R7DWJNP1gi+ppBrVgXtioml3YLZAG0aw3q923mLTT3VWjdigjkz7fieF/TtVYNpI8R3C1yO+jqdO1jgbZ5BMFI5tL+lakuoPlBfS2RTVvqOhT5YWICaD9t8f7H5mNqnvsX8M2R/9+iD2K36dG9lohilX0+9vwmu41EDpQOxGPwWdCMM/YJC4APoe6siCt/xJL8dEWi+TlLq9aRsXd8Y39K2Jqxua0py8gMNCpLC34RPUo+AsHkZumA/jNtCHTdg89ICQV8AbllrG14/RW7QdQH+OxEZWZBwRB1Orif8WkXC/28iONRquo7NfPcfe8MpdyyeE5jQV5AzybE9fm90i5qOMnrUbb9Vh7G2CftvCr3ytVmLtnVqUyepgohj1MCQoDjk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(136003)(376002)(366004)(346002)(1800799009)(186009)(451199024)(82960400001)(83380400001)(2906002)(6486002)(86362001)(9686003)(6512007)(110136005)(38100700002)(6506007)(478600001)(316002)(41300700001)(26005)(66946007)(966005)(54906003)(66556008)(8936002)(8676002)(66476007)(6666004)(53546011)(5660300002)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?i4UD4F4QeHo6gNMIf1IXrFURnVOGyzn2UU6GgbkkWLZ4cjuKniU3x+6j5wfF?=
 =?us-ascii?Q?vBrAhra6eRbxYCAgDeXPKFHd3GSZq6MTy9k9OmGPYySQFN3Spxdw4vVbYAmT?=
 =?us-ascii?Q?PqNP46iP8Nzfg8wb4zj8ifB9+TwtzEiAGrw2US8N/EPb2jvd9011ogqkzMOr?=
 =?us-ascii?Q?zrzHr2BzKXRSk1u8Qb8+aC0uc0UGlrFWnYVk6WQA4emRABwtYWXrsdYlyQ2G?=
 =?us-ascii?Q?gpmTmHU6Aw8G6H/V5WgT/4yTFm6EZdrcfRnt7dNkqa3qTRl2kSYTgyO3Ep6x?=
 =?us-ascii?Q?DhYkLbHqyIcGX79TFrB1AzX9cQfeQc/Su+/Ja54g5/WTvo88M+I1RxFab537?=
 =?us-ascii?Q?fod2EUqggV4SchvxrzY71hw2Ju8C8S1r7oyw148F9BNTScWjT/6rOIuGS0p7?=
 =?us-ascii?Q?UulcfeB28HvCda6jB9o4lrH/R1Yvr9EkS6cSl1xZkIqPKB6e8TmK7sgRiyyp?=
 =?us-ascii?Q?o8WCF1CW1JaXu0Hq/10RrvLBU9Dte8sDjXCZfJ+SX97m1SWGt8hhVJ25h4mP?=
 =?us-ascii?Q?75ckCfNnyFUEKet3NkwFzxC3LhC1arxxAj+A9Y/Eempk4Y9O5k6h2OtlXRNU?=
 =?us-ascii?Q?zcJ89rUSYyq/BSviVLQffZatQZQOK3lb3CPFLals2gbsuIczuot5/+VQVi6X?=
 =?us-ascii?Q?AcxziOa4w92zoxKniTRt/5v44wp5jYwxqzAi7Uwwv5O9o10t/kkyEaey61uC?=
 =?us-ascii?Q?cbuRBxuZ7CtL8kHk8ZZCR+RGtJhnIOJvdLOp6et9weyGtGq5vOzISj8DNUS4?=
 =?us-ascii?Q?+Vs3ijktjPbZZTUiFKt2Bai/8TDABFccK4xNeBYkcH75SgiKKS+VqPd0h/0Q?=
 =?us-ascii?Q?tp2Lczpt5NOwby120KQKkmssBaipYh3UMBcpxYiy82QjrNdUPaBUk/5uLMqg?=
 =?us-ascii?Q?3Tftk4L4OTL0ucxbvHwbm71OYaJ+0ojC+gQkmbNydjRal+wl1wM3m2X5nWBo?=
 =?us-ascii?Q?y3AaMBgLrF3FCtutO/vyyiOlJV/paEiax3iSnynn+dbdeGmw7l4FQZnu8j/+?=
 =?us-ascii?Q?F5/xaFj2eMf7afDNErDp+tVOp1IiTOnmbIR7ieN1lNRBRtUanjPP8+9995NA?=
 =?us-ascii?Q?VHYQMMjUZ0kSFUOHlxSpvqDXN1oyKPglSawjyPRBx62h9voFilQa9l4+SIfE?=
 =?us-ascii?Q?HHwC/He2zQmDC5SnB+UOKUj6WlT0v5icSqmsY+QdSFHkrUFpVCrUIGQW8kUO?=
 =?us-ascii?Q?gy9BobOFtc9AinmqhgTKVIdgKxWNRtPQaRrbswV/A6ernziEk7Ok5siEKexr?=
 =?us-ascii?Q?0P+uu6dpjyZjM3X1C05UML5b8Mzv3JlG/ouQyPh1/k5jnbLC9tGZDiRa1pZ3?=
 =?us-ascii?Q?4uWQXIm+rXkoPKIoLQzeZcTV+/k2rz7wJjyvsPTEvDC21pZcEF/delqm9PtR?=
 =?us-ascii?Q?zFCpkuFI8esd4C8Ew2muiMSj6DrNwic6voyMaiprNEsOI9UBJiF6rWN6P+EV?=
 =?us-ascii?Q?PJa2BsfUY5poDhrr9/mcBEEcExvl1ps0c5BYfnXjSqSihA/QOhXEYCYtiSGr?=
 =?us-ascii?Q?EAfgyxsT8gbvc2pQsPS5XKShzzd0q10fakPzfcFWBkCs3xpG4wGu9MjT+u7J?=
 =?us-ascii?Q?A5nBTjO2vKM72/qRqSJEnbHFhRqTZ2nLkPpEsWh5Z59g68C8OF2U/1Ies19z?=
 =?us-ascii?Q?vw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d094ddd3-bcac-4aef-5e5b-08db9dd30663
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 21:03:07.5576
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mdcy7Gi5XoZBP0YbLT7LHBJ9356k8gSlTqnCYps/cb93j+EeLLVolJbrvQfQwI9iJCy59jTcnskA/qZfJaBbhL/ukOK8DVbg97B5vjmwiUQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5914
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Lendacky wrote:
> On 8/14/23 18:24, Dan Williams wrote:
> > Dionna Amalie Glaze wrote:
> >>>
> >>>          switch (ioctl) {
> >>>          case SNP_GET_REPORT:
> >>> -               ret = get_report(snp_dev, &input);
> >>> +               ret = get_report(snp_dev, &input, SNP_UARG);
> >>>                  break;
> >>>          case SNP_GET_DERIVED_KEY:
> >>>                  ret = get_derived_key(snp_dev, &input);
> >>>                  break;
> >>
> >> Do we have an agreement around the continued existence of sev-guest
> >> for supporting derived keys, is that similarly slated for the chopping
> >> block, or is it left undecided?
> >> It appears your choice to not include the uarg/karg extension here is
> >> deliberate.
> > 
> > I do want to understand the argument from James a bit more, but the
> > exlcusion here was simply because there is currently no support for this
> > concept from other vendors.
> > 
> > That said, if it remains a vendor unique concept and continues getting
> > suspicious looks from folks like James, it may indeed be something the
> > kernel wants to jettison.
> 
> I'm not sure why we would want to jettison it. Just because other vendors 
> don't have a key derivation function doesn't mean it can't be useful to 
> customers that want to use it on AMD platforms.

Definitely, instead it was this comment from James that gave me pause:

"To get a bit off topic, I'm not sure derived keys are much use.  The
problem is in SNP that by the time the PSP does the derivation, the key
is both tied to the physical system and derived from a measurement too
general to differentiate between VM images (so one VM could read
another VMs stored secrets)."

http://lore.kernel.org/r/c6576d1682b576ba47556478a98f397ed518a177.camel@HansenPartnership.com
