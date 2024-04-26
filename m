Return-Path: <linux-kernel+bounces-160354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A99C28B3C5C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 18:04:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 363731F229F6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 16:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CA5114D71D;
	Fri, 26 Apr 2024 16:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SfxzBpkR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7D214C5BF;
	Fri, 26 Apr 2024 16:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714147427; cv=none; b=ISgQKGeNwbBvnQc+S7VhzXya8o8LlBMQCzcxo2x1MqZANqy9jb+HFz9QPMrSgxrNNaCuC0yvTsWrmIox7lfIA7hvBxqQKw1fnDYK4bqjDax+YNOQeL9EG970NoHuccpzBNuf8Y77ejMOZxgVovoW2zMA4ZKgmD5HvNmmg/l/XaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714147427; c=relaxed/simple;
	bh=xPTVfPEcrY8v2K1kUOX6aSymyuAfiCcwROAw7MbnOXs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cdFjmX8yPZoy9yIzVTHgPbdNVH3Z57tBXpCO4e0rtn2msTMyi7OMxEedOFhOfJ8xdfubdkq6afjZUfusS/uGP1MXpMv/X3OMxymNLzqMgTJkRdUySIHfEegOCWbNg4pDwq+lkGWMPTpROzXIFkVsvzzuIj4kffMatmVENXQfWIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SfxzBpkR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD6F0C4AF07;
	Fri, 26 Apr 2024 16:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714147426;
	bh=xPTVfPEcrY8v2K1kUOX6aSymyuAfiCcwROAw7MbnOXs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=SfxzBpkRkjT7W8+tdP0+Oe6sfmJa5BwQ4Q3HQ6BW1PmAqsZUOLeOS88T9hqoKnsW6
	 XJYpRsfcbIyOKs4nbfEH9XCOLTnBdrG7R8biLali2e3I+T/CyQlRdNZMdyYAhi2bTB
	 IQCgoXYOOrz3eoCRjROiQvgMhvR5LihMdjvPJbt09j3GAhvJLAflVAtGLSC8yFJM/6
	 5F2+eXLF9iDWDrIddFtXPLvYaYQLyLTs2PHnD0uMgWnTVhdQuOmrwFLfCIEzaBgbcH
	 GJH2OS136lOyyiP/fgnHnTPUFQjp17b6IhwOY7pPlTRUNhFs6mWfTszyJqgQDuBj5Y
	 hQL+C+pEHMbSA==
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6eba841d83cso550608a34.2;
        Fri, 26 Apr 2024 09:03:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUYlE7A8ahGaDrZRj6LdfRkge90eS3UVLc6AR6FVbvyrny32DAb916G08k6JbI5L2/KiWldxlGnPrAvplulj5KGfUauh/7cEbNsreszhdHbfsIo3c+zay0J3HuSwu/CEruscwr5fH0=
X-Gm-Message-State: AOJu0YxdYV6nTNGNreWgbqBqy/vxrUSyUEDxdlTpZEm5wbfgh+TPdTHa
	kSinUOfK/X7MLJaJqhRkxYvSigfGM2CRGxKzO3nxvv92oGJxA4D6Sp1CZlMgelZZfj+/0RrFQqT
	A2nvxrBf/NDIi31f+aTUKiaO/s7w=
X-Google-Smtp-Source: AGHT+IGVEqe6oZ5dmpM/yLkXmVtKat9S5qfBM7GexcB2zdP2VUJfB2bkNu/gEgMCV2srDfGazTu6lBnH2ca3wnJKY4k=
X-Received: by 2002:a4a:eb18:0:b0:5af:6d3b:d952 with SMTP id
 f24-20020a4aeb18000000b005af6d3bd952mr3695223ooj.0.1714147426141; Fri, 26 Apr
 2024 09:03:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zgtjdd0C2FzYVBto@xsang-OptiPlex-9020> <87zfth3l6y.fsf@somnus>
In-Reply-To: <87zfth3l6y.fsf@somnus>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 26 Apr 2024 18:03:34 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0g_GKF8-QK5UdFCpJapf+MK7EouQ7hMTVtPYRjNNyUt+g@mail.gmail.com>
Message-ID: <CAJZ5v0g_GKF8-QK5UdFCpJapf+MK7EouQ7hMTVtPYRjNNyUt+g@mail.gmail.com>
Subject: Re: [linus:master] [timers] 7ee9887703: stress-ng.uprobe.ops_per_sec
 -17.1% regression
