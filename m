Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25CB975E279
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 16:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbjGWOOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 10:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjGWONi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 10:13:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B970191
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 07:13:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3944F60D3E
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 14:13:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A4F5C433CD
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 14:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690121616;
        bh=UNaK5accp1ZwP3ldqWX+XmypiJ0xhGUuuZsk7zhlSQw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=iNdQcLV8Ep9KYJCqkmRFYgcOl0e91fePudNAaqXmkVF68b/lDZO2xPvjfSG0/EERi
         i1lbGU6bm8RNs0+l9o30a6tx4aKyoIodUjevyO0I4qiakbafihw7hK6/02S42mq605
         SK93gjrGJqU6LgaW3ygm6z6QZ9+zzIK0TRgj9j45EPoHf4e0A7vHuOZUmhtm6Kl31F
         qGOQVKhe1n3ZSfm3nAzwARfERewTQwAZOddj+4sCTzWMjdRA6/CvONVgTHr3wVQsEN
         uFkI5cvaH/Tai6B2TBIWGC0tc054sTYfB+xYGMEXClA+ribu1vN5vaep6gVXgb2ZkK
         Q3dxv+Y3HRWsA==
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-51ff0e3d8c1so4907033a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 07:13:36 -0700 (PDT)
X-Gm-Message-State: ABy/qLablAxBUtVsaJHNLno/WfXHLYApsLRviYvy3xeJfWAlb6BNFEnp
        G6wRGAsogyxfbU0GBnjJM49vILUX3LxqcTPMOY8=
X-Google-Smtp-Source: APBJJlF81pdK1S5qyov7uXaNJT8toiXRPZCn5bAAB50MkmBHTmXN9RB2JTeu7HCmJAa15BjS1Q2ACUTR3OZuVQL59ZY=
X-Received: by 2002:aa7:c459:0:b0:522:2711:871 with SMTP id
 n25-20020aa7c459000000b0052227110871mr1630550edr.1.1690121614807; Sun, 23 Jul
 2023 07:13:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230615121016.3731983-1-chenhuacai@loongson.cn>
 <CAAhV-H49AyrG-sH2SXLNg_cX-Wv8vS4Qno_2N4v6ccGGciv-+A@mail.gmail.com>
 <ZJ9kWqhRCWkLcYyv@bombadil.infradead.org> <CAAhV-H7qk8wSFt=ZMUSUt4cAmH+-5AsGqszXNW9w+u6Y8vDN+A@mail.gmail.com>
In-Reply-To: <CAAhV-H7qk8wSFt=ZMUSUt4cAmH+-5AsGqszXNW9w+u6Y8vDN+A@mail.gmail.com>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Sun, 23 Jul 2023 22:13:23 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7RgkZJ2hfmNmJXKqcYeE1q11V4-2Ni0j-FLJ0b5fc=Sg@mail.gmail.com>
Message-ID: <CAAhV-H7RgkZJ2hfmNmJXKqcYeE1q11V4-2Ni0j-FLJ0b5fc=Sg@mail.gmail.com>
Subject: Re: [PATCH] kthread: Rename user_mode_thread() to kmuser_thread()
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Eric,

On Tue, Jul 18, 2023 at 8:43=E2=80=AFPM Huacai Chen <chenhuacai@kernel.org>=
 wrote:
>
> Hi, Luis,
>
> On Sat, Jul 1, 2023 at 7:25=E2=80=AFAM Luis Chamberlain <mcgrof@kernel.or=
g> wrote:
> >
> > On Sun, Jun 25, 2023 at 04:55:33PM +0800, Huacai Chen wrote:
> > > Friendly ping?
> >
> > You want to cc the folks who Nacked your patch. Until then, this
> > probably can't go further.
> Thank you very much. Eric and Andrew are already in the CC list, so
> add Thomas now.
>
> My brain is a little old-fashioned so I insisted that "a thread
> without mm_struct should be a kernel thread" in the previous patch.
> Unfortunately this makes Eric and Thomas unhappy, I'm very sorry for
> that.
>
> During the discussion of the previous patch I know I made some
> mistakes about some basic concepts, but I also found the name
> "user_mode_thread()" is somewhat confusing. I think rename it to
> kmuser_thread() is better, because:
> 1, it identify init and umh as user threads;
> 2, it points out that init and umh are special user threads that run
> in kernel mode before loading a user program.
>
> Sorry for my rudeness again.
Excuse me, but could you please tell me what your opinion is. In my
opinion a typical user thread is created by
pthread_create()/sys_clone(), it is better to distinguish typical user
threads from init and umh.

Huacai
>
> Huacai
> >
> >   Luis
