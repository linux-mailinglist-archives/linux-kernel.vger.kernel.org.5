Return-Path: <linux-kernel+bounces-69829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AD43E858F2E
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 12:56:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 383A1B21FFF
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 11:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A89D6A01E;
	Sat, 17 Feb 2024 11:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bmwFHsR1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E37E69E03;
	Sat, 17 Feb 2024 11:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708170971; cv=none; b=Crv9j2x1McI+1MzPx75xPZrX5jCMnJe3amJv9Dj6Z15k6qksuOc03he7hkSeUd9/Q7IZ2lmiU/17vUDE6Pnnc15IYPaatCgQn+DlYpYeuZsV/BkjO7hT9BrkJM0DF9IDfQXHqKpwN4woZ3fOIzz60OmTo4bWhMtziI9bCmYiKYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708170971; c=relaxed/simple;
	bh=G4oVzcLV/ykkxbfQ9i2WyOmmFAhJ7hFVEiqulSQ7rtA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rKhSkJAr7inuwH27P1mUEp3XuGfZzp+0+WIjR1Z9qTmq70wMipNXK09vKjuRnzMtBP+yEBJl/OlRDPucAJN34N7vWW+b/pfpu9JOEHbuGU4AAIs8KRqLe80cTpOOpJjORJ/JD/92wdRdVN05iEyIl/87Hg2+d0eZ8x5ZE5jiUAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bmwFHsR1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 895E3C433F1;
	Sat, 17 Feb 2024 11:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708170971;
	bh=G4oVzcLV/ykkxbfQ9i2WyOmmFAhJ7hFVEiqulSQ7rtA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bmwFHsR1utDNz5Ddraahz5/SdD9hSFNbRecKfb7nwYqrZGXJGjv/uHUFWYiuvnTPG
	 Y6GuyEp8+jJfD0xeVcsiez5Hs/DaOLs0Dkyk3SNColG5GtpyIYPMtw6wRItVyanO+Z
	 KTzjO9XQ6s0LqxzOX2KmhMekuAIo1++1Mk2qtUVQ=
Date: Sat, 17 Feb 2024 12:56:07 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Jani Nikula <jani.nikula@intel.com>,
	Vegard Nossum <vegard.nossum@oracle.com>, workflows@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	security@kernel.org, Kees Cook <keescook@chromium.org>,
	Sasha Levin <sashal@kernel.org>, Lee Jones <lee@kernel.org>
Subject: Re: [PATCH v3] Documentation: Document the Linux Kernel CVE process
Message-ID: <2024021751-impulsive-vanity-b799@gregkh>
References: <2024021430-blanching-spotter-c7c8@gregkh>
 <00057b93-b5fc-4536-b13d-cd3b6cead5b1@oracle.com>
 <2024021530-plank-cornmeal-90eb@gregkh>
 <26b25204-9829-44a8-9836-1ce1c8725586@oracle.com>
 <87v86o4xu0.fsf@intel.com>
 <2024021619-barrack-shack-206c@gregkh>
 <87r0hcv4lj.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r0hcv4lj.fsf@meer.lwn.net>

On Fri, Feb 16, 2024 at 07:58:00AM -0700, Jonathan Corbet wrote:
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
> 
> > On Fri, Feb 16, 2024 at 10:28:39AM +0200, Jani Nikula wrote:
> >> rst basically allows any order of the heading underlines, and their
> >> relative hierarchy is determined by how they show up in each document,
> >> it's not specified by rst. However, it would be much easier for everyone
> >> if all the kernel documents followed the same style.
> >
> > Agreed, someone should pick a style and sweep the whole directory and
> > sync them up to the agreed formatting. :)
> 
> Somebody did pick a style, it's in Documentation/doc-guide/sphinx.rst :)

Fair enough, I'll go fix up the file headers here :)

thanks,

greg k-h

