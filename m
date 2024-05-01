Return-Path: <linux-kernel+bounces-165820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2782B8B9208
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 01:09:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4AF028884E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 23:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9306F168AE4;
	Wed,  1 May 2024 23:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kl.wtf header.i=@kl.wtf header.b="BoabnMbx"
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978B212FB28
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 23:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714604986; cv=none; b=BgegM6umwu76lvZ9bv5KQTpphdouSU+LAkr+XwBNIhyUDPWqMZFkhxzA+1ycv8OSmgmhdntKF06XqBTgqVWBpjbrtBz69NQn+9RIvZGiO4Tq22e5BhiaoWjrZtfSBil4UBdCS2V28Ts4xCwaaYU8oqovuWlCiOgvxStuwBZYY7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714604986; c=relaxed/simple;
	bh=t4q6Euaprw/nf0vGYLeYR81pJ5UkdByENdJyjQJba1E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AxXX9cft1lalimpjsGTLOtT3ZklyxwnB2QI02y82s8RzIT5WrYflbj0ttD4FzJCoFNxvKKM8+0Mcp5zbgTbqcERegQUqvbEk73jBcmiZwjBXdMGZ5VYUIIjkJ0yDnfGmDpCjCmOaCvbvDwlYpugnVn1fts13prFElOPdNgU1VRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kl.wtf; spf=pass smtp.mailfrom=kl.wtf; dkim=pass (2048-bit key) header.d=kl.wtf header.i=@kl.wtf header.b=BoabnMbx; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kl.wtf
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kl.wtf
Message-ID: <e85237b8-a572-4e45-aa08-18710635eea5@kl.wtf>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kl.wtf; s=key1;
	t=1714604982;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZURTbaEpa10D59UB64Q5vJXaRFyLVPmbATsg9QGzvO0=;
	b=BoabnMbxCfXCFoZ5Lq0H5UOSW6CGo+lInVzM1yMEfPrvavPlBu4QziWuqBRgt11VxwjYgr
	AWoL2zv//RdcVJN9umPR0OyLecopMKOslTRfyF7FwF+/9gMdErZoF1SCikHrCq1qWF2ukx
	7L3kyDGpUHxb1i2Z2BZMzYL6z7zg9OlgGQjaSEQDjn1g2eoLkaddbjuoxjWkjat4qna9iy
	kD8n1UjTPtqgjMu3j7seLBNatsiZQLSbik3ZFmZme2RXkFi49ITaRy6DOYxc/TUi37iNq8
	O9Al2jnydACoOodfBsdUcmWaA8yf/MTv9Qk+BOkYGp4YKYVE+NuRTlU1tUtyaw==
Date: Thu, 2 May 2024 01:09:37 +0200
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
 <26070c7a-4005-4bb4-b4af-779bfc415dea@kl.wtf> <ZjKTXaBrb1vs4har@google.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kenny Levinsen <kl@kl.wtf>
In-Reply-To: <ZjKTXaBrb1vs4har@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 5/1/24 9:09 PM, Dmitry Torokhov wrote:
> Is it possible for a device to be wedged so hard that it refuses to
> acknowledge the address?

A slave is allowed to not acknowledge if not able (e.g., "because it's 
performing some real time function"), but a slave that does not 
acknowledge its address is electrically indistinguishable from a 
disconnected device. In such case the device is impossible to detect 
through I2C operations, and neither smbus probe nor a "real" command 
will see it.

Any logic we have to silence missing devices will also silence entirely 
unresponsive or extremely non-cooperate devices. That is the price to 
pay for avoiding the log message unfortunately.

No other errors from the smbus probe or a real command would be related 
to device presence, and some of them even suggest a device is present 
but broken (arbitration loss, assuming no shorts).

