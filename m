Return-Path: <linux-kernel+bounces-154350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 552838ADB0F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 02:26:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07491286CCA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 00:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F39A219FC;
	Tue, 23 Apr 2024 00:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hLUMvEeB"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B27210E7;
	Tue, 23 Apr 2024 00:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713831614; cv=fail; b=PFwF3D0dR1HOjyRiM3jK8NlhRA07m/XxEQxKbPvca1NmdP8ruL1k7qxwqpleJFwtuhFvRcq4dPaWP2AxHo2RSrgQ0jz+9rafmUASYYE36RopK2s/Cv5+hNPIIeGyEBs8MbIk73jxzpe2MBNP9Zbqux5pvd0UWZeH6WbyWgUpWZc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713831614; c=relaxed/simple;
	bh=iKAIojxVsaW/riwkb+3ArWUb9KFfK8R5P6T84HVffWE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WnZyAFvkP+kc0NAY3TgVretNXJOHTqmg7MGmRJONf4fiLnus7lZMZudlyLQmAIVuNQ9o2iSxYiAo8te5J+61SMhg9gFFEoDce2J1W7bEac/hCTYTicr1sYsgH6SyJ+XZW9Tk0n2XMOWJclBMMAm6WwKfBhGduN/r70FRDNsPnto=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hLUMvEeB; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713831612; x=1745367612;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=iKAIojxVsaW/riwkb+3ArWUb9KFfK8R5P6T84HVffWE=;
  b=hLUMvEeBLv7jSJhS0fk6yYsxnrEKF+NBkRTlJUDSs6YkbWGDMP0mYsTQ
   4CNTd33V9yT9ueT9dXrFhJYtnsCdGy84kCDfIyOXrWE30zV+X4WsJ0axj
   0VJb5poOUAy3zhE6U26d5bfeslqm/bI5F/H6EogmCLYSJCAQZ2U2euDez
   S9EiJiKoZKKcV7xyvmT6WM+eqeCYLaPCbMdjobrH6nFy2p/iALc2LSeYN
   Ae8BOmIhsY7h2jL3MJLrY4q14Ct6Etp1x94hD3Ra64ZeO4vFCCm2haMUj
   sSP3rF8D6l8x6vlhcAQ3J5QeCzeb1JhwoDBjHdK101vRiJi8wPkgodLT1
   A==;