To: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Oliver Sang <oliver.sang@intel.com>, oe-lkp@lists.linux.dev, lkp@intel.com, 
	linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, ying.huang@intel.com, 
	feng.tang@intel.com, fengwei.yin@intel.com, 
	Frederic Weisbecker <frederic@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Apr 25, 2024 at 10:23=E2=80=AFAM Anna-Maria Behnsen
<anna-maria@linutronix.de> wrote:
>
> Hi,
>
> (adding cpuidle/power people to cc-list)
>
> Oliver Sang <oliver.sang@intel.com> writes:
>
> > hi, Frederic Weisbecker,
> >
> > On Tue, Apr 02, 2024 at 12:46:15AM +0200, Frederic Weisbecker wrote:
> >> Le Wed, Mar 27, 2024 at 04:39:17PM +0800, kernel test robot a =C3=A9cr=
it :
> >> >
> >> >
> >> > Hello,
> >> >
> >> >
> >> > we reported
> >> > "[tip:timers/core] [timers]  7ee9887703:  netperf.Throughput_Mbps -1=
2% regression"
> >> > in
> >> > https://lore.kernel.org/all/202403011511.24defbbd-oliver.sang@intel.=
com/
> >> >
> >> > now we noticed this commit is in mainline and we captured further re=
sults.
> >> >
> >> > still include netperf results for complete. below details FYI.
> >> >
> >> >
> >> > kernel test robot noticed a -17.1% regression of stress-ng.uprobe.op=
s_per_sec
> >> > on:
> >>
> >> The good news is that I can reproduce.
> >> It has made me spot something already:
> >>
> >>    https://lore.kernel.org/lkml/ZgsynV536q1L17IS@pavilion.home/T/#m28c=
37a943fdbcbadf0332cf9c32c350c74c403b0
> >>
> >> But that's not enough to fix the regression. Investigation continues..=
.
> >
> > Thanks a lot for information! if you want us test any patch, please let=
 us know.
>
> Oliver, I would be happy to see, whether the patch at the end of the
> message restores the original behaviour also in your test setup. I
> applied it on 6.9-rc4. This patch is not a fix - it is just a pointer to
> the kernel path, that might cause the regression. I know, it is
> probable, that a warning in tick_sched is triggered. This happens when
> the first timer is alredy in the past. I didn't add an extra check when
> creating the 'defacto' timer thingy. But existing code handles this
> problem already properly. So the warning could be ignored here.
>
> For the cpuidle people, let me explain what I oberserved, my resulting
> assumption and my request for help:
>
> cpuidle governors use expected sleep length values (beside other data)
> to decide which idle state would be good to enter. The expected sleep
> length takes the first queued timer of the CPU into account and is
> provided by tick_nohz_get_sleep_length(). With the timer pull model in
> place the non pinned timers are not taken into account when there are
> other CPUs up and running which could handle those timers. This could
> lead to increased sleep length values. On my system during the stress-ng
> uprobes test it was in the range of maximum 100us without the patch set
> and with the patch set the maximum was in a range of 200sec. This is
> intended behaviour, because timers which could expire on any CPU should
> expire on the CPU which is busy anyway and the non busy CPU should be
> able to go idle.
>
> Those increased sleep length values were the only anomalies I could find
> in the traces with the regression.
>
> I created the patch below which simply fakes the sleep length values
> that they take all timers of the CPU into account (also the non
> pinned). This patch kind of restores the behavoir of
> tick_nohz_get_sleep_length() before the change but still with the timer
> pull model in place.
>
> With the patch the regression was gone, at least on my system (using
> cpuidle governor menu but also teo).
>
> So my assumption here is, that cpuidle governors assume that a deeper
> idle state could be choosen and selecting the deeper idle state makes an
> overhead when returning from idle. But I have to notice here, that I'm
> still not familiar with cpuidle internals... So I would be happy about
> some hints how I can debug/trace cpuidle internals to falsify or verify
> this assumption.

You can look at the "usage" and "time" numbers for idle states in

/sys/devices/system/cpu/cpu*/cpuidle/state*/

The "usage" value is the number of times the governor has selected the
given state and the "time" is the total idle time after requesting the
given state (ie. the sum of time intervals between selecting that
state by the governor and wakeup from it).

If "usage" decreases for deeper (higher number) idle states relative
to its value for shallower (lower number) idle states after applying
the test patch, that will indicate that the theory is valid.

Thanks!

