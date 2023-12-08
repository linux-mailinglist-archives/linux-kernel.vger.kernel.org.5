Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1E3E80AFEF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 23:52:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234036AbjLHWwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 17:52:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjLHWwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 17:52:06 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 422C5AC;
        Fri,  8 Dec 2023 14:52:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702075933; x=1733611933;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=wxJBoGH9CFPKl0EvmrwyKMNhswe+r2/Y7uw43CtzruU=;
  b=Wi1nxNE/Pg8fmGSFJrdlo6mcTSpo4jrDVusvxMWzq8H57U+K6npcftGs
   RV/Vs4UeqCAfq0cuaQOEY1mZ0PbTa97sqHj7V2fee8yk6IL4QCQOF+geT
   Tr6BOHTqXyKDO85cIYXM4h/sqr/hskINckr3RKeQ+XkB+9lZhSbMDU0Cf
   OAQDY4f7pcLsBXx6vDftPbVqfmQ/BnMyzxEdZZqCE1HccbDApdplsfxRX
   eFmDGBcYsC6MVJWa7wdNGuUXM0kDGg62VCKSJTeQH6cXw7YJVAg9HSqX9
   RZiScSW2k8HV7nAFovDBP94L+yKfKlqCaxSsglM/5QRD77XT07CGTofAk
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10918"; a="1599434"
X-IronPort-AV: E=Sophos;i="6.04,262,1695711600"; 
   d="scan'208";a="1599434"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2023 14:52:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10918"; a="863036214"
X-IronPort-AV: E=Sophos;i="6.04,262,1695711600"; 
   d="scan'208";a="863036214"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Dec 2023 14:52:12 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 8 Dec 2023 14:52:12 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 8 Dec 2023 14:52:11 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 8 Dec 2023 14:52:11 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 8 Dec 2023 14:52:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AbZw8nIsy1dzvcV6mqSONWpmYCsivKlZwp7RYs/pMykPb8xWIgYQVM9R5CWLHKF8G5ttaX649iXKEKm7kILBowVzX2i3eftvUaTwZVDxNdPonQCredB1aWj6cM/PFcMr+HEB+etWThdoJItshielJKfNOpNKWKonfXk+LdKDfCg7nP7ZBRTnaST0c2wbX9Ze0phIoY7TLNQ721jrLkycvdRYIMtYm+LESryZZTRlSnt7FK4/WbmD6B+EFlFdgFYS66xMSPXjh1zlSEVCSgFWwRFKw+RubeQMyVYpak8wE4YmNbkcV41/wscu0ehosXoB/CqUfmjCV5Wbr2yTO115sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cb74ZPvgZ1ysfYyWmNDE4WpcTXIELJpvfVLYVwDsovo=;
 b=ZfBUvWcz5I+X+687W8TKOe9PMr3+1qd9dqT8YpH2DNXDYlW6HIeqpvwAfMc8UcJravc8mvP8Ka8W1PemNuBlIi1D1mTbPlImd1st+bnjPM3Ege+gEzIkxX6IlQnkbqHnTYxBwiy/e723vqGS5SDyt5/pPdL9u0Mk0qNzbAjTqNUcssRf3R5vRB+RBkp0+qy/8i4Nzwt3CRe3NIj9EDqPTwnpIBAhJhsAEofelmyftlCpQhd7oI1sX6Mwbe0eFSjq3yH3f+mmsLFFAkbMxXUqjtchqSNn9Lq8PjmhcC+RH88/kX89pGSWfZy4A4KmwrLxFxC569x4JV6ZvVK4u/TM/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SJ0PR11MB5118.namprd11.prod.outlook.com (2603:10b6:a03:2dd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.28; Fri, 8 Dec
 2023 22:52:09 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::da91:dbe5:857c:fa9c]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::da91:dbe5:857c:fa9c%4]) with mapi id 15.20.7068.028; Fri, 8 Dec 2023
 22:52:09 +0000
