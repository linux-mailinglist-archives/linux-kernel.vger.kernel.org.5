Return-Path: <linux-kernel+bounces-152950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D3558AC686
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 10:16:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91DB01C219C1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 08:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E383750283;
	Mon, 22 Apr 2024 08:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jzB27XhI"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D47150281
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 08:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713773778; cv=fail; b=KUXSMv0+Oe05lX5aTX84jalS9Cj6T4KTVpBFpmVfok0T0wtJTSmORinexFCT7DHh85fT2nbWd8BDoQIEm4UYs9GpMUdm9G7VH0tmXHK7POEx51w+Y+Ug0oxdui6xDMhDN8CKZEwthf6gPnHzpUjlDTAgO1bx3KMjMopeUn8Gexw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713773778; c=relaxed/simple;
	bh=IXZemTx2SLOnCdRF1L/5SSy45tdMpJ89vOIu8AzjjNM=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JnFTuXsX6MM/qiKz19uQL9RkAmmDE7fCgcBI9xhgrtAH7Whl06QVoX0QuJE+3gTexKKpnzjz5OWbAqbrMmrE7tbM0zwkl8J//psm4WNue2+ca7Mk6RYHKECEmCXhlLDRvJbvkKD3moKVOgc+2hxFl7ECZCPQJkTglTF+4X8BK14=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jzB27XhI; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713773776; x=1745309776;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=IXZemTx2SLOnCdRF1L/5SSy45tdMpJ89vOIu8AzjjNM=;
  b=jzB27XhIEgdeXh4unuYpib2+mmXU1imeQhnICICBu5vaFW9Ih5yN3DvV
   7hK+XRmTN8rwdFpcP6HLWND+rHWaPKpJOLBmBVXeR4CjArEZEBv3+hDlP
   DUjmCEyaGa7/lVMlhVqLyZ6zlHV+dF+5pBkBzVcfoGBy1PZjWGr4+vwF5
   1WmFeulXFOCCwHpX3ahDdtN5IZv+MY6s213ip02AGvXSDq1nxjMRtppgd
   dmZgeXAXz96GUqpv5UvJaqsxLnSPKNHbdKlI71wMgjhNlZea3yDZ/0AcH
   1Pe3n1GsWJzZlPaFpTXawOFLDOUai5pNnprMmOpD1NVHPIxtaehtInRHP
   w==;
X-CSE-ConnectionGUID: O/8oZsY7RCqnbOCfiWXFsg==
X-CSE-MsgGUID: fRTr7ckLQeahCg025DX9dA==
X-IronPort-AV: E=McAfee;i="6600,9927,11051"; a="9164621"
X-IronPort-AV: E=Sophos;i="6.07,220,1708416000"; 
   d="scan'208";a="9164621"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 01:16:15 -0700
