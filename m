Return-Path: <linux-kernel+bounces-147382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C308A7330
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 20:25:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A747A28457C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 18:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47A86136995;
	Tue, 16 Apr 2024 18:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z/mKn9Ul"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E5F134CD0
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 18:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713291935; cv=fail; b=AnjeHxY9Mkx9MRjiXk3ri6dvrHuyQp7CtoUW85Iszks8bm0L1CfTe89bOSGJ684H2cax70ugyp7E+0cQ6Uu7qPQNaIvXeyJz/Ojbt0cW9EgiwzUt3MISADECLNBCwB0jFZBvLyL/LGX5hkVjNle9FQvtIE4xzjRRM+mfbq81fGs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713291935; c=relaxed/simple;
	bh=84b2d6yQjSL+1xt0eessl3M2pnesgInUfPzwTd/SCi0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=o4DqZlPZy1W6KWv+S5x1jkBPIioqMuJaxOs0incviwdAR8X5ntmip2giBKPanHC4toGjFl9YvPPCYzePv9K9jQZfyQirm2sTlkGezYUTs/TH1gRkk1+B7wZa3OkeHfFGYRhT3tb6B0lsu0yPBhPuDZPwOysmqcFg3zn3ypB+amM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z/mKn9Ul; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713291934; x=1744827934;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=84b2d6yQjSL+1xt0eessl3M2pnesgInUfPzwTd/SCi0=;
  b=Z/mKn9Ulz94wJG6hjr3syDCoN7LBD1PHF1o9ZnXSFOAUhT4ZWcEGq7c2
   IDxU6V5SzUkgQIpI8QAV45KpVIcF7X7xy+7Opm3EcxMQHumEKqJT/pXCs
   wYTWW7+SvGSUeBfJNc7isXQMp+sIhL0BU92n6HEgG1e0w4UrYnA+Z9E8i
   oRyA5xPNidvc+fj7OArb/9Q8P/9x59zTc5UfJ2y4qtxLRjmMpwTTDBTPZ
   n9h59fC9M24SahgDr5q08M2t+ysVa6XP9x47Yc361JxXqG8KYVXT0T+7b
   fHS12J1Po2xoG1RhEPEqYfkFB0Ko7IVjKlst5lPiKehrAcCJAV8IMF6Sw
   g==;
X-CSE-ConnectionGUID: yKnMPxjnRSuPFNsLWxbFEg==
X-CSE-MsgGUID: Gxz6g8GhRY+q778Q09ePPw==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="19310602"
X-IronPort-AV: E=Sophos;i="6.07,206,1708416000"; 
   d="scan'208";a="19310602"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 11:25:33 -0700
