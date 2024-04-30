Return-Path: <linux-kernel+bounces-163336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C2BE8B6999
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 06:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 334F4283863
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 04:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26D72134CE;
	Tue, 30 Apr 2024 04:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VGTADb+W"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4F68BF0;
	Tue, 30 Apr 2024 04:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714452623; cv=fail; b=qb3goUsaupFhrTrfRmbnLXDrlP6lcRMMNzHTkTt0kvKxwdLzRNeopz7d6GqhbJJ5Nur+d7zupusBDGYWi67qQQHDj/NV+q10KkVFWiIC9Qo+EmQU6kS4YGWkwrh+i0bjjCXsmPlURsn5dnr7MSvLotGXW89Dkp7Qxqjr/5/mqUw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714452623; c=relaxed/simple;
	bh=BLV0cQltq5aj9QLbGc+CMGHYIcteEb363JoXIjK7ygE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BM8VtLc3HfrS1qVHVheZrjX2jZCJULyCKQBn+B7KX9OKn3ne1pT9REgZkaCuxSPpHzUwv1xg5cscEtjU6/GZnDgMUyefLUL5x33OaB7Czh9nYpFXvKYGWKfiFcvkoV4H2YSUG3bmi2DSyzKPKbWrhYq4U+NYMmt+kaRqjVTjseg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VGTADb+W; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714452621; x=1745988621;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=BLV0cQltq5aj9QLbGc+CMGHYIcteEb363JoXIjK7ygE=;
  b=VGTADb+WsSGRO7Ia4ILZlhboTGdW5+XvVm3SPECbDnxlHn/4nCDkVOzT
   rNaSfIf7dhl4v2fjP6D72Vk8janXkhAAf5t+np6DOI9Wy6K/LE4fHwI5K
   5oFg9AWz78WtWvy84VdmPLDCGebo78K1yEMU+mkf+LwKmkuCRXuWRbYDv
   X0VYrMNK0zMC0esz2tzp2V19aNH4fI4LtGekGJK3UeItQBtK7oJW0ZLoI
   TIWRzvclqAduVcS+mOfGrXOZppSYEybaE02kXw8Nbyor1QYz2hXLz9nHt
   IKYUgpTcLwVFRNIBnxQe1XJRybDPLtRmLgGJb1cw8+nHeUk+XEbAHTc6b
   w==;
X-CSE-ConnectionGUID: HGC06Vd9TPysa7XJA50kCg==
X-CSE-MsgGUID: sYI35zK8QzqmSY3jCGNGQw==
X-IronPort-AV: E=McAfee;i="6600,9927,11059"; a="21556221"
X-IronPort-AV: E=Sophos;i="6.07,241,1708416000"; 
   d="scan'208";a="21556221"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 21:50:20 -0700
X-CSE-ConnectionGUID: quG/QvI1SG+bd8htN1IvKA==
X-CSE-MsgGUID: jYaF1M/pQqKT9Fw8xLtE0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,241,1708416000"; 
   d="scan'208";a="30785152"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Apr 2024 21:50:20 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Apr 2024 21:50:20 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 29 Apr 2024 21:50:20 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 29 Apr 2024 21:50:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PhSyTr3C5omXCT47W/pLwTkWlYOpLyWyw5o2RlR5F1/9LIX3biawV6zwcrkCPSXzus7nJlxcDMPuXDb/HN8srKGYx0L8YadfIUJZncM8NZedNTd1xiMJmvBALPEcrWWdViH4oV3X9Qb2XHzLMRMJPPG0tRMIXgjRKmG/sFWi4Q6rSMK/0IG8aJvdNL4rzt7rF+gUmRnocf9+y8dVhxRGBnivqZAcm3HMjNavbOCzZhRDyYCsvrSKkIJobOxD/ig/8uMQbudmAs0nM7DTSgi3dFPt8yxgo3XuiVflXP7jJDEnIODvreNeR5iUQZjR8MeN5Tykc1apa+nizGu9Pycm2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BLV0cQltq5aj9QLbGc+CMGHYIcteEb363JoXIjK7ygE=;
 b=lHFO/BDgdKDutxyWqImBi/Hk7SPtzzW7Bo0tvHgbOW26+n0H83PAlBCBR+WTLlGQg3+S/TIuLWbscuyIhI9Rue4AqEsyKbpHNXqD9hiRDKjX7/EoTzaYRKoXf+UDxNbgjlYzGwM95wT0lvfoYsA2hjmzagRB0cuvFOJDmosCsGbWP1wHFDr1VGRE1YiKjwvFTtTPRnEA56TElOBVLimmtJZ6spTpd0vvKtsss+VqYHWnBCA44r1yTtCiYgnK4WwsPt542F9ESZ7d9Yyw3avbU6u4p3VNAJ++w671u7EuCUytJpMIJdR7d0cAfPmdX//cEW+SS3bLlUNtd7woiVB8PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by MW4PR11MB7008.namprd11.prod.outlook.com (2603:10b6:303:227::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.24; Tue, 30 Apr
 2024 04:50:18 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::d5d6:c0cc:baae:1ba6]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::d5d6:c0cc:baae:1ba6%4]) with mapi id 15.20.7519.031; Tue, 30 Apr 2024
 04:50:18 +0000
