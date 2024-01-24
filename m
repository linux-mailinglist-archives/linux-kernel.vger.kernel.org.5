Return-Path: <linux-kernel+bounces-36409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD65883A03E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 04:45:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEC471C25A0F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 03:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D86EE8C1C;
	Wed, 24 Jan 2024 03:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="95jbTkPm"
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1151933E1;
	Wed, 24 Jan 2024 03:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706067907; cv=fail; b=UYQrYnmYbk+ZV7Vry6Fjd6uYi2tiz+H/kDQK11V107G9HRd8knXbILAg8Ph4iCNkex10Cf5huorNoXKvLWL2bqcv2DHvTwte7PBkuZKJkUsTYAT9Y0Qak9XpB2YtZ6Wrst4R8rpHWhBPR9+H+pHnoC13ySRx8ux+pM9ZqILThPw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706067907; c=relaxed/simple;
	bh=KCpZ9I0o+3sXQpTca+KOZTR9N8cwsSTaLF0/3FJwx3k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Zf7pScZxcrvKkHIpUk2lFZsTPkyDsig+3gGhEQTKh1vVZpka72kgDKqpn6jaa1iYg3iDi9jHRXqTNFrAdST+zLCjGVluzCzjQoNDI+OpEFCa61zKVph2qJPVBqrSDgvpjeTleMGawhnw/zy+yNAdIBFwaL4Fi9Hu7ucEjzljIgQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b=95jbTkPm; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40O2pXhb019282;
	Tue, 23 Jan 2024 22:45:01 -0500
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3vtmgq99we-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jan 2024 22:45:01 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PDFO6evvUNYOwc5z61tCbxnP7uHet27Kr/u77yJO1n24+93MUH4rK+7e0OGhshQhE0YHiBVwOaOodCuf1UXFSsPkTnOyiwiUhDfUHD1rnVGA3AfO5P84y5PltuSTvhl/sNZBzdiPltdhtgM/Sn8RQAIO3Cv7k+MF6ZUBwK0cKn7rdmbiXMZprirv2RqfqYa0f6KAuMBc6Pxb3nd167E+XstV0PWRFG13k4v1mYc6aXRYDw0U/l6WOI8kkkjQkpuawedwzi/nDHkQNZ+qV9A1EkgPvBdG2BHTllbY5CmBxpgQDWiU40Vyorx6/lUKAAKeY3jJugCVSV/4N86uEyC5Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KCpZ9I0o+3sXQpTca+KOZTR9N8cwsSTaLF0/3FJwx3k=;
 b=fHFLdofNYvBpCDEihhDSgaxfpLKJklPu2ZTyHg23Jv9k0wVoTO4CmABtxhe1DWFyC83fUW0FjzEuaszXWUtJQG0Prnz5RxFpVyMjdN7NkPZhpo+q2lSqlt4WFdUSXBduNmCpPx/CNN5xIJlpoVj4OrmcLbyXrs8exfVqm453aNxVOqnsUJksQ9PZ4pw0g/Bh8bW203PzAvY35RYcKYpbcPXWx3HBC8WLvx09ACC6h35ev4CNmgJdYezRRCd1q5W/6XPAcshlXgYL+ms85GVgQ1qqzMnXrzaZ01lDu/SNzx5go59CSm5qepqAKlTMc1XdaybzOsFXaBWzYCKiXRm6+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KCpZ9I0o+3sXQpTca+KOZTR9N8cwsSTaLF0/3FJwx3k=;
 b=95jbTkPmjzVtrau0Z6+PTx2v8UC3FE13Gx8gSvuFYslByemjKCX0b20P9Z5u09KovDTfGBLmGyxrmM/oOjjxHdAlSDBNh5DwoACt8MVdDI+g2wmS4yRadhzGjG4618IPzdhm4IVpFVKbl7yHxNoRB53ybOlVORsevYGsoZY6nHU=
