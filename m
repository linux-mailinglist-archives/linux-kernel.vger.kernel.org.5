Return-Path: <linux-kernel+bounces-84826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3512286AC12
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 11:20:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A20751F24462
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 10:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F90D4CE17;
	Wed, 28 Feb 2024 10:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="0ZVoIYnT";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="y3XL/7f5"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726CF53E08;
	Wed, 28 Feb 2024 10:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.154.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709115561; cv=fail; b=Q5SsodkSfpE0VaBY+p1XVBrNGMcVUN+MIBSOipXpiBZZXvNJ3N8G/AS7B3E9b1lb6GkvvPqMcXsOAoRp7/i0m3cXSAEKkQy/1coiy92+a7egNMUBNMVT5f1gl5vnp762rzu6V/c66zv476L89WdXVVz29uqbCe4PVh8T48yTPqc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709115561; c=relaxed/simple;
	bh=7pXjV73gigWeHEUK0YSdDVe6eSvQ6HDSaOKXFrOYWf0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SN7+s5v8uR0WTzSUEXDINqs973MamAbz41ggLATAaZVUhqid2wTHviMc9tH1JsGAQ54GIO2HYOuwLsqpzSkF8D6/vCKGmmFhomcjuUQtD9GBHrXQE1yOdiiJMQKzrdAXlzhkZ5pE629sJHZy488hn19OxohNn1UQ4m1MSjyGFXM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=0ZVoIYnT; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=y3XL/7f5; arc=fail smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1709115559; x=1740651559;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=7pXjV73gigWeHEUK0YSdDVe6eSvQ6HDSaOKXFrOYWf0=;
  b=0ZVoIYnT+PN3B1m7I1GuOqJzKdKUhFQ1D+5wC2A7OXKQSngjmW4uadtS
   TgapHObyF7+y8imHo+W7f92LjRWNyhw6p+ZYnqjEa87Ib5Drhs3e0HBJi
   w7DzhBHUDASFN2Sh1kgcwEINHC3OscYCyHxTG7FgRvHfI1d4t7lYsy3Jo
   N+GgKxPWBeBEi52Kb0RhprXgxasEf0Pa3054b1AIfsPvkluKc/YyXkVVh
   K8ERdt9TNDuVVpcjHz8Hepjo/K9JPGjJ4kZlj6AMKBqCk4Db5KYChaS2s
   Hd+lEShX0HqBKk1emZ39j5P0yKHJ2eBY+U3K1eHHmT112HCDgaeIzF24q
   g==;
