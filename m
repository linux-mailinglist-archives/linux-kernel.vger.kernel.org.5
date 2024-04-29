Return-Path: <linux-kernel+bounces-162021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 14ABA8B54C7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 12:12:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06A87B21F32
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 10:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9340F2E41C;
	Mon, 29 Apr 2024 10:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="E14O4tVV"
Received: from esa4.fujitsucc.c3s2.iphmx.com (esa4.fujitsucc.c3s2.iphmx.com [68.232.151.214])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA1B2C19D;
	Mon, 29 Apr 2024 10:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.151.214
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714385519; cv=fail; b=RmeXdFCiokJJSEfVNXZiC9MGbm0wvMEukAec9FpBorZFPkK60bkJDm1PBkfq1+q1NzrXCc1+PGCyji7eMmdm/t7EqKhn5IVT5mQSGRzcZ3xjSmIu1R4CDyCQKlbnfoUBsYCKcdwt1/EUZ8TuXirYOaPvaGRmRb1fxP4XUL6H+3Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714385519; c=relaxed/simple;
	bh=D35S8ewEITa2F1VSg9uvnbKVp70bbfGE3FFMGzM/yos=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=isfTzpIfCf3cHXtUEHKWCx3VbLvuxoEITRNytnQszuS12+xv0/IIX+7OIU2JqB0zGGxDGKn98N6B1oTA55GHgyBtNQjPRjOrnZhu3cF0oVCec4utugbHKljaUunb1kRtbk01JcriLzM5g9rQU7BFu/VJgjbN5zSnvbpzubjBh1s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=E14O4tVV; arc=fail smtp.client-ip=68.232.151.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1714385516; x=1745921516;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=D35S8ewEITa2F1VSg9uvnbKVp70bbfGE3FFMGzM/yos=;
  b=E14O4tVVF4FhDL+kjANFVuBcFFj/yC+mCgW75xijQCTYrUB19ruQXHZx
   xV5P+TwAKKoCTi6JhEnH9Xv5Ekf6wJ9R04MycfY3M2mqnFVt7Xlan4r9D
   uIM7mNB714GEWoYsChK0uKQlpq8g8+MqdrdP/cqjoeXpJoI721scuHrTQ
   lj48UebLDPIMNEl2e0/SdNO29WLTXotqFtjOEHH7BegPuP7Lkpcrj8YJp
   h05mcGqC07qa8WsGV7VB+tENxt9NeeNzK4E341QSlaeaHE5g3EOAghC/k
   lWUd4vc2sgHkEpcBcA2TIVQk4woQtWu2TbFSR9sacmqR/uU2QxAwGgbj8
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11057"; a="31141850"
X-IronPort-AV: E=Sophos;i="6.07,239,1708354800"; 
   d="scan'208";a="31141850"
Received: from mail-os0jpn01lp2105.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.105])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 19:11:49 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nPrtUgJ6sMYqIB98GnoUL6+sVKF2ATcjbMyiSAiHCOzH7pC/Cwa16ABQd3ft+8zV1LlWpaGf3El/iI8plAOUmTkS0cMmI3CvXiSNeRfgq2efhPZnCEIJklgR6leo2t9eBZ7nqDXLrbDjdgY1xzTcfsa5JxVRCdXXv8ed5nDXn8ulxXMK3LPL32UK+NBDNpEdsEidjXNWens1ER+rlzSUIrpVMtM5ujXGtVhdoVjf5hZJrDlQ4oXDeDzHlZqCZx1Gbn+LpP8iJOVJHUSuteT1Z9PfZgNjUuMttM7AfGDdIfD5m4Xs8oSw5N/wvdv7lpwqkATV92k1on7BSyeu1wW44g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D35S8ewEITa2F1VSg9uvnbKVp70bbfGE3FFMGzM/yos=;
 b=R4i11Z0mG8V/cgCj9W9vlCumQVizW/z+DHmGJWAwS7EouFwH/wge838fWCtpGtPOOl1VRljoxP+yvgLAIwrLeJyXUhj62Lx4yHbNTKwabXy2qZMzniG3lXbRpnmNYY2wnnue4DX/IUVJFbySgcho1DSmmvsLsXZpCpaugZIuJfbBOLDQQ9DTfCA6XTjcfVEm7/EmeNJjgfpO/aHCtC35igXwpIow798HqmaZExStkYAKa/SkA8RBEHgXgLwIscjYkSSL7c1hLxh+Bufc3FlJB7mfJueCa1aRiXZ6kG3gKszA/S7d8pbYprrvG2Zr8dSzCrxHx5QuZThYioxTqR43iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (2603:1096:403:6::12)
 by TYWPR01MB9938.jpnprd01.prod.outlook.com (2603:1096:400:232::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 10:11:46 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377%5]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 10:11:45 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
