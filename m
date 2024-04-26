Return-Path: <linux-kernel+bounces-160041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CEACA8B382F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:18:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D23151C2106B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 13:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBFD8147C75;
	Fri, 26 Apr 2024 13:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="oQ0Ex0ba";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="GNm5Rcyd"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7612F146D52;
	Fri, 26 Apr 2024 13:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.154.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714137471; cv=fail; b=moYlkyCZykYyvGp4+hORMjjUVbFCdc7KtExOXwRz00CKyC8wHidJGFH8qzm3G/cK/UNr1Y9AtRnEckBRK7cB14BrIYxEBb8rvK9DwyqA3V65xVBicOFW3Eu1UkXClhIdPxhZLAGG633Hk0/0Xd/ZI65TKPEHPV+vmPDBZD/XT0E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714137471; c=relaxed/simple;
	bh=AuEHwbz+yHLusfCiQAj0MM+ImShSZ2daGZRCS0RD6SQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=g9+bVbSAtskoDHIQLHKCy4Jk2SGMp9ml0+zEOWG9+VSjUIKbuSWmahDOdqdp3KxiTNnC6/9y1lcPa2//t/LLDy0H2YHzLPYWsiZXb8qGsMdBivLHjRhQODadrbox1QbQUnijCXRhv8Wue7sv/eMYSibIiYSIR7omkYu3hYCPerk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=oQ0Ex0ba; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=GNm5Rcyd; arc=fail smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1714137468; x=1745673468;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=AuEHwbz+yHLusfCiQAj0MM+ImShSZ2daGZRCS0RD6SQ=;
  b=oQ0Ex0ba49Y1b6E0I+4cFBvJm8qp12yXr3Gu7aI6rVpJyPYz25PTgKrc
   Oe1iEJ0WYRfQqpeKdxhuLzPZE/xU6wXqv3cue19dGKOy+UOzgrB5ZtGIK
   5eHSUx4nhMBuTN5147TgW11j7WWMMuyxe1YfmeLGl2CNn6CafYCwv6V0u
   ZADFee4RbEizimE4W5nvVZoCwARwotOFC108efmCs+hDclT5wE3X1ouuc
   ZHQnTYdtCPDjxlspNhst7BOKLTZsVX6YdAqA76ibi0bAMgz1SDjp7rMkL
   dEKAjm83ZMhr+qgwSDwoRlHh+aRo6QHGwZv1yYIFP2AJDhsnl+wqSgWYK
   A==;
