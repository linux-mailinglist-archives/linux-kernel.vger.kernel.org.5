Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7EB7E5312
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 11:08:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344044AbjKHKI3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 05:08:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235406AbjKHKI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 05:08:28 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDC801726
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 02:08:25 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-778925998cbso429754685a.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Nov 2023 02:08:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699438105; x=1700042905; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4wGGir6AVBqgYA9x3Zbac4F5sWP9OwD7U2p91KydZfY=;
        b=lBAiJUAY8SHaLBh8iol/OPbb+Y6aDhNxTrbb8eyevPwd6WXyN7EQkBvpbD5FEXflzY
         kMNX+y6VuYksbjQI4mAXYM/z787iZ7/glAhe8xVaBha2ihvZVNj0GxRKdcTgwnL8suef
         2PNDwwE9ls8/1WZ9DQxB31LlnN0LTosy+SabWMmcPF3u7HQJA3L+uXhUX47lk4EoJzsH
         3UUgD7VNP9GCXwtvrqS9HZlb+wOjcWlPo+skrDKxYGw0vqAmnrBlv6X5ynhJxXcSjTl2
         4CZbTWJWfSG6NqN2Qs0wyledSav75y/lQT/rztMwMaTiuwDDx381my6UjU+yarrqU57V
         YbVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699438105; x=1700042905;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4wGGir6AVBqgYA9x3Zbac4F5sWP9OwD7U2p91KydZfY=;
        b=voSEfcbTIHJDO1GjgHjYjoXZG58JgBWcRtwSE+sUSMG9213hOoNBov05g70SayO7iq
         b5/CW/AJATAXaaCMfRHM0u7cFnnJ4ybCrsQT5Tw/op5YJ6WfFS7XtE/KGQqRFZSrcTmQ
         JP41ijUW+rgVCR/BgpQ5PtBcBzDjMbgMYjbxVtHRfjKPrIvQRhvCOu8zU/nKhIrhY/Ot
         emFofjDRiNqJsjVV5VpCcxgl1rUgGmft1/q3r8/y9MLP1FsGuj4htzCu6fDsftqJ6+bE
         A5JmvLcauaiPkMWuD5TJMpUIftExa8cXp6DFvDXWDnCUlPwIW7JX43JuIGC7ZONI8Rzt
         TlMA==
X-Gm-Message-State: AOJu0Yx8HNEi4ZpclR0WiPaxdCbgMj3PojAXiRG8PmWixC/aw1bQhGju
        eWr7iTeS8+SmJUpixrVuwYONrXlpw4HhzI84qe1eXw==
X-Google-Smtp-Source: AGHT+IFhHW/0DOROPJfJKVsS+cLUcq4hLMWxKYvyzkWCZDfN04ji8RSuzBLB7GHnSU4rjlNqYKcfdwKdxSRQ2WUJvwg=
X-Received: by 2002:a05:6214:e87:b0:673:72a4:b0bc with SMTP id
 hf7-20020a0562140e8700b0067372a4b0bcmr1711949qvb.38.1699438104938; Wed, 08
 Nov 2023 02:08:24 -0800 (PST)
MIME-Version: 1.0
References: <202310170708.fJzLlgDM-lkp@intel.com> <bd7fe929-c6fc-42be-9d2f-3f53ec21fd10@intel.com>
 <ZUkvOCxyiin_77qd@smile.fi.intel.com> <0a29df6b-bc27-43e9-a97d-57ecabb29a9e@intel.com>
 <CAG_fn=VtA6e3oGm4WVnxmy9yMBab780-U_4VoHSqm4tcd2UTzQ@mail.gmail.com>
 <ca0ad357-727b-4f41-a3d6-2c48a9dd5836@intel.com> <e3b4b1a6-5383-4bfb-ba83-ab27d58dae29@intel.com>
 <ZUqCpmDgKFbscRgW@yury-ThinkPad> <457b9cbb-9a5f-47ef-9eac-3e4f135d6a96@intel.com>
 <ZUqPAZC4sS455xtx@yury-ThinkPad>
