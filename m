Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 613377997DA
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 14:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345539AbjIIMLO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 9 Sep 2023 08:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345505AbjIIMLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 08:11:13 -0400
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BF80CD6
        for <linux-kernel@vger.kernel.org>; Sat,  9 Sep 2023 05:11:07 -0700 (PDT)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-1a28de15c8aso2304317fac.2
        for <linux-kernel@vger.kernel.org>; Sat, 09 Sep 2023 05:11:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694261466; x=1694866266;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yabyQiAl8j5eXWo65T3fAwQZtqAN0vBKM+cJ98wtujM=;
        b=ahslgGEvqUnzxXyagff1mZKhVGeFs4vLVGJmq5WyFJjTc/R58EqM5e9var78++WkaJ
         q1fdWQAVKp2UnH44ORXIh3Ww5nj5IWsna8ieaDRQOcMM8KcNBtT89a8H0Rikhv0oCj/g
         LozXlxFCsCKIK6yBJ7uE+hhRSplyebdALIDg2VofYmZXGyD/Tr34A26rk228khApGr3c
         s4+BXk0zJxNiNgfPiVNRG1oKaN50LkD3LDRl5cY/wmi/n6Klh7Pw3kW5eASTGO44RxZz
         R+CfXDNrUgVFCGSDREEiQ3LqW/nvr/UAMvxg+JIQ85rNrEM+kR/fy8dGIuVNjvWg2388
         BjaQ==
X-Gm-Message-State: AOJu0YxNsWxLr4eDbCct+R9w2z1IiGFHAvjSlHMe+ief1oerdzTQYuDY
        iT6nYX1o+3/wYKgb+Nu1W+RIcSSmjroZ/Q==
X-Google-Smtp-Source: AGHT+IHFwjzh0swbtTx0CMAn0cYeo6fW2ogbWgpAUK4acgRc7rj4EIXYBQp0kVSx4iszaIHkEhRlsw==
X-Received: by 2002:a05:6871:85:b0:1bb:8333:ab8a with SMTP id u5-20020a056871008500b001bb8333ab8amr7154158oaa.4.1694261466632;
        Sat, 09 Sep 2023 05:11:06 -0700 (PDT)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id r125-20020a0dcf83000000b005929fd6a6c7sm920556ywd.41.2023.09.09.05.11.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Sep 2023 05:11:06 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-ccc462deca6so2610623276.0
        for <linux-kernel@vger.kernel.org>; Sat, 09 Sep 2023 05:11:05 -0700 (PDT)
X-Received: by 2002:a25:aa73:0:b0:d47:8db3:8bc8 with SMTP id
 s106-20020a25aa73000000b00d478db38bc8mr5284381ybi.21.1694261465123; Sat, 09
 Sep 2023 05:11:05 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1694093327.git.geert@linux-m68k.org> <e9f3da9b152b7d19b64d775d04e9e11b63dc35b6.1694093327.git.geert@linux-m68k.org>
 <1c7894fe-4cf4-1ad9-5ed2-aaab4351ff4c@linux-m68k.org> <CAMuHMdV1Xejj2hmS6fO=gviRCuqL82S+9nFLtSkJjH-aALWThQ@mail.gmail.com>
 <4a126e21-6c36-024b-9ab1-b4798ef274d4@linux-m68k.org>
In-Reply-To: <4a126e21-6c36-024b-9ab1-b4798ef274d4@linux-m68k.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sat, 9 Sep 2023 14:10:52 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU9ujRZNxmrQh3+QZ2YNbvXwuXnfi-6OBuZxoa2aVsiXA@mail.gmail.com>
Message-ID: <CAMuHMdU9ujRZNxmrQh3+QZ2YNbvXwuXnfi-6OBuZxoa2aVsiXA@mail.gmail.com>
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

On Sat, Sep 9, 2023 at 12:59 AM Finn Thain <fthain@linux-m68k.org> wrote:
> On Fri, 8 Sep 2023, Geert Uytterhoeven wrote:
> > On Fri, Sep 8, 2023 at 1:44 AM Finn Thain <fthain@linux-m68k.org> wrote:
> > > On Thu, 7 Sep 2023, Geert Uytterhoeven wrote:
> > > > --- /dev/null
> > > > +++ b/arch/m68k/mac/mac.h
> > > > @@ -0,0 +1,25 @@
> > > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > > +
> > > > +struct rtc_time;
> > > > +
> > >
> > > I don't think we need a new header file. Related function prototypes
> > > already have homes in existing header files --
> > >
> > > > +/* baboon.c */
> > > > +void baboon_init(void);
> > > > +
> > >
> > > this could go into mac_baboon.h
> > >
> > > > +/* iop.c */
> > > > +void iop_init(void);
> > > > +
> > >
> > > mac_iop.h
> > >
> > > > +/* misc.c */
> > > > +int mac_hwclk(int op, struct rtc_time *t);
> > > > +
> > >
> > > macintosh.h
> > >
> > > > +/* macboing.c */
> > > > +void mac_mksound(unsigned int freq, unsigned int length);
> > > > +
> > >
> > > mac_asc.h
> > >
> > > > +/* oss.c */
> > > > +void oss_init(void);
> > > > +
> > >
> > > mac_oss.h
> > >
> > > > +/* psc.c */
> > > > +void psc_init(void);
> > > > +
> > >
> > > mac_psc.h
> > >
> > > > +/* via.c */
> > > > +void via_init(void);
> > > > +void via_init_clock(void);
> > >
> > > mac_via.h
> >
> > All mac*.h you suggest live under arch/m68k/include/asm/, and are thus
> > shared with the whole tree, while only the core code under arch/m68k/
> > needs these definitions.
> >
>
> I guess #include "../mac/mac.h" is expected but
> #include "../../m68k/mac/mac.h" is not intended (?)

Yes indeed.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
