Return-Path: <linux-kernel+bounces-134768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5625F89B69F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 05:53:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3C0D1F211AA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 03:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 159375228;
	Mon,  8 Apr 2024 03:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="uQbiPHRS";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="LxPOdoT7"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3047462;
	Mon,  8 Apr 2024 03:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.154.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712548413; cv=fail; b=RohhpC5SC0g9QcXFYSp4hJMXAoLJEpvSpGXYviBsuhDXsqwx2WkVl0R6UOLTPnMfYw0BeOl+XSQdz9uiVy3DSsU559NScPGs8WPYR2OUzU5aR0T6OaaUnnqmj4BEPJMOrmNmGYbhSCm4a76N/TOfExq2az8s3+LzHFcizzKZDnw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712548413; c=relaxed/simple;
	bh=kxmNgxwImH/YO4m7C9lENUFlsv/J+Uu9YbIFSddIMG0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AlegHiX4kG6Cizhw7zXu4pIopD9/q8T/9b+Ps7aNpBngx1vKlz1lDxLdJt4cZk2P/1eaE7c4iLE4b12pY1vgEAlPa4P4CjY4ZqiRNEMWmgYD+fDN9ysmeMprhJejkTKEF/bR10kzZrxuNO59i7HeVy+nDTt1h8MiipbEEhlXHf8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=uQbiPHRS; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=LxPOdoT7; arc=fail smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1712548411; x=1744084411;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=kxmNgxwImH/YO4m7C9lENUFlsv/J+Uu9YbIFSddIMG0=;
  b=uQbiPHRS6eV5tc0zoX7tFU7sr0AOmfrYoXtAg4iMkYBN1PGaHYlrVSYA
   tdl2/xZ0mAmPQx+nuLCKx11lbwfnez/cXUbSCrtPJov7NU22lvATAykG1
   d9gLKVMsAo375yQeeSXCBPGA3vRCXvIdq9G7A6zumj98PX6313MOWp8+H
   vB0SbxO+8e6hrCxM0RERscKXh8ECYBUOonUFvB7m0FJuMJpCs4tkrRcUq
   aWEPnhHQTpwutkFm9SJesHz/aUcVDb0jZj01+VmKOhQmJHUxtcEi/uNEx
   G3ZCTGJ/M++bgTT/BgBpuFuOusUKlJpGaPGYpDikz6zCDtA6+z4M8VPq4
   Q==;
X-CSE-ConnectionGUID: Nt60MdjNQ8WXlrb6tvTjuQ==
X-CSE-MsgGUID: jSW5DyArSGCUBX2yCdHAlg==
X-IronPort-AV: E=Sophos;i="6.07,186,1708412400"; 
   d="scan'208";a="20498575"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Apr 2024 20:53:29 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 7 Apr 2024 20:53:00 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 7 Apr 2024 20:52:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G+fdrRfeaDjiTsF7dpPB4ZlTI7aXoI4vcBlsE6oUwGRHk63WZOB2wNF9F+Zr1wvTiI2NraZcuVOVT96gDr83B/5MeSQFMgC51XZeBtXfbP5jfQy3UDUMPjHmDWsTbWerElU8I4/lquHpwwwVb9XmU2ianQLko0Jk8y5ah+7WoPbGdrEDKYGU12FAtGnFl9SOt5XJMRHpKkeko2wIzAkMx94KNcVd4rc/fDTkQkYpoVCoUEfyvM7um8m0cbKg4yefylcpNWzhrD7udUKJIlLBjvlJttbjd60sSig++qol2bfiCdZgqZRvZX1o5NK2ieUSgOraphhR3UXaBVQT29Mbdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kxmNgxwImH/YO4m7C9lENUFlsv/J+Uu9YbIFSddIMG0=;
 b=jIW/3wdQi03BDI4bKv9ew7Isl2Z52sjOcjAqfv5AGuxP3R5w2dEkrUUJPg4j4djNwEA2q4JFe3hPe+XuT8+2KibLCTq35fPEemkNL+1fkZjmneflTNDOG8j3YbPoSFhtLSxCZn8EUJRrrxt2JN3Ls2vvRSBbtJM4Wl3rtN22YG31zAVsNR0oWKrSkI0ekjf4Q1tdWwd18z+oxactribpK8ZkKEnZFBvtP9rDtP7g01YUR4KWKra6SoV2bE6lubvUbqOBH8Wa52PVc+4/ha4xxUL5ThQyWi8MAuieLWxkZXvPNyvGDzRDjijGS2FuzOXchThFoC6JazwQVNUxU7Vq/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kxmNgxwImH/YO4m7C9lENUFlsv/J+Uu9YbIFSddIMG0=;
 b=LxPOdoT7O1RNyoUosE6706xrP9JY4+GXmg2naWvdJdWU77IoP6fHxUiNtItmTnVUQfFKyWp/ol3ANPEd/+GFs2nUWkofdLSXNz9+7LmecrEc2AqL6QmdeBe4DH/Kd8kWb30wn2tEEpurRfeRuN+74v/cWQAjDS3fb8b0l829FUjqpB2y6dnu9KD69UdV4h4odMXffgTUKDN+wZhOkyyT3yCi/5YFXLodxDBQYDZh8yhLmyfVpk6j3kRDBKsGAyXf0fcRHLNSgF8OAnVHj5PMiVsEFd01zv99L2LKaaHbGjfDW+o2YJe70flof8PlKaNQRyMkGwVV5cnx0JaPh4DWdQ==
