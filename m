Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6B8D7CC512
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 15:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343822AbjJQNrD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 09:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234843AbjJQNrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 09:47:01 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C602EA;
        Tue, 17 Oct 2023 06:46:57 -0700 (PDT)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 39HDMubQ028554;
        Tue, 17 Oct 2023 09:46:57 -0400
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3ts569r4nd-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Oct 2023 09:46:56 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UJ9c+04FuL8U+G9ueGtGDv1SuhJgEQSKDPoUILZec66JmrARYc+yJm5RDf/U3NapQRjLKEYBvvRLLjSjCZ8Y/nPUUIzDt2nl/BWu57f65P0yzD0yp2X+tLgjcKk9oa78JaDoulWvKO2LFuuvlialPwpVfe8E4VoOllIJIEFIbcPzmNBVigUqr94wfVsGVHNUqiQabr1yJ+MfwASCPor4kyhaPeqMMvjHh7RFaAm8LJ/5xjvMeiUbWL8MtwnnKWik5bJvpTnLLlPVpQxU7it+tXJWx+5DY3WbKdiRjx1oRGx/I+nl80a4vSvOeBZOXsv50rU3qBukvIPYc+bi6bPAcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HaDJOsQcD35SBVdCghlQ+WI/eAEj2GLZO8iGM8x/sNo=;
 b=Gv8pHfLXzFYzO/x8K16qH8Bp94ucJEyqaHFfJZKygCx3dtiPZ9ZBk0s8HD6EasHZxg7TRytRUyHkc086QQZEUKqlosHENnRMjVYOKCchcvcjpHxY3C4ztAXQ7XJasf6nnjGK11j0ex7RBB+MZgGMXKalpTfJe+91js/WG87J/loUQwuj36rRJli6nNdkxYo/jVcz/Cfp1LETlB7KzjiYEdcr3PbNaGI05NxFoLss00dEOZG8GLDu76r2fpCRoiwLKkUncCtdkF9r6vuV/C+oVC0RHDvsqLrbY4exdMz6l0HoPV8uTYwIwb/DDKmsePs1mkvEjfVXXX1/1i3zFQS8WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HaDJOsQcD35SBVdCghlQ+WI/eAEj2GLZO8iGM8x/sNo=;
 b=0xGeVZSuyIi7niXctVWeSTymbiT9prIAj0PZWRpLkIgR0Tqh0Z6cyLK0i4gvVAWGHVhOWJLk6Plt9UKoKqUi4OHyZJG6Kt0UQVEEIDZALHx4UieOh/oPB6qDYj48f5VUqwwKEEDwQFzkVlNuphIKDq/SMGDlegjv8MsGCi6bfxA=
Received: from SN7PR03MB7132.namprd03.prod.outlook.com (2603:10b6:806:352::6)
 by SA2PR03MB5772.namprd03.prod.outlook.com (2603:10b6:806:11d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.34; Tue, 17 Oct
 2023 13:46:51 +0000
Received: from SN7PR03MB7132.namprd03.prod.outlook.com
 ([fe80::7064:6752:602f:7886]) by SN7PR03MB7132.namprd03.prod.outlook.com
 ([fe80::7064:6752:602f:7886%3]) with mapi id 15.20.6863.043; Tue, 17 Oct 2023
 13:46:51 +0000
From:   "Hennerich, Michael" <Michael.Hennerich@analog.com>
To:     David Lechner <dlechner@baylibre.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC:     David Lechner <dlechner@baylibre.com>,
        Jonathan Cameron <jic23@kernel.org>,
        "Sa, Nuno" <Nuno.Sa@analog.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] iio: resolver: ad2s1210: add reset gpio support
