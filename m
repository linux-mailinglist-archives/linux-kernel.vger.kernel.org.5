Return-Path: <linux-kernel+bounces-142488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51E0D8A2C38
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 12:23:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 437241C217E2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 10:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE9F253E05;
	Fri, 12 Apr 2024 10:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gQdODnrs"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3197E54656;
	Fri, 12 Apr 2024 10:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712917375; cv=fail; b=YHysOHnC2x4s47WbsVt70BZIgQ8lF3IwVS2RRo9QXJQMIRjfPWkxgC5YDhQQ2nmAo5Dxf4hnZdiqhqEhJS39J4lR6AYSJ3mcUPhQz9S5Bb1izpsOs2RglrZx9ISRLdpbc1i3Rngb1hJq7GyKYSpyQ11eT4hAZ70RYtE7SQ0YUvs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712917375; c=relaxed/simple;
	bh=JTYTUYdBlF/FmvBG3JBlXOp3J4SeBmUWYH+VP4158CE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gLwIQ+M3xyv1agJuHXslVDvwfQzQolWsltPGauV1fFZ7ms6AE4WnNrrt8BOqHbZFL+L5ENVtEgMvlU0DNgSx7jgIwQMafxFziU39hcJkpl+R7oNhVsTDoM61/vPwELBPwOpNFkqe7dlnfHrPgkw3WsXm7cvGQJuAssC5Yk8TI3o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gQdODnrs; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712917374; x=1744453374;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JTYTUYdBlF/FmvBG3JBlXOp3J4SeBmUWYH+VP4158CE=;
  b=gQdODnrsFdJT6K2YW1TFjGbHeR5eTnv8c+rsOj8oIH9v88gliOJA09YJ
   tCs6A8Op1izBss0fNYeyWO95FEaRuJqdcFL6RmHcqcHRWIx0Nmiw70WT5
   iN8YXSHe2XtfbA4HYW6ScQyca3btViSNZAqap/V2N8WOusCv+laI5hX0S
   slz3lE3/G9XKah6pJ2VE+jEW/HP86WkNqQ3gWmw5tuOvZlE6OJzR7XcJy
   iew6InPjwTwEXaUyqX6b5wwE3n+vYA3KZERzkM1elHq8afXjyexy580/3
   wl9Q/T2Ji9TC64JMVnkb82aOPJXxVxulMbJT7jMZZTRC6U747X0GWtFk4
   A==;
X-CSE-ConnectionGUID: 0mvaIzkSS/amKxnJzOvaxQ==
X-CSE-MsgGUID: Sq7rRT+mQu2+hHwAGqU/Vg==
X-IronPort-AV: E=McAfee;i="6600,9927,11041"; a="30849067"
X-IronPort-AV: E=Sophos;i="6.07,195,1708416000"; 
   d="scan'208";a="30849067"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 03:22:53 -0700
