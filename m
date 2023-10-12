Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B91627C77E8
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 22:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442679AbjJLUca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 16:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344046AbjJLUc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 16:32:28 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 936E9BE;
        Thu, 12 Oct 2023 13:32:26 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-5a7c08b7744so17121707b3.3;
        Thu, 12 Oct 2023 13:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697142746; x=1697747546; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cm/AgXb2pZX2bhYC2JHhdS0bLLkwtZFpfedsIjsGaxo=;
        b=cL9/sn0t9eOihbG1agUbr/zv1Zjp6ue4q77quXg/X2JJpSwfsrqtm39fA7wIvW6L1V
         9PBBpBfqcWKR0A92t9ssREy7SsHejx9rKnszq7F5T1uveKi0QIkbrW9/0pJbzgwJlkf9
         X7qyh2z1UibiESsIu7MXru5bqN/SrG26vnEd44994PeZyH0pBQLUpq7oeynf6pr+/Iob
         3FhbWeVO2ICcY1y5UdeFXHTa2Vk81zyb31lyZXBQctZRqj5cNlv0l9xa2BKzADGq5fX2
         2LfZUWiX47SMswiGyAlP2y9RJnCmiB8izYbPRNL+s7cxBOe2ynkl/4AOIqL3DVSRJAEq
         vkXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697142746; x=1697747546;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cm/AgXb2pZX2bhYC2JHhdS0bLLkwtZFpfedsIjsGaxo=;
        b=j41ughAjc2VwPAqfUzxQTaXjiIgU5baVChN9GUH756aPnqFiK/kIlqfh4/paQYVC1A
         cq7nWLkdNW1ljOOG38+uM6ybi66inu0lwai74AZWW2ZtfxMWcXxNCQyYDDe+E0w15hL2
         jIaUaAeORJYsVLl6S9opaFm8EcQ1YTI9IEsfTuR8FsK17S4FNZHt2kYG9UjXWczs2TQ1
         0egkdAk0OCuojrOgGxJA2H1JlWX8aU5I2crouxY58mB9pv9M1tgyqYwmtdxoTZdXOBqy
         WRlISBghXAHkt6vIX02ZIMZhbi/OvrlamalMcE9PfBC4t5eXwNonavzDCe0ywO0b2bVg
         HpZg==
X-Gm-Message-State: AOJu0YyvKbkCHlVyEXf9iLKmlDTMFMYzntmbwMk3cQIRdqjzznfOS6wo
        TIbkCoabtZncH9qYTQCOrOsn/VZuOLzOjt92vTE=
X-Google-Smtp-Source: AGHT+IHD0CrLdMGFNY3S67LMzgZgXb1f19I7/6TOigdCU28sHoSDLNP7bYc/AFFnRT0U0CZM/hzViQ0xuFqvTOJrbnk=
X-Received: by 2002:a0d:e284:0:b0:5a7:baae:329f with SMTP id
 l126-20020a0de284000000b005a7baae329fmr10012845ywe.15.1697142745697; Thu, 12
 Oct 2023 13:32:25 -0700 (PDT)
MIME-Version: 1.0
References: <20231009224347.2076221-1-mmaurer@google.com> <CALNs47vtnOfUarrH8qiJAZpp6bs1jjcsMyb3-A2Gy9YiaDFVEw@mail.gmail.com>
In-Reply-To: <CALNs47vtnOfUarrH8qiJAZpp6bs1jjcsMyb3-A2Gy9YiaDFVEw@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 12 Oct 2023 22:32:14 +0200
Message-ID: <CANiq72n4bwMn6HCNGm4iNPSsV4W83fh7yH+bKv+a9GKPBWuSsA@mail.gmail.com>
Subject: Re: [PATCH] x86: Enable IBT in Rust if enabled in C
To:     Trevor Gross <tmgross@umich.edu>
Cc:     Matthew Maurer <mmaurer@google.com>, peterz@infradead.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>,
        linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
        Antoni Boucher <bouanto@zoho.com>
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

On Thu, Oct 12, 2023 at 10:13=E2=80=AFPM Trevor Gross <tmgross@umich.edu> w=
rote:
>
> I have not tested this, but is it possible to enable these options via
> `-Cllvm-args=3D...` instead of using the unstable flags?

We probably want to use the "real" flag eventually instead of
`-Cllvm-args`, right? So we would need to change it anyhow. And using
the `-Z` one means we test the "real" flag already.

Well, unless `-Cllvm-args` becomes the "official" way to enable this,
like you suggest in the Zulip, but should that really happen? e.g.
should not there be a generic flag for all backends for things like
these?

> If so, I think this would be preferred in case the exact flags change
> before they become stable. It sounds like they are likely to change,
> see [1].

That is fine, they will change anyway from `-Z` to `-C`, so having to
update those is expected.

> If not, no big deal since it would just need an update at a rust version =
bump.

Yeah, I don't think it is a big deal, and the version bump looks like
the best commit to put the change, in fact.

It is true, though, that these ones in particular are conditionally
enabled, so there is a slightly higher risk of forgetting about them.
But that is why we should get more `Tested-by`s! :)

Cheers,
Miguel
