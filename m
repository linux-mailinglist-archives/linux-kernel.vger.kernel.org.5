Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 776157AC068
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 12:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231307AbjIWKWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 06:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231278AbjIWKWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 06:22:15 -0400
Received: from gimli.kloenk.dev (gimli.kloenk.dev [49.12.72.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B96861A8;
        Sat, 23 Sep 2023 03:22:09 -0700 (PDT)
From:   Finn Behrens <me@kloenk.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kloenk.dev; s=mail;
        t=1695464526; bh=FO50o08Po0Xx+Jpyymv92T8V3NW0ykl4byaAUjIu+CY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=dFqnTiLnrXueRxB9Povae2dHJ/LDmP/bN5R9UBGTboQBrTdSg8toX/D6oL6Uvox6q
         QBA/9JsmlX2ZH3I8jjxttXX/kYcF87cYEoRWUMpzBDXcoRy3VB52Pu7HuDhBk52NI6
         yvqFLAJFPmV8ihD3Pmh56dUW6m04LLVKcmj7HouY=
To:     Gary Guo <gary@garyguo.net>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        Ben Gooding <ben.gooding.dev@gmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: remove ignores for `clippy::new_ret_no_self`
Date:   Sat, 23 Sep 2023 12:22:04 +0200
Message-ID: <BCB65894-E7CB-48BF-8A93-BEC73A81C240@kloenk.dev>
In-Reply-To: <20230923024707.47610-1-gary@garyguo.net>
References: <20230923024707.47610-1-gary@garyguo.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23 Sep 2023, at 4:46, Gary Guo wrote:

> The clippy false positive triggering `new_ret_no_self` lint when using
> `pin_init!` macro is fixed in 1.67, so remove all `#[allow]`s ignoring
> the lint.
>
> Signed-off-by: Gary Guo <gary@garyguo.net>
> ---

Reviewed-by: Finn Behrens <me@kloenk.dev>
