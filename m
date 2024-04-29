Return-Path: <linux-kernel+bounces-162005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AA1E8B547C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 11:48:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D32C1C21981
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 09:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C113428DDA;
	Mon, 29 Apr 2024 09:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="OqzZwsDF";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="fabO4xfX"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2CB1D554;
	Mon, 29 Apr 2024 09:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.154.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714384080; cv=fail; b=rrWqjTiFCMqh2FSSYco0Bte77gXLVThBd3JQx8nNaPrsJjiTPoDrjkhzJLywoS6thkfSk7GuKbInQq92KGTvl8M+WQdIuU3tcoNC9Km0ciiBHZfUk/WMZG9KfbJryQCk77OjxW4722louxzOxp7cxqRrNWyrUiKOLkVrfWqA0/E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714384080; c=relaxed/simple;
	bh=efWwYwksEEvEEhWBE6kAgFw8Du/e2Xssrhl4WIBbbxw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uUnxZ4aX04vlFdmLBXJy1Qz5ZmvoaBmV47r3yJ2L5tO0RnQ0OSCx5y8/EEJkAvzHZZR+zShktFYrRZtvRIirRzgKJmHYCFnR/6GUA5AB6ref9mY14UfHaU4JMKMBA0SjXGydVD41trTFq9/BgktRFvRRHl8Yxr1+PT5QSlnn3dA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=OqzZwsDF; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=fabO4xfX; arc=fail smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1714384078; x=1745920078;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=efWwYwksEEvEEhWBE6kAgFw8Du/e2Xssrhl4WIBbbxw=;
  b=OqzZwsDFJCv+TLiTfV9GR1/pc7RxGF8xR4atd+BaYJc1VB+W+nYIr47x
   QmVorR0Zw9HLZ8wXQTb2SXoDSYzqyLTXtJrFbIs6SjmtQTVNmLCQWKQ4L
   n6NIdZCMDc3XLUlMaDpyeoUUIQ77tbqf26EMDL/6laQiqDoJx7JWzkc+R
   aqiazt67aIZ+Pn683kkMI99/GP6c2YqvU50h38VNuTmecpjVrXx+2QOFF
   8Mt6ybttTaZVDXmlZNrw8/P5VDtoiDANG2WlbTbTsYWdO9CF7J4+bYhON
   yR9R3KYs38DOJOT5RXbZkCX/j5oRYyh1Yez/5oc6bnbwD6x/o0m2JRiJu
   w==;
X-CSE-ConnectionGUID: wLI7ovIcRS2nJtdroufz/A==
X-CSE-MsgGUID: ll39Yr82RbmDg637zCkORg==
X-IronPort-AV: E=Sophos;i="6.07,239,1708412400"; 
   d="scan'208";a="23758305"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Apr 2024 02:47:56 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Apr 2024 02:47:38 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 29 Apr 2024 02:47:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KUwjWp6b3yZEtpoDuFvb3nr5u2dQpJnBidlnoocNU4iAr6YSY4AlWbmO9Mxw4CmkR907mmIJZuBGfI7rVrMT5RdJdPyGArd+ZH4CvI09xzgRoYWSYzoabCjCO21U5OwpC3nuCV7ohSD6Dg+gtps5PhxX5jgxON0IBguoU3MtS7ynZT+OdaZ96B6/X8oGDOFqfGxRweXzRt7onYG0Y3SjAVUxbFOVbzcy+sCxKvw6R0TQuZ/uamJ9Pj6s/fFi5e0dhBvTHC/LGhg3O/VGnTKg1BK3t5zeJb9FbCazEP/OWcJ3SeCmA+8YZvIzvKyrkgV0TUITvRos0IYUIs49+1w2IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=efWwYwksEEvEEhWBE6kAgFw8Du/e2Xssrhl4WIBbbxw=;
 b=ZT1eAp5wgMwppDms0Z0dzJqNn7nFQXN0Q6wbC4BN9kPMa3PJ72Wwqsr/REBXthJYkJaTpQOS/GCERRWt8LoTlGDoIR/dwnHWz9OajUE6DN53KUzxNEKl0/bLOEEoVcNoUpmrsxcDuwpa7QOubBsozTmZG+Kr+G3z1NYWGtqz0wlkTDSc0+4gOFIhHPYeGUDFE0riOTBdJun7+Ux9n3c5MQzoDGrm7O6F9bfc1hWgwjUh1o4jpsHVWG9XxF3+ZKDN2hWs0TLObqIwERZH7gc7pJ2JMhPsHzjpkR+A6OLzPgjfsuKZrgWg85rO8jg76GL5+DBdiKHqJgiFd6vBD042rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=efWwYwksEEvEEhWBE6kAgFw8Du/e2Xssrhl4WIBbbxw=;
 b=fabO4xfXkS0Gnoymhvw6wQlT3/yW89qUaw8sqFnyXF3y55afVBm3j7A5R5OfhW6ye1j4TuLj81SnZn1ffHdGIxo/nRHW0UPqpqU0nuIW10KU2au8Q6kqwXjPeciyyfgncC7U7BKREkP4rGi+anDMzs0/ir3nN0eWlHiGHSCcZy9HcqXTBDcaJb0SKyFJlsM5h/iFZNp/y3+7LexwYUReAQ1FIV5a5J57EyNwvLTjHRirEhvaX/yrnzBt6rf5B+Dv2kQIqY5NT872C00lZTsXa9tLhAaJRW1MiC2zF7E+kRJK10rzq0+3ITVPHC61jlmO9RmutGA/BUXj4HKR/cKCOw==
