Return-Path: <linux-kernel+bounces-86126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 920BD86C003
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 05:52:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 262FA1F23D65
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 04:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4863439AEB;
	Thu, 29 Feb 2024 04:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="rcA6wZMq";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="jWbUzxvZ"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47EA25765;
	Thu, 29 Feb 2024 04:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.154.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709182354; cv=fail; b=J9K7ihBAbuDGXgeQ2IAoCNLcAznKAmKyectbuuGw438CX5MYejZTt4URDrRJZjjcUVZfPnOJMcoJfvd1oD9rdEmT4nYiMKhMnbafb2LfJU2byYEil+FM03lPst+uC2tT3fpJHfTc6uNGv7Q/P6EQGGbHCVrsitIrJjM+W2zGAdQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709182354; c=relaxed/simple;
	bh=6EHbuGUBRcLaOhIQvjf1JdwWlQn7rv+9JEt40kCwIP0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=poJjzK1bXDpIkV4v+P4mwdlWo4ebXqGDqsrLxQEHm5Rur07XjG7uBEN5iufahR/KUTTF/NkbkA7ADQzuUGPoLWkiDF7FusaBQfk9vsrxywbA7lrrb4uI2euxVbqWmuyP/cI+PB26uOhVLk/bNuz46kEQK/gse/0oimt6dgUHnGU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=rcA6wZMq; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=jWbUzxvZ; arc=fail smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1709182352; x=1740718352;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6EHbuGUBRcLaOhIQvjf1JdwWlQn7rv+9JEt40kCwIP0=;
  b=rcA6wZMqNSHz8xcQE0aALwATO4ot+f9VrVrxwN5Oh2MjH6gTUsOiF3O0
   +GC/CJRwdZHGW2HQKnOgQiG0zpkHzQMvuJt4zGaHu+wamsh91xN1LnCU8
   8KmflTxl6BQBJTKcNrcBWbzdJLfBhgblDj5vsc1SsFlsl663n4SBvwenp
   3093EO32VDoG8lsx9g1LnJ2L4K3FkhWHcCt4ISO6anAnLkBmVBnV4dZQO
   C5BPkn0s0LclGKBSLgUX+YOgzBmfqKby4hsWvWLas6bo27/cX62WzlFwO
   0MW//izgcBkjkUgAaHyfp8S52o/pijbLbLcJWEEe5jOjVeaBNpEWYqHvU
   Q==;
