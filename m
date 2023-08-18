Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD5DE780F2D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 17:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239086AbjHRP2R convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 18 Aug 2023 11:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378185AbjHRP2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 11:28:10 -0400
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EC9C272D;
        Fri, 18 Aug 2023 08:28:09 -0700 (PDT)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-58e6c05f529so10488117b3.3;
        Fri, 18 Aug 2023 08:28:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692372488; x=1692977288;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IMYfPhpdXZY/HNpd60MMH7BNe+/RbVz/FE+3GuTWXvg=;
        b=aLZkT48hjCbcaINPls+qnieKi9tEUr90oUugyjc9APLKVe7SuSAOLUTG6OvU78wyBS
         ftU0ncG8uBQhBVPE7iFnz2JdTerWoy5I/VlrEU89U6vqHH/QI08i1qkkLJvK/R+y7tIV
         YsLyoES1IDuKhAvm2AimMxnLk8CzxrYO8NXePhv8PIppWSyEd1+NfYK6SJ9zi+U8eV4Z
         aaBQkrXoNkninqbM3t0Y8ut5nKyCGY5hjaU2FB6+yBxafDuLUlseH9RywxnBIbhhJ1cL
         eyOFZR1q2h30Vkk7oiu9kcNI0kDWkk+sp+8VDDEhIDBoXuQ41lYVsvwDyBiapAZkJ2A2
         ESCg==
X-Gm-Message-State: AOJu0Ywxg8Id/DjWGPOEpuC6ztuI/Tr7ZVgv4iK4S6F8z/hn1tbTXHps
        uE2NR1ULMDl2bCDECB08Wiu3LfIf2TGipOcu
X-Google-Smtp-Source: AGHT+IGieLwezm+fCxxQMA1a6qEqjWKA8sEQDCaBIuyYQkd9RknYeZpFDMuPv7LVO8Gm0o5gPTxarw==
X-Received: by 2002:a0d:d646:0:b0:570:77b3:1c78 with SMTP id y67-20020a0dd646000000b0057077b31c78mr2683597ywd.25.1692372488101;
        Fri, 18 Aug 2023 08:28:08 -0700 (PDT)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id u128-20020a816086000000b00589ace164besm546555ywb.61.2023.08.18.08.28.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Aug 2023 08:28:07 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-cfcebc33d04so1001395276.2;
        Fri, 18 Aug 2023 08:28:07 -0700 (PDT)
X-Received: by 2002:a25:2314:0:b0:c4b:ada8:8b86 with SMTP id
 j20-20020a252314000000b00c4bada88b86mr2923043ybj.64.1692372487654; Fri, 18
 Aug 2023 08:28:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230801-dt-changeset-fixes-v2-0-c2b701579dee@kernel.org> <20230801-dt-changeset-fixes-v2-1-c2b701579dee@kernel.org>
In-Reply-To: <20230801-dt-changeset-fixes-v2-1-c2b701579dee@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 18 Aug 2023 17:27:56 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUtXt2MGNddapmkZN1uamKd=C39gJ0iFXpZPFR3BDj-6A@mail.gmail.com>
Message-ID: <CAMuHMdUtXt2MGNddapmkZN1uamKd=C39gJ0iFXpZPFR3BDj-6A@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] of: unittest: Fix EXPECT for parse_phandle_with_args_map()
 test
To:     Rob Herring <robh@kernel.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 5, 2023 at 12:42 AM Rob Herring <robh@kernel.org> wrote:
> Commit 12e17243d8a1 ("of: base: improve error msg in
> of_phandle_iterator_next()") added printing of the phandle value on
> error, but failed to update the unittest.
>
> Fixes: 12e17243d8a1 ("of: base: improve error msg in of_phandle_iterator_next()")
> Signed-off-by: Rob Herring <robh@kernel.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
