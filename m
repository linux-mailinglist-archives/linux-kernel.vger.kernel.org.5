Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7BC47DC9BF
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 10:37:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343956AbjJaJhR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 05:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343947AbjJaJhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 05:37:16 -0400
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A431CB7;
        Tue, 31 Oct 2023 02:37:13 -0700 (PDT)
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 39V7YKnX002996;
        Tue, 31 Oct 2023 05:36:40 -0400
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3u1fu3ve84-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Oct 2023 05:36:40 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J/PxCUKfAfa8XqKaP96Gmm7Y4WWE8S8grZIMANab+fmrf1CDZdpMoejsriYSz800hW4DiT7Pl7eqvMuoNy1YkK09ZSRvDR33K4Yiv7iDRzerfKuR1gKz0XphPmaX7G09QXPjpxyqfT/thsOk6UxhQyoZfj9xwVXjj5Mtb8J7R0/gUVAez0JoMoRJWa7X3X1Oz1gdp8W0y0aumqdQ+pdDv9itAk19oQfS7Hh/TpEg8sEPbyaq+oe04jVvtpoTyBEF8VzCIDPi0iHiDdwsC7baifCZR53Hn3+A19OuRkknE3tZCJy36ADk1sBPNQsdNbLM1wTjtKo4VqZ02sNsQD1cGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AT5E+4/yuRJTURZmn/NNecFFkvLdpo8Qw/X2Rf2bI3M=;
 b=famWJ1H+PvFSjNFN6eQxNWP7TxlV1X9KIQKuFZLSHhDhBVNmNNizmq6MyceRt/qz4etP1ZSLA6y4huCkB/nLUUcU649/YaVzRjj3RW9VrcXz2QxeUbkF5ZkSCa3ZNNQr/IkjUVeVmzcjKmEMo6WwIFyAB5W2OnBlxKdO1uvZsdPje0UpzFTa8WhGN2VUc8r0hfylDApOYE9fMw/PZG7yPl7UiB3bleSjFNhX5W+oAKFCUNJNWn+HwNbxRixZ4YIwkxTWBtbyN76UKjTYQJjOkHoyRtdL18f8cHp/o6OoXxeYip5FTL7rYE5qr2ZyNPm1akgfRO7OpnYKQUb8OM2yLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AT5E+4/yuRJTURZmn/NNecFFkvLdpo8Qw/X2Rf2bI3M=;
 b=oTyMKpPg5ssRkWqdTccTXgCCDGh7KGJCUd/gx0ypn4E9vyDNVTKHeMKm79CVron2drJEjWwSCIvrEKAer5Yv9+ntxSeohfgYjhpnvYbbOAwua3bVEzlurXPsKLkGlZrNfEjxL9wdBrNRyvsuOatHdybFrNvmMCZvKXQtR1+7Pq8=
