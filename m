Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDE0E7F4C78
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 17:34:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbjKVQef convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 22 Nov 2023 11:34:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjKVQee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 11:34:34 -0500
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3621D101;
        Wed, 22 Nov 2023 08:34:31 -0800 (PST)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-5cc62cca0efso9551077b3.2;
        Wed, 22 Nov 2023 08:34:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700670870; x=1701275670;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ophsLbscDpT/fxf0eBhWE8ZK8OIp8kFL24DJaRjaQW8=;
        b=XlNhJpVG0IUme74oamEOlp1oUOtTcL7W5kJvyLDl0PmqzoDk0Je2TG3lHI+VrQvE5U
         2oVgtZHl3dZRh2dBDSrTzYM4cPmyAkOhnkb+8F7BCTFMKFc9NJLzzyAkc4vAHdZv+1vz
         AMSsg6e/2h2Gp8yIKxPCSFVE9925W4Kf5fU30Lse82MeGTOJUwWvgwvDNQvlP5jqNA9V
         n01VvGeCNC1fvLE1doTAFzGBUc98jPGh+fIygZQ+mMdqztX+Faplk23Cs+HxCZyN8/6C
         Ok4/aBaZVJ+eSZmldyXFfRGUsX+tqXuvrYEvLP1zS6e5aTQXHj7iDkZNXwV/NiHB8bb0
         7RNw==
X-Gm-Message-State: AOJu0YzeJJzYJKDuafmswgauEFJ0D1CDiiZKbMOZpna0wxtyvGx1d3wh
        8gw9Z8GYAQeK0uNY0uoHmZ2V1/42ojGUsw==
X-Google-Smtp-Source: AGHT+IGxOwoBoFb6bhUx/nujYr41iMhIuJe5EFQCCe+cDSqkpRY/GmB9x2NxAdNR7LXbeaEU2UaUwQ==
X-Received: by 2002:a0d:e695:0:b0:5c9:70b9:84d5 with SMTP id p143-20020a0de695000000b005c970b984d5mr2828263ywe.8.1700670869750;
        Wed, 22 Nov 2023 08:34:29 -0800 (PST)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com. [209.85.128.176])
        by smtp.gmail.com with ESMTPSA id p13-20020a81ca0d000000b005cb994c12f6sm1153749ywi.115.2023.11.22.08.34.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Nov 2023 08:34:29 -0800 (PST)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-5ca9114e0e2so35656247b3.3;
        Wed, 22 Nov 2023 08:34:29 -0800 (PST)
X-Received: by 2002:a0d:cb58:0:b0:5cb:576a:ec1c with SMTP id
 n85-20020a0dcb58000000b005cb576aec1cmr2804676ywd.9.1700670868874; Wed, 22 Nov
 2023 08:34:28 -0800 (PST)
MIME-Version: 1.0
References: <20231122121235.827122-1-peterlin@andestech.com> <20231122121235.827122-13-peterlin@andestech.com>
In-Reply-To: <20231122121235.827122-13-peterlin@andestech.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 22 Nov 2023 17:34:14 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWHx6FoTCZZqaUAES5wJ=JBu7iLvVtNdBZAHB9mgBX4Gg@mail.gmail.com>
Message-ID: <CAMuHMdWHx6FoTCZZqaUAES5wJ=JBu7iLvVtNdBZAHB9mgBX4Gg@mail.gmail.com>
Subject: Re: [PATCH v4 12/13] riscv: dts: renesas: Add Andes PMU extension
To:     Yu Chien Peter Lin <peterlin@andestech.com>
Cc:     acme@kernel.org, adrian.hunter@intel.com, ajones@ventanamicro.com,
        alexander.shishkin@linux.intel.com, andre.przywara@arm.com,
        anup@brainfault.org, aou@eecs.berkeley.edu, atishp@atishpatra.org,
        conor+dt@kernel.org, conor.dooley@microchip.com, conor@kernel.org,
        devicetree@vger.kernel.org, dminus@andestech.com,
        evan@rivosinc.com, geert+renesas@glider.be, guoren@kernel.org,
        heiko@sntech.de, irogers@google.com, jernej.skrabec@gmail.com,
        jolsa@kernel.org, jszhang@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
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

On Wed, Nov 22, 2023 at 1:17 PM Yu Chien Peter Lin
<peterlin@andestech.com> wrote:
> xandespmu stands for Andes Performance Monitor Unit extension.
> Based on the added Andes PMU ISA string, the SBI PMU driver
> will make use of the non-standard irq source.
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
