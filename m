Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F123C793037
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 22:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243608AbjIEUqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 16:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231834AbjIEUqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 16:46:02 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B09EE45;
        Tue,  5 Sep 2023 13:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693946751; x=1725482751;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=5awU6mhbJaxOmgz/MzcBlM7sQM7YG5Ob1P5noLzYaQg=;
  b=lxO60ngKu6hWsloii9TDpJAjlWh7HV3Sz3Mjj9V+X4/2k3NscqMNhYMe
   7ycGJq7LL6b1DU3EemTmxDFJPGKFz7ko7EjhkfRfZV04rbrVpRmjNNj3e
   4qUJT9VPLQAPBZm8DRF86vGJhbT7lP0blhc02AN3v5mVuKg5SbZFCX8eH
   hJbCJTyeQwSo0brarQhTuJPjEDZexrWsVJHj143ZgMVvrtvdaNPEwOIze
   5DsK0s45St3UVxVcCOyP98nqTp8Uy9e8E++jZTPHIhZwLxA0XL/KFKY/a
   18PG/tzT/3lMhxpMdgreiiM10gA56JMoH8vQOS65XFUd9QCCZzPIrdKmz
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="361928175"
X-IronPort-AV: E=Sophos;i="6.02,230,1688454000"; 
   d="scan'208";a="361928175"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2023 13:45:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="864887332"
X-IronPort-AV: E=Sophos;i="6.02,230,1688454000"; 
   d="scan'208";a="864887332"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Sep 2023 13:45:50 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 5 Sep 2023 13:45:49 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 5 Sep 2023 13:45:49 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 5 Sep 2023 13:45:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T//vjZInvaDaGvdmkwCwywoisYnaEoIRR1EQ3v9ZV3tqvllpG3gVO2SaRn0656pZG8i+DLRIwt9ho1D6UsgeAlCQthAySJZGcKIf2MX/Tf17LA4r3s5sY3mXEoNUdp9uuCDB1Ju53hEYpq3YmEDM1WFmkXtDmd9R8zp4tRao7Qxpm2wWffHdWKSTe3c2n9BdqRxuif90XR3DnCx7GCiwsW9bcQBSep6daUJSxm7laN85gHOv63mf19pzDddo6Ci1WkRR21G0v/STXh3wTYjEZgqXt36d4lsbjVAG5VagqNwfY3WcDW7HPNfw7HMt8zaa4/U1NZca9CmD69aTaYPcEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jCXCosk3R3IDKZT89+9ZZRAK5EPGrOm7K6abuMVaoQI=;
 b=O7MCTjoAyHPqBGwTQBk6TaT3Q+6fw7Pm0a86gep8AQ+mpVc+GPovBTa+lvrAGJwIOwRXVW4pNg8eRFVGp0nJNtvpvgPUzCRCoFy8tnZBhw/nTF1WJMgxSgCXZN+GKji92I/4/yRJ9StNnjB+s03pi0IkqwZeSW0S8ym4FJSFxlrPXBf9dSuB7GFwH6P3JZBjVcpESbjKN2gz8dQX8gVEOiflQPLEZ5Gs6S1H5AGSgScOjC8vCkyE0nsjJ1F8O7ygQ8NYihLWrU7gDifi+Cvg1HESKkYXxhnl2njdqRgrke8VidPd5+aYM1rRv8dLlAd82hlxOe6eJ4QFKZX+k5wm2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by CYXPR11MB8709.namprd11.prod.outlook.com (2603:10b6:930:dd::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Tue, 5 Sep
 2023 20:45:45 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6da5:f747:ba54:6938]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6da5:f747:ba54:6938%6]) with mapi id 15.20.6745.030; Tue, 5 Sep 2023
 20:45:45 +0000
Date:   Tue, 5 Sep 2023 13:45:40 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        <ira.weiny@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Navneet Singh <navneet.singh@intel.com>,
        Fan Ni <fan.ni@samsung.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC v2 07/18] cxl/mem: Expose device dynamic capacity
 configuration
Message-ID: <64f79374c8860_1e8e7829466@iweiny-mobl.notmuch>
References: <20230604-dcd-type2-upstream-v2-0-f740c47e7916@intel.com>
 <20230604-dcd-type2-upstream-v2-7-f740c47e7916@intel.com>
 <20230829161449.00000c7a@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230829161449.00000c7a@Huawei.com>
X-ClientProxiedBy: BY3PR10CA0029.namprd10.prod.outlook.com
 (2603:10b6:a03:255::34) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|CYXPR11MB8709:EE_
