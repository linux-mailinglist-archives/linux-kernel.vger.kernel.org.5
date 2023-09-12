Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DBD279D1EE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 15:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235469AbjILNTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 09:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235320AbjILNTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 09:19:31 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C9510D1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 06:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694524767; x=1726060767;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=HG6MCGkzzq79j1ZlD6pEW84nCYH28gpr5UOFoOC1HRA=;
  b=iUaugDspJQR/uiG7pSQe11L3mQgHqz/q2wp8jv07xiXeqQ9e8qypIdZI
   Mdl9RQC5LtnbGGPxNYMrnNfmYeNmWFv6Ztx5fPSAgK10fJ5gA1Y9TfonW
   ewWWSumoD/gst4h63zMzqSnSzdDGK0VuBgWjN2F1Jh4kripIHbgbMnAk9
   i+Gp98oQo56TsrrItRL80+J3/5cdc96dgPzaPgzBEAiFRNrhXqk44sVez
   VAaMWyH7bkQUPlUjLRvEHKk4c8zVshSIuIWeNiDFK0CXCq3flwFWewlMJ
   rpY3x86bNswqjIvXgghqzSAhX8qx+ZmHZJh+U05ME67AROZ8jPhJ4wtUh
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="381071154"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="381071154"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 06:19:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="990499510"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="990499510"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Sep 2023 06:19:24 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 12 Sep 2023 06:19:23 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 12 Sep 2023 06:19:23 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.46) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 12 Sep 2023 06:19:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Et2ghq9ewBk7FK1hncQykwTXqHC5BjcoB7x+BqiURB5uoECfOux23LSvZB4gN4vGYq1xJOQ2dtlZPEiPM2l7qskb3IiynrV44focABJ+TtHRBCCbAlJnb44bi1GJSWAhlo2Dj+5xulsZf3qWmPaz2P7OaQFrowYbQoMvMgPzZD7fZara00LUeWHo0/v2/ZBgrUyD3Ys4jIU5hyrMRFe2hVXF7TGD3pyKJRRFsEeXh+PHKXamMTJpFSRJhCRl2J4iR6rJWnzFSkS00rpI3XStcan5HXavSAjHuDIRjvB4KizRDDALfEt93KNXVEKUIYb7WbKlmQfw4gsxFF+WmacImg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hV/Eayf1fWoL+oxARHV6slrGWnK3Da+Ti41Ara72mNo=;
 b=gcXbYvXq+8DCyrIjLIjXUWthlTQdWXTpsO/4Ma+cPH48pmVuxBDJd9h/P3wEFFabmDXruZXkU/oGMc+uyXRXtJhzF8hmE7vRPwGb65lP1R3cD4bEiARBMZej0VLLItGGLvgF6ui2ozWBstvpHO4StvAq3EWjWuvbkQgkaLrkcCH1EZyGdqH3oRQ5N1D7KEdhmqPCgFLWMDfryrUkmG82ta+B2BWP5vhIIS4h+wEWRGXLYsJ3uUpYhf8zwo3IHGVeKY6eBOlYCyplR6QA6cOLDrosizDERQWKGorLH5X6QlBXt4Bmdvsoh/PzCnHDOrIuh2UzElitNWL0UpLquXNb1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by BN9PR11MB5337.namprd11.prod.outlook.com (2603:10b6:408:136::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.37; Tue, 12 Sep
 2023 13:19:22 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924%4]) with mapi id 15.20.6768.029; Tue, 12 Sep 2023
 13:19:21 +0000
Date:   Tue, 12 Sep 2023 21:19:11 +0800
From:   Oliver Sang <oliver.sang@intel.com>
To:     Chuck Lever III <chuck.lever@oracle.com>
CC:     "oe-lkp@lists.linux.dev" <oe-lkp@lists.linux.dev>,
        kernel test robot <lkp@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        "ying.huang@intel.com" <ying.huang@intel.com>,
        "feng.tang@intel.com" <feng.tang@intel.com>,
        "fengwei.yin@intel.com" <fengwei.yin@intel.com>,
        <oliver.sang@intel.com>
Subject: Re: [linus:master] [shmem]  a2e459555c:  aim9.disk_src.ops_per_sec
 -19.0% regression
