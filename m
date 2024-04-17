Return-Path: <linux-kernel+bounces-147836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D2BB98A7A46
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 03:58:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 381FEB21319
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 01:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2C9B4690;
	Wed, 17 Apr 2024 01:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="moZ9hSgS"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24F91860;
	Wed, 17 Apr 2024 01:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713319075; cv=fail; b=CVZSzWfWiIDtL6uCjEYIYMnMIXnNhlXnn+zeNdWcOix3PDakQK7XYaCF4Ik3aI8dXBCXhgd1Ghia1rdS4GZ8+ct620vk/VCtmQ6OkB15S9to+HnJpjg6JvXKP7dTiPkaQTikxQMmhP+fxAYw2T5gi6xGHDbAC5WLk2SphbGD7M8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713319075; c=relaxed/simple;
	bh=ts6pLt6cNdJBmWERiohYYItcQpwA1XISEbTwuAgLGEo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TWlxyZm0VChIkK8XNJSdRZ86nmL1uWYBcuDj59v/sj8Fby5PHLKsv7nRScqbj6vnmQCe6TfNJC+K1DYGR/pRuDGRs3xbIIsaoqkwYaq4ILAnXQXo2zDynnHglHC/dzDYI+hIdS0wKwwz1pFfyYyjoPsL3TYXIpo90wQpQfGBY8Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=moZ9hSgS; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713319075; x=1744855075;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ts6pLt6cNdJBmWERiohYYItcQpwA1XISEbTwuAgLGEo=;
  b=moZ9hSgSgPjs+udVsXbSaebeahlB3T2s15so+hNHU0TetSuv4KZGk6Z0
   SWo9PoPb+Z1KYT0x4WN8lw80EwQJ/onq4Z6TSNxOfeEUJN+3Jdifi7fwT
   0xeXQ1N+ymdwCbhQIXORuKPXxg0+uyZ+cFZYlwB4VQ9EN40qHtlY5rTux
   H2EIb6GRLtMN1S87JCZIfJ/e6n7pIxWbkkIX6o8fepgt0WOQzpgC9YEZk
   0Jgi2yEruJ/aC1djMDiNvE+YrgvzZJiNqORbWDvcIYNZ2huIfESO7ijug
   YRPFWb1azHq881+KyM9sT5Gl/lXy+q+wpoER/z90GrSGlu3G2mMNUpRzE
   w==;
X-CSE-ConnectionGUID: cu+F7qjFSxCGzQqqpQMHow==
X-CSE-MsgGUID: oYKxui3RT4mIsb1VS0osMw==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="8919566"
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="8919566"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 18:57:54 -0700
X-CSE-ConnectionGUID: CtGi/V2dQvCt+Go2WpoQww==
X-CSE-MsgGUID: M1ipO1VZQUilnZyRccnPdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="22518136"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Apr 2024 18:57:53 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 16 Apr 2024 18:57:52 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 16 Apr 2024 18:57:52 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 16 Apr 2024 18:57:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dklk6YducdbVi02XddcRqUljXGtrW3PQ9cnNszmQnq6q7/kqiUAuuLatQQbpLFCC7bqaBLrk7ZECyjBJGby2G2X0uldaRFDkcXdt0s94DRPkn9FFpEwgwXAMiBxqqhhEtHnDDgLZnXQypoMiiTTJM1ByhKBO+R3xJw9jXrltX6nY6RPc+9KhXr67W6oC+7ovq7N3wzsWUgJkZx0+DXTBDZWFDRMFyVKLAUwUm1J5Vc067fG0XIpiKKS0tgBRHL9taP7dPPCZitk4x/bEbhvRWrUrDK1qOtvwRopG49AGTvdK/J0OYdWU38MLZrhVhKomhIdRgg/Dwjss/0QdDCjLlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ts6pLt6cNdJBmWERiohYYItcQpwA1XISEbTwuAgLGEo=;
 b=gKKEQyIjHyDN4fzxteB9jVqdIUe1WHPZwr8OoqUAHz8u4QYInchZj9PufdtUuqVXOy4yLkm1HMRsyES+Glw1OR04ON0zA9avh5gsut3RudaXCIcUYYF0KbdHo8tafesPO3tKtuUaZJNfbZM1ovTrLlyJ/cH/MKxWjZrRSvtuVEXAOF3c6/T6irPUbHfl2VSj1VbMnVVL+G3LiNch4qJQJAf5QQyChei6yxWZFhPoJ9yVdixkPJDq0M+9CuwBHD0Je/y3DjerIJHcUcyqkvqxLsT5fAT136iy0v/oUbuu7gNXlaLKdR8xSK+OrXERZJHCxSIC2vO63p7na6Jliqo2yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by CY8PR11MB6819.namprd11.prod.outlook.com (2603:10b6:930:61::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.49; Wed, 17 Apr
 2024 01:57:36 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::d5d6:c0cc:baae:1ba6]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::d5d6:c0cc:baae:1ba6%4]) with mapi id 15.20.7472.025; Wed, 17 Apr 2024
 01:57:36 +0000