X-CSE-ConnectionGUID: aGCiLp9nTWaDILoSpzBqyA==
X-CSE-MsgGUID: stT5hoZvRl+ucdmQub3jeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,206,1708416000"; 
   d="scan'208";a="53328366"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Apr 2024 11:25:32 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 16 Apr 2024 11:25:31 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 16 Apr 2024 11:25:31 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 16 Apr 2024 11:25:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KH1YesHWbBrpXTRwvZoOkCewaIwXQ4tdaF+uRS9CMm3qJnQut/DYvaAcgLL158C5uJZ/oXsb43x7A85im4OjtYqS4R3OVM9/lYInatke9VZedoUPuhc6gldGFukG+SxGeVJp+4X6HsXwb5UBzHiISNnUZZbje06kZPjjaMzE0gBv42tIIcPm4+UNxRW0jCJTnMf3W+0TXSGTayFbePe1PPwLMB5B5jL10+WZSC/z++mbhvZ91x73+xYGTdcF6nwuLraaa6ESmdTEad0QAT6DdbbIJ48vK6U7w8OuBR575z5b29FFJ2VcI6n32lmkl9ih8MNg2KewoKnOX8UhsXUDjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=npaQ8f+bjvM39soiyyoIH5RhvgGLqb6WMfoaVVBljII=;
 b=WktQk73HuCu4HPkAzTQ1uS1VM8WryUzBDTbbJH7w4xfM973VuuhYiCLJq1j7/X5/XlgkzQDY5LLG9ZrvVEjhB9uiTVLFBpLXXfIAUv96awdlub91Zyx1hOKFCB7K+8xQDarlW9DOa1V5pluIkBPHgN4WqsbB+luoiem1RCjWyXkMFSLB6COBUPTPjP1DPeDNTOcD657oqD91gzwXbhIZBGCA4KEr4+iPcExp3o67y7CPvftfxRun9Myf+sPLEPXfg+DuqjtTZ9ODfmrs6hQ/gXg4yIiaU1jJZbPo4yXm5HOKaNjWaT1e1fBpOuqsBOJdfdEs5R4FUddtQmvvu9nPXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA1PR11MB7388.namprd11.prod.outlook.com (2603:10b6:208:420::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.26; Tue, 16 Apr
 2024 18:25:29 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7452.046; Tue, 16 Apr 2024
 18:25:29 +0000
Date: Tue, 16 Apr 2024 11:25:26 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Tom Lendacky <thomas.lendacky@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
	<linux-coco@lists.linux.dev>, <svsm-devel@coconut-svsm.dev>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, Michael Roth <michael.roth@amd.com>,
	"Ashish Kalra" <ashish.kalra@amd.com>, Joel Becker <jlbec@evilplan.org>,
	"Christoph Hellwig" <hch@lst.de>
Subject: Re: [PATCH v3 12/14] fs/configfs: Add a callback to determine
 attribute visibility
Message-ID: <661ec2968fa55_4d56129470@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <cover.1711405593.git.thomas.lendacky@amd.com>
 <e881a70fda1da98882241fc46fd57c3063fde55f.1711405593.git.thomas.lendacky@amd.com>
 <661e10a01f1d8_4d561294d0@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <7fc4e7d4-dfa8-b626-76c7-1f8993304a2d@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <7fc4e7d4-dfa8-b626-76c7-1f8993304a2d@amd.com>
X-ClientProxiedBy: MW4PR04CA0144.namprd04.prod.outlook.com
 (2603:10b6:303:84::29) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA1PR11MB7388:EE_
X-MS-Office365-Filtering-Correlation-Id: 24215d4d-96f3-42d3-b87b-08dc5e429837
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1r010CV2nCTpwDSNXcvK0oXoHbzc+FFUrkHtDtViBPqNiyPoqv4TbVm6le2cjTm0Ebl2Klso/N75qsPoioAG57VDZLCn9NH8n36DYcZcjM13XlYuZCRQ4bjd0IG6q0wfsdyEMJzLt+JSbR7V8K5KMcKcsn8cUd6+B5ncwQfPvOQkMS3BdONQsNTEhOaLfAQlBylejprOVeX2X1irk41PxlHCAPjiW+Bu4h+OhzR80DNAzVGq4ctybIclR8cNxoc4EjygUVYHz5OVXuh5CRqffs+9gjOj1mKTWI8J7dvghSCg25PTBDZouj2TPFE3oDQc1UDPfHIVcW7J0ySAsaFve6nUnPl993h4Ne+pfF33mr4H6nNI0n0IFoiy1OtnlVdD1kdhMpGPGyjtiZCA0IB8plVb3RwOyL9WviRynguOA29J8GZHfzYMUzF8osX4Wu/9UhQV5rGRf4oZnVJ43ACGw4qdb1OLujx0iCaZAcTF9FdVZC1LqpAal0YdxPilLD07mnmi1AjVACzEwtCbVRzhQhydXyhgoKoChs8LbKZZavZh8T82dnhbH4TsuEKgDgDJBRs8yZX+bE1F1pPj+JiAAA916PLyEKCbIs4JValaMAq2+hqkXzOXrb5WlnNMRB761w1Ifi45hrvnxF5BKxP3sRZG0szNWcomXLqHcl9NjCI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mLPUWF2vfK0/bai6/8/oIOVA+khlzrPzk1gI2F46nQrl3tBQGYLf++f3S0IE?=
 =?us-ascii?Q?v/g283S391yl1AJW1JblyH/aZ0tStcoI1SUOwjU09rYe5n59UXCBf7HDpDXO?=
 =?us-ascii?Q?SHCNn1eWD3hXhFaYH/+JMm99Q7XK47tYUDx9PsQ+YR5zTFcfovZNX0iQkazM?=
 =?us-ascii?Q?Knewhl2mooRtsVcz2EaPvOY5t9yiKMaC9P7/zyYMgV8cIBZOgrQ3owuWNg0c?=
 =?us-ascii?Q?xJlcgx8B8GR7+GHRR4qku3gLxfSalJHZ606ysfGG3iFVH5i3V8wTv4QSR0EW?=
 =?us-ascii?Q?yR9lh21nG6ghlxa+JPGR4P6Cdj/ZCDLYcVcipDpHhZJAQzxFPo0AG975mbAO?=
 =?us-ascii?Q?XaH79h3XzxOBcTDIm7XGgvm5Qfl+b4ZU7Ffr05FOTUQcwoyuvIkZNBh3azwJ?=
 =?us-ascii?Q?LZunJNrY3DUfbb512KM6gmtrHPLWaJv6b1u9Rig+/4WirbxzE646ICUUkYhd?=
 =?us-ascii?Q?2mTKuthpoHpKkT+IrGbLD4drIv3+stSXUJ+8gcmCbVTEOTHphod9ueQxGoL/?=
 =?us-ascii?Q?UfMmb1dfs5elWClhfK+qwYAFOZS9zn0/4h5ggltzcH+qy5J5jx39d9fY8OiW?=
 =?us-ascii?Q?JV2DY8ZNpK7EMSDRDLnUasVFqwj4yeYhCu+Ab+ht/5HcrvfXcGMUCUechkbZ?=
 =?us-ascii?Q?c+K8Wy83zJ6CKSrEfYxHT60dmSTVOlwbTJ5DZJJZT7iqt7xJWIcdnIcho+kV?=
 =?us-ascii?Q?8L8C6QyqINU00BxdALfOVWnsIjuJGwtdBQgptQ5ZUGaGK1p6swAtNoaB6cw0?=
 =?us-ascii?Q?B+J+qb8gIByCMgA3Me8awv+wkDL6tUi6mutoqqcdR1QdIRxiqHmtZzZxAoc9?=
 =?us-ascii?Q?f8HntbWNTeTP7SAHHTFXYbS+vNPbXgD7YzCAVQ5VZ1ZCrEZVimK+oFoDGjkD?=
 =?us-ascii?Q?+S2qq78uOO8KoUQ8RxNla0z1LQCuHAecw1e48vnTk1jkx2VeEcvEixq+YWnp?=
 =?us-ascii?Q?FQWXAyt4bGlsoVPNd4F1qviX8WKzLT0P0YrivO6U6qewhozSXpeD9wVznQCZ?=
 =?us-ascii?Q?dkEiLEVx2nyajt2zMt6qj+qLevI+MOR4+QqmT0ykS4fuTjanN2x0SdkN/2QU?=
 =?us-ascii?Q?vMjIyqHXcEOB59aj5skNyPiYDpiL4oiHGeGB/7opRDGMGia962CK/Ox9gOdW?=
 =?us-ascii?Q?DUr8R1D0FI62J7tgGpMELdObn2bJNiErirzJRJm6T97shO2VEKyALlT4HrZY?=
 =?us-ascii?Q?AkNE9tKDY22hFv3lQKyiCbkoLVCiB7m3PLjzH4DKuo98fPJjrhoQIUZUK0NO?=
 =?us-ascii?Q?4ZRQmDzssibPeYhQBM+cbyuSQWk+rgTh+4Rv9p1mPJaqwod9a7ccE++JtpQV?=
 =?us-ascii?Q?32SAIHQafJbJofP1LztCAGMZSOFbHH01EgMHoqhb3xaDc0KggdD6ccMVHEFP?=
 =?us-ascii?Q?QbKenDbnYUOO8LovTMOJ9zrpzKZbKXBR1I6XqcO4w1M8Vbkd0vv3tBWi01/g?=
 =?us-ascii?Q?izwV6aBqcmNDYOxQz2+uQ+yGp1EGian2THjJDpD/alPfF5tny10J6DxXIVhu?=
 =?us-ascii?Q?DvHpGoxRAEf+o5fbp8v0ohdqi58epEx+HK+Iht9mH2ZJSNuXyuzfN7YgPl0R?=
 =?us-ascii?Q?PIFBU/LHVbDfcdj80b2j0Wbp1g4cuPyMcygmPO+hCI82iLt5hrA5tovID4xl?=
 =?us-ascii?Q?sg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 24215d4d-96f3-42d3-b87b-08dc5e429837
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 18:25:29.6024
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eFEhPX66Uk5xVJrPruhW1s/tFgWXw/JI6Ve2A2EdIPWfbIQzBJ2QEJtnoX/3LA31/eWnBqqPrHt2/glQyTgHbWst5nbot05xeQZ7oObiHVY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7388
X-OriginatorOrg: intel.com

Tom Lendacky wrote:
> On 4/16/24 00:46, Dan Williams wrote:
> > Tom Lendacky wrote:
> >> In order to support dynamic decisions as to whether an attribute should be
> >> created, add a callback that returns a bool to indicate whether the
> >> attribute should be display. If no callback is registered, the attribute
[..]
> >> Cc: Joel Becker <jlbec@evilplan.org>
> >> Cc: Christoph Hellwig <hch@lst.de>
> >> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> >> ---
> >>   fs/configfs/file.c       |   7 +++
> >>   include/linux/configfs.h | 111 +++++++++++++++++++++++++++------------
> >>   2 files changed, 84 insertions(+), 34 deletions(-)
> >>
[..]
> >> diff --git a/include/linux/configfs.h b/include/linux/configfs.h
> >> index 2606711adb18..c836d7bc7c9e 100644
> >> --- a/include/linux/configfs.h
> >> +++ b/include/linux/configfs.h
> >> @@ -116,35 +116,57 @@ struct configfs_attribute {
> >>   	const char		*ca_name;
> >>   	struct module 		*ca_owner;
> >>   	umode_t			ca_mode;
> >> +	bool (*is_visible)(const struct config_item *, const struct configfs_attribute *);
> >>   	ssize_t (*show)(struct config_item *, char *);
> >>   	ssize_t (*store)(struct config_item *, const char *, size_t);
> >>   };
> >>   
> >> -#define CONFIGFS_ATTR(_pfx, _name)			\
> >> +#define __CONFIGFS_ATTR(_pfx, _name, _vis)		\
> >>   static struct configfs_attribute _pfx##attr_##_name = {	\
> >>   	.ca_name	= __stringify(_name),		\
> >>   	.ca_mode	= S_IRUGO | S_IWUSR,		\
> >>   	.ca_owner	= THIS_MODULE,			\
> >> +	.is_visible	= _vis,				\
> >>   	.show		= _pfx##_name##_show,		\
> >>   	.store		= _pfx##_name##_store,		\
> > 
> > Shouldn't this operation live in configfs_group_operations? That would
> > mirror the sysfs organization, and likely saves some memory.
> 
> I suppose it can, but then you lose the grouping of attributes within 
> the same directory, right? A configfs group will result in moving the 
> entries into a subdirectory, right? If we go with the group level, then 
> we will be moving the existing TSM extra attributes and the new TSM SVSM 
> attributes into new, separate sub-directories.

I am not following the concern about "losing the grouping"? Here is what
I was thinking with having the visibility routines in group operations.
This is just the broard strokes, it compiles, but still needs the finer
detail work to make tdx-guest skip all the attributes that do not apply
to it.  Might need to be broken up a bit more, but hopefully conveys the
idea. Does this address your grouping concern?

diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
index 87f241825bc3..39b8455f0ba5 100644
--- a/drivers/virt/coco/sev-guest/sev-guest.c
+++ b/drivers/virt/coco/sev-guest/sev-guest.c
@@ -968,7 +968,7 @@ static int __init sev_guest_probe(struct platform_device *pdev)
 	snp_dev->input.resp_gpa = __pa(snp_dev->response);
 	snp_dev->input.data_gpa = __pa(snp_dev->certs_data);
 
-	ret = tsm_register(&sev_tsm_ops, snp_dev, &tsm_report_extra_type);
+	ret = tsm_register(&sev_tsm_ops, snp_dev);
 	if (ret)
 		goto e_free_cert_data;
 
diff --git a/drivers/virt/coco/tdx-guest/tdx-guest.c b/drivers/virt/coco/tdx-guest/tdx-guest.c
index 1253bf76b570..654d20ea524a 100644
--- a/drivers/virt/coco/tdx-guest/tdx-guest.c
+++ b/drivers/virt/coco/tdx-guest/tdx-guest.c
@@ -301,7 +301,7 @@ static int __init tdx_guest_init(void)
 		goto free_misc;
 	}
 
