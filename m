Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1E1E7BF548
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 10:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234650AbjJJIIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 04:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234631AbjJJIII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 04:08:08 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2072.outbound.protection.outlook.com [40.107.21.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF7D997;
        Tue, 10 Oct 2023 01:08:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lvx0sQIxS4wwNPvx0radY+9/O77F7But8Rn0q0EFbfOJa8mLvvy/Fd2u+1p5UpJFgtihmntRg6MZm0OXZmfMhue/YUDZnmYJc4abXmE+3VIBHZZO0fF12OeUEFhvZdPN838UNo/kyVQy/8798lNAek7B8RRxD6oYnHktNwNbj1H1Cg6H/j9A7VGBsUApb6U/bG1mpLtmI2aZ6iPdN9VzTA9G6fApHU7Nlb7Pb7rzFpv4jzZTqwiH1JD7/5MZMycHG62+v7jeOFZ3JnFUxWwTxUT7DX5MCHfj7mNErDqeQUhi41eWJ9vqYUStkNPJH7rj7cDOeMzRo5Xxox8JBklhZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jlx9sUnRFYHei3zaIhudKMOqedRP9g1mGoMtfpb74G4=;
 b=AQLBvMkgn1+szXlAdJlHQawBDuhcwq25j0W8BEpH9WpCzNMLaI/p+LzizxiJudh9jgdZwR3bp+0mwwHxhNYze5BBF1FpST71v4n9J/dvAnoW2L9Lw9gxd7Vvc9+p2kvx8isC/VA0LqWnRO0sa8nyjXOjNsF6dl8tnkRxWhyvokdJzmV4O25w/XXtP9pWsndyGxiMi94FQ50/1KDI+8xo+njPnoJb3KfsXNYp+blkdQs1Ad5n+pSRKsGDcO+u4JFOCNuLR2Ii6FsFeAYVbeeCgUtWyAi8BvbVPMVipBPcCk5isN/TcgjMC/wcqA2JZYcIyaRx1DkhBVYGIwvTYQZgDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jlx9sUnRFYHei3zaIhudKMOqedRP9g1mGoMtfpb74G4=;
 b=LFnu7amolWtECtqiQ01+g9IjnIfdgDcXYkslG6637PUvhbE8cY0CTV03evQupfkJblHSfe2p5D6vX1LSFhCVc7Q8FUXK6fkvb6gGKxFqydY0DrtM9VV5+Im8xPhCAiqjWcnr98cHJCgm/Qjd7I6TCdg/u/cpw12Ko3vZ1hi8T78=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU0PR04MB9394.eurprd04.prod.outlook.com (2603:10a6:10:359::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.43; Tue, 10 Oct
 2023 08:08:01 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b%3]) with mapi id 15.20.6838.040; Tue, 10 Oct 2023
 08:08:01 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Cristian Marussi <cristian.marussi@arm.com>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC:     "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>,
        Glen G Wienecke <glen.wienecke@nxp.com>,
        "souvik.chakravarty@arm.com" <souvik.chakravarty@arm.com>,
        Chuck Cannon <chuck.cannon@nxp.com>
Subject: RE: [RFC] firmware: arm_scmi: clock: add fixed clock attribute
 support
Thread-Topic: [RFC] firmware: arm_scmi: clock: add fixed clock attribute
 support
Thread-Index: AQHZ+yDr+00Lv1J4akKijvcbZFMOArBCpluAgAADbnA=
Date:   Tue, 10 Oct 2023 08:08:01 +0000
Message-ID: <DU0PR04MB9417DCEC4CA9DA488796194C88CDA@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20231010022911.4106863-1-peng.fan@oss.nxp.com>
 <ZSUCDdfJjs1blK1T@e120937-lin>
