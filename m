Return-Path: <linux-kernel+bounces-124206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D66D8913E0
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 07:44:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A44601F23617
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 06:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83FE63BB20;
	Fri, 29 Mar 2024 06:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YKWOvVgH"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA493FB2A;
	Fri, 29 Mar 2024 06:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711694636; cv=fail; b=qiBtJCgcnj/DCnG5//hveni/HyoEgraOuBZDxPvl/Pm1AoQhkOIRBC24GFSTtwEZUk1b5yLovMVHKco11Xm+t9U5yo9p79SeoEpt5vqxR6FpYrDO5Z7tVE6esiGyA01vUbaJllc5ex3jp8u/HnnnnTnT3iNtqVNJFiUIgmtsNrc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711694636; c=relaxed/simple;
	bh=EjQXNp1MjNfyhgQEBE6/JfZyE26/TipqP4hbeb7/c7A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bHtGrnaT0uIaGxEn2P0D1JuQoi+8YDQH3bBBydP7Sztq2TQkVREiUwmxakWB9ScBD6NT4U25x9w5WqQzpMuNDoXf9DQuXbSRraJFkMHJSLuyzQL0Uis/qACig+JqvgtUqPn/0IaX5YK+qg+SkyP+5kZdij8+UDKvPsSdW/b5AzM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YKWOvVgH; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711694633; x=1743230633;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=EjQXNp1MjNfyhgQEBE6/JfZyE26/TipqP4hbeb7/c7A=;
  b=YKWOvVgHtpBwoWgM/1sczAOn1guUqr/Ddg7ZsKcwJDdeaf1p/Z+uSVcs
   fMeG29OqZHn+Yna7E4+M8efYXJhRnazYBJeoCyBih33iNZqpuY4YCvgjP
   A3j0u0soAhpAxfxV3TAMGT+KnlIlgxyQ1Wq/qb2dKph1lBj+rq90DxA3y
   oSP1mmtU3rboEH6bz9h+WpP0XjA3UYt9J5TkW4/Jsoj1r2tUqISgPuqBh
   wodon6HgC31fNTfBvaaUErj8Jc8N6Xzzinvt7DxOoY3V72ccB6dk+Pfq4
   QFBuYP5yKj7oG5eouG9YxEgg0jqkNuvHxqZ4a2usxgGaweGwU8zZKcpNI
   g==;
