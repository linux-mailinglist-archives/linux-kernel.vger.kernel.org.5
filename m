Return-Path: <linux-kernel+bounces-109660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 284D3881C28
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 06:41:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 967341F22174
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 05:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB123383A9;
	Thu, 21 Mar 2024 05:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="QQm8Brzb"
Received: from esa1.fujitsucc.c3s2.iphmx.com (esa1.fujitsucc.c3s2.iphmx.com [68.232.152.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD34C2E85C;
	Thu, 21 Mar 2024 05:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.152.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710999693; cv=fail; b=JL/2CV1svva9P4kio7zOLQyQfQyy0hDn4S1rE17ScH9y9xgv5MCRXvA0bX51VuHp73Q8czfIF/ObXicSSjWReZmF9WHHvm6uIskGounjAd1+vfsLCMFxRY65xjNbuBylh/07u7u6cnhiB7CwPIUO5IAY6soSG3hHx9+eodpuM64=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710999693; c=relaxed/simple;
	bh=3u1BfknM8Qvy6pashQI40WnONmgpvmbIj6nXhDWe87M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DwNQn074rJfQv7vVe62p9t9jf/92No+ffi7L8z5mkaeFTV/Ba2CjAieoIkwWcW5YOS9v4HWLTGzsYbUKtz7tzALlqCtECaiALVKxwbaGzFGhlM8GlsGSjX2TL97cggdxyg57pc7nM4V+b6UQ5r0sNsNfMDFCtnnlx4s9iTUJiI0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=QQm8Brzb; arc=fail smtp.client-ip=68.232.152.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1710999691; x=1742535691;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=3u1BfknM8Qvy6pashQI40WnONmgpvmbIj6nXhDWe87M=;
  b=QQm8BrzbV9Mo0PosNUhs5Hgy8cqnqI/UMc+2gN0BbVVytrgJUt04AxOg
   n678e+xwGWiwbKzeGazwlwCtsVPkdIaj38W8SwEDQ8P4O3KZWpGnCFRZb
   cxLW9UZ7dem3ICPK/b4D69DOE9K/9VVIvEgElGH93F81jtcp/pVYDYaYm
   cb3Ygv5sIMWZ2sNpWAUBV4Vd99MUpWNpg3oWQDznbbivH5s+6l7uWeU8F
   8cW/G85YVXLOe6of/FzIcKB257Os1X/FADCUecuk/W24nYKZ/eNcFkj9B
   u7HHdhvmBRE1qpC8iToMGn93BJR3Ej9lKrOA5GyIUaK7diV6+6dr2bGBP
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11019"; a="25657208"
X-IronPort-AV: E=Sophos;i="6.07,142,1708354800"; 
   d="scan'208";a="25657208"
Received: from mail-os0jpn01lp2105.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.105])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2024 14:40:16 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eILyumJyEE7gNtNrajK4sLmPhyj+vXKAu6WraEo/CV9vlQHjpI2gHhC677eJuc4MtYXmdKWvpcWdB0U5WWpZ1nj7lWt8VguvL6wJJEi3WpkSUVwrxQI7zpsYt2/em7IxwfiQFpGH0TSgoMgvA6gZBrmL++UgGI9fiNmmKDdfzH4Q8rUoCttfjfulVWzkR8v+mDkQkkB7ZzVTEahEvsMu8E2Kwvchu15whx4im9YXbmMqarPXnVv5hogR7UzOmed9ns1Xh2x9amxlP1vvGXkO9Us1murxmgcyIsU0RJ+XzpQjtWVefqZMph3bLJ3h1sd/yJiGDlPfS6xs299y7Sb2ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3u1BfknM8Qvy6pashQI40WnONmgpvmbIj6nXhDWe87M=;
 b=YzEAru/qVVdCKhHQCBgdllsun0KvHJ12iHxdUBbfvgkIpoThS3gB/8vKWV6n37PjU0qI8LnZmAlzwW/tldjebJa+1IC9Uodt9W0lYk/Qh41wrYcbihuQevrN7N7q9A56VY/TJXipFfz1d8GxtAkUn6FyBs1MoS5BAullIPUayvf1QQMHQav7vBpETdxy7jqPTI71G7n372JV20ix10JqiWW4P76fa+fz7ZzxVcFb2Oghvhf+IYmAGxxe4p4XZJUW6AHyJ+JBLPL4pVSWbKVABViQxXsd8DYwMdZ4a7xmWWbOY95uRlD5eIsJdzyBJqElU5sSgNkXUKcnioZSRMKWAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYAPR01MB5818.jpnprd01.prod.outlook.com
 (2603:1096:404:8059::10) by TYCPR01MB11884.jpnprd01.prod.outlook.com
 (2603:1096:400:3e2::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.30; Thu, 21 Mar
 2024 05:40:11 +0000
Received: from TYAPR01MB5818.jpnprd01.prod.outlook.com
 ([fe80::c52a:473a:a14f:7f0e]) by TYAPR01MB5818.jpnprd01.prod.outlook.com
 ([fe80::c52a:473a:a14f:7f0e%3]) with mapi id 15.20.7386.031; Thu, 21 Mar 2024
 05:40:11 +0000
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
Thread-Index: AQHab7EiTzrhxogi+kGW9pFQmlxZOrFBxRcA
Date: Thu, 21 Mar 2024 05:40:11 +0000
Message-ID: <92644ab5-6467-484c-b8f3-05cba2164cc1@fujitsu.com>
References: <20240306102846.1020868-1-lizhijian@fujitsu.com>
In-Reply-To: <20240306102846.1020868-1-lizhijian@fujitsu.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYAPR01MB5818:EE_|TYCPR01MB11884:EE_
x-ms-office365-filtering-correlation-id: c70b4881-1e25-4e42-5d3c-08dc49696064
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 oUhp1ONVdLFStqofaelNu/U/3tM1FimoWCw7x4mSnwtr9+Sj2lUiWS2tbMlCE/ase+tenJ8aLW0rwlpVFkIH6Yuhfw6FjNYhfe6KCYZx4/6y8oEPp9ZIERyiT4Y5/lzqKIt6Kk0Rz6BbXoU8c/7xt5PkfaAcxQYL9R6736Z+MRCJe+JV1TVnXR0RYKrv/knYIHgis+ghjC7Igy37JVsWBf0uJS1gOa7n+7h+DVV/3bie9XQ8xe27NoDDHdEXxNcRmvHou6afOPAYy7Id+k4hvMrtSEy0nzOoO/34ezHju9VJnM0Ygtn8aRViTRZaLrmAxRHUYm0WO/hPSR5KyGND/y8kw+nn9tV/dqMqkW+SFuCGhxLOFMK74eiHWu+bZOb92DWKDPt8PSoYRSwM7EZReAtfY2YmFJf7gxbUna6i/92wzceFkeRr9tHgXYnunhavY30XiFiFbkx6/tGFc52QgRBA8J+C3BvoSAKzA9SdCoeyatFCy1hMchLdqstxs2LGwkSJ/nLuo0SEfr46naZSYsH93kqc1kJKArH/LJZLhWY/UknFm7Rk5GPib+bUNhLxUdenRNgfWfNYp1xwkW8Dh+cvI4E0f9F2ayfT3Ok1PN218IPMlkkvPtFwkazjt7Ifao9EW/uCmRBLnfaqyek7mzJrGqGZLrt7bnFElzLRfAuT9TRIYu053DzsomX4NFQY
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB5818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(376005)(1580799018)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MnZyd200SkpuUUVhU0p5OGhJN3VOaFFhNTZOanVMNmdRam0zajlBdDFWeS9j?=
 =?utf-8?B?eTNjU3ROSnZlbDVaU3kzRnJtWWo2MjZocW94aUk2UkNyZkhkNkE5a1cwOHBY?=
 =?utf-8?B?dlhWL0tqcVEzaTJ4YUE4Q0hBVUdBN1BMQVBSLzkrSkp3Qi9ZNHNQR0ZlYS9x?=
 =?utf-8?B?aCt5ZW0vR29EYWdTaEc0N1hkVVRzTlpmVkMyVXJPVkVuSWlKb0tvNVRNa3Qz?=
 =?utf-8?B?UEpuMXFDVHhwd1AyK3lBWjhyUmpkdmFkSGVUa1IyWU11eXRLbWVuSXo2SmVI?=
 =?utf-8?B?VWRBbU9acmEybnA3amY4OXVacDFiYzhuQjVUMlIzbitVZ0wrd1gzUkFNWFhZ?=
 =?utf-8?B?U2RxRUEybmJqem93Y01mUGNGam9vRlBYUUhCZVZtNDN6NnNDSHY3RVZObFFN?=
 =?utf-8?B?eGRSbkw0enNRSmpoWFRkYTdKRFQ4ZTFta1U0MXlLUXdvNVpNQmFKWDZVQ3hz?=
 =?utf-8?B?ajh4ZWNBaHRGTlNKd241eUorV3Z0K0RJN0hYK01tajRaM0swSEdwcVlSRWN2?=
 =?utf-8?B?WE9CRXlreDMvZ3RRb3FLbHpnTjJYMjdPcDdvc1FGeUFpU2poWmc1NDVXN0Fo?=
 =?utf-8?B?NVJ4aVRQbVE5Q3RvcjNEYk1lQVVmR2VxWGJmclp3MVFab3htWWFjelRUWlpI?=
 =?utf-8?B?Rk5Id0R1Wi9GM1Q4VmYxYUJnQ1Y0Zis3YTNSM21RdkF6WFVOMjI4V2pwSGdD?=
 =?utf-8?B?NWc3TlRHZGttVXhLa0tuQjhzdTRPT3hzaTN3VS9OMHQ0NGFvd0IrKzR1V2c0?=
 =?utf-8?B?ZFpNVnY5UCtwcGtZSjFDMkpicHJXM0c4UTNpa3JraUh6alBGMDVEVDg5ajha?=
 =?utf-8?B?MzQ4M0s3QXZ0RTJtN1hLb01KMXRUSllQT0RGVUFmTWR1djAzVFVNRkNLSzVF?=
 =?utf-8?B?Sk5wOWM4VWVMZy9CSm1hVlF1OUZVOUtEWVpzQWxnSFdQdkRsTWxLYjhQZ3lF?=
 =?utf-8?B?NE0xTUg5Rnc3ZlB3R3czaS9ETGxqMG84Ny9KeVRaRnVWR25nK05lbWlrWXkz?=
 =?utf-8?B?Q1liMER0Tms2TGUvMDZDZjFFc1ArbWI2aENEdzVHYW1HNmtjdGNYUjIvUjJU?=
 =?utf-8?B?QnRvMHprWWVNZHNudUUvaVp0bzV0VzdSenQxUG5SbjA3TFA0OTBraFJaZzJI?=
 =?utf-8?B?ZG1IQzZaZFFrNWVGRi9CbkxaWUJkbENFUVlUVWZxdGxHOS80Rk1hRzBTUFNC?=
 =?utf-8?B?Q0xrWDlMMjVlRjRSaDdDY3V2Q2I1dnBIZ1l2WUxhdjVCejF3bis1QUk5S2ZM?=
 =?utf-8?B?NFlVaEMxeVlNK244cGZ5ZHhFdlBKMTBRYTA5TW5TS25JZjJiMmllSWNCV0Zq?=
 =?utf-8?B?N29rYVlIRzNHWVUzNUgxbzUxMVdLZHgxVHZaNXZ1cGRVakw0T0ZNc0dtQS9j?=
 =?utf-8?B?T0k2aFBsdXdrWmJhZEZCMzRuZ0ZEaFZYN001azhDRllRcUUxWmdLS0Z1ZmFu?=
 =?utf-8?B?OUlyZmxKUGtPcGkyK2lwVXhUeVhnaS9PV0FZRVZtRXc4M1FyWTJpYWxKU0kw?=
 =?utf-8?B?d1cyNFU5YlVSWmZXYklza25ESzFqcUVLMXhXQ1hweW1ETWhpTVJ6dEp5YnUw?=
 =?utf-8?B?V01oTklWVTB5dGx2ODFxOGdNUmZHeDBvd1Bxb1YzUGpwWSticStMQnN5QUh4?=
 =?utf-8?B?WFpla3Z4aEFId2lKV3JkVUFhMGVVSVBseW1hdVBmdHN6ejlRd3JmamhWMGZV?=
 =?utf-8?B?YjJnNlZxNk5ST1crS3BPYitvOUtibXZ5c0xIay9KTEtJcFk4cnBSN1Q0aDBl?=
 =?utf-8?B?Rm0za2gvT1ZGU2tiRDFlYTgrUE1IdDJ1RUkzejE3cHg1cU4rRTN6cDNyelpB?=
 =?utf-8?B?R2w3dmZUYkdWci9TckFkTTd0bW5ZaWYwb0ZBV1FRMUhkRFA3K2tkYW5sZHJD?=
 =?utf-8?B?YkF2RkhhNExXUFhOVnJqaWE1dFNIM3Z3d0FFNERsdTB0a3daNENHemxnQTVP?=
 =?utf-8?B?NzFQZEZCT1BzMXNJTzYzUjZqWEF2bUFyS1NOV21LOHhuMzRZam40U0ZQOHBi?=
 =?utf-8?B?dVk3WTh5RjNndk42aWJ5Y21lVSs2SWY3Q2krY3pDc0xNZkkxcFhvejhndFNZ?=
 =?utf-8?B?UEIyQzlaemp5UWhNakRqK2hwTXRYODJSUmZUNnlKOTBuVXhXbGU0TG82cFds?=
 =?utf-8?B?S1NZQ1lhUVNaR2xJR1pjSlB2OGdINk9lZUdpUExxbDkwdklnNERuT1ZXQnl5?=
 =?utf-8?B?aWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C567617B0B5BA44CA97072D5F77757F4@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Q/cLSRDjb4KXbr0OgQGFWhrBPswYlWpBPhqNdgLQrJUX8Q7m8mv/E15u6ly+5jxc3JZlkiStsYMKeLh3Zk7wpc2E3EZKlnd66g+drSu7WJVwnWY+vIndhj+spni3CaCrfWyduF2/1yHe7nvBtJbNZ8ls2CBsPPSax9Ex4FWb+YLEg0K5p16FYrKO5sh4EiTB7rKxx9bdC3NLoxf50DNJBm3NsBt1iAcU31fKQqp5GXk0dHUi70SYAw+RtiZzDExMD+o9ykneqnJzGPTV6zYRgwh8gJcJNvMhYCUXhAFnbi81CV0GVBDvoVzJn/BlWObzbso3NyiddFR7PSZ2ieLi39t4F303w5MLhfCzUHRXrrZU8bXBHonrE9GS/pNfu7/uppgwCGpcHOAGvG6tJLX+i1CNaMXveb95K4t5bT8JO3WfTGssm48eQ0RKSouAiwlZgE/a6C2Wrxrd12ZnUXILCfGU5yV2BBGbugfGzdc2+8aLGhVFOZsi6XrY3peWsy90l56UOlJYVt65HzUGoYq9VmhJ2OqZlhClas9WcMKPC/I0Qya5JmlCfL9acNcI1cJyprKnHv2L8g+tg34aBNMH2GwumTMl4xcnKa/KtAg6KgO+ICH18BfTszVAer1BxtsZ
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB5818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c70b4881-1e25-4e42-5d3c-08dc49696064
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2024 05:40:11.7097
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eHc6jU5EwIlK83gXXqVdzUcJa/Pvnr3ANDE36wyquCHcw12F/nBeFk/IOtfh599XqOE192bd0n0qSHB9KDa+KQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11884

cGluZw0KDQoNCkFueSBjb21tZW50IGlzIHdlbGNvbWUuDQoNCg0KT24gMDYvMDMvMjAyNCAxODoy
OCwgTGkgWmhpamlhbiB3cm90ZToNCj4gSGVsbG8gZm9sa3MsDQo+IA0KPiBDb21wYXJlZCB3aXRo
IHRoZSBWMlsxXSBJIHBvc3RlZCBhIGxvbmcgdGltZSBhZ28sIHRoaXMgdGltZSBpdCBpcyBhDQo+
IGNvbXBsZXRlbHkgbmV3IHByb3Bvc2FsIGRlc2lnbi4NCj4gDQo+ICMjIyBCYWNrZ3JvdW5kIGFu
ZCBtb3RpdmF0ZSBvdmVydmlldyAjIyMNCj4gLS0tDQo+IENyYXNoIGR1bXAgaXMgYW4gaW1wb3J0
YW50IGZlYXR1cmUgZm9yIHRyb3VibGVzaG9vdGluZyB0aGUga2VybmVsLiBJdCBpcyB0aGUNCj4g
ZmluYWwgd2F5IHRvIGNoYXNlIHdoYXQgaGFwcGVuZWQgYXQgdGhlIGtlcm5lbCBwYW5pYywgc2xv
d2Rvd24sIGFuZCBzbyBvbi4gSXQNCj4gaXMgb25lIG9mIHRoZSBtb3N0IGltcG9ydGFudCB0b29s
cyBmb3IgY3VzdG9tZXIgc3VwcG9ydC4NCj4gDQo+IEN1cnJlbnRseSwgdGhlcmUgYXJlIDIgc3lz
Y2FsbHMoa2V4ZWNfZmlsZV9sb2FkKDIpIGFuZCBrZXhlY19sb2FkKDIpKSB0bw0KPiBjb25maWd1
cmUgdGhlIGR1bXBhYmxlIHJlZ2lvbnMuIEdlbmVyYWxseSwgKEEpaW9tZW0gcmVzb3VyY2VzIHJl
Z2lzdGVyZWQgd2l0aA0KPiBmbGFncyAoSU9SRVNPVVJDRV9TWVNURU1fUkFNIHwgSU9SRVNPVUNF
X0JVU1kpIGZvciBrZXhlY19maWxlX2xvYWQoMikgb3INCj4gKEIpaW9tZW0gcmVzb3VyY2VzIHJl
Z2lzdGVyZWQgd2l0aCAiU3lzdGVtIFJBTSIgbmFtZSBwcmVmaXggZm9yIGtleGVjX2xvYWQoMikN
Cj4gYXJlIGR1bXBhYmxlLg0KPiANCj4gVGhlIHBtZW0gdXNlIGNhc2VzIGluY2x1ZGluZyBmc2Rh
eCBhbmQgZGV2ZGF4LCBjb3VsZCBtYXAgdGhlaXIgdm1lbW1hcCB0bw0KPiB0aGVpciBvd24gZGV2
aWNlcy4gSW4gdGhpcyBjYXNlLCB0aGVzZSBwYXJ0IG9mIHZtZW1tYXAgd2lsbCBub3QgYmUgZHVt
cGVkIHdoZW4NCj4gY3Jhc2ggaGFwcGVuZWQgc2luY2UgdGhlc2UgcmVnaW9ucyBhcmUgc2F0aXNm
aWVkIHdpdGggbmVpdGhlciB0aGUgYWJvdmUgKEEpDQo+IG5vciAoQikuDQo+IA0KPiBJbiBmc2Rh
eCwgdGhlIHZtZW1tYXAoc3RydWN0IHBhZ2UgYXJyYXkpIGJlY29tZXMgdmVyeSBpbXBvcnRhbnQs
IGl0IGlzIG9uZSBvZg0KPiB0aGUga2V5IGRhdGEgdG8gZmluZCBzdGF0dXMgb2YgcmV2ZXJzZSBt
YXAuIExhY2tpbmcgb2YgdGhlIGluZm9ybWF0aW9uIG1heQ0KPiBjYXVzZSBkaWZmaWN1bHR5IHRv
IGFuYWx5emUgdHJvdWJsZSBhcm91bmQgcG1lbSAoZXNwZWNpYWxseSBGaWxlc3lzdGVtLURBWCku
DQo+IFRoYXQgbWVhbnMgdHJvdWJsZXNob290ZXJzIGFyZSB1bmFibGUgdG8gY2hlY2sgbW9yZSBk
ZXRhaWxzIGFib3V0IHBtZW0gZnJvbQ0KPiB0aGUgZHVtcGZpbGUuDQo+IA0KPiAjIyMgUHJvcG9z
YWwgIyMjDQo+IC0tLQ0KPiBJbiB0aGlzIHByb3Bvc2FsLCByZWdpc3RlciB0aGUgZGV2aWNlIGJh
Y2tlZCB2bWVtbWFwIGFzIGEgc2VwYXJhdGUgcmVzb3VyY2UuDQo+IFRoaXMgcmVzb3VyY2UgaGFz
IGl0cyBvd24gbmV3IGZsYWcgYW5kIG5hbWUsIGFuZCB0aGVuIHRlYWNoZXMga2V4ZWNfZmlsZV9s
b2FkKDIpDQo+IGFuZCBrZXhlY19sb2FkKDIpIHRvIG1hcmsgaXQgYXMgZHVtcGFibGUuDQo+IA0K
PiBQcm9wb3NlZCBmbGFnOiBJT1JFU09VUkNFX0RFVklDRV9CQUNLRURfVk1FTU1BUA0KPiBQcm9w
b3NlZCBuYW1lOiAiRGV2aWNlIEJhY2tlZCBWbWVtbWFwIg0KPiANCj4gTk9URTogY3Jhc2gtdXRp
bHMgYWxzbyBuZWVkcyB0byBhZGFwdCB0byB0aGlzIG5ldyBuYW1lIGZvciBrZXhlY19sb2FkKCkN
Cj4gDQo+IFdpdGggY3VycmVudCBwcm9wb3NhbCwgdGhlIC9wcm9jL2lvbWVtIHNob3VsZCBzaG93
IGFzIGZvbGxvd2luZyBmb3IgZGV2aWNlDQo+IGJhY2tlZCB2bWVtbWFwDQo+ICMgY2F0IC9wcm9j
L2lvbWVtDQo+IC4uLg0KPiBmZmZjMDAwMC1mZmZmZmZmZiA6IFJlc2VydmVkDQo+IDEwMDAwMDAw
MC0xM2ZmZmZmZmYgOiBQZXJzaXN0ZW50IE1lbW9yeQ0KPiAgICAxMDAwMDAwMDAtMTBmZmZmZmZm
IDogbmFtZXNwYWNlMC4wDQo+ICAgICAgMTAwMDAwMDAwLTEwMDVmZmZmZiA6IERldmljZSBCYWNr
ZWQgVm1lbW1hcCAgIyBmc2RheA0KPiBhODAwMDAwMDAtYjdmZmZmZmZmIDogQ1hMIFdpbmRvdyAw
DQo+ICAgIGE4MDAwMDAwMC1hZmZmZmZmZmYgOiBQZXJzaXN0ZW50IE1lbW9yeQ0KPiAgICAgIGE4
MDAwMDAwMC1hZmZmZmZmZmYgOiByZWdpb24xDQo+ICAgICAgICBhODAwMDAwMDAtYTgxMWZmZmZm
IDogbmFtZXNwYWNlMS4wDQo+ICAgICAgICAgIGE4MDAwMDAwMC1hODExZmZmZmYgOiBEZXZpY2Ug
QmFja2VkIFZtZW1tYXAgIyBkZXZkYXgNCj4gICAgICAgIGE4MTIwMDAwMC1hYmZmZmZmZmYgOiBk
YXgxLjANCj4gYjgwMDAwMDAwLWM3ZmZmZmZmZiA6IENYTCBXaW5kb3cgMQ0KPiBjODAwMDAwMDAt
MTQ3ZmZmZmZmZiA6IFBDSSBCdXMgMDAwMDowMA0KPiAgICBjODAwMDAwMDAtYzgwMWZmZmZmIDog
UENJIEJ1cyAwMDAwOjAxDQo+IC4uLg0KPiANCj4gIyMjIEtkdW1wIHNlcnZpY2UgcmVsb2FkaW5n
ICMjIw0KPiAtLS0NCj4gT25jZSB0aGUga2R1bXAgc2VydmljZSBpcyBsb2FkZWQsIGlmIGNoYW5n
ZXMgdG8gQ1BVcyBvciBtZW1vcnkgb2NjdXIsDQo+IGVpdGhlciBieSBob3QgdW4vcGx1ZyBvciBv
ZmYvb25saW5pbmcsIHRoZSBjcmFzaCBlbGZjb3JlaGRyIHNob3VsZCBhbHNvDQo+IGJlIHVwZGF0
ZWQuIFRoZXJlIGFyZSAyIGFwcHJvYWNoZXMgdG8gbWFrZSB0aGUgcmVsb2FkaW5nIG1vcmUgZWZm
aWNpZW50Lg0KPiAxKSBVc2UgdWRldiBydWxlcyB0byB3YXRjaCBDUFUgYW5kIG1lbW9yeSBldmVu
dHMsIHRoZW4gcmVsb2FkIGtkdW1wDQo+IDIpIEVuYWJsZSBrZXJuZWwgY3Jhc2ggaG90cGx1ZyB0
byBhdXRvbWF0aWNhbGx5IHJlbG9hZCBlbGZjb3JlaGRyICg+PSA2LjUpDQo+IA0KPiBUaGlzIHJl
bG9hZGluZyBhbHNvIG5lZWRlZCB3aGVuIGRldmljZSBiYWNrZWQgdm1lbW1hcCBsYXlvdXRzIGNo
YW5nZSwgU2ltaWxhcg0KPiB0byB3aGF0IDEpIGRvZXMgbm93LCBvbmUgY291bGQgYWRkIHRoZSBm
b2xsb3dpbmcgYXMgdGhlIGZpcnN0IGxpbmVzIHRvIHRoZQ0KPiBSSEVMIHVkZXYgcnVsZSBmaWxl
IC91c3IvbGliL3VkZXYvcnVsZXMuZC85OC1rZXhlYy5ydWxlczoNCj4gDQo+ICMgbmFtZXNwYWNl
IHVwZGF0ZWQ6IHdhdGNoIGRheFguWShkZXZkYXgpIGFuZCBwZm5YLlkoZnNkYXgpIG9mIG5kDQo+
IFNVQlNZU1RFTT09Im5kIiwgS0VSTkVMPT0iW2RwXVthZl1beG5dWzAtOV0uKiIsIEFDVElPTj09
ImJpbmQiLCBHT1RPPSJrZHVtcF9yZWxvYWQiDQo+IFNVQlNZU1RFTT09Im5kIiwgS0VSTkVMPT0i
W2RwXVthZl1beG5dWzAtOV0uKiIsIEFDVElPTj09InVuYmluZCIsIEdPVE89ImtkdW1wX3JlbG9h
ZCINCj4gIyBkZXZkYXggPC0+IHN5c3RlbS1yYW0gdXBkYXRlZDogd2F0Y2ggZGF4WC5ZIG9mIGRh
eA0KPiBTVUJTWVNURU09PSJkYXgiLCBLRVJORUw9PSJkYXhbMC05XS4qIiwgQUNUSU9OPT0iYmlu
ZCIsIEdPVE89ImtkdW1wX3JlbG9hZCINCj4gU1VCU1lTVEVNPT0iZGF4IiwgS0VSTkVMPT0iZGF4
WzAtOV0uKiIsIEFDVElPTj09InVuYmluZCIsIEdPVE89ImtkdW1wX3JlbG9hZCINCj4gDQo+IFJl
Z2FyZGluZyAyKSwgbXkgaWRlYSBpcyB0aGF0IGl0IHdvdWxkIG5lZWQgdG8gY2FsbCB0aGUgbWVt
b3J5X25vdGlmeSgpIGluDQo+IGRldm1fbWVtcmVtYXBfcGFnZXNfcmVsZWFzZSgpIGFuZCBkZXZt
X21lbXJlbWFwX3BhZ2VzKCkgdG8gdHJpZ2dlciB0aGUgY3Jhc2gNCj4gaG90cGx1Zy4gVGhpcyBw
YXJ0IGlzIG5vdCB5ZXQgbWF0dXJlLCBidXQgaXQgZG9lcyBub3QgYWZmZWN0IHRoZSB3aG9sZSBm
ZWF0dXJlDQo+IGJlY2F1c2Ugd2UgY2FuIHN0aWxsIHVzZSBtZXRob2QgMSkgYWx0ZXJuYXRpdmVs
eS4NCj4gDQo+IFsxXSBodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sLzAyMDY2ZjBmLWRiYzAt
MDM4OC00MjMzLThlMjRiNmY4NDM1YkBmdWppdHN1LmNvbS9ULw0KPiAtLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiBjaGFuZ2VzIGZyb20gVjJbMV0NCj4gLSBu
ZXcgcHJvcG9zYWwgZGVzaWduDQo+IA0KPiBDQzogQWxpc29uIFNjaG9maWVsZCA8YWxpc29uLnNj
aG9maWVsZEBpbnRlbC5jb20+DQo+IENDOiBBbmRyZXcgTW9ydG9uIDxha3BtQGxpbnV4LWZvdW5k
YXRpb24ub3JnPg0KPiBDQzogQmFvcXVhbiBIZSA8YmhlQHJlZGhhdC5jb20+DQo+IENDOiBCb3Jp
c2xhdiBQZXRrb3YgPGJwQGFsaWVuOC5kZT4NCj4gQ0M6IERhbiBXaWxsaWFtcyA8ZGFuLmoud2ls
bGlhbXNAaW50ZWwuY29tPg0KPiBDQzogRGF2ZSBIYW5zZW4gPGRhdmUuaGFuc2VuQGxpbnV4Lmlu
dGVsLmNvbT4NCj4gQ0M6IERhdmUgSmlhbmcgPGRhdmUuamlhbmdAaW50ZWwuY29tPg0KPiBDQzog
R3JlZyBLcm9haC1IYXJ0bWFuIDxncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz4NCj4gQ0M6ICJI
LiBQZXRlciBBbnZpbiIgPGhwYUB6eXRvci5jb20+DQo+IENDOiBJbmdvIE1vbG5hciA8bWluZ29A
cmVkaGF0LmNvbT4NCj4gQ0M6IElyYSBXZWlueSA8aXJhLndlaW55QGludGVsLmNvbT4NCj4gQ0M6
IFRob21hcyBHbGVpeG5lciA8dGdseEBsaW51dHJvbml4LmRlPg0KPiBDQzogVmlzaGFsIFZlcm1h
IDx2aXNoYWwubC52ZXJtYUBpbnRlbC5jb20+DQo+IENDOiBsaW51eC1jeGxAdmdlci5rZXJuZWwu
b3JnDQo+IENDOiBsaW51eC1tbUBrdmFjay5vcmcNCj4gQ0M6IG52ZGltbUBsaXN0cy5saW51eC5k
ZXYNCj4gQ0M6IHg4NkBrZXJuZWwub3JnDQo+IA0KPiBMaSBaaGlqaWFuICg3KToNCj4gICAgbW06
IG1lbXJlbWFwOiByZWdpc3Rlci91bnJlZ2lzdGVyIGFsdG1hcCByZWdpb24gdG8gYSBzZXBhcmF0
ZSByZXNvdXJjZQ0KPiAgICBtbTogbWVtcmVtYXA6IGFkZCBwZ21hcF9wYXJlbnRfcmVzb3VyY2Uo
KSBoZWxwZXINCj4gICAgbnZkaW1tOiBwbWVtOiBhc3NpZ24gYSBwYXJlbnQgcmVzb3VyY2UgZm9y
IHZtZW1tYXAgcmVnaW9uIGZvciB0aGUNCj4gICAgICBmc2RheA0KPiAgICBkYXg6IHBtZW06IGFz
c2lnbiBhIHBhcmVudCByZXNvdXJjZSBmb3Igdm1lbW1hcCByZWdpb24gZm9yIHRoZSBkZXZkYXgN
Cj4gICAgcmVzb3VyY2U6IEludHJvZHVjZSB3YWxrIGRldmljZV9iYWNrZWRfdm1lbW1hcCByZXMo
KSBoZWxwZXINCj4gICAgeDg2L2NyYXNoOiBtYWtlIGRldmljZSBiYWNrZWQgdm1lbW1hcCBkdW1w
YWJsZSBmb3Iga2V4ZWNfZmlsZV9sb2FkDQo+ICAgIG52ZGltbTogc2V0IGZvcmNlX3Jhdz0xIGlu
IGtkdW1wIGtlcm5lbA0KPiANCj4gICBhcmNoL3g4Ni9rZXJuZWwvY3Jhc2guYyAgICAgICAgIHwg
IDUgKysrKysNCj4gICBkcml2ZXJzL2RheC9wbWVtLmMgICAgICAgICAgICAgIHwgIDggKysrKysr
LS0NCj4gICBkcml2ZXJzL252ZGltbS9uYW1lc3BhY2VfZGV2cy5jIHwgIDMgKysrDQo+ICAgZHJp
dmVycy9udmRpbW0vcG1lbS5jICAgICAgICAgICB8ICA5ICsrKysrKy0tLQ0KPiAgIGluY2x1ZGUv
bGludXgvaW9wb3J0LmggICAgICAgICAgfCAgNCArKysrDQo+ICAgaW5jbHVkZS9saW51eC9tZW1y
ZW1hcC5oICAgICAgICB8ICA0ICsrKysNCj4gICBrZXJuZWwvcmVzb3VyY2UuYyAgICAgICAgICAg
ICAgIHwgMTMgKysrKysrKysrKysrKw0KPiAgIG1tL21lbXJlbWFwLmMgICAgICAgICAgICAgICAg
ICAgfCAzMCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0NCj4gICA4IGZpbGVzIGNoYW5n
ZWQsIDcwIGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pDQo+IA==

