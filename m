Return-Path: <linux-kernel+bounces-36091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7582839B73
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 22:51:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D81AD1C21880
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 21:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0251E46525;
	Tue, 23 Jan 2024 21:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="qZgG31NJ"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013664CB4C;
	Tue, 23 Jan 2024 21:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706046690; cv=none; b=uhWHiabNzTU9w7Pptl9Q8HLzUQBwmaSwkQBQNEOD4ilEUs1ImyTQj8cDO85rkTuGEwicB1gPe/vpCGJKe2q2haLgVKLsRe+fc98JfRzZ/SYOgmXXr5Sa+NdDe+Aurpkrk0N06cc0m1CWU75svxStrI9hM57rzJ/SpjLIvqzV6yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706046690; c=relaxed/simple;
	bh=o1go1rbBgqYQFZPuiDmWmGHOfPaetZGgRJT+sNw8b3c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=R4jOZLfqk3ys40VCBtL49GpZQZgNOdyfUxwH1IHPZ8OyhRACYBPsLMAzYknjIVEVnojwTHtbHivmEhiWNz2FM+S47jRTBrbhv9kuIlUnU4Ok2gWcMeXkhkyGh954HvNwczfpeD9LNcgyeiETaDvyyb79Sfz6YrOvBwYun4IiGbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=qZgG31NJ; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Received: from localhost (c-98-53-138-11.hsd1.co.comcast.net [98.53.138.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 40C857A98;
	Tue, 23 Jan 2024 21:51:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 40C857A98
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1706046688; bh=NBOwjV8ejMEGoa0MCW8TB2MIhju55eTiqjnLlpQsCUs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=qZgG31NJ4ruefnlfEUoT/M59z1fgfyPlBqxJwi6RpMrLKQpbrhRA2FDobvBnSECBJ
	 uE9SNROMP2XzP9wwH3QSB0lWNMLManl7XXDBUcIcIIRIKEG7TOd8hKGiEiSGcL6PZd
	 zsO5nNzl/sFfPbcQhE0buO8ZKCELU1YG9Y3lzjcmXKXRqGIjsnDcVki4NqaFhk7Dwj
	 3GwtgVZLXc0ywYmEv7tX4AfRXXn14HhzeUg519wUKjoNv26FM2OI44Ddbet7c+LsRg
	 Xr442FmH2aFpWW+Ez4Is0x3I67w/w6T5HKISb878ufbsED+N3iUr+ljvwhpLP5FMLI
	 4Y/yJJWAzOM8Q==
From: Jonathan Corbet <corbet@lwn.net>
To: Dhruva Gole <d-gole@ti.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Dhruva Gole
 <d-gole@ti.com>
Subject: Re: [PATCH] Documentation: index: Minor re-arrangement and
 improvements
In-Reply-To: <20240104073317.19709-1-d-gole@ti.com>
References: <20240104073317.19709-1-d-gole@ti.com>
Date: Tue, 23 Jan 2024 14:51:27 -0700
Message-ID: <87bk9bk9b4.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Dhruva Gole <d-gole@ti.com> writes:

> * It seems odd that a develper is forced to look at the licensing rules
>   even before they get to the doc or coding guide.
>   This belongs under the "Working with the development community" / "All
>   development docs" page where it does reside even today.
> * Rearrange the section for Internal API manuals to go lower because
>   generally one would want to look at the tools and processes and admin
>   guide pages first and then move onto something deeper like the API
>   manuals.
> * Reword the Dev tools section and title to something a bit more suitable.
>
> Signed-off-by: Dhruva Gole <d-gole@ti.com>

As a general rule, multiple items in the changelog like this suggest
that you need to break a patch up.

In this case, though, I guess I don't see the reason why we would want
to churn this page this way.  The ordering of the items on the front
page was thought through and discussed the last time we did this; why
should we revisit it now?

Thanks,

jon

