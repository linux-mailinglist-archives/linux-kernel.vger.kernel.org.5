Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54B1F76FCC7
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 11:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbjHDJD7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 05:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbjHDJDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 05:03:33 -0400
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D0CE4C28;
        Fri,  4 Aug 2023 01:59:19 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id 006d021491bc7-56cc3453e31so1199888eaf.1;
        Fri, 04 Aug 2023 01:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691139558; x=1691744358;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7sTwnH4sXUXtcKXQVId2GYx+QeFJgqq/fjklOp/tKBE=;
        b=mRMW2zm1R3UoTZXU+VKQTRQxtD3PPBxQkRCYagjaV1YoRq4Z+1p758Xoo4FcuHCSwU
         i1p5ibt2wSBPE/texY/ooxsUU29II2nNLlmO4SmmFjz/8LNtPcxOa5Z9/vFDJb+wLmNq
         YMnyfG2UWstxefSKe1oBoIAia/jTYzFVgdVz71VSvQwlbpLz6HATn1/44lpsl1hf4PVY
         Tub53w3GDGj+mfJyJHkxkOVasIt45n2cI937s4PzYu/RVVY14AcX5bFK7AI7U3oXRLal
         Mz7OkeDyjABmPZBusom4rdulnpVuGFhmGrs+usxq+jE4/3P0OriBEg3kwrV3SvgY89xh
         UEPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691139558; x=1691744358;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7sTwnH4sXUXtcKXQVId2GYx+QeFJgqq/fjklOp/tKBE=;
        b=GeBRJ90Bo2ClwJEuLNIEEJbjSuugNRXcMPrymrPiDab6EXfFDrWrcoh2qLf3OV2Ucz
         yQXwZX/Pk1c8QwFs5OCWpnoMUA7V2BNFnaIXFeqmSZ0QhNtFPqi5JVVOgXa+cCeHc9Rv
         Ukcp3gQkif8FWz6jDBf3heQRJEbKuUL6LPVhvRxeRJGaKke1i+gAOvHgTXqR1vPtSOgQ
         g55C+DRyC3KotSfslyGI4JwjXfcWYxs+g4dkA7aMHCqCo/E+vMVCUjhBAziukvcylR5V
         YW4X9jmYaZ4NNDie+5dj6dsOzyxVt1g8NX6/Z3iWwkwCPAw0E/lXl3cKkuO6Y02e8WPO
         BSsA==
X-Gm-Message-State: AOJu0Yyb9hkXR0bI4KrCf4O6jeb78cSPlC7H0qKGfdt+8ATCLvV5Svfm
        A2d6M2qknOwtvacQtlQw5aM/GMPDsiHn9xY5R70=
X-Google-Smtp-Source: AGHT+IFwZ3/hKq+/i6/QnY7q8SBrb5Npfu9TgiJnbkbiT0J+lslznP/X8zWN+IF5UO0mWdhVkceNpMjEhx8mbYRgXmA=
X-Received: by 2002:a4a:9243:0:b0:56c:8c66:cea6 with SMTP id
 g3-20020a4a9243000000b0056c8c66cea6mr1185978ooh.1.1691139558429; Fri, 04 Aug
 2023 01:59:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230801060432.1307717-1-yunlong.xing@unisoc.com> <202308040103.1514A8C3CB@keescook>
In-Reply-To: <202308040103.1514A8C3CB@keescook>
From:   yunlong xing <yunlongxing23@gmail.com>
Date:   Fri, 4 Aug 2023 16:59:07 +0800
Message-ID: <CA+3AYtRYNQKuM9-99LvZYZqraLokKV4bjuvYKyEPB3MG7+VevA@mail.gmail.com>
Subject: Re: [PATCH 1/1] pstore/ram: Check member of buffers during the
 initialization phase of the pstore
To:     Kees Cook <keescook@chromium.org>
Cc:     Yunlong Xing <yunlong.xing@unisoc.com>, tony.luck@intel.com,
        gpiccoli@igalia.com, joel@joelfernandes.org, enlin.mu@unisoc.com,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        enlinmu@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 4, 2023 at 4:10=E2=80=AFPM Kees Cook <keescook@chromium.org> wr=
