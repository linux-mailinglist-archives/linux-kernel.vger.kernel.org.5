Return-Path: <linux-kernel+bounces-136218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D0BE89D157
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 05:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 331EC280A64
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 03:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 280ED55E55;
	Tue,  9 Apr 2024 03:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lpfacUB8"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F03854FA0
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 03:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712634843; cv=fail; b=TkyvI1DlQ/DWxFkvm4tmvj37j1OeIASY7jLq47hD2K4CnCAZ4e8i/KKgaZvMjibkYNu7GxLz7Poj61Yw2j26Hwu55K7RMJbv1SFx82yfjaU6rNR0qJEiW70UnMp4veppyYHwNyZ5k9TZLl8oIkHA1FLOKROW3vWSKKyOz2nuAOc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712634843; c=relaxed/simple;
	bh=uhXXAvptzz7xE5rUhF0al2a7r8WqLqEvK0Z0ULSP480=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=p+w4oUx+srT9U4gC4s93dJ+84e4BBOZPQtKDgA4CrF/Y9VwYMxmLLTwFBudaL2ARKEA2HwAbEBAR2upI9hWDAQw5ZcbQlQnzu5oXkn5YmmNItEkwpaecxki9CSN7ZJdcoRKUwKG/BeG43Ymx6QG5ikpqWRpPWRSn4nUfcguzRk0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lpfacUB8; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712634842; x=1744170842;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uhXXAvptzz7xE5rUhF0al2a7r8WqLqEvK0Z0ULSP480=;
  b=lpfacUB8GGRMhE4DNg7MM1T7VtZoxVcbhNbC8bRsvbj8/HYMtfBy8yyz
   0E597UwdiS0lmhF9/OYb2I/mFWMWmCmUFphQihF7+XnPfeyzWDDcgrK5h
   8vAdiv40YsQflrb4VkUYVjn86DC8DQcfzgXu/6Dcqp9hiZ9kquIRE+IXh
   Ca41+1H1UIDE0zyGsIsXLS+tKkv0DTqxI3nqMBGLnXdEjUXrhidyeReMa
   ekBbJweqmbpxvm61iEw9Si8uV4OOwpnDVAxoA+qofbKy6NqT8OW+GjRnL
   QXN4S0uN/Fyi7F6PPP5w4sIy0P4Pe5xao39sAIkyFoEwh7YkvaRfUhU/a
   Q==;
X-CSE-ConnectionGUID: IPnhzuciS8W5e0Cyfi4vKg==
X-CSE-MsgGUID: 8E4wfVHJTvCnOhd1/zQ8oQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="8062151"
X-IronPort-AV: E=Sophos;i="6.07,188,1708416000"; 
   d="scan'208";a="8062151"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 20:54:01 -0700
X-CSE-ConnectionGUID: HoY3v2T7Q46tmznnqD/MGA==
X-CSE-MsgGUID: TYt5CVXCTXWegsdWaHIKzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,188,1708416000"; 
   d="scan'208";a="20661804"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Apr 2024 20:54:01 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Apr 2024 20:53:59 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Apr 2024 20:53:59 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 8 Apr 2024 20:53:59 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 8 Apr 2024 20:53:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g4WlQvp5axXwtqR5Q+culxjRokC2RQf/NQe8lzQ6/U9K8UPh8j0Hs6hvWt5sc8JD6eA569FNrjIAAgcI12tTb65pCDplz5uQ+HEJ6OKZ6LbCXrtJ4t1+2wg1RPOpN5yjtM3/GGwweNRb1nl3JD7/YXuBpfpSw0+NToziSA0oTmRsFQ7P/8rmJHh+B8Y6AHCFmfrXDBF6+cor2dmYNMQNiDavXa4oh8sFYVpGVbj1QCEF/Z8jwN34I8bxq4U5cIaqkqm6JbqNAScHUE/++q0FgZ+crrdz2VPP1noiKZHgzb6wEotIU2lAQGsJ/cW0VZ2SMAIx2ppTR24d3Q2FUZ7iuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C5flRdW8KpOZCDDXrfrKekcOxo4HFYZAcwKPEmIfU0Q=;
 b=gaSLCljIVPEoKH0SEBpPLdWZLr4bTR99FIBOAKU3Fj9EswodJgcgQRwn+ZB38zwCVR33w7A2iuxSSpTzk3Xdo2u8Pmc6yiO4+8nDPD7l1O0vJxD3bRSBCs7CydQ/Hh/H91qbAJjCvHBg85vZUtRFGJ4J3KHGqB5FmeP55J/vkO49NbkRZBVFp6w5o66j/a1WsaxRAQc1JFMPfetcCX5tDtqKrLnkgKFwWK6gL0cIyNTtS8mdX0ojH37WQ+eWOQYSrbPaiATtfbvuZy/8VDuf2GQWKGt3HZQdoskAHcNa7LgiT2akIqD+/dCIGtE8DFanzyopublXYsEGOzZK5WESBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH7PR11MB6451.namprd11.prod.outlook.com (2603:10b6:510:1f4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26; Tue, 9 Apr
 2024 03:53:56 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68%7]) with mapi id 15.20.7452.019; Tue, 9 Apr 2024
 03:53:56 +0000