X-MS-Office365-Filtering-Correlation-Id: 226e4c90-24d0-4f8e-235d-08dbae5113f0
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XrezJ5Rya80Dj2bL7J8gqWA4DtwQc0gQgIb2/Q5nHdlWH0o4mnILqoL7GmkoFBxnzZ9TzbP4uVjdsb+ia90YYOvGmzIioOKRsr4OJ2LdDN8qzWnZ5Ynx+Nn3fet5fEr95WkKJU1mQija5CI1KavcU8nHE9PCwDdkyqxD3V7A6puJGqZFMWUfPUxJba9N2dBbLnxassslo4SzQ3g/687BU4O/Fn4YnL4Y4wHRi1+QCFYaFbyV2/OJ82mFl1pmdYZxymNmyjujNomd8prwoZm3GZKrg4Uo4fS6L6l2gy+ud6d99/eVda6cz7P0sIM/48u/MNFk1i24nSF5cFa4128HMdKfFji2Gm7ZXxMMCNTb5kQKOEd4Friw5EJjRXQzTmNFcKoiOQesdjCq07RAlp9Ln0hPaEiGreMyIyML3eaeasI4llCozIEBNaYK8NYYSf2ka53oBlOe0sVXg7+mJ0O1TOUFotsZe04NIKkVwaWUk8lePwNW0TeoOBf2SvB5AAqcma65oG5UciYMASvcrNiCc2QLCXiepJ3lzkU3f8/rg2YTRWejsVUfvWDJ1L7X63LI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(396003)(366004)(376002)(136003)(451199024)(186009)(1800799009)(26005)(38100700002)(86362001)(66556008)(66946007)(6486002)(9686003)(6506007)(6512007)(82960400001)(478600001)(6666004)(66476007)(2906002)(4326008)(8676002)(44832011)(8936002)(316002)(41300700001)(54906003)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tW9LJ1iU2yjqkmoZRUc/fN27rkiXsX/DOAhA6I2swKscaDQQT3SvkLxITuSw?=
 =?us-ascii?Q?KvgC6we1VUithutaIes2FBM9zcpsKc5QgWQKDw/2UpJSZUgZc7ZZHrcphish?=
 =?us-ascii?Q?l+o1GysNszCM9bChSJOAJoWILaVC3gmSGlpAHX6WfNhqJ6+zHLR4TFecDctX?=
 =?us-ascii?Q?3DA0dZgqnUYRaR39fC4BEyYR8WNPIfz6GcoUNf8+FbeX+UmS1W8VEK642kE3?=
 =?us-ascii?Q?tIRy139O7p9cbktlsEyZWvvXz041CCybkZ302LFCrqo9F2drMEUznqY8VgyR?=
 =?us-ascii?Q?TeuESbfgJqmqVPaqFxEvwgZW0PX6fUYCypJQ9SlBwfptvmyxaTfQkDqDOF6l?=
 =?us-ascii?Q?SjNi0CcjKeMfh3nFnpgsLp1tw97DmZGIpME/z5J/iSotyo8MiGE/lORGYBxV?=
 =?us-ascii?Q?Csf9fxnroUobr7LqVo5fWEHOGghHwcScjKESyKoQlWin9pv2BQeQrrCkPNKy?=
 =?us-ascii?Q?UQ56aij9faDe8PgnrJThyW+J6hH8KLQQg2fqHHuAAdkXpoAa1+hAYoE0LY/+?=
 =?us-ascii?Q?oy5GkNGFbfiglZWY0MBxpFXyNn4Qiqs6EAadwfOzd2B+c7zkgo55z+C/MLRW?=
 =?us-ascii?Q?CHf+A5ZHqWnCyZ5BBsG0B2VvKcv0yW/GJcVJusYILvd5O67lE0ZMbonVhkHp?=
 =?us-ascii?Q?4WTgBr2jGbymL/9QXJd+QIA15CX4+GWOrOpUDLvUQHUL7aRRD4Q0B3wcr+8W?=
 =?us-ascii?Q?17gDPIBeelZV5XuXAWmB9ixq7wTHC2vERdonKhffKnRCFS0yRQ4rVAgzf8uv?=
 =?us-ascii?Q?sQ530dkhbjibcbTIvkzFXj733E+GS1T474nf+qL/pJds8oB7/4bIFiaDo9HK?=
 =?us-ascii?Q?aIEgrOOyyy0XpF5CsZzpIczkn+RJ27Ih2OCJLN29V/cAA/I5uPvghv9EZ5wI?=
 =?us-ascii?Q?sXnFftHNfDlz27qmn50R+T3eDEECyD1X0Qug3mTTRP/DyohBlolymN+RGwRa?=
 =?us-ascii?Q?CQXRnyvC0DyH3nu9jHa/nKD3ytXth90cbbwgiSU4aj10zQuDsyacSBHUdmOX?=
 =?us-ascii?Q?BdLD1VWLAu51T4+bMY6jbgmmhjxNki1x1t9d9+DVy24HbMSfYL0rgf7NW+Yx?=
 =?us-ascii?Q?/KOXgDO4Bollylt5lMM9zfD66eplvbDJXnglNidwjFCO9xAIrfd79iKPgU/R?=
 =?us-ascii?Q?AYjJykhLImilLQxrdcg6PUaLJn/ZmLKNKkLD+ygpnTUpqGaJkYGqD7EBOUA5?=
 =?us-ascii?Q?jyPw3N6E+TEeBalIc9TwC3L5QzOsVvsc2VIgUD8oGsAgxvp3lnJ2SaN7Jgl4?=
 =?us-ascii?Q?swxPkKKCNy+a5uLe9hKI6/Vs7K5nxBignxVKWHZuQyV2+o3YT6hqPcljLUC7?=
 =?us-ascii?Q?KRmqsDV5075i9Sk3IbJBzjy79pyxoS2YGZvDjDilg3kBKxnPPa+UAFCZQdmH?=
 =?us-ascii?Q?L4c8Rfx6DLG1w4dX14wvA6iBdl3206WKqYyjtJmYMNpHiqggPFqG+7c4+KIK?=
 =?us-ascii?Q?rPMN2/WlAYZOdrAl2ykvvCuRzwiNVO0ib2QBbd7mPXO8LHJna6QBuCLQSaIs?=
 =?us-ascii?Q?/scJSbR9tLSMbVr7eRxksz90kN5BF6RF+AcQdXekZPwMDhtG+HfXYo4rLlxe?=
 =?us-ascii?Q?FjDmg147vSzMgaUiFmbp+KyRWhMGdHuIUz0gYNr7?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 226e4c90-24d0-4f8e-235d-08dbae5113f0
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 20:45:45.5615
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tC4+WEoLo2gpfRyYhPxzNLwXVamt7x7uRp2VcsJ4g7uOAUbzIuoTrKLQbqdEScVkIjR+B86QmxL0RIKuU0ueFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR11MB8709
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

