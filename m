Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 863A88016C8
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 23:41:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbjLAWlq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 17:41:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjLAWlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 17:41:45 -0500
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2053.outbound.protection.outlook.com [40.107.13.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16A65D63;
        Fri,  1 Dec 2023 14:41:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oQvCZrIHk8exYWqfGlLiNKzcP8J5pHArLStqMNt9c7S3AbQ2rseFroLDEp5thVOV0mmleOgm06PWhH4iuFtUjtvyjowTQ9m49AUi3vPq2hTZkWduHCLuXtWrhV86e2kso4ZMrYul16aiotj5G7P+ksk0e0GZC2iMNzvNVbxU+9H7EZLNR/xp6a4xs3Ptxl2qonsN6/Dr+2QhF6q9OnRNToPg3LKBforLorvnKqCRItyq7eY3jL49UD91PxD0SXNMXNr+AmWoUYx68l4DTavq8NQRrPCGy3S7Cv0BVOuikz/fNQyqHl4aba7LN7HvFzQ2WwJlx67UXd9d5PJuYbsLTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HNg42//TVRN5IL68zQ/mHR21Juhxc5SbYdecRttFX0Q=;
 b=HXw3m6DiFIytnOLkbMHTbRw8DnrhBG5jiQ9jvJuDRo4dcNP7j9o1RHi9jeJ0dXdctSAz7eFLRuAPBaihwELYK7geZ6sJt9rAatyT/8CjdC/gDYwIfeSQVkSZDJtVmFVeUbAfCWfA09HTpIVUVs2BxC75NLpz0WB2fkaHuVoAZOHiXgzPEYxApsX8lTp/K94Mq1tO9CDxVSQNpjFwbWrt8hSHA7he72v1GigA4aVzOuLz8dC5oFQnI8bA9JDfK7mUxgLyhNXXlYzBjHBog91FohPcec9eqVwAcUyE8cTmrVrvCKHtzGpGduM/vm98MtQLKuj6J+VaMatwtqGrMeCqdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HNg42//TVRN5IL68zQ/mHR21Juhxc5SbYdecRttFX0Q=;
 b=KksAv5MZONc78m6NUjGFikWT6csGUHmo8eTYl8N1oME9BHip+Am2T3RiLEjWE+06W6MwHFDAPVTnpRFHEHGV74tsYLZzvZuSwiL+GE0kAp6bS9TED5x5NkowSXc95d3IYwLnYddBiNOmU2M4O9EY/Ptkgi11JL6PXmKB8uxkwFs=
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by AM8PR04MB7875.eurprd04.prod.outlook.com (2603:10a6:20b:236::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.16; Fri, 1 Dec
 2023 22:41:47 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::34dd:289e:9e8b:9c9b]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::34dd:289e:9e8b:9c9b%7]) with mapi id 15.20.7068.012; Fri, 1 Dec 2023
 22:41:47 +0000
From:   David Lin <yu-hao.lin@nxp.com>
To:     Francesco Dolcini <francesco@dolcini.it>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "briannorris@chromium.org" <briannorris@chromium.org>,
        "kvalo@kernel.org" <kvalo@kernel.org>,
        Pete Hsieh <tsung-hsien.hsieh@nxp.com>
Subject: RE: [EXT] Re: [PATCH v7 02/12] wifi: mwifiex: fixed group rekey issue
 for WPA3.
Thread-Topic: [EXT] Re: [PATCH v7 02/12] wifi: mwifiex: fixed group rekey
 issue for WPA3.
Thread-Index: AQHaIdVU9t1lQPz4s0eWS+tlGSPAM7CUOvWAgADPRyA=
Date:   Fri, 1 Dec 2023 22:41:47 +0000
Message-ID: <PA4PR04MB9638C4474BE296DF113F22C2D181A@PA4PR04MB9638.eurprd04.prod.outlook.com>
References: <20231128083115.613235-1-yu-hao.lin@nxp.com>
 <20231128083115.613235-3-yu-hao.lin@nxp.com>
 <ZWmyQ9ilyAPGJmft@francesco-nb.int.toradex.com>
