Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5879480065D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 09:56:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235234AbjLAI4o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 03:56:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjLAI4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 03:56:43 -0500
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2089.outbound.protection.outlook.com [40.107.105.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 105EF12A;
        Fri,  1 Dec 2023 00:56:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e/UXeFHeO619JVpv1U/W0DNPvir/1EpS6aDHdm2xyaC2QxT5CUBl13P+9mLcgla0FO567FkypEHgsAfCa/ziQXI3eOKyMGO1EeKozo949GhYy19es/WsrenaddnQhy0neqPnbLBkhUzkD1Fx6eiov5cbxF4SDmVVkUDAVqseP+3u9k5QksXO0PTja7ZDkYml9QpY0tpBAI5cudagb42CoTyicGWNJmpICtHwTeDYh0ND8ggYCYze0+pE2f16Kn7KZjd0iwR02fVEvIvGZwJyME+eLPPtBd4zZ/PBEoOufbFV5W/p8rJJXcfx8MdGkuLQ4RVPqmY9fFiOUgZHNWUyjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zdmE85RgDHjk8rO8vXxyiV8gyKk9WB1rZGbxkBVehNo=;
 b=eQwE0ZOLj7vqtEKbG289zg/ITzdAVkIl+xxh80wonC/lFAPftQ5EO9KIR+GjbWVzUcwWRI/hE6d2CcGFUab7dKxex2/6rowNwFtp95qWiYbjaN8r2aBlaAKLzDophugud4PzcfQH5wCDaaBYuCzdp01NxAFntC7fGgGOMTPvwVkKl7eY0MrsoQy7sTxXpxnqneTBsDhNkAFIGse5cAhu35vkrV1dL6wkOeE/OYj/4skeOxG/aGK77xDLX5efuRvoIm3W2ATwFuQXhanHJ8uOAu5N7WpBk3odKUqeVBf9/VMmcYRW8uP6Zy8tNgvcMKo2+aWov66AtKI/BLKYwA5IJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zdmE85RgDHjk8rO8vXxyiV8gyKk9WB1rZGbxkBVehNo=;
 b=rf2/sRrV3xjQcy3ccfgsy4TswuEDNTjmoguqttT6z+XFslLEMpOXqH66nrMTIZy2UxNXopXaiFEU9xva0gJdKzYsYDtu+kG68rmq2F4Vmt0M1jYCmf2WzP2k9mie5Cwjh7+UayM4x2xTT7VwtsUbaGjXxemSVhuD0ZkXsGVaZhc=
Received: from DB7PR04MB5146.eurprd04.prod.outlook.com (2603:10a6:10:23::16)
 by AS8PR04MB7960.eurprd04.prod.outlook.com (2603:10a6:20b:2a8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.13; Fri, 1 Dec
 2023 08:56:44 +0000
Received: from DB7PR04MB5146.eurprd04.prod.outlook.com
 ([fe80::709e:6876:7df0:fc30]) by DB7PR04MB5146.eurprd04.prod.outlook.com
 ([fe80::709e:6876:7df0:fc30%7]) with mapi id 15.20.7068.014; Fri, 1 Dec 2023
 08:56:44 +0000
From:   Xu Yang <xu.yang_2@nxp.com>
To:     Frank Li <frank.li@nxp.com>, "will@kernel.org" <will@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "irogers@google.com" <irogers@google.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "acme@kernel.org" <acme@kernel.org>,
        "john.g.garry@oracle.com" <john.g.garry@oracle.com>
CC:     "james.clark@arm.com" <james.clark@arm.com>,
        "mike.leach@linaro.org" <mike.leach@linaro.org>,
        "leo.yan@linaro.org" <leo.yan@linaro.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/3] perf: imx_perf: add support for i.MX95 platform
Thread-Topic: [PATCH 2/3] perf: imx_perf: add support for i.MX95 platform
Thread-Index: AQHaIQMQs943ftJA00aqZJqEzdYhYrCOSeAAgAW3NgA=
Date:   Fri, 1 Dec 2023 08:56:44 +0000
Message-ID: <DB7PR04MB514625010B5F864012F7B1EE8C81A@DB7PR04MB5146.eurprd04.prod.outlook.com>
References: <20231127073208.1055466-1-xu.yang_2@nxp.com>
 <20231127073208.1055466-2-xu.yang_2@nxp.com>
 <VI1PR04MB4845D4B4CB68648CB3C1081688BDA@VI1PR04MB4845.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB4845D4B4CB68648CB3C1081688BDA@VI1PR04MB4845.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB7PR04MB5146:EE_|AS8PR04MB7960:EE_
x-ms-office365-filtering-correlation-id: 3841a665-17e3-4369-cf1f-08dbf24b7199
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Z+dS1WFOP2Al6rYAREXTOr7126R10gt1gYIkWUMxohmjP8g5zRKGQmhSeRwLPkp/YUXMlmSZkYdkpl2YcGIH5GaQRHi0y8n3Mrn6uT896JfGprNdARdjsPUCS54us/kzLhxshGle/WYJHHS7TNyaJPgwJsAflQ+rAQm7XUL58U6G9UjhDoFM431nPQ03oDavG74mZdii0a+FJzy+LmMseYXgmtEK2ISd/oRR2Z4v4un6A38LVoXtPFzY6CFqsPVew88OKvOYMXw/DcTiB2hqJwDrqwb4Un8Sr32Oohb6KqPrmFfdqVNH8zvcZikDgYlHNOIFy1sYpQhBo/0RZri7tVys3MpffSLB9aqssp8vzKCmIhqI/LiIBebucN+VIcru76j/AtZRF7O0ST0NYYBrxSReAsipmcN6Ex94Cr14JAzvGHYNJWnut29O29mIxm+sPhJSZ26vzlkYNz0PIheKnKj08dOUR+hv1WJyDORXoz3W4C8TDLcscVBk8o7Sb8GmTQ3d3aIDKX+HxbYmNkIQncxyzJDIkJVsDmEkQE8acQhUjqXSli7ynUsEI5PjHRTfoEcXPsLa3SHpkT3Taf3i4diV5tGUSv18rLOaQRJSksONfLceRN65Gn1xfz79Brn9yCmgcndfEklhbI9+/7HlRNmIAqL41/F9uWgOrxcWlsTimyRGtBiHdc6Y27Pt4wmP
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB5146.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(366004)(376002)(136003)(346002)(230922051799003)(230273577357003)(230173577357003)(1800799012)(186009)(451199024)(64100799003)(86362001)(52536014)(4326008)(26005)(8936002)(8676002)(122000001)(55016003)(38070700009)(38100700002)(41300700001)(83380400001)(9686003)(30864003)(66446008)(5660300002)(2906002)(7416002)(66556008)(66946007)(64756008)(316002)(66476007)(478600001)(53546011)(6506007)(76116006)(33656002)(7696005)(71200400001)(54906003)(110136005)(921008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WBNxg6jbeuSsLGp6fOsF4ZNgaNiffomZr84sweIP+hRtm5Z8LBKoxHQqWQ+m?=
 =?us-ascii?Q?cACf1gKOswxvPW2PpO4FmSX+Ey2mlq3QopnU7elh0corTysbId//BHJyTY7n?=
 =?us-ascii?Q?eDHH//tw5XgUfOUEJPb46/q815yNhvH2n+1ULMEYTpP5/5RRwsZHnOYsCWa8?=
 =?us-ascii?Q?h5nFBW3NT/rVeltqCPJ2yZmAVG1CowyZztNbeNXWoxEPtNn1XPMsrpqia+Ua?=
 =?us-ascii?Q?PrycJagkgsRTs5F6701XEKQJLGb1/aoSm+FcBBlCHbY+Qpc3v8dfDWSXfGVD?=
 =?us-ascii?Q?4HLD8UDQsglMUbp8fjNqXdPr1JjRVkX8NEKKfOpR0ilUQkqlC4aFRVjjt+wu?=
 =?us-ascii?Q?JTu/C6BmcnODTcd6HCfBRDwtcVDUhsvCocB8dXrANAG0QAcTlHuZkRkvP5w7?=
 =?us-ascii?Q?s3hao05vfbhuv12dVTqLXFeoPWjyIxbHn3tZNeoO7lYdrmjvspQ+3qDqkRDK?=
 =?us-ascii?Q?Cw7ojDPC/knU37ON5bCuxKKNSCxln34pHafUxP4dHERHibdQsgJwaSaVV/C6?=
 =?us-ascii?Q?leYOWLZoz8CFvB3VA3VWcuFuveigVsVGYBtijkfvR6gxezTjVZbYCkkIXEQI?=
 =?us-ascii?Q?acYCwPu9LGKGx3mYlFWSNAJL56MVG4RWf2DNAF5w0JzdhUWtgXVwKGI3H2gD?=
 =?us-ascii?Q?zRUnejXCPFDVMf+brC4tjCkdx1rO3b7y2VH8+3U63S+V2ug24GWGyOu39xO9?=
 =?us-ascii?Q?l7+KCHAQ5ZXtrb7olXHyAKnlPlAkH9aW9aAm83MNXyv1jI1CeLTNVd0MYkF9?=
 =?us-ascii?Q?BnoFr5Rgc4qaPrwiEvA2thrUiq/Ok3sa37490bwzR+ui9XNe5XaAYxPlmqVX?=
 =?us-ascii?Q?xeScyc7J6ibUUgA21b7t3gJwpjEbQLc2hwRG2G1rCPU5+5zfl8u3ooT0mSph?=
 =?us-ascii?Q?decBYgC6bgG6JpdxbgUEMkQgh4epbAkK0dOQbe5x7oYXQjISfZVS+8koURlY?=
 =?us-ascii?Q?cd4SwhWMkcc4cGq3cdKawryho8Jns541OhNc2PYJtBb9E/NhNpPgh9HRdOWQ?=
 =?us-ascii?Q?y4rX7VTmON85l9AOviPyOIOnrY1Hq+kwZgYjre3VDRxEdYhe4iccEeAM6JaE?=
 =?us-ascii?Q?zUMDr+TaaodiMel61J00Pvl0KNaSw3HJXShERb32pmB2y8xyJCQCt1et96cG?=
 =?us-ascii?Q?Xg1nraVduw/YJ4I8B+PjfnbCu7heGHTNYaU56EB3abscJLhw8xNHmCloJE7l?=
 =?us-ascii?Q?/fsbDyB+Fv0ijaXuY9Lr6U7K91Pst0MNB6GyGzsQ+sDbi6r2PwByKdSDzAO/?=
 =?us-ascii?Q?kQuJdxHLHyk3TF7zxY5Z47tD3yOUNc1JpHTjqZ41g/05LYM0uX09kFaATEzv?=
 =?us-ascii?Q?4HcZa3Op6VmkkAO6l31dS0uutQ6ncaa3xAGwBfDe0vmE6T/hhXs+0NGVs3C8?=
 =?us-ascii?Q?itKJYizMleN2F3hPB0gp1/TSuD+9S4dh+KsFRVaY2N0cD2PHELTw60Xm/mo8?=
 =?us-ascii?Q?NGFcQg2c8r3Mr+CRBmh3Xh4lAevDb0qHsP0YHscF7kvz/i6r2O+p7fl1Xn7E?=
 =?us-ascii?Q?3tdffRApcUwliqD6otrgPsz7NncRv/s7TRnw1Ylo8857rXMJRzgOChgnfTEI?=
 =?us-ascii?Q?/JxY10tG1m/X8DUASgA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB5146.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3841a665-17e3-4369-cf1f-08dbf24b7199
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2023 08:56:44.5321
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vBjS6O9r77x98xq5jP9FTEu2sem86HBBHkFOhFkAb4XiYcFu77Nb6a7ecjkyniUI77BDCVmS8R+OPaKh8zfETw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7960
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frank,

> -----Original Message-----
> From: Frank Li <frank.li@nxp.com>
> Sent: Monday, November 27, 2023 11:25 PM
> To: Xu Yang <xu.yang_2@nxp.com>; will@kernel.org; mark.rutland@arm.com; r=
obh+dt@kernel.org;
> krzysztof.kozlowski+dt@linaro.org; conor+dt@kernel.org; shawnguo@kernel.o=
rg; s.hauer@pengutronix.de;
> kernel@pengutronix.de; festevam@gmail.com; irogers@google.com; namhyung@k=
ernel.org; acme@kernel.org;
> john.g.garry@oracle.com
> Cc: james.clark@arm.com; mike.leach@linaro.org; leo.yan@linaro.org; peter=
z@infradead.org; mingo@redhat.com;
> alexander.shishkin@linux.intel.com; linux-arm-kernel@lists.infradead.org;=
 devicetree@vger.kernel.org; linux-perf-
> users@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: RE: [PATCH 2/3] perf: imx_perf: add support for i.MX95 platform
>=20
>=20
>=20
> > -----Original Message-----
> > From: Xu Yang <xu.yang_2@nxp.com>
> > Sent: Monday, November 27, 2023 1:32 AM
> > To: Frank Li <frank.li@nxp.com>; will@kernel.org; mark.rutland@arm.com;
> > robh+dt@kernel.org; krzysztof.kozlowski+dt@linaro.org;
> > conor+dt@kernel.org; shawnguo@kernel.org; s.hauer@pengutronix.de;
> > kernel@pengutronix.de; festevam@gmail.com; irogers@google.com;
> > namhyung@kernel.org; acme@kernel.org; john.g.garry@oracle.com
> > Cc: james.clark@arm.com; mike.leach@linaro.org; leo.yan@linaro.org;
> > peterz@infradead.org; mingo@redhat.com;
> > alexander.shishkin@linux.intel.com; linux-arm-kernel@lists.infradead.or=
g;
> > devicetree@vger.kernel.org; linux-perf-users@vger.kernel.org; linux-
> > kernel@vger.kernel.org
> > Subject: [PATCH 2/3] perf: imx_perf: add support for i.MX95 platform
> >
> > i.MX95 has a DDR PMU which is almostly same as i.MX93, it now supports
> > read beat and write beat filter capabilities. This will add support for
> > i.MX95 and enhance the driver to support specific filter handling for i=
t.
> >
> > Usage:
> >
> > For read beat:
> > ~# perf stat -a -I 1000 -e
> > imx9_ddr0/eddrtq_pm_rd_beat_filt2,counter=3D3,axi_mask=3DID_MASK,axi_id
> > =3DID/
> > ~# perf stat -a -I 1000 -e
> > imx9_ddr0/eddrtq_pm_rd_beat_filt1,counter=3D4,axi_mask=3DID_MASK,axi_id
> > =3DID/
> > ~# perf stat -a -I 1000 -e
> > imx9_ddr0/eddrtq_pm_rd_beat_filt0,counter=3D5,axi_mask=3DID_MASK,axi_id
> > =3DID/
> > eg: For edma2: perf stat -a -I 1000 -e
> > imx9_ddr0/eddrtq_pm_rd_beat_filt0,counter=3D5,axi_mask=3D0x00f,axi_id=
=3D0x0
> > 0c/
> >
> > For write beat:
> > ~# perf stat -a -I 1000 -e
> > imx9_ddr0/eddrtq_pm_wr_beat_filt,counter=3D2,axi_mask=3DID_MASK,axi_id=
=3D
> > ID/
> > eg: For edma2: perf stat -a -I 1000 -e
> > imx9_ddr0/eddrtq_pm_wr_beat_filt,counter=3D2,axi_mask=3D0x00f,axi_id=3D=
0x00
> > c/
> >
> > Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
> > ---
> >  drivers/perf/fsl_imx9_ddr_perf.c | 187 +++++++++++++++++++++++++++--
> > --
> >  1 file changed, 164 insertions(+), 23 deletions(-)
> >
> > diff --git a/drivers/perf/fsl_imx9_ddr_perf.c
> > b/drivers/perf/fsl_imx9_ddr_perf.c
> > index 5cf770a1bc31..5e531d94cf3b 100644
> > --- a/drivers/perf/fsl_imx9_ddr_perf.c
> > +++ b/drivers/perf/fsl_imx9_ddr_perf.c
> > @@ -11,14 +11,24 @@
> >  #include <linux/perf_event.h>
> >
> >  /* Performance monitor configuration */
> > -#define PMCFG1  			0x00
> > -#define PMCFG1_RD_TRANS_FILT_EN 	BIT(31)
> > -#define PMCFG1_WR_TRANS_FILT_EN 	BIT(30)
> > -#define PMCFG1_RD_BT_FILT_EN 		BIT(29)
> > -#define PMCFG1_ID_MASK  		GENMASK(17, 0)
> > +#define PMCFG1				0x00
> > +#define MX93_PMCFG1_RD_TRANS_FILT_EN	BIT(31)
> > +#define MX93_PMCFG1_WR_TRANS_FILT_EN	BIT(30)
> > +#define MX93_PMCFG1_RD_BT_FILT_EN	BIT(29)
> > +#define MX93_PMCFG1_ID_MASK		GENMASK(17, 0)
> >
> > -#define PMCFG2  			0x04
> > -#define PMCFG2_ID			GENMASK(17, 0)
> > +#define MX95_PMCFG1_WR_BEAT_FILT_EN	BIT(31)
> > +#define MX95_PMCFG1_RD_BEAT_FILT_EN	BIT(30)
> > +
> > +#define PMCFG2				0x04
> > +#define MX93_PMCFG2_ID			GENMASK(17, 0)
> > +
> > +#define PMCFG3				0x08
> > +#define PMCFG4				0x0C
> > +#define PMCFG5				0x10
> > +#define PMCFG6				0x14
> > +#define MX95_PMCFG_ID_MASK		GENMASK(9, 0)
> > +#define MX95_PMCFG_ID			GENMASK(25, 16)
> >
> >  /* Global control register affects all counters and takes priority ove=
r local
> > control registers */
> >  #define PMGC0		0x40
> > @@ -71,12 +81,22 @@ static const struct imx_ddr_devtype_data
> > imx93_devtype_data =3D {
> >  	.identifier =3D "imx93",
> >  };
> >
> > +static const struct imx_ddr_devtype_data imx95_devtype_data =3D {
> > +	.identifier =3D "imx95",
> > +};
> > +
> >  static const struct of_device_id imx_ddr_pmu_dt_ids[] =3D {
> >  	{.compatible =3D "fsl,imx93-ddr-pmu", .data =3D &imx93_devtype_data},
> > +	{.compatible =3D "fsl,imx95-ddr-pmu", .data =3D &imx95_devtype_data},
> >  	{ /* sentinel */ }
> >  };
> >  MODULE_DEVICE_TABLE(of, imx_ddr_pmu_dt_ids);
> >
> > +static inline bool is_imx93(struct ddr_pmu *pmu)
> > +{
> > +	return pmu->devtype_data =3D=3D &imx93_devtype_data;
> > +}
> > +
> >  static ssize_t ddr_perf_identifier_show(struct device *dev,
> >  					struct device_attribute *attr,
> >  					char *page)
> > @@ -178,7 +198,6 @@ static struct attribute *ddr_perf_events_attrs[] =
=3D {
> >  	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_wiq_6, 70),
> >  	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_wiq_7, 71),
> >  	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_empty, 72),
> > -	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_trans_filt, 73),
> >
> >  	/* counter3 specific events */
> >  	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_0, 64),
> > @@ -190,7 +209,6 @@ static struct attribute *ddr_perf_events_attrs[] =
=3D {
> >  	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_6, 70),
> >  	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_7, 71),
> >  	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_full, 72),
> > -	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_wr_trans_filt, 73),
> >
> >  	/* counter4 specific events */
> >  	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_0, 64),
> > @@ -202,7 +220,6 @@ static struct attribute *ddr_perf_events_attrs[] =
=3D {
> >  	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_6, 70),
> >  	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_7, 71),
> >  	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_ld_rdq2_rmw, 72),
> > -	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_beat_filt, 73),
> >
> >  	/* counter5 specific events */
> >  	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_start_0, 64),
> > @@ -242,6 +259,26 @@ static const struct attribute_group
> > ddr_perf_events_attr_group =3D {
> >  	.attrs =3D ddr_perf_events_attrs,
> >  };
> >
> > +static struct attribute *imx93_ddr_perf_events_attrs[] =3D {
> > +	/* counter2 specific events */
> > +	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_trans_filt, 73),
> > +	/* counter3 specific events */
> > +	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_wr_trans_filt, 73),
> > +	/* counter4 specific events */
> > +	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_beat_filt, 73),
> > +};
> > +
> > +static struct attribute *imx95_ddr_perf_events_attrs[] =3D {
> > +	/* counter2 specific events */
> > +	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_wr_beat_filt, 73),
> > +	/* counter3 specific events */
> > +	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_beat_filt2, 73),
> > +	/* counter4 specific events */
> > +	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_beat_filt1, 73),
> > +	/* counter5 specific events */
> > +	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_beat_filt0, 73),
> > +};
> > +
> >  PMU_FORMAT_ATTR(event, "config:0-7");
> >  PMU_FORMAT_ATTR(counter, "config:8-15");
> >  PMU_FORMAT_ATTR(axi_id, "config1:0-17");
> > @@ -361,7 +398,7 @@ static void ddr_perf_counter_local_config(struct
> > ddr_pmu *pmu, int config,
> >  	}
> >  }
> >
> > -static void ddr_perf_monitor_config(struct ddr_pmu *pmu, int cfg, int =
cfg1,
> > int cfg2)
> > +static void imx93_ddr_perf_monitor_config(struct ddr_pmu *pmu, int cfg=
,
> > int cfg1, int cfg2)
> >  {
> >  	u32 pmcfg1, pmcfg2;
> >  	int event, counter;
> > @@ -372,30 +409,80 @@ static void ddr_perf_monitor_config(struct
> > ddr_pmu *pmu, int cfg, int cfg1, int
> >  	pmcfg1 =3D readl_relaxed(pmu->base + PMCFG1);
> >
> >  	if (counter =3D=3D 2 && event =3D=3D 73)
> > -		pmcfg1 |=3D PMCFG1_RD_TRANS_FILT_EN;
> > +		pmcfg1 |=3D MX93_PMCFG1_RD_TRANS_FILT_EN;
> >  	else if (counter =3D=3D 2 && event !=3D 73)
> > -		pmcfg1 &=3D ~PMCFG1_RD_TRANS_FILT_EN;
> > +		pmcfg1 &=3D ~MX93_PMCFG1_RD_TRANS_FILT_EN;
> >
> >  	if (counter =3D=3D 3 && event =3D=3D 73)
> > -		pmcfg1 |=3D PMCFG1_WR_TRANS_FILT_EN;
> > +		pmcfg1 |=3D MX93_PMCFG1_WR_TRANS_FILT_EN;
> >  	else if (counter =3D=3D 3 && event !=3D 73)
> > -		pmcfg1 &=3D ~PMCFG1_WR_TRANS_FILT_EN;
> > +		pmcfg1 &=3D ~MX93_PMCFG1_WR_TRANS_FILT_EN;
> >
> >  	if (counter =3D=3D 4 && event =3D=3D 73)
> > -		pmcfg1 |=3D PMCFG1_RD_BT_FILT_EN;
> > +		pmcfg1 |=3D MX93_PMCFG1_RD_BT_FILT_EN;
> >  	else if (counter =3D=3D 4 && event !=3D 73)
> > -		pmcfg1 &=3D ~PMCFG1_RD_BT_FILT_EN;
> > +		pmcfg1 &=3D ~MX93_PMCFG1_RD_BT_FILT_EN;
> >
> > -	pmcfg1 &=3D ~FIELD_PREP(PMCFG1_ID_MASK, 0x3FFFF);
> > -	pmcfg1 |=3D FIELD_PREP(PMCFG1_ID_MASK, cfg2);
> > +	pmcfg1 &=3D ~FIELD_PREP(MX93_PMCFG1_ID_MASK, 0x3FFFF);
> > +	pmcfg1 |=3D FIELD_PREP(MX93_PMCFG1_ID_MASK, cfg2);
> >  	writel(pmcfg1, pmu->base + PMCFG1);
> >
> >  	pmcfg2 =3D readl_relaxed(pmu->base + PMCFG2);
> > -	pmcfg2 &=3D ~FIELD_PREP(PMCFG2_ID, 0x3FFFF);
> > -	pmcfg2 |=3D FIELD_PREP(PMCFG2_ID, cfg1);
> > +	pmcfg2 &=3D ~FIELD_PREP(MX93_PMCFG2_ID, 0x3FFFF);
> > +	pmcfg2 |=3D FIELD_PREP(MX93_PMCFG2_ID, cfg1);
>=20
> Suggest created a sperate rename patch, which prepare for IMX95.
>=20
> Frank
>=20
> >  	writel(pmcfg2, pmu->base + PMCFG2);
> >  }
> >
> > +static void imx95_ddr_perf_monitor_config(struct ddr_pmu *pmu, int cfg=
,
> > int cfg1, int cfg2)
> > +{
> > +	u32 pmcfg1, pmcfg, offset =3D 0;
> > +	int event, counter;
> > +
> > +	event =3D cfg & 0x000000FF;
> > +	counter =3D (cfg & 0x0000FF00) >> 8;
> > +
> > +	pmcfg1 =3D readl_relaxed(pmu->base + PMCFG1);
> > +
> > +	if (counter =3D=3D 2 && event =3D=3D 73) {
> > +		pmcfg1 |=3D MX95_PMCFG1_WR_BEAT_FILT_EN;
> > +		offset =3D PMCFG3;
> > +	} else if (counter =3D=3D 2 && event !=3D 73) {
> > +		pmcfg1 &=3D ~MX95_PMCFG1_WR_BEAT_FILT_EN;
> > +	}
> > +
> > +	if (counter =3D=3D 3 && event =3D=3D 73) {
> > +		pmcfg1 |=3D MX95_PMCFG1_RD_BEAT_FILT_EN;
> > +		offset =3D PMCFG4;
> > +	} else if (counter =3D=3D 3 && event !=3D 73) {
> > +		pmcfg1 &=3D ~MX95_PMCFG1_RD_BEAT_FILT_EN;
> > +	}
> > +
> > +	if (counter =3D=3D 4 && event =3D=3D 73) {
> > +		pmcfg1 |=3D MX95_PMCFG1_RD_BEAT_FILT_EN;
> > +		offset =3D PMCFG5;
> > +	} else if (counter =3D=3D 4 && event !=3D 73) {
> > +		pmcfg1 &=3D ~MX95_PMCFG1_RD_BEAT_FILT_EN;
> > +	}
> > +
> > +	if (counter =3D=3D 5 && event =3D=3D 73) {
> > +		pmcfg1 |=3D MX95_PMCFG1_RD_BEAT_FILT_EN;
> > +		offset =3D PMCFG6;
> > +	} else if (counter =3D=3D 5 && event !=3D 73) {
> > +		pmcfg1 &=3D ~MX95_PMCFG1_RD_BEAT_FILT_EN;
> > +	}
> > +
> > +	writel(pmcfg1, pmu->base + PMCFG1);
> > +
> > +	if (offset) {
> > +		pmcfg =3D readl_relaxed(pmu->base + offset);
> > +		pmcfg &=3D ~FIELD_PREP(MX95_PMCFG_ID_MASK, 0x3FF);
> > +		pmcfg |=3D FIELD_PREP(MX95_PMCFG_ID_MASK, cfg2);
> > +		pmcfg &=3D ~FIELD_PREP(MX95_PMCFG_ID, 0x3FF);
>=20
> It should be reductant.

Okay, will change this.

>=20
> > +		pmcfg |=3D FIELD_PREP(MX95_PMCFG_ID, cfg1);
> > +		writel(pmcfg, pmu->base + offset);
> > +	}
> > +}
> > +
> >  static void ddr_perf_event_update(struct perf_event *event)
> >  {
> >  	struct ddr_pmu *pmu =3D to_ddr_pmu(event->pmu);
> > @@ -479,8 +566,13 @@ static int ddr_perf_event_add(struct perf_event
> > *event, int flags)
> >  	if (flags & PERF_EF_START)
> >  		ddr_perf_event_start(event, flags);
> >
> > -	/* read trans, write trans, read beat */
> > -	ddr_perf_monitor_config(pmu, cfg, cfg1, cfg2);
> > +	if (is_imx93(pmu)) {
> > +		/* read trans, write trans, read beat */
> > +		imx93_ddr_perf_monitor_config(pmu, cfg, cfg1, cfg2);
> > +	} else {
> > +		/* write beat, read beat2, read beat1, read beat */
> > +		imx95_ddr_perf_monitor_config(pmu, cfg, cfg1, cfg2);
> > +	}
>=20
> Did you run checkpatch?  no "{" need?, not sure have comments case.

No warning about this when run checkpatch.

> >
> >  	return 0;
> >  }
> > @@ -596,6 +688,49 @@ static int ddr_perf_offline_cpu(unsigned int cpu,
> > struct hlist_node *node)
> >  	return 0;
> >  }
> >
> > +static int ddr_perf_add_events(struct ddr_pmu *pmu)
> > +{
> > +	int i, ret, events;
> > +	struct attribute **attrs;
> > +	struct device *pmu_dev =3D pmu->pmu.dev;
> > +
> > +	if (is_imx93(pmu)) {
> > +		events =3D sizeof(imx93_ddr_perf_events_attrs)/sizeof(struct
> > attribute *);
> > +		attrs =3D imx93_ddr_perf_events_attrs;
> > +	} else {
> > +		events =3D sizeof(imx95_ddr_perf_events_attrs)/sizeof(struct
> > attribute *);
> > +		attrs =3D imx95_ddr_perf_events_attrs;
> > +	}
>=20
> Can you put "attrs" and "events" into drvdata?

Okay. Will try it.

>=20
> > +
> > +	for (i =3D 0; i < events; i++) {
> > +		ret =3D sysfs_add_file_to_group(&pmu_dev->kobj, attrs[i],
> > "events");
> > +		if (ret) {
> > +			dev_warn(pmu->dev, "i.MX9 DDR Perf add events
> > failed (%d)\n", ret);
> > +			return ret;
> > +		}
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static void ddr_perf_remove_events(struct ddr_pmu *pmu)
> > +{
> > +	int i, events;
> > +	struct attribute **attrs;
> > +	struct device *pmu_dev =3D pmu->pmu.dev;
> > +
> > +	if (is_imx93(pmu)) {
> > +		events =3D sizeof(imx93_ddr_perf_events_attrs)/sizeof(struct
> > attribute *);
> > +		attrs =3D imx93_ddr_perf_events_attrs;
> > +	} else {
> > +		events =3D sizeof(imx95_ddr_perf_events_attrs)/sizeof(struct
> > attribute *);
> > +		attrs =3D imx95_ddr_perf_events_attrs;
> > +	}
>=20
> Can you put "attrs" and "events" into drvdata?

Okay.

Thanks,
Xu Yang

>=20
> > +
> > +	for (i =3D 0; i < events; i++)
> > +		sysfs_remove_file_from_group(&pmu_dev->kobj, attrs[i],
> > "events");
> > +}
> > +
> >  static int ddr_perf_probe(struct platform_device *pdev)
> >  {
> >  	struct ddr_pmu *pmu;
> > @@ -666,6 +801,10 @@ static int ddr_perf_probe(struct platform_device
> > *pdev)
> >  	if (ret)
> >  		goto ddr_perf_err;
> >
> > +	ret =3D ddr_perf_add_events(pmu);
> > +	if (ret)
> > +		dev_warn(&pdev->dev, "i.MX9 DDR Perf filter events are
> > missing\n");
> > +
> >  	return 0;
> >
> >  ddr_perf_err:
> > @@ -683,6 +822,8 @@ static int ddr_perf_remove(struct platform_device
> > *pdev)
> >  {
> >  	struct ddr_pmu *pmu =3D platform_get_drvdata(pdev);
> >
> > +	ddr_perf_remove_events(pmu);
> > +
> >  	cpuhp_state_remove_instance_nocalls(pmu->cpuhp_state, &pmu-
> > >node);
> >  	cpuhp_remove_multi_state(pmu->cpuhp_state);
> >
> > --
> > 2.34.1