Message-ID: <ZQBlT7NYfHldWs0t@xsang-OptiPlex-9020>
References: <202309081306.3ecb3734-oliver.sang@intel.com>
 <C85F44FD-BC7D-421B-9585-C5FDFAEA9400@oracle.com>
 <ZP++GV9WURg1GhoY@xsang-OptiPlex-9020>
 <84984801-F885-4739-B4B3-DE8DE4ABE378@oracle.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <84984801-F885-4739-B4B3-DE8DE4ABE378@oracle.com>
X-ClientProxiedBy: SG2PR06CA0202.apcprd06.prod.outlook.com (2603:1096:4:1::34)
 To PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|BN9PR11MB5337:EE_
X-MS-Office365-Filtering-Correlation-Id: 70bfd686-a8e5-4020-2f60-08dbb392e083
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zj9ZuQc7s8+cVRwB9bO4OzrtlUT4fksY0ZYhjnFw0ri4ffbK6VeLScIrNnPXkN8qVosajkPVyDn5hemC818mS0d4Ka8RGyJ3vtyIifYIcSiEm/6kAi5nJ/vWorZfsFQVeTZVvOKRfhJlZDaPdEZT9lAV5OFR30Li/MX+j7rRUXvoooRNV3H9uDzuIBEu3O27dhMvVHdZmGT2RqGCSv49RhwMYprBYIwEo4cT1+AXI3smtV8vUzYmR13yVcOPj+2JalgYX6kNz7yjAjiJz/rCptZjxM03I9ylJIPgy4IFqHzEnaJmpIsPHRJIhuFQnZHz2MSS94KD+dGGGnk+fCgEDC2/4AhE/fbqI9k7fmbFL+oWMh0ebnKbdPlxFWhvTX4RVXhAMsWXLP/wzdXKJDLOR7sJhml5I9jRFWis+/p4Or38Xv8TsRClbW//V3KvhKb5z52E2ry43OqoTG1N58//aBw55wfYoANp4RqkXITRYZHswtaoaz01KEzW/Gqb62MR4LUv3JcLPc01FAVHSQdw2C7T3Z42stfqtsmSeQ7lPpB3ACUkAn5EmLR2eladKITt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(366004)(396003)(376002)(346002)(39860400002)(451199024)(186009)(1800799009)(83380400001)(66946007)(54906003)(41300700001)(66556008)(6506007)(6486002)(107886003)(26005)(6666004)(82960400001)(8936002)(8676002)(66476007)(4326008)(44832011)(6916009)(316002)(5660300002)(478600001)(38100700002)(86362001)(4744005)(2906002)(33716001)(9686003)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CDwMRdzupi+fiJySiZPGx8x+fJBhdq+Ht0pfgy530W62NvNEwu0SmvWxaa7G?=
 =?us-ascii?Q?jsbbkUuN0MQzxL4R+x7kbKLMNA7Tgda6QoXeQE7OhUh3D2hGtDEz27kR/xne?=
 =?us-ascii?Q?T5LOn56tP0KHrRAE6/cu2LBCREjMEWFKN43E9s9R4DJvf89W3Fy4q1ohYmT/?=
 =?us-ascii?Q?mzQ7wtndeaCPwNn3tawkrwRoGaexxFTsnMnUHdYf9P3MTc+U4ny8SEj5djuk?=
 =?us-ascii?Q?22WKoIkl/tT76U95BDRbCeBYzhOhLeYAsyUyiDrMvhbXsmw7C2VGN5RmgeVw?=
 =?us-ascii?Q?lSNQdrnHuHNvu/9aSkQ1UKDfHGJ15mMYWqJBWzlawAwrzTvLFHainfkfwbph?=
 =?us-ascii?Q?ojaa7cb1JBPWkoqEesH2sB95YdhuyL1OYxkq6ES1xdkh2BbziVxJQhsmOyhz?=
 =?us-ascii?Q?Ge7Lic5EBcN9Zsb+pbcyAv1NvkHgByCBtMrBWCM2OLSrzk2KV3Am4eqzUS4y?=
 =?us-ascii?Q?bLJeq2t5p2JgEEHD5yx1+p1u+l34UVVi56jPHw5RC2WgIGJTAGQPcmoUdVeS?=
 =?us-ascii?Q?OWZDP3ArUQhgCcjtEVqLvc+LHpOv2M3thT58we4fTuc+Cm5O+3W5lksmbzWN?=
 =?us-ascii?Q?M3YBGFXJx3rPm0bFSSz9fSJlcMrRHwXdZiHnudniN1foiyvX7l5WtHNzUy0i?=
 =?us-ascii?Q?v/+MPwBlXw1rW/sprHmr0+MVtUi+4unZKelMatSNLQ4ZhSmgmtfA9kCRcwpD?=
 =?us-ascii?Q?g81cP3wyCucMVAgCFtxr4DZCqUREpp5IPYg5axVHsZmtK8XMfFwnfEwEkUMD?=
 =?us-ascii?Q?QXtrPtirBPx3WS2fM09XqOjwYg4IFug1WVWrLLwZAAsGwMDM3xyfK6MjQNAI?=
 =?us-ascii?Q?96yfGvFGM8D0MzPYIjEzpScta9xXoorAvnFKpc/s0kRVQzN1CrH2DtepuokO?=
 =?us-ascii?Q?kKaSVaoxYWnV5doA7aC0AZmn0yDf848AlYovj0BENgqgiedXB4z9bhk7iZsk?=
 =?us-ascii?Q?3+qYNqVGYfPCbj+uLQMxIHqcp3AhRJIf2PTuTGbSCDPqczgTnN5cso5CL10+?=
 =?us-ascii?Q?5F3nyziHQPT4UCv667mBbqA2e7BHwGsPFnjoucEh9whEIKKVvvUGN3/WwJ22?=
 =?us-ascii?Q?hPuwjYPVIhj2D2onuWYey+mMqihR3wm4lOoC4XHsg1qGrvQEVV5pSw4WnfzN?=
 =?us-ascii?Q?uOvCekB7RrV3Y+4eoS8207Y5l8K9WlOozHO3XrMtlOaSCeqlTPvobfb6fXpv?=
 =?us-ascii?Q?kjnzDQoc8kYmqh0PFV2WbUSUzt66axNf+RpsgtYpt398s60G8Hhscqpm2iFY?=
 =?us-ascii?Q?6fhQW2j4kfUSEvY9zrQ8l+qFX8CzKVT6tJtNQZ+lXybc0AVuOUayzJZMSuC+?=
 =?us-ascii?Q?mlGkvNyeaoUhHRQVY3Dbhsks+MZadwkZcnyHwVMXhR5+GgtBA1rmZIXkjJlj?=
 =?us-ascii?Q?XW1YrR2Tw9PrgE0Db7qAC9vpnX4U19A93ginfkjuYqcn6UWrdYhucHl6ItAG?=
 =?us-ascii?Q?nsb/AoIyRiORm0q+u8itfpWERM9in5y+F39nA/74qCwoRR5tekja2bY3pi/I?=
 =?us-ascii?Q?R5kzId2IFxn3Lnjhly17BAV1XnMs1dMpMJeo/lI6WGIAXxxUQGhuzGpOf94M?=
 =?us-ascii?Q?TUDRf1GPFvbyRCCWDJo/0zaKbUi6YjY5VfDFQzg6VLmR++QxgKM/ypEjPhXG?=
 =?us-ascii?Q?CQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 70bfd686-a8e5-4020-2f60-08dbb392e083
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 13:19:21.7624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6RDXvZpbCAPtaSoELA+SI3t1C0NMg+bzFQfWwhwYO5uG9yJjYBBgiBTLXC8RCfsk3eJTK/+Y4GX5NfAOVuFdcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5337
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi, Chuck Lever,

On Tue, Sep 12, 2023 at 01:01:29PM +0000, Chuck Lever III wrote:
> 
> 
> > in our tests, the regression still exists.
> 
> Thanks for clarifying. I wondered about that, of course only just
> after clicking "Send".
> 
> 
> >> But, I'm still in a position where I can't run this test,
> >> and the results don't really indicate where the problem
> >> is. So I can't possibly address this issue.
> >> 
> >> Any suggestions, advice, or help would be appreciated.
> > 
> > if you have further fix patch, could you let us know? I will test it.
> 
> Well that's the problem. Since I can't run the reproducer, there's
> nothing I can do to troubleshoot the problem myself.
> 
> Is there any hope in getting this reproducer to run on Fedora?

sorry about this, maybe it's hard for us to support Fedora in a short time.

BTW, we are investigating this regression now, hope that we can update you
later. Thanks

> 
> 
> --
> Chuck Lever
> 
> 
