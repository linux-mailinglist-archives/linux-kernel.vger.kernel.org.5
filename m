Return-Path: <linux-kernel+bounces-163363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE328B69E2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 07:26:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 401B41C21FE3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 05:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C52E175BD;
	Tue, 30 Apr 2024 05:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TyuI8abk"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE2E5256;
	Tue, 30 Apr 2024 05:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714454766; cv=fail; b=quPF0G9Kb09UTunKhrkkgUqdGlp/UMHvEmRUGeN+YWF6dYCyabYqBn0PvliRYGgjwxq3ekDIjOvvwSXjssXPDzC50wPTOC0o3JylcIo9Y2UkHO4fyUt9dQMTLGfGMEwegO7d03iwczRlgLzbELtfC8MNwe2RXN/T3GHCo63chpQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714454766; c=relaxed/simple;
	bh=Ov5oH2I44ITX+UuD03/feA3QUahhSxZSMCeuW8yRM1M=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=heVubWWR+T4DfMoZ3u1X6BLdvtX7zfLJm+wbXBkJ8uQGpsk99RFP46YrBBwKQuiyiOLx5IVQHyuaN8fqmAz8mVGu1Y9/w71WEEFdU3JUfiF9ronLZilMAdwA06viarl990LYP6VC/8x4sXOmQzpXkWIE7ogMIr19l/OuUqO/z5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TyuI8abk; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714454764; x=1745990764;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=Ov5oH2I44ITX+UuD03/feA3QUahhSxZSMCeuW8yRM1M=;
  b=TyuI8abknIT+4RfNO9bOTRqeWNcGtoZQ9HAD7NF/cY4MnKOOrT2jOazt
   rTCyo1XM7YoZVJJ5JedEP1QLos7kqDYrOvDggQFGzwFm65BWrb/iOSyiZ
   cdAHneNLXofVXrfPmIlz4gER2q4Kg616ZEt9u/UXYgcZYnuRq7pwt1Gp5
   pIX2rULFaIblTtrcIDh+Mw1gj6kW22jgexm7RI4fF9XdRcmMzj8W4BoUj
   27LpStPmSY+oFvYXZoogGWM+SMQhbMPfGkHRhAMnmLq9kJgavBhzWFhbE
   9T5klEncmFF4FMJ2UMPySvv7ZGgoXIHGc5rj1DQNOCTRUOogJNIQmFst/
   Q==;
X-CSE-ConnectionGUID: u0Y2uf0bR6iS0rkFZLrm/w==
X-CSE-MsgGUID: BC8DBIOvSPGIdr93l4pPRQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11059"; a="13935818"
X-IronPort-AV: E=Sophos;i="6.07,241,1708416000"; 
   d="scan'208";a="13935818"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 22:26:03 -0700
X-CSE-ConnectionGUID: 21nMgj7mQ3KSZUvIeIJNNg==
X-CSE-MsgGUID: iM+v/WDxStWlyjBrJydy7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,241,1708416000"; 
   d="scan'208";a="30792731"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Apr 2024 22:26:03 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Apr 2024 22:26:02 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Apr 2024 22:26:02 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 29 Apr 2024 22:26:02 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 29 Apr 2024 22:26:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mugQcrQoJvXhkBSySnFMKLzn7WzOqbMs5BfQxAtl0l6phNZSHkT3ATuRP5z6RENT7q0uVvZRaMl1tx1LM3iwPegd3Hk1twfP0IW8YJ130/5CI4tAIhOx97DvVKrt0iDaMYv9TzhFEAiW/8FhnOPXY0xPRLYi5b4HmIHBvd9ffWpmRUhQ8yPBBbg7cwx02aYBNcnqfBoWg8kOIndcrYJwxAdnNQyE+tPNbXhopF8oNwYY95UORr7D3rBWxdREMWdruiBWTCgwYjabr32EdcN0f3v2gTYaW47GN9C3RIdHhQni4t1O56Y0NYXkl+p6vXORTJudU/ouAGSztMPSJvf84w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0+up84rqQ/h/pFpsQi9SCKLQyF4tuWdF9k+zsOMpBwk=;
 b=fYgBBHrnfKUtI40OECb/rGgki2lcCX/80vjMZYOYUZXUfskSrx2yaBd2TscaXt6yFs5t2peLTibXJXnHoDf76fAJHeJP9mywOGbnhose9oWddpT1y6kWqDZgCt5O4ZaeEW7iGMh5bOlxpJN01Gl5qpoeCuwz55eJevjKZCDcrQV+Cy2KHZrHsswO9Of5EEJTs2Law63b07fTLJY3KxLc6BbSBQKI6eNH0Z4fUCtfANkAK/E95w5Fb37NT2wYSDhaBPJx8SWMlffTxpcQAv8RBFTm2Ji+YFieEKDBABpWwNfP6X1zYn2lanVa7zr9hKbbOyZ+mNdRH2lQ2mcxFjsUyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CH0PR11MB5218.namprd11.prod.outlook.com (2603:10b6:610:e1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Tue, 30 Apr
 2024 05:26:00 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.7519.031; Tue, 30 Apr 2024
 05:26:00 +0000
Date: Mon, 29 Apr 2024 22:25:57 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: "Verma, Vishal L" <vishal.l.verma@intel.com>, "Williams, Dan J"
	<dan.j.williams@intel.com>, "Jiang, Dave" <dave.jiang@intel.com>, "Schofield,
 Alison" <alison.schofield@intel.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>
CC: "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "nvdimm@lists.linux.dev"
	<nvdimm@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/4] dax/bus.c: fix locking for unregister_dax_dev /
 unregister_dax_mapping paths
