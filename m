Return-Path: <linux-kernel+bounces-147149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EEA18A7023
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 17:48:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 423521C20C6A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 15:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 028A313175E;
	Tue, 16 Apr 2024 15:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JGIXIQhw"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982F3130E30
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 15:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713282483; cv=fail; b=Mq7xHsB2HLnlkYuEjv1m4zNNjJTdtYouKBV62lVceVgzPr7MACfMyumoveESr0ZtW95dBCjInt5IQYnx4R2K/tWwm2393F3XASvYCUytE3lDTtNAvqSBzwokLfIbBlV0WnX3lIhHuBddS63rNqGKBJGpD1RoeprEReWoREQ42sI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713282483; c=relaxed/simple;
	bh=+u6ByJjY6qvYOBxSH0V/mBazyTGzrAIM8soMZte7ZM4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AEiZJmXrKoDIvnIqW6p8rTh8KFl1KAKZCvVDkuFqTO6Wa0cPlgN5r4YY3W2PqtZS0FkPOK7qKqvWuN8vYB833ZAfRAHlaRCOxapDOnRPv90NbpqK1rBIbW6SL5w7JYeLugiUaY7tRKvC0I2t8lk6r2clVkmECek46JTBujPn1N4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JGIXIQhw; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713282482; x=1744818482;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=+u6ByJjY6qvYOBxSH0V/mBazyTGzrAIM8soMZte7ZM4=;
  b=JGIXIQhwpU+cU1CsgTLWattbxp26v59I8PCjpEnr/EPIKhZ5n8+6sz1N
   9kljUOhs20PHiC5F6TDgtlLJnOxJZyY9wu4e4mQRfInpshdo59M2ETNuC
   ZpZcRTYFEKXMG5G3vZaLb41xy4M/QSQfDroLi/aULzDD2xCBKxugqrhuE
   P9aRoHiOg3gG/1lOP1h/5lIHzWdCmNwq53viG3ySiZ7yW4pVjd15k1HCm
   /fNXNQ76QOMoFV1XJxv4Vc8qrtOMaM/75cExUqBw404jT9z3omhrv2Zfj
   6OGYkrhSVIIkHjgr7Gl7qBnql8KcR0OMcVfbTYcIq2cSoRQEuLGxdWD6s
   Q==;
X-CSE-ConnectionGUID: dE3QNPu2Qgmcly/YE/6MtQ==
X-CSE-MsgGUID: TR92NFw9RhmrT55jybmGQg==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="8651602"
X-IronPort-AV: E=Sophos;i="6.07,206,1708416000"; 
   d="scan'208";a="8651602"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 08:48:01 -0700
