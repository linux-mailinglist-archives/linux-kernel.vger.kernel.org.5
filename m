Return-Path: <linux-kernel+bounces-147963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D7568A7BE6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 07:36:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A15631C214AD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 05:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B1C9535D1;
	Wed, 17 Apr 2024 05:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G4ljZTyX"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD35852F6A
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 05:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713332170; cv=fail; b=SU7UFuWDnGQMtJVSfrGoKJSsvP8T9zVT8jtms+Oo7tumG560XXuqpe/sY+PGVb2hKyitQi/AYFRJScq2Df6mkL6hifdd/Z7Ofq9yICcc8B/AADA2LfqNGbsBEwEHp8bI5inOHPaLnR1Z3S3FfKMgYsnQl5KC5EYDf6RdQ47jZdY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713332170; c=relaxed/simple;
	bh=N0srBs9lg2Cm0Q1ake7HcrdfW5EpYT4W1qp4Xy81wC4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bDS62vWx0Oqt7w3unC69helnL3dm7JZEacKNJO49z2H5IDtgUcBREh8G6WrlH9E4NYQD/aYjLdsNe/zi6fYCOHy9scnle9h9dNns2sc3XlEV0ZkVyGW2x7SW8MP8aHSwxBUWrvWYgI1FOmUjMAZvu0cM3v1X2XbhX0lM8SmR1aI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G4ljZTyX; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713332166; x=1744868166;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=N0srBs9lg2Cm0Q1ake7HcrdfW5EpYT4W1qp4Xy81wC4=;
  b=G4ljZTyXKlgGHuTa6wI+uPP+yAaxL8RROkxg26jO4EwimOTGRs1vUGE4
   KoGyxhmSk+WJ2EO5G+YjXYLWyTmSN+DZAcutDL3iKcp3PO2355/CyFda7
   FNsBn6G6ZhqcXOqnnD62a8XOxQmBd4EmXtp/fMG5Oiz8DcW+1+ZiItGJG
   TKGGAWPMlcTF1DoGFzsrD/bo+0SXUw1oduPFkEJCeXJk4ez7qqiczDIz5
   9jXufGRbnnILkT4oC5sn0v4IB5v6RRItv0vgWg4XPX78G8JQxkNG4Uc2h
   RIFaF50KDHfFBoObsF9AIVjawEzke+WB09xT4i91npdTOJhezHFw+SkkU
   w==;
X-CSE-ConnectionGUID: JiayJz/CQYaRKBuTjNg/gA==
X-CSE-MsgGUID: 2rofy4D0T4OjMlTS5ATicQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="8928936"
X-IronPort-AV: E=Sophos;i="6.07,208,1708416000"; 
   d="scan'208";a="8928936"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 22:36:05 -0700
X-CSE-ConnectionGUID: hr/Inr9PQ82lDoxlvs0PVg==
X-CSE-MsgGUID: rbSBAaYpSsm5CGPtOv+BNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,208,1708416000"; 
   d="scan'208";a="22987542"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Apr 2024 22:36:05 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 16 Apr 2024 22:36:04 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 16 Apr 2024 22:36:04 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 16 Apr 2024 22:36:04 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 16 Apr 2024 22:36:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H+VgJgdDt3qRWSr0kFZx3b7uhS8RI1tCKiFUpRPpstOIoVPLORcC1X69cT835E9fMvvrLNGMMnwDA3ZzPqz2rdMEkQ7T9ljk82eOgrjiGae//jUDmsh3pfN3kgRbFRA0aAMoz1Ep2aLohI0lVhgzo3xIoGmPbPOa4SEK27e2M34B8o28BB5mwHDqV+gSuLMR2KMtEpHZrR3HcGdWhabVeoCAElyISxc62jwNg/Lquzc6+LX52EnxewrmA6HFXLVhPzTOJSq8BtHJ5KQ9swDBTsnFPaOCtCMUjM5OvHWtT15WIzb84c5UbKI0wUX6LcTerpR6k7PxT70iQxNQEUoxeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BlCw//HKHRqD4XWZDtBrMSfXX1qWa5IEl5HphS4cWAA=;
 b=CPmkoesEDUazExh1gbFUOWv1TxRD1RQNawVi9fFz8b8PgIIcNzjvd0QZ05P86ZA1HQsEDfSuwVeRBALh2CVw45PuRBVrgPjNgmTzpRmdF4MjWwAAWNbQfMLF2Z1rYWYjaYnipHtqXr+odAPUAgu/3pQl4KQrmwiJs4jqHVQBpmEh+6FbtWQ0tkd5Ygr1GWAkvs4H6zGbgOP1JSz5vzfjW+2G21bXlp5BvbwE8bznIxdWY+Iv2QYItWfs7BOXgCH9/dqT5RE+L5lE/HvUc1xep2gGO/lM3iAFLWgDJ6mifCvswc2eCgGKagi4tFV4NPiC//GOoWDctuexHmLDvEQNog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DS0PR11MB8665.namprd11.prod.outlook.com (2603:10b6:8:1b8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.29; Wed, 17 Apr
 2024 05:36:02 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68%7]) with mapi id 15.20.7452.049; Wed, 17 Apr 2024
 05:36:02 +0000