-	ret = tsm_register(&tdx_tsm_ops, NULL, NULL);
+	ret = tsm_register(&tdx_tsm_ops, NULL);
 	if (ret)
 		goto free_quote;
 
diff --git a/drivers/virt/coco/tsm.c b/drivers/virt/coco/tsm.c
index d1c2db83a8ca..b31be0e61728 100644
--- a/drivers/virt/coco/tsm.c
+++ b/drivers/virt/coco/tsm.c
@@ -14,7 +14,6 @@
 
 static struct tsm_provider {
 	const struct tsm_ops *ops;
-	const struct config_item_type *type;
 	void *data;
 } provider;
 static DECLARE_RWSEM(tsm_rwsem);
@@ -252,34 +251,18 @@ static ssize_t tsm_report_auxblob_read(struct config_item *cfg, void *buf,
 }
 CONFIGFS_BIN_ATTR_RO(tsm_report_, auxblob, NULL, TSM_OUTBLOB_MAX);
 
-#define TSM_DEFAULT_ATTRS() \
-	&tsm_report_attr_generation, \
-	&tsm_report_attr_provider
-
 static struct configfs_attribute *tsm_report_attrs[] = {
-	TSM_DEFAULT_ATTRS(),
-	NULL,
-};
-
-static struct configfs_attribute *tsm_report_extra_attrs[] = {
-	TSM_DEFAULT_ATTRS(),
-	&tsm_report_attr_privlevel,
-	&tsm_report_attr_privlevel_floor,
+	[TSM_REPORT_GENERATION] = &tsm_report_attr_generation,
+	[TSM_REPORT_PROVIDER] = &tsm_report_attr_provider,
+	[TSM_REPORT_PRIVLEVEL] = &tsm_report_attr_privlevel,
+	[TSM_REPORT_PRIVLEVEL_FLOOR] = &tsm_report_attr_privlevel_floor,
 	NULL,
 };
 
