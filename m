Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68359757C0B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 14:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232107AbjGRMn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 08:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231563AbjGRMn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 08:43:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 665FE188
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 05:43:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0467A61566
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 12:43:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AC30C433CD
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 12:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689684234;
        bh=H69WBcnYOQuCKZB+mMXzbqF5HH219LA2UP0b8Dgf3wI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LUb5Yhz5OZKJByb2qt+0w11sGoO5TvV/dTSlABh7IckZBkMW4olpKvn1WuRDR3YAf
         cG/xY+346fxreb1oS8dCkCSqQBOAS2hkVMOuh7x2ZWQT74L0ZByK+mRjuv7QExX5jb
         T8TJykY31EjvCsLS1evAJA0gn91OsITELyMOwMJpEIPun08HeQxw1hnPv9GwxR94La
         MBNuOYfs+PgYtQnkNC7vtZXZw2FD2A+JsjAnwyWjDZxm3z5S8M8iU4F/nh5Y42Afuy
         wnSJn9OK3c/v0gzVR1fVztFSbYKI0OkuPTdCvXGKmrNlHocx1UF8s+TnEwQiwTxLuU
         oUkuSCxwfKORA==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-4fbb281eec6so9026965e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 05:43:54 -0700 (PDT)
X-Gm-Message-State: ABy/qLaYITyUrWTuED7gIYk3t8z1b/bSC7XrtDzTPXK8Jd06yQkYAaDf
        JO9ymk4JZlR78zGx5ALEOhmiITBTM/1ukxq/kjI=
X-Google-Smtp-Source: APBJJlHdv/ZgRJmVrvBCdU4Ff03xN1zqvkYoiIOy0I+YBVfQzYMxNtWz7MNXye1Afm60aKXs2RpHNVuv6GLzp5POsWE=
X-Received: by 2002:a19:7918:0:b0:4fb:9050:1d92 with SMTP id
 u24-20020a197918000000b004fb90501d92mr8224508lfc.51.1689684232321; Tue, 18
 Jul 2023 05:43:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230615121016.3731983-1-chenhuacai@loongson.cn>
 <CAAhV-H49AyrG-sH2SXLNg_cX-Wv8vS4Qno_2N4v6ccGGciv-+A@mail.gmail.com> <ZJ9kWqhRCWkLcYyv@bombadil.infradead.org>
In-Reply-To: <ZJ9kWqhRCWkLcYyv@bombadil.infradead.org>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Tue, 18 Jul 2023 20:43:40 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7qk8wSFt=ZMUSUt4cAmH+-5AsGqszXNW9w+u6Y8vDN+A@mail.gmail.com>
Message-ID: <CAAhV-H7qk8wSFt=ZMUSUt4cAmH+-5AsGqszXNW9w+u6Y8vDN+A@mail.gmail.com>
Subject: Re: [PATCH] kthread: Rename user_mode_thread() to kmuser_thread()
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Luis,

On Sat, Jul 1, 2023 at 7:25=E2=80=AFAM Luis Chamberlain <mcgrof@kernel.org>=
 wrote:
>
> On Sun, Jun 25, 2023 at 04:55:33PM +0800, Huacai Chen wrote:
> > Friendly ping?
>
> You want to cc the folks who Nacked your patch. Until then, this
> probably can't go further.
Thank you very much. Eric and Andrew are already in the CC list, so
add Thomas now.

My brain is a little old-fashioned so I insisted that "a thread
without mm_struct should be a kernel thread" in the previous patch.
Unfortunately this makes Eric and Thomas unhappy, I'm very sorry for
that.

During the discussion of the previous patch I know I made some
mistakes about some basic concepts, but I also found the name
"user_mode_thread()" is somewhat confusing. I think rename it to
kmuser_thread() is better, because:
1, it identify init and umh as user threads;
2, it points out that init and umh are special user threads that run
in kernel mode before loading a user program.

Sorry for my rudeness again.

Huacai
>
>   Luis
