Return-Path: <linux-kernel+bounces-161099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED9708B4718
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 18:22:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A38F12824F6
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 16:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCF601DA23;
	Sat, 27 Apr 2024 16:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qawr9JVN"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C8C8F77;
	Sat, 27 Apr 2024 16:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714234950; cv=fail; b=u1x6dCb6YFbhK5lAGrSt9KQG6qOtPum3ltWHXG46xsr8NVQHBGJSTecQK114fOeZM5Y28fc43wTF4KprlMCEHWhbNcDB4304SHJ2SgZTyU0WzHgz8mHy2/lc14wvMEwSv0soiUO6z+Jn9ie7iw3+gouqsbSQyiJGn4UE6y9EPxM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714234950; c=relaxed/simple;
	bh=DHjZ+QEGfTunoHOgEC31jyovjDg/Z1JKqzpHOQN1QAI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=D1DyyQ4H1ovajGY63vhyPiSKM/g1pFhFSfDoZzZwsZ4Zjew4u1wJywd+5kGzGNQJSPukaPxoUZHzMs7+gF3I1PXbK9/jhaNiLRMKwQAdktv9FWQB9p92v7jM/XJpXtq5RezT91uMTeSn56VHElcWdPs7r2nZagbWIdJAaTSFfUU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qawr9JVN; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714234949; x=1745770949;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=DHjZ+QEGfTunoHOgEC31jyovjDg/Z1JKqzpHOQN1QAI=;
  b=Qawr9JVNZgmvtVjnRN370Meaqa1yKwiRLqGDSv4Z94RpuPZcQpX7YNPi
   Ib/3r/wEYNUmIc/0QPSmhpJw2W7zz40faRryUXp3Lhbl6YWAXdw3pTEU1
   4zUzmOMyn/YKFzD0R5oEQ7+dCWnJDANHjhOLrsHq9+dRth/Jj5yUO1nIZ
   9//XS6Ej+Qi1D6E5jpUM14eWtuRjm/1W2AFublbowGi8UhLYGFaDMC81w
   q5tUrIxP2iB3sKrQf5AepGwYOVVyl0OAS10IgEv1WkM/RDwtZf1PZLpjw
   9kJIlAg/QL2pOzRP487aauU9FUHb0rsXqgLU9+eEoFjqcdk7dzeHkcckH
   A==;
X-CSE-ConnectionGUID: 7tnKAvYJRk+NU3TWR/PzRQ==
X-CSE-MsgGUID: bsyfiz52SRKH64HiTgJOEQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11057"; a="32454125"
X-IronPort-AV: E=Sophos;i="6.07,235,1708416000"; 
   d="scan'208";a="32454125"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2024 09:22:29 -0700