X-CSE-ConnectionGUID: g3ofMs/dR4iKvUno8KrAOw==
X-CSE-MsgGUID: v4YGXHTpTnOiBvzdlEp+/Q==
X-IronPort-AV: E=Sophos;i="6.06,190,1705388400"; 
   d="scan'208";a="184215915"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Feb 2024 03:19:13 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 28 Feb 2024 03:18:52 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 28 Feb 2024 03:18:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AdYdsDhbNjKa9eYqFAUOdtOSVMq3AfweQ0gdRLikxAYQe+FcrUfg+16zQ3m/qdQIOAto9d18lHFji1RFdptPRi4LazTV7CPR8eDuDaik1PYTUUztNYt+gXv2viQ6pTx2tSNL33FmJ7Tl48yXsZMY7WtLK+ggVxvsQ1MOTik/JEutct+T6q7L59pgocipIqH8y11dHB8Z6cJVAFq0z2Cxaeb9lGj85Y63p2no2kg1u2j2ViFAmSH6YmoYocYeacVF6M0RrT49v3Ed7I1uezVyR54nzvAYaMMI0cK9WZPA/c0+fW0b0EkkxjnuyQnjA+Nx2fYmijiJVcSzcI808SRuNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7pXjV73gigWeHEUK0YSdDVe6eSvQ6HDSaOKXFrOYWf0=;
 b=Hg7Ih7O+zE7v9Ve030emrGYmX65r+hYROMBSnL9rUxfVs9pI4ihlmG8haeWnBq66Iz/WxUDtSIbYU9WmeFfvzueOtT3jSVl5LJVBrpODUnWd1rrGlX/toYUMa6+rohOOqqPrhOtZIhA6/SV7/6Ev+FJ3VEns/R4Augb6lw7QUcFME1QpD0rVTV6PhHpyWACbmKcXzr9so45f51ThsFmYMVZkbrFm8DxMvcG2D8ivn3ivAIH3pJE2AGy+8zVdKixIxC1Z8+dndN+ewmwNB3lGXhXDKOlNLU4E6oeZgjygRwy/nNu1w4Lf0yBrodX0+X15iK+7pEWR/dVSyWumt4V0vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7pXjV73gigWeHEUK0YSdDVe6eSvQ6HDSaOKXFrOYWf0=;
 b=y3XL/7f56jGbIZUIYibNbpheWb2e3VFpCrxfBOYmSHgG1F362Us1vlMh54/u/SqZKANyGJTf/IUjGbAW0ng+jcY7yRquhgJt0xW9tmY7Q0jcyfP6jHejyDjbeoZMNWIXQJzG0kJ/3ZcNH4LmxsWVSgeb0+CE6fqncO40TZzIVN0owHcqMUkkCqxh25oXX9YKDRO8IWtriXHCX97oAiDBmH38xBdHsReHam7kkq0ZBQ2qAnSiuvfPcBamKhd/LrbkPv0zZYj6qL/FSWCSw0o8z/qY1uVUodLIAYLmo0pbXbWxcfmr8R0/G/rrJJ2ABfswrvqQCwNE6MYkkHDn03Z3ng==