Received: from SA1PR11MB8278.namprd11.prod.outlook.com (2603:10b6:806:25b::19)
 by PH7PR11MB7002.namprd11.prod.outlook.com (2603:10b6:510:209::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.32; Mon, 29 Apr
 2024 09:47:34 +0000
Received: from SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9]) by SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9%4]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 09:47:34 +0000
From: <Parthiban.Veerasooran@microchip.com>
To: <conor@kernel.org>, <ramon.nordin.rodriguez@ferroamp.se>, <andrew@lunn.ch>
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
Subject: Re: [PATCH net-next v4 11/12] microchip: lan865x: add driver support
 for Microchip's LAN865X MAC-PHY
Thread-Topic: [PATCH net-next v4 11/12] microchip: lan865x: add driver support
 for Microchip's LAN865X MAC-PHY
Thread-Index: AQHakZAq1RqgTRBTy0mY7YMhKP6dQLF8jIwAgAAKqICAAnocgA==
Date: Mon, 29 Apr 2024 09:47:34 +0000
Message-ID: <1ae4f1d5-140b-41b1-9191-da14fd67d409@microchip.com>
References: <20240418125648.372526-1-Parthiban.Veerasooran@microchip.com>
 <20240418125648.372526-12-Parthiban.Veerasooran@microchip.com>
 <Zi1PxgANUWh1S0sO@builder> <20240427-vaporizer-pencil-be6a25030f08@spud>