In-Reply-To: <ZWmyQ9ilyAPGJmft@francesco-nb.int.toradex.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9638:EE_|AM8PR04MB7875:EE_
x-ms-office365-filtering-correlation-id: abb1aacf-593c-44bf-77e3-08dbf2beb3ae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2KFKpqVrv4NUprU+kOUc61RJXbwN7tXcofoiPDLGcMRbCw4Agf1XyWElfr9r+rKoWlFnpF8/gKM3MCYDWWWtwYMYgxWc7eOIO52VLf25eZgXapVUvUt74vfOU6gtIpwgNHNZUUGelUcNIavRI+IittGrflflVOfBDFbeac9LWZgub+Xi4axNLyCxetbpVJ9SjzVRMcWit9P6yM0RpAI6iVIWnZddqb4jYSh0MCdA03+glUPcUwRwuVnLpo7LAbbY2cxPdB5EodYvL720bbGeKCyooZJDxw/kvdnSgphNB/PrGAvTnxA6zhFBiQeke6BoQXIjNXCMZ31INbNYzpkfmncyfP1PRICm6Kv7qD4qUuY7UP2iClznjZYCKCCW6s9p0mExGo3kkqiA1ZbuOiI2EaUwwPz1+HrmnbBrzDz6Zmuudhciq55bqFqo05ebrGVRC1yC5u6FIFY7veYbFgknTYA8F4IfQ/Ui3/wTXWL/vCNA6l7kPc6kk17+syA5FVPJrDaQ0twPxck140AOHZrkCmqLX6nw+Qjl3biMb49qVCRkRt3jGR0kaXnnRg0+MFwm5MCe25iSPB0Qj9QTBFHnYK8D3t8oSIh5eheA36PcwkXPXOAqCGmrDjRfp257rU78Mx8q89ArEI0gYVGVWp/xYGpAFvdLrZpChaPNoSFLedY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(376002)(396003)(136003)(346002)(230173577357003)(230273577357003)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(66946007)(26005)(53546011)(83380400001)(6506007)(8676002)(7696005)(8936002)(4326008)(71200400001)(478600001)(41300700001)(52536014)(9686003)(86362001)(2906002)(38070700009)(55016003)(122000001)(76116006)(316002)(64756008)(66476007)(54906003)(66446008)(66556008)(33656002)(6916009)(38100700002)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DLcT2nENcTh0M8hhp3BOTpZeuRH9Ltx/P8wvPB8oPPy3wprahxukT8gMIsi/?=
 =?us-ascii?Q?R5I2pRXyfld4Ej6+SBFO3AU54t5sRj/xfFQgta4HAVW5eK+rdoL+UYnyuPAz?=
 =?us-ascii?Q?b0oCG6QYColF1kDHrhx0C/HHO6UA1UYOd96omtKlCh8aE3GhIeG4Yuq7sagm?=
 =?us-ascii?Q?rw0tuVslnrBpwUs/FcdZTv1MBPdsqdDEuOqEvgcbn1cFidSmBe1IVSdAfwEB?=
 =?us-ascii?Q?V6TfOIi40QeERZAldLKEuUpDCjNYJ+BmUFCh9KsbM3R8569ElW95MjRNODDL?=
 =?us-ascii?Q?Gqw/0Z1azSPIlOxdGWCJNVYuMMNuoPmy2YPPGpRLPwZus42t4EoVudttMUzR?=
 =?us-ascii?Q?wBQlTkJbdp6cbRYb8mTvgVv5LHZ4JAEH3GMDLufpYt9nLtJHUx4DMkoZxe7m?=
 =?us-ascii?Q?o3RX/MR9PxOv5PrQCbkmPzi4s4kpUbycvEOEo5I4qBpqxN1IIOm1s5L56dR+?=
 =?us-ascii?Q?vZkuOfCeDn6363vpOp9FGK0ODM85TJwcKOlB5Tu9wIA4G0P/vMLX+XdLLmcb?=
 =?us-ascii?Q?OtF9dEEbe56nL5buxH210P7JC2KzIU8tPFh/3VXu/qZl14uSHTQX3hhNyPH1?=
 =?us-ascii?Q?99iELXjLOBwonN/NmyoOe2+a/JkaXWSvwvdQ4GE56v2D3TS0K1CDaSW5BNu2?=
 =?us-ascii?Q?eukrhffVJStK+TrgSaA6Am/2rha6WokEVGvPeim3vDpoj8DQt5PosFUnPTd1?=
 =?us-ascii?Q?qNkSecfKKweD/1yZ+p1ManoVb8GgWTL+omaDoz+J38QlvgrSOYvlRfKvLd9j?=
 =?us-ascii?Q?IUmIHm5YnmIY+5Rmg7eDFpRnLCquK42/hmrfWJ+a8IPhRzywue49iONMTdyq?=
 =?us-ascii?Q?ULsKPG5DrHThnzhr0IZro17HM01h0AM3O0ZJa0RFu+CayM4bGWZ/08yB8yrL?=
 =?us-ascii?Q?xaUAzQXcZOXt+1kTbg52wpVY6g48ar9RT7IMnbjYn2fC0UfHi4MxTKu4LDe6?=
 =?us-ascii?Q?38OV/2DK6TbLl9PIUIXYRAxrDKjhCnuPnMgJvBARPipowYvQGbwVHgH2bxL2?=
 =?us-ascii?Q?KczceN0VhhN/NX8s0PFAhfdnRqSHyy/r4g2cQAnrNjOn7wsjkMjzxe4lb38h?=
 =?us-ascii?Q?DiJtnS6BoimQu7sk1fT7J5aqPSI/cF4U3VQHmoQcsGU0EMPzQ/yzg4EtHw3x?=
 =?us-ascii?Q?F1QuP9JhCueBCgMLnPX9mWEPdFDo/rQnefdzgL+OxmSWsj7rWuynQ9kWFzP+?=
 =?us-ascii?Q?lqhxvsFYZ3PPHLkYUNrLfz+sZABohUIf63CbwSG55SZeOwUXuQ1LSwpHFuxp?=
 =?us-ascii?Q?/WKnoI30WgbOWS+7sOi4ht6hVUM5F3bb23PDDO64QpPItGTpviMVa8bfyoaB?=
 =?us-ascii?Q?cGPLPg8iLY4J0nfXEuVYbB59qOoO51lLvijDJBV6irGC0qejKKhb1orhV2qt?=
 =?us-ascii?Q?JAfZtCs5meq9e24X2YvwTEu2TTSxQINsFthdaAKGPV0kW/qVG0mT4j9UsITU?=
 =?us-ascii?Q?1zwXTC+s8X5e891pwCzI1fl23+8rUBrowQUW4ww5lLYoZgsdKPnLpEIBImNh?=
 =?us-ascii?Q?LQ2Lyk6GETGUJoz6MRVxlXFbT8Cuy1/IOJ6J3WaeHEim0zjaNd013YvGleQU?=
 =?us-ascii?Q?Q/xJf0n117DapzMRui8l1CYudDm8iKfq0EgeNK8F?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abb1aacf-593c-44bf-77e3-08dbf2beb3ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2023 22:41:47.4797
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oeiYWW0T/6ol2jFrkTse5dQZ9k4WgebPr8UhUn5Vex+Hzh83u5HdjUc+khU0lW8l9lvqpCrJsn2HXVRN2sZhcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7875
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Francesco Dolcini <francesco@dolcini.it>
> Sent: Friday, December 1, 2023 6:16 PM
> To: David Lin <yu-hao.lin@nxp.com>
> Cc: linux-wireless@vger.kernel.org; linux-kernel@vger.kernel.org;
> briannorris@chromium.org; kvalo@kernel.org; francesco@dolcini.it; Pete
> Hsieh <tsung-hsien.hsieh@nxp.com>
> Subject: [EXT] Re: [PATCH v7 02/12] wifi: mwifiex: fixed group rekey issu=
e for
> WPA3.
>=20
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report
> this email' button
>=20
>=20
> On Tue, Nov 28, 2023 at 04:31:05PM +0800, David Lin wrote:
> > If host mlme is enabled, gropu rekey offload should be disabled.
> >
> > Signed-off-by: David Lin <yu-hao.lin@nxp.com>
> > ---
> >  drivers/net/wireless/marvell/mwifiex/cfg80211.c | 3 +++
> >  drivers/net/wireless/marvell/mwifiex/main.c     | 4 ++++
> >  drivers/net/wireless/marvell/mwifiex/util.c     | 7 +++++++
> >  3 files changed, 14 insertions(+)
> >
> > diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
> > b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
> > index 40c39e4765f7..3d59e6a441b9 100644
> > --- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
> > +++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
> > @@ -3657,6 +3657,9 @@ static int mwifiex_set_rekey_data(struct wiphy
> *wiphy, struct net_device *dev,
> >       if (!ISSUPP_FIRMWARE_SUPPLICANT(priv->adapter->fw_cap_info))
> >               return -EOPNOTSUPP;
> >
> > +     if (priv->adapter->host_mlme)
> > +             return 0;
>=20
> this is a fixup of the previous patch, you should not introduce an issue =
and
> fix it in the following patch. Please make it correct in the first place =
fixing up
> that patch.
>

This is the main fix for this issue. If host mlme is enabled, there is no n=
eed for firmware to do group rekey off load.
=20
>=20
> > +
> >       return mwifiex_send_cmd(priv,
> HostCmd_CMD_GTK_REKEY_OFFLOAD_CFG,
> >                               HostCmd_ACT_GEN_SET, 0, data,
> true);  }
> > diff --git a/drivers/net/wireless/marvell/mwifiex/main.c
> > b/drivers/net/wireless/marvell/mwifiex/main.c
> > index d99127dc466e..3bebb6c37604 100644
> > --- a/drivers/net/wireless/marvell/mwifiex/main.c
> > +++ b/drivers/net/wireless/marvell/mwifiex/main.c
> > @@ -802,6 +802,10 @@ mwifiex_bypass_tx_queue(struct mwifiex_private
> *priv,
> >                           "bypass txqueue; eth type %#x, mgmt
> %d\n",
> >                            ntohs(eth_hdr->h_proto),
> >                            mwifiex_is_skb_mgmt_frame(skb));
> > +             if (ntohs(eth_hdr->h_proto) =3D=3D ETH_P_PAE)
> > +                     mwifiex_dbg(priv->adapter, MSG,
> > +                                 "key: send EAPOL to %pM\n",
> > +                                 eth_hdr->h_dest);
>=20
> this is just debug code, at a first glance not sure i

