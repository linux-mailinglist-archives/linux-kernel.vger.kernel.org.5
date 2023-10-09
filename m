Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D90F7BE38C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 16:51:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344640AbjJIOvq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 10:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbjJIOvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 10:51:44 -0400
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B38DA3;
        Mon,  9 Oct 2023 07:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=protonmail; t=1696863098; x=1697122298;
        bh=6sKASihZm9I/toAswxlIwK+AAwIK2Fz8cJLnFLKHAas=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=C7x/rMsk2bCe3th6KW2UmrTnFHKpuIP0EvK7pPEmUOh9B+17B5nucfHHvuou/NCwf
         YFoM/5ItEpq8axKW8TZfhNC2iGOd2Rf5M0o3CJ9BoOCqwFwtIGZC07rGIaqDMO+yqk
         kYvVvJcN9bneqQ1z14PVlnUDkTVrEmh1XrzN4pMsXtIysuobgXIcnQ/Z8kQEc19TOx
         z4cl7A8yaZ7khENkgHqTUeGRei1dS5iQj0tJ0u1xRR9zY2xk8RDWlQyn/XSTxePCrR
         odkWPdSzwHQYIxaOsbGPEVu8j9vptTYS1Zg8t+m5k+AVRnEFa38KXofmBhLrUeY5Ld
         GHAfl0ohUeyhw==
Date:   Mon, 09 Oct 2023 14:51:33 +0000
To:     Trevor Gross <tmgross@umich.edu>, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>
From:   Benno Lossin <benno.lossin@proton.me>
Cc:     Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        FUJITA Tomonori <fujita.tomonori@gmail.com>
Subject: Re: [PATCH] rust: macros: update 'paste!' macro to accept string literals
Message-ID: <e36687f8-8c70-0759-ecbb-4afc06b27197@proton.me>
In-Reply-To: <20231008094816.320424-1-tmgross@umich.edu>
References: <20231008094816.320424-1-tmgross@umich.edu>
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

On 08.10.23 11:48, Trevor Gross wrote:
> Enable combining identifiers with string literals in the 'paste!' macro.
> This allows combining user-specified strings with affixes to create
> namespaced identifiers.
>=20
> This sample code:
>=20
>      macro_rules! m {
>          ($name:lit) =3D> {
>              paste!(struct [<_some_ $name _struct_>];)
>          }
>      }
>=20
>      m!("foo_bar");
>=20
> Would previously cause a compilation error. It will now generate:
>=20
>      struct _some_foo_bar_struct_;
>=20
> Reported-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> Signed-off-by: Trevor Gross <tmgross@umich.edu>

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

