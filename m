Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26A0A7F59B6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 09:00:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344931AbjKWIAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 03:00:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235296AbjKWIA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 03:00:29 -0500
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1283A1BD7
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 00:00:01 -0800 (PST)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-5ca11922cedso5932077b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 00:00:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700726400; x=1701331200; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RWxVY5t9reTe/CS5uerA+GekX77vgZBS1Nj/db3aCOI=;
        b=FPBIJnxowlESh6hWBzgJRK95k8A9J7LYT61Gk2U32hsz6XXyavC5MfSI1m+lVICiuK
         wA8+bXCimBsJ22E3fonJR2+eZMVz25z3Nt3PNr2BwTHpWDKHd2ua+k9QdF7WTqggJCUN
         ka55XCLXWAzjt8HJrf5+8cEjGYGzzBe/pdTpEtFAO/HMZL53gIo0isfMKjN1DtjB2rBv
         gVwUFgxzkhcLFRdsJFTWANfokpCXajgrHWsZPeyU6DGTSq39TmEWq7+J39IvtVD199/1
         EOxIxEaLiFA+tQLzBJoDpZukyWW0pZKJ3HAfNA0+SqPdHr5YihqQKFNf/t/4AoqlUQzf
         H4/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700726400; x=1701331200;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RWxVY5t9reTe/CS5uerA+GekX77vgZBS1Nj/db3aCOI=;
        b=KmhYS4nzw7wlOTgVkZAcYGUyEcZt9VcT5xUv7q1Ii86pAEX97E9rMkEFGzxOc/IPzl
         eCmfCrvahm5pSCkdm5nQguK6RtmUHD7BW0825TrBzgRrr84s4ELd1xguZpRqAp5Szmuc
         mk92Zbyow6XsR/ggNHkWoQH0r4rhlFkhiSpfrevvbLBXI2TicyVUVR9Vcn+9fRcJzz/a
         nD6FQTtU7jqFHLl5rXYNwsy6QkyXhsBz6gdRCXCfLso+0zA5LSs5ZG3ggpVls5VkmOjm
         qRQIeBD8XEVVLq3RlW9qbfi0P6Cpm1PgPae9cBiQxXE1FDE5rFfNYN0aqUIohLv0BDVb
         16pQ==
X-Gm-Message-State: AOJu0YwUdsA9ULo+B/sWYBQxjlwvbSaBj+urmt9tQbNask3NsJYweB5r
        IjpUg8TRsD3b9bZuaWjp5v5d0Jfy9tECoS3ydvOWBA==
X-Google-Smtp-Source: AGHT+IFjaVmV0oaVTLYZb2vrD02vpGZYF0qzOkEXq8DmvmhDyaUip8/1sn3g+u8WSqLNrFn52QUP60w94QzyITCZB/A=
X-Received: by 2002:a81:ae06:0:b0:5cc:61c7:b058 with SMTP id
 m6-20020a81ae06000000b005cc61c7b058mr4742376ywh.22.1700726400505; Thu, 23 Nov
 2023 00:00:00 -0800 (PST)
MIME-Version: 1.0
References: <20231122092855.4440-1-shijie@os.amperecomputing.com>
In-Reply-To: <20231122092855.4440-1-shijie@os.amperecomputing.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 23 Nov 2023 08:59:48 +0100
Message-ID: <CACRpkdZoiA3hQN2Pgz8g01T9TdapRwiQLWc1_MttSE-FWUy7bg@mail.gmail.com>
Subject: Re: [PATCH 0/4] arm64: an optimization for AmpereOne
To:     Huang Shijie <shijie@os.amperecomputing.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
        suzuki.poulose@arm.com, broonie@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        anshuman.khandual@arm.com, robh@kernel.org, oliver.upton@linux.dev,
        maz@kernel.org, patches@amperecomputing.com,
        Kohei Tarumizu <tarumizu.kohei@fujitsu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 10:29=E2=80=AFAM Huang Shijie
<shijie@os.amperecomputing.com> wrote:

> 0) Background:
>    We found that AmpereOne benefits from aggressive prefetches when
>    using 4K page size.
>
> 1) This patch:
>     1.1) adds new WORKAROUND_AMPERE_AC03_PREFETCH capability.
>     1.2) uses MIDR_AMPERE1 to filter the processor.
>     1.3) uses alternative_if to alternative the code
>          for AmpereOne.
>     1.4) adds software prefetches for the specific loop.
>          Also add a macro add_prefetch.
>
> 2) Test result:
>     In hugetlb or tmpfs, We can get big seqential read performance improv=
ement
>     up to 1.3x ~ 1.4x.

In June 2022 Fujitsu tried to add a similar feature for A64FX, here is
the essence
of my feedback from back then, it applies here as well:
https://lore.kernel.org/linux-arm-kernel/CACRpkdbPLFOoPdX4L6ABV8GKpC8cQGP3s=
2aN2AvRHEK49U9VMg@mail.gmail.com/#t

TL;DR: this is a hack, if you want to accelerate the memory hierarchy,
then work with the MM developers to figure out how to do that in a
structured and scientific way that will work with any prefetching hardware
on any CPU.

Yours,
Linus Walleij
