Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A35C7D487F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 09:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232818AbjJXH1S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 03:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232396AbjJXH1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 03:27:16 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2059.outbound.protection.outlook.com [40.107.7.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BCFFB7;
        Tue, 24 Oct 2023 00:27:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O2uLUe4BBl6d/Wq+p1wEa6o3+x8NGmTha60kTCEmKFAw7SnBtuzSl9ZtceUpT23jI732e/DgsBWzTfTFuPahH1TC+o4PNCdHMOVDj7vW+YCqWjBcvxVpCSKJzO8ZCz2ZI6AGdnb4mHR2XYuGjNj+tn/UY/o9VW8Cdy0B4jNiiYGmQmBXvR5Pw9zaP18yuJTsqFugzeDZ8FGrPo/nxrO5gbnUwLl3OwejAuIjwZADTTu3MMD+A0fEVxn1vWaqCaCO5L5S2rjbHmBZvSzELHNT7Xkn+gccboC+50ea4df3y2SCdQXTDg5+d/l+x+wHA2AclFXUtqOcWqEK4Ao5Wcdh1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6gSP0eiFjtaS6CoisctPzsTXXN+cUXiM8hI6XX0SVmY=;
 b=diEPs8RjRTVQrv1mFH2sv74QgLHR9bQKIqFZgeEIZgTrOXtt5fx6IfjHBXbtxzyto8q21UxCpnt2k/g/PYisrbp5xI2h/45STyIJIXkgPh+M8OxPFHHrudHtVm1nJCUlT58vx0Ra9b+TBCdAahnxfYIINlQlpSne9dWrOUf2ZUhQTjaAI6Tilp2JfzR86zqd58oKIL0NzbwEsRDGpNVQa40g0/Bgfj0y65h2E5NEaqe/aNKlNUJiHT+G/yOLzaoNIs0NLmi7iDwHEErAqE8ax4Eq83P5X2dPwWkc9emYfm+SRLIuHRDgwvkrFmn9mTepihyYYnDQ6OahJeSEWlLrhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6gSP0eiFjtaS6CoisctPzsTXXN+cUXiM8hI6XX0SVmY=;
 b=jQr+Av1BE3ehnRn3UiyaVIq9iUJtLzFAj38T2Z7ou1jkNxluWT/DK9rgdzRarWbCrMNMZuAW/LkF0jtj2gwQMN8UocBW9DEFq+GKuRGhD5X29aX0YXmwxWHbNASGxLeR+3R9YBRjWmRyKYwAuzybH4JU9fShTuZkw56Npok5w0s=
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by AS8PR04MB7815.eurprd04.prod.outlook.com (2603:10a6:20b:28a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.15; Tue, 24 Oct
 2023 07:27:10 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::34dd:289e:9e8b:9c9b]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::34dd:289e:9e8b:9c9b%7]) with mapi id 15.20.6933.011; Tue, 24 Oct 2023
 07:27:10 +0000
From:   David Lin <yu-hao.lin@nxp.com>
To:     Kalle Valo <kvalo@kernel.org>
CC:     Francesco Dolcini <francesco@dolcini.it>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "briannorris@chromium.org" <briannorris@chromium.org>,
        Sharvari Harisangam <sharvari.harisangam@nxp.com>,
        Pete Hsieh <tsung-hsien.hsieh@nxp.com>
Subject: RE: [EXT] Re: [PATCH v6 0/6] wifi: mwifiex: added code to support
 host mlme.
Thread-Topic: [EXT] Re: [PATCH v6 0/6] wifi: mwifiex: added code to support
 host mlme.
Thread-Index: AdoDCDtnHg9WHjidSq6kmhUFkN75GgAYVdiAAHsGVHAADq+dtQAutwzw
Date:   Tue, 24 Oct 2023 07:27:09 +0000
Message-ID: <PA4PR04MB9638FB3E298996E2A3A61F17D1DFA@PA4PR04MB9638.eurprd04.prod.outlook.com>
References: <PA4PR04MB96388A628D6AB8359D3DAAD0D1DBA@PA4PR04MB9638.eurprd04.prod.outlook.com>
        <ZTKbxe1bAkfRI29V@francesco-nb.int.toradex.com>
        <PA4PR04MB9638847CEC6D16AE53B3875FD1D8A@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <874jih1zbu.fsf@kernel.org>
