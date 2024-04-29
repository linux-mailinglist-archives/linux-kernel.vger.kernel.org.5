Return-Path: <linux-kernel+bounces-161776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 125B48B510A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 08:10:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 362F81C213E6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 06:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CF4110A25;
	Mon, 29 Apr 2024 06:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="so6k2i8D";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="tg28+HLX"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9BB8D28D;
	Mon, 29 Apr 2024 06:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.153.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714370984; cv=fail; b=sv4h8RJmAOMOwYwiueMgEZgSE//NRCuTmoNXDufkCpW+xHWMdnl2KvO/bZVP8rcXNrnIybEiiZkEzvRasP857me0elCUpkjmGkoOa9H3Zl7XUxT6DxnX8jNsxvozvJP9bSr/kXjK8MBwyF/2gKA1eJYYEQ4EyKRRp7PobvoHb0Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714370984; c=relaxed/simple;
	bh=nMSof6AiZLNolL2xNhHFbv6ryFnU7RoGPmYW4uT9I84=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=R3LkXVwB4HOVpHpqCXyUngq2B9XZgzEVwJk4Dl/bZIlLhNFwGAzRHa9kOjAS2TPnMsW9Fj11FTN/1lY7ZED4Ai95Yf1cumKBIWDMr4CY8FLZBFyIBjhftl+GB5qOkuCELTFpm+l5/YNfzb1LgwShuqB8DkRj3JUPhqq5Lf0sTEo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=so6k2i8D; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=tg28+HLX; arc=fail smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1714370981; x=1745906981;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=nMSof6AiZLNolL2xNhHFbv6ryFnU7RoGPmYW4uT9I84=;
  b=so6k2i8D+ZM9GQt4gGp1QXeAYvv6EF+sQyflaRU0FiYLWygYvS8O8O6l
   mY+Bu5I7jM782vTO9tcAscoGvhadFjiL6lE4DcIOu8KpFzJoFoXSz3wm5
   R2ayhA58+GI+c3cD6M+MKNFid3F68qtsP05QW4+ezMpVb4IJ3LwfuIFex
   K6ydewLOIyhYbK5ASHLUT5tPM87o++MnVlr38w+dhZAkqhXcMErpvqj/j
   kXWPSaG8yETs8s5ApgK/Kkvox/9XNQmjHeONDUIHm1WaLEfQbioazMR5V
   DWeM4bB/QxVO/KywOsjoSZbmTkKqBiWiYoqrfD+cfqHJBPDPwiaNiUICX
   A==;
X-CSE-ConnectionGUID: amgevUU+Q1mDt6uA6xxbUg==
X-CSE-MsgGUID: z7GeMNrrRp+s0oKqpav3Iw==
X-IronPort-AV: E=Sophos;i="6.07,238,1708412400"; 
   d="scan'208";a="25269607"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Apr 2024 23:09:40 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 28 Apr 2024 23:09:16 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 28 Apr 2024 23:09:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l2r2R17vW6KXtoiX3+t/xOSdTDdtYjBhu45vnspI2fvHrwMsO3myRcQRJ4SW7LqgzMO7pPv8ylZLV1Np5XrhmIbwLg27wVUBXWxYr4sJ22WFnTSd9bJV7UBakJ4vI3/NplcvmNauec65SM2BIvWmEWaQKI0+QPJJ7DLYRVa4dCWY3YZLxWEAX3FKEB57jz2b6YTpH6ZMp4Kz0oOC04WP6RkKwnGvN9w4semQWE+2DnqcwRLiI+9Ph8M81ONqVWDCt/yh6UhKl0GDqz9FPq3CERC7FSu2axg5edls2p5pL68C6UqDrDXTQ9I+2xVbzHySQkynAkerqHb6D/SptADM2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nMSof6AiZLNolL2xNhHFbv6ryFnU7RoGPmYW4uT9I84=;
 b=c3kfPm4ZSxzRmRGc3Jl36n2pT6mbkylxyD0YohzkSDrYCxURn75M/yIiNZOpxvnUTRa/VXw2nokoJfwBAV6ufMN6vo1jy0y0bhq94mgxhPnEbXSe8FdO+yobCjw2gihi3U0B6I8SHK97ybe4FD82dlnkcNINrvwJ2qwz/UfPcNB2KpL/yrqtB/M6cEjr36AKSPpjHol4DFo1+XzCmiPCczcmHbAF71gtgu4XiWq91Wh4GJCZNqJph7ZYirb4Yp5tlgs60UGbV94VoOQ/qKrHh6zr8Gj5vIgzLfJ7G99OFAY0scRRDQRGInSaDHwOuib0ZJ+W0IY2G4Bx+8EdfszKpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nMSof6AiZLNolL2xNhHFbv6ryFnU7RoGPmYW4uT9I84=;
 b=tg28+HLXpe0WF4cY22FFp6kLi1Y2JvQ4zO9ePGFQrVI2BkwemsXqO5/m28dHQDGRZ1Rfcxw+TM1q0yuFLeKhTjanwgjPxGYjUv3W0Ayn+v5lHzT19EuKhdxlkzgHdxJODKb82dHYysiTdksw961aPv6fERDqAAn006CKWdKXR5FcEasI3Kd9RiYpqwxKaPAKrN8lxaqECoBX2SLMXr9TDqC9xle+DLo9hHa/Jw1ddeor3838Wx7GUpT0imH+SfOWl8R/DfzLayXmGVIWq8ZDHEWUVv6ccN7SmrfnjtRal/HIN5eNeF/c4mTzMCZiL71iD6vaTtsj1t5a3NF8ZEl52w==
