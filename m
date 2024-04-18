Return-Path: <linux-kernel+bounces-150182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FAE18A9B70
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 15:41:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40D37B212FD
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 13:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F98A1607B1;
	Thu, 18 Apr 2024 13:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AE9oIhUZ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F330069DF5
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 13:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713447691; cv=fail; b=lwB19KuNygRQWA6HSRXWp9VFm9aReAZvuCg7ffAUmpMrFj2pTfsoA6NMK94SYniFGEPy+uTaBlzYM++B2VumkBBgI8QwCJpxY7SqiJTLWeCpN95TBfV4MQCqmG0KKGjadHhkJ/KFDI2xXWb/I7iZTu31nIUDO75QGLq30ZDnkU8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713447691; c=relaxed/simple;
	bh=fUZiJc6+3V9ZwumdKakmjbOJ9Eak23T7NMnOCO8uxUM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Y/RM8xta4IUqKx9V+1oCw9gIOfFo2uActkx3X1D33Gfk/CKeDtliHoBVvmwqVqOTeD7DKLj31JGankMNk3aJQLwn9PfrEtiyTo2qoJtgvBztbkziw0RTi3a2+dMW3JvD8Wh4xYAuAGrbg/q64XUiX3D+9qOVmAfm7GU8RsudFIM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AE9oIhUZ; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713447690; x=1744983690;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=fUZiJc6+3V9ZwumdKakmjbOJ9Eak23T7NMnOCO8uxUM=;
  b=AE9oIhUZ4EMvhJwmpCf9S5jlre3od455bCwNZ/Hk7HNuptSKywb0fHvT
   nqHFebSz0KDCVpF+ysx3l4cikI37IDJS/p8uUFTyuy7TceW7vt7ndJ+dQ
   1wN/fLu1SLquFJxFC410e8pZlWwqAYDYhvG3QBAnA1N1vuNW6p22uTFlo
   1iiPMPVOwmxYeiFTOi6hNYWjSWZ/NnxF7W2fYshjUNvxwG2SQzGbUBYW3
   UZ262ZOxpeXuc/mM+Lwdo0kUrxALhm4/FSeKt5zYSMsbkA7URABn5nPZL
   XR9qqTVt4x/0zY54TOMeWeh4cWM82zZBnLT5yoAVtL6vauEe2XyZUBCVU
   g==;
X-CSE-ConnectionGUID: EwVTH1o0TW+w7yfxso53CA==
X-CSE-MsgGUID: J4GN2R16Q/C97CGLI8DRbQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="8829221"
X-IronPort-AV: E=Sophos;i="6.07,212,1708416000"; 
   d="scan'208";a="8829221"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 06:41:28 -0700
