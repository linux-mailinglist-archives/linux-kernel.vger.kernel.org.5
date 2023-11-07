Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F2377E3448
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 04:44:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233289AbjKGDo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 22:44:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbjKGDo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 22:44:27 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 018A1D47
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 19:44:25 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-40837124e1cso44655e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 19:44:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699328663; x=1699933463; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DP2Iv5ELrzaYeydQncBJF2e6SJXKbOLGVt01FUaqFHY=;
        b=3RncPv0g4GdWmSVAMYDsqIzqJLVvRQoE4iLNFxT2GUei3hqS3nkg9o0U3HbqANEMWE
         32UEnpgTGCWxPVnzXbAkurpp8NofeuB/UMLr/bNMV1EOQVlsRcll6qM5AWgggvoafWYX
         PrRn4DOoCgnvL4qifeubONep3IzXSZEE3/hlKTVXaqgHhKaNMhx4ei5fdf3oLiF4Kg6L
         o7tRiJOipNQ7xVLEVw/gnLgZ68y/N6WAvi0AKxAhRaQOjrj/uLHkfqCzKwezvf3fGDmm
         CYtfdAAY3s60z/NMyvGVfIC0Tcw0eaUh+KNRfnFde0ChXYYevfGwEExoM0vFEA6NBNrb
         D4qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699328663; x=1699933463;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DP2Iv5ELrzaYeydQncBJF2e6SJXKbOLGVt01FUaqFHY=;
        b=LBI5Xs11pjvvPnK+oCi2btZNoz5Vpj3lY6jIoj6SyWa6ylWUDaQJOJjeCyl/+BGGbJ
         p37w/XOfAzZMfX9mGMoj7SyeSVLouS0XA9XmZm0TOWYr0WyLiai4Bk8VOhDrd0DfLFr8
         oJDTt8Y3vaqXVVe9e/JOxopqPfFfrRR6pcQt+AfXWw0qFOGLFwpz5Kr9pv2adIJ4OB0e
         n5lX9wyq4viQpja7MKMkglLrl/9bYUxYX9Zd2hEVrohegsSXllz6+ASSoyoJOw87XTqY
         3WooBw6o4l7tUx2cu4nCxUKrPt1CgoFPpIsR8ToJPQQDaOw92hy06ZW1k4FbLtT1yR8i
         iBfQ==
X-Gm-Message-State: AOJu0YyKmMuSwXqEOIb7HamUN6b9x9wK8VVADqP3qmfKAOmTyU7qXHoB
        8J3Kb6ir5e3/wU0MJUoBXpuu24JXJn/8GjVh+XIIWA==
X-Google-Smtp-Source: AGHT+IGr1YusOCrM9bnppsDzO/xFTrsGhIsHdn6pdF3Q6lPJRBaX4KJY4IqfIL0/XIRV040XF8zD5jzk0UPeSFTaFPU=
X-Received: by 2002:a05:600c:1ca7:b0:404:74f8:f47c with SMTP id
 k39-20020a05600c1ca700b0040474f8f47cmr3856wms.5.1699328663197; Mon, 06 Nov
 2023 19:44:23 -0800 (PST)
MIME-Version: 1.0
References: <20231106-tcp-ao-fix-label-in-compound-statement-warning-v3-1-b54a64602a85@kernel.org>
In-Reply-To: <20231106-tcp-ao-fix-label-in-compound-statement-warning-v3-1-b54a64602a85@kernel.org>
From:   Eric Dumazet <edumazet@google.com>
Date:   Tue, 7 Nov 2023 04:44:12 +0100
Message-ID: <CANn89iKzVACROr7gzR2H3HPEQfVjctiXyiUswc-zyvN-06p3=Q@mail.gmail.com>
Subject: Re: [PATCH net v3] tcp: Fix -Wc23-extensions in tcp_options_write()
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org,
        pabeni@redhat.com, ndesaulniers@google.com, trix@redhat.com,
        0x7f454c46@gmail.com, noureddine@arista.com, hch@infradead.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 6, 2023 at 10:14=E2=80=AFPM Nathan Chancellor <nathan@kernel.or=
g> wrote:
>
> Clang warns (or errors with CONFIG_WERROR=3Dy) when CONFIG_TCP_AO is set:
>
>   net/ipv4/tcp_output.c:663:2: error: label at end of compound statement =
is a C23 extension [-Werror,-Wc23-extensions]
>     663 |         }
>         |         ^
>   1 error generated.
>
> On earlier releases (such as clang-11, the current minimum supported
> version for building the kernel) that do not support C23, this was a
> hard error unconditionally:
>
>
> Closes: https://github.com/ClangBuiltLinux/linux/issues/1953
> Fixes: 1e03d32bea8e ("net/tcp: Add TCP-AO sign to outgoing packets")
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
> Changes in v3:
> - Don't use a pointer to a pointer for ptr parameter to avoid the extra
>   indirection in process_tcp_ao_options(), just return the modified ptr
>   value back to the caller (Eric)

SGTM thanks.
Reviewed-by: Eric Dumazet <edumazet@google.com>
