Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CAD07DD4D1
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 18:42:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346905AbjJaRme (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 13:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231249AbjJaRmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 13:42:32 -0400
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 879AB91;
        Tue, 31 Oct 2023 10:42:30 -0700 (PDT)
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 39VHSe92018446;
        Tue, 31 Oct 2023 13:42:08 -0400
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3u360y06y0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Oct 2023 13:42:07 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LO8fAN9WZikJdSXF1vWr3ef8eSwUvi/3Ir3D3rQDU85nHJWqCyYiuZqQZZfAL1GQ7zcXb6cxseykQHgwTy5PWcudK7bCmGyRDo65Vd+2KoxRyR8DVVVqcnR4PfOAFaM/KdJTpAfNImh8yZ99X17zVa1nAdlx7BlwMk3uZsTeFyKMN5VvnWuELu47cfbW6oHi4xjzxsjm5t+TRuR6g9biReMBEJqhuhRk1+nuqekwTf72rAZfgzc2fc+qrtomYDpplK9oVwrKU05FI4fcj02YpU1y+G2eaFwSEZXm2ubY2uZM+SZd4ZqZAo01lW3GVsBStTawCcYY1uWZk5oltbHR8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=py40f1bnBzFs4HKfdfBmgSZylRP3s0cKeGprwkpshu8=;
 b=fKQipKM7DjlFuappgEMeLDOOGIn9+0+UwnrcRjgzYWa1hvGrna1A5GsJ+wDKCDrsRCIdWPbcysEjleIoO7rjZ1qyO8WKGEcLOY+nDhU2lIBF92OwdT/85rl9J6lzbjiPzqu5B/S82AtSsLFKb2fkuwxrSsT1Zs2CpbjycZaypNQNMGhhjXKfWpxKfXECeSZuj0nFRWnVe/5eeL7FL1d1Ssgm0973OGS9e2AfepxzLrH6+NLL3q1GhKN8OcaIhd0OWOWV0ntyh7eMGBvNJVAySUSSjwlT+Qijdfs7IZWudPoAuibXW4ko5u0oooV8q5oqic10WJSpoZe5BTdvM4Ubsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=py40f1bnBzFs4HKfdfBmgSZylRP3s0cKeGprwkpshu8=;
 b=YWzL3bENTEr5Xi5LtDwMlnOn4RhnwILqr2c6K7ksfs6/6e+Bgn8OXLTjj7rs+CVwfrUC3+XSQNkQ6b6UkMBdpIpbNKmAQ37SHFNWKfkx+3iJRrlb/umPjFu5A0SEoTYjJx/HeQJcl9X5lJruaFUkjqPUwqhGLB47DExLYYrzHe4=
Received: from CY4PR03MB3399.namprd03.prod.outlook.com (2603:10b6:910:57::13)
 by DM6PR03MB5082.namprd03.prod.outlook.com (2603:10b6:5:1ee::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Tue, 31 Oct
 2023 16:28:08 +0000
Received: from CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::26c3:a563:9b0a:3321]) by CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::26c3:a563:9b0a:3321%3]) with mapi id 15.20.6954.014; Tue, 31 Oct 2023
 16:28:07 +0000
From:   "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>
Subject: RE: [PATCH v3 2/2] rtc: max31335: add driver support
Thread-Topic: [PATCH v3 2/2] rtc: max31335: add driver support
Thread-Index: AQHaDA9c3G+ASfoC90CsVtZgJtJaCLBkDtYAgAABduA=
Date:   Tue, 31 Oct 2023 16:28:07 +0000
Message-ID: <CY4PR03MB3399DEF73E052036AC7EDBA99BA0A@CY4PR03MB3399.namprd03.prod.outlook.com>
References: <20231031153100.92939-1-antoniu.miclaus@analog.com>
 <20231031153100.92939-2-antoniu.miclaus@analog.com>
 <95e41f16-4b5f-4f2a-bc31-17273032312b@roeck-us.net>
