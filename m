Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B83077BDE6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 18:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232295AbjHNQ1B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 12:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbjHNQ0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 12:26:33 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74E84A8
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 09:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692030392; x=1723566392;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=rT2x7YjS2JmfF8F9Xsrb0kiygIKw3NOJD4pp8CxMCmE=;
  b=cPDqkPwtJT010QIl6Y7ODWxpiL50b6VKf8h9XYP+O0m80cqH/dBONNcP
   RJTE4jXsMahAsSOX+SRESgDZHI5oY1QrSdUk3ElzG2UgsdP7EcqMex7xB
   nnEj5T1iMzsnUWo6FP23v+bgkFgQZDGlA+ojI9PL49DfVVBP/nf5xoU5+
   oxDmTLhEZzRRtm6Z6Q8luqKt4+kSTbEyGuch8nXe7f7XInnhSTUSOC591
   jPH/LJSqVRpGNsJC0Jq4Jeezj2fz5/pn6bmTY001gZ2RYuJyNgU/lcxU/
   uWVZkO2G8YSUJmTtDgTHoA+ThO0P6pfUAiJRB/yAnx5N4bJhXZSXh0D4u
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="438414819"
X-IronPort-AV: E=Sophos;i="6.01,173,1684825200"; 
   d="scan'208";a="438414819"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2023 09:25:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="980039239"
X-IronPort-AV: E=Sophos;i="6.01,173,1684825200"; 
   d="scan'208";a="980039239"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga006.fm.intel.com with ESMTP; 14 Aug 2023 09:25:12 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 14 Aug 2023 09:25:11 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 14 Aug 2023 09:25:11 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 14 Aug 2023 09:25:10 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.46) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 14 Aug 2023 09:25:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ou+CUzn37lHykA2+8F3JYBvcfQ+qjiLDd10EG/Apuy3hgPZfqyQfAbSm2RLzTvUaCeQEMka28qnm6VN/rW4yqpSRAzccEdcO68DlKUFNcme0HVuXTT0RxH3yD53VlT2mgao0iOV8uHrJvVopRWnmCOmRaI/FLbdjpRVJZDTTKSCDgM53OGimmn946rmlT209eTF5+NHveQn1n/w1jV2np6NWyowaHaiibrG1HfmU1YQu192Pi5tjG+fBqSyxf61cbTpsudtIyptDd2uWw3krUMo5Ql0QgUtUtthKZ44jx/obc+ZhiK4oIGUyGPPS+mVayHk4jm4h9YCi+uMxbtRKpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CIiJEHa9U59oGntGOhzrq/cC5WDeRLbQZ791bDtHbUA=;
 b=mSrkKGYUa8FVcyh1ArRxdrMLT8lygLI2k7fhmbmcjeSb7eCgWebOTfHFi+orhgZkDAlMNRQfFoJQx2aUwOPSaCwBUYzM7TSyxv1JifIURxzXeYC5DQjkVmzY0xJIt1r6CebyB7FiBjdJK0uxsyr9UnsDhR53ZOxu8m1eIPFNrnAAhzXXfHX9iuQ6jpo9lFq4+OS1A4ciGz1ZJ6UHrNrxmWP8Sdsh5OLqgeN4rC6BJnXsuUNM/qdpbJyKDRAQo6XEzfEjqp+peZS56wKhxPKMIDTLdQ6/k72sXS2AYID0ad0PkapGlFSbmqKE/fYTPXTmIvUD0R67QlRY77kxqjWDOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CY5PR11MB6233.namprd11.prod.outlook.com (2603:10b6:930:26::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Mon, 14 Aug
 2023 16:25:09 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::acb0:6bd3:58a:c992]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::acb0:6bd3:58a:c992%5]) with mapi id 15.20.6678.022; Mon, 14 Aug 2023
 16:25:09 +0000
Date:   Mon, 14 Aug 2023 09:25:06 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-coco@lists.linux.dev>, Borislav Petkov <bp@alien8.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Dionna Glaze <dionnaglaze@google.com>,
        "Brijesh Singh" <brijesh.singh@amd.com>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 5/5] virt: sevguest: Add TSM_REPORTS support for
 SNP_{GET, GET_EXT}_REPORT
