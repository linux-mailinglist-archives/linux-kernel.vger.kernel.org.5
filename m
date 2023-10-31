Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45F777DCDEC
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 14:34:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344562AbjJaNdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 09:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344524AbjJaNdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 09:33:23 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2079.outbound.protection.outlook.com [40.107.104.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A10FDE;
        Tue, 31 Oct 2023 06:33:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aejfz/BLQzqo6nWBhRktj4uFFLHyFCVxuXA3dGbOxQgZHzjuk12Of+Gy4wEb66UQJjq6PPL/ZcvOM3DCviR8iSDILxDBJ6j69ty4I6mr39dOcSX2mgUTFRIjPatk+E7iylpvXBfx9/l1HMJi0Lkl/aVc2RW98DFDb03P9vV4aauvuQiE72mrabwql5EMfScoLRscBS9vYgu2F7R3m/u0aiT7vOSgeplg7Eqr1uzZsbUf8Av/88mp8PBNFCJyGjWsFveTgt30dr9k84Y8G5o1ahQRN5UHmjOd+8ON0k8K3bQfnkcRkJHgFigqCrcr67hPkE2jQD8inE78875j8OLyWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4FD05oeWeO9sOpJMJEouUrcLwrnhIqSdxE5XZSpGs1U=;
 b=IjMpmyB4QApmEqnR1l9/bb+l80/8DyUg18HAzreGsfrBKNJMwKXycsXEv9kcij0LMyKclTh9rgLG6sIeDJVyblbWSWZgVGxGwzQ+x4VHMAfBD8w7rJCILjXEfJQVwg/xaB0pL57tCb/cmJLKLKKH8n+q20ihvLAtkAfxWt88Rd2rcGaSL9m8E/VkmFK5SqUZ7Ofuki8stGQwLKqUmYmpHb1xGgyp+PMEfrjrvleawoOaN1y0kC23u+5Q/iYp0wpVdJ6QThaq5JydIgx5i0k0f6F4JFYDDaCMVewvOOXLuDmIqGUc07YhnPJMa5F6bFP8JvJiZGCvwrI6KuDIKpe+ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4FD05oeWeO9sOpJMJEouUrcLwrnhIqSdxE5XZSpGs1U=;
 b=BJjh5LGg36+JHI14EsE2v4fD8R93pmvKnNkjOdNOqiHhWeVSwnDuChBSnOGfGhhAM6bfXzoUmW7vjZVLL3qMlLRTmzbaOzwoDozc/oMvJiq2lTPKEP7iHhLbKZHiZtmSfqcjvDgMdcZggtonrwfhsvoe0j3Dj3oBlSOPIL9FvxM=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8183.eurprd04.prod.outlook.com (2603:10a6:20b:3f1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.11; Tue, 31 Oct
 2023 13:33:18 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::50bf:dcd6:885e:32c4]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::50bf:dcd6:885e:32c4%4]) with mapi id 15.20.6933.011; Tue, 31 Oct 2023
 13:33:17 +0000
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
        "nitin.garg@nxp.com" <nitin.garg@nxp.com>,
        Chuck Cannon <chuck.cannon@nxp.com>,
        "Souvik.Chakravarty@arm.com" <Souvik.Chakravarty@arm.com>
Subject: RE: [PATCH V1] firmware: arm_scmi: clock: support clock denied flags
Thread-Topic: [PATCH V1] firmware: arm_scmi: clock: support clock denied flags
Thread-Index: AQHaC/UHs/XlMTw0Tk6L+Yx/ZrSO0bBj3UUAgAAHvIA=
Date:   Tue, 31 Oct 2023 13:33:17 +0000
Message-ID: <DU0PR04MB941745E7400113CA3B1635C488A0A@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20231031122734.1371524-1-peng.fan@oss.nxp.com>
 <ZUD7DGynqkvDzasN@pluto>
