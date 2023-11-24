Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B93C7F8518
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 21:12:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346044AbjKXUMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 15:12:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbjKXUMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 15:12:36 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E9BF1707
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 12:12:41 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-a04196fc957so336803466b.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 12:12:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1700856759; x=1701461559; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TCf2e1EXSjwPuuSKzIrJH5yWdmYJqYZ2ahdEqbl+dh8=;
        b=fii3w53dj5vUs+qziU2lhHlCCT8x42om3PueoXKw2Ih+1en2VjHXlEoncpujII/8JL
         kfa0KjPyDOBg1FRrcimzvokWUkzcjKv7z4OLo8O0VjdNwY32DsYgFMiQEh+VgKLKSSaM
         wIxE1wGG0V+VG4WQGDGpxGDtNzH9a2C7IgNnY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700856759; x=1701461559;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TCf2e1EXSjwPuuSKzIrJH5yWdmYJqYZ2ahdEqbl+dh8=;
        b=Zm+PDKz4PHQvXfHAyHo0nYFpW4IvNF0w7FKzQE9FVokvfg8KxTdgKKmV52lnb8eCE6
         XcFIiU0MtIJnXS1ZUKVLtz6mLRVc9YWHiihfstRruDOTrhQzZg68N3IYikd07Y/rUAkf
         EiqrlkrCP2WliWjL0bnrs6ZPXVpfD+yo/QqSE4HYSLZEqxvTMvcN8gdMJAd3QUTrE8bK
         7wLRr8J/m3wlYAEFsRXy1eGdx8TMNcB07weEhKJ0yEBRnbWNk2MVy+AId4QdQl1CJCVv
         WHYBj+S0X9qZ9Se3RePOiWp8GH7dwWzDC2PI3JtFz+Ppy7kpMrl9lvN4oNsKD4/84mcW
         /arg==
X-Gm-Message-State: AOJu0Yz+6QT63ceV0FSXo7XXlLBeRki8xF6KuCwPp37xeBqEzvplzYl0
        wfsSTmLpr0juW6bszt/ipTuWpeoxTErIL9xeeOwEgfTF
X-Google-Smtp-Source: AGHT+IFb/KATiY9t8TS8Ie1nz5/vbC5hTI+pdUOhADcvZcsjnpbFyQSYQOMsmRa87bfS61jDxOMc3A==
X-Received: by 2002:a17:906:197:b0:a0a:7e3c:be2b with SMTP id 23-20020a170906019700b00a0a7e3cbe2bmr1248207ejb.55.1700856759639;
        Fri, 24 Nov 2023 12:12:39 -0800 (PST)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id bn10-20020a170906c0ca00b00a0949d4f637sm1100094ejb.222.2023.11.24.12.12.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Nov 2023 12:12:39 -0800 (PST)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a00c200782dso337338766b.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 12:12:38 -0800 (PST)
X-Received: by 2002:a17:906:a1c8:b0:9a1:891b:6eed with SMTP id
 bx8-20020a170906a1c800b009a1891b6eedmr3423738ejb.76.1700856758205; Fri, 24
 Nov 2023 12:12:38 -0800 (PST)
MIME-Version: 1.0
References: <20231124-vfs-fixes-3420a81c0abe@brauner> <CAHk-=wiJFsu70BqrgxtoAfMHeJVJMfsWzQ42PXFduGNhFSVGDA@mail.gmail.com>
 <CAHk-=wg0oDAKb6Qip-KtA5iFViy6EPWHt2DfCcG8LCXTb7i00w@mail.gmail.com>
In-Reply-To: <CAHk-=wg0oDAKb6Qip-KtA5iFViy6EPWHt2DfCcG8LCXTb7i00w@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 24 Nov 2023 12:12:20 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjCS30Mqy9b=op2f=ir9iPQfQ2Efjo1b8yMeJrXcWTtWA@mail.gmail.com>
Message-ID: <CAHk-=wjCS30Mqy9b=op2f=ir9iPQfQ2Efjo1b8yMeJrXcWTtWA@mail.gmail.com>
Subject: Re: [GIT PULL] vfs fixes
To:     Christian Brauner <brauner@kernel.org>,
        Omar Sandoval <osandov@fb.com>,
        David Howells <dhowells@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Nov 2023 at 10:52, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Gaah. I guess it's the VM_IOREMAP case that is the cause of all this horridness.
>
> So we'd have to know not to mess with IO mappings. Annoying.

Doing a debian code search, I see a number of programs that do a
"stat()" on the kcore file, to get some notion of "system memory
size". I don't think it's valid, but whatever. We probably shouldn't
change it.

I also see some programs that actually read the ELF notes and sections
for dumping purposes.

But does anybody actually run gdb on that thing or similar? That's the
original model for that file, but it was always more of a gimmick than
anything else.

Because we could just say "read zeroes from KCORE_VMALLOC" and be done
with it that way.

                  Linus