X-CSE-ConnectionGUID: TpeUg8nqR46WqvcXV6xfig==
X-CSE-MsgGUID: Nbly4tVeS/6IfJZKQlyCmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,212,1708416000"; 
   d="scan'208";a="27654679"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Apr 2024 06:41:27 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 18 Apr 2024 06:41:12 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 18 Apr 2024 06:41:12 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 18 Apr 2024 06:41:12 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 18 Apr 2024 06:41:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AXUVad5juYycwVXVP7sJolriKAExhIwnBarldN/ELAi6xa18EZjBNMAb23LuvyaC4iZ6xjXbhOqrD1XiXuDRrHtTqyk/3svttSgpVTtIZ9YWaXISLAF/h/gvkmB4/VPLUMWE0NGXVQ8DL4uQrJCJISJxiIYyMC7rBl28XwZA1NhLcnSfZp8RryqmXY06l/vnXe8buTS/Usz4yRNVkigLJv5RQAXleVrIcGmZbYEIMRok/azQ6QiHsYaSUwDEWadv9xLNoVuocvloIVwN8Oru+GVcqdKrfROCqntBJNtg79/Q6E48aW9xBIoKAAQsunaroV1lic4iKD6Fz1VwzePRtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fUZiJc6+3V9ZwumdKakmjbOJ9Eak23T7NMnOCO8uxUM=;
 b=ZXvLk7Icg1hezCh8qvyPbbBi5uRwhmMY6P5F2NaM0hTaZLXjcU9FPUdySjYsDLdtzj5E/NAWuz5uBHl3sHQoRj9juj9wcte+/unHMTJn4S6hktHgMd3IkCsmXuCSDMV2RG8jUhTD+tsjSdcjhQz++IoAv4P5nmUH8p9FsdZr0vy6GdVHAY3PC2cYkOQb3D7/y9xH13eUjjCxF1pclHEYWGRDHg5EQs0toFebShvCJR234sfKbWF+KQCFdqHH59pGNaJ1N3El+BfCjAqaVqrb4w6apvMjqRF0b8FysN1OaRY/KnWdAYUXsDnskDgQN5D+bT3xTM5eglINTHSKZwla5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH0PR11MB5330.namprd11.prod.outlook.com (2603:10b6:610:bd::7)
 by DS0PR11MB7287.namprd11.prod.outlook.com (2603:10b6:8:13f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.28; Thu, 18 Apr
 2024 13:41:10 +0000
Received: from CH0PR11MB5330.namprd11.prod.outlook.com
 ([fe80::5627:e6de:5e36:aacf]) by CH0PR11MB5330.namprd11.prod.outlook.com
 ([fe80::5627:e6de:5e36:aacf%6]) with mapi id 15.20.7519.010; Thu, 18 Apr 2024
 13:41:09 +0000
From: "Winiarska, Iwona" <iwona.winiarska@intel.com>
To: "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "openbmc@lists.ozlabs.org"
	<openbmc@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "andrew@codeconstruct.com.au"
	<andrew@codeconstruct.com.au>
CC: "billy_tsai@aspeedtech.com" <billy_tsai@aspeedtech.com>
Subject: Re: [PATCH] peci: aspeed: Clear clock_divider value before setting it
Thread-Topic: [PATCH] peci: aspeed: Clear clock_divider value before setting
 it
Thread-Index: AQHakM4OoRtzkiZz+k+V1Bv817O2JbFtIAOAgADqgoA=
Date: Thu, 18 Apr 2024 13:41:09 +0000
Message-ID: <7520ac6ef7afae66f9b1636e5806ff2bfd93584d.camel@intel.com>
References: <20240417134849.5793-1-iwona.winiarska@intel.com>
	 <7b0ef5c90138e8c1d1829de249a480709170141b.camel@codeconstruct.com.au>
In-Reply-To: <7b0ef5c90138e8c1d1829de249a480709170141b.camel@codeconstruct.com.au>
Accept-Language: en-US, pl-PL
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.50.4 (3.50.4-1.fc39) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR11MB5330:EE_|DS0PR11MB7287:EE_
x-ms-office365-filtering-correlation-id: 87840284-c3d8-4293-ae82-08dc5fad34ba
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WK66cEql+byuiBB5BnoFCtg2ki7iYJ1Qd9QxShVNB0dwgW3Y/Ky7JTf3sPdRQCX6FFPDGr9LdmsE/Y+LAV1V91W1EDOlBgL3hR6vKZohJHxzjXsu9xFHIuPQxsNCFzAUNSjThyh1JobJ+cLm1Zz0fvwfCgMCwXFMmrF5HVNq/5r9CankhMUsdPTEd/mx8bnmTo1ZCupuja92tVKkgzAo1VWwWeeOqKdM2Z1Inwuxig82CefbpwmufPZgFySnTFim8Jgm53a1XHZzrsZ7Tf6ykT2N5wwKXqn/JvvtHNQ/xBnoHJmkh7JGW6CGcmQ8sEG9FgF8JvHM8b9S9CptyWDFWS4YmjrqT7UIiWD40SPJrXpFz8DHrYWKUSDDgA4rhZ2wXuDZuoGJL82xOxg4P2bigKo4Rq5ic0MM5YCjquKWL2E0710OvpbdDv6giIc0xJHcwC0TwQ+6dehLQw5eJ9yl1KhmEK0u05kPr785Bf+VdBPpA0FvxrhlTGdkU0ylaqjpS3DYojZuarinGZ9Qx3lIxW3XU9OjnqGWKss1AB1CitWVnfla4Dp4te8X1hVUGXIt45sFuowky2llmb3oQSier5H6n5AAsYNqOMaDb4Q41C/sC5+zXrLUDwm91ZmT77AlKdmIogytPltHMTg8x07Nby4AWOn5a2qw1R+FQx7hwZDbmwf4xVCNjuoH71E5BxwaRfAgrRZ/XqJc928Emvst0FYpPl8rbKWtEj7x51LGqRQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB5330.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VHJTSTcrQlVlLzExYTdlbDd5S1BTSWhFM2dvY0V4Smlzc3BwSklRWEorbGph?=
 =?utf-8?B?Q0lIYjR0b1dOa0pZeHBKa3RuWDJmY1NJN0tzbXVqVjBVSU1kWWIxemVINzRv?=
 =?utf-8?B?ekpUak5oVnBQUHNjN241MDRkSDEyRm1xZm1GNW5aZ0xwbmVJU2NhT0ErN0FL?=
 =?utf-8?B?UXY3NTZsUUl3OU0ybGkvQ3gzVU5NQ2huUjB6SnBxSUlDcklmekZielcrancx?=
 =?utf-8?B?NklGNXVaajd3L2tZdTg4REJLWDUxeXR6VEdxRDFmZUtFSDlUOTJQYm5lUjR6?=
 =?utf-8?B?dXFPY0ZJb0JaWmo3emFyeVRxQ3diTnExRkxTOWdoU3M0SWJ1REZ3VlpJTk1j?=
 =?utf-8?B?cUY4OUhpdldYcTVoL2VabkFQTml0ZmZ0SVd6RzhnWmV3VFZTelkwbFJXakRI?=
 =?utf-8?B?dXYzUWY0RDdXcTNWb2pKWFpvRzUxU2ZqbXNCSy9GYmx4dTAraUtmZ3d5QU1F?=
 =?utf-8?B?dXdrSlRxaVZzMEM5emxYdWJvSlp6ci8zb3Z6alFaaWtGdzFJMnRRbXFGTzJY?=
 =?utf-8?B?YUpIcXJveE9aeGdLZCsvSHg0SlZxRjNKeVVnejNORWsyU0l4NndrR29NYzJG?=
 =?utf-8?B?MGR5MVlxVEZHL1NhMkErYUNEOTBTSDEzZWx2WVRHU3ErMmVqaGdzbU8veHQ4?=
 =?utf-8?B?WWpDcjRhcHUzbkFOdEk2RXdPRi9ab1hZU2FvYVliQ0lGdTB4U3Q3S0UwY3Zs?=
 =?utf-8?B?OVR3OFAxV3ZIYXpaeFRNUDdzMVlrMlROcDNNSGh4aWlKbkpHTFM2SkFOSUNw?=
 =?utf-8?B?NU9DNUJuTEp5QkUrQm9icHdYQVZKdmI0ZnNOTmFvY2c1MmlNVWtJVGZ2QlBu?=
 =?utf-8?B?NlkxK1NvcHdObmFwWHpLUlhLV2tjam1FL0dBcDBINVYyU3diZ0M5U2NyYzVh?=
 =?utf-8?B?YlEwSUFZR0Nmd0JqRmNOQkRhM0RweVBmVVdMUytPdkhCTFpaeHEvMWo5K0w5?=
 =?utf-8?B?dDgwSlBkYjBIcE1QNFpTTEZveVVTZk81cmNXajRvSjdWcngvUGJtYW1nckxn?=
 =?utf-8?B?T1lyc2VvMW9mR2R2dEpma2t6d3F5dXVYSlVJYUgwVDBCR3dsNXdXT09MNnlG?=
 =?utf-8?B?RCtsa2czMnUvSHppQ0JVZzFTSHNYSWFPZkpaMHhzVmoreXJQQVRjSW4vanRC?=
 =?utf-8?B?N3ZOaGI2SS9DMlNDcTFVV1VTUHNiQ1VuWVFtVC9YSnJnOE53Qk5NUXBWTE4w?=
 =?utf-8?B?R2FsdUwyT1BjczB2NmRxYjR2eDNPa2dXWXlrNUx6a1VRcVZMbkY2akdzbVZW?=
 =?utf-8?B?dFp5R2xDM0JRQ1lGVFN0cDF3cGUxK1Y2VTBhTkovNEdJNFFwMWlXdVM1ckZK?=
 =?utf-8?B?NDFQa1Qvbi81aXhWWk5XZ3FlbXRJZkp6Njg2Sk5DZkJwYkdKZStndFBSK0Fp?=
 =?utf-8?B?ODdQdWU4c3pQTmVOWkRoK0xrN0R4RmhxVllMQk9oczZUb2FiTllFS2g4bVdD?=
 =?utf-8?B?WEZtazRwRTJqSGozUkh3MVlBd3NGZDJOZjhhVGhLMnFiNE5mdzZPQ2JORlZI?=
 =?utf-8?B?STZVOHpMajcxWDVkQndZWGViUUppZGlNTk5mL0xXZUI0N3czNGEwa2trTTNQ?=
 =?utf-8?B?U0tRQjhDbnpWTm1sM3YxRktWWFZLWFVsdm9Bdk13S01VOW1qR0QvM1RJT1dh?=
 =?utf-8?B?cStOa2xyZzJrMHdrRHNDYUh6YWhxUnRnTHZ1QVFhY3ZPTUtZR20wSUFlRWZJ?=
 =?utf-8?B?WXA0N3lrb3VzaTFzMHJ0NWVoL0s1bjJDM0c2dGVwUFJSSGFyalMveUVhc3h5?=
 =?utf-8?B?bWZwZ2VWdlZIUkNhR01IQW12eWpOSEpsUVhCK2RPYlRWQ25uZE1Qemc0Uk1F?=
 =?utf-8?B?RVJhMU4xK1hHZmUzNHFSWEl5SlR2dk9MbVNPWkJacHRVaHptc005TGpOcmRD?=
 =?utf-8?B?QWxlOUx0SVgvSVM4WHZweTFPWENucGpQblZoVGVvUG5RUUVmTDhEVnhCYktj?=
 =?utf-8?B?WWpYSmxqLzVVbWhmVkdYQWxxZzlhTnFBWm5Wd0JMTTUxQ3JPSlhLaHJDNlJ2?=
 =?utf-8?B?L2RMaFVML1lYMnFDTVpUUnJ1NWlxaC9XaFljVFpXTGR5QXhvY2wwM00yNEVK?=
 =?utf-8?B?SDBBMlE3TXNIUGp0ZFpaUmxaZmVTSU4vbVdMYUFJcit0WFdtMTUxRzFnSG9T?=
 =?utf-8?B?YW1LNmo5eEpnRDErQm9XT1ViRWFZWXB4clpYR2tUTDJ5NytQYWR5VG05RzZY?=
 =?utf-8?B?cmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7C440F0BD0753646922E83406A99103E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB5330.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87840284-c3d8-4293-ae82-08dc5fad34ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2024 13:41:09.8298
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HIppHwnX/nRcuPMSkWFlLpfMK4J0OD0x19XdGHtkQLl4+2JYg6645pxohv/io8R3/q+0wt/fy9BWAFfCXPszpzli89jDuPYHJG9QhhVTWI0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7287
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI0LTA0LTE4IGF0IDA5OjExICswOTMwLCBBbmRyZXcgSmVmZmVyeSB3cm90ZToN
Cj4gSGkgSXdvbmEsDQo+IA0KPiBPbiBXZWQsIDIwMjQtMDQtMTcgYXQgMTU6NDggKzAyMDAsIEl3
b25hIFdpbmlhcnNrYSB3cm90ZToNCj4gPiBQRUNJIGNsb2NrIGRpdmlkZXIgaXMgcHJvZ3JhbW1l
ZCBvbiAxMDo4IGJpdHMgb2YgUEVDSSBDb250cm9sIHJlZ2lzdGVyLg0KPiA+IEJlZm9yZSBzZXR0
aW5nIGEgbmV3IHZhbHVlLCBjbGVhciBiaXRzIHJlYWQgZnJvbSBoYXJkd2FyZS4NCj4gPiANCj4g
PiBTaWduZWQtb2ZmLWJ5OiBJd29uYSBXaW5pYXJza2EgPGl3b25hLndpbmlhcnNrYUBpbnRlbC5j
b20+DQo+IA0KPiBJIHRoaW5rIGl0IHdvdWxkIGJlIGJlc3QgdG8gYWRkIGEgRml4ZXM6IHRhZyBh
bmQgQ2M6IHN0YWJsZSBpbg0KPiBhY2NvcmRhbmNlIHdpdGggdGhlIHN0YWJsZSB0cmVlIHJ1bGVz
LiBBcmUgeW91IGhhcHB5IHRvIGRvIHNvPw0KDQpIaSENCg0KVGVjaG5pY2FsbHksIHRoZSBpbml0
aWFsIHZhbHVlIG9mIHRoaXMgcmVnaXN0ZXIgc2hvdWxkIGJlIDAsIGJ1dCBJJ3ZlIGFkZGVkIHRo
ZQ0KY2xlYXIganVzdCB0byBiZSBvbiB0aGUgc2FmZSBzaWRlIGFuZCB0byBub3QgaGF2ZSB0byBy
ZWx5IG9uIHRoYXQuDQpJIGRvbid0IHRoaW5rIHdlJ3JlIGV2ZXIgcHJvZ3JhbW1pbmcgaW52YWxp
ZCB2YWx1ZXMgaW4gdGhlIHJlYWwtd29ybGQgc2NlbmFyaW9zLA0KYW5kIGJlY2F1c2Ugb2YgdGhh
dCAtIEkgZG9uJ3QgdGhpbmsgdGhpcyBpcyBzdGFibGUgbWF0ZXJpYWwuDQoNClRoYW5rcw0KLUl3
b25hDQoNCj4gDQo+IEFuZHJldw0KPiANCg==

