Return-Path: <linux-kernel+bounces-137036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8733D89DB72
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:59:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11E511F22803
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 13:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C66212F598;
	Tue,  9 Apr 2024 13:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="X5u/jFJa";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="R9WvQBjx"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792307BAF3;
	Tue,  9 Apr 2024 13:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.153.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712671142; cv=fail; b=ltLA/v5jY5vMn2FWCAtP2MSYd6fTu4VfItbx5cT2kK6hq2s0LmjU6z2jQjKhOZSBy35PEA6lXv485YUwHkH8FNVWlT1H6rP8atXrh/JiDElaraGEcidhd2oUgLzGOuQJ65jCiT4z7ivCLAQ0Z4WkwziuuHnoP7E/LVCju0ta+CY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712671142; c=relaxed/simple;
	bh=hP848IBBYJWPzpup/IIiR8cKaah1tGjgBaSER5a0/Y8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OWRj0gvY1otLxcHFRsEH/IcGMJHKXwIkJK3S8lZkIX70IshULJmSE42gXDqQnsBHcbn7wgA3JpN47fxJC+DnfscHecHzh5hqqV/v25KJ1kLV7mf6aNMNJtWNkDUJetjyxk++DKT3ygn08I1qeYO3VG399p5qInxqdNtm0Gw51+8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=X5u/jFJa; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=R9WvQBjx; arc=fail smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1712671141; x=1744207141;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=hP848IBBYJWPzpup/IIiR8cKaah1tGjgBaSER5a0/Y8=;
  b=X5u/jFJaqyMJd6pp//bw39RMEJ9zELcuWb1RteojSj1yip/SC4LQzXZY
   3b5UC0TZyD8/MIoUhUXEsfmPrWz4YtH8DTrQztbGL/4fczc0eRO1iY47D
   E1mc/TTwDJDEldNXzhrgC5NmJy/VO2CdWFoBO04vS2yYCcWDLkDnVmHZS
   xSc2Xu/8rCJWMQ61j56hgcX0ULjS0SxJRjDGa6GfZbQKMKE1GDA2O4lum
   vD00byKQg5SLLrJqwAx6Glcp5hBEWUWJZ/WrIvcnQzP3ut1q65vL9RVb0
   CglFB8ZZSchoLkGB0OSvayP2Vt5QnjeckA6XF0/KXdonromQvJUhGj10Q
   w==;
X-CSE-ConnectionGUID: 2FguXor+QDK8TdZxyb6QUQ==
X-CSE-MsgGUID: FZIh20ryScCxWuQGFag4fw==
X-IronPort-AV: E=Sophos;i="6.07,189,1708412400"; 
   d="scan'208";a="20198218"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Apr 2024 06:59:00 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Apr 2024 06:58:35 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 9 Apr 2024 06:58:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZFbgHVFdvEAJZsLxB4uBKOd0xZFblZbo1FD+QsA2TKHkkmrc2f31GScgcAIBDdzoEMueoUwco9GRtOnnhWXRPyWJPPtPbDJt9dEzmvxSgZ6ZkLD8K0aTTX/V+KOHWgjc13903LLcGNMDZqYKRPJtS2UpH35fDh97o+H2OzWIOVyw4UzXi/dfG7nS5+jQLd+aj3cn+BNNuTV8MVHDZbQcfg+uxDh1uzNJgNjtNs4zNDMQyynov4Lvqdscywv2nnXO8SuMHZHNpNxvHKhsYwxAfflSOXzQi20rQakiCPl6ZA7d/IOBFMTAAGJwGmu6GzdAQMc6GAgLzgYsw4hp/GoAeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hP848IBBYJWPzpup/IIiR8cKaah1tGjgBaSER5a0/Y8=;
 b=EuzV1HZUNCDFJPN+wzASynY4UgUI4K9xE8OF6/TyVxvPf8kINfKQLLr8rZ+GamHPaYRFp+v230pKyx+W/6sSbeAmhUWJkL3IqiyKw+Aszw9MqgAVo9c9/M5dPFNrONvq42pD9k3+QIOYCwNiislLEZ8fc2my6vIfOe9asuMy8qXg7rA97QPvFGSPQ1Vovil1X3URxz5y4fqclLp6QKwg7dOBxcLBtit6+VquYpIrucFVo1y8d7ijHhOQ5YtnXrc9NQghQjEOC94IiPnhcaoJ3+tIM04FYQ/TgQ1tGFnYmM8QTdAMgYpvCXEHUZh/mBwT73emF+H43awIJ1n20zTitA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hP848IBBYJWPzpup/IIiR8cKaah1tGjgBaSER5a0/Y8=;
 b=R9WvQBjxXCvt0air1hDddhLT0o/L4yHJqH+G4IR0/ZJIZlnUoD2FOkZgctEAnH5a0gvC54+dODZ+HAmA4vo7t2gmBuUyZkGVdzH9qfXEUU2kMiVbqS4/G4bVg5vrYcnq8/X3h7zJgLdd6AAEIradnO6QmKqdrdrxUkvvfHf4tYdD+CYJXQh0JL55h62TlW2d51AnqRYvxuO+eZJ/+2xVALUtlN1LXMREv5BguuxPlj4cr4n5crQz6OKj268/yN3dWj/BDngs4SZQli5Dz7JxBwD/TRyIGpGhE4lfUPOxlyXsK64oP9hgvWIylfWfFswrhNrD9TcvLsx09yAwppocJQ==
