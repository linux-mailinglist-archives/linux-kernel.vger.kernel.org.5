Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E36C37C804C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 10:32:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbjJMIcO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 04:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjJMIcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 04:32:12 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2099.outbound.protection.outlook.com [40.107.113.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DB1591;
        Fri, 13 Oct 2023 01:32:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OZNwQ5LwvRdKkxLmrtEgafUnyZxO43oIkDbYW2qUmyzcGxHcizxUH5xJup1vp5JLLayPRXii5slgrgFdQXA1Y71M3M8vFU1TIbeSPwIp8B9spXTv9ZAZMyAGlF7iuGSGOJ2yWpwHOcdJ3q2t/ebS9mjivPxrnsZvLCs2yq7ipkNopRqyEZreUisqTZTBYF6xM0VLMyefGssYUTlMCkp0g4dEVAj3KfaIYrdzbPosFFrphlGOV5HzGWaoATRwMD6aEjrQ04TzhbLa/iptp8a2GcLuR4QdyNSeb5cmWP9Cy1zr8jyvbZkijUaGlgvMaK8PfRd+58fL18GpFq9rBHHxsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=poHNXt4aWZrQUp1tIv/Mr+mAGkHzXihHdYm+APSwsQM=;
 b=lz/P4NDkCT7fPiHr0PXcIP9YLWAKPFYli8NUpYB318cjbvSaigqETco4r4I5uBmYRhMzYSAyxEpNQtYs1XC9lqWrk3gKnS4pgWax+T6Y0g/qWDD637siLbydNdI3XQ6qCbHHwsc05hMwyV8KuidO0xQ/kJJAAhGzO0ZjVBJbTHfl9erNYxN7ki3YSwB5meYDdUVFBNn7/RjjHZ3ojTNMn2Pwa6rqvOqehlNpUM/4VlYCX0B7scEL2JQgj8j3ACeY8ywA/vE81N8OBAOUytPEUFeaFNZeB2zgoFa6QV7lv4/hNKdKnGDMWYotgcGQz1XGgbar4vjXMbb7B51VZHSd0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=poHNXt4aWZrQUp1tIv/Mr+mAGkHzXihHdYm+APSwsQM=;
 b=I0Yw2RbbU2p2EI1QVvOjWt8++cqeiYpyOg+gYUeaC0DqIlPlZdkhe0kSExuzDrEeSLFWoIdxldi4npZbB2fJDWSwTTFjmRxJhdOCV/gTx8X8rgs84UHodC0rvK5WgwrwKdS+wfLqoQ1t2L7C8O+NFmFKPvDyGYd3CPI7Gu6uC/Q=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by TYAPR01MB5771.jpnprd01.prod.outlook.com
 (2603:1096:404:8052::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.46; Fri, 13 Oct
 2023 08:32:06 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::1dc4:e923:9916:c0f7]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::1dc4:e923:9916:c0f7%7]) with mapi id 15.20.6863.046; Fri, 13 Oct 2023
 08:32:06 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     "REE dirk.behme@de.bosch.com" <dirk.behme@de.bosch.com>
CC:     "s.shtylyov@omp.ru" <s.shtylyov@omp.ru>,
        "lee@kernel.org" <lee@kernel.org>,
        "linyunsheng@huawei.com" <linyunsheng@huawei.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
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
        "alex000young@gmail.com" <alex000young@gmail.com>,
        Zheng Wang <zyytlz.wz@163.com>,
        Jakub Kicinski <kuba@kernel.org>
Subject: RE: [PATCH v4] net: ravb: Fix possible UAF bug in ravb_remove
Thread-Topic: [PATCH v4] net: ravb: Fix possible UAF bug in ravb_remove
Thread-Index: AQHZvqRVuDoCAQ7YqEiPPoP/ALhCca/LYswAgHgTDgCAAtT3EIABbjqAgAAnWRA=
Date:   Fri, 13 Oct 2023 08:32:05 +0000
Message-ID: <TYBPR01MB53412D9F5E429A98749ECAE4D8D2A@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20230725030026.1664873-1-zyytlz.wz@163.com>
 <20230725201952.2f23bb3b@kernel.org>
 <de4ab49b-f1a7-5732-0970-13fd03407376@de.bosch.com>
 <TYBPR01MB5341D3791E728E3D9EFC25D4D8D3A@TYBPR01MB5341.jpnprd01.prod.outlook.com>
 <93811ef2-8df9-de21-3f8d-296400ec2ba5@de.bosch.com>