CC: Markus Elfring <Markus.Elfring@web.de>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "kernel-janitors@vger.kernel.org"
	<kernel-janitors@vger.kernel.org>, Alison Schofield
	<alison.schofield@intel.com>, Dan Williams <dan.j.williams@intel.com>, Dave
 Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>, Ira Weiny
	<ira.weiny@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Vishal
 Verma <vishal.l.verma@intel.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] cxl/region: Fix missing put_device(region_dev)
Thread-Topic: [PATCH 2/2] cxl/region: Fix missing put_device(region_dev)
Thread-Index: AQHamdUJ/baSUL4fTUadXbdXZxcbY7F+4uMAgAAHQoCAABo8gIAAAzoA
Date: Mon, 29 Apr 2024 10:11:45 +0000
Message-ID: <6e83f757-1555-4604-986a-625ac8cf67bd@fujitsu.com>
References: <20240429013154.368118-2-lizhijian@fujitsu.com>
 <bdfa663d-9a00-484c-80f7-75d7fa130cd3@web.de>
 <2ea9506e-4be7-48a2-bcc8-4ae543a7f1b5@fujitsu.com>
 <9254b051-3221-4877-b6ce-68bc2bb9f217@moroto.mountain>
In-Reply-To: <9254b051-3221-4877-b6ce-68bc2bb9f217@moroto.mountain>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB1562:EE_|TYWPR01MB9938:EE_
x-ms-office365-filtering-correlation-id: ab121cb0-114e-4c16-63b3-08dc6834c686
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|7416005|376005|366007|1800799015|1580799018|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?Tkt6ZHJ2R21wYjFUaUlmSGxaU0tkdXJ1Q3dtejdWWSsvWlVCTGFsWFJ2WkNq?=
 =?utf-8?B?OWJ5NXI4a2pWNzc0VkNhZjIvSit3anNCMklQSVp4dy9OVFFXV2dGZVJhR2lH?=
 =?utf-8?B?SE1SYWdhU2hrUUI0UHpPa0tXdlNjUCsxSzZ0ay82S2FpRkdnSllFdGpmWWwr?=
 =?utf-8?B?U1Nwc2pQYVdjNGI2OW5xR1RIN0NDbWpDMzdDY3BCMUlPaEpZQ2JrZ3lMRExJ?=
 =?utf-8?B?WERQd25uOTh5RkhJUGdaWlEwS3l4QW5yL3kwSTRMNGZUSC9ZdzdkRE5WSGhh?=
 =?utf-8?B?VmlSSmhEZFMwM3pwTGNCZUpHZFM4NjQyR2R1bU5VRS82b3JyUzZsWlJTb09D?=
 =?utf-8?B?K2NkWjk1SWFKWE9ERG5VaHRiK2x6OGorTG1seUUwTjlReXcxbklBNytFSVBD?=
 =?utf-8?B?Sjd1RWt5TXVKcFRGZ0ppWGVqTVNvS3JCVDQ4c1BMbk9SYlFXNTc3b2EvTWlW?=
 =?utf-8?B?WlZZSnpicWorVURveUUzNTlCdHlzazdNRWpaWm1nZENBeWVSUS9NUlVPWCtG?=
 =?utf-8?B?SHpIOUIzR1Zza3pFK2xoM2Q1WFlUZDZTa2lvZEVvSERVVmxoWC94RGdBM0gr?=
 =?utf-8?B?QkxxbjZqclVZaXB4KzA3Y3VYNDN6R29uTU43ckc4KzdIZGtmQVBlQTZhV3R6?=
 =?utf-8?B?aVRzUktFanNsQnJDZm1Wb3lJdU5wZG42K2I4anRxYTQ3Snl3ZSt6MC9FOUlG?=
 =?utf-8?B?U25FYU1LRFpzMXA3VWQ0ejZvb2pPMUJ5WCtWdFJua3hDa0VsU003WVByMXVG?=
 =?utf-8?B?R2E2SUUrLzdaNHJ3OFphUEN3UzhGb2x2dmVaZ3hvQWo0Z2poVXJleWtNbTZm?=
 =?utf-8?B?aXJGTFFCMUl0dUd6YmMrek1OWXJpdFZTVGdUQm0xbkU1WGxXQXFyaVdlZnRp?=
 =?utf-8?B?V2plR0E3Nkk2Qk5tazdNdGNnY0IzQ29kemh0Z2dUYkU1eHVFbG50ZjE2TG1P?=
 =?utf-8?B?OUt6ZlBuL2pvU2JQZDhVcUVlNGhGbEdwU0RjVmVhN3hVQUpUSE9FdzM2Ujdi?=
 =?utf-8?B?d0U2VDZ5bEZ6NGxlWFJVUHVMRGtOeno4SnRxeCtnNk5zTEZnYndFcDA0UGtH?=
 =?utf-8?B?SWZmODhpeFcwRlV3dnpkWUErTFF1dmVUVWc2dFFjQm5ZUVlOMTZ0ZXF3Vlc4?=
 =?utf-8?B?WVh1NUlWcHZSZ0lXNHBZOEJOZVBvMlUzMFEzYzBkbm4vS0tPcWMycXg2bHNh?=
 =?utf-8?B?b0RKL1ZTdURZS2h1MTdiSkxFRXM1d1lyc0p2M3lBWGNpQXp3SWpvQm00S1hI?=
 =?utf-8?B?RXJqdnRuN0Q5ODU4ZFhLK0QzWEV3RWhYb3hDV2dTa2VYMDQyb2VjVHl0ZURI?=
 =?utf-8?B?S1JaUnI0dEZOSkx1QXVweVE0SCt3Nk4xOWtveGp3Nm52b2tVMFJ2cGYzZ1Nt?=
 =?utf-8?B?a0x2TkdRNm9oMlRYSS9QWUttZksvTHh3QVE0WXBRcWpMVnZIMkZOV1hrdnQ3?=
 =?utf-8?B?TjFMd3doa1d1V25GZ1NjcE9wZDZpdm95a0xvczJnWWh4MkNCMlRwQm5OT0dO?=
 =?utf-8?B?aXhOVHN4SmNTYytaOTgxR3pCdUJscTFsazAxOTZCN1NYZnpYVjZoY2JmZjBz?=
 =?utf-8?B?RVVNTzJxaVVpbm9XM0NzOVNpaitRamkwVmZ5ZDhPcmZYZStZOWFKQ05ZRUxa?=
 =?utf-8?B?M0hGcVVReDBPM092UDJxRVZiYnM0eU1rR2RmTENpc0pqZ1ZoTGRSUmk3R2J4?=
 =?utf-8?B?L2pYSGE0ekVuaEFTdUI0Tm1iSVAzU25FR3RPMjlQbnJ1c0lkcllIWmh1aHVh?=
 =?utf-8?Q?tb2blBTfJUt0HYzlN4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1562.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(366007)(1800799015)(1580799018)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UTNIZm14Yy9sQzVmUnlOblJMN1lLdG8wWVBnOThKNHJNVjFsWnp5MDNTK1JX?=
 =?utf-8?B?Tmw3YXhKdWVYc3FqNHZTa2o4TG93Z2NhZ3ZSdXgveGtXc0lJQmdoTHBVN0xa?=
 =?utf-8?B?TkxzSkJHNlZHelQyYmh5bG9DSDNWYU1xOFEwUmFzcWFteUdFNUFKcGtSZHJT?=
 =?utf-8?B?cFZaOThWd0tVQVFWS3oxNVY1emVLTGhtd095cWdFZ0hBNHA5dDNjYmQwR001?=
 =?utf-8?B?alB3MEdyOHlLZ3oxT1dWdXZycmV3SnVRS1A1cksvRUt1R3ZZMGZ3Mzg5Z2du?=
 =?utf-8?B?TDFuaEJ4bzdjR0JjZFJXcmdHN2lRNmdha0J2eHFjRFpoVHFHM014Y2ZsV09u?=
 =?utf-8?B?dGZPSy9hQWFUUldNMXJhbTRWYUptRmVSU0RFQzRuUEtKZjdBcGJlT3lnekYx?=
 =?utf-8?B?Rys2NDZZaGJlbk54Zkp0Z0g4V2dvSXJCYncrVjVIRmJ4UGFvZGtmWitHMlZt?=
 =?utf-8?B?SkhTYnJkRHV0Zy96YXkxZ1d5aW0weGRFM0JueEczbnJZTkhZTTFMYkVZSmk4?=
 =?utf-8?B?dXN4ZlZENXVoK0tLQlNyVTl6RTQ4R1RlVDQyT3ppYnFMb2JwUkhXKytqaWcy?=
 =?utf-8?B?TTloK0RmRENjaEFCdGJGSWRHMUZDNUZIQ0lWS1JBUkNWNnZGc1Y5ZzVvZzF1?=
 =?utf-8?B?OVpHK0ErU0xsOXJvamI0S09zRjZ1OU1xcW5pRC9wVnppTDdlSGw5UGNnc1po?=
 =?utf-8?B?OUZnUkdXeWZqRTNKWkZaSWV2L21xSkNWRGNKZFNObC9FVEVKY3A2bXpITHp1?=
 =?utf-8?B?dHJFOExuaHRDMU5DeEtHR2M2a2hpMHZvWFZzK2l4RmJzemRwcUdPa1pkVXB0?=
 =?utf-8?B?ZUthTEt1RzZ3R3ZwWFZIT3hmaXhSeVc4dDZTRkFkOVNwZjh2Ym5Lbis3NlNP?=
 =?utf-8?B?SEg4ODA0MWtqWHZ3dVRIelRFaHNTWXdJdm5FTUVlQnhCM0J4c2h6ZmlDT3gz?=
 =?utf-8?B?OW1LM0NCbFF4dEJIb3AvOGljNFJsU3dxT0xGcGdtSUtBK0U3UjU3RGk3aVZh?=
 =?utf-8?B?VGlTeWNjV2dQYXJnYVhIZTJCVnBxazdVdCtBMnRPL2V3ZythZldsbWcvc3Ju?=
 =?utf-8?B?SGo0bzJGV0l1dGtPWnc5UkhUWkhUdDdqK3ducTNURGFBTmxPc1I1YWlmY05m?=
 =?utf-8?B?TXdvaE5OYnphTldKWXo2Qk4xS3EyNE5GckdaM1pFOUJ2ZlpzRGFFZ3gxcHRO?=
 =?utf-8?B?ZTQ1RFROayswOXdqek1IcVFSeE91R3hQTGN3YjVRZ0thTGVJYWlpTkxtMUZn?=
 =?utf-8?B?UzMyd1NuSmhZY1d0RUJvSWFOMXBlSlR5MmV2NFkyTzl6WTkzNHhxb2FlMmlB?=
 =?utf-8?B?Z1BBa0RXWkNJck5ERTFWYytLdFllV2RwaDBQUHZmTnhnaXlJVlV5VzhjQ1U3?=
 =?utf-8?B?T2tLMlZhMlQ3TmpFZ3FNZU8xS3U1VndleVRjN3NnYk5QL3RGbWVMb1ZHdkE1?=
 =?utf-8?B?L0V2bm9DWlU1cStzY2x1MURqNmk2S05VaHR2RzNUMVQxS1BVUHNLRm5nQmFQ?=
 =?utf-8?B?RWFZaDBsQXd2WUJ0SGhWOU1UZnNsL1l6VGVRNkRnRkNlUDVBUTliUWdiZGk3?=
 =?utf-8?B?Sk00TGozZ241TWtoc1BkU1JNbmJua1daa2JoL1NwZ25QOEdiK3AyS3Nwa0V1?=
 =?utf-8?B?TEEwUXRyMjk4VkFPRXRzZTVlNjYzSTBFZ1NNWXRPemZQbWEwVW9SUTkrN2Zj?=
 =?utf-8?B?L2N2SldMYjV0S3pRV2NCZGlnUnZ6S1BNdDMvMVhjcVB5RHIrNklmT1pCTzQ3?=
 =?utf-8?B?dmgzNlFkamVWTW0vQW8rS3RidlNtUW43TVZHNDFjK0JtblJMUjFhVFM0WnFO?=
 =?utf-8?B?bS9xR2FJRkxkK1NTL0o1SUlmY1lJbWRkTkt4WG14NDlnMzdIS0piVk5uZVgv?=
 =?utf-8?B?UzdJaUw0SGNMWUxmZU9GeW40bDV3NUxHNkZCTXVKa1VzcXE5SEVBeVFJeDh4?=
 =?utf-8?B?UXdPMjViNjRYcHltY2F0M1ZkS2lvVUJsYVB5VjI0bmdTZEx5ZWN0aHJ3VCs1?=
 =?utf-8?B?bzhOSHpuZ3VIbkJmc2R6aklPQit6SEk4VXREU1VXbjNMTTd5N2drdVcvQjBw?=
 =?utf-8?B?RnZTY2R5ZVdVQVVnaFEzaVpPVW85Z3NBSnBWUVh5TTV3V2tlcUhKNG92UEhN?=
 =?utf-8?B?SkMzT1dnVlMydFJoSWdmbWNGczgwUTErdWdjajI0Q25ETTJROVdIOENkUkxY?=
 =?utf-8?B?Tmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1994ADC621ABE84F9A5E4926E5F987F7@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	whVK2Dt+gIot4CatjAwTJTEzmzztmLL6w92QT+YLDom0TrOgoIhXgB+6o3mnvRtHl4i8C1HGrgzhPydwNZVffk6NBheQitgruoJjit0fdReVM6w3aahzijCkQFu5DU8jGXN3cqqX+xkPcl17h25wS9rLceCwF1g1qaG7aDe885jfA949VxT/qIOUVm9OI65LhinMTlB1SYYQqE+HqO4g1rMTLVec6Kx0Ly9WSkzWQCM4eoFg5h/QuC1tmc2YLmXwBoV87aqxkExU9NHl5W2tVqKVkv29sZRyQr6DNcU5UhDezyhE8nyiSMzrdFraVgM4vvMUukTpJRHO9Jvq32+f3EZyUsNE8HS/B6Mb4O28E1ZWe9b2/c9XEvop8+poR18hHOtS4t/CtSjuXw7m0Fl6S2mRURHBewy0SLJV+CWxtrL8s8QrvGHx77WFBF+A8v9hmNRvbLJbV5t3+zvQq6KhOQYPDU/8uSw2SufVdQIBkFDDqKXtLDuWuWiOMCn/epPmYplhs9ScZAEQDutSZmyr4u/tyhbW7BYUoT3fmYVgsLEn/d15S18WsznCFNx1yRrvy7u27sT6dtgYUPRTQeEA2JeDwcvnpKJW7WykPNpsr6NZKG/INxhhma0RQWe7od8w
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1562.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab121cb0-114e-4c16-63b3-08dc6834c686
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2024 10:11:45.7878
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OGjdSHryUr44khAiyb6rnJGH7fXsz2pku9UPvwHbZaji5H2eTQVTe/mO2JAJaE1nZ04Kr7KBgrtCrpElK0JXDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9938