In-Reply-To: <ZSUCDdfJjs1blK1T@e120937-lin>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|DU0PR04MB9394:EE_
x-ms-office365-filtering-correlation-id: 7336d60e-e9f6-4842-f213-08dbc96805dd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VzqYTxsNbnd5/vXAsWWVlPS75SiH6sEonBIDiUX09yDq+sZBk/nGgbSpQwgo+EtKkK+gerzSSnaGCOehXJgS4B21XbXGrTZxcdf2JoXxN8ft/W1D0I2AY6/d4OaiiQIu1HQbNclqP5v5o/Ca2WzQIXBblca0ISYdXw8fJZu820kEklc0cMbwIa08InfAuDk+C7nnxXUuEn6yBED14atI1PDVl5EJlQB+k5qb7IvUDN3YqxRoyrt6+RxxD3JsS6Glv10KpWJQXTYxvT+VAULqz8awiZvIzynfXbSHrGO0cF+Aoy8LuBNq2SXOiNH+qaHpNIzAC3HVkOrdaVd2NIVbgiOQ2WBAiE1wbqw5Qub4bQugIT3ODRw5dFyMldCH/hAceXfvH5yy8/DIckU2MmqTkKHUP9lJycUvIP7H3/YxMeBjh1iVCYKNqAVDLOc6O4S/uIExDcie0snZvcYvDO9HQj3Q0qISYiX1VP+62BXO/LB7E/L6P3Ms9BAfwksQLFmjO6wVpdN/KILrzajzO1tFxR3XMSec3wRPJKoHu7dC1xld1fm06IdpuFfmGIvU+nvTFLjTLMGkFhxrewOHjc2AIecbw+FxZ4eLDhlP053aUTR1yvqfzCvPTsSad92xobge
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(376002)(366004)(346002)(396003)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(9686003)(6506007)(7696005)(478600001)(71200400001)(44832011)(26005)(83380400001)(2906002)(5660300002)(66476007)(110136005)(76116006)(54906003)(64756008)(66446008)(66556008)(66946007)(316002)(4326008)(8676002)(8936002)(41300700001)(52536014)(33656002)(122000001)(38100700002)(38070700005)(86362001)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1+VTqtMzPNvzpeFSzyluuYHx8CerJAXcXqVmVJCQ4OdkXbBd/ZXKLB9qYBGC?=
 =?us-ascii?Q?JBt9/nI8kkSozpoC/I1EENbo1nSuoHx/OD6IyKzm75uBaFIfwFpeidgsgxyq?=
 =?us-ascii?Q?eGQlfd5IrwLkuxlesC5UpyThkMyTqrPedLCTrT+CUE18M7SxH6PD9WDP0y3e?=
 =?us-ascii?Q?VTTUO4G4v/Ds5q2M6eT/tP5NhNujaq7Os8LUSRRDsMDUY5NTCJyHD+Uxb0IL?=
 =?us-ascii?Q?Is8j/qNaN3r3n3o5gRqpi7t/nPX4O+TM6dlo8sQBORd6c4B3odJs6qkilruo?=
 =?us-ascii?Q?BWfMmuLzHdjNrRMx1qXmhtjf0O522QCl1q29xvOzHjsnN5tycKbxZuJmiHWR?=
 =?us-ascii?Q?YVcErOVAMyMJh4z3KQcXuUfDTKdgRkNHAHfwtq8NH6SPFRE6TiiY9VkILZ1D?=
 =?us-ascii?Q?YItVBJHQipdv2pXLUCGH6R0WodHQwSCOhk0VlEwd+8nyGMaAdIUZlbkPuv0U?=
 =?us-ascii?Q?wRRSY1FinDiNxIv3eTZE5rkGEak040gNLuDRSSodTap89zhmJvHq6r8OXjo/?=
 =?us-ascii?Q?mZZUUY5mCaOSUhqnLlCHMofoPVdjrP2DawJIN58fNA4XnEQBDDsPofnA+KJq?=
 =?us-ascii?Q?UeiyOVKoBRsTYbSMvYK3L6Yc8/E5HSkGY1ly8AY4WTH8mVscOZbsvVdMQJt6?=
 =?us-ascii?Q?quUYRnn05X9gyOuRtqw+FzIQtdi6kT0kG5gEND1iafdaAu939o7jFkvZ2iqn?=
 =?us-ascii?Q?J9C0cVy7hFcAlTVX/o8KldfzI50e1hpoGoOBnVoQQxUUjdoUmZ5vL2Id/fbp?=
 =?us-ascii?Q?eCA/xZx7QYLP09UBZqlRkG/6+UVnvvxnEpm0ulNc6EEbu+S8nxQNW2ivRbPr?=
 =?us-ascii?Q?C3oT019GqzSOubqBs8cZSRkYfKMZYt8Mca8d3bbOMdJJVCC4Bp2eGrlzgEVa?=
 =?us-ascii?Q?fZV1E8uBICmNvd6FAC34k8Dy4ogqZ45mfpvz2rEjD3NELYonFfmzhXCEszEr?=
 =?us-ascii?Q?milVlluNFUuWuKeB2tys87iGF2e9hHzZ/Fzw1a+lEDsFlr/KiwO5PlRNhjrI?=
 =?us-ascii?Q?OMXZdhZ9s5S6SHIIzBB0hkWg1DZborbZK2SWdaKuTMFITMK4i/xWEigaZb1e?=
 =?us-ascii?Q?o+Zb68Fn+MmLcgjnqqM3kSIfylvriIVcbscxFWul3d5UT/HY6q54cPY6y70q?=
 =?us-ascii?Q?sWZ/VZ8dyaThuC04WkTOJcZrieH1jrDsrXItv7bAlWDNeXfQO/GCfY5QBlRN?=
 =?us-ascii?Q?d4BbN0GV9x+IHy3D8a9vzBD4pfkPnyTgybzye3Ep/0Cxx7UWx9yDQ7ab7exZ?=
 =?us-ascii?Q?BZIFokkGQ66FkFRQ1QMZ6c6DAa6UdShYtVxJqx0btTHnvKZV9oHS8hyRBCCy?=
 =?us-ascii?Q?IQV13T1kyuOU+Rq0S+X5ywwce71RP4OKRbM0U6cBKDtH+euK/A4dPVPvz0D4?=
 =?us-ascii?Q?Bxym9kYG/nWBZq4JIZAUEsAecJkXCS4Ns2QOHAgXZuCU6YQ8C6KlkHdOcI70?=
 =?us-ascii?Q?fFYWQZAw59bV+It8Imr67BKjvk2f6kE1Hj/gJ/LIXB4Aqk0jG6kVuOJDaCjg?=
 =?us-ascii?Q?2GCV2QRvSjfMqCdLv3TjeYgNFsm5tXq8qy7LWSBtirOzsk/NhNFtnI1R7X5D?=
 =?us-ascii?Q?igJeapi0KLGPmMCGn2M=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7336d60e-e9f6-4842-f213-08dbc96805dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2023 08:08:01.4853
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Nie3ggvBJaOcfSHVqzD/R8PQ4yOfdzTovLLCYwFrUCAT7HqHrzEsLnOOpn1avN2MP7Lz2EHAy7cHd8eiQFPTyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9394
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [RFC] firmware: arm_scmi: clock: add fixed clock attribute
> support
>=20
> On Tue, Oct 10, 2023 at 10:29:11AM +0800, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > There are clocks:
> >  system critical, not allow linux to disable, change rate  allow linux
> > to get rate, because some periphals will use the frequency  to
> > configure periphals.
> >
> >  So introduce an attribute to indicated FIXED clock
> >
>=20
> Hi,
>=20
> (CCed souvik.chakravarty@arm.com)
>=20
> so AFAIU here you are describing a clock that really is NOT fixed in gene=
ral, it
> is just that the Linux SCMI Agent cannot touch it, but other SCMI agents =
on
> the system CAN change it and so, on one side, you keep the ability for th=
e
> Linux agent to read back the current rate with
> recalc_rate() and remove all the Clk frameworks callbacks needed to modif=
y
> its state, am I right ?