X-CSE-ConnectionGUID: oebUKlg7SvaYPFHI6J7eMA==
X-CSE-MsgGUID: 7U5FWTtASFyk8la2GqDx3g==
X-IronPort-AV: E=Sophos;i="6.07,232,1708412400"; 
   d="scan'208";a="190115540"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Apr 2024 06:17:46 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 26 Apr 2024 06:17:25 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 26 Apr 2024 06:17:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jXZcNed4owgJnBnQF8tktpreV+kWDmFKSHLIJHuqu4wjAaK4+iz3eG51rLGYbqawEdk+1Efy/sHUA/2RqE0uY4x5uhaBVqhXn15Nnz7F1skkTZJ6dKihEobfMPUOfE2E0J85vqIv+2jcSl+OfzoC63jNALP45ygZWMQRRmPf9o1VF0mXrKLgKDGriSc98ei/ecwMreCa3mDDn9l3E+M4R7zk6KNwkQ0ei2IGFHA/YKQKee1VK+19B56GVznJfDXMKKRneiuXRM7xfKEmQav7KWWnqXfxn72K8kKLEOm00Kn3j8ZwRzCujp0+haoWcXVb3liuWv/fJ7qzVvr+CVPpNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AuEHwbz+yHLusfCiQAj0MM+ImShSZ2daGZRCS0RD6SQ=;
 b=QduamI4hbrCM5xzH5Q4uNqpQ76btlqdHBzX4FCf57Ly02htY2chYS5HQLm2YMacdb7Zhx9G5rfsT4sPHPXHaki6dSTHXL6pq1bnU3Lam4fgrFaUUMU+9wzMrAdi6nmD/QL1NmvXtisUCAL3zgvX27K2z/vwcp+RS1/9CdrNdpQgljiNt+wexSZLDmQWlE9lSJmseX0tLsaMBiXQYYYlJCp0l56V07u7orJd9PpWQwBVTw5w0R0UTi2KcmohoJdg/aoAkfFVR6spJp9g7ZE0X+vxtZ7qwLrHTSKj2hcxsuPdKiDrvmQRdL49uNdRoh81hBTVXML7xYfsFRYEMGj6Idw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AuEHwbz+yHLusfCiQAj0MM+ImShSZ2daGZRCS0RD6SQ=;
 b=GNm5RcydgAX6TRtve0mlvOhrCixRq9a3hF81jKCyibDafEZOYU/x9axvnc3XfK42AS85fpSBSahUjN2Gfwbgt1bliQwGGltwvB7HzaCXI+TFVseqa1z6EyyrW79gUNF9WfLRGNFNnzGyz3jpEWRB+Y9U8ioOshfgnS0JH2ViDnHZ2ts5WJQkWYS3rupcVlfcZa4YKh7xFu535Sj0AIpKd8Ii1aoTGHZXvpPSvUkRFyK0am7O/E8uU42BsUnaBTzlJGcP4R4G5fUiKi7BPuJndeTKEmV0gXgHbldVQgk3et+5m0X9Kci3paqKeVeKzHPHkdY/lfvrHAFdsNlV1isHKQ==
Received: from SA1PR11MB8278.namprd11.prod.outlook.com (2603:10b6:806:25b::19)
 by SA1PR11MB5874.namprd11.prod.outlook.com (2603:10b6:806:229::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Fri, 26 Apr
 2024 13:17:23 +0000
Received: from SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9]) by SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9%4]) with mapi id 15.20.7519.021; Fri, 26 Apr 2024
 13:17:23 +0000
From: <Parthiban.Veerasooran@microchip.com>
To: <andrew@lunn.ch>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <saeedm@nvidia.com>,
	<anthony.l.nguyen@intel.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <corbet@lwn.net>,
	<linux-doc@vger.kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<devicetree@vger.kernel.org>, <Horatiu.Vultur@microchip.com>,
	<ruanjinjie@huawei.com>, <Steen.Hegelund@microchip.com>,
	<vladimir.oltean@nxp.com>, <UNGLinuxDriver@microchip.com>,
	<Thorsten.Kummermehr@microchip.com>, <Pier.Beruto@onsemi.com>,
	<Selvamani.Rajagopal@onsemi.com>, <Nicolas.Ferre@microchip.com>,
	<benjamin.bigler@bernformulastudent.ch>
Subject: Re: [PATCH net-next v4 06/12] net: ethernet: oa_tc6: implement
 internal PHY initialization
Thread-Topic: [PATCH net-next v4 06/12] net: ethernet: oa_tc6: implement
 internal PHY initialization
Thread-Index: AQHakZASjmqmxbv8t0yjmbU4gSXFVbF2jkiAgAQG1YA=
Date: Fri, 26 Apr 2024 13:17:23 +0000
Message-ID: <738b10fd-9bb6-433b-900e-5571e392f347@microchip.com>
References: <20240418125648.372526-1-Parthiban.Veerasooran@microchip.com>
 <20240418125648.372526-7-Parthiban.Veerasooran@microchip.com>
 <aae5f0be-7e1f-443e-831a-ab0b4df0b839@lunn.ch>
