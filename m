Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88B9278B2C8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 16:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231439AbjH1OPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 10:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231797AbjH1OOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 10:14:55 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2083.outbound.protection.outlook.com [40.107.14.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCD5A102;
        Mon, 28 Aug 2023 07:14:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J72IZrRMZUQxMN3tApcd9zPHfGTjngnx/II4zu/kGD4JAy+7Alb6+FlcGi8TP6nA8bFzCN01HIzcO7HGxHp18d5n3mufXs6y4MN7V5FgQBcifbAhEEWDqXl3lCvbUjORyOs1Yx6CME/c53aJ5nSiULuvK6ThiJgL1bPkKbqZfjoC6o3VOzavqnP+2WSx2Ev/kNNm/13BRUP49CQM4S74c15MQPUab0TBlAPNA8S4+yek2k4OxbPGTNoS8W8vb40r8V+BgkPWsOWR+FKJhB9xMzoo5FbtbRyeeg7JyKF56rSwqrA6lzNUCLp8x2ZJYWObA9cZwoHdJP+GQ18NFSl4gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7SGMDXwLLNwimDa1+2fz/+ptbpkqZUUANetO8Oeukzo=;
 b=OqoGt3fWqCaZSGmn6TaTwrT+4Gs+jV+vxBvfLD90pAXQqf5FDK/PwXK695eLbSPhioBddo0wDVMTGXY6sFWAvjtlOIsIivfaIv6vz/RiRDt7LWnTCoh/p9SkRmyb41m3TCReQCL1ow8PWJidbi/rBO+tJ9fRc5nob4+nfnEpvVS+4hsPcQCjop3Cwf1wlvGxOhWCyiU7xXmn4a+VY+aOdcsZuUimmHhyRbM3ztisanPR0wJcZUBmMXD74c+WiLFlr0y30DeN1bVi0NXFA1/WKwLCvHDbSer0MKj/0QwpQRCD16WIgpq0G/GdnHWTv4z3j4/kqyd1Kgo0ULoGwjNpew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7SGMDXwLLNwimDa1+2fz/+ptbpkqZUUANetO8Oeukzo=;
 b=frXUq3fl8NqyeNSQFNLDTpd7qDQGc8b1cd78Qtb8Mznlt8+H2WEy12S23IQFNgNRS1MJPZCMA+8DmKZJpivXdYtUrAfdTKMPOpCUfAeojHFMf/0YgoKl/9qnKjFCdp2zVpPhbDONetvYqeB2V+ReV8b7Cy1ZsLdVhpmhLuZ210Y=
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by DB9PR04MB9774.eurprd04.prod.outlook.com (2603:10a6:10:4c5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Mon, 28 Aug
 2023 14:14:48 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::d4ee:8daa:92f4:9671]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::d4ee:8daa:92f4:9671%3]) with mapi id 15.20.6699.034; Mon, 28 Aug 2023
 14:14:48 +0000
From:   Shenwei Wang <shenwei.wang@nxp.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "imx@lists.linux.dev" <imx@lists.linux.dev>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH 1/2] dt-bindings: power: Add regulator-pd yaml file
Thread-Topic: [PATCH 1/2] dt-bindings: power: Add regulator-pd yaml file
Thread-Index: AQHZ2boA+eQCLw1OHEa+mlsHM6jE0Q==
Date:   Mon, 28 Aug 2023 14:14:48 +0000
Message-ID: <PAXPR04MB91850EEDB09A2872E9D94AB289E0A@PAXPR04MB9185.eurprd04.prod.outlook.com>
References: <20230818153446.1076027-1-shenwei.wang@nxp.com>
 <CAPDyKFqsn6kVjPFUdVyRxNDiOaHO9hq=9c+6eAK4N-v-LVWUPw@mail.gmail.com>
 <PAXPR04MB91858254554272C90822FED1891DA@PAXPR04MB9185.eurprd04.prod.outlook.com>
 <CAPDyKFoV2Z=-WUiF3SgXqhF+K+r5QqsLgz8_hau0WKfZxTzYpg@mail.gmail.com>
 <PAXPR04MB9185F6AA20B0440B8FAB847789E3A@PAXPR04MB9185.eurprd04.prod.outlook.com>
 <4e2c18e3-b1ed-6361-3998-5de060d2bcf0@linaro.org>
 <CAPDyKFro6roynXuS1caARpMK08hvARQ7mQfiJcDgCyJXiw=nzw@mail.gmail.com>
