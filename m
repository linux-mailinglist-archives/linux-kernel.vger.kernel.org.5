Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24E0579128A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 09:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352441AbjIDHst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 03:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244268AbjIDHsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 03:48:47 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E544ED
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 00:48:42 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2bccda76fb1so17799411fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Sep 2023 00:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20230601.gappssmtp.com; s=20230601; t=1693813720; x=1694418520; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=rYrT/OBD2Zjx+XkX7u24UqYymx1MH3uTPX/Eopb7uUY=;
        b=zl0uKz0nZsKSAygGoCvYFwKtWZTI14UOOALL5Cy6N/wGWz4LlEa/kfWMc4tWYDrWzz
         KQ9+lOZVpY0ia6+Ry6AHVZefrdaL+5+hSystYBRrYzd9/A/Dmc6PidbQ6I3aW3LlJ/EW
         xlhjJgjQtusbkusBCAoBsR+Ir7z8OeQwrzttGdzqQmc7/S9DzNYN8m/EE7UzHhy8MZaS
         oQgZOMCNQMkY6Rks62B8OOL3/xNneq4yqtiI0UJlT9XGvxmFsAcJ8GEcImie1MvcO1EB
         gAhPhcYPld/gsYMtsC/+8xpM2Ft08QAyLdQl3JRiWElEfx8e6THHtJ8COmD09cgw1OYx
         Q4TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693813720; x=1694418520;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rYrT/OBD2Zjx+XkX7u24UqYymx1MH3uTPX/Eopb7uUY=;
        b=OI51jp7SDzZeo3g2jTC+8Dhh/sqW9sGUNkUUnKWgbVYNdOCZkpIiAeSs3IjEz5TF+s
         0HQAaV4oaZWuBPjqj81oF/d4eVtzAaJGvqAeJE6GWRWzkYe31uZw60pehktVM5quue1B
         EJWd2TmYd/H60tF03Hfc5TyBENFbUjSJtVVkXYt3CTYu6a84kk00vTWYi6rJkdnfAfcE
         ImYNr+a3aaQed7H0dc1cUoq7Di9uD93R1uzWlXZeWt/BXsOuoSe0jg+LCj73t8aCN4Fs
         Cn1LE5jb5t8sMZSpwdXEcorU9ezrzmAfb0gIJigsZfcpTl/BJrfWMtuITcjfa45iGRDf
         o9Ug==
X-Gm-Message-State: AOJu0YxuF/66qE5H0P5kLt4sQv94ZbWRD8K6uwB+ikcR8/k7KlctkPFC
        j96wnRZjHcVFiEAf2b0w1mEtYg==
X-Google-Smtp-Source: AGHT+IHIoedgWTzQVLwkmmr1H6x7PvoQzeRB9iDwXkD31dT6UvjTDDGRznVwz5aXCithFb0S9liFBQ==
X-Received: by 2002:a2e:8898:0:b0:2bc:c11c:4471 with SMTP id k24-20020a2e8898000000b002bcc11c4471mr6624856lji.21.1693813720447;
        Mon, 04 Sep 2023 00:48:40 -0700 (PDT)
Received: from localhost ([165.225.194.194])
        by smtp.gmail.com with ESMTPSA id u7-20020a05600c210700b003fe4ca8decdsm16341300wml.31.2023.09.04.00.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Sep 2023 00:48:40 -0700 (PDT)
References: <20230830165949.127475-1-ojeda@kernel.org>
 <20230830165949.127475-2-ojeda@kernel.org>
User-agent: mu4e 1.10.5; emacs 28.2.50
From:   "Andreas Hindborg (Samsung)" <nmi@metaspace.dk>
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Alice Ryhl <aliceryhl@google.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Subject: Re: [PATCH 2/2] MAINTAINERS: add Maintainer Entry Profile field for
 Rust
Date:   Mon, 04 Sep 2023 09:48:21 +0200
In-reply-to: <20230830165949.127475-2-ojeda@kernel.org>
Message-ID: <87ledmtm3s.fsf@metaspace.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Miguel Ojeda <ojeda@kernel.org> writes:

> The `P:` field allows a URI, and we have been adding information
> on how to contribute to the Rust subsystem to our webpage for a
> while now (and other relevant topics, e.g. branches, third-party
> crates, Rust unstable features...).
>
> The webpage/document does not currently follow the headings of
> the Maintainer Entry Profile, but it does nevertheless answer
> some of the questions we have got so far from contributors and
> it covers partially some of the topics there.
>
> Thus link to our "Contributing" document [1].
>
> Link: https://rust-for-linux.com/contributing [1]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---

Reviewed-by: Andreas Hindborg <a.hindborg@samsung.com>