Received: from SA1PR11MB8278.namprd11.prod.outlook.com (2603:10b6:806:25b::19)
 by PH0PR11MB5901.namprd11.prod.outlook.com (2603:10b6:510:143::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 06:09:10 +0000
Received: from SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9]) by SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9%4]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 06:09:10 +0000
From: <Parthiban.Veerasooran@microchip.com>
To: <ramon.nordin.rodriguez@ferroamp.se>, <andrew@lunn.ch>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <saeedm@nvidia.com>,
	<anthony.l.nguyen@intel.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <andrew@lunn.ch>, <corbet@lwn.net>,
	<linux-doc@vger.kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<devicetree@vger.kernel.org>, <Horatiu.Vultur@microchip.com>,
	<ruanjinjie@huawei.com>, <Steen.Hegelund@microchip.com>,
	<vladimir.oltean@nxp.com>, <UNGLinuxDriver@microchip.com>,
	<Thorsten.Kummermehr@microchip.com>, <Pier.Beruto@onsemi.com>,
	<Selvamani.Rajagopal@onsemi.com>, <Nicolas.Ferre@microchip.com>,
	<benjamin.bigler@bernformulastudent.ch>
Subject: Re: [PATCH net-next v4 13/12] net: lan865x: optional hardware reset
Thread-Topic: [PATCH net-next v4 13/12] net: lan865x: optional hardware reset
Thread-Index: AQHambFe+IoUXQDhSE2fgqcXND6Bv7F+xDiA
Date: Mon, 29 Apr 2024 06:09:09 +0000
Message-ID: <dd9da345-e056-4f34-8e39-6901bf9c1636@microchip.com>
References: <20240418125648.372526-1-Parthiban.Veerasooran@microchip.com>
 <Zi68sDje4wfgftyZ@builder>
