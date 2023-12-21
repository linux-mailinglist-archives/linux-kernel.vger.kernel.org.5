Return-Path: <linux-kernel+bounces-7704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B5B281ABC9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 01:35:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2510CB249E7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 00:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF5DEDE;
	Thu, 21 Dec 2023 00:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="khF2KoQH"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A21710EB;
	Thu, 21 Dec 2023 00:34:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE6E0C433C7;
	Thu, 21 Dec 2023 00:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703118887;
	bh=iBBX7JrvE5c6etj+HPKaqOuXmJxPA0RAWYdmPd5igvY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=khF2KoQHa8tpe46/f6GzkGV2sspQ9qFZK67JOqx7kqwYMHaxat/IJCGJ0ZhRku8CG
	 8E3EG2lgZ6U5KTbpR2XTtguWvXqnuLX9xWk66UN0avv/skUOb4cvE/AcK3rSshgfQ1
	 X72I8Ow2PwcIwEvEAOfWKrGbObe47lb1mFn+CPY/gfrmNX5JHflApxSTFE51XFkPfD
	 ecmHgAVqeEEjUvbeRQE1bsY8uaVtNnfCenoFDzI7cRFrNl0ZyeXA+INFoQGgleYxyr
	 ZUhVobRNn94otdYHDJmB0eLHZUsR/6YluvBv5gdgjX55V6xoAsakOk3mzrmjdztZKR
	 Qe50Z87CHFcCw==
Date: Thu, 21 Dec 2023 09:34:42 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Daniel =?UTF-8?B?RMOtYXo=?= <daniel.diaz@linaro.org>
Cc: Mark Brown <broonie@kernel.org>, Naresh Kamboju
 <naresh.kamboju@linaro.org>, Linux ARM
 <linux-arm-kernel@lists.infradead.org>, open list
 <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org, linux-stable
 <stable@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Steven Rostedt
 <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, Marc Zyngier
 <maz@kernel.org>
Subject: Re: selftests: ftrace: Internal error: Oops: sve_save_state
Message-Id: <20231221093442.3c4b84f0d39350f9deb4e51f@kernel.org>
In-Reply-To: <CAEUSe7_9tE5K7NpsmaG_v_bTJaMGhVVSDRhMn1QYnr2z4vSg8w@mail.gmail.com>
References: <CA+G9fYtEGe_DhY2Ms7+L7NKsLYUomGsgqpdBj+QwDLeSg=JhGg@mail.gmail.com>
	<ad5b7442-385d-41db-9202-a36414460610@sirena.org.uk>
	<CA+G9fYsbwWpDVR9KJXx8UO5MXsYT81uAJbLLNDnLianr8jmXUA@mail.gmail.com>
	<63e92a6a-9cb7-4272-b524-ccaf997aceb3@sirena.org.uk>
	<CAEUSe7_9tE5K7NpsmaG_v_bTJaMGhVVSDRhMn1QYnr2z4vSg8w@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Daniel,

Would you know what ftrace selftest testcase script is running when
this crash happened? I think it depends on the selftest version but
I don't know which one you run.

Thank you,

On Wed, 20 Dec 2023 18:06:53 -0600
Daniel Díaz <daniel.diaz@linaro.org> wrote:

