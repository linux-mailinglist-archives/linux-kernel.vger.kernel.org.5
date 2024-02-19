Return-Path: <linux-kernel+bounces-70996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A47859F2C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 10:06:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF16A2834D0
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 09:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A3762263E;
	Mon, 19 Feb 2024 09:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="AZJoeqpf"
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964B5224DC;
	Mon, 19 Feb 2024 09:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708333542; cv=fail; b=aEJVeIT5bQw5TCWctc+KgrpHoOd3Azw9XC5su/lxgV0uuxxgvH0Rk7lBU5H4bmYij0Rg1ys7ICoBf0ocqp7neuBWNlruJtg6RR6j3zZvTExS6H0ApnUDtSyRkTtGDPWq1bkxb/U9kcfPwVDYyH5DMmgj3Y133Rsu9SGrwU+wvhE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708333542; c=relaxed/simple;
	bh=GH3Lre5nvzqQ9EFnkN/E/fL6FQS59b5M0SCiNhgxyNc=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=omY/aSEBSEtrd8cjVroQ9QXowLhdgYd8DwLKlL6gOafm0CXwvNKu4SGJYZqMykeknB3bvL1rj1qVuuCVYXC+DjVNYOyL09KlOdOuFzxGh2SHttI6bf9dfvnWEIFrzYH3Sw3GnEDFXlrYgTgze2KZC6jAIGe3GLvlBBeOsrWawfo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=AZJoeqpf; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41J5xtkN011944;
	Mon, 19 Feb 2024 04:04:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	from:to:subject:date:message-id:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=DKIM;
	 bh=GH3Lre5nvzqQ9EFnkN/E/fL6FQS59b5M0SCiNhgxyNc=; b=AZJoeqpfK0C6
	jag1KPF4jU86+D0/CZa2+P2XzfVsUEMBy1uBqqvq9XIegssB35L2eFQFTCLEkRO7
	Bg/q/qo8X49KR8JE7xVz7Yjs3XKsffUyPzcEUBvvMdBa1xrvZqoFAvb0s68WVWb6
	88kECr3xz76oWrIadO8HGX1i3YPAJtO/ZndVChkGUP/vAPDYnCZKz2IweVlbVLn9
	ZaPw51lifGxeQIp6EhD/SJshNvcbVyWVDp7qMt+GIXxGKIBXwjbU2A6SQqP4z349
	7+GRmLBDXgqIERoowwPvTvFZ/uJyu/Cv1izQB837eyp48YTwkLf4bkttl1L+TWsN
	pvPf+Lnj1w==
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2168.outbound.protection.outlook.com [104.47.73.168])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3waqh8ee7h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Feb 2024 04:04:59 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GQhSWzcybp/9zF3r3jKGiRgEHcgLvgKfrptAjigIpodCn+sfGfQjE5oTJ1FEH1/aduDBb/cHQnHYh2gNrq+62OmJoztlQip+p37Hgle3XbAhEE0pTtPjXTs8X8p8Hkno7cNFCtimf0SMFLFWjsP6hg6P6cm2xaqIn+BGITw80JkXYXoFBejKg/CymE4dxrA7tx3uSnrKEV/iLpl2xa8FPc8/g64yZn05hwN4lVIv8f7emGhQf26+KQmvST9smTseDRBpvB7vBabi2uAOetSuzx71CuprC/XacxD9/a/lGXSqSNocZ9+n2vO7UCAvE73xD8SVr93fvtcfEB4zcAbZqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GH3Lre5nvzqQ9EFnkN/E/fL6FQS59b5M0SCiNhgxyNc=;
 b=oWv6fcQs/fzNqEOyo/gXNDujMXNHQkpZYOcgKhHqJsJ/vT1D/dZ8ki5iGAN0FlHgireb9ro0PFaM+F58VErs4xPD7BjZD1Zl4WXdJbdAU5ZLAYQJsMrbbhW/i7x44wRjym2jSw2+RU/bv8TZviyWXmpdRqPR7oxqTkI7wp0DcYKU8UM+oIvGN04mAA6G89w/RiccuwU/8qKGdOrBvZrsM+7/VEIn7k+yx81B82w0MY8YclBmtQu2FWtbcCN7/zeiYKnhcJI3AygAfwXRKEqwS/NlxLDPIuo3g3KOqwB/ClKi6xv04f/ZrEAcqf6rxGV6YFCJAZpgIE2cTIrreKJZsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from CY4PR03MB3399.namprd03.prod.outlook.com (2603:10b6:910:57::13)
 by PH8PR03MB7220.namprd03.prod.outlook.com (2603:10b6:510:25c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.38; Mon, 19 Feb
 2024 09:04:57 +0000
Received: from CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::7219:8129:91a1:7a99]) by CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::7219:8129:91a1:7a99%3]) with mapi id 15.20.7292.029; Mon, 19 Feb 2024
 09:04:57 +0000
