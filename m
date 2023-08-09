Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A137775053
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 03:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbjHIB1q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 21:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjHIB1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 21:27:45 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2072.outbound.protection.outlook.com [40.107.6.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD09119A8;
        Tue,  8 Aug 2023 18:27:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MxoM/F1LWaJMLGPh/3qrqmt7U8phfTXDRP/eh/L7lGTDW1q8lFwiPZeiEVJP1c5noraVExIvfrLxtiYSJiiVBso4npAZdTDaPCh9FDj+5koByVv3PEipNNiN7ZoPdj4GG3PPtBaKn5m4To5QvzVlEij3yQBLxGOKSD+Mz0sMz/N8tOro0elFknfDF3jKwNQbcG95JrCYn0R0UuntG3ikd6DtctPPMxvqvxa9Yfm3SZ0pXxngHQroWm+p41GuXSrYptwcRx2xmmx7EW2hVUT5EnAa6453V3DO5O49J9PLxnLpK7QpAuu/+SKl7tuteeNTeO3fnbSE2/KB+u/mIfTC8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jA0C54Bi5GahVfCLmdguJPVdbQGUBFxHn9x41fZnGq4=;
 b=T+LB/H1eSv5eFq47SrfI7+k+xiNd2A3jYsHFa6fMU+8W/TMOjbZ3ZE8OSajRcfFhLJw3WbmTrPQ9IWsK5pxIeUny9zt9fz56OMIB0MfFohxhNaGMIYuQHwSLzMqN1X1uh0UGKlzrM0LU/tTUjvTE8EcmQzgDNFNmLZ7Opin0F4Tpzhy9Xr6BogdLMziilDWTIZV/sLvjtfgVJDvBpMJ6nsOrUwdiY0ZVVi1H2AgWlj1CggWo1hyQ2/gIGADf4ya2SkgNZsdRUiBEv6NUpH/jgLJ9ebUVZveozioQX4c9RZZRYVC8/NFVt31lq8dENPSjC/qRUgwD/uWtJexyXwFd+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jA0C54Bi5GahVfCLmdguJPVdbQGUBFxHn9x41fZnGq4=;
 b=spjkdkwpjXVqJOTyfrzSm6aW0AA/0rOz4e1IHKe21JUaEGSYiRfgtS3atnr+DqgX3nDDsSAo4VLHxzgXTQ7my6kcKFZxKHXMc9O5VNxhxm1sLj9uQ0+qkkMDgaAFmLIF1+2C7LuqvFRaHyPDkPajMIJQy1vFshKVyczto5E8r88=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8296.eurprd04.prod.outlook.com (2603:10a6:20b:3f2::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28; Wed, 9 Aug
 2023 01:27:42 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97%6]) with mapi id 15.20.6652.025; Wed, 9 Aug 2023
 01:27:41 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>
