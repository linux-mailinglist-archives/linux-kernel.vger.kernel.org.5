Return-Path: <linux-kernel+bounces-134344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 032E489B082
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 12:55:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DB1D1C210F5
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 10:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 795FD23768;
	Sun,  7 Apr 2024 10:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V18iottp"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1563F225A8;
	Sun,  7 Apr 2024 10:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712487315; cv=fail; b=Mfc/LIoJSyjENW5qRQn+XGmTVdO3lNn80UWY9jXancLvGqlgOramjQ8VDeEl7Cp1Zszd4FWchKmM/gYr+t2XgQ27Z9ECMXqJShddMKJhJfFRlsn/yrGJI9jowViCfkPXa2/JFs/Tyz2x51QNi+JD6S/J1+jm3r3dQSMIN4eUzEU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712487315; c=relaxed/simple;
	bh=2OYU2oF3VGflVK/JdrjY8LoumYbs7cmjs6YN8VdSHe8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uLK4KgZY8vrAw5+tzA5uhH6T8mMEHP9zj7dmT0CwEgvhLw+v/RCTfdEZoYteeG2mLGJtpUbqVwEMB1s6X0dxXS3VJxrrZCRHXmtBCQKiQj120U5k3RCm0eu8D8RevLJnGiq9i7SV386pV8LLFeQBE+wwnkQuTfsWek8WCZ51vQM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V18iottp; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712487313; x=1744023313;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=2OYU2oF3VGflVK/JdrjY8LoumYbs7cmjs6YN8VdSHe8=;
  b=V18iottp+8HHhwlGtxs9Eads/bYEU0oOMNgLeeCt907dngTL2Jh07cGE
   aHCiVSieB19KfhY/EklaA7xOCTVaMMOx3aH31w2mwbVagvcVN811QB7/f
   xIdzI9ORcY9ft93FQz4QBxSzxI75HXXzn+3FHcCTFBKpUvPgkS1X4UlaS
   KctwJmRFB17YjNDVLVi47cddU/Ttks4vDSW+wcP1n5Y86qtNIzH+poqax
   +Brs1pneJsmYVfnvy6DFptp5kcisATX+K1Ecld2F6gUThRv5NA6cGFXVE
   hyolEuz7zT5UQRAE1zPyjzhfidk6dko1IItey7E4rKy01aydKNpGGSfB5
   A==;
X-CSE-ConnectionGUID: pxtxflFQRMOr1YafVZbQUg==
X-CSE-MsgGUID: P3ljBFvlSZKmbyhECi3AVQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11036"; a="18390015"
X-IronPort-AV: E=Sophos;i="6.07,185,1708416000"; 
   d="scan'208";a="18390015"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2024 03:55:00 -0700
X-CSE-ConnectionGUID: bnS0PBImQ/+uxRHcjkHB8w==
X-CSE-MsgGUID: mTjcjgaPRE+hiVRgJwPyKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,185,1708416000"; 
   d="scan'208";a="19534102"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Apr 2024 03:54:57 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 7 Apr 2024 03:54:55 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 7 Apr 2024 03:54:55 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 7 Apr 2024 03:54:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AZOT8jF6GqfH7fVmXs9AkIEKeaaWU61M6TlmRywUOnTmrgbJSeid/xTPQHlFP/1xIrEejzYao1WoHboYR+wjitZWgA+n2KGj24lclZE4IU+o/XRVMX4a71pXTb0N93/gJGgGysHISSoNxXMrWG4muF8l28JSp9mJOt75RQ+OeG06ndYgwPMEhYmJe/g0HCdzlJNoOwwyPFkefMDLtBkMzy3EniHshmIqBDBzRS0Zs4QLa9HU3+8cjlnrqIesRRaaSgXaaUOx2COUZ0aYsKrQpf8n6+913l/dUCvjQs0I57DDeuvJwzp8ff3z8d9/8qHpIGByRq4MTu+G//KqGqJm5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hr9nmO/sfc76cJ5E5JehsO7jOKoHyns2Ur6wSwJ9/QE=;
 b=ltezBYA6UlJcOFmSafN2ATLZbRYKTFbC/cbqtsa4QD98zLRyRJ7/DdFwCckJMLhLnPpUBeGwkSxgSw+Yn3cM9cFflB73Ik9VubN+Z+I1EXJhvVirfPb832pG6QcoP06RkQFrHvvM3OG7/+d6S00Ts9MAZUVAsqPiFD1xgWBS7q5W+tAO3Zs3IBUsZzgHYCgbyAfl6VxcaZmGykLNxD+wyN0PA7YNp8cU7wY3Wrae8wbtF+XCYvjWBC4/IoAg1ws7cjLz7aDQPmM8wvCpRGhU3wmz98F2X0X23bxuIoASm7K2B8KTYCvs6oBiNxIEl1U59pGJxrN0ygqxxARv8l1rYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by PH7PR11MB7961.namprd11.prod.outlook.com (2603:10b6:510:244::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Sun, 7 Apr
 2024 10:54:53 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::3637:7937:fc13:5077]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::3637:7937:fc13:5077%7]) with mapi id 15.20.7409.039; Sun, 7 Apr 2024
 10:54:53 +0000
