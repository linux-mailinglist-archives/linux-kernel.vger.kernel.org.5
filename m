Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28CB97DC342
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 00:42:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbjJ3Xmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 19:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjJ3Xmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 19:42:52 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D70EDB
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 16:42:50 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9c3aec5f326so1285278266b.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 16:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1698709368; x=1699314168; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=e5N724rwDHXZ7JYVD8hn/Em5XUesdSK4Pl1fcV5KWlA=;
        b=LdNZRe9kaCiZwpUBKZ/zv3T9Lxjoif6Rq6L4NTspFfhQ9wvWZswkWmXoAqwhQbMoZq
         wMjhwW7yUNuC0caCT2QKeVpWym963DJNsNzPoZLRn6Z9suonoV5Glr1YoH2Z3nPm28yH
         x9tbzNxZcjfpCzTV8AE/Vh8k0yBabXwPhCHdc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698709368; x=1699314168;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e5N724rwDHXZ7JYVD8hn/Em5XUesdSK4Pl1fcV5KWlA=;
        b=cCwF6MSwD7CcARWr2nRxHqCbz4wtufg0cx4oEteZYXoybZUKIzXE6FHYTaQBY8WDzw
         bYWDKYaEu2j5YzI6xw23kvywvFo5h4UJy6FNv51FCkzoIxi4AT2rA9pv2oVcBT0GJsPZ
         TmfAzEXC4jv9jV9x9FsEOzLOmon+K87uCUXjLqvPaVkOq2/4GKkdpIFtGgzJpesnB1Se
         0Ko2jGLtzhhdLcsvuNiKOAzAH3J1YynJW4OeW5Qd7n1zLmE258sTS4kGzOUfZONVXUL4
         ApIPR1N0mWx/zsQiapseNmb322SqdLZtOH+15e9NmMxvHxluzj+JOpFGWPsOe1kymlFD
         1Tbw==
X-Gm-Message-State: AOJu0YztFJNBeneGdbFAYTz3LW05Cv81pRH1Jy1vyQ4PZnG58b6huDfr
        5G8plNlikgFEe6lV3uhEz0KOuVWq9VmzaGsUbjw5tA==
X-Google-Smtp-Source: AGHT+IHYCzKH8q9uFigwvDW5KY2tk82Z2s1MZrXde8UZkqsj/Q8yIZ/DdoACPV09eta4kzcefCDtaA==
X-Received: by 2002:a17:906:24da:b0:9c5:7f5d:42dc with SMTP id f26-20020a17090624da00b009c57f5d42dcmr974834ejb.33.1698709368385;
        Mon, 30 Oct 2023 16:42:48 -0700 (PDT)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id m10-20020a17090607ca00b009875a6d28b0sm47371ejc.51.2023.10.30.16.42.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Oct 2023 16:42:47 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-9c603e2354fso1036076166b.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 16:42:47 -0700 (PDT)
X-Received: by 2002:a17:906:ef02:b0:9be:85c9:43f1 with SMTP id
 f2-20020a170906ef0200b009be85c943f1mr839873ejs.7.1698709367234; Mon, 30 Oct
 2023 16:42:47 -0700 (PDT)
MIME-Version: 1.0
References: <34E014FF-351E-4977-B694-060A5DADD35A@oracle.com>
 <CAHk-=wifhiJ-QbcwrH0RzPaKeZv93GKDQuBUth18ay=sLu5CVA@mail.gmail.com> <96800661-0F30-4F9E-89E4-C0B032EFDEB9@oracle.com>
In-Reply-To: <96800661-0F30-4F9E-89E4-C0B032EFDEB9@oracle.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 30 Oct 2023 13:42:30 -1000
X-Gmail-Original-Message-ID: <CAHk-=wgyD3=63P=xewgmzSxcMmfj9LPakdVBDWnzR1EwUUOctQ@mail.gmail.com>
Message-ID: <CAHk-=wgyD3=63P=xewgmzSxcMmfj9LPakdVBDWnzR1EwUUOctQ@mail.gmail.com>
Subject: Re: [GIT PULL] nfsd changes for v6.7 (early)
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Neil Brown <neilb@suse.de>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jeff Layton <jlayton@kernel.org>
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

On Mon, 30 Oct 2023 at 13:21, Chuck Lever III <chuck.lever@oracle.com> wrote:
>
> Do you need a refreshed PR with the testing bit removed,
> or can you live with Neil or me sending a subsequent
> fix-up later in the merge window?

Oh, I've pulled it, I just haven't pushed out my recent merges yet.

I realize that my complaints are nit-picky and they don't hold up pull
requests. It's just that bad Kconfig questions are a pet peeve of
mine.

But being a pet peeve doesn't make it a showstopper..

          Linus
