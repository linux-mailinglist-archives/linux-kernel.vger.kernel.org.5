Return-Path: <linux-kernel+bounces-96647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F98875F6B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 09:25:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CFB5282081
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 08:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04659524B2;
	Fri,  8 Mar 2024 08:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="w/q2ga8S";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="j812D+nW"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7FF4EB47;
	Fri,  8 Mar 2024 08:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.153.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709886338; cv=fail; b=mtQ3ut1nFSkFoZDVFypyVJUpCHmwWVnDPVDz3AeHAcJhicWowvqAEBnX7KbJ9wRhOpQlO/6nMv5sQkN+oOwzGbzBZjJN248q6/6W0TOPKW4kn9xtPSvFE2SMd9RZsTE6A1w/fTzDZK8dZlXlMT5TxFh5gXjsOAgA5QzOnB/r0MM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709886338; c=relaxed/simple;
	bh=IfPpkZMrSED83C8LjvVSCXNCZ+DSEi6tSGEmw5n41Hw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AFhx6MMjjbRUkilgUO8iaJk/N1r3F9eqdVNve59XJ1n7uTEs3WwSCHvDz0FF6fVqaaPdHOQ5aQKml8P4VWbpTFRogebzB8OnKdrFEa/hcYnPbow3xN8EicGd9svYDUMZqb9bs3WE5x06MFYLzLHyXa7jF970hWww1T5Q+iFtTjI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=w/q2ga8S; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=j812D+nW; arc=fail smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1709886337; x=1741422337;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=IfPpkZMrSED83C8LjvVSCXNCZ+DSEi6tSGEmw5n41Hw=;
  b=w/q2ga8S4ySKpaKT7wEu5OZ1XXodwZYMc2F9p2CFF6YdvY+zrTwQ+2vO
   O5kpm9DQ9ZCXxWm43AxQJ5fPlOjbzQZgQfUBVaEG6ku3lqw4Wm83x39YS
   EZvSWXjffFrCBrvj9Ef3Bcjt6EQYxl0zBaKr7crKYCvWjC0g4Bzb5AM4w
   BrUxs0wDIO4giFdjRi21T7YldvxsET5YaFNjR30QIYAYwUBwhRNQBrZzj
   rvCodGcUgAeYbqwm2MSzc3sP85oI4wR36h7iPF1K0fUIjF3XSTBOnoqlo
   PkCSlONcsMNZpxVt+gX9BCwx5MCcKo/Scb5oj+vuydl48ICO+EumQnvEP
   w==;
