Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE5DB7DF787
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 17:20:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235446AbjKBQUH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 12:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235476AbjKBQUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 12:20:04 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 859F813A
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 09:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698941998; x=1730477998;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ifoi14LNUZsDpzywYJ2o+sPYwVr/bYOOsrKHkptvwrI=;
  b=JzcI/rijgerKMyyjvY2LPnshldLSFkEzpLvqZWYaxzvxi27hULqbufje
   ne+08RAmst+osbTpNb5lED0lHzqkza0pOz2wBzJ2HAwpm6d2w7M4EUX35
   HcCAX77QA4/eSr0NLkTV5+TShVIW/1iksMwCFphkSMJP8ZnUK5wMHKsnr
   pPWJv8i+cnlptkD7aTMgnidY13BHWglepN0YwrL1BDBDr0v9XHguqvZ5T
   iVKtcW3HAmi/kGgDkv3sGXUDfyzBx/9oWyeUyg2ewlGu9yBs1L8abhETi
   5kqO9y7h0x+Vb2IlUN57jxw2sMWijpmFqdrRqll7zJaaDZNgJLN8UofMJ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="392633951"
X-IronPort-AV: E=Sophos;i="6.03,272,1694761200"; 
   d="scan'208";a="392633951"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 09:19:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="831731588"
