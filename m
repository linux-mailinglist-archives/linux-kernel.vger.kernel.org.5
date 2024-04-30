Return-Path: <linux-kernel+bounces-164407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8A1C8B7D52
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 18:42:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16087B26F24
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C9B41791EB;
	Tue, 30 Apr 2024 16:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d89AJGG2"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03A0537E4;
	Tue, 30 Apr 2024 16:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714495333; cv=fail; b=W/GPub0T2qdGXVdoxD2RwZfG7Yk7tInko8meZJxTv8gOR5NruhGOM9W41FxrRmKaSQARjY/PBM5Q0vqgen66Lwp1uLqJlYYbhhH9PPgjvFyblDFRZwRQ67PWA0PX+YC2GBSk/Uz8dE2YJU50vF+QPVLPJlYYYdZ2bgx7b1GA7x4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714495333; c=relaxed/simple;
	bh=o2kehi9Bmfb/DXOpwIKhk34uie6upnKVAO+TE0u+7Uk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=R8dIgjxthSisUegJXcu3vulUIUsoaPPEy+KdiSit9nTSHsn0Q6ZltuMlTbCR4tVtU09C8KFsJ9XaLD+OhqKMvZIyKpEIbmomkyqHDE13VtpW3Y4RWEvAm4yr3j6f4P8gIJ8fI3E4hvQT+MlMnvij0IidGlmsFxOObxVCPC4n4Og=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d89AJGG2; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714495332; x=1746031332;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=o2kehi9Bmfb/DXOpwIKhk34uie6upnKVAO+TE0u+7Uk=;
  b=d89AJGG2v8U3XCQtWuOQtli8ReuruS3CRRewcNuMmwxLACb3KOp9ITCD
   cqErifXXgkkcnO+Aj3WPXyM8MKHWPJpfwgJhjoyGw1NvLLSVxuSg4CMDy
   pSATHwufkmjRgjaQJrmL2IdakGaXZTYWX2L3RqFMcUGy77/DXj9ku17DC
   hM6JfA24d5t55BPh87p9ZedQXLsISxcYCeh3oFyaDzkPIHK8W7wHYQlJR
   lf3I0tenWeabT60zyqpyKvnb+cINuSV8Qgec+Y7i9eEgzqZVZuOoYhAAv
   fXO7Nd4TS4T2gsnK3HBzPzRJf2F5uGa+0cOyIZQ70r1yQMvAYNkLQCT8J
   Q==;
