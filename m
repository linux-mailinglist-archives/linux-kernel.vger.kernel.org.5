Return-Path: <linux-kernel+bounces-77999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9710D860DDF
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 10:21:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAA101C2104F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 09:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D42AA5C8E2;
	Fri, 23 Feb 2024 09:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="g5XE3YV4";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="rB3WKRju"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D561B1AAA9;
	Fri, 23 Feb 2024 09:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.153.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708680098; cv=fail; b=iT6U/EmmrpbZP1u408Ix0a2S7wWCzVu2Qx1u5SclM7W3/3LDG9yyVkCM4F/jhHT0A7qnN/wlW0vbCy7ACsvVgAEO5F/+O3tvE0blGRmsehOEESKzLBr7ggf+A3fUyq82chimzFCdCLBBpI/JGzyL//k/JrjJXk6lML0POsFqM30=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708680098; c=relaxed/simple;
	bh=B4va5lpbcA3s1eWB1LSY7kg+9heJ3x3+w1BjLMGWMmk=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=a+OM3JqViQtgNZnfzPBI4NcP8n8xBeBWOgYS0b/mkDtJ0KbEVdozk1gVpvfGeOLVzqbiXUCy0gCur8zGaDy3WvSRpHoviYoePD0HlqxLO/1JtlZwD5+6j1ahfW+lcl7hfz1rqwG2YaZ7wb7lS8rm18eTDTLA0XUageXhnOMkBco=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=g5XE3YV4; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=rB3WKRju; arc=fail smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1708680098; x=1740216098;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=B4va5lpbcA3s1eWB1LSY7kg+9heJ3x3+w1BjLMGWMmk=;
  b=g5XE3YV46bcCi7G1cBvbH32YjIG3jIW97JOwQi7xaP26sGj05q1NRY5d
   xnkjNfzH0zB1NZoNjE8wZZaysa1+fe62FoVs/Mv5spkdtNS5BjKYHKFI8
   cnGY0gOaoLxJ5DsN176aS0l1FmXQIx2tzt5+bj5t3O+6yr5jHsdFP3Qch
   vIeO6vauVCur6p2XdKghfSNhPhpn1lIw2PzcjDZBxfHPx1WgY5r4hnGHj
   XPOUH7WzHD/NIOYGkoBt6LYD1lOEpxOPOwkxpc5AV4OrIDEJaWf0VkNnM
   4Fmu9SOTRCnZOHgYXve173sPiKb76t/rbs0eGCb6O+lb/HgDQR2AhOJo5
   A==;
X-CSE-ConnectionGUID: 5spGbb/DQYaQGHuWzReuBg==
X-CSE-MsgGUID: xrMav4N8R3qPInlRhBSiAQ==
X-IronPort-AV: E=Sophos;i="6.06,179,1705388400"; 
   d="scan'208";a="16711570"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Feb 2024 02:21:31 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 23 Feb 2024 02:21:29 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 23 Feb 2024 02:21:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nvBhcuv8XbuNye0zaskVnOebsdbmGpEE29qdC72McTAlj4IBlzxpIOmIRl25bI1dGiP+ZsZnNcj806XOLmO2qWaKU4gbWOxN08tUsPyvIuwxxKoT+RVEC1XLJYmsFuNZ+fpUQ6YW+pl7NxIOc7BbuQSUw2FRW6zouMiKKOhulSAuCvwXEF4GIDPQVxQOYmV3xxqflnNpGm1YAmzGsi9pqC1b7f9VnAQLkC/AJWag+OO/iVWgalWQLq45CMzFoPgEKo5zQltCXxfWDGGKxvN+y1Neu4a1JHG3kKF/3JzY/c8jSulzF22ohgsDdD/QEUWy3rNe7lizRvamOtMoT97bTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B4va5lpbcA3s1eWB1LSY7kg+9heJ3x3+w1BjLMGWMmk=;
 b=BpSj3qJcRCcjViD7YXtPabmNyHYBpMQ7eM5jlzO881jJYI4Za4ngW/2rh2G/ARoi6EabWXeIvDoQ21gPT/ZqNJ47kLFOoc0xIGEqOubN8/gbDoHqDYWIakrx9aVfI2uYkX4QESEFAv7QXG84FkFaOcFojEa6pC8/BffUi4XDsk2DI1p89uRFFkQEA6245oLVxOBggtNepa1jsfCGFFBo67fvTYIUJMK2mGRHHCZAG2zr6jkzOtLEeJbv/wpQjlSYlFb9asLK+ccuFlCoiTq8F+LeUPxxn2OcsdM7nO8aa7vqMCKDGF1K9kaahOX9p9OlQ5A0v3VoooLuITHMCipstQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B4va5lpbcA3s1eWB1LSY7kg+9heJ3x3+w1BjLMGWMmk=;
 b=rB3WKRju0ElSJHO+avRYmqyjQMEu7Bf0k2wQgOPTOK3A2M+csrWdaAYyFDLii/hAHW/91D1n1DzUtriki/ewohwfQgdnBbKdZmANzwpL+LDMwR9phTWEgB0I/eEVY1jF5LOPYqEG9W4kdmnCPymvcSnnxD62IuZi33uMJ8qy/RLBy5uQlOU5+IeOqnEkvMFcQuzStukqeGpzpIGhBFu8By6eqZQOYyQ+0eriyIJ/N/wW1bdW9ma15NInZyKFbgay5Aq90GicM2UCAVlajh7VngpDFjxBJvWdZLmPOooe5KyNlMCoHl+TZA2Big9bEfkkmYFD58hLqLmM00W6dtxstg==
