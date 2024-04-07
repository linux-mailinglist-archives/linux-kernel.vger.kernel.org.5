Return-Path: <linux-kernel+bounces-134256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F227789AFBA
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 10:40:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6FDB28310D
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 08:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88A4D11717;
	Sun,  7 Apr 2024 08:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tr6GAxOf"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E472E107A8;
	Sun,  7 Apr 2024 08:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712479197; cv=fail; b=pwGLurBWrARcfugInX2z07RuH0BrbHfRKS0s0vxFXgcY8YICdaqSSML94hqrVun3sHU+4U5XOedcO4zcxVrKMLLkMkTfYMczjKqgu+PuuAAxH3fD6qRxJvkpEuVd21qdbK8usymYiB/uXsoJEHOgdQQ7iWV3+3O1TdV5iAG2cqI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712479197; c=relaxed/simple;
	bh=TMlMl4FFAophxZR6YUe8Cz1r4uwGY0xXIUpTRZVjKF4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QtqGseKfsl3/HSYPhVeNeucsKeBQ4n2xTtX+P6iRohVOm4zmrFJdxqsU4GJYH5p9kgGAQG3XTOF6z4f1qgljT+IevXFP/Jwbh3douOB93MWnq3fBaBz8BCx4uWhk766yo5Dxqkw4wICGKXViRslCsGQajLmg+jrl8+4TZ6Cdx/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tr6GAxOf; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712479195; x=1744015195;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=TMlMl4FFAophxZR6YUe8Cz1r4uwGY0xXIUpTRZVjKF4=;
  b=Tr6GAxOfiX0w3IqrXT30XgyLcSYZhdAY8twj7HMrPI0BpEfmjwFkzjlR
   sXInEBaetwlGOIQD77OW6XpH5Xvma5sbYJNQ1HP2byyfnxEL0xEv2y+E1
   wXlPIbS8+UVOSXXLgRXIvIjju5IjcBGzuEXZ/evRKAiVwC8ARIqIiVJok
   vDFt2EOmKJNmrDVR5dL4fHEOW97XERK+7Dxha3rQe5gff7GHvt7joH3MO
   A1xzR0eHRAocbrfH9ePO0k9caSxBdixKGRIXJH/crQMTnubysFU1eDxo+
   iEkHlMquVxCB0BLBwrlfz9RDUchNGy/ZAjNIJCgVeFQBYG3Kctwt72/GZ
   g==;
X-CSE-ConnectionGUID: o3ERmVl2TKeRF5tca97Xzw==
X-CSE-MsgGUID: QKhzmGuoSBOUC97YnXY4Wg==
X-IronPort-AV: E=McAfee;i="6600,9927,11036"; a="7624797"
X-IronPort-AV: E=Sophos;i="6.07,185,1708416000"; 
   d="scan'208";a="7624797"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2024 01:39:54 -0700
X-CSE-ConnectionGUID: kPEGYUVqQ/KC0//7K9e0ZQ==
X-CSE-MsgGUID: Ai1LRbTQQrqR7GZqV6Gz6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,185,1708416000"; 
   d="scan'208";a="20022815"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Apr 2024 01:39:54 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 7 Apr 2024 01:39:53 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 7 Apr 2024 01:39:53 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 7 Apr 2024 01:39:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aHUKgefK5SA087RodaWcY6KxQvEEcP5fqpRAigIP0mn5zrksd15Wry/Byx48vp/uESRpw9oNYXGUsKaFm+qDO/TafeYiimXr6QF2DuKLgKKAfHs7lAgryNll/TdLI0oCSFbbgK63y+cozMQjpSUyQxCdWePsO3GpgmgqFbpBpUaphjssnhr9seDgDHRbbXX42PwISX8ymrTwXyd44LWdo5eCbAE7BC90Fw0LQoESwpFvB+qHE2tWuh6XLwHyFD/Sxip4YrFbxNzjfoUGcVbH6R9Ea1aroyCvySE932YlSnRNASrXvO+1mJl51gxEzhw56FVNHHD0yl+3Kpp7K88rNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TMlMl4FFAophxZR6YUe8Cz1r4uwGY0xXIUpTRZVjKF4=;
 b=G9x8W/T1s4cxZxPFRgavlFK8FqBg63kXKhwaWKKMPJS7K7Du14ruxaa1xMpk0DLN8FDgBJsl2upPUICcuqbTM5M/3ne3EJ0VdmiwaYZ8d+eOx7QDU9JZ9sjgx9WtMGmT5PCmJdAxGqVLRqqTFlziVKan0MghqccDygFb3emvZM3KexqssA65yaglcpPsvcwHZoNV0NmfRRWMmEZMmku5XkTNpwcYg7K8e+nR/JZ41/3p7JXCIS1o1WgC2bcoSlVi8ifQKa3q5LnYvmtLKbWjaqPeewgc7ibwCUT6qZgpVlItPm9xi9kbRFpJwKHbWik1qQ1NoVNHMy7GrQ9uk05kMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by PH0PR11MB5079.namprd11.prod.outlook.com (2603:10b6:510:3d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26; Sun, 7 Apr
 2024 08:39:51 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::d5d6:c0cc:baae:1ba6]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::d5d6:c0cc:baae:1ba6%4]) with mapi id 15.20.7452.019; Sun, 7 Apr 2024
 08:39:51 +0000
