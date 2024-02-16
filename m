Return-Path: <linux-kernel+bounces-68514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B7A857B7E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 12:23:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58E321C23C01
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 11:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 223E1768F5;
	Fri, 16 Feb 2024 11:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FXBusB7i"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42628768ED;
	Fri, 16 Feb 2024 11:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708082568; cv=none; b=BqghZOrrAqPadwIOhSu8E0d4KIb1Cxch1Hcp1PeaSUGRkFWHr4gPPLzOrCUxbWgdL+F+mjM94hDY4+w3gqCmsm2vYqlrxgoLva21U82fiu3JbfRyL0MnyRef/ONqTjcdIA5ZrpLB0PMyoI1I7wJujnXLZTl1tdyYkqnQUQbqznI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708082568; c=relaxed/simple;
	bh=w6cCBXR4zlZbDLGLQiSrai5ihqlxj3TUoet3Mpn54QM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A0+e7k439H8+X/BApTfbAULRkqa83SaiQJ/r8+D9ld40YY18MZoPe1Eeag1Z3iyPgCm4sa7L7o8I5v4GfrNmz2kQ9sErDgGFzlVyRSE7ZD7h+dc5kOHv1HgU13gv1St3njPOXEnqsD1n1mm+LSGJx0x3e21z0OcRDJF7qV05iEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FXBusB7i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CB99C433F1;
	Fri, 16 Feb 2024 11:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708082567;
	bh=w6cCBXR4zlZbDLGLQiSrai5ihqlxj3TUoet3Mpn54QM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FXBusB7i4GGrbqA1HcqgpW6yuOkkjfHp4HV1ws1iNvTVFEfxGx39cHZ6gMM5Z5M5a
	 iAT6kUddYZWaG9E3fWopXcaWAKeBoAyimc+QxFdZ+r7ucI9xFuOlatkEZrAOgt5+51
	 tuUPF+G5HokBmbm4YMOcHA+OafkOLc+YlXwouJQE=
Date: Fri, 16 Feb 2024 12:22:44 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jani Nikula <jani.nikula@intel.com>
Cc: Vegard Nossum <vegard.nossum@oracle.com>, corbet@lwn.net,
	workflows@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, security@kernel.org,
	Kees Cook <keescook@chromium.org>, Sasha Levin <sashal@kernel.org>,
	Lee Jones <lee@kernel.org>
Subject: Re: [PATCH v3] Documentation: Document the Linux Kernel CVE process
Message-ID: <2024021619-barrack-shack-206c@gregkh>
References: <2024021430-blanching-spotter-c7c8@gregkh>
 <00057b93-b5fc-4536-b13d-cd3b6cead5b1@oracle.com>
 <2024021530-plank-cornmeal-90eb@gregkh>
 <26b25204-9829-44a8-9836-1ce1c8725586@oracle.com>
 <87v86o4xu0.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v86o4xu0.fsf@intel.com>

On Fri, Feb 16, 2024 at 10:28:39AM +0200, Jani Nikula wrote:
> On Thu, 15 Feb 2024, Vegard Nossum <vegard.nossum@oracle.com> wrote:
> > On 15/02/2024 12:50, Greg Kroah-Hartman wrote:
> >> On Wed, Feb 14, 2024 at 09:37:31AM +0100, Vegard Nossum wrote:
> >>> Document titles should have ==== above them as well, and then you would
> >>> need to shift all the other headings in this document (i.e. all the ---
> >>> should become ===).
> >>>
> >>> Info here: https://docs.kernel.org/doc-guide/sphinx.html#specific-guidelines-for-the-kernel-documentation
> >> 
> >> Really?  I copied this directly from
> >> Documentation/process/security-bugs.rst which is in the format that I
> >> used here.  Which one is incorrect, I'm confused.
> >
> > Documentation/ currently has a mix of both formats and they both work,
> > but the guidelines linked above is the gold standard and what we should
> > aim for in new documents.
> >
> > The "correct" format would thus be:
> >
> > ====
> > CVEs
> > ====
> >
> > ...
> >
> > Process
> > =======
> >
> > ...
> >
> > At least this is my understanding; I'm happy to be corrected (and in
> > this case, we should also update the documentation).
> 
> rst basically allows any order of the heading underlines, and their
> relative hierarchy is determined by how they show up in each document,
> it's not specified by rst. However, it would be much easier for everyone
> if all the kernel documents followed the same style.

Agreed, someone should pick a style and sweep the whole directory and
sync them up to the agreed formatting. :)

thanks,

greg k-h

