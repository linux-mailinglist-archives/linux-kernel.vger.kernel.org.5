Return-Path: <linux-kernel+bounces-66281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9533A8559AB
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 05:11:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D74C29079E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 04:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C9A79C5;
	Thu, 15 Feb 2024 04:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Z5wgi19g";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="htyepu7n"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3EAA6FD2;
	Thu, 15 Feb 2024 04:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.154.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707970271; cv=fail; b=GzsUgy98XXISZAFiCBP9NpGo47jgSqzOFp0SUPwwXUNjiPKtTzSFS8UwvKOLNeu8U4uTnbZBCqtr0p9FdzIQCRp2ICwx2T8vknCuGUcK4+TAh/k7SwbL5xcDXwND0Fx9LcHGcOqM6SSmlbnPD45y4Eb9uRwtWPuNosRXg72YXxY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707970271; c=relaxed/simple;
	bh=RQai0k8crXJZdbq8tGVurvyV4BIIz5qJ2sqp/Fxn/bQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RrAC44ZR126WWGzg4BFzav6zPg4wXkad7IqEp5rhIBxiwxD8mdv1EWtCcRZOfl0gdE5QI39lQI2XHP7yDnIfZCQUr53iwW0FZQZ9Igqi0Cxox+zBLmBJqXEuZuir4j6RWNB+1UHOz55R2pZZlJGn8QSbfDIEYblsSTbDrx7hBSg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Z5wgi19g; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=htyepu7n; arc=fail smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1707970268; x=1739506268;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=RQai0k8crXJZdbq8tGVurvyV4BIIz5qJ2sqp/Fxn/bQ=;
  b=Z5wgi19gRyUUKW8cPiv5v00WYrO9RL65BLhzVqWklIyCiO6ger0S1Zei
   A+h3hA8HfbESQkQYMIYEzg42E34SvQKLdo3vdvYrtIALe51O/wUnslqiO
   qUL/9rYkkX+67MTAU6ZMrtlXPyD0valbAlrVmjcr94GXQgf/ZpJv1UiN/
   F9OaOx2+SSUlS0XyiDsc84jOgwyOuDmIgRuiNCQXtR5S7uADRLrE8LrnU
   qHmAEFVpUm3SSNJWAoCvMZJGhOAnMetgsyj1Fk5lyxgKb+z0AUNZIxykw
   gpUnACJn60F7J4hiOyu3Zrt/621znJT4BZ7W8iabFV/Lvf3ks9RJiNRJ1
   A==;
X-CSE-ConnectionGUID: nc6/3DY0Rzq/x6NiLXvvzg==
X-CSE-MsgGUID: HgdCe3EiSF23DTp5/JKlaw==
X-IronPort-AV: E=Sophos;i="6.06,161,1705388400"; 
   d="scan'208";a="16274748"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Feb 2024 21:11:02 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 14 Feb 2024 21:10:35 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 14 Feb 2024 21:10:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hIiVKuXZWGKW8j6sah0xG7QyHqTOqP/SCO+ja/OaM9Wq0CqCeSp+aBTGeEy0rb83r8cnVPH1az0WA91tRx/fbPpWk34qZwQFDzlz1lTOJjkWLoJjpGxWEC4bqbW1XIweU8q6jTMwAf4aQAKogLrzl7wT5ePJ9Sjlmy7kFjFIgzJP9LeA81Yh7ZfmveUh3FDUbQsM8/kDIzqkzC5NQf2/Y6wrHIxpaXZtce9G43dh7H1IjsQHJbPsjX6BURZ6/FF8eXXlEJ2btH46gn0C7G1NcBRk/+MwQIQ7+if17sq4uVy5qjd2x8llq1wRR0XbT28ZrfhEPkPxye4TSYtm6eAhjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RQai0k8crXJZdbq8tGVurvyV4BIIz5qJ2sqp/Fxn/bQ=;
 b=MhXbB7QgFkm16RViVwoaSw6QxOHo8S2HgcKF4EtgQ/vydmZGdc6t2Q49I3yjE2cJe/aEBjnxxcKqZiyxKqO0hu8IsfeZA2hZEg8wF+5hm6Fegn/r/pkiLuGV+xV2GFwmb0qfKK6qnfTMYhUoTTQuIdDxSO8B4WOpF8gwb6ZSELCvKf4dlCVeKRCMbOo+dB5e0qdx780C7+ec3qlzrUgNHzlJ1v8jblBrmn6UnSP9W0gaS6h5xdtRfK6mYKTIQuXyztIAUhlaN45M9e0BL4xKGK8kKaCDMUAB5ZJ38JI9WpOnXMyBcHLawF00qRH73S3KxNp4ftEbsSxFUfJ20WAf9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RQai0k8crXJZdbq8tGVurvyV4BIIz5qJ2sqp/Fxn/bQ=;
 b=htyepu7n61ugK5TvqTuTIZEkVQC9JbvO8Snh263T8OOs8oDrTA12wtON3P+e9sAXmbzgv/Rh5Pdz60VhSLr+oETjDPv1DpWrc3M13NTudffw5WKprHwxZ8OfrXMKJHoVA4fh70l6ZAnYwuOymxBJydIu44HjalAL7HhQeimk5idKwdvsUYG8bzuFWEtBy7E+S7hAE75M5UqT8nDxf9DTUgFvGV/gN1beYltosB0fkfQb9urp4BX5atLLJogD2qkyTcFIV11V00BtceYd7VDqGXbAddMjth4QUGqvgg8tPL+Yxr+RCohSsIJcmVCpIvf81r7Hynw/ItIN03p4I/j+pQ==
