Return-Path: <linux-kernel+bounces-161677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 219468B4F52
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 03:53:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB01F2827FE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 01:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4831310F7;
	Mon, 29 Apr 2024 01:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="ejsz22/y"
Received: from esa14.fujitsucc.c3s2.iphmx.com (esa14.fujitsucc.c3s2.iphmx.com [68.232.156.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78CB57F;
	Mon, 29 Apr 2024 01:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.156.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714355576; cv=fail; b=fWTmtkC2GEYscf6d1OeeJv9yh8qWXh6WOa2ZCOTMZg0ZZXGvxtC6A44cD4CCpAgX1ftXLyQ3DASzpZ6h9Crcwwhvyf2Zv2LZX6q7VdR8qkJ9LcV83huNweIkrhETk51gr3NL7vZJGRcAK0MwpR7ObGVgJmmHA8zKYuvPYIYIeQI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714355576; c=relaxed/simple;
	bh=gTsUvZK0k9e9Ar3QQtI2hh9icNyfLBM0aJY6tleFX54=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OCunXkMt6k9MO/o/j1QnkNqINK6XdI8BwjUmLNM6bnqfmnnOZz31w42Z2YRUiHvdJpYdLNl95JF8EItf3VCy7bQ+F+/vsfvMETGK22HxhK6oAQEYmIaJb+lXQ785dxv35QkCMk64QNkmAHg7vgX8H1XcHXhOQyqVKyYJGwUwDRE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=ejsz22/y; arc=fail smtp.client-ip=68.232.156.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1714355573; x=1745891573;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=gTsUvZK0k9e9Ar3QQtI2hh9icNyfLBM0aJY6tleFX54=;
  b=ejsz22/y19Vdp22M6cvw/BR91SiD5PbekL1Ez4wHd9dyPby76DlXYtd/
   pmapvU2YTXq4efudygIbHpcyFHp2zuxElsXw3BW6l5zwhm91YQvH85+Hx
   tfiHbVQ8e8ka6kwpkebB9MStVf7/Z7S2xBVfnOpSTQ+Pb4r4yipMRAUlG
   LOaLT96WT6ybMcC1Doj6syyVsEgBoBFXcdZ+/UiDxh9pZE9G1ErfOMytm
   5Rl5zedkzrsTKAqSeNVvikeHj6mkOUK7K/ZX5lSnFCl8MNkAfBNQd78WX
   lor3fB5txyVrT9p0QtNKiISwOTItcNRXr35PkZZpXG/OxqUiRwxKdpEsw
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11057"; a="117700309"
X-IronPort-AV: E=Sophos;i="6.07,238,1708354800"; 
   d="scan'208";a="117700309"
Received: from mail-os0jpn01lp2105.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.105])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 10:51:38 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V8s5DvBdjEyBoEwEY3W9I49XzvodCdwX5nwVntOo6wd/6zZa3aUrNWHHm5jhbBZWJPAUfUybzupDwekNRQJZ1pFYhv/QFdct38dc2Xd9bUETndWXV8EMbmfhfb7A0OWg+2IJ5gWWa2YH7oDdqhB0kbtMk4SDsIa4/S27mfjuTN5AhnS0PSNiN5YGgLmMVls5egbyabc1BER+2OB0sHtzslNPKCgffMBlwGofnqVDZ67p7KQFHOzrni7Wf0fTb5XR412o+W4fzqziiPnYpMLaqQSe7QU+Ri+lMGW1jqMjaWJimUsN8hIdPtQs3ZEjaNB2h38mu6oGq8Yvpp0GPKCjow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gTsUvZK0k9e9Ar3QQtI2hh9icNyfLBM0aJY6tleFX54=;
 b=Lxj7TXkWl6frURziS6FcrliGPpacvmCKTuzzZuLeiECQNrApnsYmyQ620JtdAMlV4o5g7nO+VzLgVArYPc5YFPLYAkBrmyjqNiPQY7XQV1Nm4WsGWVLyfS4rn2hEN73nRNtZ8zfLfc2rmYTpqtinUL22DpW2V8+oZ28j8Qag7z0ypG86BC6RXVoHxfqW74EG/STgVZBCTU/PW1M5KCgxnFET7yGEz+YHtc3Ml1iaXZkuhFQa9pKchPFX50RP09BCQPCv++zwaQHfbUDHnNF70HU7NjG+bYlQ6esm1iqJDiwLmQZBSVvvoBZgW0rHn9FI6tRxBMxXAYvbNZfyTMt8eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (2603:1096:403:6::12)
 by OS7PR01MB11728.jpnprd01.prod.outlook.com (2603:1096:604:242::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 01:51:34 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377%5]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 01:51:34 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: "dave@stgolabs.net" <dave@stgolabs.net>, "jonathan.cameron@huawei.com"
	<jonathan.cameron@huawei.com>, "dave.jiang@intel.com" <dave.jiang@intel.com>,
	"alison.schofield@intel.com" <alison.schofield@intel.com>,
	"vishal.l.verma@intel.com" <vishal.l.verma@intel.com>, "ira.weiny@intel.com"
	<ira.weiny@intel.com>, "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] cxl/region: Fix missing put_device(region_dev)
