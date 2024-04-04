Return-Path: <linux-kernel+bounces-132090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58D2B898F83
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 22:19:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C25A1C20EAB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 20:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D359134CF8;
	Thu,  4 Apr 2024 20:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d6pHfiNz"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D375134733;
	Thu,  4 Apr 2024 20:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712261943; cv=fail; b=TwiX3Hi9QuYWCxdNV94JJ2ZMUvSm8AeOs7TMSEvApEaRxNuCNOABo8LW+NaJhhSuAqEtJ5SXYTeheI8TpaRANHFtPp/AisaYs+9vmP6/wjvjeT5Vy5sv3VhPb4kCCwxge6+6CmNs1gK86j5lzxlRR1bUMB6BM+xootEASj4xz8g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712261943; c=relaxed/simple;
	bh=ahEc38m2+KVPL3W7hauIIb2dqUy3qH33BZlwg2mr3yE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CaGo6HI2ePhroOrmQPvV4BOG4GoG2XCJVnTCQXcOW/yxUb66+6gn9FjA8KgDeZaW5SoXC94YpLTAMhGhYXntG9w5Yqjw2b0krLcVF755wcYj11MVkyWHFUwynQpFNQ2xL15W/sWBbxycD71pz8gglNns4yWHB2triKeNyuilcGE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d6pHfiNz; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712261942; x=1743797942;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ahEc38m2+KVPL3W7hauIIb2dqUy3qH33BZlwg2mr3yE=;
  b=d6pHfiNzP1v+cE0sfwcR7hWCK8yVha4UFjpWcadxtBaJisBb2KkPhFnt
   klX+txHXpvTLbsKf98XXOZjhIxlIm3Kn1GuBRvk4syMJvKA5MfeY3BE8U
   jxMQMmmjM6j+wfhXXKb9zBKeiG9R9cNknBPjAuAid9jJ6zTWGh5rAxL/l
   toStmgu2YL6KVRGAWX1IvN2MSClM+Qm3OM7lTNUXvuul8E9XCnb/6T+H+
   TQbxeMRcnFelFs3IpuugRr/SoBQMbrlk7U96YH/+FPvwmiiZna+PmClln
   s+aOXgnuEyuPmpUKY9B0w8GndyxIDS9lKk5tfkBt6L/1GcH6GERQG17YQ
   Q==;
X-CSE-ConnectionGUID: CHI7wscxQ/KRiGAUNmd3eQ==
X-CSE-MsgGUID: Xf0GgCt7R0eLcl1XJTTmlg==
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="18183190"
X-IronPort-AV: E=Sophos;i="6.07,180,1708416000"; 
   d="scan'208";a="18183190"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 13:19:01 -0700
X-CSE-ConnectionGUID: iNdImBIaQCS9IRYGHzA4jw==
X-CSE-MsgGUID: ZVjec4lcQCeP2e8h2cMWKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,180,1708416000"; 
   d="scan'208";a="23387278"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Apr 2024 13:19:01 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 4 Apr 2024 13:19:00 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 4 Apr 2024 13:18:59 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 4 Apr 2024 13:18:59 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 4 Apr 2024 13:18:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jHZioR1xj9fR6KQNlnsS98+LCLdRcSIhb7WW4PPKc40xiP3w2poCdy9sRsdIcX3EhQry+YDvqjaebwhrrNS6aa6asJ7Z5PqeaId2SZMOj0cBpFTJTQUv9IZSpKXiv+PYDndUEy8nQS+BjSv6kfrVXuATuiPtG9GmjG3b/z5Ek7kNFYOgpxmSyVYjJJFb0rWVkMfJTAFKcjfU1kjd3tliz8VBU/wSVYXjV78uqYr6X6V/QeQi7bKyCBFtli4uRWJH8u+YGAx8ce3MQk8D2YlQdrpPvlYnoCDsn9TFWaEdhsEtsfMtlndyVHf862LYg6ZYftkOKbl8/Czu3urhAeWBdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uU5fVBG5swki0tTbs8wX0OZjrDEHIg7eEZan5S7JREo=;
 b=gfqk0LRZOtKlDncp/4pVmlUpqWEagYaac0e99r5eFd7FYyJCrlzVkAkRbV5oCVPiZyvCi0scLOGqR84ouCVl0N1ruZJsKIaX8Mj8C0BJgt3xywEXDw7/2aOmKzj+Mye80HenHM7CBm7iUUnuhLq1iG+jQn1eaqyzdPyBoS42FjT6IbwRVkpx0qXnyS4nx2p66UB+mtKxzsPgLHyYcTVfDtZepP1bVYgz7Y5LacPEQeowf7gU97j1m60B5YO3SFrUPys1uKx4RTm7mNWdq99lcWELCB0L4x8VzLfeH/KviRlsg/aTdQZu5NwY/DVvXCYHf1uNxKtkiVZ34fRPcNuFWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DM6PR11MB4643.namprd11.prod.outlook.com (2603:10b6:5:2a6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26; Thu, 4 Apr
 2024 20:18:57 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5c74:8206:b635:e10e]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5c74:8206:b635:e10e%7]) with mapi id 15.20.7452.019; Thu, 4 Apr 2024
 20:18:57 +0000
