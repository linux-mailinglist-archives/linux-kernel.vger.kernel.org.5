Return-Path: <linux-kernel+bounces-145686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 75DEF8A5983
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 20:02:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CB1DB2275F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 18:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D4D913A26E;
	Mon, 15 Apr 2024 18:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="C8a4cA1i"
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AABD91E877;
	Mon, 15 Apr 2024 18:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713204161; cv=none; b=q33eoqDpd8UHFOD3DxOnwUx3qNxpMXA2Tmmp9XtzOy5ZS/uDokgo39ZQfzwf2/In/PAp9RtkMuyyFUFguUd6waPn9krbgOwS1wzQEyZRQ7EYzCaS2TrTME0SJDiFpvKgAR2MOS5ATsd0BVDdULa8dZRaBId73NypLpKm8j0BMrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713204161; c=relaxed/simple;
	bh=jjRA8zXzvN3+cUuLH6NQmwsAUi5CL+5L4B90taz/wa0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kvL3mtDfGUiMVXNvjw8Iz4LtHaMp3IuU7HVvzFwIEe6ErGDaZvp0Y7iRz+qvDLPLwGMihMa/MKrJgYP6R46TUB5OEm/gthA1AgcHN/GT4uO6CsNnhzG1QCerC/pRjiS0Fl8nMypYaU0dc4sUXoJeMK5Du3OzkeHReRy1Aisd7RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=C8a4cA1i; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 15 Apr 2024 14:02:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1713204156;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BvG3OA4w+Lj+qFTRz9zvJBh1oQGpJxeKv6GShdGzH/k=;
	b=C8a4cA1ivcG5Bo7GDT8vVtf5hr3IqHQvcKX+4O0fFKHUHgmIX1sthSt0u8U3kKTqaSIi+V
	/lt41/u+rU12oYkxjHuLrF/5lHiSYArGy10tPc0cEinynEE6E3q+T0spsmyRA3XSbE5EEd
	YiX+R37zTKLup25G96rRs4KCJNxe5Gs=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Johannes Berg <johannes.berg@intel.com>, 
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: debugfs revoke broken?
Message-ID: <ra3ig25pwua6wm6v7vqexjvwybfpk23i5qqfeihth4f3zygjb6@7ykqlkyu25tb>
References: <nxucitm2agdzdodrkm5rjyuwnnf6keivjiqlp5rn6poxkpkye6@yor2lprsxh7x>
 <2024041557-stereo-wafer-1551@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024041557-stereo-wafer-1551@gregkh>
X-Migadu-Flow: FLOW_OUT

On Mon, Apr 15, 2024 at 10:47:56AM +0200, Greg Kroah-Hartman wrote:
> So this file was open when debugfs_remove() was called?

Seems likely.

> Any chance you can bisect?  We just fixed some issues here in
> 952c3fce297f ("debugfs: fix wait/cancellation handling during remove")
> that I thought should have handled this.  If you revert that commit,
> does things work again?  And/or what about commit 8c88a474357e
> ("debugfs: add API to allow debugfs operations cancellation")?  Maybe we
> need to go back to not having completions at all in the debugfs remove
> path and just live with waiting for the files to be removed before
> continuing (which should at the least, resolve the issue you see here,
> while slowing things down a bit.)

No, this doesn't occur often enough to bisect, unfortunately. All my
tests bang on sysfs/debugfs in the background to torture test those
codepaths, and I've seen 2 occurrences out of thousands of test runs -
it's rare.