X-CSE-ConnectionGUID: CzkLpnCiSNyCQqWU3nz1dQ==
X-CSE-MsgGUID: tIESjtAZRsSPU8ljI+N00A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,220,1708416000"; 
   d="scan'208";a="28452267"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Apr 2024 01:16:15 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Apr 2024 01:16:14 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Apr 2024 01:16:14 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 22 Apr 2024 01:16:14 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.170)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 22 Apr 2024 01:16:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j5j75vUT5NaGvrZiHxWox9s66NHWbMvk2EqZZUSmVfV7oIMu0Rh5oW+4IRYvfcymchl0fH6Sp0gQKuL06qTNminGBKK5JzwfIt1BZcD3bDfQXTFiCJ/skrQpGpHD/6m7LggGLod3B+KYFYi+qy0PPAaZmpeliNyGpA6m4Y2OrzFG6dBYNi50PIZBZ7w0bIUR+KPWlt29ZwbFPCtw/pt5wYz4ygDkfb4dvaxt0LMHcAVbwG9V4fCXcscgTTQTs/urBgj3Z1rCxrHUC5Dt0sqLGGTVtsDrIbz7x9GFjZ99BmwKwWsc/nbuvCa2M1Ivyd0qBqzbrQxcfon/Kl62pxe8jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=34/JwktTS6/bnV52wjk0jr64eFrjCRRD36bDkLowUg8=;
 b=U9EhAaT1i3sZ6/D+IIJY8ZD8QHD/crP2A4nS2jZKCb2bphQhEO7uMpqWtL1CAxSkGEIqMa0aHkefb6N+PIT1TF9eIXSXMT7mcldObGHLmjaz/+k4L0XLInVJWIHXd/UnpUUktjzOdcqE3DJFJ79mX5HaoBDQKq3j95fLg8o//FHjxgJWuSE6hY882tK3AsP38855Ex2zQAx/qgSPLDm0sR2Vf+XkZqW77RgDZEMJRGTtzEg08KsSNWSIKLWOmMotHSHv5Xs8jmJbCGFDhoLJ3Y3eAqF9xsGBBGKIXE9zKF2pKLEOL6k0lUC20EEUz5dKVXVHRUAp5ZBjzQxkKVfNVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB8393.namprd11.prod.outlook.com (2603:10b6:806:373::21)
 by DS0PR11MB7559.namprd11.prod.outlook.com (2603:10b6:8:146::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.20; Mon, 22 Apr
 2024 08:16:11 +0000
Received: from SA1PR11MB8393.namprd11.prod.outlook.com
 ([fe80::c0cf:689c:129c:4bcd]) by SA1PR11MB8393.namprd11.prod.outlook.com
 ([fe80::c0cf:689c:129c:4bcd%6]) with mapi id 15.20.7519.018; Mon, 22 Apr 2024
 08:16:11 +0000
Date: Mon, 22 Apr 2024 16:09:33 +0800
From: Yujie Liu <yujie.liu@intel.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>
CC: <x86@kernel.org>, <linux-kernel@vger.kernel.org>, Linus Torvalds
	<torvalds@linux-foundation.org>, Daniel Sneddon
	<daniel.sneddon@linux.intel.com>, Pawan Gupta
	<pawan.kumar.gupta@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>,
	Alexandre Chartre <alexandre.chartre@oracle.com>, Konrad Rzeszutek Wilk
	<konrad.wilk@oracle.com>, Peter Zijlstra <peterz@infradead.org>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, Sean Christopherson
	<seanjc@google.com>, Andrew Cooper <andrew.cooper3@citrix.com>, Dave Hansen
	<dave.hansen@linux.intel.com>, Nikolay Borisov <nik.borisov@suse.com>, "KP
 Singh" <kpsingh@kernel.org>, Waiman Long <longman@redhat.com>, "Borislav
 Petkov" <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v4 1/5] x86/bugs: Only harden syscalls when needed
Message-ID: <ZiYbPZ1biNCEndKZ@yujie-X299>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <982d05a2f669140f26500bee643011896d661094.1713559768.git.jpoimboe@kernel.org>
X-ClientProxiedBy: SGAP274CA0022.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::34)
 To SA1PR11MB8393.namprd11.prod.outlook.com (2603:10b6:806:373::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB8393:EE_|DS0PR11MB7559:EE_
X-MS-Office365-Filtering-Correlation-Id: 00cab06a-3af6-46a6-3b44-08dc62a47885
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|7416005|366007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zAtrfKKtvk6QJSTO+MKkpDvosOOBmuaciARkL57eRjM3upvoW8TxJhcgEj24?=
 =?us-ascii?Q?TrmAlMYPx4Tjroo5oiuG98llZnnXx9Xw/pPDCeYrdtT48k4N+aKzC5j4g28S?=
 =?us-ascii?Q?uEXUCqj7BXYCvNNqENXF0RjDefDsexhSrCzycoiX3L/ZNb3iaZJEswbQRVsY?=
 =?us-ascii?Q?iAf+Gs8m2enmQPDlj/ghGMxkWDLJujnpnGwejjFfE3RNvJe+0MlbUZdZ5j/O?=
 =?us-ascii?Q?tqEV1/zd46GOQJ0PNgijCzwFF7zbHYO53G+ljSCuJh/Dq5r0xlH+mNgPrBj4?=
 =?us-ascii?Q?eos5HattmUFZTDA80tS/UXJh8AtvINcuusKyHEWwOMUlVRoOm4ylo6xaCnL4?=
 =?us-ascii?Q?BeaxAZnBllaBcxyhfS6beC9cRieHei9WgbKCWxxsxtbPwjeYD/RKET7NCkvF?=
 =?us-ascii?Q?uSZVLaB85YjeH/+73Kn5iLdr6JMsS99qIKhZsMfmPM4+GrgjL4K3uW9gaJl4?=
 =?us-ascii?Q?/UtCgsgeZIIdO0Wn4j6HJrxUt15k4Ix16vYwxXBIyVanaHOosi9/WXjaaPoo?=
 =?us-ascii?Q?Y+DyujX0udhx94audetjIq44CIgAMh3S1xow74aSw2G3oGd0d7QcUs+N/eZr?=
 =?us-ascii?Q?jhz0CdNS1hWwjMwG4wD4NbGf3vkI7QFwsibAQzi0FV9XskYYVFVYLMnr/IDa?=
 =?us-ascii?Q?hCE2I1lGlYb9dfRpH6aHMJcBRJtSUVmn7+XDdrQ1GdSAkVPJpGrmzpk3UUHt?=
 =?us-ascii?Q?ZZnxvlDB73bndMYOKVZGqkMJdSsL/OLmwSISLHCQBKewmCCvZpB2d3U8hct4?=
 =?us-ascii?Q?3Fg4zVWNmzgJqhLuOUtAaV7J266ghLel+OdwS7dMlPFfasCWGQn7nYgEUEpN?=
 =?us-ascii?Q?lU6VmwQguzOXbgIS59tm5GrtJsfVtpEZErLNZh8JQZ23VK2/zRAxckn6dr94?=
 =?us-ascii?Q?3iz0WGlU6gTrJ6Xh1M40KfCXGTMNY8Sz+bvPZre+CVHzwD1H79IXoSShibDG?=
 =?us-ascii?Q?zm8oWSqBtuaN5gjLeX0pFmCCzSmRD4RWsluqSpqp384ga3N7cLYIeOBXSenc?=
 =?us-ascii?Q?GLGQ+B/H1Og6VAJsruulzNiZZqvuvZRlWkTZ8bG4VjNaDEuUyUZru2u8pRv5?=
 =?us-ascii?Q?Dr265w8N7HaOj+9w6hYiu+j1uR7x5l3SA0HRzJFuzvPW/FhNR3d/Vt78eWRO?=
 =?us-ascii?Q?NcvLirdGPVCMicxKhVWzGrCr4QXzKgGk/lPvnMcmDiXWZog2goDjarMtWkye?=
 =?us-ascii?Q?Rcq5litWCbnEVq4Ra31M9FwSMePMN3eg9N6Vmf+bPtfMUc4WmwZDDCBqfhAc?=
 =?us-ascii?Q?pP9VVttH+TmLt8FSbN06CcO8lAvc9TKYYlSNlNay4g=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8393.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FZzSqId8q/Nu1b7Ials9mue7N44OzFnhbeCjwRfiar0Q1ZnTFfJ6J69o8ee0?=
 =?us-ascii?Q?tPrqK5nSFJvqP9OsIgdoZjZHQApalMTmseHxR7QdVPnv57spFQ0vyQvS8ugI?=
 =?us-ascii?Q?djq++w3ubVztX/Fg4lBw7MUcEX7bh69ATK/NOt3tcEiK29ExAWwqPRXxP20k?=
 =?us-ascii?Q?4K5fmLzdEbvUPqPPoD2iO/rWIbr1NgpVku5pqX15KisPEn+pYl7/pEB7KbgO?=
 =?us-ascii?Q?RvxQYdfMO83wT+tqxc70itF3N42ktO82+Fwo6No/e8hCi6s3iYt3RBFLZTwi?=
 =?us-ascii?Q?BklLy4oUnLNJkLC4FbCccRzyGnTRDNv8XKEfGNYtrKxob6rlueqG6qHhW+y9?=
 =?us-ascii?Q?56mqe41PsZs0EDrh4YisXB32gs5+Q3l+OjFpHcJ+h+zqYjvquJm2cFFpDXQJ?=
 =?us-ascii?Q?9OhKYYPvqrjBQfsVuyOx5u+BcLSRXx3W3bbcfsQIlC6osLvYrWK4A5NsmrNF?=
 =?us-ascii?Q?woA2WzOAjEeW9d0Ut21fWc3dY/1jN5/GyrHTPURn/APMvDlVVB+JFRPYq/Ij?=
 =?us-ascii?Q?VJz6pxYtAGILG+ZqBJ+asAvzhxkqoQQM7/9WV+70Pd/88uTm3tCh6Q7ZTmr3?=
 =?us-ascii?Q?tS8TnjGhAgKy+dnAhAhJJf3lZMjhag2GZi/uErqBDY73af5+nrRSCTNk1trR?=
 =?us-ascii?Q?UBKvR683UnvjevswH9UoAroU5vLTV1MPh910K4VfnDIbTN11zZ0XSNl0d0PE?=
 =?us-ascii?Q?+db0by7bij+MVQKSMR3mBIbY4F/x90M/08CiRkT03f5CTlzsZJTf941Ut4aE?=
 =?us-ascii?Q?JZESokxPQJBnUmhjrJ3P9rRXyvQuSZO5Am0qXPUYLtMA9ZBmEEMoIXhLcOm+?=
 =?us-ascii?Q?B75lUwvlj3WTBVqEGQPyVLaYHYtXLQH4dbG6quglH3HdhJGTltI977likDqa?=
 =?us-ascii?Q?druxsnwf7tVkrEv/wp9ZFmh0DbtCTuaWinW8b0WMkb1QylGyicokHISM4oFF?=
 =?us-ascii?Q?K9tgsu2QzjtLnGc+TZoJqjQXdzw02RTDCPCYWLXBU4txZjus5CO/m2dWuEB2?=
 =?us-ascii?Q?cCQvw670soFUX90OtePRjV4HIkIWgUslNgvykxooCKBYjlihOjgtkKZyB+9U?=
 =?us-ascii?Q?SiMFJrnnIkeDZSlqATb8+j1x0Uy1rSv8/cFTidSQUDJIcv8z/ZdJFQiu7TKw?=
 =?us-ascii?Q?WP8hEEpnXZIGaOP4KbymGCZ39OHN9c/cKy7Br1GdNmQ+z/Ubltzbpa/lC7Up?=
 =?us-ascii?Q?i4ldXtsDXXmlXCgaRp77S8itT6FGjZ3Riar5qpqZHRGtllp6L0WvOQ7ARy84?=
 =?us-ascii?Q?XtLksdWbpoYRwQB/vEektMa7SanFUdHsYf4+sWDqB2X0C2h8+SgED14pguT6?=
 =?us-ascii?Q?IJfg6Qon6Lvf/X8m7/9RoyxTZypF8tX7B6NfRXH60/EHEh+BvzWk2tmJVGrD?=
 =?us-ascii?Q?yQ2v98oVS+YgctJ1l4j/3/FJ4Ww+7ljQpqH1KviJwL9Pm46Sa2/motM4KbaQ?=
 =?us-ascii?Q?Sec86yFo1WIxGeDBwuYO9j+ixwPNPoExKpu5sMkEvSoXQAu7AecOup4MYC13?=
 =?us-ascii?Q?pEu+kcfkvgvnlynFd1kgKwj1R21zmJKqCGXbp32C8qInXXFJyoLaAx45byat?=
 =?us-ascii?Q?jxTJldWanCrUJ9Tk18pUkjZT/KXAlOWxiCCq/xYe?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 00cab06a-3af6-46a6-3b44-08dc62a47885
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8393.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 08:16:11.7631
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a8X+fDTJx0fP/ZkLMO3OXZA268YMnhEe7BewkcdlbjU/60qlZ87D/befk+DB0ULivHFRMATDy0pf45EFSaxZTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7559
X-OriginatorOrg: intel.com

On Fri, Apr 19, 2024 at 02:09:47PM -0700, Josh Poimboeuf wrote:
> Syscall hardening (converting the syscall indirect branch to a series of
> direct branches) has shown some performance regressions:
>
> - Red Hat internal testing showed up to 12% slowdowns in database
>   benchmark testing on Sapphire Rapids when the DB was stressed with 80+
>   users to cause contention.
>
> - The kernel test robot's will-it-scale benchmarks showed significant
>   regressions on Skylake with IBRS:
>   https://lkml.kernel.org/lkml/202404191333.178a0eed-yujie.liu@intel.com

To clarify, we reported a +1.4% improvement (not regression) of
will-it-scale futex4 benchmark on Skylake. Meanwhile we did observe some
regressions by running other benchmarks on Ice Lake, such as:

    stress-ng.null.ops_per_sec -4.0% regression on Intel Xeon Gold 6346 (Ice Lake)
    unixbench.fsbuffer.throughput -1.4% regression on Intel Xeon Gold 6346 (Ice Lake)

>
> To fix those slowdowns, only use the syscall direct branches when
> indirect branches are considered to be "not OK": meaning Spectre v2+BHI
> isn't mitigated by HW and the user hasn't disabled mitigations.