From: "Zhang, Rui" <rui.zhang@intel.com>
To: "ricardo.neri-calderon@linux.intel.com"
	<ricardo.neri-calderon@linux.intel.com>, "Wysocki, Rafael J"
	<rafael.j.wysocki@intel.com>
CC: "srinivas.pandruvada@linux.intel.com"
	<srinivas.pandruvada@linux.intel.com>, "Brown, Len" <len.brown@intel.com>,
	"stanislaw.gruszka@linux.intel.com" <stanislaw.gruszka@linux.intel.com>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Neri,
 Ricardo" <ricardo.neri@intel.com>
Subject: Re: [PATCH 1/4] thermal: intel: hfi: Rename HFI_UPDATE_INTERVAL
Thread-Topic: [PATCH 1/4] thermal: intel: hfi: Rename HFI_UPDATE_INTERVAL
Thread-Index: AQHamo3lE+a0LwbfYEqI7eXe78wf4LGAPqWA
Date: Tue, 30 Apr 2024 04:50:18 +0000
Message-ID: <ac4ac4d8e1e7a5bd44b22bb27af3bffc3080d752.camel@intel.com>
References: <20240429234152.16230-1-ricardo.neri-calderon@linux.intel.com>
	 <20240429234152.16230-2-ricardo.neri-calderon@linux.intel.com>