In-Reply-To: <874jih1zbu.fsf@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9638:EE_|AS8PR04MB7815:EE_
x-ms-office365-filtering-correlation-id: 7d28a221-e25e-40d5-0353-08dbd462a270
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 025SclndXw4guyvMb0w3CIYN+efsXjvth5WOCnGkC2PQl6u3WNCRtkIxx2vWz3M2j4AAxe7PFdo6bZIuSHLc2TMeKjL4FaXC5Hfkj4ys9FJLFx1s9k8kIPFX7+tPnW78AfHz9e+rO55YcdFV5/7/vM8c0UHniZO2sRGVdjUcquRZKXR+jbHRDisoBYrUUNVIksT6+NrSBXsNMZpAv65iZrMpoy3q9oQ3N4kJ3//jdZu8HKOqAABKSWUnclL880IrTpMKA6cVzKkxhfoMsl9oxT/6M8qgJ2HEO9VrHb5nxpSNxqEXMVozd6RNkKaIZxEapHFTgiiM5qijSAiAlJhMmAKtnq/kQ1pYNyPoOLUyaJkOOrTf7c0SFJ3fVi9oXI0N6v/XpWkAWLvG9Tsh5JZPCT8gmalV+1YD5ZT3d5tkKv6h6O+CwATQLKsKbcLj2OJiBT1s87Z0U1cbEYsXEUymUpMMGtVMVO5WE8AnGySPfXC0HUh/lblDlPyJYRl7RLLl1i8I2BNrOW1p3fF3BggGAgEf+6wMzb4chnmkUL9HOHHA3FsUZmczQoEg68/gJMRWfbcsnT+AdQENpGMQZaZFi44W5lFYugPPwQWLj4p8i6g=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(366004)(346002)(376002)(39860400002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(83380400001)(38070700009)(55016003)(71200400001)(8936002)(2906002)(4326008)(52536014)(33656002)(26005)(53546011)(8676002)(38100700002)(122000001)(7696005)(19627235002)(6506007)(45080400002)(9686003)(316002)(6916009)(478600001)(966005)(5660300002)(66556008)(76116006)(66946007)(86362001)(66446008)(54906003)(66476007)(41300700001)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zTIUDouJZjhTBoiREvJDyYVml1+J+EFDl7ata32MDlYoQcRhvWoeaflnQBnN?=
 =?us-ascii?Q?hO+NKMuS14+Z6txwsjjeBIYcAcvU5iom7hTVBtJ6NLoEzYY+Ki+9c44QEqwG?=
 =?us-ascii?Q?xRcennxy0uy3BYvG036OozmBDp8lXHFOdbbcFasU4MdJVJ7iilhMXy0eVM1M?=
 =?us-ascii?Q?L0AcZ7nO4MGOsCXsLcEj/9l0CDQFXpTcBzC10OOqNlzqO3T/67ctkVoMBzY8?=
 =?us-ascii?Q?ZjhIykNnCkfMJsvnsJbsIl+QF5M9SvrDkiQ1oLaey2WP5xG2Q23+lAfG0Zqo?=
 =?us-ascii?Q?kQlBS6SZHxJHWJI6o789PTUfp6G+69hGN8O0M6aecWo72jrd+9xKSgjjqFIv?=
 =?us-ascii?Q?vO8FBoRARzKEsIJg0uKyxAD1DRXeZvT1kSAt0V1NKjzc8zujgUNBkO55O08F?=
 =?us-ascii?Q?L9B0kLvmnBDJ33zIx3VSdYyk/zuBbBUf9FzMxCPEXEONZu/jPqiQvo1R4+0C?=
 =?us-ascii?Q?77IX5+LG/Rr+2NcC37B99AMA4F2DocdJKodKEUKL+7AuialzE16cOXeJn+Fh?=
 =?us-ascii?Q?wzjZGZRh6lNU4sxHeG0etnLDyjHLRRm7sXw2+OWaCERPt/4863wL4XSt6fr5?=
 =?us-ascii?Q?Th42GE+MZV8mh9y+LSt8pQJJIYzgA1eqyc9fwJRMeDRkR6kqDlzoVscAY8RB?=
 =?us-ascii?Q?2RlW9zcyQ1AMMwlRaQ+BIogjghyeHILQe+uPyE8QfWR/YcwoP//+IQlZ1EIG?=
 =?us-ascii?Q?SHrcDUUCpRF0mDYDx3eHRhxldi1Akb2+iLMtPFdAoHaCuuGA4PLfqbINWO1R?=
 =?us-ascii?Q?G0Uziq5V1kJmXxkRhXY9mnA+JFtkAAz37Tw3ig5Oyy3grPHHVEdo0pf3WURJ?=
 =?us-ascii?Q?h7mGWZfEWfe8QWuDqXLrifpVRBg9S5vnQU14f4BM3PNJIWH9YS0StaK69gdj?=
 =?us-ascii?Q?lkw6R2yBmU4ZxHDIGlmBqiHTnvLfjvMV18opZ3R+DFC+yLTIWx0pG/xar+fo?=
 =?us-ascii?Q?8RXBUoDrrCxtCvu7Ay0AALVd27adv67g/nex/1sjje/GcTokI9CYmbTgUdPK?=
 =?us-ascii?Q?dwnvFHF0wRar7yh7HA3FafXvZgxFwv3st2YCJgAXMvOa0QvD3LVL8qrtzSEe?=
 =?us-ascii?Q?xSo1VOQupZDj3RVCZZFec6lUDGz0tZITWbTAV7HzlY94WcW8980UTY590uXL?=
 =?us-ascii?Q?qn5b+ByZJKgJZ4HN7DivB6UGVddzkfeLrOSqeDaUuaSICK7rzvD/umj0uTwA?=
 =?us-ascii?Q?qud9qG1RP84gpo6Axpw73VFKpVMdXZ0bJtkoN4BA92F/riQDotavDhctFAsz?=
 =?us-ascii?Q?BI36yXMVi/dwBEtjBvLxo+IV25PTD4a544BCQWJmSj5WkzGm21EZoNA5pDCk?=
 =?us-ascii?Q?VPtxtbVCYLQ+xIrFdpfPlHtXLhH/uWx7R8JTUBVg3YDLivOvnTImkD2H51w/?=
 =?us-ascii?Q?VFKe6HcdzhQKXR/QjO8sSrI+3PZ6hHR+p/IYswRq/902ogaFY4TVquoVKlbO?=
 =?us-ascii?Q?DfnidCIEF/jNdwCbbVsHdwn3OTSIvKVlvE7h/JFgzU94vkcbb9D89Q+xHVUD?=
 =?us-ascii?Q?EOeP2ywS8oPIqvEXLQKDaNXlsfk2gxWgTSvau0AH89xRp6V5KQNYpHi1NLbF?=
 =?us-ascii?Q?Hd/64ZxlmrNopanbdGuDqUiuh9jczJJRuOt94GoP?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d28a221-e25e-40d5-0353-08dbd462a270
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2023 07:27:10.0011
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b3oNjlZBRTrk5fa/v8bkwxLC3RIQyIeuzb3U9jxeSfaMRdmYEqcDjtv83crnHIwpOil+mM8k4IVRvG3+SJ9GTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7815
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Kalle Valo <kvalo@kernel.org>
> Sent: Monday, October 23, 2023 5:08 PM
> To: David Lin <yu-hao.lin@nxp.com>
> Cc: Francesco Dolcini <francesco@dolcini.it>; linux-wireless@vger.kernel.=
org;
> linux-kernel@vger.kernel.org; briannorris@chromium.org; Sharvari
> Harisangam <sharvari.harisangam@nxp.com>; Pete Hsieh
> <tsung-hsien.hsieh@nxp.com>
> Subject: Re: [EXT] Re: [PATCH v6 0/6] wifi: mwifiex: added code to suppor=
t host
> mlme.
>
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report
> this email' button
>
>
> David Lin <yu-hao.lin@nxp.com> writes:
>
> >> From: Francesco Dolcini <francesco@dolcini.it>
> >> Sent: Friday, October 20, 2023 11:25 PM
> >> To: David Lin <yu-hao.lin@nxp.com>
> >> Cc: linux-wireless@vger.kernel.org; linux-kernel@vger.kernel.org;
> >> briannorris@chromium.org; kvalo@kernel.org; francesco@dolcini.it;
> >> Sharvari Harisangam <sharvari.harisangam@nxp.com>; Pete Hsieh
> >> <tsung-hsien.hsieh@nxp.com>
> >> Subject: [EXT] Re: [PATCH v6 0/6] wifi: mwifiex: added code to
> >> support host mlme.
> >>
> >> Caution: This is an external email. Please take care when clicking
> >> links or opening attachments. When in doubt, report the message using
> >> the 'Report this email' button
> >>
> >>
> >> On Fri, Oct 20, 2023 at 03:48:06AM +0000, David Lin wrote:
> >> > Patch v6:
> >> > Correct mailing sequence.
> >>
> >> You are still doing something wrong sending the patches over email,
> >> the various emails are not threaded as expected, git-send-email
> >> should do everything for you.
> >>
> >> No need to re-send now IMO, but please figure out what's wrong for
> >> the next time.
> >>
> >> To give you an idea here [1] you see this email alone.
> >>
> >> This [2] and this [3] are examples of a properly sent patch series
> >> (just random series from your NXP colleagues).
> >>
> >> You have also a winmail.dat file attached to every email in this
> >> series, not sure what it is, but I would try to not send it.
> >>
> >
> > Yes. I can send them as a single e-mail. However, I find other member
> > would send multiple patches as separate e-mails with a cover letter. I
> > think it would be easier for review.
>
> We are not asking to send the patches as single email. We are asking to r=
un git
> send-email only _once_ per patchset to make sure threading is correct (ie=
.
> References and In-Reply-to headers are set). For example, you can do it l=
ike
> this:
>
> $ git format-patch --base=3Dauto --cover-letter -o outgoing/ main
> outgoing/0000-cover-letter.patch outgoing/0001-First-Commit.patch
> outgoing/...
>
> $ git send-email [...] outgoing/

