Return-Path: <linux-kernel+bounces-150930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F89F8AA6D3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 04:07:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99BBC1F229D0
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 02:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B354D4C85;
	Fri, 19 Apr 2024 02:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="Hqix7C9y"
Received: from esa7.fujitsucc.c3s2.iphmx.com (esa7.fujitsucc.c3s2.iphmx.com [68.232.159.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0554C6B;
	Fri, 19 Apr 2024 02:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.159.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713492427; cv=fail; b=sRK0voyr+4mo1qorY5MO4/I1oaScYwb3HUQYmxGCTpDlMbj0rIV4wa180ehWvkQCZg/hkKI0STZ0Si1iZrkg8qgFFndjUJSqTqSS14/H9+T3+SweVVxm5jghf8Y5H/cxgEDpxT3I3FCF6a9L0ydwOEOvIASWOnn7RnShujh3lyM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713492427; c=relaxed/simple;
	bh=82B9/UaxjkLTucMp+wRet1iJgmyTCfxOqzyx286emQs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kqc0uViws+MZIavg3EAcq7S2YhUBu0whA9GZCX9v5n6YshwrTo/akb8ByFIxKYb9ziEP+nA6tnjhxab/4umNHSyjVrJoEd/YzDM9dzB086UCN/Ss/Hs0t2rTk2GdaWz6kuQjxLnUgtDvNWF9IAg2GWB/gJW1mv8mer9nAAVtFJI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=Hqix7C9y; arc=fail smtp.client-ip=68.232.159.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1713492426; x=1745028426;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=82B9/UaxjkLTucMp+wRet1iJgmyTCfxOqzyx286emQs=;
  b=Hqix7C9ye/KbFeWJ+FhF5O1oc6Rd22VABiDiJzoUQTbai6JvjEmhor6w
   r8dHvUyodffUJvvTT0Sjf7if78HcTtOBIzQ4muk/HxNWlnSuL1WT/MXVK
   Jk4vK9xE+Gd4oHIutuziJI1ZCI/HiU+8z01cKm2OrckNt94mWJnMtH+K8
   naw/Wm2KJmH5+Cvp61J8/ZAs91qgqi0+l2KundZYumQV1N07iYXmgl+Pz
   6QlNNLeQKXfXUD8LeRFjZe3W34KCyKYx9DO6QqFeAZRIi/DHM9Rk/bcOe
   t2rvaq3P5XQIMsQ4Tp50+X1gSclKbj/tiI+neaEO0nJ8fugRXCrJy0d/c
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="117289075"
X-IronPort-AV: E=Sophos;i="6.07,213,1708354800"; 
   d="scan'208";a="117289075"
Received: from mail-os0jpn01lp2104.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.104])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2024 11:05:49 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Svaw1HWjVrDZ/MErGNVSF/jiJhyJu+HOH0ubUHuSGHqOyN495bQFxwfstaWYD3gV4i7GT65ApHA6PEs6mZxIwoZkvJ1Cp5ZbFW23feTrGwVzT/8gbtNZXcdPaAeS9iTisqVjTzfhPQggGsGEuj2m+bYZoDCP5KLy5j0r/fBC0DG1hS0VllwVKmnuH+2bDEHxsT6Ap6rI87FrRoQQZXBlMsfPN28wnN+e8QcBZwWibYIZWt1ezCU5mZJpbL110IZAMWc9+inTdHN0rHJB02ncsKQYeCY5jkeqXRPVHLy3FDFlRzH/8kV7/rM/Dh5mY+LWHVNKaFvdB5ojPMctXWw0wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=82B9/UaxjkLTucMp+wRet1iJgmyTCfxOqzyx286emQs=;
 b=hOIslnLPzSMmVCnnQw3GOQBp+9kX/lLwfCXC6qJZryXxZuRFIZgkPvlEEoJx5WOXf58mq2NyaHAoWWX6Kc805k1peUWEPsl1O6DQFjyLqJR+4awM+TOcqasNg2AbJr6Ctjai/fT6qDRBIRz1xzkoVd9ikDYUFMwSbc0e4dzuRNkYIdgaNmKQZqdwcMVN1DWmIvHzMpOqMWXxOG2LSXu3MUzNW0kGla7CUZh36qyxvoxNpzlwTZ6jVuYKNMeCInu69pkT5N6qhhO7uYnQCKLewE9r8GGKPcLIX3BSDb18tpV5ZvTDsVWxf5GrEq+BzZCYyDU2bVlP0CxKdTqEvrvK8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (2603:1096:403:6::12)
 by TYWPR01MB9647.jpnprd01.prod.outlook.com (2603:1096:400:1a2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.43; Fri, 19 Apr
 2024 02:05:45 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::8f3e:a36f:e4bb:8d33]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::8f3e:a36f:e4bb:8d33%6]) with mapi id 15.20.7472.037; Fri, 19 Apr 2024
 02:05:45 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>, Alison Schofield
	<alison.schofield@intel.com>, Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>, Borislav Petkov <bp@alien8.de>, Dan Williams
	<dan.j.williams@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, Dave
 Jiang <dave.jiang@intel.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, "hpa@zytor.com" <hpa@zytor.com>, Ingo Molnar
	<mingo@redhat.com>, Ira Weiny <ira.weiny@intel.com>, Thomas Gleixner
	<tglx@linutronix.de>, Vishal Verma <vishal.l.verma@intel.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, "linux-mm@kvack.org"
	<linux-mm@kvack.org>, "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
	"x86@kernel.org" <x86@kernel.org>, "kexec@lists.infradead.org"
	<kexec@lists.infradead.org>