Received: from PH0PR11MB5176.namprd11.prod.outlook.com (2603:10b6:510:3f::5)
 by DS7PR11MB5966.namprd11.prod.outlook.com (2603:10b6:8:71::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7270.33; Thu, 15 Feb 2024 04:10:31 +0000
Received: from PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::613:fb5:737:dae8]) by PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::613:fb5:737:dae8%7]) with mapi id 15.20.7292.027; Thu, 15 Feb 2024
 04:10:31 +0000
From: <Ajay.Kathat@microchip.com>
To: <johannes@sipsolutions.net>, <alexis.lothore@bootlin.com>,
	<kvalo@kernel.org>, <lkp@intel.com>
CC: <oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-wireless@vger.kernel.org>
Subject: Re: drivers/net/wireless/microchip/wilc1000/cfg80211.c:361:42:
 sparse: sparse: incorrect type in assignment (different base types)
Thread-Topic: drivers/net/wireless/microchip/wilc1000/cfg80211.c:361:42:
 sparse: sparse: incorrect type in assignment (different base types)
Thread-Index: AQHZ2gMQNOMgJor5MkmGejQxkqg1X7AAypeDgAAnkKOBCZ1fgIAADQAAgAE5RwA=
Date: Thu, 15 Feb 2024 04:10:31 +0000
Message-ID: <457eb81e-73f6-4800-83aa-fb5a49dc6818@microchip.com>
References: <202308290615.lUTIgqUl-lkp@intel.com> <877cpev0pn.fsf@kernel.org>
 <87a5uatfl1.fsf@kernel.org>
 <09eeb7d4-c922-45ee-a1ac-59942153dbce@bootlin.com>
 <e9501c13be127b8b9d0c769a27d8d38636875f0f.camel@sipsolutions.net>
