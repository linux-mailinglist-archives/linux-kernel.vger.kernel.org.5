Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 370247718C8
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 05:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbjHGD2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 23:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjHGD2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 23:28:11 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2078.outbound.protection.outlook.com [40.107.247.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BAFAAD
        for <linux-kernel@vger.kernel.org>; Sun,  6 Aug 2023 20:28:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hH3imy+TJVHfe8rPxLJf5eLGWDK+/tWk4LP9yABuagE10D47Q218TSqpcvPVvxWKPTZt+6ru/sUErM5qyu9BVOCQhPJLko7FDTkjw5E6WSG0tEmhj+9K0N4YW0+PEXXgpYSgtNHq0nIeRY5DER4p0uX8nH7GbwcxSKTaVKnbPk+2ne0j+FLrBfLGf2ggtElrsntjcTVRkvGnJtan03yJn6kYTP4zdOKgiV+JmkMW8vvmj4iL2CpSSf21tbWtiQtFUhgpu6L8RcEr4+z/ykzm/2Q4MGE4OUcrpqI8wcnkCz2H740gzqueQqEpT8E1CY9J69qpplsbBAc39Hj4Efv75Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p8oTNnT4NAr29npNPDgLgQoOW/vdMcHkhSAJZ4nGt0Y=;
 b=UOFyclsgouXqBRwTNYvaJ0LyT7G0LYQef/n4NS9M2awM/RvT2SKs+Ozg6yNgBbXYhrY/LGZ/4yJRiTM+/WMOxD34XB2BAR5ZDXmmWtmeVDXw5f6j/e3ChUkhy26qgRFwUr1fvuCE06IlvUOH5RdCzdlFfFsSi7R5kSzSplRWfN6aut/4abpD4YyJQ0FOz2HJm8aR5FucYx/m2xIZiod4yE59VwBrSO+ejmQcG88x/k294EUApZnzlemP38tcLgbjOBtsW9XN5ANzN29SVlcTCkVXXdQwKqJmzw5+f4j5KhmI7xH+w4teS0sqaO2LLTVmMrPR0ZvkHinz5B07bobfeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p8oTNnT4NAr29npNPDgLgQoOW/vdMcHkhSAJZ4nGt0Y=;
 b=MnajK7Qt4F7wCdQ4UrYsRptICAs0emwKefSB743qJL/txhc2FmjB9a8NTJ5RTSd3FrfRjEbzKxPMJs1aqdZZQ/32rWspkx+5i1lzyMZNuyEnOOescNXuWb2UT6lRk8DoVOe/oyAjZXZXaojkhzEjIzog33Gf5QqHk0IM1kILtog=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM7PR04MB7014.eurprd04.prod.outlook.com (2603:10a6:20b:121::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Mon, 7 Aug
 2023 03:28:07 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97%6]) with mapi id 15.20.6652.025; Mon, 7 Aug 2023
 03:28:06 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC:     "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "alexander.stein@ew.tq-group.com" <alexander.stein@ew.tq-group.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Robin Gong <yibin.gong@nxp.com>
Subject: RE: [PATCH V5 6/9] firmware: imx: scu-irq: fix RCU complains after M4
 partition reset
Thread-Topic: [PATCH V5 6/9] firmware: imx: scu-irq: fix RCU complains after
 M4 partition reset
Thread-Index: AQHZw41xv1ojgpBuAUSkGn78CZgks6/eMxOAgAADviA=
Date:   Mon, 7 Aug 2023 03:28:06 +0000
Message-ID: <DU0PR04MB94177737DACD5C77C55E3129880CA@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20230731090449.2845997-1-peng.fan@oss.nxp.com>
 <20230731090449.2845997-7-peng.fan@oss.nxp.com>
 <20230807031309.GO151430@dragon>
