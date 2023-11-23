Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A94EA7F59F3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 09:25:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344911AbjKWIZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 03:25:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231394AbjKWIZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 03:25:47 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D05F8B9
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 00:25:53 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-5bd33a450fdso457064a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 00:25:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1700727953; x=1701332753; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x8iwBupcT3hR7TdREkRDPApB+NZD7yQfnGBIetxepY8=;
        b=HwewnmTDU+TaGctNuyEZlsupUfleH3vyZVoceoHrO71OO0lz7cgma6oSZIbX3VpeCF
         5AXcAilJCOLJaz5IZBXQtOdEDSgH9O7E0ECJ8UGC7PvXb3GpsR5vejYObusPpjrikvtp
         3ZnTUH9C0+Ff8tYL2Y9OzD/7mx+025ZV5/vX7726bcdleJz+Ds2IKbZV7pksloSlD8Jj
         SDpAarYFeTHoxyVFFrvs8ZJl8y2p0UGxKBQWcch2CTvSTZZFYBBUPyLHfmwWPEslgqZB
         fGPRnn7lpi8tPThI9LlQ7pwgKc3qjhhs5NUTF0MLCtDmGwNxLs8HuSnTJK0p3YmEJnHR
         M4GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700727953; x=1701332753;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x8iwBupcT3hR7TdREkRDPApB+NZD7yQfnGBIetxepY8=;
        b=wkkGa6qtWf11uyTpHIRFz8nZynxNu89fcrqWR2E1eotVWBaXYRkNTiLcUU8E8pWr77
         cO+4bu9Y2ZOS07U55sNci/IDY9oTh4MUusmLb2a7FMUA3z6pA6/uHke0jpiGt1tcoJVr
         B8dXnVX9XGEXhrxd9ny/aepOIJv/hYZ+rgfy3FJeSU0+AXVcRhGtgaLodRTw519/mxtC
         oh+iTN/E36qywgTxZORK3pk4yAbmhnEW1NvHV99Pef3mPdhnSZvcNlsbbGpYUn0ohVTw
         rrJM9Lr9/pP9yQDCZfoWqI++5jr+2HsHNrsKyu6HH3isgCmxHfqCJSFTNvkwZoNrhlKa
         8dgg==
X-Gm-Message-State: AOJu0YxqwpsZJ0dCeu8ILUH/vitOHUl+F3sbDtSsJutTNbZwAEY4irof
        peleo9miCXKlMDuqA1HTwWvadQ==
X-Google-Smtp-Source: AGHT+IHIqVvat3WFgW7bSGIN3IhC9C4vTopTqfpdV2Xu/qtEpuLymttnUvDdmZXr+/gA2lPD1xkW2Q==
X-Received: by 2002:a17:90a:1950:b0:27d:2663:c5f4 with SMTP id 16-20020a17090a195000b0027d2663c5f4mr5601350pjh.47.1700727953287;
        Thu, 23 Nov 2023 00:25:53 -0800 (PST)
Received: from localhost.localdomain ([2001:c10:ff04:0:1000:0:1:4])
        by smtp.gmail.com with ESMTPSA id nm3-20020a17090b19c300b00285139b71cdsm1017481pjb.11.2023.11.23.00.25.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 00:25:52 -0800 (PST)
From:   lizhe.67@bytedance.com
To:     dianders@chromium.org
Cc:     akpm@linux-foundation.org, kernelfans@gmail.com,
        lecopzer.chen@mediatek.com, linux-kernel@vger.kernel.org,
        lizefan.x@bytedance.com, lizhe.67@bytedance.com, pmladek@suse.com