In-Reply-To: <aae5f0be-7e1f-443e-831a-ab0b4df0b839@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8278:EE_|SA1PR11MB5874:EE_
x-ms-office365-filtering-correlation-id: ab753d32-2bbb-47c2-626c-08dc65f3359e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|366007|7416005|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?RURGd2tPYXIyWW96YjlJWjZqelJNYXdkZ0M1R3lKODNCQS9RWFMzR2gzUkNM?=
 =?utf-8?B?bHdkTGt5NDY1bisrdGc2NmRYMEtzbnFneTVyVUxuekV4ZVJucnRBT3pQV3M1?=
 =?utf-8?B?S2VVWlVyWklicytUMVJDVlJVbG9TSjZrcHBYZUFHcm1XbUpBZmR4Tnp3YkZi?=
 =?utf-8?B?RGFuVEFTWEg4dmJhWlMxaVd4UWlwbWo2b2VGODVkeWtaWUJFSzBIQ2gxNE9y?=
 =?utf-8?B?dGlsSW53NHg2WlVTQ2ZmVVhJZExKclVlVW90WlJUK0lZeE1FWmpVQ052aE9P?=
 =?utf-8?B?TGN3ZEdZNHhmQnFvWkF3bnJRREJyaFlUSy9CdWlOOVkyVTl3dm5pYzlZWDZR?=
 =?utf-8?B?Qzk3MjR6bjZBVUNCUzRxUDNwUGVyeWhsVHFlMGcxYmVMdStWMzliVCtKSXVJ?=
 =?utf-8?B?ZnYrMkFSbEpUcDJVVC9RTHlzVDZaWUpYcFBiZnRWVWw0TnJUMDhFWkRkVEFJ?=
 =?utf-8?B?azk5QjNOMEJvaldpN0p5dXdiS25MYlYzRWdibEZYUUY2RWZGQlJhL0xlTjJw?=
 =?utf-8?B?ZTVEeG14R0x4aXFtSWpmUnFpa254WS95VjFRMWxCdFBsUVN3OU5XVmQrQ09n?=
 =?utf-8?B?VU5uZG5HTGxyZ29mL0t1eTdnNURndmN0b0g3Rkx1QmJ6Zlo3ZHRIOHhURCtH?=
 =?utf-8?B?RFVUS0NnSmZLUERUWm9mVTZ5bjlsNWJWQ3ZxSWR4cklpZHFWSjFWSUpvWENB?=
 =?utf-8?B?clRuWXVoZWJnUHpRVEM0bkdCQjhieWMwZFMvb0FYSFg4R3B2ZVJqRHpoT0J6?=
 =?utf-8?B?MkRsM3pyUzI5Ui9MTU1rREZmaUZoeU9OQWtRZjRaVVgzSzRnM2ZGdG1xNjYz?=
 =?utf-8?B?ZnYyU3A1MXVTM0xLYVozS3p4cGcrRXZhZURGWnNyaVFKSDdWaXcxNWxUVmJs?=
 =?utf-8?B?UFRTeWNyWW42QzAzODRwaURWWmhoS3hZdnU2MThkdTFPcTY1c1pGcHJiQk01?=
 =?utf-8?B?NmQrSUxwbm1sNDZrWWJ5Ukk2RCtyb2lRTjExQXhlSDB0NTZYZGJZdURpbGNO?=
 =?utf-8?B?OVNNYXhrZVFFV08wdENWK3RiYXd3WDQ1T2FiWlVaZnFmNXdQeWdsL2hKYnZI?=
 =?utf-8?B?czE2N0tCRVVnSEp1ZUZLQnV4QWcvR0RyNWM4OGZ4eUl0cWFxemNDTy94K2Jh?=
 =?utf-8?B?QnVRckIrSnRSbkVuUjg5TFdCdnFzN3ZTUzUyQm9xSkRpK29abzFIZXZGWUFR?=
 =?utf-8?B?a21CaDVBVXk4RkpBbncycjJpNldmU0tUVDM3clBHQjdBNHVoRkVEMjc2Z0Q2?=
 =?utf-8?B?eVUzVGs0NXdBQ0I1RFRaRzkrMW1pR3hwekl0RitOT0pCT3dsTE5ITmhRYmlv?=
 =?utf-8?B?WS9EQVducEdDdGliWWhNOWpIQUlUMk9xNWdvcStuOWdNZVRZbzBDaWxzOUJK?=
 =?utf-8?B?TEszanhjUlMweUgxdTJaKzVSM2pOVHRwbjZzbHMzOEhOVGtLR2F3QkkvVTl0?=
 =?utf-8?B?NFV0ZnZEcHU4Tk9uTnZLaXZWaFlGLzV2YU5namZSN1VWZzl6Y0dvRkh3eUFI?=
 =?utf-8?B?QjRsZldEMm5nNmExRnZsbndTeDJOSW9ETXl6UGc4OFNRRE5UbmZGeGw5SWxP?=
 =?utf-8?B?d2ZlVnFQZlB5YVpuRzZEMEJpVjI4MUxaWWYxZFlwSGZCMVRYRytqNElzL2gx?=
 =?utf-8?B?U1J5Sks5eTNSQ3FVajA1Wjg5V2w0NFhoRUgrYktCdUxoSGU1b0VZcWM4T09V?=
 =?utf-8?B?aUEzSk00MXp6UGNoMEE2ZC9JVHRzU2xLZzkrM3FOQU5DditvRWxadW5RPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8278.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(7416005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K05UckV1bElmVFliNGk3U042VUk0QnJaRFhNUXNiOHZwS3o3Tzhhb1NEaW9B?=
 =?utf-8?B?U2ZEUVBOR3RadFhWU3IyNVJXb2NmbXVvUnlibVpMSUJUZDVwVERkai9uV0pR?=
 =?utf-8?B?OE8vTTVhVS9Ea29ueDFwQzVudldUckxJTXpraXk2T2NMd3IyQStNNUlSYjBr?=
 =?utf-8?B?S3FMalpabHlKM1lqREtmRC96aFdoNit2K1hVL3kxeGdDL1ZPZzdkYTZHTUF0?=
 =?utf-8?B?d1NQMDB3L3Fvc2NnUHo0MDA1OEZERi9NZjROOTNEdloxdzJROVRZOUo3dXdm?=
 =?utf-8?B?Q0hQWGJJS0tMRUx5RjRnV3oxWEFRSWNlS0c4VjFOd0kxVXAwVExQeXBISlpo?=
 =?utf-8?B?WUhCdm5ERDIrdTdRZFdpditiNURYdCs2UnVWQmJKN3RWYUJCYUpneHpaVG1C?=
 =?utf-8?B?bmtpdWcvMTZCU3hvTWd1T3JVbkxMZnRFM1lrMlRoQ2EvTFF6Mk9PZnQ1Zmlm?=
 =?utf-8?B?VU9YU29XSUNEMGJuN0R4aWNrUHdTRDJNL0dzbHBiZjhXLys4U0k2L1lSUHQ1?=
 =?utf-8?B?SDAzYzJhTHN6dW9ESDlzRk41VTF1d3A5VXpKVGRWak40VEFXUjJ4NWhoU2di?=
 =?utf-8?B?eEFTYTlrd2EwSkQwcHBkQnNvRUhKYXh3MkVWc1NGdnFialdHODFqdFNWbkc0?=
 =?utf-8?B?dFdMS2pqaHgxQlBiOXkyVTlYK25oK3QvdjFEUkd6SUUwMVBhamdxdGJ6TFpi?=
 =?utf-8?B?c0hxTWdCQ05TSFdYUElDeXQwOC8zeDhTbDFETU5EUTdKdzBOekppS0EyTTMz?=
 =?utf-8?B?cmJ4RWN6ejFWMGdJdlJwU0Z4M01EZlRuMHhuV3gvM1RBV2ZsOTVnT1lXTHVh?=
 =?utf-8?B?Qmx5ZkVpbVdhZHF4NUp6c3B6d05WY2RWdC9PaWkyalNIOVJkVG16OWRYdDRN?=
 =?utf-8?B?ZUwyT1c0VktOTElDU1paWTVZTjUyWGNFTlJwRDRjdG5jcDVvVGx4MGxSaTFo?=
 =?utf-8?B?RnRaaVY2ejVZRFBLdkpwTTZ5YmcvSzlGVUNtaWlkZTdBbnErTDFmUWtBNk91?=
 =?utf-8?B?U2pIcHNqMUdNREdwY0VHSlo5ZE5acGpiVHdSVjB3Q05pcHIwcFBKMmRtRDFj?=
 =?utf-8?B?dityUGRWc2ZyWkp5dHVEenRtK2ZEZzhzMlZyTkc2WjRQZFVlUjVVUkx5bnBu?=
 =?utf-8?B?cHRjNmJTcjdxN3JoY2RlbVlic05XMTFLYlloSTBSdWN0RTBpeGk4N2JvMUdq?=
 =?utf-8?B?RlcwNkV2NjhQd0FnMzVWK3B2NEFEUzdMU1JDaHBkSlEraEZHYWxWSjhUSUdN?=
 =?utf-8?B?eTgxNjZlQnBjTXRnWTJuVkpVdG9QbUhvR29LeGNuV1ROTDRIZUxFODVvamYw?=
 =?utf-8?B?OEpLWFhsUlNNY0NZZGM0S2FSRHNwZUxRNWhSc0tPZHg4WUpGZGRwU1dEbUZT?=
 =?utf-8?B?cUYveTJZdlM2dmZaMW9JcitBWW5GRFpRY3o4NXRIOUM2MkRxSGtOUWgxa3kx?=
 =?utf-8?B?dFRZbzM0WUpCWHdra1hlanMxeDI5S0lRWmxUUFQzNjdLZTc3Ni93NDFTRnpa?=
 =?utf-8?B?R2xYU1dKRXYxSjArZ29HZUsvMENoTXJGejFKc1hFYWk2MVBSK0ZBZ0c4cTRP?=
 =?utf-8?B?T0JSVGk4YXNPVm9YRTJSdUoxK1RzeklLVUFzdlYxaXJqem9wZk51TXBMRHpT?=
 =?utf-8?B?VnV0NTZKRDdIVVh3NW5LOG1XTDZDa3Rwb29BYWp1QStoa3FqTE1sVVNYMjNG?=
 =?utf-8?B?ZVdkUllhdGFLejdKdzRCZ2Q1czB3Yk4vampIUmZGMldtWlZxNTB2Q256NEVB?=
 =?utf-8?B?V0d0d21PbEFOT0NYbTZHbEV1Rm82T3RlSi9EbWE0bTkzekFqVlVVM1ppWHhJ?=
 =?utf-8?B?K3hyQmVCLzU3SjczUGdiZ2x5NkpoK2I0L1pyL2lyVWlWUkZOWE9SNDFwK1cy?=
 =?utf-8?B?MWdKMjk5dU03YkdNV2VNOGpBS3Nvd1dLM24xRng2by9Wait6Z0pydGVuQlFE?=
 =?utf-8?B?SG1weUpkT1lES0FmVEYzN29la2FEVDZKa3FwbG01djE1VktlWnpIM2pPci9J?=
 =?utf-8?B?dEpNZUMrbzRqczFMZkRUaXU0ZEJSQ255OWg2b1hCQzVpZU9rZGk1TVNzSHor?=
 =?utf-8?B?T3Vkc3ZaY1RXenVQNUQxTkh0K3dLN0dOZy9GdUh5b2FROXZha0c5RS9Xby84?=
 =?utf-8?B?UWZnemtDMWFQNWtPc3l6ankvaWxKa3p2ZnBtVFgwZ3VBaTNGSWpVQ0U1RUhM?=
 =?utf-8?B?eXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <20F6655C93C00E40B6017FFF86DDEB0A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab753d32-2bbb-47c2-626c-08dc65f3359e
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2024 13:17:23.0520
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mIT02MTOjeX8MVCUTC2q9qQpY/JSfw164knwr3cDruonyygIkKGtOXVR/oDWt2KGhBIRTj/s02IzvfgWKMMVyYHkEeOG6RAKoC6MnRv3dUBeI2eVCNTdms3x4pj7IZBU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5874

SGkgQW5kcmV3LA0KDQpPbiAyNC8wNC8yNCA1OjE4IGFtLCBBbmRyZXcgTHVubiB3cm90ZToNCj4g
RVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVu
bGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPj4gKy8qIFBIWSBDbGF1c2Ug
MjIgYW5kIDI5IHJlZ2lzdGVycyBiYXNlIGFkZHJlc3MgYW5kIG1hc2sgKi8NCj4+ICsjZGVmaW5l
IE9BX1RDNl9QSFlfU1REX1JFR19BRERSX0JBU0UgICAgICAgICAweEZGMDANCj4+ICsjZGVmaW5l
IE9BX1RDNl9QSFlfU1REX1JFR19BRERSX01BU0sgICAgICAgICAweDNGDQo+IA0KPiBEaWQgeW91
IGV2ZXJ5IGZpbmQgb3V0IHdoeSBDMjkgaXMgcmVmZXJlbmNlIGhlcmU/IEZyb20gdGhlIHN0YW5k
YXJkOg0KPiANCj4gMjkuIFN5c3RlbSBjb25zaWRlcmF0aW9ucyBmb3IgbXVsdGlzZWdtZW50IDEw
MEJBU0UtVCBuZXR3b3Jrcw0KPiANCj4gTk9UReKAlFRoaXMgY2xhdXNlIHJlbGF0ZXMgdG8gY2xh
dXNlcyB0aGF0IGFyZSBub3QgcmVjb21tZW5kZWQgZm9yIG5ldw0KPiBpbnN0YWxsYXRpb25zLiBU
aGlzIGNsYXVzZSBpcyBub3QgcmVjb21tZW5kZWQgZm9yIG5ldw0KPiBpbnN0YWxsYXRpb25zLiBT
aW5jZSBNYXJjaCAyMDEyLCBtYWludGVuYW5jZSBjaGFuZ2VzIGFyZSBubyBsb25nZXINCj4gYmVp
bmcgY29uc2lkZXJlZCBmb3IgdGhpcyBjbGF1c2UuDQo+IA0KPiBJIGRvbid0IHRoaW5rIHlvdSBz
aG91bGQgYmUgcmVmZXJlbmNpbmcgaXQgaW4gdGhlIGNvZGUuDQpUaGFua3MgZm9yIHRoaXMgZGV0
YWlsZWQgZXhwbGFuYXRpb24uIFRoZSByZWFzb24gd2h5IEkgY29uc2lkZXJlZCB0aGlzIA0KaXMs
IGluIHNlY3Rpb24gOS4yIGFuZCB0YWJsZSA3IG9mIHRoZSBPUEVOIEFsbGlhbmNlIGRvY3VtZW50
IHNob3dzIHRoZSANCm1hcHBpbmcgb2Ygc3RhbmRhcmQgcmVnaXN0ZXJzIHdpdGhpbiBNTVMgMCB3
aGVyZSBjbGF1c2UgMjkgYWxzbyBsaXN0ZWQgDQphcyBjbGF1c2UgMjIgZXh0ZW5kZWQgcmVnaXN0
ZXJzIGZyb20gMHhGRjIwIHRvIDB4RkYzRi4NCg0KaHR0cHM6Ly9vcGVuc2lnLm9yZy9kb3dubG9h
ZC9kb2N1bWVudC9PUEVOX0FsbGlhbmNlXzEwQkFTRVQxeF9NQUMtUEhZX1NlcmlhbF9JbnRlcmZh
Y2VfVjEuMS5wZGYNCg0KQnV0IGJ5IGNvbnNpZGVyaW5nIHRoZSBsaW1pdGF0aW9ucyBleHBsYWlu
ZWQgYnkgeW91IGFib3ZlLCBJIHdpbGwgY2hhbmdlIA0KdGhlIG1hc2sgYXMgMHgxRiB0byBzdXBw
b3J0IG9ubHkgZm9yIGNsYXVzZSAyMiByZWdpc3RlcnMgaW4gdGhlIG5leHQgDQp2ZXJzaW9uLg0K
PiANCj4+ICtzdGF0aWMgaW50IG9hX3RjNl9tZGlvYnVzX3JlYWQoc3RydWN0IG1paV9idXMgKmJ1
cywgaW50IGFkZHIsIGludCByZWdudW0pDQo+PiArew0KPj4gKyAgICAgc3RydWN0IG9hX3RjNiAq
dGM2ID0gYnVzLT5wcml2Ow0KPj4gKyAgICAgdTMyIHJlZ3ZhbDsNCj4+ICsgICAgIGJvb2wgcmV0
Ow0KPj4gKw0KPj4gKyAgICAgcmV0ID0gb2FfdGM2X3JlYWRfcmVnaXN0ZXIodGM2LCBPQV9UQzZf
UEhZX1NURF9SRUdfQUREUl9CQVNFIHwNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIChyZWdudW0gJiBPQV9UQzZfUEhZX1NURF9SRUdfQUREUl9NQVNLKSwNCj4+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICZyZWd2YWwpOw0KPj4gKyAgICAgaWYgKHJldCkNCj4+
ICsgICAgICAgICAgICAgcmV0dXJuIC1FTk9ERVY7DQo+IA0KPiBJbiBnZW5lcmFsLCB5b3Ugc2hv
dWxkIG5vdCByZXBsYWNlIGFuIGVycm9yIGNvZGUgZnJvbSBhIGxvd2VyIGxldmVsDQo+IGZ1bmN0
aW9uIHdpdGggYSBkaWZmZXJlbnQgZXJyb3IgY29kZS4gSWYgdGhlcmUgaXMgYSBnb29kIHJlYXNv
biB0byBkbw0KPiB0aGlzLCBwbGVhc2UgYWRkIGEgY29tbWVudC4NCkFoIG9rLCBJIHdpbGwgcmV0
dXJuICJyZXQiIGluIHRoZSBuZXh0IHZlcnNpb24uDQo+IA0KPj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvbmV0L3BoeS9taWNyb2NoaXBfdDFzLmMgYi9kcml2ZXJzL25ldC9waHkvbWljcm9jaGlwX3Qx
cy5jDQo+PiBpbmRleCA1MzRjYTdkMWIwNjEuLjc2OWE4ODI1NDI4NSAxMDA2NDQNCj4+IC0tLSBh
L2RyaXZlcnMvbmV0L3BoeS9taWNyb2NoaXBfdDFzLmMNCj4+ICsrKyBiL2RyaXZlcnMvbmV0L3Bo
eS9taWNyb2NoaXBfdDFzLmMNCj4+IEBAIC0yNjgsNiArMjY4LDM0IEBAIHN0YXRpYyBpbnQgbGFu
ODZ4eF9yZWFkX3N0YXR1cyhzdHJ1Y3QgcGh5X2RldmljZSAqcGh5ZGV2KQ0KPj4gICAgICAgIHJl
dHVybiAwOw0KPj4gICB9DQo+IA0KPiBQbGVhc2UgcHV0IHRoaXMgaW50byBhIG5ldyBwYXRjaC4N
Ck9LLCB3aWxsIGNyZWF0ZSBhcyBhIG5ldyBwYXRjaCBpbiB0aGUgbmV4dCB2ZXJzaW9uLg0KPiAN
Cj4+DQo+PiArLyogT1BFTiBBbGxpYW5jZSAxMEJBU0UtVDF4IGNvbXBsaWFuY2UgTUFDLVBIWXMg
d2lsbCBoYXZlIGJvdGggQzIyIGFuZA0KPj4gKyAqIEM0NSByZWdpc3RlcnMgc3BhY2UuIElmIHRo
ZSBQSFkgaXMgZGlzY292ZXJlZCB2aWEgQzIyIGJ1cyBwcm90b2NvbCBpdCBhc3N1bWVzDQo+PiAr
ICogaXQgdXNlcyBDMjIgcHJvdG9jb2wgYW5kIGFsd2F5cyB1c2VzIEMyMiByZWdpc3RlcnMgaW5k
aXJlY3QgYWNjZXNzIHRvIGFjY2Vzcw0KPj4gKyAqIEM0NSByZWdpc3RlcnMuIFRoaXMgaXMgYmVj
YXVzZSwgd2UgZG9uJ3QgaGF2ZSBhIGNsZWFuIHNlcGFyYXRpb24gYmV0d2Vlbg0KPj4gKyAqIEMy
Mi9DNDUgcmVnaXN0ZXIgc3BhY2UgYW5kIEMyMi9DNDUgTURJTyBidXMgcHJvdG9jb2xzLiBSZXN1
bHRpbmcsIFBIWSBDNDUNCj4+ICsgKiByZWdpc3RlcnMgZGlyZWN0IGFjY2VzcyBjYW4ndCBiZSB1
c2VkIHdoaWNoIGNhbiBzYXZlIG11bHRpcGxlIFNQSSBidXMgYWNjZXNzLg0KPj4gKyAqIFRvIHN1
cHBvcnQgdGhpcyBmZWF0dXJlLCBzZXQgLnJlYWRfbW1kLy53cml0ZV9tbWQgaW4gdGhlIFBIWSBk
cml2ZXIgdG8gY2FsbA0KPj4gKyAqIC5yZWFkX2M0NS8ud3JpdGVfYzQ1IGluIHRoZSBPUEVOIEFs
bGlhbmNlIGZyYW1ld29yaw0KPj4gKyAqIGRyaXZlcnMvbmV0L2V0aGVybmV0L29hX3RjNi5jDQo+
PiArICovDQo+PiArc3RhdGljIGludCBsYW44NjV4X3BoeV9yZWFkX21tZChzdHJ1Y3QgcGh5X2Rl
dmljZSAqcGh5ZGV2LCBpbnQgZGV2bnVtLA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgdTE2IHJlZ251bSkNCj4+ICt7DQo+PiArICAgICBzdHJ1Y3QgbWlpX2J1cyAqYnVzID0gcGh5
ZGV2LT5tZGlvLmJ1czsNCj4+ICsgICAgIGludCBhZGRyID0gcGh5ZGV2LT5tZGlvLmFkZHI7DQo+
PiArDQo+PiArICAgICByZXR1cm4gYnVzLT5yZWFkX2M0NShidXMsIGFkZHIsIGRldm51bSwgcmVn
bnVtKTsNCj4gDQo+IEl0IGlzIGJldHRlciB0byB1c2UgX19tZGlvYnVzX2M0NV9yZWFkKCkuIFRo
YXQgd2lsbCBjaGVjayB5b3UgaGF2ZSB0aGUNCj4gbG9jayBoZWxkLCB3b24ndCBqdW1wIHRocm91
Z2ggYSBudWxsIHBvaW50ZXIgaWYgdGhlIGJ1cyBkb2VzIG5vdA0KPiBpbXBsZW1lbnQgQzQ1LCBk
b2VzIHRyYWNpbmcsIGFuZCBpbmNyZW1lbnRzIHRoZSBNRElPIHN0YXRpc3RpY3MuDQpPSywgc3Vy
ZSB3aWxsIGRvIGl0IGluIHRoZSBuZXh0IHZlcnNpb24uIEFzIHRoaXMgaXMgYWxzbyBhcHBsaWNh
YmxlIGZvciANCl9fbWRpb2J1c19jNDVfd3JpdGUoKSwgSSB3aWxsIGNoYW5nZSB0aGlzIGFzIHdl
bGwuDQoNCkJlc3QgcmVnYXJkcywNClBhcnRoaWJhbiBWDQo+IA0KPiAgICAgICAgICAgIEFuZHJl
dw0KPiANCg0K

