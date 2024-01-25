Return-Path: <linux-kernel+bounces-38975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C7B683C940
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 18:05:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3220928FAB1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 17:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CDB8136671;
	Thu, 25 Jan 2024 16:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IYYFaX1C";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dhtglBwj"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E94A130E4C;
	Thu, 25 Jan 2024 16:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706201758; cv=none; b=Te9Buf2bpKYQDqOT0zVmhBb54iNPmrY1w4GCctKClzd5qODfgIYq1xOlqOselitMe3HFTn9YzNLYpJh1PbqzbEm/SiacQol/B6dFOzAPrOmYIkpQKYRM/kYq7cl8oPJhlJo6kBT2+GdNtICojKkTh8ChNYfUFU5U+btclZaExPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706201758; c=relaxed/simple;
	bh=ev6BXcPHhv7hS7Msyu1jtYzNEvqf40KXNLQ0snfhHq8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LDPFp+ZDzRGB2TCHxp/yfZVps3Rq7H82kIWPjYZ9DgOkV+wMAoTCKlrAdHUWWSsOTK1SBWat3r9ays/xLIzqxe75VMLljC+maXm+WQc2oGC7b6hEfWb6G+AIhf51ggLBBLztM9LmY+mT0G01Ll6hW1H/6I+r7/hzeechttsmpSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IYYFaX1C; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dhtglBwj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706201754;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=92eY21xw230GFaL41ki63jBw0c9iPkoZ86cyJ3/UBuE=;
	b=IYYFaX1CoPZKZ22c4E20tWimlLKl43pFyO/pydrGFhb3jKmR/0qffOL5o6Pc7a6ARLtL5X
	cx7d/E6Kqxwzon8E1NiV9zpyFr6Hb+G203Lb44AHFg3Qh9I/s8HlaDXTjqd6ueVdD3Ey3L
	f9r2F7a418aL1JytoctvHEABzFc7spyfeVDGlsY5iHjdYN0/5VO6IyRXwh858CxoL1fAqg
	ezIjbD/nlZ+ovdWu7vLp2QNU9/y8m4evdrS3h9uskmhj+J58V11BcunV5Bh68wSQbOU1JC
	OpD3rfSKR/YQ+OuaUnbv++/omkHjFRWmbPeVUHT+pe4/ukgxO2+uPlNsbFoNbg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706201754;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=92eY21xw230GFaL41ki63jBw0c9iPkoZ86cyJ3/UBuE=;
	b=dhtglBwj2v1Tv9I9JA58q4T+sG6vEy/szyfd4g6YVrOv3Iw+digC76dDrnMyo5yeermLWM
	PK750z3a/vS3/JCg==
To: Jani Nikula <jani.nikula@linux.intel.com>, Jonathan Corbet
 <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>,
 linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Frederic Weisbecker
 <frederic@kernel.org>, Ingo Molnar <mingo@kernel.org>, John Stultz
 <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, Clemens Ladisch
 <clemens@ladisch.de>, linux-doc@vger.kernel.org
Subject: Re: [PATCH 6/8] Documentation: Create a new folder for all timer
 internals
In-Reply-To: <87y1cdjuwk.fsf@intel.com>
References: <20240123164702.55612-1-anna-maria@linutronix.de>
 <20240123164702.55612-7-anna-maria@linutronix.de>
 <8eac7bf0-86c5-43ef-99e0-0896c994184a@infradead.org>
 <87o7d9d7dd.fsf@somnus> <87plxpbgpz.fsf@meer.lwn.net>
 <87y1cdjuwk.fsf@intel.com>
Date: Thu, 25 Jan 2024 17:55:54 +0100
Message-ID: <87wmrxbbdx.fsf@somnus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jani Nikula <jani.nikula@linux.intel.com> writes:

> On Thu, 25 Jan 2024, Jonathan Corbet <corbet@lwn.net> wrote:
>>
>> I've thought for a while that we should have a standard warning or two
>> along these lines, like Wikipedia does, but of course haven't done
>> anything about it.
>
> One approach could be to use the todo extension [1], and use todo
> directives instead of warnings. With todo_include_todos config set to
> True, you get the banners in the code, but it's more of an invitation
> for people to fix them. Maybe. :)
>

This might be a bit more positive than the red warning box. But with
this todo extension, the box is simply grey and might be easier to
ignore (I don't know if it is that easy to change the appearance).

Thanks,

	Anna-Maria

