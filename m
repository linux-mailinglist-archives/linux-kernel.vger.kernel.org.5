Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDDB87C48A3
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 05:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345112AbjJKDzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 23:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345097AbjJKDzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 23:55:07 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2052.outbound.protection.outlook.com [40.107.8.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25DDC98;
        Tue, 10 Oct 2023 20:55:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kOWjRDzFOUggBWLKk9kkSaQwRFs0BhY5h10hhI+CgLslCdCBVgBxucl9ww1HN49Egtn4TXWzM1sOIw/yvtXBDr4s8d4NcEbc4m6EYTl0f9OPSH59XhmVsQweCObmwoe+D/41b829gUlhQWo3Ql6NPoNc1snUZBvP/TMIeZgT08Nthr0Dr+WOnP1npT5blhfXsStcRnN/64VoUMQ0f9zlqGR3pcW3MuF5MGxChKWt5zaCxTprbPc2CXm/47e6YWSBVOF15ID+RjjyK8DIX152ZzQZi2nTZkTeFHJGWr8lRvX2/Ux5NuBKL+/JK3hxh8o2fePzarhUw2W0oakJJd+wzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T52qtmprTBooQx6mLDVPgGPWdTyiu/jQp/g1FTtivTc=;
 b=UijCJjcjzRtTn09zW9OymD+fk9cRslwe4ufJF5Am8r0xL8ItCak4a4/U682JIIFRvD2utymerP3DEgjmJHmy2F9Wa/2xSZV0DUd5KOloUdaUX650heubXVhiY8ctjHYuOfrO8LWa7JCWJ6/HbCCQoNINet3PRDjKxqxQZqLDVRTDechDy6EeFXP4M5HWtiEeqSBuH86gC4E+Q3+uFjfUD8TxHlrAlUkt3JfhqU0RVVruIcU1EWFpzoTHMyX1BeptJ6p13JKLJBJfUADA8zzhsoJb8E/TsrnjF3GPv7jbs1aZTOOmhV+22sK8iFu2DjKAYRcnckL8YqOzvH9imoz7jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T52qtmprTBooQx6mLDVPgGPWdTyiu/jQp/g1FTtivTc=;
 b=rT91pRbhQleTocKTXxl3wIWlQWTmgCVmWiGuxGkIgRiqaI/lWkVE19sWECmSZITa7O6Ro8uLgWyhz+2mTK9VPJgAOJNbPUrgjwT8x/J/Y24JElISIfbY64c/L7LdfobdjAeMPwmqdNIXOLPTziAocMHNBP1lATUHVF57y7I0zW0=
Received: from PA4PR04MB9485.eurprd04.prod.outlook.com (2603:10a6:102:27d::18)
 by DBBPR04MB7593.eurprd04.prod.outlook.com (2603:10a6:10:20c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.43; Wed, 11 Oct
 2023 03:54:59 +0000
Received: from PA4PR04MB9485.eurprd04.prod.outlook.com
 ([fe80::31b8:3bf7:a0f3:d48]) by PA4PR04MB9485.eurprd04.prod.outlook.com
 ([fe80::31b8:3bf7:a0f3:d48%4]) with mapi id 15.20.6838.040; Wed, 11 Oct 2023
 03:54:59 +0000
From:   Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>
CC:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "souvik.chakravarty@arm.com" <souvik.chakravarty@arm.com>,
        Glen G Wienecke <glen.wienecke@nxp.com>,
        Peng Fan <peng.fan@nxp.com>
Subject: RE: [EXT] Re: [RFC] firmware: arm_scmi: clock: add fixed clock
 attribute support
Thread-Topic: [EXT] Re: [RFC] firmware: arm_scmi: clock: add fixed clock
 attribute support
Thread-Index: AQHZ+yDsjwKkBHlR5kuYildRcF7ttbBCvYCAgAACs4CAAAOpgIABD3+g
Date:   Wed, 11 Oct 2023 03:54:59 +0000
Message-ID: <PA4PR04MB94859C7729B19C8B88541F8692CCA@PA4PR04MB9485.eurprd04.prod.outlook.com>
References: <20231010022911.4106863-1-peng.fan@oss.nxp.com>
 <20231010091223.rvcyrgbjcrmjzmvp@bogus> <ZSUXu65bOYVG689E@pluto>
 <20231010093509.ddy75og4jd72n6cq@bogus>
In-Reply-To: <20231010093509.ddy75og4jd72n6cq@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9485:EE_|DBBPR04MB7593:EE_
x-ms-office365-filtering-correlation-id: 86be3a1b-f3bd-4137-e24c-08dbca0dd6ef
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tdLiPuw1pJKrN0QW7ljCxE0C2/J4MLhvXMuE/NRAVSkUmwy1eYdHl6VUauL74r61t3iEDLC4wLTetaeZv/1mYBtHe+755AbB6soAC+vqCWK8g8RhenuaEPKXD+obm8DQkipZYC3i5oc3ze6jXkFR/DQyYcqiSFdqOyKQeRZlHivCSIgUoNh1iSidyH0uqodijd+0qium4XQ9duGtG+V7SyrQdKd5+BzzxG6K80nhiZiz3nwVQPuNtaIIGzUaq1AyIMBp9JlK4IaGAERQxiOOI2RCYVYUEAjG9+KXKc2SSCIGBMNYd9Elgwb2GPFthKDF2H3IHnjPnp8n7mHOcvF9S/eSwgLiM3Vl1PVn0jZvCLkLLxNGRd6b88YATYHSSia/U5tCpl7aY+Vx8qEa9iCnbUu+cp7uDKr4+ZB2Np4JxMXrvhdfx15pq/uSuus2C2Wi6ep2ZxCo+Gretg1DGM+2GOv83Q8h9Dt1UvKE1KYZU8qZg3zAr3UjS9hElZ4yJjhX4i19hwAov6uk8f8jzck5yp97DnhbzlzlGrWki+Xz/nABdZqe8Ul979HSfyCema8IK6Em79buH2Px4+eJmw5MLH5zkmR2Hne6vOvROP74B8PGz99psA2fdZJGCBC0tuWa
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9485.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(136003)(396003)(366004)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(53546011)(55236004)(55016003)(6506007)(7696005)(38070700005)(38100700002)(41300700001)(122000001)(26005)(9686003)(66446008)(76116006)(64756008)(66556008)(110136005)(66946007)(54906003)(66476007)(86362001)(316002)(33656002)(52536014)(5660300002)(83380400001)(44832011)(4326008)(2906002)(8936002)(8676002)(478600001)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DJZIRw4cNlCAuQ2UBCy2itds4qOC9nTlGuA8QCBXNVzA3eZBCFa1YPHG2oQT?=
 =?us-ascii?Q?TUZ7/5zRJDx28F1PTCjCELfe4GzKodOk/AkzElsrNKIlLst6QO6qf1eqwHsp?=
 =?us-ascii?Q?v/tLf5hzNsAsL6PCv6mgD8CmgM1r5iKcK0BuqZ+iGRna3jAE3ryBuLnMUbeE?=
 =?us-ascii?Q?iifESW6zkHrtC/3mT9RDqDri+NlQg2z8x4GXucg6PH66a0MuwZ1X9JcuCcn+?=
 =?us-ascii?Q?ZDsD1TDzxWhR/13BmkA1fJq52TsKXeAMJfLH1cHCOBF+qZxR1FNZxFtCfhJi?=
 =?us-ascii?Q?lSy7hpvuGua0qltudr9Ngv3yYUJNXEBzQIR6gKI0Na0mN9qBRGDCIPHwyako?=
 =?us-ascii?Q?zOL2k72JnwP5ZCnlurSa36s8V+1MJpGAp5il5N89GlatkPpnoVS7Nq4DGLgU?=
 =?us-ascii?Q?zp69dVEwiXJd+gWVrdwXVFee8zzsyXVRKarFh0puVIuiEl+K9FgrY1UoqvL8?=
 =?us-ascii?Q?q6YTrPLyq9mBklw+MIGKWBsb2mjWz4WWzKj2KPJkmdIOKldAacKQlLcDyOUi?=
 =?us-ascii?Q?h0BPJxchESNic2NItl5spzH3uQWZoHdxg6Esvve/3cfRfu8SBNjxBn/0JfK5?=
 =?us-ascii?Q?eUOkTeqBKlIWCHKQc18Q5ctuz55SpzAssMFPsnKlI9y5/xEeWf7vSNR6eqVr?=
 =?us-ascii?Q?8ou8QmSQHgNr7V20AZL3GePM3Zcj7GP7BGAGqvvUNepiiGWY2UlLkO7oSG+Z?=
 =?us-ascii?Q?gkZPyKdvBs9UvlHXlllutbbCQ3A2W0XSue1ObFY1mLaocm0LKfb0b62NabE4?=
 =?us-ascii?Q?lbCyLJMNgA9puQwFzn05MaRuT+KaF4lORPAi459rupciwKXdy1IcxVCTYbWL?=
 =?us-ascii?Q?Ohg8Z/IPejOrgS2dN1mS+VuaNqcSBAhYNnqAkBVfR9TDFJcaPTIAwrRqAcQB?=
 =?us-ascii?Q?Lq93ZKWoz5rgXCOGmX4F3VE2xxpD8mTpfTJPUgnhU2cv3DF4KKptNJ8cJiGA?=
 =?us-ascii?Q?C36jCpozOZxjVoNvSj18cPO+YSrkLSQOyPMxzwPUOVhVJcb9vU0gOx0N3M97?=
 =?us-ascii?Q?U6z6lyiyjlaSyJqaqcjly6Er2awryAslfjt7Yse7pSzlYtlXdGSNTPDUeFRK?=
 =?us-ascii?Q?Vxqod2PD8b1UoSisCxJKnIQiGQEwOWQmTscmgq+f2pDnnNXFoYetQWqa6oF1?=
 =?us-ascii?Q?AYJQUejeiJiqmT6QFtjpIE4DO/B5/of7CFPdoMkrZl7c+oHtDaoI1roNnJT7?=
 =?us-ascii?Q?OttcTty7Scv1tsBsQYNXw2Wz/5vCq9HSca+ofF06XFIwGhviXkvy7cYA67Js?=
 =?us-ascii?Q?7+ECMnCE6Lkc+ULq50i63ozfgbU0Ft3pvu9uQ1Trs883qri+8PDQragepAga?=
 =?us-ascii?Q?e4Q5BXVspfTm/WU1kCXuF5zgUbOfiNXvtful6yFBk6GSV1r0NA5TfzaQW7yJ?=
 =?us-ascii?Q?AV3h2GsjKL+5/foFys8664QFfKm6rCG4biEFNMy6JwiPnHyeXIPYFZVEPJZX?=
 =?us-ascii?Q?MJCSpO8JjARmGawRdN4dfm1OAx1wmtNziCKDz2CA6Irqfy5tCwSO5Q5TRKfb?=
 =?us-ascii?Q?JCR8HLsuSQCSWF4YyqIjsXaG1f+dbls/DwIvUmhUNSD2rlhAM9HhTsM5Hjo1?=
 =?us-ascii?Q?BXLYKa42lb7WqkdkobcfifGVFqPVvUNSCrbtzhJNT4Lw8GqmDQ4CHFL9fotZ?=
 =?us-ascii?Q?UA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9485.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86be3a1b-f3bd-4137-e24c-08dbca0dd6ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2023 03:54:59.2252
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QpuMwpNlccJEXQWPSEM03bR+qTWgyS8h9iwzlnctdkHcM40mgmnxtCaP4NL2rvlDZJOCBA8nIpW6uQm1MT/dY0pZCGpnuj5wiLReCaa2nS8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7593
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From what I see SCMI clock protocol could benefit from an attribute for the=
 clock that describes what operations are possible on a clock.=20
There are many bus clocks that only the SCMI server manages and the error c=
ode DENIED should be handled gracefully by the agent.

In the case of Linux, perhaps this should be handled by the SCMI clock driv=
er, instead of allowing the error to propagate up the Linux clock framework=
? It seems strange that the SCMI server should swallow the error (silently =
fail) only for certain agents. I would think this would make debug quite di=
fficult and having a "DENIED" error code not very useful.

Regards,
Ranjani

-----Original Message-----
From: Sudeep Holla <sudeep.holla@arm.com>=20
Sent: Tuesday, October 10, 2023 4:35 AM
To: Cristian Marussi <cristian.marussi@arm.com>
Cc: Peng Fan (OSS) <peng.fan@oss.nxp.com>; linux-arm-kernel@lists.infradead=
.org; linux-clk@vger.kernel.org; linux-kernel@vger.kernel.org; Ranjani Vaid=
yanathan <ranjani.vaidyanathan@nxp.com>; souvik.chakravarty@arm.com; Glen G=
 Wienecke <glen.wienecke@nxp.com>; Peng Fan <peng.fan@nxp.com>
Subject: [EXT] Re: [RFC] firmware: arm_scmi: clock: add fixed clock attribu=
te support

Caution: This is an external email. Please take care when clicking links or=
 opening attachments. When in doubt, report the message using the 'Report t=
his email' button


On Tue, Oct 10, 2023 at 10:22:03AM +0100, Cristian Marussi wrote:
> On Tue, Oct 10, 2023 at 10:12:23AM +0100, Sudeep Holla wrote:
> > On Tue, Oct 10, 2023 at 10:29:11AM +0800, Peng Fan (OSS) wrote:
> > > From: Peng Fan <peng.fan@nxp.com>
> > >
> > > There are clocks:
> > >  system critical, not allow linux to disable, change rate  allow=20
> > > linux to get rate, because some periphals will use the frequency =20
> > > to configure periphals.
> > >
> > >  So introduce an attribute to indicated FIXED clock
> > >
> > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > ---
> > >  drivers/clk/clk-scmi.c            | 6 ++++++
> > >  drivers/firmware/arm_scmi/clock.c | 5 ++++-
> > >  include/linux/scmi_protocol.h     | 1 +
> > >  3 files changed, 11 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/clk/clk-scmi.c b/drivers/clk/clk-scmi.c index=20
> > > 8cbe24789c24..a539a35bd45a 100644
> > > --- a/drivers/clk/clk-scmi.c
> > > +++ b/drivers/clk/clk-scmi.c
> > > @@ -182,6 +182,10 @@ static const struct clk_ops scmi_clk_ops =3D {
> > >   .determine_rate =3D scmi_clk_determine_rate,  };
> > >
> > > +static const struct clk_ops scmi_fixed_rate_clk_ops =3D { =20
> > > +.recalc_rate =3D scmi_clk_recalc_rate, };
> > > +
> > >  static const struct clk_ops scmi_atomic_clk_ops =3D {
> > >   .recalc_rate =3D scmi_clk_recalc_rate,
> > >   .round_rate =3D scmi_clk_round_rate, @@ -293,6 +297,8 @@ static=20
> > > int scmi_clocks_probe(struct scmi_device *sdev)
> > >           if (is_atomic &&
> > >               sclk->info->enable_latency <=3D atomic_threshold)
> > >                   scmi_ops =3D &scmi_atomic_clk_ops;
> > > +         else if (sclk->info->rate_fixed)
> > > +                 scmi_ops =3D &scmi_fixed_rate_clk_ops;
> > >           else
> > >                   scmi_ops =3D &scmi_clk_ops;
> > >
> > > diff --git a/drivers/firmware/arm_scmi/clock.c=20
> > > b/drivers/firmware/arm_scmi/clock.c
> > > index ddaef34cd88b..8c52db539e54 100644
> > > --- a/drivers/firmware/arm_scmi/clock.c
> > > +++ b/drivers/firmware/arm_scmi/clock.c
> > > @@ -46,6 +46,7 @@ struct scmi_msg_resp_clock_attributes {  #define=20
> > > SUPPORTS_RATE_CHANGE_REQUESTED_NOTIF(x)  ((x) & BIT(30))
> > >  #define SUPPORTS_EXTENDED_NAMES(x)               ((x) & BIT(29))
> > >  #define SUPPORTS_PARENT_CLOCK(x)         ((x) & BIT(28))
> > > +#define SUPPORTS_FIXED_RATE_CLOCK(x)             ((x) & BIT(27))
> >
> > I don't see this in the specification, am I missing something ?
> >
> > And why do we need it. Can't this be discrete clock with only one=20
> > clock rate ? Or step clock with both lowest and highest the same and st=
ep being 0.
> > At-least I don't see the need to change the spec for this and hence=20
> > no need to assign any attribute bit-field to represent the same.
> >
>
> No this is not in the spec, it would require a spec change.
>
> My understanding is that they have clocks that CAN have more than one=20
> rate BUT such clock cannot be changed by Linux, only other agents can=20
> enable/disable/set_rate BUT they still want to be able to query the=20
> current rate for configuration purposes.
>

Fair enough. As I mentioned to Peng on the other thread, it is *not a fixed=
* clock. It is read only for this agent.

--
Regards,
Sudeep
