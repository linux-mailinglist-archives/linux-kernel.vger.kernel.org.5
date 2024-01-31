Return-Path: <linux-kernel+bounces-45616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D2C84330B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 02:57:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBD931C2474D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 01:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43DC3E572;
	Wed, 31 Jan 2024 01:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PZLo3fTi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4CDE546
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 01:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706666268; cv=none; b=TInU1fJJG1WvvUBpRd7NkQZPRFZHqwX4yTM1abmisJ+6xKVDbMFC/5QQPyk0o7BifvtveCI9aQOJHlnkR1qxYHNB7TgwXDyijHjtWSrDLTkqPVWQHyL8DHhHYzdeLvbTrhfisic40HkQH9ObqrjjmcuFYfBBdrA85NVqlmtWZeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706666268; c=relaxed/simple;
	bh=5HKFmGW8B2tLWa6jC99azibL8F5QWLwDeqyZ9vcYUFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EgdlaksB0RKlOt5NNdW+YjC4LnRNryibQWNt7W+SDDGW2wVRS7NxAtnAP000DSrY85gUjqjQE/Lhat/JidX0DYe0WYDCVyCHZPQDMIld+RNcexwNv2FbK4o7urgSJnwnVBmnKAeWDrlf1oIbungDev/9/T9p2s4ouVNnowPJTsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PZLo3fTi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91C51C433F1;
	Wed, 31 Jan 2024 01:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706666267;
	bh=5HKFmGW8B2tLWa6jC99azibL8F5QWLwDeqyZ9vcYUFE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PZLo3fTinCp4E1KYeJsgUWUP729IoEmeDKl9lv6H1UyBD49SiMNrggnDkwUMKJ1Ut
	 PiQ2IljkWkJk6drH0QI9ArmTLYkW4kuXB+veDRFCA/l3fnAjajrrz2yf3/s9mGfuAy
	 IJM0SQua1egmQjeQJTdZq8llYBvFWLGVfr9cxO+A=
Date: Tue, 30 Jan 2024 20:57:44 -0500
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Tony Luck <tony.luck@intel.com>, x86@kernel.org, 
	Reinette Chatre <reinette.chatre@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: commit tag order vs. "b4 am"
Message-ID: <20240130-solid-seahorse-from-camelot-e0ecdb@lemur>
References: <Zbl5XvzpqND9exmW@agluck-desk3>
 <118a560d-9e5f-4bc4-b0d2-ee0b3d6a5120@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <118a560d-9e5f-4bc4-b0d2-ee0b3d6a5120@infradead.org>

On Tue, Jan 30, 2024 at 04:47:26PM -0800, Randy Dunlap wrote:
> > Reinette noticed that v14 of my resctrl/SNC patch series[1] did not adhere
> > to the tag order proscribed in Documentation/process/maintainer-tip.rst
> > Specifically my "Signed-off-by:" was now the last tag, instead of
> > appearing before the "Reviewed-by:" and "Tested-by" tags as it had in
> > v13.
> > 
> > A little digging showed that my tag had been moved to the end by "b4 am"
> > when I used it to pick up some additonal tags.
> > 
> > An e-mail discussion with Konstantin ensued to determine if this was
> > a bug. Konstantin said:
> > 
> >    This is the intended behaviour, because b4 follows the chain-of-custody
> >    procedure. If we encounter a Signed-off-by trailer matching the identity of
> >    the user preparing the series, we move it to the bottom to indicate that the
> >    chain-of-custody boundary has moved to include the code review trailers
> >    received after the initial submission.
> > 
> >    https://lore.kernel.org/tools/20221031165842.vxr4kp6h7qnkc53l@meerkat.local/
> > 
> >    Basically, the "Signed-off-by" trailer is special because it indicates that
> >    everything above it is the responsibility of the person doing the sign-off. If
> >    we kept your Signed-off-by in the original spot, then it wouldn't be clear who
> >    collected and applied the trailers.
> 
> I can't find "chain of custody" anywhere in Documentation/process/, nor a
> specification or example of this ordering.
> 
> Where did this b4 requirement come from?

Many discussions at the Maintainer Summit and on the tools/users lists. E.g.:
https://lore.kernel.org/tools/20221031165842.vxr4kp6h7qnkc53l@meerkat.local/

The chain of custody approach is the only one that makes sense because it
allows keeping track of who applied which trailers. I know that most people
don't think about it twice, but it matters from the perspective of process.
If we need to put it into the official documentation, I'm happy to submit the
patch.

-K