Subject: Re: [RFC PATCH v3 0/7] device backed vmemmap crash dump support
Thread-Topic: [RFC PATCH v3 0/7] device backed vmemmap crash dump support
Thread-Index: AQHab7EiTzrhxogi+kGW9pFQmlxZOrFBxRcAgC1XswA=
Date: Fri, 19 Apr 2024 02:05:45 +0000
Message-ID: <1d337595-c244-4a60-9f12-d76b930c59e1@fujitsu.com>
References: <20240306102846.1020868-1-lizhijian@fujitsu.com>
 <92644ab5-6467-484c-b8f3-05cba2164cc1@fujitsu.com>
In-Reply-To: <92644ab5-6467-484c-b8f3-05cba2164cc1@fujitsu.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB1562:EE_|TYWPR01MB9647:EE_
x-ms-office365-filtering-correlation-id: 7c34266e-95dc-4961-0224-08dc601539a5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 XU52CVZg5g3klf/mZLXTJOt/7l4kHrw9VFZMDnjaPpZS9xjaPtXsXpJWFxiXiNGL00daMDPacq1R+SB2CoF60mI3zPpBHnjgx7AG5vS0q15Qm9Cffr1lhWzPvJSQyjYD3V3pMjwj3LtiFL9vEo0/E3Z3+9tBs0d7x+nL9LVCUzxVlI27U/RVfJFd9Dur+l69XmeQ2bxUJzxVnV4f+UzKaPHTH/TtJwatuEFgu6iW8Le/Qxxwfy19/MNGbmEjDI22nRs6L79Z4oPZGJ+LvZR2jj7cTYYSsl+0Fh+G3Nj1bQOUGdzMs+byUGuCjxkP0K/GYPIzjugy1EfuWSyvoFErh4r3RzDDuVagIdwvhFok3AditZQhnaCvHrNj0tyWqjp4h68OBOLsNZYudaLw8smjwuC+5HLtNJsLzu3dUHoOV0h3i/z3V4PTFeHRnaWPCgBZ4PdT5gavYyrLEm5jmcE31P5X4FsSJnZk3nOl4OYAOUnoVPgNvX1ksqbeSYDUYo2+CgfyZDPtrJIZpBSFc0y7LDD8TsD8z1Zm96XyHcbHjNfXkzjsOzuO31L//EFxqbJ1DtmN5gu6v2TeZTV36KBHuFcGT8GqiM6ENO6v7BFsm6PSBU82W9F5+4yewdRS99muDyJC75BrKe5wnJ+fkOEwPxD6h4Sd2+ixakriIgU16374AR3FjdE7N5saH5s5sRdP
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1562.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005)(1580799018)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WnNxbFpKbGplWWk4S1hmam9IdHMxYU5HekpweTR2OTZLaEF6cGNlWFhlSVp2?=
 =?utf-8?B?aUxuMDhXMERWQWNyd0NwVytwNzVDTGNyTWhFWXVrYjNKZmxQVnJWeXFvM2xS?=
 =?utf-8?B?aEpWcnorUkVUT0cxc01WZWltSm1nY3l0amliWDI0RW5HY2hINGVvUWRrY2hD?=
 =?utf-8?B?cXpiRXpxRVJEUE53SjREME10M1lVMEZIenB5WXJUYWRxOEdOMnNBZUdEMTFx?=
 =?utf-8?B?bUFWQWFGZjZGM280Y3l6ZllNdklja0VJdVg3RG4zQjAxb2FZNzdudWtGRWpw?=
 =?utf-8?B?R2xvakd6QytMT25IRzUxOUpqL2hDUkd0Ymlob1d2dStSeXEwTzBqdUIvbERK?=
 =?utf-8?B?UlFJMSsrWFhCRnkwTEw5WDc2b2gxclJmNWsxTy9lT1BjdTJtVjRLb0dHL1FT?=
 =?utf-8?B?TE5vMm45N29JWFkyUGNoWjc1SW1uVDgyT2RTOHlicEtEMkRaNnNENklHR2l5?=
 =?utf-8?B?WE84OFgrQStmcjBObjNJYlBFS3luc0V0VGY4em9sdkRJVk1xVWhzMVF4NmVN?=
 =?utf-8?B?WVZJQ0VtMjRUdlhzTTdRMFgzWHF6VkhDTm0waVZaSmkrWWMvU1FjNHFFRmp2?=
 =?utf-8?B?S0NqdEMwMGZPTWVnMEhjUnFmNWh4NmUrQnhGUnRMUmtxR2VZaHgwY1RENFp2?=
 =?utf-8?B?a0NaSlRyZStPcUFabnRVZTdyUFBuNjhlSUJYZ1hhUVhTbGg2U3VycFNUMDdU?=
 =?utf-8?B?UXVYMy8xTHVFRE5FZ3QrUWVXaDBMWnpZMXlTRmtNczJkdHdxU2w4N0xDWFcz?=
 =?utf-8?B?RmV1U3RockdtL0plU3l4TkFOSjVXZ1lUTGJja1hLZVRBWXlqSzNkMEthSnRp?=
 =?utf-8?B?Y2dHSEVKdTNXYnFyb0xDVFdDcU51MnFWTHpTVkZySXovUFowNDdkN1UwTUtC?=
 =?utf-8?B?eE44L0J1UWp4djN1czJIbkJ3TmxsUGhGN055aWhUekxtMDlrdTZlTHByRk9h?=
 =?utf-8?B?dy92eWNvekFnTjFSdkhianh3NGhYaGxobG5YbUtrTjR2bFdoL3RqUmZ5MHB3?=
 =?utf-8?B?QjZlNllpOEJ1L2V4d2RnY3NjK2JxbGdoLzJxSzVqTytLdG9vOERacldxSlhv?=
 =?utf-8?B?emt4U0RmNFVBcjlHRkRxYWZZd3plQ0FjV0hnMDNwb0Evb0xtYXpuNWNOM0dm?=
 =?utf-8?B?bTlHZ1FGRmFjMVBNdEU2U05NenJuUnRpOEVEbDdoc09FNndpaGJESCtSaWE0?=
 =?utf-8?B?b3pKZGpDY2F5dGx1OFNMSVJMcEZJS2Z5VDM4QkJlVytpTk5wWU1sRXFISVZ2?=
 =?utf-8?B?VEszVktTbGIyY2h3anlMZVRxU2NoZjNXQXRGaUdRY3JHWkVvMnFVeTZOV2R5?=
 =?utf-8?B?RXZ5OGsydmFQQ2hpSlptV29WTjZOMVBYMS9DSTFjaU9CMGdpNi9GRjNFT0dS?=
 =?utf-8?B?aU9oVFhqTS8wRXZvVndqMlNaZVVrZEo2R0NqL1BpTjc3UVJmR1hwcEFqUW5I?=
 =?utf-8?B?VUZUUzJXQzJuZmdsdmR5bUdNSWEvdjFnUFlIeVVua3c4T01ITG1td1c0dkMw?=
 =?utf-8?B?VFE0dnpxV09WUVVsOVR0VUdKVUlpaExwR3gzZDNvcmlXcnFTWTh4YW5nZFQv?=
 =?utf-8?B?ZnBuK3VpK2hueVpWU0RLTW0vM2xQME1nTUZJZW83TmRBTmxMc1J0aVUvUVZr?=
 =?utf-8?B?VTROdkV6ZC85ZEdhMXAvRDB5YnlwaWtLbXdRZDI5N2ZTa0tWS2NQby9WeEgr?=
 =?utf-8?B?WjY4YWprdDFxZUh0bGdsS2N1dWdVeWNiZDNXSVFoUUtpWHdSak81OTJFMC9L?=
 =?utf-8?B?eXJtUkV2WnZCUUxFUjg3SGVUQmdRTWxaZDJWNGRla1ByNGZqSWtWQ0VLb2pr?=
 =?utf-8?B?YWRkcXJMd0FrbGU3VHhibWliZjBQNWFCczZ5OWJxY1huZnZFWGxRQmVOU0Ro?=
 =?utf-8?B?NndEcTVYTnpRNTYrYnQ5TTMrcUdkTUxZNEhubXVUUjZnbmUxcC90NmpMNlEy?=
 =?utf-8?B?S001Q3FYZmlUNEpPUTd2MkY4VHJ0T3E0cmpZQUtTajJyMlVHMGMwSGlEdTI2?=
 =?utf-8?B?VE1Ub0J0dDBmV2VOS3Z4dUR0bnFBWWw1bjEwUGtSTzREc2lSVnJlRDlsYm1C?=
 =?utf-8?B?dXpWVlk5eEEwSVlqUlJUNGNybWhKTEJ0VUNPRXlPZEMvY0ljajZYd1lDRnRq?=
 =?utf-8?B?RDVSSVJzdXBTVFgwVE5MTjVQMktNcitxOWxvVmY0NDF6RG9vYzdoQU12TXNp?=
 =?utf-8?B?eEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C59B5FE0DA897140A4944B4364ECDC32@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	N0rD8LcayQTJ5B4OwcxF0TeVl/Qw/8eHKN3+nUn/nUJrZV3lG5z17nkEzWRj32mEFtMZRY9JixXxhmon2lLmvQirRXDTiuGbT0ZKI/t1Sj/KKGmS6Sbw3gdYUVWVLU5CXnqhurylYam1ZozHAzBN83dR0gZaK6R6g4NUIKV3DXDgNUjCM0K8E1lsUFW/smcbuKawbGEIphXx+L//eP2m1/ShbbT8HFsm71sgCgJsooq1+atVqi23c1pH6w0awDQLdysAoGD2lEGaJ1oNplKK305dhXgFiMRcpHCMC2Rn83FdtjSwy5rliCmy4bye9WsUvZ42q3G20vrlH5Nsof4k8gGWrlZnNO/msQ84pysfZg37wYlbjMbLbTkc+4Ey5KN5m6UQiVqfLcUfdVjHTuITjvuAqYDpSZcomovfOmaSHsWhk/ytcqOGCfWA4dhr2N3wEUY66E+eAYGL2BfiObwUsfOijz69WegN5eaq/E6UmGZ8PB0UVneJRkVDr5Wm6y14Kogw8Ot+OSouC3m0LRwfcwLsISFhJ+mxa20HHCUIQb6wZ2gDCctEI7VgNozc9AMmMhyidZC8USs43AzrmU7T2HEpSLHrrQd985O4WWYTLc72qsCBIuVa/eUs93D2eWBq
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1562.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c34266e-95dc-4961-0224-08dc601539a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2024 02:05:45.7358
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X+I0U23ZAQqn+wqfP+YuUD7W4SLWHQK40AEhptimWmb58OIU2Mjxr0GkSI1QZ0N/wzYYXTSPfnUXTWwELOS+kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9647