X-CSE-ConnectionGUID: HXPQZvRhR1SZW/n7UkmyMw==
X-CSE-MsgGUID: GmgVM7i1S2uMua3t8voNrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,206,1708416000"; 
   d="scan'208";a="22779465"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Apr 2024 08:48:01 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 16 Apr 2024 08:48:00 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 16 Apr 2024 08:47:59 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 16 Apr 2024 08:47:59 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 16 Apr 2024 08:47:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mNLfEYqAdy/nAS3+POOz9dbmqHwFgMnGT+tLZqQwjS83/1WUAqa+v0ptgo4pU5PZqM7UBzKiAAe72zoGGaIrsvEzfPKV52yWL3zrn/0X+ihui3LRL4YNn6xxN+uLzIyswyqsWtwQfnpOr/JqizqDvJcfsr05O2oQcbHs8b7AQV1G7tVxviYdQM9OVjQ63KPHu2eAhtdZjUUqy+SYzLz2W9a8YKXsgoKMWo/chLLJkLUmLNTcA3gdzHTg6wDIBBi4sIjUd3GF3RYrzxpg1YXXJkcFXO2fQAQ4fOZKM54D1lauclXQ7/D+mAJll6sjEqH8P7th5ZtlsqDVnbLhCP6nLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ufwWjto5ZrM/f3XjozdX/daW14n95hA/d83V+5ZfGoU=;
 b=ceG4ePWjYBRN84hdSJHLZhGpkB9taTN9syWvdS4c8ixgmmwWimSQQojjCpzyZAubSENkyhNNhmv+5MH5htHJeh6XPyLyjkN1a6tgn4b0Kd8vkHaRtNprcKOs/T+TcAc4TJgGvjBHIkMCgFkJYzPHMiqy+wrqmrPkzcY2Uetz2bcoS5diRNCde96kx0OK2zljt9qpjyw8mvf+lYL3QUAmmV1U8xGxINphG3fNary2iFqRtOVNhL3HpSHBu1PJcL1sRUCUkCjjPyiqLBCVoSAWZZt7E1i6qwSmxOUqk1Ht1E2LMwuryRjzA+co5F9n1CdCRlCrjU5lHkrBlisKkcvslg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SN7PR11MB6798.namprd11.prod.outlook.com (2603:10b6:806:262::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.25; Tue, 16 Apr
 2024 15:47:57 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7452.046; Tue, 16 Apr 2024
 15:47:57 +0000
Date: Tue, 16 Apr 2024 08:47:54 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Tom Lendacky <thomas.lendacky@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
	<linux-coco@lists.linux.dev>, <svsm-devel@coconut-svsm.dev>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, Michael Roth <michael.roth@amd.com>, Ashish
 Kalra <ashish.kalra@amd.com>
Subject: Re: [PATCH v3 09/14] virt: sev-guest: Choose the VMPCK key based on
 executing VMPL
Message-ID: <661e9daa4b37c_4d56129418@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <cover.1711405593.git.thomas.lendacky@amd.com>
 <9615e6055e5b262a22bf312608647223517595b5.1711405593.git.thomas.lendacky@amd.com>
 <661e04966c622_4d5612946d@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <8a1b16c0-9897-bd10-b6f7-b428292c8c9f@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <8a1b16c0-9897-bd10-b6f7-b428292c8c9f@amd.com>
X-ClientProxiedBy: MW4PR04CA0226.namprd04.prod.outlook.com
 (2603:10b6:303:87::21) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SN7PR11MB6798:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a1835a9-c519-4e65-8219-08dc5e2c961d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hJbNwv1NuYjbPSmuU2bgXJ++/RHMgxFq5ADO4Ep8IMTck8vftr98bB919fjXwAqIoioMsHsJSbZfUjUkqKpgOYfRRlTSF1jh/8z7ZAR/cpJ8ugD+CEB/ySiRSPGi3zH9fi2RupYuyNWlwvMoLq4Lj/U0ullp4DcDREHJo4whuVZNpPHLAmO59RWXWjoEQy9zrmD4jVMAx/Q5KmNaLlJBUukysUyBZn/DfQsu7W74+eKyc1dnTNPh9ca0BRhBCcpASTjDIVQKw22/lMpiTcBx/SJ9coBGPvVYbVdO36vaaUmfpFSWsr9ABkSWOggKEZ0qMDR8Ux1bB+QZmC9VbV8kCf+6MjsLfE4ifX6+/PhQh8jZHXRiyyIZ0De1gEP70b28E7gF7dXzv3e6qCEzbl/vkldNZETuAyKF2vKsWmwRP18iia+fGYVoqlecUfyy2YqXTt02pe0zeMzy7H4fd7eeZyFB1SBv5zowzxjFyR7k/9pjIuefnUJmtMGGQ7azUM2/ZBSVJp4SD6e8WgvU/dXMPXEvzLhxfJRrk2UULnDF4CtWfpZ/pl5fry9ZBKS+OSzWAcMzPnbE2uRdEa/wwlOMSwPNNioIbf8US8xw6AP17LUWoO07HdpLa89TZhDdDyANEE42sFpQJra19jJMOxSC8XOYlbFTyvibv30D0y+a3YQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vqrUM4ICoIf+41HsUc3T5ckcZW7AzhcOYXP4ONWvbcVGCh0FSRA2DnRo5twj?=
 =?us-ascii?Q?nrztwuJFLOvDs/x/FgyLJzYgTnAKyatrC6x9rcWzH8U59OeXVlSgRvCAnwNU?=
 =?us-ascii?Q?jHW6Anai+D2bXetXJEFDzg6sq2LUDw2kGoMClAKp5SKbxGNEiUON0MhBdoN5?=
 =?us-ascii?Q?ptoSqL+Mynnp8lHl5OPoP0oAkhSwhns7PeqkcLX47bOvQvXw0FkZrde3QK9S?=
 =?us-ascii?Q?S/PLjm8xihThEjTAHSUVcF/GsN9KjQgnbShcKQceMsgpt/NgivICcnfkOme1?=
 =?us-ascii?Q?brtUcRxqCIpwl/fa0QZsJJBCBUmtqj/Vx+Y6YE0MOPxXy/2QTrf/MB3/DnOi?=
 =?us-ascii?Q?A20fue/KGuKk/dl56WTti1ltgZEERPKbhJPzwp8AlP1qlNwhKIx0JGhFpd42?=
 =?us-ascii?Q?YBIpvZu5mk8jPtc47M7thyF956gdjvXNJLvzymI3KOh+wmJAxma7eeBvur77?=
 =?us-ascii?Q?5990bWLJfXeD56olt6ORCcb0HsRrJTFQ0AnO+7n9Xg3rjQTeudClDCTYdV+d?=
 =?us-ascii?Q?/XdxBwRQzSy4ebgpB0RcwLKyFVvsIaiA0sNHgaZOUsuxJbeY1UsKAzIWjFj7?=
 =?us-ascii?Q?u/OmfzxHubgqUQS/SjcxFRp1PkJd4kln5CI0caTVbN4/r8irw+pwwqsG1SJA?=
 =?us-ascii?Q?JR03twJgq5zwvZ+M0sUsrF5/UJBINq3cuRQ0vtXvNsoL0/ggKBtgbxl9xfIV?=
 =?us-ascii?Q?vdzb8tu7nSRt8+JKmkuJtOHHBFFb6i+b8u4PQpUwrBclBuw8P4Ak8nUBkOqT?=
 =?us-ascii?Q?GaIYgrhc1BfPom+0ngoSm5KhFzsW+dEz7zq1bN7W7YzCZiNo3VUTpr9zghc+?=
 =?us-ascii?Q?BzCkCSUc7ga0U7rLmihFoOXs5w7vovXsXVcFVZdnJVtx5WQk5v/Sja6tHiYg?=
 =?us-ascii?Q?QxGrx8l1ylkjW85Ot9U6LKVlTurHc0LtfwRXYrl0d5+Z+We3v7Yp5xm6xyJl?=
 =?us-ascii?Q?BZVR1YLxvX2794GMHqaWnDk0p0XDICPwRmUlH9wSDy1CwH+8TQ2q1Sojr0dH?=
 =?us-ascii?Q?FGHsphA7so25knZEHQmQxFsPQ9eJSaaECOcwCO3RRoXgJjPRw0CQvUff6RVI?=
 =?us-ascii?Q?TbJJoNqss0JGW3a/hiUeb8M18V8OiDtEpC+RzIpJEZe46GFPrBWERH9idb/j?=
 =?us-ascii?Q?JzxEYFwQ8/sIadAyNn1Rs7dt33fIDkuKadZkV8J5wcYHnZ7uNBexRCe4EANo?=
 =?us-ascii?Q?4uNn1Kl6qYjgNoeVCIK2crX/tjWmqn+HoH8/9iqBfiYtcG0/Oc2WlhNUjmnu?=
 =?us-ascii?Q?XiTGs/eHxBcsK1WZ2azZkfKC882MDppC1lBh0/bZDx5gFAIGmD+czlhn4g3t?=
 =?us-ascii?Q?o/RIrJ2e/gnHSRp5p2CBmlSGGt/Lk51k/3S+a2Bi6SdldJgn9gPH263tL93T?=
 =?us-ascii?Q?9tzeq5+Tp7HV3g4a7b+1DKXwReF4p8P56vDmYrT6s9Xag3sxMR2yd/e/01cy?=
 =?us-ascii?Q?NU6ZSXdzhFyqaPdjFLGtnDo8Q135pB4YOu2CAxUYN2J4AVOoj/omG6YRRxQi?=
 =?us-ascii?Q?fjD6cxlTS/snH56fIgygevN/00JZFkqv5+bI4Y266SW578BaVNwqEYhYt0OG?=
 =?us-ascii?Q?valubwQnM8QS5ki3/VrZjx/hbUxD1zHyEifuNFlmYFjfLAB1tVX+NJtrTlAb?=
 =?us-ascii?Q?gg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a1835a9-c519-4e65-8219-08dc5e2c961d
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 15:47:57.1079
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qVElfNBBhr7W9mfroVOBhcINM6M8oDdrA3Bd/wXJFa4cE163XIjyAHUsjqKIcA9uubt6owamv+TSxprYeXQ+mYL6TJGQrJivTHGyc+oF5m0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6798
X-OriginatorOrg: intel.com

Tom Lendacky wrote:
> On 4/15/24 23:54, Dan Williams wrote:
> > Hey, Tom, came looking to review the tsm_report changes and noticed
> > this...
> > 
> > Tom Lendacky wrote:
> >> Currently, the sev-guest driver uses the vmpck-0 key by default. When an
> >> SVSM is present the kernel is running at a VMPL other than 0 and the
> >> vmpck-0 key is no longer available. So choose the vmpck key based on the
> >> active VMPL level.
> > 
> > The module parameter is not mentioned in the changelog. Is it not
> > sufficient to always use snp_get_vmpl(), and if not should there be some
> > documentation about when to specify vmpck_id?
> 
> It is possible to encounter an issue that causes the vmpck key to be 
> cleared. In that situation, the guest is allowed to use a vmpck key 
> associated with a lower VMPL. For that reason, the module parameter was 
> added to the driver when it was initially created.

Oh, sorry, misread that the module parameter was not new.

> I can update the changelog to mention this.

I guess it is too late now, but a proper sysfs attribute rather than a
module parameter would let you do sanity checking on the writes and
allow a natural place to document behavior in
Documentation/ABI/testing/sysfs-devices-sev-guest.

