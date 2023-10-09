Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 075DF7BE3A1
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 16:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344930AbjJIOyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 10:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234554AbjJIOyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 10:54:35 -0400
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92CABAC
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 07:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=protonmail; t=1696863270; x=1697122470;
        bh=ymlaUVVXJ+Th4cNPzJgcV4MwmbIo6pX1Ds9YjsPWOLw=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=nFpfho4+A48XTr/+ObS3l7NWx9W3mSLKvweAC1P77ZAZOOYT6SDeh2zoPnDG4j88H
         SRw5kphw9F75gRdyCUUr8/zOM8uxBs9/JXR6F/RmoaAhvJHRMBfrM2dmWlwO3K8IgU
         6y0rKFXrMYsQXxunHHAVpJQkf2Dtk5u+QMDsUH8aE6dHFNtN0+e31X+8QS9sHt1vkx
         /Yay3PyzdV6AdFr9m3f/hAxVNtLsR/Z/sM64B/fmeoi+9MolSD9qEueGeDfPi8yFhi
         eD61AwMwZH3dX5f/IbijSTD1dguHuER8JzSIb3MXHNhvaoUMsBxATuAhksplpVejxr
         62PAsZ5ohOaIg==
Date:   Mon, 09 Oct 2023 14:54:25 +0000
To:     Wedson Almeida Filho <wedsonaf@gmail.com>,
        rust-for-linux@vger.kernel.org
From:   Benno Lossin <benno.lossin@proton.me>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>,
        linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>
Subject: Re: [PATCH] rust: error: fix the description for `ECHILD`
Message-ID: <5122b6b6-12d5-0337-0c04-3e30da1f3898@proton.me>
In-Reply-To: <20230930144958.46051-1-wedsonaf@gmail.com>
References: <20230930144958.46051-1-wedsonaf@gmail.com>
Feedback-ID: 71780778:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.09.23 16:49, Wedson Almeida Filho wrote:
> From: Wedson Almeida Filho <walmeida@microsoft.com>
>=20
> A mistake was made and the description of `ECHILD` is wrong (it reuses
> the description of `ENOEXEC`). This fixes it to reflect what's in
> `errno-base.h`.
>=20
> Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
> ---
>   rust/kernel/error.rs | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
> index 05fcab6abfe6..bab2c043fc42 100644
> --- a/rust/kernel/error.rs
> +++ b/rust/kernel/error.rs
> @@ -37,7 +37,7 @@ macro_rules! declare_err {
>       declare_err!(E2BIG, "Argument list too long.");
>       declare_err!(ENOEXEC, "Exec format error.");
>       declare_err!(EBADF, "Bad file number.");
> -    declare_err!(ECHILD, "Exec format error.");
> +    declare_err!(ECHILD, "No child process.");

Strictly speaking, `errno-base.h` documents this as "No child
processes" (note the plural), but I am fine with taking it as-is.

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

