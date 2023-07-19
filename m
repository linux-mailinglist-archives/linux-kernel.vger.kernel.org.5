Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0587A758CA0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 06:31:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbjGSEbF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 00:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjGSEbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 00:31:03 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A4AB1B9
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 21:31:02 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-401d1d967beso559911cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 21:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689741061; x=1692333061;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+/BlqLIDfeuKqQi7Zyq/vs2odCOmYtAyzi0u6RkYKfs=;
        b=dI68NxHHDPUyAywUbAXEmQM3Upc11gKLIkXntAl/lJHTY5ai+xy0GTHHGZqpc4nS8F
         rqvFYfj8IvVcnidgCYdBV92k8CrS64TsVoT8ZpddkRjVTp7AOAj6Uxd2q/8hRtWS0U5B
         fsPdzm6dGKcliW6tql984pOxXVq6luozGGaZNvwHo7kKhxEr0UuLW40USscS2EyuOE5w
         3Qr7YoRiPhnMh71Etwwi6RiS+cnQdWJgpfJzYwoXZkMfNXCbpbpUqTADg2GlUP+Z/q95
         R2GK3Eyx9nmKyOozKjXy6sBnZn9iLc1Opq9gdmzCqcP6OIuFSsYrKx2VpxYVTHtH0j9X
         ZMHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689741061; x=1692333061;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+/BlqLIDfeuKqQi7Zyq/vs2odCOmYtAyzi0u6RkYKfs=;
        b=NgCDiYqDiC1hV95GE4mRC52K2RvTZ0xrFVHKbVpu5/DoWr+TbJcvLLcP8UKs3LNMmd
         EyGBDERRiBK9q4BUl3nb6QXffqd67xV2h2NWIO84Fmbd5lRGZeubolsfSn6jrj9hJC+B
         Uw8hI2XNCkPqEQ5uGuKzWDd8m5E/XuMa0abC1TRAEoCJbfx8wQXMNkJUB2BRD/SSF9Q9
         Fa31NQTgkFzSys9Lh7kLHZOFISxwyjNKUrcjs8PPXm3ddYHDyowPq3ZpSu1KSbCSaovd
         Ei79JIRW+K6DVKHsXWLj1HmsV7LWMIG2JIh1Wt0ZUvO+P/MQS5oDGhCgGIHmWIwYm8ew
         Cg5w==
X-Gm-Message-State: ABy/qLYQYNlI7br3vgyEUv/isHdg0ZnhqBlfTaEn0tMAcuXe2vsl3QIh
        ug1TL3dfLlzULC1UDR28gynuxEbsDRcEuv6h/vW9rA==
X-Google-Smtp-Source: APBJJlGxHaQ7tsAAQLo5ly6nXmWgE4aWDs22NZHEvIHKyguQyYRgXJZGnKvgaVSSQYy2YpLZnuug+R9ZTYCGkPEfiwQ=
X-Received: by 2002:ac8:5905:0:b0:3f9:6930:1308 with SMTP id
 5-20020ac85905000000b003f969301308mr332660qty.13.1689741061559; Tue, 18 Jul
 2023 21:31:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230717143443.163732-1-carlos.bilbao@amd.com>
 <20230717192403.96187-1-kuniyu@amazon.com> <c196f8f9-3d2c-27c6-6807-75a6e6e4d5a5@amd.com>
 <20230718195414.4c6f359f@kernel.org>
In-Reply-To: <20230718195414.4c6f359f@kernel.org>
From:   Eric Dumazet <edumazet@google.com>
Date:   Wed, 19 Jul 2023 06:30:50 +0200
Message-ID: <CANn89i+wMUGHoMzeK9ZttJUeZj-acK4M6__tYL1_o4nEdPY5=g@mail.gmail.com>
Subject: Re: [PATCH] tg3: fix array subscript out of bounds compilation error
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Carlos Bilbao <carlos.bilbao@amd.com>,
        Kuniyuki Iwashima <kuniyu@amazon.com>, davem@davemloft.net,
        linux-kernel@vger.kernel.org, mchan@broadcom.com,
        netdev@vger.kernel.org, pabeni@redhat.com, prashant@broadcom.com,
        siva.kallam@broadcom.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 19, 2023 at 4:54=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue, 18 Jul 2023 10:52:39 -0500 Carlos Bilbao wrote:
> > >> Fix encountered compilation error in tg3.c where an array subscript =
was
> > >
> > > What is the error ?
> >
> > drivers/net/ethernet/broadcom/tg3.c: In function =E2=80=98tg3_init_one=
=E2=80=99:
>
> What compiler are you using? Any extra flags?
>
> I remember seeing this warning too, but I can't repro it now (gcc 13.1;
> clang 16).

Same here, I think I was seeing this 4 or 5 years ago.
I ignored the warning at that time because we were using an old compiler.

>
> > >> above the array bounds of 'struct tg3_napi[5]'. Add an additional ch=
eck in
> > >> the for loop to ensure that it does not exceed the bounds of
> > >> 'struct tg3_napi' (defined by TG3_IRQ_MAX_VECS).
> > >>
> > >> Reviewed-By: Carlos Bilbao <carlos.bilbao@amd.com>
>
> We need a sign-off tag
> --
> pw-bot: cr
