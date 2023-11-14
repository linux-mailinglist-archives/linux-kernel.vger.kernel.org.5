Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 611A27EA81A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 02:08:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbjKNBIv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 20:08:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjKNBIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 20:08:49 -0500
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F265D51
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 17:08:46 -0800 (PST)
Received: by mail-vs1-xe35.google.com with SMTP id ada2fe7eead31-45ef8c21e8aso2056204137.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 17:08:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699924125; x=1700528925; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AGgQXmlApHAVakndCGgpAS18nj7Grq29NxlZqQQt5zY=;
        b=FtBo1msq5pjyk7NfNj+4F3qLg5XZMr7Vs/Jb8uhO7UFTomjMaFoaD6YqL63nRYZ4lM
         px9zVNcskKmezLXq4s7S1vM6TLxV2cOO6gpeuZLggMoMNAdm1nDStvsc57iBrVCzPLAD
         xqmcWQq1TodVa8/yEG6I4yIFylwWegFBrk7M8ngxTz1huSL3SroSYnRL3GZ2gpZntWij
         BQkRjXhPEqcEIUwub0XcHiq77Arv8ERRyeq4MeIH0H3gKuLeXU1l2R3bFLwJUcz1a5Du
         3hcPmUSzocnC2mS1IekWjgiShTm4QM08nJDeR0Kqtj/W8wYLa9s/7LbwJbE0sTg5fb26
         s7OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699924125; x=1700528925;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AGgQXmlApHAVakndCGgpAS18nj7Grq29NxlZqQQt5zY=;
        b=R9B1VZy9eCS7b6mQf4v3uQfxlv2BzChSzCr7mAVxxB8M6EZ13y7Rc//ITrWej9rCpg
         Jj/VTtoNmT+Hx9MeZt3ZXxwDTtUtmh5arPPa+OK8hKLeE2o2SeP/mxzoar3zvtrg4nXw
         LbEYyzdWA/dlbSgYJhxY2MRBMSISTJqXFnOUcWj4GQTcKObG5vYEg9tDi2CtGXA2nApH
         /X1Bl4qYbPVNZqBvtCpMxtZbP1ebsMhlT6pciK8wAitEzrlveGd6StCOkdViIDYFyrlq
         UXz7fwdcT6xhW0ZvzasQvOFfoUrvu1XPAioRJLkaRpagmS1DXmjWyKeykGGTxD/yymz6
         XAxw==
X-Gm-Message-State: AOJu0YxN05R8rw9QC4J+EoLgAa8lnmpQoWH9mCaNqIx2vL81vNIsdMxK
        iZI0eWMBiou4AWKBWvf3w2BrOe+cKv6t9ARGRoM=
X-Google-Smtp-Source: AGHT+IF8jYbSt5snceu5F/A9kPLTXsHKQYKG50Xw7E9vvr1iYOo5ZzVPGns73PHf3MmTahQRX2vCOuaQMiDZyH+xrvA=
X-Received: by 2002:a67:e15a:0:b0:45d:7671:8253 with SMTP id
 o26-20020a67e15a000000b0045d76718253mr7563463vsl.13.1699924125226; Mon, 13
 Nov 2023 17:08:45 -0800 (PST)
MIME-Version: 1.0
References: <20231103131011.1316396-1-lb@semihalf.com> <20231103131011.1316396-12-lb@semihalf.com>
 <CAJfuBxzhz7pBYkfqfPomH4PUzqLPX1nxsev4yrQ2P6m5hyMT+Q@mail.gmail.com>
 <CAK8ByeJ1fYSVaVQz3tERzj_5QNAN4Ggx850pKcAG3vhsoWnS+w@mail.gmail.com>
 <CAJfuBxyu3VqakFNr4mW0h4QiPVSf-7HSPXobGO2_qC-H8yLgcw@mail.gmail.com>
 <CAK8ByeL1WwdVKSMtGfbHZLfYm73ZwjiEbtNZJiWur-spMc74Zg@mail.gmail.com>
 <CAJfuBxz1=9o06Rj_mX-2aZXhCSF7rKxyusayPiy4RuJZ7qKbQw@mail.gmail.com> <CAK8ByeJH8vKUxeM21ME0vYjKmC_Z=P8XsKiB42k95iZ09bJXJg@mail.gmail.com>
