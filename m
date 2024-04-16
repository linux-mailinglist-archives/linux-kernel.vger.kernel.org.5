Return-Path: <linux-kernel+bounces-147728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FBF98A7841
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 01:03:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA1B128587B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 23:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8701C13BC1A;
	Tue, 16 Apr 2024 23:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iSGCmGf7"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7F513A3EF;
	Tue, 16 Apr 2024 23:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713308537; cv=fail; b=NtIAWnoeF8G/fRbAScaumgNNE3lBFtz9/hh/OujlxlAOFgRpwbeug8/0P1EJEz2z9Ik9CD+FLq/yHq5TJmVUkIn6alvMGQkFfxe3lcObQdUQ0YkYM7GYWTO62q3Rvji8bfEHYUOVGL/wcz8evuySlIrnpO0Q5gMWwk6YHAe3IU4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713308537; c=relaxed/simple;
	bh=ci2qhEyqHZ9YhBwPVKALy3A1S0oTSpz1fQwqLE39U8U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oKCuBgAskQxAcUw7HSHJ4+uLQjdLE7thVZCWoRgRCpvniHFIEJ4aehnuWOgV7Rk2i4Z7TE98vhXvSUV92vqjeNdroVbacNb7WVDQmU2DbQhMh0C18t8IfyesRZv+XfCjDNOhg2eYYdb4Qz3OrIczNfHI4UgvxmZh47bJm+lHVBs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iSGCmGf7; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713308535; x=1744844535;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ci2qhEyqHZ9YhBwPVKALy3A1S0oTSpz1fQwqLE39U8U=;
  b=iSGCmGf7dVl4Ui8/eI7CUFHacyKPFcxynDttc9kdq4zrZ5+2AQZWDWJK
   awE5zEFDAl9mdlCdmMNBe+dPDXxbC+TqUCIxv8NsN/WaRZ4ahuWRboYqi
   1P7nIyQ2hcOy+Q5nsrVjPx3PDhxN4Nqi0KbKJH1yVRlfg9JHizEDtRC9u
   Y/q6vEQhOHirUexJr55r2uQZbuxg3xUq6jNls0K14CG3WDPpk44wVn9hf
   MLCNqHVt866+cNMYKFClwngwQmy8TYT6r6dBh+n1amQ6ATuNzXkprccPM
   XXs2LzLsqTlnruQs3tf/oYn/bPol9+kcJzOzrRdI6+ZpOWEDv/P+irh9R
   g==;
