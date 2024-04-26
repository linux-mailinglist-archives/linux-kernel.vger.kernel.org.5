Return-Path: <linux-kernel+bounces-159540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2872D8B2FF8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 07:57:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7F661F22770
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 05:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0FDF13A879;
	Fri, 26 Apr 2024 05:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="gSpF2x34";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="rJR7LoFw"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F05713A3F7;
	Fri, 26 Apr 2024 05:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.154.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714111010; cv=fail; b=kPDN8bDilXaFdPA2CnGb2MCnB3qEgyQBkjud1Bq6SqGkwMsdIG0qJSORmbDjIKQWYpwr7ig+gj4ho2UTbTuqWVyx4e4tJtmCpY4jn/z73DAUmyCC6bOI4GSNvbbvyJ53wpSHUb6PsKgRomUXQdSptkLQELpROo8qNkOgcmRwdf4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714111010; c=relaxed/simple;
	bh=dJwwUkmwEeMD+90XM9Ilwzu4LcxWnE7FM+u3BEPsei8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Z5n0YLXQTCoWX1WHPju3/W5pRDxEakhmb9APqfvR5Llk4vBzvI5nbnMtELmmgECp9fwn6pFRv5ISepMW9lHGLe7UGvxHJLuFaej1OKpv7Sl8kD1dM9AW3nvNi5e8u1oXbO5WS9SmYej43v5DQgC4z6G5BHjEjCedOvyuWA0Tp3c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=gSpF2x34; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=rJR7LoFw; arc=fail smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1714111008; x=1745647008;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=dJwwUkmwEeMD+90XM9Ilwzu4LcxWnE7FM+u3BEPsei8=;
  b=gSpF2x34bhDM6teM+nFDTTY5bsGkKtXWTM2ZhGr+cL4zs1Ec2OxrAI9q
   zNE5N0Sy7MvalvIeZycCacv7RgqZ4RQTFD+2u5J5Vj3SFzE+CgK/AnI0g
   270xqhrrT9yo+ZkJ+ufy4NBK/qb2E7FtwZ6wwGLyPyai6KGCRE/WxIklm
   zsdDRiYduWKbR9zPnQ1cIPkzfpYcQdqu07tDy9vk2J7m5dPXKoIzK22Xu
   L2RnjbCuQIK3DWg20MSF97pDCKNCtILi9Kno/BmHs75Si+ZXPXFe2ibfD
   v45/1SHGmpupenjQNJ86AMQvlXu5QaPuIFAyl/J2ZxT2tQ/I8swOrWiRb
   w==;
X-CSE-ConnectionGUID: qr/DPryoQLS1Ela7PN7/WQ==
X-CSE-MsgGUID: WuvC32h3SkWx1pPJhoDKKw==
X-IronPort-AV: E=Sophos;i="6.07,231,1708412400"; 
   d="scan'208";a="23323866"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Apr 2024 22:56:46 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 25 Apr 2024 22:56:36 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 25 Apr 2024 22:56:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M4Ue+tBlKbWIZXVD3MMVb16e339ERiji6uzFhu4xQxFOnpEKZh1cLC76siCEO0Kvvr5/L3N8yKUG/lQYnTnQ37qge5hNGmF47tQ9V6xMAip3uWJKd2Nn754bBAKv7DIuPfW20JAlG7axTwlQ5Ryee453qBmf3eBFqSv9DqfEfAFWOBNof7EcqLz/if18OScS+7LLzJDi1wPzOWyj97tyUUnpff2PuvotNs+W+a5dIEIyGjAEdhGZdUOijxYbk4wWgP3JomX/AFMvqbcPtzrKgi8OI8iuSJLnOc6zkBWlUg/SSQnmu89nL7FjbKfFIRMbKF8ojwy6hcKaLcrt8WC2Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dJwwUkmwEeMD+90XM9Ilwzu4LcxWnE7FM+u3BEPsei8=;
 b=F8OZlz6/eUmvLW9i0guE0+fGIEiPQRzjaCGQrKMerMJFeB5OXfzWMCQCCbZoli9HFP5hZ4lAWCTVW95ieV0NnnTE/7HjsaYIG7kfpS2HRbc/DSgjhcUwNqLPii7Me1xctPuN8PFpcpAkv5v0WtfpoJvI/w18CdtksmrDQLWtR3Sctw5du2S/sr5XNKDA0ZBIvidLw7f/FrIerrUZcopiKTF/LRdaZKbpZc3+skukjea08GuZvGfo+du9YArP7d9XScTALeK2YaDZnQixjF3jlmslpwvu+G6FMJwKOnU/L3rLIdqDf01o2AW3Ftzi1zE3ADRYxTddeDbDEYWZwC35VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dJwwUkmwEeMD+90XM9Ilwzu4LcxWnE7FM+u3BEPsei8=;
 b=rJR7LoFwZ/iBkG4Q3bIy8v1jB202prT3mHIrfz2PCxsCn59lErncM4O0yHQeT5WuRBJiRIttMJet1gXAPMOfL+AUuzu6JYlS/xNwATzLm1p9drHhwPnR05YDzad3t6jZX3JLZxcEDidv8LVOH+tHFRBvQPD2fFQzqvfhhngHvNI3Y2C6hnUasQQS2AkkY1UvlMyMXAOFPD21d73xdmnjV8gmfDcGb0DwgznvX++snDMSqjBjbW4+tA6OAdIv+faPL7AwUqu5ymOQ0LUvJUCSceB96F06OA99/GiM4imR27IBvpfYwDe9RY2/A93CYBd6adG8yQR9zcNCNoKEfoKJ6A==