DQpwaW5nIGFnYWluLA0KDQpJIHdvdWxkIGFwcHJlY2lhdGUgZmVlZGJhY2sgZnJvbSB0aGUgbnZk
aW1tIGFuZCBsaW51eC1tbSBjb21tdW5pdGllcw0KDQpUaGFua3MNClpoaWppYW4NCg0KDQpPbiAy
MS8wMy8yMDI0IDEzOjQwLCBMaSBaaGlqaWFuIHdyb3RlOg0KPiBwaW5nDQo+IA0KPiANCj4gQW55
IGNvbW1lbnQgaXMgd2VsY29tZS4NCj4gDQo+IA0KPiBPbiAwNi8wMy8yMDI0IDE4OjI4LCBMaSBa
aGlqaWFuIHdyb3RlOg0KPj4gSGVsbG8gZm9sa3MsDQo+Pg0KPj4gQ29tcGFyZWQgd2l0aCB0aGUg
VjJbMV0gSSBwb3N0ZWQgYSBsb25nIHRpbWUgYWdvLCB0aGlzIHRpbWUgaXQgaXMgYQ0KPj4gY29t
cGxldGVseSBuZXcgcHJvcG9zYWwgZGVzaWduLg0KPj4NCj4+ICMjIyBCYWNrZ3JvdW5kIGFuZCBt
b3RpdmF0ZSBvdmVydmlldyAjIyMNCj4+IC0tLQ0KPj4gQ3Jhc2ggZHVtcCBpcyBhbiBpbXBvcnRh
bnQgZmVhdHVyZSBmb3IgdHJvdWJsZXNob290aW5nIHRoZSBrZXJuZWwuIEl0IGlzIHRoZQ0KPj4g
ZmluYWwgd2F5IHRvIGNoYXNlIHdoYXQgaGFwcGVuZWQgYXQgdGhlIGtlcm5lbCBwYW5pYywgc2xv
d2Rvd24sIGFuZCBzbyBvbi4gSXQNCj4+IGlzIG9uZSBvZiB0aGUgbW9zdCBpbXBvcnRhbnQgdG9v
bHMgZm9yIGN1c3RvbWVyIHN1cHBvcnQuDQo+Pg0KPj4gQ3VycmVudGx5LCB0aGVyZSBhcmUgMiBz
eXNjYWxscyhrZXhlY19maWxlX2xvYWQoMikgYW5kIGtleGVjX2xvYWQoMikpIHRvDQo+PiBjb25m
aWd1cmUgdGhlIGR1bXBhYmxlIHJlZ2lvbnMuIEdlbmVyYWxseSwgKEEpaW9tZW0gcmVzb3VyY2Vz
IHJlZ2lzdGVyZWQgd2l0aA0KPj4gZmxhZ3MgKElPUkVTT1VSQ0VfU1lTVEVNX1JBTSB8IElPUkVT
T1VDRV9CVVNZKSBmb3Iga2V4ZWNfZmlsZV9sb2FkKDIpIG9yDQo+PiAoQilpb21lbSByZXNvdXJj
ZXMgcmVnaXN0ZXJlZCB3aXRoICJTeXN0ZW0gUkFNIiBuYW1lIHByZWZpeCBmb3Iga2V4ZWNfbG9h
ZCgyKQ0KPj4gYXJlIGR1bXBhYmxlLg0KPj4NCj4+IFRoZSBwbWVtIHVzZSBjYXNlcyBpbmNsdWRp
bmcgZnNkYXggYW5kIGRldmRheCwgY291bGQgbWFwIHRoZWlyIHZtZW1tYXAgdG8NCj4+IHRoZWly
IG93biBkZXZpY2VzLiBJbiB0aGlzIGNhc2UsIHRoZXNlIHBhcnQgb2Ygdm1lbW1hcCB3aWxsIG5v
dCBiZSBkdW1wZWQgd2hlbg0KPj4gY3Jhc2ggaGFwcGVuZWQgc2luY2UgdGhlc2UgcmVnaW9ucyBh
cmUgc2F0aXNmaWVkIHdpdGggbmVpdGhlciB0aGUgYWJvdmUgKEEpDQo+PiBub3IgKEIpLg0KPj4N
Cj4+IEluIGZzZGF4LCB0aGUgdm1lbW1hcChzdHJ1Y3QgcGFnZSBhcnJheSkgYmVjb21lcyB2ZXJ5
IGltcG9ydGFudCwgaXQgaXMgb25lIG9mDQo+PiB0aGUga2V5IGRhdGEgdG8gZmluZCBzdGF0dXMg
b2YgcmV2ZXJzZSBtYXAuIExhY2tpbmcgb2YgdGhlIGluZm9ybWF0aW9uIG1heQ0KPj4gY2F1c2Ug
ZGlmZmljdWx0eSB0byBhbmFseXplIHRyb3VibGUgYXJvdW5kIHBtZW0gKGVzcGVjaWFsbHkgRmls
ZXN5c3RlbS1EQVgpLg0KPj4gVGhhdCBtZWFucyB0cm91Ymxlc2hvb3RlcnMgYXJlIHVuYWJsZSB0
byBjaGVjayBtb3JlIGRldGFpbHMgYWJvdXQgcG1lbSBmcm9tDQo+PiB0aGUgZHVtcGZpbGUuDQo+
Pg0KPj4gIyMjIFByb3Bvc2FsICMjIw0KPj4gLS0tDQo+PiBJbiB0aGlzIHByb3Bvc2FsLCByZWdp
c3RlciB0aGUgZGV2aWNlIGJhY2tlZCB2bWVtbWFwIGFzIGEgc2VwYXJhdGUgcmVzb3VyY2UuDQo+
PiBUaGlzIHJlc291cmNlIGhhcyBpdHMgb3duIG5ldyBmbGFnIGFuZCBuYW1lLCBhbmQgdGhlbiB0
ZWFjaGVzIGtleGVjX2ZpbGVfbG9hZCgyKQ0KPj4gYW5kIGtleGVjX2xvYWQoMikgdG8gbWFyayBp
dCBhcyBkdW1wYWJsZS4NCj4+DQo+PiBQcm9wb3NlZCBmbGFnOiBJT1JFU09VUkNFX0RFVklDRV9C
QUNLRURfVk1FTU1BUA0KPj4gUHJvcG9zZWQgbmFtZTogIkRldmljZSBCYWNrZWQgVm1lbW1hcCIN
Cj4+DQo+PiBOT1RFOiBjcmFzaC11dGlscyBhbHNvIG5lZWRzIHRvIGFkYXB0IHRvIHRoaXMgbmV3
IG5hbWUgZm9yIGtleGVjX2xvYWQoKQ0KPj4NCj4+IFdpdGggY3VycmVudCBwcm9wb3NhbCwgdGhl
IC9wcm9jL2lvbWVtIHNob3VsZCBzaG93IGFzIGZvbGxvd2luZyBmb3IgZGV2aWNlDQo+PiBiYWNr
ZWQgdm1lbW1hcA0KPj4gIyBjYXQgL3Byb2MvaW9tZW0NCj4+IC4uLg0KPj4gZmZmYzAwMDAtZmZm
ZmZmZmYgOiBSZXNlcnZlZA0KPj4gMTAwMDAwMDAwLTEzZmZmZmZmZiA6IFBlcnNpc3RlbnQgTWVt
b3J5DQo+PiDCoMKgIDEwMDAwMDAwMC0xMGZmZmZmZmYgOiBuYW1lc3BhY2UwLjANCj4+IMKgwqDC
oMKgIDEwMDAwMDAwMC0xMDA1ZmZmZmYgOiBEZXZpY2UgQmFja2VkIFZtZW1tYXDCoCAjIGZzZGF4
DQo+PiBhODAwMDAwMDAtYjdmZmZmZmZmIDogQ1hMIFdpbmRvdyAwDQo+PiDCoMKgIGE4MDAwMDAw
MC1hZmZmZmZmZmYgOiBQZXJzaXN0ZW50IE1lbW9yeQ0KPj4gwqDCoMKgwqAgYTgwMDAwMDAwLWFm
ZmZmZmZmZiA6IHJlZ2lvbjENCj4+IMKgwqDCoMKgwqDCoCBhODAwMDAwMDAtYTgxMWZmZmZmIDog
bmFtZXNwYWNlMS4wDQo+PiDCoMKgwqDCoMKgwqDCoMKgIGE4MDAwMDAwMC1hODExZmZmZmYgOiBE
ZXZpY2UgQmFja2VkIFZtZW1tYXAgIyBkZXZkYXgNCj4+IMKgwqDCoMKgwqDCoCBhODEyMDAwMDAt
YWJmZmZmZmZmIDogZGF4MS4wDQo+PiBiODAwMDAwMDAtYzdmZmZmZmZmIDogQ1hMIFdpbmRvdyAx
DQo+PiBjODAwMDAwMDAtMTQ3ZmZmZmZmZiA6IFBDSSBCdXMgMDAwMDowMA0KPj4gwqDCoCBjODAw
MDAwMDAtYzgwMWZmZmZmIDogUENJIEJ1cyAwMDAwOjAxDQo+PiAuLi4NCj4+DQo+PiAjIyMgS2R1
bXAgc2VydmljZSByZWxvYWRpbmcgIyMjDQo+PiAtLS0NCj4+IE9uY2UgdGhlIGtkdW1wIHNlcnZp
Y2UgaXMgbG9hZGVkLCBpZiBjaGFuZ2VzIHRvIENQVXMgb3IgbWVtb3J5IG9jY3VyLA0KPj4gZWl0
aGVyIGJ5IGhvdCB1bi9wbHVnIG9yIG9mZi9vbmxpbmluZywgdGhlIGNyYXNoIGVsZmNvcmVoZHIg
c2hvdWxkIGFsc28NCj4+IGJlIHVwZGF0ZWQuIFRoZXJlIGFyZSAyIGFwcHJvYWNoZXMgdG8gbWFr
ZSB0aGUgcmVsb2FkaW5nIG1vcmUgZWZmaWNpZW50Lg0KPj4gMSkgVXNlIHVkZXYgcnVsZXMgdG8g
d2F0Y2ggQ1BVIGFuZCBtZW1vcnkgZXZlbnRzLCB0aGVuIHJlbG9hZCBrZHVtcA0KPj4gMikgRW5h
YmxlIGtlcm5lbCBjcmFzaCBob3RwbHVnIHRvIGF1dG9tYXRpY2FsbHkgcmVsb2FkIGVsZmNvcmVo
ZHIgKD49IDYuNSkNCj4+DQo+PiBUaGlzIHJlbG9hZGluZyBhbHNvIG5lZWRlZCB3aGVuIGRldmlj
ZSBiYWNrZWQgdm1lbW1hcCBsYXlvdXRzIGNoYW5nZSwgU2ltaWxhcg0KPj4gdG8gd2hhdCAxKSBk
b2VzIG5vdywgb25lIGNvdWxkIGFkZCB0aGUgZm9sbG93aW5nIGFzIHRoZSBmaXJzdCBsaW5lcyB0
byB0aGUNCj4+IFJIRUwgdWRldiBydWxlIGZpbGUgL3Vzci9saWIvdWRldi9ydWxlcy5kLzk4LWtl
eGVjLnJ1bGVzOg0KPj4NCj4+ICMgbmFtZXNwYWNlIHVwZGF0ZWQ6IHdhdGNoIGRheFguWShkZXZk
YXgpIGFuZCBwZm5YLlkoZnNkYXgpIG9mIG5kDQo+PiBTVUJTWVNURU09PSJuZCIsIEtFUk5FTD09
IltkcF1bYWZdW3huXVswLTldLioiLCBBQ1RJT049PSJiaW5kIiwgR09UTz0ia2R1bXBfcmVsb2Fk
Ig0KPj4gU1VCU1lTVEVNPT0ibmQiLCBLRVJORUw9PSJbZHBdW2FmXVt4bl1bMC05XS4qIiwgQUNU
SU9OPT0idW5iaW5kIiwgR09UTz0ia2R1bXBfcmVsb2FkIg0KPj4gIyBkZXZkYXggPC0+IHN5c3Rl
bS1yYW0gdXBkYXRlZDogd2F0Y2ggZGF4WC5ZIG9mIGRheA0KPj4gU1VCU1lTVEVNPT0iZGF4Iiwg
S0VSTkVMPT0iZGF4WzAtOV0uKiIsIEFDVElPTj09ImJpbmQiLCBHT1RPPSJrZHVtcF9yZWxvYWQi
DQo+PiBTVUJTWVNURU09PSJkYXgiLCBLRVJORUw9PSJkYXhbMC05XS4qIiwgQUNUSU9OPT0idW5i
aW5kIiwgR09UTz0ia2R1bXBfcmVsb2FkIg0KPj4NCj4+IFJlZ2FyZGluZyAyKSwgbXkgaWRlYSBp
cyB0aGF0IGl0IHdvdWxkIG5lZWQgdG8gY2FsbCB0aGUgbWVtb3J5X25vdGlmeSgpIGluDQo+PiBk
ZXZtX21lbXJlbWFwX3BhZ2VzX3JlbGVhc2UoKSBhbmQgZGV2bV9tZW1yZW1hcF9wYWdlcygpIHRv
IHRyaWdnZXIgdGhlIGNyYXNoDQo+PiBob3RwbHVnLiBUaGlzIHBhcnQgaXMgbm90IHlldCBtYXR1
cmUsIGJ1dCBpdCBkb2VzIG5vdCBhZmZlY3QgdGhlIHdob2xlIGZlYXR1cmUNCj4+IGJlY2F1c2Ug
d2UgY2FuIHN0aWxsIHVzZSBtZXRob2QgMSkgYWx0ZXJuYXRpdmVseS4NCj4+DQo+PiBbMV0gaHR0
cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8wMjA2NmYwZi1kYmMwLTAzODgtNDIzMy04ZTI0YjZm
ODQzNWJAZnVqaXRzdS5jb20vVC8NCj4+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tDQo+PiBjaGFuZ2VzIGZyb20gVjJbMV0NCj4+IC0gbmV3IHByb3Bvc2FsIGRl
c2lnbg0KPj4NCj4+IENDOiBBbGlzb24gU2Nob2ZpZWxkIDxhbGlzb24uc2Nob2ZpZWxkQGludGVs
LmNvbT4NCj4+IENDOiBBbmRyZXcgTW9ydG9uIDxha3BtQGxpbnV4LWZvdW5kYXRpb24ub3JnPg0K
Pj4gQ0M6IEJhb3F1YW4gSGUgPGJoZUByZWRoYXQuY29tPg0KPj4gQ0M6IEJvcmlzbGF2IFBldGtv
diA8YnBAYWxpZW44LmRlPg0KPj4gQ0M6IERhbiBXaWxsaWFtcyA8ZGFuLmoud2lsbGlhbXNAaW50
ZWwuY29tPg0KPj4gQ0M6IERhdmUgSGFuc2VuIDxkYXZlLmhhbnNlbkBsaW51eC5pbnRlbC5jb20+
DQo+PiBDQzogRGF2ZSBKaWFuZyA8ZGF2ZS5qaWFuZ0BpbnRlbC5jb20+DQo+PiBDQzogR3JlZyBL
cm9haC1IYXJ0bWFuIDxncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz4NCj4+IENDOiAiSC4gUGV0
ZXIgQW52aW4iIDxocGFAenl0b3IuY29tPg0KPj4gQ0M6IEluZ28gTW9sbmFyIDxtaW5nb0ByZWRo
YXQuY29tPg0KPj4gQ0M6IElyYSBXZWlueSA8aXJhLndlaW55QGludGVsLmNvbT4NCj4+IENDOiBU
aG9tYXMgR2xlaXhuZXIgPHRnbHhAbGludXRyb25peC5kZT4NCj4+IENDOiBWaXNoYWwgVmVybWEg
PHZpc2hhbC5sLnZlcm1hQGludGVsLmNvbT4NCj4+IENDOiBsaW51eC1jeGxAdmdlci5rZXJuZWwu
b3JnDQo+PiBDQzogbGludXgtbW1Aa3ZhY2sub3JnDQo+PiBDQzogbnZkaW1tQGxpc3RzLmxpbnV4
LmRldg0KPj4gQ0M6IHg4NkBrZXJuZWwub3JnDQo+Pg0KPj4gTGkgWmhpamlhbiAoNyk6DQo+PiDC
oMKgIG1tOiBtZW1yZW1hcDogcmVnaXN0ZXIvdW5yZWdpc3RlciBhbHRtYXAgcmVnaW9uIHRvIGEg
c2VwYXJhdGUgcmVzb3VyY2UNCj4+IMKgwqAgbW06IG1lbXJlbWFwOiBhZGQgcGdtYXBfcGFyZW50
X3Jlc291cmNlKCkgaGVscGVyDQo+PiDCoMKgIG52ZGltbTogcG1lbTogYXNzaWduIGEgcGFyZW50
IHJlc291cmNlIGZvciB2bWVtbWFwIHJlZ2lvbiBmb3IgdGhlDQo+PiDCoMKgwqDCoCBmc2RheA0K
Pj4gwqDCoCBkYXg6IHBtZW06IGFzc2lnbiBhIHBhcmVudCByZXNvdXJjZSBmb3Igdm1lbW1hcCBy
ZWdpb24gZm9yIHRoZSBkZXZkYXgNCj4+IMKgwqAgcmVzb3VyY2U6IEludHJvZHVjZSB3YWxrIGRl
dmljZV9iYWNrZWRfdm1lbW1hcCByZXMoKSBoZWxwZXINCj4+IMKgwqAgeDg2L2NyYXNoOiBtYWtl
IGRldmljZSBiYWNrZWQgdm1lbW1hcCBkdW1wYWJsZSBmb3Iga2V4ZWNfZmlsZV9sb2FkDQo+PiDC
oMKgIG52ZGltbTogc2V0IGZvcmNlX3Jhdz0xIGluIGtkdW1wIGtlcm5lbA0KPj4NCj4+IMKgIGFy
Y2gveDg2L2tlcm5lbC9jcmFzaC5jwqDCoMKgwqDCoMKgwqDCoCB8wqAgNSArKysrKw0KPj4gwqAg
ZHJpdmVycy9kYXgvcG1lbS5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDggKysrKysr
LS0NCj4+IMKgIGRyaXZlcnMvbnZkaW1tL25hbWVzcGFjZV9kZXZzLmMgfMKgIDMgKysrDQo+PiDC
oCBkcml2ZXJzL252ZGltbS9wbWVtLmPCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgOSArKysrKyst
LS0NCj4+IMKgIGluY2x1ZGUvbGludXgvaW9wb3J0LmjCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDQg
KysrKw0KPj4gwqAgaW5jbHVkZS9saW51eC9tZW1yZW1hcC5owqDCoMKgwqDCoMKgwqAgfMKgIDQg
KysrKw0KPj4gwqAga2VybmVsL3Jlc291cmNlLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHwgMTMgKysrKysrKysrKysrKw0KPj4gwqAgbW0vbWVtcmVtYXAuY8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCB8IDMwICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrLQ0K
Pj4gwqAgOCBmaWxlcyBjaGFuZ2VkLCA3MCBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQ0K
Pj4=