Thread-Topic: [PATCH 2/2] cxl/region: Fix missing put_device(region_dev)
Thread-Index: AQHamdUJ/baSUL4fTUadXbdXZxcbY7F+e9oA
Date: Mon, 29 Apr 2024 01:51:33 +0000
Message-ID: <db8619ed-8c64-4494-8552-1c54f1c189e6@fujitsu.com>
References: <20240429013154.368118-1-lizhijian@fujitsu.com>
 <20240429013154.368118-2-lizhijian@fujitsu.com>
In-Reply-To: <20240429013154.368118-2-lizhijian@fujitsu.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB1562:EE_|OS7PR01MB11728:EE_
x-ms-office365-filtering-correlation-id: 3557c0cc-6072-42e6-600d-08dc67eee5ed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|376005|1800799015|366007|1580799018|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?NEROa0ovT2R0SkVINk5CeEpGbHFTbnNkMzVBblhjYUppMHJlVjlzdFlsaENs?=
 =?utf-8?B?NjlwY3VOUVMxZWt3MTV2UUcxZ1BIQzlxZytPbW1FeVIrUStLWXRiSVgzOHM4?=
 =?utf-8?B?TlV4Rzl4KzhSZ0dDbllMcWk0U09mTWtjNG5NUUg2OGhKYkx1VzhTMW9MTVM5?=
 =?utf-8?B?YTZTZ01Zc3NUbGNtbzNpOGRWRHcvTk9jSElWTVVWQzBBMjRsZzVwd25QRERm?=
 =?utf-8?B?UE9SZGp3R1hLeDlScmVqcDNtTzI1aVJHR1pnc0V5dkdWSWdhTEt1blI1ODBt?=
 =?utf-8?B?WGg4UDRWeDBpTGJBZUtURFZwYk0yd3VTbWRib05iR1V0QklyNGIvZ1pLVTZm?=
 =?utf-8?B?WFlzc1g3NlFlK1lDWnRFZXdUdXU4VzJnOGw4RGs3aHRLWHk2M1ZCTllqMENP?=
 =?utf-8?B?blJaYjBSWEZvRzUyaWM5b3h5d1FjeHpuQjA2eW1UdENMdU10cGd6YmhJbUl6?=
 =?utf-8?B?bm1DMnhWaHpQQnp1M2srbjg4UW00R0hSRG0xMFhXNWlZMnhqZ0NWVXYrZDBl?=
 =?utf-8?B?aTA3WEVmaTYzNUFhcXZZYVY0OFIwM1VoNmNWWkpHdVlrR29LdjF1cVJLL1Fi?=
 =?utf-8?B?WnJTLzFVVk5nWDluS3dnSUhXdnc3anVPQ1B6R0RTK0FGeFpnMndnMHJtR2Qr?=
 =?utf-8?B?bktsMlh4QVdjN0hMa0J1NUFXdGF4RnFxWUp2NjJnNmROWjdQUEJoNVppWEY2?=
 =?utf-8?B?UzZsMlR3RUozOFp6VU54b0FGOG5TZEd3T1UxMkQ3MjVkRUpGM0tUajNYM2E2?=
 =?utf-8?B?dkxYVXBQMTVsNUJFL1BMNGR4L2llbnROS0M2ZlhZTlJKTm96cWpQWkxnUTZQ?=
 =?utf-8?B?Q3JKZVh6RUk0VEZzMHdkb0pkckNhOE1wU2hlWmlMa2xhVEt4SGN4WW5EenJu?=
 =?utf-8?B?aG5Hb0RCLzk5cnZpNXc4ekprZVdOV1IybGZsVjM2MG5XUXpQTjNkSlk1NTBj?=
 =?utf-8?B?ZTE5bnF4T3lOZjVJakQrbVpmajA0S2JKT0NQTzZyS0JPVk5VVU91RG04dkFE?=
 =?utf-8?B?d1hVU2thWWpKbm81Vm83bGFCZThKd3dBOU1BZHJNdGdMbjdFcDZOSzVhVTVq?=
 =?utf-8?B?SDA4aG4rZTVBdnJPWmN6N1JDcDZnZ0FpNHl4bzFjWGR4WmZIeE13RjViRjBx?=
 =?utf-8?B?MVpDeFNQU1JISFhJc280dmMzWFNaNXMwQ1MyMEk4dWVqNUE2V2lzSVRteVk0?=
 =?utf-8?B?cE02TkwvS2tuSFZ5YTY4UG9JYXFEQm1QY3NnZ08rRGRPSnV1eWpjN0hXVUJL?=
 =?utf-8?B?MC9YMTZyUnNCN0pka2tkWU0xMzY3bnVNLzcvcEFxU256c09oeWRQMGpXTkJv?=
 =?utf-8?B?dFo2bFV3clBidzNVczlWbTlLTVo2T3I4dTBjbVZ3RXIwSW5VWkpDNVZlb1Vj?=
 =?utf-8?B?dFV3TTd1dlZUVWJGQWVsd3Y3TkZuSDVNOHFIa1UrOUwwOUFDUGlJMDV2T3Fl?=
 =?utf-8?B?MGx5dkh1VVlMazFxTVNaVzloMDZ1YzJCVTZwWVlkWUZ1dzZ4TTVETis0MG5B?=
 =?utf-8?B?cmpPSVQrRnF6dVN6Tlc5KzRPdFBWU1pQTGRlL3Z5alRKYmpDSE9xYjVTYzNN?=
 =?utf-8?B?WDlYMGFGZThsVkN5aFZXZDFqcDR2UmlFSDY0WENIN2xTV2NCTTUvOXFycGJ5?=
 =?utf-8?B?SXI3RnNIVWR4cEdXZXFTZ2lsbStUN3k3VVY0MTVkRjR0M2ViVUp0YnpvbFpG?=
 =?utf-8?B?L0Z6ZTJHcVVDcWdieEJyeityenVVbGVTUlNHcUEwZ2tKZGtxK0RDOGozbnVo?=
 =?utf-8?B?bkgxcnBCTjIzMWJ5eXp2Y3hkVXdXcUtlQmg0bkRiVll6VTVKZ21mQUVmN2Ni?=
 =?utf-8?Q?HfVFx+Oq9Jk3Ie5d/cvpujUdVusw3kw6pe47U=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1562.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(1580799018)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZFd3eDNFdFp6UUZwOEdPbUJROVNsbWNBNXNncFV1bkJqcUpZcndpRnhaSUt6?=
 =?utf-8?B?NTBMdHFnVit2TkljRWRxcFRsR2tCRnliUGFDdFM3RUFLTE02L2FWRjNTLzIr?=
 =?utf-8?B?elF2enJMelVBaVpCVGozZy96ckRqWDQvOGEyc3hMRU1mWkVDWEk5VHQvTXVt?=
 =?utf-8?B?eHFTSkdoVWE3TTNONTZxbk5oV0RReWxTSnBCQWxFcFRSZVJOa2pyYWVWOVNY?=
 =?utf-8?B?THFXcHVRUU9DY0IzUk5BSWVLRzlCMC95RFRxUzhBUWJNeC9ESWdVNjlJa3po?=
 =?utf-8?B?VkNYSTA5MFI2UHRXbmNHeDBhQWxRd2F4c0ZNRG1OSU5Qc1YwVjNJTnJMZ0pE?=
 =?utf-8?B?eGkvcWl5a3VFT0dlaHRDbmRhbGdPUHNzN1JLYVpIN01sZlRUc2VLT0ZPTnJO?=
 =?utf-8?B?VzhwSmFxSXJ5eWRCK1NZNmpLY3JzMjE2MC9Kd3VocUUxbWpoeUdaYXRhLzFM?=
 =?utf-8?B?NnJhNS9zUlNDV3JqK2JObFVYYkswem1oSEVJdFQ4bXU4SzNIMDJGR0pnYUdG?=
 =?utf-8?B?OWJFZ2VYNkRSQUgyK1VUU0xNVkY2TjVYR2JPTGxpTUtYY2pQMW1YeVJrMXJQ?=
 =?utf-8?B?SWZFaWluenVTd1k5K0pQZlNtTiswZEt2UFNINnBKMXh5RWhKNUdpUlNmakd0?=
 =?utf-8?B?VDNvWHF5T3JIS21rWnNnU2NDeGJwL2FIcGduVXVYb1d6RGsrNmJrbDBYNCt0?=
 =?utf-8?B?bjJ2ZkpGalArWmRDb2Z2WmF3UDFuM1F0TGxHdHU5YTVZTTJCeEFYSmdFUjQ5?=
 =?utf-8?B?c2JNMjk4OW9KMDk3K3dtSjBLNFY4M1h4VG9JOEs2UTNJT1VkZ1JSY08xUjd0?=
 =?utf-8?B?UmZ5RTBFZlp0cmFYOUhUUFV6b2IrcHExejh5U3V1TGRUbG5veFlhMmx3cHcv?=
 =?utf-8?B?Z2VxTElBZnpEeGx2Q2lOai9LZVNqdXFWMDhnSFJxS2tEanFNM3dmeHFMcWpw?=
 =?utf-8?B?bHd1akc2ZXpVSjAzSVJMWW5vZHR3T2xmZTRQNWVrV0dKWVR4SXlEczdXT0Mr?=
 =?utf-8?B?UG1sUWk5OWlZMGJOV0N3cEx0TDQyeE1QRXhWOEJxRTFaMG95czZYdWVIL3Fk?=
 =?utf-8?B?V0xpQXVNUkxmTXNuNjh6TVBTcUl6YmQrZHhUNnFoajM0aVpJNjVyemR1OVBJ?=
 =?utf-8?B?TW5PQW9qUjJ1WkYvMG9yMk1FNm93QmplSHFZdXZTeGVQVlZ4K3RiQXZObm1E?=
 =?utf-8?B?T25CT3M0SU1RUEFZV2RPWmFtUjN3b2FTT1VlTVc2MjNIUCtzbS9HclpzYVNk?=
 =?utf-8?B?OW1LTmtnWGJsMzUwa2RMYlBCTXBsdEFrMVhDZGFBa0VRUUtZN2RuSytiUGpH?=
 =?utf-8?B?UXVpZ09pL04rUVp3SUZDWDRHZm1uMHExQnB0MGNmOEh5dVRlYTU2bkFtalZB?=
 =?utf-8?B?aFA4QlQrNVVLYWQ3Sy9nMnRYckVvcjlYU2dLSHlOTEhNcTI1S3Bkb21QT3dx?=
 =?utf-8?B?RnA3VDVDbC81VnF1eE5YanF3S0F2OWQzc0F4RUo0NDJQeWpKZ1BMMjdkRGNU?=
 =?utf-8?B?cHZhTjU0c0JGbTE0U09oeXM0WVlJYXF0ekdBNzEwQWtuRFhXdHMySnptYk5P?=
 =?utf-8?B?QzRsc08vY1VpcFBad3RVNFJBaHA5RmRVazFGM0ZoMVlJUFE1K002d3ozZXR2?=
 =?utf-8?B?aExiVVlheHAxK0ViRDlRbzllUUhWZ2RHTWVyVmlNVm9BemVkSU1sUnVPNnM1?=
 =?utf-8?B?VTNJdHNmSFhtQjV0V2ErbzBUaTBZMEpVS1lZZ200YytJUXNYeWk0UmxVc0l3?=
 =?utf-8?B?aEJKYnUyWGRGK3lvamU0dnJGTmJONVdiYy9SanNPUzNyOXd4cFp5RHRUbi8w?=
 =?utf-8?B?bUVIM2k4QnBmcDZMeGc0Q1c1R2VuODA1dWgyRndFL01XbXY3Z0txQ3pDTkln?=
 =?utf-8?B?Z2ZySEtVOENzUnh3dFdEME90SDJJUFhITjUrdzhXYjJ4RlJKMWxHclBDN1Ri?=
 =?utf-8?B?ZWVaZzZrblM2QU56dk1DQ1U4L2wyVGJjNTYvWHZNL0NRUko1aFhWSkphMUVj?=
 =?utf-8?B?dmRyK0h1cHRpWlNvWkZCNnZxeWlpS0VacExya2ZQZTRGTnF4UkR2a0wyWll6?=
 =?utf-8?B?ZzM1Tk1lQjY1UXBrZVZ0a3cvVEtGcXNoTFRuNXBvU2g3WXBqWlFJaUFNMnBU?=
 =?utf-8?B?N1FaZkNmSURQbEtJYnVLclRkQzQxL3RTMHFLcFd3dmM1Q3JaKzl1MXBJRTRa?=
 =?utf-8?B?cFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <57CC3B82107F74439178A8D6810D50C6@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	YM5mQTGKKhm1g1pa9Ix+EJ3h6OZYjnGk2J33XsDiXvF/5REAhyZry+hXCrm3ff4+LdIY5nN7oZU64dc3TmfSUSZ6nchbSL1j7pFX+e3s6aD4hcrytQiYqX0HUgeOriA8HQT+j27gYTg1KEhjavNm0pUZ3XOhbwV/lyUuQi0MhAnPXnGLc+J4C/gLZD/s1QwfGu0l/CMZHHwv7z+1lQkNXw8dyaP1nxtNsBblysr4fKl+tbTKDzTHp0CsF0N/DoEI9Sp+Y7D3HrH72J0WCk5GL8v7PV5b534Vh16pgsRiiq3BbuEqAJ8aFzdw/ROMsxwz7K2yN28ov6V4jHH3l/u2AQYhaeUNVIXbrBp7mR19bXO12W38v+dMu6BMusQGgUKQ0JpWCKfzk5i8X7Fq9QnVFBv+QMw4xKRIJUGIuO9tCZCo/2OPoSXZrLn8yjExJkqvYTKtSvHk/wlXwYQeRWku5nvMobUtN9FOUCZrSRAUNx4XMzXC7LWpTfVyEizdGakFdSRSkAg+uix42Yt5P6uFe/k6F5QQTb9UG9d1WPqFrqAjczCwqeNsKvJub/SYs6qIctSr1QG0XQ0AhG0nN0n78HA7IE3pyZKvY74PE0oa9NGT7bdNfTYTE9daOKtNFmkH
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1562.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3557c0cc-6072-42e6-600d-08dc67eee5ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2024 01:51:33.6720
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aifjolUX1FVm7h7v2h5Bls8b1cNGD6o32h6L8QhW+0RIWMYnf6vpp3m7MLkcfIFsMulgaXngA4UOdnzLYK65ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB11728

