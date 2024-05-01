Return-Path: <linux-kernel+bounces-164943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65C0D8B854A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 07:24:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21D65283E3B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 05:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C8F481B3;
	Wed,  1 May 2024 05:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kl.wtf header.i=@kl.wtf header.b="hf2VBGy0"
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0259B45BF1
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 05:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714541059; cv=none; b=DTeKBSpgH4QPPNmvpWLjHKtuggfo5Mq0ztTJw9yLd3vSuRIxisR+NUG7WAW5JAj6IjiHInYZlNDyIOMeJzBexUOMfhi7LlaYJNtJaYDy0g2g01FM0jgUN1OlG3isLEKTmYNC3Z1jpHReA1Udt/GCr6AK/Gwn2oYka/N+mPUJWBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714541059; c=relaxed/simple;
	bh=W6vQknOCG9pH+KpiTCI9n0o+sqxHWVPRqivmOUwN4wU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SYI7DToqPj9v6EJ+xeXJhkdwfEMxX6L1RSUWgS5J8zlqs4mOwL7NJZTg3MCwj5IyOIsSR6ygAD5U1I0OF5m1LpBBWrNIIail2SnVHmCrAwRQ3/SvctjlNvUY6TDcxXeP4v1G1YQb1UshII45+MsTwtFEeSjQKBc3J7eEKnKMr+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kl.wtf; spf=pass smtp.mailfrom=kl.wtf; dkim=pass (2048-bit key) header.d=kl.wtf header.i=@kl.wtf header.b=hf2VBGy0; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kl.wtf
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kl.wtf
Message-ID: <26070c7a-4005-4bb4-b4af-779bfc415dea@kl.wtf>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kl.wtf; s=key1;
	t=1714541052;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DY5QCzdG2l5n9xOYJTH9mAFpqSJJ9rQm13TN9QItwbA=;
	b=hf2VBGy0lVBFv/YVa68S9xhqplWrtjAcAvXPKeohrhdgYWNn+SfInIqhAbzGn5aFpWSBWD
	fXSek3RABzu0zWhAB/dtVmfAdpJm9msJXv88ZqxCuAcimMExS+VY/1723GxzyBHEKN6iD8
	PEsSniZPD3YloWzhNIqrUm0NxQGRcFncMAOTS4AB14LnpEOfjq5kU8gi3OffZ9j2Tqerl8
	9y4v6jJclwhl1boFvdYcRV59LThvWa5JFrR7ppIEDe1TMj7O1dbyfDvEbxb5iqrdAoPfzo
	LNGULD8FGqFG39Cq2AlZFDfXf8maPFq+rCx5b1kgJ8w+ai+fATBqfK4bK5pfWA==
Date: Wed, 1 May 2024 07:24:08 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 1/3] HID: i2c-hid: Rely on HID descriptor fetch to
 probe
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, Dmitry Torokhov <dtor@chromium.org>,
 Benjamin Tissoires <benjamin.tissoires@redhat.com>,
 Douglas Anderson <dianders@chromium.org>, Hans de Goede
 <hdegoede@redhat.com>, Maxime Ripard <mripard@kernel.org>,
 Kai-Heng Feng <kai.heng.feng@canonical.com>,
 Johan Hovold <johan+linaro@kernel.org>, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org, Radoslaw Biernacki <rad@chromium.org>,
 Lukasz Majczak <lma@chromium.org>
References: <20240426225739.2166-1-kl@kl.wtf>
 <20240426225739.2166-2-kl@kl.wtf> <ZixvUNooESC02cJK@google.com>
 <5aa9f745-7f6a-4873-90ba-79c55335905c@kl.wtf> <ZjFli4zOalXkDWx_@google.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kenny Levinsen <kl@kl.wtf>
In-Reply-To: <ZjFli4zOalXkDWx_@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 4/30/24 11:41 PM, Dmitry Torokhov wrote:
> I actually believe there is. On Chromebooks we may source components
> from several vendors and use them in our devices. The components
> are electrically compatible with each other, have exactly the same
> connector, and therefore interchangeable. Because of that at probe time
> we do not quite know if the device is there at given address, or not
> (i.e. the touchpad could be from a different vendor and listening on
> another address) and we need to make a quick determination whether we
> should continue with probe or not.

Maybe I should clarify what I meant: All I2C operations start with the 
master writing the slave address to the bus. When a slave reads its own 
address off the bus, it pulls the data line low to ACK. If no device is 
present on the bus with the specified address, the line stays high which 
is a NACK. This means that on the bus level, we have a clear error 
condition specifically for no device with the specified address being 
present on the bus.

Whether the operation used is a dummy read or our first actual write 
should not matter - if the address is not acknowledged, the device is 
not present (or able to talk I2C). The problem lies in whether this "no 
device present on bus" error is reported clearly to us: Some drivers use 
-ENXIO specifically for this, some use it also for NACKs on written 
data, some report it but use other return codes for it, etc.

Even if we stick to the smbus probe in the long run, if we get to the 
point where we can rely on the error codes from I2C drivers we would be 
able to correctly log and propagate other error classes like bus errors 
or I2C driver issues which are all currently silenced as "nothing at 
address" by the smbus probe.

> I am not sure we can fully unify what Windows does and what Linux does,
> mainly because our firmwares are different (I think Windows devices do a
> lot more device discovery in firmware, Chrome OS historically tried to
> limit amount of code in its firmware). We also need to make sure it
> works on non-ACPI systems/ARM.

Good point. My main focus is also quirky behaviors we have added to 
replicate Windows behavior, the smbus probe just stood out in my bus traces.

I already sent 
https://lore.kernel.org/all/20240429233924.6453-1-kl@kl.wtf/ which goes 
back to improving the bus probe.

