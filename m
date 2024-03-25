Return-Path: <linux-kernel+bounces-116484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76079889FC2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:38:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 994F81C36995
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 631B819DF66;
	Mon, 25 Mar 2024 07:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="C8gY+sUB";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="oKAa+QEj"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E12A181490;
	Mon, 25 Mar 2024 07:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.153.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711350680; cv=fail; b=SuBV7/8JYOY/falPDosJFHWdjNBpX0iNSRiNgpf3jQsC6xKeDlmT3+9sgXYBHeGeTL8mbcHKwFDeyZyx2d/T+wJo4GX7C7OFSJPFnTclzIH6OjaymNGTimY4qIg+NtcKgiHbrqTLJTasxpuKZ5pc+flNFvI7C+NcuQNWkgrqIIM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711350680; c=relaxed/simple;
	bh=7LloCdrMGLGxRS9RhEW2FsKQJ/xPgZEw7WIwkPx77KI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PBv3b6Bzrk3MriZ53R8IYkuco7ej/ejB7U//+C/HX0WV6U6WGiRocSt19IPnAzn3uEldTaMUkR53paCZXiX2RcnAcurVUwh3stbeD0bIt9OnzVZp7cKj7a1Myenl5n+NTnELJm6CSVs4R2/1qXQMBFMcbRvvuRsABkGd2358L5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=C8gY+sUB; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=oKAa+QEj; arc=fail smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1711350677; x=1742886677;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=7LloCdrMGLGxRS9RhEW2FsKQJ/xPgZEw7WIwkPx77KI=;
  b=C8gY+sUBwCB4tooDirjB7QjQT9n7cerYitWVmrVx2LCKyT8FS9BRnciR
   SoEbW6zoC1intt29xwrFeHVeGNVLBblNU+/m+VUGHWMs0c4gOE+37Nsc4
   qrn5GFwG+BB0ELlLNnhmLl/gzkX1hRhE5Qv28UNmldboWZePlKIk7Dut8
   k3Wh+2reNwX+MfnKI/P5KlAPtPO5qyNAojWBvVKqUd3GuFOO+zoVQCQSa
   +aCRvQXGtlnWoa62cm3WH28rgZwRIv9OmvhlpfRkatogo/0OPhHcJ4kNn
   ZyBfRdde+0XgwctZ+evT13Z8+8LqQaZ/bxsCW+7UPvEQLlrt6JyH4mNDG
   g==;
X-CSE-ConnectionGUID: SQLTIg0QTKWesyXjKIcpDQ==
X-CSE-MsgGUID: xd5dY/dlRPGNiw0lK/ZspQ==
X-IronPort-AV: E=Sophos;i="6.07,152,1708412400"; 
   d="scan'208";a="19925603"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Mar 2024 00:11:09 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 25 Mar 2024 00:10:49 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 25 Mar 2024 00:10:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R1k5HVy2o5r1Wfo9YaamtDaH0AFbyYaqJPisTDsQ73OH4G+CkV5yJIVSdhmjXykuq+fDQUxz+FXFuQ1sUupXwjDixk13GjF3FciM3ScbOD39Gozw7++TM4S5k+SgGUJ2vGFYAkweI+NAWTbxx8egpnaT9mSt/m1MoF28p+VpQne2o4tjqdq8sn9VACJ7n/tBY/IFqJdlJOCEp1+A4EaqajTrNzSLbbFAcARDAq3tpW4Iqb0xft39HagreD65iRxMfUt7zwdwS4+qPpeeGkI8o/HNG8HSa8vv4lbIa0zPpKkJ9Cs6j3+VXyvWmeJo87Z0eJrzS3MVOF4MQ6GkGlWKwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7LloCdrMGLGxRS9RhEW2FsKQJ/xPgZEw7WIwkPx77KI=;
 b=jzVc+hQiibCaRcg5lVTV7H48AX5Q0HFbrSpwZNmFpJohBovRKZkoGkDykT4jZ4pVC5cgVvIOg3Y2ibYP1CokVheKLffeW1KP/ljAMLvj1oNm6D6v5npVDitBRG6DPes111X6+OMJ89HfyX/LmhWxnAq0MAcO1eme6uNQP7I5GZFMXZNzSZAM7S2jiEhJ7GT41iRY6A9KJFNMuq+jYoO7vzlqAUPW/azh5d7bKws7h8crMQJxBJgYKnKnbGvbdd5OnlvdhLAeRn6Yuu1xxDD46XH2T3DnXVGNVJrMhKSvW3jIXZzFD1aqOKZszQ4GzRZrKX6F1Uf4ARuvm45o8BsNZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7LloCdrMGLGxRS9RhEW2FsKQJ/xPgZEw7WIwkPx77KI=;
 b=oKAa+QEjzu7dbPmyKUe3Ayglor7WPWF8ycF7oerBE5viQXmUGqFApbCoVNu7JDwn6/ga6GoCIJiJweHtKAd1N5c0uCcYDgeOG6yiZ/aEjKsiM9BE0e9BDg76C9WkExUkL7BNJ6ZRaOYndYO/+SAbZdqI0JoVObFOYq/6R7NUKhMm+zFJcv0W9Ygmw18GrKy3n+I9cVWWzef9Dx9MKdrpqCc3e2PPm7We9SGr49XKzpVHZohlaWn/+J7DFr4ovMWYb3GMc4CzY1Of6Bfu5V7RyYOps7H5/zQrUzcAREnP70wYMKafqVC9in++U9Xs3CaM2SzNOvNy91KepXeCE86Kfg==