X-CSE-ConnectionGUID: FoDdqlN/TJ6Nu0kQmx/H3Q==
X-CSE-MsgGUID: /5ecAxKqTO+fPoZOkpEW8Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11052"; a="9263478"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="9263478"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 17:20:05 -0700
X-CSE-ConnectionGUID: LQ9Al1apT7mMKdjWcMb5ng==
X-CSE-MsgGUID: zh3x6nxqRA+XVDXUEnSekg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="28698280"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Apr 2024 17:20:05 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Apr 2024 17:20:04 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 22 Apr 2024 17:20:04 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 22 Apr 2024 17:20:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KAKqTM1KxYdvJm+Q1moAHGd7a+LTZiiFvGe/hKEPIQ/u0ppYHGWltZCst/DkV5vY4vik4/sY6jfn3k/D/YhaWpDZCXgYOove69vIuE2Y7FuOHgMf96Cm9cARSM93GkQNMVAx4IG8XdShG5dOswmj/+wBOAD3l5xdTigl6E6BQxuKj9c3hgXwATIFNmsPjrv8zOdAO2fWR/lW3CoF1lXwhrwNlB8Z4ziMsReY4I5GBdOFI/wvygcqQEsEbNMUplScjelPINI/ReB+LSA2uOpChrRyOvWbAG0MvNqRvlk64InCKFeTJHOX+mdfEGjoUfvj+4q08Dsoh7W/pE+ZKGjEhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9lly0Wxzj1MFcVrQRxGrxykiQq/nBpcweu7VToehltI=;
 b=hqCjvMh1O45O1HuvKZVDGGOwTxFvVMI0B4HDbamAbljXEj3fzR6Ce1R1s2QVfVCNhXWlkuX8hk3Yvv5VpUcRgaFyx8PDo21dkGrr8zyRfqcMY0Z6bF1WE0RblIozOC6xmA91b2fiA3ZqCszb7xnqyNzAAcNMsk/GhcehZcnVoTwtEAgVlsWAWuPN7SvZS6Ls6NuIUhi0sgHBh14dsTSTyEOZopgbrX4xJf6xMtL2OjnHbRFiIGi7Lc6SGeJRvGV7Zjsv/AJooMwSa0JERjXGB6TTp1bjOOp7CG4jQ/6oE4PiSQu9SvsGyGBLNdpLULdwGsolAVmsg4K6G03MmjpKnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA1PR11MB6099.namprd11.prod.outlook.com (2603:10b6:208:3d5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.29; Tue, 23 Apr
 2024 00:20:02 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7452.046; Tue, 23 Apr 2024
 00:19:54 +0000
Date: Mon, 22 Apr 2024 17:19:52 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Robert Richter <rrichter@amd.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	"Vishal Verma" <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	"Dan Williams" <dan.j.williams@intel.com>
CC: Robert Richter <rrichter@amd.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] cxl: Fix use of phys_to_target_node() for x86
Message-ID: <6626fea88c0d1_690a29479@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240419140109.1996590-1-rrichter@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240419140109.1996590-1-rrichter@amd.com>
X-ClientProxiedBy: BY3PR04CA0015.namprd04.prod.outlook.com
 (2603:10b6:a03:217::20) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA1PR11MB6099:EE_
