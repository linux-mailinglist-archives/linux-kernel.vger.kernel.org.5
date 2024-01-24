Return-Path: <linux-kernel+bounces-36268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5459B839E35
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 02:26:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8620E1C25660
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 01:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 365641381;
	Wed, 24 Jan 2024 01:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LZns3JX3"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0095EC5;
	Wed, 24 Jan 2024 01:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706059603; cv=none; b=PI3wKPzZaCqwvpJp/2/yP2PdMY92OkvE9g3mmI4EzrZi6BEj4bj+yGLgpDD6yd89ZVE85PIPXn7d2jreDSWk/8KrA+Pp1ez3LCJLvF7cWFBR8dLuzhtkcD/sn7iXPMLw6Pl9dqXcIO+NemjPXiXpDNaGJDd24IJTMrDFRkdMM3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706059603; c=relaxed/simple;
	bh=j34jFf8Lg18z7ESEocx5XiCdaa6sLj8slT2vXXI7dxs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oQu6YIDE570nGQAnhD2YV/2hSsMQTSaEA+evxV7oZK+OSGG+6ILTBHBuNvYzQ5EKPAgGkGEcz0N342TB9qDGZkO99jkd5xgzdJcB/s0VMICEXEAHhVj6MS8Vgdt/vxDhUA5hhcKQRLodoJOTHoFKFUn01+e+j+bbutyBoV82aVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LZns3JX3; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=ZACLddTL1hSFNg3sqrkIaMx4QGJCs1G4xd7qc8mSFn4=; b=LZns3JX3XgwT8Y7AJ55eZAeysU
	Ar/vuIoH7PuwnzsCSL6JaKURMxziF86onll5n6P2I1SXOODVTYa2JMiJ/NikIzKOzg0PSVTH7VqTv
	uVdiNr+aMiCYKp2l1B2GDC3F0aGh+Lo7RfMcYjTMPqr/9aoFjZedJcc7Kp/P5Mc4fARrZWJ8RaqNd
	rfRWFc1dYHZHfbegPYWnBRojURt5XWMbQG7XIJNpizkDnHSAbvoFr278udfKZ983dLqtNhWOHjqp4
	BByZS5ie+MSZyNp6iWhrClKwrurOOJ7weRBslC8mzS7+GVh/wa0fUHpsAvW65tDqoYi0IK+RfGDTV
	ER3w6AzA==;
Received: from [50.53.50.0] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rSS2J-0010iQ-24;
	Wed, 24 Jan 2024 01:26:41 +0000
Message-ID: <8eac7bf0-86c5-43ef-99e0-0896c994184a@infradead.org>
Date: Tue, 23 Jan 2024 17:26:39 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/8] Documentation: Create a new folder for all timer
 internals
Content-Language: en-US
To: Anna-Maria Behnsen <anna-maria@linutronix.de>,
 linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Clemens Ladisch <clemens@ladisch.de>,
 linux-doc@vger.kernel.org
References: <20240123164702.55612-1-anna-maria@linutronix.de>
 <20240123164702.55612-7-anna-maria@linutronix.de>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240123164702.55612-7-anna-maria@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 1/23/24 08:47, Anna-Maria Behnsen wrote:
> The structure of documentation changed. There is 'core-api' where also
> timer related documentation belongs to. But the timer related documentation
> (doesn't matter whether it is up to date or outdated) is still located in a
> separate folder with no relation to core-api.
> 
> Create a new folder which is located below core-api and make it the new
> place for all timer related documentation. Instead of revisiting all files
> below the already existing timer folder right now, add a warning banner to
> the top of all those files. When it is ensured the content is up to date,
> they can be moved to the final destination.
> 
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
> ---
>  Documentation/core-api/index.rst        |  1 +
>  Documentation/core-api/timers/index.rst | 22 ++++++++++++++++++++++
>  Documentation/timers/highres.rst        |  5 +++++
>  Documentation/timers/hpet.rst           |  5 +++++
>  Documentation/timers/hrtimers.rst       |  5 +++++
>  Documentation/timers/index.rst          |  5 +++++
>  Documentation/timers/no_hz.rst          |  4 ++++
>  Documentation/timers/timekeeping.rst    |  5 +++++
>  Documentation/timers/timers-howto.rst   |  5 +++++

When can we remove the old, "might be outdated" files?
Do you think that some of their contents might be valuable to someone?

I prefer not to have the old documentation and the new.

>  9 files changed, 57 insertions(+)
>  create mode 100644 Documentation/core-api/timers/index.rst
> 

Thanks.

-- 
#Randy