Received: from SA1PR11MB8278.namprd11.prod.outlook.com (2603:10b6:806:25b::19)
 by SJ0PR11MB4880.namprd11.prod.outlook.com (2603:10b6:a03:2af::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Mon, 25 Mar
 2024 07:10:47 +0000
Received: from SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::f633:b9d4:f539:177d]) by SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::f633:b9d4:f539:177d%6]) with mapi id 15.20.7386.015; Mon, 25 Mar 2024
 07:10:46 +0000
From: <Parthiban.Veerasooran@microchip.com>
To: <krzysztof.kozlowski@linaro.org>, <conor@kernel.org>
CC: <andrew@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
	<saeedm@nvidia.com>, <anthony.l.nguyen@intel.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <corbet@lwn.net>,
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
Thread-Index: AQHab6Ox6ghenOTJpkWNbGLTwd03cbErBYYAgAAJFoCAAANkgIAVU1wAgAAUTICAAX1RAIAAAHgAgAA4LwCAADuQgIAA+O2AgAAKtoCAABfTgIABsrcAgALuiQA=
Date: Mon, 25 Mar 2024 07:10:46 +0000
Message-ID: <be68c2e3-a535-4d7d-8cf0-b7b48742f61a@microchip.com>
References: <20240306085017.21731-1-Parthiban.Veerasooran@microchip.com>
 <20240306085017.21731-13-Parthiban.Veerasooran@microchip.com>
 <20240306-spree-islamist-957acf0ee368@spud>
 <4c5968a3-c043-45fc-8fff-2a9eaa6de341@lunn.ch>
 <20240306-ripeness-dimple-e360a031ccde@spud>
 <05a9a7ee-e4f0-443e-9c8a-8ee649a11448@microchip.com>
 <2f384a54-74a0-4a75-a325-8985257b5d66@linaro.org>
 <ba37c212-fb98-407d-9bee-6d14801754d9@microchip.com>
 <96493beb-afbf-42f2-88f0-ad645422ecdb@linaro.org>
 <1735add6-4a6a-452b-bf26-1cf19c95493e@microchip.com>
 <20240321-upcountry-finless-b0e9b1ab4deb@spud>
 <13a28ba3-2da4-428c-8091-25e75c6c11e8@microchip.com>
 <d41a53bd-ea1e-476a-a18c-ed51dbac0a98@linaro.org>
 <b3c5d217-a5e3-4957-884c-02e8c10aba9d@microchip.com>
 <703de50e-f271-4e65-bda4-85b1835afa6e@linaro.org>