Received: from SA1PR11MB8278.namprd11.prod.outlook.com (2603:10b6:806:25b::19)
 by MW3PR11MB4748.namprd11.prod.outlook.com (2603:10b6:303:2e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.24; Fri, 26 Apr
 2024 05:56:34 +0000
Received: from SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9]) by SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9%4]) with mapi id 15.20.7519.021; Fri, 26 Apr 2024
 05:56:34 +0000
From: <Parthiban.Veerasooran@microchip.com>
To: <andrew@lunn.ch>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <saeedm@nvidia.com>,
	<anthony.l.nguyen@intel.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <corbet@lwn.net>,
	<linux-doc@vger.kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<devicetree@vger.kernel.org>, <Horatiu.Vultur@microchip.com>,
	<ruanjinjie@huawei.com>, <Steen.Hegelund@microchip.com>,
	<vladimir.oltean@nxp.com>, <UNGLinuxDriver@microchip.com>,
	<Thorsten.Kummermehr@microchip.com>, <Pier.Beruto@onsemi.com>,
	<Selvamani.Rajagopal@onsemi.com>, <Nicolas.Ferre@microchip.com>,
	<benjamin.bigler@bernformulastudent.ch>
Subject: Re: [PATCH net-next v4 03/12] net: ethernet: oa_tc6: implement
 register read operation
Thread-Topic: [PATCH net-next v4 03/12] net: ethernet: oa_tc6: implement
 register read operation
Thread-Index: AQHakZAE+xRxNJnAkkOjdoPSHid7LLF2hZQAgAOUYYA=
Date: Fri, 26 Apr 2024 05:56:34 +0000
Message-ID: <8be4f5b1-01b8-41ec-b29d-a5bcbcfe7d80@microchip.com>
References: <20240418125648.372526-1-Parthiban.Veerasooran@microchip.com>
 <20240418125648.372526-4-Parthiban.Veerasooran@microchip.com>
 <cfe4a1f4-df6e-4ac7-bd2d-1f8429af29e2@lunn.ch>
