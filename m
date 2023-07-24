Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8E5675EBB8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 08:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbjGXGii (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 02:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbjGXGic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 02:38:32 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2041.outbound.protection.outlook.com [40.107.21.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A76EC10F7;
        Sun, 23 Jul 2023 23:38:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e0WrCHsnxmRKDAtz0LrNK4ChLmX9Gn69zhyZOhBXRzSBJf56OLuVqxMAprxB+1ORSQ+vcA7YcbqJgv9WReqS+oubQotOicpzJ4+dh5VNx3nKsCfrWJRcY0a3afWXtZyNcXK5sbS3qzL00DhC3R48GIpokmCuGC97nIzTNre8ubCtqzFzAqP9eXnzEsf1wyQ6KIhaUXqDCEpiQ1Q5mDu+cRY93smixuckODgGXQKlDCOg5JAUzKTVqZT3FqyMKgVlpzybshw1nAAn5hYjxlecED41yey4+DgO8kaU44cW+ElQI1g/6cJ3iXq6ZnpDhJb+ZlWzLiDBWM3l3JY1IqaZtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hyDODoQToEyJv9AeAHoSz/xSWO/jackqs59CJLwV7cE=;
 b=i1TGTyDsZZxlbnr/2I6eXpcUI7WgltA2vDtL/biVcdWKoloqMp/re7x0AJZ5v0yGZ5L7yxeUXUZJ2miX6gIHRrk6xQzAqtd6o1VzkUGluiikc+d5SF+S0ADdsrPybmB8GG21L/aIen1q8f8gaDbekeko+A1uUFsAUdTcnQgUWvswNoObsBdsd/cgMNxKgqOoHxrf5RbFyUDLi2WHEzXsyF9NsNW9gPt6awZNmuXLVPKwK7IaC1By62MVA5NiA1MWGuhO4gau6ZfG1WmK4qYBeDXWOIJWhJTcM9efvOo7jVt8/MTupbqjMXtxJOUiNMrYUZYyUwWysvnUT+tVv1Q5Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hyDODoQToEyJv9AeAHoSz/xSWO/jackqs59CJLwV7cE=;
 b=NPg1hzEhybmhN2gKk/SzwZCh3qIVAaPE5Nb/eBqYOygdv3Y5JNjArxBAacbkuIoe1RzZ5ruh2XvQb8kL7AA3KJiMs0avmdo05ZSksGYI+2TKtsvVbNxRkcYIWj2oTrGCAvAR3SP+7DoR2b9iEYz7ImKuXPVq8nPis3d6YIPaMl8=
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com (2603:10a6:10:2dd::15)
 by AS1PR04MB9333.eurprd04.prod.outlook.com (2603:10a6:20b:4df::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Mon, 24 Jul
 2023 06:37:23 +0000
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::175:d311:2cb4:7915]) by DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::175:d311:2cb4:7915%7]) with mapi id 15.20.6609.032; Mon, 24 Jul 2023
 06:37:22 +0000
From:   Pankaj Gupta <pankaj.gupta@nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Conor Dooley <conor@kernel.org>
CC:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "clin@suse.com" <clin@suse.com>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "pierre.gondois@arm.com" <pierre.gondois@arm.com>,
        Jacky Bai <ping.bai@nxp.com>,
        Clark Wang <xiaoning.wang@nxp.com>,
        Wei Fang <wei.fang@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        Bough Chen <haibo.chen@nxp.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Gaurav Jain <gaurav.jain@nxp.com>,
        "alexander.stein@ew.tq-group.com" <alexander.stein@ew.tq-group.com>,
        Sahil Malhotra <sahil.malhotra@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Varun Sethi <V.Sethi@nxp.com>
Subject: RE: [EXT] Re: [PATCH v4 1/7] dt-bindings: arm: fsl: add se-fw binding
 doc
Thread-Topic: [EXT] Re: [PATCH v4 1/7] dt-bindings: arm: fsl: add se-fw
 binding doc
Thread-Index: AQHZtLo09zXvz2nwA0eXBXtTWXN23a+2c2IAgAACQoCAEfalcA==
Date:   Mon, 24 Jul 2023 06:37:22 +0000
Message-ID: <DU2PR04MB86307308661039043F9FF1C79502A@DU2PR04MB8630.eurprd04.prod.outlook.com>
References: <20230712121219.2654234-1-pankaj.gupta@nxp.com>
 <20230712121219.2654234-2-pankaj.gupta@nxp.com>
 <20230712-step-dimple-31746cd3a640@spud>
 <6e13acf6-3e23-f9bf-5c3f-368e79802a8d@linaro.org>
