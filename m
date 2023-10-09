Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71C4B7BEAC6
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 21:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378446AbjJITmb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 15:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378420AbjJITma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 15:42:30 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF6DD93
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 12:42:28 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-27927d37ec7so3788673a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 12:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696880548; x=1697485348; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cPDCWjeLigUTOz7mgyt00FMkqMkRL1/1wVrDbyf+7ZI=;
        b=M8h3zhPtpcCXz5r1md5NF82uaNalbj2s1Bls5I1tVEBtxcJAa6qGmBmCUmNoryCW9I
         M3rHFZyxH5TMfD0hXRm7PWDgYQ6l51yowYkVabwzuBW3FOSm4W5qss37fTwvBXyu9Uvo
         XkHgu3Np6y+pI9eDI4K9i/HSFLP5j63zIuDhN7aHIb8tzWm0VI+QDUveTynvyr4c4zzw
         gnb4CcWT9Cp7jv9XlAK5IsLUpooOa0oLxydqYeoKPX2YBC75mLKzqr93DdYCojX8AtqV
         RnLGZk27sMuFO0PL8roy0D66owNXTct/7ZqeNsTrjhmI2hRBTfcNJTalaRafdttRV4pW
         LYKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696880548; x=1697485348;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cPDCWjeLigUTOz7mgyt00FMkqMkRL1/1wVrDbyf+7ZI=;
        b=GN8Ow10hUzi3e+U+RmMMuYEcB9p11YanVDokzoplSdz3sL8y1oQicl39q2b4qrZGRy
         gXLg3+dVI91WSoGxyO+/4GbBknwyFLyxHVBXgkSp154Z/95toq58JQ8+zOjO/Z2VxOTu
         fwmb/xTiFN032e/qDKAcA9AWXQvny+d0MIrX1sFalEeWzcyvRLdf5WDNA/4Q8z/8WocP
         4muCbj5nKLqYJfzEf3ph4M9qYy5UtAU3mwsYlrezYBI0/kXVub2+CYz3BFgbANLtZN8S
         VDDbgNopZ3pYRKGby0dLqmDnCT+jV6/fR71nswZN/3iTPrJ9r/uW75Q4HpxaluzeDCqN
         09xA==
X-Gm-Message-State: AOJu0YxUH6nhhNkLNwat3dI9EcDQa0HwIdcnh9Y6heIq3tWLkfjZWvn3
        1eSN+B2LQBoprQc0IOV0me9sMWStQBkO2RvIQVY=
X-Google-Smtp-Source: AGHT+IExYC+OPpUXmt1BVyq5dC6T8wbI+Aqd+dPhChcfblL9aoYP18a+MiC50PkcmK6zjyYImK5mF9a8bQwYSTG3W1g=
X-Received: by 2002:a17:90b:124c:b0:279:98f6:deac with SMTP id
 gx12-20020a17090b124c00b0027998f6deacmr15079471pjb.20.1696880548133; Mon, 09
 Oct 2023 12:42:28 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1696605143.git.andreyknvl@google.com> <6fad6661e72c407450ae4b385c71bc4a7e1579cd.1696605143.git.andreyknvl@google.com>
 <CANpmjNOp0yq2vQmSmTim=AF7bm9XdStbaQE9B=wVwpKkO_y6tQ@mail.gmail.com>
In-Reply-To: <CANpmjNOp0yq2vQmSmTim=AF7bm9XdStbaQE9B=wVwpKkO_y6tQ@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Mon, 9 Oct 2023 21:42:16 +0200
Message-ID: <CA+fCnZfES0OV16s3i3B-p2fGYhRa-Z3wQ5QzJbrCmGnfBgzC5w@mail.gmail.com>
Subject: Re: [PATCH 4/5] kasan: fix and update KUNIT_EXPECT_KASAN_FAIL comment
To:     Marco Elver <elver@google.com>
Cc:     andrey.konovalov@linux.dev,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>,
        kernel test robot <lkp@intel.com>
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

On Mon, Oct 9, 2023 at 10:48=E2=80=AFAM Marco Elver <elver@google.com> wrot=
e:
>
> On Fri, 6 Oct 2023 at 17:18, <andrey.konovalov@linux.dev> wrote:
> >
> > From: Andrey Konovalov <andreyknvl@google.com>
> >
> > Update the comment for KUNIT_EXPECT_KASAN_FAIL to describe the paramete=
rs
> > this macro accepts.
> >
> > Also drop the mention of the "kasan_status" KUnit resource, as it no
> > longer exists.
> >
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202308171757.7V5YUcje-lkp=
@intel.com/
>
> "Closes" isn't a valid tag? Reported-by + Link should be enough to attrib=
ute.

I believe it is: the robot asks to use it, see the link. (I think this
tag is also used by syzbot btw.)

> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
>
> Reviewed-by: Marco Elver <elver@google.com>

Thanks!
