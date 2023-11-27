Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ABD17FABF0
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 21:48:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233341AbjK0UsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 15:48:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233332AbjK0UsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 15:48:05 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9354187;
        Mon, 27 Nov 2023 12:48:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701118091; x=1732654091;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=nNUoA+g0CQvaCe8wrGvhIs1/OQN6Mc+y6bwebPdKXZw=;
  b=EoSo5ao5F9JW1yLeuhbKI79/75e1xHjNkFbbAla5UzB/GnVQ+eIv5m0I
   tqbYLdG8sUiUthRB9WC5PQixha1NeshR+G8zLTQgvmX7XhQraQSwnIbpQ
   fM3Jqnjw3PPLxOcAUwWv+EEmvaX1kwmaguCAqxIGug70FG5yvF9d2XOC9
   zFaFp2Q2ljxSFyLuNJl5TN/x2uYLQZYklwfmWjdNxgMnRfqWwCly4wxAf
   oPreU9Vz3hSjCe1Nle9oicM3nAz3Fhi0YnkD75WipYyI3V/bgUbchSA+N
   bPTEFAfIxTTGyT2FYn9cc+RkQfo5vAVbVqai5KQ9ETkuPmd+WxDS9J2Ll
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="395605150"
X-IronPort-AV: E=Sophos;i="6.04,231,1695711600"; 
   d="scan'208";a="395605150"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2023 12:48:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="838831808"
X-IronPort-AV: E=Sophos;i="6.04,231,1695711600"; 
   d="scan'208";a="838831808"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Nov 2023 12:48:11 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 27 Nov 2023 12:48:10 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 27 Nov 2023 12:48:10 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 27 Nov 2023 12:48:10 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 27 Nov 2023 12:48:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OT12PE0EYXzXqVqFv6+yx3jH8hFi2SX7UHjree7Sya3k/ajlnX2CfMo+9ePO4m1g45zGFGH90MdNcgkFEVsjxy6ubAFASxTem4y0Rp+ZUBWEhmR6TyAIiOvlP35OyqXlH9cYLXlKyQDEJIeHMrHCAllq//4FaKSoS91M4UPLDGTolU/F6iEcvOKOBwmmdKZaG+WY4i6LIUA+SpPe3h3TTWtBJZ6Tq4QQ9nsNF2RY6uBPGjBUyZ68R51mKDjQFiwZso2NdzjK9+ue94qenLQpwYdVEfnPDvlXCAvHvikHK9+hjN9rn8xJlI2hU5W3IAlDIn9q6Ua1faZAE2O/j/4iIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pmpMcnK3U1g0iI1ndfU7Gzx0oXvYuxUNeeixal1Zdb4=;
 b=cejFVPFoMneIEziJ6e9jkBejn22cnTLHRA3U2bo9Kwl7M1jeQf8P1dL/24tTg6XaTuO3fajL5W4rixpo0MNqRU/akreNklnHkb+RVgcBr/jXneqXMri+uIdcC6nTvnIAyr9qw0hdhJiX4qrjeEwgNiOL+/uADSYYt5NR7LO3z1Tn/db4z3189b6gtUi9baNhCJ9+I+NsW+z8KjrSlxcydy1AyUnyT5qNVOABYujKYXamWE50vIsv7GNIcP7iTC0eVg5U4A4DXZqBD8zboNXgLSmwoENbhRTRLfueiMLYS+v7D4QcJZIYcBx/bd0oZ99hxnzuT5qJ4LLA0tvVZBEftA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by MW3PR11MB4731.namprd11.prod.outlook.com (2603:10b6:303:2f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Mon, 27 Nov
 2023 20:48:08 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::d3b2:2f2:701e:e8c7]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::d3b2:2f2:701e:e8c7%5]) with mapi id 15.20.7025.022; Mon, 27 Nov 2023
 20:48:07 +0000
Date:   Mon, 27 Nov 2023 12:48:00 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dave Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Fan Ni <nifan.cxl@gmail.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] cxl/cdat: Fix header sum value in CDAT checksum
Message-ID: <6565008062aa8_5ec232942e@iweiny-mobl.notmuch>
References: <20231117-fix-cdat-cs-v1-0-ffc2b116ca6c@intel.com>
 <20231117-fix-cdat-cs-v1-2-ffc2b116ca6c@intel.com>
 <962fa507-b9f5-4646-8090-cf63f737e84f@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <962fa507-b9f5-4646-8090-cf63f737e84f@intel.com>
