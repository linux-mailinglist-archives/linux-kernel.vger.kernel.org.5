Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6C67BF631
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 10:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbjJJIj6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 04:39:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234741AbjJJIi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 04:38:58 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2085.outbound.protection.outlook.com [40.107.7.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8E84FD;
        Tue, 10 Oct 2023 01:38:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UdolgLPSRwxlmgMmVtoBEnsO5SYEz9jtFeFkg8J72Etvg5ikjT/An4h3fMqzIsW6nbyplcPfB2b8Q2KybMkCQJpMH6hukNP5zQlJD3ohmvoFauYKV3FL++elBkcyCloUUyzUIxyOgEUImqU8hP+Zy2AkUYUgoRNgpSu39bghp4KcG87Hwj5eAHYSKt0IGf6kx0q+I9G7VUVBgdQQ42zlDwbFrATSqfO6XxvymL83OOMFhnDt2x7SVWDtOliUe2Fe8enPp1+O3GdFvi5O3impXrj2JE37OVPwMYiNqj6bg0bIdWGNbmUhlrTYz0bl26uKSaYmERgOldJaitdijnq9HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hMfDoSWsNq5BK+t1vRO7eaKTMMTTD37//I8W0HqzHM0=;
 b=diTEJ0FEATlL4Aw7guCCGzfIhvJutOwD3pAfngh/mcMFZF+qJEhdWjoPKhp2eCPJUZAYec8zejO3kXto9Q9mzvFXcH1OxKjC39uWPqh4yxAMIb81wSS7lyUlqUnJF9xqCI2kwsicNjpLjX6iZX+3pCmNhwwBGlo6UYjBpncJiZEv6O47SiYoEJJQGcMhgf9GadIqw+5367pgJ2zF8IgjnlOCQeXmtRxC2AG35PNZfTM4qf3u5Uy0Qxx0eqXRNpSgJMPAd7nRV88lvfTE5TOlZBb1Ng8pUboAddIZNo6lqRcHGVmyS2xZwLrRgaMZgLCnAmJblWlZAALDzf56rrG/Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hMfDoSWsNq5BK+t1vRO7eaKTMMTTD37//I8W0HqzHM0=;
 b=luoY2RjZK5/y4agOpsQOiGfI5eqRoskcieXlDWV5c1ZLtRiJaE5kZqapwXDHUeMV9bXa/wtbaDZjy4nBljHM4BU+v4Zq3ea2FfBOhIDwQbs/Amvvoo5+1wBDwDftS9Amf2f5bZe6K22Y2dqW+Mtscwc/kwxTlo/IQFI6kyC5cD8=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB8474.eurprd04.prod.outlook.com (2603:10a6:102:1dd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Tue, 10 Oct
 2023 08:38:12 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b%3]) with mapi id 15.20.6838.040; Tue, 10 Oct 2023
 08:38:12 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Cristian Marussi <cristian.marussi@arm.com>
CC:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
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
Thread-Index: AQHZ+yDr+00Lv1J4akKijvcbZFMOArBCpluAgAADbnCAAAfGgIAAAWpA
Date:   Tue, 10 Oct 2023 08:38:12 +0000
Message-ID: <DU0PR04MB941774AB05A2FD491CA4DF3588CDA@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20231010022911.4106863-1-peng.fan@oss.nxp.com>
 <ZSUCDdfJjs1blK1T@e120937-lin>
 <DU0PR04MB9417DCEC4CA9DA488796194C88CDA@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <ZSULYoS4FUNQaVtd@e120937-lin>