Date: Thu, 4 Apr 2024 13:18:50 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Ira Weiny
	<ira.weiny@intel.com>
CC: Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Kwangjin Ko
	<kwangjin.ko@sk.com>
Subject: Re: [PATCH] cxl/test: Enhance event testing
Message-ID: <660f0b2ab8484_e7f1629469@iweiny-mobl.notmuch>
References: <20240401-enhance-event-test-v1-1-6669a524ed38@intel.com>
 <20240403164145.00007bcd@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240403164145.00007bcd@Huawei.com>
X-ClientProxiedBy: SJ0PR03CA0211.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::6) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|DM6PR11MB4643:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6jlSIpATJHs8fYcVwaX6Lkj8bCRKem1QZEddSYjmxOUg4/YeqhdAj7aQZk96cc7l9b6ZH4KzuEa6veMjzs/eRsRIqMoPrG2QAfJgAd7rE3G+ir5MsAfpp198i7QEAU4axEhHBD6fp+2pMef9F5rbxY+RR0Cufi/rIX2KntXaUTBe9mPSfojo16hHtlkozDybHJdyJl0FRXDwLqVVpHy0rvi1HrWg8xHxdz7SuYDrD73p2yD4p5Uv6xX7PjgkB3fRIEgas/DODZLXsvJqRukglu29aYM4QlPK42zZVZ0mJf2hxc4uGOz4dUeoXUux5wViOsCh/k7veQHDHH63KDuWMzxWFtjuTReGNzFQAgTxmrYEGVK38X1jwGv0SLI4eRpndb4oJhKT1lNFSpOYOFMGTf9pldz/su7y7F6YxgGQugvYzKrpHAlEM5SsZv4gyQiI53ykTwtUeDPKDJ9bQY2/cc55IlJuFScaAOgx8VOcUZhlkaxFPrBX6wrwIzGavgeT6bg2J1T1kYU5fDV/Bx4JoAQdo29gAXxrpWTeXG5SGoh63MpGUX2V1nMqf08k/6U4i9pEO3pe988GaX3W9e7krA38ZVv4Q1TT6feOIT9jvkg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RdDNtNIVgoAOvX52PjNRazo9Ei1sQPjaFM4zJfKTXwwhE58ES1HAaefagGwv?=
 =?us-ascii?Q?Tgq7oeR7as3OgmMO/c/LX8xGIqpokRitNidiuHnZYlGYTJ0FvgZazpiDAsk0?=
 =?us-ascii?Q?aHcFQd/3pxllrj2VmseyMH0KZv5Pr2vO4c/+y4D3i3ECwBgEh5S4rRDzu0qc?=
 =?us-ascii?Q?juKcwkGNnZVmDioSjAYe/WcqIATOlu9HXlkaPz2Zz8bILYQ9q1UdQZEIZXVC?=
 =?us-ascii?Q?kAe6ZFB4CUNov0UDwnmMnZL4iRvBexZkRMHj2j1ltfgnohaddbFULg62sP/Z?=
 =?us-ascii?Q?oF/809fimvUTOjnSq+hlnyx14bSdBQnjBosgzSsxTRVxi3Cuk3PjkC0nl3Rb?=
 =?us-ascii?Q?HY5SYwe3JSXcsv8tGdI+mZcZjO0pY/nyAAL8zW2yEezMhayN4BYKU9WdXW1I?=
 =?us-ascii?Q?L+0b3iuMDZZ5/6sTu+kvubISp+EPG9l8nWTnUBjOA4M5+C8z/f2PpBadF0cK?=
 =?us-ascii?Q?ZnFW1J2KJPMCiH5i3TU2UoYpI+kb7AVKiI14ci7wowJ/YVnbI9PTS1L8dMo4?=
 =?us-ascii?Q?PU4lqUcIen+FD2I6JTGNrjKpwH5XVlWfC+pemR8osPWXCiETVlDH2jY0EoQ1?=
 =?us-ascii?Q?nrjSjKk0ySC2T9184r+G3aUj+Yc7IQVukxHTvFfmGOWkABbCBY1rI7ghXoRf?=
 =?us-ascii?Q?bRnl69Tsr2+cO8DekzEJIhtmtrgF0YSAJ+WD856y8MIDMD8J/eMQlkyu+WLh?=
 =?us-ascii?Q?oGLq965tPLuQgpKnsugZ1xW0i/ErlOMDso9nQTRJSfL8n4ZCad+w/RuFiCNH?=
 =?us-ascii?Q?pwT2ykpIl9ePH4M74AXoIa6oe8rqLU6Mp7pFWVeq+788g+9V3YfwjHD/0EWk?=
 =?us-ascii?Q?G9MhWkn0wVEyLhZsaUTFMyowoCNxMusU7HEtN9CdXwCvZ+LNU3Ns/harnuIK?=
 =?us-ascii?Q?vXbnlpk6i9H/NS/x/RSWcxPSRQ04REgm5oJXubwpbCGgYm2v7HhQqkUcOLMV?=
 =?us-ascii?Q?gBl4OslFdu4jsa0zpCc3DjHlG1gVD7FOYrryuxewpJa+luvkZl63XpmAb/TY?=
 =?us-ascii?Q?ommitvbGBY4kVGtoi3g0b4QdHuxTHT+DI6xmQAUGmUBKvO31R6Eu83OXAz+F?=
 =?us-ascii?Q?ymG/IQlKtX7AJQdOEv8eeH6q/esvL2mHfsfrZj/vPEQytPAR5NCv51IbwX+u?=
 =?us-ascii?Q?mHRgCNAIt1+sylsOkn1QnynvVXtT57ONg41JDLoPqK7PLfl3Smjm01mcwB0h?=
 =?us-ascii?Q?S9eYAY/bmPoYTvdcncr1gIIHsqMsY2GGVYG5E1rXVKiv/WqM8tVkXrePwc/c?=
 =?us-ascii?Q?RXybIOZzbFRWezTIRzw+BXyfHrbTTZ0gDexJVePSM4E2qOLQSlmExmOJqzFI?=
 =?us-ascii?Q?Yg+cLoeyNJ1FNkr9UELAyMWaw+Ab9LIhfBfFine2rnmgIwII8IMven10nUN9?=
 =?us-ascii?Q?jmrsy/X3KEDJMnio4gJiWGCwHqTdwd3/zvZs0YhQAY1TD4lfpi7YuI9VNK+Q?=
 =?us-ascii?Q?fgpzSlXHOepxo9PE6K+5orYWio9q4jXWsR+ujpDySyAY5AhLOO4WaCWF2X8X?=
 =?us-ascii?Q?UL8lOm+f957X+Fs4ebJG4G6y1etHpQC4v2k1zfluVB4dhmKeutPjkHZ/jvRx?=
 =?us-ascii?Q?4LPI5cce0gBuaRhayBz60REgvHlUvnYV3w8ozq+4?=
