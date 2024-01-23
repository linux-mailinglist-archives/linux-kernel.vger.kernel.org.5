Return-Path: <linux-kernel+bounces-35051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CBE5838B14
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 10:56:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1B971F2167E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 09:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F7675A78D;
	Tue, 23 Jan 2024 09:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="HXSrwoqw"
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974E95C8F6;
	Tue, 23 Jan 2024 09:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706003737; cv=fail; b=FWjX23KC+3bK7qUqYVBboXz4nl+TygB0BODFR/A549S1BZW8/p3YfgKMtaTapKzi0Vm6AXDI9/Q0X0i2yWIeMEU805z4M57MSdG3G8GdfYJjMO5Sw6xDMpfCH6+57mk5prJ6ebzTVy9fLCuLMUQfEDBU2Q5KD7ZGYZWQmzFAVLA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706003737; c=relaxed/simple;
	bh=N7XmCSVoxaUKIF2N01knJAqbpThaIpELsaj4YT0iOT4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=q9bbA/+xbdypcQov/GWuDZhXX3GIu/Qwo3XS34oXNhHHdAQrd64emdZJnNo4NF03s5gOJdlfwMy46Cmj7Nq7Ji4B6GRWR75bgP2h+N74b1RV5ezvMbnuqNx/moA9a7SSbcX7lZ2JPT7eE4dywh99xYatN0lvuY2SKzmZ55w2yoA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b=HXSrwoqw; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40N8EjAo006966;
	Tue, 23 Jan 2024 04:55:31 -0500
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3vrby73mam-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jan 2024 04:55:31 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EUCXqFFnsj4lmXAwyyYOKhNXgOl13NiujElRC7Y/ZwYpqE1tm7xHYEND3/NZQtD1xTvMkRdCwL14OjVbyGQF76pTBSySXnaufdw3lqYv6xjyT48Scr7lLq+2EtYSBSRN/06TWPOooDqVWT0lusi+NDHRvuj06w43vpbH+IyJFtjnDUBx0HX/ZEJeY1S6dSVXfhTwZ7betQk341picFbxVXpxCmBVfsC5AThdIulPb9PXl5Zkoo8ArdEf380NTKtOHUzPIhabPEjk1xeNmMVvEmKYBGNO++T5PhJSAYuPr6UrAPKDpUBSk3K9Aqf1XOPrlRuVVGIFYBZCzHOmDr0gEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N7XmCSVoxaUKIF2N01knJAqbpThaIpELsaj4YT0iOT4=;
 b=g61HbBypk0Z2FY1UTmmahukNBz9z6Zjk/VaV8DwYwffIYcB90Ns4hk7N/L7BpWH/SCQ4hX+gROy2VNTJHSjvXnbwfsp2OKj2JKljCK4fViLzgoWvh7884mbcaE8hqy21ggEZ/MljMAG1+vyqqQ0ZHSc2ofDrHIfHsMgp/phjorIuDg07/VFCV1AXPcxRCa8nnU29bp86HOPZj09WKPUTfqDk7A8Yh+tboZwYGXLynPyS8df+R+RYzq3QLIB3GH1n/uTfpV6Zav82x+G/bIpdGp8PBKFE/NnezE44RvXcAWhRy6/aKJGG4itpF2km0JPMwvVaGCIpD1tmmy0PE8rUhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N7XmCSVoxaUKIF2N01knJAqbpThaIpELsaj4YT0iOT4=;
 b=HXSrwoqwzDeAHykDv1zpiPRxKoarCtIn3CQsWo24yr2jOkN60tVwLx48z3kbpgR0+sBfExxxeLJS2MerbyT0FHm5dZ69PQ2wWBnln/q6jq8Xq+JO8x4l4cOPQMdM7cMJ/0PvFcOT5kQe1nr8XMCZwBzEFoN8sWBy36seUIYzbgQ=