It will be helpful for driver to print out authentication, association and =
EAPoL key handshaking.
This kind of information will only be printed out when station is associate=
d to AP. It won't affect
TP of driver.

> > diff --git a/drivers/net/wireless/marvell/mwifiex/util.c
> > b/drivers/net/wireless/marvell/mwifiex/util.c
> > index 23675c1cecae..ff1b2f162c30 100644
> > --- a/drivers/net/wireless/marvell/mwifiex/util.c
> > +++ b/drivers/net/wireless/marvell/mwifiex/util.c
> > @@ -482,8 +482,15 @@ mwifiex_process_mgmt_packet(struct
> mwifiex_private *priv,
> >                               return 0;
> >
> >                       if
> > (ieee80211_is_deauth(ieee_hdr->frame_control)) {
> > +                             mwifiex_dbg(priv->adapter, MSG,
> > +                                         "auth: receive deauth
> from %pM\n",
> > +                                         ieee_hdr->addr3);
> ditto
>=20
> >                               priv->auth_flag =3D 0;
> >                               priv->auth_alg =3D 0xFFFF;
> > +                     } else {
> > +                             mwifiex_dbg(priv->adapter, MSG,
> > +                                         "assoc: receive disasso
> from %pM\n",
> > +                                         ieee_hdr->addr3);
> ditto

