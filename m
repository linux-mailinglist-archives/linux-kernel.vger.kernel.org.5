Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C451B767937
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 01:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235703AbjG1X7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 19:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235752AbjG1X7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 19:59:02 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A40D61BD6;
        Fri, 28 Jul 2023 16:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690588741; x=1722124741;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=wtVhkhhx5qM5lQGZVizv5DezSpdB2aNQ+xFt+PnMcBY=;
  b=WV4AOR4LHuW1ZvFSrhMZUjPzxV8ePUHGxFuxf0L41YaT4xt/9ndlnbaQ
   i1DXoMuBMPkk5Yl1dX22+IFE7Kj1yo3iP3e+4sZ9vgLAQ3jAVhYqGBiMr
   ef2DZ4V2a/Y0q7DTYg/+5u8wl2atbg6gn755kL+e0Mb55vTXs/Ii7dy/F
   e022IO8CUgPUMA6aCqS42qBEzaXu1FbHPyNvUBD0j6bww/fYEd0muFMLp
   kVVxSI3I2J+slkSMaIvwQ7qySr6no1KGgB6O/ibuWMlLAVb4avWnmhNCl
   HgEN9LQVA6WvEgO15WuOyI8xXCgfa1IBRKcSTP+eHTpmgANHfIjrhqQJ2
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10785"; a="367591147"
X-IronPort-AV: E=Sophos;i="6.01,238,1684825200"; 
   d="scan'208";a="367591147"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2023 16:58:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10785"; a="793080826"
X-IronPort-AV: E=Sophos;i="6.01,238,1684825200"; 
   d="scan'208";a="793080826"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga008.fm.intel.com with ESMTP; 28 Jul 2023 16:58:48 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 28 Jul 2023 16:58:48 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 28 Jul 2023 16:58:48 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 28 Jul 2023 16:58:48 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 28 Jul 2023 16:58:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SHkYWx6B4qKazce1OI7Ux6IEHzhPVsiGUM95R61ynJK8mGehoYkiKBdm6Aw7ThAVhZQ0JfirHEilsrrJJY8Z59isXuDCnsKI8+EnnS8iJSzumurD1ghD18BGs9SHECIbVBSZJRC+2L9/PHqo6gEi5CyulgBIOEf5q6QIWjT7AiBkE+N8fTDGovsnbTYUco3xTaj7gEpLT1ynbDm4Vhk8V1W8Oy2iQMA6u9gLlrAPJ+6NMFP5bNm6xqGW8GVxHdcNMfWV9g2/pHnnwHVeAP7g9z/TPIDYCSt9XKeZLDJvskRT8qGdwjWOYGkHGtCp2A5sfwZMx4mHgED8Pml5yYzZNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xK5s1kCf4Qn+HeP08q4wl1dWD3LGvJsZjxejTltCRiA=;
 b=kclq5hFibOeykArOdk0nZMNpz2CuJKMHdD64GRQgei/7ZVW3H/04xXzpJ2Khz8BXLpQxiAOCUjR09AecNVzxnvgao1cuQRNUU8J0inwLiN56qD86uTk19Hm/6r27bTHz2uHNdTNRRAIVI2s49/MWpXzMkf/adNuKrbZFU/DIUqbS98lQj1utNokpTsFatEyriIQWdIi0bsC5J0S07BdoahjZ1MDgYXo2JzeyQKKb9YodM4Cfeu3N96ZmDesry2MrXK1pt7EBiZM1FLOA7APLiczLkyW6YLxWgX6yd+fejN6VJ6VVrJfGxDi+p+afSFS6TAWfBtT1fd4sheUfdR3dhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA1PR11MB7040.namprd11.prod.outlook.com (2603:10b6:806:2b7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 23:58:44 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::4556:2d4e:a29c:3712]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::4556:2d4e:a29c:3712%4]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 23:58:44 +0000
Date:   Fri, 28 Jul 2023 16:58:39 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Ira Weiny <ira.weiny@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Dan Williams" <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Ira Weiny <ira.weiny@intel.com>
Subject: RE: [PATCH] cxl/memdev: Avoid mailbox functionality on device memory
 CXL devices
Message-ID: <64c4562fb7531_a88b29481@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230728-cxl-fix-devmemdev-v1-1-dbd3269b3295@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230728-cxl-fix-devmemdev-v1-1-dbd3269b3295@intel.com>
X-ClientProxiedBy: MW4PR04CA0035.namprd04.prod.outlook.com
 (2603:10b6:303:6a::10) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA1PR11MB7040:EE_