In-Reply-To: <ZUD7DGynqkvDzasN@pluto>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AS8PR04MB8183:EE_
x-ms-office365-filtering-correlation-id: a43289d6-aa39-4732-afb8-08dbda15f131
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mCJypl9hKNvJm7qJxH57IuGdJubVwEAju/YBiXoASPRa4qrtv05ZUot9qbzUdO3/+5wrmwHuBTCXktV3StqRX40EBz1MhDo5fDZwpAdWUMSVl9hHH2e0NdKYaZR9ylNosC5EUfJvm5GEwt0hELtzZeIJaZijr1uGKLGQVXhXcVH04JzZiNgRezAOIlSvWL3b8/XI6jJm6M09G6truNyTocq+YV5nvj/cQiLBBawtSVt8DrQUsutVED15lBZEB0Pz0H1cGWgn9U3zWQnALRf+419oiK5b7jlwUmTrCvTl2unYchSc4BAunR6C8RjpspDA6jAwy0g45GIOQP3HGMuq2R38Jb0c2tv63bN840JdICpjp35rnAghztzhS/0SANtbQh4MRDneVKr0uPSGomwdGqTgASjAM893FYE1ToRjbTq8o6jegpJJb2VITHfGY+3Ekahq/odsUVmiqa4L/WsNyYYoyAUlbUc4ZddDchRtpmqhwlwEjQ15l5P+Z//y1YMeTjtIVuSHECGp5CjPeTbSYxmXe+iqytQJCtZCSKIf51D0z7Bgb1hj3e8mhdk7aBHv17av8j/1Y2LAjFmb84FPzviYaDDEN7lr0pW106zvNrlSrn+ztPZjZH7ouURNiyMy
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(136003)(346002)(366004)(376002)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(122000001)(71200400001)(26005)(38100700002)(9686003)(7696005)(6506007)(83380400001)(66476007)(86362001)(316002)(54906003)(66446008)(64756008)(110136005)(55016003)(66946007)(478600001)(76116006)(66556008)(33656002)(4326008)(44832011)(41300700001)(8676002)(8936002)(52536014)(2906002)(38070700009)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Ym3bIgMAD+h7g5PDFptd4eYHUkwkxl7EAMCekqKpwQeIvhzrwN80SlV+Bg/h?=
 =?us-ascii?Q?dKSwOQ7jhcxLktPjW3xfeaIxOT/wlRedRdchuVSQTgIfK8ot1pnoND7EsOVB?=
 =?us-ascii?Q?NRTMESu8yiO3PUaRVzFkwmWD4XepDFsN79ZgvDQSMBFz/QzsPDqwCO1ROx9x?=
 =?us-ascii?Q?t9Wx+ZDF4MSO/LCeFeckBAuCqGQxhjkNPX5HtshNBPmZnIniMTwfafitxXeH?=
 =?us-ascii?Q?XIx9SlUaPCFdYO2wapBnAMyBVACwqqgflVg85kIBCBvZuBvCrk1DgYQ5EBt7?=
 =?us-ascii?Q?njLDNfqH08h1tpkStmnoQ7VF0e2C9aiiKo0G6kumj2KxWXI8uTe3+/qWvaWP?=
 =?us-ascii?Q?4xQ5+3gkzdxM5rxIIMfwnPE7owPA7pNlEMHChhtl55a8NuHtHPHWLu0jL6B/?=
 =?us-ascii?Q?JaZhmJLpBB6GPqpUYXE2AkARoXN0kO0mqMHLVFSTihzn/mndgkyBCBYk1NDa?=
 =?us-ascii?Q?VaO1dybfICDMzjEHkWxtSOlZchjbtE07b1P373udafKnHstaD+aGDousuc9F?=
 =?us-ascii?Q?Sz4/iyy3iWHpWbGYofoS4eu4zXxrFSQknNh/FO0NbXEMG++ABcrmkRw0c4XA?=
 =?us-ascii?Q?APe4OD8CgSuvaAQZtJyWfnjsegrTcFphlwM7EBhiRjEPjeLETuji4D+fjXoy?=
 =?us-ascii?Q?uUc5WX1t1Yewx1/hLxxlLHkM4jBQYquR5kamPFFpDtj5ailyw83SECxB/rJP?=
 =?us-ascii?Q?2rFLGGyVvepezZ+43nXpdomrW3aa9jkPVLqpVVOdJQt4ucSoopczVhxjGjkx?=
 =?us-ascii?Q?JZlH0oS6bW5Im+jCXM2JT0F4DLpzbMJjqdtbnGtpNl61PLPA2/PDKOD/d8GC?=
 =?us-ascii?Q?DGP+91E6U+n+rl3C3X34kqEudzBbSps0tp/SS3J1SRmBY1A0ybIuzN2Tq3dp?=
 =?us-ascii?Q?vD2HzXd3py0+lEN4Bywj7KYz/ZukGlvsQgu92xUwsm7OVSvS8M6ilBr/d+XF?=
 =?us-ascii?Q?1+/KrTKI15s1Tt/E7XBIjnhEMkHKskZX3V8ZVw/FkSVOz0IMluws6N3yBm8K?=
 =?us-ascii?Q?+0KjmI6pvnBuEt30n74gt9qBhFM8zPZS6NsE4XWzRL0fW1uYPhYYoewmwM06?=
 =?us-ascii?Q?ROkp3KwPxtfNrJsAu/wwbdC7oUHnPwyNFAcLK1uGXOpMj1+1Jt5sopIjC1bw?=
 =?us-ascii?Q?7XcRk7g0y7lGuLQfLhIQZ/jMGvY6LTsmVOYdhCdx7VPVCJbaDihVSIGM9BXV?=
 =?us-ascii?Q?cCAcnU5V+RgN2G3cm63H6HLAHOdghgDgFp3zpiiZKfJnc8/H0iz6rK8BO50o?=
 =?us-ascii?Q?9hf5CNR2MPKQc3wnIarMw9EhNBEKy8Az+axhd9V96k/oehdK0U5+aSVC7ek+?=
 =?us-ascii?Q?nSsVSGZvSKeaKotLvZwDj1q8SqtcTmOL72/23nafHxRhN65JwEaniCfBDxhY?=
 =?us-ascii?Q?9wn9qRaHCxi2hucLsayaf6UI6l2P1Ibpikk1Hdmj7e+qFKkigXocgGkq8WE+?=
 =?us-ascii?Q?9A3WCt8PLR73ESaZ8XunzdKTTEmAQpFhEU72MH1TfAg6aidSEhRrgODvWMHa?=
 =?us-ascii?Q?1P1NIDDaZ7F4H6VzWG2IOGnoJXQyUms/zc4TDa7SrFWCiHmQIXDqoGSZMuqV?=
 =?us-ascii?Q?r/9MVaiKVLGDHOGOySM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a43289d6-aa39-4732-afb8-08dbda15f131
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2023 13:33:17.8663
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OMTXaVtrKiY97kN3s9OBBbI8Ib9FuzVQp1VITLmdLyWHRKCk52KUpcFdYzMUAAsXmetT9auobo0GF+UsSQxJoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8183
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH V1] firmware: arm_scmi: clock: support clock denied
> flags
>=20
> On Tue, Oct 31, 2023 at 08:27:34PM +0800, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > The firmware may export flags to indicate whether the clock is allowed
> > to set rate, set parent, enable/disable from the Agent.
> >
> > If Agent is not allowed to enable/disable, directly return success.
>=20
> ... even though, this success on deny built-in policy could be
> controversial..
Yeah.=20

