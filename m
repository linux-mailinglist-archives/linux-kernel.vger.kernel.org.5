Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D23A7673FA
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 19:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbjG1RyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 13:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbjG1RyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 13:54:14 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62B83421E
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 10:53:48 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-268541d2947so1370271a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 10:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1690566828; x=1691171628;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=37pdsq8+2ptJGKAZent8EqZv3/6dgtP4FMZ1uorvDto=;
        b=IFKPBPXurfdURYStWi+6ZseGJ7z61qyczq/oGR2tEhG4C12DE/c4reMiDyYH1CvNJC
         YFUzga3ik4jSa5zcoHUlTEND1kYGP0goWCSfBt2UEmjpTH/hzB4L79SNwnSI9OOu04rI
         Eop2soCCw9v1nzHdc7z/+jVeA9cZU2oOP1cuNyQB31ois2HGrVkpttIBA/E76ufvOF4s
         KGrw3hBc3y9VfQ4UMfHsAwKk3VyZJ0XWTULmr8QHaTvGnzmFxmeV3/w5RD4ZitX7BgfG
         HBwAh9Zo8VnKiJVi8kDac8p7KXu/4GHnk/ne71045hND+VoIgKswZScuBXpDq7dXCjGy
         6L1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690566828; x=1691171628;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=37pdsq8+2ptJGKAZent8EqZv3/6dgtP4FMZ1uorvDto=;
        b=ExJP0Ce1DfzxkZWVUaTxs+axA/AJ4zOr1kNBfr43M/qRMaYNbSPn+GCeMBa1rye6aU
         WOT6gVGHyIJu+m8h07bpAOVivYgfqqECUMa4VSAZ1uiTmDc/v3tHyjMFUDSXOpTzuZ6y
         TedYcias/Sv9XV1Q0jet+VnbwtDVTFj7tlqA8Qf8IQNlVV23LnhvfubPmosricZrBJjM
         yZkNpXcKcOykuDUFQYtsHqXRz3irwPkPLf0p9J4pmuiMJ8JzJREnma77Zjh3sQYtDxzr
         sT9TUFllmOC1NXUmy/liJrH0Wx9h8cu560AZihrcvcnrjGi3BoT5JLjXAJdxJ72C7vAo
         C3gw==
X-Gm-Message-State: ABy/qLaaoVEn+4XJL9gCcOI5g/UuFpfgobtKO0mkNuSeDVJrGWm4RpbH
        c+jkxLrkG2Jhk+NjoSPL6MHIyg==
X-Google-Smtp-Source: APBJJlELkdP8qtdOWzJYIDmj9vMpr1SLtuGv9RgrFXcZf2pWkzJMLuE3l1bLloZ4gQrTBb3ezjrZLw==
X-Received: by 2002:a17:90a:94c2:b0:263:40e1:d4d9 with SMTP id j2-20020a17090a94c200b0026340e1d4d9mr2018809pjw.47.1690566827709;
        Fri, 28 Jul 2023 10:53:47 -0700 (PDT)
Received: from x1 ([2601:1c2:1800:f680:dacb:3a1a:fcaf:c0fc])
        by smtp.gmail.com with ESMTPSA id 3-20020a17090a1a4300b00267b7c5d232sm4733566pjl.48.2023.07.28.10.53.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 10:53:47 -0700 (PDT)
Date:   Fri, 28 Jul 2023 10:53:45 -0700
From:   Drew Fustini <dfustini@baylibre.com>
To:     Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc:     Xi Ruoyao <xry111@linuxfromscratch.org>,
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
Subject: Re: [PATCH v3 0/8] Add Sipeed Lichee Pi 4A RISC-V board support
Message-ID: <ZMQAqUfb0y/igQs2@x1>
References: <3e0994dab495920ac590dc28d6b9d9765abe0c7e.camel@linuxfromscratch.org>
 <ZME1J4mpVf5yth32@xhacker>
 <866eab3e30a18c50742a75d62aee223fdc7e3cee.camel@linuxfromscratch.org>
 <4986b92f1a5aa303a529c6004aaedd2184c3ccf7.camel@linuxfromscratch.org>
 <ZMKXQpreSr47MFj6@xhacker>
 <290101d386866f639a7c482527d7a78c5108d49b.camel@linuxfromscratch.org>
 <ZMNojqwLxcG8FcHN@x1>
 <af41edfe515373530d3d1ffc43c581131e6f6038.camel@linuxfromscratch.org>
 <0f528aa0d4e6f2491835c9a78bb38dd162b75810.camel@linuxfromscratch.org>
 <CAJM55Z9SeT_-5vDWVUAOKeNGZ0TmBPQMjdaZuyVcnbNJuxNCBQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJM55Z9SeT_-5vDWVUAOKeNGZ0TmBPQMjdaZuyVcnbNJuxNCBQ@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2023 at 12:23:12PM +0200, Emil Renner Berthing wrote:
> On Fri, 28 Jul 2023 at 12:07, Xi Ruoyao <xry111@linuxfromscratch.org> wrote:
> >
> > On Fri, 2023-07-28 at 15:40 +0800, Xi Ruoyao wrote:
> > > On Fri, 2023-07-28 at 00:04 -0700, Drew Fustini wrote:
> > > > It seems like your kernel config is the problem. I used it and I saw
> > > > the same result of a panic in riscv_intc_irq:
> > > > https://gist.github.com/pdp7/1a26ebe20017a3b90c4e9c005f8178e1
> > > >
> > > > This is the config I have been using successfully:
> > > > https://gist.github.com/pdp7/ecb34ba1e93fc6cfc4dce66d71e14f82
> > > >
> > > > Could you try that config?
> > > >
> > > > Linux 6.5-rc3 boots okay when built with it:
> > > > https://gist.github.com/pdp7/580b072f9a5bf9be87cf88b5f81e50e3
> > >
> > > Yes, your configuration works.
> > >
> > > I'll try to figure out which specific configuration item is problematic
> > > in my origin one...
> >
> > Ah, I found it... If I deselect CONFIG_FRAME_POINTER it will crash.
> >
> > And I see RISC-V selects ARCH_WANT_FRAME_POINTERS, so it seems frame
> > pointer is mandated.  But then why I'm able to deselect
> > CONFIG_FRAME_POINTER?
> 
> You've probably run into this issue:
> https://lore.kernel.org/linux-riscv/20230716001506.3506041-1-guoren@kernel.org/
> 
> Try applying those two patches.
> 
> /Emil

Thanks, I think that fixes the issue with CONFIG_FRAME_POINTER=n. I had
the same kernel crash [1] when trying the config from Xi [2].

I just did 'b4 shazam 20230716001506.3506041-1-guoren@kernel.org' and
the riscv_intc_irq panic no longer occurs [3]. I don't have the mmc
patches applied on this branch so the boot just hangs at mounting rootfs
but I think it is otherwise okay.

Drew


[1] https://gist.github.com/pdp7/1a26ebe20017a3b90c4e9c005f8178e1
[2] https://gist.github.com/pdp7/c6e358be892d506826be304dcc346a7a
[3] https://gist.github.com/pdp7/871ada434febeca4ff93f2381352c038