From: "Zhang, Rui" <rui.zhang@intel.com>
To: "rafael@kernel.org" <rafael@kernel.org>
CC: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Wysocki, Rafael J"
	<rafael.j.wysocki@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Pandruvada, Srinivas"
	<srinivas.pandruvada@intel.com>
Subject: Re: [PATCH V2 1/3] powercap: intel_rapl: Sort header files
Thread-Topic: [PATCH V2 1/3] powercap: intel_rapl: Sort header files
Thread-Index: AQHaiWgmXnX9ta73/kax6EYXSptfqbFq+nuAgADH7wA=
Date: Wed, 17 Apr 2024 01:57:36 +0000
Message-ID: <45835aa25b4574732d8d4eb4dfd5b7f89af66f58.camel@intel.com>
References: <20240408035141.248644-1-rui.zhang@intel.com>
	 <20240408035141.248644-2-rui.zhang@intel.com>
	 <CAJZ5v0hF-AHY97y-Hz78=1MYGM4zHtOZ8U62NQBMMUNP4L-Kqw@mail.gmail.com>
In-Reply-To: <CAJZ5v0hF-AHY97y-Hz78=1MYGM4zHtOZ8U62NQBMMUNP4L-Kqw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|CY8PR11MB6819:EE_
x-ms-office365-filtering-correlation-id: eaec6dad-6a27-4b72-17ce-08dc5e81c12b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4xmGd+Qsw8evpgS1VdjIl3hehgbgZPi0VhYGMJfwVnwRWGL8w3skOXjRRpQmUTHI8YJPo/9liJb9NOhiqpIXU4ChYYj5cTZW+kF43wcAaDv/H/ACOs4C4usU2AiZvJcs/OcNbTm6XzBqEwEWNVT4htpIntKOvXC92rnwiijK+HBPBOB9o267aRyaazauciR7nl3G3vkOrDE6zSE7oaFho7Jw7OrJy8H7Pn7HRaKxLDegBCoCuHJE6e/4t+MdxLq+zAIb83dAhWGf3q3qra2TsfqgDcnMa1+nvRBRtOgP/YmfazfvYyD08jdjUZ6GC8enDWDHtXVtuEyG4eieNxbE3DSgV1l8lp7D8qHiJY8BrJSeeoyebI6SWock6eQsS0lGDM+ppTY9pcew8s27WLrC+r+ILU5bG0HO0Xql0sVCZJG9IenlTc3h3XxbB1ItO1ObZaWg3eqMNQdFHNd79SSgII+meJrn1P8bBfF6J0Upl5ErvZdYF6efa9EwTZQpnihlmO/8uYSD5h3SdkUOJmjlCryiHtvXRcUm9Xwxmg10PaGVSVSBQMjVY8NGH4TBiWKctAJUXtLdldk6wbKW4l7gBrwCmsOgmL4yOKQa8eg4EUfjz+CrQS1/GW2eqHdyXGE1D9A9cRSYcxHQpjZe4PL8tC4KwTlBDUA1w2/hb8HgK6GjxSnMTD4gEsrAB+RYEAHvNJCfqD9IzcK5p3SY8nS5QZQxrORx0PDsxHQ5xk396xs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L2VQd3FrQlZ6eXE0TktSeTNMVU9FV1pyc3dPbmNZY1NiZVhmcGN5YVV2S1M1?=
 =?utf-8?B?RU5WN2NRZHpNL0xxRU9wUEVtWjhpcmt3ZXpGRVBsUlJKTUVUb1kydW5ZZFhG?=
 =?utf-8?B?TXRHemJuWCtITkVZVkw4aXkzeGJKUjNlWXFSV3NtcGVtdk14c3NjUUZSWTdH?=
 =?utf-8?B?SlEzOUpQSURJYms3cFFvTzh3eXdkbTFaSVk4VExFRmpLZlhVb3VjTUdsQ0ZT?=
 =?utf-8?B?VUUwRXp6RmJoMWJta2RVekY4OHFyQmRJYWFRK1licmZNY1dOSnREdzA1TDZU?=
 =?utf-8?B?Um9pMmlGRTlhcUZWSFRQV3VMc3ZOWmFDVmZPNGlBdlAzSG5TYmtFUEZ0aGJB?=
 =?utf-8?B?RmhMUi9lNmlPODdQNEVEcTVRZjZQUXdocWhVL0RiN0xzbjF0NVZxeUxlaHhz?=
 =?utf-8?B?MHJSaWc0Z3c0UEVEbVB1TnBkQkIyUTN6WXpQek5mT0hkcnI0ekxmTnpSZkFr?=
 =?utf-8?B?QUVTZ2tqWGpVYkp0bHFOZFBPcjhkTnlOdGlNSTF2ZVVLeHFyQ0dSaEk0V09o?=
 =?utf-8?B?eGx4NHNBdFF2TjNiU0ZTem5zRW1aTHVmYytXVkFCaDh2R21hazBVUHpEcGli?=
 =?utf-8?B?cytqRWVDVEZwSVExbmJqYjhITVkzcjFiQzJRcVJNNlFKY1NlelFKQnVNUjFL?=
 =?utf-8?B?OFc4bHVKcGZtRkpwRVd3RWRPMzg0RU00VXBLdHg2UlZwMFJCR0RWaU5oRHB4?=
 =?utf-8?B?enNlWHY1TS9xUklCL2s1eGc5UmlrZzRCK1ZzU3ZkQTlFaHYwUVhycXZpTkZv?=
 =?utf-8?B?dGRGNlh4a1RON0M0bzk4bzl3dGczYlp4eHNwdEZsbGJLc21VbCtQNlZTUDNT?=
 =?utf-8?B?RVpLbFljWGlrdkdZUHBUaW9KZTRVcGpBTkliWnU5NlhBUnZvQUl5WW9yNndr?=
 =?utf-8?B?a2k3UEo2dnZ3azdBZ085STM5TEQ5SDlBTXBER3dnOVFCNyt5clNGUWVyZmdR?=
 =?utf-8?B?b09JR0Z4Ni9BVGpUQ085ckQ0bXZEc2xtUWpWUU1HOE1pUlk3eGJ0bjVRdzkv?=
 =?utf-8?B?MzNLR2VrcExxa3dVakNQNWs4YzFsSSttOFBPN09HSDR2azJadE0rUXFMcnBs?=
 =?utf-8?B?SzA3dCtoZWUxZWtXNU9NVHNPTlBlcEswa0dWYWsxZmR6a255MXBuYTRHVVVp?=
 =?utf-8?B?N0xvL0FvMytXeFVXbG1IdjlMeEZmQnEzdnRlT1l3L1B2cEJ5SEV5dnV6c29x?=
 =?utf-8?B?MU8rcDVNNzU2RUhPZUdKQUxrMXFWWUZ1Tm5aNjNTQTBPR1ZnalZCcVpWQVBT?=
 =?utf-8?B?K0RONzFUdEN0UU80dWFFNllOVDV6alRRcWI1WjVXOGQ5SEYweVZDdnZKY2dU?=
 =?utf-8?B?WUpSWExxRFUyWENFTFpURkx1WjFoNnNaaHJMRGdHaUFUOHRXUUkyRXhpZExK?=
 =?utf-8?B?cHNwQlZQSDlmaEkzV1lKUDFLZzBzZUpMWGs5SnF5TXFaTEs2ZXdaRXN5aGRk?=
 =?utf-8?B?UzZZRjNoZkJEMDJHYjdlUGJjUzI4SlVWR1czZUp1bDJtMExoTVVkQXdBMnho?=
 =?utf-8?B?cHhpV3NIMmVBN0ROeHdBazVzcXUzcDZoT0pRME5mUDVwbWlkU1JOZllrUEhr?=
 =?utf-8?B?VUVpSExCSDh3elh3TEk5cFhFTGxiZHphWC92eWp0enBJUVJhOXpxclRFTFNa?=
 =?utf-8?B?a1dBYTQrSEgySHpYZ3MxRVc1cEJQc0pZWmlJUlE3NFV1QlVMbVFVMnl5ZGtC?=
 =?utf-8?B?NWJ1ZkgybUt1TmlVWXpOazlWMkZEa1d4K0dGUi9TR1JVTWpqZmlkejh2OHRT?=
 =?utf-8?B?TWgzcmJxNUhLRjdVNWRta0lybi9mNFlqVThCOTZSVFBZMFdKWDQrSXNWRzBY?=
 =?utf-8?B?K0lXeVdudmZpZzgvVDV6alR4Z1dWMGg3RXZ2cytsOVpweEZJNmhQR3hmaUJJ?=
 =?utf-8?B?T3ZMRm5YSTlBb3RVa1JuVUEyWUhINXdtdWhTaVRCcUV6Z3JUcVNUQ1kxdXlY?=
 =?utf-8?B?NkxCY2FJN2wxdS81eDJTdWZmUE1UR1FOSGlQWFE0ekhEc3NyeTdUeU1jSEM1?=
 =?utf-8?B?bytPVzY4RkVBS2ZScHNLR09ydGRFbElsRlgwdnRpellNRG9OQ2IwOWwyTnJy?=
 =?utf-8?B?TDJiN1R3eE80NzBjQW9HRTJvbVBha3ZhUlFHREJEa2kwODYrVFdIc1RWajR1?=
 =?utf-8?B?d0t2VU9WSUdNVFd2WnpUbkFySXJjL29aN2M2Nm8wOEFzVVBOaTdBTXlrTnJP?=
 =?utf-8?B?U0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <254D539EE6607F4992E271034BAA6040@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eaec6dad-6a27-4b72-17ce-08dc5e81c12b
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2024 01:57:36.4311
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hSLNxTgI+P9csMvV9SF408ocFtX6M5UBKTUFGgpuEbxxAq3GC791bz7NcMBsTDiodggUfvYM0xp5GXOgQS7G7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6819
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI0LTA0LTE2IGF0IDE2OjAxICswMjAwLCBSYWZhZWwgSi4gV3lzb2NraSB3cm90
ZToNCj4gT24gTW9uLCBBcHIgOCwgMjAyNCBhdCA1OjUx4oCvQU0gWmhhbmcgUnVpIDxydWkuemhh
bmdAaW50ZWwuY29tPiB3cm90ZToNCj4gPiANCj4gPiBTb3J0IGhlYWRlciBmaWxlcyBhbHBoYWJl
dGljYWxseS4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBaaGFuZyBSdWkgPHJ1aS56aGFuZ0Bp
bnRlbC5jb20+DQo+ID4gLS0tDQo+ID4gwqBkcml2ZXJzL3Bvd2VyY2FwL2ludGVsX3JhcGxfY29t
bW9uLmMgfCAyNCArKysrKysrKysrKystLS0tLS0tLS0tLS0NCj4gPiDCoDEgZmlsZSBjaGFuZ2Vk
LCAxMiBpbnNlcnRpb25zKCspLCAxMiBkZWxldGlvbnMoLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9wb3dlcmNhcC9pbnRlbF9yYXBsX2NvbW1vbi5jDQo+ID4gYi9kcml2ZXJzL3Bv
d2VyY2FwL2ludGVsX3JhcGxfY29tbW9uLmMNCj4gPiBpbmRleCBhMjhkNTRmZDUyMjIuLjFmNGE3
YWExMmQ3NyAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3Bvd2VyY2FwL2ludGVsX3JhcGxfY29t
bW9uLmMNCj4gPiArKysgYi9kcml2ZXJzL3Bvd2VyY2FwL2ludGVsX3JhcGxfY29tbW9uLmMNCj4g
PiBAQCAtNSwyNyArNSwyNyBAQA0KPiA+IMKgICovDQo+ID4gwqAjZGVmaW5lIHByX2ZtdChmbXQp
IEtCVUlMRF9NT0ROQU1FICI6ICIgZm10DQo+ID4gDQo+ID4gKyNpbmNsdWRlIDxsaW51eC9iaXRt
YXAuaD4NCj4gPiDCoCNpbmNsdWRlIDxsaW51eC9jbGVhbnVwLmg+DQo+ID4gKyNpbmNsdWRlIDxs
aW51eC9jcHUuaD4NCj4gPiArI2luY2x1ZGUgPGxpbnV4L2RlbGF5Lmg+DQo+ID4gKyNpbmNsdWRl
IDxsaW51eC9kZXZpY2UuaD4NCj4gPiArI2luY2x1ZGUgPGxpbnV4L2ludGVsX3JhcGwuaD4NCj4g
PiDCoCNpbmNsdWRlIDxsaW51eC9rZXJuZWwuaD4NCj4gPiAtI2luY2x1ZGUgPGxpbnV4L21vZHVs
ZS5oPg0KPiA+IMKgI2luY2x1ZGUgPGxpbnV4L2xpc3QuaD4NCj4gPiAtI2luY2x1ZGUgPGxpbnV4
L3R5cGVzLmg+DQo+ID4gLSNpbmNsdWRlIDxsaW51eC9kZXZpY2UuaD4NCj4gPiAtI2luY2x1ZGUg
PGxpbnV4L3NsYWIuaD4NCj4gPiDCoCNpbmNsdWRlIDxsaW51eC9sb2cyLmg+DQo+ID4gLSNpbmNs
dWRlIDxsaW51eC9iaXRtYXAuaD4NCj4gPiAtI2luY2x1ZGUgPGxpbnV4L2RlbGF5Lmg+DQo+ID4g
LSNpbmNsdWRlIDxsaW51eC9zeXNmcy5oPg0KPiA+IC0jaW5jbHVkZSA8bGludXgvY3B1Lmg+DQo+
ID4gKyNpbmNsdWRlIDxsaW51eC9tb2R1bGUuaD4NCj4gPiArI2luY2x1ZGUgPGxpbnV4L3BsYXRm
b3JtX2RldmljZS5oPg0KPiA+IMKgI2luY2x1ZGUgPGxpbnV4L3Bvd2VyY2FwLmg+DQo+ID4gLSNp
bmNsdWRlIDxsaW51eC9zdXNwZW5kLmg+DQo+ID4gLSNpbmNsdWRlIDxsaW51eC9pbnRlbF9yYXBs
Lmg+DQo+ID4gwqAjaW5jbHVkZSA8bGludXgvcHJvY2Vzc29yLmg+DQo+ID4gLSNpbmNsdWRlIDxs
aW51eC9wbGF0Zm9ybV9kZXZpY2UuaD4NCj4gPiArI2luY2x1ZGUgPGxpbnV4L3NsYWIuaD4NCj4g
PiArI2luY2x1ZGUgPGxpbnV4L3N1c3BlbmQuaD4NCj4gPiArI2luY2x1ZGUgPGxpbnV4L3N5c2Zz
Lmg+DQo+ID4gKyNpbmNsdWRlIDxsaW51eC90eXBlcy5oPg0KPiA+IA0KPiA+IC0jaW5jbHVkZSA8
YXNtL2lvc2ZfbWJpLmg+DQo+ID4gwqAjaW5jbHVkZSA8YXNtL2NwdV9kZXZpY2VfaWQuaD4NCj4g
PiDCoCNpbmNsdWRlIDxhc20vaW50ZWwtZmFtaWx5Lmg+DQo+ID4gKyNpbmNsdWRlIDxhc20vaW9z
Zl9tYmkuaD4NCj4gPiANCj4gPiDCoC8qIGJpdG1hc2tzIGZvciBSQVBMIE1TUnMsIHVzZWQgYnkg
cHJpbWl0aXZlIGFjY2VzcyBmdW5jdGlvbnMgKi8NCj4gPiDCoCNkZWZpbmUgRU5FUkdZX1NUQVRV
U19NQVNLwqDCoMKgwqDCoCAweGZmZmZmZmZmDQo+ID4gLS0NCj4gDQo+IEkgY2FuIGFwcGx5IHRo
aXMgY2xlYW51cCByaWdodCBhd2F5LCBzbyBkbyB5b3Ugd2FudCBtZSB0byBkbyB0aGF0Pw0KDQp5
ZXMsIHBsZWFzZS4gdGhhbmtzIQ0KDQotcnVpDQoNCg==