Date:   Fri, 8 Dec 2023 14:52:04 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Robert Richter <rrichter@amd.com>
CC:     Ira Weiny <ira.weiny@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Fan Ni <nifan.cxl@gmail.com>, Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH] cxl/pci: Get rid of pointer arithmetic reading CDAT table
Message-ID: <65739e147ba03_1e7d272945d@iweiny-mobl.notmuch>
References: <20231116-fix-cdat-devm-free-v1-1-b148b40707d7@intel.com>
 <ZVfIaNhiSc-yQZo5@rric.localdomain>
 <ZVfJ6Fxidvw_gz7r@rric.localdomain>
 <656648433bd82_888fe294a6@iweiny-mobl.notmuch>
 <6572369ea4080_4568a2945f@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6572369ea4080_4568a2945f@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: BYAPR07CA0027.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::40) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SJ0PR11MB5118:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d34deeb-3f83-4639-99c3-08dbf8404f03
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IJAFdjD/8Zv/NHpVMQHlrDx/SuWe+3wabM4iaqcwHLyWDFborV55Qc0ZA4zsZH3bV5jhI25okmfwyS5ChCWnrIpO7K2ia4kPX7YX4k6VaYccyiwdwUfLtXu22lE26jXaWEq+xYsyda4uiNHLngyaYda36ahsCTLIlIBK7MAZ4r6ZYto8g0SVazac5rS3kog1/gj1CRTYCWIUMX4ffaZJFxXAkV40fLmnZY5UR9qtP3oaD9IowwmJagnBk5UwYIGWNSpZfaoqLDC1dvshXIqdSmUTtBKUlOnpvdUt5EhsnJRzH7otnoduL9kQ4C2jtjQ8agLtCNjHe5cPIs0ZC3ZWmrwTrO+CW/EDvDA4zW7qI23m9EP5nQDna8VGD1yh9e5lttqC90IZlOuXXbP0w/4nM3q+XdL2bKEY0LiMS7vt8ZItGeYuHGtimVdIbixP1mQnycjMs5Yyu4dCmjJV3lO3H7Mf70SXNrSLUNzNuFzSMdl/e71gaqXbewVTQj2nZ4JTOnXm62mJaO7Ol4RGNNHu5KO/nDqT+m7y7hhjj0teqfYIJJ9QnJjNzGVzgyhrtykjfeILW6tZgELU/TpbhfpEpTCh/W0Jpctr1m14P806SZg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(136003)(366004)(346002)(39860400002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(26005)(8936002)(8676002)(4326008)(44832011)(9686003)(38100700002)(6512007)(6506007)(82960400001)(6666004)(6486002)(478600001)(66946007)(66476007)(54906003)(110136005)(316002)(66556008)(4744005)(2906002)(41300700001)(86362001)(5660300002)(26583001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6zS3EQvqI23ONHC5JpuhURf5bJGOzTzRE5+RjP4L97KJFL1/rSZ0YBwaq6xH?=
 =?us-ascii?Q?gFIZZk/DOqsMe0Z+/oHVTKmpmehajrOxclbWCsZr/50C+Wfb6DYHBZV/RDLX?=
 =?us-ascii?Q?ukVonbnjiobEFBNeYi14my/z/48T5LF9kCmFqH8BQyjN0JA1Zu1T9BhDn6Ul?=
 =?us-ascii?Q?3NJPXlRUeMXHP2VEFrg1WB+kKh4Zx+x2vM0pkfg5//HMIkOWKBiaiV0hbGrO?=
 =?us-ascii?Q?Odq5V+M+GeonKzOq8qdkY/jnWi8lZSJdCe2owbCEEu2cf7yM+gY3hThNra8p?=
 =?us-ascii?Q?hjoZ2JnVZMkxaGBhEgprBjY95pEZaSoBOU61WCYbUcNab5CTpQoZsjahY5I0?=
 =?us-ascii?Q?Wi7C6A89VuaFoGlJ6uj3CzvuUl7wQSDIig188V2N94z+5M5a4+yt8FFeEKGi?=
 =?us-ascii?Q?wr7HMkiYGZ+LJGOL0l0aTBDz4mXUUeBN1gqxIHnMntYFORrGxWJTz3o9lGW/?=
 =?us-ascii?Q?i7+U7x/kZkH6XqktfeuQ66+YjPuzo0OdNLNnx000A7Jeq4yXkE1YH5ogWvWf?=
 =?us-ascii?Q?keo/1yZOiXhn+O69JIlPY6wagp8LSpR0JTkGzLWFJhy/efiWdeK2KciXlWjU?=
 =?us-ascii?Q?mwHumbS4+Er1of+nU3BlBdeuPbOJWj9Hn/0cCbuV8kAJ7ZE6rgD6ycMeK+Ba?=
 =?us-ascii?Q?xciryT6ZLntrfESXKxkoO4L4YMJ97CsQYOKMbIoAk0zq8TEF+C+s0DFOzEzH?=
 =?us-ascii?Q?9l45f22U2p4JvliGX6M4cbs/MYeVn3GUiOv6m1H8DXLoxUpsKr66MDlej/4X?=
 =?us-ascii?Q?h7hNg+fSSiBB5lhPSVeNJuJ8zMguv5AFvrBOpJKWSWF2aNjJ5ldHs/vCbWax?=
 =?us-ascii?Q?eUhqOBkhyzbcxaEsN6eRQ/+F/VatuXkvpxUl0EphpXAmZoN0fqptYtdXZRvt?=
 =?us-ascii?Q?GUGY/0KzlFoiyuakb9etj5XWDM2sahFxnjgnAFqGSG5wcP8e7PDyq68mhhwQ?=
 =?us-ascii?Q?GXxifAWZqjlKSLPgzLzFLk2VOWX3eKsYa2vcPucZd5YnY2HOM8H1bPKz/dId?=
 =?us-ascii?Q?r1jgwnHrcTx0LB3Y1RvM+Y5vlztrP7HJqpzOxcX0Dkg0PhhuikidEOX0MBjg?=
 =?us-ascii?Q?ctNRTPYZaVikgiSZp6BCVu6P7Utl5kXRzbeolw04dGB2K1J94UeQTCCZTBxg?=
 =?us-ascii?Q?EHJS92DdFJmHwF/Xx6VoN491mIIwUjvOUvO0wlz6ifpWyfzWu8i5m8hCxmvn?=
 =?us-ascii?Q?bYDG55kM1nu5Df34rw+Z8EVgbc9Bej77puguJ86nbgAC+W9pV3oIsWY4z+xk?=
 =?us-ascii?Q?Z8KtiAFIO2u8sbMG1MLVEn2Ecen1LCk39Xw6EuvRtz5kjnLI9l8J5lrBews1?=
 =?us-ascii?Q?FnujQC0L0gOArw8BQ0bzd8Y5/OUYcuFyJ80QAffGg+HYPa71c8FmZgWzWt0J?=
 =?us-ascii?Q?BUMiH+m8xMZ+H9QQbWcjkEnfCTjaPslSFKMDBzSN66JZI45UTxi/QubcC3kM?=
 =?us-ascii?Q?dF+SgR1nHSONdwAhEi0SIPFSXbMDL9ARGPUEBTUePt9s732Z9+NUbpHj01rl?=
 =?us-ascii?Q?byTYoAzbyrpiptHVh38j70OGAn6AbBnCAb1SKoh47HChSLYQWXx9+qG+9s7E?=
 =?us-ascii?Q?X8Ak9Pf78QMVEZtckG40ZAdOqRmIPdr2+AYEKsFf?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d34deeb-3f83-4639-99c3-08dbf8404f03
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2023 22:52:09.7863
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rBy8yaj0rUXcBir3mX+VXlfoiPoB2yQBY/MGhL6Odyt5iRVSrjuIGkDIe3j7KvbE5uFn4vUbYDIVrmrJxXor2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5118
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Williams wrote:
> Ira Weiny wrote:
> > Robert Richter wrote:
> [..]
> > > -	cdat_table = cdat_buf + sizeof(__le32);
> > > -	if (cdat_checksum(cdat_table, cdat_length))
> > > +	if (cdat_checksum(doe->table, length))
> > >  		goto err;
> > >  
> > > -	port->cdat.table = cdat_table;
> > > -	port->cdat.length = cdat_length;
> > > -	return;
> > > +	port->cdat.table = doe->table;
> > 
> > As an aside: the type of port->cdat may need to change at some point too.
> 
> I did not understand this comment relative to what you expect to see in
> the next posting, but maybe Robert will when he respins this patch.

Robert introduced some new types which better defined what the read algorithm
was doing.  Right now the table is just a void *.  It would be nice to type it
more strongly as it starts to be used in the kernel.

Ira
