Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57A9A7C7848
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 23:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442842AbjJLVAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 17:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442277AbjJLVAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 17:00:23 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BACB99D;
        Thu, 12 Oct 2023 14:00:21 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-5a7c95b8d14so18441317b3.3;
        Thu, 12 Oct 2023 14:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697144421; x=1697749221; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VS3Vk1hGFBjeGc8z4uoPu31TJIYHPUua8IaOwdxDOM8=;
        b=NzuDUfFajTJq/BVkf9YErjLcZMAyBZ++IDdjQc5tGD3SRXvasbpYHoYcKFigJnoxx2
         8W49eR+4c3peDRIllXbkXldgt+zSi4ufhfVIiY3ID9ZbEkFpFdfprv9lNnc96fvX0S5L
         VBwLfPG2L5w/qhTPG13OpRkLj0ESZgAqx2dVggAfFRmuMIB7k+Zq37mixbljc9jS1DUe
         NyWlo3xyqGeF+pCV56RRUVcK4eOYKnrKnrCDFyVYrPecTFeHvE/21HJZ+v+7G+1PYAgE
         BH0W6F7+E67G9XjsH/lAeXb5HcUCrkPjqSFxbgqDiQfyB9nbWM5eKvBdkCJ6XLaCWOEW
         OSRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697144421; x=1697749221;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VS3Vk1hGFBjeGc8z4uoPu31TJIYHPUua8IaOwdxDOM8=;
        b=sr8Dj1vaxBHA9noLMmF3KjU4bmP/A1N2gJoaEhzVqqSnGacyczn/Vxom+qcLL7UGGT
         q9tWOUcfe3tCA/+p9DWhkWN7Nw6//zfFjOfo9stLTfXIRQTeel0y+YIu2rt2T2PeIERf
         zc6NhqZoCdhT5yLtKN8NdYcESoYxyRrNfGbWv5kLZbNOgs5bvLO/1ifP+vVvM2cdmAfN
         zft8a+77Kz7qJHgeKpAaJXOxDdbLhsuRs+QrIG31Dpya1CPTylax1jAbQC9F55EoRc7/
         bLxcuH9jiG6gysOFqUz9J7qT8uhydbQjS4plxI668Av683Cavui1kkEUV48ng8KOoQYg
         2PYA==
X-Gm-Message-State: AOJu0YxEuEZdlbW8Q4yiCgYa8uK18oqymCaUS50syCYq7lkmPn/06jg+
        MJyIYeOHdAwelzZTjd/nH4QZKbvJBAMmq3H7g7E=
X-Google-Smtp-Source: AGHT+IHh8ujhu/UcLg8ViA9S7kui2bh28bpPnv7cNtkKSY5vYwn2QFDh8uegWuQ0WgvBvVJ6lgIuiz5oASaGMuY5Z74=
X-Received: by 2002:a81:a247:0:b0:599:b570:2db7 with SMTP id
 z7-20020a81a247000000b00599b5702db7mr24945063ywg.30.1697144420801; Thu, 12
 Oct 2023 14:00:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230930144958.46051-1-wedsonaf@gmail.com> <5122b6b6-12d5-0337-0c04-3e30da1f3898@proton.me>
In-Reply-To: <5122b6b6-12d5-0337-0c04-3e30da1f3898@proton.me>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 12 Oct 2023 23:00:09 +0200
Message-ID: <CANiq72n=y7GtYEEF3042-JLhcpLMAk2ammh2DGkO+1ELXBc=NA@mail.gmail.com>
Subject: Re: [PATCH] rust: error: fix the description for `ECHILD`
To:     Benno Lossin <benno.lossin@proton.me>
Cc:     Wedson Almeida Filho <wedsonaf@gmail.com>,
        rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>,
        linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 9, 2023 at 4:54=E2=80=AFPM Benno Lossin <benno.lossin@proton.me=
> wrote:
>
> Strictly speaking, `errno-base.h` documents this as "No child
> processes" (note the plural), but I am fine with taking it as-is.

Good catch.

POSIX seems to use both (General Information vs. `<errno.h>`), so
perhaps that is where Wedson picked it from.

Given the kernel uses the plural, and that the commit message says it
mimics `errno-base.h`, I have amended it.

Cheers,
Miguel

1:  77983c791960 ! 1:  17bfcd6a8153 rust: error: fix the description
for `ECHILD`
    @@ Commit message
         Fixes: 266def2a0f5b ("rust: error: add codes from `errno-base.h`")
         Cc: stable@vger.kernel.org
         Link: https://lore.kernel.org/r/20230930144958.46051-1-wedsonaf@gm=
ail.com
    +    [ Use the plural, as noticed by Benno. ]
         Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

      ## rust/kernel/error.rs ##
    @@ rust/kernel/error.rs: macro_rules! declare_err {
          declare_err!(ENOEXEC, "Exec format error.");
          declare_err!(EBADF, "Bad file number.");
     -    declare_err!(ECHILD, "Exec format error.");
    -+    declare_err!(ECHILD, "No child process.");
    ++    declare_err!(ECHILD, "No child processes.");
          declare_err!(EAGAIN, "Try again.");
          declare_err!(ENOMEM, "Out of memory.");
          declare_err!(EACCES, "Permission denied.");