From: "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>
To: Chris Packham <Chris.Packham@alliedtelesis.co.nz>,
        Alessandro Zummo
	<a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Jean
 Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>
Subject: RE: [PATCH v9 2/2] rtc: max31335: add driver support
Thread-Topic: [PATCH v9 2/2] rtc: max31335: add driver support
Thread-Index: AQHaG6lWID1+DdXCCUCxEqBnFjOMHLERheGAgABmKdA=
Date: Mon, 19 Feb 2024 09:04:57 +0000
Message-ID: 
 <CY4PR03MB3399F66B70302CD41D6DC82E9B512@CY4PR03MB3399.namprd03.prod.outlook.com>
References: <20231120120114.48657-1-antoniu.miclaus@analog.com>
 <20231120120114.48657-2-antoniu.miclaus@analog.com>
 <1a51a8ac-e2a6-4054-b91d-c860913b7385@alliedtelesis.co.nz>
In-Reply-To: <1a51a8ac-e2a6-4054-b91d-c860913b7385@alliedtelesis.co.nz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: 
 =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jWVcxcFkyeGhkWE5jWVhCd1pHRjBZVnh5YjJGdGFXNW5YREE1WkRnME9X?=
 =?utf-8?B?STJMVE15WkRNdE5HRTBNQzA0TldWbExUWmlPRFJpWVRJNVpUTTFZbHh0YzJk?=
 =?utf-8?B?elhHMXpaeTFtTVdNeE9HWmlOeTFqWmpBMUxURXhaV1V0WVdWak1pMWtORGd4?=
 =?utf-8?B?WkRjMU1EWmtaR1ZjWVcxbExYUmxjM1JjWmpGak1UaG1Zamd0WTJZd05TMHhN?=
 =?utf-8?B?V1ZsTFdGbFl6SXRaRFE0TVdRM05UQTJaR1JsWW05a2VTNTBlSFFpSUhONlBT?=
 =?utf-8?B?SXlNak00SWlCMFBTSXhNek0xTWpnd056QTVORFl5T1RNMk5qZ2lJR2c5SW1k?=
 =?utf-8?B?VmIyUTNMMmxVYTNaRGRURnVhVXBOVUc4eGFYUTRTMjg1V1QwaUlHbGtQU0lp?=
 =?utf-8?B?SUdKc1BTSXdJaUJpYnowaU1TSWdZMms5SW1OQlFVRkJSVkpJVlRGU1UxSlZS?=
 =?utf-8?B?azVEWjFWQlFVVnZRMEZCUTJ0Q01Ia3dSVzFRWVVGaGVraGFTRUpTVkdjMFVu?=
 =?utf-8?B?Sk5aR3RqUmtaUFJHaEZSRUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRklRVUZCUVVSaFFWRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGRlFVRlJRVUpCUVVGQlJVOXdiRTluUVVGQlFVRkJRVUZCUVVGQlFVRkJT?=
 =?utf-8?B?alJCUVVGQ2FFRkhVVUZoVVVKbVFVaE5RVnBSUW1wQlNGVkJZMmRDYkVGR09F?=
 =?utf-8?B?RmpRVUo1UVVjNFFXRm5RbXhCUjAxQlpFRkNla0ZHT0VGYVowSm9RVWQzUVdO?=
 =?utf-8?B?M1FteEJSamhCV21kQ2RrRklUVUZoVVVJd1FVZHJRV1JuUW14QlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVWQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlowRkJRVUZCUVc1blFVRkJSMFZCV2tGQ2NFRkdPRUZqZDBKc1FVZE5RV1JS?=
 =?utf-8?B?UW5sQlIxVkJXSGRDZDBGSVNVRmlkMEp4UVVkVlFWbDNRakJCU0UxQldIZENN?=
 =?utf-8?B?RUZIYTBGYVVVSjVRVVJGUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRlJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRMEZCUVVGQlFVTmxRVUZCUVZsUlFtdEJSMnRCV0hkQ2Vr?=
 =?utf-8?B?RkhWVUZaZDBJeFFVaEpRVnBSUW1aQlNFRkJZMmRDZGtGSGIwRmFVVUpxUVVo?=
 =?utf-8?B?UlFXTjNRbVpCU0ZGQllWRkNiRUZJU1VGTlowRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZDUVVGQlFVRkJRVUZCUVVsQlFVRkJRVUZCUFQwaUx6NDhMMjFs?=
 =?utf-8?Q?dGE+?=
