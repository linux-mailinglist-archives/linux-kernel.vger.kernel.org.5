Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDD7278FC98
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 13:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241960AbjIALrW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 1 Sep 2023 07:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234023AbjIALrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 07:47:21 -0400
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7362C10E5
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 04:46:52 -0700 (PDT)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-1c504386374so1204637fac.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Sep 2023 04:46:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693568770; x=1694173570;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mmi1BI358ffCGTUdtlT0m2XgZO6RaiWjgEoPAH8B6pQ=;
        b=P19xNaK1gLoCnWLWwaC9TdWNqbad1oEzKTpK7fO6wDdi9P+AWukxq8QdZIPMkVNI8e
         0MfqKJ34ieN419aoz9iKyeFbIc7k4xoknE8zj1XItUEkid1azcPtjd2JrqzW/CzVo+YP
         F6dvWPBJcZKNQujIcDhowR8qqZcOLYQP6Ea4A9erWPAL+AILPnsBXswJI5EsIU0cXy4G
         dCFP3eY7Fu8gHkPZ3M9cjv+hQaJNF9ETectbTnC0VHO4umigjK3nufcdc8Fbn3z/dLRd
         5qEZcw+X2PnDtgaBX6tdBPc0cjhzTh3SL37DvQbfZPGEXeoUDHDSWesCstUcoc710WkH
         lN7A==
X-Gm-Message-State: AOJu0YwuvDcpYfccxvonxdJ3Tsf9Aawc9qqDzUbkJp420RHZVA6Xq1vL
        qozn3JR/0Ttasq2UOwwJATncHKFNUIECyQ==
X-Google-Smtp-Source: AGHT+IG3pF/LrKw+q2D5tCKjgHm0coTmPDoLdeffO2x/r6Ru/eTjy2bI9fHEEF3+uq+QmhJjpWfQdQ==
X-Received: by 2002:a05:6870:6387:b0:1bb:b172:4bd5 with SMTP id t7-20020a056870638700b001bbb1724bd5mr2600746oap.18.1693568769850;
        Fri, 01 Sep 2023 04:46:09 -0700 (PDT)
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com. [209.85.161.51])
        by smtp.gmail.com with ESMTPSA id l17-20020a05683016d100b006b46b913767sm1705722otr.24.2023.09.01.04.46.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Sep 2023 04:46:09 -0700 (PDT)
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-570e005c480so1142951eaf.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Sep 2023 04:46:09 -0700 (PDT)
X-Received: by 2002:a05:6358:9489:b0:134:e458:688d with SMTP id
 i9-20020a056358948900b00134e458688dmr1872438rwb.15.1693568768936; Fri, 01 Sep
 2023 04:46:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230901105858.311745-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20230901105858.311745-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 1 Sep 2023 13:45:57 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXXRSphh82KaY=xHTpHLuQXz0aKL2qhL0LXsNW9A42hSQ@mail.gmail.com>
Message-ID: <CAMuHMdXXRSphh82KaY=xHTpHLuQXz0aKL2qhL0LXsNW9A42hSQ@mail.gmail.com>
Subject: Re: [PATCH] riscv: Kconfig.errata: Drop dependency for MMU in
 ERRATA_ANDES_CMO config
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor.dooley@microchip.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 1, 2023 at 12:59 PM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Now that RISCV_DMA_NONCOHERENT conditionally selects DMA_DIRECT_REMAP
> ie only if MMU is enabled, we no longer need the MMU dependency in
> ERRATA_ANDES_CMO config.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