In-Reply-To: <20230807031309.GO151430@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AM7PR04MB7014:EE_
x-ms-office365-filtering-correlation-id: be818c49-57f5-4b53-3e52-08db96f6510d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: S7eHCaXQLFhTYpbmT5Ir8Vbkc4Rps+73Ufc3MzpkE1NLmeORd/GDV3ieQiiVc6eIgUw7PVGMvASOMdnJxCzoa2zSH4C8fmsJv5LwOvFYCZ49ndMM0eLdcg0hc4M743vtdUCsDslnuidvC+JSgb098SpdXK2NHeh33tdnMKR5SL8iRT7CM523V97tZDw4fKFM4YnLdf1jo2Slcd9YV0EjIKgDvrJDQPDzKAPr/LH52tZ9Xxy1T3rOlNzeWet4VVdxdqs7CT5mBzbFrRQ5peiX0KA1YxnbcTumDynSOv2iIuEBUfwj1KXw08deHypSXakNRi76lIx0Mnvd4hrD2sH4L/Prvp1pmujd4cNI7NsfxLp5eJ8akT+mCCHdW3NKq1vUhJskfyVeIkKHZQdy1ke8jn96gTKoTB+n+6y7Q5jdAEyTfMc0c3ZlZjj29zU3wAAXoOKJ8N3OIPaULlNcOmQqgdlDCoxK3u7Uf/qtKOv0+ovdPo2iLGluzn2o9Z2N/eShRWdGxyUxbWXY5phbW/UDAmsArKnamk5c5duhAjDKu3QZVHPvlgAjrVz+t+jHdPTEDRmAStYQUln9V/91K/Txsi0TxuH1J5m/qwXMYXLG8YxdlXwJSgll2vNrI+Z+/psj
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(136003)(346002)(376002)(39860400002)(451199021)(186006)(1800799003)(55016003)(4326008)(9686003)(316002)(86362001)(122000001)(478600001)(110136005)(54906003)(38100700002)(76116006)(71200400001)(66946007)(66556008)(66476007)(66446008)(64756008)(7696005)(33656002)(45080400002)(6506007)(41300700001)(26005)(52536014)(38070700005)(8676002)(8936002)(2906002)(83380400001)(5660300002)(44832011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4KwbJXxE/48QvNQGlJnwH/GsdWArxOlYu36QAxrHOeh6nOxvOlDRzo5b03Tr?=
 =?us-ascii?Q?UD3KKpzgFenG1pZSeMO52peSvlE7VuhdN0clL88AEey9rdEqZwrmQ5Jw+z9M?=
 =?us-ascii?Q?4eWjby3uWBEbgDuJkU+ctx0Whiad8Pbm92paw+t90kN5xI+4o7euxzL2rTi0?=
 =?us-ascii?Q?sdHzujdLZMVsKKDcGGeCurqM7udQeHtAczBPCenMjgdmmm9GnWcXko6PLGkH?=
 =?us-ascii?Q?y87hnLaw/eZl3EUih71T/OgVbJKqhwAYAp39Mt9BmQn2k4i5EIdryZcmTU8k?=
 =?us-ascii?Q?4gj9i5gvDBzMHLJpQIarVcU6d67EUIOEh05pUXCV74Tkr8L5EqEH+BR+lwaD?=
 =?us-ascii?Q?iV7T9Zp5Gz2hFs70fUykflAxeDOOWPEy3rZR/UcMvgxXgoah/Pk3r4S0D+oF?=
 =?us-ascii?Q?+BUmaImeyIZMczkiUDk+Zmcf6edTLQ/plV2X9WJmLdBGNh856Xu3fL3OgY44?=
 =?us-ascii?Q?E033boe3M+bu7wqKiPcpH1acozIOsqGIGraHw1vuitBPukTTBctUzlhwaO8z?=
 =?us-ascii?Q?aRThXvAOxCL/QygT5Fl4LcHp7FlO43e2IRkpPR9c8waud0XbulUKAYqAjdCm?=
 =?us-ascii?Q?7reqa/e+L8dK9Y1P7nX/FeTteyKDpEy4yIuP37o4U4eunYDRWjLKfzY6U4FN?=
 =?us-ascii?Q?RrkwmNEFY7hsfM67L2BIvY2fN22KG3GnCsUXUukM0Fs8KV/wKUHYBP0MNEsJ?=
 =?us-ascii?Q?g2u5wVJefG+IikJf8y8IpMiIhyZwGiQ/2qUQQ6K7qkspBK5dTZ0Hwd6grwbQ?=
 =?us-ascii?Q?EtzdB0ky8bKfAZtTJ4XNNUReFZ9V9qLouVC8tXoBvodKZDOOOnmCWGpPw9if?=
 =?us-ascii?Q?WP5Q8Va1KeAPA9kkAQWv6vtG6/NGKEnLsgXL1LH1z4duW0uCbg1yWdzccjNb?=
 =?us-ascii?Q?Vkh0rxlo9NamC/Sb66uBie203ghS/+m4VUqpQUwcqZygm481Wtk7Mm3njYT/?=
 =?us-ascii?Q?JN6idiDk6/yHnjE1O6Rnsr7DASC0N/EM7Rac2Lv5eb2kdNklCrbtaRQBkJGF?=
 =?us-ascii?Q?nmuJG3ZOed8pI8BzjJzXOd7ARS5k+asHMMK3gGqzH4A4QwTfslDg5JQsL50o?=
 =?us-ascii?Q?5SSiYT6J4T8eozcDlw/AnCDDqdG2jKCaBMleMMhgiRmgUKLnBuf3EBLxsaWn?=
 =?us-ascii?Q?hjFymQs+tyijzlJb46DQwTDGl+oUYY98mIKy0c5D+I1XVCbzT5+xwvN37Vgt?=
 =?us-ascii?Q?4k21CFcN8XAGqBxcHcMXfaDg/GjwHd6jCybzQcBNXWCLa7QksxY/D5ekSzg2?=
 =?us-ascii?Q?AOyM5q8SZOcwY0t1FlW84tWARBtW39+64Wtq62pK5BZ4fAF4eAAcoD/2ULWX?=
 =?us-ascii?Q?rA4RxDv7g7RubPD4HAcYv9M4e/YFNFJTdVnI7WFkAG873ze8/LCnrdDWcoVr?=
 =?us-ascii?Q?N3qHX6iV/a57AcdJaNf4BLSqs3rSbH15mAExWxUOQ+ZUttiIdXtjL0HUmBtc?=
 =?us-ascii?Q?YWI7ZgjZrJ+nbL4lNlRRlexdatE+QsLsEUn9cHf4sLvZeSiPmDZWFCzV/cX1?=
 =?us-ascii?Q?pY6FugJvqIIae44jsxadClFxnVMECLV6ykDHslNjUS0KyHB/Xk9EK5VoWd2e?=
 =?us-ascii?Q?XrhyUS+nCj6eaJ+enWk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be818c49-57f5-4b53-3e52-08db96f6510d
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2023 03:28:06.8617
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dck1Ds1arQgNNcICII/Eo6GoSUwFwpUowQSy4ugOI+kLh5i9cqPV+lGKnTxfD3dtYndK176Lsqm25pg12RicYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7014
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH V5 6/9] firmware: imx: scu-irq: fix RCU complains aft=
er
> M4 partition reset
>=20
> On Mon, Jul 31, 2023 at 05:04:46PM +0800, Peng Fan (OSS) wrote:
> > From: Robin Gong <yibin.gong@nxp.com>
> >
> > Use blocking_notifier_chain instead of atomic_notifier_chain,
> > otherwise below RCU complains would come out since
> > unregister/register_virtio_device
>=20
> s/complains/complaint, and in subject too.
>=20
> > () will issue mbox message (mbox_send_message() is blocking) again
> > after
>=20
> The () should be on the same line as register_virtio_device.
>=20
> > received M4 partition reset. Actually, no need atomic for notifier
> > which
>=20
> there is no need of atomic for ...?

