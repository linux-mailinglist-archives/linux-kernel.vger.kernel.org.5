Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30A2E7F4CD2
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 17:38:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231701AbjKVQim convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 22 Nov 2023 11:38:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343915AbjKVQiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 11:38:13 -0500
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5DF51FD7;
        Wed, 22 Nov 2023 08:36:41 -0800 (PST)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-5c85e8fdd2dso55845627b3.2;
        Wed, 22 Nov 2023 08:36:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700671000; x=1701275800;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YnNltyNH2Qapz/Qt/SgTE3LNVbUWrueMgIGKLwuGujM=;
        b=dabEhPsZ8hWe1ZhM4I3aw1Fz1FsO/cXksOA4ScePBdyYVn/+uAGAJcXAwphghZfso+
         ekcW3D9ll/LqPd1q8XZgsEXw2tEr0CLGBn9UweZ9IKj5K5D/g3uQR/8alb2d7u5tuDxv
         9fjMsRzCnXaN8uLFEmKySEisRkyxk5sBg2PfpQxnAQx0sSBjhrkkgm2bqMvKZCGc3Ppd
         WtD/IEThn48Iwc07rcsazbwsCkIuKAJwwzf6x2KPa6iIjrdMviDTexbFxkE9PV5RUdPx
         T/q7NpKC4QaFcKhTwhJDdphWt4Aqxo6Aot/TKTmdVFrHQoNuvxlI+FTyzbCDwOBEi9rm
         k1QQ==
X-Gm-Message-State: AOJu0YzrTjUJMUjQwJjGKq+SEhJlPKNgQkhcGMjpeHa/uQL0HAWvQtMZ
        8+6H3i0axRzOgmA6nh58wJQaJrKI4vnjfA==
X-Google-Smtp-Source: AGHT+IEtwFQIyER05QBhtqE64v8Xa6vCpxfd4cINyz0QT9Cg8FRMPIaPUjrd36xFGOl3qYaqXRgqTg==
X-Received: by 2002:a0d:f4c4:0:b0:5a8:e6f4:4b6c with SMTP id d187-20020a0df4c4000000b005a8e6f44b6cmr2848601ywf.25.1700671000549;
        Wed, 22 Nov 2023 08:36:40 -0800 (PST)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com. [209.85.128.173])
        by smtp.gmail.com with ESMTPSA id i6-20020a816d06000000b005ccd9a64bcfsm179841ywc.1.2023.11.22.08.36.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Nov 2023 08:36:38 -0800 (PST)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-5c85e8fdd2dso55845127b3.2;
        Wed, 22 Nov 2023 08:36:38 -0800 (PST)
X-Received: by 2002:a0d:d78f:0:b0:5a8:22b5:399c with SMTP id
 z137-20020a0dd78f000000b005a822b5399cmr3089413ywd.24.1700670998325; Wed, 22
 Nov 2023 08:36:38 -0800 (PST)
MIME-Version: 1.0
References: <20231122121235.827122-1-peterlin@andestech.com> <20231122121235.827122-6-peterlin@andestech.com>
In-Reply-To: <20231122121235.827122-6-peterlin@andestech.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 22 Nov 2023 17:36:24 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVL9_VQ7e7-Cr7vcFWqpCTeptczZmgWN4seENcJKTi0eQ@mail.gmail.com>
Message-ID: <CAMuHMdVL9_VQ7e7-Cr7vcFWqpCTeptczZmgWN4seENcJKTi0eQ@mail.gmail.com>
Subject: Re: [PATCH v4 05/13] riscv: dts: renesas: r9a07g043f: Update
 compatible string to use Andes INTC
To:     Yu Chien Peter Lin <peterlin@andestech.com>
Cc:     acme@kernel.org, adrian.hunter@intel.com, ajones@ventanamicro.com,
        alexander.shishkin@linux.intel.com, andre.przywara@arm.com,
        anup@brainfault.org, aou@eecs.berkeley.edu, atishp@atishpatra.org,
        conor+dt@kernel.org, conor.dooley@microchip.com, conor@kernel.org,
        devicetree@vger.kernel.org, dminus@andestech.com,
        evan@rivosinc.com, guoren@kernel.org, heiko@sntech.de,
        irogers@google.com, jernej.skrabec@gmail.com, jolsa@kernel.org,
        jszhang@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-sunxi@lists.linux.dev, locus84@andestech.com,
        magnus.damm@gmail.com, mark.rutland@arm.com, mingo@redhat.com,
        n.shubin@yadro.com, namhyung@kernel.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, peterz@infradead.org,
        prabhakar.mahadev-lad.rj@bp.renesas.com, rdunlap@infradead.org,
        robh+dt@kernel.org, samuel@sholland.org, sunilvl@ventanamicro.com,
        tglx@linutronix.de, tim609@andestech.com, uwu@icenowy.me,
        wens@csie.org, will@kernel.org, ycliang@andestech.com,
        inochiama@outlook.com
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

On Wed, Nov 22, 2023 at 1:16 PM Yu Chien Peter Lin
<peterlin@andestech.com> wrote:
> The Andes hart-level interrupt controller (Andes INTC) allows AX45MP
> cores to handle custom local interrupts, such as the performance
> counter overflow interrupt.
>
> Signed-off-by: Yu Chien Peter Lin <peterlin@andestech.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
