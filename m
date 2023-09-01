Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3403878FC9C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 13:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344866AbjIALsC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 1 Sep 2023 07:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345137AbjIALsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 07:48:01 -0400
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22C36170A
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 04:47:44 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-58fc4eaa04fso20829317b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Sep 2023 04:47:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693568863; x=1694173663;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KlILCXxelUgpayFeYE8jsNyi3YxHuXk4RJqViDf9D+s=;
        b=FkErsmcUmGWzjc1JCgoodMofA825lUs2xOzpfzLNBZx4UkDwsXSfMlNjPqKlN/Y6IB
         aK5PHxxsQfsecIkQo99mFE7fkKePyznRAehyQYAVOXqLCVLqJ7J8cgHveUvvireErPrN
         klnJpcbevYLYtPfrc3OyBHRa2gpGi6V9CmLGV67TaUQZItlAPRfoeTRVlLjpu0fDBEcw
         SdC9NoSrmwgCSORHQM/7SLJHFNwCvN45bWin2GvMJ9iEVQ8geCtq5z3hAw63oUYdprFN
         fiZySd9ygPFf2y8eUj49lX4EoYMIsM6fbEjeex3+UYm2tBojJYA7rkI77m8R0WklOebd
         HLMQ==
X-Gm-Message-State: AOJu0YwIb+6+dHG2wt3LH5WP4zZ2OiNlnsIh/0xAmSKkbEtFyt5+kGh9
        h7MNk0fZlse38CnrzqnvZgQcRiyvoXyFOg==
X-Google-Smtp-Source: AGHT+IETj7hA2o+4MA1gxXRPjJT+WB4d7Ajc9wdRCcQxgdWGo35FhdgWKnyROrEhMsPebK2Ryvitpg==
X-Received: by 2002:a81:6241:0:b0:589:f2dd:44a0 with SMTP id w62-20020a816241000000b00589f2dd44a0mr2553853ywb.33.1693568863189;
        Fri, 01 Sep 2023 04:47:43 -0700 (PDT)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com. [209.85.128.175])
        by smtp.gmail.com with ESMTPSA id z19-20020a81a253000000b0054f50f71834sm992278ywg.124.2023.09.01.04.47.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Sep 2023 04:47:42 -0700 (PDT)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-58fc4eaa04fso20829047b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Sep 2023 04:47:42 -0700 (PDT)
X-Received: by 2002:a25:e0c3:0:b0:cec:81af:cf92 with SMTP id
 x186-20020a25e0c3000000b00cec81afcf92mr2613450ybg.36.1693568862448; Fri, 01
 Sep 2023 04:47:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230901110320.312674-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20230901110320.312674-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 1 Sep 2023 13:47:31 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUYQPRMBg05HDDQq5kZvbv2Tx_kjeri5GMANRXoxTJF=Q@mail.gmail.com>
Message-ID: <CAMuHMdUYQPRMBg05HDDQq5kZvbv2Tx_kjeri5GMANRXoxTJF=Q@mail.gmail.com>
Subject: Re: [PATCH] riscv: Kconfig.errata: Add dependency for RISCV_SBI in
 ERRATA_ANDES config
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor.dooley@microchip.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 1, 2023 at 1:03 PM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Andes errata uses sbi_ecalll() which is only available if RISCV_SBI is
> enabled. So add an dependency for RISCV_SBI in ERRATA_ANDES config to
> avoid any build failures.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202308311610.ec6bm2G8-lkp@intel.com/
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
