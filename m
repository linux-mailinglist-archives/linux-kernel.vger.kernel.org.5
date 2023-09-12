Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D2A779D43C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 17:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236106AbjILPCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 11:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjILPCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 11:02:51 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C9E115;
        Tue, 12 Sep 2023 08:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694530967; x=1726066967;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=hd6bqfbrmiaA0ZOm472+GnzYDGdfzyxOIjlzMOdEjJw=;
  b=OOWKpgwMCzNEnJMPDyRZ2U+67yFXvfo62fHt5qddWbka3FfKUnePDaMt
   HCaG/dR9ijjj+dVnRPcHmZKssEOG3/qQqXzCyFRymdpH6W3B75ZqbPjId
   lYGyys45kME0K8TFr7a7Mm7DFkdus84WlU8cgxerBUmSdaOPfJgcVsFS/
   ORk1RRjnxNI6iagEZ1sMPiNWdV15XWpUzIGbJHjemsuT47PQYR3llpWb5
   on2Q0Rjy4iJf/7NYWqw4LiOqDksNCY8zUfskSbnbo7TNPVUgITv7bZfLn
   CqpGwV3Gw2/33I+l5C0QzFJXs5VhdisFw11/6SC5VFwR4rDiwISKujDds
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="464771531"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="464771531"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 08:01:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="737148399"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="737148399"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Sep 2023 08:01:06 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 12 Sep 2023 08:01:05 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 12 Sep 2023 08:01:05 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 12 Sep 2023 08:01:05 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.43) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 12 Sep 2023 08:01:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a+WkwD4X+/77mU0DznZ8wnwIOvNP65PXGfsBjwk8/hAKXrPQobUsqYrZz72ubXC1ebmTZIpDJDjq2Yxo6qT+ctBH8nRLjy9YEgK1y945ZkmNUhdSb45ZKSNKga3Q2s1xiiTasAJbu5OjPUcDLghWSHhcxW3IEcgmE7oVE1rgejMv9q0TcA8vouJRO0wdtinSbviYEsRtjTR/OM9r2h9h2emGQ9Nqu0ZgXMqKod8xY5KI0rrzf94Gr4hH288G2i4j/WiGPLwjvGeWhiGH5miuZZ1ZLpSPW+sJsETX72v/+KerxHSGn6gOtSZW//MCN4MBvpVUC76iZqCuqAq/3ffBVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3K7T1tOJ4qufJizDeN5MFBBCeOYtNAdjFd7m3jhfo1c=;
 b=iwktUPOYNZh68KD7r/6vwM30Z4+sAH+twN6OTzB2m8nuzJcAABhyV7fyVpykJaec/87Xltf+lXbloiuToRJbqdG1rwkDIC4BJDonIAiHynJn7AzLaW8rSM8vzNk/zthINHamatqTgekUgxn9e9m1oz/T3gAbehBsjuMHOLypf1cyS/2GdtcvSf3maIfGU55oTzxWtL2F56VGXfJ+qOuuCbPcojVe6WZUhHaG/215fpYJj9CAkqAZtWBJHPaYoJO6Yx0Ax4LhCRgugru/Rfd6h6JebEoRLnvPe8cfimHAAIJolpI/r9N7quttqX/NAdp8qxHBT3L3DLsFuRybUYMFWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by PH7PR11MB8479.namprd11.prod.outlook.com (2603:10b6:510:30c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35; Tue, 12 Sep
 2023 15:01:03 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::d9d9:1535:1180:603a]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::d9d9:1535:1180:603a%2]) with mapi id 15.20.6768.029; Tue, 12 Sep 2023
 15:01:02 +0000
Date:   Tue, 12 Sep 2023 23:00:51 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Saranya Gopal <saranya.gopal@intel.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: typec: ucsi: Release debugfs only if it has been
 allocated
Message-ID: <ZQB9Izz0t8RcGHuX@chenyu5-mobl2.ccr.corp.intel.com>
References: <20230911162706.2856910-1-yu.c.chen@intel.com>
 <2023091112-elevation-immature-8f9f@gregkh>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2023091112-elevation-immature-8f9f@gregkh>
