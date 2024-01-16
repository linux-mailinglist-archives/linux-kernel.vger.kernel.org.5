Return-Path: <linux-kernel+bounces-27083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D41C082EA24
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 08:37:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BD98B22903
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 07:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E32411188;
	Tue, 16 Jan 2024 07:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="VZbw27LF"
Received: from esa7.fujitsucc.c3s2.iphmx.com (esa7.fujitsucc.c3s2.iphmx.com [68.232.159.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C34910A3B;
	Tue, 16 Jan 2024 07:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1705390618; x=1736926618;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=3efeIyZdI+BbtbxQWCBKXEnSS7HK4QGtw5AFnOPqGWw=;
  b=VZbw27LF/igXKRN9Qo9/t5ybjlGZPoNzRdUVsrVI/wSBpt05Oy3tGEA2
   jiPvLBMdhEHKajNJ2hv12FwRhRJETERy1kqlEFpkzS8gfBF9C2Oh2/HqN
   5WpgALJccctVM7jDtfIjmDY/Z9n9Vtgv+b4Vj7twjwNHxMv7BM09DbtGp
   Jaz8mWfx59iDjvc+q0tuqcNe/2z6glZH/VmAJDmW9yUcC/43tobdfX2Uk
   nHls5GxiuvSCiuM6e93zVvf4gfCh83uB0OfGQntf/C6e7k90B9rBNAIhi
   9MnStrvTrNc5lNx49+Gaokl47Lvs5HUh4X7lxKkmxm7bdO5kxdXimrZdl
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="108295240"
X-IronPort-AV: E=Sophos;i="6.04,198,1695654000"; 
   d="scan'208";a="108295240"
Received: from mail-tycjpn01lp2168.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.168])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2024 16:35:43 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CzE3TZ60u0sRjmt6F3yERsR0H2/NAzlAzMvLTPHwXt+cQkjQvqVU4V4PVoDsFQjQGzN3H1dw+PAZYXn2CU70B5YoJphx6iHZV9qX19wbX8bd9cQsiIpUH7REUL2D/LItlrvazs+Yi/Gxa4ba71kPZpezcl7IzMnTiJBsEseb6Mp8I12FduGwRaMxkDMkSbjLWTh6vzh5AwGqWrbUq+ug0FysU+JPWguZM18UvqGILRAMh05nL/akKj9DFyoQFDQCBZ4IS/hq8hrlpk5glCk3NBsr0MivahiPz4BASjlh/J0e9lRGHJZ5cYOoNLbU6RXdA3XnoA0BADV//fmZsqWiUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3efeIyZdI+BbtbxQWCBKXEnSS7HK4QGtw5AFnOPqGWw=;
 b=JobiosPsv5/8VPBnugB25gjmWp2E9SW5Ae9T+Udq/2HTtW51DZ6ZyiDT6rub9W85EIrKl75O5rE3WNjxIhC1lK63e73JhTUfOtbPXOZWaVSFz9IutD5lpm0lM9rCGogB/pqT0mmMuPmlg+sNDn4rjAJ5TWgR0AQRcKXv+JBQnvmB+cQ1RIhlOcPXPYoYvJM7qOHJk6C1T84nletRxDuo9ba6enz9yY76boXuOLVOOC/phxY36mfIL69V+HA9Ku3hgQv4hn3WHQSB2KsHprP8pirnx5BLBEGtPAFHWNtGBGdi/t5vrF4snjZm93sFkdMZJ6N+5rPCQ6/YpyAap9UgNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS0PR01MB5442.jpnprd01.prod.outlook.com (2603:1096:604:a6::10)
 by TYCPR01MB10214.jpnprd01.prod.outlook.com (2603:1096:400:1ee::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.22; Tue, 16 Jan
 2024 07:35:31 +0000
Received: from OS0PR01MB5442.jpnprd01.prod.outlook.com
 ([fe80::c96f:52b0:dd4e:8d50]) by OS0PR01MB5442.jpnprd01.prod.outlook.com
 ([fe80::c96f:52b0:dd4e:8d50%6]) with mapi id 15.20.7202.020; Tue, 16 Jan 2024
 07:35:30 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Adrian Hunter <adrian.hunter@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland
	<mark.rutland@arm.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung
 Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, Thomas Gleixner
	<tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, "H. Peter
 Anvin" <hpa@zytor.com>, "linux-perf-users@vger.kernel.org"
	<linux-perf-users@vger.kernel.org>
Subject: Re: [PATCH 04/42] arch/x86/events/core: Convert snprintf to
 sysfs_emit
Thread-Topic: [PATCH 04/42] arch/x86/events/core: Convert snprintf to
 sysfs_emit
Thread-Index: AQHaSDfILN9CUWpr00qL+s2Qx0vCJrDcAziAgAAJfoA=
Date: Tue, 16 Jan 2024 07:35:30 +0000
Message-ID: <3f26722a-e838-4674-9617-87aea0a5d6ea@fujitsu.com>
References: <20240116041129.3937800-1-lizhijian@fujitsu.com>
 <20240116045151.3940401-1-lizhijian@fujitsu.com>
 <20240116045151.3940401-2-lizhijian@fujitsu.com>
 <c9a3f5b7-4f81-4d24-835b-c365d7d61995@intel.com>
In-Reply-To: <c9a3f5b7-4f81-4d24-835b-c365d7d61995@intel.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5442:EE_|TYCPR01MB10214:EE_
x-ms-office365-filtering-correlation-id: 05ae9993-4b87-4a1d-b7c5-08dc1665b790
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 TRsYysx9/ZToqWM/tOIXkBMCBKhq2PoxXwMyu3+jSI4G17nGJoAp2ziYj3LQt8i+VitYMR/eQePG+vBvJE9Tnn99LENZbHkG2liJ+HE9Fylv2X6MMgP3hpX12VkJQoAUVf8Lb47NVKqovQ4yoadtBd3n0+E8d1dmhcxIoHQccwNGa/s6EqvTa9skDHExALZGRIZhSxWHIJy/jLQ1eX5D+D8XIgs8+BOZu0QSXZL+a6GAKm9twFI4iJ/73h7S8E7jvErUzxL9ciJNr4X3ugK/UEw5XgOLj5Bo/R3s8zrcqMsXZcsSV+kJSLFFfmhQKkbO55w7RtuL4w7iKtNY0JFTn3SnJ+MN39oc42jypP64B1rseiRpgAN1qX78dCFkPnZUQGabdtD98SMdgTpbweijIunDLrollyRHF3eDcr5mBGcivJtrmlB8DGrq5LmnVqqCu/6TDGo5DcMlC/pomBIlFcBZQ/hBH2cELthUfQBmW/DA6mgpgU7xP+2JStULq3r4NtGH8GlKpd2lfNA+y2ff+gLGwvTT7+IjsYdkIGxapcNJMlZde252fahxeO16Yr5/nlhAo9llHU4JjgVk6chStWZOhe8Haj5FgsYpD2wwfcAAXAk4lJ/NecE9EJDyOTuj2P7d40Cmm1ZEruDN52pQvD0GsVMnOcrvDZer6aYjH6NR3mFHsNYqGEWn5d8fNB2rgV7swule5lNfmQ9oanWgYw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5442.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(396003)(39860400002)(136003)(366004)(230922051799003)(451199024)(1800799012)(1590799021)(186009)(64100799003)(71200400001)(2616005)(26005)(122000001)(38100700002)(316002)(76116006)(110136005)(91956017)(66446008)(66476007)(66556008)(54906003)(64756008)(66946007)(8676002)(5660300002)(8936002)(7416002)(6512007)(6506007)(4326008)(2906002)(4744005)(6486002)(53546011)(478600001)(36756003)(82960400001)(31696002)(86362001)(85182001)(41300700001)(38070700009)(1580799018)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WUp6Zk5WQWM2Ri9hempCSDJsdFFWUy9JSUlpN2dJaloxVXg4UEdpN20xYWpP?=
 =?utf-8?B?ajR0SEtXRlZVOVlSZ3BBd3lxUENBTENSa3VvMC9rWktGQnpmT0VKbHM0U1dh?=
 =?utf-8?B?cThjUk82WUVYbkNyaDFIdGp6YUUrQkFmb3IxcFlGNTRoZzVtMTlWdW5EUTZh?=
 =?utf-8?B?ZEhpZjl3amZsSy9HdnZzOU1qckVCaVVNcUtMM0xnU3dhR1RGY0s3R3FhSU9C?=
 =?utf-8?B?cXgxcUoybi9RSHZ3blVIUWhrT3FmOXg5SG9jY21mckh0bkV6MXZaMUJ4TW1C?=
 =?utf-8?B?V25DckNoZVNCVVNmZWpCM0ZpZmVpK3czcVBJTC9GaFJneWJMdXFBMytvZ0tP?=
 =?utf-8?B?TUN0OVNrbzBTOGxDTzJxeTlrbmtubFI3SFVrVFFJYjZvYTd2S2FmT0xUYURp?=
 =?utf-8?B?NjU2aHUxdzR2S3l0V242enJ5ZC9lZU14dSt0Wm1FbWp3N2oyRVhHc0YzU0VT?=
 =?utf-8?B?dUthcjhCYUF5Z2lZZkliS0lGUGh1ZFpBNGluYmpZRDBnVE9pc3B4L2YwZEpT?=
 =?utf-8?B?Q09HVWpxR0FWTkpLdVlxRHpqeWJOL1pWTnNTYlpvN2t0b3J5U295UEFnWWxL?=
 =?utf-8?B?SmlWcGRHZGI0MGxyeHByVnZoTERLbDhDa2JJb3I0ZWtCWHhtRTc2UXFsSGF6?=
 =?utf-8?B?RFdFblpLMUMwWWRobGRtaTViRVFOVjZRNFp4aUFLSjFrd1YzZElLeERXbDZa?=
 =?utf-8?B?b2pGc0hZbHNNVW5PZno1akcwKzRncVRtRUkyaU5Cb0x0enVsdjBDUGRLcm5j?=
 =?utf-8?B?QUpqMXU3bWRKeTh1YWtsWWZQRTM5WGRzejFRVmloZjRud1YzV004WmFta1VZ?=
 =?utf-8?B?L0F2M2dkT0ZrNU1KK0lYZVBoVGlIWUZtaFJOR3hOZUJ4cm80YW5WRUJqZncz?=
 =?utf-8?B?MmtXMHBxc3lxUTU2MFFzUEZVMURlK0czRGxLc2VSR0E5V2wyYWNBK3BnOFZN?=
 =?utf-8?B?bjNvNXAyMkdkWDdCRW16RWRhcFhKY2puVnJWZWI3NHdidUlXN0pqNjYyNjVV?=
 =?utf-8?B?TzlXTjZXNzdTaWQ2Y2JvK002K29PU1R3aUFERHlVaStJZnMySnM0cGM2VkdG?=
 =?utf-8?B?OHhPOG5SRCtxenZ0VldqRDRPK29FU1Vhb0VvS1RMdTc5czY2MFg1WjQ3bVJx?=
 =?utf-8?B?YVRPVXVONml3aWdZaDZWUzBnZldaVHNreTZUbXBwOEZucW42aFFQSHJTc0hF?=
 =?utf-8?B?dzlVRXBaWHozblBBWWtFWHphQTY2RXFHaFNoTkpWbXRUVlZGVDNLaHhIU0NS?=
 =?utf-8?B?Z2h3U1BXV2xabWdDUEpSZ0JKK3NQRnRUMWNEalNxVVJlTVBvRnpwc3lQWWsy?=
 =?utf-8?B?UnZDc1llT3U0aUJuK29lQS9ZcHpvM0VaeGNHV2l4d0Vtdm9NcHJUQWowZlFz?=
 =?utf-8?B?L05vczY0dmhjbk03NFo4TzRDSmNBeHJ2eGc3OVpMUkRuZjZzRVpEWklmWmZC?=
 =?utf-8?B?S0pZYUJaZUdjbG9lYTdleTlpc1IyS2ZzRWZKMHA3WjBueXFBYzNEM3BpcTRR?=
 =?utf-8?B?bFRiZzhzM3hrUmVlSDZuZkVNNDZyYVM5eE0wa25UZ0hOVWk4NTU3cy9yT0hL?=
 =?utf-8?B?WTRWeVJibHA3L3M5NVkraFdTOFZRUVRTZU43RkFyQzJWN0d3NWVmY2JIY3Bu?=
 =?utf-8?B?S2dkbGZWamd4ZzZQZUZtTiticHFhK3Jzd3BPakR3NENRUVVEZng4MENzMHhH?=
 =?utf-8?B?SCtSU0hVNnpxRGRHaTdEZGZiRWhHS1YzVG5kd3VESWZoTDRiNDNRdDdrMkRE?=
 =?utf-8?B?d0MyTmhsQXBHQ25IWExBSUw4bnBaMWJJU25zd2lNeDhwSVdUaXdkYU9EcmVy?=
 =?utf-8?B?N3lkWmdWZmNxY2R2ZWkvaWFmK0lKMGFrTXprdEduZGkwUmJrK2NzNjNVMDRZ?=
 =?utf-8?B?S21uMHRhUGNBODA1a2VXSms1WVVwK2N1WHpkRkg4Vk8vbDF0ME9ncGw3Rjdp?=
 =?utf-8?B?dkdZaFh6ZTZ3ZkNlYURkWTNEcTQrcW5Pcmc5ZWFBTXdrSGdEOUJlYnRjaXdI?=
 =?utf-8?B?MVBYYlpVVmY3c3lFQ2oyK0wrdEZNMTBMc1piNXdSTW4rOUJXTE40SjFjMW90?=
 =?utf-8?B?cWpuNUlvN0hTeFdiQWFhTUFDUkpIZVdCK21sYnlFcEFSWFJaSmxINGZVY3I0?=
 =?utf-8?B?QjFsQ3NwRlpPb3FYTnZoVmRrdmMzczQwRGh0SjZ5Q0NjVWpqYW0xWWNhdkp4?=
 =?utf-8?B?NFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F3D2DC30BAB62F41BF795949B9738724@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ID87PrNhqgtPrjwOh/+4ZOdDaCpU9GycEeZUUYKbW/MwUIiBL6sLW0Sn9d22cqA/qOcF25PFGX/0207S7+ixXZLFoqAhh3yvtP2D46LXRtQwOB5SrRIQf2hjJl8tpvMjEk34yXdb7AFK81y9kgRjtYniWf1QUVYeOKLrMhAPuJsCZLenVsosmSAJu75Ext9CQvzus+BH4om9+2+aU+uu2WyjEaiYSI1iSor/CAFRjSRBz4y5eNt+hBagx/GzQO5/KppvoZnN6i0vVomUKwghUnwOJzWzXXwKRiDbDLW8nPJkKa6XVWJQAnpi7g1CkJ8ezmrpR4Vh9e/gXkkpHtqBfhFRFHEkyZuzfnJ3MT2NWzAMty8SQdPX5r/MaE23AlYnc3dFQBlx9A+3xrUF1Ht9puZaTnHMg741oI+WPH54n9xS90XfWSf1u5l7Hr5u7VgGGns1ahK0ibl8GgP7FukOeMxAtPgchcrcatPhATyAJsczzI6eyegSGnAO+MADBy/i/HOesEafs0aZXrNOLrAGAMxufLvMfBEE6SBIqV1QPckIeU1qQgSCYoSVztbmipZkHOunrak618iUaNbfaVVG66FD4xXCpKHQguaxh2NUolUAD++UMNU998+cLcAgvhCM
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5442.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05ae9993-4b87-4a1d-b7c5-08dc1665b790
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2024 07:35:30.6406
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oOxDxuV+If1W4OfX3h5kcOQlqRe2l1NhiJd0r9D9rFLcLxDErFg29y94u2813wUH0L+kJINlsCR4pVwhOGcIrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10214

QWRyaWFuLA0KDQpPbiAxNi8wMS8yMDI0IDE1OjAxLCBBZHJpYW4gSHVudGVyIHdyb3RlOg0KPj4g
ZGlmZiAtLWdpdCBhL2FyY2gveDg2L2V2ZW50cy9jb3JlLmMgYi9hcmNoL3g4Ni9ldmVudHMvY29y
ZS5jDQo+PiBpbmRleCA0MGFkMTQyNWZmYTIuLjUyZTU3MDdiZTAzYiAxMDA2NDQNCj4+IC0tLSBh
L2FyY2gveDg2L2V2ZW50cy9jb3JlLmMNCj4+ICsrKyBiL2FyY2gveDg2L2V2ZW50cy9jb3JlLmMN
Cj4+IEBAIC0xODkyLDcgKzE4OTIsNyBAQCBzc2l6ZV90IGV2ZW50c19oeWJyaWRfc3lzZnNfc2hv
dyhzdHJ1Y3QgZGV2aWNlICpkZXYsDQo+PiAgIAkJaWYgKHg4Nl9wbXUuaHlicmlkX3BtdVtpXS5w
bXVfdHlwZSAmIHBtdS0+cG11X3R5cGUpIHsNCj4+ICAgCQkJbmV4dF9zdHIgPSBzdHJjaHIoc3Ry
LCAnOycpOw0KPj4gICAJCQlpZiAobmV4dF9zdHIpDQo+PiAtCQkJCXJldHVybiBzbnByaW50Zihw
YWdlLCBuZXh0X3N0ciAtIHN0ciArIDEsICIlcyIsIHN0cik7DQo+PiArCQkJCXJldHVybiBzeXNm
c19lbWl0KHBhZ2UsICIlcyIsIHN0cik7DQo+IFRoZSBpbnRlbnRpb24gc2VlbXMgdG8gYmUgdG8g
cHJpbnQgb25seSB1cCB0bywgYW5kIG5vdCBpbmNsdWRpbmcsIHRoZSBuZXh0ICc7JywNCj4gYnV0
IHN5c2ZzX2VtaXQoKSBpcyBub3QgZ29pbmcgdG8gZG8gdGhhdC4NCg0KSW5kZWVkLCBpdCBpbnRl
bmQgdG8gcHJpbnQgYSBzdWItc3RyaW5nIG9ubHksIHRoaXMgY29udmVyc2lvbiB3YXMgd3Jvbmcu
DQpMZXQncyBsZWF2ZSBpdCBhbG9uZQ0K