Date: Sun, 7 Apr 2024 18:50:13 +0800
From: Pengfei Xu <pengfei.xu@intel.com>
To: Alexander Wetzel <alexander@wetzel-home.de>
CC: syzbot <syzbot+93cdc797590ffc710918@syzkaller.appspotmail.com>,
	<dgilbert@interlog.com>, <jejb@linux.ibm.com>,
	<linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
	<martin.petersen@oracle.com>, <syzkaller-bugs@googlegroups.com>
Subject: Re: [syzbot] [scsi?] WARNING in sg_remove_sfp_usercontext
Message-ID: <ZhJ6ZQc8KkOX01CW@xpf.sh.intel.com>
References: <000000000000a6e0450614b960ac@google.com>
 <00000000000007e8290614c036a6@google.com>
 <Zg6HlGO8ZyRQZSUA@xpf.sh.intel.com>
 <0c2ee56a-13a6-4d93-8c45-f43f551bf1da@wetzel-home.de>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0c2ee56a-13a6-4d93-8c45-f43f551bf1da@wetzel-home.de>
X-ClientProxiedBy: SGBP274CA0001.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::13)
 To PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|PH7PR11MB7961:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 482jrdzeujcYW3wofnWV3G3I+THzh2D14Y2K89ppnTXh6da0WkY+5llRsfjJyPbb2u7+4aOyFQ3MQKmKVYZS8IaEJ4zDIMmaKfXVzgPpActagEPimgRy6W9xRnzRmFubWeF10ZXrseXUavAmDyeFAXEMAM+Jv6SJh1EatgqYrq3xO8BBs+CaAS9bXnxGsaP+IQwAfS8Sgyc13cSqUGVy61AS4n7kiJ9T4eLzXuy0m2bo9JIrfEBC7kqTGMHMIIhBAv/q35vZPGPaejGuaVrEVpYnmFRWWZqYar4l5uZlN/C08y3rjx95TRtOTEEKPDsYABJzwYjxufugc7wLxZECRZJHU+F8D+P1HrW/gdgdwAmswWViQwmBWZNMW8UIcxnpEyAIUk7PpCq9SoNswn4+s/29WRaF34WZ2YivHkOz5pNMlT+TAG6WVwViEUoG8jSVBDDZge/qDAtnGVyBB74JCR8PQxh2RoVtTiq+h6fDhJR8aOent9FJfx7cgKYdB5ZhrW2JrncVk/PdUcYkRfebn2dJZ0tdRg56r/bQYpdT6NKpBOfYZiReLdjuob3juh51a6RnEktJ1IcqGlOdm4P1N0qkAD1GGHhDEv73xiMMzh0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4839.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ta4rNUbgsipHWiPNh7S3AQZ8vu2bsCCdjxgCppABzGRV0nTiWODMksnhb9MV?=
 =?us-ascii?Q?vYBdDKrr+gj7vJNKLVxeAF7DyW5ai+KviRRp6ILc1XWj1+KK04/ihh9wUieI?=
 =?us-ascii?Q?+vFKBElzW5XJy8VeAeW0Tcy5RlwwwI8OZygaeh6y1YLh0G9RvwNt+Jqg1Lk2?=
 =?us-ascii?Q?86Q2NoPYFOGLDHtxGWjHIV2/3d85Vj40/lgtcU+Y0f0uR6BJe08TrIB0b0Yp?=
 =?us-ascii?Q?jP6Eba7gm36iKGMjCcxJBfKylJXAmOW/+gw9MzfnHn6WsR98BQZCPtdQVzeb?=
 =?us-ascii?Q?3dUunLjTfDHUk+Lb6crkQc7HxAIWRG/TsGv4/Rx8nFXhM+mrOETQh9jU03Xb?=
 =?us-ascii?Q?NiO2qYPgDZ5m/nXnHazerTeYEDCo2CHkQ2N4Q6Juyq3JdUOGZ+ziqMjlqLhj?=
 =?us-ascii?Q?J7EyQfXRRzHy4derW+7/wUdrFPGE77jIU1Tgv6f5HNhyzh/MBIxDVjBwTbD6?=
 =?us-ascii?Q?kN/QnADBjwluYWdZvdke5kuw4kOpy6bLFXklQQpvizdPSmxBo511zLOzGmQE?=
 =?us-ascii?Q?Kpg9le5El22/70c7mVXF2fXep7vC9Oe/VUWGHY+/TK33uAo36Blts2EhFg0a?=
 =?us-ascii?Q?DfEYEirYmVxMYFF9CkY+RLUjMxzoN3OF8F5zvjIILHjlJxN5skvHX4vq9voj?=
 =?us-ascii?Q?XcAUGD2+VYpeM9rUpjtZHbSrk1ie+9nRCey1oY1X2JSwxhBhQzbuy4ZP/Iam?=
 =?us-ascii?Q?RIeKzrVQU72LGRkDxzUgkVHJ9/iD9uO6brEMiRYXAkRyopMdUgOaeYcKP9XW?=
 =?us-ascii?Q?NmjUvTBgITQ+Z+gG5Lp3CR61YUcUYzYT+JhIo/mLbYy+ah8DJ7yEP/1OwNQu?=
 =?us-ascii?Q?iZ/IipL62VOZchWBRzERm8e0KtxmEJlhujOiMUVuK2uKq8ARMNmIl/odrwSj?=
 =?us-ascii?Q?h7ikOSjr65y2lggsN6nu0/rmmDJIaLSZ7ghLT9/oHRnIjvHQQsIGFAu4+Le0?=
 =?us-ascii?Q?Jq9YbHAR0UwVhI1exqwfKBbQyZbBNcpWG+5UdUSStBlPMa2KSYnDVLZ6ydVs?=
 =?us-ascii?Q?d5gt2u/27Y2IM1zJfpzPW+zXySuwrx4h/QTwWmM5qLiMqBGdN66T7briBfoD?=
 =?us-ascii?Q?TghcK6NfRc/are/cj2xdiRWFWRX907DDWxoKH/x/vdcM9SLgRdTy/3xERiNx?=
 =?us-ascii?Q?j10fqzvcDkcmASZZClUIU4OVtHh3EITpgB05KLUVe4VXJe5tK1ERUV0loROY?=
 =?us-ascii?Q?To8gtXrMyH14LQOP3tAo57Zi2M5Ixy+uZnNHTR0VH4jZ/6Eh2YdtjnCZRBQ3?=
 =?us-ascii?Q?wdsIGppOkooWdDbLj3cRzMbmvYoOKNLxKJ0J5p3QeiRrmqQs3+7s2YWqcxrD?=
 =?us-ascii?Q?m2kw66Bp4Y77fflxubgdsfmVUB0LpP5T4aCjbO4duPxZVaOPdBx+9ZlUkzF6?=
 =?us-ascii?Q?KLZ5eMditvpeSrd6ZcuPI4sXi3XyAnjbA5XqkLPp41dVlZCHYCV1kO+9Ws4T?=
 =?us-ascii?Q?23wW6PKU23/nkbv+7m1NYFrb7I4SPc3sUPlDio/oc84Lehznq+zo952FGL9F?=
 =?us-ascii?Q?pgKuZfvoJnXfv1346s5xaEPq6OFsLgEvH6cxHQbVjdwOXSpT7cFYqyAZ/Eme?=
 =?us-ascii?Q?R4+aLnJZACrDZKgcyPr/VryZaabWj84AeAiHKyWd?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dfda5da-5c09-48eb-4901-08dc56f127ff
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2024 10:54:53.8945
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HUTjjpWtApL9E7lAVRR2FTlwnF29ifv0Y5ECD/HxlZvsVd/LdzMqlDH+aO8DrqP/RuLB9gxbmOg6tqbeablktg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7961
X-OriginatorOrg: intel.com

Hi Alexander,

On 2024-04-04 at 14:05:12 +0200, Alexander Wetzel wrote:
> On 04.04.24 12:57, Pengfei Xu wrote:
> > cc Alexander Wetzel,
> > 
> > I used syzkaller and found the similar problem.
> > 
> > And bisected and found the related commit:
> > 27f58c04a8f4 scsi: sg: Avoid sg device teardown race
> > Reverted the commit on top of v6.9-rc2, this issue was gone.
> 
> There were now multiple reports about the issue. The first (main) discussion
> and fix is here:
> https://lore.kernel.org/all/20240401191038.18359-1-Alexander@wetzel-home.de/
> 
> In a nutshell:
> The new WARN_ON_ONCE() was a (very) stupid idea and must be undone.
> It's ok to just drop the line with the WARN_ON_ONCE(). The rest of the
> proposed patch fixes a much less urgent issue.

  Got it, thanks for your description!

> 
> Of course I can also break the fix into two patches, when this speeds up the
> merge...

Thank you, if it makes sense and accelerates the merge process.

Best Regards,
Thanks1

> 
> Alexander

