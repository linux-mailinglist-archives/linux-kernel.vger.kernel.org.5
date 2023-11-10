Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40B2D7E833D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 20:58:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345945AbjKJTy4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 14:54:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346572AbjKJTyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 14:54:40 -0500
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A06931FEE
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 11:51:45 -0800 (PST)
Received: by mail-vs1-xe32.google.com with SMTP id ada2fe7eead31-45ef8c21e8aso1074258137.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 11:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699645905; x=1700250705; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1XHT4YSLzPD/E8aj03B/6V64jSf/rAM4u8ZPBVxJtgk=;
        b=gJsUryOieQmHFPWcN/IIO8N7qMephByNSoGaukKAWSWqNu/TlgsUndtml3Kkzk8bEE
         C/W7GbrFNZUHfUiJeinPf5PQU1j3nu+yTa73g5fkLsmmDmhBgq8pPdZgTU+kW/AzvFBS
         eXKVP6yQh2WFUgO/djQj9KStxPogP/gcUcYQ04kB8Lk/SO8EubIh5I5sZGUF5l4R/reL
         q/UCQkC97bH80CIcj4ikhMjf0QgPzaS0VxUozKqilRLkzZeGHNEXvT+KNO4RxWGJU9Fa
         dzn6cVlgoOryHcgKNfhUAesuXBxxVn4sfaFuTVy4LOoCxiEBV7vlQ5E55T6E+mPDKkdH
         JL5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699645905; x=1700250705;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1XHT4YSLzPD/E8aj03B/6V64jSf/rAM4u8ZPBVxJtgk=;
        b=oB+aNDg24NtVMAduVzZvoFj2vZX/HU/yzaoKKiGxLitR/3gAPSKEMVeE95DOgIqqIq
         xizPKR5a3L3QBJC+6HntHJh6cFIPFw7U3kNtoBsp1jfJShwFeJnab7Tk3fMnJJlMTJsl
         V7Me/Ex9BNbgPafcSZdmQLjZxEIC/MdUJJbRYjdJSFB/3AOb5Ra0CGP9De002jYhnH+C
         62eTasAMEx6E3jtq5x7LH17ZWqiOv5RCUiegKof85QogHk3gwG1tq0muRpA8CMwOeMzs
         mtP7lhNvMdtGJAB7aIRzVBNmJSuTyHbpNlm/uLXpIJ+sCOULUvUSVHM/3wG+BpkktDVt
         EiYw==
X-Gm-Message-State: AOJu0YyGXe2wholCqbIa3R9vE+ksjrgy2pYStVqx7G9F2LbPw9KdbvyN
        lYa+7p8oaO+yvLSiSsN95R7pKRIukq0IKfFHWMA=
X-Google-Smtp-Source: AGHT+IGIoxi8Adc0PKUN/X2JFJaZMPpzAtI9aV0sUTO+URwu3Mk2KEMp+ocOENtvW0QERXWv1U+hrhrMiRxCx6HEu6c=
X-Received: by 2002:a05:6102:94b:b0:45d:987d:debe with SMTP id
 a11-20020a056102094b00b0045d987ddebemr475932vsi.3.1699645904678; Fri, 10 Nov
 2023 11:51:44 -0800 (PST)
MIME-Version: 1.0
References: <20231103131011.1316396-1-lb@semihalf.com> <20231103131011.1316396-11-lb@semihalf.com>
 <CAJfuBxxVGaqG4wVu-kM3ynA8ARTD6DFPBuz0a1GqunMqdvRBgQ@mail.gmail.com> <CAK8ByeL9UJzNr=kAdyHZcdt6-B8c57OxUW+ccm4GmLrW26CxDg@mail.gmail.com>