In-Reply-To: <Zi68sDje4wfgftyZ@builder>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8278:EE_|PH0PR11MB5901:EE_
x-ms-office365-filtering-correlation-id: 1bf50017-468d-4a6c-1e6f-08dc6812e290
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|366007|1800799015|7416005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?UnlHUFRPNkhWcmhNZGczM1dpRFJKM0tnL1JRZVJvTXZ0WkpNMGptc0t0enBt?=
 =?utf-8?B?eEpZd3RtM21BMngyS1lCeDl0MFRvK1JUY0xsNFVDaXVhMkJJMEtBSnFDekhn?=
 =?utf-8?B?UFRSWFJkNFgvRWFNVXpydzJkTmMwVXNwUmdPaWVGcFlMUWpYV2ZiZ2ljbS9x?=
 =?utf-8?B?b1dJOGlPbGlRTkFVNSt0aW1Jb2EzT04wdjhXY3pPRUtUWXZoZFUzWElFdGlt?=
 =?utf-8?B?L3p0OHBXb1FrclpnMVZaSXJSOHRHWjdsQ3VhbEVqSklacUttbm8rSzdMVlZz?=
 =?utf-8?B?cmMwZW1JY0tROFVZdEh2Q2QzMWhWVU12MzJFWkVKOHM3emw1b3N6Y1FjRWlp?=
 =?utf-8?B?Q1RyaFNubFM4S0dPUElBUlZNQzVRcTUxcThTS3g0Y2k2L2ZjWjZjalpDbE1n?=
 =?utf-8?B?a0tkQnF1RklaNjFoVkhzaHhtakVKamF3OGxlejdQVUtJNE1HektJc2JKSXFh?=
 =?utf-8?B?K3VFakpaUnVyYU4yMStmMC84d0UvVDE5L1o4cG9yWnRZWnRRdTMvNUp4Qzlx?=
 =?utf-8?B?V2VzMGVtQzRZdnFxdlJ3Vm5MNUtubjBSWkI3M2doNE1lTnRkNHJlMjdBNkhn?=
 =?utf-8?B?WEdQYWdNZWJTc3NocVVCQ2xFT2NGR3lpRlA1Z3B0aVd4aTVGZG42QXJzcXFG?=
 =?utf-8?B?dUVHcENLTTdSSWJ3RStaMVJqb3pxVWZqRzNLYWJRc0daUTVSejVPWDZ4eFht?=
 =?utf-8?B?MzdMbDFjLzg4RFF1ME9La05ETEtGZzJlQmJvOWNvaUY3QlYxSEYzRytEbHlT?=
 =?utf-8?B?ekVpUEppUG5CUE01MUVONktmczRaUUE2UVRVWmRWMzRUSFRzdHc5R3czZ0Ey?=
 =?utf-8?B?MmNmOCsybkxOU0NFUTl2ck1QS1daa1lETC9EOW5FaEl0VGF0MERjam01blR4?=
 =?utf-8?B?ZFk5SFpMMGdOYnVMeit2NDEyK01lcTY4UENqS0lOdHByNXE2MmprUDg0UnNZ?=
 =?utf-8?B?QXFQSGNVT2VQQ0I2Wkg2bkd5REtkU2RBVWJmY3IyVFJCaDZ4L1hMZUtHY1ZK?=
 =?utf-8?B?V0JTd0FRQy8raWpNemFuUzlBY1VQeTdXRngrRnVka0dKVGhxQjlOY09nN005?=
 =?utf-8?B?RTQ4MzJWRGtMUFJJaTlmcERFREEwQWdrb1FuNXkwTWk0bGt2NldxSkVqS2w2?=
 =?utf-8?B?RnBTTkgvQVMwdmIxdnlHOTFjOWRaUEZOOXd5cU53Rzlxc3lSVkR3TnhMMzFG?=
 =?utf-8?B?OFBXL1NPOU9rd1RPYWptcVY2M3NVZFdjbTAwSDVzR1p1R0trc1JkWGxvekhm?=
 =?utf-8?B?ZU4ydDBWck5qbDEvNVhVUm1TVVdKdW1wV3BiMk4vaXpqNm1rSTVjaFJqY3lj?=
 =?utf-8?B?dmk3Z0Z3ckJUOFpXQndxV2N2Y0RoeFZzekhuK0VNZDhPV3lBRkx0azR6NnNa?=
 =?utf-8?B?VnlsTlgvNVdHQTU0TldqRU52aTBHeUcrRFBPRnlQVkFlUUJYS084OVRTOHFj?=
 =?utf-8?B?cXBwMHRvMnVkL2xQY3dnVW9Ed0VwdzF2UE9DWkpxYmREY3BIN0pWT3d1UXFl?=
 =?utf-8?B?RTNUNzQ0QkJwTDBxeVcrSHVTeGlHUFFpVjRPK2l2RW9YeVhRdlhaY2tmdDND?=
 =?utf-8?B?K2FPVGMxL2hvMnlTVThIOGk4MHdUTXcvb21MZTRDbWZrd05MODdTUVdQUjds?=
 =?utf-8?B?aE9CSEF1c05YQUdETzc4QTRhMHVUOEhheTZydm9TL2lkU1Fuc2pHT1hDUWlE?=
 =?utf-8?B?QkpBUnRQaVFtZmJOVzBIQUl4aUJLQ251MHVvR0NkT0F2SWw2a3AvRzMzV3lR?=
 =?utf-8?B?bi92RkE2Qkg0L2kraHZOdFpkdXpsaVY5RHF2MVJaeFdWaGlPN3dCblBhNjV6?=
 =?utf-8?B?WGdwUy96SGY4SDZpMVczQT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8278.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(7416005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eS9oS2dBY1BpQURZVVZ2MG45TVFnRUNCc1dHT0NnQmFMRmZNUlBKbFJRVG54?=
 =?utf-8?B?NzJFQjF4Zm5Idy9CZnJjZGFVcU5YQXZ1aVJ5d1UvZFg5Q0VSN0ZmZEpiNjRX?=
 =?utf-8?B?eTNmQnFtUTJJU1pKbE1PNHpybUNMWXNlWXhXWDdOdzRWMXNUM3ROeHAySU1l?=
 =?utf-8?B?NG9sNENHRmtwTkZVTTBhMlZHL21QYTZjYTY1UFNURCt1SW95TndqdW9haWx6?=
 =?utf-8?B?UDQrd1hralp0L3ljQnlBcFIrb002Qi9JeTBUNVZwQk9SYU9sK08weVBOTUdI?=
 =?utf-8?B?SXhqV0h3NmhYZlNsQ0wyK0dlQnZTeTVXU2dZSXBQZ0xPZWE0Z1FMVy9ORTF6?=
 =?utf-8?B?Zk5BY0NwbnNkVHJhYUV0cU5RUDZJbnBHQ0JqWHNPUHpPQ1pnU2JaNVZFZFgx?=
 =?utf-8?B?YjBnS3FqSktMdTE4V2VaUWhFeElDM1Z2aUpVU3puVEw0WUExbFNDZkpSRFNQ?=
 =?utf-8?B?dGdDZm1vZDM5MmNtOXdzTSsyS1hGOGZxekhkRnNFNHVlZVB5emMwUDNGNkxP?=
 =?utf-8?B?ank1YTZ4bFdHSDhvVTIydU1IRjdIS1dpak41cVQwdEZ1d2c2VmpjZmdsV2Ur?=
 =?utf-8?B?Tnd2akZuUDNiSHREOGNhcGFEVW5XL0NUZVV5SWtiZTdHOW9icXNFWnZOMXpB?=
 =?utf-8?B?Qm5zbXI2Q3lkZnU3TzliN0hCV2ZiQXBTR2RPMXEyY3JzZGI2TXg3UDZOR1lL?=
 =?utf-8?B?a1E4OTIxMFgzTno5Wk5BSURPYXl6NWVUajdsQzUyd1g3MmtabHVIaHFhc1Nq?=
 =?utf-8?B?eE1DcDh2SUNkVzBLL25tbi9tT0t3WmlGZzcwK04xeTlzemZYUkhDMlNISGp6?=
 =?utf-8?B?MFZISGE4dGc1Y09RaWdYWFFXSVR6Z0hTb0p5U1loWXkvZEJyUk1KNmNDc2pC?=
 =?utf-8?B?aXAzaVdkWWtkemVHczNwZzhRTUZWOTdHdm1QMm9SM2ZGY1hhU242R1VYRlVx?=
 =?utf-8?B?UzhpY0JJdi9ibForTjJ3dWxsYWpzTE40QVJmaHNlamNQTHEvZXN3YXNOalFJ?=
 =?utf-8?B?eVZkdHBUVFpKZzlBckNsamowZWhRYlhoam8wUllQc2xrcmlXczZBL1V2VzNX?=
 =?utf-8?B?MFBzalpCYkJsYzNLb1d4cDZNNUpFVFQxZmU1cmtvZ0lsYVdiOVZFRmtxckV1?=
 =?utf-8?B?Y3Zlc05RU2Nod2x4MWtEekJQOTNsd25IYWEzK3NzZXRqL3hjOFpCNmltaC9O?=
 =?utf-8?B?MXpMVjMrYW1XZlVZOXFoVUlFck50cGc2WS9WNVNRbmlkTDgzTXJ5QzZsclE5?=
 =?utf-8?B?dUJxS2t0YWkyUTRlVHQzN2JlMVNDWFBXRFhLdFQwY0FDRU9KaE5nRUI2aWJX?=
 =?utf-8?B?Y3NyZjRXNW43bm1Dc0QyWVVaTjJheVdNMTJlOFU2cThGZzAwVTNzMVdQM2hz?=
 =?utf-8?B?MFJvcTBvVEZyWDdvUWlmZzM5ckRNdjJOSG4xVmFGTVUrV2RiemowWHpsUHJQ?=
 =?utf-8?B?Tms2YmhMcE1MNnZkMFFoOE1TQnJ1emY0U0JTNkpMelVWcGx4UTBuME1FcEpK?=
 =?utf-8?B?eG5GVFNTaVBhQU1vVXp2djdiUExoSm1rMmU1SjRGcVNyOGcvSEhCejg5SGhj?=
 =?utf-8?B?Z21xTmlwaEdhL09LcDFNdHlTREZ1RXcwUTZnTHM4MldvOFVpM2F2M3JySnlI?=
 =?utf-8?B?NlYwR1YyWlZjTWNEYTJmS0lkMVF3Qlo2azlkMDBzTW5lMUFWaDFVMDlZaXhS?=
 =?utf-8?B?aUQybldsZXVkemNRNlJ0OHBwM09UWGdVQk9UMmVSM1BGeHg1dUVNWUJuZ3hR?=
 =?utf-8?B?YURHeDNWZEZpV3RwYnM3MDBIMVA0eDVleDJSNEQrbkZrRGM1NXNPd3YzcjQ1?=
 =?utf-8?B?cjl6VURiakx3REUveVpPYXhNUmZEMXlsdm9UdGhiMFJoUkUrRXdGVmliUG0z?=
 =?utf-8?B?a05xYjlmSG9uUDdnZUNPaUE2VTlrNjRrL0hwUUNPZDhZaEgvOVlVS2doclJm?=
 =?utf-8?B?a3MvWW1LRGp4WFhiTlhDajlKSTBGa2tYaFBtcEhGTFkrcXJrZ2krTFc0V2lS?=
 =?utf-8?B?eVF3M1VkNUZuUm50aWJhK1A0Wk56NHlINjVnRWJzL3ZlTU5xa3FxTG9MMGVO?=
 =?utf-8?B?OEk0VmhGdmFJNFFIYk8wRXlHcy9KdWRFQzJiZGExSHBicHViOXFwYzFwSUcw?=
 =?utf-8?B?TytVeG85bm92Um9YM1g2b1VQZGdEQlVnTnVJMmxUWTBwQ2pVTzJOc01ORWJE?=
 =?utf-8?B?a3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F5C46D1F43781946BADB2FA57D840868@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bf50017-468d-4a6c-1e6f-08dc6812e290
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2024 06:09:09.8967
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JJ6+ETwscRWinnZu2jLxAYxKl0C+fn66yAYfKwSjIWD9Ri1TSomDIkFEvfoB27S95NyasKzffk60/hG8F1HjUtjhue2xIPB9CcK6n8cFu8HHwUaxw1jmb9uEINy9O0ve
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5901

SGkgUmFtb24sDQoNCk9uIDI5LzA0LzI0IDI6NDYgYW0sIFJhbcOzbiBOb3JkaW4gUm9kcmlndWV6
IHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0
YWNobWVudHMgdW5sZXNzIHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+ICBGcm9t
IGM2NWU0Mjk4MjY4NGQ1ZmQ4YjIyOTRlYjZhY2Y3NTVhYTBmY2FiODMgTW9uIFNlcCAxNyAwMDow
MDowMCAyMDAxDQo+IEZyb206ID0/VVRGLTg/cT9SYW09QzM9QjNuPTIwTm9yZGluPTIwUm9kcmln
dWV6Pz0NCj4gICA8cmFtb24ubm9yZGluLnJvZHJpZ3VlekBmZXJyb2FtcC5zZT4NCj4gRGF0ZTog
U3VuLCAyOCBBcHIgMjAyNCAyMjoyNToxMiArMDIwMA0KPiBTdWJqZWN0OiBbUEFUQ0ggbmV0LW5l
eHQgdjQgMTMvMTJdIG5ldDogbGFuODY1eDogb3B0aW9uYWwgaGFyZHdhcmUgcmVzZXQNCj4gTUlN
RS1WZXJzaW9uOiAxLjANCj4gQ29udGVudC1UeXBlOiB0ZXh0L3BsYWluOyBjaGFyc2V0PVVURi04
DQo+IENvbnRlbnQtVHJhbnNmZXItRW5jb2Rpbmc6IDhiaXQNCj4gDQo+IFRoaXMgY29tbWl0IG9w
dGlvbmFsbHkgZW5hYmxlcyBhIGhhcmR3YXJlIHJlc2V0IG9mIHRoZSBsYW44NjUwLzENCj4gbWFj
LXBoeS4gVGhlc2UgY2hpcHMgaGF2ZSBhIHNvZnR3YXJlIHJlc2V0IHRoYXQgaXMgZGlzY291cmFn
ZSBmcm9tIHVzZQ0KPiBpbiB0aGUgbWFudWFsIHNpbmNlIGl0IG9ubHkgcmVzZXRzIHRoZSBpbnRl
cm5hbCBwaHkuDQpUaGUgc29mdHdhcmUgcmVzZXQgZG9uZSBieSB0aGUgY3VycmVudCBkcml2ZXIg
aXMgbm90IG9ubHkgcmVzZXR0aW5nIHRoZSANCmludGVybmFsIFBIWSwgaXQgcmVzZXRzIHRoZSBl
bnRpcmUgTUFDLVBIWSBpbmNsdWRpbmcgdGhlIGludGVncmF0ZWQgUEhZLg0KVGhlIHJlc2V0IGJp
dCBvZiB0aGUgQ2xhdXNlIDIyIGJhc2ljIGNvbnRyb2wgcmVnaXN0ZXIgb25seSB3aWxsIHJlc2V0
IA0KdGhlIGludGVybmFsIFBIWSBhbG9uZS4gQnV0IG9hX3RjNl9zd19yZXNldF9tYWNwaHkoKSBm
dW5jdGlvbiBpcyB3cml0aW5nIA0Kc29mdHdhcmUgcmVzZXQgYml0IGluIHRoZSBSZXNldCBDb250
cm9sIGFuZCBTdGF0dXMgcmVnaXN0ZXIgd2hpY2ggcmVzZXRzIA0KdGhlIGVudGlyZSBNQUMtUEhZ
IGluY2x1ZGluZyB0aGUgaW50ZXJuYWwgUEhZLg0KDQpPUEVOIEFsbGlhbmNlIHNwZWMgc2F5cyB0
aGUgZm9sbG93aW5nIHdoaWNoIGlzIGRvbmUgaW4gdGhlIA0Kb2FfdGM2X3N3X3Jlc2V0X21hY3Bo
eSgpLg0KDQo5LjIuNA0KUmVzZXQgQ29udHJvbCBhbmQgU3RhdHVzIFJlZ2lzdGVyICgweDAwMDMp
DQo5LjIuNC4xIFJTVkQNClJlc2VydmVkIGZvciBmdXR1cmUgdXNlLiBXcml0aW5nIHRvIHRoZXNl
IGJpdHMgc2hhbGwgaGF2ZSBubyBlZmZlY3Qgb24gDQp0aGUgTUFDLVBIWS4NCjkuMi40LjIgU1dS
RVNFVA0KTUFDLVBIWSBTb2Z0d2FyZSBSZXNldC4gVGhlIGFjdGlvbiBvZiB3cml0aW5nIGEg4oCY
MeKAmSB0byB0aGlzIGJpdCBzaGFsbCANCmZ1bGx5IHJlc2V0IHRoZSBNQUMtUEhZLCBpbmNsdWRp
bmcgdGhlIGludGVncmF0ZWQgUEhZLCB0byBhbiBpbml0aWFsIA0Kc3RhdGUgaW5jbHVkaW5nIGJ1
dCBub3QgbGltaXRlZCB0byByZXNldHRpbmcgYWxsIHN0YXRlIG1hY2hpbmVzIGFuZCANCnJlZ2lz
dGVycyB0byB0aGVpciBkZWZhdWx0IHZhbHVlLiBXaGVuIHRoaXMgYml0IGlzIHNldCwgdGhlIHJl
c2V0IHNoYWxsIA0Kbm90IG9jY3VyIHVudGlsIENTbiBpcyBkZWFzc2VydGVkIHRvIGFsbG93IGZv
ciB0aGUgY29udHJvbCBjb21tYW5kIHdyaXRlIA0KdG8gY29tcGxldGUuIFRoaXMgYml0IGlzIHNl
bGYtY2xlYXJpbmcuDQoNCkxBTjg2NTAgc3BlYyBzYXlzIHRoZSBmb2xsb3dpbmcsDQoNCjQuMS4x
LjMgU29mdHdhcmUgUmVzZXQNCkEgc29mdHdhcmUgcmVzZXQgb2YgdGhlIExBTjg2NTAvMSBpcyBh
dmFpbGFibGUgdmlhIHRoZSBTb2Z0IFJlc2V0IA0KKFNXX1JFU0VUKSBiaXQgaW4gdGhlIHN0YW5k
YXJkIE9BX0NPTkZJRzAgcmVnaXN0ZXIuDQoNCk5vdGU6IFRoZSBTV19SRVNFVCBiaXQgb2YgdGhl
IENsYXVzZSAyMiBCYXNpYyBDb250cm9sIHJlZ2lzdGVyIHdpbGwgDQpyZXNldCBvbmx5IHRoZSBp
bnRlcm5hbCBQSFksIG5vdCB0aGUgZW50aXJlIGRldmljZS4gVGhpcyBQSFkgb25seSByZXNldCAN
CmlzIG5vdCByZWNvbW1lbmRlZCBmb3IgdXNlLiBJZiBzdWNoIGEgcmVzZXQgaXMgZGV0ZWN0ZWQs
IGJ5IHJlYWRpbmcgdGhlIA0KUkVTRVRDIGJpdCBvZiB0aGUgU1RTMiByZWdpc3RlciwgcmVzZXQg
dGhlIGVudGlyZSBkZXZpY2UuDQoNClRoZSBhYm92ZSBub3RlIGlzIGdpdmVuIGluIHRoZSBsYW44
NjUwIGRhdGFzaGVldCB0byBsZXQgdGhlIHVzZXIgdG8ga25vdyANCnRoYXQgY2xhdXNlIDIyIHNv
ZnR3YXJlIHJlc2V0IHdpbGwgcmVzZXQgb25seSBpbnRlcm5hbCBQSFkgYnV0IEkgZG9uJ3QgDQp0
aGluayB0aGV5IG1lYW4gaXQgZm9yIHRoZSBNQUMtUEhZIHNvZnR3YXJlIHJlc2V0IGRvbmUgZnJv
bSBSZXNldCANCkNvbnRyb2wgYW5kIFN0YXR1cyByZWdpc3Rlci4NCg0KU28gaW4gbXkgb3Bpbmlv
biwgSSBkb24ndCBzZWUgdGhlIG5lZWQgb2YgZXh0ZXJuYWwgcGluIHJlc2V0IGFzIHRoZSANCmV4
aXN0aW5nIG9hX3RjNl9zd19yZXNldF9tYWNwaHkoKSBmdW5jdGlvbiBkb2VzIHRoZSBzb2Z0d2Fy
ZSByZXNldCBvZiANCnRoZSBlbnRpcmUgTUFDLVBIWS4NCg0KU3RpbGwgaWYgeW91IHNlZSBhIG5l
ZWQgdG8gaGF2ZSB0aGlzIGV4dGVybmFsIHBpbiByZXNldCBhcyBhbiBvcHRpb25hbCANCmZ1bmN0
aW9uIHRoZW4gaXQgbWF5IGJlIG5lZWRlZCBmb3IgYWxsIHRoZSB2ZW5kb3Igc3BlY2lmaWMgTUFD
IGRyaXZlcnMuIA0KSW4gdGhhdCBjYXNlLCByZXNldC1ncGlvcyBwYXJhbWV0ZXIgdmFsdWUgYWxv
bmUgY2FuIGJlIHRha2VuIGZyb20gdGhlIA0KY2hpcCBzcGVjaWZpYyBkZXZpY2UgdHJlZSBhbmQg
dGhlIHJlbWFpbmluZyBjb2RlIGZvciBvcGVyYXRpbmcgdGhlIHJlc2V0IA0KZ3BpbyBjYW4gYmUg
bW92ZWQgdG8gb2FfdGM2LmMgYW5kIHRoZSBmdW5jdGlvbiBuYW1lIGNhbiBiZSANCm9hX3RjNl9o
d19yZXNldF9tYWNwaHkoKS4NCg0KQmVzdCByZWdhcmRzLA0KUGFydGhpYmFuIFYNCj4gDQo+IFNp
Z25lZC1vZmYtYnk6IFJhbcOzbiBOb3JkaW4gUm9kcmlndWV6IDxyYW1vbi5ub3JkaW4ucm9kcmln
dWV6QGZlcnJvYW1wLnNlPg0KPiAtLS0NCj4gICAuLi4vYmluZGluZ3MvbmV0L21pY3JvY2hpcCxs
YW44NjV4LnlhbWwgICAgICAgfCAgNCArKysNCj4gICAuLi4vbmV0L2V0aGVybmV0L21pY3JvY2hp
cC9sYW44NjV4L2xhbjg2NXguYyAgfCAyOCArKysrKysrKysrKysrKysrKysrDQo+ICAgMiBmaWxl
cyBjaGFuZ2VkLCAzMiBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL25ldC9taWNyb2NoaXAsbGFuODY1eC55YW1sIGIvRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL25ldC9taWNyb2NoaXAsbGFuODY1eC55YW1s
DQo+IGluZGV4IDRmZGVjMGJhMzUzMi4uMGYxMWY0MzFkZjA2IDEwMDY0NA0KPiAtLS0gYS9Eb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbmV0L21pY3JvY2hpcCxsYW44NjV4LnlhbWwN
Cj4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL25ldC9taWNyb2NoaXAs
bGFuODY1eC55YW1sDQo+IEBAIC00NCw2ICs0NCw5IEBAIHByb3BlcnRpZXM6DQo+ICAgICAgIG1p
bmltdW06IDE1MDAwMDAwDQo+ICAgICAgIG1heGltdW06IDI1MDAwMDAwDQo+IA0KPiArICByZXNl
dC1ncGlvczoNCj4gKyAgICBtYXhJdGVtczogMQ0KPiArDQo+ICAgICAiI2FkZHJlc3MtY2VsbHMi
Og0KPiAgICAgICBjb25zdDogMQ0KPiANCj4gQEAgLTc2LDUgKzc5LDYgQEAgZXhhbXBsZXM6DQo+
ICAgICAgICAgICBpbnRlcnJ1cHRzID0gPDYgSVJRX1RZUEVfRURHRV9GQUxMSU5HPjsNCj4gICAg
ICAgICAgIGxvY2FsLW1hYy1hZGRyZXNzID0gWzA0IDA1IDA2IDAxIDAyIDAzXTsNCj4gICAgICAg
ICAgIHNwaS1tYXgtZnJlcXVlbmN5ID0gPDE1MDAwMDAwPjsNCj4gKyAgICAgICAgcmVzZXQtZ3Bp
b3MgPSA8JmdwaW8yIDggR1BJT19BQ1RJVkVfSElHSD47DQo+ICAgICAgICAgfTsNCj4gICAgICAg
fTsNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L21pY3JvY2hpcC9sYW44NjV4
L2xhbjg2NXguYyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L21pY3JvY2hpcC9sYW44NjV4L2xhbjg2
NXguYw0KPiBpbmRleCA5YWJlZmE4YjlkOWYuLmJlZDkwMzM1NzRiMiAxMDA2NDQNCj4gLS0tIGEv
ZHJpdmVycy9uZXQvZXRoZXJuZXQvbWljcm9jaGlwL2xhbjg2NXgvbGFuODY1eC5jDQo+ICsrKyBi
L2RyaXZlcnMvbmV0L2V0aGVybmV0L21pY3JvY2hpcC9sYW44NjV4L2xhbjg2NXguYw0KPiBAQCAt
OSw2ICs5LDcgQEANCj4gICAjaW5jbHVkZSA8bGludXgva2VybmVsLmg+DQo+ICAgI2luY2x1ZGUg
PGxpbnV4L3BoeS5oPg0KPiAgICNpbmNsdWRlIDxsaW51eC9vYV90YzYuaD4NCj4gKyNpbmNsdWRl
IDxsaW51eC9ncGlvL2RyaXZlci5oPg0KPiANCj4gICAjZGVmaW5lIERSVl9OQU1FICAgICAgICAg
ICAgICAgICAgICAgICAibGFuODY1eCINCj4gDQo+IEBAIC0zMyw2ICszNCw3IEBADQo+IA0KPiAg
IHN0cnVjdCBsYW44NjV4X3ByaXYgew0KPiAgICAgICAgICBzdHJ1Y3Qgd29ya19zdHJ1Y3QgbXVs
dGljYXN0X3dvcms7DQo+ICsgICAgICAgc3RydWN0IGdwaW9fZGVzYyAqcmVzZXRfZ3BpbzsNCj4g
ICAgICAgICAgc3RydWN0IG5ldF9kZXZpY2UgKm5ldGRldjsNCj4gICAgICAgICAgc3RydWN0IHNw
aV9kZXZpY2UgKnNwaTsNCj4gICAgICAgICAgc3RydWN0IG9hX3RjNiAqdGM2Ow0KPiBAQCAtMjgz
LDYgKzI4NSwyNCBAQCBzdGF0aWMgaW50IGxhbjg2NXhfc2V0X3phcmZlKHN0cnVjdCBsYW44NjV4
X3ByaXYgKnByaXYpDQo+ICAgICAgICAgIHJldHVybiBvYV90YzZfd3JpdGVfcmVnaXN0ZXIocHJp
di0+dGM2LCBPQV9UQzZfUkVHX0NPTkZJRzAsIHJlZ3ZhbCk7DQo+ICAgfQ0KPiANCj4gK3N0YXRp
YyBpbnQgbGFuODY1eF9wcm9iZV9yZXNldF9ncGlvKHN0cnVjdCBsYW44NjV4X3ByaXYgKnByaXYp
DQo+ICt7DQo+ICsgICAgICAgcHJpdi0+cmVzZXRfZ3BpbyA9IGRldm1fZ3Bpb2RfZ2V0X29wdGlv
bmFsKCZwcml2LT5zcGktPmRldiwgInJlc2V0IiwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgR1BJT0RfT1VUX0hJR0gpOw0KPiArICAgICAgIGlm
IChJU19FUlIocHJpdi0+cmVzZXRfZ3BpbykpDQo+ICsgICAgICAgICAgICAgICByZXR1cm4gUFRS
X0VSUihwcml2LT5yZXNldF9ncGlvKTsNCj4gKw0KPiArICAgICAgIHJldHVybiAwOw0KPiArfQ0K
PiArDQo+ICtzdGF0aWMgdm9pZCBsYW44NjV4X2h3X3Jlc2V0KHN0cnVjdCBsYW44NjV4X3ByaXYg
KnByaXYpDQo+ICt7DQo+ICsgICAgICAgZ3Bpb2Rfc2V0X3ZhbHVlX2NhbnNsZWVwKHByaXYtPnJl
c2V0X2dwaW8sIDEpOw0KPiArICAgICAgIC8vIHNlY3Rpb24gOS42LjMgUkVTRVRfTiBUaW1pbmcg
c3BlY2lmaWVzIGEgbWluaW11bSBob2xkIG9mIDV1cw0KPiArICAgICAgIHVzbGVlcF9yYW5nZSg1
LCAxMCk7DQo+ICsgICAgICAgZ3Bpb2Rfc2V0X3ZhbHVlX2NhbnNsZWVwKHByaXYtPnJlc2V0X2dw
aW8sIDApOw0KPiArfQ0KPiArDQo+ICAgc3RhdGljIGludCBsYW44NjV4X3Byb2JlKHN0cnVjdCBz
cGlfZGV2aWNlICpzcGkpDQo+ICAgew0KPiAgICAgICAgICBzdHJ1Y3QgbmV0X2RldmljZSAqbmV0
ZGV2Ow0KPiBAQCAtMjk3LDYgKzMxNywxNCBAQCBzdGF0aWMgaW50IGxhbjg2NXhfcHJvYmUoc3Ry
dWN0IHNwaV9kZXZpY2UgKnNwaSkNCj4gICAgICAgICAgcHJpdi0+bmV0ZGV2ID0gbmV0ZGV2Ow0K
PiAgICAgICAgICBwcml2LT5zcGkgPSBzcGk7DQo+ICAgICAgICAgIHNwaV9zZXRfZHJ2ZGF0YShz
cGksIHByaXYpOw0KPiArICAgICAgIGlmIChsYW44NjV4X3Byb2JlX3Jlc2V0X2dwaW8ocHJpdikp
IHsNCj4gKyAgICAgICAgICAgICAgIGRldl9lcnIoJnNwaS0+ZGV2LCAiZmFpbGVkIHRvIHByb2Jl
IHJlc2V0IHBpbiIpOw0KPiArICAgICAgICAgICAgICAgcmV0ID0gLUVOT0RFVjsNCj4gKyAgICAg
ICAgICAgICAgIGdvdG8gZnJlZV9uZXRkZXY7DQo+ICsgICAgICAgfQ0KPiArDQo+ICsgICAgICAg
aWYgKHByaXYtPnJlc2V0X2dwaW8pDQo+ICsgICAgICAgICAgICAgICBsYW44NjV4X2h3X3Jlc2V0
KHByaXYpOw0KPiAgICAgICAgICBJTklUX1dPUksoJnByaXYtPm11bHRpY2FzdF93b3JrLCBsYW44
NjV4X211bHRpY2FzdF93b3JrX2hhbmRsZXIpOw0KPiANCj4gICAgICAgICAgcHJpdi0+dGM2ID0g
b2FfdGM2X2luaXQoc3BpLCBuZXRkZXYpOw0KPiAtLQ0KPiAyLjQzLjANCj4gDQo+IA0KDQo=