X-MS-Exchange-CrossTenant-Network-Message-Id: de916046-6808-4a3a-cdce-08dc54e4750a
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2024 20:18:57.5677
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d1fQ7b87lO3zhfD7UFjoOT8gp5lCkoLAxSTsGh2Pg2mOn9vqPDtGNLEVGXTKhfqK1vINFM1Jp0gNqSDo+/LN4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4643
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Mon, 01 Apr 2024 22:31:58 -0700
> Ira Weiny <ira.weiny@intel.com> wrote:
> 
> > An issue was found in the processing of event logs when the output
> > buffer length was not reset.[1]
> > 
> > This bug was not caught with cxl-test for 2 reasons.  First, the test
> > harness mbox_send command [mock_get_event()] does not set the output
> > size based on the amount of data returned like the hardware command
> > does.  Second, the simplistic event log testing always returned the same
> > number of elements per-get command.
> > 
> > Enhance the simulation of the event log mailbox to better match the bug
> > found with real hardware to cover potential regressions.
> > 
> > NOTE: These changes will cause cxl-events.sh in ndctl to fail without
> > the fix from Kwangjin.  However, no changes to the user space test was
> > required.  Therefore ndctl itself will be compatible with old or new
> > kernels once both patches land in the new kernel.
> 
> Good to state how many events are read out (22 I think) as that allows
> reader of this patch to see that it will cycle all the way around, so we
> will get the 4 to 1 reduction between two reads ensuring things work
> correctly when smaller number of events are returned.

