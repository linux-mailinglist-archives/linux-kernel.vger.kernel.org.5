Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1E587EA724
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 00:45:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbjKMXoq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 18:44:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjKMXop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 18:44:45 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1835B8F
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 15:44:41 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-53e08b60febso7703964a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 15:44:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google; t=1699919079; x=1700523879; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/TRNoBdB113ZlUaU1dCsk0X8MgsinAA1RqdwQHwf2Pc=;
        b=Cs30ESf7wcveIzKD446+z9VeU3Xzpcl3/tzzVCxcPslYz17OFwEwwh4J5rbHHSnera
         Kpwr24Ek2sXx77mOsiYbqDuQFPGQv7BUyplhwJnWsfwD1JbXsr2A+ISGVj+PbVHOCXdX
         ZtwXzlTTRQI6RN8+c6eLye8/MLIREHm+ijUk7yfQKtg5I0AiriTSLURkZtMJaeAvPzNl
         mW1Q5CBQ1xlDBi9k9B6K+j3wL1/Yiiiy29UhYz09ytOz0E6B1zKVu0skj4vAqFmB9RSF
         FX7EGR52InVd2pLdMweXM0AXR7VuptTvhNIEq9VrADS0K/q7kak0OR0SA9oytfcgHKOR
         dy2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699919079; x=1700523879;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/TRNoBdB113ZlUaU1dCsk0X8MgsinAA1RqdwQHwf2Pc=;
        b=JKkEH7dWls6WNcPyqLFK1MWUlvi32+QvxeRQnFBvJl2a2Uqz7A5rt6wdVyI4Xc52QP
         d0BTitbF3+It/BJDji4Qt7cTdEikaSf9u4Nxn5bW7GQuDNdhSel5bfWZcaKGattr5lZn
         QUlb/F5+E3ZbBijCXVMJBdXHQOZNrHllC8jYyp6n17XheqmWKKU0sNAihcKyvcVnviXt
         3ftpyrlB1AvKvheHh1ubagFfl5TF40lONdttbpVJ+dNI/Fq0Hc9ak8Lzpc/mbIQ5CprE
         cs4hvzVOU1ipxTeox/6+fd1F/zZHryVFxrJ8w0dehJ1Tyx5Mj7//yPVSOk13WICgXR41
         5mGg==
X-Gm-Message-State: AOJu0YwBS6VtrSUP30/75mju1BaRiHWL8S5er7Y6pCq4qEZR0njL0a3M
        eYHdA5pDpac+amyM0o0kXO/HLIxfXOZ5QxTG5zPT
X-Google-Smtp-Source: AGHT+IGZTHB32j/FJ6pAdIZdK2kY6yGlQkolP8KB6jLuKdkYXgrrOqOLprv7WpSVuzl4q/rjC+bwKKk4ZcCzsagmf/A=
X-Received: by 2002:a05:6402:753:b0:543:f90:b956 with SMTP id
 p19-20020a056402075300b005430f90b956mr5330531edy.35.1699919079430; Mon, 13
 Nov 2023 15:44:39 -0800 (PST)
MIME-Version: 1.0
References: <20231103131011.1316396-1-lb@semihalf.com> <20231103131011.1316396-12-lb@semihalf.com>
 <CAJfuBxzhz7pBYkfqfPomH4PUzqLPX1nxsev4yrQ2P6m5hyMT+Q@mail.gmail.com>
 <CAK8ByeJ1fYSVaVQz3tERzj_5QNAN4Ggx850pKcAG3vhsoWnS+w@mail.gmail.com>
 <CAJfuBxyu3VqakFNr4mW0h4QiPVSf-7HSPXobGO2_qC-H8yLgcw@mail.gmail.com>
 <CAK8ByeL1WwdVKSMtGfbHZLfYm73ZwjiEbtNZJiWur-spMc74Zg@mail.gmail.com> <CAJfuBxz1=9o06Rj_mX-2aZXhCSF7rKxyusayPiy4RuJZ7qKbQw@mail.gmail.com>