In-Reply-To: <20240429234152.16230-2-ricardo.neri-calderon@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|MW4PR11MB7008:EE_
x-ms-office365-filtering-correlation-id: cc62ca78-9948-43be-719e-08dc68d108aa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?T0lhYnZXcWxGdWd0d3ZXd2g4K25KWWt2WUcxMTBsejlwUlVsbnRuOXNLaTZZ?=
 =?utf-8?B?VDladXNOaTRTUWNSNFh5WFdwVVFXMmhZYmZRQ1h6SCtRcUVidUpzeVdQSWZo?=
 =?utf-8?B?TWZjSVc4SmdBOUdtUjFSczFqVFJHVytKRzF6Y3ZRWGsrTGx6OGJla1I2aGYw?=
 =?utf-8?B?MXM2UmxMVWhqdkFLeDRzY1V4Qmx3TkdzcUgrSDlwZWZVNTFWUldSeFlHdWdH?=
 =?utf-8?B?c1hydWZ6Tno4SFJPQlB0cnFJeThySUFYWW54Y3VvM0puNXJVaWNUbTNSL3Bi?=
 =?utf-8?B?cmdrSTdyV09PbWFteXdkMU1Ha0l2WGU4cVJXejRBQkVvRDZ5clBQbjRZQXBD?=
 =?utf-8?B?Y3VFNDJ5REhqdzEzTkd5ck5nWUtEK1I2bk5xdnBjM2o0RjgrR2lxSVJOWXZI?=
 =?utf-8?B?SDUxUTROb29DUWdEeVpnVFRKS1A2b2twZEpNVDFHVnZxMDE1NWJqTXRxdEZK?=
 =?utf-8?B?eTYwclhCdnhyNWhQMVVNMHZnbkdlUnNyUE9WM0Y0ZnFmTy9WTnMvYzQwY0tx?=
 =?utf-8?B?WmF3b1VYM2wrL2c1RlJUK0p4ZUNGNHd4VkJzTWlROGVVWFRTYXlOZ0lyMWxI?=
 =?utf-8?B?SDh0WlkxSjlXdmh3YUREc0dxR1JGcm5PR3RRc012TzJCeWd3YlI0S2ZNWDVR?=
 =?utf-8?B?Mis1QXRPcU9GSk1RTnpUZDRLTGF2NlAyT0tjdWQrMUsyS1k2VHVJZFBJTWFp?=
 =?utf-8?B?WlpkbHRLckFvUnBaY0JqK3hRK1VCS1BlTURhQ0RyYzB4emxnYzVUdzRFbVZl?=
 =?utf-8?B?UDZ3RnV5cHVqdlZRRWxQcUNrbUZHQUpZTXlLT2RWMDRzb1FoaFMvU3diK1Nu?=
 =?utf-8?B?LzFxdERNNGRpQ1V1ajRHbHU0eUk3RFYyS2pGZk5kSFFwZFprQW9Wb29YUnNs?=
 =?utf-8?B?WTZDbjkyVXlBOFVPeEM1Q29USllRZTd2c2RhT2svWUZwT2RyN1F3WkRPSDJr?=
 =?utf-8?B?cHlDU2ZweHVETWNUZWFsbmlGaXNZSjFucjRveE5mWFlxdFhnMEFDajZoSmln?=
 =?utf-8?B?aS9pQVYzRE5ZVHdZRlBEdU1ER1lMSUVNOXlmVTI1NGF5NVlWeHd6VmhudC9y?=
 =?utf-8?B?aDRENVE3elJuK0g3cXYzZStqT3ZnaFRsYnJ5UUQ5TUlEMk5MTTM2U2wxeUZ0?=
 =?utf-8?B?K3JscGZCejNRZUJPVllRdXE3NVZJTkVQTFBJT29qZ2ZBOGZSaGJPSG8zTEhS?=
 =?utf-8?B?YmVrK2tEbXRBMDQ4NEY4dkRUSFNPTW9KZ28zWFFQekxDV1ZwdlVTeE96M042?=
 =?utf-8?B?NWlueWVuMVVFMWovcy93VE9IZXNBbEFHc0QwK3g5SnlmeXZHdjZGVzRqK0hP?=
 =?utf-8?B?SklldncvclBhWHdob0pBR0FLMHFrUnd4YXNsRTFOellyWHpHZk9JNUFvZ3NU?=
 =?utf-8?B?S1ZHRWFLYW8wYUFBdkc1YUQrQ2VRa2t2OURoMTkrai90R0pUd1FpeVVPeUZs?=
 =?utf-8?B?Si9uQWdHREZjSnRjTVRtSG40SzRxR3RjM2xFZ3p4Yis2VHl2SUU2YTJBTWdF?=
 =?utf-8?B?RE1VMWlIRU0vWDFFOWt0RVNBamFQZVplQjMrVEVnTE9nZHNraUtGMUxCcVZn?=
 =?utf-8?B?WE8yVlVUVmdyclNHeXN0VW1IRSt4Y2hPSHd1NnpWdVVoQ0RQRVhtalZKV0Rh?=
 =?utf-8?B?NmM0SCtFSTJwWjEyMWlsMmIzd2RSbFl3K2I5em15a3Zvc1F0NjUxSlh4Njd1?=
 =?utf-8?B?bk9aZEZRWnZpSHk5NUdSdWRwaCtzNmFDbE9GRFc3OEk4bTFEcXJITVRrMkdS?=
 =?utf-8?B?Q1Z1T09GdFRVdlR0a3NFeitTendvcFlSaGVXSTRSdkFQcmExNllEaWNVSTdK?=
 =?utf-8?B?UUFqU2hsTmlEc3NZb01OZz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R2Rib08yT096U3RweldORnpscVArRkNIOHlibUxHNGllQXV6RzU2c1lMOVJZ?=
 =?utf-8?B?OTRaNFQ0M003U3BvV01GeUxOdktjL0pWd054S2ZFRmovcEJMODM2L21JK0Z4?=
 =?utf-8?B?RE5NNlVzU3lNREErQ2VJSHZSaW9paUtKZzBBNzJ6NmFEa3NXdjRQS0phRmhz?=
 =?utf-8?B?OEhaZUFteEtObUs2WkJxaGs3VDNDN0FwVTNROHd0MWIvRkMrbnpBNDRGeTdi?=
 =?utf-8?B?NDdYNDhoY3JOTTdoMDNqcVlFUFBYaG03QlhqcG9YNldQSWhSSTZ6TjdZaXJK?=
 =?utf-8?B?M2xXd1JaZ0JaV05jU2JyL2NEOGFiOU1KUlpjbEg2amJoN285SER1UlZLejBm?=
 =?utf-8?B?VTlZYkE3Y2hWUzQ0eEl6eW91TXFOb29JY0pMVkVjWmdTYlJBMExWN3ZDUDMw?=
 =?utf-8?B?eGt1TW5tVUtXL3BhelI5YUVlbWNGbndhRzNtOHNzZjZtcmFGSGVvOW9MRTRG?=
 =?utf-8?B?Z2VtR2VQNTUyMnpuSUdkSXFrYjVobC9ybmZ6K081OG9vZ1g2czBPUzdBNGRS?=
 =?utf-8?B?aXJHM04vK2FHNzFJV1VtcXJ4SlpCUFQwRUlMdHV0QVJ6QzNWNTFMQkp3d3RH?=
 =?utf-8?B?RzFqVkRpbTdpQ0JuWER0a3NrSDF6cVFKMlkxQ0pYYmhJQlhjZnF1MzJxU21X?=
 =?utf-8?B?aWY0Y1Rvbi81aG9aZmxmRG9SOGpub2ZIenVRR0g5ZGVZSnZwM28rbXpINkJs?=
 =?utf-8?B?Q3lPNlFiWlNNSE45bVVuWnlhc0U3QUJWKzNyWmk4MDVZNTliUGJFazRlSysz?=
 =?utf-8?B?Yyt3TWJCVUtiZUZ0bllqdkJOUkl0d0YvdnR6RVFZZDI4S1ppZ1Buc3VTZVFs?=
 =?utf-8?B?STk1MnF4TUlITTIvMFZKN0daa2ZPUmtPWWh0RlBpUXJsbnNTWGg4THEwU2tw?=
 =?utf-8?B?dStkWHZySklnUGZENUFIQU1uc1d4eFVKbG11RERSMEJBVEtudjhzUUlSZWVH?=
 =?utf-8?B?d2xiOXMzWkg1b01KV1BzTms2UHFvZkh2c1BJUmluaXU1KzJLRUVmTzNVbVZQ?=
 =?utf-8?B?T0dqeTdHUjB5UndmcEZZODdXMGhWV3psVHBmWDBlbTk0aHBpWXdVOW0vQi9I?=
 =?utf-8?B?MFpCKzI3eGdCZldQa2txNWpmWnNhbkF6UUVRdlIreXBXQS9RZURiUk03dkNS?=
 =?utf-8?B?QzVJQnZWcmFpVFIrZk1wZlBEZDNlQ2hMSGR5d3lwekdqb2gvWXNJQTR5TXoy?=
 =?utf-8?B?bXcySktEVmMvSW5sRE1nYzBnNXplRlUvNmhBR0pjUXhtV0NBMlh0RXZVR2hC?=
 =?utf-8?B?NW1JTnFMeFZIRXVxZnk1YXd0MTlwUFVyWDZ1Q3QzWUI0ck1zamVvaWZXL0kv?=
 =?utf-8?B?bUVaQ280OTBueUNnTC9DUURWMk9EY3Q0d0I5VlFtbThBNFBhUDBOelpJZEwr?=
 =?utf-8?B?Q1prVVRhMkdlQnIybUQ5bkFmV20waFVoMlNLcTVuWDJJZW9aT2lQcU9jbFNW?=
 =?utf-8?B?ZGU5OU40WWN3ZUd1WnNRRzlmWGRTU1E0a2paU0tWeVRnYVBibUtzK2lURXpC?=
 =?utf-8?B?ZFphTWdIUHRoQVB2Q3Npc3E3M1p3dlBiTTRPVll2a1VGYVFMNHRhaVcxcG1I?=
 =?utf-8?B?OERhSFFWZGxsL2FZN2ZweUx4d1BtWHJOdFFwRjdGWkNnWWI1K1VvdDB3dWdC?=
 =?utf-8?B?R1dVYmlKRlNEVnBEMC93KzZlYUpjUjRVVlNUejFSZFUwQVQvMVVoTnh4THNQ?=
 =?utf-8?B?aWlrYXcvcU9UOXNLMXJpSTFWdHo3ZnZ5eDgyNkl0UVhHcjRDSXRCVWhkQ3Jh?=
 =?utf-8?B?RzF5aWtSQXpyblgwMXJoMi96TVVxWFZINzRsZ3BGaWIvZjJSTmpzcFhURTFT?=
 =?utf-8?B?ZWh4U1FPSk5qM1pvQXJwWW5BRnpCVlBCMjg0NlE2UStRVDg1RnFNdlRmeFZq?=
 =?utf-8?B?NzVOWmxNelRXN1JSS21zVnZtemMxcnBidDdGSDZyMStsUDhtMDRQTk84cFp6?=
 =?utf-8?B?S0lmTTY1ZHNrbmdRN2d0VjhLZ2lUTk52emJSK3lFL2daWWZGTnBrTUF5Tmlx?=
 =?utf-8?B?U25oSVdHaDBiUE9mT0E2UDhpTS9qeVNGQXN6cTJCMXA5bEw3NENOV1FrSWpm?=
 =?utf-8?B?WlZFSkc5Rkd2RkRFM3FhclFmK3Q3ZGVMQTVFL3AzYVR6RzVIRi9FMXdSdFM5?=
 =?utf-8?B?MVRwWTV3UGNtM3NweGFaYWRtYVQ4TzRHQk1zL3B1RXRIQjJjelFjaFRaT2tw?=
 =?utf-8?B?cEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9B10AEDD4FE1684ABF6997E50A85EA95@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc62ca78-9948-43be-719e-08dc68d108aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2024 04:50:18.2231
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VuPBOD0rake555p35bAWJgxNDwCZezta5orKiAInaz21r6m33sAksIDFRMlnJUNI95Q952AvRmoDeh2MveMLtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7008
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI0LTA0LTI5IGF0IDE2OjQxIC0wNzAwLCBSaWNhcmRvIE5lcmkgd3JvdGU6DQo+
IFRoZSBuYW1lIG9mIHRoZSBjb25zdGFudCBIRklfVVBEQVRFX0lOVEVSVkFMIGlzIG1pc2xlYWRp
bmcuIEl0IGlzIG5vdA0KPiBhDQo+IHBlcmlvZGljIGludGVydmFsIGF0IHdoaWNoIEhGSSB1cGRh
dGVzIGFyZSBwcm9jZXNzZWQuIEl0IGlzIHRoZSBkZWxheQ0KPiBpbg0KPiB0aGUgcHJvY2Vzc2lu
ZyBvZiBhbiBIRkkgdXBkYXRlIGFmdGVyIHRoZSBhcnJpdmFsIG9mIGFuIEhGSQ0KPiBpbnRlcnJ1
cHQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBSaWNhcmRvIE5lcmkgPHJpY2FyZG8ubmVyaS1jYWxk
ZXJvbkBsaW51eC5pbnRlbC5jb20+DQoNCkFja2VkLWJ5OiBaaGFuZyBSdWkgPHJ1aS56aGFuZ0Bp
bnRlbC5jb20+DQoNCi1ydWkNCj4gLS0tDQo+IENjOiBMZW4gQnJvd24gPGxlbi5icm93bkBpbnRl
bC5jb20+DQo+IENjOiBTcmluaXZhcyBQYW5kcnV2YWRhIDxzcmluaXZhcy5wYW5kcnV2YWRhQGxp
bnV4LmludGVsLmNvbT4NCj4gQ2M6IFN0YW5pc2xhdyBHcnVzemthIDxzdGFuaXNsYXcuZ3J1c3pr
YUBsaW51eC5pbnRlbC5jb20+DQo+IENjOiBaaGFuZyBSdWkgPHJ1aS56aGFuZ0BpbnRlbC5jb20+
DQo+IENjOiBsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IGxpbnV4LWtlcm5lbEB2Z2Vy
Lmtlcm5lbC5vcmcNCj4gLS0tDQo+IMKgZHJpdmVycy90aGVybWFsL2ludGVsL2ludGVsX2hmaS5j
IHwgNCArKy0tDQo+IMKgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlv
bnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3RoZXJtYWwvaW50ZWwvaW50ZWxfaGZp
LmMNCj4gYi9kcml2ZXJzL3RoZXJtYWwvaW50ZWwvaW50ZWxfaGZpLmMNCj4gaW5kZXggZmJjN2Yw
Y2Q4M2Q3Li5lMmI4MmQ3MWFiNmIgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdGhlcm1hbC9pbnRl
bC9pbnRlbF9oZmkuYw0KPiArKysgYi9kcml2ZXJzL3RoZXJtYWwvaW50ZWwvaW50ZWxfaGZpLmMN
Cj4gQEAgLTE2Niw3ICsxNjYsNyBAQCBzdGF0aWMgc3RydWN0IGhmaV9mZWF0dXJlcyBoZmlfZmVh
dHVyZXM7DQo+IMKgc3RhdGljIERFRklORV9NVVRFWChoZmlfaW5zdGFuY2VfbG9jayk7DQo+IMKg
DQo+IMKgc3RhdGljIHN0cnVjdCB3b3JrcXVldWVfc3RydWN0ICpoZmlfdXBkYXRlc193cTsNCj4g
LSNkZWZpbmUgSEZJX1VQREFURV9JTlRFUlZBTMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoEhaDQo+
ICsjZGVmaW5lIEhGSV9VUERBVEVfREVMQVnCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBI
Wg0KPiDCoCNkZWZpbmUgSEZJX01BWF9USEVSTV9OT1RJRllfQ09VTlTCoMKgwqDCoMKgMTYNCj4g
wqANCj4gwqBzdGF0aWMgdm9pZCBnZXRfaGZpX2NhcHMoc3RydWN0IGhmaV9pbnN0YW5jZSAqaGZp
X2luc3RhbmNlLA0KPiBAQCAtMzIyLDcgKzMyMiw3IEBAIHZvaWQgaW50ZWxfaGZpX3Byb2Nlc3Nf
ZXZlbnQoX191NjQNCj4gcGtnX3RoZXJtX3N0YXR1c19tc3JfdmFsKQ0KPiDCoMKgwqDCoMKgwqDC
oMKgcmF3X3NwaW5fdW5sb2NrKCZoZmlfaW5zdGFuY2UtPmV2ZW50X2xvY2spOw0KPiDCoA0KPiDC
oMKgwqDCoMKgwqDCoMKgcXVldWVfZGVsYXllZF93b3JrKGhmaV91cGRhdGVzX3dxLCAmaGZpX2lu
c3RhbmNlLQ0KPiA+dXBkYXRlX3dvcmssDQo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBIRklfVVBEQVRFX0lOVEVSVkFMKTsNCj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEhGSV9VUERBVEVfREVM
QVkpOw0KPiDCoH0NCj4gwqANCj4gwqBzdGF0aWMgdm9pZCBpbml0X2hmaV9jcHVfaW5kZXgoc3Ry
dWN0IGhmaV9jcHVfaW5mbyAqaW5mbykNCg0K

