Return-Path: <linux-kernel+bounces-159081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F388B2916
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 21:37:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 050BAB23F61
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 19:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3CB3152527;
	Thu, 25 Apr 2024 19:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kl.wtf header.i=@kl.wtf header.b="SXJukNhR"
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C67E14B06B
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 19:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714073810; cv=none; b=jCV4/lvoSXvfCPuXQh00LPOBeuwQ5/vBdAIOcqTAx3kZ7C3ScDipG53Iz1Ni+ZPFBBlQ57PGc3kya11FQkvHU4vqySfJVMss0lkuylUkbUNzvQ79yHoaW2/WKi/RPvd65hYl1eCafPtREffXeKbWPWkdbdNf9tSxK/p2Fo81Q7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714073810; c=relaxed/simple;
	bh=bULNLhL8JjvmllG31dsbkgOA5oEY9WMBez3SwOVtrpI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UpZ3h22+0aUpcvqwTvvoL2dFOht/loi9ltdi+A08823GjoZjggk2BLzEKYVwch6mANMRqkXIP9H6k0vo01U3oV4QN9KbBmOh4Z/hOb5sctA0d/USmx4GB0vpj6f9m16BCv+EJVxRctAHUHrB7seyZNjpkq2RwVOM63/COwHpgr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kl.wtf; spf=pass smtp.mailfrom=kl.wtf; dkim=pass (2048-bit key) header.d=kl.wtf header.i=@kl.wtf header.b=SXJukNhR; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kl.wtf
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kl.wtf
Message-ID: <836b5226-a6e9-49af-981b-365aa5df1fcb@kl.wtf>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kl.wtf; s=key1;
	t=1714073806;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bCeDyj/azxXR59ysx7fddTqcYUzcbcaYMudaUZrfnAE=;
	b=SXJukNhRA6IbNlRbP3UJTAPtX9EBcdudA580Xs6MrB1vBzjIJcEDd3XQ7RSUHvTmY6RbCp
	dtOVV9LRau/cBtwN0g7HG6w6i2Dro49E5iKsoEZQ7z3eesG+4nYrmhN7vTAyg3Y3sL+t+n
	lB2T5EDz4PMPOsZB9AHIq3un44vpMaOzehOeQpJw1CdWImkluXXNATyFRS2fnjNA7Tk3aH
	2erf7LOYBPy0O0tCRpakVTRUECZNjKln326tbvk7Bt9gwB5t3V0StJIFzYUV94r4L2Up6S
	FyMm8FLhvBOjZBRajw2pUMo4Ahi5GpeYhlT8D8fxypeQNccw4qp4jlhOqMP3MQ==
Date: Thu, 25 Apr 2024 21:36:42 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/3] HID: i2c-hid: Rely on HID descriptor fetch to
 probe
To: Doug Anderson <dianders@chromium.org>
Cc: Jiri Kosina <jikos@kernel.org>, Dmitry Torokhov <dtor@chromium.org>,
 Benjamin Tissoires <benjamin.tissoires@redhat.com>,
 Hans de Goede <hdegoede@redhat.com>, Maxime Ripard <mripard@kernel.org>,
 Kai-Heng Feng <kai.heng.feng@canonical.com>,
 Johan Hovold <johan+linaro@kernel.org>, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org, Radoslaw Biernacki <rad@chromium.org>,
 Lukasz Majczak <lma@chromium.org>
References: <20240423122518.34811-1-kl@kl.wtf>
 <20240423122518.34811-2-kl@kl.wtf>
 <CAD=FV=Xr6NsW085Sc+NhVmGDOn-zCCQ65CMNce_DsHxtXUgm9w@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kenny Levinsen <kl@kl.wtf>
In-Reply-To: <CAD=FV=Xr6NsW085Sc+NhVmGDOn-zCCQ65CMNce_DsHxtXUgm9w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 4/24/24 7:00 PM, Doug Anderson wrote:
> I worry a little bit about keying just off of -EREMOTEIO. If I'm
> skimming the code properly it's up to the different i2c bus controller
> to decide which error code to return here. Looking at, for instance,
> "i2c-qcom-geni.c", I see:
>
> [NACK] = {-ENXIO, "NACK: slv unresponsive, check its power/reset-ln"},


Hmm, good point. I decided to go through the drivers and check their 
behavior on NACK, and based on my quick glance I found (insert accuracy 
disclaimer):

- 52 drivers emitting ENXIO
- 14 drivers emitting EREMOTEIO
- 11 driver emitting EIO
- 5 drivers emitting ETIMEDOUT
- 1 driver emitting EAGAIN
- 1 driver emitting I2C_ERR_BERR (???)

So just EREMOTEIO is definitely not good enough. Looking at the drivers, 
it seems like the majority of drivers emitting generic error codes could 
just as well emit ENXIO on NACK. Room for improvement.

> Maybe we should just use dev_dbg() in all cases here when we fail to
> fetch the descriptor? ...otherwise I think some boards will start
> getting a noisy error message.

I'm okay with that. I don't like hiding a useful error message, but the 
smbus probe would also have hidden bus errors.

I'll send a v3 with just dev_dbg, then if I (or someone else) end up 
aligning more i2c drivers on their NACK error we can go to the stricter 
check and incentivize the drivers to give meaningful error values...