In-Reply-To: <CAJfuBxz1=9o06Rj_mX-2aZXhCSF7rKxyusayPiy4RuJZ7qKbQw@mail.gmail.com>
From:   =?UTF-8?Q?=C5=81ukasz_Bartosik?= <lb@semihalf.com>
Date:   Tue, 14 Nov 2023 00:44:26 +0100
Message-ID: <CAK8ByeJH8vKUxeM21ME0vYjKmC_Z=P8XsKiB42k95iZ09bJXJg@mail.gmail.com>
Subject: Re: [PATCH v1 11/12] dyndbg: write debug logs to trace instance
To:     jim.cromie@gmail.com
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
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pon., 13 lis 2023 o 19:59 <jim.cromie@gmail.com> napisa=C5=82(a):
>
> On Sun, Nov 12, 2023 at 9:32=E2=80=AFAM =C5=81ukasz Bartosik <lb@semihalf=
.com> wrote:
> >
> > pt., 10 lis 2023 o 21:03 <jim.cromie@gmail.com> napisa=C5=82(a):
> > >
> > > On Fri, Nov 10, 2023 at 7:53=E2=80=AFAM =C5=81ukasz Bartosik <lb@semi=
half.com> wrote:
> > > >
> > > > sob., 4 lis 2023 o 22:49 <jim.cromie@gmail.com> napisa=C5=82(a):
> > > > >
> > > > > On Fri, Nov 3, 2023 at 7:10=E2=80=AFAM =C5=81ukasz Bartosik <lb@s=
emihalf.com> wrote:
> > > > > >
> > > > > > When trace is enabled (T flag is set) and trace_dst field is se=
t
> > > > > > to value greater than 0 (0 is reserved for trace events) then
> > > > > > debug logs will be written to trace instance pointed by trace_d=
st
> > > > > > value, for example when trace_dst value is 2 then debug logs wi=
ll
> > > > > > be written to <debugfs>/tracing/instances/dyndbg_inst_2 instanc=
e.
> > > > > > Given trace instance will not be initialized until debug logs a=
re
> > > > > > requested to be written to it and afer init will persist until
> > > > > > reboot.
> > > > > >
> > > > >
> > > > > restating 00 comments -
> > > > >
> > > > > you can get rid of integer destination ids by adding a new comman=
d: open/close
> > > > >
> > > > > $> echo  \
> > > > >  open kms-instance \;\
> > > > >  class DRM_UT_KMS -T:kms-instance  # preset-dests-disable-sites \=
;\
> > > > > > /proc/dynamic_debug/control
> > > > >
> > > >
> > > > Instead of using above command to preset destination we could prese=
t
> > > > destination with open command. I mean last successful
> > > > open would preset destination ? What do you think ?
> > > >
> > >
> > > I dont think it works - if open maps to a dest-number, (or implicit a=
s
> > > TOP-of-stack)
> > > then you just have +T<dest-number>  (or +T <implicit tos>)
> > > rather than +T:dest-name
> > > and you still have to keep track of what dest-numbers were already us=
ed.
> > > (or every new dest needs an explicit OPEN before it)
> > >
> > > and how do you then get back to default instance ?
> > > open 0 ?
> > > close <previous-handle> ?
> > >
> > >
> > > by using names, all opens can be at the top,
> > > (and thus document in 1 block all the named-instances)
> > > and any named dest that hasnt been opened is an error
> > > (not just reusing previous OPEN)
> > >
> >
> > Sorry, I should have been more specific with my proposal. Let me use
> > an example to clarify it:
> > open usb    # -> create trace instance "usb" and make it default
> > echo module usbcore +T > /proc/dynamic_debug/control ## --> write usbco=
re
> > ## debug logs to trace instance named usb
> > open tbt --> create trace instance "tbt" and make it default
> > echo module aaa +T:usb > /proc/dynamic_debug/control --> write aaa
> > debug logs to trace instance named usb, instance usb has to be used
> > explicitly
> >
> >                          because now tbt is default trace instance
>
> that feels too magical/ action at a distance.
>
> ISTM it also muddles what the "default" is:
>
> my-default:
> what each callsite's current/preset dest is/was
> the only way to set it is with explicit [-+]T:outstream
>

I see your point, I will follow your suggestion.

> your-default:
> whatever was last opened. whether it was 2 or 50 lines above,
> or set weeks ago, the last time somebody opened an instance.
>
> and as more instances are created
> (potentially by different users?
> after all there are separate instances,
> and presumably separate interests),
> the default gets less predictable.
>
>
> > echo module bbb +T > /proc/dynamic_debug/control --> write bbb debug
> > logs to trace instance named tbt
> > close tbt --> close tbt trace instance, I omit this step but in order
> > for an instance to be successful closed it must not be used by any
> > callsite, after
> >                     closing tbt instance the usb becomes default instan=
ce
>
> so after 'close tbt',  the previous 'open usb' is now top-of-stack ?
>
> how does that affect all existing callsite-users of tbt ?
> do they continue to use the trace-instance theyve been writing to ?
> If not, then reverting to the global instance seems much more predictable=
.
>
> Or are you proposing that the close fails because the instance is still i=
n use ?
> this seems least surprising,
> and more robust in the face of the next 'open foo'
> which could otherwize reuse the dst_id mapped to tbt
>
>
> >
> > I agree that your method of setting default trace instance is more flex=
ible:
> > class DRM_UT_KMS -T:kms-instance  # preset-dests-disable-sites
> >
> > Maybe we can combine both to set default trace destination ?
> >
> > Also I think we need a reserved keyword for writing debug logs to
> > trace events - maybe "event" keyword ?
>
> do you mean "event" as a selector, like module, function, class, etc ?
> if so, what are the values ?
> any event under  /sys/kernel/debug/tracing/events/ ?
>
> how does this get used ?
>

I meant that we need to reserve name/keyword to enable writing debug
logs to trace events (prdbg and devdbg), for example
echo module usbcore +T:event > /proc/dynamic_debug/control

Or do you anticipate other way to do it ?

> >
> >
> > >
> > > > >
> > > > > and +T  w/o dest means use existing setting, not just 0 (unless t=
hats
> > > > > the existing setting)
> > > > >
> > > >
> > > > Sounds good.
> > > >
> > >
> > > :-)
