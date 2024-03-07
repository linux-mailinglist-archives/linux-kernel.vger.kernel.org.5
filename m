Return-Path: <linux-kernel+bounces-95756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE3F875216
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 15:42:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 416901C218CA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 14:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEE3C1EB40;
	Thu,  7 Mar 2024 14:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="DDAlmN3I";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="wgGWMKAf"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58561E868;
	Thu,  7 Mar 2024 14:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.154.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709822534; cv=fail; b=eVr04VY5R89m2ok7DTqkUiecmQ++WcaBQIiqRLegA4F+RW6/amQRarzjUZzVnR78fbVDX90HL/wvLYSPzjfufVm6u3oZwIOvHJ+vfYC5fQvy6Gw1bCZwYwwSREJXZB8yJ8Uie+OTwooMWlsmGZJygmcIpYln9A9/qpKgX1AWOKM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709822534; c=relaxed/simple;
	bh=4tuuRWF11cZz79+IyozTKv8izKxTEYU2QDfQzL6F5sg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CtngfAIwVCfq/+AHeZm8tEgiYnig32aHT78P/NLBuZFXttMcbkNnya0StihW2WDQ6hPDNyv0sLOndaUMEI79Q8yCcaEkmRWpibPrNGBMMepR4+5kIAnnTG0FsMvbitqTCnqiq2+ripp+jRs1iUvdVEW+poWqKG7VuvfMf/PNhgg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=DDAlmN3I; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=wgGWMKAf; arc=fail smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1709822531; x=1741358531;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=4tuuRWF11cZz79+IyozTKv8izKxTEYU2QDfQzL6F5sg=;
  b=DDAlmN3I/HPFXn08ORCf9ghVRCqqPVL4xwLF1jCXAKCnmBpohxbr3qNp
   H27RipJcpsXiUJGQClo7grHzo+lL5SZJ4rr77UJlBXNZa7oTddJDPUQha
   X0wVr9B8nwtTN96S9Y2fYjKMW+X6HfPxSsBp7aVnyXmDcsv4iO57gugKQ
   vm5MDTCdSxwixBYzDywi73N+wIGlYaBy+UL7AcVLfR8Dcyrinnvz0x6Ki
   4BtaqAdMJOZ7Ez+f6RU8mSD3zAjRM27f7jhaN4dNTx3UP5p/w/NlNfthJ
   W9T5Q9UohD92Xynvr3EI0J+QBW3JuZ0lnDBV+pMpyYwmauLqGgcuqB0X7
   Q==;
