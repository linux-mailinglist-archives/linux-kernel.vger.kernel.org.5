Return-Path: <linux-kernel+bounces-85072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9745086B004
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 14:11:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05A7828A2E9
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 13:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5469149E0B;
	Wed, 28 Feb 2024 13:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A+OeNsCU"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E5373522
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 13:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709125870; cv=none; b=kzImsIlaHsnJGi+1+6SEnFNREWBM+Uv6QGjj1shFrhqTQOFJ8AT/t0PW/xqyyLjJ7k8r1HJZaPU2fcDSXFJAiOE1vpL2NcgwH1jcZBhWT9235WtZN2/2Kp7OZbAgfoF6fI/yYAbeESe8U+yvD7Y9kjkZLk88mcRoOQJ3GfovTyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709125870; c=relaxed/simple;
	bh=pqawju+a24ExbQYB8MjrouWxnqD+tGLBsT+gniNfu0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A0bBaNNEQpmYqSSEkFQ1PnbOIBWfkdmUksAxGueOBtmNnwDccg4oSmuAjwOY8jTsjJJKI4nFeQF1F9/BA+YO1t6ukQSCiXnav3emaprgj+Ugve14xFxeW8wxZUtwBck7KgBTs15qFNmmnsi4IYPQ6PDBE2Wk7mZ3wznRLwldDbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=A+OeNsCU; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-33d066f8239so3946723f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 05:11:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709125867; x=1709730667; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qJD1W327BiKI98MCb1pXVIatRG0iyNZTqwC1jZzBmvo=;
        b=A+OeNsCUVzExRpEW7bymfviWQIj6ED1cd5Blk8RtBGuwLGDb+farL9ZRcFuGbDFX9N
         rGWsNgM+BlMMtwKFh7yXjhEzIasmhXLgBOQ954XLmu0VoaI0FqyFF9xXrjL/Twgyl8+X
         fW56Bk2ZKJ/Adu34qwar7PH2eSe46DFo2oeIG2c+bUhjNcssRZ7CkAX1Th6mpyIY7alv
         wxzSR9+WwXuPhRV8wupSlMBJsjKAD7qCvV6jua+zem8IghUSJP7SxqdiN6esds/tmEZN
         zblvxKs/dOd9L/4/WIh4U0sHbN1u3yMQ8PLumqx3pOpPIrRuSMkVYhA++53yKuv43SaT
         XkIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709125867; x=1709730667;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qJD1W327BiKI98MCb1pXVIatRG0iyNZTqwC1jZzBmvo=;
        b=m5qhkBlKx73nm5IWaJHHoZ5WuKBIqp+qEMLxBsXGym1Dz20mjCQQsswsUg1nHMpcn+
         0Z/VwBjMawwrRYbEo/IXZb9sfCk/KOrgPO3IgyASeoBoX5ErkugOgbwbv0BB8h8bmjcs
         zP036iTetmV+k6ep7JjpCP1iwnQqatAl4adYbdPDWSHCTxpx2ecnvj7gD6G6xb6Hhhvp
         H2LPlglZw8ndQxRX+1XecqbN1RXUVJBtjatNlbjIHyGcBaZJSoDvcY2amacxit1kcb9z
         iOf1KiN3s7FcsuNEdZux5XbhS5IvuJqyz+gG1Izr/xblBzg+z62LlWt+G7hnAVTdT0cW
         AJVA==
X-Forwarded-Encrypted: i=1; AJvYcCUqX/VYQ1rxcajrlxyUp3NH8kWVzPSFeVh2GL2tVTatZQUZh0kbZ1ay3Mvfb5HvzVFVJpX7aHKtAeIMCWQYr55EiFMB0VEzFS7snnQU
X-Gm-Message-State: AOJu0YzngBRh1YcB7jv0lwhzXdVX374cKVhprinFoI1XNQ8VqiNAXLWj
	j+bLg4OJqtgFogbNoUkplthrqNTO1XU70e6trCFRouGI7fqgx/pYdumpkr42Q5M=