X-ClientProxiedBy: BYAPR08CA0045.namprd08.prod.outlook.com
 (2603:10b6:a03:117::22) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|MW3PR11MB4731:EE_
X-MS-Office365-Filtering-Correlation-Id: 274aae29-f3c0-4f5c-fed6-08dbef8a28fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u9cdMuBkm+DjdrKThJAD6uPfqUB3cJ5B4zwcg21bZVlOeOOOPI0gWoIuPFJ2z7Dxzl5OgpI/X3tBu8Knecs5qcs/esvAQnjsGTFIMn1f6/LDaksjZ2n8j28IO+SDVOX/kZQxSnWdQ1soR8lMha7CMOc22TazC0BpXJluVq8fV8x2a8D4ZiJ9JmHmAgzdPUgxJVIHRtHX+MKKZNgAmxiaznG9RJMTHlEZLcl9ea7qfEJepjd7sw5PY7uXNZbHpafsD8enXrZdjVSSs2B4x5/QL597QVRtgjJ8kAvADm6YHbASFF1h3YPqQFJ3Bk8vYMJKyrXs5T/ZCtY73sIm8U5dLarp1TGcIq7VSofbjD/6D7zyvQxMlFBJLLdpCyXeATJkjEMKIZjJYF2ArF2VmLFdCICnsdvIpaiNAb+xBWiy34Ecc0F7rXNt1h13pWLK3kJ4AwsvjxUFFnKI2if1aTEBhC2LvcYbUb6fL6cCz5BLShDjZIfJxVyCo27IUWMZFNoSUAAJU8SRNrxASQz5mRINM1OvdtYiuZLU6rj5o4Zfwx5VZWqE+xCo1QSBVcR3gE05
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(136003)(366004)(39860400002)(396003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(38100700002)(41300700001)(86362001)(4744005)(83380400001)(5660300002)(82960400001)(26005)(44832011)(2906002)(6512007)(9686003)(6506007)(6666004)(8676002)(4326008)(8936002)(6486002)(478600001)(66946007)(110136005)(66476007)(66556008)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uz5S5vAGprgQ0C+d0uU+7E7NliuvKArnAGbVAUYD/OeZEVzHe0LqfRocQChQ?=
 =?us-ascii?Q?daVv7gdyHcfRp6RAc/Tu3xfy3zuEUjlLOjBkwKE9NiLIi/6I7VJAxj1TcbM9?=
 =?us-ascii?Q?YdNIanh7AfoECMxn4uI+dmVRLYDcdPCL3rvI5df/N0h+9ObzCt5t3wxzGSvI?=
 =?us-ascii?Q?MCUipR5EERZ7Bk81H+AbzR5daZSmbamS7qp9htrhE1Dkk6A6D9kJALJmTFWt?=
 =?us-ascii?Q?MjSQMfQ97xTAjn9Nwui4N5ecI/HTze2LTcx26qlIJx+i2zWcTi4bTExJvRzR?=
 =?us-ascii?Q?Vv4Mwo6wEaSXJZYjHzLH4vB/2z4OPQP9EI5MvHCWJPtcjRWMjtlA834i7e8b?=
 =?us-ascii?Q?IP6CWc6R94PRx5Kn7IOxbWiO+WA/xP8C+NNwVekxJoxkU4DPHvnkKusNRRvx?=
 =?us-ascii?Q?DxgMCmIadfCApkqcfFKbTZ52yyzEIfPqzj5jYeB0+hoT7Ze6/FII8A4RHW4z?=
 =?us-ascii?Q?WdQEGxCAWuuBlx8x9xMJ3IFBbv6rWkhuaw8kPwaxfBt5yWM83He0C0pWrb0+?=
 =?us-ascii?Q?gpUd6OcQWKaz5wjcxuI7wYmX2NEJrbgMs04IcjKnMhHd1Szz+WWR14kv0GjS?=
 =?us-ascii?Q?aoUSKwT/nhiqG7yeA36KTeMlE11W+lVlo2o8x+U9KfBHsl3FPaBJWVMfjPyJ?=
 =?us-ascii?Q?PKLuzi5WKRcTspsPYr7f2AWldt2WACgdRyXdftzCv2AVeJ2ZQNoQ5aWstA/A?=
 =?us-ascii?Q?cKnubXZQCH/7o1dT5GNMUbjf8X55NampbFOvMmHfZYA3r2edLJ/8obQro4BG?=
 =?us-ascii?Q?dp/NEzB+zWnwr+fvLi4QxADpRjqsz62BRcg60orlg5HnFG4aXlGj/OlAcVm3?=
 =?us-ascii?Q?mmh7VaaIl68JJWtx11CMEsXro6Hzy6b9CYuBF68o3aWmRP5zaKggMhROYxTG?=
 =?us-ascii?Q?hEFOyqOdQEtI/voLqwP9+OcrtG7BylEE+7J+IHYmFpQQRUfRPtLWj4Q085DD?=
 =?us-ascii?Q?casOHP7iP//bRuqxgA4ELaNHyZgG7JmixRI2uZKDlVKo66jPqZQ6PoEiqoq+?=
 =?us-ascii?Q?SMoKrMVLE7gujyEHUPAAoNzA28SWPVyB78S78RFWlc9gyXzo0t5V8bxacXvo?=
 =?us-ascii?Q?19Dy92BjNiHWqwAFj4JX2skR76Q8HsWlJVxvQH2ZluBE6W1JNgoQZ7WIA19P?=
 =?us-ascii?Q?AOehjkb3+y5188kBZtGtNkK1X7eLIdR0i5OUfW57R+9EM8/IRGqn9zG86C07?=
 =?us-ascii?Q?DuOPD5JEsh65XIW4+cVNBdr7m2QMUb3c2kj3REplUrgrpOmjS5o8UA2SqCKR?=
 =?us-ascii?Q?I8vF62XqW9vOY4Pk9GxGL99hy3svLG86b018mnVr+mOoLcEnDTkl2u0oL4Ws?=
 =?us-ascii?Q?LGMD1zXb4tRhLnB6CKFcRYiXbjOrnifSj5O0oSQFSHU0HjnZKRwiRWbfAZFQ?=
 =?us-ascii?Q?6rX3wI0WS3qwgHxX9CttlnT1XYiqLmrHsGwC/goPQ+j0gS6eC1WgvRHRrt09?=
 =?us-ascii?Q?lGIHySNej9fRCZMZYXW8cNYqVmuPxa/UyDxU+EVza5vkjsWfUtEn3gwGy0dZ?=
 =?us-ascii?Q?FWKHAJIxAQeKf1yj+BGcEFUTdyRUmTmO3YYVdcg/cEAnhxry60XpHm/7qZPa?=
 =?us-ascii?Q?xuqlLVKhQZw4zq9dEyVpdkqXFI2arcPgwTf7IfyI?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 274aae29-f3c0-4f5c-fed6-08dbef8a28fc
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2023 20:48:07.8166
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n/FolCF8QAQnnGF3N7rka33cBvw1/nvsxvyqcnoXM6Q/xCTIJJzIOIaovn2ZjLLXyay++v/3QjcDqyuXLoLvkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4731
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jiang wrote:
> 

[snip]

> > diff --git a/hw/cxl/cxl-cdat.c b/hw/cxl/cxl-cdat.c
> > index 24829cf2428d..d93e2e4e64f2 100644
> > --- a/hw/cxl/cxl-cdat.c
> > +++ b/hw/cxl/cxl-cdat.c
> > @@ -95,8 +95,15 @@ static void ct3_build_cdat(CDATObject *cdat, Error **errp)
> >      /* For now, no runtime updates */
> >      cdat_header->sequence = 0;
> >      cdat_header->length += sizeof(CDATTableHeader);
> > -    sum += cdat_header->revision + cdat_header->sequence +
> > -        cdat_header->length;
> > +
> > +    do {
> > +        uint8_t *buf = (uint8_t *)cdat_header;
> > +
> > +        for (i = 0; i < sizeof(*cdat_header); i++) {
> > +            sum += buf[i];
> > +        }
> > +    } while (0);
> 
> Why the empty do/while loop?

Because I used the loop for debugging and forgot to clean up after it was
tested.

I'll send a v2,
Ira