In-Reply-To: <CAK8ByeJH8vKUxeM21ME0vYjKmC_Z=P8XsKiB42k95iZ09bJXJg@mail.gmail.com>
From:   jim.cromie@gmail.com
Date:   Mon, 13 Nov 2023 18:08:18 -0700
Message-ID: <CAJfuBxxw6DbmGG-UdiZeUr9680tJVEVcw-czPL+jt-88YUMgbw@mail.gmail.com>
Subject: Re: [PATCH v1 11/12] dyndbg: write debug logs to trace instance
To:     =?UTF-8?Q?=C5=81ukasz_Bartosik?= <lb@semihalf.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Jason Baron <jbaron@akamai.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Guenter Roeck <groeck@google.com>,
        Yaniv Tzoreff <yanivt@google.com>,
        Benson Leung <bleung@google.com>,
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

On Mon, Nov 13, 2023 at 4:44=E2=80=AFPM =C5=81ukasz Bartosik <lb@semihalf.c=
om> wrote:
>
> pon., 13 lis 2023 o 19:59 <jim.cromie@gmail.com> napisa=C5=82(a):
> >
> > On Sun, Nov 12, 2023 at 9:32=E2=80=AFAM =C5=81ukasz Bartosik <lb@semiha=
lf.com> wrote:
> > >
> > > pt., 10 lis 2023 o 21:03 <jim.cromie@gmail.com> napisa=C5=82(a):
> > > >
> > > > On Fri, Nov 10, 2023 at 7:53=E2=80=AFAM =C5=81ukasz Bartosik <lb@se=
mihalf.com> wrote:
> > > > >
> > > > > sob., 4 lis 2023 o 22:49 <jim.cromie@gmail.com> napisa=C5=82(a):
> > > > > >
> > > > > > On Fri, Nov 3, 2023 at 7:10=E2=80=AFAM =C5=81ukasz Bartosik <lb=
@semihalf.com> wrote:
> > > > > > >
> > > > > > > When trace is enabled (T flag is set) and trace_dst field is =
set
> > > > > > > to value greater than 0 (0 is reserved for trace events) then
> > > > > > > debug logs will be written to trace instance pointed by trace=
_dst
> > > > > > > value, for example when trace_dst value is 2 then debug logs =
will
> > > > > > > be written to <debugfs>/tracing/instances/dyndbg_inst_2 insta=
nce.
> > > > > > > Given trace instance will not be initialized until debug logs=
 are
> > > > > > > requested to be written to it and afer init will persist unti=
l
> > > > > > > reboot.
> > > > > > >
> > > > > >
> > > > > > restating 00 comments -
> > > > > >
> > > > > > you can get rid of integer destination ids by adding a new comm=
and: open/close
> > > > > >
> > > > > > $> echo  \
> > > > > >  open kms-instance \;\
> > > > > >  class DRM_UT_KMS -T:kms-instance  # preset-dests-disable-sites=
 \;\