> Hello!
> 
> On Thu, 19 Oct 2023 at 11:26, Mark Brown <broonie@kernel.org> wrote:
> > On Thu, Oct 19, 2023 at 09:07:02PM +0530, Naresh Kamboju wrote:
> > > On Tue, 17 Oct 2023 at 17:52, Mark Brown <broonie@kernel.org> wrote:
> [...]
> > > > To confirm have you seen this on other stables as well or is this only
> > > > v6.5?  For how long have you been seeing this?
> >
> > > This is only seen on 6.5.8-rc2 and seen only once.
> > > I have checked on mainline / next and other stable branches and this crash
> > > is not seen anywhere else.
> >
> > > However, I will keep checking them on other branches and next and mainline.
> >
> > I see.  If the bug has never been reproduced I don't think we can draw
> > any conclusion about which branches are affected, I would be a bit
> > surprised by something that affects v6.5 only.
> 
> We have been seeing this problem in other instances, specifically on
> the following kernels:
> * 5.15.132, 5.15.134-rc1, 5.15.135, 5.15.136-rc1, 5.15.142, 5.15.145-rc1
> * 6.1.42, 6.1.43, 6.1.51-rc1, 6.1.56-rc1, 6.1.59-rc1, 6.1.63
> * 6.3.10, 6.3.11
> * 6.4.7
> * 6.5.2, 6.5.10-rc2
> 
> Most recent case is for the current 5.15 RC. Decoded stack trace is here:
> -----8<-----
>   <4>[   29.297166] ------------[ cut here ]------------
>   <4>[ 29.298039] WARNING: CPU: 1 PID: 220 at
> arch/arm64/kernel/fpsimd.c:950 do_sve_acc
> (/builds/linux/arch/arm64/kernel/fpsimd.c:950 (discriminator 1))
>   <4>[   29.300418] Modules linked in: fuse drm dm_mod ip_tables x_tables
>   <4>[   29.302720] CPU: 1 PID: 220 Comm: systemd-udevd Not tainted
> 5.15.145-rc1 #1
>   <4>[   29.303601] Hardware name: linux,dummy-virt (DT)
>   <4>[   29.304804] pstate: 40400009 (nZcv daif +PAN -UAO -TCO -DIT
> -SSBS BTYPE=--)
>   <4>[ 29.305615] pc : do_sve_acc
> (/builds/linux/arch/arm64/kernel/fpsimd.c:950 (discriminator 1))
>   <4>[ 29.306499] lr : do_sve_acc
> (/builds/linux/arch/arm64/include/asm/jump_label.h:38
> /builds/linux/arch/arm64/include/asm/lse.h:24
> /builds/linux/arch/arm64/include/asm/atomic.h:86
> /builds/linux/include/linux/atomic/atomic-long.h:335
> /builds/linux/include/asm-generic/bitops/atomic.h:42
> /builds/linux/include/asm-generic/bitops/instrumented-atomic.h:71
> /builds/linux/include/linux/thread_info.h:108
> /builds/linux/arch/arm64/kernel/fpsimd.c:949)
>   <4>[   29.307466] sp : ffff8000083b3e60
>   <4>[   29.308447] x29: ffff8000083b3e60 x28: ffff0000c2f42000 x27:
> 0000000000000000
>   <4>[   29.310500] x26: 0000000000000000 x25: 0000000000000000 x24:
> 0000000000000000
>   <4>[   29.312034] x23: 0000000080001000 x22: 0000ffffb3c8a454 x21:
> 00000000ffffffff
>   <4>[   29.313338] x20: 0000000064000000 x19: ffff0000c2f42000 x18:
> 0000000000000000
>   <4>[   29.314636] x17: 0000000000000000 x16: 0000000000000000 x15:
> 0000000000000000
>   <4>[   29.316090] x14: 0000000000000000 x13: 0000000000000000 x12:
> 0000000000000000
>   <4>[   29.317096] x11: 0000000000000000 x10: 0000000000000000 x9 :
> ffffb047a36178f4
>   <4>[   29.318131] x8 : ffff0000c2c4d888 x7 : 0000000000000000 x6 :
> 0000000000000200
>   <4>[   29.319171] x5 : ffffb047a5c6f260 x4 : 0000000000000200 x3 :
> 0000000000000001
>   <4>[   29.320180] x2 : 0000000000000000 x1 : ffff4fb95a329000 x0 :
> 0000000000800800
>   <4>[   29.321599] Call trace:
>   <4>[ 29.321996] do_sve_acc
> (/builds/linux/arch/arm64/kernel/fpsimd.c:950 (discriminator 1))
>   <4>[ 29.322674] el0_sve_acc
> (/builds/linux/arch/arm64/include/asm/daifflags.h:28
> /builds/linux/arch/arm64/kernel/entry-common.c:129
> /builds/linux/arch/arm64/kernel/entry-common.c:138
> /builds/linux/arch/arm64/kernel/entry-common.c:529)
>   <4>[ 29.323273] el0t_64_sync_handler
> (/builds/linux/arch/arm64/kernel/entry-common.c:639)
>   <4>[ 29.323951] el0t_64_sync (/builds/linux/arch/arm64/kernel/entry.S:584)
>   <4>[   29.324598] ---[ end trace b31d3b95f436e1b5 ]---
> ----->8-----
> 
> Complete log (and reproducer) here:
>   https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/2ZoYpOR79EjlFiAuFHeOWN2rwC3
> 
> Artifacts (including vmlinux and System.map) can be found here:
>   https://storage.tuxsuite.com/public/linaro/lkft/builds/2ZoYoIewSKk26jISEo4QlNaOvVR/
> 
> Greetings!
> 
> Daniel Díaz
> daniel.diaz@linaro.org


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