X-CSE-ConnectionGUID: Fgs7ufuHTEGUwiYLNmM6rg==
X-CSE-MsgGUID: lBfFzEvsR/mduKt1YLP8Og==
X-IronPort-AV: E=Sophos;i="6.07,211,1708412400"; 
   d="scan'208";a="17885049"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Mar 2024 07:42:09 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Mar 2024 07:41:33 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 7 Mar 2024 07:41:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dQtyiDTB5HY8G6LJYlGcqrZfRS3OCpmFN77QAMBkaKnBu3aEED7KpR9z6ERGSeD3F+F6WG3C1nKCONpMuN9INJSTTuUlDi/+EkVug/pXd2Aj8vzGNozHx/5uZAMoJZ/2En5CwfP7G0ySeDNK6FYCRHMXA/aUKoGSwrLpIXd1VLE50fWelLG1/wYXw8U04F9QaSn3xzrBEIZDkqRZRIRPddrVIR10EVH+TiYN9LkvVLW/UACcgf2Ft8NSSgx7IaPx3UpfTxKCNxrUDyP8dNWloNQqydvsy/8Ouqimpi1TBlYCGhzx05pfgdg/3ddeLXw+TwSiAm5LZLvNQ56+IXrIpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4tuuRWF11cZz79+IyozTKv8izKxTEYU2QDfQzL6F5sg=;
 b=Cp/GUIlw4quqzh85UcbLC1/7kUUiM4t74Q2YVpl9xvfoogi38eyFY8IqRd6cVPgx0TR1XytIOgWRYXNdslXEb86+MmAsXzWDGKYPIlVN9SbDpASVUkc4bWJ/MiqoeyzlROwbCFSptrK47tGS5RcLmFG2VdEpiAESg/5PHvhCNd+Iq9zrQVtYoebYA9guI/u5iLPAvc8gQvIqBwwDP59TBL05MiEGFc+CkH2S9TfNNR6x9Ta3h9ElZG6egB8duBd59as0rqcP2hl4jgLa6pMPbnsLF1LqgG8kzpljvMHQjuqGPsPOl2bHk5R4XXgxqrb9UrOCqjQnKeGPj+hJPPUsaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4tuuRWF11cZz79+IyozTKv8izKxTEYU2QDfQzL6F5sg=;
 b=wgGWMKAfzc5i8QpybUZ0RcwNg9iwDIpDL5QQWwGR7oBcOn4zoVVYibSvBNLBzxkusf6mm8jZjKYwo2lUNyl3jj8R7QsxQ2OIbkgG62r2/4TCZBEuu5kos1piGWBIBuyVMdDXuDCbjPi1WwCtqFbL7d+6X0hg2xFTCtOL+1awIcZP77GF1DTZHL8UW2gsH/IVAilomOuhKnQQPleqs0zHzofhjHLQRWcxYPs9g0+h6DmM//sbpsaD6h1zqMRdiR2YZM/jL75VHviFV5NdxU9PStMQZKQT5FRxOhX8SWLgT76nLpb8TxEKtvZUcQ2Xe7G8YuAPlsuGE1Zs/zD5xM07Bw==
Received: from SA1PR11MB8278.namprd11.prod.outlook.com (2603:10b6:806:25b::19)
 by MN6PR11MB8147.namprd11.prod.outlook.com (2603:10b6:208:46f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.9; Thu, 7 Mar
 2024 14:41:30 +0000
Received: from SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::f633:b9d4:f539:177d]) by SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::f633:b9d4:f539:177d%6]) with mapi id 15.20.7386.006; Thu, 7 Mar 2024
 14:41:29 +0000
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
Subject: Re: [PATCH net-next v3 06/12] net: ethernet: oa_tc6: implement
 internal PHY initialization
Thread-Topic: [PATCH net-next v3 06/12] net: ethernet: oa_tc6: implement
 internal PHY initialization
Thread-Index: AQHab6OHj5kLkYW7WEGlK1Xe+8KWTLEregYAgADhwoA=
Date: Thu, 7 Mar 2024 14:41:29 +0000
Message-ID: <eeb57938-e21e-406d-a835-93c6fb19b161@microchip.com>
References: <20240306085017.21731-1-Parthiban.Veerasooran@microchip.com>
 <20240306085017.21731-7-Parthiban.Veerasooran@microchip.com>
 <8c2b95f4-75a7-4d6d-ab9c-9c3498c040d8@lunn.ch>
