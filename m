Return-Path: <linux-kernel+bounces-132238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CB7C8991E7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 01:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 286951F22E97
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 23:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9141113C3E3;
	Thu,  4 Apr 2024 23:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mWgi46Qc"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B389613B798
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 23:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712272232; cv=fail; b=oE/Oj6XrJKCQxYyN/ipF78Y5T0zdWoPLiD6++B18z/uYuYbH3Co6PF7Ni8rOafVt/dc8WrlQKbHRhFD/aOaJr5+xqnCA7yMUnkRTtGjBzfCIY/5fr4cChk6Ec1nrheU8DQh7L1SoFvhnCO5lNTcluv5gkq6RvEXS4sraRyJDR84=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712272232; c=relaxed/simple;
	bh=PWASOWwOhn3vEuhtyY/mDQEI0OG4jvaWEKjA2+M+bRM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BDPom1XEeflIpIEHT/+xVqE5TQNOUi+ws2UMDarQU+GPwVpVLx2ZYdJx23dd6+Fpfh4iO6iJVlv2aRbCRQA8hdUHRXE6O7GefnjU8tmChTJRqZtWDsOmB6faSyeDw8efZTDwmpU5YkV5yCVDOb7yiJXsSINin/2O8N+zc0FXT2k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mWgi46Qc; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712272231; x=1743808231;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PWASOWwOhn3vEuhtyY/mDQEI0OG4jvaWEKjA2+M+bRM=;
  b=mWgi46QckJ5isz4UxLUMHT9nnHRBiWFGZd0G2AJi7G87rXXM6PxZUUxu
   RVlV7KiXipJIAxU5OWTXTqcJ5kud3Od6qhGvIBdJyKXaRYsSWXyL57WuF
   hoekEsE/BG85BAuARJFr4b/Gy1h4jyqW6Qp4wBuM2653XspAt4rQkjrdG
   2T8vySMW1dba443wwIwVVaV2A1FoueyJam0uicQAQNbOhHu4uw8roZLQB
   SwefU74EBz6VdSrrHCncB9ilonm0KhIwkytRNPSXWp/SanILm0L3vbJ6b
   GM8X1nJ9spEZOmRHdaoHIr+vxOybvWWu+wG9xrAqZ3mYxiMRLP85gNSK+
   w==;
X-CSE-ConnectionGUID: gDi/y5swSGmJM75PWFG3OA==
X-CSE-MsgGUID: RRahiwliRy6rOa+dLvYawg==
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="7748626"
X-IronPort-AV: E=Sophos;i="6.07,180,1708416000"; 
   d="scan'208";a="7748626"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 16:10:30 -0700
X-CSE-ConnectionGUID: RpKkFistSA+fEt7TsjDuBA==
X-CSE-MsgGUID: xbtWNmK0RaKT9mpwrjs1yw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,180,1708416000"; 
   d="scan'208";a="18893813"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Apr 2024 16:10:29 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 4 Apr 2024 16:10:28 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 4 Apr 2024 16:10:28 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 4 Apr 2024 16:10:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bl7NGqUtzk16buRLEFyeE0BCynkoa8y2Mz7HTxlmlf8JdjUQbeI5Z5J03oRDlSQ10WsLdjd8uUZDB/EHt2SOQwHKYnX68Qny9rf77jPq9zdMTaNDdMbSMOn4EcygN++v55Y66Z2+ZfPMzgTtXEok0Y9TWYz1mq+paW8igM+E4Bv+Mcein20N3BUj/UvJMAZGUa434vOUkjly9+69vd5cZtGxNzOGc+PYwzAoxy1PyeZ5NyTbMWUFAqoL0nZpotGMT/kqtRVt8TNN21kAn7R0iJjc9IACbXZX2WzKR03oIUWn89vgT9fyaGx4E/XuIvl4ZPt3Vqm7tAs3WCYhryognQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P8YJYy+8Pl+GAhna0oYaDJ1QM99d8wI/em+vpifLdKQ=;
 b=mQRv0WRTEniu1S8GwaGkO6hXgRHpoJWn1riXb4AOwMo6LiSiniOGl1diTbBnR3opaz+bFLWsn7D25PsqW4Bw+N6imnmfk8mpUcujfr5gjaFugJiJ7q5sisxCbQfOxTlAwmhb3nQYnFp3Gq05zWNv64felFpjXvyIjUuNFKOqFljzn8IiXiyYqERxSZHYjYARBzE7IDoCYhkJVv14wErs+c5Wl9pfNN23hzM1zzemWlTreOBWoFVhYBuB7WqroTykCC+rPfZx8jqthLMAqdwfY2uPh2oiKQj2g/sp1vOTkOuptE7kWm5ihjfaazaUdQZ9LRjUFA+q8YFe5Y5W/wEhNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SJ0PR11MB4847.namprd11.prod.outlook.com (2603:10b6:a03:2d9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Thu, 4 Apr
 2024 23:10:26 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68%7]) with mapi id 15.20.7452.019; Thu, 4 Apr 2024
 23:10:25 +0000
