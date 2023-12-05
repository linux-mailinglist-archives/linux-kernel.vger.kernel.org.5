Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1945805B52
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:48:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232021AbjLERik (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 12:38:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232367AbjLERJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 12:09:04 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 182661B1
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 09:09:10 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-548ae9a5eeaso13030a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 09:09:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701796148; x=1702400948; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bkFwzVvbe6yA1cIGZShUgkfM/+JdLkcU+PGFPzrYDiU=;
        b=Nn1mW42Ntk6S9u0SXVGzDwkIxzFQXdacusxu0YE20oQtR50XCAfnGrN5uEXnxkjJH6
         tX8tyr8s5f94c8kwmt4aLjZV47wIzngjzFzYkCGgoYzwSkEWE/mrg6drVKcgiNKFxOa+
         xPT5YXWFu9tWTrxPgjFKcnlI3VWSd+JNwy8u3BjyT0n7uEbtriTGqq5BcdjPzlRstMmi
         prNdnrSA0x3dI1luVwIiMTrygQ2FNEdIVpGeSAw+C3TD5A4PXaB2FK4CeTRBHwISyWJK
         81ARf6vf6315JJQtNjhAIsIqOhgWQuq0DEny+mGeDcJ32wrzwnEyUWYE+28/IVbEk2Pe
         qQqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701796148; x=1702400948;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bkFwzVvbe6yA1cIGZShUgkfM/+JdLkcU+PGFPzrYDiU=;
        b=UKGV9aezccPV9P77FpM3yqzXunAMVTQQgYQ9FmRSA5ZK2VlTHfOskke3Ib/z/MNjGC
         nr6Cl9fs7hH/vPeH5tdu/uyG2bwrbg4zLQ+pQeweMuwmBZbCl6JwLhEWmIf8XvCvJ7OQ
         rSUnUotIXhuWzdk2Z32Hvf6Z98v/SWtQ2/ihwnuC53iOR/fj+MDCDY14JY7nHQBbsRyX
         xUrKM9QPItb5sAd3kMJRYyfqs9lhpOxRkAC+AbgArmJvWGGgKE+of7kQ33XK0YiYVqj+
         soN7/sfCLWbohnZl6ge6VrlEIMKBrG8dP8ITLpor1S0evKZlUKiaB3UV8rg2eGvHHKnr
         otPg==
X-Gm-Message-State: AOJu0YxipAoQLaJZaIeZMv16vy4sw9mKIg/EV8OiO9hbLVsO/GNkd1qU
        1dVsFxSJFJkXM3jAsJ12kMO73+rkKT86jyvjO5vcrA==
X-Google-Smtp-Source: AGHT+IF2i5XyQR1RU0uyna1eHXekO04dHiuZe6LQ98fv76mTz4QyL/jue4lAyxNlVBJ58/FzkHyI8lVwMuntfPY/V1c=
X-Received: by 2002:a05:6402:35d3:b0:54c:9996:7833 with SMTP id
 z19-20020a05640235d300b0054c99967833mr312277edc.7.1701796147967; Tue, 05 Dec
 2023 09:09:07 -0800 (PST)
MIME-Version: 1.0
References: <CAG48ez0TfTAkaRWFCTb44x=TWP_sDZVx-5U2hvfQSFOhghNrCA@mail.gmail.com>
In-Reply-To: <CAG48ez0TfTAkaRWFCTb44x=TWP_sDZVx-5U2hvfQSFOhghNrCA@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 5 Dec 2023 18:08:29 +0100
Message-ID: <CAG48ez1hXk_cffp3dy-bYMcoyCCj-EySYR5SzYrNiRHGD=hOUg@mail.gmail.com>
Subject: Re: Is xt_owner's owner_mt() racy with sock_orphan()? [worse with new
 TYPESAFE_BY_RCU file lifetime?]
To:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        netfilter-devel <netfilter-devel@vger.kernel.org>,
        coreteam@netfilter.org
Cc:     Christian Brauner <brauner@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Network Development <netdev@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 5, 2023 at 5:40=E2=80=AFPM Jann Horn <jannh@google.com> wrote:
>
> Hi!
>
> I think this code is racy, but testing that seems like a pain...
>
> owner_mt() in xt_owner runs in context of a NF_INET_LOCAL_OUT or
> NF_INET_POST_ROUTING hook. It first checks that sk->sk_socket is
> non-NULL, then checks that sk->sk_socket->file is non-NULL, then
> accesses the ->f_cred of that file.
>
> I don't see anything that protects this against a concurrent
> sock_orphan(), which NULLs out the sk->sk_socket pointer, if we're in

Ah, and all the other users of ->sk_socket in net/netfilter/ do it
under the sk_callback_lock... so I guess the fix would be to add the
same in owner_mt?
