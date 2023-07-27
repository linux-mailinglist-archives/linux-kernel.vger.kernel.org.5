Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13448764E37
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 10:54:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234153AbjG0Iyl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 04:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234124AbjG0IyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 04:54:17 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51FA9618A;
        Thu, 27 Jul 2023 01:35:27 -0700 (PDT)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36R76NDT027825;
        Thu, 27 Jul 2023 04:34:47 -0400
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3s36afn2g2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jul 2023 04:34:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JlBtZcSYPDEO/y2yiyRbJboDuajUzsIwW9LFhwmZl7FUfgC2EFkz+phYwHh5Amiq/BtYPz+LwiAd7Ict1Jeej2RASEIE8XFnc67IQAF3vAwVPAfPBJX7YH73zSzKJVl+Zn24TLHukV0v9Fe1/E/KoZSVIVFSfF0e/S2QO5MQB0+adqjZbAR/0/AhuLdBdrLDlLdwkDeJeWg7E+prXQk6uio4yFkJqUwhzeTwSInOwdIJYnntbFf9/y+AZbzf5Gw4mAezUDHukk9ASPe1s2TVKO78M2Futmj8KPSK7u5XgV+WvEA5eI7in4fPl89e0J78Zhge8+xgDmZ2h5fqmCCbTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lI3WVBqtBgCyspxFtNQeN9xGr6Z/YOZ/3NJfURThKkc=;
 b=EXOryqIMlrlB1dEboutzZAhTUI+KfbWDLFT/5dH/MbMQKRkm0Qvp+kC6jabkjgqwuERK35lqz5ZoTAGGIH/cwCnCjO50zgz7Ud5UU+kPUw5RMcJOulL9Wj1etLxns0z8b0ca1yks05kZ9sRLtyBEwFi70IwH1mJSLXc7P7KJxVFf95EnOMfGg2uziC+CL44HiSgoO0+zm0NYq1jUcEyrmMEjaMqPOVQt2H6g6k+gzyiTPVdLRr4eMMIXkRIO1yzvxXiuuoDZOAO/RUiklyYoFmK69ew8ZspiAYZRjsj+if+KAnKZBXxYJcpfOPZ6w+5ekYzGNh1YOHslYMslByKKaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lI3WVBqtBgCyspxFtNQeN9xGr6Z/YOZ/3NJfURThKkc=;
 b=p7qTuh2TBGtDqSrIUzglHOe88/zlqVyfL3GXKQYz2PBnNxVvlKV+DDx8SAEg5jSWUyQYDusE8MGsxpbk2vmgWbEyw1/CUPy+Ubl6Ummnc0h/KNIl6vY84/vKf9IZuJNbpka/mbDO7bPMWmUNpO0bpPLnELdwFivaw1X2Q9l9Wqo=
