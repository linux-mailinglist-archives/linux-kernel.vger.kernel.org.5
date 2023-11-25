Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C9607F8BE7
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 16:02:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232149AbjKYPCS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 10:02:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231808AbjKYPCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 10:02:16 -0500
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42E3AF7
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 07:02:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=bk4765lcuzg2bdnuqztpj764ku.protonmail; t=1700924540; x=1701183740;
        bh=gof9ChInamH5ECCSkTNXtzzGmXtuXsCMfRl1DTKJMUc=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=Q0aGNxFzedO96fXx4SBrwy0BzQxVjSYmwUC/QPgdyzY0U0REORTDn/ZtMrcs0ToY4
         Icqr4dUeXLx0wbtGkAtt/1juIOzYvFV6zqaNbXNaXRz4nLy40WzbFBZy8v1ikW4TEA
         kTVn9n9vnq6encvzpBoAJumtZ0TPLv+MYDeZYxOAL+sG7/9xe/33yyluxM3dQ9mij3
         61FYKbmXFadOqvBff/Hl7WvEQiHe2zOBL0hh3yuiatPe3ctB4ps4BaVssF6GaiKIDb
         ADXumuvo7WwlxJ8hQJOhtLXqh0c/nQM19fSAGRap0FcZxYxUDjkT+MQEzcKzgQ2YYI
         /FShV5AXEfa3g==
Date:   Sat, 25 Nov 2023 15:02:00 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
From:   Benno Lossin <benno.lossin@proton.me>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] rust: macros: allow generic parameter default values in `#[pin_data]`
Message-ID: <t4HJjY0Oft2K2H1ssXTxZchdPTx25J6WqSJqAx75NiRUYg40BBLt1AHxm9ZF0UA70FkqIXb6Pp2sz3BErD-AyXmQCkU4xDvqyXHSinaWGb4=@proton.me>
In-Reply-To: <2023112525-impatient-untwist-ee3d@gregkh>
References: <20231125125024.1235933-1-benno.lossin@proton.me> <20231125125024.1235933-2-benno.lossin@proton.me> <2023112525-impatient-untwist-ee3d@gregkh>
Feedback-ID: 71780778:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.11.23 15:26, Greg KH wrote:
> On Sat, Nov 25, 2023 at 12:51:09PM +0000, Benno Lossin wrote:
>> This patch adds compatibilty for generic parameters defaults by using
>> the newly introduced `decl_generics` instead of the `impl_generics`.
>=20
> This says _what_ is happening here, but not _why_ this is needed at all.
>=20
> Try taking a look a the kernel documentation for how to write a good
> changelog text to make this much better.  It's often times the most
> difficult portion of making a kernel patch, the code is easy, writing a
> summary of why everyone else should agree that this code is acceptable
> is hard.

The reason is hidden in the third patch. Without this, the `#[pin_data]
macro would not allow specifying const generic parameter default values
and instead emit a compile error. I will add this to v2.

--=20
Cheers,
Benno


