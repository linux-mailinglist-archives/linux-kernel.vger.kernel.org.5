Return-Path: <linux-kernel+bounces-156342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DAA318B0186
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 08:08:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06F09B21D1C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 06:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2C2E156F35;
	Wed, 24 Apr 2024 06:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="rwUrOTS+";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="qrzjuVAk"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7A9156C74;
	Wed, 24 Apr 2024 06:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.154.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713938884; cv=fail; b=Lt9sf0CZeGTq8cfacmaXWfdRuA5A0dbZJ3TkpnC81ygwzY0fuM5MO37uKIjXWtIkpGKDSUVEdUDgW1uDyKrbyKt/qeEs6Vsqsbp5bdCf49zF8pmWbJhORQRW4xHfv6Rja6JlRcU9bZ8YN033QKTkZaDoeeXZI6KwMlUMRcOQGxY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713938884; c=relaxed/simple;
	bh=3sGi8lDkTi+07p/KppK+kN1W5L0TzfXw/ERxdk9TT10=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aoyn3c/FUpmSa2AgewMQgEKNzt8FpfUwUEeCVu1ptPhBgF8qwEh5clDshebmFARaFi+62fycqgtvNcLLmOysdHztN+/nJgS2n0oFoLJio63JDEDoqZBNGN1CTpv9qgT265o6VtTrSe0QLfNB3sbkRXIHTIvJ1x/RN0jbTFZiGrg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=rwUrOTS+; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=qrzjuVAk; arc=fail smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1713938882; x=1745474882;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3sGi8lDkTi+07p/KppK+kN1W5L0TzfXw/ERxdk9TT10=;
  b=rwUrOTS+NwLHwQt6x2tsIr2N8zuurLOmfXxC0SmMUOONZYkeJHFYXH/T
   IyBWyDc0M2/uIBq/xK+EB/Z3VpaK6WTpRk2dIuFkyq3IscAQs3U5quIii
   W/oS06rwLVS4n9gcuVgY0vMSRUf6b4arNG8i8lQBCkFnOFc7SnLjYpGsR
   K23YJyTttzCm5veQMn7Jnb/AnBTyl19GWkt3fwJuk14xzdbcwAx14r1h1
   Ye6Ur74RNEAwiGVhHzLzEV2LBMjPucv2WQ7p8wO9Lea/CKQ8w0wSrRVg/
   jiP39natp38jFpabqmX0x0cFrWInBVYQFRahRCPhyUZIU7dS5z8T9ONFX
   w==;
X-CSE-ConnectionGUID: cniL7VbJSu6FU9cFTt8RQA==
X-CSE-MsgGUID: PlPjR7V7TgyqI5Nwx8NyYQ==
X-IronPort-AV: E=Sophos;i="6.07,225,1708412400"; 
   d="scan'208";a="22981055"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Apr 2024 23:08:01 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 23 Apr 2024 23:07:55 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 23 Apr 2024 23:07:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nJ2KRmL1CnP24h/tmeOlc+HsUo247cje5npIz7EymxL8Z6x4EZDPwVv4dacDbUXQjfoKqMObLqr+sZvCqF4cM6g1k4oyYzgALasMP5f38gxQvMFkTJgoZAA8dCyxZJFy95tH04NJBC8mroDJvI8/ArHAiD2wjqNnn8kX0di94Oy9oDg2SbhBGX2c2ut97FUVlkzmrM3+HJ1xrpmyHa504y4Z9yziBhzeuIRVGGM9eb6vzcYQP8uhkVxduIXbWr+dqv99zf7TgButwwesDYZeJcwMdfpXtb/Lo+2Tbr3J5ad9Hvlk/83fVDSqg7P31N9vGLRMtlPEbcKIbEpuLPTUfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=In5ptcEPm24A2aXZcJAsl+twu9A+CybZhT1JmZ5FE/k=;
 b=UsCXTk3L3z0jsfZak8K7FPqSP3RG68MqXEJB013XmKUBfF0T84t65IuW/lmq9A/YB3vEcJE3TnK/trevbQtJFCzqDkJ76uxEVu/CXish9jr7HCbyI6abibMXhBPqSWZ3n5MtW/eXWws3elVgjNCwjYA/MlocSA4cSVDridNtn5nuC9VfRGsTRFgs2R++A4VKZ9JUlIp6MbKYFMO+HoNzxmqWSxMyiHojxm44Hb+hJpTNtMAKnzJYIb/gO9tdzJ/Qq6jh8xKyYHji0bSD3YWZB/rCfRbPvHwicFrmtQ1AIq0I8x3Ty7TBBSVUDZrSQy+la+uRpSQYRF3M7ioQPIZXGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=In5ptcEPm24A2aXZcJAsl+twu9A+CybZhT1JmZ5FE/k=;
 b=qrzjuVAklkyhJRxuJcWZnpTVmQY6et6aJBw2jB0M0tI1jCENzA69O6OYCf0wQsNnZbByRTWi6mqwL4btUcHVLJ+Fz7fCdABKGgM1alTBzxt2ogeL+YVlPe58zkZJdJLodwkbzmL8+bqoEZSC5uZ1pUxfwLtqQmF2vtZW8FtvsAT7AsF0jfi0HiaJxNa+VoYcw4+5qRqTmdQzj7rZgXhH/e27ffqzqt6UGsTt4T/px7tvDVjuH6bsdA+ugiJ2m8508vRnzKEItKLn2/HKRyZTZMnOrvfMAQNu+GfIvluPNKLx8BJoC3y9abuxLwvGWf47zVaUVUfwi1ezX3R+BCcN0g==