-#define TSM_DEFAULT_BIN_ATTRS() \
-	&tsm_report_attr_inblob, \
-	&tsm_report_attr_outblob
-
 static struct configfs_bin_attribute *tsm_report_bin_attrs[] = {
-	TSM_DEFAULT_BIN_ATTRS(),
-	NULL,
-};
-
-static struct configfs_bin_attribute *tsm_report_bin_extra_attrs[] = {
-	TSM_DEFAULT_BIN_ATTRS(),
-	&tsm_report_attr_auxblob,
+	[TSM_REPORT_INBLOB] = &tsm_report_attr_inblob,
+	[TSM_REPORT_OUTBLOB] = &tsm_report_attr_outblob,
+	[TSM_REPORT_AUXBLOB] = &tsm_report_attr_auxblob,
 	NULL,
 };
 
@@ -297,21 +280,12 @@ static struct configfs_item_operations tsm_report_item_ops = {
 	.release = tsm_report_item_release,
 };
 
-const struct config_item_type tsm_report_default_type = {
+static const struct config_item_type tsm_report_type = {
 	.ct_owner = THIS_MODULE,
 	.ct_bin_attrs = tsm_report_bin_attrs,
 	.ct_attrs = tsm_report_attrs,
 	.ct_item_ops = &tsm_report_item_ops,
 };
-EXPORT_SYMBOL_GPL(tsm_report_default_type);
-
-const struct config_item_type tsm_report_extra_type = {
-	.ct_owner = THIS_MODULE,
-	.ct_bin_attrs = tsm_report_bin_extra_attrs,
-	.ct_attrs = tsm_report_extra_attrs,
-	.ct_item_ops = &tsm_report_item_ops,
-};
-EXPORT_SYMBOL_GPL(tsm_report_extra_type);
 
 static struct config_item *tsm_report_make_item(struct config_group *group,
 						const char *name)
@@ -326,12 +300,38 @@ static struct config_item *tsm_report_make_item(struct config_group *group,
 	if (!state)
 		return ERR_PTR(-ENOMEM);
 
-	config_item_init_type_name(&state->cfg, name, provider.type);
+	config_item_init_type_name(&state->cfg, name, &tsm_report_type);
 	return &state->cfg;
 }
 
+static bool tsm_report_attr_visible(struct configfs_attribute *attr, int n)
+{
+	guard(rwsem_read)(&tsm_rwsem);
+	if (!provider.ops)
+		return false;
+
+	if (!provider.ops->is_visible)
+		return true;
+
+	return provider.ops->is_visible(n);
+}
+
+static bool tsm_report_bin_attr_visible(struct configfs_bin_attribute *attr,
+					int n)
+{
+	if (!provider.ops)
+		return false;
+
+	if (!provider.ops->is_bin_visible)
+		return true;
+
+	return provider.ops->is_bin_visible(n);
+}
+
 static struct configfs_group_operations tsm_report_group_ops = {
 	.make_item = tsm_report_make_item,
+	.is_visible = tsm_report_attr_visible,
+	.is_bin_visible = tsm_report_bin_attr_visible,
 };
 
 static const struct config_item_type tsm_reports_type = {
@@ -353,16 +353,10 @@ static struct configfs_subsystem tsm_configfs = {
 	.su_mutex = __MUTEX_INITIALIZER(tsm_configfs.su_mutex),
 };
 
-int tsm_register(const struct tsm_ops *ops, void *priv,
-		 const struct config_item_type *type)
+int tsm_register(const struct tsm_ops *ops, void *priv)
 {
 	const struct tsm_ops *conflict;
 
-	if (!type)
-		type = &tsm_report_default_type;
-	if (!(type == &tsm_report_default_type || type == &tsm_report_extra_type))
-		return -EINVAL;
-
 	guard(rwsem_write)(&tsm_rwsem);
 	conflict = provider.ops;
 	if (conflict) {
@@ -372,7 +366,6 @@ int tsm_register(const struct tsm_ops *ops, void *priv,
 
 	provider.ops = ops;
 	provider.data = priv;
-	provider.type = type;
 	return 0;
 }
 EXPORT_SYMBOL_GPL(tsm_register);
@@ -384,7 +377,6 @@ int tsm_unregister(const struct tsm_ops *ops)
 		return -EBUSY;
 	provider.ops = NULL;
 	provider.data = NULL;
-	provider.type = NULL;
 	return 0;
 }
 EXPORT_SYMBOL_GPL(tsm_unregister);
diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
index 18677cd4e62f..213e88f4cec2 100644
--- a/fs/configfs/dir.c
+++ b/fs/configfs/dir.c
@@ -580,6 +580,7 @@ static void detach_attrs(struct config_item * item)
 static int populate_attrs(struct config_item *item)
 {
 	const struct config_item_type *t = item->ci_type;
+	struct configfs_group_operations *ops = t->ct_group_ops;
 	struct configfs_attribute *attr;
 	struct configfs_bin_attribute *bin_attr;
 	int error = 0;
@@ -589,12 +590,17 @@ static int populate_attrs(struct config_item *item)
 		return -EINVAL;
 	if (t->ct_attrs) {
 		for (i = 0; (attr = t->ct_attrs[i]) != NULL; i++) {
+			if (ops && ops->is_visible && !ops->is_visible(attr, i))
+				continue;
 			if ((error = configfs_create_file(item, attr)))
 				break;
 		}
 	}
 	if (t->ct_bin_attrs) {
 		for (i = 0; (bin_attr = t->ct_bin_attrs[i]) != NULL; i++) {
+			if (ops && ops->is_bin_visible &&
+			    !ops->is_bin_visible(bin_attr, i))
+				continue;
 			error = configfs_create_bin_file(item, bin_attr);
 			if (error)
 				break;
diff --git a/fs/configfs/file.c b/fs/configfs/file.c
index 0ad32150611e..356d23b6b9cf 100644
--- a/fs/configfs/file.c
+++ b/fs/configfs/file.c
@@ -444,7 +444,8 @@ const struct file_operations configfs_bin_file_operations = {
  *	@attr:	atrribute descriptor.
  */
 
-int configfs_create_file(struct config_item * item, const struct configfs_attribute * attr)
+int configfs_create_file(struct config_item *item,
+			 const struct configfs_attribute *attr)
 {
 	struct dentry *dir = item->ci_dentry;
 	struct configfs_dirent *parent_sd = dir->d_fsdata;
diff --git a/include/linux/configfs.h b/include/linux/configfs.h
index 2606711adb18..31553f12db7c 100644
--- a/include/linux/configfs.h
+++ b/include/linux/configfs.h
@@ -216,6 +216,8 @@ struct configfs_group_operations {
 	struct config_group *(*make_group)(struct config_group *group, const char *name);
 	void (*disconnect_notify)(struct config_group *group, struct config_item *item);
 	void (*drop_item)(struct config_group *group, struct config_item *item);
+	bool (*is_visible)(struct configfs_attribute *attr, int n);
+	bool (*is_bin_visible)(struct configfs_bin_attribute *attr, int n);
 };
 
 struct configfs_subsystem {
diff --git a/include/linux/tsm.h b/include/linux/tsm.h
index de8324a2223c..a45b12943223 100644
--- a/include/linux/tsm.h
+++ b/include/linux/tsm.h
@@ -42,6 +42,19 @@ struct tsm_report {
 	u8 *auxblob;
 };
 
+enum tsm_attr_index {
+	TSM_REPORT_GENERATION,
+	TSM_REPORT_PROVIDER,
+	TSM_REPORT_PRIVLEVEL,
+	TSM_REPORT_PRIVLEVEL_FLOOR,
+};
+
+enum tsm_bin_attr_index {
+	TSM_REPORT_INBLOB,
+	TSM_REPORT_OUTBLOB,
+	TSM_REPORT_AUXBLOB,
+};
+
 /**
  * struct tsm_ops - attributes and operations for tsm instances
  * @name: tsm id reflected in /sys/kernel/config/tsm/report/$report/provider
@@ -55,15 +68,11 @@ struct tsm_report {
 struct tsm_ops {
 	const char *name;
 	const unsigned int privlevel_floor;
+	bool (*is_visible)(enum tsm_attr_index index);
+	bool (*is_bin_visible)(enum tsm_bin_attr_index index);
 	int (*report_new)(struct tsm_report *report, void *data);
 };
 
-extern const struct config_item_type tsm_report_default_type;
-
-/* publish @privlevel, @privlevel_floor, and @auxblob attributes */
-extern const struct config_item_type tsm_report_extra_type;
-
-int tsm_register(const struct tsm_ops *ops, void *priv,
-		 const struct config_item_type *type);
+int tsm_register(const struct tsm_ops *ops, void *priv);
 int tsm_unregister(const struct tsm_ops *ops);
 #endif /* __TSM_H */

