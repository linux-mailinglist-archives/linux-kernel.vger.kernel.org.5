Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6259078BBC5
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 01:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234422AbjH1X4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 19:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234367AbjH1X4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 19:56:09 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on20621.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eaf::621])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 715BC13D;
        Mon, 28 Aug 2023 16:56:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b4eTY3MePcH8h0D2OfxDsE9hIAsMJ8tiSLhVfhuEtab6+v6jUn1X/ZBzSdXwu8FT/JfJUnXYq6Vkkl1/tuWKHg9IiryARLY0k2+vr/3wMovvcUyohcPEHM5kAyu8eyRLzgizOItoHT235DIVtR8BAZwMAueXrtaV1PQOHtiVrsDXUhgXx5trUX+sWSvyS0mOVkbf9pN7iKW+DhaK9Nt7g68wSOQdvaC+mP9qMCoxKQNXP5Q3taxDR+xFCTPHtgFWRElAdbsD072nO7RFLRHSohgacpl9BS4AH0GipxEVcENSQ0yYokdeP3nM3bp676UxhOJmYcDaY2JaBGl6PC8F2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RK9wxc0tzxGCqZFSfkDJFumBNmZHNhqVbAXAmb/7Y8k=;
 b=fTUofUX0nP7ElZGbNdXjRTdGIdhh9nUAhV5Y8BG7fz4pEkBec/V4sK6+zri42Cx/tN2djJ0U/mW/Ce2SGLghuaTMwcaSOfEM4oxSyQlFdQLRUkTyQgGirVO1/JF01MD/JviIs2xgb6CUwcSOYgDbvh2ZMkouicOa7p5YyACeUu6i4L+6fuByANCnJu8OSr263wraTiCvLMfMrK0oGVj/hVttiVT059glWCyE/SQpbNg8LiZBRx07SahyHySwqNcbUcBT665SqrzcAIkw0AOLUiNPj9RNZT2HOl6tJPoVuS/X88ju/4VR3MrvrPeHXo2uY4p+2E4PT5IlBJCJWeHgeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RK9wxc0tzxGCqZFSfkDJFumBNmZHNhqVbAXAmb/7Y8k=;
 b=o7Db/Pu6gyDmCI+d6+h2lK8gJBsyMOOtProhIiRr0JWcHwr8okYvxRy9+gjRv5uY6Erbzw3G8s9kK1wMqpfrc0w53XgIpK30ZDjvYduAGT+4Lf4QtdDv127Z4nIm1L5z7Ax2SFE4BmfiIbu0pXTFdB0KrD/Y6jXgIrVbJHYbGSE=
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by AM9PR04MB8858.eurprd04.prod.outlook.com (2603:10a6:20b:409::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Mon, 28 Aug
 2023 23:56:01 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::693d:8782:eae1:2460]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::693d:8782:eae1:2460%4]) with mapi id 15.20.6699.034; Mon, 28 Aug 2023
 23:56:01 +0000
From:   David Lin <yu-hao.lin@nxp.com>
To:     Francesco Dolcini <francesco@dolcini.it>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sharvari Harisangam <sharvari.harisangam@nxp.com>,
        Pete Hsieh <tsung-hsien.hsieh@nxp.com>,
        "kvalo@kernel.org" <kvalo@kernel.org>,
        "amitkarwar@gmail.com" <amitkarwar@gmail.com>,
        "ganapathi017@gmail.com" <ganapathi017@gmail.com>,
        "huxinming820@gmail.com" <huxinming820@gmail.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>
Subject: RE: [EXT] Re: [PATCH v4 1/1] wifi: mwifiex: added code to support
 host mlme.
Thread-Topic: [EXT] Re: [PATCH v4 1/1] wifi: mwifiex: added code to support
 host mlme.
Thread-Index: AdnPR2mvHOQJHhM/R5inuXZ0d62ZCgH9B74AAJU/fRAAAdHxgAAcxruA
Date:   Mon, 28 Aug 2023 23:56:01 +0000
Message-ID: <PA4PR04MB9638E9E042C248502DAE810DD1E0A@PA4PR04MB9638.eurprd04.prod.outlook.com>
References: <PA4PR04MB96386B2937FE0F7BD0BFAEB3D114A@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <ZOh8deIyeJMZAs7u@francesco-nb.int.toradex.com>
 <PA4PR04MB9638EAED5E4361F0429A796CD1E0A@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <ZOxyeTdEXgxVZzAF@francesco-nb.int.toradex.com>
