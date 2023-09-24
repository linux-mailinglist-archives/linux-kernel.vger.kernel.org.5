Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F289A7AC7D5
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 14:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbjIXL7h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 07:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjIXL7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 07:59:36 -0400
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A5B8FE
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 04:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=protonmail; t=1695556766; x=1695815966;
        bh=oQo/kb9ebTvq/QgNY8lAYDLsGdDSn7gbpv3qtZMT6f4=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=bv3YO44uaO8A7qa85xsHVdWNZwSzicjbY9tiX+UHqPNTzKlOI7qAVR9lPGMufjG+w
         5KVSl2ZNU9RVOnOxOnZ4XbTx47ZgU2aaiVjQEsmWMLHHDDc98syOExiIFqS25axYp0
         mpWL4UeQ4u5H+Deu3vnXB+/DM8OSPzfl3tYxe4fp0xeUETfvOTiZmJAIp0GN79dzeO
         UTWSVyTrzjne8NCqpR0oEvF6xcy93Y0up6T8tp/ob4757M+6FDIpUe4NIK9SYUbq6q
         kqygRBaroV3T1IA9X7bFShtgf5IyLOCDHKfwFhsQXYy47VfsO/3hZySh0gMSScdK7E
         UPocTuP1ElCWg==
Date:   Sun, 24 Sep 2023 11:59:20 +0000
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
Subject: Re: [PATCH v2 1/2] rust: arc: rename `ArcInner` to `WithRef`
Message-ID: <48800564-0024-26f7-ae8f-9bf4523360aa@proton.me>
In-Reply-To: <20230923144938.219517-2-wedsonaf@gmail.com>
References: <20230923144938.219517-1-wedsonaf@gmail.com> <20230923144938.219517-2-wedsonaf@gmail.com>
Feedback-ID: 71780778:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.09.23 16:49, Wedson Almeida Filho wrote:
> From: Wedson Almeida Filho <walmeida@microsoft.com>
>=20
> This is in preparation for removing `ArcBorrow` and making `WithRef`
> public.
>=20
> This is a pure name change with no functional changes intended.
>=20
> Suggested-by: Bj=C3=B6rn Roy Baron <bjorn3_gh@protonmail.com>
> Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
> ---
>   rust/kernel/sync/arc.rs            | 20 ++++++++++----------
>   rust/kernel/sync/arc/std_vendor.rs |  4 ++--
>   2 files changed, 12 insertions(+), 12 deletions(-)

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

