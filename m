Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74AAF7DCACE
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 11:29:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231383AbjJaK3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 06:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbjJaK3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 06:29:42 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23E38E4;
        Tue, 31 Oct 2023 03:29:38 -0700 (PDT)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 39V8DmMJ021743;
        Tue, 31 Oct 2023 06:29:07 -0400
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3u1f5hx9de-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Oct 2023 06:29:07 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XxVo38nrCJ2180WNLsKJ8qVtN9UCwOCWdb1+ODMkfJnEKh9RUJsNDQjRkipxBVIMXwPgaQ7s6vO8N2wU4VuZUrmkPLsYlbWIQfXlsBlrZBr6H5tOHz/VxiCooscJDN8AcqQBR9t3A+HczL9h5S3UBzknmD+t/7+H7u4GptAPEI7QzYz1WPOqgsPIQ2VEBaHavDhpQvvUZFlvZYNLOqx+MX3gbwg/jI1r32Uzdne+H5twLm0OAgdedz5N0q9FbDoX3XMsazL4DYY+DiDwmSNBVf1a+MvTrhGKXJxl3TUev4zt5bPjFaWpSY52j7uVZqosjIoXsIGnoDMsJDEfquu3dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8NT3bJMDSZ4wiNVJyrgiOtG1DXkju0+Qm+muqu06abo=;
 b=QxHGGx/1FFaWnHjobHiInKNIcYSUEof20ncaZL1U7C3Y6WmbzeOgCyK1SK99LRgNma4RYZkQcMiKMlSIPqatApKn93leVHv55sRZw7T3H3xbLer1T1V3r6AO0PcSAHPRqYW71u2asbUnpUEeUMTzDP4EOsn5NefEa0FTfqlo8VGVlw/Jqg3thN0POTmiUKeW2q9q2SmyRZ/Z6G12zbQRX2zNPzJv0ZYugmh1o/YB+JNjNrMOap9UHjXrK+rpi2qBXEQ/76ef+D2JMSqjRzeOYNZ+n+1ovbeC/pw2OIEuYCIe2gvfZLxvH3sQJXYlnl4xSMqocwkqgJDU3K/dnoWVSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8NT3bJMDSZ4wiNVJyrgiOtG1DXkju0+Qm+muqu06abo=;
 b=B2R9HQaoyI1JDrU4i/bsRV495cQrmcpmeuM9SWlEX5l3v2K0Q9ztZiQ2D9BGfXoeZHZvuf9Yv0Au5s7u2GIz2aPG54SpE+ZfMVWOJ6CKb+F6WHKg/P2ftjhzJB3kGcgUd2UrN23yDgjaP50ClX6Rpupecr8YnhjvioJ/CQ3Ud3U=
Received: from CY4PR03MB3399.namprd03.prod.outlook.com (2603:10b6:910:57::13)
 by BY5PR03MB5234.namprd03.prod.outlook.com (2603:10b6:a03:219::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.17; Tue, 31 Oct
 2023 10:29:04 +0000
Received: from CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::26c3:a563:9b0a:3321]) by CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::26c3:a563:9b0a:3321%3]) with mapi id 15.20.6954.014; Tue, 31 Oct 2023
 10:29:04 +0000
From:   "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>
Subject: RE: [PATCH 1/2] dt-bindings: rtc: max31335: add max31335 bindings
Thread-Topic: [PATCH 1/2] dt-bindings: rtc: max31335: add max31335 bindings
Thread-Index: AQHaCyeKLCuMriAqW0+5lr1vn1bC0LBilZ4AgAEdooA=
Date:   Tue, 31 Oct 2023 10:29:03 +0000
Message-ID: <CY4PR03MB3399A0D6DCA419936B024D759BA0A@CY4PR03MB3399.namprd03.prod.outlook.com>
References: <20231030115016.97823-1-antoniu.miclaus@analog.com>
 <20231030115016.97823-2-antoniu.miclaus@analog.com>
 <11906efc-e16a-40bc-98a5-db32fefbf355@linaro.org>
