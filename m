Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B96237AC54B
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 23:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbjIWVvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 17:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjIWVvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 17:51:05 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD47B180;
        Sat, 23 Sep 2023 14:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695505858; x=1727041858;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=D/iIizdfDFqyGQBK6NO/5w2ohVbFHZVTRk1XNz9Uitc=;
  b=EhtYqDA2wviJnt6evN+By7DUORy5cyC0khhowRdSgbu+UkGJBZkOOPmN
   AI5FtgVSTuzj64ScsVyE/vO106UhOH3KvMEWuKQ4MMnrOiAwZ1Ymv86Ee
   ko6sfoxq0JhRWVI8pUb5mEoBYVf7YJ5imz5n+38vOqEQK74dxOndv1zAJ
   yfhpTxgmrzozo7GgxR169N2CItsn6VJfEc1FyelK6d49llynWP1GQ65v/
   F/lWsnKDeUtE8Ls4NCPL9uKZk+sR/xVlV9R3NtURHlSCmWifkVrSYDUI4
   TO2esSNEaSxKaMouwZVeiZPvkB1CZ3JmjF4iRo0GhTcNOrbUMlkD0fTCE
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10842"; a="384891856"
X-IronPort-AV: E=Sophos;i="6.03,171,1694761200"; 
   d="scan'208";a="384891856"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2023 14:50:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10842"; a="921559556"
X-IronPort-AV: E=Sophos;i="6.03,171,1694761200"; 
   d="scan'208";a="921559556"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Sep 2023 14:50:58 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Sat, 23 Sep 2023 14:50:58 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Sat, 23 Sep 2023 14:50:58 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Sat, 23 Sep 2023 14:50:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hLWyEbgTnialkiP+jurt8mHlPDmGC1yaEMa5s4m3KC+smvcxnLMcx9VzN02L6ZHfzxklm5PsC5SXAI9CwJDcpY9Av/p5feYnCO3qZYL807d+R5sx4vlDksC6jp7aL92P+m+L0TBG8R6S9LtieZz9qF02cNOk8fDgK/5L74XGQYYQ+qckL1Tj5mERmE2WsbCsEEQpoZN+moy19TB3sq53LujAbob96chJ6FNWmzw/sL2h3IYMZmSBxQc/fSZdObnd8zWFoIzGzcEZMdCjQ3iocR5HlycIflGYnzSopC8drfCUL18wwFpQfJFpho7g4IseNleopj/dfqPa9aPPLgaZ9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a0Pe7gjb6Kqv5fLvm5qYdq6NhUQKwDhAX+lgcRVIqO8=;
 b=Y9p+ZLofXyfjZaV07ZcraB2P7YHdM1VlYv2Rbm7MAulKseEfFGopEp+9e/lcP9PPcW0LMfX2BnOiUD84fvg0B2wc9a1c4JCIPEhnhAb7/LpgM4RbxnrxlNy27JaWe1VPbu7a17C2dwO+yy7/zYHRUPfl0Z66hpb6QX8gly8oSAGO3W1RsZx8N6Xm7T2PPEXrCTeyn5HWNCviRnWW3QhF7X8V/C5UCrBwS/DkxZfQuku+EN/YzhexqjTlvLtDcoWl31+H6hkBdcK4lESQKyksqvyvaGMuoMvYOmNSHb9Y01bDprtvV8yBISN93v2sW4Q723yG3JCCeFW234BThjZNIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by LV2PR11MB6070.namprd11.prod.outlook.com (2603:10b6:408:179::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.24; Sat, 23 Sep
 2023 21:50:55 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::acb0:6bd3:58a:c992]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::acb0:6bd3:58a:c992%5]) with mapi id 15.20.6792.026; Sat, 23 Sep 2023
 21:50:55 +0000
Date:   Sat, 23 Sep 2023 14:50:52 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Dan Williams <dan.j.williams@intel.com>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Linux Next Mailing List" <linux-next@vger.kernel.org>,
        <alison.schofield@intel.com>
