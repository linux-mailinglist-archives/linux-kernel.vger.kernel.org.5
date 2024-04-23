Return-Path: <linux-kernel+bounces-155606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79AB48AF4BB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 18:58:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35C12B25B74
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 16:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 579DC13D893;
	Tue, 23 Apr 2024 16:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iAZ6XmAZ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7BDA208A9;
	Tue, 23 Apr 2024 16:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713891503; cv=fail; b=OmQb6x+zt7RtWcGtLhBvkNdS/ck641bLz2U4CCtXCYccI2JVJppwcR9w5jUrmQe5yhQ1YM3oaF4Yw0BCUTSRj2/u2TOrp39jgNdN+LVq+CaQbO0fXMSnPAfZTRfIaD81l5S7515G3muki+5SRIjlGz5y5AcVQiMQME+URJ5jG48=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713891503; c=relaxed/simple;
	bh=jVoQtLMncVzcZ0PD0aIwZG1of4xKAT2LBdPN0iacqog=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=umhjZoopihCyoG7XnpHptI4Mq8MB3jqphRQ1b32aMocY/5033LHM9SQa0JFXn8aRX0e9jNDXDCg6MBuPGQ/nnURUrGs1zAymSrvTOs0O4+sYopPdkrqFQzD4sCmPSN/Qt6DKbmXNEfyjb4dfvO8fhT2BD/w2z1S5FCRqrAse9iI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iAZ6XmAZ; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713891501; x=1745427501;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jVoQtLMncVzcZ0PD0aIwZG1of4xKAT2LBdPN0iacqog=;
  b=iAZ6XmAZV8A8kvHBE5xylb73xlVv6Muf5cshUdJM64V6Cxbfpo0EnMC7
   e4vcqPcNdT7eGNfVGVL0CXAfKI/zlLuZ0fkf63e/TUOjPupazQjqpEzxU
   NmWldIjarX3f7CuvHGhWTQL1wHQcJHEtq70ix+8WdpjFdpGd83caWrBXc
   cbzJGWt2q1C0TsT3nqmpRdkhp6Ist0hXgKM5dgHUAvepFe83Gu2k4SAax
   +bGLsGnKawaWUIGx92Whk2R7IXFxcD4PM4KMw+LmTGCvh/Y8qX+movtuj
   w3PMptspWJB0tj3MmliFrZc0WndlcAGyzYSw5znYCtM9CMHYz950MeDg5
   w==;
