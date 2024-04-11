Return-Path: <linux-kernel+bounces-139885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49EF38A08DF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 08:53:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C8CD1C216DF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 06:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9DFD13DB8D;
	Thu, 11 Apr 2024 06:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P4n5PcNf"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B2513D8BD
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 06:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712818426; cv=fail; b=mFTUUl5QeOE/vo4/2oPzKKIoUeSRgDea55oYIBEL5ELBPJXo8BN+jYJI2grYpsxfleaHjv8fRQbz8idVhPEMwqYzRLrwbOIPIJmITmabBHhGoUceAjQHKEZkt8vpBFQ1hkziJa0rGA9hCt8/qfkaGKqB/VVTEcHIQdjbcdiaD9Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712818426; c=relaxed/simple;
	bh=vx8wAjjSeMaD0aFwIGHWPo1dxSeJA6CUP5SBybvtTHg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=teVPmqc0PozLGNmZpl5JdglBQF8DkocRmHWs/eO5VpsrbfuuhgeE9rIuzJH2AqnCIDtbFQzr7FNFV6b5/2YSb61blmKZ1Ja6W8W6t1+mHFg2n4hwgKGLua7Wh+EwV+sFJActghqMkCtXw5zZYjWUw8RxriAC81zPc+RYBqnsKK4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P4n5PcNf; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712818424; x=1744354424;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vx8wAjjSeMaD0aFwIGHWPo1dxSeJA6CUP5SBybvtTHg=;
  b=P4n5PcNfe5jM5mRgZCTz3ndE4j25khlAGxfO1Viy2sb0M6KXic1f90v3
   5MfyvOiNDwWcxk9qcxJhy9htZcOz9bEyAA1eVYddZMqjoDfYWqMYlHEEk
   E8tjG/NLerC83wNZ60sPyVFMou/s1IDDoc+zCV05+HSr7mjXD/v9hbDJ1
   78bDAzVAyo78c+4WMe4WhV1IBHopwraBk24Q+c9UTSEnpyqCwK9uRZyte
   clJr2MyE3MSclH08CbRwoj83ZzifznwYdK59n7yNemRA1O/9qQ/ktpO4S
   04zeDq4R6H73lhj4AF//DufIPyOnyelR2z0mAEjR13Nb46AMCccvo38ba
   A==;
X-CSE-ConnectionGUID: qrZwKf1UTnWZne2NuS58uA==
X-CSE-MsgGUID: tcxbHNYVQlWinUE1I7umPA==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="12063848"
X-IronPort-AV: E=Sophos;i="6.07,192,1708416000"; 
   d="scan'208";a="12063848"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 23:53:44 -0700
X-CSE-ConnectionGUID: cZ1rxpJYRPWYaM2EvkrHqA==
X-CSE-MsgGUID: OIzYc/eHRke1gMu8AE3hnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,192,1708416000"; 
   d="scan'208";a="51999895"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Apr 2024 23:53:43 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 10 Apr 2024 23:53:42 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 10 Apr 2024 23:53:42 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 10 Apr 2024 23:53:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AOM5ZCakhGEpWv0PwBz2Yy7sNg/b6V5nfKcvdQCng6+LA84nWljJ65j4jVnFJPvhCfGRnWUvxdI9//24MZ4nfeuTNKFJ5QL+PXJHx8d1VzXG5luJKWBBWLZMO6XiClJpH6prjBfQTYlbRMEKrruIgk+ZB0A+BQVS34WrV/GEluKuDUkofNuSz7HCKg/uQKBSDzkt7B7PtAfabHTG3QyQcFUpcM7m/p2H27uYwKfy93AD6dwGKpb6/7FCRro70+LO32T9/Ku5Qli9nsJB2WuqfunIDU27yiHkPJsSv7SQkjvQiGFzVJseBaVoV/A7w5aOTgbV/YUzlCnpqcPVQyVDVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vx8wAjjSeMaD0aFwIGHWPo1dxSeJA6CUP5SBybvtTHg=;
 b=Z2l7vXUDfv+08gh+6ccYQKikaymysnEz3fvI8L9EHMl4TFvNfy9cADwwZ/IPyoHRocoGaXgrj30LY80GzUacMUDDrHCLacQZ7uggJ0xFhhZgVIPDa9qjaV92MTTDL++C5xOkaiMQpyN+76rsegT7E+6rZ62RU03l6gJVMJH7mLwPcDQsmnS6GNFOkNeiruNK6sRWGA1/Tft2SvAqpja9czsbIw8cErF0ca8J8wJGztKgiFHqoSo98AuLangKueR2hlGfOtxvYuuL+awaVfAB3g2iLgeLElXtiStItiOROHETBsr4lrLc6+Cc9g37Xr6YM6KAV6tXLdcxkYHCi3qq4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH7PR11MB8454.namprd11.prod.outlook.com (2603:10b6:510:30c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26; Thu, 11 Apr
 2024 06:53:39 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6c9f:86e:4b8e:8234]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6c9f:86e:4b8e:8234%6]) with mapi id 15.20.7452.019; Thu, 11 Apr 2024
 06:53:39 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>
