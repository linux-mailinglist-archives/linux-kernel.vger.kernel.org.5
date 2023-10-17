Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B83507CCEDE
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 23:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234808AbjJQVGK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 17:06:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbjJQVGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 17:06:09 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0DBC9F
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 14:06:06 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-507975d34e8so6561355e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 14:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697576765; x=1698181565; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zIVGpmrEfvGCoVLuovs/VFu2oojvFUXynCFBKml5c+c=;
        b=OdtEMmc99mgjt6XALFV/SIQRnf1lVpakjUqVijJ6LczGvrhQ8+xwupzHEkF+OlGSfV
         QZu5letCYV7io/u6eOK/ug/jlmo57BtPTmWg2ZtV5nysO817NqkJgG1Q2BhEx8T8TVSB
         TQCuy81A9FrLMg2mZFDGXZVHoxP6fb1I81WebeLkGeQfqwQ/OsYF5Y/4SSWe3xnVgr/l
         ptqZIAy3QUr7F0EGdTBwF/ft/pAsmUOCr1Y4H1EUAFo5Sjf0OcFTyCwPjpqAVt0lwvPB
         UvHHwGJiIfexzfe9Yvc5lqxrtdOxZYbo9rQSR+szdhjELsRtNyPB0j23jnnbkZMEoBQG
         XiSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697576765; x=1698181565;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zIVGpmrEfvGCoVLuovs/VFu2oojvFUXynCFBKml5c+c=;
        b=LcVPTM0c2uAxEH/+5RIKyIj7+n8amBKydSW5Uwevciba42zem15rw8EFGWiuGkF0Zf
         WhTfvBw8Rp5GhZ6A4EGlf5MwJ+3Gxsm5J7KliWBHV7FfcpccXYf43RGtE5lvgF4wLkIM
         n2UMLBxmIxCBrApmIiolp3kulUgpUwlYiyvUqbbjx6E2YdE18+wOY8klh7k+JwaE3Su2
         iAUBXUMOi3ydjqmQfraz2hHyovF9A2jz+Nek1Rlkfx1wdWPw60ifQqxmr8FTwVu+dg7w
         CyvTs9SIqbThjSZIF5VL3pZjgHBX/kKJ+QHwb9EnF/0SCrZ9twV+ejBelJbhNlm15mqw
         tLQw==
X-Gm-Message-State: AOJu0YziCAp5VYv4D2Xw6dDbKHdwO1/4ztR8BPIKApDmrNRRbBvQ/AM0
        Vi6LMzN4hZBdiKePL8cH6PW9dAqmCL6Uwq43dw0=
X-Google-Smtp-Source: AGHT+IFgWyUPoksmBSxsbzqcUCWGrAXhC9fkZ9N83wHEa4Tfjmbg0g0jISORydeDw2UoL64NB6Srqe8rdnNWQdfwwys=
X-Received: by 2002:ac2:518b:0:b0:507:b922:f925 with SMTP id
 u11-20020ac2518b000000b00507b922f925mr2773171lfi.9.1697576764866; Tue, 17 Oct
 2023 14:06:04 -0700 (PDT)
