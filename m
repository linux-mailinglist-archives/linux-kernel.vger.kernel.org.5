Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B917080DC0B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 21:51:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344853AbjLKUvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 15:51:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344835AbjLKUvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 15:51:10 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F4DEB5;
        Mon, 11 Dec 2023 12:51:16 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1d30141d108so8396155ad.2;
        Mon, 11 Dec 2023 12:51:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702327875; x=1702932675; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OckqF+ycLHzYHFxbjXbvIz3Ml946FujF+AQK5q5s1sM=;
        b=SCvV/7Lxz/d7iohJx9GUmFTtOF+/EU8OesVEO8ST5BFekp/E3yD+Wbe10dFUheBAkD
         BbfgNWP1S+kQNooerLH/ldznzvhLzVOsOJMi7ySrp0RkDrlwZrRuWgt/oL2TbqN5iwHP
         jEMf4GHvEIW3GS8zP73VNbZZ19pvFASmnIhJBPY/IY7BIcq8iIzc5YcFXSp4hs2HYwMO
         E1pRL0jo/zoEY82xz5apKbZErFrN15UmYBwTiUbaIl4HyUyGsKXZ/3+tls5LHKtSgBVl
         FGp9rr2Kv/5tYZxyu5kAi6cL1WwDals9YHtWLuw9snV0UsrPSUF4/UFGAIfBh1NydT+g
         qOwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702327875; x=1702932675;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OckqF+ycLHzYHFxbjXbvIz3Ml946FujF+AQK5q5s1sM=;
        b=tGEGF/3Rnq1TgzZ3wxTJpfPtrCHuudVk4qx2GZPn5VnpCzqDQm53sxALqoKA1qwraK
         BanmuK90A4XweWcHi2O6+hrLPExMomHUt2AiNcXZU1E18b66d6T8RWCavijJnfstxA0B
         z+Uo9o9Jga0+x5YbYNWATtgi9dmyFt0eaHRGfRZNqeIQ6w22gJtlPi27P17Y8MqpMOsf
         BPFWzTmqBaeTL80vVVtDdfjUl8tffQZvJdnAkE91Pf76xc35cawnD/WOkZ7tJ096hZwT
         0R4isZS/NSTaqaA20RbB+lVk3Q92DCjQnDxV0dCNNkFAf50qGKJ0X/5BCmUGeWan8u9m
         6+gw==
X-Gm-Message-State: AOJu0YzPVDvSlhw+mYZ2qxF2CKME/gyiSWwwL1nSsUAiaoApNzRWGX1u
        rOD+lIm1eg0az73IxbiTPvxQu1Ti5Znp4LnbGjo=
X-Google-Smtp-Source: AGHT+IEPBlm9uKygnaPDOIUZllJHKtTnroaHPRNtiorenP4WwZXATO18QCas7C3jxxvCCX276R3QqwSsVLgr1jR8DCI=
X-Received: by 2002:a17:90a:34c1:b0:286:6cc0:b918 with SMTP id
 m1-20020a17090a34c100b002866cc0b918mr2228620pjf.79.1702327875595; Mon, 11 Dec
 2023 12:51:15 -0800 (PST)
MIME-Version: 1.0
References: <CAMn1gO7Ve4-d6vP4jvASQsTZ2maHsMF6gKHL3RXSuD9N3tAOfQ@mail.gmail.com>
 <CANpmjNNvGL--j-20UxqX_WjeXGiAcjfDAQpfds+Orajz0ZeBsg@mail.gmail.com>
 <CAMn1gO6reT+MTmogLOrOVoNqzLH+fKmQ2JRAGy-tDOTLx-fpyw@mail.gmail.com>
 <CANpmjNN7Gf_aeX+Y6g0UBL-cmTGEF9zgE7hQ1VK8F+0Yeg5Rvg@mail.gmail.com>
 <20230215143306.2d563215@rorschach.local.home> <CAMn1gO4_+-0x4ibpcASy4bLeZ+7rsmjx=0AYKGVDUApUbanSrQ@mail.gmail.com>
 <CAMn1gO6heXaovFy6jvpWS8TFLBhTomqNuxJmt_chrd5sYtskvw@mail.gmail.com>
 <20230505095805.759153de@gandalf.local.home> <n37j6cbsogluma25crzruaiq7qcslnjeoroyybsy3vw2cokpcm@mh7r3ocp24cb>
 <CA+fCnZebmy-fZdNonrgLofepTPL5hU6P8R37==sygTLBSRoa+w@mail.gmail.com> <fv7fn3jivqcgw7mum6zadfcy2fbn73lygtxyy5p3zqpelfiken@5bmhbdufxgez>
In-Reply-To: <fv7fn3jivqcgw7mum6zadfcy2fbn73lygtxyy5p3zqpelfiken@5bmhbdufxgez>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Mon, 11 Dec 2023 21:51:04 +0100
Message-ID: <CA+fCnZfQEueCifc-8d5NVWEUtAiOG1eRW-LFKbOhab_Y7jqU0Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] kasan: switch kunit tests to console tracepoints
To:     =?UTF-8?Q?Paul_Heidekr=C3=BCger?= <paul.heidekrueger@tum.de>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Peter Collingbourne <pcc@google.com>,
        Marco Elver <elver@google.com>, andrey.konovalov@linux.dev,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-trace-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2023 at 7:59=E2=80=AFPM Paul Heidekr=C3=BCger
<paul.heidekrueger@tum.de> wrote:
>
> > Hi Paul,
> >
> > I've been successfully running KASAN tests with CONFIG_TRACEPOINTS
> > enabled on arm64 since this patch landed.
>
> Interesting ...
>
> > What happens when you try running the tests with .kunitconfig? Does
> > CONFIG_TRACEPOINTS or CONFIG_KASAN_KUNIT_TEST get disabled during
> > kernel building?
>
> Yes, exactly, that's what's happening.
>
> Here's the output kunit.py is giving me. I replaced CONFIG_DEBUG_KERNEL w=
ith
> CONFIG_TRACEPOINTS in my .kunitconfig. Otherwise, it's identical with the=
 one I
> posted above.
>
>         =E2=9E=9C   ./tools/testing/kunit/kunit.py run --kunitconfig=3Dmm=
/kasan/.kunitconfig --arch=3Darm64
>         Configuring KUnit Kernel ...
>         Regenerating .config ...
>         Populating config with:
>         $ make ARCH=3Darm64 O=3D.kunit olddefconfig
>         ERROR:root:Not all Kconfig options selected in kunitconfig were i=
n the generated .config.
>         This is probably due to unsatisfied dependencies.
>         Missing: CONFIG_KASAN_KUNIT_TEST=3Dy, CONFIG_TRACEPOINTS=3Dy
>
> Does CONFIG_TRACEPOINTS have some dependency I'm not seeing? I couldn't f=
ind a
> reason why it would get disabled, but I could definitely be wrong.

Does your .kunitconfig include CONFIG_TRACEPOINTS=3Dy? I don't see it in
the listing that you sent earlier.