X-MS-Office365-Filtering-Correlation-Id: c2539ebb-e49c-484d-c92f-08db8fc692f1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7t9+SmCswj4toeaQ6c35LvpwU//r9iTt5zCqVrXeNBrcXi970FCvgVUYFZBQGGCOHFh2wSNwvewKzHKLbGpKf5yGL+R5n4BTJs6f7gkJBPrE2QOV9w3+Ce90s24eFH5lOSFGYvmT3uIH1BqNp84yUtCmmd/D+L92Q3F67kZmy/VNyFlmPTBk9fat9m3QLkQkxPNSgAIH/tSwE4I9h6EHCR/TAmevjW07wR9xRADi5S+xxGLJKcYyGRgUQlr2kdBSfxuHtUJnO19s/nqSDQT9sFpyNpZSTM763BzqhTATnvt2U2+cbAmmVOD4n2t3bYJepVSSBibrv0TJChWPsSb1pkPcu0zPPD9OIpxQnQ6zM9eKOWUhX1+dRcitMPL01X6m3v29IpL9w5quWjhk5kfROAPP6+Iagx3hlEOfth2iN8yz5qPbMqCzpReFpGuVAWLoDo8oplg+24wxFQ72MzBmwzBVU4xU1BC1sYPiAexOtO50ZH60tRw0ZVIbswUYjUJKfBCj6tXb+wP1uMt8pFouLc6LG11XlERo+OoIkmS6r/6SEEWPmQYDvlPfebS7pjvL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(39860400002)(366004)(346002)(376002)(451199021)(6666004)(478600001)(82960400001)(6486002)(83380400001)(6512007)(9686003)(107886003)(26005)(6506007)(38100700002)(66946007)(66476007)(66556008)(4326008)(110136005)(186003)(15650500001)(8676002)(316002)(8936002)(2906002)(41300700001)(86362001)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tXR5hUOFJTsBfNR3AA13wQc1vxRyFNLynNvl0ncIKHltY2HQdj6a+NJoEnSX?=
 =?us-ascii?Q?T3K3a/uHHpfLbHrp9YTFODwg17Gmpt0GhxIJv1bs+S8oeGeZvRXajnrlhJo5?=
 =?us-ascii?Q?nmFuTOt2fCVFM6KEOI7iMz+n0izrrluFE9V8Rx6DpHJl2SdsIQZ4H+Cg9i+x?=
 =?us-ascii?Q?6h3P2tH7K9QiCJ/Bd+YyPx4SSDLo7egq/itKJI4yXdSVhX3eht1g7fx70oc1?=
 =?us-ascii?Q?sI+LOp+cOoEoobK5pYom6j/+o+cOQxIFGOfJ65X+ELMpNQUyGnqqledkTNTJ?=
 =?us-ascii?Q?mGWAJOQyr+CORDzAm4vwAPAUBONigpd45KpuPGxpOAV4W68heePjlOdVbpWM?=
 =?us-ascii?Q?9HBl4QZMcW30BOWX0mZKPMyt+dhmw9v1USNfRd8+ZE2XEchG85a/rNDBI8eM?=
 =?us-ascii?Q?HmL/ileN4xsuzicUWNJE62C9Ic6HDQWImiJwSDIDzgiN4yBQZ5NZoJZ+bfyI?=
 =?us-ascii?Q?vZTUlkQDgFq9NtIWcLcLTTF9lZjk/b8eMS0pPyZc/BK/Eb1r6rIOuqA6q21q?=
 =?us-ascii?Q?5P+W/bPCTZbTiMVBCBC8vq/Np9idlNkkCrrAB62a8T+z1RlRH4XM9hgv0vZ2?=
 =?us-ascii?Q?NynN7xWH5Y/BvG7Q7sfFiPxFbMQnVnEYJSZjQ73/UHm9gg79LbssmMwDYNOf?=
 =?us-ascii?Q?QdtMKd+Ws//SaokLpl/nrHD4R91o8ov7pgyMpV6rdF1KOqbikvy0hqpaDGTb?=
 =?us-ascii?Q?F57NH94YWNVu4iJ/ih48tzNOSrFRbNJO2WttlmLudv1hpftQg4pKNTNIiSwC?=
 =?us-ascii?Q?aAdz0hepYQJkewe+teC0jWHQJPEGw/aBsDHVezFAucscbMzgnz8Wqy3PcERZ?=
 =?us-ascii?Q?33gAgA8EopKPCjr3HbWerVBBxW09jdP5/3A5iszeTnqXY+lsE6K2I/DTdJ0m?=
 =?us-ascii?Q?7YzHvMRJC0HCvgaRqpTjPgo3TRaQc91vsIROtBHpiKKCES1W3xI2A8m5WWWA?=
 =?us-ascii?Q?gR3BPRK1lCaZRnrwhA79lcelMZxc8REEsJcPiFIjXn0jYbhZgiM7g8vMwdzH?=
 =?us-ascii?Q?VMzxFsCxoxiFlbpjoChxd0eUWOAv5xGbXafhHK3S0hHpdD1asEaAuFUj+c9p?=
 =?us-ascii?Q?3NLTbrxC2qruibZa3rpWTcXtZk9HrEkDIuJp5jFB3gzBQ++Kf8zHL94AU/fx?=
 =?us-ascii?Q?+OctAUUOaE/ZbZu0haL9xerQHfxMI29d7Vx6bF4bPjSSLOIa+noQ+TsVC55i?=
 =?us-ascii?Q?Nacw/qyXEAOFnR1S9shIuQaonPgaq1gFTOdcK4K6JIbBZtKysmEEuQ8z5QK3?=
 =?us-ascii?Q?0yiqeKXADnG7anvYVjm9vqXLurU6f3izS36vmiX5mvHY7DPYn1jWFz2Sk7DZ?=
 =?us-ascii?Q?7na1GKuGYSu3U3QkIyqDJ1yjSI8KW+lCeAYyGPX/yHkDI6sD9IkwuScyaUUd?=
 =?us-ascii?Q?hnOrGalYFOW+3s058SUoEiZSZi/knY29Z+iASP7+gOeoAgykXgPuKpsB9Ffz?=
 =?us-ascii?Q?o33n9TAqeTCuXVlpAZsy+kPdbWHAwB4SHb0/FarOYZ+GlYog3UYOhGh77Ldk?=
 =?us-ascii?Q?vsRkgw7+DmnNQecB4s3MGRFvE4MZ6+aqP+SWcYMBQZwKd5Y/3UoUAgs+6adR?=
 =?us-ascii?Q?KkOrzJheTzVr8QB+SNiErQcxRCgITgJQ/7hxm7Yvu0Fi55IbK7o482xCbgYJ?=
 =?us-ascii?Q?DQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c2539ebb-e49c-484d-c92f-08db8fc692f1
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 23:58:43.8219
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DVmcto8WfCAmZ0R3OEkxFm+ZDOj3pkE4WkJI14o7YVEdw+ohvuZLAyXJP1BX3P6kfmdGVIfiSiYiPYIS1L8Gnp57ye/0FniEYPO8WxlNePs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7040
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ira Weiny wrote:
> Using the proposed type-2 cxl-test device[1] the following
> splat was observed:
> 
>   BUG: kernel NULL pointer dereference, address: 0000000000000278
>   [...]
>   RIP: 0010:devm_cxl_add_memdev+0x1de/0x2c0 [cxl_core]