I'll rephase the commit log in v6. There is no need to use atomic
notifier for scu irq notification.

Thanks,
Peng.

>=20
> Shawn
>=20
> > is so tough for user since this notifier is called in worker instead
> > of interrupt handler directly.
> >
> > [  389.706645] i2c-rpmsg virtio0.rpmsg-i2c-channel.-1.2: i2c rpmsg
> > driver is removed [  389.767362] Wait for remote ready timeout, use
> first_notify.
> > [  389.774084] ------------[ cut here ]------------ [  389.778729]
> > WARNING: CPU: 0 PID: 397 at kernel/rcu/tree_plugin.h:293
> > rcu_note_context_switch+0x34/0x338
> > [  389.788131] Modules linked in:
> > [  389.791195] CPU: 0 PID: 397 Comm: kworker/0:13 Not tainted
> > 5.4.0-rc5-02977-g08f78722f07b #26 [  389.799633] Hardware name:
> > Freescale i.MX8DXL Phantom MEK (DT) [  389.805481] Workqueue: events
> > imx_scu_irq_work_handler
> >
> > Signed-off-by: Robin Gong <yibin.gong@nxp.com>
> > Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  drivers/firmware/imx/imx-scu-irq.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/firmware/imx/imx-scu-irq.c
> > b/drivers/firmware/imx/imx-scu-irq.c
> > index d9dcc20945c6..4408f150b3d5 100644
> > --- a/drivers/firmware/imx/imx-scu-irq.c
> > +++ b/drivers/firmware/imx/imx-scu-irq.c
> > @@ -42,25 +42,25 @@ struct imx_sc_msg_irq_enable {
> >
> >  static struct imx_sc_ipc *imx_sc_irq_ipc_handle;  static struct
> > work_struct imx_sc_irq_work; -static
> > ATOMIC_NOTIFIER_HEAD(imx_scu_irq_notifier_chain);
> > +static BLOCKING_NOTIFIER_HEAD(imx_scu_irq_notifier_chain);
> >
> >  int imx_scu_irq_register_notifier(struct notifier_block *nb)  {
> > -	return atomic_notifier_chain_register(
> > +	return blocking_notifier_chain_register(
> >  		&imx_scu_irq_notifier_chain, nb);
> >  }
> >  EXPORT_SYMBOL(imx_scu_irq_register_notifier);
> >
> >  int imx_scu_irq_unregister_notifier(struct notifier_block *nb)  {
> > -	return atomic_notifier_chain_unregister(
> > +	return blocking_notifier_chain_unregister(
> >  		&imx_scu_irq_notifier_chain, nb);
> >  }
> >  EXPORT_SYMBOL(imx_scu_irq_unregister_notifier);
> >
> >  static int imx_scu_irq_notifier_call_chain(unsigned long status, u8
> > *group)  {
> > -	return atomic_notifier_call_chain(&imx_scu_irq_notifier_chain,
> > +	return blocking_notifier_call_chain(&imx_scu_irq_notifier_chain,
> >  		status, (void *)group);
> >  }
> >
> > --
> > 2.37.1
> >
