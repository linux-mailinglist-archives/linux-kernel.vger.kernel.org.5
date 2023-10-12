Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8FBC7C6A55
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 12:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343609AbjJLKCy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 06:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234182AbjJLKCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 06:02:48 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAF33BA;
        Thu, 12 Oct 2023 03:02:44 -0700 (PDT)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 39C829V5009901;
        Thu, 12 Oct 2023 06:02:11 -0400
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3tp9p6ssrk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Oct 2023 06:02:11 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YjKI9/PKTx7H/OqlbnPN1L6hafTBIGV+Bs/yNjhR6mYmczkco4ZmAKI0OxL9r0P121nQVdMie4/pMnvwtyk1rL4cYGJF9vNmWozcswDPZ/Rk0NG6wqGJa9VZozcEdsZ/fAF9acIZsdfB/VN+7cCSDx0qIczxl1duk019OJGpErxApjINrKz1BhcgBMWBFdIDujjf++CKMTQk9vNgJpxa0SOtmfcjvRgcmhAlfb7E1NXCKFvFWqel6jsIDm47lmzZ1+pRwX5/iXvHJJpehXLagqk3Pshl7grNPmiLQ+yt5kBTF5ZZiAPoJa6pqaE3Y1Iw7grB+xirXcckvuFdxQZQww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zmAvXwibXckk0yDClMAOjrGQw8RiiWlJC6liiNkQzDI=;
 b=P1gIrdhkqKsy+/q/AhhyAxO+K7wTA33SIt8qEJC52riU9/U5icJ/4JXyAynI7UK+hM+UlqkCv4BeqiSQI3zRQB//V9JeS10wtOrAzpYb5ewLGV069suBozb5tHcj5LG2PgtOX6Qy17R9c2+dY3ksm9wB3hcJ72kyY2x/UPr7uwWbn8fyjLFDmuMO5LzXmVuFuJFO3Byzul3MXGK9zVCUmhC37ZGd6jGerY0DwGNTYt3ePNz5tFku+5nXdwGr+y+qDsl+FzaMI7APHO1S5EcGkA1PlPnCqRAv1cJmAsh9Km2Hb36Oe3orJg9OOKGiyaTy1QKSp4JVdlcUi06lox4N9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zmAvXwibXckk0yDClMAOjrGQw8RiiWlJC6liiNkQzDI=;
 b=ZNkzs62VZQRTtcJ5camoKpoUGtzJiGRxppMudaT+1SX9fLbh7uHulKewi6sTBI3fGiCHl0XvpEfCM1kQys+8G+ENqwgdmaHfusmWKaeupW0nCGQ6qRHaFEJfR5Zhp4+uL/H/dR0gqf5Vm/k84klKa6aP0zL47aswHtMbX5Kremc=
Received: from CY4PR03MB3399.namprd03.prod.outlook.com (2603:10b6:910:57::13)
 by CH3PR03MB7506.namprd03.prod.outlook.com (2603:10b6:610:19a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.44; Thu, 12 Oct
 2023 10:02:08 +0000
Received: from CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::ed02:8279:265d:e00f]) by CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::ed02:8279:265d:e00f%4]) with mapi id 15.20.6863.043; Thu, 12 Oct 2023
 10:02:07 +0000
From:   "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        =?iso-8859-1?Q?Nuno_S=E1?= <noname.nuno@gmail.com>
CC:     Jean Delvare <jdelvare@suse.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: RE: [PATCH v3 2/2] drivers: hwmon: ltc2991: add driver support
Thread-Topic: [PATCH v3 2/2] drivers: hwmon: ltc2991: add driver support
Thread-Index: AQHZ9c/WLuqIcswPJEmCq5tuXUE077BCwGgAgAHqnwCAAUzCEA==
Date:   Thu, 12 Oct 2023 10:02:07 +0000
Message-ID: <CY4PR03MB3399C19BAB8F482A1CBECBB99BD3A@CY4PR03MB3399.namprd03.prod.outlook.com>
References: <20231003080059.8041-1-antoniu.miclaus@analog.com>
 <20231003080059.8041-2-antoniu.miclaus@analog.com>
 <1e6ee7f6733d621a9be7fd94d48e41ca76c05a3c.camel@gmail.com>
 <1f3bc281-9bb3-4a56-8791-773e2e762513@roeck-us.net>
In-Reply-To: <1f3bc281-9bb3-4a56-8791-773e2e762513@roeck-us.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?iso-8859-1?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcYW1pY2xhdX?=
 =?iso-8859-1?Q?NcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZi?=
 =?iso-8859-1?Q?ODRiYTI5ZTM1Ylxtc2dzXG1zZy02MTNjMDBiZC02OGU2LTExZWUtYWU2NC?=
 =?iso-8859-1?Q?1kNDgxZDc1MDZkZGVcYW1lLXRlc3RcNjEzYzAwYmUtNjhlNi0xMWVlLWFl?=
 =?iso-8859-1?Q?NjQtZDQ4MWQ3NTA2ZGRlYm9keS50eHQiIHN6PSIyMjg3NyIgdD0iMTMzND?=
 =?iso-8859-1?Q?E1Nzg1MjUxMDczMjE1IiBoPSJHcDdTeEpuQXdPeTZneWFPS0w2R0NBSzBD?=
 =?iso-8859-1?Q?Z289IiBpZD0iIiBibD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVU?=
 =?iso-8859-1?Q?ZOQ2dVQUFFb0NBQUMvN0ZFbjgvelpBUzRyUGhLYnpDdFlMaXMrRXB2TUsx?=
 =?iso-8859-1?Q?Z0RBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBSEFBQUFEYUFRQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBRUFBUUFCQUFBQUVPcGxPZ0FBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUo0QUFBQmhBR1FBYVFCZkFITUFaUUJqQUhVQWNnQmxBRjhBY0FCeU?=
 =?iso-8859-1?Q?FHOEFhZ0JsQUdNQWRBQnpBRjhBWmdCaEFHd0Fjd0JsQUY4QVpnQnZBSE1B?=
 =?iso-8859-1?Q?YVFCMEFHa0FkZ0JsQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFFQUFBQUFBQUFBQWdBQUFBQUFuZ0?=
 =?iso-8859-1?Q?FBQUdFQVpBQnBBRjhBY3dCbEFHTUFkUUJ5QUdVQVh3QndBSElBYndCcUFH?=
 =?iso-8859-1?Q?VUFZd0IwQUhNQVh3QjBBR2tBWlFCeUFERUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFBQUFDZUFBQUFZUUJr?=
 =?iso-8859-1?Q?QUdrQVh3QnpBR1VBWXdCMUFISUFaUUJmQUhBQWNnQnZBR29BWlFCakFIUU?=
 =?iso-8859-1?Q?Fjd0JmQUhRQWFRQmxBSElBTWdBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBQT09Ii8+PC9tZXRhPg=3D?=
 =?iso-8859-1?Q?=3D?=
