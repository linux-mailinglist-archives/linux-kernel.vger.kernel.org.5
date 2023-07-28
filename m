Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB64B766A35
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 12:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235264AbjG1KX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 06:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235810AbjG1KXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 06:23:50 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BDE33A81
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 03:23:36 -0700 (PDT)
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 9ECAF40822
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 10:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1690539810;
        bh=WLnDrc+rYkHy9bAgh+dxRp9NnmR58Fh4SPqrY0WiOj0=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=MtEc6QobGE02LlmusYWJ6hKmRLhwQCNe09sQimYYcL9Mb1f9jcWFEVTnmCAmu9VxX
         DvM5+bHK/7hqalx4oL+yy+phxh9xnHfcFKxlEcdLu2q5LTCeS5aPCfA+OMW31KnolU
         uuefDf152MSDfM70H5atPfzfVX8/3n6lXoulIvn/74wYcIbJqazIKBGXy7kKlMcA7f
         12CpCYAS14FUg5s9OLBVZOgZRM96Vb+pPXigA3cUT4NroWXr9Mjh/pauOteGU4xJKR
         zbqbMxCnqfP/XW94cZ7DdoI/faaB+nPYR3wXbDqDxtHVzgVPchmuNEclJAZmm7CUzd
         b6By57cFGGybg==
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-767b778582eso236957385a.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 03:23:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690539809; x=1691144609;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WLnDrc+rYkHy9bAgh+dxRp9NnmR58Fh4SPqrY0WiOj0=;
        b=H9NXgMSCuLN3cHdJ/mgR8/MbtOJ3bcwBhLamgoZ/jc9N4gZosD+Iy3CYEvnKWPIkKz
         /YxnJaHymb1kExUfmWtQkYhjG1JmlQI2Vj/3CngYPLZQriXXU8vWHIov3d2iIEDHbZE1
         wZshBsPpwRNqnVZSez5iaCb+30dYBfiF0ookdnttCR1PG92WY6O5f3sLIigxmhANjltj
         Jiy5rjP1/2GyS7nLPJeltly7/toQWffzx2srJ4OYP7kjiY+A7AcDSHzlxgjY0KPbaF/8
         xNAvqfffsKbf0/G17jHYvFOo3wcop2hvIbv4+6iDXxl/J3PubB2DptmjQ3M4Gtj2zfWE
         5XWg==
X-Gm-Message-State: ABy/qLaInafn0t2B24IC+TujOxaGsm5QJKqPBK0YBf8nk4rIufSjhzKP
        h0JUSHAzWsiYETaIEJD+8v7J7OCbmskN8oeMAhVXG2B9+gaEdqfx0KbOsV/Y6Czogl5G3T8rdF1
        WhFfylNT0OM8QXZu0itf7BxAUFMWM0VKUl64L3kvndfXPzwdjmDxoj5E0lg==
X-Received: by 2002:a05:620a:44c2:b0:765:ab83:ef05 with SMTP id y2-20020a05620a44c200b00765ab83ef05mr2598603qkp.56.1690539809443;
        Fri, 28 Jul 2023 03:23:29 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFcKhdNQ8Hs4J35XbEQ2hbzW3cikJQYq0MD/JjdXIJIhnGCVG8T2MePWTq8hZguyBvatYVfCrK3lq92FYw3mSs=
X-Received: by 2002:a05:620a:44c2:b0:765:ab83:ef05 with SMTP id
 y2-20020a05620a44c200b00765ab83ef05mr2598590qkp.56.1690539809213; Fri, 28 Jul
 2023 03:23:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230617161529.2092-1-jszhang@kernel.org> <c9a44f534071a6d67f1e21bafdb713793c559124.camel@linuxfromscratch.org>
 <20230725-unheard-dingy-42f0fafe7216@wendy> <ZL/jMYL3akl78ZZN@xhacker>
 <3e0994dab495920ac590dc28d6b9d9765abe0c7e.camel@linuxfromscratch.org>
 <ZME1J4mpVf5yth32@xhacker> <866eab3e30a18c50742a75d62aee223fdc7e3cee.camel@linuxfromscratch.org>
 <4986b92f1a5aa303a529c6004aaedd2184c3ccf7.camel@linuxfromscratch.org>
 <ZMKXQpreSr47MFj6@xhacker> <290101d386866f639a7c482527d7a78c5108d49b.camel@linuxfromscratch.org>
 <ZMNojqwLxcG8FcHN@x1> <af41edfe515373530d3d1ffc43c581131e6f6038.camel@linuxfromscratch.org>
 <0f528aa0d4e6f2491835c9a78bb38dd162b75810.camel@linuxfromscratch.org>
In-Reply-To: <0f528aa0d4e6f2491835c9a78bb38dd162b75810.camel@linuxfromscratch.org>
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
Date:   Fri, 28 Jul 2023 12:23:12 +0200
Message-ID: <CAJM55Z9SeT_-5vDWVUAOKeNGZ0TmBPQMjdaZuyVcnbNJuxNCBQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] Add Sipeed Lichee Pi 4A RISC-V board support
To:     Xi Ruoyao <xry111@linuxfromscratch.org>
Cc:     Drew Fustini <dfustini@baylibre.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Jul 2023 at 12:07, Xi Ruoyao <xry111@linuxfromscratch.org> wrote:
>
> On Fri, 2023-07-28 at 15:40 +0800, Xi Ruoyao wrote:
> > On Fri, 2023-07-28 at 00:04 -0700, Drew Fustini wrote:
> > > It seems like your kernel config is the problem. I used it and I saw
> > > the same result of a panic in riscv_intc_irq:
> > > https://gist.github.com/pdp7/1a26ebe20017a3b90c4e9c005f8178e1
> > >
> > > This is the config I have been using successfully:
> > > https://gist.github.com/pdp7/ecb34ba1e93fc6cfc4dce66d71e14f82
> > >
> > > Could you try that config?
> > >
> > > Linux 6.5-rc3 boots okay when built with it:
> > > https://gist.github.com/pdp7/580b072f9a5bf9be87cf88b5f81e50e3
> >
> > Yes, your configuration works.
> >
> > I'll try to figure out which specific configuration item is problematic
> > in my origin one...
>
> Ah, I found it... If I deselect CONFIG_FRAME_POINTER it will crash.
>
> And I see RISC-V selects ARCH_WANT_FRAME_POINTERS, so it seems frame
> pointer is mandated.  But then why I'm able to deselect
> CONFIG_FRAME_POINTER?

You've probably run into this issue:
https://lore.kernel.org/linux-riscv/20230716001506.3506041-1-guoren@kernel.org/

Try applying those two patches.

/Emil
