Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1B9277875B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 08:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233647AbjHKGTT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 02:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjHKGTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 02:19:17 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2057.outbound.protection.outlook.com [40.107.13.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 191CD2D4F;
        Thu, 10 Aug 2023 23:19:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=btVaY568xYyV9oNIo07qfn//9i3wfiv0ZMZMD6+HmumpYuC7QKbXEGQhOM7RXgxnzfXDbQfJqWiTnkp5wdwKo0vXEHsfYsOwOf5brQwhB4Sz4DMIpwuDN1m+dGuUpTy+ngHq+DCaqHC4Vv91F7wshqnPHXI9PMRbbU9TV27VFDGdR/onrogkuxq8mKdKXilajTgvLemoScRJNDbRjt1tXKRoBPPD5B+6UveGAHDCPvTIYorz6XlAFBbdNPuuOB1oSDnNOzok4RdeUHvNL6YYHUh7e+vPon9BMiaIj+pQW2IYMJvIecIrM/jzStK6SIINurQQgyEn/0IooeDh/hEV4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xfd+oy6dtaJDcwlAGt8emX9q8o030zDBj3e5cxZLcK0=;
 b=jpCk79/+wX7qU+ISprFr7HcAxnwTFK6LftHBs5NZO2/eGKrUOw0xTk3cAbcL/QaA12RrN4pghCIBSIenoRm8iU/9xFJODH+HltCpJDhTsBx8JxW1mko6hYKCJVMmIRs53JtE9NdbfaHX6NTrk2YUe0hm+aTsdw5MVenxQzr2mR46wbQES4Or3OYjxEr6UuQxN961+EdmudlnX/lf+0o1GMcymeVYxCjPUQQzkgsG5AF+0PqMzzLGj9CWoJDRPWdE52VkX1hWOXQ54ChTy4iB7cGHRvw8AtGCtwj5ibhmb9iK1g/sgv/GR7aCMGpj3WjppdPBrySVoBwCh7Pv/D8LOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xfd+oy6dtaJDcwlAGt8emX9q8o030zDBj3e5cxZLcK0=;
 b=dqwhjqniiNgkcGILCohsNfzm3+VEx/6kRuDDHDYf+FzA8lEmQWk1ng3s2J3qHRlvyp7Hfcgevwui4q3JIuHTHe5kUZ5hwdZOOxo6NbKvIbJEkQYMBo1t4DsaPjKtHCAOIsXJt+LR3DNzqXclIpX7VLpEy4v9F6yQo3tp3fAWGuY=
Received: from AM9PR04MB8603.eurprd04.prod.outlook.com (2603:10a6:20b:43a::10)
 by DBAPR04MB7464.eurprd04.prod.outlook.com (2603:10a6:10:1a8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.20; Fri, 11 Aug
 2023 06:19:12 +0000
Received: from AM9PR04MB8603.eurprd04.prod.outlook.com
 ([fe80::7504:9897:4e5d:df25]) by AM9PR04MB8603.eurprd04.prod.outlook.com
 ([fe80::7504:9897:4e5d:df25%4]) with mapi id 15.20.6678.019; Fri, 11 Aug 2023
 06:19:12 +0000
From:   Neeraj sanjay kale <neeraj.sanjaykale@nxp.com>
To:     Francesco Dolcini <francesco@dolcini.it>
CC:     "marcel@holtmann.org" <marcel@holtmann.org>,
        "johan.hedberg@gmail.com" <johan.hedberg@gmail.com>,
        "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>,
        Amitkumar Karwar <amitkumar.karwar@nxp.com>,
        Rohit Fule <rohit.fule@nxp.com>,
        Sherry Sun <sherry.sun@nxp.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] Bluetooth: btnxpuart: Add support for IW624 chipset
Thread-Topic: [PATCH v1] Bluetooth: btnxpuart: Add support for IW624 chipset
Thread-Index: AQHZzBu/ZNvkJKpX/Easuk1eK/rWBA==
Date:   Fri, 11 Aug 2023 06:19:12 +0000
Message-ID: <AM9PR04MB8603F338D7C1511C3E0269C9E710A@AM9PR04MB8603.eurprd04.prod.outlook.com>
References: <20230810094802.832652-1-neeraj.sanjaykale@nxp.com>
 <ZNUUeD2Zr1SfTODT@francesco-nb.int.toradex.com>
 <DU2PR04MB860074DF11676414E57A5904E713A@DU2PR04MB8600.eurprd04.prod.outlook.com>
 <ZNUt9V2WCS/ZCavl@livingston.pivistrello.it>
In-Reply-To: <ZNUt9V2WCS/ZCavl@livingston.pivistrello.it>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8603:EE_|DBAPR04MB7464:EE_
x-ms-office365-filtering-correlation-id: 213d8be5-ffac-4695-eb15-08db9a32e1a4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4gyIbmijt0hPggH0OVyfjzEUFv07sy2b8R5dWSbu5MQ1k+4WutDflHEvm6rldMmSGHC0qlsnAN9sJbIHt0w++DPGphTaH/vt93ySZTKEqMAm+a7jF0PXlWWG0iTHX/zfYKjNfWX+rXGjigAlcYi6i6MFD6j52DFW83eoVdORPlY123e0zU1FrywBJsjEY5ujVu35NRaEnBnsdKIdLwbX0/SgKHEa/tXBznvTaStB3/XUXDhdNrBrkhx1GcBRNsCgJQVhvTOgyJiebtvWyEVwgce3uwvg335f22NpR1QWNQ1NB7evAoyE+eoHXQHHJy/8vL6hnPTuUAe6VBnnH7eelk4s85CPgmEu1OISS0nYpD+WEW+QzNI6DZJs/+wANBNgT/O+y3f2qL8uEz/RkPftunoHL+7kWVGZBNiK3FwYuyNAQk7QoYBYeaPqELTm5quYxJKbFYHQG6U0Pa8DaisKZfZxqru0f1Cw3sebNMv9wcwVtGwOb1uD7wTmcijqYvo+kr9BbXOml4hz87nP6IBB0WPW/8kaj/eXWl7BLe3qz8KQ2BvEKJbymsooMvh4AWSSNZCb0hzjxdnVURzb3XbBthuUqy5O+H702PkECVQuu/mdNsX4ykYyS1NEt0Gm77JC
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8603.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(366004)(376002)(39860400002)(346002)(1800799006)(451199021)(186006)(9686003)(41300700001)(86362001)(33656002)(55016003)(38070700005)(122000001)(38100700002)(55236004)(6506007)(26005)(83380400001)(478600001)(71200400001)(54906003)(7696005)(4326008)(6916009)(316002)(8936002)(8676002)(52536014)(66476007)(66446008)(64756008)(66946007)(5660300002)(66556008)(2906002)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?j/ib+wdMaKOUZCnvK0jWQTbNFUoH3towkeg6m5kfY+Do4D6pidl6/QoZtaQF?=
 =?us-ascii?Q?50Gy6SUTBEVXjp2a9T28BMbC2DkaEZLTLpMhzNPhbiZrklmXkDBEVEtyMjAz?=
 =?us-ascii?Q?Xd4iSv4s1jsWd5OzqrsGrqIqtoM+YSZm8TJbOdPOb7uNdtPG78AMio87rPeb?=
 =?us-ascii?Q?lbLHeJ+xNOeOARwY031w8yhLK1OG7mhO8OsK5I43wS5k/+GFM0KDCS4umYe0?=
 =?us-ascii?Q?+ZPhQYbme272i6Y26QjpWO2Yf0UO0e/3vX9jHeEqRu4fQkFe8/po9408brQU?=
 =?us-ascii?Q?D1EFoehs4xWe9Y06oDXXh4DcZcKdQaG6hG5yB35a9eRkjd6I4NAUtApRbZgl?=
 =?us-ascii?Q?nyZHjLbLsb4lgHqND0C3Ev0HyxZn6ncGEFbL5HCAXzwxuQIj7VBxOzFEjj0t?=
 =?us-ascii?Q?V+7gmn/4tupG7kcMuY7MCBMPy9lY2tgY8V8OR/MXMrNNibsUbdm+Iv/3dIvJ?=
 =?us-ascii?Q?gxYDYapFXWDWScnB2kC7tFs7scXMn6G+ZLBSTlJzsPIKWFGYaKCnEeWdYChW?=
 =?us-ascii?Q?7OUsPvKEzgxPULzOln5XMJ6J2IA2l5rcaadKU3OQ0bEbJEbCt0Y/Ivrrm9Z4?=
 =?us-ascii?Q?Gx8vgGIX3Tu+RQQLdLK8umTg7a2kEwCgoBhw8i/EcCqVdVn+oWM/539xFqNB?=
 =?us-ascii?Q?f32SHTBgsA0dXmDMdIqqRH6e0R6aqoT1kP+0NRUF/KTr5NX3zHZ/Tq7is2Xl?=
 =?us-ascii?Q?DFscVtvhuFQGgPW/62s6U1nsCEF88maInOeFDgeXlleIWGIudPoBq7i8JaWq?=
 =?us-ascii?Q?aSXO5ncolvyDiAaz/1ILch4iChgTFREgrsrUjqExxySoOO0fSQarkaKUQa4j?=
 =?us-ascii?Q?D2oKwgGu4sUQrqHkjH2nK99m8DhO8bvsQ/5UM2m9toV/X3xXkvYspGS2+QXD?=
 =?us-ascii?Q?8NVM/yeggEWNpmizyRBpyiV/06rJer4DKE/O5BNPeQh/ZFknokOJ0Oi1GANk?=
 =?us-ascii?Q?+qtevjgy1D4vCqPsg0guFA/avkkmFcpMozRwRyIMP4m5qHPw2bnDOeeIWvyR?=
 =?us-ascii?Q?fZU/NIwnk48AtqNdPj7+FHLv0y4WXCd7XSLGPFfiniuHFM+dUHY/IVHwAImk?=
 =?us-ascii?Q?s5Hcpq8LIueGltcBMMddquxI0zpBKzMqEvk0RBEabLaHkeKOb8NRNVXSNp6F?=
 =?us-ascii?Q?jgl59eE/+McQ31vewvrCfyoI9d0aADs+jrNX2Cfz0KdXy/6tRnQnsFXomCtC?=
 =?us-ascii?Q?+9I1s6/sjhHfJZukTPiyg+X1qxy+bGu4xymTbKTV8+UDnKjo8PtswFIxq8up?=
 =?us-ascii?Q?drmgyToQd08lZMgsWZ1OSVgGUBnJued5hMzxD1LtJJbmD5p5RV4Jj0jh2vDU?=
 =?us-ascii?Q?yrIN1JohPZH0BWfUBq46tG3GpwzW7rxmxZyLVQoC/OJ1AwgFZ91zT5ptj+Mk?=
 =?us-ascii?Q?AoGW5HV1bL5OxbE0gp1DA3OGG8LWzJeHQk4zE2K3jbE4gewcsI6439v/jFTN?=
 =?us-ascii?Q?l14/r85IOFnNBaADi2Rr91axqUEclRbxDtomC9QYUo1eYwlWRqcfGChXK7+R?=
 =?us-ascii?Q?JlB1e5zEcN6/kaUekm3tfjfdTWUcej+r7AlvPRzleu8TDgSUo6GaqJ8EmTrx?=
 =?us-ascii?Q?CkIzRjIOoXdotA4XfxHAyLZq6ABgZwyoz++jP+zZ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8603.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 213d8be5-ffac-4695-eb15-08db9a32e1a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2023 06:19:12.7730
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yKlb5DUQKcQGTpWbxVIXiVPwiBgJqfyky99KBBTaqyvAKb99iU5/5fQWn4nbLVC5y9NLXrB4bgcIbzqMK4d0OkJnH2+d8rqDOMkIWttzquI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7464
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Francesco

> >
> > > > --- a/drivers/bluetooth/btnxpuart.c
> > > > +++ b/drivers/bluetooth/btnxpuart.c
> > > ...
> > > > @@ -547,7 +553,7 @@ static int nxp_download_firmware(struct
> > > > hci_dev
> > > *hdev)
> > > >       serdev_device_set_flow_control(nxpdev->serdev, false);
> > > >       nxpdev->current_baudrate =3D HCI_NXP_PRI_BAUDRATE;
> > > >
> > > > -     /* Wait till FW is downloaded and CTS becomes low */
> > > > +     /* Wait till FW is downloaded */
> > > >       err =3D wait_event_interruptible_timeout(nxpdev-
> >fw_dnld_done_wait_q,
> > > >
> > > > !test_bit(BTNXPUART_FW_DOWNLOADING,
> > > >
> > > > &nxpdev->tx_state), @@ -558,16 +564,11 @@ static int
> > > nxp_download_firmware(struct hci_dev *hdev)
> > > >       }
> > > >
> > > >       serdev_device_set_flow_control(nxpdev->serdev, true);
> > > > -     err =3D serdev_device_wait_for_cts(nxpdev->serdev, 1, 60000);
> > > > -     if (err < 0) {
> > > > -             bt_dev_err(hdev, "CTS is still high. FW Download fail=
ed.");
> > > > -             return err;
> > > > -     }
> > > this seems like an unrelated change, and it's moving from a 60secs
> > > timeout polling CTS to nothing.
> > >
> > > What's the reason for this? Should be this a separate commit with a
> > > proper explanation?
> > >
> > While working on integrating IW624 in btnxpuart driver, I observed
> > that the first reset command was getting timed out, after FW download
> > was complete 2 out of 10 times. On further timing analysis, I noticed
> > that this wait for CTS code did not actually help much, since CTS is
> > already low after FW download, and becomes high after few more
> > milli-seconds, and then low again after FW is initialized.  So it was
> > either adding a "wait for CTS high" followed by "wait for CTS low", or
> simply increasing the sleep delay from 1000msec to 1200msec.
> > I chose the later as it seemed more cleaner, and did the job
> > perfectly, and tested all previously supported chipsets to make sure
> > nothing is broke.  But you are right, I should add an explanation for
> > this change in the commit message in the v2 patch.
>=20
> This should be a separate commit, and probably it should have a fixes tag=
,
> since this is solving a bug. I recently noted some bugs around this, I ju=
st did
> not have the time to reproduce on the latest mainline kernel to report th=
ose.
Sure I will revert this change and add the wait for CTS back. I will remove=
 it later in a separate fixes patch.
Please do let us know if you encounter any issues here.

>=20
> One more question on this, what about the use case in which a combo
> firmware is used and no firmware is loaded here? Will this use case be
> affected?
No in that case this part of code won't be executed.

In nxp_setup() -> nxp_check_boot_sign() waits for 1 second listening to any=
 bootloader signatures from the chip.

If any bootloader signature is received, the driver performs this nxp_downl=
oad_firmware()  routine.
If 1 second times out (which does in case of combo FW), it means FW is alre=
ady running, and the driver proceeds with its initialization routine.

Thanks,
Neeraj
