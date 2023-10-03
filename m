Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C62F7B68E8
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 14:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232353AbjJCMY6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 3 Oct 2023 08:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbjJCMY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 08:24:57 -0400
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1877A6;
        Tue,  3 Oct 2023 05:24:54 -0700 (PDT)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-59c268676a9so10591817b3.0;
        Tue, 03 Oct 2023 05:24:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696335893; x=1696940693;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FM7F2ErDCT18gWR6Yw2KxppndzFMwSzkF3KAWh0GJec=;
        b=Lo+etlKTkS9tjGgySqyr8cDdpXFLe2/CSA8Gr1xfHkf//7t9Yj7WvkYqhzJ3GBRgUB
         XSqY5N8y4IAP4TkUBW9Sto48qzPUgKu7QmeXtFzlyUcu+LNgPbTQZwfvPqvTPqO5NMuF
         GwphvsA5txVgC0Ag+iF6AZ54MHPanN5Y5XwNaK/capJf0g0MQO1tDS9fK38aAj654UyG
         d5cjLFFefTkESWVv87oKIPCXptvdF7EvEcOBfzmO//fPEF4Vhr29b+qn7LVibNchkNsQ
         5oJqivjuMaMawt9g1VMxjeyMUkPX7nbeDB5ayf2x4yk/m1fnq6+OeLh0AgFwVcd3ets5
         yixw==
X-Gm-Message-State: AOJu0YxNJ+Wix34WMFO5yh4zQuAZ9V68AvKY6CgcofV9PpGA3ljoOsC/
        LzZEWfHrR4gMmBm+KplCdAiEti8JHgb/DQ==
X-Google-Smtp-Source: AGHT+IEPjvDnWoVfpY8flp1oUsiBJ8fgb2P2bQ9+ZqH67xkxpOI0DGgjsefkYn/MBo3nVmnxkahcxA==
X-Received: by 2002:a81:5246:0:b0:592:97c3:18d2 with SMTP id g67-20020a815246000000b0059297c318d2mr13867273ywb.15.1696335893573;
        Tue, 03 Oct 2023 05:24:53 -0700 (PDT)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com. [209.85.128.169])
        by smtp.gmail.com with ESMTPSA id u81-20020a816054000000b005956b451fb8sm334717ywb.100.2023.10.03.05.24.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Oct 2023 05:24:52 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-59bc956b029so10355077b3.2;
        Tue, 03 Oct 2023 05:24:52 -0700 (PDT)
X-Received: by 2002:a81:a182:0:b0:59f:5013:b19d with SMTP id
 y124-20020a81a182000000b0059f5013b19dmr13601255ywg.17.1696335892593; Tue, 03
 Oct 2023 05:24:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230929000704.53217-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20230929000704.53217-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20230929000704.53217-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 3 Oct 2023 14:24:40 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXQK=7uaow7Yazusi8vtL+U_fwxBXjH6UFu53XhU31zCg@mail.gmail.com>
Message-ID: <CAMuHMdXQK=7uaow7Yazusi8vtL+U_fwxBXjH6UFu53XhU31zCg@mail.gmail.com>
Subject: Re: [PATCH 2/5] riscv: dts: renesas: r9a07g043f: Add dma-noncoherent property
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 29, 2023 at 2:07 AM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> RZ/Five is a noncoherent SoC so to indicate this add dma-noncoherent
> property to RZ/Five SoC DTSI.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v6.7.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
