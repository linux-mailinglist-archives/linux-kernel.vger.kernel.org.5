Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB2D67992CB
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 01:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345210AbjIHXWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 19:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345202AbjIHXWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 19:22:40 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 522CDE45;
        Fri,  8 Sep 2023 16:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694215356; x=1725751356;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=0dgsXEABt2DuxlQF74U1aIU3r9/EwMjOUBwbuTrH6jQ=;
  b=g9pSQk57xuk9d+Nd0T5lRxokLXKoDjJaf4IuFQdPSz6vxyi2TkaYVbW/
   ejOMXKi6KM23Y6IPWP0A40NeCC0vluMV5wSiEhl56E2jpa5OUcYD9Sdhu
   02WqXvTEre1h4CZNBsU00j6Rs6rRNC41Zd9i31jo9+o4tjJoE5QXTe1B0
   4logQh2OvBgwX+RuB2Y0NYNr/x6p3kQfokj8Py7VIYMXLnEmmEo4MURu6
   0yDGdv4WZPdm/4uvXv5qSZy7SeLmR5jh/ZYhTgX/o+sMiA0fgDA6Vfl4r
   Ke1fiLbWskutx726iU1y3dJMKS/asK9zB4Q9VSevO8Tea36rpgNKzuTCo
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10827"; a="441780007"
X-IronPort-AV: E=Sophos;i="6.02,238,1688454000"; 
   d="scan'208";a="441780007"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2023 16:22:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10827"; a="692425180"
X-IronPort-AV: E=Sophos;i="6.02,238,1688454000"; 
   d="scan'208";a="692425180"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Sep 2023 16:22:35 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 8 Sep 2023 16:22:35 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 8 Sep 2023 16:22:35 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 8 Sep 2023 16:22:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PoGhbzEfRUzzBvzMqCes+4lTGgHXY5olKLQD/gXhGaVZ5yxh/OB9Qo197cH9L8KTK6z0lVo9dsD/+Z4F7B34JWvQkue4puwjoabMVczfv5GpqeI/dfxywy/qghVHOtRsvck7Xh3AxpH7Zq0xx2ESYJTckAUyf0lmy5dyiKViSOcn45S7sWYhWkUY9WnuSbhNeCiUM9YukCsVNGZIHxGcD7CD86vPjUJS7oCmp86yXjR0THhMCZ7i+3adGDknGLyi4Zs5gGiMYTnwsnUz/5gL/r1O69nX4wL+Oro4tBZItWDnOM+Y7k/utYm2gHgFXoAr+HZG6AVQ8FjDBAPWOfE1TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uhMSAU46tzBRP4Aop7TFZaZF8peeZ9t9ujEsvzsduas=;
 b=H1Md6swjHi2KF3DXyxijlZtCu3sHbUj/0e4noF+GvLq8CnoXo14mYOpSzS12ECmUlBJrk+LVXSxJ2DpB2gLexrBXRgKuLrClzZcJeoVmXrWynAyxrttZ3A36o13cmegy/GgEg1QK22uVl7GYTXdME4P3/U6fKVy88KPiu1ADTFv+X/Wxj15pUQ57WFp57Wtzc2JHE9o3Wvod2luO8l01DbVh367a1gw4IdRXcvHWMW2UmRkx91P7KOi2bFd3pPgZaxasv/Al/rOnE1Sao+04BB7zLVpsOlqn1V18eNfNJ0fVJZBulgbZPg3ljBUYS7LevEW/1EKLBmv6Dxp2phawKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by IA1PR11MB7293.namprd11.prod.outlook.com (2603:10b6:208:42a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Fri, 8 Sep
 2023 23:22:33 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6da5:f747:ba54:6938]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6da5:f747:ba54:6938%6]) with mapi id 15.20.6745.034; Fri, 8 Sep 2023
 23:22:32 +0000
Date:   Fri, 8 Sep 2023 16:22:28 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dave Jiang <dave.jiang@intel.com>, <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     Navneet Singh <navneet.singh@intel.com>,
        Fan Ni <fan.ni@samsung.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Alison Schofield <alison.schofield@intel.com>,
        "Vishal Verma" <vishal.l.verma@intel.com>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC v2 07/18] cxl/mem: Expose device dynamic capacity
 configuration
