Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B63C77FA3D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 17:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352730AbjHQPGm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 11:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352774AbjHQPG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 11:06:27 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B833D173F
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 08:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692284785; x=1723820785;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=oyJhmGKS3fuQxtw3wJJe029MWjWcZMj8/rjel0cJnSw=;
  b=LaTbmTGbNyb9myqx9a/oAJSvAhvMDh38LZiA+TPb3c1XpPWWb2y4lsLC
   VjKkaSiyEVlJksbw8SUcaeqEnxJ1h/XZSDsFAaMQAplBxk6DGhNjtR0E3
   SK0w7Zx0dWAFqDhBK/oKDJU4UgkOm7KXNaOS7U1OA6g7ksROIPW8f/48H
   B9SRjLyS3PKI+xhI8wPbOnEc0eXsfLco6j5TzlzEVEZXTVtZTWtX4LcYY
   8KcVyeYK3Kn07aCHgp+QWkVz363xlx2PRyoEdmbWi9dzx6CEsPx/Eraql
   uIqK4vOYSHIgOzlX6hmKeUO4ZClyjzrhMgrn5q1SMXDG7On5JCqkdsKD/
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="403818358"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="403818358"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 08:06:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="1065291607"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="1065291607"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga005.fm.intel.com with ESMTP; 17 Aug 2023 08:06:21 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 17 Aug 2023 08:06:21 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 17 Aug 2023 08:06:21 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 17 Aug 2023 08:06:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JQDqHj1smPGdP8BvUFrmDfJx99wfWRhelONsCGFBIvkPo8pLnUUVoFWaskk5lJgxk9We4e7FWHV4gDakPpRI8a0TNzv9U2nqCaGqDE78YQ0v+CrQLlZAvgGME35cIRulkyPStlvj3f5aoTzApfLz99244oA1XB245aizSIDZQL5rl83fAWSHGRw/0xtr+9FkkBgycdNzO1Owh2tK69iQXgd7jg4ndZhCKrVbq+pPMP87kWHdaaplWg0p+UfjqBvSHzof4HG2FUXsazUKcrOmjPHL9GBE09a7p7ORLNA4rn11DpkigGvfBNYdbS3CCLpbEG7/hvgZc1dIzPOhZgsBRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oyJhmGKS3fuQxtw3wJJe029MWjWcZMj8/rjel0cJnSw=;
 b=fk54Ihmq0psHQALPW/LQRYH+01efrwpHE8HjdtrLWdgrj50Flu8X2qB2V4EX9NInPzWmtTOu2aylpeOBlZcaTL4zvC86hqentTKK5mxyraS+/tmNG1WGpemjsh/dEXOVjt6ZUYb2fbhrIKzgsY+31EKtJVC0m/Vlutx+aXB0Cw4PDQDcEujCQS9HHg9jToEPdtNA3rNQvKW4Q4rfJAzFStM8sESOZPtkJ2pgQMpOj/orRQ4AFuu44S93knHyPBkiosI53GfS5rjrykYvZ9vRgCuIJguWNuIBOvu8SR6ZLHwKhWJDtl0Z32KbnHfi7izaIhVvTjMkkbrCnEJxYRxTlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA2PR11MB5209.namprd11.prod.outlook.com (2603:10b6:806:110::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Thu, 17 Aug
 2023 15:06:19 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::acb0:6bd3:58a:c992]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::acb0:6bd3:58a:c992%5]) with mapi id 15.20.6678.022; Thu, 17 Aug 2023
 15:06:19 +0000
Date:   Thu, 17 Aug 2023 08:06:15 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        <dan.j.williams@intel.com>
CC:     <vishal.l.verma@intel.com>, <dave.jiang@intel.com>,
        <ira.weiny@intel.com>, <nvdimm@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, <yusongping@huawei.com>,
        <artem.kuzin@huawei.com>, <kjain@linux.ibm.com>, <maddy@in.ibm.com>