In-Reply-To: <703de50e-f271-4e65-bda4-85b1835afa6e@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8278:EE_|SJ0PR11MB4880:EE_
x-ms-office365-filtering-correlation-id: 009e6683-4bb0-4877-6aad-08dc4c9ab1a6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CFeMEhM2a56Brs6D0uwqhpqGysnhM7Lu5+zfkoolOljyQj8/BCYmCojLlRspN4GH9XxxpVNY35YKC7JVwsLx78wImYQdVRTTAbOjbuioltAzjJyaAEdjFvcRfiMJdsGA0KrvBfkTvoQsRJVTtNLs687JAtckNZg2svfO/k7GLYwMZLI0JwVTDOpWb1nfTNNRbi9Y2n9w0Iqsgmj4VAfXV3SoknnKv54OKlgJAd/O+4W56H2M+jb6BvscAH0xKglP/D4TPBbt2MA9Qn+398crcgnpLhlht5F/JRFz0pSgLPp//UFwdycjJIRAq5WQrx2HaSt4JaOwDidSHXa5WZ607ZQs5JlSXv4CPlTOOkIb50T+z3nDb3bycTASjLwygim7xQbpa1nmAVJ9nGORRQs92I3xccaCyYR5Qunzpn0RwpJx0i42qIssp7DmXYIEiYV2QVBdzv/U4bsvcrt8rFVCyCjOLHClhTSjo3gJWJqyLr20Qf8RciJ4rNuLbv3SqxyK7jKzn6gpS3MAV5ZVzR/AG6EWDBMFPwNprpeHCk3dxwQmhz4TQwhPv5yiE39cFUJYFat3HLsZHBywoMvBQxfCqG6wZpl/iRCFUBT/P5foYUMy2t4VdIb4nFwBMHBFes1gpRmBT5Hlwv2fDSxll00SkavtlG4+0f4JvFMUFO3FAb8n+wbtV8mOFwEeOvhwulazZpLa+VoAGchIDzDixdplhg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8278.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VjJrWUNXaGtmMmVBYjh3TzBmN2p3djNqaXExMXRGZ2huOGtETGVTb2hYQldF?=
 =?utf-8?B?SDFyYUhCRVdtQktYRWx4MXdKKy9IbjdJajdvejEwKzJ0RVBkc3Y3N20zMnNG?=
 =?utf-8?B?cDJXMEdacmNWN2Z2TzFkSWx5TkluQ0Y0M1NhZEdCY2pEbUF3T05zWHVzamJV?=
 =?utf-8?B?WFI3VkxuaDVtUVk2QVlMT3JtWlJONHZ1SEdQOU50QjkrQkd2OThnSVRJeXBM?=
 =?utf-8?B?d0xUNkoraWRSTncvRjlSU3lITVZuY2NPZGUwSTQwYUYvV0dZci9yM3IrN1NR?=
 =?utf-8?B?M3IxK1QydHM0Wkt1eVBCY25BeWJTWkgxR3lJZmxERTlrajczajJNNDRzL3Fz?=
 =?utf-8?B?TVYwSGtFZmJXUlVadzBEUlZ3TmgvdjNPOVVlSSszTG1tVFdhcERIaVdaeGZ0?=
 =?utf-8?B?UStoTVRmMUoyM2x3WlNUWm5NaUVRZ2ZJOWVYZ3piazE4S24rbkFvK3praTVO?=
 =?utf-8?B?UENJOEhmRldaLzhyazRoc2oyK3dNZmc5aG5nQUNodkRNRVlpNk9XalF5VU9Y?=
 =?utf-8?B?d0F3MS9CM1VvSk9wbnpZTHM4MERmN0FCRGptOXdRcmlUNHdKU3VPU0M5Slo1?=
 =?utf-8?B?WUpSb3o3N3FhU3hqM1lRbFl6Y2o3MXRlL0ZEd2dUbGdoZTJ3aXRQQ09LUFJo?=
 =?utf-8?B?d1ZGUWdGQm1EWm1ENXhRd2JqUVNEV0pKZ3RXYU4xOForbGdJdXc3MERrTGk5?=
 =?utf-8?B?WVdCQnNSWWpQVEVrQ3VyMnNRTzZORTZEMmZuck9DcGk0NCtiMUhlVGN3M0pS?=
 =?utf-8?B?VVdHYjVtek8vN2dha254SXVzTTBtZUh1emNHN3hteE5vKzlQZlJtM3BvcTY5?=
 =?utf-8?B?NThwTUpUNGVmR2J4Y1daQzhBNWpKY3FMWC9LVE5BcGVFYTlGVm9wSUpFblhs?=
 =?utf-8?B?SXkyWGlBUjV1eVhEOE9SbXJkVy9lVHNQWlBSTEdnNzlYRHl3MVo4RnRMZ2ZT?=
 =?utf-8?B?K0ROQ25WYmxKR1p6QmhtWkNPeUs2Q1QySi9IMVhSQjhCOFcyN0w2ZjJHSEFr?=
 =?utf-8?B?ejZoQndnNDVjaGZBd2VwY3NPQUdIT255RDZmUWN0RWM2cTZ5TGtPOEYwVEpH?=
 =?utf-8?B?TjJFL1dvQlNINHB6K2RlQUs5YnJNMWpWSGhiM00zL2VmZmZ0OFNvdEE2NXhP?=
 =?utf-8?B?Q042WVIwRy83QzdLSUg3SmJYYlFrdUh4QXVDdmdXa0V0cGF4QjJhRGEyTEhk?=
 =?utf-8?B?NnorMElqVW1tRy96U0FjR05SekZ3M2dacjJObWNXV3JYMmxhYkFOYTRERzho?=
 =?utf-8?B?ZTN2M3NSN2E5WWM4endvZHR6WElXVXpvS2dPM01Ca04rbkpGY21YZGxqWTVv?=
 =?utf-8?B?SEtnOVAyb2Q5cjVQRlhPNTBPL2l6U2V4VlRaM2NUenRKQnY2U0ZFUG8wMHNR?=
 =?utf-8?B?WkhIQ1RRNG1mR0lsbXEvdnJtWXNiazNMSiszVWEwa09IMnhhc2dvVEdWY3kx?=
 =?utf-8?B?ZlBhUlErem9hbjlNUVZiSVFUWStGQkVyUEQxLzZzUFlsbXJDQmViL0t1RVEw?=
 =?utf-8?B?ODFjUlFpMHAxMmhGeFgvYmtwSmFWRVJNTXZXVWRGODAyYURGQll3cmZ3bFIz?=
 =?utf-8?B?RkVYdThmKzVMejBZcjZaZFRXM1laNE5oV0hKc0xQSnBmWEZxUFZ5NWtuTjR5?=
 =?utf-8?B?UkdoYi9NYmY2V3g2WUtDeG5iZ3VBaXRITGw3MmVMZXJ2d2ErZE1ydnVmMXJX?=
 =?utf-8?B?LzhDTTBLTUFUUlNEZzRjclIyZHZvK0d3dzBpWk1PRDdLTG1YT3NoeWFNRUdC?=
 =?utf-8?B?S29PWU5Od2RPUS94WkdpcUx3UnFxcW5SL1JRMlFidFlSODFqRi9laUtFZmRh?=
 =?utf-8?B?dkUzbktLanpnWE9RUlRjeFRDQU1EQVVaK2dEcFdvUDJPWFhGWXMrRDJ1TDR6?=
 =?utf-8?B?TFZ4VnErdUFHSUVDVFMrV2N6M2lSa1JaR3l1cnRQSGRKVGkwSm5mOUw2NHpJ?=
 =?utf-8?B?Z2dSUnBGK1FvdnFOcjNvQW5BbHJQTTIvZFBDR3JOY1Q5RmhITllidmRKUEdh?=
 =?utf-8?B?eC9aK05SaDRncS9SK25Sa0toZkFCKzZtazhZMzNPU0NHL1g5cldHQ0hybUxr?=
 =?utf-8?B?K2RlNFlCbk04NnpyS1pHK1ZNU2o4NTVkZ1Rrd0JkUFRQNDZESTNhQkhkMmor?=
 =?utf-8?B?b3NhSnNSVktobElBQnFJTHFuc2J1MEJhSkIxYmdEZkVEWG1ZRytlYlhkekd2?=
 =?utf-8?B?WGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F390A5864B043243B8093EEFFE56F526@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 009e6683-4bb0-4877-6aad-08dc4c9ab1a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2024 07:10:46.8724
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e7mM6D1K3Nwi4QB1UfHU6aBRTx0uYiVOA+ilpBXdME+US9qu0/iDKFgpX+I4Re3LWvGMG79ObqO/jGmcAMH2ArGaj/LChj1AezM9JHkWo/1oblqHLGPkfJG4rciCxVAf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4880

