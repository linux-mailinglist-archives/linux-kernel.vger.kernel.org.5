Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFAF97D953C
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 12:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235074AbjJ0K0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 06:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231499AbjJ0K0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 06:26:46 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0033610E;
        Fri, 27 Oct 2023 03:26:43 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id 006d021491bc7-581b6b93bd1so1060897eaf.1;
        Fri, 27 Oct 2023 03:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698402392; x=1699007192; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FnEhhHWnozzJIP32+eWhnM429iVdFM4b7RUlsQz6pj4=;
        b=Aimp6tc5xvKDBimfMFOwrfoHTJEhzbQfHYWsLHXGAIwnl815r6S1K89raM3fPdc/aF
         EuEEgAfirR1zNQ8mM9O9NWY8+DxuE+9KM/kmjsy8dVMi5kGetW5N9Q+wjLcD1sZOFbv6
         /J1vS4no4MlFt8+cQEM0mimun5UfYqABusPNJp4dNoxeueRZIoqlbcAnMjNgHPKWuIUb
         gsa/3y4MMc9m3ZwZLsVqcGwB+YSyUaSqaawgJUJYpXhvxdAKwRbt4rtCb/cSXeHIyVul
         QVSS5etrPivHT01IZnreuCgk7boN3C4JLcjSxSgAe349+UybEhLtKj9iOomTls8Yj9gs
         X8fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698402392; x=1699007192;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FnEhhHWnozzJIP32+eWhnM429iVdFM4b7RUlsQz6pj4=;
        b=p+kwqghVabFr788RCYn2pn0q1GSh+ULUVTGh/j+reddpZoXykcK0DGEki5NkhyIR32
         lj8VBtJodd0NcDJbidHh59dhJg2bnWR/J2Bb/dkIjrV5Qrztn90Ca6N7E+jszAjge9CC
         Qzui1OuTqWS5BbFXq8KV/vH7Frj6GuQzWQ/d71P8loiqhb7QzuU2PtN9spaZ93rulKrn
         0b7Cwtxk0nNn34ml32kbP0BwYBEcbyZB/g/DQ4q32heWCo84fA+v1xuXt08VLBf/+m9U
         UIUzmbPfomUi5bjTA5Evl08uH3du/c8G7iN04kzzamMM9+URXlLzExCR7y4LGObeyX33
         AOHg==
X-Gm-Message-State: AOJu0Yzf/hhh3KgWToD4Z6IP74uBbL8GH0Vglac5P4Ev4uE92vn6sd2+
        c4Nmm9Tog301gqNPHrYoIpZ1d7XBFZA/PsmXfRo=
X-Google-Smtp-Source: AGHT+IE3vAuxVtHflrtayMtQWS1SsLfDsADkWuOSZA+RD7OcrVdj1WACBpf/AIdQ+wZvdv9F+KIBy5w2rNeTbPAQaEo=
X-Received: by 2002:a05:6808:10d6:b0:3a9:c25d:176a with SMTP id
 s22-20020a05680810d600b003a9c25d176amr2728090ois.36.1698402392062; Fri, 27
 Oct 2023 03:26:32 -0700 (PDT)
MIME-Version: 1.0
References: <20231026201855.1497680-1-benno.lossin@proton.me>
 <au3adook2dsnveqlz3i7inmbzx7b5sel7qg2cn7efcacicthiy@fm5io4kam3s2> <f5526059-66b1-4e28-aae2-b1cc1532ade0@proton.me>
In-Reply-To: <f5526059-66b1-4e28-aae2-b1cc1532ade0@proton.me>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 27 Oct 2023 12:26:20 +0200
Message-ID: <CANiq72nQnPZttFp34Ngz1nfQRT9F+z3CFGmbCNj0E=RJb7AzHA@mail.gmail.com>
Subject: Re: [PATCH v3] rust: macros: improve `#[vtable]` documentation
To:     Benno Lossin <benno.lossin@proton.me>
Cc:     "Ariel Miculas (amiculas)" <amiculas@cisco.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        Asahi Lina <lina@asahilina.net>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Viktor Garske <viktor@v-gar.de>, Finn Behrens <me@kloenk.dev>,
        "rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

On Fri, Oct 27, 2023 at 11:32=E2=80=AFAM Benno Lossin <benno.lossin@proton.=
me> wrote:
>
> Oh I forgot about that. Miguel, would it be reasonable for you to fix
> this when picking the patch?

Yeah, no worries.

Thanks!

Cheers,
Miguel