In-Reply-To: <CAPDyKFro6roynXuS1caARpMK08hvARQ7mQfiJcDgCyJXiw=nzw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9185:EE_|DB9PR04MB9774:EE_
x-ms-office365-filtering-correlation-id: 7572a10b-405d-4415-3115-08dba7d1236a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EAji+X+302snc6LK9ldeU9UXql/YkXLoZIqzGCg33knc6KLgPUFpfZL8r16w18wERogohsLp4JPhiDG+NgWNw3MxtTE/rtEhyR5z+0Gq3rAX6+d4M72E1kMQu0oVe8XU/So9RyY/arYf4qzsht6W4mZzEvyBIVmTEnUCks9KnzJea9J6jxhDcBvwAKIzGiZ+/leTs+b7S8OFv6dwTFBvLpoJedMl5918TMbGd82zqf8QYaiZ3gdAFSL4RrHTO2EAVHllD89fHU/mPMH4e/ee/frbuS6c7oIa+1W8/OPYEUvEyJXMs3XUiVI6VUDe1sQwj82vYHWLRfL6bJ3wVrZYQcbMj6cwM/kMpxUPI+1fStSIaYdsCYuJ2RioetBHRmUCs90Mff0BXCcYEAA+PS6gW9KnHGq8vRDehUO9o1noRYjCkxJTvhULx2EalkLTQjBCR5VQB2UN9vB1/9be8SA18w+vVdKLef4NjLRRUbx2micP9AEIh3qLS9zMMr+2SeDKp/rtmimFFmcDIWEWgCkezD1jZtv+mcnclf2dVwYLlpZBG2eMw0n6/kj05qrBgxweJ55kN4Eurx//iM3xlH+0DzfwiA4Q2fIaP3vGPdEYYCA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(136003)(366004)(39860400002)(451199024)(1800799009)(186009)(71200400001)(6506007)(7696005)(9686003)(53546011)(45080400002)(966005)(83380400001)(26005)(478600001)(55236004)(7416002)(66556008)(64756008)(52536014)(316002)(54906003)(66446008)(8676002)(44832011)(5660300002)(66946007)(76116006)(110136005)(2906002)(66476007)(8936002)(4326008)(33656002)(86362001)(41300700001)(55016003)(38100700002)(38070700005)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QqoVIOneVkh+JAfHrmV6awzFoA57DtqVBcF/tOdroSb0Uecwza0HIC0NbBHK?=
 =?us-ascii?Q?3XAjDJHsqMIJjEPfUnmpa/6hYbvuTOkobytUz6n9wm3kfkhfgbKgIJCg3+ym?=
 =?us-ascii?Q?wO/TCu6Vx62A5AdHqUatVh96oeRctIruTw1zKuPDy4V2CNuoax6HkhOqzF90?=
 =?us-ascii?Q?zMaITnx21aWcgXhf+uDG82W3Zxdcv7mqborJ7O/0z+p1QJgFr+94g2M74VeC?=
 =?us-ascii?Q?gGb7KVq6KmUQwtIso2KstvoIF3ADdGmFXZlEyYehGN/GpelOPeGusARPVMli?=
 =?us-ascii?Q?i2k5TRlHLViUouAF3Tucml4kyY8e9c3aroMHu8uQCi0Y10OSuQpmUAM1gOhM?=
 =?us-ascii?Q?rMI5WfLAdNV0ufKNXNh/NgGDoOYgk32/CXReHeJcNvh3DAzK3+EEVtkq11Xw?=
 =?us-ascii?Q?bXVbJ//0X7YVl1lrs1oZU8+pfhMSUC0VQcIIuzkOKdAN9S/ynl+a6NUZpIQm?=
 =?us-ascii?Q?JAwDMNhKa38PJjP6oP2fQ0w4bFW+v9jw1ApPKT2RW1PfbYwU2a6yLaqffOfo?=
 =?us-ascii?Q?CzZGWA2ph4NRB6vVeRzmfL4dJZvVNs2X2fQKHIxZmqb2NDWGjzruW0jxyJaz?=
 =?us-ascii?Q?mLY1ttY2ho1bT4WV3jJAgspWwi+WLl1xdY3QDZE/Sgl3+Raw25YyTHi0vtfv?=
 =?us-ascii?Q?tZ+lh1/XFAAE7V+REUiKNPSx4s6LAv1ramxsQZkbPWKH0vf7EXiIGpH83Ubs?=
 =?us-ascii?Q?898TBtYEStKeN5+NojfapbjOEa+ydOVopVqzwxA8Jg2lxTFhi87mRfLOt53f?=
 =?us-ascii?Q?O0otOT4rZvfeTyQDNb0wSL8y3mlmtOqIY/Zy53BpQWCZPFokEif/5GpIOvZE?=
 =?us-ascii?Q?9XKLkywv7O4VHtoSjbhcUzdyGOuYDZsFXfTjtkopFvtkTIanHZ4eA/Rhdru9?=
 =?us-ascii?Q?38bvxXRGhep55CtfG/6qpFa3fV++rZIANltTuZijah80YBj8WpF99uYjmJi6?=
 =?us-ascii?Q?CrHq9i+1+ynpaAfeopRgDSuYJ3CVp1q+xRo1CWTf9BElLlGgHLKJYuPn+paP?=
 =?us-ascii?Q?eAzkJ2Oq/aVNjCE3tTbIUjhQU3OsKo0YZI8RBnjOekNUtDOqWLEbMQQGdKs0?=
 =?us-ascii?Q?/dBFjwC6ODUdS/ITD2GFREggSsO3vApaDzWGlkgecUTlwYZhvEeDYZY2Abor?=
 =?us-ascii?Q?3ABJNxgHPqiAYrIaR0iJrw68PhhUKuWkut7vLecoEaEnCjhxSEkeRuxmpZNc?=
 =?us-ascii?Q?rARQdOoJpyRAvCwXf7k9c055PaECI3ib7UiuotUOS3zn3MEUHxqYKjgNaylK?=
 =?us-ascii?Q?Utl2x0MRaCBwMqxVzI1g5Qep410awRzWJIlgBL7fnVvTrJiSQnh3tySWlNMb?=
 =?us-ascii?Q?8bH1LUZ1r4DXa1WicjdDz2D9FkDGqfLPFjn1Kz8UXfbVksr4b1W5MuRjL8TD?=
 =?us-ascii?Q?gwN4MWSUA6PjwGz+bklGWorVtB+99UHczmcXxGY6GAoozFSYKqnSH5qhGiKo?=
 =?us-ascii?Q?EN4lSICr/V4vp3vOOioemlYWUveqKtdEYZOWkYIHXUXd8xwPItqKdHmHQA+0?=
 =?us-ascii?Q?xlhoKDqjqAw9X9+gHqpiryWrW1R98UmrxZbj1FI/d2rHtHNsyjOABHfciyIw?=
 =?us-ascii?Q?VnrnAWIPwkcG2ynZYRgG+bFiXWm0Da6tBqdbtScO?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7572a10b-405d-4415-3115-08dba7d1236a
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2023 14:14:48.6891
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DbY6icFakoV/o5gzcvJPVZbF8rDjHolp6cjvDMTfUc0eq3Lg3+Pe8uFBLUSZoovhuULwm8KfyIQepeOrrrUydQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9774
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Ulf Hansson <ulf.hansson@linaro.org>
> Sent: Monday, August 28, 2023 4:59 AM
> To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Cc: Shenwei Wang <shenwei.wang@nxp.com>; Rob Herring
> <robh+dt@kernel.org>; Krzysztof Kozlowski
> <krzysztof.kozlowski+dt@linaro.org>; Conor Dooley <conor+dt@kernel.org>;
> Liam Girdwood <lgirdwood@gmail.com>; Mark Brown <broonie@kernel.org>;
> imx@lists.linux.dev; devicetree@vger.kernel.org; linux-kernel@vger.kernel=
.org;
> dl-linux-imx <linux-imx@nxp.com>
> Subject: [EXT] Re: [PATCH 1/2] dt-bindings: power: Add regulator-pd yaml =
file
> > > If I understood your reply correctly,  it seems that the current
> > > implementation of regulator-pd is what you have described. Please cor=
rect
> me if I'm mistaken.
> > >
> > > The following are the diff of scu-pd and this regulator-pd.
> > >
> > >     power-controller {                                               =
     power-controller {
> > >         compatible =3D "fsl,imx8qxp-scu-pd", "fsl,scu-pd";      |    =
           compatible
> =3D "regulator-power-domain";
> > >         #power-domain-cells =3D <1>;                                 =
   #power-domain-cells =3D
> <1>;
> > >                                                             >
> > >                                                             >        =
 regulator-number =3D <2>;
> > >                                                             >        =
 regulator-0-supply =3D <&reg1>;
> > >                                                             >        =
 regulator-1-supply =3D <&reg2>;
> > >     };                                                               =
     };
