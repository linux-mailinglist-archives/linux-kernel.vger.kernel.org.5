Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5F847D827E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 14:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234866AbjJZMUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 08:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230405AbjJZMUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 08:20:43 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2074.outbound.protection.outlook.com [40.107.15.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 973D2D44;
        Thu, 26 Oct 2023 05:20:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AUUx4Y53p1NNXKIMvmVDtKRVH1+lA2G3ujg3qIRddiffHQ/AWKgjR78iX0XCSq4NiK2lgDlP3SPiSJJKdCOOck6JUIPB/lKeJGRBG4HpQzrmNOl6Frx5UKGYpv9Ry9jLJLmLHgQdyiKomP0vpgwez9pOJBoNMsjERZ3gmn/vZCu6zY45FzdQ2T3nTW2W7DdDrd6dLInnQYbRmwhsJndQ0Dca6LR09gG3wNqe53L0kiNUiA8Bp6OzQ9UbGlkxKQaOK6PhFLMaLrJgLaPGaylzXnKvEs4XayKrpblXPjNpK7bwdkwzgzAci4A/mTgBscWjGJ51EpuYJrG7l8ByvLk23A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RxPzHgJoxX159CwOGgYWKS7+8THx2cSPswD4ry3qA74=;
 b=SgugeEPH+izmuU4TYDzVhpCAW+EJwYiAuX4WjDthmqRUm+lE/vnfV6Uq6XpXQyYrmPoM8YHyMdDl6YC3qGYnb4glQr9zBWfX7h9SEqOdjsb2qtxkvLExTgMedPT1SynfjOBScZH2n63vg/gTTS0HfSwMYy69w8fNpCw0ukewfAtNiGmNbDVMKLNJ2EM8XAvQFIohbxM+U47IlaZJE+KEbyyHvK6SR2SYFf85Z7f0s1hnoBiAH7F7a5BxbPWOyc/gQ17lJZx8BF9B5GXtm6sNKYGHasYBLIQ+Uiz+194rIIw4VMT/fshZMmm/Co9Fn5lnW+ccvjUd0iwEe2nHm9+Yfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RxPzHgJoxX159CwOGgYWKS7+8THx2cSPswD4ry3qA74=;
 b=Jx/FrhBLV7IcBFsU+ofAYslzy42p8ZKV74FI1SGte1PgFv+G+D01A3sbFs82htqzo6TLGMj0ZwRAn8ssfcDG2IL4cR+i8gtRoCFntJk1wmHT8gJFLH72jnyIJ5XMNb6zOiCATUOt0FMx2AZv1w0NNPQQgUblVocv9AuilArDJf0=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8884.eurprd04.prod.outlook.com (2603:10a6:20b:42f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.14; Thu, 26 Oct
 2023 12:20:35 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::50bf:dcd6:885e:32c4]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::50bf:dcd6:885e:32c4%4]) with mapi id 15.20.6933.011; Thu, 26 Oct 2023
 12:20:34 +0000
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
        Nitin Garg <nitin.garg_3@nxp.com>,
        Chuck Cannon <chuck.cannon@nxp.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>
Subject: RE: [RFC] firmware: arm_scmi: support clock denied attributes
Thread-Topic: [RFC] firmware: arm_scmi: support clock denied attributes
Thread-Index: AQHaB72txrUateKD6ESfQTu2QRStRbBb4hEAgAATkpA=
Date:   Thu, 26 Oct 2023 12:20:34 +0000
Message-ID: <DU0PR04MB9417977827068BFD4903486988DDA@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20231026034125.1823954-1-peng.fan@oss.nxp.com>
 <ZTpCAgUxjbVnFEkB@pluto>
