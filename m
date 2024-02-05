Return-Path: <linux-kernel+bounces-52361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A08CF84971E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 10:58:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3CEE1C21443
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 09:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6C8112E68;
	Mon,  5 Feb 2024 09:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OMquXTRP"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949E3134BC;
	Mon,  5 Feb 2024 09:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707127068; cv=none; b=bwLD1VCldo6mHpJjEmCnUhpTi2UdAhMSizZY1kzhzDPKRWchRbg7RFqk4VxeNZqun5KzGtKsNOucE70xgmoHHXP9rs22uHiLWW0W3tb2nqTwlzCzki01iQykbhMz+EQ2QSUsTW7SDNdddgHUF74XLvycDRVEaMbMyrjtwI2Oxfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707127068; c=relaxed/simple;
	bh=WhLnBbjWuqYjIwGARAA1pzVbqLdXtIQN6h++SLYzu3g=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=pOqt+c9gTmmS2l6uBHywKuU1oxUGrJ+iMbOWpN6my7woM8myLjg+VDKO+H32AnZQ+QlMTBR9MwFBqulRQTzzu/cqIgFAXbU3I2VIvVFZPvgUtXFUMCASyYPOYTEqSZmXXUl+e8O/vo6BDxgDZ/u2LVeluuRL4SSOE3M//A71J7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OMquXTRP; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40fd280421aso13802315e9.3;
        Mon, 05 Feb 2024 01:57:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707127065; x=1707731865; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tCtq+GIvKzGX4j4jHNEOu2hxdGJ4/Dlmsc+YK4PJJPo=;
        b=OMquXTRP1ty4ywaLM9okNo1dQgHAt654D5+DEiP2QQLuhYdYTLawQRfjcaGkKJH9dK
         HomUG2ZxK90o3yTEikTTwBUJH4M6v1HOHRtQZHXMsfFubpY+xd745m62ZqyoPsWSx/N+
         llta3ZAuVCzEkCV4qFm/NOCG/rvGiaNdah2BqterMON7EZkWRX2Aa5z3H06Hu7GNFCXe
         l4JaDZUVjTUZN/+CwrHGFSOOQI8imzTyLtYfwG21lW6q9ntThD8cikRlRHl8cUrHpFj9
         s0p4vgjv1A2Pi+S8AX88PgmfYheiHWLGThyngrshcbX1VeTztn+yJ+z9OTdmWsHMG19i
         vzWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707127065; x=1707731865;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tCtq+GIvKzGX4j4jHNEOu2hxdGJ4/Dlmsc+YK4PJJPo=;
        b=UmqKttofKOogG+KlggutJLIkBlw4tyKFzP3r8q04ltFjSQowfdhFoMYk7MIak+c9Ci
         XtsepTJqvCrNuairzDhcdRsQN6D/9js+8Pe9Idf7BhaLPP2C5HTZIHIyIIU3oOipi4RZ
         u8Z75Z9wp/kyYLCi1kZk/jDHgFJWR2yeQvTyiJy2nYjwknjAp07Q+kC+RkeBH0ZOsIyy
         Ij6/TW+yNS4pUwr/iP5W1j1GsdMOAZqdJq3fO3Dhkin1EQdRjFL6+FHVDUruZjE3EMhz
         B6HMStZrwieM5du4NqiqowumA4eSmjQ1mASfIKwc0zLvyOiiTdFqU+5qfnJNXMF2pm8C
         nq/Q==
X-Gm-Message-State: AOJu0YzxixCXnJBrL1pdt7KmHsO5L7dpaKEKOkskRw8pdS+FBAcKe2LF
	VhuU9UIxcJYp+RXF6ozTqM/P2OlWhkFMESRHbtzOPOy5hm/aMOfPlGwgyjAem9P8cAeqVvdfMqS
	sXNq48auYm08omcWRlhUXx8nfYJw=
X-Google-Smtp-Source: AGHT+IH3NI3ipn0a6ca7OvcchfzcfeJvG97VIoeZDF4dFmYrE2Z3sbbxykdncbFfBxqULlxMpIdBGcwzT2EmmcKdGbc=
X-Received: by 2002:a05:600c:34d3:b0:40f:b022:cea with SMTP id
 d19-20020a05600c34d300b0040fb0220ceamr4336894wmq.28.1707127064538; Mon, 05
 Feb 2024 01:57:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: richard clark <richard.xnu.clark@gmail.com>
Date: Mon, 5 Feb 2024 17:57:29 +0800
Message-ID: <CAJNi4rMpt88Gz+149wR9crzApmfUEfpS05sbOgAvOhzh2+Brbg@mail.gmail.com>
Subject: Question about the ipi_raise filter usage and output
To: nico@fluxnic.net, Steven Rostedt <rostedt@goodmis.org>, 
	Mark Rutland <mark.rutland@arm.com>, mhiramat@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, richard clark <richard.xnu.clark@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi guys,

With the ipi_raise event enabled and filtered with:
echo 'reason == "Function call interrupts"' > filter, then the 'cat
trace' output below messages:
..
insmod-3355    [010] ....1.. 24479.230381: ipi_raise:
target_mask=00000000,00000bff (Function call interrupts)
..
The above output is triggered by my kernel module where it will smp
cross call a remote function from cpu#10 to cpu#11, for the
'target_mask' value, what does the '00000000,00000bff' mean?
 ~~~~~~~~~~~~~~

Another question is for the filter, I'd like to catch the IPI only
happening on cpu#11 *AND* a remote function call, so how to write the
'target_cpus' in the filter expression?

I try to write below:
echo 'target_cpus == 11 && reason == "Function call interrupts"' >
events/ipi/ipi_raise/filter

But the 'cat trace' doesn't show anything about cpu#11 IPI info,
although both the /proc/interrupts and the smp_processor_id() in the
remote function shows there's IPI sent to the cpu#11.

Any suggestions?

Thank you!

