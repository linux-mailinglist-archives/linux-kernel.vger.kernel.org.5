Return-Path: <linux-kernel+bounces-48724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E635846046
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 19:47:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09CE61F2D3DA
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 18:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CDC95A4E0;
	Thu,  1 Feb 2024 18:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Td0DnGoF"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B214412FB32;
	Thu,  1 Feb 2024 18:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706813220; cv=fail; b=EgkUdksHTzbK/FyL2HbVXzH813RHkP/nVKuvXeHvnfdUYtSD8fN++ffzyX5mUcI+qLvksVswiyTSNnPxgYf80qLPKBD3LbVopJJPm29QVXmx0b4N3xtuEENSxgcwmxMx+NnecRUpc9BDPDJfeeVbUr6KxzQH1ock+L4fLMD2tDU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706813220; c=relaxed/simple;
	bh=HHgaFsu4s7Sl76VFzhpB9CxxUaWPG2Gdoq3jHd0Ha3c=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=db8twxw9jRrB8A9bj7BEkxgqz1FFI8jTk8hkzKoHEGBasjYpUxXOKVItKk7NF7sfUxMGEhj03WejwJX84sj+ZQhRiJwnKlLPiiek/aB7mVKCMS6yw8M6FwdlmcxlvGqJNbavGaxnQC1DC3EAOGck8ZrDGAE0ltnVcX5PjoR/fAI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Td0DnGoF; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706813219; x=1738349219;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HHgaFsu4s7Sl76VFzhpB9CxxUaWPG2Gdoq3jHd0Ha3c=;
  b=Td0DnGoF4yHAovxyEEiwybdGdcri2aSCBsGmKAXG44KdrnX+aLGnHkTZ
   hrWf5zPhu4NOi13ZneBQyyO7B49xgQKaldjW3uI8zaRTWUxF3h7fCgTU+
   UGUtp4HbXVqpUKHRlVg7hK2dDlH9C88GeCwYDyW78NFgwh/s/5jKJKkbC
   qJaUXUo6eVva4jx1OaYo8f7FQXIXwuMYR+oX6fwWFuVby7fL5wMwSzuws
   N67yx7KQg3N84qbNrR1W35VyUqkQe/1+GhY2NWLfNok+kvnr4PYYpEUQf
   NynZWqH6iUBhhKo08ytLqUFtGAeHXWpnlEWfXmxsu22/WylcMzIYAOpYP
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="2903816"
X-IronPort-AV: E=Sophos;i="6.05,236,1701158400"; 
   d="scan'208";a="2903816"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 10:46:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="859204591"
X-IronPort-AV: E=Sophos;i="6.05,236,1701158400"; 
   d="scan'208";a="859204591"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Feb 2024 10:46:57 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 1 Feb 2024 10:46:56 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 1 Feb 2024 10:46:56 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 1 Feb 2024 10:46:56 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 1 Feb 2024 10:46:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iXv0D91PR/lCbB+3aFbkBVOYzGymVKFA+EcZDqS26XfMEYtKzQ5vlVGz8ux5uLdDPU9QGB7LuUDhxE3dezObxCA1mZA/B+5PFUNAxz/f4Wg04+aLeojdGqBXlw3pwS4AIW/h8+tYvT3tOeSkUWAnkqnxfO3HaxpfTzUGbTQcxHUcLLz98sSJxaGk4c/YJ8i2x4fMHrIcCSgaxyyWAKBCAGaUAxXnhE6Zt4U591723m+k7o6kSga+/xqY5Zi4wCA4mQYG+hnK82W8ePXWR2Kmct9/akSvtQGhrX7h0tQf143t9HMOH7Ni6IOJJvcIndFPWJng99mwSbDC+dITqap/qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ChIPZ/n6IVbAc3HXsho4BLH6NQVIvTvLuUeE5sMD1rs=;
 b=ZiJVtXwKpITxi49SEJyGnbIsM2tBEe2k4U81kb7Yn+bN06J3kYXmZoTiRLNqM3p89mfj1tCMyb+Kknh7yWaU4+DEgWPhOAQK/WmJHzoyDUAaD64tNHx/rcO4XrGEyvOfAushUQwzFXLFCAFtwy/AOXyV24IacgtepyURGHKa+8gD6rRiuktRxp7fRUJ852D9HIQoFAIb0GFqdBzGMuwv96u12Uob4Cex8FvQAbcCaAOY/PQRjwTf8cpo9QsA525HvhlboeFnFaACK3QFSzoTwweMR7XP+ONGffcG7VsaVnTMHn5BsFdQGwt7rR5vy0jnZL1Ct03omgwLavaKQtqadA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by MW5PR11MB5811.namprd11.prod.outlook.com (2603:10b6:303:198::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.26; Thu, 1 Feb
 2024 18:46:47 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa%7]) with mapi id 15.20.7228.029; Thu, 1 Feb 2024
 18:46:47 +0000