X-CSE-ConnectionGUID: 6qwxoBUdTWWC1n+ryOguOA==
X-CSE-MsgGUID: CI41py9JRh+9orWwvRFfVA==
X-IronPort-AV: E=Sophos;i="6.07,108,1708412400"; 
   d="scan'208";a="17394528"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Mar 2024 01:25:35 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 8 Mar 2024 01:25:31 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 8 Mar 2024 01:25:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AqptIQYH9k4N+VIeZMZ0yrms8T3nFSeW1fKuqMfNWx6zeoiSUq1cXxb6pXozSdG0z7WHRUzv4dNvfqq2G6pTb3C9tTW1Dw6za4ImmnaPc+BM35FQ34qZDWl7nHpbxwriSCfRDgYQ1Se4aioWeQpiyggZPIsDdgeO3q9YWDtwDn2DK4QqZxUsv+6Xhwr4k877BsFQ7MBKJQjhUzupa3fXqDOWmderB26pbZuF3WvEZZAEDjj8ngQIaMbIReeSBJ/ANq1XjOJ1ZJ9SOZgaiK0jkOhtZL418TQRy2hSwXLmkzSFGm/oAFdO8NZh3S5irGDMgt6CCaKZM3g+WN0k6LuoGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IfPpkZMrSED83C8LjvVSCXNCZ+DSEi6tSGEmw5n41Hw=;
 b=AorlslGneeyHi+bfrpPrVCW2sXzgZwdT+AQ9asCrcOGMsiLwCWu7FeTd+6irre13UtuxAUslvAu34GraBb12fGCdq+4bZZHzyJbIpcFV4lxTAN3raCt4RkKrqnR+wm2dSccL2aNV/2x3lUekvTMBntol5UfwUUEK1+cs9l8F/oPvoyWZ7s3spMZmT2+4CpaPSW5nOzU7R5MPTXRzBFVbGQM7b/mpl9cvsBqt0wy+gRaXlMxPIofVRxmTCjPfd/zkw7VZ48FcmL6gayZaXOI+Zu6R4lCs2Gc4yE4/HrmYuh5ncXyXW8aXphmSWqd5nONcp7MukA8Pay6ySBL988arOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IfPpkZMrSED83C8LjvVSCXNCZ+DSEi6tSGEmw5n41Hw=;
 b=j812D+nWWQQFAhAkG/CCyae8iYvDjHss6ugPNmKVi3poAiBN6xMv0GyulXzKDaDEoHieG5t/s5GXiTuZIiF0AzRR9uRsXBho0Xo/Io0O3OJlMqATBK914CqDv7wwH3f22+Nuaz4bwJ7p7tOJWz5CNANWeS1DKrgwDu6req/HKwMrbKWtrg+IilWTBbxgx8FO5rIfcNdVYRHNmf2C5Oqg5FYreXSQPH8RTA5gcfyrbzW5w1RR253aRTP5ZvMPvstD3+2ZV3h/ey2kO7zzGXTah+OHn2hFV4J0iJqaj9snBehgI/NcW9dRY1e/oliIZV0y5+TrObVSrJuCq1foAfAnPA==
Received: from SA1PR11MB8278.namprd11.prod.outlook.com (2603:10b6:806:25b::19)
 by CO1PR11MB4785.namprd11.prod.outlook.com (2603:10b6:303:6f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.8; Fri, 8 Mar
 2024 08:25:28 +0000
Received: from SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::f633:b9d4:f539:177d]) by SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::f633:b9d4:f539:177d%6]) with mapi id 15.20.7386.006; Fri, 8 Mar 2024
 08:25:28 +0000
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
Subject: Re: [PATCH net-next v3 04/12] net: ethernet: oa_tc6: implement
 software reset
Thread-Topic: [PATCH net-next v3 04/12] net: ethernet: oa_tc6: implement
 software reset
Thread-Index: AQHab6OCD00I709j00WIKaDUtsZwCbErb26AgAB2hACAAGBgAIABPr2A
Date: Fri, 8 Mar 2024 08:25:28 +0000
Message-ID: <b3e2a595-437b-440d-ae22-da12570163c1@microchip.com>
References: <20240306085017.21731-1-Parthiban.Veerasooran@microchip.com>
 <20240306085017.21731-5-Parthiban.Veerasooran@microchip.com>
 <4e56f5c2-3d5c-4dda-8a37-01c1dbce27d7@lunn.ch>
 <bff71d0b-49d0-4a4c-98c1-7df7056c4268@microchip.com>
 <31a09423-276a-415b-a7b8-4aab04021a82@lunn.ch>