X-Google-Smtp-Source: AGHT+IHkjDQ0jy8446w5QH4Mojlhm/NHAFGBOg1TPPqVtaVh3gnc1TkEjqP+ht7CxO7h2f1OlbfGvg==
X-Received: by 2002:adf:e4c1:0:b0:33d:409b:5738 with SMTP id v1-20020adfe4c1000000b0033d409b5738mr9582230wrm.26.1709125867034;
        Wed, 28 Feb 2024 05:11:07 -0800 (PST)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id bu11-20020a056000078b00b0033daaef7afcsm14979790wrb.83.2024.02.28.05.11.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 05:11:06 -0800 (PST)
Date: Wed, 28 Feb 2024 13:11:04 +0000
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Doug Anderson <dianders@chromium.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Marc Zyngier <maz@kernel.org>,
	Misono Tomohiro <misono.tomohiro@fujitsu.com>,
	Chen-Yu Tsai <wens@csie.org>, Stephen Boyd <swboyd@chromium.org>,
	Sumit Garg <sumit.garg@linaro.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Tony Luck <tony.luck@intel.com>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: smp: smp_send_stop() and crash_smp_send_stop()
 should try non-NMI first
Message-ID: <20240228131104.GB22898@aspen.lan>
References: <20231207170251.1.Id4817adef610302554b8aa42b090d57270dc119c@changeid>
 <CAD=FV=WtJCkdSY=HYDmBjn3hc4TYT7j0bMxGCV-=B3o3bm-kpQ@mail.gmail.com>
 <CAD=FV=XMkrWmA1D6UjdTs8oZiXxKc1xiUoRqtNqAE-7GoPk8mA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=XMkrWmA1D6UjdTs8oZiXxKc1xiUoRqtNqAE-7GoPk8mA@mail.gmail.com>

