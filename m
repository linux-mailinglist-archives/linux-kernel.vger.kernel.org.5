Return-Path: <linux-kernel+bounces-108626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CC35880D3C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 09:41:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19A0E281B0B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 08:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F73138DEC;
	Wed, 20 Mar 2024 08:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="vkgGH/au";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="y9bMjMpS"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E538B18C19;
	Wed, 20 Mar 2024 08:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.153.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710924071; cv=fail; b=Me5wUkLePj7HK+Lp9Hu7XzpVbD37tL9iF2i6SnKCEEbFRvij9e6Vs9AXkkqKSpH1z8wQCZAo+x1MNXgGLoU+coyLhc8DdM+/c52hsUCgOsSRnwJg/393Pdz+Kx0EbX7/RaXn1hFSj16Ssx9OdzUuGenAwYTzEJjLmWlbmwU1EQc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710924071; c=relaxed/simple;
	bh=OCzx/9PdT6fwvsNwdvNV7XC0LOYamTIIfmSyPBx/kzA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lD23JgTm1ROTTExULVyDdeUNZd/Wt8kgkAQCwrHnyYlxUpg1pBY3gaRxCh2t9Uy6Kp6CcYn7wSCz0WYf4nwTvAKqeVOQ1iD3hCL5nviCh9QPmcghaxYB10BpCp89wzW/+uviVa5lWbjCrZK9m6lXoZcALOi6co7SCSJdYamMh3E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=vkgGH/au; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=y9bMjMpS; arc=fail smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1710924069; x=1742460069;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=OCzx/9PdT6fwvsNwdvNV7XC0LOYamTIIfmSyPBx/kzA=;
  b=vkgGH/auxQPxdfHEjb6bLqEYqTLUgGvRVF4WMIz2NeofVH1jsla6vziH
   YIH1gQOY9h5Yr6VX8JLJUyUaiDjU+qK3D+GSqxrqlr1cO7avLsYoRdtgG
   BPu6xl3UvqXBX0obsA2apIxWzsNRsrLFbVqGRabD14Xy+zJBvcW1zUnj8
   EmKkdj+l9dA8Bd9bvwo0S8Sfoafz+33bpJ4w6gZzya1f/IXdWRZGhY6c2
   qjHeBigDQTZLORkRDeHBvGiu6U1CaJiB+rpwmkiQfzEuvDAEQDljV/XNJ
   lo2O4+tmD/2BVbpD8ZL4nGlyQoXBgGBH2Qzou6g66M2pO2BYhE4pWAAU/
   A==;
X-CSE-ConnectionGUID: F3rLw0mcQbuJ1Q59Cjbhng==
X-CSE-MsgGUID: ScrcggLrRouwRMqo+VOX6g==
X-IronPort-AV: E=Sophos;i="6.07,139,1708412400"; 
   d="scan'208";a="17893739"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Mar 2024 01:41:08 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 20 Mar 2024 01:40:52 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 20 Mar 2024 01:40:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OhuTRJMrimmLLJmuNZuNuV6oOWfihPEgvVlPA1G5pUW6nCJNibCUUX+PXAvDxs32r0pcAHJKFegRmA8oq/HLDgnhGMhZiO6q7iqu5FmkivvlVmK91sDg66dT3ov4rsG0RkBhZgm5ygyiXLxzwCa5BoCXg0dYj8dmXaskjagk/6GPIXpBure8fG1wPCeNIfFv1mgGBv6nTJyn5KpUClOHpNvW5z5UDLKhzTniTUjGTsMVox9Jc/1ET1oopqYxexn3/lfh8ByIxajJlkkd0FTkcUitodhJamYkBM3cQIz2en+8SskUcoCOSGakUtCAIpdRfVeCE3UdA6klXspCu7CHgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OCzx/9PdT6fwvsNwdvNV7XC0LOYamTIIfmSyPBx/kzA=;
 b=g5tKWFLTB1br8slvu3GVtPPdMLBV6le039PmvYEbXye6+XkggpHxW4ws4H0rvwqrTiNVVsyvRUWFCtAZqwZGk/5TfVoabsRO8z8Ui7277yI8O1YFOb1usAdTNCAOw9fWkF53lOVDWHcQz1SYp2qDaiEb0VC8ZrPXjcrun89L09RGhznZSxeoJaQT1Kt6UupAn6+sJx/bn7jcrX5MuNfrsls5qqaRCO3/tV9uAihFpHaYi7GJ5C4ypGjUUaOC6hCq3WxBkIFJ5hyF/vLGMGTcI4dSkBmR76Gp8rbf6hlxCPt/boWtBoY47or4OXP75GYYNOE5+2WnL3RAYfbSyq34EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OCzx/9PdT6fwvsNwdvNV7XC0LOYamTIIfmSyPBx/kzA=;
 b=y9bMjMpSkcuvTB92IWfMaXsRVjeib7uBJLMv8OGkKA1nxmzAK5XlQ4JSBsQpsO5FcgzVJko5ZV7sPMVwjXfddswMNzfmUrF4MQZR8r+cts/KHz8mC66g2ukYbQvInd0kY2z6eDq0NieE2bLhZQxxPmyqG8LKjVpho4rA5CXnhzxAUTXoiB+qLW1IFqHO9zOvdEVvh4CPUhjJEAnLRFP2aHP7KCWdCx8H7RAcaulsfCRZNBFWg3oNtHg7CSn9qq7sdmeyTVcvnWOJDfp4IxL8hR4Kk9BE1KGNTDQ9gYKfARUW7G/ORlQUEluSuPxMSSi4w1CmNWXw3Up7IDQ7DobBKg==
