Return-Path: <linux-kernel+bounces-156044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 054688AFD1A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 02:08:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA1BC289310
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 00:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 820BA4A1C;
	Wed, 24 Apr 2024 00:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kct9xVLG"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC371FC4;
	Wed, 24 Apr 2024 00:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713917287; cv=fail; b=NmFPxUiWppubkXz/R7c8aFLA9jvX9OyI9ZdopG8GyXW3onOjeP7LiocKRQoKuqvlZ9aL7afQJcDY09LPzyUrwupUWXOdq0MRX31qy39p2xBDA6xkf8RhU/VZoZNUZVGAL0j5F085RoGGniAO07/oVqLwb/3dWdQsPZH2bCMwSJE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713917287; c=relaxed/simple;
	bh=fVXK8U3MNGqHoNnqNRGlqucLECWW6SjJceC9sDZAHRs=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IDDy000bFJcMsF2VStD38lPqRwVpvMXWT6XHDn5jRIahevX8zXB9X+Ro2Be6DYbBU9k4JxvsYOrvAIydSviX1vwam5/SqpXPNQFhLHFKMBiY0U1GwRuKLykTl2euEAJG4f963vBtlO5Asc0jbgquLjb1+DqYI4a7N+XEwR6W0A0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kct9xVLG; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713917286; x=1745453286;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=fVXK8U3MNGqHoNnqNRGlqucLECWW6SjJceC9sDZAHRs=;
  b=Kct9xVLG2jQOdRHXKhQ4WqKCAkO+4jxA1umsGdE18RjPLNkM383TsbVK
   u+iot99xYlmemXksDaxRJ0+kpLGtbNwFrMHHO3z/1EMo+Ja1FeVPjXQtf
   W4ooa6d9l9TSKf0v3LnsVFGlFUibOr9agB+1zUt7kHOdMs7bB/dfNcYzD
   YQKl0i6V6lrfV1YN6O7O+Y+ldGdi54V9PWtv2iURh3f6AhqDK/kiEGsig
   9KUGNr/WzgrquAJ5Um9pvWw4AGP7Tp63vvLjkS/TBOsu9AzkY2q8uupxW
   jkfJxlNr5zpPepQxkCmSM4VxQLKcf6ZvgRdNGXqNI2MGeK6Z4WfNGcxiC
   A==;