SGkgS3J6eXN6dG9mLA0KDQpPbiAyMy8wMy8yNCAzOjU0IHBtLCBLcnp5c3p0b2YgS296bG93c2tp
IHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0
YWNobWVudHMgdW5sZXNzIHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IE9uIDIy
LzAzLzIwMjQgMDk6MjgsIFBhcnRoaWJhbi5WZWVyYXNvb3JhbkBtaWNyb2NoaXAuY29tIHdyb3Rl
Og0KPj4+Pg0KPj4+PiAgICAgICAgICAtIGNvbnN0OiBtaWNyb2NoaXAsbGFuODY1MA0KPj4+Pg0K
Pj4+PiAgICAgICAgICAtIGl0ZW1zOg0KPj4+Pg0KPj4+PiAgICAgICAgICAgICAgLSBjb25zdDog
bWljcm9jaGlwLGxhbjg2NTENCj4+Pj4NCj4+Pj4gICAgICAgICAgICAgIC0gY29uc3Q6IG1pY3Jv
Y2hpcCxsYW44NjUwDQo+Pj4+DQo+Pj4+IEV4ZWN1dGVkIGR0X2JpbmRpbmdfY2hlY2sgd2l0aCB0
aGUgYWJvdmUgdXBkYXRlIGFuZCBpdCB3YXMgc3VjY2Vzc2Z1bC4NCj4+Pj4gSG9wZSB0aGlzIGlz
IE9LPw0KPj4+DQo+Pj4gVGhpcyBpcyB0aGUgdGhpcmQgdGltZSB5b3UgYXNrIHVzLiBOb25lIG9m
IHRoZSBwcmV2aW91cyBjYXNlcyB3ZXJlDQo+Pj4gYWN0dWFsbHkgdGVzdGVkLiBNYXliZSB0aGlz
IG9uZSB3YXMsIG1heWJlIG5vdC4gSSBhc3N1bWUgdGhlIGxhdHRlci4NCj4+Pg0KPj4+IEZpcnN0
LCB0ZXN0IHlvdXIgY29kZS4NCj4+IEFzIEkgbWVudGlvbmVkIGluIHRoZSBwcmV2aW91cyBlbWFp
bCBpdHNlbGYsIEkgdGVzdGVkIHRoaXMgY2FzZSBhbmQgdGhlDQo+PiBwcmV2aW91cyBjYXNlIGJv
dGggaW4gbXkgUlBJIDQgc2V0dXAgYmVmb3JlIHJlcGx5aW5nIHRvIHRoZSBjb21tZW50LiBUaGUN
Cj4gDQo+IEkgZG9uJ3QgdW5kZXJzdGFuZCBob3cgb25lIGNhbiB0ZXN0IGJpbmRpbmdzIGFuZCBE
VFMgb24gUlBJIDQuIFRlc3RpbmcNCj4gaXMgd2l0aCBkdF9iaW5kaW5nc19jaGVjayBhbmQgZHRi
c19jaGVjay4NCk9rLCBtYXkgYmUgSSBoYWQgYSBtaXN1bmRlcnN0YW5kaW5nIGhlcmUuIEV2ZXJ5
IHRpbWUgSSB1c2VkIHRvIHRlc3QgdGhlIA0KZHJpdmVyIHdpdGggdGhlIGdlbmVyYXRlZCBkdHMg
aW4gUlBJIDQuIEkgdGhvdWdodCB5b3UgYXJlIGFza2luZyBhYm91dCANCml0LiBJIHVzZWQgdGhl
IGJlbG93IGNvbW1hbmRzIHRvIGNoZWNrIHRoZSBkdCBiaW5kaW5ncyBhbmQgZHRicy4NCg0KJCBt
YWtlIEFSQ0g9YXJtIENST1NTX0NPTVBJTEU9YXJtLWxpbnV4LWdudWVhYmloZi0gDQpEVF9TQ0hF
TUFfRklMRVM9RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL25ldC9taWNyb2NoaXAs
bGFuODY1eC55YW1sIA0KZHRfYmluZGluZ19jaGVjaw0KDQokIG1ha2UgQVJDSD1hcm0gQ1JPU1Nf
Q09NUElMRT1hcm0tbGludXgtZ251ZWFiaWhmLSANCkRUX1NDSEVNQV9GSUxFUz1Eb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbmV0L21pY3JvY2hpcCxsYW44NjV4LnlhbWwgDQpkdGJz
X2NoZWNrDQoNClRoZXkgZGlkbid0IHJlcG9ydCBhbnkgZXJyb3IuDQoNCkJlc3QgcmVnYXJkcywN
ClBhcnRoaWJhbiBWDQo+IA0KPiANCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQo+
IA0KPiANCg0K