X-IronPort-AV: E=Sophos;i="6.03,272,1694761200"; 
   d="scan'208";a="831731588"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Nov 2023 09:19:57 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 2 Nov 2023 09:19:57 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 2 Nov 2023 09:19:57 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 2 Nov 2023 09:19:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bH1s6T7gPVBiuTmG5FReMirLWQ16/uOPVX32BkmClQOvDtUTuz1EAoO5dUDaPLHO4aw9fXs7n/2vp7I9hauezhQXWdct4qxNkkdedEujlXg/guoCn+wTj1U5abdBZnVcafqWX1mLt5npL9pSXRf2Kf9UEHxYM7vA7NgL5Q4wBsl6vFQ4CZzdHh8KwIB7UfQebL/bCDBywRcnvwJOMdzfX/D/vdjOhCCnGxZer+J88lVq8ptOlzhRSdtDC5G2Oz0/NTkDGMm0F9H0K7t2d1I8wFENxBOrZqkMSElTq4DBR/qwzcsSiQJEsKe+BPShidI08mqh1TQ/h1rHEKlSAgQndA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i8xRX38X++1jNY9MWvPo3CMkguRCodyMIpOTcIZVHGw=;
 b=fr0HCyHc4jkAirOYqLzXB4OJ4HONZxqpvOoZLOKYj3WHg1ZM6YOgq9nQSDzBYjl4eZwpAqlFDJFtr7HiAt/HdP57bhXkCMYVRCE9L7wFQSQ8IvN0tbzXSmQ+S3eZ0cCrSIq4IlEMk21JQd94wv3nve5NiLOTWS8Qfb+4jyYnSbeun5iur3JJulU2fbB4A/QfG5w3ctsRotRPNe7OVkWo6vKM+UbDxwXM+NWYogyqI4w4YajgvJSFIbI1avqA2xgSMZ02jvk3B5rXPvu4jsMdTrOS+9JrYRRU4sVHHllJKXO8usd8QFqZzFg05qMjvluYn6guosgDt7NbmfmT4hs6Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB2995.namprd11.prod.outlook.com (2603:10b6:208:7a::28)
 by CH3PR11MB8139.namprd11.prod.outlook.com (2603:10b6:610:157::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Thu, 2 Nov
 2023 16:19:49 +0000
Received: from BL0PR11MB2995.namprd11.prod.outlook.com
 ([fe80::2f1a:e62e:9fff:ae67]) by BL0PR11MB2995.namprd11.prod.outlook.com
 ([fe80::2f1a:e62e:9fff:ae67%4]) with mapi id 15.20.6954.019; Thu, 2 Nov 2023
 16:19:49 +0000
Date:   Fri, 3 Nov 2023 00:19:40 +0800
From:   Philip Li <philip.li@intel.com>
To:     Yonghong Song <yonghong.song@linux.dev>
CC:     kernel test robot <lkp@intel.com>, <oe-kbuild-all@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>
Subject: Re: kernel/bpf/helpers.c:1905:19: warning: no previous declaration
 for 'bpf_percpu_obj_new_impl'
Message-ID: <ZUPMHE482aEfpUvZ@rli9-mobl>
References: <202311021613.I5dZri9c-lkp@intel.com>
 <ZUNmpE2OTpuKcxjW@rli9-mobl>
 <4eb1d4cd-c327-4514-b709-b98dc9e6af3b@linux.dev>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <4eb1d4cd-c327-4514-b709-b98dc9e6af3b@linux.dev>
X-ClientProxiedBy: SG2PR04CA0159.apcprd04.prod.outlook.com (2603:1096:4::21)
 To BL0PR11MB2995.namprd11.prod.outlook.com (2603:10b6:208:7a::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB2995:EE_|CH3PR11MB8139:EE_
X-MS-Office365-Filtering-Correlation-Id: b71c47b8-3ef4-43d2-9493-08dbdbbf8938
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UFeA0jzxbDsVsQvh0aMk3cs71pgKBy6PAzSjL8Xqu3FkwEMYUsFYAtYT+vGaSWE1V9mW8UtOJNdRBRwvp9G51daPCGzttlt18oMejwF91qdzowMyIYoE2bw3qGRvqNulUgDYshHMvMQPLerIicxaFZvmrl9PtYuxuqftLpoe8M9Xw7qLTFdTao5npeQuLjaF5JZOPe72QRRIvwLLfheNs4W7iALSy2bVVlrJjHYNcA8LPGOiJLV7jddDO+5wYFGOy5W4aRE/DluA85wmeX6yBGm4Y7lD2QrA7kIWJI7cCNrQ7/mvtSzzfTjTEZ+N7Dg1479KorQ0luSx3oJ9WItJuC2pbR4jsKxWE9zLScWg7zp37vy5WMck8MaycEWggXJKNbYoewhdJG7Ji3ietCzo0vwwPt3wJ0uQt5UuHTvQ5ehAT9aNXpveLPNqwjA8AHXek46h+pRCPACBaAJm5D0mkxNmcKWCWZ7mAphfuYFt3xfFcnniXFuNBygViKIhu9ixtUz+lvZ9tcSCuc8y/6CdP/N6FKWaaaG0wKdnomVHPQwdYt02D1wniiKZAEaonrPmhdYK5keQx7w8O4wA4xOhdFydCLiK9a6gwRfqttkOthc+4kqPX7Tjhg2oxkNEIcBnEjPYHRfyy0KyUTskK8m5yQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB2995.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(396003)(376002)(136003)(39860400002)(346002)(230922051799003)(230273577357003)(230173577357003)(64100799003)(1800799009)(186009)(451199024)(2906002)(6512007)(26005)(9686003)(478600001)(66556008)(6506007)(6666004)(5660300002)(66946007)(8676002)(83380400001)(4326008)(41300700001)(33716001)(316002)(6486002)(966005)(66476007)(54906003)(8936002)(6916009)(44832011)(53546011)(82960400001)(38100700002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gBdm0UdAHdzLOByeFNfwvX5IgmOuVIbX3ZEZ+hWufttPqMts+p1AQ5HNQVY4?=
 =?us-ascii?Q?RCbxT699n14Z5xn+zUQoxNw4UgaL7pyl/czwSkbnQ2YhS9GKyvA2XRbY9TXg?=
 =?us-ascii?Q?yptrSihN61qDlhxWwaHJ7wxroqULWjeAzhihTSgDEVsF2MAKEAPYwqw0yjSz?=
 =?us-ascii?Q?6t8Z+iRadpYdgy0avQpggRo6ZwXDV4CgJlsaL8IE/sZ4N6SZ8JZVwJ4mXlMM?=
 =?us-ascii?Q?dX5MWLCOcBzD2hHy4q7PkczdSRUQoM1inE1C2rAabBE63Q6LBnFTV3eCOpO1?=
 =?us-ascii?Q?AUPlKUgo9CTetxLxGZ0Q/XTJTDzTuBY9Ug/WKXmfBr76wHZC/3F1lWrRE/bM?=
 =?us-ascii?Q?QJdfM2Ty46gniLwwZLOCF0bo0GJRwn3MEhU3CNo6KjjvKQBDIYWtcnN1p8Kg?=
 =?us-ascii?Q?4jgThMjs4fHhf7OaeL+3fB6IwlyZo5fgw2zo6pYCZuN9tmWPebVGz2nvb50Q?=
 =?us-ascii?Q?bnh8FoH+i7Bc43tO85GZxo1QP9hE8t3rvOT6a8CT0muV4Z3pAFtLbgjwl0Qd?=
 =?us-ascii?Q?MpON7iPRFIWKFeNV+UkZbaO4ke76T3YCSB9Dk/x3DJfFi86mJZ5tjTk39uSA?=
 =?us-ascii?Q?hqmycNMBtobv03pryrQ+XHQ71DELkhQMtKB5d3929fyEBU0nIj5Azp2tG6fq?=
 =?us-ascii?Q?Nei7d1Sc2LE5RfQAdhNfgOxQr6f1078pqAaicYYJNTo2vfX4Qnu02yRYE6fb?=
 =?us-ascii?Q?270eSqk/ccq71aDnprjH3xjV6Uu90As1flb0AS44V4eESOaZHgbSbEM13LaZ?=
 =?us-ascii?Q?ZBHIY8eHBbLsZxvAdk+zfKpUGlxyk1SPvkc9gBQcQ+ljOQh8IDpKDfYHmZEH?=
 =?us-ascii?Q?DoCjprf3lsik/vE4Wg5fHGY7imoyxXonsBwqwwsvXQRxzcQt2zhGIT954DAI?=
 =?us-ascii?Q?3OKToKKNLBaUygR5qf0xwxsxO27qkd+66YvoFxp4jmhdFl1V4YHTEI4eI9YQ?=
 =?us-ascii?Q?NQ0QmF5x4Hittk+u9u1HuXBiDHywdsV/zRgMwx9TYaWLVmQC4xDfYbP/cGTb?=
 =?us-ascii?Q?fHugndcntBzMgrJhuoe5/rbjgKDiqLsJsdevupJ/x7yMni5oCq8U1PvpHATk?=
 =?us-ascii?Q?8wUV643jHx9ZJ/ZkhPe4amMoi+3j+9YYQgMC45kWs0EtuwB4OHN7gON/GwhP?=
 =?us-ascii?Q?A6qgxv8bcib1TvBQxh+xoxhRY7BEUg+GCbRVraBitnxZW7VVRfyrdZadax7p?=
 =?us-ascii?Q?4C20ey5qXs41JCuKtx8UyFinsfmtDUyibEDI8uF+0c4T/RJt6Y5GyEA9HSKG?=
 =?us-ascii?Q?PZC+ch27ZOT+KCXQdIMj0R0y6Je9o/MIJadn8akSofVrKoOu3lEQ5z9pW+rV?=
 =?us-ascii?Q?nUQ/Il2LuC373iim48fXYGuYX0LihYlnJiTgrpdzGi+hFm/lOEj9HZgn9pWR?=
 =?us-ascii?Q?nMNkR48EDYFVyP/0ek0aujCX8MP9pxcCvBF/fnHjkcU3Y5Rdz2yLXYg9I4Ff?=
 =?us-ascii?Q?4HiVZt3x7PieOUu55HpYb1Dbv6UXE9suSKYw/al5MT93vvqMWi+zKJ9QxhDN?=
 =?us-ascii?Q?/65fXIHkoY2oRtoNnFoi8sL4DgI7PsWM3LvhzNLrJ7/U2z+k0LrYaIyMee5Q?=
 =?us-ascii?Q?CkENx7PPGwgGCf5qrH1XbXxC0hG2nle9UKaoEPbC?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b71c47b8-3ef4-43d2-9493-08dbdbbf8938
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2995.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 16:19:49.2387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u2pzGTHLb9Qp4JiimtXbtSVWj71zsCe6pxVUU9i70OSfM7OSyi5qJTVeC5oEcbxZcNnVJhHk+cg1QoEE8NQjhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8139
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 02, 2023 at 08:36:16AM -0700, Yonghong Song wrote:
> 
> On 11/2/23 2:06 AM, Philip Li wrote:
> > On Thu, Nov 02, 2023 at 04:42:39PM +0800, kernel test robot wrote:
> > > Hi Yonghong,
> > Sorry, kindly ignore this report, it is similar one as https://lore.kernel.org/oe-kbuild-all/202309241550.JnHcYTZh-lkp@intel.com/,
> > and we haven't fixed the bot side yet.
> 
> The fix is just pushed to the bpf tree.
> 
> https://lore.kernel.org/all/20231031215625.2343848-1-davemarchevsky@fb.com/

Got it, thanks for the info.

BTW: I found a few places in kernel only handle -Wmissing-prototypes but not
-Wmissing-declarations when using __diag_ignore_all. Initially the bot only
run with -Wno-missing-prototypes for old compiler, which leads to -Wmissing-declarations
warnings still being reported.

What the bot does now is run with both -Wno-missing-prototypes and -Wno-missing-declarations
now for gcc older than gcc-8.

> 
> 
> > 
> > > FYI, the error/warning still remains.
> > > 
> > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > > head:   21e80f3841c01aeaf32d7aee7bbc87b3db1aa0c6
> > > commit: 36d8bdf75a93190e5669b9d1d95994e13e15ba1d bpf: Add alloc/xchg/direct_access support for local percpu kptr
> > > date:   8 weeks ago
> > > config: x86_64-buildonly-randconfig-006-20231102 (https://download.01.org/0day-ci/archive/20231102/202311021613.I5dZri9c-lkp@intel.com/config)
> > > compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
> > > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231102/202311021613.I5dZri9c-lkp@intel.com/reproduce)
> > > 
> > > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > > the same patch/commit), kindly add following tags
> > > | Reported-by: kernel test robot <lkp@intel.com>
> > > | Closes: https://lore.kernel.org/oe-kbuild-all/202311021613.I5dZri9c-lkp@intel.com/
> > > 
> > > All warnings (new ones prefixed by >>):
> > > 
> > >     kernel/bpf/helpers.c:1891:19: warning: no previous declaration for 'bpf_obj_new_impl' [-Wmissing-declarations]
> > >      __bpf_kfunc void *bpf_obj_new_impl(u64 local_type_id__k, void *meta__ign)
> > >                        ^~~~~~~~~~~~~~~~
> > > > > kernel/bpf/helpers.c:1905:19: warning: no previous declaration for 'bpf_percpu_obj_new_impl' [-Wmissing-declarations]
> > >      __bpf_kfunc void *bpf_percpu_obj_new_impl(u64 local_type_id__k, void *meta__ign)
> > >                        ^~~~~~~~~~~~~~~~~~~~~~~
> > >     kernel/bpf/helpers.c:1933:18: warning: no previous declaration for 'bpf_obj_drop_impl' [-Wmissing-declarations]
> > >      __bpf_kfunc void bpf_obj_drop_impl(void *p__alloc, void *meta__ign)
> > >                       ^~~~~~~~~~~~~~~~~
> > > > > kernel/bpf/helpers.c:1941:18: warning: no previous declaration for 'bpf_percpu_obj_drop_impl' [-Wmissing-declarations]
> > >      __bpf_kfunc void bpf_percpu_obj_drop_impl(void *p__alloc, void *meta__ign)
> > >                       ^~~~~~~~~~~~~~~~~~~~~~~~
> > >     kernel/bpf/helpers.c:1947:19: warning: no previous declaration for 'bpf_refcount_acquire_impl' [-Wmissing-declarations]
> > >      __bpf_kfunc void *bpf_refcount_acquire_impl(void *p__refcounted_kptr, void *meta__ign)
> > >                        ^~~~~~~~~~~~~~~~~~~~~~~~~
> > >     kernel/bpf/helpers.c:1992:17: warning: no previous declaration for 'bpf_list_push_front_impl' [-Wmissing-declarations]
> > >      __bpf_kfunc int bpf_list_push_front_impl(struct bpf_list_head *head,
> > >                      ^~~~~~~~~~~~~~~~~~~~~~~~
> > >     kernel/bpf/helpers.c:2002:17: warning: no previous declaration for 'bpf_list_push_back_impl' [-Wmissing-declarations]
> > >      __bpf_kfunc int bpf_list_push_back_impl(struct bpf_list_head *head,
> > >                      ^~~~~~~~~~~~~~~~~~~~~~~
> > >     kernel/bpf/helpers.c:2035:35: warning: no previous declaration for 'bpf_list_pop_front' [-Wmissing-declarations]
> > >      __bpf_kfunc struct bpf_list_node *bpf_list_pop_front(struct bpf_list_head *head)
> > >                                        ^~~~~~~~~~~~~~~~~~
> > >     kernel/bpf/helpers.c:2040:35: warning: no previous declaration for 'bpf_list_pop_back' [-Wmissing-declarations]
> > >      __bpf_kfunc struct bpf_list_node *bpf_list_pop_back(struct bpf_list_head *head)
> > >                                        ^~~~~~~~~~~~~~~~~
> > >     kernel/bpf/helpers.c:2045:33: warning: no previous declaration for 'bpf_rbtree_remove' [-Wmissing-declarations]
> > >      __bpf_kfunc struct bpf_rb_node *bpf_rbtree_remove(struct bpf_rb_root *root,
> > >                                      ^~~~~~~~~~~~~~~~~
> > >     kernel/bpf/helpers.c:2101:17: warning: no previous declaration for 'bpf_rbtree_add_impl' [-Wmissing-declarations]
> > >      __bpf_kfunc int bpf_rbtree_add_impl(struct bpf_rb_root *root, struct bpf_rb_node *node,
> > >                      ^~~~~~~~~~~~~~~~~~~
> > >     kernel/bpf/helpers.c:2111:33: warning: no previous declaration for 'bpf_rbtree_first' [-Wmissing-declarations]
> > >      __bpf_kfunc struct bpf_rb_node *bpf_rbtree_first(struct bpf_rb_root *root)
> > >                                      ^~~~~~~~~~~~~~~~
> > >     kernel/bpf/helpers.c:2124:33: warning: no previous declaration for 'bpf_task_acquire' [-Wmissing-declarations]
> > >      __bpf_kfunc struct task_struct *bpf_task_acquire(struct task_struct *p)
> > >                                      ^~~~~~~~~~~~~~~~
> > >     kernel/bpf/helpers.c:2135:18: warning: no previous declaration for 'bpf_task_release' [-Wmissing-declarations]
> > >      __bpf_kfunc void bpf_task_release(struct task_struct *p)
> > >                       ^~~~~~~~~~~~~~~~
> > >     kernel/bpf/helpers.c:2224:33: warning: no previous declaration for 'bpf_task_from_pid' [-Wmissing-declarations]
> > >      __bpf_kfunc struct task_struct *bpf_task_from_pid(s32 pid)
> > >                                      ^~~~~~~~~~~~~~~~~
> > >     kernel/bpf/helpers.c:2265:19: warning: no previous declaration for 'bpf_dynptr_slice' [-Wmissing-declarations]
> > >      __bpf_kfunc void *bpf_dynptr_slice(const struct bpf_dynptr_kern *ptr, u32 offset,
> > >                        ^~~~~~~~~~~~~~~~
> > >     kernel/bpf/helpers.c:2349:19: warning: no previous declaration for 'bpf_dynptr_slice_rdwr' [-Wmissing-declarations]
> > >      __bpf_kfunc void *bpf_dynptr_slice_rdwr(const struct bpf_dynptr_kern *ptr, u32 offset,
> > >                        ^~~~~~~~~~~~~~~~~~~~~
> > >     kernel/bpf/helpers.c:2380:17: warning: no previous declaration for 'bpf_dynptr_adjust' [-Wmissing-declarations]
> > >      __bpf_kfunc int bpf_dynptr_adjust(struct bpf_dynptr_kern *ptr, u32 start, u32 end)
> > >                      ^~~~~~~~~~~~~~~~~
> > >     kernel/bpf/helpers.c:2398:18: warning: no previous declaration for 'bpf_dynptr_is_null' [-Wmissing-declarations]
> > >      __bpf_kfunc bool bpf_dynptr_is_null(struct bpf_dynptr_kern *ptr)
> > >                       ^~~~~~~~~~~~~~~~~~
> > >     kernel/bpf/helpers.c:2403:18: warning: no previous declaration for 'bpf_dynptr_is_rdonly' [-Wmissing-declarations]
> > >      __bpf_kfunc bool bpf_dynptr_is_rdonly(struct bpf_dynptr_kern *ptr)
> > >                       ^~~~~~~~~~~~~~~~~~~~
> > >     kernel/bpf/helpers.c:2411:19: warning: no previous declaration for 'bpf_dynptr_size' [-Wmissing-declarations]
> > >      __bpf_kfunc __u32 bpf_dynptr_size(const struct bpf_dynptr_kern *ptr)
> > >                        ^~~~~~~~~~~~~~~
> > >     kernel/bpf/helpers.c:2419:17: warning: no previous declaration for 'bpf_dynptr_clone' [-Wmissing-declarations]
> > >      __bpf_kfunc int bpf_dynptr_clone(struct bpf_dynptr_kern *ptr,
> > >                      ^~~~~~~~~~~~~~~~
> > >     kernel/bpf/helpers.c:2432:19: warning: no previous declaration for 'bpf_cast_to_kern_ctx' [-Wmissing-declarations]
> > >      __bpf_kfunc void *bpf_cast_to_kern_ctx(void *obj)
> > >                        ^~~~~~~~~~~~~~~~~~~~
> > >     kernel/bpf/helpers.c:2437:19: warning: no previous declaration for 'bpf_rdonly_cast' [-Wmissing-declarations]
> > >      __bpf_kfunc void *bpf_rdonly_cast(void *obj__ign, u32 btf_id__k)
> > >                        ^~~~~~~~~~~~~~~
> > >     kernel/bpf/helpers.c:2442:18: warning: no previous declaration for 'bpf_rcu_read_lock' [-Wmissing-declarations]
> > >      __bpf_kfunc void bpf_rcu_read_lock(void)
> > >                       ^~~~~~~~~~~~~~~~~
> > >     kernel/bpf/helpers.c:2447:18: warning: no previous declaration for 'bpf_rcu_read_unlock' [-Wmissing-declarations]
> > >      __bpf_kfunc void bpf_rcu_read_unlock(void)
> > >                       ^~~~~~~~~~~~~~~~~~~
> > > 
> > > 
> > > vim +/bpf_percpu_obj_new_impl +1905 kernel/bpf/helpers.c
> > > 
> > >    1904	
> > > > 1905	__bpf_kfunc void *bpf_percpu_obj_new_impl(u64 local_type_id__k, void *meta__ign)
> > >    1906	{
> > >    1907		u64 size = local_type_id__k;
> > >    1908	
> > >    1909		/* The verifier has ensured that meta__ign must be NULL */
> > >    1910		return bpf_mem_alloc(&bpf_global_percpu_ma, size);
> > >    1911	}
> > >    1912	
> > >    1913	/* Must be called under migrate_disable(), as required by bpf_mem_free */
> > >    1914	void __bpf_obj_drop_impl(void *p, const struct btf_record *rec)
> > >    1915	{
> > >    1916		if (rec && rec->refcount_off >= 0 &&
> > >    1917		    !refcount_dec_and_test((refcount_t *)(p + rec->refcount_off))) {
> > >    1918			/* Object is refcounted and refcount_dec didn't result in 0
> > >    1919			 * refcount. Return without freeing the object
> > >    1920			 */
> > >    1921			return;
> > >    1922		}
> > >    1923	
> > >    1924		if (rec)
> > >    1925			bpf_obj_free_fields(rec, p);
> > >    1926	
> > >    1927		if (rec && rec->refcount_off >= 0)
> > >    1928			bpf_mem_free_rcu(&bpf_global_ma, p);
> > >    1929		else
> > >    1930			bpf_mem_free(&bpf_global_ma, p);
> > >    1931	}
> > >    1932	
> > >    1933	__bpf_kfunc void bpf_obj_drop_impl(void *p__alloc, void *meta__ign)
> > >    1934	{
> > >    1935		struct btf_struct_meta *meta = meta__ign;
> > >    1936		void *p = p__alloc;
> > >    1937	
> > >    1938		__bpf_obj_drop_impl(p, meta ? meta->record : NULL);
> > >    1939	}
> > >    1940	
> > > > 1941	__bpf_kfunc void bpf_percpu_obj_drop_impl(void *p__alloc, void *meta__ign)
> > >    1942	{
> > >    1943		/* The verifier has ensured that meta__ign must be NULL */
> > >    1944		bpf_mem_free_rcu(&bpf_global_percpu_ma, p__alloc);
> > >    1945	}
> > >    1946	
> > > 
> > > -- 
> > > 0-DAY CI Kernel Test Service
> > > https://github.com/intel/lkp-tests/wiki
> > > 
> 