X-CSE-ConnectionGUID: Cv6MAtzgQ4Gdi4/mEL9RjA==
X-CSE-MsgGUID: B0mIh140Tgmx3q4P24cdPg==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="9453275"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="9453275"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 17:08:05 -0700
X-CSE-ConnectionGUID: /u66n6isToqb2CQZlu2S/A==
X-CSE-MsgGUID: 8gRTH+OHStaXzWCJDSGIWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="24577353"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Apr 2024 17:08:04 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 23 Apr 2024 17:08:03 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 23 Apr 2024 17:08:03 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 23 Apr 2024 17:08:03 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 23 Apr 2024 17:08:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W2TfZNJxwSN6qplhd78sDkfit68WdaGtigZuZwZ0dtQagxckxTsi47t+i/GsraBwTVbFlhqUpxqc/p1kRULMhE/N+Iitaoq9KJbOWgtE3xjdOw2ymFwVf3YMCIdu3TRmVXEuq1wcSG9oqAWYmVF6mVCd0RNZgSnxvSPHl57LL1QehLLendhkhu+QrDzfW0tJBObQHwqeDwyqK/xL6J5d7Fx589Y7Vkp1Ox6uNZswXVSI5S25sb+MzYxcAfr9amtYhhEGMx+blBLISYlvLEChIc8Trhj8X//krUyZY7EA+E98M/HOJtBUVAOIF0F8HJcHEzLR/mwQz8uZzn/2rv+4IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rDktO1q6tvML6z33OtmB3/lMW+8PhiwJSA9VBtzx0Go=;
 b=gtWbs7NCAMgKl/mg219VguovSTsgTxajRRf1Z6rhSt9bwGYZ1PBTBlBJx/U238Tj5rH5YU++eR3Dw/SNu6+xFMqIriNAu8r7nf04evvqLMSl2wBKa91kSlTo5+PZ3/97pDCY0QeOyKkrG8zNia3aPp6jeyc3toTQvX86fhECF70EMHGVOxEpKjVApGqJM+w4zk5CkN4j8+FGTveG7APmZlIE3hV7O/S7D2/DMeXGbxUpyNUJwDPgAQPSDicKtXDzl6sjT1pHKbyWrA32o51K2pDeuSeH49uWLmraRIuuFmZ3zI/5D9/AMg57NJyRrCJq0Op6vech5IBA6ewBVKEkjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA0PR11MB4558.namprd11.prod.outlook.com (2603:10b6:806:9e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Wed, 24 Apr
 2024 00:08:01 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7452.046; Wed, 24 Apr 2024
 00:08:01 +0000
Date: Tue, 23 Apr 2024 17:07:58 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, Sreenivas Bagalkote
	<sreenivas.bagalkote@broadcom.com>, Brett Henning
	<brett.henning@broadcom.com>, Harold Johnson <harold.johnson@broadcom.com>,
	Sumanesh Samanta <sumanesh.samanta@broadcom.com>,
	<linux-kernel@vger.kernel.org>, Davidlohr Bueso <dave@stgolabs.net>, "Dave
 Jiang" <dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	<linuxarm@huawei.com>, <linux-api@vger.kernel.org>, Lorenzo Pieralisi
	<lpieralisi@kernel.org>, "Natu, Mahesh" <mahesh.natu@intel.com>
Subject: Re: RFC: Restricting userspace interfaces for CXL fabric management
Message-ID: <66284d5e8ac01_690a29431@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240321174423.00007e0d@Huawei.com>
 <66109191f3d6d_2583ad29468@dwillia2-xfh.jf.intel.com.notmuch>
 <20240410124517.000075f2@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240410124517.000075f2@Huawei.com>
X-ClientProxiedBy: MW4PR04CA0221.namprd04.prod.outlook.com
 (2603:10b6:303:87::16) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA0PR11MB4558:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d7d5b4d-1897-468a-d03d-08dc63f29afa
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FrkEIvy6gAVYLwHPSXuIrh+mzywocf6k/rXS4drbYOW9XMt+2CbXIORRdKsJ?=
 =?us-ascii?Q?dRgOWXAhO10vg7dLOWP1kF5L8U7ENYd2eUzp6xZ7YJRoKNgpKXbgWA7A3ob+?=
 =?us-ascii?Q?4pd/Hwcg7eqvW+DEQ+3tNwZyRs48Ce5c0fEu1Hr0HFsVohHvP1P/eCN73Kxr?=
 =?us-ascii?Q?OSOE0d9qXkrCHxn39RbV2OG3L28FUYl16llyha1ikDAYLpdkZj4yhSrVENbN?=
 =?us-ascii?Q?UjhcggnmwMkhUarTkCvg3Ot4gLLfkUhk6cYHpQGy0kCtirj65tucI+YgWDBy?=
 =?us-ascii?Q?YwqhBR64SRltEgYZq+ZoU5iLJzglPJ5R36whvzYCjEJcIqcNSjdBm7fgJ+Zm?=
 =?us-ascii?Q?9TMIyDDaVgr1XIXeyVh5EdM+EjyyFJTVKFOlFeQptWsAU/qC9ZbG5APrbPL/?=
 =?us-ascii?Q?Fjg4u4PnTyYFU5uj2pxnHSTDFNlKDr3wwQRXoaPav6650pihQRs7fxH3BA0d?=
 =?us-ascii?Q?XrPejqj7ihEff01EwpexkopRKwU3v/ZwU0+HFuoxbuMpx1j5VR785TDd19wS?=
 =?us-ascii?Q?r6OC41cdRNzl3RVTrVnx2rPWUtd5ibDDdo+amASVtzJjs7LJ0zELL7Ns3K+m?=
 =?us-ascii?Q?J0Q5Urz+1Pyihzb8FL1zgrW4mLFKI1435f/fi4cFVsLDOdrI3I3EevRBz+s6?=
 =?us-ascii?Q?tKE1PrHZ14LuOb31A9KZoxPer23kJkD9gJPWI/Baw45evcAap4+vaj/Vttwu?=
 =?us-ascii?Q?hyO2RiYDVNMlnSvRdPwn40jExarEO0QWxX1++wTMvOuhm16NaPZX9RU4d4ok?=
 =?us-ascii?Q?Sz9hj89fjQVYJIjMTOVOUcCu3HEL5PTH7tboVd9BrolPe4vLQ4OVPE5jXc/W?=
 =?us-ascii?Q?YEL4fM7P6LeB4cNOHwqP9CceouPYdD5uGgZjUrwVuhWLzDtGpIRr/Ix3sz7N?=
 =?us-ascii?Q?1hyJ+5TgvAUGKI5N7yZxgtEkJHxqOrTOs6JdfENogXDp//zgeMoNBgkjl42u?=
 =?us-ascii?Q?6pJr+UfQuYL2tleOcQS7CEn1IrRIcvNeVfeHQvwgGuERse3CfpXVwta/k5Zg?=
 =?us-ascii?Q?spzdbcC+pGRkbL93eexUtlKdO2VdyLP4P9oxPNO3qo1a2Z57bsAv4y8QUo3a?=
 =?us-ascii?Q?Os8xPHR4e/d9pA8CoCkqAQsBQH4Lz5EXI18fRDA+Nq7q7OpLIHfypB/00o5m?=
 =?us-ascii?Q?Cu3x5C/1R1YEUK4mRLPIKPYTZQrN2ErLEiD+vO/ALlsAg3eGZiESuSD3xIdS?=
 =?us-ascii?Q?DMvL1BjWeb97dcO52EFbTfudM+SExxAmr9HAN9X4tZzjWUvmfaF79nvem2Ie?=
 =?us-ascii?Q?jzz8QKLkiIQuaLBDCIlG8P3CfELu01YqCCDsOgwRyQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fKguvXecjOTkm1aVJykoJszKLni+sXnJQh9KDM1RDoulLVwmp1S/Cd6FjwtQ?=
 =?us-ascii?Q?SBfSPXdvzzX6wyjbsl7aNFCxSH5MivQ1xYldCy8FLK7WMxf4vC7oS3gjxr2w?=
 =?us-ascii?Q?4s+kiyZIwSZooNszFWwOLUt5gQw3InrBW1EPRmRTIiP149D8rCEzbeFWdLPt?=
 =?us-ascii?Q?xGeUCEOQKLewkTUPh0lpHp9OeeAZZoA1SN3+JmDrpvypurTCMnTUn/PpkyEG?=
 =?us-ascii?Q?fOM+oGRkFPDSLFzsHOLdJjpMTyes5kksaaMyuDdg7rV63IdjGVMh2HDREGus?=
 =?us-ascii?Q?XERLFh864Tc3mdwdyEvUaUUFfBpaQZHeB/kvwZh/x1iKI2JHLpiWZLjZ3ID8?=
 =?us-ascii?Q?zF6S8ji+9+Blp9qhZZtJaZIyvXxIePjJ2P08SUsUAuaANbT3ajeQGG0IFRK1?=
 =?us-ascii?Q?khiHCFWXhFln5srS4qmmJOG297JEjqXS5WE7qdiSTs+TNkDgRdFaIcatIUW6?=
 =?us-ascii?Q?ugqxWcj10o7gICXXqnd3oKh2UvmUerQHAw+d4hpkPE0XZpIO2Hrq1V5kDIHo?=
 =?us-ascii?Q?3ubZmLmCZZFVlWlql/lRrT74d0NK/QD9zcFYUI2tOTNZb/UPs7ntFEliEzEj?=
 =?us-ascii?Q?W0fFgOiq1hGfmsWqEnvnitGwkku/qznEie5PG4WQo626sx3Fk+Tckz+TwbqA?=
 =?us-ascii?Q?WyrZt1yAE/h2PbVZj412K+vVR6gxJtX2KcNffdiMzMVyexZKr+SV0MhZHSw5?=
 =?us-ascii?Q?Ww2sf8ycM9UoT0BL2nVoglEf7dtMv8B8v6NlSyMFGM2uxCYB/L9Sz3LOVxGh?=
 =?us-ascii?Q?esNwFTRm8plFQrsiM2/vWP9AGfps9mWj+HrA1b5Yh9+X36sPgPXXdT2PhIZi?=
 =?us-ascii?Q?L4Iy2FTjHz0a4fmFkcQIhAKDFTSurcfQemk/j2tZCAf8ctHM2Pce+OoMcccT?=
 =?us-ascii?Q?WTCWfg8Ar5YOtE/sE27Kv1UnPGPS3FDAz4+3s/CRYb67W6faqGRberjz9Uox?=
 =?us-ascii?Q?BM32ZZ+gyhGCOfzdyfFTm8RVtenTnN77WHEpECriGlOPTLqnduFYR7rJHRvi?=
 =?us-ascii?Q?p0PAfZN28Fo7NrMWXSrOtx8Y+6b7LLg7gZPnbikhHr2e3AQvt37Mwj0eXZhe?=
 =?us-ascii?Q?iC7UPqzHfLxkrmG2mme6ANAuuddq0w62kNZKlPLLwgG2FxFFDLem7E/hj2e/?=
 =?us-ascii?Q?hQT51kL+iyd1tdSFTG7GvM2JmQw2XDIUgrQV8vokug/9mdYiRjMBuOwdZJeW?=
 =?us-ascii?Q?cjubGRWWlSy2xeMY0Frfb04N2/60DekfXsMINs/HDQuM4vrlTgRljJbHIeC0?=
 =?us-ascii?Q?wGMjHCE9k8yQcZOukMwLYbjUo8KL/SgjOXsOgUOIDn0hmoiwKDkLnOSr00Zw?=
 =?us-ascii?Q?RRckxFUqooRRglGM13b6LKVF2EZmhmpBh97KFvPVvg6EjuoZAI50z5yoQQ9K?=
 =?us-ascii?Q?hau9+n1mTCZeVRf+OhPIlKd+FIW+Cq9T72dWxcnVT1P79a6AojLAOSBeR4DF?=
 =?us-ascii?Q?J+QPPknrlv/2Rb8x5l0+5aC6QHSM4C9hKciy95lAWC/03CuLSW1VEwAqFHMx?=
 =?us-ascii?Q?CLsoD0JSSTzSwdrSxzLDapdvxL6/D6hXiCAe0t/bKOg00vC1kW3PzDR4l7YG?=
 =?us-ascii?Q?GDaVOhh+phbdzfyb9My2wpqH0fSNIJTvEK6otd7gWQkUahdk6tJX6HcSd9BL?=
 =?us-ascii?Q?6Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d7d5b4d-1897-468a-d03d-08dc63f29afa
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 00:08:01.4922
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6xi01a8J3KjUzV8PKh46mKI2f5/oFfBYstVbfhYjHfBD98o813L0/WVdE9a0OEPyKMSlEhuBAIKXCS9U9mC+V8ePyd0FS7repq64nMI/SXs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4558
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
[..]
> > It is not clear to me that this material makes sense to house in
> > drivers/ vs tools/ or even out-of-tree just for maintenance burden
> > relief of keeping the universes separated. What does the Linux kernel
> > project get out of carrying this in mainline alongside the inband code?
> 
> I'm not sure what you mean by in band.  Aim here was to discuss
> in-band drivers for switch CCI etc. Same reason from a kernel point of
> view for why we include embedded drivers.  I'll interpret in band
> as host driven and not inband as FM-API stuff.
>  
> > I do think the mailbox refactoring to support non-CXL use cases is
> > interesting, but only so far as refactoring is consumed for inband use
> > cases like RAS API.
> 
> If I read this right, I disagree with the 'only so far' bit.
> 
> In all substantial ways we should support BMC use case of the Linux Kernel
> at a similar level to how we support forms of Linux Distros.

I think we need to talk in terms of specifics, because in the general
case I do not see the blockage. OpenBMC currently is based on v6.6.28
and carries 136 patches. An additional patch to turn off raw commands
restrictions over there would not even be noticed.

> It may not be our target market as developers for particular parts of
> our companies, but we should not block those who want to support it.

It is also the case that there is a responsibility to build maintainable
kernel interfaces that can be reasoned about, especially with devices as
powerful as CXL that are trusted to host system memory and be caching
agents. For example, I do not want to be in the position of auditing
whether proposed tunnels and passthroughs violate lockdown expectations.

Also, the assertion that these kernels will be built with
CONFIG_SECURITY_LOCKDOWN_LSM=n and likely CONFIG_STRICT_DEVMEM=n, then
the entire user-mode driver ABI is available for use. CXL commands are
simple polled mmio, does Linux really benefit from carrying drivers in
the kernel that the kernel itself does not care about?

[..]
> Switch CCI Driver: PCI driver doing everything beyond the CXL mbox specific bit.
> Type 3 Stack: All the normal stack just with the CXL Mailbox specific stuff factored
>               out. Note we can move different amounts of shared logic in here, but
>               in essence it deals with the extra layer on top of the raw MMPT mbox.
> MMPT Mbox: Mailbox as per the PCI spec.
> RAS API:   Shared RAS API specific infrastructure used by other drivers.

Once the CXL mailbox core is turned into a library for kernel internal
consumers, like RAS API, or CXL accelerators, then it becomes easier to
add a Switch CCI consumer (perhaps as an out-of-tree module in tools/),
but it is still not clear why the kernel benefits from that arrangement.

This is less about blocking developers that have different goals it is
about finding the right projects / places to solve the problem
especially when disjoint design goals are in play and user space drivers
might be in reach.

[..]
> > > The various CXL upstream developers and maintainers may have
> > > differing views of course, but my current understanding is we want
> > > to support 1 and 2, but are very resistant to 3!  
> > 
> > 1, yes, 2, need to see the patches, and agree on 3.
> 
> If we end up with top architecture of the diagrams above, 2 will look pretty
> similar to last version of the switch-cci patches.  So raw commands only + taint.
> Factoring out MMPT is another layer that doesn't make that much difference in
> practice to this discussion. Good to have, but the reuse here would be one layer
> above that.
> 
> Or we just say go for second proposed architecture and 0 impact on the
> CXL specific code, just reuse of the MMPT layer.  I'd imagine people will get
> grumpy on code duplication (and we'll spend years rejecting patch sets that
> try to share the cdoe) but there should be no maintenance burden as
> a result.

I am assuming that the shared code between MMPT and CXL will happen and
that all of the command infrastructure is where centralized policy can
not keep up. If OpenBMC wants to land a driver that consumes the MMPT
core in tools/ that would seem to satisfy both the concerns of mainline
not shipping ABI that host kernels need to strictly reason about while
letting OpenBMC not need to carry out-of-tree patches indefinitely.