.Have you tried the different approach of not registerig the
> enable/prepare callbacks in clk-scmi instead ?

Not yet, I could give a look. But not have much time
in the following week.


> From the Clk framework code it seems could be handled gracefully.
> (I have not tried though...)

If there is no enable/disable/prepare/unprepared hooks, the enable
counter or prepare counter would be used.

Thanks,
Peng.
>=20
> Thanks,
> Cristian
>=20
> > If Agent is not allowed to set rate/parent, directly return -EACCES to
> > avoid SCMI RPC calls.
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >
> > V1:
> >  drop the changes in clock.c, add an attribute entry in clock info
> > which  may be easy for extending new flag.
> >
> >  SPEC still not have such support, this is for discussion
> >
> >  drivers/firmware/arm_scmi/clock.c | 19 +++++++++++++++++++
> >  include/linux/scmi_protocol.h     |  1 +
> >  2 files changed, 20 insertions(+)
> >
> > diff --git a/drivers/firmware/arm_scmi/clock.c
> > b/drivers/firmware/arm_scmi/clock.c
> > index 42b81c181d68..fad4329a21fc 100644
> > --- a/drivers/firmware/arm_scmi/clock.c
> > +++ b/drivers/firmware/arm_scmi/clock.c
> > @@ -46,6 +46,9 @@ struct scmi_msg_resp_clock_attributes {
> >  #define SUPPORTS_RATE_CHANGE_REQUESTED_NOTIF(x)	((x) &
> BIT(30))
> >  #define SUPPORTS_EXTENDED_NAMES(x)		((x) & BIT(29))
> >  #define SUPPORTS_PARENT_CLOCK(x)		((x) & BIT(28))
> > +#define SCMI_CLOCK_SET_ENABLE_DENIED		BIT(15)
> > +#define SCMI_CLOCK_SET_RATE_DENIED		BIT(14)
> > +#define SCMI_CLOCK_SET_PARENT_DENIED		BIT(13)
> >  	u8 name[SCMI_SHORT_NAME_MAX_SIZE];
> >  	__le32 clock_enable_latency;
> >  };
> > @@ -307,6 +310,7 @@ static int scmi_clock_attributes_get(const struct
> scmi_protocol_handle *ph,
> >  		if (PROTOCOL_REV_MAJOR(version) >=3D 0x2)
> >  			latency =3D le32_to_cpu(attr->clock_enable_latency);
> >  		clk->enable_latency =3D latency ? : U32_MAX;
> > +		clk->attributes =3D attributes;
> >  	}
> >
> >  	ph->xops->xfer_put(ph, t);
> > @@ -499,6 +503,10 @@ static int scmi_clock_rate_set(const struct
> scmi_protocol_handle *ph,
> >  	struct scmi_xfer *t;
> >  	struct scmi_clock_set_rate *cfg;
> >  	struct clock_info *ci =3D ph->get_priv(ph);
> > +	struct scmi_clock_info *clk =3D ci->clk + clk_id;
> > +
> > +	if (clk->attributes & SCMI_CLOCK_SET_RATE_DENIED)
> > +		return -EACCES;
> >
> >  	ret =3D ph->xops->xfer_get_init(ph, CLOCK_RATE_SET, sizeof(*cfg), 0,
> &t);
> >  	if (ret)
> > @@ -585,6 +593,9 @@ scmi_clock_set_parent(const struct
> scmi_protocol_handle *ph, u32 clk_id,
> >  	if (parent_id >=3D clk->num_parents)
> >  		return -EINVAL;
> >
> > +	if (clk->attributes & SCMI_CLOCK_SET_PARENT_DENIED)
> > +		return -EACCES;
> > +
> >  	ret =3D ph->xops->xfer_get_init(ph, CLOCK_PARENT_SET,
> >  				      sizeof(*cfg), 0, &t);
> >  	if (ret)
> > @@ -668,6 +679,10 @@ static int scmi_clock_enable(const struct
> scmi_protocol_handle *ph, u32 clk_id,
> >  			     bool atomic)
> >  {
> >  	struct clock_info *ci =3D ph->get_priv(ph);
> > +	struct scmi_clock_info *clk =3D ci->clk + clk_id;
> > +
> > +	if (clk->attributes & SCMI_CLOCK_SET_ENABLE_DENIED)
> > +		return 0;
> >
> >  	return ci->clock_config_set(ph, clk_id, CLK_STATE_ENABLE,
> >  				    NULL_OEM_TYPE, 0, atomic);
> > @@ -677,6 +692,10 @@ static int scmi_clock_disable(const struct
> scmi_protocol_handle *ph, u32 clk_id,
> >  			      bool atomic)
> >  {
> >  	struct clock_info *ci =3D ph->get_priv(ph);
> > +	struct scmi_clock_info *clk =3D ci->clk + clk_id;
> > +
> > +	if (clk->attributes & SCMI_CLOCK_SET_ENABLE_DENIED)
> > +		return 0;
> >
> >  	return ci->clock_config_set(ph, clk_id, CLK_STATE_DISABLE,
> >  				    NULL_OEM_TYPE, 0, atomic);
> > diff --git a/include/linux/scmi_protocol.h
> > b/include/linux/scmi_protocol.h index f2f05fb42d28..ddf5363c8cfd
> > 100644
> > --- a/include/linux/scmi_protocol.h
> > +++ b/include/linux/scmi_protocol.h
> > @@ -58,6 +58,7 @@ struct scmi_clock_info {
> >  			u64 step_size;
> >  		} range;
> >  	};
> > +	u32 attributes;
> >  	int num_parents;
> >  	u32 *parents;
> >  };
> > --
> > 2.37.1
> >