In-Reply-To: <93811ef2-8df9-de21-3f8d-296400ec2ba5@de.bosch.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|TYAPR01MB5771:EE_
x-ms-office365-filtering-correlation-id: cce735f6-33fa-43a6-63af-08dbcbc6e21b
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dUUdeNzca47u70IY4mf9KAM5Vh88jZbw+omR1YOd0rL47ExEbwLKVi0YVguo6zv4dVlOzFufH/3givElIdiCkvfXNGFFlc2RUNZx7gUtDrnubY8yglToM6UaFSD9Vz7R5K5lvhBqzqHSO3nTJ70/FPg7SWt8elTK4EZXIUF//E7eh8HhqsG7KokPqNjQwC4IbeDOJSbvKb6TXPBjFKHMxH8QatGAvNPl6+yyeBorOfpOtmE4Qu/wOu5xuLawX4ZneNcdgnFf76Pg5aRW9JRRaY5VvvIxC8j4SSkRNHBYmFXDDahyjwtwQv6yPPsQ0/0PWc682UKom+254r4noTCVCpPte9JvtCeq8vcZLmgJZ2XMLUQ+QACVh3Ki3/WWZjWtORRLwBC69Xp+mKIP3XP2CHJTT/5dnKzcYHQnkk4228X2Tvay1bxFszjHJAWJJtj5fhaH3XuxR+h8ljTrWSSbZMCO2Vtjr/P/4nADUepMII1g93sXBdvv59liARXkocsdjlMZBnKg/hIma48RAGd7Kc0pjB39AoGXhffvGk58oYrmIqN7aqY0jgdIriTwswoIto4pI4alL4yTkvY1TRWFayBAijuFZI/Fbm/3bU42PT3+bTfFlF/SP1ZSvtrHPex6W3WoR7J/rLavvwJGY9Ps3A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(396003)(346002)(136003)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(55016003)(52536014)(66446008)(66946007)(64756008)(54906003)(76116006)(66556008)(316002)(5660300002)(66476007)(2906002)(33656002)(8936002)(6862004)(4326008)(8676002)(41300700001)(83380400001)(7416002)(66574015)(38100700002)(38070700005)(478600001)(122000001)(53546011)(966005)(71200400001)(86362001)(7696005)(6506007)(9686003)(45080400002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?qtWdewC+8v70Vc+ReAEn1KDocZD93W7PBhV1fO7tYj80yfTedEbKtqhnYs?=
 =?iso-8859-1?Q?44r8s6M82Hdhoe+ktFPhDJ7aEMtRVBLdkGyUziiTgBR5kYSdudhV9yIyp4?=
 =?iso-8859-1?Q?5aWTCnpcBdSGdFNvUbu8NHop10SYpNw7oZSJbeTGwBJCIoITEeRMFkw9C9?=
 =?iso-8859-1?Q?UW5a1bTWIclf19NSW8nOyoM4lD5E/5tv8HXIHjwJRw5Wf2FYVk7DQD51/J?=
 =?iso-8859-1?Q?m3Vza+crzsRZq7nGA2p6tmQSlmii17UdGjrA2C9jAo/r6FYmN+5SfY5j9p?=
 =?iso-8859-1?Q?l7ZKVprwgr3W0t8h1n0bTH6SrkkzxKQN1uCGUs2XbuNCFHLC8MCTjEBhWe?=
 =?iso-8859-1?Q?FQZQbcvEOLewfFo5z3GO6t8NsOsBMHPBhOAtnOtANE4pzT5VSr1jwvUaFT?=
 =?iso-8859-1?Q?bP7jwrNyNuhknUbB4mGrKtK6LNGiWgRapI01NMQjwoZvoRr99HdArP0IBm?=
 =?iso-8859-1?Q?CLvWk4qG7hDT+2Lr1zvFd3VW9HhQgt2Bd+fHiwnPfztGLSJ0nRgMmB9F4o?=
 =?iso-8859-1?Q?lILG48l4gpcOUwWb6wetanQVW5maeMeALVX7fF3vC9LyDG17n2rHUssuET?=
 =?iso-8859-1?Q?T4edNDZhc7HF8DeWFPRbxVlwTyeU6eaPRc0Und0l1BjOMMKK7Duk+8Pa8X?=
 =?iso-8859-1?Q?D/StDQqzgQR9ex7Cie+wLdR408zALiu/OZBpANNYFgfLNs/3eDb+9+UzfI?=
 =?iso-8859-1?Q?WvdvPtZiP6mvBsCewgvyrVyG9cJA/69XwUuo9BTsuFKA/NzH1YyOZWFKru?=
 =?iso-8859-1?Q?8EABjJ82dY2bTzgn3cHtsyegvlabGPZdqSnh+Uoxz6N+laQywgrv2ZxB59?=
 =?iso-8859-1?Q?lc4Dw557V9aWzLG4EiMgv1VbzzQMCPXGxcXufwwnFZ+VV76acYUJ/H8sLU?=
 =?iso-8859-1?Q?hZdj2Do3Xc/zbQB1s5py1W8PgGnxYmlSlPCYZNh+L/gKug9lp4Omn6HE0n?=
 =?iso-8859-1?Q?E/tuiUR4A/A04Y8/nMSd4shoKd6X9cXVWDLLHNHHn3PZ0eQnt3HxCPOLDm?=
 =?iso-8859-1?Q?j6tGMJTQBMYNNDLLq7RkbpLyYylGxwPEmlZsDsSrLvkrzb7UhHXmJsq9kx?=
 =?iso-8859-1?Q?54mCPmLHv3ntD+pkmM50k9uNNYh7Mf+A3gRFsyPXZ+9CZe60S77nZ4UCgy?=
 =?iso-8859-1?Q?QjRBsyF8Azj+wupl1CGuyeFSkbK6iWY8ZOPWw+BggRklrO0c3zStHYCBxf?=
 =?iso-8859-1?Q?JNjOYEuzQLCLCGy9svfzy6r8mS5aJwP0ah1xNjBbGNfwBlggd5CYUTvdiG?=
 =?iso-8859-1?Q?mutXtDW9tYtYfB5+e1Rh7o8iFfKMqqprIwo98dRj41V7PPLbfzz4ozyim8?=
 =?iso-8859-1?Q?BKWc2KWPKy+PnA8FVbHoTVOVw7gf891QeTl7MFMEi6miI64a0twbGQ00G9?=
 =?iso-8859-1?Q?AmjRZtlX2YA4cxlPLufl5wFtVufpRMa3rkRZ2ydJenW4iH17P2mPDhAu1D?=
 =?iso-8859-1?Q?UcwQSLJ68h3If6crF34yOz5gVxfCix41VvmVZY9M+Hw/NSxzwHzLtVUQvb?=
 =?iso-8859-1?Q?pggVMx4B/3wJS1AxFJh4nlHsPkwpuJyuSleqttYY+4yMlX5RgLyjRytUrj?=
 =?iso-8859-1?Q?w+tAru7GDEOIlwX8wHd8PRf872JhLo0ot0r0K6aFASS01UddcOfACFIQUl?=
 =?iso-8859-1?Q?Lq6l9OYMxianJX1rq22umc5IOFQD1pWbAMcQARgl1o/H9Lcby0TVhYsHnF?=
 =?iso-8859-1?Q?Mxpuy8u9mIOIUB8cg61TQEdYS+EBO3egsl+144wNKpC4ImwhHbFLg4i1M8?=
 =?iso-8859-1?Q?akeg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cce735f6-33fa-43a6-63af-08dbcbc6e21b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2023 08:32:06.0072
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DezpbIfyYUwWm4n3bp2CRhgPQxI7xk4DwQ3NiEqytq7VUvZoy2jX2cBB5yf/G45GvYIVYArbT9Rd9xP3eteNRgd8kWixtS/xKOATi50R5/ZRE9xa0jFUTbL9cIj1sbmH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5771
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> From: Behme Dirk (CM/ESO2), Sent: Friday, October 13, 2023 3:05 PM
>
> Hi,
>
> On 12.10.2023 10:39, Yoshihiro Shimoda wrote:
> > Hello Behme,
> >
> >> From: Behme Dirk (CM/ESO2), Sent: Tuesday, October 10, 2023 9:59 PM
> >>
> >> On 26.07.2023 05:19, Jakub Kicinski wrote:
> >> ...
> >>> The fact that ravb_tx_timeout_work doesn't take any locks seems much
> >>> more suspicious.
> >> Does anybody plan to look into this, too?
> >
> > I believe my fixed patch [1] resolved this issue too.
>
>
> I'm not an expert of this driver nor the network stack, so sorry if I'm
> totally wrong here ;) But somehow this answer confuses me. Let me explain=
:
>
> What you did with [1] is to stop/cancel the workqueue in ravb_close().
> That's fine. But that is at driver's close time.
>
> What's about driver's normal runtime? What I understood is that
> ravb_tx_timeout_work() might run totally asynchronously to the rest of
> the driver. And therefore needs locking/protection/synchronization if it
> uses resources of the driver which are used elsewhere in the driver, too.
>
> I think this is exactly what is described with:
>
> > ---
> > Simplest fix I can think of is to take a reference on the netdev before
> > scheduling the work, and then check if it's still registered in the wor=
k
> > itself. Wrap the timeout work in rtnl_lock() to avoid any races there.
> > ---
>
> So, where is above done? Not at close time, but at normal run time of
> the driver?

