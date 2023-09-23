Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 827D97AC440
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 20:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232173AbjIWSCu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 14:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232077AbjIWSCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 14:02:49 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD6D8127
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 11:02:42 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9a9d82d73f9so484377566b.3
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 11:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1695492161; x=1696096961; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=merlx8zyFVbSTOkQ7KtQ6LzM5SBv7ZrAIafExSV7TA4=;
        b=M8a3v+u8pR+OVrs61fuvI8nFrqRlVyEAohGuCWsgT+vKVoqQXBBBFxl8MOqiFAv5rb
         kKq21+dJdNBgkGsKfDcghlw/CJvX464/M5Iq9FlQoppZiE0ol4xb5QDJHP0m4gZ7nyJt
         G3lrBM0anLByTZVJcuwjC791U5nvlNWbduSQI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695492161; x=1696096961;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=merlx8zyFVbSTOkQ7KtQ6LzM5SBv7ZrAIafExSV7TA4=;
        b=LcL5kUbSwv7/8rbC8EcNh6+odPVuLAre07idoTT6U5fza8TuNYQaKk9gmXqcm6qV6k
         zn5WUgXX6BR6ee7WZwAzR0xYY39VQWVU+GU0aPYS3V7H9vWdjTOVooNa6MqX3n4HIibZ
         p+yaPON++vQnwbo4KbshOrT+xXF6x7ExqMQWyFND73FbcQibTLbPVV6pokhiw42oz37S
         nOJT0IuLV5SC8whB71ht4O1aAxp7SfKSou9kyM70k465HP2D1zOUHejr2v6Isre79LnQ
         yMHa8oLv7cIsBGEiNdShIJhBG40hDqSPfWESkZmFcAaWD0PEUHi+3Zfo3hRTCOnNWDZt
         BSwg==
X-Gm-Message-State: AOJu0Yz62YmF3xjYzjLRYfNnnLNQAPmqAGTnrdxN5SSEywa2deU1rcUv
        LSw6Ra5S+zcGFqBFWqN8Oviq40AwimQCSDSyxnenjLLg
X-Google-Smtp-Source: AGHT+IHzB7iukXapYe1Tggp4SBrwacMGZ5aQFrwVlvmuZDnzolZSFFk1NHP7Q7gFJKJnq3smxLZyzA==
X-Received: by 2002:a17:907:75f4:b0:9ae:40d1:999b with SMTP id jz20-20020a17090775f400b009ae40d1999bmr2154163ejc.16.1695492161069;
        Sat, 23 Sep 2023 11:02:41 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id z21-20020a1709063a1500b0099d0c0bb92bsm4155757eje.80.2023.09.23.11.02.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Sep 2023 11:02:40 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5230a22cfd1so4565517a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 11:02:39 -0700 (PDT)
X-Received: by 2002:aa7:d5c6:0:b0:533:6ef4:9f5b with SMTP id
 d6-20020aa7d5c6000000b005336ef49f5bmr1917272eds.6.1695492159622; Sat, 23 Sep
 2023 11:02:39 -0700 (PDT)
MIME-Version: 1.0
References: <202309220957.927ADC0586@keescook> <CAHk-=wg0C+eEm0Tegpvc1zZjcqkdG9L0ed10tg_rQ1-WZciMGA@mail.gmail.com>
 <2983cda7-f084-4eb2-811d-158f43e99e47@p183>
In-Reply-To: <2983cda7-f084-4eb2-811d-158f43e99e47@p183>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 23 Sep 2023 11:02:22 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgSHAS-HLmGH_p+NwGEHsOPgtDq8=f_iRpZDdFs4XquCw@mail.gmail.com>
Message-ID: <CAHk-=wgSHAS-HLmGH_p+NwGEHsOPgtDq8=f_iRpZDdFs4XquCw@mail.gmail.com>
Subject: Re: [GIT PULL] hardening fixes for v6.6-rc3
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Sept 2023 at 09:53, Alexey Dobriyan <adobriyan@gmail.com> wrote:
>
> This doesn't work with g++ :-(

Whee. So the compiler seems to literally test "is it at offset 0", and
refuses to do flex arrays there.

Oh well. So flex arrays are just not usable on C++, because the
language tries to "protect" us from outselves. What else is new. I
suspect it's the same broken reason that empty structs aren't
zero-sized - stop the user from being clever.

I had hoped that the C++ people had learnt from their mistakes, but no.

Happily we don't have to deal with that crud for kernel code. I don't
like the #ifdef, but if it's needed...

                 Linus
