Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1DC7DFBFF
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 22:31:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbjKBVba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 17:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjKBVb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 17:31:28 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBCC1198;
        Thu,  2 Nov 2023 14:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698960683; x=1730496683;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=MZNzRKwHOo6UKSf+NUH+JAli76cBYlg9qudXn6IDbMM=;
  b=GXcwOEwTdJIxcxBpZhrvssC403PXBDBX3IVFbgJOL9yzgv1bzf+zt17h
   xe6pMiQvKH2lu+ILt28hvClsquNWWUrKPBwZeKbqB+slu3QE81FJGaGMl
   DCbxBQFf/FXt9oKTUakhcXrewVOnzRqRweozf29QWUrZaqtLmg/Dhdb3a
   6wEJMA2otrOI8VbeYzYKDzD2CfJKXTIGD2UThYEnRIas4V67oR31JPJ+Q
   ex59YakEzRtT1hMX5WGSNVSFPMjMyyaeEMWB1u4+Dt4ZAAacfqpmI6FeE
   Bmk9ZqlaZFX5Hc5x3SWCpP0+4qDMtwjHJqWp6SSO25fdbC+Zp2YADm2YY
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="10355134"
X-IronPort-AV: E=Sophos;i="6.03,272,1694761200"; 
   d="scan'208";a="10355134"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 14:31:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="754931857"
X-IronPort-AV: E=Sophos;i="6.03,272,1694761200"; 
   d="scan'208";a="754931857"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Nov 2023 14:31:06 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 2 Nov 2023 14:31:06 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 2 Nov 2023 14:31:06 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 2 Nov 2023 14:31:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ll75DNVEjBMggT08f/aPDcKwSTIJiD7zGpVWnZ4s3YyVoCJOHaBo4LvucGQG+SIEH3I6P4aAblO+wAsYiqm+LW1wtQazqTmoj61ZSKrSHuwOUNmZBciK9+IlRWxkEAL0Kg9WtSD3wY1A+9vBSVWjU8qaNk5pk2s61q9izJYUXY2pfuxGaygVho7r1yrdbKAhjO5XtuJ40u1yHpv9JGAm4HUZEl7tABpI5tFT2/3KN55QI6KNUCj0wrt5WJQlNtYmMbr7d8rlQ6Wwdw9GKsNJLf7GSGrd2VWWUVWEdMmceQysh6D+h48DsPYF9AjDppN1idpEwPiped0XhKkaNwEfEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6n6GHybUgUGYRBMzI9vHRtKs3fxA+EDz/NXigGvkcmo=;
 b=B6OvEQcWbtu0uiz3DP+48y5TvJltsGmvELWqwUKSqIU8hsIHaxYOMWIbGcT0QeOIipJt7caOvGXPbHghOTFjNyy+NtviF08q4bx2pGGtMAk5igMeif3SjYPzdVTuvlGENxNaVxksyad2tWJBCjZI0EXIG+BTjUYhA6lGpfn/e5Mgk1EUzMrUUHCPbK7CjAPOMUOP3bDRyb5t3C6mWbaUVlTBXSbsFAse76kOss78eFZ+W4t6Jm7cdykN2SIXrpwsRa/P87EPbEE6Ct5golkMIGCOcK9Te/DELTJynuRZsFFwhwW3H8efakZdcpMZeCCKigTxBwhRo0Zik6zZWD/fng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB6650.namprd11.prod.outlook.com (2603:10b6:510:1a8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Thu, 2 Nov
 2023 21:31:04 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::e75f:ec47:9be1:e9e4]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::e75f:ec47:9be1:e9e4%4]) with mapi id 15.20.6933.026; Thu, 2 Nov 2023
 21:31:03 +0000
Date:   Thu, 2 Nov 2023 14:31:00 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Terry Bowman <terry.bowman@amd.com>
CC:     <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <bwidawsk@kernel.org>, <dan.j.williams@intel.com>,
        <dave.jiang@intel.com>, <Jonathan.Cameron@huawei.com>,
        <linux-cxl@vger.kernel.org>,
        <Smita.KoralahalliChannabasappa@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cxl/pci: Change CXL AER support check to use native AER
