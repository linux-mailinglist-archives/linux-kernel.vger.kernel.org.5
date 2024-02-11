Return-Path: <linux-kernel+bounces-60958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FDF9850B98
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 21:58:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D0532824D7
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 20:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 651495EE9B;
	Sun, 11 Feb 2024 20:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uCreMs31"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D828FBF3;
	Sun, 11 Feb 2024 20:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707685087; cv=none; b=LvmZ2HyrjZ0ThMIovXb++SqHihlfr6o7Lb08W42s2QE4gEh2cVKjbR99MN+ZholGPRjHxLlsMLzlUi4rmkhN4uKtDDN17Y3tVmCl0Jlnsev4EPq68fxGfq34I0UonjIRZdpfa8JNGKq8kn0O1LTOaaQdTAwLfb2mzdVZXgA0wGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707685087; c=relaxed/simple;
	bh=RrzSXXk7UtVwrZ1/WZdD3UuUAO/VH8ivj2LiH6i78pI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GyFt3QTzrNOi94kJ4qApgXEMDwwgcormQX4qdwp5uJSDARNax1hs3YItdORIdI1K+c7gTvGlXn4pnK2j4fQ5m1h1kBRKmYaHb4jOYQXClgMmBFZrZeUbp2nFFxVgop6HDpZ1vjt61v1zHKPxfkZnXP27kEoO8uLtO3NMrcFz/7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uCreMs31; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22AC1C433C7;
	Sun, 11 Feb 2024 20:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707685086;
	bh=RrzSXXk7UtVwrZ1/WZdD3UuUAO/VH8ivj2LiH6i78pI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uCreMs31bJp9DZQJdLJ6VTtdM57bYaq+dRdPIb4UXHb6g4uDbYcbmgQMm3vQU5rwY
	 xuUBE9e+S7itmXZ8vgmoYzqA6B/T5QFPZVfnWQshuDdntOEhx+F1EWsih20D3updw/
	 0SBkcvaWJsK+UbxedyXaq1qgeWRLvvFWJ/n//uWY=
Date: Sun, 11 Feb 2024 20:57:54 +0000
From: Greg KH <gregkh@linuxfoundation.org>
To: Shresth Prasad <shresthprasad7@gmail.com>
Cc: corbet@lwn.net, linux-doc@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	skhan@linuxfoundation.org
Subject: Re: [PATCH] Fix malformed table error in gadget-testing.rst
Message-ID: <2024021158-rewire-duplicity-c31c@gregkh>
References: <2024021159-banner-dramatic-af88@gregkh>
 <74d67b62-6fa4-4218-b51f-f0d33f19c422@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74d67b62-6fa4-4218-b51f-f0d33f19c422@gmail.com>

On Sun, Feb 11, 2024 at 06:24:24PM +0530, Shresth Prasad wrote:
> I see, sorry about that. I will try some other way to fix the error.

What error, sorry I see no context here (remember, some of us get 1000+
emails a day to do something with, context is key...)

> Also, as mentioned in this thread: https://lore.kernel.org/all/877cjqa5le.fsf@meer.lwn.net/ has the patch already been applied, fixing the issue?

What issue?  Always look in linux-next to see what has been accepted by
maintainers as that tree merges all of them together daily.

thanks,

greg k-h