Received: from PH8PR11MB7965.namprd11.prod.outlook.com (2603:10b6:510:25c::13)
 by DM4PR11MB5996.namprd11.prod.outlook.com (2603:10b6:8:5f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Wed, 24 Apr
 2024 06:07:52 +0000
Received: from PH8PR11MB7965.namprd11.prod.outlook.com
 ([fe80::1a3a:422d:1406:cd7]) by PH8PR11MB7965.namprd11.prod.outlook.com
 ([fe80::1a3a:422d:1406:cd7%5]) with mapi id 15.20.7519.021; Wed, 24 Apr 2024
 06:07:52 +0000
From: <Ronnie.Kunin@microchip.com>
To: <andrew@lunn.ch>, <Raju.Lakkaraju@microchip.com>
CC: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <linux-kernel@vger.kernel.org>,
	<Bryan.Whitehead@microchip.com>, <UNGLinuxDriver@microchip.com>
Subject: RE: [PATCH net V2 2/2] net: lan743x: support WOL in MAC even when PHY
 does not
Thread-Topic: [PATCH net V2 2/2] net: lan743x: support WOL in MAC even when
 PHY does not
Thread-Index: AQHaen5pYcVCYAnMVEe2BSZT37paArFBPcYAgBgwmwCAAJVnAIAb45oAgACHioCAAKyXUIAACkKg
Date: Wed, 24 Apr 2024 06:07:52 +0000
Message-ID: <PH8PR11MB7965A7545D86EA3546BFAEE495102@PH8PR11MB7965.namprd11.prod.outlook.com>
References: <20240320042107.903051-1-Raju.Lakkaraju@microchip.com>
 <20240320042107.903051-3-Raju.Lakkaraju@microchip.com>
 <22089299-a3e2-4cbd-942a-65ea070657b8@lunn.ch>
 <LV8PR11MB87003ABBCA98F00F3EEA9AB09F032@LV8PR11MB8700.namprd11.prod.outlook.com>
 <fb5a6f19-ae4c-443e-babb-cbbcf6ba5fc6@lunn.ch>
 <LV8PR11MB8700A34520EA2521BC5F59EF9F112@LV8PR11MB8700.namprd11.prod.outlook.com>
 <9c4f8fcd-ae95-4874-b829-d381928c5f13@lunn.ch>
 <PH8PR11MB7965211413E7295D537BF53095102@PH8PR11MB7965.namprd11.prod.outlook.com>
In-Reply-To: <PH8PR11MB7965211413E7295D537BF53095102@PH8PR11MB7965.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB7965:EE_|DM4PR11MB5996:EE_
x-ms-office365-filtering-correlation-id: 87bca6ef-d900-48f1-25d1-08dc6424e078
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?dCfilCXs5RGZa41rxzHFIPjgmXWMwjLoJKizOxDD1Iy1V+CUyb71NtlfbJKu?=
 =?us-ascii?Q?/Io0ivQ8R4fo7p7dgfrE7VXHeqssXyxb6JFktcBq5ZuSDAzR/rxa2g2+roJu?=
 =?us-ascii?Q?LuRj5MB+YU8nxFMmuc4FcADQJgMWTBBNb5Yg3LNrmW41ipMyzeB4Fm8NWNhd?=
 =?us-ascii?Q?SpJE7Kw7KvC0X9UJO+q4WCsyZkvyKdlweqK2H6YSc2l/TB96/m+NZRYTGhg+?=
 =?us-ascii?Q?wSdFNQPmec1Fc05Ud+XlmxW+SQyiGfxDX/zxQrDB1ItdO/q/zO36MfdsAZMi?=
 =?us-ascii?Q?FxOyhItTYUwcecqdJU+EAe42swGzhizstc5h8dir7pH4K0PTGDG4tayEXD2D?=
 =?us-ascii?Q?diwFpQgxPhEoUkG3Rge4xW1T4Tbo3HlkDGZE48f8Ma7R4twhY1qMhIhTnUt/?=
 =?us-ascii?Q?L21DwiP6Vy8NkpXInbty0vuJhGydhjw7EO9K1sBWm+qQNB/NmSc9zv2kEIJU?=
 =?us-ascii?Q?3eX2z6w6SMt6CiVT9lFBCxps4xOsnCbqZjk9ZyPlu0/t4cW7nfL3ABlNEvDz?=
 =?us-ascii?Q?44wKQytkGRTBssIS9lBuBJhfXvMOdHmIVS9Glge8TMZY9a6e690AKkqrAnRo?=
 =?us-ascii?Q?VzOaguOd3x6Rs3QK+ZOjGnoH8vP61BKYJGeDOoNgHKkJWD75rB5X11cLeaXk?=
 =?us-ascii?Q?gtqdYITFp5cEfY5JGswZYes7DSe9HCkWC+tiZk5ZjT7bF4yZj7Tbi3gadV2V?=
 =?us-ascii?Q?AlDQ8ZpO4jL/DDlMu5bvE7+fATzllOs8Ode2j8VR/WaZAhefUTaVLhoxy2YL?=
 =?us-ascii?Q?N0gPDSv7fm35iX1j9CMdIl8U7oWO/F3DR1DWvAG9IKqTi9XAcahgH9uUKDhb?=
 =?us-ascii?Q?qJ2PRqievHaMPM/Yue4XBWPWVSpGndPryzNo4HJLX9yJkBNkkUSr8pGm8WM8?=
 =?us-ascii?Q?CV/NSH1HzJ1xo9PuK9aTT64mSK7Wv81dyN3ao7Vo3yJeSmpSRZ55i+FPK+/x?=
 =?us-ascii?Q?+3V7NBFl8us4OG4Hs1SCWSkOHkdsSqa2FrbLq/7cU+UgopOK1QisIW7v590m?=
 =?us-ascii?Q?bL5ZBpIDDuMWdtMGvV1uDWS4V5xKoJSO5681+62+prNOB/b4hYXjPSZEsO56?=
 =?us-ascii?Q?yTq3eqIg8LWAy2qdHV/4fCAZkF0gY13/HVB7WTbuGa3hcSlbNNtniWxit49/?=
 =?us-ascii?Q?AT5CVhfDj//eXHu5RP2pxQZA5AonqG1wjD7mwevS02TvD2U3KsBamUcgyMCf?=
 =?us-ascii?Q?tVCuXvHZz1M3YjY+rmfbK/KmRl2hjU/TyH4/GoA2JZzdLmqJjyTyeZTGIWq0?=
 =?us-ascii?Q?pcC0uBhFtAaDlzmuNIdzqvAyrD+zf3U/MRVTVy9CSmY1+iOlnUQr8Ot/cWu1?=
 =?us-ascii?Q?Y+ry0BHC2f5x/Buk/1Vgz7ZN3ZZdtf5R5wtFA4QVxpwaNA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB7965.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TGgSnkK+Mog3LZ2k/o8q22rKt80mcXR9Z3j3jMDxtrY66GPlzRCFXG1eW6Sf?=
 =?us-ascii?Q?pO9ZWxJk16gV0JKwKNC9zxWtIQre9gPlgjjBNdodJALhVzDzz3FsvPR4G+DV?=
 =?us-ascii?Q?kFvFbYg6Nex7IvnrleAWYM+nlZZ2vEJ2j+WFUQC5jJbJENWDv3lZilBgpLmM?=
 =?us-ascii?Q?Tqxj5GPQ8duMFpdRxPAWsn0i17UBAyGeQGX4dNK9t8U540X64bjrPCtfR9zZ?=
 =?us-ascii?Q?BsHofTIpzyVjHH0LwrmDJEUj6ZZIf5pY/mal3VtWkSeCd/mYl9hzUDMIU9Xg?=
 =?us-ascii?Q?vuoCM9XO4Qmm7v4HhdJD95nWYjbACQ4z+ov7GrajojBI8Ub3dbVVV+1/4PzE?=
 =?us-ascii?Q?ELg9V6Y1l6AxkUF93Ogibmv92faCpQaXn0XA5CJVjOXs8XG1hIIwOuA9Liy6?=
 =?us-ascii?Q?8vu7wYfYKokn4ZL9xpL7sZ/lQhLH2OhI16zwsuEEPKwsxsBvyOp81V+hw9nE?=
 =?us-ascii?Q?FFyuSJ8VcDuaMVKP3Wgm8kCLk1frkk0Xb8wQquKQz6ZRoOgyRWmg6O53rctF?=
 =?us-ascii?Q?3VncvzrIHyuqqCXYpK4vyXlUYngpXKljaceCrhZlf0E9io/NdSirbSNBmBGn?=
 =?us-ascii?Q?jN3f3lH3NejD8irdFJyGrxKxXFa2ZmqSnkTZdUriEw+KaGDfnz8KDpids1Ob?=
 =?us-ascii?Q?tKIAqgA6fifrZ7z4tfiBra3T+zcTo/BBHohjS80sptzoG5sYEfvJcaUDJzlz?=
 =?us-ascii?Q?rzQvwV7AimN5ykssAq/qxVOz/0midaK6ex1dM4tBJdQCql94LbGgMZ40nloE?=
 =?us-ascii?Q?Camnn5QvdaWbZ0lY8y+niIyNf3KUMgUsUAkP0SksdRtw93QZzguroyUGthYY?=
 =?us-ascii?Q?tgGgBw7AJUDvRIRCWbgej+FZdyFTb/TZlmt+rpfC/wGqhyzo4MPr7sXyiJ7I?=
 =?us-ascii?Q?bT+Mv3jopUJEpuIoZEtBFY/rMDK94A1OqfmawYnRZ8vWaECTlwgdP2sfsW6r?=
 =?us-ascii?Q?322RiOHflVNpyXLBnGxqzdp0evUd/fjDBOJAs1YV5CCm3iNt91N6c1gI6LZa?=
 =?us-ascii?Q?N/JLVNU+Dyw3YCuzFQb4W7WXFAHrpKLiU4uaKvpJFBdzG0zH5Wo65pPNoSLn?=
 =?us-ascii?Q?e6F3zpAinDjb+Ih0ngFB4vo6pXxO0rWEzaDEv5kycQ/P3mFikUBmx/HGyRcJ?=
 =?us-ascii?Q?CnWQ2Mj+6f8+p0BRDOqdQmgGOl8C4hf5+M3K7VJfBsWQEVe67uEhovwc/Mkv?=
 =?us-ascii?Q?naQ2WwpvS++/9qt6pqWpYFek/kFekZgZu8WH7M7y+RRr5V7QMfrWc6TJq5CH?=
 =?us-ascii?Q?Cp6KA1s8xbF+aKX5o1L3xjCh6MPmwZorHAgoydwEGV6cVYB04uCKeB3KIZ6W?=
 =?us-ascii?Q?GjuCealDKZVOlFnATjUUMvsheZWrmF2swkkEFhzmJQKlXN73DoJeNGkQkd3x?=
 =?us-ascii?Q?HYw2z8EeXHSegAFIVVBhGahJQlp31P7ObJ7+P91vgNRiEWcA54AgOwxYsELO?=
 =?us-ascii?Q?gsBWV79HPM5eGWyVD6C0bFy60OafTS4QZQtaSuTOiDQTm7N9ksDVeCJqi6tC?=
 =?us-ascii?Q?OIWsvSVDpCONOJv5opbsX1gF8scq5CpMVHlI4bWWhL+ucCnciEYt1FNJm2Wu?=
 =?us-ascii?Q?smQZHQizQ2He4EdzhsxncBZVI2IPxo/p7ntEElA1S+OFcmNGg2870g3I1nA4?=
 =?us-ascii?Q?kQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB7965.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87bca6ef-d900-48f1-25d1-08dc6424e078
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2024 06:07:52.7280
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 471FMV2B59GQDuWGRHFxrzwrcfa/XSn6LGk/HwagZgAW6L/MKCI2Mg0uWR31AoLHr9+vca2VAeG/YCZ1c9WiRNL3qlbg+3c5cl30Mximyjc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5996

> While the registers that control enabling/disabling processing of the phy=
 interrupt do reside within the MAC
> block's register set in the ethernet controller
Correction, the bits that control processing of the PHY interrupt are NOT w=
ithin the actual MAC block register set either.=20

> -----Original Message-----
> From: Ronnie Kunin - C21729 <Ronnie.Kunin@microchip.com>
> Sent: Wednesday, April 24, 2024 1:59 AM
> To: Andrew Lunn <andrew@lunn.ch>; Raju Lakkaraju - I30499 <Raju.Lakkaraju=
@microchip.com>
> Cc: netdev@vger.kernel.org; davem@davemloft.net; kuba@kernel.org; pabeni@=
redhat.com;
> edumazet@google.com; linux-kernel@vger.kernel.org; Bryan Whitehead - C219=
58
> <Bryan.Whitehead@microchip.com>; UNGLinuxDriver <UNGLinuxDriver@microchip=
com>
> Subject: RE: [PATCH net V2 2/2] net: lan743x: support WOL in MAC even whe=
n PHY does not
>=20
> Thanks very much for your feedback and suggestions Andrew, some comments =
and clarifications below.
>=20
> > -----Original Message-----
> > From: Andrew Lunn <andrew@lunn.ch>
> > Sent: Tuesday, April 23, 2024 3:11 PM
> > To: Raju Lakkaraju - I30499 <Raju.Lakkaraju@microchip.com>
> > Cc: netdev@vger.kernel.org; davem@davemloft.net; kuba@kernel.org;
> > pabeni@redhat.com; edumazet@google.com; linux-kernel@vger.kernel.org;
> > Bryan Whitehead - C21958 <Bryan.Whitehead@microchip.com>;
> > UNGLinuxDriver <UNGLinuxDriver@microchip.com>
> > Subject: Re: [PATCH net V2 2/2] net: lan743x: support WOL in MAC even
> > when PHY does not
> >
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know
> > the content is safe
> >
> > > If we don't enable/register the PCI11x1x's ethernet device in wake
> > > list by calling " device_set_wakeup_enable( )" function, device
> > > power state shows as disable.
> >
> > > PHY (GPY211C)'s interrupt pin (MDINT) connect to PCI11x1x's ethernet =
device.
> >
> > > When I configure the WAKE_PHY or WAKE_MAGIC on GPY211C PHY,
> > > Interrupt generation observed when magic packet or link activity
> > > (link down or link up).  If wakeup enable in PCI11x1x's ethernet
> > > device, System resumes from sleep.
> >
> > This is the bit that is missing from your commit message, and maybe it
> > should be in a comment. The interrupt controller is part of the MAC.
> > So you need to leave MAC burning power, maybe even processing packets,
> > because you cannot disable the MAC but leave the interrupt controller f=
unctioning, so that it can
> trigger a wake up via PCIe.
>=20
> I think there is a terminology problem here. Within MCHP we sometimes cal=
l "the MAC" to the whole
> ethernet controller chip that has everything (i.e. actual MAC, FIFOs, fil=
tering engines, offloads, interrupt
> controller, bus interface, etc) except the PHY.
> That is what Raju probably means when he says that the interrupt is handl=
ed by "the MAC". While the
> registers that control enabling/disabling processing of the phy interrupt=
 do reside within the MAC
> block's register set in the ethernet controller, it neither means that th=
e extensive parts of the actual MAC
> block need to be kept enabled nor that processing packets has to occur in=
 the MAC in order for the
> PCI11x1x chip to detect an event coming from the PHY that should be proce=
ssed as a wake event over
> PCIe
>=20
> >
> > There are a few things you should consider:
> >
> > Call phy_speed_down().  This will renegotiate the link, dropping it to
> > the slowest speed both link partners support. So hopefully down to
> > 10Mbps. Your MAC will then only need to pointlessly process 10Mbps of
> > packets, rather than 1Gbps.p
>=20
> I am Windows driver expert, not Linux so I may be wrong for Linux, but wi=
th the advent of dynamic PM
> in modern OSs (connected and then modern standby in Windows, I remember a=
lso autosuspend - at
> least in USB, maybe not applicable to PCIe  - in Linux ) we have stayed a=
way from renegotiating the link
> to down speed during suspend - resume events since those interfere with /=
 delay connectivity
> significantly.
>=20
> >
> > See if you can disable parts of the MAC, in particularly the receive en=
gine, in order to save power.
>=20
> This is already supported by the hardware and I had told Raju to do it as=
 soon as he successfully got the
> host to wake over PCIe from events signaled from the PHY
>=20
> >
> > Talk to your hardware engineer and see if the next generation of the
> > hardware can separate the interrupt controller from the MAC, so you
> > can disable the MAC and leave the interrupt controller functioning.
>=20
> As mentioned above, for all intents and purposes, that is already the cas=
e.
>=20
> >
> > > Please find the attached prototype code change (Temporary patch)for r=
eference.
> > > I will submit this patch separately.
> >
> > Please just submit it in the normal way for review.
> >
> >        Andrew

