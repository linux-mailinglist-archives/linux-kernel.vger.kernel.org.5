Return-Path: <linux-kernel+bounces-36598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E8C83A399
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 08:57:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AEC129334E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 07:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88DBB171C2;
	Wed, 24 Jan 2024 07:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="P2Hc2rt+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="C4r5lcFi"
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231FC5C85;
	Wed, 24 Jan 2024 07:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706083037; cv=none; b=lyZfpuJqxVQCus8smxYN5/S2F5P9E2TF9U2mBvvoV/+7xHR1VVtIh8j1Zn6ofJisGdnlP6+OiZ6AunfDyuHGRgIJAewOSFjLTgsb+K/jrNJ4UcwQsNu87Sfwlm1uVKJUfKgaaIxSvut1yztzNc2ABEZRXxTkCxwIHR4lo9WRk6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706083037; c=relaxed/simple;
	bh=H1RgzITUOCuBAmiNIP/bkdVi51TkAA5ExJr5YGT+qz0=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=QkJA9u3Som96c0rGjWYavizKqujjQTVlSuo7N4F0hNE5kAaaWwI7cLEA3rXRWRMLrpojKTjfAKNvsqRYU05TmyldajAOTRZ3WmUPpKiNfFK2u1Kf7DAkvBQfE0rHOc4kEaqJRyLBSexyTv6PNuKijE9SypqXZbb9uIeb9jcIw0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=P2Hc2rt+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=C4r5lcFi; arc=none smtp.client-ip=64.147.123.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id 9BE6F3200A35;
	Wed, 24 Jan 2024 02:57:14 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 24 Jan 2024 02:57:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1706083034; x=1706169434; bh=ZwuSM4ZywO
	RUMVxFPkG3MmUndAlpqgqOEw7Unxr8DYg=; b=P2Hc2rt+q2/08jOIIXFAlF7a/X
	yft+6VFlCEWhY36dgDfZ3f96tY0QDNLsEu3uQZ2PY0HP1CG2XE8U25iqyopvlUuZ
	Rcp/B4YlIxjJqQM2nX1AK/E7Ft2ii7gsQ0IrHS/qWPLmGzHFoYz8pPozzdYI3FQq
	hf6JUtWfayV+hPYB/xmbKcq4/EcrcbNGfUs4L8pk8ZgEbPki8KZJGDDxOp6vSy/v
	X9b7lKIEQQjtF4IYyqVpBKoQkX2p2D51K+nSC1rC72v3+BsrlsAVu119HsNzlAA5
	oMSQtZ6dzwWbVDCBGxVlpeHs9SNtBWkunvQ9fo3EdinX514WzKS9ovOddzoA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706083034; x=1706169434; bh=ZwuSM4ZywORUMVxFPkG3MmUndAlp
	qgqOEw7Unxr8DYg=; b=C4r5lcFink3F1aepdJCZCIZq39CNNE53jHzI2zoH45ug
	iTS2Df9Wb/qWJQiCo33AWL4Wba2Z0iNI5b0qEFaGYGzdE/t5QUT/OEx8J1nj4P8u
	GPaTTaWfm4cFQ/nebn2V+9xA5eR0iIQZKi/LNscyP1wXjuSwRg1k9KZN8vYNE9cI
	iEOi0zf0QjXgOWvJ+G14odfg/hXvx7nFnPcONqb3KyFbSaZ54EvLDbetU48xHu2M
	JJU4vgPNt1+GnRJn59EjOg2K5yQxhRvNfIaXVNlc63iRVS5sct9ZMUArcizbv1GI
	g6KQWhpodmFf3AVVdPE96CStr6E6qCFilmsCxrN6JQ==
X-ME-Sender: <xms:2cKwZeg-e8i443zuIg2HciyyyUxzzPOJNizhCWZK2uTj67p4dZoKcA>
    <xme:2cKwZfBU1Ix5pp0ITIXuQ71LKFDqDts1qxk7R7B15-BPw6p-XAf3EjU-rjKLy-ewK
    eMS-1xdethDq5Lvj6w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeltddgkedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:2cKwZWEiWB97t7FW-oD9O5r5z4X12FxnIJN-oCDskrVAbUpOuIwQfg>
    <xmx:2cKwZXQ1uZvQjUPlFXmqCCzATvukhd-71MbVxLfr1msf8JYxoidJtw>
    <xmx:2cKwZby-Fc8jNHSyir56Ww9VpHx1cRtbNDWv2FhUYaTrRjyAjgrxkQ>
    <xmx:2sKwZSkuVgritFhUt6bkhjj2XsVgoUleGbxIJGAlhcdkKWINWRfbuA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id C7018B6008D; Wed, 24 Jan 2024 02:57:13 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-119-ga8b98d1bd8-fm-20240108.001-ga8b98d1b
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <18c814fa-b458-48f9-b7e8-88b23a1825e2@app.fastmail.com>
In-Reply-To: <20240124004028.16826-6-zfigura@codeweavers.com>
References: <20240124004028.16826-1-zfigura@codeweavers.com>
 <20240124004028.16826-6-zfigura@codeweavers.com>
Date: Wed, 24 Jan 2024 08:56:52 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Elizabeth Figura" <zfigura@codeweavers.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Cc: wine-devel@winehq.org,
 =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
 "Wolfram Sang" <wsa@kernel.org>, "Arkadiusz Hiler" <ahiler@codeweavers.com>,
 "Peter Zijlstra" <peterz@infradead.org>
Subject: Re: [RFC PATCH 5/9] ntsync: Introduce NTSYNC_IOC_WAIT_ANY.
Content-Type: text/plain

On Wed, Jan 24, 2024, at 01:40, Elizabeth Figura wrote:

> +	if (args->timeout) {
> +		struct timespec64 to;
> +
> +		if (get_timespec64(&to, u64_to_user_ptr(args->timeout)))
> +			return -EFAULT;
> +		if (!timespec64_valid(&to))
> +			return -EINVAL;
> +
> +		timeout = timespec64_to_ns(&to);
> +	}

Have you considered just passing the nanosecond value here?
Since you do not appear to write it back, that would avoid
the complexities of dealing with timespec layout differences
and indirection.

> +	ids = kmalloc_array(count, sizeof(*ids), GFP_KERNEL);
> +	if (!ids)
> +		return -ENOMEM;
> +	if (copy_from_user(ids, u64_to_user_ptr(args->objs),
> +			   array_size(count, sizeof(*ids)))) {
> +		kfree(ids);
> +		return -EFAULT;
> +	}

This looks like memdup_user() would be slightly simpler.

      Arnd

