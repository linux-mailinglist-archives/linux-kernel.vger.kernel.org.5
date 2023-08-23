Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF0878559A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 12:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233949AbjHWKmv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 06:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230518AbjHWKmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 06:42:49 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2056.outbound.protection.outlook.com [40.107.21.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED63EFB;
        Wed, 23 Aug 2023 03:42:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bMo+YZEj30UKC0WnLrycYqFuj+TqSc77nhIvtlGbHgIx7o2+bgPG+3iouO+9KX6TcreJYh4ish5KdvqT3xpaRVUhHdxTsTupyMST4mOzrRWk1iZVZBc1mr/NtmoJqHC6B2qM4f1QGyKbjLfEUBACMGkV6x/jxBptV5kgdCybfJ607QEoP21QOC0ye5WVMfJbD5gmgb4f89gOsLP//bfKLxWoYLDzr5P2PmzMpV52OSCtPsqaUoudNEFS+TCSmmnn+vvOD9/zk3Dq9EbqZFOWHBpJKaP39RYHX7yR/TJJo/xgD3QMh6qkpiqyXaXwl+wCv6FxCqhC/txRXtZSYBIV1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vtCvWy24MvzbNGdm2v4ZtQnoAeJsp/kopSBDxpPBb1g=;
 b=M2mdsFTHao6EsMZ2Xongz9U3wKH5BMjFjh8Xf/+tJCiH0rjoHyqEFl2YbJLFfiZ3Xp6gLknZE8Aez31Y3elExael42Kv0lMVdFDdGUQV2Ak0poVPyC0PYHtmJZ+UHEnA6NtPZqV0i5zYqw93cUwH6M/ovMUUjbrc93l2X6NphwtENzrr6sq+eXYpsyaxwdQ63iqVo7/XyfwTC8f0A81NuPXhvFq0wlVrtCJzSb9zUi16VBbBdzY9n1KHQWGG8yRgCzjYpBVbFxgynBTWeVMnNzQwSZqEmisaEiq1dpHYSmhxncxxYiXfhEwTwua5XiX3e528Ezb2JDhDDd4MpJVxvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vtCvWy24MvzbNGdm2v4ZtQnoAeJsp/kopSBDxpPBb1g=;
 b=NCb6+0HMK6LMMTp/P3V3YMBac/ksuAN3H7ledDa2iPELSkZuW/R5HclQi7xudSP+LK37Zm7H0p70n5zhLGmpoZD0EkBOBGA2o+ZKDVbWx15BaG/X8S325NoZHNzghWivCd0AU4OACDrPcj487d80DeOG70FaIvA3kwaFz0Cbzh0=
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com (2603:10a6:10:2dd::15)
 by AM9PR04MB8524.eurprd04.prod.outlook.com (2603:10a6:20b:433::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.25; Wed, 23 Aug
 2023 10:42:43 +0000
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::175:d311:2cb4:7915]) by DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::175:d311:2cb4:7915%7]) with mapi id 15.20.6699.026; Wed, 23 Aug 2023
 10:42:43 +0000
From:   Pankaj Gupta <pankaj.gupta@nxp.com>
To:     Rob Herring <robh@kernel.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Bough Chen <haibo.chen@nxp.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Peng Fan <peng.fan@nxp.com>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        Varun Sethi <V.Sethi@nxp.com>,
        Sahil Malhotra <sahil.malhotra@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "clin@suse.com" <clin@suse.com>, Gaurav Jain <gaurav.jain@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Jacky Bai <ping.bai@nxp.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Clark Wang <xiaoning.wang@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        Wei Fang <wei.fang@nxp.com>,
        "alexander.stein@ew.tq-group.com" <alexander.stein@ew.tq-group.com>,
        "pierre.gondois@arm.com" <pierre.gondois@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: RE: [EXT] Re: [PATCH v5 01/11] dt-bindings: arm: fsl: add imx-se-fw
 binding doc
Thread-Topic: [EXT] Re: [PATCH v5 01/11] dt-bindings: arm: fsl: add imx-se-fw
 binding doc
Thread-Index: AQHZ1ZRNdEyzu2/ls0yVYLUzDZQS6q/3jHCAgAAYKlA=
Date:   Wed, 23 Aug 2023 10:42:43 +0000
Message-ID: <DU2PR04MB86300732E155EB859C13BADC951CA@DU2PR04MB8630.eurprd04.prod.outlook.com>
References: <20230823073330.1712721-1-pankaj.gupta@nxp.com>
 <20230823073330.1712721-2-pankaj.gupta@nxp.com>
 <169277931130.1441418.1447733552044665055.robh@kernel.org>
