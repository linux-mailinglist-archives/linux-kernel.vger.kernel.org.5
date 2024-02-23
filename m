Return-Path: <linux-kernel+bounces-78008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BBB8D860DF0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 10:27:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22315B20B8A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 09:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B50EA5B687;
	Fri, 23 Feb 2024 09:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="IVmWosgP";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="FU0CqW8c"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5ED65B69A;
	Fri, 23 Feb 2024 09:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.153.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708680466; cv=fail; b=fe2i/+jqPzwD9qnycVL2Ziqz4IuwAncYEuZsOjXRxu/ET7//F2mfGQ7ULjQdQpRbZvhiEaAf//z++DnEC+OUX94BB6Yfd2oYWsdFUE2aAHTYKOIgryYgik6e3jbdz6TSaeitRzkOW3ou7uDlTW1RRkJ2oHTVWTKlwOeEKtNeEaw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708680466; c=relaxed/simple;
	bh=IH402xQ5o/7lsPVcSJ5/mlcfpZFpGSWW0Et26Ez4hZA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=um1RW/hy9rueUb/aql3VFscG6XYK2ib08+E57PC1XfM9v6vvMAZ7jYkyZLYsV/xGL6gY0hQBnxxIOLeX9Wuz+gbTVQjn4FsuV7elNU3/b55dWWQHKvWCtUZg5IyrbaSgMSQFzDNqb+2Gg99QlDpBhiX+scizn6rSDDQC7QTlLBs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=IVmWosgP; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=FU0CqW8c; arc=fail smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1708680465; x=1740216465;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=IH402xQ5o/7lsPVcSJ5/mlcfpZFpGSWW0Et26Ez4hZA=;
  b=IVmWosgPfBPLT97E3vHm+Om06YxAprMPi35MCtCV7IvvMFP6yXXaImTr
   QZrq5eCDS1colahUolrqIMwQsa6VOUNx0MYxHKahwucnLGTzGxnZkGoHd
   c+pdy8rbLj1w1k/o05QueGhfb/IE+BoKPuSjThFDhj/j+J/+cFUVjvbPa
   FnqxHBbIvvj4+PXglGM+3PTyl4phPjSk5HQ4jF6xyOYzA10oH7rINRq/S
   c7UWh2iJ48xTsytDvhIoMcjhAz8q+V6vzKHUgEL4hrqHz9hfArOe+rm8h
   3k6cwjl3TYIUiiQSqDw1C1w6/BmuI/ij/NmYGZFACpyr4lDgwpoissqAa
   Q==;
X-CSE-ConnectionGUID: m4gf04BjTrCMX6leQJM9ug==
X-CSE-MsgGUID: aNpI85PSTM+e9aDD3OkocQ==
X-IronPort-AV: E=Sophos;i="6.06,179,1705388400"; 
   d="scan'208";a="247458948"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Feb 2024 02:27:44 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 23 Feb 2024 02:27:29 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 23 Feb 2024 02:27:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nBIEEotfI2JMVUmpRypQyOGionCA8Is1sqw3cC5GkG0lQNVEy5QOJRks2JMbnbUILf6DYJOwwb3F8zh8sAT69RnFmBbBl2+16gxegnNH8VN4QKZpsAKawk0pb9TBjr1LLsjGQWsi3lCRymjp17HHqXcl7qQyYdCgslqGLhhEecE7JoRNxgdJRmLLR2vyXU4EVTX9l9wsG9d2Igxo4XOEIdByEpDDVoSrdF4xz4igh93mftP9LzNsmNu+CTZsRoS/vF8XcwTgpIy8AWkNYl9W8iwCGGmVgfLJZTEoEXI3usMJ9q4b8Y625O6WpNpN5BfSKZ+cUHMJjN0IgUZRD9Qz7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IH402xQ5o/7lsPVcSJ5/mlcfpZFpGSWW0Et26Ez4hZA=;
 b=EyyD35AJ0qMus+iJr/Ts5lrBcVSJUu3LWWzoUoNz7QVxot+HYfmlhLdcp6gbPQ84EhyoHzinOeMO8NJcDQJQROxHgDcVR6VkaB2HhCpzIBRkR6u3J3ohRfyunxy+fAwrk2G0HeuTwqmbY+OTkZnd5Co8Tg6gMF+m3x+KykinrWY/BJuWLyMFmRtAh6nKaYb9zDAd+XP2Lc0vAvmtaDFFmh4K5eduPdEjPF4R0GhnPfItMn2ppccLMjEXjO4c9T0Af9vfo7IuXoudOuImFSXBqnBVLGspQbYTi5XpNvhIV3rDM0VomQrM3B564aXTEN5vQcQVQ6wDCB+Sd9+e1Fpirw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IH402xQ5o/7lsPVcSJ5/mlcfpZFpGSWW0Et26Ez4hZA=;
 b=FU0CqW8cZXw4x0o8UkxNEQBbyvmZdlCw4pQHwLTWJBnsCNPMM1/nY71ACoV26TBroTJn/6mPfuOMUzSMjinO0DXxwKBRZWRxKF6mllvcJuLsNVpZxwcHyi3Oh53q3KexBDI4Z/yknVyVdhyWt5yXrarKlU8TZllrj4MPuv8fPQAtV/m796On35Andz8hC+uoUQWGPDVTpvVWMZQ3dSmI4rz7gGT/FZ2+5mGbsR3c/sA+BUc+DWRkx8KWisfD5xb2ZPxpClPEHEQeWodRDAV8uW23HpYE/HBDwaAOHNNHcJdquwnIVk+1DJtlS2vMBB0PB9eDfMZpvt8E+/PHzZ1ebQ==
