Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC2DF7B8671
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 19:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243592AbjJDR0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 13:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243502AbjJDR0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 13:26:15 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2072.outbound.protection.outlook.com [40.107.100.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC5A8A6;
        Wed,  4 Oct 2023 10:26:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a8D2+77R36m/IuEGPkuF0dumbpeFwID2DeJ6T/rph4YCD3o2SmH3MFMuCyU3l+zOvbpvbgDmhpxtIEp3PChhFCEWeCz7BgB3HjlP85r+LZ1lukANX0HBYxeTN3ro1pcdf9UxUvRvPDnOwoMgtsZNIUxZgNXB/1d4TsxyHytYvw9LKrxs9viuTRP39zBz7epubxHJyp4RCQqxSKxNAIucdrwMTtsC2O+uSpSUqDuhCB6reTOa3tCnbJI0yj3UWoV7S9FHMjvreGo854XYUPf+k9kdBfIjsdcvsx02e77BF/BquB3LuKWSekP0Da4jDPd/t76YL1sH0X4eTO45P5zBjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tEwz8tw1GdPgX360WCRX6T+Pt/TQN2vQZl80x3BPAfE=;
 b=nfPA/yrJVjRo42DH49z84AReX8O5z5to/2Wi295sx7HJ0crSQKv7QEE/BdWnRv9nvQk2w9MvZlVHiDvsi7KC6MhKYo2iQVngI6FQT4HM7qZ+kOTulgCOfAbKUwIvws6PTKUaYREgqhMcDBEx7/cvuSBx6lkpOR+dyD2RZ7/9V4sgeH14YhxiL16yxC/THLjyigWIrbeR0/B/fLouvA0G6HxzqGQUX6WPee0vSf8Uncr77bDpKtry608U9hca4Q5ZWAW2m/9QZVaFdmz4Ny4XTUBXv11ypnnRSSpwLecek4PyCIBJZevCkCmoEt+40pEyP1LfPHUDCyXEgGfLhB5A/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=silabs.onmicrosoft.com; s=selector2-silabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tEwz8tw1GdPgX360WCRX6T+Pt/TQN2vQZl80x3BPAfE=;
 b=bgGif0J+7CMVBBJ70I8KxjKJP5r00s30nW/mBB2/8i4oWuNvcwYh0wN28iQk1KS0PQdHLw0KwoKpqoPA2vAs1bJYcldioVKlrMdC2nBuNgucLjHEFNwz+PKbhAlDYtbi/kuSMItAI+F1qfKjBZVeRasU4RYAASZQGh9YRP0uNHA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=silabs.com;
Received: from IA1PR11MB7773.namprd11.prod.outlook.com (2603:10b6:208:3f0::21)
 by DS0PR11MB8071.namprd11.prod.outlook.com (2603:10b6:8:12e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.28; Wed, 4 Oct
 2023 17:26:07 +0000
Received: from IA1PR11MB7773.namprd11.prod.outlook.com
 ([fe80::d6c8:4cb6:2594:d8f3]) by IA1PR11MB7773.namprd11.prod.outlook.com
 ([fe80::d6c8:4cb6:2594:d8f3%4]) with mapi id 15.20.6838.030; Wed, 4 Oct 2023
 17:26:07 +0000
From:   =?ISO-8859-1?Q?J=E9r=F4me?= Pouiller <jerome.pouiller@silabs.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/9] wifi: wfx: fix power_save setting when AP is stopped
Date:   Wed, 04 Oct 2023 19:26:03 +0200
Message-ID: <3984977.e99z0qppnp@pc-42>
Organization: Silicon Labs
In-Reply-To: <877co27hga.fsf@kernel.org>
References: <20230927163257.568496-1-jerome.pouiller@silabs.com>
 <14139521.lVVuGzaMjS@pc-42> <877co27hga.fsf@kernel.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-ClientProxiedBy: SA1PR02CA0006.namprd02.prod.outlook.com
 (2603:10b6:806:2cf::15) To IA1PR11MB7773.namprd11.prod.outlook.com
 (2603:10b6:208:3f0::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7773:EE_|DS0PR11MB8071:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a1f077b-22a7-4006-67b2-08dbc4fefe24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aHjkOiVwYskv6XkqlVeHxxGyyLMXAECsyM/FZjojEj234aXlBqySBx/+NaebWCJ1dX9I1vT8cAh7vRm/lLrB/SyHkwdwVWrwxrD2d36dWLP/jlJk8v7XdJC/QNwKzbZ6uGWdMg3vePd1+d+C3S/wPs0bFfTk+5QA0TxzYIKT8xSFfUeIUVh3yfIkPIOi1PqNUG8OkVN6Pj+a5V1T40FwGIGV+APoE/jsczn4zFuQ/l6JryMq3bk6ptjMp4ioTBak6MT37vdGctMYjPOLIetvXn9X2Ft/cxIpers/a3ZpUcV6TQv2xQ2XyscN/Ae4m0eOsnSe2t4TPst4KESHC3qYHFCgZxvML5GVPnLfIdvY6+eGXuQscIVs4tkIxOmmsP8/EiVxFQXWmLoFni/CxG1q95QwHEQRV020o/YV6/jiSWH1kDxF9P/GMvbQeSRm1DFryL40ChLNdsccwYIgZN/qPq7WOpBrEpc86JmlP2IJrTUMzLcerSv+ap5kFRyHDYKBF+QcvBGUP3+ZDaM66Ln9kLUPm7i/JygkxdWgxPz7gIoL87axkvEY/GREduguDYqo
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7773.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(366004)(39850400004)(376002)(346002)(136003)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(478600001)(52116002)(6486002)(36916002)(6666004)(6506007)(66574015)(9686003)(66946007)(2906002)(66556008)(8936002)(33716001)(6916009)(8676002)(4326008)(66476007)(316002)(5660300002)(83380400001)(38100700002)(41300700001)(86362001)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?wM5BRrOQ1QxpqLkB6NtCoKVWJHJNuAv1+gOpdJotAELJOvhwEO7Vxi1H5i?=
 =?iso-8859-1?Q?wdOKWmeUOp41s8CTb1ZUA8K/nOeGQu2tjA8dpvcqbN8trgZBnJy/8/ovx/?=
 =?iso-8859-1?Q?+aiAc07RRJtcBjbFwSMYjvLtfy9EPsiEXBIUtEqlDAiMe9ky16FI5EV9kv?=
 =?iso-8859-1?Q?7SjioGhtNtGLUYsFn0ocYYBJKaDqVuRyuqVJp4i9TaecfBwygTEHSRl6X+?=
 =?iso-8859-1?Q?NvUo25SRy+V7p5fXP9r5kOhXvkUpshMDYCI2zNHtMPCrvsW/tT2bT0YxjC?=
 =?iso-8859-1?Q?weRmJDfc/m1s3Zk2pBS1txgHSsibu0nWapNF7S9dVbUnUls+mqXXpZtOAv?=
 =?iso-8859-1?Q?QA6dm9iNZHWbQAGcd3KubM2fUortOr0+q+6IUu4Nk9Rf88mKd/1bPjXOHS?=
 =?iso-8859-1?Q?rfaFzlgZBaranXg7vEQKIkqOfy5KFFlzoDdlv689FKeGuxMELRZjsIM0Zc?=
 =?iso-8859-1?Q?I76e0tIh+KSsCExYLbHsHzxvmOvUtXNahmKbVWIuf6m5ON6v11gcyhGjji?=
 =?iso-8859-1?Q?NVcGfK+PmrYMfgqe5EbXzpJlRhH4+fwNMfSyf/qjs5qdBDbjCH/hb/KZtS?=
 =?iso-8859-1?Q?9QmvznhCsT+op+ZHQORd6YKBp/pehV3y1wXFqYIQfjCLyYaJJsHofDGpzM?=
 =?iso-8859-1?Q?tjs7ukAyWytOgyCaDZ47ARXjFSwWr+Uzqq6wjGXGRVu9mqxGJsChthx/4b?=
 =?iso-8859-1?Q?QZeLsuDDZmjM+ZZ/T/spdMqmVmrbI3+E6PkDN+YIS0FJp/ubm/raZHO1qS?=
 =?iso-8859-1?Q?apGvQCpgIQx5Ra5wv5wcRcIR7sNZrM1tDrA7vSyrVjfN9Uzvq061ryoP5S?=
 =?iso-8859-1?Q?WZ4/GyGwl6f41wOTkeZYa2w9Gmlf8amMGPixKxj6mPumW/dg1m9hOAMTzE?=
 =?iso-8859-1?Q?AyUK36J/9PajZ4bUbMLfiNb4EcM3cXTMjwmURC07t249u805xTCkajuHq7?=
 =?iso-8859-1?Q?AY7nceSrlp4JZowJjFSBgsESSV7KTniEyBecIeip0HY8yO0jhiRo6lqfCk?=
 =?iso-8859-1?Q?ZIqAUrl5SpQkxC8Nb1imnMy/ZPSzWw+FfNvl5vQSOV+b5CGVXAquiEjuuk?=
 =?iso-8859-1?Q?LPApDx2jiG4V6h3cNkE0rdCS0BmFBGZzCAUWYrbg+6ZHtJrzHt3n/HC614?=
 =?iso-8859-1?Q?kF0Bc/mSfcnRFvff94vELlw0LXAXc501KW8xXT4fE/wUJCNwnJhRbp+xA1?=
 =?iso-8859-1?Q?HyeIXIM6LxldeLRSf4Ikl7zcEGSHJvmQd+EHfQ+WBYYAHlbGwCPA+jd5DH?=
 =?iso-8859-1?Q?IPRBzwlh49+arnREjRb5kLw7g7J2Z2VjLlX3KtETvhq90BNdb15/5RXvyE?=
 =?iso-8859-1?Q?qO6ZekpMeR4OqTAXGTIqDGaecjaNr+B3nhoxskNxTgC6m+4gkhiIDUNlrv?=
 =?iso-8859-1?Q?T0MQT+32RkSnouygmsyq5BPL2s3tzxyFGMjqq5JsRN/MUcIJ/ERoWiGiq4?=
 =?iso-8859-1?Q?Umy2RLqHmN95YoibqT7TXF5eP7ugKoah89XHcGy5jmtEnodY3d8rf9gzo5?=
 =?iso-8859-1?Q?hXMXEnMa3VeqX2rmmeDLIUcHTa0q8AUlGUs3pblpKp/gCSQxwAz1O7jQG1?=
 =?iso-8859-1?Q?Szs/gceG2npZpSRIH4HfavrBnUZkXvuEcWVtJME7KCD7d8IEvp8Uqby8Yf?=
 =?iso-8859-1?Q?9Hc6+MfKi4dXx4FPpl+JbrzOdS8VZdDmsnE9To6VD/17r/34szvABDCzUy?=
 =?iso-8859-1?Q?jbWZxS34yqRPXbQ3/DzbS7qU//Dqm8gbF2Zy/l1r?=
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a1f077b-22a7-4006-67b2-08dbc4fefe24
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7773.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 17:26:06.9662
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yq2e0HWbHMaen+2z5ROW5su4nsT61MKlkDGbz0gESDoC/8Ko8j45eLJTFkdM+N4MyMApOov+9XInKquDma9X/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8071
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 4 October 2023 13:30:45 CEST Kalle Valo wrote:
> CAUTION: This email originated from outside of the organization. Do not c=
lick links or open attachments unless you recognize the sender and know the=
 content is safe.
>=20
>=20
> J=E9r=F4me Pouiller <jerome.pouiller@silabs.com> writes:
>=20
> > Hi Kalle,
> >
> > On Wednesday 4 October 2023 12:20:12 CEST Kalle Valo wrote:
> >>
> >> J=E9r=F4me Pouiller <jerome.pouiller@silabs.com> writes:
> >>
> >> > The WF200 allow to start two network interfaces (one AP, one station=
) on
> >> > two different channels. Since magic does not exist, it only works if=
 the
> >> > station interface enables power save.
> >> >
> >> > Thus, the driver detects this case and enforce power save as necessa=
ry.
> >> >
> >> > This patch fixes the case where the AP interface is stopped and it i=
s no
> >> > more necessary to enforce power saving on the station interface.
> >> >
> >> > Signed-off-by: J=E9r=F4me Pouiller <jerome.pouiller@silabs.com>
> >> > ---
> >> >  drivers/net/wireless/silabs/wfx/sta.c | 5 +++++
> >> >  1 file changed, 5 insertions(+)
> >> >
> >> > diff --git a/drivers/net/wireless/silabs/wfx/sta.c b/drivers/net/wir=
eless/silabs/wfx/sta.c
> >> > index 626dfb4b7a55d..9c0a11c277e97 100644
> >> > --- a/drivers/net/wireless/silabs/wfx/sta.c
> >> > +++ b/drivers/net/wireless/silabs/wfx/sta.c
> >> > @@ -402,7 +402,12 @@ void wfx_stop_ap(struct ieee80211_hw *hw, struc=
t ieee80211_vif *vif,
> >> >                struct ieee80211_bss_conf *link_conf)
> >> >  {
> >> >       struct wfx_vif *wvif =3D (struct wfx_vif *)vif->drv_priv;
> >> > +     struct wfx_dev *wdev =3D wvif->wdev;
> >> >
> >> > +     wvif =3D  NULL;
> >> > +     while ((wvif =3D wvif_iterate(wdev, wvif)) !=3D NULL)
> >> > +             wfx_update_pm(wvif);
> >>
> >> Isn't the assignment of wvif to NULL unnecessary as in the next line w=
e
> >> assign it to again?
> >
> > wvif is also passed as argument to wvif_iterate(). wvif_iterate() uses =
this
> > parameter to know where the iteration has stopped on previous call.
>=20
> Ah, I missed that.
>=20
> > However, the assignation during the declaration of wvif is useless.
>=20
> Indeed, missed that as well.

In fact, this first assignation is used to fill wdev just below. So I am
keeping this code as-is.

--=20
J=E9r=F4me Pouiller


