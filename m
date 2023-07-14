Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAD30753FC6
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 18:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235737AbjGNQWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 12:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235746AbjGNQWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 12:22:07 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C093E5C
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 09:22:06 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-98e011f45ffso260647466b.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 09:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1689351725; x=1691943725;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rFEjcMXqBZrAZsK+2fE1V7QZr5MeKAXaA74Ueb4SV2s=;
        b=a1WhRuL0BZgTm8AuZVAmExteF2/lMnb5W5IAKnI3MkLdc4lrjyuQ81GWOA7h8N0Gn7
         o2649bvARu3akwfmjcq1x9fJ48MYE5zsDYuKkzfmFf9P0kOpEIl0ZkzW7KQjPnAkqMWI
         1/3DASJ/PNY7Y7H8JK+xPLUKajNq273pit/I4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689351725; x=1691943725;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rFEjcMXqBZrAZsK+2fE1V7QZr5MeKAXaA74Ueb4SV2s=;
        b=K2eVmnBulYmn3vufGbEQqVuQXfcgIGJ1ErxBBObYJ+HOFqX9Oea+gD97xQGLt6FIFU
         2Q1jqt7K4bX7ZPy4DQs07pse38c2PgT556EXtCRxO6no8AEUze5D6qJviYxF5etxyJSS
         kTbAUiIoKE2fkSCsB1W2xonJpEiEETEYWUGCRMPyUYoFRC1kuReU/EHHQNrO/h6IsAkH
         WCtSqzw9ocw3tTo4UbxpuwEJ4KR6JMcZfV9Z4CW67DuTvQJqKvxtLRerePpkPCbDNhER
         //Ak7mMa7qR0Wf2IfDxpRT7SMKJS6Iz3ULJnUtUxMXRLkJXTnDpykOC6KLwDHs8MrZhP
         Lbxw==
X-Gm-Message-State: ABy/qLZ7aidvNEnzBBr5mLI6d/KLN1AkITYo4R88X7N+VGj442mQ5Ry8
        mL/4CgG963qGCr0QjMqmWVwk11V0G2wIKIXsM7aR7HMr
X-Google-Smtp-Source: APBJJlEET1c/H2QnX/Cf1NwJZO96bJd30+XvECQNPgQwJ0IQFdnVd9C2+yoaHDZcXMcf7y8SbeVorQ==
X-Received: by 2002:a17:906:5354:b0:988:9621:d855 with SMTP id j20-20020a170906535400b009889621d855mr4562433ejo.61.1689351724773;
        Fri, 14 Jul 2023 09:22:04 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id lc20-20020a170906dff400b00992f2befcbcsm5619058ejc.180.2023.07.14.09.22.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jul 2023 09:22:04 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-51ff0e3d8c1so2468521a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 09:22:04 -0700 (PDT)
X-Received: by 2002:aa7:d5c1:0:b0:51e:2a1b:6de with SMTP id
 d1-20020aa7d5c1000000b0051e2a1b06demr3609121eds.40.1689351724042; Fri, 14 Jul
 2023 09:22:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230714115803.111346-1-jarkko@kernel.org>
In-Reply-To: <20230714115803.111346-1-jarkko@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 14 Jul 2023 09:21:46 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj_qyDXCvjkb4GAh--OtaHQYCx8gSaX9HF-RfT=dNnvEA@mail.gmail.com>
Message-ID: <CAHk-=wj_qyDXCvjkb4GAh--OtaHQYCx8gSaX9HF-RfT=dNnvEA@mail.gmail.com>
Subject: Re: [GIT PULL] tpmdd changes for v6.5-rc2
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Fri, 14 Jul 2023 at 04:58, Jarkko Sakkinen <jarkko@kernel.org> wrote:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/jarkkojs/linux-tpmdd.git/ tpmdd-v6.5-rc2

That does not exist.

The "jarkkojs" should be just "jarkko".

This is the *same* problem that we had in May. I'll wait for you to
fix whatever completely broken flow you have, I'm not dealing with
this AGAIN.

                   Linus