In-Reply-To: <95e41f16-4b5f-4f2a-bc31-17273032312b@roeck-us.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jWVcxcFkyeGhkWE5jWVhCd1pHRjBZVnh5YjJGdGFXNW5YREE1WkRnME9X?=
 =?utf-8?B?STJMVE15WkRNdE5HRTBNQzA0TldWbExUWmlPRFJpWVRJNVpUTTFZbHh0YzJk?=
 =?utf-8?B?elhHMXpaeTAzTnpZeU9XTmpaUzAzT0RCaExURXhaV1V0WVdVM09DMWtORGd4?=
 =?utf-8?B?WkRjMU1EWmtaR1ZjWVcxbExYUmxjM1JjTnpjMk1qbGpZMll0Tnpnd1lTMHhN?=
 =?utf-8?B?V1ZsTFdGbE56Z3RaRFE0TVdRM05UQTJaR1JsWW05a2VTNTBlSFFpSUhONlBT?=
 =?utf-8?B?SXpNakE0SWlCMFBTSXhNek0wTXpJME16STROVGN3TURJd05qQWlJR2c5SW1W?=
 =?utf-8?B?a0szRmFZblJHUlVZclZHaE9iRFpCTTFsYUswSkJZa0pVVVQwaUlHbGtQU0lp?=
 =?utf-8?B?SUdKc1BTSXdJaUJpYnowaU1TSWdZMms5SW1OQlFVRkJSVkpJVlRGU1UxSlZS?=
 =?utf-8?B?azVEWjFWQlFVVnZRMEZCUWsxTlVGVTFSbmQ2WVVGVWVtVlljMUZFVTBSSlFs?=
 =?utf-8?B?Qk9OV1Y0UVU1SlRXZEZSRUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
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
x-ms-traffictypediagnostic: CY4PR03MB3399:EE_|DM6PR03MB5082:EE_
x-ms-office365-filtering-correlation-id: e132fa7b-1bcf-4134-bd37-08dbda2e5db8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MY1lW0Bj0RADHfsgj07MfA+DIHD3wig32/3WTstCve+IR87Ao6ZjWeMtGgZyXqc2u3Bl1aqlQXdBfZo8qmojdONdViIqYi8bHYzOGXPyh75asa3mDMQX48ZCGWDWIKlq1mFQTDu+/JrYiXJSfcuGUViftZeKzyXgVDRVZawZOeSxrC4/XEnv9GNhohb03aEyUFWwVcyVNmAGSYqRlJerAO+QGYqgJoeYj3oZTy0AgM6XyJCkp0GcY1NZ0rqtrH2Dj/I4K93eb1NYyXDdbqm9mw3kB/qMkKgGamg+BhOTk3brPh31AV/hi4aUUdjp8i/FVV84KXwOJAAporNUyDduZGXDPFkq9P9aYhdBQXNsUyy4xN3Wuk4I4rkvY3wNkrfF5UgFrFM6sfhybHMiMRvyNI5asAfmAFXg5CF5ibpyuaio4hIv1pFM/ezdUDREK9iAAkz2ACZ5FDDicnTh9PWZ7y/S4dgS04zvNRXj/0qe/1X9nEblsc+ncw51kHMbFvArid+m1QV+PLvvvQuv2QeacXGN0qOg7A04Cgj99I12XgrfCOPMWARkVmV/08c8mLB0EerS8mmdZ9p166fqA703McC274RDxAemEUEnNKwcTJeekrIFUnCkkG8M97JevCt2aGtImYwQeCJaPVtIB98TVQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR03MB3399.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(39860400002)(396003)(136003)(346002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(38070700009)(33656002)(921008)(55016003)(41300700001)(478600001)(7416002)(5660300002)(52536014)(83380400001)(7696005)(2906002)(66946007)(76116006)(110136005)(66556008)(8936002)(53546011)(8676002)(26005)(64756008)(66446008)(66476007)(316002)(86362001)(71200400001)(38100700002)(9686003)(6506007)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cFBKK2s5OTlVTDlSN1crV25XZ1dvdGkwTU5sRjdoUDY2RGxFaVU1NXozMllP?=
 =?utf-8?B?U2J5RVJ2YmtkMVdySHBHSm9wcWxtZVNHbDF2RHVwbCtNelJoUjg3MjdQUFhr?=
 =?utf-8?B?emZJVFMzbkg2TDMyUWhhbDVTbVp6Qm1CNHMrWTd1dDR0aWJOQjM2U0c0bTVl?=
 =?utf-8?B?cEZVL1VPWjRsSmFLMVgxeVFISnNVbzRldGpLK0NlOEJiVEdPYVdHRS84Q0th?=
 =?utf-8?B?MDFRMk1WeWNMcVYwSXVrNEh3QVNZNjlvQlNncjdEMk80eUdRTUxrOFNEN0pY?=
 =?utf-8?B?SVVzUVZkQmRqK2tYRWFGeVJ3Qk9JNXY2QjVBY3pDWHNUOWpGUUtKZHg2REov?=
 =?utf-8?B?WUQyTlJBdy9jaElIbVd5djY5R041MTBLeXdsc3dQek1SemVpaTJveG11Vk9L?=
 =?utf-8?B?eUtvNFMzcjA5S1lHdXFsL21qWWZjYVdRTktVQllHS0VDRVRlSTN0NmNtZ0FQ?=
 =?utf-8?B?TVNiVXo5bTQ4UURjcXQrazgwbEYxOFRScE5acWc0cVZqTEhlYnAxNkVRYzlt?=
 =?utf-8?B?aGp4eUM3QXJoaUlpdEJWMXA4R0d2clJMdWZpYS9HSGdJTUZFRVpiMWx1cUd3?=
 =?utf-8?B?MkwrK0JzTzBSaVo4dEI0dU9kZW9QNU1pcjBYTjU0ekVDL004cFdJQzVXOVMx?=
 =?utf-8?B?c2EvTitpVjEzOGtCdEp0Yit5WVg4ZkhKSERsUG92Q0U5WGZZVUhmZUFhV3NX?=
 =?utf-8?B?OElzTDJNcEdxRnNJY1lUTUZqNkpua2M4MHdKandNSnEyTm9wS2tjeVFKYkE3?=
 =?utf-8?B?N08xekRCaU1RajB6bUkyQzU0MWRCY1F6V3NCOUlCcXR3SmdaV0huNk10eUtW?=
 =?utf-8?B?SlRnbXFFSnlZK1g3SC9jaG9RZlppMzVtVS90MDZ6QllhSFMzek1QdXh0NHQx?=
 =?utf-8?B?bVRpSVBCOTh1OFNDK0NtckJpL3h5dTFXSFVFdG9QdjV0T25YamcvZmhIUVVG?=
 =?utf-8?B?NHFrMXB1cGRnMmJwK1oyRTZ5dVBSaVBMUUVSanltQ3ZMOEI4STQybU1EeU9Z?=
 =?utf-8?B?YjdwWnZhclFJRjBzVnNzNXBUYnpBWnVzS2xxaVFETGNpV3BMdkttUHE0QThl?=
 =?utf-8?B?WEJPRkVCSGVWUEdlMk0vQUJNN3hZUW53blhBQ0E4ZDVNWDUxaFhUaVo0dE9G?=
 =?utf-8?B?bWZ5Um80U1ZNMXZNS1dEaVY0dnNtMnBhd2UxWGxtQWxkUEJDUDdQV3h5OHo0?=
 =?utf-8?B?dWpHK2ZrZ1BsRERDRElxWWpSWDJ2MllUOTBaa0c2YjJWckRZR2paUndRUEQx?=
 =?utf-8?B?OEszQW9tVnh4RjllVmxKZG9obmR3enZBcUxYcE9xc0NYU3RPVlJEeFlQeFdz?=
 =?utf-8?B?K3luekpiajNvZUx5RXA4SDByRkFJL1dxQlJ2YjNob2RGYXkvNC92dlpWTWEw?=
 =?utf-8?B?aUxmV1U4UDJ4RXBWcnJxTmVtUEFEdmNraTNGUlVObzJKaEJBcmp1MFBYaEpr?=
 =?utf-8?B?NTN3RitYdkw5VzlLYytna3Q1VGkxT1lLWnVnL2VDSFNoNGI4eE1HTEFGZmh1?=
 =?utf-8?B?Q1crVDRGWlhROXZxTHVTeUlSaW9Cd0JDS0ZaNGxtdUdRTnVnQ2NRaUcxc1dQ?=
 =?utf-8?B?VDFTQktEMUkrVnM3NDN5NUVlWUkyWHFaQmhBMWFWaVQ2T0FxSm9OeG5yVDBm?=
 =?utf-8?B?TUoxYVJ2NlpkbUVCcXloREhYVlZyZXRwL25rVi9BSjkxTkNZRHE5S21ydERq?=
 =?utf-8?B?QkIzSGZaN1VHZVRSemlBQWtEZjVCeUJya1JoRi9hZVFyWXY3eDRHMXJTdEhr?=
 =?utf-8?B?dkJhZEt1K2RqM29sT0dGM3BWdUlHcksva2lhdzhjN1prejh1Z09UbkludktC?=
 =?utf-8?B?bXk0MTd6WnJtdnM5Q1RlRzNjbkRPZFFQL21NYzJCVHp4MkZtZlNNN2dBd1NY?=
 =?utf-8?B?RTZ5end6UTlLSjhyb2ZQOFY2WFlIc3g3MVBDK3BoMXV4OVduQ2tDTmU1SHZm?=
 =?utf-8?B?L09GRzZDempad05iSzBKM3I0QnZkVVhmRVF1SU9NOW9EcENLOWpWSWZkRUcr?=
 =?utf-8?B?NkhqRG1WUFBTbTVHR0tOV0lWbWg0alkzVExUMVRNRVNVUjdUNVpxTm9GNVps?=
 =?utf-8?B?M2YvR09CRWllY1J6bXoxeDdWd2ZTNloyNTlwOXlHT2JlSmJEQitQRHpGQWlt?=
 =?utf-8?B?TUNQdUU5OXF4MkhVTzlnSHo5dFgrdmFQRTF3SW1td1QzQjkyTlc1Q0E4ek5S?=
 =?utf-8?B?Tnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR03MB3399.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e132fa7b-1bcf-4134-bd37-08dbda2e5db8
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2023 16:28:07.8563
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZqNDbfv+2O9VA5q/Pfx3pwDEvFszk0rAlWg7IWC6q8kp4yw3IpDSqGZl9qBbhCv3bJ42HAT4LDyrYcJlskOS9VQfxUGrM/0JcnwvyL6Ocgc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5082
X-Proofpoint-ORIG-GUID: 7s947X3vUtoSYdSGBfpoVuXh3l7EcEH4
X-Proofpoint-GUID: 7s947X3vUtoSYdSGBfpoVuXh3l7EcEH4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-31_04,2023-10-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 malwarescore=0 mlxscore=0 bulkscore=0
 phishscore=0 spamscore=0 mlxlogscore=999 impostorscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2310240000 definitions=main-2310310141
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiAxMC8zMS8yMyAwODozMCwgQW50b25pdSBNaWNsYXVzIHdyb3RlOg0KPiA+IFJUQyBkcml2
ZXIgZm9yIE1BWDMxMzM1IMKxMnBwbSBBdXRvbW90aXZlIFJlYWwtVGltZSBDbG9jayB3aXRoDQo+
ID4gSW50ZWdyYXRlZCBNRU1TIFJlc29uYXRvci4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEFu
dG9uaXUgTWljbGF1cyA8YW50b25pdS5taWNsYXVzQGFuYWxvZy5jb20+DQo+ID4gLS0tDQo+ID4g
Y2hhbmdlcyBpbiB2MzoNCj4gPiAgIC0gZHJvcCBNQVgzMTMzNV9TVEFUVVMxIHJlZ2lzdGVyIGNo
ZWNrIGluc2lkZSBwcm9iZSBmdW5jdGlvbi4NCj4gPiAgIGRyaXZlcnMvcnRjL0tjb25maWcgICAg
ICAgIHwgIDExICsNCj4gPiAgIGRyaXZlcnMvcnRjL01ha2VmaWxlICAgICAgIHwgICAxICsNCj4g
PiAgIGRyaXZlcnMvcnRjL3J0Yy1tYXgzMTMzNS5jIHwgNzY1DQo+ICsrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysNCj4gPiAgIDMgZmlsZXMgY2hhbmdlZCwgNzc3IGluc2VydGlv
bnMoKykNCj4gPiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL3J0Yy9ydGMtbWF4MzEzMzUu
Yw0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcnRjL0tjb25maWcgYi9kcml2ZXJzL3J0
Yy9LY29uZmlnDQo+ID4gaW5kZXggZDc1MDI0MzNjNzhhLi4xMWM3ZDdmZTFlODUgMTAwNjQ0DQo+
ID4gLS0tIGEvZHJpdmVycy9ydGMvS2NvbmZpZw0KPiA+ICsrKyBiL2RyaXZlcnMvcnRjL0tjb25m
aWcNCj4gPiBAQCAtMzczLDYgKzM3MywxNyBAQCBjb25maWcgUlRDX0RSVl9NQVg4OTk3DQo+ID4g
ICAJICBUaGlzIGRyaXZlciBjYW4gYWxzbyBiZSBidWlsdCBhcyBhIG1vZHVsZS4gSWYgc28sIHRo
ZSBtb2R1bGUNCj4gPiAgIAkgIHdpbGwgYmUgY2FsbGVkIHJ0Yy1tYXg4OTk3Lg0KPiA+DQo+ID4g
K2NvbmZpZyBSVENfRFJWX01BWDMxMzM1DQo+ID4gKwl0cmlzdGF0ZSAiQW5hbG9nIERldmljZXMg
TUFYMzEzMzUiDQo+ID4gKwlkZXBlbmRzIG9uIEkyQw0KPiA+ICsJc2VsZWN0IFJFR01BUF9JMkMN
Cj4gPiArCWhlbHANCj4gPiArCSAgSWYgeW91IHNheSB5ZXMgaGVyZSB5b3UgZ2V0IHN1cHBvcnQg
Zm9yIHRoZSBBbmFsb2cgRGV2aWNlcw0KPiA+ICsJICBNQVgzMTMzNS4NCj4gPiArDQo+ID4gKwkg
IFRoaXMgZHJpdmVyIGNhbiBhbHNvIGJlIGJ1aWx0IGFzIGEgbW9kdWxlLiBJZiBzbywgdGhlIG1v
ZHVsZQ0KPiA+ICsJICB3aWxsIGJlIGNhbGxlZCBydGMtbWF4MzEzMzUuDQo+ID4gKw0KPiANCj4g
SnVzdCBvdXQgb2YgY3VyaW9zaXR5LCBpcyB0aGlzIGFuIHVucmVsZWFzZWQgY2hpcCA/IEkgb25s
eSBmaW5kDQo+IE1BWDMxMTMzMSBhbmQgTUFYMzEzMzQgb24gdGhlIEFuYWxvZyB3ZWJzaXRlLCBi
dXQgdGhlIHJlZ2lzdGVyDQo+IG1hcCBmb3IgdGhvc2UgaXMgZGlmZmVyZW50LCBhbmQgdGhleSBk
b24ndCBzdXBwb3J0IHJlcG9ydGluZw0KPiB0aGUgY2hpcCB0ZW1wZXJhdHVyZS4NCj4gDQo+IFsg
Li4uIF0NCj4gDQo+ID4gKw0KPiA+ICtzdGF0aWMgY29uc3Qgc3RydWN0IGh3bW9uX2NoYW5uZWxf
aW5mbyAqbWF4MzEzMzVfaW5mb1tdID0gew0KPiA+ICsJSFdNT05fQ0hBTk5FTF9JTkZPKHRlbXAs
IEhXTU9OX1RfSU5QVVQpLA0KPiANCj4gQWNjb3JkaW5nIHRvIHRoZSByZWdpc3RlciBtYXAgYWJv
dmUsIHRoZSBjaGlwIGRvZXMgc3VwcG9ydA0KPiBsb3cgYW5kIGhpZ2ggdGVtcGVyYXR1cmUgbGlt
aXRzIGFzIHdlbGwgYXMgb3Zlci0gYW5kIHVuZGVydGVtcGVyYXR1cmUNCj4gYWxhcm1zIGFuZCBp
bnRlcnJ1cHRzLiBJIHdvdWxkIHN1Z2dlc3QgdG8gYWRkIHN1cHBvcnQgZm9yIGFsbCBvZiB0aG9z
ZS4NCj4gWW91IG1pZ2h0IGFsc28gY29uc2lkZXIgYWRkaW5nIHN1cHBvcnQgZm9yIHRlbXBlcmF0
dXJlIGFsYXJtIGludGVycnVwdHMNCj4gYW5kIHJlcG9ydCB0ZW1wZXJhdHVyZSBhbGFybSBldmVu
dHMgYnkgY2FsbGluZyBod21vbl9ub3RpZnlfZXZlbnQoKQ0KPiBpZiBhIHRoZXJtYWwgZXZlbnQg
b2NjdXJzLg0KDQpJJ3ZlIHNlbnQgaW4gdGhlIGZpcnN0IHZlcnNpb24gb2YgdGhpcyBwYXRjaCBz
ZXJpZXMgYSBjb3ZlciBsZXR0ZXI6DQoNCiJBbHRob3VnaCB0aGUgZGF0YXNoZWV0IGlzIG5vdCBw
dWJsaWMgeWV0LCB0aGUgZHJpdmVyIGNhbiBiZSBtYWRlIHB1YmxpYyAob24NCm90aGVyIGxpbnV4
IGN1c3RvbSB0cmVlcyBpdCBpcyBhbHJlYWR5KS4NCg0KVGhlIGRyaXZlciB3YXMgdGVzdGVkIHdp
dGggYWN0dWFsIGhhcmR3YXJlIGFuZCB3b3Jrcy4NCg0KRXZlbiB0aG91Z2ggdGhlIGRhdGFzaGVl
dCBpcyBub3QgYXZhaWxhYmxlLCBpZiB0aGVyZSBhcmUgYW55IHF1ZXJpZXMgYWJvdXQNCnRoZSBm
dW5jdGlvbmFsaXR5IG9mIHRoZSBwYXJ0LCB0aGVzZSBjYW4gYmUgcHJvdmlkZWQvaW5zZXJ0ZWQg
YXMgY29kZSBjb21tZW50cw0KaW5zaWRlIHRoZSBkcml2ZXIuIg0KDQpUaGUgcmVhc29uIHdoeSBJ
IGFtIHJ1c2hpbmcgdGhpcyBhIGJpdCBpcyBiZWNhdXNlIHRoZSBjdXN0b21lciB0aGF0IHVzZXMg
dGhlDQpkcml2ZXIgd2FudHMgdGhlIGRyaXZlciByZWxlYXNlZCBhbmQgbWFpbmxpbmUga2VybmVs
IGNvbXBsaWFudC4NCg0KVGhpcyBpcyBhbiBpbml0aWFsIHZlcnNpb24gb2YgdGhlIGRyaXZlciBj
b3ZlcmluZyB0aGUgbWFpbiB1c2UgY2FzZXMgKHdoaWNoIHdlcmUNCnJlcXVlc3RlZCwgdGhlcmVm
b3JlIGFjdHVhbGx5IHVzZWQpLg0KDQpBZGRpdGlvbmFsIGZlYXR1cmVzIGNhbiBiZSBhZGRlZCBh
ZnRlcndhcmRzLCBpZiByZXF1ZXN0ZWQuDQoNCj4gDQo+ID4gKw0KPiA+ICsJaHdtb24gPSBkZXZt
X2h3bW9uX2RldmljZV9yZWdpc3Rlcl93aXRoX2luZm8oJmNsaWVudC0+ZGV2LA0KPiBjbGllbnQt
Pm5hbWUsDQo+ID4gKwkJCQkJCSAgICAgbWF4MzEzMzUsDQo+ID4gKwkJCQkJCSAgICAgJm1heDMx
MzM1X2NoaXBfaW5mbywNCj4gPiArCQkJCQkJICAgICBOVUxMKTsNCj4gDQo+IFRoZXJlIGlzIG5v
ICJkZXBlbmRzIG9uIEhXTU9OIiBpbiB0aGUgS2NvbmZpZyBlbnRyeSwgbWVhbmluZyB0aGlzIHdp
bGwgZmFpbA0KPiB0byBjb21waWxlIGlmIEhXTU9OPW4gb3IgaWYgSFdNT049bSBhbmQgUlRDX0RS
Vl9NQVgzMTMzNT15Lg0KPg0KDQpXaWxsIGRvIGluIHY0Lg0KDQo+IEd1ZW50ZXINCg==