X-CSE-ConnectionGUID: EY6dwZI/QMCpx8DtI2FTCg==
X-CSE-MsgGUID: X8qJG3PxSgicIhXrwXWXow==
X-IronPort-AV: E=Sophos;i="6.06,192,1705388400"; 
   d="scan'208";a="17523937"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Feb 2024 21:52:30 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 28 Feb 2024 21:52:14 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 28 Feb 2024 21:52:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kLw01Jr/dGN0G+I1xIow2UHuY/X18cNeQs1GjqFF4i9AEpIJ0vi/EV+dFuObfBDqXZHqpvwiMVWb9cXMlckQTi74fGPQq9JTpRvNG/oh2zHKgAbDhm0Z7269QytYWaDO4Vy4N0VS+1RzK0++7wyCQCNx9rBFqqRYNppVMUmvLYXn+U44/DK2SAPskJ+alLsOAPg3MGzCmiET5OaXxMb9NsgChH6BUVl09pOjBo03LOAp69f2lImBhX95DlZbSJTa83zlJhdPsKIdx2XFBzEn6oaEg7AH8HdesaLbTavExgjAvgEBMERd6YfmpOy4e//xDXa//t3U+zxYh8cIIFBF+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6EHbuGUBRcLaOhIQvjf1JdwWlQn7rv+9JEt40kCwIP0=;
 b=QZmMqMT65ul2izcvAMeZjKK8TCzA6FY9cy6UEaZQNj1RzCzAfJmHPVP4Bhm/yA5FNsFYmCUV+uprq8Ky5IVbUCe8iorjJiwzBy/Xg/TLRYB3kRVzE0B6BFUQFBxL+2yxchGecWPMARwu9hGYYeItTLYoCdNlWZhBp8tiXWV/3TtMpiZipMR/lMfIAZD6DUhDRPrnW0znkBF6XWFuz+iHir7qt9XMCHKdIvNpEiCOwXEIwfW0Vl2pATZG6OAQeb0iiibTfD89VcdV6RcHMGjoXKj/YGhKuZyRyrwJE7KUROWtbzvcV3o39t6ljnL5rcewCHiqTBlGbPG51qZ3q+YKiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6EHbuGUBRcLaOhIQvjf1JdwWlQn7rv+9JEt40kCwIP0=;
 b=jWbUzxvZ0CmVxYep9psa1gcn29Xy0hwKBiICvV1//68OKbwFo97MK71lgy4l38c2bDLIOnVs2FgZ2Lb5v3JDZ8GLVzT7sCxg0anDgfKpDWYU4rPICJ78GJTYqrV8Z1PUpZHpam1Z2w6VaqhngWvhsLGZ00KklqmH7C/tL4S8ValTVVPCRRy+C4udlIiJXDCW4Med8thQgJShDmnQqIywX9JngtYJO19SJquHZQntbn9Cei5WI8pYyBZIPsGLmR5goque1GxFM0rJth1yLB7M+t5LLzxJnJtjYIFGKOOig8MOL1myK6FqirPshJTxixWrmW64owTL5Uzam+ty0XjRIg==