Received: from CY4PR03MB3399.namprd03.prod.outlook.com (2603:10b6:910:57::13)
 by SA1PR03MB6483.namprd03.prod.outlook.com (2603:10b6:806:1c2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.14; Tue, 31 Oct
 2023 09:36:37 +0000
Received: from CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::26c3:a563:9b0a:3321]) by CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::26c3:a563:9b0a:3321%3]) with mapi id 15.20.6954.014; Tue, 31 Oct 2023
 09:36:37 +0000
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
Thread-Index: AQHaCyeKLCuMriAqW0+5lr1vn1bC0LBilZ4AgAEPBkA=
Date:   Tue, 31 Oct 2023 09:36:37 +0000
Message-ID: <CY4PR03MB33997CBD72404C5EC79677449BA0A@CY4PR03MB3399.namprd03.prod.outlook.com>
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
 =?utf-8?B?elhHMXpaeTFtWVRoaU1EZGhZeTAzTjJRd0xURXhaV1V0WVdVM09DMWtORGd4?=
 =?utf-8?B?WkRjMU1EWmtaR1ZjWVcxbExYUmxjM1JjWm1FNFlqQTNZV1V0Tnpka01DMHhN?=
 =?utf-8?B?V1ZsTFdGbE56Z3RaRFE0TVdRM05UQTJaR1JsWW05a2VTNTBlSFFpSUhONlBT?=
 =?utf-8?B?SXpNakU1SWlCMFBTSXhNek0wTXpJeE9EVTVORFUzT0RnMU16a2lJR2c5SW1o?=
 =?utf-8?B?dE5EUkVOV1ZtVDFaTlEyMHZaa0pOYVVkd1EwZDViRkpvY3owaUlHbGtQU0lp?=
 =?utf-8?B?SUdKc1BTSXdJaUJpYnowaU1TSWdZMms5SW1OQlFVRkJSVkpJVlRGU1UxSlZS?=
 =?utf-8?B?azVEWjFWQlFVVnZRMEZCUWpkRlQyVTRNMUYyWVVGV1JVNXZjSGxXYVVOU01G?=
 =?utf-8?B?VlJNbWx1U2xkSlNraFJSRUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
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
x-ms-traffictypediagnostic: CY4PR03MB3399:EE_|SA1PR03MB6483:EE_
x-ms-office365-filtering-correlation-id: c6d3c05f-886d-4771-0b53-08dbd9f4e0e8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4WdnYQXHMVsoiWELf1SJ5jGSsYhO09D8ZLw1zixlCI0xPEJLjMhohlMRO46XXHEgH4Wnp0IsQy5jocPH7d4rif895bbtD0O73iwe92i6gRQe4BJBbHMKctp1Qj1IqQ6ltpZWEhY1JY8I2WUdsXLGMigmkxO3rJBtV3lfGYtDGP0PgWFyLUXxhxLuZeJ5PXEG1KwgACOnYoQEDZxrFOQVHJaOLXThl6uskjxRwTkd7L5bj/uLA/9h+JxU8wbKrPNtAkfw7EWBxF2NtVVlrFX4WPb3VBao5KvoHcpgKfuQahsO2m2+wMPecexzY0ZrHQ3SIO0U33mOxkgfG6Pfjq9mo1j/Qy3c8C5mzzH32GLjpk7dXVSGRzcgm5s3ObHJuyy20TqhFSxXT3oP3PRvnlqlFFYdoseVWOIYEsJTwmYpbfQTOMCsN7zllu2Ks+/TEuaMtJ1+jMoCu68h/aQ3AvrKl5JTVrtbFLKR7hc0ab1zP6nJsv5jAxqI76fsmI/lJSYA5KhOyyi7IlBQUZBrLOqZ8v2IUpVEPHZqHxYLUU2AvADjvM91vUhG8W0+83Pw7y749IDfQFmcJwIOWGGRNKJwgnkHjbcs4TRcvf0IA/WJctjELg86+MwxT5xLKOyGytEddsq5DSL0pkHxxxY4fGBtfUR5Hf3WupQ7rrx9I1Bi78M=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR03MB3399.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(39860400002)(136003)(396003)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(26005)(7696005)(53546011)(6506007)(55016003)(38070700009)(9686003)(921008)(38100700002)(33656002)(86362001)(122000001)(64756008)(83380400001)(5660300002)(19627235002)(7416002)(41300700001)(316002)(76116006)(110136005)(66476007)(66946007)(66446008)(66556008)(52536014)(8936002)(8676002)(966005)(71200400001)(2906002)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TllEYk1va3VOaXdONVRDMG9Cb3pQa1JLNjl4NytiZ2UxZlkyODNFSDRwN0ty?=
 =?utf-8?B?WTZSTlJoRGV1NE4xZzJUQVlVM01vNU5ERnJmSnFhcEhWa2xuVnloK29sMW1S?=
 =?utf-8?B?eHhLUWFvK2pTaUNyNXRzM0lXVlRRTTN4ZjdhSEVCK0poWUJVOEJyN3hsT0Yz?=
 =?utf-8?B?VlZwR2UzbHc3eUhKY2crcWpYbmFCYlg4SzE0R1FXcmIxZkkxOUhxZjlBN0Vq?=
 =?utf-8?B?bW1OOGtaTkRCdzZtcWNzK3ZjQkloS0RHZGdSOXVPQjlYNWlyTi9kM1NWNFlB?=
 =?utf-8?B?WlNNWnp5MzNwcWNXdTExME1pMGxFYlpUYzdJL1B0Wk8vajFYMWx4SkJrUlJt?=
 =?utf-8?B?S1JlUldrTloyMUxTWGpueW1zbTBpOE9wek5KVk1OQXVWVjZnUEs1Qk5XZG1T?=
 =?utf-8?B?T0VLWmxObERNNmt5M01RaXlBclBzbWZvbTNGdnp4TVRNZEZuTHZSNmxQWmlN?=
 =?utf-8?B?K2ptSlE2KzQ5VE90Q1p2bkZhNjY1RTBlL0MySGF3S0luTkdQZFpaVnZTMDRn?=
 =?utf-8?B?ajQrbUlXRmM5OEdzMHhCSThxOE8wTHNYL0pOdDhLOFV6TUtBMGVvMG1nTDl0?=
 =?utf-8?B?SU9tVm5DQTJwMTNINlRxVTZsVlVOalRhZlJVVEpJRGtubGhsT0Z6QjJBZ2dU?=
 =?utf-8?B?NmVGRWt2bXE5VnE5SFVCMGpxUUkxK0F0U1l0QlY3RkVheEpnc0U4NWx3RjRx?=
 =?utf-8?B?Vy90eklJcEVBQzJNMVBWL3dhclBQbTNuY1pCVzB2SHdrdWlPNU85NU95Y01Q?=
 =?utf-8?B?YmNxaDlsZmttVTFhalBPLzdDck15V0oyelhwc2JvTWhCVG9JZTlPWndMdTFo?=
 =?utf-8?B?KzVlenF5YVJ1d1RGSFBTOU1GeHF4cEFPZVdENHdNUXJaQVVaZWFKZW9qU3VU?=
 =?utf-8?B?WTRVbFdXRStqVmdNSHNZTVVta0RBYmxEWEZWaDZoMk4yNUJKZWFVTVc0MjF3?=
 =?utf-8?B?U2l0ZmR1VkZnTkp5SjdnaE94c0pyUDRNejNXajlEYVpydlh6QUVyVUg4aWp2?=
 =?utf-8?B?K1luOHA2M3Vld29VOTdEZHRYNFF5cnA4eHU1YS83ZmUzV25tZ1dFY1dKOUZn?=
 =?utf-8?B?eHk5VkFQTEpNWEh6SVRZbzV6bkUvWlFuamsxOW5PSXNUdHFEUTZkekk5ajlL?=
 =?utf-8?B?cXQvb0JMemM4cC9EMWtHYTlqQURsTUpVbWIzL25kNHN1OFVKT0xsNGtrWFdu?=
 =?utf-8?B?VGZwcS9UMzMwUEdyanUyRFNNbXFVUjRFV2U0dmQrdjVJaWxXdjBONGk1b2pa?=
 =?utf-8?B?TjN5ZkxRYjhuZDRMa2ZnaGVUTG5QT0J3NkhjZzBoZ3pNczhKWXArQzViaE9N?=
 =?utf-8?B?Q1NwSXkwNk9ZWUJEYm9zSWI4UCt1LzhaSi9pbkhURkRZcnY3dno5dTZVUXow?=
 =?utf-8?B?S2ZDd3NCc0plWXpldTI4TnhTU2pxb3pwNHlCSmxmdW1kSVVvV3dFeXpvS0tO?=
 =?utf-8?B?NHIwbXZQeWNaMmc4Zko4dWI3dDFuK0xncUJjZk11MXMzTEdYaWZSUXdFc2Yw?=
 =?utf-8?B?cFBtMWtFSkVGSWpsU2pNWDR3WnI1cVlwVnpQQmJGSmk5S20ra1RNaFQ4STR4?=
 =?utf-8?B?MXlVa1FkY1ZUTFN6TURmUjR0VlVhb3FEOUU2cHNBNHVrdTNuY2NTNHZrRjBs?=
 =?utf-8?B?ZDdzUTNwdkd1RW9iTVlYeENxajFUc1lTSEpHbXE5RE1FWFhLajhqNmtsTUU2?=
 =?utf-8?B?RXNXQ25ORzVJa2pEclFQV3Y1QWpHc0RYbDRPUmJsNUt4L2JaR09xMzB3ckFR?=
 =?utf-8?B?eGt6dnRyWkIybWxTWVpETGEvTXM2dVJzOCtOdXgzOFo3c25xODN1SCtDR09U?=
 =?utf-8?B?V3RiaGhUN0JzT2ZsbHBzUjhnODVJLzJ1N1BhNmp1VjBuKzl0YldZVGowamNY?=
 =?utf-8?B?TzFlQ1Y0c3g1ZjVnR0krVnBpc3VQRnFwZjRndVRSM0NpUUw1VnF5bXFWNVZm?=
 =?utf-8?B?NEFTZFVzOEY3emo3MU13SVhLSWZuM1RsK0tXalhHMWQ5Z1YxVnBpcmN0aEp3?=
 =?utf-8?B?U05rTlJCbVBtMmtDM1JjOG5udXQyWkZvK01BR2czeHg4SUdyM3BrQWRubS9o?=
 =?utf-8?B?ODdUMldHbXY1TjdVb1NHN240c0tzZ3REMm1CaUIxbTN4T2UzRlhxbURYU1I0?=
 =?utf-8?B?cGVXUXZDOHE1cnhHZkdTZWExTDhLbkJ0czZoY3duNjI1c1h4cThjTnBsampv?=
 =?utf-8?B?VFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR03MB3399.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6d3c05f-886d-4771-0b53-08dbd9f4e0e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2023 09:36:37.1283
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M8VCpM44p58X5Dty5noqsopzSU5jE0ySal9PhiM3EBPCJa4q8CRYoNVdsrT+aGC5BSgbwPX1f6uojjwyff1l8BRyXoYhRy+4WUSBFT+dJok=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR03MB6483
X-Proofpoint-ORIG-GUID: M0RW6hzTWPC0R8OK61knxt6eI8KBrrTe
X-Proofpoint-GUID: M0RW6hzTWPC0R8OK61knxt6eI8KBrrTe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-30_13,2023-10-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 suspectscore=0 clxscore=1011 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 spamscore=0 mlxlogscore=999 bulkscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2310240000 definitions=main-2310310074
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
bWEgYW5kIHlhbWxsaW50Lg0KSW5kZWVkIEkgd2FzIHVzaW5nIGFuIG9sZGVyIGR0c2NoZW1hIHZl
cnNpb24gbG9jYWxseSBhbmQgdGhlIGR0X2JpbmRpbmdfY2hlY2sNCndhcyBub3QgdGhyb3dpbmcg
YW55IGVycm9ycy4gd2lsbCBhZGRyZXNzIHRoZSBjb21tZW50cyBpbiB0aGUgbmV4dCB2ZXJzaW9u
Lg0KPiBBbHRob3VnaCBJIHdvbmRlciB3aHkgdGhlcmUgaXMgbm8gZXJyb3IgcmVwb3J0IGZyb20g
dGhlIGJvdC4NCj4gDQo+IERyb3AgIkRldmljZSBUcmVlIEJpbmRpbmdzIg0KPiANCj4gPiArDQo+
ID4gK2FsbE9mOg0KPiA+ICsgIC0gJHJlZjogcnRjLnlhbWwjDQo+IA0KPiBUaGlzIGdvZXMgYWZ0
ZXIgZGVzY3JpcHRpb24uIFNldmVyYWwgZXhpc3RpbmcgZmlsZXMgaGF2ZSBpdCBpbiBvdGhlcg0K
PiBwbGFjZSwgYnV0IGlmIGRvaW5nIGNoYW5nZXMgdGhlbiB3ZWxsLi4uDQo+IA0KPiA+ICsNCj4g
PiArbWFpbnRhaW5lcnM6DQo+ID4gKyAgLSBBbnRvbml1IE1pY2xhdXMgPGFudG9uaXUubWljbGF1
c0BhbmFsb2cuY29tPg0KPiA+ICsNCj4gPiArZGVzY3JpcHRpb246IEFuYWxvZyBEZXZpY2VzIE1B
WDMxMzM1IEkyQyBSVEMNCj4gDQo+IERyb3Agb3Igc2F5IHNvbWV0aGluZyBlbHNlIHRoYW4gdGl0
bGUuDQo+IA0KPiANCj4gPiArDQo+ID4gK3Byb3BlcnRpZXM6DQo+ID4gKyAgY29tcGF0aWJsZToN
Cj4gPiArICAgIGNvbnN0OiBhZGksbWF4MzEzMzUNCj4gPiArDQo+ID4gKyAgcmVnOg0KPiA+ICsg
ICAgZGVzY3JpcHRpb246IEkyQyBhZGRyZXNzIG9mIHRoZSBSVEMNCj4gDQo+IERyb3AgZGVzY3Jp
cHRpb24sIG9idmlvdXMuDQo+IA0KPiA+ICsgICAgbWF4SXRlbXM6IDENCj4gPiArDQo+ID4gKyAg
aW50ZXJydXB0czoNCj4gPiArICAgIG1heEl0ZW1zOiAxDQo+ID4gKw0KPiA+ICsgICIjY2xvY2st
Y2VsbHMiOg0KPiA+ICsgICAgZGVzY3JpcHRpb246DQo+ID4gKyAgICAgIFJUQyBjYW4gYmUgdXNl
ZCBhcyBhIGNsb2NrIHNvdXJjZSB0aHJvdWdoIGl0cyBjbG9jayBvdXRwdXQgcGluLg0KPiA+ICsg
ICAgY29uc3Q6IDANCj4gPiArDQo+ID4gKyAgdHJpY2tsZS1yZXNpc3Rvci1vaG1zOg0KPiA+ICsg
ICAgZGVzY3JpcHRpb246IFNlbGVjdGVkIHJlc2lzdG9yIGZvciB0cmlja2xlIGNoYXJnZXIuDQo+
ID4gKyAgICBlbnVtOiBbMzAwMCwgNjAwMCwgMTEwMDBdDQo+IA0KPiBkZWZhdWx0PyBPciBtaXNz
aW5nIHByb3BlcnR5IGhhcyBvdGhlciBtZWFuaW5nLi4uDQo+IA0KPiA+ICsNCj4gPiArICB0cmlj
a2xlLWRpb2RlLWVuYWJsZTogdHJ1ZQ0KPiANCj4gV2hlcmUgaXMgaXQgZGVmaW5lZD8gWW91IGFk
ZGVkIGl0IGFzIGl0IHdhcyBhIGNvbW1vbiBwcm9wZXJ0eSwgc28gd2hlcmUNCj4gaXMgdGhlIG9u
ZSBkZWZpbml0aW9uPyBNYXliZSB5b3Ugd2FudGVkIHRvIHVzZSBvdGhlciBwcm9wZXJ0eSBmcm9t
DQo+IHJ0Yy55YW1sIHdoaWNoIGlzIGRlcHJlY2F0ZWQsIHNvIG9idmlvdXNseSBub3QuLi4NCj4g
DQo+ID4gKw0KPiA+ICtyZXF1aXJlZDoNCj4gPiArICAtIGNvbXBhdGlibGUNCj4gPiArICAtIHJl
Zw0KPiA+ICsNCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQoNCg==
