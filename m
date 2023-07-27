Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1949765518
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 15:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232021AbjG0NdA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 27 Jul 2023 09:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233733AbjG0Nc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 09:32:56 -0400
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FB6D2728;
        Thu, 27 Jul 2023 06:32:56 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-584243f84eeso10363367b3.0;
        Thu, 27 Jul 2023 06:32:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690464775; x=1691069575;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lf/pqyRZV/biJkojfSpBvd3tXkvLp57H+KrNoCOq1+0=;
        b=U2ySh94u11AkLGv020q7OfvwAzGv6guUWJn8JqSfmb8jKOufDTu7bcS4zAX7ujlHzC
         oj2Rozs6d/AJ1Nigw5uTqIgpk/MrK2efxbliA3wj+FHZUqaPn0CqO5ySSbLyJtPK2rti
         t4HO3cL3QY1NN1mmZmVr5vAG9LlNv/wsLsDsKItNwGNdTTNHIOfX2i6FJ3iw7xr905uF
         +IlOVsboiBi+5Q3shf5EsJIQcv293fer2ASjzNnrm0RJCEOcB3pCvLfnmfhxIOfrXi5W
         DdNm/eXIUU9Fr/15zQfD2D1gouXyT1KNDA1mJHhKNbaloEgFdd7yizUN7BFv8qn6w2YO
         FEWA==
X-Gm-Message-State: ABy/qLbXYDUSQDYhBKiaZc4AYhnA150GIe8J3RTcAUawkOMJD4Rv+tG1
        j/w4pTND7eAIyAqaHDtgpaHfTyAjjMMSHA==
X-Google-Smtp-Source: APBJJlHC7JRu6htUD7n6d+84F79WBlqMNT4cwa5pmw0NDqWY6PO1uygMYG60FCYwsSH6UAfWWNpYcg==
X-Received: by 2002:a0d:cc43:0:b0:56c:f68f:d824 with SMTP id o64-20020a0dcc43000000b0056cf68fd824mr4942191ywd.45.1690464775040;
        Thu, 27 Jul 2023 06:32:55 -0700 (PDT)
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com. [209.85.219.180])
        by smtp.gmail.com with ESMTPSA id o64-20020a815a43000000b00559fb950d9fsm407035ywb.45.2023.07.27.06.32.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jul 2023 06:32:54 -0700 (PDT)
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-d16889b3e93so857939276.0;
        Thu, 27 Jul 2023 06:32:54 -0700 (PDT)
X-Received: by 2002:a25:c5:0:b0:d06:f0ab:e17b with SMTP id 188-20020a2500c5000000b00d06f0abe17bmr4639603yba.55.1690464773775;
 Thu, 27 Jul 2023 06:32:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230719192835.1025406-1-arnd@kernel.org>
In-Reply-To: <20230719192835.1025406-1-arnd@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 27 Jul 2023 15:32:42 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXzUvapDXKET6ZRmn33aH-EdQJ4E6Lk2AEXk_fwmtzFGQ@mail.gmail.com>
Message-ID: <CAMuHMdXzUvapDXKET6ZRmn33aH-EdQJ4E6Lk2AEXk_fwmtzFGQ@mail.gmail.com>
Subject: Re: [PATCH] [v2] rtc: bq4802: add sparc dependency
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "David S . Miller" <davem@davemloft.net>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 19, 2023 at 9:28 PM Arnd Bergmann <arnd@kernel.org> wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> The added HAS_IOPORT dependency might not actually be necessary as Geert
> points out, but the driver is also only used on one architecture. Sparc
> is also a special case here since it converts port numbers into virtual
> addresses rather than having them mapped into a particular part of the
> __iomem address space, so the difference is actually not important here.
>
> Add a dependency on sparc, but allow compile-testing otherwise, to
> make this clearer without anyone having to spend much time modernizing
> the driver beyond that.
>
> Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: David S. Miller <davem@davemloft.net>
> Link: https://lore.kernel.org/all/CAMuHMdWEx0F=fNei4Bz_JPkuvoaN-+zk08h0i8KnSi_VjO615g@mail.gmail.com/
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> v2: split dependency into two lines, as suggested by Geert

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