From: "Zhang, Rui" <rui.zhang@intel.com>
To: "linux@roeck-us.net" <linux@roeck-us.net>,
	"ricardo.neri-calderon@linux.intel.com"
	<ricardo.neri-calderon@linux.intel.com>
CC: "Neri, Ricardo" <ricardo.neri@intel.com>, "linux-hwmon@vger.kernel.org"
	<linux-hwmon@vger.kernel.org>, "lukasz.luba@arm.com" <lukasz.luba@arm.com>,
	"daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, "jdelvare@suse.com"
	<jdelvare@suse.com>, "srinivas.pandruvada@linux.intel.com"
	<srinivas.pandruvada@linux.intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Wysocki, Rafael J"
	<rafael.j.wysocki@intel.com>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>
Subject: Re: [PATCH 3/3] hwmon: (coretemp) Use a model-specific bitmask to
 read registers
Thread-Topic: [PATCH 3/3] hwmon: (coretemp) Use a model-specific bitmask to
 read registers
Thread-Index: AQHah72GbzYUSgau9UqJ7GYKY57P8rFbOfYAgAFE3IA=
Date: Sun, 7 Apr 2024 08:39:51 +0000
Message-ID: <d0b5ae04b4d08e2003114c4d6b6d3a040f585995.camel@intel.com>
References: <20240406010416.4821-1-ricardo.neri-calderon@linux.intel.com>
	 <20240406010416.4821-4-ricardo.neri-calderon@linux.intel.com>
	 <f4d18a63-c348-4882-897b-dc636feb149b@roeck-us.net>