DQoNCk9uIDI5LzA0LzIwMjQgMTg6MDAsIERhbiBDYXJwZW50ZXIgd3JvdGU6DQo+IE9uIE1vbiwg
QXByIDI5LCAyMDI0IGF0IDA4OjI2OjE5QU0gKzAwMDAsIFpoaWppYW4gTGkgKEZ1aml0c3UpIHdy
b3RlOg0KPj4NCj4+DQo+PiBPbiAyOS8wNC8yMDI0IDE2OjAwLCBNYXJrdXMgRWxmcmluZyB3cm90
ZToNCj4+PiDigKYNCj4+Pj4gU2ltcGx5IHB1dF9kZXZpY2UocmVnaW9uX2RldikgaWYgcmVnaW9u
X2RldiBpcyB2YWxpZCBpbiB0aGUgZXJyb3IgcGF0aC4NCj4+Pg0KPj4+IFBsZWFzZSBpbXByb3Zl
IHRoZSBjaGFuZ2UgZGVzY3JpcHRpb24gd2l0aCBhIGNvcnJlc3BvbmRpbmcgaW1wZXJhdGl2ZSB3
b3JkaW5nLg0KPj4NCj4+IFllYWgsIEkgYWx3YXlzIG92ZXJsb29rIHRoaXMgcG9pbnQuIHRoYW5r
IHlvdS4NCj4+DQo+IA0KPiBHcmVnIGhhcyBhIGJvdCB0aGF0IHJlc3BvbmRzIHRvIE1hcmt1cydz
IHJldmlld3MgZm9yIFVTQi4+IA0KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyNDA0
MjU0Ny1zaGltbXktZ3VpbGVsZXNzLWM3ZjJAZ3JlZ2toLw0KDQoNCldvdyEhIFRoYW5rcyBmb3Ig
eW91ciByZW1pbmRlci4NCg0KDQoNCj4gDQo+IHJlZ2FyZHMsDQo+IGRhbiBjYXJwZW50ZXINCj4g

