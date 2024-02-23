Return-Path: <linux-kernel+bounces-79245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 391C0861F83
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 23:19:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 548811C23191
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 22:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89B7414D45B;
	Fri, 23 Feb 2024 22:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="LhacPCxy";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="kJLbTTDJ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="sg6lDpgL"
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD531493B0;
	Fri, 23 Feb 2024 22:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708726770; cv=fail; b=dLvae4U+Fv3DvqXIHQBXyx0ZpN1W0g+8wtV3ZHO9G4J8/bzzBvObLtOMyLEfMFr/sY5Aq2UiYGv7sYm7mUc3zA+90O7sJfVTNUwch7aPbIADs9gMtqPE9jIC0tJwNtJhqBbnKIDPK7DZZdyFSYHoUT+OSsOJmqapPmlyR1RmpG4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708726770; c=relaxed/simple;
	bh=RuTeLjlurYSuwZQHlCDD9s9GskM9b+d9wZcHmi2EhRQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Pu/lhIhYGv67a4GiszQJn3q4JOJ4l31/gTwWaiDIywULyjhDpLX30geDczlezzlC5COR7rjUXFJosnhHpymL2Ld5w+S7i9iKHuOcX1ERVqcd38pbYhVcioQyk9a/GUmBwsekN6ndd0aBpxLhdfSnq7EfJdE86QRIjC/zWEt7VTE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=LhacPCxy; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=kJLbTTDJ; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=sg6lDpgL reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41NGjfnj028598;
	Fri, 23 Feb 2024 14:19:15 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=pfptdkimsnps; bh=RuTeLjlurYSuwZQHlCDD9s9GskM9b+d9wZcHmi2EhRQ=; b=
	LhacPCxyEXaL5BOkcvlyGZY5AHor04iTGnj6MHQg29mLtArmQxZYXrvR1F84Dwi9
	wjtw5P1+uxGCY7mceOscqliPxS0apAbEXehxbtxfleAkHrHJG5hWQGjwIBp//ext
	FvdcwZ4KEUVR88B0aCBjBDO5r6aY5BlOR0i/k0hxXPWR088eKTCf2XxtB37A5O4E
	MIWrzhNZm/GRr8sNmLfGbX0S4AzmdNBh0RgNoQsQ7g9/mKqLgut17Agf/VwwVAYY
	I70s5GCelnBS65V+OhoU/Mo7TTWyAzNDTZ14u8jwTeRzGzoOSC75u87tzFBBQwGg
	K9pxcJ1XvL+yyenOXXzLRA==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3wd22411qg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 14:19:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1708726753; bh=RuTeLjlurYSuwZQHlCDD9s9GskM9b+d9wZcHmi2EhRQ=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=kJLbTTDJsijEby5Ux2NBE8vz6cFw4V62kL9YQHElkjEAlAoC8fm8zc4kgSB94WzKW
	 /8stRCrR0XKoQUqlW4EuxHuazIgQrhz7CxRL+WSjpbEgAH77uv5lQUys7slVX8Mi8R
	 /646GstgMBEvGYREEQku31/HoxehOjQxkI9Y5zduUwilCC0htrx/YuodFKcgdeOFxs
	 EE80fhs2FTT87I7i1PWhlGS7TGoZx62Xv5/MWddyM6WvBBPgPnuSmDCSYhFQvQbL/j
	 PyxOWXpzXKl9kilTOAeN9OACFLqh3k+tP1Iu1+qsJl9ToMEYun+WMPffQfPBD+2TMK
	 XqS7gg5ZKWRTA==
