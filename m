Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1E077C3EC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 01:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233477AbjHNXY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 19:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232055AbjHNXYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 19:24:25 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2153ABE
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 16:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692055465; x=1723591465;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=5EHjerqk3EtnhZ4dg5GcfFVR/+xbKNDz/6kpz4m9G7M=;
  b=M1JcSWc6vi4doGFWpIndz7NkG2YTmwh07X7/73V4Q0NAMWbnSLsbdPYM
   40vn+8KsMVXEz8LG23rNABE3LvQfCz6tQ3LFODcx/k48FDUXsCHAU9hn/
   rACEZrtn6EzlPmxK2mhrBfD9OFOW6ydloAHhdTZ/mzwrfWHuaGDt72cAd
   2546hV65jPPKUUYaRrgmkk29BhUDC+e3Azszk6e4LQYLudfd9LXJvuH1n
   9mw7ZKdsGdb5edWdTql6z1MPTpPNb38RfHQ0eI1fmmLnVyBj8+qheXPnP
   YuHozO/KoNjmsycZe9tufba+k9jm1nj1fcfhJ9WhpLKGntvldwvm2RJZc
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="436051936"
X-IronPort-AV: E=Sophos;i="6.01,173,1684825200"; 
   d="scan'208";a="436051936"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2023 16:24:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="803614502"
X-IronPort-AV: E=Sophos;i="6.01,173,1684825200"; 
   d="scan'208";a="803614502"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga004.fm.intel.com with ESMTP; 14 Aug 2023 16:24:24 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 14 Aug 2023 16:24:24 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 14 Aug 2023 16:24:23 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 14 Aug 2023 16:24:23 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.103)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 14 Aug 2023 16:24:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TmBc2zhhoWV66mm+EJwmY/heaTEjKbmmQyEaQLIqOp5OHQanuqbKGnrO8V5ULsQCNyI98NqA0ZE1G1Q9XfQU1+aiM8epJOUvLY/TQVE1laq5VNIvisc0CgyC0H2TNWP7PJ0bfcDDDeWoYt3umZToVgvDpW59GgshD7hr8/RLEQEV2NEej5vTuwuRCIgYSlezq3Ej6gp8gZbL6TjJaTfVj6qNDR5dE+1goeIrXra35jzoV1rGlRxKrX75naoedkGxZMUCJ9eglfkkWGsGgzLNjZuZKMl9QwahoyupTmUwX2qdQ+iv7VyMcEIlDV7ktpQZG5p1Xk0ECH3+0ZpNI8Yl9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CQBT81YkAb4lX7/XnO2lWbcWwpgJbHDZQixvh1Ufbss=;
 b=bVlpG7mHsyWOvVQVKyozzfstwia70Q7fEe3TKMi31C8C7PynvS0MXu2Y98RJEjUOIyaa/T4MfklvWES0u7xoosl7vLk97/tyYgVvSvJWhrKXZKMYoqIPt9rWXyEe0wwbc+7sPUl0E5HRDhLpywi4CsFdtoi/P3fvnDVGZzorlHwzH/QjM3w6rygJg0hTsk2JZ/N2znK4VLZAz4g5ZAIqSYzM2LcTwXbEMUTbU1efLf/onekcEkRTjDVJkccApMtJY/HZb2351Yf3RyBo2mnimgt2z0+1t3gecsUj9IkBsl8xuQvxmw2JtFsdWuw5z0VKbtwITuHaRMvJe03xX5h/NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH0PR11MB7636.namprd11.prod.outlook.com (2603:10b6:510:26f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Mon, 14 Aug
 2023 23:24:22 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::acb0:6bd3:58a:c992]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::acb0:6bd3:58a:c992%5]) with mapi id 15.20.6678.022; Mon, 14 Aug 2023
 23:24:22 +0000
Date:   Mon, 14 Aug 2023 16:24:19 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Dionna Amalie Glaze <dionnaglaze@google.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-coco@lists.linux.dev>, Borislav Petkov <bp@alien8.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>, <peterz@infradead.org>,
        <x86@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/5] virt: sevguest: Prep for kernel internal {get,
 get_ext}_report()
