Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DFFD7B7757
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 07:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241321AbjJDFFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 01:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241312AbjJDFFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 01:05:24 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2138.outbound.protection.outlook.com [40.107.113.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2562FB0;
        Tue,  3 Oct 2023 22:05:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FLafoJhXAwSOtMc3rWA8EWxxiTdgH07yk20yoRqmL5pnHjbdt197bfUSBxdV05myWFAXmW9LC0aZ62FhZ3O0CbwEK5Y6U2qPc9TXAQKWawrQUuVQVaETDy5cfYlybUmdukQlsr71a4jQYB8a7h5+UqwUhIFDzryQMJ1d4kpYhniFe/Cpvd04U33M7gMkceQZdZyDaRCc1mYBimcSfVKq/Y6iHwmInEmsSKoImPVJdHTe/zHiuMRaX+odhyFMApTqiUehdkG/f/w0Ndx95Bz7sNra3yoFBBZklXqlnG1dsAZzhE83fMtCSUz3WgQ4qVvHwXEwBCxFb6Qvh47b0MS1Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=McUBy/tiBI6bnJ55miUy/9JT9FB9Ff0gLI7WUYG5vHg=;
 b=f0WEi9epuymQDGXq5WDskoBiutzV53EJX4ds75MMWbgk/GNcSb9wXgL92vRb8+44OzgK2x/sUOe+dI+Z/kPLSXPo26dOd816zfQeKqxmRSB0AmuHokTsXflC7j3QSyjZhRvRjsOKbczUTp0LnicF9KFcYlX+hGaNb22kdqA+horTpi0VT+KIN3CrCwfW1NSYjR/tyZ8WrXl1dNnQJMkz4DdJkzWFbHbM9JTE0VGj4bSUsAlJBbQI6luyU3jvOmFCLr4Nx/iwcjKiqXDTXfr6nAkcuvIctYPWMp/rhJnWuILImOQnKqR029brH9BgF7hXHVy0jwjSAbh7Hmo4bndNlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=McUBy/tiBI6bnJ55miUy/9JT9FB9Ff0gLI7WUYG5vHg=;
 b=PU0TidNXmovkp69WvYqpGH8YlstYytQt8b7hqi2QkQBmNZTkUAToLS7RVroJj47JehGngNJiqUaZeUizLe/i0S1SIG9aWvhygEh4PPC5HQpbS9RV3by8b8eLWPeTW4YwxRmroGa7TqUsRdTLJhtJPzhHZA4EvJ48uP4q8pJHUU0=
Received: from TYAPR01MB5339.jpnprd01.prod.outlook.com
 (2603:1096:404:8043::13) by TY3PR01MB10141.jpnprd01.prod.outlook.com
 (2603:1096:400:1da::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.35; Wed, 4 Oct
 2023 05:05:16 +0000
Received: from TYAPR01MB5339.jpnprd01.prod.outlook.com
 ([fe80::fe97:d12a:d11b:cdcc]) by TYAPR01MB5339.jpnprd01.prod.outlook.com
 ([fe80::fe97:d12a:d11b:cdcc%5]) with mapi id 15.20.6838.033; Wed, 4 Oct 2023
 05:05:16 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Sergey Shtylyov <s.shtylyov@omp.ru>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Zheng Wang <zyytlz.wz@163.com>
CC:     "lee@kernel.org" <lee@kernel.org>,
        "linyunsheng@huawei.com" <linyunsheng@huawei.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "richardcochran@gmail.com" <richardcochran@gmail.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "geert+renesas@glider.be" <geert+renesas@glider.be>,
        "magnus.damm@gmail.com" <magnus.damm@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        "wsa+renesas@sang-engineering.com" <wsa+renesas@sang-engineering.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hackerzheng666@gmail.com" <hackerzheng666@gmail.com>,
        "1395428693sheep@gmail.com" <1395428693sheep@gmail.com>,
        "alex000young@gmail.com" <alex000young@gmail.com>
Subject: RE: [PATCH v4] net: ravb: Fix possible UAF bug in ravb_remove
Thread-Topic: [PATCH v4] net: ravb: Fix possible UAF bug in ravb_remove
Thread-Index: AQHZvqRVuDoCAQ7YqEiPPoP/ALhCca/LYswAgAHmgICAAK9XgIBVS6xQgBWhAwCAAJ1FwA==
Date:   Wed, 4 Oct 2023 05:05:16 +0000
Message-ID: <TYAPR01MB53396D8FA06A45B0837F6413D8CBA@TYAPR01MB5339.jpnprd01.prod.outlook.com>
References: <20230725030026.1664873-1-zyytlz.wz@163.com>
 <20230725201952.2f23bb3b@kernel.org>
 <9cfa70cca3cb1dd20bb2cab70a213e5a4dd28f89.camel@redhat.com>
 <607f4fe4-5a59-39dd-71c2-0cf769b48187@omp.ru>
 <OSYPR01MB53341CFDBB49A3BA41A6752CD8F9A@OSYPR01MB5334.jpnprd01.prod.outlook.com>
 <872cf8d7-3bd6-b11a-82ac-a9f4c82d0a02@omp.ru>
In-Reply-To: <872cf8d7-3bd6-b11a-82ac-a9f4c82d0a02@omp.ru>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYAPR01MB5339:EE_|TY3PR01MB10141:EE_
x-ms-office365-filtering-correlation-id: 1467237d-b456-4ec4-ce7e-08dbc4977fc9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ttFCkzm77+4r+6Ljz6Rbe8PC60UgOXuLlZ1X+CEP2ql940qbIqrxKqAWuANZqMu6Offk/juZL9PXY9Z1UhiZhUyrCooCGbcWjOhvdCjJAVzN46AwHapeUX+STXSObrCclCYSq82MkgjQXSeWW/iN8b4WtT32WaD5bKMYZoYOjW5HfCyNlbU90g82ergrnOBBlRclvay2ZnAtKOFaUD8veodeOtEu/qwF7nsMxUrXz9KClcQkMuMMfOokKPQbPngPb+dB8qfn3tsSoP6kj6IjXTUQA6ytGSyGUd8Vgxu6+9SlfYzatZr6e9xcoQGW4ZHuOCyliCnJlaX7jfucgV1tcWmoUhnSn0TxEeXUi9rbLhmrESva5PtFWbsqwII44kBP/x0GADmCAcDyWanH5Ab7si7tUZDvY+vsVuYt7Rt5QpHBUmlg6FLrsFTg3xlpUiOwN1zX94EK+FXk3Isia+s/tr5M9tFKbMHNUEHxCqf1gNxO/LgJ0snZ+jLQ9PSpQrDAM0RfrQSHHxkHjek6w6eIt3i0vg9ADwSnUbcWT1q+A8HhzVZAqOyBibNID3Ua9cghx7Kb8ubps1ldgFjqwzb9xkZzKAsdVvTzt95OIc7s/vcISv40b4oH4LSDGaTZYZzF
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB5339.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(136003)(376002)(396003)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(55016003)(53546011)(7696005)(6506007)(71200400001)(478600001)(38070700005)(33656002)(86362001)(38100700002)(122000001)(2906002)(7416002)(83380400001)(9686003)(316002)(64756008)(54906003)(66946007)(76116006)(5660300002)(66556008)(41300700001)(110136005)(52536014)(66446008)(4326008)(8676002)(66476007)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6PM84/dwfzx7+IdhltGGtkr+Bau8rEgE6Vfw1It2tJiUCsgi9hNpp0MTzMsR?=
 =?us-ascii?Q?TwUlTwJz2nm8Mxessi0fDM4kG6hody7DqnvUEsj7Wr90CvkzKHyOM4lodEqZ?=
 =?us-ascii?Q?Zx2w+q6U1fSyrG9JRgvH4dLZ1Z8hrysEiF1qvs/9WBbyBVgDk/LVDtWYIxTR?=
 =?us-ascii?Q?O5C0+bxbI/vaDyyyV76MQb2OJOouiMyVCAoHMyh6TXryLdBk6LEHB1+7WavF?=
 =?us-ascii?Q?iRyY0sHyesKnXI2W4pI80BPS4YkE+Jo5ProTYm+oLNRGO684E1MNGCrChvfW?=
 =?us-ascii?Q?xl84Xo+mOorfBk9/GsY7cxi+kk8Nx/t8qyJ+R6LlBXlfbTUbYyfaQpGYFar0?=
 =?us-ascii?Q?HPQO+SdL+08kUivp8iatX0QKsV2pzVJFerfPZclGbv2q7KkJ1OShnS9L6PCk?=
 =?us-ascii?Q?LqJSuYx5NjW3/Z9BAdkkfMh528/3mJWvXHHCVVKyyX08QGklf6FZIEWFiHOq?=
 =?us-ascii?Q?jY0AmZ5hSf8VRwQzPBos9lxHfBDeANdVlis6q7MURSiED7uVaAzygfotiwd/?=
 =?us-ascii?Q?gBMGmrIBWOB96hZY2hD0mMNJEK1rJoQ98fv1JLnmmOWcwDTVF9ueeIS2bVNT?=
 =?us-ascii?Q?cQiHDNO5LEOOOrvmORof/jNk2z+K7qzAi7iasM1CGPf0aKuy7nWDdfAGYeow?=
 =?us-ascii?Q?uytvpHiBiV0fBJ/Js+rM8cWfdJqScROPclz4ITiblQHB0jszpvfV4G4xjf1p?=
 =?us-ascii?Q?n4rvgi8CwWGbFilEKBXrdXQ7wcC28oh4ZgZwTEjsmFJA9P8DGcAyrIP976Jd?=
 =?us-ascii?Q?6HTQ/LLn7fo0mroCSvRd4+jR1BHjaTD7GKFVrOrWVB9IQ3hxHCuIvrgemqPa?=
 =?us-ascii?Q?TV927AphHqyt/Yhd/5/wL3ca9BJ+s7Hlg+tfbOUrzTKwVj6gqtdtSTkCCYTA?=
 =?us-ascii?Q?7Dgq2iT0n+9DPzEJjaO8Gewaorg5hLGNqwhwpvLsngh8noO1DEO8tS+qdXO+?=
 =?us-ascii?Q?qrCqVp2FLiOv+mEuUASNhu9ZNpiwce1teu1ImXjW5oAqu2AsdDhRa5ICDzhD?=
 =?us-ascii?Q?sXElG9z7+uD5rrEz9vsMBT5Ex1gsqT9jh+OBjlJXVOrPDVkLubjntw7LAPXw?=
 =?us-ascii?Q?8PP58LvVlax+8tEQzD8XEBvlyUnDA+rQVz0177YVod59KM5Wb0D+M3/BEmdi?=
 =?us-ascii?Q?Q6/Ot3pHV3IxL7Dunkwu5ZQEyg+XNjG/hmSI86Gl0yKHnPOeqIvmshgnIsfX?=
 =?us-ascii?Q?MCq1JRPW08K4Vt0DxJrNOn0aztquPNWKAFDSUJe3ocaSmnpCYUBdi2UijC2F?=
 =?us-ascii?Q?7VdLRHTnabXFhD9bD6pz8fpVj9sWIKzBswfmtIeVG5ZZlT/cBdNGgdT8byRp?=
 =?us-ascii?Q?z7Wo8ZRIq0GO8x3OdC2DRDDNG2gFaSo8LfQUQL+/EqQnRZ3PUN9hpGvj/lba?=
 =?us-ascii?Q?Y9BjqcRNa9iMQOSnFjlOpcuLKOPAwaK7QWtB7Ajq5VWEn/At/nwe6Ppx/yi8?=
 =?us-ascii?Q?TYsN5OegBNNZW84PRCzDKmRinuD///YRWuDPvSesedHRp/MLN1MO09stgN8w?=
 =?us-ascii?Q?GotxKPHGIJlYvetQ2lhHAXD/9P/NVMLe4xxQdOrU/+vfIMPRwRUuYSXdAc4L?=
 =?us-ascii?Q?QiLfwmar8/KJtyJJ+n6yRtWaKSrJrnTDF2ttFLQXbl8257jM3iMUMMsa9OZR?=
 =?us-ascii?Q?QSlTPhcIeEwzzuvx+yBR+QE0K6Mbla1a+5JW5kV8s4oGwBwv+dUNuQXMrJbe?=
 =?us-ascii?Q?wgZ0Fw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB5339.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1467237d-b456-4ec4-ce7e-08dbc4977fc9
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2023 05:05:16.5813
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LR1XUugsABHBf4BIxi4kk96mng7M86jAjdBnMslgGs1qKQPbPYkbrUpxc8m24C/szLQhBsQPrMXlMtFqY6Wgm20wggyNWBBOFTMkHMUEVkT2P0/n5pcxqPqHfRRCHZky
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10141
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Sergey,

> From: Sergey Shtylyov, Sent: Wednesday, October 4, 2023 4:39 AM
>=20
> Hello!
>=20
>    Concerning the subject: I doubt that UAF acronym is known to
> everybody (e.g. it wasn't known to me), I think we should be able
> to afford spelling out use-after-free there...

I got it. I'll change the subject.

> On 9/20/23 5:37 AM, Yoshihiro Shimoda wrote:
> [...]
>=20
> >>>>> diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net=
/ethernet/renesas/ravb_main.c
> >>>>> index 4d6b3b7d6abb..ce2da5101e51 100644
> >>>>> --- a/drivers/net/ethernet/renesas/ravb_main.c
> >>>>> +++ b/drivers/net/ethernet/renesas/ravb_main.c
> >>>>> @@ -2885,6 +2885,9 @@ static int ravb_remove(struct platform_device=
 *pdev)
> >>>>>  	struct ravb_private *priv =3D netdev_priv(ndev);
> >>>>>  	const struct ravb_hw_info *info =3D priv->info;
> >>>>>
> >>>>> +	netif_carrier_off(ndev);
> >>>>> +	netif_tx_disable(ndev);
> >>>>> +	cancel_work_sync(&priv->work);
> >>>>
> >>>> Still racy, the carrier can come back up after canceling the work.
> >>>
> >>> I must admit I don't see how/when this driver sets the carrier on ?!?
> >>
> >>    The phylib code does it for this MAC driver, see the call tree of
> >> phy_link_change(), on e.g.
> >>
<snip URL>
> >>
> >>>> But whatever, this is a non-issue in the first place.
> >>>
> >>> Do you mean the UaF can't happen? I think that is real.
> >>
> >>    Looks possible to me, at least now... and anyway, shouldn't we clea=
n up
> >> after ourselves if we call schedule_work()?However my current impressi=
on is
> >> that cancel_work_sync() should be called from ravb_close(), after call=
ing
> >> phy_{stop|disconnect}()...
> >
> > I also think so.
> >
> > ravb_remove() calls unregister_netdev().
> >  -> unregister_netdev() calls rtnl_lock() and unregister_netdevice().
> >  --> unregiter_netdevice_queue()
> >  ---> unregiter_netdevice_many()
> >  ----> unregiter_netdevice_many_notify().
> >  -----> dev_close_many()
> >  ------> __dev_close_many()
> >  -------> ops->ndo_stop()
> >
> > ravb_close() calls phy_stop()
> >  -> phy_state_machine() with PHY_HALTED
> >  --> phy_link_down()
> >  ---> phy_link_change()
> >  ----> netif_carrier_off()
>=20
>    Thanks for sharing the call chain, I've followed it once again... :-)

Thank you :)

> > The patch will be the following:
> > ---
> >  drivers/net/ethernet/renesas/ravb_main.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/eth=
ernet/renesas/ravb_main.c
> > index 7df9f9f8e134..e452d90de7c2 100644
> > --- a/drivers/net/ethernet/renesas/ravb_main.c
> > +++ b/drivers/net/ethernet/renesas/ravb_main.c
> > @@ -2167,6 +2167,8 @@ static int ravb_close(struct net_device *ndev)
> >  			of_phy_deregister_fixed_link(np);
> >  	}
> >
> > +	cancel_work_sync(&priv->work);
> > +
> >  	if (info->multi_irqs) {
> >  		free_irq(priv->tx_irqs[RAVB_NC], ndev);
> >  		free_irq(priv->rx_irqs[RAVB_NC], ndev);
> > ---
> >
> > If this patch is acceptable, I'll submit it. But, what do you think?
>=20
>    I think it should do the job.

Thank you for your comment! I'll make such a patch.

>  And I suspect you can even test it... :-)

IIUC, causing tx timeout is difficult. But, I guess
we can add a fault injection code somehow.

Best regards,
Yoshihiro Shimoda

> > Best regards,
> > Yoshihiro Shimoda
>=20
> [...]
>=20
> MBR, Sergey
