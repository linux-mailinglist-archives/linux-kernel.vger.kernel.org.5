Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15DCF7D2848
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 04:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233036AbjJWCLI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 22:11:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjJWCLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 22:11:07 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2085.outbound.protection.outlook.com [40.107.6.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03DA18E;
        Sun, 22 Oct 2023 19:11:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mi1adOOR84UqQpnT6bvptGt+MeCOG0l16dgo3nEigdywhgbezCl9HYQphMDYFgNEJexJ4bUPbe+EDs61VCVtfqniL0tZJo+5KUbcDlKcSHxXGf7Q+vaJf/TICHLv59It+U2tulG3sDFLTE+M6ArcCVFvXuE5LReGqcN7I/qby440HP8EFE9M8gYUV1F0Avoex/OXPdeacCNuX1/f3AbdluhaJpkghDZ5WHl+s5L4Z/gYAnwWCPlH45xwohz5jV3mME3YOiMksjK5Hjv+hPicXougV8q+XuyQFyoy8co0bdr8BMXvRDhg4xC9eiskdA0fco7f3t5gtamfjrJrixqfsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hvOhTA6D4/M/dlH1/IQ2vRDlpCRlV337MhDCJHWboyI=;
 b=YsuWnJMUWQBvpfxlwBeljC8STSWhvGi30VCKL9xgSipkUASh40hApf3bzBYg94JCQq4H3hnu3k2sWkfv57T+903CLxiz5N5ognYhL8pl1Zs7TPAwoDOdbIzbAwGkzjzvIFZNGd1qdkTjyBL+ZmZdqqNBdl8cNA0VGClAEA6WuhtKQzJuUsIPTRtkPnOmfcoPyelOy0hWI2AX9H9yVygkA/wohgD82c0TXrhcgrrE7VeUfEzLl85fw5jXE3wGP7iIwSver1PqIj0+kZUa51+XgI8lZMHOHWJagvWbhYzJUfWoX4RkydnkiFWlIMegzxaUvaIjaZiQj2z3/QoT/ny+5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hvOhTA6D4/M/dlH1/IQ2vRDlpCRlV337MhDCJHWboyI=;
 b=is2xJypPO/cd+fMXoY92aXV/ULA0UWIzfH866Qp1BTrUVH+DGETBOzKo76EvEWtR2axFEGHSydEAgW/V7o6vob85MRx9VHoDs6fomCuFdXfU5W0f1cSepYD2FfNPcyPji9Od72L1rfOLgDWK0lALP1o25kl9Q+KLBoY3mqT0UA8=
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by PAXPR04MB9643.eurprd04.prod.outlook.com (2603:10a6:102:241::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Mon, 23 Oct
 2023 02:11:02 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::34dd:289e:9e8b:9c9b]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::34dd:289e:9e8b:9c9b%7]) with mapi id 15.20.6933.011; Mon, 23 Oct 2023
 02:11:02 +0000
From:   David Lin <yu-hao.lin@nxp.com>
To:     Francesco Dolcini <francesco@dolcini.it>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "briannorris@chromium.org" <briannorris@chromium.org>,
        "kvalo@kernel.org" <kvalo@kernel.org>,
        Sharvari Harisangam <sharvari.harisangam@nxp.com>,
        Pete Hsieh <tsung-hsien.hsieh@nxp.com>
Subject: RE: [EXT] Re: [PATCH v6 0/6] wifi: mwifiex: added code to support
 host mlme.
Thread-Topic: [EXT] Re: [PATCH v6 0/6] wifi: mwifiex: added code to support
 host mlme.