In-Reply-To: <ZTpCAgUxjbVnFEkB@pluto>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AS8PR04MB8884:EE_
x-ms-office365-filtering-correlation-id: 451e9206-e430-4dce-5e1d-08dbd61df49a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nypHcObKxb3C9psdDk4HAoq4VkZM4dAD/e/KMpDhMvZoC1oHrX0z3U7LYIrB7/Yw+YfH1+5qVlexAxQqDP3HynR+BBZCn2hS/2IniYRsY1dSbhPaixOOn4CaBdk9PXDCc0ON9jCuMLsONEC6cJtQnt608VBh/KFTfUUv921Wm+s1GvnAtZjIrdsfXxt23cK7BEvXie9UocTKfXiRg/8FF7bLvR3q5PRru/aSPJRavMCUiUeWlQBfAob837WltZvcRtq3s5snAgQ19nyOYoNKv4bFzbCQZA+mhxpEowecb2NwfZOg0vvqdgyuc9cJ6dj6Xn9CZkxYnPskK+TRGbImJqEHvcGRJ+v+/x7Mk6h0qYCcW0tGeiK7whnjVkQiGQvt2f+iyarjLKTyKOFKvCQ03MKENePYGunRFoBm6Lo1YkCtvcGUNN/FaqeL/2Xq9bXwqD1fkbvAz332v4OJkvDQK/0bN33xAd3JzcuU4ag9MPk3tWwSijVktd3JkBHaKkbgGDKlh2Q4YCmV0AJveEDa8Nl0nOat8ummZrI44Fw2l4ykcUYv7CZ1oQcLSIUxJLTqMzYwAMPDywWV28grNZxPp9mY8MJZrTQOU2VRJ2EfXKVMfD10a3m5FbHJtd/Mbwcc
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(346002)(366004)(136003)(39860400002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(71200400001)(52536014)(83380400001)(122000001)(7696005)(6506007)(9686003)(316002)(26005)(66556008)(33656002)(55016003)(54906003)(66446008)(66476007)(478600001)(64756008)(66946007)(110136005)(38100700002)(76116006)(86362001)(41300700001)(4326008)(8676002)(8936002)(44832011)(38070700009)(2906002)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QG3eH+FkixzaP3gwrl4v0nboIU0GiiETWB01vQkgwATtMH5yiapzpT+PnDPi?=
 =?us-ascii?Q?rUq2e0s1QxMFuqUcvNwHEAo/LctIDF51llfehqE0mCubhuOWkUJtR9NtJcY7?=
 =?us-ascii?Q?DB/NfOjOyi6ICxzxhHnMpRSIwEcV67tfMyyZSV+zIn0VoOXtL4IJ4/bZ9Chu?=
 =?us-ascii?Q?kQHA2CG/x8DuFaXgfm1orEHUe8x7oADtSL8LxDXsMJ7/+dgG73GvpaT8pM4t?=
 =?us-ascii?Q?Sl/2epwhc1achJ/IN8fCLGpyetPa1tKkejlgaF2ukcqVr0QfxLl20a/79zbO?=
 =?us-ascii?Q?u8YX85otkv3LMu1TtyounMSW4atKpsPSPdCtBrgsoA8/dD0JWS6bQ8NTdC+U?=
 =?us-ascii?Q?ByxB5zfDhNe+frokUOuHwdbbidiZbvOTX/OE/EZOFCPfX6zHSZylj+ZnFPw8?=
 =?us-ascii?Q?pYJI8lx+DacQyWb7L21embPg6kLzLs7AYlVqTexAT4DlAxzozg2SBy8IGzf8?=
 =?us-ascii?Q?0dm4ZB/vGkowDGI0u5esOXTo30RsaNvpeCdxcfg823tpoe11lwUtdHJM2kOp?=
 =?us-ascii?Q?f8SZWwLpA/AIxFMNr7kZuAtuori7W/HE/5j1xwio0/fFErFqCvtq61hJERi3?=
 =?us-ascii?Q?AsR9yCfJMSZKqQ6QzxaceGAQmvkKmlE1PpMtGYl+2E3AWi38iSplYcGfHq7Q?=
 =?us-ascii?Q?IEsDZLmPi6xWmlfqLAyqeAqDYJcR1LaR4tULjjmC8wljJHEzlGV/c8eLkhsB?=
 =?us-ascii?Q?KOi1foff4FHro1dPe2db4ZBTs44JS6Afv2E+4AlobfBvExLKGREbigfsAera?=
 =?us-ascii?Q?z5iaLNLA0LA0MP/t/Ink16NvZpKnhfunAQ+a4DprFBqCThMNoVUfcMoDvj7t?=
 =?us-ascii?Q?voCQqj2E6ck/+sUBQi5OpWltTnD7wloIf2kJdZxneTSi5CybDVgkYjjlEatf?=
 =?us-ascii?Q?cH9kqzjS4cFiv/RCG4NNBHFw752/rpczPNUghTiGXPYedHKBhnCvOgv9OTxv?=
 =?us-ascii?Q?MiTISLIeuaFEoyVlRsZ49Yixk7pTsWNGWrIA8q+h6BojDtu0SvNbq9bnicEq?=
 =?us-ascii?Q?3abY2yAe8u51JLnjZ1aPKIERA9HmTwNdeKFHNMh3b8pgCgi5QUR2U92NC1FS?=
 =?us-ascii?Q?DPuhJMHIwAqt3Fcf9FozbsuTuksKZkgOxJJaJe1URLLswtsLAh7MzdFmcHSO?=
 =?us-ascii?Q?6uvHyFoasZxM8UwU27zs6eU69wkxnKyIE94wWqeq/jbN0pQS6XBH4RZK53V5?=
 =?us-ascii?Q?NVHELs3fXIoHTD4q0Z0yte2wDH8/ManSHlrhc0Uq+Q/X1zS3E2sbdX1KVFM/?=
 =?us-ascii?Q?m8pf0iNhFf4q6KOkths2YvI+0KEsP8QVCGTJ8IC/q2YdeHVfE/6ZEw45j+OU?=
 =?us-ascii?Q?I77arO6IfeToins1radW/K4DiVv75gVvfUhkdKCCNWIsuVTEtTQKZh18VK08?=
 =?us-ascii?Q?yLwfFF26/wc44pKM6ox36aVXWn5amoHXdy4l1Kxk/Fq+aA2r0qYedTAPmhsU?=
 =?us-ascii?Q?pnIZL5O8rGo1qkIbWYNV6qNtMnS8k+EYvM56ax0mc0M8+v8etSxZ/5wb7cYo?=
 =?us-ascii?Q?sACG4ss1V3PcNvQzaMciFhqTZeQRdBYGLoOiQzgEHRCmgzKEMFTkrFiVF56I?=
 =?us-ascii?Q?d/4L4PDFE5bFk6fQ0+A=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 451e9206-e430-4dce-5e1d-08dbd61df49a
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2023 12:20:34.8638
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p7nRcDK8GPXO9toUvHj3ich7spW/sCiCEZ2rPb67EIZYVFUdAJEGJplf1Cjkth3puHJzRAYdd9SkuSFDMe9A8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8884
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Cristian

> Subject: Re: [RFC] firmware: arm_scmi: support clock denied attributes
>=20
> On Thu, Oct 26, 2023 at 11:41:25AM +0800, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > This is not in SPEC and is just defined by NXP. This patch is to start
> > the discussion to start include them in SPEC.
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
>=20
> Hi Peng,
>=20
> thanks for validating this scenario.
>=20
> [CC Souvik]
>=20
> So at the end, you are returning -EACCESS anyway, it is just that you are
> avoiding to send any SCMI message at all if the flag reports that you can=
not
> touch this and you will get back a DENY.

Yes, except enable/disable, rate/parent both return DENY.

>=20
> Does this solve your usecase where your other drivers (callers) were fail=
ing to
> probe due to such error being reported from the server ?

We removed the assigned-clock-rates and assigned-clock-parents from device
tree nodes to avoid failure.

The peripheral driver call clk_enable/disable, since it return success, so =
issue
resolved.

>=20
> From our offline discussions my understanding was that, beside un-needed
> SCMI msg exchanges, your main issue was receiving a DENY error from the
> server when trying to modify a clock, how does this solves that ?

See above, removed the assigned-clock-parents and assigned-clock-rates.
The scmi firmware configured the parent and rate ready.

> Basically You are just returning the same error from the clk driver, just
> avoiding (rightly so) needless SCMI exchanges.
> (..in your last RFC patch you attempt was indeed different, to refrain  f=
rom
> registering any clk framework callbacks at all for untocuhable
>  clocks...)

The last RFC was to register clocks as fixed clock, so no parent/rate call =
needed.
But actually we may need get new rate because the scmi firmware could
update rate per device performance level setting.
>=20
> Does this work with upstream drivers, or just with some downstream soluti=
on
> properly crafted to handle the EACCESS ?

The patch tested in downstream repo, 6.6.

>=20
> Anyway IMO, these changes in this scenario are certainly valuable in gene=
ral
> since they avoid needless exchanges with the server around clocks that we
> know upfront we cannot touch.
>=20
> BUT, hvaing said that, if this series goes further as it is and the spec =
is
> changed accordingly, please move all of this logic inside the protocol la=
yer:
> there is no reason to change the clk-scmi driver at all for this.
>=20
> You can just check that same new flags (that you set in clk discovery) up=
front
> inside the related clock operations in drivers/firmware/arm/clock.c and j=
ust
> return EACCESS from there avoiding any SCMI exchanges if the flags are se=
t.
>=20
> This way you dont either need to re-define and expose such new flags in
> scmi_protocol.h, it can just all handled inside the SCMI protocol layer.

Thanks for your suggestions, I will give a look and prepare a new version
patch.

Thanks,
Peng.

>=20
> Thank,
> Cristian
>=20
> >  drivers/clk/clk-scmi.c            | 39 +++++++++++++++++++++++++------
> >  drivers/firmware/arm_scmi/clock.c |  9 +++++++
> >  include/linux/scmi_protocol.h     |  4 ++++
> >  3 files changed, 45 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/clk/clk-scmi.c b/drivers/clk/clk-scmi.c index
> > 8cbe24789c24..303f8a8ec8e0 100644
> > --- a/drivers/clk/clk-scmi.c
> > +++ b/drivers/clk/clk-scmi.c
> > @@ -75,15 +75,13 @@ static int scmi_clk_set_rate(struct clk_hw *hw,
> unsigned long rate,
> >  			     unsigned long parent_rate)
> >  {
> >  	struct scmi_clk *clk =3D to_scmi_clk(hw);
> > +	const struct scmi_clock_info *info =3D clk->info;
> > +	u64 rate1 =3D 0;
> >
> > -	return scmi_proto_clk_ops->rate_set(clk->ph, clk->id, rate);
> > -}
> > -
> > -static int scmi_clk_set_parent(struct clk_hw *hw, u8 parent_index) -{
> > -	struct scmi_clk *clk =3D to_scmi_clk(hw);
> > +	if (info->flags & SCMI_CLOCK_SET_RATE_DENIED)
> > +		return -EACCES;
> >
> > -	return scmi_proto_clk_ops->parent_set(clk->ph, clk->id,
> parent_index);
> > +	return scmi_proto_clk_ops->rate_set(clk->ph, clk->id, rate);
> >  }
> >
> >  static u8 scmi_clk_get_parent(struct clk_hw *hw) @@ -107,6 +105,17 @@
> > static u8 scmi_clk_get_parent(struct clk_hw *hw)
> >  	return p_idx;
> >  }
> >
> > +static int scmi_clk_set_parent(struct clk_hw *hw, u8 parent_index) {
> > +	struct scmi_clk *clk =3D to_scmi_clk(hw);
> > +	const struct scmi_clock_info *info =3D clk->info;
> > +
> > +	if (info->flags & SCMI_CLOCK_SET_ENABLE_DENIED)
> > +		return -EACCES;
> > +
> > +	return scmi_proto_clk_ops->parent_set(clk->ph, clk->id,
> > +parent_index); }
> > +
> >  static int scmi_clk_determine_rate(struct clk_hw *hw, struct
> > clk_rate_request *req)  {
> >  	/*
> > @@ -119,6 +128,10 @@ static int scmi_clk_determine_rate(struct clk_hw
> > *hw, struct clk_rate_request *r  static int scmi_clk_enable(struct
> > clk_hw *hw)  {
> >  	struct scmi_clk *clk =3D to_scmi_clk(hw);
> > +	const struct scmi_clock_info *info =3D clk->info;
> > +
> > +	if (info->flags & SCMI_CLOCK_SET_ENABLE_DENIED)
> > +		return 0;
> >
> >  	return scmi_proto_clk_ops->enable(clk->ph, clk->id, NOT_ATOMIC);  }
> > @@ -126,6 +139,10 @@ static int scmi_clk_enable(struct clk_hw *hw)
> > static void scmi_clk_disable(struct clk_hw *hw)  {
> >  	struct scmi_clk *clk =3D to_scmi_clk(hw);
> > +	const struct scmi_clock_info *info =3D clk->info;
> > +
> > +	if (info->flags & SCMI_CLOCK_SET_ENABLE_DENIED)
> > +		return;
> >
> >  	scmi_proto_clk_ops->disable(clk->ph, clk->id, NOT_ATOMIC);  } @@
> > -133,6 +150,10 @@ static void scmi_clk_disable(struct clk_hw *hw)
> > static int scmi_clk_atomic_enable(struct clk_hw *hw)  {
> >  	struct scmi_clk *clk =3D to_scmi_clk(hw);
> > +	const struct scmi_clock_info *info =3D clk->info;
> > +
> > +	if (info->flags & SCMI_CLOCK_SET_ENABLE_DENIED)
> > +		return 0;
> >
> >  	return scmi_proto_clk_ops->enable(clk->ph, clk->id, ATOMIC);  } @@
> > -140,6 +161,10 @@ static int scmi_clk_atomic_enable(struct clk_hw *hw)
> > static void scmi_clk_atomic_disable(struct clk_hw *hw)  {
> >  	struct scmi_clk *clk =3D to_scmi_clk(hw);
> > +	const struct scmi_clock_info *info =3D clk->info;
> > +
> > +	if (info->flags & SCMI_CLOCK_SET_ENABLE_DENIED)
> > +		return;
> >
> >  	scmi_proto_clk_ops->disable(clk->ph, clk->id, ATOMIC);  } diff --git
> > a/drivers/firmware/arm_scmi/clock.c
> > b/drivers/firmware/arm_scmi/clock.c
> > index 42b81c181d68..1a62e3b82d34 100644
> > --- a/drivers/firmware/arm_scmi/clock.c
> > +++ b/drivers/firmware/arm_scmi/clock.c
> > @@ -46,6 +46,9 @@ struct scmi_msg_resp_clock_attributes {
> >  #define SUPPORTS_RATE_CHANGE_REQUESTED_NOTIF(x)	((x) &
> BIT(30))
> >  #define SUPPORTS_EXTENDED_NAMES(x)		((x) & BIT(29))
> >  #define SUPPORTS_PARENT_CLOCK(x)		((x) & BIT(28))
> > +#define SETS_ENABLE_DENIED(x)			((x) & BIT(15))
> > +#define SETS_RATE_DENIED(x)			((x) & BIT(14))
> > +#define SETS_PARENT_DENIED(x)			((x) & BIT(13))
> >  	u8 name[SCMI_SHORT_NAME_MAX_SIZE];
> >  	__le32 clock_enable_latency;
> >  };
> > @@ -327,6 +330,12 @@ static int scmi_clock_attributes_get(const struct
> scmi_protocol_handle *ph,
> >  			clk->rate_change_requested_notifications =3D true;
> >  		if (SUPPORTS_PARENT_CLOCK(attributes))
> >  			scmi_clock_possible_parents(ph, clk_id, clk);
> > +		if (SETS_PARENT_DENIED(attributes))
> > +			clk->flags |=3D SCMI_CLOCK_SET_PARENT_DENIED;
> > +		if (SETS_RATE_DENIED(attributes))
> > +			clk->flags |=3D SCMI_CLOCK_SET_RATE_DENIED;
> > +		if (SETS_ENABLE_DENIED(attributes))
> > +			clk->flags |=3D SCMI_CLOCK_SET_ENABLE_DENIED;
> >  	}
> >
> >  	return ret;
> > diff --git a/include/linux/scmi_protocol.h
> > b/include/linux/scmi_protocol.h index f2f05fb42d28..71911dcd8117
> > 100644
> > --- a/include/linux/scmi_protocol.h
> > +++ b/include/linux/scmi_protocol.h
> > @@ -41,12 +41,16 @@ struct scmi_revision_info {
> >  	char sub_vendor_id[SCMI_SHORT_NAME_MAX_SIZE];
> >  };
> >
> > +#define SCMI_CLOCK_SET_PARENT_DENIED	BIT(13)
> > +#define SCMI_CLOCK_SET_RATE_DENIED	BIT(14)
> > +#define SCMI_CLOCK_SET_ENABLE_DENIED	BIT(15)
> >  struct scmi_clock_info {
> >  	char name[SCMI_MAX_STR_SIZE];
> >  	unsigned int enable_latency;
> >  	bool rate_discrete;
> >  	bool rate_changed_notifications;
> >  	bool rate_change_requested_notifications;
> > +	unsigned int flags;
> >  	union {
> >  		struct {
> >  			int num_rates;
> > --
> > 2.37.1
> >