In-Reply-To: <f4d18a63-c348-4882-897b-dc636feb149b@roeck-us.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|PH0PR11MB5079:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2lq1j3xtwK3IoRO2yD+QRUih6pxYRg+6HyH8lLXNGcNcCE3fMI24qMcC/kXSCmMpOa/8Ckl8nTEJCEqC+AcmI/A4bNKdkqyiK/00cxMYRhmd3UxkFWqKo8tBnb6RC9Gm8sx4vccpF5RaCrMN39t+h2pccsQDnu9XfgVfSfa4mGh+A/9VH6AMaTvUztB/+Wu7nLUTl81vGlaCZc+gD2Fhhf/k4CugJ0yFZoEZvSXyRVwLD4SG3hEVBZsMKL2xLTXFKg1NOR4PO+7BLZwyu7PnjOGbnFxy6hE2mmYtAsQJeEsx+5f/w6/7GVQcfLoTD+72/n3uex+qb75v9EM82y2M9gAbpJNU4PVBXVJK8g3lrvFcOfjyIgEpjVP4wWsXmMnTH/NIiiyK1sN50LZFuHZ+Oq4ebo9OJWcuGGXG19XCFgRBceO7KzLnqWZ1iIebWwxCOBU8IJGEK3g+kaTkYoBuIvaUbu+S28hTrzZGHvX2/TFFXwYQAJKJztbUPD+RJL3wLpo6DOxz+L702Quf5ST83nVxqBAATgZd72xTThlJX4nCDhbeNZkZEZzYG9RggqFTVY5jYeyiD3797lsakacM5d/hN95kNuKZ+4c0/PuGEnXvnL1Auml2PpzMUye/A2TE4lKV6ebSCY3yE7hhYLRhbQDQlseCJhsGQTij0KVjTPw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RUMxNHRKT3dmMit5ZnhjSkRpblRZb3Z5V24zUElaem1GUnJiTllVWnJjbkUy?=
 =?utf-8?B?Qno3d3ltdTVHQ1pXNUtyQXFIakxCSmVRcmtFTDFuSGNveGhQTk5YMDVEbmJ6?=
 =?utf-8?B?bXNXc1VadFVibEVVNnRIUFltakk4dHh2aVlNSmhhcDFjZHZaNGNoaTVyM3Vz?=
 =?utf-8?B?SVZueXAzTmltWXdoNzJqdW9BMzl2U2ZZZ2VrZnpxL0VBT1oxOUtkamVCWEc1?=
 =?utf-8?B?djFMV3QrejdIbU9EaU1veHdaUVdLa0dTV0VOTGJYVytRQTBxL0phSFRYODlv?=
 =?utf-8?B?MWxVREZOczBGVm1aZDZpYkRJcFY1VDFYeXRJZFpOZjB3dmRPN2dPdlNUYlpC?=
 =?utf-8?B?dmowWUhzYTJYM0puejZWblVLNGI1VzJZekJUcVowcnZ3dysrSldLMmpKQnRY?=
 =?utf-8?B?WlFDZnFYcUhlWFRCRlZaN0RnRmRPREloR3IxZ2hqZityOTNSajJVOE5sdE9O?=
 =?utf-8?B?Ry9hMjJsQitjcXl0U3NCV2FWU25xaXQvNzAxcUVza21kMlE5MEc3UW0rVUtK?=
 =?utf-8?B?T0FjZEtYUHhGQmVrYjRHQjFkdkQ4TENwMUhLM2QvV2NLUjFPVHduYk1GbEUr?=
 =?utf-8?B?akxDWFRuVGVxbldCYzI0cEcvb3BYaXBndW5VbzFMeVRwYnNBYmozRzNHSDBi?=
 =?utf-8?B?UGlFbUhtRHRhOFFWNlY1UFdYanA2RWJUU1FSL25QdkVsQ2E4ZUR5ZE41TWNN?=
 =?utf-8?B?NENKRDI0ZFBYRm9BeTc1U1NOaGZETlBsemsyVTRIRGNMbGNBem1SVEhLUXRw?=
 =?utf-8?B?eEdkNzVvM3c1ZUU5VWZMdG1FeUJ1RnRlVVRLaTRTdHpLaElZeWlUTThZUzYx?=
 =?utf-8?B?Q1h4NXRrUEFrdGtoWllmOTBLK1ozUERxSThoTU5QTTJuUEE5Z0g5eSt4aVVo?=
 =?utf-8?B?RGRsai9iNFZjYzZ4VU1Qa005dzdXSTNKZ3VQNGNyOTRuZHpEYmxqb2ZCaThn?=
 =?utf-8?B?ODV0eDlsSFF3ZGpHV3krTUdGcldXR3FkWEVpRldPZ1U1NWxPWTdCRlhmU2RT?=
 =?utf-8?B?NUVyWVEwdnFNN1JFWFpKQVlEWEpkTk5RNG50Vi9ra2FUdUk3YnByY3BNRlhy?=
 =?utf-8?B?M1VweVRNb2E5N1daQmdyS29qVzJOZ2V3TFUvakpyM0MzK0pJU3RNd0c4bk5n?=
 =?utf-8?B?RzA4d05wL1ZKcTRjdGtFcGJFU242VkI4b052OXArU0V0K2dwMlVRSWwvY1l1?=
 =?utf-8?B?MTBwV3NFQUZWejQ1cnJidTZMY0NtVndxVXlqc1c3RkppN1FtVVFLaWpPendW?=
 =?utf-8?B?ZGZibldXNWptQnJLOUZReU92MllyMjQ4WURoa1c2bG1wTVpMVHVyUEgzcEQ1?=
 =?utf-8?B?b01mWmI2NnpuaHMwdzJRU2NRdlBMYk9CS2hiVkRkRnNmSnFwNGRFUXNWUFJL?=
 =?utf-8?B?MkFzVHZORjJMbCtWTm1vUUpCbWdsZEhJWUVlcHBoVExKbnJ3SXVEN2loTUtN?=
 =?utf-8?B?N0YwM01RTTlZQ3RRZUJxWHlLQU1ETDVseW1VVUJvZjhMdXRBVnFydU1uTWVX?=
 =?utf-8?B?VXdNQ1pqdENtU1BGdS9wd0lFZnkzUStzZU8zcUZRZFA3TDlTNUt0MmpyUjg0?=
 =?utf-8?B?bVBwQzI2Y3diQTFFQ0x0UjBoKzZMVXk1VXBncjhwMXhxL2FObnZ1bXd0a0VD?=
 =?utf-8?B?NHVyY1pDV09lbVlzRXdVQnpZdGtud3NOeURNQlpzZ0J6TWxpNEROOXo2ZFVG?=
 =?utf-8?B?dkYwSkdFWVpwNWQzeC9yZUV0QkVINWFVeVFPN0FuMlByWFFKdlFmM2hZdGJK?=
 =?utf-8?B?VmtFbGV0SlpPUU1mNGVYM1o4OFN5b3RZanlXY3dnb2NPMEI4YVV0MEZ1dVBR?=
 =?utf-8?B?M3FkZnB5eklrdWxHRUdseFIxRGU0QUoyVXV6NHNxT0ZKUGliUHJLbXBJUGMz?=
 =?utf-8?B?MUpvTUdHSUQ1ZzFzMHFHeDBwNG1iQkJUOC9iNXVMR0VaT2hjR0NJVXRUbzAw?=
 =?utf-8?B?eW1lVmRad2F4ZzVBTUxIa1pvTXliWVFUSDJYZHJzbkZudHdNOFF0T0NDRFM0?=
 =?utf-8?B?b3lmK2RYdFlTcnIzbnM4UGFUaTAvYXRWWDJsc2dZT1pVLy8yMFdZbVhCV1d3?=
 =?utf-8?B?NlFiZ3Y2V0FYbStwMWswMG9yT2xEa0hRS1ZScGViWlJ5NGVzNzBxYTNOYkZJ?=
 =?utf-8?B?ZVpuWWs4MEFsblpjTkIxaGVwVGxmaU9NbU52dVkycjRHY2tBc2VPcStXZzRG?=
 =?utf-8?B?N1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <461BC85A23E2F44E99CB3B8A29818618@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcd11f04-b507-41b7-7ca3-08dc56de4a9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2024 08:39:51.3883
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MhTKPGbVfQgwrTqfRDeMTPfkfHqNcWlaZ26Zn/De716tFx9g/GE3EYB2ZX5Ch4LpEsOdHC3DOmn7uhWp1+M+1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5079
X-OriginatorOrg: intel.com

