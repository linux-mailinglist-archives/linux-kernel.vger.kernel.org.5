Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 588F67F9C15
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 09:49:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232724AbjK0It3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 03:49:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232596AbjK0It1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 03:49:27 -0500
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2085.outbound.protection.outlook.com [40.107.241.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1893710A;
        Mon, 27 Nov 2023 00:49:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dBEtVtusz2Fs+H7uBy0TWwLeJ0VjxCbdpTDsZwfAb3ISFp4+wBdDx1VQMPYwZjtfQl3u5F6mbr1fXKwQGLRBkk2/Ci5v2glsx1yNx87KL9qbz1sVqApsInshAMxtauM2gZVIkr1YhNcMUkbM4hK4S1XnYuxclSgFw7YY4fQACbebRRoQA9Ikk4RIdpgBHviVbe4QBjIsgnWAhcdN15PfzLZFIEFN7vXueOkSRQCyj/Jk4QEV0pNbUZ7f8AsTNrSrkcLz3ORFgByKCO5XZUHJ1SAIG/b+w0cXaaCizd3xsfh8hgG8cfaOoyDOnQeSiMrTx4L4GvW0T5l8j1XqLShN2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8hmEdzYFTTRAQYjjG9DBs7Z3Axqj3wI/TBCDUmCGuTg=;
 b=fAB/fiXhPWHctdjCOKHig3VRB7YYu8pZj4g+LOR/Zn/m3DpFeHOMZynoSNcUdQPQ4CWgULEDgioF+xfKPF2SMtLKEgLz44VRiJ4ymWHdEGc2i9xE/k/qMvbmGXtYTXpynBN0okWFkVAoDaMrL8344UiI9U/V5xfhzJjw0ZPv68lg3NzeF7KpvJA5klrARK/Hd32bopsnA1twGqKjM2sysq6Tx4lYW0NVNvcq+DI7FkVYIwFVt/BnnPsinEwLiR3FYUNgbj+A5a9i6xfSiO57IqG3K9MTJXxCKPIMLTmN1KyIFJ7mfON6xJtSiJicmEmyXnuT3LbRcyQPQ6mHSBVVhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8hmEdzYFTTRAQYjjG9DBs7Z3Axqj3wI/TBCDUmCGuTg=;
 b=PEpaYrZXqFxkgohZkJoZc6IL8Gl2frZL7lUyHjscokJTdcZtwstm6nDQI5XpAU1j9oTp4OpbnAiiZvWvO8wP1FcticrbsrUgf9GiDlwxnUQHXk3ZSAT/b6ixPVSB54UmY2c5XPEY8y/zmp8SQ+UVCCM9gNUOVwXQCx0DnBlDIuo=
Received: from AM0PR04MB6739.eurprd04.prod.outlook.com (2603:10a6:208:173::27)
 by GVXPR04MB9734.eurprd04.prod.outlook.com (2603:10a6:150:112::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.19; Mon, 27 Nov
 2023 08:49:28 +0000
Received: from AM0PR04MB6739.eurprd04.prod.outlook.com
 ([fe80::8ce6:e6d7:974e:41cc]) by AM0PR04MB6739.eurprd04.prod.outlook.com
 ([fe80::8ce6:e6d7:974e:41cc%4]) with mapi id 15.20.7046.015; Mon, 27 Nov 2023
 08:49:28 +0000
From:   Neeraj sanjay kale <neeraj.sanjaykale@nxp.com>
To:     Francesco Dolcini <francesco@dolcini.it>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Amitkumar Karwar <amitkumar.karwar@nxp.com>
CC:     Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: Re: WARNING around serdev/bt/btnxpuart with 6.7-rc2
Thread-Topic: WARNING around serdev/bt/btnxpuart with 6.7-rc2
Thread-Index: AQHaIQ6hmEF8SHAVok2SVfXrutuMLg==
Date:   Mon, 27 Nov 2023 08:49:28 +0000
Message-ID: <AM0PR04MB6739181E152A4C2F47EC1838E7BDA@AM0PR04MB6739.eurprd04.prod.outlook.com>
References: <ZWEIhcUXfutb5SY6@francesco-nb.int.toradex.com>
 <ZWI4gMCoY_YzcH7f@livingston.pivistrello.it>
In-Reply-To: <ZWI4gMCoY_YzcH7f@livingston.pivistrello.it>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR04MB6739:EE_|GVXPR04MB9734:EE_
x-ms-office365-filtering-correlation-id: 881ceedb-99a2-4d49-7b5b-08dbef25c417
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Am9/PI6QvanRnt8P0/tCjimdmdOjq8mEMjRCDCef8pqorxYrgAfPcvhSHTi9E49XhgsSsDMS7eZn4LnMktWxNb/I3NqOCOS/qnseA0uTCEVCvixPkfWZU0ObzVHSbiKaCUsLsjp+1YRq5YsLC9JdDzcqkopQGc0joGzZKcTdBtVoymv8Bu9+Yi8xwmHlefuwl7v+wGJBfKh6V9HeaShmw6YUu+Sh7T6fsYJGIOSsVMEU3fk/17+yGl3Bz3e3gX47D0v6MChssThy2iNw4UFBIH2x884v8KIjVMsicK3k9YXMIGzyoHAsDrp7Smm1q1g4xxTxtMacPQYNRh5QWKLbyD+pGQr9s8YaEZUJ2OJXnPgmSLqRB1ybY/cJEDGM25etVFotKxsFpEYri3dcUY7lR6Vtk7NbWslRpHAdW03rjNF6ckAvCjlQ62eElPDRPGxLkAINFF5tAEYBHDEhzBHnMQlrp6jF4BxQBy4FjrNY2nSu7grBEy9adSqEuDIAuv6FIu+J2t2mY+CEIss4PHKNvWW/CwUYlOnwcWr9xEHCNtVo8iPriHKyCAK+CaO80sLpKDikOra4WORxSduadi9lFLZPs/QekVmAn/26eZQYoe/qLFlqMdCYHU8/KLlOqCMTUZomC/pAJnhXTDonJMCUvno8eu1UVs9AJqnX02XK+rA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6739.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(396003)(39860400002)(136003)(346002)(230173577357003)(230922051799003)(230273577357003)(451199024)(64100799003)(186009)(1800799012)(38100700002)(122000001)(478600001)(45080400002)(33656002)(41300700001)(8936002)(8676002)(4326008)(7696005)(6506007)(66946007)(64756008)(54906003)(6636002)(86362001)(316002)(66446008)(66476007)(66556008)(110136005)(76116006)(26005)(83380400001)(71200400001)(9686003)(38070700009)(52536014)(55016003)(2906002)(5660300002)(7416002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GcNCKQzOPP3qcLujhZGZLNdpIaqHTrVbstDbC0dmExTNFxVPFkNPVBLENv/g?=
 =?us-ascii?Q?O1nTwKoosomtU/oNaTE9Pku58gSYmhCH0lPNvTQ/RNGs3ruNT3IwkI3UMY4C?=
 =?us-ascii?Q?g7axghQOKHfz4m1wEQXd1vwX2rCX3ejre+JhV094jY/GBayoVuS0tehK3xOJ?=
 =?us-ascii?Q?1Z6lBhAn+DI91KQP2ulA6dK+5E0hTeI+L4ZXDfb0WjJ8QtpPIWAesozC7Y8J?=
 =?us-ascii?Q?XMdu7NMzIprB2XR3diKubDEqrInK8RuNlTemd7vS7NFFtHexdll8z25kTJts?=
 =?us-ascii?Q?iNtennEdd3Nw5IR9uOepmNWMeiTHSclYt2yYNxk1Fm9Nd/dssHfUgmRg0Oaa?=
 =?us-ascii?Q?7w9WIOkCxfoEwWNFbJbq5wWzyH1g8ZwwxAVKHXFqbBNrTdIzC4mXAoQQ8GGP?=
 =?us-ascii?Q?jFzdZKdIXZhquTH6i7hznHCwyW40G1NWLt8jGYMQoEe2ZJF6C7d3hKnF9ip5?=
 =?us-ascii?Q?k5avQ+OtPxLH4nLYMqqo1dzeaNy7mN+uaIneveozECJ/J+ktFqv2Y1IOCLc0?=
 =?us-ascii?Q?JW0NZkk3TvemKCzj8oV8jRgOLg/ahF6NxdNAnJ+eOkJ6Fo1XR52AOVjEozdF?=
 =?us-ascii?Q?zQyYtbLXydyDdNCafU8/v9+kDnah0Ub05I9AyHnGCnxxvWpxnVhl+UatEwWz?=
 =?us-ascii?Q?E32xryG9bOJYDnABMyNH/neLsiXVmtAbC43iVTWSNTqhIVTzznFQ/3wBW3en?=
 =?us-ascii?Q?dM1VFX7495wL/X/OPi+zLsq+hE//eIa2oJtPsmCj8uqingAKwlFKxpSaZNXj?=
 =?us-ascii?Q?RDXc3PxxcrMsZS9CZLyOrV1/P4TjkSlYL2cGmgV63NDQg46ZoogANgVsrhWI?=
 =?us-ascii?Q?TNGIySjHhDtJXABTjSPY+Yy5R0jC7c3PyKxvdL6igMdBPbl7WV00urGNDOkb?=
 =?us-ascii?Q?9zxO8Xm4Y09n+kCziGuDEYYOtB8GSaoYT3cDJPeW+YNofK9pfc1fhU8uOQLB?=
 =?us-ascii?Q?g24zV8LDyHFuRaBaP0OJbJ87DGSTkUbDX59eqTwcDMM6Y8gdWk0EFKPn2JJV?=
 =?us-ascii?Q?Fc3H2xuPSuVLgV8YWquwWZEGOxOq96WFJIKRXuzN8jGzSTi1u8Q0w3se1tC3?=
 =?us-ascii?Q?H2dfSgzXmnrzWEjxoYw1xOyykB7XknQa3fDNTOx2xhIsRShyO5QBFwbqXUeH?=
 =?us-ascii?Q?0d4iaU9Z3oPszC0sByFCtLYCm3JxHfWdbqzJ4e2TJ5otFXYzmsDPgdPO5wMa?=
 =?us-ascii?Q?ywo8MC0kgckXisknr2ZXXQS1lUr4dlOghlg5S48Ei7a0TnAvEN9judkzgG3p?=
 =?us-ascii?Q?ffoq5I4fnak3mYnBhPsr8PfiMD6/VQWTAkk7dL1kNQOahn7bm9YMiHPxEpfW?=
 =?us-ascii?Q?gvyk1P/3UovwcGgZi98mP5sYEZcCcKUbc8QGWJJazr1AbXKpLYNMDqFCxwFh?=
 =?us-ascii?Q?tSRGzpwKNVt3OPtc5bciwnHw9q+peLDTVw3bAyfBEHC51gW5NMCNTFRUCOGS?=
 =?us-ascii?Q?ZPVXK4QLeExntpK/TckaR8GzgpmRihZTFT53xpyevWsWFZZvkxTtsdAEnEDP?=
 =?us-ascii?Q?ttE5QGZQKQiqLYUAIQtVWrxvshD9pvh3qQCzua0lT3PKmS1CMYxZlM6eyDWr?=
 =?us-ascii?Q?4jp+18o1QWRcEodwnESDBPlQ+sPjTXREqNx/yfl8?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6739.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 881ceedb-99a2-4d49-7b5b-08dbef25c417
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2023 08:49:28.5505
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wJe1XppBjRVAJgOinCliyD7qyM5f8piBT1gV4yXqMs5vgXWfjPdlIhdflDSLgQpIF9Cpxt/xV8t/cNC16LfzR31L9dsXDjNIIsywok6Ca1A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9734
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Francesco,

> On Fri, Nov 24, 2023 at 09:33:09PM +0100, Francesco Dolcini wrote:
> > Hello all,
> > while doing some test with current [1] Linux mainline I randomly hit a
> > warning. It is not systematic and I cannot really tell when it was
> > introduced, posting here to collect some ideas.
> >
> > Amitkumar, Neeraj: to me the issue is around the bluetooth/btnxpuart
> > driver, however I could also be plain wrong.
> >
> > The issue was reproduced on a Toradex Verdin AM62 [2] that is based on
> > a TI
> > AM625 SOC (arm64) running with a arm64 defconfig and built with GCC 9
> [3].
> >
> > [    9.599027] Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
> > [    9.962266] Bluetooth: hci0: Frame reassembly failed (-84)
> > [    9.972939] ------------[ cut here ]------------
> > [    9.977922] serial serial0: receive_buf returns -84 (count =3D 6)
> > [    9.994857] WARNING: CPU: 0 PID: 37 at drivers/tty/serdev/serdev-
> ttyport.c:37 ttyport_receive_buf+0xd8/0xf8
> > [   10.004840] Modules linked in: mwifiex_sdio(+) mwifiex
> snd_soc_simple_card crct10dif_ce cfg80211 snd_soc_simple_card_utils
> k3_j72xx_bandgap rti_wdt rtc_ti_k3 btnxpuart bluetooth sa2ul ecdh_generic
> ecc sha256_generic tidss rfkill libsha256 drm_dma_helper
> snd_soc_davinci_mcasp authenc omap_mailbox snd_soc_ti_udma
> snd_soc_ti_edma snd_soc_ti_sdma atmel_mxt_ts ina2xx snd_soc_nau8822
> ti_sn65dsi83 tc358768 ti_ads1015 tps65219_pwrbutton at24 m_can_platform
> industrialio_triggered_buffer drm_kms_helper m_can kfifo_buf rtc_ds1307
> lm75 pwm_tiehrpwm can_dev spi_omap2_mcspi panel_lvds pwm_bl
> libcomposite fuse drm backlight ipv6
> > [   10.059984] CPU: 0 PID: 37 Comm: kworker/u4:2 Not tainted 6.7.0-rc2-
> 00147-gf1a09972a45a #1
> > [   10.071793] Hardware name: Toradex Verdin AM62 WB on Verdin
> Development Board (DT)
> > [   10.082898] Workqueue: events_unbound flush_to_ldisc
> > [   10.091345] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS
> BTYPE=3D--)
> > [   10.101820] pc : ttyport_receive_buf+0xd8/0xf8
> > [   10.109712] lr : ttyport_receive_buf+0xd8/0xf8
> > [   10.117581] sp : ffff800082b9bd20
> > [   10.124202] x29: ffff800082b9bd20 x28: ffff00000000ee05 x27:
> ffff0000002f21c0
> > [   10.134735] x26: ffff000002931820 x25: 61c8864680b583eb x24:
> ffff0000002f21b8
> > [   10.145209] x23: ffff00000026e740 x22: ffff0000002f21e0 x21:
> ffffffffffffffac
> > [   10.155686] x20: ffff000000da5c00 x19: 0000000000000006 x18:
> 0000000000000000
> > [   10.166178] x17: ffff7fffbe0e7000 x16: ffff800080000000 x15:
> 000039966db1c650
> > [   10.176564] x14: 000000000000022c x13: 000000000000022c x12:
> 0000000000000000
> > [   10.186979] x11: 000000000000000a x10: 0000000000000a60 x9 :
> ffff800082b9bb80
> > [   10.197352] x8 : ffff00000026f200 x7 : ffff00003fd90080 x6 :
> 00000000000022e5
> > [   10.207680] x5 : 00000000410fd030 x4 : 0000000000c0000e x3 :
> ffff7fffbe0e7000
> > [   10.218051] x2 : 0000000000000002 x1 : 0000000000000000 x0 :
> 0000000000000000
> > [   10.228393] Call trace:
> > [   10.233989]  ttyport_receive_buf+0xd8/0xf8
> > [   10.241224]  flush_to_ldisc+0xbc/0x1a4
> > [   10.248117]  process_scheduled_works+0x16c/0x28c
> > [   10.255851]  worker_thread+0x16c/0x2e0
> > [   10.262673]  kthread+0x11c/0x128
> > [   10.268953]  ret_from_fork+0x10/0x20
> > [   10.275460] ---[ end trace 0000000000000000 ]---
> > [   10.294674] Bluetooth: hci0: Frame reassembly failed (-84)
> > [   10.461657] Bluetooth: hci0: Frame reassembly failed (-84)
> > [   10.472025] Bluetooth: hci0: Frame reassembly failed (-84)
>=20
> I think that what is happening is the following:
>=20
>  -> serdev-ttyport.c:ttyport_receive_buf()
>    -> btnxpuart.c:btnxpuart_receive_buf()
>       -> h4_recv_buf() errors out
>       -> return -84
>    -> warn because ret is <0
>=20
> Is this the desired behavior? If I understand correct recv_buf() is suppo=
sed to
> return how many bytes it has consumed, e.g. something from 0 to count.
The recv_buf() returns how many bytes it has consumed and created a complet=
e RX packet from received chunks, if everything goes as expected (>=3D0).
However, if there is a packet corruption, or the payload length in received=
 header, and actual payload are not equal, or wrong sequence is received or=
 there is a probable baudrate mismatch, it returns an error (<0).

In this case, -84 is illegal sequence error.

It would help if you could share with us some more info:
1) Test steps.
2) Logic Analyzer captures of UART TX/RX lines when this issue occurred, to=
 check what is causing this illegal sequence error.
3) Is PDn pin toggled? If yes, then chip is probably sending out bootloader=
 signatures at 115200, while host UART is at 3000000.

Thanks,
Neeraj
