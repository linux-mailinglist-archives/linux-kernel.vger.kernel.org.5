Return-Path: <linux-kernel+bounces-27814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A54082F646
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:56:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE28D281BC7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 19:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFB5A1F952;
	Tue, 16 Jan 2024 19:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rh1CccZG"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2756D1D6A6;
	Tue, 16 Jan 2024 19:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434262; cv=fail; b=MI/g+59VyqIMMyziLCSqN89wgZFcxpzeSb14jBmBNMCyLYghYYye42buYFQeRwAfr3ryJggI5fvA+6dvvaWbsBd2rJ/ga1k4bSzBEDcKPzbaU2xTTzqf8aJ6WWqh9mBXECzME0KCXpT5y8cI2PGIJrM+4sbXxOrdc3Me4edmp/g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434262; c=relaxed/simple;
	bh=BeCkwqnHB1UsLBFGhLVgEHX8nQ3Klalvu1QHcBqI4sY=;
	h=DKIM-Signature:X-IronPort-AV:X-IronPort-AV:Received:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Received:Received:Received:
	 ARC-Message-Signature:ARC-Authentication-Results:Received:Received:
	 Message-ID:Date:User-Agent:Subject:Content-Language:To:CC:
	 References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-LD-Processed:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	b=r6IWDphOHJqy8Lb08sQNv3yWVhGRH+55FYZ0i7sMGwftoywgIwdloK++vnXUsPSmOUx/oeXsF3lHqCkWGkuQ8Ok3eky7N0rkfz/x83f119jjzqTJelN3Wz3bPObztP//BxEMewyl/+PipPI4Tj5OFmqOj8DonqDlaOeP0aLT67E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rh1CccZG; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705434261; x=1736970261;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BeCkwqnHB1UsLBFGhLVgEHX8nQ3Klalvu1QHcBqI4sY=;
  b=Rh1CccZGyVLkucutth2rOdIFfvYDTiLGUMlgon5JcwyKyVcy/1VhQd1s
   9ox3GfrN/kO99ZopB5bkwIVwZp5d5ZsJ3oPbpdiegCGo50NmeUZQVpeS5
   VaLAiCC18eY/t7c0Z91JtenHotBweZ7id9TB7/mMcGlW2A1LrfebCJAS6
   cQb8mqT+t3uUClkRCae6oNqA+idEyJZTnHlbBalrzaQWoQT6a3H9GzpFS
   lwAeeo6YBTZxrjzaT0tQUrghAprhYZrK19NNoqOl2OOCPP1aoggsaWxs8
   VYSpR1OwuybjtZtpT7VsZua8ZYpWoaL0hLGcYkBr79o53rjWWjk/dAAGD
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10955"; a="7355907"
X-IronPort-AV: E=Sophos;i="6.05,200,1701158400"; 
   d="scan'208";a="7355907"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2024 11:44:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,200,1701158400"; 
   d="scan'208";a="18574716"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Jan 2024 11:44:18 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 16 Jan 2024 11:44:17 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 16 Jan 2024 11:44:17 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 16 Jan 2024 11:44:17 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 16 Jan 2024 11:44:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SPJdHMZFksSFZonrxWXLCT9neDXt/bY7AXb+t4sQmQ324ZhiBt+lCIC/oAlRiVRZZ3Y4VZZFmd/+0o+zFJg47s69cHlh7k1dlhzIAJ7BW1QimvdIj04oC6zaLyQOs3xse9zjLA/LkWnNd8DB5VQ7zFjW65y3RkWcxkJ/zHm+/VpHFjdFeUlt78qjPFU8yHWnVEUFaXWCTBWrkEL2FrU9YcLpYGzDNw6QOs9tHpOxljMAbb2Udy9gFcsDljkxYtdo2pfwwmOZGTijOKluSxSRwph6I5LUcfYUtLuOG2iZeaieqpbpUtMZ2XahFbQyDt8bAp2gwJYW6UelSt4d5jMQoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xnF60W2nkIGU0CtNhBPl3sxW6gE1cZ1QdIDf8Inl3V4=;
 b=g0/7rtFlMCv+seToZMjMv6lEE0aFKbt1MwL6dxTa8/zkhSn2fWh7l6/IceEYBZSdJjohyRMgt+iLlH/UdWrvGhcwOR9dXgAjlYNykZfDzOrskmDfgusRW3cWy/vsPwdUFCu1aT3ENHlmt8xYU0DLY9Y4CsTC/6aVwQD2Fr/KknU/0pP42Ohu6kf9ps2acBRffslZn0jRer7u4Thhgo4Gt3S3hk/yWispvxvssQU5GCEh56C1FMTSlxgM2wOb1pI+d6oMV/XZD5S8RVYxeZbqwiV5BMujZVA2onZQ5OI73VzZ8PsLyYDb6LfNoJfbCFe8l9PSMD3sP1r1m0CtlNuKWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CH0PR11MB5281.namprd11.prod.outlook.com (2603:10b6:610:bc::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.26; Tue, 16 Jan
 2024 19:44:15 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa%7]) with mapi id 15.20.7181.018; Tue, 16 Jan 2024
 19:44:15 +0000