Message-ID: <d40b3d06-b0b9-40c2-a7bb-19e19d5a3803@intel.com>
Date: Mon, 8 Apr 2024 20:53:53 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/6] x86/resctrl: Move __resctrl_sched_in() out-of-line
To: Peter Newman <peternewman@google.com>
CC: Fenghua Yu <fenghua.yu@intel.com>, James Morse <james.morse@arm.com>,
	Stephane Eranian <eranian@google.com>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, "H. Peter Anvin"
	<hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, Juri Lelli
	<juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
	<rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, Daniel Bristot de Oliveira <bristot@redhat.com>, "Valentin
 Schneider" <vschneid@redhat.com>, Uros Bizjak <ubizjak@gmail.com>, "Mike
 Rapoport" <rppt@kernel.org>, "Kirill A. Shutemov"
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
 <20240325172707.73966-2-peternewman@google.com>
 <e2c479b6-43f0-4e2c-9ccd-2e5f322d1974@intel.com>
 <CALPaoCjWDKM9VYXexDt2+zh2srTotuaErFHXkWzH1w0c_KWDjw@mail.gmail.com>
 <d3ef1a5a-a7ee-477c-8697-d64b91726d91@intel.com>
 <CALPaoCieXQfgEL-7CK2pB5xgrRzTTWBkbic7OXxdKbh-ipWTpw@mail.gmail.com>
 <17264fcc-5db9-41c8-b57c-9bd62ef544ce@intel.com>
 <CALPaoCiX-EZu-SNt-1A9QNJyc27jqmr9LNJ2r4Eq_fChGhgscQ@mail.gmail.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <CALPaoCiX-EZu-SNt-1A9QNJyc27jqmr9LNJ2r4Eq_fChGhgscQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0148.namprd03.prod.outlook.com
 (2603:10b6:303:8c::33) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH7PR11MB6451:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k1Emrgw4zFtI05xemouZWPbjGXLBU7dHrW4J4oxKF0n2PyP2RlQRJnOt6beQDWuT5NIxLu2o8iTLVcWoWXPPwjOJVcsR2p4ogKc4fOtQvCvXGJHWksKvwXTCTXL4LmcBjiscA7Ku8aWRTQ2jK2uGTptYQKUqS1+yXdeWkdoKy5/YwfjQT+vj6kVG2hk4L1qH8TE+JNpExrrFWLXqKvnBnVk1tJcp9QgrgTF6PcEfFKG3Z9M89ZbcFtTMg9HRnUaMmbHmlkVBx2kXCHh2sf6nn0k65j7iBA0v/32CdEbV8pCuqbd7i8D9Qcw78TcL94UEZ2edW/DIyGOxtG0u/YvHbGorQqMErLK4y0ElA3CQz8TRX92an94dfam7ZTX8LnucXTMjVs5AkynURFc0stYn97N27qqkqh8N7uunB6G9yProuhS+bT0kzTBNuzgtgE8VZQAr+3gMUrPOAQk6pswiw9PeKgksolBvm7U2rSExAPbOIpyREYbbzCIh7a/zUWdMn0lR7VEvFgRz884U55ZjASyGhfd3R6ifqbBaYi6IY5/o9NENOdbNCKK+zY7RnvNY1MY08L2dQDgMlc0rz9io66Cj8uDNQPsT8zmDyfw66kyMdWlMX5pQJYLa/7yoPtQXs8hKGR30c2ymC/7NACOPeVxcU2YCEgUXckx8JovjEx4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(366007)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SC9oSk5oaHBYeGNJZmMyc3R1MVpYUXI0cXBpdk0zcE1BN29RTDJhQWZHVjBt?=
 =?utf-8?B?MW5iQS9Yd2p0UHBCM0RQazBFQnZuTmRvMC9qV1ZqSjBla2hvSUYwWHlxZzlF?=
 =?utf-8?B?U05IU1hFZGdmZ1o2RHYxQ2pMamk3cSs1dnc4a0ZScjNrY2lxM2Z4QXBuRFFy?=
 =?utf-8?B?blgzY2lUeGdIcllQSExBTVdUSG8zZ0pGcVZHUHM5eHFLaXBSem5mc205Y2hv?=
 =?utf-8?B?SnNwOW5UR3UvNzZjam1HVExTeVFaNUFWMGRVVGJxVWlEdFBUb0RhVmppRnFk?=
 =?utf-8?B?NFdtRjJZYmh6NUY3TmIxc25WL3dCM29oWUpxODhJbEZEQVRKYUcvR0ttdGRN?=
 =?utf-8?B?SHJVeitwdkJZM1lZZUxucTdrVWQvbDNHQmwwRzhKMmUxbklNeDZ5Rk9YMExq?=
 =?utf-8?B?Rm4wMFE2K0FCMkM3bVpxWTkxVjFSMGZyaEhvRm1lU0ZvS2lUT1FDM1FEVDAv?=
 =?utf-8?B?RVJvTktQN0F4SENaN0p6YXF0QjRiOFE1b0RucVZoVkJLTlRaTUYzY2xZSTRq?=
 =?utf-8?B?UHRSQXM3ay9LQ2VVNEplRFBDOG1jeXhEdzA1L0NkdjFkSXZiQzROdTBjdFNn?=
 =?utf-8?B?Z20zcDU2dXV4SFBROXVyZSt5OXZCZUVnYk9kbHdmbmpHOFplQWl0YkdQcndz?=
 =?utf-8?B?K3dlWDc3TE4yWUkrQjU3RUhtOHE1ckJPRkRwYndjdndML1NKdmF5ZkNpWVNW?=
 =?utf-8?B?cFpFbUlIQ1ByN2gxK2szY01HSUdhQSsrWW5UYWd0TUlXVGlyWDlMVCtjVVM0?=
 =?utf-8?B?T3ppSzE2eURyZ3VZZW9rR0Y0YWRoZWVXYWV0b29WS0oyclU3aUNVbmdrWktN?=
 =?utf-8?B?Yklxd0t6R1RnUlpvZ2t5eklVRXAxTEQ5T3Q5RWtQc0M1QUJPNzN4NlNJVWR5?=
 =?utf-8?B?ZHQ1WXpONDlJa084cHlBU1hyN3ZXbytHSWtGa0g1azNUS09xWGU3aEYrR3V0?=
 =?utf-8?B?cGFVRGhOekk1Q05MaW5mV1NhWDFtOFV2N0pwRWNIQWF0Q2xEYmF4M1RRMzdp?=
 =?utf-8?B?TDBrM2NGTG5vOTZGWUFZeERXbm9SK2RGOXp6bzFLQmV0OEhCQTZDdjYyYzVk?=
 =?utf-8?B?UXN6WlVmTG1lemVJRzBhYTNJbVhMeUNKakFiZU1qRDRFNzFMZUJ2NVJ1akFl?=
 =?utf-8?B?UkFOd002NDJZTHdtazViNFdLem00QmowcW9iN0d4WEVUQ3REd2ZMRjQvb01z?=
 =?utf-8?B?L05LZmJ2Q2tBaDlyWkFodzFZVVk5YVlSTW45RFZZQUZRRzdLc1RRV1hQU2Fi?=
 =?utf-8?B?TEF5YjFsQXozVWFObHFsbG03dDIzQktyb1QxQzZZb0pOVXBWdGltdC9OVzJa?=
 =?utf-8?B?akNuY1FiUHZkeVNyL0hGM3RpbCtYZzU3azZlam10V25YTnVtWXhCT2VRTjh1?=
 =?utf-8?B?eGFQZ1dza0EzNkdGVitsRk5Sb0ZjTXFkT0NveEw4UTVIVWVYM2UzaHYvdm9E?=
 =?utf-8?B?S1QzcURkbXZYSmFJdEJYVG5qMzZVVHJqaXl1aUFHbGhXR3NOdWJGdzRlMGdQ?=
 =?utf-8?B?SXhrNmpNMEVuZXNWSHhJU251SDUxc2hwZVFrUEl0Q2V4ZlIwSmZRZHRNcmhK?=
 =?utf-8?B?RU5keUxTS0w4UVJha3hwdGY4aG9lZU42QlhVcmM0aGhtbmJHUGQ2ODZXTjBX?=
 =?utf-8?B?TW9DZ3lRbXJWbUdpUllrVkpWb1haemlqaWhnSTBlakpYdHErcTNsb3V1K3o2?=
 =?utf-8?B?UkJBYzU5REhlK1VyTHVUSkd6UklLUnorci9tL01rQkg2a1BKNkhVaERTU1Fo?=
 =?utf-8?B?TnpORFlzTVg0NGpPb1FOUzRpamJhRURBbFBkUHlMaEFjcjFtQWZwTDhvVW03?=
 =?utf-8?B?RzRsUVdXd0dBbGwzenZMbG1La3JMUEJKWm1XOVpPMWFBek82b3A3eXpFWDRy?=
 =?utf-8?B?ekFMaEorRDRKbkVIcjZVQnFOWU5QcWE5cTB1RFJwL3ViN08rNE9BRFdhT0Yr?=
 =?utf-8?B?UFprNXFna3MwS2NnTGZoM3IwRjBrWk1EYTVOa2FZQjFWUjhtOTJsSUZOUGIx?=
 =?utf-8?B?Y0xCMlBGVExNbWxBaG8xUVpKZUU1ZERmQUtUMlhEVGdCZWpBa2ZvQngwRzhj?=
 =?utf-8?B?QVoyYXlsS0JkQ0M4MnJnTkdpbzVtK3I5bmdSdjRFTzlzWXl6ZE9Oa3l4bnRl?=
 =?utf-8?B?cFVlOXU1V0NlSEZUdnJLZFRKdmVsZzVJMVNwTmE2bit6dk9DTVRDQ2VNSlcv?=
 =?utf-8?B?dVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bae41497-d2c8-419b-99c3-08dc5848ae18
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 03:53:56.2682
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QL+sc3fKtVAF8Cbo91e1oSxsGE5WC6TlYIWVjcTRLDQNKA2LW0nNdOaJSR4qEUVCtt0sfIBnuDojh00U3PUKbt5pP+uYAGXPbSgiMnIx8bM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6451
X-OriginatorOrg: intel.com

Hi Peter,

On 4/8/2024 2:41 PM, Peter Newman wrote:
> On Mon, Apr 8, 2024 at 1:59 PM Reinette Chatre
> <reinette.chatre@intel.com> wrote:
>> On 4/8/2024 12:05 PM, Peter Newman wrote:
>>> On Sun, Apr 7, 2024 at 12:21 PM Reinette Chatre
>>> <reinette.chatre@intel.com> wrote:

>>> wrappers for the mon and alloc enable keys[1], so I can only assume
>>> they are architecture-independent in concept.
>>
>> The wrappers are intended to be architecture-independent, but the keys
>> are architecture dependent. Quoting the commit you linked to:
>> "This means other architectures don't have to mirror the static keys"
> 
> The static keys seem to exist mainly for the benefit of
> __resctrl_sched_in(), so if it becomes architecture-agnostic, I think
> it would make sense for the static keys to move into the FS code with
> it. I don't see any other usage of these keys in the code that
> remained under arch/x86 on James' latest series.

Good point. James untangled the static keys from multiple usages with
only context switching remaining.
If its only use remains to avoid runtime checks in __resctrl_sched_in()
then it sounds reasonable that the static keys follow
__resctrl_sched_in() to FS code.

Reinette


