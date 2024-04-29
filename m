Return-Path: <linux-kernel+bounces-162460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA978B5B91
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 16:39:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60FA8B25B43
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 14:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 598E87EF04;
	Mon, 29 Apr 2024 14:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wo5j4L1D"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E507E11E;
	Mon, 29 Apr 2024 14:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714401561; cv=fail; b=WCecHzwEwWXoygKIW9jqL7L/TfMxcOx5NYcU2TEBdFyAgUlH28iV69pyLT3EebpascJp4sOvfW+pKILAmuD/xD3xISmb+1ksPQWO7zJM1H2bZ5Z8LecTSCyj6Ywz/h3EN7vSJBbpKhoCbFzd/er4wMdIJRr16+OM5hq2vriowT0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714401561; c=relaxed/simple;
	bh=2BUZ9fvzFB89Ztk6O6zhG37L5njgoU/56xT1Og1v6ho=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JSYuZb1QBYCecZ8R3Hb1DYWUhSOS5vaajY+DABNxzvap2Pt+8VLlJ7TBIeRvK5DWGhKUhMsLKqafUTq0QPkJs4zLKLHzeooZGF9sNA4BoRwlY6N2M6/uDg+xmX7ktp/A69uEV79yGo2lwhyMXej1TWM0ruAA0T5veNLJq3VWHiQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wo5j4L1D; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714401560; x=1745937560;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=2BUZ9fvzFB89Ztk6O6zhG37L5njgoU/56xT1Og1v6ho=;
  b=Wo5j4L1D7kl6TKmLF4Ps8L1oNRqlBp9AXfFGCiQHGIo4wXVdJ4VOnkdy
   kZgMU2ukYmCyk+/IrxdogAXMjHSgDRyd0b/qJAoTSWZjCGMHP8NhCXjYz
   h5r0y+yMguJ5wEXF3jPbUewKjpWtSe1L9F/29RXlS+IxwlMbHhd/n9vJi
   ORjiixnS/jo/UhfYZm+JMUFvVTxbC3FaUZrz2RjbD7K2hC6rLoS0keF7R
   IZSNp6gSGOrzitHnkMmrxG2WWSdgH/j2qcGd7AmgF/Ak+XDkQnIjJ4ssi
   4yukuxNGVs2+NvaxmD4v6Fmq2jr7RbqnE5Cn7psXk2CpzSR4ZjwZvC+eS
   Q==;
X-CSE-ConnectionGUID: DUSBkx9JTCmApltqOcZkxw==
X-CSE-MsgGUID: OfFEXh4dSOSZKrP1trVDow==
X-IronPort-AV: E=McAfee;i="6600,9927,11059"; a="10283110"
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="10283110"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 07:39:19 -0700
X-CSE-ConnectionGUID: TBGDUWS0TLGg75bWxmyCcA==
X-CSE-MsgGUID: 9iLTnrjfT1OuNUixdSWcQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="30930003"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Apr 2024 07:39:19 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Apr 2024 07:39:18 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Apr 2024 07:39:18 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 29 Apr 2024 07:39:18 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 29 Apr 2024 07:39:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e5D9aJJ9JEX0/F6Q++0dW9lkNtAd0aAqlBMfzzfLmOghqPHKW+c+kCePx+2QNDyO/ZtcrLjFeASJWVimRWcphn8R/XpzM5sTsIEYjMmqqyISfR5UuC/SHDmMJmGcoyC9MC2SnF4tR+LGJYunLO8WIykhZ0El/0gp3TPp9/9ZHxWmm/tisTKgTo98J8igel1+h5GqStdsYxFG7GQRddbMxLTQVLF+VtLE/G7UYgG7za+JmStcEHIZdZ9T7yJjT6fGjRi3XM/0jyp6Hw4GeB2Ki5vFsYoVcMITQmz4KI6YjvEOC6i/QfaOGupj0JCOS7Pm8BSc/1qucC5CfBVr18mXzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2BUZ9fvzFB89Ztk6O6zhG37L5njgoU/56xT1Og1v6ho=;
 b=J3Z1KhTa+aYOVVRNNL7KpnYoTj7sOCdNd5VKWtOOqww+YBeQlA2CDzDOe7Q8xHV6chpCcD6LhogI107CGwVZu5hZ0HcnCUa05EGsisHou8x7BDgZRosdvUP2blzkVXrYlKvk5UGCnf6L4eyCxnLYo/UtlExWcouaH0TvE+3Q9UUJGp67suvQcXXY9qmPZKbqP+6ODHl+jA7hffCAUawAdmNGxYKAT/NRmC4o9olXAa6oiwjafp7oRGOTfrjFn37qoQkXnsJgokeGbvxzXY9XUfIsN6RFEQLNv1faUTVjU4E64i/o4y4ghptQkqxUoEoz9Y9c9gNYO0/6Z5CEXZk7tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by BL1PR11MB5317.namprd11.prod.outlook.com (2603:10b6:208:309::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 14:39:14 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::d5d6:c0cc:baae:1ba6]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::d5d6:c0cc:baae:1ba6%4]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 14:39:14 +0000