CC:     "amitk@kernel.org" <amitk@kernel.org>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V2 0/2] thermal: fix two coverity reported issues
Thread-Topic: [PATCH V2 0/2] thermal: fix two coverity reported issues
Thread-Index: AQHZvf4jbwqPDJU9yUGPQivCwIGMgK/hRT1Q
Date:   Wed, 9 Aug 2023 01:27:41 +0000
Message-ID: <DU0PR04MB9417E1F81E036117D733D61D8812A@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20230724071646.2744900-1-peng.fan@oss.nxp.com>
In-Reply-To: <20230724071646.2744900-1-peng.fan@oss.nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AS8PR04MB8296:EE_
x-ms-office365-filtering-correlation-id: 9af6106b-9243-471a-de64-08db9877d334
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nakA142/CnF+I3taIEVWerO3NQTaZvfo1NIvHOo6frY0dgZgGERBN6dn1jiTHPZGhJagYUhl9jBXjCmKiukauz4oUNn7NGVK0ASDdqI6v1VNfF++sA68AlyKwYdTlYGZAIzPMjWWxk5IzLHwuBYYcdqi+suSdaVPksP1abzCTyvsYWoLtJZTCAcI/Kpohn/YwZQ4QVdJoSE/Zxt+zrPm/j176aQwTXOPxREST/GUvEIbe1OKOJ88Mmxeexf4q3PWSVtGAD8OkswCPyetUiIgKVjMPxw7XxTyUq7HWFGSjcR6/B1LifmVFkO2ud0tCl4FvKbWptfrhyil6ERE2SkgYHJ8cTviN0gelwb72D3hCkqTgx+v1q/0JyYNDoqWhO/5VoOzIolWMo1A0sW1Ez42R3Opi4qCSQze2hbijoum0GJFyC8SPJ6tMQs5nUVUFNc9isgkYX2k4gsXx9Yc7hSLTk6yfoCS8z5vnAg5bdT1egqe02fcceaKsas/mHXVugPCTnC05tPHb1LrslID+6T24s19Zc9aN5+HiI41JpTcu3cjiKy4WaZbg8URjoa7wigYVpsY4f7Q1a4wQi7S2+tYMFkH7VVM+Ep652el9AWvVNVMn1Pa+c7ASKV3zMn/YRxx
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(396003)(346002)(136003)(376002)(451199021)(1800799006)(186006)(7696005)(9686003)(41300700001)(83380400001)(8936002)(8676002)(86362001)(38070700005)(52536014)(38100700002)(5660300002)(64756008)(4326008)(66946007)(316002)(66556008)(66476007)(76116006)(66446008)(122000001)(44832011)(71200400001)(26005)(6506007)(55016003)(2906002)(33656002)(4744005)(110136005)(54906003)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fEe8t7+ZLeBSGYkR2DQ2+f5OhJ/KATYT6pQFeePUEyVrki195zKIYWqL62BJ?=
 =?us-ascii?Q?uuwjPuh+jj+El8vvhmquZUkKe5wkc/Mk8x1P46laB+9pnGFtLl38/5vlOyok?=
 =?us-ascii?Q?gk8U5hMHidkkam3o711yOwD24snXcan3l1XRzVsuZW9x3I7kTz2vtd3NfU7R?=
 =?us-ascii?Q?m1SjD2zAlToxQeMbGIaAvMEQMo7isjtaO5Y0rV7rRkkXlU20UJWpf3CmKehP?=
 =?us-ascii?Q?vC0uy3tYPg2RrDI8dwKH3L9MePawxtTFk3QzIeGGcDWOKOaQsf6eh5JLX+Sp?=
 =?us-ascii?Q?oWwvL5QjaDAvNroBsO2MtA6hmDxg4KJ80LMfaZ2BYGm2clltP8bItEZ7I15q?=
 =?us-ascii?Q?ao80/0mPyqrKcjcyRq07hgCQRWn9ZJnT4WNmN9eYGgO6bLJY4oIa32ufeReC?=
 =?us-ascii?Q?V+MtbfLHbu4doB474/1piWFwj23OWlUe1MQrmGNIsdx1wqZ892oPtinynL8B?=
 =?us-ascii?Q?b9ztWuTeZWq5nILiK6L8tzdRx+jbw8WTNaUN8k8saJHavrzoGGGbhyfI83i/?=
 =?us-ascii?Q?yNlpYrrEbWcp40/O4wsl6/ebGWQBqj55rcbr4hgNFEJNjckPnH1zFpBNtw1N?=
 =?us-ascii?Q?Ck7SViF3Yl26v3F7JajqsIEAdXN51HscKtU8fi9hzFVd93bIQlOAoLd3vZ3y?=
 =?us-ascii?Q?q05m6q7Op+W58fM7NDYxtJAoGGO8dnxfXnyjR2c8Bhm02TGfujx1lsGXbWtc?=
 =?us-ascii?Q?NeekS7wBt3CBKooJO5O308QjHDQ+YMoojCPMwXThmqQAXf5tUzw9Zb1JH8bx?=
 =?us-ascii?Q?if12PRbO6ewzm+AIfi0lH/8X7eMg4ZpubHF7jnM198aj8QLoPQuhgy14KDtC?=
 =?us-ascii?Q?fkd3ELWKE+wvhkpDyEfoM+pWZgF+Xx/yEBM48uj9vDF7/TIDgjhDKOQCo4VP?=
 =?us-ascii?Q?bUYmsJDc225fqLZnvoH/44RKj86Z/l/fXdj/aD1rTQ9tjftjY4NKY4frFotA?=
 =?us-ascii?Q?hfeWkOjNBlO526LTtaPKa6ktm+EF4IhG5LNkck/rHhRZcsKlZzfNYNMNLn/z?=
 =?us-ascii?Q?O4wIx8s9QpnLD6SKuRSVm6RCz1qJEHvujOi46WNF/6ftUoNYl7fJIqMjlpRk?=
 =?us-ascii?Q?RDhVmpnRWonAo7vZeTroGvwk7SE5mnTdZ83KYAmjf5OUzWv5lf38mtXvWUC3?=
 =?us-ascii?Q?ylzA/XNUDwtOpYF0c6nlIKOjwL0BgHnP0o+32qn0Vg235MPowJjKrCQpLqrx?=
 =?us-ascii?Q?3h/NOgeFjNnaPVIqH0K26CSijRNTWvCQrKgcB/aj/KDVxR13wbfKUyrlgLVW?=
 =?us-ascii?Q?KsIkMV9TsPSRfGyPVKN0xxu8253RFvMyhkKfExTxXHK8qvShFySqRyJQxiRp?=
 =?us-ascii?Q?AMj25+Cp/+AfgZGLRp6TftL5qFHqArD2ibV2sLPSfgH41aePXSosE8M7SvEe?=
 =?us-ascii?Q?Dypv0CLk6lOvwVOPBYP0rfmh61zCS8eiVATBBwuJzLPyM29xqzhAYeE3lBwa?=
 =?us-ascii?Q?vyW1Cl/UiB4lO1LNEPHavPMw/IVLrm+z0ah/quTUmxmuHAWvaJGRMgB37HNj?=
 =?us-ascii?Q?TFBe2JkkDRUwf30nx2E1r/mjaqRnAVZfKEwSk2ow6Zrgdeqvhod5RN6oUJSG?=
 =?us-ascii?Q?dRiiszWTwsYJfQgt/NA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9af6106b-9243-471a-de64-08db9877d334
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2023 01:27:41.4817
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mjIQA1gQ72vD5FG/JMpRGIOGgCum1HAPlCnZxCVRJ32wUeDmBTKkOVtpPvrZQ7PwE1SY8WuLJZ+4PAVUi7/Qww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8296
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Any comments?

> Subject: [PATCH V2 0/2] thermal: fix two coverity reported issues
>=20
> From: Peng Fan <peng.fan@nxp.com>
>=20
>  Fix two thermal issues reported by coverity.
>=20
> V2:
>  Add cover letter
>  Add Fixes Tag
>=20
> Peng Fan (2):
>   thermal/core: fix potential memory leak
>   thermal/of: accessing potential uninitialized value
>=20
>  drivers/thermal/thermal_core.c | 3 +++
>  drivers/thermal/thermal_of.c   | 8 ++++----
>  2 files changed, 7 insertions(+), 4 deletions(-)
>=20
> --
> 2.37.1
Thanks,
Peng.