Message-ID: <50298f2b-45dc-4b22-9383-b82791ee319d@intel.com>
Date: Thu, 4 Apr 2024 16:10:22 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/6] x86/resctrl: Add hook for releasing task_struct
 references
To: Peter Newman <peternewman@google.com>, Fenghua Yu <fenghua.yu@intel.com>,
	James Morse <james.morse@arm.com>
CC: Stephane Eranian <eranian@google.com>, Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>,
	"Juri Lelli" <juri.lelli@redhat.com>, Vincent Guittot
	<vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel
 Gorman <mgorman@suse.de>, Daniel Bristot de Oliveira <bristot@redhat.com>,
	"Valentin Schneider" <vschneid@redhat.com>, Uros Bizjak <ubizjak@gmail.com>,
	"Mike Rapoport" <rppt@kernel.org>, "Kirill A. Shutemov"
	<kirill.shutemov@linux.intel.com>, Rick Edgecombe
	<rick.p.edgecombe@intel.com>, Xin Li <xin3.li@intel.com>, Babu Moger
	<babu.moger@amd.com>, Shaopeng Tan <tan.shaopeng@fujitsu.com>, "Maciej
 Wieczor-Retman" <maciej.wieczor-retman@intel.com>, Jens Axboe
	<axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>, Oleg Nesterov
	<oleg@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Tycho Andersen
	<tandersen@netflix.com>, Nicholas Piggin <npiggin@gmail.com>, Beau Belgrave
	<beaub@linux.microsoft.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	<linux-kernel@vger.kernel.org>