In-Reply-To: <6e13acf6-3e23-f9bf-5c3f-368e79802a8d@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR04MB8630:EE_|AS1PR04MB9333:EE_
x-ms-office365-filtering-correlation-id: ec558f81-96e7-452f-2f8e-08db8c106ff1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0daJ/KoGfW0elDT2G2jEqXtELju+krNsUbZGhMBifhIHsmb5lwVBYMCoFD2UJzC1oeysYXTbjjEDcNf9FHAqqaCfisYfgwOg1ZLPoJMQyWGgNSpXxa67vfs0Txdgq8EGzH6zax5uW4jcgq/Jd9QNQnmAD4oycQRtdHupYe1pBiyybM3npQ/NQrx0/vNzsqGxTmQqJ59pk3XAeHv42cnCOZ4/PYHh/DZr0A4+U6xm5BPQCNWnLGRsiPXYAcOJCtR2xnL1h0Vo/lcD7zMkY1QEpzGASTr5tMyiBzWuKuc3DLOMQ8fDc+DfaPP3MsalKxlixnUZBxugGtaFo4lfHOAEHvaRdb/i5bXV86/gl/TILASAOhiIRYTpnbzW14pvUtKeGA189jrmXklY3HWeI5uTuknyhWtNMFLAMd/htCmCCYFlORAi5rBaSN/X+CVQkxU0nTKv8Y/v3WdsI//OKS8+9DX2I26f5yQutJ9b6KPDEfO+iHf1dX+TVnCYrm+qow5QZKgz7wNArA5+7IP2azN7uLA4SLT+6Wc+vk+prfhny63H45SgoEJNbQiSjfSZjWEp12xjpHY0hv1Qy6R8r2tSK9yhqkiirWtKJMqKAnAwSQo/zDujXcq4+i6XV44RwAJv
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(346002)(376002)(136003)(39860400002)(451199021)(33656002)(86362001)(38100700002)(55016003)(122000001)(71200400001)(2906002)(7696005)(9686003)(53546011)(186003)(6506007)(26005)(38070700005)(5660300002)(41300700001)(66476007)(76116006)(66946007)(66556008)(66446008)(64756008)(316002)(4326008)(45080400002)(478600001)(7416002)(8676002)(8936002)(52536014)(44832011)(54906003)(110136005)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?o9PEWTDaj3dTShsCEkpKsfuEAHHzksCr5psap774tLNh+rAqjBCwensCFkrd?=
 =?us-ascii?Q?xZ8JnZ5WSgXF8aX5mEdrFX446T8DxzNHcwBOeap01P3HjxTVz6cs2UAYvaRp?=
 =?us-ascii?Q?NTdRh1fr8mZg/hb91fBcS6h5fAwEHzDhoCftw6QOTbz84z/uzwZUIkknMnWO?=
 =?us-ascii?Q?/CU5ZskmYRhPzAbSq0C9uwdOSQe/vHqbfBed8/hKp67ThK2fUhVLT9ILYsi2?=
 =?us-ascii?Q?u4M375zIIvz3ikFfiGol+CnkMoqOYX2ApOHc35R9t1Rw/694sGweq6WCxLgN?=
 =?us-ascii?Q?xWcgpNuhBh8J9Rvj8zrzFpMLI+vOYh0PykdrdT1jmABYtuE/D9KBc2LOh66Q?=
 =?us-ascii?Q?wMAWOvufxn4dCgU/eGhZh23NibtUPzeyPn2r1K/mqR3edu4kBjzO29jwoM+o?=
 =?us-ascii?Q?PS/houircINmQN4zWvCFRStt69vn/QrElls0OHko7jxdQWcbs9o9MVjDQCZM?=
 =?us-ascii?Q?J4MkybJL9EzEX5lKv/VscX0hP6nYXTjlP6MuAD8QWb3wdrnEQ1VZJklP4UuI?=
 =?us-ascii?Q?nXb2AY/gbVYPvo7jraUIg8GHp2S8GzUhDXiI73lm+3okk+WkbB25NDulEUPh?=
 =?us-ascii?Q?u7AxGZqlG94KzSgFtJaBWEPXhhVaLBYcNyJnOq5Q+NcBluUEc6nSwMipzqPp?=
 =?us-ascii?Q?vtTGbPZuwyvIsowKF7hVLaMvm+vwOrMgqnpMbiQIweyukrKZfZV0RpOuRXGz?=
 =?us-ascii?Q?pINR/3fx8lNpuq/zs7DXNT2cvNxaU15doc1uVG32esrZ7ikj4Bz8I7BK2V2C?=
 =?us-ascii?Q?asaofNp44FiR1YApEKH1hegSGXsGROQTTArQiFH63QmEyC1uAhJ+2zcHsTSq?=
 =?us-ascii?Q?1zK/P3uhH/MbUf3Qh6wXWhAGTt+8MBj+AaYz37yI4yt7GS1NCav6ToT/EZJR?=
 =?us-ascii?Q?oDjfMw3GKa5XpPAE3eqDZVyUwGjXX0l0wlVVPBNNhv6bZPa0gg8aL9OVaTrq?=
 =?us-ascii?Q?sfFo4KUkH0/yZH1LGsP7QEpI9PNRH9J1bY1QULfPcO/jPYE38DNX4mW8JtLC?=
 =?us-ascii?Q?qQD7NwlyQMIr6XYC5JLVaIj2RZIZHlF9z+wRRxoIW8Gd7Jm/vwsldPsHg6FM?=
 =?us-ascii?Q?KmSJ0cV9GO7RPZ3EpzG2kCPr4dW6zFBefJN+DBrqZiSY1zK4NKhzXgzP9jnn?=
 =?us-ascii?Q?OritSBH8OHpziNCfj7kIwuH4JKtXgEnsVZg/F44YsQfLCYSu6+6dlXdDElwb?=
 =?us-ascii?Q?lW8O/pujJzPlouDK6hN72j9ruqGy2E0Xe+gtGcdmvI3PvXs6IcxsIt1Ry9Ou?=
 =?us-ascii?Q?ik3+LlQhMf9bwUtYSgCboHBo5Rsub0QQJI4vv89hL0jIPHPsYXdEKUAntIXN?=
 =?us-ascii?Q?TxF8qftrOSPZ80HpSXr9s3G9+h2c5/TOzJuHPyzpqkMTjoNuesvhU/v0tT66?=
 =?us-ascii?Q?9kD4MJq572+Xd808GTM8bun2n2WnJuPIbZY5buiUibKXyb1fGL3NzCwsX7zQ?=
 =?us-ascii?Q?lPv3NsI/yp1P33MFyxSx766UIsCknk/5HRsKHTfcQ2WnzcdXSFxHXpBJZit/?=
 =?us-ascii?Q?XUy6WxuGyCnMM6F3hrDNcb5eQ/1Jw1AjHsoH/aFaqxXVZUFuUNzVUhLRUFMW?=
 =?us-ascii?Q?OYi+CfcGONebq1oBWm3nvoyuGzhxvVUsdpBFVTmA?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec558f81-96e7-452f-2f8e-08db8c106ff1
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2023 06:37:22.8011
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sBzK/4Ty8p6k7IJtQi7nFI3RpokV87I5nUUS6vXqZrwMbn8DFVdYa3A5sblvOT5k7minV3D9+V6EPRalfCclbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9333
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Sent: Thursday, July 13, 2023 12:05 AM
> To: Conor Dooley <conor@kernel.org>; Pankaj Gupta
> <pankaj.gupta@nxp.com>
> Cc: shawnguo@kernel.org; s.hauer@pengutronix.de; kernel@pengutronix.de;
> clin@suse.com; conor+dt@kernel.org; pierre.gondois@arm.com; Jacky Bai
> <ping.bai@nxp.com>; Clark Wang <xiaoning.wang@nxp.com>; Wei Fang
> <wei.fang@nxp.com>; Peng Fan <peng.fan@nxp.com>; Bough Chen
> <haibo.chen@nxp.com>; festevam@gmail.com; dl-linux-imx <linux-
> imx@nxp.com>; davem@davemloft.net; robh+dt@kernel.org;
> krzysztof.kozlowski+dt@linaro.org; linux-arm-kernel@lists.infradead.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; Gaurav Jain
> <gaurav.jain@nxp.com>; alexander.stein@ew.tq-group.com; Sahil Malhotra
> <sahil.malhotra@nxp.com>; Aisheng Dong <aisheng.dong@nxp.com>; Varun
> Sethi <V.Sethi@nxp.com>
> Subject: [EXT] Re: [PATCH v4 1/7] dt-bindings: arm: fsl: add se-fw bindin=
g doc
>=20
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report
> this email' button
>=20
>=20
> On 12/07/2023 20:26, Conor Dooley wrote:
> > Hey,
> >
> > On Wed, Jul 12, 2023 at 05:42:13PM +0530, Pankaj Gupta wrote:
> >> The NXP's i.MX EdgeLock Enclave, a HW IP creating an embedded secure
> >> enclave within the SoC boundary to enable features like
> >> - HSM
> >> - SHE
> >> - V2X
> >>
> >> Communicates via message unit with linux kernel. This driver is
> >> enables communication ensuring well defined message sequence protocol
> >> between Application Core and enclave's firmware.
> >>
> >> Driver configures multiple misc-device on the MU, for multiple
> >> user-space applications can communicate on single MU.
> >>
> >> It exists on some i.MX processors. e.g. i.MX8ULP, i.MX93 etc.
> >>
> >> Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
> >> ---
> >>  .../bindings/arm/freescale/fsl,se-fw.yaml     | 121 +++++++++++++++++=
+
> >>  1 file changed, 121 insertions(+)
> >>  create mode 100644
> >> Documentation/devicetree/bindings/arm/freescale/fsl,se-fw.yaml
> >>
> >> diff --git
> >> a/Documentation/devicetree/bindings/arm/freescale/fsl,se-fw.yaml
> >> b/Documentation/devicetree/bindings/arm/freescale/fsl,se-fw.yaml
> >> new file mode 100644
> >> index 000000000000..7567da0b4c21
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/arm/freescale/fsl,se-fw.yaml
> >> @@ -0,0 +1,121 @@
> >> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause) %YAML 1.2
> >> +---
> >> +$id:
> >> +https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fde=
v
> >> +icetree.org%2Fschemas%2Farm%2Ffreescale%2Ffsl%2Cse-
> fw.yaml%23&data=3D0
> >>
> +5%7C01%7Cpankaj.gupta%40nxp.com%7Cde3f4d12573845f8b7db08db830
> 6b165%7
> >>
> +C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638247836986636
> 866%7CUnk
> >>
> +nown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik
> 1ha
> >>
> +WwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3DPUeKu1fQmYpTsN72LA
> YGRS2daqnO
> >> +gzATfe0ckNfYdik%3D&reserved=3D0
> >
> > I think on v3 you were asked to use a filename that matches the
> > compatibles?
> >
> >> +$schema:
> >> +https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fde=
v
> >> +icetree.org%2Fmeta-
> schemas%2Fcore.yaml%23&data=3D05%7C01%7Cpankaj.gupt
> >>
> +a%40nxp.com%7Cde3f4d12573845f8b7db08db8306b165%7C686ea1d3bc2
> b4c6fa92
> >>
> +cd99c5c301635%7C0%7C0%7C638247836986636866%7CUnknown%7CTW
> FpbGZsb3d8e
> >>
> +yJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D
> %7C
> >>
> +3000%7C%7C%7C&sdata=3DtufHqsLbzUCQjGG9KzQ5dy1Htlk2gc2Ik5gEAFWym
> %2FI%3D
> >> +&reserved=3D0
> >> +
> >> +title: NXP i.MX EdgeLock Enclave Firmware (ELEFW)
> >> +
> >> +maintainers:
> >> +  - Pankaj Gupta <pankaj.gupta@nxp.com>
> >
> >> +  value, i.e., supported SoC(s) are imx8ulp, imx93.
> >
> >> +
> >> +properties:
> >> +  compatible:
> >> +    enum:
> >> +      - fsl,imx-ele
> >
> > This looks like a generic compatible, not a specific one, but you use
> > it on the imx8ulp. I would have expected that you would have something
> > like "fsl,imx8ulp-ele" for that.
>=20
> Yeah, this one looks generic, so not what we expect.

This change left un-changed in V4. It is "fsl,se-fw", instead of "fsl,imx8u=
lp-ele".
I will change in V5.

>=20
> >
> >> +      - fsl,imx93-ele
> >
> >
> >> +
> >> +  mboxes:
> >> +    description:
> >> +      A list of phandles of TX MU channels followed by a list of phan=
dles of
> >> +      RX MU channels. The number of expected tx and rx channels is 1 =
TX,
> and
> >> +      1 RX channels.
>=20
> Don't repeat constraints in free form text. This is obvious from the item=
s
> below.

Removed the line till here.

>=20
>=20
> Best regards,
> Krzysztof