In-Reply-To: <11906efc-e16a-40bc-98a5-db32fefbf355@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jWVcxcFkyeGhkWE5jWVhCd1pHRjBZVnh5YjJGdGFXNW5YREE1WkRnME9X?=
 =?utf-8?B?STJMVE15WkRNdE5HRTBNQzA0TldWbExUWmlPRFJpWVRJNVpUTTFZbHh0YzJk?=
 =?utf-8?B?elhHMXpaeTAwWlRWaFlXWXpNeTAzTjJRNExURXhaV1V0WVdVM09DMWtORGd4?=
 =?utf-8?B?WkRjMU1EWmtaR1ZjWVcxbExYUmxjM1JjTkdVMVlXRm1NelV0Tnpka09DMHhN?=
 =?utf-8?B?V1ZsTFdGbE56Z3RaRFE0TVdRM05UQTJaR1JsWW05a2VTNTBlSFFpSUhONlBT?=
 =?utf-8?B?SXpPVEF3SWlCMFBTSXhNek0wTXpJeU1UYzBNVFkxTlRZM01UVWlJR2c5SW5O?=
 =?utf-8?B?NFRGazViVXgyY0d4YVJsVlVWQzk0TVVGbE1tTnpRalJ4VFQwaUlHbGtQU0lp?=
 =?utf-8?B?SUdKc1BTSXdJaUJpYnowaU1TSWdZMms5SW1OQlFVRkJSVkpJVlRGU1UxSlZS?=
 =?utf-8?B?azVEWjFWQlFVVnZRMEZCUTNJMFRGRlJOVkYyWVVGWE0yZHlhMFZYV1U5d2JX?=
 =?utf-8?B?SmxRM1ZSVWxwbk5tMVpSRUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
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
x-ms-traffictypediagnostic: CY4PR03MB3399:EE_|BY5PR03MB5234:EE_
x-ms-office365-filtering-correlation-id: 94afc8fa-d189-4675-477e-08dbd9fc349c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tnRy11WauJbR3xFD30pVPRf5bcnytfzY+86n4R34My+2mh5/nPWGUFeryZ6zm+wiih30qcroDpgy4kZ4fnIEqF72bLY9iBAjiR8CIsX7IsxlEhzWXt92R3TCv86T0kBOF10/rIHMeBEkoLVc7lqAnICJDUshsULKpXUfiKjvL4cu1BYeH34bxt0Iphy6IRfb1jhQr2DYALBhwMwu/0XgjDgiQhAhZR1ujYlpjDY0A9/fQZ6OFfiATGrNaJe/7A7vA6xsc/yULJkAwYs9Z1X9rvn2ceiN8hzdPkzEd4sOy5l5dPYCOcu2d+n48WRe1XInRNFSJXV90YREXS9Tmu4vllYMckHDmpq43z5FAwGvres91eZQFzHZ04GBrfVpQmWeAk8+JV81cp68srYt5XPLyQ5tj/NZ2/3LfyhjVkH/yZpos8HXlOsQTuCRpe7tj+X+YfeNrEYhTdQPzyIlaspScREg6RVmPonb8vZ9o9WhHxmv+806VoojWkNPkmHpEZC0tknwdi8YtA4VDNZIrRpz8QszvGrY90HSZk1uu0U7uRxIdlvi66jIFQHITXKThbijFv8gs0gZfgzMGbKR+nk5CnBIoDqnD31JBHH+5FzyTsaoVoCzlcpzSJJuYu0oowNaDu31YDcEvQM5TtnSeICdfL1sbTeGh4OEWdozk9cctfz9McwCWspXy2fuKW34KqL1Mid48Ca6dAAJqOJ2lsTLHA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR03MB3399.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(136003)(376002)(396003)(346002)(366004)(230922051799003)(230173577357003)(230273577357003)(1800799009)(186009)(451199024)(64100799003)(7416002)(52536014)(2906002)(921008)(966005)(8676002)(8936002)(5660300002)(38070700009)(41300700001)(55016003)(316002)(66476007)(66556008)(66946007)(76116006)(110136005)(64756008)(86362001)(66446008)(478600001)(83380400001)(26005)(66574015)(71200400001)(9686003)(6506007)(7696005)(53546011)(122000001)(33656002)(19627235002)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z2VTMWR3aDBIemNBd1lRUHArTGZDZVRKcExIajd3c0RqaDN4Uzk1TkxSMTZ6?=
 =?utf-8?B?bnlGR3dUM2h3MVB1aHJwRGoyb1BNMWZJcmt4U3RublVzOHJSM1pDNXI0RkVI?=
 =?utf-8?B?SEtqZlIyWmtYazdsY2Z3ZDFIOTdoSnFWeHNSTWVuZDhkTkV1eGl3cnpicTcx?=
 =?utf-8?B?TWlHa0oxcFBCMTJ2VmVrbkV5SjIxVCthRWwyQ2FqS01xODRJRTBwMjFnOWZL?=
 =?utf-8?B?N1Erck5aTFZlUmQzc3RyaERXbktXb0wya014Q3ZLUHhoTzV3aFMzU0l1SUtR?=
 =?utf-8?B?azQ3eERBbDh5SWdQLzJ0b2lyVis0T3ZPb3NrNlRtUXF1RkwvVmR0YmQ5bUJt?=
 =?utf-8?B?VWtzWVdCVHlmUFpkMWkxcmZwSjJiTi85ZnRYLzN6dWMraFVpSkVFTEJRaUJ6?=
 =?utf-8?B?MGU5b1dvUzJSczN3c3JTTUt2NytYQ1BwRy9LdW15RmsxVlJpM2IrT0R2NER1?=
 =?utf-8?B?OSswN3Q0ME54SG0vYzRSZmJDZUpaV1FkdU5SZGNhZTFQSzRmQVorVnVtSFdz?=
 =?utf-8?B?c1o0TUJ2UHptckFkOVdIWlJVcmYrZCs1VjJyeWRSUDJZczMrS0dyMUM1TTB4?=
 =?utf-8?B?L01yZHl1OThOY0lLamliSEVtK3NnSjNYUHNET3JCc3Y4bDZOYURqSGYrMmE0?=
 =?utf-8?B?b1gvVy9yRWxHcG1hQ3ZoclVCVlM2S2ppZExRZG53S3FZVGYxMFV2SDdTWUdT?=
 =?utf-8?B?dE9scmZvaUg0cWRXekpTUEZQS3ZVWVljM1gvVWtuVVFVWGU5QllTR3BXenZs?=
 =?utf-8?B?T0M3ajRMQmt2ZTRDVVFVSW9YdFkvOG9rbmdWOVU1aUZ1c2tjUHUzMTNLUy81?=
 =?utf-8?B?cEFuWDNlNm1hSUI3MVBqQTZJeVlEUE5WdWZCMlp4KzVjSHhwaWZtZmJPYy94?=
 =?utf-8?B?cnMrQlljQmtiOEdBT1dmak42RFlEcktGWE83UDRWR0tjUGhRRVBjc1ZCUHFx?=
 =?utf-8?B?b1UxNmhaUURaaGsxSythRTZWV3VaVzJLMllPWjh6ejhTQ2t3TlRZdDdlZnVL?=
 =?utf-8?B?ektpZjJ2SWpDaEt2Q1BIN0NyZElBdVk0bHE4Zjh3VCtKSFB0OS8vS2JlSVoz?=
 =?utf-8?B?eTFlQ2QrTHFXMThNYlZnWUZIeCt4UEM5dGYyakhnMVZ5OGdiNjBOdGZENmZB?=
 =?utf-8?B?RWJVK0d3ZWloV3hSRGdKOHFmTW5zRThTWUZhMCt4NExwVW9WWHQ5Y0NtVFFN?=
 =?utf-8?B?andFendQSmJUcmF4Z2ZTZmc1ZVhYRE1jSy95UXlNa1FtNFdkbXlvNU05Qkds?=
 =?utf-8?B?ZGhCS3Q2Z1FsMFdZN0xoUWJ1aVE3WUN4RTJna2QyMjdMR2JrRE0yWm9tZERX?=
 =?utf-8?B?MitFOExuYzU0Nk5NcVZndENSSXh4OGl3WTNpV1pPeFJPd2VTcTdncnlYVjg1?=
 =?utf-8?B?YWY1NjNsRkx0MUhFcHBzaUF6YWgwNFBVcHl2SWI1Ykxld29NZlhHb3dwcFMy?=
 =?utf-8?B?L2YyYkNBTEVQWTBZMUl6RlIzZnJuV0tKc0s0NDlIWjBBOEo0eFdUcHdLdjMx?=
 =?utf-8?B?Wk5wTnJ5ZENjT1RoR3g2SmpzVVpJQjlYSFFLaE5LME16TFZaVlJJb0Vyb1gv?=
 =?utf-8?B?MEZ6cEpudS9weGlwSGE2QVQxbjlKUnhUTmJNci84MGVGMHhkWk9rLzRIL2d3?=
 =?utf-8?B?UmpYaEZaaEp1VW1jR2hFRkdzcEJ6b1FVTjRhcUY0RzlMa2grRS8wam1hbS80?=
 =?utf-8?B?Y1ZaMkFrZFdUV25RRVV6SUp1UitLUTVaRUgwdndnYi9sVWFBeEFSQWM3SzF5?=
 =?utf-8?B?S2xFWXpLdHBIcnQzZURxWVlSU2hBYW1tc0I4QmpaVFNWUUU5ZTN2eVVKS0N2?=
 =?utf-8?B?Nzh5OGZ2YWIvSHVBUmNFUGR6TE9SOVpubDJVdy9yUG10L3g0S1oxejNEaXh5?=
 =?utf-8?B?OWw2Z3lEZ21HWlJFVHZISC9Ua2tMVUF4L2MvK2tUbEVzdGJ4TVVheFQzUWky?=
 =?utf-8?B?MmpiSU55UWRacnFPOEY4a3MxVE55d05GNXZVbzgxak5OUDlrVi9EWHFqK0s4?=
 =?utf-8?B?VmZ0Y2pKUXNJWlJ2THNxR2JGSzdXRFd0eUp4Vlh2WmoyVEhFcWlzYmpkSW5R?=
 =?utf-8?B?VXpGMG1jUW4wMi9tQVlLZ2FTYW1iODI3bUI4OFlJTU1KTW5vcFFOK2hnQ1Fy?=
 =?utf-8?B?cllUSVdERkxSRFVGejNPQnp2UCtjdTRiMWx5U2plZlJxemFPbWpnV3ZHalNV?=
 =?utf-8?B?U3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR03MB3399.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94afc8fa-d189-4675-477e-08dbd9fc349c
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2023 10:29:04.0410
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tzEieMFO4DEXV8esdpgUkUplhYINhHvRsp/yHs8eHhp3fJubEuUZYTTjpdInUGVwy053ryPcmJf4ACBCSSqa2Orh/Zxx4yng9+QXd6tTbiE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB5234
X-Proofpoint-GUID: taCxMHUTcDiroGVBNbHKpS_tXBbmyJNJ
X-Proofpoint-ORIG-GUID: taCxMHUTcDiroGVBNbHKpS_tXBbmyJNJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-30_13,2023-10-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 malwarescore=0 adultscore=0 impostorscore=0 bulkscore=0
 priorityscore=1501 phishscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2310240000 definitions=main-2310310081
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCi0tDQpBbnRvbml1IE1pY2zEg3XFnw0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQo+IEZyb206IEtyenlzenRvZiBLb3psb3dza2kgPGtyenlzenRvZi5rb3psb3dza2lAbGluYXJv
Lm9yZz4NCj4gU2VudDogTW9uZGF5LCBPY3RvYmVyIDMwLCAyMDIzIDc6MjUgUE0NCj4gVG86IE1p
Y2xhdXMsIEFudG9uaXUgPEFudG9uaXUuTWljbGF1c0BhbmFsb2cuY29tPjsgQWxlc3NhbmRybyBa
dW1tbw0KPiA8YS56dW1tb0B0b3dlcnRlY2guaXQ+OyBBbGV4YW5kcmUgQmVsbG9uaQ0KPiA8YWxl
eGFuZHJlLmJlbGxvbmlAYm9vdGxpbi5jb20+OyBSb2IgSGVycmluZyA8cm9iaCtkdEBrZXJuZWwu
b3JnPjsNCj4gS3J6eXN6dG9mIEtvemxvd3NraSA8a3J6eXN6dG9mLmtvemxvd3NraStkdEBsaW5h
cm8ub3JnPjsgQ29ub3IgRG9vbGV5DQo+IDxjb25vcitkdEBrZXJuZWwub3JnPjsgSmVhbiBEZWx2
YXJlIDxqZGVsdmFyZUBzdXNlLmNvbT47IEd1ZW50ZXINCj4gUm9lY2sgPGxpbnV4QHJvZWNrLXVz
Lm5ldD47IGxpbnV4LXJ0Y0B2Z2VyLmtlcm5lbC5vcmc7DQo+IGRldmljZXRyZWVAdmdlci5rZXJu
ZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4gaHdtb25Admdl
ci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMS8yXSBkdC1iaW5kaW5nczogcnRj
OiBtYXgzMTMzNTogYWRkIG1heDMxMzM1IGJpbmRpbmdzDQo+IA0KPiBbRXh0ZXJuYWxdDQo+IA0K
PiBPbiAzMC8xMC8yMDIzIDEyOjUwLCBBbnRvbml1IE1pY2xhdXMgd3JvdGU6DQo+ID4gRG9jdW1l
bnQgdGhlIEFuYWxvZyBEZXZpY2VzIE1BWDMxMzM1IGRldmljZSB0cmVlIGJpbmRpbmdzLg0KPiA+
DQo+ID4gU2lnbmVkLW9mZi1ieTogQW50b25pdSBNaWNsYXVzIDxhbnRvbml1Lm1pY2xhdXNAYW5h
bG9nLmNvbT4NCj4gPiAtLS0NCj4gPiAgLi4uL2RldmljZXRyZWUvYmluZGluZ3MvcnRjL2FkaSxt
YXgzMTMzNS55YW1sIHwgNjENCj4gKysrKysrKysrKysrKysrKysrKw0KPiA+ICAxIGZpbGUgY2hh
bmdlZCwgNjEgaW5zZXJ0aW9ucygrKQ0KPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQNCj4gRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3J0Yy9hZGksbWF4MzEzMzUueWFtbA0KPiA+DQo+
ID4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9ydGMvYWRp
LG1heDMxMzM1LnlhbWwNCj4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcnRj
L2FkaSxtYXgzMTMzNS55YW1sDQo+ID4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gPiBpbmRleCAw
MDAwMDAwMDAwMDAuLmI4NGJlMGZhMzRlZg0KPiA+IC0tLSAvZGV2L251bGwNCj4gPiArKysgYi9E
b2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcnRjL2FkaSxtYXgzMTMzNS55YW1sDQo+
ID4gQEAgLTAsMCArMSw2MSBAQA0KPiA+ICsjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwt
Mi4wLW9ubHkgT1IgQlNELTItQ2xhdXNlDQo+ID4gKyVZQU1MIDEuMg0KPiA+ICstLS0NCj4gPiAr
JGlkOg0KPiBodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cDovL2RldmljZXRyZWUub3Jn
L3NjaGVtYXMvcnRjL2FkaSxtYXgzMQ0KPiAzMzUueWFtbCpfXztJdyEhQTNOaThDUzB5MlkhOGRF
SVRXY1RRLQ0KPiBlWl9LRzBUUmxaOWdoV3VEUG5ad1Ixb1I1T3BHeXZKa21BT3hzRnhEWUk3clVx
Ui0NCj4gVV9LU1FjR2JrcXhKM2dscUJjSmFfampidWtlVnR5VlN3LUxDcTMkDQo+ID4gKyRzY2hl
bWE6IGh0dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMvX19odHRwOi8vZGV2aWNldHJlZS5vcmcvbWV0
YS0NCj4gc2NoZW1hcy9jb3JlLnlhbWwqX187SXchIUEzTmk4Q1MweTJZIThkRUlUV2NUUS0NCj4g
ZVpfS0cwVFJsWjlnaFd1RFBuWndSMW9SNU9wR3l2SmttQU94c0Z4RFlJN3JVcVItDQo+IFVfS1NR
Y0dia3F4SjNnbHFCY0phX2pqYnVrZVZ0eVZSSTc2NzluJA0KPiA+ICsNCj4gPiArdGl0bGU6IEFu
YWxvZyBEZXZpY2VzIE1BWDMxMzM1IFJUQyBEZXZpY2UgVHJlZSBCaW5kaW5ncw0KPiANCj4gSXQg
ZG9lcyBub3QgbG9vayBsaWtlIHlvdSB0ZXN0ZWQgdGhlIGJpbmRpbmdzLCBhdCBsZWFzdCBhZnRl
ciBxdWljaw0KPiBsb29rLiBQbGVhc2UgcnVuIGBtYWtlIGR0X2JpbmRpbmdfY2hlY2tgIChzZWUN
Cj4gRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3dyaXRpbmctc2NoZW1hLnJzdCBm
b3IgaW5zdHJ1Y3Rpb25zKS4NCj4gTWF5YmUgeW91IG5lZWQgdG8gdXBkYXRlIHlvdXIgZHRzY2hl
bWEgYW5kIHlhbWxsaW50Lg0KPiANCj4gQWx0aG91Z2ggSSB3b25kZXIgd2h5IHRoZXJlIGlzIG5v
IGVycm9yIHJlcG9ydCBmcm9tIHRoZSBib3QuDQo+IA0KPiBEcm9wICJEZXZpY2UgVHJlZSBCaW5k
aW5ncyINCj4gDQo+ID4gKw0KPiA+ICthbGxPZjoNCj4gPiArICAtICRyZWY6IHJ0Yy55YW1sIw0K
PiANCj4gVGhpcyBnb2VzIGFmdGVyIGRlc2NyaXB0aW9uLiBTZXZlcmFsIGV4aXN0aW5nIGZpbGVz
IGhhdmUgaXQgaW4gb3RoZXINCj4gcGxhY2UsIGJ1dCBpZiBkb2luZyBjaGFuZ2VzIHRoZW4gd2Vs
bC4uLg0KPiANCj4gPiArDQo+ID4gK21haW50YWluZXJzOg0KPiA+ICsgIC0gQW50b25pdSBNaWNs
YXVzIDxhbnRvbml1Lm1pY2xhdXNAYW5hbG9nLmNvbT4NCj4gPiArDQo+ID4gK2Rlc2NyaXB0aW9u
OiBBbmFsb2cgRGV2aWNlcyBNQVgzMTMzNSBJMkMgUlRDDQo+IA0KPiBEcm9wIG9yIHNheSBzb21l
dGhpbmcgZWxzZSB0aGFuIHRpdGxlLg0KPiANCj4gDQo+ID4gKw0KPiA+ICtwcm9wZXJ0aWVzOg0K
PiA+ICsgIGNvbXBhdGlibGU6DQo+ID4gKyAgICBjb25zdDogYWRpLG1heDMxMzM1DQo+ID4gKw0K
PiA+ICsgIHJlZzoNCj4gPiArICAgIGRlc2NyaXB0aW9uOiBJMkMgYWRkcmVzcyBvZiB0aGUgUlRD
DQo+IA0KPiBEcm9wIGRlc2NyaXB0aW9uLCBvYnZpb3VzLg0KPiANCj4gPiArICAgIG1heEl0ZW1z
OiAxDQo+ID4gKw0KPiA+ICsgIGludGVycnVwdHM6DQo+ID4gKyAgICBtYXhJdGVtczogMQ0KPiA+
ICsNCj4gPiArICAiI2Nsb2NrLWNlbGxzIjoNCj4gPiArICAgIGRlc2NyaXB0aW9uOg0KPiA+ICsg
ICAgICBSVEMgY2FuIGJlIHVzZWQgYXMgYSBjbG9jayBzb3VyY2UgdGhyb3VnaCBpdHMgY2xvY2sg
b3V0cHV0IHBpbi4NCj4gPiArICAgIGNvbnN0OiAwDQo+ID4gKw0KPiA+ICsgIHRyaWNrbGUtcmVz
aXN0b3Itb2htczoNCj4gPiArICAgIGRlc2NyaXB0aW9uOiBTZWxlY3RlZCByZXNpc3RvciBmb3Ig
dHJpY2tsZSBjaGFyZ2VyLg0KPiA+ICsgICAgZW51bTogWzMwMDAsIDYwMDAsIDExMDAwXQ0KPiAN
Cj4gZGVmYXVsdD8gT3IgbWlzc2luZyBwcm9wZXJ0eSBoYXMgb3RoZXIgbWVhbmluZy4uLg0KDQpJ
ZiB0cmlja2xlLXJlc2lzdG9yLW9obXMgcHJvcGVydHkgaXMgbWlzc2luZywgdGhlbiB0aGUgdHJp
Y2tsZSBjaGFyZ2VyIHNldHVwIGlzIHNraXBwZWQuDQoNCj4gDQo+ID4gKw0KPiA+ICsgIHRyaWNr
bGUtZGlvZGUtZW5hYmxlOiB0cnVlDQo+IA0KPiBXaGVyZSBpcyBpdCBkZWZpbmVkPyBZb3UgYWRk
ZWQgaXQgYXMgaXQgd2FzIGEgY29tbW9uIHByb3BlcnR5LCBzbyB3aGVyZQ0KPiBpcyB0aGUgb25l
IGRlZmluaXRpb24/IE1heWJlIHlvdSB3YW50ZWQgdG8gdXNlIG90aGVyIHByb3BlcnR5IGZyb20N
Cj4gcnRjLnlhbWwgd2hpY2ggaXMgZGVwcmVjYXRlZCwgc28gb2J2aW91c2x5IG5vdC4uLg0KPiAN
Cj4gPiArDQo+ID4gK3JlcXVpcmVkOg0KPiA+ICsgIC0gY29tcGF0aWJsZQ0KPiA+ICsgIC0gcmVn
DQo+ID4gKw0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCg0K
