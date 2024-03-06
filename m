Return-Path: <linux-kernel+bounces-93394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B943872F1D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 07:56:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C185228B3F0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 06:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4CE35C022;
	Wed,  6 Mar 2024 06:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="AqKSlmqi";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="DMU2XO76"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09B31772F;
	Wed,  6 Mar 2024 06:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.153.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709708167; cv=fail; b=D8Xgveibmh3BbR4Ch1fSEVI8Z3VRjs9J7h8xyhTzskiM22XYqxZcA5REI6aLxrWE57Rqp8LB+VkVn2+brgYJPWJwI49B8jHZ3PDNz4fOOnTR3LiihDAhdTAAW2V8JYUDTnmJ64ysRLg1MtJ8BizWf2sUEKUUAvcag3orv8HKekE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709708167; c=relaxed/simple;
	bh=9qsVXvZ5JjPJGTs4oEX4uPo/jsBgpRF1VbKWpC/EjPU=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VQExnyJGCnUQIqMU/QEVCY3gHodvGMXJ/tDxp1CbpgeL2aB5tygt8yUsV4Be+coD9U3dS+vdFVL138nDWzAAO+ZKRF5wCZLr6mL58ykcKe2zW3jzW+dPAdmKFiXTs95srXyjDciSZqeDkqVLl9LFqP/gHmYNh50xhDxinlaQ23c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=AqKSlmqi; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=DMU2XO76; arc=fail smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1709708164; x=1741244164;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=9qsVXvZ5JjPJGTs4oEX4uPo/jsBgpRF1VbKWpC/EjPU=;
  b=AqKSlmqi9tlRPKUU0rfKV52O7GnZrm3TzVa362ITCNpqMAFai0zvoOUU
   wbrYvz9KVQLgNMXkcUqWTUB56PPnXdbUWUCpglRz7NUPSBw5PLHQC673K
   +1gi9B03j9n7xLO6iU6R6iqoLb8GNwYMBtJ2UMQJNhAotOeEDy/jQEbQa
   K7Pyc3mMrtw++MGp9o7kfLCfZt7xJZvIKQsI6kAYQq4RrboVEX7jKzENH
   YxpFbrbnSqjpv26/lTPLpoqAjEdqEXDhD4ZqtrDoaO2Jb5ACmTwCREc8Z
   MIo1PkS4KgqyuFH1zb883npgMqUuZtteD/A/8NpYG/12z3GGxxRhRkA0l
   A==;
X-CSE-ConnectionGUID: RD61MaVnSSqpkMTLHUaaNA==
X-CSE-MsgGUID: +C+e01eOR72TwEKOtmbXag==
X-IronPort-AV: E=Sophos;i="6.06,207,1705388400"; 
   d="scan'208";a="18911473"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Mar 2024 23:56:02 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Mar 2024 23:55:46 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 5 Mar 2024 23:55:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UxyC3iWFCve34R9RhDk5aZtTspCqddZgYTVtFW4LkaygtcFsqtNirtDfrHaRCzLypmeloQyP+lbP0dJS2XHbA4GgBxV8jVdEqhs/nxQTQ//YL9725oeDJzvhhw5XpH/u4AOWHq8rYd4fczcugtzAKapPaurkHk5L6BuNJnO7DGG5aBuoqvCpAA6YzfAJKZUdHA5KLH51AcjZ8TP7UbEhLAi5evIk0NndodiiZcWDSNMvGyGJ6S/DrIDhpZtmcMH4Lk+8/RdUtFrfhbHuWpg6fEqw9yPOs435pa8joq8P1XN5YRxT9TUrz3kdci4FlTBg3Vh4HXxrXzK1+8MX7A3dGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9qsVXvZ5JjPJGTs4oEX4uPo/jsBgpRF1VbKWpC/EjPU=;
 b=hZvcXIT8eWvyPaBDuHOkg50hwe8cP7oBsx9Ho32i2siYENmL5lZEMPgQ2kLIMWecgRkGnqk0NnDUSk/HXoSdonclPk4GjSNJndMZZJVvBMWPGjiCuXBJvieNQacnESgNdPJygzYH36bCr3yJ9X9Rfnu6hMlETdFKJc1dQUadlLcb2XSdy8r/6MEIxApx5xIJWSp2PzTuATQiXTvQk9RqdOIdnhkle9MixZa6nXps6vGTzEqsj/Y1KkhVvnUbro530Iq9gTFaBJndrWvmmmS2k87u9rZXOcJ9Ys7a8mNSk8BoHh4ZhQEdL6dvXQN+dV7ULdgOiFrv6vN7DRVMdcOO5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9qsVXvZ5JjPJGTs4oEX4uPo/jsBgpRF1VbKWpC/EjPU=;
 b=DMU2XO76JqHvrjJevW+T+gRIZBFNKmSaLn7j1+YCMYeVfdQGXgTxJ4vKGUkOuqW0bE84S7GSSKytvuOJcby5IJJyhoVJf7l7iAVTZPE0LN+nHa6t28pC68Up9vv2b8/lragBc8W5MS451CSXpXZvePse37mrlNHqwEx6buRCDrNuQkGcecGPNJKBFYU2JIeypxSIpohPJtPjUQGMChzaklyEev+xsSNPQs5wZp3jF95CVZ6KMe6sp6F+PR+DGEu3CNV9ZQRT9exCJi09r+kJv2JKsCQ0cz3JwaTfhXBWSg5ZLC6loErM25UASCsv1d1Lj9MLL0ZlGrDdztBxKlEaOg==
