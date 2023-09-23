Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FDC67AC30D
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 17:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231887AbjIWPED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 11:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231869AbjIWPEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 11:04:01 -0400
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F35B7196;
        Sat, 23 Sep 2023 08:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=57b3cr2nfbdyjf3g77ru3a4vem.protonmail; t=1695481430; x=1695740630;
        bh=Chjm2AZttFwpleadM5PaZGr2osi32W+sjTU8gNi8vpk=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=DSJR2d3fX6MoAtThQRR0nCfRm0iMFhpoB2fT/bCzn3gZjaK36NE8NJOj/Vef5zPlV
         TT87q0ztojoXNCgb23vIJ3HQgesl5e2zcWDxZGb79ZgVZD89cwt35LnToIzFIJWlmx
         LJQNg/Hl5q9P4pvXAGZtNR0Dr8KCclr8xJ0LvbCgTh+buGZNfbg+pH+AAXSfVM84Ax
         f7BocvfNbrX4IHqBElON8y/dUDoLwa0ESyJQDb+nnfhmkoQ1AUSTURcxR3WapktA2H
         k8KCZyS9L7lLi9emAle9o55j5V9xHsSz5p96FsURpq4RNr2w4pluysl/RQPiqlOG6v
         HT2IJ8NGqTikg==
Date:   Sat, 23 Sep 2023 15:03:40 +0000
To:     Gary Guo <gary@garyguo.net>, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        Ben Gooding <ben.gooding.dev@gmail.com>
From:   Benno Lossin <benno.lossin@proton.me>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: remove ignores for `clippy::new_ret_no_self`
Message-ID: <600d5369-5520-c2b3-2e1b-2af9ae3f77c3@proton.me>
In-Reply-To: <20230923024707.47610-1-gary@garyguo.net>
References: <20230923024707.47610-1-gary@garyguo.net>
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

On 23.09.23 04:46, Gary Guo wrote:
> The clippy false positive triggering `new_ret_no_self` lint when using
> `pin_init!` macro is fixed in 1.67, so remove all `#[allow]`s ignoring
> the lint.
>=20
> Signed-off-by: Gary Guo <gary@garyguo.net>
> ---
>   rust/kernel/init.rs         | 20 ++++++++++----------
>   rust/kernel/sync/condvar.rs |  1 -
>   rust/kernel/sync/lock.rs    |  1 -
>   3 files changed, 10 insertions(+), 12 deletions(-)
>=20

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