From: "Zhang, Rui" <rui.zhang@intel.com>
To: "linux@roeck-us.net" <linux@roeck-us.net>,
	"ricardo.neri-calderon@linux.intel.com"
	<ricardo.neri-calderon@linux.intel.com>, "Wysocki, Rafael J"
	<rafael.j.wysocki@intel.com>, "jdelvare@suse.com" <jdelvare@suse.com>
CC: "srinivas.pandruvada@linux.intel.com"
	<srinivas.pandruvada@linux.intel.com>, "lukasz.luba@arm.com"
	<lukasz.luba@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
	"daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Neri,
 Ricardo" <ricardo.neri@intel.com>
Subject: Re: [PATCH v2 2/3] thermal: intel: intel_tcc_cooling: Use a
 model-specific bitmask for TCC offset
Thread-Topic: [PATCH v2 2/3] thermal: intel: intel_tcc_cooling: Use a
 model-specific bitmask for TCC offset
Thread-Index: AQHalzMUIPnt72yi5EiTSkiLy2FaYLF/V5oA
Date: Mon, 29 Apr 2024 14:39:14 +0000
Message-ID: <5de7a9cf7336afa4aa514d93ba9bcd0bac3ef8f0.camel@intel.com>
References: <20240425171311.19519-1-ricardo.neri-calderon@linux.intel.com>
	 <20240425171311.19519-3-ricardo.neri-calderon@linux.intel.com>
