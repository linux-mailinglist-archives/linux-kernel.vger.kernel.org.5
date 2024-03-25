Return-Path: <linux-kernel+bounces-116472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E4D889F7E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:30:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95A1B1C3648F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E75F172789;
	Mon, 25 Mar 2024 07:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="AEOhvdDP";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="RuzV7zDr"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C950318C08;
	Mon, 25 Mar 2024 03:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.154.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711339040; cv=fail; b=SG8XAJa45xTpJr7r33nz/Ay7h0K/QRQVXf1w5+XfG193cCESPmcrZwCHLXVLip2Ft5c2T82FiSVYpp8sk+2ru9SFAPiqfn5KV/WBJpr/UnpHorvS0wGcQrLJ9cisApQJUuTIehnrq0J/OtAOKeXX10V/LBGtDsUB7un8KJKeKus=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711339040; c=relaxed/simple;
	bh=ZUxkxCE/vBmMl6E37W8ndCiGnStgr/XqwJ6LzFblp6g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gAn07zGxv6VRWnmoyTbbbyLu1c4LVNxb2YrC2goyOd45NQlBKfu/RvtCVnvBI2+sbV/lQfFscZ/D9wvGwcZjFNkzIXIJFqsR2blLf01pJjZaeY7QFCVKo7moLg1oNNtXsqwcgeoCeUb7AbGEH3Bf0AY9NsVE7DSi+kPfFgSOGRE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=AEOhvdDP; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=RuzV7zDr; arc=fail smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1711339038; x=1742875038;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ZUxkxCE/vBmMl6E37W8ndCiGnStgr/XqwJ6LzFblp6g=;
  b=AEOhvdDPWSo1WW0yTQqMk0KW4rsoTdScZFFAX37u+yt57oEU28F5Prs+
   fdyFIEYTKCu19RL35NmySS0+N76HblRZObnyAYzq4wPz7YHU5acqLZSw8
   N3uvXJ6iR5HQt5UIU2XJDI2Sw88I9azSzpT1Qzl1VzV0s7s3E1cBZpqMU
   IIHvCuGCY1iNQRMnZfq+PxF7hbZc5ta7Vuvu87/23z4d3UImgrA0t1+kh
   Uc923aGmSMfLnQMgbtq2KpJxGIIODoUxZOyF9Cr+YqnwoxyZ1HRqnnzDY
   d4tdcJQHDFJKfu0vbH2Uj5BQr7plHg7iatEoS82rGbPQTRZs/9UnZqCrX
   g==;