Received: from CH3PR11MB8187.namprd11.prod.outlook.com (2603:10b6:610:160::18)
 by PH7PR11MB7145.namprd11.prod.outlook.com (2603:10b6:510:1ec::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.10; Fri, 23 Feb
 2024 09:27:27 +0000
Received: from CH3PR11MB8187.namprd11.prod.outlook.com
 ([fe80::782f:376b:1779:f4a3]) by CH3PR11MB8187.namprd11.prod.outlook.com
 ([fe80::782f:376b:1779:f4a3%4]) with mapi id 15.20.7339.009; Fri, 23 Feb 2024
 09:27:26 +0000
From: <Balakrishnan.S@microchip.com>
To: <robh@kernel.org>
CC: <claudiu.beznea@tuxon.dev>, <lgirdwood@gmail.com>, <broonie@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: sound:atmel-at91sam9g20ek: convert bindings
 to json-schema
Thread-Topic: [PATCH] dt-bindings: sound:atmel-at91sam9g20ek: convert bindings
 to json-schema
Thread-Index: AQHaXxCvY0Si5P98XEeva7vRTMxkh7EJ3Z8AgA3ZVAA=
Date: Fri, 23 Feb 2024 09:27:26 +0000
Message-ID: <62a9f501-64de-47f6-9d0f-f1b48df6e5e6@microchip.com>
References: <20240214-at91sam9g20ek-wm8731-yaml-v1-1-33333e17383b@microchip.com>
 <20240214135824.GA692740-robh@kernel.org>
In-Reply-To: <20240214135824.GA692740-robh@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB8187:EE_|PH7PR11MB7145:EE_
x-ms-office365-filtering-correlation-id: 6ce28e9f-bb7f-4818-4fdb-08dc3451a668
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LP1F1amEsw8p9vVWUPH6MJc485XfMzi5dBn9iS3kLYyXzqeQ8bxBnQCG0/JZ+w7+hChdWNZjW244kEU/Rx+OASGsmgLZZqY3/SrnMLkcKf8YYJgn9NO48ZSPy3SUJCIsZZ12qFVxtlYhsgTBynl/MM27EAJqrQk7JbwqGXm3rOJvHfC7539TKvhVqQ5PwejIXyFaz+Gu1jhcn5k1UNdW/ROLi0i3slsNj2EkvTn9v4QAKK8mWO6WqFw3w4VxzPFAaHmFCZNvSqlM4+xvKWu5M1XNwgmZZ+ITPRq8DGTgmKgdsCWXpWhxv2mLbeu1K++i5aT9vnEqP2X16EPEMl1GYjFniNIy3eyqTKeShm85y59B0OvaqDAjBkLA9nkogVFZKuO+XtE3QaIj4XzR5PBQJO4CZRmkhq4HJQ1wXkb3uzfnNSb/9sb+KeeSsKodcpgkOvoqafqAZVxyyeTe4KwIEyD3JlDfeTk4Y64McFhJxLHk6KhZJIgGl+vJaEejEXvllbjVqiw3nONJfA0xUzBHf8xAGrlupvym9Vuqk3RvCSn8cwfffLon1zV8sRIusVKvcNZX4aMb2uoy64dSR5eN1OC0nWGiZZZMKgQ/7baxsGc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8187.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(230273577357003)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?azYyK0ZwQTA2dEZzSnZHMWJyS0xDcWlzL1RZbzRSVy9uK1l4bTlGK0Y1WWda?=
 =?utf-8?B?cTdCSUV4V1lxOTVicERBRTJUZjBuNVl1cUp4ZEk4NFdKREN6V2JxUTNrK0xF?=
 =?utf-8?B?MU9RazhHUDVMalJma09FbmFXcWxYR0hNcWw1Z1FGQlJmblF6VjVsc3BOaGhD?=
 =?utf-8?B?TURLalZiaGV2SFRPZGhjV1B4V3ByNlNlRzl4VFZUWkp0N0FNTDlKL0hGZTY0?=
 =?utf-8?B?Vm9iWjV0WGpFK3Jnd05FK2xuYm1iTHlCNHQ5ZFRaVHhsWVBYRjJFR2dVT1VR?=
 =?utf-8?B?QTdXQTM4NmpoeGdxVkhaWE1FYVBsem5FVVRybndURUJKT2J2a3paMnZKM3hj?=
 =?utf-8?B?eE5PUE5xUVZSaU50QmNmSWJrajdCNzY4c2hXU2YzSUw4TXdVRUNCS3ZHMXow?=
 =?utf-8?B?WG9jZGIrOXRUcGxIOE1KZlptTVFYb3NpSUpQUDB5a3V6VXNvMGRqS1hEa0xW?=
 =?utf-8?B?RFJENmRvaWd2b0taZ21CaFJvaFNoUWVvOVk2VG1CN2grRWZucm1hVlpzdUU5?=
 =?utf-8?B?cWNtd2xYK0h1T1hsb1F5NEdCbFpHamRCYkl3RlUyL2ZndkZ2Q2tkM2liT2Ny?=
 =?utf-8?B?VXhqUHBXaWdNVVRtN2ZsTTViMGNqc0lOOFh4bWJqanBIMFpEVXFISUd1angv?=
 =?utf-8?B?ZHh2YTFjS1R3ZkN1bDVaTS95ME9RUklMZmVFY1VxMHQ4OC9nQ21yN2hrVGxy?=
 =?utf-8?B?eDRCbk9wOE5xSlJwT2EraWxnVExSc0t5QUpiWVZqVld6K1FjczJBMlNNTFBx?=
 =?utf-8?B?MzJlQ29HU2x2TnNSVlFSUFJPUTF3UVpXSzVtTmF1WXMyNFFqcThzaTFUVVJP?=
 =?utf-8?B?aS95cTRCLzZORWhrOWR0RjgveFJ6M21UOENRR3NoNFVaU3prRjNqSC9Pc0pV?=
 =?utf-8?B?QjNkaVUwWVA1QXBuSTY2cUEwVlZEOXVvejZvRnVNTG1WR1ZoRCt2Z1dmbjAy?=
 =?utf-8?B?cFlDUEI0b2hWcFA4Q3BKeG9wTk5VOVRlNENOdWdCRHE1WVNiYkp0YVp4SWRl?=
 =?utf-8?B?cnVXdTBsVXd5eHEvTXJGYkYrN0RENUxnYk9veVFWVFFVZzFhbGg5Titha2Ji?=
 =?utf-8?B?Vk4rMTQ0azB6a1lYU0FEZCtzUXZqY2VRd0E0NnRLcGtuQU9OYWxsZDdWdkd5?=
 =?utf-8?B?b2R6Q0l2VnR0SytjZWhubFFBOGUzZmNnTkkvWmhtMXFQWGh5SllIS3dqSXlr?=
 =?utf-8?B?RDZ4VUJpUGQ5TnExbHBzRTR3TEtZU1N4bkJMTzAvU3VvWStjODM1VSt2dk9T?=
 =?utf-8?B?bVVjNnAzVHJyRStoOUlScE82VVNUUFJxV0RyNE16RGZLYXYxVTZoMkc4cDJy?=
 =?utf-8?B?NDF6U2VZUmpnY0VaZEFxb1lCNU1JMi9aYWNBUGRiUXJIdmEwUDJmUU5iTG5L?=
 =?utf-8?B?dHlYSlRncTRpNlo5SjVrQUZzY1kyM1l5RWhocEhOYzhQRlFNL00rT2QrQlU3?=
 =?utf-8?B?ejZGR29rRW5YYjQ0VGFxTmZ1WVlsc3JzakRHTUFFWFprRlE0dVlscUd6UzRV?=
 =?utf-8?B?VTA5WWhhRE9QVkxLRUZGQ3hQNmlWMDNoVzVKQ2l4aytYR3NoSXc4TXJEeVAz?=
 =?utf-8?B?dnBRaHRoU3BoN21MYmJvaFBDQVNQUzN5WFlScHIxTGpnK252NGZyTXNDYnA4?=
 =?utf-8?B?WWdGbVNFWUNGbms3ZHU5WWtXaFdEM2xlaUtXZkg3dWVDNGxVSFdxL1dnNkZK?=
 =?utf-8?B?VEFpY1VVNXA5eWRHcTlZa0xrTEwrSERDTWpwT3M1OWJsbUN6VWk0L0FmZnZi?=
 =?utf-8?B?OHBYQ09SRE9PUDF1RDRmeHRaVzlKcnE2SmU3dysxZGNXSTFlbzdFQ0ZFQUZ3?=
 =?utf-8?B?RVZ2Y0ZpdlJMaUdyT1pWeE04TFpTSnBMRW5Kb05LLzhsKzE0NXF6MXlHQjdE?=
 =?utf-8?B?MHJCd2tTV05YbGpwTHZ1TUV1eTZUYnFoTEh3aHo5cDBxeHlZVFRKTzNBNXVi?=
 =?utf-8?B?bzBjS2N0TG81MXhGbVhyV2N0MDBIWDJVMUFaVEN4YmVDL0JxY1BPc05WS0VT?=
 =?utf-8?B?MWZoNWFxUzg2cVNXS0Z1Slk0alZvWEJ1OFdQQVREdkM3Y1NoQThYMlZSNkU0?=
 =?utf-8?B?SElLeG9pcDI5MFU2eUtHMWdsVHdzVkE3UjYzayt4aWhIMldEKytPUVNKSjdP?=
 =?utf-8?B?U2tWMFJhRS9RTDlIaVhvenk5MVhBbzJPMlNKNit0Z3dZWTZkUUJCT2FxMlRp?=
 =?utf-8?B?ZUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EAB313B1B84B1544BEB94BBCA06275D9@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8187.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ce28e9f-bb7f-4818-4fdb-08dc3451a668
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2024 09:27:26.7995
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W8V65kznRHMbFOkTdcHrHYAZ9Iu7pe++r+ZGCppisY649hRE6QkSeyG8+pMZhFIu0BUnhZkZjN3tJhKyS01q2KU8LfS4NEHBqXed/tlU96I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7145

SGkgUm9iLA0KDQpPbiAxNC8wMi8yNCA3OjI4IHBtLCBSb2IgSGVycmluZyB3cm90ZToNCj4gRVhU
RVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVz
cyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiBXZWQsIEZlYiAxNCwgMjAy
NCBhdCAxMjoxMDowNlBNICswNTMwLCBCYWxha3Jpc2huYW4gU2FtYmF0aCB3cm90ZToNCj4+IENv
bnZlcnQgYXRtZWwtYXQ5MXNhbTlnMjBlay13bTg3MzEtYXVkaW8gRFQgYmluZGluZyB0byB5YW1s
DQo+PiBiYXNlZCBqc29uLXNjaGVtYS5DaGFuZ2UgZmlsZSBuYW1lIHRvIG1hdGNoIGpzb24tc2No
ZW1lIG5hbWluZy4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBCYWxha3Jpc2huYW4gU2FtYmF0aCA8
YmFsYWtyaXNobmFuLnNAbWljcm9jaGlwLmNvbT4NCj4+IC0tLQ0KPj4gICAuLi4vYmluZGluZ3Mv
c291bmQvYXRtZWwsYXQ5MXNhbTlnMjBlay13bTg3MzEueWFtbCB8IDYwICsrKysrKysrKysrKysr
KysrKysrKysNCj4+ICAgLi4uL3NvdW5kL2F0bWVsLWF0OTFzYW05ZzIwZWstd204NzMxLWF1ZGlv
LnR4dCAgICAgfCAyNiAtLS0tLS0tLS0tDQo+PiAgIDIgZmlsZXMgY2hhbmdlZCwgNjAgaW5zZXJ0
aW9ucygrKSwgMjYgZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9zb3VuZC9hdG1lbCxhdDkxc2FtOWcyMGVrLXdtODczMS55
YW1sIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NvdW5kL2F0bWVsLGF0OTFz
YW05ZzIwZWstd204NzMxLnlhbWwNCj4+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+PiBpbmRleCAw
MDAwMDAwMDAwMDAuLmY2MzMwNzA3ZmUxYg0KPj4gLS0tIC9kZXYvbnVsbA0KPj4gKysrIGIvRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NvdW5kL2F0bWVsLGF0OTFzYW05ZzIwZWst
d204NzMxLnlhbWwNCj4+IEBAIC0wLDAgKzEsNjAgQEANCj4+ICsjIFNQRFgtTGljZW5zZS1JZGVu
dGlmaWVyOiAoR1BMLTIuMC1vbmx5IE9SIEJTRC0yLUNsYXVzZSkNCj4+ICslWUFNTCAxLjINCj4+
ICstLS0NCj4+ICskaWQ6IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9zY2hlbWFzL3NvdW5kL2F0bWVs
LGF0OTFzYW05ZzIwZWstd204NzMxLnlhbWwjDQo+PiArJHNjaGVtYTogaHR0cDovL2RldmljZXRy
ZWUub3JnL21ldGEtc2NoZW1hcy9jb3JlLnlhbWwjDQo+PiArDQo+PiArdGl0bGU6IEF0bWVsIGF0
OTFzYW05ZzIwZWsgd204NzMxIGF1ZGlvIGNvbXBsZXgNCj4+ICsNCj4+ICttYWludGFpbmVyczoN
Cj4+ICsgIC0gQmFsYWtyaXNobmFuIFNhbWJhdGggPGJhbGFrcmlzaG5hbi5zQG1pY3JvY2hpcC5j
b20+DQo+PiArDQo+PiArcHJvcGVydGllczoNCj4+ICsgIGNvbXBhdGlibGU6DQo+PiArICAgIGNv
bnN0OiBhdG1lbCxhdDkxc2FtOWcyMGVrLXdtODczMS1hdWRpbw0KPj4gKw0KPj4gKyAgYXRtZWws
bW9kZWw6DQo+PiArICAgICRyZWY6IC9zY2hlbWFzL3R5cGVzLnlhbWwjL2RlZmluaXRpb25zL3N0
cmluZw0KPj4gKyAgICBkZXNjcmlwdGlvbjogVGhlIHVzZXItdmlzaWJsZSBuYW1lIG9mIHRoaXMg
c291bmQgY29tcGxleC4NCj4gDQo+IGJsYW5rIGxpbmUgYmV0d2VlbiBEVCBwcm9wZXJ0aWVzDQo+
IA0Kc3VyZSwgdGhhbmtzIGZvciBwb2ludGluZyBpdCBvdXQuIEknbGwgZml4IHRoaXMgaW4gdjIN
Cj4+ICsgIGF0bWVsLGF1ZGlvLXJvdXRpbmc6DQo+PiArICAgICRyZWY6IC9zY2hlbWFzL3R5cGVz
LnlhbWwjL2RlZmluaXRpb25zL25vbi11bmlxdWUtc3RyaW5nLWFycmF5DQo+PiArICAgIGRlc2Ny
aXB0aW9uOiBBIGxpc3Qgb2YgdGhlIGNvbm5lY3Rpb25zIGJldHdlZW4gYXVkaW8gY29tcG9uZW50
cy4NCj4+ICsgICAgbWluSXRlbXM6IDINCj4gDQo+IE5vIG1heD8NCj4gDQoNCkhlcmUsIHRoZXJl
J3Mgbm8gZXhwbGljaXQgY29uc3RyYWludCBvbiB0aGUgbWF4aW11bSBudW1iZXIgb2YgaXRlbXMs
IHNvIA0KSSBvbmx5IGVuZm9yY2VkIG1pbkl0ZW1zLiBQbGVhc2UgbGV0IG1lIGtub3cgaWYgSSdt
IGRvaW5nIHNvbWV0aGluZyB3cm9uZy4NCg0KPj4gKyAgICBpdGVtczoNCj4+ICsgICAgICBlbnVt
Og0KPj4gKyAgICAgICAgIyBCb2FyZCBDb25uZWN0b3JzDQo+PiArICAgICAgICAtICJFeHQgU3Br
Ig0KPj4gKyAgICAgICAgLSAiSW50IE1JQyINCj4+ICsNCj4+ICsgICAgICAgICMgQ09ERUMgUGlu
cw0KPj4gKyAgICAgICAgLSBMSFBPVVQNCj4+ICsgICAgICAgIC0gTUlDSU4NCj4+ICsgIGF0bWVs
LHNzYy1jb250cm9sbGVyOg0KPj4gKyAgICAkcmVmOiAvc2NoZW1hcy90eXBlcy55YW1sIy9kZWZp
bml0aW9ucy9waGFuZGxlDQo+PiArICAgIGRlc2NyaXB0aW9uOiBUaGUgcGhhbmRsZSBvZiB0aGUg
U1NDIGNvbnRyb2xsZXINCj4+ICsgIGF0bWVsLGF1ZGlvLWNvZGVjOg0KPj4gKyAgICAkcmVmOiAv
c2NoZW1hcy90eXBlcy55YW1sIy9kZWZpbml0aW9ucy9waGFuZGxlDQo+PiArICAgIGRlc2NyaXB0
aW9uOiBUaGUgcGhhbmRsZSBvZiBXTTg3MzEgYXVkaW8gY29kZWMNCj4+ICsNCj4+ICtyZXF1aXJl
ZDoNCj4+ICsgIC0gY29tcGF0aWJsZQ0KPj4gKyAgLSBhdG1lbCxtb2RlbA0KPj4gKyAgLSBhdG1l
bCxhdWRpby1yb3V0aW5nDQo+PiArICAtIGF0bWVsLHNzYy1jb250cm9sbGVyDQo+PiArICAtIGF0
bWVsLGF1ZGlvLWNvZGVjDQo+PiArDQo+PiArYWRkaXRpb25hbFByb3BlcnRpZXM6IGZhbHNlDQo+
PiArDQo+PiArZXhhbXBsZXM6DQo+PiArICAtIHwNCj4+ICsgICAgc291bmQgew0KPj4gKyAgICAg
ICAgY29tcGF0aWJsZSA9ICJhdG1lbCxhdDkxc2FtOWcyMGVrLXdtODczMS1hdWRpbyI7DQo+PiAr
ICAgICAgICBwaW5jdHJsLW5hbWVzID0gImRlZmF1bHQiOw0KPj4gKyAgICAgICAgcGluY3RybC0w
ID0gPCZwaW5jdHJsX3BjazBfYXNfbWNrPjsNCj4+ICsgICAgICAgIGF0bWVsLG1vZGVsID0gIndt
ODczMSBAIEFUOTFTQU1HMjBFSyI7DQo+PiArICAgICAgICBhdG1lbCxhdWRpby1yb3V0aW5nID0N
Cj4+ICsgICAgICAgICAgICAiRXh0IFNwayIsICJMSFBPVVQiLA0KPj4gKyAgICAgICAgICAgICJJ
bnQgTUlDIiwgIk1JQ0lOIjsNCj4+ICsgICAgICAgIGF0bWVsLHNzYy1jb250cm9sbGVyID0gPCZz
c2MwPjsNCj4+ICsgICAgICAgIGF0bWVsLGF1ZGlvLWNvZGVjID0gPCZ3bTg3MzE+Ow0KPj4gKyAg
ICB9Ow0KDQotLSANCkJlc3QgcmVnYXJkcywNCkJhbGFrcmlzaG5hbiBTDQoNCg==

