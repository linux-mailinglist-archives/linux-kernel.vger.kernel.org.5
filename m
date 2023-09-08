Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7376F798322
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 09:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242380AbjIHHPj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 8 Sep 2023 03:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242527AbjIHHPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 03:15:36 -0400
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 236E51BF4
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 00:15:22 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-d77ad095e5cso1674795276.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Sep 2023 00:15:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694157321; x=1694762121;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J3D3jclUxV5EXK8oDDsSaJIa0qUPkeLw+a0rRVcoFOI=;
        b=iBoY+MXnbAg4UKBZgoPL2b57W38GPMT8+58G32sfGD7DfCJbLuui5fAV165g3OAa5w
         oZNenXLXZZ+mvk5noyn6JRDhXrnxoiVNwfh4S6mfV8YBa/3xRhvvqDqK9UV2NvH0Oz+D
         Qv9mDsOmEGNni+gRjZQzwrMnBHFozgV5mCSAxFoERS+v5HTuz1snIidtHHXD+qI2Amdo
         Qy4NZ072JBUNGwUTq4s5FFPWuc1MchRYMex8biN+tMt4Kh/nUEUDV1uM8DizvYbJm3Hk
         sWa5YYbqjjap1kNkO3Gm13Xdkc9IIosT4BZIBTKJF9dp7dJWGuHRxeiisuiEV1/vQ3t3
         HHpg==
X-Gm-Message-State: AOJu0YwSSrpW8Jm9NYYbE4ahWol1o1g+CB8EYqK+/+sQ5d1rlNdzbeqr
        iBNSHjB8Ms0j1SlwgUmpJIvg0nKU9wfeTH8h
X-Google-Smtp-Source: AGHT+IHp1kXT7xXsTGVpXojj+rOLMXA5y4k0n39PnPhQIiclkT9bYTR2/jeoTisfChdGeKb7Lpnjhw==
X-Received: by 2002:a25:d20d:0:b0:d12:d6e4:a08b with SMTP id j13-20020a25d20d000000b00d12d6e4a08bmr1560133ybg.22.1694157321155;
        Fri, 08 Sep 2023 00:15:21 -0700 (PDT)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id g1-20020a258a01000000b00d7802512079sm249704ybl.38.2023.09.08.00.15.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Sep 2023 00:15:19 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-d7bbaa8efa7so1652839276.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Sep 2023 00:15:19 -0700 (PDT)
X-Received: by 2002:a25:2f85:0:b0:d80:1a0a:e7a7 with SMTP id
 v127-20020a252f85000000b00d801a0ae7a7mr1485372ybv.53.1694157319131; Fri, 08
 Sep 2023 00:15:19 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1694093327.git.geert@linux-m68k.org> <e9f3da9b152b7d19b64d775d04e9e11b63dc35b6.1694093327.git.geert@linux-m68k.org>
 <1c7894fe-4cf4-1ad9-5ed2-aaab4351ff4c@linux-m68k.org>
In-Reply-To: <1c7894fe-4cf4-1ad9-5ed2-aaab4351ff4c@linux-m68k.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 8 Sep 2023 09:15:07 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV1Xejj2hmS6fO=gviRCuqL82S+9nFLtSkJjH-aALWThQ@mail.gmail.com>
Message-ID: <CAMuHMdV1Xejj2hmS6fO=gviRCuqL82S+9nFLtSkJjH-aALWThQ@mail.gmail.com>
Subject: Re: [PATCH 32/52] m68k: mac: Add and use "mac.h"
To:     Finn Thain <fthain@linux-m68k.org>
Cc:     linux-m68k@lists.linux-m68k.org, Arnd Bergmann <arnd@arndb.de>,
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
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Finn,

On Fri, Sep 8, 2023 at 1:44 AM Finn Thain <fthain@linux-m68k.org> wrote:
> On Thu, 7 Sep 2023, Geert Uytterhoeven wrote:
> > --- /dev/null
> > +++ b/arch/m68k/mac/mac.h
> > @@ -0,0 +1,25 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +
> > +struct rtc_time;
> > +
>
> I don't think we need a new header file. Related function prototypes
> already have homes in existing header files --
>
> > +/* baboon.c */
> > +void baboon_init(void);
> > +
>
> this could go into mac_baboon.h
>
> > +/* iop.c */
> > +void iop_init(void);
> > +
>
> mac_iop.h
>
> > +/* misc.c */
> > +int mac_hwclk(int op, struct rtc_time *t);
> > +
>
> macintosh.h
>
> > +/* macboing.c */
> > +void mac_mksound(unsigned int freq, unsigned int length);
> > +
>
> mac_asc.h
>
> > +/* oss.c */
> > +void oss_init(void);
> > +
>
> mac_oss.h
>
> > +/* psc.c */
> > +void psc_init(void);
> > +
>
> mac_psc.h
>
> > +/* via.c */
> > +void via_init(void);
> > +void via_init_clock(void);
>
> mac_via.h

All mac*.h you suggest live under arch/m68k/include/asm/, and are thus
shared with the whole tree, while only the core code under arch/m68k/
needs these definitions.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