DQoNCk9uIDI5LzA0LzIwMjQgMDk6MzEsIExpIFpoaWppYW4gd3JvdGU6DQo+PiAgICAgICAgICBt
dXRleF9sb2NrKCZjeGxyZC0+cmFuZ2VfbG9jayk7DQo+PiAgICAgICAgICByZWdpb25fZGV2ID0g
ZGV2aWNlX2ZpbmRfY2hpbGQoJmN4bHJkLT5jeGxzZC5jeGxkLmRldiwgaHBhLA0KPj4gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG1hdGNoX3JlZ2lvbl9ieV9yYW5nZSk7
DQo+PiAgICAgICAgICBpZiAoIXJlZ2lvbl9kZXYpDQo+PiAgICAgICAgICAgICAgICAgIGN4bHIg
PSBjb25zdHJ1Y3RfcmVnaW9uKGN4bHJkLCBjeGxlZCk7DQo+PiAgICAgICAgICBlbHNlDQo+PiAg
ICAgICAgICAgICAgICAgIGN4bHIgPSB0b19jeGxfcmVnaW9uKHJlZ2lvbl9kZXYpOw0KPj4gICAg
ICAgICAgbXV0ZXhfdW5sb2NrKCZjeGxyZC0+cmFuZ2VfbG9jayk7DQo+Pg0KPj4gICAgICAgICAg
cmMgPSBQVFJfRVJSX09SX1pFUk8oY3hscik7DQoNCg0KVGhpbmsgYWdhaW4sIFBUUl9FUlJfT1Jf
WkVSTygpIGhlcmUgc2hvdWxkIGJlIElTX0VSUl9PUl9OVUxMKCk/DQpQVFJfRVJSX09SX1pFUk8o
KSByZXR1cm5zIDAgaWYgY3hsciBpcyBOVUxMLCBidXQgdGhlIGN4bHIgd2lsbCBiZSBkZXJlZmVy
ZW5jZWQgbGF0ZXIuDQoNCg0KDQo+PiAgICAgICAgICBpZiAocmMpDQo+PiAgICAgICAgICAgICAg
ICAgIGdvdG8gb3V0Ow0KPj4NCj4+ICAgICAgICAgIGlmICghcmVnaW9uX2RldikNCj4+ICAgICAg
ICAgICAgICAgICAgcmVnaW9uX2RldiA9ICZjeGxyLT5kZXY7DQo+IA0KPiBXaGVuIHRvX2N4bF9y
ZWdpb24ocmVnaW9uX2RldikgZmFpbHMsIHB1dF9kZXZpY2UocmVnaW9uX2Rldikgc2hvdWxkIGJl
DQo+IGNhbGxlZCB0byBkZWNyZWFzZSB0aGUgcmVmZXJlbmNlIGNvdW50IGFkZGVkIGJ5IGRldmlj
ZV9maW5kX2NoaWxkKCkuDQo+IA0KPiBTaW1wbHkgcHV0X2RldmljZShyZWdpb25fZGV2KSBpZiBy
ZWdpb25fZGV2IGlzIHZhbGlkIGluIHRoZSBlcnJvciBwYXRoLg0KPiANCj4gRml4ZXM6IGEzMjMy
MGI3MWYwOCAoImN4bC9yZWdpb246IEFkZCByZWdpb24gYXV0b2Rpc2NvdmVyeSIpDQo+IFNpZ25l
ZC1vZmYtYnk6IExpIFpoaWppYW4gPGxpemhpamlhbkBmdWppdHN1LmNvbT4NCj4gLS0tDQo+ICAg
ZHJpdmVycy9jeGwvY29yZS9yZWdpb24uYyB8IDMgKystDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDIg
aW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Y3hsL2NvcmUvcmVnaW9uLmMgYi9kcml2ZXJzL2N4bC9jb3JlL3JlZ2lvbi5jDQo+IGluZGV4IDNj
ODBhYTI2M2E2NS4uNzUzOTA4NjUzODJmIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2N4bC9jb3Jl
L3JlZ2lvbi5jDQo+ICsrKyBiL2RyaXZlcnMvY3hsL2NvcmUvcmVnaW9uLmMNCj4gQEAgLTMxMTcs
OCArMzExNyw5IEBAIGludCBjeGxfYWRkX3RvX3JlZ2lvbihzdHJ1Y3QgY3hsX3BvcnQgKnJvb3Qs
IHN0cnVjdCBjeGxfZW5kcG9pbnRfZGVjb2RlciAqY3hsZWQpDQo+ICAgCQkJCXAtPnJlcyk7DQo+
ICAgCX0NCj4gICANCj4gLQlwdXRfZGV2aWNlKHJlZ2lvbl9kZXYpOw0KPiAgIG91dDoNCj4gKwlp
ZiAocmVnaW9uX2RldikNCj4gKwkJcHV0X2RldmljZShyZWdpb25fZGV2KTsNCj4gICAJcHV0X2Rl
dmljZShjeGxyZF9kZXYpOw0KPiAgIAlyZXR1cm4gcmM7DQo+ICAgfQ==

