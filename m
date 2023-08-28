Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF2C978A57A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 08:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbjH1GAl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 02:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbjH1GAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 02:00:24 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2087.outbound.protection.outlook.com [40.107.7.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D01BD123;
        Sun, 27 Aug 2023 23:00:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GLexSDxp1N2slbtWqZGi5Ple2oWJeTIfq0m6vWUW7XaHiipEF38IQ2paTXyjm5bw54JQ3ra07GTs94OpYhoD26CG2+l7i8EjAn4jGdrKbS/1/25O4bsmRxQmQiGqqdXOfwXarZnc1J7qypgFMELzy3OioCRY8rOJUhXvd0s5gAjSEu/Igl8SpcnuDudcyDXXSfMjQYEuNgXe+bbkDluCqPZuD76qKpLjSPWcXp3kCRJks0WgQCF6VrZEIV3S71Md5JeMkzVqr4WfJlfHF8xgecG9m+Y/CPbFM/rYMQgfD//NwPVoCPvbmW+zJoqx+MsgqKRzYpn1qsCyN/ANzKHoGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pMeaNlnndlvuXWksQV8RNSS5dC0lerbVed/uuDwSg+U=;
 b=IgJa3ZXVCBXmWzjy3FpjkKReVpVR2O4MSwZoBQSdmxnpt/Fs2of3FImJpbqeIyMjZugiowPF+Bw3csIgsKF95ykI0Fg5flbvWlhcyk1LRrcQ5zywrBQNcUOMIT4Dv66Yfyc5VlKgXHgHciUYQHgqIJ46P27jgTwmlcxvuKfELdHdrDWBp7dXCJKVI2eSWzon7FNWtzU7PGs9pU7ypCzgAanD0WYWp3/ADFDTmjzj5mbbJ7qlnbLk/sdNj/s5L5kJImcW//0+iVeNLuWi0cCy/f5+AtBgPAVhvydRmdyGrfjzRSVCRoezNI+xICcC/cViMFwvdxbWdXi5fVMYKGpsAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pMeaNlnndlvuXWksQV8RNSS5dC0lerbVed/uuDwSg+U=;
 b=Y+MEf0mPexGvlA0z68hn1MBxGRdeTjZxfRvhc1ayt1LW3IspsLy+Q+KKRA4q4bVelE5ScSQf0eX2Fr6ey8mTorZkod59HTKjSA381QbH5xd0VK4f/7QRKB70osDYbOezZSaEcL5moRWPWBXVBResCCHsOrqxDXmDLNt6v4szwB0=
Received: from AM9PR04MB8211.eurprd04.prod.outlook.com (2603:10a6:20b:3ea::17)
 by DB8PR04MB7083.eurprd04.prod.outlook.com (2603:10a6:10:121::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.25; Mon, 28 Aug
 2023 06:00:17 +0000
Received: from AM9PR04MB8211.eurprd04.prod.outlook.com
 ([fe80::3df9:f31a:be7f:4b97]) by AM9PR04MB8211.eurprd04.prod.outlook.com
 ([fe80::3df9:f31a:be7f:4b97%4]) with mapi id 15.20.6699.034; Mon, 28 Aug 2023
 06:00:17 +0000
From:   Varun Sethi <V.Sethi@nxp.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
CC:     Rob Herring <robh@kernel.org>, Pankaj Gupta <pankaj.gupta@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "clin@suse.com" <clin@suse.com>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "pierre.gondois@arm.com" <pierre.gondois@arm.com>,
        Jacky Bai <ping.bai@nxp.com>,
        Clark Wang <xiaoning.wang@nxp.com>,
        Wei Fang <wei.fang@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        Bough Chen <haibo.chen@nxp.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Gaurav Jain <gaurav.jain@nxp.com>,
        "alexander.stein@ew.tq-group.com" <alexander.stein@ew.tq-group.com>,
        Sahil Malhotra <sahil.malhotra@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>
Subject: RE: [EXT] Re: [PATCH v5 01/11] dt-bindings: arm: fsl: add imx-se-fw
 binding doc
Thread-Topic: [EXT] Re: [PATCH v5 01/11] dt-bindings: arm: fsl: add imx-se-fw
 binding doc
Thread-Index: AQHZ1ZRNognu21NiNEqcymppfWTOnK/307kAgAH3e4CAAAqTAIAFZ0EA
Date:   Mon, 28 Aug 2023 06:00:17 +0000
Message-ID: <AM9PR04MB8211D170F1D484E083C8F899E8E0A@AM9PR04MB8211.eurprd04.prod.outlook.com>
References: <20230823073330.1712721-1-pankaj.gupta@nxp.com>
 <20230823073330.1712721-2-pankaj.gupta@nxp.com>
 <20230823124340.GA2022486-robh@kernel.org>
 <574e93da-ec74-f1a2-7170-c16bb225a2bb@kernel.org>
 <2023082422-proofing-dispense-1a1a@gregkh>
In-Reply-To: <2023082422-proofing-dispense-1a1a@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8211:EE_|DB8PR04MB7083:EE_
x-ms-office365-filtering-correlation-id: 162b86ee-e00a-41fe-62fc-08dba78c0dd9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Hx6HLPJ2GwIInFerhzk6cdK87l8wQ7bgtFZTMHcBLN46hi/d+bB/pcfkKDkLNY0mWG86YDjIrSuKESoI8qCW9DkMe2okUTrgDu4GuBH/acdoDeGvYOqVrglc309455AsqLsm7pP8lHWNvz+sPFOf3TC3xMBrrL5hQZavQj8LudnbVzlqTNEdM4FilmLzZ5EIMbdMnQfWqsWEAO2tXwwJgm4uJFZOleYy1chAvBGlRCgCjJtHfaxkUZxBqZ0o0rr5AcCUsYVqaRKVe1jmIDow7LaI9oEmmKkvPJ5dO5gs3w6YgntIcZSh3+lqH4+Ewizux6AcvRLY5We0/PrZdWdnDH8LBQUazJY8eP/BfQiNwZCpBV4LmuKcHuNH20xO3Oavxg1Mga2BDJ9ukIpORjUOon18V30WyRUtNMYNCazFu1eX91+Hu5ijtHZMq5yt+MccZxWmA3hURcMviduKb868sorM8OEd8D2cC7Vm3yEenTBIp6vncslcN0wBrl2DpJmYmhCInox7OFx3UtrW/nzQOb5hOfGSh5UQhIf25T+xj0bpawlhdp3WVFKUa3u1wLtr7KdYUHjwPHWyUQ1aZ30aYWs8HuYayW4Cd590IjBa3w0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8211.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(396003)(136003)(39860400002)(376002)(1800799009)(186009)(451199024)(86362001)(33656002)(7696005)(316002)(6506007)(54906003)(66476007)(66556008)(110136005)(66946007)(966005)(478600001)(53546011)(76116006)(64756008)(9686003)(52536014)(8676002)(38100700002)(41300700001)(4326008)(8936002)(38070700005)(122000001)(99936003)(26005)(71200400001)(5660300002)(7416002)(83380400001)(66446008)(2906002)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HnhZHpBPjGGmKzcf7t7V1RZXSUdR3mcHw4kI75bMGbLsy5dvCAHIwAtyjNuM?=
 =?us-ascii?Q?ygy0L8OkK5CQV9aiuXBPRJc7nZ7TFdXJwfxSj5et37PP93PfMIk/Y5mIyl13?=
 =?us-ascii?Q?l2SViz+a3svjCHInB4yX8ir4kbosStwu3Jm9RhAaOTCcsa/hq+hk9Dz7/qX7?=
 =?us-ascii?Q?pZa2QxxtdO/+MBSQ6/3MwyE5TC7LHeOzcQwSen7xdtDmOuvoTMjoi4Zdms2d?=
 =?us-ascii?Q?PvqxrvQHyeoKWWDBkpCN4T78KFWVXB6fLhrSfJ10EbbysBEwxfXwoQL3jtcX?=
 =?us-ascii?Q?yn/dJg13si6nymxBcqh2U7QXOfnWLl5gAUJ+tFW69V/ZvVbwDHlN/+zPneGS?=
 =?us-ascii?Q?J7dlpCHDy/ytIG0JcEYK3jvEBvldeMHhjGC8OjMvgIZPJsUBbwb1m8zWiAVM?=
 =?us-ascii?Q?r/8KI+6CiwLjijG1OIJSt+OKrJ01Sb+045OFt6oIm3R1Q4vw4z8QvieSA0cj?=
 =?us-ascii?Q?spP29IHaV/7v0A6UUVKzYHe3PjzmpDOe5bce6H4EVqoAX91Mh1e6Al9woqmE?=
 =?us-ascii?Q?qRT/vb7UoUNWqKztUvHOF0F698jwcK4F0D+6fjnecEGA/75zmWB/AmkJh7Go?=
 =?us-ascii?Q?XXJA9hGf3u5gAHcLd4kVMl232X/uzrDPT1J4Zz1WpUkqbG9qR1vfr6qMZL4a?=
 =?us-ascii?Q?XahkjQDKR0nUCtmUgjyMqHEKk+j1XNX7BejrdbR2gDvRolK70XizLkCMPWja?=
 =?us-ascii?Q?8S58Gr/GqEHrhlUOApsPjACgEEXFJNvlnpcD6qgDkbAGUUWoQ/pySZyrpLNL?=
 =?us-ascii?Q?bsobcAa93A45bvZbHi8QdmuTn9j2kLr/Qi5RPSUMPZfUI5Lo3ZcajrzCE8dK?=
 =?us-ascii?Q?nLLwEna1CjZFuHcvS9c9tYz80w2kEcQ0F2uUPaj6P18xdXs41DQ+ScsSsTOT?=
 =?us-ascii?Q?99gql/n1y8C3xt6NOcSjAfZyZX98Yw1qJWNw7HJXYpNHMZJuCXrkWmjvE5/w?=
 =?us-ascii?Q?sbkk+Ud8VmChxDQLu1AXnjRLCJSWzotb9RsONkGwS7szu/FFqKOGTFxvSwQb?=
 =?us-ascii?Q?LCKdPvUBUUWpf1im45WyCCk1iKA8D7uVd7R53QZJhutF3+wwZ7+NXR7xo8ei?=
 =?us-ascii?Q?IjHOfhMyP0BQC/dOUw4IoPvMwm/YG/GV304hAnmGmZ6t01BWa2YZOO0ExDjL?=
 =?us-ascii?Q?5bhVRVMorK3QhOv6rqpPzvbNgp5/YtdRVicgnFM74Rc2qPXNpmQTIQ/z2CUB?=
 =?us-ascii?Q?TunlCySADpzDgmBHwNoMWjGXLKh8s8aT21ziKlfMTBsvCNYFxxtei16YfNsg?=
 =?us-ascii?Q?AYl0Seol97jGvmi4vkRPXZMcvtNeRckDueu3egCUIX/aODG8Gnnm2q7kwShE?=
 =?us-ascii?Q?2G5m6iymCOLaPL+2meA3KexRdNuAlcpQq2ZtNXSwDS/My63jTn5eurPyJLmN?=
 =?us-ascii?Q?ns8hMxvzQ26PdV+xhD8bJC8lKZL2A9R+SsafNP2W4W0nM1yYkwZhJ8OOr/Ce?=
 =?us-ascii?Q?T0QfkLC+6RaefohLcsqjbH4f86YFXOi4qe+fr5BGS9lDnLxbZN3JafsFdqe8?=
 =?us-ascii?Q?W7f5q2B4rJtXPkPrOyJo+yGfYBiyb8zU5fs4+m9DUGv45VEwhpiXNwBOy9bV?=
 =?us-ascii?Q?dGyTPEYZi+7O2EGjkzU=3D?=
Content-Type: multipart/signed;
        protocol="application/x-pkcs7-signature";
        micalg=SHA1;
        boundary="----=_NextPart_000_0064_01D9D9A3.03991140"
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8211.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 162b86ee-e00a-41fe-62fc-08dba78c0dd9
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2023 06:00:17.2509
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uJ+cx5bgp1akbKCJ0efu6sCeOaYipp5bIMLlEkCnxv0Xfk7uwMZWQxz1rmdlbAsM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7083
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

------=_NextPart_000_0064_01D9D9A3.03991140
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Greg,

> -----Original Message-----
> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Sent: Friday, August 25, 2023 12:54 AM
> To: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: Rob Herring <robh@kernel.org>; Pankaj Gupta
> <pankaj.gupta@nxp.com>; shawnguo@kernel.org; s.hauer@pengutronix.de;
> kernel@pengutronix.de; clin@suse.com; conor+dt@kernel.org;
> pierre.gondois@arm.com; Jacky Bai <ping.bai@nxp.com>; Clark Wang
> <xiaoning.wang@nxp.com>; Wei Fang <wei.fang@nxp.com>; Peng Fan
> <peng.fan@nxp.com>; Bough Chen <haibo.chen@nxp.com>;
> festevam@gmail.com; dl-linux-imx <linux-imx@nxp.com>;
> davem@davemloft.net; krzysztof.kozlowski+dt@linaro.org; linux-arm-
> kernel@lists.infradead.org; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org; Gaurav Jain <gaurav.jain@nxp.com>;
> alexander.stein@ew.tq-group.com; Sahil Malhotra
> <sahil.malhotra@nxp.com>; Aisheng Dong <aisheng.dong@nxp.com>; Varun
> Sethi <V.Sethi@nxp.com>
> Subject: [EXT] Re: [PATCH v5 01/11] dt-bindings: arm: fsl: add imx-se-fw
> binding doc
> 
> Caution: This is an external email. Please take care when clicking links
or
> opening attachments. When in doubt, report the message using the 'Report
> this email' button
> 
> 
> On Thu, Aug 24, 2023 at 08:45:41PM +0200, Krzysztof Kozlowski wrote:
> > On 23/08/2023 14:43, Rob Herring wrote:
> > >> +                                                          |
> > >> +  +------------------------------------------------------ |
> > >> +                     |             |           |          |
> > >> +  userspace     /dev/ele_muXch0    |           |          |
> > >> +                           /dev/ele_muXch1     |          |
> > >> +                                         /dev/ele_muXchY  |
> > >> +                                                          |
> > >> +
> > >> +  When a user sends a command to the firmware, it registers its
> > >> + device_ctx  as waiter of a response from firmware.
> > >> +
> > >> +  A user can be registered as receiver of command from the ELE.
> > >> +  Create char devices in /dev as channels of the form
> > >> + /dev/ele_muXchY with X  the id of the driver and Y for each
> > >> + users. It allows to send and receive  messages to the NXP
> > >> + EdgeLock Enclave IP firmware on NXP SoC, where current  possible
> value, i.e., supported SoC(s) are imx8ulp, imx93.
> > >
> > > Looks like a bunch of Linux details which don't belong in the binding.
> > >
> > > Why do you need your own custom interface to userspace? No one else
> > > has a similar feature in their platforms? Something like virtio or
> > > rpmsg doesn't work?
> >
> > +Cc Greg,
> >
> > I doubt they care. This is some stub-driver to pass messages from
> > user-space to the firmware. The interface is undocumented, without
> > examples and no user-space user.
> 
> Great, no user?  Let's delete the code then :)
> 
[Varun] We do have middleware applications that utilize the driver.
Following
are the links:
https://github.com/nxp-imx/imx-secure-enclave
https://github.com/nxp-imx/imx-smw

Also, we plan to enable the kernel crypto API interface to 
leverage operations provided by the firmware.

Regards
Varun

------=_NextPart_000_0064_01D9D9A3.03991140
Content-Type: application/pkcs7-signature;
	name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="smime.p7s"

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIg+jCCBaIw
ggOKoAMCAQICCE4Rpu+H69FRMA0GCSqGSIb3DQEBCwUAMGUxIjAgBgNVBAMMGU5YUCBJbnRlcm5h
bCBQb2xpY3kgQ0EgRzIxCzAJBgNVBAsMAklUMREwDwYDVQQKDAhOWFAgQi5WLjESMBAGA1UEBwwJ
RWluZGhvdmVuMQswCQYDVQQGEwJOTDAeFw0yMzA0MjEwNjQzNDVaFw0yODA0MTkwNjQzNDVaMIG2
MRwwGgYDVQQDDBNOWFAgRW50ZXJwcmlzZSBDQSA1MQswCQYDVQQLDAJJVDERMA8GA1UECgwITlhQ
IEIuVi4xEjAQBgNVBAcMCUVpbmRob3ZlbjEWMBQGA1UECAwNTm9vcmQtQnJhYmFudDETMBEGCgmS
JomT8ixkARkWA3diaTETMBEGCgmSJomT8ixkARkWA254cDETMBEGCgmSJomT8ixkARkWA2NvbTEL
MAkGA1UEBhMCTkwwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDAWrnSkYP60A8wj4AO
kATDjnbdgLv6waFfyXE/hvatdWz2YYtb1YSRi5/wXW+Pz8rsTmSj7iusI+FcLP8WEaMVLn4sEIQY
NI8KJUCz21tsIArYs0hMKEUFeCq3mxTJfPqzdj9CExJBlZ5vWS4er8eJI8U8kZrt4CoY7De0FdJh
35Pi5QGzUFmFuaLgXfV1N5yukTzEhqz36kODoSRw+eDHH9YqbzefzEHK9d93TNiLaVlln42O0qaI
MmxK1aNcZx+nQkFsF/VrV9M9iLGA+Qb/MFmR20MJAU5kRGkJ2/QzgVQM3Nlmp/bF/3HWOJ2j2mpg
axvzxHNN+5rSNvkG2vSpAgMBAAGjggECMIH/MFIGCCsGAQUFBwEBBEYwRDBCBggrBgEFBQcwAoY2
aHR0cDovL253dy5wa2kubnhwLmNvbS9jZXJ0cy9OWFBJbnRlcm5hbFBvbGljeUNBRzIuY2VyMB0G
A1UdDgQWBBRYlWDuTnTvZSKqve0ZqSt6jhedBzASBgNVHRMBAf8ECDAGAQH/AgEAMEUGA1UdHwQ+
MDwwOqA4oDaGNGh0dHA6Ly9ud3cucGtpLm54cC5jb20vY3JsL05YUEludGVybmFsUG9saWN5Q0FH
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
HwYDVR0jBBgwFoAUWJVg7k5072Uiqr3tGakreo4XnQcwggFGBgNVHR8EggE9MIIBOTCCATWgggEx
oIIBLYaByGxkYXA6Ly8vQ049TlhQJTIwRW50ZXJwcmlzZSUyMENBJTIwNSxDTj1OTEFNU1BLSTAw
MDUsQ049Q0RQLENOPVB1YmxpYyUyMEtleSUyMFNlcnZpY2VzLENOPVNlcnZpY2VzLENOPUNvbmZp
Z3VyYXRpb24sREM9d2JpLERDPW54cCxEQz1jb20/Y2VydGlmaWNhdGVSZXZvY2F0aW9uTGlzdD9i
YXNlP29iamVjdENsYXNzPWNSTERpc3RyaWJ1dGlvblBvaW50hi9odHRwOi8vbnd3LnBraS5ueHAu
Y29tL2NybC9OWFBFbnRlcnByaXNlQ0E1LmNybIYvaHR0cDovL3d3dy5wa2kubnhwLmNvbS9jcmwv
TlhQRW50ZXJwcmlzZUNBNS5jcmwwggEQBggrBgEFBQcBAQSCAQIwgf8wgbsGCCsGAQUFBzAChoGu
bGRhcDovLy9DTj1OWFAlMjBFbnRlcnByaXNlJTIwQ0ElMjA1LENOPUFJQSxDTj1QdWJsaWMlMjBL
ZXklMjBTZXJ2aWNlcyxDTj1TZXJ2aWNlcyxDTj1Db25maWd1cmF0aW9uLERDPXdiaSxEQz1ueHAs
REM9Y29tP2NBQ2VydGlmaWNhdGU/YmFzZT9vYmplY3RDbGFzcz1jZXJ0aWZpY2F0aW9uQXV0aG9y
aXR5MD8GCCsGAQUFBzAChjNodHRwOi8vbnd3LnBraS5ueHAuY29tL2NlcnRzL05YUC1FbnRlcnBy
aXNlLUNBNS5jcnQwDQYJKoZIhvcNAQELBQADggEBAEEfsA0F+xNIIHRidw1YMWKTkWBmsGRri99r
6fQ1dL6dBG2KEsPRiF9y/Uf7jadR12HglTbmWUM5xdqxCWqf4UAxQDH1OoXn2xdvaP4ApmIMI2i8
Wwa8yJT8fBdmQQn5NEfqu9zPpfQL4NHEmvUqgXMhZzsa2dGrJoX/oNe7zw2UPnUNL+KB6B7N/P3o
Pupu18TuxAMIKYnGr+cb4Xx6iecFuncI7OLu3t/AkwUYtUYO/H8tr1E8YSj52rlSPb8xAD6VHGxm
daNqC79xMXbXx7SdgzRkb8kJKBTQhNcYz1xmsGTtP5ZE9FE8m8MgRq5Bh+7q8TWzMdeA9mIQIDE0
qOwwggg4MIIHIKADAgECAhMtAApIQhnEGx1xgCPsAAEACkhCMA0GCSqGSIb3DQEBCwUAMIG2MRww
GgYDVQQDDBNOWFAgRW50ZXJwcmlzZSBDQSA1MQswCQYDVQQLDAJJVDERMA8GA1UECgwITlhQIEIu
Vi4xEjAQBgNVBAcMCUVpbmRob3ZlbjEWMBQGA1UECAwNTm9vcmQtQnJhYmFudDETMBEGCgmSJomT
8ixkARkWA3diaTETMBEGCgmSJomT8ixkARkWA254cDETMBEGCgmSJomT8ixkARkWA2NvbTELMAkG
A1UEBhMCTkwwHhcNMjMwODA5MDk0ODE0WhcNMjUwODA4MDk0ODE0WjCBmjETMBEGCgmSJomT8ixk
ARkWA2NvbTETMBEGCgmSJomT8ixkARkWA254cDETMBEGCgmSJomT8ixkARkWA3diaTEMMAoGA1UE
CxMDTlhQMQswCQYDVQQLEwJJTjEWMBQGA1UECxMNTWFuYWdlZCBVc2VyczETMBEGA1UECxMKRGV2
ZWxvcGVyczERMA8GA1UEAxMIbnhhMDY0NzUwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIB
AQC4HbZ3M7z3dSiGvIB/e1S8Vk9d1Ll7qBV5X9aGUQ4ufPKfd+3PLNCVmKGnzlULLKuZGhZdGWgL
6ICnJYksySHcRhfMaaX3r7Cp/M/Y2JCqaf2baJ5wtwq5IHfGWBj4XL1E7tv6Z3UzGdnAsxis2MjV
FvdzqS5w5qgI52pkmVXpHqUn2bazRlkXnIYbhSQZL4hZf7kzJGlgJmQyWYbr51PMWyn/JHfSEVjz
GgghaLLdZU9rEm3x0rvAV/GZCTJPp/lrpHHA/SC+CFteDosHoDTHqN4mlV7zfg/sAKy4QEnMmlHq
jQXxx00DiwyjTzg/7ZvEVVvo0GUBVl8aMtGGujHFAgMBAAGjggRXMIIEUzA8BgkrBgEEAYI3FQcE
LzAtBiUrBgEEAYI3FQiFgsB+gY70VYbthTiC65lLmpJWP4Xmim6EteF+AgFkAgE7MBMGA1UdJQQM
MAoGCCsGAQUFBwMEMA4GA1UdDwEB/wQEAwIFIDAMBgNVHRMBAf8EAjAAMBsGCSsGAQQBgjcVCgQO
MAwwCgYIKwYBBQUHAwQwgZQGCSqGSIb3DQEJDwSBhjCBgzALBglghkgBZQMEASowCwYJYIZIAWUD
BAEtMAsGCWCGSAFlAwQBFjALBglghkgBZQMEARkwCwYJYIZIAWUDBAECMAsGCWCGSAFlAwQBBTAK
BggqhkiG9w0DBzAHBgUrDgMCBzAOBggqhkiG9w0DAgICAIAwDgYIKoZIhvcNAwQCAgIAMDsGA1Ud
EQQ0MDKgHwYKKwYBBAGCNxQCA6ARDA9WLlNldGhpQG54cC5jb22BD1YuU2V0aGlAbnhwLmNvbTAd
BgNVHQ4EFgQU02lKsh6BFAv1r0HH4kII7jSbHEwwHwYDVR0jBBgwFoAUWJVg7k5072Uiqr3tGakr
eo4XnQcwggFGBgNVHR8EggE9MIIBOTCCATWgggExoIIBLYaByGxkYXA6Ly8vQ049TlhQJTIwRW50
ZXJwcmlzZSUyMENBJTIwNSxDTj1OTEFNU1BLSTAwMDUsQ049Q0RQLENOPVB1YmxpYyUyMEtleSUy
MFNlcnZpY2VzLENOPVNlcnZpY2VzLENOPUNvbmZpZ3VyYXRpb24sREM9d2JpLERDPW54cCxEQz1j
b20/Y2VydGlmaWNhdGVSZXZvY2F0aW9uTGlzdD9iYXNlP29iamVjdENsYXNzPWNSTERpc3RyaWJ1
dGlvblBvaW50hi9odHRwOi8vbnd3LnBraS5ueHAuY29tL2NybC9OWFBFbnRlcnByaXNlQ0E1LmNy
bIYvaHR0cDovL3d3dy5wa2kubnhwLmNvbS9jcmwvTlhQRW50ZXJwcmlzZUNBNS5jcmwwggEQBggr
BgEFBQcBAQSCAQIwgf8wgbsGCCsGAQUFBzAChoGubGRhcDovLy9DTj1OWFAlMjBFbnRlcnByaXNl
JTIwQ0ElMjA1LENOPUFJQSxDTj1QdWJsaWMlMjBLZXklMjBTZXJ2aWNlcyxDTj1TZXJ2aWNlcyxD
Tj1Db25maWd1cmF0aW9uLERDPXdiaSxEQz1ueHAsREM9Y29tP2NBQ2VydGlmaWNhdGU/YmFzZT9v
YmplY3RDbGFzcz1jZXJ0aWZpY2F0aW9uQXV0aG9yaXR5MD8GCCsGAQUFBzAChjNodHRwOi8vbnd3
LnBraS5ueHAuY29tL2NlcnRzL05YUC1FbnRlcnByaXNlLUNBNS5jZXIwUQYJKwYBBAGCNxkCBEQw
QqBABgorBgEEAYI3GQIBoDIEMFMtMS01LTIxLTE5MTUyMDcwMTMtMjYxNTA0MDM2OC0zMDc2OTI5
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
yqWSRG8TriVkksAAAAAAAAA=

------=_NextPart_000_0064_01D9D9A3.03991140--
