Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E21D780649A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 03:11:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376556AbjLFBtd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 20:49:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjLFBtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 20:49:32 -0500
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2045.outbound.protection.outlook.com [40.107.247.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED9C51AA;
        Tue,  5 Dec 2023 17:49:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PvSK+tJvYLIWednmPMRvTGojWy7MXWEH/MOKYXHl8IUD2wOGWZSQ8bK2WjjgDX+PUodo3NCCnrLmB1Uf2Xmq1dvOA9vfudLJgbDTi2IJZgApT5RqhOyUvdbKK6Siepj80nBx6bVLGVoTk6Vzsy2F0YVwZ5lNEPcOg5KARzoZYMhSkFbJTuNQjSD+jdQ6wJ/l9IuOACZATgTUSweZquZ+gry7dweVHD2wd8C99DM8LVSbMHrjcJNaper5aHPWaBWFIlASGkXPICeBAtNNkGomIuBYYU0dPLkUDBTNYA7CeAsOeyDlDShbfq74/JH1eRjQ77Xk5Z1fxzNQK5eKRM/IEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6F47MIrjxAU2QIwCv45okn59g2XwUWaKijM5SOaAf7U=;
 b=SNcefvwOXujVzZjX+hQ3tZvo/EWubO2lHFTbtdwe8daUSCyG6oUyrDahXb1P5fOsYi6MdPFbblg0iBarY66rqSt4VmBn7ViLP5ilMAtD2mqalG7g+JSkKOPK0LQY1hPCv07gFGwWmrbPKEk1lHprflew/yBVTtgWgwh8x7JpHwtm7jiO2H2ZL31zTtPb0kV8lh7UE/F6aGx2y8WpJpoXRJNUwbKGZdqzPHzEJgrgBrpxjS51BTttsfldSZM0E0Dgl8ZknZ13j0+yclaz7d9Nch8BWQ2u+bFtCRTrcrQw1VqU1UrA4r291E3pxjet0S28Ae1T7lphKP5lDRAowD6dNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6F47MIrjxAU2QIwCv45okn59g2XwUWaKijM5SOaAf7U=;
 b=grYKTf2QPMcYmWou5L0XmJpyTCf7Im5MtJjOQ0yfwteuTDWY3fFUaAAjH/ikZWSbCSwLJU/tqX/wTKLypqoX4mzOtgxH35IZAbzZlqAx3PDTEuFDrtPoEeh7DG0da1Bki5FJXWK1fnmS3DCDCNX+EtQhMbVfd0YKMiVYmyjfCt4=
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by AS8PR04MB8181.eurprd04.prod.outlook.com (2603:10a6:20b:3f5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.24; Wed, 6 Dec
 2023 01:49:35 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::34dd:289e:9e8b:9c9b]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::34dd:289e:9e8b:9c9b%7]) with mapi id 15.20.7068.022; Wed, 6 Dec 2023
 01:49:35 +0000
From:   David Lin <yu-hao.lin@nxp.com>
To:     Francesco Dolcini <francesco@dolcini.it>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "briannorris@chromium.org" <briannorris@chromium.org>,
        "kvalo@kernel.org" <kvalo@kernel.org>,
        Pete Hsieh <tsung-hsien.hsieh@nxp.com>
Subject: RE: [EXT] Re: [PATCH v7 00/12] wifi: mwifiex: added code to support
 host mlme.
Thread-Topic: [EXT] Re: [PATCH v7 00/12] wifi: mwifiex: added code to support
 host mlme.
Thread-Index: AQHaIdVRwVjPeSM2JEKuatsKwEyar7CUVRkAgAC6w/CABhQEgIAAZSfw
Date:   Wed, 6 Dec 2023 01:49:35 +0000
Message-ID: <PA4PR04MB9638E7962C38BC839F1E2826D184A@PA4PR04MB9638.eurprd04.prod.outlook.com>
References: <20231128083115.613235-1-yu-hao.lin@nxp.com>
 <ZWnIMGytEdDCySS8@francesco-nb.int.toradex.com>
 <PA4PR04MB9638E6F1128DE4ED977E0D07D181A@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <ZW9+Iz9a3tEv3CpM@francesco-nb.int.toradex.com>
