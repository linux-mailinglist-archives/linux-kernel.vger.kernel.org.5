Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 953B37DC7DD
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 09:07:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbjJaIHg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 31 Oct 2023 04:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjJaIHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 04:07:35 -0400
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A5D4B7
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 01:07:33 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-5af5b532d8fso46763777b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 01:07:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698739652; x=1699344452;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8dW9T/oJs2BJS5b3p+JbS+2l957dizjV3YoatArAOMI=;
        b=sOdXUrYYCMXjeCk0kxZ3ryYTvsv7lODtrLQ/SmZxHwkJ4q6iK/2uTCE5vUhBMyPNt6
         rVV6pGZZf9gYcyl2Zo0JJVrP/ygeXAjYrv9W5ApJ6JsEl2LztSquKTDMItAkfU/ZAGqS
         WI7OQa6L3Zb62mlvZ6AfYAapBZRSa4cGHc6fNnAfMUkI/CXv4A2bvG/m/+Xdo56azw+p
         L3vFPCkSU1gF8MLbfK3ica2TcjtyQTwxVnP+Mtfxkv3pQdLieF1MppAX5Y5D5JFtgNE7
         /D60x0jo3T6tgsys8oEfv59wLP15G0c7utFYt9K/KTr+dMm2sqTqC7tY195EqM1h57uT
         +1hw==
X-Gm-Message-State: AOJu0YwvGT6JJuwkstO4bou99hkP3VJg2iVnMCbfduvECxBmTXTyc6AW
        IRfZMfL2dKAt9okIIZtkLm4PNyqMFLazvg==
X-Google-Smtp-Source: AGHT+IEpY9UaGPG4z0YqHy8gG4vQZHzZaZ8TjSENwgt1mZQ1rnS5xjSiXqIQ2GmH7e3LXNG94R2lCg==
X-Received: by 2002:a81:af03:0:b0:5af:196c:dfcc with SMTP id n3-20020a81af03000000b005af196cdfccmr12609992ywh.8.1698739652397;
        Tue, 31 Oct 2023 01:07:32 -0700 (PDT)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com. [209.85.128.178])
        by smtp.gmail.com with ESMTPSA id j186-20020a8192c3000000b0059bdac3fd08sm498893ywg.48.2023.10.31.01.07.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Oct 2023 01:07:32 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-5ac376d311aso52388937b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 01:07:32 -0700 (PDT)
X-Received: by 2002:a81:e608:0:b0:5a7:bc66:949f with SMTP id
 u8-20020a81e608000000b005a7bc66949fmr11098090ywl.26.1698739651833; Tue, 31
 Oct 2023 01:07:31 -0700 (PDT)
MIME-Version: 1.0
References: <ZT-46QZiN8b37Swy@infradead.org>
In-Reply-To: <ZT-46QZiN8b37Swy@infradead.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 31 Oct 2023 09:07:18 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXQrJcFh1rfd0HAOEb-KYKQVBBJ8RWpvU_W6kxc3EQi2g@mail.gmail.com>
Message-ID: <CAMuHMdXQrJcFh1rfd0HAOEb-KYKQVBBJ8RWpvU_W6kxc3EQi2g@mail.gmail.com>
Subject: Re: [GIT PULL] dma-mapping updates for Linux 6.7
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

On Mon, Oct 30, 2023 at 3:08 PM Christoph Hellwig <hch@infradead.org> wrote:
> the Kconfig dependencies added in this branch caught configuration issues
> in a riscv platform.  The fixes for that went into th soc tree, so it
> if you want to avoid them it might make sense to pull this branch after
> the soc tree.

FTR, these fixes were merged in v6.6.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