In-Reply-To: <31a09423-276a-415b-a7b8-4aab04021a82@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8278:EE_|CO1PR11MB4785:EE_
x-ms-office365-filtering-correlation-id: 54a610ea-002b-46d8-6dab-08dc3f494fe6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: miVMqiW2sd7BvGRHqOTBLKW+2faIdByfA6twbbj4eO2+jjAW6bqYNDVtcow/D/AXlk2uqn7lc4jfc9t8BWXkoPZbikXXd2n9dZL+wRKRnPKrZg9gz53TydpKNhHdT8bWMgYjfYBV+ln+UUNTVZ4uorzfCbUHjRB7r6tKDjelA32QILQ8KYW8E8+O9e2+Ghxp+AotC7myLWXvCSVX0F05Bg2Q3uHuSDwXNPgRTRNPBn1QgCWBhuBJ94rWHtGFMF2uAuhnFBj1jHnzpHkWzE52oK5dUHXSGbe0AqrM6C5bm2GTL/GqiYLiQyKE4G/R6JLpJUIMf6ZMoJtkZEnWliQNbKH2FdFlh0V01Tc/XuZSJDyl48wsl4wtlmKuYx/XUU9JiZfFpludKGJqRTdbDm6DkJWh/ManofvXnabmN4w98zKDz2BVq0ZBtHDrZ3Yy8F6qAE8qcN7HY5CchMmL8+sRmgnHKTTLpb4CxDfWeLCxnfOkttb7+OADX2MBrV/D6hDuVSjavk8mvUwLZoickRUc/XTR9rCTYuvEkQnahaiuzssX3P/fjj0SNgrIaMba+XKMk36RfkDZNXCUgIBtclWEwhHXM3R/p5HtwO35MdkAJfrOylvekEhXrQSWD+ffzBv5U/rf+U6TN8FHdrCcmwGhBEizUy/yabwvIWgL80x+pflMd1jD8TgvcfmCwI9RzJG/6kGEmR5/cs1CawJ0SXmUag==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8278.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M3RuemFPdGRTVjFKMXZBekgrQ3R6VE9YdXJ3V0k0M0c0WEh1MXBiT3lKR3Rw?=
 =?utf-8?B?bkYzbHBRSXZSNTIxOVBNY0NpTk15ejFwcnpHWmJvakhTeTFiN0xqVXFMNHB6?=
 =?utf-8?B?NE1MUGQwTGFvTXo1cWhqQUdtOThVdE5HRGtqVkZtSGdITVFqU3ZJNkFrcW55?=
 =?utf-8?B?aytmWmszclVQMTB6cWltL0hPckRzcjRJbm9xRDRYSnhUMWNBNm40c3g5YWl5?=
 =?utf-8?B?bzdLdTlYUnZ5aDJkZkN0UjQzcGp2dE5veEh2ZzZVQXpKa2VGUGJNM1ZkeEs4?=
 =?utf-8?B?UFZCa1Q5bzRsaVErdndIRC82OVM1ZEZqRjVnRENwT3F2S2piRHlIREJlck5S?=
 =?utf-8?B?dStVQXppa3JPRjBWQ3pWZzZMZ09oOEUyNHdmdW5NSnBPNjFqelJIMDlpekRO?=
 =?utf-8?B?OGR6bEhlckcyVXpULzVwdHE5MDhUQzdjN3luWllKOEpYRXVmMW1XTGM4UG84?=
 =?utf-8?B?RmhwdHN3L0FvRHREWG9pMTZjWFJ6QjFGb3J6UklNdjJNM3NFYkdDNW44dHlG?=
 =?utf-8?B?NGR0MmNUdXJxMnVYaTNpb3lHcEtOYUpSbDAvWEg1K1pCY0tPS2tIeitZK2gw?=
 =?utf-8?B?REdWa1ZaQ2V1VS9TUndMM0ZjSmJBTGkvSGs2Ly91cUtGclpPK3ZyOGNnM2FX?=
 =?utf-8?B?Y1ZWdzQ3WTZBSks1Unk5OVhZUDV1S3orMjlKU1pQeEsvRmZ3UEl4TFE5YUpv?=
 =?utf-8?B?dmh2SVFKakpHVXFDNkF6SlEvQVZlNTltZHYzek5kZ0pqQjQrRE9YU0lxeE1x?=
 =?utf-8?B?Y0hCZHF2S3NKMnF6Y0xJRlhtNkpRWW9jOHNKOW1WWDlYYWYrWThhY0V5cUZa?=
 =?utf-8?B?TWxZY2ZxRFRaZ0l6a043eUFEWWtoNzhZWnRvRnIxNVV5M283NmJaTjZuL2pw?=
 =?utf-8?B?Z1ZYNVZTc25zWWIwYy84R1JtalkzR2YvRzF4aEpHR0lsTUNSTUZOaHJ2bEJ2?=
 =?utf-8?B?dzY4bjlUbGtJZmhMdzhuRlZ2RXdhYm5BR01iYmZaNW5sLzgyMTRJZUZ3OFFn?=
 =?utf-8?B?RnAxWFhBM0JQbEdSVk5RRFc1dXMzb3JSQWpWeFJyRlRYOTZmejUxcmxWU0wy?=
 =?utf-8?B?akRPVEtTVkhlZjZ3VVRWVlFNWXI3VTBHa25FNGh1L0c5bEx4UEJraDFwbENo?=
 =?utf-8?B?UEswU20valFKc3NZclRqZFpGdUlPRnFkVmQ3NEU3eGVMcTZDMk5PR3BuL1BN?=
 =?utf-8?B?OTJyaEVKZVBqQkVqUDFiRUJ0MWF6Y2VBeUdxQ0VFZGR3SWhzOXRoMENianY1?=
 =?utf-8?B?WkdKb1FCRmY4cCs5TTc4cFMxd09meHI1a25yeWg5TlpJV3NqaXJBYk9zSFdm?=
 =?utf-8?B?K056VVRjY1U4aks0Rkhnd2ZzZ2htaWNFMlg5Z0Fwb01NeHgyZFNtUy9kUCsr?=
 =?utf-8?B?UFVldThMczIvMzd5T0U2aG45VmIvdFdxNjc1UTlUbDRYVVYrTFhQUzNCQXYv?=
 =?utf-8?B?Nmd0eStHMzhjbHcwS09NbkFKNTNvSThWNUswekFiUGx3RkJieEFyRnNlWHp6?=
 =?utf-8?B?cnd5REFqTS83eEdjVVR4Z2lIdEFwajE4eDd2eXhNR0Q5VElpRE91VGNrdmtW?=
 =?utf-8?B?SGhCb0lid0h2OHVjcXFFRmtxMkM5WEcrZm5GL1RwQWhCdytla3Zxa25jc0lz?=
 =?utf-8?B?MlhDc1hqeEx4cW1rYWh4bTZSOEtjazRYZGdiSUs5NisyOFEvM0hmQW0wKzVi?=
 =?utf-8?B?Q3hjK0syN0h6NDJoTHh2VThENGlHRVRlRmFKRXVnS3l6U3RIRlVPbTZWakM3?=
 =?utf-8?B?dG5BelI3WEY1cUU3dmhEbDQ4bjBvaTF5VW1TTVQvV2J4Q1NWUnBFM01QcENh?=
 =?utf-8?B?K0Z4RFRQbTF2YzlUNm9rMitjdU9qMGJjVTVHQ2wrazNWRU9NV29EZkFvNWtZ?=
 =?utf-8?B?SjliNFlSa2grbzgzT1BvWWlldzdVZ014SUZIRGlEcDU3UmxKeUlLSjlFMVdF?=
 =?utf-8?B?cmdPRXdZZ09ma29vUis5S3RIQno2MXNyL0ZJOFhTL29pUHUzUUE5eDNJOFNw?=
 =?utf-8?B?MEVsYzc4Qm9zUUV3VW1Zb0VCS1JpOTdsS1I4WVZBS2dqaEx6VVhWdmtZc2oy?=
 =?utf-8?B?YUZGZncyUEc2Y2s1a2FaWDI4TmhhUndyUm9UMEpHV3V4MmdvelM1Nm5KRjUr?=
 =?utf-8?B?SkJ3UkpMakd4RHdJdDlrYUx6SDg0VkJFeUhlV1pYM2lPU3FabjR3WWdKbmVR?=
 =?utf-8?B?YWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <891B724EC20FCF43AB165A05E3730D05@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54a610ea-002b-46d8-6dab-08dc3f494fe6
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2024 08:25:28.5072
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ihEFuDqNDIvWLrgvQoZS2nf8x6dKHOl4QogEwEazNeVLsKC4FlBbNUmjv+nkBlyOZnYeEpTvgaQiYrb8Y3jJSpr2a7O5wPTlKNYV+Qca4S3Wm/gg2NI37s4HBqIMaP/H
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4785