X-ClientProxiedBy: SI2PR01CA0001.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::13) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|PH7PR11MB8479:EE_
X-MS-Office365-Filtering-Correlation-Id: 9baedbdf-525c-4fac-eef3-08dbb3a114e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QrFVZb1UEx3QYT4xGGCDyKnsxE74q+K4iatbnKNpyD3NA1hkEltReVFIhk637n/S7f4T0tph+EIoy03ry53ajd86ssuuZ1p5L3ULEoer70B4J8fiiMt1MWf144CQLLfIpSofg6aVtDw7AdDk+kQ+icfZIDDmbZ+VWhnL93zsUgS+asimHqsmRWexBvUZsifXzV7CDGsJizHER8SIHLgwZ6hCEZk6Y6JxMR+hAA539kP97Isl6cLL19f3fyefv6V1oc9xtVPppXADsFptLwMKibnDHhteavOOiXBlikIQZGPLSQvud8742YaA6oJd4QKQYlzrUz/rwfFkPAAxRZT1ZEXKPvkZL4ONc1GMu0EKsAgOkZrYvfIsH/TuQOgA7Q4npQkXT6qSdHNygPE6W9+ghHLZqIXwlXUbgsWKNqBlSbI+xLivY4oQaupAVS3HhNPo3B3RY4CUGipkriVRgPTEw2ooD5CRkJoNbC8aKHK3LgZsabfqljsImOp6qihJ+qwt6o1U0sEU5Z5SqjCXupPYcC4oFm32j4RlG8PrDKP1urI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(366004)(396003)(39860400002)(1800799009)(186009)(451199024)(2906002)(38100700002)(86362001)(82960400001)(41300700001)(316002)(6512007)(6486002)(6506007)(6916009)(54906003)(66556008)(66946007)(66476007)(53546011)(8676002)(4326008)(478600001)(966005)(8936002)(6666004)(5660300002)(83380400001)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mTrK/MLXSV90BS48ZXrPLDO0hiO66JNOpjQiVrPZAfXjlUNoHQXt2zglIWPQ?=
 =?us-ascii?Q?p+er7Zaz0Ao5J/3EHQG48YK+a6HTs2FZFlRcrFjyucr9QItCEXUmt2iagXWl?=
 =?us-ascii?Q?QMy7awc+2gtWIFu1DB95qO8Fiaq7oO2D8pPOtF1Y0XDtublSLZEirDMPjEMv?=
 =?us-ascii?Q?OHd4WRpS4lZ1OXudMA9q6+FP1QOucdE9sigfKtA0HlAoqQcYPA+t07hFqv1Q?=
 =?us-ascii?Q?yR2WU+j9vmhWRodB0usJjCZoEwvMk1YbwQpfVN4oJp6pg68v8VocOBigAADf?=
 =?us-ascii?Q?v2EeEPuGuHGpLTlVCcRaDYRfdrH2spnO9x2UQLpkP4PrLSPM54OAcgNjF+fY?=
 =?us-ascii?Q?7c37+eFCUDRPkI1cXkgw7w0W+6PvmA6j9cJtLkhtEmqcfdJ5iVdZexjm4tQB?=
 =?us-ascii?Q?LIAHTNB93PG3BbL9I7RJ0VWtUhRFm79Qk9VgQLl6jZY0jC8JEBAkh2S8tXa4?=
 =?us-ascii?Q?zqZcs9JzKf1blj69XTzOUsMQg7PCDDWbQTGpUpr52BTSx6t8kdV6Ci1Sm90Z?=
 =?us-ascii?Q?AFPfznSZyiSpzP2g+YEX8kvgX7SUEraI11XkqXEPiNm/5vSUJQNLQ/d67LFs?=
 =?us-ascii?Q?0Su5OX6T+E3Z6Dm7oQHIOPvUhEo8wsLksfFGZ6FoufRSsnuiGmt5sSeYe8Lt?=
 =?us-ascii?Q?PgXVN6ziPBYxGWWNTjBmVCeWpxY1AmRZ05LdecVq/HJTuakBYrh2yfMo/6+t?=
 =?us-ascii?Q?/90e0kl/RlKHeVYNNTudM5uHiHzhZ1dp2RDlU1ha9Vu+uvz0FE9L6G28aERW?=
 =?us-ascii?Q?3bZM5rmdo8rHClHl4ajUC3JgG5g3m6KRj4hIuLpJF0wcfLlS8TLVMmjiMAX0?=
 =?us-ascii?Q?l+nSAy4HCHBUMEU9YncYKjnU18QTiV8T16hfdlRYJKY4Thg+2XA1dLOgaEbS?=
 =?us-ascii?Q?xTKnKxiQWwoKc/HfaxF0CbtkkfUaIulZDctTGZDz1skSboc0GxIUwZC3aLS8?=
 =?us-ascii?Q?ziwr9EulDmzvg3TPMBa8KiKihtIBB47Vwd01R8iLuPdXQW6UyJ9RuhvlGITO?=
 =?us-ascii?Q?qqtObANrxy39O1OkuVtJI01Q+CUiCQAmZyASHgMIxBraQL0s1p3auXfM+vzm?=
 =?us-ascii?Q?1iZtmxRAm4JVokYG9uwI/XvZHFAR/1o3rA1uVX9MFnjXiRD7olw26E5wn2tv?=
 =?us-ascii?Q?cRnn0bjIE3IF5eOLo9ZrMBowB0x8BZDHBuG8mtQVANRa8SN0C8Ia9XLyYiNu?=
 =?us-ascii?Q?0fudG9v6R//7eSoGYkTRjX+m01Z45SOwZTkCxBBz8w8dpVRcIlgrlEUHMZoh?=
 =?us-ascii?Q?HoRJ1TNzP7Lq1jFLGeQ+Ftbbu2xlzwNnT24U7r7FBebCXJLGW4d9E3qB5G1n?=
 =?us-ascii?Q?r5MeTT/USdne2RyvtKe+PxwCnYGwacVClcnOJRDjCto5LaEex4cZHUd1b+vp?=
 =?us-ascii?Q?wwbaDb9SRZ7ReyicDbsW+3T8fZ/lXe2cwabsJwC+3JnqiKu/G81Umo51nUk7?=
 =?us-ascii?Q?P2rN9Y/kluiKTCYmepG7+QtBJM2lcv3OPQy2M1y0tgdvtgZvGaov0ALG8A7N?=
 =?us-ascii?Q?t8d5mh40aG9CbUg+3cE9kjqg7J+5d/nlf6hrB1uRIYgctGQ0o6hACQiIsSOE?=
 =?us-ascii?Q?QyZ4bNTRrCoe8KJdlLRZC9pyYbQg5VSWEGsZ4rYt?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9baedbdf-525c-4fac-eef3-08dbb3a114e4
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 15:01:02.6291
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MH+vdc+n3sOxzvB7UnCWSTK4u3rL4VzCQ0V8htN2fawo2Dom/9IQJiMTohEV0G+Vz/CQxes8qzjfZbp58kkNlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8479
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