x-dg-rorf: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY4PR03MB3399:EE_|PH8PR03MB7220:EE_
x-ms-office365-filtering-correlation-id: fdced199-6375-494d-f3e8-08dc3129d864
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 b562rY7n2ysbt3nbrlDOpURT3VhhLATf8p0m4AZrWfHcIMexUfGwqXrEzK2DqjKx30xmUSIrxgZDpChzxL1VX01OaOEaDXDJXxayhZjCy//BjJzYZnCLMpdR89xForRk+7aiyzi1xb33W396RNrE4Du09ESuUicIARo/zZ6qOAPDt/urW8j51NVIElgN7OObbs2N8v23hLbkDlVC0ZXC6Ml6rCCuCoHi1GfK9M4doX2NxFBck3b80cSmWRfLgS/pjLNUqWl7X2jeRfEoAkun/MT8iS2i4IKTdd2XD23mLoPoghhuVlXmvwCh++6e62wNlsdoOAO/KtQynfOlT49vDuZCjSl7atOqhEKDvLh+dRHZeO/RDCx0DnK2Ur5m1+LB8B2QMAsRL76BbpTMhZwD0wC9NBiaaZjXLDQHAeOpoO+XmNkZ2xYSPLG3bsd+ES4VQ/cycAZr7GO4mBEcHfP33T8adG7GAI0qrFeiPqeHQZQUybVUuednEUpMbLW9+kM+F40hYkY4ygfhjZvMkneUBCEnGiVWZmS1LZ8Q8Yow+LEopp91iPP9mWIvflK62XJgXrGZuiOAMnU2VwpRId0u1FPMggJt5EWcl26ykn3Cu7ztlVK+fHjsBwxbqYfKtnRq
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR03MB3399.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(396003)(136003)(346002)(376002)(230922051799003)(230273577357003)(64100799003)(186009)(451199024)(1800799012)(66946007)(76116006)(7416002)(5660300002)(2906002)(8936002)(52536014)(8676002)(64756008)(66446008)(66476007)(55016003)(66556008)(33656002)(86362001)(122000001)(921011)(38070700009)(38100700002)(66574015)(83380400001)(71200400001)(6506007)(7696005)(41300700001)(53546011)(26005)(478600001)(110136005)(316002)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?aUhVWHROanpFWmJic2x5bXN6a0tvMjdRWDBhRFdKenk2S2cxWVAxQlpzZkQw?=
 =?utf-8?B?TnhEUTlacG0wVDBCSDQvaFNMZ0hqRTROQnFnQXJidFExSHhldUNSNG1sMy8w?=
 =?utf-8?B?cnBBclVXMGhRa2NNUlpwaXREUW1rMU8xRzRpdXp3WHNqS3dXQW4wMi9wcnRS?=
 =?utf-8?B?SEw2d0NhdmdRSHluSGpVbjErcmdYMDFhVzdXQ2pVSWdXZEVST0ZMRWVDNjlD?=
 =?utf-8?B?Q3pjcmxBU1RVSGlFSFZqZjFOck5EZE5Xcmc1ODh3Tzh1NXVLZUlWVkdYRGdJ?=
 =?utf-8?B?d2FWR0NkcVlKcFVmU3FvZE92ZUFrNDl1YjE2OGtBTmNyUTR5STg2OXBuNHZD?=
 =?utf-8?B?b1lSWk84YktkeXYvWWF3elZJeSs5ZEg5bnY4NVRzMjBZcXdUNjdBUVB4M1Ry?=
 =?utf-8?B?Z2VlQk9FbGZSMFVCb0JaREFyNlpYT1lsZ2t1UTBMWFNkQ0VJRkNkNW9POVVM?=
 =?utf-8?B?MEJVbW5yVGtUbkdiY2h0U0VMWTBNK1c3Z28vSmVBTDFNUTM2NS9XSkEzOXNY?=
 =?utf-8?B?OEcwSExkZTJVODhieER6V3VhYm9PQVJneFZndStCTFlzQkVFeDErZzdTT0l4?=
 =?utf-8?B?cHZVUk5CUEFYT2JCVEd6YmcyYjVUVmhDTzBrTmpKNEQxVEYwWldWMmwxYXd3?=
 =?utf-8?B?ZU1vRmx1SFJ5TXJHVHB4U3ZMUUlkbGduemQ2Sk5XL2VDbENpY1o5VEdJUjFn?=
 =?utf-8?B?MHhQK3dCTnRqMk9BTXZ5MEFLN2RSVXBZZm1iRStQdmQ0L1M5Yk5kTWhiWVF4?=
 =?utf-8?B?SlNENnhEb2R4cDJmUnk0TXJOMWFWSWVnK1Z1ZlNueW5NRXd1VDZhMThRSVVP?=
 =?utf-8?B?NG55ajJIc3lFOCtCV2JpSGwzK0t4bURjbk9Mbkc3NnFkZE4wcDkzWmo4SmZ6?=
 =?utf-8?B?KzNVZEhRSERyWDByM0ptclVTRklpeG9JS1h4ekVTaFNidm1YWUJJOEpSSURG?=
 =?utf-8?B?WDh5ZkREdzUyb0xDSW9OYnE4RFErbXQyOHJkNVlNLy8xV2N2WHVzV25wTnhr?=
 =?utf-8?B?WmpRTmpjQ3RUeWdHQWhJYjduYzduYkY2T1NuSDBEcnBUUUYyTENmaHBONTBw?=
 =?utf-8?B?Wk02eTlRaWMxdnBDcjYzM0FhcHo0RWRNTHIrOXJFb2dkUElmMzFpTVQ3T3F3?=
 =?utf-8?B?dndCYk5HdytwcmFkSnFCY3Z5Mk9hMVZFNDhWUjhkSEgrK010QVMwMWJNcVZt?=
 =?utf-8?B?dkFmQ05kWlFCdTViSTE4RU9IektTSHVnNWtHYVdZaG4yelVpMGx5QVErcFJq?=
 =?utf-8?B?L2Y3cmJBNE04NGwrRGpEYXNhditodTJiRlROUlVNcWR3dXVJaDlmYVZodkxk?=
 =?utf-8?B?MU15Mi9MYnZYZDBSTVNGdERxKzBEdmlGcjZ1a1ZMRXc5ZUJwQ0tha2ljR083?=
 =?utf-8?B?SXVxd1ZuTTdqaE9EeFU1eXFmMFRRYUNjQnRScGh5Nit4UGJtQnZZWHRvTS9F?=
 =?utf-8?B?ZyszbFYwaSt3Yi9aL2laQWxzQVFJTlBJVytvdHUwQkpDWkQ5TzhVV2pVLzlz?=
 =?utf-8?B?SFE4cnlLOVBNK0ZHVnVDdE9iWEVpVUpuRGRiOFh3V2NDaVdDMG0zZ3o2ZEJM?=
 =?utf-8?B?cmpRUEVQZ1N6Y2hmVmxaVFF1eklvWGVhOVpBTWM1RlRqMGJEUDhoRzUydUty?=
 =?utf-8?B?V0QxbjEwbkt0RVZlMzVyTXBOeHVNKzNqZGRFQTB5cVl3eTlveDNTa21BR21O?=
 =?utf-8?B?dmg5UFpnM2NZSFlKMm1iT2FsSjZNR3l1TWMyN0x6VWdkZnFkUUlnZXRKak5x?=
 =?utf-8?B?UFh3K3RXRnM5VVE5dmtuZ3lndU02Nlp3NlBWQW53NGdJNnhvUkFLYW91bjRG?=
 =?utf-8?B?Yk03Ri81aUY2SWU2WEk1UG1aSFVTNldKbXNBZWdacUJNOVJ6eGNrK1IrNWdT?=
 =?utf-8?B?VEdaYUp2MUVhTmxZcC8zUnJ3d2k3QWlpYnhRM1ZPcnRRNFdBZHVzQk1BOWl1?=
 =?utf-8?B?RVVybE92b0ZDbXg4ZE82cFRNL2dvQW4xN1BVNWYxOE9USVNjaWQrS0hRcXZJ?=
 =?utf-8?B?Mi9mNWxPSGZTY0JLWDdGdzZwZitsV1FxdFlKNGd5Rlh1QjJRbG85eUNiNGVB?=
 =?utf-8?B?Z3VNdnhEeG9VZUE0OGRWTHlZNU91OWVxV3k4T1V4NDNaRW5HRWkybnh0VHBY?=
 =?utf-8?Q?m88GV9vxi1sx2ohyWuw3Nv/bP?=
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
X-MS-Exchange-CrossTenant-AuthSource: CY4PR03MB3399.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdced199-6375-494d-f3e8-08dc3129d864
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2024 09:04:57.3352
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dIqxGqvTJa6RR+1K7iLhagbl5hgtlguEKJN2gMreGyFg4itcXjyzQw3/Q9QgDCepZvQqWLR9/FSHlwSydvI236ZzAhnicOYXzXeUwoD5KRQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR03MB7220
X-Proofpoint-ORIG-GUID: eATaUA6ifYU0YBymG0YTMqwFiCHc6paL
X-Proofpoint-GUID: eATaUA6ifYU0YBymG0YTMqwFiCHc6paL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-19_06,2024-02-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 mlxlogscore=999 suspectscore=0 spamscore=0
 impostorscore=0 adultscore=0 mlxscore=0 priorityscore=1501 clxscore=1011
 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402190067

