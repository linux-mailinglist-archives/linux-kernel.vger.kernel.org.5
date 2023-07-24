Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E672F76011A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 23:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbjGXVVs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 17:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbjGXVVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 17:21:46 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D57AB1737;
        Mon, 24 Jul 2023 14:21:40 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 1603A733;
        Mon, 24 Jul 2023 21:21:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 1603A733
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1690233700; bh=gaNKVqyvP22L4mM+8WXVkl4QkXFivhR0y8i1kXszzPQ=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Imyn4jnOBa86K/OaOKITI/KBfz9yvh0y9ALfYriy5qxu4LN+yV24qqe3iRsQWGXet
         Z0x30JO9siMaPYMDEly+xc1qoNp45ZaUQ1D85j9tUoC6C5NVbGLODqkfajJaPYXs0N
         KFT7VVC9eI8oduNvf/yvbgOi9hQ5JCJuSm9uDzMiQMhkAigNV1uBCRBERqqny9mtXY
         VcQdMGxkwxZcXHjLPVM7yP2kJyq7AqvEX51t1e0q6hb47Ba7f6fiodQUqvxe7mcXT2
         a/TsUs0wUQQIY8VUy/Uurzj1/RQMIhvRoz77GY4o2+QyPG0ySzzrSOxjoLuOcPIxdP
         3iGu6Y+qoYdXw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Costa Shulyupin <costa.shul@redhat.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION PROCESS" <workflows@vger.kernel.org>,
        "open list:RUST" <rust-for-linux@vger.kernel.org>
Cc:     Costa Shulyupin <costa.shul@redhat.com>
Subject: Re: [RFC PATCH] rework top page and organize toc on the sidebar
In-Reply-To: <20230724193118.2204673-1-costa.shul@redhat.com>
References: <20230724193118.2204673-1-costa.shul@redhat.com>
Date:   Mon, 24 Jul 2023 15:21:39 -0600
Message-ID: <87ila9atuk.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Costa Shulyupin <costa.shul@redhat.com> writes:

> Template {{ toctree(maxdepth=3) }} in
> Documentation/sphinx/templates/kernel-toc.html
> uses directives toctree and doesn't use sections on the top page
> Documentation/index.rst
> to generate expandable toc on the sidebar.
>
> BTW, other template {{ toc }} uses only sections, and doesn't
> use directives toctree.
>
> Summary of changes:
> - split top page index.rst to several pages
> - convert sections of Documentation/index.rst to hierarchical toctree
> - vertical bars '|' add empty lines
>
> Benefits:
> - collapsed toc is just seven short lines length
> - toc is expandable
>
> References:
> - https://www.sphinx-doc.org/en/master/development/templating.html#toctree
> - https://www.sphinx-doc.org/en/master/usage/restructuredtext/directives.html#directive-toctree
> - https://www.sphinx-doc.org/en/master/development/templating.html#toc
> - https://www.sphinx-doc.org/en/master/usage/restructuredtext/basics.html#sections
> - https://sphinx-rtd-theme.readthedocs.io/

What is the purpose of all these links in a patch changelog?

This patch is somewhat difficult to apply, as a result of:

> Content-Type: text/plain; charset=true

But the real problem is that you seem to have ignored my last message.
The purpose of the front page isn't to create a nice-looking sidebar, it
is the entry point to our documentation as a whole.  I am all for a
better sidebar, but this is not the way to do it.

jon