In-Reply-To: <e9501c13be127b8b9d0c769a27d8d38636875f0f.camel@sipsolutions.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5176:EE_|DS7PR11MB5966:EE_
x-ms-office365-filtering-correlation-id: 5d947a51-ca74-4275-d225-08dc2ddc0cd1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ST1mHJM95bUM84o98eq18MuFx0fnuwXeLlT5/P8V1a559WN2rdGqla+wrZtZvX3Q5GDUgSaIKj5weBqrT1A37Vj1em56KyyPdhjCLGW2szYJAchmBwQVx/kz8ZRWHAr2CWzm+FBlZiaLqs2iNft9ldSDDC1RXypF/ZQOAFAAvpS2G4pRFJbHOUAmwM08//UVFjU2TgI4IURWEW3nUQEWhg2l5Gpx77tckRC7CAIAh0AygcVS5Zph8QaKIjyNQzpP4dKWJYtOUMmh26gGdqg26EKKGROORwoIQfcJD7Aljq+pmWo9lO2WReGazOUZTRtl8NL7aEcx2MkAI2W/QRMnylWqPl8gHfw058l5UyBjLFRh6JxIGAOlojCpZXt0/UeCSTaYNpSyu7QHPieBhPjBF9LbRRtxku1osdi94K2kkiwTacQTzvjASRFJKXFAhQXFa0risVyIukLnLjC1yTiEq43ES+UJiHk6fGRkmCbcTsYeXISYqcpsEWz/vPnFi7vdCR6q13WBuqIbsJluYdWT2CzDBF2GfG9J0/zusZFx6lWAPElBq+ZuRRZLw0z+26yY7OHfkvOzUAKO5vUb+PRB5KRZdGPtgY3sb2dg4Yx3mS4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5176.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(376002)(136003)(396003)(230922051799003)(230273577357003)(64100799003)(186009)(451199024)(1800799012)(5660300002)(31686004)(6512007)(478600001)(6486002)(966005)(41300700001)(8936002)(4326008)(8676002)(2906002)(122000001)(86362001)(38070700009)(76116006)(53546011)(54906003)(316002)(71200400001)(66946007)(66556008)(66476007)(6506007)(64756008)(66446008)(31696002)(26005)(2616005)(110136005)(38100700002)(83380400001)(36756003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dGhPVmFoQTdPTG5zZnJEWGFKM2xPODhob3MvV25PV2xhQmtRWU5MbXo3eGJK?=
 =?utf-8?B?YzkyTDYvc3E0bFdXb1dqdTJLcmFBeFJMS3FINGtWV2JrbTZQcml4WlMwOVkx?=
 =?utf-8?B?VXZzckZtZE1tMGVwRlVKay82ejZWcHV4Y01oOEtkUXJTZVY5SlJScWRlV0dk?=
 =?utf-8?B?M3pXQzdWSWIyK1I2ZjJtM3hqUUhpVlI2VTRMdmk3eTRjY3IxNmJzTkpHOGl1?=
 =?utf-8?B?dWVJUlZaQ1pmZXN6Nk5KOFNiNFZ5bm9ka0dOaU11dnpSLzJQc3dFUGsvYXRk?=
 =?utf-8?B?L0F6SlU1eXFZbFZnMm9uMURjOW5iRnRzcXNiVWRBbEdYWWxQVXZWNksreWE0?=
 =?utf-8?B?b2hYbmVIZC9mT1Y0WEV3T3lrV0hCRGRQUGZkRUxqM2hFY053UG4zMjZ6a3NC?=
 =?utf-8?B?b2NhYlhlY0YrMCtlbWVuMFRIa1hIN0ZtN29JT3ByZW9RQzVRdjhHRGNBV2U4?=
 =?utf-8?B?ODBRSmtoWWpQS2JuRHBIQlp6eCtFNVRNOURCZlN6VEQ1L294TVltaFJVanQ5?=
 =?utf-8?B?Vlcxdlh5VFdLTEpxR0ltS3p6VDNpZ2g2V2NrYzYzN0xZTXhydGlqRUJmalVk?=
 =?utf-8?B?Sy9oVGlrZFJSNkFYMlg3WXVYTjJQMUZRbEZkVmpSaVhuSzhQaWlxYnhXSFNW?=
 =?utf-8?B?bzJSYnJKbW1YT096Z1ZWSFRlRE9lUnhxZ2RxWHJhRDE3YTFHYzZaWGlYTzht?=
 =?utf-8?B?bTJ1K0E1U1A2M2Q2dzZxSU1WVFAwVWlYN3pIZGpwb1dLclBMOHNENE9NTnFk?=
 =?utf-8?B?aWY0MHMwVHlDOUVOU0RNU1FBRVNOM3hGWC9jcm5DS1JjVktBVmxTcXFkNjBJ?=
 =?utf-8?B?NlMvZExhYUJyNU9iYlpBQmoxaG9aRGcrVHdwQ1R6NXR4M3NNRmZVVzNHSmRj?=
 =?utf-8?B?QWRwSkx5NmRtVThmWUFKWjhYSnFFRHNUSzNkUGIwd3p1MC8zNDVIYm1INWNm?=
 =?utf-8?B?UWlSSDNyckt6Smw0VE1FeEFIY3FocCs3U3NEbDcxczBVRFVYOVMwM2ZWRVln?=
 =?utf-8?B?R2lpU21CK0xIeXNRbytlNkdRNW1LS2R5SnkwNnlmKzY3ck9wWHoxVUw2VFVU?=
 =?utf-8?B?YkkzZ24ycEdUMXZCSlZmUzUzRWlvOWxvS21GUE9oNEJTUW5KWmJzc2RoWExR?=
 =?utf-8?B?Nm01UVRDeVJON01IUVQzeFdScXpiT1lFdGxGN2prU1B6bWY0ZlNTSnBlMTNR?=
 =?utf-8?B?MEZyS1hDeXdKZzE0eldjNit6NmdpU1BQb2ozVUkrR0JDTjZZYmpYM1hlWHA2?=
 =?utf-8?B?WGw0Y213a2JsR21OYWUzcWlQbW9hZHZWM2E3L0hmWk91clR1bW5Jbk1Hc1dZ?=
 =?utf-8?B?dzg2Z25DMjM1em13RkwvYlp5a3kzY21aYSt3VStMVXRqQTJuTmVlWitPOURP?=
 =?utf-8?B?cVQ2VzI0SXo1VUdpMWZsYklDQ3VVNm9lNTUwd1k1d0pVZ2dTL3J6d3I4YWV3?=
 =?utf-8?B?VmtULzJVbzY5aWQyQzdBeVNDdjk4Njg3dlZJcm9BUmYzclRSQTQrVnk0NFRU?=
 =?utf-8?B?ckZYOERVa1VYUVB1UjA1bzVQREpJY05obG9NQ2w4bnVNSzBwK1VkVGtPMVZs?=
 =?utf-8?B?cTlYeWV4ZCtyUUUwc3Uzc3hKZE4yd1hqeGtmbExxblRpNkxYYmpldVBEQ0hI?=
 =?utf-8?B?RzNFdWpodmZIMjJXVXZJWGZsbUFTU0ozRW4rSWl4RnNVYmVnV21vT2xEYlVi?=
 =?utf-8?B?WEhDbGpwdXB0Mm9JRG4vaWlhRmxGeThGTVRmOXBIWnIzeG43NTlKcUZJS2pk?=
 =?utf-8?B?d2lRcmY4Z2N4dkNSclBySklZTWd4amxiTUw5bkJvQWozRytkdEpialJFb1p0?=
 =?utf-8?B?Z1l5RWcrbG85T3ZtRkFnVVFFR3ByM3F5d2lDbFQ5cytvSk5YWkJrYWc1RUc2?=
 =?utf-8?B?eE4wdmtXMTdtU01CdUVpVTlSdjV0dmMvUitMamhzQTU1SzJoK0dZMmpXZVlU?=
 =?utf-8?B?bzhOdDFSQ2VmMGJiODIzOFRvRWtOZGNXWGk1WUVyWlY0b1VHNTNoMHRGelpv?=
 =?utf-8?B?WGxuQStiY09OWXVmVEdrU0tyVzBZdFA5OWR5L2UydnhMUW14emhMM0JNS2VE?=
 =?utf-8?B?cGF1MXFxdlpXTytFUVhsQXlXamJ0SnNlalRvV2I4YWxiMWlLUkRHbU9vNFpu?=
 =?utf-8?Q?js5fPIaJX04i7mswNibAhy0oT?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1DD3A292B760E54DB386116A342532D5@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5176.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d947a51-ca74-4275-d225-08dc2ddc0cd1
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2024 04:10:31.0879
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vzvV+u0p5M11PtF1Wv0B0FWUXHJ97ZgFOMA50dNmfDTmj5037RVAtNFNJ1Z1/eaVfkEoPiwtLInYDvQdUH98oP7+M3kVgsJCnuXLsRx77rw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB5966