Message-ID: <663080e5be58_148729453@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240416-vv-dax_abi_fixes-v2-0-d5f0c8ec162e@intel.com>
 <20240416-vv-dax_abi_fixes-v2-2-d5f0c8ec162e@intel.com>
 <6630487879c61_148729427@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <d4047d21f0b88c5baee9140adb56e86afca24b3a.camel@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d4047d21f0b88c5baee9140adb56e86afca24b3a.camel@intel.com>
X-ClientProxiedBy: MW4PR04CA0211.namprd04.prod.outlook.com
 (2603:10b6:303:87::6) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CH0PR11MB5218:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e834071-af41-41f3-d1c6-08dc68d60510
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?GBYykBo+nsXFPsbThqvY7q2hEbNjL/uTzOgfXLTI5q+tWKJ17DtJz/bY0d?=
 =?iso-8859-1?Q?MICjBZLXEBahGTf1lmBOcYKXe13xGbzk05dk4xdsTjYyxhNq4v8QuRcCy4?=
 =?iso-8859-1?Q?+Stdkg8mHiBFbSA5Sy7IvMkywHMRFxpzNhJPBXAXe9T+9iLMrv5vAYm7Np?=
 =?iso-8859-1?Q?Y86t8I0sGqM6l8J+iTd6gANT8JL9bWYcbUiQ0rMeRya5mFuBdJTnKCwUmj?=
 =?iso-8859-1?Q?uzH/jQcOXg/Ka8AmAkMiHTSQ4QMKdOryCnH2yHhM8vY6AkUDlL+ZLzmTwE?=
 =?iso-8859-1?Q?ilYeqee/IebMfLSWgRuTnsJ6iPa5onT2ZPZzh1EQNs12hdpj7imFPpcikZ?=
 =?iso-8859-1?Q?sOdawXUQJ0YMSxhcuceJHP9705a2UrYXxLraqb7R0AhS8TcVPKZpCY7YB6?=
 =?iso-8859-1?Q?RP3w47u/RS6yk3xQVWsGH2QejmiaB2mW//yI8Sryi+17PnEy0yOkHyCnIh?=
 =?iso-8859-1?Q?ChOvJD7gJmid8E+RTKrK/xKgH8oAwAaL37gSQxkyc5FxgZ2/EpEhKXHtPP?=
 =?iso-8859-1?Q?bHbxbfkOccAJjuOFjwyXULR5nJep4G9xiFPlby0s1xipsk+kBm8AhAbBty?=
 =?iso-8859-1?Q?jFGWIcd6UnZ69DCPnVHyRBU7zl5PhHZpP1x8rH0Fs/CnuDy3DhmY9+JMDF?=
 =?iso-8859-1?Q?5w5MUyC8AOIL2XDYC7piZ3fFIASxDL2nj/+GjBimFKvkHpTCZO3D+uz/lD?=
 =?iso-8859-1?Q?vu9qHIFBFHb7h/YXQTVGMovhqeDE4bytQlUXAyvvwciSHlXtCDfs81rL8P?=
 =?iso-8859-1?Q?3lvx0z0WlwuLSCmk2se2CUhtvFPdgDfJBO+F/wyL3yar0U5O3+aescJCWL?=
 =?iso-8859-1?Q?oAFNXXvZh47BiAEIYW4WbC+wxkJIi7Hf3Om7LEcrx/b6qy+E/yTpiOmHZK?=
 =?iso-8859-1?Q?zgGtN+oeU92sqyFS7/y41ALOCyejzD3bpoc0e5hJbVTfhofntNwA6IqvbJ?=
 =?iso-8859-1?Q?LGuz5c793DE42rF48m/9q6jqH6Ubg9euxlfJgU9YcVPWUQq10AvhqeutqB?=
 =?iso-8859-1?Q?4drjHj+Dck87cZnvyEkE2di52JEJxmtbIbpXnHGqW2Cn3pQ7jbPnfshodn?=
 =?iso-8859-1?Q?4veMOfVb06n6kr5l+F+LBR/fINfG60w/encHH7ISnRWqbkbs8qwzK9YWqy?=
 =?iso-8859-1?Q?Q+spE5cznT2znC4hZP3GzNLmIYL3Q3c7SOHFJ8LOaF7ramLrwy6690wsdj?=
 =?iso-8859-1?Q?KMMW3a+W/PBuM3GD/tFAvGZ/6KrZYDmSEmioIMZz8wslm+bF5HNkmUzJxL?=
 =?iso-8859-1?Q?KgCYCvp93+XEcWJu+MtpQTalaLM4/Uh5l6eHoXpN/TDlOCRiDKWF4NJVIQ?=
 =?iso-8859-1?Q?aF2ickmzW2MTEZ+1r4HK0EYwgA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?C77XKp9k0qdnbiXFOp+ZGdlrl3xpgrlFto3Rk6rRqzsZNbQJgP69fu7ZSM?=
 =?iso-8859-1?Q?oGobuqx5BahsKN+Uh6vrvjKhATGe/0ATsVkaG46ainIfI/QTXs0dvhuvNT?=
 =?iso-8859-1?Q?vhEQeGvsoeGdldasDOmhKBu+2j73NiZkof+UUjPTGGLaeza7w350+bbaGQ?=
 =?iso-8859-1?Q?4H1X6hPEyDqDapl+S6OZyWH6XFVjx/Y4KCKfF4kbzoOzCTlR6byeMKvpLe?=
 =?iso-8859-1?Q?115DN40Ml4RpgU+9CFRzOq3CWA2MEfPv2fubJhW2KY4rhdo5ij76Zt/k1o?=
 =?iso-8859-1?Q?prjOQ8qGzG+pJ1ZEKU3s1kdf9hicJD6tzufohPu5uDx1TjB7VpnEhD+ZPA?=
 =?iso-8859-1?Q?0ebvRtdnma7uVij7RvfsntVWb/2GZe9BSBrFZQNzO5Ui7kL/FiErzhu2p9?=
 =?iso-8859-1?Q?6cRRAWUTpGr6Gf4juVsWhPSupZBdDHXpL1XDTKQCNTUP19y58/qdnbruBW?=
 =?iso-8859-1?Q?D3svGXfrTFoWLKMb8OYbJwLfyIVmiSCKYRRy2fq38bQgk87fYC0bXF02xu?=
 =?iso-8859-1?Q?7Ej1EACFModta1x1rHnA561vL8NsMwbzhqXoYPBSgpanFi6uK2AWxfCbJg?=
 =?iso-8859-1?Q?ZxqjQhQtZ8mnXf0WVAinxlD1vluhh5p1MYKGQD9b9Aa6ZUu0vB0ENn8Qpx?=
 =?iso-8859-1?Q?HG+X4+oiwCXmxnl8FMcKCMiniDNEcOe9keQVhrfZCr1CJA/cHNI1mowv15?=
 =?iso-8859-1?Q?J6had9cZiwTIxdLbqfvqhmokLr0lHr9LxPIMRNHrJ7dRm2WZdfleFxNcGf?=
 =?iso-8859-1?Q?1/5Gsrc9eNNg5dDG7Gsvl2LCMYpoKBgSVDdjWoN2ezi/g+BU0e7DS64smF?=
 =?iso-8859-1?Q?1d8ZgGEvH5MQiB+X1btjbKWbXtSYd7nApDLfjtbtObsYEmcK5u/4g10xKq?=
 =?iso-8859-1?Q?m/JpmR5EwRek5eWUSPhOfQ3n4xhaBCxs/rJ1IY48yfNy+cgMMH6VJnnxeT?=
 =?iso-8859-1?Q?8FsTrNS94HkqezPr0pWrfSXhX3jjmTcHa+vb+8zue3aa9ClN6JU1k6KsI8?=
 =?iso-8859-1?Q?LLlxGPGj7hwyZ6L2iAqlvc+RUC1ScnwcwtiGqK1XZzCV/6MdDICWRblKhg?=
 =?iso-8859-1?Q?WKxMvUiOHeM5AaseoQMYPps6JWTfgACTWfYGPa8rbIvHohMQhbkIJh0j2x?=
 =?iso-8859-1?Q?dgYaHH2R8rBvdGRj1hqvSj83KbcSs5iXiu0z8shjtrZZzg60qwTZNrdbge?=
 =?iso-8859-1?Q?OQahDm/IjegbljI3OOHJfsQbaJuhfEtHBynwKhybajQUzTlWjLdM146a3d?=
 =?iso-8859-1?Q?3/jiDP+0mNCGANrW4Sney2H5AeJNhAWq2k33fTSxTSBFX+8Sdie9Vx0rec?=
 =?iso-8859-1?Q?uHfhkwLgnumpbLJb94fRhom3ObqnjjLpulS0LUbH8WA6HbDcbtx6r3shsf?=
 =?iso-8859-1?Q?ief0BZhAMymYxfKGPKNMi5EaJqZf7+5Xtqd3Qn2UA1l7YwZTxXuBcuyEHf?=
 =?iso-8859-1?Q?xCLsSA47VBDMSTpj+XZb2z71VitX8d8o81N1t0UbmFE0Jdh3jaEuY9Qlea?=
 =?iso-8859-1?Q?mu7HHaBXNsxKUsFYbZ3N6mZEuVWhViwXpLA4sH5s29asu+MbSL42ww8VcF?=
 =?iso-8859-1?Q?IXZt6XfyB7KNNLCJ62BAd4lrWOeLzgrVgjF3whLBxB1f5A/bHtwsPJhRXn?=
 =?iso-8859-1?Q?I+JRaGF5gD+zeYF0fEF57heT2kjsQ3V86J8RjkxQi0zW02SK+7eEVkzg?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e834071-af41-41f3-d1c6-08dc68d60510
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 05:26:00.3317
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7bAb57sGG0aZndMUxpR4lMLNfRctrx4tVkxpFAyEucdo9pFwNkYvW52KXG5HDqdETEbP/eLPgZmICTemhHMCzqp36jsR9uIp8q4MLOxkQNg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5218
X-OriginatorOrg: intel.com