SGkgQW5kcmV3LA0KDQpPbiAwNy8wMy8yNCA2OjU0IHBtLCBBbmRyZXcgTHVubiB3cm90ZToNCj4g
RVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVu
bGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPj4+PiArc3RhdGljIGludCBv
YV90YzZfcmVhZF9zd19yZXNldF9zdGF0dXMoc3RydWN0IG9hX3RjNiAqdGM2KQ0KPj4+PiArew0K
Pj4+PiArICAgICB1MzIgcmVndmFsOw0KPj4+PiArICAgICBpbnQgcmV0Ow0KPj4+PiArDQo+Pj4+
ICsgICAgIHJldCA9IG9hX3RjNl9yZWFkX3JlZ2lzdGVyKHRjNiwgT0FfVEM2X1JFR19TVEFUVVMw
LCAmcmVndmFsKTsNCj4+Pj4gKyAgICAgaWYgKHJldCkNCj4+Pj4gKyAgICAgICAgICAgICByZXR1
cm4gMDsNCj4+Pj4gKw0KPj4+PiArICAgICByZXR1cm4gcmVndmFsOw0KPj4+DQo+Pj4gVGhlIGZ1
bmN0aW9uIG5hbWUgZG9lcyBub3QgcmVhbGx5IGZpdCB3aGF0IHRoZSBmdW5jdGlvbiBkb2VzLiBU
aGUNCj4+PiBmdW5jdGlvbiByZXR1cm5zIE9BX1RDNl9SRUdfU1RBVFVTMC4gSSBhc3N1bWUgaXQg
aGFzIG1vcmUgYml0cyBpbiBpdA0KPj4+IHRoYW4ganVzdCBTVEFUVVMwX1JFU0VUQy4gU28gZWl0
aGVyIHRoaXMgZnVuY3Rpb24gc2hvdWxkIGJlIGNhbGxlZA0KPj4+IG9hX3RjNl9yZWFkX3N0YXR1
czAsIG9yIHlvdSBzaG91bGQgbWFzayByZWd2YWwgd2l0aCBTVEFUVVMwX1JFU0VUQywgc28NCj4+
PiB0aGF0IGl0IGRvZXMgYWN0dWFsbHkgcmV0dXJuIHRoZSBzdyByZXNldCBzdGF0dXMuDQo+PiBP
aywgYXMgd2UgZG8gdGhlIG1hc2tpbmcgaW4gdGhlIGNhbGxpbmcgZnVuY3Rpb24gcmVhZHhfcG9s
bF90aW1lb3V0LCBhcw0KPj4geW91IHN1Z2dlc3RlZCBJIHdpbGwgY2hhbmdlIHRoZSBmdW5jdGlv
biBuYW1lIGFzIG9hX3RjNl9yZWFkX3N0YXR1czAgaW4NCj4+IHRoZSBuZXh0IHZlcnNpb24uDQo+
IA0KPiBPLksuIEFuZCBpIHRoaW5rIHNvbWUgb2YgdGhlIGxhdGVyIHBhdGNoZXMgY2FuIHRoZW0g
bWFrZSB1c2Ugb2YgdGhpcw0KPiBnZW5lcmljIGZ1bmN0aW9uLg0KWWVzLCBtaWdodCBiZSBoZWxw
ZnVsLg0KDQpCZXN0IHJlZ2FyZHMsDQpQYXJ0aGliYW4gVg0KPiANCj4gICAgICAgICAgQW5kcmV3
DQoNCg==