Received: from PH0PR03MB7141.namprd03.prod.outlook.com (2603:10b6:510:296::20)
 by MW4PR03MB6617.namprd03.prod.outlook.com (2603:10b6:303:128::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.36; Wed, 24 Jan
 2024 03:44:58 +0000
Received: from PH0PR03MB7141.namprd03.prod.outlook.com
 ([fe80::ad49:e4d6:441b:28cb]) by PH0PR03MB7141.namprd03.prod.outlook.com
 ([fe80::ad49:e4d6:441b:28cb%5]) with mapi id 15.20.7202.035; Wed, 24 Jan 2024
 03:44:58 +0000
From: "Paller, Kim Seer" <KimSeer.Paller@analog.com>
To: Linus Walleij <linus.walleij@linaro.org>
CC: Bartosz Golaszewski <brgl@bgdev.pl>,
        "linux-gpio@vger.kernel.org"
	<linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>
Subject: RE: [PATCH 2/2] gpio: gpio-adg1414: New driver
Thread-Topic: [PATCH 2/2] gpio: gpio-adg1414: New driver
Thread-Index: AQHaTFWO6BctQx5jpU+9EjWi7po2DrDlzS2AgAFfGbCAAMeGAIAAYQXg
Date: Wed, 24 Jan 2024 03:44:58 +0000
Message-ID: 
 <PH0PR03MB7141270792673459B8831BE8F97B2@PH0PR03MB7141.namprd03.prod.outlook.com>
References: <20240121103505.26475-1-kimseer.paller@analog.com>
 <20240121103505.26475-3-kimseer.paller@analog.com>
 <CAMRc=MeGVAO8Fr4U5ai-OgEmX5gXeddLDKyRC+FQia1TH64m+Q@mail.gmail.com>
 <PH0PR03MB7141E0C8822D4887E04A3F06F9742@PH0PR03MB7141.namprd03.prod.outlook.com>
 <CACRpkdYePmAmrZN=GS58muzhxPUPKkenbgPQZmcct-0G5Ohc_g@mail.gmail.com>
In-Reply-To: 
 <CACRpkdYePmAmrZN=GS58muzhxPUPKkenbgPQZmcct-0G5Ohc_g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: 
 =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jYTNCaGJHeGxjakpjWVhCd1pHRjBZVnh5YjJGdGFXNW5YREE1WkRnME9X?=
 =?utf-8?B?STJMVE15WkRNdE5HRTBNQzA0TldWbExUWmlPRFJpWVRJNVpUTTFZbHh0YzJk?=
 =?utf-8?B?elhHMXpaeTFsWm1VMU1XSmlaUzFpWVRaaExURXhaV1V0WVdGalpTMHhORGMx?=
 =?utf-8?B?TldJek5XUmtZemhjWVcxbExYUmxjM1JjWldabE5URmlZekF0WW1FMllTMHhN?=
 =?utf-8?B?V1ZsTFdGaFkyVXRNVFEzTlRWaU16VmtaR000WW05a2VTNTBlSFFpSUhONlBT?=
 =?utf-8?B?SXpOalEwSWlCMFBTSXhNek0xTURVME1UUTVOVGt6TURrNU1qa2lJR2c5SWtO?=
 =?utf-8?B?MlJtUktXbWN2Y2pKa1F5dDBWWGhpYXpFd2FtWnZWREJ0UlQwaUlHbGtQU0lp?=
 =?utf-8?B?SUdKc1BTSXdJaUJpYnowaU1TSWdZMms5SW1OQlFVRkJSVkpJVlRGU1UxSlZS?=
 =?utf-8?B?azVEWjFWQlFVVnZRMEZCUW5Cd1JESjVaREEzWVVGU1YxbFJTRWN3VG1oRlow?=
 =?utf-8?B?WmFhRUZqWWxFeVJWTkJSRUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
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
x-ms-traffictypediagnostic: PH0PR03MB7141:EE_|MW4PR03MB6617:EE_
x-ms-office365-filtering-correlation-id: 2c2c2f05-7798-40db-902d-08dc1c8ed663
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 p+m6FLS4G13omZkUl8Wicn0CmYUxGUjIaSyl1bYDesXmxkIBvathuB1nWrRWpcsdUC5ln753TpjsAl/3DnSTJQMzMMLQDPFSyp5j46wyIxv3KMUqRdroVvSpIWIQCI0pouxWfKsXAD15wnch+66j9OBZufKEX/LinpFMfPPPE+Jesdd5+AUbqR07cGuWlQnBvUhto6/KXC/ACChjLdt/M+oG1ozofE/jDJoIRK8GF8TdQBOSacyY/rTnMBTyKLCtJzBuCZqD3BCnH0WfP0u7E84srhpazf+Re4HeOIgb44md4c645FZ4/c5iudWyYfyStpmOhacAXKSdMOiClENn/icNLjxa3JFAk6ZatWVfa8SH7cpGkUmJUb7isFoTgiPnA0pPxzpil3oIGnwuDJWaIZMpOwSOFCnP3D/sIYU+LpQtcHntOrfbY1dVfZyXHElifkucu36dFsmKrF1+Bss43BVv5lVdTIeP1HLShW8VhHUV5s0Itl0dWDTJMg9Yofzf/OpiTkkKetbhre8Dftk49I1PLDjm/njhhvXT3J+XLb2tpwHz6oF+TLpxmkELa7wNcLv3elYwLgwoncwQ89nyQiivQ1DDohIyvs0JNOYfjHMGpYVE1+9kGZ/2jxZ2ROLP2nPGg4jS3YIzO6VD5RfJryxtL4VQS/1uaJZA5+58c6M=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB7141.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(39860400002)(366004)(396003)(346002)(230273577357003)(230922051799003)(230173577357003)(1800799012)(64100799003)(451199024)(186009)(55016003)(41300700001)(8936002)(2906002)(8676002)(5660300002)(66446008)(54906003)(316002)(6916009)(64756008)(66946007)(66476007)(66556008)(76116006)(478600001)(9686003)(53546011)(26005)(6506007)(7696005)(71200400001)(52536014)(4326008)(38100700002)(83380400001)(33656002)(86362001)(38070700009)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?T1R5djZtbUVRN3Bad3pKUmp4a1JhNFpJMVRpM0hNMVdpZ2xEOWVnNysvclpH?=
 =?utf-8?B?TDlYaldlMklHQVpBcFBlWXVCTmVTOEJwMnNuU0NJMDNDZHZxVFFMM01uZWpw?=
 =?utf-8?B?U3BTVkNuUTJWZFVZTE5TZWZkVCs5eS9lUTdxNUdXY29aY1lYL1hkQWNueGRk?=
 =?utf-8?B?S0Q3N2QwM1JvZjllU3pUUHVIbWd0VVV1OWRLZmJSbllnejhaMGF0M01xN0pR?=
 =?utf-8?B?c2J3MU1ESGllNFNFay8rTkFsMERnSXMxaFJ3SC9OMkwrN0NLVkNKSU1LdEN0?=
 =?utf-8?B?MkkvK2w1QmdSOGY4MVIzUTJPaTRpMDMrNHpHeVorc0UzclZUK2g5V3JpTWtj?=
 =?utf-8?B?c0lnUHhRTk9ZVHhYdDZrZWo4Sm5MNEFWUHdnMlZ1cjhHWDhnQjB2V2x4alpC?=
 =?utf-8?B?dWlXNGNSN0krUTUxcjZHaW13U3VYeFhsT3ljMkhhMFQxVE53ZDBMYVZKeHF2?=
 =?utf-8?B?dER6YzdtWW9la3p6RUtGMSs5YTV6cExRTWJSbFNINGQ5cmFKU2J4WFQ4cDht?=
 =?utf-8?B?T1ZOSytkVHFTL25yNEJ2cUFtRXpCQnltVHJNK3lzVDBzYTZpMVF0YmNXSTE0?=
 =?utf-8?B?SmRFaWZ3VFZlRmorL3FJZDYxYmR2UFNlWHdVYkdTbUF3dmFVSXRtcHRBMUM2?=
 =?utf-8?B?anVGd2Nudm5ITWF5TXNMdVlDU0dFWjhQbndPblVLd1RKQ000SkZ2YkNyZEUr?=
 =?utf-8?B?WWZWbWUyNkcydy95YzJIRFpLNWUvMW9Eb0dWR3k3VFhnUy9rS3hoRUtzMlk5?=
 =?utf-8?B?NWFSd0VYN2pRSkxuRzZ1YUJqdEc2WUdMTWxIZjgvcFFoM1NtUUhIM3UyQ0wz?=
 =?utf-8?B?RG9XdlUwd2ZSdGYrSnRXdFcvYVNLT1IyV2o0YjBFM3ZyaTY1SC9hRXBxak1t?=
 =?utf-8?B?MEp6NXY0K2RzYjIzOTN4RkJIV0tHM1YwTGxOb1lOZDdCWElHcXBqTmZtNzRP?=
 =?utf-8?B?TkY0Q3Fycko5MjRpUU52SWZmTWZYcXpsRGY4UDV5UjVMSFh3bzQvOVlHWGpk?=
 =?utf-8?B?bjRyZjRTVzNBUnUxOHVNNlFmRXZLYjJLRE5sM0VTUEprY1dENjdWRjNZN2Fw?=
 =?utf-8?B?YXBGNmtSTGtjUGNpTmNNaG14Z243bVA4NFk0MGxHOUhNYkQ2OXZ2VHpoUUtM?=
 =?utf-8?B?OTgxSE55dy9XNURpL0oxZDRlT3FrSVdieHB4eWNVb2NTWDY5c2FBMklyT0M5?=
 =?utf-8?B?eTJDR2V4UnNaay95WGZWaDFoSjUrMVJmbnBGZzRpTi81NTlEM2ZFdmxraWdP?=
 =?utf-8?B?TTN4UWZwT1JYV1ByVVVhQzNGcysvUWVLTEQ5cUlnaDlmcVlEM09LQU5lc0dl?=
 =?utf-8?B?UGxmOE9yQ2xDWnNTc0diQzdReHc0by94VUxXOVJzMCtYNFZkTlNHTVNvbUVT?=
 =?utf-8?B?OWdjT1h1M1RrenVWMG4vd1pnZWlyRk5raUVFZnlaRUNHQmNpNVQ5bHU3RGgz?=
 =?utf-8?B?S2ZBaU9ZaDI2bDVjN0h5a1ZvQUVyZGR1TW1SYitzUWZqZ1Rwb2RIQkdRd1Ni?=
 =?utf-8?B?MThhRTMxT21hTStQcXVuaXdWS280N3BnaEt6VlgwMkRoRGF3VU1NQkQzejVv?=
 =?utf-8?B?aWVrQkFrdnYrZ1g3L1FMRjBLSTJ6NDJGamIwRFdidy9vZTRlL1hZOXBTT25a?=
 =?utf-8?B?QXpLck5XS2I0MktXTkd0U0o1RW9lWUVrc2NpU0EzMlNNOTF1TEc4SmpJMGRi?=
 =?utf-8?B?THQwRzhibElMYTM1ZHMvdlJ4bS9ab1I4UGVkS0oyOTU5N1ovcVRoK2hTSE9k?=
 =?utf-8?B?bmRrUTlyb2tzV3pBMGJqQjFGS3ZuM2RCQlNOY0VqMTFjWnY4WERYRXNqWGtP?=
 =?utf-8?B?OWRCOVRicXFGRjl4YlpyZldPdDVCNy9jMTJmWXpCWlpoNFhveUw4NVo4RHFC?=
 =?utf-8?B?QXZEVDEyanNFbXl2OUFxOGtEaHF3MEcyWVdWb0RCRGZsVzZkZml2Wk40OGQ1?=
 =?utf-8?B?MWhDcS9jQlBiNGpDNm55VVBtVVg3RDFRM0EvdlpMUHpETndOUlRrRjJJaVQ0?=
 =?utf-8?B?QlBNaENHck83ZGZHRllBaFlSWENJN1RyWXl1bUppa1UzYm10Wkl5a1phU21X?=
 =?utf-8?B?d21ZdlZhMy8wS24zdzhSNnVXeVdPUm5mcTVZaC9GUkpNeVh4NUhWcHVuZERQ?=
 =?utf-8?Q?yQZPrsws2HVcNksAHRN84PfDS?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c2c2f05-7798-40db-902d-08dc1c8ed663
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2024 03:44:58.7371
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cBMp4/JQGy4d/dT45KOlZnCtsb1JL8vHn2l7/0V/AAUe5aPJjUwXzAojPc/iyTu7jD73kDGTmNL6AZruGxnB5wI+GUajLb3bEbuy6nnVbOU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR03MB6617
X-Proofpoint-ORIG-GUID: jN-5aPsjZmsTdWqe6nvb3iqSbAcdEP9o
X-Proofpoint-GUID: jN-5aPsjZmsTdWqe6nvb3iqSbAcdEP9o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-23_15,2024-01-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 priorityscore=1501 phishscore=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 mlxlogscore=984 malwarescore=0 adultscore=0
 clxscore=1015 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2401190000 definitions=main-2401240025

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMaW51cyBXYWxsZWlqIDxsaW51
cy53YWxsZWlqQGxpbmFyby5vcmc+DQo+IFNlbnQ6IFdlZG5lc2RheSwgSmFudWFyeSAyNCwgMjAy
NCA1OjUxIEFNDQo+IFRvOiBQYWxsZXIsIEtpbSBTZWVyIDxLaW1TZWVyLlBhbGxlckBhbmFsb2cu
Y29tPg0KPiBDYzogQmFydG9zeiBHb2xhc3pld3NraSA8YnJnbEBiZ2Rldi5wbD47IGxpbnV4LWdw
aW9Admdlci5rZXJuZWwub3JnOw0KPiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgt
a2VybmVsQHZnZXIua2VybmVsLm9yZzsgUm9iIEhlcnJpbmcNCj4gPHJvYmgrZHRAa2VybmVsLm9y
Zz47IEtyenlzenRvZiBLb3psb3dza2kNCj4gPGtyenlzenRvZi5rb3psb3dza2krZHRAbGluYXJv
Lm9yZz47IENvbm9yIERvb2xleSA8Y29ub3IrZHRAa2VybmVsLm9yZz4NCj4gU3ViamVjdDogUmU6
IFtQQVRDSCAyLzJdIGdwaW86IGdwaW8tYWRnMTQxNDogTmV3IGRyaXZlcg0KPiANCj4gW0V4dGVy
bmFsXQ0KPiANCj4gSGkgS2ltLA0KPiANCj4gT24gVHVlLCBKYW4gMjMsIDIwMjQgYXQgMTE6MzHi
gK9BTSBQYWxsZXIsIEtpbSBTZWVyDQo+IDxLaW1TZWVyLlBhbGxlckBhbmFsb2cuY29tPiB3cm90
ZToNCj4gDQo+ID4gPiBMb2NraW5nIGhlcmUgaXMgc2ltcGxlIGVub3VnaCB0aGF0IHlvdSBjb3Vs
ZCB1c2UgdGhlIFNQSSByZWdtYXAgYW5kDQo+ID4gPiBnZXQgaXQgdG8gZG8gdGhlIHNlcmlhbGl6
YXRpb24gZm9yIHlvdS4gQW5kIHRoZW4geW91IGNvdWxkIHBvc3NpYmx5DQo+ID4gPiByZXVzZSB0
aGUgZ3Bpby1yZWdtYXAgYWJzdHJhY3Rpb24gYW5kIGdldCBhbiBldmVuIHNtYWxsZXIgZm9vdHBy
aW50Lg0KPiA+DQo+ID4gSSBjb3VsZCBub3Qgc2VlbSB0byBmaWd1cmUgb3V0IGhvdyB0byB1c2Ug
dGhlIFNQSSByZWdtYXAgaW4gdGhpcyBjYXNlLg0KPiA+IFNpbmNlIHRoZSBudW1iZXIgb2YgZGFp
c3ktY2hhaW5lZCBkZXZpY2VzIGRlcGVuZHMgb24gdGhlIGxlbmd0aCBvZg0KPiA+IGRhdGEgdHJh
bnNmZXJyZWQgd2l0aCBjb250aW51b3VzIHRyYW5zYWN0aW9uLCBJIGNvdWxkIG5vdCBkZXRlcm1p
bmUNCj4gPiBob3cgdG8gaW1wbGVtZW50IHRoYXQgdXNpbmcgdGhlIFNQSSByZWdtYXAuIE9yIG1h
eWJlIEkgbWlzdW5kZXJzdG9vZA0KPiA+IHRoZSBzdGF0ZW1lbnQuIEhvd2V2ZXIsIGlzIGl0IHN0
aWxsIGFjY2VwdGFibGUgdG8gdXNlIHRoZSBjdXJyZW50IGFwcHJvYWNoPw0KPiANCj4gWW91IGp1
c3Qgb3ZlcnJpZGUgb3Igd3JhcCB3aXRoIHlvdXIgb3duIHJlYWQvd3JpdGUgY2FsbGJhY2tzIGlm
IG5lY2Vzc2FyeQ0KPiBieSBkZWZpbmluZyBhIGN1c3RvbSBzdGF0aWMgc3RydWN0IHJlZ21hcF9i
dXMuDQo+IA0KPiBGb3IgZXhhbXBsZSBpbiBkcml2ZXJzL2dwdS9kcm0vcGFuZWwvcGFuZWwtaWxp
dGVrLWlsaTkzMjIuYw0KPiBJIGRvIHRoaXMuDQo+IA0KPiBJdCBtYXkgbm90IHNhdmUgYSBsb3Qg
b2YgY29kZSBpbiB0aGlzIGNhc2UgYnV0IGl0J3Mgc3RpbGwgd29ydGggaXQgYmVjYXVzZQ0KPiB3
ZSB1bmRlcnN0YW5kIHdoYXQgcmVnbWFwX3JlYWQvd3JpdGUvdXBkYXRlX2JpdHMgZG8gYW5kIHJl
YWRpbmcNCj4gYW5kIHVuZGVyc3RhbmRpbmcgYWRnMTQxNF9zZXQvZ2V0IGNvZ25pdGl2ZWx5IHJl
cXVpcmUgbW9yZSBmcm9tIHVzDQo+IGFzIG1haW50YWluZXJzLg0KDQpIaSBMaW51cywNCg0KSSds
bCBjaGVjayB0aGlzIG91dC4NCg0KVGhhbmtzLA0KS2ltDQo=