Thread-Index: AdoDCDtnHg9WHjidSq6kmhUFkN75GgAYVdiAAHsGVHA=
Date:   Mon, 23 Oct 2023 02:11:02 +0000
Message-ID: <PA4PR04MB9638847CEC6D16AE53B3875FD1D8A@PA4PR04MB9638.eurprd04.prod.outlook.com>
References: <PA4PR04MB96388A628D6AB8359D3DAAD0D1DBA@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <ZTKbxe1bAkfRI29V@francesco-nb.int.toradex.com>
In-Reply-To: <ZTKbxe1bAkfRI29V@francesco-nb.int.toradex.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9638:EE_|PAXPR04MB9643:EE_
x-ms-office365-filtering-correlation-id: 4e4ced9f-e78d-40b9-c88d-08dbd36d4ea1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sQ68ly/6GaIwIN4wzmee/LJLz5VntfSv4+KjYaaKTyxEnjPpmQ4H+nJvv8lHasFEfcJ53KVasaFuPFc9EnGn7+mrRAqoarV4CjTImbds5GNxGdWL+YNNrbIyGqqV269h0HEppsp1y8p7fGtmyLrZDgdZrsc7W9BDuVwOgifPzS+6JwpwIomyQYdOaOcPQHDTMZzcjzyoVaZSLfgHFDxoML6mV77vOFKA6mtGiPK30wkggnbqfVYBeb4aNk4qoPnfH6+tIrLXi20D3VZjU1oq/id6N02itkLm/EVUodx3iQWNmtODLoO4BqDEgC9w6PXZL6jag2OARuAu+I+jd5/28tQNQzOrcqNviIGI1Gk++wOUgk5Zu970cxrwwusmvMbLy3s8e3OsIFEHlaMn2XtGIsJHL03Rk1mN2d1hCIkfTbq60VqaIg82PLO9oKKh99s37gXhZxgg3v46jTszSEFu1bHVFKB+bffYUmAE7ZxUW3LTndBYUM2hsp0EnPjZhxR6ZxTVzVzsL7puGjyyIhF3ixa4scFKhPmsTK7vNIml4sNPKWzxIbEAbt8sPe5YZbynws3B2HVpfSqLZBHqnWGFWhGM0QZG1creA6Fd6MYUTjg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(39860400002)(396003)(376002)(136003)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(38070700009)(66946007)(55016003)(53546011)(966005)(316002)(122000001)(38100700002)(66446008)(83380400001)(66476007)(66556008)(2906002)(7696005)(64756008)(478600001)(45080400002)(54906003)(76116006)(33656002)(6916009)(9686003)(26005)(8936002)(6506007)(71200400001)(86362001)(52536014)(4326008)(8676002)(5660300002)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8nIXzqmwyoXEPkAfqKBKW8me8C9y8eQDc5t5H4jLVjGX5fXuMC3OOW+KLq/M?=
 =?us-ascii?Q?KGZl0tlv6Q+VUiIedBTMkhDCaRXXbNJM8RJpvTeO5pQiE/rA8urt2ysTsAor?=
 =?us-ascii?Q?Tc1QsiFsFFtL68h+BWC7V/AH0I2s9jTVhVBTnIPKFp+EBgQTl+7ZkM9qzJgT?=
 =?us-ascii?Q?/Y7Q/mY+BcKanwXCVMRSO8O6YEzqUz0wIxg6MFtDlmHutjSUyCKEniSRE/ao?=
 =?us-ascii?Q?pGtRoHk2+op+f6M5P//1rGbVg16+hYqogZYX4O15EKKtBcu9dz0hMtaAzmOu?=
 =?us-ascii?Q?MCyA9iZL7TZrueHk/ceQulgon73gV9XdLSRm0MSNaovhJ1LoP9I0xarufmPo?=
 =?us-ascii?Q?agLbT6nB5gFfwCL/EAnW84yHqJ05rZRzh4+stTKKxKSOKa6A+xyOCMfQ6bR+?=
 =?us-ascii?Q?nBqDYlkjKvs6R+h4MKSDiMk0jct7vxC2YrE0yU6Ue9LpXcUemIG6KGOOvCk9?=
 =?us-ascii?Q?iUmBcMBAEWUhH5HejlMmxeISpeYjGAagjTJDcUeG7kwx4cP4m0aEw7YWbEaa?=
 =?us-ascii?Q?4bM7SO5zoJQeIFfPQkkX+BbI6dIuV/Sd0++4A8m3ltFDQmYEmzVFlWlTLGV+?=
 =?us-ascii?Q?07KRGaLu5wR7EJ5cNduHjIhtQmMiGaotFtNQDxRKlTptD/W4BWW6Zphlcnk9?=
 =?us-ascii?Q?IM48iJW6+UnpcIFLoV+kU+ixn4OXosrpsusKWVof8lXBacz3ndLR0atJxyfg?=
 =?us-ascii?Q?D7F9JtBzjiynm2UX8Zl3p9ZfaVi0JCWSa7qJ3bn6FmLFQ6MgjmqhMfZVlEb6?=
 =?us-ascii?Q?1WColKEGvM9+IfD0Q80zultu+mgQY1FmLi/40w1DZCb4sItOcEZS4bAZ+JYT?=
 =?us-ascii?Q?oBBplqo0OiLr3ZK5EugSrJcKEh3WLL8o4R7VffzqR6vL5qjhsfdxjCGWKf98?=
 =?us-ascii?Q?k/mHcAFtvxRb8D4Wsum1zAxKaJK2cxAnY2HZ/RkZhZ9eZD6HHMaFbBlmW2ii?=
 =?us-ascii?Q?nHQyhQoW/cVIvNdfakA2oUT0PlLdZ07m1fLzIH36PZkW8PDwd7Gv8HC5i5s+?=
 =?us-ascii?Q?bhfQUpckZL04J1xDtSNL5H9hvmBrOpLIcqQlG7U9HPhXdhzfKDQoKpkmktc2?=
 =?us-ascii?Q?nsgfNZk1FvPj/e5XPwMruVvJr5aXVKHo4VJSv3PujPY7oD9chwj7qy7cH7zB?=
 =?us-ascii?Q?/dSDnUvoc92H+BAVH8UC42+AtUGRHJDXOlr4sYMT9PxTHh0LGaOzEMn5K41e?=
 =?us-ascii?Q?zjZbIg96BQTauVPbyRw17FgxjfyWDnUUXOzbYaQiY6dWVp93gZCMSY7fXzsK?=
 =?us-ascii?Q?WSto1wm4h2BeOij10QumAhQaEOp6CK65YpKpPenbCC/H8nUAnn86G5pLK9ud?=
 =?us-ascii?Q?zGOuQJpjrZSYklJ/qBsLnPulfe/4WFJ4rvGkhWDWQJviEDvj929zT3YV9gHz?=
 =?us-ascii?Q?2S2VoxofPca09oGXzowBXYX/Fe+DWrZIEONRBc0kdf1QfB4yi+O7cBwiTvOz?=
 =?us-ascii?Q?owkRIX157f3CL/vlRt4gj5+kE/KjSXhF6h0D1FwFh0/nT4EXE5dvUWP/an2d?=
 =?us-ascii?Q?Hk8j0Y23RlkzNfJX5TMQWikHhuZk5e2iWVvHtuutwsB81mCN1XaZ+GJQzeoO?=
 =?us-ascii?Q?hm3bRY2kk3rSPDccCh/O3SudEC18cMTpeFY4jJsC?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e4ced9f-e78d-40b9-c88d-08dbd36d4ea1
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2023 02:11:02.7153
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5W9V/iYmvLFtGfoeqgqxk8uHS8cPtQmXm6/OyDG0rg0p++npDR+yyRUUOz8Ne1q+eHuLRDmOimIn3pjKVkZ0gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9643
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> From: Francesco Dolcini <francesco@dolcini.it>
> Sent: Friday, October 20, 2023 11:25 PM
> To: David Lin <yu-hao.lin@nxp.com>
> Cc: linux-wireless@vger.kernel.org; linux-kernel@vger.kernel.org;
> briannorris@chromium.org; kvalo@kernel.org; francesco@dolcini.it; Sharvar=
i
> Harisangam <sharvari.harisangam@nxp.com>; Pete Hsieh
> <tsung-hsien.hsieh@nxp.com>
> Subject: [EXT] Re: [PATCH v6 0/6] wifi: mwifiex: added code to support ho=
st
> mlme.
>
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report
> this email' button
>
>
> On Fri, Oct 20, 2023 at 03:48:06AM +0000, David Lin wrote:
> > Patch v6:
> > Correct mailing sequence.
>
> You are still doing something wrong sending the patches over email, the
> various emails are not threaded as expected, git-send-email should do
> everything for you.
>
> No need to re-send now IMO, but please figure out what's wrong for the ne=
xt
> time.
>
> To give you an idea here [1] you see this email alone.
>
> This [2] and this [3] are examples of a properly sent patch series (just =
random
> series from your NXP colleagues).
>
> You have also a winmail.dat file attached to every email in this series, =
not sure
> what it is, but I would try to not send it.
>

