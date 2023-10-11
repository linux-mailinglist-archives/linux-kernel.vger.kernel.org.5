Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8CE7C5DE2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 21:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376296AbjJKTxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 15:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233419AbjJKTxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 15:53:16 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8DA590
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 12:53:14 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9b2f73e3af3so28075866b.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 12:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1697053993; x=1697658793; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tUfa4vIuWpsi0vE4J7cy1MWGRzD7YIrcZ6ulH75qxJo=;
        b=TaR6IKvzan+Wc5ItPslv37LPaKdEZdk9rhAVT2TmntQwKP1GqrpNprltqBcmzfCR5I
         z0LDrNgK9cz8kt34hhocPOaimPuhPI7hwyHkQrnxQJRBGhn8keelm+X+Pyf5/t9M4RH1
         4IXi+wWWNe3m/scsNE/g2X2qeQ+Fja+Uj1Ve8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697053993; x=1697658793;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tUfa4vIuWpsi0vE4J7cy1MWGRzD7YIrcZ6ulH75qxJo=;
        b=uK6HWBy1yPeY71qTX5S5v4JbmYw5lUxjChz34L8fOWAL//1Oj//Laokg+RQzMBKymr
         SQ+OS3vPi7B39wZpSlajVlyQO6ERE4hx2AyhKw5JKtq3mVHJvstGlA8LM9XaOjd2HhaR
         DOHOyk1wNkXln/faBHn80TNefgrXFBzNRQx+FjdwOAaOWgoRzVcXZmY9UAzcn0IHbTjP
         I0ZAdFUkbSpYfffSd00Crodxhap7tkUYsWffEmcp95m0/efAkp8IqPN6TN2najkeC3XQ
         ggYFGyVl8/mLNJlhTzyP6sSmViuIBbeZ/iErUEV50vHioTNLrgAOiL8A6otdL74BhXD3
         US1A==
X-Gm-Message-State: AOJu0Yxc25TUyWiMaEBRAV+wgFGI14I4irWOZU6gsMhhhuanC/9VEHuT
        4oHAkoCTnyc0Hr1KlWIH+jOhwRptPbTkFv1yWRxMegRG
X-Google-Smtp-Source: AGHT+IGBhnAFAxg+3cvE/D51OMcsfeTD/+avUKtfebn2RHZ9pIA5qZzf7qDabL+24DlbvC6OSFNvPQ==
X-Received: by 2002:a17:907:78d9:b0:9bb:a243:e6f1 with SMTP id kv25-20020a17090778d900b009bba243e6f1mr4070771ejc.0.1697053993222;
        Wed, 11 Oct 2023 12:53:13 -0700 (PDT)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id lz11-20020a170906fb0b00b009b97521b58bsm10199726ejb.39.2023.10.11.12.53.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Oct 2023 12:53:12 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-53dd752685fso425885a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 12:53:12 -0700 (PDT)
X-Received: by 2002:a05:6402:2214:b0:53d:fe06:3bb2 with SMTP id
 cq20-20020a056402221400b0053dfe063bb2mr460278edb.8.1697053991908; Wed, 11 Oct
 2023 12:53:11 -0700 (PDT)
MIME-Version: 1.0
References: <20231010164234.140750-1-ubizjak@gmail.com> <CAHk-=whYWhZN52SJN-Th9x2L2V-vHtAXUgiy_nSJ3+vQU6ak4Q@mail.gmail.com>
 <CAFULd4ZqH3FeG8_mjDvUAU9QiGB36wDu3MzUtadgAgoVuQ9QRg@mail.gmail.com>
 <CAHk-=wiALZxieQQmvv5sW15HYB_YwC3d_ma9sdp7Zb4Fb4uK2w@mail.gmail.com>
 <CAFULd4Y8NSArDqH=VMy8F97eNosUUGxrBMEyHH=MytjUBSCmjg@mail.gmail.com>
 <CAHk-=whMr8V_q3dq4iS0dpx4Nssu+aYWz+mA36p2ykA+OXTjXA@mail.gmail.com>
 <CAFULd4afyYK0-wAOo3oJDapX0iyu86m5+vVn9c35gk8fd6iwRQ@mail.gmail.com> <CAHk-=wiLyA0g3BvQ_nsF2PWi-FDtcNS5+4-ai1FX-xFzTBeTzg@mail.gmail.com>
In-Reply-To: <CAHk-=wiLyA0g3BvQ_nsF2PWi-FDtcNS5+4-ai1FX-xFzTBeTzg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 11 Oct 2023 12:52:54 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg+zCZNRW-N6SFn8w_xYLzG6Y_NsW9doxcD32hb-jWd8w@mail.gmail.com>
Message-ID: <CAHk-=wg+zCZNRW-N6SFn8w_xYLzG6Y_NsW9doxcD32hb-jWd8w@mail.gmail.com>
Subject: Re: [PATCH v2 -tip] x86/percpu: Use C for arch_raw_cpu_ptr()
To:     Uros Bizjak <ubizjak@gmail.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Nadav Amit <namit@vmware.com>,
        Andy Lutomirski <luto@kernel.org>,
        Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Oct 2023 at 12:51, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Dio y ou have any actka performance numbers?

And before anybody worries - no, I didn't have a stroke in the middle
of writing that. I'm just not a great typist ;)

                  Linus