X-MS-Office365-Filtering-Correlation-Id: 22d0f0f4-2428-432d-688e-08dc632b19ca
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Sh9W0jsvDlwiHD+CCkBVqyIRYEuSG63lG/Sj54o+DNaDfDoZP9VP6shgoeLq?=
 =?us-ascii?Q?SVuf9mrpcOGeTWLYIRNPbzcTWSP/6fMoWab/1XD+L/D5j/GoMF6sZrnYpFlf?=
 =?us-ascii?Q?t1w6uhjWBQ6zWn4BQKNtg3uBkXIjv9vAztvBGpxVNPLfwJ79o44gb5lgVHm8?=
 =?us-ascii?Q?rcCn+Hb1OnfSjn9hYFQRXQOLlX14v3mpOFzPt5PXs4hj3MoCTemt0R66SpCV?=
 =?us-ascii?Q?snVfbzsOz0wn75CT47J7tnE+0ttcoHLZYCefxr4FtzLYZ1rQfV39dwbM+tPv?=
 =?us-ascii?Q?a3aX9p8X+c0VLqoSliayOJYlmygzQnUJs+FYhnKEnckYrpuR8RmF0ebUaewH?=
 =?us-ascii?Q?Gh3Ymeqkm35Kb/ocuBTq1qoXYcT/zwxeY98+AEPnYfblDiYBN5XgnzQQ+XcZ?=
 =?us-ascii?Q?KOScfsYPtG6tqj3pF2qSxWjcPMlK+h1CyGlNhaO6uIloRhhsvFMzRMujQnpO?=
 =?us-ascii?Q?MDzi02X4AUKOwQ6IDQlTNIHl5fjtDrR+pmRsH6d8Ellfeq2I3Hox/ELhes3W?=
 =?us-ascii?Q?WvVmt7AcFnwyt/g8TI5M+ywPQMUZecwv+C6zuv4IUMg/XrQpxEwuC2ExMFUP?=
 =?us-ascii?Q?LIZwIfdZL5re5bV021qCtN86V9OjwZ3/Dz1fmDukHRDkqD4Dyht33dUYG+fp?=
 =?us-ascii?Q?Q8pmHBZvLseFh50BWF3oTIKfatuaAG3FPaUg4feLZ9Kbat6UNp+chk+j7+/D?=
 =?us-ascii?Q?FYnwDof6HiyemTzNOvkqd46fvgLctDko6enSwEg827tErdfzf37G+VYgoTUA?=
 =?us-ascii?Q?82y1BQhkbEyDLaTsU0US3uMcPoSwPkapaWcl6jJxU0BMUDGT1p1hA/nvHSBJ?=
 =?us-ascii?Q?+GkeqTj52pcvhpk2OiOLwQ7yINdgWhFeZR6bb2uu0R7ocgVtXSJPl8HVJbd2?=
 =?us-ascii?Q?c3qNdoqBVTT2bWOHXNsMBqJDtvrM0/Fq3Xg9yP1g4dCkpC7AgSLb87WNaErU?=
 =?us-ascii?Q?J/ziiBAgesapqH/SfgbLjThRvZeFdPgn7dHyLfDNAhEP93kTxK1/FHAYMga9?=
 =?us-ascii?Q?yvNtvIYbvS36aJCmSxORLs2acfKEIIqPCR0GGYot+kGuoWR0Ie+xd+b9V3SG?=
 =?us-ascii?Q?HeQS3spH5drMe3FqlMjqTX95RO6Ibk94eKzYGGU3duCrBvRgG71YwmJWvLJT?=
 =?us-ascii?Q?h4ZZ0kTfS9btYzQPrO1MDXhHF2EQKLFZGbvhTMPun14li8+1qAPpj4umGcsN?=
 =?us-ascii?Q?EHrdFthmI2fkAC1i9MFA+AEnlQwgpV9pP6Le7lD93W+JABG61skJ/i92GG7k?=
 =?us-ascii?Q?zz09AN+L+v9wvzLZUNRTP6bE1FcZoZFSk8LvhPMKNA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9Th8oR3pJfi0BYhAMs7D42s+L5SMoUr7JHEb5Epl52NL2lLgYQgWGIbKGhdn?=
 =?us-ascii?Q?TfWVZBOC/wu6arqglKYA0S3Q4fEzeGO6YB7HhEp1j4X6I9DlezVrDe0nvKp0?=
 =?us-ascii?Q?wHUEpR0GBnFv63VNWvbA91Esk0ReG2v5Y1XVd+GU8TBek1PR2Dr0iiVTGKZ2?=
 =?us-ascii?Q?JSwMcKp52HpM2HRpdst5D8W/yFMQarde7FeXlb4u1ur6GmoeuBdTKyPNRa5F?=
 =?us-ascii?Q?n2/3RcicZHaXiuDeLzG7AOAUV6g7V6d2Jbx3p3Q5g1Fk3CFGAcHI2kgoTgtF?=
 =?us-ascii?Q?rj4V2k8L9SjZZ0jFFvq6z6T30Cl99pT0ZPU3fd4Vkq1SdnoU+wm46vj9cRSX?=
 =?us-ascii?Q?Kv1EZceAzauyeSrnU3AAMj4CB+3D9BedMXxnHQznQtq7VdltVnvbn9xNDMf8?=
 =?us-ascii?Q?N0rRytRKWuDsCf7HpvUPwz2kpNNdM72wbUwp46+Wp89lYjcEQc/zlaWlpvBT?=
 =?us-ascii?Q?ErpcvgO4f927d5JX2GNuhbT00hbkffFLCaiDJ2DqmrObCenmnCI1WHteNaCz?=
 =?us-ascii?Q?gLEXhGgKlV71qs9sL9JJeQDltkqjAavzEJcO2rxFAVFCmoFhNsZ0JqFNTDdN?=
 =?us-ascii?Q?niDZigOel+MBrAiVY9Yh/9335VQnlPbF77qVu9QFXBswJtz2EYm0kMUblIDL?=
 =?us-ascii?Q?5HVffLLyLa3u9JSawVmUxLPQsYD2ry1naIokH5aPVYioAbeD7Pp+AoH1i1ke?=
 =?us-ascii?Q?LWl7av1lzF0mJwGToQpxtIVL9tC3mxUYFhGb+UIIrEu87+GMjyXHxtwv29CZ?=
 =?us-ascii?Q?LgeiUXIyCixxMulxQtwQhGw33+ZjwoiXd/PyEQCFLjiIoM4k9yNn5ltP829+?=
 =?us-ascii?Q?u7QtsypmnWxDs3PPwJSGdPaIPKgbEN9YTglzyGhUQlo5lP/AinwZWjOb7qwl?=
 =?us-ascii?Q?vhEv8EcvlBEKu3efyeHWHKCaZ+DE15wI4wUZkAQ+IIjV72v1eh3dyMLztbvb?=
 =?us-ascii?Q?46uRdPoVkkC3Vwa1nCpkJ0SvJAz246TfyX3rnTFeT0NocuBfiqflUBt2/chm?=
 =?us-ascii?Q?EDJfhI2etRw9iNBCLGmrk5eBRaYbTwrrQTVSYCvwvJMbF+iQou9OV0+mZ8cS?=
 =?us-ascii?Q?vsKV1ZpH5GKzprxZjBcKYgokBO2JAxtkVYY3JmCGvFW3fcjbsML70iU6o6h+?=
 =?us-ascii?Q?iHC6FfRYgF+C5U67FxU516PInoehbpLtvM6KpUeHatYdL30E8/Ou9f5i6sRy?=
 =?us-ascii?Q?PELheEN6oB8uZSXzHPWeIANdI0aIYnFd46i69h6fQ7bwiLx29vIYEGeTqFp3?=
 =?us-ascii?Q?Wt7+cNNUtEmwCjOpDDlFzIEOtGd6B2/wb0ca3Ki+xTnxCiJlce+DxYpDNHUG?=
 =?us-ascii?Q?y6XG5xuWRmBm++iKtX4v0P9/JTlI645kKO5bX1aDAvCZ1Sb7eRtCDbz+JcAJ?=
 =?us-ascii?Q?h4TlGWgDP1DkwMzVLLiaNotilSv4pYxCWDNjk05P7MSIUhu6tb5bAnqj04If?=
 =?us-ascii?Q?sSPcygkQGBMSGbl/keeMN8BhLm0B5ezI+1mr3Yzeo6+Dh2teb0KWHWwhkbaN?=
 =?us-ascii?Q?USZmM1Rf2/6A22HWhZZWHTLs8Qat23xPNgqHR4NHfl5sTCAJCEHhHYxfRv7+?=
 =?us-ascii?Q?uFA0Pwjq+iWVSwuaByd+7bdoR/QixoQdTaxGXWvI5PW6Cq4cNTNwm33FWr+f?=
 =?us-ascii?Q?cA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 22d0f0f4-2428-432d-688e-08dc632b19ca
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 00:19:54.8506
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dysq6Eh2U2CxCbd5WAFAY8rTiyFluNHScXTZ7RbR+mC6kcC87nJMOAcLiqL5O3suKY3tu2OVfrQ8xb3C3Jiy0ql0cW/MsfXrsbYVfYxvf2g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6099
X-OriginatorOrg: intel.com

Robert Richter wrote:
> The CXL driver uses both functions phys_to_target_node() and
> memory_add_physaddr_to_nid(). The x86 architecture relies on the
> NUMA_KEEP_MEMINFO kernel option enabled for both functions to work
> correct. Update Kconfig to make sure the option is always enabled for
> the driver.
> 
> Suggested-by: Dan Williams <dan.j.williams@intel.com>

It would be nice if all "Suggested-by:" tags also came with a "Link:"
tag to recall the rationale, because my brain had cache flushed what I
said earlier.

Found it here:

Link: http://lore.kernel.org/r/65f8b191c0422_aa222941b@dwillia2-mobl3.amr.corp.intel.com.notmuch

..with that added:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