In-Reply-To: <ZOxyeTdEXgxVZzAF@francesco-nb.int.toradex.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9638:EE_|AM9PR04MB8858:EE_
x-ms-office365-filtering-correlation-id: e0287724-0135-47ae-f82a-08dba8225513
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hovFymGqDHK7u+nqTOiJsWYgrmobueSTfTlLUm1qiz+USy/X/u5zvcqF3DN2y4cBwOTSz9mLTMexDVETzDqwxbEMfWXhafNIpdJSaZ1pZbWXasoXtud+b8f25MwIjXcLcYF8OcZgqUPn071DQyUmC3yIV9kbyhwi6Vx6IEPmCmxU+t7Gc2WE9MhuacDXyq+cMhHcKUbJxwXBgmtMnI5MHmDy/9nzhm0qgKMX5rRBYybYs6asB2aIAc6L1ApgFBCwJF0oO6ZKmMfu8BUL2arlkukdknMJGKAt8gtDoP5PlciE33JZo7ebtn5Hrme/GzadVdGeqYMjUiI4vTNdo61b5nsjMd6cSTwEDhwFlvlyYAcAORSTgQEzta4r7zsVwyLoDCQh+dlNsEElaIfi61ePL8aOsFkYo4J44QSF09e9AHUeJeww3siFe6q4zM64GmPV5zhM4oYJYXh9kGz1BYVigEbf+8DfnT1RLlnOpTwVKCOaaXRpv5P+uGaEyScpfSjUAJw8Me6sTVygBtQl5wQISlKqah8X7SVy6DXR5hLRhqo+xV2MetafYKCDWiIhSnY3n5jU7jykU0D34Fxi3bqL/a9ZNX+2JJRCM3oIa/n94znVY9Ct4TF4aMfOqVigSevX
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(39860400002)(136003)(366004)(346002)(1800799009)(451199024)(186009)(8676002)(8936002)(4326008)(316002)(6916009)(2906002)(54906003)(64756008)(66446008)(33656002)(66476007)(66946007)(76116006)(66556008)(5660300002)(52536014)(7416002)(41300700001)(7696005)(6506007)(53546011)(26005)(9686003)(55016003)(38070700005)(38100700002)(478600001)(71200400001)(83380400001)(86362001)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jyIa5WFYNnvtvXQIgw/ZCh/5pTv/l8C1Ndzjs+S3WL3HQhgTJQIpTmSDtx5t?=
 =?us-ascii?Q?gfL3WwzSaXmhtYWVVyipSA6TEuTOoaXlLYgbH/VLR2e9lV7gx4bB0e4BY2nR?=
 =?us-ascii?Q?Izt4swHTj8feSfbW1knTdVwKcZl5HenlvGaO+ReLQcz3tdyM8TrepoWsdHVY?=
 =?us-ascii?Q?7xeAjaizX91yU3DTFstyqkD30AzIbI9M4dm4a7wCHgoK3C+gPp1dypROb2Vz?=
 =?us-ascii?Q?dYqf7fHgLuocjlKbqXiw1ArO0jH7db8BPS0VG86s4SOVsjv0S1VknH3AgsfX?=
 =?us-ascii?Q?ufnGv54nTaSvGxB9LkSl2rOl9RxWGk6gITQc2SlLIpYCSDdBtADTJVM10njI?=
 =?us-ascii?Q?i67J1t0iuzBPVtCzIxMs8+ONqsHtvSzrjdk1DuGm/sSk2rjFUn6NKEb3jQsr?=
 =?us-ascii?Q?8nC/BeVgNWHWWToP2L0tQVWF2T0XVK7mPemHjzZpcTnr+AG0XQy1r/ka8UjJ?=
 =?us-ascii?Q?SRchSzl6r021qDE0gYgccvBXrTxsT/GBuqzWihuu2e9iD4S/n8occBOjEh4d?=
 =?us-ascii?Q?hsEGPNRFFaDSf6Q1iyFs2eRPz8u3HIptkGzucs1bnyIvQpGUdY0a44VXYYNo?=
 =?us-ascii?Q?Rb4rfbgJDvzuXVVx/1X94kXR6RolSEfSq8VpQbqeZByfpUYt5XEC1+9qLnqg?=
 =?us-ascii?Q?slaDOOHpeLOOPTRTK2IgiXyZvwW/Gpq4dkU/Bq7j16sBwG19GvfKbe+e8SnJ?=
 =?us-ascii?Q?lwW80CEzOOAJvx1nleTQwkjiWFyC+esnae5CJKECNt1l+RoZ3kwZ3D7934YA?=
 =?us-ascii?Q?0TQ7voPFKP3jdEud0g8/vLR1QrZJigYi8ixbBDUwD1M6WZIZtvLNINXOpUJV?=
 =?us-ascii?Q?1Q134Pp6+D5voNrcWHPBbCOs9/yParngFS6VNe/8P/va3nN67kR7HoApKxcL?=
 =?us-ascii?Q?hAadEDmbmZWJIfYqmgTWR+UrAhFIYPKF6zmg+VMlCEyvVmdL95lXQwrKQCPM?=
 =?us-ascii?Q?0G5rTJRczAdd9FcNluL9DY1QjP3vHGWOdoM3WSaVaTMMGw186VJ973ygXtnS?=
 =?us-ascii?Q?cowzcV5wzDGIIORMADuQfa34GjmWV9fYodrS9K9PfKII2JUtyglJOEYtAYV3?=
 =?us-ascii?Q?t/vnssSxWY8FK/uZHya1qaH9LvZ0J9EqrahRRet+uBz47JsHyrusaD+lSSX0?=
 =?us-ascii?Q?DvvCug4EgZ34/EUPHFRzgDxcICQWfGLTkSI7JOCTS6s2A0XpNzvK3Q7Ur8TT?=
 =?us-ascii?Q?JyOD6QUnhGzlyOKvdS/0Uz/6oA6MpIyZq9ShcgquV3uFchTHCmED6KOaoZqG?=
 =?us-ascii?Q?aVe5IE1yuIVuL0iyrB5iWZ0pUiikFNYX3QqLv/sTP20KdZqpuN0z9Fg1gVfM?=
 =?us-ascii?Q?M/8l1QTkPuK61HnoTvQjk7NnsIN4mgxuPBPm9paFMLCxtDivCWdAed1f/FbV?=
 =?us-ascii?Q?ISXY1BL6BafD2M0MbFysyw2QEqGytR5EJc21TiYElhkpT3WrNFtSl/77JfME?=
 =?us-ascii?Q?SBG1zUhkBCnNtHbAhU4O+lp39yI2/JbsfWB/tL2+Il6nAYWy9ZAvI/c5Xsg2?=
 =?us-ascii?Q?MyLVgNnONU+KKMGcsFIVfKxLI4r4n71v0wZDS3+rfsLdt5mW4YiARG0TRAUy?=
 =?us-ascii?Q?YjL3mhwIINRrZ2Il6otAHWImOBn9gKTW9IoQ4vQJ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0287724-0135-47ae-f82a-08dba8225513
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2023 23:56:01.2182
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ctB7KfxFMPlvE++BHrTu6KIhA78FqHIQnLL8vgnj5FT8/yc0SI9+XoF+lLNq9VUiXUKdDcRhgrNTB3o5NkMhAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8858
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,T_SPF_PERMERROR autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Francesco Dolcini <francesco@dolcini.it>
> Sent: Monday, August 28, 2023 6:10 PM
> To: David Lin <yu-hao.lin@nxp.com>
> Cc: Francesco Dolcini <francesco@dolcini.it>; linux-wireless@vger.kernel.=
org;
> linux-kernel@vger.kernel.org; Sharvari Harisangam
> <sharvari.harisangam@nxp.com>; Pete Hsieh <tsung-hsien.hsieh@nxp.com>;
> kvalo@kernel.org; amitkarwar@gmail.com; ganapathi017@gmail.com;
> huxinming820@gmail.com; davem@davemloft.net; edumazet@google.com;
> kuba@kernel.org; pabeni@redhat.com
> Subject: Re: [EXT] Re: [PATCH v4 1/1] wifi: mwifiex: added code to suppor=
t
> host mlme.
>=20
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report
> this email' button
>=20
>=20
> Hello David,
>=20
> On Mon, Aug 28, 2023 at 09:30:08AM +0000, David Lin wrote:
> > > On Tue, Aug 15, 2023 at 07:09:25AM +0000, David Lin wrote:
> > > > 1. For station mode first.
> > > > 2. This feature is a must for WPA3.
> > > > 3. Firmware key api version 2 is needed for this feature.
> > > > 4. The code is only enabled and tested with IW416.
> > > > 5. This feature is disabled for other chips.
> > > >
> > > > Signed-off-by: David Lin <yu-hao.lin@nxp.com>
> > >
> > > I think you are missing a few of the comments you received so far.
> > >
> > >  - verify the recipient list, the list here was likely generated with=
 an
> > >    old kernel tree using an outdated MAINTAINERS file
> >
> > I followed your suggestion and issued the command on latest wireless te=
st
> repository.
>=20
> Weird, you should have Brian Norris as recipient.
>=20

Maybe I will issue the command again for next patch.

> > >  - you need to provide a changelog in your patch, otherwise is not
> > >    possible for other to review
> >
> > Yes, one the cover page.
>=20
> Whoops. I missed this since I am not cc: on this series and just found it=
 by
> chance. I would have just expected to have the changelog together with th=
e
> patch and not on the cover, given that it's a single patch.
>=20
> Sorry for the misunderstanding, I would appreciate if you could keep me i=
n
> CC from now on, thanks.

O.K. No problem. Thanks for your help.
>=20
> Francesco

