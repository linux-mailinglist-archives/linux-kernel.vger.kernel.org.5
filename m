Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F52F7F858A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 22:42:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjKXVly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 16:41:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjKXVlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 16:41:51 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16F09172E
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 13:41:57 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-a03a900956dso446293766b.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 13:41:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1700862115; x=1701466915; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DnKDKbUOd1WxbpDbxgYGPaEFH1QtfgYmXWR7clpWkts=;
        b=hw8/Lzju34oPqCwtW9K+Ik359I2sQBTHXMjwvM1VpVG3tnmd7irO9ywXrdv/8toqDb
         auG+QAhSieej4w97kyz7RDQz3exhMSaboVWx9jTyOK9+aPNzlAqW2CfieOPUnjX6rdl2
         BCzVUvHFmVG5U21bv06mEiaK5RGr8LuV6yid8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700862115; x=1701466915;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DnKDKbUOd1WxbpDbxgYGPaEFH1QtfgYmXWR7clpWkts=;
        b=JCw0ksnHwuF9/h4oSXdODiG0pBHtJuDWQZbrViGGLAr55aUo7pL20CUvK+sFvix/lp
         B+20pOap3LItxrSth1B51/HXsww2oXYgpH1GYm5NuLhRtlfPhAh/KjF8dw0kzIny8+be
         Hs5lLhkxzUeZ8SqFGQRUZ55q7WG/7tfkKk2Ype+dgu0RoUiqs3DVSl/ACMgbvVk1UNo9
         2T8Nf8Ni9wAWnYnAKFy1PAahRBpyWFEyI9vBu3/LY9AAZv6jQfC9E/fwRf8tsNdVzEef
         DBE+MW8GRTzGoG9WOT92HrDzyz1WS/Y+PB/2BSoL6Y8wVVGOnSGuc3/5xRduAk2B01mh
         33pg==
X-Gm-Message-State: AOJu0YzP5DcQDUrDLmWml4KtGlcsNY0XCOsfn/I1ONUZdstGQUYBEhLn
        smasLCAhJjJw4BEeO7xWJ3sQ6ERQb79illfKnjAyENig
X-Google-Smtp-Source: AGHT+IEcWmm2BQHhvlGjFiIHEm7RCy60aGGmYp5IV2IyZI7FoxzW97CRiXwDXY8Uh7KNVplZiJntsw==
X-Received: by 2002:a17:906:5308:b0:a01:bd67:d2fb with SMTP id h8-20020a170906530800b00a01bd67d2fbmr6600572ejo.0.1700862115331;
        Fri, 24 Nov 2023 13:41:55 -0800 (PST)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id ks20-20020a170906f85400b009db53aa4f7bsm2544964ejb.28.2023.11.24.13.41.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Nov 2023 13:41:54 -0800 (PST)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a002562bd8bso449764266b.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 13:41:54 -0800 (PST)
X-Received: by 2002:a17:906:518c:b0:9ee:29fe:9499 with SMTP id
 y12-20020a170906518c00b009ee29fe9499mr7818143ejk.4.1700862114559; Fri, 24 Nov
 2023 13:41:54 -0800 (PST)
MIME-Version: 1.0
References: <20231124060553.GA575483@ZenIV>
In-Reply-To: <20231124060553.GA575483@ZenIV>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 24 Nov 2023 13:41:37 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgZNitYwL0kC4GWxWo9zfNXX-8Nhe=D6VtAhP9CAG_xcw@mail.gmail.com>
Message-ID: <CAHk-=wgZNitYwL0kC4GWxWo9zfNXX-8Nhe=D6VtAhP9CAG_xcw@mail.gmail.com>
Subject: Re: [PATCHES] assorted dcache stuff
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>,
        linux-kernel@vger.kernel.org
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

On Thu, 23 Nov 2023 at 22:05, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
>         Assorted dcache cleanups.

Looks obvious enough to me.

Famous last words.

                  Linus
