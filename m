Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CDDC776CB5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 01:20:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbjHIXUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 19:20:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbjHIXUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 19:20:03 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E2BAE5B;
        Wed,  9 Aug 2023 16:20:01 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id 46e09a7af769-6bcae8c4072so301562a34.1;
        Wed, 09 Aug 2023 16:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691623201; x=1692228001;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/lRhXpkftV5WprBOjenlPu4RlVRZWyTjLExmBLK+zSg=;
        b=mVTrbEAuawdJx3ElwaKv58oDRhAx1j/Zgd20JP5iECUNCndAK5bBHxQ/M7Gzcy/AIC
         bEp9t4cWhfYj9qPehf0Q4kbHHfAjGPzFHt24SP2Goq4jQqCresNBZV1fDQh02mzPNuRA
         Z4hYxarDm4ZraeNrXzUZK2Br9B7SDN7pA/gbIzxhfaYHrAZMawdtZNdye1UoE/MH5nG0
         tbqT4ccCdMG9Z8Fb4OTYOonV2jtfeFvYPjyboY+sdn3mdF59FuqLG0af8O/bLx2pclzt
         kEXFGSCtHQRPdvRwcCHRgjW7hm447xc99gn2drGw/Gb21XM1TWHqGjatO2T5/bmiYhSP
         5+SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691623201; x=1692228001;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/lRhXpkftV5WprBOjenlPu4RlVRZWyTjLExmBLK+zSg=;
        b=LfnqIGII479S3RRfJq5bRrjQ9BtGg46QCgjp17+xWH6HD0WvOW7/6LFjt2kMD2ew66
         BEK2NlVKqJ+3GSsQs7YUMeUwWnUzCwq3qpdQ8efjDFG6sVvPy7+I3Z8aPw82qQKtFUtc
         5gRYN6n4xfmhe5zsXmE8DZHIq2cMIE0I0lGccjPDEWYlkyuYKn6HKAL+sXsKuX9GuQwf
         JLqiehoqPdEm85qKIZnY/WE5D8O3E/z6mcXQehxUFKhjoxSnTYO3tuUslzdXPPAHwxkh
         rQ1wH3ZRWE3bi/sNWctxQCryo1O0JBaqfxM2RA07dNwlUam3cLOHUKxFrXtoZW6bzIQ6
         QiAA==
X-Gm-Message-State: AOJu0YyW5U9EmI+g+gAMUcXj2hCKtmpXimtkD+f9qIGW3M2rATGnfBPd
        KxOHhazW2UpkgMXer45IuuTPxDXfoOMCEinjAxs=
X-Google-Smtp-Source: AGHT+IFVwAsHAc1I/f4r+kqoInQuxwLB7X/eKeE4VB/eVwqAdhRIKHNUJUJZUxVvn1vl2e7UmaDNzTGKAMl7IyEv1YI=
X-Received: by 2002:a05:6358:89f:b0:134:c771:bffa with SMTP id
 m31-20020a056358089f00b00134c771bffamr651523rwj.6.1691623200560; Wed, 09 Aug
 2023 16:20:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230718054426.1048583-1-ojeda@kernel.org>
In-Reply-To: <20230718054426.1048583-1-ojeda@kernel.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 10 Aug 2023 01:19:49 +0200
Message-ID: <CANiq72k_tEaWO1MCb7mfoJPzAEFhCdSpiezvENSf0A1+mfHB8A@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: add Andreas Hindborg as Rust reviewer
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Alice Ryhl <aliceryhl@google.com>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 7:44=E2=80=AFAM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
> Andreas has been involved with the Rust for Linux project for more than
> a year now. He has been primarily working on the Rust NVMe driver [1],
> presenting it in several places (such as LPC [2][3] and Kangrejos [4]).
>
> In addition, he recently submitted the Rust null block driver [5] and
> has been reviewing patches in the mailing list for some months.
>
> Thus add him to the `RUST` entry as reviewer.
>
> Link: https://rust-for-linux.com/nvme-driver [1]
> Link: https://lpc.events/event/16/contributions/1180/attachments/1017/196=
1/deck.pdf [2]
> Link: https://www.youtube.com/watch?v=3DBwywU1MqW38 [3]
> Link: https://kangrejos.com/A%20Linux%20(PCI)%20NVMe%20Driver%20in%20Rust=
.pdf [4]
> Link: https://lore.kernel.org/rust-for-linux/20230503090708.2524310-1-nmi=
@metaspace.dk/ [5]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Applied to `rust-next` -- thanks & welcome!

Cheers,
Miguel
