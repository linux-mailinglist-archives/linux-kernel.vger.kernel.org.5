Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46FD07D010A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 19:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346329AbjJSR50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 13:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235502AbjJSR5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 13:57:25 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CAD9136
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 10:57:23 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-53df747cfe5so14428116a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 10:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697738242; x=1698343042; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rD0auMna/G8UtkxOnP1VpkXXubqCDzIy0ubtyJSg/vM=;
        b=H8B575Ba75TdEA7Ll5fW87YgPLRBGkc1ikCqxYIUeKZqmQvLd/Y5lvilg/hBAlVvSk
         cR0WnkjqXULKDYbnRQdx8IBpKE9Ik9bBp36NwWWbgN4mOP2ek+UIj99I6eMXPvDrAdYF
         isuxNCmpZGijRokW4mFYnIyr0vQOyyhRAh0kbG6KKdQvoMkBadLns564Lr8OeHI58SBC
         YV7LAQUTRzc3eV9+lH6z92K6+kLFvHIHYqJR+xRBTHjyVR7YcVLCYr67/slH+Ofz/pZW
         EMLzYDAl6MFRZ9xxD69h49PTROI56AJ7G2t1ayocTfGRrfetMsoj2nU+VorlsFLTRGsO
         08tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697738242; x=1698343042;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rD0auMna/G8UtkxOnP1VpkXXubqCDzIy0ubtyJSg/vM=;
        b=vr+R1RC1fj6HhB+/eBcXa03cCUGSFmohIGExR7IyJb5mF/Z5Qlul3a0To/I1/uV3Z2
         dmexWcpopy8hHPiECx/GMkKVNshcnJN20x7VRbhi9094uDjVYLKXaGPuLhoMs7Ggjm8L
         hn1J2S3hbQvLX6Rlk0bYVMJfcAfny+TFOybdVZSCjIm478EUj0snbTHAGLb+YzyGufk9
         8wo42OXtkxW4SGzJ3Kni3RqJQIw4Keg81SD6RmfAmo30iZfHGc+KxEN2cL6z0J8HBnCt
         pqyfi0pXuaZrB2IQnW5c/RVQPfz6sn2EhR1Ky5LF0wfpo+E2jHo1IC/PF5zO5KU+T2kX
         6zww==
X-Gm-Message-State: AOJu0YyciCOaRZG+YriV24E5//2g8/0zFQMIRFB+hO4NpO56No3t/DaI
        Z80ByVoXrzGL53gyG0t1542ICTw3KGKR9N96MDE=
X-Google-Smtp-Source: AGHT+IExQxo8T6PTUcrbYgciOHSYdKfFSAI7/IPwOx3zjfdkQm5nlBIQUtYa+IETYSXcTvrtKQcwD7oLrDniRgkRWpM=
X-Received: by 2002:a17:907:930a:b0:9c5:64b5:45cc with SMTP id
 bu10-20020a170907930a00b009c564b545ccmr2183910ejc.14.1697738241303; Thu, 19
 Oct 2023 10:57:21 -0700 (PDT)
MIME-Version: 1.0
References: <CAAMvbhG40h6pqSf91BurDHQqeoKfP30bwnpvSDRHBN4Hoygqew@mail.gmail.com>
 <ZTCLLinnaqIILXsJ@debian.me> <cf6950bc-32c8-459c-a4b1-ca0a291fc2f8@infradead.org>
In-Reply-To: <cf6950bc-32c8-459c-a4b1-ca0a291fc2f8@infradead.org>
From:   James Dutton <james.dutton@gmail.com>
Date:   Thu, 19 Oct 2023 19:13:38 +0100
Message-ID: <CAAMvbhHvyiWKb9Pn9=JUuE_efWK2EMcy2SBP6p_BvLGCjwW_VA@mail.gmail.com>
Subject: Re: Is strncpy really less secure than strscpy ?
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Justin Stitt <justinstitt@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Calvince Otieno <calvncce@gmail.com>,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Shevchenko <andy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Oct 2023 at 02:49, Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>
[snip]
>
> What if printf("a is  %.*s\n", a);?
Um, it fails to compile.
>
> >
> >
> > So, why isn't the printk format specifier "%.*s" used more instead of
> > "%s" in the kernel?
>
> Since basically strings are pointers.
Um, I was trying to draw people's attention to the fact that "%.*s" is
much safer than "%s".
"%s" is like strcpy() but for print statements.
"%.*s" is like strncpy() but for print statements.

Why wasn't "%.*s" also included in the string discussions previously?
