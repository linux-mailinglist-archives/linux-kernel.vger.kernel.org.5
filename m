Return-Path: <linux-kernel+bounces-165743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99FCC8B9078
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 22:16:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDAC61C22E1A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 20:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 383691635BA;
	Wed,  1 May 2024 20:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NdA68YuY"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF221635A8
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 20:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714594560; cv=fail; b=kxqR/nf7lW0v/7cG3+ot/am7JEBUlyZMYUZXkiP/YqgzphJuXNVUQ8m+mloEi9jpLHpJVdyh2GlESZWtbcJeWo6jIU7jDVqJjXFAGhvewFiytT0taLqooLkm14YcEMJ0Zy6TQ6+cG3bdY4z5AdzIv+GvkyIm02EBHrT56xIc4nM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714594560; c=relaxed/simple;
	bh=W67N1bupqopF4OdecuAxktFdND1r0HiFL7dPtxhiR64=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=A0nxaPRQFQjZhx4KEyw1jY0+5NNkxiIi4Bp2o20xhUwdBti1uFK2BjgyGuhB1Z9Wj1SkAClACLoimOHNp1XBYJxPIqJmBUC8WWt1gyu6Pfr2Bz2JbZrWN18puFNeo2Dyj7sK4GH1ULtXJUslJUqUrJwL3CFvUmoKDhhGPoSOows=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NdA68YuY; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714594557; x=1746130557;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=W67N1bupqopF4OdecuAxktFdND1r0HiFL7dPtxhiR64=;
  b=NdA68YuYlB7c4htZSX0tarfiIfOL0GvP8VkL7jm8tkLSUiJVMQDwX5mO
   k1C7ILb1S3wITRCVDvLMYmTO7mcoVKPnpzLsal0TTXQ9khNxc+xH57Xrn
   aO13avyTwir3BmNURBKYBS0mRY2qLpjV/Zb+rH6X2wA0bW1ewDHGH+41f
   GNWkMEnXbLnUwVeRIp/qE3oPPdm7J9/NK7h57BHF8YPTAIRDRPTy0us55
   fXRreimJRW2bFptDiFLyQJAKq66OXR4WFFo9HfWqGbQvxL8+nx4KpLt2l
   BTDLd9MkmPaUvUsynW825T3x6hXmsYhsaNTTEZM2y3XH5VXXiI7L1+xiR
   w==;
X-CSE-ConnectionGUID: VvjYx4uWRLuyio2FqIvQwg==
X-CSE-MsgGUID: h6YUMF+/SNe9kcr7h+XNGQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11061"; a="21746059"
X-IronPort-AV: E=Sophos;i="6.07,246,1708416000"; 
   d="scan'208";a="21746059"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2024 13:15:34 -0700
