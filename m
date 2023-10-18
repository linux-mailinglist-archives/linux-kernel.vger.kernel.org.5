Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81F1E7CE555
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 19:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbjJRRwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 13:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbjJRRwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 13:52:16 -0400
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84854113
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 10:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=bukk2el6ffc2jlr6cnysroyswa.protonmail; t=1697651532; x=1697910732;
        bh=7YLZ6YBfW+uBf8TkCH/eJD44OCqiSuRU6iHamk93ONY=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=jgsUpik+1bG0rtK7LxUJo4oXvzPZDqpiKWw93hIvyK6zyVQ2zgu2uz0qPlMz/AYaY
         UmBHKWJ7oJ+EvoOfYOG9KeDoS9lqqAx3X7tOruBfPaT+JW3VKqCCY4gXfYn4MRNq45
         BuTkyhxGJOtxW2a+I0q0lvoFSTcy7TiupGGxZ88O/1dz3Kia6NuFG67Qr5vNMyVfvo
         cZ5tNFMG50E0ldFjpg1CYCl/8YiRi0Gx+CLQ8zayOLDwdRrf8Rv81TFkxX7aa94NVY
         sSr9n5pi3cUsFQO8l6nv5DyhVBMRQvhGPi0cDCbCh9UtAw0tNls3GmqscCDua4bijT
         66RxZa2+sjBxg==
Date:   Wed, 18 Oct 2023 17:51:55 +0000
To:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>
From:   Benno Lossin <benno.lossin@proton.me>
Cc:     Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH] rust: docs: fix logo replacement
Message-ID: <d1107a9c-87b1-4571-841c-04bc60083f85@proton.me>
In-Reply-To: <20231018155527.1015059-1-ojeda@kernel.org>
References: <20231018155527.1015059-1-ojeda@kernel.org>
Feedback-ID: 71780778:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.10.23 17:55, Miguel Ojeda wrote:
> The static files placement by `rustdoc` changed in Rust 1.67.0 [1],
> but the custom code we have to replace the logo in the generated
> HTML files did not get updated.
>=20
> Thus update it to have the Linux logo again in the output.
>=20
> Hopefully `rustdoc` will eventually support a custom logo from
> a local file [2], so that we do not need to maintain this hack
> on our side.
>=20
> Link: https://github.com/rust-lang/rust/pull/101702 [1]
> Link: https://github.com/rust-lang/rfcs/pull/3226 [2]
> Fixes: 3ed03f4da06e ("rust: upgrade to Rust 1.68.2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Works for me.

Tested-by: Benno Lossin <benno.lossin@proton.me>

--=20
Cheers,
Benno


