Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7943D812ECB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 12:39:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444052AbjLNLjP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 06:39:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444143AbjLNLi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 06:38:58 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2066.outbound.protection.outlook.com [40.107.20.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2BDF1712;
        Thu, 14 Dec 2023 03:38:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AnoJZ65LTyE4UUsEtGd/7aCIQlJ02AaZvMJlTQT4b6ft2JLBtUl297jhCbEk1+bGW2vBDhfo7iixKr9bZhRiJzfXr+Nk6171WM8Uh/W5CtK6kYJzkfRsegwnc1PlggJ4LSnBiXLD1XBXmixutScsuNvBlhW5gCuOZ3vseXnIEWw9t3EboFdm29PiS78euVRv6F61pGUfFMTIIBGzIdzlhL0qU4L6mLnYPTxiu76elAuvjutIxEPRlgjLQDFEju1do8ZaDm1e6ljezK/mlPDA+VZLuiajXr8IQRVXkMlmIarleHbcM7N7eaHlOcMhrVbF+tgJv/mi+/TdcZ9PHKVJTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FlivcE5GkM91NTYVJ9sUMcxd1tjC9FQtElnWe841dc0=;
 b=CfI1red6SyhkE2fShc9qqdya3T/VsoUnbsIyes1cU6qpovgYDmo//WpSiosPDaM09VKGsPKFH8XLTjUAX8Apf0uKgND0PZ4Nua/HM1DUXQoBWmYVYxf+Du4hmypNV6lcd/q3posVYlEmn3QX+8dGV2S1L/Bd9ZofEubE0UMoL/5/Lqxj7dEiAb8sCe4tiOFW7y9r70c3kMELqqn42V6XFkY0u7FS8NXRVkVa6c/2R6/TQLaDeB6wg+e6wyhaBtmHdaPRZom0rAqFPGL+185s76peVEAygLWeDYRwyeJl8oS2PyJQbdfSq4FpSoCplIcbPA0WkgJ+cPCFIeUrXyUhaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FlivcE5GkM91NTYVJ9sUMcxd1tjC9FQtElnWe841dc0=;
 b=Vf7Yb312FXZrUHTxw+lLEJeTzIrzIFeNOhGsH2Br/ed/x6Xi0DsCh9uphjNKWxxtUwphYP7XZtVWk+TMVYZMMn12YwlQ02GkmlaYouo8kwTjFKKA8D/s1OaCqK/6NSRfuSL0zEGDx8XdQyh7fjoN4Dt8CXJaQZ181xF7uOapP/I=
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by AS8PR04MB7704.eurprd04.prod.outlook.com (2603:10a6:20b:296::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 11:38:45 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::34dd:289e:9e8b:9c9b]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::34dd:289e:9e8b:9c9b%7]) with mapi id 15.20.7068.033; Thu, 14 Dec 2023
 11:38:45 +0000
From:   David Lin <yu-hao.lin@nxp.com>
To:     Francesco Dolcini <francesco@dolcini.it>
CC:     Brian Norris <briannorris@chromium.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvalo@kernel.org" <kvalo@kernel.org>,
        Pete Hsieh <tsung-hsien.hsieh@nxp.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH v2] wifi: mwifiex: fix STA cannot connect to AP
Thread-Topic: [EXT] Re: [PATCH v2] wifi: mwifiex: fix STA cannot connect to AP
Thread-Index: AQHaKjAcb/i+pQpnHEy+2M8UmgtSVbCoEGkAgAADiBCAAFflgIAAQzrA
Date:   Thu, 14 Dec 2023 11:38:45 +0000
Message-ID: <PA4PR04MB96380AA7B60AFD73491FF53BD18CA@PA4PR04MB9638.eurprd04.prod.outlook.com>
References: <20231208234127.2251-1-yu-hao.lin@nxp.com>
 <ZXpjjmD5Se7axJju@google.com>
 <PA4PR04MB96383A106724AC1CE683112BD18CA@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <ZXqwP7NscRtE1uGL@francesco-nb.int.toradex.com>
