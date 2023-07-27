Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C8077651F2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 13:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233041AbjG0LGD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 07:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232058AbjG0LGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 07:06:01 -0400
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E11B9A3;
        Thu, 27 Jul 2023 04:05:59 -0700 (PDT)
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36R86eOS001100;
        Thu, 27 Jul 2023 07:05:49 -0400
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3s36adnepn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jul 2023 07:05:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RAAhb4UySvwCOApU41IX1rd02XxRvlctkXCBXmHYCnB/XTRPjdfMUd/t0Kp8J6NFZJAhj+ShFAmp+7rpialv/3KoiDK8eEhXo3TbGXK+3YZYwyZA5VajZZ9mRL9pFW7guCQJheSAIRjGON3Y1qF/CFL9bwpDQKA4HVZ3mqwY+OihGMuahY8AoECDk6aK9Tu43rlJDYYZewqWxDRDJIF04XW47laTmr0Qghdh4+cJ6wa9UW5LO1mfTV/aMA7UivGMhHPwJyJtR8+ZIDAU9cNH95WvPEdxzvwp5wAtDxz3cw574ih7qheI/2g2QXXDcnd2wFzXI9oLqgkFNNO/dejHWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yE9b0i6XOh6e9HHCVu4BKqiNEnFiTHgr2qoX+yiz35I=;
 b=eH/mOxwhgUHAo7oycdmEmQV6UdXBf2KjfjNUvOfGBZLmMdvzO7FqyDloBPCggOqvBuFmYC/3pc3EEcRZB1EVH0aK2uHWk2kiccB6+swwKmDqIk7roT3yEGynRiyWnxMlRRQvrzGlZ9GET3XhS3VFWt7EDoljFQ7uVYmOlwCoR3NWmLV8ECgfW5GNK8U0/s60J+KN+snSv+76ODP6ip7pW82ylaMsZTMxO6+39bTS49u7AJXqWb8YXzkVj0IYbS0ZhredwsfMFT/damr+vUmhYwM+Jd75dyCzR6oM+j/18YptEA9jo0oBnJM/xvuM7Gj2K8JB3oUvzx+tPuyTNYHFUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yE9b0i6XOh6e9HHCVu4BKqiNEnFiTHgr2qoX+yiz35I=;
 b=77W/lPlFjIv4+EcJ4klpkjGMmvTQCASa8i7ogVijIzjnFuiWn0udTU+x4ZXSf/1ScQX1DXyjXw9kQcrwVE7SNdH5qrHGrlkL7mhQKLCndAh67045LVvCpzFo045iamITqj7OB3A5eE8+BNeh0hBcUyWPOhj9sn02gsMUMpkIk1M=