In-Reply-To: <8c2b95f4-75a7-4d6d-ab9c-9c3498c040d8@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8278:EE_|MN6PR11MB8147:EE_
x-ms-office365-filtering-correlation-id: 88efc6db-1f6e-4aac-93a3-08dc3eb4ad0f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CMIn3q4i/ZZztbBexDg/v32BfGvc02Co1JRicc0k7mDgkRLxprgb93dRsf3o2W3TKE/7NrFfkc5fyR39O+mNDgFz+7LwSeRsDoWWIE9gxJ7XGW9K8rkbbI35wdRb40Ol0nSw3GqkEuQ+OD7JsDlr02x1mtTcKzISw3Z0J6MSSrow5JU/zmzUprfmTVbILC92oDeHSCNvsXTlASiTiGwQkQxoIBeGydsTNCX35nQSHvQ+KPw7eXhMiie7t7LgTDqsWFal4klBb5Bsg9wv//p+I7K3yxzmNMCXGp8V+CuNLhKptYDH3CR53/mNoG6kNOSVi+T6fXzRC5qzOg0Uq0tCdjrS1D9p3T97S0qINFdAXBVcG+7hPmAAvPB4a0Us6E9HvuxLzAvPpmmQ9USBmDOqAY/2GrqEwm5QtxzT+xo1NGGrDu27l89O5ibYQ3m7CF4og/W5y2FuuDT5kVMyQoXsluMswo5p1GVw6r26aOlGplZUfCSIw6X/vuCj5hys6ktW+QM31pq0QktxZsy7fmQ4Up1/pUZMSToJqyFj9f8bLpWnglYe2bP5Ag8fFyGhTvPsikn8Pedo4YTuvzdeHhH10dhHHFICFn6kFA2WPnz123v1Bu2Qic7zZdbkS6bVYEkMR7GsfzXjqrBBV+6UjgD4RZLzau7eAL8Z7FVkwE8kwDUcOXo37hHydlriVrIZTpF6RGNLAjd3xjLvS555EQyiXSmGV0Yd/kzBr6OpZxslKWI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8278.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SDNvVUlOeGZvQk1mR3cwUlhqSXlLSzlvOWRSZXI4bzU0L1JKRWtNT0p2TExu?=
 =?utf-8?B?RmxiSXU5VzVYRTFjSE41RFhjOVB4cUlpOUpRU3gwZHlSVjNXc2pvTFMzSERO?=
 =?utf-8?B?d1hQL1doLytEb3NzM2pJUnZ0WFo2WEQ0NFJNSDJBdDh3Y0x3amM3VzRUcnF5?=
 =?utf-8?B?K3Nmb3JaTWRnWUpzaDVWNWQ4d0tkY0NxdUZsMFhHa3Z0SmdYUkNBNllLRTNL?=
 =?utf-8?B?d1pyWS9nNGV1SWk5SmQvQUJDbFlaSllmWDZvTURDeE5DTmxCS2p0dnduTys3?=
 =?utf-8?B?MU1QUFBnZDU1dklibU5MdnZyK3RaUHd5TmhHNHp2clBDaGdwTGV3L2pFSGo1?=
 =?utf-8?B?aGczUytBcWRHaGhuY0NUcW1HUUpIWWdxTXZ6WVJac3VhQmRreHdESHZrZXll?=
 =?utf-8?B?bHI0NjRLbWtqQng4NVVPaVhDck5qSnMzenNXS0dVblFNS1VPa2xYcFpwRVlE?=
 =?utf-8?B?SitLd3hGdU5KOEdMaUNvRW5XcGZ0ayttWW56QWI4OFpvdzAxZmlUcUl0MDli?=
 =?utf-8?B?SVNmb3kzQzVIVFllT0FHdElBVE9ZbFd5NElPZUdQU0tkcktCaDlPUnFITzZu?=
 =?utf-8?B?cnRiMUpmekFIcmQzWG1sUDNqVC8xM3d0Q1pTTG1XbE5LUmhFNFdTSDdPMzFq?=
 =?utf-8?B?MEhNVU42TjVsWURQUWFXd0M0YnpzM2tzRWw1N01Oc0MrZGpFZ09xMjVvMjlH?=
 =?utf-8?B?VnNEM0JQWkRqTis0WkU5Qit1bkg0L1BEYi9IV2wwb21sd21tSTVQblEvMFJs?=
 =?utf-8?B?UTF5SWwyNlBZSjdENFMwQjJiN3MrN2N3WlB2b2htZXZjRExQSFdzLys4QnZN?=
 =?utf-8?B?YlpHd2lkd2paZ1NYZ0x0dEZZM1lyUW5WdUROZEFUY0pNSkZ1U1hVZFJjNWRp?=
 =?utf-8?B?bmRPQ2R6aXU4cEZVeU9VM21JWEpSaXNmSWtLTFMvdUsvOC80NXJsZjdXbDhH?=
 =?utf-8?B?QTlCM2RDejU4S2VUUFRxaCtwYUtSditvd3ZyYkhWVG1JWENtbVNCS2g1L3Qz?=
 =?utf-8?B?N0VxTElRSlo0L251KzM4UzBxbDU0KzVPeUMxNmVTdEFkWGVnTEhBZGlYT2pj?=
 =?utf-8?B?QnZTQTNOQjczLzJLcitESjlHcWNkTFI2OFRiTGhnODFwKy9jQ3BxMFVDQjdY?=
 =?utf-8?B?UGNTdjlOMkY4TTI2dktXWmhzVk5icVRqY3ptQkE2ZTIvaEd4MXppMy90ZERp?=
 =?utf-8?B?VHArTUZuYUc4dmYvNmk2VmJDNVV1a2VEbGo0Yjd2VXpnemRHYTN2V21wUjBR?=
 =?utf-8?B?bWloUlh3ZFJ0WXYwZ3BybHE1U1NSV0RMYXk3ZEo3UVZYRFI3TXVqM3ZZMmUz?=
 =?utf-8?B?WmU0TzUraGx6MVBGdnpJeXliZDFsZGtJK0J0dlQrNVV0NXkybm9yU1hzQjFt?=
 =?utf-8?B?WkFWVzJsUEpJL1RubmRjNEZUZXpCdUJIK1FYQ1JqZVhRaFhOdGY0cklqOVZz?=
 =?utf-8?B?eVZCTWxVd2d1UVFRY1RGRm5NdVFmRUd3cldIb2krTW50ZSt2bU80dUF4VHJz?=
 =?utf-8?B?STAyZ0FkZ3RTQnVlYmttMUtmdXFVVTlMMFVWTy9QbTNIK05UaFRmNjBvSEI4?=
 =?utf-8?B?K3YvQUdvYnpuQkxwbUlkeGNFYUN5T3MreGs5L0dTSDZDdXYzVHBNeUNrQjhV?=
 =?utf-8?B?MTRidXdhcXEvSUpkRmNnd1dzNWtTanNPUGpKc1U0ekUxYWgzSk55ODVNRGJu?=
 =?utf-8?B?VzlveHp0M0JhVzJXYlEyZlMxcXJEczJUUHczemxVenJ4eVVpZWNTNllrdkdP?=
 =?utf-8?B?WDBRSWt6WW91a1ZYVnNjOXRSWVJNNWNDN3dpdVRHTXc1cjFLR2xmb2lWbEo1?=
 =?utf-8?B?Q283N0xWbmNYNDI4cGtiV0pxaCtpcTlwYTFSUkM3d3B3VFh4TGtEeWs4RFJG?=
 =?utf-8?B?U09SYWM2QWR4ckp2c2hHK0VtM3dqR2ZZREpCTVRFYmYrVDJKYmhoek5JdmxY?=
 =?utf-8?B?QnhnZVpCVjN6VytaN2MxbjRzTDN4ZlVyWm1mRy9ucTdHZC9NV05Da0c5azA4?=
 =?utf-8?B?djJ5dnFXcWZNV0VBbkloc0F4QUttaHlna205bTExbTUzQW1UZXJQRW9FM3oy?=
 =?utf-8?B?L0xBaE1wWTFHOHk3bU01OWRZYWtCQUo3aXZ4cnlOdlVhb08xT2IxK0xSclN1?=
 =?utf-8?B?TUduM3A2T2puR1BGQyt0YzlXRzFISlRMWjBVZDdmUktCbTlCR3NpaERwcVVJ?=
 =?utf-8?Q?fVqOjCLb8qbB5lJ9uz2LdNk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1854EEEECE0F3445A88EA599B3CF7ED5@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88efc6db-1f6e-4aac-93a3-08dc3eb4ad0f
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2024 14:41:29.7885
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: alNJ/v4jrRzrj52hGEMIwLWyRgjE7FQPLfpYH9lxPXp8Acs9Sot1cGMVIaSve7Rgy9rJoG64MnkfLwb/+9eZpH07h5EK/ogILuchKRB4KQaPdIUiPYn1HWcwKH8wYCZj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8147

