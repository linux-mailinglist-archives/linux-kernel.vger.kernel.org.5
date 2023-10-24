Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E91F37D488F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 09:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233548AbjJXHao (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 03:30:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232706AbjJXHal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 03:30:41 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2080.outbound.protection.outlook.com [40.107.104.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B816B7;
        Tue, 24 Oct 2023 00:30:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jUiCIbY7tdvtmXW0eWNmejhBtiEOlH/+1O4QNXXsH82kqtrQ5ihJiQK4TsMW7ivOa/WFYQ6VC2VZzCT9g0cSgUSYKk0lE8ugXWjg2qwV4EMnqLJqo7Hfn6sYAFOUxV5cTDYDeJ38ldoR+HlIVcoRJ8v8Rxm8xuBGdBNlFxlQ90munC7mss9IUwXc33NabjSrGFnz0/BBAYWdbZapd1a+jHpG27BfoxYzayIcJIUgXLBHfVC2bs/+YvlG/D9pLA07EgX28187l0z2oqiCuNXeTrxJRQfbfDiSlYV7vvRBhGLkNMMO2Zzm2O4FnOibP1Pi1vAfKmRGQsqbSgOmuTEPEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vg95xOSLw7pUY4MKR7rO/dHd17vxH5GpixtqGPnRKlk=;
 b=cFSyGMaVUBdzrzInFCPPozSemm8fqiRplF89YyqdhzU11qSEcuVcXHOvF/5lipqrUbvbkjkYTlJWxV+VSTXF43NGnVWdUTXPdqOTYAxoxUzajDKmz4gONuK+efgiq0ATb2fuEOkxEv3swp+UY4I1iLMzjmTrwJnB53jfug/xXSoPOHCAG4ILTNpBjzobIQd5VVeo4k95QaNNsUCVsQezdzhOqkxe1vi89gjacObQTSxYYWg/F3kREabrIowT+COrwNiTmkD/G2K9GcYLggQzoe+2nfwnTWZVQEUOvvaWfOtmnm3KeB7hJpXGfRXf3JaFmxSi3ZKHquUSUwvc9yy8VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vg95xOSLw7pUY4MKR7rO/dHd17vxH5GpixtqGPnRKlk=;
 b=ipJ4+hBKRqN7PnoDZnN1cPMx5U8JU209avewX/084hlqaCHvFDysxyHHe3vU1AecVm5F+wwEBs2LNDXanbelBsW+QnXC12y0eqRiADK/q+kAh1d0vllinw0IubIxvtDEZ8p2255IBwV+NBY4pJV0J/M4w7Y8nXajNF3tKDL+e3I=
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by PAXPR04MB8797.eurprd04.prod.outlook.com (2603:10a6:102:20c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.10; Tue, 24 Oct
 2023 07:30:36 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::34dd:289e:9e8b:9c9b]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::34dd:289e:9e8b:9c9b%7]) with mapi id 15.20.6933.011; Tue, 24 Oct 2023
 07:30:36 +0000
From:   David Lin <yu-hao.lin@nxp.com>
To:     Francesco Dolcini <francesco@dolcini.it>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "briannorris@chromium.org" <briannorris@chromium.org>,
        "kvalo@kernel.org" <kvalo@kernel.org>,
        Sharvari Harisangam <sharvari.harisangam@nxp.com>,
        Pete Hsieh <tsung-hsien.hsieh@nxp.com>
Subject: RE: [EXT] Re: [PATCH v6 1/6] wifi: mwifiex: added code to support
 host mlme.
Thread-Topic: [EXT] Re: [PATCH v6 1/6] wifi: mwifiex: added code to support
 host mlme.
Thread-Index: AdoDCD3HfqdGXSjhR7u7/u1lbWxIUwBLzz6AAEfEgvAAEFZ8gAAs9bvg
Date:   Tue, 24 Oct 2023 07:30:36 +0000
Message-ID: <PA4PR04MB9638A0D7D64AB447EAE70C9FD1DFA@PA4PR04MB9638.eurprd04.prod.outlook.com>
References: <PA4PR04MB9638DEFC074F41AAEE3AC471D1DBA@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <ZTP1OXGExKCMk14D@livingston.pivistrello.it>
 <PA4PR04MB9638E6859D64EF4FC4762C03D1D8A@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <ZTZEfefJ8pvtnR7M@francesco-nb.int.toradex.com>