Received: from DS0PR11MB7481.namprd11.prod.outlook.com (2603:10b6:8:14b::16)
 by CH3PR11MB7761.namprd11.prod.outlook.com (2603:10b6:610:148::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.21; Fri, 23 Feb
 2024 09:21:27 +0000
Received: from DS0PR11MB7481.namprd11.prod.outlook.com
 ([fe80::c243:33d7:2ff6:409b]) by DS0PR11MB7481.namprd11.prod.outlook.com
 ([fe80::c243:33d7:2ff6:409b%3]) with mapi id 15.20.7292.036; Fri, 23 Feb 2024
 09:21:27 +0000
From: <Rengarajan.S@microchip.com>
To: <jirislaby@kernel.org>, <linux-serial@vger.kernel.org>,
	<gregkh@linuxfoundation.org>, <UNGLinuxDriver@microchip.com>,
	<Kumaravel.Thiagarajan@microchip.com>, <linux-kernel@vger.kernel.org>,
	<Tharunkumar.Pasumarthi@microchip.com>
Subject: Re: [PATCH v1 tty] 8250: microchip: pci1xxxx: Refactor TX Burst code
 to use pre-existing APIs
Thread-Topic: [PATCH v1 tty] 8250: microchip: pci1xxxx: Refactor TX Burst code
 to use pre-existing APIs
Thread-Index: AQHaZZZL0nj0fFzSz0iXzZOI5AQ+c7EXclSAgAA2nwA=
Date: Fri, 23 Feb 2024 09:21:27 +0000
Message-ID: <e93048e64c3f8aa2731575d4b296c473e8dadb82.camel@microchip.com>
References: <20240222134944.1131952-1-rengarajan.s@microchip.com>
	 <5bf4ba6d-d8e3-4ba6-a889-cfae8c3ddabe@kernel.org>
In-Reply-To: <5bf4ba6d-d8e3-4ba6-a889-cfae8c3ddabe@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7481:EE_|CH3PR11MB7761:EE_
x-ms-office365-filtering-correlation-id: a1e99c50-22fb-403e-cae8-08dc3450d039
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bTwVoet6iJ15VFGhbkXyRSNAcQuVj+0sOZJUAkDfKTrUY8Oxrvf+fo2aYjV6thQq4cogGK05TqB8BA3DlL9OYikZIoSziA32ed+IQGT9lD7yTcXpQG6xLAhSmg/MaKJSLpgbCzpz9Xhcp9pvKEyaKABkajab6Fs2g1/IkmSA5ZtS8tMTowdprksvt0i9rXLs2Z5v/YKCMMCJTmh/HGaH6VtjPSg9blUjlbABWl6adDXtuEuekkgy4ndm8XW6QO3aBDGe82AX2CbYWK5atgJebTbnVCDwf164ZCOJnsBQHdk0kHrcwafjshZiONepKsWbEB0YITdcUoADDT+4PtTKloqbbxgwlmgGTNI6k+QfZOuNB0Mdy4thTnQuXWHdEjcyzKpb5Ft93K5VY4qOYP3PECJpIOejyDgrurJBv3XNgZCse5Zoq9wus8oi7U2KUSxFJz5p2jFZV/ZLc3dhiYj5W+C6GcXXADDa2GavbVaBbQZT4eWlubUyK/qI26mtzvxAYzV5AsCy25irUOf4zDAxCQ9QBChdegD78KzDXZ0ZoKjJRA8Co0bA6zCZ+kkj5+KXAaSSZMqVu2pQ1N0pnFtQAl72Z3KEbfRzwrzbjVQyHYTS3IV3dkAUhcGICvyw0gMc
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7481.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(230273577357003)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NUVnMjF3RFc0dTM0N0YxR1NPVkdsa2VteHBPV090Sy9oUDRiQnRhUVhXci9B?=
 =?utf-8?B?bWVleFR5V1VDY3pjNjA2YkxQZTg4ZzQ5ZmF5SUZSSjIvMDd0QmRFaXp4YTBG?=
 =?utf-8?B?WlMvVzZkZkkvQ1pOU0VaM1N6cFFydy9YZU1NY2pVeG0zM1Y0TzBoMUFlSDEx?=
 =?utf-8?B?SS9JWWhuaVczMXdpSUZ3d0xleVV6R0sxcWVHSXpNajBKNDU4V0hJZEpOd2N6?=
 =?utf-8?B?eStzbkx4MjdTQzEyU2ZkNVdITStiN3dYOExPSFlRMmd6UUtyRzRkbHpEekVV?=
 =?utf-8?B?Tk9lQ0ZYRFduc0FoWVlPd2l0UENFcXMwZGNlOU8xbEQreGtPWmcwNkNzS1oz?=
 =?utf-8?B?SUVneEdDY004dFU1bTU2U1BiT0N3dmx4dnU3bTVsbmc1eHNETkhRMHRBT0Fm?=
 =?utf-8?B?WEh1S2dZcmFyM2JmWTY1TGNtc2xDYmJoT3NETzJMd05ZQWVBOTVNdS9iWmVp?=
 =?utf-8?B?V25lV1ozY2RhTG9MVldvd0FlblZ1OTdPYzRmU1R6N1huSVZSWGNzRHh6cVhn?=
 =?utf-8?B?eCtIdUhQQll2SlRFajFJVnFFcUZMU3I1YlQ2MU9HazVxSGZKL09mRmlVVm13?=
 =?utf-8?B?cjltNTU5RzlMS1hYb1VuMXVzWEk0eU82aEt5UVNvVjNUUE52bHVwSVY3ckJF?=
 =?utf-8?B?VnFPMzllRHNSNm9YL2NYVCtRaEFIOUhDL3h6NjR2eTViN25DMjdFV1VzR1J4?=
 =?utf-8?B?V2lINFpmaXMxSmRhNTNCaDhYL2txZDU1WUtibXpIbTNlcUcrbjhtcWNKUXl6?=
 =?utf-8?B?MXhmS2t2WWVmcWRwcWdPVWR3aUhaQVpObzEybndmWmo3SGMxaGpJeUUrVnZU?=
 =?utf-8?B?TXhPSHNxcUFNckc3RHY4TitVZDNoWVBuMm92b3NmYUE5YTlXL3M3UWRvMXZ1?=
 =?utf-8?B?ZllsdDRGcUFUaHAyMHk3U0JiM2wxYlo2Y3dJL2xCWkI2V0xaem5xQkh5UTEx?=
 =?utf-8?B?UkhiTDdYbUNnMjNyQ0kweExHRHRCV0ZGaWcyVFprTTJaa280VEdsMDgyYzlT?=
 =?utf-8?B?cXhreWV2Mjl5azZMLzhOWDMvKzU0VVBsRit2MTE1TG9DQzhTZVFFTGFJZGZE?=
 =?utf-8?B?Y0VoSkYyMHFYaU8ya0NVeTVPMEhlckdqVTVyWHlFZ20zMUJwTXZOVmc3VXJY?=
 =?utf-8?B?YmRGYmc0U3dpYzZubGZaMVIxRk13L0ZrdmwzaUxlOG56Sjdib1Q2NzdYemhi?=
 =?utf-8?B?TXBPMUgvYjJKMHBaQmhvVnFKZk9kOHRKemxITnlrNkxCOTNhRmtwaHVQQ2Nn?=
 =?utf-8?B?S3pZT3R4L0l6Ymhxald1U1NPTHZHdkNPLzV6cTc2WFNLbWZDV1BHeXgrSCtn?=
 =?utf-8?B?aWVGMlBZN09Sd2FPaEo1ajNzeDY3aGV4RTJucGlNNUZ4U0MrRDF4Z04rQks4?=
 =?utf-8?B?bStuVVFpczd1RVFTOXlBY0pIRXowVlNxdW0yYzlucWFqUjhnQktCOVFKUlp2?=
 =?utf-8?B?TXVScElFdlZ0cElaUGZIUEx2b21PdXlSVFg1cm9uNVZDdnZ0ZmszS3Nmd0xa?=
 =?utf-8?B?WXdBa2tzRGR2Qk1GbHRQUkJhWnRLQWR5ekJwR2xOVWp4bG93SEIvaTVyZ2lq?=
 =?utf-8?B?RFhGRU1pM2RxbUhDb1lmM1ppZHVzZEpBL1BXSWxyMWQxVEV6YVZsb3dOODY2?=
 =?utf-8?B?WW9mUzJKdFVzQzNjcHc3blNEdnRlRUczTElNRnhLSHZBeFVvWUUyYlNnNitP?=
 =?utf-8?B?RjJsb0RDSWhraXRseXM1OFU3cUluckFOUlp5RWpzY3M4OXJwOEZpRUxrRVBw?=
 =?utf-8?B?T1doaDFHNUFYLzgvVkd4MHlHaHJUN1p3RmlzaFp1WTJWU1poMXJDbVlFQ1I5?=
 =?utf-8?B?ejhHWkc4eElpbVg3MU1BOTMrMHR2MWtSWDdwRkF2U0FTeXVkWlBWaitTZzZk?=
 =?utf-8?B?Q2JtWmtPWUl5WGxrV2hKUXo3YkUrUGs0SWlmVEtUZGZWVHdnenRzU0t3eVlG?=
 =?utf-8?B?SU5NeHo2VHBHT1A5V0hwSS9jV2IreCtxcVlyY1JhT0ZZR0tiUUxOTVFJV255?=
 =?utf-8?B?bEtLNS9CeGNmdmptMnN0RklWcTJRUFpybE51R3RlUVdyaDhzOGNod1hRUDJz?=
 =?utf-8?B?S3Z2d3RVY1R4Y0o0UEkzaXVMaUc5VUl0dHh1RXJpTXB0YThvTktlK1ZGVTNF?=
 =?utf-8?B?WEVJSXdhTmdwakhtT0lsdE9tTTF2ZTRuQkxYWVY0NndCaE9FYXhIZTM2cVE1?=
 =?utf-8?B?emc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <53E2A155ECC00449812E0E62C034BD65@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7481.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1e99c50-22fb-403e-cae8-08dc3450d039
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2024 09:21:27.5051
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /sTy/Ey8PoCXbcmT3KEISnxITEErLNgOuwufLeoSD5m3vaLsODVzrn5qZ7E9j/NZRtr6xarfFctwnv70QUhT+tWcv31PEsWvlTUN6LOr/Ts=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7761

T24gRnJpLCAyMDI0LTAyLTIzIGF0IDA3OjA4ICswMTAwLCBKaXJpIFNsYWJ5IHdyb3RlOg0KPiBF
WFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5s
ZXNzIHlvdQ0KPiBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IE9uIDIyLiAwMi4gMjQs
IDE0OjQ5LCBSZW5nYXJhamFuIFMgd3JvdGU6DQo+ID4gVXBkYXRlZCB0aGUgVFggQnVyc3QgaW1w
bGVtZW50YXRpb24gYnkgY2hhbmdpbmcgdGhlIGNpcmN1bGFyIGJ1ZmZlcg0KPiA+IHByb2Nlc3Np
bmcgd2l0aCB0aGUgcHJlLWV4aXN0aW5nIEFQSXMgaW4ga2VybmVsLiBBbHNvIHVwZGF0ZWQNCj4g
PiBjb25kaXRpb25hbA0KPiA+IHN0YXRlbWVudHMgYW5kIGFsaWdubWVudCBpc3N1ZXMgZm9yIGJl
dHRlciByZWFkYWJpbGl0eS4NCj4gDQo+IEhpLA0KPiANCj4gc28gd2h5IGFyZSB5b3Uga2VlcGlu
ZyB0aGUgbmVzdGVkIGRvdWJsZSBsb29wPw0KPiANCg0KSGksIGluIG9yZGVyIHRvIGRpZmZlcmVu
dGlhdGUgQnVyc3QgbW9kZSBoYW5kbGluZyB3aXRoIGJ5dGUgbW9kZSBoYWQNCnNlcGVyYXRlIGxv
b3BzIGZvciBib3RoLiBTaW5jZSwgaGF2aW5nIHNpbmdsZSB3aGlsZSBsb29wIGFsc28gZG9lcyBu
b3QNCmFsaWduIHdpdGggcnggaW1wbGVtZW50YXRpb24gKHdoZXJlIHdlIGhhdmUgc2VwZXJhdGUg
aGFuZGxpbmcgZm9yIGJ1cnN0DQphbmQgYnl0ZSkgaGF2ZSByZXRhaW5lZCB0aGUgZG91YmxlIGxv
b3AuIA0KDQo+IC0tDQo+IGpzDQo+IHN1c2UgbGFicw0KPiANCg0K