X-CSE-ConnectionGUID: /eYAHis0TmusLMYfzwOOwQ==
X-CSE-MsgGUID: SMUNbZFBQOeJVR5JD2OF1w==
X-IronPort-AV: E=Sophos;i="6.07,152,1708412400"; 
   d="scan'208";a="18634162"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Mar 2024 20:57:11 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 24 Mar 2024 20:56:50 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 24 Mar 2024 20:56:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TTQ/rd+q5wET5bMnPl342DQ5EeZOC3gGTPoCBuG3P6YB6gecYozhqgqqmdy2BMVarUVe8qJ/Q0gM3YVl0zDAiImuYZhKbz9bnpDh9Fam15X8IL+IYUPVKBHkK3SMoEwpFPNz0x+lezvWGs9d8OrsZzV+jYptj+b10kaSC+9/v6WasogcC/mwcedHgPvaMTpDHwzZ4ofzR+649iNO/hrxes7F0z7o+ZCUMWFEjiaUcI4W4XH0aG6NTgQsQ12ZwhgcDVTkt7uf1yUUp95JyMSiGsCWFG61+Z+YHWUFWrwxjxv92q0nvB2USQ/unDf1zsFBjYjonU6QVbDMqweUk2W8RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZUxkxCE/vBmMl6E37W8ndCiGnStgr/XqwJ6LzFblp6g=;
 b=Ss8nu4xVUMTkiITQ4jwY37jqZLKoSnrW/Jx5oK/cVG45GYbWvw4dNiWTgpYdhywq9Q/T8qNIpShq6AS59fQz9s1vty7QWq04mRFoGxUQksxTPjz+U9JoJQWb1t1O5oHNuDJAVRCPj5oQyXjG/yqUTRtCcCZ3EWjgMaixYmjp11VywpcV4JQNpoBP+JLl30klpOs/AgfgD34dOchPmsAYP8T6H2lzZ/b12v7Ot1tag8hUgNCBwE6uY/DUDS6Ub/oHQarZaDS1MbPxKnfb6YO3MtCYKjsgMQHWIXlxgbf5/rPXmtuOADwEFw/1pYROoiUh54FWwzJbCyYM7jBkuVYbYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZUxkxCE/vBmMl6E37W8ndCiGnStgr/XqwJ6LzFblp6g=;
 b=RuzV7zDrGkn8irsPI41DHuVG0+WRlNVz24XCa5M0Ql3mgIY2dheFkusEP+iLJgtRdW5VOEmeDAs/dOkHPi4E5wonGoBdK0hoQ8ruWX3916OGmfePFkBfFYVbAfHjhly9dZafObQayPf7xAURNHsknQ3QBtcyU3ho4XAsas+AR5ZHGteg3+BMJhzpKt/jql3yvlPCKNj3wmOIonrxK+C7LyUJmWIUPq/k7XtStLICNppJDTa7RLnDS9oDvgAgYRPpfd3+4l4hsnyIqvbZ3RUQcarvJtQadTi9WWVrHnO0nAdlnBnO//Z5vafGSBBR85G1WhmNJX3fMHLseOFJja5OCA==
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by SJ2PR11MB7453.namprd11.prod.outlook.com (2603:10b6:a03:4cb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.21; Mon, 25 Mar
 2024 03:56:47 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::6440:4b82:c32c:9eb7]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::6440:4b82:c32c:9eb7%5]) with mapi id 15.20.7409.028; Mon, 25 Mar 2024
 03:56:47 +0000
From: <Balamanikandan.Gunasundar@microchip.com>
To: <Conor.Dooley@microchip.com>
CC: <conor@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
	<vigneshr@ti.com>, <robh@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <Nicolas.Ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<linux-mtd@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: mtd: atmel-nand: convert txt to yaml
Thread-Topic: [PATCH 1/3] dt-bindings: mtd: atmel-nand: convert txt to yaml
Thread-Index: AQHaeoroe47HkYrCOkO/zG8i/RhtzbFA1CuAgAJZPQCAADMvgIAEezwA
Date: Mon, 25 Mar 2024 03:56:46 +0000
Message-ID: <d3f2c773-ca53-43bd-bca8-4e27b9a4e5c1@microchip.com>
References: <20240320-linux-next-nand-yaml-v1-0-2d2495363e88@microchip.com>
 <20240320-linux-next-nand-yaml-v1-1-2d2495363e88@microchip.com>
 <20240320-quicksand-attentive-14610103237b@spud>
 <3c199359-f0d8-4ec0-bf86-930b2ecfb876@microchip.com>
 <20240322-arrest-pucker-7ff731359fa0@wendy>