Received: from mailhost.synopsys.com (badc-mailhost3.synopsys.com [10.192.0.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id E74B04035D;
	Fri, 23 Feb 2024 22:19:12 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 04AA7A007A;
	Fri, 23 Feb 2024 22:19:11 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=sg6lDpgL;
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 4D13640132;
	Fri, 23 Feb 2024 22:19:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B+dMldrIYuvQUiSChiezXsrz9BGYiUymkg0FwSqL5hIMfpBJyx32NDtYwsMZTm6XoeBXXluQEPSnvXmuBAtpPyZ1x7uvUvv2AgD/0oEIgFdz1rwhtr9VgEL+fw6Qzt4E7QQWnOb9gnPozVVuITqpBr55FRFN7g1TdJKN+IevJpbnU48gFXYWy/SBm3YAKR1BIJpePUmhagYRBrjDYUmmKfF8FzFbA1sc1dsMuJU0ygU4xdbXp4eF/NBWChXk6muWdvNUjzo/hykiXxTnK/BNp4jbsP6qgQz2g4vDYXQtutWIOPzATG2tsouUrfMmEUAk+ootknGjBiLr7hW/ziPiwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RuTeLjlurYSuwZQHlCDD9s9GskM9b+d9wZcHmi2EhRQ=;
 b=N1mzVZB/T4Z+TBwn+sfuQcqM7NhWOJZGM7xnWiUxrATbaNnug5kJAeJ7G2wx7FiHytqOJLYoBfkS011xC4nuFthLPKDI9r5NLzJK0nfM23qLUH4XefGJM8Aou2agAy8tRKNetYnmGpEUHtOegX049GZF8pi4VVW5mdPEwPUWTfzA+YFd+gQAhVG4w1q2khaGo/nyQiIUKWR1sCPWaQufpNpWwyaVF3g8BumN7ALvpA4wbBPhupzcllpVdVnYeoegMp10ILgWuPlbOL+TAbTIgUdwsjp9INnw/R3K+oeSJ+Cn+nnkEzcwewQvKikwSI4Q9+dqwTvpEKNh+/mIvqqlVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RuTeLjlurYSuwZQHlCDD9s9GskM9b+d9wZcHmi2EhRQ=;
 b=sg6lDpgLuWrD0Yflia5PLENP8XhCxxVfa9WAkEq781jGZBdg60svN+JwFFlaUaxePkbLlHFGnbhGNyavQEid5ErhRAqTIE6yyzcHnkb0wqG0GIZ1XsQ10n15+BzDgjn3RjNzkhWY2SoKm4l9uftDMe6lLe4rmQMVLuSWIqSwKcI=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by CY8PR12MB7220.namprd12.prod.outlook.com (2603:10b6:930:58::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.27; Fri, 23 Feb
 2024 22:19:06 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::a6b8:3d34:4250:8ae3]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::a6b8:3d34:4250:8ae3%3]) with mapi id 15.20.7316.023; Fri, 23 Feb 2024
 22:19:06 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Roger Quadros <rogerq@kernel.org>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, "nm@ti.com" <nm@ti.com>,
        "r-gunasekaran@ti.com" <r-gunasekaran@ti.com>,
        "afd@ti.com" <afd@ti.com>, "b-liu@ti.com" <b-liu@ti.com>,
        "srk@ti.com" <srk@ti.com>,
        "francesco@dolcini.it" <francesco@dolcini.it>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v3 3/5] usb: dwc3-am62: Fix PHY core voltage selection
Thread-Topic: [PATCH v3 3/5] usb: dwc3-am62: Fix PHY core voltage selection
Thread-Index: AQHaXysDDqYaaSEh4ky+pbNUdQXuhrEYjkgA
Date: Fri, 23 Feb 2024 22:19:06 +0000
Message-ID: <20240223221904.e4kdlslqicucgftd@synopsys.com>
References: 
 <20240214-for-v6-9-am62-usb-errata-3-0-v3-0-147ec5eae18c@kernel.org>
 <20240214-for-v6-9-am62-usb-errata-3-0-v3-3-147ec5eae18c@kernel.org>
In-Reply-To: 
 <20240214-for-v6-9-am62-usb-errata-3-0-v3-3-147ec5eae18c@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|CY8PR12MB7220:EE_
