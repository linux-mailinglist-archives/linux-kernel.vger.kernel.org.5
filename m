Return-Path: <linux-kernel+bounces-135670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 656D889C987
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 18:27:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A70ADB21721
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 16:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A95621422DB;
	Mon,  8 Apr 2024 16:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="NJ3ZA4L7";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="J5gINcXO"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E88C128389;
	Mon,  8 Apr 2024 16:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.153.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712593616; cv=fail; b=NEdsfizy+jjoJ8A4WnnnJ5UJFYL7fodZYTbPAwLvIUj9nSl3Tn6zea3UCBKcMCDjYkoMjtdVSv/ooweMJTwtjEOaQ7eISavftY+SooPRnTlNjqpRSCwOG42dtGNc0eIUoXRJ31XhWPEBEdWnc3StWsWcv1vxEHZcDgOtIsxczSU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712593616; c=relaxed/simple;
	bh=rEsbaCBGYjMnGdF5AUtZAqvA48GyplriuNJT8Rd9BYs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UVhppDKWygKZCxbdCC914L6udSuUgcu54hHuWb/CyqnxkLTcHR0BRQIOrmTf8L+gVzoiroxqJdRHySBh0XZzAfBdOTMRSqefjgUE8/ke+FKWg2QqdyPPc1kxPZ1mo3jG/s0yV8QDb6772tf4bQtLtQuQCMrsjgwgcevhGEEq7bc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=NJ3ZA4L7; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=J5gINcXO; arc=fail smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1712593615; x=1744129615;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=rEsbaCBGYjMnGdF5AUtZAqvA48GyplriuNJT8Rd9BYs=;
  b=NJ3ZA4L7DUClIYKSBvfMwEOMZFLdNmId7+5iLxGcnQVmq5jU+fhAWSi8
   qq3GkuGc3Y9lTw2EjywL7XypCObWEGebXILEGm7ENo+ACEA//tTFn5uj7
   U3w5HZWwaT8cKBO1VkvJ1f1bJDELzZG0su5EwpQBFzqaBOFtHYq0XqfHV
   HXDLr0xl9fBg+XsbnzoxyEUAV22Jl4ARj+itsxQK/zMjTk8ZQHke3ZKBB
   Hd5shrntGvku01kzIzXHe3CfFKHYhs65IO7fFyQrvS5nsrrpxdaVErycG
   +9gyXDOtBvEVhpoTSmmm42lYsI1qyQR6nb/42UUpSfs7PpJT9/oejDHrY
   A==;