> > >
> > > Are you suggesting to move the regulator-pd to the imx directory and
> > > add a company prefix to the compatible string?
> >
> > There is no such part of iMX processor as such regulator-power-domain,
> > so I don't recommend that approach. DTS nodes represent hardware, not
> > your SW layers.
>
> I would agree if this was pure SW layers, but I don't think it is. At lea=
st, if I have
> understood the earlier discussions correctly [1], there are certainly one=
 or more
> power-domains here. The power-domains just happen to be powered through
> something that can be modelled as a regular regulator(s). No?
>
> Note that, we already have other power-domains that are consumers of
> regulators too.

Can you please point me an example? I would be happy to use the existing im=
plementation
if it fits this use case.

Thanks,
Shenwei

>
> Kind regards
> Uffe
>
> [1]
> https://lore.kern/
> el.org%2Fall%2F20220609150851.23084-1-
> max.oss.09%40gmail.com%2F&data=3D05%7C01%7Cshenwei.wang%40nxp.com%
> 7Cebeaa5d30be14033509f08dba7ad7dbd%7C686ea1d3bc2b4c6fa92cd99c5c30
> 1635%7C0%7C0%7C638288135797275723%7CUnknown%7CTWFpbGZsb3d8eyJ
> WIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C
> 3000%7C%7C%7C&sdata=3Dre2A5wbng9haHoMKTbPICh%2Fh9VJVsG66H9jybd2fN
> k8%3D&reserved=3D0
