Return-Path: <linux-kernel+bounces-157659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E28BB8B1423
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 22:08:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C86B1B29A4D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 20:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA6D313C9CF;
	Wed, 24 Apr 2024 20:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ceoFv3u3"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF46514A85;
	Wed, 24 Apr 2024 20:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713989326; cv=fail; b=V8jdtFRUVTjq0frS8sG8oWQrj/Zh0bzrk2NQBJ0IknLXebPRlIfn9BdTH7XpI3HFMMDr6S4sOZfbno78j2SKp3fSEIJXN28qAs4RyUmQOMmjyGvMSvHFP5oHG9OtPv/D+1RpqLM+mn0nkpP/UjddTtrbJtbp6yXTZZ6nBFQdgmI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713989326; c=relaxed/simple;
	bh=98MdHH9IRyCFSb7SVJZvXxHeDgOh4BOsSCE3K+bGqKA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=As65tGAzQ2eQ5LAFxpPTneyzAyHisrccWtC+rqYr608N5RcAx26f7Bhca0SXoqEcXilKrtdxhEiVpwtlpyiDKIMyNozszNqzsZ1NgEu2YpxBZVJyS9orHv2Ga0btd8S6LYuziTZGOyyWn2+hLnVUm8alnyQi00EFfNJ9to+wbRs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ceoFv3u3; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713989325; x=1745525325;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=98MdHH9IRyCFSb7SVJZvXxHeDgOh4BOsSCE3K+bGqKA=;
  b=ceoFv3u3FzcVOOVtihrq3zOuP/RvZGb2iaW20UTkKNpR7kdFN8nT1JVp
   imE5ftPlukJyx9Ul4BV/P4YIGFmTpG6Pwv0OOeA8L03hKLUy1cVRRPbJI
   svXGaIIvqN8Ylv79Zgk6pK6oivqscfkmWVQG8Aqeyh3fqXwN20XUybvIL
   sDe/YGtio43xHeX1sxBJOoF/UiDuST5O0Y9hWu9xxQ+t0sB/q7PAwBHq1
   qZa5EO5Z0Qu7WuYFE1q7LxKmGS6daAqGoe019BvLVKwuo4P9Y7cB4Nmxu
   Y1vfjCzqCC/eLolOrUlhw8g8948NKILIT7jDgNkYfLMbB2ykmGiy3RujD
   w==;
X-CSE-ConnectionGUID: HqmHvO6MSBi9uM/WAKGqBg==
X-CSE-MsgGUID: 7jQ95t/9SYOi1ZWNjwaDPQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="9766888"
X-IronPort-AV: E=Sophos;i="6.07,227,1708416000"; 
   d="scan'208";a="9766888"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 13:08:44 -0700