In-Reply-To: <CAK8ByeL9UJzNr=kAdyHZcdt6-B8c57OxUW+ccm4GmLrW26CxDg@mail.gmail.com>
From:   jim.cromie@gmail.com
Date:   Fri, 10 Nov 2023 12:51:18 -0700
Message-ID: <CAJfuBxxTuiEun9YFtWY_99nvCwnJQ_LByJioOTxsCkMS6URQnw@mail.gmail.com>
Subject: Re: [PATCH v1 10/12] dyndbg: add processing of T(race) flag argument
To:     =?UTF-8?Q?=C5=81ukasz_Bartosik?= <lb@semihalf.com>
Cc:     Jason Baron <jbaron@akamai.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Guenter Roeck <groeck@google.com>,
        Yaniv Tzoreff <yanivt@google.com>,
        Benson Leung <bleung@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Pekka Paalanen <ppaalanen@gmail.com>,
        Sean Paul <seanpaul@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        upstream@semihalf.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 10, 2023 at 7:52=E2=80=AFAM =C5=81ukasz Bartosik <lb@semihalf.c=
om> wrote:
>
> sob., 4 lis 2023 o 04:06 <jim.cromie@gmail.com> napisa=C5=82(a):
> >
> > On Fri, Nov 3, 2023 at 7:10=E2=80=AFAM =C5=81ukasz Bartosik <lb@semihal=
f.com> wrote:
> > >
> > > Add processing of argument provided to T(race) flag.
> > > The argument value determines destination of debug logs:
> > >
> > > 0 - debug logs will be written to prdbg and devdbg trace events
> > > [1..255] - debug logs will be written to trace instance
> > >
> > > A user can provide trace destination by folowing T flag with
> > > ":" and trace destination value in range [0..255], for example:
> > >
> > > echo "module thunderbolt =3DpT:7" > /sys/kernel/debug/dynamic_debug/c=
ontrol
> > > echo "module thunderbolt =3DlT:7,p" > /sys/kernel/debug/dynamic_debug=
/control
> > >
> > > When T flag with argument is followed by other flags then the next fl=
ag has
> > > to be preceded with ",".
> > >
> >
> > the trailing , seems punctuation heavy.
> > Could we just stipulate that any :string  (leading : trailing anything)
> > be the last flag in the spec ?
> > bare T flags are not constrained otherwise.
> > seems fine as API-spec-by-error-codes.
> >
>
> I followed Jason's suggestion to use "," when T flag is not the last
> flag and destination is explicitly provided for the T flag, like in
> the example above
> "echo "module thunderbolt =3DlT:7,p" > /sys/kernel/debug/dynamic_debug/co=
ntrol".
>
> With "," we can have the following cases:
> - when T is the last flag then it doesn't need to be followed by ","
> even if destination is explicitly provided, for example "lpT:7",
> - when T is not the last flag and destination is explicitly provided
> then "," has to be used before next flag, for example "lT:7,p",
> - when T is not the last flag and destination is not explicitly
> provided then "," is not required, for example "lTp",
>
> Jim, Jason, would you please come to terms if we want to use "," or
> just assume that T has to be the last flag in the spec ?
>

Im fine either way -   eliminating punctuation has a cost too,
it adds some order dependency which isnt there now.
If that complicates the code, no-good.


> >
> >
> >
> > > When no value is provided trace destination defaults to 0, for exampl=
e:

That seems wrong now - it should default to whatever it was previously set =
to,

this allows setting a non-default dest while disabling the site:
   echo class DRM_UT_CORE -T:core-log  > /proc/dynamic_debug/control

then just enabling it later, to use the preset dest
   echo class DRM_UT_CORE +T  > /proc/dynamic_debug/control
or more likely:
   echo 0x01 > /sys/module/drm/parameters/debug_trace

this way, debug_trace is just like debug, but still can write to the
separate trace-instances

> > >
> > > echo "module thunderbolt =3DT" > /sys/kernel/debug/dynamic_debug/cont=
rol
> > > echo "module thunderbolt =3DlTp" > /sys/kernel/debug/dynamic_debug/co=
ntrol
> >
> > no colon after T means p is a flag, not a destination name
>
> Yes, in this case p is a flag because when T is not followed
> explicitly by destination then next character would be treated as
> another flag.