It is actually:

num_overflow_expected=1
num_fatal_expected=2
num_failure_expected=16
num_info_expected=3

..because each log is read separately.  But the 16 failures is what tests
this.

> 
> 1, 2, 3, 4, 1, 2, 3, 4, 1, 1 
> I think.

1, 2, 3

> > 
> > [1] Link: https://lore.kernel.org/all/20240401091057.1044-1-kwangjin.ko@sk.com/
> > 
> > Cc: Kwangjin Ko <kwangjin.ko@sk.com>
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Thanks, Dave do you want me to reroll with an updated commit message?

Ira

> 
> 
> > ---
> >  tools/testing/cxl/test/mem.c | 19 +++++++++++++++----
> >  1 file changed, 15 insertions(+), 4 deletions(-)
> > 
> > diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
> > index 35ee41e435ab..6584443144de 100644
> > --- a/tools/testing/cxl/test/mem.c
> > +++ b/tools/testing/cxl/test/mem.c
> > @@ -127,7 +127,7 @@ static struct {
> >  #define CXL_TEST_EVENT_CNT_MAX 15
> >  
> >  /* Set a number of events to return at a time for simulation.  */
> > -#define CXL_TEST_EVENT_CNT 3
> > +#define CXL_TEST_EVENT_RET_MAX 4
> >  
> >  struct mock_event_log {
> >  	u16 clear_idx;
> > @@ -222,6 +222,12 @@ static void mes_add_event(struct mock_event_store *mes,
> >  	log->nr_events++;
> >  }
> >  
> > +/*
> > + * Vary the number of events returned to simulate events occuring while the
> > + * logs are being read.
> > + */
> > +static int ret_limit = 0;
> > +
> >  static int mock_get_event(struct device *dev, struct cxl_mbox_cmd *cmd)
> >  {
> >  	struct cxl_get_event_payload *pl;
> > @@ -233,14 +239,18 @@ static int mock_get_event(struct device *dev, struct cxl_mbox_cmd *cmd)
> >  	if (cmd->size_in != sizeof(log_type))
> >  		return -EINVAL;
> >  
> > -	if (cmd->size_out < struct_size(pl, records, CXL_TEST_EVENT_CNT))
> > +	ret_limit = (ret_limit + 1) % CXL_TEST_EVENT_RET_MAX;
> > +	if (!ret_limit)
> > +		ret_limit = 1;
> > +
> > +	if (cmd->size_out < struct_size(pl, records, ret_limit))
> >  		return -EINVAL;
> >  
> >  	log_type = *((u8 *)cmd->payload_in);
> >  	if (log_type >= CXL_EVENT_TYPE_MAX)
> >  		return -EINVAL;
> >  
> > -	memset(cmd->payload_out, 0, cmd->size_out);
> > +	memset(cmd->payload_out, 0, struct_size(pl, records, 0));
> >  
> >  	log = event_find_log(dev, log_type);
> >  	if (!log || event_log_empty(log))
> > @@ -248,7 +258,7 @@ static int mock_get_event(struct device *dev, struct cxl_mbox_cmd *cmd)
> >  
> >  	pl = cmd->payload_out;
> >  
> > -	for (i = 0; i < CXL_TEST_EVENT_CNT && !event_log_empty(log); i++) {
> > +	for (i = 0; i < ret_limit && !event_log_empty(log); i++) {
> >  		memcpy(&pl->records[i], event_get_current(log),
> >  		       sizeof(pl->records[i]));
> >  		pl->records[i].event.generic.hdr.handle =
> > @@ -256,6 +266,7 @@ static int mock_get_event(struct device *dev, struct cxl_mbox_cmd *cmd)
> >  		log->cur_idx++;
> >  	}
> >  
> > +	cmd->size_out = struct_size(pl, records, i);
> >  	pl->record_count = cpu_to_le16(i);
> >  	if (!event_log_empty(log))
> >  		pl->flags |= CXL_GET_EVENT_FLAG_MORE_RECORDS;
> > 
> > ---
> > base-commit: 8d025e2092e29bfd13e56c78e22af25fac83c8ec
> > change-id: 20240401-enhance-event-test-cebeff5189cd
> > 
> > Best regards,
> 