In-Reply-To: <20240427-vaporizer-pencil-be6a25030f08@spud>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8278:EE_|PH7PR11MB7002:EE_
x-ms-office365-filtering-correlation-id: 02518a14-b52d-4947-3318-08dc683165a0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|7416005|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?dkxqZnJxbGZoMUlGWldOUmx0M0VadTg3U1Z3WlN6djgyampWT0xNTFBmMU9l?=
 =?utf-8?B?TE1hQlRlUEVGYW5CdU9KUFlXN28xY0JCUzdDc0psZFM5Rzg5UStkWE82UW1r?=
 =?utf-8?B?blB0KzRnODF2QXQ3K2lWQVorZmUwNmhCRUlkbGw4REJJQjg3ajFSYU5pc1FC?=
 =?utf-8?B?SG9FQy9ZY1JoVjVKbVorQjlCTXhEdXdrUi9IZDVZb2RabDAwUytpZ3lSajdu?=
 =?utf-8?B?UU5DdnI5Rk5FZUFQb3VRekQvSmx4eTUwcmJtWlJ6aFlHN3Q0Y2pzSXhFaDFa?=
 =?utf-8?B?eFlkSDRUZ3JITTNLT1Z6UTVpNVZVUDE4L2NWaENwVEd4L0srME9HSjRwQ2E3?=
 =?utf-8?B?ZExhdGhheU9FM0xFSUhnam9vcmNCb1hqdjM4T3NvN0tVMXYyK1EwU1FGZFFl?=
 =?utf-8?B?MTVEa0ZvNnk3TS8xZVN0VEdQS25pc0w0T1oycVdKek9zV2pYbkJkL1pGeTM2?=
 =?utf-8?B?c3R4aUdzTVJ2N1krUVhZVG1yUHlEVDNIYTRnek5Da0NVVDBDdVR5VGM0T1pS?=
 =?utf-8?B?c3pTMUd2eXVHUHlac0VNQ2hhSGZCNDBjZVcxd3pnWlkwUzNaRStkeU55QXlo?=
 =?utf-8?B?SkNSQXRCeGluOVpMMTVFa0dmcFNmVkNYYW1MZEhDanhrWkxYV253TTNqNU1k?=
 =?utf-8?B?N3VEa2ZCcFBRMUU5YjM0ZW0zZitIZVJBaTJlOTFoSm9oMk5mZUZqbEZDTmlO?=
 =?utf-8?B?MDNqSzJOM2lYWDhlb3plTDdBdS80TlkzREZUWWR5YzFmYkV3ZUMvdGRQcTRo?=
 =?utf-8?B?UVB0S2FTanNYaW16MFRZOVhLM0trdE04NVprWEx5cWxCajlzdVdmbUlORGFU?=
 =?utf-8?B?K2FEV2VqRlNaMlNsTFhOdnRoeFRlaURFbnpDRXdYeVp0N1U3dXV1enNBVGtB?=
 =?utf-8?B?Tld1cTJsTGlDaGpmWEc2MUFUM0dkN0ErNjZITnJjMVZJSG9PeHBvMzhnWU1q?=
 =?utf-8?B?NHg1MnRBNE16R29XZXhDT3ZNNm8yUlVwQkNoRmE1UVJLSmltNW1kRG55YkJr?=
 =?utf-8?B?eGUxSUhnbnI1cVdrUng5VUM5VmNPZW5VWE85TjJFNUhZSTN0QUM1VWRSTEgv?=
 =?utf-8?B?bzV0Zm44QjVaSzc1Skorek1OTHhaR1RudDlXNFVuSXdTK3VzbFB1aUwwQjRk?=
 =?utf-8?B?bk1wMWpCNGdrd3N6cEtVYXBiMlo4ZDhkNmVPd2s2MW5MTWN4VFIxUGF0cFpF?=
 =?utf-8?B?NG5CWCt5QzdzTElNUG1vdVZLQnJxek5KanRLSWxaaVdQZFU5VzU5QWl6Vk9U?=
 =?utf-8?B?dmZacy9sM1I5Vi9hMy9VRWw1WUVpRjM1Y2U0aVZQOUQ0YStoZGQzbkZEZ1p5?=
 =?utf-8?B?bGpFblJkMjBhU0ZzbHhITTdYb0U3TnE3aXFrZ3lPQzRYcHREQ29IeVNlcS9q?=
 =?utf-8?B?aFBWQTdmaytwRVNYUVRiQnlZekhwZlFYZDcrWVk1UWVKTHV6YVBCbUN6YXM1?=
 =?utf-8?B?L1RrK3haK0t2YXczTGtjdjYralNHS0tZUWl3NlR1Zks4am1wLy8wenRYTUg1?=
 =?utf-8?B?Y2tkZnNhM1BHbVo3LzY1bzVzTzc1Q0lWbTNsSldCeTNLdDlOM0g4R04wQVlR?=
 =?utf-8?B?VTlyTzF1ZndWemhGeU93RXRWQXBVS3UyeDN2K3JmTVIwckVkVSswZlA5anhr?=
 =?utf-8?B?U1JRT09WWWlPbmcvbGtnSENTYWVpTEtVVEtjTEZWeElRbEtiaFczNS9TUGZi?=
 =?utf-8?B?bHI3d3RYMzFTdzUzT1ZWVlM1em9US0JKSzZBeDFvaHRLcDZjS2tMUjVpQ3F1?=
 =?utf-8?B?Rk50VHRkOWQ5R3IxNEpCWnAwR3RjdXl5Zk1lTDdpYVpaZzdwZDZ6N0sxN1JB?=
 =?utf-8?B?RjRhL2R5SkpCM2FOQWpIQT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8278.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dElIZjY0TWZHdTFlWTdSdXVXanB0NTl4WktwdGZ2RW5GcVZLSEdUU3BodFlm?=
 =?utf-8?B?WHZGYU0zYWMwYzZIQmVtK0JPemcvMGRZKzRPOFFia0lieDR1aklWaVNxMFNF?=
 =?utf-8?B?RlZXWTY0cTNaeEhGSHhIdmEzT1RtblFOSFRpZjJPNWNjZ2ZQREtkcGRjV2RO?=
 =?utf-8?B?clFaYzdjeEJUd0F6eGo2d3E2U240YVIzRWJxclMzZHhpbE9namp3TUtSNGcz?=
 =?utf-8?B?MklEUVgrQzArS1dTNFBuNGprUnZFVGRIRVF4cXdZMWp3eW8wamxJRUZkcjhv?=
 =?utf-8?B?dGF6MWc0S1NCMmsxaHlucWdPeWQvc3lFeTVjT3M0YkdOV1YwT0oxbTNDaGZN?=
 =?utf-8?B?Q3B4ci9kV3VxN3pRcFc1ZTlyYW1IYUtQUFRDS3NqOXhYOWxSdGFLWTZJaGhz?=
 =?utf-8?B?TzEyK3FuNGYxT3A1MlFqZ0huOUVEelBNZHFBUnBzcjVHNnZqZUtpTXl2WnYx?=
 =?utf-8?B?L3JzSlROMUhnOTFLZW9RS0dRa3FQNGpheER0d3FtRVBsWXc0RFQ5dUJYelk1?=
 =?utf-8?B?cCsrMVVjYy9tdklTTmhXOHh1dG9XaCtxZy9VK25tdzBzb21QWkwrVE04ejZF?=
 =?utf-8?B?OHlMb3ZSUTlDdGhra2Y5aDJseWRYcUZKZ0cxYjZiK2NvMDNUSUdCYXNOcHV1?=
 =?utf-8?B?NnRUREY3QVAzOS92d21PZHVhRHFNQVd5ejJKU25YdHY5MHgwZnFrRWk2eGhx?=
 =?utf-8?B?bklTbnc3MnBqNnhKdGJkV0JEaDdLcEtRNWpxMWdiZkdIS1JGQ3FDaFZVS2Ux?=
 =?utf-8?B?b0FuNnN5eFJ6bzFBWW5kaFdrVFFkckVwSnRZeXB0REJsWGR2bUh5dGRJOWVF?=
 =?utf-8?B?aFI1SDV6cGhzUFJhS1dHMUZ1cytFaVVveVlncE91bFNuenNtb0RXVnErZDht?=
 =?utf-8?B?MHdFUjh2VDZGanQ2R0dGVUY4TG45VW9LK3NPRXVBOGR6T3VnOEd4TWFvNWVv?=
 =?utf-8?B?ZEFDUDFkZjlKUmo1YkpZVm5qWlNEa1VkbFRWQUNDQms3MzRXUVBiTmVzVkFi?=
 =?utf-8?B?aEFxL3M1REtHaUp1Y2RmOE10dldCRGY0SEg1WXhzaVYyVlRKK1ZSN2dMTlg3?=
 =?utf-8?B?UXRxMUdQSW1oV1pSRjlTaVFnVnJoRVlxb3ZFT3M1Mm1uTUo2QjE1SHFFRnhp?=
 =?utf-8?B?YjdVRlNSZE5keGg1RmRLOXcyY3BmTDI4Nkh1K1Q0U1dBK0xnNnhRZHQ3cnc4?=
 =?utf-8?B?OFd2NjZpYkFHUzZ0RCt2WEhETENlcDJQYlJ5cjg5Q2pyQm10OHNOUmIxYzJv?=
 =?utf-8?B?bWtlRlR1S2szbDdCdU04REJ6MXdnd0thUmFVTFRsSTN0K3pmKzVJODhRV1F4?=
 =?utf-8?B?NDNIVXYrcE1lem85U0ZUTnJ5OXQ0VjhUbENnSHUxZ2FxemtHRDZHekl1MU9T?=
 =?utf-8?B?WWp1Y3QycWVCR1EvTnZnZE1ha2VYN1pFNmo5dUlka2JKbWVRTEd2R0tUL0x3?=
 =?utf-8?B?bVlRdXhxRzZWdEM5aVg5d3JjbFZ4QlMrZFl2UGJjZm5DVU9uQ1ROTFFRcE53?=
 =?utf-8?B?bUNmOXEwSko1cjRwdStqdk1pM1YrcnljZ3pPQjBra293MlphR0YyM2pTZVRC?=
 =?utf-8?B?R1NDeFo4WEpwdjJmSmVYQTBWYUNxakpqVVJMNGJQTFQxcjJDbEFHcXhJdndJ?=
 =?utf-8?B?NjloU1RiMndTejJKajlWaEVzZUpJUUFFTnprWGVNdGVFSVBMWGtPa1JkaFRO?=
 =?utf-8?B?dUFYcWNRTHNBMXVSUXluQ05QOStNSzZ4eXdsWS84NzdQQkdnUXMyNllNamt1?=
 =?utf-8?B?RHBLanBoWGo5MmMxb1E1WmE0K2VoS1RGeGNnMHZDYktRcndCVy9ZdWJjYlI1?=
 =?utf-8?B?QnBpdVNIOFcrNkFOd0k0enVaSi8rTDJlR1JES01PTTQzSDJWcDlpZkdCR1Mr?=
 =?utf-8?B?aGNHOWcyOGo5a3AvTi9JMHdmYnU1YVozY0FVRUc1TU5tMjZCOVZoRk1CQ25r?=
 =?utf-8?B?ME5ldmxvNWNGVzRYVTkxQWdKOXlqcHFLOFN0YVhXYyt3aWZySjU1NW5hL0RY?=
 =?utf-8?B?c1RoelBpU2VWaXZ5ZklDWndtSjlibnhnNUtyVVBhRDMxMWlOS2svc29iK2pD?=
 =?utf-8?B?VHJPZEZkWThPUUJBTy9HdEJUU3dpR1A5V1lPSHRFWnJSNVVhTTU5SW5ycjhl?=
 =?utf-8?B?dGtrb1REMWdkQUFGbWoreDhmZEIzWE1tVUZFLzIxTE1Nd3grOGFsSVI2MXRE?=
 =?utf-8?B?VXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <836D5E536373014A931DFC2456A104DE@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02518a14-b52d-4947-3318-08dc683165a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2024 09:47:34.6944
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OLn+dXyJB/y7TnTvvUfM63f68AaE0mPjUN7yZDtqzMnEujMi6g3D7Fa3JHiiCKLDxt+WRlGcMRzvpDZUz9kYmQkaQmRLoCLBgM7on6rPQbBGh3S29AINiv1qFDDPViD+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7002