Message-ID: <64da55624c6c1_2138e294cf@dwillia2-xfh.jf.intel.com.notmuch>
References: <169199898909.1782217.10899362240465838600.stgit@dwillia2-xfh.jf.intel.com>
 <169199901829.1782217.16990408177897780160.stgit@dwillia2-xfh.jf.intel.com>
 <20230814112144.GF776869@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230814112144.GF776869@hirez.programming.kicks-ass.net>
X-ClientProxiedBy: MW4PR04CA0267.namprd04.prod.outlook.com
 (2603:10b6:303:88::32) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CY5PR11MB6233:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f0583bf-4404-4457-c3a3-08db9ce306f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YWsaxbHZf2jfnrocylbpeAoLVcMMxyhlrdPf3vihYl5Soyn7DelOu42oEa/CdYuoycbGRx+SxSkDfZ4SF9Bk4EO9XQzdpDcthg95x3nM4rmKmm6Ibw+EiGjDk/fvHXJ8mMGFGFNYnDHoxIQYU7GVImdh4jNY2Hv0VkZ6cvWIfrO0gQKdD9iwM5g20lyhAmeGTzk/wOjhbSR2+iCIhKNR3xvz+sG135u1OjcFVqquttif3IgDBJQBoQe2mZPjh5scMidkD9USlBgEGaholG2wjFlJArJ7vAQQ4jTIziCCTsUrxl9w5HlpquT6AmmxWQWXu57SINj7FwClRcbsN8rInfVTHHY26i53VdxYJVgLRV9BHMn5Ti3s2P/rHtpzf4S7tm9fNNnYNu/+XVrNjuaHK3EJPioQ0lRZvBlYGdALqwSmtfCt4xsYMKR0pHJDhKV5xnwmkyO6WBXk+MPOx0EDanx7K3j4d0CO6F23/DpuXYPiqVNXA8OFUEngUQ/yQOmdOvMYrNgP1AQRw2sNFUSXA1Dg+PX/G9V+AnlZU2GvtptH5mFw7G7UgTAMlujmQl6r
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(366004)(346002)(376002)(39860400002)(451199021)(186006)(1800799006)(38100700002)(110136005)(54906003)(6486002)(6666004)(478600001)(82960400001)(5660300002)(2906002)(4744005)(86362001)(4326008)(66476007)(66556008)(66946007)(41300700001)(8936002)(8676002)(316002)(26005)(6506007)(9686003)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TpHmUAVgPb7vlIZ3j7jO/JavVFbcLNQ4fcmXqj3rOToWbDJIOjnjkTjQlsst?=
 =?us-ascii?Q?Efz2XbaC3X8prxWEs45do0LQ/UPkBDI/qK5/3jpyljm0b75qRdmWsgO8rCh0?=
 =?us-ascii?Q?1k5jlTEJzErpZAm0mwCkW0rxQTh9qEjAyIBQnRf0W4rCZk+nj9yjbkeHD0Kx?=
 =?us-ascii?Q?NwEuVOIDUOO3LdMzFmBLLC0VBwbsr4honvcEv5dYW6uDbokZS1Ob4oey6d5n?=
 =?us-ascii?Q?c1sXeQOzfdNmxxyN6D0L0YayXB8PGpsBDMZEx8NC+UfXpUzPbiadZFNqeFj1?=
 =?us-ascii?Q?esrJeQ6tvkfAOJ9lpczutwiSuLN9I/+uNdJ9+RJ6XP5wKESw543mzqCMmwII?=
 =?us-ascii?Q?fvqtstaS0VXBtdzytuX6PmGn0StqksKC6YM5YNqjyQJlb1RoXZ3xz96HjLad?=
 =?us-ascii?Q?N5No1e3OODjnPTVLxI8VIuWJJ4eQiWiiZqfq3wXfV/BM4Or52U+7wVQ9Y3KB?=
 =?us-ascii?Q?CVj7XB2UbOTSWM3FA7pHdahsA7wD3jzNrue9KK38BRmbx8kizHItq2pWyeKT?=
 =?us-ascii?Q?8UcYA62GWYe7Q1W0KuYL0/Ag9Ia/BR6wYor8aAJHXZ7RsczPEOWpBsH9Ah3g?=
 =?us-ascii?Q?miPa+Z6XfKlptRTLh92tsOAzt33u2/onYYRvsqErKD7hBbxzi7YkRVQsmS7G?=
 =?us-ascii?Q?O/onXIpf/8Kcg5rePVBgkpzcGVMEWnQye0vRJYgDZEJd2twrPmoDoIaPnLnR?=
 =?us-ascii?Q?jfAUSfjWBYMLJU0bgpgG4kEIh4K6rgCStNBaV1ePzqoR8dwasLvchcA0uRMN?=
 =?us-ascii?Q?mzPDOb3FGJxfBQft8PuQHji3sm64XTGIEfQcFYVwaL8y2UM4ZzsedmRuJmQk?=
 =?us-ascii?Q?m1q+dltfrOga552C3W01OnWCneJP6oh6HNm/4/+gYBBBmdU5i8c8kzJYk42q?=
 =?us-ascii?Q?3iK/NdukK1BA16ixbcB0fFC7gcjw48r5D36UjPiSyYzYbTiWNaAKXs2TPKFf?=
 =?us-ascii?Q?4I03jX0OUJfJYukVtXJkdvmZgEsSQONi3xRyqx/Oxq6Soq9tF/9wzuqY1fra?=
 =?us-ascii?Q?5wYeUiBM3HPxXVmTnwzwV1GD1BcritqQZ1EYYEOOdjbZYyW1wNvjTSbFp2d6?=
 =?us-ascii?Q?7SFmSfrX38HzjEnSQOhQpvgnuJ9XGW3RtMKYTyQibHIcXmHrIiy8UE63INVs?=
 =?us-ascii?Q?vYrgBlqFdQewy9BdOHpFE5Y52qjizqRo0t+3pcoteMyetnLhVCVpD/FNjhZf?=
 =?us-ascii?Q?9OaYMP0N36QoFffL9F6l41PwKN4LCdKbIQuPEVbyB7p1ptzt/bRZECUz8vwV?=
 =?us-ascii?Q?QlbWIAxNXtvR6t9xCrROW69yFeFj/AvzrLrKzNtRkgNqYDAU5Zak1f6PmSqA?=
 =?us-ascii?Q?N/sumiBgYZASUjiyt7pHLF/l+d8h2ZPpQZ9cddzMfexMyzGqQNDIq1xtxdLl?=
 =?us-ascii?Q?nmxKlK+hxjc8idfNXb9tQQlfRRBEXdX2hbVXZ1T5MwXJM/xoHXZA8PGhdM7C?=
 =?us-ascii?Q?NhTaOtBwNAWe8yA8qPfZ6iLa5VdSMhCu74zLFK1Ix49plhooAyMn+YAoCWrS?=
 =?us-ascii?Q?MdglFCnAgF9NbaIft6aRPfIYghXv2cCU/5ThLILHTL0LGlkfl3rBl3J2XhQh?=
 =?us-ascii?Q?BDsT4ryn7kru7Itq28R3nOYFiYHnfisr39NhkpQg8rKeiJi8r/ragJ2UvYUf?=
 =?us-ascii?Q?yQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f0583bf-4404-4457-c3a3-08db9ce306f5
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 16:25:09.2910
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0eVjMMhHU6Id9nqwUGbLoEZkwqClX0xAwmA94L9ZFgazgbdd2axFOukrbPId4Hcc2OHhrWHy2YJaLMFAKtwy5xYfZxuaVOSu16OancX8DqI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6233
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra wrote:
> On Mon, Aug 14, 2023 at 12:43:38AM -0700, Dan Williams wrote:
> > +static u8 *sev_report_new(struct device *dev, const struct tsm_desc *desc,
> 
> > +			  size_t *outblob_len)
> > +{
> 
> > +
> > +	u8 *buf __free(kvfree) = kvzalloc(size, GFP_KERNEL);
> > +
> 
> > +
> > +	*outblob_len = size;
> > +	no_free_ptr(buf);
> > +	return buf;
> 
> This seems broken, no_free_ptr(x) is basically xchg(X, NULL) (except no
> atomics). So the above would end up being:
> 
> 	return NULL;
> 
> What you want to write is somehting like:
> 
> 	return no_free_ptr(buf);
> 
> or, a convenient shorthand:
> 
> 	return_ptr(buf);
> 

Oh, I indeed did not realize that no_free_ptr() had side effects beyond
canceling the free when the variable goes out of scope. Will switch to
return_ptr().
