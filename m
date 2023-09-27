Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1FA47AF8A6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 05:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbjI0D2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 23:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjI0D0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 23:26:15 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 947639005;
        Tue, 26 Sep 2023 18:47:53 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-40594a6d1ecso11520805e9.1;
        Tue, 26 Sep 2023 18:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695779272; x=1696384072; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eP9N2gfeiWYXcjxAcn/cQZzNl5uPlV6uaT56umiTjo8=;
        b=mdZBYtkbGXhEIASl9MXbPlNQ4Fh56XGfHyTUP0QwiLyXtvoLaWDMWxHh8VcZJpdy1A
         tmg3iEPLb7Y/NarmpFuCsqo+B34sWqLs/PyDeKub7ZWqFEfTxC9qQOtM+ZLkm485qHZ8
         8Vk2ckW1hM9XJZ4f81NeZV2+YMP0XdbhO5kAAJ8UdYQgwGjjKQgASE7MXTWlAyQFc099
         Mv1PGfBEr3BqkiR5W9dO8Qa6tNwd4fBHfKrgLuJNyJC7CtlfBxQD7qK6T2QAMKhjrr2Z
         j21Ziah7ETDY+EDfNzh1xQfAfuz+YcYGeGRkmQc6JtbD3lTfr5TT7Th0JDz/zZLycdv9
         G2JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695779272; x=1696384072;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eP9N2gfeiWYXcjxAcn/cQZzNl5uPlV6uaT56umiTjo8=;
        b=lCDZEd4+kiIfHUzAgWpF2OzdWi9ktf8lFvn4C18J/iVF2oyWUcqWoyaz4Am2NzktbP
         DWUz4DSlvRCmbeh8hU0ONOqyvt4mgxx/Kg7r0jfQsRSbz05C76LZMHjy/edXoK+3jIVj
         Eg+l24lymIUu5pykLNrhPIkOyHBNpZ/Ip6hjHnFK8+J7JVuHCEvVlcu2lsmGTX9q/X/w
         TcfOIXkDxDrALNVXkKfMLMf4gKrDmbhEUGh060Dhoxk9UtmJhRjuColgT3ZS85CPPfps
         pq1Galr098ruUVoG/Yj+Kfw/VJpVOzFdBhi82+7ANkykY0gDP2b4uFktoDK97rcpzSlL
         i3gg==
X-Gm-Message-State: AOJu0YxqZW/KWqpheJSyiqv3odn45yjfss9t9qxrWHBwKLGs+l4RTpMd
        7/rUOTSCsxdoyunDgkSRZOjW/h9l/mj5mmPNdjDHrrIEgSo=
X-Google-Smtp-Source: AGHT+IEAaKAlOkvmR0LD66XKj8QWzk4M3h/3mWe27gg1G+gi8Qs8/Sv8nOxQdC0XyT/2gKyWkvIM/59GaOUJCyYn1EU=
X-Received: by 2002:adf:e5cf:0:b0:323:2e5d:b7c6 with SMTP id
 a15-20020adfe5cf000000b003232e5db7c6mr329201wrn.0.1695779271781; Tue, 26 Sep
 2023 18:47:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230925214046.1051350-1-anarsoul@gmail.com> <b0786bf5571050397b5075bac7c1e9023bfa5aec.camel@intel.com>
In-Reply-To: <b0786bf5571050397b5075bac7c1e9023bfa5aec.camel@intel.com>
From:   Vasily Khoruzhick <anarsoul@gmail.com>
Date:   Tue, 26 Sep 2023 18:47:24 -0700
Message-ID: <CA+E=qVc424VJsqGRR+SZbDmDdtdVmx+Ag6vt_brhZsNv1JTCRw@mail.gmail.com>
Subject: Re: [PATCH] ACPI: FPDT: break out of the loop if record length is zero
To:     "Zhang, Rui" <rui.zhang@intel.com>
Cc:     "rafael@kernel.org" <rafael@kernel.org>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2023 at 10:03=E2=80=AFPM Zhang, Rui <rui.zhang@intel.com> w=
rote:
>
> On Mon, 2023-09-25 at 14:40 -0700, Vasily Khoruzhick wrote:
> > Buggy BIOSes may have zero-length records in FPDT, table, as a result
> s/FPDT, table/FPDT table
>
>
> > fpdt_process_subtable() spins in eternal loop.
> >
> > Break out of the loop if record length is zero.
> >
> >
> > Fixes: d1eb86e59be0 ("ACPI: tables: introduce support for FPDT
> > table")
> > Cc: stable@vger.kernel.org
> >
> > Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
>
> Is there a bugzilla or something where such a buggy BIOS is reported?

I'm not aware of a bug filed a kernel bugzilla, however I found
mentions of the issue online:
https://forum.proxmox.com/threads/acpi-fpdt-duplicate-resume-performance-re=
cord-found.114530/

> > ---
> >  drivers/acpi/acpi_fpdt.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/drivers/acpi/acpi_fpdt.c b/drivers/acpi/acpi_fpdt.c
> > index a2056c4c8cb7..53d8f9601a55 100644
> > --- a/drivers/acpi/acpi_fpdt.c
> > +++ b/drivers/acpi/acpi_fpdt.c
> > @@ -194,6 +194,11 @@ static int fpdt_process_subtable(u64 address,
> > u32 subtable_type)
> >                 record_header =3D (void *)subtable_header + offset;
> >                 offset +=3D record_header->length;
> >
> > +               if (!record_header->length) {
> > +                       pr_info(FW_BUG "Zero-length record
> > found.\n");
> > +                       break;
>
> For cases like this, it implies the FPDT table is far from usable and
> we should stop processing on such platforms.

Here's FPDT dump:

00000000: 4650 4454 4400 0000 018c 414c 4153 4b41  FPDTD.....ALASKA
00000010: 4120 4d20 4920 0000 0920 0701 414d 4920  A M I ... ..AMI
00000020: 1300 0100 0100 1001 0000 0000 30fe 207f  ............0. .
00000030: 0000 0000 0000 1001 0000 0000 54fe 207f  ............T. .
00000040: 0000 0000                                ....

S3PT at 0x7f20fe30:

7F20FE30: 53 33 50 54 24 00 00 00-00 00 00 00 00 00 18 01  *S3PT$..........=
.*
7F20FE40: 00 00 00 00 00 00 00 00-00 00 00 00 00 00 00 00  *...............=
.*
7F20FE50: 00 00 00 00

FBPT at 0x7f20fe54:

7F20FE50: xx xx xx xx 46 42 50 54-3C 00 00 00 46 42 50 54  *....FBPT<...FBP=
T*
7F20FE60: 02 00 30 02 00 00 00 00-00 00 00 00 00 00 00 00  *..0............=
.*
7F20FE70: 2A A6 BC 6E 0B 00 00 00-1A 44 41 70 0B 00 00 00  **..n.....DAp...=
.*
7F20FE80: 00 00 00 00 00 00 00 00-00 00 00 00 00 00 00 00  *...............=
.*

It looks like subtables are not usable. S3PT subtable has the first
record with zero len, and FBPT has its signature again instead of the
first record header.

So yeah, I agree that FPDT is not usabled in this case, and it
shouldn't be processed further.

> So, IMO, it is better to
> 1. return an error here rather than break and return 0.
> 2. add the error handling for fpdt_process_subtable() failures.
>
> what do you think?

Agree, I'll implement it in v2.

Regards,
Vasily
