Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAF397A5107
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 19:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbjIRRcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 13:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjIRRcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 13:32:06 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8169EFD;
        Mon, 18 Sep 2023 10:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695058319; x=1726594319;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=hiFiF9kSZ8hkfKuRpfWGpOoLtIQ//XSpiZpLSb9i/LI=;
  b=FP02b0+XfPbKK2gcXxyu7+f4M+VZQ3qvrtkWUOKX0b0j0jwSQTyMRKCe
   d8chTa9A5DqvsM/Rqhe6h8ACuR8XShf+bp2o+iYnXjU3QVWSCsSGJE2S9
   upj5PUm5rzKPMbBwiwlLlZx/PPrScklVp+KxN9uT5gRLQy7ScxWICEyKn
   2Jb4xF50aDSeW2KXb/VcUxj4prNLViaKCYefJWpFtDF228tCO9871gx4x
   GlS7rRUcQsIFNf5KQPL+i5qvlcbaeXbFzRB5s9Zlhr5/fY1FNi/TLA1V7
   Sl9iIB282sXbpDyS6nPZTh2xbGdUOR33GPy4hM37vXCSbtM5UOGITgMsS
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="443799865"
X-IronPort-AV: E=Sophos;i="6.02,157,1688454000"; 
   d="scan'208";a="443799865"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 10:31:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="745891103"
X-IronPort-AV: E=Sophos;i="6.02,157,1688454000"; 
   d="scan'208";a="745891103"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Sep 2023 10:31:14 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 18 Sep 2023 10:31:13 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 18 Sep 2023 10:31:13 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.105)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 18 Sep 2023 10:31:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hSKX4fkhjYCMeYMrcawcnFESrik17p30GFEgCaRayugOa1rbirGqGwtpdksby7OG/zh0goPIT/UIkATvN12GBUt2uCDFAaOhhBAue5K6yBmMrLq97yxDuF4ojijvwxiWx59pFQ6OqtIxJ1WzqBRK3BKXrgdMoXxVDItisCdSLqRZ9lOyW+mZe9Nw5WvAW3gl36S/C2UepMjmWzihsJ9Q+HvycTNtv1pPjCp5I/0RPcSC3rtOlJlffrRWGlkf0DAnHtPpOb1MUEtxlAaiaDTUgXJmFeb4odcc+hS83Yhj6XUUzRZg0V3vpcgfHV9HuhTdfXOmElbL950Fi0bx9JY04w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yJ0/FQBKfM+EqKlN1Yf75T19tsdOgrhtE6kUmUH400w=;
 b=XgbPEuGuU1GAn3TGwXIlIni6vhs1HmS8I9JUih6lanXoIOZWsJcE2MJgrlfaQqr5x1gfEfolIrfxkVggOVYYhixknGuKILyciS7+sBunwR3TlE7131qKBTZ9VPHnwe/7plaqpIzPee7rk1MwOKogUS/oZanTixlaqlmZagZeVw9gIioFCQA9cvi/V7QHo9JDMpSIGkrxWgR6djBVJiYG03SxeXi6e8JS5DwuKi4M5nO5D9rQYnrw90GCjfg6r/ymfCrbQXVSFlwFpjO5C00//ftzyZTg049FGExAaqoZckXIjiUXhS3ZkZY44pSEwvVb6C3uJQ2lXAItYIuzPouUuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DM4PR11MB5406.namprd11.prod.outlook.com (2603:10b6:5:395::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Mon, 18 Sep
 2023 17:31:11 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6da5:f747:ba54:6938]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6da5:f747:ba54:6938%6]) with mapi id 15.20.6792.026; Mon, 18 Sep 2023
 17:31:11 +0000
Date:   Mon, 18 Sep 2023 10:31:07 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "sunfishho12@gmail.com" <sunfishho12@gmail.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Ira Weiny <ira.weiny@intel.com>
Subject: RE: [PATCH 3/3] tools/testing/cxl: Document test configurations
Message-ID: <6508895bb6e7d_3921be2943@iweiny-mobl.notmuch>
References: <20230426-cxl-fixes-v1-0-870c4c8b463a@intel.com>
 <20230426-cxl-fixes-v1-3-870c4c8b463a@intel.com>
 <650553545372e_d7cc829461@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <650553545372e_d7cc829461@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: BYAPR11CA0044.namprd11.prod.outlook.com
 (2603:10b6:a03:80::21) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|DM4PR11MB5406:EE_