ote:
>
> On Tue, Aug 01, 2023 at 02:04:32PM +0800, Yunlong Xing wrote:
> > From: Enlin Mu <enlin.mu@unisoc.com>
> >
> > The commit 30696378f68a("pstore/ram: Do not treat empty buffers as vali=
d")
> > would introduce the following issue:
> >
> > When finding the buffer_size is zero, it would return directly.However,=
 at
> > the same time, if the buffer's start is a illegal value, the others wou=
ld
> > panic if access the buffer.
>
> Which "others" do you mean?

About =E2=80=9Cothers", You can refer to the following panic call stack:
 sysdump_panic_event+0x720/0xd38
 atomic_notifier_call_chain+0x58/0xc0
 panic+0x1c4/0x6e4
 die+0x3c0/0x428
 bug_handler+0x4c/0x9c
 brk_handler+0x98/0x14c
 do_debug_exception+0x114/0x2ec
 el1_dbg+0x18/0xbc
 usercopy_abort+0x90/0x94
 __check_object_size+0x17c/0x2c4
 persistent_ram_update_user+0x50/0x220
 persistent_ram_write_user+0x354/0x428
 ramoops_pstore_write_user+0x34/0x50
 write_pmsg+0x14c/0x26c
 do_iter_write+0x1cc/0x2cc
 vfs_writev+0xf4/0x168
 do_writev+0xa4/0x200
 __arm64_sys_writev+0x20/0x2c
 el0_svc_common+0xc8/0x22c
 el0_svc_handler+0x1c/0x28
 el0_svc+0x8/0x100
>
> > To avoid these happenning, check if the members are legal during the
> > initialization phase of the pstore.
> >
> > Fixes: 30696378f68a ("pstore/ram: Do not treat empty buffers as valid")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Enlin Mu <enlin.mu@unisoc.com>
> > ---
> >  fs/pstore/ram_core.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/fs/pstore/ram_core.c b/fs/pstore/ram_core.c
> > index 85aaf0fc6d7d..eb6df190d752 100644
> > --- a/fs/pstore/ram_core.c
> > +++ b/fs/pstore/ram_core.c
> > @@ -519,7 +519,7 @@ static int persistent_ram_post_init(struct persiste=
nt_ram_zone *prz, u32 sig,
> >       sig ^=3D PERSISTENT_RAM_SIG;
> >
> >       if (prz->buffer->sig =3D=3D sig) {
> > -             if (buffer_size(prz) =3D=3D 0) {
> > +             if (buffer_size(prz) =3D=3D 0 && buffer_start(prz) =3D=3D=
 0) {
> >                       pr_debug("found existing empty buffer\n");
> >                       return 0;
> >               }
>
> And in the case of "buffer_size(prz) =3D=3D 0" but "buffer_start(prz) !=
=3D 0",
> this will be caught by:
>
>                 if (buffer_size(prz) > prz->buffer_size ||
>                     buffer_start(prz) > buffer_size(prz)) {
>                         pr_info("found existing invalid buffer, size %zu,=
 start %zu\n",
>                                 buffer_size(prz), buffer_start(prz));
>                         zap =3D true;
>                 }
>
> i.e. it will be detected and zapped back to a sane state.
No,This code has no chance of execution because there was a return 0 before=
 it
>
> That sounds correct to me, though I wonder if reporting it as an
> "invalid buffer" is inaccurate? Perhaps we should have a separate case:
>
>                 if (buffer_size(prz) =3D=3D 0) {
>                         if (buffer_start(prz) =3D=3D 0)
>                                 pr_debug("found existing empty buffer\n")=
;
>                         else {
>                                 pr_debug("found existing empty buffer wit=
h non-zero start\n");
>                                 zap =3D true;
>                         }
>                 } else if ...
>
> What do you think?
Good, I gree it. For me, it should not return directly while finding
the buffer_size is zero, We need Check others case.
So does the modification method you mentioned require me to resubmit a
patch or do you need to modify and merge it
>
> --
> Kees Cook