On Tue, Feb 27, 2024 at 04:57:31PM -0800, Doug Anderson wrote:
> Hi,
>
> On Mon, Jan 8, 2024 at 4:54 PM Doug Anderson <dianders@chromium.org> wrote:
> >
> > Hi,
> >
> > On Thu, Dec 7, 2023 at 5:03 PM Douglas Anderson <dianders@chromium.org> wrote:
> > >
> > > When testing hard lockup handling on my sc7180-trogdor-lazor device
> > > with pseudo-NMI enabled, with serial console enabled and with kgdb
> > > disabled, I found that the stack crawls printed to the serial console
> > > ended up as a jumbled mess. After rebooting, the pstore-based console
> > > looked fine though. Also, enabling kgdb to trap the panic made the
> > > console look fine and avoided the mess.
> > >
> > > After a bit of tracking down, I came to the conclusion that this was
> > > what was happening:
> > > 1. The panic path was stopping all other CPUs with
> > >    panic_other_cpus_shutdown().
> > > 2. At least one of those other CPUs was in the middle of printing to
> > >    the serial console and holding the console port's lock, which is
> > >    grabbed with "irqsave". ...but since we were stopping with an NMI
> > >    we didn't care about the "irqsave" and interrupted anyway.
> > > 3. Since we stopped the CPU while it was holding the lock it would
> > >    never release it.
> > > 4. All future calls to output to the console would end up failing to
> > >    get the lock in qcom_geni_serial_console_write(). This isn't
> > >    _totally_ unexpected at panic time but it's a code path that's not
> > >    well tested, hard to get right, and apparently doesn't work
> > >    terribly well on the Qualcomm geni serial driver.
> > >
> > > It would probably be a reasonable idea to try to make the Qualcomm
> > > geni serial driver work better, but also it's nice not to get into
> > > this situation in the first place.
> > >
> > > Taking a page from what x86 appears to do in native_stop_other_cpus(),
> > > let's do this:
> > > 1. First, we'll try to stop other CPUs with a normal IPI and wait a
> > >    second. This gives them a chance to leave critical sections.
> > > 2. If CPUs fail to stop then we'll retry with an NMI, but give a much
> > >    lower timeout since there's no good reason for a CPU not to react
> > >    quickly to a NMI.
> > >
> > > This works well and avoids the corrupted console and (presumably)
> > > could help avoid other similar issues.
> > >
> > > In order to do this, we need to do a little re-organization of our
> > > IPIs since we don't have any more free IDs. We'll do what was
> > > suggested in previous conversations and combine "stop" and "crash
> > > stop". That frees up an IPI so now we can have a "stop" and "stop
> > > NMI".
> > >
> > > In order to do this we also need a slight change in the way we keep
> > > track of which CPUs still need to be stopped. We need to know
> > > specifically which CPUs haven't stopped yet when we fall back to NMI
> > > but in the "crash stop" case the "cpu_online_mask" isn't updated as
> > > CPUs go down. This is why that code path had an atomic of the number
> > > of CPUs left. We'll solve this by making the cpumask into a
> > > global. This has a potential memory implication--with NR_CPUs = 4096
> > > this is 4096/8 = 512 bytes of globals. On the upside in that same case
> > > we take 512 bytes off the stack which could potentially have made the
> > > stop code less reliable. It can be noted that the NMI backtrace code
> > > (lib/nmi_backtrace.c) uses the same approach and that use also
> > > confirms that updating the mask is safe from NMI.
> > >
> > > All of the above lets us combine the logic for "stop" and "crash stop"
> > > code, which appeared to have a bunch of arbitrary implementation
> > > differences. Possibly this could make up for some of the 512 wasted
> > > bytes. ;-)
> > >
> > > Aside from the above change where we try a normal IPI and then an NMI,
> > > the combined function has a few subtle differences:
> > > * In the normal smp_send_stop(), if we fail to stop one or more CPUs
> > >   then we won't include the current CPU (the one running
> > >   smp_send_stop()) in the error message.
> > > * In crash_smp_send_stop(), if we fail to stop some CPUs we'll print
> > >   the CPUs that we failed to stop instead of printing all _but_ the
> > >   current running CPU.
> > > * In crash_smp_send_stop(), we will now only print "SMP: stopping
> > >   secondary CPUs" if (system_state <= SYSTEM_RUNNING).
> > >
> > > Fixes: d7402513c935 ("arm64: smp: IPI_CPU_STOP and IPI_CPU_CRASH_STOP should try for NMI")
> > > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > > ---
> > > I'm not setup to test the crash_smp_send_stop(). I made sure it
> > > compiled and hacked the panic() method to call it, but I haven't
> > > actually run kexec. Hopefully others can confirm that it's working for
> > > them.
> > >
> > >  arch/arm64/kernel/smp.c | 115 +++++++++++++++++++---------------------
> > >  1 file changed, 54 insertions(+), 61 deletions(-)
> >
> > The sound of crickets is overwhelming. ;-) Does anyone have any
> > comments here? Is this a terrible idea? Is this the best idea you've
> > heard all year (it's only been 8 days, so maybe)? Is this great but
> > the implementation is lacking (at best)? Do you hate that this waits
> > for 1 second and wish it waited for 1 ms? 10 ms? 100 ms? 8192 ms?
> >
> > Aside from the weirdness of a processor being killed while holding the
> > console lock, it does seem beneficial to give IRQs at least a little
> > time to finish before killing a processor. I don't have any other
> > explicit examples, but I could just imagine that things might be a
> > little more orderly in such a case...
>
> I'm still hoping to get some sort of feedback here. If people think
> this is a terrible idea then I'll shut up now and leave well enough
> alone, but it would be nice to actively decide and get the patch out
> of limbo.

I've read patch through a couple of times and was generally convinced by
the "do what x86 does" argument.

However until now I've always held my council since I wasn't familiar
with these code paths and I figured it was OK for me to have no opinion
because the first line of the description says that kgdb/kdb is 100% not
involved in causing the problem ;-) .

However today I also took a look at the HAVE_NMI architectures and there
is no consensus between them about how to implement this: PowerPC uses
NMI and most of the others use IRQ only, s390 special cases for the
panic code path and acts differently compared to a normal SMP shutdown.

FWIW the x86 route was irq-only and then switching to irq-plus-nmi
(after a short trial with NMI-only that had problems with pstore
reliability[1]) and that approach has been in place for over
a decade now!

However, if we talking ourselves into copying x86 then perhaps we should
more accurately copy x86! Assuming I read the x86 code correctly then
crash_smp_send_stop() will (mostly) go staight to NMI rather
than trialling an IRQ first! That is not what is currently implemented
in the patch for arm64.


Daniel.


[1]
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7d007d21e539dbecb6942c5734e6649f720982cf

