Return-Path: <linux-kernel+bounces-142034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E858A2690
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 08:27:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B9B72815AC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 06:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A39EC3FB09;
	Fri, 12 Apr 2024 06:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="omulzr0l"
Received: from out203-205-221-149.mail.qq.com (out203-205-221-149.mail.qq.com [203.205.221.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B98B3F9E0
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 06:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712903261; cv=none; b=Wf1rDZzo7rDOVL785bVYngX/P238ojX5pWCQYzmU6LuP82AKWsXIcq3mDt4QNwlNncQCN8sKJsPSZ4AblluwolNIGNdism5QFt7d/KLzRW5D31jhK1vIsNmzTQxGdWRKPYyxBNTlj2OcN2bBhtYEn4v0Ip/G5zM9LgWn8+ZVGkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712903261; c=relaxed/simple;
	bh=mpG73ntkI+bKnWbZWLV1SvgJybIvz4F5Ii6CWsA53Qs=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=NA9mj0biL3l8ot73iAIM9lkEFMwl1FyLmxPzEcYk/UWq2vnvcnpwUA/1iyqCScbfrawnUkfakqOFe4QKbHB3ympGt+rv5pNTigy9ej80hQundnlp5zB3qoDsDToI8aNtNsS/ot8pAtaL/XfvmDZgrH4eVGO9CT5gRXnn8lB6GC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=none smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=omulzr0l; arc=none smtp.client-ip=203.205.221.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1712903254; bh=D8d08kdXjrFd28ginRdzdAdRNU2wwkO/zqvD1S6aOGE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=omulzr0leRzsi57LqNmlKQHklbB3iyYiKql9AigtmqNk/ZoKOS9po86lTcwDR7TxB
	 mrCsruuospHXDPbmi5UTU6ZafuLMOxsk6KPftcXX6l8ekHB8O+NzBgW5pkhow8RZFO
	 gCHrtBgN9zMC7pJX0bBIKzJcgb4Lm4zG1LxV14lo=
Received: from Yangyus-MBP-2.lan ([219.141.235.82])
	by newxmesmtplogicsvrszc6-0.qq.com (NewEsmtp) with SMTP
	id 6DDA90ED; Fri, 12 Apr 2024 14:27:29 +0800
X-QQ-mid: xmsmtpt1712903249tchi8hoao
Message-ID: <tencent_49E156C63C84E435E6F16509D6699339520A@qq.com>
X-QQ-XMAILINFO: M6lqjKFHeg8FipVhaxR+kEqYAYB7tJUinzNVL1AmDc5DgmTMqHVxOFMH9MdVvV
	 RjPhvTEMHFHFNzmcs9Aso2kRDaElcQapDDlJwGkBBhWa59KhptInSCzFi03vMg4LzERqRTZQ1sJH
	 CNwnCmgUbBUIIERkAWWI5ZK2gZuvi4zwiiGC+wR497dv+g43C3eN2JS5O7Je9Y6JSbC3b+djrjzT
	 is/rS4G4tjTzsKLPax7qS7oAx7SJLE/XmKBeXrzrz3Qmc4F5hfqJ/3hZN3FsWWH3VcgFyuw8qf+j
	 eiV9+dyW/PuokfeGq0Ko589nTnyFWgZECvR4yt5fKkP9bIgQDqLM6G2g5mly91OlFrL9On6PMTif
	 FJdE9a192NEFtCl+UWCfyxh8ZZ2wbYvMmvE9UOb3GS6xU/Tr7TbPjPINZZ9ecjgnobJ7ocdNqNHi
	 1s7o3Zq+t8JEi9C+16Uwe6O8ssdxqdtAgsbhco7k6BKEiBYkZUu0E2UYmS0rwFsMuIn6f/lAu646
	 wLzCtFhObPbbeMQkiyf1dpvjVC8A/nXkupyawyK4+ldMuF8chHbnuffrn/WczlsV08UGuU/V/If4
	 z2gvOQt8/PBLvTLv9w+dLovbn+7popyN1zfKg1MdqMOwjmGzK1Dj+cMMQjxZpQBC8+D9XbpFTRa3
	 c9Px4pQB2KSD4hUsvPtpQfuNN42fQE5utHLK5kJYr2XOhgGy0Y6j79KVhI26e7m59RHkbRoxyWcc
	 pGVurjjQF0Vgt0CP2K/RhKXKmXGR6Ez24GgnCCEp9v/RCWowSHECv6IIECzBfDlH+98UUR58dsiG
	 DftcNxVBMSIoVMU24t23HUMnay7tCqipq67fxLzF0UsIlkLT/nUqJ/DjJVRXTB54DSsbMM/6SeKD
	 qwUrpMixt0xaelMdd/Ucma3hsRRjqDxmo9LwXdiEYBcOUrjTeY+LpFcaolblLmrzLNU1tEYeaghx
	 VEqmBD/GaU1ukUuKp4//LrQaxRNyClcp71h31IuKwmHJU5f/IiWqKhwnP8NevXBzJFk/yZem4=
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From: Yangyu Chen <cyy@cyyself.name>
To: conor@kernel.org
Cc: ajones@ventanamicro.com,
	anup@brainfault.org,
	aou@eecs.berkeley.edu,
	atishp@atishpatra.org,
	conor.dooley@microchip.com,
	dqfext@gmail.com,
	guoren@kernel.org,
	heiko@sntech.de,
	inochiama@outlook.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	mark.rutland@arm.com,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	will@kernel.org
Subject: Re: [PATCH] perf: RISC-V: fix IRQ detection on T-Head C908
Date: Fri, 12 Apr 2024 14:27:28 +0800
X-OQ-MSGID: <20240412062728.71533-1-cyy@cyyself.name>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20240314-pep-announcer-2d7f10ff8b65@spud>
References: <20240314-pep-announcer-2d7f10ff8b65@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

>> IMHO, it may be better to use a new DT property like "riscv,cpu-errata" or
>> "<vendor>,cpu-errata". It can achieve almost everything like using pseudo
>> isa. And the only cost I think is a small amount code to parse this.
> 
> I suppose we could do that, but accounting for vendor specifics was one
> of the goals for the property I only just added and that I am suggesting
> to use here.

I think there is a simpler way to do that. We use T-Head PMU by default
for All T-Head CPUs (from mvendor id). Then, to test there is sscofpmf in
the ISA string being probed by the kernel. If yes, then use scofpmf.
Otherwise, use T-Head PMU.

I will check if this can also be switched in any vendor CSR like Svpbmt and
T-Head MAE we discussed before.

Thanks,
Yangyu Chen


