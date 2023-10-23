Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B9B27D285A
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 04:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233111AbjJWCM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 22:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233155AbjJWCMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 22:12:54 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2041.outbound.protection.outlook.com [40.107.6.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 654CF10C4;
        Sun, 22 Oct 2023 19:12:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D2C1gD7cMb8r1Jg51wp38wvW8BtGoTw0b7XFisFWTMjFzzNpq8wURKTJB+rtwDBvfnkWCuYqn7Z0wd3Rj8u8naHIhJ+EuzjSENUr02gdTklXPnZ9Ohh8t4ssngBeRjPEPbmJbimyWuKHeOuYwWGUlTtWAo3o3uwHhkWhEcmId7lkJ6n7tJiktyGeTlA4aVMIZ/XWOuVCLrUdimzRTZP871BCxFoxPIrOZnVFJwE8hJBECtT+EFK8CddGVz2My3oGcBTY7frdZF5kwxo3zZK+zm65OYIJRHrG0dggeyzH04vkSaUFztfodizRkIPUQOZ/enssTlnkwqjTCSVGKBRvkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J0JOj4+9Sj76eZ7MBZAiIQSBi3C01FitxhSnw6MoYZk=;
 b=Xza8qvzXP6bSeB2curGgFdXQ9jkC2psvjEj69Fv4UwNyBbcJepzC9lIhMO0D51JghtJIWUvS595HFoP3hVZj5jDbY4TexPu7Fhwah//aNDBmdWWEk63RJOnwMaBOWsIzeb15cUY9jk+W04XZT3GW5SAFL2x9jI1bO0zu20OePsov4TUmJ9V59xAtwVN8M0VM/zkmxy8Q5QeasB/dMjpdujvwS0D93/dnwqXrd+50Rekf8QRofWtkpK7/68DEKTGff1Ga4AVCrh7gSLgL2FmuiXUroPhw2GhfE36wDAhbAGBQzbDJf8eA5d9CnkxUfBhYP3rXmWv13Of1X/VglYnaJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J0JOj4+9Sj76eZ7MBZAiIQSBi3C01FitxhSnw6MoYZk=;
 b=fz/jpFT3nvNYSKwu5QDYldZKSyfx/7MBx7t4Vr1KWqjh/T4hIWEbi3/x0vBJ+AmAGg7KVc+irz14VZU4+htKTlbYmEPc8XZeTCkPZox16URkIyjRPWsXUYM4HBCnrUllTyLnTUn4egZlUnx11fZGCSqET++iixY4er6GgOT72yI=
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by PAXPR04MB9643.eurprd04.prod.outlook.com (2603:10a6:102:241::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Mon, 23 Oct
 2023 02:12:46 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::34dd:289e:9e8b:9c9b]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::34dd:289e:9e8b:9c9b%7]) with mapi id 15.20.6933.011; Mon, 23 Oct 2023
 02:12:46 +0000
From:   David Lin <yu-hao.lin@nxp.com>
To:     Francesco Dolcini <francesco@dolcini.it>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "briannorris@chromium.org" <briannorris@chromium.org>,
        "kvalo@kernel.org" <kvalo@kernel.org>,
        Sharvari Harisangam <sharvari.harisangam@nxp.com>,
        Pete Hsieh <tsung-hsien.hsieh@nxp.com>
Subject: RE: [EXT] Re: [PATCH] wifi: mwifiex: added delay after firmware
 downloaded.
Thread-Topic: [EXT] Re: [PATCH] wifi: mwifiex: added delay after firmware
 downloaded.
