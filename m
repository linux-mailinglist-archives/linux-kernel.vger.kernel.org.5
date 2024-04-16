Return-Path: <linux-kernel+bounces-147042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 310A88A6EA1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 16:41:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BF651F22D96
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 14:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BE6312EBD0;
	Tue, 16 Apr 2024 14:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="kVPhWSra"
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D9912DDBF;
	Tue, 16 Apr 2024 14:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713278478; cv=fail; b=nn6/wnBBkGf+2EORbZnaU/S2C2FXzfuc8rRyRdZsi+jcWrUzbbCDErkYCvGZqr6a/0Ot5+N3K2ZwTOBVOT9U+0pqm7SUirJBj5Yp3bj0ZPbXdp8yJ0bZOdUIpupYIHKgx86D8HpYFYZPMfMLitcFpo2pcwDWrz5vAGHF9a8D3wE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713278478; c=relaxed/simple;
	bh=bTbmVpWlHMAynGu9JrWeS6uHRMQ+vJYnH4xEgL9R2pU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KirOVA4vyeVhc2kf/8hRAhpzDd2EYgrhrFBow0aCWhDJOx6Hs5bJYz+Ua4gwSpo7wN8u3vnh/VaxSra+x7oNTYEcqY9Mk5eQ/DP1U8FnT2FVHXU/UU6v6443Uy2xWf4p7rF+2EDWQvnezTD989YFlZSZxsICrQgmS786jvZF+fQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=kVPhWSra; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43GB6fvM028048;
	Tue, 16 Apr 2024 10:41:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=DKIM;
	 bh=bTbmVpWlHMAynGu9JrWeS6uHRMQ+vJYnH4xEgL9R2pU=; b=kVPhWSraJpFr
	v7UKggiwfePWpsz2pxblpazJzFQkgBqJyom92M997yyTa4nm3KM3BUT0GsgFt7BZ
	9OcuMlDPuO34qEAc0N+ERoEa5AjEjABUc89xlm9nUf6oyGQJ9dpwl5//79SM0ouq
	RIISi/ozHucIUSy82rLCa+CCUY4WEd66A6oeaLWcmSzFk9tVfmSYog7+t8gzEEbC
	7sI7ZsO7sqxZ4d9OMpW7ZQ+oRD5grS6EfBY+od1zxlMgCVbSUe+CnR9aasVNbFjf
	CjNZ88DmLVTyn9CR4SHu0OYJTyFnwL8U+sICKDcWKrI48MQJWSZkFSa2e5iLkX2M
	V7+h7rHWUQ==
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3xhr5xgs5p-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Apr 2024 10:41:00 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LMudig38kNQLnJZp66YZgLBSPk3NkPWp/u4TlmDtrdn5C827g+o0rosyoH2/4t3Rfeks1d5voyJdpEzh8F8Q9HhVde1HL8HvU8LSQSCNBFfsqWbdJY+krY7jbG2fzXbhCSQnbB61gUtQAuM80fcjvHMuRAAAI4G8osLsO7gsBCsmiDgZdAZutsOICFz6IETVLqeF9yLTAGk+P+cUrPSvYTt6FSITQDwSVNSMBdUSzpt1dkdWy2Z0C1zz2dbY+q2EY4bX33k0G3pvm7gTBwTK1QIROD42o9kY1m5zc+i7KcUdpVKwq3nDH+mwfnDfYIo+ieaJyswwy2z2TIKUk1hYYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bTbmVpWlHMAynGu9JrWeS6uHRMQ+vJYnH4xEgL9R2pU=;
 b=jt9BuNexVYTNFePyDxVuWHvHU1yDDM8ueTBjqzG7WVEFOLsN739luwu3nF43cVTHSrKhlLLkDxHFFjUM5ko75dCXtmb7v3i4yFAzeT61a2lDLXgOXtyJ+9ecGmuR5781eOALX09Fn+zjAhAGyKpMkxuCJgqjR3jSSqYQXRuzo2jugPiVPwwQxs9/Ve+zvNL3pgkjTh/yifteR9C56vO7OJ55Mm/nvMRsSr7EskSZ8uDe5tfiOegIo7KZqwAMlMCsrvdhVcCKy44d45xPDgm5myyki/rPwKIzps4aZjk9/Fnrngm6h1OBr6rcgCQTz6D61VQVNhPkoau3OamYb/i49w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from PH0PR03MB7141.namprd03.prod.outlook.com (2603:10b6:510:296::20)
 by MN2PR03MB5197.namprd03.prod.outlook.com (2603:10b6:208:1f0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 14:40:57 +0000
Received: from PH0PR03MB7141.namprd03.prod.outlook.com
 ([fe80::116a:391a:ba0d:7538]) by PH0PR03MB7141.namprd03.prod.outlook.com
 ([fe80::116a:391a:ba0d:7538%6]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 14:40:56 +0000
From: "Paller, Kim Seer" <KimSeer.Paller@analog.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lars-Peter
 Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Liam
 Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        "Hennerich,
 Michael" <Michael.Hennerich@analog.com>
Subject: RE: [PATCH 1/4] dt-bindings: iio: dac: Add adi,ltc2664.yaml
Thread-Topic: [PATCH 1/4] dt-bindings: iio: dac: Add adi,ltc2664.yaml
Thread-Index: AQHajR+YT0X5TsusMUGJfQChAmxz3bFmTf0AgAAVKoCAAA2NgIAEfTsg
Date: Tue, 16 Apr 2024 14:40:56 +0000
Message-ID: 
 <PH0PR03MB714170F4494EA0E1B4112291F9082@PH0PR03MB7141.namprd03.prod.outlook.com>
References: <20240412032102.136071-1-kimseer.paller@analog.com>
	<20240412032102.136071-2-kimseer.paller@analog.com>
	<CAMknhBHgKK_OEcPz-5ktxj+YEkB7jHpw5owdh9HVj_qfwuVXkQ@mail.gmail.com>
	<20240413160610.4cec010b@jic23-huawei>
	<CAMknhBHMd2mK3yVoH_XjW7BapX5BTRZjUJpF=ZQrF8Mctf-NJQ@mail.gmail.com>
 <20240413181025.39d1a62e@jic23-huawei>
In-Reply-To: <20240413181025.39d1a62e@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: 
 =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jYTNCaGJHeGxjakpjWVhCd1pHRjBZVnh5YjJGdGFXNW5YREE1WkRnME9X?=
 =?utf-8?B?STJMVE15WkRNdE5HRTBNQzA0TldWbExUWmlPRFJpWVRJNVpUTTFZbHh0YzJk?=
 =?utf-8?B?elhHMXpaeTAxTWpVMU1HVXhPQzFtWW1abUxURXhaV1V0WVdGbE5DMW1PR1Uw?=
 =?utf-8?B?TTJJek0yUTJObVZjWVcxbExYUmxjM1JjTlRJMU5UQmxNV0V0Wm1KbVppMHhN?=
 =?utf-8?B?V1ZsTFdGaFpUUXRaamhsTkROaU16TmtOalpsWW05a2VTNTBlSFFpSUhONlBT?=
 =?utf-8?B?SXhNRFUyTmlJZ2REMGlNVE16TlRjM05USXdOVE0wT1RReE1URTBJaUJvUFNK?=
 =?utf-8?B?UFpETllSM0J2Vm14bE5HUXJNVTFFVFU4NFlUazJTa3BKWVVFOUlpQnBaRDBp?=
 =?utf-8?B?SWlCaWJEMGlNQ0lnWW04OUlqRWlJR05wUFNKalFVRkJRVVZTU0ZVeFVsTlNW?=
 =?utf-8?B?VVpPUTJkVlFVRkZiME5CUVVNMllsaFpWa1JLUkdGQldFcERWbElyUVRWblZH?=
 =?utf-8?B?eGphMHBXU0RSRWJVSlBWVVJCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJTRUZCUVVGRVlVRlJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlJVRkJVVUZDUVVGQlFYWnpSMHByVVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VW8wUVVGQlFtaEJSMUZCWVZGQ1prRklUVUZhVVVKcVFVaFZRV05uUW14QlJq?=
 =?utf-8?B?aEJZMEZDZVVGSE9FRmhaMEpzUVVkTlFXUkJRbnBCUmpoQldtZENhRUZIZDBG?=
 =?utf-8?B?amQwSnNRVVk0UVZwblFuWkJTRTFCWVZGQ01FRkhhMEZrWjBKc1FVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGRlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFXZEJRVUZCUVVGdVowRkJRVWRGUVZwQlFuQkJSamhCWTNkQ2JFRkhUVUZr?=
 =?utf-8?B?VVVKNVFVZFZRVmgzUW5kQlNFbEJZbmRDY1VGSFZVRlpkMEl3UVVoTlFWaDNR?=
 =?utf-8?B?akJCUjJ0QldsRkNlVUZFUlVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJV?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVU5CUVVGQlFVRkRaVUZCUVVGWlVVSnJRVWRyUVZoM1Fu?=
 =?utf-8?B?cEJSMVZCV1hkQ01VRklTVUZhVVVKbVFVaEJRV05uUW5aQlIyOUJXbEZDYWtG?=
 =?utf-8?B?SVVVRmpkMEptUVVoUlFXRlJRbXhCU0VsQlRXZEJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUWtGQlFVRkJRVUZCUVVGSlFVRkJRVUZCUVQwOUlpOCtQQzl0?=
 =?utf-8?B?WlhSaFBnPT0=?=
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR03MB7141:EE_|MN2PR03MB5197:EE_
x-ms-office365-filtering-correlation-id: c47e870a-5921-4882-c6d8-08dc5e2339f7
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 stKyX+aKUcDfqvPpcsk8IMmUGsHmFt3Nx/tGtjxY2s2z7V2gexGOhXXW5RO93W13WxAUMHfZnJicqcaxaeB/2BtGtlfmRI6G4/chrJkQ0ptkM9RrDqmVkMlwxhc9+Okt5ogYrXZZ0fLYVm3P/pdw/YvtfKL3ivFXyso6f38R+6QWVu1mX3PNfYiit1nL7KnY1ssScIGxWUHwqhIq40o5+c1NSDQOgXjB0Jtivc4CAZENq8DvPSx7J6QiLjmRKoQxVwlWrMSKX0w9Hs93rgJXODsrjDOwkr4e2aJNkW+Sscx6wC0B+/fCQQ0gv3/FLh4OgyJ/hiYpdDzlCycOEVcdhgcqpJnccyei3snyDvVaB6pZ22TC0yO9yUCdCWOVFIQar7NKzxL4LnhR0m0NwEX3ko7Fg8V/93ER+nYF7jonkV9zbQqhT1NjeNCFsd4/PL4UXSQ6DcrGkVwVkKVwRNGFFj9aAkAQnifrxlaooT04tOjBMpveDFwis0B2oBCEqoY7w5YYrOPsjbQsKx6PqxjtO3d2EWMulijf7yRMMAAqQOnVoP+xvbECKibCaDmy+Jrp5LOia7J7uQxmdFEjZYV3zm6V0MsF2NxTIwBjBpnubTlGXBJrTQaWSTr/q4659oQbCqdC/wwkupQ4XRKyHoQXXcE8ebGu6jIw5sXnBjQeGeoBQMv8dinYT/O8s4sG5HbLw2PC6HxMMZ0syhsj6FoUQ07oEs7fKtmSi29+P2lQZ44=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB7141.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?emdVRncrV3JMMUtsQ1lHUXl2OWdNZFR1bXVZWEtIVVdyWVZpam40bGVkeDlQ?=
 =?utf-8?B?c2lLSk9EdTQ4Q3M0OEVyNmFEVXU1SFYvaDJPZ1BBSkx4Ykd3RksvVHNkWWNs?=
 =?utf-8?B?dStTbEJHMVZOM3d5SFY4NG5GUUo5a05BWXd5alF1RXord0JJVzlVN3FRKzJs?=
 =?utf-8?B?aDRoK2VHZVBCVzRpb1YzZmU5QkhrVjdVWEhlanl0TktKTXYrdFRSSDBXci9P?=
 =?utf-8?B?RnZYT1gwUTZFRHVYalAvakVlclMvWE4xMWFiYnF5MWhYY3FWUVA1RkgwWEVD?=
 =?utf-8?B?b2ZBQW8xRnF4OFByR01PcXV2bUwyY0ZaeU9PN3BDOHV6MVdVNjd2ODRidE9l?=
 =?utf-8?B?czVxWHFIVzlZMWYwRUtaK3BEVC9Kd0U3Ull6L1E4YkliR3kwUTN5cXI5YWxq?=
 =?utf-8?B?M3d1a3U0eXVrMjhMVVc4dk5UVm9KWittSnI2SDVpc1VTS1JDN0FRY3RzZ05n?=
 =?utf-8?B?RS8rVXJLbHN0cFBzOXpVcTRVR1NWRWY2ZDJxbmV3N2xYUzBtclE1YXJRenl2?=
 =?utf-8?B?aDRjRWhmSEx1bVdTOG5OeEpBenJPTDhidEZISXZqNGRaZm84K2ZWa1RubkNh?=
 =?utf-8?B?OFlOc0lUNDRRSUJIQUxLZDZrZkEyc2JibFdsMUZEOHJXSG55eEVpQlhCblZI?=
 =?utf-8?B?MFpjODcwK1U5b292cWtYOWlVSU11Y1BqWERkNGxRMm8zaGV1YTJKaFRiU0No?=
 =?utf-8?B?cjRIcy9nb3M3RTNid0NSa3NkK1Q3ejExYlBqS1NYMlEzVHFaVmNVM1BIcWlj?=
 =?utf-8?B?WG5mdi96UkwxMngyN3NiOWtZUHdhNllLaXN3SWw1eDhUSXZUdHh0eDBxODdW?=
 =?utf-8?B?QXpSNHQ3bnhrMGRFcVpXOHBMVmhZekl1OVBaSk5jNWc5R2tZcGd2N04wTm12?=
 =?utf-8?B?RGw5UGVwcXovWG5ZVmFjQTlvbTBVaStjdkJtRkZ2bWYrZ2paM29YL2M5TkIx?=
 =?utf-8?B?UkJMclVNZjVTV3Vqd2dnYThVV3hOc2p6S29PZkRXZUJZWStVR2l1dWVTUmtS?=
 =?utf-8?B?UVYvUjg0Y2owQ3JOQ0RMUWFSbk1KYnhka3NJNW9WdkFNYzBzNlVWTXNZYXVz?=
 =?utf-8?B?SHBNRHlJTlZ5TU9vQjJ2RmFtWmZ6blp3RjF3T2dpWGZ6cFNWUE9pSmZsUVB5?=
 =?utf-8?B?bzBidHVnNjlqQ3BLeHFFLzgrb3BsNFd2Y3JBMHVuYTVnTG9BTG0yMzF5c3FL?=
 =?utf-8?B?dHN4YXJpS1poVUZXRXZ3RFlQeDdBKzE2Q01JbTZmdUszVm8xSzRKdEFvZ2xJ?=
 =?utf-8?B?Y0JacUJiMDFITmVMbWQ2eHBsRjNLbi9TZ0t4b0NseGJLZ293QllmaUtlN1M2?=
 =?utf-8?B?S1dhTkVmTUIzbzFBMWpiWjJBQThRN0gxdzNDZ2VVVThhbWRnYnNORVE0UEt2?=
 =?utf-8?B?OWhMUlI2T2MvckNHZFRPT1kyaU1scjhsaE9YZ2I5d3FhZEx4eDA0NkxXR3h5?=
 =?utf-8?B?NGRwU1EyYXIyUzZYVU5JVkkxNlgzKzV6aE85YVJmMk9QdzhOQkkvdEllQUxS?=
 =?utf-8?B?TnFuUDhwcmpuN0xRZGhkYzVnWE9yUFpzd3pwVHQzS3Izc3ozUGFhd0RzU0kw?=
 =?utf-8?B?d1VYVFZEK0FhSVBIdUxZTVhLUldaNjhJd01jZHErQW5qVDhyZE9tZU03UXVG?=
 =?utf-8?B?ZzJvSktKOHU4bHR4OG1jSldVRFoxbzQwSW1jNkxmQmtQZVdRelcwaWtjdmJs?=
 =?utf-8?B?bUE3ZzBscVRYUk51RytvVXFxVE9PV0hMMDhuZHYwUSt6TnkrT0Vac2oxdXpF?=
 =?utf-8?B?ZGRyUThZTTlDVm1ySmJDYlMxMDZ4ZTFhVm5EcklNT0hoU3Rwbkp1b2tMMDdP?=
 =?utf-8?B?MlpLME0vdllQZW51YWJkK3g0NjY4YmpZdGE3SGlpNFZoSGptcXZqbTRiSEs0?=
 =?utf-8?B?NTFya0wwMHgraXI4THlUaWZlYWJGeFBDbC9mV3h4QTZ5eWtsWFM0L3FTQ2Rt?=
 =?utf-8?B?dEMwd0tSR0FYMURTMGY0ZHAwWDBCdkF1dmtIbDFBcitRN1JlZ3dQLzBZN0Ji?=
 =?utf-8?B?MVhMdWZSK21IKzBMNkZ1Wk9ZMTVTSjRYcm96djk4Q2ZKaXlxUnJUakY2WnBK?=
 =?utf-8?B?UE9tdllIZ0M0WWtEMEt6UTBhOG1jcEsyRC9NSkZjK3BJQXZRditnWXh0bWRz?=
 =?utf-8?Q?+AaWbNcX4D1hg8duJsHsrwskO?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB7141.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c47e870a-5921-4882-c6d8-08dc5e2339f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2024 14:40:56.8671
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +f7y0aVGrUtMIIg3mw3JGnLdGXmYxCToOgPD11APeABXXWypQdaPpTgXVLT8ZSp4VmtkiSRbB+VueXev8odO/EttSbByUycdRG+89n30XFc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB5197
X-Proofpoint-GUID: 5Nvz3DLMKfyfpAuF4UlSRBTyUrOtxPt4
X-Proofpoint-ORIG-GUID: 5Nvz3DLMKfyfpAuF4UlSRBTyUrOtxPt4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-16_10,2024-04-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 spamscore=0 malwarescore=0 adultscore=0 clxscore=1015
 lowpriorityscore=0 priorityscore=1501 phishscore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404160089

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKb25hdGhhbiBDYW1lcm9uIDxq
aWMyM0BrZXJuZWwub3JnPg0KPiBTZW50OiBTdW5kYXksIEFwcmlsIDE0LCAyMDI0IDE6MTAgQU0N
Cj4gVG86IERhdmlkIExlY2huZXIgPGRsZWNobmVyQGJheWxpYnJlLmNvbT4NCj4gQ2M6IFBhbGxl
ciwgS2ltIFNlZXIgPEtpbVNlZXIuUGFsbGVyQGFuYWxvZy5jb20+OyBsaW51eC1paW9Admdlci5r
ZXJuZWwub3JnOw0KPiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZn
ZXIua2VybmVsLm9yZzsgTGFycy1QZXRlciBDbGF1c2VuDQo+IDxsYXJzQG1ldGFmb28uZGU+OyBS
b2IgSGVycmluZyA8cm9iaEBrZXJuZWwub3JnPjsgS3J6eXN6dG9mIEtvemxvd3NraQ0KPiA8a3J6
eXN6dG9mLmtvemxvd3NraStkdEBsaW5hcm8ub3JnPjsgQ29ub3IgRG9vbGV5IDxjb25vcitkdEBr
ZXJuZWwub3JnPjsNCj4gTGlhbSBHaXJkd29vZCA8bGdpcmR3b29kQGdtYWlsLmNvbT47IE1hcmsg
QnJvd24gPGJyb29uaWVAa2VybmVsLm9yZz47DQo+IEhlbm5lcmljaCwgTWljaGFlbCA8TWljaGFl
bC5IZW5uZXJpY2hAYW5hbG9nLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCAxLzRdIGR0LWJp
bmRpbmdzOiBpaW86IGRhYzogQWRkIGFkaSxsdGMyNjY0LnlhbWwNCj4gDQo+IFtFeHRlcm5hbF0N
Cj4gDQo+IE9uIFNhdCwgMTMgQXByIDIwMjQgMTE6MjE6NTUgLTA1MDANCj4gRGF2aWQgTGVjaG5l
ciA8ZGxlY2huZXJAYmF5bGlicmUuY29tPiB3cm90ZToNCj4gDQo+ID4gT24gU2F0LCBBcHIgMTMs
IDIwMjQgYXQgMTA6MDbigK9BTSBKb25hdGhhbiBDYW1lcm9uIDxqaWMyM0BrZXJuZWwub3JnPg0K
PiB3cm90ZToNCj4gPiA+DQo+ID4gPiBPbiBGcmksIDEyIEFwciAyMDI0IDE2OjIzOjAwIC0wNTAw
DQo+ID4gPiBEYXZpZCBMZWNobmVyIDxkbGVjaG5lckBiYXlsaWJyZS5jb20+IHdyb3RlOg0KPiA+
ID4NCj4gPiA+ID4gT24gVGh1LCBBcHIgMTEsIDIwMjQgYXQgMTA6MjHigK9QTSBLaW0gU2VlciBQ
YWxsZXINCj4gPiA+ID4gPGtpbXNlZXIucGFsbGVyQGFuYWxvZy5jb20+IHdyb3RlOg0KPiA+ID4g
PiA+DQo+ID4NCj4gPiAuLi4NCj4gPg0KPiA+ID4gPg0KPiA+ID4gPiBBbmQgdGhlcmUgaXMgVn4g
b24gYm90aCB3aGljaCBjYW4gYmUgYmV0d2VlbiAtNS41Vi8tMTUuNzVWIGFuZCBHTkQsIHNvDQo+
ID4gPiA+IG9wdGlvbmFsIHYtbmVnLXN1cHBseSBzZWVtcyBhcHByb3ByaWF0ZS4NCj4gPiA+DQo+
ID4gPiBPbmx5IG1ha2UgaXQgb3B0aW9uYWwgaW4gdGhlIGJpbmRpbmcgaWYgdGhlIHNldHRpbmdz
IG9mIHRoZSBkZXZpY2UgY2hhbmdlDQo+ID4gPiBkZXBlbmRpbmcgb24gd2hldGhlciBpdCBpcyB0
aGVyZSBvciBub3QuICBMb29rcyBsaWtlIHRoZXJlIGlzIGFuIGludGVybmFsDQo+ID4gPiByZWZl
cmVuY2UsIHNvIG1heWJlIGl0IHJlYWxseSBpcyBvcHRpb25hbC4NCj4gPg0KPiA+IEkgc3VnZ2Vz
dGVkIG9wdGlvbmFsIHdpdGggdGhlIHRoaW5raW5nIHRoYXQgaWYgdGhlIHBpbiBpcyB0aWVkIHRv
IEdORCwNCj4gPiB0aGVuIHRoZSBwcm9wZXJ0eSB3b3VsZCBiZSBvbWl0dGVkLg0KPiANCj4gV2Ug
Y291bGQgYnV0IGdpdmVuIFZORCBpc24ndCByZWFsbHkgdGhhdCBzcGVjaWFsIGluIHRoaXMgY2Fz
ZSBJIHRoaW5rDQo+IEknZCBwcmVmZXIgYSBmaXhlZCB2b2x0YWdlIHJlZyBvZiAwViBpZiBzb21l
b25lIGRvZXMgd2lyZSBpdCBsaWtlIHRoYXQuDQo+IChJIHRoaW5rIHRoYXQgd29ya3MsIHRob3Vn
aCBub3Qgc3VyZSBJJ3ZlIHRyaWVkIGEgMFYgc3VwcGx5IDspDQoNClRvIGNsYXJpZnksIGRvZXMg
dGhpcyBtZWFuIHdlIHNob3VsZCBzdGlsbCBhZGQgYW4gb3B0aW9uYWwgcHJvcGVydHkgZm9yIGl0
IGluIHRoZSBiaW5kaW5nPw0KDQo+ID4gLi4uDQo+ID4NCj4gPg0KPiA+ID4gPg0KPiA+ID4gPiAq
IChib3RoKSBUaGUgTVVYL01VWE9VVCBwaW5zIGxvb2sgbGlrZSB3ZSBoYXZlIGFuIGVtYmVkZGVk
IHBpbiBtdXgsDQo+IHNvDQo+ID4gPiA+IGl0IGNvdWxkIG1lYW4gd2UgbmVlZCAjcGluY3RybC1j
ZWxscy4gbHRjMjY2NCB3b3VsZCBhbHNvIG5lZWQNCj4gPiA+ID4gbXV4aW4tZ3Bpb3MgZm9yIHRo
aXMuDQo+ID4gPiBOb3QgY29udmluY2VkIHRoYXQncyB0aGUgcmlnaHQgYXBwcm9hY2ggLSBsb29r
cyBtb3JlIGxpa2UgYSBjaGFubmVsDQo+ID4gPiBzZWxlY3RvciB0aGFuIGEgY29udmVudGlvbmFs
IG11eCBvciBwaW4gY29udHJvbC4gU3VyZSB0aGF0J3MgYSBtdXgsIGJ1dA0KPiA+ID4gd2Ugd2Fu
dCBhIGNsZWFuIHVzZXJzcGFjZSBjb250cm9sIHRvIGxldCB1cyBjaG9vc2UgYSBzaWduYWwgdG8g
bWVhc3VyZQ0KPiA+ID4gYXQgcnVudGltZQ0KPiA+ID4NCj4gPiA+IElmIHlvdSB3YW50ZWQgdG8g
c3VwcG9ydCB0aGlzIEknZCBoYXZlIHRoZSBiaW5kaW5nIGRlc2NyaWJlIG9wdGlvbmFsDQo+ID4g
PiBzdHVmZiB0byBhY3QgYXMgYSBjb25zdW1lciBvZiBhbiBBREMgY2hhbm5lbCBvbiBhbm90aGVy
IGRldmljZS4NCj4gPiA+IFRoZSBJSU8gZHJpdmVyIHdvdWxkIHRoZW4gcHJvdmlkZSBhIGJ1bmNo
IG9mIGlucHV0IGNoYW5uZWxzIHRvIGFsbG93DQo+ID4gPiBtZWFzdXJlbWVudCBvZiBlYWNoIG9m
IHRoZSBzaWduYWxzLg0KPiA+ID4NCj4gPiA+IExvb2sgYXQgaW8tY2hhbm5lbHMgZXRjIGluIGV4
aXN0aW5nIGJpbmRpbmdzIGZvciBob3cgdG8gZG8gdGhhdC4NCj4gPiA+DQo+ID4NCj4gPiBSaWdo
dC4gSSB3YXMgdGhpbmtpbmcgdGhhdCB0aGlzIHBpbiBtaWdodCBiZSBjb25uZWN0ZWQgdG8gc29t
ZXRoaW5nDQo+ID4gZWxzZSBleHRlcm5hbCByYXRoZXIgdGhhbiB0aGUgc2lnbmFsIGNvbWluZyBi
YWNrIHRvIHRoZSBTb0MgKG9yDQo+ID4gd2hhdGV2ZXIgaGFzIHRoZSBTUEkgY29udHJvbGxlciku
IEJ1dCBpdCBtYWtlcyBtb3JlIHNlbnNlIHRoYXQgd2UNCj4gPiB3b3VsZCB3YW50IGl0IGFzIGV4
dHJhIGNoYW5uZWxzIGJlaW5nIHJlYWQgYmFjayBieSB0aGUgU29DIGZvcg0KPiA+IGRpYWdub3N0
aWNzLg0KPiANCj4gSXQgbWlnaHQgaW5kZWVkLiAgQnV0IEkgdGhpbmsgdGhhdCdzIGFuIGV4ZXJj
aXNlIGZvciB0aGUgZnV0dXJlIGlmDQo+IGl0IG1hdHRlcnMuICBNaWdodCBiZSBhIGRlYnVnZnMg
Y29udHJvbCBvbmx5IHBlcmhhcHMuDQoNCldlIGNhbiBjb25zaWRlciBwb3RlbnRpYWwgZnV0dXJl
IHVzZSBjYXNlcyBhcyB0aGV5IGJlY29tZSByZWxldmFudC4NCkZvciBub3csIHdlIG1pZ2h0IG5v
dCB0byBpbmNsdWRlIG9yIHN1cHBvcnQgdGhpcyBmdW5jdGlvbmFsaXR5Lg0KDQo+ID4NCj4gPiAu
Li4NCj4gPg0KPiA+ID4gPg0KPiA+ID4gPiA+ICsNCj4gPiA+ID4gPiArICAgICAgcGF0dGVyblBy
b3BlcnRpZXM6DQo+ID4gPiA+ID4gKyAgICAgICAgIl5jaGFubmVsQChbMC0zXSkkIjoNCj4gPiA+
ID4gPiArICAgICAgICAgICRyZWY6ICcjLyRkZWZzL3RvZ2dsZS1vcGVyYXRpb24nDQo+ID4gPiA+
ID4gKyAgICAgICAgICB1bmV2YWx1YXRlZFByb3BlcnRpZXM6IGZhbHNlDQo+ID4gPiA+ID4gKw0K
PiA+ID4gPiA+ICsgICAgICAgICAgZGVzY3JpcHRpb246IENoYW5uZWwgaW4gdG9nZ2xlIGZ1bmN0
aW9uYWxpdHkuDQo+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ICsgICAgICAgICAgcHJvcGVydGllczoN
Cj4gPiA+ID4gPiArICAgICAgICAgICAgYWRpLG91dHB1dC1yYW5nZS1taWNyb3ZvbHQ6DQo+ID4g
PiA+ID4gKyAgICAgICAgICAgICAgZGVzY3JpcHRpb246IFNwZWNpZnkgdGhlIGNoYW5uZWwgb3V0
cHV0IGZ1bGwgc2NhbGUgcmFuZ2UuDQo+ID4gPiA+DQo+ID4gPiA+IEhvdyB3b3VsZCBzb21lb25l
IHdyaXRpbmcgYSAuZHRzIGtub3cgd2hhdCB2YWx1ZXMgdG8gc2VsZWN0IGZvciB0aGlzDQo+ID4g
PiA+IHByb3BlcnR5PyBPciBpcyB0aGlzIHNvbWV0aGluZyB0aGF0IHNob3VsZCBiZSBjb25maWd1
cmVkIGF0IHJ1bnRpbWUNCj4gPiA+ID4gaW5zdGVhZCBvZiBpbiB0aGUgZGV2aWNldHJlZT8gT3Ig
c2hvdWxkIHRoaXMgaW5mbyBjb21lIGZyb20gdGhlDQo+ID4gPiA+IG1pc3Npbmcgdm9sdGFnZSBz
dXBwbGllcyBJIG1lbnRpb25lZD8NCj4gPiA+DQo+ID4gPiBTb21ldGltZXMgdGhpcyBvbmUgaXMg
YSB3aXJpbmcgcmVsYXRlZCBjaG9pY2UuICBTb21ldGltZXMgdG8gdGhlIGV4dGVudA0KPiA+ID4g
dGhhdCBwaWNraW5nIHRoZSB3cm9uZyBvbmUgZnJvbSBhbnkgdXNlcnNwYWNlIGNvbnRyb2wgY2Fu
IGNhdXNlIGRhbWFnZQ0KPiA+ID4gb3IgaXMgYXQgbGVhc3Qgbm9uc2Vuc2UuDQo+ID4gPg0KPiA+
ID4gWW91IGxvb2sgdG8gYmUgcmlnaHQgdGhvdWdoIHRoYXQgdGhlIHBvc3NpYmxlIHZhbHVlcyBo
ZXJlIGFyZW4nIGZpbmUNCj4gPiA+IGlmIHRoZSBpbnRlcm5hbCByZWZlcmVuY2UgaXMgdXNlZCwg
YnV0IG5vdCB0aGUgZXh0ZXJuYWwuDQo+ID4gPg0KPiA+ID4gSG93ZXZlciwgaXQncyBrZXllZCBv
ZmYgTVBTIHBpbnMgc28geW91IGNhbid0IGNvbnRyb2wgaXQgaWYgdGhleSBhcmVuJ3QNCj4gPiA+
IHRpZWQgdG8gYWxsIGhpZ2guICBTbyBJJ2QgaW1hZ2luZSBpZiB0aGUgYm9hcmQgY2FuIGJlIGRh
bWFnZWQgaXQgd2lsbA0KPiA+ID4gYmUgaGFyZCB3aXJlZC4gIEhlbmNlIHRoZXNlIGNvdWxkIGJl
IGNvbnRyb2xsZWQgZm9ybSB1c2Vyc3BhY2UuDQo+ID4gPiBJdCdzIGEgYml0IGZpZGRseSB0aG91
Z2ggYXMgY29tYmluZXMgc2NhbGUgYW5kIG9mZnNldCBjb250cm9scyBhbmQNCj4gPiA+IHlvdSBj
YW4gZW5kIHRyeWluZyB0byBzZXQgdGhpbmdzIHRvIGFuIGludmFsaWQgY29tYmluYXRpb24uDQo+
ID4gPiBFLmcuIHNjYWxlIHNldCB0byBjb3ZlciAyMFYgcmFuZ2UgYW5kIG9mZnNldCBzZXQgdG8g
MFYNCj4gPiA+IFRvIGdldCBhcm91bmQgdGhhdCB5b3UgaGF2ZSB0byBjbGFtcCBvbmUgcGFyYW1l
dGVyIHRvIG5lYXJlc3QNCj4gPiA+IHBvc3NpYmxlIHdoZW4gdGhlIG90aGVyIGlzIGNoYW5nZWQu
DQo+ID4gPg0KPiA+DQo+ID4gVGhhbmtzIGZvciB0aGUgZXhwbGFuYXRpb24uIEl0IHNvdW5kcyBs
aWtlIEkgbWlzc2VkIHNvbWV0aGluZyBpbiB0aGUNCj4gPiBkYXRhc2hlZXQgdGhhdCB3b3VsZCBi
ZSBoZWxwZnVsIHRvIGNhbGwgb3V0IGluIHRoZSBkZXNjcmlwdGlvbiBmb3INCj4gPiB0aGlzIHBy
b3BlcnR5Lg0KPiBBZ3JlZWQgLSBpdCBuZWVkcyBtb3JlIGRldGFpbC4NCj4gDQo+IEpvbmF0aGFu
DQo+IA0KDQo=

