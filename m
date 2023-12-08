Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99354809D65
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 08:43:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573313AbjLHHnl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 02:43:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573335AbjLHHnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 02:43:37 -0500
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B39211734
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 23:43:37 -0800 (PST)
Received: by mail-ua1-x929.google.com with SMTP id a1e0cc1a2514c-7c45280b1a9so427927241.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 23:43:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702021416; x=1702626216; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+4q2vuoSSJgvH7vZRaxIDen/jyKU6XB1LXeL+/4gRcM=;
        b=rIrWSWa6FMeZTRA6fOsq7PUz5nO/S7mlA2+xHwzMbfB2voaQlNJrCeXFB0LFJLHnwW
         lcgHihAnps8KkMjw0WtR8PrJrujwWJStNJyWMLVwE1TF3NnLDTEzx/0d3KI2vB9RpKTP
         /ZQz9Yp627xKNzP365RyfKbmo+H7Sccqxwp5MZ4SCW2RV8UTFqnQW4pkiKsRa2adIK8k
         1iYz5a3AmrGvIDcJXgdRYBCpj2el7zudWoQdyvjdk+DItHaCSDB+RNo/NyFxDUxImE/A
         jI5kkZhkRSqrEDkRF8g1VRuWv86sgrA0+eEcuQAUGyiqDibJShj6Ram4BWguRtBLrcmx
         /rRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702021416; x=1702626216;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+4q2vuoSSJgvH7vZRaxIDen/jyKU6XB1LXeL+/4gRcM=;
        b=aYWtk3l5hv+0bSiFMfhADivW7Se0nQdA3sS8A9N5PXYNnMQ8HvMrhxzLB3Uqzb62GG
         Njk0T8x2fNhdVGrtvVbdfnTYrEBrCnpsNwryeNxUKzaEqv+xnbrhxlRbiesuDkjnXlt0
         2msYjw3/sb6Xu82KPftze4ul4RoEnaUORFh1UamlPyQOrzVdvcTRwR4ehhrEIbGVp7Zr
         2dXaasxnnRRD9l3Pj2qMmEwKL+M3YvSH1mgRrrLcmMwH586Zxv3ZlaorcSxDGC90LNIC
         CTNOsBY4tyaUJn8bTGV1+QQR4yWqW+itZsJU2JV2bdkAanjShSmd6wX4waY/vOZAMiqC
         wGrA==
X-Gm-Message-State: AOJu0YzcmKew/OrJQgYsRh1aE4M8wRFW5lTEF/ObxtvhUxdcdrpDlOvD
        G+rVfjZ5DlNcaJ5ecYRb2WDxjOxSVmyxwadQ+8WYaQ==
X-Google-Smtp-Source: AGHT+IH3GFhE6C5y58gfbtDBuMvPVznxpofnP+2ZfxvpHEccq0MFGv9X86KkaH/iD1Z/02axDn1F0RFCnYFzPu5sjwQ=
X-Received: by 2002:a05:6102:548d:b0:464:8660:18b2 with SMTP id
 bk13-20020a056102548d00b00464866018b2mr4377343vsb.22.1702021416509; Thu, 07
 Dec 2023 23:43:36 -0800 (PST)
MIME-Version: 1.0
References: <20231206-alice-file-v2-0-af617c0d9d94@google.com>
 <20231206-alice-file-v2-4-af617c0d9d94@google.com> <ooDN7KSgDTAyd45wWcPa1VLmvo-fiqwDmffX1Yl8uiesYUcgnCZq5dcd6fGw5sVYMusZGpEI4L5avLCqNXXM7opR627oUp1NB-TIHOwJufg=@proton.me>
In-Reply-To: <ooDN7KSgDTAyd45wWcPa1VLmvo-fiqwDmffX1Yl8uiesYUcgnCZq5dcd6fGw5sVYMusZGpEI4L5avLCqNXXM7opR627oUp1NB-TIHOwJufg=@proton.me>
From:   Alice Ryhl <aliceryhl@google.com>
Date:   Fri, 8 Dec 2023 08:43:25 +0100
Message-ID: <CAH5fLghg7=eF38fNeUTEFe9zH95H-Que_911kJ+g_rsNrODHsw@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] rust: file: add `FileDescriptorReservation`
To:     Benno Lossin <benno.lossin@proton.me>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Carlos Llamas <cmllamas@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 8, 2023 at 8:37=E2=80=AFAM Benno Lossin <benno.lossin@proton.me=
> wrote:
> > +/// Zero-sized type to mark types not [`Send`].
> > +///
> > +/// Add this type as a field to your struct if your type should not be=
 sent to a different task.
> > +/// Since [`Send`] is an auto trait, adding a single field that is `!S=
end` will ensure that the
> > +/// whole type is `!Send`.
> > +///
> > +/// If a type is `!Send` it is impossible to give control over an inst=
ance of the type to another
> > +/// task. This is useful when a type stores task-local information for=
 example file descriptors.
> > +pub type NotThreadSafe =3D PhantomData<*mut ()>;
>
> This should be in its own commit.

Will do.

> Then you can also change the usages of `PhantomData<*mut ()>` in
> `Guard` and `TaskRef`.

Will do.

> It would be nice to use `NotThreadSafe` as the value instead of
> `PhantomData`, since it is a bit confusing...

That doesn't compile, unfortunately.

> I think we might be able to also have a constant with the same name
> that is just `pub const NotThreadSafe: NotThreadSafe =3D PhantomData;`.

I can try to get this to work, but I worry that they will shadow each other=
.

Alice