X-CSE-ConnectionGUID: ogL2Jx3iTz+Cx7A8lZ221w==
X-CSE-MsgGUID: ZIq454rgRKm1aXIzV1lflg==
X-IronPort-AV: E=Sophos;i="6.07,187,1708412400"; 
   d="scan'208";a="20044933"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Apr 2024 09:26:54 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Apr 2024 09:26:38 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 8 Apr 2024 09:26:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IMLC9HQ9xwvlP4qtOhiKvEmdAy3F9i6VVyPt4V22rkoPfV1kWcPdw9NVELGAtM6f0a+yGpdNiZXKn0IGW4ipxXpmtH0Mf9B9Z/sumturFAUeGcUQNuODI94O3NO/CTseqSq6Z+oPzP+KDd70bnhd9Qm3R97N/v8yhp995PAu1EJo4JT4y7wpn2CShKEdEZL11NcHRd25ptsk/ICfJXKBLvFfN4FwwZe0FjELSAZyYmObsitY/psSFay5j2DHrXbF8YTAPiKZrC0vERmld17yorB5DN3/kObN8i36e1Uc1+IIitzWgfPKibL01k3Co3sPXX4hOM0+RhXBnxMC2evYWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rEsbaCBGYjMnGdF5AUtZAqvA48GyplriuNJT8Rd9BYs=;
 b=ln7CujRWjRh3e165UM5lq6KnxfEZnhbntpqcTCoibGAYQLQsi28chDzAHVeCWtmC32PFQIXdXWWmLmbQYIQQ9djcGuz6TFI5LHVqCDKugL+eKrF5DsS68yqITFNEY3uYarJrpK/p5ZbWr09cONdDytKOSY1fF4PQv0PyG+htEmSishXeAh3EvihWq5IxJnrS+ef9t/kdXXUudNtj1atG+pY6G2xToQlOGbFx0UTYOQQ4zKXe9mb1HshWMEjIfvlEkW5YudE4YSjSJrunRh1ajMhm7nXzJF1PUyeqogkrpejBea8XDoupTNdRXOoRfSf9DNWTQ9q+Z+eQOBHmrECARg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rEsbaCBGYjMnGdF5AUtZAqvA48GyplriuNJT8Rd9BYs=;
 b=J5gINcXO+45+jA8ZfqC4EKHPx8fQxH4O07pkSgwOoSmuqphLo0AAXQDqxRsorq/dmOz+lHep+yFhEY2JvL9mn5SfF0APYB2zl0tyXDYz6bUYU1QqUIPGu8pAezWte9uzXjSlc8KLuBe+YJjXw5G881SM/jIB4lny5TQiT2VLYcLbBbaAixoqAc6bmuhZVf7yTRVbCSCFlkw2WffhzQs0D4/PnmOzo14XKTy5KcxfounD3QgNPizvzgzE36uYzozavsfqga8clwiUTyp5ZgUQrDhcInu+p8Obv3JDUq8NPIxufk1hCY7IAEgtFWCylgRcrTrOfOaC0qSXJ9mhLFQqdw==
Received: from PH7PR11MB8033.namprd11.prod.outlook.com (2603:10b6:510:246::12)
 by SJ0PR11MB5894.namprd11.prod.outlook.com (2603:10b6:a03:42a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.25; Mon, 8 Apr
 2024 16:26:34 +0000
Received: from PH7PR11MB8033.namprd11.prod.outlook.com
 ([fe80::d529:f716:6630:2a1d]) by PH7PR11MB8033.namprd11.prod.outlook.com
 ([fe80::d529:f716:6630:2a1d%3]) with mapi id 15.20.7430.045; Mon, 8 Apr 2024
 16:26:34 +0000
From: <Arun.Ramadoss@microchip.com>
To: <andrew@lunn.ch>, <olteanv@gmail.com>, <davem@davemloft.net>,
	<Woojung.Huh@microchip.com>, <pabeni@redhat.com>, <o.rempel@pengutronix.de>,
	<edumazet@google.com>, <f.fainelli@gmail.com>, <kuba@kernel.org>
CC: <kernel@pengutronix.de>, <dsahern@kernel.org>, <san@skov.dk>,
	<willemb@google.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <horms@kernel.org>, <UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH net-next v4 6/9] net: dsa: microchip: dcb: add special
 handling for KSZ88X3 family
Thread-Topic: [PATCH net-next v4 6/9] net: dsa: microchip: dcb: add special
 handling for KSZ88X3 family
Thread-Index: AQHaiYlEnhCoo9K/i0mwtbuNdW8BprFekGSA
Date: Mon, 8 Apr 2024 16:26:34 +0000
Message-ID: <7f0684fb1729dafc92f8b81ce81f10c91385c0c2.camel@microchip.com>
References: <20240408074758.1825674-1-o.rempel@pengutronix.de>
	 <20240408074758.1825674-7-o.rempel@pengutronix.de>