Received: from PH0PR03MB7141.namprd03.prod.outlook.com (2603:10b6:510:296::20)
 by CO1PR03MB5923.namprd03.prod.outlook.com (2603:10b6:303:6e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.34; Tue, 23 Jan
 2024 09:55:29 +0000
Received: from PH0PR03MB7141.namprd03.prod.outlook.com
 ([fe80::ad49:e4d6:441b:28cb]) by PH0PR03MB7141.namprd03.prod.outlook.com
 ([fe80::ad49:e4d6:441b:28cb%5]) with mapi id 15.20.7202.035; Tue, 23 Jan 2024
 09:55:29 +0000
From: "Paller, Kim Seer" <KimSeer.Paller@analog.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC: Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski
	<brgl@bgdev.pl>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] dt-bindings: gpio: add adg1414
Thread-Topic: [PATCH 1/2] dt-bindings: gpio: add adg1414
Thread-Index: AQHaTFWOVZG53vNTpkO9fGt471FF9rDlx7AAgAFgC7A=
Date: Tue, 23 Jan 2024 09:55:29 +0000
Message-ID: 
 <PH0PR03MB7141D8CD02D93AB420FA535DF9742@PH0PR03MB7141.namprd03.prod.outlook.com>
References: <20240121103505.26475-1-kimseer.paller@analog.com>
 <20240121103505.26475-2-kimseer.paller@analog.com>
 <2e34faa9-a0ca-49f6-a268-1c01c31b041c@linaro.org>