Message-ID: <78c88c6d-2e8d-42d1-a6f2-1c5ac38fb258@intel.com>
Date: Thu, 1 Feb 2024 10:46:45 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15-RFC 0/8] Add support for Sub-NUMA cluster (SNC)
 systems
Content-Language: en-US
To: Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, "Peter
 Newman" <peternewman@google.com>, Jonathan Corbet <corbet@lwn.net>, "Shuah
 Khan" <skhan@linuxfoundation.org>, <x86@kernel.org>
CC: Shaopeng Tan <tan.shaopeng@fujitsu.com>, James Morse
	<james.morse@arm.com>, Jamie Iles <quic_jiles@quicinc.com>, Babu Moger
	<babu.moger@amd.com>, Randy Dunlap <rdunlap@infradead.org>, Drew Fustini
	<dfustini@baylibre.com>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <patches@lists.linux.dev>
References: <20240126223837.21835-1-tony.luck@intel.com>
 <20240130222034.37181-1-tony.luck@intel.com>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20240130222034.37181-1-tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P222CA0011.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::16) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|MW5PR11MB5811:EE_
X-MS-Office365-Filtering-Correlation-Id: 147ec4f4-396d-48a1-3663-08dc235624c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yYK+dOBZl3FeOyZxFb9jTftTNPkOxNFS8S7Z8xJk96SqUFEsBm0AXZKy5QqA5AP6j8NT5XEBP3l0S6QBqb3Vs0xolEDpyEVljV9MOo5jKueRX4A4fRD06umzjwPZFgcE8Zlxt84V0zeJ5Z40i8JdTB4O98WDS4DmEYbmEdVUE9ryuCryDFsDpPLIhMbiZimJgkJH2I3jDUsb6/dKBW8npLWM/xC04sc1J9jVdDP75mL8qtUzlMwfcwzpEBsQLYtzhufM5JPQnfaziSWzWjwtHZUaE5htSqqxkc44I/xNwgCT30kpn964GRZI2dNdz+omIvLIvhGwuaBnDjZgVutgQWbxWynRv38RONqHtL91INHNWY0IC84o+FP61AlRmoDMMNBIVHcCnNJe61yrLw+3lCCuLmdZSYlvVeqTF4O0oWGdAbGq+CXagDceiOK9lXyGsljR7+XN3ckD9XEOQIfQAxa3bhV9wGYR38lcpAEiGlrUO52OXYO3InpMzJ/xkb6uFuoJaSgrsD3VZ8e4JsXYaLAiEDNTljw5pn7g+kCTDe0/yYgtodi+EBUOCLwkxOAiN295d+Ym5AckiyMKFo6O+Ttx1SE1sJgnoBUEDhj1KQZZRWX2CEVRmAew41vnQSn4myK3enqVQdVi4NCZ4s9KNj9EprAnstZiIhP5SNkrHuAziKqjWqlidKm0n9PIX8KC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(136003)(366004)(396003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(41300700001)(6486002)(4326008)(44832011)(8936002)(8676002)(2906002)(86362001)(31696002)(5660300002)(110136005)(66946007)(316002)(54906003)(36756003)(7416002)(66556008)(66476007)(38100700002)(82960400001)(53546011)(6506007)(478600001)(6512007)(966005)(83380400001)(26005)(2616005)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZlM4SGJUakI4b0ZPWGZBVTRQK3ZBdG8wTnMrTEFQR3kvWW9HdzI5ZEdXV0Vk?=
 =?utf-8?B?c05DYmNuWkl6UmFCS3F3Z052RmxLMGNKYWtpN0loZXBMSUZ0Z1BXaXFHcUNT?=
 =?utf-8?B?M205YXp2YlF1NzgxczFFUlgvcVZINy9TSWQ4MFJyQjl3L0UrbVc4MVU3S1VZ?=
 =?utf-8?B?UTVkaXNTRXFldE5VdzRFVk5xam5ScGZST1FCT3B4d2hxdithTHc2cExFWlFT?=
 =?utf-8?B?QTJOQmZBSy9hazBubWRmRWlrUnZvTHZjT01naHd2Yy9IT1RxVHZmWHFFdVRS?=
 =?utf-8?B?cHQzQndlRTJqcW1GOEFqR0p6TVg0MHd2N2IybWN6dzZXSkkzNVZVUkFhVjV2?=
 =?utf-8?B?VUhwemh3eHZBY1ZOQ2p1L1JTVURKZTdhcUlUblBPNG5qOExwQXU3dmgwb21t?=
 =?utf-8?B?WTVDbVBsRDREeDdXMk5NL1V3cXMxTWZ3NXhUQzI1Z09aUk5wYzRZVjBBUGg5?=
 =?utf-8?B?SjQvb1hjLzNVSURaaWk5d0E0RUNIMHhHa0tPdm9kaUo1YjBneklDa3Y3Mkhu?=
 =?utf-8?B?K3VhYVlJSjFWQXIzanFEWUdCbUNLaitsbGcrMmVHQ0V1ekQxWVNWMVhNN3k0?=
 =?utf-8?B?RnE5dkpJU05KV2ZRZisyS3NVSXhvSm8wTXRnb1BCMHVDZy9XV0JoODdZemdL?=
 =?utf-8?B?eEsrRHQzbVlobEZLSVZXZnkxM05QR04vU1VENVZNN3NHN1dta09QWGNkRWpM?=
 =?utf-8?B?dCsvMlJnOHJxaDRCQnhPWno2cmRYSUtkRkZxVE44bm9tQ1Z1blh5SVVoRFkr?=
 =?utf-8?B?dFRaa1dlRGozemN0ZnM2b3M2SnJISTVqMFpTc2xjL1FDNVRSWm1RRGFpQlhs?=
 =?utf-8?B?MFlEYXVTY2ZWQ2pXMkxIeFJYKzBLQzhNSmYwWnhNMjlEM1h5VzdqSi9yYUox?=
 =?utf-8?B?ckpHc1l3NlVLWXYreWxabHlZRDhLMTRqNHQ0YmMxOXZxTVRQN0ExR0hKQ0x2?=
 =?utf-8?B?cU1BbmZJTUlDN0xGSm85ZFdMYnA5SFo0VVNDK2d6aTRWdW9BZmRleW9JMlBy?=
 =?utf-8?B?aHAxeGEvNkQ0cEhWeW11bUZEQWJXMkdENkYzMXNnRVlFQndTaC9TSUE5cjRC?=
 =?utf-8?B?RXc5Mmk2aTlhMG1iVGdneUlOZXBCVGZ4V1J1ZzlKOGdVK2lzcHVLQkFFZDNa?=
 =?utf-8?B?UVF5R3BRcytka2R5UmJlNFN6Ly9XVXpyUzBlQVFjMWxoVml5WEtScGdCVi9L?=
 =?utf-8?B?S09iTGZVT1NFTmlTZ0ZjN1F5bkFCay9QR0hLTWZvV25tQitmZnk0YWZxVVhZ?=
 =?utf-8?B?QTR6VkZnUFo3amZMcWg3MFZ4Q1RxbDQvOWlJWEpYNThCamdXeWR6TDIxN2VD?=
 =?utf-8?B?eXRJTkdJc3NieHd4TlZDam03NnpieStmM0poWjVqc0tyNHdUdGtRV01ackZh?=
 =?utf-8?B?MlJiU2VuVHA3amlPQ1pBdnFxRWtuZXE4OVdLZVd2QU5mdEZlZDBHZkxEd0tO?=
 =?utf-8?B?am1XWHB0QktKY2xseU0vQnRuRDlvdTZzRHQxRHRReFh6UzI1QTRUVlZ3Qk9m?=
 =?utf-8?B?aFRSWTIwR0pldUNscnMzZENzSGJNRDZKZ3hISHRicS9ycGtxc1E4NEhpWHRF?=
 =?utf-8?B?QjVHNXVGT0g3c1BaQXBrQnRBay94RDhjVUExQm9kZk1FUnNTSzNKd1k0WDVv?=
 =?utf-8?B?MHhLSWhXUTZyZ3ZhNHN6ZGtDeVp2S1ZaVUxmTmcwQ2RJajNodWRQQld0MmlY?=
 =?utf-8?B?NnhJc0xHRHI5blhpb1d6dVJhak5CMFNRKzRlVXE0MHZsM1FVMkcwa0xOV0RW?=
 =?utf-8?B?VlRZUUlHeHJXdGdXT2ZsSUFyUUVnM1lIWG5IR1AzZUlvRU45cTdWR21iaE9O?=
 =?utf-8?B?bTZSL1dLcUozZ1pmUldwZjRGdDZ6V2E0bno1QTFkME1UQkN2aGF2dE1YT2FP?=
 =?utf-8?B?MGszOWdhZXJHRHlXK3NYeFUzSTZqZGxqbUZld0dNSGlvK3ZUN0YzUnhraHNk?=
 =?utf-8?B?RXBzdHQxRWdDVDhobzBhb2J0L29laFZQblhRQlQxc2R1RWxkNFVEQjhvbkJP?=
 =?utf-8?B?Q09mR0JLY29BNTEvQU5lWDFyMkVBbU1CbWVTRTcyTTJma2prZWpGZVRxODdJ?=
 =?utf-8?B?WkNsMUJ1VytIeGFTRXEyRzJSMGFEZ2ZNTlpGVHI3RzZlL0xlaHJJYmxVRnhj?=
 =?utf-8?B?aEh1UGhNTktNQnNmcHZvcENabFFUWlpEYU9MK0x1aHBsemVZakFiM1gxa1V0?=
 =?utf-8?B?S3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 147ec4f4-396d-48a1-3663-08dc235624c7
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2024 18:46:47.2525
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RKTOlvPRasK39rwq6Kg09RezcKZOVBBhn6zAumwS2ogfBeR8mlLhEmyX9KYaa1x/x0BHbkDcriDEiVT1GJhc5EhtM4wIM9RrDUDD7qOCeBM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5811
X-OriginatorOrg: intel.com

Hi Tony,

On 1/30/2024 2:20 PM, Tony Luck wrote:
> This is the re-worked version of this series that I promised to post
> yesterday. Check that e-mail for the arguments for this alternate
> approach.
> 
> https://lore.kernel.org/all/ZbhLRDvZrxBZDv2j@agluck-desk3/
> 
> Apologies to Drew Fustini who I'd somehow dropped from later versions
> of this series. Drew: you had made a comment at one point that having
> different scopes within a single resource may be useful on RISC-V.
> Version 14 included that, but it's gone here. Maybe multiple resctrl
> "struct resource" for a single h/w entity like L3 as I'm doing in this
> version could work for you too?
> 
> Patches 1-5 are almost completely rewritten based around the new
> idea to give CMT and MBM their own "resource" instead of sharing
> one with L3 CAT. This removes the need for separate domain lists,
> and thus most of the churn of the previous version of this series.

I do not see it as removing the need for separate domain lists but
instead keeping the idea of separate domain lists but in this case
duplicating the resource in order to host the second domain
list. This solution also keeps the same structures for control and
monitoring that previous version cleaned up [1].
To me this thus seems like a similar solution as v14 but with
additional duplication due to an extra resource and without the cleanup.

Reinette

[1] https://lore.kernel.org/lkml/20240126223837.21835-5-tony.luck@intel.com/