Received: from LV8PR11MB8700.namprd11.prod.outlook.com (2603:10b6:408:201::22)
 by DS0PR11MB8049.namprd11.prod.outlook.com (2603:10b6:8:116::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.25; Thu, 29 Feb
 2024 04:52:12 +0000
Received: from LV8PR11MB8700.namprd11.prod.outlook.com
 ([fe80::bef5:e3b9:4214:8eda]) by LV8PR11MB8700.namprd11.prod.outlook.com
 ([fe80::bef5:e3b9:4214:8eda%6]) with mapi id 15.20.7339.009; Thu, 29 Feb 2024
 04:52:12 +0000
From: <Raju.Lakkaraju@microchip.com>
To: <Horatiu.Vultur@microchip.com>
CC: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<linux-kernel@vger.kernel.org>, <Bryan.Whitehead@microchip.com>,
	<richardcochran@gmail.com>, <UNGLinuxDriver@microchip.com>
Subject: RE: [PATCH net 2/3] net: lan743x: support WOL in MAC even when PHY
 does not
Thread-Topic: [PATCH net 2/3] net: lan743x: support WOL in MAC even when PHY
 does not
Thread-Index: AQHaaIt875w43lFlJEKADNz3AeNNCbEcSoMAgAR5j/A=
Date: Thu, 29 Feb 2024 04:52:12 +0000
Message-ID: <LV8PR11MB87009A3E7C1817051806A6FE9F5F2@LV8PR11MB8700.namprd11.prod.outlook.com>
References: <20240226080934.46003-1-Raju.Lakkaraju@microchip.com>
 <20240226080934.46003-3-Raju.Lakkaraju@microchip.com>
 <20240226082840.qbofj764s35zo352@DEN-DL-M31836.microchip.com>
In-Reply-To: <20240226082840.qbofj764s35zo352@DEN-DL-M31836.microchip.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR11MB8700:EE_|DS0PR11MB8049:EE_
x-ms-office365-filtering-correlation-id: 49833879-16bc-414e-fe42-08dc38e23197
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bGfOach/vW0kOphZKeweLGNwiGfsTXEmU5E+v/vNgZ/yp6s7p22Sx0YhQAz57xgiJm6yV+HCkOred+KPoYdWm4Ryll6nJ8wQzzOY8Go8yMT81aQooH734c7e9wRJ0ymDmnvNvWsPT2+4jKXYFIQQiS9DZdSGhGmhTj7jH1va9fzkfs1/toO0D5SpeMSHgWoTfiCBZWSzoJ5QPveypP+FLIOcOFL0g6AAdpxkhm5lVtjYTlwGjrPnjmw+D5rtK+YqPqE9a0l5BT7+V/Fh9vh7AYcUYySAjTl/E5SZ4St+7kv9zXK5c5icmJMpezVkuAuNLLJEC6kzmKyc+ygyAYQwuIK4vP/ZXdZruwq6cckZVc7Tv0bXqFqLMD/PmvbH8hsy19ue+iDvFazWdXq4uiYTUbg8X1Wk/2bDj4Gc8LckzMEPhz0+XXvPF3/cpQlx5SWJCuYGAIWactZMkVFAUUJlfewTfGPmu1jnLswxPW3OyUoo14iCKSut9lNkTCgPZ39GdGuj3UFP1ZNj3gjnxfei+BHSSLea8l/yDJ8dpJzel3TjNiOrLNF1FmN8eTmN+8NmQ5ThThGahfvqQLMu1OXGvuSXISOIUniGYU05t5sfiKHSz/4rTHiC9OezAcDXUzH0aEjaftXc2J0dVuQehsJ7jT1VO8H21aPNyKaWQXJ+OzWE79UT9581SspFz9JqhU9YQWVJfXeQpZ6/rnqlGy+eIzdcugvEkQge/MV8srF8/Ow=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR11MB8700.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Qmo2TEwvUHY2N3RhQ3M0Vmp4ZnBiN0FyNlRyY2NVd29tWXdzL3Iyb0lUNFd2?=
 =?utf-8?B?cEdLU3BTVEFZRkhPd3Zhb3FTSkpLNnlaTnFGRnI2c3ZVOTNlYjNZQUdnWSs2?=
 =?utf-8?B?dkluWmdTditjT0JybWQrOUwyNzhNMi9Db3N2dmptZW11SGM2dEtPb2Q0VFpl?=
 =?utf-8?B?UGVoZlkrcnN6bjlvMzRMNmdVRXVDeFQ5UUYyK1BpeElLUlJ4dEtYWFNHYXNF?=
 =?utf-8?B?ZzNFWnpmZDdlYUJkMzBKL2tYUFI3TVpudzFjMHJZM1lsK0ZqNE1MMkFQVGVh?=
 =?utf-8?B?SDNqTlltRUMzL2ZYNkZNTENyRE5HUzVyeWVXU2dpVXdicWVLczN5Uld0NGpC?=
 =?utf-8?B?VjIvcG1LRjhoU3VhcC9BRUQraXdoUnFJTFM1T2VtUVArKzBNbCtMdEwyUEtx?=
 =?utf-8?B?Y3d1M2toeHVYbm9LZnNEN09QRmpiUS9TakVEQS9wc3BYWm1DaUFDbEN3QUln?=
 =?utf-8?B?MHE0azlBRXpuZWJxTmZ3T0RwZTJ3UGRoQUYvOEZIdi9NNEZVRGo1cVk3SVlS?=
 =?utf-8?B?S2JvRzd2ckt5WU5JQWk2aHZYYzNoSWxRVnlPU2xvS2l0V3BqZ0Y1RTFpbStZ?=
 =?utf-8?B?STJCb3dFclVpSEN2Y3p0RHNJZW9FREVtY3lBM2ZmeE9iRWJOQzlMRXg0Mlht?=
 =?utf-8?B?SHpvUTlHMjI5TE1OL0g3QmdqeFhyeU5NeHBWdlZZVElhMnp6VmJEb2wxY2VU?=
 =?utf-8?B?azVCd3dNaEl0OHZTU001WklUSFp5c1UreVNHYVFiNktPTE95QW5WQVRqVUNs?=
 =?utf-8?B?Wkd6anlKY2szRWRrQjBsbkJEZTkzdHBvVGNCRHg4bTZ5QlhjcytySHd5SmNj?=
 =?utf-8?B?Wm9Vc2x2eHB0UzFzL1Zpdmx0VHY4WGJQeVJyd2poT1BoMFRmdWt2QVZ2bmVV?=
 =?utf-8?B?Rml6UEVreWluVEt6eVptTTRhNmFxVEpMOVJhUS82enV2U1JObERkRFNSc2p3?=
 =?utf-8?B?YU13KzV4a0l3TVhYcy81c0dwbzN2aTJxelE1OWxpbjN1ZUJ5aktyajdZQVNY?=
 =?utf-8?B?alQyRlg3Mjk2cFJzbGY1YnJuR2R4dW5UaThPU25xeGMwandlaXVnbnpkT0ZP?=
 =?utf-8?B?WUhMRy9JUVE3Nm9KL1I5cE01T2xnRlh6TmNFY0w5MFluVVpVeUVjdTFCTENy?=
 =?utf-8?B?TVB3NStURzFNVXBFVHllOHlMaVIyWXRrZUFESjNRbEF0bmRFdXpUMWtkd3lt?=
 =?utf-8?B?aVljMHVhRzdhMjJRYkJ5c0g3YjVtbFJKR2E1SXZWM2NpWC9KSkJVR2J6cUlo?=
 =?utf-8?B?YU1jcmRLL1F1aThGWlFzQnBTOXl1WGtJTzVROElabVZ5TG1hTml4L3lUL295?=
 =?utf-8?B?b3l4MzAxZHBQanFkS3RQY1EwVytWRGJNZlloYUo5N1g2b0F3R1ZSTnVIWnh6?=
 =?utf-8?B?THl4T2JRWXpJRUtMTlYxaTE2Y3V5MXF5TURyWFlhWkxCSzluZUFTRzNYd1Qx?=
 =?utf-8?B?aGVJZUd6akJ0aHlwd2dMbmk3K09LR1FtSTZZaHRhNTBSZ2NadURCVFBSQVFX?=
 =?utf-8?B?d0NFWnhkUU9qcUJzSWFFZ0tLRjdJMWdGRWNYdFdUVnZnQzNZS3FMenRUOGZq?=
 =?utf-8?B?VkVjLzZQTWp3aVdMZWg3UWpnQ09iU2JJZklBNzVuQVdHTlpuYys3U2VaaWdo?=
 =?utf-8?B?M3IwYkRXN0lHUzB1UHpON0ErR2VRQzA2ai9iVSt4b3dyR3ArUUFHS2RVb2Zo?=
 =?utf-8?B?RHhNc1ZyR21jSUw0VkZGNXBzdlRhdWc2Q3p2L3NoL2dxbHBONlFSR21CdDZF?=
 =?utf-8?B?WDlJKzZZa1c2enRkRmMzeVlVTnRhNDd5enc0dWdoTkZINEY1Q2V0VHhzYU9q?=
 =?utf-8?B?TVErWlBwdld2TFpJbFdGdkhkRTNIM2hxMXpSanRJKzE5d0VpUVRWYnRvL2JI?=
 =?utf-8?B?ZDBzemlqQUF0OXorMWFmL1FhQTc2ZU4yQ1YvM0ZJTzNYT21oQmhOVG0rcTl0?=
 =?utf-8?B?cUtWRVhjM1BUcFVrNjUrbStwV0hwbmVCa2c2bHdVU0tJMkN0c3ozZDJROXYy?=
 =?utf-8?B?TlVyNzNXL1JHTUdpZkJYVVJka3ZZTHpBelVTbklCVGdETDllV1NjeklqZll1?=
 =?utf-8?B?V3duT3orZjNmWDg5ZThaeTBMcmd4TnhFb1VhWjJ5Z3hTdnZVRm1wVE05dG1Y?=
 =?utf-8?B?NW4reUd2QkRVUWxkSEZYbjlHd3BCbXVaRXYwZktvT3VSZ3NGQ1dYQ0RGUVFQ?=
 =?utf-8?B?cmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR11MB8700.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49833879-16bc-414e-fe42-08dc38e23197
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Feb 2024 04:52:12.4974
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /Cb5Q9ZuJZXtYpZ4ImEnQM3LvTIzjCvaXWU5kVBwKajg007q+i8+PdROfXlLDzAvQDHgcLOpwQhKMTxdRujrVzkpIHGyqqsNfy9R4vQ4Fds=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8049

SGkgSG9yYXRpdSwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBIb3Jh
dGl1IFZ1bHR1ciAtIE0zMTgzNiA8SG9yYXRpdS5WdWx0dXJAbWljcm9jaGlwLmNvbT4NCj4gU2Vu
dDogTW9uZGF5LCBGZWJydWFyeSAyNiwgMjAyNCAxOjU5IFBNDQo+IFRvOiBSYWp1IExha2thcmFq
dSAtIEkzMDQ5OSA8UmFqdS5MYWtrYXJhanVAbWljcm9jaGlwLmNvbT4NCj4gQ2M6IG5ldGRldkB2
Z2VyLmtlcm5lbC5vcmc7IGRhdmVtQGRhdmVtbG9mdC5uZXQ7IGt1YmFAa2VybmVsLm9yZzsgbGlu
dXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IEJyeWFuIFdoaXRlaGVhZCAtIEMyMTk1OA0K
PiA8QnJ5YW4uV2hpdGVoZWFkQG1pY3JvY2hpcC5jb20+OyByaWNoYXJkY29jaHJhbkBnbWFpbC5j
b207DQo+IFVOR0xpbnV4RHJpdmVyIDxVTkdMaW51eERyaXZlckBtaWNyb2NoaXAuY29tPg0KPiBT
dWJqZWN0OiBSZTogW1BBVENIIG5ldCAyLzNdIG5ldDogbGFuNzQzeDogc3VwcG9ydCBXT0wgaW4g
TUFDIGV2ZW4gd2hlbg0KPiBQSFkgZG9lcyBub3QNCj4gDQo+IFRoZSAwMi8yNi8yMDI0IDEzOjM5
LCBSYWp1IExha2thcmFqdSB3cm90ZToNCj4gPiBBbGxvdyBXT0wgc3VwcG9ydCBpZiBNQUMgc3Vw
cG9ydHMgaXQsIGV2ZW4gaWYgdGhlIFBIWSBkb2VzIG5vdCBzdXBwb3J0DQo+ID4gaXQNCj4gPg0K
PiA+IEZpeGVzOiBlOWUxM2I2YWRjMzM4ICgibGFuNzQzeDogZml4IGZvciBwb3RlbnRpYWwgTlVM
TCBwb2ludGVyDQo+ID4gZGVyZWZlcmVuY2Ugd2l0aCBiYXJlIGNhcmQiKQ0KPiA+DQo+IFBsZWFz
ZSBubyBzcGFjZXMgYmV0d2VlbiB0aGUgdGFncy4gQW5kIHlvdSBzaG91bGQgbm90IHNwbGl0IG9u
IG11bHRpcGxlIGxpbmUNCj4gRml4ZXMgdGFnLg0KPiANCg0KSSB3aWxsIGZpeCB0aGlzIGlzc3Vl
Lg0KDQo+ID4gU2lnbmVkLW9mZi1ieTogUmFqdSBMYWtrYXJhanUgPFJhanUuTGFra2FyYWp1QG1p
Y3JvY2hpcC5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvbmV0L2V0aGVybmV0L21pY3JvY2hp
cC9sYW43NDN4X2V0aHRvb2wuYyB8IDE0ICsrKysrKysrKysrKy0tDQo+ID4gIDEgZmlsZSBjaGFu
Z2VkLCAxMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L21pY3JvY2hpcC9sYW43NDN4X2V0aHRvb2wuYw0KPiA+
IGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWljcm9jaGlwL2xhbjc0M3hfZXRodG9vbC5jDQo+ID4g
aW5kZXggYTJiM2Y0NDMzY2E4Li40ODk5NTgyYjNkMWQgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVy
cy9uZXQvZXRoZXJuZXQvbWljcm9jaGlwL2xhbjc0M3hfZXRodG9vbC5jDQo+ID4gKysrIGIvZHJp
dmVycy9uZXQvZXRoZXJuZXQvbWljcm9jaGlwL2xhbjc0M3hfZXRodG9vbC5jDQo+ID4gQEAgLTEx
NjMsNiArMTE2MywxNyBAQCBzdGF0aWMgaW50IGxhbjc0M3hfZXRodG9vbF9zZXRfd29sKHN0cnVj
dA0KPiBuZXRfZGV2aWNlICpuZXRkZXYsDQo+ID4gIAkJCQkgICBzdHJ1Y3QgZXRodG9vbF93b2xp
bmZvICp3b2wpDQo+ID4gIHsNCj4gPiAgCXN0cnVjdCBsYW43NDN4X2FkYXB0ZXIgKmFkYXB0ZXIg
PSBuZXRkZXZfcHJpdihuZXRkZXYpOw0KPiA+ICsJaW50IHJldDsNCj4gPiArDQo+ID4gKwlpZiAo
bmV0ZGV2LT5waHlkZXYpIHsNCj4gPiArCQlyZXQgPSBwaHlfZXRodG9vbF9zZXRfd29sKG5ldGRl
di0+cGh5ZGV2LCB3b2wpOw0KPiA+ICsJCWlmIChyZXQgIT0gLUVPUE5PVFNVUFAgJiYgcmV0ICE9
IDApDQo+ID4gKwkJCXJldHVybiByZXQ7DQo+ID4gKw0KPiA+ICsJCWlmIChyZXQgPT0gLUVPUE5P
VFNVUFApDQo+ID4gKwkJCW5ldGlmX2luZm8oYWRhcHRlciwgZHJ2LCBhZGFwdGVyLT5uZXRkZXYs
DQo+ID4gKwkJCQkgICAicGh5IGRvZXMgbm90IHN1cHBvcnQgV09MXG4iKTsNCj4gPiArCX0NCj4g
Pg0KPiA+ICAJYWRhcHRlci0+d29sb3B0cyA9IDA7DQo+ID4gIAlpZiAod29sLT53b2xvcHRzICYg
V0FLRV9VQ0FTVCkNCj4gPiBAQCAtMTE4Nyw4ICsxMTk4LDcgQEAgc3RhdGljIGludCBsYW43NDN4
X2V0aHRvb2xfc2V0X3dvbChzdHJ1Y3QNCj4gPiBuZXRfZGV2aWNlICpuZXRkZXYsDQo+ID4NCj4g
PiAgCWRldmljZV9zZXRfd2FrZXVwX2VuYWJsZSgmYWRhcHRlci0+cGRldi0+ZGV2LCAoYm9vbCl3
b2wtDQo+ID53b2xvcHRzKTsNCj4gPg0KPiA+IC0JcmV0dXJuIG5ldGRldi0+cGh5ZGV2ID8gcGh5
X2V0aHRvb2xfc2V0X3dvbChuZXRkZXYtPnBoeWRldiwgd29sKQ0KPiA+IC0JCQk6IC1FTkVURE9X
TjsNCj4gPiArCXJldHVybiAwOw0KPiA+ICB9DQo+ID4gICNlbmRpZiAvKiBDT05GSUdfUE0gKi8N
Cj4gPg0KPiA+IC0tDQo+ID4gMi4zNC4xDQo+ID4NCj4gDQo+IC0tDQo+IC9Ib3JhdGl1DQoNClRo
YW5rcywNClJhanUNCg==

