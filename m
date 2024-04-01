Return-Path: <linux-kernel+bounces-126950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 956678944DF
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 20:27:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA4BDB21B15
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 18:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D40251C2C;
	Mon,  1 Apr 2024 18:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HEyJ/+qg"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B614B5CD;
	Mon,  1 Apr 2024 18:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711996035; cv=fail; b=ultUHmH5ospxDrzEfUjhRTJXduSdmuYWD5dcp03WzN74vmOKPmPr2tHmS+zhJKfLLldL5bLQJs2aK5YqALQ+CK/vyEnhfyP6fSm8HxV9MrYIB/Gg2lL2uByFOW6KL1W+L0ViOux4Iwgr226j4sjD1ezz14FttvCVpMIwymVUTZs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711996035; c=relaxed/simple;
	bh=B1QHl5EGCzDbrHZ+dLFHU96Cq5V7atstuhRUXpLjnkw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gr+2vb5ux4anNnFfwFaMWWUesDz5M4ATMwSnc3fyTIaJhq+1NWNfZBTGamNSqYlnIOgkJCkGqyR9xVwITQ3vU8yU1PDB4sVikvqkuQcjnS/82VSvnQS0b7i7zKbKY1mLkY+nDLsK5pmr38gGBMkIPhokZZEAfx8cRUCdPFtnnA0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HEyJ/+qg; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711996034; x=1743532034;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=B1QHl5EGCzDbrHZ+dLFHU96Cq5V7atstuhRUXpLjnkw=;
  b=HEyJ/+qgfIRNVG9q08pC4ESoriF8Dz07G6oRG+pX06wXHTD3bocMqW7/
   OT9JLH5mX/SRARQIk1UWkt2GTwwBW5SPKrJp+S+sr3nr2NzQ/40/kd3iz
   7JQ5lCaIiWxIg0PWRsa6tBj6IBtUjGrugMkXq0wRHgTfEULX6m51xzLRV
   vVopiF03Sc3P/gTE9muQKXeZ+maHiGfm6KSkFbR8ndtY7NsSxNFYXgmTZ
   Ap1BcubbpMKE9v12/WjqoG6HKNr8QVgKorJ3ReoDwMD4o7pHbzTbYkS2e
   iwyc/uSK72dkCeQ7j4ETZFZUu3ysDlWOq9yDHg/ZyoNmyDotF2ddbfF30
   g==;