Subject: RE: [PATCH] drivers: nvdimm: fix memleak
Message-ID: <64de3767e1245_29e22029456@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230817115945.771826-1-konstantin.meskhidze@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230817115945.771826-1-konstantin.meskhidze@huawei.com>
X-ClientProxiedBy: MW4PR04CA0300.namprd04.prod.outlook.com
 (2603:10b6:303:89::35) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA2PR11MB5209:EE_
X-MS-Office365-Filtering-Correlation-Id: d8aeecbd-3080-4cef-bea8-08db9f3382bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VEKaZhBvQWLmg6y9/VLgr0oSA1xGVMTM3mD0n8PW6lqatW3zAZbQRVXAo9iDyFWlctk3XHUxcR13et7LeB74Lw3dThWWsxRBWLWZW60DsNL3CrhpDx1Q31gcC69WaY4Y28YZqLeJ/X/agSz3TboEYtUY+osBxOVXza4/p3z2dZT8A5jlzHgVib90Lg/ps4HpzqWNP7ZEzR0igYO/KQpwOR2lQF0GMI1x7Le3zQXYD7isDCJiZ9cM9pEW5LUa5092qnChVOZooBb+CMu69Num4nW47J+y6iub+izEdO1ntf/hAF13xfLOfkyhZejYUPIoqCHKteYojXRIxK99Wv+zwgkTVtXpUJJKrWx3vv6vGH8biAGhZcP2LDnxBnNezTc5YAwuHqjpzBQ2QxrcALGVVgMqk92gdBmtpD3Ca/q6BLT/WG+5yMaz55HpWc3dFSBpRh36O/bLxaQsozEnht39t172R3cODW5SQ6j7E9GTSSiMuD0R23Ck996c7ud7uKlg5BnJFu35aT+UYjI4A5At9cPKLmovkuhKZVRBRqKgI2WQQd/Te/2MW1r59yv6uju7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(136003)(346002)(39860400002)(396003)(186009)(451199024)(1800799009)(2906002)(4744005)(26005)(86362001)(478600001)(6506007)(6666004)(6486002)(6512007)(9686003)(5660300002)(41300700001)(316002)(66946007)(66476007)(66556008)(4326008)(8676002)(8936002)(82960400001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Zjdcbt5cwomL+/wgwvN+/3EyoeXWsSqAHhQ3A3R/4CD8WdENuIB1AvhkvLKs?=
 =?us-ascii?Q?zd5OJUGUGR6qN6ubNEM1Tf5XNTTnnEbcgdwj3d7AJuccSIcPcIZYVsNaKDJn?=
 =?us-ascii?Q?8KNd1k81wlGhU39ZmMcxLgw8w+OJLOlf5xmmkPdH45vd3u6pLv8ZJJRAMvhd?=
 =?us-ascii?Q?BubGCda7CLQmCgb3x53x5C1BLwWqCqwrIH/Sgl5K4TUsx475HWxP0e53W41k?=
 =?us-ascii?Q?j7tQB/EXwYRNW6Sm2tFWfp74jvgs1E9dfHFhm9xEj+GR88cFdD0G4ANVvaVW?=
 =?us-ascii?Q?Z9yWocFY1wg3usv6TGb9xyonbORu3EafRXVQmzaOsbwFGALaK7oy/5zkqA1C?=
 =?us-ascii?Q?du6Vwm0WhBH+ZkPZiD52s3bviTsCXU/Ky7CFFWLm7CPUuOsGOgsvpMj1xFDa?=
 =?us-ascii?Q?bb5XNTSM7etguQqRWTvlnNkG+kNFm5pJ8bJEawFk8JDsL9buShpZIIW440/d?=
 =?us-ascii?Q?TW2EmTOutdueACUHgpfIm/ZUD4zFN4gCU7k/tM3RyevGvtGcczkc5aKfckzm?=
 =?us-ascii?Q?6ehDV6GI3l2XdazO6K5Ey/XAddPkeioKMBpWzzQL/OvrrskDXRs4kh6HUyln?=
 =?us-ascii?Q?D83xjwlPqiwFFmb/tRK831c93eCZm0F5qpSLVzph+vZpKGkmKmjT0cIdZ+bD?=
 =?us-ascii?Q?lGnlmUb3pdXudbCXejQqm+Fuh10Fgy4DL2q+7ohp0DbyZp3hGDkhd08sc5zU?=
 =?us-ascii?Q?VJP+6fO6EpoR5CD/tvMJETe2KOaFEAUfodUavhJmGqvtlPIGUMuroFUmfi6D?=
 =?us-ascii?Q?BgcEhwo8RXw8dmUHwZg34n9+WBL1HJJBhl0BcRKhDcAlHWMM560rScVveCJR?=
 =?us-ascii?Q?8WU7hRb04J0IFatEdS3OjmLqsopiT0TZpFzTADeD2gTiom035CB2KzAVyWwU?=
 =?us-ascii?Q?ML+Rv0W8IApqLlRR/udObflSQcLA7VWmfCCnxTXSOpHCuWOXxsEyQ09qGYJt?=
 =?us-ascii?Q?CJeKKXKXTOUkzJlpteVZxL8cj3jZPTCYL9cbd+wnnx/9pDr7rxNuNUriLeg/?=
 =?us-ascii?Q?TWXW511EfYz3xTjwHht135yzB8zmWwnLJRiHcDXANWEPAF5nW+H8JYz7dhFh?=
 =?us-ascii?Q?/fveEJUAVh0TUSA/FflSFQWHOUyjKtKbMAKPaZvq9pKx/qutoiBry8f0ssZR?=
 =?us-ascii?Q?zg2PEhOxDCWfR8TXs1TyNrZcxlFsA59sIh/FbZiJ0SnO/waf1zC8D2+ieBVF?=
 =?us-ascii?Q?mtRDEhqimEhtuLG30Wm/ZRjuPRfwedUG6980HtgcA9BERaC13FfARQnpMxrR?=
 =?us-ascii?Q?gagQcZ0JV4Pztj7l5rsFzuaGfgRytxZw38GLJFNqaay92/Z6CNv7fvk1BT/m?=
 =?us-ascii?Q?AShUxuAOpQmVDd8nELjLTDvH+B/955ZH1HB3rBEZZfi/PD/pXx5xzKaUL6Ez?=
 =?us-ascii?Q?CDyIMdOSSzmRqm/7I9E72RZdDexuWBo1zXrxYpOXUBDCzTgTNWxi96S12D4Z?=
 =?us-ascii?Q?BPOxkTBzt+EKZmc7IhuME82jV+LdS9cfJe3sPg1/xIfIwkpbh1bSUhY9QMMI?=
 =?us-ascii?Q?9oaP40dA32Ul3w4zvqpB0KRnGcR8LdDBPYOM1qPp33+vtDr7g1ChCtFVj8OC?=
 =?us-ascii?Q?55xiGfZvfynovMNqrAwVHxfiHIh6Mp9HIFd08OgETV5M8xofTKju9UyMpQJz?=
 =?us-ascii?Q?IA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d8aeecbd-3080-4cef-bea8-08db9f3382bd
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 15:06:19.0421
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4w28Hxn7o54FammvceWEF5s6V5ZS6XblCEG1U8XWDjE6VIq56DOBRqyoMW3phwcJD4kEeX1UPI/v5POWwwt7i+ZwpVXpUwEQGYpxPugL2kc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5209
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ add Kajol and Madhavan ]

Konstantin Meskhidze wrote:
> Memory pointed by 'nd_pmu->pmu.attr_groups' is allocated in function
> 'register_nvdimm_pmu' and is lost after 'kfree(nd_pmu)' call in function
> 'unregister_nvdimm_pmu'.

Yes, looks like a real issue, but also completely avoidable by using statically
defined groups.

My fault for not catching this earlier, but Kajol, why is nd_perf not using
statically defined sysfs attribute groups?