In-Reply-To: <20240408074758.1825674-7-o.rempel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.36.5-0ubuntu1 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB8033:EE_|SJ0PR11MB5894:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oejvuns454Y0x5TCJyReZ+qzlFEoYvFKPSrE5WPlc7SJsaYqdPO0Xn0RVoq7a7+jfKKM3fGRALSArkpMNYjk0Q2/yHDmAGc/0LHIOgKrpoKiCmigeNn+d4eKD1FMF8fg3Iz3AEEr4d/dUUipc4uTIy1Kj57qn1px6oli3Eai9tKBDLADClhrHenbvpPQwExjcrWJZ4drdhp0BvLUGKaH1D1JDebzv3OO/dPAO85+9PrY1FOzxhEJaGRI7PqOLmBBC0xg7guuioEEoF/7oTkqFMjKCUj9eLjWdafQdUb14T1ooq586IRTRLuEPzbsZ69QtLBQPWyZ9LCRpnFmRtEKDJKoV14VGGREZrJMgJ7kM1hXwaP1uXA37ZZk50FvckRq9EeF0M+Zr+PUb4zIkTYCn+MXaDYPr7UlEM7B8Q99TrFYk8J5B1W0Z5J99rRRsiFF1x2GAROaBs1e6+t6lhuuDAWxmFHTC/PSEkFslmc/qf0E6RxbH9fOuoPdCpo9xNxBZr39BjkvML5R1LYA9dNObfmIK5f9LAxy39UUV8KhihbV6ki2YT1xs6/FVrNE0JNcJa2vGr9MFjJtXrV8S4WhwR2jreajVYMXmrbmOok3i3arw1t+KS+QoRanZWarqFymc7+45ZJrYy7PhhdCOZRdBBTWYNoiNArozLvrV/AtWt4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB8033.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?LzJ5dFFIOStQQWp1QXRYVUFDaFJjVGg1RkNHSVo4YTRKai8wYmJkOWNJYkxp?=
 =?utf-8?B?bUtWSTgwZlZQbjUrNmR1QnY2QlNxSWpFQS9hVUk4UUJCVGJsMm5VNmQ2VDJa?=
 =?utf-8?B?a2JTYTZUNGhoNXU1YldpVnhIdkE2cFRoOHpiaHBtWDhvUkFlc3JmUU1nTHg0?=
 =?utf-8?B?VU9BaEwvU3ZiOHk1dEZIbUxKZTZ0d0prUWgwNzZybFhxTDFvaEp4MmppaGpB?=
 =?utf-8?B?MGpkVks1UFBzVFN6NjU3djB4L0ZydWJzdkNlciswR01HREd6eHpSR2lkY2F0?=
 =?utf-8?B?QTc1WHdPUy9zOG5icGFobnFvUEMyMUNNYzRmYlFoWEpIQ3BzS1duKzBGU3Jj?=
 =?utf-8?B?aW50cnd6QXYyZmNzUFJZam1UdFY0SDhsSERPWmVmM1kvNmlXNSthcE9kSzBz?=
 =?utf-8?B?d3BNZGE3SmdlZC9PZ3ltRGNOaG5Rc0ZzYml4TldmVDExQUJWekRFRTh2Rlow?=
 =?utf-8?B?UlNmR3hMN3VybjZhRStsdnZRS3ZnZWg5OExWZjY2TzZwRU4xbytzdU5MY1p6?=
 =?utf-8?B?Vzg3emhwblFPRlVyVGp2UldSaUU4MjVRSDRpcEVJUWk1Qm8wbWxOaUNzYU93?=
 =?utf-8?B?STljV3hlZUQvME5MUVR0OEc4QXl1NHBSVVZPOXF2ZnpBSjE5YmV0WWpteU93?=
 =?utf-8?B?eE5YWnYwTzR3Zm9HWWVRRkgwNHRmYXJaYjNWbndjajNNMlkwZVBrV1BJWW81?=
 =?utf-8?B?WE9KQUNadW1pSFFFeWFFTUtlQUJ3K3NwS2dldnpUNUJIQXdwRHdXTlB2SEhy?=
 =?utf-8?B?ZUF5QXNVMVk3VzVBU2VSd1UwOXR6aHJ6QnYxRFpEcXlRaUNZVkhUVGZaK28y?=
 =?utf-8?B?SWw2TEYvS0dWTHp5MllkSlpRQU52SlJzeTRwZDF0UjJKTGUwU1BLeWVCanRP?=
 =?utf-8?B?ZzFJclBncG1GY1pXK2ZqcWV3eGtQSzFaYmJNNUFTajdIQktvNEI5VFV6VDFT?=
 =?utf-8?B?NlpuUlVBVUVhKy8xcWMza1R5TjhEUCtWQmNEeHZvTjc0ckg1QmZLTEdkRHZp?=
 =?utf-8?B?N1dJSEJ1VHlhN3hHZVVIUXhlUnJEMGE1dzlTOVdhR2NubkE5V3ppTUFpVjdE?=
 =?utf-8?B?YldCZnRvSUZDWUI5aWZiVDJUZW1jQ0cwMS9FdHQ2aTdHTXdzeitoYWhqeFRs?=
 =?utf-8?B?UXZrOURrdXpuQnR4V0J5ZnN0WDhsREVaNkpzcU5QRHVPbUd2TURrdU41Tlk0?=
 =?utf-8?B?QlJTc0FkWnArcWR1dUhMdElHM0hkQXN4K2V4elhsbHRXN0lLdEs1bUR3eXpo?=
 =?utf-8?B?UTBISSs4ajBOaFFCM2Z4MEdGTnZiQy9oN2tzajJ3RkVxZnM0RWdlbVlvVE11?=
 =?utf-8?B?ZHd4emFqbWZlRjhXd2dlYnZFMVRlVU1tMTV5WTNra3Z3U210R1VsMUlWbFU1?=
 =?utf-8?B?VkJxeDVMMHBnRGMvbzkyT2tZWE9BMWJ2QjhPZ1l3eW9ycDNaYTVmSVlwdGJB?=
 =?utf-8?B?WDM4cDd4S1dnR3lsWm9JbmJTUEVtZmRaQlFOOTR6QW1NQ2FQRWlnTkdEQnhu?=
 =?utf-8?B?OGFKRitpanViRkRlRWU4QVJYSDlqZmNuL1JIQnlwODMvUkdtam11OG5ETDYv?=
 =?utf-8?B?Nmo3Ym0rU0FHWC9BZ3ZUWHY2V2xsQmEvazRuemRDTGU2T0NreGg3TDU3R1Bw?=
 =?utf-8?B?QjdTN2hjd2JtNHg3ZUJmc0FqcDc3aE5jVGZVNG9mTVNhYkdFTXJJbzZqb2J4?=
 =?utf-8?B?Yy9JZlJ4TzVlOXR0RUVDUzZ4OEY0U1BlcEtsdzdiVnh0R3Vrc3ZRWXkwQ3Fy?=
 =?utf-8?B?dFRsMTNoQWh5dGFRUFF0dUlRdVVabUt0RVRLK3YxSTJFeTVzdXA3L3JxUXA3?=
 =?utf-8?B?VmtoVlV0OW5yOWVYYmJJbFBrUkFmOXVGa2J4aHZCcWY4TjJ3UTdjOFZQMHdV?=
 =?utf-8?B?Q1lMSjJsOXlzNW5wZE5CZjRuZWZtRlRVVmd2Y0hObXczTlE1Nm1kYTJ4Yito?=
 =?utf-8?B?a1BzOVVFU0dySlQ0b0Fnb0dwaE50UVVlaG0vNEJyVDJJajRZckxMME9WQmNP?=
 =?utf-8?B?L2xIYUxtT0hoRVlEU1d6WGlkYmhPblU1QVFWVm42SVg5LzNCanp3eGgxdmxn?=
 =?utf-8?B?ZjNMa0l3RUVWc1NqT3QyQnZkcjN6TktYcWN6b0hTVmowUExHWFcwdHZsNUNT?=
 =?utf-8?B?dG15Y1ZLVmYyQkdIM3ZnVnFaRVI1THB5SDQxRU5RSlRWSSt3SUQ1MlVmSm8z?=
 =?utf-8?Q?c+8wMC1/VE/dUVe2rjYRsOk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <14E40E38F5EE354C89939CEAA8BE57AE@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB8033.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99595908-f01f-46ac-dbbf-08dc57e8a83f
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2024 16:26:34.6502
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uG1OwLjh5KWln/VSeGzl5llZSCP1Yx/WtON2JXPx/jzDOfzZ+dyNkSv5lrNvC+pzn61zRS8YurmUGJbtVD1JE86nbzCmuBFrjmtiTHNAJCY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5894

