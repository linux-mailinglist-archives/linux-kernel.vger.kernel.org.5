Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 875057B5F13
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 04:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239004AbjJCCc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 22:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbjJCCc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 22:32:26 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 845FFBD
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 19:32:23 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-405459d9a96so47835e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 19:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696300342; x=1696905142; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=al5wsxcEEaN9EiW9Q10StMwifcs508QOq5CB2e+zVuE=;
        b=JEder+CwoTzfgoSh5q3l6XLAlAXUPid8zXnLr896D5cV4xUPqnlkb+6KUVZbPdtGFR
         CwKs8MPlCfslQVtbqWEiSVgTx+qMFIlFxlLHf/3AixlJ+Tdke1/AftgVhbc1xs1zc5Mi
         AikMxYQUmjvjpTQWyEkxM4UNl1C7HfCsBmtKoTPJJbI3p7EwUJO4La10oonv9uQvvShV
         yk3f9b8NP2wACjQ4YS4700hwkZ3TskMtZ8LwzAUuoHBNEZzt/pJAELnUj0/14UxNtkHJ
         8VPviB1m4H3Et4eu9ch9qB+ugAgLhm17IiGCuT3zMvgs+A7SYO32N3evGfZFLMbMRZCJ
         /H+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696300342; x=1696905142;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=al5wsxcEEaN9EiW9Q10StMwifcs508QOq5CB2e+zVuE=;
        b=c8n4Nmap4Laf6W0TybLAlFdyjHhDPnWM2iqa2anzpkWXt47G540M95Cv4JS0mn1LGq
         J3gh7TvHY3MdJnf6Z/js9cIdialynNfvi3mGDFOwsZMJYZD1hfBXIKm7I+8uhgoP1pfy
         VX0z2LH9G8aHb01J15GQirtuS5h1Jigq7gN6+5eSe8TJtd4p3BbzaVk50DAB3TgZ6hCV
         e0fAKE8evZqczTA1vZgHYCY3SUF6QxsB38+BQheFLcx9mC5WzHz7MiS8rqbtcJ2KbisS
         FECE62rrv0dLA/3KNgNjnCZs2I9gp2U7x4HsUJznnta7a+OADPzx9FRMnOJ9bOwoW8Wg
         qZZQ==
X-Gm-Message-State: AOJu0YzPjQVcb0Es0iP05z3/HfMqJuBfNx7E26E/lcWigioNE6fs9qwI
        htrwkrhVusq8DGaHInwwFDc8kyoaILeqmt6jJrHT
X-Google-Smtp-Source: AGHT+IHawGS/nKRDttCxOnrm1x8BXzTA2XAn8KgNoxMYw1zp7u1qR9XjUrId+1wAC3oM/0hcr3zcIpekfA405SgCO1s=
X-Received: by 2002:a05:600c:3b82:b0:400:c6de:6a20 with SMTP id
 n2-20020a05600c3b8200b00400c6de6a20mr38797wms.3.1696300341777; Mon, 02 Oct
 2023 19:32:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230929023737.1610865-1-maheshb@google.com> <CANDhNCqb5JzEDOdAnocanR2KFbokrpMOL=iNwY3fTxcn_ftuZQ@mail.gmail.com>
 <CAF2d9jgeGLCzbFZhptGzpUnmMgLaRysyzBmpZ+dK4sxWdmR5ZQ@mail.gmail.com>
 <CANDhNCro+AQum3eSmKK5OTNik2E0cFxV_reCQg0+_uTubHaDsA@mail.gmail.com>
 <CANDhNCryn8TjJZRdCvVUj88pakHSUvtyN53byjmAcyowKj5mcA@mail.gmail.com> <CAF2d9jg4Oxm3NwDuh21eeKC5-m7umZM3XLuxUKcFkchFjTgTtQ@mail.gmail.com>
In-Reply-To: <CAF2d9jg4Oxm3NwDuh21eeKC5-m7umZM3XLuxUKcFkchFjTgTtQ@mail.gmail.com>
From:   John Stultz <jstultz@google.com>
Date:   Mon, 2 Oct 2023 19:32:10 -0700
Message-ID: <CANDhNCp_BvN5GMGjLnZTKQBXwVAn72CuMkCwK9LhhjNGTmujzQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] time: add ktime_get_cycles64() api
To:     =?UTF-8?B?TWFoZXNoIEJhbmRld2FyICjgpK7gpLngpYfgpLYg4KSs4KSC4KSh4KWH4KS14KS+4KSwKQ==?= 
        <maheshb@google.com>
Cc:     Netdev <netdev@vger.kernel.org>,
        Linux <linux-kernel@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Don Hatchett <hatch@google.com>,
        Yuliang Li <yuliangli@google.com>,
        Mahesh Bandewar <mahesh@bandewar.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 2, 2023 at 5:13=E2=80=AFPM Mahesh Bandewar (=E0=A4=AE=E0=A4=B9=
=E0=A5=87=E0=A4=B6 =E0=A4=AC=E0=A4=82=E0=A4=A1=E0=A5=87=E0=A4=B5=E0=A4=BE=
=E0=A4=B0)
<maheshb@google.com> wrote:
>
> On Fri, Sep 29, 2023 at 12:07=E2=80=AFAM John Stultz <jstultz@google.com>=
 wrote:
> >
> > On Thu, Sep 28, 2023 at 11:56=E2=80=AFPM John Stultz <jstultz@google.co=
m> wrote:
> > > On Thu, Sep 28, 2023 at 11:35=E2=80=AFPM Mahesh Bandewar (=E0=A4=AE=
=E0=A4=B9=E0=A5=87=E0=A4=B6 =E0=A4=AC=E0=A4=82=E0=A4=A1=E0=A5=87=E0=A4=B5=
=E0=A4=BE=E0=A4=B0)
> > > <maheshb@google.com> wrote:
> > > > On Thu, Sep 28, 2023 at 10:15=E2=80=AFPM John Stultz <jstultz@googl=
e.com> wrote:
> > > > > 3) Nit: The interface is called ktime_get_cycles64 (timespec64
> > > > > returning interfaces usually are postfixed with ts64).
> > > > >
> > > > Ah, thanks for the explanation. I can change to comply with the
> > > > convention. Does ktime_get_cycles_ts64() make more sense?
> > >
> > > Maybe a little (it at least looks consistent), but not really if
> > > you're sticking raw cycles in the timespec :)
> > >
> >
> > Despite my concerns that it's a bad idea, If one was going to expose
> > raw cycles from the timekeeping core, I'd suggest doing so directly as
> > a u64 (`u64 ktime_get_cycles(void)`).
> >
> > That may mean widening (or maybe using a union in) your PTP ioctl data
> > structure to have a explicit cycles field.
> > Or introducing a separate ioctl that deals with cycles instead of times=
pec64s.
> >
> > Squeezing data into types that are canonically used for something else
> > should always be avoided if possible (there are some cases where
> > you're stuck with an existing interface, but that's not the case
> > here).
> >
> > But I still think we should avoid exporting the raw cycle values
> > unless there is some extremely strong argument for it (and if we can,
> > they should be abstracted into some sort of cookie value to avoid
> > userland using it as a raw clock).
> >
> Thanks for the input John. This change is basically to address the API
> gap and allow it to give a user-given timebase for the sandwich time.
> I will remove this RAW-CYCLES option for now. If it's deemed
> necessary, we can always add it later into the same API.

Sounds reasonable to me.

thanks
-john
