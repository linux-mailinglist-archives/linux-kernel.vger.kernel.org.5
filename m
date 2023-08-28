Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E74178A89D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 11:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbjH1JOb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 05:14:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjH1JOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 05:14:22 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2060.outbound.protection.outlook.com [40.107.6.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C909EC;
        Mon, 28 Aug 2023 02:14:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lw0K+rz4yZPJ9Jrl6eOHoS8vhdysecTvTbKtay7i/MYHUYCEtyMEnsv7MVKUIvI6AMc/w56yGdutg5IE1bGnv8RQO2ErqKVGSjB0LZMXNxyDT9Ttm7V45Dzo7w2SfK14pt5ZOM59AD5RJ4mLn7He1XnT9ECFwv8RZkbXri/3KIPTIBY+EBFJjMA91ls5tTlnoRV8KY3JMFSNrU4tasRhFxmuaw7zEWPqiU9YTCnGkXPNR+txx2L99UA26AiJK4OO3AemaqFu4YOWT6gn1pGDrCJl12m4jks6xGCgTmbL2YJJ4czyWc9Bb3Ll2aZKX8SeIim4x1wha43FfTzW3HDvaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Xagr/eZchQRI14iLDRZfXX75lm+v2is59rLScGatZM=;
 b=jy0B4U7VmC4Q53Z84WwrPHCFa0YgJaMS5i5vrSPsIV+/BR9HAmcAlvshffYJNrJlYR0JNh3PfnWx297qNtze3zDRu1Fiq/cgJBImmt7dJyvEhjZ1RudXB+hhI8dgzsm3nAuGdQzjaOgbRuq34BYXvgq0ZUJjHwp9kAef/s9Kr8dVAARz6zQAtQApKRheSQ90eFS60yl/ehi3QYyrM7oMtEbkpKsWAubQUKo29XHgU58l3/rCeKHA902XIVyhE6wPE+M2OPBthk0ax+3I+HO+Zu61TVAzwi+WOGg59lWgG4oH9teHrO9SjJn3Cwi8M00lZT7kIk6UD6aUtrEKXy0liQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Xagr/eZchQRI14iLDRZfXX75lm+v2is59rLScGatZM=;
 b=lsIoJ+HFlrhh+WVHpfUDkVc1nm7WFhhV8YQzX5+Jm9xpALT8dpcj39W9fp3Fb1LSxIF2CugaTp6znSHVrX57vhqYDlzLxojh9k/G+61wPuo3IYfFgnjvjvO0CqagogYLLylce8U7edz6W6yAPg67s7ujLeqFUQ/VtfVsMcvtU9E=
Received: from AM9PR04MB8211.eurprd04.prod.outlook.com (2603:10a6:20b:3ea::17)
 by AS4PR04MB9315.eurprd04.prod.outlook.com (2603:10a6:20b:4e6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Mon, 28 Aug
 2023 09:14:16 +0000
Received: from AM9PR04MB8211.eurprd04.prod.outlook.com
 ([fe80::3df9:f31a:be7f:4b97]) by AM9PR04MB8211.eurprd04.prod.outlook.com
 ([fe80::3df9:f31a:be7f:4b97%4]) with mapi id 15.20.6699.034; Mon, 28 Aug 2023
 09:14:16 +0000
From:   Varun Sethi <V.Sethi@nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
Thread-Index: AQHZ1ZRNognu21NiNEqcymppfWTOnK/307kAgAH3e4CAAAqTAIAFZ0EAgAAQ9YCAACSNUA==
Date:   Mon, 28 Aug 2023 09:14:16 +0000
Message-ID: <AM9PR04MB8211928A3F7640A4684871ACE8E0A@AM9PR04MB8211.eurprd04.prod.outlook.com>
References: <20230823073330.1712721-1-pankaj.gupta@nxp.com>
 <20230823073330.1712721-2-pankaj.gupta@nxp.com>
 <20230823124340.GA2022486-robh@kernel.org>
 <574e93da-ec74-f1a2-7170-c16bb225a2bb@kernel.org>
 <2023082422-proofing-dispense-1a1a@gregkh>
 <AM9PR04MB8211D170F1D484E083C8F899E8E0A@AM9PR04MB8211.eurprd04.prod.outlook.com>
 <9f983d06-e82b-e572-e007-18d39c15ead7@linaro.org>
In-Reply-To: <9f983d06-e82b-e572-e007-18d39c15ead7@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8211:EE_|AS4PR04MB9315:EE_
x-ms-office365-filtering-correlation-id: a3784325-8c86-486a-b6b9-08dba7a72720
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xtEW2RLNEoWsAqnrbp0fuoqQHvtx3352daAJevrz8zCCgj4ZRvOIrSSGnxAhOgR6PTmwBLMxxGd9TLvmGvzD82ncLUSy9L8kJHdfeYcQu3DAUjabQiW9o9uDXspLkCuevSXqS8tWJ3dMX/Lukmkcpyj0AKDgPsJyyz6lSkYK4jiJAguVDr0a2B5h+qrfORLyees6082ramuWxdO8lOnWtpPj6EB+5XvzXj4+IBoru7xTgWCmJCL4ghqD22/QIAc3N4xAHSjqJnRc0kHQyXF6n91p2cOgkZku3uhXI+HN5Vnzt2rYPLgxpWp/ShzpHov8eXsREI56r+xvPW0w9Ldk0rnJHffslGkKh1n1zbBVd3XbCjQRI/7zqIUR14HfhvL2ey2Coh3BBfee+DHWgBdyDy8Z6BqJg+YHKEd3M7QNYu05nsiapXJ2y2sq48/40d0ABtWZJ7rD1Uf8RH6s+fWFyaGtVP36I0o6GrJqAo2/cP0F84OCBUqlnxZCs/H1xVI0ytOd+zfouSxUu57RjyLcOemrgqNC9vU8hRbVn36W7puSZUaLyy0z2FPspOp6P6wrZPL/6fQng9vyVfAK9KtI9zJI3WX1KIMV7Ktwke/q6v7WCe0c8ZZm+cI5NBhd9XUm
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8211.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(39860400002)(376002)(366004)(136003)(186009)(1800799009)(451199024)(2906002)(5660300002)(38100700002)(38070700005)(8676002)(52536014)(4326008)(122000001)(99936003)(8936002)(7416002)(86362001)(33656002)(55016003)(966005)(26005)(478600001)(7696005)(6506007)(9686003)(71200400001)(66446008)(83380400001)(45080400002)(76116006)(66946007)(41300700001)(54906003)(66476007)(64756008)(110136005)(66556008)(53546011)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QbQKIKZJrbRNQeetPTpOhAglV+9QmxGm+jgQRN4Jq4Vc0/pitYd/lw95HWa3?=
 =?us-ascii?Q?j22FWzYpJ+VytRrz27LCWgsTHIz7EYMDJmQJiDf1FS3QHz1KVgAXOQWDwGCv?=
 =?us-ascii?Q?/6XzUMnReO9f0tBaAmV0EguH5zPakhNZMUu8jBXvZrs8sq28zZfMx1mR/t1N?=
 =?us-ascii?Q?2W/wQnbbu2i7kqK9PvZbcjspKmhHIhmPCt87wNzGcrSAGdS8JPV1afRHrsx4?=
 =?us-ascii?Q?emkJgjY8xNLKjDfJMVNdJcYyPlJhoo7MtHnlNN3/U08QnnWJod9C+80E0Yiv?=
 =?us-ascii?Q?KRgoooQYmf/sDwzcmkjobrru/Kj+0TvEnPlCFrira2boMDg2yCeK0QlgoEl0?=
 =?us-ascii?Q?LVh4SYoOb0TR1SqnNklfT5eIr6HglMaqeVf2CbWmJrSltnL0Ggmq62QdDMy0?=
 =?us-ascii?Q?I9PNY8EQv83zbURDbqWDCEp04NvXz7wuGA81TVd01i99jM/Z8lqOVoUL9pP/?=
 =?us-ascii?Q?BSM2lLrZ7IXBnZAIcTjpcCli2sjRpPgJ7H+vsVQ8GDshcJKkKQu3EXYNPOR6?=
 =?us-ascii?Q?nnBBkdRagrACm1ThOjrIrnCI00oZ344aUZaXKnqgGXOC2Gubsej5dnu/Rskq?=
 =?us-ascii?Q?0L2JlkWBEW9rifznmKJaMosI67m0z3tExC582vC81npuiBW8y4QCvu89hCpK?=
 =?us-ascii?Q?uhNZ2UFSGORyI5TorClTdi12+yqfF70zylncbzPLzrWBCkOBu9MkPU8wVvO4?=
 =?us-ascii?Q?SSxix9lLMXGoVoYXgFTvNMb/9x0kd+L01nvVUd3enVYhbgKRv/61/rfJ6QU8?=
 =?us-ascii?Q?UMd4m64eXkm3+PJZccsE/WaG+5KSOTDKUnv17Uq4zXhhuqyiV/tl6AmAo5WV?=
 =?us-ascii?Q?0Gli5jdvUmWTH65a6phMNuIluOGo9V9dmZ3Y1oHBPNMu5PExJu4MWdYz90UH?=
 =?us-ascii?Q?VhoB6H2Uqg16wSYdolc2Yy6D217yQMwSw3R6f4OgtS+qD7WvxR4VC48gtEZO?=
 =?us-ascii?Q?f2cUT/c6Dvedw+s7XXX4HjJoPqaneX47MG7tXX4A6JFKlE2wOlh8Gr2+nqTe?=
 =?us-ascii?Q?b9EfSIzj+FGE5qVbiEsn3wE6FrX2plQPaDQm/kYpyQJGTqLbCFJ1l4IZsF1n?=
 =?us-ascii?Q?/nvgm/uFuI4Y+1jJASi15Of1cjRXZ2dHdxLT2iUm4UnbMqbuhXveBjauA0jc?=
 =?us-ascii?Q?Uu/fIN7gxL9EzdAZee4/Pyi9sTrGGGD94108ocD6kru1XNQ58Gog+5O8HTCB?=
 =?us-ascii?Q?TmtEEpuOATyfJbcRQ/2hdIW1wq0A+5LpEvKek5mihcnuYPa8bnGs6S8Pz3It?=
 =?us-ascii?Q?NNhw3BG+Rg1FLIChvw4Wk+gNs3P12nj5EN1ncVmn8AsaJYz+URdF2BAa5laH?=
 =?us-ascii?Q?s5Yd2tTxB0/v+9znZCpLUyZCfIbpkFePWk2u4sKVIKaJexiwRRY/VHSBYgH9?=
 =?us-ascii?Q?BdBwBdVKLzn2Np+D+SSQZJT6shc7vrE4XWUZWzTSFMb5BZ0I4A973EqA+ioL?=
 =?us-ascii?Q?GmwdysXjKngPyUfFd9MFTiI7wUpBZMwuyKS0ZPgjGhfD5I7SEv8ezzyBFzOA?=
 =?us-ascii?Q?6dinxLZ5/mtFAzh2MR6jfUQuUnlHqVnmun06s08FIfcGKQSMMBdsoEuH6vQV?=
 =?us-ascii?Q?KOUBLzufmYNOME/XBzU=3D?=
Content-Type: multipart/signed;
        protocol="application/x-pkcs7-signature";
        micalg=SHA1;
        boundary="----=_NextPart_000_00EF_01D9D9BE.1C5D7200"
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8211.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3784325-8c86-486a-b6b9-08dba7a72720
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2023 09:14:16.0520
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NTCjlk6hFw7/D0Eqtn7M+6Zem03c4B9EAX3NYlL/H7vECto/ynWpADgimpQC+5jT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9315
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

------=_NextPart_000_00EF_01D9D9BE.1C5D7200
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Krzysztof,

> -----Original Message-----
> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Sent: Monday, August 28, 2023 12:25 PM
> To: Varun Sethi <V.Sethi@nxp.com>; Greg Kroah-Hartman
> <gregkh@linuxfoundation.org>; Krzysztof Kozlowski <krzk@kernel.org>
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
> <sahil.malhotra@nxp.com>; Aisheng Dong <aisheng.dong@nxp.com>
> Subject: Re: [EXT] Re: [PATCH v5 01/11] dt-bindings: arm: fsl: add
imx-se-fw
> binding doc
> 
> Caution: This is an external email. Please take care when clicking links
or
> opening attachments. When in doubt, report the message using the 'Report
> this email' button
> 
> 
> On 28/08/2023 08:00, Varun Sethi wrote:
> > Hi Greg,
> >
> >> -----Original Message-----
> >> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >> Sent: Friday, August 25, 2023 12:54 AM
> >> To: Krzysztof Kozlowski <krzk@kernel.org>
> >> Cc: Rob Herring <robh@kernel.org>; Pankaj Gupta
> >> <pankaj.gupta@nxp.com>; shawnguo@kernel.org;
> s.hauer@pengutronix.de;
> >> kernel@pengutronix.de; clin@suse.com; conor+dt@kernel.org;
> >> pierre.gondois@arm.com; Jacky Bai <ping.bai@nxp.com>; Clark Wang
> >> <xiaoning.wang@nxp.com>; Wei Fang <wei.fang@nxp.com>; Peng Fan
> >> <peng.fan@nxp.com>; Bough Chen <haibo.chen@nxp.com>;
> >> festevam@gmail.com; dl-linux-imx <linux-imx@nxp.com>;
> >> davem@davemloft.net; krzysztof.kozlowski+dt@linaro.org; linux-arm-
> >> kernel@lists.infradead.org; devicetree@vger.kernel.org; linux-
> >> kernel@vger.kernel.org; Gaurav Jain <gaurav.jain@nxp.com>;
> >> alexander.stein@ew.tq-group.com; Sahil Malhotra
> >> <sahil.malhotra@nxp.com>; Aisheng Dong <aisheng.dong@nxp.com>;
> Varun
> >> Sethi <V.Sethi@nxp.com>
> >> Subject: [EXT] Re: [PATCH v5 01/11] dt-bindings: arm: fsl: add
> >> imx-se-fw binding doc
> >>
> >> Caution: This is an external email. Please take care when clicking
> >> links
> > or
> >> opening attachments. When in doubt, report the message using the
> >> 'Report this email' button
> >>
> >>
> >> On Thu, Aug 24, 2023 at 08:45:41PM +0200, Krzysztof Kozlowski wrote:
> >>> On 23/08/2023 14:43, Rob Herring wrote:
> >>>>> +                                                          |
> >>>>> +  +------------------------------------------------------ |
> >>>>> +                     |             |           |          |
> >>>>> +  userspace     /dev/ele_muXch0    |           |          |
> >>>>> +                           /dev/ele_muXch1     |          |
> >>>>> +                                         /dev/ele_muXchY  |
> >>>>> +                                                          |
> >>>>> +
> >>>>> +  When a user sends a command to the firmware, it registers its
> >>>>> + device_ctx  as waiter of a response from firmware.
> >>>>> +
> >>>>> +  A user can be registered as receiver of command from the ELE.
> >>>>> +  Create char devices in /dev as channels of the form
> >>>>> + /dev/ele_muXchY with X  the id of the driver and Y for each
> >>>>> + users. It allows to send and receive  messages to the NXP
> >>>>> + EdgeLock Enclave IP firmware on NXP SoC, where current  possible
> >> value, i.e., supported SoC(s) are imx8ulp, imx93.
> >>>>
> >>>> Looks like a bunch of Linux details which don't belong in the
binding.
> >>>>
> >>>> Why do you need your own custom interface to userspace? No one
> else
> >>>> has a similar feature in their platforms? Something like virtio or
> >>>> rpmsg doesn't work?
> >>>
> >>> +Cc Greg,
> >>>
> >>> I doubt they care. This is some stub-driver to pass messages from
> >>> user-space to the firmware. The interface is undocumented, without
> >>> examples and no user-space user.
> >>
> >> Great, no user?  Let's delete the code then :)
> >>
> > [Varun] We do have middleware applications that utilize the driver.
> > Following
> > are the links:
> > https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgith
> > ub.com%2Fnxp-imx%2Fimx-secure-
> enclave&data=05%7C01%7CV.Sethi%40nxp.com
> > %7Ceda172f10a684cc926a908dba793b776%7C686ea1d3bc2b4c6fa92cd99c5c
> 301635
> > %7C0%7C0%7C638288025110398317%7CUnknown%7CTWFpbGZsb3d8eyJW
> IjoiMC4wLjAw
> >
> MDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%
> 7C&sda
> >
> ta=jJ%2FZl1myldPaciswIps2dDuuzp%2BqXGZDnvh07yD%2BEFU%3D&reserve
> d=0
> > https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgith
> > ub.com%2Fnxp-imx%2Fimx-
> smw&data=05%7C01%7CV.Sethi%40nxp.com%7Ceda172f1
> >
> 0a684cc926a908dba793b776%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7
> C0%7C
> >
> 638288025110398317%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwM
> DAiLCJQIjo
> >
> iV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=U
> VjBwmzZ
> > myHu%2Fmy6WZiQcz2qksA67W1BtwFIJ8%2Ft7nQ%3D&reserved=0
> >
> 
> Why this is not explained in the cover letter and in the patch adding the
> interfaces? You still need to document and explain the interface.
> 

[Varun] Following information would be added in the next version of the
patchset:
1. Details of the users for this driver.
2. The ABI document would be enhanced to provide information about the
interfaces leveraged
by the user space middleware applications.

Please let me know if this would be sufficient.

Regards
Varun Sethi



------=_NextPart_000_00EF_01D9D9BE.1C5D7200
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
0AFf1s7L0t5hZZEAAAAAAAA=

------=_NextPart_000_00EF_01D9D9BE.1C5D7200--