Message-ID: <64dab7a322eef_2138e29421@dwillia2-xfh.jf.intel.com.notmuch>
References: <169199898909.1782217.10899362240465838600.stgit@dwillia2-xfh.jf.intel.com>
 <169199900677.1782217.12516417657696965559.stgit@dwillia2-xfh.jf.intel.com>
 <CAAH4kHbRkFdmdQyPHjOjnnyuYXPLT2GKmQTE8fU9aDFMtri8ew@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAAH4kHbRkFdmdQyPHjOjnnyuYXPLT2GKmQTE8fU9aDFMtri8ew@mail.gmail.com>
X-ClientProxiedBy: MW3PR05CA0012.namprd05.prod.outlook.com
 (2603:10b6:303:2b::17) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH0PR11MB7636:EE_
X-MS-Office365-Filtering-Correlation-Id: 48db97b7-67e6-4e9e-2754-08db9d1d9727
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a6hpCG+yf+8ENKlRnaJq2Uc9LahQ532GFhgty6wDBtwSaD+YHS47gSt08oSaSnJPCTPs/2K84eYt07Tt0VglGiHSOjR/iV+DHQtrGXfmXFGV+TW+nzpBjdP6hmYOOO5jl7enz0SFaNPr3jSwWB8oUvy85qepGtUfqoT2ZwvfcjmYbbxtluseAXCkCVrmvTMppNvnqOXUmQ1zRjVxPDmqHZDQjHpHE9S7b+XEPo9/8wdq1lZoUl3GXS4MlAf4NObMvfS4/En89XHk+44v7N/lMa1ElYbtde/FkYNRNOIE42+CvPEELI3+tkFcVMdoZaN/TyuVqyKtGTBaisR5nEiGMhmLhEZ3ExwWL3AUwHm/3me8bnIA5q5vhd+Jz8Axp1eq9OPi44u34DnB8TKyK09lgaYVEoGRMoW8MiSZvb1lTzpQvcAA6SsgfWi6IMcj8sQtPhUyoFQOsZ/IYwJ+sLT9r/ZPn79m1PL0/CFhUrrENoek9TBGeQyqX3MM3rCyAlEi9adq3C/sw3zLmL6LH2CATizeS1/YMrp9esxDeNuIetjGk2ZHPeqMFYSMGtQB6ty2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(346002)(376002)(366004)(39860400002)(1800799006)(186006)(451199021)(6506007)(26005)(8936002)(41300700001)(8676002)(66476007)(66556008)(66946007)(316002)(9686003)(6512007)(83380400001)(6486002)(478600001)(38100700002)(110136005)(54906003)(6666004)(86362001)(4326008)(82960400001)(5660300002)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hiG26eyBFe/b0JnSKPCKeIP5A/GSUVlAlfSMdWc4bIGm/ieMUqUNM/hR26Kt?=
 =?us-ascii?Q?qr084+YNczkJKcM9G1icsjUmV9cBjT/60VuttK+PRR8ijqWRO0eIDMzerdSZ?=
 =?us-ascii?Q?Cu2uvPuEpQ14ryl/1vcURB9TxnEI+bYF0ry7PB1IG6S03eLdzG+iaWKHqt4C?=
 =?us-ascii?Q?aYc5G6zH6zxjszDaJ13acylUL/V30KdYnfHWX4cqrPhaNqa0FRUxlPdUYQCY?=
 =?us-ascii?Q?1k4CgCo9URUsrA52/iHVrduEUYyV/inr7WCQTMRCJyDFqIgnXOAvjx+gfMYe?=
 =?us-ascii?Q?gLyBSmleKnq3qJ6v4EVtiSVnWAnxrvp9ucmbhyByz3v5aObJa5gsrv/VgRW0?=
 =?us-ascii?Q?W/GMit57N92s6rRxvGtPk7//V4En99GTaP880M6vbVf0ubijoBFM9cSkLwBK?=
 =?us-ascii?Q?y2Og+Xuiu9sxVtHVgr62n11Bzw20GPOLIpSX41PZufqOvAiFk5A7e9Z4UGz4?=
 =?us-ascii?Q?5bLi77EW2JJjSA/wkBhR3N5+5IGUvMjgttLAPG/GgfyiFKgmOd687h65cGHb?=
 =?us-ascii?Q?PJtBl4iFaPD4XX9gHvXc+uRB/2Dq+mnTsZF8OfxouNsUJ6lc37gFozSOy2jM?=
 =?us-ascii?Q?xiO6PE12M6iIeUm/8Yl13dPiG+BHPUFxtiuOsArK5/QVWMAq0lWYTz2MJZME?=
 =?us-ascii?Q?v83PVF47BqMdds9nuwNzONKWJvod1yXMHnOGB8ZUv6ckDk5PJ0CJN2bj53Nw?=
 =?us-ascii?Q?eIJia1VkgnVGBfTgghESktJBMsIrcVXBZ99yP0SKTWrvFlAVG1yA7deEMbtn?=
 =?us-ascii?Q?vwcEGBAqXdYEVC0dWdUyyCqedasMPJneb7IZKoTXqcS3FANRnRa22WTpgOWH?=
 =?us-ascii?Q?vaqN2UlSaAin16Bd67UmNeVKVGcXjwfHK5v7x/SknC1288N3jGN0L7JkRWWo?=
 =?us-ascii?Q?3mfZSu8hMOSuXHtUdFpI6QB7wnAMX6Z24zst4cjdct8dTMR2I+gZq8PsjVA4?=
 =?us-ascii?Q?27vMgwH0mUEZBBzX/2RnrnqAsb1TY8OfD1xov/4wZ/DOtZsxgetaNsVk0OVJ?=
 =?us-ascii?Q?EOmwEmA1ftt3XNYvGuiLnCGLV4KZKAdC3iJ+Jxif9WmmZkI4opm/TOnY8hbN?=
 =?us-ascii?Q?m7Et0I4/Kqa5Ej3dlynREhxJuHyvE/Spw5oGuy1FNGoUr/dgNfLvUZCqPYM7?=
 =?us-ascii?Q?EBHokGS33Y4AcVtplJqR/x/X1WU6+wSRGfELoyeHVTE8cSkdJQazuMWbvOiy?=
 =?us-ascii?Q?KU46YMBNZLsq09cR4H+jKLOlAnvOX+L424xTAoEF0/hckqQNhaE9GiKFrid1?=
 =?us-ascii?Q?dSqOirSzD2ZsbpYgytwNkINOKk95vZHPqi1QqVcN33hfUewisPDFZb0J9nb8?=
 =?us-ascii?Q?0XJF+AD5xT7fiFHMwiJRKOWEw68EyDfq5DDg3xr7cvvKtpRtJy5jTJfuEfHi?=
 =?us-ascii?Q?2yWWEEpF1mC88aq4K/BWBd+geahZobTbcZXQwfM/m94CjVH7jd+9ETMk1JVA?=
 =?us-ascii?Q?RU0MVF5Y0DfhYttVulzA8xPCOGWaLioZs/dmE58Of43Zt2mIoegsj7f+rSlu?=
 =?us-ascii?Q?x1378N5//mczRwOK2eYKU5s6JIctJ8zobOMC7b4jDhk3wV0gfQ9zj+7icrO6?=
 =?us-ascii?Q?UuYwfnTITaphD2gckgNig8qBiVzNOdYrVJyJiX6S+38+SfpeEOPO5LO5unNu?=
 =?us-ascii?Q?Mg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 48db97b7-67e6-4e9e-2754-08db9d1d9727
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 23:24:21.9881
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P/gfDXkR4oRzy6I30Zc3gkUJg6tPA8XqsSOywll8MKnwxV3KITr/o/ZN7v/4cpNaE8JrZwc15jXIVl7AzRwVdbVOoBC+iwk5tlhKc5zT4ZU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7636
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dionna Amalie Glaze wrote:
> >
> >         switch (ioctl) {
> >         case SNP_GET_REPORT:
> > -               ret = get_report(snp_dev, &input);
> > +               ret = get_report(snp_dev, &input, SNP_UARG);
> >                 break;
> >         case SNP_GET_DERIVED_KEY:
> >                 ret = get_derived_key(snp_dev, &input);
> >                 break;
> 
> Do we have an agreement around the continued existence of sev-guest
> for supporting derived keys, is that similarly slated for the chopping
> block, or is it left undecided?
> It appears your choice to not include the uarg/karg extension here is
> deliberate.

I do want to understand the argument from James a bit more, but the
exlcusion here was simply because there is currently no support for this
concept from other vendors.

That said, if it remains a vendor unique concept and continues getting
suspicious looks from folks like James, it may indeed be something the
kernel wants to jettison.

> >         case SNP_GET_EXT_REPORT:
> > -               ret = get_ext_report(snp_dev, &input);
> > +               ret = get_ext_report(snp_dev, &input, SNP_UARG);
> >                 break;
> >         default:
> >                 break;
> >
> 
> Reviewed-by: Dionna Glaze <dionnaglaze@google.com>

Thanks for all your help on this!