In-Reply-To: <20240322-arrest-pucker-7ff731359fa0@wendy>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB6231:EE_|SJ2PR11MB7453:EE_
x-ms-office365-filtering-correlation-id: db4eb569-e4c4-4c57-7416-08dc4c7f97ba
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1Rl7V3xUVX5U7kAF2hbvL9kGJiNXVt/gAq0mf3pY5T2LHYZHLiTzQsoHzhhlzKj9+6J3UBKXmh29rSWwAgekzcoJcf6bgODeErzK2ZjIqQozTMah7dQnb0SNCejg1hVCh99JaFlby6R657rAWuVeWGgNBjH6oTDWGXgoy34kDS14b+Fzw3vGe9yVYmV2WTOXdu7kiyoSbq/IIPiBiHHWiDd4dkfQivOHtMc4LRZSNMTb9foPYtbdq+qesJfKIBTFrfuiD1lr45shvmB1fGmEN/8dFJspIYyoJX/Z1rKsx1I5piOSxW+av1EWKTBZmLgzHjm36ThTMYA/z8UPZRZee/xeO5cG6H0/GIHAnXzbHqpdjWODydI4W0Z0lsEhaVwKP4qtawK8Jvue2Ql1+LYWzEEjMIIEHbUJoTmj1TuUKtQFylg78H9nZxciBgOO5VwtVFLNq/L0vzEBtnSROmBB0vO23yzzdyZ9RDuQdzKYJbVvvWK5xVuXsoU9TA5kwUpBCuUYbMGuncRSr9/mr6Ng0pUnKYJN2+QL0H7Rsqt2coPj5HCi+Ef1olDdSdQWHnXDVT+i9IipFr10JFp8TqJeQridPBlXwE+/gPXMI0a2Udip9QXWcs/yKtLqSVaonmlAVXyYudXdtbz4ScrBbGLt6jZmzPuarmrD341YtLSrUkOv+FoONVDlvYDbYJOKKfMv4Z19LRxcs6ZwPO0BMclRW8qND2c8MAjttji/3vbQUIQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QnI4V25lYVR1NklsSjlvdDBoRDhFUWFUbFkxOG81MzRrRW4rL3ZoQ3EveXhm?=
 =?utf-8?B?a25yaTFZcWlzS0l5eWRUbjJya1VHL25hSExpS1J4N1E5RkdwZDJlbjFES3F6?=
 =?utf-8?B?eWVPR21YQnVpMWdlbXEwSUo4Zng4Q3Z0TG1NQXQ4WUZUSEtFZnZTUG9VSXRP?=
 =?utf-8?B?dEY1R08reXJKSWx6NkZxc3BaUkYwcDQ1WVBYc2NJVG05OUVESFhsdlRodFVC?=
 =?utf-8?B?Zk5ZL3gxNUFLL2h3SmU1NkwyWmQzRTkrVk9pVG9EaGo4VXRHa1B3VjFWdTZK?=
 =?utf-8?B?cTZGWHpSK0lEMnVPZHk5YllJT1pMci9FUVJUNWZ4dmlnT1JLSFQ2VUtLc3Vh?=
 =?utf-8?B?RS9IbFI5dFF4eGs3SUthSHBMblRXcnR4SEFsUDNrMkE3ZVJPblhSUXRRVkpi?=
 =?utf-8?B?TzcrNXFDU2JiS2p5S1ExM243T1JDRkdETE1zNFd4RHZQS25HWUh4NjZNaFNs?=
 =?utf-8?B?eGtvcEpTQnB4U1RNL3lyVVo5aWdrUHV3NVBVMnhrUmIvMHRDTHM4MVBzckFO?=
 =?utf-8?B?TnpINnlHNmFLSXZ4cmFNRE9ZVU9VNGluMjcveDVTSW9TaHBjaVpicDBaQ2pO?=
 =?utf-8?B?SXdEWWkxdU5HWDZhOTE5WXBybG8vRFNzZDlhM0dlNjdVM3ByUW0xdDZ0dEJY?=
 =?utf-8?B?WERmSHhrK1lQbU5KTXloLzFYbjMrNFJPUzdQZm51SlluUjRkUkprVmNycDlM?=
 =?utf-8?B?V2ZjMUxqRURGOER3cDRQbHkrUzJrclZra3BqZFRSWktIMVJJVzhKa2F6Rzha?=
 =?utf-8?B?VEdlNW9aaTNPWW5vdnJnZ01wVnkwUldrUmFlM0tjMEJYRWFoVEtMbjFMTHl2?=
 =?utf-8?B?NWJGVlBOei9BS3NoK3dKOHpZaENUNWJ2dEx2VUlvN0dHb2tnRUNLdUdHZXdM?=
 =?utf-8?B?WFVNK0h3VmpzTGd5cm00Z3VXSWNuczlYU3BtNHpsbmhqOFZibkpyTGZqdXky?=
 =?utf-8?B?TXBINmhRb0JlMnJTMlRPbDZoaDB1QVRFTi96TkNIejJSMmdubGFPanpMR1h3?=
 =?utf-8?B?Rmp1VmxLeFNBUUVsclhPdW9mVkoybWlSS0gwYmN1SkJwQ21CM0tYT29DOGlS?=
 =?utf-8?B?U1pENTdydkdKUXhiVWNDV3RSdFJqQ3JWZDMwT0tGdjdHSFo3K2hyN3htSVVB?=
 =?utf-8?B?UEszMjFRZThFUU0xVkk0SFRTSEpORzFTK25HZ2wzL1dnNm0zSmdQNUg1cXRl?=
 =?utf-8?B?bnhSU1lvZlhZSU5vSHdMTEt6STQ3U0FVNS9raVZiaWJHaWxISmVKdnZMMlk3?=
 =?utf-8?B?a08yVUgvVmNPUVRrWEtsVXFDd0pVRnJia2ZleXlqMjVTSmNFN2R0NUxLSDR1?=
 =?utf-8?B?YWo5OG9rR0YyRGJReHpzclN4elNOMndSM1k2RW8wNmhiVnJNUlkvSFQ0SFc0?=
 =?utf-8?B?RWdaSjlSMU1JMEh6akYvZ0tCU1VMdjdkazhyNXRaeG5CTzByWFVsWXFxdHNa?=
 =?utf-8?B?cEM3Q25Ta1Z2UUpwcFVTVG9VcjMxeDJPWFBldHpoNWlsOUJMcGJVOG0zczZG?=
 =?utf-8?B?QU1OTkFKc2puZFVmWmNNYVRyT1Nwa3hPR2Z4VDQ2Z0dzaU5DNnJ5UnBKVFdE?=
 =?utf-8?B?eVJwanVHS1J1RlF6U3IxcVUyQm1PaTdFeWluaFJORzJrZjNENWhNcDVVTlRT?=
 =?utf-8?B?dDZYK1JXdG5DTGh5bFczZVJua3ZLb29SZjloYUNENEpReDZLcDNNOVBsWjcv?=
 =?utf-8?B?elh5R0sweHU5RmZQcXBKekpoOHF6V1NMOXhSTmdVVXJhQUJybUZMU1JmQUU5?=
 =?utf-8?B?V3pHeXNvbGdMenhUZVpJK1B6NHFuZkpNUFI5bnRza2E3Qnd3TUF6WkYwb1I1?=
 =?utf-8?B?UGcvVFdMVUtaZ1JSNlA5MkdvaWZqSmdlSjlTWXEyWHJlelBPVytLUzloRENF?=
 =?utf-8?B?eGJOR0pTS1AwWHR2QUJLWXgybVQ2SFFiSzNnT3hyRzYvOW5aa3RzUEdGYWhs?=
 =?utf-8?B?Si83NkhBcjZDUTR3WmUwak80UDNsQzVNMlZKVkR6dEdqcXVRYS9VYng0WVU1?=
 =?utf-8?B?MlhrSHVqNEhzclY3OHhWNzVlSDhJWklMQ0tvWUNmeG5wRlZONDRWKyt5Vktx?=
 =?utf-8?B?QWF4RFZlemdwRlJYWFMzb0pNM0podVhucTlpd3VkTGdpbkJHOVdwVjlTOGpr?=
 =?utf-8?B?R1lUdHJZTEVqQjdjU3A3aTlrQmpXdHZEZEdPRlF3L3ZUTUNUZ1JQYUNsRmlI?=
 =?utf-8?Q?PhRwRfTadA9xAXDWh5P5QVw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AAF8B1F6AB24974C87C655A411DA54D2@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db4eb569-e4c4-4c57-7416-08dc4c7f97ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2024 03:56:46.9400
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RhDjfARhrzWzMIru/AdSGlYwOgi9fQj50VIC9m3EX/VR8ARt5XWsvU0q8WaUiDpuS+E9QrRiYTxXkzJoHe1iXqptSkUWJlQrWXxpo/40c9YS0sFa2eKXir3/SLW0L5Wa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7453

