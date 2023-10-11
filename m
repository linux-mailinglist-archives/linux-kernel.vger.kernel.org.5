Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 731787C4767
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 03:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344673AbjJKBrI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 21:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344636AbjJKBrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 21:47:07 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9702F9E
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 18:47:05 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-32003aae100so260917f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 18:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1696988824; x=1697593624; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tzAxAbhfO5fDQKli+KSnHfx+fk0ksCyLQoQRxAIETUQ=;
        b=RFtqYqcFeSZ81G37/YQ9N/3UM9DAozgvknBA+RoBnXESi1GdIc7V/92eUSLSwnffUb
         75H2l1IEhUq49gbUrf2woWCfBsOnJIoUzfV4COigDROTv1/971Cxkrz9y+Q8t5gC3/as
         L/CnnBT9EYxHTAH7c56p3Szo8QuucHpEWzETBgu+Qo0Z5twm0DnbzSYnM1wzyjS+UFMh
         U+KlWSbH5I2D/WLSoJnpqQ2ZWF1GZHVoi+xFgjlB5f4W2zIZqAmDWc8ZGT4/mX7HeYpz
         3h67ITihdKQGSe3FAnbwxiAs6E7MPua/svYXKgW956+73WC7VhIjZjgaUF2/fo5wENUf
         NLkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696988824; x=1697593624;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tzAxAbhfO5fDQKli+KSnHfx+fk0ksCyLQoQRxAIETUQ=;
        b=KCv5FJHVs3WRZpdjvovqD09T9vRpy5q2lJ9RHRb7au0Mm4J5q/J1E4bXsoWutWTzmH
         0R/JMAzp9h9ElVM4B9sqKeFIprlC1HgO9/d8shvoeMz77aOiKCRkNqrPP6E4l/BlV/wu
         k6hf5iNKSLPuO/Dmm3viyoB02MevmTRqYNeC3PZjSjuM4nJjeLpjzIA4bWFC1Gd3YzxU
         j7vtuBVNiVENo+ezy456SH1PqdifpA9nqenNp4Ws+B7YjJ27ABg/KxLpHBRjhO/qz6Pd
         fvWhkquXong97WdFdHm24lMhzps0i+q0IMTMeMkrxIIa55yeVXCT98+gZBen9mxTM52i
         nKMg==
X-Gm-Message-State: AOJu0YzF3R5uoW7v7/+YVHsaK86Uo7Gfl8FX4C9LHMBincmqLq6Kg+fv
        Jj50S6W5DbEWZhQI9wAVmJW0d/Hfdj11Ig8J87WOCg==
X-Google-Smtp-Source: AGHT+IEUVGGgeYbJ114nPBxfHjS4sE3dP8/OO36c/IOC7Goh6EjU83CUE0Z9puhjfc7OnvtUy9Dw6oPHvOXMTESgUEw=
X-Received: by 2002:adf:e641:0:b0:320:a4e:acf5 with SMTP id
 b1-20020adfe641000000b003200a4eacf5mr13733659wrn.34.1696988823901; Tue, 10
 Oct 2023 18:47:03 -0700 (PDT)
MIME-Version: 1.0
References: <CAEEQ3wnfOOpKAKGt07cFv1Du-NaFOzX_=yeQZfD6VNojpPFTqA@mail.gmail.com>
 <202310091307.CB416B950@keescook> <CAEEQ3wnA=_TjE-nD2UzSSEsbjBmeE23V0KdA3MkqkOCxtwv=Vw@mail.gmail.com>
In-Reply-To: <CAEEQ3wnA=_TjE-nD2UzSSEsbjBmeE23V0KdA3MkqkOCxtwv=Vw@mail.gmail.com>
From:   yunhui cui <cuiyunhui@bytedance.com>
Date:   Wed, 11 Oct 2023 09:46:52 +0800
Message-ID: <CAEEQ3wmH0u1p4gWX454Hx09m5=LQ_+3VPWiEHogn_QiS-po4BQ@mail.gmail.com>
Subject: Re: [External] Re: Discuss the implementation of pidns_install()
To:     Kees Cook <keescook@chromium.org>
Cc:     brauner@kernel.org, jeffxu@google.com, akpm@linux-foundation.org,
        cyphar@cyphar.come, mcgrof@kernel.org, frederic@kernel.org,
        lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christian,

On Tue, Oct 10, 2023 at 11:29=E2=80=AFAM yunhui cui <cuiyunhui@bytedance.co=
m> wrote:
>
> Hi Kees Cook=EF=BC=8C
>
> On Tue, Oct 10, 2023 at 4:08=E2=80=AFAM Kees Cook <keescook@chromium.org>=
 wrote:
> >
> > On Wed, Sep 20, 2023 at 05:37:20PM +0800, yunhui cui wrote:
> > > Hi Kees, jeff, Andrew, Christian,
> > >
> > > We hope that containers at the same level can also switch pid namespa=
ce.
> > > To fork() the entire pstree of a container, we need to switch from th=
e pid
> > > namespace of the template container to the  target container's pid
> > > namespace. But it is blocked by the following code:
> > >
> > > ...
> > >         while (ancestor->level > active->level)
> > >                 ancestor =3D ancestor->parent;
> > >         if (ancestor !=3D active)
> > >                 return -EINVAL;
> > > ...
> > >
> > > Can we give this code permission, such as CAP_SYS_ADMIN ..., so that =
those
> > > with this permission can switch to sibling pid namespace. Rather than=
 just
> > > parent, parent ...
> > >
> > > Do you think this plan is okay?  Or can you give me some suggestions?
> >
> > I'll defer to Christian on this, but it seems like moving processes
> > sideways is kind of unexpected. I agree it'd need privilege if we did
> > it, though.
> >
> >
>
> I'll defer to Christian on this, but it seems like moving processes
> sideways is kind of unexpected. I agree it'd need privilege if we did
> it, though.
>
> Thanks for your suggestion, my plan is to give this code SYS_ADMIN permis=
sions.
>
> CAP_SYS_ADMIN has been checked in pidns_install(), as follows:
> static int pidns_install(struct nsproxy *nsproxy, struct ns_common *ns)
> {
> ...
> if (!ns_capable(new->user_ns, CAP_SYS_ADMIN) ||
> !ns_capable(current_user_ns(), CAP_SYS_ADMIN))
> return -EPERM;
> ...
> }
>
> So can I delete this code:
> ancestor =3D new;
> while (ancestor->level > active->level)
> ancestor =3D ancestor->parent;
> if (ancestor !=3D active)
> return -EINVAL=EF=BC=9B
>
> Thanks=EF=BC=8C
> Yunhui

Could you help me look into this issue?