Received: from SA1PR11MB8278.namprd11.prod.outlook.com (2603:10b6:806:25b::19)
 by SN7PR11MB6948.namprd11.prod.outlook.com (2603:10b6:806:2ab::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.11; Wed, 20 Mar
 2024 08:40:50 +0000
Received: from SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::f633:b9d4:f539:177d]) by SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::f633:b9d4:f539:177d%6]) with mapi id 15.20.7386.015; Wed, 20 Mar 2024
 08:40:50 +0000
From: <Parthiban.Veerasooran@microchip.com>
To: <conor@kernel.org>
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
Subject: Re: [PATCH net-next v3 12/12] dt-bindings: net: add Microchip's
 LAN865X 10BASE-T1S MACPHY
Thread-Topic: [PATCH net-next v3 12/12] dt-bindings: net: add Microchip's
 LAN865X 10BASE-T1S MACPHY
Thread-Index: AQHab6Ox6ghenOTJpkWNbGLTwd03cbErBYYAgBVf3IA=
Date: Wed, 20 Mar 2024 08:40:50 +0000
Message-ID: <a172a0a3-42eb-4905-a22c-8078c0fd343a@microchip.com>
References: <20240306085017.21731-1-Parthiban.Veerasooran@microchip.com>
 <20240306085017.21731-13-Parthiban.Veerasooran@microchip.com>
 <20240306-spree-islamist-957acf0ee368@spud>