> > > > > > > /proc/dynamic_debug/control
> > > > > >
> > > > >
> > > > > Instead of using above command to preset destination we could pre=
set
> > > > > destination with open command. I mean last successful
> > > > > open would preset destination ? What do you think ?
> > > > >
> > > >
> > > > I dont think it works - if open maps to a dest-number, (or implicit=
 as
> > > > TOP-of-stack)
> > > > then you just have +T<dest-number>  (or +T <implicit tos>)
> > > > rather than +T:dest-name
> > > > and you still have to keep track of what dest-numbers were already =
used.
> > > > (or every new dest needs an explicit OPEN before it)
> > > >
> > > > and how do you then get back to default instance ?
> > > > open 0 ?
> > > > close <previous-handle> ?
> > > >
> > > >
> > > > by using names, all opens can be at the top,
> > > > (and thus document in 1 block all the named-instances)
> > > > and any named dest that hasnt been opened is an error
> > > > (not just reusing previous OPEN)
> > > >
> > >
> > > Sorry, I should have been more specific with my proposal. Let me use
> > > an example to clarify it:
> > > open usb    # -> create trace instance "usb" and make it default
> > > echo module usbcore +T > /proc/dynamic_debug/control ## --> write usb=
core
> > > ## debug logs to trace instance named usb
> > > open tbt --> create trace instance "tbt" and make it default
> > > echo module aaa +T:usb > /proc/dynamic_debug/control --> write aaa
> > > debug logs to trace instance named usb, instance usb has to be used
> > > explicitly
> > >
> > >                          because now tbt is default trace instance
> >
> > that feels too magical/ action at a distance.
> >
> > ISTM it also muddles what the "default" is:
> >
> > my-default:
> > what each callsite's current/preset dest is/was
> > the only way to set it is with explicit [-+]T:outstream
> >
>
> I see your point, I will follow your suggestion.
>
> > your-default:
> > whatever was last opened. whether it was 2 or 50 lines above,
> > or set weeks ago, the last time somebody opened an instance.
> >
> > and as more instances are created
> > (potentially by different users?
> > after all there are separate instances,
> > and presumably separate interests),
> > the default gets less predictable.
> >
> >
> > > echo module bbb +T > /proc/dynamic_debug/control --> write bbb debug
> > > logs to trace instance named tbt
> > > close tbt --> close tbt trace instance, I omit this step but in order
> > > for an instance to be successful closed it must not be used by any
> > > callsite, after
> > >                     closing tbt instance the usb becomes default inst=
ance
> >
> > so after 'close tbt',  the previous 'open usb' is now top-of-stack ?
> >
> > how does that affect all existing callsite-users of tbt ?
> > do they continue to use the trace-instance theyve been writing to ?
> > If not, then reverting to the global instance seems much more predictab=
le.
> >
> > Or are you proposing that the close fails because the instance is still=
 in use ?
> > this seems least surprising,
> > and more robust in the face of the next 'open foo'
> > which could otherwize reuse the dst_id mapped to tbt
> >
> >
> > >
> > > I agree that your method of setting default trace instance is more fl=
exible:
> > > class DRM_UT_KMS -T:kms-instance  # preset-dests-disable-sites
> > >
> > > Maybe we can combine both to set default trace destination ?
> > >
> > > Also I think we need a reserved keyword for writing debug logs to
> > > trace events - maybe "event" keyword ?
> >
> > do you mean "event" as a selector, like module, function, class, etc ?
> > if so, what are the values ?
> > any event under  /sys/kernel/debug/tracing/events/ ?
> >
> > how does this get used ?
> >
>
> I meant that we need to reserve name/keyword to enable writing debug
> logs to trace events (prdbg and devdbg), for example
> echo module usbcore +T:event > /proc/dynamic_debug/control
>
> Or do you anticipate other way to do it ?

way back, when I had even fewer clues,
I sent patches to call trace-printk when +T was set.
Steve didnt like it, I think cuz it could flood the tracebuf.

Thats why I added the prdbg and devdbg event-types,
so that they could be disabled easily using /sys/kernel/debug/tracing/
putting them squarely under trace-control.

Note that this puts 2 off-switches in series,
both tracefs and >control can disable all the pr_debug traffic,
tracefs by event-type, and >control at individual callsite level.

echo 1 > /sys/kernel/debug/tracing/dyndbg/enable
echo 1 > /sys/kernel/debug/tracing/dyndbg/prdbg/enable
echo 1 > /sys/kernel/debug/tracing/dyndbg/devdbg/enable

I briefly thought about linking the 2 off-switches,
but punted cuz I thought it complicated things,
(how exactly would they get coupled?)
and I didnt want to distract from larger goals

Does that address your question ?

On a related point, I also added drm_dbg and drm_devdbg.
Those are issued from __drm_dbg & __drm_dev_dbg
 respectively when CONFIG_DRM_USE_DYNAMIC_DEBUG=3Dn.

Im not sure theyre more useful than confusing yet.

>
> > >
> > >
> > > >
> > > > > >
> > > > > > and +T  w/o dest means use existing setting, not just 0 (unless=
 thats
> > > > > > the existing setting)
> > > > > >
> > > > >
> > > > > Sounds good.
> > > > >
> > > >
> > > > :-)
