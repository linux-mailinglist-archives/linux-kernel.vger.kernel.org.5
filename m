Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AFDD80B8ED
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 06:00:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231510AbjLJE1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 23:27:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbjLJE1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 23:27:14 -0500
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2041.outbound.protection.outlook.com [40.107.15.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E4C8ED;
        Sat,  9 Dec 2023 20:27:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BCA3041fGUlAMXkNQCdfsefNwJ/+bJ+oF1pr++Zegr0hK/GQZKGFpaHfhQ0zm58CWhE8f+0LcneZ4YwhnpbavuQOjIMK7YB32XrdGXwKMLG3Et3gBbbjRlXNSsS32ft2h7w1KpUFkIs3RJ53mJneXa2PvV3cY2XDGZ1RofosyAvac/dxcTaS6wrh0NYoqL1u1tKSClz+W0xg67/BvHg+eCSnqEWbNBlsRLTBWZk32ihGjze0A3semsWm3d4jzvWwS/NHEW59Se4Z0b3eqjozA0zGBQjDLYS3/OPaRI651pytkKrIXDUdSddATYlMSjIPG8SmDdoQeZ0Mp9mpim6JLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dhxP/+YfK1EojN3WvQpqzj+3bWaV3MAugyGXQ+zOAqI=;
 b=SDi2KmQGPD7ECB0gRW2HAtcr8tVo7CBIXCzpSggv9Ug/p4SA2pxiCzQIIDe7HV8ggkh17ne5ET2m9S0i3mthJ8TOuJ99N3SprLqL93rGO6T8XIWmsNAzeRThUq4E/rev3nqHAaKIA1wlvp1U1QFXnjq2waG7B77Uafu9OcwpipK8IAZEgdLyC87CchwmL4RNAHT2LUusJ928+CLyFgkyp2Ipy5FobD/K44eXZDB08QYGrZSolJAvp9t8r791HEISAvvr+RVL8IM40UAoIyn6vceaLvXmwXLqTrMlLssxZUVcefLRO6+aoZcuR9YXYq7DHfX/Z0Xb/zfZxCLWdO2tOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dhxP/+YfK1EojN3WvQpqzj+3bWaV3MAugyGXQ+zOAqI=;
 b=Db78pJd3PkOgAT1rjC9wtvU2F+2OcyJU5A+xDLnJgB5lA8UYa0+0OKhk4CGICaVwfG0o86VEx1od97vDM8VdeBZk472sjDvXdfpC3EVb/Mz4rQcHlMT7++H+VZny8N99MS93leVh1XQ4kqlpMrSImxPZw2vdaFMD9qpTugza6ys=
Received: from DB7PR04MB5146.eurprd04.prod.outlook.com (2603:10a6:10:23::16)
 by PA4PR04MB7917.eurprd04.prod.outlook.com (2603:10a6:102:cd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.30; Sun, 10 Dec
 2023 04:27:17 +0000
Received: from DB7PR04MB5146.eurprd04.prod.outlook.com
 ([fe80::709e:6876:7df0:fc30]) by DB7PR04MB5146.eurprd04.prod.outlook.com
 ([fe80::709e:6876:7df0:fc30%7]) with mapi id 15.20.7068.030; Sun, 10 Dec 2023
 04:27:17 +0000
From:   Xu Yang <xu.yang_2@nxp.com>
To:     Conor Dooley <conor@kernel.org>
CC:     Frank Li <frank.li@nxp.com>, "will@kernel.org" <will@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "john.g.garry@oracle.com" <john.g.garry@oracle.com>,
        "jolsa@kernel.org" <jolsa@kernel.org>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "irogers@google.com" <irogers@google.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "mike.leach@linaro.org" <mike.leach@linaro.org>,
        "leo.yan@linaro.org" <leo.yan@linaro.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH v2 1/4] dt-bindings: perf: fsl-imx-ddr: Add
 i.MX95 compatible
Thread-Topic: [EXT] Re: [PATCH v2 1/4] dt-bindings: perf: fsl-imx-ddr: Add
 i.MX95 compatible
Thread-Index: AQHaKbNLbV9si+3atU615KFz+VRTyrCfelqAgAJ0bsA=
Date:   Sun, 10 Dec 2023 04:27:16 +0000
Message-ID: <DB7PR04MB51468DB108F3003AF52CDDDA8C88A@DB7PR04MB5146.eurprd04.prod.outlook.com>
References: <20231208085402.2106904-1-xu.yang_2@nxp.com>
 <20231208-depress-smuggler-f3069487a067@spud>
In-Reply-To: <20231208-depress-smuggler-f3069487a067@spud>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB7PR04MB5146:EE_|PA4PR04MB7917:EE_
x-ms-office365-filtering-correlation-id: bea4020b-3a59-4b7c-ad84-08dbf9384aa7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LkKoEydtrOJq+F0270yeBqvRt3HuXimhHCGS/ZY/dB+fEQXBS83v5qszDg3hvqljYDb31Qp4QBail+t90i6HH+ZZdNLco19UySQHqlGQvm7iBl04ee1MeS9hOTL0ffkwetKe8GEBqxiPZ82lzuuLzlIMwrCktTt/3HQyvF2ixsFoJPBRaZOwBtycgt0v39GHm6ah0p2qltBlDRuz0AYVkc7eKNwOhqMe2DLU9gW2Pq1wP3uXiCsfulkYSmrJqCZ1DwPn5uEC60v4Vf/FevPpFbWgo2j6U2cJ9tqSwtODsQm5rt1nlFXAZqZFm4hL5EYP3L8UDMq/WyxywXNE4E67qp3uljuNREyHia3ykDlMPc8Mb2WXAYnu9rnW6knjm3/qIdzUzTXmsoBLvwPQG5IsTA1UUKW5ZV7d83IzMJZgAhgg1f3z7cOeJVVmwj3YLaDna8Nw6ri8stFDraKuPYwn9Fucw/gIXo4xPlhNxGyGwEiLTQXwGye5kHTLfAT+bb6jxpp4BAwE3XZWFCHF4bbNl0yJW/+OHwiP1l8oGl3wHWuUkwtz9epv3+ngpbxuRdce+z/4ScRQZEGuVCg8GR9S74Bg4MbXV56NtbmlJx0QZ38=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB5146.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(396003)(136003)(366004)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(9686003)(26005)(45080400002)(966005)(478600001)(6506007)(71200400001)(7696005)(83380400001)(7416002)(2906002)(5660300002)(41300700001)(6916009)(54906003)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(4326008)(8676002)(8936002)(52536014)(316002)(38100700002)(122000001)(38070700009)(86362001)(33656002)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?g3OtttApcfnc/iyeZZE4n3E0rE2HkdSQRUCFXXDZUgtvetcEPcs9RtV++Oru?=
 =?us-ascii?Q?eBgNXel0z2lxonycxJxJn4ZT4ALglyP8htCCbir+rm4B1Vx8XbUzesvVxXqI?=
 =?us-ascii?Q?jN5+QDBkr8XCH7ahaaL7FPQif3zbgXpoI1YKHQaoDGcRK5pZpXg6MUSAZVOk?=
 =?us-ascii?Q?jnZqqI7sykzCMJxGd1HDHeRW6YLYdPs3lMjDGF9WyZsaxLaxD1HpnXm8zW1T?=
 =?us-ascii?Q?LIfU1aQwJEGmb8DdGuqmUS13+q1HNRnfCu1SS43jGBPO5PPNS5crnn7BjO9+?=
 =?us-ascii?Q?C9UaGUEzy3aNqxXnAUJRuuJX27D7eoXUGQy6Iw9jU4RAuUc11MTPEgVGVM4r?=
 =?us-ascii?Q?6MTAojS2zjJC85nayLioR9JRx21bznWX6tirV4Ue6haXMkU49WUEKfGIhWaD?=
 =?us-ascii?Q?YVZ/l2FqEY4Sl3/AjflvybG9BYMPKwq3Azu/iT1FkTBPz4h3W4f7NAq9ZpEe?=
 =?us-ascii?Q?2wULkg/9RIzCQwrDeVwr7y+JRNrQcfHcT3sRNY76/8cIyVMcES+oIV2kfLnq?=
 =?us-ascii?Q?skGrOyoZuxOySkrBgiafmT1iNnA9S8jDRc8s8Jqvd5H4Nl6rlZHKSzlZskwp?=
 =?us-ascii?Q?c4xVZOrunAg17FD+lI/G7U7HKCjirL2oYxGcmjsouGoLzrsUgkCaCAEACUTK?=
 =?us-ascii?Q?9qjl+Xj3hpb2TJbrNNFdbdbvkeBTbruj0SdOg92AUDmjfJGi44eGKcDi4IH6?=
 =?us-ascii?Q?xJHu9+fqcZJn5bUtK8ZZzlK4urj5YwqJJYRBIdiAoM5xU0FwzSCylGVKVDyU?=
 =?us-ascii?Q?5LvgCZBA9BdEhSBLGdP6Z6ff4OiJ+aYBdgRenwzd4/eE3m+8eXraGugtexur?=
 =?us-ascii?Q?eLJBPt33ZXaA+xBan/Y75CkRJGd60CgmoQWHI0dVZ0kmEL5/i7WlRFO+RVOo?=
 =?us-ascii?Q?T2fpPpo0Ci9gl348W/k+MBbzh8LAGrTpZ+Tep2WFiBDGB/OUs9TaUZ5g+9Be?=
 =?us-ascii?Q?E5W7n2UOuxt+TDVyuc7zJ4ZUcFCQlG3imHU4nhW2526vebOFtfNUyoZ/f7Ae?=
 =?us-ascii?Q?8dlClAjh8Y2/POCa8F0cQaNdzK2DXJoih0euWmlQoPUZ5pqvBqniWhsQqnuo?=
 =?us-ascii?Q?8L9br6qGGaEeobafqFh+qM+80dPCe3hFiGtWjE4gIQ/8kIvnAOlKkLkpPra3?=
 =?us-ascii?Q?cBI8HN9o0y4MQhrNxRwUHqbyZ1CX2EDEx3i/XUvxXFpfymAWRQWplZXArvtQ?=
 =?us-ascii?Q?t0FSmEyr9ZGqnWagq+hH1x/q3OPrj6Y5HzzcNQRstanmi7MWHYxWZmmwr5qT?=
 =?us-ascii?Q?z52WiLtZsdTVs+t8j3s1/7KrZfn99z2WBF6D8CmVSoPbBMp56VPrbPQXfXPY?=
 =?us-ascii?Q?tr2lH4rGo7y6li2+floL2xiUobHPOKK4J3UWMfxZw6G+ThjDA15mBo44+iUA?=
 =?us-ascii?Q?NygfkLjHrXbRTX62RYhDnvC73pOJYXt13DH/ez2OdyQE9HQGHOsYeIvM5qpJ?=
 =?us-ascii?Q?ThsT6JgiH90PgavkEhcRz8hSKyEn85MrCwNYyqe2m6R71F/rEO5x/wjvRmU9?=
 =?us-ascii?Q?mMM9I5Bv/qElGQuDufs7WgGQkOzrXV2DvjbgVIdeJctOPBijZCo5/CHIdRRl?=
 =?us-ascii?Q?mSFJ0esieugt7/uwzwc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB5146.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bea4020b-3a59-4b7c-ad84-08dbf9384aa7
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2023 04:27:16.8988
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eXZ+Wyb9KCVPM2yetNqEJO/MdLyu6ASBHHaiTGssm8kZXLVmFZG9/UBp6WWczNxfqcToevYfvItcP9wU2iRDHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7917
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Conor,

> On Fri, Dec 08, 2023 at 04:53:59PM +0800, Xu Yang wrote:
> > i.MX95 has a DDR pmu. This will add a compatible for it.
>=20
> On v1 we had a discussion because the commit message wasn't clear about
> whether or not the device was compatible with existing ones. For some
> reason, the v2 patch _removes_ information from the commit message
> rather than tries to explain.
> This [1] message of yours, that I didn't get a chance to reply to before
> you sent this new version, seems to say that there should be an
> imx93-ddr-pmu fallback.

Thanks for your comments.=20

Just read my previous comment in [1] and found I made a mistake.
Now I'll try to clarify it here.

Imx95 and imx93 have different AXI filter configuration. I need a=20
compatible for imx95 since the driver cannot differentiate them.=20

Then I need to consider below two options:
1. compatible =3D "fsl,imx95-ddr-pmu", "fsl,imx93-ddr-pmu"
2. compatible =3D "fsl,imx95-ddr-pmu"

Both of them work correctly on imx95. When I make changes in
driver for imx95, imx93 is not affected.

For basic functions, imx95 is compatible with imx93. I select the 2rd
form for simplicity. If the first form is optimal, I can change it in next
version.

Thanks,
Xu Yang

>=20
> Cheers,
> Conor.
>=20
> 1 -
> https://lore.kernel.org/all/DB7PR04MB514668A8B172CD1A2187BC408C84A@DB7PR0=
4MB5146.eurprd04.prod.outlook.com/
>=20
> >
> > Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
> >
> > ---
> > Changes in v2:
> >  - no changes
> > ---
> >  Documentation/devicetree/bindings/perf/fsl-imx-ddr.yaml | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/Documentation/devicetree/bindings/perf/fsl-imx-ddr.yaml b/=
Documentation/devicetree/bindings/perf/fsl-imx-
> ddr.yaml
> > index e9fad4b3de68..1bc7bf1c8368 100644
> > --- a/Documentation/devicetree/bindings/perf/fsl-imx-ddr.yaml
> > +++ b/Documentation/devicetree/bindings/perf/fsl-imx-ddr.yaml
> > @@ -20,6 +20,7 @@ properties:
> >            - fsl,imx8mn-ddr-pmu
> >            - fsl,imx8mp-ddr-pmu
> >            - fsl,imx93-ddr-pmu
> > +          - fsl,imx95-ddr-pmu
> >        - items:
> >            - enum:
> >                - fsl,imx8mm-ddr-pmu
> > --
> > 2.34.1
> >