Message-ID: <65441514c8494_244c8f294af@dwillia2-xfh.jf.intel.com.notmuch>
References: <20231102155232.1421261-1-terry.bowman@amd.com>
 <ZUQEa1q/R2KBF/3W@aschofie-mobl2>
 <65441103b3b1b_44d229485@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <65441103b3b1b_44d229485@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: MW4PR03CA0111.namprd03.prod.outlook.com
 (2603:10b6:303:b7::26) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB6650:EE_
X-MS-Office365-Filtering-Correlation-Id: ba81b0ec-968b-4121-b932-08dbdbeb040b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bgiEOmPEFihYazwm/RKuJfkcleHzDMfrK6iGOW8YgynFT2eO0WKPHBdbcpNNXXwgZpN5FBx1izyCTVBL6vZavC3pCOQh74l+9jua9PcLS0GrEkCdhzP3DtYHcBdk/qA7AZGscnui088evuoFbtRgbrwutTPx1uCLYaWbhalD7USI15lYzwJ8nOf4bXvtsxjBxRzY/tsRVNC5qrxSAwaywS9Wt/uzHBKVVBbuF+P2a1Fg8CDgtHDqrNrzmHEtwoTbBznBZp7fKWCMnL2w6/itbq63RZly0y/V1N1eWywBeg/fSqyHhAY7tyVeB2j2XJA9tOqEmaDhYhpDtNxgmMpvygFzh0hE9qIJpqc7nv7vsRrt4kZduDtmvRf+lATyFykBwJbR+KuqSHd5slfRYjzFff9F6fmnVok1uZQobyekAnIJ/P+MsWHgsF4CDul6qc4XCjuoMW621p2BiTne4A3/bXnHbZsX81/r1NNinDxqu7BZ2CAf90sPuJd1xVUo29T33chWwmHhWJXaOcEjPDEq6l/h95/dlatn3lgr3FjvABDkSg2GUVEhDwwtOgNRBqoY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(376002)(136003)(346002)(396003)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(6486002)(478600001)(38100700002)(6506007)(5660300002)(8936002)(26005)(110136005)(66556008)(82960400001)(66476007)(66946007)(8676002)(4326008)(83380400001)(2906002)(86362001)(316002)(41300700001)(9686003)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tndXmnwTJEtjTK+lUq6wpc1tsuFibVFi/YxLMKHfKmhLRfu80OVbtTopiYs/?=
 =?us-ascii?Q?sbzPgQ9zAsZDdUClojqW+hu1bdRBXfHNzHGzTWCvgIcK8PzxeGNg1BaAxkQL?=
 =?us-ascii?Q?h98+9lgfiU+wUSK7Yovqt5A5YJQYUdsvvTARkawly+AaVg3LU532GdIJSeAH?=
 =?us-ascii?Q?TaJXZeCoTDBpjfWrFSdNE/i/XgIhDZ1KuegjbOFCN4mtB6yjfBos1pbuuhLA?=
 =?us-ascii?Q?5fkoCa7t9JIalpBXEKWEZjcO5qbou4Ytp/wRuxYJCZegf4lD93ro2jyE9lcY?=
 =?us-ascii?Q?LeQUbSGi0JKFoNf0tLnhXtpQNpfMXoHAXU7/w0y3OBVfn1YU7tQVjHr8O6k1?=
 =?us-ascii?Q?Tx9YwkSRSr9dRQIcLtWEwRUZHYa5K9yIOTDT+p73cZTfQQ3O9V2BE12k8duA?=
 =?us-ascii?Q?kFJ7RH3nRcHbmO/cKN+HylQ8tP7l/JSFuqDdnl7Y20lUWgu2PwPRSSs6I7Kp?=
 =?us-ascii?Q?J7KD3PVCy7MrBbVewvOv3Jv5P0uYidAOyIsfcRc/6rCSY8YLHOtMm1w6FmzN?=
 =?us-ascii?Q?pkQsXqAMCRMr4lVPRSgs+WQfDHOuSPh8b7JV4g7bTpx5He67Dl5nq68EbVel?=
 =?us-ascii?Q?NTC8ZekY/C5u/95UysxMufxFGUzOSYgLyS3oZHfhtQp3ew37eb2mK6E7TMto?=
 =?us-ascii?Q?PqJ8r0jpf9OCXfs0Y/fCMLu69dMuZHPnSQMDAIxforo5ZXFrN3o2YMobZ7Xs?=
 =?us-ascii?Q?EOHUVfpj2HQp4ce8Y28609AUCGkIL1tmqhEMRpxHEt/zHjA6IOVcLu6mftWA?=
 =?us-ascii?Q?9bltB4f6E4/6OzE9B8b2b9vCDbspnVkbGesTam0CLMNhiILp1fdVtcBtQK5Y?=
 =?us-ascii?Q?9PSIHZWBw+QFXZI6X+SJMbSL0911w0OTq9imYf4w2CUXRe5vQyPzq6R0lc6X?=
 =?us-ascii?Q?hXTYxMbHr8OAZ41vyEl/SlJgxolyP2j+5UsQXIBJPEOia/VnNZab8wNO2hYl?=
 =?us-ascii?Q?o3iMnNUDBsjun627l8Yz1bLt6uz0lT+r2r1gHnDnqVCJ6lcArmdgVAOxBNwG?=
 =?us-ascii?Q?QLSXuqu9zyie4yRt9hXyomA+6VAcb5nm+Tng3LedVETkHLLgxwq1uecvt0XI?=
 =?us-ascii?Q?WnmJ9PBRO2K2wBt7v/WWpxWSQT5FefsVUJa0D5mClQXdyinwxPH4oSDpnhtA?=
 =?us-ascii?Q?1AJSb7WtaLHNWY28nGZeesPEuyFaO1H5xfJ/fG/h/J1mYKdp6LbNu3SPIalP?=
 =?us-ascii?Q?JruncNJ6OLFn0YTcH9xu9ALNCF57oCmOrmFTuCcHDvw3hpHTl7VKtyPxuXSn?=
 =?us-ascii?Q?HEL1MF9qPf8ny6PMDnRrGZo/jQxVfc0QQm8WyqFoKGeP+FPf48jeYKVtErTS?=
 =?us-ascii?Q?G2Ahg0QUSeQ/bbyVk9iuIkkZJxBLgMrPWTCj5m3ja4Ri5hFmprRYohTVLEBa?=
 =?us-ascii?Q?iz5jT6x9K2JTIeklOGX3qeuZHu5GAvr3oTUJGaCCtcFaVt3GWRFYd6GikF4e?=
 =?us-ascii?Q?PfHVMeq5Y21hVgTP4JOo60TxqDMB78LeZ3orIqDlbLr28xWCw2g1hsdVV+lY?=
 =?us-ascii?Q?swyWpOhKD8gslwMKW3mShBUR0Qgj9ZSqrJ1HD9RfHb8hPwrZ2SMkVLffn/mC?=
 =?us-ascii?Q?qbxB/6UN95Zp3oeR+nMBnxVp5FedVT2wL4FGA3/I10QCbbaIx7j1mk5H+FmM?=
 =?us-ascii?Q?ww=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ba81b0ec-968b-4121-b932-08dbdbeb040b
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 21:31:03.5926
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XC4aNXYq5VE6R862EmNPJNobv2gaKzbxk+IF8gh199VRgBDsgf6iNZcsme339G/TCdWlVb+tw9WstVSYqDCxcXAX8fqevHW2FzZKd72H8Uw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6650
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Williams wrote:
> Alison Schofield wrote:
> > On Thu, Nov 02, 2023 at 10:52:32AM -0500, Terry Bowman wrote:
> > > Native CXL protocol errors are delivered to the OS through AER
> > > reporting. The owner of AER owns CXL Protocol error management with
> > > respect to _OSC negotiation.[1] CXL device errors are handled by a
> > > separate interrupt with native control gated by _OSC control field
> > > 'CXL Memory Error Reporting Control'.
> > > 
> > > The CXL driver incorrectly checks for 'CXL Memory Error Reporting
> > > Control' before accessing AER registers and caching RCH downport
> > > AER registers. Replace the current check in these 2 cases with
> > > native AER checks.
> > 
> > Hi Terry,  Does this have a user visible impact? 
> 
> Saw this after I applied it. It is good feedback in general.
> 
> The reason I did not ask for this clarification was that this is fixing
> brand new code and was just using the wrong flag, so I had the context.
> A backporter will never need to make a judgement call about this patch.
> 
> The end user impact is that CXL protocol errors that could be handled by
> AER will not be handled if Linux failed to negotiate memory error
> handling. Memory errors are strictly related to memory-error-record
> events, not protocol errors.

However, to that point the "Fixes:" tag looks wrong, it should be:

f05fd10d138d cxl/pci: Add RCH downstream port AER register discovery