Received: from PH7PR03MB7391.namprd03.prod.outlook.com (2603:10b6:510:2e6::5)
 by SJ0PR03MB6359.namprd03.prod.outlook.com (2603:10b6:a03:399::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 08:34:45 +0000
Received: from PH7PR03MB7391.namprd03.prod.outlook.com
 ([fe80::2adc:1975:dfe2:776c]) by PH7PR03MB7391.namprd03.prod.outlook.com
 ([fe80::2adc:1975:dfe2:776c%3]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 08:34:44 +0000
From:   "Sahin, Okan" <Okan.Sahin@analog.com>
To:     Nathan Chancellor <nathan@kernel.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "zzzzTilki, zzzzIbrahim" <Ibrahim.Tilki@analog.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>
Subject: RE: [PATCH v3 2/2] regulator: max77857: Add ADI MAX77857/59/MAX77831
 Regulator Support
Thread-Topic: [PATCH v3 2/2] regulator: max77857: Add ADI MAX77857/59/MAX77831
 Regulator Support
Thread-Index: AQHZuGy8mN9TLCcuJkyLQ19F8fkBDa+/r5IAgAyW/YCAARHLsA==
Date:   Thu, 27 Jul 2023 08:34:44 +0000
Message-ID: <PH7PR03MB739122A373964651D995EA5AE701A@PH7PR03MB7391.namprd03.prod.outlook.com>
References: <20230717050736.10075-1-okan.sahin@analog.com>
 <20230717050736.10075-3-okan.sahin@analog.com>
 <20230718155502.GA3542993@dev-arch.thelio-3990X>
 <20230726161033.GA1102409@dev-arch.thelio-3990X>
In-Reply-To: <20230726161033.GA1102409@dev-arch.thelio-3990X>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcb2thbi5zYWhp?=
 =?us-ascii?Q?blxhcHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4?=
 =?us-ascii?Q?NGJhMjllMzViXG1zZ3NcbXNnLTZkN2ZiM2FjLTJjNTgtMTFlZS1iZjAwLTU4?=
 =?us-ascii?Q?NmMyNWQzYzNlNFxhbWUtdGVzdFw2ZDdmYjNhZS0yYzU4LTExZWUtYmYwMC01?=
 =?us-ascii?Q?ODZjMjVkM2MzZTRib2R5LnR4dCIgc3o9IjU4MTAiIHQ9IjEzMzM0OTIwNDgx?=
 =?us-ascii?Q?MDk3NTk2NCIgaD0ieUY5UDVvYW5BZFNzNlduNVYwSFZRUExZMUZVPSIgaWQ9?=
 =?us-ascii?Q?IiIgYmw9IjAiIGJvPSIxIiBjaT0iY0FBQUFFUkhVMVJTUlVGTkNnVUFBRW9D?=
 =?us-ascii?Q?QUFEY3l0WXZaY0RaQVFTNi9GYXVFU3FQQkxyOFZxNFJLbzhEQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUhBQUFBRGFBUUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUVBQVFBQkFBQUF2ZGhreGdBQUFBQUFBQUFBQUFBQUFKNEFBQUJoQUdR?=
 =?us-ascii?Q?QWFRQmZBSE1BWlFCakFIVUFjZ0JsQUY4QWNBQnlBRzhBYWdCbEFHTUFkQUJ6?=
 =?us-ascii?Q?QUY4QVpnQmhBR3dBY3dCbEFGOEFaZ0J2QUhNQWFRQjBBR2tBZGdCbEFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBRUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFHRUFaQUJwQUY4QWN3QmxBR01B?=
 =?us-ascii?Q?ZFFCeUFHVUFYd0J3QUhJQWJ3QnFBR1VBWXdCMEFITUFYd0IwQUdrQVpRQnlB?=
 =?us-ascii?Q?REVBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQVFBQUFBQUFBQUFD?=
 =?us-ascii?Q?QUFBQUFBQ2VBQUFBWVFCa0FHa0FYd0J6QUdVQVl3QjFBSElBWlFCZkFIQUFj?=
 =?us-ascii?Q?Z0J2QUdvQVpRQmpBSFFBY3dCZkFIUUFhUUJsQUhJQU1nQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUE9PSIvPjwv?=
 =?us-ascii?Q?bWV0YT4=3D?=
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR03MB7391:EE_|SJ0PR03MB6359:EE_
x-ms-office365-filtering-correlation-id: a7b368e0-0664-4254-60bd-08db8e7c5474
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8Xl5vPQL/pMWembLrTI64bvz99IjHAZszxEvdV1hxyl3dwD42aDGTAhDlr6WnQtytfC0yti7lXeFDvbx1uiB4q9IrBm0ehqO+59l7kUrDO6BJC2G/VZPq1HkhXUD8WQkh7uYilN+NJ2/CDrFx0ytDPJAVoAUZKNsq5w1febNa/AS9UbgF8Iign6R7eJrjE0qtdNWbXXwftB31AppqKqVM3+kZ7LH2hZKRxiKxnJMEesPL42e6EORWq/Z5eQBYYiMAW/gmSMWjigpp88XlYVrm9Aw8ByE+rhYQJDcsZXcIsJgdBalj12YQgvd13Znf5fHEPA3DvGCr2OMevo38+vu2gRWlvb/n2jGpDgdAbGuMD9up00cyXr/fX2PBaWor2G5OcqvS52h8UI7FOJf0dNhRwLDozJtjPAdXzEzkj04ZXxBrwpIbVcBvEOCnI5YL9oLwPoeDjMVGBiCnssc+BVCrefXy++WVXe/RxHymgOdJkS3mYj3pexF5t115Fm+lLhMG3TolBgNJPRDlmt11TSHROFduPy6lp13ewRGR82SGaKJ58Dl1fbFH9sfFgWd6JENev4CHZj/rsA/sVSMW72kvW424L3TAugZfoUQfGjj0XE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR03MB7391.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(376002)(39860400002)(346002)(136003)(451199021)(26005)(478600001)(9686003)(7696005)(71200400001)(54906003)(64756008)(66446008)(6916009)(66946007)(76116006)(4326008)(66556008)(66476007)(41300700001)(83380400001)(52536014)(5660300002)(186003)(8936002)(8676002)(122000001)(2906002)(6506007)(38100700002)(38070700005)(86362001)(33656002)(316002)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?iMdTO0okfz4oP0FiAQkm/GTWaVElkUpg4er5OuOcPjP4aGd7/xAl06qLNf1T?=
 =?us-ascii?Q?0tv8xS8DTmvcMztUbInot8QcbYxzgp9/26xyyfSkkn5tkmbpIpPKeSNFXks3?=
 =?us-ascii?Q?3sFcxUMcEbB+3nIYhSuMnSjxFJygSWBY1jlyaYt5kS1RJSGn5fi/G4+PFnet?=
 =?us-ascii?Q?JhguSYVa0YEgbEkTfy/I52nABiZN6uDPI5LoHNf7TarxGA5DcsvOIT3ppMyO?=
 =?us-ascii?Q?taSYEsp2iMRYIg2s88hgYjTYxrY1L9EGOV+v4vB6Zyx99yjcCP1mZy8t15Tb?=
 =?us-ascii?Q?zbphzJablTJdmSD7piPJj3DCIysFpth17wraOSqnifr8mdtz+O4otFtwqY5c?=
 =?us-ascii?Q?1H3nPp8kGUbuy9EM4WG3/Nc8O88gjT8cWW/BIYI9BksRYrrNAltcJvm27cEx?=
 =?us-ascii?Q?xhxPfdrS9sn6zEeILFq9okvaVFmz9deRtNhY1TheVzDX7PrLbAXOiBcCGpNt?=
 =?us-ascii?Q?PY88hJCTuhOdH4YoMvdDRB4E2SE7Wgwlv63MzeNBFSxYUFXV2+mGGH6zBSKa?=
 =?us-ascii?Q?ZJt28ktGfJD6hprTybJd7G6i43ZxzQQuTXYeynbAkvoWa8qKFlWpI8KIMMUl?=
 =?us-ascii?Q?z5zwEZv/I7tousoKaKEsNkr/9b+o3gt8tSnPM+1IF1b/GjFNsHWAHdeX6AB+?=
 =?us-ascii?Q?ICBdYu7f7VbOA7RJC3yTAk73LRAN79/U2j4My0AtITj5V3FQZg7I8AS37pbG?=
 =?us-ascii?Q?3o6CDF/UvtX5lbC53tTBIw5zFkaYIWnotlhzHrjKV9oUPC4Pcq4dQRSBdJTd?=
 =?us-ascii?Q?Xsya8lqmDUzKYex+qlll8Lfun8yooza/eEMf467QjqXnprT+GPr2+Sa2YIC/?=
 =?us-ascii?Q?FTeKyYs255GGy/c6lFOAn0V8G5gnI0SOw5UzDvM4GJCTx9T3sMMRwKD4ZgvN?=
 =?us-ascii?Q?/eOjSRa69pq6PI6vjOO1gETLpZsVR5vh9h+HzJb9SvQDwLht3m8+mLBcbJB6?=
 =?us-ascii?Q?OqOakD2y0q+7mrNC7MPeIIhWgoRktDbFeP8XIR8TcEm8WhXyIzBNgwKHrgYd?=
 =?us-ascii?Q?Dq2IwFmXuhZJQPvQfEErRJGXwfcvpOGf8pjDBCqcaYjh8TXFUfNhrQ69wNYW?=
 =?us-ascii?Q?storYFp/nlb9XEYCY+RhV/eVQ2HJ1MrckmgE2X0359BT0eA699qMDtm+SIp4?=
 =?us-ascii?Q?DxBs9deSa6JVUEx8PrMe8+qvgjs6D4i4h2uyWq5555Zdt79BOicWQ6b6B0hf?=
 =?us-ascii?Q?QDHLAOYuNE+GsdlUZUU4unVbpJt7rcylaY4Wm8UqG7sn8Vx6jQaSJ3mZU4/Y?=
 =?us-ascii?Q?1EwqzKmR08l6jFYFIXfRFSVVuPEiYGu6GAy6u9I+TQEOfuD2imK/7Eqrte/M?=
 =?us-ascii?Q?XvJgF0Q+pqE+LB2mIT9tQWfnUZM8rwO3cDrDSx++xR3aQNdlqYXzplL1AomD?=
 =?us-ascii?Q?QDCsYP1g2/sXwm0GhQgHvYGlAviAn1/8QxI6gbJv4ta4TsHMkWLtZ+YkrxO2?=
 =?us-ascii?Q?aOqeEoRquGW9nNxyP+Z7E/IiifW2PQb8VTXu12Nkr2KItD7bHsfL8PqSdD5e?=
 =?us-ascii?Q?LAOw6zxZ6QDbb4wFKHxUeBHbSDeB2zu0HppXYCbd3utrNHrqZBnUweGTqI4R?=
 =?us-ascii?Q?ytMsKb+BqeI3c2knwwP6G5SVLlgbHmpDRRPebqII?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7391.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7b368e0-0664-4254-60bd-08db8e7c5474
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2023 08:34:44.6827
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E1BGtpTk3sJBL45rpC6FJlUFQoNeoiw2149txFGXd3XCZtgMKxB6RmEhZORdTK3WvxtuhPgwrE5wmsa8EvUDhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB6359
X-Proofpoint-GUID: cBQ6cRJdl21C5PWPDogxo2DnVT4BYcxR
X-Proofpoint-ORIG-GUID: cBQ6cRJdl21C5PWPDogxo2DnVT4BYcxR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-26_08,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 phishscore=0 suspectscore=0 mlxscore=0 bulkscore=0
 mlxlogscore=999 clxscore=1011 spamscore=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307270075
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>-----Original Message-----
>From: Nathan Chancellor <nathan@kernel.org>
>Sent: Wednesday, July 26, 2023 7:11 PM
>To: Sahin, Okan <Okan.Sahin@analog.com>
>Cc: Liam Girdwood <lgirdwood@gmail.com>; Mark Brown <broonie@kernel.org>;
>Rob Herring <robh+dt@kernel.org>; Krzysztof Kozlowski
><krzysztof.kozlowski+dt@linaro.org>; Conor Dooley <conor+dt@kernel.org>;
>zzzzTilki, zzzzIbrahim <Ibrahim.Tilki@analog.com>; linux-kernel@vger.kerne=
l.org;
>devicetree@vger.kernel.org; llvm@lists.linux.dev
>Subject: Re: [PATCH v3 2/2] regulator: max77857: Add ADI MAX77857/59/MAX77=
831
>Regulator Support
>
>[External]
>
>Hi Okan,
>
>On Tue, Jul 18, 2023 at 08:55:02AM -0700, Nathan Chancellor wrote:
>
><snip>
>
>> > +static struct regulator_desc max77857_regulator_desc =3D {
>> > +	.ops =3D &max77857_regulator_ops,
>> > +	.name =3D "max77857",
>> > +	.linear_ranges =3D max77857_lin_ranges,
>> > +	.n_linear_ranges =3D ARRAY_SIZE(max77857_lin_ranges),
>> > +	.vsel_mask =3D 0xFF,
>> > +	.vsel_reg =3D MAX77857_REG_CONT2,
>> > +	.ramp_delay_table =3D max77857_ramp_table[0],
>> > +	.n_ramp_values =3D ARRAY_SIZE(max77857_ramp_table[0]),
>> > +	.ramp_reg =3D MAX77857_REG_CONT3,
>> > +	.ramp_mask =3D GENMASK(1, 0),
>> > +	.ramp_delay =3D max77857_ramp_table[0][0],
>>
>> This breaks the build with GCC 5.x through 7.x:
>>
>>   drivers/regulator/max77857-regulator.c:312:16: error: initializer elem=
ent is not
>constant
>>     .ramp_delay =3D max77857_ramp_table[0][0],
>>                   ^~~~~~~~~~~~~~~~~~~
>>   drivers/regulator/max77857-regulator.c:312:16: note: (near initializat=
ion for
>'max77857_regulator_desc.ramp_delay')
>>
>> and clang:
>>
>>   drivers/regulator/max77857-regulator.c:312:16: error: initializer elem=
ent is not a
>compile-time constant
>>     312 |         .ramp_delay =3D max77857_ramp_table[0][0],
>>         |                       ^~~~~~~~~~~~~~~~~~~~~~~~~
>>   1 error generated.
>>
>> This relies on a GCC 8.x+ change that accepts more things as
>> compile-time constants, which is being worked on in clang
>>
>(https://urldefense.com/v3/__https://reviews.llvm.org/D76096__;!!A3Ni8CS0y=
2Y!7B
>eWxuzHgLzOprQA_madbvdR7hd0ZgmS73lUlDbgoxWUFWdDSIRXLnhyqLeRhu3uTaqpS
>kzZKwc5pHA$ ). Since the kernel supports older
>> compilers, this will have to be worked around somehow. Perhaps a define
>> that can be used in both places?
>
>Was there any update on this? I do not mind sending a patch for this
>myself if I have some sort of guidance on how you would prefer for this
>to be fixed, should you be too busy to look into it.
>
>Cheers,
>Nathan

Hi Nathan,

I thought that I should fix this issue after merging main branch that's why=
 I did not send patch.
I sent patch v3 so should I send new patch as v4?

Regards,
Okan Sahin