X-CSE-ConnectionGUID: DQ3CZlsmSt2DN9ftLWwoeA==
X-CSE-MsgGUID: VOvhCQTrTc674DAXeMpytQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,235,1708416000"; 
   d="scan'208";a="63174939"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Apr 2024 09:22:28 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 27 Apr 2024 09:22:27 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sat, 27 Apr 2024 09:22:27 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sat, 27 Apr 2024 09:22:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BzQaVAKE4POpK98myPhHo4JijMEnsEMTb4zs22NmQKQ0X+M9Tu6ZhoZaL6Wwo2XfH2swQVwpops73pbhgnfk+hE+oDw/PEV5E+dYr1u/GSgc7OL002ahjEGY1MH5jDlkO/tL2YeZ18py5bCwM6B84rBwndruGkHWJqAiC5/vfIOp/drMYuAe3TSvhwRAb/WwZphbc5B3GxjBj7eRh+ZV5pDpV2fCGOgD/bDiqMK8JO+eHE/MZAhaKprp+ZevvA6WZw0j89crq9jTC1k6dQn1EsfeB5XHHc71JML8/p+WhqVm3Q6mVzT8PBEnsA98clSIOePZeu9+rDbFXT+I6vXCbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ha+uahDiGGfJDoNuBrGY5Lia05aAQj5E+DDipabnKvo=;
 b=bEOknTZ8QV/0/3ay1ZdzSKFLlj8yQloxvBf3B8yBLysbs1O0SBqqViZNTZyU/ulJ7uIbpIi0P9S1OL/eg7dllKXCZBKrv0kQsc+dXQhbyL4uj5AM0YlakYjV1/wPVHHxOaPKeIKZzxlaiJSsX8xsXogACWGgSvFfKHK8lRpx+Efv9bzPq46ZiYLBNm6jbepASg2+C2pqUxocaFvCzgiyQDmdCalIrsBzMJfynXWhvikBI7jr46FXSlvOEIpFShu1uSDNmSCzPSj4HPCbnrU3QC/MTDTsIwN3e+OptYNM6wX+U3H4YfXcD8h1zaGzLWhMWHGLa2ZETirC2b8lwuQ19A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA1PR11MB6614.namprd11.prod.outlook.com (2603:10b6:806:255::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.30; Sat, 27 Apr
 2024 16:22:25 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.7519.031; Sat, 27 Apr 2024
 16:22:25 +0000
Date: Sat, 27 Apr 2024 09:22:21 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Greg KH <gregkh@linuxfoundation.org>, Harold Johnson
	<harold.johnson@broadcom.com>
CC: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Dan Williams
	<dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>, Sreenivas Bagalkote
	<sreenivas.bagalkote@broadcom.com>, Brett Henning
	<brett.henning@broadcom.com>, Sumanesh Samanta
	<sumanesh.samanta@broadcom.com>, <linux-kernel@vger.kernel.org>, "Davidlohr
 Bueso" <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>, "Alison
 Schofield" <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	<linuxarm@huawei.com>, <linux-api@vger.kernel.org>, Lorenzo Pieralisi
	<lpieralisi@kernel.org>, "Natu, Mahesh" <mahesh.natu@intel.com>
Subject: Re: RFC: Restricting userspace interfaces for CXL fabric management
Message-ID: <662d263dd17c7_b6e0294ab@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <66284d5e8ac01_690a29431@dwillia2-xfh.jf.intel.com.notmuch>
 <20240425123344.000001a9@Huawei.com>
 <662a826dbeeff_b6e02943c@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <20240425182605.00005f22@Huawei.com>
 <662aae2fe4887_a96f294bf@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <20240426094550.00002e37@Huawei.com>
 <662bd36caae55_a96f2943f@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <20240426175341.00002e67@Huawei.com>
 <6351024b5d6206c4e9a8cd98d1a09d43@mail.gmail.com>
 <2024042708-outscore-dreadful-2c21@gregkh>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2024042708-outscore-dreadful-2c21@gregkh>
X-ClientProxiedBy: MW4PR04CA0272.namprd04.prod.outlook.com
 (2603:10b6:303:89::7) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA1PR11MB6614:EE_
X-MS-Office365-Filtering-Correlation-Id: 52873962-d250-4f26-a901-08dc66d63938
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|7416005|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/c3GGsXdK75DFDqCSEU1/n3MHh/E0ExrYog3lpcL8DmYU2sDbP8P4y797yKv?=
 =?us-ascii?Q?VxZ6PHpWGOv3afsEDsdhFiXNNwgu0wxugUFMJ4SZfWwNUjuLPTKeZqe8ULyd?=
 =?us-ascii?Q?opoB45gr+1ykERCNtVDJoNKo6hhNpoiK1DU83oHp2weCCoQh0Q8ARG+o6TjE?=
 =?us-ascii?Q?4mg3lqO2quKQMjYdNAasKoD3clX63e4c+ZX0Iyz1ZY4AxN4PZCIvBSigpR8h?=
 =?us-ascii?Q?DvgkO5jyWFr6hXI/JIPxsJKnpkcHwx8z5q9rJo/k4nvDq2GDtBFdrfwFW9hB?=
 =?us-ascii?Q?8ynSgiUAV6vtv+z0VUgNi75EewpmOQUlGSq2H2KhY9k8Zm9JCiTUxlh99LXz?=
 =?us-ascii?Q?Vvq6OOSgjsPuy4StA8rCcVVDJUmdL7i1fOxzQtcmBdk60LSuDdIjodhMNTjl?=
 =?us-ascii?Q?SDcEu1jnV83OwWXvmYHisxOtuhAAF5pYAPAxBbHc7uSvS02EVYwO7nxLiUZR?=
 =?us-ascii?Q?LEXSz20bTKuckEZPKGLuwVpAFWtE2VTVvNSR5iAKIc9aX/wkAjd6RY3UU0Fn?=
 =?us-ascii?Q?yK1CrE6uB6HFj6/6OmkSJ5Qn1JkhmvuBBuPeBZwGt4/BPxTBqLnCJKEDYGmf?=
 =?us-ascii?Q?QpdB+KRdV3zRuQHId1geSWlR6mDPThMCV+AoQeVuJDC+kvhRAvYXAwPx6ocl?=
 =?us-ascii?Q?eSllRg4c3sxfwfQsQM90fc8ZGVUgCkmS4kqZPW9zVGpbGzSoKw3yPqqBIVpZ?=
 =?us-ascii?Q?OtWNzKsYLxrQ4Q18Sb6tTyLfOtJim+DwFTrSw9ISh0E90lSSk4mDKwoMlw/e?=
 =?us-ascii?Q?QPBLsGWMG1zqVH6G69gD2sJGSSTdq6KgLurMCjVreN+mnzSeqJKbR9zJ75/R?=
 =?us-ascii?Q?7eSBY80dXJCPF71Auxu0xx4EwPm+H1tLW8v7AohHiepedEze+rw0FzdSPDYR?=
 =?us-ascii?Q?jMPtFmDoN66M7fAcA8zXYmsyO74fffRerZ/Tx7qJem2b1LD0dq4+V151vj+w?=
 =?us-ascii?Q?2ov2Fo3mfew8aJi4oGc+VMuw3iRX/eDFM8H8uVV/arCPBbFLJa3DegKAcb8P?=
 =?us-ascii?Q?wz93wOKR4C/03wlvf1vd/QCD8e4DSnQHNpYIFLU0imvGl1+Ifs66N5VFYN+9?=
 =?us-ascii?Q?Glldyy82z5GDDKQmG2V6Rr7XEDMPtwtxvE71uvJARAVMrvhy0nDGj38S5MgL?=
 =?us-ascii?Q?ulAbrOp4o8ILnRvrO6Ln6D4BnthNLfqMYhmUi0dCjK+wRDcGSO2KCWX4RZNw?=
 =?us-ascii?Q?AzMaP+0EIKUm9DW0PPH9GowMQSVXE0Ui0wVs65b2d5zYK3DEDwYFOS2MPRE4?=
 =?us-ascii?Q?/0uc9rJiifkgRXiU7Besd2JmMQGS2Ok4vQeSpF3izw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0c2+z4wcZRuQdqNJsL53Zc9Ijh+bkcFro2/7UPBE7zt85SUGDvFPf4P8+GLr?=
 =?us-ascii?Q?v3kZxmkoO2Gf9xvw40VMmiMwCX+Dy9WlXLVI8RSaQsdNua6S9D/FSJT1/PY1?=
 =?us-ascii?Q?zRm8JYJPRR9LKLu/KOA2R5NRQOZk8tI7WtgGPw91MXhCsFDvfkKxQTCzfHIP?=
 =?us-ascii?Q?xaHUJmDVt1Scf+FNDn+s2WKgEpQYvbfTG5Sh2ZBsSbVgKhDyzSoDmcQPr9zl?=
 =?us-ascii?Q?h79u3KwYOwlg93yi50SSvPL3IkeARD0U9iOnoOVHO/FIOxpRFfamlwAjshpb?=
 =?us-ascii?Q?3iHf8Ee/hqoNJoSd3WJqo6vBxzcox63VWfL+Q1Jq+/Uiy28UQAGYto/Uu/Kl?=
 =?us-ascii?Q?TUp/BxDezkd/aIhzKi5ATVZ1/If8S0cYFr6VGUHSvkLZu+SUyiTtJJ2Wuokh?=
 =?us-ascii?Q?aj+z0O8VxRTcrJCYYMrlSPw39skI3MRuOJwuYt/YcAg366wVyCLNloFLcBGV?=
 =?us-ascii?Q?Y+QYbJqp3iX3z4d5zmwk924ufrziS/FWqQP4GTR25KmIvGXbjRP5cfQ+Bjir?=
 =?us-ascii?Q?9ImWw/vd8JF1Wa2xZVtqMfJvtY5ZhcPKT3Eq5InqLRBcgAO4dmz4ZQs725ZU?=
 =?us-ascii?Q?8/ESsOK1qrrCWFpp75HdascRZJkhO2+/rVxB+jAMoOF1o+3fxBMkeXKXuKOl?=
 =?us-ascii?Q?A7tkiAeBeU3kYa9u14LoRROd1CH8IGc4rk4k8+dkrBnufQrRKvpr1t0egf2c?=
 =?us-ascii?Q?3yECsxesYLcrN9oZ7RQIwPBpwIugdAFFL22FULya7N+Swyn9Cpp99BJvuwZE?=
 =?us-ascii?Q?7WotSdvqWnYQ1CcBb4tsnaiL5EbWGv1a01/9UBBYJHtD6KNIn69PdzHs8IGq?=
 =?us-ascii?Q?us0xSNSZbxL2VeDqKhkc35L/qnXt0SfckGrNvzdBf5RtBGSkQoVbxVEGXFEc?=
 =?us-ascii?Q?4srKRBdGLYKRALLwRqUS0NuWnBbc480gOZna1tMG3MZF7AGZH8ScyUUMXrhd?=
 =?us-ascii?Q?0/aBWsibWH3BWj7qcRKJoVRBKieLE/ghWuYEN9J4wcsI1I4KElvswT9vnSp5?=
 =?us-ascii?Q?GReQzSMDGLeZum03qbf2NRsphAxJZAX/DWKeYiQmhzn+/wWgOo3ZLk1ErdPf?=
 =?us-ascii?Q?iNqIgtJ0RuqzJX34G5nqxP/bQMH3PnF+Y2FgjJQL5szszb8GdO2MXS9GkNhd?=
 =?us-ascii?Q?/rGlUUU4VRskIplxCv9VRfOjTyT9GkdKxcmF+dEVeci49smFVg74BnMZxDmJ?=
 =?us-ascii?Q?4jgTpkFuBSARTd34bUhpXwmw5nfUN3FO8P5uGG33hSMXko9mZ2IhkXAa1Zny?=
 =?us-ascii?Q?nC45tV84GW0JUni0sJux83Dh+Y9Cem8L7SG/Vzh77CiE86Y82RHcOScf9wyU?=
 =?us-ascii?Q?Wfa0/ZI/8sTRxW5CZa3lUhDlNCn98kMV2FVc+IhVNSa7wrGye+j5Qhuic41w?=
 =?us-ascii?Q?zhuz4Pc06HzWietxFYF8CsM+v+FvO7bHprbAtyzeQdbDEByX7NRlu/ToGWyh?=
 =?us-ascii?Q?+5K97HY1gmc6nGlmnM1h5EAAV8IwKSa5p2v8Qby1vBjcWsGmhyAj0SSf26M9?=
 =?us-ascii?Q?Gebv5QvTcVrNlslLVxJnHWmi7hx3TCi4GwOEx3Q26ohQqZTYG7IntTYsdZQk?=
 =?us-ascii?Q?wvRa6SxYOh4WQiSFgFg98r0F6rxNqZz7TkKggfKINYxC2HIXDgP6uNownA4H?=
 =?us-ascii?Q?Fw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 52873962-d250-4f26-a901-08dc66d63938
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2024 16:22:25.0907
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jPjC6hnm/XxeJkpvdYAL6jJ+hdoHGhjVQJqshU1UpZ0dDXYS3Y+RWDpq48MJQ0VtWoTZOqGAn5kGwqwa2J0EHhQJedy17dE02DLOR8dYB6Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6614
X-OriginatorOrg: intel.com

Greg KH wrote:
[..]
> So while innovating at the hardware level is fine, follow the ways that
> everyone has done this for other specification types (USB, PCI, etc.)
> and just allow vendor drivers to provide the information.  Don't do this
> in crazy userspace drivers which will circumvent the whole reason we
> have standard kernel/user apis in the first place for these types of
> things.

Right, standard kernel/user apis is the requirement.

The suggestion of opaque vendor passthrough tunnels, and every vendor
ships their custom tool to do what should be common flows, is where this
discussion went off the rails.