X-CSE-ConnectionGUID: GwGwf+GrSLSRPF5j1fSILw==
X-CSE-MsgGUID: J45dlRdNRRWrZ7PG/+Pi9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,246,1708416000"; 
   d="scan'208";a="31701484"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 May 2024 13:15:34 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 1 May 2024 13:15:33 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 1 May 2024 13:15:32 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 1 May 2024 13:15:32 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.170)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 1 May 2024 13:15:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R9topHHCqSpiw2OMuBd2ZXGFKNqLYQfFAJyu2Hv9mKbxFNSwqyeojdwAfYxCxwMtu7Z6FmgW6YadqtCPQ6jbpWIHmC3AL7Qg4+MzrJy0ewQhy7mY9x5GC07hLwEIS+E+vCIEMwMPWk7NbEmaa4zx/CefC7rwD6VwjT2mAFuRcpw7CfQygdzFYvtrHS7kgBso/DC/fUrqpIQmWIcD3AQd5VQ41syzdb9VwNa13VsPtnMO9WcSWVwyEAEpHwae/5elbfanZoj3UxfUqjzqkcyD+DOsXD7E1/L4RiODE7LUpvNnlMYU+UlxiIv3YOJU2np0gUAvn0tQjXRzUA3TO+PrPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PxMTDG9ByXnn1h9KLV5/j11+ktiDehHuRJt+mA0s4AE=;
 b=m4yUAJCDt79n8lizy7wrpSn0Nw1lQxFU7hTA+eI/+W9bahakcEpif6UtviywlcQPREjaLaJaviPIimfgiARims457kYvXci7t9FsFAvza5noOnfljFglzOnhwYQ3ogLXsG7J48/GoI4uXkjfB9WBP/26mMLNYBe8jn+pe6Gfsd7y6IfWvWKJMyM1kFPPCDzHUsKVULAUa1gk1y+IBNe6wyInsb/Zoll+fynzq80PXAkglKh51kZmVZdXWEwE8XSx7R9pmdwjkAdlPMEE7nmdd/8vy/NN0IpKQuYTUedYCvrxap3GlxYpWjXP0ScfeAhu3n9W9YV+G4LW7Kt6AsATcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MN0PR11MB6109.namprd11.prod.outlook.com (2603:10b6:208:3cf::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.37; Wed, 1 May
 2024 20:15:30 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.7519.031; Wed, 1 May 2024
 20:15:30 +0000
Date: Wed, 1 May 2024 13:15:28 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>
CC: <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
	<linux-coco@lists.linux.dev>, <svsm-devel@coconut-svsm.dev>, Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin"
	<hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra
	<peterz@infradead.org>, Dan Williams <dan.j.williams@intel.com>, Michael Roth
	<michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
Subject: Re: [PATCH v4 13/15] x86/sev: Take advantage of configfs visibility
 support in TSM
Message-ID: <6632a2e0738d_1384629442@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <cover.1713974291.git.thomas.lendacky@amd.com>
 <e3143c1f3d0b26fcd8884c6f75644b634a7138e8.1713974291.git.thomas.lendacky@amd.com>
 <CAC41dw-g2=jKkevGOJUqnzYTpxQ8+Z_JxnNNuoLR+CM_yqfRzA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAC41dw-g2=jKkevGOJUqnzYTpxQ8+Z_JxnNNuoLR+CM_yqfRzA@mail.gmail.com>
X-ClientProxiedBy: MW4PR04CA0066.namprd04.prod.outlook.com
 (2603:10b6:303:6b::11) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MN0PR11MB6109:EE_
X-MS-Office365-Filtering-Correlation-Id: bf486ad0-8452-4379-a664-08dc6a1b72ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|7416005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Qms1MjZGbkdhV05UM2UweU9kdUFaSkVrY3ZTTlg1dnYrRU0wOFJKL1QwejNq?=
 =?utf-8?B?VnlhTlNOY3V5Vk1DK1Q3TFE3NmcwSlNvSDRLbE9NL3k4ZGxXUFM3TEhRZXlo?=
 =?utf-8?B?YjlZVUw1VlhrQ2Z1R1l1NGZmak5XRkdNUFJqU1RQRngrZ1BVZGNWUWF2ZHhX?=
 =?utf-8?B?UjlpZ2JyOXBUemMzWlk4SmF6Ukd1OURiakt2RCtVaElaNzNBTDFqbzVlRElR?=
 =?utf-8?B?Q2pJMkk2MjhCNEJkOEI3OGNHSEo3aDNqWEEwb3pnci9YSmxYVHRUQmlHUTJJ?=
 =?utf-8?B?YzJCUktIRFpaRXlhMEczUDBaS2tvUUJ6VE9Ya0hOVXRqKy9IZWNVRnptekRz?=
 =?utf-8?B?Z25GaGJXZDdhbWpuem5NNjNxTHk5M0tSTVh5Snl6Q2IvZU5hc3dzM2wwNmVt?=
 =?utf-8?B?Um50UW9JdFFObUFoSFhJc2ZlSkdsci9Kd3JLQzNxeU52d3RORytRY2FwVVJh?=
 =?utf-8?B?dUtSVksrRGgvWXRKWlZQZlpYT1NtMVFYbFozYVNLbjhXQTNSQUdCeHhNZ2FZ?=
 =?utf-8?B?cTRNTS9DbkF4c1FyNis5WllkcmhsZUhJWUl5YnZXcGhCZVA0ano0bEVFMkw3?=
 =?utf-8?B?ZXNJR3VYcmhwb3BCTGRvYWNRTnBIYUJpUnNRU3JXL1liUGk3MFN2NXo5ZDUx?=
 =?utf-8?B?NlhxOWFJdWxCVDB4d21mY1djaEhtamt3U2Vmb0RXdG1ENk5mQ29DRnQySHJs?=
 =?utf-8?B?QTBLV1pvcG1KSHJoeFd0M0JlNDE3WHVVUWJKZ2pxWnFaZllmMlZlT25VTWhO?=
 =?utf-8?B?ZEI4cjc2QlNxQWYwVGxBWDhQRHFJNklMR21SZk9SS3B2QWNFNEZXclRNZDJS?=
 =?utf-8?B?ZkUwazc3RlFzSHppRHYxRWdEbHZsSXlnakhJWHMvMEZGOFBWWnBTQ2o0U2h1?=
 =?utf-8?B?K2JpTWpzZ1pGYmF2dENudThYSXhrNytXQjM3NkowQmFoTDd2b0dVYWJyeU9D?=
 =?utf-8?B?d0lSemdUMG8wdjdNZXkzb0pmL29mU2htTHRKK2wzUjkwWmQzdjREdER2dHdm?=
 =?utf-8?B?eUVzaXpocjdUQkdUNEk2T3B3WUY5OFFnUks4allnbWJVbkNxOGc0L1pVZkhz?=
 =?utf-8?B?UmRLZ0Q3eXRNeVUwTnBrY200NlFldHBCak4rMkF1SUxCSHQyKytUc0FsS1p3?=
 =?utf-8?B?ZHl1SnF1T2FCcjlxUEV4bkoxMXFseFlwNFFxSVJZbnlRMGI3bnJpQ0JHMUp4?=
 =?utf-8?B?VTRBNlJTQXVBaFBtRkxselRtcS9CMEdGYmFsZGE1eUVpU21UN3FvRnNWS2t3?=
 =?utf-8?B?R3gyMlRWMlNta2VSdktsU21QbjVhS3huNENVRFFJSmwrZVZJSUJ1NnNJMFBj?=
 =?utf-8?B?eXFOelFrbGp5Qms4Vmxvb0pzeU43VVdxazVheUIzN0FEUWNMdENNaHJYTHpn?=
 =?utf-8?B?VWQ1UEZ5SHcwWTlnbFZkazJtT21sL2dzZ2tvSGVudWJGcEFVc1dkZHRObDdW?=
 =?utf-8?B?aWppOG5jTGZLSGdZOWQ3bE5ycUVvbStTTjRMT1cwSkpLcW1RU0NWRHhZTzR2?=
 =?utf-8?B?clM4SmNlbXd1NW1IU005MGdOanBUcmhoNUljcmhFN2p4NHpCUHRJK0phVCtK?=
 =?utf-8?B?U08xQmJma3lzVmhuc3RadkgxeE1KNmxHSHZ3UFVNcWFZVDNHRGh2c29sZXd3?=
 =?utf-8?B?S0JraHgvV0VoNjBqbWlqamxVMXhKNjZKZTdDS3lSZGtZaVFOWHpEOEN2OVJB?=
 =?utf-8?B?a2E0SlVuSEloeERXZzBDelZYOEhWeTFFL3VEcHF1RVdWQ2FFT2orQlB3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YWZPZjlMMUNKc0dvR1hubjVRUnRMY3Q4NVYrL3l0UUQyb1VlOHRsc2NJRVNa?=
 =?utf-8?B?NC83SmFQTklOa3pjbWcySGpqZVJCZ3VmRHp6S0JjNDByelRqVzE4UmhGdTVZ?=
 =?utf-8?B?N3RrVUpBbElOTk5VOSsybUM0VkRuYTI4OTJwYUZUNVJxakRoTWVUcXkrN2Y1?=
 =?utf-8?B?YVd5ZnBQSXdQdVdJdjJFaXFQbzNydzh1N2NiRk5Bek1aL0dXU1RyaXJoaFc1?=
 =?utf-8?B?bjl4UCtmTUthakhMK3BrYUhhNnV0VXViOEMxWHZybkJXL3VROU50anVNMzdF?=
 =?utf-8?B?K1J0WVY1aFFkOVFJQnRyRmpjK1ZNMUM4VU5Eby9XbkpINVdqS0dpMTRBU0Fz?=
 =?utf-8?B?U2NFNjBRV0EycGsxRlVFK1VmOXJhbHZ4RnIrZ3dxcnVRMnA4ejllYWl6U1Zz?=
 =?utf-8?B?VTNGRHJ6VExXTWZaSFJKWktoVTJRTUNJRWw4Z2FhdVo5T1BKN3MyalYwUlMy?=
 =?utf-8?B?anluVDdEaGdOVEdLMkFmMEEvN2xGR0FaREF3N2dvajJ0NEFSRmpEaTJpRlRP?=
 =?utf-8?B?SUg5RUJ2SmRndnJYZHljNFZIb1F0MFQ5NnB2YU1DQUtPeTFxWGtiaUxiMktB?=
 =?utf-8?B?SGhrS2JKMzhJeU1aYSt2ZUtIQ0RNemVURUpDcyt5Y3RhUjFReDhCbDBmenFp?=
 =?utf-8?B?TnpDcU82dlZ4ekxxSXhBK0Z5NlhhSlpRWTJhRDRmQzdNVXlUWlhlZVJQSWp2?=
 =?utf-8?B?cWNUSUQ0ZFNDY0VvY2lxUktPa3BseGo5dmxmVHVzK2QxTUlvODlFenUxVGVk?=
 =?utf-8?B?dXJXcERuL01SMkxNZkJEUEZpc0t2UklQZnRqS3o0VFFvdzFTRWdsczFmRjEz?=
 =?utf-8?B?Ni9uTVlsWmh5MG1mSW1ScHp0dU5jK0I5ODk1WmdPRGRXY05ZYlVzV0xDTWx5?=
 =?utf-8?B?cHFTUUJVWDJGdDh0TzlrOEtQVTIvSFE5QzAvNFNITk5TMUp3cFlnQkxNSjYv?=
 =?utf-8?B?UThTMWE1akVrMEZZRTJkL0M0VGFJdmx2clJVVkFhN1IxcllNbVprS3JuVjE2?=
 =?utf-8?B?TnVVVFJrU2tLTC9RM3NZYlhPWk9DY0NJMU9Pb2lYYk5DWlJUSU9lWk5UVUlM?=
 =?utf-8?B?SkFYUklCOFJ4ZnFZek5OY0ozYVd4RUo1eXNBUFJDS0pUK3VXaDBiVDk0SGpu?=
 =?utf-8?B?M1RPdWJFeElucEtEWTFKWngrVjJyMlpldHFmeC9UNmhZSE1oOWp4bFZxODAy?=
 =?utf-8?B?QlBadGVjVlQ0QnlQeG5HS3d5OEMwdm5tK1pFZmJhdllqcVUrclJES0l0VjQ4?=
 =?utf-8?B?aW1NcnYvOE96SitFZXFXb3gzRnF2V2xKMUsvYlBVTitLMmxtN1ErOWlpMWZE?=
 =?utf-8?B?ZDVPekoxSm00alBZdTZaUlp3S2VUQ1phUkhtVnJPUlM0Zm5DblFWL1YxS1ov?=
 =?utf-8?B?YVhURXJyTUlDbFhSTW16cVVxTXhOM1IwZTJ6cnJadDl5MnowVWI2LzRram0y?=
 =?utf-8?B?NUNVMDNaNWZtTUlHSU5kZEljdTB5V2pTd1doRVBTeUtFeGxLNlBBVDV6c3hF?=
 =?utf-8?B?cGREWGtBcUFhUGRvaGpvRU9BNmNqV09qNzlVS2phUEROQ092QmpWTDdvTVAw?=
 =?utf-8?B?QWJHQTdxcEZyYmN3ZUpnYzZwZk52OVpIY3FqdlRjeXdQRzM5RXpteGhIdTZp?=
 =?utf-8?B?dVRYUk1qQTA0b0tVNnJ4ZEpiQWhQUVBNNE5pOGFvRkkvOUxyMEJnZmNKbEtk?=
 =?utf-8?B?QzZxMVBCaHl6UndjUklieE5PZkRwaDVMZ1QzbjE0bU94V0F5Ti83ZnZCRXFt?=
 =?utf-8?B?QTRGekhtTGhHKzB4WjhXOUViYWw5c2wza2U1KzhiaWxuS2R4NGVJWThTK21X?=
 =?utf-8?B?azZIZHVuc2NiRVhnb2FybEZ5NFpXb2doT2k5U1p0WFhuM21sdlYrOXdBRFRr?=
 =?utf-8?B?aFRvN3N0cjI5S0FIc1J6aXYwMGozd2luNUNrdVJadUNxRmRoSTZYY09JcTNM?=
 =?utf-8?B?U1BVcnZnTEZXMkd0T3RES1JkVWJtcFdMNFJ1WWNNVmtBZVE1V0JuSnNleWdr?=
 =?utf-8?B?YlBXWUVWdW5IcFFBQ202a0ROclFGYnhyNUFueUFCYkxkRUpBNXdEbjFWY3lx?=
 =?utf-8?B?bkJta25kWGxkVHRiRjRxVWJYYWRuYWJLTUhqbmJXd1EvM2R5L29BRDRlYS9v?=
 =?utf-8?B?dTdxaUpWaEN0bHhtUHdNNG5MbldPV1FiZno4T3MxU2MzRmhMUFJ2MnQ5U1Ft?=
 =?utf-8?B?OFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bf486ad0-8452-4379-a664-08dc6a1b72ea
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 20:15:30.5792
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YnAChUYPaZPilwIg0VGWmyL0i6lx4jp6vM19FrSo913LW5PhLMH7W3pRDj9BZ8LDcQenGnlVO9UDdNDhVE660Ok2Jx/a7B5SNNyDZ9qWkdY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6109
X-OriginatorOrg: intel.com

Kuppuswamy Sathyanarayanan wrote:
> On Wed, Apr 24, 2024 at 9:00 AM Tom Lendacky <thomas.lendacky@amd.com> wrote:
> >
> > The TSM attestation report support provides multiple configfs attribute
> > types (both for standard and binary attributes) to allow for additional
> > attributes to be displayed for SNP as compared to TDX. With the ability
> > to hide attributes via configfs, consoldate the multiple attribute groups
> > into a single standard attribute group and a single binary attribute
> > group. Modify the TDX support to hide the attributes that were previously
> > "hidden" as a result of registering the selective attribute groups.
> >
> > Co-developed-by: Dan Williams <dan.j.williams@intel.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
[..]
> > + */
> > +enum tsm_attr_index {
> > +       TSM_REPORT_GENERATION,
> 
> Do we need an index for the generation attribute ? Since it is a core
> function, we can allow it by default.

That is up to the is_visible() callback to decide the declaration of
which index corresponds to which attribute is just static information.

> 
> > +       TSM_REPORT_PROVIDER,
> 
> Same as above.

These numbers need to match the array indices of tsm_report_attrs.

Your suggestion makes the declaration of tsm_report_attrs more
difficult:

 static struct configfs_attribute *tsm_report_attrs[] = {
    [TSM_REPORT_GENERATION] = &tsm_report_attr_generation,
    [TSM_REPORT_PROVIDER] = &tsm_report_attr_provider,
    [TSM_REPORT_PRIVLEVEL] = &tsm_report_attr_privlevel,
    [TSM_REPORT_PRIVLEVEL_FLOOR] = &tsm_report_attr_privlevel_floor,
    NULL,
 };

..because then the definition of TSM_REPORT_PRIVLEVEL would need to
know how many attributes precede it in the array. So, defining it this
way makes it more robust against future changes that want to
add/delete/reorder attributes in the array.

> 
> > +       TSM_REPORT_PRIVLEVEL,
> > +       TSM_REPORT_PRIVLEVEL_FLOOR,
> > +};
> > +
> > +/**
> > + * enum tsm_bin_attr_index - index used to reference binary report attributes
> > + * @TSM_REPORT_INBLOB: index of the binary report input attribute
> > + * @TSM_REPORT_OUTBLOB: index of the binary report output attribute
> > + * @TSM_REPORT_AUXBLOB: index of the binary auxiliary data attribute
> > + */
> > +enum tsm_bin_attr_index {
> > +       TSM_REPORT_INBLOB,
> > +       TSM_REPORT_OUTBLOB,
> > +       TSM_REPORT_AUXBLOB,
> > +};
> 
> Why differentiate between bin attr and regular attr? Why not use the same enum?

I do not understand your suggestion. There are two arrays:

 static struct configfs_bin_attribute *tsm_report_bin_attrs[] = {
       [TSM_REPORT_INBLOB] = &tsm_report_attr_inblob,
       [TSM_REPORT_OUTBLOB] = &tsm_report_attr_outblob,
       [TSM_REPORT_AUXBLOB] = &tsm_report_attr_auxblob,
       NULL,
 };

..so there are 2 sets of indices. If only one enum is used then one of
those arrays becomes sparsely populated causing the NULL array
terminator to pop up in unexpected indices.

> > +
> >  /**
> >   * struct tsm_ops - attributes and operations for tsm instances
> >   * @name: tsm id reflected in /sys/kernel/config/tsm/report/$report/provider
> >   * @privlevel_floor: convey base privlevel for nested scenarios
> >   * @report_new: Populate @report with the report blob and auxblob
> >   * (optional), return 0 on successful population, or -errno otherwise
> > + * @report_attr_visible: show or hide a report attribute entry
> > + * @report_bin_attr_visible: show or hide a report binary attribute entry
> >   *
> >   * Implementation specific ops, only one is expected to be registered at
> >   * a time i.e. only one of "sev-guest", "tdx-guest", etc.
> > @@ -56,14 +85,12 @@ struct tsm_ops {
> >         const char *name;
> >         unsigned int privlevel_floor;
> >         int (*report_new)(struct tsm_report *report, void *data);
> > +       bool (*report_attr_visible)(struct config_item *item,
> > +                                   struct configfs_attribute *attr, int n);
> > +       bool (*report_bin_attr_visible)(struct config_item *item,
> > +                                       struct configfs_bin_attribute *attr, int n);
> 
> I think we can use a single callback . We don't really gain anything
> with bin attr differentiation.

No, the goal here is symmetry with sysfs, and the arrays are separate so
the @n argument is a different index space. It also loses some type
safety for making sure that bin_attr callbacks can safely assume that
they were not passed a text attribute by mistake.

