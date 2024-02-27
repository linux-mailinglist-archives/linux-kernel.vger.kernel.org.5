Return-Path: <linux-kernel+bounces-82858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDCFF868AB4
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 09:22:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B85F1C2105B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 08:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B93E25644F;
	Tue, 27 Feb 2024 08:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UGKMKj+c"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A7C56460;
	Tue, 27 Feb 2024 08:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709022166; cv=none; b=svrmAAssapWhi6DnDQF9F9ClM9YYbE1Cxvhd23o+LX7m3ZKshXnNCqDz0aXZEvadQ66upMvqzN7rJDLATiX/lxSI5ZPc2AGiuAy1BykBo4/JV5yWXmg+uCUD/aym1bVgaVBYBSaSb1okNfMSxF/oA4tTCIewd6mCHT823LUm4gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709022166; c=relaxed/simple;
	bh=D36nw/Xki/5+V0cvqQD3tqm2AVDQqAhbQkABgw3cuqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QJVWkHbRqGJLb+DjQNezBrMXO4mWOhifv4IhIvZowaEzk/u81SDdMS43PO6HFo62+st19GcF1GCPhH6UiglS/3jt0L0rKKzY3yfR4i2Yr/II1V3irOSOASu2pepMMXJ4W4rNyp0PDKdMtkAKQgElbzXKY05VTT06dXyaw82O2kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UGKMKj+c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB284C433F1;
	Tue, 27 Feb 2024 08:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709022165;
	bh=D36nw/Xki/5+V0cvqQD3tqm2AVDQqAhbQkABgw3cuqw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UGKMKj+caAJuQ1O+HRzr9PJd8SsWHLbP7YifVvRTyb6l6a//t78a2a8DuxY74h5GR
	 9FKLxQnmu4bkEpYgUPoQCpIxVKcl3im23sTr2xs0YkIwXgREMIN7Bm6CKqtbr5awkA
	 3+ZTKnTRAulsGsxMU0fmqVOwVGPPvdembrqlN1lk=
Date: Tue, 27 Feb 2024 09:22:42 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Michael Harris <michaelharriscode@gmail.com>
Cc: hdegoede@redhat.com, Larry.Finger@lwfinger.net,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Staging: rtl8723bs: hal_btcoex: fixed styling issues
Message-ID: <2024022720-parted-ecologist-43af@gregkh>
References: <20240227080943.13032-1-michaelharriscode@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240227080943.13032-1-michaelharriscode@gmail.com>

On Tue, Feb 27, 2024 at 12:09:43AM -0800, Michael Harris wrote:
> Fixed various checkpatch.pl styling issues: spaces before tabs, constants being on left side of comparisons, unnecessary braces, etc.
> 
> Signed-off-by: Michael Harris <michaelharriscode@gmail.com>
> ---
>  drivers/staging/rtl8723bs/hal/hal_btcoex.c | 78 +++++++++++-----------
>  1 file changed, 40 insertions(+), 38 deletions(-)

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- Your patch did many different things all at once, making it difficult
  to review.  All Linux kernel patches need to only do one thing at a
  time.  If you need to do multiple things (such as clean up all coding
  style issues in a file/driver), do it in a sequence of patches, each
  one doing only one thing.  This will make it easier to review the
  patches to ensure that they are correct, and to help alleviate any
  merge issues that larger patches can cause.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

