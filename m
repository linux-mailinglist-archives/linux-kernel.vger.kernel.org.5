Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E013F78EE66
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 15:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234413AbjHaNSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 09:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbjHaNSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 09:18:33 -0400
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0964DCEB;
        Thu, 31 Aug 2023 06:18:31 -0700 (PDT)
Received: by mail-oo1-xc2a.google.com with SMTP id 006d021491bc7-5735282d713so480811eaf.2;
        Thu, 31 Aug 2023 06:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693487910; x=1694092710; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bHwmmwrGfDSkCjztvNTCgRkwWwsnvAt3/1zqnbkw4UE=;
        b=Gfs5gUDAKnohkLuwenKHBFcc6MV9CUo3KFTYbyk3sooD+u5t9joBsLYpDwP/H0Aywp
         RUcUao9unx5wp3Bz/jAcm7JcqO7I5XJhY8R0s4GcvBw8CGHjOle7QNWfPm+uxQo6nsVv
         +etgkiD/f7mkU/oPtCiEp4p2bKofDVcdmJjtRwJ/wJEl8I2aEeIF8dblVW6rG78geZ2N
         if2HWf5fnyzmS1DAYzdAjC1VWsTSxG0wZTppa5dJkY3V8BKGnqy1s9pZP9TM4RHWE1wb
         VC08NBiXPGFSUVNQsw8vntE+H7QIDSp9+fa+2w15w9bdpp6Dtf6M5ZKLqq+SoiZJAERX
         5tjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693487910; x=1694092710;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bHwmmwrGfDSkCjztvNTCgRkwWwsnvAt3/1zqnbkw4UE=;
        b=aV2OrenRfa907kRxv+oBhLbRQjEuwJ/Yxwhtr6bVA8RrrHk+3Go/yPUtFv57X5Y9Ng
         2ew+TNYVZmQgp21B7icpdmYOIpguVLgPbENHN28eIycA6/CIq/h0tzrDz7bYeySYN9pX
         oSdhGJ4wekuUEWn3zuD8YEdMDLOcMg08UHDERn7TLbWLrJ0/D5wZrIwW0brbzYKyv1zw
         ZNiyRCiizyNHm/7LPYvtTbfEoLNoKquh6u9Qp6RR4tUi2afzKnUZ2ek2FBRwZkPhNNxI
         xKyN8rxyp3EhnDXrISQkSKzq2HEdFXKkTaE2Aoq1AhdHLYt19F9x+Mz0BKvmojADmqT+
         5W6g==
X-Gm-Message-State: AOJu0Yy8fEcWeCtSyyt5W8/RO11sldwOtGAaYGwg/EP+ohvLnpEcedHW
        WRqD0754TtQV1I24Zp82fde9TWDbGrW4uZX2sSE=
X-Google-Smtp-Source: AGHT+IEKwsKaxX8FN7thNvTRv4YUKZ/hXURRhwTFIgLKkuYrezXPSfhwY/Atro+sW4IO7Vj76e+t2OY3b1M7LZ7lpJE=
X-Received: by 2002:a4a:3013:0:b0:56d:e6:21bf with SMTP id q19-20020a4a3013000000b0056d00e621bfmr5008308oof.0.1693487910302;
 Thu, 31 Aug 2023 06:18:30 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1693386602.git.pstanner@redhat.com> <46f667e154393a930a97d2218d8e90286d93a062.1693386602.git.pstanner@redhat.com>
 <CAHp75VfkzV-=XuEZwipYzfHNu4EXuwzbu6vfEKh1Uueseo2=wA@mail.gmail.com>
 <94b893ef37fe0cc0bcc52e8b54c62be3853a7bbb.camel@redhat.com> <CAHp75VcNyE9uJu8-v2eVWRdZ3-nm2r-kdxE-naQB4VN6zxPFxg@mail.gmail.com>
In-Reply-To: <CAHp75VcNyE9uJu8-v2eVWRdZ3-nm2r-kdxE-naQB4VN6zxPFxg@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 31 Aug 2023 16:17:54 +0300
Message-ID: <CAHp75Vc6Bj87V5HVZeNXJRmN1qBYP8_eDDSj5tLnfL7d81o9+w@mail.gmail.com>
Subject: Re: [PATCH 1/5] string.h: add array-wrappers for (v)memdup_user()
To:     Philipp Stanner <pstanner@redhat.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Andy Shevchenko <andy@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Christian Brauner <brauner@kernel.org>,
        David Disseldorp <ddiss@suse.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Siddh Raman Pant <code@siddh.me>,
        Nick Alcock <nick.alcock@oracle.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Zack Rusin <zackr@vmware.com>,
        VMware Graphics Reviewers 
        <linux-graphics-maintainer@vmware.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org, linux-hardening@vger.kernel.org,
        David Airlie <airlied@redhat.com>
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

On Thu, Aug 31, 2023 at 4:16=E2=80=AFPM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Thu, Aug 31, 2023 at 3:22=E2=80=AFPM Philipp Stanner <pstanner@redhat.=
com> wrote:
> > On Wed, 2023-08-30 at 17:11 +0300, Andy Shevchenko wrote:
> > > On Wed, Aug 30, 2023 at 4:46=E2=80=AFPM Philipp Stanner <pstanner@red=
hat.com>
> > > wrote:

...

> > > I'm wondering if this has no side-effects as string.h/string.c IIRC
> > > is used also for early stages where some of the APIs are not availabl=
e.
> >
> > I forgot to address this point in my previous reply.
> >
> > Who's going to decide whether this is a problem or not?
> >
> > My personal guess is that this is unlikely to be a problem because
> >
> >    A. either (v)memdup_user() is available, in which case
> >       (v)memdup_array_user() will always work =E2=80=93
> >    B. or (v)memdup_user() is not available, which would cause the code
> >       that currently uses (v)memdup_user() for copying arrays to fail
> >       anyways.
>
> It also uses something from overflow.h. I don't remember if that
> header was ever been used in early stage modules (like
> boot/decompressor).

Also we need to be sure UML is still buildable. Dunno if they are
using anything from this, but it appeared to me recently that someone
tried to optimize something using (internal) kernel headers and broke
the build in some cases.

--=20
With Best Regards,
Andy Shevchenko