References: <20240325172707.73966-1-peternewman@google.com>
 <20240325172707.73966-3-peternewman@google.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20240325172707.73966-3-peternewman@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0069.namprd04.prod.outlook.com
 (2603:10b6:303:6b::14) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SJ0PR11MB4847:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QyoYJnSiUwWz1jbMBLlgP+rbxvGuc/f/Dtj4wu4pE0eQgE2SqHCkO4OfhgnMsjJlLf/1V55PRRNfi5LHulzR1Cw8VcJnHeuPDhh3JEXrh5jr5zxwbp2yp+1YFxMw3wDDl4S0RQP5e/FkodvF9KTFpnhngGtsVuiDYr2LUqJ1s2b5mjLW6Sqvc0hFmnXDzHVrhvk8oUsB8Nn44x3c6IMAY5sBEQHDeOarKrrbMGFxFPW3NW8FntOvk+FNn1F0Ok1bMg5Z5m7vLA7NnKuT9LHThuy5gA45zUV2Amuxgx64tDf4jp/qY4w2Tu2a8K8St77vOPcXGxa7iGCVlDZtn68hR8EWWE8o2zAXKqS550Es4uPKHJT1awY5ticxh4MCuKRD1T6XG2hj8AmGT9xwHdKolvDE2P1wFOFh2DU3Pk9eaiLxv9ZzsZJUTylXG+XZqtGADZnNm5fELnMXalq+FzsVOZs8kkeveX/DfaGwUXOpekM52AqzjR5kcFyQIGBF6LH8/ribCPWHySoI9PV9E0KNmyuqnDMpEP6NwcoSAeutNY2IZneSRYVea3p0tt57J6PDh6ygbU6FOy/QZUyuwqkKrCMMJuUf2NG4S5aUDOlqTwsGYY5vDK6Pj9zZXa+QOfDykSwODvbeHgRE9C8Zgs6xOS2fkCCQF9vub1RYIBGkApw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NGxFQVFKdXovN1BxZktpblhvWEJxajRnU3R6d1krWit0NlIzYlJhV0xlbml0?=
 =?utf-8?B?Nm9XT2M4ZVBSNHNGRjN6Kzg5SER0WVh1bzRlNStwa09tVW9mUFh4SW9LbGtx?=
 =?utf-8?B?ZGQzM3VVTnpxblRHMXY5dnU4cHRvTXhOT2hzazFhMkdMQUYzWmkrdEJySHNR?=
 =?utf-8?B?cnNFN3NoTWNPeFZRV0tnZ1VYY29wY05FL1Mva0VxL1dGbUNGNjFKUmd2MzlH?=
 =?utf-8?B?d3BRcERobTNESVcwMUJObmhvZFNvbVVWdFZFb3ZMZmYzdUYrZkI2cndtVGRE?=
 =?utf-8?B?T1pSNmJHQ3pwZmhyalY5bXVIaGlWUjNvdmIrNW0rMFdXeWQ0eHhsWE9JUTZs?=
 =?utf-8?B?MnlTUzFXOUFQcEY3NnJxMHhCUjY0Z2JTQUl5OVZnNWIyaHBOcHQ0bFFSczZN?=
 =?utf-8?B?Nk9CV2lQOHVpQndtNUZCd09XVmJWT2w2WU5VMnhxbXZNb2JNb29RbGg4RDVp?=
 =?utf-8?B?UTc1dTMxNTRBWXBmRFdkWkduM2FSTVN5My9mN2IvdjlOSmY2VkpqUXRhRTMx?=
 =?utf-8?B?cFRaamRnQ1JvS0hKeWkxcTk1RmpaK3ErSjlub1Q0YjVRb0RtM1RsWHhPNG1i?=
 =?utf-8?B?anNsWGpWSCtvRFBuckkzN09taUlwakRzSWVaa0hJSHIxWXZVQ3UxcGY0RHFE?=
 =?utf-8?B?NkdHZ0RucnlNOUVPRjBpaDVzOXJTNzAwWnc3RkR4Zk9HMjRabytnK3puM0Vh?=
 =?utf-8?B?czVFR042dURzaUpyenRWTXB3ODVBNVNpdm1hMnRTbzk2SnVwODJKNndPd3Y4?=
 =?utf-8?B?d0pSeXM4UHdCTXVKZ2FEbzk4QmcwQ3QrYUhwNklKMTZSdVNuOVZsRnZYMzVP?=
 =?utf-8?B?WHFSRHB6YURoVVF3QlB4ZU5XclIrN2xXQm5ZRFFjV3VjbWhCYjZkUE1PMUZY?=
 =?utf-8?B?dGY2ZjRIQkJiSzFod2p5TEUzT0hWQTBxU3B6OGxENDdQR0F1QlVMMDZibG5s?=
 =?utf-8?B?TWNReWpEUGxTTmUzSXNnMFZGMWhTMWxIZnFJRWFTTFdVYjV6Rk4wYVdMbGdp?=
 =?utf-8?B?NlMrL2k1U1Nadjc5UVFtejQvS245Y1dHd2FxM3ZuUWFYTzMvQmpRdi95eUQr?=
 =?utf-8?B?bHpXRWJWVVAyTXZIM0VZVU1qdGZWcWRWYXZ5K256U090dWVmZGt4REo1clJH?=
 =?utf-8?B?QnZFZHZYL2U0bEJpNzdoM1FSV1BSdG11VVRxMm9RUHVnTDRGd0FFZGdQRFFD?=
 =?utf-8?B?dkMyWHlJeVNQWEpZMFd1SE0wcmJydXVoLzhWTjYxUXQyUlc0Y0NkTUhhZktB?=
 =?utf-8?B?OHh4MHROdVBWUFJ3Y3YyQnVkbjlRdGhqR05rQWo3ZWIvNHFydUwyNFNyREYx?=
 =?utf-8?B?QVZ5MW9FZnVKWXBzNHdyZHFOVDdFaU5heXVreXJ5YytmQW1qZ1Baem9WSk04?=
 =?utf-8?B?T2ZHQ240cmpTZFlndHpOeWlSc1F0VmJZTEhNOUpOekU3U1pCa2ZZOW5wSVBQ?=
 =?utf-8?B?eUpWT1Z3Skk3MTFKeTJpQlB2VVhEQkRSR0xoRk9tcFp1MWhpdXJvQzc1cHBr?=
 =?utf-8?B?UldhMENNZ05HdUJ0SG1YYzNYSk1wK0lEb2M4Z3BtU2J3NWNoVzRiaWpKUEky?=
 =?utf-8?B?N0tjMGFzaHZGamhNY1NYbWlYVWJaaW9TWllpcStBYlV4SmNaNm5INEIrZHBs?=
 =?utf-8?B?UGZYKy91aFBZQVcxai81ZVM0QTJyMksxekpZSmJOTUU1RmhsbzQ0UnpZSU44?=
 =?utf-8?B?WnhaV2x2N0FYaFE5RHZhc0Nsa1lmWlZRS3EwT0lpd29BYW9reldEaGhSTk5Y?=
 =?utf-8?B?eklnTFRlNnlzWWRXbnhmbXFCek1ZenhpdjJzY1Qyek5EUjVEaDEzVGxMeHdm?=
 =?utf-8?B?VGNrZnFwR093ZFpyQU1GeE80eGJXNGhVTERoR28yd0dVbGFyT1llQTBmR05p?=
 =?utf-8?B?cHZwVUlXd0poYkFWVUhQcUVzeEZuYmdmSHBDazR0d0FhVUpycndXdEY1UC82?=
 =?utf-8?B?VDNVZFRGTzErOXBndVJkYnk1QjVDKzFmSlJCS0RDL1UyL0p1Z1FjQXFlU0dI?=
 =?utf-8?B?T1lid0V2ZE1yK2E5QmZhMkFWREM1UWRjbjRxL1NJcHFnak15NHFIV3BGOHJM?=
 =?utf-8?B?dTFOSzU3ckpKb0VnQWMvdWRXVnhucnRjQXJRM0dtbU1yYmFkZ3lURWtMNHlB?=
 =?utf-8?B?ekdsc0ZJZzh3dXk3aWVpdngxcDdCblJDNGZNbG1zcjNuTmxtclRIYnM4V29T?=
 =?utf-8?B?N0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f72d1c3-a76d-4c75-aaac-08dc54fc6955
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2024 23:10:25.7183
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: izs0i6C2zSYuDSpQ1b5j65SpOgAcgsVsUKO833wOIvzpVAFtiCvpjkRev73KKYti6WTxSvLe10QGnM7HSk0lXw1Gq6tDX5ClkYjdUtt0hYQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4847
X-OriginatorOrg: intel.com