X-CSE-ConnectionGUID: 0Zay23LmRmGbndZ6oyVx4A==
X-CSE-MsgGUID: AyV7VoXBTn+GUnSvcupD6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,195,1708416000"; 
   d="scan'208";a="44458338"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Apr 2024 03:22:52 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 12 Apr 2024 03:22:51 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 12 Apr 2024 03:22:51 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 12 Apr 2024 03:22:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cCIqLoEw7YQWiCKKNmQy46T8pMbtnqDzkWb7QoyiB9OQ2p1K8vsxVshyHvNTMpvZXyxHx9IIDk5JP/Mj5cxpwTT3Wv3/hzyBUUDkVdUhPiL1UWsTY75tYM2OHexGfjWIx7+75SV6c4yUgvG8+rPfGzL7xUK1hWkkVIjGhjqvhHgRIgBzWUyL+OR7zBgVj3R0slp79pOwXWtrj7SSRVMQIDoouxQZVrj27nHBOmgg0gibPQHjXScg6fuld+HsRyzWEY2KpXxV2FG1iz6hapkvjHQ9OtDONMUmSpGldfh4XEoRpsbjugZjN7lcaXPltWcrXPADEnUluS2l5wmLMZVJrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gw2wikkvyFvon/I6oRoDPo1QpZpVIrajWw7DzfhNOjc=;
 b=QN6KGYtnPfglKzx0JCLPnj4lGKgZZC0QWgwiYoYO/UL34JBBc61nmDfj9/NtFVU8HzrUbxex57mlspiPwYeANqVbUXlTeRRBfr47z52yTPb64txS+wyZ/WPPpG7Q+kYR/9ndLu82Kj0hkw1/lqtakM4OTHpM3+vePKpuoOEteEEmIyBIt80/NvKpQpTS2b5KaqVchQXj2TgcGnqrgI2v8kwpJg0j4iImI6ij4w3ewdX31Fa34a3A/ULZ8mhyB0jV9m+MjogBGcnQZM5SbRB8/fgYtW0H2m29OMHuBIC3y06NyKfGcMkUDlmIFYaLa2KaFJrVqei162ZnlTesMRSp3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB7110.namprd11.prod.outlook.com (2603:10b6:806:2b3::19)
 by DS0PR11MB8719.namprd11.prod.outlook.com (2603:10b6:8:1a8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.25; Fri, 12 Apr
 2024 10:22:49 +0000
Received: from SA1PR11MB7110.namprd11.prod.outlook.com
 ([fe80::48e0:2fb8:7d8f:4a67]) by SA1PR11MB7110.namprd11.prod.outlook.com
 ([fe80::48e0:2fb8:7d8f:4a67%6]) with mapi id 15.20.7430.045; Fri, 12 Apr 2024
 10:22:49 +0000
Message-ID: <e7fc4fa1-01fd-45ac-bce5-e8a03107363a@intel.com>
Date: Fri, 12 Apr 2024 18:22:40 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf parse-events: Avoid two scenarios involving the
 reordering of topdown events
To: Ian Rogers <irogers@google.com>
CC: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
	<jolsa@kernel.org>, <namhyung@kernel.org>, <adrian.hunter@intel.com>,
	<kan.liang@linux.intel.com>, <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20240411144852.2507143-1-yanfei.xu@intel.com>
 <CAP-5=fWaB9c0m3Y5zAAS_4qs-L7n0=mqp7=zwatQOQmTc32YNQ@mail.gmail.com>
Content-Language: en-US
From: Yanfei Xu <yanfei.xu@intel.com>
In-Reply-To: <CAP-5=fWaB9c0m3Y5zAAS_4qs-L7n0=mqp7=zwatQOQmTc32YNQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2P153CA0028.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::15)
 To SA1PR11MB7110.namprd11.prod.outlook.com (2603:10b6:806:2b3::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB7110:EE_|DS0PR11MB8719:EE_
X-MS-Office365-Filtering-Correlation-Id: b68a1989-2ab0-44db-97c1-08dc5ada8118
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A+PYjhJKDY7fx1qnYqvWK16V0igQrWHdbByBQQXhIXtrmmwfQN8LEcqi42LId0BJX8hI+dVdz6VGX/uzQWhO0wn7Q5HuyVUv4XxKeFXGnQ85WrUve6ADX11+qmJnBwnAvug8P01QyvVErRsYBr0qw/gQ9C4tGWEPLboJIba6rfsw+nBhQ9RBRa1QJU0Lkj1evQSJC2ACnVogMYbl4Bcf7SPYl/dcBDOsYEFcaIjnSV+BC005HDrgNbP4A63jYA4M2OE7HB8IfsgAzEM2SHwEm/dPhiudn/B8V5r4ilbS94+OLt/E0guW3sM9UKfax/chbF+IoIvS7gQtn5aGp45X+wucqjBl2o7mSUDnN5ECsAddI72KYlrlsLE5jLjCxKsWu5Lx4H6zpw2Bf2rCb+ZMvwRSO6T6vs8ouaKjmv4v4ceUvnTFpNc1tobeOV9QwFPZVG87hF+IWR2SxMe5Kw2fXrsAGjiANEBcYiQKVy07ibA7astljHggj8I8YfyU9qDeRQYWfXtw2QFjQ5FPu7CDE85xTXVQSoIlfnGwHKZVTkC8cyJU5XJ9tmaRk7S3+TI0zzV5Qdsl58uF1/T7PXdwFk4HlyMFd46F/Mi4Y8SSaDRUhIVSAjlwW2SVgIKTCvvv
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB7110.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TzhzZVZ5bnRNZ1gxWFdZa2xTaXR6eTNZQVhaV1pGNWc3RERjMU51NlZMdnZy?=
 =?utf-8?B?NXNheDNMaGgzenVBWXBKQnQ4eEhRU21YYnVYUmVGT0owNHNWVjlkcDF4Vm9r?=
 =?utf-8?B?MHl6MFIzZERlSHhlMFpyQkhzM0dibFdWWWNQTUJHbG9HWU9xdGhPcnpiakRC?=
 =?utf-8?B?eVYwMUd3cFpiTVBSb1JwbmYvazczRUVZVW41eXFsZWp5RVprME1xaVpBb2cr?=
 =?utf-8?B?VGZJc2EwMFF4b2kvaGo5NEYvSTBPekhJY0hvdGR0TDlFR1EwOTM1cWtsc0x5?=
 =?utf-8?B?cjBOd0lpSUlkVnpjV2RvaTkrUk9xemJtbHJwMHFuUUhLcUszNlorQmdzVTdw?=
 =?utf-8?B?SDdEbXVjWkZIOSt5TXByMk5jcUE3NXNZYXdrc1VvTlAveldIM05UeVdDTlZv?=
 =?utf-8?B?UEpUajJlSWRnaEw5VldUR24ySlkxZzhGT0ZiR21RbDRuSDVjY04xUmthSFJB?=
 =?utf-8?B?V2FxOWQrOXhBeFVzdWFEVTd4L3Zjek16RllXZklGaVVaQzlQUEtFTzR4R3lV?=
 =?utf-8?B?ZEExeFRGTFExTlVLTmdxWFJ2NjV4SjFGMWt1S2pjK1gxTmxTb2M0Q1Vhakc2?=
 =?utf-8?B?d08vTnk5eTNPd1RNNUk5Zmg5c3hiK1NNc1BXK0EvY215WVkxcUxmZE5LK0xS?=
 =?utf-8?B?bzJnTXMraDZndEdPMlEwY00vUVcyR1lKSDlVVXc0OFduRU5LUFZFRFRFVmhm?=
 =?utf-8?B?a0VPbUdSaUdQSDhGNVRLWFUybGdxa3JtOXV1VU1LZTdxRDAwMmpyRHAwaGpx?=
 =?utf-8?B?RGs3bGxWaW9RSHIzNHU5emh3VGluYUtyVTFiVVFGaGJGeXdIY2dLM25WK2Nj?=
 =?utf-8?B?UDF6dzlhTXkrRmJxSStLejZxRFN4c2lGRDMrRU5NYzVORU5LM2ttajNUY1oy?=
 =?utf-8?B?Uk9sTlFZWHkxdzNrWS9JTVNRSjBLMHU1OTJRNFphVWtRQnFqb3hsRGp5N0Vq?=
 =?utf-8?B?VHFPakFGZEZPRzA4YmZWK0lyT3NTTkhzdG5hMDgrRW1HNXQ1M0MvZU9FejND?=
 =?utf-8?B?Rm9leTJjWXlya3NhcWp6amlnSDNEZGRISEhReGhhekZCVThObWRobHFVTlFE?=
 =?utf-8?B?TEVpWTVBMzFQMExRZTNDOFo2ZmdrenpLYy9rUVorb053Y3o5a2tUNWl2ZGxL?=
 =?utf-8?B?TndycnpRc1BjbFpLUGV6U283ZERiUnIxcXRCTnRaRlY2SlpwSFdLcmxRTk1w?=
 =?utf-8?B?QjBXMzdFc201a1JSSThyL08wVkhOZUFUMHhIV3g4Q2RHRWkxbkNoYTRWQ3A0?=
 =?utf-8?B?NjNvS2dmdnJncS9wMUlmT29TUUFpWm1kZjYvMkxDMmpVQlM3Q3RvM3hWZnM2?=
 =?utf-8?B?RUE0NW9vZ2R4dmJjbHN4bllBVVIza2NIcnhQdzkzdUlYd2xwaEE3MjFPMHJ3?=
 =?utf-8?B?ZjlPRXZ2dHVZdjRkTnlCRUdzTktxOWI1ZXRaUWV2Ti9iOGV1Zk14Z2VxTVh1?=
 =?utf-8?B?eTBYdzc4ajRickhMUEVBcEpiY2EvUVlBK09rVWJnRlE5a1Y4OGhncUJQYjdu?=
 =?utf-8?B?U09QNWVCT1A5Z0srL3orc1AvaTU5TUs3VUJxQVpvS1prQS80WnBiOVZBUm81?=
 =?utf-8?B?ZURkLyszS1l3Rm9qUjIzcFByem0zZjBsOUJlckVicVB0TERBajB4ZnhpTjhW?=
 =?utf-8?B?R0pIdmRQRWw0azBQYjZDSXI5MVFISDRvSFRKMm1TL2lRZmdxSm5aK2JjL0Uw?=
 =?utf-8?B?MnlTcEFLVDdTU1ZIdFRwbDFBWi93MnZJUjF1cng3alB0cHdCalVhVm9IRWR4?=
 =?utf-8?B?WTJOTDRCMmkxWmsyUkRPMkxiZ0s4TkJXNFRwOXY5RDJ6U1V6MEFqdlF3RHhL?=
 =?utf-8?B?QzF1U2xkblRZNzJtOGk1Vm9rdDA0MzJtQ0s3U250QWNMNlFoUU02QTdjdEpn?=
 =?utf-8?B?TU02eG5Hc2ZraTIzUEdWdzgvclZDNFFyNW1vdm5tcHlQQlgzZmVBclloVjBI?=
 =?utf-8?B?dGtMZWhOVlFnRmhtYldHWDJGQ3g2QU5ScHBKVTJLdjRpalJUN0g5RjZWWkd6?=
 =?utf-8?B?UStNSWZDU3BLQ0lPTERrbTlUbDAxc2w3V1lTc1pyRzJNZGZZcitWYjYvaTNG?=
 =?utf-8?B?VnF3c3pzU2k1N2RMdktPNEQxc2dXTlhwZ0JRbEhUUm1TRDJTTFEzbWdDSWNR?=
 =?utf-8?Q?7znBHqLCrHMtQbp+Wta67aZm+?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b68a1989-2ab0-44db-97c1-08dc5ada8118
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB7110.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 10:22:49.8145
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OZa6L3IcBdy2H2sRb/VFPyttS9FTdEZndjDxviieWFM9iucrluuK6wCEaiNbpBQAiQXEkiGxhcmrHxnESg7HZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8719
X-OriginatorOrg: intel.com

Hi Ian,

On 4/11/2024 11:14 PM, Ian Rogers wrote:
> On Thu, Apr 11, 2024 at 7:53 AM Yanfei Xu <yanfei.xu@intel.com> wrote:
>>
>> We found that even an events group with slots but without topdown events
>> will still reroder to place the slots first. It's unnecessary, and may
>> break tools expecting the command line order to match the printed order.
>> The issue was previously fixed [1], but was later discarded since [2].
> 
> The requirements for topdown events is a gift that keeps on giving :-( Please:
> 1) provide the tool that is broken,
> 2) provide a reason why the tool is depending on text output that may
> vary over time (intended audience for it is humans) instead of say the
> json output that is intended for consumption by tools,
> 3) provide a test.

