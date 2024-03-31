Return-Path: <linux-kernel+bounces-126321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A9EF893532
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 19:25:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE0FFB276F4
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 17:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01802145FF4;
	Sun, 31 Mar 2024 17:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="qb41CNTk"
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F51C1E531
	for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2024 17:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711904867; cv=none; b=C+0dnVuzM5PNcF+xp9AsfRvgRWbD6yw3X//dzpLOHua1NMd89uYUqQazJb8nUyl9aYs3kN8PPr9H6srbAOxYOggR/PamxZJtTZjXGmiOeC33cZqY62geYFeUcEuFNbg75IUq5vfzfVf7+eVOUT6GvglHy3yBFaNCt9I0HtqlkGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711904867; c=relaxed/simple;
	bh=ip/ojBn1bBIN37JHwCVonuz9hy+GTreofF8f4G55+f4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QFeenuFYHCSKRPbnbmvruVRmh5n6UqTECCm8Gt6DndUN/x28kP3kTvugXUp3y1NpUJKh+ELSVF/Yhd/s2fMBHN0OIjpruIznXuFet0YMqBaCkcROMjIOx8WQ3aiowkhMfkPkGDkokXe+jV/7e2wuHGmVoMaYqU4qx3l5SEZ7haU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=qb41CNTk; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=QkYfgLS7hkRF6DPbDYtOSNe6tba9tryOWI4KjfUu1rY=; b=qb41CNTkrlQyNw/zpC02hfKPfe
	VdoTMltrAiIdxssFiQW7oeDhQzlhuhpwd1TwHyZXSyyWuLViSKHqn8GsUky+5eIVWHsDKijT8OHON
	dE3tUJCSpHWrV17OuhIOzdKD40HlPiNyPs4ekuJ3ZDOGcjDHXY2Z8bO9TAyqVGEKHe0GgSJn57il+
	OccVl63PUWingDwlWP9MXGxm+hlPoq/MaruHzG//SzziV+7leQfF9B/Ele68F4r/YUYGFhT5Tws96
	0UKBhmDywRXQvn5a3O9xJg7g4U1Y4zRR1yEo0GewMlLMNfjhAEPIQThjXZjsodZe3syuZLVOdT+Vo
	hAEMPc+w==;
Received: from [179.232.147.2] (helo=[192.168.0.12])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1rqyee-00HM7F-9R; Sun, 31 Mar 2024 19:07:36 +0200
Message-ID: <7c8c6f7c-7476-d73d-4df1-9dea0aa4ecf2@igalia.com>
Date: Sun, 31 Mar 2024 14:07:28 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] x86/split_lock: fix delayed detection enabling
Content-Language: en-US
To: Maksim Davydov <davydov-max@yandex-team.ru>
Cc: den-plotnikov@yandex-team.ru, x86@kernel.org,
 linux-kernel@vger.kernel.org, dave.hansen@linux.intel.com,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
References: <20240321195522.24830-1-davydov-max@yandex-team.ru>
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <20240321195522.24830-1-davydov-max@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/03/2024 16:55, Maksim Davydov wrote:
> If the warn mode with disabled mitigation mode is used, then on each cpu
> where the split lock occurred detection will be disabled in order to make
> progress and delayed work will be scheduled, which then will enable
> detection back. Now it turns out that all CPUs use one global delayed
> work structure. This leads to the fact that if a split lock occurs on
> several CPUs at the same time (within 2 jiffies), only one cpu will
> schedule delayed work, but the rest will not. The return value of
> schedule_delayed_work_on() would have shown this, but it is not checked
> in the code
> In order to fix the warn mode with disabled mitigation mode, delayed work
> has to be a per-cpu.
> 
> Fixes: 727209376f49 ("x86/split_lock: Add sysctl to control the misery mode")

Thanks Maksim! I confess I (think I) understand the theory behind the
possible problem, but I'm not seeing how it happens - probably just me
being silly , but can you help me to understand it clearly?

Let's say we have 2 CPUs, CPU0 and CPU1 and we're running with
sld_mitigate = 0, meaning we don't have "the misery".

If the code running in CPU0 reaches split_lock_warn(), my understanding
is that it warns the user, schedule the sld reenable [via and
schedule_delayed_work_on()] and disables the feature with
sld_update_msr(false), correct? So, does this disabling happens only at
core level, or it disables for the whole CPU including all cores?

But back to our example, if CPU1 detects the split lock, it'll run the
same procedure as CPU0 did - so are you saying we have a race there if
CPU1 face a split lock before CPU0 disabled the MSR?

Maybe a more clear example of the issue would be even helpful in the
commit message, showing the path both CPUs would take and how the
problem happens exactly.

Thanks in advance,


Guilherme