Received: from DS0PR11MB7481.namprd11.prod.outlook.com (2603:10b6:8:14b::16)
 by PH8PR11MB8063.namprd11.prod.outlook.com (2603:10b6:510:252::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.23; Wed, 6 Mar
 2024 06:55:44 +0000
Received: from DS0PR11MB7481.namprd11.prod.outlook.com
 ([fe80::29:ed7f:de5a:55bb]) by DS0PR11MB7481.namprd11.prod.outlook.com
 ([fe80::29:ed7f:de5a:55bb%6]) with mapi id 15.20.7362.019; Wed, 6 Mar 2024
 06:55:44 +0000
From: <Rengarajan.S@microchip.com>
To: <jirislaby@kernel.org>, <linux-serial@vger.kernel.org>,
	<gregkh@linuxfoundation.org>, <Kumaravel.Thiagarajan@microchip.com>,
	<UNGLinuxDriver@microchip.com>, <Tharunkumar.Pasumarthi@microchip.com>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 tty] 8250: microchip: pci1xxxx: Refactor TX Burst code
 to use pre-existing APIs
Thread-Topic: [PATCH v1 tty] 8250: microchip: pci1xxxx: Refactor TX Burst code
 to use pre-existing APIs
Thread-Index: AQHaZZZL0nj0fFzSz0iXzZOI5AQ+c7EXclSAgAA2nwCAAACkAIAPZ0qAgAAbsICAAXCsAIAAMoCAgAGMfoA=
Date: Wed, 6 Mar 2024 06:55:44 +0000
Message-ID: <7e34da3866ee8a66a11ea44fea1cf83fe5bd2afd.camel@microchip.com>
References: <20240222134944.1131952-1-rengarajan.s@microchip.com>
	 <5bf4ba6d-d8e3-4ba6-a889-cfae8c3ddabe@kernel.org>
	 <e93048e64c3f8aa2731575d4b296c473e8dadb82.camel@microchip.com>
	 <254db026-5f9d-497f-ac44-c81d9d5947cf@kernel.org>
	 <53dd0d89466f0f06dfd2d63ab1ff29462a09aabb.camel@microchip.com>
	 <e8b49c34-90a1-4610-b7cd-8eff1b1a312a@kernel.org>
	 <f3b627f1d03c8db3d09f56a836e8733004b2287b.camel@microchip.com>
	 <1cc70895-b520-4dde-971e-692041dfbcce@kernel.org>
