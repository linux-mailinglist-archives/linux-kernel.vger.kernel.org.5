Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0872D75AC39
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 12:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbjGTKmk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 06:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjGTKmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 06:42:39 -0400
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E71910F1;
        Thu, 20 Jul 2023 03:42:38 -0700 (PDT)
Date:   Thu, 20 Jul 2023 10:42:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1689849754; x=1690108954;
        bh=Y2JtQMmANk8Ycv1ygWijsVhzopEKF97I4GcrRrQYLhY=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=ifiSn1BVQhYuF6auOiOe5xF4+dOBSMI5GX8fKT/+2qrBFGS8+RYiUgRzBvHyLJpU7
         9vKNWuClzGiMUHSy+1He0DiT4ch14w1Bz3gnhfOVDMksEK6IzYKWaUfd0BjhJruH3N
         QjtsrwtIQHdbIovCpuULiJByjFYiet4/c4njYrmE0UIPXxYg7lkEEnq2NCySCqZf2V
         SYdkdupFOIUHkvLpFaT/Xk2Ej06PIHTK7lrnP3vo7+O/JhhP/oR0agsmakuAVQvhsW
         ecSET+iklcOJszEiSZ5FK4ooUf0M2UFnRkfsZONUH5EeaFzK8phKrYNnXniWM0QTKI
         rOP3V9YWPOxYA==
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
From:   =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Mark Gross <markgross@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Armin Wolf <W_Armin@gmx.de>
Subject: Re: [RFC PATCH v1] platform/x86: wmi: Do not register driver with invalid GUID
Message-ID: <_szgAop-lIsQt90xoCYXQbiJtrQclFitfhE2ak2omTiPCx37toqB4lq7OTmBD_vMEn6TonpAns5NgVH1xFpGQLyuLkd0pOGwRqrB8C9INRw=@protonmail.com>
In-Reply-To: <ZLjyDQ80QKWtKqUk@smile.fi.intel.com>
References: <20230715211604.1272227-1-pobrn@protonmail.com> <ZLUOxnE58wUgZXWx@smile.fi.intel.com> <mL0s5ZsO3eU18EzO_7zVsawf2rr7o-zsOrwBDncazQIAgRn-LRNTGw2ugm1bfRoHKWTRYmUHt8s7zjfNEESapwFZlaNj6B041x_AZ-pagoI=@protonmail.com> <ZLUmh0nKJdRMmhX1@smile.fi.intel.com> <kN5iBK5RwAEr8LXNTgb6dUk7zxuGFFtF2q_ReNezksLqaq7C4frYfo6ELswUu0wVoewy3UENAwFjjK48d2qBwf6q4is8ST28zpK6-ze_eIU=@protonmail.com> <ZLjyDQ80QKWtKqUk@smile.fi.intel.com>
Feedback-ID: 20568564:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi


2023. j=C3=BAlius 20., cs=C3=BCt=C3=B6rt=C3=B6k 10:36 keltez=C3=A9ssel, And=
y Shevchenko =C3=ADrta:

> On Wed, Jul 19, 2023 at 07:23:37PM +0000, Barnab=C3=A1s P=C5=91cze wrote:
> > 2023. j=C3=BAlius 17., h=C3=A9tf=C5=91 13:31 keltez=C3=A9ssel, Andy She=
vchenko =C3=ADrta:
> > > On Mon, Jul 17, 2023 at 11:23:50AM +0000, Barnab=C3=A1s P=C5=91cze wr=
ote:
> > > > 2023. j=C3=BAlius 17., h=C3=A9tf=C5=91 11:49 keltez=C3=A9ssel, Andy=
 Shevchenko <andriy.shevchenko@linux.intel.com> =C3=ADrta:
> > > > On Sat, Jul 15, 2023 at 09:24:16PM +0000, Barnab=C3=A1s P=C5=91cze =
wrote:
>=20
> ...
>=20
> > > > > Besides using wrong API (uuid_*() vs. guid_*() one), I don't
> > > >
> > > > As far as I can see `guid_parse()` also uses `uuid_is_valid()`, the=
 format is the same.
> > >
> > > Then add guid_is_valid() to complete the API. Perhaps with the renami=
ng the
> > > common part to something else.
> >
> > But that would be the exact same function. GUIDs are UUIDs, aren't they=
?
>=20
> Yes and no. If we want to validate the respective bit for GUID vs. UUID, =
they
> will be different. Currently they are the same as validation is relaxed i=
n the
> kernel.

I see. Regardless, that is the only check `guid_parse()` does, so I don't t=
hink
it is unreasonable to have only that check for the time being.


>=20
> > > > > think we need to validate it here. Why not in file2alias.c?
> > > > > [...]
> > > >
> > > > 1) that seems like a more complicated change (duplicating `uuid_is_=
valid()`?);
> > > > 2) that will only check the GUIDs specified by `MODULE_DEVICE_TABLE=
()`.
> > > >
> > > > Arguably the second point is not that significant since most users =
will indeed
> > > > use `MODULE_DEVICE_TABLE()`. But I think the first point has some m=
erit. And
> > > > furthermore, I think this check should be here regardless of whethe=
r file2alias.c
> > > > also contains an equivalent/similar check.
> > >
> > > Why do we need it? We never match against wrong GUID from ACPI, since=
 it would
> > > be very weird ACPI table.
> > > [...]
> >
> > The point is to catch typos in drivers' WMI ID tables.
>=20
> Yes, that's what file2alias is for. We trust modules we build, right?
> If you don't trust, then we have much bigger problem than this patch
> tries to address.
> [...]

It seems we have to agree to disagree then.


Regards,
Barnab=C3=A1s P=C5=91cze