Thread-Topic: [PATCH] iio: resolver: ad2s1210: add reset gpio support
Thread-Index: AQHaAEeEZrW9+LMH/kKVC8C74GE9yLBOAAXA
Date:   Tue, 17 Oct 2023 13:46:51 +0000
Message-ID: <SN7PR03MB7132A5B955A660700220ADA78ED6A@SN7PR03MB7132.namprd03.prod.outlook.com>
References: <20231016154311.38547-1-dlechner@baylibre.com>
In-Reply-To: <20231016154311.38547-1-dlechner@baylibre.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbWhlbm5lcmlc?=
 =?us-ascii?Q?YXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRi?=
 =?us-ascii?Q?YTI5ZTM1Ylxtc2dzXG1zZy05OGFhNDI1Mi02Y2YzLTExZWUtYjgyOC1iY2Yx?=
 =?us-ascii?Q?NzFjNDc2MTlcYW1lLXRlc3RcOThhYTQyNTQtNmNmMy0xMWVlLWI4MjgtYmNm?=
 =?us-ascii?Q?MTcxYzQ3NjE5Ym9keS50eHQiIHN6PSI0MzE4IiB0PSIxMzM0MjAyNDAwNDUx?=
 =?us-ascii?Q?ODU4MDciIGg9Imc3Y2JGNVFTbWNtZGVZRlp4SGw2TElDOHJkZz0iIGlkPSIi?=
 =?us-ascii?Q?IGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk5DZ1VBQUVvQ0FB?=
 =?us-ascii?Q?QVBtNzFkQUFIYUFTN1N5K2lnNjhHaUx0TEw2S0Ryd2FJREFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFIQUFBQURhQVFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFFQUFRQUJBQUFBbEdUR1ZnQUFBQUFBQUFBQUFBQUFBSjRBQUFCaEFHUUFh?=
 =?us-ascii?Q?UUJmQUhNQVpRQmpBSFVBY2dCbEFGOEFjQUJ5QUc4QWFnQmxBR01BZEFCekFG?=
 =?us-ascii?Q?OEFaZ0JoQUd3QWN3QmxBRjhBWmdCdkFITUFhUUIwQUdrQWRnQmxBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBR0VBWkFCcEFGOEFjd0JsQUdNQWRR?=
 =?us-ascii?Q?QnlBR1VBWHdCd0FISUFid0JxQUdVQVl3QjBBSE1BWHdCMEFHa0FaUUJ5QURF?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FB?=
 =?us-ascii?Q?QUFBQUNlQUFBQVlRQmtBR2tBWHdCekFHVUFZd0IxQUhJQVpRQmZBSEFBY2dC?=
 =?us-ascii?Q?dkFHb0FaUUJqQUhRQWN3QmZBSFFBYVFCbEFISUFNZ0FBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFBPT0iLz48L21l?=
 =?us-ascii?Q?dGE+?=
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR03MB7132:EE_|SA2PR03MB5772:EE_
x-ms-office365-filtering-correlation-id: 09374c7f-1db9-40f5-0c20-08dbcf17845c
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +VPFn9FJJaXQS9yW95iWFj2nOoXv3dQsGb/ySvj09wDyx16+FAsNN5ya09dRyOddHjEXJ4Iv/wV7IxImlng2hiElfVhsxdnXIBAOJvubg4cd60yMUzB+Gl4IwT28SRtkN1xh+QEgbfphGUZ9VOS4i3xhH0iwpax1sVszFxO1vP4YCjBtSpj+k3inEWmH0JbcA+8kwlsIHijqs90Or8R3iwy6WU0lyVqQoHZeMsJWHWWRQxbG9hRTWeD+c1XKW9h8X4ht1ZfE0H1Lk3/PdNy31VnakWnr79CaWhCYGRZ9zQO9rVKGO9KyzNp8iXT0dH3nBLIltx85LbNkJVJaR7s71kz+1WV/j7+cpEWgds6fIfCkHtsBfqpw92V9vDPNPFMEf4spGt5enO46D7mauobTv92TB4c2A64EDGjo8K1hcea3kc1ljvo5uXsSt9s91j6NNrtdsLr1ehcxeDpqxmRT3/JNbUctNEKp4YO6tiCLh4YLpHqWIs31Y2U+rakH/6S1gXsQWAS+/VkmZzSGVRp209qc818pEfynBGoli9a5xBIats9Z3bYdNjAEF7Vw6uSWfa1ILvETJj1CuTFewRk4/oYiq7hsVkTUCzwiJaMcA7I/QJEVZwsjvxceMlpMUTfo
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR03MB7132.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(366004)(376002)(346002)(136003)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(55016003)(26005)(53546011)(7696005)(9686003)(6506007)(71200400001)(83380400001)(8936002)(4326008)(52536014)(8676002)(2906002)(478600001)(316002)(5660300002)(64756008)(41300700001)(76116006)(66946007)(66556008)(54906003)(66476007)(110136005)(38070700005)(66446008)(122000001)(86362001)(38100700002)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VwABa3bf/7EZwE7iYiGSCO++FVu0UBLwxr2b0RtZB/V6XHSY6td0aK1uYfMY?=
 =?us-ascii?Q?0+JjbZuCuJX9jcB+r6lEiA27sZvPAxSZ6J/o3ngLZVHfDcYsVOPLsa0l3UCb?=
 =?us-ascii?Q?pHBDG+gayY+dJrCopf+4Fltb/xtPhFZfvSEnVKngV+vPyRv7+ibHZS2J9EV1?=
 =?us-ascii?Q?fS1/1+BRF80sO1kzVs/f0Pat67Eq+XnhBZ7B0Q0163BIllHOzY1FJARsTZu0?=
 =?us-ascii?Q?bHbuIQeytkIR3R6QJQAF+vNZ6atff0oqjDqAHx6DSZ6xPiMDZQmOBrVRFDex?=
 =?us-ascii?Q?Tp8VhEdLm3KSGYwpZqJ98Weikon6gdCBXSU3ilqqkHLnY27qOItM3iKXhO2x?=
 =?us-ascii?Q?l6LfdRKMHJwM079DknvPKvysW5WbVxlvs5T9Bxb3Vu13SjPMj9Jxl6dXh6mP?=
 =?us-ascii?Q?/LreP+HfmrXynLyirLX4Cgr/1pAWk3nAyYO/agEWlOO11/cBNSlyvt6ExZ+k?=
 =?us-ascii?Q?dVQzUL7u5P+mA7/t98KVzrH/Nym4hte85fA6xTrEUbnqAsLphULPwcjqA6qp?=
 =?us-ascii?Q?CxmxoC50wSo7ZLjYJu2dvI4QMizG59P1JHXH+/weT7/lPPl2vz2T76C624XN?=
 =?us-ascii?Q?5OKvMoiktOnvPgp08ZD93DM4W1qxZpyDR0k8GtZnzsWclRt1ltLTuDDi9Eo6?=
 =?us-ascii?Q?+O5n0GXrZGy0M9w7jpAXBU6hpb9fEIiJufeUI+pCi8RG6rmEOMHbVpavamp0?=
 =?us-ascii?Q?chAiN2z0LxVbBTAPiGfezaopylxacI47dnrqfv885BlpKKyiFHtyioG17E0e?=
 =?us-ascii?Q?Q8XculwDVd8lLoW7mN2QoZgPxUNXfYey73X80/u5E+ETJ9aQdQFqp4Gdi/L8?=
 =?us-ascii?Q?3NQHlVEkmslSg035DOW/jGh0MOh7sph8DOS1pPVC10QSpLaHHjFAs+viF7Z9?=
 =?us-ascii?Q?C82R3iMgxSRdDzt85hyyRq2rduhn9tvnWVDyYa/TXpZtccUvQU4gUwjARBmW?=
 =?us-ascii?Q?RRKnfZV4jDovirYQa0/CLJJuOmENU6mcBuJW78rmihwSnM3RJzDjG4Cj1pMo?=
 =?us-ascii?Q?QTR4CZYHKJ3DVOLrjqN3Tq6EULhM7bm1uoStC6CC+JZpDFyFUBBiSPXHkrNn?=
 =?us-ascii?Q?2Yf7a9Kg6vjnBEYjQnx948yChLKJnSIAwL4YqCk/bnLnRrlnqSC6GX1HJswf?=
 =?us-ascii?Q?/52+oGWkXEg60fSiC3oYaBgzWw/Qa6Th4LmIb64s3JUpZnm+UfQWqkFdSkZl?=
 =?us-ascii?Q?XSeWEjLW5fNtLD3PNQyzvImIBI8qx+tTxW7op+RvAH1E4+OLSK3G6WTgEO7A?=
 =?us-ascii?Q?WGVW3I5EyF0p9qyWV5nXSoiAKs84+z49x1tIYyeOKelao6FRd+6F9Lvsuexs?=
 =?us-ascii?Q?pH+20j86uNfKUr5zeaa+FUdaNPU5BqpmRofFLRVoZow4ajUkCuftUfoTFCys?=
 =?us-ascii?Q?/mMESJHBLvmehTjTppFh7p0X2H3ImFhOPo2yIKUOTwQqwbdYj/cFJKKSsH/7?=
 =?us-ascii?Q?EDdwH9wWv8rX67oI6chXWUyAhI1+1Us5wivKJBYps/oGiShOKYlYipbxPeKz?=
 =?us-ascii?Q?6DKNTVQDRyabWlLzY0fU2LzreW1nTUGiMUWEvL/8JfKe9kgCfRxEqiTNjOZA?=
 =?us-ascii?Q?xOMGssXW+b1pA+ke9tpY8L2Kl307/btPBzyJ9ov/dLJ5wDTsGldpjrUDoyBb?=
 =?us-ascii?Q?pA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR03MB7132.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09374c7f-1db9-40f5-0c20-08dbcf17845c
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2023 13:46:51.4530
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x2FC7mzWDDEoWoGsJfrkTza9/eXD80UWHMtBl6ySOXPFNGaDR+vdbQgp4zryBCnXR9wNZ3GRU1El1eTI1ukwVb4zWTzG7JDm0tNhpXVSvl8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR03MB5772
X-Proofpoint-GUID: QS-oeZWQEyuNhlwFnDJXpKKPravhPRoe
X-Proofpoint-ORIG-GUID: QS-oeZWQEyuNhlwFnDJXpKKPravhPRoe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-17_02,2023-10-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 adultscore=0
 spamscore=0 phishscore=0 bulkscore=0 clxscore=1015 mlxscore=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2309180000 definitions=main-2310170116
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: David Lechner <dlechner@baylibre.com>
> Sent: Montag, 16. Oktober 2023 17:43
> To: linux-iio@vger.kernel.org
> Cc: David Lechner <dlechner@baylibre.com>; Jonathan Cameron
> <jic23@kernel.org>; Hennerich, Michael <Michael.Hennerich@analog.com>;
> Sa, Nuno <Nuno.Sa@analog.com>; linux-kernel@vger.kernel.org
> Subject: [PATCH] iio: resolver: ad2s1210: add reset gpio support
>=20
>=20
> This adds support for the optional reset gpio to the ad2s1210 resolver dr=
iver. If
> the gpio is present in the device tree, it is toggled during driver probe=
 before the
