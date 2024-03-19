Return-Path: <linux-kernel+bounces-108198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 302E3880763
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 23:50:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C428A1F23659
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 22:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F5985A11C;
	Tue, 19 Mar 2024 22:50:11 +0000 (UTC)
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6F1364D4;
	Tue, 19 Mar 2024 22:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710888610; cv=none; b=YNMT5KYt42HYVXqNHecc+KxCuwtVRFmM8gfpTtcyt4XHaGl0P9pARY6BkHQOJjzxf8N9qTfu2g48q2saOVcdvvP8x6ZvjA5/aDen88yNaEsKhINxBr7Exi0nnzrltWZdF1mQOpUPNfkXSHqq5cI2b74qBXm6tSReBT136/3Fg8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710888610; c=relaxed/simple;
	bh=1flOJ3RWi62qhATNMgJWjfQ18bBCP95T4oDhosHEGzc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RzQg7/NzgjJV+ndoPiy7alIajDg1azAZlN2Uyykfq0OntUur6lth8VJSbAkK3HRUpFbUxR4E+g4o6sztB7KYXjfDJuuTUsgukD5jbPWe6WkGz6ggUibznUO8CwRCMYHBgWAZfGl6oyhVDlMHgtcSNeZ3n92+3dmr2r3l17gmNP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.178.112] (p57b378ee.dip0.t-ipconnect.de [87.179.120.238])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 152AC61E5FE3D;
	Tue, 19 Mar 2024 23:48:19 +0100 (CET)
Message-ID: <cd42aca9-ac6c-4579-96d5-121a38ebded5@molgen.mpg.de>
Date: Tue, 19 Mar 2024 23:48:17 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH v5 00/11] Add support for Intel PPS
 Generator
Content-Language: en-US
To: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
Cc: tglx@linutronix.de, jstultz@google.com, giometti@enneenne.com,
 corbet@lwn.net, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 mallikarjunappa.sangannavar@intel.com, alexandre.torgue@foss.st.com,
 perex@perex.cz, basavaraj.goudar@intel.com, thejesh.reddy.t.r@intel.com,
 christopher.s.hall@intel.com, x86@kernel.org, joabreu@synopsys.com,
 peter.hilber@opensynergy.com, intel-wired-lan@lists.osuosl.org,
 subramanian.mohan@intel.com, linux-sound@vger.kernel.org,
 andriy.shevchenko@linux.intel.com, netdev@vger.kernel.org,
 pandith.n@intel.com, eddie.dong@intel.com, mcoquelin.stm32@gmail.com,
 anthony.l.nguyen@intel.com, davem@davemloft.net
References: <20240319130547.4195-1-lakshmi.sowjanya.d@intel.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20240319130547.4195-1-lakshmi.sowjanya.d@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Lakshmi,


Thank you for your patch series.

Am 19.03.24 um 14:05 schrieb lakshmi.sowjanya.d@intel.com:
> From: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
> 
> The goal of the PPS(Pulse Per Second) hardware/software is to generate a

Please add a space before (.

> signal from the system on a wire so that some third-party hardware can
> observe that signal and judge how close the system's time is to another
> system or piece of hardware.
> 
> Existing methods (like parallel ports) require software to flip a bit at
> just the right time to create a PPS signal. Many things can prevent
> software from doing this precisely. This (Timed I/O) method is better
> because software only "arms" the hardware in advance and then depends on
> the hardware to "fire" and flip the signal at just the right time.
> 
> To generate a PPS signal with this new hardware, the kernel wakes up
> twice a second, once for 1->0 edge and other for the 0->1 edge. It does
> this shortly (~10ms) before the actual change in the signal needs to be
> made. It computes the TSC value at which edge will happen, convert to a
> value hardware understands and program this value to Timed I/O hardware.
> The actual edge transition happens without any further action from the
> kernel.
> 
> The result here is a signal coming out of the system that is roughly
> 1,000 times more accurate than the old methods. If the system is heavily
> loaded, the difference in accuracy is larger in old methods.
> 
> Application Interface:
> The API to use Timed I/O is very simple. It is enabled and disabled by
> writing a '1' or '0' value to the sysfs enable attribute associated with
> the Timed I/O PPS device. Each Timed I/O pin is represented by a PPS
> device. When enabled, a pulse-per-second(PPS) synchronized with the

Please add a space before (.

> system clock is continuously produced on the Timed I/O pin, otherwise it
> is pulled low.
> 
> The Timed I/O signal on the motherboard is enabled in the BIOS setup.

It’d be great if you documented your test setup including the name of 
the system firmware option.


Kind regards,

Paul

