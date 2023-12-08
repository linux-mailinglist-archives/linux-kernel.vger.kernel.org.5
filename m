Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58A5780AB94
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 19:04:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574605AbjLHSEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 13:04:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235943AbjLHSET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 13:04:19 -0500
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 746061738;
        Fri,  8 Dec 2023 10:04:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=protonmail; t=1702058660; x=1702317860;
        bh=PTmEXgI7BxufT0npzlsJT5kiKHIgc9s02WiJV5XBNQU=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=Ku3Fwe5Ivvvv7/4sAslKhSLbNE2c16L8W9Vp2kURUwCdrCDOtvKhiKIMRbTdK+mLb
         Ti7kJUTNntqDHGEdE/Z0ZzRQtCNOd1Ub7YXRTUkkM6VYDHMchM9FzkXNzQT/blk/cd
         VxjB0iLT27kzVChTAGy0f6kaeZxfXQjbAyOG8tlH9uJunL93YkuR+lVz0cyeuMFjM6
         +cjKRCuJp7gCslhzCntRKnuKz4z9XlyqusEBM3xbN5iiNhb1niGGQIdNc/FDO37NjK
         BdutuscjCKkjvnVgI/ubh+oIPvQ+s8WYwvM1jJehNprfolLSsWuogbdxl87AYgN+o+
         CdGM0doVGmiOQ==
Date:   Fri, 08 Dec 2023 18:04:01 +0000
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>,
        Jonathan Corbet <corbet@lwn.net>
From:   Benno Lossin <benno.lossin@proton.me>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        rust-for-linux@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: rust: Clarify that 'rustup override' applies to build directory
Message-ID: <4738ad1c-eb54-4ad6-98c8-3852de3e8fc3@proton.me>
In-Reply-To: <bf0d4ff21bc25d1ba3a31e49a32bde06dcaf6e44.1702030679.git.viresh.kumar@linaro.org>
References: <bf0d4ff21bc25d1ba3a31e49a32bde06dcaf6e44.1702030679.git.viresh.kumar@linaro.org>
Feedback-ID: 71780778:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/8/23 11:18, Viresh Kumar wrote:
> Rustup override is required to be set for the build directory and not
> necessarily the kernel source tree (unless the build directory is its
> subdir).
>=20
> Clarify the same in quick-start guide.
>=20
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  Documentation/rust/quick-start.rst | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/rust/quick-start.rst b/Documentation/rust/quic=
k-start.rst
> index f382914f4191..a7a08955fe46 100644
> --- a/Documentation/rust/quick-start.rst
> +++ b/Documentation/rust/quick-start.rst
> @@ -39,8 +39,13 @@ If ``rustup`` is being used, enter the checked out sou=
rce code directory
>  =09rustup override set $(scripts/min-tool-version.sh rustc)
>=20
>  This will configure your working directory to use the correct version of
> -``rustc`` without affecting your default toolchain. If you are not using
> -``rustup``, fetch a standalone installer from:
> +``rustc`` without affecting your default toolchain.
> +
> +Note that the override applies to the build directory (and its sub-direc=
tories).

Shouldn't this be "Note that the override only applies to the current
working directory (and its sub-directories)."?
I think it would also be useful to continue with this: "But in order
to build the kernel, this override must affect the build directory.".

And then you could also mention that in the default location for the
build directory is in the repository.

--=20
Cheers,
Benno

> +If the kernel is built with `O=3D<build directory>`, the override must b=
e set for
> +the build directory instead.
> +
> +If you are not using ``rustup``, fetch a standalone installer from:
>=20
>  =09https://forge.rust-lang.org/infra/other-installation-methods.html#sta=
ndalone

