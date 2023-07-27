Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 062E3764900
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 09:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231744AbjG0Hks convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 27 Jul 2023 03:40:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232550AbjG0HkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 03:40:24 -0400
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67581B4;
        Thu, 27 Jul 2023 00:33:41 -0700 (PDT)
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6b9b52724ccso565854a34.1;
        Thu, 27 Jul 2023 00:33:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690443220; x=1691048020;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HMg5UvkC3t621T16FyA+RQwu73DIw5SgUYvp8HwLnhk=;
        b=c187fBrojk06vByPjo6ALi5r+gx8EahVfVJompnH1FpxaIYEFVJnFHPo7T8XykMGon
         Pz46un/ABX08T6rEDlJlkI18CcJSIzQ2xsP6r/UpmVG8jVTGRUG//j5Dz/rcz1uQmTAH
         cuYsllYxyvw81zw5BNp4IzjoRUDG9dYP3vpzHSichIelOSeACMvLPF+aa0LBO2dRg19a
         HPJrUis0XbGkaVh+o76lqglLNHitnqkkg72OCZGnWjeEDH5g2QygGEF/pcNu1h8LUh/Z
         wILsedXTEhHfG2xClMfsKepwzmdiU6/yceubkTviJCBmMmiE+oe9g+BS3julqmcvBY0u
         Bmyg==
X-Gm-Message-State: ABy/qLZ/nE/F3GHhGWhfAFjpFcQgaWJjjQHHFvVAPuFZdfHpaf1EbIJc
        zo1LpBy7sVJcfQGxMYU7XssFfAV/NUNdPA==
X-Google-Smtp-Source: APBJJlGG+basVdIBieAJLLCE3d8MYdrWkKwcsI6nd/A3E+D0CFcCwbRakujhm9RIbM6WNzVzDlAzkQ==
X-Received: by 2002:a05:6870:e394:b0:1bb:a30a:299b with SMTP id x20-20020a056870e39400b001bba30a299bmr2349836oad.48.1690443220461;
        Thu, 27 Jul 2023 00:33:40 -0700 (PDT)
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com. [209.85.161.53])
        by smtp.gmail.com with ESMTPSA id h7-20020a056870d34700b001bbb4f34a7bsm442431oag.49.2023.07.27.00.33.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jul 2023 00:33:38 -0700 (PDT)
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-56c4457c82eso502776eaf.0;
        Thu, 27 Jul 2023 00:33:37 -0700 (PDT)
X-Received: by 2002:a05:6808:1a10:b0:3a1:c841:f026 with SMTP id
 bk16-20020a0568081a1000b003a1c841f026mr2761680oib.27.1690443217548; Thu, 27
 Jul 2023 00:33:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230727101128.2752153-1-ruanjinjie@huawei.com>
In-Reply-To: <20230727101128.2752153-1-ruanjinjie@huawei.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 27 Jul 2023 09:33:26 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXhBx5e=EH731NxcKWajFniDHtCATpjZzM-UvOrKfJwQg@mail.gmail.com>
Message-ID: <CAMuHMdXhBx5e=EH731NxcKWajFniDHtCATpjZzM-UvOrKfJwQg@mail.gmail.com>
Subject: Re: [PATCH -next] media: rcar_jpu: Remove redundant dev_err()
To:     Ruan Jinjie <ruanjinjie@huawei.com>
Cc:     mikhail.ulyanov@cogentembedded.com, mchehab@kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2023 at 4:37 AM Ruan Jinjie <ruanjinjie@huawei.com> wrote:
> There is no need to call the dev_err() function directly to print a custom
> message when handling an error from platform_get_irq() function as
> it is going to display an appropriate error message in case of a failure.
>
> Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