Message-ID: <e89278a8-cd40-4e73-ae39-800c29dae385@intel.com>
Date: Tue, 16 Jan 2024 11:44:12 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] x86/resctrl: Read supported bandwidth sources
 using CPUID command
Content-Language: en-US
To: Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>, <fenghua.yu@intel.com>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>
CC: <x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
	<rdunlap@infradead.org>, <tj@kernel.org>, <peterz@infradead.org>,
	<seanjc@google.com>, <kim.phillips@amd.com>, <jmattson@google.com>,
	<ilpo.jarvinen@linux.intel.com>, <jithu.joseph@intel.com>,
	<kan.liang@linux.intel.com>, <nikunj@amd.com>,
	<daniel.sneddon@linux.intel.com>, <pbonzini@redhat.com>,
	<rick.p.edgecombe@intel.com>, <rppt@kernel.org>,
	<maciej.wieczor-retman@intel.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <eranian@google.com>,
	<peternewman@google.com>, <dhagiani@amd.com>
References: <20231201005720.235639-1-babu.moger@amd.com>
 <669896fa512c7451319fa5ca2fdb6f7e015b5635.1705359148.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <669896fa512c7451319fa5ca2fdb6f7e015b5635.1705359148.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0119.namprd03.prod.outlook.com
 (2603:10b6:303:b7::34) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CH0PR11MB5281:EE_