Hi Peter,

On 3/25/2024 10:27 AM, Peter Newman wrote:
> In order for the task_struct to hold references to rdtgroups, it must be
> possible to release these references before a concurrent deletion causes
> them to be freed.

This is very hard to parse (for me). I found your description in the
cover letter to be much easier to understand.
Considering the core area of code changed with this patch the
changelog needs to be specific on what is needed and why.

I'd also like to recommend that the subject prefix is changed to "exit: ..."
to highlight to folks that this crosses into a different area of the kernel.

It is not obvious to me how changes are routed to this exit code but we
can start by highlighting this to not appear to want to sneak it in.

> 
> It is not possible for resctrl code to do this with
> for_each_process_thread() because the task can still switch in after it
> has been removed from the tasklist, at which point the task_struct could
> be referring to freed memory.
> 
> Signed-off-by: Peter Newman <peternewman@google.com>
> ---
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 10 ++++++++++
>  include/linux/resctrl.h                |  6 ++++++
>  kernel/exit.c                          |  3 +++
>  3 files changed, 19 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 5d599d99f94b..9b1969e4235a 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -2931,6 +2931,16 @@ static void rdt_move_group_tasks(struct rdtgroup *from, struct rdtgroup *to,
>  	read_unlock(&tasklist_lock);
>  }
>  
> +/**
> + * exit_resctrl() - called at thread destruction to release resources
> + *
> + * This hook is called just before the task is removed from the global tasklist
> + * and still reachable via for_each_process_thread().
> + */
> +void exit_resctrl(struct task_struct *tsk)
> +{
> +}
> +
>  static void free_all_child_rdtgrp(struct rdtgroup *rdtgrp)
>  {
>  	struct rdtgroup *sentry, *stmp;
> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
> index 62d607939a73..b2af1fbc7aa1 100644
> --- a/include/linux/resctrl.h
> +++ b/include/linux/resctrl.h
> @@ -325,4 +325,10 @@ static inline void resctrl_sched_in(struct task_struct *tsk)
>  #endif
>  }
>  
> +#ifdef CONFIG_X86_CPU_RESCTRL
> +void exit_resctrl(struct task_struct *tsk);
> +#else
> +static inline void exit_resctrl(struct task_struct *tsk) {}
> +#endif

Scattering these ifdefs in the header file is not ideal. I think when there
are just the two sections as I mentioned in previous patch this will look better.

> +
>  #endif /* _RESCTRL_H */
> diff --git a/kernel/exit.c b/kernel/exit.c
> index 41a12630cbbc..ccdc90ff6d71 100644
> --- a/kernel/exit.c
> +++ b/kernel/exit.c
> @@ -70,6 +70,7 @@
>  #include <linux/sysfs.h>
>  #include <linux/user_events.h>
>  #include <linux/uaccess.h>
> +#include <linux/resctrl.h>
>  
>  #include <uapi/linux/wait.h>
>  
> @@ -862,6 +863,8 @@ void __noreturn do_exit(long code)
>  	tsk->exit_code = code;
>  	taskstats_exit(tsk, group_dead);
>  
> +	exit_resctrl(tsk);
> +

This seems fair but I am not familiar with the customs in this area of the kernel.
I see both exit_xxx() and xxx_task_exit() being used.

Reinette