SGkgQWxsLA0KDQpPbiAyOC8wNC8yNCAxOjI3IGFtLCBDb25vciBEb29sZXkgd3JvdGU6DQo+IE9u
IFNhdCwgQXByIDI3LCAyMDI0IGF0IDA5OjE5OjM0UE0gKzAyMDAsIFJhbcOzbiBOb3JkaW4gUm9k
cmlndWV6IHdyb3RlOg0KPj4gSGksDQo+Pg0KPj4gRm9yIG1lIHRoZSBtYWMgZHJpdmVyIGZhaWxz
IHRvIHByb2JlIHdpdGggdGhlIGZvbGxvd2luZyBsb2cNCj4+IFsgICAgMC4xMjMzMjVdIFNQSSBk
cml2ZXIgbGFuODY1eCBoYXMgbm8gc3BpX2RldmljZV9pZCBmb3IgbWljcm9jaGlwLGxhbjg2NTEN
Cj4+DQo+PiBXaXRoIHRoaXMgY2hhbmdlIHRoZSBkcml2ZXIgcHJvYmVzDQo+Pg0KPj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L21pY3JvY2hpcC9sYW44NjV4L2xhbjg2NXguYyBi
L2RyaXZlcnMvbmV0L2V0aGVybmV0L21pY3JvY2hpcC9sYW44NjV4L2xhbjg2NXguYw0KPj4gaW5k
ZXggOWFiZWZhOGI5ZDlmLi43MmE2NjNmMTRmNTAgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL25l
dC9ldGhlcm5ldC9taWNyb2NoaXAvbGFuODY1eC9sYW44NjV4LmMNCj4+ICsrKyBiL2RyaXZlcnMv
bmV0L2V0aGVybmV0L21pY3JvY2hpcC9sYW44NjV4L2xhbjg2NXguYw0KPj4gQEAgLTM2NCw3ICsz
NjQsNyBAQCBzdGF0aWMgdm9pZCBsYW44NjV4X3JlbW92ZShzdHJ1Y3Qgc3BpX2RldmljZSAqc3Bp
KQ0KPj4gICB9DQo+Pg0KPj4gICBzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCBsYW44
NjV4X2R0X2lkc1tdID0gew0KPj4gLSAgICAgICB7IC5jb21wYXRpYmxlID0gIm1pY3JvY2hpcCxs
YW44NjUxIiwgIm1pY3JvY2hpcCxsYW44NjUwIiB9LA0KPiBIdWgsIHRoYXQncyB2ZXJ5IHN0cmFu
Z2UuIEkgZG9uJ3Qgc2VlIGEgc2luZ2xlIGluc3RhbmNlIGluIHRoZSB0cmVlIG9mIGENCj4gb2Zf
ZGV2aWNlX2lkIHN0cnVjdCBsaWtlIHRoaXMgd2l0aCB0d28gY29tcGF0aWJsZXMgbGlrZSB0aGlz
IChhdCBsZWFzdA0KPiB3aXRoIGEgc2VhcmNoIG9mIGByZyAiXC5jb21wYXRpYmxlLipcIiwgXCIi
IGRyaXZlcnMvYC4NCj4gDQo+IEdpdmVuIHRoZSBmYWxsYmFja3MgaW4gdGhlIGJpbmRpbmcsIG9u
bHkgIm1pY3JvY2hpcCxsYW44NjUwIiBhY3R1YWxseQ0KPiBuZWVkcyB0byBiZSBoZXJlLg0KPiAN
Cj4+ICsgICAgICAgeyAuY29tcGF0aWJsZSA9ICJtaWNyb2NoaXAsbGFuODY1eCIsICJtaWNyb2No
aXAsbGFuODY1MCIgfSwNCj4+ICAgICAgICAgIHsgLyogU2VudGluZWwgKi8gfQ0KPj4gICB9Ow0K
Pj4gICBNT0RVTEVfREVWSUNFX1RBQkxFKG9mLCBsYW44NjV4X2R0X2lkcyk7DQo+Pg0KPj4gQWxv
bmcgd2l0aCBjb21wYXRpYmxlID0gIm1pY3JvY2hpcCxsYW44NjV4IiBpbiB0aGUgZHRzDQo+IEp1
c3QgdG8gYmUgY2xlYXIsIHRoZSBjb21wYXRpYmxlIHcvIGFuIHggaXMgdW5hY2NlcHRhYmxlIGR1
ZSB0byB0aGUNCj4gd2lsZGNhcmQgYW5kIHRoZSBiaW5kaW5nIHNob3VsZCBzdGF5IGFzLWlzLiBX
aGF0ZXZlciBwcm9iaW5nIGJ1Z3MNCj4gdGhlIGNvZGUgaGFzIG5lZWQgdG8gYmUgcmVzb2x2ZWQg
aW5zdGVhZCDwn5mCDQo+IA0KTG9va3MgbGlrZSwgdGhlIGJlbG93IGNoYW5nZXMgbmVlZGVkIHRv
IHdvcmsgY29ycmVjdGx5LA0KDQpsYW44NjV4LmM6DQotIGNvbXBhdGlibGUgc3RyaW5nIHRvIGJl
IGNoYW5nZWQgbGlrZSBiZWxvdyBhcyBpdCBpcyBhIGZhbGxiYWNrIGZvciBhbGwgDQp2YXJpYW50
cywNCgkuY29tcGF0aWJsZSA9ICJtaWNyb2NoaXAsbGFuODY1MCINCi0gRFJWX05BTUUgdG8gYmUg
Y2hhbmdlZCBsaWtlIGJlbG93LA0KCSNkZWZpbmUgRFJWX05BTUUgICAgICAgICAgICAgICAgICAg
ICAgICAibGFuODY1MCINCg0KbWljcm9jaGlwLGxhbjg2NXguZXhhbXBsZS5kdHMgZm9yIGxhbjg2
NTA6DQotIGNvbXBhdGlibGUgc3RyaW5nIHRvIGJlIGNoYW5nZWQgbGlrZSBiZWxvdywNCgkuY29t
cGF0aWJsZSA9ICJtaWNyb2NoaXAsbGFuODY1MCI7DQoJT1INCm1pY3JvY2hpcCxsYW44NjV4LmV4
YW1wbGUuZHRzIGZvciBsYW44NjUxOg0KLSBjb21wYXRpYmxlIHN0cmluZyB0byBiZSBjaGFuZ2Vk
IGxpa2UgYmVsb3csDQoJY29tcGF0aWJsZSA9ICJtaWNyb2NoaXAsbGFuODY1MSIsICJtaWNyb2No
aXAsbGFuODY1MCI7DQoNCkkgdGVzdGVkIHdpdGggdGhlIGFib3ZlIGNoYW5nZXMgYW5kIHRoZXJl
IHdhcyBubyBpc3N1ZXMgb2JzZXJ2ZWQuIEFueSANCmNvbW1lbnRzIG9uIHRoaXM/IE90aGVyd2lz
ZSB3ZSBjYW4gc3RpY2sgd2l0aCB0aGVzZSBjaGFuZ2VzIGZvciB0aGUgbmV4dCANCnZlcnNpb24u
DQoNCkJlc3QgcmVnYXJkcywNClBhcnRoaWJhbiBWDQoNCj4gVGhhbmtzLA0KPiBDb25vci4NCg0K