X-CSE-ConnectionGUID: FGEUqVWKSAiKDuGlpsPUXg==
X-CSE-MsgGUID: 5hA+FPf+SxuWeLKg8mvjZA==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="20908444"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="20908444"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 09:58:20 -0700
X-CSE-ConnectionGUID: WeBV4f34Qo6Z59Y0UBSaVw==
X-CSE-MsgGUID: r0WaOc65TJ+vphpc86Z3lQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="25038994"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Apr 2024 09:58:21 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 23 Apr 2024 09:58:19 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 23 Apr 2024 09:58:19 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 23 Apr 2024 09:58:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JYbW3CxmZ6Am52i6M7nlSu25it3yfnsrWkA6tY8DAPUVwxpz3KpDUnv4IHe0iFTRnB03H2ZYC8xZ7H3dhCFhN/0YA/C9pKgj/00RlmHx098R/PAhvUCPghXaGDxw0NbgSMa/eJ8t1CrL4lC94hQXBZkgSI2nUBmom4O80TiepkTBFYNhf2xhkbenxDR03mSJYaxmBv+JgiMOPyXP0wPAG1WUWDclJ/wUmL2cccWmdBsNXJwy4haIBwpRpughEMOGHcRmCCxw/UcsFrMaqTLrtM5nKKwfZ6tEc5N77h4RyP582nrjkpSuFW58413xaTv5j+RQhLoD796GUy9xQ3GIhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jVoQtLMncVzcZ0PD0aIwZG1of4xKAT2LBdPN0iacqog=;
 b=W/IhhbimEus+ROE/Bi5ToGW0ABSToTKw6ijGL5Hs1CHQKlonLokRBPAO8ahnj6jeiJ0Muc+ByhHn0eE0DuNpNNrgejfu6mBz9uslnwm4iHQ9kZE1oXl1T4Bxfe6YkKnM8pNNhvziweR3V9sqAt4UxiLtzlO3m+gv/ZyPJ7UOSabGUoNbyKa91MJpy92BuZZNnFeRZ3lBK9NZ+xhczQYqYFvxlRpvUz5lARR+haJjXKRIy0JAZdtGe7+/FPxKhyaRd5Hs51pzN+13JN140RpGnGHQYn+2uV/RTXvLWhIdw0GJsVdmsxL41AtDy6SRIiQqorVlIoq1aoqGCn5MuI4FqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO6PR11MB5635.namprd11.prod.outlook.com (2603:10b6:5:35f::14)
 by DS0PR11MB6496.namprd11.prod.outlook.com (2603:10b6:8:c0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.21; Tue, 23 Apr
 2024 16:58:16 +0000
Received: from CO6PR11MB5635.namprd11.prod.outlook.com
 ([fe80::d3a0:f70a:9340:9a3e]) by CO6PR11MB5635.namprd11.prod.outlook.com
 ([fe80::d3a0:f70a:9340:9a3e%3]) with mapi id 15.20.7519.020; Tue, 23 Apr 2024
 16:58:16 +0000
From: "Wang, Weilin" <weilin.wang@intel.com>
To: Namhyung Kim <namhyung@kernel.org>
CC: Ian Rogers <irogers@google.com>, Arnaldo Carvalho de Melo
	<acme@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar
	<mingo@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, "Hunter, Adrian" <adrian.hunter@intel.com>, Kan
 Liang <kan.liang@linux.intel.com>, "linux-perf-users@vger.kernel.org"
	<linux-perf-users@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Taylor, Perry" <perry.taylor@intel.com>,
	"Alt, Samantha" <samantha.alt@intel.com>, "Biggers, Caleb"
	<caleb.biggers@intel.com>
Subject: RE: [RFC PATCH v7 0/6] TPEBS counting mode support
Thread-Topic: [RFC PATCH v7 0/6] TPEBS counting mode support
Thread-Index: AQHahUcLWSEEQYKQY0+baQJ5ad3Q3bF0xt8AgAFtBDA=
Date: Tue, 23 Apr 2024 16:58:16 +0000
Message-ID: <CO6PR11MB56354787D828B28C5824E4AFEE112@CO6PR11MB5635.namprd11.prod.outlook.com>
References: <20240402214436.1409476-1-weilin.wang@intel.com>
 <CAM9d7cj2EbxWVLHU3XPf_F2OzWRVRfSV2TghNA+h8noDztrasQ@mail.gmail.com>
In-Reply-To: <CAM9d7cj2EbxWVLHU3XPf_F2OzWRVRfSV2TghNA+h8noDztrasQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR11MB5635:EE_|DS0PR11MB6496:EE_
x-ms-office365-filtering-correlation-id: 812206b2-89ac-413e-4a3d-08dc63b69225
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|7416005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?NW4vY25aTm1sWFFaMzhMVnJOVVMydmEzU0hzUlByOTRNWk9wSiszOU9FOC82?=
 =?utf-8?B?VTJNNG1MZXI3V2JQTlNwY3lCWStqbTdqTXZ1cENQZDB1am50VWNpVGpDR2d6?=
 =?utf-8?B?MnZ2L1hpU0g4WCttbDA1anBjYlNsT0ZVSVZvd1c1MTNvUmV1VnFqQVUzUDlv?=
 =?utf-8?B?UWx5MHJGR0lRdHZiSTM0K0plT2dvQytiWWVKNTNiamgrNnRCZ2tlMXVia1NZ?=
 =?utf-8?B?V1N5U0xPVHBKNzZXS1dFL0cxRHR6UVVNOG9HeFFKZmVvbWdBcUUxbkJuSElW?=
 =?utf-8?B?clFqemhwUGZiNVJ2T25jWG5VNHhoeStIWERBVENRK09WZXllZ0ozN0hDMDQy?=
 =?utf-8?B?d1JYQy9BTmtWZEloSjU5QngwMDlTTDlNSmhwUUt2R09uRTJVTk5zczdKYk5C?=
 =?utf-8?B?djB0MXRHUEw3VEIrZXhROWdzWkdEL0hDN0RPNVVQR2UzQStDY2xZeFNjS2Fi?=
 =?utf-8?B?a2NaU2ZlVHplWXNFWkFZbHQyYm5PQnZhT3JZcmYvL2tMMzVXKytaNlhZd09W?=
 =?utf-8?B?cm1QUk5CbWZQVTJXNnBicm0vVUdZSTIrcHIvb2xFYllIcC9SUCt1RTFTeHlR?=
 =?utf-8?B?cXorWlRhZjI2WXhvOVV5OU56ZGxmQ2RWdkdCT2lFeTB3bXc5TWZlTml5R0x0?=
 =?utf-8?B?N0p0dnplaWtwV0syWDhEOEZYaU9LTk8rdjhCV202YWw1WTJGc21oeFh4TVBR?=
 =?utf-8?B?cVlPaWg1T3FwbWtjS2p0eFc3akIzY3hYc1BOK2Y1TFFLRnZ4T3JkSmVrMVo4?=
 =?utf-8?B?akVqb0ZZNmtxb2p3WkJTSUo3R1EzdEdsQ1NpTXNwbndpSWN1VlZPc3lKTldw?=
 =?utf-8?B?SWR0emZCUDNVb0pTejdhd285dEZJUzFQaC9xYVc1cGVXT0dKenRaQkxJelRL?=
 =?utf-8?B?VTZ2UkdVcjMzTlpoemVEV2dheCtVZmpEQkMxZHNaVXQ2VS9mN1kwUjNIbTRS?=
 =?utf-8?B?MGxBSHp3RU9lb0ZoU2owZHppblRhV2Q5aGw3NU9Ea2Z5MUFUc25JOXJCdVor?=
 =?utf-8?B?d2x0M1ZLOUtCNVJZS1VzaXo0ZlFWdDdUWmFaNmZnR0hlVGZEZ1RDVGxFUWYr?=
 =?utf-8?B?QitaRlV0U0tGbXNhV2l2WjBlVG81UzRKeWFRTGMvbVB1aUcvRW8rbDhhQ0RK?=
 =?utf-8?B?ZTFsWTU1K2N5T2ZLQWFBZmxYMlVFZFc2aTZOM0MrTWFqcXBOb05NOTdNcGVr?=
 =?utf-8?B?aXF3SmhCakowYkk1eUVlODhGMFhKSjNiUGhDdy94NUltanRuQXRLWVVmYUth?=
 =?utf-8?B?OS85QlFyYWdHaVpvbU81Sk5rdmp5L3U5ejl0ZFB5SCtrbXhxRlNsV2pLckJu?=
 =?utf-8?B?N2t5UDlvR0REK0VRSjlsSGVaa3dXSGJUc1k3NFZhc0RvU1I1eHBWWG1oWCtj?=
 =?utf-8?B?cEZBT2NRcVNLUFhQQ2pad3FtRFVpTkVDenM5ejBpeGoxaWlNQzFOUEtrU0Q2?=
 =?utf-8?B?Ri80VTc5a2ZodzZUNDQrTzJEQ29iNjNidlBqODVoMXQ4Q0FiVmFjVjFmbzI1?=
 =?utf-8?B?SjVJZlJWZ3pKNmxEOEVudjhRMVFVRDFMWHFlbmVuWUFXRDl2bENwRTdvRDlC?=
 =?utf-8?B?RzRFSFdOcjVhMzJDekw2RjAxVnU4eS9za1lQMVV1Vm56SHAxbE9kNmVPRkhE?=
 =?utf-8?B?VmlSdUhEMnJBV1l4SHVCZmttU04zUmtaTjJhQXh3QzBVWlhUZGlVbUNoVGJN?=
 =?utf-8?B?R0pqRkQyQnc3S1REdTNDbjMwUVJMTWd5V3J3MmI2UWkxNVV2dlpGY2kwNmJs?=
 =?utf-8?B?anFTV1hoM21sbTFKempPeldXbE13VS8xNGxySjFSOHhVUEYxajZNY2FDeE9W?=
 =?utf-8?B?TGVPYWpQSnFXeXkyN0QyZz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5635.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V1JvcGNETGUwQ1duY2ZMeWJUSDJHa0k0eDRQZ2E1MEJFSHhLSlFUUXBtQWRR?=
 =?utf-8?B?OStNNzAwNDNaK3Z4SlltdFlKaG5MMGs3M3lGNU1lZTdGTkQ2OUJiVGNCMHJT?=
 =?utf-8?B?Qnl6bzNCYVBPRHhMS1BoQ1c5emM4WUNiMkxkNzIwUE1mY3ZPeWhlVUNHY1hS?=
 =?utf-8?B?R1BlekU3dEM2MGxDQSttcW9mUGYzOE9sc0VxZGcvM1pURWlaM0tNajBoR3ZV?=
 =?utf-8?B?QUlRSzBZOVJGbE9RbDJqS3d1cVJJT0hjMEMyTFJHMm5kQ0VURVRIclhpOURu?=
 =?utf-8?B?Rm1lRldva0V4T3U4ci9JS1JrdklrK0w5NDZuWXNEWURYL25ZQUFMd2JlSWU4?=
 =?utf-8?B?dFRmK1hsdDllTWwySE4xYTB0MEtuU0htYmNaNWFLamhTdHQyUUljSS9CdklR?=
 =?utf-8?B?NHVBZ3hHdktyY3g3MDFUdEJxTDladWJDWHcwUWNpODZTRXlhdTZkMUlUdmlH?=
 =?utf-8?B?TWlzdklJL245bHA3dGs2SGZYRHFXWGdTQm5FeVQwQkp1S1M4WnV3R0MxeWEr?=
 =?utf-8?B?dGtQZWpOWjRnNXNEQjI2MUVtdmRVM2taZThDOGg0Yzd6WG1QMTRwMldtYi9E?=
 =?utf-8?B?K0VEOGhqNDhnZ2duRWRTQ3NxdERoaFpaS2RzcEp2Z3pIaFE3Z2F0KzNDeWlk?=
 =?utf-8?B?dG80K3BRSDU0OERXT0pwK1VycSsvWGRGY2xJS0pXcml2bWQrRDllM1VNRVNt?=
 =?utf-8?B?WStQNTNxem41STlvUzVybnd1UzFEOVJSN2FzNXFLZGlZdHh5TEVhR3ViQ29k?=
 =?utf-8?B?NENCYmp2dHhHWVRMdFhRYS9rUkdtVWpkL0JCS3gzWFI4L3hpdFlNMVJaeFZG?=
 =?utf-8?B?Vjhud2RsR2FCclQ0NDQrb1pFK05nZGxYY3l1ZWlialpjNVdzZlRLMWYzWDZM?=
 =?utf-8?B?aXZXbjNrbkNubytKNDNqRTFxRVNNTUlha1RtMWtEbXE5NXhQSExNZmtOZWds?=
 =?utf-8?B?YW9oalhGRk5QZ3J4VGFvNHRNUHJHYit3cVBrRk44T1A3VHZ0TG5FOVJhc0M3?=
 =?utf-8?B?WVZqRk5qZkZHSTlycHpUYThCK0JLZUMvOExHYklNUzBtVGJVcWRaRlJNT1JO?=
 =?utf-8?B?TnBDYnlUZDUxRm1mVFYxaWpqUzR4andiVFovcm4wTUVSdURISnFLcDl2d3Z4?=
 =?utf-8?B?RlUxaGNmb3dCWHVBd05LanlXQ2ptNVZqWVlHdzFOaXRXa0F0RW9lb1FhMHFT?=
 =?utf-8?B?R2EwM1R3ZmFZRVFMVUpmN2czcWVESmNCQWRYQUJnSisreEQwcW1qTTYwaFBH?=
 =?utf-8?B?NFVhQWRyQUFOeWJDVFlEY2o1cXhiMTFiRzdDS0g1TWpDb21xSmJLU3UyN2V1?=
 =?utf-8?B?NXJ4L2dHV25oMGtycG4yRHdNT2QxUVovRnJsN09xMFlHeFowQTRrdEhNTnRK?=
 =?utf-8?B?QVJueUJIcUVod2ZuUCtrSWRZNlR6SEhwckdZSGM0TC8wUUUxQkx5eXpKZFZC?=
 =?utf-8?B?cHBaY3VtZ01NZ09XQllLZTU2MlZjSkxCb3RSK2ZVWk9Gdk1hL3hWQVQveEVF?=
 =?utf-8?B?VHZZd2xkZjlmZXlmaXYxRHpSVTlobktjNitvLytrMDhZelora3k1dktrbmdN?=
 =?utf-8?B?VDFiWkk3QkNYbm1UWXYydkFacXJuZ1VobERsRGxuaitRQ1lBTk0xem11NU1C?=
 =?utf-8?B?Y2MwY0dYY1hrSmlxVE1KRnA3b0t4aUh4ZDRqZDgvR2pjMmVjL0RweEtPUkt5?=
 =?utf-8?B?QXJWU3pyN0hSTUNIenEyWWtwc01DOVZWME1YU05nejQvN2tjdkh0R0wvZW8v?=
 =?utf-8?B?M2cvRUtqL1VzV2cwS3VqYlVOeFZVVmhnNWh4UWh3ekFGTVZBTm5lRWV1aG5r?=
 =?utf-8?B?cVpTSGQxSlJleTFuWnlzZzE2UlF6Q0tMcXBkMDltRG5ONm03MGxoUUVyVTJK?=
 =?utf-8?B?cHExdDdJelUzb2Rhd1hrdmozd09uSHNUSVVBalVlL3g5Mm9zdEorV0s5MFpT?=
 =?utf-8?B?L0dadDBEK2RBc1JXdEN5VEdQOGJYcDdxemJjaXBQaVlrNmt5WGJ2ZkQ2NlZP?=
 =?utf-8?B?SjJucG4rdVo3djhHUU9ZWTdtdmh1d1E5OEEzTFlLdERWNy9XcXlDeGdyTE9k?=
 =?utf-8?B?dWNENnpXTlFnSFJyKy8xMk1yNGU1V21ET1ovS1U0ZnB3Mk9Cc1Q5ZmVxNVpw?=
 =?utf-8?Q?Ti0BHfTpZGWL/B379l6YqeKXc?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 812206b2-89ac-413e-4a3d-08dc63b69225
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2024 16:58:16.6515
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cTb9AFOnOX+2co3uRoEd37vD43gkOoqpZ08BE1Kv5Hi5+jFLCpD9WQXXVuevyeQRUhIcM6HY2umICwl5P9e+dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6496
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTmFtaHl1bmcgS2ltIDxu
YW1oeXVuZ0BrZXJuZWwub3JnPg0KPiBTZW50OiBNb25kYXksIEFwcmlsIDIyLCAyMDI0IDEyOjEw
IFBNDQo+IFRvOiBXYW5nLCBXZWlsaW4gPHdlaWxpbi53YW5nQGludGVsLmNvbT4NCj4gQ2M6IElh
biBSb2dlcnMgPGlyb2dlcnNAZ29vZ2xlLmNvbT47IEFybmFsZG8gQ2FydmFsaG8gZGUgTWVsbw0K
PiA8YWNtZUBrZXJuZWwub3JnPjsgUGV0ZXIgWmlqbHN0cmEgPHBldGVyekBpbmZyYWRlYWQub3Jn
PjsgSW5nbyBNb2xuYXINCj4gPG1pbmdvQHJlZGhhdC5jb20+OyBBbGV4YW5kZXIgU2hpc2hraW4N
Cj4gPGFsZXhhbmRlci5zaGlzaGtpbkBsaW51eC5pbnRlbC5jb20+OyBKaXJpIE9sc2EgPGpvbHNh
QGtlcm5lbC5vcmc+OyBIdW50ZXIsDQo+IEFkcmlhbiA8YWRyaWFuLmh1bnRlckBpbnRlbC5jb20+
OyBLYW4gTGlhbmcgPGthbi5saWFuZ0BsaW51eC5pbnRlbC5jb20+Ow0KPiBsaW51eC1wZXJmLXVz
ZXJzQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgVGF5bG9y
LCBQZXJyeQ0KPiA8cGVycnkudGF5bG9yQGludGVsLmNvbT47IEFsdCwgU2FtYW50aGEgPHNhbWFu
dGhhLmFsdEBpbnRlbC5jb20+OyBCaWdnZXJzLA0KPiBDYWxlYiA8Y2FsZWIuYmlnZ2Vyc0BpbnRl
bC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUkZDIFBBVENIIHY3IDAvNl0gVFBFQlMgY291bnRpbmcg
bW9kZSBzdXBwb3J0DQo+IA0KPiBIZWxsbyBXZWlsaW4sDQo+IA0KPiBPbiBUdWUsIEFwciAyLCAy
MDI0IGF0IDI6NDXigK9QTSA8d2VpbGluLndhbmdAaW50ZWwuY29tPiB3cm90ZToNCj4gPg0KPiA+
IEZyb206IFdlaWxpbiBXYW5nIDx3ZWlsaW4ud2FuZ0BpbnRlbC5jb20+DQo+ID4NCj4gPiBDaGFu
Z2VzIGluIHY3Og0KPiA+IC0gVXBkYXRlIGNvZGUgYW5kIGNvbW1lbnRzIGZvciBiZXR0ZXIgY29k
ZSBxdWFsaXR5IFtOYW1oeXVuZ10NCj4gPiAtIEFkZCBhIHNlcGFyYXRlIGNvbW1pdCBmb3IgcGVy
ZiBkYXRhIFtOYW1oeXVuZ10NCj4gPiAtIFVwZGF0ZSByZXRpcmUgbGF0ZW5jeSBwcmludCBmdW5j
dGlvbiB0byBpbXByb3ZlIGFsaWdubWVudCBbTmFtaHl1bmddDQo+ID4NCj4gPiB2NjogaHR0cHM6
Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjQwMzI5MTkxMjI0LjEwNDY4NjYtMS0NCj4gd2VpbGlu
LndhbmdAaW50ZWwuY29tLw0KPiANCj4gSW4gZ2VuZXJhbCwgSSB0aGluayB5b3UgbmVlZCB0byBl
eHBsYWluIHdoYXQgZXhhY3RseSBUUEVCUyBpcyBhbmQgd2h5DQo+IHlvdSB3YW50IHRvIGRvIHRo
aXMgZm9yIFRQRUJTLiAgTWF5YmUgc29tZXdoZXJlIGluIHRoZSBkb2N1bWVudGF0aW9uLg0KPiAN
CkhpIE5hbWh5dW5nLA0KDQpPaywgSSB3aWxsIHdvcmsgb24gdGhpcy4gSSBoYWQgZXhwbGFuYXRp
b25zIGluIGFib3V0IFRQRUJTIGluIHRoZSBmaXJzdCB2ZXJzaW9uIG9mIA0KdGhlIGNvZGUgcGF0
Y2guIEkgd2lsbCBhZGQgdGhhdCBpbiBhIG1vcmUgcHJvcHJpYXRlIHBsYWNlLiANCg0KVGhhbmtz
LA0KV2VpbGluDQoNCj4gVGhhbmtzLA0KPiBOYW1oeXVuZw0KPiANCg0KPiA+DQo+ID4gV2VpbGlu
IFdhbmcgKDYpOg0KPiA+ICAgcGVyZiBzdGF0OiBQYXJzZSBhbmQgZmluZCB0cGVicyBldmVudHMg
d2hlbiBwYXJzaW5nIG1ldHJpY3MgdG8gcHJlcGFyZQ0KPiA+ICAgICBmb3IgcGVyZiByZWNvcmQg
c2FtcGxpbmcNCj4gPiAgIHBlcmYgZGF0YTogQWxsb3cgdG8gdXNlIGdpdmVuIGZkIGluIGRhdGEt
PmZpbGUuZmQNCj4gPiAgIHBlcmYgc3RhdDogRm9yayBhbmQgbGF1bmNoIHBlcmYgcmVjb3JkIHdo
ZW4gcGVyZiBzdGF0IG5lZWRzIHRvIGdldA0KPiA+ICAgICByZXRpcmUgbGF0ZW5jeSB2YWx1ZSBm
b3IgYSBtZXRyaWMuDQo+ID4gICBwZXJmIHN0YXQ6IEFkZCByZXRpcmUgbGF0ZW5jeSB2YWx1ZXMg
aW50byB0aGUgZXhwcl9wYXJzZV9jdHggdG8NCj4gPiAgICAgcHJlcGFyZSBmb3IgZmluYWwgbWV0
cmljIGNhbGN1bGF0aW9uDQo+ID4gICBwZXJmIHN0YXQ6IEFkZCByZXRpcmUgbGF0ZW5jeSBwcmlu
dCBmdW5jdGlvbnMgdG8gcHJpbnQgb3V0IGF0IHRoZSB2ZXJ5DQo+ID4gICAgIGVuZCBvZiBwcmlu
dCBvdXQNCj4gPiAgIHBlcmYgdmVuZG9yIGV2ZW50cyBpbnRlbDogQWRkIE1UTCBtZXRyaWMganNv
biBmaWxlcw0KPiA+DQo+ID4gIHRvb2xzL3BlcmYvYnVpbHRpbi1zdGF0LmMgICAgICAgICAgICAg
ICAgICAgICB8ICAyNDkgKy0NCj4gPiAgLi4uL2FyY2gveDg2L21ldGVvcmxha2UvbWV0cmljZ3Jv
dXBzLmpzb24gICAgIHwgIDEyNyArDQo+ID4gIC4uLi9hcmNoL3g4Ni9tZXRlb3JsYWtlL210bC1t
ZXRyaWNzLmpzb24gICAgICB8IDI1NTEgKysrKysrKysrKysrKysrKysNCj4gPiAgdG9vbHMvcGVy
Zi91dGlsL2RhdGEuYyAgICAgICAgICAgICAgICAgICAgICAgIHwgICAgNyArLQ0KPiA+ICB0b29s
cy9wZXJmL3V0aWwvbWV0cmljZ3JvdXAuYyAgICAgICAgICAgICAgICAgfCAgIDg3ICstDQo+ID4g
IHRvb2xzL3BlcmYvdXRpbC9tZXRyaWNncm91cC5oICAgICAgICAgICAgICAgICB8ICAgMjIgKy0N
Cj4gPiAgdG9vbHMvcGVyZi91dGlsL3N0YXQtZGlzcGxheS5jICAgICAgICAgICAgICAgIHwgICA2
OSArDQo+ID4gIHRvb2xzL3BlcmYvdXRpbC9zdGF0LXNoYWRvdy5jICAgICAgICAgICAgICAgICB8
ICAgMTkgKw0KPiA+ICB0b29scy9wZXJmL3V0aWwvc3RhdC5oICAgICAgICAgICAgICAgICAgICAg
ICAgfCAgICA0ICsNCj4gPiAgOSBmaWxlcyBjaGFuZ2VkLCAzMTE1IGluc2VydGlvbnMoKyksIDIw
IGRlbGV0aW9ucygtKQ0KPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQgdG9vbHMvcGVyZi9wbXUtDQo+
IGV2ZW50cy9hcmNoL3g4Ni9tZXRlb3JsYWtlL21ldHJpY2dyb3Vwcy5qc29uDQo+ID4gIGNyZWF0
ZSBtb2RlIDEwMDY0NCB0b29scy9wZXJmL3BtdS1ldmVudHMvYXJjaC94ODYvbWV0ZW9ybGFrZS9t
dGwtDQo+IG1ldHJpY3MuanNvbg0KPiA+DQo+ID4gLS0NCj4gPiAyLjQzLjANCj4gPg0KPiA+DQo=

