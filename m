Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB7D67CEB85
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 00:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbjJRW57 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 18:57:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjJRW56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 18:57:58 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 268CD114;
        Wed, 18 Oct 2023 15:57:56 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-5a7c7262d5eso92835127b3.1;
        Wed, 18 Oct 2023 15:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697669875; x=1698274675; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RKkVdOuDWF4XkQSOFeT9iebziRU+xr3n1OlUXKxR8yQ=;
        b=R6r+wNWSKY5hLGqvhwjeDmZx5hf1bPcHlIyYl++wTJk4JNDZcJtXqubEIux9UflePn
         GSXXj2zMFm1ZEf+9HVSQ4SM8iAQq55G/UNJJCaKJiq6GNEaZutRKkxPR+oLB/E4LLdn8
         ncF3bas1v6Cs2oGUqzrYNHZ/3uFzlpJOH2C0B2+2nbLZfj7Gvff1oJQkZx2xsdxUaAf/
         AHNmaF/05XGcMwwoNmviWg5x9SOo61P/Vnr5fxjuYFjeF2TSPYrLRdIObBGv8q1xBgzh
         EgJWAKyyXA89pcV7GXIYNHukaxfmAQssGXEsq6UCpwObYRWMtdJuj2Uqz6WUaY4W0DC2
         hy4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697669875; x=1698274675;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RKkVdOuDWF4XkQSOFeT9iebziRU+xr3n1OlUXKxR8yQ=;
        b=DPrPOBJXTXAOW5YDDeul+mEd0qdessv/6OPDBHx+hq70ZQ4pQe3ixGaLNDofGeDWIG
         Gw+rMpughq2mHpWgdVTT0QCFWq+yc0/JIyN+6ecWlbhE9mfoAtACNj0V2wtX4jh67vQ1
         h3DeVfyNGkED9XJ+thX+sQHNnXwzxYmyZzCjdg7A94dwfL+QyMz0L6GhQTn1jY/8ObKJ
         6vLmlaNtOMxO0eCybHBx9leI6xxm0fNkNBqNHvc9U4XIz6r7rYmBl1KuYKiKANCrVNYp
         6B66GvTOQTREqmMke/cCzrFRkpzDVs6tsJGSkYapzpEo5DeiCvqrxk9EZ2RBaJMfvVi8
         IB+A==
X-Gm-Message-State: AOJu0YwJk6W9c+0MRqYtpxQvGda3iXrUSE0o6NdPnMlNUy+fdd5qpDe+
        ZV0ztWlxIDhpnGGZJSApdDRF8B6hnnsSBt+P+i0=
X-Google-Smtp-Source: AGHT+IFrRe19551V3133QusmY93KFsTv/XMURZAAbpLgmpHhSRq0ztkPRgjFSMeQaWFwYIX6VJzYxBi/XO3cFeKFXQ4=
X-Received: by 2002:a05:690c:dd1:b0:5a7:dbf4:6a1a with SMTP id
 db17-20020a05690c0dd100b005a7dbf46a1amr792663ywb.7.1697669875320; Wed, 18 Oct
 2023 15:57:55 -0700 (PDT)
MIME-Version: 1.0
References: <20231018155527.1015059-1-ojeda@kernel.org>
In-Reply-To: <20231018155527.1015059-1-ojeda@kernel.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 19 Oct 2023 00:57:44 +0200
Message-ID: <CANiq72mx+gHfP+PE1fuHcO8zhv038qXJ9Zz+rKgRN5tt7eokvw@mail.gmail.com>
Subject: Re: [PATCH] rust: docs: fix logo replacement
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, stable@vger.kernel.org
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

On Wed, Oct 18, 2023 at 5:55=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
> The static files placement by `rustdoc` changed in Rust 1.67.0 [1],
> but the custom code we have to replace the logo in the generated
> HTML files did not get updated.
>
> Thus update it to have the Linux logo again in the output.
>
> Hopefully `rustdoc` will eventually support a custom logo from
> a local file [2], so that we do not need to maintain this hack
> on our side.
>
> Link: https://github.com/rust-lang/rust/pull/101702 [1]
> Link: https://github.com/rust-lang/rfcs/pull/3226 [2]
> Fixes: 3ed03f4da06e ("rust: upgrade to Rust 1.68.2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Applied to `rust-fixes` early to start getting some time in
`linux-next` -- please feel free to send more reviews, thanks!

Cheers,
Miguel