In-Reply-To: <cfe4a1f4-df6e-4ac7-bd2d-1f8429af29e2@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8278:EE_|MW3PR11MB4748:EE_
x-ms-office365-filtering-correlation-id: b3f85c49-071d-47c6-51a7-08dc65b5a13a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|7416005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?MW1lSVZvTnRGUTJQUjMvTjJSbzFyQUM5dXF0R3REb2dabWUzMGNYUlNUTnJK?=
 =?utf-8?B?NjFzTzZ4Q2xmY0RENjFzZE5aM0RBbk5BM2FDUmdwWUYxekNsc3ZTam4xNHh0?=
 =?utf-8?B?SHp1WGNOWk1PbjZ5UVVGb3Z5aFdzUUt4RnZpYVkwY0lRVGpsSVlOd3hWa0t2?=
 =?utf-8?B?cXJFTnh3cHUrRm1lclRMOXlnYkloNWNVRWplUzdsL012RnFIOExYd1grU1NW?=
 =?utf-8?B?Tkt5dlVSUk9vMFFQNHFoOWxjUW5lYXordXNBMjNxKzZWTmUyTlYrODZ2L1cr?=
 =?utf-8?B?VGtXbUNHVTJFM05pTmJNVGg5TnEwY3hxRXNFa0VkSFJDckY1enRDTG4wWGtC?=
 =?utf-8?B?M05iQVV4WnlxbWFYUHgwME9kdkwrMVpFTm91Uy9oWFE0UWdkcGdpNHZ2enc5?=
 =?utf-8?B?K0prdTRwNysxQjV5SkI2cWVWei9pamJtMHVySFZKQm4xUGsrbE5XWlF1Y1Jr?=
 =?utf-8?B?b2xBeW83OWdZQkdiUkZOOVVlcFU1YjlWVjVtWXRPNlpVdjNzdGpmV0V1ekxt?=
 =?utf-8?B?ZlNENEkvT3ZrZXhTVVFDY0xJZXEzb0d0c1NFT3ROSSsvZmxLZVRTaXczdlZl?=
 =?utf-8?B?dGdsR3dyY3dZTFpPaGtaVVFwVU85ZGRpdGhxM291ZjJRVmpwTFladW90OUxS?=
 =?utf-8?B?cXVibjJOblNWWWNJMDVIR2tHdWxaY2VNMjVBbUxGZFdGN2JKY1NDT1RGcFJQ?=
 =?utf-8?B?bllLdEpKVEd1Qk5IK1YrZG5LMnVJU1FVd2NTYWhlN2c3bW5NdVVrN1VzcGJz?=
 =?utf-8?B?Q1VOUSt6aWtTRCs4QUluWVNuTkw4d2xzS0JBeUtITHU0MUdQWUZXZXJNbmk2?=
 =?utf-8?B?SEtYMXZ0S3dvZnlhdzZ5Sk1RWGMvNzhCZ3lqS3hkVkdhbDAvcENzSHQwWjh4?=
 =?utf-8?B?bEdha3E0cDhRVGl4aUdvalZKbkNDOERnWjJuUUw0VHFXa0JDT093ZmI3TWZT?=
 =?utf-8?B?SW94UFBudjZCdndVRk1FM3lsMXczN0Nrc1Z3VGNtNEVZdmJBc0tabTFaRUNX?=
 =?utf-8?B?QVhnSW9SWWl3b2FjR3pRQSs1LzdHNmJ1Mlozd1FTcWtITFZVUE53QnIveEJk?=
 =?utf-8?B?Nkl0NFgzS0w4THBYajJxUGcvclN1eStXcVNlR0diTUJxZFp2NG1ZekhiNXBK?=
 =?utf-8?B?SUpGaEV3Vm55THlCcXRLU3NISXBJQStZUExCNzg1ZXFnZ1A3RkxHOW5salhh?=
 =?utf-8?B?aTZhM2UvbjFVUmpQYmFCclM4Yms4dlE2UW9DRDAyTGwreHhacmV0MktvaTVT?=
 =?utf-8?B?cjVROHRNOVVUUjZZZmRrU2tQd3E2YVhYaURFWFpmcGw3R3ZLZU1WcERTaDhQ?=
 =?utf-8?B?Z1NHRlBTdHBUVlhNek9mMGtRV01jS2pSRUhBWjZkeXBKYmJVL010UnJKNS9h?=
 =?utf-8?B?SlBmSXdyUG9WNkkzdDlwSzdvOWRaQ0FZQklZWk5uOU90YjhRbmgwR2xXU1Jk?=
 =?utf-8?B?TGE1Ui8vVUIwak8wVHhoSTFSeWZDdkxXV3BHTVhBOHN0MGRKYVRlOU9QSG1T?=
 =?utf-8?B?Q2ZTeExiUjFBU2RDTHdob2xaZGRWbnNWQ2o3ZGpCbnEvSHgzVDlHMUYzZ3l6?=
 =?utf-8?B?N1phRmF0dWtqUW5lR1l6QkorVTlOUWR6SVhyWXlYUFNKNjZaOWdtWjZSTnNV?=
 =?utf-8?B?RkVPd0ZOOXhhUDYwd05heXAvZzJFbHQ0TjRESUtIYkRXL3k0SThmbDJQQmlX?=
 =?utf-8?B?NUJUNjU5MmcremIyeUlKNVhtSzArTGFHaXIwd3dyQ2R5OCtMNy95dmdqTkpR?=
 =?utf-8?B?R2F3bjNPSGhqUGcwVTZWYVdrUUt4OTd5VHBOYnhoYnVCc1hSK2IxcnZiVnBk?=
 =?utf-8?B?bGMwV2RjVk96Vmdub0t4Zz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8278.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZkllUDNNSWdEeDJwcVB6cFRnTm1TazNGOUxscldLMkRrem1tTGErcXdzek1C?=
 =?utf-8?B?Z2VDQ2RzbFRaaWphMVd3Y3Q1S2xPYjY1Q1M2ZDlMQzBBbjRRZ2dXcjhKdmZy?=
 =?utf-8?B?MG1vc29HVzV4dy9IS1ZRQWdaS3lEMVplSTBnSFJoZ1lDcmpGSFh5R1ZwUXFs?=
 =?utf-8?B?VWk3SThudUJDQ040dFVRTTBHZHJRZUp5MFZlTTFYSERYUEMrbGRJb3ZjQ1hR?=
 =?utf-8?B?UVBCY0c5VGFSTG5oeWJ3VkloQWYranorTmVZVXZGZGU4Tmk0VFdrUmFvVDRk?=
 =?utf-8?B?d21mcGo4RnZ5MHJONytVelE4YnRXUjB0V0FDdVppbmlwMWRTN2k4bzlKRnRD?=
 =?utf-8?B?RW16b09WbWo1eExTN0xyaUVJQlBDRjFqS0wxUXdxZlI1RnhvTXBBN2UrRU5i?=
 =?utf-8?B?Qnl3Nkx5eXgxWmU3azdIaGl0RENmS2ZIeWtJSURMNXFyUTJKS1JFdzdiVnl5?=
 =?utf-8?B?cnZQTlpYVHkvb25VU1REZHNkVnBOYlhJS3FEQlJaZm9LeWY1Q2RBemNJWHBa?=
 =?utf-8?B?QkczMFhkMHExYm1tNXpCT3JZaTBXR1ZJUDlJU0tlTC91TmthdzdxUjZneUEz?=
 =?utf-8?B?aUhzaThYdG5DR1FmMjdNeFZnMUFSV3hnTjdJa3kzVVRnSlpSTC9nOTNQVVM2?=
 =?utf-8?B?cjNyT2kvWTZsN1NEQ05GbG04ZThHSkQ1c015SnM1d1pua2pLT2FLa2FkWGZw?=
 =?utf-8?B?Ukh0b2lxMFlPcUFzb0docEZKaTFtOUlncXlyRDNBaWsvZ3RhbGEzZG9SSjky?=
 =?utf-8?B?YmR1VjVTSHE5MnZJaFF0UmFQcktTdVk1eXFWOGMwWkpKSzluYmpXUHUwVENZ?=
 =?utf-8?B?a0VDNkdXQnp5akRoUFhyTnduS29uNDlSVkdmQTV5WklXUE1iQ0I3cXh4VktM?=
 =?utf-8?B?aXJSK3hubGUwc01ySG1aY0JwZ2RQTng2ZUdtYm1hdlRGeklQWDVxeUpDMWk1?=
 =?utf-8?B?NzdnRHlSaHMzYjVzYXBiQVQxRElMR1ErRyt2aG9hSlVraTJYRFJtYXhYdFJt?=
 =?utf-8?B?d3V4WWtmeUtFcDJMb3JWZ3V1b3Z5YmtJUmJSdWFKZ2t3Z1czbkwxYmlJSmZ3?=
 =?utf-8?B?VFRncGhjY2I1dnBnOTZTWkRURUdSUjlVRzMyYjRBeEZBZnQ3ZTVhWVNuZmFh?=
 =?utf-8?B?Q2Z3ajhLeVFkTWFKSDRObG55TlJTZUZYR0VyU2kyNUlRM1l2WnVOaUhqVSt2?=
 =?utf-8?B?T1hZVExZTkozQ2tTd2VvMVFzSDlBV3hXNHl4QVl0K0lLY2d0ZXFDd0NaSGpV?=
 =?utf-8?B?aWdON0N2RnZlbDM4M1pRSVNWYnM5SVRlcGNZOHY4OTZhb1orc1Iwc28vRExR?=
 =?utf-8?B?YzEyMXV5ckRNbTNKWmswRnB2ait1QlU4LzdDT0d3V1BjbHdrYVFUOWs5U0tr?=
 =?utf-8?B?VlNNVkF2TWUyU0pMT2Y1R0hQdmJrMWZuRVp1ZVU3ODkxZUd0TkFacjVjbE8w?=
 =?utf-8?B?cmpwWmxvc0ZuRmRzS0FzVmlhaDQyUFpPcnAyVmhCSzZEL0dWRXplOWw1alNU?=
 =?utf-8?B?dWJodVllYytwbEQzNDVFZC9xL0gvb041cnhmR3ZqV3djNW9wcFFCMHV3VnQz?=
 =?utf-8?B?bkxQZFhjaXFrelI0anJkaURsaUo2SlBKSFBJdVRiNXZsWjZ2MVZLNWpLME5G?=
 =?utf-8?B?MEdMaGhGR1E2Vm1oa1hRczVIb1JRS0lRbHBDTW1hYzg4RUV2Z0svN1c4VzJQ?=
 =?utf-8?B?d01DMGhBMitRT2QwaWw4ZnJhVmJ6bzVuN3ZPSlNxSHhQQkJ6UmZYVjgzb2VC?=
 =?utf-8?B?eFRFcU5wZHVpV1JUSjduK2xGMEJZUnUyZlhaWkUxRzc0MG1LM2J3NVJkdkdo?=
 =?utf-8?B?RitVdGRuQWxHNXo4OGdMSzdFYjNNOE9ua1NJYVFpYWcrWDNuZlE0a3daU3lw?=
 =?utf-8?B?UFhSTjErbjBlZlQ1Zzc2ZUtYUXo4c2txWVZrTGZENmVwQk83anlqNHQ2Mm9F?=
 =?utf-8?B?QlpQU3Q2a1NVcDVZc3VGWDNvVWhVdElUZGViK0I3eUF6bllZUlJva2ZCTXpy?=
 =?utf-8?B?Z241eWV6aEo0dWxlbWYreC8wN3o5Ti91WFlEMElDTkxoYjB3Y2dENzRsanNZ?=
 =?utf-8?B?QkRBTGZrYkVaSWUrM0kwVjU3ODdHUmxmTy9ZNEF5eWJ6WnpjcTlMU0l6cGt1?=
 =?utf-8?B?RE5Id0lZaW9FZklsZ0NPV0VNTlBMOVJFbHJqNCtvUkJVcWdWZkk3S3hvMCt1?=
 =?utf-8?B?RUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1F17B992A84A63429B092D3C32164B4F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3f85c49-071d-47c6-51a7-08dc65b5a13a
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2024 05:56:34.7841
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xFtC30hNGNBBLirsWed6SiHBPjvLbvaOWQ3EmICY4BJZljPdX+CALvjKnDUHeyDci4PBYHdQPf1qHEeuHQKp9lJ4ESwlrDJhRI4T3+O/T4ZIOhEzpPno+Sh8Z4tGb03M
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4748