Message-ID: <eeb900f4-30ae-45e8-87a4-30c3faf7c1ba@intel.com>
Date: Tue, 16 Apr 2024 22:35:58 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] x86/bugs: Replace CONFIG_SPECTRE_BHI_{ON,OFF} with
 CONFIG_MITIGATION_SPECTRE_BHI
To: Ingo Molnar <mingo@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>
CC: <x86@kernel.org>, <linux-kernel@vger.kernel.org>, Linus Torvalds
	<torvalds@linux-foundation.org>, Daniel Sneddon
	<daniel.sneddon@linux.intel.com>, Pawan Gupta
	<pawan.kumar.gupta@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>,
	Alexandre Chartre <alexandre.chartre@oracle.com>, Konrad Rzeszutek Wilk
	<konrad.wilk@oracle.com>, Peter Zijlstra <peterz@infradead.org>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, Sean Christopherson
	<seanjc@google.com>, Andrew Cooper <andrew.cooper3@citrix.com>, Dave Hansen
	<dave.hansen@linux.intel.com>, Nikolay Borisov <nik.borisov@suse.com>, "KP
 Singh" <kpsingh@kernel.org>, Waiman Long <longman@redhat.com>, "Borislav
 Petkov" <bp@alien8.de>, James Morse <james.morse@arm.com>, Dave Martin
	<Dave.Martin@arm.com>
References: <cover.1712813475.git.jpoimboe@kernel.org>
 <3833812ea63e7fdbe36bf8b932e63f70d18e2a2a.1712813475.git.jpoimboe@kernel.org>
 <ZheV2ly/LZjpaVTE@gmail.com> <ZhecyLQsGZ9Iv8wU@gmail.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <ZhecyLQsGZ9Iv8wU@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0348.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::23) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DS0PR11MB8665:EE_