In-Reply-To: <ZXqwP7NscRtE1uGL@francesco-nb.int.toradex.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9638:EE_|AS8PR04MB7704:EE_
x-ms-office365-filtering-correlation-id: 5770426a-dd88-4bcc-5b15-08dbfc993b44
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kZ78Xb1OIZGd30Nqa7j6UQ7MGwpmmW/VdXa9Vt0fRvm6+WEhfWIl3yh0Fc8B8/xnWCNN+ltERpwOl0kghSZtjOmMfBDBR2BBUjI5qN44Pfpnh977UdIsRkTegc3B2HUluWF5VUbVZNGdTU1caigZ5/1vdUOBx3QlpZLv7fq3W8Nes80xkSp48Uhlun7A5Qpt4rMh+RLahT7FHN6vZAtyzq81Qr89j69uOycmN8ifeOclHzmNfkkJ0ycQt42ODQYeG6aF4WBsDZvWSGYMdZo2D9LQEpcdaIogYTrLKDPfzyjV2LICDWw9SjzQSZpXExHRN+f1ERBM38zpooKqJf4XI6w23tvz1jYuzPhKgUh80/jZALBN/k1yhtwDS/3jMhjZwkcVAaFkd/LR+OGEAX/71cW+SKZqIwDszZuA2Eooms5KzhgSEJWdP1nLAliEY3LKEDqPHtbDEYQN1j2Byjeyff2nnJD9iTGKDR3f6u5d0qL5U4i8N3MogUmtd+ZStCOMRjDEeGk8RRjZfiMHABX3J27UIXbx/CIbndIVn2LT/4a1jlNlC/dGMfyorD500nPePI9InLHw79RFY7DlGRPhr7zjeB97PhmZTtEmqPt6+fLWsRstdXf8+MgYrJ++Jsd4/VZZdQ+ngZdBKTFQl7In9n2wAFgZG0WY/tGZzdmv+V4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(39860400002)(366004)(346002)(376002)(230273577357003)(230173577357003)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(86362001)(122000001)(38100700002)(6916009)(316002)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(54906003)(26005)(83380400001)(52536014)(5660300002)(4326008)(8676002)(8936002)(71200400001)(7696005)(6506007)(53546011)(9686003)(478600001)(41300700001)(2906002)(55016003)(33656002)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BRn0fX+i7bXuK1gUfXUbA3liIVzELld83YiMYcmUuaWE91dCSmiFCqklRxYi?=
 =?us-ascii?Q?b92UdezvnLCHIBAp5fTDeA9TJLdA2sjJ0Q8VRc1DTY0yPB31+oYtFP4RK3RA?=
 =?us-ascii?Q?wv0NKltzIzLXDrwQnwOTNKRLcX5q16yfLysrIH4W+C1Zq04rVumzisgHo+dx?=
 =?us-ascii?Q?eQHnIgYeRxouEbwed5SVARbOBh0nf4LyE30oiMDkUOnZKtf/rHyBLv+hQNLn?=
 =?us-ascii?Q?pfIVrIjfEX/yc3BFF7NrumcuB3tHyonujNSbuyHA/iIS4Eej0JVP4suKKLDD?=
 =?us-ascii?Q?AqljCM5cYa+esc74mPtxCEnht3SmSXDM2JEo2Ul6rL4Nqi/55b/A9MZDMNe4?=
 =?us-ascii?Q?apwyZVVnc6QRTzv6lm9mF2NbqKPNV5vC4dXbu6Zeym4jGzBVlvRSSxM3s/fW?=
 =?us-ascii?Q?hVuV8opT5jLLi4TEfdflaQNGMdnK/ESTl0PjIWsLO3zLR+AhmkA04e76l7k3?=
 =?us-ascii?Q?VzC5hpFldj74csT985gnA7z92sPyOVjE4SchPy0vgh+V7/Akcgy+jz4w9QBz?=
 =?us-ascii?Q?Ua5PTzOczSiOh1b6it/jbtE27XfM76hggxxAOA1b1h1hi6RH2xFVa7pTVqL+?=
 =?us-ascii?Q?K9UKyFOB2ziEPrtw4dKx1NPHOgNgQBxdq0Y/8IcUTbaQSggUSZd43WnWK8ty?=
 =?us-ascii?Q?8i00NgfypAnRgjwLerRxuShrcS/84OZxu4z66i0Zsie3b/AFWJYdUHDrqrBo?=
 =?us-ascii?Q?gLzTVIW8yKHUvpTWW3qMCz7sKA82cJmO/xSqq3/zMj829tf5H1/RGvcpWBKX?=
 =?us-ascii?Q?0PbgJy1WUpeGclKxsByJBJfchn/SNOV++8fMN29cUch9pEzbgv1ZEXdbzoJO?=
 =?us-ascii?Q?xhZiFHDcalQpTDC1zW98TaugYdS81VxyZGxXBl6mjW9JMtL0g0p8pB/dEapn?=
 =?us-ascii?Q?HxIg0FNSfugSfHfnN78PZUlWg6Gv/A+PBpwfoJ+Bmp53Y02n5LCUn3otkJFv?=
 =?us-ascii?Q?7BPBKNcKf6fp9yGjR+krVWK4zHxwWRpp7ilYB0PNiUivyzBOhJqv+Ir+I5Cg?=
 =?us-ascii?Q?3WPqNARdp1rme1ko+MvPsMuSp557jDAi676RSq9aNkZYrgXoV5r1K2qIs7mu?=
 =?us-ascii?Q?Fa50XQciqofjx1vhj5326yAVYchQ7zHU2eSuq/K38MrDkn6ViqNQBHKxJ+F2?=
 =?us-ascii?Q?gLVRFY7/c7+AegATLPKYmOPnSPpimZQVQPkPTjYONFJTEMQSnO3suLJmztzj?=
 =?us-ascii?Q?8WJOEcYANoCSTu936JgIPvPrbbEk3eGWY0SXPVEWnwx9oq/GWVYvKxDV61zY?=
 =?us-ascii?Q?ZtzDO7f8nylTrX3Kp3WwhyvqyHvk4zPEiNUirvEPbhWLSHUu+eE0VRyzynx6?=
 =?us-ascii?Q?CgmuNrN435f7w9nN4Gq/T+MJYt4/FKvYln273KCTqy2Iz5oha8hDqd3HAACH?=
 =?us-ascii?Q?nvf4ia5KafPFmS80tDoOa5gu4tQ2MYFVa5e+zYRbB+PGxRJbIj1N2oZdPTML?=
 =?us-ascii?Q?1Rvlm9dRdNfr7WUx4Mjno1EUPoifLyRILJjZgwuSIpiXD8xmlbo8EvTJkfMb?=
 =?us-ascii?Q?gEhskCD5X6VHCHDMkiE+pQvwtOrop6eb4cj4xg0PdDC500jgmk3XkL7+ndEd?=
 =?us-ascii?Q?2BxwkdkJ1pY3O8ODZEuXWzi3A5z3HW7lluErGjXj?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5770426a-dd88-4bcc-5b15-08dbfc993b44
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2023 11:38:45.6988
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bFKIfzrY/616/86l9FFiph0MWfvis8XDwAak1qxh8buz+iRWCaYcttJQIagNn8QOXIpzX6n86nAsQeiV2nK60g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7704
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Francesco Dolcini <francesco@dolcini.it>
> Sent: Thursday, December 14, 2023 3:35 PM
> To: David Lin <yu-hao.lin@nxp.com>
> Cc: Brian Norris <briannorris@chromium.org>;
> linux-wireless@vger.kernel.org; linux-kernel@vger.kernel.org;
> kvalo@kernel.org; francesco@dolcini.it; Pete Hsieh
> <tsung-hsien.hsieh@nxp.com>; stable@vger.kernel.org
> Subject: Re: [EXT] Re: [PATCH v2] wifi: mwifiex: fix STA cannot connect t=
o AP
>=20
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report
> this email' button
>=20
>=20
> Hello David,
>=20
> On Thu, Dec 14, 2023 at 02:22:57AM +0000, David Lin wrote:
> > > From: Brian Norris <briannorris@chromium.org>
> ...
> > > Nitpick: "fix STA cannot connect to AP" isn't the best commit
> > > message; that could describe an enormous number of fixes. Maybe
> > > something more like "Configure BSSID consistently when starting AP"?
> >
> > Thanks for your suggestion. I will change commit message as you
> > suggested. Does it mean I should create another patch from v1?
>=20
> Just create `[PATCH v3] wifi: mwifiex: fix STA cannot connect to AP`
>=20
> Add the change suggested by Brian and the tags you received on this v2:
>=20
>  - Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>
>  - Tested-by: Rafael Beims <rafael.beims@toradex.com> # Verdin iMX8MP /
> SD8997 SD
>  - Acked-by: Brian Norris <briannorris@chromium.org>
>=20