In-Reply-To: <1cc70895-b520-4dde-971e-692041dfbcce@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7481:EE_|PH8PR11MB8063:EE_
x-ms-office365-filtering-correlation-id: f3ec8fd8-8101-42fe-e32b-08dc3daa71c0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P/0WHZG72xr4Pso/0b6HB9ILYotm14q6XWI2ZwoHBtPYxRKTNrtlFOsySle+9ZVFUJO1zD3NC2hifZ7FIiw1+vtmQwxvYBLb3fIfL2ET7GrJsi8VDot0rsVKwFijdo8/3jdofD1uU/g5g2wLcslfsQcyWlh26kfLba4BgF+ahsI7Mq2VX852I0KUTvvOvT3SQI/YO65ZaBI4+JguIJR4pjujWsIP5I5b68XWLerUI08rNyIsn3L+QCT4yk4xY2B4Q81nxyddkUZeKamsuemixYKfAai4SxPdW8GQEHrumWnGRcix/2vNMWRfix432D7bTmnZLKnz74Fym1jlSkxr+u4nkWRQ0KhmHa7ZVj5T1D1f0GpDaSyq/gYyemZILrdEzaVv7DEF8FvQ1j7F7mOHqstYeLvfMpfhtsc/2eU4TZhSWtI7lGZ34tPxVF2K0WR1s3PcHEEonjJimNqFBQeAtqdQ+EZvLzr0wIWtvJ4KruLa5wq/hBYgx3SF0rfKLVGdT6Gynxn3fkZR0TPpCfkvUb4DtjgzmFFjN+Pbo11/OY1xB+LgtW42Di27uEs4rMHECh/VZiswBn1SjFrRf8wUm6KxN1m8DgVQdFxSXkzPB/WY5Lm+UXepweqwk0mJpVHI8vO5HTiqM5GQwu3cTyt9wAWHvkY4Z0Hu/t7+KG2B+FI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7481.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eDJaaFRkUDJMVnpYWW1QYmVOTjg0L2lHaG03MThqUDdhWDUvanJxNGV5cTQr?=
 =?utf-8?B?TWZ6dEpyWUgrcXFLT1B2WUZFS3JXbG1yZjRkQWdIaXpmTXdnN0hjc3dQUE9M?=
 =?utf-8?B?SGYvV01ydlFRTWRZbExEd1FRM1U4OE9Ia0JyYnpCZkNpbnhISlZuYllDTkpt?=
 =?utf-8?B?ZTY4dGhiQmR1cFAwZDVaemtEak9LZWJLSFBwclJxYjlxTUZnTmx1ZWRFMmxy?=
 =?utf-8?B?bmlpaFFEWnIxMjlCUGF3cXBqZ0FyZEtXaG85QTdXQWhMZGpjZGFMMEE1UFlk?=
 =?utf-8?B?ZUlCdkVGSjdLa1BZY0JLcDMrTk1rTzdwOG5HOGNJNXpwTEdRdlp0SUgzbnI5?=
 =?utf-8?B?YzZyVWpDZnVIRWx2cDBFd1c0WkNCdkp3ZzlRa3VzS25ZTXlFNGNGVzVqZStR?=
 =?utf-8?B?di9ZU2FMSU9mS2NQYjd2U3ZMenlsN2RjcjlrVDdZMmZxMXJvT3o1aG5kd1ZJ?=
 =?utf-8?B?UUtYaXhMOU95RkErQnF0Qm1xNVFFV1Z3TGZuaUFXUHRQTFpQZXRLT2w5WTY1?=
 =?utf-8?B?NmtTV3pScTQ0ZUpFVmc2QWlObTFQWXV4R3B3NVI4U0czdDU1RkZydUVySUht?=
 =?utf-8?B?RFdRZXowa2ZXSmltSHVlNGRJK093VW1KNjBUdnhPdTJNQi9KOUZjL3A4QSs0?=
 =?utf-8?B?dXpsQnZkd0dRVjAzR2RDMjlzRHlzak9jckcwcHJtTUxkei9iMm12SFlyM2FK?=
 =?utf-8?B?dEdWdmF3RVFHYlBBd3Z6WWJUYUFwSzdqZ1NEUmU2T1Z6QzY2SGtpanB1dGcr?=
 =?utf-8?B?ZmhzYkdEMlQxdVFxYW5PRzZFTnFOSnJxemV1d0xCcjBWZDVkc211VGRhTVVs?=
 =?utf-8?B?aFVYcFNTOWl6U1M2V1Y2ampIY1FVTEFrRE9Rd1A0bWQzbnk1RGNwN2IzNFhs?=
 =?utf-8?B?ak5pc1ZWMGlGdmlOZVVNU1pWZVlkV0Z2d3NGU2lCMkxkMUcyZUxRN2owcFFD?=
 =?utf-8?B?UU5yZTFEQVJiOWYzdnlraG0xY3NrQkttbWovQXdzRWVFQkwwNTU4c1l5blZL?=
 =?utf-8?B?MmkzNGxBZ0NDMlRwaWswaEVQVVJGdjVWRStTcFVtc3Y1MldOSDFKbHVHRXpm?=
 =?utf-8?B?T3JLVEdxa2VnWnRpM3BSV2NEdW5DTVBZa3YyeXpvN3NobHJkL29EaTkxVDJP?=
 =?utf-8?B?eFJPck1nU3ZhN0szZWRJRXF4UXZQblZ0MzJNTjJ0YVFOR2VnL3lCaTFCYjVw?=
 =?utf-8?B?QWpBeHRvb0doZ1lvamRtdTVBSmF1akJzTjJkdGh5c3VjS2xVMUcrVGhzeFk0?=
 =?utf-8?B?cHdyaURMZjQvMElIWVNpVm01VnNMcGRzOUwrdU1yMkQycy9FRUUrMnUzWmZW?=
 =?utf-8?B?OUxhNTl4NlptUFNnTld1QTFFdi9tcC9aZ1VyVXVSdXJlV1VlMTJtd29LazMy?=
 =?utf-8?B?azVVcnZmb1g2U2dvSUZUYWdTYWdxTlAvMUNzRU9PY01DNFMxZ2F0dVd2T2ps?=
 =?utf-8?B?cWFxRlB0bElleVlQUm9SOE9ZMEpiTmMzNzNvWHAwVmZsT0R6QzlCVm11ZUFj?=
 =?utf-8?B?dWJvNmFHWUFHdkN4SzVoTGIzdUM2UlErTENrZ1Z2THA4MDgreGpRN0NSa29v?=
 =?utf-8?B?QktjRGpxazlsU2ZHTE90eDhPQUpMQ004OXFnamV1bnZzSVdkL0pNa00wRHV2?=
 =?utf-8?B?UGZpOWdxeDZuY0pTWDZVNEpvQ0UvbVZDUzJaK0xsdFRySGthSzFrcWk2S0Jx?=
 =?utf-8?B?ZkZPaWdLcEJJWW9mdlo2WUtRczg2K3QyUzRWa2RBdk82bS9Lay9aMXFKVE5r?=
 =?utf-8?B?NHhZUDJsbHVucE5ic05KVUpGVnFCa08ybnRwYUJ5ZXRoMW4wSzU5UUh4NlB5?=
 =?utf-8?B?N0Z0c1F1WGgra0sxRE9seFFEVjROWEVMU2xMTWhmY3NxY1VkRWFZMDFsa3Qw?=
 =?utf-8?B?Mk0rbTVqOVJJR3Bqc3J1ZGx2c01xd0xlSmJTQ2FWN0VTUVVkM0JwNUdWVDVy?=
 =?utf-8?B?RVUrYmV3RzZNSHBJOW90TUlhUThVU2F4UnQweGdtdk5zaWxaVWk2KzhrVGh0?=
 =?utf-8?B?TFFqMVk5TUczczdoZXpNVkxLSlhZSlVhaE83d2lzZk53ZjhBbExQcmdsTXBm?=
 =?utf-8?B?S1R2Q3FJcUd0TVkvay9uRE8wNVltd0V4UlM0aTZxQXFyTC8rUWlvZVNyZDBk?=
 =?utf-8?B?aDF2NFowN0FQMXU1YnkwT1RQaDVPZGdtd2JFY2UwTUhmZEdGaEZvb2xRRmUz?=
 =?utf-8?B?Z0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B0B241D147B5EE42865B9810C58A4EE0@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7481.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3ec8fd8-8101-42fe-e32b-08dc3daa71c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2024 06:55:44.1620
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RiUAKOYXN6MNMsNEQ8F7DeS6lrh5qh7HjQ+ASJTsl4j0U0Hp2FZneWpkq0S5BlneFvQ3fkk8q2q3nXx/sEw/TLQbfUouMOacG/uDiAYizlI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8063

