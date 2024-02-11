Return-Path: <linux-kernel+bounces-60703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 003998508B7
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 11:54:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32C741C21218
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 10:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42DF55A4CD;
	Sun, 11 Feb 2024 10:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xonQOv+c"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5540A36102;
	Sun, 11 Feb 2024 10:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707648882; cv=none; b=ZxXWqZH7Rn1nv65TvZGI1DBwLlMZJC5p7WET4syB/TMbJrfbWqvc4yuN3RbLRujawj1UhqDoWq/gkOG0DJUiXMetxzOMwHrfzGoGTQpkaeTLZaBy4mhuisBy90Mjl6Wr3LyW14DPDIa3TSlXGsWmdV4ydySkatHjnjlMVMFKlDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707648882; c=relaxed/simple;
	bh=XidJr1ZlQjXr0bF6dE9gAFyg9lk16J+ooF1DK7KJovc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mYeDV/GUAUw0iUZ16/EMDXTLRkGCjlul3BKHbwpmDm07qTk//SAs9Qwxt3iK5BHkCS9Vi8jNNRhbZAAeywpOzXGfv2G40OwVzE6pCrAWZaZjwdBM2opFj5Jugx+do7aFc7wpjHKRPtik9zI9FDD+QdsQZv4ga8vmBvOB/0Tlj0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xonQOv+c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84B1DC433F1;
	Sun, 11 Feb 2024 10:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707648881;
	bh=XidJr1ZlQjXr0bF6dE9gAFyg9lk16J+ooF1DK7KJovc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=xonQOv+crnNzxpR41yVlGsPJsZWPjzgfG1UGAYv1pRg6BgcAd0besjn4nzOtRO0/G
	 TItMQ8vp9vkV8JpXhj/lcnReUVXHQP92WEnRwUdgcsi4OXpV6PaUofBrtnkzTiFSO5
	 54fFSdqBXe8r30QxZM43Fwo9lF4jA1YZT4o2FD8c=
Date: Sun, 11 Feb 2024 10:54:38 +0000
From: Greg KH <gregkh@linuxfoundation.org>
To: Shresth Prasad <shresthprasad7@gmail.com>
Cc: corbet@lwn.net, linux-usb@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] Fix malformed table error in gadget-testing.rst
Message-ID: <2024021159-banner-dramatic-af88@gregkh>
References: <20240211101324.37266-1-shresthprasad7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240211101324.37266-1-shresthprasad7@gmail.com>

On Sun, Feb 11, 2024 at 03:43:24PM +0530, Shresth Prasad wrote:
> I've replaced all tabs with 8 spaces in gadget-testing.rst so that the
> document is easier to work with. This also fixes a malformed table error
> emitted while compliling the docs.

Please no, tabs are tabs and we all know they are on the 8 character
boundry, so they can stay as-is.

sorry,

greg k-h