DQoNCi0tDQpBbnRvbml1IE1pY2zEg3XFnw0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQo+IEZyb206IENocmlzIFBhY2toYW0gPENocmlzLlBhY2toYW1AYWxsaWVkdGVsZXNpcy5jby5u
ej4NCj4gU2VudDogTW9uZGF5LCBGZWJydWFyeSAxOSwgMjAyNCA0OjUyIEFNDQo+IFRvOiBNaWNs
YXVzLCBBbnRvbml1IDxBbnRvbml1Lk1pY2xhdXNAYW5hbG9nLmNvbT47IEFsZXNzYW5kcm8gWnVt
bW8NCj4gPGEuenVtbW9AdG93ZXJ0ZWNoLml0PjsgQWxleGFuZHJlIEJlbGxvbmkNCj4gPGFsZXhh
bmRyZS5iZWxsb25pQGJvb3RsaW4uY29tPjsgUm9iIEhlcnJpbmcgPHJvYmgrZHRAa2VybmVsLm9y
Zz47DQo+IEtyenlzenRvZiBLb3psb3dza2kgPGtyenlzenRvZi5rb3psb3dza2krZHRAbGluYXJv
Lm9yZz47IENvbm9yIERvb2xleQ0KPiA8Y29ub3IrZHRAa2VybmVsLm9yZz47IEplYW4gRGVsdmFy
ZSA8amRlbHZhcmVAc3VzZS5jb20+OyBHdWVudGVyIFJvZWNrDQo+IDxsaW51eEByb2Vjay11cy5u
ZXQ+OyBsaW51eC1ydGNAdmdlci5rZXJuZWwub3JnOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9y
ZzsNCj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtaHdtb25Admdlci5rZXJu
ZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjkgMi8yXSBydGM6IG1heDMxMzM1OiBhZGQg
ZHJpdmVyIHN1cHBvcnQNCj4gDQo+IFtFeHRlcm5hbF0NCj4gDQo+IEhpIEFsbCwNCj4gDQo+IEkn
bSBsb29raW5nIGF0IGZvbGRpbmcgdGhpcyBpbnRvIHRoZSByZXN0IG9mIHRoZSBtYXgzMTN4eCBz
dXBwb3J0IChidXQNCj4gSSdsbCBzdGljayB3aXRoIHRoZSBtYXgzMTMzNSBuYW1lIHNpbmNlIHRo
YXQncyBsYW5kZWQpIGFuZCBJIG5vdGljZWQgYQ0KPiBwcm9ibGVtLg0KPiANCj4gT24gMjEvMTEv
MjMgMDE6MDAsIEFudG9uaXUgTWljbGF1cyB3cm90ZToNCj4gPiBSVEMgZHJpdmVyIGZvciBNQVgz
MTMzNSDCsTJwcG0gQXV0b21vdGl2ZSBSZWFsLVRpbWUgQ2xvY2sgd2l0aA0KPiA+IEludGVncmF0
ZWQgTUVNUyBSZXNvbmF0b3IuDQo+ID4NCj4gPiBSZXZpZXdlZC1ieTogR3VlbnRlciBSb2VjayA8
bGludXhAcm9lY2stdXMubmV0Pg0KPiA+IFNpZ25lZC1vZmYtYnk6IEFudG9uaXUgTWljbGF1cyA8
YW50b25pdS5taWNsYXVzQGFuYWxvZy5jb20+DQo+IDxzbmlwPg0KPiA+ICsNCj4gPiArc3RhdGlj
IGJvb2wgbWF4MzEzMzVfdm9sYXRpbGVfcmVnKHN0cnVjdCBkZXZpY2UgKmRldiwgdW5zaWduZWQg
aW50IHJlZykNCj4gPiArew0KPiA+ICsJLyogdGltZSBrZWVwaW5nIHJlZ2lzdGVycyAqLw0KPiA+
ICsJaWYgKHJlZyA+PSBNQVgzMTMzNV9TRUNPTkRTICYmDQo+ID4gKwkgICAgcmVnIDwgTUFYMzEz
MzVfU0VDT05EUyArIE1BWDMxMzM1X1RJTUVfU0laRSkNCj4gPiArCQlyZXR1cm4gdHJ1ZTsNCj4g
PiArDQo+ID4gKwkvKiBpbnRlcnJ1cHQgc3RhdHVzIHJlZ2lzdGVyICovDQo+ID4gKwlpZiAocmVn
ID09IE1BWDMxMzM1X0lOVF9FTjFfQTFJRSkNCj4gPiArCQlyZXR1cm4gdHJ1ZTsNCj4gUHJlc3Vt
YWJseSB0aGlzIHNob3VsZCBiZSBzb21ldGhpbmcgZWxzZSBhcyBNQVgzMTMzNV9JTlRfRU4xX0Ex
SUUgaXMgYQ0KPiBiaXRmaWVsZCBvZmZzZXQgbm90IGEgcmVnaXN0ZXIuwqAgQmFzZWQgb24gdGhl
IG90aGVyIGNoaXBzIEknbSBndWVzc2luZw0KPiB0aGlzIHNob3VsZCBiZSBgcmVnID09IE1BWDMx
MzM1X1NUQVRVUzFgLiBJJ2xsIHRyeSB0byBpbmNvcnBvcmF0ZSBhIGZpeA0KPiBpbnRvIG15IHVw
ZGF0ZSBidXQgc29tZW9uZSBtaWdodCB3YW50IHRvIGZpeCBpdCB1cCBmb3Igc3RhYmxlLg0KDQpJ
bmRlZWQsIE1BWDMxMzM1X1NUQVRVUzEgIHNob3VsZCBiZSB1c2VkIGhlcmUuIEkgcmUtY2hlY2tl
ZCB0aGUgbGF0ZXN0DQpkYXRhc2hlZXQgdGhhdCBJIGhhdmUuDQoNClRoYW5rcyBmb3IgcG9pbnRp
bmcgdGhhdCBvdXQuIA0KDQpJIHdpbGwgYWRkIGEgcGF0Y2ggc29vbi4NCg0KPiA+ICsNCj4gPiAr
CS8qIHRlbXBlcmF0dXJlIHJlZ2lzdGVycyAqLw0KPiA+ICsJaWYgKHJlZyA9PSBNQVgzMTMzNV9U
RU1QX0RBVEFfTVNCIHx8DQo+IE1BWDMxMzM1X1RFTVBfREFUQV9MU0IpDQo+ID4gKwkJcmV0dXJu
IHRydWU7DQo+ID4gKw0KPiA+ICsJcmV0dXJuIGZhbHNlOw0KPiA+ICt9DQo+ID4gKw0K

