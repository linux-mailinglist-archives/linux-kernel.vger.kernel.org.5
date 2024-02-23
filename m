Return-Path: <linux-kernel+bounces-78169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 86FF1860FC1
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 11:46:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16A2CB24275
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 10:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E992578697;
	Fri, 23 Feb 2024 10:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K6DU9Lko"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3647963111;
	Fri, 23 Feb 2024 10:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708684887; cv=none; b=qwBOX3hs2IuuS9LplA5dy6gjnOyH17MTss3PRuGx9N85ZYA3/COQBrZCOQS5GMxA8PRlLJV99RDHnXYjd++iOwI8PP2xhABXeMu5t63W240aIluLsCiGy2LDivgh72D6kI0mrwQ5CrSUqoFse6Q8sp6emGuciurv85M9c5zCFkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708684887; c=relaxed/simple;
	bh=yQ5gfwOefwOYR/TaCnNrogXr3ETb5Amk5wl97VmmEbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qADtgk7NPSa7NwMVC84GhC/6iC4c0CNolQb+SHFhoNh15PiSnadNvuhxsj9WRtaggK6c5znrTPAGee9eLTVPOgcVBYIk2UaBGhlX9riI6Wld0YQzde5WfOJpevbS5n6Fr3ic9XPujAEPnQ+XV9l+8icKzUtGGQ+S07Tp0xBAvAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K6DU9Lko; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBEA6C433F1;
	Fri, 23 Feb 2024 10:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708684886;
	bh=yQ5gfwOefwOYR/TaCnNrogXr3ETb5Amk5wl97VmmEbA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K6DU9LkoALnHKFvraTWmnJPi71aDWQwUWdz9BFoY5zQg1PPgl79U5SA0buvUmM72M
	 wwNXXpmQpzhl5Je1d9egRhXJ+9BRw0PXDt+MUDyfU3EIBw4U5BGEE/0aVPQupIcxi6
	 SeDch/AFzOd8U4QJyfzU+4pF744oUcOJPl9niqBTX7EOz6o3scAM/ktT5VkD2oBfq7
	 3HaR8aHcfVWKiYjRpKQa7KhNQeVEgOZDKPc1EHyS631wKkQ9A0k6XHhEDXsGtD6U3U
	 3MSZJVz3IsceBu3TiHlgyBJNWt1PwConf31kAUq0ysYpoz1XzQHZtQAI7i/aqksE0D
	 Swe/EJ2/O1OfA==
Date: Fri, 23 Feb 2024 10:41:21 +0000
From: Lee Jones <lee@kernel.org>
To: David Laight <David.Laight@aculab.com>
Cc: 'Justin Stitt' <justinstitt@google.com>,
	Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Finn Thain <fthain@linux-m68k.org>
Subject: Re: [PATCH v2] checkpatch: add check for snprintf to scnprintf
Message-ID: <20240223104121.GQ10170@google.com>
References: <20240221-snprintf-checkpatch-v2-1-9baeb59dae30@google.com>
 <dd2b4ac483b54a41aff11a04b6906fd6@AcuMS.aculab.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dd2b4ac483b54a41aff11a04b6906fd6@AcuMS.aculab.com>

On Thu, 22 Feb 2024, David Laight wrote:

> From: Justin Stitt
> > Sent: 21 February 2024 22:12
> > 
> > I am going to quote Lee Jones who has been doing some snprintf ->
> > scnprintf refactorings:
> > 
> > "There is a general misunderstanding amongst engineers that
> > {v}snprintf() returns the length of the data *actually* encoded into the
> > destination array.  However, as per the C99 standard {v}snprintf()
> > really returns the length of the data that *would have been* written if
> > there were enough space for it.  This misunderstanding has led to
> > buffer-overruns in the past.  It's generally considered safer to use the
> > {v}scnprintf() variants in their place (or even sprintf() in simple
> > cases).  So let's do that."
> 
> While generally true, there are places that really do want to
> detect (and error) overflow.
> That isn't possible with scnprintf().
> 
> I'm not sure what the solution is though.
> Having a function that returns a negative value on overflow is also
> likely to get misused.
> seq_printf() (or whatever it is called) may let you check,
> but it is hardly a cheap wrapper and a bit of a PITA to use.

I agree.

spprinf() was my favorite solution, but it seems that the lib string
people don't like to accept new functionality, even if it's a clear
improvement over the currently available solutions.

[0] https://lore.kernel.org/all/20240130160953.766676-1-lee@kernel.org/

-- 
Lee Jones [李琼斯]

