Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 221A87B738F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 23:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232424AbjJCVzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 17:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232355AbjJCVzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 17:55:05 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DEC6A1
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 14:55:02 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-5a22eaafd72so17953577b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 14:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696370102; x=1696974902; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Xv9u3ucLLjlP5EiWRSs6ylR+qTsic8mZD/1X78BJP4=;
        b=iNiqPr8ARa1PX5RdHu3c3XdkbbLQLIvvwybyicAqEaASgrxKoWYCfe6gs0ncD5Qa5e
         MyRGYXZxfPOPNmlTnwi/HDoZF6gImzR8XDvrgDA17yoHrU8nOWME7GGVOwP9O4Ftxqjo
         BHy4Jrg7A2b0iSf0GoAAN0gQhWB/9I3S88f8O2KBnNnJFFlw65ps03/6CEcTMwwMf4Zs
         zhH/Qm7slv4kVC/fuRpmIM1bxy6JgBhuy6b2OE9ZJuIH+IljJXV8y/P4f6aPjKZL93nf
         Gsv/FoYYyr996kflPDiXGmT9Fz/DWiAJKEUGMMcqO+ik/GMaDJcOLcKTT4zx+hvY9LYt
         dhsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696370102; x=1696974902;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Xv9u3ucLLjlP5EiWRSs6ylR+qTsic8mZD/1X78BJP4=;
        b=pgmMqtQE9pIZ84CjK+nKBATGDEajwiR94bbHBOi4TBkXTOczElP9gsqt3JWLKFtX9m
         p/fJRZyoYhNnR6bls9ZgDSZRldKSaubx2DI/vMAqvUru7JmUlWNtb9xloQgs4Hu2S8k7
         NwolyZZy/huSgZtTvi4wEFPjfhFKUUxEZblxryq15gqSgtbNxsixYv4cbRsZy10Sblle
         Epbh4eJ6KXpDftViMGnhQ5h/KhTJCkEhZ49/iy1o0uNHWBZ6XRVfivAvMFUQmwUojQIW
         ehgU3PtfW+GFvCqJ8+30gxX1OaUI9Z97kusn/vQiP/CwQH2AjlBTWTMV0PEDEDyT++sb
         OwAA==
X-Gm-Message-State: AOJu0Yx+vJs9L6S2HzGvocgUrKs86XCIlatcqvygKazraMSNX/9myvr2
        5LCGtOyNvhEWLKcjM24JGVHBcDZp0+Tt2VNqQIlQgA==
X-Google-Smtp-Source: AGHT+IFiz9jLtqqyu/bUfWMmxSrAm5G7bYi6ikGRjXOf59sT/YSLJOCOxtl+UgwPUHqNHm1pzNWBgFg+uSCJnwzcVVA=
X-Received: by 2002:a81:6c13:0:b0:576:93f1:d118 with SMTP id
 h19-20020a816c13000000b0057693f1d118mr895084ywc.2.1696370100826; Tue, 03 Oct
 2023 14:55:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230923-ixp4xx-eth-mtu-v1-1-9e88b908e1b2@linaro.org> <169632602529.26043.5537275057934582250.git-patchwork-notify@kernel.org>
In-Reply-To: <169632602529.26043.5537275057934582250.git-patchwork-notify@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 3 Oct 2023 23:54:49 +0200
Message-ID: <CACRpkdacagNg8EA54_9euW8M4WHivLb01C7yEubAreNan06sGA@mail.gmail.com>
Subject: Re: [PATCH net-next] net: ixp4xx_eth: Specify min/max MTU
To:     patchwork-bot+netdevbpf@kernel.org
Cc:     khalasa@piap.pl, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 3, 2023 at 11:40=E2=80=AFAM <patchwork-bot+netdevbpf@kernel.org=
> wrote:

> This patch was applied to netdev/net-next.git (main)
> by Paolo Abeni <pabeni@redhat.com>:

Sorry Paolo, this is the latest version of this patch, which sadly changed
Subject in the process:
https://lore.kernel.org/netdev/20230928-ixp4xx-eth-mtu-v3-1-cb18eaa0edb9@li=
naro.org/

If it causes trouble for you to replace the patch I can rebase
this work on top of your branch, just tell me.

Yours,
Linus Walleij