CC: Jason Gunthorpe <jgg@ziepe.ca>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] iommu/vt-d: Fix WARN_ON in iommu probe path
Thread-Topic: [PATCH 1/1] iommu/vt-d: Fix WARN_ON in iommu probe path
Thread-Index: AQHaiIkfDCiYXSWkLUGWnjJZsYe/DLFiZDkAgABEX6A=
Date: Thu, 11 Apr 2024 06:53:39 +0000
Message-ID: <BN9PR11MB52768106FE4890D6481E73178C052@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240407011429.136282-1-baolu.lu@linux.intel.com>
 <3674a075-d305-4cd7-be44-8d808f872249@linux.intel.com>
In-Reply-To: <3674a075-d305-4cd7-be44-8d808f872249@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH7PR11MB8454:EE_
x-ms-office365-filtering-correlation-id: 4d817771-e31a-435d-7b3b-08dc59f41e4a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PeYuC43mrkj2AH1yzUjZ7OdYIX3nqBuMUNxD8zVxKwUQkwNiJn33QUKfO39aaL7XVN9ynkBbd8DO2TK+Rdkip1Om2BVGVMmmPYlFBGTQUAbD2p3KPoaiEr7dmC7QOnjmUMCzruZfJoio7LgrZyVr5HrooWOlMDmlG/0rnuMKZHNFFdPFgzIhuY1zJaxkS+DBjCj0cd9v+69NWEEYdyxMgCrihl9kdgrXxx1vdYbJwIopmF8z4mLuixjn/Bb7umhXYVH4EBAj+uZ2nXqn7lZ8y2xnc+YYlakX9SJAIrA9gn6w+YEftUtLTxs8wjZ5SX9xgp7qyM4vGk+FJmbnButJWL3SzyksPmsja7O52IZ116or7hSS+qENKFIGj2yV6ufQ/L19gHrDLOJxlncRTzf7UrSKk2mo98C59Vz2zvsNvQKO2O+yB9y4R+gW91CJ2N8wnLZXNKQikpNffOTNTQHwhMZvoFk2mKuPJOhBQ4P8M8yz9Y08YF5xVmnS6gZmIN6opDK+mO5Oblr5QEGqlw6fcFwjyUJSYnQHmXoxzaYPaJZcEIh/m8Qa9u5C+7NlvYe1nftXKXwSRLVFFpaYOPjb3z//+IIyPfAvzM9b0g/8QXPWJWC94YPgE1P8Pm6WgT3+4L6C9QL+jHVtrPpjQ6u9pkLE8GLociVekrV5bIDEOd0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aENjUlFqTitjajhscXByWitCYVVRNVM5YWRBWnh5Z0FFUkFhWms4QVZKeXZm?=
 =?utf-8?B?OFE0Ti9VN3dGZXcxWWs3K1BSd0YyTThyL3J2WVR4UFloL1NhRHZMN2Vxa1pV?=
 =?utf-8?B?aGt1RjV2blhwVERQQmg4YytUWlJlc092Yi9HdWxoK1VvOWoyUjczTGxPOXU3?=
 =?utf-8?B?SjVsdGRNM25oNFl4YXNod2F1d0hVaXBmK0FhYThUdXhNWUVLbGtNVjJMTUdW?=
 =?utf-8?B?dDIzWkU4Z1lkbWY5UUpFbmR6TWdUSy9yZW8zc1Q5ZDh6Nm15aWtyNll3cFhC?=
 =?utf-8?B?OGt6TElta1ZwaUJhcjl0QjRENjRZd3M2YzVRR0wzQ0U2WW8wT1h3ajU2WDQ5?=
 =?utf-8?B?b0o4U0hlUzF2bWFES1c4c0VaejJnek9HQzM2dDdUTExXNEw5Y1RLNEIzWEdj?=
 =?utf-8?B?WjVMZmtRUkpidVo3bnhSazNzZFNBQzNscFlvYlVHQzNnZERPLzRnRlhqMURX?=
 =?utf-8?B?d2d0VXRnYWVlb2xpNzl3TERNSjkxUWhNQnhKa0VQT2RRRmx3UjU1eE9RQzBK?=
 =?utf-8?B?UDB1UDMvdWlab1UyNDRxdkFRT2FUQkk4eWl1TVFHMmVzRGdoNHlwOXo4R08v?=
 =?utf-8?B?eStoTjkrcVZBYzFBVmtoZHRrSE1Yd2NHOWZUc3F5VzRYZHNMS1RESE4xSGV5?=
 =?utf-8?B?NEVVUXFvclRTWFVxdkoyWUZsbkYxaTR4aTJlN0QzUXR1VzN5ZUpyOURIRkI5?=
 =?utf-8?B?dnBCdWtMVndHdnEyeVlqODZybjJMdDdIWXBIR0VZTlBZUVhqV2xZVUFFM1I3?=
 =?utf-8?B?RkFoSHYzNVVvUzV0NnlIcy96OWVZLzh0WGVqTlFUTTNBZWZFUHkvSFRnMHJ2?=
 =?utf-8?B?UjYyNldRcmdveXNKemVOdWtwV21sNFg0MlpLS1M0Yk1XZFo3YWN4OWhOUUgy?=
 =?utf-8?B?dWtBWVlrWHFUWFhhVTVTU0l3a1RENWZPSXNHTVpIWC9tZlB4Zyt0bXV1V3R4?=
 =?utf-8?B?aFo0amdBc1RWZ1h3OExNcHI3MW83TklYUk9JS1RkVkEvNlo4OWl6b0tzV0li?=
 =?utf-8?B?T05BTTBpdEJrTUdNaDc2NDlJamxOcDlJTkt0OHJGc2lrU3V6c3ZkWDJ1YUhN?=
 =?utf-8?B?dGNsNW9EdFFOT3JPdjRqb252RGRRZFREVHNMUjVRL21va0FZaEJ2b2YyM1BF?=
 =?utf-8?B?UTdLQlRkS1ZiVGI1dUZKQ09DcXZHL2JzdUc1ekljRisrL1VjSkkrRFp0Q3RG?=
 =?utf-8?B?Vm01b3BqYlcxYjhLUHFFSHFhVEw4TEs5S2I2ZmtqUkdZaUMrcEhzVWgwZTBS?=
 =?utf-8?B?TjI4TDN5dUtkNlhSN1ErNlZORmtmZC94SUdSWHhuMThiTm9wMG8zMnNLZWE3?=
 =?utf-8?B?MDRYMmxrSGhBZ3F4R0JsUXBLM3FUSXNxKzJIdStObFN4R3ZoSnpDRUliQThY?=
 =?utf-8?B?Q2RxYlNHM0JmR1JXWm1OR1hXOWFqWHdlSTY0ZURoY25TSGc0NXJ4K0VRc0VX?=
 =?utf-8?B?S0FPZGY0OVMvUERPalpUcU96aDYwaGU1cWtRRWRTMFB2UFBkdFVLMExaSzdy?=
 =?utf-8?B?dEJhK244ZS9RVlpBbVV1RTdIQ05hbVd1OWdpNmo1VnlKSE1NNDlONmlycWlY?=
 =?utf-8?B?dXlCaFNPNmxVQ3hxZUhXdGQweHRqRFV5NlM2L290WU9STVhCdGRhdFpTbUQ4?=
 =?utf-8?B?ZllHVzFxT3hWcTBpRWxDeUdHNzhZVkFKQXhTbFFhTk1wVENPMGE2anRpa1FQ?=
 =?utf-8?B?WkJ3cHdvcjc4R3FEWDZxRDZFZHZBTWtQRWpRVG8wU3psS0JQK1Z2aXh5SDk4?=
 =?utf-8?B?cUN3cHZIRWlOTVprV1ptaXRFVUlhVEQxOTJuZEJGaUtUVXN5ZEh0YXkzcXlu?=
 =?utf-8?B?aHJXOUdGYjh3cUc2bWE2SzdCRW1jNG5HTWs0d3FmTEoyZGRZU0FCT21IblU0?=
 =?utf-8?B?SmkyaEhuNzRyQlh5MnIvMHB4dEdFK3lOcXdEdmoxbEsvZHNxbTdwbjZoRlY0?=
 =?utf-8?B?KzFEa3E2OFp0anhBdDBDZk5PMTZUSTJXVHJ3cHhEK0ZHUEtMUGU1NWFEZWJL?=
 =?utf-8?B?b1NNODQ2Wmo4T0NHOXREc1FCNE9FNndSTFVmKzAvNExsMENMV3VqVXp3c3Vj?=
 =?utf-8?B?ZjRJOEZxeVd0L1ZkSlpCKzFRWHFvb1pNRE85Uk9BZVQ1WDVITGlEUEZTMXBF?=
 =?utf-8?Q?+6RXZvxmD+/jH0SSCzVzDKmvw?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d817771-e31a-435d-7b3b-08dc59f41e4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2024 06:53:39.4737
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cwgcf7MdY0it3Bq1MQcDHGYbDAl2KXq6oMa5aY9wC6DppBguswpCaxu8b62D9ouMoZ55+bfdW9K6NyEgIn8SyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8454
X-OriginatorOrg: intel.com

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBUaHVy
c2RheSwgQXByaWwgMTEsIDIwMjQgMTA6NDggQU0NCj4gDQo+IE9uIDQvNy8yNCA5OjE0IEFNLCBM
dSBCYW9sdSB3cm90ZToNCj4gPiBDb21taXQgMWE3NWNjNzEwYjk1ICgiaW9tbXUvdnQtZDogVXNl
IHJidHJlZSB0byB0cmFjayBpb21tdSBwcm9iZWQNCj4gPiBkZXZpY2VzIikgYWRkcyBhbGwgZGV2
aWNlcyBwcm9iZWQgYnkgdGhlIGlvbW11IGRyaXZlciBpbiBhIHJidHJlZQ0KPiA+IGluZGV4ZWQg
YnkgdGhlIHNvdXJjZSBJRCBvZiBlYWNoIGRldmljZS4gSXQgYXNzdW1lcyB0aGF0IGVhY2ggZGV2
aWNlDQo+ID4gaGFzIGEgdW5pcXVlIHNvdXJjZSBJRC4gVGhpcyBhc3N1bXB0aW9uIGlzIGluY29y
cmVjdCBhbmQgdGhlIFZULWQNCj4gPiBzcGVjIGRvZXNuJ3Qgc3RhdGUgdGhpcyByZXF1aXJlbWVu
dCBlaXRoZXIuDQo+ID4NCj4gPiBUaGUgcmVhc29uIGZvciB1c2luZyBhIHJidHJlZSB0byB0cmFj
ayBkZXZpY2VzIGlzIHRvIGxvb2sgdXAgdGhlIGRldmljZQ0KPiA+IHdpdGggUENJIGJ1cyBhbmQg
ZGV2ZnVuYyBpbiB0aGUgcGF0aHMgb2YgaGFuZGxpbmcgQVRTIGludmFsaWRhdGlvbiB0aW1lDQo+
ID4gb3V0IGVycm9yIGFuZCB0aGUgUFJJIEkvTyBwYWdlIGZhdWx0cy4gQm90aCBhcmUgUENJIEFU
UyBmZWF0dXJlIHJlbGF0ZWQuDQo+ID4NCj4gPiBPbmx5IHRyYWNrIHRoZSBkZXZpY2VzIHRoYXQg
aGF2ZSBQQ0kgQVRTIGNhcGFiaWxpdGllcyBpbiB0aGUgcmJ0cmVlIHRvDQo+ID4gYXZvaWQgdW5u
ZWNlc3NhcnkgV0FSTl9PTiBpbiB0aGUgaW9tbXUgcHJvYmUgcGF0aC4gT3RoZXJ3aXNlLCBvbg0K
PiBzb21lDQo+ID4gcGxhdGZvcm1zIGJlbG93IGtlcm5lbCBzcGxhdCB3aWxsIGJlIGRpc3BsYXll
ZCBhbmQgdGhlIGlvbW11IHByb2JlIHJlc3VsdHMNCj4gPiBpbiBmYWlsdXJlLg0KPiA+DQo+ID4g
ICBXQVJOSU5HOiBDUFU6IDMgUElEOiAxNjYgYXQgZHJpdmVycy9pb21tdS9pbnRlbC9pb21tdS5j
OjE1OA0KPiBpbnRlbF9pb21tdV9wcm9iZV9kZXZpY2UrMHgzMTkvMHhkOTANCj4gPiAgIENhbGwg
VHJhY2U6DQo+ID4gICAgPFRBU0s+DQo+ID4gICAgPyBfX3dhcm4rMHg3ZS8weDE4MA0KPiA+ICAg
ID8gaW50ZWxfaW9tbXVfcHJvYmVfZGV2aWNlKzB4MzE5LzB4ZDkwDQo+ID4gICAgPyByZXBvcnRf
YnVnKzB4MWY4LzB4MjAwDQo+ID4gICAgPyBoYW5kbGVfYnVnKzB4M2MvMHg3MA0KPiA+ICAgID8g
ZXhjX2ludmFsaWRfb3ArMHgxOC8weDcwDQo+ID4gICAgPyBhc21fZXhjX2ludmFsaWRfb3ArMHgx
YS8weDIwDQo+ID4gICAgPyBpbnRlbF9pb21tdV9wcm9iZV9kZXZpY2UrMHgzMTkvMHhkOTANCj4g
PiAgICA/IGRlYnVnX211dGV4X2luaXQrMHgzNy8weDUwDQo+ID4gICAgX19pb21tdV9wcm9iZV9k
ZXZpY2UrMHhmMi8weDRmMA0KPiA+ICAgIGlvbW11X3Byb2JlX2RldmljZSsweDIyLzB4NzANCj4g
PiAgICBpb21tdV9idXNfbm90aWZpZXIrMHgxZS8weDQwDQo+ID4gICAgbm90aWZpZXJfY2FsbF9j
aGFpbisweDQ2LzB4MTUwDQo+ID4gICAgYmxvY2tpbmdfbm90aWZpZXJfY2FsbF9jaGFpbisweDQy
LzB4NjANCj4gPiAgICBidXNfbm90aWZ5KzB4MmYvMHg1MA0KPiA+ICAgIGRldmljZV9hZGQrMHg1
ZWQvMHg3ZTANCj4gPiAgICBwbGF0Zm9ybV9kZXZpY2VfYWRkKzB4ZjUvMHgyNDANCj4gPiAgICBt
ZmRfYWRkX2RldmljZXMrMHgzZjkvMHg1MDANCj4gPiAgICA/IHByZWVtcHRfY291bnRfYWRkKzB4
NGMvMHhhMA0KPiA+ICAgID8gdXBfd3JpdGUrMHhhMi8weDFiMA0KPiA+ICAgID8gX19kZWJ1Z2Zz
X2NyZWF0ZV9maWxlKzB4ZTMvMHgxNTANCj4gPiAgICBpbnRlbF9scHNzX3Byb2JlKzB4NDlmLzB4
NWIwDQo+ID4gICAgPyBwY2lfY29uZjFfd3JpdGUrMHhhMy8weGYwDQo+ID4gICAgaW50ZWxfbHBz
c19wY2lfcHJvYmUrMHhjZi8weDExMCBbaW50ZWxfbHBzc19wY2ldDQo+ID4gICAgcGNpX2Rldmlj
ZV9wcm9iZSsweDk1LzB4MTIwDQo+ID4gICAgcmVhbGx5X3Byb2JlKzB4ZDkvMHgzNzANCj4gPiAg
ICA/IF9fcGZ4X19fZHJpdmVyX2F0dGFjaCsweDEwLzB4MTANCj4gPiAgICBfX2RyaXZlcl9wcm9i
ZV9kZXZpY2UrMHg3My8weDE1MA0KPiA+ICAgIGRyaXZlcl9wcm9iZV9kZXZpY2UrMHgxOS8weGEw
DQo+ID4gICAgX19kcml2ZXJfYXR0YWNoKzB4YjYvMHgxODANCj4gPiAgICA/IF9fcGZ4X19fZHJp
dmVyX2F0dGFjaCsweDEwLzB4MTANCj4gPiAgICBidXNfZm9yX2VhY2hfZGV2KzB4NzcvMHhkMA0K
PiA+ICAgIGJ1c19hZGRfZHJpdmVyKzB4MTE0LzB4MjEwDQo+ID4gICAgZHJpdmVyX3JlZ2lzdGVy
KzB4NWIvMHgxMTANCj4gPiAgICA/IF9fcGZ4X2ludGVsX2xwc3NfcGNpX2RyaXZlcl9pbml0KzB4
MTAvMHgxMCBbaW50ZWxfbHBzc19wY2ldDQo+ID4gICAgZG9fb25lX2luaXRjYWxsKzB4NTcvMHgy
YjANCj4gPiAgICA/IGttYWxsb2NfdHJhY2UrMHgyMWUvMHgyODANCj4gPiAgICA/IGRvX2luaXRf
bW9kdWxlKzB4MWUvMHgyMTANCj4gPiAgICBkb19pbml0X21vZHVsZSsweDVmLzB4MjEwDQo+ID4g
ICAgbG9hZF9tb2R1bGUrMHgxZDM3LzB4MWZjMA0KPiA+ICAgID8gaW5pdF9tb2R1bGVfZnJvbV9m
aWxlKzB4ODYvMHhkMA0KPiA+ICAgIGluaXRfbW9kdWxlX2Zyb21fZmlsZSsweDg2LzB4ZDANCj4g
PiAgICBpZGVtcG90ZW50X2luaXRfbW9kdWxlKzB4MTdjLzB4MjMwDQo+ID4gICAgX194NjRfc3lz
X2Zpbml0X21vZHVsZSsweDU2LzB4YjANCj4gPiAgICBkb19zeXNjYWxsXzY0KzB4NmUvMHgxNDAN
Cj4gPiAgICBlbnRyeV9TWVNDQUxMXzY0X2FmdGVyX2h3ZnJhbWUrMHg3MS8weDc5DQo+ID4NCj4g
PiBGaXhlczogMWE3NWNjNzEwYjk1ICgiaW9tbXUvdnQtZDogVXNlIHJidHJlZSB0byB0cmFjayBp
b21tdSBwcm9iZWQNCj4gZGV2aWNlcyIpDQo+ID4gU2lnbmVkLW9mZi1ieTogTHUgQmFvbHU8YmFv
bHUubHVAbGludXguaW50ZWwuY29tPg0KPiA+IC0tLQ0KPiA+ICAgZHJpdmVycy9pb21tdS9pbnRl
bC9pb21tdS5jIHwgMTEgKysrKysrKy0tLS0NCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2Vy
dGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+IA0KPiBUaGlzIHBhdGNoIGNsb3NlcyBhIGJvb3Qg
YnVnIGRlc2NyaWJlZCBoZXJlLg0KPiANCj4gQ2xvc2VzOiBodHRwczovL2dpdGxhYi5mcmVlZGVz
a3RvcC5vcmcvZHJtL2ludGVsLy0vaXNzdWVzLzEwNjg5DQo+IA0KPiBJIHdpbGwgcXVldWUgaXQg
Zm9yIHY2LjktcmMgaWYgbm8gb2JqZWN0aW9uLg0KPiANCg0KbGV0J3MgZG8gaXQuIHRoZSBpc3N1
ZSB3aGljaCBJIHJhaXNlZCBpcyByYXJlIGFuZCBjYW4gYmUgdGFja2xlZCB3aGVuDQppdCBhcmlz
ZXMuDQoNClJldmlld2VkLWJ5OiBLZXZpbiBUaWFuIDxrZXZpbi50aWFuQGludGVsLmNvbT4NCg==