x-ms-office365-filtering-correlation-id: 51d6e4ce-dfe6-4f6b-167b-08dc34bd730b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 4uRmdxLa5BL5Dma7fT1CEpNYXLqVJ/LcgDkcHZoe89qzRVViI0Z0iPjSgHcplX2MYk4dQTErLQ1swRTgk/HvLH2gW65uhS2G4HFxTqHe1YNHba+RsyE73e9CXuVdSDgzeOGn7rvbCmpSVmTvdAXatD0dJPEV0vpbLEY2DtVhLRORy0IeKKw4XQZtSG6AyD9+qvhexlSk8o44d4y7VWOMLhEWTtL0f067dmEh9mNhQ7eYKG4tebg+qExrgXGmfp5pZFguvg1h0ZCvsRjNwZvXZKsU9ybbafa4ylu18EC7J0h0/+bly3RSQgkyhtY9vsiIdXvuv2wxddB7+rOoPtmawjOEI/65BvvcKIzqorarCbMPVhYCrDFJyLJkUGoOT97m25xDxZ/ER77x0Mpd1PJAShVDqKDpQX8p40roDPYCM2nGVPdI1JEJh9AN619LkIkyY24xYkLjS1VPjtZCIfUksWA5rn6J0t4AUJxt5MAc24SC+eK5VoZlircd6hj38h/2H/bxbMBwPTKsq3WKECbGkVa9ZS7PNmNFI22nu8/tSL6ig4Qu+CjHLA5X5DigUBH66VpPssZq0ikS2cTy8BJwheS7DSgTGbqau7n+SGc48io=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?a1JpOXFob1QvVnhDTnhIVW5nOFo5dXJwNXdhc0x3YXpZMkFSOVl6UmNJbDly?=
 =?utf-8?B?OWFwYVFibXhzazE3MFBNQmpXT3RaOXlEdEhNbnV4aXdCWDNOVURQRGR6bkNQ?=
 =?utf-8?B?VUYyNVpnWUVSVUdrazQ0TVg1cUk2d1FmLzM3TmlGcEs5Lzh1RXJQWWl5L0Ex?=
 =?utf-8?B?THl4T3NrbGJzb3lDZTJFZFlHeDRYci9ySzJkbmE0c29aMml3eEdPdWUzVkEx?=
 =?utf-8?B?RGpEWnhQR0xaT2Q0Zy9TTWsyRDNwcStIMFN4RDlKN2hNLzJUSHB6dDBMU29I?=
 =?utf-8?B?a0J0K2dld2dGaHYzY1N1SE9LczkrV3Y0UEF0UzlmYVYyajdKbzc1dEhRdDlj?=
 =?utf-8?B?RmYzQUVoVTVncUxWSVllNU15VkpPT1Q5Q2JUV0ZvT25rSlRFTFF6RmdtNExT?=
 =?utf-8?B?aWN6Sy91cXA2NSttRmpQNjJ2UWtMdDdLeW1wemxPZnZJVUNvSUpseUpYUEFR?=
 =?utf-8?B?VU52M1pNbndaeGtIMzV4UTJZb0dXRTdPdzFDblRkTHphMmM0RFN3cnYrZUQ3?=
 =?utf-8?B?SGZkbzRacG9YZ1B3MjFrVjRIbWdsQU1Fb2FVTWhteEVQU1V3RDJTWWhRRjE5?=
 =?utf-8?B?Q29yOTZJMWtjMnVFVEFmY2RhV29qRFhvajNvZ3FRR1MzbzR5UmwxL3ZKaVdB?=
 =?utf-8?B?eUllUnV2dmxsVThTYzBXNWdyQjJSUjFWMGh0WXRZbnk5emVMOFl5cEova1Fo?=
 =?utf-8?B?MFNPYUlsNTFiMFY5QlpLNjdkSHdVZEhRR05zVlYzQnRqK2lLOGFuakRPVnNm?=
 =?utf-8?B?UjE3RWhHM3pBUnJTaElWdkQwWWVKUUZIMGVJMG9zVS9hRGxFUWh6cW5NcTRi?=
 =?utf-8?B?YStXR2JqaEpoZXBJSEUyT0FWQWZNcGRzeHlsNW44cjFNeGhJcEFZQUxCKzdm?=
 =?utf-8?B?aTNneHhYWUpBU21aM1ovbzNqdW1kR3ZBbVA5L1JhZkc0UmxtSFd1SnhnOEVz?=
 =?utf-8?B?NkwrTDNUOHI0UEFZVkNnUkR2ZDNSaUNaZ0liWS9iazFMY282TTQ1N2dNMmdI?=
 =?utf-8?B?Z2NWZHVVV0xqSjVHSzdPVURvUjNjZ1kwVWNDQWZFZjJnMVg2anl4NVhqUFFR?=
 =?utf-8?B?S2VnU2VCdVh4ZjNRbHhmcFhVVmozY3ZoMVk1c3ZZcVM1aDl5RmlRUDROS2Rw?=
 =?utf-8?B?Um1KKzhIS0J3N2Foa3A5Vjh1WFlOTUFmNGRPVEhMZ0lsOXh0RkQ4eXdodWhP?=
 =?utf-8?B?L3Btakw3MVh2SWlrNmpKbHJQTzl0SGZ1bmxkY1lDVnNacmpNN3Zac2VqTzdD?=
 =?utf-8?B?NzlaZjNPeG42OERTSHlnMzlaa2xRLzdiaVlGbHhwOUlXa1BrekR5V24ybG80?=
 =?utf-8?B?eGlicHhxWXptS1JiS2w2Rmh1a0grZ2lHZnZrVnYzNUpWWnRESUNCYm9RV0ZE?=
 =?utf-8?B?a0hkR2tTdDkrc1dVUWpPaDNLd3J1RHk1OG43eDN1NGN1ZTRYeWJlcGlrbUZ4?=
 =?utf-8?B?U2haQVFXQVNyVVhQcEdVM0FpZzNXZUJyNmFyY2NaTkJPdFdhWWM2NmJxRUJ0?=
 =?utf-8?B?d0JBOElZOXNjY05iUXZlckJENmwwNGlnMEJkeWFuTnd4NmJhTU50dytWc3dE?=
 =?utf-8?B?MVNiaUN3ZjhxYWVlbnVVSkIrZnNZcnpvZGZoSWFHQVdpK050VFlCK3V1WjJv?=
 =?utf-8?B?UkROeWVGNTZodVJmbkZ4QzFJY08vdGltankzUGFlZ0dCaTJDMUlSeUhGelNu?=
 =?utf-8?B?UTBpdWtjOFN5K002bzFLNzA5eS9WQi82YXVQcWg1TWdMWUJoRzY4VDZRM0ls?=
 =?utf-8?B?Zk1QWnJiSE9jdWhEMXpMNzlVVk1EYjVzamhjN1Y5LzltdGZiaWRDMTdWa1Bz?=
 =?utf-8?B?OEZEek9pamFRWVkxTlg1Qm1EZHJxT2gwbmwwVlhFcVBPeFpTemQ4c1NhczF3?=
 =?utf-8?B?Q3dXeFp6dGR4Rkx6UHMzQkFZREtBTjZhMnErd0JjdUU5Qm51dzFTSlh4Smp2?=
 =?utf-8?B?TVd6WFZZZ09CVkpyT1dSVDBGMkIrVE9SZ3ptTVpvMWtyemJHMXJGYzJFOC8z?=
 =?utf-8?B?dDBXODl5N0RudnNYZWswTDNjaGVLVGhqcVRJeGlzWVNKSVdxWTFrZ3VxN0Fy?=
 =?utf-8?B?d05CemMzMjFqQlVSN1ZGTU4wOWhoZVVuMFUxWGE3Q0RROEVoYWxhcjRjUjVH?=
 =?utf-8?Q?2E27F6sWmwzcqDKXWH45RFFhP?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0118E9870EA7714AB5D3F2441049A4E7@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	9vBJNCAtCvMPDSu2Gq8ILdoGXXMREO0X2Fax0yjz/JFvIQL7lUMj7HcojzhxP+Nc2VAhcBbLtO4E5NQnjFKj9p12CzDEs8pYkxPtAImp6M9VprctyAFZloHA2QOdZyfEzynK9Ov5LOyJPczz1FPdlI6/kaQDvFr6925ETyb3U/LiVcouuFaM6FWbx7/4y+kysOL2CR47eboiHmhDbq/z/53wn1+nUIKP026BO+kJFr4IUEOF+XAtpSOpjLAu3h2H6T6emMCY+66hy51yRRIBS+WKLSKT0CsLc+TCRD8A1hfp6v6In0aRvBZ4StHJ7Z64OTj2l3ri4pv4Pl4kKbw3FHBglrPQg+Z/CmyKxz/LKefOsMaPcgpYQdDO+C15HvTFo6nMF3P54v5kL0WUI4C+/0rApS9iw1EGmBYr2KpyCTKrvRnvOhxkWnPyxpgW4FA/MrQbkxwcYT0NkJagrqDK48JvIAAeL/uga0I8iKXndEWXZ8N0UVWifvmKRCtHYdaCPfJhJosxcH7vH6d6A83CN17hb0L2yElOIHGiY+fwdvOoyjYpYGMFLzTu+kglUuZRXfnqrWTHS/fgaD23OzH9xkhGd4hvJCy5f3m/2DZ/7HE5seCFtV6wMo/zxOXcv3L4z04cGjslMvZmnO6wyLKZlQ==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51d6e4ce-dfe6-4f6b-167b-08dc34bd730b
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2024 22:19:06.2881
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: atTFXCH4qxZ94uIADOaJCTkNoyij8slM0nnX/B9PQ7luAh7Jb16TwPHEG33jTrv6Wt/SJNcT3q74VCgD9WbRkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7220
X-Proofpoint-GUID: zYpj_z7B79oO9e1qOFJLJ-XKRU-aAvOB
X-Proofpoint-ORIG-GUID: zYpj_z7B79oO9e1qOFJLJ-XKRU-aAvOB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-23_06,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 priorityscore=1501 mlxlogscore=999 phishscore=0 impostorscore=0
 malwarescore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0 spamscore=0
 adultscore=0 mlxscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2402120000 definitions=main-2402230160

