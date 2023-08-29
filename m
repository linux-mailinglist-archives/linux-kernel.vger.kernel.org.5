Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2DA378BC05
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 02:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234329AbjH2ANP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 20:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233844AbjH2AMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 20:12:44 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B71CE43
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 17:12:07 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-52a39a1c4d5so4968199a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 17:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1693267887; x=1693872687;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BzlSx/tZwdRXhDAhmF9UVWRVY0WUPs0em9CYy+YHbPA=;
        b=S+jDL+ys8VUQD0k7RqceEEgat3ByMjAqINxFhtbBM/REHeF+DoFdf/FSdnzClj3MJG
         susowtoy5w+nyklGmy52q2NM3+8q+LU/+xDm6uKL3Q2VN/SO6NCkYFCUzbNn3oPmMNmE
         tJRTEpITTdVMVjxrFVisO0eXNm3WU91H+c/o4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693267887; x=1693872687;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BzlSx/tZwdRXhDAhmF9UVWRVY0WUPs0em9CYy+YHbPA=;
        b=QU/3Xgy9fAXrtPUHfwE3l0T+bjZCg2NUoJk58S8m5jONCXOJs+B5fyXdSVy5oujX5Q
         cy2FQAsfdNdaPKRzhnHENEn0vcZp6UM/oqd5amS60v6yPX7/iaBfJpkxedlqDsYglslM
         HF4x5YkbNZpCdjdwZLXmYdez2Q0r69yT/R/pw5gdDQpN4tMWXVHyqBpGJvwHs7/DK4+T
         ZYHs1jG02TbJ9vaSXQmSbsrbo1JjVNOXVhfYVFqo6zsoeX6hzZATI1fk6e8aGb64tuMa
         uZx4PB3EsFeHTl/XEp1EQ0Q8xkzpQAodfwg+P5lrVyAsxxch0r0i1kPZT3V1WFWSf/hU
         aWbA==
X-Gm-Message-State: AOJu0YyeQTbw9a3Dms9V6M2MBhuyjSZxscjV4M3MOoMYZNgcmglSJKUZ
        mMz5aHQ2qffUV8+EjnkUDImLxcNPnZOMs534YTeVIbqw
X-Google-Smtp-Source: AGHT+IHnBNl8ZH2QmYCFogx1nQWv9sL/78yrp+AI2xCMwFdVPqWhZUnzw7GqfIvA5PeoVVYoKEwU9w==
X-Received: by 2002:a17:907:78d6:b0:9a1:cbe5:758c with SMTP id kv22-20020a17090778d600b009a1cbe5758cmr12401830ejc.7.1693267887636;
        Mon, 28 Aug 2023 17:11:27 -0700 (PDT)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id uz16-20020a170907119000b0099b6becb107sm5313842ejb.95.2023.08.28.17.11.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Aug 2023 17:11:27 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-99bcf2de59cso499248466b.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 17:11:26 -0700 (PDT)
X-Received: by 2002:a17:906:5358:b0:9a2:1ce5:123f with SMTP id
 j24-20020a170906535800b009a21ce5123fmr10113708ejo.76.1693267886438; Mon, 28
 Aug 2023 17:11:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230828122533.GBZOySPQIjw25NiUqI@fat_crate.local>
 <CAHk-=wjPNoHZm4ukpSXRCpxoCSb59GLgiDZBTgs-yn0=082TFw@mail.gmail.com> <CAHk-=wgYsC7XcPRwekr5RcqAn4EkjyhpjzB34i-GfyVe-unTbA@mail.gmail.com>
In-Reply-To: <CAHk-=wgYsC7XcPRwekr5RcqAn4EkjyhpjzB34i-GfyVe-unTbA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 28 Aug 2023 17:11:09 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjnKqHf3RCJuid_deMa6MHaARZVMg9LFMsx16R-wVUzqQ@mail.gmail.com>
Message-ID: <CAHk-=wjnKqHf3RCJuid_deMa6MHaARZVMg9LFMsx16R-wVUzqQ@mail.gmail.com>
Subject: Re: [GIT PULL] x86/microcode for v6.6-rc1
To:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Aug 2023 at 16:25, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Feel free to send me a follow-up patch to move that
> amd_check_microcode() declaration to whatever the appropriate place
> is.

.. actually, I have now gotten around to Ingo's "Misc x86 cleanups"
tree, and there I find the declaration movement to <asm/processor.h>
by Arnd.

So I ended up just making my tree match at that point.

                Linus
