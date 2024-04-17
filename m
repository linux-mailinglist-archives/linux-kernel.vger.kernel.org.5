Return-Path: <linux-kernel+bounces-148583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B4598A84BC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 15:32:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C0AB1F23AAA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 13:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB363142912;
	Wed, 17 Apr 2024 13:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="S+2TnFv4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277C2140381;
	Wed, 17 Apr 2024 13:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713360607; cv=none; b=UAapLek0ysUvc4urlruDuIP+M8bVgVem9WOiAOB9FTt0E8W2reveBOc2v+ZoFN55btVN8YZmHjYR2wumXMoOa07vsasdmS8pshkjGBmEwN18+o6G3IdKNoYori2WQRXRhbPx4ra0xoLnvvRKJ+kKwY4y6izeOrMvqolRWhu9mac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713360607; c=relaxed/simple;
	bh=GyHbhmJ+9xPNnXgNXVIFixxq2fw78zbU6823wMnDiuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GQ0kyVzdwWI/QWq1ydR7wd6EVKo98Wzta6ISnRBoC5R3RbqE6zLjoyvFH83cs1blaapffPR1SCjKEgHtD1uIAsu8wfNkg24Vl+gtcRN0+6MddfIc0fE12SvO4WWLfqgU1UBbMX8bhL3klQAzP7bfNCxGYJUBkY5OiXnGwdqJ/Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=S+2TnFv4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88FABC072AA;
	Wed, 17 Apr 2024 13:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713360606;
	bh=GyHbhmJ+9xPNnXgNXVIFixxq2fw78zbU6823wMnDiuw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S+2TnFv4zen3mDTIhf+eb4GHfX2E0l85VNscHmwnOqsEWCHDzjxB5yuUrFjArq9V3
	 dFu60UNJL/uXIO2Nff4vEmJBJ3022OHGn6kxVEQG4JNH64PGZONcfxb8ObHx9KbxZO
	 X6aIO7dNJUszGvkt1u/v4oUnNcdlFYA+P7myXtWA=
Date: Wed, 17 Apr 2024 15:30:03 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jan Kara <jack@suse.cz>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org,
	linux-cve-announce@vger.kernel.org
Subject: Re: CVE-2024-26774: ext4: avoid dividing by 0 in
 mb_update_avg_fragment_size() when block bitmap corrupt
Message-ID: <2024041711-chapter-uninstall-b1d3@gregkh>
References: <2024040308-CVE-2024-26774-52d9@gregkh>
 <20240417114324.c77wuw5hvjbm6ok5@quack3>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240417114324.c77wuw5hvjbm6ok5@quack3>

On Wed, Apr 17, 2024 at 01:43:24PM +0200, Jan Kara wrote:
> Hello!
> 
> On Wed 03-04-24 19:31:41, Greg Kroah-Hartman wrote:
> > Description
> > ===========
> > 
> > In the Linux kernel, the following vulnerability has been resolved:
> > 
> > ext4: avoid dividing by 0 in mb_update_avg_fragment_size() when block bitmap corrupt
> > 
> > Determine if bb_fragments is 0 instead of determining bb_free to eliminate
> > the risk of dividing by zero when the block bitmap is corrupted.
> > 
> > The Linux kernel CVE team has assigned CVE-2024-26774 to this issue.
> 
> I'd like to understand what is the imagined security threat fixed by this
> patch (as multiple patches of similar nature got assigned a CVE). The patch
> fixes a bug that if a corrupted filesystem is read-write mounted, we can do
> division-by-zero. Now if you can make the system mount a corrupted
> filesystem, you can do many interesting things to the system other than
> create a division by zero... So what is the presumed threat model here?

Exactly what you said, "if you mount a corrupted file system, you will
get a divide by zero fault."

Many systems auto-mount any filesystem plugged into it.  If yours do
not, then yours does not need to worry about this type of CVE.

thanks,

greg k-h

