Return-Path: <linux-kernel+bounces-103959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F5F87C70B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 02:17:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 465D31F21363
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 01:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4049F6FA9;
	Fri, 15 Mar 2024 01:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="bZSR3ctN"
Received: from esa9.fujitsucc.c3s2.iphmx.com (esa9.fujitsucc.c3s2.iphmx.com [68.232.159.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDC6139D;
	Fri, 15 Mar 2024 01:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.159.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710465447; cv=fail; b=q6kPV/1yszqAsdqhNQU0FBCjRSoVr2E3rUrlndjFpXb/5UDXrbi7g0S23EkAjBhGqRThnjnXZiRK4MyUq/CY9AWMqHabifDVsFV8eEdGtU6IqxxUpBSim8IKBNXX4aIXW74nHZobXtZS1urp3ZBpeJwWRH5Fki6o2HOjHfpAeK4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710465447; c=relaxed/simple;
	bh=DVxDsBflY6kZ69SFyzdl5ZAMx6899FxhXPUbMXpzdu8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Fv7lom7kqw6gkbAuZEkta42z68Pgwmc4qUn3k2Gb44N/sjL/+/QPWYRo803AhTS7OPuFVoti93ntP4HCC2hWnwT/5KXY2iiJJpDnPTkhqhlQUP63gju+NpMH7rUkiQZHfcAKIPmYViVRwIiGrRTjRNXlHf/3wte1LmgLcBrcgQY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=bZSR3ctN; arc=fail smtp.client-ip=68.232.159.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1710465446; x=1742001446;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=DVxDsBflY6kZ69SFyzdl5ZAMx6899FxhXPUbMXpzdu8=;
  b=bZSR3ctNtxlgsJi0vYo6h4XCU8/A1ssrhYE3ktnVXArbCVATOsdMOzpu
   EO7KLMFqmvnhNrNEKtxmBXeWGQI95FXmhxIWBue0vijQtVnHG1qQGTsQ3
   0EKOf60SCIBsCZ4EvLoM4VpvpBgNgmpjtwQ3o83VoK+3uyxw3Bv2MWTp7
   WwRCnkxOM9S2XMqLATWparZd1TE1b22lMA/q7nqZT/qlqlLzloTRRRHU5
   2xccdHK1qIOUH7Xidvu6NbNj6TNp4rDQO/0jn0AXNduZuubuxq91x+J2N
   94eeV61uzk+GSEytTEHVEB/nRf04raAXeyHhv06+/tgMABgSOofd+wCT2
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11013"; a="114208371"
X-IronPort-AV: E=Sophos;i="6.07,127,1708354800"; 
   d="scan'208";a="114208371"
Received: from mail-tycjpn01lp2168.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.168])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2024 10:16:12 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JB92qP4hUohurSZcrS0y9qFbxtSCjea0JcER6sjkzobaTeotg5iqlmDL/U0LwNUCwDkHSs71d7VW/aSTabqE+mgr3KeyzAC4K6Xo5TR99SVVV243jxCHQL7atYrmtOxlfRQQcn4nlmiHlBXLngveFqzoFqv35kjFXzWYFq7Wu1AZykmpVFTmgtC1Mqns9t3sWDeXKiI71dp+mxqu4BX/Biusgdkn3rrRsBIli1QOvZSRfzgm5hf1kcgtFfSTzfc4hXwBXvdo31yOmbLOowV2gc+c1VZ55msf3gOU6vaX+lckTnueHO9uXQeJdSDAvesN82qA37gYzwncIbiljO59sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DVxDsBflY6kZ69SFyzdl5ZAMx6899FxhXPUbMXpzdu8=;
 b=EFMf6qkgFfvZ9AkN1M0Ji/3jlS4LsX1Hmp9q1RfGEFK6YCk+8wDECI9rUqLcdLKSCCSxc+yA+UNqv3PRRHZh+f3G69NOB5/KEaO+IVxEWI5GnbBl0d/xGACGcFswBKOAZSyCt589FNl5WemPxZNAPAC7iwRBaDv9GDQolaPIC18VraQniY1eXj2Yb4oYDcB6P/LjPiaTKVhfv1PUgSDIp0tXSBlAl0iqLOjEPTK4fYIKgWObxju/cE3xW6kswYbrapjZVA+hFOqucnlkum7BEILCaHroAZUUxE3EGectl5PJLnlO3lgf3EwkZ4yLYg0YAdR43MzcNpCjyblnHx0qmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYAPR01MB5818.jpnprd01.prod.outlook.com
 (2603:1096:404:8059::10) by OS3PR01MB9739.jpnprd01.prod.outlook.com
 (2603:1096:604:1ed::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.18; Fri, 15 Mar
 2024 01:16:07 +0000
Received: from TYAPR01MB5818.jpnprd01.prod.outlook.com
 ([fe80::c52a:473a:a14f:7f0e]) by TYAPR01MB5818.jpnprd01.prod.outlook.com
 ([fe80::c52a:473a:a14f:7f0e%3]) with mapi id 15.20.7386.017; Fri, 15 Mar 2024
 01:16:07 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: =?utf-8?B?TWljaGFlbCBCw7xzY2g=?= <m@bues.ch>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Larry
 Finger <Larry.Finger@lwfinger.net>, Kalle Valo <kvalo@kernel.org>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"b43-dev@lists.infradead.org" <b43-dev@lists.infradead.org>
Subject: Re: [PATCH 2/3] net: b43: Convert sprintf/snprintf to sysfs_emit
Thread-Topic: [PATCH 2/3] net: b43: Convert sprintf/snprintf to sysfs_emit
Thread-Index: AQHadfTI2s7BUux6ekGPp1x+w9aTsLE3j/aAgABw1QA=
Date: Fri, 15 Mar 2024 01:16:07 +0000
Message-ID: <191ee62c-ab5e-498c-86d1-951771c9834f@fujitsu.com>
References: <20240314094823.1324898-1-lizhijian@fujitsu.com>
 <20240314094823.1324898-2-lizhijian@fujitsu.com>
 <20240314193215.74aac927@barney>
In-Reply-To: <20240314193215.74aac927@barney>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYAPR01MB5818:EE_|OS3PR01MB9739:EE_
x-ms-office365-filtering-correlation-id: 7cd895e6-4d50-4bae-d91a-08dc448d7e29
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 jZkJWhPZErGLqy+wDT0mD16z9mWqDOPx0rKIJ0ILs75/1BTrv/VD7NQad+Wn4aWb55ZAzhHEfIjEShuwVbXWxt3gXvnqKVX2d1BC+RVG9cttDO6/quT4y8hYT5DpffvK+Ztz59j1YHP38k3Civr1bdh7YYpmShmLWGqyqNB+McQNrUFMH77rgqkLmPk6kJZCnFO4mbuZq1kXW0jRJ4ojpvYFvhjwJkMo/64QeWOoPb/YFHoe+7y9x3R2NuZ/C2d1P8V9h7W6DwUkitntleRG+YLXaTIcqICNUVnVKgJscVcVC72dEObMJpB2d9KUNeBrBhZdcM61svcdsBXeABv05BPPFKZ52ISg3dOYn3e+L3vYmcNh7E62qsu6O8NF2qiGGgwmChv0krBBbLFmbo/c9/JOHlMfHJxcIAA+seVQX7oK+1lcG00t2o3HttxBWRzI9MTEJiuW7MMPH7/kQ6612rM/B7NKZmyT+ptMyYRns5+4zMXqWs0kzNtVXPsjSvS1anpos7ybHPaqcql6J/ruiTxsBgDr/Lt2nkNg/PLQIWaOX9bP1q/MiNJmGqkorKWnQuhJH6z/aBFaRJ4uRqw8rxEnxKoY7DtkFBEI8HPPItwX9eH5+7aP6hAfLVJ99ifROuA1+xZ4NedKMVg8u2GCNF2FtQiki03OMTqrm+tiHQIO5v16OPRfjQoCgyx5ummsIicAjC3DodcOfWjl+AkunzZBZ29rWIIgZDp0bti59lnsXUBEs8sS/FtbFMC/qIou
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB5818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(1580799018)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?anNsVWthUHpiUDdBRVZiM2J1Mk5VbkpLVUZJd2dTbnpWOVcxVTZlejlrYXFM?=
 =?utf-8?B?SWhFQ0xwaVJkT2xUbGJqY3VHSXZrWmlWaXpNc2R4WmdXNWF6NmNaeUtrblM3?=
 =?utf-8?B?OHk0NGVzVnhTZDZFODgxZGZTeEpLb01XY3Axd2hmWU9xRlFLMTBCbk9QUmM4?=
 =?utf-8?B?QndsN2ZvSFhCbktUaENuK0N4bDFrWlNaaUM3VmluUWJLRmVscGdLZUpqcGEv?=
 =?utf-8?B?dHAxMjdBQUp2aWFxR05SV2ZDMGVPaEpianZ5dUJ2YXRHbTkyRmY0ODJaKzRw?=
 =?utf-8?B?SVR0ankwaFVDMGhidUQ3WFdORm96NjIrNW1BOVFSVlJKQmQ3NnFUbnlpaEZj?=
 =?utf-8?B?SHJWQms2aWRuVk5qaU15Z0pGVFdRTDRnZU1ERXlBdC9oaW5NSXhVdTBzNWhD?=
 =?utf-8?B?UjdGTkx6VjVuMlhYNnZsQVlZbmtyNE9EaWZsQmZDRDVOc1ZGa0sxTmVTS3U3?=
 =?utf-8?B?a2UrUzdaT0JGNU9BVzluM0hPSUFRSWc2RkdXRjhnaUc5OXNOOVVCRzFjSkla?=
 =?utf-8?B?YnJwNTJ2U0dZZk1idStaay82ZEFjQjlmWFJWc0wwYnZFa2F2VWJ2UE5xdVVX?=
 =?utf-8?B?Q2p2OVhFWDVLNmwzcFJvekx3N0Y0ZlVlUThKWExIUEhPNXJKMS8yVWhvN29Z?=
 =?utf-8?B?NmorZHBNSURkbDRYN3RIZEl0UURBUHphOXBDNmdXZjkrQ1lHU21oZG5ybWhr?=
 =?utf-8?B?K1lMaE9uUUhVWjJIckR1bEcrQnpSakp3US9JNUpKeEg3aDcrcXBuL0tDaWpB?=
 =?utf-8?B?bHFYZlNEZzBFamFhUzF0Wm9NYUQ3Z1lJenM1ZzdVaEl4YWFKWGp2OUFRWm1k?=
 =?utf-8?B?MkZXeDdSWGl3UllscXN2NkdHRnZ6aDBqd1pNd0JCR0dTbWFEaDdPYTJ1RldF?=
 =?utf-8?B?aU1JTkVzQXZNc3Uybi9CcExvdTVuUXI0cW9jTXpFUzZvZ2RHSGVqUVRNVXNV?=
 =?utf-8?B?Nzk2R0R5SWhQWUFrbVE5cDYxYVliMGs3WVVDc3prSmxOanl6Ry9XZlNMTDlR?=
 =?utf-8?B?ZnJHY2VzZVorbXovdU9QbE90Z1FDUTlrM1BKWTVBelZKdEhJbFBGR0h1NVZr?=
 =?utf-8?B?UWRwSUxIaWNydGhSNllHT2N2cTNtNGp0S1p6blpmUnJvSEg3cVorbGczV2d1?=
 =?utf-8?B?OFBEcGw1R3N6NUJRZVAzYk54RnMzSnRDMlI3cDJyVFpaOXJMSDBhNURCL09m?=
 =?utf-8?B?Rit2ay82SUV3YmZPc1FobjJKbUlVZHVlcXF6clhuUzA3YUFwTENBK3VTQTcx?=
 =?utf-8?B?THF0aktvMG5QcFNGbGpxSGx4VkZUQ0t5M091ZVBMSlBLbEk4Qm4wbjAwREdr?=
 =?utf-8?B?QnlJeEg2K3pxQXZ0NldkOGVNSk5raXVhaHFjOWQxSHE4Wkx0bjNLRTZWcmk1?=
 =?utf-8?B?allVWnVGNWRlb3lzOUNqYlVEYWFaanNnWVZVeVd1anFUS1o3bXQzSjB1QjVa?=
 =?utf-8?B?ZHRONlgzQjY1K2R6a2c2M2ZVSE8vb1VCbFFDekk0aHY1T01DYWpMVE1TM2JO?=
 =?utf-8?B?M0VUMkEvbTRHZGFUMWR6Y20wL0N3WHJzZlZHVUF3VHAweDllN3hOVjVNSkY1?=
 =?utf-8?B?bUVGV2VxN3FZbFpPcFd2UVN3b09oZUcxc29ScVRtbmZGbitNWXZvMDJkVVlr?=
 =?utf-8?B?OTN3RW1PaWYzcUozMDRoWW1yOXJDVkRtMnpQem4wRGd2SWM3RXJxekZ1MDlI?=
 =?utf-8?B?NUFIL0lTd3RUcFVGRUhBNG5ZRkpxYkUycmNDL2hTWEUrc3dUcnlDRWlHYkZD?=
 =?utf-8?B?UWc0Q2taTlhOZEhKK2JBMFRkZjRzcVFDKzN6eCtIMjhqRHZrQjlpbGN4V2ZO?=
 =?utf-8?B?NnNkMVFyZTYwZm54VHpWVlkyKzZhTVdvQktWekhVOXlWZDY0MXpRSXNBNUlr?=
 =?utf-8?B?NDdYendLZlFpNWNXYWJsQ3k0dnovS1FlVC9lcjRnR3FJZXlIcXdGUW5TWnl5?=
 =?utf-8?B?Q2pDRmZuR0J0NW50OHRPc0llTWdiMHZaZFFsRjBSY3QzTXptb2ZBVS9IK29m?=
 =?utf-8?B?bmJsMndmL3A3M21SbW9KdkJ3Yms3WThJeFR2Y3krNEcyS2YvZE51bDh3SXpC?=
 =?utf-8?B?VWdVRDlyR0w1a2RzMnR1bWtNME54azlkNVFGOW8yc1JvejZGT1NIVEY1eEwy?=
 =?utf-8?B?WnBGUTgvYnZKaWVMMEdET3pRT2xlZE9UQTlFWnZVR0FEQ3pNV1BYbGxPbkhB?=
 =?utf-8?B?S2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B96E88789B20AB479E041DAFFEF02B7A@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3d1X+zHGnFg69TUxaRpnEzJI8UbHVfIJ/bYkVZlm6NVSHdcgYmJNY3uk3Cc4pUoB3srIQUoy7H+l54OvHEGXNUcbJIEQP7rDuT3YMVFmgJCT4SrhLjrxWOZY3zxiMxCOl5F4ZwnGIqF/XWIDCgq5rKksdyB2OOd16zPzDU/sZvCQuSvn3AZ4N8zsoES2YBwgCrgBbtnimU3q3Ex0gXfo5RkOzTMhyQ1WqX02WhhU8DQ2fAfGlWq1iisIl9KWxir5cDwOaPDEhW8d4Fr5My7RK/gMPOd0McSwpt1jJGhF8T9WhaL3QqxwXNB5InSsOM3ZIELe1e54vpoFYHNQVckZww2SejIOhtC03atbvMnmwTcK/u9wh326Xqhr2WKAyg3xVJ+te95XM2Cck2YadEfVXUd4ooJmBN1mZL3NBqwKg3GREYcFSzLeL9cxsOS6KoNExIXWUOwtmrDs0bHrY0FgF/m9nRcIjfPV9oLrxsnXdxdmuR8pdPQigeILBnhdSlYkuri3Wy0j6q7k5jfiFvj3rAZwFfA7jNbxYpXAZ0izlUKhlbR5JbFmz95aINMkPFYI39Gv20QOGtAmNG+7/4IiW4ma5zoc6hBOqK6HMESxYx/ioyZ1GvBjGqjKrK4TzPPr
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB5818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cd895e6-4d50-4bae-d91a-08dc448d7e29
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2024 01:16:07.7125
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XiRXqLJqOC6XRQA+7SiDlzGUs0bOQBSxtLBgbb4UJAttYmht8hGF7OppLG33/QtmA0MEdu6F2kjXwIkjsPy6SQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB9739

DQoNCk9uIDE1LzAzLzIwMjQgMDI6MzIsIE1pY2hhZWwgQsO8c2NoIHdyb3RlOg0KPiBPbiBUaHUs
IDE0IE1hciAyMDI0IDE3OjQ4OjIyICswODAwDQo+IExpIFpoaWppYW4gPGxpemhpamlhbkBmdWpp
dHN1LmNvbT4gd3JvdGU6DQo+IA0KPj4gICAJY2FzZSBCNDNsZWdhY3lfSU5URVJGTU9ERV9OT05F
Og0KPj4gLQkJY291bnQgPSBzbnByaW50ZihidWYsIFBBR0VfU0laRSwgIjAgKE5vIEludGVyZmVy
ZW5jZSINCj4+IC0JCQkJICIgTWl0aWdhdGlvbilcbiIpOw0KPj4gKwkJY291bnQgPSBzeXNmc19l
bWl0KGJ1ZiwgIjAgKE5vIEludGVyZmVyZW5jZSIgIiBNaXRpZ2F0aW9uKVxuIik7DQo+PiAgIAkJ
YnJlYWs7DQo+IA0KPj4gICAJaWYgKHdsZGV2LT5zaG9ydF9wcmVhbWJsZSkNCj4+IC0JCWNvdW50
ID0gc25wcmludGYoYnVmLCBQQUdFX1NJWkUsICIxIChTaG9ydCBQcmVhbWJsZSINCj4+IC0JCQkJ
ICIgZW5hYmxlZClcbiIpOw0KPj4gKwkJY291bnQgPSBzeXNmc19lbWl0KGJ1ZiwgIjEgKFNob3J0
IFByZWFtYmxlIiAiIGVuYWJsZWQpXG4iKTsNCj4+ICAgCWVsc2UNCj4+IC0JCWNvdW50ID0gc25w
cmludGYoYnVmLCBQQUdFX1NJWkUsICIwIChTaG9ydCBQcmVhbWJsZSINCj4+IC0JCQkJICIgZGlz
YWJsZWQpXG4iKTsNCj4+ICsJCWNvdW50ID0gc3lzZnNfZW1pdChidWYsICIwIChTaG9ydCBQcmVh
bWJsZSIgIiBkaXNhYmxlZClcbiIpOw0KPj4gICANCj4gDQo+IFBsZWFzZSBlaXRoZXIgbGVhdmUg
dGhlIGxpbmUgYnJlYWsgaW4gcGxhY2UsIG9yIHJlbW92ZSB0aGUgc3RyaW5nIGNvbnRpbnVhdGlv
bi4NCg0KR29vZCBjYXRjaCwgaSB3aWxsIHVwZGF0ZSBpdC4NCg0KDQpUaGFua3MNClpoaWppYW4N
Cg0KPiANCj4gDQo+IA==

