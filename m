Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E6587BD7DC
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 12:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345860AbjJIKCm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 06:02:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345964AbjJIKCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 06:02:40 -0400
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C45A99
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 03:02:38 -0700 (PDT)
Received: by mail-ua1-x92e.google.com with SMTP id a1e0cc1a2514c-7b07c3eaf9bso1322814241.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 03:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696845757; x=1697450557; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TeHC4fUNzptIsm702Gc729/mLFYjfVybbm1yE9/t+ZU=;
        b=MrV3m5se8NFOytbLB9GHYXxM2dcxfeOftqIP63agQ/mHJuDCvtKYkiI1jmGNNBz4AW
         ageS6fInH34dctCeSNHRStHAY+aGDcFq2hfzuz3Jwm4Eq8ln7n5Up1ICOV5lSzajV+7z
         ztMo+O7eJR5B/6WbabN0F9/SUcb1v1NlrGx8Je9/pwe9edeOMeBKCa0VVvdRNLDkRpi7
         i7L1X74yJfEAwNFRfmmDiXt8Aex3zm3tGKagodo/X4mgaSrDf+MGY97TIMjpKwi151DK
         pWnIEbO9a/KBE3uEr81uY/SonyTZH85HsPqi5ibIs5qpSMBcPvsmeWyvQtF0XBWVU/ec
         K3Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696845757; x=1697450557;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TeHC4fUNzptIsm702Gc729/mLFYjfVybbm1yE9/t+ZU=;
        b=L0Ar20HVQ02cNQRxiL/PW5btOo/2VEPo8z+Ucip8njHEb9sqgDmagCVMsnsuMoJd0u
         4J/5LM8f/Y3gZ4Z69WSrAj6wInTSUFDHmAmUYAzY3yl3xGjxHundNsLsQu3F52yQucCN
         bXM2QYyc2iV1vEdUUADvirGGKrM9c77z3jyKEDn1o7WgGItzpO2ZUFGF6vzwQ32jklSC
         +3P1TimqY9bnZimA5DVezzzhNClsQApXXIqrvefBVwFe5Hs+kvG9DA74tmYW4kXLLIkZ
         aOlto6OU3rP5K0urBxZiumHA90wKyHYAv7tF5PDji+2vlzAKz1sA4s3tytTWAqbX9S8g
         3sTA==
X-Gm-Message-State: AOJu0YyfvTzFjsXOYIX2jzY6nvgGjxOUZ+MvjSGGwl1bplhtphtYaVRw
        5UxTJWUcpljkgl0WfCq3Sj6oGvvMrVNpRmDfF7eLvA==
X-Google-Smtp-Source: AGHT+IFb9TiFL2rRm2CJq/eWV+YaqZXixEAA+lusEldkhIm4jX1txiBO381BakZx7EsO6YdAN9AdFYadt8kGouypPZ0=
X-Received: by 2002:a05:6102:3558:b0:454:6891:a53b with SMTP id
 e24-20020a056102355800b004546891a53bmr13033111vss.13.1696845757062; Mon, 09
 Oct 2023 03:02:37 -0700 (PDT)
MIME-Version: 1.0
References: <20231008094816.320424-1-tmgross@umich.edu>
In-Reply-To: <20231008094816.320424-1-tmgross@umich.edu>
From:   Alice Ryhl <aliceryhl@google.com>
Date:   Mon, 9 Oct 2023 12:02:26 +0200
Message-ID: <CAH5fLgg+3B5SCFwxLz_YJT1hqU+Ev+XvLT+hA4OLpBk7Oi6Xrw@mail.gmail.com>
Subject: Re: [PATCH] rust: macros: update 'paste!' macro to accept string literals
To:     Trevor Gross <tmgross@umich.edu>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        FUJITA Tomonori <fujita.tomonori@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 8, 2023 at 11:51=E2=80=AFAM Trevor Gross <tmgross@umich.edu> wr=
ote:
> Enable combining identifiers with string literals in the 'paste!' macro.
> This allows combining user-specified strings with affixes to create
> namespaced identifiers.
>
> This sample code:
>
>     macro_rules! m {
>         ($name:lit) =3D> {
>             paste!(struct [<_some_ $name _struct_>];)
>         }
>     }
>
>     m!("foo_bar");
>
> Would previously cause a compilation error. It will now generate:
>
>     struct _some_foo_bar_struct_;
>
> Reported-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> Signed-off-by: Trevor Gross <tmgross@umich.edu>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