In-Reply-To: <ZW9+Iz9a3tEv3CpM@francesco-nb.int.toradex.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9638:EE_|AS8PR04MB8181:EE_
x-ms-office365-filtering-correlation-id: 81c7f5d8-5219-48b6-4f70-08dbf5fd9993
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pesOtiSSnYeEBjcPZUg78Z7TnHcvCuqjGeVAht20JPoVJFc5PEXykAkCg21iCssZq1EuvPnhFAuBH0S10Nd+WfpqW6I//X4Rs1E7EhBxtYIpoUCoEPrycwEFKjmrNCRXj3z1nYjok8aEJ7k+rqBgQweMuu+9Ig5gW/VZi8WFp64VSXLh4hGO4ULaWJVHy6epCLu5CzRqigffTPvOV7NPB7slnUsCg8MRNUsoMO+Oul79HTYdFdjHkfMvwKAQDXzZNI+nENDSInQcFNfi/pOjJpulA8hAe5gqupddR//3mgC+Py+bvMkd0IzTdfDYM9fKBInHR0a6BiO8OaNOoqXpXpDbduJwkteaZcGzIvf3VadD1KlzE93Jto8p+nIcu8CCRhEBvxhY8rULV5z+NtVrSPKRAJL8OBHbsM1C7JlJEJZuaar42vlvBZiErPc/v/c9q6sVMFFqR7Xm/nYy5j6svPmuyjT+PGqZXIuLQnAb0TaH9rt/cjEaDz7KWIfEyc6Nt7GuFPJnNiD4SEM0iMT3gWzGNaHDfE4p6Gf8wR2W7OlUoky76+6+gsSYUvakXkBuc6NRJbQu82249DQgxj4b89uKe2u+Bq2qHIreYtuBHKpHcG0fqkgMJVyVxTBnHjLXHJxcs5177vGgnmBPGtxkMzGDVuaWdGCJ7sQY85qBM1c=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(376002)(346002)(366004)(396003)(230922051799003)(230173577357003)(230273577357003)(451199024)(186009)(1800799012)(64100799003)(8936002)(8676002)(4326008)(7696005)(6506007)(53546011)(52536014)(71200400001)(26005)(9686003)(54906003)(66946007)(316002)(66556008)(76116006)(66476007)(64756008)(6916009)(66446008)(478600001)(41300700001)(38070700009)(5660300002)(2906002)(86362001)(38100700002)(122000001)(33656002)(55016003)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Zur8bME9BAkymyycFqpbTxU0FwKNGlCrUIIAZLw48CyEqkaP6d9s0m9qaga8?=
 =?us-ascii?Q?PjcT2tKEkQNXamLImNRGocA6/phZPuUoc5DHf4bwVnpeVO5auO/lwZcVh4Vl?=
 =?us-ascii?Q?k7czIZXOxPnhg4dl94kJSheQdUzHtZ+640gn9qKObSmrSgKSQojBsLyqTyLy?=
 =?us-ascii?Q?oL3PCQrHuQPlOmb9ugSWdOSO831ZZHqB62qC46Q4bVPsMFgChbFqR+RCVpxc?=
 =?us-ascii?Q?qhvQyhohQisNGhQPzO7+86YFleo1LXVpYO0eXfCGAYxG07Q7iIe0u+Ui1qSb?=
 =?us-ascii?Q?1ScZ4aJOqcSNgHfGUrA+izeu/N1Y6HMGUuEtGTanlaaJHVJ9Gf0DqUKQVqj4?=
 =?us-ascii?Q?qNZbBpVYBviwxJFCgAAYpZElgeoWQZKzsSqUQnJZP0wbOLMG4EmxbvTayS3h?=
 =?us-ascii?Q?0JuuF5Y5ZjTfKa6Ibxi0pwfOLIOl1RNWjE9zwzpE/u0Fj72sKr/tDHcnhmnb?=
 =?us-ascii?Q?kM9WAh8lnWdr6+Er+o0jKDv+50+jUS8BY4Py5VaS0/t1wVi///5cV1VMOqoJ?=
 =?us-ascii?Q?8BrhfZCccGchjXBA47KmE9GOsB8qbv0jqYFVzI4ek2CaJIxie53IoPJPqHfJ?=
 =?us-ascii?Q?mBtaIuNRGJPTzWgzOHIXB+ttpiIi3mCHpwiToH8A8z5FdwjcM4n1Peua0ore?=
 =?us-ascii?Q?2sfvB0PEdoOIj1Pf3EhfCa8w3CfFETvFsjlJ/Nhr7tdiW4ZeIhaJO2iMH+Zu?=
 =?us-ascii?Q?sdKcj/ZqUcveBU/3805W4gwcbzivUOI2Av0k/z3OdeO4+mPaTJ8xrwWjyMpc?=
 =?us-ascii?Q?vTnEnhhmLmNvyU3Ulv1NrGy6Qirawi9jIJ35SsGIN1QWXavwoL6UWKcnHOi8?=
 =?us-ascii?Q?FekUBqsJHe67jR8a1mNHQ3MOM4AsehGoPIZ4sdZpbQEnHSzIJ828a+VqQHcv?=
 =?us-ascii?Q?f2GBiFMA5dLCbPxg7uxOcyFGVyGTU6cw+DX54Ih6uHT6qcLQpUsWFhZSrgyH?=
 =?us-ascii?Q?wTOdnvt3fUjGuL9dSmFAahzuZ1wLEcX27FYtwlB7iGpdcGUCT6vsCCxFBUPm?=
 =?us-ascii?Q?AkN8z9mWiShsMCdDVEK/SsVUzVnN+6gjBEvQ0l9aeoAJCq4LDlX6pWKw0Tkr?=
 =?us-ascii?Q?Y6ulDWtIbyfAK6tFvd4MmVY1b2GddFCrTPxU3gbPr6ZPSAXFzl2fRgt6SoEK?=
 =?us-ascii?Q?P+FfGkvuNE1RumNPoufN5Q7UsxKjM1kzv4n3UE/EjIap1Ut14AqwU/Jq3sco?=
 =?us-ascii?Q?muKqBWEqMIgTYf2fo5XqTDd24x3i/fCWSBHelfMoDKKfDZuUB4UlfIes/HE0?=
 =?us-ascii?Q?6fUdPUVvlLqyrCnQ//Xry7D4I26npl2QeX/HYKqm3JC2GQxUHo1BYrFl2953?=
 =?us-ascii?Q?RFUtwPYaI+zc0gY7mtWHgy45e0xqdAV+lzY2ZiT8u3X70W8oXvUVTK9SaS0U?=
 =?us-ascii?Q?yXHOoK2gEDpo4c4TJBFnGgP1MQ7c0+ss1M/6d0H+EkFoLPfc6P7hY/EYYIvK?=
 =?us-ascii?Q?6n4UhCuMwWF/HdEPpOF+64Hc1rSuF1lRh8u/YN4mAPt7CTV5elaFxYBOWgx6?=
 =?us-ascii?Q?Mw7MOUUma3dKeyENZYRUCOxp3id5QZ48Lyl3hLys6ASLwTUDg/2m37plP0Ci?=
 =?us-ascii?Q?tAOHE2pzEN500oDncsonz2UTnEMrlpUs0ul2Ci9C?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81c7f5d8-5219-48b6-4f70-08dbf5fd9993
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2023 01:49:35.4575
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qGOzyrMO1Ip3ci8EbUjSMd0Qke972NJAWc/ZhEGKqxsWJFKiS7P8sF5NEiLA0Rh4zsT2eN6zYAlIwk/3WzjBwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8181
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Francesco Dolcini <francesco@dolcini.it>
> Sent: Wednesday, December 6, 2023 3:47 AM
> To: David Lin <yu-hao.lin@nxp.com>
> Cc: Francesco Dolcini <francesco@dolcini.it>; linux-wireless@vger.kernel.=
org;
> linux-kernel@vger.kernel.org; briannorris@chromium.org; kvalo@kernel.org;
> Pete Hsieh <tsung-hsien.hsieh@nxp.com>
> Subject: Re: [EXT] Re: [PATCH v7 00/12] wifi: mwifiex: added code to supp=
ort
> host mlme.
>=20
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report
> this email' button
>=20
>=20
> On Fri, Dec 01, 2023 at 11:05:47PM +0000, David Lin wrote:
> > > On Tue, Nov 28, 2023 at 04:31:03PM +0800, David Lin wrote:
> > > > 5. Address reviewer comments.
> > > You should list the changes you did, something that generic is
> > > forcing the reviewer to compare v7 vs v6 to known what changed.
> >
> > Can I summary what should I do and hopefully I can make agreement with
> you:
> >
> > 1. Separate patch v7 6/12 as a single patch.
> > 2. Merged all other patches as a single patch for host mlme.
>=20
> I would suggest to proceed the following way:
>=20
>  1. v8 of this series should have only 2 patches
>    - PATCH v8 1/2 : add host mle station support.
>    - PATCH v8 2/2 : add host mle AP support.
>=20
>    Any kind of fix on these 2 new functionalities should be squashed in
>    these single 2 patches. No commit to add a functionality with a bug
>    that is fixed with a follow-up commit. If you discover bugs during
>    your testing this is great, just amend the original commit that
>    introduced it.
>=20
>    I am assuming that is fair to implement station and AP support in
>    separated patches, please speak up if this is not the case.
>=20
>  2.  PATCH v7 06/12: this should be send as a new separate patch, with a
>      Fixes: tag and Cc:stable.
>=20
> > So there should be no patch v8 and only have two patches, one for host
> > mlme and another one to fix hostap restart issue.
>=20
> It's ok to have a v8, restarting another series will be even more confusi=
ng IMO.
>=20

Thanks for your suggestions. I will follow your suggestions to generate fol=
lowing patches.

>=20
> Thanks!
>=20
> Francesco