X-CSE-ConnectionGUID: fdUbg10iRQSSzDr+NWqdOg==
X-CSE-MsgGUID: v8UmVSFfSN69SRR/ZkKZhw==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="19339281"
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="19339281"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 16:02:15 -0700
X-CSE-ConnectionGUID: nIzF0NKfTPay0/+0PEwPcw==
X-CSE-MsgGUID: 3AXpH85gSky/bUwKGDoUXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="53387571"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Apr 2024 16:02:15 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 16 Apr 2024 16:02:14 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 16 Apr 2024 16:02:13 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 16 Apr 2024 16:02:13 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 16 Apr 2024 16:02:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CuWlwONAO4kBU8NRlwho8HOob4A7Oj7yyDJgPRHqEUgqc0ejYOFl0TaHELGsg/FAzvTbWBVjpPrBk6AJ3QrUvl/yLH8nGyvzYEts2Z/ezgXZfPYoeCUb4xjPdlo65Z12uYDfcymOcEmXATadn6xRz/DcX9gredfIijOXvAtjh1shnHNkbAhyjCht1vjdhzHn8Rmo5im/R2xUSMAvakU0ylZd6sX6gFBxizuAeDnxTQ1LpUsri5IpHhspsNRN/HNs5uy85Mnjf5K5Z4QDFkalsb+2WVTM5N5mRupIM2FTEfRPDDrJ6H5JO7QHfYixW63o4gePyvzS++TraVfloWm/Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ci2qhEyqHZ9YhBwPVKALy3A1S0oTSpz1fQwqLE39U8U=;
 b=LhNkpX/oZeyuwSoy1MREM/D9xFwfcgtItR5CZgqG0kZ2DV88kr1P1K/7ajYs5XGjon9jTmMMhlcqV2EGMp6kQOF/G/dCy+dzVnBL7sj7PfYpacrKQX6HpkcRYGoTi0+sTxEgqkzupnL1QAtxWXk9C0gG0jRHC6gPIp8GN4bAT9NbCQY5VZSEXMSm3NIrQVRJdKr/vZSOhBUjbhxSQO2Ia4MBgs5qUv9ut4uBe1qhI77X6ZUR1f4yVBTBLl/lbAtPl91y521sfwS6RnQoN7UvmqjXfohDBOWYug3xc8ZMpzMzsNm1jaglyx27qJi8yPmFQ2xXEV6ZuxmUZdCYXKfUeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB7125.namprd11.prod.outlook.com (2603:10b6:303:219::12)
 by DM4PR11MB5309.namprd11.prod.outlook.com (2603:10b6:5:390::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.31; Tue, 16 Apr
 2024 23:02:12 +0000
Received: from MW4PR11MB7125.namprd11.prod.outlook.com
 ([fe80::ed72:f69c:be80:b034]) by MW4PR11MB7125.namprd11.prod.outlook.com
 ([fe80::ed72:f69c:be80:b034%4]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 23:02:12 +0000
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "Williams, Dan J" <dan.j.williams@intel.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "colin.i.king@gmail.com"
	<colin.i.king@gmail.com>, "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>
CC: "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][next] dax: remove redundant assignment to variable rc
Thread-Topic: [PATCH][next] dax: remove redundant assignment to variable rc
Thread-Index: AQHajx5rJmN1CaXtkkqCTeiSd99Z6rFrhf2A
Date: Tue, 16 Apr 2024 23:02:12 +0000
Message-ID: <9dc2aeeab5b1c553c8e23e678cfc637174247701.camel@intel.com>
References: <20240415101928.484143-1-colin.i.king@gmail.com>
In-Reply-To: <20240415101928.484143-1-colin.i.king@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.50.4 (3.50.4-1.fc39) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB7125:EE_|DM4PR11MB5309:EE_
x-ms-office365-filtering-correlation-id: 075e1daf-4d0f-4d9f-521e-08dc5e694042
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: w9TyOV8SLfUayTnX6D1hA64ra7S7wzJn9KIq0RhMPPrl6KB+pbhpc+fF8c0CvgPaPh38UrS3UEnVTBdGXL9B3Xkgouw2ytGfOliipGKNXulzBes4sTa7daxlfzLi/DmFlONlwvNKiajxJ9blX2Bp/rva9I4KXCFg0HBBjqxy4uLIAMyX+YIE0+gFjwQZ0ZYrKoxiX69ltfNDP3SjyuPXi58ldrfMqH+CdRinvXsJvOZreyNc/QVgs8IV+y3l085BntQdUTmjtnKiKUwJKHTK8nBY+vtHrGGMi2KLwJMR0twV0kIlCsf9/nU3m0Cjj0qEWXfwA3ptNAlOkkiUJbwnTYcRMu86txXN/yUi6HXLnZkYRhM6T8DkleN0MZGN55SxzptjTl/2q0cPFgfrxfHSrqICcaObWeeetE70IwNK2bfRd2JGGD+mzaWdEGomo4FgDaDalHHCJeIlu5GwPiCn6ltVn8T1IhmVZK5FMm9oTQwjGoT7AxFBaeW9JGbNgZj2BXjZ/7LzU+PE1MSMDrzU1a+zwXKW5/2Q2RRh6X/Pumgeb9XzWpS63owWolRQ6cXjv1wFgeeWdyAcCJ36QEbpONvxGhRBIelAzix3JWPYLsiNnhKB9G5NVk4kEYnMpbFaA34Piq6RwExap6YKhGTfljv2YXzkqp++pz48qS95Zffv230xVxgPYz+Sb3Rx6gmQQtAu2B6tgRWffKeShK3lUw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB7125.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ekY1MmhKdjNkWFczZHdHcDBMOHdHeVZLMlgxVi9vYnRiZlMzTTg3THZ4ZzB3?=
 =?utf-8?B?VjVraU1aV2tuTGdoK2l2S1h3clhxYkl6YlBQZTdnMDVjbnRKNytHVUZ4K0Ry?=
 =?utf-8?B?dzNmYzZza21lU2t3VjVZZEFZMHpWV0xJK2ovNjdXTHVqdlBuakFGc1Q5K1Ra?=
 =?utf-8?B?L3V4dHkrZk9salpwY000TjNxREw1SEp1OEZBajVOWnRKRWpQdFcwNmxLOFhE?=
 =?utf-8?B?WU5VbE5pMkQrTktlQmo2N0FrRnFXOGRVWE5YYWZ2TzRkTDhOcGdFZTFUOFBU?=
 =?utf-8?B?eFRIQk8yazNjaWRPanNGQmFXMEpHNGx2OUxib0wwNm9MOVJCaFlkV25CWWM5?=
 =?utf-8?B?RGVCZk9RYng3LzRpWFZpSWU2Q2tFaWJVekc4SitQZWpYYU9xeHA3ZkFDREpQ?=
 =?utf-8?B?TElOcGoyd2VSRTFNejRFTHNnWE9CNWNmNkQ2SkUvaXBWOE54a1FVOVhqd0Mw?=
 =?utf-8?B?VEpwZ0ZjYW80NDJYVU1rdGdFMVdMUTRHZmxZRXU0czVsTi9ZSWRjSHY0aTJx?=
 =?utf-8?B?eE5Qcnh4RlQ0NThIeVltcGJBR2l1QWNCcEtSZ0J3cnBTN24wdzREMXFCTjJU?=
 =?utf-8?B?NEQwdXBuQ1pXS01VbUxnT0h3LzJ0TUpXZkxDMFhxUnV5V2RhakNTZVpKdlp0?=
 =?utf-8?B?bkx6Z1BtZ2lqMHhYc0VWNW5yUE0xZkNjYUxmZ1Nzc2tMSzRLMTlONWo5VS91?=
 =?utf-8?B?ei8zcW9RNTlubVpCdnBmb1hYTFd2Q000Znh6aEY1WnQreDA1bjRrR0I3bzAv?=
 =?utf-8?B?MDZDbVVzcGhzcU1ZOTNCREw1VWwrTTQ5YTM3N2VpL0JQWEtTeklFNG5ZZDFE?=
 =?utf-8?B?STlibXl0RWZPMnI4MmIrK1dBMmt6TjJTalpHK1FoTllYMDIva0xxMFZiV3dG?=
 =?utf-8?B?UzdUV2F4Q1NjNi9seDgzeVd4V0tHd29YUHJqdnhXVlZBbVNqUjZWWm0wQ3k4?=
 =?utf-8?B?UjhsRm9IRnFYSkhGWEpESHZya3dsSGRHUFRlT2pac1ZRTi8zOUNOaEFZcDM2?=
 =?utf-8?B?WkUzNzZGMDF2OHcwTEJmUm5PYU5FRDEvcnBzcnVzRWJyVkdSQU1vR1poaDlt?=
 =?utf-8?B?VVJLelhGNlZGNTRxM21aMTBJc0dWRXhFaDRzUXZlOVo5MzRzWlB4ZERCQVEx?=
 =?utf-8?B?Zjd1QWoraFJsMGhFSERwNjRKK1hsWC9TQnEzUGlRL3lrMUlHVGdmZE9mMUxj?=
 =?utf-8?B?aHliNGZMZnpKUjhNcjI0WmlCYlBpMTFzMlY3OFdyQzhhTnZ6WVg0NVhFMWZE?=
 =?utf-8?B?WkdmM2UrdzBxWUVUNzhsNlJGMEtESHVXbmRCWXRhcUpSQVNRUlFoc2pEYloy?=
 =?utf-8?B?MVJwbmk3TjNGS2E1ZndYUFkwSkZ6dENIb1l6UHArZnREd01tc2hJekF6Y1By?=
 =?utf-8?B?Z2toeFZUdkNKV1g4ak8rS2dGSUhnc245dExHUUZUWThsaUNCOVpISFdnNTBR?=
 =?utf-8?B?YnpSMWsvWVNQblRycHYzbU43dUk2NHJmYnF3VEltRWR0N2Ywa3l3bTlJS01m?=
 =?utf-8?B?SWhmem9VQk1XdEpNK3ZvbFZwSWFBT25DNU96TVhjSkxOd2Vaa0Y4MzliUzNo?=
 =?utf-8?B?VTRYZ2IxaW1KVFA1Sjk0eU5Ca0VEbHhGdDUvL0V2YkpMY1NwVzFGSkhlTk5P?=
 =?utf-8?B?anJaUUJ0OVRKdlRUaFpxS05VYW1kQWVPZkRwenNBMVZBc0ZQNC85WkxWUStI?=
 =?utf-8?B?am5YdGs4NmNDRi9DS1k4ekdQRGErQkdHQUxUVXU5em9GN0Z0SU9Kd0JqZTBD?=
 =?utf-8?B?TU5kclJIVzNnV0ZZMk9ydkNESWRRU0JwTjBwUTY2RDYydGNTQllmdXkyOEVI?=
 =?utf-8?B?S1N4UWxVOGQ0VzhvV0Nla1pkRG42dFJ1ejU1R28yU3FvN3NCNFhzSWREcEli?=
 =?utf-8?B?bS8xRU4wcUxPalAzQ0NaWDJ1SXBSang0NU9CTU1ZT2VXZUxwNURURm5SUTlV?=
 =?utf-8?B?S3B1R2Y1TU1uUjJHaENOZHBjWGljcUVndDUzbVNOMnB2TExBNG5GcUxrZWpy?=
 =?utf-8?B?Z3FIaTdMZVZYRTNRWnNrN1h0YVA0MnhZVzl3bmZ6Zi9YN3ZTdUhYVGwvMjFU?=
 =?utf-8?B?ZlM4bGNLQUJ0eHZsVWlsbHp6eHArczIrZSswT1ZtTUQ1T3hXeG9DVFZ0Nytt?=
 =?utf-8?B?UDBXWThxOU41OGt2SjBPMUsvSmw3enF3SlBHV2EwZER6Unk1WW1HRk1MNFpR?=
 =?utf-8?B?Nmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <934BAF1428D4EA4EA29D57CA5EF6D165@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB7125.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 075e1daf-4d0f-4d9f-521e-08dc5e694042
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2024 23:02:12.1928
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nD2wZ2zN/EclyuAsacBko+k9sYQuj2LSm9hUqQd86iuDuf4s5tw6Xy77wGN+ZeLGMMjlvmnSJgOgxMeKA/OYxZUxPF15KhnLtD4HK5fmZPA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5309
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI0LTA0LTE1IGF0IDExOjE5ICswMTAwLCBDb2xpbiBJYW4gS2luZyB3cm90ZToN
Cj4gVGhlIHZhcmlhYmxlIHJjIGlzIGJlaW5nIGFzc2lnbmVkIGFuIHZhbHVlIGFuZCB0aGVuIGlz
IGJlaW5nIHJlLWFzc2lnbmVkDQo+IGEgbmV3IHZhbHVlIGluIHRoZSBuZXh0IHN0YXRlbWVudC4g
VGhlIGFzc2lnbm1lbnQgaXMgcmVkdW5kYW50IGFuZCBjYW4NCj4gYmUgcmVtb3ZlZC4NCj4gDQo+
IENsZWFucyB1cCBjbGFuZyBzY2FuIGJ1aWxkIHdhcm5pbmc6DQo+IGRyaXZlcnMvZGF4L2J1cy5j
OjEyMDc6Mjogd2FybmluZzogVmFsdWUgc3RvcmVkIHRvICdyYycgaXMgbmV2ZXINCj4gcmVhZCBb
ZGVhZGNvZGUuRGVhZFN0b3Jlc10NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IENvbGluIElhbiBLaW5n
IDxjb2xpbi5pLmtpbmdAZ21haWwuY29tPg0KDQpSZXZpZXdlZC1ieTogVmlzaGFsIFZlcm1hIDx2
aXNoYWwubC52ZXJtYUBpbnRlbC5jb20+DQoNCj4gLS0tDQo+IMKgZHJpdmVycy9kYXgvYnVzLmMg
fCAxIC0NCj4gwqAxIGZpbGUgY2hhbmdlZCwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZGF4L2J1cy5jIGIvZHJpdmVycy9kYXgvYnVzLmMNCj4gaW5kZXggNzk3ZTFl
YmZmMjk5Li5mNzU4YWZiZjhmMDkgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZGF4L2J1cy5jDQo+
ICsrKyBiL2RyaXZlcnMvZGF4L2J1cy5jDQo+IEBAIC0xMjA0LDcgKzEyMDQsNiBAQCBzdGF0aWMg
c3NpemVfdCBtYXBwaW5nX3N0b3JlKHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IGRldmljZV9h
dHRyaWJ1dGUgKmF0dHIsDQo+IMKgCWlmIChyYykNCj4gwqAJCXJldHVybiByYzsNCj4gwqANCj4g
LQlyYyA9IC1FTlhJTzsNCj4gwqAJcmMgPSBkb3duX3dyaXRlX2tpbGxhYmxlKCZkYXhfcmVnaW9u
X3J3c2VtKTsNCj4gwqAJaWYgKHJjKQ0KPiDCoAkJcmV0dXJuIHJjOw0KDQo=

