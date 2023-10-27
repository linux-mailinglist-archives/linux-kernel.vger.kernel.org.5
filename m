Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43FE37D9C88
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 17:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346233AbjJ0PF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 11:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346219AbjJ0PFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 11:05:54 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DD191B9;
        Fri, 27 Oct 2023 08:05:52 -0700 (PDT)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 39REB84P000744;
        Fri, 27 Oct 2023 11:05:38 -0400
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3tywr0pq07-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Oct 2023 11:05:37 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cnjevBzy1fp9S2aafy8r+OrTQsInG0mSRNINRUsiX2eEh36prf/kXFm0X9z75C2YJdKwbeVCe7JJF3kkbsb+E/GEg0tmBR31nkwHxftD2+S3AiTxH1iDAwRtTLAOwpUay6eNhexf9CXii/nv7h47SXYqzgLA5SOad1EPC3cxEMSxolXNQrHo7BZN/tJlOQ1WXDlAO3oFdwwKh+owV/VO94VdbGyV8YtaOJajPJ2pKoI6B/mUoaBflPkMycsm/3Tv99k882jCm7xp7Bhn8LLWLmdN9O6U52yGGKo8DLcUIvPeyQsuF/nV5NOrM6DCpZywFs4hQqakWxiW07Pbd2P4vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rWmylU5RtoPPBIRX3lrbwesvO50kzLDu0IU4UaqWtwI=;
 b=i2PALkLHTGt++zx/9KB5rnIOzat2L0b/VlTcYjHqIw+KDJRk2LSEiTdEVa0djtk4a4z/cz5naDSAWGSQZcuIxPfP7jowaNWWuzHUnOwL0U3dFAYDqp5cjryh8eocBjTvtsAW7u7K2OeeCWdH9KAxArXUTwAcUMULa379POzowTku7PVqBEeK8q3td7SyEfgTcmWOVsZZaQDiwYUPJu6tE/Ufd8JF9lmiVz0IKSji638jmfr6cD5pikclpUPERB0KUH6q+pL1VjxhDE4zUIRCwkH3R+tzzHh+P8Fq8CVs/KDdHpwpt0LXTIfgO+RMTFB5/14zwBBDnDzP8kaKMWlEeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rWmylU5RtoPPBIRX3lrbwesvO50kzLDu0IU4UaqWtwI=;
 b=mA1oLHXeBPiNwgyAjcppTFMqU7cdoIcLCOI3AjTWKF0khbvlfvyvZHrWb3GPQqIhc3R3NRcGentrZR7SupNks4rtDLBG8FTcbWboF/Ck33NQYemrtK+6jhFIzKNXNUx8z9Toscxs6/Fc/vHHWhlyRuCM6GfoCXX3PUU6p6zCYnw=
Received: from PH0PR03MB6771.namprd03.prod.outlook.com (2603:10b6:510:122::17)
 by PH0PR03MB7066.namprd03.prod.outlook.com (2603:10b6:510:29c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.11; Fri, 27 Oct
 2023 15:05:34 +0000
Received: from PH0PR03MB6771.namprd03.prod.outlook.com
 ([fe80::d18d:cbcc:2b22:9b25]) by PH0PR03MB6771.namprd03.prod.outlook.com
 ([fe80::d18d:cbcc:2b22:9b25%3]) with mapi id 15.20.6954.011; Fri, 27 Oct 2023
 15:05:34 +0000
From:   "Matyas, Daniel" <Daniel.Matyas@analog.com>
To:     Guenter Roeck <linux@roeck-us.net>
CC:     Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v5 2/4] hwmon: max31827: Add support for max31828 and
 max31829
Thread-Topic: [PATCH v5 2/4] hwmon: max31827: Add support for max31828 and
 max31829
