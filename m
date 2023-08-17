Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9182A77FE09
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 20:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354064AbjHQSly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 14:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354099AbjHQSla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 14:41:30 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2069C30C5;
        Thu, 17 Aug 2023 11:41:29 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73:dffa:9883:e232:5c72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id AE84721A6;
        Thu, 17 Aug 2023 18:41:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net AE84721A6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1692297688; bh=d6+Ykv748Qq+9/JOmQJdkszxyXJBo3Vy4SPPwQPoxME=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=duWC7U3u6DiU/rF2sxbfFQ/bXY+6HvwPIXO3gJzZKG37/n1PYNTyDLB0hDzvxZKvH
         H4BcLpyVlcFr2ZGfRyqZE7JUH3TpLkhF7ZNpWsR1dvmPFwwj5zEwqTLEqQ3sIg5hl2
         T41Ci9ktlKzpiCvAHYx9Xjca+bEYKE7z3FJJY9+JRF0/YRNG80/60Z+OKGtwDfYkB7
         68rgpUWeEaicdfBmhfT7IlrDlClhsRUsyepohYscF8FxTrxWB6CyfUDq/8pu38fJUR
         FtrO7JjDwcG+m2qF3RhnxTn3vBf17RAHV7Dj8Sg5JwmJnM8vAQsTlfaW69vcs4RtAR
         ydo6bSVgKzMVA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Jakub Kicinski <kuba@kernel.org>,
        Michele Dalle Rive <dallerivemichele@gmail.com>
Cc:     Andrew Lunn <andrew@lunn.ch>, Greg KH <gregkh@linuxfoundation.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Alice Ryhl <aliceryhl@google.com>,
        Davide Rovelli <davide.rovelli@usi.ch>,
        rust-for-linux@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [RFC PATCH 0/7] Rust Socket abstractions
In-Reply-To: <20230817084848.4871fc23@kernel.org>
References: <20230814092302.1903203-1-dallerivemichele@gmail.com>
 <2023081411-apache-tubeless-7bb3@gregkh>
 <0e91e3be-abbb-4bf7-be05-ba75c7522736@lunn.ch>
 <CACETy0=V9B8UOCi+BKfyrX06ca=WvC0Gvo_ouR=DjX=_-jhAwg@mail.gmail.com>
 <e3b4164a-5392-4209-99e5-560bf96df1df@lunn.ch>
 <CACETy0n0217=JOnHUWvxM_npDrdg4U=nzGYKqYbGFsvspjP6gg@mail.gmail.com>
 <20230817084848.4871fc23@kernel.org>
Date:   Thu, 17 Aug 2023 12:41:27 -0600
Message-ID: <87y1i91pgo.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jakub Kicinski <kuba@kernel.org> writes:

> I thought the Rust was just shaking up the languages we use, not the
> fundamentals on how this project operates :|

I don't think this little episode has anything to do with Rust, really;
certainly we've had no shortage of companies wanting support for
out-of-tree modules written in C over the years.

Instead, this is just the sort of thing you see when people who are new
to our community learn - the hard way, sometimes - how kernel
development works.  Rust seems likely to bring in a fair number of new
developers, which is great, but we're going to have to help them learn
their way around.

Thanks,

jon