X-CSE-ConnectionGUID: NtKvAAmrR0KvFSbssVZOVQ==
X-CSE-MsgGUID: JrdqcevxSoOXCasnSCCEHw==
X-IronPort-AV: E=McAfee;i="6600,9927,11027"; a="17433566"
X-IronPort-AV: E=Sophos;i="6.07,164,1708416000"; 
   d="scan'208";a="17433566"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2024 23:43:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,164,1708416000"; 
   d="scan'208";a="21557440"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Mar 2024 23:43:51 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 28 Mar 2024 23:43:50 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 28 Mar 2024 23:43:50 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 28 Mar 2024 23:43:50 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 28 Mar 2024 23:43:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WOABtl6EdJrurs7mp6MicCIxRtqTiVRmxAphlwMt48YEHGTTJD312nqN4bOfp+ZfkqMzhNetSmTa327rFSSdgoHyfL4espDQ6tytTvPK5NvX9hSqO2P9M5aq1kJs3wrDrezUfBov7V/Ye+12eSomW6tSVMjjv8FTwv/maYcwyq0MdPRJy8ffP46+Xv3LUPhhjx783KnnlNQDVTFcTk/JALwRHZsWsfNX8ghN/j5LhqE3xgx/++6uF5IetzxLL32xAfkpG8gAyic0i+V79+L7UwsSj+8vKeuMyolVsv7ShjvbXaTqiGZHrZNuiUn5+deZ60l4JWZCDe+R5+jUM38WIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EjQXNp1MjNfyhgQEBE6/JfZyE26/TipqP4hbeb7/c7A=;
 b=CiY6YbTJa3WyytsujIZVe7dV7Y3LEEQR66oXiK8Bg56EauqO1sXgxVYUf6Qy6DaaXSq/AcxB6iZwYrStrKfu9EdawR1EAVeGus98lyiW6WqxR2Am8vVcJkQ1ktQgGKtzu//kD1p0yFrYUHbJqLVFATt2ZFMFOnsHu865Ny9qwRjRoBLi5iwz6oBMsmYLPz4ooqZk2n3zhbHPCC3+JAhVne/xyr335swFNy1zDL+zlBziWBAZjBUGKg20/mBsjmAop930YuTYGKdCOasdQ0igH8qbD7hlmx3N4YYJP7wwMBJ0QA8pzKCWayr8EbCR9c4qFzWaPis83hVfCsduuwr+Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO6PR11MB5635.namprd11.prod.outlook.com (2603:10b6:5:35f::14)
 by BY1PR11MB8055.namprd11.prod.outlook.com (2603:10b6:a03:530::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Fri, 29 Mar
 2024 06:43:48 +0000
Received: from CO6PR11MB5635.namprd11.prod.outlook.com
 ([fe80::d3a0:f70a:9340:9a3e]) by CO6PR11MB5635.namprd11.prod.outlook.com
 ([fe80::d3a0:f70a:9340:9a3e%3]) with mapi id 15.20.7409.031; Fri, 29 Mar 2024
 06:43:48 +0000
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
Subject: RE: [RFC PATCH v5 1/6] perf stat: Parse and find tpebs events when
 parsing metrics to prepare for perf record sampling
Thread-Topic: [RFC PATCH v5 1/6] perf stat: Parse and find tpebs events when
 parsing metrics to prepare for perf record sampling
Thread-Index: AQHaf7xVTssqXpXKH0WuXe3bfOU0N7FOOUgAgAANccA=
Date: Fri, 29 Mar 2024 06:43:48 +0000
Message-ID: <CO6PR11MB5635E6DE9643226FF76D08B3EE3A2@CO6PR11MB5635.namprd11.prod.outlook.com>
References: <20240326202859.960577-1-weilin.wang@intel.com>
 <20240326202859.960577-2-weilin.wang@intel.com>
 <CAM9d7cjm6uOhffsiuVKk=2GBEUBZUyhNe-5QM5--tw3-X+UBJw@mail.gmail.com>
In-Reply-To: <CAM9d7cjm6uOhffsiuVKk=2GBEUBZUyhNe-5QM5--tw3-X+UBJw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR11MB5635:EE_|BY1PR11MB8055:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: k4Vsfi277os/CwqJayCArRlaygVDUNGivE6GETq72nrAfsQikp8AclrKxEaTIrHxzRSXQf13JMynmX7lQbQnIDQK01pp/2FFz2gQxAeAj57Ct//kwkyMnGy39LgiMWSFsJhHut8Vs7fFjyj2pH6FwVjnbo/MuXAYiTCSQ6hifUjNStRTfsZy41Dhzq0L9M7yUwkv3E0IrNKXFIwVA5ENejJyKnSTw3obc6rq7SkmDu4U2roVRQWn2chHe3Ud11maAa2RICu/M0+58ChwDoJ5EKnmF8Z8mMkx5VpwtGVVcM7aXq3M9FpN8uuiiZN2v1ubNMncbzI6MjTsUclcqLMBy1Gx7SgJgmycCzKpfBF2bDNgoVTi6eKRVbFeZY05aCL13ccVcfc8oOv5w9NzCJxp+uYY81s1P3mfurRqUcAPUm1Zsezm4ZqyEMp2GVATubVkSs8ky/LQqOonjjHhen1/AshnDF+l1SxuoeuG6XEx9kSW+UMl0i+TMjtLYtxw0Jk9TUooKhdXWjxk7h833bMghLwkF1knyZFHwL1E3U59HJLsTstl4QLJ5Q/UlBdS+IQ9z6dXpamI7Ei5LAforWB4ALIc47wf76bVgTXDANDyOL4LJXDKrbh87hhZsa+d2nZZfwL5XMtN013VGrrCtCX4Rjr8zyOckokCDn30FhMQI9E=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5635.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b21uTUpyQmlJR01aNkJKTGhDbjkzdFoxR284dWxOK1N3UUN1MHFHcDl2UVBu?=
 =?utf-8?B?eWo4R05CdlBsa1ZFbEwzSVFtRnMzbjV5R1VJazFzNzd1dit1MVltU1hsaDJP?=
 =?utf-8?B?K3hYTVJmVzNQcEhMQi8vSnBNeUpaTHhnWG43SDBxdUZDMGhqdERWUkp6SjVy?=
 =?utf-8?B?TUVzbDlzOWd4WDdrRHVkdTd1SmtUM1VWYkR4U2gvV2lpTnRDQmFuNHIwZFBG?=
 =?utf-8?B?U1grdTdLUDZTTTg1Y0ZhQllFV0VrSmNNUW02QktzcnRrY2VzZThOYTdyQzRr?=
 =?utf-8?B?TnpoS0FReU9xY2RXWDRjdkk5VlByR3VFcFhUREczV2l5L0FJQ2NnRmxwamtK?=
 =?utf-8?B?WGd5M2EvVkhaS3lFMXY3NlB5ZXEwcVFac3M3Rm9sdHd6NkJCZXNBOXpvblpp?=
 =?utf-8?B?SmZocE1DTkNUTWRaS2FSa0ZyS0VNUzNVb2dMbTlNczZsZ29VK3YzQXJrVnQ2?=
 =?utf-8?B?bGRSL2F4QW1zVmJVemNJaithcml2QkV3ZmZBdjV4NmZWb1Fsc0QrK01TcVhm?=
 =?utf-8?B?Q2NQOXBkbkdDdmpucnl3ZlQva1BNbW1UK2tKMlBXWUp2clYvcG1ETkUwTUVQ?=
 =?utf-8?B?MDZQMENJZG9heVRlZGVXeXVJOWE5bk9ZZlYvQ0p5UmczZE4wL3hWVFlKZDZ5?=
 =?utf-8?B?WjI2VHVISzBib1ZsMVhQS3JEVGlXelF1YkdLVzdhdDJTZThKbXVlQWNIdXJJ?=
 =?utf-8?B?eUlrVlprdllVb2JrcXFUeldsWEp1UUNzcCs5QUtHb3JmcVFYRDd5ODlxM3BM?=
 =?utf-8?B?aUxHOTl3Y2x5MElncjRYUnJ2aW10eGkzZDE1cCs0azM2dGFaZm1aN205L1Iv?=
 =?utf-8?B?WWhpNlB0RUdUMUFpVWk4MUZnYWlXRVJnN1AzeE9TVlUxeVJsb1BreW5HNXhU?=
 =?utf-8?B?THJTTS9vdEpmTWZTOXE2Y0Z3eFd0K0tTQk5NVDBSUHpRMXhyVnZIcHhYUjlv?=
 =?utf-8?B?L2lyeDd0ay82b3IxN01ldEZoU3ZyZkJ5bm52c2JnakoxUDZmQVFlR0hFd3pI?=
 =?utf-8?B?cHJqa2RpTGdCdktpNTlCN2VVclk3L1IvMml4QzF0Tk1YYTZndTAzQ1FabUs1?=
 =?utf-8?B?cjZDaEQ2ZGNoVHJidDduc3pkUUlZUmE4VDByblJRRmM5WVRzSUpUaUh0dkpl?=
 =?utf-8?B?SVRhalU0M29TL0pjVWw5VlErQzhuZHY5VkZHQXYwQmc4STlRQVI2aFhEZTEx?=
 =?utf-8?B?a2ZCQ3Yxd0V3ckpQT2Ntcm5lK3BvOFhNcWlOdDR1WVljbk9PWXZSWG5zL21t?=
 =?utf-8?B?OGZ5aERnYUFOaUZ5REVlUFJOb3RqRkUzRXBiZmRhM3p0bXJUU3VhK2xlRHZh?=
 =?utf-8?B?V0NqdkxCWjVUbTN4ekFDT2I3V0ZmV29GSHgzTUR1SUhKV0FWT1BqRDdGdW5l?=
 =?utf-8?B?VTJjUmRuTXhVY0xOeWpyUStHcllIOUxGYjRmSjdkWjVUankxY05rZEQxQmM2?=
 =?utf-8?B?WTExbUo1ZkVGYmUwRjB3ODVDUkxwYU9mYStPb0JBYUFDNU1Pc0x0WUtxOVRn?=
 =?utf-8?B?enBoaTVmQWt4NnNXWEtZa1JEVmorWm1VcWZQMURmNXJrUlRibis2dXJRNGtm?=
 =?utf-8?B?azRIcmVGNWc1RkhKalhiNC8wZndzSGNpUExxK2liRlBCM2xyUjJ2MVZYRlJp?=
 =?utf-8?B?bDl6MTlESzV5eEpiUnFqOHY4cjBpN2JLWDZXdnRlZEs3MUo1WFNGdXhMY0ZM?=
 =?utf-8?B?Y3FXdHN0a1Q0WkVjdk96YVI1Lzcra1ZRLzM4V2RvTWdjZXJRZlRZRGZrenVH?=
 =?utf-8?B?U2g0S0dMemxRbURmdktZREU2bVZFY1l5ZGhIT3NQYkJaUEpqQjJhNGxWc0dl?=
 =?utf-8?B?SisraWVQbGszakxTY1VrUkRRdG1UckdVNkVUcnVoVmJoT1IxQ1dUSVZGWVJ1?=
 =?utf-8?B?SWtFVXdiYk1wcFFqa2pmZ0V2T1N4dFY1L3RvQ0UyRHJNL0cwQngyWjZ1VE13?=
 =?utf-8?B?TXdRYUk3RkZyWTk5SDdQU29UVTJXNEJoUmI4SWt2MUhhbi85NWpMbDVRVnV4?=
 =?utf-8?B?WHJ3ejlBdzFGa3ZwcE1ObEVtSEQvbDFMZmdWY2tQN2R1bWlBVmZtMU41L1RR?=
 =?utf-8?B?eDFwcEt0Zm5IZXlVMXpjQjRxR3dwUzQ5QWxjMnVnZEdrWVVrbWJqL2dpclh6?=
 =?utf-8?Q?fTDlCHj8BSnttsR+peadWoNgt?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 02cb4c0e-b16f-4761-539c-08dc4fbb9687
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2024 06:43:48.2195
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Kee91VJrqe223H1hpQ+2X4X16majL8xY30Hw1bMz/HasMmTxo4ACyWFhfi8BTbzMfoKjLXPx0Gouqng5jmEpAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8055
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTmFtaHl1bmcgS2ltIDxu
YW1oeXVuZ0BrZXJuZWwub3JnPg0KPiBTZW50OiBUaHVyc2RheSwgTWFyY2ggMjgsIDIwMjQgMTA6
NDYgUE0NCj4gVG86IFdhbmcsIFdlaWxpbiA8d2VpbGluLndhbmdAaW50ZWwuY29tPg0KPiBDYzog
SWFuIFJvZ2VycyA8aXJvZ2Vyc0Bnb29nbGUuY29tPjsgQXJuYWxkbyBDYXJ2YWxobyBkZSBNZWxv
DQo+IDxhY21lQGtlcm5lbC5vcmc+OyBQZXRlciBaaWpsc3RyYSA8cGV0ZXJ6QGluZnJhZGVhZC5v
cmc+OyBJbmdvIE1vbG5hcg0KPiA8bWluZ29AcmVkaGF0LmNvbT47IEFsZXhhbmRlciBTaGlzaGtp
bg0KPiA8YWxleGFuZGVyLnNoaXNoa2luQGxpbnV4LmludGVsLmNvbT47IEppcmkgT2xzYSA8am9s
c2FAa2VybmVsLm9yZz47IEh1bnRlciwNCj4gQWRyaWFuIDxhZHJpYW4uaHVudGVyQGludGVsLmNv
bT47IEthbiBMaWFuZyA8a2FuLmxpYW5nQGxpbnV4LmludGVsLmNvbT47DQo+IGxpbnV4LXBlcmYt
dXNlcnNAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBUYXls
b3IsIFBlcnJ5DQo+IDxwZXJyeS50YXlsb3JAaW50ZWwuY29tPjsgQWx0LCBTYW1hbnRoYSA8c2Ft
YW50aGEuYWx0QGludGVsLmNvbT47IEJpZ2dlcnMsDQo+IENhbGViIDxjYWxlYi5iaWdnZXJzQGlu
dGVsLmNvbT4NCj4gU3ViamVjdDogUmU6IFtSRkMgUEFUQ0ggdjUgMS82XSBwZXJmIHN0YXQ6IFBh
cnNlIGFuZCBmaW5kIHRwZWJzIGV2ZW50cyB3aGVuDQo+IHBhcnNpbmcgbWV0cmljcyB0byBwcmVw
YXJlIGZvciBwZXJmIHJlY29yZCBzYW1wbGluZw0KPiANCj4gT24gVHVlLCBNYXIgMjYsIDIwMjQg
YXQgMToyOeKAr1BNIDx3ZWlsaW4ud2FuZ0BpbnRlbC5jb20+IHdyb3RlOg0KPiA+DQo+ID4gRnJv
bTogV2VpbGluIFdhbmcgPHdlaWxpbi53YW5nQGludGVsLmNvbT4NCj4gPg0KPiA+IE1ldHJpY3Mg
dGhhdCB1c2UgdHBlYnMgdmFsdWVzIHdvdWxkIHVzZSB0aGUgOnJldGlyZV9sYXRlbmN5IGtleXdv
cmQgaW4NCj4gPiBmb3JtdWxhcy4gV2UgcHV0IGFsbCB0aGVzZSBldmVudHMgaW50byBhIGxpc3Qg
YW5kIHBhc3MgdGhlIGxpc3QgdG8gcGVyZg0KPiA+IHJlY29yZCB0byBjb2xsZWN0IHRoZWlyIHJl
dGlyZSBsYXRlbmN5IHZhbHVlLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogV2VpbGluIFdhbmcg
PHdlaWxpbi53YW5nQGludGVsLmNvbT4NCj4gPiBSZXZpZXdlZC1ieTogSWFuIFJvZ2VycyA8aXJv
Z2Vyc0Bnb29nbGUuY29tPg0KPiA+IC0tLQ0KPiBbU05JUF0NCj4gPiBAQCAtNjgxLDggKzY4NSw1
NiBAQCBzdGF0aWMgaW50IG1ldHJpY2dyb3VwX19idWlsZF9ldmVudF9zdHJpbmcoc3RydWN0DQo+
IHN0cmJ1ZiAqZXZlbnRzLA0KPiA+ICAgICAgICAgaGFzaG1hcF9fZm9yX2VhY2hfZW50cnkoY3R4
LT5pZHMsIGN1ciwgYmt0KSB7DQo+ID4gICAgICAgICAgICAgICAgIGNvbnN0IGNoYXIgKnNlcCwg
KnJzZXAsICppZCA9IGN1ci0+cGtleTsNCj4gPiAgICAgICAgICAgICAgICAgZW51bSBwZXJmX3Rv
b2xfZXZlbnQgZXY7DQo+ID4gKyAgICAgICAgICAgICAgIC8qDQo+ID4gKyAgICAgICAgICAgICAg
ICAqIFBhcnNlIGFuZCBzZWFyY2ggZm9yIGV2ZW50IG5hbWUgd2l0aCByZXRpcmVfbGF0ZW5jeSBt
b2RpZmllci4NCj4gPiArICAgICAgICAgICAgICAgICogSWYgZm91bmQsIHB1dCBldmVudCBuYW1l
IGludG8gdGhlIHRwZWJzX2V2ZW50cyBsaXN0LiBUaGlzIGxpc3QNCj4gPiArICAgICAgICAgICAg
ICAgICogb2YgZXZlbnRzIHdpbGwgYmUgcGFzc2VkIHRvIHBlcmYgcmVjb3JkIGZvciBzYW1wbGlu
ZyB0byBnZXQNCj4gPiArICAgICAgICAgICAgICAgICogdGhlaXIgcmVpdHJlX2xhdGVuY3kgdmFs
dWUuDQo+ID4gKyAgICAgICAgICAgICAgICAqIFNlYXJjaCBmb3IgIjpSIiBpbiBldmVudCBuYW1l
IHdpdGhvdXQgIkAiLiBTZWFyY2ggZm9yIHRoZQ0KPiA+ICsgICAgICAgICAgICAgICAgKiBsYXN0
ICJAUiIgaW4gZXZlbnQgbmFtZSB3aXRoICJAIi4NCj4gDQo+IFdoYXQgaXMgdGhlIHJldGlyZV9s
YXRlbmN5IG1vZGlmaWVyIGV4YWN0bHk/DQo+IFdoeSBkbyB5b3Ugc2VhcmNoIGZvciA6UiBhbmQg
QFI/ICBXaGF0J3MgdGhlIGRpZmZlcmVuY2U/DQo+IFdoeSBkb24ndCB5b3Ugc2VhcmNoIGZvciAi
cmV0aXJlX2xhdGVuY3kiPw0KDQpXZSBkZWNpZGVkIHRvIHVzZSBSIGFzIHRoZSBtb2RpZmllciBm
b3IgcmV0aXJlX2xhdGVuY3kgaW4gb25lIG9mIHRoZSBwcmV2aW91cyANCnZlcnNpb24gb2YgY29k
ZSByZXZpZXcuIFRoZXJlZm9yZSwgdGhlIGNvZGUgc2VhcmNoZXMgZm9yIFIgaW5zdGVhZCBvZiAi
cmV0aXJlX2xhdGVuY3kiLg0KDQpJdCBzaG91bGQgc2VhcmNoIGZvciA6UiBpbiB1c3VhbCBjYXNl
cy4gQnV0IGluIGh5YnJpZCBwbGF0Zm9ybSwgZXZlbnQgbmFtZSBtaWdodCBiZSBpbiANCmZvcm1h
dCBsaWtlIGNwdV9jb3JlQGV2ZW50X25hbWVAUi4gDQoNClRoYW5rcywNCldlaWxpbg0KDQo+IFRo
YW5rcywNCj4gTmFtaHl1bmcNCj4gDQo+IA0KPiA+ICsgICAgICAgICAgICAgICAgKi8NCj4gPiAr
ICAgICAgICAgICAgICAgY2hhciAqcCA9IHN0cnN0cihpZCwgIjpSIik7DQo+ID4gKyAgICAgICAg
ICAgICAgIGNoYXIgKnAxID0gc3Ryc3RyKGlkLCAiQFIiKTsNCj4gPiArDQo+ID4gKyAgICAgICAg
ICAgICAgIGlmIChwID09IE5VTEwgJiYgcDEpIHsNCj4gPiArICAgICAgICAgICAgICAgICAgICAg
ICBwID0gc3Ryc3RyKHAxKzEsICJAUiIpOw0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIGlm
IChwID09IE5VTEwpDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBwID0gcDE7
DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgcCA9IHArMTsNCj4gPiArICAgICAgICAgICAg
ICAgfQ0KPiA+ICsNCj4gPiArICAgICAgICAgICAgICAgaWYgKHApIHsNCj4gPiArICAgICAgICAg
ICAgICAgICAgICAgICBjaGFyICpuYW1lOw0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIGNo
YXIgKmF0Ow0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCB0cGVic19ldmVudCAq
bmV3X2V2ZW50ID0gbWFsbG9jKHNpemVvZihzdHJ1Y3QNCj4gdHBlYnNfZXZlbnQpKTsNCj4gPg0K
PiA+IC0gICAgICAgICAgICAgICBwcl9kZWJ1ZygiZm91bmQgZXZlbnQgJXNcbiIsIGlkKTsNCj4g
PiArICAgICAgICAgICAgICAgICAgICAgICBpZiAoIW5ld19ldmVudCkNCj4gPiArICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHJldHVybiAtRU5PTUVNOw0KPiA+ICsNCj4gPiArICAgICAg
ICAgICAgICAgICAgICAgICBuZXdfZXZlbnQtPnRwZWJzX25hbWUgPSBzdHJkdXAoaWQpOw0KPiA+
ICsgICAgICAgICAgICAgICAgICAgICAgICpwID0gJ1wwJzsNCj4gPiArICAgICAgICAgICAgICAg
ICAgICAgICBuYW1lID0gbWFsbG9jKHN0cmxlbihpZCkgKyAyKTsNCj4gPiArICAgICAgICAgICAg
ICAgICAgICAgICBpZiAoIW5hbWUpDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICByZXR1cm4gLUVOT01FTTsNCj4gPiArDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgYXQg
PSBzdHJjaHIoaWQsICdAJyk7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgaWYgKGF0ICE9
IE5VTEwpIHsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICphdCA9ICcvJzsN
Cj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGF0ID0gc3RyY2hyKGlkLCAnQCcp
Ow0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKmF0ID0gJy8nOw0KPiA+ICsg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RyY3B5KG5hbWUsIGlkKTsNCj4gPiArICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cmNhdChuYW1lLCAicCIpOw0KPiA+ICsgICAg
ICAgICAgICAgICAgICAgICAgIH0gZWxzZSB7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBzdHJjcHkobmFtZSwgaWQpOw0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgc3RyY2F0KG5hbWUsICI6cCIpOw0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIH0N
Cj4gPiArICAgICAgICAgICAgICAgICAgICAgICBuZXdfZXZlbnQtPm5hbWUgPSBuYW1lOw0KPiA+
ICsgICAgICAgICAgICAgICAgICAgICAgICp0cGVic19ldmVudF9zaXplICs9IDE7DQo+ID4gKyAg
ICAgICAgICAgICAgICAgICAgICAgcHJfZGVidWcoInJldGlyZV9sYXRlbmN5IHJlcXVpcmVkLCB0
cGVic19ldmVudF9zaXplPSVsdSwNCj4gbmV3X2V2ZW50PSVzXG4iLA0KPiA+ICsgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgKnRwZWJzX2V2ZW50X3NpemUsIG5ld19ldmVudC0+bmFtZSk7
DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgbGlzdF9hZGRfdGFpbCgmbmV3X2V2ZW50LT5u
ZCwgdHBlYnNfZXZlbnRzKTsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICBjb250aW51ZTsN
Cj4gPiArICAgICAgICAgICAgICAgfQ0KPiA+DQo+ID4gICAgICAgICAgICAgICAgIC8qIEFsd2F5
cyBtb3ZlIHRvb2wgZXZlbnRzIG91dHNpZGUgb2YgdGhlIGdyb3VwLiAqLw0KPiA+ICAgICAgICAg
ICAgICAgICBldiA9IHBlcmZfdG9vbF9ldmVudF9fZnJvbV9zdHIoaWQpOw0K