Thread-Index: AdoDBnqsYZDxfBp+Q3Wpq1CAkxdKPABF4TyAAE4S+iA=
Date:   Mon, 23 Oct 2023 02:12:46 +0000
Message-ID: <PA4PR04MB96383AEDA0E0D42A11E5518AD1D8A@PA4PR04MB9638.eurprd04.prod.outlook.com>
References: <PA4PR04MB96388864C8B07F2B3AA7964AD1DBA@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <ZTPKedZWWAfDjmpo@livingston.pivistrello.it>
In-Reply-To: <ZTPKedZWWAfDjmpo@livingston.pivistrello.it>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9638:EE_|PAXPR04MB9643:EE_
x-ms-office365-filtering-correlation-id: 1fcb191d-08b8-43be-e99c-08dbd36d8c46
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: I3temUkkqua6WdhyuGbH1VZEXeo/bXN0iworOpGerUM2VKkWGTUNSfmmeicQDzIcDBJpKa0ggk6/eea1v14fPVmVJM2Sc+X+ZMVMr7jMpRSnxW6gYZLKWK85XaRknykL4yf1iN3eCBP50TQeU1f19wHu59UdV+2nvfZrYu5EiHevWQJNg3LcUSkO6Z1Nv3g2/WW8lrvew80O1YoGdaxBfcWnj+aNZIq37e7eTN3UavLNNvMTXv+uibmwl9rmf6yK22aNdurhTxtulheuTPu1RW+x87SEYeP6ZA8U7soFbH0FPpoWsZXm6mMXnkpzS0aE4J03CFKrpzRrGIwsWZMe1u4ETebYBxifZeiYW0bD3Hu/H/RFWgVo5G8Qy5IucPWgBGEPYM53UJEIVIxSRqzR09sv81JVEju6ea2ZAuxxmp74ZsmWSYdYsIWXadVykBGlBNz80t3XMlIqkccwjeCViNcxj0U/t7IF6CiZ511skJCfWzAUhTBhdWih61gx4AodHfQ2l4qgVSlOTDNKS7PiOM5oemfAaT2g2XDBuBDUje4R+oEG7pHJc0bN2ttAsi0DiWoxWnohUWhRaIXTdEm0r1+HEku6nokQCi0lX/4mo+7mEO1FtC2+5j6iv9VR/b2g
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(39860400002)(396003)(376002)(136003)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(38070700009)(66946007)(55016003)(53546011)(316002)(122000001)(38100700002)(66446008)(83380400001)(66476007)(66556008)(2906002)(7696005)(64756008)(478600001)(54906003)(76116006)(33656002)(6916009)(9686003)(26005)(8936002)(6506007)(71200400001)(86362001)(52536014)(4326008)(8676002)(5660300002)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jgJ+edL34odhGpQS8SjHZcnxXZZKnU36dY4MGPbZUGIw2eD1HE53H8AOSg8g?=
 =?us-ascii?Q?QVjNDOxJsG/CUSVzF/toxqyeMTJfyKWRg7B6uHSi/YDWtCQUj8G1zemBm7GZ?=
 =?us-ascii?Q?rXtvBZkW7wCEkX8nOCKpk+u+N8OSD0rxATpdPbQHgdxkCmgWru1jzKJ40yWW?=
 =?us-ascii?Q?gqQhfPaPtnPqBGQ3luf92jjjgHVWtPAAQSW82AawZCwMxDm8uv3mfLvTvQuD?=
 =?us-ascii?Q?NcSi2OIbXdt6hx6R7/avMs63i354gBQZ1MIL2qQQRCfm9sD2fIeeLs/miCeN?=
 =?us-ascii?Q?2YFZnvZvgQ8mjjnvTWxj18bwJOs1fg2aJ9EID6vv2mLLewSZBU7g4jwTvkh2?=
 =?us-ascii?Q?3EszZm0903qykEEeVDGjqt1HMUw3mvAmdANYzZQN7+osX9hlDJxhPjsAVOtk?=
 =?us-ascii?Q?EmwvPl1uayIzya8DG3SJA6PDb2b66J+T7QX8spiQzIdRyFa1omzYelfas1fH?=
 =?us-ascii?Q?75WkUsVTl6bTIApg0tBJHLqIjhiez13OZ8uw7RfYh1iITknjza8FRLRKY8/w?=
 =?us-ascii?Q?cStNI5AnR5XDwwqqw+QHQ+hgIaOh9nNm0GU3+e/QHtbr6I/I/OgY9i8lE3kD?=
 =?us-ascii?Q?H6vLgMamVsGZ2rcFxJBr8c4vKjmc9lDVJcpI38WiP9FxjNsQHIbt/mpmY30m?=
 =?us-ascii?Q?Oq7XZGRhCSeU3MiMOJrgibW0CIvHLEj1/8ZB4T7AFkw3kEGcBHC1wooALrRw?=
 =?us-ascii?Q?BWA8Obcf//6pISbJniVDCYVSL5aeIyAp/vea3BlRRXu4Ck4h52cZArFDZ79X?=
 =?us-ascii?Q?LtM9lee5tndLYJCBc4CelQHfi+08pQWagKCyHjutsqcnhEEmVHziHro5DrIJ?=
 =?us-ascii?Q?ZVfXOIc23fUPqcoYWy2SHu9/EngGq0SHbLaR/7ghNImmaE+q+JarKZ5PlUIe?=
 =?us-ascii?Q?WM465eCJ2y2B5N6aHT0cJ/Pi4+nRWwpf0afGSKsYtdeoFHiyxaAASv1eW6s3?=
 =?us-ascii?Q?Z4hSEAcU+vJ1Fro7xgNGwS/aUe+g0uPFc2p/RFEDnGYh/OzqpQyPB5ku0uhb?=
 =?us-ascii?Q?ff+bopowmn/SzWuQrigEwZOoV0uB0Pyhe1p77PeGXxd1QfRdJGTCa62BAROQ?=
 =?us-ascii?Q?lk1gvz0O60HbkaKd6UauJjzVMYCWIknLEUrz53juuCfkvuSGhl3/XmSIEUUg?=
 =?us-ascii?Q?Gph+Gst9De1DX2QmB4PTMx9I8ztjspZS6qLOwyGNhQoYLE1B6mQaTJAsjEPG?=
 =?us-ascii?Q?SdzfkFiOWsaeEVTtUumvdK8Y2f94Apm2XnL4du+RvMw7st5l1kqPrKH0YnlD?=
 =?us-ascii?Q?j5fZKByRIMdacAFJOYP9mhVvAADrfZqq/3L1S7ptu/HcOQFnMna6BRdutPsl?=
 =?us-ascii?Q?qPRagySnHNxQwyjuVimhTl0qqffIOqY8wNd4hbzus/8mLq6tIzJ/R2b0OA4z?=
 =?us-ascii?Q?bsLhiGemUeq4YAIRYPvBeFC3fMCENCSZNIeY9QFpL2X+cud/gmmxWLkztzSV?=
 =?us-ascii?Q?9c5N8yej/QZSX/lbHZbxNoP8EECH21CZt16BrzUKA9gYgx+Dmohz5de4TuCq?=
 =?us-ascii?Q?+UWEW7mkkpbpwazpv2FYELtQeWkJe3BD2Hls8B+Gzq9FVKx4YG9/SHOTQjrD?=
 =?us-ascii?Q?N/Bviq2eJA0E0bhK8E7Kkbn5+9s6RhJZVSRS6/DK?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fcb191d-08b8-43be-e99c-08dbd36d8c46
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2023 02:12:46.1131
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tiOF192vc6QZVxwBeMhjwtIaIdBDU8PR2n0dwOKBtrYX88jKgKPtFnzubOpXs4UbrnEX9ZPyMtMOOl3VVLgfiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9643
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> From: Francesco Dolcini <francesco@dolcini.it>
> Sent: Saturday, October 21, 2023 8:56 PM
> To: David Lin <yu-hao.lin@nxp.com>
> Cc: linux-wireless@vger.kernel.org; linux-kernel@vger.kernel.org;
> briannorris@chromium.org; kvalo@kernel.org; francesco@dolcini.it; Sharvar=
i
> Harisangam <sharvari.harisangam@nxp.com>; Pete Hsieh
> <tsung-hsien.hsieh@nxp.com>
> Subject: [EXT] Re: [PATCH] wifi: mwifiex: added delay after firmware
> downloaded.
>=20
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report
> this email' button
>=20
>=20
> Hello David,
> thanks for your patch.
>=20
> On Fri, Oct 20, 2023 at 03:35:34AM +0000, David Lin wrote:
> > Added 100 ms delayed after firmware is downloaded and active in order
> > to avoid command timeout for the first command sent to firmware.
>=20
> Please have a look at Documentation/process/submitting-patches.rst.
> In very brief:
>  - you should use imperative mood to describe your changes
>  - this is fixing a real issue, I believe this is worth a more complete c=
ommit
>    message, including a log of the failure this is solving.
>=20
> I am also inclined to think that this change should be backported and it =
likely
> would need a Fixes: tag.
>=20
> > ---
> >  drivers/net/wireless/marvell/mwifiex/main.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/net/wireless/marvell/mwifiex/main.c
> > b/drivers/net/wireless/marvell/mwifiex/main.c
> > index d99127dc466e..a25e8bb8daec 100644
> > --- a/drivers/net/wireless/marvell/mwifiex/main.c
> > +++ b/drivers/net/wireless/marvell/mwifiex/main.c
> > @@ -570,6 +570,7 @@ static int _mwifiex_fw_dpc(const struct firmware
> *firmware, void *context)
> >               goto err_dnld_fw;
> >
> >       mwifiex_dbg(adapter, MSG, "WLAN FW is active\n");
> > +     mdelay(100);
>=20
> from my understanding there is already a function polling for the firmwar=
e to
> be active, e.g. mwifiex_check_fw_status(). Maybe is that function that ne=
eds
> to be fixed instead of adding an additional delay here?
>=20

O.K. I will check the function to see if I can add this modification to the=
 function.

> Francesco

