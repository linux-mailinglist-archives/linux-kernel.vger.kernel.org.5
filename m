Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 471C57F8BDE
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 15:55:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232098AbjKYOyl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 09:54:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231808AbjKYOyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 09:54:40 -0500
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32675EE;
        Sat, 25 Nov 2023 06:54:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=protonmail; t=1700924083; x=1701183283;
        bh=m7DRPE1YM1YZPMcaawIPOhHZs97EHiKr03J3c4DSLHc=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=A2Cb5xOl2/tPQFaBVFc5AK6egOaemZUuiqbgpvnaPsx+rLB87UFiYDP7jqOr0UEYa
         nfp81cuqANtXqjVX1lfynpi02and8F+BPuiIWT+TVsFWjt0qJL0A26pNR4evK05H4h
         e98FZNASWvD8dbfP4CDQ1KLbKTaPIilTGCZNdKYWo58zRl/R4TIxsm7OSD+Y0V5f6c
         VNRcXO7y0oSCKKWF//gYvvTFkSflRRRBbzbMsfQnbCzI90WnqJgMut15uOszRyKOyU
         eNWx9A6w05xbFLa/xp3WuKFhFFeh02pXBYsPFXLZaYacO5y951kUDF6vqgA6/te/vt
         /PA/2Xe+mmUdA==
Date:   Sat, 25 Nov 2023 14:54:29 +0000
To:     Alice Ryhl <alice@ryhl.io>
From:   Benno Lossin <benno.lossin@proton.me>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <walmeida@microsoft.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 3/3] rust: workqueue: add `#[pin_data]` to `Work`
Message-ID: <FAzxAy7jRUJ6uc-DBqKKJi76s7ddxab9IyXMW5g_SxyxJKCSH8Xarqda9M3-DTDFvlgmNr9S8-X4prDvw57ZLYqR953uK6pd1qGqFpXWWXk=@proton.me>
In-Reply-To: <45e5de7e-d787-4200-82dc-389cbdad9ee8@ryhl.io>
References: <20231125125024.1235933-3-benno.lossin@proton.me> <45e5de7e-d787-4200-82dc-389cbdad9ee8@ryhl.io>
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

On 25.11.23 15:35, Alice Ryhl wrote:
> On 11/25/23 13:51, Benno Lossin wrote:
>> +        pin_init!(Self {
>> +            work: Opaque::ffi_init(|slot| {
>=20
> Surely there should be an <- here instead of the : character?

You are absolutely correct. I did this so rustfmt would format it nicely. B=
ut
forgot to change it back.

--=20
Cheers,
Benno


