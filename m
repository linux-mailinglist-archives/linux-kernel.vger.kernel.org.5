Return-Path: <linux-kernel+bounces-25647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B66C82D40F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 07:03:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 481CF1F21773
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 06:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9FAD28E3;
	Mon, 15 Jan 2024 06:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="exLgzkbX"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2052.outbound.protection.outlook.com [40.107.104.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23533C0B;
	Mon, 15 Jan 2024 06:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EIyxidYazEElfx0fWYJPisE8c4Y77vdDzEDmxIorOEvDBWdofhFSoJ0RlxiHb0x6NkUi2Lw2weZrLZ19jteVfHjdsNJIW6x7INS1Qqt++eRDc+0WeAg8ybRSGsI0DrC79OQmPraNa7hmUKtGYHrlMHGTkkwgeWKVKGBbGoTSfH3cnzu+b6wdMp0BuvQZ3Vva7dpX59QBX2zHPx4Jzkr+JGRos9PYcG2iYXjRHfYZUn/Qn64F3mYVTjkX4FxdcQ1r1parrwcSzW5uyeYotdOsaiKa0CozrUMJ1kAyTXdCt5PRKfMtq1UJNSLF/KHV4KBEAE5e912eyrc1U8P4d2idEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rw59AOYiU0VT8TYbNGkpDIEUux2FpyhTsMrzwOF7uNM=;
 b=R6ICDdJG/er6ctHNzxFB3G/OYNw5wsE+rvmu5xo9iKT0QWjw/J6gCfnUVYkviq+JaL/QfZ0kz0aEZ7QJ3TvPMbfohLztlioelPOiPkMmZDABddXfQB/oFBleatrMfltf4jnQYcnjKaLDIz+JRCE1yAvCXHL0qHuwn7yFYPmztzKfFOB2cBqbz37IiNbESlFp7Kn61sdhdBMf5os09Tihb2DUgmF1B3W9Y7z93AZPLMarBFTt9dGsHICV7wXB5ewoJEwA6cKz/VdEmNzsx45G7VFRi5i+He/a8T25dwPnOsfW3SXf1LNN5Dmxw7MsaALBjYnsHz2L8IhBNhS6wbnGmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rw59AOYiU0VT8TYbNGkpDIEUux2FpyhTsMrzwOF7uNM=;
 b=exLgzkbXLYlxd6UFjgcRo8nRLcsVHHCesWvSCC8guGszV5HKhYNbwP3o5KBtchhPMEyzPKWe24Ef5sRV8e4aOXDTyynH21OyVHjIZlj0l3qgcywgk0Dvkmxfd6CYAVKJD3aF0dMrc/AufghiZS/O8YIebpbHr6jKpJX0Nmj5K2g=
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by AS8PR04MB7557.eurprd04.prod.outlook.com (2603:10a6:20b:294::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.23; Mon, 15 Jan
 2024 06:03:36 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::efd8:23d4:18bf:630a]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::efd8:23d4:18bf:630a%4]) with mapi id 15.20.7181.026; Mon, 15 Jan 2024
 06:03:36 +0000
From: Xu Yang <xu.yang_2@nxp.com>
To: Frank Li <frank.li@nxp.com>, "will@kernel.org" <will@kernel.org>,
	"mark.rutland@arm.com" <mark.rutland@arm.com>, "robh+dt@kernel.org"
	<robh+dt@kernel.org>, "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>,
	"john.g.garry@oracle.com" <john.g.garry@oracle.com>, "jolsa@kernel.org"
	<jolsa@kernel.org>, "namhyung@kernel.org" <namhyung@kernel.org>,
	"irogers@google.com" <irogers@google.com>
CC: dl-linux-imx <linux-imx@nxp.com>, "mike.leach@linaro.org"
	<mike.leach@linaro.org>, "leo.yan@linaro.org" <leo.yan@linaro.org>,
	"peterz@infradead.org" <peterz@infradead.org>, "mingo@redhat.com"
	<mingo@redhat.com>, "acme@kernel.org" <acme@kernel.org>,
	"alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"adrian.hunter@intel.com" <adrian.hunter@intel.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-perf-users@vger.kernel.org"
	<linux-perf-users@vger.kernel.org>
Subject: RE: [PATCH v2 1/4] dt-bindings: perf: fsl-imx-ddr: Add i.MX95
 compatible
Thread-Topic: [PATCH v2 1/4] dt-bindings: perf: fsl-imx-ddr: Add i.MX95
 compatible