In-Reply-To: <2e34faa9-a0ca-49f6-a268-1c01c31b041c@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: 
 =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jYTNCaGJHeGxjakpjWVhCd1pHRjBZVnh5YjJGdGFXNW5YREE1WkRnME9X?=
 =?utf-8?B?STJMVE15WkRNdE5HRTBNQzA0TldWbExUWmlPRFJpWVRJNVpUTTFZbHh0YzJk?=
 =?utf-8?B?elhHMXpaeTA0TjJZeU4yUTJNeTFpT1dRMUxURXhaV1V0WVdGalpTMHhORGMx?=
 =?utf-8?B?TldJek5XUmtZemhjWVcxbExYUmxjM1JjT0RkbU1qZGtOalV0WWpsa05TMHhN?=
 =?utf-8?B?V1ZsTFdGaFkyVXRNVFEzTlRWaU16VmtaR000WW05a2VTNTBlSFFpSUhONlBT?=
 =?utf-8?B?STBPVEU0SWlCMFBTSXhNek0xTURRM056TXlOalV5TkRjek1EZ2lJR2c5SWxj?=
 =?utf-8?B?d2RuSnFXV0ZZVEhSNGMzcEtjRE5CWldsb1lUSXdLM2swVVQwaUlHbGtQU0lp?=
 =?utf-8?B?SUdKc1BTSXdJaUJpYnowaU1TSWdZMms5SW1OQlFVRkJSVkpJVlRGU1UxSlZS?=
 =?utf-8?B?azVEWjFWQlFVVnZRMEZCUWsxVVJYUkxOR3N6WVVGUmJrRTJjVlpXVTBSa2Qw?=
 =?utf-8?B?TmpSSEZ3VmxaSlRqTkJSRUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRklRVUZCUVVSaFFWRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGRlFVRlJRVUpCUVVGQmJFZFVSMVpuUVVGQlFVRkJRVUZCUVVGQlFVRkJT?=
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
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR03MB7141:EE_|CO1PR03MB5923:EE_
x-ms-office365-filtering-correlation-id: 983a2325-ebfa-48db-2046-08dc1bf96e5a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 lj6WiRf3E/O0Sp7RDd+vE1d1J8ZUKhsNdpfowRphAmQ4952U/dYXxL57MrSbgMldSicY1Buh/NnRDz34N0WzgMtl+OUIKdHmKIbQwS+jlcSgvtsg6IZQT8gS82ohY9tDwsFdgR92YhgL29rUw5Fifv/LGYGGgJRI2zKhL6OdiJn++q2p2QJxSvTyTgxRJAWL1Dqvsj+1PvDJx9Y1vzHSTogjsm5a/QTwWUiTZSO6dG+LGbaT2v7iImhS5ZW+6OpmPa13TjHqvVg6d0w0R40VNfr/wBNw7POdX9Rp2dfUOwFnI9nLP0EdWeFa+ZsTglno0R4fowYyHz/R+GvjU91xZpJdqvIckFPhkPlGidNm1Zy6dHjH0lZNYXa3rPyMu76zXKxcfNmbDYi9ByrTiCy3+HmNkrGpFvV3mxU++vVMRZ9/y2P3GGUen9pZLAvbqdkWkjNHZqcoZ7JQDbZpitV+csUrl6vJbvgpqV97/Y5ke0IX+gzC+mIbbwkQ+egV6+1tBpEWIOW0te5iPbfBxOIYjz4cHku03D6K8OKdyGb4YYBTr09WX/29EhNHgRxxpif33zlpQjDjx5BH+COFgm+zR/Bbk9aPSO5f1pRKiAj+muBnIDcYH2sDJNdmKnYoDmy+LP67M9pSHfziHLR90tQp11XnR934z2g+yJ8zpbW5zFIaCtkB7DHAIre7Ke5pimZ2
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB7141.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(366004)(39860400002)(376002)(346002)(230273577357003)(230922051799003)(230173577357003)(64100799003)(186009)(451199024)(1800799012)(55016003)(6506007)(71200400001)(7696005)(26005)(9686003)(53546011)(122000001)(86362001)(38070700009)(38100700002)(33656002)(41300700001)(52536014)(19627235002)(83380400001)(8936002)(2906002)(478600001)(5660300002)(4326008)(54906003)(66446008)(8676002)(66556008)(66946007)(64756008)(316002)(66476007)(6916009)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?eGs1NVpOQXJ5TDUwUUZ6NGZGY2lwSHc2eUNNTXpnTEVqZHluQWxmV2lybDVi?=
 =?utf-8?B?UW9LM0pjSlZPcXVkNnkyWjZTc0ZhbTdjdlZZek9aOGl5VG51YWdiVXJrT0Ru?=
 =?utf-8?B?blNxL28ya0JIRFRTK09XUkg3MlVJL1hrVUVCUlo4dFRIZCtNM1JSR1VzbWt1?=
 =?utf-8?B?NHppeWZBNDhqRjRBY2N1akZ4YUdkWHdzRXg5M29LNTNMZGJOWlVGU0lPTnow?=
 =?utf-8?B?YkhkaENaYTJ2ZEswemNiam5aMVgwWm9ockhwSmtXQitFditTUFp0WmxQTElS?=
 =?utf-8?B?L21UTTRKQlpjNTJ5VmFFQUtYSFpMQjFDTWxBcng3QnA2T0FoTjh3WTFWVFNF?=
 =?utf-8?B?eXp5U0NkNThFOHEyRUZzdjgwTzdVazY1MndaV05vYXg4dmtCV2RZdmU5R0Jz?=
 =?utf-8?B?Zlg4SmtiTDV5RFl3cG5xdVlOMmEyaDVoQlNNbnR6WC9uQndiMVZabWVwQzdL?=
 =?utf-8?B?cEhRc3grbFN6eGthR1o5Zm41OGtSWDZQKzZjbklFTXBhbUM4T0ZlK2VVYnhM?=
 =?utf-8?B?SXlLMDR0WEpwKzlUemRjUzAvN0hhUUI4TWhUb1VsRjhoeW1oUWxHUG1PUTY5?=
 =?utf-8?B?azUxbVhTcVJuMzduckJzUkw0S2VGaWRYbkNBY2hDMzBwUWdlZTR0YUNEcjFI?=
 =?utf-8?B?V084SGN0K3FweVU2d3VGNUhUc1N6WUpiMVRGcU40TXRiNUNLa1B2UlU2elNh?=
 =?utf-8?B?UTVGdExVb2JvOXoyai9QZFcreXdtTVFnTDFaZDlYYzhqeXFRTmVvcFB4dEN2?=
 =?utf-8?B?SThhYnZQWVBTTExRVHVONFNnWG9KVlhjaHFQSmJrc3ZQcEVKWUk0YnlnTklG?=
 =?utf-8?B?NkFhMU5rdEduTE9Ka3FUM1VUNFdUanF2UUFRNVJvSXJscEVNTFkyelNPUWVl?=
 =?utf-8?B?R21zK3J1ZGdVU056ODZEaURTTXBFMVlrR2w5akppOWY3SzhzNnlXMFBzVTcw?=
 =?utf-8?B?RGpVZXFHbkgwVTVvbkVueDNpZVkyMjVwR1lFSnM2bmY0YWdpQUZrZXJzNEE5?=
 =?utf-8?B?dStybWNHR3hnWkNIYTFtblFBa3gvTEY2SWlQRldjdjFuSWNaNTJENHdnOWtH?=
 =?utf-8?B?K2ZjOTFheS83bHZHMEhhbkhlSk43OHk4ZEdmWGNsdHpoVXRvbUxrVmowaUJ4?=
 =?utf-8?B?ODl5MERwSS9rZG9OUXU4QkdwMHNvMGtqVmlBdWc5ZTVyczlnTWV5Z0h0UFdT?=
 =?utf-8?B?UzQ2WkdyQ3M5OG94ODFKdFpkYWhFZXlMWjdOMm55eUVNN3JQc2hyK3U4MjZV?=
 =?utf-8?B?Qk1jRmJ4ZXlEVlM2Y3oyWWdhRjNxYkhFWmcvRFdzcmtDUllFZkZleXQvazYx?=
 =?utf-8?B?dFQ5aW4zY1kyU0JmaDdka3NYL3I4VFNBdkprN3Z0UXNzMUtIRHVuUy9tbE01?=
 =?utf-8?B?ZmtITkxJMnk4aDlpajlDRUtFNzdSeUk5UTVvcGRCNXgzN2dvc1FJUjlTNU9x?=
 =?utf-8?B?bW5wNHNmdXNZaEhiaExpTmlQbEY2SGZTcGxZVUJQRUtBbzNRaHZnMW1OVVh1?=
 =?utf-8?B?amxHODV2Q0tmTDhmZkt6eVBZYzczYnZmRkRzczBMd1FLRkc1V0dCQXdtbkw2?=
 =?utf-8?B?VEdINXpHYkpTM3hIWTFoT1AzcXJUYlhvQ2ppaDFoODdHa3p4OXhNNjVaNGk5?=
 =?utf-8?B?YXMrbElVSjBJbS9mQlVDMTlUaC94VXRMa1lQcU1mL0hmb0Rja2pyeEF6S1JD?=
 =?utf-8?B?b3hiTFhNcEIraXVjT0EwQ1BEU09XODZqMVNOWmtLUU9jTFBDcHBHOG9ZTS9L?=
 =?utf-8?B?L3Rudys1S2lQRGZ1a2FjS2h2MExwQ1JSSHRXUlhKMnJMMG5aYlV2L0VaS09Z?=
 =?utf-8?B?Qlpqa0NhbzdVQ2tOeFl5SGxrdXc1M2RDaXh5VVN2UWFWdGNsL0NzVXBmZkVF?=
 =?utf-8?B?aGdYRHM3ZzE3amp0QVZhZXFWcDZ2eC9tNEc3eDlJR3J0akVDZ3RNNjZsWFRp?=
 =?utf-8?B?NnlhTzJ4R2FlVnpZZWxwbjQyMXhtUXNINzJUY1Z4dE83azB3eHpQSVQwMTk0?=
 =?utf-8?B?WXhlMEZOcUhjTzR2NDFiY2VQWUdsdlBQQ3JHMFJ2bFU4U3VSdTlFQTVJSmNl?=
 =?utf-8?B?ZjJZbWNKeEI3aW8ybzN2ZDRFc1c4RWxhYzdqaXp1ZHhsYnBLK1BZZXNldllX?=
 =?utf-8?Q?jI7GyU+FYzuH6d35E8mkwWHWY?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 983a2325-ebfa-48db-2046-08dc1bf96e5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2024 09:55:29.1450
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M7fLl/wIs3UzT5NU9fuIFnMvo6h5+RUwunjvm8uGDGD1g1kb53dsDe/5b/KTYPdR9oaaoAwIwDShSOQpXQRFe/F2vIK7Z+G0n6mi5Y6wI7E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR03MB5923
X-Proofpoint-GUID: O09_PlMpUTo0l2RpUoohQXVQiQNcFyhA
X-Proofpoint-ORIG-GUID: O09_PlMpUTo0l2RpUoohQXVQiQNcFyhA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-23_04,2024-01-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 spamscore=0 adultscore=0 mlxscore=0 suspectscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2311290000 definitions=main-2401230071

