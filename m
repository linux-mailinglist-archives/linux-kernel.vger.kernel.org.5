Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C886E7E52AA
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 10:30:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235589AbjKHJav (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 04:30:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235554AbjKHJas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 04:30:48 -0500
Received: from mx0b-002bf204.pphosted.com (mx0b-002bf204.pphosted.com [205.220.172.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B88C92;
        Wed,  8 Nov 2023 01:30:44 -0800 (PST)
Received: from pps.filterd (m0207525.ppops.net [127.0.0.1])
        by mx0a-002bf204.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3A84Iql5027929;
        Wed, 8 Nov 2023 01:30:25 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        monolithicpower.com; h=from:to:cc:subject:date:message-id
        :references:in-reply-to:content-type:content-transfer-encoding
        :mime-version; s=pps1; bh=TwkqQxbuw4UQdRDiXBESUfIDSR+K6Z6KvhLrjR
        KCER4=; b=lAksTrRlkuxQKu4CBwqiiHhrPymCtYVJUvGuVyeUMU9p+xzTEhkTSW
        EB+d/QQLEu0hJqSzcQshggFZ07gDy7LjI7k0EDvl5v9wIfK0i3rpTad4ylZHcELS
        G4AdRLlQJyUZei9vuO253tj79Ija7F4E2cw/N+VaoUT1J+nOBAB1soglU1Lv9+qe
        8i933pJQVtZfyJ/07o4JIGwh9YHiBZ7V82Jjyw0zvQ3divLnqR+0H0KskzrGEWoI
        Wvs0064OHaX2PeuR6RkTsykAcArzWmCVJcVA1rZmPCTpf7LHuG7N61P9vdjGkT1J
        KMAmipxv89KNl7D9Gkvs7DCrfEdJeUHg==
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by mx0a-002bf204.pphosted.com (PPS) with ESMTPS id 3u7w5drw06-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Nov 2023 01:30:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A8diQJqplDszTkTUiiH/8VFnNgyVnKgp3k09bu28CPAS7dK5xeH89GnKM+PzeMMluT3ep/0BY/lKjg5KaF7y28BhhdIysyKk0Ke3efMFeuSSsfj13Y/EDABVYGBXNJw2KDQEugpkZMGnMbIK6PBxr1wQh0lvXhJUQwUaVptRKh/iHCaxcxyy3bQl1wXQUymopIU1bZ94G9e5QrWs3PD5/umQ/cUgtlke+JJmJbidOKdXb3rCfqioBDp+JjBvp0ueJ/EEtsA6dcth+9IS/0EIJZ5XC0FDJhk9cGMKEgh9gG85ikbOwO45BEO1XoTi4bdwX+tU4IguftBeseTyf2ZIpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TwkqQxbuw4UQdRDiXBESUfIDSR+K6Z6KvhLrjRKCER4=;
 b=W7ZSPZYfnfkGKNnrS/188uFI6HL7xWuvi/+rtZ2yDX5WiBdtY83dJh7pPSV0FRQVhuaphfL2PqdxUU/IrjbIwwvVv8igL1AJ9nuKoeBqWc9UYRvMHIw1dD8Fn2hSJssGM/WHuM57Y5uTwsnfy9v8bL6AhETtLpNY5XkbGUkHVUFu4rHYwrUrwB/T1hESqGrlg19nR8KAt+U3b6cwW1n2Kh6LYUuBq05iq92dbuweiwPdAEMIPGXvtY8nlGnwnDwns2NgI7WBT/Doc/wgJABa51oyA1zRW+AgvdVE8PRZfvBHQe/Ohn1b2QbMbEJx3xcqD0lKzF+GSGTRThG9Jzx5ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=monolithicpower.com; dmarc=pass action=none
 header.from=monolithicpower.com; dkim=pass header.d=monolithicpower.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monolithicpower.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TwkqQxbuw4UQdRDiXBESUfIDSR+K6Z6KvhLrjRKCER4=;
 b=gRIW+LNX/a7cdTDJtV70ZjtAaEXDZs6EhlyvKeX/7gOlA2ReJcS/zB5KDBV9zd+MFC3zQvPs589F7iEv5RYyPRWcNqWPWplfAYqCLM+zLBt4O5bRH4JPH6Q1f4+nnmiseq/k4ilzEubUxZ6GGRVpVRJKEhqOnPpCXZsdhEtfvhL6Pc4v8DeSRUaisyT8AFdSqcJ8PPJKzGchsaFTaP2hTi8Sz9ItB1Z9bH/oDw+a+palBLBlRvkbhADjQCa8QUpW4EpbfOt0xmPh2BR6jq3bGPw6eYImhPYX1bR9JLpqFm650vtdL7AhD3VjUUmNUieUgAj/vjqRHzaPkxu+TwYLOQ==
Received: from BY5PR13MB4487.namprd13.prod.outlook.com (2603:10b6:a03:1d4::20)
 by SN4PR13MB5696.namprd13.prod.outlook.com (2603:10b6:806:1ef::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.27; Wed, 8 Nov
 2023 09:30:20 +0000
Received: from BY5PR13MB4487.namprd13.prod.outlook.com
 ([fe80::9a0d:a0c8:2e78:2521]) by BY5PR13MB4487.namprd13.prod.outlook.com
 ([fe80::9a0d:a0c8:2e78:2521%4]) with mapi id 15.20.6954.029; Wed, 8 Nov 2023
 09:30:19 +0000
From:   "Yuxi (Yuxi) Wang" <Yuxi.Wang@monolithicpower.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Yuxi Wang <wyx137120466@gmail.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "lee@kernel.org" <lee@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>
CC:     "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Yuxi (Yuxi) Wang" <Yuxi.Wang@monolithicpower.com>
Subject: RE: [PATCH 1/2] dt-bindings: leds: add mps mp3326 LED
Thread-Topic: [PATCH 1/2] dt-bindings: leds: add mps mp3326 LED
Thread-Index: AQHaEfPkg6VyiFzre0WezJZm4wxoi7BwFPaAgAAIj2A=
Date:   Wed, 8 Nov 2023 09:30:19 +0000
Message-ID: <BY5PR13MB4487AE8D2319B5F022C53343F6A8A@BY5PR13MB4487.namprd13.prod.outlook.com>
References: <20231108032921.3134115-1-wyx137120466@gmail.com>
 <20231108032921.3134115-2-wyx137120466@gmail.com>
 <e63fbf69-fe21-45cc-ae46-7b95dae9151e@linaro.org>
In-Reply-To: <e63fbf69-fe21-45cc-ae46-7b95dae9151e@linaro.org>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR13MB4487:EE_|SN4PR13MB5696:EE_
x-ms-office365-filtering-correlation-id: 0e3eea2a-7c15-4cae-aea3-08dbe03d5319
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wCkeutMgx5bNUjTpp0084ZNauh03Gg3KoH4MxgxiyxPfmFZfdXbMg3b4dndNyrR69cNPueRUQ7qEWV5eNnh6oT5tl9xWJOHVMeRv5w/KeQ682/lU+dUMAeZgrCJO8uHiRSwZTbUOShxJUgSL0Qdi583HTMvO4kieTFVD+OehpbLNvVAn7ndDZ/qUopBRgZqa9g83sWdyPcRIzHQahhcFK+27xIpQRUj8Yqc0xTJBxicXCcVD8tv3ycyyjreKwwuhX0xVC3t4+69FJ4GvyGA8lsXQJP9SkQj4gByBLoj1f392X/HLZAos8JKCGfxOODYdcXI00DGgnJLR/mbs4gnpFWz/10Kg6D5/y1JNKi5umdC6ofT6t/jGb7NcFfs00r5E771aOR6us5eYYzBmPn0yqSAEMVv9bJ8ti9BgQJ+QOiZrrYLM/oOKjHcTc9UKng2AQYHDALabtfQ9RL7DS/waQ4eDo8MA5CFpEJTp20cqzXsOFDnz7iCnrBaMtqc53QIm34LhBRB5xVKAZtXBgP9Lq3cyU4vlMtbz5kCq8NNvI0MkNzOVLeAb8erGZ4ZLMrJrFBODZoX/d+IrVJxI8zgX49uZ1s6DYBRM777xgeuo3MPj5KWSplFpry0w4EhR2fgwOAxoNsE+7Sp0Hq0qc1/7NNNXd6y1xmCPHIZAFm06ox0N635Mi5r7DR9Ps+GNkzj4
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR13MB4487.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(396003)(376002)(136003)(39860400002)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(33656002)(38070700009)(55016003)(52536014)(8936002)(316002)(8676002)(83380400001)(4326008)(66476007)(110136005)(66946007)(66556008)(66446008)(54906003)(7416002)(64756008)(76116006)(5660300002)(41300700001)(9686003)(2906002)(107886003)(71200400001)(478600001)(6506007)(966005)(7696005)(53546011)(26005)(122000001)(86362001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TXlwSkF6K3phRklvZWJ3ZG80WG53OFFiVWhDNXRiS0FJYnBhQW5ZdU9hZnQ3?=
 =?utf-8?B?NzFHdnFrTm1LcXZFcFNBUGNlYjVBUXNnaVk4Umtic2xkU2dSRGJ3cWtPR1lP?=
 =?utf-8?B?WDVlQVF4VXdKTENNNzlmc0QyU01mV1hhakZ3OHNWb3lvS2RvVEYyVXh6bE04?=
 =?utf-8?B?SHVHcmh0NjdBSEdDdFB6b1BOb01XckNJUXd3bWNxNzBuTi9yL3JJdnZ0U1Ni?=
 =?utf-8?B?d1BhVjBkWnVRbXlVS2xxVUlmdW0yZXBkWS9IcFlxVmRXeUZnMW1uaDEzUW1O?=
 =?utf-8?B?ekthZGRvR2F0NWc3SkR6S1I4UnVodGEyVWMrSGJxVU5OZ0dIbXlibDNPZTZP?=
 =?utf-8?B?bDMwVDFrWVNESkhxMzRBV3VCQzJkOFNRRmNIRWFyN2lBb0Z3S0xSUE44VmtT?=
 =?utf-8?B?cHl3YXJBaHMvaHRVOHZZZVN6L2F6MWpyMDBYN0h0MHl6eDFFVmc4angvMEV1?=
 =?utf-8?B?MXVKbTRyaFVBUW81Zzk2ODRIb2h2VjEwSTNwSUFCWUl5UFVoN3hha2IyQ3NG?=
 =?utf-8?B?ekc3WXZvdllJV2RvTVZIWGJhNmhkNUZQQmZEYStKVnpack01TkczMkpMQ3ZJ?=
 =?utf-8?B?WFN4NHBreEdtbWRiVDZRRlR6Rk8zT3UyRVpUQkh2ci9xbU01L3lLRWEyYmpK?=
 =?utf-8?B?RUx6a25rVnEyMVg1cVdGMnZLRXMwbUl5Sk1zbDlHTTMvSDdmTCsxeEtRZzgw?=
 =?utf-8?B?cTNRSXNUKzVKdWZNOEo5dVBkRytiUjJ1NC8raDg4R0QvTFJwZDNUOUM2U2Q1?=
 =?utf-8?B?MlBaU3hVdEhmeU5idUFiOVdJeHk2c05FY21lUWFxV0ltSUxwblA4bmVmVFIx?=
 =?utf-8?B?T0xOSG9zM2laOEtnT3IzZmdPbUZBWUhiU1Bra0ZoczEzYjVQejRXOEd0VUo5?=
 =?utf-8?B?SGlaakRWY3FJYWgyQXlOT1BKNE84Y2xBaHBNNnFvR3ByaTBVUmFSVnRSdG1V?=
 =?utf-8?B?MkZsSDVBNDNaa2NTTElTMnlkUTA3RWlobUZvSmRRUGp5TDA5SU1rK1U5cld3?=
 =?utf-8?B?Uk5GVVRwQzI2WStaOWdnSHZSSzdzQ2ZJaWxLNXprVXlkbXgyN3JKeGgwSHhs?=
 =?utf-8?B?MEhEcmZWcUtMM3h1dDEyTGVBTVhES3dxdE9qTjk5RFgyd1ZBaVFRRkgyM0Uy?=
 =?utf-8?B?TWIxRml5MDFqZGdRNnVNNkIwb0dVYmxNRG5za3pONVRubDBsZ1VJYTNwSzJW?=
 =?utf-8?B?Z1dLQSt1c01UbTZOT3VuY0M2dFpBeEdxbmg5SElOby9hQ0tOaS94VmVVZkhU?=
 =?utf-8?B?aUVaOWFrVTVPSnJjeUJtcGVhSlFyeWhTK0V0UHNrclA0ekc3RGJJbHA5aVFk?=
 =?utf-8?B?c2JLS0lyV2UyN2s5WDlNNFptZG9qZWp0MWs5VmRzNDE4MldHOFRXNHNySi9U?=
 =?utf-8?B?cWJvNmo4YXR0ck9VZGVLenN4aFk2dEp5SEtjb05HT3A5QVhoM3JFQ0VtM0Fx?=
 =?utf-8?B?cndtWjZXTVdJaWRnZWVQeW5jWjIxeGVHK01CRyt6N0pETzd4VjRnVkNoaExG?=
 =?utf-8?B?WXVDbmxlbDRsZUR4SXNlblF1cy9tWEo2UC9UekNrdE9tai91Wm81cXJXVWVZ?=
 =?utf-8?B?YTF0MkpRWktPUFJ2N2dWd04zV0pFc0hjOHdJVFE4MldXR0Q5ZGtBOWhsNDV4?=
 =?utf-8?B?K1hPWitna1hXZWhWT1huZFEvUkdUWk1nTURzek1RN0d5N01HZGFLd1lpY2RI?=
 =?utf-8?B?MTVaN0FQakNxTWoyeW13Mnk0NkoxZUJtM2JLVjljdnd1NVRDcmJzOUM2UUtT?=
 =?utf-8?B?ZzVSN0EvbHhoWk1lTzJnWnRmWHEwODlMZ2lrWnVwTjJXbGdxUVJ1emVSVUJn?=
 =?utf-8?B?aDZuWE0rb0VMQXh0SG1rZWE0WUcxUDQ1RGxvallMczBCdkhlTXd1Nno1OU1k?=
 =?utf-8?B?NXQ5SlFXNG9zcGpnM0ZRaGlqaytDQ0kxYnhReTFIVUc3U3lpeUZZbFVTeWxs?=
 =?utf-8?B?MkhGbU1JdjFYeUtudXRNY2NRci9LcEFMVWM1MkJHamFiTVNFanN4amhQVmln?=
 =?utf-8?B?dDVkWE9nNXVrSklPU1lIV0FKMU0zbTRJVUZNZThpK3NIQWlMeEFLTGpNRDY1?=
 =?utf-8?B?OWIwditkQWhkZWYwdUw2NUgzdUxPVmxDTG5JcUh6ZmRHYlMwNjNsbWxmOE5i?=
 =?utf-8?B?dFg2VE9RMmV4SkR1UVBNV3JrUDZtVzJ0bi9leFJsL2l5UnVxL2gxU1JZdlpW?=
 =?utf-8?B?TGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: monolithicpower.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR13MB4487.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e3eea2a-7c15-4cae-aea3-08dbe03d5319
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2023 09:30:19.4397
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b862589a-7404-403d-98c7-6a3fede1a7b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oi9Z9VCwkD6OwnroCrHfQDVbVJkDDRou6lJDhxtTduNyO/Rz0jLluiVohH1rUkXkFT5CLmQRuPdi/f9tzuSOvcoign91/y4g30jrWxBg3qA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR13MB5696
X-Proofpoint-GUID: p8Ta-kGOjfo_-jKshyL-IsdHDF7vy0W0
X-Proofpoint-ORIG-GUID: p8Ta-kGOjfo_-jKshyL-IsdHDF7vy0W0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-08_01,2023-11-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 mlxlogscore=999 impostorscore=0 lowpriorityscore=0 suspectscore=0
 spamscore=0 clxscore=1011 malwarescore=0 priorityscore=1501 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311060001 definitions=main-2311080079
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiAwOC8xMS8yMDIzIDA0OjI5LCBZdXhpIFdhbmcgd3JvdGU6DQo+ID4gRG9jdW1lbnQgbXBz
IG1wMzMyNiBMRUQgZHJpdmVyIGRldmljZXRyZWUgYmluZGluZ3MuDQo+ID4NCj4gPiBTaWduZWQt
b2ZmLWJ5OiBZdXhpIFdhbmcgPHd5eDEzNzEyMDQ2NkBnbWFpbC5jb20+DQo+ID4gLS0tDQo+ID4g
IC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL2xlZHMvbGVkcy1tcDMzMjYueWFtbCB8IDE4NCArKysr
KysrKysrKysrKysrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDE4NCBpbnNlcnRpb25zKCspDQo+
ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
bGVkcy9sZWRzLW1wMzMyNi55YW1sDQo+IA0KPiBFeGNlcHQgdGhhdCB0aGlzIHdhcyBub3QgdGVz
dGVkIDooLCBmZXcgbW9yZSBjb21tZW50cy4NCj4gDQo+IEZpbGVuYW1lIGxpa2UgY29tcGF0aWJs
ZS4NCj4gDQpUaGFuayB5b3UgZm9yIHBvaW50aW5nIHRoaXMgb3V0LiBJIHdpbGwgdXNlIG1wcyxt
cDMzMjYueWFtbCBpbiB0aGUgbmV4dCB2ZXJzaW9uLg0KDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEv
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2xlZHMvbGVkcy1tcDMzMjYueWFtbCBi
L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9sZWRzL2xlZHMtDQo+IG1wMzMyNi55
YW1sDQo+ID4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gPiBpbmRleCAwMDAwMDAwMDAwMDAuLjg5
OWNmNTY4ZjY0Nw0KPiA+IC0tLSAvZGV2L251bGwNCj4gPiArKysgYi9Eb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvbGVkcy9sZWRzLW1wMzMyNi55YW1sDQo+ID4gQEAgLTAsMCArMSwx
ODQgQEANCj4gPiArIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogKEdQTC0yLjAtb25seSBPUiBC
U0QtMi1DbGF1c2UpDQo+ID4gKyVZQU1MIDEuMg0KPiA+ICstLS0NCj4gPiArJGlkOg0KPiBodHRw
czovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cDovL2RldmljZXRyZWUub3JnL3NjaGVtYXMvbXBz
LG1wMzMyNi55YW1sKl9fO0l3ISFGSUhNVmxHcllWR2E1a3dHSENZIVhfRWpiOHVlaXZlYnZNdjIN
Cj4gUm9vVnk5TVZncVdSRWxmNzVOVGs4SlBxRlhhWXdXTnl6dXBLN1hLTjVVS0F2SlJvLVdNUW12
eEl1SlBxNWlzS0hlb3FGYktaNF9jSDgxaDI0ZnJzJA0KPiA+ICskc2NoZW1hOiBodHRwczovL3Vy
bGRlZmVuc2UuY29tL3YzL19faHR0cDovL2RldmljZXRyZWUub3JnL21ldGEtDQo+IHNjaGVtYXMv
Y29yZS55YW1sKl9fO0l3ISFGSUhNVmxHcllWR2E1a3dHSENZIVhfRWpiOHVlaXZlYnZNdjJSb29W
eTlNVmdxV1JFbGY3NU5UazhKUHFGWGFZd1dOeXp1cEs3WEtONVVLQXZKUg0KPiBvLVdNUW12eEl1
SlBxNWlzS0hlb3FGYktaNF9jSDg4c21tVnlBJA0KPiA+ICsNCj4gPiArdGl0bGU6IE1QUyBNUDMz
MjYgUkdCL1doaXRlIExFRCBEcml2ZXINCj4gPiArDQo+ID4gK21haW50YWluZXJzOg0KPiA+ICsg
IC0gWXV4aSBXYW5nIDx3eXgxMzcxMjA0NjZAZ21haWwuY29tPg0KPiA+ICsNCj4gPiArZGVzY3Jp
cHRpb246IHwNCj4gPiArICBUaGUgTVAzMzI2IGlzIGEgUkdCL1doaXRlIExFRCBkcml2ZXIgd2l0
aCBJMkMgaW50ZXJmYWNlLg0KPiA+ICsNCj4gPiArICBGb3IgbW9yZSBwcm9kdWN0IGluZm9ybWF0
aW9uIHBsZWFzZSBzZWUgdGhlIGxpbmsgYmVsb3c6DQo+ID4gKyAgaHR0cHM6Ly93d3cubW9ub2xp
dGhpY3Bvd2VyLmNvbS9lbi9wcm9kdWN0cy9tcDMzMjYuaHRtbA0KPiA+ICsNCj4gPiArcHJvcGVy
dGllczoNCj4gPiArICBjb21wYXRpYmxlOg0KPiA+ICsgICAgLSBjb25zdDogbXBzLG1wMzMyNg0K
PiA+ICsNCj4gPiArICAiI2FkZHJlc3MtY2VsbHMiOg0KPiA+ICsgICAgY29uc3Q6IDENCj4gPiAr
DQo+ID4gKyAgIiNzaXplLWNlbGxzIjoNCj4gPiArICAgIGNvbnN0OiAwDQo+ID4gKw0KPiA+ICsg
IHJlZzoNCj4gPiArICAgIG1heEl0ZW1zOiAxDQo+ID4gKw0KPiA+ICsgIG1wcyxsZWQtcHJvdGVj
dDoNCj4gPiArICAgIGRlc2NyaXB0aW9uOiB8DQo+ID4gKyAgICAgIExFRCBzaG9ydCBwcm90ZWN0
aW9uIHRocmVzaG9sZC4NCj4gDQo+IHRocmVzaG9sZD8gU28gaW4gc29tZSB1bml0cz8gV2hhdCBk
b2VzIGl0IG1lYW4/IFdoYXQgZG8gdGhlIHZhbHVlcyBtZWFuPw0KPiANClllcywgaXQgaW5kaWNh
dGVzIHNob3J0IHByb3RlY3Rpb24gdGhyZXNob2xkIGluIG1wMzMyNi4NCkJ1dCB0aGV5IGRvIG5v
dCBoYXZlIHRoZSB1bml0cy4gVGhleSBqdXN0IGluZGljYXRlIHRoZSBjb3JyZXNwb25kaW5nIGJp
dHMgdmFsdWUgb2YgcmVnaXN0ZXIgd2hpY2ggY2FuIGNvbmZpZ3VyZSBzaG9ydCBwcm90ZWN0aW9u
IHZhbHVlLg0KDQo+ID4gKyAgICBlbnVtOiBbMCwgMSwgMiwgM10NCj4gPiArDQo+ID4gKyAgbXVs
dGktbGVkOg0KPiA+ICsgICAgdHlwZTogb2JqZWN0DQo+ID4gKw0KPiA+ICsgICAgcHJvcGVydGll
czoNCj4gPiArICAgICAgIiNhZGRyZXNzLWNlbGxzIjoNCj4gPiArICAgICAgICBjb25zdDogMQ0K
PiA+ICsgICAgICAiI3NpemUtY2VsbHMiOg0KPiA+ICsgICAgICAgIGNvbnN0OiAwDQo+ID4gKw0K
PiA+ICsgICAgICBjb2xvcjoNCj4gPiArICAgICAgICBkZXNjcmlwdGlvbjogUkdCIG1vZHVsZQ0K
PiA+ICsgICAgICAgIGNvbnN0OiBMRURfQ09MT1JfSURfUkdCDQo+ID4gKw0KPiA+ICsgICAgICBs
ZWRfcjoNCj4gDQo+IE5vcGUuIEZpcnN0LCBubyB1bmRlcnNjb3JlcyBpbiBuYW1lcy4gU2Vjb25k
LCBwbGVhc2Ugb3BlbiBleGlzdGluZw0KPiBiaW5kaW5ncyBhbmQgbG9vayBob3cgaXQgaXMgZG9u
ZSB0aGVyZS4NCj4gDQpUaGFuayB5b3UgZm9yIHBvaW50aW5nIG91dCB0aGlzLCBJIHdpbGwgRml4
ZWQgaXQgaW4gdGhlIG5leHQgdmVyc2lvbi4NCj4gPiArICAgICAgICB0eXBlOiBvYmplY3QNCj4g
PiArDQo+ID4gKyAgICAgICAgcHJvcGVydGllczoNCj4gPiArICAgICAgICAgICIjYWRkcmVzcy1j
ZWxscyI6DQo+ID4gKyAgICAgICAgICAgIGNvbnN0OiAxDQo+ID4gKyAgICAgICAgICAiI3NpemUt
Y2VsbHMiOg0KPiA+ICsgICAgICAgICAgICBjb25zdDogMA0KPiANCj4gV2h5IGRvIHlvdSBoYXZl
IHRoZSw/DQo+IA0KDQpTb3JyeSwgIGhlcmUgaW4gbm8gLCAuDQp3aGF0IGRvIHlvdSBtZWFuPw0K
DQo+ID4gKyAgICAgICAgICByZWc6DQo+ID4gKyAgICAgICAgICAgIGRlc2NyaXB0aW9uOiBJbmRl
eCBvZiB0aGUgTEVELg0KPiA+ICsgICAgICAgICAgICBtaW5pbXVtOiAxDQo+ID4gKyAgICAgICAg
ICAgIG1heGltdW06IDE2DQo+IA0KPiBQbGVhc2UgZm9ybWF0IGl0IHByb3Blcmx5LiBZb3UgbWlz
cyBibGFuayBsaW5lcyBiZXR3ZWVuIGVhY2ggcHJvcGVydHkNCj4gZGVzY3JpcHRpb24uDQo+IA0K
VGhhbmsgeW91IGZvciBwb2ludGluZyB0aGlzIG91dC4gSSB3aWxsIGFkZCB0aGUgYmxhbmsgbGlu
ZXMgaW4gdGhlIG5leHQgdmVyc2lvbi4NCj4gPiArICAgICAgICAgIGNvbG9yOg0KPiA+ICsgICAg
ICAgICAgICBkZXNjcmlwdGlvbjogUmVkLg0KPiA+ICsgICAgICAgICAgICBjb25zdDogTEVEX0NP
TE9SX0lEX1JFRA0KPiA+ICsgICAgICAgICAgcmVxdWlyZWQ6DQo+ID4gKyAgICAgICAgICAgIC0g
cmVnDQo+ID4gKyAgICAgICAgICAgIC0gY29sb3INCj4gPiArDQo+ID4gKyAgICAgIGxlZF9nOg0K
PiA+ICsgICAgICAgIHR5cGU6IG9iamVjdA0KPiA+ICsNCj4gPiArICAgICAgICBwcm9wZXJ0aWVz
Og0KPiA+ICsgICAgICAgICAgIiNhZGRyZXNzLWNlbGxzIjoNCj4gPiArICAgICAgICAgICAgY29u
c3Q6IDENCj4gPiArICAgICAgICAgICIjc2l6ZS1jZWxscyI6DQo+ID4gKyAgICAgICAgICAgIGNv
bnN0OiAwDQo+ID4gKyAgICAgICAgcmVnOg0KPiA+ICsgICAgICAgICAgZGVzY3JpcHRpb246IElu
ZGV4IG9mIHRoZSBMRUQuDQo+ID4gKyAgICAgICAgICBtaW5pbXVtOiAxDQo+ID4gKyAgICAgICAg
ICBtYXhpbXVtOiAxNg0KPiA+ICsgICAgICAgIGNvbG9yOg0KPiA+ICsgICAgICAgICAgZGVzY3Jp
cHRpb246IEdyZWVuLg0KPiA+ICsgICAgICAgICAgY29uc3Q6IExFRF9DT0xPUl9JRF9HUkVFTg0K
PiA+ICsgICAgICAgIHJlcXVpcmVkOg0KPiA+ICsgICAgICAgICAgLSByZWcNCj4gPiArICAgICAg
ICAgIC0gY29sb3INCj4gPiArDQo+ID4gKyAgICAgIGxlZF9iOg0KPiA+ICsgICAgICAgIHR5cGU6
IG9iamVjdA0KPiA+ICsNCj4gPiArICAgICAgICBwcm9wZXJ0aWVzOg0KPiA+ICsgICAgICAgICAg
IiNhZGRyZXNzLWNlbGxzIjoNCj4gPiArICAgICAgICAgICAgY29uc3Q6IDENCj4gPiArICAgICAg
ICAgICIjc2l6ZS1jZWxscyI6DQo+ID4gKyAgICAgICAgICAgIGNvbnN0OiAwDQo+ID4gKyAgICAg
ICAgcmVnOg0KPiA+ICsgICAgICAgICAgZGVzY3JpcHRpb246IEluZGV4IG9mIHRoZSBMRUQuDQo+
ID4gKyAgICAgICAgICBtaW5pbXVtOiAxDQo+ID4gKyAgICAgICAgICBtYXhpbXVtOiAxNg0KPiA+
ICsgICAgICAgIGNvbG9yOg0KPiA+ICsgICAgICAgICAgZGVzY3JpcHRpb246IEJsdWUuDQo+ID4g
KyAgICAgICAgICBjb25zdDogTEVEX0NPTE9SX0lEX0JMVUUNCj4gPiArICAgICAgICByZXF1aXJl
ZDoNCj4gPiArICAgICAgICAgIC0gcmVnDQo+ID4gKyAgICAgICAgICAtIGNvbG9yDQo+ID4gKw0K
PiA+ICsgIHBhdHRlcm5Qcm9wZXJ0aWVzOg0KPiA+ICsgICAgIl5sZWRAWzAtM10kIjoNCj4gPiAr
ICAgICAgdHlwZTogb2JqZWN0DQo+ID4gKw0KPiA+ICsgICAgICBwcm9wZXJ0aWVzOg0KPiA+ICsg
ICAgICAgIHJlZzoNCj4gPiArICAgICAgICAgIGRlc2NyaXB0aW9uOiBJbmRleCBvZiB0aGUgTEVE
Lg0KPiA+ICsgICAgICAgICAgbWluaW11bTogMQ0KPiA+ICsgICAgICAgICAgbWF4aW11bTogMTYN
Cj4gPiArDQo+ID4gKyAgICAgICAgcmVxdWlyZWQ6DQo+ID4gKyAgICAgICAgICAtIHJlZw0KPiA+
ICsgICAgICAgICAgLSBjb2xvcg0KPiANCj4gTWlzc2luZyByZXF1aXJlZCwgYWRkaXRpb25hbFBy
b3BlcnRpZXMuDQo+IA0KPiBPcGVuIGV4aXN0aW5nIGJpbmRpbmcgYW5kIHVzZSBpdCBhcyBleGFt
cGxlLg0KPiANClRoYW5rIHlvdSBmb3IgcG9pbnRpbmcgdGhpcyBvdXQuIEkgd2lsbCBhZGQgdGhl
IGFkZGl0aW9uYWwgUHJvcGVydGllcyBpbiB0aGUgbmV4dCB2ZXJzaW9uLg0KPiA+ICsNCj4gPiAr
ZXhhbXBsZXM6DQo+ID4gKyAgLSB8DQo+ID4gKyAgICAjaW5jbHVkZSA8ZHQtYmluZGluZ3MvbGVk
cy9jb21tb24uaD4NCj4gPiArDQo+ID4gKyAgICBpMmMgew0KPiA+ICsgICAgICAgICNhZGRyZXNz
LWNlbGxzID0gPDE+Ow0KPiA+ICsgICAgICAgICNzaXplLWNlbGxzID0gPDA+Ow0KPiA+ICsNCj4g
PiArICAgICAgICBtcDMzMjZAMzAgew0KPiANCj4gTm9kZSBuYW1lcyBzaG91bGQgYmUgZ2VuZXJp
Yy4gU2VlIGFsc28gYW4gZXhwbGFuYXRpb24gYW5kIGxpc3Qgb2YNCj4gZXhhbXBsZXMgKG5vdCBl
eGhhdXN0aXZlKSBpbiBEVCBzcGVjaWZpY2F0aW9uOg0KPiBodHRwczovL3VybGRlZmVuc2UuY29t
L3YzL19faHR0cHM6Ly9kZXZpY2V0cmVlLXNwZWNpZmljYXRpb24ucmVhZHRoZWRvY3MuaW8vZW4v
bGF0ZXN0L2NoYXB0ZXIyLWRldmljZXRyZWUtYmFzaWNzLmh0bWwqZ2VuZXJpYy0NCj4gbmFtZXMt
DQo+IHJlY29tbWVuZGF0aW9uX187SXchIUZJSE1WbEdyWVZHYTVrd0dIQ1khWF9FamI4dWVpdmVi
dk12MlJvb1Z5OU1WZ3FXUkVsZjc1TlRrOEpQcUZYYVl3V055enVwSzdYS041VUtBdkpSby0NCj4g
V01RbXZ4SXVKUHE1aXNLSGVvcUZiS1o0X2NIOC1LMmNYbzgkDQo+IA0KVGhhbmsgeW91IGZvciBz
aGFyaW5nIHRoaXMsIEkgd2lsbCBjaGVjayBpdCBhbmQgY2hhbmdlIGl0IGluIHRoZSBuZXh0IHZl
cnNpb24uDQo+IA0KPiA+ICsgICAgICAgICAgICBjb21wYXRpYmxlID0gIm1wcyxtcDMzMjYiOw0K
PiA+ICsgICAgICAgICAgICByZWcgPSA8MHgzMD47DQo+ID4gKyAgICAgICAgICAgIGxlZC1wcm90
ZWN0ID08Mz47DQo+ID4gKyAgICAgICAgICAgICNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KPiA+ICsg
ICAgICAgICAgICAjc2l6ZS1jZWxscyA9IDwwPjsNCj4gPiArDQo+ID4gKyAgICAgICAgICAgIG11
bHRpLWxlZCB7DQo+ID4gKyAgICAgICAgICAgICAgY29sb3IgPSA8TEVEX0NPTE9SX0lEX1JHQj47
DQo+ID4gKyAgICAgICAgICAgICAgI2FkZHJlc3MtY2VsbHMgPSA8MT47DQo+ID4gKyAgICAgICAg
ICAgICAgI3NpemUtY2VsbHMgPSA8MD47DQo+ID4gKw0KPiA+ICsgICAgICAgICAgICAgIHJnYl9y
QDEgew0KPiA+ICsgICAgICAgICAgICAgICAgICAjYWRkcmVzcy1jZWxscyA9IDwxPjsNCj4gPiAr
ICAgICAgICAgICAgICAgICAgI3NpemUtY2VsbHMgPSA8MD47DQo+ID4gKyAgICAgICAgICAgICAg
ICAgIHJlZyAgPSA8MT47DQo+ID4gKyAgICAgICAgICAgICAgICAgIGNvbG9yID0gPExFRF9DT0xP
Ul9JRF9SRUQ+Ow0KPiA+ICsgICAgICAgICAgICAgIH07DQo+ID4gKyAgICAgICAgICAgICAgcmdi
X2dAMiB7DQo+ID4gKyAgICAgICAgICAgICAgICAgICNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KPiA+
ICsgICAgICAgICAgICAgICAgICAjc2l6ZS1jZWxscyA9IDwwPjsNCj4gPiArICAgICAgICAgICAg
ICAgICAgcmVnID0gPDI+Ow0KPiA+ICsgICAgICAgICAgICAgICAgICBjb2xvciA9IDxMRURfQ09M
T1JfSURfR1JFRU4+Ow0KPiA+ICsgICAgICAgICAgICAgIH07DQo+ID4gKyAgICAgICAgICAgICAg
cmdiX2JAMyB7DQo+ID4gKyAgICAgICAgICAgICAgICAgICNhZGRyZXNzLWNlbGxzID0gPDE+Ow0K
PiA+ICsgICAgICAgICAgICAgICAgICAjc2l6ZS1jZWxscyA9IDwwPjsNCj4gPiArICAgICAgICAg
ICAgICAgICAgcmVnID0gPDM+Ow0KPiA+ICsgICAgICAgICAgICAgICAgICBjb2xvciA9IDxMRURf
Q09MT1JfSURfQkxVRT47DQo+ID4gKyAgICAgICAgICAgICAgfTsNCj4gPiArICAgICAgICAgICAg
fTsNCj4gPiArICAgICAgICB9Ow0KPiA+ICsgICAgfTsNCj4gPiArDQo+ID4gKyAgLSB8DQo+ID4g
KyAgICAjaW5jbHVkZSA8ZHQtYmluZGluZ3MvbGVkcy9jb21tb24uaD4NCj4gPiArDQo+ID4gKyAg
ICBpMmMgew0KPiA+ICsgICAgICAgICNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KPiA+ICsgICAgICAg
ICNzaXplLWNlbGxzID0gPDA+Ow0KPiA+ICsNCj4gPiArICAgICAgICBtcDMzMjZAMzAgew0KPiAN
Cj4gTm9kZSBuYW1lcyBzaG91bGQgYmUgZ2VuZXJpYy4gU2VlIGFsc28gYW4gZXhwbGFuYXRpb24g
YW5kIGxpc3Qgb2YNCj4gZXhhbXBsZXMgKG5vdCBleGhhdXN0aXZlKSBpbiBEVCBzcGVjaWZpY2F0
aW9uOg0KPiBodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly9kZXZpY2V0cmVlLXNw
ZWNpZmljYXRpb24ucmVhZHRoZWRvY3MuaW8vZW4vbGF0ZXN0L2NoYXB0ZXIyLWRldmljZXRyZWUt
YmFzaWNzLmh0bWwqZ2VuZXJpYy0NCj4gbmFtZXMtDQo+IHJlY29tbWVuZGF0aW9uX187SXchIUZJ
SE1WbEdyWVZHYTVrd0dIQ1khWF9FamI4dWVpdmVidk12MlJvb1Z5OU1WZ3FXUkVsZjc1TlRrOEpQ
cUZYYVl3V055enVwSzdYS041VUtBdkpSby0NCj4gV01RbXZ4SXVKUHE1aXNLSGVvcUZiS1o0X2NI
OC1LMmNYbzgkDQo+IA0KVGhhbmsgeW91IGZvciBzaGFyaW5nIHRoaXMsIEkgd2lsbCBjaGVjayBp
dCBhbmQgY2hhbmdlIGl0IGluIHRoZSBuZXh0IHZlcnNpb24uDQo+IA0KPiA+ICsgICAgICAgICAg
ICBjb21wYXRpYmxlID0gIm1wcyxtcDMzMjYiOw0KPiA+ICsgICAgICAgICAgICByZWcgPSA8MHgz
MD47DQo+ID4gKyAgICAgICAgICAgIGxlZC1wcm90ZWN0ID08Mz47DQo+ID4gKyAgICAgICAgICAg
ICNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KPiA+ICsgICAgICAgICAgICAjc2l6ZS1jZWxscyA9IDww
PjsNCj4gPiArICAgICAgICAgICAgbGVkMEAwIHsNCj4gPiArICAgICAgICAgICAgICAgICNhZGRy
ZXNzLWNlbGxzID0gPDE+Ow0KPiA+ICsgICAgICAgICAgICAgICAgI3NpemUtY2VsbHMgPSA8MD47
DQo+ID4gKyAgICAgICAgICAgICAgICByZWc9IDw1PjsNCj4gPiArICAgICAgICAgICAgICAgIGNv
bG9yID0gPExFRF9DT0xPUl9JRF9XSElURT47DQo+ID4gKyAgICAgICAgICAgIH07DQo+ID4gKyAg
ICAgICAgfTsNCj4gPiArICAgIH07DQo+ID4gKw0KPiA+ICsuLi4NCj4gDQo+IEJlc3QgcmVnYXJk
cywNCj4gS3J6eXN6dG9mDQoNCg0KQmVzdCBSZWdhcmRzLg0KDQpZdXhpIFdhbmcgDQoNCg0KDQo=