X-CSE-ConnectionGUID: JSeHTzSnRFiu4NMnWgSCYA==
X-CSE-MsgGUID: 2KgGYgk1Q/iWfwgiRwTUfw==
X-IronPort-AV: E=McAfee;i="6600,9927,11031"; a="18496712"
X-IronPort-AV: E=Sophos;i="6.07,172,1708416000"; 
   d="scan'208";a="18496712"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2024 11:27:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,172,1708416000"; 
   d="scan'208";a="22462984"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Apr 2024 11:27:13 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 1 Apr 2024 11:27:12 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 1 Apr 2024 11:27:11 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 1 Apr 2024 11:27:11 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 1 Apr 2024 11:27:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZghdD2K6tDXydgj3l9V1uSGDH3Q/IuRk3E9DoP3DKQfAlHxEQt/3cD5Ea528wPGB6ii5ogdsIYiT2iAOTEMKXTrgg84jPMxvTMGfs7RTjHSIt15O9etqqK82CRATLs8W4S97gV3N6wEybtdpdur7+HY/sxmaFq9d1kcrAiFmJrGcD7qRe5l7DSQ3/1qYki/0zSHp/jGyyDz4xDYVeJPP7/tQg5fqCDJ2vvwfMsvjTRW+cdJXdSd8Jhz3JMt9/tUE8Bmt9rpj5yt7EXHLIZZ2YWF+O66nCRFDb33bkjbPOT1dqtAU48508eoJMwIbwy/7oKAEJ+qDALSpCHw+y7LheA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B1QHl5EGCzDbrHZ+dLFHU96Cq5V7atstuhRUXpLjnkw=;
 b=iFelkY0S4NylqMCWFOmwhgzchvMiCD+DryaFnlgRskqigWJsX52P+Usx3kxCAYG75pX3z59mYE7SNiPzophu5B8vtrtyo0LXQbEJ4vBApXra5BjduTnDFZY+pnH6N6wGRD4XDUdKtdooR+EFtWiGq48Ba78eU8GrPmSZrPf1+ZkjQyf1iuLnYJxwgUOOi1WdnqDfip/VuGai1nomXiWNlHP4nOmAYxn9/PLy8zg2d3LjhQOnE0fEVFS1qslyyNQGchKOTBC0xd0GcO+V+qyLYTU+Qv/S95kEc6omVnZrE8oysBPHpYW/XxU5HEDOh6ornD7HdFHc9UVNg08ZEnn75w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SN7PR11MB7590.namprd11.prod.outlook.com (2603:10b6:806:348::13)
 by IA1PR11MB7677.namprd11.prod.outlook.com (2603:10b6:208:3fd::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Mon, 1 Apr
 2024 18:27:08 +0000
Received: from SN7PR11MB7590.namprd11.prod.outlook.com
 ([fe80::5997:c66:5650:3bed]) by SN7PR11MB7590.namprd11.prod.outlook.com
 ([fe80::5997:c66:5650:3bed%3]) with mapi id 15.20.7452.019; Mon, 1 Apr 2024
 18:27:08 +0000
From: "Colberg, Peter" <peter.colberg@intel.com>
To: "yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>
CC: "Xu, Yilun" <yilun.xu@intel.com>, "linux-fpga@vger.kernel.org"
	<linux-fpga@vger.kernel.org>, "mdf@kernel.org" <mdf@kernel.org>, "Wu, Hao"
	<hao.wu@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "russ.weight@linux.dev"
	<russ.weight@linux.dev>, "Pagani, Marco" <marpagan@redhat.com>, "Rix, Tom"
	<trix@redhat.com>, "matthew.gerlach@linux.intel.com"
	<matthew.gerlach@linux.intel.com>
Subject: Re: [PATCH] fpga: dfl: afu: remove unused member pdata from struct
 dfl_afu
Thread-Topic: [PATCH] fpga: dfl: afu: remove unused member pdata from struct
 dfl_afu
Thread-Index: AQHahEXDUw29MWHX3k2cS6rvyjjFIrFTu9oA
Date: Mon, 1 Apr 2024 18:27:08 +0000
Message-ID: <df3382349cbb72fc1604d3e305edbad9e81505a4.camel@intel.com>
References: <20240328235417.7219-1-peter.colberg@intel.com>
	 <ZgrLZCl1nPDMcq/i@yilunxu-OptiPlex-7050>
In-Reply-To: <ZgrLZCl1nPDMcq/i@yilunxu-OptiPlex-7050>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR11MB7590:EE_|IA1PR11MB7677:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RRvzadqf5HQWDU0ZXwvsnbEFx+ErAEcnMXspz2aMqSIsYJfcnMweGNU+nu7FVSadY/nk/jqE6w37f8sm/odxR7nX7L1t5FeTYVrLSOMaaZAPSH988BppR/h5APos6akeSGczr7IxQjCUdiyoZh+VzU6ud81uUEv4Iis6eNRk/mI56d/YHGDdKhrGvoJjzXqHF6AAd2MjxoLFgI+Z4h9WdUxwL1YY9tD7wpb2TdWvKeC+2sJAcMorwXmAVgID3n8Bz4lNktECGIRKKluAbN18nDn6PLl0Y3AwBJDj21a5V/nTk8GSxaWak30q4UwhdvELvs4t70uvkxbLtOHNNKT3IM7GBImZKDEpqV9aRBsM34nQwYabpIcNVdYWSxsWxM4rgRO6xwu4KzZm4JqRyderPG39FIlpWoQIiPJAOyav27rjc1NVBcxGrb/M9sIXXE0b93aaCoFsoXaRz24wY3uYnlD+aBWkJ7TXtcrJADCFbaW8Aomd4YthlaKfpmflN136v91X8ODUw0u0APDBMEO/T3PV6zxwKS92G8rrPWkmML17TLvHqsCPgXGMoDY0nnTd0Kp7W/TB5XGikvRivbVEJ6APof7A6jTmgO5+Z4OYfsvuywYpZlqgPxYqgy9mgqLMv99vkiEXdVppM7v904n99znfpbbvUihIOOC/YyGnhYU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7590.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L3hMNWZLaEdvZ2kxMVduaW1CODR6Q0xmdUcyZUU1Q29UQ3N3cE9pY3EzTldj?=
 =?utf-8?B?Um8rT3RYeWZZZ2pla2xRTHFmN1Avb1pkaGRNWXN6cFp5SytidzMwQ2JUZzdn?=
 =?utf-8?B?cGUyNEZsTWpzQ0FXcDhMam1kcWxpVXlRRnJzUW5vcXBHVm5pKzJWUGt5VzZs?=
 =?utf-8?B?Ny9hczVLMUl3NXFYUEJLMjIzbjdMUDR5R0c4Nkprb1JFMDFWSGxiVVR1bXpF?=
 =?utf-8?B?Kyt6TTMwb1Nhc0kvVHR4NWxaQ2NDZk1RRTY5SGpMQzJFV214SU0xcjVITmph?=
 =?utf-8?B?TTVIUFYxcTQrWmVhWHhXNVA4ZlBsTzRwZ2tCS0NEYytjNXRka0ZiK0RjM0s4?=
 =?utf-8?B?a0NSTVdmd0oxc3VpaU5lLzhTQmFSK1ZYTUo3UTZxN0VkZjRHYXBUd29FaDJF?=
 =?utf-8?B?dXYyTU8zODAyZWVRRnhpaG5KMlMzRGhXeVZvNFpKMkxpM1R5MXhKenZZWEN4?=
 =?utf-8?B?aHVlWENxL3ZpQ000VTE5UUFINjFCOXJyVlFMeGxkNVVvQzNKQ3FQUE9mQXhv?=
 =?utf-8?B?djdkbXkwblBDVVhuc2x6KzRlSTlDdDJPeTRHVUhQQzkraWZKeHMxNm13dFVy?=
 =?utf-8?B?S3JxZExtMnRveWNNWDJyNTdFckN1b2ppVXhmQjJXdzNuSnNSeDkrYmV1TzN1?=
 =?utf-8?B?M01vYUREUTdBYWgvTnRMWGRlUEZ4NmZxazlTaU44cEIzdlFSSHNNb01BL1hK?=
 =?utf-8?B?YmRNQUl5NnRaSDMxajdrRFNIUU80VG5aSmdYcXRDUDdnVUFjMVI3M0htV2FG?=
 =?utf-8?B?N0Z2RWlmZm9TQnczS01IaTMyMXBYTEJxVnNIUEJIRzhMREUvam41dkt5UFRo?=
 =?utf-8?B?cmY4MGlLYXNlYU1GYzhJcnBYUW1SQ1JTeE03eDExdDFoRTdhN2VyWDRtRjhR?=
 =?utf-8?B?U1BtbzVHOWxlRS96a3ZmNU5TWU1OZWdaclZYOVBVR0RFWnlRdVJ4dVdFa3JP?=
 =?utf-8?B?K1BkczEwNUVyRGlTOVNFaUZpRVVLdkxNWnJxMmUwR3R2K3Q3V0hrSWJOV0lP?=
 =?utf-8?B?Q3huUDUxNGpsL3JZeUNJVjEvbjNVaTNhaWdyOTVaVXFJUlJERUFsNk94MEpF?=
 =?utf-8?B?OXhYRzdXejQwV3hDdS9TOWJ0VEN0eUt3L2F4Y0NLUmQ5VmRaK1NRV0lXVStn?=
 =?utf-8?B?UmIxWXFGOVVuV01OS3drQ296cGY1QWFod1RTc0VmeWxkaEZ5NVhWY3NOTEdU?=
 =?utf-8?B?VFVFQzM5RStQU3ZLSmZxR2Z0V0dKeFM2UENWdHJMSDBoRW80UFZSaklTQTU5?=
 =?utf-8?B?a1g3YXp5WTFxb3F5OWRHOWdUUFh5UGdEck1pRElxSGFIdkpaY3NqV1RVaFBC?=
 =?utf-8?B?eE93MnBCWVZucVArNExCTlFDb1JTWkVPcFNqUEFDZ3NUVTNlNGhrdEhuMUJi?=
 =?utf-8?B?ZytpK05jemEzMWRMTnFmMGtvYk1ydk05WjJGNXJsMWFORlBsVE5uS2FsQ1pM?=
 =?utf-8?B?bXhhMGhUNENvNlJQTWVkdFBnSjcvakpvemFxWHoxQnFnUFVRYmgyM0kwMjRW?=
 =?utf-8?B?S0xGNlhIc1NOYVYyWURMSlRwRUVFMFNWdmdDWU00Z3FnY2hrbjFaaTlUNDZx?=
 =?utf-8?B?R0VtWnNyblBrNTJodVhGRU42Y09VR3ZreXNNVzg0akw5eW52SFlsUW5NZGNR?=
 =?utf-8?B?NHFPaVRWOXpETW8zcGNLMTRMSWsyVWhyQURvRDdCbjJlK3pBYnRGem45MGxX?=
 =?utf-8?B?cmcraGpXcHgwMDFSMGNlcmVZaGt0aXVGZ3N2NFlVZTBOTy9HaFVlTWVXQ2pQ?=
 =?utf-8?B?eFZHTXR0R0JzQndNRmxoQkF1aldRK2twbldSQjA3TDBRTVRteUtOa0tqV1d4?=
 =?utf-8?B?VnRjSDJPNFN1NGNQN0h0T3NkU3RxN0FUd0ZoN0JWVXFNNXBUdzRkTENGalZs?=
 =?utf-8?B?UytKQlcwTEtHdmtEbmt5bnVRWndaNzcvamFrOUh3Q0lOMkh3WW42cnRpVUt1?=
 =?utf-8?B?WHV4TGpEYWhOb2I3TkdNaUF3bFR1KzY4YTl3UFlTUWx6QnJxaHFZb2Z2R2Jh?=
 =?utf-8?B?V3U4amZEOE0zUjN6SXpVcG9abVpMeUtyWW10U0psTVFWUjVVMjMzaEZZcG1O?=
 =?utf-8?B?MllFeDNJc0liU2VNenlSd0pjbUt4bEFyeU5BVTBEVmJ6U1YzVlJuVWxrWTN1?=
 =?utf-8?B?amt2RmtVUFRGbWVpbkdveU5WeU5wWUU4S0MyZ2dYeGlTOWU2ZXlnYmxVaEgw?=
 =?utf-8?B?bEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4C34EDDEAD0D1F4A89966388C108F130@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7590.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 874f538f-c529-42d0-3dc9-08dc5279570c
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2024 18:27:08.4396
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JC+GLphllqgsAQf138rSvRrO45dVNq5nxV82veQf3TN9AEyku8ZBJrvsOY2/NO3S86u4uSsCpfHMXnfeCRDMpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7677
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI0LTA0LTAxIGF0IDIyOjU3ICswODAwLCBYdSBZaWx1biB3cm90ZToNCj4gT24g
VGh1LCBNYXIgMjgsIDIwMjQgYXQgMDc6NTQ6MTdQTSAtMDQwMCwgUGV0ZXIgQ29sYmVyZyB3cm90
ZToNCj4gPiBUaGUgbWVtYmVyIHBkYXRhIHdhcyBhZGRlZCB0byBzdHJ1Y3QgZGZsX2FmdSBpbiBj
b21taXQgODU3YTI2MjIyZmY3DQo+ID4gKCJmcGdhOiBkZmw6IGFmdTogYWRkIGFmdSBzdWIgZmVh
dHVyZSBzdXBwb3J0IikgYW5kIGlzIHNldCBpbiBmdW5jdGlvbg0KPiA+IGFmdV9kZXZfaW5pdCgp
IGJ1dCBvdGhlcndpc2UgbmV2ZXIgdXNlZC4NCj4gDQo+IENvdWxkIHlvdSBhbHNvIGhlbHAgY2hl
Y2sgaWYgZGZsX2ZtZSBoYXMgdGhlIHNhbWUgaXNzdWU/DQoNCkluZGVlZCwgdGhhbmsgeW91IGZv
ciBwb2ludGluZyB0aGlzIG91dC4NCg0KUGV0ZXINCg0KPiANCj4gVGhhbmtzLA0KPiBZaWx1bg0K
PiANCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBQZXRlciBDb2xiZXJnIDxwZXRlci5jb2xiZXJn
QGludGVsLmNvbT4NCj4gPiBSZXZpZXdlZC1ieTogTWF0dGhldyBHZXJsYWNoIDxtYXR0aGV3Lmdl
cmxhY2hAbGludXguaW50ZWwuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2ZwZ2EvZGZsLWFm
dS1tYWluLmMgfCAyIC0tDQo+ID4gIGRyaXZlcnMvZnBnYS9kZmwtYWZ1LmggICAgICB8IDMgLS0t
DQo+ID4gIDIgZmlsZXMgY2hhbmdlZCwgNSBkZWxldGlvbnMoLSkNCj4gPiANCj4gPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9mcGdhL2RmbC1hZnUtbWFpbi5jIGIvZHJpdmVycy9mcGdhL2RmbC1hZnUt
bWFpbi5jDQo+ID4gaW5kZXggYzBhNzVjYTM2MGQ2Li42Yjk3YzA3Mzg0OWUgMTAwNjQ0DQo+ID4g
LS0tIGEvZHJpdmVycy9mcGdhL2RmbC1hZnUtbWFpbi5jDQo+ID4gKysrIGIvZHJpdmVycy9mcGdh
L2RmbC1hZnUtbWFpbi5jDQo+ID4gQEAgLTg1OCw4ICs4NTgsNiBAQCBzdGF0aWMgaW50IGFmdV9k
ZXZfaW5pdChzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiA+ICAJaWYgKCFhZnUpDQo+
ID4gIAkJcmV0dXJuIC1FTk9NRU07DQo+ID4gIA0KPiA+IC0JYWZ1LT5wZGF0YSA9IHBkYXRhOw0K
PiA+IC0NCj4gPiAgCW11dGV4X2xvY2soJnBkYXRhLT5sb2NrKTsNCj4gPiAgCWRmbF9mcGdhX3Bk
YXRhX3NldF9wcml2YXRlKHBkYXRhLCBhZnUpOw0KPiA+ICAJYWZ1X21taW9fcmVnaW9uX2luaXQo
cGRhdGEpOw0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2ZwZ2EvZGZsLWFmdS5oIGIvZHJpdmVy
cy9mcGdhL2RmbC1hZnUuaA0KPiA+IGluZGV4IDY3NGU5NzcyZjBlYS4uN2JlZjNlMzAwYWEyIDEw
MDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZnBnYS9kZmwtYWZ1LmgNCj4gPiArKysgYi9kcml2ZXJz
L2ZwZ2EvZGZsLWFmdS5oDQo+ID4gQEAgLTY3LDcgKzY3LDYgQEAgc3RydWN0IGRmbF9hZnVfZG1h
X3JlZ2lvbiB7DQo+ID4gICAqIEByZWdpb25zOiB0aGUgbW1pbyByZWdpb24gbGlua2VkIGxpc3Qg
b2YgdGhpcyBhZnUgZmVhdHVyZSBkZXZpY2UuDQo+ID4gICAqIEBkbWFfcmVnaW9uczogcm9vdCBv
ZiBkbWEgcmVnaW9ucyByYiB0cmVlLg0KPiA+ICAgKiBAbnVtX3Vtc2dzOiBudW0gb2YgdW1zZ3Mu
DQo+ID4gLSAqIEBwZGF0YTogYWZ1IHBsYXRmb3JtIGRldmljZSdzIHBkYXRhLg0KPiA+ICAgKi8N
Cj4gPiAgc3RydWN0IGRmbF9hZnUgew0KPiA+ICAJdTY0IHJlZ2lvbl9jdXJfb2Zmc2V0Ow0KPiA+
IEBAIC03NSw4ICs3NCw2IEBAIHN0cnVjdCBkZmxfYWZ1IHsNCj4gPiAgCXU4IG51bV91bXNnczsN
Cj4gPiAgCXN0cnVjdCBsaXN0X2hlYWQgcmVnaW9uczsNCj4gPiAgCXN0cnVjdCByYl9yb290IGRt
YV9yZWdpb25zOw0KPiA+IC0NCj4gPiAtCXN0cnVjdCBkZmxfZmVhdHVyZV9wbGF0Zm9ybV9kYXRh
ICpwZGF0YTsNCj4gPiAgfTsNCj4gPiAgDQo+ID4gIC8qIGhvbGQgcGRhdGEtPmxvY2sgd2hlbiBj
YWxsIF9fYWZ1X3BvcnRfZW5hYmxlL2Rpc2FibGUgKi8NCj4gPiAtLSANCj4gPiAyLjQ0LjANCj4g
PiANCj4gPiANCg0K