X-MS-Office365-Filtering-Correlation-Id: e2bf2eea-bbc3-4be5-a7e4-08dc16cb8554
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tf4CyCCPhYutm4LwO8xl5fuIoREIOqlgSwbcFQCxArbsTCInvFPzzTRCItFrtIuwiqHjJpklDTJ6ZmvEJxscHgGuE5xpgjGIZv2txxLKuReyHk/aBjVZpet64P+TvZ/KV2g9GKhahd5ovtrYxhTVs7FAeo5r9oQOeceh1fuMUbvPKCowE4oVWA/9WIi28tV6P7HcTKVBF+v29TXz0CgNEAIM8ROE/P/g3MLcojEdBbGPA2g4nyFQua1WVC6AzQ5FVoqDWDFURvUwbCUpFDHmfLceIWuzKvQ+oQelNITWPaOinRrZ4N3GisvXhwG9OnP7qYrCjHhL3ILNXIofj5gHKx853Qq/VWB2jF7ISOTbpQfB/uGTVhINKkVgVjEqeyP7ZyCJWJrA3pTr3KZ2iCIe8LQyGy8xDrLHli08+uBRcOj/FS5U+VIwWzmT1H43wMqsBYu9p8H4J87SGjGK8TdIT16D0KCklY23hfWsF6QsG2F/LmjL5hacIMBCH2jZwoEuAuMbXu90dWihT6LCfDxPiOJkDwCAmV1WJmlkzNVzMTmt+AsZehoJzLJYLwK3LGsiCApTG3Hejgx84Bfe/yGcr2WPELtMHJo2y2hcaZSlWKl/j8DJtIfRx/5ddLXMKQPH/Torr0fprxo6JWw5u3s0Pg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(346002)(136003)(396003)(376002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(38100700002)(6666004)(2616005)(26005)(6512007)(6506007)(53546011)(5660300002)(8936002)(7416002)(4326008)(44832011)(2906002)(966005)(6486002)(41300700001)(66946007)(66476007)(478600001)(316002)(66556008)(8676002)(82960400001)(36756003)(86362001)(31696002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eXZDOXBKVDNVQnAwWWRSamkxSC9HMU5RV1E0UEhodEZiNjVxY0VTSDVWZWJh?=
 =?utf-8?B?V3pvV0F4QnhCQlY1M1BWakpKNGVnb1FEYjdZRzkwK0kzeXZFdkFYUGRLYjNQ?=
 =?utf-8?B?RFFYRjA1TW96UFR1SWtwditab2ZmMTdBVWhIYTZQazRSOU00MExZeXNiODMy?=
 =?utf-8?B?MEhPMTRBY0ttZHM5TVR0dHhFaHExczRsNmxYaWpkU2lTZXJtdjNOMnpTRmN6?=
 =?utf-8?B?dnprYjlmRjR1UGhGdE1zek1rNGthbkZKbjYyWWRQRFlUdkNEQjQwMkhDcSt4?=
 =?utf-8?B?aHRjbnh6bXRyd3hRY0dHRUhRV0c2cERaelhjaWFZbzVDYVNnU28rSnQ1ZUky?=
 =?utf-8?B?QTRudC81V1BUS3ZMWDEyeDd2K28xVzFOckJNSTc5ajQwQjFtRkUvakpCZVNM?=
 =?utf-8?B?Z1Z2dDFFKzhpSE5Cdk9FOEpkUjMzNWd3TWk0aENYdFJ0R2pVOW11TS9xRHhl?=
 =?utf-8?B?aHRURTVlcjR4dW5TTjZjMlFxQmZwZ0xZRVpnMFRPWk9QRmkwZWo2K2lLSU85?=
 =?utf-8?B?Z3RyWXJLSUJKSHFBTkg4SE1vYnUyeUs4LzVWWUtSMkZGa1k0aEd6TjJERzdi?=
 =?utf-8?B?ZmRqNzQxU1FFZDZseGFqYU9MeGVLVndibE52WDVwOGQwbFdOMktadnZXM1Mv?=
 =?utf-8?B?RXN2S0ZMZVlodTc4aUR2YnBvTy8xL21wZWMvRmQ5dVdpcE9CU05sdVpNdVhL?=
 =?utf-8?B?MElQV2k3VlV4Um9rR2lMUWlwQk9acGFuYkJod1NTSkpSVFBVZWpuYmhORm9u?=
 =?utf-8?B?cE01RDk1d3AwMFFzL2M1a1hZL2VVWVk1WVQ2cFgzVGJMeHBLRTE2SmM2Kzk0?=
 =?utf-8?B?YmRVTDc4M3VRd1JoRE1qT2R0Y1M5YWxqYWQ0cUF6RXRnRm1tRFRXekpJdUdR?=
 =?utf-8?B?eWRDTXlPTWdOYjh3cC9Ka09aUjB2bC9lT1RkN0NMU3FIYkZpcjVwelNGbFVU?=
 =?utf-8?B?ak1DV0lJWDhVelZ3ZTBJMmVNVklpbTA3Y0xrNlBvRkdoMEZPZGFpbFhGaUx1?=
 =?utf-8?B?UzcwcjYxU3ZWQmlodXlEelNIQll4TkJVcHpHa0lKQmRvRzRCR2E4VXFIWVBC?=
 =?utf-8?B?Y2lSV2kzOUtJSGFFQ0lrdDhJZnpxQmI2N09vWjdyRkRUQXRBUS9BTm50RFFl?=
 =?utf-8?B?UkZQOFhobC9YMFY2M2laNXFic2p0ams0Z3pPMlVhYzYxcXQzdFk1c1I3cGVK?=
 =?utf-8?B?U0VRbzdEMVR2VllPWmZpNkNYNThBcWRUbEduVzM3eW1ocXRENjRtREIyZjNG?=
 =?utf-8?B?RGtMUk1NS1JXWWdZelRoMjFsSkppU3pVWnRsMHc5bjR6ejJCd3pzclNYa2Zy?=
 =?utf-8?B?bmtMSkQ5Qm94WitrbHQvNFhBb1BrZnFKMHcrSWFEdHFDNHJYOU8xWCtqVEZw?=
 =?utf-8?B?UnNJRHFKRlFnalg0VGJCd0lTSXJGV3FBREZZY0ZrUlE4S2h2ZUhSbk11b2dV?=
 =?utf-8?B?WEJDRnkydjRSVjRaZnJaQVFrUkMzUVg3VWp6amIvUHpIejdGbWpDN2JCS0tj?=
 =?utf-8?B?MzF5WkN2blZEL1JTWk82cnJyUWNzTGlkZUtPSFZFNnFqc3RWZkU5NFpMakUv?=
 =?utf-8?B?OEMvVEZ2eEZac3VLV01nMmdKUGRRM3lzUC9Xb1BoeVFNeCtNZDZYdFpvYXBh?=
 =?utf-8?B?dkRNeWxvellZd2NSSlFjakJQQWprRlk1WDJ4ZDZleFE2VWs2U0JBM3RVQ2ow?=
 =?utf-8?B?UFhXMmN0S055blYvLzRaSnMxcytqb0pYcXE0cmk0Ymg3Yy9KdVhNOTB1YjBI?=
 =?utf-8?B?eTdHOEdZT3kvZmJXYkxnZHhMSlpUTU9yc1JoSjN4K2k1K0REU01OcFVCbGFW?=
 =?utf-8?B?YWRGTVZ1alFEK29NeHp5ZWRlWkFHeG0yUHY3a1Z5VGd1S2RVbnB1b2FCTHJw?=
 =?utf-8?B?VDM3b0s0cy9sZkZhOXdOMmVVcmZPSXl2VTBZejU4VGxNSXFSZ2Y0a3hqdE5u?=
 =?utf-8?B?czhXSWpTMGQ3TkY1TFh0Y2RVWHpMSUVxbUcvT1JYa0FabzV4QWFsUXgzUFJs?=
 =?utf-8?B?MVU0clhWNWdKMGtVMGN5Z2g0TzlCK0NnazNaRjVmSndJb2ZSV1VCSnhGSlg5?=
 =?utf-8?B?N2dvaTBNMnRQSjl4MWJ4TzMrQzVaMjBjcDJaOG5vS1lxczdPZGxROHIzMXNv?=
 =?utf-8?B?cktyRTBuMngreXk3RmJCZTlGTndYYytwZGJmK1RhUllPOW9vZ3QzdmlONklK?=
 =?utf-8?B?RUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e2bf2eea-bbc3-4be5-a7e4-08dc16cb8554
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2024 19:44:15.2850
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WcSQySJZEjiQWrnKLlTyX06MUhKmy/7tzaWP91r00Oq2kMGrJb5glX7yyiFSYHPcqjBfIo7hG2BYYCJ3XaN4UPBozWAzqPWLUvmqb6Kwikk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5281
X-OriginatorOrg: intel.com

Hi Babu,

On 1/15/2024 2:52 PM, Babu Moger wrote:
> If the BMEC (Bandwidth Monitoring Event Configuration) feature is
> supported, the bandwidth events can be configured. The maximum supported
> bandwidth bitmask can be determined by following CPUID command.
> 
> CPUID_Fn80000020_ECX_x03 [Platform QoS Monitoring Bandwidth Event
> Configuration] Read-only. Reset: 0000_007Fh.
> Bits    Description
> 31:7    Reserved
>  6:0    Identifies the bandwidth sources that can be tracked.
> 
> The bandwidth sources can change with the processor generations.
> Read the supported bandwidth sources using the CPUID command.
> 
> While at it, move the mask checking to mon_config_write() before
> iterating over all the domains. Also, print the valid bitmask when
> the user tries to configure invalid event configuration value.
> 
> The CPUID details are documented in the PPR listed below [1].
> [1] Processor Programming Reference (PPR) Vol 1.1 for AMD Family 19h Model
> 11h B1 - 55901 Rev 0.25.
> 
> Fixes: dc2a3e857981 ("x86/resctrl: Add interface to read mbm_total_bytes_config")
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
> ---

Thank you.

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette


