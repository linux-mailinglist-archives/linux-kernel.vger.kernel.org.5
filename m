Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE5277CB6E7
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 01:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233567AbjJPXPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 19:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232172AbjJPXPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 19:15:14 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B3DA9B
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 16:15:11 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2c501bd6ff1so54342711fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 16:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1697498109; x=1698102909; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jiFv6IoUrhFAKU+BWwxAbcjyc1kfZd+ZTtqjUkgLJsc=;
        b=dkk6UIAXGZIwkpJ3EAKe+2sATuI1lMmkxhN5S3DM5dtgMHelHYDmIzhplv6VtsdDnK
         2nx15oXlnaKq+r8XWztmB4n9TWX29yhvgeaLRKEoDaG/3ysNDrzucG3000XIOPAl07RS
         jY1w046oLG7Fx3U8HCbsrNI49c1yrHJlsvToQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697498109; x=1698102909;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jiFv6IoUrhFAKU+BWwxAbcjyc1kfZd+ZTtqjUkgLJsc=;
        b=p9ZEwYj6wrwIhWIqxvMJLPxfpRTo55gHixPZ3dchqd57DhJMNPofaabePV+C8t1+PP
         3pNwEjVfZbVFGt2a9gkYzkvXXXzlthxiylIHVpazlA0OLkoqqJKcmwtgsyWujHg3yt9c
         n98mSt+eK7USxuamZPRFu27w+2wtG1sj9g0hE8ftTY15Qll2C/I/piATmWkFINZVmrVK
         MxGMdvsPPYIRXac/7AKWaRYtBv+WzCTlR/rGrLjzemiq/VuTOTYyMrQbboayffQ+ASeA
         HuYSzGPW24YFkC0q2P5AqOXE996rOtRJejwb15jCZeGDKeKoe/oiMXqYy3XMvW15lxu/
         SJoA==
X-Gm-Message-State: AOJu0YxqQl/f82+aDQtwGzx+f4ZNzXHhwT1FQtcP2DJ7QdFCytKq1oBH
        dTL1elkX5MH4Ew1aKt1SIhzUTt0CrwDzoC1HASzThpjE
X-Google-Smtp-Source: AGHT+IGBVFlyH2M2G1lmLi5On7bMe+V0CC6G2A19q0QMfwD6tYg4UMYEam9NqlKbHHcG/l5jpdjV2A==
X-Received: by 2002:a05:651c:44f:b0:2bf:fa62:5d0e with SMTP id g15-20020a05651c044f00b002bffa625d0emr508860ljg.2.1697498109516;
        Mon, 16 Oct 2023 16:15:09 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id h17-20020a2e9011000000b002c12b823669sm17864ljg.32.2023.10.16.16.15.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Oct 2023 16:15:08 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-507a29c7eefso3110762e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 16:15:08 -0700 (PDT)
X-Received: by 2002:a05:6512:3b85:b0:507:a04c:76eb with SMTP id
 g5-20020a0565123b8500b00507a04c76ebmr603611lfv.35.1697498108277; Mon, 16 Oct
 2023 16:15:08 -0700 (PDT)
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
In-Reply-To: <CAHk-=wj1dLFkL9Qv2vtk0O8Q6WE-11Jq3KucZoz2Kkw59LAexw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 16 Oct 2023 16:14:50 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi0mF0sFGweuhGaLyKCT-itO_RgbEcmxkgkwYxEzbHyzQ@mail.gmail.com>
Message-ID: <CAHk-=wi0mF0sFGweuhGaLyKCT-itO_RgbEcmxkgkwYxEzbHyzQ@mail.gmail.com>
Subject: Re: [PATCH v2 -tip] x86/percpu: Use C for arch_raw_cpu_ptr()
To:     Nadav Amit <namit@vmware.com>
Cc:     Uros Bizjak <ubizjak@gmail.com>,
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
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Oct 2023 at 16:02, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> so I think this is the right thing to do. I checked that the 32-bit
> code builds and looks sane too.

Just to clarify: the 64-bit side I actually booted and am running.

The 32-bit side is pretty much identical, but I only checked that that
'process_32.c' file still builds. I didn't do any other testing.

             Linus