We noticed this issue from the regroup WARNNING which didn't trigger in
past regular testing. After digging into the code change I noticed that
there was also a fix for this kind of unnecessary reorder with saying
tools may expecting the original command line order. From my side, I
don't have the tool.
You can refer to the link[1]. Actually it was from you. :)

[1] 
https://lore.kernel.org/lkml/20220321223344.1034479-1-irogers@google.com/#/

> 
>> Add an extra check of evsel leader, variable must_be_in_group, to ensure
>> the slots event is only moved if the group has non-slots topdown events.
>>
>> Without the patch:
>>
>>    $ perf stat  -e '{cpu/cpu-cycles/,slots}'  sleep 1
>>    WARNING: events were regrouped to match PMUs
>>
>>     Performance counter stats for 'sleep 1':
>>
>>             2,663,256      slots:u
>>               443,876      cpu/cpu-cycles/u
>>
>>           1.001079566 seconds time elapsed
>>
>>           0.001054000 seconds user
>>           0.000000000 seconds sys
>>
>> With the patch:
>>
>>    $ perf stat  -e '{cpu/cpu-cycles/,slots}'  sleep 1
>>
>>     Performance counter stats for 'sleep 1':
>>
>>              469,039      cpu/cpu-cycles/u
>>            2,814,234      slots:u
>>
>>          1.001148306 seconds time elapsed
>>
>>          0.001123000 seconds user
>>          0.000000000 seconds sys
>>
>> In cases where both slots and topdown events are present, moving the
>> slots event to be the first event is necessary. However there is no
>> requirement to move the topdown events to be adjacent to slots event.
>> So keep the original order of the topdown events is expected. Further
>> more, if a group doesn't have slots event, the topdown events will be
>> unexpectedly moved to the head of the group.
>>
>> Remove the movements regarding topdown events in arch_evlist__cmp()
>>
>> Without the patch:
>>
>>    $ perf stat -e '{slots,cpu/cpu-cycles/,cpu/topdown-bad-spec/}' sleep 1
>>    WARNING: events were regrouped to match PMUs
>>
>>     Performance counter stats for 'sleep 1':
>>
>>            2,681,460      slots:u
>>              336,496      cpu/topdown-bad-spec/u
>>              446,910      cpu/cpu-cycles/u
>>
>>          1.001210088 seconds time elapsed
>>
>>          0.001160000 seconds user
>>          0.000000000 seconds sys
>>
>> With the patch:
>>
>>    $ perf stat -e '{slots,cpu/cpu-cycles/,cpu/topdown-bad-spec/}' sleep 1
>>
>>     Performance counter stats for 'sleep 1':
>>
>>            2,715,486      slots:u
>>              452,581      cpu/cpu-cycles/u
>>              340,766      cpu/topdown-bad-spec/u
>>
>>          1.001116709 seconds time elapsed
>>
>>          0.001111000 seconds user
>>          0.000000000 seconds sys
>>
>> [1] https://lore.kernel.org/lkml/20220321223344.1034479-1-irogers@google.com/#/
>> [2] https://lore.kernel.org/lkml/20230302041211.852330-10-irogers@google.com/#/
>>
>> Fixes: 347c2f0a0988 ("perf parse-events: Sort and group parsed events")
>> Signed-off-by: Yanfei Xu <yanfei.xu@intel.com>
>> ---
>>   tools/perf/arch/x86/util/evlist.c | 13 +++++--------
>>   tools/perf/arch/x86/util/evsel.c  |  6 ++++++
>>   tools/perf/util/evsel.h           |  2 ++
>>   tools/perf/util/parse-events.c    |  9 ++++++---
>>   4 files changed, 19 insertions(+), 11 deletions(-)
>>
>> diff --git a/tools/perf/arch/x86/util/evlist.c b/tools/perf/arch/x86/util/evlist.c
>> index b1ce0c52d88d..eed0a74c561a 100644
>> --- a/tools/perf/arch/x86/util/evlist.c
>> +++ b/tools/perf/arch/x86/util/evlist.c
>> @@ -75,17 +75,14 @@ int arch_evlist__add_default_attrs(struct evlist *evlist,
>>
>>   int arch_evlist__cmp(const struct evsel *lhs, const struct evsel *rhs)
>>   {
>> +       struct evsel *leader;
>> +
>>          if (topdown_sys_has_perf_metrics() &&
>>              (arch_evsel__must_be_in_group(lhs) || arch_evsel__must_be_in_group(rhs))) {
>> +               leader = evsel__leader(rhs);
> 
> Usually the leader doesn't make sense at this point. For example, a
> metric following event parsing may group
> {cycles,slots,topdown-fe-bound} and cycles will be the leader. The
> leader's properties say nothing about the ordering of slots and
> topdown-fe-bound.

Yes, the leader at this point is temporary. Actually what we want here
is to get a information of the group the event located at to know if
group contains topdown events.

> 
>>                  /* Ensure the topdown slots comes first. */
>> -               if (strcasestr(lhs->name, "slots") && !strcasestr(lhs->name, "uops_retired.slots"))
>> -                       return -1;
>> -               if (strcasestr(rhs->name, "slots") && !strcasestr(rhs->name, "uops_retired.slots"))
>> -                       return 1;
>> -               /* Followed by topdown events. */
>> -               if (strcasestr(lhs->name, "topdown") && !strcasestr(rhs->name, "topdown"))
>> -                       return -1;
>> -               if (!strcasestr(lhs->name, "topdown") && strcasestr(rhs->name, "topdown"))
>> +               if (strcasestr(rhs->name, "slots") && !strcasestr(rhs->name, "uops_retired.slots")
>> +                       && leader->must_be_in_group)
> 
> Why isn't this symmetric? As in the lhs has a test that will return -1.

The full code of this function is as below, the last "return" can keep
the -1 case.

int arch_evlist__cmp(const struct evsel *lhs, const struct evsel *rhs)
{
     struct evsel *leader;

     if (topdown_sys_has_perf_metrics() &&
         (arch_evsel__must_be_in_group(lhs) || 
arch_evsel__must_be_in_group(rhs))) {
         leader = evsel__leader(rhs);
         /* Ensure the topdown slots comes first. */
         if (strcasestr(rhs->name, "slots") && !strcasestr(rhs->name, 
"uops_retired.slots")
             && leader->must_be_in_group)
             return 1;
     }

     /* Default ordering by insertion index. */
     return lhs->core.idx - rhs->core.idx;
}


> 
>>                          return 1;
>>          }
>>
>> diff --git a/tools/perf/arch/x86/util/evsel.c b/tools/perf/arch/x86/util/evsel.c
>> index 090d0f371891..16f42fcfbe0b 100644
>> --- a/tools/perf/arch/x86/util/evsel.c
>> +++ b/tools/perf/arch/x86/util/evsel.c
>> @@ -44,6 +44,12 @@ bool arch_evsel__must_be_in_group(const struct evsel *evsel)
>>              strcasestr(evsel->name, "uops_retired.slots"))
>>                  return false;
>>
>> +       if (strcasestr(evsel->name, "topdown")) {
>> +               struct evsel *leader = evsel__leader(evsel);
>> +
>> +               leader->must_be_in_group = true;
>> +       }
>> +
>>          return strcasestr(evsel->name, "topdown") || strcasestr(evsel->name, "slots");
>>   }
>>
>> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
>> index 517cff431de2..a7ab266bc915 100644
>> --- a/tools/perf/util/evsel.h
>> +++ b/tools/perf/util/evsel.h
>> @@ -98,6 +98,8 @@ struct evsel {
>>                  bool                    bpf_counter;
>>                  bool                    use_config_name;
>>                  bool                    skippable;
>> +               /* any evsels with the flag set must be in a group */
>> +               bool            must_be_in_group;
> 
> This duplicates arch_evsel__must_be_in_group but one may be true when
> the other isn't. This doesn't make sense to me.

Indeed, this name might be not much accurate. The good point is that it
can keep all checks of "topdown" and "slots" being completed in
arch_evsel__must_be_in_group(). How about rename it as
group_has_topdown? or do you have any suggestion?

> 
> I think this patch needs a rethink and the behavior with it looks
> broken and more complex than what already exists. I also think the

I was thinking to check the existence of topdown event in
arch_evlist__cmp(). It could make the fix more consistent. However the
evlist at comparison stage of sorting is broken, not traversable. So the
check is moved in front of sorting list.

> problem is one that is more to do with the tool using the output than
> the reordering.

In my opinion, moving slots when topdown is present is neccesary. But
rerodering in above cases is unneccesary, just for looking more
comfortable? why not users do that by themself if need when inputting,
instead of perf do that only for topdown.

Thanks,
Yanfei

> 
> Thanks,
> Ian
> 
>>                  int                     bpf_fd;
>>                  struct bpf_object       *bpf_obj;
>>                  struct list_head        config_terms;
>> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
>> index 6f8b0fa17689..37950056a661 100644
>> --- a/tools/perf/util/parse-events.c
>> +++ b/tools/perf/util/parse-events.c
>> @@ -2052,9 +2052,12 @@ static int parse_events__sort_events_and_fix_groups(struct list_head *list)
>>                   */
>>                  pos->core.idx = idx++;
>>
>> -               /* Remember an index to sort all forced grouped events together to. */
>> -               if (force_grouped_idx == -1 && pos == pos_leader && pos->core.nr_members < 2 &&
>> -                   arch_evsel__must_be_in_group(pos))
>> +               /*
>> +                * Remember an index to sort all forced grouped events together to,
>> +                * and check each evsel for setting must_be_in_group of its leader.
>> +                */
>> +               if (arch_evsel__must_be_in_group(pos) && force_grouped_idx == -1 &&
>> +                       pos == pos_leader && pos->core.nr_members < 2)
>>                          force_grouped_idx = pos->core.idx;
>>          }
>>
>> --
>> 2.40.1
>>
> 

