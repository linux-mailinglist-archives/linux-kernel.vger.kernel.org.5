Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0D5C7EDD5A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 10:05:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235283AbjKPJF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 04:05:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235471AbjKPJFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 04:05:55 -0500
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B41BD1B9
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 01:05:51 -0800 (PST)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-5a7eef0b931so6075117b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 01:05:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700125551; x=1700730351; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CJvcy5OQThQMBzLC/CmhcyXSfL+uAyptQQ2e5phxAM4=;
        b=oWrSP1IlUTG1W8C2Vn3MDQRkcOkQC47jhTsbJE/syle+x2E7pLk8YH73UqsmtyCF5X
         wjMY1VnB609yWCdmQTbYSx6hEvgz9PlngiYT2pBwgpQSS1+4lNcph9dOwAmspD512EoA
         DyHUWd9wOherKtEvRiHolu3BRIZ9y9+IRZIIiP2S57xykxHFJkkVZyhOesC0+tL4jxIN
         7wgNrnGeECevzbZc3Us2+uMI2bErIcqBxMq8Kz8bYRmxIj97dJbe22z0hEPSYaSEBXbh
         w2FcIamjnoB00s5iy8eJtvDXW8ynQlsWRawCX7xBaPUoQ6LguUMaS3AavD7Q9sUsyuBD
         oB0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700125551; x=1700730351;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CJvcy5OQThQMBzLC/CmhcyXSfL+uAyptQQ2e5phxAM4=;
        b=Ui8wlZ+8nSAQGtbXLXm2wIEjl+Bh0x/q9wzVKsO9t3BRa5m6LQlUoYsdJwcaWVXgQg
         GixhDPOsvzK2cHtWF77jUolXM0cbrqVMH5PUH9Uo0wEfaIKiI4g7IIhFEJTInrgKy56H
         nIZJL84oTbUJ/XfyswiwZRp844bD9hcM2GvTMQHopetiPRSMEVm4mxY/PamiwmVrxTIp
         7hltHw+Gozo/AneWvsGgsVdZ6f73iwU5y9VZMBDRVWgsR26tjBfZR5uVaXH08MnHoQeI
         dVTtd41oMZb/EnmDTcFslHa65iwh8FWsRfjdLlbvVhiq5nUHw8GdJ0isgXGdfSUwZCkX
         QeTg==
X-Gm-Message-State: AOJu0Yx8Cawaviy/L9K0cwlLsp85rDfGgoUQuZlUqsLSPL3E6iLHMTXg
        oMy4j1YVCF8NNrgtxKuJAUbhI2q7qh94Z6qa/aRRAA==
X-Google-Smtp-Source: AGHT+IGJR4QLM16FKTPZT3Tz/J1QFBPNhj+bwePlZEFgi7iCb5pKMX+w3+XgoMz2yIXIyLcBCWd/7G270rmy6YIVNjQ=
X-Received: by 2002:a81:8a41:0:b0:5a8:3f0a:618e with SMTP id
 a62-20020a818a41000000b005a83f0a618emr16007472ywg.37.1700125550745; Thu, 16
 Nov 2023 01:05:50 -0800 (PST)
MIME-Version: 1.0
References: <20231115203401.2495875-1-iii@linux.ibm.com> <20231115203401.2495875-31-iii@linux.ibm.com>
 <CAG_fn=WW1BUehMSsbjtPb4gKpakLGi3bF2KFEPxE4dV7n1ToSQ@mail.gmail.com>
In-Reply-To: <CAG_fn=WW1BUehMSsbjtPb4gKpakLGi3bF2KFEPxE4dV7n1ToSQ@mail.gmail.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 16 Nov 2023 10:05:14 +0100
Message-ID: <CAG_fn=XftAnT0=kxkjGrtn9QEye1Xayg_jw3Fk_cy6SforMTpg@mail.gmail.com>
Subject: Re: [PATCH 30/32] s390/unwind: Disable KMSAN checks
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexander Gordeev <agordeev@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Marco Elver <elver@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Pekka Enberg <penberg@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-s390@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Sven Schnelle <svens@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 16, 2023 at 10:04=E2=80=AFAM Alexander Potapenko <glider@google=
.com> wrote:
>
> On Wed, Nov 15, 2023 at 9:35=E2=80=AFPM Ilya Leoshkevich <iii@linux.ibm.c=
om> wrote:
> >
> > The unwind code can read uninitialized frames. Furthermore, even in
> > the good case, KMSAN does not emit shadow for backchains. Therefore
> > disable it for the unwinding functions.
> >
> > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > ---
> >  arch/s390/kernel/unwind_bc.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/arch/s390/kernel/unwind_bc.c b/arch/s390/kernel/unwind_bc.=
c
> > index 0ece156fdd7c..7ecaab24783f 100644
> > --- a/arch/s390/kernel/unwind_bc.c
> > +++ b/arch/s390/kernel/unwind_bc.c
> > @@ -49,6 +49,7 @@ static inline bool is_final_pt_regs(struct unwind_sta=
te *state,
> >                READ_ONCE_NOCHECK(regs->psw.mask) & PSW_MASK_PSTATE;
> >  }
> >
> > +__no_kmsan_checks
>
> Please add some comments to the source file to back this annotation,
> so that the intent is not lost in git history.

Apart from that,

Reviewed-by: Alexander Potapenko <glider@google.com>


--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