In-Reply-To: <ZSULYoS4FUNQaVtd@e120937-lin>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|PAXPR04MB8474:EE_
x-ms-office365-filtering-correlation-id: e19a1c22-6d2d-4329-138b-08dbc96c3d67
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xAUsJxpfGTjDMD5Nmpt+jjOJHcYDCNpiBXahz9ufCW8QtGcPA1rvo/9RxRyc53JjEEDdpq4PlDUs/uP/Vt6FiT78XOmxJO1v8rP9OzNdAC98OkO47f/crCNYseRGgkr7uhy7qbY+A1/ZBvPHHy+axX4kr9g/ZUphJVOaTN+lQrh97LNLSq/XfeJ2/Wfmv78MORv2kQNa9wAkuaX46GzVgXnLitESd1vbl73XKpIS33dTenZQEJ8Id86DbF/efF6tCtc1N6unPI9u3ywBz0nF277KnTYl4Psqse+9w1HMTiY7kAhPsWzubF7BNjpSF+88eI3QmldRyrNdWfC31yhMDw6fRFWUzDcwNq5+9HCgoqTkbZwkYyEm4WQW5I6BsghxelJG/iAWh+MgNcgWKUV3NFIL1QW+gNUGQYOpFUAL+x8d5dr+YrEr6QdsC2v8pNrJDZ7O4lLMDn+DxQ5BaEZL+boMXyFQAB+QzyV69DhSOOvBV4c61YnG3mma3u4+uZydJm9Z3gyTuGcwCp0D53TwQL7BGWgcSAWGCirmmH9Zbt12qKmXdZYb2uTMrT2GhXrSVBTcFEWh5wINK0i0KdlAGTPuG93prFxa3Dxo0cy2HGxgqs59EhNFb6SA0NOWv8uy
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(396003)(376002)(136003)(346002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(316002)(66476007)(66446008)(66556008)(76116006)(66946007)(54906003)(6916009)(64756008)(38100700002)(44832011)(41300700001)(5660300002)(4326008)(8936002)(8676002)(52536014)(33656002)(6506007)(86362001)(83380400001)(38070700005)(7696005)(9686003)(122000001)(2906002)(71200400001)(55016003)(26005)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+qrcbrSJ1oyoQQRE8Acz02ZXIDJXI4Ed2NcUPotcM4iHskCB1gYpOL84zQJp?=
 =?us-ascii?Q?AFF1ctP9uzqF21QHQKjSHBDHi4PE/wqFY/4biqh4hzmjT13WzlJwjn6Q3AWh?=
 =?us-ascii?Q?r0cOVzHpy9TqaLWNWMmQSJlztNDgPK0mzmfr01ZywOSsj6XwEgnCwzYlf+8n?=
 =?us-ascii?Q?cvDboUglh7sv8wif82oEBRDpyx8xTnEltbd514iWmT4+4jlLfh6/fO517TlT?=
 =?us-ascii?Q?WcPebBV0Jg/p3dXx3GvJKV2+msCGX7Y1W6imAnJgTf7PkLMxaVO6/+5uxgT5?=
 =?us-ascii?Q?Ea9520paHQWfGzWhW5GYqIThOa+Lk7qZHcB2bwAOxaKCtM1cG9miHRYsCrpQ?=
 =?us-ascii?Q?bJ3cpsnDP2w3Qucq4QMpJZDwp+S9/0XFW9CKthlV/mTijm1i8iEUHJsGEcCt?=
 =?us-ascii?Q?pATR4xj6Z5etCpSRRxJ99YvcwmCMcw6Yra4NJ2mqV0CGGQCrPTmZzY6NCwCE?=
 =?us-ascii?Q?H0RbNV7tt4NIfFYrDoSRG3n45ZOK1HkkOym9dz8mknWlajl5cq5BzejsRL8O?=
 =?us-ascii?Q?15DKRqB6hos7KwWpGoAKsPzQk6gz+2r+Jnt8kKj9mPGF1u8Pv5GYCE85NgN6?=
 =?us-ascii?Q?keVEdc+hyc14HngrFF4EaXF6768HUjSueE5cCJ8r8jSSpaKe60S+1rsp94I4?=
 =?us-ascii?Q?DijI4nQ+yreqlRV+rw8nAA/kse5y0ZJ1a/Ds2FkdckVEM9B1LkvhLzhk2TCa?=
 =?us-ascii?Q?YOwsker/jcJnVs3ELcqSlD0TTd8z1/A524Dt1gtfejRToAYu4kARqOBgntKm?=
 =?us-ascii?Q?l4qWX/FV7ETzvFG317OoP64KRndBbRrg+WvWX0u6YPhWT6i8TmTuLTZJwm1Q?=
 =?us-ascii?Q?Xj2a3ADQk7g1Vt8yYXQfIqksny2+sND6TchA34DiQ8ZgOp9tRO2kIHxKkb9p?=
 =?us-ascii?Q?gAvfQVudUJDgZy1JROXLf3tOLj2r3DZVu31r+KDoFn9kLNr3b9jH5IkiATU7?=
 =?us-ascii?Q?4eQJa72fuCSMdmyVPL2aHkCaWYDE65R6iU+NjPkLpzt87hZE/DYgb7oC19ZX?=
 =?us-ascii?Q?Y20HBEOQ8h6/Z8M1hB7q9KdaRyvAct6pq1OGDKcNQsl5VY/wvFf3/XHyRyNn?=
 =?us-ascii?Q?lrUB6t6MrFdYLDMwTjIu7oAUeffOtIya5jpKAZLvg6YjO9xIbPRY/PGaRPpr?=
 =?us-ascii?Q?skVo6puSv731ip7RmUfyVzzmV531LpsyADJl5pphU7dmgOKjVvu8utPjkPCI?=
 =?us-ascii?Q?xlb7yuizw3nkY4vu0USCCrdCoDkRfGmcRWrKDDpKaAqt+xzfVyF8idQriIk5?=
 =?us-ascii?Q?Ql9PZW592+qb1/Bucrfsn52WWMrTayqgGxm6UeJTXU9ytlGRyW0MBDO85gqR?=
 =?us-ascii?Q?0KOWqDiF8y4x9qPzfmjCb08xAjtAv1q3WfEqtGr26aARsYzepJPEbBoFgYG3?=
 =?us-ascii?Q?ouecaVnHM0EXNpQN9kuGlIUgpCqDPlBKDwzyVQeZB6+kCKXG0Bqb1iNwE0B1?=
 =?us-ascii?Q?Z6tugDae0kWMyFXvSR6HXqUWe9maCebAVTJiCmFajdCgpVntXpZ+sk/laayo?=
 =?us-ascii?Q?1TdBMLLwCjMf8DqlxofxcjROKrQyk7+kAlq65fkXoMhzhHR75plaKHKEdQHV?=
 =?us-ascii?Q?IAYkqnq/X5IqnatgZ0A=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e19a1c22-6d2d-4329-138b-08dbc96c3d67
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2023 08:38:12.6631
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yquDJ2Ho08ai3lx8jXFFxmMRmsMPEro1keXjVnF7Krx2ZeWJ7UQVPnsRGq9RVBP+MByaQnGERL2evh5R02QAYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8474
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
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
> On Tue, Oct 10, 2023 at 08:08:01AM +0000, Peng Fan wrote:
> > > Subject: Re: [RFC] firmware: arm_scmi: clock: add fixed clock
> > > attribute support
> > >
> > > On Tue, Oct 10, 2023 at 10:29:11AM +0800, Peng Fan (OSS) wrote:
> > > > From: Peng Fan <peng.fan@nxp.com>
> > > >
> > > > There are clocks:
> > > >  system critical, not allow linux to disable, change rate  allow
> > > > linux to get rate, because some periphals will use the frequency
> > > > to configure periphals.
> > > >
> > > >  So introduce an attribute to indicated FIXED clock
> > > >
> > >
> > > Hi,
> > >
> > > (CCed souvik.chakravarty@arm.com)
> > >
> > > so AFAIU here you are describing a clock that really is NOT fixed in
> > > general, it is just that the Linux SCMI Agent cannot touch it, but
> > > other SCMI agents on the system CAN change it and so, on one side,
> > > you keep the ability for the Linux agent to read back the current
> > > rate with
> > > recalc_rate() and remove all the Clk frameworks callbacks needed to
> > > modify its state, am I right ?
> >
> > Right.
> >
> > >
> > > In this scenario, it is really the SCMI platform fw (server) that
> > > has to implement the checks and simply DENY the requests coming from
> > > an agent that is not supposed to touch that clock, while allowing
> > > the current rate to be retrieved.
> >
> > Linux will try to enable, get rate, runtime disable the clock.
> > But the server does not allow enable/disable the clock, so the driver
> > probe will fail.
> >
>=20
> Which driver probe ? I have just double checked and when clk-scmi driver =
is
> loaded there are a bunch of SCMI queries to the server BUT no *_SET
> command is issued during the clk-scmi probe; indeed JUNO had never had
> any issue despite having access to a bunch of CLKs which are visibile BUT=
 not
> modifiable from Linux.

It is my setup, I2C needs CLK BUSAON(this clock is also critical for system=
),
SCMI server exposes this clock, allow get rate, but when linux try to enabl=
e
this clock, SCMI server reply denied, so the i2c driver will probe failure.

Regards,
Peng.

>=20
> > The SCMI server could bypass enable/disable and only allow get rate,
> > But this introduces heavy RPC, so just wanna whether it is ok to
> > register fixed clock and avoid RPC.
> >
> > >
> > > JUNO/SCP is an example of how the CPUs clocks are visible to Linux
> > > BUT cannot be touched directly via Clock protocol by Linux since in
> > > the SCMI world you are supposed to use the Perf protocol instead to
> > > change the OPPs when you want to modify the performance level of the
> runnning CPU.
> > >
> > > This kind of server-side permissions checks, meant to filter access
> > > to resources based on the requesting agent, are part of the SCMI
> > > declared aim to push the responsibility of such controls out of the
> > > kernel into the platform fw in order to avoid attacks like
> > > CLOCK_SCREW by letting the SCMI firmware be the one and only final
> > > arbiter on the requests coming from the agents; you can ask teh
> > > server whatever you like as an agent but your request can be DENIED
> > > or silently ignored (in case of shared resources) at the will of the =
platform
> which has the final say and it is implemented in a physically distinct co=
de-
> base.
> > >
> > > It seems to me that this patch and the possible associated SCMI
> > > specification change would give back the control to the Linux agent
> > > and could allow the implementation of an SCMI Server that does NOT
> > > perform any of these permission checks.
> > >
> > > So, IMO, while this change, on one side, could be certainly useful
> > > by removing a bunch of unused/uneeded callbacks from the CLK SCMI
> > > driver when a fixed clock is identified, it could open the door to a
> > > bad implementation like the one mentioned above which does NOT
> > > perform any agent-based permission check.
> >
> > Thanks for detailed information, let me check whether our SCMI
> > firmware could do more on the permission side. But if RPC could be
> > removed, it could save some time.
> >
>=20
> Avoiding to issue SCMI requests destined to fail would be certainly good,
> even though it could lead to just quietly implementing a server with no-
> checks at all, but why these unneeded calls happen in first place ?
>=20
> I have never observed anything like that in my setups.
>=20
> Thanks,
> Cristian