Right.

>=20
> In this scenario, it is really the SCMI platform fw (server) that has to
> implement the checks and simply DENY the requests coming from an agent
> that is not supposed to touch that clock, while allowing the current rate=
 to be
> retrieved.

Linux will try to enable, get rate, runtime disable the clock.
But the server does not allow enable/disable the clock, so the driver probe
will fail.

The SCMI server could bypass enable/disable and only allow get rate,
But this introduces heavy RPC, so just wanna whether it is ok to register
fixed clock and avoid RPC.

>=20
> JUNO/SCP is an example of how the CPUs clocks are visible to Linux BUT
> cannot be touched directly via Clock protocol by Linux since in the SCMI
> world you are supposed to use the Perf protocol instead to change the OPP=
s
> when you want to modify the performance level of the runnning CPU.
>=20
> This kind of server-side permissions checks, meant to filter access to re=
sources
> based on the requesting agent, are part of the SCMI declared aim to push =
the
> responsibility of such controls out of the kernel into the platform fw in=
 order
> to avoid attacks like CLOCK_SCREW by letting the SCMI firmware be the one
> and only final arbiter on the requests coming from the agents; you can as=
k
> teh server whatever you like as an agent but your request can be DENIED o=
r
> silently ignored (in case of shared resources) at the will of the platfor=
m which
> has the final say and it is implemented in a physically distinct code-bas=
e.
>=20
> It seems to me that this patch and the possible associated SCMI specifica=
tion
> change would give back the control to the Linux agent and could allow the
> implementation of an SCMI Server that does NOT perform any of these
> permission checks.
>=20
> So, IMO, while this change, on one side, could be certainly useful by rem=
oving
> a bunch of unused/uneeded callbacks from the CLK SCMI driver when a fixed
> clock is identified, it could open the door to a bad implementation like =
the
> one mentioned above which does NOT perform any agent-based permission
> check.