X-MS-Office365-Filtering-Correlation-Id: ec276137-c982-4678-f94d-08dbb86d0c8f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EuzeScbuHE27cKfvbNyD55I+C0VfrjzLm8veFJdNBQuXD1qsJZayOSgAhh0T0gekGAdeLgpGOU7sGfyn2xT38OEOsiS79naGUhJlTmmxrjieo9ch/8JFsNSdjd1J94ecSKzcSNWJlj5sVm7HcDxMU6CbzabYuZNVUXmyBgPrjibYaTTH5yEUjrx8CJmm+9kFqbuQxKPUudhLMgy1FQ0FozRDIEZVTyzLCARzwDIV39TI1TOf1SrB0P0rhFqYs4Qiio1kxToEac5ZCi/CShncEJE3JM5nGkS34XLMttRbHM68FeB4sLnKMWLNlE+zmXItDHAV6yN/cRxa2crx14sPjoPKDCWS06+b339ieL93WRJsreoWaLIPTOEMkyD4cD9v2B6xUs4OYX84YcNlHm9tupY9qkN8+w/51JMQixbuv2Pi4VcQVp6pc32xb8OCq/5tWxugVm5dFfJ1WrK8mUwdCEz5xpKT/9SW7WLc3Lsv05/idhQUgq8iaLB8/ZUq3fwXOT+kGAzKQBjf6RVh1ifrNRvNwbtNErDv/KqRbQkc35k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(136003)(39860400002)(366004)(451199024)(186009)(1800799009)(6666004)(6486002)(6506007)(478600001)(966005)(26005)(86362001)(2906002)(5660300002)(83380400001)(44832011)(82960400001)(9686003)(110136005)(316002)(66556008)(66476007)(41300700001)(6512007)(8936002)(8676002)(4326008)(38100700002)(66946007)(107886003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZTXNfy5/evSgcjLo4X9sUiKyz0WJ/NFbGzg+DCeVeJfct4bUTfbvxpDSytoA?=
 =?us-ascii?Q?NqoCYE3f7j6gOEr4y9C7WPLB2wbg6YXoNTnYhjWwM68SQ20HaSDdAijE7XcR?=
 =?us-ascii?Q?E99LUSQmYzmN3MIBl9kiKN47VDN4zV26p+Yf5IpKf9CYhEDYvjBoUCLAK+od?=
 =?us-ascii?Q?XxNxm7FmFpBQt3KtWhAnMeUUMAppncW6aeCaNFy5AaiBh++WZAYXjpAFF8Zr?=
 =?us-ascii?Q?OsAr2y2UuMllgknITuR2cXhMso/tZduujRctu7tQ5Kn49ITVQMPnlj2j7lqh?=
 =?us-ascii?Q?8uIupVBzvQV4eS6OCi2J72w+18ELIh2BhOSaXB/FXCtfcxkLKLaRo83zU0hX?=
 =?us-ascii?Q?Q3dYWAGAwSGGP2hDxMTMfcRdeHRMSYHUi2YsVHK94RVOqPTWkVfy7cS3pfUK?=
 =?us-ascii?Q?O6Bm/v2pKsGkHtZJ6onyb4FkrQBfjBjGC1bHFgO8xGjo/Y9npqxnt1B8+N5K?=
 =?us-ascii?Q?pB0zQQg0YCiS9DOGLB5S4FvcNgx3nqMqK8L/Yx8gE62Y78nAmf+yWG2QXHQZ?=
 =?us-ascii?Q?ft3d/aSP80qHzmIG6vT8JjQADdglAKWIFFzLHHziRC6nnMDf1wmAjb3IXw84?=
 =?us-ascii?Q?8V8TJvXf8w1q1E6rBh54xYxRNKvb8hdtMCstXNXqyrKEMY+gT1to54Ih0Eex?=
 =?us-ascii?Q?1cgT1AwF1SLMDNIG4R70BqNW/U+FiosreyzPKz9Y43PqMikQHukjFHWhmDFF?=
 =?us-ascii?Q?SyrbfFkpE+XbbOTmKXDrBo/QqHGfOEB54sHSDy8F0j64ZQpUR0m69laz8+h7?=
 =?us-ascii?Q?jJ5i5c5gkqMnMnLJ+D3MnOe7ugzNP6lDMI1vjIlL/8Th7CEheDqZqW8b4mnZ?=
 =?us-ascii?Q?DKjZVlcjkyteUXprDRTzJXpmPAHoWlXcdY2G6MD+hQB7+R3LpUZ2PCrjxTrK?=
 =?us-ascii?Q?v6FcXGcceQu8Mn/otVppFoFcHDwG2c2XPxJ1yEWPcv8gXOSbEu5bh1SlVblb?=
 =?us-ascii?Q?CvK+WOSquUf4WYdIh7TSbik0krERmlUXfZg0VY4Qlee48nUwqjloPw+h/RJV?=
 =?us-ascii?Q?5/8CMDwVvvkypy5tQUBKEXJiHohGWsgeqLd+fwBzhl7SiTZkQCZca+mCbF5z?=
 =?us-ascii?Q?+zVbuWqTxfCNlBCtJvJVGre0O2Ugdk4SfAKemtecA/LMO+0gY7B0QD8BMeBn?=
 =?us-ascii?Q?vDgqa/qya3hgiNDSVv1lMOEspCmmR2JvCJ/XlPf+b26sEJOPSX1xEhJqyzrt?=
 =?us-ascii?Q?vT5uX20p1WkfJaCseIuUi4D9K396khNVY7aqJrFf2ngmIjrjwWcWVStIViP/?=
 =?us-ascii?Q?oARO44uUW8ygCN/vmFQ6pq2/1Gd7xzqoGqE/buvPIrkzOEzzKbmewYle8Dqj?=
 =?us-ascii?Q?gK20GYvwscMpwHGJbXYovX0/HRQs9LMzF4bqOHRKroIFbgpqDcO8vd0kPIvB?=
 =?us-ascii?Q?9Dh1oOc+GNq3gcQidYz5XlDYJmPaiyLq6+9gU2lzFTkB3Eq8huqfjZF0JkT+?=
 =?us-ascii?Q?uVRMUi7ySGPppvEeBQumfGysTOj9Z9vcfxFPOHP9fsOmcCRILX7Uu3NEdflo?=
 =?us-ascii?Q?cw5Rg/y/hTKRlr8Vvs01XgmneJxTq+3hpZii6twNGIv8PQaqkVWzI0pihcaC?=
 =?us-ascii?Q?BYFOF+QU/MZ0DcP3WFOmCjOoCiU+C50oxYjc9K19?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ec276137-c982-4678-f94d-08dbb86d0c8f
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 17:31:10.7176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QugAd7lETBqUJLTnsUUJW3mI9leSqIo029ai3CM7kh+5JKMnGZKlrCuBCZvAXkpwY+p4Wiv/SI/Fm2BMb49hQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5406
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

+Matthew Ho

Dan Williams wrote:
> Ira Weiny wrote:
> > The devices created, their relationship, and intended testing purpose is
> > not extremely clear, especially for those unfamiliar with cxl-test.
> > 
> > Document the purpose of each hierarchy.  Add ASCII art to show the
> > relationship of devices.  Group the device declarations together based
> > on the hierarchies.
> > 
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > ---
> >  tools/testing/cxl/test/cxl.c | 75 ++++++++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 73 insertions(+), 2 deletions(-)
> > 
> > diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> > index bf00dc52fe96..bd38a5fb60ae 100644
> > --- a/tools/testing/cxl/test/cxl.c
> > +++ b/tools/testing/cxl/test/cxl.c
> > @@ -23,6 +23,31 @@ static int interleave_arithmetic;
> >  #define NR_CXL_PORT_DECODERS 8
> >  #define NR_BRIDGES (NR_CXL_HOST_BRIDGES + NR_CXL_SINGLE_HOST + NR_CXL_RCH)
> >  
> > +/*
> > + * Interleave testing
> > + *
> > + *             +---------------+                            +---------------+
> > + *             | host_bridge[0]|                            | host_bridge[1]|
> > + *             +-/---------\---+                            +--/---------\--+
> > + *             /-           -\                               /-           -\
> > + *           /-               -\                           /-               -\
> > + *   +-------------+         +-------------+       +-------------+      +-------------+
> > + *   |root_port[0] |         |root_port[1] |       |root_port[2] |      |root_port[3] |
> > + *   +------|------+         +------|------+       +------|------+      +------|------+
> > + *          |                       |                     |                    |
> > + *  +-------|-------+       +-------|-------+     +-------|-------+    +-------|-------+
> > + *  |switch_uport[0]|       |switch_uport[1]|     |switch_uport[2]|    |switch_uport[3]|
> > + *  +---|-------|---+       +---/-------|---+     +---/-------|---+    +---|-------\---+
> > + *      |       \              /        \            /        \            /        \
> > + * +----|----++--|------++---------++----|----++---------++----|----++----|----++---------+
> > + * |switch   ||switch   ||switch   ||switch   ||switch   ||switch   ||switch   ||switch   |
> > + * |_dport[0]||_dport[1]||_dport[2]||_dport[3]||_dport[4]||_dport[5]||_dport[6]||_dport[7]|
> > + * +----|----++--|------++----|----++----|----++----|----++----|----++----|----++----|----+
> > + *      |        |            |          |          |          |          |          |
> > + *  +---|--+   +-|----+   +---|--+   +---|--+    +--|---+  +---|--+   +---|--+   +---|--+
> > + *  |mem[0]|   |mem[1]|   |mem[2]|   |mem[3]|    |mem[4]|  |mem[5]|   |mem[6]|   |mem[7]|
> > + *  +------+   +------+   +------+   +------+    +------+  +------+   +------+   +------+
> > + */
> 
> Circling back to merge this I realize that the numbering is off. For
> example a snippet from "cxl list -BPT -b cxl_test"
> 
>     "ports:root3":[
>       {
>         "port":"port5",
>         "host":"cxl_host_bridge.1",
>         "depth":1,
>         "nr_dports":2,
>         "dports":[
>           {
>             "dport":"cxl_root_port.1",
>             "id":1
>           },
>           {
>             "dport":"cxl_root_port.3",
>             "id":3
>           }
>         ],
> 
> This is due to the modulo math at setup time. I only noticed this
> because I wanted a diagram to refer to when doing some recent
> extensions.

:-(  I did not realize this detail.

> 
> I wonder if we could just use "cxl list" to maintain this diagram, or
> maybe circle back and use this to keep an image up to date on a web page
> somewhere:
> 
> https://lore.kernel.org/linux-cxl/cover.1660895649.git.sunfishho12@gmail.com/

I forgot about this and this is a nice idea.  Did that support land?

Ira