x-dg-rorf: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY4PR03MB3399:EE_|CH3PR03MB7506:EE_
x-ms-office365-filtering-correlation-id: 34f847af-a406-4004-a2fa-08dbcb0a4b6d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XcFXi9nJDYU14KAnNgJ84gKn+P37jOLzmPigmtFhHwxcn0R6xw/uponSYN7AMVHEOMaT9woDXR4ERRBCnjKQTFuf+51P/vYGUW5GSPiDqmhzFZi+FrZzeQ9f9lqvJor8p8ZT6yRF4CUall2CkD0jQ0IUne6WvWV5MZpRU9PdG+6E+So70nGKuDhnZkq1SFbMdmd7lhAhhzKLb+E0JlqXVjITac0tQBpOTwmKCgZUqDMYm2/1qu0pxGMK+4xDk8PslK1dqCJ0DwjO0j3trTkAFE0zvmPC0PNMA+/DciDIEeS4BCz8p/D2PGhhioU/rJr+yZ/2IToQLzIXvS9CfMxYx74/6cnAJz/8sF22DEsyzvNVA1IAcRpfp2alNG9EBAoCJ+I8r1ngqLguCM31y8MrlaNKgHELqDJMZlN0jX0ZJYdbF0eE8aHS3IPmmVtXuZJqH6S67uLj05qn1ThT4NvzjlhMOCR1f4hLYROD7VqKoj4J0xpZLEjRCMtaG6VpTa1r2fF3bnnFq/yzOSiWt4BX6+WWG22kmE5q8FlQOU9Y/8u4D5wFMBAynrJlL74NGQTcPoNIIZwfrdJgPemtqLGz4JZvicgQf7tm3jyRkaFdVoeBstaMUZKyp3SluaOJoTupJcfbgWN4y2Mn3HhFx8F6hw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR03MB3399.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(346002)(136003)(366004)(376002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(26005)(478600001)(966005)(7696005)(55016003)(6506007)(83380400001)(86362001)(71200400001)(41300700001)(8936002)(8676002)(4326008)(66946007)(54906003)(64756008)(316002)(66476007)(66446008)(66556008)(76116006)(110136005)(9686003)(30864003)(7416002)(2906002)(33656002)(38100700002)(5660300002)(122000001)(52536014)(38070700005)(579004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ZMsgXXcjBzz2Dd728kzsDaCagMtovISOe78d4+umaJJT7N+FVjG53FuaQc?=
 =?iso-8859-1?Q?cifxEwF6+LzyxnuGo+fzZIq5g/nXzFcrKDldfLYguJl/nRm3YqPQ+dSwe7?=
 =?iso-8859-1?Q?eqaliamVhMu3FmQEXNKqAPY3Z5j5itSfPQSUX1PVRO2ghFHhd3Qzq9eLzt?=
 =?iso-8859-1?Q?9N6BTursh2QS/VnycYjAgVal005EzzRcSQP1pFF+KxanzLkEEbn3xIh6ud?=
 =?iso-8859-1?Q?J7irybcZbCZWTgtcQP6lc4aFEwUuY2ptPUvAgIk/zG4e6/aBIQKXmqLih8?=
 =?iso-8859-1?Q?pPHFR4AW57ah0Mv1Vl+WQNwA9cA+pnwkVFDYyZoAkTmrUqt7lovIgk18Bl?=
 =?iso-8859-1?Q?6030seB5AnotcSvykQbGMCugo0SkcoQ6D5JGkq8NLsJv0wq9AT0onbzOXf?=
 =?iso-8859-1?Q?bOV5L/ZdWAe5uzEhIDuXY63xaXALDsRU5s1BQyqR4/pbu9Iq4gh26IveMf?=
 =?iso-8859-1?Q?+esc7Xb4QksKN/VKLGAABw2vh1jVSd7Jblxiehl2OVZds6UkvoVeGZx5vT?=
 =?iso-8859-1?Q?hUGQujdvtoLEeTWuIdiNZY+hsqr12TVT5qcDslM1+TwxJIpiVxgeu/WbGI?=
 =?iso-8859-1?Q?wuod3UZqlRLtbYS96jFSOUoeh5wj2ToYzavACOmPZvdjrK6VZGiVSr4iab?=
 =?iso-8859-1?Q?HsWd8TBuEsS6sfMOteRRFo7CZxJe17dqtzX/ZTIx9vj1QndB2YhCA96o/j?=
 =?iso-8859-1?Q?W7icGFECFOGA5mpS1m89BS5YTyN/jE0J7qEEBgLqm9IDL83dp7UvLDhXSk?=
 =?iso-8859-1?Q?U8xldR2/Wve9f3JL7UHCgluUGA0nfnZGRIs3p+QHEdojxAr3GRcWoKJ2Ot?=
 =?iso-8859-1?Q?01bkXKxIf5z2joGwQ3x6uRIAk4NydWPUvIMdHCWwTNNfUinJXLfxFHEMF3?=
 =?iso-8859-1?Q?VMABmq2ELSFykoe0Bo5lUeNdhqkv1gD7qlKsvEF6K7H/i0kVKHDM0XxuIT?=
 =?iso-8859-1?Q?tWzNCaK9suu3Io+iP4qGn1EJqvsJWNXQpjPOGhsd/DxdICSyo17/5ILKB3?=
 =?iso-8859-1?Q?a8H74yZdTuvVUnU4tYeYMGm8a7AN5g+J0lH9Z3bGQF2nRvmk2ntDsfEC1r?=
 =?iso-8859-1?Q?83CL5BEUxFX/1FevolBsM50ar/tULbVFt1LoBfe+Krb6CFwmyQYbD6vQXW?=
 =?iso-8859-1?Q?N5JBN8FSeCtRCCr8KwmXDUnR8FgfV+Jpg5DEXbLFK2SGIV2Rrybus+ddMz?=
 =?iso-8859-1?Q?OFG6efKbHjtD8RUDXEXR5GEqDJFijBx806jALNo7WvlhT++gu4zKDUJJ7z?=
 =?iso-8859-1?Q?+IfcLk96XpQ5yqbeLd3kxBk5/J5DFgKHbs8uwpU6C4qxDcu7W9dQML0IXC?=
 =?iso-8859-1?Q?azovbuqtaRCCiZ2409J7KYeIlC6i00TdyrQZkCEYYjs2Ug6mZWWAUusTGl?=
 =?iso-8859-1?Q?GlEX45fu/D47bdU4MAU+VAxYvyvBKR7CZ1aykRWQpDW3nocytBZYhgrHSP?=
 =?iso-8859-1?Q?746XJNIVNmanr4ZHHdPPFXPk2a7E0n/4sYFbi4Dkkfp5wNvWhhjYd1PjNu?=
 =?iso-8859-1?Q?J6Ss56ZPWOXm+5pFNH3h4YIizJSOMtjbEnyHsYurFQ8JwPUfD1AshKUr4T?=
 =?iso-8859-1?Q?y8L47y3xwvNrDGBlHHwdMBjFT4m1p7mtzp91sxSLevZsIEiGz90UreRfRH?=
 =?iso-8859-1?Q?9tFnngASfxOQW1fDL5pSyZ2RosOpYnAG6T1z5uhh4047rbtkTBDxpzAA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR03MB3399.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34f847af-a406-4004-a2fa-08dbcb0a4b6d
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2023 10:02:07.8102
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MfnWJuy3tTd6lAf5dyZW7YGaYtJAgwPT1xNwZLP4RTnI9z7K05jSqiIHNTtapim+EX7yaAjC5e8JVYs1oWiB6lqqRit/trrGYU84EITAdJI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR03MB7506
X-Proofpoint-GUID: jP9tW6QFWiR6mEs84yuu5J-cwwLvXnLy
X-Proofpoint-ORIG-GUID: jP9tW6QFWiR6mEs84yuu5J-cwwLvXnLy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-12_05,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 suspectscore=0 priorityscore=1501 clxscore=1011 phishscore=0 adultscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2309180000
 definitions=main-2310120082
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>=20
> On Tue, Oct 10, 2023 at 10:44:44AM +0200, Nuno S=E1 wrote:
> > Hi Antoniu,
> >
> > A few more comments from me. But essentially, I think you should revisi=
t
> V1 and
> > Guenter's comments. I'm fairly sure you are still missing his main poin=
ts...
> >
> Yes. And there is no change log either.
>=20
> Guenter
>=20
For some reason I completely missed your comments on V1 (saw only Nuno's).

And I apologize for that.

Regarding the channel exposure, according to the typical applications of th=
e part
(datasheet page 24/25 for example) a voltage pair (V1-V2) can be used as fo=
llows:
V1-V2 differential reading to obtain current based on rsense (Imotor) and i=
n the
same setup V1 is used for singled ended voltage reading (Vmotor). While for=
 the
Temperature readings there are no other readings done on the same pins.

Also looking at all usecases of the part, the differential input can be use=
d either to
obtain current, either to measure temperature.=20

I will update the channel exposure accordingly in V4 and do the other chang=
es
requested.

Thank you,
Antoniu
> > On Tue, 2023-10-03 at 11:00 +0300, Antoniu Miclaus wrote:
> > > Add support for LTC2991 Octal I2C Voltage, Current, and Temperature
> > > Monitor.
> > >
> > > The LTC2991 is used to monitor system temperatures, voltages and
> > > currents. Through the I2C serial interface, the eight monitors can
> > > individually measure supply voltages and can be paired for
> > > differential measurements of current sense resistors or temperature
> > > sensing transistors. Additional measurements include internal
> > > temperature and internal VCC.
> > >
> > > Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> > > ---
> > > =A0Documentation/hwmon/index.rst=A0=A0 |=A0=A0 1 +
> > > =A0Documentation/hwmon/ltc2991.rst |=A0 43 +++
> > > =A0MAINTAINERS=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 |=A0=A0 8 +
> > > =A0drivers/hwmon/Kconfig=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0 11 +
> > > =A0drivers/hwmon/Makefile=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=A0 1 +
> > > =A0drivers/hwmon/ltc2991.c=A0=A0=A0=A0=A0=A0=A0=A0 | 479
> ++++++++++++++++++++++++++++++++
> > > =A06 files changed, 543 insertions(+)
> > > =A0create mode 100644 Documentation/hwmon/ltc2991.rst
> > > =A0create mode 100644 drivers/hwmon/ltc2991.c
> > >
> > > diff --git a/Documentation/hwmon/index.rst
> b/Documentation/hwmon/index.rst
> > > index 88dadea85cfc..0ec96abe3f7d 100644
> > > --- a/Documentation/hwmon/index.rst
> > > +++ b/Documentation/hwmon/index.rst
> > > @@ -121,6 +121,7 @@ Hardware Monitoring Kernel Drivers
> > > =A0=A0=A0 ltc2947
> > > =A0=A0=A0 ltc2978
> > > =A0=A0=A0 ltc2990
> > > +=A0=A0 ltc2991
> > > =A0=A0=A0 ltc3815
> > > =A0=A0=A0 ltc4151
> > > =A0=A0=A0 ltc4215
> > > diff --git a/Documentation/hwmon/ltc2991.rst
> b/Documentation/hwmon/ltc2991.rst
> > > new file mode 100644
> > > index 000000000000..9ab29dd85012
> > > --- /dev/null
> > > +++ b/Documentation/hwmon/ltc2991.rst
> > > @@ -0,0 +1,43 @@
> > > +.. SPDX-License-Identifier: GPL-2.0
> > > +
> > > +Kernel driver ltc2991
> > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > +
> > > +Supported chips:
> > > +
> > > +=A0 * Analog Devices LTC2991
> > > +
> > > +=A0=A0=A0 Prefix: 'ltc2991'
> > > +
> > > +=A0=A0=A0 Addresses scanned: I2C 0x48 - 0x4f
> > > +
> > > +=A0=A0=A0 Datasheet:
> > > https://www.analog.com/media/en/technical-documentation/data-
> sheets/2991ff.pdf
> > > +
> > > +Authors:
> > > +
> > > +=A0 - Antoniu Miclaus <antoniu.miclaus@analog.com>
> > > +
> > > +
> > > +Description
> > > +-----------
> > > +
> > > +This driver supports hardware monitoring for Analog Devices LTC2991
> Octal I2C
> > > +Voltage, Current and Temperature Monitor.
> > > +
> > > +The LTC2991 is used to monitor system temperatures, voltages and
> currents.
> > > +Through the I2C serial interface, the eight monitors can individuall=
y
> measure
> > > +supply voltages and can be paired for differential measurements of
> current
> > > sense
> > > +resistors or temperature sensing transistors. Additional measurement=
s
> include
> > > +internal temperatureand internal VCC.
> > > +
> > > +
> > > +sysfs-Interface
> > > +-------------
> > > +
> > > +The following attributes are supported. Limits are read-only.
> > > +
> > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > +inX_input:=A0=A0=A0=A0=A0 voltage input
> > > +currX_input:=A0=A0=A0 current input
> > > +tempX_input:=A0=A0=A0 temperature input
> > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index b19995690904..98dd8a8e1f84 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -12451,6 +12451,14 @@ F:=A0=A0=A0=A0=A0drivers/hwmon/ltc2947-i2c.c
> > > =A0F:=A0=A0=A0=A0=A0drivers/hwmon/ltc2947-spi.c
> > > =A0F:=A0=A0=A0=A0=A0drivers/hwmon/ltc2947.h
> > >
> > > +LTC2991 HARDWARE MONITOR DRIVER
> > > +M:=A0=A0=A0=A0=A0Antoniu Miclaus <antoniu.miclaus@analog.com>
> > > +L:=A0=A0=A0=A0=A0linux-hwmon@vger.kernel.org
> > > +S:=A0=A0=A0=A0=A0Supported
> > > +W:=A0=A0=A0=A0=A0https://ez.analog.com/linux-software-drivers
> > > +F:=A0=A0=A0=A0=A0Documentation/devicetree/bindings/hwmon/adi,ltc2991=
.yaml
> > > +F:=A0=A0=A0=A0=A0drivers/hwmon/ltc2991.c
> > > +
> > > =A0LTC2983 IIO TEMPERATURE DRIVER
> > > =A0M:=A0=A0=A0=A0=A0Nuno S=E1 <nuno.sa@analog.com>
> > > =A0L:=A0=A0=A0=A0=A0linux-iio@vger.kernel.org
> > > diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> > > index ec38c8892158..818a67328fcd 100644
> > > --- a/drivers/hwmon/Kconfig
> > > +++ b/drivers/hwmon/Kconfig
> > > @@ -932,6 +932,17 @@ config SENSORS_LTC2990
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0 This driver can also be built as a module=
. If so, the module will
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0 be called ltc2990.
> > >
> > > +config SENSORS_LTC2991
> > > +=A0=A0=A0=A0=A0=A0=A0tristate "Analog Devices LTC2991"
> > > +=A0=A0=A0=A0=A0=A0=A0depends on I2C
> > > +=A0=A0=A0=A0=A0=A0=A0help
> > > +=A0=A0=A0=A0=A0=A0=A0=A0 If you say yes here you get support for Ana=
log Devices LTC2991
> > > +=A0=A0=A0=A0=A0=A0=A0=A0 Octal I2C Voltage, Current, and Temperature=
 Monitor. The LTC2991
> > > +=A0=A0=A0=A0=A0=A0=A0=A0 supports a combination of voltage, current =
and temperature
> > > monitoring.
> > > +
> > > +=A0=A0=A0=A0=A0=A0=A0=A0 This driver can also be built as a module. =
If so, the module will
> > > +=A0=A0=A0=A0=A0=A0=A0=A0 be called ltc2991.
> > > +
> > > =A0config SENSORS_LTC2992
> > > =A0=A0=A0=A0=A0=A0=A0=A0tristate "Linear Technology LTC2992"
> > > =A0=A0=A0=A0=A0=A0=A0=A0depends on I2C
> > > diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> > > index 4ac9452b5430..f324d057535a 100644
> > > --- a/drivers/hwmon/Makefile
> > > +++ b/drivers/hwmon/Makefile
> > > @@ -127,6 +127,7 @@ obj-$(CONFIG_SENSORS_LTC2947)=A0=A0=A0=A0=A0=A0=
=A0+=3D ltc2947-
> core.o
> > > =A0obj-$(CONFIG_SENSORS_LTC2947_I2C) +=3D ltc2947-i2c.o
> > > =A0obj-$(CONFIG_SENSORS_LTC2947_SPI) +=3D ltc2947-spi.o
> > > =A0obj-$(CONFIG_SENSORS_LTC2990)=A0=A0+=3D ltc2990.o
> > > +obj-$(CONFIG_SENSORS_LTC2991)=A0=A0+=3D ltc2991.o
> > > =A0obj-$(CONFIG_SENSORS_LTC2992)=A0=A0+=3D ltc2992.o
> > > =A0obj-$(CONFIG_SENSORS_LTC4151)=A0=A0+=3D ltc4151.o
> > > =A0obj-$(CONFIG_SENSORS_LTC4215)=A0=A0+=3D ltc4215.o
> > > diff --git a/drivers/hwmon/ltc2991.c b/drivers/hwmon/ltc2991.c
> > > new file mode 100644
> > > index 000000000000..b5333c25cb31
> > > --- /dev/null
> > > +++ b/drivers/hwmon/ltc2991.c
> > > @@ -0,0 +1,479 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * Copyright (C) 2023 Analog Devices, Inc.
> > > + * Author: Antoniu Miclaus <antoniu.miclaus@analog.com>
> > > + */
> > > +
> > > +#include <linux/bitops.h>
> > > +#include <linux/err.h>
> > > +#include <linux/hwmon.h>
> > > +#include <linux/hwmon-sysfs.h>
> > > +#include <linux/i2c.h>
> > > +#include <linux/kernel.h>
> > > +#include <linux/module.h>
> > > +#include <linux/property.h>
> > > +#include <linux/regmap.h>
> > > +#include <linux/regulator/consumer.h>
> > > +
> > > +#include <asm/unaligned.h>
> > > +
> > > +#define LTC2991_STATUS_LOW=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A00x0=
0
> > > +#define LTC2991_CH_EN_TRIGGER=A0=A0=A0=A0=A0=A0=A0=A0=A0=A00x01
> > > +#define LTC2991_V1_V4_CTRL=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A00x0=
6
> > > +#define LTC2991_V5_V8_CTRL=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A00x0=
7
> > > +#define LTC2991_PWM_TH_LSB_T_INT=A0=A0=A0=A0=A0=A0=A00x08
> > > +#define LTC2991_PWM_TH_MSB=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A00x0=
9
> > > +#define LTC2991_CHANNEL_V_MSB(x)=A0=A0=A0=A0=A0=A0=A0(0x0A + ((x) * =
2))
> > > +#define LTC2991_CHANNEL_T_MSB(x)=A0=A0=A0=A0=A0=A0=A0(0x0A + ((x) * =
4))
> > > +#define LTC2991_CHANNEL_C_MSB(x)=A0=A0=A0=A0=A0=A0=A0(0x0C + ((x) * =
4))
> > > +#define LTC2991_T_INT_MSB=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A00=
x1A
> > > +#define LTC2991_VCC_MSB=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A00x1C
> > > +
> > > +#define LTC2991_V7_V8_EN=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0BIT(7)
> > > +#define LTC2991_V5_V6_EN=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0BIT(6)
> > > +#define LTC2991_V3_V4_EN=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0BIT(5)
> > > +#define LTC2991_V1_V2_EN=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0BIT(4)
> > > +#define LTC2991_T_INT_VCC_EN=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0BIT(3)
> > > +
> > > +#define LTC2991_V3_V4_FILT_EN=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0BIT(7)
> > > +#define LTC2991_V3_V4_TEMP_EN=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0BIT(5)
> > > +#define LTC2991_V3_V4_DIFF_EN=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0BIT(4)
> > > +#define LTC2991_V1_V2_FILT_EN=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0BIT(3)
> > > +#define LTC2991_V1_V2_TEMP_EN=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0BIT(1)
> > > +#define LTC2991_V1_V2_DIFF_EN=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0BIT(0)
> > > +
> > > +#define LTC2991_V7_V8_FILT_EN=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0BIT(7)
> > > +#define LTC2991_V7_V8_TEMP_EN=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0BIT(5)
> > > +#define LTC2991_V7_V8_DIFF_EN=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0BIT(4)
> > > +#define LTC2991_V5_V6_FILT_EN=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0BIT(7)
> > > +#define LTC2991_V5_V6_TEMP_EN=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0BIT(5)
> > > +#define LTC2991_V5_V6_DIFF_EN=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0BIT(4)
> > > +
> > > +#define LTC2991_REPEAT_ACQ_EN=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0BIT(4)
> > > +#define LTC2991_T_INT_FILT_EN=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0BIT(3)
> > > +
> > > +#define LTC2991_MAX_CHANNEL=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A04
> > > +#define LTC2991_T_INT_CH_NR=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A04
> > > +#define LTC2991_VCC_CH_NR=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A00
> > > +
> > > +static const char *const label_voltages[] =3D {
> > > +=A0=A0=A0=A0=A0=A0=A0"vcc",
> > > +=A0=A0=A0=A0=A0=A0=A0"voltage1",
> > > +=A0=A0=A0=A0=A0=A0=A0"voltage2",
> > > +=A0=A0=A0=A0=A0=A0=A0"voltage3",
> > > +=A0=A0=A0=A0=A0=A0=A0"voltage4",
> > > +=A0=A0=A0=A0=A0=A0=A0"voltage5",
> > > +=A0=A0=A0=A0=A0=A0=A0"voltage6",
> > > +=A0=A0=A0=A0=A0=A0=A0"voltage7",
> > > +=A0=A0=A0=A0=A0=A0=A0"voltage8"
> > > +};
> > > +
> > > +static const char *const label_temp[] =3D {
> > > +=A0=A0=A0=A0=A0=A0=A0"t1",
> > > +=A0=A0=A0=A0=A0=A0=A0"t2",
> > > +=A0=A0=A0=A0=A0=A0=A0"t3",
> > > +=A0=A0=A0=A0=A0=A0=A0"t4",
> > > +=A0=A0=A0=A0=A0=A0=A0"t_int"
> > > +};
> > > +
> > > +static const char *const label_curr[] =3D {
> > > +=A0=A0=A0=A0=A0=A0=A0"v1-v2",
> > > +=A0=A0=A0=A0=A0=A0=A0"v3-v4",
> > > +=A0=A0=A0=A0=A0=A0=A0"v5-v6",
> > > +=A0=A0=A0=A0=A0=A0=A0"v7-v8"
> > > +};
> > > +
> > > +struct ltc2991_state {
> > > +=A0=A0=A0=A0=A0=A0=A0struct i2c_client=A0=A0=A0=A0=A0=A0=A0*client;
> > > +=A0=A0=A0=A0=A0=A0=A0struct regmap=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0*=
regmap;
> > > +=A0=A0=A0=A0=A0=A0=A0u32=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0r_sense_uohm[LTC2991_MAX_CHANNEL];
> > > +=A0=A0=A0=A0=A0=A0=A0bool=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0temp_en[LTC2991_MAX_CHANNEL];
> > > +};
> > > +
> > > +static int ltc2991_read_reg(struct ltc2991_state *st, u8 addr, u8 re=
g_len,
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 int *val)
> > > +{
> > > +=A0=A0=A0=A0=A0=A0=A0u8 regvals[2];
> > > +=A0=A0=A0=A0=A0=A0=A0int ret;
> > > +
> > > +=A0=A0=A0=A0=A0=A0=A0if (reg_len > 2 || !reg_len)
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return -EINVAL;
> > > +
> >
> > IMO, this is too much checking... It's an internal API, just make sure =
to
> > properly call it ;).
> >
> > > +=A0=A0=A0=A0=A0=A0=A0ret =3D regmap_bulk_read(st->regmap, addr, regv=
als, reg_len);
> > > +=A0=A0=A0=A0=A0=A0=A0if (ret)
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return ret;
> > > +
> > > +=A0=A0=A0=A0=A0=A0=A0if (reg_len =3D=3D 2)
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0*val =3D get_unaligned_=
be16(&regvals[0]);
> > > +=A0=A0=A0=A0=A0=A0=A0else
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0*val =3D regvals[0];
> >
> > not what I had in mind. Having unaligned access is overkill when you ca=
n go
> with
> > typical __be16 + __be16_to_cpu(). If I'm not missing anything, you just
> have to
> > shift out the LSB in case of 1byte registers. Alternatively, before the=
 bulk()