In-Reply-To: <20240306-spree-islamist-957acf0ee368@spud>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8278:EE_|SN7PR11MB6948:EE_
x-ms-office365-filtering-correlation-id: 05470e0d-f824-495a-ecc6-08dc48b97255
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zGHxGEdw81hFt39ISdaVmxU1Z56+eKKGj49gGtf+QGaPDTPxlVReDyzl2VhCdT6cJ2mea94g2OnFmOd3ezt1vqEWAVjs+umWvlDZKmMM+QCqh5vgE9m2tGCkJ3+5tEIYyWfXluLgsz7d6aBvXJaQyE0mwDmcbpiwVqH1+bHkgSfcs85bawLNFSI5gfmDvszvBBbImwmwQFOf+aw7mVv2geDPAnNEzage+ftSbFJer8/ooWFNmhLyqIwZs0h5teNnUTfQBVg6mG/Ng5bDgBaCunFxiK3UvNH03dbMz9HE+rKbSixgxXw5cSayr+6DyD53X8+isbCABHtjijV0cH6/NEi6NXxowl6kC27R+WFJW4B5D46m5rANpJhZWbCnOHyG4NQ9t04OD81K50Y2QE6/ja6cB8G4S7TdvaADIn5uMoQhVCSU74YF/Mowa/ehd1YWKwSR1BBnap+V85mK32YZ9EawBjlVyh8KzbE4x4+eBv9oaU0EY5n7uXQimT8a+fpKMBNtCpYM45j0BcyFVfg59qlTsatlhMWuob1KoUlpd5DcPYxkKNrJ7fV9+gq/aEizkmjyZzQBJSAMRsZayU9tBwDRpmaNo12bAVCH9VUNQ5okrxvHb/ZoMpta4Xf6XkkhhqqhxrellSHvLz/bttsLXyzBjdopS9cqUuaeKyBpotM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8278.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Myt0QjFJMGNiZldBbkg3RjV5RmxWWkZtTlNncStsdzFQTC9IZ2s3U2hOTjZ4?=
 =?utf-8?B?aXVtK3M4SFR3am9QRFF2TGJzN1V4UmJXZm41TFFpSFgxaHBjOGpBdWlnMUMy?=
 =?utf-8?B?VkZnaFpqVW1TMnc3anJYTUhsV3drUVhsbndhVEd1bzJ3K0JoRWJGVXB0VXk0?=
 =?utf-8?B?UFJJUGE5MEo2aEhmVkt1STNBcDQrQTJxMHJSVXo1R0hDcWszSEZ3eGJvakU5?=
 =?utf-8?B?b3o5SEMwS0l1MlVLelUwYk12dU5RcFZSSy8rRStZODNkRUJ6aGhCMWVuR0Iy?=
 =?utf-8?B?Skw2SnBNNjlJTE1GbzdNa1AzWGxjYS83SlVJTW9JWkZ3Z1liODA4M0wzU1FK?=
 =?utf-8?B?dlpZSk5xQ1JjZVdtTkV3Y1IxZ0xjZ2tscm84NVZHcVdVSUs5Q1RXQmYyTm9p?=
 =?utf-8?B?Z2lkcEV0YzVYZ0FQRDFQM1M3b1d3VmFsRVFoNEJFenF4dmE5RFFqQU1JSTA3?=
 =?utf-8?B?UU9PekVxL3lnMng0ZFlycVNQQS9FMzJha1MvWWlUUjNuZGR1S29MTCtYQzc2?=
 =?utf-8?B?c3pVQUQzNmZleXBGYWxtRVJVWDlDbzVmRzVDci9sK0ZzMmtzU0doOG1kY0ln?=
 =?utf-8?B?V1pXRkJVYUZ2Y2xxMDl2MndiallMWkQ1SWxwV0o4SkJtNXZkZUkvQlhKemcw?=
 =?utf-8?B?bjRMd2Q1cXdMY3ZhYkczd3RXYzFrSU9KVkQ5NzQ4Ly81dEdYV1lWbTFNQklR?=
 =?utf-8?B?WG5kT3g2Z0cyWksvd3FsalpNNUVSVCtvQ2MrMEVVSkVPdEJ5UGVwRSt0ek1B?=
 =?utf-8?B?RUZvR1R0N2xXS0lWcWVCa3FnS24wWFB2RkhUc1pEMFNzeVBwdjZkamJQWkJy?=
 =?utf-8?B?V3JQSUFHc1Q2RVBiNngwN3hodEJnZE1Ody9iSkxGR0piQklsY2NWbmJMRTVy?=
 =?utf-8?B?SWVxcDdSNFNYa3p4dnV5TC9aQUxhbC9pSk1IWjluTndWUmZWd3BwZUtvNXFj?=
 =?utf-8?B?WlZTV2RuYkVUTmdXNkRaTFowbDJHNzJRNy9nZ20rUUQ5TWlYWG1rWWk5VFRt?=
 =?utf-8?B?K0p4YTlkbjdxbWh5ZU5BL3lWRzRXQnYxN25sRkV3TnRGU1pYUGhwK2JrU1JZ?=
 =?utf-8?B?emc4dWtLR1QxNXowSTFjS29iSlRMNVdzcmM4UWNiR1lvL0huR1hqRVZKeVhD?=
 =?utf-8?B?aFN1Vjd1WGR6UW1TUzhrL0VUZ1Z5bU00a1JvYWwvN21lZEJjZVA3cnpnamlT?=
 =?utf-8?B?TEh2UU1na2MrMEZNWGhCa09yRWhSYVF1R3NwaHZOM2JSVG5rWk5WcVlJYStW?=
 =?utf-8?B?Z2VnRVZTQ2hJN2VoQi9ndXkvSDBka1RkbE1oTkw4VGt5SkwycDEwU05NNTdl?=
 =?utf-8?B?VmxGSkVBdWg5T0tab1gxeU82bkZhNm8zVXFXVTd4RGdhWEp4QTQwbEhqdzJz?=
 =?utf-8?B?Zlp3NkpNcjJza2VrOHpyWWVHTnA1dGZuZjU4eVgxdjh3QUVDU3dGK3hqTUZR?=
 =?utf-8?B?aTFzdGphR2h2VnNBK014NTNRQi9HVEsySFVZYkpOWElsWDNLejNOaHV2UmZp?=
 =?utf-8?B?Zmx0bGRmbk5vVmpac1J2TmJMZVAzckZoaThaQ2pMYTZweDE1MFhqeTRtS0ps?=
 =?utf-8?B?RjF5Rll4TEpEYVU5SlhHbFFrc1A1TTAwOGp1QUpZWE05ZVZJa1RYNW9RVlNp?=
 =?utf-8?B?UU9RcFNXTnpXWUNvemVZN2ZMcVMwdkp4QitQUDh5K05uVkx6bXlEbnI4ZmJh?=
 =?utf-8?B?eHlHR1cyQlRpdWNNa1NjT2Y2RnU5dHNWS2pFaS9mRnRFZTRHeHJoR0pxbTZ0?=
 =?utf-8?B?QWxVQ2YycUp0ejI5SEVTSG9uSnlwMWFSNzZ4QlpUQ3VrM1hxTjZlMGlNU2t4?=
 =?utf-8?B?WXBmQ0kxWHI0TGJkVmdtS1lvZHQ2bW9ianQ5WXk1eW1mb2pxSEdOcXE2cjRO?=
 =?utf-8?B?dGtCSFM5SW9LbGN6YXhnbVlucjlSUVE3eVdMUWhwVmo0dVlBMjRhelhnT05Y?=
 =?utf-8?B?WThSSWhQaE1VQjFHbzNTbzBJb0JlTHRCOHhsdGsrSU03RkxMWTlPalY2Qk50?=
 =?utf-8?B?eWJmeXNkUC82aFBFWEUvbFhRMldBYittVEVJMlVxMnpHeUx2bEt2TUNsQ0xZ?=
 =?utf-8?B?MWQvVGQxUHZORlJ4K2UyV3BnSitYSTZENDlrVkc2R1dvTXpUMENNdC8vb01o?=
 =?utf-8?B?bzhLVkxRT2l0alNaQmw0TWN4YnhKWXFyRE5TbHpVYjdrOGJocktCaXEyUDNk?=
 =?utf-8?Q?GQZQY/xWNPhp/OHClSspV2s=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5C3AE6C2D5D68E42B9F3C6D6F52A5B26@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05470e0d-f824-495a-ecc6-08dc48b97255
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2024 08:40:50.3889
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /IChAWpQBz13gN1I/SL+azrU3m10Nrx+DLIu9YO09YTl2h4TT58wQAWiZevfHSPjOE7yu7yQex0srfA3EuuS3ObycTGTfpsYgDIRuvw1UdZWbni4R5janDaa91g1lQZ7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6948

