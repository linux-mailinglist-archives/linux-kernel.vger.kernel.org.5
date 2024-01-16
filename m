Return-Path: <linux-kernel+bounces-27019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09F6982E942
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 06:53:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95044285318
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 05:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33277F507;
	Tue, 16 Jan 2024 05:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="IsoWbVa8"
Received: from esa16.fujitsucc.c3s2.iphmx.com (esa16.fujitsucc.c3s2.iphmx.com [216.71.158.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B41010A01;
	Tue, 16 Jan 2024 05:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1705384416; x=1736920416;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=wspj8Kjl0oyduamOqUq5Xso7J3hso2il6WDhcQEH0fA=;
  b=IsoWbVa8b4VmOvtpsWxE/LN9Dqof6oKhpZD9jhxMeUG5YM90TVsx4LWH
   G3pk8sHUCJrWJ+AjkOeMpCzscXqYu0VrebOJOLc6sgnDjOHNQJz3VRYGb
   YMAmk0nWbnl5bAzvIc58nNsfL/ZdXExBwWmOjlxVEPVKfpFonsn/gHAuR
   NlNYFbwefvt/OGZH1WJAPI+VEE+d4kCdbuNb+6xsnF8Jw1HokbuCcZsym
   AhPEcFmMaI5jORlnSQjeuCV9xMmayzApTJMUzV9NLn9DraT8YYlRZANTi
   pTP4q2LpYCeH8rvl2NTC2hFoIKouYwUZqHhI7KV7Up9rX0ymeZVs9HaD0
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="108250673"
X-IronPort-AV: E=Sophos;i="6.04,198,1695654000"; 
   d="scan'208";a="108250673"
Received: from mail-os0jpn01lp2104.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.104])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2024 14:52:18 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DU6qV+K4awRjDYSyb8NOwieZWeWFV7ZydOPU23VW5JzbgAGYK/RsKWF7gm7BrMnj15E8oqmBieRnjJjajFpODwfVlorQCFchrP/lM3i6ooXqOhl+FDTiFe9U3ekhYBduhmQv2/hRsAJZsGHl0n4JWVr+DvcMYUe3my3a4UTEqpTy5SmkVZsbnrnyjPJzUIkSH0NSVHpbMIji4HaEkUA7WwgOeOmjl3/vWi+sevEDm4FiIdGrdb6nFxUTVAS/eBTA1I7NlnNnTypNx3wZwZwjlEqERVp7mS7FEZHJXffUX7bwfRlqVNyPEO2TaVOv9WJ8HE8HAdgZynAXjVRkogjX1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wspj8Kjl0oyduamOqUq5Xso7J3hso2il6WDhcQEH0fA=;
 b=oNGqHpYwjCt0UKS7QepfYquI0KOI90megJuh/oWQvC5FsD1eEA1qlTtczhOD08IVRLwLCY/CQqz4edQH+mfr2CSo3QYHTtDhor96dzry0z6jzfX0syJU3132JdKQhpmqXpn7giV+lByv3f5j9uXdZICNCq3owcFhrzHkJQY3sCaPYgSc8CbM+kkpnxcAPjo8BSiTQ4BSTxuTVVsQfcXXBZTlBDisl5yQ0/H9VBfFziFJa0WfDioopzNJiAGkbg9CpB2spuCSC9JgKLD0h+omVDtcczE0gfFGZI90XtGN2T+/bdWjOvotyEoi8wyGRdDBSIqIWvwosOLBQInGXI/CsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS0PR01MB5442.jpnprd01.prod.outlook.com (2603:1096:604:a6::10)
 by OSYPR01MB5480.jpnprd01.prod.outlook.com (2603:1096:604:8e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.22; Tue, 16 Jan
 2024 05:52:15 +0000
Received: from OS0PR01MB5442.jpnprd01.prod.outlook.com
 ([fe80::c96f:52b0:dd4e:8d50]) by OS0PR01MB5442.jpnprd01.prod.outlook.com
 ([fe80::c96f:52b0:dd4e:8d50%6]) with mapi id 15.20.7202.020; Tue, 16 Jan 2024
 05:52:14 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Rahul Rameshbabu <rrameshbabu@nvidia.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Richard
 Cochran <richardcochran@gmail.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: Re: [PATCH 15/42] drivers/ptp: Convert snprintf to sysfs_emit
Thread-Topic: [PATCH 15/42] drivers/ptp: Convert snprintf to sysfs_emit
Thread-Index: AQHaSDfKq4UVG5RABUyqD6L9r7IuSLDb4akAgAAOJQA=
Date: Tue, 16 Jan 2024 05:52:14 +0000
Message-ID: <f8a1d2d3-baa6-414f-976f-492b8b735154@fujitsu.com>
References: <20240116041129.3937800-1-lizhijian@fujitsu.com>
 <20240116045151.3940401-1-lizhijian@fujitsu.com>
 <20240116045151.3940401-13-lizhijian@fujitsu.com> <875xztzx3e.fsf@nvidia.com>
In-Reply-To: <875xztzx3e.fsf@nvidia.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5442:EE_|OSYPR01MB5480:EE_
x-ms-office365-filtering-correlation-id: a6e43cae-6005-467d-bf1d-08dc16574a86
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 LUXPyK60n6OX9KmjUdVHjK/CQhPfEiBm6FtYyNeglx7dvBSRTQIBpqhYaj1g6fE9atu0Q8GnmRdTdGjb5+WcDNcMY9VuWnkgB3nwZlGrPejomvPOIn40DQdgvWU83+SxdJ1GiqrKHN6Hy36uoKaQyB0gOKZ3OcxeTmjRk7/WQ0TvII8fzIREOox6QlU4LTxefdJglupDFO67R45Tco304kj1Ytp/AVX4QQwV5HqRrjsrTG3Q+y43k1qVqnSUS/usejAt2knT1MQV8AIGUA/+VHEjZ6oFd8j/UEEerisOLEo2GTha0Dy823QgZt87veT/QdAPBgjOpMRaZSRNskxy+fPjIy9CAKHgO22/Yln8WmpzxAsDYr/haoz8NWk/Q0Yz7+yRB2JN6n9wx8ZSMdOlbW1KlYfh40ZGpiKxSJ6O/upfX3Nv6HMvmwHwZGovxmMiUKh/nZst4h1c1KZ2W9+2LyiK3uttQpbmk3QY2VRlHrfGYERQuU/wXiPuKLmP31rs2xSxxnUwWTHaYL5OKRmFLH/9cRdlA70ArbqxxWt7x/i1ZQJHGz413MsXdO/RL8griC05mfWYQeDSteZg35NLUA5vcDPOMG8Mlm6UA241H8ZYPwShJWUcmxtDJYhKw4dEsdixwZ5i9NhSkCiIFpkG78FjKBgtfDfWTi4EmNCOmE48xdcT+MiYlfqiuRdTRgx7WqhudIJXsOs9PYigzpMDQvkhjXE2rzx4XLkgdYSzZvtlANx6kDDagbQWrwh68mFc
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5442.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(346002)(376002)(366004)(136003)(230273577357003)(230173577357003)(230922051799003)(451199024)(1590799021)(186009)(64100799003)(1800799012)(83380400001)(1580799018)(36756003)(38070700009)(41300700001)(31696002)(85182001)(86362001)(82960400001)(122000001)(64756008)(38100700002)(66556008)(53546011)(6512007)(6506007)(66446008)(76116006)(66476007)(91956017)(5660300002)(71200400001)(31686004)(54906003)(4326008)(8676002)(8936002)(478600001)(6486002)(66946007)(26005)(2616005)(316002)(2906002)(6916009)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RFN2bnB2d2R0Y3dUWTh5MHB6UlB4Q01mN3NNSlVDN21SMHZQWTA2NWlVekFP?=
 =?utf-8?B?MDY2MUtsS1ZNKzlJRzI1ajlYemJtQ25JYnU2VStlemd0QTNHTlA0czRMZkV1?=
 =?utf-8?B?Z1VaTGJiYW45blpZWjljYk1UK0hoQ2ZrS29HYzM0SHphbmIrWlljSTBGUmkw?=
 =?utf-8?B?UU1LTHZ2UC9RQ1ZWM3lLNVF4aVdERUNjS2dwZmZ1ZE1NUUN1RG1ac25pdUpT?=
 =?utf-8?B?Um9ncGZwTkI3aWx5blJkUkQ4b0xvWlE3QTBzRVR6QWErWGUrWldnN3hQOUNL?=
 =?utf-8?B?Wlp5Y0c2VVd4Rmp5OXF0eEJFb2l3T1AvSzVoMUNGVUQ2QUdHQTBtZHA5K2xx?=
 =?utf-8?B?MHZFVkVmcGxZYys5ZkdXSEcxTklTd29ob0R4aWZibzYycVdaMTRjc3hpT2xQ?=
 =?utf-8?B?by9Bcm9mdEg4Rzg0SVNaL0J0WTNBMHF0cXR0NklSUXVPVUJVU0o5aTF6V0lH?=
 =?utf-8?B?RlFNZXZ5dmdsejZ0UFJRdXN6V1lIQ2hnOWExZEJyR3Y5d2EwKzQwOFJ5SzJW?=
 =?utf-8?B?dnlUbWJGdVdJWi9idGhzM0pVVlBOVmhRcitqMW9sODVZUEk2NGlmMUJ6ekVn?=
 =?utf-8?B?WXdkbUdlNVg3MGc2QXBtMlFYSkYveDA3OUdqd2tCVHBLakJxSzlCd0FzcDlV?=
 =?utf-8?B?dUlsN2dKOFlKcVQ3SWd4K2FXVGdwT1JrT3A5c2N3d2lTVERCMHN6ZG5wSXlQ?=
 =?utf-8?B?QzRiajlISGJ6QndZRnNrTHNkdWJnazR2TDF2YXBXYVdRMndacDg2cjA1RkNB?=
 =?utf-8?B?OG1LU0VkTDVnNSt1R2JWdjBTZEpORkJPRmlmT04yWi9KNkpSS1FSbExUS3dZ?=
 =?utf-8?B?RXFEWEpEU3l2STB5SUpKbG1ETjRVN0xpZ01mTlU4SDBBNkU5TFBnV2xMNDI1?=
 =?utf-8?B?RjZndlgzc1BBOU4zaTdxdDkzSWUxeW53YXJ6K1RYT2FDWVFwaFc4MjgxaVhK?=
 =?utf-8?B?VzBkMUptMTF1OUQwSGV1eDhvNC9GZitPN3Jja0VXdmVWYnBlRmdmSVJKbnZy?=
 =?utf-8?B?VHRXd3lwZEh4YlRFV0gxUzFPZTZQTXJFbU9UcnRWN3ZoVjFFcGptc1BaSVRx?=
 =?utf-8?B?QnFYVGhwdXQ0T0tyYjFXRGh1TlY5VUgvcDlIV2pyL0dEUitvRWptV0ZrWmdM?=
 =?utf-8?B?VDh4Yzk3emZiWFI5clBCNS9mYWFiajA1S0lkdlJjV0J3SVlWMVZTZXB1YzA4?=
 =?utf-8?B?U0VhVkw4OUVDSmM5amdmVzMwb01kWWRvdFZ0OWFIbXRFb3J5bndMSndCMUlj?=
 =?utf-8?B?ak5ZVXZjQmJQTE02UXhtaWxKcThIVVFLTGMxNXM3OVdLSW15N0h5cS9VQXpY?=
 =?utf-8?B?bGY3VVVHUkZhQ2xZV2VWOGs1a283QnhGcjlhVXVTZjNGOUxudUtiWHl0R1VX?=
 =?utf-8?B?OUZmQkJoY2IrVDNMZEpPK3pOdnk0QVI2SHdHK1JHWmdZenNUWlNHQktBYitu?=
 =?utf-8?B?U3duanRULzJvbDNsWHlIalJrSmZVeXRPSFlHb0ZoNkNkd0pSWXFwS00zckRN?=
 =?utf-8?B?eWFFa0o1UVBFV3p1SFNQVU80UFpuUkVEUGhlOWZwamFhKzRXVVdlTWQ4M0ll?=
 =?utf-8?B?d0k2TjlkK2dGL3EyMHJ1Tmh2bVEzM1plOEdSMlE3YTE4OFpNWmlzU2M2Qm9t?=
 =?utf-8?B?QWhaNHVIOW5UZDdTMmdNT1lndjFiQkw4TkJxaGo5OUhtY2ErTjNROU0wcEFS?=
 =?utf-8?B?clhQMjdRbEoxQUtjdkdnUUgrNE5hV1Jpd1JqM2h6Tk5DVm5qMWpaQ1dER0s3?=
 =?utf-8?B?V29BelF6OW5OSi8vek9xdEVIV05tQTVORExvY3pSNmRLWmpTZnpjREZURnZU?=
 =?utf-8?B?Tk1teHZNenFqZkRsSkpNV0NWU3RsZFMzTWtqY2FUcU81M09ZanltSFY2c0JK?=
 =?utf-8?B?bnZTV2pvQ1U5TGRtMmZDeDNML2ZDODRaZ3JLODZxME5MNE1BZDNSdUhJdkxv?=
 =?utf-8?B?N3hXczBtazVLeThDOU1Tc3BxaHJEOVJZSit1Yy9FNDAwb3hFWHBwVVpTNjFo?=
 =?utf-8?B?NEhjNThadzEzY2lVcUxVNFRhTElhbkxCa1F6SmNieXRYcXJzOGJweDZLMFUv?=
 =?utf-8?B?eStMMHNEL1QzaTUwOHZpaEg3ZHk4NlN3Z1l0RHd1SGI2RkJ0TUgrR1ZxRGVQ?=
 =?utf-8?B?WTNSUjFzdFNRczBCaHNrNEt6bWg1K3Y4K3VTSUxVLzQ1MTFRV0s5L3kvK2RE?=
 =?utf-8?B?WVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6A0A0E57FC60D745A6A4B4DC0ACBE02F@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	cnnOiR4cprP8DxQwEj1G7KbozDB3yJ5w3ZiC98OUTR9uHvptsrQrpHSt/oPt8EVahDrCLqMZWDlOa8leUa+FDbgEZruRLOIUOw9QNZ7C/GdIq3MQ1hVeEwG8x3LxoMi88CbZLoAp+MmUGmIGLBsY6XNBR2DCJFuobQPlKljBr6UTVmKgUjwHhPjcO6jeDS3oDHGIBQRqPwzazwvEqVGOMyGNJttku2v7d0/n52uWKlYbk0U4qYTztgMxq9ZsyFUQMHAyyh7L3AUhvJd0n49PhByyJqG4vHJrL0l22LfLr2j1qFLewwiAiqyBO6e+AlEBTqLD5lGdj8MMyidhoVHH7ZE173tMYbAVR21ZIh3wZkTHflzb95/Pdppmw9Ly0yC9bmJmykXJ94njDO45DehnlYZt06v1pFnhgbNGb+lXuRxWJooggd2F0+X2SANwU62qgkRMtrggi7nwoQVsSQAEvfRzZnuAZbrmPe8zMRviD9S8hGWyP6/XpVPdUh7m7COQaAabBfzizYYWeXVEyjykAKhsooWl4rTNxDxfP3mDKxVim0Zdu0BoSC1VH2wLlS9wGg/a8JTfWUC/WFjfsUi4SbpUSgDcg637ip6/Z7pAu6CslUxLCP+Hp+29BaKxNk2A
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5442.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6e43cae-6005-467d-bf1d-08dc16574a86
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2024 05:52:14.7743
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hsRLgS7QerInqNWLRV+I7aE0BBKUauPz4IcwAet6JrdIz1SC0hjbhOzCqjDarfOJK6TgmWtcURnbXhIOq4bnYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSYPR01MB5480

DQoNCk9uIDE2LzAxLzIwMjQgMTM6MDEsIFJhaHVsIFJhbWVzaGJhYnUgd3JvdGU6DQo+IE9uIFR1
ZSwgMTYgSmFuLCAyMDI0IDEyOjUxOjI0ICswODAwIExpIFpoaWppYW4gPGxpemhpamlhbkBmdWpp
dHN1LmNvbT4gd3JvdGU6DQo+PiBQZXIgZmlsZXN5c3RlbXMvc3lzZnMucnN0LCBzaG93KCkgc2hv
dWxkIG9ubHkgdXNlIHN5c2ZzX2VtaXQoKQ0KPj4gb3Igc3lzZnNfZW1pdF9hdCgpIHdoZW4gZm9y
bWF0dGluZyB0aGUgdmFsdWUgdG8gYmUgcmV0dXJuZWQgdG8gdXNlciBzcGFjZS4NCj4+DQo+PiBj
b2NjaW5lbGxlIGNvbXBsYWlucyB0aGF0IHRoZXJlIGFyZSBzdGlsbCBhIGNvdXBsZSBvZiBmdW5j
dGlvbnMgdGhhdCB1c2UNCj4+IHNucHJpbnRmKCkuIENvbnZlcnQgdGhlbSB0byBzeXNmc19lbWl0
KCkuDQo+Pg0KPj4+IC4vZHJpdmVycy9wdHAvcHRwX3N5c2ZzLmM6Mjc6OC0xNjogV0FSTklORzog
cGxlYXNlIHVzZSBzeXNmc19lbWl0DQo+Pg0KPj4gTm8gZnVuY3Rpb25hbCBjaGFuZ2UgaW50ZW5k
ZWQNCj4+DQo+PiBDQzogUmljaGFyZCBDb2NocmFuIDxyaWNoYXJkY29jaHJhbkBnbWFpbC5jb20+
DQo+PiBDQzogbmV0ZGV2QHZnZXIua2VybmVsLm9yZw0KPj4gU2lnbmVkLW9mZi1ieTogTGkgWmhp
amlhbiA8bGl6aGlqaWFuQGZ1aml0c3UuY29tPg0KPj4gLS0tDQo+PiAgIGRyaXZlcnMvcHRwL3B0
cF9zeXNmcy5jIHwgMyArLS0NCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAy
IGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3B0cC9wdHBfc3lzZnMu
YyBiL2RyaXZlcnMvcHRwL3B0cF9zeXNmcy5jDQo+PiBpbmRleCBmN2E0OTlhMWJkMzkuLjQ5NzM3
ZWQ2ZWY1ZiAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvcHRwL3B0cF9zeXNmcy5jDQo+PiArKysg
Yi9kcml2ZXJzL3B0cC9wdHBfc3lzZnMuYw0KPj4gQEAgLTI0LDggKzI0LDcgQEAgc3RhdGljIHNz
aXplX3QgbWF4X3BoYXNlX2FkanVzdG1lbnRfc2hvdyhzdHJ1Y3QgZGV2aWNlICpkZXYsDQo+PiAg
IHsNCj4+ICAgCXN0cnVjdCBwdHBfY2xvY2sgKnB0cCA9IGRldl9nZXRfZHJ2ZGF0YShkZXYpOw0K
Pj4gICANCj4+IC0JcmV0dXJuIHNucHJpbnRmKHBhZ2UsIFBBR0VfU0laRSAtIDEsICIlZFxuIiwN
Cj4+IC0JCQlwdHAtPmluZm8tPmdldG1heHBoYXNlKHB0cC0+aW5mbykpOw0KPj4gKwlyZXR1cm4g
c3lzZnNfZW1pdChwYWdlLCAiJWRcbiIsIHB0cC0+aW5mby0+Z2V0bWF4cGhhc2UocHRwLT5pbmZv
KSk7DQo+PiAgIH0NCj4+ICAgc3RhdGljIERFVklDRV9BVFRSX1JPKG1heF9waGFzZV9hZGp1c3Rt
ZW50KTsNCj4gDQo+IEkgYXV0aG9yZWQgdGhlIGxpbmVzIHRoYXQgYXJlIGJlaW5nIGNoYW5nZWQg
aGVyZSwgc28gZmlndXJlZCBJIHNob3VsZA0KPiBwcm92aWRlIG15IHJldmlldy4gRG9lc24ndCBQ
VFBfU0hPV19JTlQgaW4gdGhlIHNhbWUgZmlsZSBhbHNvIHVzZQ0KPiBzbnByaW50ZiBpbiB0aGUg
c2FtZSBtYW5uZXIgYW5kIHNob3VsZCBiZSBjaGFuZ2VkIHRvIHN5c2ZzX2VtaXQ/DQoNClRoYW5r
cyBmb3IgeW91IHJldmlldy4NClllcywgaSB0aGluayBzbywgYmVzaWRlIFBUUF9TSE9XX0lOVCwg
dGhlcmUgYXJlIDMgb3RoZXIgcGxhY2VzIG5vdCBkZXRlY3RlZCBieSBjb2NjaW5lbGxlIHNob3Vs
ZCBiZSBmaXhlZC4NCkkgd2lsbCB1cGRhdGUgaXQgaW4gVjIuDQoNCiQgZ3JlcCBzbnByaW50ZiBk
cml2ZXJzL3B0cC9wdHBfc3lzZnMuYw0KICAgICAgICAgcmV0dXJuIHNucHJpbnRmKHBhZ2UsIFBB
R0VfU0laRS0xLCAiJWRcbiIsIHB0cC0+aW5mby0+dmFyKTsgICAgIFwNCiAgICAgICAgIGNudCA9
IHNucHJpbnRmKHBhZ2UsIFBBR0VfU0laRSwgIiV1ICVsbGQgJXVcbiIsDQogICAgICAgICBzaXpl
ID0gc25wcmludGYocGFnZSwgUEFHRV9TSVpFIC0gMSwgIiV1XG4iLCBwdHAtPm5fdmNsb2Nrcyk7
DQogICAgICAgICBzaXplID0gc25wcmludGYocGFnZSwgUEFHRV9TSVpFIC0gMSwgIiV1XG4iLCBw
dHAtPm1heF92Y2xvY2tzKTsNCg0KDQpUaGFua3MNClpoaWppYW4NCg0KDQo+IA0KPiAtLQ0KPiBU
aGFua3MsDQo+IA0KPiBSYWh1bCBSYW1lc2hiYWJ1