SGkgSmlyaSwNCg0KT24gVHVlLCAyMDI0LTAzLTA1IGF0IDA4OjE5ICswMTAwLCBKaXJpIFNsYWJ5
IHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0
YWNobWVudHMgdW5sZXNzIHlvdQ0KPiBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IE9u
IDA1LiAwMy4gMjQsIDU6MTUsIFJlbmdhcmFqYW4uU0BtaWNyb2NoaXAuY29twqB3cm90ZToNCj4g
PiBIaSBKaXJpLA0KPiA+IA0KPiA+IE9uIE1vbiwgMjAyNC0wMy0wNCBhdCAwNzoxOSArMDEwMCwg
SmlyaSBTbGFieSB3cm90ZToNCj4gPiA+IFtTb21lIHBlb3BsZSB3aG8gcmVjZWl2ZWQgdGhpcyBt
ZXNzYWdlIGRvbid0IG9mdGVuIGdldCBlbWFpbCBmcm9tDQo+ID4gPiBqaXJpc2xhYnlAa2VybmVs
Lm9yZy4gTGVhcm4gd2h5IHRoaXMgaXMgaW1wb3J0YW50IGF0DQo+ID4gPiBodHRwczovL2FrYS5t
cy9MZWFybkFib3V0U2VuZGVySWRlbnRpZmljYXRpb27CoF0NCj4gPiA+IA0KPiA+ID4gRVhURVJO
QUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5
b3UNCj4gPiA+IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiA+ID4gDQo+ID4gPiBPbiAwNC4g
MDMuIDI0LCA1OjM3LCBSZW5nYXJhamFuLlNAbWljcm9jaGlwLmNvbcKgd3JvdGU6DQo+ID4gPiA+
IEhpIEppcmksDQo+ID4gPiA+IA0KPiA+ID4gPiBPbiBGcmksIDIwMjQtMDItMjMgYXQgMTA6MjYg
KzAxMDAsIEppcmkgU2xhYnkgd3JvdGU6DQo+ID4gPiA+ID4gRVhURVJOQUwgRU1BSUw6IERvIG5v
dCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcw0KPiA+ID4gPiA+IHlvdQ0K
PiA+ID4gPiA+IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+
IE9uIDIzLiAwMi4gMjQsIDEwOjIxLCBSZW5nYXJhamFuLlNAbWljcm9jaGlwLmNvbcKgd3JvdGU6
DQo+ID4gPiA+ID4gPiBPbiBGcmksIDIwMjQtMDItMjMgYXQgMDc6MDggKzAxMDAsIEppcmkgU2xh
Ynkgd3JvdGU6DQo+ID4gPiA+ID4gPiA+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlu
a3Mgb3Igb3BlbiBhdHRhY2htZW50cw0KPiA+ID4gPiA+ID4gPiB1bmxlc3MNCj4gPiA+ID4gPiA+
ID4geW91DQo+ID4gPiA+ID4gPiA+IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiA+ID4gPiA+
ID4gPiANCj4gPiA+ID4gPiA+ID4gT24gMjIuIDAyLiAyNCwgMTQ6NDksIFJlbmdhcmFqYW4gUyB3
cm90ZToNCj4gPiA+ID4gPiA+ID4gPiBVcGRhdGVkIHRoZSBUWCBCdXJzdCBpbXBsZW1lbnRhdGlv
biBieSBjaGFuZ2luZyB0aGUNCj4gPiA+ID4gPiA+ID4gPiBjaXJjdWxhcg0KPiA+ID4gPiA+ID4g
PiA+IGJ1ZmZlcg0KPiA+ID4gPiA+ID4gPiA+IHByb2Nlc3Npbmcgd2l0aCB0aGUgcHJlLWV4aXN0
aW5nIEFQSXMgaW4ga2VybmVsLiBBbHNvDQo+ID4gPiA+ID4gPiA+ID4gdXBkYXRlZA0KPiA+ID4g
PiA+ID4gPiA+IGNvbmRpdGlvbmFsDQo+ID4gPiA+ID4gPiA+ID4gc3RhdGVtZW50cyBhbmQgYWxp
Z25tZW50IGlzc3VlcyBmb3IgYmV0dGVyIHJlYWRhYmlsaXR5Lg0KPiA+ID4gPiA+ID4gPiANCj4g
PiA+ID4gPiA+ID4gSGksDQo+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiBzbyB3aHkgYXJl
IHlvdSBrZWVwaW5nIHRoZSBuZXN0ZWQgZG91YmxlIGxvb3A/DQo+ID4gPiA+ID4gPiA+IA0KPiA+
ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiBIaSwgaW4gb3JkZXIgdG8gZGlmZmVyZW50aWF0ZSBCdXJz
dCBtb2RlIGhhbmRsaW5nIHdpdGggYnl0ZQ0KPiA+ID4gPiA+ID4gbW9kZQ0KPiA+ID4gPiA+ID4g
aGFkDQo+ID4gPiA+ID4gPiBzZXBlcmF0ZSBsb29wcyBmb3IgYm90aC4gU2luY2UsIGhhdmluZyBz
aW5nbGUgd2hpbGUgbG9vcA0KPiA+ID4gPiA+ID4gYWxzbw0KPiA+ID4gPiA+ID4gZG9lcw0KPiA+
ID4gPiA+ID4gbm90DQo+ID4gPiA+ID4gPiBhbGlnbiB3aXRoIHJ4IGltcGxlbWVudGF0aW9uICh3
aGVyZSB3ZSBoYXZlIHNlcGVyYXRlDQo+ID4gPiA+ID4gPiBoYW5kbGluZw0KPiA+ID4gPiA+ID4g
Zm9yDQo+ID4gPiA+ID4gPiBidXJzdA0KPiA+ID4gPiA+ID4gYW5kIGJ5dGUpIGhhdmUgcmV0YWlu
ZWQgdGhlIGRvdWJsZSBsb29wLg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IFNvIG9idmlvdXNseSwg
YWxpZ24gUlggdG8gYSBzaW5nbGUgbG9vcCBpZiBwb3NzaWJsZS4gVGhlDQo+ID4gPiA+ID4gY3Vy
cmVudA0KPiA+ID4gPiA+IFRYDQo+ID4gPiA+ID4gY29kZQ0KPiA+ID4gPiA+IGlzIHZlcnkgaGFy
ZCB0byBmb2xsb3cgYW5kIHNvcnQgb2YgdW5tYWludGFpbmFibGUgKGFuZA0KPiA+ID4gPiA+IGJ1
Z2d5KS4NCj4gPiA+ID4gPiBBbmQNCj4gPiA+ID4gPiBJTU8NCj4gPiA+ID4gPiBpdCdzIHVubmVj
ZXNzYXJ5IGFzIEkgcHJvcG9zZWQgWzFdLiBBbmQgZXZlbiBpZiBSWCBjYW5ub3QgYmUNCj4gPiA+
ID4gPiBvbmUNCj4gPiA+ID4gPiBsb29wLA0KPiA+ID4gPiA+IHlvdSBzdGlsbCBjYW4gbWFrZSBU
WCBlYXN5IHRvIHJlYWQgYXMgdGhlIHR3byBuZWVkIG5vdCBiZSB0aGUNCj4gPiA+ID4gPiBzYW1l
Lg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IFsxXQ0KPiA+ID4gPiA+IGh0dHBzOi8vbG9yZS5rZXJu
ZWwub3JnL2FsbC9iODMyNWMzZi1iZjViLTRjNTUtOGRjZS1lZjM5NWVkY2UyNTFAa2VybmVsLm9y
Zy8NCj4gPiA+ID4gDQo+ID4gPiA+IA0KPiA+ID4gPiB3aGlsZSAoZGF0YV9lbXB0eV9jb3VudCkg
ew0KPiA+ID4gPiDCoMKgwqDCoCBjbnQgPSBDSVJDX0NOVF9UT19FTkQoKTsNCj4gPiA+ID4gwqDC
oMKgwqAgaWYgKCFjbnQpDQo+ID4gPiA+IMKgwqDCoMKgwqDCoCBicmVhazsNCj4gPiA+ID4gwqDC
oMKgwqAgaWYgKGNudCA8IFVBUlRfQlVSU1RfU0laRSB8fCAodGFpbCAmIDMpKSB7IC8vDQo+ID4g
PiA+IGlzX3VuYWxpZ25lZCgpDQo+ID4gPiA+IMKgwqDCoMKgwqDCoCB3cml0ZWIoKTsNCj4gPiA+
ID4gwqDCoMKgwqDCoMKgIGNudCA9IDE7DQo+ID4gPiA+IMKgwqDCoMKgIH0gZWxzZSB7DQo+ID4g
PiA+IMKgwqDCoMKgwqDCoCB3cml0ZWwoKQ0KPiA+ID4gPiDCoMKgwqDCoMKgwqAgY250ID0gVUFS
VF9CVVJTVF9TSVpFOw0KPiA+ID4gPiDCoMKgwqDCoCB9DQo+ID4gPiA+IMKgwqDCoMKgIHVhcnRf
eG1pdF9hZHZhbmNlKGNudCk7DQo+ID4gPiA+IMKgwqDCoMKgIGRhdGFfZW1wdHlfY291bnQgLT0g
Y250Ow0KPiA+ID4gPiB9DQo+ID4gPiA+IA0KPiA+ID4gPiBXaXRoIHRoZSBhYm92ZSBpbXBsZW1l
bnRhdGlvbiB3ZSBhcmUgb2JzZXJ2aW5nIHBlcmZvcm1hbmNlIGRyb3ANCj4gPiA+ID4gb2YNCj4g
PiA+ID4gMg0KPiA+ID4gPiBNYnBzIGF0IGJhdWQgcmF0ZSBvZiA0IE1icHMuIFRoZSByZWFzb24g
Zm9yIHRoaXMgaXMgdGhlIGZhY3QNCj4gPiA+ID4gdGhhdA0KPiA+ID4gPiBmb3INCj4gPiA+ID4g
ZWFjaCBpdGVyYXRpb24gd2UgYXJlIGNoZWNraW5nIGlmIHRoZSB0aGUgZGF0YSBuZWVkIHRvIGJl
DQo+ID4gPiA+IHByb2Nlc3NlZA0KPiA+ID4gPiB2aWENCj4gPiA+ID4gRFdPUkRzIG9yIEJ5dGVz
LiBUaGUgY29uZGl0aW9uIGNoZWNrIGZvciBlYWNoIGl0ZXJhdGlvbiBpcw0KPiA+ID4gPiBjYXVz
aW5nDQo+ID4gPiA+IHRoZQ0KPiA+ID4gPiBkcm9wIGluIHBlcmZvcm1hbmNlLg0KPiA+ID4gDQo+
ID4gPiBIaSwNCj4gPiA+IA0KPiA+ID4gdGhlIGNoZWNrIGlzIGJ5IHNldmVyYWwgb3JkZXJzIG9m
IG1hZ25pdHVkZSBmYXN0ZXIgdGhhbiB0aGUgSS9PDQo+ID4gPiBwcm9wZXIuDQo+ID4gPiBTbyBJ
IGRvbid0IHRoaW5rIHRoYXQncyB0aGUgcm9vdCBjYXVzZS4NCj4gPiA+IA0KPiA+ID4gPiBXaXRo
IHRoZSBwcmV2aW91cyBpbXBsZW1lbnRhdGlvbih3aXRoIG5lc3RlZCBsb29wcykgdGhlDQo+ID4g
PiA+IHBlcmZvcm1hbmNlDQo+ID4gPiA+IGlzDQo+ID4gPiA+IGZvdW5kIHRvIGJlIGFyb3VuZCA0
IE1icHMgYXQgYmF1ZCByYXRlIG9mIDQgTWJwcy4gSW4gdGhhdA0KPiA+ID4gPiBpbXBsZW1lbnRh
dGlvbiB3ZSBoYW5kbGUgc2VuZGluZyBEV09SRHMgY29udGludW9zbHkgdW50aWwgdGhlDQo+ID4g
PiA+IHRyYW5zZmVyDQo+ID4gPiA+IHNpemUgPCA0LiBDYW4geW91IGxldCB1cyBrbm93IGFueSBv
dGhlciBhbHRlcm5hdGl2ZXMgZm9yIHRoZQ0KPiA+ID4gPiBhYm92ZQ0KPiA+ID4gPiBwZXJmb3Jt
YW5jZSBkcm9wLg0KPiA+ID4gDQo+ID4gPiBDb3VsZCB5b3UgYXR0YWNoIHRoZSBwYXRjaCB5b3Ug
YXJlIHRlc3Rpbmc/DQo+ID4gDQo+ID4gUGxlYXNlIGZpbmQgdGhlIHVwZGF0ZWQgcGNpMXh4eHhf
cHJvY2Vzc193cml0ZV9kYXRhDQo+ID4gDQo+ID4gwqDCoMKgwqDCoCB1MzIgeGZlcl9jbnQ7DQo+
ID4gDQo+ID4gwqDCoMKgwqDCoMKgwqDCoCB3aGlsZSAoKnZhbGlkX2J5dGVfY291bnQpIHsNCj4g
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB4ZmVyX2NudCA9IENJUkNfQ05UX1RP
X0VORCh4bWl0LT5oZWFkLCB4bWl0LT50YWlsLA0KPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIFVBUlRfWE1JVF9TSVpFKTsNCj4gPiANCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBpZiAoIXhmZXJfY250KQ0KPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBicmVhazsNCj4gPiANCj4gPiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBpZiAoeGZlcl9jbnQgPCBVQVJUX0JVUlNUX1NJWkUgfHwgKHhtaXQt
PnRhaWwgJg0KPiA+IDMpKSB7DQo+IA0KPiBIaSwNCj4gDQo+IE9LLCBpcyBpdCBkaWZmZXJlbnQg
aWYgeW91IHJlbW92ZSB0aGUgYWxpZ25tZW50IGNoZWNraW5nICh3aGljaA0KPiBzaG91bGQNCj4g
YmUgY29ycmVjdOKEoiB0aGluZyB0byBkbywgYnV0IG1heS93aWxsIHNsb3cgZG93biB0aGluZ3Mg
b24gcGxhdGZvcm1zDQo+IHdoaWNoIGRvbid0IGNhcmUpPw0KDQpBZnRlciByZW1vdmluZyBhbGln
bm1lbnQgY2hlY2tpbmcgdGhlIHBlcmZvcm1hbmNlIGluY3JlYXNlcyBtYXJnaW5hbGx5LA0KVHJh
bnNmZXJyZWQgMTAgTUIgYXQgMjc1OTk5OSBDUFMuIEJ1dCBzdGlsbCBvYnNlcnZpbmcgaXQgaXMg
bGVzcyB0aGFuDQp0aGUgcHJldmlvdXMgaW1wbGVtZW50YXRpb24uDQoNCj4gDQo+ID4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHdyaXRlYih4bWl0LT5i
dWZbeG1pdC0+dGFpbF0sIHBvcnQtDQo+ID4gPm1lbWJhc2UgKw0KPiA+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFVBUlRfVFhf
QllURV9GSUZPKTsNCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgeGZlcl9jbnQgPSBVQVJUX0JZVEVfU0laRTsNCj4gPiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCB9IGVsc2Ugew0KPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB3cml0ZWwoKih1MzIgKikmeG1pdC0+YnVmW3htaXQtPnRh
aWxdLA0KPiANCj4gSWYgeW91IHJlbW92ZSB0aGUgInRhaWwgJiAzIiBjaGVjaywgeW91IGNhbiB1
c2UgZ2V0X3VuYWxpZ25lZCgpIGhlcmUNCj4gYW5kDQo+IG5lZWQgbm90IGNhcmUgYWJvdXQgdW5h
bGlnbmVkIGFjY2Vzc2VzIGFmdGVyIGFsbC4uLg0KDQpVc2luZyBnZXRfdW5hbGlnbmVkKCh1MzIg
KikgeG1pdCkgc2hvd3MgdGhlIHBlcmZvcm1hbmNlIGRyb3AgdG8NClRyYW5zZmVycmVkIDEwIE1C
IGF0IDE5NTk5OTkgQ1BTLg0KDQo+IA0KPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHBvcnQtPm1lbWJhc2UgKw0KPiA+IFVB
UlRfVFhfQlVSU1RfRklGTyk7DQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIHhmZXJfY250ID0gVUFSVF9CVVJTVF9TSVpFOw0KPiA+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIH0NCj4gPiANCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCB1YXJ0X3htaXRfYWR2YW5jZShwb3J0LCB4ZmVyX2NudCk7DQo+ID4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKmRhdGFfZW1wdHlfY291bnQgLT0geGZlcl9j
bnQ7DQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKnZhbGlkX2J5dGVfY291
bnQgLT0geGZlcl9jbnQ7DQo+ID4gwqDCoMKgwqDCoMKgwqDCoCB9DQo+ID4gDQo+ID4gVGVzdGlu
ZyBpcyBkb25lIHZpYSBtaW5pY29tIGJ5IHRyYW5zZmVycmluZyBhIDEwIE1CIGZpbGUgYXQgNCBN
YnBzLA0KPiA+IA0KPiA+IEFmdGVyIHRoZSBtaW5pY29tIHRyYW5zZmVyIHdpdGggc2luZ2xlIGlu
c3RhbmNlOg0KPiA+IA0KPiA+IFByZXZpb3VzIGltcGxlbWVudGF0aW9uKE5lc3RlZCBXaGlsZSBM
b29wcyk6DQo+ID4gVHJhbnNmZXJyZWQgMTAgTUIgYXQgMzkwMDAwMCBDUFMNCj4gPiANCj4gPiBD
dXJyZW50IGltcGxlbWVudGF0aW9uOg0KPiA+IFRyYW5zZmVycmVkIDEwIE1CIGF0IDI0NTk5OTkg
Q1BTDQo+IA0KPiANCj4gDQo+IC0tDQo+IGpzDQo+IHN1c2UgbGFicw0KPiANCg0K

