Return-Path: <linux-kernel+bounces-84797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D41F86ABB4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 10:56:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADB561C22CCA
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 09:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24230364A0;
	Wed, 28 Feb 2024 09:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="VsPL45C/"
Received: from esa5.fujitsucc.c3s2.iphmx.com (esa5.fujitsucc.c3s2.iphmx.com [68.232.159.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA7636123;
	Wed, 28 Feb 2024 09:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.159.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709114181; cv=fail; b=Ii8//9E094mg29KuFdZJUrQ4GOZxrCLv+0Otj/XvvDVX5LJ+6Tgya2sITF7ZugRt4Zz8cjxIjceodj7HDRDIq6dExp/TG4+tMESG1iHgG0Er77g9VnNO9ZLV5fM4Uqdfm4FlzyJMRZWmq+wmIqWo6kB3dGdJ2kVT6F6ruHDEHLY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709114181; c=relaxed/simple;
	bh=NtwbQWf3uQlSg/7SLhhNj/qDlp98p06OZCKqeXO5iQE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oMaFEKkSvsTB+8GnAb4ILRP/tw6hbQTQ4oz6bzMCIO1600CJBmz+FUUI4eE4acUEyuS225BCPnxQFvh7+69eGcTOAIc9EZyqqbURqGlGMPL9FGf5woF0nqndBRwOCcKhd8GOyaCZuJwYGLPalaadRL1hTv9E394NwQLJokIFsaM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=VsPL45C/; arc=fail smtp.client-ip=68.232.159.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1709114174; x=1740650174;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=NtwbQWf3uQlSg/7SLhhNj/qDlp98p06OZCKqeXO5iQE=;
  b=VsPL45C/ZNTIDDlN8UjCYM8ZIO1N1hvwptqgiCK3YmH7wGOSSYKeEP4j
   tnMBItuzI0LwEiuhFW1iZIgx7u8qh78vQ2ffxWyKI7LmvXXNF09yDGt8u
   J2fkOpJ6hx6Pb+GLBRk6rKXYmjJA5TaFO7eXZufAezliWxYMiTqI7gr09
   Z/JBd39vW75SeBi1TJ1tv8ZC9AjiZayret8ZtWQ/nTyHLk5axXEkf2RH1
   Uedibn1+8dUtVNW5WbLdNpexWgfT3sMr3FIc0FXmeWi+C8XjmWiuxQtTh
   49uzyANKlsev4Uhh/+A2ffNPLRuqU6XJ9xKJ9GU3lEOOYxjrxHeo0TJjp
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="112792388"
X-IronPort-AV: E=Sophos;i="6.06,190,1705330800"; 
   d="scan'208";a="112792388"
Received: from mail-os0jpn01lp2104.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.104])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 18:56:08 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=erTDDmKD6rJWpKI/43MlMmcaoombsjDK4Xm0enUUxXouit2aQNYyjth9XQeHU2mg3b7uaBA/e0ubXBTNUa9h5AUroycsY3jhTjKSeDFIJ17nn8i/clxXRm4lguARdy5SS7cyAO2uZZQrfb5+Yv/r/YSk825lr9vRWw1jO5sv24dd07/1EogCDgp3mXBgm06kXW4+SBBSqcg5HrIygRkmMfkA3dw59yr5TGSlt2UXEM9fMb+ZmyQ9asU3Yo9rkpnDQ13YGriGIVyIozoTOh2MCgaz8BAmdKEPlLTo2p+wbyVHabfOzhKfBlx78RrQo7e1PlzSA3S+4p0N5uv2ETQGyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NtwbQWf3uQlSg/7SLhhNj/qDlp98p06OZCKqeXO5iQE=;
 b=Q6BA7LfOKfeDJIuX14Xx63yztAJT7ItRNRyVAWPyG78+IXfKtflXdJSHt1XdZ/kPJM+TKdCU9ZFIgRwGVaudOPlNJndI6sok4oMRUbVrsmKpqo83aD8NAG24RweJlsa0+wI3bFnXCp35oDPSy9Xm+17CMeZV0wE9sEr96/zWtCL/x7fx58EDWzzJwxQepsM6IeP0zQKrdxVyWqc47gdb+F6PK69LPmCgDGhXzFZt5IyPqUMXEVo/GpzKSfEg3SK7tZ8363lGSHFBhS0sVP4LgkqP54GWgILB8n8jK669+8Ama28XK3R6if3nB+AfDYWnZYnH8PG975+s6pL8ALVY1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSAPR01MB1905.jpnprd01.prod.outlook.com (2603:1096:603:15::14)
 by TYCPR01MB10103.jpnprd01.prod.outlook.com (2603:1096:400:1ef::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.33; Wed, 28 Feb
 2024 09:56:03 +0000
Received: from OSAPR01MB1905.jpnprd01.prod.outlook.com
 ([fe80::2336:cf8:2fb3:65f2]) by OSAPR01MB1905.jpnprd01.prod.outlook.com
 ([fe80::2336:cf8:2fb3:65f2%5]) with mapi id 15.20.7316.037; Wed, 28 Feb 2024
 09:56:03 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: =?utf-8?B?QnJ1bm8gUHLDqW1vbnQ=?= <bonbons@sysophe.eu>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jiri Kosina
	<jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>,
	Jonathan Cameron <jic23@kernel.org>, Srinivas Pandruvada
	<srinivas.pandruvada@linux.intel.com>, "linux-input@vger.kernel.org"
	<linux-input@vger.kernel.org>
Subject: Re: [PATCH 11/42] drivers/hid: Convert snprintf to sysfs_emit
Thread-Topic: [PATCH 11/42] drivers/hid: Convert snprintf to sysfs_emit
Thread-Index: AQHaSDfJjZ2uibywh0yfmI6ukztwn7EZ9TmAgAXTAoA=
Date: Wed, 28 Feb 2024 09:56:03 +0000
Message-ID: <b2ef0840-d561-3443-dd09-e0af5d89172c@fujitsu.com>
References: <20240116041129.3937800-1-lizhijian@fujitsu.com>
 <20240116045151.3940401-1-lizhijian@fujitsu.com>
 <20240116045151.3940401-9-lizhijian@fujitsu.com>
 <20240224175929.6ea8d4f9@hemera.lan.sysophe.eu>
In-Reply-To: <20240224175929.6ea8d4f9@hemera.lan.sysophe.eu>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.1.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSAPR01MB1905:EE_|TYCPR01MB10103:EE_
x-ms-office365-filtering-correlation-id: 6209721d-45e3-435c-42b2-08dc38437992
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 JXSMAiBbmyzcLXHHaThfseSF0//debBEjoFZhpYzigmN8EERxFaS2vexMgY/ZQF5P346iyC5mkQ+hlpR1D+v3PL0lY4btfwtwBCbSEA/349nDSYyP53dTBI56L8xvVpiOQfBcpPT2VPMZPTdg7jlfGAMYyG8mV7JLRB3VU2I/lZx5hNb+U6C51+8nP9nQQ1L1chd4AjTMV5gyvaGUfU64Xcbqui33mkzmUfTETHdLo090lW3qWRLem4ZzCJUGtUAK5HxWFYg0IZXxLsKvrrB5u+VL3HZrMaiO8Hcx/PHhdjP+cb3DhZn0LlhjrA5QeH33ACi5cJ3MxPR3bytBPqq+pl31XSK+H4b8dESb8Vl1+ZArMNuIaDff5BpP/sH0iIQ2FadvKv4FgZXV6f6b/bLjdkp3jdTILMBl19i9q7//2C4b3zIuIFHpT1Av7H76HnTzG8L+dpKIGFLOhVwjhFzVL3HHhkwfEgs/QY9kFRtgQWaMPllZCU4P3mg5PrXtSuoJOy4WvwONaOyq0rdj0SkYXOnJeCWTL+pJk/ZEm+cZyIYJ8NUitLvUZEoT3VFx1MP5IqejlETUI0KkcvqK3JH1atsDZ866z80mWBgVSdUvMnvVm+RVUqdTrQTAn9YLFym7GJmSQWETp/0avv+tsf9YVNXhZ7Su3lNWJkt/PGteRWLUyUfqT6J/iusA6LJPs6mNxXN5Rfwwk9F3Eva78G+0mQriNhhlOWHgPnKpCn+tTzRpzu8R/cnlKprow0EDgW8
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB1905.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(230273577357003)(1580799018)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?N1k2cmIrZ0ZHSHhNbWNQbGJUVVExRzRpSFdvUWlDV0FtRXdUMGtQYTZlSnA2?=
 =?utf-8?B?cXZUamNMQ0FRYjNzOEp1R3M3bXZKMDlyVVg5VTg3ckdCNmR5S1ZlclN1LzZr?=
 =?utf-8?B?NktaRGFPakJVZzNTRHlGQXBXMlE0WDBneU9rY2NnZjZrOXRvTmxHK0tvUVlU?=
 =?utf-8?B?dFByUCtNWERlUmcrSDBwZ2hOTXQ5bVU3MFplVU1Td0l1Z3FqRnFBR3dvcGln?=
 =?utf-8?B?VndKUG92bkdsN09mUmpIWVZQajd3ZkxMT0IwMU44aCs5bDdPMEVPbVYydXdh?=
 =?utf-8?B?SVFRZ2VWbEhqcCtySjBDYTRWelJ6YjJpVHBQd2YxOEcwSVgyRTZzY2U5SXgx?=
 =?utf-8?B?dkVKMjUvWWduWlcwSnhUNzVtWk52anoxUkZOZWtZeEQybStqVEgwd2hTTFBr?=
 =?utf-8?B?YnBWQlU5M2FkcnRFNDVtT1JiK0dWbmZaK29SdzhXVFlMeDN0Wm9SdzY4L1Vs?=
 =?utf-8?B?Y2FlcnVkOVc1bDQ4M2w4ZXRJUXYvSU1LenpwNjJsblBPdHF3WW40U2NsMDI2?=
 =?utf-8?B?RnBIZ0k1ZGNRL2RYODY1UitFT09tRmlEUE5qMmpmRWVlVnZJMjBDQ2xoanNB?=
 =?utf-8?B?elNjVGdYM2VqVU5mQVpmMlFISUU1UDFaZEtyUWx1V1lPV3psdUhBcVM3RzRv?=
 =?utf-8?B?RWJ3eXRiclFseFpmdlFka3huN0g2RXVZd01pQXJSYzg1dmdDN3Uyb3FWODFu?=
 =?utf-8?B?VVpXWlZ6V29oenFPaUd2OVFRbDRIUjZZUnNTaS9ubnU5MC8xUUxYUEl3U1ZH?=
 =?utf-8?B?Y3p2T3FtNWdGYjhzZ3o5bjREeFE1OFBmM043NXErZE5ZWC82YnVzQWFkRTZS?=
 =?utf-8?B?Y0szMTRITU1MdnNpZUEvd3VxWjdaN0R2M3NTcDNRdE9xNk5XVnh4MURrVjVl?=
 =?utf-8?B?TmROQnpGd0pBbkp0dUg0U3pKQ0c1Z3VKbXpjczlWNzMvNXp5dTdmRTBkODEy?=
 =?utf-8?B?aGRZdit2TFpLbkRHT1lVMVdnRVJQQ09kSmZKSURqUWJ3NHN1TGNrbGhYb2J0?=
 =?utf-8?B?dmhVREVxMWVBNkEvWkszVUVybDlDVitHbERpb2NRMTd1dkczTnVqWFJEOHdn?=
 =?utf-8?B?bldZR2t5T3I0bU9iOTJpYVBNNjF0SHJDN0s3bmxqNHBqbkF2Wm5maVV2VHU2?=
 =?utf-8?B?YTVGd0Q4M3Uvd3AwTlpiMzAwOVNwR2o2WmdlWk9MSklXZURZMWI1dXc1Vy9x?=
 =?utf-8?B?R0dEeDJ5NHZMK0lQU3lwc0NDSngvRkZ5VFgzcXJYZDRzdzZ0L2N5NnhSRzgw?=
 =?utf-8?B?L1hLdHpDV21peFJHRXBPWWRPNklPWXZuQ3RtVlpSOSttZWZwV3FBUTl1dWRq?=
 =?utf-8?B?RUpHT01mVTcwYk5DaXZqOSszNE1NSjdCOVJJSWZMU2pIdTBkNUpsN3oxSHFh?=
 =?utf-8?B?YnU5T3ZhNWxTcXpWVXUweUZvWWNvMU1oQ3BwUUZFaW1uSUFCOHlQbmFDVisw?=
 =?utf-8?B?UnplTEJOWkFjWTlZZmNyVVlGZ0M0WXJQd0hGNERxNFlkb0RnUmg3TFZxVFdi?=
 =?utf-8?B?QjRrVWd4Vy9pZitqaFZVekFYQ3lFTnRvZ2lKc2NGQkNmVHBpY3NRUDE3NXBX?=
 =?utf-8?B?N0JRU3p2M1l2T2Y4NS9Ed1hCeXlxaGpydmp5UHZQU0ltTjBwSzlUdG5YNkhF?=
 =?utf-8?B?R01abk1iY25vWDhFY2FqMWxsVUJIZU56cXZqcXJHU2lTOU5xNFFTWjhsQ0Zm?=
 =?utf-8?B?OU9TQWlVVmlBS08vL2RwcktIT0R3TEFpd0NER1phemd5bkZHYWpCOWNXMmgw?=
 =?utf-8?B?ZzI2bkErMVIwOXAwTFBoazdiY3pkZFRUazN3WTZvK1ZRK0FVUXdTbHNjeW9s?=
 =?utf-8?B?Nit3Q2l3dDA4RHR5WVROYkhkQkcvVXoyZ3JVaWpuL2M5KzlERWlkK2hiNXJh?=
 =?utf-8?B?c0ZwWFhXZFloL25ONXlHaU9LK2J5clJsNGtOUWQrVmlHc3R6eTVvK2VpRXBG?=
 =?utf-8?B?czg2WkFPRDJaUkVmb1FjNHNkeURRa3BEa1pxOTEzNjUrTGNLNnBubGpaV0NC?=
 =?utf-8?B?VVBodmdQZ0tYQ0YvQlNYbFJjVmVySURsMHFVQzY2dXdxdGdPNTYzV3JTbFZQ?=
 =?utf-8?B?dTA2WjFwTTBRNlA4VWwzamZGMHdrdm54Mm9kTDQ4bzhsUFEveUdUbVpOMHdt?=
 =?utf-8?B?WUFQZ3V1OUZBdmIwMjJiN2NsSDZ0RmdyQmdBLzhTZGdYTXZpVUozQzlXd2My?=
 =?utf-8?B?cWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E71705360AB8ED4B83DE6D0D36A3398E@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	iWUsowacfxOwIW21l/f6b3z1GBhzdo02i3mpNHep2ZkqIjBGp6B8u42rLzAL1IH0g8etSSk6uXgxS+1dqAUed9WdJ0uhuHu53ftwDTmmXkDTVgTfVs1c2ZVDW+Xqd7LjNBhjIJERusUtHLq5Lx+W015l/Qex9oCrMfVYabKpFYN5ZLxGuKgNrBOSMihk13YS6mDfJxqlMsrcExETwT/ilbMBoZ70rCYj1+sQWjoxJmnqm+wK8J/So5rn3aCzfkbL4ktUjJHKz2mBCQegqagZrDHionYTyxxFialJjpb29vuombZp1ByJbbZrmWKHB1TO/VKCnRgj5D7LQkKzKqm/gKA8GjCMIrIlZNNsSm2DqOdKYaNZbGCG7mqrkQw1601c4F1FO5fM/BJmqQjU5vLfAwMTUd8gU6gJdIikNWtdMUGCa3KjJDid6bqFOLs8xdOnCu7QGji4dkngzqDaUwxZsUGxJxVEhrUpJC+zl38+V8gg8RPfeABJtbj2bx26yapuTvbRws7OWJ3orrgdtsAZ1cI5KQP8jcAesZAS+oTvWTt/R/crjBWovp7l87O22KyDclJfBzNg7492MWcuPCuP4L2ijuG8AvgrLyO/oBSpZ2C0q5Hj47BJRKhVwOwTT/WW
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB1905.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6209721d-45e3-435c-42b2-08dc38437992
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2024 09:56:03.2857
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PaD6y6TilhBh8XaC65vjvQE3u5OlzKKnEClszWIhnQdUL2E+AmasU/ZAJwRbkD1LR1CPggq6PRxTV0ukL83ZWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10103

DQoNCm9uIDIvMjUvMjAyNCAxMjo1OSBBTSwgQnJ1bm8gUHLDqW1vbnQgd3JvdGU6DQo+IEhpIExp
LA0KPg0KPiBXaGlsZSBvbmx5IGxvb2tpbmcgZm9yIHRoZSBzbnByaW50ZigpIGluIHlvdXIgY29j
Y2luZWxsZSBhbmFseXNpcyB5b3UNCj4gcHJvYmFibHkgYWxzbyB3YW50IHRvIGxvb2sgZm9yIHNw
cmludGYoKSAoc2VlIGUuZy4gZWxzZSBjbGF1c2UgaW4NCj4gaGlkLXNlbnNvci1jdXN0b20uYyBh
bmQgc2NucHJpbnRmKCkgKHNlZSBwaWNvbGNkX2ZiX3VwZGF0ZV9yYXRlX3Nob3cNCj4gaW4gaGlk
LXBpY29sY2RfZmIuYykgdG8gcmVwbGFjZSBtb3JlIHMqcHJpbnRmKCkgY2FsbHMgd2l0aCBzeXNm
c19lbWl0Kg0KPiB2YXJpYW50cy4NCg0KWWVhaCzCoCBwcmV2aW91c2x5LCBpIGludGVuZGVkIHRv
IGRvIHRoZSBjb252ZXJzaW9uIGZvciB0aGUgZmlsZXMgDQpyZXBvcnRlZCBieSBjb2NjaW5lbGxl
KHNucHJpbnRmKCkgb25seSksDQpUaGluayBtb3JlLCBJIHNob3VsZCBjb25zaWRlciB0aGUgd2hv
bGUgcypwcmludGYoKSBmYW1pbHnCoCBmb3IgdGhlc2UgDQpmaWxlcyBhdCB0aGUgc2FtZSB0aW1l
Lg0KDQpUaGlzIHdpbGwgYmUgZG9uZSBpbiBWMi4NCg0KDQpUaGFua3MNCkxpLCBaaGlqaWFuDQoN
Cg0KDQo+DQo+DQo+DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2hpZC9oaWQtcGljb2xjZF9mYi5j
IGIvZHJpdmVycy9oaWQvaGlkLXBpY29sY2RfZmIuYw0KPiBpbmRleCBkNzI2YWFhZmIxNDYuLjAz
MDc0ZDI1ZDY2MiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9oaWQvaGlkLXBpY29sY2RfZmIuYw0K
PiArKysgYi9kcml2ZXJzL2hpZC9oaWQtcGljb2xjZF9mYi5jDQo+IEBAIC00NTksOSArNDU5LDkg
QEAgc3RhdGljIHNzaXplX3QgcGljb2xjZF9mYl91cGRhdGVfcmF0ZV9zaG93KHN0cnVjdCBkZXZp
Y2UgKmRldiwNCj4gICAJCWlmIChyZXQgPj0gUEFHRV9TSVpFKQ0KPiAgIAkJCWJyZWFrOw0KPiAg
IAkJZWxzZSBpZiAoaSA9PSBmYl91cGRhdGVfcmF0ZSkNCj4gLQkJCXJldCArPSBzY25wcmludGYo
YnVmK3JldCwgUEFHRV9TSVpFLXJldCwgIlsldV0gIiwgaSk7DQo+ICsJCQlyZXQgKz0gc3lzZnNf
ZW1pdF9hdChidWYsIHJldCwgIlsldV0gIiwgaSk7DQo+ICAgCQllbHNlDQo+IC0JCQlyZXQgKz0g
c2NucHJpbnRmKGJ1ZityZXQsIFBBR0VfU0laRS1yZXQsICIldSAiLCBpKTsNCj4gKwkJCXJldCAr
PSBzeXNmc19lbWl0X2F0KGJ1ZiwgcmV0LCAiJXUgIiwgaSk7DQo+ICAgCWlmIChyZXQgPiAwKQ0K
PiAgIAkJYnVmW21pbihyZXQsIChzaXplX3QpUEFHRV9TSVpFKS0xXSA9ICdcbic7DQo+ICAgCXJl
dHVybiByZXQ7DQo+DQo+DQo+IEZvciBoaWQtcGljb2xjZC0qLmMsDQo+ICAgIEFja2VkLWJ5OiBC
cnVubyBQcsOpbW9udCA8Ym9uYm9uc0BsaW51eC12c2VydmVyLm9yZz4NCj4gYnV0IHByZWZlcmFi
bHkgd2l0aCB0aGUgc2NucHJpbnRmKCkgY2FzZSBpcyBjb3ZlcmVkIHRvby4NCj4NCj4NCj4gQ2hl
ZXJzLA0KPiBCcnVubw0KPg0KPiBPbiBUdWUsIDE2IEphbiAyMDI0IDEyOjUxOjIwICswODAwIExp
IFpoaWppYW4gd3JvdGU6DQo+PiBQZXIgRG9jdW1lbnRhdGlvbi9maWxlc3lzdGVtcy9zeXNmcy5y
c3QsIHNob3coKSBzaG91bGQgb25seSB1c2Ugc3lzZnNfZW1pdCgpDQo+PiBvciBzeXNmc19lbWl0
X2F0KCkgd2hlbiBmb3JtYXR0aW5nIHRoZSB2YWx1ZSB0byBiZSByZXR1cm5lZCB0byB1c2VyIHNw
YWNlLg0KPj4NCj4+IGNvY2NpbmVsbGUgY29tcGxhaW5zIHRoYXQgdGhlcmUgYXJlIHN0aWxsIGEg
Y291cGxlIG9mIGZ1bmN0aW9ucyB0aGF0IHVzZQ0KPj4gc25wcmludGYoKS4gQ29udmVydCB0aGVt
IHRvIHN5c2ZzX2VtaXQoKS4NCj4+DQo+Pj4gLi9kcml2ZXJzL2hpZC9oaWQtcGljb2xjZF9jb3Jl
LmM6MjU5OjktMTc6IFdBUk5JTkc6IHBsZWFzZSB1c2Ugc3lzZnNfZW1pdA0KPj4+IC4vZHJpdmVy
cy9oaWQvaGlkLXBpY29sY2RfY29yZS5jOjMwNDo4LTE2OiBXQVJOSU5HOiBwbGVhc2UgdXNlIHN5
c2ZzX2VtaXQNCj4+PiAuL2RyaXZlcnMvaGlkL2hpZC1zZW5zb3ItY3VzdG9tLmM6Mzc1OjEwLTE4
OiBXQVJOSU5HOiBwbGVhc2UgdXNlIHN5c2ZzX2VtaQ0KPj4gTm8gZnVuY3Rpb25hbCBjaGFuZ2Ug
aW50ZW5kZWQNCj4+DQo+PiBDQzogIkJydW5vIFByw6ltb250IiA8Ym9uYm9uc0BsaW51eC12c2Vy
dmVyLm9yZz4NCj4+IENDOiBKaXJpIEtvc2luYSA8amlrb3NAa2VybmVsLm9yZz4NCj4+IENDOiBC
ZW5qYW1pbiBUaXNzb2lyZXMgPGJlbmphbWluLnRpc3NvaXJlc0ByZWRoYXQuY29tPg0KPj4gQ0M6
IEpvbmF0aGFuIENhbWVyb24gPGppYzIzQGtlcm5lbC5vcmc+DQo+PiBDQzogU3Jpbml2YXMgUGFu
ZHJ1dmFkYSA8c3Jpbml2YXMucGFuZHJ1dmFkYUBsaW51eC5pbnRlbC5jb20+DQo+PiBDQzogbGlu
dXgtaW5wdXRAdmdlci5rZXJuZWwub3JnDQo+PiBTaWduZWQtb2ZmLWJ5OiBMaSBaaGlqaWFuIDxs
aXpoaWppYW5AZnVqaXRzdS5jb20+DQo+PiAtLS0NCj4+ICAgZHJpdmVycy9oaWQvaGlkLXBpY29s
Y2RfY29yZS5jICB8IDYgKysrLS0tDQo+PiAgIGRyaXZlcnMvaGlkL2hpZC1zZW5zb3ItY3VzdG9t
LmMgfCAzICstLQ0KPj4gICAyIGZpbGVzIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgNSBkZWxl
dGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9oaWQvaGlkLXBpY29sY2RfY29y
ZS5jIGIvZHJpdmVycy9oaWQvaGlkLXBpY29sY2RfY29yZS5jDQo+PiBpbmRleCBiYmRhMjMxYTdj
ZTMuLmZhNDZmYjZlYWIzZiAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvaGlkL2hpZC1waWNvbGNk
X2NvcmUuYw0KPj4gKysrIGIvZHJpdmVycy9oaWQvaGlkLXBpY29sY2RfY29yZS5jDQo+PiBAQCAt
MjU2LDkgKzI1Niw5IEBAIHN0YXRpYyBzc2l6ZV90IHBpY29sY2Rfb3BlcmF0aW9uX21vZGVfc2hv
dyhzdHJ1Y3QgZGV2aWNlICpkZXYsDQo+PiAgIAlzdHJ1Y3QgcGljb2xjZF9kYXRhICpkYXRhID0g
ZGV2X2dldF9kcnZkYXRhKGRldik7DQo+PiAgIA0KPj4gICAJaWYgKGRhdGEtPnN0YXR1cyAmIFBJ
Q09MQ0RfQk9PVExPQURFUikNCj4+IC0JCXJldHVybiBzbnByaW50ZihidWYsIFBBR0VfU0laRSwg
Iltib290bG9hZGVyXSBsY2RcbiIpOw0KPj4gKwkJcmV0dXJuIHN5c2ZzX2VtaXQoYnVmLCAiW2Jv
b3Rsb2FkZXJdIGxjZFxuIik7DQo+PiAgIAllbHNlDQo+PiAtCQlyZXR1cm4gc25wcmludGYoYnVm
LCBQQUdFX1NJWkUsICJib290bG9hZGVyIFtsY2RdXG4iKTsNCj4+ICsJCXJldHVybiBzeXNmc19l
bWl0KGJ1ZiwgImJvb3Rsb2FkZXIgW2xjZF1cbiIpOw0KPj4gICB9DQo+PiAgIA0KPj4gICBzdGF0
aWMgc3NpemVfdCBwaWNvbGNkX29wZXJhdGlvbl9tb2RlX3N0b3JlKHN0cnVjdCBkZXZpY2UgKmRl
diwNCj4+IEBAIC0zMDEsNyArMzAxLDcgQEAgc3RhdGljIHNzaXplX3QgcGljb2xjZF9vcGVyYXRp
b25fbW9kZV9kZWxheV9zaG93KHN0cnVjdCBkZXZpY2UgKmRldiwNCj4+ICAgew0KPj4gICAJc3Ry
dWN0IHBpY29sY2RfZGF0YSAqZGF0YSA9IGRldl9nZXRfZHJ2ZGF0YShkZXYpOw0KPj4gICANCj4+
IC0JcmV0dXJuIHNucHJpbnRmKGJ1ZiwgUEFHRV9TSVpFLCAiJWh1XG4iLCBkYXRhLT5vcG1vZGVf
ZGVsYXkpOw0KPj4gKwlyZXR1cm4gc3lzZnNfZW1pdChidWYsICIlaHVcbiIsIGRhdGEtPm9wbW9k
ZV9kZWxheSk7DQo+PiAgIH0NCj4+ICAgDQo+PiAgIHN0YXRpYyBzc2l6ZV90IHBpY29sY2Rfb3Bl
cmF0aW9uX21vZGVfZGVsYXlfc3RvcmUoc3RydWN0IGRldmljZSAqZGV2LA0KPj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvaGlkL2hpZC1zZW5zb3ItY3VzdG9tLmMgYi9kcml2ZXJzL2hpZC9oaWQtc2Vu
c29yLWN1c3RvbS5jDQo+PiBpbmRleCBkODUzOTg3MjE2NTkuLjRmZThkY2NmNjcxZCAxMDA2NDQN
Cj4+IC0tLSBhL2RyaXZlcnMvaGlkL2hpZC1zZW5zb3ItY3VzdG9tLmMNCj4+ICsrKyBiL2RyaXZl
cnMvaGlkL2hpZC1zZW5zb3ItY3VzdG9tLmMNCj4+IEBAIC0zNzIsOCArMzcyLDcgQEAgc3RhdGlj
IHNzaXplX3Qgc2hvd192YWx1ZShzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCBkZXZpY2VfYXR0
cmlidXRlICphdHRyLA0KPj4gICAJCQkJICAgICBzaXplb2Yoc3RydWN0IGhpZF9jdXN0b21fdXNh
Z2VfZGVzYyksDQo+PiAgIAkJCQkgICAgIHVzYWdlX2lkX2NtcCk7DQo+PiAgIAkJaWYgKHVzYWdl
X2Rlc2MpDQo+PiAtCQkJcmV0dXJuIHNucHJpbnRmKGJ1ZiwgUEFHRV9TSVpFLCAiJXNcbiIsDQo+
PiAtCQkJCQl1c2FnZV9kZXNjLT5kZXNjKTsNCj4+ICsJCQlyZXR1cm4gc3lzZnNfZW1pdChidWYs
ICIlc1xuIiwgdXNhZ2VfZGVzYy0+ZGVzYyk7DQo+PiAgIAkJZWxzZQ0KPj4gICAJCQlyZXR1cm4g
c3ByaW50ZihidWYsICJub3Qtc3BlY2lmaWVkXG4iKTsNCj4gU2hvdWxkbid0IHRoZSBzcHJpbnRm
KCkgaW4gdGhlIGVsc2UgY2xhdXNlIGJlIHJlcGxhY2VkIGFzIHdlbGw/DQo+DQo+PiAgIAkgfSBl
bHNlDQo=