Message-ID: <64fbacb4e51d9_1e8e7829497@iweiny-mobl.notmuch>
References: <20230604-dcd-type2-upstream-v2-0-f740c47e7916@intel.com>
 <20230604-dcd-type2-upstream-v2-7-f740c47e7916@intel.com>
 <7e7dfcbd-22a0-c1c3-de1b-7a99edb7f22a@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <7e7dfcbd-22a0-c1c3-de1b-7a99edb7f22a@intel.com>
X-ClientProxiedBy: BY5PR20CA0033.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::46) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|IA1PR11MB7293:EE_
X-MS-Office365-Filtering-Correlation-Id: bcbe2581-df39-457c-8565-08dbb0c27a67
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JMoWQJXh7vQKZaAkDfA1/Q0UGT3zg9xSBcfLRnrtIYDuM422/SeV6g6M3Fx/c7PzktGDS91Lkp1zi/8rDF49VHdc+0XpFwd0Ji72hQ4K+PDwbnUxvXpnsC0zm04Jen2nvvmAp00/GlUokl7x1wEjQ6FtuItx1iuL5sGfjyjFzpI1WA5u+MtA3pfInHUypEAD7q9HsiT5KAnNEf+aCpFJoTkkeSQr4oevD+XyLixrDD7NfTlUZhdaoX/0V4vLNK7mZh32Dg00Mo613ZFk9pe5kOlVcK86e3YIONxtfSM/X6UYqpE1oZAVxNOGtXqbBzEF3Sde1cKNIi8xcIofZWf5UecYXxcZFBYFUseHK2ZzsdeS55GE+A/+6Aua8vPknvxgNXdjQbcwNsIyKWFOwN1xUrpn2+qMXtkmZYkJgQvYU7BXens5WTorN3VWz3E00d7u9AawVypHHfqMwvwEvJxz6rRg0JFyXCPm7FgovKxCGrM66rqkR6ZoqR+6O+XrdApJ6itmfrNPEnSM5ZU//IkE4lPjQOqgFy6FwzCpmK+9GoUQd+2G3ZeeqB46EDl0PWKq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(346002)(376002)(396003)(136003)(1800799009)(451199024)(186009)(6666004)(6512007)(53546011)(6506007)(6486002)(9686003)(41300700001)(478600001)(26005)(4744005)(66946007)(2906002)(44832011)(66476007)(66556008)(54906003)(316002)(6636002)(4326008)(8936002)(5660300002)(110136005)(8676002)(82960400001)(38100700002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9WBNQhCcqiWOtZ5UMCOZos9LBGQeFYarXxzT4+THPIS/J8aniasYc7r2uY/s?=
 =?us-ascii?Q?Z5VEa1cQSg8cIOJdtU0itpUwnS4wdNA0gqgXKeBCPM5lncJgoPyRetT/aRZN?=
 =?us-ascii?Q?iLaPG7OUJzCnpFY8Wx+Q+0SUdXNEiW+V0gL1xKbV7MLdm9jyICfg6AU0NHh9?=
 =?us-ascii?Q?hPUv8yVkG1WTNz4v1nV9kVutwmpv+YE30f0PjlqlOL4O4Ufn9OxseOGHSA6D?=
 =?us-ascii?Q?cKRV9XwSDvRLTt7J7pwtU5vm3dWBpCHyUYeTZW/fIlVUAsJG3vVLD/1Qg9SI?=
 =?us-ascii?Q?l5dnE2K5wst4RsbDeBlRcv8Um6cZ88q0iYfZLYBrHrXHu42P8PIKY6V6/vEG?=
 =?us-ascii?Q?sTk7ZJOtgZLExUJ7VZsX7YEVS8qPGJ9bkcHm/rK8v4FobQ82GohksCtZjBmD?=
 =?us-ascii?Q?T8jGsOW7JriCgNpAKl+dM3bdwGtfcEL/y3ZCYirlGI5EAf1E5d1n6mN+yUxO?=
 =?us-ascii?Q?RcFSz3GYTiDBVpMSqDVDwAEn55SFOdIg++SnjIUimLmO/n3MArPiZPKwyjtx?=
 =?us-ascii?Q?AQdoUMFtgvXLyhLEmHyS+Ry1UJ24QQkR9FvxVkoOBJBwdvM4NwYRQbobLITH?=
 =?us-ascii?Q?frxaCi8tuBaIB5Zlj3z7C/L/SnQC879aY5ZCMpe3YkH7KImUxt/8lGqSFaTf?=
 =?us-ascii?Q?y/QBpHcmjdlSUO/FylVmegdDXp569k7nVQdBuXOw7h/YC7VWewF2z/7Apg0T?=
 =?us-ascii?Q?Fiv4ADbsnJQAJ8dMavexYqJIFFB9qaqiRhRNAwx04V9BDb9Gx5wpi3kEYK++?=
 =?us-ascii?Q?41sKJdu8Jc/gpA5VZh61+Dsg4i2vvPoVy7OHX2TpG7ryucPa8Veum3IA3KAX?=
 =?us-ascii?Q?yJiiH73cmKWCKpwVIImRKEugVD5IPzb9AaFMUClJNu4xhRHlg/V4FUwlZqLI?=
 =?us-ascii?Q?5upn3ja0SC8ckGOsjfyKQ2Ek5vqrBufjTuehKzFCl84gKYXpu2lir8zeXfJa?=
 =?us-ascii?Q?4ukq7u2tdYrjDTt1lJy1CHg+/TEm8GM4VKaOtPfVP/YAupajfvgPsNfFgMfF?=
 =?us-ascii?Q?54NsKnnneB/32PoaxelsMStN7YZMhzbKroKK2YDtmhzLR5T1dxiDkEOuaUsx?=
 =?us-ascii?Q?evucrLaYcoSkYG1qsYAgL/P/nIAA+63XNbxia4fN8ahVPUZUfJJCN683Ly/d?=
 =?us-ascii?Q?CVjhT2CD930Tb1dKfBXB0oXWqrSdt9CVmy0shkKPU4cLlZ2bptcyq0i4a/um?=
 =?us-ascii?Q?AZj36+w6JtLEcQfWGhglkhcCxsrLYe/P6ycOi1uCA52mAIq2N6xPFOl5GP5W?=
 =?us-ascii?Q?KlQ6KObnsB6ZzMBy+IMpd7grLOmSIi5Cv47L4w0Zw/5HYBOmAzzSCSI1f8E+?=
 =?us-ascii?Q?UHN7omZe9vyZaRYlnc00ZFNsJUT8vf150NMItHUEETdyZWJT8ekhWJBCz9w0?=
 =?us-ascii?Q?sggW7ytoGKpo0FIh5MXAy1kEAmQszMDG4Don2a2KKlOMk76cjz6WxdZqLnoF?=
 =?us-ascii?Q?5CiK8ux2jOmw7IfDtW0K+kByAVSqV+kVV0DAb2OSDev+OyDv4I1ZhXaiOlRr?=
 =?us-ascii?Q?8XHBHkMqVQzI3Stluo4369rzUB3UQawUJTb7PbL+YrDSto6SFq5oeKlRwfme?=
 =?us-ascii?Q?dJsIh6qXnjICVGhDVthhDVlRaa9yjhUv2RdyKPfd?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bcbe2581-df39-457c-8565-08dbb0c27a67
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2023 23:22:32.8602
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0QE6eY1Yd9BfSILhBYne8noqdPtYAPxbyRjYr6N9FZjKZzvcGvVCBci2v3GxGQi2jJFlaCW03QS4/wmnB5WGKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7293
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jiang wrote:
> 
> 
> On 8/28/23 22:20, ira.weiny@intel.com wrote:
> > From: Navneet Singh <navneet.singh@intel.com>
> > 

[snip]

> > +
> > +static umode_t cxl_dc_visible(struct kobject *kobj, struct attribute *a, int n)
> > +{
> > +	struct device *dev = kobj_to_dev(kobj);
> > +	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> > +	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
> > +
> > +	/* Not a memory device */
> > +	if (!mds)
> > +		return 0;
> > +
> > +	if (a == &dev_attr_region_count.attr)
> > +		return a->mode;
> > +
> > +	if (n < mds->nr_dc_region)
> > +		return a->mode;
> 
> I would add a comment on who you are checking against nr_dc_region to 
> make it obvious.

Sounds good.

Thanks!
Ira
