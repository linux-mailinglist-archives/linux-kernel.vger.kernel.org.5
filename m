Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F23597E4F43
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 04:01:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234780AbjKHDBy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 22:01:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234013AbjKHDBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 22:01:53 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B797910EC;
        Tue,  7 Nov 2023 19:01:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=h36Fp+oGSZZThQKXVlSOBuQnKzshdSZBHiXatxwGT+Y=; b=ElnjHmAwWkFuzcNJjP5dtneZrL
        30f02EklI2wvJ0YOQm5TlAG2ilPFzhZzJiYEzkTvITM8h3L7YsV7R2CLjirpZyQ1v0Mg8HexbaMpS
        xbkjGzSQu4yqZFmwwLdNBjLpWcPOKqgMv1HAXL64PtDRK1rRKz8v5ISfLa0bdbQcYZX1jOOlI9Jvk
        dLnkliPurnPOd0PYQK1pNX/eQN/s906JwxaO19gKxNCtHtk5l9FKaNWTzMmmQmWvh+YNJOjZYY3yA
        oyRQfa93Thb+bCIazfCZyNKfFh14nlwq1WRyO0mzbUqrsvx3atI+T9rffPokTc2J40erlIjUiLd23
        n1QoIm4w==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1r0Yp9-002qcW-12;
        Wed, 08 Nov 2023 03:01:47 +0000
Message-ID: <3f0a6313-afe4-4e51-b22a-5728f3d0b11d@infradead.org>
Date:   Tue, 7 Nov 2023 19:01:45 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] kconfig: Add special rust_modules config option
Content-Language: en-US
To:     Matthew Maurer <mmaurer@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>
Cc:     linux-kbuild@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>,
        linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
References: <20231108022651.645950-2-mmaurer@google.com>
 <20231108022651.645950-5-mmaurer@google.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20231108022651.645950-5-mmaurer@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/7/23 18:26, Matthew Maurer wrote:
> Adds support for the rust_modules kconfig type, which works similarly to
> modules, but for restricting or allowing the use of modules which
> directly depend on Rust.
> 
> Signed-off-by: Matthew Maurer <mmaurer@google.com>
> ---
>  scripts/kconfig/confdata.c |  3 +++
>  scripts/kconfig/expr.h     |  1 +
>  scripts/kconfig/lexer.l    |  1 +
>  scripts/kconfig/lkc.h      |  1 +
>  scripts/kconfig/menu.c     |  7 +++++--
>  scripts/kconfig/parser.y   | 12 ++++++++++++
>  scripts/kconfig/symbol.c   | 31 +++++++++++++++++++++++++++++--
>  7 files changed, 52 insertions(+), 4 deletions(-)
> 

Hi,

This appears to be a change to the Kconfig language, so please update
Documentation/kbuild/kconfig-language.rst with some prose explaining it.

Thanks.
-- 
~Randy
