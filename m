Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FABA7820B1
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 01:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232106AbjHTXIP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 19:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231931AbjHTXIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 19:08:13 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50CC5A3;
        Sun, 20 Aug 2023 16:08:12 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-cfcebc33d04so2708104276.2;
        Sun, 20 Aug 2023 16:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692572891; x=1693177691;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0wFw0h6J88toaQr7oL9THwrzdDbquNtH0tOmWMgSocU=;
        b=pRgCXmNPYlnnFjrw8jfI/bFFD7GvO8EvyPf6w9ZA4Mgu/5VdTZebF0xG3DG6L3VMAY
         GGIIVSyiUmexKplTkeFEOGGq6DOjPSuKBKP57f/adz0CiVMULc+mbJ9/tkXzryqoD392
         D+u1MXMkSMpWa3/NQzkUaBfpKSITYtZJKXKOrofj63hIIQKopwElEIYDc14vGU6own6N
         qtOE9j8KPA6hZ2TabkoiRtCghQCSUToDM2F1XmiQyiGSvNvj1hoiLWdN55a+86iSWuWZ
         TjS/mGax9joocUbI9LqxZp1u7gsg7oArwaybtr0hac57WFUOSLOaJJ4B4OTkYKLncgHi
         msYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692572891; x=1693177691;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0wFw0h6J88toaQr7oL9THwrzdDbquNtH0tOmWMgSocU=;
        b=gVHLwTnXoKciDTrLEUipiA6zZOaAeP+nC1anXGfyuNLc5Y1cYoXoQ8JPwxALFWLM0X
         +nrU/H/YuMmOchHBcy4vZ7S5mNS7O9wyqPd66SCeuzCzNoOi8Jp/u+Mo+dYNMaiaUbYB
         bzj/NSqOxrHU7wCdxVWip+Tjg6yqW5dWajyepEH0NKjEBaAwxtqxzNGmLLjaHXjqEM3Z
         AYPE/ODuIHQkALauRd9PhMrqytkW/JIXuaTyLSgq/JBXmxEX3S4DBJDKZgsmsVP6nbBG
         MGbJt3XQsDWkkLfiOGySgfC6+7EHKZo8r18+eUzi01YHCpGhVdOFrw1S/FtIJVUJvigb
         S2oA==
X-Gm-Message-State: AOJu0YxLe7BqnNFMcaJgYfse2/BZN4YJEFmezzgANWRdLnJtlQXx1D5n
        06cX6QVDLzTyhZWECoS6BSIE1qr6fIslnOJTusU=
X-Google-Smtp-Source: AGHT+IFzwOknJTExUFuBDZ4/A7YfrxZ1A7/FifIpW9tQ+a8AlTtxwj4g+RD2UBT1OXubr7RaQRGrmWiyfP9Lc6pTP1s=
X-Received: by 2002:a25:d207:0:b0:d08:2101:562d with SMTP id
 j7-20020a25d207000000b00d082101562dmr5368297ybg.34.1692572891538; Sun, 20 Aug
 2023 16:08:11 -0700 (PDT)
MIME-Version: 1.0
References: <y4jBalhfESeCZDShmVaGwrdlIRoIHroqNVUUYLck6qGNwB5e7wbIJO5DoiLBTPpTNYtdneWRODjhXwlIl9VzokqxffdNU7y__1wIa7BBl94=@protonmail.com>
In-Reply-To: <y4jBalhfESeCZDShmVaGwrdlIRoIHroqNVUUYLck6qGNwB5e7wbIJO5DoiLBTPpTNYtdneWRODjhXwlIl9VzokqxffdNU7y__1wIa7BBl94=@protonmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 21 Aug 2023 01:08:00 +0200
Message-ID: <CANiq72nKnJFQcB3CX78HmP5FXANWD15Wwd0j+TdSgph3vzZ2_Q@mail.gmail.com>
Subject: Re: [PATCH] docs: add command line to rust-analyzer section.
To:     Guillaume Plourde <gplourde@protonmail.com>
Cc:     "ojeda@kernel.org" <ojeda@kernel.org>,
        "alex.gaynor@gmail.com" <alex.gaynor@gmail.com>,
        "wedsonaf@gmail.com" <wedsonaf@gmail.com>,
        "boqun.feng@gmail.com" <boqun.feng@gmail.com>,
        "gary@garyguo.net" <gary@garyguo.net>,
        "bjorn3_gh@protonmail.com" <bjorn3_gh@protonmail.com>,
        "nathan@kernel.org" <nathan@kernel.org>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        "trix@redhat.com" <trix@redhat.com>,
        "trix@redhat.co" <trix@redhat.co>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>
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

On Mon, Aug 14, 2023 at 5:07=E2=80=AFPM Guillaume Plourde
<gplourde@protonmail.com> wrote:
>
> Add command line to rust-analyzer section for convenience purposes.
>
> Signed-off-by: Guillaume Plourde <gplourde@protonmail.com>

Applied to `rust-next`, thanks!

I fixed the indentation to tab and slightly reworded the title --
please double check.

Cheers,
Miguel