T24gMjIvMDMvMjQgMTowMCBwbSwgQ29ub3IgRG9vbGV5IHdyb3RlOg0KPiBPbiBGcmksIE1hciAy
MiwgMjAyNCBhdCAwNDoyNzoyOUFNICswMDAwLCBCYWxhbWFuaWthbmRhbi5HdW5hc3VuZGFyQG1p
Y3JvY2hpcC5jb20gd3JvdGU6DQo+PiBPbiAyMC8wMy8yNCAxMDowNSBwbSwgQ29ub3IgRG9vbGV5
IHdyb3RlOg0KPj4+IE9uIFdlZCwgTWFyIDIwLCAyMDI0IGF0IDExOjIyOjA3QU0gKzA1MzAsIEJh
bGFtYW5pa2FuZGFuIEd1bmFzdW5kYXIgd3JvdGU6DQo+IA0KPj4+PiArYWxsT2Y6DQo+Pj4+ICsg
IC0gaWY6DQo+Pj4+ICsgICAgICBwcm9wZXJ0aWVzOg0KPj4+PiArICAgICAgICBjb21wYXRpYmxl
Og0KPj4+PiArICAgICAgICAgIGNvbnRhaW5zOg0KPj4+PiArICAgICAgICAgICAgZW51bToNCj4+
Pj4gKyAgICAgICAgICAgICAgLSBhdG1lbCxhdDkxcm05MjAwLW5hbmQtY29udHJvbGxlcg0KPj4+
PiArICAgICAgICAgICAgICAtIGF0bWVsLGF0OTFzYW05MjYwLW5hbmQtY29udHJvbGxlcg0KPj4+
PiArICAgICAgICAgICAgICAtIGF0bWVsLGF0OTFzYW05MjYxLW5hbmQtY29udHJvbGxlcg0KPj4+
PiArICAgICAgICAgICAgICAtIGF0bWVsLGF0OTFzYW05ZzQ1LW5hbmQtY29udHJvbGxlcg0KPj4+
PiArICAgICAgICAgICAgICAtIGF0bWVsLHNhbWE1ZDMtbmFuZC1jb250cm9sbGVyDQo+Pj4+ICsg
ICAgICAgICAgICAgIC0gbWljcm9jaGlwLHNhbTl4NjAtbmFuZC1jb250cm9sbGVyDQo+Pj4+ICsg
ICAgdGhlbjoNCj4+Pj4gKyAgICAgIHByb3BlcnRpZXM6DQo+Pj4+ICsgICAgICAgICIjYWRkcmVz
cy1jZWxscyI6DQo+Pj4+ICsgICAgICAgICAgY29uc3Q6IDINCj4+Pj4gKw0KPj4+PiArICAgICAg
ICAiI3NpemUtY2VsbHMiOg0KPj4+PiArICAgICAgICAgIGNvbnN0OiAxDQo+Pj4gV2h5IGlzIHRo
aXMgaW4gYW4gaWY/IElzbid0IHRoaXMgYWxsIG9mIHRoZSBkZXZpY2VzIGluIHRoZSBiaW5kaW5n
Pw0KPj4+DQo+Pg0KPj4gVGhlIGRlZmF1bHQgbmFuZC1jb250cm9sbGVyLnlhbWwgZGVmaW5lcyB0
aGlzIGFzIGNvbnN0IHZhbHVlcy4NCj4+ICgjYWRkcmVzcy1jZWxsIDogMSBhbmQgI3NpemUtY2Vs
bHMgOiAxKS4gSSBhbSB0cnlpbmcgdG8gb3ZlcnJpZGUgdGhpcw0KPj4gY29uc3QgdmFsdWUuDQo+
IA0KPiBZb3UncmUgbm90IG92ZXJyaWRpbmcgYW55dGhpbmcgYXMgeW91IGRvbid0IGhhdmUgYSBy
ZWYgdG8NCj4gbmFuZC1jb250cm9sbGVyLnlhbWwgaW4gdGhpcyBmaWxlLCBBRkFJQ1QuIFdoeSBk
b24ndCB5b3U/DQo+IA0KPj4gTWF5IGJlIEkgc2hvdWxkIHRoaW5rIGFib3V0IGJldHRlciBhcHBy
b2FjaCA/DQo+IA0KPiBZb3Ugc2hvdWxkIGJlIGFibGUgdG8gYXBwbHkgdGhpcyB1bmNvbmRpdGlv
bmFsbHkgZm9yIHRoaXMgZmlsZS4gSSBkb24ndA0KPiBzZWUgd2h5IHRoZSBpZiB3b3VsZCBiZSBu
ZWVkZWQ/DQo+IA0KPiANCj4+Pj4gK3BhdHRlcm5Qcm9wZXJ0aWVzOg0KPj4+PiArICAiXm5hbmRA
W2EtZjAtOV0kIjoNCj4+Pj4gKyAgICB0eXBlOiBvYmplY3QNCj4+Pj4gKyAgICAkcmVmOiBuYW5k
LWNoaXAueWFtbCMNCj4+Pj4gKyAgICBkZXNjcmlwdGlvbjoNCj4+Pj4gKyAgICAgIE5BTkQgY2hp
cCBiaW5kaW5ncy4gQWxsIGdlbmVyaWMgcHJvcGVydGllcyBkZXNjcmliZWQgaW4NCj4+Pj4gKyAg
ICAgIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tdGQve2NvbW1vbixuYW5kfS50
eHQgYWxzbyBhcHBseSB0bw0KPj4+PiArICAgICAgdGhlIE5BTkQgZGV2aWNlIG5vZGUsIGFuZCBO
QU5EIHBhcnRpdGlvbnMgc2hvdWxkIGJlIGRlZmluZWQgdW5kZXIgdGhlDQo+Pj4+ICsgICAgICBO
QU5EIG5vZGUgYXMgZGVzY3JpYmVkIGluDQo+Pj4+ICsgICAgICBEb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3MvbXRkL3BhcnRpdGlvbi50eHQuDQo+Pj4gVGhlc2UgZmlsZXMgZG8gbm90
IGV4aXN0Lg0KPj4+DQo+Pg0KPj4gQXBvbG9naWVzIGZvciBjb3B5aW5nIHRoZSBjb250ZW50IGZy
b20gdGhlIHRleHQgZmlsZS4gSSB3aWxsIGNvcnJlY3QgdGhpcy4NCj4gDQo+IFlvdSBkb24ndCBu
ZWVkIHRoZXNlIGNvbW1lbnRzIGF0IGFsbCBJIHRoaW5rLiBZb3UgaGF2ZSB0aGUgcmVmIHRvDQo+
IG5hbmQtY2hpcC55YW1sLCBzbyBhdCBsZWFzdCB0aGUgZmlyc3QgdGV4dCBmaWxlIHJlZmVyZW5j
ZSBjYW4gYmUNCj4gcmVtb3ZlZC4NCj4gDQoNCkFncmVlIHdpdGggdGhpcy4gSSB3aWxsIHJlbW92
ZSBpdC4NCg0KPj4gWWVzLiBJIHNob3VsZCBmaXggdGhlIGFsaWdubWVudC4gSSB3aWxsIHNlbmQg
YSB2MiBzaG9ydGx5DQo+IA0KPiBJIGRpZCBtYWtlIG90aGVyIGNvbW1lbnRzLCBzbyBJIGFzc3Vt
ZSB5b3UgYWdyZWUgd2l0aCBldmVyeXRoaW5nIGVsc2UgSQ0KPiBtZW50aW9uZWQgYW5kIHdpbGwg
aW1wbGVtZW50IHRoZW0gaW4gdjIuDQoNClllcy4gSSBhZ3JlZSB3aXRoIG90aGVyIGNvbW1lbnRz
IGFzIHdlbGwuIEkgd2lsbCBhbHNvIGFkZHJlc3MgYWxsIHRoZSANCmNvbW1lbnRzIHdpdGggdGhl
IG90aGVyIDIgcGF0Y2hlcyBhbmQgc2VuZCBhIHYyLiBUaGFua3MgZm9yIHJldmlld2luZy4NCg0K
UmVnYXJkcywNCkJhbGEuDQoNCj4gDQo+IFRoYW5rcywNCj4gQ29ub3IuDQoNCg==