Thanks for your information. We will follow this way for Patch v7.

>
> More info:
>
> https://wireless/.
> wiki.kernel.org%2Fen%2Fdevelopers%2Fdocumentation%2Fgit-guide&data=3D05
> %7C01%7Cyu-hao.lin%40nxp.com%7C61329a44c6e344221c0a08dbd3a78bef%
> 7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638336488782298560
> %7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJ
> BTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3DJTeuKeS8LQphE
> QYR%2BeBK1ENgR7L9ny0S9Nv15Ku1keE%3D&reserved=3D0
>
> https://www.ker/
> nel.org%2Fdoc%2Fhtml%2Flatest%2Fprocess%2Fsubmitting-patches.html&data
> =3D05%7C01%7Cyu-hao.lin%40nxp.com%7C61329a44c6e344221c0a08dbd3a78b
> ef%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638336488782298
> 560%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIi
> LCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3Di5Q5Hj9w6X
> zRo3phK9UcSaOzoHeJbxpmpB2TRIfyhak%3D&reserved=3D0
>
> --
> https://patchwor/
> k.kernel.org%2Fproject%2Flinux-wireless%2Flist%2F&data=3D05%7C01%7Cyu-hao
> .lin%40nxp.com%7C61329a44c6e344221c0a08dbd3a78bef%7C686ea1d3bc2b4
> c6fa92cd99c5c301635%7C0%7C0%7C638336488782298560%7CUnknown%7CT
> WFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJX
> VCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3DTdWVJj9KpejI6kQfQnF9R7u3Ohz8
> U1o9xYiiDUcasag%3D&reserved=3D0
>
> https://wireless/.
> wiki.kernel.org%2Fen%2Fdevelopers%2Fdocumentation%2Fsubmittingpatches
> &data=3D05%7C01%7Cyu-hao.lin%40nxp.com%7C61329a44c6e344221c0a08dbd
> 3a78bef%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C6383364887
> 82298560%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2
> luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3DVjDp0
> T4L%2FjqG2lnHG0EJLpWEA6mAcBCXFhwTwMfakg0%3D&reserved=3D0