Yes. I can send them as a single e-mail. However, I find other member would=
 send multiple patches as separate e-mails with a cover letter. I think it =
would be easier for review.

In fact, you can find all patches from following link:

https://patchwork.kernel.org/project/linux-wireless/patch/PA4PR04MB9638DEFC=
074F41AAEE3AC471D1DBA@PA4PR04MB9638.eurprd04.prod.outlook.com/

> Francesco
>
> [1]
> https://lore.kern/
> el.org%2Fall%2FPA4PR04MB96388A628D6AB8359D3DAAD0D1DBA%40PA4PR0
> 4MB9638.eurprd04.prod.outlook.com%2F&data=3D05%7C01%7Cyu-hao.lin%40nx
> p.com%7C608c0799062a4eda2dc708dbd180b8d1%7C686ea1d3bc2b4c6fa92cd
> 99c5c301635%7C0%7C0%7C638334123004268118%7CUnknown%7CTWFpbGZ
> sb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn
> 0%3D%7C3000%7C%7C%7C&sdata=3DxG3TByV5kbGXbMvr1NM4YF6uErrE%2Bjw
> ZCRf4J8pqPQc%3D&reserved=3D0
> [2]
> https://lore.kern/
> el.org%2Fall%2F1697794232-2607-1-git-send-email-shengjiu.wang%40nxp.co
> m%2F&data=3D05%7C01%7Cyu-hao.lin%40nxp.com%7C608c0799062a4eda2dc7
> 08dbd180b8d1%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C63833
> 4123004268118%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJ
> QIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata
> =3DPj2suLqyMdelLbFOnePQMFHD89R1VWxGg437SCzNMrQ%3D&reserved=3D0
> [3]
> https://lore.kern/
> el.org%2Fall%2F20230811101232.844769-1-neeraj.sanjaykale%40nxp.com%2F
> &data=3D05%7C01%7Cyu-hao.lin%40nxp.com%7C608c0799062a4eda2dc708dbd
> 180b8d1%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C6383341230
> 04268118%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2
> luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3DivxJP8
> uJVfq5VXVj8ru%2FKwRYmdvirlczox08NDRzaNQ%3D&reserved=3D0