X-MS-Office365-Filtering-Correlation-Id: f56350e5-b44f-4264-55a9-08dc5ea044f9
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AvOqfc50MQavQh4GtiWLu0pbztdhAvRyAoruFmxb9RDqlLXbPMEDOhLsL9tXk+NkrbFlgSLpLkZvBUUpjJEGv7MR0Hfo9LQFHUl6k0Rqnz9oeFMfV1zEZoZRtUayOc6Oogpabn0JwWfVbnMhP1jPd5REviZEV/ZGcqo05eRGxjcEseeKrZHp28ncayHz9+Dk9XFqmVReYsWjxZb/nJjrdSlXC3NkxtTyZZaO3xKM0Mdmhf/WhQILsQy1452st4DOAppmj3iw1d6K7P+6ptb8OCsuCO0k4mITPFQ5DgrCd6SWINLElyCajNjCT/t4x498kwrrjR6P1NGtFkwXSlXlaVsfhbHVDvm2lGdDkpTTBzIcpNo/1uz19ZXqSLeMVgfFAQNK3YDt+B3f++frqn4WgV2QCz5KZzIjHFUUv3WrtKEEHNlxdXOPqzak6xZvqWJwqZ3yDAx7GdNTia/zeUaZSil8fobQ8sWrNin1KXVsvZCasQzwxPz84OZNEq9oBQFE0dyhgwj8I1DdZyep4m4/KCYH7d1ePOiPjQQ+u581yr3ZlTMf/oNLzNBhBX4a9yb0iFdsyptDr0zlUSMczUKgsz4AAPHquUgyFX1QfKTsLqd6mb2Ja1+jYtaGJZkLlGDVS9BfxWiQtbGtmqzkjCQQzMdxXHPG1QTEYA8npatQFcQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UURSZnJXbWZhS0pUcGtQNnA4eitZQ09sZkZ0Y3VaV3lPRG5Va2ZsdFNhREFv?=
 =?utf-8?B?LzlnV1VIM0dCNEhQM2RPbzhuSGNPZkkxbDI0aHYzdWpXRkN3cHA0cmhqNW5u?=
 =?utf-8?B?VHM0YWFvUlJhWFZ2elArN2g2bVpVZnZCRU0zOTgrZEk3dnBWTkVLYi9YNmU0?=
 =?utf-8?B?bTQ4ZlNrV2FSUm0rSmhwNndqOTRnYXZDWUZjM3FhOGxJM1A3d2tueFhNNEFz?=
 =?utf-8?B?SDB4bUt3UEozeldnZk9TbVk0T0RsMzdsQU5XNlk3SzdEdnIzOGhWbENveHln?=
 =?utf-8?B?N1BYRWVvKzZnVHdQc2tjOEdLL2N6S1ZHOFFvWHlYWkRmcnY4blV4dnFqODhB?=
 =?utf-8?B?d3V0dVNNUGFUVVRPaFR5K1JRSlRGU0ZjTGU2Mk1lRTVSTVhCb2ZLVno5Tkl5?=
 =?utf-8?B?M1JOVFBXTEx0cHB0MUhvK2ZscHRSUXkzQm0rYWsyb0VPa2tRaHNDYkpRMlpl?=
 =?utf-8?B?Z1paUk5zc2wrY0R4Q3JubEowSjJNL0ltS3FTVVJITDVuNHZvMHk5MkdNVUVt?=
 =?utf-8?B?WFJnTUwzR25SRk90TnA2ZnU3L0M5dUpReitETUIxQVk1TnpLSHZ0YVNaeGhO?=
 =?utf-8?B?Sm9MWXFCbTN1NVpQS0NVVUE1MUNjOExlQytNNEJYUHhjbkZnMEFGVGNNR1Jr?=
 =?utf-8?B?ampSTVAydkFnNlNKZFpNQ1FmZjk1ajJMWVhTSkpoQ00xa0RUOWExMGNVT2VZ?=
 =?utf-8?B?ZEIrUVd5Rnc1dHp1M2VEdzUydFN3NDMxbitybjZma2VyeDloUzJPTWQreVNT?=
 =?utf-8?B?UktyWUE0amxqbWdKWUFpWldCS0ZvckphRmVEMGlJOWdLOVBOYTFPMGNuOUE3?=
 =?utf-8?B?UE1ubjFSd1lZeC9sWE44K0I2YTM1bUJjcVovZGNPalFwdCtRTkNzNWN6Y2Ro?=
 =?utf-8?B?dEcvc0NSYkorejFvR0hsY3RjUWM0bGFxRGZGbzVxTDZkNmFaNVRkNGdHd0tt?=
 =?utf-8?B?Vm1CY2RqUlVqc3hmSFo0Q0NLVitJWVV6S1d0UWVMSnZBN1M2WTdUUS9RWHNF?=
 =?utf-8?B?aEJYTXlXZXlmRXQvUmJVczRLRzFTMERwWjBPN0IzbUV2RlNoZ2YrUys5VUpZ?=
 =?utf-8?B?N0M5dTZtSnROblNzWExVb2lMT3BJbVE3THV4dUh1WGM5TG12Z21xdWZDbmt4?=
 =?utf-8?B?TVJCWUJhVnBOa0ZNL3FEZWpUQ2V6eXJiU3c5Rk9OR1hLMzR0dkI5MkZFa1A5?=
 =?utf-8?B?MGVsQ1ZSek54OUtLNjRoLzhxRVFDdWNwMG5QYjFtcCtZOUM0R1R0Z2ozRnlI?=
 =?utf-8?B?b1I4V1dtMjJSTXR5a0oycDdQRFRVQWMrQ1ZQbHVNaENNUWVvNTFCOGVNWWNW?=
 =?utf-8?B?VEFjMzUxcWRBdC8zaGhPSUczR2NxZFJ3OGZXT0xkLzlnNDFIRFZlTzloTFha?=
 =?utf-8?B?REJJOUJwNWdyS0lCUkl1emRRMXF3UU1jZU95bGFTWmdkaFhOV3hiZHJvYndq?=
 =?utf-8?B?REZkem8zaUdDVk5mb1p4Nm5BTWhhZDJHOS8rdGdreGljOFhHVHNUR0xlL1FI?=
 =?utf-8?B?eHlOclpjZkJ1UDk2SlQvVVVqKzl0YW53RGdoQ2FmdzBUZjRWWUt6UTAycUNa?=
 =?utf-8?B?a2Q1VldGb2tqcGMwR0JLR2FCcTFuTGxyL082ZjcwdkNXQW1zbjhmL2ZZVG1u?=
 =?utf-8?B?aEVUWDFkd2Q0THBqWDFETmpiYzhpSUJKQXVmUEUvVGpXVGdXSkFEN3Awd0pI?=
 =?utf-8?B?dzBVSzNhWmtUZ2dCY1QzTVRTbWZEZ1ZraVZuNFlEYUVhRWpQVFJGMkc3azhH?=
 =?utf-8?B?SDM2emdMNWRmRm14Vmh0NkJZM3V4amRGNm5UcDZ1RVJ5ZnZqWEZDWFFoZkMz?=
 =?utf-8?B?TSsxK1NhMEE3eHJJaTBULy8waE9NZEtLNFV0UUJuWEJ2N3R6YTEwdHNEN0Jt?=
 =?utf-8?B?a1haSHA3Y1F1bUN0cFRhWU91Y0RzSkFHWnZnbWk1czlBdVk4QWVxQ2dmVEM5?=
 =?utf-8?B?aUpvbTgrdmFyeXRuQzBEdWdobElnWlRDUVJObGtnRmxRaSs0cWR5VElrQ2pu?=
 =?utf-8?B?UlRpb3lSWG91TGhnUUJqaWQxTVVGclJ0VSs1bnZFN2FYMUNPK3AwL3lIaEJw?=
 =?utf-8?B?NTRuY0tVY2U0cmxqLzFxS0x2VE5OL0luUkNzWEFEakN6SndTanhWS3RjRlN2?=
 =?utf-8?B?TnhoOWdMSDlkK0RwWFFpU2I0MldCdXhzSjVlTEVSMWNBUmNJeFVyWWNJaWg0?=
 =?utf-8?B?aGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f56350e5-b44f-4264-55a9-08dc5ea044f9
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2024 05:36:02.6063
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eOcysRWnzmS68SX9O4NXab3HdNRgZ2JIHqWK1hN1pw1wOLwX1O7ZuoObHCPp+0tjKwK5cU+YwA7LeRWlwEEIo0xhKqgJji5mZncoGHWyD/g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8665
X-OriginatorOrg: intel.com