In-Reply-To: <169277931130.1441418.1447733552044665055.robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR04MB8630:EE_|AM9PR04MB8524:EE_
x-ms-office365-filtering-correlation-id: 84e3d64f-dd5d-4cfa-3aab-08dba3c5ae89
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XBUxZc8t9/pGzg45FWdWwiZWSZ5rMQzTHIIypLhjwyQGEnjyhDC2e3sHn/r0wSOjcKh7VGlggUaD/zZAr/R0fZfJPKCbvJVud2eIYBtF70mP+vWT6walIcs+MoXb5D8Nu6fQVnxFZvuf4DNe7hfYRveIUOrx1mRPB0SQiTk4Ob2PWYyGE8C81uqodlqFupn/dI9XBrC0RWd7outBMSQB8OuhgKoAw3GTbaHu6MSiTDqbYmampYgpQRiTBnd7+Sjkr9qLyTVxAUuP+E88Zy0EtK+Np02bekPGlTT5cArhXFZFtErQuHAW3Q+Oojs4oLc4kKeNJNUcCV6KzblH5jq2FhmJwA8b05mfgrwtKcYTN7lwHDNrZkCRyJQ01e8jfd/2II5kLmxDaGTJPIO5tKZZo90LkvAd73d+CKnDxog6wjzhtpxc1wNLY02POeK3UEEgihZz0q70r8jqQWSzFaYc/vqsFo8Iur1ISEPKGV56ZeGx7Hc9JLu/4fGn7qyZrQjuk+9D5yhNSHH/xfF6ZoIAq0/uzzhwgytVhW/j1cT0ZKtSIGD6GWGZn8jOls4UaubeggBBpysB+SgQwW8dsE5EZeFVTG8p5verYCfhoKN/W7/S73ihH0wGET396r8kj9Bv
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(136003)(346002)(366004)(396003)(451199024)(186009)(1800799009)(83380400001)(7416002)(2906002)(55016003)(71200400001)(64756008)(6916009)(316002)(7696005)(66556008)(66446008)(66476007)(6506007)(54906003)(53546011)(66946007)(76116006)(478600001)(966005)(86362001)(33656002)(45080400002)(44832011)(5660300002)(26005)(38100700002)(41300700001)(9686003)(122000001)(52536014)(38070700005)(8676002)(8936002)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7H/VZL2ZALSTBurD5SDp1r4j5DXMPXQ9GxjK+FVrJoCHrpPMQlM9rN9IcS0e?=
 =?us-ascii?Q?Jmp2l9jVV8AKTb3vk+zmIJ36pnuwOODr0JOlxOY2hKLpGuk2RDWSWdtCFMkW?=
 =?us-ascii?Q?66SnD7KkqilXXTT+aOxm93JV/GulyHOG4RpNqajMWx5z5KOC3+jpcC7mRLPL?=
 =?us-ascii?Q?ByOeNRI+0Ja/EgyAt0pg9hVi/N9gAlrc52Q88ZMvhtIiCmnZO9DrzaeKHIUV?=
 =?us-ascii?Q?ppEyxtY7B0SHnDU7F7WiejNpq7Z0MuXbgv/ekvYf2Ous72okK42SLO/g/rhs?=
 =?us-ascii?Q?jEzyqmSBbZW8U+wdJo65RntRH8Zb1R4nLvyPixnPX+ic4VgnCy/4qssdPHbo?=
 =?us-ascii?Q?gey4+5wQ5h78J+2iWdg3q8g/DFuGgqvjQYdQAQsjvQKxwZiDPaUhMUe82hYG?=
 =?us-ascii?Q?ttlgTyy28Uv3dQUAmMd/6LMN0mhCAzrL7jj1+eB7exAhlnVyI43VxFF1j3Wb?=
 =?us-ascii?Q?bkdfsGKrSY+7/0QLWTz1SsJAQ9iq556fJAp3TcMunPtT0gfoHZqv8w69ipKL?=
 =?us-ascii?Q?GdXWv03pXxpqJp6iGfRUsHE5XfQ+MO+zy5wUV2M/utssj+1EuaiONo5Jzynj?=
 =?us-ascii?Q?GU2/pkiY/7aKBHYL/A68mKrI/v/4fyRd1gpCwaWQqWsFh7G8yl0PzLQ8Cjms?=
 =?us-ascii?Q?YghwFlKBDgocBfrEg4DlF1gJAGypW1C/fbp8aoJ5YdUhMEZmvdmb3JJDDOwM?=
 =?us-ascii?Q?GA9h+3qcA7idAVt8wAfCToNBD25vRvujGsqaE0Ozji8G7X6GrBcQfCxZooW7?=
 =?us-ascii?Q?Q8IiyBQVdEWKeenK+Q7PVQv0nN7hl9z435w5VfxDLZGZeQc7T0IGN7FT5SUA?=
 =?us-ascii?Q?nMZOpRxfGWiKk6sZIakvxqTkl19aq7YxLYJ25MVyFO72DkRII6bWQLVt580z?=
 =?us-ascii?Q?5bilUZJlo9XpF+gcpoHKr09cu1j0o7g9knJc3JaBaGOmuxAGt4t+4uyxUbVx?=
 =?us-ascii?Q?8LXUdmQ2qW59R496CFX5C0Nwuzxwz6FUmkVDlnvkqYF1hueVBSpQrt7nctUz?=
 =?us-ascii?Q?P7mW9tRPyz4RbzsaU0Vr7DlzDX/6X8ZAkOlJA7LghAYeeAv0sNfOYkQPVDxC?=
 =?us-ascii?Q?Gam6EXd5F5pZh5j8hmh6aBeuVjFRkbcKWMQaaV3tuuOZuQR6PRguXIr/TvJn?=
 =?us-ascii?Q?I9DAqQ9WtAV25t2jDcJ4V8SoriifFPxIqCuGzbowFmCUs9W3paeE50uAYI+2?=
 =?us-ascii?Q?HF8uOkfIVWmK2K1GJe9DxLJB5HNmCB2eZei0zisJN7KvTfWH83IYEZQ8VWPX?=
 =?us-ascii?Q?P6wyj7jcDvneKplcsA4i6VpyKinsYp0F7VP972iW+1TPI5IeFueV5KBPW8bT?=
 =?us-ascii?Q?/0zQBnlMb+uqHMfTbRfIxm5y1e33CLSBBTKQ90PnowM+4VoQMw3w+TW27MOo?=
 =?us-ascii?Q?y6c5tbnFx4dBE4T9LnosuvfAuyVmMECLDlGydn/UNyc1yabC9m6jiAOIgxAI?=
 =?us-ascii?Q?FUSg9DjnJWn+R3+c/G7LGf+p7VPhSS1fnEQm2oGwcsRYFOdPQEfoCFAt6yZf?=
 =?us-ascii?Q?01kcR63U5RQqsTzxFvs9GMYgMyXLiTGWXblg8E1pUtzt/uRBjozaE4sCi53L?=
 =?us-ascii?Q?THCRaNBWB4/Y4elLBjeGI4WYuEbrZ3Zo35GdEYo1?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84e3d64f-dd5d-4cfa-3aab-08dba3c5ae89
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2023 10:42:43.4995
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t+qPI0dgiOWRojzlrHqENYuFNhzKyoQqNh6HpP9F3UdziqiTnxcy1g39sy24pxGpdzNMxiP/AyVX+KKiNDTQrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8524
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Rob Herring <robh@kernel.org>
> Sent: Wednesday, August 23, 2023 1:59 PM
> To: Pankaj Gupta <pankaj.gupta@nxp.com>
> Cc: linux-arm-kernel@lists.infradead.org; Bough Chen
> <haibo.chen@nxp.com>; festevam@gmail.com; Peng Fan
> <peng.fan@nxp.com>; conor+dt@kernel.org; Varun Sethi
> <V.Sethi@nxp.com>; Sahil Malhotra <sahil.malhotra@nxp.com>;
> shawnguo@kernel.org; s.hauer@pengutronix.de; clin@suse.com; Gaurav Jain
> <gaurav.jain@nxp.com>; dl-linux-imx <linux-imx@nxp.com>;
> robh+dt@kernel.org; Jacky Bai <ping.bai@nxp.com>;
> krzysztof.kozlowski+dt@linaro.org; Aisheng Dong <aisheng.dong@nxp.com>;
> Clark Wang <xiaoning.wang@nxp.com>; devicetree@vger.kernel.org;
> davem@davemloft.net; Wei Fang <wei.fang@nxp.com>;
> alexander.stein@ew.tq-group.com; pierre.gondois@arm.com; linux-
> kernel@vger.kernel.org; kernel@pengutronix.de
> Subject: [EXT] Re: [PATCH v5 01/11] dt-bindings: arm: fsl: add imx-se-fw
> binding doc
>=20
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report
> this email' button
>=20
>=20
> On Wed, 23 Aug 2023 13:03:20 +0530, Pankaj Gupta wrote:
> > The NXP's i.MX EdgeLock Enclave, a HW IP creating an embedded secure
> > enclave within the SoC boundary to enable features like
> > - HSM
> > - SHE
> > - V2X
> >
> > Communicates via message unit with linux kernel. This driver is
> > enables communication ensuring well defined message sequence protocol
> > between Application Core and enclave's firmware.
> >
> > Driver configures multiple misc-device on the MU, for multiple
> > user-space applications can communicate on single MU.
> >
> > It exists on some i.MX processors. e.g. i.MX8ULP, i.MX93 etc.
> >
> > Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
> > ---
> >  .../bindings/firmware/fsl,imx-se-fw.yaml      | 121 ++++++++++++++++++
> >  1 file changed, 121 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/firmware/fsl,imx-se-fw.yaml
> >
>=20
> My bot found errors running 'make DT_CHECKER_FLAGS=3D-m
> dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>=20
> yamllint warnings/errors:
>=20
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-
> ci/linux/Documentation/devicetree/bindings/firmware/fsl,imx-se-
> fw.example.dtb: se-fw: 'mu-id' is a required property
>         from schema $id:
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fdevice=
tr
> ee.org%2Fschemas%2Ffirmware%2Ffsl%2Cimx-se-
> fw.yaml%23&data=3D05%7C01%7Cpankaj.gupta%40nxp.com%7C7e28c89d24c6
> 4b9c000108dba3b2f2d0%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7
> C0%7C638283761210875688%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4
> wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C
> %7C%7C&sdata=3DSFldwBvByjOkEf%2FlzBmMJ3oZI9cBdWJe1ZmSh2AsflA%3D&r
> eserved=3D0
> /builds/robherring/dt-review-
> ci/linux/Documentation/devicetree/bindings/firmware/fsl,imx-se-
> fw.example.dtb: se-fw: 'fsl,mu-id' does not match any of the regexes: 'pi=
nctrl-
> [0-9]+'
>         from schema $id:
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fdevice=
tr
> ee.org%2Fschemas%2Ffirmware%2Ffsl%2Cimx-se-
> fw.yaml%23&data=3D05%7C01%7Cpankaj.gupta%40nxp.com%7C7e28c89d24c6
> 4b9c000108dba3b2f2d0%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7
> C0%7C638283761210875688%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4
> wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C
> %7C%7C&sdata=3DSFldwBvByjOkEf%2FlzBmMJ3oZI9cBdWJe1ZmSh2AsflA%3D&r
> eserved=3D0
>=20
> doc reference errors (make refcheckdocs):
>=20
> See
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpatch=
w
> ork.ozlabs.org%2Fproject%2Fdevicetree-
> bindings%2Fpatch%2F20230823073330.1712721-2-
> pankaj.gupta%40nxp.com&data=3D05%7C01%7Cpankaj.gupta%40nxp.com%7C7
> e28c89d24c64b9c000108dba3b2f2d0%7C686ea1d3bc2b4c6fa92cd99c5c30
> 1635%7C0%7C0%7C638283761210875688%7CUnknown%7CTWFpbGZsb3d8
> eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D
> %7C3000%7C%7C%7C&sdata=3DafDClssaony%2B7aLwRX8VWJ1QyPrfZJJnEOcyU
> LYxR4g%3D&reserved=3D0
>=20
> The base for the series is generally the latest rc1. A different dependen=
cy
> should be noted in *this* patch.
>=20
> If you already ran 'make dt_binding_check' and didn't see the above error=
(s),
> then make sure 'yamllint' is installed and dt-schema is up to
> date:
>=20
> pip3 install dtschema --upgrade
>=20
> Please check and re-submit after running the above command yourself. Note
> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> your schema. However, it must be unset to test all examples with your sch=
ema.

Accepted.
Re-submitting the patch V6 by end of this, after fixing it.=20