Received: from PH7PR11MB8033.namprd11.prod.outlook.com (2603:10b6:510:246::12)
 by CY8PR11MB7687.namprd11.prod.outlook.com (2603:10b6:930:74::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.20; Tue, 9 Apr
 2024 13:58:32 +0000
Received: from PH7PR11MB8033.namprd11.prod.outlook.com
 ([fe80::d529:f716:6630:2a1d]) by PH7PR11MB8033.namprd11.prod.outlook.com
 ([fe80::d529:f716:6630:2a1d%3]) with mapi id 15.20.7430.045; Tue, 9 Apr 2024
 13:58:32 +0000
From: <Arun.Ramadoss@microchip.com>
To: <andrew@lunn.ch>, <olteanv@gmail.com>, <davem@davemloft.net>,
	<Woojung.Huh@microchip.com>, <pabeni@redhat.com>, <o.rempel@pengutronix.de>,
	<edumazet@google.com>, <f.fainelli@gmail.com>, <kuba@kernel.org>
CC: <kernel@pengutronix.de>, <dsahern@kernel.org>, <san@skov.dk>,
	<willemb@google.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <horms@kernel.org>, <UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH net-next v5 6/9] net: dsa: microchip: dcb: add special
 handling for KSZ88X3 family
Thread-Topic: [PATCH net-next v5 6/9] net: dsa: microchip: dcb: add special
 handling for KSZ88X3 family
Thread-Index: AQHailbLQB5pI/BwAECOxifyCj9vBbFf98KA
Date: Tue, 9 Apr 2024 13:58:32 +0000
Message-ID: <fb6ddb9065a322ec85ae5b6f71a07e411f6830d3.camel@microchip.com>
References: <20240409081851.3530641-1-o.rempel@pengutronix.de>
	 <20240409081851.3530641-7-o.rempel@pengutronix.de>