Thread-Index: AQHaKbNLbV9si+3atU615KFz+VRTyrDanSGg
Date: Mon, 15 Jan 2024 06:03:36 +0000
Message-ID:
 <DU2PR04MB882292D4D284A000A9342EA58C6C2@DU2PR04MB8822.eurprd04.prod.outlook.com>
References: <20231208085402.2106904-1-xu.yang_2@nxp.com>
In-Reply-To: <20231208085402.2106904-1-xu.yang_2@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR04MB8822:EE_|AS8PR04MB7557:EE_
x-ms-office365-filtering-correlation-id: e8436c45-322c-4cd3-9267-08dc158fb679
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 I7blsfjPqqR1Cxx4kticD0gqGsltnlHt+niEnc9Em/c3nb+i4vDyuNWoJDGgrl+B9p7U4LVAM7KcQ7zZdsJSiBiAduAmIRIpu0TLPdJXXxmXXe+Nmxhrq3tn4g9K7NDuciumo34h6nRcY6/RIwZboc5hGyBMo4XEEvB52eyRvloN6fzDutbz4oZWwMUAzz2wGKzs468U0CJHDsdad4Xg5Px7NM+8i/lqoDbdcl3SxVvePevIO+OGYVc9XG/BZH7Qz/x8cZHeJzXOc8nKNTg9d0LSoIT2ochVmSm6rZmqJMApOQznDstHJM4m56AOr0hH8dIaW62m09lnKVR2YMTuZK9anrVkVr6ncUgUt87rApadgU7+7LJ+rFqQTq7qzFuphR1nP61SXtDL7YUhgGlj+8UJRK3ENUYF70mfJ9glIXpvvUYIDqgONWiLMUGq52HhlA2GDBlakmWJZEP6vBz1hYyjsWY91hVF2LY0a6Zlu+8SlWs84UltuoGxbixnXSZCzoifOOSxKJM7adu5VEs8bPR5hnAUIAn8nEIRPMyYll7q/INJAY0DzyGmtUa8x71EZRTcSxU6MJlhqvI7tD/ZN3goqBYQkqUc49syYa3L0ECg5RXfpZ1miM+4NcLMbUebsUn74owq5YiqlY2M0BPEIA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(366004)(346002)(39860400002)(136003)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(55016003)(33656002)(86362001)(38070700009)(7696005)(8936002)(4326008)(5660300002)(52536014)(122000001)(71200400001)(9686003)(26005)(38100700002)(8676002)(66946007)(316002)(7416002)(921011)(66446008)(66556008)(64756008)(54906003)(76116006)(110136005)(4744005)(2906002)(66476007)(41300700001)(6506007)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?2QSY8f6cggGwYf+WFaIQ1JslFs43mr7S+HIZPvfW19qgfWI0wiPj6/w4Ls8N?=
 =?us-ascii?Q?/niq+c7wjXfi5/N87Kx2CVbkJ2qlMHfjgltktTI56JpC935YW1slOSGMJYGb?=
 =?us-ascii?Q?BtsVsOL/fzo5MndtbyzoMvB2ubiqUXPg19oJE8jOv180B4dYM7bzOlr6qnoJ?=
 =?us-ascii?Q?Xu/SqlHI/UFp6N19Goanrl9axA6Z1ibG85LsgAUX45iBdUSlziuc9wEOQ9VU?=
 =?us-ascii?Q?MQBYeFb3CqPsQM6LqUV38Nyz7v+Qz5kmIRzpg99wpd1P9BzYVo4tG2dceP1p?=
 =?us-ascii?Q?NolH/v3BnnJVCEwXO5W3l7vV26c6muCE2GstF7viQcSky48IUFGRqeSX+lvw?=
 =?us-ascii?Q?oawfipbp36PWb4Lyt+Kg4Ac2nxCVoQHoVwG0P2+u+QXQI95EuNBplKe93ufY?=
 =?us-ascii?Q?TDQ4mwWaEFVN+JR2iGKDNIqea0VIibwbjqIgPukkceZE5YPJbiLzbQgHpia3?=
 =?us-ascii?Q?cggyxtFzvfIGzXHih2omHGQzTYhQkN64SJMhbvRa2vr5uH3TbS4Gx0Py5gzV?=
 =?us-ascii?Q?NPsHJIQtvXEdZoLnyaSsVVKRsYSBBeOugNUNkqCiRlGkqGmFXq2Vl38lv0rW?=
 =?us-ascii?Q?3pdvnIWyYcOaxvsOmL+W9830qcdE75IHrnuhXDdIcVkZncLIZygy+sFXrA5o?=
 =?us-ascii?Q?AuCKYVwkrMLN7ezW8/fYYYf19xhxmYUEmlpjnJEZRok++cqg+WpSB/lb2ULb?=
 =?us-ascii?Q?BSN7mflWlxCp9wfjmvtYs9RFIi+KM00fOlmK0nRr3GK+Pr5v42SAb6TuuKWe?=
 =?us-ascii?Q?VwfU3gpHfVtVRW9m4Ei3zsOeOOMM52rrvGuVDdjRacLwQSfpNJI8vOQWmjay?=
 =?us-ascii?Q?4cJ72uIUxB4QggnQAjDZZqJsSPO4X0AW0geZG54/m0Asd3YY08D500BtzQro?=
 =?us-ascii?Q?sLJUYUepV9KnWZVMG1VhOlfBhrBP8RFo2Ptu6YpJetUuT7HBMrckaLxvCEfK?=
 =?us-ascii?Q?FIrLxqAeZGS3+s7WxfmmUURaE2pSy5mKRGJfQhUH8ZpJNMwrAQdIzEyAZk5L?=
 =?us-ascii?Q?vIhcCIJOzs3rHSqPFYTsFJ7MxemWfPcZQcxSXvK2vbCKeuukInrAqla4KE3A?=
 =?us-ascii?Q?GMUK9ySJk4Pcr/NJwXQa1WizwCc7jshOwVVNudbxUV0NOS4JIufs95de0b04?=
 =?us-ascii?Q?GZQkb82K5WxIZZH19pzP+aL4w6OQ7+KJq6D+ApTDsA7cgsHOXP3LPh8bJ9FI?=
 =?us-ascii?Q?/vIAdDJt/MqedN80y+6tC9JAaHHLjiMYsdaOTnQ8XhndS50+Xd2UVxFNOkv0?=
 =?us-ascii?Q?KI6WSKive5xIwrcLOq6JxN5mvQqgtYLaTCvqJ5tKGU520Bm2z3HPaxmlqeIJ?=
 =?us-ascii?Q?miT3NazAOxJFNb6tuz2jvQ/VNYE7Vns9wXvovdayXrTLDOPGtLZjaYNKleDO?=
 =?us-ascii?Q?RHnOKbFyxxEegjrDKq/qC2FtuYeNYgDCE0YN5UTDlxTfs6KwsPe8YM+m9Jbv?=
 =?us-ascii?Q?deOR53IUp8dH9fl25RdsW54zD4LqP1LbZDH49yVVrNkncTcvsRXo4ShibMou?=
 =?us-ascii?Q?dUjrcgv6yh6PBO9fNUFw4AJAHoyfK+S4WtfwZdqGD4y8XPBnSYhsNzrhH11i?=
 =?us-ascii?Q?EpQJHE4oZsh+iAfRzZY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8436c45-322c-4cd3-9267-08dc158fb679
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2024 06:03:36.5225
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KMFgJaX9PC/PDywNtpvihKQX4req0AaLD/j4KKgzbIDNni7oylDY0SY5bbwwQ6mwphPT3dEM5ks8dWZ4BAUMjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7557


> Subject: [PATCH v2 1/4] dt-bindings: perf: fsl-imx-ddr: Add i.MX95 compat=
ible
>=20
> i.MX95 has a DDR pmu. This will add a compatible for it.
>=20
> Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
>=20
> ---
> Changes in v2:
>  - no changes
> ---
>  Documentation/devicetree/bindings/perf/fsl-imx-ddr.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/perf/fsl-imx-ddr.yaml b/Do=
cumentation/devicetree/bindings/perf/fsl-
> imx-ddr.yaml
> index e9fad4b3de68..1bc7bf1c8368 100644
> --- a/Documentation/devicetree/bindings/perf/fsl-imx-ddr.yaml
> +++ b/Documentation/devicetree/bindings/perf/fsl-imx-ddr.yaml
> @@ -20,6 +20,7 @@ properties:
>            - fsl,imx8mn-ddr-pmu
>            - fsl,imx8mp-ddr-pmu
>            - fsl,imx93-ddr-pmu
> +          - fsl,imx95-ddr-pmu
>        - items:
>            - enum:
>                - fsl,imx8mm-ddr-pmu
> --
> 2.34.1

A gentle ping.


