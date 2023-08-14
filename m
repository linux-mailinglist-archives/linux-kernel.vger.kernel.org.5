Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B27AA77C045
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 21:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231856AbjHNTBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 15:01:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231927AbjHNTA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 15:00:56 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB8AB10FB
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 12:00:54 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1bc73a2b0easo29825285ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 12:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692039654; x=1692644454;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gKTJbYyHwGU/Pavfa3Pni61Jgqd+CWSu3/z3hiS2FZk=;
        b=HLQl75aDvj2mEnVYovaIHU/OOGwgRtjHAT3BetsxMzFRe6RXIWRmCMYKUVj2Mu9Mdl
         d2IbKwWkNjw3pocpmU1XmO6+RmPLRa68vlKwfk2y/ciQk/k7dfiSIL9qbC/wkf2pj4+W
         d/ah7C/qdg5kc7tdACd3HKs8HaDGCfk13BTHc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692039654; x=1692644454;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gKTJbYyHwGU/Pavfa3Pni61Jgqd+CWSu3/z3hiS2FZk=;
        b=hHFtYtJPlFa5I/gP5002sWQeVWwJgw2o6XLF+f+1ZkjIgL60eNbjbyS5Xkvjnn92He
         Keg6i/K4wJabE1UN/TA/+H4IwFJSMVpsYyfPCLd/0r4L42EUCL3s9f/LXK7VS2bu0A/p
         IRMLWave9aj10Li5OF0yyAY+26RNa8PckrjAiRh0Fa+vcmlhJXH9dsEbzvmapy6gxQGi
         tW2//QvQuvpVQOwHpHVPSf34R/Bh+q2CYqp1+R4z7qA+rJBYww/mzp8yLOO9X0zSpsPg
         QxpATKCoLeHUD0PRxWH1nLHig+NiCbuH2NJiw9T+hiekwJ4KFKSVAqiwyz1aXqTEtzZR
         FlBw==
X-Gm-Message-State: AOJu0YwQYK1+1BqmqwzpORO8h7Y37ymJ1zrkHprRsaJhF56sI3TlfyzA
        0/fl41zyqe6mNWf9FD/081YDdQ==
X-Google-Smtp-Source: AGHT+IFdxlyUb3opfqP0LZm8yaMzbRYT5aUM9s1n5GnCFd9QkjKQiIIeuTRrDisx8zwdDnVwz0WSPw==
X-Received: by 2002:a17:902:968f:b0:1bc:4f64:e2fc with SMTP id n15-20020a170902968f00b001bc4f64e2fcmr8552937plp.27.1692039654159;
        Mon, 14 Aug 2023 12:00:54 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id u18-20020a170903125200b001b53953f306sm9813816plh.178.2023.08.14.12.00.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 12:00:52 -0700 (PDT)
Date:   Mon, 14 Aug 2023 12:00:51 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org, linux-wireless@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org
Subject: Re: Build regressions/improvements in v6.5-rc3
Message-ID: <202308141159.9E4C2332@keescook>
References: <CAHk-=wi4Yau-3Bsv2rXYmtXMTLaj3=Wyf4cdM6d89czFvkVsRQ@mail.gmail.com>
 <20230724122626.1701631-1-geert@linux-m68k.org>
 <88f83d73-781d-bdc-126-aa629cb368c@linux-m68k.org>
 <202307281551.D894AA39@keescook>
 <CAMuHMdXRiacSxqDzYmakWAQB99kYvY0Bi9zALP9ZnC9Xs_xO5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdXRiacSxqDzYmakWAQB99kYvY0Bi9zALP9ZnC9Xs_xO5g@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2023 at 06:20:59PM +0200, Geert Uytterhoeven wrote:
> Hi Kees,
> 
> On Sat, Jul 29, 2023 at 12:57 AM Kees Cook <keescook@chromium.org> wrote:
> > On Mon, Jul 24, 2023 at 02:43:02PM +0200, Geert Uytterhoeven wrote:
> > > On Mon, 24 Jul 2023, Geert Uytterhoeven wrote:
> > > > JFYI, when comparing v6.5-rc3[1] to v6.5-rc2[3], the summaries are:
> > > >  - build errors: +5/-0
> > >
> > >   + /kisskb/src/include/linux/fortify-string.h: error: call to '__write_overflow_field' declared with attribute warning: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Werror=attribute-warning]:  => 583:25, 493:25
> > >
> > > mips-gcc13/mips-allmodconfig
> > >
> > > Full context:
> > >
> > >     In function 'fortify_memset_chk',
> > >       inlined from 'memset_io' at /kisskb/src/arch/mips/include/asm/io.h:486:2,
> > >       inlined from 'build_auth_frame' at /kisskb/src/drivers/net/wireless/legacy/ray_cs.c:2697:2:
> > >     /kisskb/src/include/linux/fortify-string.h:493:25: error: call to '__write_overflow_field' declared with attribute warning: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Werror=attribute-warning]
> > >       493 |                         __write_overflow_field(p_size_field, size);
> > >         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > >     In function 'fortify_memcpy_chk',
> > >       inlined from 'memcpy_toio' at /kisskb/src/arch/mips/include/asm/io.h:494:2,
> > >       inlined from 'translate_frame' at /kisskb/src/drivers/net/wireless/legacy/ray_cs.c:955:3,
> > >       inlined from 'ray_hw_xmit.constprop' at /kisskb/src/drivers/net/wireless/legacy/ray_cs.c:912:12:
> > >     /kisskb/src/include/linux/fortify-string.h:583:25: error: call to '__write_overflow_field' declared with attribute warning: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Werror=attribute-warning]
> > >       583 |                         __write_overflow_field(p_size_field, size);
> > >         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > >
> > > Single-element flexible array abuse in drivers/net/wireless/legacy/rayctl.h:tx_msg.var
> >
> > ^^^^
> > is this line from you or is there a tool outputting this? Because, yes,
> 
> It is a line from me.
> 
> (should I take it as a compliment that I start sounding like a tool? ;-)

Heh. It was so declaratory. :) I think I was hoping there was some
analyzer that could save us the pain of manually examining these
warnings.

> 
> > very true:
> >
> > struct tx_msg {
> >     struct tib_structure tib;
> >     struct phy_header phy;
> >     struct mac_header mac;
> >     UCHAR  var[1];
> > };
> >
> > I'll send a patch.
> 
> Thanks, I noticed you took care while I was enjoying summer holidays ;-)

Awesome! Thanks for the report. :)

-- 
Kees Cook