O.K. Thanks.

> > > Not directly related to this patch, but while you're expanding the
> > > size of this command buffer: it always felt like a
> > > security-hole-in-waiting that none of these command producers do any
> kinds of bounds checking.
> > > We're just "lucky" that these function only generate contents of
> > > ~100 bytes at max, while MWIFIEX_SIZE_OF_CMD_BUFFER=3D2048. But, just
> > > add a few more user-space controlled TLV params, and boom, we'll
> > > have ourselves a nice little CVE.
> > >
> > > It probably wouldn't hurt to significantly write much of this
> > > driver, but at a minimum, we could probably use a few checks like thi=
s:
> > >
> > >         cmd_size +=3D sizeof(struct host_cmd_tlv_mac_addr);
> > >         if (cmd_size > MWIFIEX_SIZE_OF_CMD_BUFFER)
> > >                 return -1;
> > >         // Only touch tlv *after* the bounds check.
> > >
> > > That doesn't need to block this patch, of course.
> > >
> > > Brian
> > >
> >
> > I will modify the code for next patch.
>=20
> I would suggest not modify this in this patch, we should fix all the code=
 that
> is subjected to this potential issue.
>=20
> I would personally do a follow-up patch just to add the check to avoid
> overflowing the cmd buffer everywhere it is used.
>=20
> Francesco


O.K. I will only change commit message. In fact, this TLV command is added =
as the first one command.
