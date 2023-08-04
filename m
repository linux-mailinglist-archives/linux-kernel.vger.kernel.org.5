Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A750770289
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 16:06:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231562AbjHDOGo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 10:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjHDOGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 10:06:42 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ABD6B9
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 07:06:41 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-52229f084beso2830239a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 07:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691157999; x=1691762799;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PHi5nckc6oIs97S9jAu59ejHeSZNcUAh0B99fcmw+3M=;
        b=FOANhKv31NOTyDYcJGf/w3u8a0B9MkJic1WI+ujUjzFnPqLHzNqwjAVE111ibP3Ywc
         I+2wSO7/ASHKmenKEy+WLdJdA57f2YMsqtKH8U6U7Uq9RJZXLXMcs+YSWht5rlUybMqa
         kJ+Sa+HAnrvQ1pp74NPLZYxS7poDyMjSwghoI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691157999; x=1691762799;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PHi5nckc6oIs97S9jAu59ejHeSZNcUAh0B99fcmw+3M=;
        b=FY9CwXmfccgkEpUyBE2rP2pgsCT30CpDV7NNoDoFrAySvJWu5QrNEQxybnn8jx1nwA
         ch3YEMyQYdkHNk1J+pmWtAdaXPGuga2CAaiKhICnkqFdQqQ1CPixFkpBACqScaPJWQBj
         HrKmCY7KfkcvtgzwUzizWDDxRDocKMWCi/5jhBRgBaFpF74q+ovb8er5ZN9AspmVMHN+
         GI2wYyFdtsXSK5DMAfhyEduh2wuRqrIr1FjIonqlP0JCBYISacMSjIRskGXyzaCkYNXJ
         Ch8agV2PNQzAj5fooSK0fGabfNQGeGs0T+IKT8E/oZQW8c/PhbuOQUrUPcXqJn0yjxy/
         wdyw==
X-Gm-Message-State: AOJu0Yz4flIyeJeCkIJFEnzpRS8dOoZPC2uipsr+PHIamkJxFSD4RJYQ
        wVYJeT6SPyrb6aJ0q78uEFixbwS2K3JaoIY0eJyuiuFa
X-Google-Smtp-Source: AGHT+IEuEgxELYGGQlKXPAEKhWVcd6YfMb+tvr4m3MLJ8A1tWti0ZgZacC2zrj/LDNTacg/VmVGkIA==
X-Received: by 2002:a17:906:32d6:b0:99b:ead0:2733 with SMTP id k22-20020a17090632d600b0099bead02733mr1714379ejk.72.1691157999263;
        Fri, 04 Aug 2023 07:06:39 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id fy2-20020a170906b7c200b00992eabc0ad8sm1344701ejb.42.2023.08.04.07.06.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Aug 2023 07:06:38 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5223910acf2so12295a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 07:06:38 -0700 (PDT)
X-Received: by 2002:a50:9ea4:0:b0:506:b280:4993 with SMTP id
 a33-20020a509ea4000000b00506b2804993mr81237edf.2.1691157998622; Fri, 04 Aug
 2023 07:06:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230804132800.2270896-1-arnd@kernel.org> <20230804132800.2270896-2-arnd@kernel.org>
In-Reply-To: <20230804132800.2270896-2-arnd@kernel.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 4 Aug 2023 07:06:26 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Wn20c3=TjNnqOvt2n61q8d3AaJHFGboGfog2rq7UYARg@mail.gmail.com>
Message-ID: <CAD=FV=Wn20c3=TjNnqOvt2n61q8d3AaJHFGboGfog2rq7UYARg@mail.gmail.com>
Subject: Re: [PATCH 2/2] watchdog/hardlockup: simplify Kconfig selection
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>, Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        David Gow <davidgow@google.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Aug 4, 2023 at 6:28=E2=80=AFAM Arnd Bergmann <arnd@kernel.org> wrot=
e:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> The use of the 'imply' keyword tends to be a bad idea, as it's at best
> confusing to the reader but often actually doesn't do what the author
> intended.
>
> In this case, it seems to be used correctly, but doing the same thing
> using 'default' statements as we have elsewhere in the kernel is simpler
> and would be easier to understand by readers that are unfamiliar with
> the special semantics of 'imply'.
>
> Fixes: 1356d0b966e7e ("watchdog/hardlockup: make the config checks more s=
traightforward")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> I got confused by the 'imply' here myself and thought this had caused
> a build failure that turned out to be unrelated, but it might help
> to apply this anyway to save the next person the confusion.
> ---
>  lib/Kconfig.debug | 14 ++++----------
>  1 file changed, 4 insertions(+), 10 deletions(-)

Seems reasonable to me.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