It would be useful to decode this to a line number, the rest of this
call trace is not adding much.

>   [...]
>   Call Trace:
>    <TASK>
>    ? __die+0x1f/0x70
>    ? page_fault_oops+0x149/0x420
>    ? fixup_exception+0x22/0x310
>    ? kernelmode_fixup_or_oops+0x84/0x110
>    ? exc_page_fault+0x6d/0x150
>    ? asm_exc_page_fault+0x22/0x30
>    ? devm_cxl_add_memdev+0x1de/0x2c0 [cxl_core]
>    cxl_mock_mem_probe+0x632/0x870 [cxl_mock_mem]
>    platform_probe+0x40/0x90
>    really_probe+0x19e/0x3e0
>    ? __pfx___driver_attach+0x10/0x10
>    __driver_probe_device+0x78/0x160
>    driver_probe_device+0x1f/0x90
>    __driver_attach+0xce/0x1c0
>    bus_for_each_dev+0x63/0xa0
>    bus_add_driver+0x112/0x210
>    driver_register+0x55/0x100
>    ? __pfx_cxl_mock_mem_driver_init+0x10/0x10 [cxl_mock_mem]
>    [...]
> 
> Commit f6b8ab32e3ec made the mailbox functionality optional.  However,
> some mailbox functionality was merged after that patch.  Therefore some
> mailbox functionality can be accessed on a device which did not set up
> the mailbox.

cxl_memdev_security_init() definitely needs to move out of
devm_cxl_add_memdev() and after that I do not think @mds NULL checks
need to be sprinkled everywhere. In other words something is wrong at a
higher level if we get into some of these helper functions without the
memory device state.

So definitely this uncovered a problem where cxl_memdev_security_init()
needs to move, but the rest of the mds NULL checks need clear
reproduction scenarios and expect most of them are precluded higher in
the call stack.