Subject: Re: [PATCH v2] softlockup: serialized softlockup's log
Date:   Thu, 23 Nov 2023 16:25:46 +0800
Message-Id: <20231123082546.7842-1-lizhe.67@bytedance.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <CAD=FV=VwaL7VSpEir6Ocyh3cttk8Abj5ZJ61h_CrPkYzYZDRYQ@mail.gmail.com>
References: <CAD=FV=VwaL7VSpEir6Ocyh3cttk8Abj5ZJ61h_CrPkYzYZDRYQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Nov 2023 15:22:12 -0800, dianders@chromium.org wrote:
>>
>> On Wed, 22 Nov 2023 18:02:12 +0800 lizhe.67@bytedance.com wrote:
>>
>> > From: Li Zhe <lizhe.67@bytedance.com>
>> >
>> > If multiple CPUs trigger softlockup at the same time with
>> > 'softlockup_all_cpu_backtrace=0', the softlockup's logs will appear
>> > staggeredly in dmesg, which will affect the viewing of the logs for
>> > developer. Since the code path for outputting softlockup logs is not
>> > a kernel hotspot and the performance requirements for the code are
>> > not strict, locks are used to serialize the softlockup log output to
>> > improve the readability of the logs.
>>
>> Seems reasonable, but...
>>
>> > --- a/kernel/watchdog.c
>> > +++ b/kernel/watchdog.c
>> > @@ -28,6 +28,8 @@
>> >  #include <linux/kvm_para.h>
>> >
>> >  static DEFINE_MUTEX(watchdog_mutex);
>> > +/* This lock is used to prevent concurrent actions of softlockup output logs */
>> > +static DEFINE_SPINLOCK(watchdog_output_lock);
>>
>> It would be a little neater to reduce the scope of this - move the
>> definition into that little code block in watchdog_timer_fn() where it
>> is actually used.
>
>That's where Li Zhe had it in v1. I actually requested it move to a
>larger scope since I think we'll want a future patch that also uses
>the same lock for hardlockup and I was thinking of sending that out
>after Li Zhe's patch lands. Specifically, I've seen cases on arm64
>when pseudo-NMI isn't enabled that we can end up with a soft lockup
>triggering while we're waiting for a backtrace of a hardlockup (since
>we wait 10 seconds if a CPU isn't responding to the request to
>backtrace it).

In my opinion, I think both definition methods are OK. But for the
original patch, it is more appropriate to put the definition inside
the function. I will send a v3 patch. Looking forward to your patches
for the hardlockup.

>
>I've also been testing hardlockup (with pseudo-NMI enabled) and I also
>notice similar problems with hardlockup itself. Specifically, I'm
>looking at a an output currently that looks like this:
>
>[  102.619905] lkdtm: Performing direct entry HARDLOCKUP
>[  112.037900] Watchdog detected hard LOCKUP on cpu 1
>[  112.038031] Watchdog detected hard LOCKUP on cpu 7
>[  112.042872] Modules linked in:
>[  112.047807] Modules linked in:
>...
>
>...but I'd also be OK with limiting the scope until I send my later
>patch, so up to you.
>
>
>> >  #if defined(CONFIG_HARDLOCKUP_DETECTOR) || defined(CONFIG_HARDLOCKUP_DETECTOR_SPARC64)
>> >  # define WATCHDOG_HARDLOCKUP_DEFAULT 1
>> > @@ -514,6 +516,7 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
>> >               /* Start period for the next softlockup warning. */
>> >               update_report_ts();
>> >
>> > +             spin_lock(&watchdog_output_lock);
>>
>> The hrtimer callout function is called from [soft]irq context, yes?
>> Doesn't lockdep get upset when we take a spinlock in such a context?
>
>I don't think so, but I could certainly be wrong. As far as I knew:
>
>* spin_lock_irqsave / spin_unlock_irqrestore: Always safe to call,
>whether from normal context or IRQ context. Saves whether IRQs were
>disabled or not, then disables them, then restores them to how they
>were before.
>
>* spin_lock_irq, spin_unlock_irq: Safe to call as long as you're _not_
>in IRQ context (because spin_lock_irq disables IRQs and
>spin_unlock_irq unconditionally re-enables them)
>
>* spin_lock / spin_unlock: Safe to call as long as you _are_ in IRQ
>context. Being in IRQ context means IRQs are already disabled so the
>function doesn't need to disable/reenable them. Also safe to call if
>no users of this spinlock ever run in IRQ context.
>
>The reason for all that complexity is to specifically to avoid:
>
>1. spin_lock(&my_lock);
>2. IRQ fires off
>3. In IRQ context: spin_lock(&my_lock);
>
>...because that would make us spin forever.
>

I can't aggree with you more.

>
>Just to be sure, I just tried with lockdep and things seemed OK.
>Specifically, I did:
>
>sysctl -w kernel.softlockup_panic=0
>sysctl -w kernel.softlockup_all_cpu_backtrace=0
>for i in $(seq 3); do
>  echo SOFTLOCKUP > /sys/kernel/debug/provoke-crash/DIRECT&
>done
>
>I got no lockdep splats and things seemed synchronized. Of course, the
>system was in pretty bad shape because the "provoke-crash" module
>never gets out of its soft lockup, but that's part for the course and
>why on our systems we run with kernel.softlockup_panic=1. I guess that
>also means I'd be happy with this now:

I also did the same test, things seemed OK.

>
>Tested-by: Douglas Anderson <dianders@chromium.org>

Thank you very much for your test!