Hi Ingo,

On 4/11/2024 1:18 AM, Ingo Molnar wrote:
> 
> * Ingo Molnar <mingo@kernel.org> wrote:
> 
>>>  static enum bhi_mitigations bhi_mitigation __ro_after_init =
>>> -	IS_ENABLED(CONFIG_SPECTRE_BHI_ON) ? BHI_MITIGATION_ON : BHI_MITIGATION_OFF;
>>> +	IS_ENABLED(CONFIG_MITIGATION_SPECTRE_BHI_ON) ? BHI_MITIGATION_ON : BHI_MITIGATION_OFF;
>>
>> Uhm, after this patch there's no CONFIG_MITIGATION_SPECTRE_BHI_ON 
>> anymore, which is kindof nasty, as IS_ENABLED() doesn't generate a build 
>> failure for non-existent Kconfig variables IIRC ...
>>
>> So AFAICT this patch turns on BHI unconditionally.
> 
> BTW., this is why IS_ENABLED() is a bad primitive IMO:
> 
> kepler:~/tip> for N in $(git grep -w IS_ENABLED arch/x86/ | sed 's/.*IS_ENABLED(//g' | sed 's/).*//g' | sort | uniq | sed 's/^CONFIG_//g'); do printf "# %40s: " $N; git grep -E "^config $N$" -- '**Kconfig**' | wc -l; done | grep -w 0
> #           RESCTRL_RMID_DEPENDS_ON_CLOSID: 0
> #                   NODE_NOT_IN_PAGE_FLAGS: 0
> 
> 1)
> 
> CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID doesn't exist anymore, but is used 
> widely:
> 
>  kepler:~/tip> git grep RESCTRL_RMID_DEPENDS_ON_CLOSID
>  arch/x86/kernel/cpu/resctrl/monitor.c: *     Only allocated when CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID is defined.
>  arch/x86/kernel/cpu/resctrl/monitor.c:  if (IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID))
>  arch/x86/kernel/cpu/resctrl/monitor.c:  if (!IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID))
>  arch/x86/kernel/cpu/resctrl/monitor.c:  if (IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID))
>  arch/x86/kernel/cpu/resctrl/monitor.c:  if (IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID)) {
>  arch/x86/kernel/cpu/resctrl/monitor.c:          if (IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID)) {
>  arch/x86/kernel/cpu/resctrl/monitor.c:  if (IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID)) {
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c: if (IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID)) {
> 
> Each of those uses is bogus, as the Kconfig symbol doesn't exist. (!)
> 
> AFAICT CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID was never defined within the 
> upstream kernel (!!).
> 
> AFAICT the first bogus CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID use was 
> introduced in this recent commit:
> 
>    b30a55df60c3 ("x86/resctrl: Track the number of dirty RMID a CLOSID has")
> 
> ... and was cargo-cult copied in other patches. It was never explained in 
> the changelog why it's used without a Kconfig entry anywhere.
> 
> Maybe in the future some other arch might (or might not) introduce 
> RESCTRL_RMID_DEPENDS_ON_CLOSID, but that doesn't justify this bad pattern 
> of dead code ...
> 

We are in the final stage [1] of untangling the resctrl filesystem code from the 
x86 specific code with the goal for the resctrl interface to also be used for Arm's
(Memory System Resource Partitioning and Monitoring) MPAM that is similar enough
to AMD's Platform Quality of Service (PQOS) and Intel's Resource Director Technology
(RDT) for which resctrl is currently used.

During this work we incrementally separated the resctrl filesystem from the x86
specific code. RESCTRL_RMID_DEPENDS_ON_CLOSID was introduced during this effort
to prepare the resctrl filesystem for a fundamental difference between x86 and Arm
and you are correct that this is dead code until the Arm support arrives. The Kconfig
entry is currently being reviewed [2] as part of the portion where the resctrl
filesystem structure starts to take shape but it remains without a user until the
Arm support arrives in the next part of this effort.

I do believe that there are precedent for subsystems obtaining support for features
a couple of kernel versions before users of the features appear. With Arm MPAM support
requiring this capability from the new "resctrl filesystem" it did seem reasonable at
the time to add the capability in preparation for Arm support.

Reinette

[1] https://lore.kernel.org/lkml/20240321165106.31602-1-james.morse@arm.com/
[2] https://lore.kernel.org/lkml/20240321165106.31602-30-james.morse@arm.com/

