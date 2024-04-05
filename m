Return-Path: <linux-kernel+bounces-133436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 679CC89A3AA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 19:45:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B1B928542A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 17:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 396BE171E53;
	Fri,  5 Apr 2024 17:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gttniskJ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4CBC16D9A0;
	Fri,  5 Apr 2024 17:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712339114; cv=fail; b=QFUDhHmnMRU7IDourJhtgWJO2L4eSOC9QuhaPlEJb54ZRrlJ9JyiRNehjx5yadkq0fGQwojHuTKHQpcbxL9RsdlKmYL9pDO9ISM2l9L7mvonWWoBdfBZ7SJQwJb84O/ZIsRiPpFCpc/HXpC0pZmslqAm0+IeQRS5BKtV2pFdvEM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712339114; c=relaxed/simple;
	bh=1BROUKh/qXAWIrFvv+WqSikzN4XbkoHD6vZSd7MxMlc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mVsXGzuNt84IeR2Rf8xio7/6eIGUYVgF3yScLP70L5O6MokYlPVI0+GFqAac40q/vbo/Gix5Kpc07TyPyaxSlhh3QKovQsclfYHrXPUNVyNEF0hHDKk3wu4CEvCM0OcRj9UgnifYBayFB6LqL5eRwguJ6rDxcbamK4JHpBx3LDo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gttniskJ; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712339113; x=1743875113;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=1BROUKh/qXAWIrFvv+WqSikzN4XbkoHD6vZSd7MxMlc=;
  b=gttniskJ+iqBLn8WfK052G5BfgFPpop31pDiLp1m/yFKcOgLuu0BgOVE
   leaPTJoBNW7L2YPVmq94fiiPVrr45eMzdTSEXwWOKO6335GrrLlzedmrT
   wyz/vhGDzFOQT4HVuJmNLEOTSdsKCYTx+9nz7ar75lj8lqfMWroIaf9co
   5SHqKMCbQkOXLgKPVLDh2bCatWEKyUtfIDeXbGxvu8b5MiocOmucTd7LY
   Aztp4xMVe2SZUC6iGOYL43+IHuVZBPo20/uIUi27Ep1+k27jnNX7fbrKs
   S1PSfcsbfL2hKqWkmsApQ1C/U/0nYTwiTHF9JMAdEGBhccknLbTsIOxGH
   A==;
