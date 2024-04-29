Return-Path: <linux-kernel+bounces-162052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EC4A8B554A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 12:27:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9421284D0B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 10:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A49C3BBF9;
	Mon, 29 Apr 2024 10:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="J6J7nEEc"
Received: from esa3.fujitsucc.c3s2.iphmx.com (esa3.fujitsucc.c3s2.iphmx.com [68.232.151.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098D43B295;
	Mon, 29 Apr 2024 10:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.151.212
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714386425; cv=fail; b=iL4ibNnmal40tKTKAYFfUD2h6dQwyOereTx7O2492i16AS1G5wyCu6i4fUClMiYQZQvZqAgE4OcBGjfrdLRWJu0/Q02LSiCx4Y1BhXplUkpXGrpxa8/Fbp/c/7UYaJVngkFkLirwIkM7NFQId9DvRkJ+1HHBeXCnxxpC1EDVyWc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714386425; c=relaxed/simple;
	bh=g6grfQVj4HvGxkfYyEvxNlAde1WOlDfnO/F/t2gWij0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KYFYhQVkwg5rDPGnJRbRTZEF/w3M1XYvKvwD9D9P5EaLg/zzmfIOZcLBNDP8S5Twn5vyE4BUzsYdBmO5OfWKqf2Cuz9llkwM40cayY6LcAOOcUEEirglg4yvAPmlj1rkEuPOfZrwSOeMjtrGpPCpbzrjago/c3VLdxxJiZ1vt8M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=J6J7nEEc; arc=fail smtp.client-ip=68.232.151.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1714386422; x=1745922422;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=g6grfQVj4HvGxkfYyEvxNlAde1WOlDfnO/F/t2gWij0=;
  b=J6J7nEEccH8n+f4U6BAOkaWdBKkvLJHy8f0ic/wmOV5LpGKy4iwuYZI6
   6WyY+gbSMKraHt2OuxCWB63JTtVlcte726ETFNwOZYQ8eWJ2aPg6ViJjF
   eXIBqTd4zegq5Z1NXHGHdnT3MgD7oyHDkxNJxhZhmnufiftQMD6tB0fKa
   6N5H1ffGjKe4XFrcsD/cLs56m9t34fkxNxN68jWBegMKdtX9gtxhPQ0lo
   cJD0atePuT8G8dGT5+Aky1bVzpbShJsIg7LnMT2gakrej30f8NuAJSVQ9
   ZvzvDXxJUDKEMbQtveGZsgu5jTcVLtdYrT4SmItlrLJYobHj1DAQLOif4
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11057"; a="29305849"
X-IronPort-AV: E=Sophos;i="6.07,239,1708354800"; 
   d="scan'208";a="29305849"
Received: from mail-japaneastazlp17011004.outbound.protection.outlook.com (HELO TY3P286CU002.outbound.protection.outlook.com) ([40.93.73.4])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 19:26:50 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fTkhqopkXBfvH2AT8xFI3dvygGFyeuY+cu3dh26uucF19kTx1VytRb2Byi4iQz7MtV8WE8USY+pjvEke7TNAYH1g9g8r7z7FIO5H1RczE73i2LjQ1VkcX8b4MQWkTt2qAYMXsukTpix4S0xB8Vi/lJDtSPSnXt+SUGe9MCXGO80pVRFgXNb7gyQw2iKLv80EMmwtySB7kEr+GidpqTlaB1uFNDu2wAn0WAuAkbzR2HY9p1GKzmjWCrliHvUuT0Dz7iTAyTlwk7VJzM4J6HLaFWwxeUiL0bH3Z5YPfP2UzpTgeblMK80jOK+FVEe4cciX4KxsxajReZeHrihw0j2ZIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g6grfQVj4HvGxkfYyEvxNlAde1WOlDfnO/F/t2gWij0=;
 b=hzdyIUdNheBhJ2KVxQ49hI0N+GvvWt1qIA4reMmKmwFd4b6SdkBVCkTBJfFLqYAS1yU7BEPQ7ermqPomTPwp/Pw/v3Z03qinA4vnildjq1SXGtaNhgD9WiVB5U41NDRETETN6EZ/68qm1DlqVQPxmIiAV6NJx1jt9F+EuX4F9B4nKPap7cEsZA15nJBChYgWMn4MHXf4CqzptJEFKzPPF+txgmZHHkx83IRgaoEE4hTfDuSswyW+znKGjcp2oWfoT3H2aCdUHE+o8KcBRFWROyyB+uAQ6vIh31WpPi7QeJLmF0W4C+XHSMDf3kuyWZBdVvk7WFbhIyzhQ8s2kBMQSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (2603:1096:403:6::12)
 by OS3PR01MB10138.jpnprd01.prod.outlook.com (2603:1096:604:1e3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 10:26:47 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377%5]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 10:26:47 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
CC: "dave@stgolabs.net" <dave@stgolabs.net>, "jonathan.cameron@huawei.com"
	<jonathan.cameron@huawei.com>, "dave.jiang@intel.com" <dave.jiang@intel.com>,
	"alison.schofield@intel.com" <alison.schofield@intel.com>,
	"vishal.l.verma@intel.com" <vishal.l.verma@intel.com>, "ira.weiny@intel.com"
	<ira.weiny@intel.com>, "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] cxl/region: Fix missing put_device(region_dev)
Thread-Topic: [PATCH 2/2] cxl/region: Fix missing put_device(region_dev)
Thread-Index: AQHamdUJ/baSUL4fTUadXbdXZxcbY7F/CRiAgAACtwA=
Date: Mon, 29 Apr 2024 10:26:47 +0000
Message-ID: <cd20f733-3523-490c-8bc1-73b7300f18b8@fujitsu.com>
References: <20240429013154.368118-1-lizhijian@fujitsu.com>
 <20240429013154.368118-2-lizhijian@fujitsu.com>
 <df5830dd-d822-4c11-9cce-3775dff0113b@moroto.mountain>
In-Reply-To: <df5830dd-d822-4c11-9cce-3775dff0113b@moroto.mountain>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB1562:EE_|OS3PR01MB10138:EE_
x-ms-office365-filtering-correlation-id: 0a19f854-b05e-403c-6c42-08dc6836e01a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|1800799015|7416005|376005|366007|38070700009|1580799018;
x-microsoft-antispam-message-info:
 =?utf-8?B?d21pTmp2RnFVUXJqeU5YM3VaY3laTlphbGN0SFl3b0VqUU9VeUtWamFJSWF2?=
 =?utf-8?B?d2Z0d2VHQWE1S0ZCQmZqd0lBeVVuTzlET0xtYUkydkg4amlIWm13VXJReFM4?=
 =?utf-8?B?UkozVmNVanBMRTFGWXBpWkcyR1VySUh4UTczNlJiTklLbWMzaFhWQ21tYUtn?=
 =?utf-8?B?dEExUkorQUU2YUJNbGZGZWVIZzNHQnQzc1dHZVM4K3JqSEtBcFFCV3JnZlNj?=
 =?utf-8?B?M0lVYkFwczVNM0QzUHhob0xpQ2ZwWERLWVJ1c3lvVVRtMERLSU5TcHRGamR3?=
 =?utf-8?B?VTJBbXIxODc1ZDRJV0xRMUZhTG1WcUpOclVwU3NLY2tzQk10d2JFbXRHN0ZD?=
 =?utf-8?B?Ry9hMlVhVEVSM3Q1M0FuSEJqME9GaDZ2SEVzWFVPZlFRN1VsbFB0dm8rb1p2?=
 =?utf-8?B?RHVzejhVOEVGSE9DeGRHWUlpZHN5Y2RSd1BzK3JrbTlBMVJTb2FJdEcvUy85?=
 =?utf-8?B?QUtkbGM3RkRFcGpQREYvUk5ucVl5UXdKZWFOaW5FQmNScy9kdys4MmNHVkFE?=
 =?utf-8?B?ak96ZEd3VEhjRXhqc0FHYVFzNmZsSkd6UWhxRlU3bWF6SEU3WnJXVHNsTWNk?=
 =?utf-8?B?cHVsZU5WaHpSV1hIM21wN0p4TUt6OXZGVDgvVG1ncDVEalRLZ1VyTXVxQnpC?=
 =?utf-8?B?Zzkrbmd5WUh5M3ZObE5Lelk0ZldXVW1heVJ3enYxd2E3NHlqOTRSNkxONDZD?=
 =?utf-8?B?R3BJaHNiTFVOZGlLTmUrRGNZMHpqeWxpMGdWbi96MFkwZFRCVVg4MktQcUQv?=
 =?utf-8?B?bkphSG85MkRLeHV2ZUtuTWt3aldEUGhQYUFmckpPdU5WeHdLb0V4MVErVE4w?=
 =?utf-8?B?djVrb2U3YzBFOXRiRmhqUVVtU2dyYUFoaTRJQUtGeDc4MDJHVDlxVytwWEp3?=
 =?utf-8?B?RXhjaXJ2TTdqaHQyNVY2SkEvcFNzT3RCZ1dsTmJyaGpLRjU2VUFzUlJacGxL?=
 =?utf-8?B?Tk5BMjFHeUFIbC9GdHAwZmUxVTdaNVJJVEpyUGFZcy9WMUdmUEtrU0lvV283?=
 =?utf-8?B?ZDBsUG54VVNmeUVtQjVUQXFDRzF1NEtIRFkyejBla0duSERHVFBSRk5nZXEz?=
 =?utf-8?B?RWJxSGkyYU9mVm5nVStGNmFURWJHQWZMYkZnQUhYOWNBVmI3NnRQcHFjUHk1?=
 =?utf-8?B?NFNOdDF5SnpMSDZrK2psUlpxMzFzSE0rS2Fud2hIWVplN1BMbnQ5YTYyU25w?=
 =?utf-8?B?Yk13bVZKNzhrb1FrT1o0amNrRS80SDBGM09WM1JJZ1BjWXhRYXZKMGVkaEF6?=
 =?utf-8?B?QW42NzhRcnoyMmkzOHBwRHc1d3lzejluM2ZNVXJiMW94amxaSzlWQTJCdEc3?=
 =?utf-8?B?eDRNcStscXQ5S1JlMzRsZ1MvTCtaNVUxWEZDQ1IzTVZmQWtHVkRqL09ETnRW?=
 =?utf-8?B?bFpvZGpwMmRJeS9aYTF3MmxmSEV6VUxxekV4SDh1d0ZCZjBHeTZteC81RkUx?=
 =?utf-8?B?ZTVWNDhGZC9jaitnOWVDOG9aMDdqaWVTZFJIZE1NV3ExUWhicUJxNUhLdllh?=
 =?utf-8?B?cVRoTmFEcTJQV1o0SFI1aEVJSnlrSVVEcHM4Qis2c1V2SC85QVZCRWYvY1pR?=
 =?utf-8?B?MzJJejBXejBFMFlEOElNY1p6ekpuYTJsMlBzYkpUK3E1Nmd6SFh3R05tMnIw?=
 =?utf-8?B?MFJNUHdlbUxkVjlDY0RSeWxPTUViRHJQMlpKWXpIWklQbVQrNjZFaEMyU2NY?=
 =?utf-8?B?UWYwb3EwT3JvNkhTQjJaSkFORzhWeWhMMm9hYjNkRFZGZVJSaUlVdmtuRUZi?=
 =?utf-8?B?N0VFSWUwQVlLZUZBVWVlbElNRXFQMXF2dnFnNUxzRlVITzVSakVGaWFsRFd4?=
 =?utf-8?Q?nD8BEgbO6niNF4/jdgy44AJp9ucbTg6mVPNII=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1562.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007)(38070700009)(1580799018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RTFlVG5RQnhncER0RmZ5Nk1sSzVhekFrZ1pKWGJwWnhjeVZyWktrQkZMR3JK?=
 =?utf-8?B?Z25qSU9hZXV2YUFieW9qalVmeC91Z1FjRWxhbkNINDIzS0w5Ukl6MkpCZ3p2?=
 =?utf-8?B?cFozUklHSU1MSjRndnEySDBpK3U3N1pHS0ZpaDY2Wm9taGN4bjIvNllCUXFM?=
 =?utf-8?B?KzJweW93SFRrbmhRZU54MGJOQlZ6NG9xOEhuazBSZDNvb2UvRzNQOFNxUkpp?=
 =?utf-8?B?aE9xODlUbHo1RUxDMkc0dG1xeUVXQW5QbkpSZ3FTVnRhRTZ5VzZvSnFqYmxp?=
 =?utf-8?B?SlpOL0NWSFUzKzNsSVBOSHU3Qm9ZaCtmR0VnNjZubEpTUEdkNGxSdnhhQ0lm?=
 =?utf-8?B?eUN2b3ZFYVdyTTlGanNpKzNaT09vOXN0amFCWk41YnJlMjByb0hMSWg4UDFv?=
 =?utf-8?B?bE5DQmt2aDE2cHdqWmpZSjdXV0QxYmRuSWVUdjk3djJENGdGbGs4QzM0eDFI?=
 =?utf-8?B?dDdtbGpFajlHTFFJSS9QdEN1Tmw1anhIWG1Eekd2VmUyOVFySVAyYmp3bk9N?=
 =?utf-8?B?NUR4WlFTSFhZTkUwKy9DU3JJN09tL0tIWXdzVTAyL0VzcnovTVNpUlBwOC9z?=
 =?utf-8?B?R1dDYXdoWnRNOHRpc3l3QzQwMC9tTDhCTndBUzJPUUhyWFJoanZrY0hhMS8x?=
 =?utf-8?B?U2Y0K3kvaFp3Sjkramx2bUJEOGN4WkJhaWNGbTErdUhKZ0NMemFKbE9tY1Fs?=
 =?utf-8?B?ZG1RbW1wVEJObmlobHo0cFBOODRqTVllbm95TWs3SmkvQUZYRXNSN2ljaE9K?=
 =?utf-8?B?eUhuMnpxWS9Qem80SG5GdDhrZnY1a1dFODdjNDkxODYyeDFKUUNCYzJqL2hI?=
 =?utf-8?B?U3krdFNHQ21WcjVPWFg0WE5ZZTBGRU8yNUhBQmRHbDBBN1dBU3V0TyszVWZM?=
 =?utf-8?B?WXVhR0xVZGpjMUl3akJ0Sy84VGlacDd5aUdGZDVrOFUwcEdoVWxldGJTZlRk?=
 =?utf-8?B?K3pwNWhHOVdyb0swTGU3ZXovam5mdEM4VjFTSjgrb21kY3FaaWdKNTFuVHR3?=
 =?utf-8?B?cHFLUVZJa2xSTEJtMHU3aUcvMUYyVFhtd09YS2ppVFpHQUl3VGxlK3dScFNK?=
 =?utf-8?B?bU9JT0NVbUhtYmRIdFRRdWk4RlBlMFhZcmsyaDV3Zjl0ZUNHUk1KeXZHM3ZB?=
 =?utf-8?B?blV3eTlaZDNtdGZaeCswaHJORGtzdlQwUzQvdlZOcHpIN1BIVGprMDkvaXl4?=
 =?utf-8?B?enlZT1o1L1daUzlvTklBLzNEMDFBMUZmUEMreFZxVTIyWEE5b0ZXWi9YRmxD?=
 =?utf-8?B?VTEwbStNZ0xnMEZJK01nNjlNMmtHaHFCQzlEb2VzeUR6T3Jlc1o5S3oxRUIz?=
 =?utf-8?B?bktIUGEzUURyL0licTI5c25EY0w4YWczTEVGaTc4bnhHWndycUpaVExna1hw?=
 =?utf-8?B?QWhGczBMWkkydWJIb1ROOWcreG51TDVod1M4YWxNcTJLSEVyNTlZVnJxcEdF?=
 =?utf-8?B?M0hyY1h3bjhucHl3ZGFTQjh5cE5jVVNES2dja3BpMjFFVENaYmFuYlN0eFpM?=
 =?utf-8?B?anZxWFdua3hIQ3hTTElGcCtBaU1xMmFDU3AwRTc1a3ovbTdLcC8vL0hLb2ZR?=
 =?utf-8?B?Z1dZR2tmNHVOSVVoMFI5YVdaRlBXRzF6L0N2N3c1UzZvb00wWkZxR202SU11?=
 =?utf-8?B?cC9LRU5Da0dENW5yYmR0S3REbEQvMERHTXl5Y1A5N0IxS0V3NjU2aXVVR285?=
 =?utf-8?B?ZUFDWE5SR0MrTVB6ZXM0SHRoTzd5Vmc2M1ZYM1FSRER1UWpXVjJ1VWhhSnRS?=
 =?utf-8?B?cVlGQUJvZEdoOW1McEtGcDliN1FqbStkK0lGNVU1V1RwWEc4V202bTJtQ1dC?=
 =?utf-8?B?alBFNGcxZkNjaUdPVTJ1NUV0WjkzUkFuV21NNWNVcnExWkZCOUQvaHZLcHpi?=
 =?utf-8?B?UmZaNmRhZFhJM1pTdXpUZVJTV3cwaENMOWRyVi9obmZkcElWRkcwemNhNk5Q?=
 =?utf-8?B?aGpjd3FxMzVpTG0yaStLVlZPMnRaK0hhODl0M3hWYks2OWgvT3dydittRlNh?=
 =?utf-8?B?VUpwdUhHR0RqdGYrVll5eFJoN0ZTVGZqK2pxVjdyQmd3dzBsazQvRUlaNFFK?=
 =?utf-8?B?a2U4VlZRVXBGbk1qcE1yTkVORnY2cEFPTFQ5MzJDVzNhVEJ4NWRqYVFMR2hi?=
 =?utf-8?B?V2s0dHlWamd1WVlENVhWR2lhT3I3VFdhbjNnWitrSVVFeW9kSUg3dFdSUnpw?=
 =?utf-8?B?Y1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5F5D9B470BD6744EB87B548C1F4E9FEA@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	pf1w1wY7dfKifxMKS5ciEGgSefWiNwyiUIoRoe7BoTzfQdTBUnMyvAoccTT+gL2YaeJT55gCMgN9nj6onDnDA2Y3FgpbnL8WsquDlR6itWn6JmNCxfRhmsk3HhfpDn2pt0I8C6Fix+0HuL5w47XHlnMeX/858Fuiwb5HXM9L+lLAODtoZt2jHwayVuMi+oovueqYVs7QIFtwYqmVs/ZR1W0bGBM74zJd3BOzzOnm+S0AMEQKmzkuftLG/3az24NVxnZeRloeVGDtBXjYoYITCN9wz/7m6JtWZ6m4oZt2lslE7qKMUaNLa2H1XhbD7q/6DDRB0qpFuD42sNrpoFRG9GWwcg9BMXVjWTfbmOdq3kodjaihTs3DF/r1Kg4AoSxA1Q08fm9UhofHeVbdwFwcKuMBzUYKAXDLZHBWyXeB0tktVU8aeiTH++AlaXN3HYHtkNyBA/kabtC7iVhr244iR8aV+6kDYp/x1w5zuc8dAme7PTOKrxIOkPwYXZXsTbyvZe/eFLoRYCASFCPxCXN3rtjAqhMQlRzjDnaq7Ey+aZDK7EqMpTH8rjLlAQ+zw42GHPSk2Wsmib/NTohBtJKmM0g+ChYAf2+rz5y3Elg/83DXrXN5/Up99d7n6F0/LjnI
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1562.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a19f854-b05e-403c-6c42-08dc6836e01a
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2024 10:26:47.6903
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mYNPm8FfB4C/2XawHd0+UWnZFsrd8qu+M2VHfxIHyCmeXVUK1u1/dizqQesyZLDFOMENTMudlxJkO7DdGniJtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB10138

DQoNCk9uIDI5LzA0LzIwMjQgMTg6MTcsIERhbiBDYXJwZW50ZXIgd3JvdGU6DQo+IE9uIE1vbiwg
QXByIDI5LCAyMDI0IGF0IDA5OjMxOjU0QU0gKzA4MDAsIExpIFpoaWppYW4gd3JvdGU6DQo+Pj4g
ICAgICAgICAgbXV0ZXhfbG9jaygmY3hscmQtPnJhbmdlX2xvY2spOw0KPj4+ICAgICAgICAgIHJl
Z2lvbl9kZXYgPSBkZXZpY2VfZmluZF9jaGlsZCgmY3hscmQtPmN4bHNkLmN4bGQuZGV2LCBocGEs
DQo+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG1hdGNoX3JlZ2lv
bl9ieV9yYW5nZSk7DQo+Pj4gICAgICAgICAgaWYgKCFyZWdpb25fZGV2KQ0KPj4+ICAgICAgICAg
ICAgICAgICAgY3hsciA9IGNvbnN0cnVjdF9yZWdpb24oY3hscmQsIGN4bGVkKTsNCj4+PiAgICAg
ICAgICBlbHNlDQo+Pj4gICAgICAgICAgICAgICAgICBjeGxyID0gdG9fY3hsX3JlZ2lvbihyZWdp
b25fZGV2KTsNCj4+PiAgICAgICAgICBtdXRleF91bmxvY2soJmN4bHJkLT5yYW5nZV9sb2NrKTsN
Cj4+Pg0KPj4+ICAgICAgICAgIHJjID0gUFRSX0VSUl9PUl9aRVJPKGN4bHIpOw0KPj4+ICAgICAg
ICAgIGlmIChyYykNCj4+PiAgICAgICAgICAgICAgICAgIGdvdG8gb3V0Ow0KPj4+DQo+Pj4gICAg
ICAgICAgaWYgKCFyZWdpb25fZGV2KQ0KPj4+ICAgICAgICAgICAgICAgICAgcmVnaW9uX2RldiA9
ICZjeGxyLT5kZXY7DQo+Pg0KPj4gV2hlbiB0b19jeGxfcmVnaW9uKHJlZ2lvbl9kZXYpIGZhaWxz
LA0KPiAgICBeXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eDQo+IHRvX2N4bF9y
ZWdpb24oKSB3aWxsIHJldHVybiBOVUxMIGlmICJyZWdpb25fZGV2IiBpcyBub3QgYSByZWdpb24g
ZGV2aWNlLg0KPiANCj4gICAgMjIxNSAgc3RhdGljIHN0cnVjdCBjeGxfcmVnaW9uICp0b19jeGxf
cmVnaW9uKHN0cnVjdCBkZXZpY2UgKmRldikNCj4gICAgMjIxNiAgew0KPiAgICAyMjE3ICAgICAg
ICAgIGlmIChkZXZfV0FSTl9PTkNFKGRldiwgZGV2LT50eXBlICE9ICZjeGxfcmVnaW9uX3R5cGUs
DQo+ICAgIDIyMTggICAgICAgICAgICAgICAgICAgICAgICAgICAgIm5vdCBhIGN4bF9yZWdpb24g
ZGV2aWNlXG4iKSkNCj4gICAgMjIxOSAgICAgICAgICAgICAgICAgIHJldHVybiBOVUxMOw0KPiAg
ICAyMjIwDQo+ICAgIDIyMjEgICAgICAgICAgcmV0dXJuIGNvbnRhaW5lcl9vZihkZXYsIHN0cnVj
dCBjeGxfcmVnaW9uLCBkZXYpOw0KPiAgICAyMjIyICB9DQo+IA0KPiBJdCB3b24ndCBmYWlsLg0K
PiANCj4gSWYgaXQgZG9lcyBmYWlsLCB3ZSdyZSBhbHJlYWR5IGluIGJhZCBzaGFwZSBhbmQgaXQn
cyBub3Qgd29ydGggd29ycnlpbmcNCj4gYWJvdXQgcmVzb3VyY2UgbGVha3MgYXQgdGhhdCBwb2lu
dC4NCj4gDQoNClNvdW5kcyBnb29kIHRvIG1lLA0KDQpUaGFua3MNClpoaWppYW4NCg0KDQo+IHJl
Z2FyZHMsDQo+IGRhbiBjYXJwZW50ZXINCj4gDQo+IA==

