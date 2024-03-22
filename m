Return-Path: <linux-kernel+bounces-110896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B05F288655C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 04:17:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC5F61C2175B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 03:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06B334A3E;
	Fri, 22 Mar 2024 03:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="IIfYrY+K"
Received: from esa14.fujitsucc.c3s2.iphmx.com (esa14.fujitsucc.c3s2.iphmx.com [68.232.156.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80CAD4A07;
	Fri, 22 Mar 2024 03:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.156.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711077429; cv=fail; b=QbJJlcgMbp5mKvmxfpoYjlpq34JbbOzLbV0VfPBVklQ5VJ5Lnw6TyyJmgNa9OV0QKyvVJe6oATtIIgRrWQWm4IRGF0KRN5KPYzAp5e1nMbBPbl1Mtq9Br0Ni/AD5c2f5YoQ8FpI4yDeQHZAXLvuSz/WEmLAwndyj9a/vFdu1GLo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711077429; c=relaxed/simple;
	bh=iRibYhNjIZ4GD06/1qA4nkerG6PBRDPXebR7nLyK/kI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dnwEihI99LhSB8xZ7nNQZntJ0wezTtKAZcfrcHD5XVhKh8GlIqaf7o6x4dd8+xbbWT+IOFEX2eS0s/LzuG8IfMu/M3mFVJa6EM9jM6K5YKkU+B/pdbZR8X/8h9PfWEH/+vdFeQ7v+u7DgirbHs0d1pYtkgLxcZ5/vuno8+ALyXg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=IIfYrY+K; arc=fail smtp.client-ip=68.232.156.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1711077427; x=1742613427;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=iRibYhNjIZ4GD06/1qA4nkerG6PBRDPXebR7nLyK/kI=;
  b=IIfYrY+KOktsfOG5snjZDDOiXA/3PjUk8OAD2tdXSWir1dQ3EMkDCGlB
   l0fPelVuR2TZyBdYB139xbICxi0bvBie+pFn9Q78wrMmEpZ8xi4aDkb8b
   C3AKTZsWdP8utgsCzgpqvJRO7sPP75PmgG2f0UUAk9IZmm0SQalFDpuqR
   m3lZ61t/DddmwqTBsKc7shZg9DjgKZmiKvvdwQm2mzBHOQzUARH8i6WJa
   AF3M98Eiju03cf7zukPC5HYoz5Cu1VG7pzCJQ32lJTBdR4Yso/01fEpn0
   sa54GkgnK7kTtiDHQzOBK+HgrqO/EaKs+1DYnaDsz4HIwTjZE0svvTxXn
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11020"; a="114308758"
X-IronPort-AV: E=Sophos;i="6.07,144,1708354800"; 
   d="scan'208";a="114308758"
Received: from mail-tycjpn01lp2169.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.169])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2024 12:15:53 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EOhW+rulek68UXYya+xjSCD0qMXaYbM+H4MbODUPqXWE2b0u3t1HUABHOVjriizrghPwo9nswKc/x1jbaTcYbGZDzFET8WdiiGw3y9LXxdWiW+QUJUVcS3GH4wZLWRoWZePvBWKypymxpSfYmn6sCjuUgLoZdl1E/MS7S66LMakK1lk6O08REVjHmNQr6N1Qo9XEqQJ0WHa4cpQ6fYxN0aFvyo43AMWs/rsASKnWtIaCYSFp1ZcYjpRdX5MImgdx7MTLJdyl9bzyWZsnVsOgDE9pNQWTa5aIckn8JA1MULeFCA8bRPUxrnX9Gw3D68i8amubQC2QkcJU/MdSnYGs0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iRibYhNjIZ4GD06/1qA4nkerG6PBRDPXebR7nLyK/kI=;
 b=M4xBCzBOkcIDX6gpf/yBj4GJLYk8ejpAleqGZNYrKOOWMUpSHxM3BSPG1BFbC2+5xrrmJAeeHmFQMTvHLUbSAQPmWHWS8PLKIAf40/N5H+uWjKO5ZozEFWZFdSdMYcNI0lXn11/swzd4dJiZmiFYQCkrAnuBewqlZRgctGwAzEgZP0XucEYvdUly9LDNfVPVKhwfIU2K1V4YVuKgvvf/vwgiknhdkUuvpK52hszMWVOWKGyK/2wFOWqFHDDzKpzk6IblknFjfKUHdZJ0DVfiLTr/ajwM7xn0SWT0iaV0zROllZFxfhaKlZE6MA4VoXg4HZijGH5YjRG62ok8Ru+rmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYAPR01MB5818.jpnprd01.prod.outlook.com
 (2603:1096:404:8059::10) by TYCPR01MB9990.jpnprd01.prod.outlook.com
 (2603:1096:400:1ea::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.34; Fri, 22 Mar
 2024 03:15:46 +0000
Received: from TYAPR01MB5818.jpnprd01.prod.outlook.com
 ([fe80::c52a:473a:a14f:7f0e]) by TYAPR01MB5818.jpnprd01.prod.outlook.com
 ([fe80::c52a:473a:a14f:7f0e%3]) with mapi id 15.20.7409.023; Fri, 22 Mar 2024
 03:15:46 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Robert Richter <rrichter@amd.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>, Vishal
 Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan
 Williams <dan.j.williams@intel.com>
CC: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Xingtao Yao
 (Fujitsu)" <yaoxt.fnst@fujitsu.com>
Subject: [Problem ?] cxl list show nothing after reboot Re: [PATCH v2]
 cxl/pci: Fix disabling memory if DVSEC CXL Range does not match a CFMWS
 window
Thread-Topic: [Problem ?] cxl list show nothing after reboot Re: [PATCH v2]
 cxl/pci: Fix disabling memory if DVSEC CXL Range does not match a CFMWS
 window
Thread-Index: AQHaYPF+guY7ES5MRk+p0kfVt2bmsbFDTJAA
Date: Fri, 22 Mar 2024 03:15:46 +0000
Message-ID: <b0f5e2ce-d39e-4a8e-8f2f-ffa67b604e02@fujitsu.com>
References: <20240216160113.407141-1-rrichter@amd.com>
In-Reply-To: <20240216160113.407141-1-rrichter@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYAPR01MB5818:EE_|TYCPR01MB9990:EE_
x-ms-office365-filtering-correlation-id: c2bc6eff-c1a1-4914-9a64-08dc4a1e5ddb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 LpW8W79waoFlxn7Re4W9VZLpmxHwgCy0VwODX+iABMvkWnd3xeeOEjNMdBXmxd+/uXSNuoWJM5fdTKizWctY1I1qafTD8CpJgYdut6WBhjmy+6m655hWGiDPDiyaNd5ah0wlfFwWG9gLoeYzdqGddU6PsnE04dgHJ6XNU3jfG2AD6HRJLQ3Dx3Dwxjs/2B2ZGuGCpaCi9w0sXLZiJhbCgIbnLCpjEVHxrg4u8UMbD/Cq/4Indn7tBkVMDCOI5r0CTaXBw0bsBRHNbaueoUDnN/NlA4z9wmY7GH0vp/09HBdNtdQaJAv3E2E+2wEWwI6HGZxYwhy0yIU8SAexbLwbf3FjEpHT4fGW/HFqY9MivbSiz/EoAMs3zHhIFRnAGSjwnP5zGIh7AMJY7cwm0jx5PXQJohI9y4viSST4H6skeO5kby2mAJDX+sxJ05bdj+Hn2oh/z/8GmWtve4e7OQun/M4MGtXql4nTCZvlAS4m0oaMqkveyIGm/e94im3oyKgQ7oshx0tIFNupL9SixJQmLFE2xlzfcU108ZbqzxGjnej7iJAvt+4gI1JxxUppG5ZQ/yOUcQZxfK5HY2eonn76QuWy0Dv37i+8V2ZxYhLVMp6ffZUdqoF/86sELH9NCi4NVCjhKUtLf8PTy0pzEE0d19lJ6var7g0Cf8okxKo9+7ZCOKprMSnVoo7ivmI4FXO79Ez3acdjxnWbw8ZV5GvXAFm9j4R73tUBarQfxoot40pokqlE2CeJqG7ubKxknhv8
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB5818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(366007)(376005)(1580799018)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eWpyU296OURpbk5adzBKQmxLeDVkWTFFdVZGUk4wZFBBQWlpbUJxUFdNMkxp?=
 =?utf-8?B?aXh6cjZMMnFteEFwRkhLR3hVMi8zTTdDYWRhVVl4Tjd4Vkt5UDQ4TzA1bFlF?=
 =?utf-8?B?dW5nakQ5MllhMGoyZllvdURKZWZzMkxKUERJWDlzMm5sUS9ERnY3UXNmNjZy?=
 =?utf-8?B?RU9KYWtoKy9tQjF6SDd2SUxwM2tWaGppNStEQlhnRjFUWGJoRng0MnVkYW9u?=
 =?utf-8?B?RHowMENMS2w0SEZlNEJWdUNKL2tSSFRyQ1VyZzFBUGs3bGYrUzNoSGtNUzll?=
 =?utf-8?B?VFR4bVJqUHNzK25xNzVtN1RnaU55OSs5VUxrZEgySzdvS3FEbTlUR2ROVkNi?=
 =?utf-8?B?Y212MjkzSWkwSFJqTmNwZHV1Znd5Y1dJYno4TFgxSXpxbVFjMFd6cXJqNENO?=
 =?utf-8?B?aGdrTkFURGcrMk14dGlvZ2dqMWRVRmc4bDhJdWQ2QXhKTm85UDI5RVVScFFX?=
 =?utf-8?B?VDlyZjFVTUcvdk0wd1BmanNBbnZvMnFzekVaSWIyejhrSG53cTFxQllCdVRM?=
 =?utf-8?B?d05IOVJnRFRQRlh6U3lncEtUV3oyUFgzUGRqb3k3cmVyMWtLSHpaMjlrUGl1?=
 =?utf-8?B?MmZ5aktwYzM0T2RCMTRqZ2czY2hwc0ZTeXQ5Mk4vQ1BRclVMK0dxclc3MjBp?=
 =?utf-8?B?UHpJM2hWSXVKN0pHdWdoZUIzd2x5VlVFRXZOKy9uUXB4Z1FTOUhTZlFmU21z?=
 =?utf-8?B?aXBkZFI2TW9UWWJoOWFxMTk5Vi92SmR5VjFHcVUwTW9FOXRVN3hybzNOSG44?=
 =?utf-8?B?TXlmd1lpbG42SG5ZUU13ZS9Ma1l2bjdJUXJXN2psVGVQREl5Rm9FQUJlMVhU?=
 =?utf-8?B?U0F4QlJuU1ZBaFdUdDBtY2d5bWdFakJQMlorWnJmRnRPZU5jYW56SVU2MUF0?=
 =?utf-8?B?T2ZxN1RZdFVtU2poM1RJMU9jY2dGSloyZjI4b0FEZmxiWFY5S2xiSVZyMFNL?=
 =?utf-8?B?SG4xS0xFbHpVeHhMUFNmQWd2ZlpKRDhNZGhQTEV4WU9LdFgzcHFoZ1ZhOHB0?=
 =?utf-8?B?UnRRcVlxcTJOalhGd3hWZmRiVVpSbTNTd3BLNFVSL0QrSFFwckNPOThtMlpD?=
 =?utf-8?B?d216N2JuVjNadEtIbkViZmIrNkYzSWFob1ZHTjFGTkdrMDFLa0JhbVpIYlVV?=
 =?utf-8?B?SHNGVlNrZjRZNnZMTEh4TnQrWmxpZ2NEcXNFaFF0UHdoTjBhcS9xUFYxSmdR?=
 =?utf-8?B?bXRaSHh4QVJaNG5admRoNkxjcmYwNWRIZEMwL2svWlBxcXhyakZUZmFkazdX?=
 =?utf-8?B?bnNQR2l6UXVlRUdTZjJ5VHFHMDd0YUl1QkVQOEgxUWczbk9mZWxOVkN4NEZs?=
 =?utf-8?B?RlE0UjlCN1FWTU5RcHdsa2pFSEJVUnBKZnJkeU1lZFZ6L3M3Nm9CUUxyNkMw?=
 =?utf-8?B?ODVaM2w1RmFSN2RmZnh6QTZ6MXdVa1FPN0dPOCt1WjJTcDBoaThhUEFsUW5L?=
 =?utf-8?B?OXRtQkw1RCtWUTAvaHpxMmtZZTIxb3JScUszdlFJZDVJY2lQUk05S0U1YlZt?=
 =?utf-8?B?Nm1TQllPSlQ3K25Sa2VJaldlRGFlSE15bW5SNzUySEE5VmFncnJqaHg5Wlor?=
 =?utf-8?B?NWxWejdkcWE3akJkWk83NGd5aFBZbCtGQ1ZCQ09UY0oxcnN3TGVBN0tpOEJj?=
 =?utf-8?B?RWl3QmhJMEFpNmpyVEtNQjlnVURXQnVvODEvbUZWM0hHYkptM1pIbHlpakgz?=
 =?utf-8?B?ZzllUnZVS2tJSkQzaVMvZnRXM3VSdmo5QWE0aHMrNW05d3BVMFp1dm1QU1VQ?=
 =?utf-8?B?MkgzSTZOZ3BvZzhhK1EwYTVXeEpWL1YzVVJzaXFWM1FOOTM2bzRSU09mMWlU?=
 =?utf-8?B?THFteTdQMCtxUTRkNWo3RUVzMStoOWV5Ly96M2Q0V0FrbkJadkluclhpQ2VQ?=
 =?utf-8?B?eEhmVDlHa3lUMm4vME1lODhYQXBsSFM0L0c3K21pUXE0U25vdjVhMlpWQmQ1?=
 =?utf-8?B?Q3BaSWE2eWtId3JDczJTOFY0NG5oNUVTTWRDZ1ZGM0xQOGhwUGI4b2E2dUxX?=
 =?utf-8?B?dkF4WUpaZSszVGdPUTcvaTR5ZTREczBGTGZtanlpcmJjRXhMZkIrbDNvTGR4?=
 =?utf-8?B?NGRGcXRzMzJQVmhlMkRoT0ZLQk05OHY2dmlQaEdMelRySkc5Yk8vMkVFcGsr?=
 =?utf-8?B?aUlzNi9tcWRiTlRGWVJrcHFaaWtMcG1ldjdzeVFFTElpdXV5UnNRUkxia2NR?=
 =?utf-8?B?alE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <47EDD7977FDA774C85D638692A32C012@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7sLgYbA7VaKVCLFedZBTQgCGllDit3huk8nwFXgf1ugJ2YlCfRIeBjxXvKc4uTtoKNi1ZPbaYgEse4RM2NFFHt5NGoTS0ckQ3WnX0pnzLXiwKIBO2WqO78kIVc9/HEr4Oo7YK4p9WITaZHnH8On6+dPsQP+PAwkBCWbXs6dJ6qWxse8KK4NAAU+BuhZZYG7nl7ZtC4mkHD1uBIfeO/AzQ2iDf8lsLRhs/4mAH69SHfEFOPpgb3WnDtufwPGSOtcG7psPSmTMBxFbSg+X6cL1Av7I/oVeRrUeKg5+PcnJNNASVUuArFdA5vjIiGTrFjC8IzJZY+f2rUiNX9NjaT9K4WxbSHad+n6zWuBxgBOfr5b/xMnhlF6Us4BnjUPusok4jm1HsUTBHaLm/QzYjB1t5JNzYmTcMVS1Om8nAD/ZEIkOM1fp2sAJbmlWiQgQSjJlaGIb7PpZQ5eJGNbjnt46PgGX6MUimLivL39twfgX/hrBJzUe/ql30+pxRyTSUcE4bqit0YbOnJXJxMvvVaDC8NrHpW+xAdd/HT3nAMBHjod2r8T7nZfZPErjgkRfX2kBQ8ftnQICBgqCvXWMAm3BYYU4QLkBCjR78l+nMWpZOoPUFC5PCoOfEo1ydElhWyaA
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB5818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2bc6eff-c1a1-4914-9a64-08dc4a1e5ddb
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2024 03:15:46.3466
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sCLdYqIISjoKHhz5h8Vvx0Bt4p0av0j+7kSvR+PkU2dMpztrI3rcEynKrByDlU6vuKDvJh0a0sgzKHhDjzPl/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9990

Um9iZXJ0LCBEYW4NCg0KSXQncyBub3RpY2VkIHRoYXQgJ2N4bCBsaXN0JyBzaG93IG5vdGhpbmcg
YWZ0ZXIgYSByZWJvb3QgaW4gdjYuOC4oQSBmcmVzaCBib290IHdvcmtzKQ0KVGhlIGdpdCBiaXNl
Y3Rpb24gcG9pbnRlZCB0byB0aGlzIGNvbW1pdC4NCg0KSGF2ZW4ndCBpbnZlc3RpZ2F0ZWQgaXQg
ZGVlcGx5LCBJJ20gd29uZGVyaW5nIGlmIGl0J3MgYSBRRU1VIHByb2JsZW0gb3INCnNvbWV0aGlu
ZyB3cm9uZyB3aXRoIHRoaXMgcGF0Y2guDQoNCg0KUmVwcm9kdWNlIHN0ZXA6DQoNCjEuIFN0YXJ0
IGEgY3hsIFFFTVUgVk0NCjIuIGN4bCBsaXN0IHdvcmtzDQpjeGwgbGlzdA0KWw0KICAgew0KICAg
ICAibWVtZGV2IjoibWVtMCIsDQogICAgICJyYW1fc2l6ZSI6MjE0NzQ4MzY0OCwNCiAgICAgInNl
cmlhbCI6MCwNCiAgICAgImhvc3QiOiIwMDAwOjU0OjAwLjAiDQogICB9LA0KICAgew0KICAgICAi
bWVtZGV2IjoibWVtMSIsDQogICAgICJwbWVtX3NpemUiOjIxNDc0ODM2NDgsDQogICAgICJzZXJp
YWwiOjAsDQogICAgICJob3N0IjoiMDAwMDozNjowMC4wIg0KICAgfQ0KXQ0KDQozLiByZWJvb3Qg
Vk0NCjQuIGN4bCBsaXN0IHNob3cgbm90aGluZyBhbmQgaGFzIGZvbGxvd2luZyBkbWVzZw0KDQpj
eGwgbGlzdA0KWw0KXQ0KICAgV2FybmluZzogbm8gbWF0Y2hpbmcgZGV2aWNlcyBmb3VuZA0KDQou
Li4NCg0KWyAgICA2LjI0OTE4OF0gIHBjaTAwMDA6NTM6IGhvc3Qgc3VwcG9ydHMgQ1hMDQpbICAg
IDYuMjU4MTY4XSAgcGNpMDAwMDozNTogaG9zdCBzdXBwb3J0cyBDWEwNClsgICAgNi40OTA1Njhd
IGN4bF9wY2kgMDAwMDo1NDowMC4wOiBSYW5nZSByZWdpc3RlciBkZWNvZGVzIG91dHNpZGUgcGxh
dGZvcm0gZGVmaW5lZCBDWEwgcmFuZ2VzLg0KWyAgICA2LjQ5NDI5OF0gY3hsX21lbSBtZW0wOiBl
bmRwb2ludDMgZmFpbGVkIHByb2JlDQpbICAgIDYuNTA2MDcyXSBjeGxfcGNpIDAwMDA6MzY6MDAu
MDogUmFuZ2UgcmVnaXN0ZXIgZGVjb2RlcyBvdXRzaWRlIHBsYXRmb3JtIGRlZmluZWQgQ1hMIHJh
bmdlcy4NClsgICAgNi41MTUwOTJdIGN4bF9tZW0gbWVtMTogZW5kcG9pbnQzIGZhaWxlZCBwcm9i
ZQ0KWyAgIDEyLjE4MTE4OF0ga2F1ZGl0ZF9wcmludGtfc2tiOiAxOCBjYWxsYmFja3Mgc3VwcHJl
c3NlZA0KDQoNClRoYW5rcw0KWmhpamlhbg0KDQoNCk9uIDE3LzAyLzIwMjQgMDA6MDEsIFJvYmVy
dCBSaWNodGVyIHdyb3RlOg0KPiBUaGUgTGludXggQ1hMIHN1YnN5c3RlbSBpcyBidWlsdCBvbiB0
aGUgYXNzdW1wdGlvbiB0aGF0IEhQQSA9PSBTUEEuDQo+IFRoYXQgaXMsIHRoZSBob3N0IHBoeXNp
Y2FsIGFkZHJlc3MgKEhQQSkgdGhlIEhETSBkZWNvZGVyIHJlZ2lzdGVycyBhcmUNCj4gcHJvZ3Jh
bW1lZCB3aXRoIGFyZSBzeXN0ZW0gcGh5c2ljYWwgYWRkcmVzc2VzIChTUEEpLg0KPiANCj4gRHVy
aW5nIEhETSBkZWNvZGVyIHNldHVwLCB0aGUgRFZTRUMgQ1hMIHJhbmdlIHJlZ2lzdGVycyAoY3hs
LTMuMSwNCj4gOC4xLjMuOCkgYXJlIGNoZWNrZWQgaWYgdGhlIG1lbW9yeSBpcyBlbmFibGVkIGFu
ZCB0aGUgQ1hMIHJhbmdlIGlzIGluDQo+IGEgSFBBIHdpbmRvdyB0aGF0IGlzIGRlc2NyaWJlZCBp
biBhIENGTVdTIHN0cnVjdHVyZSBvZiB0aGUgQ1hMIGhvc3QNCj4gYnJpZGdlIChjeGwtMy4xLCA5
LjE4LjEuMykuDQo+IA0KPiBOb3csIGlmIHRoZSBIUEEgaXMgbm90IGFuIFNQQSwgdGhlIENYTCBy
YW5nZSBkb2VzIG5vdCBtYXRjaCBhIENGTVdTDQo+IHdpbmRvdyBhbmQgdGhlIENYTCBtZW1vcnkg
cmFuZ2Ugd2lsbCBiZSBkaXNhYmxlZCB0aGVuLiBUaGUgSERNIGRlY29kZXINCj4gc3RvcHMgd29y
a2luZyB3aGljaCBjYXVzZXMgc3lzdGVtIG1lbW9yeSBiZWluZyBkaXNhYmxlZCBhbmQgZnVydGhl
ciBhDQo+IHN5c3RlbSBoYW5nIGR1cmluZyBIRE0gZGVjb2RlciBpbml0aWFsaXphdGlvbiwgdHlw
aWNhbGx5IHdoZW4gYSBDWEwNCj4gZW5hYmxlZCBrZXJuZWwgYm9vdHMuDQo+IA0KPiBQcmV2ZW50
IGEgc3lzdGVtIGhhbmcgYW5kIGRvIG5vdCBkaXNhYmxlIHRoZSBIRE0gZGVjb2RlciBpZiB0aGUN
Cj4gZGVjb2RlcidzIENYTCByYW5nZSBpcyBub3QgZm91bmQgaW4gYSBDRk1XUyB3aW5kb3cuDQo+
IA0KPiBOb3RlIHRoZSBjaGFuZ2Ugb25seSBmaXhlcyBhIGhhcmR3YXJlIGhhbmcsIGJ1dCBkb2Vz
IG5vdCBpbXBsZW1lbnQNCj4gSFBBL1NQQSB0cmFuc2xhdGlvbi4gU3VwcG9ydCBmb3IgdGhpcyBj
YW4gYmUgYWRkZWQgaW4gYSBmb2xsb3cgb24NCj4gcGF0Y2ggc2VyaWVzLg0KPiANCj4gU2lnbmVk
LW9mZi1ieTogUm9iZXJ0IFJpY2h0ZXIgPHJyaWNodGVyQGFtZC5jb20+DQo+IC0tLQ0KPiAgIGRy
aXZlcnMvY3hsL2NvcmUvcGNpLmMgfCA0ICsrLS0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNl
cnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY3hs
L2NvcmUvcGNpLmMgYi9kcml2ZXJzL2N4bC9jb3JlL3BjaS5jDQo+IGluZGV4IGEwZTdlZDVhZTI1
Zi4uMTg2MTZjYTg3M2U1IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2N4bC9jb3JlL3BjaS5jDQo+
ICsrKyBiL2RyaXZlcnMvY3hsL2NvcmUvcGNpLmMNCj4gQEAgLTQ3OCw4ICs0NzgsOCBAQCBpbnQg
Y3hsX2hkbV9kZWNvZGVfaW5pdChzdHJ1Y3QgY3hsX2Rldl9zdGF0ZSAqY3hsZHMsIHN0cnVjdCBj
eGxfaGRtICpjeGxoZG0sDQo+ICAgCX0NCj4gICANCj4gICAJaWYgKCFhbGxvd2VkKSB7DQo+IC0J
CWN4bF9zZXRfbWVtX2VuYWJsZShjeGxkcywgMCk7DQo+IC0JCWluZm8tPm1lbV9lbmFibGVkID0g
MDsNCj4gKwkJZGV2X2VycihkZXYsICJSYW5nZSByZWdpc3RlciBkZWNvZGVzIG91dHNpZGUgcGxh
dGZvcm0gZGVmaW5lZCBDWEwgcmFuZ2VzLlxuIik7DQo+ICsJCXJldHVybiAtRU5YSU87DQo+ICAg
CX0NCj4gICANCj4gICAJLyo=