Subject: Re: linux-next: Fixes tag needs some work in the cxl-fixes tree
Message-ID: <650f5dbc37797_1236929474@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20230918074537.51fe95ed@canb.auug.org.au>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230918074537.51fe95ed@canb.auug.org.au>
X-ClientProxiedBy: MW2PR2101CA0005.namprd21.prod.outlook.com
 (2603:10b6:302:1::18) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|LV2PR11MB6070:EE_
X-MS-Office365-Filtering-Correlation-Id: ed17238b-f474-422c-7f3a-08dbbc7f295d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K0WugrCq8PU4nVWnFz2XQuwgG2sHpqh4pm59JOKwrFE5iMQTmqVY2YlSPllXSN9WUf5gchNLsQk8uXzlzxnNQVlKXhnfW7p2OksEw5M7hrynoPgCMiRykx7/TeLcqfSucK+ZZDNs2zR5F7RAEpM/YAdGcR/+oF1UtdPlvsLyS0nOOY2/LEzcPPRGqhAhj+lZ1d99ExKDUOFo3jLjXMMmeNlSgIYoEnPB4XS2Iy941x2myqNQnpNA8hc/zRzQoTxH/retXfg6AiFviznvCl70i6nTbcUzGqUsf0Gsx06pqsOAZE+lPOSamILGaiXTiKAyMzDO5TVnnzs0dFcI+gc4ixD7OZPePNUk0a/g2qPBR5Tm/jDdm0V6HfYUFFVyTGXikSld938+FqYm7qPNeeQx/wbf216ccEaThJHm66AnyXsSpErBsAF+7MGGMhgTPrEjKICaYcpavzsy2eakNYnAFvb+HmRMjS+jX7GIx2Hr5+lQDTmD5qgTN01X540MdW2FgZWv9f27C5jMYE2HUhgZDJ7pZAkf3cBg9jpteuruVHFjkrB3jK22aaLPVdOm/dxg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(39860400002)(366004)(376002)(346002)(230922051799003)(1800799009)(186009)(451199024)(316002)(107886003)(26005)(6506007)(6486002)(9686003)(6512007)(82960400001)(38100700002)(86362001)(54906003)(41300700001)(66476007)(66556008)(4326008)(5660300002)(8676002)(8936002)(110136005)(66946007)(4744005)(2906002)(478600001)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qUL5Q7dpxnWl5LYBR3Pw3iprrT04U63/eLP2BONO7oqOrOjXYM90NPwAeyK+?=
 =?us-ascii?Q?/GzKos9nZ/mYEBJV9gdXNGyMff1u+3ROp/1rfeLz5BB9A00IHsqT9V/JEQc4?=
 =?us-ascii?Q?AswCAJCTNaceoOhFScmmT5pfIG+dxAJi9DIQSUVAyhCMr07Nq2bYBoaKnVYo?=
 =?us-ascii?Q?neApf0I5ZR6uY8lasBoxS40pkjzSEOQ6AMaXEM4wSILdX0GipRbeM8IoEOtt?=
 =?us-ascii?Q?x3uo7rta7PMC7IGIJXFurwU5DtKGMoYQ7zcunzC3g4jOSbTMDyl6hr5M/9KZ?=
 =?us-ascii?Q?E/bzEMcTRVTYWFGGb8IZM09pHXcGgf7JjcY/+mbQi5SIN3EqFQZaN4jMJ/E/?=
 =?us-ascii?Q?RpPFic58oMgscgGx+Xj5bs8+G2omXzlgrl0LdDalKG4uAQ1o5lx1hIWwHy2K?=
 =?us-ascii?Q?9tmPBRzCSF9tGWjvdKPL4XzuyN6/nSmkn2YISZzudAlwrTsozeF6s2v82rEr?=
 =?us-ascii?Q?zhZoo3SnF5ZvB5TzaF2bUvBKXq9SxSQCQvRCyBzB0lJIO4nAuycVtjziJPeZ?=
 =?us-ascii?Q?uDJMSpoalMm5pwNFhoZNug25+53hIZN08ZuSpvwd90Fnp3/Cxi7bMEgF461V?=
 =?us-ascii?Q?KkokkYoTOz7onpu3Q0llDn6fIXZ60/cHG6UDXtCfkm6Rhb5uAUrHK8Dk3dPj?=
 =?us-ascii?Q?ZVF+hMNu8/H13LaxpIGw7XbPzunLtqhoBoPRZUbx3Pymk1PXFQZaJZsTWQr2?=
 =?us-ascii?Q?2JDsWsUhKfh0Ka+Yp/eI3ks3fok71XSaHEl3W5mCQgCyF8Yk9juGVoNClKPH?=
 =?us-ascii?Q?KBKlkVBtuwpZyUeRvA721dIIOOkJkplR57CKgTiSpk82zpvYw85r8xdOdqZ4?=
 =?us-ascii?Q?XnLzfUI3YR1f7S9OiqFadJ+0AeMEOVh9A97/Z1dpJb793/k/lxaaOKmQS2qY?=
 =?us-ascii?Q?PtgVUY92jgaYAW/X9kXRLo6dOWCNmDzUWm6AWAA+2+RGJTt/dyt4Qe3KTixb?=
 =?us-ascii?Q?2Bq/N2SpcWP+JNQW13rhBHGynt28BdKk3otUhYGFdl/O/phSwYcUorkFTfZz?=
 =?us-ascii?Q?mIhOmeHT6XQDgF1kMxd7Ws3jPNV9VzjY2Jq+VuFSQMvEBCNGQLX/DH3ernsG?=
 =?us-ascii?Q?5h/dAZeFlUuaUypNs07sZvmEZ+Dfb6vq7SYt7E1lofshDC1JuoS6NpeWfCB3?=
 =?us-ascii?Q?nLr246RWAq3p/2J5aUJU4Ovi+4rDsvudZnOLLQf7txO/X11SNRWTQ8SxauYr?=
 =?us-ascii?Q?+au0d5TpXQagEWy/mtgxigWopNJvUW8wpk4uk2B/7Nx/AzSWduUQWArjhkGq?=
 =?us-ascii?Q?NsCFrojXFtIlLJzE7Xi54wPIH4etA4Zwkp+WO3rFctqa8dK8YDyO9d6z53hv?=
 =?us-ascii?Q?Zrk7WjqttJWXAeWPagaHeGa9O5DWdULh9MFwv/QOCWUd08qwoqbc4LzM1D02?=
 =?us-ascii?Q?q8W2l5/SsSqXjOneI7LpO3b7ELqehWqSEMwuLAJ+ZMBmpMUBQUJKypa/BBPr?=
 =?us-ascii?Q?r3rEH5ATO5/wuaxZpsjwqnqOLmLVUKx+BdtpvC39ETXBq/PzgeCvLiZqjYCa?=
 =?us-ascii?Q?irqwTM4yexcRyTH8SF51BAhD/JKnP9R8AXbU9bOXo5YcU0m+nm7kcxZJANjB?=
 =?us-ascii?Q?JzbyKoeMnHz5Vrn5D6FVHgFsfZp9U+oQPkG7fEfezxbmSzCzg+aAkadt+xbs?=
 =?us-ascii?Q?9g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ed17238b-f474-422c-7f3a-08dbbc7f295d
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2023 21:50:54.7878
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bODtZDLKqO5hcD6N36jUJD6xEvYMv8EXliKp0ouF3Qd70/+isNAMkFBDmjMKmDZN/xbmzOsjsClk76MdOCXGveazv36KQ/d5Jpe2BAlQ8dU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB6070
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ add Alison for her fyi ]

Stephen Rothwell wrote:
> Hi all,
> 
> In commit
> 
>   18f35dc9314d ("cxl/region: Refactor granularity select in cxl_port_setup_targets()")
> 
> Fixes tag
> 
>   Fixes: ("27b3f8d13830 cxl/region: Program target lists")
> 
> has these problem(s):
> 
>   - No SHA1 recognised
> 
> It should be
> 
> Fixes: 27b3f8d13830 ("cxl/region: Program target lists")

Noted, and I missed this before letting the branch soak. Will highlight that I
did not rebase the branch to address this in the pull to Linus.