SGkgQW5kcmV3LA0KDQpPbiAyNC8wNC8yNCA0OjQ3IGFtLCBBbmRyZXcgTHVubiB3cm90ZToNCj4g
RVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVu
bGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPj4gK3N0YXRpYyBpbnQgb2Ff
dGM2X2NoZWNrX2N0cmxfcmVhZF9yZXBseShzdHJ1Y3Qgb2FfdGM2ICp0YzYsIHU4IHNpemUpDQo+
PiArew0KPj4gKyAgICAgdTMyICp0eF9idWYgPSB0YzYtPnNwaV9jdHJsX3R4X2J1ZjsNCj4+ICsg
ICAgIHUzMiAqcnhfYnVmID0gdGM2LT5zcGlfY3RybF9yeF9idWYgKyBPQV9UQzZfQ1RSTF9JR05P
UkVEX1NJWkU7DQo+IA0KPiBSZXZlcnNlIGNocmlzdG1hcyB0cmVlLiBUaG9zZSB0d28gbmVlZCBz
d2FwcGluZyBhcm91bmQuDQpBaCBvaywgc29tZWhvdyBJIG1pc3NlZCBpdC4gV2lsbCBjb3JyZWN0
IGl0IGluIHRoZSBuZXh0IHZlcnNpb24uDQoNCkJlc3QgcmVnYXJkcywNClBhcnRoaWJhbiBWDQo+
IA0KPiAgICAgICAgICBBbmRyZXcNCj4gDQoNCg==