SGkgQW5kcmV3LA0KDQpPbiAwNy8wMy8yNCA2OjQzIGFtLCBBbmRyZXcgTHVubiB3cm90ZToNCj4g
RVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVu
bGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPj4gKy8qIFBIWSBDbGF1c2Ug
MjIgYW5kIDI5IHJlZ2lzdGVycyBiYXNlIGFkZHJlc3MgYW5kIG1hc2sgKi8NCj4+ICsjZGVmaW5l
IE9BX1RDNl9QSFlfU1REX1JFR19BRERSX0JBU0UgICAgICAgICAweEZGMDANCj4+ICsjZGVmaW5l
IE9BX1RDNl9QSFlfU1REX1JFR19BRERSX01BU0sgICAgICAgICAweDNGDQo+IA0KPiBbR29lcyBh
bmQgbG9va3MgYSA4MDIuM10NCj4gDQo+IENsYXVzZSAyOSBpcyAiU3lzdGVtIGNvbnNpZGVyYXRp
b25zIGZvciBtdWx0aXNlZ21lbnQgMTAwQkFTRS1UIG5ldHdvcmtzIg0KPiANCj4gSSBkb24ndCBz
ZWUgYW55IG1lbnRpb24gb2YgcmVnaXN0ZXJzIGluIHRoZXJlLg0KPiANCj4gVEM2IHNheXM6DQo+
IA0KPiAiQ2xhdXNlIDIyIHN0YW5kYXJkIHJlZ2lzdGVycyBhbmQgQ2xhdXNlIDIyIGV4dGVuZGVk
IHJlZ2lzdGVycyAoQ2xhdXNlDQo+IDI5KSBhcmUgZGlyZWN0bHkgbWFwcGVkIGludG8gTU1TIDAg
YXMgc2hvd24gaW4gVGFibGUgNy4iDQo+IA0KPiBHb2luZyBiYWNrIHRvIDgwMi4zLCB3ZSBoYXZl
IDIyLjIuNDoNCj4gDQo+IFRoZSBNSUkgYmFzaWMgcmVnaXN0ZXIgc2V0IGNvbnNpc3RzIG9mIHR3
byByZWdpc3RlcnMgcmVmZXJyZWQgdG8gYXMNCj4gdGhlIENvbnRyb2wgcmVnaXN0ZXIgKFJlZ2lz
dGVyIDApIGFuZCB0aGUgU3RhdHVzIHJlZ2lzdGVyIChSZWdpc3Rlcg0KPiAxKS4gQWxsIFBIWXMg
dGhhdCBwcm92aWRlIGFuIE1JSSBNYW5hZ2VtZW50IEludGVyZmFjZSBzaGFsbA0KPiBpbmNvcnBv
cmF0ZSB0aGUgYmFzaWMgcmVnaXN0ZXIgc2V0LiBBbGwgUEhZcyB0aGF0IHByb3ZpZGUgYSBHTUlJ
IHNoYWxsDQo+IGluY29ycG9yYXRlIGFuIGV4dGVuZGVkIGJhc2ljIHJlZ2lzdGVyIHNldCBjb25z
aXN0aW5nIG9mIHRoZSBDb250cm9sDQo+IHJlZ2lzdGVyIChSZWdpc3RlciAwKSwgU3RhdHVzIHJl
Z2lzdGVyIChSZWdpc3RlciAxKSwgYW5kIEV4dGVuZGVkDQo+IFN0YXR1cyByZWdpc3RlciAoUmVn
aXN0ZXIgMTUpLiBUaGUgc3RhdHVzIGFuZCBjb250cm9sIGZ1bmN0aW9ucw0KPiBkZWZpbmVkIGhl
cmUgYXJlIGNvbnNpZGVyZWQgYmFzaWMgYW5kIGZ1bmRhbWVudGFsIHRvIDEwMCBNYi9zIGFuZCAx
MDAwDQo+IE1iL3MgUEhZcy4gUmVnaXN0ZXJzIDIgdGhyb3VnaCAxNCBhcmUgcGFydCBvZiB0aGUg
ZXh0ZW5kZWQgcmVnaXN0ZXINCj4gc2V0LiBUaGUgZm9ybWF0IG9mIFJlZ2lzdGVycyA0IHRocm91
Z2ggMTAgYXJlIGRlZmluZWQgZm9yIHRoZSBzcGVjaWZpYw0KPiBBdXRvLU5lZ290aWF0aW9uIHBy
b3RvY29sIHVzZWQgKENsYXVzZSAyOCBvciBDbGF1c2UgMzcpLiBUaGUgZm9ybWF0IG9mDQo+IHRo
ZXNlIHJlZ2lzdGVycyBpcyBzZWxlY3RlZCBieSB0aGUgYml0IHNldHRpbmdzIG9mIFJlZ2lzdGVy
cyAxIGFuZCAxNS4NCj4gDQo+IFNvIGNsYXVzZSAyOSBpcyBub3QgbWFraW5nIG11Y2ggc2Vuc2Ug
aGVyZS4gQ2FuIGFueWJvZHkgZXhwbGFpbiBpdD8NCj4gDQo+PiArc3RhdGljIGludCBvYV90YzZf
bWRpb2J1c19yZWdpc3RlcihzdHJ1Y3Qgb2FfdGM2ICp0YzYpDQo+PiArew0KPj4gKyAgICAgaW50
IHJldDsNCj4+ICsNCj4+ICsgICAgIHRjNi0+bWRpb2J1cyA9IG1kaW9idXNfYWxsb2MoKTsNCj4+
ICsgICAgIGlmICghdGM2LT5tZGlvYnVzKSB7DQo+PiArICAgICAgICAgICAgIG5ldGRldl9lcnIo
dGM2LT5uZXRkZXYsICJNRElPIGJ1cyBhbGxvYyBmYWlsZWRcbiIpOw0KPj4gKyAgICAgICAgICAg
ICByZXR1cm4gLUVOT0RFVjsNCj4+ICsgICAgIH0NCj4+ICsNCj4+ICsgICAgIHRjNi0+bWRpb2J1
cy0+cHJpdiA9IHRjNjsNCj4+ICsgICAgIHRjNi0+bWRpb2J1cy0+cmVhZCA9IG9hX3RjNl9tZGlv
YnVzX2RpcmVjdF9yZWFkOw0KPj4gKyAgICAgdGM2LT5tZGlvYnVzLT53cml0ZSA9IG9hX3RjNl9t
ZGlvYnVzX2RpcmVjdF93cml0ZTsNCj4gDQo+IFRoaXMgbWlnaHQgZ2V0IGFuc3dlcmVkIGluIGxh
dGVyIHBhdGNoZXMuIFBMQ0EgcmVnaXN0ZXJzIGFyZSBpbiBDNDUNCj4gYWRkcmVzcyBzcGFjZSwg
VkVORDEgaWYgaSByZW1lbWJlciBjb3JyZWN0bHkuIFlvdSBkb24ndCBwcm92aWRlIGFueQ0KPiBD
NDUgYWNjZXNzIG1ldGhvZHMgaGVyZS4gRG9lcyBUQzYgc3BlY2lmeSB0aGF0IEM0NSBvdmVyIEMy
MiBtdXN0IGJlDQo+IGltcGxlbWVudGVkPw0KTm8gdGhlIHNwZWMgZG9lc24ndCBzYXkgYW55dGhp
bmcgbGlrZSB0aGlzLiBCdXQsIGFzIEMyMiByZWdpc3RlcnMgYXJlIA0KbWFwcGVkIGluIHRoZSBN
TVMgMCwgcmVnaXN0ZXJzIDB4RCBhbmQgMHhFIGNhbiBiZSB1c2VkIHRvIGFjY2VzcyBDNDUgDQpy
ZWdpc3RlcnMgaW5kaXJlY3RseS4gVGhhdCdzIHdoeSB0aGUgZHJpdmVyIGltcGxlbWVudGVkIHRo
ZSBhYm92ZSANCmZ1bmN0aW9ucy4gSSBhZ3JlZSB0aGF0IGluZGlyZWN0IGFjY2VzcyBpcyBzbG93
ZXIgYW5kIHJlcXVpcmVzIG1vcmUgDQpjb250cm9sIGNvbW1hbmRzIHRoYW4gZGlyZWN0IGFjY2Vz
cy4gU28gaW1wbGVtZW50aW5nIHRoZSBkaXJlY3QgYWNjZXNzIA0Kb2YgQzQ1IHJlZ2lzdGVycyB3
aWxsIG92ZXJjb21lIHRoaXMgaXNzdWUuDQo+IA0KPiBUaGUgc3RhbmRhcmQgZG9lcyBzYXk6DQo+
IA0KPiBWZW5kb3Igc3BlY2lmaWMgcmVnaXN0ZXJzIG1heSBiZSBtYXBwZWQgaW50byBNTVMgMTAg
dGhvdWdoIE1NUw0KPiAxNS4gV2hlbiBkaXJlY3RseSBtYXBwZWQsIFBIWSB2ZW5kb3Igc3BlY2lm
aWMgcmVnaXN0ZXJzIGluIE1NRCAzMCBvcg0KPiBNTUQgMzEgd291bGQgYmUgbWFwcGVkIGludG8g
dGhlIHZlbmRvciBzcGVjaWZpYyBNTVMgMTAgdGhyb3VnaCBNTVMgMTUuDQo+IA0KPiBTbyBpJ20g
dGhpbmtpbmcgeW91IG1pZ2h0IG5lZWQgdG8gcHJvdmlkZSBDNDUgYWNjZXNzLCBhdCBsZWFzdCBN
TUQgMzAsDQo+IHZpYSBNTVMgMTAtMTU/DQpUaGFua3MgZm9yIHRoaXMgZGV0YWlsZWQgY29tbWVu
dC4gSWYgdW5kZXJzdGFuZCB5b3UgY29ycmVjdGx5IGJ5IA0KY29uc29saWRhdGluZyBhbGwgeW91
ciBhYm92ZSBleHBsYW5hdGlvbnMsIHRoZSBkcml2ZXIgc2hvdWxkIHByb3ZpZGUgQzQ1IA0KYWNj
ZXNzIHRvIHRoZSBQSFkgdmVuZG9yIHNwZWNpZmljIGFuZCBQTENBIHJlZ2lzdGVycyAoTU1EIDMx
KS4gQXMgcGVyIA0KdGhlIHNwZWNpZmljYXRpb24sIFRhYmxlIDYgZGVzY3JpYmVzIHRoZSBSZWdp
c3RlciBNZW1vcnkgTWFwIFNlbGVjdG9yIA0KKE1NUykgQXNzaWdubWVudC4gSW4gdGhpcywgTU1T
IDQgbWFwcyB0aGUgUEhZIHZlbmRvciBzcGVjaWZpYyBhbmQgUExDQSANCnJlZ2lzdGVycy4gVGhl
eSBhcmUgaW4gdGhlIE1NRCAzMSBhZGRyZXNzIHNwYWNlIGFzIHBlciBzcGVjLiBUaGV5IGNhbiBi
ZSANCmRpcmVjdGx5IGFjY2Vzc2VkIHVzaW5nIHJlYWRfYzQ1IGFuZCB3cml0ZV9jNDUgZnVuY3Rp
b25zIGluIHRoZSBtZGlvIGJ1cy4NCg0KSW4gTWljcm9jaGlwJ3MgTUFDLVBIWSAoTEFOODY1MCks
IFBIWSDigJMgVmVuZG9yIFNwZWNpZmljIGFuZCBQTENBIA0KUmVnaXN0ZXJzIChNTUQgMzEpIG1h
cHBlZCBpbiB0aGUgTU1TIDQgYXMgcGVyIHRoZSB0YWJsZSA2IGluIHRoZSBzcGVjLg0KVGhlcmUg
aXMgbm8gb3RoZXIgUEhZIHZlbmRvciBzcGVjaWZpYyByZWdpc3RlcnMgYXJlIG1hcHBlZCBpbiB0
aGUgTU1TIDEwIA0KdGhyb3VnaCAxNS4gTm8gaWRlYSB3aGV0aGVyIGFueSBvdGhlciB2ZW5kb3In
cyBNQUMtUEhZIHVzZXMgTU1TIDEwIA0KdGhyb3VnaCAxNSB0byBtYXAgUEhZIOKAkyBWZW5kb3Ig
U3BlY2lmaWMgYW5kIFBMQ0EgUmVnaXN0ZXJzIChNTUQgMzEpLg0KDQpJIGhhdmUgZ2l2ZW4gdGhl
IGNvZGUgYmVsb3cgZm9yIHRoZSBDNDUgYWNjZXNzIG1ldGhvZHMuIEtpbmRseSBjaGVjayBpcyAN
CnRoaXMgc29tZXRoaW5nIHlvdSBleHBlY3RlZD8NCg0KLS0tIENvZGUgc3RhcnRzIC0tLQ0KDQov
KiBQSFkg4oCTIFZlbmRvciBTcGVjaWZpYyBhbmQgUExDQSBSZWdpc3RlcnMgKE1NRCAzMSkgKi8g
DQoNCiNkZWZpbmUgT0FfVEM2X1BIWV9WU19QTENBX1JFR19BRERSX0JBU0UgICAgICAgIDB4NDAw
MDANCiwsLA0KDQpzdGF0aWMgaW50IG9hX3RjNl9tZGlvYnVzX3JlYWRfYzQ1KHN0cnVjdCBtaWlf
YnVzICpidXMsIGludCBhZGRyLCBpbnQgDQpkZXZudW0sIGludCByZWdudW0pDQp7IA0KDQogICAg
ICAgICBzdHJ1Y3Qgb2FfdGM2ICp0YzYgPSBidXMtPnByaXY7IA0KDQogICAgICAgICB1MzIgcmVn
dmFsOyANCg0KICAgICAgICAgYm9vbCByZXQ7IA0KDQogDQoNCiAgICAgICAgIHJldCA9IG9hX3Rj
Nl9yZWFkX3JlZ2lzdGVyKHRjNiwgDQpPQV9UQzZfUEhZX1ZTX1BMQ0FfUkVHX0FERFJfQkFTRSB8
IHJlZ251bSwgJnJlZ3ZhbCk7IA0KDQogICAgICAgICBpZiAocmV0KSANCg0KICAgICAgICAgICAg
ICAgICByZXR1cm4gLUVOT0RFVjsgDQoNCiANCg0KICAgICAgICAgcmV0dXJuIHJlZ3ZhbDsgDQoN
Cn0gDQoNCiANCg0Kc3RhdGljIGludCBvYV90YzZfbWRpb2J1c193cml0ZV9jNDUoc3RydWN0IG1p
aV9idXMgKmJ1cywgaW50IGFkZHIsIGludCANCmRldm51bSwgaW50IHJlZ251bSwgdTE2IHZhbCkN
CnsgDQoNCiAgICAgICAgIHN0cnVjdCBvYV90YzYgKnRjNiA9IGJ1cy0+cHJpdjsgDQoNCiANCg0K
ICAgICAgICAgcmV0dXJuIG9hX3RjNl93cml0ZV9yZWdpc3Rlcih0YzYsIA0KT0FfVEM2X1BIWV9W
U19QTENBX1JFR19BRERSX0JBU0UgfCByZWdudW0sIHZhbCk7IA0KDQp9DQosLCwNCg0KdGM2LT5t
ZGlvYnVzLT5yZWFkX2M0NSA9IG9hX3RjNl9tZGlvYnVzX3JlYWRfYzQ1Ow0KdGM2LT5tZGlvYnVz
LT53cml0ZV9jNDUgPSBvYV90YzZfbWRpb2J1c193cml0ZV9jNDU7DQoNCi0tLSBDb2RlIGVuZHMg
LS0tDQoNCkJlc3QgcmVncmFkcywNClBhcnRoaWJhbiBWDQoNCj4gDQo+ICAgICAgQW5kcmV3DQo+
IA0KDQo=