thanks for your time,

On 2023-09-11 at 20:59:18 +0200, Greg Kroah-Hartman wrote:
> On Tue, Sep 12, 2023 at 12:27:06AM +0800, Chen Yu wrote:
> > The following NULL pointer exception was found during boot up:
> > 
> >  calling  ucsi_acpi_platform_driver_init+0x0/0xff0 [ucsi_acpi] @ 394
> >  initcall mac_hid_init+0x0/0xff0 [mac_hid] returned 0 after 5 usecs
> >  BUG: kernel NULL pointer dereference, address: 0000000000000020
> >  Call Trace:
> >   ? ucsi_debugfs_unregister+0x15/0x30 [typec_ucsi]
> >   ucsi_destroy+0x17/0x30 [typec_ucsi]
> >   ucsi_acpi_probe+0x1d5/0x230 [ucsi_acpi]
> > 
> > It is possible that ucsi_acpi_probe() fails to install the notifier,
> > and calls ucsi_destroy() to release the resource. However at that
> > moment the debugfs has not been registered yet, thus the NULL pointer
> > exception is triggered. Add the check for debugfs pointer.
> > 
> > Fixes: Commit df0383ffad64 ("usb: typec: ucsi: Add debugfs for ucsi commands")
> 
> Incorrect format :(
>

Ah, the 'Commit' was incorrectly added.

> > Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> > ---
> >  drivers/usb/typec/ucsi/debugfs.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/usb/typec/ucsi/debugfs.c b/drivers/usb/typec/ucsi/debugfs.c
> > index 0c7bf88d4a7f..55533dc3d539 100644
> > --- a/drivers/usb/typec/ucsi/debugfs.c
> > +++ b/drivers/usb/typec/ucsi/debugfs.c
> > @@ -84,7 +84,8 @@ void ucsi_debugfs_register(struct ucsi *ucsi)
> >  
> >  void ucsi_debugfs_unregister(struct ucsi *ucsi)
> >  {
> > -	debugfs_remove_recursive(ucsi->debugfs->dentry);
> > +	if (ucsi->debugfs)
> > +		debugfs_remove_recursive(ucsi->debugfs->dentry);
> >  	kfree(ucsi->debugfs);
> >  }
> 
> What's wrong with this patch instead:
> 	https://lore.kernel.org/all/20230906084842.1922052-1-heikki.krogerus@linux.intel.com/
>

Thanks for this link, I'll patch my kernel using above version.

thanks,
Chenyu
