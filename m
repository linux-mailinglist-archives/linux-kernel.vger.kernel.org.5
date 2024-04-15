Return-Path: <linux-kernel+bounces-145646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91DBE8A58E8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 19:14:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1B541F2245E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 17:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 529EF83CA0;
	Mon, 15 Apr 2024 17:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kl.wtf header.i=@kl.wtf header.b="lUBVImYa"
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B096E823CE
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 17:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713201280; cv=none; b=F9VXQayJiSxhikRxA4X0CSXxo1mVsACL4mb/stDbek+9Sg2rEyqr2C5QdpEMUz04MBtjLyTWf+CjqgQcNSCiAid71tJJPRBdQUVvx9Q2w6Gb9OuCiaRKvoeioQFlve5pAaRl+ymIuWwW9kax2ck/YpzNp4o12E2i5Nup90MouE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713201280; c=relaxed/simple;
	bh=Lhm8h3+fyCz8kLt0MSDXOEmQEYTcNebxjOcqo1juRJI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B/LUlyOS/RMheLb/UXK9zXypLxl+jzqw8jw1mhvTkTBnVYAOSzbq/A0Nws/OFYDr5dFKHWjpZIHmAJGjRGdOyMzPw7PTHHxf1+Vx/9YaKw2IqSojEhpUz5SQm7nnKexR1YhFGO+YLY1G5d1fjfZnx+7OLkGozi007vS/r5urozo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kl.wtf; spf=pass smtp.mailfrom=kl.wtf; dkim=pass (2048-bit key) header.d=kl.wtf header.i=@kl.wtf header.b=lUBVImYa; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kl.wtf
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kl.wtf
Message-ID: <535f3756-80d9-4599-bf73-a8785d18c399@kl.wtf>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kl.wtf; s=key1;
	t=1713201276;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a1GCY3d0Rm3dFPkZOURJBPK9XnkZDPXKOhQPctcVrWI=;
	b=lUBVImYakrQ7L0y+8E+z3/izEBFow8JVMMDUpagBstRUlT569+LnhDW+7iPuScLfUap2Cq
	AnStl6AGjXorrLAbQ+9tLV4mm6skz8EEY75O5nBXsZ9Ono9Pdaa0e/jGckXQFJq74qBSEk
	+BfBbyOD6uKGmQ27LtJ6Mwi2Rl8pwIu0mkyiL8bOc35xii9NOhgv8Ymxz8YGSbn6/NzXKi
	SG/68LEvB7WSK9pQ7Zp7+9DK176ZuyGamZ+znA4d7jT1s7ESsAzwfTlG9LCKKdPct2YJ3u
	dWXMgU3oAkL2/Z3rnSJY6GlSLjE5tS1flDNW9DfFzOTUFAYuMK+cM6Of+2PvNA==
Date: Mon, 15 Apr 2024 19:14:33 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] HID: i2c-hid: wait for i2c touchpad deep-sleep to
 power-up transition
To: Johan Hovold <johan@kernel.org>
Cc: lma@chromium.org, benjamin.tissoires@redhat.com, dianders@chromium.org,
 dtor@chromium.org, hdegoede@redhat.com, jikos@kernel.org,
 johan+linaro@kernel.org, kai.heng.feng@canonical.com,
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 mripard@kernel.org, rad@chromium.org
References: <CAE5UKNqufWZfKLAXLcpBYKQpJEVt6jPD4Xtr=Nesh34VkNOETg@mail.gmail.com>
 <81e1b870-37f9-4ef2-9a3d-87015f32546b@kl.wtf>
 <Zh0qKeI-YPDE-NVT@hovoldconsulting.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kenny Levinsen <kl@kl.wtf>
In-Reply-To: <Zh0qKeI-YPDE-NVT@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 4/15/24 3:22 PM, Johan Hovold wrote:
> We also use it for devices that may not be populated (e.g. an optional
> touchscreen) and in that case we should not print anything.

I sent a patch series[0] that shows how the same can be achieved 
(gracefully handling missing device + retry to wake device) without any 
smbus probes, following the existing retry style in i2c_hid_set_power().

Radoslaw and Lukasz, it somehow felt rude to tag and blame you for code 
you hadn't seen yet. If my patch ends up favored we should make sure to 
have the appropriate attribution tags added...

[0]: https://lore.kernel.org/all/20240415170517.18780-1-kl@kl.wtf/