SGkNCg0KT24gMi8xNC8yNCAwMjoyOSwgSm9oYW5uZXMgQmVyZyB3cm90ZToNCj4gRVhURVJOQUwg
RU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Ug
a25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBIaSwNCj4gDQo+Pj4gRm9yIHJlZmVyZW5j
ZSBoZXJlJ3MgdGhlIG9sZCBkaXNjdXNzaW9uOg0KPj4+DQo+Pj4gaHR0cHM6Ly9wYXRjaHdvcmsu
a2VybmVsLm9yZy9wcm9qZWN0L2xpbnV4LXdpcmVsZXNzL3BhdGNoLzIwMjIwNzIwMTYwMzAyLjIz
MTUxNi0xLWFqYXkua2F0aGF0QG1pY3JvY2hpcC5jb20vDQo+Pj4NCj4+PiBBbnkgdm9sdW50ZWVy
cyB0byBoZWxwIGZpeCB0aGlzPyBJIHdvdWxkIHByZWZlcnMgZml4ZXMgZm9yIGlzc3VlcyBsaWtl
DQo+Pj4gdGhpcyBjb21wYXJlZCB0byBxdWVzdGlvbmFibGUgcmFuZG9tIGNsZWFudXBzIHdlIGFs
d2F5cyBnZXQuDQo+Pg0KPj4gSSdtIGJ1bXBpbmcgdGhpcyBvbGQgdGhyZWFkIGJlY2F1c2UgaXQg
bG9va3MgbGlrZSB0aGUgc3BhcnNlIHdhcm5pbmcgaXMgc3RpbGwNCj4+IHByZXNlbnQgaW4gV0lM
QyBkcml2ZXIsIGFuZCBJIHdvdWxkIGdsYWRseSBoZWxwIGdldHRpbmcgcmlkIG9mIGl0LCBidXQg
c2luY2UNCj4+IHRoZXJlJ3MgYWxyZWFkeSBiZWVuIGEgZmFpciBhbW91bnQgb2YgZGlzY3Vzc2lv
bnMgYXJvdW5kIGl0LCBJIGFtIG5vdCBzdXJlIHdoYXQNCj4+IGlzIGV4cGVjdGVkL3doYXQgc2hv
dWxkIGJlIGRvbmUuIEhlcmUgaXMgbXkgdW5kZXJzdGFuZGluZyBzbyBmYXI6DQo+PiAtIEFqYXkg
aGFzIHByb3Bvc2VkIGEgcGF0Y2ggKFsxXSkgd2hpY2ggaW5kZWVkIGZpeGVzIHRoZSB3YXJuaW5n
IGJ1dCBpbnZvbHZlcw0KPj4gbWFueSBjYXN0cw0KPj4gLSBKb2hhbm5lcyBhbmQgSm91bmkgdGhl
biBnYXZlIGRldGFpbHMgYWJvdXQgdGhlIG9yaWdpbmFsIGlzc3VlIGxlYWRpbmcgdG8gdGhvc2UN
Cj4+IGNhc3RzIChbMl0pOiB3cGFfc3VwcGxpY2FudCBzb21laG93IGZvcmNlcyB0aGUgQUtNIHN1
aXRlcyB2YWx1ZXMgdG8gYmUgYmUzMiBhdA0KPj4gc29tZSBwb2ludCwgd2hpbGUgaXQgc2hvdWxk
IGJlIHRyZWF0ZWQgaW4gaG9zdCBlbmRpYW5uZXNzDQo+PiAtIGFzIHBvaW50ZWQgYnkgQWpheSwg
dGhlIGNvcnJlc3BvbmRpbmcgZml4IGhhcyBiZWVuIG1hZGUgc2luY2UgdGhlbiBieSBKb3VuaSBp
bg0KPj4gd3BhX3N1cHBsaWNhbnQgKFszXSkuIFRoZSBmaXggbWFrZSBzdXJlIHRvIGhhbmRsZSBr
ZXlfbWdtdF9zdWl0ZSBpbiBob3N0DQo+PiBlbmRpYW5uZXNzIEFORCB0byBrZWVwIGNvbXBhdGli
aWxpdHkgd2l0aCBjdXJyZW50IGRyaXZlcnMgaGF2aW5nIHRoZSBiZTMyIGZpeC4gLQ0KPiANCj4g
QW0gSSBjb25mdXNlZCwgb3IgaXMgdGhlIGNoYW5nZSBbM10gaW4gdGhlIG90aGVyIGRpcmVjdGlv
bj8NCj4gDQo+IEZyb20gd2hhdCBJIHNlZSwgdGhlIGNvZGUgdGhlcmUgKG5vdyBjaGFuZ2VkIGFn
YWluLCBidHcpIGlzIGFib3V0DQo+IHJlYWRpbmcgdGhlIHZhbHVlICpmcm9tIHRoZSBkcml2ZXIq
Lg0KPiANCj4gVGhlIGRyaXZlciBjaGFuZ2UgaXMgYWJvdXQgZ2V0dGluZyB0aGUgdmFsdWUgKmZy
b20gdGhlIHN1cHBsaWNhbnQqLg0KPiANCj4gQW5kIHRoZSBfb3V0Z29pbmdfIGNvZGUgKHNlbmRp
bmcgaXQgdG8gdGhlIGRyaXZlcikgZnJvbSB0aGUgc3VwcGxpY2FudA0KPiBoYXMgLSBhcyBmYXIg
YXMgSSBjYW4gdGVsbCAtIGJlZW4gcHV0dGluZyBpdCBpbnRvIHRoZSBhdHRyaWJ1dGUgaW4gaG9z
dA0KPiBieXRlIG9yZGVyIGZvcmV2ZXI/IFNlZSBjb21taXQgY2ZhYWI1ODAwN2I0ICgibmw4MDIx
MTogQ29ubmVjdCBBUEkNCj4gc3VwcG9ydCIpLg0KPiANCj4gDQo+IEFoYSEgU28sIEknbSBub3Qg
X2NvbXBsZXRlbHlfIGNvbmZ1c2VkLCBob3dldmVyLCB0aGUgb25seSB1c2Ugb2YgdGhpcw0KPiB2
YWx1ZSBpbiB0aGlzIGRyaXZlciBpcyBzZW5kaW5nIGl0IGJhY2sgdG8gdGhlIHN1cHBsaWNhbnQh
IFdoaWNoIHNlZW1zDQo+IGVudGlyZWx5IHdyb25nLCBzaW5jZSB0aGUgc3VwcGxpY2FudCBhc3N1
bWVzIGJhc2ljYWxseSBhbnl0aGluZyB3aWxsIGJlDQo+IGhhbmRsZWQ/DQo+IA0KPiAoQnV0IC0g
dGhlIGZpcm13YXJlIGFsc28gaGFzIGEgcGFyYW1ldGVyIGtleV9tZ210X3N1aXRlcyBbaW4gc3Ry
dWN0DQo+IHdpbGNfZXh0ZXJuYWxfYXV0aF9wYXJhbV0gd2hpY2ggaXMgbmV2ZXIgZXZlbiBzZXQg
aW4NCj4gd2lsY19zZXRfZXh0ZXJuYWxfYXV0aF9wYXJhbT8/KQ0KPiANCj4gDQoNCnllYWgsICpr
ZXlfbWdtdF9zdWl0ZXMqIGlzIG5vdCBwYXNzZWQgdG8gdGhlIGZpcm13YXJlLiBJdCBpcyBhZGRl
ZCB0bw0KKndpbGNfZXh0ZXJuYWxfYXV0aF9wYXJhbSogYnV0IGl0IHdhcyBub3QgbmVjZXNzYXJ5
IHNpbmNlIFNBRSBBVVRIIGlzDQpvZmZsb2FkZWQgdG8gdXNlciBzcGFjZSBzbyBpdCB0YWtlcyBj
YXJlIG9mIGNvbXBsZXRlIEFVVEggZXhjaGFuZ2UgYW5kDQpvbmx5IGNvbmZpcm0gb25jZSBpdCBp
cyBkb25lLiBrZXlfbWdtdF9zdWl0ZXMsIHdoaWNoIGlzIHJlY2VpdmVkIGluDQpjb25uZWN0KCks
IGlzIG5lZWRzIHRvIGJlIG1haW50YWluZWQgaW4gZHJpdmVyIHRvIHBhc3MgYmFjayB1c2luZw0K
Y2ZnODAyMTFfZXh0ZXJuYWxfYXV0aF9yZXF1ZXN0KCkuDQoNCj4gQWxzbyBub3RlIHRoYXQgdGhl
IHN1cHBsaWNhbnQgd2lsbCAqb25seSogcmVhZCBSU05fQVVUSF9LRVlfTUdNVF9TQUUgaW4NCj4g
YmlnIGVuZGlhbiwgc28geW91J3ZlIGFscmVhZHkgbG9zdCBoZXJlIHByZXR0eSBtdWNoPw0KPiAN
Cj4+ICAtIEl0IGNvdWxkIGhhdmUgYWxsb3dlZCB0byBzaW1wbHkgZ2V0IHJpZCBvZiB0aGUgYWxs
IGNhc3RzIG9uIEFLTSBzdWl0ZXMgaW4NCj4+IHdpbGMgZHJpdmVyIChbNF0pLCBidXQgdGhlbiBu
ZXcga2VybmVsL2RyaXZlcnMgd291bGQgYnJlYWsgd2l0aCBleGlzdGluZw0KPj4gdXNlcnNwYWNl
LCBzbyBpdCBpcyBub3QgYW4gb3B0aW9uDQo+IA0KPiBJIGFtIHdvbmRlcmluZyBpZiBpdCB3b3Jr
cyBhdCBhbGwgLi4uDQo+ID4+IE5vdywgSSBzZWUgbXVsdGlwbGUgb3B0aW9ucyB0byBmaXggdGhl
IHNwYXJzZSB3YXJuaW5nOg0KPj4gLSBhcHBseSB0aGUgc2FtZSBmaXggYXMgZm9yIHdwYV9zdXBw
bGljYW50IChbM10pIGluIHdpbGMgZHJpdmVyIChzbyBiYXNpY2FsbHksDQo+PiBiZWNvbWUgY29t
cGF0aWJsZSB3aXRoIGJvdGggZW5kaWFubmVzcykNCj4gDQo+IEJ1dCB0aGlzIGNhbm5vdCBiZSBk
b25lISBPbiBpbnB1dCB0byB0aGUgZHJpdmVyLCB0aGUgdmFsdWUgaXMgaW4gaG9zdA0KPiBieXRl
IG9yZGVyIGFsd2F5cy4gVGhlIHF1ZXN0aW9uIGlzIG9uIG91dHB1dCAtIGFuZCB0aGVyZSB5b3Ug
Y2Fubm90DQo+IGRldGVjdCBpdC4NCj4gDQo+PiAtIGFwcGx5IHRoZSBzYW1lIGZpeCBhcyBmb3Ig
d3BhX3N1cHBsaWNhbnQgKFszXSksIG5vdCBpbiB3aWxjIGJ1dCBpbiBubDgwMjExDQo+PiAobWF5
IG5lZWQgdG8gdXBkYXRlIG5vdCBvbmx5IHdpbGMgYnV0IGFueSBkcml2ZXIgaGF2aW5nIHRyYWls
aW5nIGJlMzIgY2FzdCBvbg0KPj4gQUtNIHN1aXRlcykNCj4gDQo+IFRoYXQgbWlnaHQgZXZlbiB3
b3JrPyBXZWxsLCBub3QgdGhlIHNhbWUgZml4LCBzaW5jZSBhZ2FpbiBpbnB1dCB2cy4NCj4gb3V0
cHV0LCBidXQgc29tZXRoaW5nIGxpa2UgdGhpczoNCj4gDQo+IC0tLSBhL25ldC93aXJlbGVzcy9u
bDgwMjExLmMNCj4gKysrIGIvbmV0L3dpcmVsZXNzL25sODAyMTEuYw0KPiBAQCAtMjAxMzYsOSAr
MjAxMzYsMjcgQEAgaW50IGNmZzgwMjExX2V4dGVybmFsX2F1dGhfcmVxdWVzdChzdHJ1Y3QgbmV0
X2RldmljZSAqZGV2LA0KPiAgICAgICAgIGlmICghaGRyKQ0KPiAgICAgICAgICAgICAgICAgZ290
byBubGFfcHV0X2ZhaWx1cmU7DQo+IA0KPiArICAgICAgIC8qDQo+ICsgICAgICAgICogU29tZSBk
cml2ZXJzIGFuZCBkdWUgdG8gdGhhdCB1c2Vyc3BhY2UgKHdwYV9zdXBwbGljYW50KSB3ZXJlDQo+
ICsgICAgICAgICogaW4gdGhlIHBhc3QgaW50ZXJwcmV0aW5nIHRoaXMgdmFsdWUgYXMgYSBiaWct
ZW5kaWFuIHZhbHVlLA0KPiArICAgICAgICAqIGF0IGEgdGltZSB3aGVyZSBvbmx5IFdMQU5fQUtN
X1NVSVRFX1NBRSB3YXMgdXNlZC4gVGhpcyBpcyBub3cNCj4gKyAgICAgICAgKiBmaXhlZCwgYnV0
IGZvciB0aGUgYmVuZWZpdCBvZiBvbGRlciB3cGFfc3VwcGxpY2FudCB2ZXJzaW9ucywNCj4gKyAg
ICAgICAgKiBzZW5kIHRoaXMgcGFydGljdWxhciB2YWx1ZSBpbiBiaWctZW5kaWFuLiBOb3RlIHRo
YXQgbmV3ZXINCj4gKyAgICAgICAgKiB3cGFfc3VwcGxpY2FudCB3aWxsIGFsc28gZGV0ZWN0IHRo
aXMgcGFydGljdWxhciB2YWx1ZSBpbiBiaWcNCj4gKyAgICAgICAgKiBlbmRpYW4gc3RpbGwsIHNv
IGl0IGFsbCBjb250aW51ZXMgdG8gd29yay4NCj4gKyAgICAgICAgKi8NCj4gKyAgICAgICBpZiAo
cGFyYW1zLT5rZXlfbWdtdF9zdWl0ZSA9PSBXTEFOX0FLTV9TVUlURV9TQUUpIHsNCj4gKyAgICAg
ICAgICAgICAgIGlmIChubGFfcHV0X2JlMzIobXNnLCBOTDgwMjExX0FUVFJfQUtNX1NVSVRFUywN
Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY3B1X3RvX2JlMzIoV0xBTl9BS01f
U1VJVEVfU0FFKSkNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgZ290byBubGFfcHV0X2ZhaWx1
cmU7DQo+ICsgICAgICAgfSBlbHNlIHsNCj4gKyAgICAgICAgICAgICAgIGlmIChubGFfcHV0X3Uz
Mihtc2csIE5MODAyMTFfQVRUUl9BS01fU1VJVEVTLA0KPiArICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHBhcmFtcy0+a2V5X21nbXRfc3VpdGUpKSkNCj4gKyAgICAgICAgICAgICAgICAg
ICAgICAgZ290byBubGFfcHV0X2ZhaWx1cmU7DQo+ICsgICAgICAgfQ0KPiArDQo+ICAgICAgICAg
aWYgKG5sYV9wdXRfdTMyKG1zZywgTkw4MDIxMV9BVFRSX1dJUEhZLCByZGV2LT53aXBoeV9pZHgp
IHx8DQo+ICAgICAgICAgICAgIG5sYV9wdXRfdTMyKG1zZywgTkw4MDIxMV9BVFRSX0lGSU5ERVgs
IGRldi0+aWZpbmRleCkgfHwNCj4gLSAgICAgICAgICAgbmxhX3B1dF91MzIobXNnLCBOTDgwMjEx
X0FUVFJfQUtNX1NVSVRFUywgcGFyYW1zLT5rZXlfbWdtdF9zdWl0ZSkgfHwNCj4gICAgICAgICAg
ICAgbmxhX3B1dF91MzIobXNnLCBOTDgwMjExX0FUVFJfRVhURVJOQUxfQVVUSF9BQ1RJT04sDQo+
ICAgICAgICAgICAgICAgICAgICAgICAgIHBhcmFtcy0+YWN0aW9uKSB8fA0KPiAgICAgICAgICAg
ICBubGFfcHV0KG1zZywgTkw4MDIxMV9BVFRSX0JTU0lELCBFVEhfQUxFTiwgcGFyYW1zLT5ic3Np
ZCkNCj4gfHwNCg0KDQpJTU8gdGhpcyBwYXRjaCBpcyBiZXR0ZXIgc29sdXRpb24gc2luY2UgaXQg
Y292ZXJzIGZvciBib3RoIG9sZCBhbmQgbmV3DQp3cGFfcygzKSBhbmQgZXZlbiB0aGUgZml4ZXMg
aW4gbmV3IHdwYV9zIGFyZSBub3QgcmVxdWlyZWQgd2l0aCB0aGlzDQpjaGFuZ2UuIEFmdGVyIHRo
aXMgY2hhbmdlLCB0aGUgZHJpdmVyIGNhbiBiZSBtb2RpZmllZCB0byB1c2UgdGhlIGhvc3QNCmJ5
dGUgb3JkZXIgdGhhdCB3aWxsIGFsc28gcmVzb2x2ZSB0aGUgc3BhcnNlIHdhcm5pbmcuDQoNCg0K
UmVnYXJkcywNCkFqYXkNCg==

