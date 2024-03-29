Return-Path: <linux-kernel+bounces-124709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B811F891BAD
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:30:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA4781C2692F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A48A8136E01;
	Fri, 29 Mar 2024 12:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aIwAwshY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CE813664E;
	Fri, 29 Mar 2024 12:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715931; cv=none; b=hKyXHQ203bPVFeDCFalPnUK59cQ2+Vm4g9JV3uCiUcmUU1lk+mpvve4APMlj4PRsK0Sb1yzPRMU1sJbRmB0X/b0/abaV4szq39VRnwo3+WVKX+LdqjA4+cOejIETOcewXrz8AygxgBSP+5qJbCIqWlKfW14GBkRAGgKNRNorLzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715931; c=relaxed/simple;
	bh=7OCE6E+V/uRCmyJIcNCPSK5hYqaC8YBhEdwTeGxys3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UcnvqbLis9BVhgBtwhzKOPNr2KELtBeKKKPe/Pp1yRi6y7vrOwY50dqO9kbWf1U98NKdKzEgygC7wNsY6fBeBEFckNhyyqgi9w428QsS8orU6eyUPfeCxE1v7uJnGHBHDcpMPxPwkOzSR7WNUwyUHFVgoKpzexAZRTwSmgTNlQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aIwAwshY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED5EFC433C7;
	Fri, 29 Mar 2024 12:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711715931;
	bh=7OCE6E+V/uRCmyJIcNCPSK5hYqaC8YBhEdwTeGxys3M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aIwAwshYuhXNwu5+OKWbn6PPzRD2Q1fuTJPxJF5b6wNOFJ0B1iC69LpdDDWMfqi/Y
	 OJkKAH3fz/dAmmchsiOtbPx9n6ux59ANT3v0YZHBVtbgCaH+N69RYgaXibPVb16NP/
	 0NhzBe0hDWb3cT9OoO+gYoillLKprEn8qXLMNYxk=
Date: Fri, 29 Mar 2024 13:38:48 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: genjian zhang <zhanggenjian@126.com>
Cc: stable@vger.kernel.org, axboe@kernel.dk, stable@kernel.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	zhanggenjian123@gmail.com, Genjian Zhang <zhanggenjian@kylinos.cn>
Subject: Re: Re: [PATCH 4.19.y 0/9] Fix the UAF issue caused by the loop
 driver
Message-ID: <2024032938-preface-reassure-a1f4@gregkh>
References: <20240301013028.2293831-1-zhanggenjian@126.com>
 <2024030421-obedient-unbalance-a728@gregkh>
 <1d74f009.2179.18e16c2d99f.Coremail.zhanggenjian@126.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1d74f009.2179.18e16c2d99f.Coremail.zhanggenjian@126.com>

On Thu, Mar 07, 2024 at 10:34:12AM +0800, genjian zhang wrote:
> 
> At 2024-03-04 21:31:20, "Greg KH" <gregkh@linuxfoundation.org> wrote:
> >On Fri, Mar 01, 2024 at 09:30:19AM +0800, Genjian wrote:
> >> From: Genjian Zhang <zhanggenjian@kylinos.cn>
> >> 
> >> Hello!
> >> 
> >> We found that 2035c770bfdb ("loop: Check for overflow while configuring loop") lost a unlock loop_ctl_mutex in loop_get_status(...).
> >> which caused syzbot to report a UAF issue. However, the upstream patch does not have this issue.
> >> So, we revert this patch and directly apply the unmodified upstream patch.
> >> 
> >> Risk use-after-free as reported by syzbot：
> >
> >This looks good, but you are backporting commits that are NOT in newer
> >stable releases (i.e. from 5.8 but the commit is not in 5.4.y), is that
> >intentional?
> >
> >Does 5.4.y also have this problem?  If so, can you send a series that
> >fixes that up so I can take both of them at the same time?
> >
> >thanks,
> >
> >greg k-h
> 
> Thank you for your advice. This problem also exists in 5.4.y. 
> I will send a series of patches for 5.4.y.

All now queued up, thanks!

greg k-h