In-Reply-To: <ZUqPAZC4sS455xtx@yury-ThinkPad>
From:   Alexander Potapenko <glider@google.com>
Date:   Wed, 8 Nov 2023 11:07:44 +0100
Message-ID: <CAG_fn=WPNROrC4ndAa_JOoOiWYSh3gQat1fqiv+3jdvFXcpw=A@mail.gmail.com>
Subject: Re: [alobakin:pfcp 11/19] include/linux/bitmap.h:642:17: warning:
 array subscript [1, 1024] is outside array bounds of 'long unsigned int[1]'
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Alexander Lobakin <aleksander.lobakin@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Syed Nayyar Waris <syednwaris@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        kernel test robot <lkp@intel.com>,
        oe-kbuild-all@lists.linux.dev, linux-hardening@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 7, 2023 at 8:24=E2=80=AFPM Yury Norov <yury.norov@gmail.com> wr=
ote:
>
> On Tue, Nov 07, 2023 at 07:52:19PM +0100, Alexander Lobakin wrote:
> > From: Yury Norov <yury.norov@gmail.com>
> > Date: Tue, 7 Nov 2023 10:32:06 -0800
> >
> > > On Tue, Nov 07, 2023 at 06:24:04PM +0100, Alexander Lobakin wrote:
> > >> From: Alexander Lobakin <aleksander.lobakin@intel.com>
> > >> Date: Tue, 7 Nov 2023 17:44:00 +0100
> > >>
> > >>> From: Alexander Potapenko <glider@google.com>
> > >>> Date: Tue, 7 Nov 2023 17:33:56 +0100
> > >>>
> > >>>> On Tue, Nov 7, 2023 at 2:23=E2=80=AFPM Alexander Lobakin
> > >>>> <aleksander.lobakin@intel.com> wrote:
> > >>
> > >> [...]
> > >>
> > >>> I tested it on GCC 9 using modified make.cross from lkp and it trig=
gers
> > >>> on one more file:
> > >>>
> > >>> drivers/thermal/intel/intel_soc_dts_iosf.c: In function 'sys_get_cu=
rr_temp':
> > >>> ./include/linux/bitmap.h:601:18: error: array subscript [1,
> > >>> 288230376151711744] is outside array bounds of 'long unsigned int[1=
]'
> > >>> [-Werror=3Darray-bounds]
> > >>>
> > >>>> to give the compiler some hints about the range of values passed t=
o
> > >>>> bitmap_write() rather than suppressing the optimizations.
> > >>>
> > >>> OPTIMIZER_HIDE_VAR() doesn't disable optimizations if I get it
> > >>> correctly, rather shuts up the compiler in cases like this one.
> > >>>
> > >>> I've been thinking of using __member_size() from fortify-string.h, =
we
> > >>> could probably optimize the object code even a bit more while silen=
cing
> > >>> this warning.
> > >>> Adding Kees, maybe he'd like to participate in sorting this out as =
well.
> > >>
> > >> This one seems to work. At least previously mad GCC 9.3.0 now sits
> > >> quietly, as if I added OPTIMIZER_HIDE_VAR() as Yury suggested.
> > >
> > > What's wrong with OPTIMIZER_HIDE_VAR()? The problem is clearly on GCC
> > > side, namely - it doesn't realize that the map[index+1] fetch is
> > > conditional.
> >
> > It's totally fine for me to use it, this one is just an alternative
> > (well, a bit broken as per below).
>
> OK, guys, that's even worse. The 12 and 13 don't fire the warning
> because Warray-bounds is explicitly disabled for gcc-11+. Check
> 0da6e5fd6c372 ("gcc: disable '-Warray-bounds' for gcc-13 too"). I'll
> test how gcc-10 builds it, and if it's broken too, it's worth to shift
> the threshold in init/Kconfig.

Yes, that's my point.
According to Godbolt, GCC versions 9.1 to 13.2 (trunk included) are
reporting the same false positive on the code I posted above.

In 5a41237ad1d4b62008f93163af1d9b1da90729d8 ("gcc: disable
-Warray-bounds for gcc-11 too") Linus says that "Older gcc versions
end up being increasingly less relevant", so I think there won't be
objections against extending this rule to GCC 9 and 10.
