Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E199C7E2FAC
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 23:17:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233258AbjKFWRF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 17:17:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233216AbjKFWRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 17:17:04 -0500
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24DE1183;
        Mon,  6 Nov 2023 14:17:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=protonmail; t=1699309018; x=1699568218;
        bh=BNxWJUeheK6gz+So6VEqeeEFNOpFymOedNOxNufT0d0=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=AhnJxO6x4c/fSu8ujTAjajj1x3Mu/Din++uRfo0kverW+MHLIWmWKx6WmTmU8yp9R
         7FPjgfq3tlf+8MnWO8JaZ8okYOBh+tm9RngiZFaEjYZ9oqCfoOZGzHvsUixNPT7bhg
         /lq0bX4cnwl1AJ31WUs623LDmb4n3yG/+kZLaBwmZTxLuEhT4+X+iDbvhlajZKeQUP
         H1VbBmfHizNix7nj9LQ1usxSoPPXIpGzO9d8eqWjzO3DRyzuq5PowRaqKkeA/F5kDk
         oAqZkk3KM0acDSjIfA/siNk4XHRWeV2SrznQn/25k6gS+WSgItnlvUG5ijFr2n5JsO
         OPwBsbG6zf+ZQ==
Date:   Mon, 06 Nov 2023 22:16:53 +0000
To:     Gary Guo <gary@garyguo.net>, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        Vincenzo Palazzo <vincenzopalazzodev@gmail.com>
From:   Benno Lossin <benno.lossin@proton.me>
Cc:     Wedson Almeida Filho <walmeida@microsoft.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] rust: bindings: rename const binding using sed
Message-ID: <b73f01b8-1253-40df-8e22-06b6e3b6755d@proton.me>
In-Reply-To: <20231104145700.2495176-1-gary@garyguo.net>
References: <20231104145700.2495176-1-gary@garyguo.net>
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

On 04.11.23 15:56, Gary Guo wrote:
> diff --git a/rust/Makefile b/rust/Makefile
> index a27f35f924ec..57f7f5e5a95d 100644
> --- a/rust/Makefile
> +++ b/rust/Makefile
> @@ -337,6 +337,8 @@ quiet_cmd_bindgen =3D BINDGEN $@
>=20
>   $(obj)/bindings/bindings_generated.rs: private bindgen_target_flags =3D=
 \
>       $(shell grep -Ev '^#|^$$' $(srctree)/$(src)/bindgen_parameters)
> +$(obj)/bindings/bindings_generated.rs: private bindgen_target_extra =3D =
; \
> +    sed -Ei 's/pub const RUST_CONST_HELPER_([a-zA-Z0-9_]*)/pub const \1/=
g' $@

I think I mentioned this before, but I think this should use `^`
to ensure that this is only replaced at the beginning of lines.

--=20
Cheers,
Benno