In-Reply-To: <20240409081851.3530641-7-o.rempel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.36.5-0ubuntu1 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB8033:EE_|CY8PR11MB7687:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VE0tziZlua9c5nyDmy5XEkD9URkzc4NSYuYa7TFqpUBDQvFie6qzI2UgbbhZBLJLwbYeypPDM7badaccuG/nIhT9QtqToCHkxXWl58tZLbwtKQecO04jo9KfIIaL9QCrPKfswfZuoWPZCxv3Himiw1cbjYv8RCnzhaIy6VUvpWcFMPNIbdOVTkitOhxcNnx/+LvFwoRMCvNmIERtLyA2SIy7UbX7RauEQQQWt3xUBvhZ5ZLGMCDHg6q6gMYxdbs/8zXAeRMZ9EE0rDeID6cpJUmvdy9OxF12gLa7SD3mqxWwlxUqGHJtqA8WR9W0EZAEq9/L09DaMXSaNePzvPTwLJlWSevEk8pakUtur6R8yoa05aeLuJ7W4ymKYIWYh2oyP0qupLk3gL6hhCsfQUv2EBnLwDGnURboPm+6UEVINZATsfRSLjhNO5vhqcMmnNQixYgdQZBIVbg7f65oBhqLM9VkiDdhy5eVlvlkki0WMSyGp0+84vmQ8zUlEhI7SKuLOiaR2aAtW/AZX7anxQ9Y/HQ+Wg6OQYnBjVW9htLSSzT6TyhJdDot9FXyeNXxY9uVvKPknhNnXt0NTaS17aXlvB09uEKxvlVrtA5KwtlNVSOWGpr4M71Gg5pMGQrCYOVLZ6XUCE52YCnqy+54HPAAR6LquoUFdiIANlX1ZFp9lbc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB8033.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(7416005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bXdSN2pvb0liejMyMjFxSVZQT1dxdkNRMk9WdXl1TDBsSFR5djV2T3N4V2c3?=
 =?utf-8?B?c1RXR3VSZUNUbG1hR3M4UFFCMk1rR3lqWWdueERTRGJuZVZOVUlmaDBnOXMx?=
 =?utf-8?B?ckV4dzVucWUzd1gyRzRlNC85Vnd1bzBLWkFrQ0g0VkVjOUp1TmdOR1M0TkFz?=
 =?utf-8?B?NHBWN08zdW1WQjdQMXo5ZWJrUlNRdnlXL0pXcmZVWE1RR1BBSkNmelRaSEph?=
 =?utf-8?B?MkRzZEM5YlQ4SjF5TnRhWHlINXhTS2xSbHlSSEsrM1FuZWllUzhybmdRd0ZP?=
 =?utf-8?B?aFVia09sTjFLbklNU1RXQU1XSU1vTFo3RXFtN3RtWE83TnBIQjhzVE5zcUdh?=
 =?utf-8?B?VnVDZlZiUzd0cXdtZGdYRlhRQVVqTms4WWpEaExCamNZSmx4OHE3M2pOMUtm?=
 =?utf-8?B?R0xYNUpvcXRUM0NMeVJzTHkwWFRmUGpqekZyVUZKcHBhT0YrcXNlRTVNRlJw?=
 =?utf-8?B?QU1oL0VTSU1xaENidkg5dmxuUERRL1c1ckJWaVRJYmdQYkdoeHpoQ3BrajZx?=
 =?utf-8?B?UnBoT054NG9qdXJPbzNjMVFYT05iOUFRMXVWTkpWem1kQTA5L3loTENGY3dj?=
 =?utf-8?B?SEVFVG4rVXJLbGU5VlFWU0R3R0c5Tm5iMUtub1NuZmFwZU1vaFlkTVdoNWZj?=
 =?utf-8?B?c3Y3UzNKUWV5dTZoMi9nQWY5YzkvTi8ycnZmK0JCYmNpdTNlb3BsV3dVYjcx?=
 =?utf-8?B?OEh6N1ljcTU5U1pQN0kwWWNZTUlNQnRYSmpySVBzYzFybjJCYU9SeWhTRjFQ?=
 =?utf-8?B?YmtGK1hVK3FieEtYcnQzbGZVTU5VZ3ZoRkk3THdPdEhxbHBzVVdwRnlxWUVJ?=
 =?utf-8?B?ZXBDWldib0g4dlBDbDlvaVNHdjlJOTBNT0VNZTFpQ0pJZ3lwSlZPZ0srMmVa?=
 =?utf-8?B?cHVMd2hXRHE5b2JDZStnc3NXTmRvM3FobjhYR3ZDa0tCaVZ5SDNmb3BZMC92?=
 =?utf-8?B?ZzhrVFoyVGpWNmlxYmcrMk1rcmdOV1YyZWwzbjVETmlMS0VEd3FoczBTaTFa?=
 =?utf-8?B?WVFkeGp1dkxVc280cSsyT2p5MmhzUHFLNlJrM0lXUmNMYjBwcEd4NGZMVk5y?=
 =?utf-8?B?U3docmh1TmFTZGFkbGI1K1YzaTNqWVZHTk9TTGhGOXlYZEVFWjJlcThpQm9W?=
 =?utf-8?B?WmM0T1ZRT3BJclRadDNGeFdQeTdiaE1Jc3hLMXo5NHk0Z1BuT05sM3VIS3NV?=
 =?utf-8?B?Y2M1THFYTnB3WWo3WkF4NUY2dnR4QjUxTFB5RnRTUThiRm04WjI1T3hPdHlS?=
 =?utf-8?B?ZzZQQ0ZNWndteEVhYmsvU0pWY3JSdExMRk90d3JKS3U4UThlUTFON1VFRllz?=
 =?utf-8?B?K1psSEhEMjdvaXFlcHd5Z3JyL29EM0tWSzJPdXhROFhOQS9pSk5RaGYwWHdF?=
 =?utf-8?B?cGxYb08wcEx3SG1ORExONlcvNW50SFNPTjRIaUZJMzFtZW0zc3Qzdmx5bkF3?=
 =?utf-8?B?WG1ReENNdkNpcEtkTU5UVnltUm9JbGVDSURZUGp4YWZlTXI2Sk1OczlEYjFD?=
 =?utf-8?B?bnYxMlZydVhuTDd6Mnd2RVROY0hJYTlsZlJ4dCs1NmVLWnI2d2pUcjBuc0kr?=
 =?utf-8?B?MmdQZkZEcC8wUUtoWS9OME1ITDhnMkM5bklxWGk2UjNla0o3V2t2aFFnejdT?=
 =?utf-8?B?cHU0bjBPNGZhcWhXb09kd2NsRTlUMndSSHRNQmVRZmJialBGOWQ0RWwybmRS?=
 =?utf-8?B?cDhhVVpRQVhHMmp2c04zZEtLSWtBaVMzQkg2TDJjdUhISEpBSURtSG14R05r?=
 =?utf-8?B?bFJMSmRRMnRZY2p6dWpBM2RZSVdmMnBJc2laWEFGL1BEVHBNSjlWVC83YWo0?=
 =?utf-8?B?Uk9pWGJJMXJjbEx4akY4U3F4MDVBVkFoYzIwcVpzc1NSalF1TUxVREZiRnBo?=
 =?utf-8?B?N0d1dGtTcEliMXh1MGFvRmVDM3dDMWxFb3FEbFpQcWc4eVJlU21HdW9HdXJT?=
 =?utf-8?B?SFFOMUJOenRDcUhldU9IZDVjR2ZxcjNLb3Y0YXJXNDdEaUpCb0szaHlEVkRw?=
 =?utf-8?B?ZE9FNldFMGs4QmJvbHZXTDI2VDlJMm9EV1lTTVBLajRjWlZrYTh2VVA4ODBw?=
 =?utf-8?B?ZFdFeU0rcmNnZFRoSGJwM2ljR3FVcTByUzJndGRYRGc2MlhpeFZuYjhBdDUv?=
 =?utf-8?B?L2E1YW5xd1JaMGdsWmhra0M3UFNsRE1oUGhEeFZGSnh5cXFRZ0o5WWVQWFVn?=
 =?utf-8?B?Y1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F2061E7FFE870A4DA40B080D366E37E3@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB8033.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e42260ab-e34a-4c36-5476-08dc589d2486
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2024 13:58:32.5471
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rI42ql831m+G9lbFuen+Dc5aMvATdW76mQbLrZBmQS7H1v5P6lC3hjXcRD6GLBFKPSWqoBcLtL7ps59jqi38H5WjMPGTxic1TmrTTAm7jTA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7687

T24gVHVlLCAyMDI0LTA0LTA5IGF0IDEwOjE4ICswMjAwLCBPbGVrc2lqIFJlbXBlbCB3cm90ZToN
Cj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRz
IHVubGVzcyB5b3UNCj4ga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBLU1o4OFgzIHN3
aXRjaGVzIGhhdmUgZGlmZmVyZW50IGJlaGF2aW9yIG9uIGRpZmZlcmVudCBwb3J0czoNCj4gLSBJ
dCBzZWVtcyB0byBiZSBub3QgcG9zc2libGUgdG8gZGlzYWJsZSBWTEFOIFBDUCBjbGFzc2lmaWNh
dGlvbiBvbg0KPiBwb3J0DQo+ICAgMi4gSXQgbWVhbnMsIGFzIHNvb24gYXMgbXV0bGlxdWV1ZSBz
dXBwb3J0IGlzIGVuYWJsZWQsIGZyYW1lcyB3aXRoDQo+ICAgICAgVkxBTiB0YWcgd2lsbCBnZXQg
UENQIHByaW9zLiBUaGlzIGJlaGF2aW9yIGRvIG5vdCBhZmZlY3QgUG9ydCAxDQo+IC0NCj4gICAg
ICBpdCBpcyBwb3NzaWJsZSB0byBkaXNhYmxlIFBDUCBwcmlvcy4NCj4gLSBEU0NQIGNsYXNzaWZp
Y2F0aW9uIGlzIG5vdCB3b3JraW5nIG9uIFBvcnQgMi4NCj4gDQo+IFNpbmNlIHRoZXJlIGFyZSBz
dGlsbCB1c2FibGUgY29uZmlndXJhdGlvbiBjb21iaW5hdGlvbnMsIEkgYWRkZWQgc29tZQ0KPiBx
dWlya3MgdG8gbWFrZSBzdXJlIHVzZXIgd2lsbCBnZXQgYXBwcm9wcmlhdGUgZXJyb3IgbWVzc2Fn
ZSBpZiBub3QNCj4gcG9zc2libGUgY29uZmlndXJhdGlvbiBpcyBjaG9zZW4uDQo+IA0KPiBTaWdu
ZWQtb2ZmLWJ5OiBPbGVrc2lqIFJlbXBlbCA8by5yZW1wZWxAcGVuZ3V0cm9uaXguZGU+DQoNCkFj
a2VkLWJ5OiBBcnVuIFJhbWFkb3NzIDxhcnVuLnJhbWFkb3NzQG1pY3JvY2hpcC5jb20+DQoNCg==