Thread-Index: AQHaCBrux3jCd9w9Ok6JeCc2kSWWE7BdFUuAgABLXpCAAFlUgIAAA21g
Date:   Fri, 27 Oct 2023 15:05:34 +0000
Message-ID: <PH0PR03MB6771E74E7C5CC2FB1DD0EB1989DCA@PH0PR03MB6771.namprd03.prod.outlook.com>
References: <20231026144405.546822-1-daniel.matyas@analog.com>
 <20231026144405.546822-2-daniel.matyas@analog.com>
 <fe99431e-3245-484c-bf26-928048500ec6@roeck-us.net>
 <PH0PR03MB67712B3C063B794442F6D58A89DCA@PH0PR03MB6771.namprd03.prod.outlook.com>
 <84252c5e-9a39-91bd-b7da-2bdea1b2aff6@roeck-us.net>
In-Reply-To: <84252c5e-9a39-91bd-b7da-2bdea1b2aff6@roeck-us.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jWkcxaGRIbGhjMXhoY0hCa1lYUmhYSEp2WVcxcGJtZGNNRGxrT0RRNVlq?=
 =?utf-8?B?WXRNekprTXkwMFlUUXdMVGcxWldVdE5tSTROR0poTWpsbE16VmlYRzF6WjNO?=
 =?utf-8?B?Y2JYTm5MVFF6T0RGbU1qZ3hMVGMwWkdFdE1URmxaUzFpTnpRNUxURTRNV1Js?=
 =?utf-8?B?WVdGbU1UTTBNVnhoYldVdGRHVnpkRncwTXpneFpqSTRNeTAzTkdSaExURXha?=
 =?utf-8?B?V1V0WWpjME9TMHhPREZrWldGaFpqRXpOREZpYjJSNUxuUjRkQ0lnYzNvOUlq?=
 =?utf-8?B?UXlNRElpSUhROUlqRXpNelF5T0RreU56STRPVGd6TkRrME1DSWdhRDBpU0Vw?=
 =?utf-8?B?V1VWTm5XVlV6VTNCaVpFeFBjelpXV2xSdVNEVmlTWEpaUFNJZ2FXUTlJaUln?=
 =?utf-8?B?WW13OUlqQWlJR0p2UFNJeElpQmphVDBpWTBGQlFVRkZVa2hWTVZKVFVsVkdU?=
 =?utf-8?B?a05uVlVGQlJXOURRVUZET0ZCa09FWTFkMnBoUVdZNFpIZHNRWEZuVjBGekwz?=
 =?utf-8?B?Z3pRMVZEY1VKWlEzZEVRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVaEJRVUZCUkdGQlVVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVWQlFWRkJRa0ZCUVVGc1IxUkhWbWRCUVVGQlFVRkJRVUZCUVVGQlFVRktO?=
 =?utf-8?B?RUZCUVVKb1FVZFJRV0ZSUW1aQlNFMUJXbEZDYWtGSVZVRmpaMEpzUVVZNFFX?=
 =?utf-8?B?TkJRbmxCUnpoQllXZENiRUZIVFVGa1FVSjZRVVk0UVZwblFtaEJSM2RCWTNk?=
 =?utf-8?B?Q2JFRkdPRUZhWjBKMlFVaE5RV0ZSUWpCQlIydEJaR2RDYkVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUlVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?blFVRkJRVUZCYm1kQlFVRkhSVUZhUVVKd1FVWTRRV04zUW14QlIwMUJaRkZD?=
 =?utf-8?B?ZVVGSFZVRllkMEozUVVoSlFXSjNRbkZCUjFWQldYZENNRUZJVFVGWWQwSXdR?=
 =?utf-8?B?VWRyUVZwUlFubEJSRVZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFWRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkRRVUZCUVVGQlEyVkJRVUZCV1ZGQ2EwRkhhMEZZZDBKNlFV?=
 =?utf-8?B?ZFZRVmwzUWpGQlNFbEJXbEZDWmtGSVFVRmpaMEoyUVVkdlFWcFJRbXBCU0ZG?=
 =?utf-8?B?QlkzZENaa0ZJVVVGaFVVSnNRVWhKUVUxblFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUpCUVVGQlFVRkJRVUZCU1VGQlFVRkJRVUU5UFNJdlBqd3ZiV1Yw?=
 =?utf-8?Q?YT4=3D?=
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR03MB6771:EE_|PH0PR03MB7066:EE_
x-ms-office365-filtering-correlation-id: 6969ec9e-b212-4bf2-610f-08dbd6fe2bd0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6drv3ZMxp2tNomgA/Vick6qRCz/mb51B7vSMGITf5PvovR9p9A3Zkv6/kQXV2J3ixtnLl/xTIVT/m9a3kySGXb86TX6/oc/IHyYd8Cbiao8KfuhKimtmHI5QAimMyR86UDYHrL4ADk0GZlmLK8Xrxcj1pSQ+SBA0CiFNUenYdtSzRv2Vuymza/kGjnDomgmwNoM/wbP/Xlo5fbDUIsEr+Gx0Osl9KULxXvAR2dmnK7PTGm9foYZhUzrICMOR3bw+BPAIX26XsX6yEAwxVJUkrBwMLWnJYzcEH6BJUZpM9xZq3kt/FQ4oTrRT86FvWL17e+2aVukj9DmjP5HsrNFqVxFevzaK1bgHweYpegCb/D2DHiYQ+Kc/++OHtT599cRJJGMS/OuCU2OlP26Ert528TPR97imPVNIOmULKtX3IjZL7ThhNeJG1BJ/LDbqErBOk+EWqO3jPbXkllurxSZhyYHu8dnsRuy513CZ2BPiBhtjhp/RAI8DvT3KM4wYHazodzHyLgg4PJ+Vkzny/9eAz27DW6ZoQxy1jhSWvzOPHUpHsA51H3q9WBOWnDfqs9U87P6bPESXn61pD5gucG6mEcrA3KOEzPtzBhfELckVwhqVzzHsJEnGddJoP2f7ytEdnclrtQbGcruS70ZjIFfyI2HYN2UPOgAv9912eOHZoMo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6771.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(366004)(39860400002)(396003)(376002)(230922051799003)(230273577357003)(230173577357003)(1800799009)(64100799003)(451199024)(186009)(6916009)(8936002)(4326008)(8676002)(38070700009)(41300700001)(2906002)(52536014)(5660300002)(71200400001)(9686003)(53546011)(122000001)(7696005)(6506007)(83380400001)(38100700002)(76116006)(66946007)(86362001)(316002)(66556008)(26005)(33656002)(66446008)(55016003)(478600001)(64756008)(54906003)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ek1pdWFDbnRSSEluV1NLRE5HM00zbWlkMXpPejVnWWcvdExJYmdaZFQvRFc1?=
 =?utf-8?B?WDgwbWFaVXFuV1I2Y2R5SDRiUC9Cc1NYRjdCbm12VEFhMzM4L1pVUVBMQW9N?=
 =?utf-8?B?V2U4TEp0bVFyV3RiZ1Y5UlpaSzdrK1UxMnlBUFRsYzVlckZESzlhR0xvQmN3?=
 =?utf-8?B?SDZSenBWY0Z6L1dOV0dzS2xZTUc2UGRLbzB4RDZKU0YvUlordGN5MHI0eTYw?=
 =?utf-8?B?RGl0MFcrQ1JlZjBiRmh2a29sQjlVdzRnVEMxS0NEbEZ0YS8zQ1lpQkxkQWla?=
 =?utf-8?B?ZU9ERHVEYVRtMlZYb1NpVWZxUWdRbTFUNW4ycVNyWjlNNWZZNE5JR1YzaFFK?=
 =?utf-8?B?SEN0ZXh0VUNndmo3UXhUU0JhQS9TLzA1b0pvdTlOeFBaU0pxSnJkZXU5UW1z?=
 =?utf-8?B?QXJucEVQUkRuYUx1bTBjNTRMdm9IYkIxa0RQai9ONkU4Z09GV0FsN2ZuMC9T?=
 =?utf-8?B?aU83UW1RaU9kR29QTm1wWVB3NkNUc2ZSc0RPWTJFZzlaZmdGQUlObXZxY29t?=
 =?utf-8?B?aUZkU2gxODNlVENNdlY5bDdGQVFpSU1Pd0RURGQ5cUhTbFFxczBEK3FuMzRH?=
 =?utf-8?B?YTY5dVhacnhtSk9hcC9PVlFIRGV0b2Y0NUxCS2p3MFREbU5VWWk3NnVmWk5C?=
 =?utf-8?B?K0N1RW9sYnVMcnA1bUpKVEo0aXh5K2RrWEt3MW1QSnFndk9vbXJPb0RkNldx?=
 =?utf-8?B?Ny82Y1VOU2IzQ3lkdElzVWpHa05kaGhWRWsyTmRmYTR3Zk1EcG9mYXFxbnZM?=
 =?utf-8?B?elowMC91SmFwNXdraVlUWk1ZM096aWN4MmZyUUVMampaclM0dmpHb2dwaUVQ?=
 =?utf-8?B?YWwybUM0MitZcloyV3U5WC9kQnlQYVIzZU5jUlB1RUxKN0c1VmlzVHMxUFgv?=
 =?utf-8?B?bUpwanZxMCtRbVFtQXVIaU0yMmdJYzMrR21nMElSbHlWbksvV25Xc29zRHMz?=
 =?utf-8?B?cnliUVBpTC9MOGQyclVSTm5oTU9sV3BKWS9FSWtHbGJpVVVYL1JqL29hY2pi?=
 =?utf-8?B?MVFxSWFCWUJPeWIxeTZnMHltR3YyTXozcFhZMTMxUHlqMXhPVkF4RFM1WXVN?=
 =?utf-8?B?VHlKK09HTFdOZlZDaURCQ0xQbkhTZTZYRU5FaUtyUlVJTVZlUm56MXdTZjAx?=
 =?utf-8?B?ZDdaMGh3MGp0VXBzNEFQNFhOcFhWYnh1UjdRKzFUNjFKZkZuRU1uK1dzN05u?=
 =?utf-8?B?MVlocTBrdnNRdURZbzljZ2trcGl0Vmx2c1c2K1l4eDNMQ3JLMjNUOVJjb3Y3?=
 =?utf-8?B?ZFdSc2JxQ0ZuZXBDc3BaaFRFWnl1WGZ0bnYrWS9Ud3RNSFJyMGx0TE1MdmZ4?=
 =?utf-8?B?QkxYMWZOendyN1JWREVNTHgyM2FoYWtWbUlTeWpvRTFCenJjSFNaSENidHFF?=
 =?utf-8?B?dHBPdUh4Zy9pampDTkVZYUVpYjYyVU11M3h1WC9QUm1nWnhwQ2ZHUXMwd1Zn?=
 =?utf-8?B?T2hQalJZdTdKczVrcEFJOVZzd2x3bFZ4RW0yYUJjVWsxckIvc1VwVzhCbmVp?=
 =?utf-8?B?NEZTa0MwNXRFOEZPWjdhL1pTOERURXUyNUdLWEhYU0ErWCs1UENXMjJhaUZu?=
 =?utf-8?B?RFBnMzNnakxmY24veTZOdHVCcXFGMkljc3Fpa2pibUNGeEF3a3BnTDVaS0tF?=
 =?utf-8?B?czJ3Nk9xUU9uTGY1TjluT2dwakMzNU1PZXo2NlNOVlllZ0wrS082UG1jb1Nt?=
 =?utf-8?B?R0xpVFF6dHp3ZURqYkpwRlNZM0Jua3Erd1NiZ3RoN2ZuUTRxYVpzcEdjRjNz?=
 =?utf-8?B?ZnF2YjJCVmdlWTFkS1hvb1dUUktaYnZTMGxEUTFRaUYvSmhoSFljWkpjMXJU?=
 =?utf-8?B?REdpWDhJYWRqcVFNLzg1NTN2U2VpSGhEVGlaMks0SmZNYzJKbFJqMHJ2aTVC?=
 =?utf-8?B?Q0I2NVAvN3ZNbndBSXNDaG5BOVJnVlVCMFF3WnJVZlJGeG9QWHR4RCtBQXRG?=
 =?utf-8?B?MEoxc29JZWFHWW1qSWU1ai9ETFlSdHJBcWd2S0tpVXJnSW5DWE1SbkZsZW5o?=
 =?utf-8?B?SHp4NFpjZVRNSzB3QU9zMUVEZi9Na1huNTM0VC9YOXFRdVZJcE5ITkdpTGVo?=
 =?utf-8?B?S0pNOURhWjl0RTg4Uk9rS0ZpQ0M3ai9kdDRlY09wbFhodnFnOC9XdHk5OE50?=
 =?utf-8?Q?yktqjx04GadRj2m6CrDy7xga2?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB6771.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6969ec9e-b212-4bf2-610f-08dbd6fe2bd0
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2023 15:05:34.7803
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z40x72TO8j4eIgD6+YKS9PKqaFZXrlRScQ7tiyNdx9LaGZLcH/V7JMdusRMPTZ717uRst/5ESiMPMln7ob64iVBmYAHJyGLQasgq6pZ/pmk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB7066
X-Proofpoint-GUID: CS5P4MIji36mViIOwL-AhOqJMqU4Ek3r
X-Proofpoint-ORIG-GUID: CS5P4MIji36mViIOwL-AhOqJMqU4Ek3r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-27_13,2023-10-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 mlxlogscore=999
 impostorscore=0 suspectscore=0 spamscore=0 priorityscore=1501 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2310240000 definitions=main-2310270130
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogR3VlbnRlciBSb2VjayA8
Z3JvZWNrN0BnbWFpbC5jb20+IE9uIEJlaGFsZiBPZiBHdWVudGVyIFJvZWNrDQo+IFNlbnQ6IEZy
aWRheSwgT2N0b2JlciAyNywgMjAyMyA1OjUyIFBNDQo+IFRvOiBNYXR5YXMsIERhbmllbCA8RGFu
aWVsLk1hdHlhc0BhbmFsb2cuY29tPg0KPiBDYzogSmVhbiBEZWx2YXJlIDxqZGVsdmFyZUBzdXNl
LmNvbT47IEpvbmF0aGFuIENvcmJldA0KPiA8Y29yYmV0QGx3bi5uZXQ+OyBsaW51eC1od21vbkB2
Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPiBkb2NAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJu
ZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjUgMi80XSBod21vbjog
bWF4MzE4Mjc6IEFkZCBzdXBwb3J0IGZvcg0KPiBtYXgzMTgyOCBhbmQgbWF4MzE4MjkNCj4gDQo+
IFtFeHRlcm5hbF0NCj4gDQo+IE9uIDEwLzI3LzIzIDA2OjAwLCBNYXR5YXMsIERhbmllbCB3cm90
ZToNCj4gWyAuLi4gXQ0KPiANCj4gPj4gSSBhbHNvIGRvbid0IHVuZGVyc3RhbmQgd2h5IHRoYXQg
d291bGQgYmUgY2hpcCBzcGVjaWZpYy4gSSBkb24ndCBzZWUNCj4gPj4gYW55dGhpbmcgYWxvbmcg
dGhhdCBsaW5lIGluIHRoZSBkYXRhc2hlZXQuDQo+ID4+DQo+ID4+IEFoLCB3YWl0IC4uLiBJIGd1
ZXNzIHRoYXQgaXMgc3VwcG9zZWQgdG8gcmVmbGVjdCB0aGUgY2hpcCBkZWZhdWx0Lg0KPiA+PiBJ
IGRvbid0IHNlZSB3aHkgdGhlIGNoaXAgZGVmYXVsdCBtYWtlcyBhIGRpZmZlcmVuY2UgLSBhIHdl
bGwgZGVmaW5lZA0KPiA+PiBkZWZhdWx0IG11c3QgYmUgc2V0IGVpdGhlciB3YXkuIEFnYWluLCB0
aGVyZSBpcyBubyBndWFyYW50ZWUgdGhhdCB0aGUNCj4gPj4gY2hpcCBpcyBpbiBpdHMgZGVmYXVs
dCBzdGF0ZSB3aGVuIHRoZSBkcml2ZXIgaXMgbG9hZGVkLg0KPiA+DQo+ID4gVGhlIHdlbGwgZGVm
aW5lZCBkZWZhdWx0IHdhcyBzZXQgaW4gdjQsIGJ1dCBJIGRlbGV0ZWQgaXQsIGJlY2F1c2UgdGhl
DQo+IGRlZmF1bHQgdmFsdWUgaW4gaGV4IGZvciBtYXgzMTgyNyBhbmQgbWF4MzE4MjggYWxhcm0g
cG9sYXJpdHksIGFuZA0KPiBtYXgzMTgyNyBmYXVsdCBxdWV1ZSBpcyAweDAuIEkgaGFkIDIgI2Rl
ZmluZXMgZm9yIHRoZXNlIHZhbHVlcywgYnV0IHlvdQ0KPiBzYWlkOg0KPiA+ICIgU2luY2UgTUFY
MzE4MjdfQUxSTV9QT0xfTE9XIGlzIDAsIHRoaXMgY29kZSBkb2Vzbid0IHJlYWxseSBkbw0KPiBh
bnl0aGluZyBhbmQganVzdCBwb2xsdXRlcyB0aGUgY29kZS4iDQo+ID4NCj4gPiBTbywgSSB0aG91
Z2h0IEkgc2hvdWxkIHJlbW92ZSBpdCBhbHRvZ2V0aGVyLCBzaW5jZSByZXMgaXMgc2V0IHRvIDAg
aW4gdGhlDQo+IGJlZ2lubmluZyBhbmQgdGhlIGRlZmF1bHQgdmFsdWUgb2YgdGhlc2UgY2hpcHMg
KGkuZS4gMCkgaXMgaW1wbGljaXRseSBzZXQuDQo+ID4NCj4gPj4NCj4gPj4gQWxzbywgd2h5IGFy
ZSB0aGUgZGVmYXVsdCB2YWx1ZXMgYWRkZWQgaW4gdGhpcyBwYXRjaCBhbmQgbm90IGluIHRoZQ0K
PiA+PiBwcmV2aW91cyBwYXRjaCA/DQo+ID4+DQo+ID4NCj4gPiBJbiB2NCB0aGVzZSBkZWZhdWx0
IHZhbHVlcyB3ZXJlIHNldCBpbiB0aGUgcHJldmlvdXMgcGF0Y2guDQo+ID4NCj4gDQo+IEkgYXNr
ZWQgeW91IChvciBtZWFudCB0byBhc2sgeW91KSB0byBzdG9wIG92ZXJ3cml0aW5nIDAgd2l0aCAw
IGluIGENCj4gdmFyaWFibGUuIEkgZGlkbid0IG1lYW4gdG8gYXNrIHlvdSAoaWYgSSBkaWQpIHRv
IHN0b3Agd3JpdGluZyB0aGUgZGVmYXVsdCB2YWx1ZQ0KPiBpbnRvIHRoZSBjaGlwLiBTb3JyeSBp
ZiBJIGRpZDsgaWYgc28sIHRoYXQgd2FzIGEgbWlzdW5kZXJzdGFuZGluZy4NCj4gDQo+IEd1ZW50
ZXINCg0KV2VsbCwgd3JpdGluZyB0aGUgZGVmYXVsdCB2YWx1ZSBpbnRvIHJlcywgd291bGQganVz
dCBvdmVyd3JpdGUgMCB3aXRoIDAuIFNob3VsZCBJIHN0aWxsIGRvIGl0Pw0KDQpEYW5pZWwNCg0K