X-CSE-ConnectionGUID: QAv3lLtJQnCKm/a+TkpX0w==
X-CSE-MsgGUID: YmJBQQEFSqOxb9A9I7pwxg==
X-IronPort-AV: E=McAfee;i="6600,9927,11035"; a="11473473"
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="11473473"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 10:45:13 -0700
X-CSE-ConnectionGUID: YShuKIBoSBaePZzaCAhi3Q==
X-CSE-MsgGUID: irlUvDCORy6CnyUWMGIXZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="19782000"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Apr 2024 10:45:12 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 5 Apr 2024 10:45:11 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 5 Apr 2024 10:45:11 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 5 Apr 2024 10:45:11 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 5 Apr 2024 10:45:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CEWaJJl9bwecXBBf+czKKga1ld1T6I8TmgcDPPNZ2KIBDETBe4r0cXbssqsznoZfo2u3YL5ugPNR4fDbXNh2Uzz0A9VefXV9GPrmqUJbaI1ntrW6qhVQkkcJ17h1SAAZPcSPWZo0ild2siDqCUAQkSleIRzURFRJmsr374R50mjLwcGDDHypBvNdFoj09vjGSkY8/QY8WHxTJLOxZPDUyVFxQ4k2zr5H+z2MpmNAaC5B0jx2b4s/KAhK089LhRMMrLYpqCyUvSSOPZkLSb6geJU5XGSMd1/akVav/NFXMtBoW9LlrohVawkWYZLtJbRA/AUUqd3SD/TE7WpUotVZ0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VG7rsQGUcA0kaPIlIfcTo3UWh/MvbI0+ZWxsmISmCJA=;
 b=LrWgE9e2yBAffdzll0y7cEDL7W4QpHNVwIrNnA+/d2WI9saZIuKDUs+VvShR8cloF8zb/NGHmFY7jj/Yx0+LlYS3dTRAEQ5miOKyxp0P4a6hOcUUEeM2hAUZv2KyFJAXnAK9WK9DwfL64pXAxvW7NcmJaBzytZiknr8XD4ujQN7CDr5o/Ct84piA/QRCK/bI2UbPD2/S91yLv/km/kF8Ikw8QhHspicqbJSQ29yvV82CeC5Bq3wa77gKVHcWsjBULHX6OjEtB7d1xvvalSjc1n3VRQQvIUc0K+KFdbkBlLn7cAB+yXMB9ksjpkr0PTeG6V499spT1WlbSg5BIrMBBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM4PR11MB7181.namprd11.prod.outlook.com (2603:10b6:8:113::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26; Fri, 5 Apr
 2024 17:45:08 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7409.031; Fri, 5 Apr 2024
 17:45:07 +0000
Date: Fri, 5 Apr 2024 10:45:05 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Alison Schofield <alison.schofield@intel.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>
CC: Kwangjin Ko <kwangjin.ko@sk.com>, <dave@stgolabs.net>,
	<dave.jiang@intel.com>, <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <kernel_team@skhynix.com>
Subject: Re: [PATCH v2 1/1] cxl/core: Fix initialization of mbox_cmd.size_out
 in get event
Message-ID: <661038a136a79_1578629429@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240402081404.1106-1-kwangjin.ko@sk.com>
 <20240402081404.1106-2-kwangjin.ko@sk.com>
 <ZhAhAL/GOaWFrauw@aschofie-mobl2>
 <20240405174056.00005422@Huawei.com>
 <ZhA25pRuyiHJWcLj@aschofie-mobl2>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZhA25pRuyiHJWcLj@aschofie-mobl2>
X-ClientProxiedBy: MW4PR04CA0281.namprd04.prod.outlook.com
 (2603:10b6:303:89::16) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM4PR11MB7181:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gEn6zC4uoEhEwfe7VCIatZY3yR6xIUsPvxILM/e2K+XoeLYwbfyDx3SMPpvNOHRh4+euQ9D8j6Bf8D/CwVCwxCIdJtFBOI6+1d6N0fUK4TN2IMO56/gxkskexD7KbGzKlrOsUuCyZsT3paXBDmc9nUJOuNe8lWNStKb5L5pNNGlYlRmzImnCntkKTHUGuoYKsfB0Edew27ihJXmYXD2xECSiV2TEXdgF+RsVBSCcXQ3mY9SYrf5L8mSNt2H79vtCyoBsGA6sVZ6p9yNP4uB8u/JL1tXik0/d+5KOJ7cKhQ/3GFC89nrJttbZ+7Ve4Q0IWzlokT5/SQR0CFInnqLWZiO1b82ydgx94/WevrELY7l5YySP7PaWX0XPqLXFJy6iwniq7g/5M6CJmkKvWzqGP5juLw8nB/b/LPURZcM/VFGSAdMlQ3YHjEm7CzZy6V8Xdxlpap2dUKMzTRU6Kip/Az3zpJz+xsN+Dnes4PMF0qT87fV3XJL87fKB6arnBtU7cdxcIfA7FhmDa0P1WoQAw0gKPXFVOxeoIzLtXwrXAqZk5CB+h3lWlfNQpfD8x7K7d4V/yKRAq6L4IAEjDj4Yc+R9bDNRrhoJnEt1TwrJUwv3eSqzVQkgv6V2+23yOjxUh3qz7Kl+45iirNPmQs2AGEx2Y4MZaX/ZA9NMngzwsv8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dNmCCp8fYkSFcrapNZk942GQIgUOPzK63TxEFhguTfarG7ct03hTXGMg3Xkj?=
 =?us-ascii?Q?Le14gUy4nDESVbaafTv8OQcPKvXcNFnNiVtvQY2IW5R8jgXgEDBTG7XN5JLj?=
 =?us-ascii?Q?lOQz7RkzzJzUYcE3eAqzQEd7NBK8/TO1CAwq2pNLv4yo2/sckxGsK2259Y0Z?=
 =?us-ascii?Q?aiSqWgq/UCiLWFHvBAqPdIcfjexTo7pFlAkX+tPtXRLbRGF2+TkfsIKqBK5q?=
 =?us-ascii?Q?hg7732Ck7fDRzLqLAWh5gk4yUfPV1mYS0WJnrfDZ8/5mx9pSxypZY62yOmfG?=
 =?us-ascii?Q?nQCXR050lKpK2WjsEsIKsN7nkKP72/70oynIBA6vmkVIf9SzQKmZ1aoai63t?=
 =?us-ascii?Q?eb24jua+U4Xilnj6zVA4/vgQLeciTv1+RNZmmgO24GdGC0DWIsG0PQ1SbPk3?=
 =?us-ascii?Q?gQGKahTnl3c1t2SsiCPVRDmChrK/+q9go+hZCFOFPugSr2oirwrGEC8hqZg9?=
 =?us-ascii?Q?d1inixJXE/MAU0eoNrpWeuLh/gDzf34JTO+craifW0yWJkolnDPARIbHHZye?=
 =?us-ascii?Q?sTcDBDiOwojaCsWulR44J8HpZAaksQRYZwMQ4+b8FunHBRO/X1M0pSMDm8YL?=
 =?us-ascii?Q?wxrrGo+bPOiSHYwkFfJ4DxbHtsvp0GuUTOCipkHQ0WKLQb3+OeuZLQy4hPOD?=
 =?us-ascii?Q?zZmC80ZNY7i0ihEDdIqeA02H+vsa9N1ixSC9EdNhpJ7aCmRcnm7SSvAqA9hO?=
 =?us-ascii?Q?NH2poTr1nDdXPafhYRJ4PRvtGb3nVkMossDkDoUSDED373evTantsqL798zw?=
 =?us-ascii?Q?QM4rTRKyiQiI88Udt09//hU/pzYrdJNbWTsXJ/eETMfeqdCTNaH33trsEmuJ?=
 =?us-ascii?Q?GYjMofylQKvY9Oys7jf7k99DCFtJKMShLAnd6SjXiV8mope8qYZLXfXdRNwU?=
 =?us-ascii?Q?dPTOTFz1ZCjWZITPs8/no8dokJ2uFC0SvKpb932+uSFa8G02YBTzaEvCejeX?=
 =?us-ascii?Q?j0zu+83KadfH7X579EMj3T9CkLJ5tBBKti5glMfCw+fwr9SVq50SBhZmscn9?=
 =?us-ascii?Q?pPqrF8HMBS5oMqGprSA+Aua+YoyYcfQ1NPn6MRiXOBPla8kaXuILBI6lVDit?=
 =?us-ascii?Q?ng+Ki0PCMTvopQlWtYsWdPGErv+ho8Xk1TqfVyb6biE/ie2+DgvMLs033MOu?=
 =?us-ascii?Q?SMdik3jhI1xFsHMEJB966tvVO4to5NXvUt/Da3Duxe6g/9J8xsAt4GF/ZdMs?=
 =?us-ascii?Q?EAYntTRsDuoioS6NZDDbh202byuouiFoJ0amfodi42d5/Odtvv70q3/aUNrn?=
 =?us-ascii?Q?O2aN0KUEgp4BYvsDwtSYaLWEq09TLc/EotCJllDAkqJQbGBeja/aNPuqryz7?=
 =?us-ascii?Q?VqFBCF+jtdCMwTmRjfeVHN0hw+rh+d6ngqwwjySoT21qRE64qOU6odNZxFQs?=
 =?us-ascii?Q?BloF1NbZtM2e92pdUxMhoZ2Nq8H1rdD1fP/qVG7T+0UCEaCw/mnkS30UnkT1?=
 =?us-ascii?Q?UGWvbIJTw6bOZXQhQDRwHUNxj31tV1GEno17S9vxXmt/uKHqxzU/jPB49APF?=
 =?us-ascii?Q?8KmvF8Z30J7zNNgb2jNS+Tm5MO0gevU/dQCHx1A6Q4Q07yXPX80gDwAZ9qz8?=
 =?us-ascii?Q?BQdIFHl4Y2bWC0AUDttzqGcdOEBIdKKAvTmuA0K7kx//cU152LvrtcZqUHXY?=
 =?us-ascii?Q?/w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ab54ddf6-dcac-4add-5cc8-08dc55982226
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2024 17:45:07.7660
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TAgnwaqH+k3y3JMmWrGKH3ZtKzE9LZW20dbeTkQNhAPq1IEIV7YxdPhgXfDbAWf0RfiBIrW+JkdoTRwI1CJdS0dQdIGFuTQWjl4WI7WCWoo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7181
X-OriginatorOrg: intel.com

Alison Schofield wrote:
[..]
> My thought was 2) device bug. Bad device is returning payload length
> that exceeds what pci/cxl-driver can consume, so gets ignored. Am I
> worrying about debugging the hardware needlessly? 

I would not go so far as to say "needlessly", but the number of fun and
interesting ways that hardware can violate software expectations is
myriad, so it will always be game of after-the-fact quirks and fixups.

A payload truncation would seem to fail safely in the sense of no buffer
overrun and no stale data exposure. Still a bug, but no riskier than all
the other potential hardware bugs / spec violations.