SGkgS3J6eXN6dG9mLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEty
enlzenRvZiBLb3psb3dza2kgPGtyenlzenRvZi5rb3psb3dza2lAbGluYXJvLm9yZz4NCj4gU2Vu
dDogTW9uZGF5LCBKYW51YXJ5IDIyLCAyMDI0IDg6NDAgUE0NCj4gVG86IFBhbGxlciwgS2ltIFNl
ZXIgPEtpbVNlZXIuUGFsbGVyQGFuYWxvZy5jb20+OyBsaW51eC1ncGlvQHZnZXIua2VybmVsLm9y
ZzsNCj4gZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5l
bC5vcmcNCj4gQ2M6IExpbnVzIFdhbGxlaWogPGxpbnVzLndhbGxlaWpAbGluYXJvLm9yZz47IEJh
cnRvc3ogR29sYXN6ZXdza2kNCj4gPGJyZ2xAYmdkZXYucGw+OyBSb2IgSGVycmluZyA8cm9iaCtk
dEBrZXJuZWwub3JnPjsgS3J6eXN6dG9mIEtvemxvd3NraQ0KPiA8a3J6eXN6dG9mLmtvemxvd3Nr
aStkdEBsaW5hcm8ub3JnPjsgQ29ub3IgRG9vbGV5IDxjb25vcitkdEBrZXJuZWwub3JnPg0KPiBT
dWJqZWN0OiBSZTogW1BBVENIIDEvMl0gZHQtYmluZGluZ3M6IGdwaW86IGFkZCBhZGcxNDE0DQo+
IA0KPiBbRXh0ZXJuYWxdDQo+IA0KPiBPbiAyMS8wMS8yMDI0IDExOjM1LCBLaW0gU2VlciBQYWxs
ZXIgd3JvdGU6DQo+ID4gVGhlIEFERzE0MTQgaXMgYSA5LjUgzqkgUk9OIMKxMTUgVi8rMTIgVi/C
sTUgViBpQ01PUyBTZXJpYWxseS1Db250cm9sbGVkDQo+ID4gT2N0YWwgU1BTVCBTd2l0Y2hlcw0K
PiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogS2ltIFNlZXIgUGFsbGVyIDxraW1zZWVyLnBhbGxlckBh
bmFsb2cuY29tPg0KPiA+IC0tLQ0KPiA+ICAuLi4vYmluZGluZ3MvZ3Bpby9ncGlvLWFkZzE0MTQu
eWFtbCAgICAgICAgICAgfCA2NiArKysrKysrKysrKysrKysrKysrDQo+ID4gIE1BSU5UQUlORVJT
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICA2ICsrDQo+ID4gIDIgZmlsZXMg
Y2hhbmdlZCwgNzIgaW5zZXJ0aW9ucygrKQ0KPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQNCj4gPiBE
b2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZ3Bpby9ncGlvLWFkZzE0MTQueWFtbA0K
PiA+DQo+ID4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9n
cGlvL2dwaW8tYWRnMTQxNC55YW1sDQo+ID4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3MvZ3Bpby9ncGlvLWFkZzE0MTQueWFtbA0KPiA+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+
ID4gaW5kZXggMDAwMDAwMDAwLi4yNGE1MWU3OWYNCj4gPiAtLS0gL2Rldi9udWxsDQo+ID4gKysr
IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2dwaW8vZ3Bpby1hZGcxNDE0Lnlh
bWwNCj4gDQo+IEZpbGVuYW1lIGxpa2UgY29tcGF0aWJsZS4NCg0KSSB3b3VsZCBsaWtlIHRvIGNs
YXJpZnksIGlzIGl0IGNoYW5naW5nIHRoZSBmaWxlbmFtZSBmcm9tIGdwaW8tYWRnMTQxNC55YW1s
DQp0byBhZGcxNDE0LnlhbWw/IA0KDQo+ID4gQEAgLTAsMCArMSw2NiBAQA0KPiA+ICsjIFNQRFgt
TGljZW5zZS1JZGVudGlmaWVyOiAoR1BMLTIuMC1vbmx5IE9SIEJTRC0yLUNsYXVzZSkgJVlBTUwg
MS4yDQo+ID4gKy0tLQ0KPiA+ICskaWQ6DQo+ID4gK2h0dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMv
X19odHRwOi8vZGV2aWNldHJlZS5vcmcvc2NoZW1hcy9ncGlvL2dwaW8tYQ0KPiA+ICtkZzE0MTQu
eWFtbCpfXztJdyEhQTNOaThDUzB5MlkhX1EwelJCOEotDQo+IGluV0lJeWJnT2p0VGhVMHRvSmVV
enFhVDlUdmVnDQo+ID4gK1hUanZQV2lDVGg0SUFKNURrTmVwRmRmaFhYZnhYTG5CMndTUjlfTGdQ
bnZWbkZxdzJiRHV2Qkk4ZyQNCj4gPiArJHNjaGVtYToNCj4gPiAraHR0cHM6Ly91cmxkZWZlbnNl
LmNvbS92My9fX2h0dHA6Ly9kZXZpY2V0cmVlLm9yZy9tZXRhLXNjaGVtYXMvY29yZS55DQo+ID4g
K2FtbCpfXztJdyEhQTNOaThDUzB5MlkhX1EwelJCOEotDQo+IGluV0lJeWJnT2p0VGhVMHRvSmVV
enFhVDlUdmVnWFRqdlBXaUMNCj4gPiArVGg0SUFKNURrTmVwRmRmaFhYZnhYTG5CMndTUjlfTGdQ
bnZWbkZxdzJiRUlaMVBHNCQNCj4gPiArDQo+ID4gK3RpdGxlOiBBREcxNDE0IFNQU1QgU3dpdGNo
IERyaXZlcg0KPiANCj4gIkRyaXZlciIgYXMgTGludXggZHJpdmVyIG9yIHNvbWUgaGFyZHdhcmUg
ZHJpdmVyPw0KDQpMaW51eCBkZXZpY2UgZHJpdmVyLiBJdCBzZWVtcyBJIG92ZXJsb29rZWQgdGhp
cyBvbmUsIGl0IHNob3VsZCBiZSBBREcxNDE0IE9jdGFsIFNQU1QgU3dpdGNoZXMNCg0KPiA+ICsN
Cj4gPiArbWFpbnRhaW5lcnM6DQo+ID4gKyAgLSBLaW0gU2VlciBQYWxsZXIgPGtpbXNlZXIucGFs
bGVyQGFuYWxvZy5jb20+DQo+ID4gKw0KDQpCZXN0IHJlZ2FyZHMsDQpLaW0NCg==