Received: from PH7PR11MB6451.namprd11.prod.outlook.com (2603:10b6:510:1f4::16)
 by DS0PR11MB6493.namprd11.prod.outlook.com (2603:10b6:8:c3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Wed, 28 Feb
 2024 10:18:48 +0000
Received: from PH7PR11MB6451.namprd11.prod.outlook.com
 ([fe80::c2e8:2ace:1ddf:54dd]) by PH7PR11MB6451.namprd11.prod.outlook.com
 ([fe80::c2e8:2ace:1ddf:54dd%3]) with mapi id 15.20.7339.022; Wed, 28 Feb 2024
 10:18:47 +0000
From: <Dharma.B@microchip.com>
To: <krzysztof.kozlowski@linaro.org>, <maarten.lankhorst@linux.intel.com>,
	<mripard@kernel.org>, <tzimmermann@suse.de>, <airlied@gmail.com>,
	<daniel@ffwll.ch>, <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <Nicolas.Ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>
CC: <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: display: atmel,lcdc: convert to dtschema
Thread-Topic: [PATCH] dt-bindings: display: atmel,lcdc: convert to dtschema
Thread-Index: AQHaZjjd01Ir06e0kkmO7KWz3iDwFbEeHZWAgAE9Z4CAAAOxAIAAM9cA
Date: Wed, 28 Feb 2024 10:18:47 +0000
Message-ID: <e5cb705f-56cc-47cc-beb5-700c9a35c8cf@microchip.com>
References: <20240223-lcdc-fb-v1-1-4c64cb6277df@microchip.com>
 <796652d5-af57-4aca-87c2-10a7b0b55959@linaro.org>
 <11c545e2-45df-4587-a5c7-12b05c2f01e0@microchip.com>
 <9bf7e492-891c-4d8f-b388-3b2ebae611c1@linaro.org>
In-Reply-To: <9bf7e492-891c-4d8f-b388-3b2ebae611c1@linaro.org>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6451:EE_|DS0PR11MB6493:EE_
x-ms-office365-filtering-correlation-id: dd10fbe7-9b75-4b94-76e2-08dc3846a6e0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5nabekvnfeoOAe5kHNnH+rIVvIRM74FwWbrMlo8LLc4FNR47k1pW5u9U/bRUX0r2OhrVHoPiZI67QJ5/+ExE1Zw+v0+bbBYbvO00eQrzeeHYG84J/8UJYggA4057UjXugP9LHvnlJRTyZPuoJnOFmnCNaDcBjypZHIqv/gPI6HNFPeip7EnWtdI/PY05apIR5YGSwLelYtgIugcN3rY5vAMpRDAaDaZyHZGU+vjoK9bWjzMVZZaBUkJO58uxzcMsKFSIqLA7MqWHyFdAd7wVkShx4LDOEFygkU+ooYUPtS32YBpQUBc7biJ4NL691c/t1ltiW9fy+lm7BTxa94H1EGylADvLn5kTJ3lebK+sXJIZsZ4kMS7Ph2YB8Yn77kBek+W/ITLI4Skx1g6xyDqBucyDCgIAFGkbcFq6ndD3NK6opLhLS187unKpqx2CeE4qAqjVyN53pzx14lX9+Q9DYTDil4NEpbp+XXPaXSow3AgK7vwAHw55Z+B7cwKvT/oh0/x+xiT+DlFFBHNg/yOQ61iQYQcqX374J7ZJiHB6oZV9zsuU1ILkKp3B3EYr4OM2crMdLO1jcO6HEiF+yesL2Eh134BuxlF7xaqDeXruYHRpbv8+I7jsO8Stnbrq/a1L/hHYjKH3S/Al+zp8GFj0X4Opw6fpBQ2A0XX+VZbsOtnZTJz7IIkdIGTZmJJGkUIt0Tp9CcfjidRlGaEtNd50Tjk4pTVQH7GsWfiLeQFtqNo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6451.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(230273577357003)(38070700009)(921011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K09SMWpiY2NvbUxUODdXQWdPS0UvZUROT0p4Wm5OL2c3ZWhrNDM1SmNHNzFL?=
 =?utf-8?B?cFBWZ3E2aU9lN3R6YUlCSVdKVjdiaFBtenJLWWhNYUN6b1QrN1hNbmVFK2dv?=
 =?utf-8?B?T0NuWkRaMGhCY1JXclRTOVlLQ1NMVjRudGgydHg5eVpCNDlRWnAxYldjUzBw?=
 =?utf-8?B?a3pXbXhPeTNSc2QxZGF3RHBLaVpCTEx2SUJTL3JYTzNyL2lFQkJYa01YTU9i?=
 =?utf-8?B?OCtpMUd2N2Ywbk1aejhtL1lmWUVPam9CdG1Fa21meUNNL0IxNDZQR1pkLy9s?=
 =?utf-8?B?YVBjK0VBQ1VJK3ZvZnJQQzh3dDRHeFJVb1ZwTkJscmo5eEk0V1RCa3BKR2Uz?=
 =?utf-8?B?eXlkb0FEMjhoMFczc2MwV3ZqS2Y0T3daVFk2bHEySzZha3V5UFk1SGxsdldz?=
 =?utf-8?B?QmlOcEZDQ1crUnNkYmRDWnEyZjlmbS9vLzhmV00xbS9haTR0dmlETWdTdzJ4?=
 =?utf-8?B?Wkhxam5Yd3J4SFlJYTM1UEg4akQwQmxHSWZIU2dSN1VxVGQ2ZXpVZldmNUc5?=
 =?utf-8?B?WDN4SDdzV0NsVUQwZXlUdGJ6THVSSUE3dTFwR01STC8wWjcvaVJiRW80RWsr?=
 =?utf-8?B?eGZOL0NBeXZHWnlVdlRRY0E4SW5lQ3dWejh2emNLOHVYNU54aGRYbkFqWmNz?=
 =?utf-8?B?L0lENmRDeU5QQzRKeVVST2g1ZysyUFlzV21wL0RIS3RnRVp6dThESTgwMHJF?=
 =?utf-8?B?OUFwTlZGZ3NXeTBuVjcyaGJXeWZJY1dCNFQ1L3JQUEhucmI5bVpvQ1BzSVVn?=
 =?utf-8?B?RFlUTlc2QWRYeDFrdFJMTHB4VzYvbUszaTd0bVAyczlJeE4yc0dmTkRlSlp2?=
 =?utf-8?B?cUlDVkNsYjJTRUI2QXcrZkZBbGRYeUF4T2NWdWQ0QW53azluN2xyYVNvaC8x?=
 =?utf-8?B?ckVoamZrLzduUHNzdFdGRUNwYzc1a0IyNFgreUVZRjJKTzV6bnBLaG5ncnNi?=
 =?utf-8?B?YjVFbjFFdG9hZGxWSW5PT2pTV01Rb3QrNE1USWkzSTZVdllGOTNSeE52aDY1?=
 =?utf-8?B?cEh6QnRxaFRtMlNYaThBUEJoWEdJMEF0Ym1HVGVuOU1jTVJmZERDT3JKWTNW?=
 =?utf-8?B?OVJqTzcxR25wajdwMS9zSnRRTysxOHpFVDZPTHFRNlpmZUNzdnZIVHhkczkw?=
 =?utf-8?B?di9wQzhmMUp0OWk5V29HdW5Mc0pRVHVxQnhqanhVbExEaDNSUHFEa1NSSTdJ?=
 =?utf-8?B?L2NrbEN0dXc3UVFRdUNiUzZPRndjamlPLzM4V1lvRlpIYmVNL0hNZGk3bXl2?=
 =?utf-8?B?bTBESStxanR6eTN4eGJpekV0Y1pkUzZQb05IelU0KzRIcTduUXQ3VVRyanNX?=
 =?utf-8?B?cmhTNjkvNDBydDNBeGMzWUNaRG9xRW5LR3dJRytwQkpEWFdzTEYrK1pRcDRp?=
 =?utf-8?B?a0JFUU1FS1VpTGdtS3V5MlBweXBEYW5UcUFMckVmay9HV003bWRhR1RJc2da?=
 =?utf-8?B?UStVenNIc2FkL1BDQXQyMmFjWFU5Vkd6NSt3cHFXekUxZWxOYWFDQ2gyZ2ND?=
 =?utf-8?B?Mnd4TXkxMlVKaW1TQ2NiQ012VFUzTzI4SzdlZWd3WENHaCttWHI1ZGRzY1lR?=
 =?utf-8?B?Z0c3ZUs2elllN1Q5R0NtT3VicXoxekg1bUg0dkZ3d1ljNXMxRGd2RS9FWVZN?=
 =?utf-8?B?Y1F4emVxY2xUd09Wb3dHNnZIeVJzUlJDRVRlSWw0Z2wvd283SjlienFpNHVF?=
 =?utf-8?B?TEhKL2lpRjUyMXg2YTZYT2ZRTU1tVjVVN0UzQ2RubGN0QzdDaFpHWEVRSGNE?=
 =?utf-8?B?dGJCUlR6b3JhUGx5dUFXUUt5YVM1eHJhSTFsSFBtUUd4T01TdnAvSTlIYWhF?=
 =?utf-8?B?b3lLclFKZDl1RjUvbk5SZ3VtVmxYSUo5QndFekJXVFN5NC9hVHV5LzhXa2pj?=
 =?utf-8?B?SUVoWFJsRHhkL254TEJhcW9aTFVHVVlaQS9WVG4vRW9oWklJZk0wbWhRN2xU?=
 =?utf-8?B?bHdoTUNpZG9pS0ZRZ2ovR3pUNmFaY3RrcG0vbk9QSFZGUmxDUWxrb1lmVEJD?=
 =?utf-8?B?WFBnL0ZsQ213RWsrWml6MEhNejZWc1oyOFJ2ZXc5M2JCM2dBTllxdytXa3U5?=
 =?utf-8?B?ditodHA1dmxhRml6NFhRNm8rdmc5ekI2VUZkNTZsQWdsWWVuNkJLamN1SGRE?=
 =?utf-8?Q?CPymj0JZTMvlJt9c1qyRbCsBb?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C8691AEF3281354D90959C0B22B0A078@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6451.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd10fbe7-9b75-4b94-76e2-08dc3846a6e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2024 10:18:47.8156
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dILGicpNBit74kaYU+GSMABwuRA1ik2FVgwPrf2UphDJfBgp9pUjP4+2gGDUOTUcO0BLwksV3AoV8XW1t12Fvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6493

T24gMjgvMDIvMjQgMTI6NDMgcG0sIEtyenlzenRvZiBLb3psb3dza2kgd3JvdGU6DQo+IEVYVEVS
TkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3Mg
eW91IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gT24gMjgvMDIvMjAyNCAwNzo1OSwg
RGhhcm1hLkJAbWljcm9jaGlwLmNvbSB3cm90ZToNCj4+DQo+Pj4NCj4+PiBJIGRvbid0IGtub3cg
d2hhdCdzIHRoaXMgZXhhY3RseSwgYnV0IGlmIGVtYmVkZGVkIGRpc3BsYXkgdGhlbiBtYXliZQ0K
Pj4+IGNvdWxkIGJlIHBhcnQgb2YgdGhpcyBkZXZpY2Ugbm9kZS4gSWYgc29tZSBvdGhlciBkaXNw
bGF5LCB0aGVuIG1heWJlIHlvdQ0KPj4+IG5lZWQgYW5vdGhlciBzY2hlbWEsIHdpdGggY29tcGF0
aWJsZT8gQnV0IGZpcnN0IEkgd291bGQgY2hlY2sgaG93IG90aGVycw0KPj4+IGFyZSBkb2luZyB0
aGlzLg0KPj4NCj4+IE9rYXksIHRoZW4gSSB0aGluayB0aGUgZHJpdmVyIGFsc28gbmVlZHMgdG8g
YmUgbW9kaWZpZWQsIGN1cnJlbnRseSB0aGUNCj4+IGRyaXZlciBwYXJzZXMgdGhlIHBoYW5kbGUg
YW5kIGxvb2tzIGZvciB0aGVzZSBwcm9wZXJ0aWVzLiBBbHNvIHRoZQ0KPj4gY29ycmVzcG9uZGlu
ZyBkdHMgZmlsZXMuDQo+IA0KPiBEcml2ZXIgZG9lcyBub3QgaGF2ZSB0byBiZSBtb2RpZmllZCBp
biBteSBwcm9wb3NhbC4gWW91IHdvdWxkIHN0aWxsIGhhdmUNCj4gcGhhbmRsZS4NCg0KSWYgSSB1
bmRlcnN0YW5kIGNvcnJlY3RseSwgSSBjb3VsZCBkZWZpbmUgdGhlIGR0IGJpbmRpbmdzIGFzIGJl
bG93DQoNCiAgIGRpc3BsYXk6DQogICAgICRyZWY6IC9zY2hlbWFzL3R5cGVzLnlhbWwjL2RlZmlu
aXRpb25zL3BoYW5kbGUNCiAgICAgZGVzY3JpcHRpb246IEEgcGhhbmRsZSBwb2ludGluZyB0byB0
aGUgZGlzcGxheSBub2RlLg0KDQogICBwYW5lbDoNCiAgICAgJHJlZjogcGFuZWwvcGFuZWwtY29t
bW9uLnlhbWwjDQogICAgIHByb3BlcnRpZXM6DQoNCkkgd2lsbCBhZGQgdGhvc2UgcHJvcGVydGll
cyB1bmRlciBwYW5lbCBub2RlIGFuZCBtb2RpZnkgdGhlIGV4YW1wbGUgYXMgYmVsb3cNCg0KICAg
ICBmYkA1MDAwMDAgew0KICAgICAgIGNvbXBhdGlibGUgPSAiYXRtZWwsYXQ5MXNhbTlnNDUtbGNk
YyI7DQogICAgICAgcmVnID0gPDB4MDA1MDAwMDAgMHgxMDAwPjsNCiAgICAgICBpbnRlcnJ1cHRz
ID0gPDIzIElSUV9UWVBFX0xFVkVMX0hJR0ggMD47DQogICAgICAgcGluY3RybC1uYW1lcyA9ICJk
ZWZhdWx0IjsNCiAgICAgICBwaW5jdHJsLTAgPSA8JnBpbmN0cmxfZmI+Ow0KICAgICAgIGNsb2Nr
cyA9IDwmcG1jIFBNQ19UWVBFX1BFUklQSEVSQUwgMjM+LCA8JnBtYyBQTUNfVFlQRV9QRVJJUEhF
UkFMIA0KMjM+Ow0KICAgICAgIGNsb2NrLW5hbWVzID0gImhjbGsiLCAibGNkY19jbGsiOw0KICAg
ICAgIGRpc3BsYXkgPSA8JmRpc3BsYXk+Ow0KDQogICAgICAgZGlzcGxheTogcGFuZWwgew0KICAg
ICAgICAgYml0cy1wZXItcGl4ZWwgPSA8MzI+Ow0KICAgICAgICAgYXRtZWwsbGNkY29uLWJhY2ts
aWdodDsNCiAgICAgICAgIGF0bWVsLGRtYWNvbiA9IDwweDE+Ow0KICAgICAgICAgYXRtZWwsbGNk
Y29uMiA9IDwweDgwMDA4MDAyPjsNCiAgICAgICAgIGF0bWVsLGd1YXJkLXRpbWUgPSA8OT47DQog
ICAgICAgICBhdG1lbCxsY2Qtd2lyaW5nLW1vZGUgPSA8MT47DQoNCiAgICAgICAgIGRpc3BsYXkt
dGltaW5ncyB7DQogICAgICAgICAgIG5hdGl2ZS1tb2RlID0gPCZ0aW1pbmcwPjsNCg0KICAgICAg
ICAgICB0aW1pbmcwOiB0aW1pbmcwIHsNCiAgICAgICAgICAgICBjbG9jay1mcmVxdWVuY3kgPSA8
OTAwMDAwMD47DQogICAgICAgICAgICAgaGFjdGl2ZSA9IDw0ODA+Ow0KICAgICAgICAgICAgIHZh
Y3RpdmUgPSA8MjcyPjsNCiAgICAgICAgICAgICBoYmFjay1wb3JjaCA9IDwxPjsNCiAgICAgICAg
ICAgICBoZnJvbnQtcG9yY2ggPSA8MT47DQogICAgICAgICAgICAgdmJhY2stcG9yY2ggPSA8NDA+
Ow0KICAgICAgICAgICAgIHZmcm9udC1wb3JjaCA9IDwxPjsNCiAgICAgICAgICAgICBoc3luYy1s
ZW4gPSA8NDU+Ow0KICAgICAgICAgICAgIHZzeW5jLWxlbiA9IDwxPjsNCiAgICAgICAgICAgfTsN
CiAgICAgICAgIH07DQogICAgICAgfTsNCiAgICAgfTsNCg0KVGhpcyBzdHJ1Y3R1cmUgaXMgbm93
IGluIHN5bmMgd2l0aCB0aGUgZXhpc3RpbmcgRFRTIGZpbGVzLg0KDQo+IA0KPiANCj4gQmVzdCBy
ZWdhcmRzLA0KPiBLcnp5c3p0b2YNCj4gDQoNCi0tIA0KV2l0aCBCZXN0IFJlZ2FyZHMsDQpEaGFy
bWEgQi4NCg0K