SGkgQ29ub3IsDQoNCk9uIDA2LzAzLzI0IDExOjQ2IHBtLCBDb25vciBEb29sZXkgd3JvdGU6DQo+
IE9uIFdlZCwgTWFyIDA2LCAyMDI0IGF0IDAyOjIwOjE3UE0gKzA1MzAsIFBhcnRoaWJhbiBWZWVy
YXNvb3JhbiB3cm90ZToNCj4+IFRoZSBMQU44NjUwLzEgY29tYmluZXMgYSBNZWRpYSBBY2Nlc3Mg
Q29udHJvbGxlciAoTUFDKSBhbmQgYW4gRXRoZXJuZXQNCj4+IFBIWSB0byBlbmFibGUgMTBCQVNF
LVQxUyBuZXR3b3Jrcy4gVGhlIEV0aGVybmV0IE1lZGlhIEFjY2VzcyBDb250cm9sbGVyDQo+PiAo
TUFDKSBtb2R1bGUgaW1wbGVtZW50cyBhIDEwIE1icHMgaGFsZiBkdXBsZXggRXRoZXJuZXQgTUFD
LCBjb21wYXRpYmxlDQo+PiB3aXRoIHRoZSBJRUVFIDgwMi4zIHN0YW5kYXJkIGFuZCBhIDEwQkFT
RS1UMVMgcGh5c2ljYWwgbGF5ZXIgdHJhbnNjZWl2ZXINCj4+IGludGVncmF0ZWQgaW50byB0aGUg
TEFOODY1MC8xLiBUaGUgY29tbXVuaWNhdGlvbiBiZXR3ZWVuIHRoZSBIb3N0IGFuZCB0aGUNCj4+
IE1BQy1QSFkgaXMgc3BlY2lmaWVkIGluIHRoZSBPUEVOIEFsbGlhbmNlIDEwQkFTRS1UMXggTUFD
UEhZIFNlcmlhbA0KPj4gSW50ZXJmYWNlIChUQzYpLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IFBh
cnRoaWJhbiBWZWVyYXNvb3JhbjxQYXJ0aGliYW4uVmVlcmFzb29yYW5AbWljcm9jaGlwLmNvbT4N
Cj4+IC0tLQ0KPj4gICAuLi4vYmluZGluZ3MvbmV0L21pY3JvY2hpcCxsYW44NjV4LnlhbWwgICAg
ICAgfCA4MCArKysrKysrKysrKysrKysrKysrDQo+PiAgIE1BSU5UQUlORVJTICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICB8ICAxICsNCj4+ICAgMiBmaWxlcyBjaGFuZ2VkLCA4MSBp
bnNlcnRpb25zKCspDQo+PiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3MvbmV0L21pY3JvY2hpcCxsYW44NjV4LnlhbWwNCj4+DQo+PiBkaWZmIC0t
Z2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL25ldC9taWNyb2NoaXAsbGFu
ODY1eC55YW1sIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL25ldC9taWNyb2No
aXAsbGFuODY1eC55YW1sDQo+PiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPj4gaW5kZXggMDAwMDAw
MDAwMDAwLi5lZTUyZjlkOGU5M2MNCj4+IC0tLSAvZGV2L251bGwNCj4+ICsrKyBiL0RvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9uZXQvbWljcm9jaGlwLGxhbjg2NXgueWFtbA0KPj4g
QEAgLTAsMCArMSw4MCBAQA0KPj4gKyMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IChHUEwtMi4w
LW9ubHkgT1IgQlNELTItQ2xhdXNlKQ0KPj4gKyVZQU1MIDEuMg0KPj4gKy0tLQ0KPj4gKyRpZDpo
dHRwOi8vZGV2aWNldHJlZS5vcmcvc2NoZW1hcy9uZXQvbWljcm9jaGlwLGxhbjg2NXgueWFtbCMN
Cj4+ICskc2NoZW1hOmh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9tZXRhLXNjaGVtYXMvY29yZS55YW1s
Iw0KPj4gKw0KPj4gK3RpdGxlOiBNaWNyb2NoaXAgTEFOODY1MC8xIDEwQkFTRS1UMVMgTUFDUEhZ
IEV0aGVybmV0IENvbnRyb2xsZXJzDQo+PiArDQo+PiArbWFpbnRhaW5lcnM6DQo+PiArICAtIFBh
cnRoaWJhbiBWZWVyYXNvb3JhbjxwYXJ0aGliYW4udmVlcmFzb29yYW5AbWljcm9jaGlwLmNvbT4N
Cj4+ICsNCj4+ICtkZXNjcmlwdGlvbjoNCj4+ICsgIFRoZSBMQU44NjUwLzEgY29tYmluZXMgYSBN
ZWRpYSBBY2Nlc3MgQ29udHJvbGxlciAoTUFDKSBhbmQgYW4gRXRoZXJuZXQNCj4+ICsgIFBIWSB0
byBlbmFibGUgMTBCQVNF4oCRVDFTIG5ldHdvcmtzLiBUaGUgRXRoZXJuZXQgTWVkaWEgQWNjZXNz
IENvbnRyb2xsZXINCj4+ICsgIChNQUMpIG1vZHVsZSBpbXBsZW1lbnRzIGEgMTAgTWJwcyBoYWxm
IGR1cGxleCBFdGhlcm5ldCBNQUMsIGNvbXBhdGlibGUNCj4+ICsgIHdpdGggdGhlIElFRUUgODAy
LjMgc3RhbmRhcmQgYW5kIGEgMTBCQVNFLVQxUyBwaHlzaWNhbCBsYXllciB0cmFuc2NlaXZlcg0K
Pj4gKyAgaW50ZWdyYXRlZCBpbnRvIHRoZSBMQU44NjUwLzEuIFRoZSBjb21tdW5pY2F0aW9uIGJl
dHdlZW4gdGhlIEhvc3QgYW5kDQo+PiArICB0aGUgTUFDLVBIWSBpcyBzcGVjaWZpZWQgaW4gdGhl
IE9QRU4gQWxsaWFuY2UgMTBCQVNFLVQxeCBNQUNQSFkgU2VyaWFsDQo+PiArICBJbnRlcmZhY2Ug
KFRDNikuDQo+PiArDQo+PiArYWxsT2Y6DQo+PiArICAtICRyZWY6IGV0aGVybmV0LWNvbnRyb2xs
ZXIueWFtbCMNCj4+ICsNCj4+ICtwcm9wZXJ0aWVzOg0KPj4gKyAgY29tcGF0aWJsZToNCj4+ICsg
ICAgb25lT2Y6DQo+PiArICAgICAgLSBpdGVtczoNCj4+ICsgICAgICAgICAgLSBjb25zdDogbWlj
cm9jaGlwLGxhbjg2NTANCj4+ICsgICAgICAgICAgLSBjb25zdDogbWljcm9jaGlwLGxhbjg2NTEN
Cj4gVGhlIG9yZGVyIGhlcmUgaXMgd3JvbmcsIGxhbjg1NjEgbmVlZHMgdG8gY29tZSBiZWZvcmUg
dGhlIGZhbGxiYWNrIG9mDQo+IGxhbjg2NTAuDQpSZXBseSB0byB0aGlzIGNvbW1lbnQgaXMgaW4g
YW5vdGhlciBlbWFpbC4NCj4gDQo+PiArICAgICAgLSBlbnVtOg0KPj4gKyAgICAgICAgICAtIG1p
Y3JvY2hpcCxsYW44NjUwDQo+PiArDQo+PiArICByZWc6DQo+PiArICAgIG1heEl0ZW1zOiAxDQo+
PiArDQo+PiArICBpbnRlcnJ1cHRzOg0KPj4gKyAgICBkZXNjcmlwdGlvbjoNCj4+ICsgICAgICBJ
bnRlcnJ1cHQgZnJvbSBNQUMtUEhZIGFzc2VydGVkIGluIHRoZSBldmVudCBvZiBSZWNlaXZlIENo
dW5rcw0KPj4gKyAgICAgIEF2YWlsYWJsZSwgVHJhbnNtaXQgQ2h1bmsgQ3JlZGl0cyBBdmFpbGFi
bGUgYW5kIEV4dGVuZGVkIFN0YXR1cw0KPj4gKyAgICAgIEV2ZW50Lg0KPj4gKyAgICBtYXhJdGVt
czogMQ0KPj4gKw0KPj4gKyAgc3BpLW1heC1mcmVxdWVuY3k6DQo+PiArICAgIG1pbmltdW06IDE1
MDAwMDAwDQo+PiArICAgIG1heGltdW06IDI1MDAwMDAwDQo+IFlvdSdyZSBtaXNzaW5nIGEgcmVm
ZXJlbmNlIHRvIHNwaS1wZXJpcGhlcmFsLXByb3BzIHdoZXJlIHRoaXMgcHJvcGVydHkNCj4gaXMg
ZGVmaW5lZC4NCk9LLCBJIHdpbGwgYWRkIHRoZSBiZWxvdyBsaW5lIGluIHRoZSBhYm92ZSAiYWxs
T2YiIHNlY3Rpb24uDQoNCi0gJHJlZjogL3NjaGVtYXMvc3BpL3NwaS1wZXJpcGhlcmFsLXByb3Bz
LnlhbWwjDQoNCkJlc3QgcmVnYXJkcywNClBhcnRoaWJhbiBWDQo+IA0KPiBUaGFua3MsDQo+IENv
bm9yLg0KDQo=