X-CSE-ConnectionGUID: AW3cZiZiQxSYJJCLDBWwsg==
X-CSE-MsgGUID: Oe82mnxPSZGa2ONbQTV3mw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,227,1708416000"; 
   d="scan'208";a="29310351"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Apr 2024 13:08:44 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Apr 2024 13:08:43 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Apr 2024 13:08:43 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 24 Apr 2024 13:08:43 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 24 Apr 2024 13:08:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g16RGMzgRpui1vd2qQOxaN8VLPwKQWJQHM2DotYaGOEVQKpwPlkatGlBDo+N0rvmIOPGEJXZqzo0qlhzva+GPvk0+CsdEav0/oebQC+PZDDMs9hc892FT0rT69BnyrUjCGmHv9dODsFEMV2PHyxI3bnfuceo2Cy1XgqSZ5A+nuQs0VJCu8IZQpJqL2QdtfGWGQ0GwcAWgAH7oKc2bHMMWar9LkEA4J2qzxK6wMYHP1JQZDjz2q8F3nGNbp7iBm98VOiha6pPrXGxcgyLgVlNmzm1lcwIYTwujRXqmE9Lri9ZUWHh6I0a7eOQmMP/BI4A2uvf6H0/mYMw4ljyOAZv/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=98MdHH9IRyCFSb7SVJZvXxHeDgOh4BOsSCE3K+bGqKA=;
 b=XsXvQGnX00vTeoV5xNXnk3yxYSe1Z14Fsa7DP84PWvnOjldahmQO8hzpRZINEnYtJvaBDXeGMZQK39+9Sp4RgeDOAxJUh6DASa7+r5XC3APOwWDdaTV0RBOmNuWEZ79tz9vNwkGdc5b1CmLI00Igv/DlT0kX2aI57EOFMreWTDgld4ldctrugRut0OJcBjsn3HUxxSRMKmFjR9VPqDXhf+NN/nI4fvpCUHx56eSpPh7NUZ04m+uX6dE/9s9RvE8z1PX7oTETORW5MrI6cTR/YzIqIiIiktef8b7XenRjxPvZq4ZlQtlyFxOelKZWVqvfL1egBWhZ+8/wBDVYZIOXsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO6PR11MB5635.namprd11.prod.outlook.com (2603:10b6:5:35f::14)
 by MN2PR11MB4549.namprd11.prod.outlook.com (2603:10b6:208:26d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.23; Wed, 24 Apr
 2024 20:08:41 +0000
Received: from CO6PR11MB5635.namprd11.prod.outlook.com
 ([fe80::d3a0:f70a:9340:9a3e]) by CO6PR11MB5635.namprd11.prod.outlook.com
 ([fe80::d3a0:f70a:9340:9a3e%3]) with mapi id 15.20.7519.021; Wed, 24 Apr 2024
 20:08:41 +0000
From: "Wang, Weilin" <weilin.wang@intel.com>
To: Namhyung Kim <namhyung@kernel.org>
CC: Ian Rogers <irogers@google.com>, Arnaldo Carvalho de Melo
	<acme@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar
	<mingo@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, "Hunter, Adrian" <adrian.hunter@intel.com>,
	"Kan Liang" <kan.liang@linux.intel.com>, "linux-perf-users@vger.kernel.org"
	<linux-perf-users@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Taylor, Perry" <perry.taylor@intel.com>,
	"Alt, Samantha" <samantha.alt@intel.com>, "Biggers, Caleb"
	<caleb.biggers@intel.com>
Subject: RE: [RFC PATCH v6 2/5] perf stat: Fork and launch perf record when
 perf stat needs to get retire latency value for a metric.
Thread-Topic: [RFC PATCH v6 2/5] perf stat: Fork and launch perf record when
 perf stat needs to get retire latency value for a metric.
Thread-Index: AQHagg0bJu1HXMAx+EKTfolw5tlMzLFT6nUAgAADChCAIpCggIAAE36ggAAP1wCAAStEAIAAH34AgAAVm9A=
Date: Wed, 24 Apr 2024 20:08:41 +0000
Message-ID: <CO6PR11MB56352FDA2D82D000A575CE16EE102@CO6PR11MB5635.namprd11.prod.outlook.com>
References: <20240329191224.1046866-1-weilin.wang@intel.com>
 <20240329191224.1046866-3-weilin.wang@intel.com>
 <CAM9d7cjBfTM2bjkrvN5XWcXJ=OyBOU06fBN=+eWnDSdP2dkD4A@mail.gmail.com>
 <CO6PR11MB56351C2AB4BE15C5371E29C2EE3F2@CO6PR11MB5635.namprd11.prod.outlook.com>
 <CAM9d7cjORNS9h7v6p2fg8OXsZMpeBODzTSCQNZ5zAea-baFKNQ@mail.gmail.com>
 <CO6PR11MB5635C7D8C91FEDA17EC4BCDEEE112@CO6PR11MB5635.namprd11.prod.outlook.com>
 <CAM9d7chSCQViX=VjgqdVn5un0J5MpGsGDGncUyY-K4=oPvvfQA@mail.gmail.com>
 <CO6PR11MB56359754A01778EA3EA53981EE102@CO6PR11MB5635.namprd11.prod.outlook.com>
 <CAM9d7cj2Zmd_FMBzf=H6K6jRmYLYuR6mpcyhC0_neTvur0=pyw@mail.gmail.com>
In-Reply-To: <CAM9d7cj2Zmd_FMBzf=H6K6jRmYLYuR6mpcyhC0_neTvur0=pyw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR11MB5635:EE_|MN2PR11MB4549:EE_
x-ms-office365-filtering-correlation-id: 22f03509-d1cc-4877-d259-08dc649a562e
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|7416005|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?akIxTElYVWZqb0JTMXBPTTUzN08yenF6MGxjVXdTTEwzWHBRREJKMGwzQVJR?=
 =?utf-8?B?YXRwVFkxblpVQmtOQnFzeDI3Rk9PTTJRUTQrT0s5dUJqNUFvTE1SYllFZVN0?=
 =?utf-8?B?aHRXZ3dlYU1FWUxPZXMyNXF0dFdjMEgwNmxxSEp4d01NdENSR0tGMkxMT1Vi?=
 =?utf-8?B?djFSWHR3bTNuU3UxV0h3YnJhV1VvWXRmZkFJVjRJd0RGaFdLRkxvWUMwcnJT?=
 =?utf-8?B?V1JLcnovdTQzR01hWFVSOTkwSnpmWG14d0JENklOeEdLa3JONkZ0YzY2WVVI?=
 =?utf-8?B?anhaWEJTK09sTXRmc1dCcEZIWk04Y3RiTEx5SGpqYnVxaVpkbnZzMmNJU2t1?=
 =?utf-8?B?M0w5bHdDYmtCSmxQUUtrRFYxbTdBQWpJbkZlRm5LSjFzVWlsWE9qWjJZdTZn?=
 =?utf-8?B?UGppMUoxRDR5QWhMMGRaN1JwQ3hKa2QzcDNEOS9Uc3VvL2l0alRCYm9BTjF4?=
 =?utf-8?B?QTR2aENpc3ZLd1ErQzhIY3JCcldmYTI3dDN6T1JVMFlSZ25oN243QklIcnEr?=
 =?utf-8?B?OTJ1eHlzTnVlMjVoOXBmQ2tyMUVQWHdFWEtadVEyMTk1MFhTSkcvUEdkMjNz?=
 =?utf-8?B?bVBhNy9yQnlsbXJRL3ZVODdHUjhadXRscDhpODJuK01udml3dTM1dEJjY0l3?=
 =?utf-8?B?aU9wVTQ0K2dGdUNsaXY3SGtqZEwwa1lXRzNRZ2xJTEEweFdMRjRIb2tUalVN?=
 =?utf-8?B?Z1B0NkhZMkUwKy9yZXZyVGk5OXVjQjV2blZSeHJpMTkvMzdXSDFwZHJOOFhC?=
 =?utf-8?B?bnhFYmROMG1TYS9HdnorNEJLM01rQXNBZnRTV3M4ZFI2RlNHZ2JyYlRHU3pq?=
 =?utf-8?B?eHRnKzBQeEZqYUlrZG1EaEVpdzNaV29wdC9pU1F4cjluWFA4V0FoT1B2RHBR?=
 =?utf-8?B?Tk8rSDNCRkNsaWhISmxvSWdRbXVSaExwdDBKU04rUUx4SXgyNExGUEJWalZV?=
 =?utf-8?B?cXNidGhKWndMZFJ2QmNWdmR0RGlGcDhCRmlzQ3plTnZOZVFKbjV6OW1NSkZo?=
 =?utf-8?B?RWRQOHp4NVFoRkhWSXpuM1lTUjlFVUh1aVBkeDVIRUw3V0NIWjNPTUZUUDdh?=
 =?utf-8?B?aGdYRGJnL2luUHJQbHZ2VVpkc0FhcXIvNjZ1TllFVEFpR0FwckNOY0tuamhi?=
 =?utf-8?B?VWQ0UmZXbDltTmF1WUJDdWlWWkRRSEUwdGJsT21sMWJPV1JNMnMrZlhXeTdW?=
 =?utf-8?B?bUNaRVRCdnhZR29uejVmVmFtSEEwNFYycEdrWDVydDA5M0d2NE1sMXNQVlNm?=
 =?utf-8?B?SXlINk8zUUxpRkpoZndCb2VUcTRxem40Zm5SMkYrOVg3ZnZhVmpRenhXbmk0?=
 =?utf-8?B?eHN5M2F5cHZmOStDYjhPbEhnU0U1bzZFK3ZIeXFETXFodzhleVQ5b2hUVStT?=
 =?utf-8?B?bG55L3EwUnFseWNid0hySE5HNzd2akN5cjd5Q1lyY094V0FtZjZSTXd1M0RF?=
 =?utf-8?B?NFM3eHg1L0NuOFJWQmZ0NC90S2todU5XdElqR2lDN0QxbTdEVzJiZ3pxbFlZ?=
 =?utf-8?B?ZDZGVVV4QXBJbEJvRGd4M0NVSG10cDFvcUlBQVE2R1VIL3Z2L0dkV2IwS1FR?=
 =?utf-8?B?VjFUNS9WMzJNUVh0c2dCTXhxVjRrTnJHZ3ZuWTFsR2FDdXRRY1VCSkV6ejlk?=
 =?utf-8?B?Vzh6UjVqb0JveW0wSGdBWUI2eU1sTDZOU1dlYllZZ1ZqdGtzNlNUakpxZWZD?=
 =?utf-8?B?TEFGZFZ2Rzd6aTU0Mlp1TFU3NlJSR1BadWFtaWsxSHFqQ3ZLTm1ycHVJZEpP?=
 =?utf-8?B?S2FOWjBJTlhJbWl3MlZZN01rTGd5R3JVWEN2MkdXWVYwVWlFTHB4eUpSVmtG?=
 =?utf-8?B?cjkwY2FVK0ZUb1lYQkhGQT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5635.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ajdRWWJBdnBXeE5VQ0FyYTR5TEFIWXVsY24rS3BsNlpHbk4wRklFQTVkSHRU?=
 =?utf-8?B?RlFRSTVLcVZNUHBqeGpaTnFiSVJwQUoybHdXTm5KYkdsN0w4eGFKZ2I5a2tm?=
 =?utf-8?B?bU5DTnR0NG52Y1VmK0VBeHZJYUJaZjBVdDRtRVhHYXdEWENteDV0THcxbnZK?=
 =?utf-8?B?ODdkN0NDWDdKMUhQK1J0OVFLbzcrR0RqdTdKQVM0SmNkbk1CTVE5TXpJRitX?=
 =?utf-8?B?RWoxWVJtRWd3aytLaGhIU2QrOTZCcUdRb1RHS0N4NTFwVHp2NkFPNVFqM1Zv?=
 =?utf-8?B?QzRtRTZmTGhZN2trVTVhNHB0L3RvZGpxRlR2MHFwVTVtQURMRFRUWDN6M0sz?=
 =?utf-8?B?MHZlbGFLYnZDakg3UkxXblZZNUxoU0ZwaFVjWUlDTGEyYTNvS0lVWFgxNEZp?=
 =?utf-8?B?SnIrRk5MWFUvRnNqbndUQkJBSXkwZDR1MU9NN2NjL2JMMGwwQ2lweEJFWENC?=
 =?utf-8?B?bkM4dW95U2hRUno3cUFFSVhmY1A2STl0NVRjUjljMm0xM3NPKzBmSTVVNlIy?=
 =?utf-8?B?U1F3cDlxMmQvTGRQUm1VQmhMWTZUb1pnTWNUb2U0RUJsZ0VlTG5YNGFXMG1X?=
 =?utf-8?B?SHJYWm1wRnkvWGJITm1qOWlBb1lLOEIrd0RBZmU5c3hBSUFhVXdQcmM1WHZ6?=
 =?utf-8?B?NU1QS2pTSWRPYnVuQ0JyUktGMmRlTkd3QjA1WklqcWk2SmlpYXJnOWYzLzM3?=
 =?utf-8?B?bWRDR24zNHh5c3N4WWtBSk50RWk5V1pMc0pFTFJjTVFtWTVsb0lSTFlLN1RR?=
 =?utf-8?B?S2kyTEZPcnBqWVZRdHVLMXJNR0RnQlF6Rjk5WDRaZWRIUVU4Ung5YWtwUjYx?=
 =?utf-8?B?MkVmaWN5clZFMFlFQW9pdHp6QzJ2SUNqUGFMTDdWOTdNdkx1TEQzVnZpWWUr?=
 =?utf-8?B?NWkyeGQyZDNMZEFuQ0tpRmV4dXhhUCtlYzE4MU5GSERLd3B6dzZLTTh3WEkz?=
 =?utf-8?B?Y0FidEVkZ2RBQUY1cVl4bEkydllyenAxY0cyWHh2TEx4VXJCTzBoUitnbm5R?=
 =?utf-8?B?TGE4dTY3a2kzaGUrL01wbmsxSlFhRzhvNTRFRGxZYUlVMW1sLzZsU2VBeFFz?=
 =?utf-8?B?VWlmOEtsRlhUNFRzMGZJZ3hDRUFQZWExc2xGRXlrMnBWUHhJaFZLd0hyZ3pH?=
 =?utf-8?B?V0Y0Ly9VQkMrdXJVaFdWYXdEVG9XT2hKcU5LZkd2OWJaVVdIY1g5M1E1QjhR?=
 =?utf-8?B?dHFpU3lOblBaN0FKNloyUFh1bEZkOHM2UDRVVFFmNTZsYXRiQWhkN1k2cVBI?=
 =?utf-8?B?UXpndzMxZzJnc3F2aXE2dUhEYXJIUnc1dDl0L1hWYjZpeDNZd3B6Q2NxZy9h?=
 =?utf-8?B?c1FCTUM5OUxEd0ZZdkduUWg2clV6MWVTbnoxTnA2RmZkZjFyWU9yeGxQTzM4?=
 =?utf-8?B?QTdteWNNS2l4SEU0djZ1NG8wS1dJYndnbFhsTkRMZy9GUWpHanVkQTV1QlBJ?=
 =?utf-8?B?aytnNU9LeFhMUU5RcFIvclJlR0V2UDdrakErcEZuWXByQkJ2dDRHTlJjK3Bu?=
 =?utf-8?B?Q2NWTWJTRjBTWnpOa0ZlWlNHZExCU3E2eXJoL3FPRndqbWx0UlcwTlVsYnM1?=
 =?utf-8?B?OHB1NGJYa2lOQUR4RHZwTkluNmtuS2ZuRk1qM1dIR1lQUjFLcXdjcCtmNXZE?=
 =?utf-8?B?WUIxN3RQbEV2ZU5YVCtxMHFURndmeHlvWlhsWW9jTXpBU1dOa053RWdHWmY4?=
 =?utf-8?B?dDIyRm5RTTNNT1FCSVFia3RvNWhndjkyK3dITHQ0SXNVZ0NMbHNFd0FTMGV2?=
 =?utf-8?B?YnpMMHRDbWU4eSt4T2dKUUExd0tNb2RadjJCTUZGdDFickUrSzdnY1NCMmha?=
 =?utf-8?B?bm1jMks1c3gxOFpWTXlyTW5BRm5tbXh1RFlYRlZjWjcwZlIzcEllWkVtRnZD?=
 =?utf-8?B?UW8xSDZiTW1NaDc2MU1hTkNxdzlWUDJiWTN2WTRaTVlTZWFnMUNJcWNPOHQ4?=
 =?utf-8?B?SzZQRzhWaGJOcVpJUUhySjEwUS8wOXE0MkpZT3dtY3NNaDBGelhYMEs0aXRH?=
 =?utf-8?B?ZnlmYmdhUnByU2ZJR1gydnFEUW1rdXp6OFBiaWs3aGZNZnhMODY0elNZbXpQ?=
 =?utf-8?B?ZEoxUDcvMmpROCtVQW12RThjbVU1Nk9YYXVhT1lWbk5ZaERGSE9xd2x2bk42?=
 =?utf-8?Q?UgfklGx1dopx4Wg1qbMQD26WI?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5635.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22f03509-d1cc-4877-d259-08dc649a562e
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2024 20:08:41.3149
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SkvhDvjddi83/pXToMTz3oCkR5LWYmRazAnCZGwU3cqa49E233721cj0lrjaa2Kryqbisq1qvz4cW5Juxdqdsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4549
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTmFtaHl1bmcgS2ltIDxu
YW1oeXVuZ0BrZXJuZWwub3JnPg0KPiBTZW50OiBXZWRuZXNkYXksIEFwcmlsIDI0LCAyMDI0IDEx
OjUwIEFNDQo+IFRvOiBXYW5nLCBXZWlsaW4gPHdlaWxpbi53YW5nQGludGVsLmNvbT4NCj4gQ2M6
IElhbiBSb2dlcnMgPGlyb2dlcnNAZ29vZ2xlLmNvbT47IEFybmFsZG8gQ2FydmFsaG8gZGUgTWVs
bw0KPiA8YWNtZUBrZXJuZWwub3JnPjsgUGV0ZXIgWmlqbHN0cmEgPHBldGVyekBpbmZyYWRlYWQu
b3JnPjsgSW5nbyBNb2xuYXINCj4gPG1pbmdvQHJlZGhhdC5jb20+OyBBbGV4YW5kZXIgU2hpc2hr
aW4NCj4gPGFsZXhhbmRlci5zaGlzaGtpbkBsaW51eC5pbnRlbC5jb20+OyBKaXJpIE9sc2EgPGpv
bHNhQGtlcm5lbC5vcmc+OyBIdW50ZXIsDQo+IEFkcmlhbiA8YWRyaWFuLmh1bnRlckBpbnRlbC5j
b20+OyBLYW4gTGlhbmcgPGthbi5saWFuZ0BsaW51eC5pbnRlbC5jb20+Ow0KPiBsaW51eC1wZXJm
LXVzZXJzQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgVGF5
bG9yLCBQZXJyeQ0KPiA8cGVycnkudGF5bG9yQGludGVsLmNvbT47IEFsdCwgU2FtYW50aGEgPHNh
bWFudGhhLmFsdEBpbnRlbC5jb20+OyBCaWdnZXJzLA0KPiBDYWxlYiA8Y2FsZWIuYmlnZ2Vyc0Bp
bnRlbC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUkZDIFBBVENIIHY2IDIvNV0gcGVyZiBzdGF0OiBG
b3JrIGFuZCBsYXVuY2ggcGVyZiByZWNvcmQgd2hlbg0KPiBwZXJmIHN0YXQgbmVlZHMgdG8gZ2V0
IHJldGlyZSBsYXRlbmN5IHZhbHVlIGZvciBhIG1ldHJpYy4NCj4gDQo+IE9uIFdlZCwgQXByIDI0
LCAyMDI0IGF0IDEwOjA44oCvQU0gV2FuZywgV2VpbGluIDx3ZWlsaW4ud2FuZ0BpbnRlbC5jb20+
DQo+IHdyb3RlOg0KPiA+DQo+ID4NCj4gPg0KPiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCj4gPiA+IEZyb206IE5hbWh5dW5nIEtpbSA8bmFtaHl1bmdAa2VybmVsLm9yZz4NCj4gPiA+
IFNlbnQ6IFR1ZXNkYXksIEFwcmlsIDIzLCAyMDI0IDQ6MDYgUE0NCj4gPiA+IFRvOiBXYW5nLCBX
ZWlsaW4gPHdlaWxpbi53YW5nQGludGVsLmNvbT4NCj4gPiA+IENjOiBJYW4gUm9nZXJzIDxpcm9n
ZXJzQGdvb2dsZS5jb20+OyBBcm5hbGRvIENhcnZhbGhvIGRlIE1lbG8NCj4gPiA+IDxhY21lQGtl
cm5lbC5vcmc+OyBQZXRlciBaaWpsc3RyYSA8cGV0ZXJ6QGluZnJhZGVhZC5vcmc+OyBJbmdvIE1v
bG5hcg0KPiA+ID4gPG1pbmdvQHJlZGhhdC5jb20+OyBBbGV4YW5kZXIgU2hpc2hraW4NCj4gPiA+
IDxhbGV4YW5kZXIuc2hpc2hraW5AbGludXguaW50ZWwuY29tPjsgSmlyaSBPbHNhIDxqb2xzYUBr
ZXJuZWwub3JnPjsgSHVudGVyLA0KPiA+ID4gQWRyaWFuIDxhZHJpYW4uaHVudGVyQGludGVsLmNv
bT47IEthbiBMaWFuZyA8a2FuLmxpYW5nQGxpbnV4LmludGVsLmNvbT47DQo+ID4gPiBsaW51eC1w
ZXJmLXVzZXJzQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsg
VGF5bG9yLA0KPiBQZXJyeQ0KPiA+ID4gPHBlcnJ5LnRheWxvckBpbnRlbC5jb20+OyBBbHQsIFNh
bWFudGhhIDxzYW1hbnRoYS5hbHRAaW50ZWwuY29tPjsNCj4gQmlnZ2VycywNCj4gPiA+IENhbGVi
IDxjYWxlYi5iaWdnZXJzQGludGVsLmNvbT4NCj4gPiA+IFN1YmplY3Q6IFJlOiBbUkZDIFBBVENI
IHY2IDIvNV0gcGVyZiBzdGF0OiBGb3JrIGFuZCBsYXVuY2ggcGVyZiByZWNvcmQNCj4gd2hlbg0K
PiA+ID4gcGVyZiBzdGF0IG5lZWRzIHRvIGdldCByZXRpcmUgbGF0ZW5jeSB2YWx1ZSBmb3IgYSBt
ZXRyaWMuDQo+ID4gPg0KPiA+ID4gT24gVHVlLCBBcHIgMjMsIDIwMjQgYXQgMzoxNuKAr1BNIFdh
bmcsIFdlaWxpbiA8d2VpbGluLndhbmdAaW50ZWwuY29tPg0KPiA+ID4gd3JvdGU6DQo+ID4gPiA+
ID4gPiA+ID4gLXN0YXRpYyBpbnQgX19ydW5fcGVyZl9yZWNvcmQodm9pZCkNCj4gPiA+ID4gPiA+
ID4gPiArc3RhdGljIGludCBfX3J1bl9wZXJmX3JlY29yZChjb25zdCBjaGFyICoqcmVjb3JkX2Fy
Z3YpDQo+ID4gPiA+ID4gPiA+ID4gIHsNCj4gPiA+ID4gPiA+ID4gPiArICAgICAgIGludCBpID0g
MDsNCj4gPiA+ID4gPiA+ID4gPiArICAgICAgIHN0cnVjdCB0cGVic19ldmVudCAqZTsNCj4gPiA+
ID4gPiA+ID4gPiArDQo+ID4gPiA+ID4gPiA+ID4gICAgICAgICBwcl9kZWJ1ZygiUHJlcGFyZSBw
ZXJmIHJlY29yZCBmb3IgcmV0aXJlX2xhdGVuY3lcbiIpOw0KPiA+ID4gPiA+ID4gPiA+ICsNCj4g
PiA+ID4gPiA+ID4gPiArICAgICAgIHJlY29yZF9hcmd2W2krK10gPSAicGVyZiI7DQo+ID4gPiA+
ID4gPiA+ID4gKyAgICAgICByZWNvcmRfYXJndltpKytdID0gInJlY29yZCI7DQo+ID4gPiA+ID4g
PiA+ID4gKyAgICAgICByZWNvcmRfYXJndltpKytdID0gIi1XIjsNCj4gPiA+ID4gPiA+ID4gPiAr
ICAgICAgIHJlY29yZF9hcmd2W2krK10gPSAiLS1zeW50aD1ubyI7DQo+ID4gPiA+ID4gPiA+ID4g
Kw0KPiA+ID4gPiA+ID4gPiA+ICsgICAgICAgaWYgKHN0YXRfY29uZmlnLnVzZXJfcmVxdWVzdGVk
X2NwdV9saXN0KSB7DQo+ID4gPiA+ID4gPiA+ID4gKyAgICAgICAgICAgICAgIHJlY29yZF9hcmd2
W2krK10gPSAiLUMiOw0KPiA+ID4gPiA+ID4gPiA+ICsgICAgICAgICAgICAgICByZWNvcmRfYXJn
dltpKytdID0gc3RhdF9jb25maWcudXNlcl9yZXF1ZXN0ZWRfY3B1X2xpc3Q7DQo+ID4gPiA+ID4g
PiA+ID4gKyAgICAgICB9DQo+ID4gPiA+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ID4gPiA+ICsgICAg
ICAgaWYgKHN0YXRfY29uZmlnLnN5c3RlbV93aWRlKQ0KPiA+ID4gPiA+ID4gPiA+ICsgICAgICAg
ICAgICAgICByZWNvcmRfYXJndltpKytdID0gIi1hIjsNCj4gPiA+ID4gPiA+ID4gPiArDQo+ID4g
PiA+ID4gPiA+ID4gKyAgICAgICBpZiAoIXN0YXRfY29uZmlnLnN5c3RlbV93aWRlDQo+ID4gPiA+
ID4gJiYgIXN0YXRfY29uZmlnLnVzZXJfcmVxdWVzdGVkX2NwdV9saXN0KQ0KPiA+ID4gPiA+ID4g
PiB7DQo+ID4gPiA+ID4gPiA+ID4gKyAgICAgICAgICAgICAgIHByX2VycigiUmVxdWlyZSAtYSBv
ciAtQyBvcHRpb24gdG8gcnVuIHNhbXBsaW5nLlxuIik7DQo+ID4gPiA+ID4gPiA+ID4gKyAgICAg
ICAgICAgICAgIHJldHVybiAtRUNBTkNFTEVEOw0KPiA+ID4gPiA+ID4gPiA+ICsgICAgICAgfQ0K
PiA+ID4gPiA+ID4gPiA+ICsNCj4gPiA+ID4gPiA+ID4gPiArICAgICAgIGxpc3RfZm9yX2VhY2hf
ZW50cnkoZSwgJnN0YXRfY29uZmlnLnRwZWJzX2V2ZW50cywgbmQpIHsNCj4gPiA+ID4gPiA+ID4g
PiArICAgICAgICAgICAgICAgcmVjb3JkX2FyZ3ZbaSsrXSA9ICItZSI7DQo+ID4gPiA+ID4gPiA+
ID4gKyAgICAgICAgICAgICAgIHJlY29yZF9hcmd2W2krK10gPSBlLT5uYW1lOw0KPiA+ID4gPiA+
ID4gPiA+ICsgICAgICAgfQ0KPiA+ID4gPiA+ID4gPiA+ICsNCj4gPiA+ID4gPiA+ID4gPiArICAg
ICAgIHJlY29yZF9hcmd2W2krK10gPSAiLW8iOw0KPiA+ID4gPiA+ID4gPiA+ICsgICAgICAgcmVj
b3JkX2FyZ3ZbaSsrXSA9IFBFUkZfREFUQTsNCj4gPiA+ID4gPiA+ID4gPiArDQo+ID4gPiA+ID4g
PiA+ID4gICAgICAgICByZXR1cm4gMDsNCj4gPiA+ID4gPiA+ID4gPiAgfQ0KPiA+ID4gPiA+ID4g
Pg0KPiA+ID4gPiA+ID4gPiBTdGlsbCBJIHRoaW5rIGl0J3Mgd2VpcmQgaXQgaGFzICdwZXJmIHJl
Y29yZCcgaW4gcGVyZiBzdGF0IChkZXNwaXRlIHRoZQ0KPiA+ID4gPiA+ID4gPiAncGVyZiBzdGF0
IHJlY29yZCcpLiAgSWYgaXQncyBvbmx5IEludGVsIHRoaW5nIGFuZCB3ZSBkb24ndCBoYXZlIGEg
cGxhbg0KPiA+ID4gPiA+ID4gPiB0byBkbyB0aGUgc2FtZSBvbiBvdGhlciBhcmNoZXMsIHdlIGNh
biBtb3ZlIGl0IHRvIHRoZSBhcmNoDQo+ID4gPiA+ID4gPiA+IGRpcmVjdG9yeSBhbmQga2VlcCB0
aGUgcGVyZiBzdGF0IGNvZGUgc2ltcGxlLg0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IEknbSBu
b3Qgc3VyZSB3aGF0IGlzIHRoZSBwcm9wZXIgd2F5IHRvIHNvbHZlIHRoaXMuIEFuZCBJYW4gbWVu
dGlvbmVkDQo+ID4gPiA+ID4gPiB0aGF0IHB1dCBjb2RlIGluIGFyY2ggZGlyZWN0b3J5IGNvdWxk
IHBvdGVudGlhbGx5IGNhdXNlIG90aGVyIGJ1Z3MuDQo+ID4gPiA+ID4gPiBTbyBJJ20gd29uZGVy
aW5nIGlmIHdlIGNvdWxkIGtlZXAgdGhpcyBjb2RlIGhlcmUgZm9yIG5vdy4gSSBjb3VsZA0KPiB3
b3JrDQo+ID4gPiA+ID4gPiBvbiBpdCBsYXRlciBpZiB3ZSBmb3VuZCBpdCdzIGJldHRlciB0byBi
ZSBpbiBhcmNoIGRpcmVjdG9yeS4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IE1heWJlIHNvbWV3aGVy
ZSBpbiB0aGUgdXRpbC8gYW5kIGtlZXAgdGhlIG1haW4gY29kZSBtaW5pbWFsLg0KPiA+ID4gPiA+
IElJVUMgaXQncyBvbmx5IGZvciB2ZXJ5IHJlY2VudCAob3IgdXBjb21pbmc/KSBJbnRlbCBDUFVz
IGFuZCB3ZQ0KPiA+ID4gPiA+IGRvbid0IGhhdmUgdGVzdHMgKGhvcGVmdWxseSBjYW4gcnVuIG9u
IG90aGVyIGFyY2gvQ1BVcykuDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBTbyBJIGRvbid0IHRoaW5r
IGhhdmluZyBpdCBoZXJlIHdvdWxkIGhlbHAgZml4aW5nIHBvdGVudGlhbCBidWdzLg0KPiA+ID4g
Pg0KPiA+ID4gPiBEbyB5b3UgbWVhbiBieSBjcmVhdGluZyBhIG5ldyBmaWxlIGluIHV0aWwvIHRv
IGhvbGQgdGhpcyBjb2RlPw0KPiA+ID4NCj4gPiA+IFllYWgsIG1heWJlIHV0aWwvaW50ZWwtdHBl
YnMuYyAoaWYgaXQncyBiZXR0ZXIgdGhhbiBhcmNoL3g4Ni8uLi4pID8NCj4gPiA+DQo+ID4gPiA+
DQo+ID4gPiA+IFllcywgdGhpcyBmZWF0dXJlIGlzIGZvciB2ZXJ5IHJlY2VudCBJbnRlbCBDUFVz
LiBJdCBzaG91bGQgb25seSBiZSB0cmlnZ2VyZWQgaWYNCj4gPiA+ID4gYSBtZXRyaWMgdXNlcyBl
dmVudChzKSB0aGF0IGhhcyB0aGUgUiBtb2RpZmllciBpbiB0aGUgZm9ybXVsYS4NCj4gPiA+DQo+
ID4gPiBDYW4gd2UgaGF2ZSBhIHRlc3Qgd2l0aCBhIGZha2UgbWV0cmljIHNvIHRoYXQgd2UgY2Fu
IHRlc3QNCj4gPiA+IHRoZSBjb2RlIG9uIG5vbi0ob3Igb2xkLSlJbnRlbCBtYWNoaW5lcz8NCj4g
Pg0KPiA+IEFsbCB0aGUgZXhpc3RpbmcgbWV0cmljcyBpbiBub24tKG9yIG9sZC0pSW50ZWwgQ1BV
cyBzaG91bGQgd29yayBhcyB1c3VhbC4gU28gSQ0KPiB0aGluaw0KPiA+IGV4aXN0aW5nIG1ldHJp
YyB0ZXN0cyBzaG91bGQgd29yayBmb3IgaXQuDQo+ID4NCj4gPiBJZiB3ZSB3YW50IHRvIGFkZCBh
IGZha2UgbWV0cmljIHVzZXMgdGhlIDpSIG1vZGlmaWVyIGZvciB0aG9zZSBwbGF0Zm9ybXMsIHRo
ZQ0KPiBtZXRyaWMNCj4gPiBzaG91bGQgZWl0aGVyIGZhaWwgKGlmIHRoZSBmYWtlIG1ldHJpYyB1
c2VzIGFuIGV2ZW50IG5vdCBleGlzdCBvbiB0aGUgdGVzdA0KPiBwbGF0Zm9ybSkgb3INCj4gPiBy
ZXR1cm4gYWxsIDAgcmV0aXJlIGxhdGVuY3kgZGF0YS4NCj4gPg0KPiA+IFNvLCBJJ20gbm90IHF1
aXRlIHN1cmUgd2hhdCB3ZSB3YW50IHRoZSBmYWtlIG1ldHJpYyB0byB0ZXN0IGZvci4gTWF5YmUg
d2UNCj4gY291bGQNCj4gPiBjb250aW51ZSB1c2luZyBleGlzdGluZyBtZXRyaWMgdGVzdHMgdG8g
ZW5zdXJlIGFsbCB0aGUgZGVmaW5lZCBtZXRyaWNzIHdvcmsNCj4gY29ycmVjdGx5DQo+ID4gaW4g
ZWFjaCBtYWNoaW5lIHVuZGVyIHRlc3Q/DQo+IA0KPiBJIHRoaW5rIGl0J3Mgb2sgdG8gcmV0dXJu
IGFsbCAwIHJldGlyZSBsYXRlbmN5IGZvciBmYWtlIHRQRUJTIG1ldHJpY3MuDQo+IEl0J3MganVz
dCB0byB2ZXJpZnkgdGhlIGJhY2tncm91bmQgcmVjb3JkICsgcmVwb3J0IGxvZ2ljIHdvcmtzIG9r
Lg0KDQpPaywgSSB3aWxsIHdvcmsgb24gdGhpcy4gV2UgbmVlZCBhIGZha2UgbWV0cmljIHRoYXQg
dXNlcyBldmVudHMgZXhpc3Qgb24gYWxsIHRoZSANCnBsYXRmb3Jtcy4gDQoNClRoYW5rcywNCldl
aWxpbg0KDQo+IA0KPiBUaGFua3MsDQo+IE5hbWh5dW5nDQo=