Received: from PH7PR11MB8033.namprd11.prod.outlook.com (2603:10b6:510:246::12)
 by BY1PR11MB8032.namprd11.prod.outlook.com (2603:10b6:a03:524::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7430.46; Mon, 8 Apr
 2024 03:52:57 +0000
Received: from PH7PR11MB8033.namprd11.prod.outlook.com
 ([fe80::d529:f716:6630:2a1d]) by PH7PR11MB8033.namprd11.prod.outlook.com
 ([fe80::d529:f716:6630:2a1d%3]) with mapi id 15.20.7430.045; Mon, 8 Apr 2024
 03:52:57 +0000
From: <Arun.Ramadoss@microchip.com>
To: <andrew@lunn.ch>, <olteanv@gmail.com>, <davem@davemloft.net>,
	<Woojung.Huh@microchip.com>, <pabeni@redhat.com>, <o.rempel@pengutronix.de>,
	<edumazet@google.com>, <f.fainelli@gmail.com>, <kuba@kernel.org>
CC: <kernel@pengutronix.de>, <dsahern@kernel.org>, <san@skov.dk>,
	<willemb@google.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <horms@kernel.org>, <UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH net-next v3 7/9] net: dsa: microchip: enable ETS support
 for KSZ989X variants
Thread-Topic: [PATCH net-next v3 7/9] net: dsa: microchip: enable ETS support
 for KSZ989X variants
Thread-Index: AQHahz8bMT1C+CbFPEiccDNAaUSBmbFdwmuA
Date: Mon, 8 Apr 2024 03:52:57 +0000
Message-ID: <2d4afde2479cb7830c8add15a7df3d58db0dbb3c.camel@microchip.com>
References: <20240405095216.353829-1-o.rempel@pengutronix.de>
	 <20240405095216.353829-8-o.rempel@pengutronix.de>
