Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8501C786BE1
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 11:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240005AbjHXJ3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 05:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239433AbjHXJ30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 05:29:26 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D986E67;
        Thu, 24 Aug 2023 02:29:24 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id 46e09a7af769-6bdacc5ed66so388962a34.1;
        Thu, 24 Aug 2023 02:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692869363; x=1693474163;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C9Np9rhswG2lM4RqG/GxnXvjeyufDHIsif5l5dirrcU=;
        b=bzA5bZbuG0eVWNSETkRUVSGKT46EyGzeQoh3VxOcq3DzmoNQvLmI50nQzLed1Pyygx
         s61k9+ai74EzDlr0rzeanT7yQa2rVcQmBNbynzxCpUlS8wgShO6onemNMpHWdUoGxjur
         /Z6aruaTqmty4AbxUKZ5b0yLeMmjNQmyZwkWjOZ+Ig3t2m8MDg9mdSDtkh7iW4mh6l8X
         A67qA0r/mdDwoT6h/xDZRONKdcOu4ttujZaxANrik0bZvtw1Ef+E5/OgTHmcFGRm0jGP
         ardUvrj2YA9MeX8s4MsuOcG+8Uvql6DMtrwHdrvcIUwCLKgmgrn+TqK58MLjr5/yN+qz
         o8Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692869363; x=1693474163;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C9Np9rhswG2lM4RqG/GxnXvjeyufDHIsif5l5dirrcU=;
        b=MWLmO7vz9sX+VuEbedWbnZNI5Wbe1/8ZR5DNtcCzoBGH3v0XtEdsj/P0XJjoFDx/6H
         Ohly9OxneP0ML9aLNqsF7cAqFuryV2Yi4qsHMhroLvVzLpfld0fdY6ABhFGxwZJFKrpw
         Rdce4ogoqB9uNU1Zxi+8l5cK/HjcSZz9E4X5E9ZcCu6soTQ7BlDYK+iVwVZ/RDwgU8fh
         ZiQv5AS8JdeafY/zB4OqRPdQvGIaYPAJxkUYS5O9P/gUWtPAyE+W0+tGiCa1MvIBXM8D
         jIMM5tW/sc01Z63+C9TnUFToxXUdxI+4uOGZAHzw8ZhpQBJqRLDrATsCYr/yaSvTUb/F
         D+zA==
X-Gm-Message-State: AOJu0YwexEZZag1e81jF7dlYDOvfvJoVvk0U8f+XTtOcZ1RV35b7iM6B
        wi/JzQUnE8xDwnz8BGePCh7eYl2gcAcBE07SDls=
X-Google-Smtp-Source: AGHT+IELv86tPFEe0IZ3ozVag+2XtvaXb7rAtjPqBF8LBFMJ1uQQVIR068dF7DARv8J2DyEo/KCw861I7DEjvdnSV4M=
X-Received: by 2002:a9d:71d2:0:b0:6bd:9e1c:93a6 with SMTP id
 z18-20020a9d71d2000000b006bd9e1c93a6mr999534otj.0.1692869362757; Thu, 24 Aug
 2023 02:29:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230824075448.76548-1-jiapeng.chong@linux.alibaba.com> <260a285f-4dec-5443-401b-eaeeb58b58d9@redhat.com>
In-Reply-To: <260a285f-4dec-5443-401b-eaeeb58b58d9@redhat.com>
From:   Ilya Dryomov <idryomov@gmail.com>
Date:   Thu, 24 Aug 2023 11:29:10 +0200
Message-ID: <CAOi1vP-7eC9WALP=fiQ_VPv8D0aPAMJS45WYwxRWSKaTB3Cv7Q@mail.gmail.com>
Subject: Re: [PATCH] ceph: Remove duplicate include
To:     Xiubo Li <xiubli@redhat.com>
Cc:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        jlayton@kernel.org, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
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

On Thu, Aug 24, 2023 at 10:18=E2=80=AFAM Xiubo Li <xiubli@redhat.com> wrote=
:
>
>
> On 8/24/23 15:54, Jiapeng Chong wrote:
> > ./fs/ceph/mds_client.c: crypto.h is included more than once.
> >
> > Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> > Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=3D6211
> > Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> > ---
> >   fs/ceph/mds_client.c | 1 -
> >   1 file changed, 1 deletion(-)
> >
> > diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> > index 7cfa0e3aedb4..9a3b617270c3 100644
> > --- a/fs/ceph/mds_client.c
> > +++ b/fs/ceph/mds_client.c
> > @@ -16,7 +16,6 @@
> >   #include "super.h"
> >   #include "crypto.h"
> >   #include "mds_client.h"
> > -#include "crypto.h"
> >
> >   #include <linux/ceph/ceph_features.h>
> >   #include <linux/ceph/messenger.h>
>
> Reviewed-by: Xiubo Li <xiubli@redhat.com>

I folded the fix into "ceph: encode encrypted name in
ceph_mdsc_build_path and dentry release" commit.  Thanks for
the report!

                Ilya