T24gU2F0LCAyMDI0LTA0LTA2IGF0IDA2OjE3IC0wNzAwLCBHdWVudGVyIFJvZWNrIHdyb3RlOg0K
PiBPbiBGcmksIEFwciAwNSwgMjAyNCBhdCAwNjowNDoxNlBNIC0wNzAwLCBSaWNhcmRvIE5lcmkg
d3JvdGU6DQo+ID4gVGhlIEludGVsIFNvZnR3YXJlIERldmVsb3BtZW50IG1hbnVhbCBkZWZpbmVz
IHN0YXRlcyB0aGUNCj4gPiB0ZW1wZXJhdHVyZQ0KPiA+IGRpZ2l0YWwgcmVhZG91dCBhcyB0aGUg
Yml0cyBbMjI6MTZdIG9mIHRoZQ0KPiA+IElBMzJfW1BBQ0tBR0VdX1RIRVJNX1NUQVRVUw0KPiA+
IHJlZ2lzdGVycy4gSW4gcmVjZW50IHByb2Nlc3NvciwgaG93ZXZlciwgdGhlIHJhbmdlIGlzIFsy
MzoxNl0uIFVzZQ0KPiA+IGENCj4gPiBtb2RlbC1zcGVjaWZpYyBiaXRtYXNrIHRvIGV4dHJhY3Qg
dGhlIHRlbXBlcmF0dXJlIHJlYWRvdXQNCj4gPiBjb3JyZWN0bHkuDQo+ID4gDQo+ID4gSW5zdGVh
ZCBvZiByZS1pbXBsZW1lbnRpbmcgbW9kZWwgY2hlY2tzLCBleHRyYWN0IHRoZSBjb3JyZWN0DQo+
ID4gYml0bWFzaw0KPiA+IHVzaW5nIHRoZSBpbnRlbF90Y2MgbGlicmFyeS4gQWRkIGFuICdpbXBs
eScgd2VhayByZXZlcnNlIGRlcGVuZGVuY3kNCj4gPiBvbg0KPiA+IENPTkZJR19JTlRFTF9UQ0Mu
IFRoaXMgY2FwdHVyZXMgdGhlIGRlcGVuZGVuY3kgYW5kIGxldHMgdXNlciB0bw0KPiA+IHVuc2Vs
ZWN0DQo+ID4gdGhlbSBpZiB0aGV5IGFyZSBzbyBpbmNsaW5lZC4gSW4gc3VjaCBjYXNlLCB0aGUg
Yml0bWFzayB1c2VkIGZvcg0KPiA+IHRoZQ0KPiA+IGRpZ2l0YWwgcmVhZG91dCBpcyBbMjI6MTZd
IGFzIHNwZWNpZmllZCBpbiB0aGUgSW50ZWwgU29mdHdhcmUNCj4gPiBEZXZlbG9wZXIncw0KPiA+
IG1hbnVhbC4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBSaWNhcmRvIE5lcmkgPHJpY2FyZG8u
bmVyaS1jYWxkZXJvbkBsaW51eC5pbnRlbC5jb20+DQo+ID4gLS0tDQo+ID4gQ2M6IERhbmllbCBM
ZXpjYW5vIDxkYW5pZWwubGV6Y2Fub0BsaW5hcm8ub3JnPg0KPiA+IENjOiBMdWthc3ogTHViYSA8
bHVrYXN6Lmx1YmFAYXJtLmNvbT4NCj4gPiBDYzogU3Jpbml2YXMgUGFuZHJ1dmFkYSA8c3Jpbml2
YXMucGFuZHJ1dmFkYUBsaW51eC5pbnRlbC5jb20+DQo+ID4gQ2M6IGxpbnV4LWh3bW9uQHZnZXIu
a2VybmVsLm9yZw0KPiA+IENjOiBsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmcNCj4gPiBDYzogbGlu
dXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiA+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3Jn
wqAjIHY2LjcrDQo+ID4gLS0tDQo+ID4gwqBkcml2ZXJzL2h3bW9uL0tjb25maWfCoMKgwqAgfCAx
ICsNCj4gPiDCoGRyaXZlcnMvaHdtb24vY29yZXRlbXAuYyB8IDYgKysrKystDQo+ID4gwqAyIGZp
bGVzIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+IA0KPiA+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2h3bW9uL0tjb25maWcgYi9kcml2ZXJzL2h3bW9uL0tjb25maWcN
Cj4gPiBpbmRleCA4Mzk0NTM5N2I2ZWIuLjExZDcyYjMwMDliZiAxMDA2NDQNCj4gPiAtLS0gYS9k
cml2ZXJzL2h3bW9uL0tjb25maWcNCj4gPiArKysgYi9kcml2ZXJzL2h3bW9uL0tjb25maWcNCj4g
PiBAQCAtODQ3LDYgKzg0Nyw3IEBAIGNvbmZpZyBTRU5TT1JTX0k1NTAwDQo+ID4gwqBjb25maWcg
U0VOU09SU19DT1JFVEVNUA0KPiA+IMKgwqDCoMKgwqDCoMKgwqB0cmlzdGF0ZSAiSW50ZWwgQ29y
ZS9Db3JlMi9BdG9tIHRlbXBlcmF0dXJlIHNlbnNvciINCj4gPiDCoMKgwqDCoMKgwqDCoMKgZGVw
ZW5kcyBvbiBYODYNCj4gPiArwqDCoMKgwqDCoMKgwqBpbXBseSBJTlRFTF9UQ0MNCj4gDQo+IEkg
ZG8gbm90IHRoaW5rIGl0IGlzIGFwcHJvcHJpYXRlIHRvIG1ha2UgYSBoYXJkd2FyZSBtb25pdG9y
aW5nIGRyaXZlcg0KPiBkZXBlbmQgb24gdGhlIHRoZXJtYWwgc3Vic3lzdGVtLg0KPiANCj4gTkFL
IGluIHRoZSBjdXJyZW50IGZvcm0uDQo+IA0KSGksIEd1ZW50ZXIsDQoNClRoYW5rcyBmb3IgcmV2
aWV3aW5nLg0KDQpXZSd2ZSBzZWVuIGEgY291cGxlIG9mIGh3bW9uIGRyaXZlcnMgZGVwZW5kcyBv
biBvciBpbXBseSBUSEVSTUFMLg0KVGhhdCdzIHdoeSB3ZSB0aGluayB0aGlzIGlzIGFuIGFwcGxp
Y2FibGUgc29sdXRpb24uDQpVc2luZyB0aGUgaW50ZWxfdGNjIEFQSXMgY2FuIGVmZmVjdGl2ZWx5
IHJlZHVjZSB0aGUgZnV0dXJlIG1haW50ZW5hbmNlDQpidXJkZW4gYmVjYXVzZSB3ZSBkb24ndCBu
ZWVkIHRvIGR1cGxpY2F0ZSB0aGUgbW9kZWwgbGlzdCBpbiBtdWx0aXBsZQ0KcGxhY2VzLg0KDQpv
ciBkbyB5b3UgaGF2ZSBhbnkgc3VnZ2VzdGlvbnM/DQoNCnRoYW5rcywNCnJ1aQ0K