SGkgT2xla3NpaiwNCg0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2RzYS9taWNyb2No
aXAva3N6X2RjYi5jDQo+IGIvZHJpdmVycy9uZXQvZHNhL21pY3JvY2hpcC9rc3pfZGNiLmMNCj4g
aW5kZXggNDY0OTFjNmRkNmY2MC4uMmMyOGM0ZWQyODhhOSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVy
cy9uZXQvZHNhL21pY3JvY2hpcC9rc3pfZGNiLmMNCj4gKysrIGIvZHJpdmVycy9uZXQvZHNhL21p
Y3JvY2hpcC9rc3pfZGNiLmMNCj4gQEAgLTgzLDYgKzgzLDEwIEBAIHN0YXRpYyBjb25zdCB1OCBr
c3pfc3VwcG9ydGVkX2FwcHRydXN0W10gPSB7DQo+ICAgICAgICAgSUVFRV84MDIxUUFaX0FQUF9T
RUxfRFNDUCwNCj4gIH07DQo+IA0KPiArc3RhdGljIGNvbnN0IHU4IGtzejhfcG9ydDJfc3VwcG9y
dGVkX2FwcHRydXN0W10gPSB7DQo+ICsgICAgICAgRENCX0FQUF9TRUxfUENQLA0KPiArfTsNCj4g
Kw0KPiAgc3RhdGljIGNvbnN0IGNoYXIgKiBjb25zdCBrc3pfc3VwcG9ydGVkX2FwcHRydXN0X3Zh
cmlhbnRzW10gPSB7DQo+ICAgICAgICAgImVtcHR5IiwgImRzY3AiLCAicGNwIiwgImRzY3AgcGNw
Ig0KPiAgfTsNCj4gQEAgLTEyOCw2ICsxMzIsNDggQEAgaW50IGtzel9wb3J0X2dldF9kZWZhdWx0
X3ByaW8oc3RydWN0IGRzYV9zd2l0Y2gNCj4gKmRzLCBpbnQgcG9ydCkNCj4gICAgICAgICByZXR1
cm4gKGRhdGEgJiBtYXNrKSA+PiBzaGlmdDsNCj4gIH0NCj4gDQo+IA0KPiANCj4gKy8qKg0KPiAr
ICoga3N6ODh4M19wb3J0MF9hcHB0cnVzdF9xdWlyayAtIFF1aXJrIGZvciBhcHB0cnVzdCBjb25m
aWd1cmF0aW9uDQo+IG9uIFBvcnQgMQ0KPiArICogICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgKHBvcnQgPT0gMCkgb2YgS1NaODh4MyBkZXZpY2VzDQo+ICsgKiBAZGV2OiBQb2ludGVyIHRv
IHRoZSBLU1ogc3dpdGNoIGRldmljZSBzdHJ1Y3R1cmUNCj4gKyAqIEBwb3J0OiBQb3J0IG51bWJl
ciBmb3Igd2hpY2ggdG8gc2V0IHRoZSBhcHB0cnVzdCBzZWxlY3RvcnMNCj4gKyAqIEByZWc6IFJl
Z2lzdGVyIGFkZHJlc3MgZm9yIHRoZSBhcHB0cnVzdCBjb25maWd1cmF0aW9uDQo+ICsgKiBAZGF0
YTogRGF0YSB0byBzZXQgZm9yIHRoZSBhcHB0cnVzdCBjb25maWd1cmF0aW9uDQo+ICsgKg0KPiAr
ICogVGhpcyBmdW5jdGlvbiBpbXBsZW1lbnRzIGEgcXVpcmsgZm9yIGFwcHRydXN0IGNvbmZpZ3Vy
YXRpb24gb24NCj4gUG9ydCAxIG9mDQo+ICsgKiBLU1o4OHgzIGRldmljZXMuIEl0IGVuc3VyZXMg
dGhhdCBhcHB0cnVzdCBjb25maWd1cmF0aW9uIG9uIFBvcnQgMQ0KPiBpcyBub3QNCj4gKyAqIHBv
c3NpYmxlIGlmIFBDUCBhcHB0cnVzdCBvbiBQb3J0IDIgaXMgZGlzYWJsZWQuIFRoaXMgaXMgYmVj
YXVzZQ0KPiB0aGUgUG9ydCAyDQo+ICsgKiBzZWVtcyB0byBiZSBwZXJtYW5lbnRseSBoYXJkd2ly
ZWQgdG8gUENQIGNsYXNzaWZpY2F0aW9uLCBzbyB3ZQ0KPiBuZWVkIHRvDQo+ICsgKiBkbyBQb3J0
IDEgY29uZmlndXJhdGlvbiBhbHdheXMgaW4gYWdyZWVtZW50IHdpdGggUG9ydCAyDQo+IGNvbmZp
Z3VyYXRpb24uDQo+ICsgKg0KPiArICogUmV0dXJuOiAwIG9uIHN1Y2Nlc3MsIG9yIGEgbmVnYXRp
dmUgZXJyb3IgY29kZSBvbiBmYWlsdXJlDQo+ICsgKi8NCj4gK3N0YXRpYyBpbnQga3N6ODh4M19w
b3J0MF9hcHB0cnVzdF9xdWlyayhzdHJ1Y3Qga3N6X2RldmljZSAqZGV2LCBpbnQNCj4gcG9ydCwN
Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGludCByZWcsIHU4IGRh
dGEpDQo+ICt7DQo+ICsgICAgICAgdTggcG9ydDFfZGF0YTsNCg0Kd2h5IGNhbid0IHdlIGhhdmUg
c29tZSBjb21tb24gcmVmZXJlbmNlLCBiZWNhdXNlIGl0IGlzIHNvbWV3aGF0DQpjb25mdXNpbmcu
IGZ1bmN0aW9uIG5hbWUgaXMgcG9ydDAsIGJ1dCBhcHB0cnVzdCBjb25maWcgaXMgZm9yIHBvcnQx
IGFuZA0KdTggcG9ydDFfZGF0YS4gYXRsZWFzdCBpbnN0ZWFkIG9mIHBvcnQxX2RhdGEsIHBvcnQw
X2RhdGEsIHdlIGNhbiBoYXZlDQp2YXJpYWJsZSBuYW1lIGFzIGRhdGEsIHNpbmNlIHRoZXkgYXJl
IGhhbmRsZWQgaW4gdHdvIGRpZmZlcmVudA0KZnVuY3Rpb25zLiANCg0KPiArICAgICAgIGludCBy
ZXQ7DQo+ICsNCj4gKyAgICAgICBpZiAoIShkYXRhICYgKEtTWjhfUE9SVF84MDJfMVBfRU5BQkxF
IHwNCj4gS1NaOF9QT1JUX0RJRkZTRVJWX0VOQUJMRSkpKQ0KPiArICAgICAgICAgICAgICAgcmV0
dXJuIDA7DQo+ICsNCj4gKyAgICAgICByZXQgPSBrc3pfcHJlYWQ4KGRldiwgMSwgcmVnLCAmcG9y
dDFfZGF0YSk7DQoNCkhhdmluZyBtYWNyb3MgZm9yIG1hZ2ljIG51bWJlciBmb3IgcG9ydCAxIGFu
ZCAwIHdpbGwgYmUgZ29vZC4gDQo+IC0tDQo+IDIuMzkuMg0KPiANCg==

