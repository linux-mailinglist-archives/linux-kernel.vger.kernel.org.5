Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 737C9774448
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 20:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235516AbjHHSQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 14:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbjHHSQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 14:16:07 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43F697A0F4
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 10:22:38 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-5217ad95029so7646902a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 10:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1691515356; x=1692120156;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1ZMo3VFIBuSc8s4BkuFzX7yAflC5N6hG1s52Y/WzRwg=;
        b=UaMABPPZiHqLzouKimb/ZPmNNqDQxzFo8V8zHoKNrMOymozptRfNO6xUSW4eVIsE3j
         U7C1PkB/raIL/7qMoZUSGosxPkbWkWB3DcZPkoK7k0BLPS+8AbcKK0A/eJsVvCt8x5As
         pas1FxEpu4ejw0GRUoBAGBL8rwUiWcQnwwf0o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691515356; x=1692120156;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1ZMo3VFIBuSc8s4BkuFzX7yAflC5N6hG1s52Y/WzRwg=;
        b=F48Ww53HBbugiHzObFbxBkHBinTz633cv4R1w+jbLfBZnmkZzOi1aAgJ5H9ogdXMw8
         zYKbIsD4TWCPv/SwomeQ3tuW+TXWco9OSbWHrkKjS7Ex8UIVPj+cClbUB5AJmDa3xaEB
         gX5g1tUU+1qfuV5dynpPHRYqfV7azczF+Z+T7fsbk8k2WW0Ai6U+ixWHY+lmD/gzjUdN
         AF9bxJkcQMpcTccIObh6JBQPA/x+Z8of9QE4iGHTIMhWbKVC8vCNpsH+i8Xa3xhrw81N
         WBogAnCiKwqjUIFfJtn1GLh0WJ3D8t/b6DpqIK5Uq4UAs44lHE5lK6bkbV1WZqBuyzJT
         bOng==
X-Gm-Message-State: AOJu0YxQJIUmurdbCIA3dM+aZMFYaMCLImYnhEsEJ2Blc6Zq/EG96wLe
        iLZyEnwAXzxvcaZ3dmh1WyS7wkNfhfRFVL2sGApCZzbp
X-Google-Smtp-Source: AGHT+IG9UePGtljnaG5GeT8vYISkuFCBhZNcKTiuehnAhRx0I8ZLSvqqFTDplokqMLLV/md0wskYFA==
X-Received: by 2002:a17:906:11a:b0:988:8be0:3077 with SMTP id 26-20020a170906011a00b009888be03077mr205328eje.31.1691515356748;
        Tue, 08 Aug 2023 10:22:36 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id t6-20020a1709060c4600b0099bcb44493fsm7038554ejf.147.2023.08.08.10.22.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Aug 2023 10:22:35 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5230f8da574so3417986a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 10:22:35 -0700 (PDT)
X-Received: by 2002:a05:6402:1219:b0:523:17ad:c7d4 with SMTP id
 c25-20020a056402121900b0052317adc7d4mr368834edw.39.1691515354968; Tue, 08 Aug
 2023 10:22:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230806230627.1394689-1-mjguzik@gmail.com> <87o7jidqlg.fsf@email.froward.int.ebiederm.org>
 <CAHk-=whk-8Pv5YXH4jNfyAf2xiQCGCUVyBWw71qJEafn4mT6vw@mail.gmail.com> <20230808-jacken-feigen-46727b8d37ad@brauner>
In-Reply-To: <20230808-jacken-feigen-46727b8d37ad@brauner>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 8 Aug 2023 10:22:18 -0700
X-Gmail-Original-Message-ID: <CAHk-=whiKJGTF2_oKOKMi9FzWSzcBkL_hYxOuvG-=Gc_C1JfFg@mail.gmail.com>
Message-ID: <CAHk-=whiKJGTF2_oKOKMi9FzWSzcBkL_hYxOuvG-=Gc_C1JfFg@mail.gmail.com>
Subject: Re: [PATCH] fs: use __fput_sync in close(2)
To:     Christian Brauner <brauner@kernel.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Mateusz Guzik <mjguzik@gmail.com>, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        oleg@redhat.com, Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Aug 2023 at 10:15, Christian Brauner <brauner@kernel.org> wrote:
>
> I think you're at least missing the removal of the PF_KTHREAD check

Yup.

>                 It'd be neat to leave that in so
> __fput_sync() doesn't get proliferated to non PF_KTHREAD without us
> noticing. So maybe we just need a tiny primitive.

Considering that over the decade we've had this, we've only grown two
cases of actually using it, I think we're fine.

Also, the name makes it fairly explicit what it's all about, so I
wouldn't worry.

              Linus