Verma, Vishal L wrote:
> > > @@ -560,15 +551,12 @@ static ssize_t delete_store(struct device *dev, struct device_attribute *attr,
> > >  	if (!victim)
> > >  		return -ENXIO;
> > >  
> > > -	rc = down_write_killable(&dax_region_rwsem);
> > > -	if (rc)
> > > -		return rc;
> > > -	rc = down_write_killable(&dax_dev_rwsem);
> > > -	if (rc) {
> > > -		up_write(&dax_region_rwsem);
> > > -		return rc;
> > > -	}
> > > +	device_lock(dev);
> > > +	device_lock(victim);
> > >  	dev_dax = to_dev_dax(victim);
> > > +	rc = down_write_killable(&dax_dev_rwsem);
> > 
> > This begs the question, why down_write_killable(), but not
> > device_lock_interruptible()?
> 
> Do you mean change the device_lock()s to device_lock_interruptible() in
> addition to the taking the rwsem (i.e. not instead of the rwsem..)?

I mean convert the rwsem to drop _killable.

> I guess I just restored what was there previously - but the
> interruptible variant makes sense, I can make that change.

So the original code did device_lock(), then the rework added killable
rwsem (deleted device_lock()), and now the fixes add device_lock() back.
So now that there is a mix of killable/interruptible lock usage all the
locks should agree.

Since there really is no risk of these operations being long running
there is no driving need to make them killable/interruptible, so go with
the simple option.