Thanks for detailed information, let me check whether our SCMI firmware
could do more on the permission side. But if RPC could be removed,
it could save some time.

Thanks,
Peng.

>=20
> Maybe Sudeep or Souvik think differently.
>=20
> Thanks,
> Cristian
>=20
>=20
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  drivers/clk/clk-scmi.c            | 6 ++++++
> >  drivers/firmware/arm_scmi/clock.c | 5 ++++-
> >  include/linux/scmi_protocol.h     | 1 +
> >  3 files changed, 11 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/clk/clk-scmi.c b/drivers/clk/clk-scmi.c index
> > 8cbe24789c24..a539a35bd45a 100644
> > --- a/drivers/clk/clk-scmi.c
> > +++ b/drivers/clk/clk-scmi.c
> > @@ -182,6 +182,10 @@ static const struct clk_ops scmi_clk_ops =3D {
> >  	.determine_rate =3D scmi_clk_determine_rate,  };
> >
> > +static const struct clk_ops scmi_fixed_rate_clk_ops =3D {
> > +	.recalc_rate =3D scmi_clk_recalc_rate, };
> > +
> >  static const struct clk_ops scmi_atomic_clk_ops =3D {
> >  	.recalc_rate =3D scmi_clk_recalc_rate,
> >  	.round_rate =3D scmi_clk_round_rate,
> > @@ -293,6 +297,8 @@ static int scmi_clocks_probe(struct scmi_device
> *sdev)
> >  		if (is_atomic &&
> >  		    sclk->info->enable_latency <=3D atomic_threshold)
> >  			scmi_ops =3D &scmi_atomic_clk_ops;
> > +		else if (sclk->info->rate_fixed)
> > +			scmi_ops =3D &scmi_fixed_rate_clk_ops;
> >  		else
> >  			scmi_ops =3D &scmi_clk_ops;
> >
> > diff --git a/drivers/firmware/arm_scmi/clock.c
> > b/drivers/firmware/arm_scmi/clock.c
> > index ddaef34cd88b..8c52db539e54 100644
> > --- a/drivers/firmware/arm_scmi/clock.c
> > +++ b/drivers/firmware/arm_scmi/clock.c
> > @@ -46,6 +46,7 @@ struct scmi_msg_resp_clock_attributes {
> >  #define SUPPORTS_RATE_CHANGE_REQUESTED_NOTIF(x)	((x) &
> BIT(30))
> >  #define SUPPORTS_EXTENDED_NAMES(x)		((x) & BIT(29))
> >  #define SUPPORTS_PARENT_CLOCK(x)		((x) & BIT(28))
> > +#define SUPPORTS_FIXED_RATE_CLOCK(x)		((x) & BIT(27))
> >  	u8 name[SCMI_SHORT_NAME_MAX_SIZE];
> >  	__le32 clock_enable_latency;
> >  };
> > @@ -326,7 +327,9 @@ static int scmi_clock_attributes_get(const struct
> scmi_protocol_handle *ph,
> >  			clk->rate_changed_notifications =3D true;
> >  		if (SUPPORTS_RATE_CHANGE_REQUESTED_NOTIF(attributes))
> >  			clk->rate_change_requested_notifications =3D true;
> > -		if (SUPPORTS_PARENT_CLOCK(attributes))
> > +		if (SUPPORTS_FIXED_RATE_CLOCK(attributes))
> > +			clk->rate_fixed =3D true;
> > +		else if (SUPPORTS_PARENT_CLOCK(attributes))
> >  			scmi_clock_possible_parents(ph, clk_id, clk);
> >  	}
> >
> > diff --git a/include/linux/scmi_protocol.h
> > b/include/linux/scmi_protocol.h index f2f05fb42d28..e068004c151a
> > 100644
> > --- a/include/linux/scmi_protocol.h
> > +++ b/include/linux/scmi_protocol.h
> > @@ -47,6 +47,7 @@ struct scmi_clock_info {
> >  	bool rate_discrete;
> >  	bool rate_changed_notifications;
> >  	bool rate_change_requested_notifications;
> > +	bool rate_fixed;
> >  	union {
> >  		struct {
> >  			int num_rates;
> > --
> > 2.37.1
> >