In-Reply-To: <ZTZEfefJ8pvtnR7M@francesco-nb.int.toradex.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9638:EE_|PAXPR04MB8797:EE_
x-ms-office365-filtering-correlation-id: 0fcfd714-d332-4996-d866-08dbd4631d8b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gQL0dcho/F7Os7Ce35lfqt30UKEEJa1dt0Y9Irsqb5lnhX5MB5CFYbLMqLb1U7RLHM+r2nv721q6F1ZoWQNjw/xGWtzrefSoshLnqeCkOpFvq1ckFTGnDP/tuUPCWmOqd40VLuwbIizca++t/eFS63rkwwPf9fIJYSktGfXZS1jACrctcufZW/jAwHFzEjFqJonnD5zSn24LqEivw7tXwBiWSngFps/X6uia4okpvScjo22yHmtDlEOP4zPJtIUG1+BbAs+IhZP+pQifboBModo0BgCsI/9gEnq0FXerEgd0Mo6LggsxLA+UeA8Qe0EGEbhCFcnkyZ1vTV7hRB8eqHEBqOhF8z9EdpY4dpLNwpuSgCJL6FCZHcHhgAO7yWnM0Xo+O2CWEZd+OHOiGD1tmxxg1jgq5SvP6QAu4AiFKsdxnRq/qSkc+MNlVhGX9T6qPJbFLjde82nNEMUbOpPNC2+UhLVWDZNmCQ9PiCoJUshRfsOTiw09I5S5s/lwAuZDcwO4+OMmMiZM+Bx3c0WL6ov1nEZprZHtbb6Vf9uzSCdSiwzWrvkVBDDxpqMntYf9cRZdVGjQ03WNephjh3JmW6QZkGxK1EDsK3oshc5ymKg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(366004)(346002)(39860400002)(376002)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(55016003)(52536014)(6506007)(38100700002)(41300700001)(7696005)(26005)(4326008)(5660300002)(83380400001)(122000001)(2906002)(53546011)(9686003)(38070700009)(966005)(33656002)(45080400002)(8936002)(86362001)(8676002)(478600001)(71200400001)(66946007)(54906003)(316002)(76116006)(66476007)(66556008)(6916009)(66446008)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dun+ol0NWGxUnKPaIV8otbJMIAgj0OLPXtuwY2u0ybcsb5j96c4dSlVPMK7h?=
 =?us-ascii?Q?HVZaWr0TBhZIkOZiAhXIPpaoRNDqXfetWxiLds5g85EReTBP6J10934CqQcY?=
 =?us-ascii?Q?15nm/54fOxPtz1M+mWCGcSsKok1fJCu8HndrpjTy8Y+HsTKra8RningUELMc?=
 =?us-ascii?Q?zI8VkC7Z/BG109Ext3eeuj8M9YGOhK150l0xg1DKuiXGR4vnrZyLBowHUeie?=
 =?us-ascii?Q?6xSdVJgetOvw+zyVjwQr4Hzi25v7x/ppo/UJ0l9GGr2Wa3/fBHFMOHGXdgm0?=
 =?us-ascii?Q?+aNe+guCwnkiu2Jo3rRkSdA5ztIMAUlAN2L7YBdpt7Rl8g/lzrAaiE8FU2FI?=
 =?us-ascii?Q?AIyVZGbQVfzzBiCNuWpTS3hBBh6QpZ4qKe8Zp14gJvVZ+JmBzWqbbjvr6AsN?=
 =?us-ascii?Q?q7pG54eurpqKiD4sZRGSn/cQt49KZLGgBPMc9Y1koKHvzAMj9i7tAE1jQC0O?=
 =?us-ascii?Q?L+58DxSP3uzl3ndDr+b/OrCpkpTLyhkHrJgpVY24/M9M5AWQdc3gjIgVnCu4?=
 =?us-ascii?Q?0+E0xm+vPnxmciw8jMk/J8dZggUIcrQBepuv8iMwbrZ09tjdZHIcqTSCaT4E?=
 =?us-ascii?Q?VhMh7CLGvZM5BC5pvbBcQtq2aLxkSHAV7USUrG1bJwunGIDVC3zzBulD8csU?=
 =?us-ascii?Q?BW6u94iBiQloezrcfft1JxIcKf5yrL+WIeoe4GTSsHaNbW7hc2XkHfOdjmvQ?=
 =?us-ascii?Q?lLR3X0oLEjluC+Og7OvQNNJA2FwI164Ya67i+19I66scdtr3Bk/abuEZfVYX?=
 =?us-ascii?Q?Q/kEiZnKioKrvqWmnld4MFvasEDXUVxGrhmb559JJI84H51WLXMOoExnmbyG?=
 =?us-ascii?Q?RwryBYCzQJWVWPzTz2shya3MEQXWVlqqhraT+mWiQmAiGVofvafL0j5mT6P+?=
 =?us-ascii?Q?1ErAhomckKAYk/1WppOze69HEjsPcREp2UVEugvMBekI/kHhz71Tb6NAu6+v?=
 =?us-ascii?Q?icoIVK11DJsTtqAxYu4rSynID8MOYPzVVyn4iuNEAt4ivp5x/dFfPbNtzUWw?=
 =?us-ascii?Q?hz+CHIwbEs1Eyc71eVrvvPVhxAKkAebr8az75EP3tYoEwx1aTUYbbZc8oO14?=
 =?us-ascii?Q?4PP18YR2Cwj1xqYz7jBDzWggsu1WxQc7FtagkMf3hlhNaWVrhx7Oefstyt1L?=
 =?us-ascii?Q?JPJ4oiRZeqpTzeV0QY0S8sHRshslCs2qEE2+TRCcUb1oxkR2KOXTscN4l0To?=
 =?us-ascii?Q?RXAOqUWRDBgBTTMeIwpB/X2/ywjLrPIlmho1U6czxO6qy52qPviMvIvKx5Mb?=
 =?us-ascii?Q?IsLnMGOwqlVV85ozhkUW0Ks8gELymooGuogyhcRx8ujKg5ZDGkV4mFu8xCdB?=
 =?us-ascii?Q?ZQhYWO4ouNh4bxYK6ZRTiGcfiM2eH/JzMXoEpWt8aYEDQovgpLL8a6h3rmcT?=
 =?us-ascii?Q?xQ8gOzAvrPE1MYEoBTjugrnCP30lpvVMzuTos3+r5SBkiaXHDqFI2LzZ8QX+?=
 =?us-ascii?Q?6dTUJaw0JJ6vklXmBXFryrXMdRhZ6y7CWwuxUHvqUIbfZa2mRO6UdHxGJWt4?=
 =?us-ascii?Q?gIJg/VX51vgDl2tO4ex0PZF6PhIdwrWDiKvQ6jAJ7Qvbc26dFNnY4nnLsXzE?=
 =?us-ascii?Q?PjwNbtYBYnQIT+31tnu2f9zNzf5pUpMsLw+kp85T?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fcfd714-d332-4996-d866-08dbd4631d8b
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2023 07:30:36.4698
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bHBpaeLtUu6+/9Oq7jP80fPAWAWPUyof4+vhOON6iXkDauc6uFC9dkEngkML1CrEhz4GXB1vBusl7OAfLfhMuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8797
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Francesco Dolcini <francesco@dolcini.it>
> Sent: Monday, October 23, 2023 6:02 PM
> To: David Lin <yu-hao.lin@nxp.com>
> Cc: Francesco Dolcini <francesco@dolcini.it>; linux-wireless@vger.kernel.=
org;
> linux-kernel@vger.kernel.org; briannorris@chromium.org; kvalo@kernel.org;
> Sharvari Harisangam <sharvari.harisangam@nxp.com>; Pete Hsieh
> <tsung-hsien.hsieh@nxp.com>
> Subject: Re: [EXT] Re: [PATCH v6 1/6] wifi: mwifiex: added code to suppor=
t host
> mlme.
>
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report
> this email' button
>
>
> On Mon, Oct 23, 2023 at 02:16:26AM +0000, David Lin wrote:
> > > On Fri, Oct 20, 2023 at 03:48:11AM +0000, David Lin wrote:
> > > I noticed that you ignored some (all?) of my feedback [1].
> > >
> > > Maybe my feedback got lost between the quotes, maybe you just forgot
> > > to apply it. Please go back to the previous discussion and either
> > > implement all requested changes or keep discussing them.
> > >
> >
> > I think I replied your request and follow it. Please check following li=
nk:
> >
> > https://patc/
> >
> hwork.kernel.org%2Fproject%2Flinux-wireless%2Fpatch%2FPA4PR04MB9638DE
> F
> >
> C074F41AAEE3AC471D1DBA%40PA4PR04MB9638.eurprd04.prod.outlook.com
> %2F&da
> >
> ta=3D05%7C01%7Cyu-hao.lin%40nxp.com%7C6878af1bfd2840a79d0708dbd3af0c
> cb%7
> >
> C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638336521007434968%
> 7CUnkno
> >
> wn%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1ha
> WwiL
> >
> CJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3DAMCnU6bzMXwCJcn0VqXPnUF
> xEQB8j8N4mF
> > 4LZchFxOA%3D&reserved=3D0
> >
> > Please press "Series:   | expand", you will find cover letter with
> > related patches there. You can review any commit and reply the e-mail
> > separately. Thanks.
>
> I think we are not understanding each other, please have a look here
> https://lore.kern/
> el.org%2Fall%2FZRLsuJfxuvFk1K16%40francesco-nb.int.toradex.com%2F&data=3D
> 05%7C01%7Cyu-hao.lin%40nxp.com%7C6878af1bfd2840a79d0708dbd3af0ccb
> %7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C63833652100743496
> 8%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLC
> JBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3DamdyTVGXjQn
> js40yAAiVo3oN7pBEW5XmuG8UvNPNsyo%3D&reserved=3D0
> where you can find my comment on v4 of your series. I cannot find any ans=
wer
> to that comments nor the changes I asked for implemented.
>

Sorry. I missed lot of your comments on patch v4. I will check it and reply=
 you. Any needed modifications will be added to Patch v7.

> Francesco