Jonathan Cameron wrote:
> On Mon, 28 Aug 2023 22:20:58 -0700
> ira.weiny@intel.com wrote:
> 
> > From: Navneet Singh <navneet.singh@intel.com>
> > 
> > To properly configure CXL regions on Dynamic Capacity Devices (DCD),
> > user space will need to know the details of the DC Regions available on
> > a device.
> > 
> > Expose driver dynamic capacity configuration through sysfs
> > attributes.
> > 
> > Co-developed-by: Navneet Singh <navneet.singh@intel.com>
> > Signed-off-by: Navneet Singh <navneet.singh@intel.com>
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > 
> One trivial comment inline.  I wondered a bit if it would
> be better to not present dc at all on devices that don't support
> dynamic capacity, but for now there isn't an elegant way to do that
> (some discussions and patches are flying around however so maybe this
>  will be resolved before this series merges giving us that elegant
>  option).

For now I will keep this yes.  But if there is a better way then sure.

> 
> With commented code tidied up
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 

Thanks.

> > diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> > index 492486707fd0..397262e0ebd2 100644
> > --- a/drivers/cxl/core/memdev.c
> > +++ b/drivers/cxl/core/memdev.c
> > @@ -101,6 +101,20 @@ static ssize_t pmem_size_show(struct device *dev, struct device_attribute *attr,
> >  static struct device_attribute dev_attr_pmem_size =
> >  	__ATTR(size, 0444, pmem_size_show, NULL);
> >  
> > +static ssize_t region_count_show(struct device *dev, struct device_attribute *attr,
> > +				 char *buf)
> > +{
> > +	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> > +	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
> > +	int len = 0;
> > +
> > +	len = sysfs_emit(buf, "%d\n", mds->nr_dc_region);
> > +	return len;
> 
> return sysfs_emit(buf, "...);
> 	

Done thanks!
Ira