T24gV2VkLCBGZWIgMTQsIDIwMjQsIFJvZ2VyIFF1YWRyb3Mgd3JvdGU6DQo+IFRSTSBpbmZvcm1h
dGlvbiBpcyBvdXRkYXRlZCBhbmQgZGVzaWduIHRlYW0gaGFzIGNvbmZpcm1lZA0KPiB0aGF0IFBI
WV9DT1JFX1ZPTFRBR0Ugc2hvdWxkIGJlIDAgaXJyZXNwZWN0aXZlIG9mDQo+IFZERF9DT1JFIHZv
bHRhZ2UuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBSb2dlciBRdWFkcm9zIDxyb2dlcnFAa2VybmVs
Lm9yZz4NCj4gLS0tDQo+IENoYW5nZWxvZzoNCj4gDQo+IHYzOiBubyBjaGFuZ2UNCj4gDQo+IHYy
OiBubyBjaGFuZ2UNCj4gCWh0dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMvX19odHRwczovL2xvcmUu
a2VybmVsLm9yZy9hbGwvMjAyNDAyMDUxNDEyMjEuNTYwNzYtNC1yb2dlcnFAa2VybmVsLm9yZy9f
XzshIUE0RjJSOUdfcGchWVJiRWNzNmtjV2JWbVowYkJ1OVN2T0VBblNGVVB2LVp6cHQtekx0RlpG
TGRocXVBcDV0cHB2aWtFcU11R1RjRnVRQVhrc1BpQm1jLXp1WnFydm1OJCANCj4gDQo+IHYxOiBo
dHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIw
MjQwMjAxMTIxMjIwLjU1MjMtNC1yb2dlcnFAa2VybmVsLm9yZy9fXzshIUE0RjJSOUdfcGchWVJi
RWNzNmtjV2JWbVowYkJ1OVN2T0VBblNGVVB2LVp6cHQtekx0RlpGTGRocXVBcDV0cHB2aWtFcU11
R1RjRnVRQVhrc1BpQm1jLXpsZ3ZxYVM4JCANCj4gLS0tDQo+ICBkcml2ZXJzL3VzYi9kd2MzL2R3
YzMtYW02Mi5jIHwgMTAgKysrKysrKysrLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9u
cygrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMv
ZHdjMy1hbTYyLmMgYi9kcml2ZXJzL3VzYi9kd2MzL2R3YzMtYW02Mi5jDQo+IGluZGV4IDYwMGJh
OWNmZWZlYS4uYWYxY2U5MzRlN2ZiIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2R3
YzMtYW02Mi5jDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMvZHdjMy1hbTYyLmMNCj4gQEAgLTk3
LDcgKzk3LDggQEANCj4gICNkZWZpbmUgVVNCU1NfVkJVU19TVEFUX1NFU1NWQUxJRAlCSVQoMikN
Cj4gICNkZWZpbmUgVVNCU1NfVkJVU19TVEFUX1ZCVVNWQUxJRAlCSVQoMCkNCj4gIA0KPiAtLyog
TWFzayBmb3IgUEhZIFBMTCBSRUZDTEsgKi8NCj4gKy8qIFVTQl9QSFlfQ1RSTCByZWdpc3RlciBi
aXRzIGluIENUUkxfTU1SICovDQo+ICsjZGVmaW5lIFBIWV9DT1JFX1ZPTFRBR0VfTUFTSwlCSVQo
MzEpDQo+ICAjZGVmaW5lIFBIWV9QTExfUkVGQ0xLX01BU0sJR0VOTUFTSygzLCAwKQ0KPiAgDQo+
ICAjZGVmaW5lIERXQzNfQU02Ml9BVVRPU1VTUEVORF9ERUxBWQkxMDANCj4gQEAgLTE2Miw2ICsx
NjMsMTMgQEAgc3RhdGljIGludCBwaHlfc3lzY29uX3BsbF9yZWZjbGsoc3RydWN0IGR3YzNfYW02
MiAqYW02MikNCj4gIA0KPiAgCWFtNjItPm9mZnNldCA9IGFyZ3MuYXJnc1swXTsNCj4gIA0KPiAr
CS8qIENvcmUgdm9sdGFnZS4gUEhZX0NPUkVfVk9MVEFHRSBiaXQgUmVjb21tZW5kZWQgdG8gYmUg
MCBhbHdheXMgKi8NCj4gKwlyZXQgPSByZWdtYXBfdXBkYXRlX2JpdHMoYW02Mi0+c3lzY29uLCBh
bTYyLT5vZmZzZXQsIFBIWV9DT1JFX1ZPTFRBR0VfTUFTSywgMCk7DQo+ICsJaWYgKHJldCkgew0K
PiArCQlkZXZfZXJyKGRldiwgImZhaWxlZCB0byBzZXQgcGh5IGNvcmUgdm9sdGFnZVxuIik7DQo+
ICsJCXJldHVybiByZXQ7DQo+ICsJfQ0KPiArDQo+ICAJcmV0ID0gcmVnbWFwX3VwZGF0ZV9iaXRz
KGFtNjItPnN5c2NvbiwgYW02Mi0+b2Zmc2V0LCBQSFlfUExMX1JFRkNMS19NQVNLLCBhbTYyLT5y
YXRlX2NvZGUpOw0KPiAgCWlmIChyZXQpIHsNCj4gIAkJZGV2X2VycihkZXYsICJmYWlsZWQgdG8g
c2V0IHBoeSBwbGwgcmVmZXJlbmNlIGNsb2NrIHJhdGVcbiIpOw0KPiANCj4gLS0gDQo+IDIuMzQu
MQ0KPiANCg0KQWNrZWQtYnk6IFRoaW5oIE5ndXllbiA8VGhpbmguTmd1eWVuQHN5bm9wc3lzLmNv
bT4NCg0KVGhpbmg=