Thank you very much for your detailed explanation. I understood it.
ravb_tx_timeout_work() still has races between ethtool ops for instance.
So, I'll make a patch for it by early next week. However, IIUC, using
rtnl_lock() in ravb_tx_timeout_work() is possible to cause deadlock from
cancel_work_sync() in ravb_close(). So, I'll use rtnl_trylock() instead.

Best regards,
Yoshihiro Shimoda

> Best regards
>
> Dirk
>
> > Sergey suggested to add cancel_work_sync() into the ravb_close () [3].
> > And I investigated calltrace, and then the ravb_close() is under rtnl_l=
ock() [4]
> > like below:
> > -----------------------------------------------------------------------
> > ravb_remove() calls unregister_netdev().
> >   -> unregister_netdev() calls rtnl_lock() and unregister_netdevice().
> >   --> unregiter_netdevice_queue()
> >   ---> unregiter_netdevice_many()
> >   ----> unregiter_netdevice_many_notify().
> >   -----> dev_close_many()
> >   ------> __dev_close_many()
> >   -------> ops->ndo_stop()
> >
> > ravb_close() calls phy_stop()
> >   -> phy_state_machine() with PHY_HALTED
> >   --> phy_link_down()
> >   ---> phy_link_change()
> >   ----> netif_carrier_off()
> > -----------------------------------------------------------------------
> >
> > So, during cancel_work_sync() is waiting for canceling the workqueue in=
 ravb_close(),
