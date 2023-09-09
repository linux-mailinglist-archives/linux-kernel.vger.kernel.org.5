Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3B407997DB
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 14:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345558AbjIIMMj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 9 Sep 2023 08:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234102AbjIIMMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 08:12:38 -0400
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E3B0CDE
        for <linux-kernel@vger.kernel.org>; Sat,  9 Sep 2023 05:12:35 -0700 (PDT)
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5733d431209so1813836eaf.0
        for <linux-kernel@vger.kernel.org>; Sat, 09 Sep 2023 05:12:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694261554; x=1694866354;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ElnjYqTEVh98M3QsOcoe1d7VW/OGyAcrh4Gl8OyK3Xs=;
        b=pY9xL/LiEm1GnNf0YWZs/ozW5We3NsKuhqh/UD1rt22qNHkbJaKeCtQZJtdQNMvLDX
         K7Pz+B3hf0NXz+EKFnAIW56lffdWmSWWWXozWwPmYzqMEbVenZ16p7j4UBY/xc1d7I9s
         Dm0lp1QNRwn6TnoePVY1HuGNUURusi8UCzH0XvlwS1HTiSCuT4C0u0TtmY7gIvXHw4Fb
         WnMA12FJG7aOKLr9lFsbRhP7+sKIaHv3mGGkhv/mVCRYStVdPeSo1yxRrbmblbsKLDZ0
         VF7JegH+dyl/NqKRuUjOD0CUhB76BVuh9LW+e2cDLq/ezMWnKy4WYsdZJcUtnMH+O35O
         dudg==
X-Gm-Message-State: AOJu0YyQqut75qTA0OlHg4djHqsWjEC0Q+KpsyjpOD58opYwbMp7jg88
        7RdJEpV62bbubxcPLfur/cd0Gthy6CLC7Q==
X-Google-Smtp-Source: AGHT+IF/356TdVmIcaXjqVG1LzkHQdJBjbjbaZg4WbdcREB1HKEq4sB21oyFkMVeTtSVp123yhBW6Q==
X-Received: by 2002:a05:6870:2192:b0:1be:ceca:c666 with SMTP id l18-20020a056870219200b001bececac666mr6512748oae.14.1694261554167;
        Sat, 09 Sep 2023 05:12:34 -0700 (PDT)
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com. [209.85.210.52])
        by smtp.gmail.com with ESMTPSA id x2-20020a056870740200b001d4d7238a78sm2016029oam.54.2023.09.09.05.12.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Sep 2023 05:12:33 -0700 (PDT)
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-6bcb5df95c5so2182974a34.1
        for <linux-kernel@vger.kernel.org>; Sat, 09 Sep 2023 05:12:33 -0700 (PDT)
X-Received: by 2002:aca:2302:0:b0:3a8:4dfd:4f14 with SMTP id
 e2-20020aca2302000000b003a84dfd4f14mr5186395oie.27.1694261553297; Sat, 09 Sep
 2023 05:12:33 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1694093327.git.geert@linux-m68k.org> <64ea8cf65a4318fbf8c91cb3062d90a2555007c4.1694093327.git.geert@linux-m68k.org>
 <2545f40a-0c59-491d-895f-4a7975faaedc@app.fastmail.com>
In-Reply-To: <2545f40a-0c59-491d-895f-4a7975faaedc@app.fastmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sat, 9 Sep 2023 14:12:21 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWs0QbRQZCXZ2Gycqb7jjsjUZMp7_h2mVWxR1zrjCL1Og@mail.gmail.com>
Message-ID: <CAMuHMdWs0QbRQZCXZ2Gycqb7jjsjUZMp7_h2mVWxR1zrjCL1Og@mail.gmail.com>
Subject: Re: [PATCH 15/52] m68k: emu: Mark version[] __maybe_unused
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-m68k@lists.linux-m68k.org,
        Finn Thain <fthain@linux-m68k.org>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Philip Blundell <philb@gnu.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Joshua Thompson <funaho@jurai.org>,
        Sam Creasey <sammy@sammy.net>,
        Laurent Vivier <laurent@vivier.eu>,
        linux-kernel@vger.kernel.org
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

Hi Arnd,

On Sat, Sep 9, 2023 at 10:28 AM Arnd Bergmann <arnd@arndb.de> wrote:
> On Thu, Sep 7, 2023, at 15:41, Geert Uytterhoeven wrote:
> > When building with W=1:
> >
> >     m68k/arch/m68k/emu/nfeth.c:42:19: warning: ‘version’ defined but
> > not used [-Wunused-const-variable=]
> >        42 | static const char version[] =
> >         |                   ^~~~~~~
> >
> > Fix this while obeying the wishes of the original copyright holders by
> > marking version[] with __maybe_unused.
> >
> > Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
>
> That will just drop it from the object file, maybe it should
> instead be marked "__used" ?

Given it's been like this since the beginning, I guess it never showed
up in the object file anyway...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