X-CSE-ConnectionGUID: uKbQtDycTpyDRFsnT7pZ2g==
X-CSE-MsgGUID: VY9RlXTHQTuFrLAA7Mt46A==
X-IronPort-AV: E=McAfee;i="6600,9927,11060"; a="35601239"
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="35601239"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 09:42:11 -0700
X-CSE-ConnectionGUID: hnfifDKaTzay4WyTkBaaVQ==
X-CSE-MsgGUID: sle/DazsRkGoVYHH4sbk4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="27130877"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Apr 2024 09:42:11 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Apr 2024 09:42:10 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Apr 2024 09:42:10 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 30 Apr 2024 09:42:10 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 30 Apr 2024 09:42:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QhCGKALP/z1Z6PYfobwkgRKYchdrJWHpv9YxOpcaS1gOuktex1vza0slHugs5BKAwdJxX8I/BVd6JvRmV+EmsLUC+OVPJVzEr3/XDrC3yUnpTMRbmMbAbilWgWe8CTFD73fnXd7CgNggL4zFwrkwrNTx76H5XJZTSMFn50a7athTHNTGkVj/SZ9aX/9NxK6X3+u2vCe6ocvMk1EyRYyVpPaYjCXHGxjL2K228xKlDizcAJwjJeIzUExuZbXaYmaptaZy+Op45Thn7y5cw+N5QiD7htMqpwz6+j0hIeccAy0WF5iLPjNOCJ9Z81kWmvmxxtJscr4IyBMECLtsv+AkeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tn5ulbJ7KnH3ElGFedrqExIpkMAg/H52tuFlUKNTR2w=;
 b=UGrhNahjnRVjw7GiOVqtp09cC+/KztG6pyfIoSTDEcxVkSJe7yBczdTl68dzFe7gg1OX1bTQHzpoPEMBdOe48xFQReTfViCFyKf097gNvT87NeYzADXY7SMK1WOjeYWKvd3MBZ1OtGzvyBIGN89pyGzYX40I49GTlzJyzISQ8DMTE2vgSh+50bDOmh7Tmew1O9ugeLEPTxbLLdqbJfPXNiakqDT52Z0RsXX7yq3q3ayMuunCoUqnyRnnQro7NKKG+0HUVgBc/5pyz/XeeFtK/kwSxty579Vzq0pz0x78n2hlzg87Cya2+6L4EkRL+hO+aJPia69uA5YVu5lYrG6xdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB6908.namprd11.prod.outlook.com (2603:10b6:510:204::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.36; Tue, 30 Apr
 2024 16:42:07 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.7519.031; Tue, 30 Apr 2024
 16:42:07 +0000
Date: Tue, 30 Apr 2024 09:42:04 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Robert Richter <rrichter@amd.com>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
	<mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, Andy Lutomirski
	<luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Alison Schofield
	<alison.schofield@intel.com>, Dan Williams <dan.j.williams@intel.com>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, Robert Richter <rrichter@amd.com>, Derick Marks
	<derick.w.marks@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Len Brown
	<lenb@kernel.org>
Subject: Re: [PATCH v6 1/7] x86/numa: Fix SRAT lookup of CFMWS ranges with
 numa_fill_memblks()
Message-ID: <66311f5c59e15_10c212947f@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240430092200.2335887-1-rrichter@amd.com>
 <20240430092200.2335887-2-rrichter@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240430092200.2335887-2-rrichter@amd.com>
X-ClientProxiedBy: MW4PR03CA0086.namprd03.prod.outlook.com
 (2603:10b6:303:b6::31) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB6908:EE_
X-MS-Office365-Filtering-Correlation-Id: f49fcb40-b663-4ba0-82b6-08dc6934796b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005|7416005|921011;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XrLUG4S0ZpdrwBTQac5r4PUgeLG5xYpeQZr73u02d92zOYQFNZeuzONr8Svl?=
 =?us-ascii?Q?6FH6fiKCRMXA/jwkY/xPuxGhDZ5+9+aYQqgqk78puroOdAbcGE4oE/iDi+yH?=
 =?us-ascii?Q?c+ltDJH/6u9+s2M5UnbZA01WGWmkb/EQLRrSrTKe5SPHcUtx8HBX2SplIJT1?=
 =?us-ascii?Q?fVFaHjs4wWiZdPAXIFvv+HoukAwF4lMi/KdCcJ3zsJEyEimOkKUot3KwG7zz?=
 =?us-ascii?Q?PfZhAeJFEm+XhTBM50TFTuikmEph1ui++7aPjRiEnnfG0o+NpUJNBr1JW0g2?=
 =?us-ascii?Q?eLKj765Lq2fTRtutDAuezHXN/ya3DU76sFgmR1+Xpj7e6N6irkvnmWeIksHU?=
 =?us-ascii?Q?v7l2fkIkuc7+2QnXb0lNMf/7F0zPCH71iqPdhKeHrDw9GrHsCAA+I2gkAFaV?=
 =?us-ascii?Q?3LxVENkZbw4e1Wtw42ciDqRutqp9EvV8OnmIimFebhuUWb0slaAPxV+kyZFN?=
 =?us-ascii?Q?70R3EUI46LBfI6sZMuS37Rl4cSSYf8vMv2ZgAceuYSEiZOdsZzpT90tgK9UI?=
 =?us-ascii?Q?oZctEVGQ2pZ8UE2SZwbBqviOegsj/1ou+huhLZVYcd8MDozGsiBlCzZstu9F?=
 =?us-ascii?Q?Yvs6657zSVTwed3nJ+zxh/4xNWz0RVHJeF0Myh529uI4BnL3Y/xUkwUA+oqf?=
 =?us-ascii?Q?vPegVeXqzLXOZnkX5gVLu9mwGolhOH9svC6f2G9tRDqR1tbOJq9xtYz+nh+J?=
 =?us-ascii?Q?Zl39Bd6xZBrtdpFyQurDEt/n84age6DnsbB39jGxRfTNfZ1JQuzIiNQPM7ck?=
 =?us-ascii?Q?fACibwSH5V8BcZ20R0WSA8Do+I0G9JuN/Ol8VRD9xFwsHQ+lNH3I+U6tdEVn?=
 =?us-ascii?Q?kmU1qna8gbPe+oIs8ykXk2LoGj38BvOgeOeAYTeKT5kQtpiXtuMsQ8OUiuPh?=
 =?us-ascii?Q?1Wle3W3ITgT1Ak/UGPBwsEJ+vASYJPPkVh/aAbojS04Q1RcXxag7EYg963Ry?=
 =?us-ascii?Q?5wLQM8K9EMoT9CVd/ur2l/YTCoTAhW+gfkl7Ndpvr62RmmLPdX6OUvEJpQ/j?=
 =?us-ascii?Q?m7eqZdKIp4SYKbXWSrWntcCx5R8r8MJHSjoj9Ci6VxutMsoZeRth8AZi0wem?=
 =?us-ascii?Q?GTQXgE9CIa6Rcmur6vn0a2fDY/9Trg60YGpSzViXodH8seHIGhMDqG349Wgr?=
 =?us-ascii?Q?Z39fi413jXSejYdWdnz9S2pvEhDdl48dPAjoszsGuxMitcrURp1qKXxKNNgX?=
 =?us-ascii?Q?yWvhVHheXAjQVqOnWU7jVK/y2glubhs7jUfm3v65xMQhGentpCU+L+d4ttzV?=
 =?us-ascii?Q?HTs91JPUbJThmS5IDgW5?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(7416005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/u8CqbI9+O562LphGK8/ymy0rUJrII2LmIup6HPhZmciuQLwxrcwAvXUsZ9D?=
 =?us-ascii?Q?p6Si6idCt+afXUSju1ezJl8WlVnuR1UfBAzNPNbm3xien8wNmjs9+k/bEpJc?=
 =?us-ascii?Q?nKAF7oS1E4eDDnal+mica/u2emJOKn0iM4GFSJeyLLCjHqunZ5WOqyEiFN0i?=
 =?us-ascii?Q?AlGAWCuUD2D0GjKW19KzCUH9R32T4baNVsAU/mU2CdXKcRsnt7nSU8EAU/PC?=
 =?us-ascii?Q?jMmNsfHBXNEDeT9AkY3CAStflJMLp18T6pM54WPxh3jdNj4OwRfUxBJIL/G2?=
 =?us-ascii?Q?K86JraDbF1H+bYJ7A22SJ4mdhdFcKu8oqLfqnn1msL0RZZYbPExgJyB/j99j?=
 =?us-ascii?Q?rJFZxlhXQPTFbBVnO2dkyQjo3Ll7gWse6+38BjRIaBSxa5eYP2TPxzZJLGcf?=
 =?us-ascii?Q?+ImFFyoLYVx/F2LjuD3Vg3Ij248XrKTF9r7dVLEM985Kal8CS9TNvek3GGJJ?=
 =?us-ascii?Q?T7Mb1FyE+XFJtL+R8taTsvyFm9hEXcwotmS473wjktSmcURnBXNC+GazIG7C?=
 =?us-ascii?Q?b5fOYjR82rBz4ImNgDU3VQuZpJAU2piafOW9a7kLu3yN/a+f0Us1USms9RAP?=
 =?us-ascii?Q?HY+9VlQIluuThnAKMWvzlgLVSH+hyeAiTuHNEQh9ZTFttawSpVrtXK7DDN8P?=
 =?us-ascii?Q?RA1Nr424GlSVyTgVJ2Brp5fYJfw8/STSsdAMVX8C17r8tFptwPTMZYJ2N6QL?=
 =?us-ascii?Q?nrYlJZqMQx9XUlOgUfJ+zUYTt69eyGdTR+V87zdkBbveOfful6OgiuXU6c41?=
 =?us-ascii?Q?slNe+mw9eiZYcxyehiFflhGucPlZxOOAjllfkReTzUmS3KcWSe9IenwnBI+Z?=
 =?us-ascii?Q?aGhGrbLTgLsEVqwXOoi1BrPypOziRsIvbaEldy7fFekN2nzMpU3Ot2u2D4ul?=
 =?us-ascii?Q?2p9gkeNxLDarpqGyHJm27rvC6WLbe00OtG1tjYFJlPRMtITFYBDvFSMy08kD?=
 =?us-ascii?Q?LLiLcVGIamf/A6WV/qP6r0xpHB1rkYolRGuSw2N67r8jS38/urzhHyVqplyD?=
 =?us-ascii?Q?vptWyuve0opoNKcB6+GcVig3ijXXKCs8rlsD8uVbxTRanQ2EW1I1X2v/Pdu/?=
 =?us-ascii?Q?eXodqOafoqY+VCaSKyCZh48t2S9iFrSkdrofOmckVay/DP5d/yefRAv/c6W5?=
 =?us-ascii?Q?snHvt1UX18yPtLz41xi3FQm3OV4Drl4uFRh9uG744X4yujO2+XV/bQuHSdvF?=
 =?us-ascii?Q?+hSbhqH8NRe09RVT8jQXu6CWe7nMzESMrXeZmuO2ZpN9kX/VD2PFFUWIHYS9?=
 =?us-ascii?Q?lKynp4a0IsRn/9gIFn/YPG4GtTytJnGK/3s2WAcmzp3ffh+PlKmsAxwObUfR?=
 =?us-ascii?Q?qp+wtjD1d8KOL/mDM6H8Eq0P53xra+JF4xx9syfx0SdWtCTjvxo4RLHrgdDu?=
 =?us-ascii?Q?tLN2aaRqobJCD1s9l7MySC35U73sHu5RiJabi6x5SRR5OCQbavuUPrJTDaR2?=
 =?us-ascii?Q?UIMI1d7tPxTXCL1E0ZZK+EfgNnEe1hww2CY29lBcTH1zVUYmXMhOq+LNrB7c?=
 =?us-ascii?Q?u8yo1NvnI5XEevJCey7KKe5kdr2APp3NePo3z00tja5MvjL/ibKzpL9gS4Om?=
 =?us-ascii?Q?FI1++Ix7E7Z34uCVycsgxalGvS8S6t4ak/wCDL6xjtAkhRCKHTYywehrgYvO?=
 =?us-ascii?Q?lg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f49fcb40-b663-4ba0-82b6-08dc6934796b
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 16:42:07.7179
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KU9Gkt28QB1B29fD5KnomPdB/HJrQXs6ViFZc4kbIqY1idkxVqyfuTk3qDt7Q4PmLxxPzjjVrLdL1dvvZq34863FPO5Q4l7lK9J5Wrh161k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6908
X-OriginatorOrg: intel.com

Robert Richter wrote:
> For configurations that have the kconfig option NUMA_KEEP_MEMINFO
> disabled numa_fill_memblks() only returns with NUMA_NO_MEMBLK (-1).
> SRAT lookup fails then because an existing SRAT memory range cannot be
> found for a CFMWS address range. This causes the addition of a
> duplicate numa_memblk with a different node id and a subsequent page
> fault and kernel crash during boot.
> 
> Fix this by making numa_fill_memblks() always available regardless of
> NUMA_KEEP_MEMINFO.
> 
> The fix also removes numa_fill_memblks() from sparsemem.h using
> __weak.
> 
> From Dan:
> 
> """
> It just feels like numa_fill_memblks() has absolutely no business being
> defined in arch/x86/include/asm/sparsemem.h.
> 
> The only use for numa_fill_memblks() is to arrange for NUMA nodes to be
> applied to memory ranges hot-onlined by the CXL driver.
> 
> It belongs right next to numa_add_memblk(), and I suspect
> arch/x86/include/asm/sparsemem.h was only chosen to avoid figuring out
> what to do about the fact that linux/numa.h does not include asm/numa.h
> and that all implementations either provide numa_add_memblk() or select
> the generic implementation.
> 
> So I would prefer that this do the proper fix and get
> numa_fill_memblks() completely out of the sparsemem.h path.
> 
> Something like the following which boots for me.
> """
> 
> Note that the issue was initially introduced with [1]. But since
> phys_to_target_node() was originally used that returned the valid node
> 0, an additional numa_memblk was not added. Though, the node id was
> wrong too, a message is seen then in the logs:
> 
>  kernel/numa.c:  pr_info_once("Unknown target node for memory at 0x%llx, assuming node 0\n",
> 
> [1] commit fd49f99c1809 ("ACPI: NUMA: Add a node and memblk for each
>     CFMWS not in SRAT")
> 
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Link: https://lore.kernel.org/all/66271b0072317_69102944c@dwillia2-xfh.jf.intel.com.notmuch/
> Fixes: 8f1004679987 ("ACPI/NUMA: Apply SRAT proximity domain to entire CFMWS window")
> Cc: Derick Marks <derick.w.marks@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Alison Schofield <alison.schofield@intel.com>
> Signed-off-by: Robert Richter <rrichter@amd.com>

Looks good,

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

