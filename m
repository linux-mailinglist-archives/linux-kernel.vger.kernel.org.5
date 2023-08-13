Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29B3477A890
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 18:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232035AbjHMQDm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 12:03:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231642AbjHMQDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 12:03:23 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B266C1BF9
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 09:02:58 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-51e28cac164so9567493a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 09:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1691942549; x=1692547349;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=g5ugHtb+gFLqHmdHj/rIBNWAy0u9pV9CjmqakNJzIxY=;
        b=Oj0mSsS46jeV/oUT5MAXfcjss6McfNfiKYQrraiQMRL8sTJBw4d8L4S8yxi/lYj7/A
         7r3S5rxoqAmN6oWXyEodKqbZEwXf6+pND145SyK6r7I//24q0FiBkBdxVi4vJltOF7bT
         lO4vZDPaKABMHKqKaR3tn6kp7YpOPeVcnRgOc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691942549; x=1692547349;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g5ugHtb+gFLqHmdHj/rIBNWAy0u9pV9CjmqakNJzIxY=;
        b=FSFxwRFJsaAekts4A+fe0nzX+sZDnbw4eJKrjibyfPEymLMyC/iKeaZsmWpw+Cm4+R
         sWGDwSBJUyilW3wRbaxuPrlDCfu0khmomOwItF2ToO9i9KPDQVB5/tyXhuLhbdMfoDx7
         4luz2/HmePgX2wuOWI0gjE/GG9q7jE4IBXhhNDDKYraas3h14wCiwt/h3m31BsNrPCoK
         xjpFOSzoHW7ahzrm3dhIAPdKq//9/9VPpI+1AiJ9l4rUGeBjVJhNQWXs9+LL6hx4gPM8
         Xdh3jEPD6JqtrF1jHGh/gJg9xB/Usgf6Ryoa+Rl9/rUcnQlxt4HRNBDgH2yobekVWZjl
         A9tg==
X-Gm-Message-State: AOJu0YzOqO8pf1PEfmrCedoEnigrYqvuaOkZksSB85cXeVi0NnhRlMOj
        wkn8MTDZc6fPHg0iQS3zNx+DRxzKG5HecWe1DPM67ppR
X-Google-Smtp-Source: AGHT+IHKoT6GDdnkTHswkIkc1pllfHV33GlwAxzLl7AXIT5NwUAg2dCjdwkqKuzqp/jNXsWMUyb5Sw==
X-Received: by 2002:a05:6402:3508:b0:51e:4218:b91b with SMTP id b8-20020a056402350800b0051e4218b91bmr11749143edd.1.1691942549205;
        Sun, 13 Aug 2023 09:02:29 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id a22-20020aa7d756000000b005233f8e064dsm4489229eds.89.2023.08.13.09.02.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Aug 2023 09:02:28 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-52256241c66so7375524a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 09:02:27 -0700 (PDT)
X-Received: by 2002:aa7:c683:0:b0:523:3e27:caa7 with SMTP id
 n3-20020aa7c683000000b005233e27caa7mr6430259edq.20.1691942547533; Sun, 13 Aug
 2023 09:02:27 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000094ac8b05ffae2bf2@google.com> <000000000000ab16cf0602ce0f9d@google.com>
In-Reply-To: <000000000000ab16cf0602ce0f9d@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 13 Aug 2023 09:02:10 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjsitvsCyu0+Pu8Hdmzd6XaCjugktE5aQVjUbCRYgQU=Q@mail.gmail.com>
Message-ID: <CAHk-=wjsitvsCyu0+Pu8Hdmzd6XaCjugktE5aQVjUbCRYgQU=Q@mail.gmail.com>
Subject: Re: [syzbot] [modules?] general protection fault in sys_finit_module
To:     syzbot <syzbot+9e4e94a2689427009d35@syzkaller.appspotmail.com>
Cc:     bpf@vger.kernel.org, chris@chrisdown.name,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        llvm@lists.linux.dev, mcgrof@kernel.org, nathan@kernel.org,
        ndesaulniers@google.com, syzkaller-bugs@googlegroups.com,
        trix@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Aug 2023 at 06:38, syzbot
<syzbot+9e4e94a2689427009d35@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit f1962207150c
> ("module: fix init_module_from_file() error handling")
>
> dashboard link: https://syzkaller.appspot.com/bug?extid=9e4e94a2689427009d35

Looks right. Apparently syzkaller had two different bugs attributed to
this. It was already marked as fixing syzbot issue
x=9c2bdc9d24e4a7abe741

#syz fix: module: fix init_module_from_file() error handling

             Linus