MIME-Version: 1.0
References: <20231010164234.140750-1-ubizjak@gmail.com> <CAHk-=whYWhZN52SJN-Th9x2L2V-vHtAXUgiy_nSJ3+vQU6ak4Q@mail.gmail.com>
 <CAFULd4ZqH3FeG8_mjDvUAU9QiGB36wDu3MzUtadgAgoVuQ9QRg@mail.gmail.com>
 <CAHk-=wiALZxieQQmvv5sW15HYB_YwC3d_ma9sdp7Zb4Fb4uK2w@mail.gmail.com>
 <F48A9D34-3627-4372-B555-B58CBFC3F241@vmware.com> <CAHk-=wjF4gzCZKh-zN-sY0WpX1kCo+s9gYE9sOcSv0QieH1dwQ@mail.gmail.com>
 <CAFULd4bmOa7G2dXd_mu4J=_bsEs+TbxH691tYx9QQBwJPAma9w@mail.gmail.com>
 <CAHk-=wj2Co_g3RQ=JkDZC7PYbRqDPq7mePQ0=eYhhtpEgqJD0w@mail.gmail.com>
 <0617BB2F-D08F-410F-A6EE-4135BB03863C@vmware.com> <CAFULd4Zjd6idrLXuF59cwKxyd1a--DsiJwGQAKai9Tph30dAow@mail.gmail.com>
 <CAHk-=wgSsfo89ESHcngvPCkQSh_YAJG-0g7fupb+Uv0E1d_EcQ@mail.gmail.com>
 <7D77A452-E61E-4B8B-B49C-949E1C8E257C@vmware.com> <CAHk-=wj1dLFkL9Qv2vtk0O8Q6WE-11Jq3KucZoz2Kkw59LAexw@mail.gmail.com>
 <9F926586-20D9-4979-AB7A-71124BBAABD3@vmware.com> <CAHk-=wi7YKPKKZw5SpA9gZcf4paG4pZ2kUM50g-LQmdF0g6vWg@mail.gmail.com>
 <CAFULd4bpHkNzCzKed23mTTBWRyhPnOm91f+F6UE413VK+oFtMQ@mail.gmail.com>
In-Reply-To: <CAFULd4bpHkNzCzKed23mTTBWRyhPnOm91f+F6UE413VK+oFtMQ@mail.gmail.com>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Tue, 17 Oct 2023 23:05:52 +0200
Message-ID: <CAFULd4Z-q4Ot6iyOLo7DkjE=dY3RHXUV+yx6R0iWk=-tZ6ufhQ@mail.gmail.com>
Subject: Re: [PATCH v2 -tip] x86/percpu: Use C for arch_raw_cpu_ptr()
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Nadav Amit <namit@vmware.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: multipart/mixed; boundary="0000000000000d2c9b0607efe4f9"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000000d2c9b0607efe4f9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 17, 2023 at 9:11=E2=80=AFPM Uros Bizjak <ubizjak@gmail.com> wro=
te:
>
> On Tue, Oct 17, 2023 at 9:00=E2=80=AFPM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > On Tue, 17 Oct 2023 at 00:23, Nadav Amit <namit@vmware.com> wrote:
> > >
> > > Yes, the FPU issue is the one that caused me to crash before.
> >
> > Uros, can you verify whether that patch of mine resolves the issue you =
saw?
> >
> > That patch is _technically_ an actual bug-fix, although right now our
> > existing 'current' caching that depends on just CSE'ing the inline asm
> > (and is apparently limited to only doing so within single basic
> > blocks) doesn't actually trigger the bug in our __switch_to() logic in
> > practice.
>
> Unfortunately, it doesn't fix the oops :(
>
> I'm testing your patch, together with the attached patch with the
> current tip tree (that already has all necessary percpu stuff), and
> get exactly the same oops in:

But adding the attached patch on top of both patches boots OK.

Uros.

--0000000000000d2c9b0607efe4f9
Content-Type: text/plain; charset="US-ASCII"; name="p.diff.txt"
Content-Disposition: attachment; filename="p.diff.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_lnutb9fn0>
X-Attachment-Id: f_lnutb9fn0

ZGlmZiAtLWdpdCBhL2ZzL2V4ZWMuYyBiL2ZzL2V4ZWMuYwppbmRleCA2NTE4ZTMzZWE4MTMuLjNl
ODEwYmFkZjlhYiAxMDA2NDQKLS0tIGEvZnMvZXhlYy5jCisrKyBiL2ZzL2V4ZWMuYwpAQCAtMTAz
Nyw3ICsxMDM3LDggQEAgc3RhdGljIGludCBleGVjX21tYXAoc3RydWN0IG1tX3N0cnVjdCAqbW0p
CiAJCW1tcHV0KG9sZF9tbSk7CiAJCXJldHVybiAwOwogCX0KLQltbWRyb3BfbGF6eV90bGIoYWN0
aXZlX21tKTsKKwlpZiAoYWN0aXZlX21tKQorCQltbWRyb3BfbGF6eV90bGIoYWN0aXZlX21tKTsK
IAlyZXR1cm4gMDsKIH0KIAo=
--0000000000000d2c9b0607efe4f9--