> reset of the device initialization. As per the devicetree bindings, it is=
 expected for
> the gpio to configured as active low.
>=20
> Suggested-by: Michael Hennerich <Michael.Hennerich@analog.com>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---

Acked-by: Michael Hennerich <michael.hennerich@analog.com>

>  drivers/iio/resolver/ad2s1210.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>=20
> diff --git a/drivers/iio/resolver/ad2s1210.c b/drivers/iio/resolver/ad2s1=
210.c
> index 8646389ec88d..a414eef12e5e 100644
> --- a/drivers/iio/resolver/ad2s1210.c
> +++ b/drivers/iio/resolver/ad2s1210.c
> @@ -1426,6 +1426,7 @@ static int ad2s1210_setup_gpios(struct
> ad2s1210_state *st)  {
>  	struct device *dev =3D &st->sdev->dev;
>  	struct gpio_descs *resolution_gpios;
> +	struct gpio_desc *reset_gpio;
>  	DECLARE_BITMAP(bitmap, 2);
>  	int ret;
>=20
> @@ -1481,6 +1482,17 @@ static int ad2s1210_setup_gpios(struct
> ad2s1210_state *st)
>  					     "failed to set resolution gpios\n");
>  	}
>=20
> +	/* If the optional reset GPIO is present, toggle it to do a hard reset.=
 */
> +	reset_gpio =3D devm_gpiod_get_optional(dev, "reset",
> GPIOD_OUT_HIGH);
> +	if (IS_ERR(reset_gpio))
> +		return dev_err_probe(dev, PTR_ERR(reset_gpio),
> +				     "failed to request reset GPIO\n");
> +
> +	if (reset_gpio) {
> +		udelay(10);
> +		gpiod_set_value(reset_gpio, 0);
> +	}
> +
>  	return 0;
>  }
>=20
> --
> 2.42.0