Received: from BN6PR03MB3395.namprd03.prod.outlook.com (2603:10b6:405:3f::23)
 by MN2PR03MB5087.namprd03.prod.outlook.com (2603:10b6:208:1ad::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 11:05:46 +0000
Received: from BN6PR03MB3395.namprd03.prod.outlook.com
 ([fe80::728d:be5a:be21:90cf]) by BN6PR03MB3395.namprd03.prod.outlook.com
 ([fe80::728d:be5a:be21:90cf%7]) with mapi id 15.20.6609.032; Thu, 27 Jul 2023
 11:05:46 +0000
From:   "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] dt-bindings:iio:frequency:admv1013: add vcc regs
Thread-Topic: [PATCH 1/2] dt-bindings:iio:frequency:admv1013: add vcc regs
Thread-Index: AQHZwHRo6bK1nc3gOUaMHGqGRSpEZK/Na9uAgAAHVxA=
Date:   Thu, 27 Jul 2023 11:05:46 +0000
Message-ID: <BN6PR03MB33959C45BA5DBCA708AB926D9B01A@BN6PR03MB3395.namprd03.prod.outlook.com>
References: <20230727102309.92479-1-antoniu.miclaus@analog.com>
 <96a82a51-6e26-cee2-c095-98fac749393f@linaro.org>
In-Reply-To: <96a82a51-6e26-cee2-c095-98fac749393f@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jWVcxcFkyeGhkWE5jWVhCd1pHRjBZVnh5YjJGdGFXNW5YREE1WkRnME9X?=
 =?utf-8?B?STJMVE15WkRNdE5HRTBNQzA0TldWbExUWmlPRFJpWVRJNVpUTTFZbHh0YzJk?=
 =?utf-8?B?elhHMXpaeTA0TnpFNVltTTJNaTB5WXpaa0xURXhaV1V0WVdVeVlpMWtORGd4?=
 =?utf-8?B?WkRjMU1EWmtaR1ZjWVcxbExYUmxjM1JjT0RjeE9XSmpOalF0TW1NMlpDMHhN?=
 =?utf-8?B?V1ZsTFdGbE1tSXRaRFE0TVdRM05UQTJaR1JsWW05a2VTNTBlSFFpSUhONlBT?=
 =?utf-8?B?SXlPREE0SWlCMFBTSXhNek16TkRreU9UVTBNelV3TXpneU16TWlJR2c5SW5W?=
 =?utf-8?B?T2NIYzBiVk51VkhOdUwzcFVlRFZ1Y2xwSFpHOTJkbE5PWXowaUlHbGtQU0lp?=
 =?utf-8?B?SUdKc1BTSXdJaUJpYnowaU1TSWdZMms5SW1OQlFVRkJSVkpJVlRGU1UxSlZS?=
 =?utf-8?B?azVEWjFWQlFVVnZRMEZCUVZwUWJsSktaWE5FV2tGbVZVcElaRGxoUzFsUlFU?=
 =?utf-8?B?bFJhMlF6TVc5d2FFRkJSRUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRklRVUZCUVVSaFFWRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGRlFVRlJRVUpCUVVGQmNXVjRNVlpSUVVGQlFVRkJRVUZCUVVGQlFVRkJT?=
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
x-ms-traffictypediagnostic: BN6PR03MB3395:EE_|MN2PR03MB5087:EE_
x-ms-office365-filtering-correlation-id: fcce856f-6a6f-4bea-ae9a-08db8e916d88
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dm3x7cNgKGPkmdzy6e3bXgf+BcJ5cAXwTnPLyrhHa31OjjlSdi8FJSSnSXQU4aq4AQ4dKJo9l5UPhZNV7jZLdkzb7EeehWkuxV0eqRcgpccpA4PjbDpjfMSARRzYFNRUWFZhk9HpSzBFp1lNRBNQB1gu+g0fuXjyxkO1KVvL5imDMuYJoUazjWuw4jQ0uqREolABLjOgB0eWL8ch8Lhpp6b57pmlYlyiXs1P0xpXbYfEgKJDmTjpo2Vzfi4+4A7OK/v6Ey7OnrrOU364KnhOTjGgvGPFMFsYdJYouUZUIVDYztnbviuOt+o0m7sgkjISZyDfaCTWaQT2cdqR8D6Ov8P9haHtm23asQiT5yuv/flJfbtwyuxcSDBdTMljHYc7ZJxLqzD3o6t1mltU3Hs/djnFwFtve78NbWmNeve5yC0IVZ1oqKPLdlthGL+LDP1NSuJ/E/63O+45Op2dMSZGhfEqfC68LuTCyxMXMsD+vF2CRRr1ciIuENO07UqTfWjDORstlAq9BdZU6hHqEjOza2i9YEuKFW3KyxHaMciJFZnN2QUlZq6Ra2mhvHCVysfjPiJX0ldWRwFMkJA5QHjLmA4NDZHX6b9qk5B3BxoD//xvlnUE/zcxmT33ykW6YVRW
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR03MB3395.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(366004)(376002)(39860400002)(136003)(451199021)(41300700001)(2906002)(316002)(52536014)(5660300002)(38070700005)(8676002)(8936002)(33656002)(55016003)(86362001)(9686003)(6506007)(53546011)(26005)(478600001)(7696005)(71200400001)(83380400001)(38100700002)(186003)(66446008)(64756008)(66476007)(66946007)(76116006)(110136005)(122000001)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QTBRU0taQmVrMktnR1gxeUdHVzh1SDhHRUpacUFCZjdoaFdYdEZ1c3AyamJh?=
 =?utf-8?B?U04zUDRuakQ5L25XNG5GbXU5QjlhWkFJVEpod29lWVhqYlNFT21OS01wcGcy?=
 =?utf-8?B?VTRKWi8xTi9Oc0xUYlpqM3ZvUVA3bnc5KzN5czE0eWtQb0J6dS94OWhzYkpE?=
 =?utf-8?B?aWtlOGxMRldMK2I0SER0UlVOU0xheE03UFR4SWRHUlFYcXRTYjE2d0NYampz?=
 =?utf-8?B?VXRLdnozQkRpTnplMmp5bGk3a1ZEeldUTmFXMVowMjlDT1M1RWhuZ0R1Mk83?=
 =?utf-8?B?NFoxeE1jZmFoT29POUY4RjNSNUNJUUErV2owU0I4Ykt3ektUSVRiN0dDeXND?=
 =?utf-8?B?dUt0UkNZSjkwU2pwTmp3aTI2QnhMTnRmK1BqNXJYeSswNVZuV0xRWG12QytG?=
 =?utf-8?B?a3o3QW5SNmpTYjduS3h3MEJ6UHovdmF2WlB3eGV1VWFyazFESmpubzFtU25n?=
 =?utf-8?B?T0JHUDBJSU1QcGxoV3BuZjQvbnErNUtMSC81SG1KUnJ4RVA4N2ZQOVgxZnpj?=
 =?utf-8?B?dWIySHpqbC84K0NscU9GV1pDSXUvY0ZYOW5KZmVOTUFnVWdBZTdjUVhGQm45?=
 =?utf-8?B?Q3JlSnVna1ovckpreG5nQTI3YktjYUdZcEFXNXBwL21aeDlPU2lUZUVjeUVv?=
 =?utf-8?B?QWJEWUk5Qmh4dUxDSUF5OGd1Z3I4S1RSQ3c4Tm95VHVnQmtPa3NySFZpSWNZ?=
 =?utf-8?B?ZXZPVjNnblg1T2NTa3dVZjk3SllHWm5za2lYemtOUHlvYUUwOFBJYjhPR1U0?=
 =?utf-8?B?TGlCc3FtQWtZWnlWV1dYWHpkQm5aRFg4U2VnU0VLbG9EOUtQM0dISVNmMUVN?=
 =?utf-8?B?NHZxK2FwaXJpejExVTJrTnc3Tm05dHJRd3lpRk1YaHZiVjgxODJyUE9aUDB1?=
 =?utf-8?B?MVgvcWNFV2JBanUvUklUODI1U0V5OUdlN1dJNzlqcUJ5VzBkcXAzaGlGSUVF?=
 =?utf-8?B?RVpYSmN6NGdaRm85cXZCUmJCM2lqSlZFNENkM25XbDNsN0Y0RU00aDFjcFhG?=
 =?utf-8?B?eGd1VXNqRkNIdjhkM1lTZjJ5QlgzSVhWVWhjbXZWYTh3bzdJYXF1K0RHMzUr?=
 =?utf-8?B?aGxkMWlOUk9yRG1obWl0cjhERFN4Wk5sTWxIQ1hLVjVxUTQzRWJNV3NuMzU1?=
 =?utf-8?B?SktwelNOeGI5ZDNSbGVHVmJuc01BWUdPeW5SdmZLYlZpT0xkcVp3MDZjUGZE?=
 =?utf-8?B?LzZUVzh5bENCZG5Gc1RkNjQ5bGQ4ajBlRlpyRndTc3JLWmpvZGFxZU9iZFh3?=
 =?utf-8?B?NTA4WmlFVXpVQUhEcVIvR0krcGF6Q2VORHdRdG5nQzdwd3JNVGhRL3RPWmNm?=
 =?utf-8?B?K0R5Tyt5QVJBTUxGdDZzT0FBZmdOQkhHV3B0MENReGY4VVBZTHlRSTRsMUxP?=
 =?utf-8?B?WTdsajdmNjM5N1QzS0ZOQUZXMkxrWWlHN3RkQ3ByY21QUElYZEpTaDdUb0V5?=
 =?utf-8?B?U3lWQ0J1NmRnam9QZDhaTHIxOUE3ckd1U0w3Yk81VUgvSERITzArajd0enQv?=
 =?utf-8?B?ajl5VzFDQnRRMlE5V3ZjZHFzVE94end1OXlMU0x6RlFJam9YY2dnK0puZGd0?=
 =?utf-8?B?WWczZjl6Z2p3TURjdW1lZ0lzZjJ4bDdyNnpVSFhZWXlRSVEveE1uSnp4bDQy?=
 =?utf-8?B?K08zbnBIRFVqSjJ2dXU2WEJzN3NIUDRnU3pSWjJad0JMeU9TV29BeUdKK2Ra?=
 =?utf-8?B?Q1VCMGRDZU13cHltWndrYmNPQUg1QitDbG4yU0cvZHpjbHAxdGI0dGRXZEh6?=
 =?utf-8?B?ckhDT1lOdnRadEVSZFQxcHl6NlRaWEVKeDFJVnl6MXpWeklZa3JVbnB6dVJI?=
 =?utf-8?B?VnY5eGhtVzRFOWx5MlRnOGNOYlZCRzFrNGprNjh2a0tLSWxWU1ZIQTZicS9N?=
 =?utf-8?B?c09mYlQ0ZUMvYmxsY1RWN21idEIzaGJuem0rTHhjRHpBdnNEMW8ySmtDdUZI?=
 =?utf-8?B?SUJYYlgwTkZvL1AvY0ZsN3pjakU5aWsxSUk1TjZJaW5NZ09McWFWeHVQRmk0?=
 =?utf-8?B?MTdqL2VOeUZOZ2N2d2xsMFREVkpQdFpyOE5BMUFpZkl2VCtTNlVkNXFDVzd5?=
 =?utf-8?B?TFNXd0o1M0dXQnU1dVdzU3ovY2JhOGlBdnc5ODF5amFKbVRaWFR2UDdBV2tC?=
 =?utf-8?B?QlVXekdBYTM4dEFlWEhHRjhIUGswRU9za0x6dG1lVWhBS05FZDFySXU2M2lN?=
 =?utf-8?B?RFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR03MB3395.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcce856f-6a6f-4bea-ae9a-08db8e916d88
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2023 11:05:46.1565
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Tb8isc+S3Cqgwo/ut7WZafgMjmtHG7hPC6bl6bQaX2h3siYZj6LFxnKXc7cB5Gn1Sk3gH67r0+EpPuZLCipqnLu+752kZuWMGMF3ZgyZnho=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB5087
X-Proofpoint-GUID: kROM41-j-hULYnJ1ooHMhkpvapeW2fBs
X-Proofpoint-ORIG-GUID: kROM41-j-hULYnJ1ooHMhkpvapeW2fBs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_06,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 clxscore=1011 priorityscore=1501 malwarescore=0 suspectscore=0 bulkscore=0
 impostorscore=0 mlxlogscore=999 spamscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307270099
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLcnp5c3p0b2YgS296bG93c2tp
IDxrcnp5c3p0b2Yua296bG93c2tpQGxpbmFyby5vcmc+DQo+IFNlbnQ6IFRodXJzZGF5LCBKdWx5
IDI3LCAyMDIzIDE6MzggUE0NCj4gVG86IE1pY2xhdXMsIEFudG9uaXUgPEFudG9uaXUuTWljbGF1
c0BhbmFsb2cuY29tPjsgamljMjNAa2VybmVsLm9yZzsNCj4gcm9iaCtkdEBrZXJuZWwub3JnOyBr
cnp5c3p0b2Yua296bG93c2tpK2R0QGxpbmFyby5vcmc7DQo+IGNvbm9yK2R0QGtlcm5lbC5vcmc7
IGxpbnV4LWlpb0B2Z2VyLmtlcm5lbC5vcmc7DQo+IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3Jn
OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMS8y
XSBkdC1iaW5kaW5nczppaW86ZnJlcXVlbmN5OmFkbXYxMDEzOiBhZGQgdmNjIHJlZ3MNCj4gDQo+
IFtFeHRlcm5hbF0NCj4gDQo+IE9uIDI3LzA3LzIwMjMgMTI6MjMsIEFudG9uaXUgTWljbGF1cyB3
cm90ZToNCj4gPiBBZGQgYmluZGluZ3MgZm9yIHRoZSBWQ0MgcmVndWxhdG9ycyBvZiB0aGUgQURN
VjEwMTMgbWljcm93YXJlDQo+ID4gdXBjb252ZXJ0ZXIuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5
OiBBbnRvbml1IE1pY2xhdXMgPGFudG9uaXUubWljbGF1c0BhbmFsb2cuY29tPg0KPiANCj4gU3Vi
amVjdDogbWlzc2luZyBzcGFjZXMgYmV0d2VlbiBwcmVmaXggcGFydHMuDQpJIG1pc3NlZCB0aGlz
IGNvbW1lbnQgaW4gdjIuIEkgd2lsbCBhZGQgYSB2MyBmaXhpbmcgdGhlIGNvbW1pdCBzdWJqZWN0
Lg0KPiANCj4gPiAtLS0NCj4gPiAgLi4uL2JpbmRpbmdzL2lpby9mcmVxdWVuY3kvYWRpLGFkbXYx
MDEzLnlhbWwgIHwgNTANCj4gKysrKysrKysrKysrKysrKysrKw0KPiA+ICAxIGZpbGUgY2hhbmdl
ZCwgNTAgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdA0KPiBhL0RvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9paW8vZnJlcXVlbmN5L2FkaSxhZG12MTAxMy55YW1sDQo+
IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2lpby9mcmVxdWVuY3kvYWRpLGFk
bXYxMDEzLnlhbWwNCj4gPiBpbmRleCBmYzgxM2JjYjY1MzIuLjY2NjAyOTlhYzFhZCAxMDA2NDQN
Cj4gPiAtLS0NCj4gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaWlvL2ZyZXF1
ZW5jeS9hZGksYWRtdjEwMTMueWFtbA0KPiA+ICsrKw0KPiBiL0RvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9paW8vZnJlcXVlbmN5L2FkaSxhZG12MTAxMy55YW1sDQo+ID4gQEAgLTM5
LDYgKzM5LDQ2IEBAIHByb3BlcnRpZXM6DQo+ID4gICAgICBkZXNjcmlwdGlvbjoNCj4gPiAgICAg
ICAgQW5hbG9nIHZvbHRhZ2UgcmVndWxhdG9yLg0KPiA+DQo+ID4gKyAgdmNjLWRydi1zdXBwbHk6
DQo+ID4gKyAgICBkZXNjcmlwdGlvbjoNCj4gPiArICAgICAgUkYgRHJpdmVyIHZvbHRhZ2UgcmVn
dWxhdG9yLg0KPiA+ICsNCj4gPiArICB2Y2MyLWRydi1zdXBwbHk6DQo+ID4gKyAgICBkZXNjcmlw
dGlvbjoNCj4gPiArICAgICAgUkYgcHJlZHJpdmVyIHZvbHRhZ2UgcmVndWxhdG9yLg0KPiA+ICsN
Cj4gPiArICB2Y2MtdnZhLXN1cHBseToNCj4gPiArICAgIGRlc2NyaXB0aW9uOg0KPiA+ICsgICAg
ICBWVkEgQ29udHJvbCBDaXJjdWl0IHZvbHRhZ2UgcmVndWxhdG9yLg0KPiA+ICsNCj4gPiArICB2
Y2MtYW1wMS1zdXBwbHk6DQo+ID4gKyAgICBkZXNjcmlwdGlvbjoNCj4gPiArICAgICAgUkYgQW1w
bGlmaWVyIDEgdm9sdGFnZSByZWd1bGF0b3IuDQo+ID4gKw0KPiA+ICsgIHZjYy1hbXAyLXN1cHBs
eToNCj4gPiArICAgIGRlc2NyaXB0aW9uOg0KPiA+ICsgICAgICBSRiBBbXBsaWZpZXIgMiB2b2x0
YWdlIHJlZ3VsYXRvci4NCj4gPiArDQo+ID4gKyAgdmNjLWVudi1zdXBwbHk6DQo+ID4gKyAgICBk
ZXNjcmlwdGlvbjoNCj4gPiArICAgICAgRW52ZWxvcGUgRGV0ZWN0b3Igdm9sdGFnZSByZWd1bGF0
b3IuDQo+ID4gKw0KPiA+ICsgIHZjYy1iZy1zdXBwbHk6DQo+ID4gKyAgICBkZXNjcmlwdGlvbjoN
Cj4gPiArICAgICAgTWl4ZXIgQ2hpcCBCYW5kIEdhcCBDaXJjdWl0IHZvbHRhZ2UgcmVndWxhdG9y
Lg0KPiA+ICsNCj4gPiArICB2Y2MtYmcyLXN1cHBseToNCj4gPiArICAgIGRlc2NyaXB0aW9uOg0K
PiA+ICsgICAgICBWR0EgQ2hpcCBCYW5kIEdhcCBDaXJjdWl0IHZvbHRhZ2UgcmVndWxhdG9yLg0K
PiA+ICsNCj4gPiArICB2Y2MtbWl4ZXItc3VwcGx5Og0KPiA+ICsgICAgZGVzY3JpcHRpb246DQo+
ID4gKyAgICAgIE1peGVyIHZvbHRhZ2UgcmVndWxhdG9yLg0KPiA+ICsNCj4gPiArICB2Y2MtcXVh
ZC1zdXBwbHk6DQo+ID4gKyAgICBkZXNjcmlwdGlvbjoNCj4gPiArICAgICAgUXVhZHJ1cHBsZXIg
dm9sdGFnZSByZWd1bGF0b3IuDQo+ID4gKw0KPiANCj4gWW91IG1hZGUgdGhlbSByZXF1aXJlZCBp
biB0aGUgZHJpdmVyLCBzbyB0aGV5IHNob3VsZCBiZSByZXF1aXJlZCBoZXJlIGFzDQo+IHdlbGwu
IFRoZXkgc2hvdWxkIGJlIHJlcXVpcmVkIGFueXdheSwgYmVjYXVzZSBBRkFJVSB0aGV5IGhhdmUg
dG8gYmUNCj4gcHJvdmlkZWQuDQo+IA0KPiBPVE9ILCB0aGlzIHdpbGwgYnJlYWsgdGhlIEFCSSwg
c28geW91ciBkcml2ZXIgbWlnaHQgbmVlZCB0byB0YWtlIHRoZW0gYXMNCj4gb3B0aW9uYWwuDQo+
IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0KDQo=
