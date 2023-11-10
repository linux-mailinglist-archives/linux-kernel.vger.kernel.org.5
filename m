Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D71F47E84E1
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 22:02:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbjKJVBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 16:01:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjKJVBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 16:01:10 -0500
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B5069F
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 13:01:04 -0800 (PST)
Received: by mail-ua1-x930.google.com with SMTP id a1e0cc1a2514c-7ba45fc8619so1022401241.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 13:01:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699650063; x=1700254863; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gcCycjsmcCz3FzgprLMKFbxpjQZ3n7eNM/WpUxUKFZc=;
        b=M8qnkjR6CuJsDJztN+hL66Qv4P0dwXBPHPBPcthoMolY5afBQ2xl7RNFvT5Etl7wuP
         OW12HUy29kAtspP76OM6mgLwdYkojgZARqT7sRgeBnxWnOaC4x8k/J1xDvKFhmgfOt6t
         mS+vV8UyYGpQArduFqW+hF5JFtNowyAGgvAZi3ENFw9jZZk1bXpP/ScNwlpNMxOtzaV/
         SOtwswYTKZc/jKPEv696H6XlJdCPpL3Mc4BGbVBLCyzOekv0/vIR0h5jSSAjCFYn3msg
         mPhMLYPc8YtvbjviEYrJ4Qi5sR51SmnMjeAlQ9dVciH1yMTqpMOeUeBbUhScgaUAUapu
         1m+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699650063; x=1700254863;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gcCycjsmcCz3FzgprLMKFbxpjQZ3n7eNM/WpUxUKFZc=;
        b=M0FonRx7/2aKNEYA8w+NhXk/6rrh5P/yMfZSupPbrrETKomns0GnaNrKZ5SHkhUPvz
         +58gWnpMHp8IQW4V53YqY3199RaW7W2kOYdmNHPFyopWCu6tDQmq/w9e9nFn+tKOokxQ
         yNm0BlysocnpUDjWcyY65K17BugO+dxg7w8FgOiwnf0AT6kG8dKgnifYRC1SxuX96crY
         z44Eb7oKJhNNw7VF3kqQciEMaslnyD8NvR2pSZ7jkR+5XQ4OxtLarHVvkTLZ53KangQm
         0nKfGFUksDkbbbcZGNe6ewQLhCbRLLwrXtwWC+8qVbAdiXEYVK0Br1YjC3eLvrbRfPWN
         gngQ==
X-Gm-Message-State: AOJu0Yz0vAcCY9DLK6TfPp+WV/j9RYmEbbinYwtpeiJLaZ0pvTlqxuwf
        FLdqLsuivF6GdCYN6fDC2cTEog03x7uGOGzmKzo=
X-Google-Smtp-Source: AGHT+IH7PU+hIiIqqzUuNfyy1RC9hNhNEGzWRMV7NrnoWUbvZNdf3gcRprkj2J3ufI906E5BUl84bGye48SrdBfH/EM=
X-Received: by 2002:a67:cb83:0:b0:45f:9ee:d1c8 with SMTP id
 h3-20020a67cb83000000b0045f09eed1c8mr545691vsl.20.1699650063619; Fri, 10 Nov
 2023 13:01:03 -0800 (PST)
MIME-Version: 1.0
References: <20231103131011.1316396-1-lb@semihalf.com> <20231103131011.1316396-8-lb@semihalf.com>
 <CAJfuBxzWSyw-Xp3k5WzOexbRZFydCUp_nX4A_BZs8Gq0OE2U7Q@mail.gmail.com> <CAK8ByeL=A6xC=q8Ah4im4JQGUcN_NZNg10pSezBPCeKW9J_DeQ@mail.gmail.com>
In-Reply-To: <CAK8ByeL=A6xC=q8Ah4im4JQGUcN_NZNg10pSezBPCeKW9J_DeQ@mail.gmail.com>
From:   jim.cromie@gmail.com
Date:   Fri, 10 Nov 2023 14:00:37 -0700
Message-ID: <CAJfuBxzH=G++Qs86OGUFTC2WuBZh8JZ4y7a7KcVi+7R8L3N7Fw@mail.gmail.com>
Subject: Re: [PATCH v1 07/12] dyndbg: repack struct _ddebug
To:     =?UTF-8?Q?=C5=81ukasz_Bartosik?= <lb@semihalf.com>
Cc:     Jason Baron <jbaron@akamai.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Guenter Roeck <groeck@google.com>,
        Yaniv Tzoreff <yanivt@google.com>,
        Benson Leung <bleung@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Pekka Paalanen <ppaalanen@gmail.com>,
        Sean Paul <seanpaul@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        upstream@semihalf.com
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

On Fri, Nov 10, 2023 at 7:51=E2=80=AFAM =C5=81ukasz Bartosik <lb@semihalf.c=
om> wrote:
>
> sob., 4 lis 2023 o 02:49 <jim.cromie@gmail.com> napisa=C5=82(a):
> >
> > On Fri, Nov 3, 2023 at 7:10=E2=80=AFAM =C5=81ukasz Bartosik <lb@semihal=
f.com> wrote:
> > >
> > > From: Jim Cromie <jim.cromie@gmail.com>
> > >
> > > Move the JUMP_LABEL to the top of the struct, since theyre both
> > > align(8) and this closes a pahole (unfortunately trading for padding,
> > > but still).
> > >
> > > Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
> >
> > let me add, I havent really tested this, nevermind thorough.
> > specifically, I didnt look for any offset dependence on the static-key
> > inside their container.
> > Conversely, maybe theres a free default or something in there.
> >
>
> Any idea how to properly test the relocation of the key ?

I was hoping Jason knew it from memory.

I have booted dd-kitchen-sink, which includes it, and it didnt melt the box=
.

I just checked `pahole vmlinux` output for the existence of 0-offset keys.
Its not conclusive, cuz im only looking at x86.

it does occur, but only for "sub-types".

struct static_key_true {
        struct static_key          key;                  /*     0    16 */

        /* size: 16, cachelines: 1, members: 1 */
        /* last cacheline: 16 bytes */
};
struct static_key_false {
        struct static_key          key;                  /*     0    16 */

        /* size: 16, cachelines: 1, members: 1 */
        /* last cacheline: 16 bytes */
};
struct static_key_false_deferred {
        struct static_key_false    key;                  /*     0    16 */
...};
struct static_key_mod {
        struct static_key_mod *    next;                 /*     0     8 */
...};
struct static_key_deferred {
        struct static_key          key;                  /*     0    16 */