> > it's under rtnl_lock() so that no additional locks are needed in ravb_t=
x_timeout_work().
> >
> > [1]
> https://git.kernel.org/pub/scm/linux/kernel/git%25
> 2Fnetdev%2Fnet.git%2Fcommit%2F%3Fid%3D3971442870713de527684398416970cf025=
b4f89&data=3D05%7C01%7Cyoshihiro.shimoda.uh%4
> 0renesas.com%7C466e046b20b548b264f808dbcbb255f6%7C53d82571da1947e49cb4625=
a166a4a2a%7C0%7C0%7C638327739033548199%7CUn
> known%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiL=
CJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3DHkA8f5a
> gawjXMvAGkaE6tELaSpjpbIn7M3mU5xbDTD0%3D&reserved=3D0
> > [2]
> https://lore.kernel.org/netdev/20230727164820.48c9e685
> %40kernel.org%2F&data=3D05%7C01%7Cyoshihiro.shimoda.uh%40renesas.com%7C46=
6e046b20b548b264f808dbcbb255f6%7C53d82571da19
> 47e49cb4625a166a4a2a%7C0%7C0%7C638327739033548199%7CUnknown%7CTWFpbGZsb3d=
8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTi
> I6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3DcGvnA8WqxM%2FUDa%2FNS2OB=
ztr1IWgjCX4IzBYXe1LGkZU%3D&reserved=3D0
> > [3]
> https://lore.kernel.org/netdev/607f4fe4-5a59-39dd-71c2
> -0cf769b48187%40omp.ru%2F&data=3D05%7C01%7Cyoshihiro.shimoda.uh%40renesas=
.com%7C466e046b20b548b264f808dbcbb255f6%7C53d
> 82571da1947e49cb4625a166a4a2a%7C0%7C0%7C638327739033548199%7CUnknown%7CTW=
FpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luM
> zIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3DOWwBKy%2Fdckgo3=
clPPfn2hxE4H6ToyqdcbhPhGoqoo30%3D&reserved=3D0
> > [4]
> https://lore.kernel.org/netdev/OSYPR01MB53341CFDBB49A3
> BA41A6752CD8F9A%40OSYPR01MB5334.jpnprd01.prod.outlook.com%2F&data=3D05%7C=
01%7Cyoshihiro.shimoda.uh%40renesas.com%7C466
> e046b20b548b264f808dbcbb255f6%7C53d82571da1947e49cb4625a166a4a2a%7C0%7C0%=
7C638327739033548199%7CUnknown%7CTWFpbGZsb3
> d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C30=
00%7C%7C%7C&sdata=3DJfypf10jiUfTqWUAukjnPzIQp
> urx7m0ETF5N2Toq8wE%3D&reserved=3D0
> >
> > Best regards,
> > Yoshihiro Shimoda
> >
> >> Best regards
> >>
> >> Dirk
>
> --
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Dirk Behme                      Robert Bosch Car Multimedia GmbH
>                                  CM/ESO2
> Phone: +49 5121 49-3274         Dirk Behme
> Fax:   +49 711 811 5053274      PO Box 77 77 77
> mailto:dirk.behme@de.bosch.com  D-31132 Hildesheim - Germany
>
> Bosch Group, Car Multimedia (CM)
>               Engineering SW Operating Systems 2 (ESO2)
>
> Robert Bosch Car Multimedia GmbH - Ein Unternehmen der Bosch Gruppe
> Sitz: Hildesheim
> Registergericht: Amtsgericht Hildesheim HRB 201334
> Aufsichtsratsvorsitzender: Dr. Dirk Hoheisel
> Gesch=E4ftsf=FChrung: Dr. Steffen Berns;
>                    Dr. Sven Ost, J=F6rg Pollak, Dr. Walter Schirm
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