> > call you can:
> >
> > if (reg_len < 2)
> >     return regmap_read();
> >
> > and then just assume 2 byte reads...
> >
> > > +=A0=A0=A0=A0=A0=A0=A0return 0;
> > > +}
> > > +
> > > +static int ltc2991_get_voltage(struct ltc2991_state *st, u32 reg, lo=
ng
> *val)
> > > +{
> > > +=A0=A0=A0=A0=A0=A0=A0int reg_val, ret, offset =3D 0;
> > > +
> > > +=A0=A0=A0=A0=A0=A0=A0ret =3D ltc2991_read_reg(st, reg, 2, &reg_val);
> > > +=A0=A0=A0=A0=A0=A0=A0if (ret)
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return ret;
> > > +
> > > +=A0=A0=A0=A0=A0=A0=A0if (reg =3D=3D LTC2991_VCC_MSB)
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0/* Vcc 2.5V offset */
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0offset =3D 2500;
> > > +
> > > +=A0=A0=A0=A0=A0=A0=A0/* Vx, 305.18uV/LSB */
> > > +=A0=A0=A0=A0=A0=A0=A0*val =3D DIV_ROUND_CLOSEST(sign_extend32(reg_va=
l, 14) * 30518,
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 1000 * 100) + offset;
> > > +
> > > +=A0=A0=A0=A0=A0=A0=A0return 0;
> > > +}
> > > +
> > > +static int ltc2991_read_in(struct device *dev, u32 attr, int channel=
, long
> > > *val)
> > > +{
> > > +=A0=A0=A0=A0=A0=A0=A0struct ltc2991_state *st =3D dev_get_drvdata(de=
v);
> > > +=A0=A0=A0=A0=A0=A0=A0u32 reg;
> > > +
> > > +=A0=A0=A0=A0=A0=A0=A0switch (attr) {
> > > +=A0=A0=A0=A0=A0=A0=A0case hwmon_in_input:
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if (channel =3D=3D LTC2=
991_VCC_CH_NR)
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0reg =3D LTC2991_VCC_MSB;
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0else
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0reg =3D LTC2991_CHANNEL_V_MSB(channel - 1);
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0break;
> > > +=A0=A0=A0=A0=A0=A0=A0default:
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return -EOPNOTSUPP;
> > > +=A0=A0=A0=A0=A0=A0=A0}
> > > +
> > > +=A0=A0=A0=A0=A0=A0=A0return ltc2991_get_voltage(st, reg, val);
> > > +}
> > > +
> > > +static int ltc2991_get_curr(struct ltc2991_state *st, u32 reg, int c=
hannel,
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 long *val)
> > > +{
> > > +=A0=A0=A0=A0=A0=A0=A0int reg_val, ret;
> > > +
> > > +=A0=A0=A0=A0=A0=A0=A0ret =3D ltc2991_read_reg(st, reg, 2, &reg_val);
> > > +=A0=A0=A0=A0=A0=A0=A0if (ret)
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return ret;
> > > +
> > > +=A0=A0=A0=A0=A0=A0=A0/* Vx-Vy, 19.075uV/LSB */
> > > +=A0=A0=A0=A0=A0=A0=A0*val =3D DIV_ROUND_CLOSEST(sign_extend32(reg_va=
l, 14) * 19075,
> 1000)
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 / (st->r_sense_uohm[channel] / 1000);
> > > +
> > > +=A0=A0=A0=A0=A0=A0=A0return 0;
> > > +}
> > > +
> > > +static int ltc2991_read_curr(struct device *dev, u32 attr, int chann=
el,
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 long *val)
> > > +{
> > > +=A0=A0=A0=A0=A0=A0=A0struct ltc2991_state *st =3D dev_get_drvdata(de=
v);
> > > +=A0=A0=A0=A0=A0=A0=A0u32 reg;
> > > +
> > > +=A0=A0=A0=A0=A0=A0=A0switch (attr) {
> > > +=A0=A0=A0=A0=A0=A0=A0case hwmon_curr_input:
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0reg =3D LTC2991_CHANNEL=
_C_MSB(channel);
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return ltc2991_get_curr=
(st, reg, channel, val);
> > > +=A0=A0=A0=A0=A0=A0=A0default:
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return -EOPNOTSUPP;
> > > +=A0=A0=A0=A0=A0=A0=A0}
> > > +}
> > > +
> > > +static int ltc2991_get_temp(struct ltc2991_state *st, u32 reg, int
> channel,
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 long *val)
> > > +{
> > > +=A0=A0=A0=A0=A0=A0=A0int reg_val, ret;
> > > +
> > > +=A0=A0=A0=A0=A0=A0=A0ret =3D ltc2991_read_reg(st, reg, 2, &reg_val);
> > > +=A0=A0=A0=A0=A0=A0=A0if (ret)
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return ret;
> > > +
> > > +=A0=A0=A0=A0=A0=A0=A0/* Temp LSB =3D 0.0625 Degrees */
> > > +=A0=A0=A0=A0=A0=A0=A0*val =3D DIV_ROUND_CLOSEST(sign_extend32(reg_va=
l, 12) * 1000, 16);
> > > +
> > > +=A0=A0=A0=A0=A0=A0=A0return 0;
> > > +}
> > > +
> > > +static int ltc2991_read_temp(struct device *dev, u32 attr, int chann=
el,
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 long *val)
> > > +{
> > > +=A0=A0=A0=A0=A0=A0=A0struct ltc2991_state *st =3D dev_get_drvdata(de=
v);
> > > +=A0=A0=A0=A0=A0=A0=A0u32 reg;
> > > +
> > > +=A0=A0=A0=A0=A0=A0=A0switch (attr) {
> > > +=A0=A0=A0=A0=A0=A0=A0case hwmon_temp_input:
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if (channel =3D=3D LTC2=
991_T_INT_CH_NR)
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0reg =3D LTC2991_T_INT_MSB;
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0else
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0reg =3D LTC2991_CHANNEL_T_MSB(channel);
> > > +
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return ltc2991_get_temp=
(st, reg, channel, val);
> > > +=A0=A0=A0=A0=A0=A0=A0default:
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return -EOPNOTSUPP;
> > > +=A0=A0=A0=A0=A0=A0=A0}
> > > +}
> > > +
> > > +static int ltc2991_read(struct device *dev, enum hwmon_sensor_types
> type,
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0u32 attr, int channel, long *val)
> > > +{
> > > +=A0=A0=A0=A0=A0=A0=A0switch (type) {
> > > +=A0=A0=A0=A0=A0=A0=A0case hwmon_in:
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return ltc2991_read_in(=
dev, attr, channel, val);
> > > +=A0=A0=A0=A0=A0=A0=A0case hwmon_curr:
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return ltc2991_read_cur=
r(dev, attr, channel, val);
> > > +=A0=A0=A0=A0=A0=A0=A0case hwmon_temp:
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return ltc2991_read_tem=
p(dev, attr, channel, val);
> > > +=A0=A0=A0=A0=A0=A0=A0default:
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return -EOPNOTSUPP;
> > > +=A0=A0=A0=A0=A0=A0=A0}
> > > +}
> > > +
> > > +static umode_t ltc2991_is_visible(const void *data,
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 enum hwmon_sensor_types type, u32 attr,
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 int channel)
> > > +{
> > > +=A0=A0=A0=A0=A0=A0=A0const struct ltc2991_state *st =3D data;
> > > +
> > > +=A0=A0=A0=A0=A0=A0=A0switch (type) {
> > > +=A0=A0=A0=A0=A0=A0=A0case hwmon_in:
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0switch (attr) {
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0case hwmon_in_input:
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0case hwmon_in_label:
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0return 0444;
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0}
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0break;
> > > +=A0=A0=A0=A0=A0=A0=A0case hwmon_curr:
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0switch (attr) {
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0case hwmon_curr_input:
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0case hwmon_curr_label:
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0if (st->r_sense_uohm[channel])
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0return 0444;
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0break;
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0}
> >
> > This is what I was speaking about... You should go read again v1 an try=
 to
> > understand the points made or continue the discussion.
> >
> > I didn't looked at the datasheet but what I understood from Guenter is =
that
> each
> > channel can only be a specific type of sensor and you should be explici=
t
> about
> > that (not using rsense as the deciding factor). Thus, your bindings sho=
uld
> > likely be refactored so you have a property that explicitly "defines" a
> channel
> > (not forgetting to handle things like differential channels and overlap=
s
> etc...)
> > and then you need to reflect the ABI according to what sensors OF/ACPI
> have
> > defined.
> >
> > This looks a bit like the ltc2983 [1] I upstreamed where most of the fu=
n was
> in
> > defining the channels (and maybe that one was actually an hwmon driver
> but what
> > did I know back then :))
> >
> > Also important is that in absence of OF/ACPI, you should read whatever
> > configuration is the device holding so, once again, you export the corr=
ect
> ABI.
> > But in this case, I'm not really sure what would be a sane (if there's =
one) for
> > rsense in case of a current sensor.
> >
> > Hopefully I got it right...
> >
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0break;
> > > +=A0=A0=A0=A0=A0=A0=A0case hwmon_temp:
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0switch (attr) {
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0case hwmon_temp_input:
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0case hwmon_temp_label:
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0if (st->temp_en[channel] ||
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 channel =3D=3D LTC2991_T_INT_CH_NR)
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0return 0444;
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0break;
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0}
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0break;
> > > +=A0=A0=A0=A0=A0=A0=A0default:
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0break;
> > > +=A0=A0=A0=A0=A0=A0=A0}
> > > +
> > > +=A0=A0=A0=A0=A0=A0=A0return 0;
> > > +}
> > > +
> > > +static int ltc2991_read_string(struct device *dev, enum
> hwmon_sensor_types
> > > type,
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 u32 attr, int channel, const char **str)
> > > +{
> > > +=A0=A0=A0=A0=A0=A0=A0switch (type) {
> > > +=A0=A0=A0=A0=A0=A0=A0case hwmon_temp:
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0*str =3D label_temp[cha=
nnel];
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0break;
> > > +=A0=A0=A0=A0=A0=A0=A0case hwmon_curr:
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0*str =3D label_curr[cha=
nnel];
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0break;
> > > +=A0=A0=A0=A0=A0=A0=A0case hwmon_in:
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0*str =3D label_voltages=
[channel];
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0break;
> > > +=A0=A0=A0=A0=A0=A0=A0default:
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return -EOPNOTSUPP;
> > > +=A0=A0=A0=A0=A0=A0=A0}
> > > +
> > > +=A0=A0=A0=A0=A0=A0=A0return 0;
> > > +}
> > > +
> > > +static const struct hwmon_ops ltc2991_hwmon_ops =3D {
> > > +=A0=A0=A0=A0=A0=A0=A0.is_visible =3D ltc2991_is_visible,
> > > +=A0=A0=A0=A0=A0=A0=A0.read =3D ltc2991_read,
> > > +=A0=A0=A0=A0=A0=A0=A0.read_string =3D ltc2991_read_string,
> > > +};
> > > +
> > > +static const struct hwmon_channel_info *ltc2991_info[] =3D {
> > > +=A0=A0=A0=A0=A0=A0=A0HWMON_CHANNEL_INFO(temp,
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 HWMON_T_INPUT | HWMON_T_LABEL,
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 HWMON_T_INPUT | HWMON_T_LABEL,
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 HWMON_T_INPUT | HWMON_T_LABEL,
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 HWMON_T_INPUT | HWMON_T_LABEL,
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 HWMON_T_INPUT | HWMON_T_LABEL
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 ),
> > > +=A0=A0=A0=A0=A0=A0=A0HWMON_CHANNEL_INFO(curr,
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 HWMON_C_INPUT | HWMON_C_LABEL,
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 HWMON_C_INPUT | HWMON_C_LABEL,
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 HWMON_C_INPUT | HWMON_C_LABEL,
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 HWMON_C_INPUT | HWMON_C_LABEL
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 ),
> > > +=A0=A0=A0=A0=A0=A0=A0HWMON_CHANNEL_INFO(in,
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 HWMON_I_INPUT | HWMON_I_LABEL,
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 HWMON_I_INPUT | HWMON_I_LABEL,
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 HWMON_I_INPUT | HWMON_I_LABEL,
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 HWMON_I_INPUT | HWMON_I_LABEL,
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 HWMON_I_INPUT | HWMON_I_LABEL,
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 HWMON_I_INPUT | HWMON_I_LABEL,
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 HWMON_I_INPUT | HWMON_I_LABEL,
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 HWMON_I_INPUT | HWMON_I_LABEL,
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 HWMON_I_INPUT | HWMON_I_LABEL
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 ),
> > > +=A0=A0=A0=A0=A0=A0=A0NULL
> > > +};
> > > +
> > > +static const struct hwmon_chip_info ltc2991_chip_info =3D {
> > > +=A0=A0=A0=A0=A0=A0=A0.ops =3D &ltc2991_hwmon_ops,
> > > +=A0=A0=A0=A0=A0=A0=A0.info =3D ltc2991_info,
> > > +};
> > > +
> > > +static const struct regmap_config ltc2991_regmap_config =3D {
> > > +=A0=A0=A0=A0=A0=A0=A0.reg_bits =3D 8,
> > > +=A0=A0=A0=A0=A0=A0=A0.val_bits =3D 8,
> > > +=A0=A0=A0=A0=A0=A0=A0.max_register =3D 0x1D,
> > > +};
> > > +
> > > +static int ltc2991_init(struct ltc2991_state *st)
> > > +{
> > > +=A0=A0=A0=A0=A0=A0=A0struct fwnode_handle *child;
> > > +=A0=A0=A0=A0=A0=A0=A0int ret;
> > > +=A0=A0=A0=A0=A0=A0=A0u32 val, addr;
> > > +=A0=A0=A0=A0=A0=A0=A0u8 v5_v8_reg_data =3D 0, v1_v4_reg_data =3D 0;
> > > +
> > > +=A0=A0=A0=A0=A0=A0=A0ret =3D devm_regulator_get_enable(&st->client->=
dev, "vcc");
> > > +=A0=A0=A0=A0=A0=A0=A0if (ret)
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return dev_err_probe(&s=
t->client->dev, ret,
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "failed to enable regulator\n");
> > > +
> > > +=A0=A0=A0=A0=A0=A0=A0device_for_each_child_node(&st->client->dev, ch=
ild) {
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0ret =3D fwnode_property=
_read_u32(child, "reg", &addr);
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if (ret < 0) {
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0fwnode_handle_put(child);
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0return ret;
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0}
> > > +
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if (addr > 3) {
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0fwnode_handle_put(child);
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0return -EINVAL;
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0}
> > > +
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0ret =3D fwnode_property=
_read_u32(child, "shunt-resistor-micro-
> > > ohms", &val);
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if (!ret) {
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0st->r_sense_uohm[addr] =3D val;
> >
> > This still allows 0 as a valid value which would lead to a divide by 0
> > exception...
> >
> > [1]: https://urldefense.com/v3/__https://elixir.bootlin.com/linux/v6.6-
> rc5/source/drivers/iio/temperature/ltc2983.c*L1371__;Iw!!A3Ni8CS0y2Y!7K
> woudmzAsHvuDAbhjSNiwM0gCzmfIMYzwFrV2pm7XJTQe7WmW2uioGLsZKt
> PXKk5IKWSMN0yDWCca5NCvWZ$
> >
> > - Nuno S=E1
> >