In-Reply-To: <20240425171311.19519-3-ricardo.neri-calderon@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|BL1PR11MB5317:EE_
x-ms-office365-filtering-correlation-id: 9c55ddb4-d991-4311-279e-08dc685a2435
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?eTFHWmE3NXduZTREQ1lhMHFZcGFlbzlZOVJuZVRzNTAzZGlLUmY2VW1OT2lp?=
 =?utf-8?B?c3V6VXB6eVR5RGZ0OG9tNE4raFhnNFlXL2xFMHpnd1ZGSUYzYWNQeDRPa0Rp?=
 =?utf-8?B?U1JaSno5QUdiU2xiMFREQTNpUkI4N09wYVBWblBjWWR3ZEYxSzBXdDcrUk9a?=
 =?utf-8?B?elFlZTRaejR0UDhQWmZRUk5RMmZtdjBxanUwWmNvTm1CZmUza0plV05hMVpS?=
 =?utf-8?B?SUR4WTAvSDNUN3B0UlRyWnVtd2dyMEdpSU1lOEd1ZzhkLzMwVE1qQUhvbU0v?=
 =?utf-8?B?dVRSY3NTTkwrem5hR2VKdXJiTWdUQ3Y5VGxoMnI0QlpmZjBaSWRlMlQ3dVoy?=
 =?utf-8?B?aXNoRisva3Z1UWpsWkZUemttanNJNDBwUlRiZ08rbWxpZW8xU2F1NlJqWWVN?=
 =?utf-8?B?cUZ3anNrOXhzN1RuY28vQ2J3YTQ3R29SV3VHMnFaSGdEdFdtcmI1SVJaclR4?=
 =?utf-8?B?clZmNmpuWmUyazFxVlV0aVJVTk5kT2x0Q2ZtcHYwV2NZdUd1UnF6K3BqTWRw?=
 =?utf-8?B?Vk82ZGhLZkZaQWtJMDNaUGhseXZzdHBSbmZBTGY2TjRnOFZKZTBjWW14TEc5?=
 =?utf-8?B?Vk5Uc2VBT0d6bHRCaUwxNWdFTFBZTzNWbGdvaU1zd1JOQndXeVdDOGFxeG9T?=
 =?utf-8?B?VmpuSGFIWmlOdmUwa1lZS3JpTmp1NWJBTTJVdW16ejJiSDhmU0lhREJVZndX?=
 =?utf-8?B?M1prZlNqR1UzR3kvV09Wd2hXZHlRV0dZRkpsUi83b1lZM09TT3hoZFJTR2tF?=
 =?utf-8?B?dVZJVWtPVGVBMnowckZwOExUeXU1TFBQam9LS0pWMjM5OW5XeU4rWDNFS0Nv?=
 =?utf-8?B?VGMzREl2d2xGeDhlV0psSFh3Y0ZlWHpsMURZaEZ5OUlPaExQQTJPaGRzdUF6?=
 =?utf-8?B?NEg0NTgwa1p4L1FZa09aNlpOaDdoN1NJcWJuUkdmVjd6QlBGYnYrVjFkbU42?=
 =?utf-8?B?bFhTREpXTG1RSmN2Vzh5aDQ3bmtJelRJUXRCakxKb0hZUXdRTUhWMlVYVFRs?=
 =?utf-8?B?U3hhWWVNR3p4a2QyaXluUnVDcGplalYvU0E2cTJyUDhqMGw1cDhGUE1IdVI5?=
 =?utf-8?B?YS81MDFERzlsZDVZbXZvSWpzQ0wva3ZQK2VJQTIwVTJ5eTlpR282WlRkTnFJ?=
 =?utf-8?B?Y05qVjkrY29leTlzeUJielRpVWhlTTZXVFR0Y01IUkZTODRZRDRXVWt1dGhU?=
 =?utf-8?B?ZkJ6Z1NqNlRqS0FGb0QxUDdhZzJyOXhacEhqbHVhUTcxQmxsTjIwREN0T2dz?=
 =?utf-8?B?c1NVeG91MG8wTnM3VkMzV2lrUFZHcHdTK1lkK2pGbWtVeWdzenJJeGcrazA5?=
 =?utf-8?B?UFNudjV6MDcvSDExM2wzYlpxNWJ4LzJRM016RzRZZmFka3FXN0ttUmVEKzlu?=
 =?utf-8?B?eFFHSjZSd2t4TFVXS2VaZEN2aE5jandLQWZweHNpTElNcmxMUmMxWUJkUncx?=
 =?utf-8?B?Y2FZU3plTXZlSUxzeFZXV2hreFROUVRqeElyeVZCU1lwVmhlVUVIcWtpZ0ky?=
 =?utf-8?B?aEd6RGFzVnRKUlB0Z1FrZit1QVcrRTFRWG9lTWRlV2p4a3c4RlJRSkgzcVlP?=
 =?utf-8?B?M3VTa1QzWHJBRHBTRysvWnhQMWk3YzdxVEwrM2QrUFRydWF0Smh6a2JCdUhi?=
 =?utf-8?B?dDJNNy9RVEdoSWFyVlNMRVpLSlE1bE5zYjI3SUozdVZKUHB1UkFwQ2tZdnNB?=
 =?utf-8?B?VnhrcllMRG1jQWJvazZVTVZ5MTU2M1Y5N0JxUkxTTXdENWtOT2k1Vm1xNXdk?=
 =?utf-8?B?ck9BMjY3c2J6M3NsdGRpcWVYYkVQTzI3Y1dPNG5JaHBWLzFadG5rVkR5eGsy?=
 =?utf-8?B?b2VQcGZPWHdEdmNyOXNTZz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UnltMXErdkpIMUtFWU5udmE0b05GTzlrWGVyRS96d0wwZTA2aXRXK0NuNDh3?=
 =?utf-8?B?WFNFU0hoMW1NN3Z5NVhJa3UyNTRnU0huWlFnK2M5TG1Za1pxU0RFZ3pJcHBH?=
 =?utf-8?B?ZFVzWXhZTE5HNTBuOTkwN0ZhNzQ4RzE2dVJnYU5zaDN0Q015V2NPWTQxa3NK?=
 =?utf-8?B?b2ZQNHZaMDhrQ3BkVWZBVzU0a1VnMW5DU2lNdTl6aXNwcVBkZ1B0ZElVWC9O?=
 =?utf-8?B?THhBSnlWVE1DazFsWXZjdWJYdlJtc2NBODJ0UTd1SEpZK3A4c3c0aURXd2V2?=
 =?utf-8?B?SGI2M2E3dFJ4ZHdLMGdmMDNUZ1REQzhGTWc2UldhNnR2Y1FGcE1IN1lKdWdB?=
 =?utf-8?B?MzZZVDk5OTNPQktFeGdHM2UzYzZRMkdpOXo0RUZtVy8zYWtieUJCSUxucEdP?=
 =?utf-8?B?WEQ0QUo0RlVlcjM5ZER3a281VnpBeFViMVpRUnJDZGc0MFQ1NVBBMDNEc254?=
 =?utf-8?B?d1hHOUVyT3lPWHRaaE41cEp3Vi9GSW5aU3R6ckpaVVVtZCtKbnkxdUE0d2xL?=
 =?utf-8?B?clRtbGcyMWJSL1ZGVHpobk4xRFduUkpXOEl3Q2hjV1pVbGpsbU9pVlFpK1dy?=
 =?utf-8?B?bXIreXBNU29XODlaaWYwemNRMFdPWXNPWndnRmU5eG42cW5Bc3NvOGh3L2Vk?=
 =?utf-8?B?TUtObndyUFROMmdvcEZiK0UvajFRRXhmeFBRdmFCSnlIY0o5R2E0cXpsY3l3?=
 =?utf-8?B?dWdZR1FJazQ4dU5oUm51NjVHZkk0N2pwbG1WUGtLT1R5Mms3K0RORHFVSncv?=
 =?utf-8?B?MUZGWWRXM01ERk5FdU1jbGVmc3p5TlkyMVh4b1RuRW5qT25qVkNYbFhKZWZk?=
 =?utf-8?B?aWlEOW54ck1xSnVtdmlEUXZiNEF0Q2NHUUdJOFF2UlorUGwzaVBzVHoyRVRx?=
 =?utf-8?B?ZFBvSnNodDBlNEU0RXlzYlRkSDFZNmdBS2l4Um4yNlZHSmxZeXVING1Sa2ow?=
 =?utf-8?B?RmswZ05USlFVMWY3c0phNVU4YkdhR0JjR1Y3Sk5ubktld2tpT01HQ2pDYkZt?=
 =?utf-8?B?dmNkWDJpMWg5M2R1aDVVbG9nelFiRjE1eldvREMxZUZTekFyYkhVZHpVQmR4?=
 =?utf-8?B?ekdkcG03TlZOUk1vV1l5aXRzSldJdDBkNDNPeWxJVy91Mm9kOXVtQS9SVzIw?=
 =?utf-8?B?bHhCMm00SGpiVDNWWHdIbmk3Y25FZnBhVXJvQk5QWVZwZ1FGOUV3V0dqNzdT?=
 =?utf-8?B?eW1XR1lJSmN1TzNnRjFycld0bkN3bThWcnYySTJYSXcyUXlnYUwzMnIwSDJV?=
 =?utf-8?B?eERUcGtFRHNWVjN3L3hpT0tER0t4bFJiTGczNVM3QlJtQXQxY3h0RVhqWVd3?=
 =?utf-8?B?U3BHb1VPRnZ5K2MyVDRZdndPUUZsOXlpQnJlb2o3dUowOTZiNys2NjUyZ3E3?=
 =?utf-8?B?aURyQmhiblJLOURya3NTdVFMdi96VE5STFU3MEl0b0treG1Nb0xqa1ZJdVFD?=
 =?utf-8?B?ZGl3NXRUZmRYVUpTamFxOHhQYWtUSithSndlT080WGdEdDZMUWRSRDZGUjVZ?=
 =?utf-8?B?L2JSZ2k2V0lKM1RNL0FDQTZXS2hxL2tPa2RSRXpnZVRxT0w3Si80dHhCQm5n?=
 =?utf-8?B?ZE04RkV0NVFlcXdCenhUVEduREM4Ulg4c1RZK2xDODhQWHdYMzhWd2hFRjBa?=
 =?utf-8?B?Yk5BOWVQVHB4QjMrVWhsT29jai8rTGpRcWE4TUFHQzdjcURiRElwZE9CT2Rx?=
 =?utf-8?B?Y0hxOW9tOXM2M0Q0cXJxcEdSRHJIV2FiT0YyK2FyZ1BwaGdFdVViTENUS3o2?=
 =?utf-8?B?ejA4ZVp6VmJUNEMzZjlSdUlzMWQxRXcvb3FQd1hKWmtnV0MvU1VFZGV6Y2Zo?=
 =?utf-8?B?bHdUZmQzenNYeFY4Z203MlUrdTl4M2x0VVE5Uzl0S3A0RW45eWVEbnI3U2c5?=
 =?utf-8?B?STVjVXNwS29KSjlZVEZXK3NIYTRUZGNnclFld1dybkc4QW1TdVhZWlNZenJG?=
 =?utf-8?B?MDQxSE1KWUN3ZDlvanFkNVNzUVdyczg0ZnRJd3R5VHBvVjRWajBVNFkwcUV3?=
 =?utf-8?B?K1J5bGFSdVN2Z2RLMnJnRHB2bGp5cXVkZmd2MTBYWVRIcElwTGszOTlGbU9X?=
 =?utf-8?B?clNqalZoVnNoZW1pSEZHcEtsK2xwN1VYQW1GNmV4MTFYbGtBNVY5MDJFOExU?=
 =?utf-8?Q?mKhrqFksr9ezLU4/yysQyU8G8?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EA5E6D630D8C944EA02E282E110AB39C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c55ddb4-d991-4311-279e-08dc685a2435
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2024 14:39:14.3021
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ygZvXdweu51sOppkq0/xtkp9KJ7ZZR/QdBbjlsQ7orlfPCQ02fvDeFEPYaa7cARC1E4l7hCkmmM7a0RogxIeJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5317
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI0LTA0LTI1IGF0IDEwOjEzIC0wNzAwLCBSaWNhcmRvIE5lcmkgd3JvdGU6DQo+
IFRoZSBUQ0Mgb2Zmc2V0IGZpZWxkIGluIHRoZSByZWdpc3RlciBNU1JfVEVNUEVSQVRVUkVfVEFS
R0VUIGlzIG5vdA0KPiBhcmNoaXRlY3R1cmFsLiBUaGUgVENDIGxpYnJhcnkgcHJvdmlkZXMgYSBt
b2RlbC1zcGVjaWZpYyBiaXRtYXNrLiBVc2UNCj4gaXQgdG8NCj4gZGV0ZXJtaW5lIHRoZSBtYXhp
bXVtIFRDQyBvZmZzZXQuDQo+IA0KPiBTdWdnZXN0ZWQtYnk6IFpoYW5nIFJ1aSA8cnVpLnpoYW5n
QGludGVsLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogUmljYXJkbyBOZXJpIDxyaWNhcmRvLm5lcmkt
Y2FsZGVyb25AbGludXguaW50ZWwuY29tPg0KDQpSZXZpZXdlZC1ieTogWmhhbmcgUnVpIDxydWku
emhhbmdAaW50ZWwuY29tPg0KDQotcnVpDQoNCj4gLS0tDQo+IENjOiBEYW5pZWwgTGV6Y2FubyA8
ZGFuaWVsLmxlemNhbm9AbGluYXJvLm9yZz4NCj4gQ2M6IEx1a2FzeiBMdWJhIDxsdWthc3oubHVi
YUBhcm0uY29tPg0KPiBDYzogU3Jpbml2YXMgUGFuZHJ1dmFkYSA8c3Jpbml2YXMucGFuZHJ1dmFk
YUBsaW51eC5pbnRlbC5jb20+DQo+IENjOiBsaW51eC1od21vbkB2Z2VyLmtlcm5lbC5vcmcNCj4g
Q2M6IGxpbnV4LXBtQHZnZXIua2VybmVsLm9yZw0KPiBDYzogbGludXgta2VybmVsQHZnZXIua2Vy
bmVsLm9yZw0KPiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZ8KgIyB2Ni43Kw0KPiAtLS0NCj4g
Q2hhbmdlcyBzaW5jZSB2MToNCj4gwqAqIFVzZWQgcmVuYW1lZCBmdW5jdGlvbiBpbnRlbF90Y2Nf
Z2V0X29mZnNldF9tYXNrKCkuDQo+IC0tLQ0KPiDCoGRyaXZlcnMvdGhlcm1hbC9pbnRlbC9pbnRl
bF90Y2NfY29vbGluZy5jIHwgMiArLQ0KPiDCoDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigr
KSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdGhlcm1hbC9pbnRl
bC9pbnRlbF90Y2NfY29vbGluZy5jDQo+IGIvZHJpdmVycy90aGVybWFsL2ludGVsL2ludGVsX3Rj
Y19jb29saW5nLmMNCj4gaW5kZXggNmMzOTIxNDdlNmQxLi41YmZjMmI1MTVjNzggMTAwNjQ0DQo+
IC0tLSBhL2RyaXZlcnMvdGhlcm1hbC9pbnRlbC9pbnRlbF90Y2NfY29vbGluZy5jDQo+ICsrKyBi
L2RyaXZlcnMvdGhlcm1hbC9pbnRlbC9pbnRlbF90Y2NfY29vbGluZy5jDQo+IEBAIC0yMCw3ICsy
MCw3IEBAIHN0YXRpYyBzdHJ1Y3QgdGhlcm1hbF9jb29saW5nX2RldmljZSAqdGNjX2NkZXY7DQo+
IMKgc3RhdGljIGludCB0Y2NfZ2V0X21heF9zdGF0ZShzdHJ1Y3QgdGhlcm1hbF9jb29saW5nX2Rl
dmljZSAqY2RldiwNCj4gdW5zaWduZWQgbG9uZw0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqc3RhdGUpDQo+IMKgew0KPiAtwqDCoMKg
wqDCoMKgwqAqc3RhdGUgPSAweDNmOw0KPiArwqDCoMKgwqDCoMKgwqAqc3RhdGUgPSBpbnRlbF90
Y2NfZ2V0X29mZnNldF9tYXNrKCk7DQo+IMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gMDsNCj4gwqB9
DQo+IMKgDQoNCg==

