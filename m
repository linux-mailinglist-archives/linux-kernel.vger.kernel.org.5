Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E488B777FE1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 20:02:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233464AbjHJSCi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 14:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjHJSCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 14:02:36 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2071.outbound.protection.outlook.com [40.107.22.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C94EED;
        Thu, 10 Aug 2023 11:02:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YTDq4AgbhFWNVUbrHeLIxc4N/af+jsCXiNmiV+zWv740Qj2Mc5bGc5ZQx1ZhaZD2+hG0oLE/O5f5QG+6Vv0rNQ97JpihRxby8gSC5L4MtuzIZKHouCmoAvSR60wL22k1xIkrdc/T67s1gH5KchtckjOKMPZDazF+YQTE5N28Z25Lw7UUjV4ZmvftG1UeSW+sYYJFlawDnnNVJkqeNSHIHkQqNa6wvZsICCEaX7HGYI2Z9zCWTmJZMhJIaunx8QzJQkG6PMsl9sYhmYMxooXGji66hqlPwvQj/tEVuD7vdyjrBH4AXH0cTNvAMVwXNyqnOsZPQvTj7S99QUgvD6hvpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fFi8AGXXT/r2AUjibxwSbH3f4rJpPAAX0Y4L/e++2s4=;
 b=hbGKur9qMCXS8/PuUkX4W5mTF93+CVRpmWH5preTFUsZan5xF+ICFlRm2zC7ESEosAlXtMZfi3qlFz03MTIHwDfHeI0YvX6yTHtWprp6WNtIEPyHjy9s4m1kapRJqyEaqyPiXkj2zYk3kmf4cXrFujd+ypjwnIVploODibgZTplGEEL1zRWFa7A/YOfTUHaljgpOM/NgbhEIQd9jA3/qKjPq9GTj/yTrCAjn8Fs73UQEq5rURvIR93PbwNIPdQTcjuM92V4cldg2MbsZLlftk9Rpzb7SN+PGGZEKAN5ACZRBh00PdeMKGA1SgxJWAV6jEn+t7FXe/MDf+liEFPkL3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fFi8AGXXT/r2AUjibxwSbH3f4rJpPAAX0Y4L/e++2s4=;
 b=momd73z5ifHsVdKfoHj2970xn6OH1PWtv7ZTbn9QnYADVom163mEws1DHGSqSNEjq659jbCKesPU71YH86SdaLrMNGOzrNj9RIVotveKD4Vk4Aqq4sx6SifYWPx4yFHaI05dafO+1Sd0NDLzioP/sXwyX0amy+VRzRMH1cKl4RE=
Received: from DU2PR04MB8600.eurprd04.prod.outlook.com (2603:10a6:10:2db::12)
 by DB8PR04MB7017.eurprd04.prod.outlook.com (2603:10a6:10:123::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 18:02:32 +0000
Received: from DU2PR04MB8600.eurprd04.prod.outlook.com
 ([fe80::ad96:21d9:cba2:5c1d]) by DU2PR04MB8600.eurprd04.prod.outlook.com
 ([fe80::ad96:21d9:cba2:5c1d%7]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 18:02:32 +0000
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
Thread-Index: AQHZy7TVPhRhpc6pbUWRKW6v463VNQ==
Date:   Thu, 10 Aug 2023 18:02:32 +0000
Message-ID: <DU2PR04MB860074DF11676414E57A5904E713A@DU2PR04MB8600.eurprd04.prod.outlook.com>
References: <20230810094802.832652-1-neeraj.sanjaykale@nxp.com>
 <ZNUUeD2Zr1SfTODT@francesco-nb.int.toradex.com>
In-Reply-To: <ZNUUeD2Zr1SfTODT@francesco-nb.int.toradex.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR04MB8600:EE_|DB8PR04MB7017:EE_
x-ms-office365-filtering-correlation-id: e7566dd1-c034-4f5d-6b2f-08db99cbf850
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vBru8zOPYxQLfZhi/X6FxZiFRDNfDippGrSySUb2dbSRRzNSOOnXmO12//4s8K3403DIS54y96xgInpo7hVYFS1GXzX3WYC+xbbe7THDJ4eCLbnyo+ftkcvUOswjHHIx2+IbrXTKzU2u1B0b5ZGJ7/mwrIEEQHQs8pWL4/EDgRNyRn1l/ui2yHrMP0D6Wpyc6YaHTGqbGvZM+z4QLa1XB2V87r3mddSQlvhYF3ZJCoanS0m5vo2bTErjX9ldEIM4CTapr0UgdzXZ+DiidQsCC+lo5wpkVMLxpTyRgythqcmzjMsKxMmL3pYicHp+RzxQp1y5wistoYXJ0j14dRKupuP4P01c7zkBv0PnjWvGdOxcZNGVu4xrbbnrTBgI9V5YDbqzvj4zGgVnsC9x+ZQrFZs5230fdYhmTiOSwzYpqUAjlrr3kI07Qbv7j9jtzfKhQPbmcw0v078Jf4lK6kbYdoS2vq70zI8/QR/d5/VQDe1Qeh1unDEn3sZKI9f0wVpSHrSeUGQQBbSOzMf7+2qlTSsnaM/jlzO+nUf8bEepHlzLnEYWiZgkwBXI60KgKUDOxTbYgI8CHSGfP8KQXr9N5hQtxrymSvPkJzmNQHp7jUOO1CMoaY4QxpdG38yFjPWj
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8600.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(366004)(346002)(396003)(136003)(451199021)(186006)(1800799006)(83380400001)(33656002)(86362001)(478600001)(6506007)(9686003)(71200400001)(2906002)(55016003)(7696005)(26005)(55236004)(38070700005)(52536014)(316002)(122000001)(38100700002)(41300700001)(64756008)(6916009)(4326008)(66446008)(76116006)(66946007)(66476007)(66556008)(5660300002)(54906003)(8676002)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cCm9Y9q/I2XcVBtCMNyYNjNHji3HemqLYRZLzQmqja1/1Eow4lt8zjSGVVUb?=
 =?us-ascii?Q?XEVIf3Qd7tB1Dry9709Ny4Tj6zobEhveHgid6bhn3KPZ4iYMarqOB2U1hluO?=
 =?us-ascii?Q?zb8r7gnT8EQ1799nfj4LjNSyCVGDZixw3ytP6NqauJCv7BKXcGLN9WaMG0UX?=
 =?us-ascii?Q?Yg/d35JBDgKK7/HVGpYG8bMrSa25x346TzbVcZiQMSLVEhsBc+CCnSXFAxKJ?=
 =?us-ascii?Q?sas4W/J2gULrF5FlOCQq4YMD6KzMcD7/07oiFUKBUzs8G2SXI1YaVNprpj7m?=
 =?us-ascii?Q?fVIRNIYcCt2Jr0YIYt5t1hKE5s31G5Zj7W37b4SaD7hO1GeS4IOQix0axPSp?=
 =?us-ascii?Q?VKkrEsuQMSNQs6+XYaeK5s16Ygb01v5VbiHcVmP0k4p8q2teTNgChZ5ekNUU?=
 =?us-ascii?Q?PsnwkjOK9SD90qGi6bNe9dU5hlUhqq3YheSUCHSI1dtxuxXNWY9a4GaO8l42?=
 =?us-ascii?Q?x2Tv9Pi4uBwQtBac+wi7r1S3jYBiM7O293rvTDNzjtcypiBTd3hgtBHzwwZ0?=
 =?us-ascii?Q?be1DNn156LPj+DkwhsSIcP3XKYrTjHU+GefYh7tv2V+fvrzVZm7SGgSdQLMR?=
 =?us-ascii?Q?AQTz5RMiXoiXzk2rEg6VvlxFhkje9J8rm0QzXPlBMb81XEN4ngWgX96vnnwV?=
 =?us-ascii?Q?MG5Uuxvgp4PdzhDRq62Fx2ekeNAIRjLdecj3vNZN6upOcGoBCL7sIU6xOwYD?=
 =?us-ascii?Q?mw6a0oMwo6mXE7UjjQ+fDIMLp+ocGIEBfVDUTAaHbOpYnkctF808U8EBUiSv?=
 =?us-ascii?Q?hDIbYbvtDxmfLXcP8E3do9zhIn4P3oX7I0gUdqBw+tclmwBeoAxSnE4n6v24?=
 =?us-ascii?Q?ZfagJRUIyIHnbfPLpUk+cC9D2mX4Y1B2FvQ0Kv95WHb/LDIwUBLFnipcGHiw?=
 =?us-ascii?Q?zENcZNcR/tOdzkk1rWpHfPFlkSLTQkfh1JIUa0jrhgCJuyhz4PdW4WcvE1M9?=
 =?us-ascii?Q?SNkQGtIK5m6Y2FTLwXrCesr12Qz31s8oSmozfuZ9U+Eh284MsgUu+1bNn2rm?=
 =?us-ascii?Q?TZIrvZlyHbfes7EbY3oMKyjdKB/Wr/8QN6p1MkMw5FfKo7llxgoKhyI7XmLa?=
 =?us-ascii?Q?RBaw1qYTesqrYHUJmkcpm0jK4m+0vXgS5omSazA01v6dNI3REsvwukA2TURr?=
 =?us-ascii?Q?ahOErlkG8NbwC7MVjO/NK43f8skf29lDTOV9zwMyERiICQqQM6ufKzFxZCMj?=
 =?us-ascii?Q?DCBs+GqHO5i3qma5rwZgPedeJpjQGTCTFdYqpaMGVzjpL1OIOnWP/ADiWoYd?=
 =?us-ascii?Q?iTrqEecEteYJS642kZReO0JPA9luWRnWB3teLajzkqTZBFt0XjIOFJoQz6BV?=
 =?us-ascii?Q?rHU5I/jYzvDFuEGdi2atx0u+7D5ad2HluBBjQ0ivmeGk8dGeS6lca9Ds01lM?=
 =?us-ascii?Q?BZEac5CJ0yOSuVkHqd8Gy2Y42nC50OI684DOxXKFD1lereUqUNjlyzDGi5h1?=
 =?us-ascii?Q?P6COIezvPQpE4wUYuWk2PS2by9rJBg5WddRqimFmZ6DYVpyen+Cn5nr2nUsx?=
 =?us-ascii?Q?rN7dovLdqzPcC7l9j/RCZVALkg3jXokH9T8YjmlBYq3snq/dzIdpBM+8frAW?=
 =?us-ascii?Q?LulbRhSD4FUk/wtgklDt/zGunMfXkqKJ4GAGwuUn?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8600.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7566dd1-c034-4f5d-6b2f-08db99cbf850
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2023 18:02:32.6395
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ghtTmn6eMAorHbGC7897ewLWpzPEGgf/ieUbNHp488TTcl/GEUCGobkYpG5IknSX0pR6vjh0J9ZC+vhF6fMKIhztqRO3eIPEEr9B+asvLJs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7017
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Francesco

Thank you for reviewing this patch.

> > --- a/drivers/bluetooth/btnxpuart.c
> > +++ b/drivers/bluetooth/btnxpuart.c
> ...
> > @@ -547,7 +553,7 @@ static int nxp_download_firmware(struct hci_dev
> *hdev)
> >       serdev_device_set_flow_control(nxpdev->serdev, false);
> >       nxpdev->current_baudrate =3D HCI_NXP_PRI_BAUDRATE;
> >
> > -     /* Wait till FW is downloaded and CTS becomes low */
> > +     /* Wait till FW is downloaded */
> >       err =3D wait_event_interruptible_timeout(nxpdev->fw_dnld_done_wai=
t_q,
> >                                              !test_bit(BTNXPUART_FW_DOW=
NLOADING,
> >
> > &nxpdev->tx_state), @@ -558,16 +564,11 @@ static int
> nxp_download_firmware(struct hci_dev *hdev)
> >       }
> >
> >       serdev_device_set_flow_control(nxpdev->serdev, true);
> > -     err =3D serdev_device_wait_for_cts(nxpdev->serdev, 1, 60000);
> > -     if (err < 0) {
> > -             bt_dev_err(hdev, "CTS is still high. FW Download failed."=
);
> > -             return err;
> > -     }
> this seems like an unrelated change, and it's moving from a 60secs timeou=
t
> polling CTS to nothing.
>=20
> What's the reason for this? Should be this a separate commit with a prope=
r
> explanation?
>=20
While working on integrating IW624 in btnxpuart driver, I observed that the=
 first reset command was getting timed out, after FW download was complete =
2 out of 10 times. On further timing analysis, I noticed that this wait for=
 CTS code did not actually help much, since CTS is already low after FW dow=
nload, and becomes high after few more milli-seconds, and then low again af=
ter FW is initialized.
 So it was either adding a "wait for CTS high" followed by "wait for CTS lo=
w", or simply increasing the sleep delay from 1000msec to 1200msec.
I chose the later as it seemed more cleaner, and did the job perfectly, and=
 tested all previously supported chipsets to make sure nothing is broke.
But you are right, I should add an explanation for this change in the commi=
t message in the v2 patch.

Thanks,
Neeraj