In-Reply-To: <20240405095216.353829-8-o.rempel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.36.5-0ubuntu1 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB8033:EE_|BY1PR11MB8032:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tJh4rBA30tcLL9qpXjzN3cFwNg8EoSP8aRTTJL/SpwOZeDGy0HBs0ZEVUE40tSYLgG39kVZYLr39ZbwgMl8tXImkseJoua+bx8sVQ6t8Z+5sf/5q7VWRYOAtLqgN0Ri/silY0ip67fhJ6qguA2gENoKZ97O4mGLg/jlo4BJTDd7POcxTLAcI0ryB7krDHbmra+tZG8r5NmhDh4qKJHWjenIrb2OhiKcrqms/8fYQMLWCZersbX64g8naSGbKt35NSLV3jWHSCqIHGnp+APlkGVzWBd/lLOcgmK1wOVxs1+swppcY7zgieYkhVJ41Ae8osEJ3OscChtF9rOb2/4XBmqJu6RaOPayAP/FnE/njS/RMNq9HFfrlk5arVNP6fYSNqy8HUg2HIoCCA6o2/xDKApHyifm23OZ5R8AjM8L1zYKzAl3K1kC+YOPRYvzvHbPg9O2cjmBdW5fvUknO+EZQ79MFFQEJV4ggLJfGCKuXFsUp7LoI6A7ACsxu7LeG9JWl5MaLu+ssOLC/SyiduLzU0ejH4RhGdEskhteXq8LsTCDcDp7JjZPkR8gpdU9xX9LB5zSyfcjYqo/xQcHQ5jBeBt8C6qrDBgJEZC6Q14eSHZdojmIJHBe0XL/8hRJgyihZIr40yvNyS9ofDQoteIEJkq7+Y4G9GXb+b7Igs3jbkEA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB8033.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(7416005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b0dwUlFVcFhDS0dQWFR5NnVMaUNYOFh0WW1tQ1U1MXBSUXVpZ0N6TnJVc2I1?=
 =?utf-8?B?cWErR2JTYksweVU0bVMrR0F0b25SOTBwN1Q4bUVYRC9FY2ZxYVFVM1RoZTVn?=
 =?utf-8?B?Y1dUckFyajYvZXVXb3lVb3lDQU54N0NoSnVoOW4xamVVNDJ5M0VsNzhOMVlK?=
 =?utf-8?B?VWVVOTY5YXlVOXQ2T2F2enQ3dlllUENaMXAyMHdneVVGZHZycU0yVU9Xd01Y?=
 =?utf-8?B?d1pUWUdCdU1IU0JqUm1lWlZyaEt1S2YwSEdlV1c2bVIvU3g1eFNRR2dMYm9n?=
 =?utf-8?B?WGpTUUtkQmh2Rnhic0hVWnJIbHAyMUJUSkVUbVV3ZDZXWktPeHBiaDJINUQz?=
 =?utf-8?B?eitNdVVjaXh0WXIyYTFKR0N2UC81ZngwTVV6SDhLNU5mb1VLS3AwTzBPbElk?=
 =?utf-8?B?Mjc4ZUNmczlOMkhDZXpQRmJSeWZXT3NvSnl4NldVakMyS0N0VzdXL1RydEtp?=
 =?utf-8?B?R1RNY1RVY1B2S2l1YTltdVU1c1dLNDU4ZVU5OGkxdXFmSkZobnZsR2g4SzI1?=
 =?utf-8?B?ZmY4RmFCd3NId01sbDBLK21DZWk1ckN4S3dXQm1sQ2dFaFh5UHUwajduY0N0?=
 =?utf-8?B?NGNyelZGQVNwM2JoL2RXMFRuYm1URWxoL2JpTU94MVJJNFBpV1VOemVVcCtO?=
 =?utf-8?B?TzU4UTBjQXN1T2tELzcyeExSS0hmV2tvK0s3ZmxTUGNZUmZjU2VlamlSblVy?=
 =?utf-8?B?UWNLemMzSjJlUmFpVmVkZ0NvemhsbTNXcjNTRHlHVWlhaUZuemd2TU9FWXF4?=
 =?utf-8?B?QVk4UkU4a2ZMMFRWZXNBUVYxL1hUQ2E1Z3hZbmd4dTh1MVVZdmRBR3JaeGVF?=
 =?utf-8?B?UldNaUYzcnZCbjBBSEJjWFBYaTY4VTRUSjJ6V0lOakoxWmxHaTczV2M3QzBI?=
 =?utf-8?B?Q3Y5U3VqSXZKZTh6ZmJlUUtSam12KzdkUEpHVFJCanhiNkF6YXJiZ1pJaGlZ?=
 =?utf-8?B?eTFpR1RyZE5UeCtucGNBdmFSeWdEaW1CdUV1RlZDQVFndE5XUG5YMTdTZmpi?=
 =?utf-8?B?UUxyeEFkQkpUalNqbEVGMHdBVGJmV25ZbmVLVGFSdmRWU09OMTdsQU1wSmNw?=
 =?utf-8?B?MVdGOUpGRmhBdkk4MlNyRXk4RHpjUklXLzBNWURqZjRrTU43Rm9kem5yTjU0?=
 =?utf-8?B?UmdERU1BcXgzeTRTWkhtekdoelFJRTJQcmVPaDNwZHgyY2cwdkJjbXArR09y?=
 =?utf-8?B?V0FGeHBjbW5UbG82VVBFUGR1R1NyNHlmYytoMnVJUlVBVnovK3hBR1lFTmpW?=
 =?utf-8?B?ZWlVWmgzVW9VYlg3UnY5RzVPekJYbXpDVVRaNkt1MnBmbElJL3FtUWJTL1Yr?=
 =?utf-8?B?LzNWODlkVlh3cCtPNDkrYzI4YnRUR1dPM2x0U1E5OFBIa1hoR0d4YWRTdENL?=
 =?utf-8?B?L3krZmtrVzZ5M2xlWndvV2xKdjZHMGlSQmozdldwUC9wL1ZJZ29yL2ZPalJt?=
 =?utf-8?B?N3J3dTBPVE1RcEplelpZRXRlTWJ2Q2NnN0g5MmxWaGpZMnoxUDRqRTFIYUNx?=
 =?utf-8?B?M2Z2aXRrcDhoendGMnYxNHBvaEpKNVArR3VsWW53TTE5VzVabUpldzZ4QkFz?=
 =?utf-8?B?UFNVVmpobUQyMGJVYmF0Rml4RkxCMGF4NG9LemtSMU1lWk9sTjVjOWlvWW9N?=
 =?utf-8?B?NHNGUEFoVVhhZG1rZW4xVm9UbzVJWUhNS0kxUHZvODNrdW9VR1p0MFlld1BO?=
 =?utf-8?B?aHNiRHR0VmxGNHFnbXNmcHNzaHU3MEZOYTJ2OUM2Z01IajFXYUZpYmxIc3Vw?=
 =?utf-8?B?RW1LdFFJVzlBNnRSQ2hoMDdoeEtFK2x6U0J3OG9KYThGTEZySFNQSitPSnNj?=
 =?utf-8?B?ZVViQ3NtcmVpbG93dWxHajkwb0xoREQrVHVrcmdwcUZtakJXM1BaamlhSTV4?=
 =?utf-8?B?V01jd2Z1SS94R0Q2eDRUbzFmNDg5NU5ydnhQdDExZFplTWJkVHQzTm52ejI2?=
 =?utf-8?B?M2w3U0RYTkRRZTVCUHQ0M01odkhueFZTODlqdGpRNlVmVzRSV09xTDQ3MUhS?=
 =?utf-8?B?UTJ6Y05KdDlFN0NYaldvUERsbzM3ZmFHZ2xIYWdGSjIxaTlMWlRESG5OU3M4?=
 =?utf-8?B?OHZSSm52cnA4N1AzVkY1YTVUckF4Q2JBNXl5bml2Q0c3S1l2TE5halVQOFZs?=
 =?utf-8?B?cngxN0JzY1pKZzhWWlVIemFEZG1LTlBXaE14RVNuVVpqMWFock1vUEN1bE95?=
 =?utf-8?B?cFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C572D2F5F1C156459909B4D8B5DBDB1E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB8033.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 528b19b9-012c-4c0b-0200-08dc577f60bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2024 03:52:57.4693
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bRQkb13MibzLrTjBEaiQR3jtABJLf2dbAdgU6DmA5c7FP/7T+zqJO8O1F0w3/rZCS3LEfWDRFcwlFhl+reYuoceDjm1dsarZExUzomLw2Q0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8032

SGkgT2xla3NpaiwNCg0KT24gRnJpLCAyMDI0LTA0LTA1IGF0IDExOjUyICswMjAwLCBPbGVrc2lq
IFJlbXBlbCB3cm90ZToNCj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBv
cGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3UNCj4ga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+
IA0KPiBJIHRlc3RlZCBFVFMgc3VwcG9ydCBvbiBLU1o5ODkzLCBzbyBpdCBzaG91bGQgd29yayBv
dGhlciBLU1o5ODlYDQo+IHZhcmlhbnRzIHRvby4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE9sZWtz
aWogUmVtcGVsIDxvLnJlbXBlbEBwZW5ndXRyb25peC5kZT4NCg0Kbml0cGljazogRm9yIHRoZSBz
b3VyY2UgY29kZSBJIGluZmVyIGV0cyBzdXBwb3J0IGlzIHN1cHBvcnQgZm9yIGFsbA0Kc3dpdGNo
ZXMgZXhjZXB0IGtzejh4IGZhbWlseShLU1o4Nzk1LzQsIEtTWjg3NjUgYW5kIEtTWjg4MzApLg0K
SW5zdGVhZCBvZiAudGNfZXRzX3N1cHBvcnRlZCwgY2FuIHdlIGFkZCBpbiB0aGUga3N6X3RjX3Nl
dHVwX3FkaXNjX2V0cygNCikNCiBsaWtlDQoNCmlmKCBrc3o4X2ZhbWlseSgpKQ0KCXJldHVybiAt
RU9QTk9UU1VQUDsNCg0KT3RoZXJ3aXNlDQpBY2tlZC1ieTogQXJ1biBSYW1hZG9zcyA8YXJ1bi5y
YW1hZG9zc0BtaWNyb2NoaXAuY29tPg0KDQo+IC0tLQ0KPiAgZHJpdmVycy9uZXQvZHNhL21pY3Jv
Y2hpcC9rc3pfY29tbW9uLmMgfCAzICsrKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9u
cygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2RzYS9taWNyb2NoaXAva3N6X2Nv
bW1vbi5jDQo+IGIvZHJpdmVycy9uZXQvZHNhL21pY3JvY2hpcC9rc3pfY29tbW9uLmMNCj4gaW5k
ZXggODQwYjE3Yjg1MDdlMS4uZGM5NjkzMWU2MmRhOCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9u
ZXQvZHNhL21pY3JvY2hpcC9rc3pfY29tbW9uLmMNCj4gKysrIGIvZHJpdmVycy9uZXQvZHNhL21p
Y3JvY2hpcC9rc3pfY29tbW9uLmMNCj4gQEAgLTEzNzgsNiArMTM3OCw3IEBAIGNvbnN0IHN0cnVj
dCBrc3pfY2hpcF9kYXRhIGtzel9zd2l0Y2hfY2hpcHNbXSA9DQo+IHsNCj4gICAgICAgICAgICAg
ICAgIC5wb3J0X25pcnFzID0gMiwNCj4gICAgICAgICAgICAgICAgIC5udW1fdHhfcXVldWVzID0g
NCwNCj4gICAgICAgICAgICAgICAgIC5udW1faXB2cyA9IDgsDQo+ICsgICAgICAgICAgICAgICAu
dGNfZXRzX3N1cHBvcnRlZCA9IHRydWUsDQo+ICAgICAgICAgICAgICAgICAub3BzID0gJmtzejk0
NzdfZGV2X29wcywNCj4gICAgICAgICAgICAgICAgIC5taWJfbmFtZXMgPSBrc3o5NDc3X21pYl9u
YW1lcywNCj4gICAgICAgICAgICAgICAgIC5taWJfY250ID0gQVJSQVlfU0laRShrc3o5NDc3X21p
Yl9uYW1lcyksDQo+IEBAIC0xNDExLDYgKzE0MTIsNyBAQCBjb25zdCBzdHJ1Y3Qga3N6X2NoaXBf
ZGF0YSBrc3pfc3dpdGNoX2NoaXBzW10gPQ0KPiB7DQo+ICAgICAgICAgICAgICAgICAucG9ydF9u
aXJxcyA9IDIsDQo+ICAgICAgICAgICAgICAgICAubnVtX3R4X3F1ZXVlcyA9IDQsDQo+ICAgICAg
ICAgICAgICAgICAubnVtX2lwdnMgPSA4LA0KPiArICAgICAgICAgICAgICAgLnRjX2V0c19zdXBw
b3J0ZWQgPSB0cnVlLA0KPiAgICAgICAgICAgICAgICAgLm9wcyA9ICZrc3o5NDc3X2Rldl9vcHMs
DQo+ICAgICAgICAgICAgICAgICAubWliX25hbWVzID0ga3N6OTQ3N19taWJfbmFtZXMsDQo+ICAg
ICAgICAgICAgICAgICAubWliX2NudCA9IEFSUkFZX1NJWkUoa3N6OTQ3N19taWJfbmFtZXMpLA0K
PiBAQCAtMTQ0Miw2ICsxNDQ0LDcgQEAgY29uc3Qgc3RydWN0IGtzel9jaGlwX2RhdGEga3N6X3N3
aXRjaF9jaGlwc1tdID0NCj4gew0KPiAgICAgICAgICAgICAgICAgLnBvcnRfbmlycXMgPSAyLA0K
PiAgICAgICAgICAgICAgICAgLm51bV90eF9xdWV1ZXMgPSA0LA0KPiAgICAgICAgICAgICAgICAg
Lm51bV9pcHZzID0gOCwNCj4gKyAgICAgICAgICAgICAgIC50Y19ldHNfc3VwcG9ydGVkID0gdHJ1
ZSwNCj4gICAgICAgICAgICAgICAgIC5vcHMgPSAma3N6OTQ3N19kZXZfb3BzLA0KPiAgICAgICAg
ICAgICAgICAgLm1pYl9uYW1lcyA9IGtzejk0NzdfbWliX25hbWVzLA0KPiAgICAgICAgICAgICAg
ICAgLm1pYl9jbnQgPSBBUlJBWV9TSVpFKGtzejk0NzdfbWliX25hbWVzKSwNCj4gLS0NCj4gMi4z
OS4yDQo+IA0K

