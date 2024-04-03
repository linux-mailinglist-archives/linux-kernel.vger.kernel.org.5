Return-Path: <linux-kernel+bounces-129044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B82418963B8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 06:55:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E913E1C22C03
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 04:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9BEA45C14;
	Wed,  3 Apr 2024 04:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aqEy1tPI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B4F17997;
	Wed,  3 Apr 2024 04:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712120112; cv=none; b=SvByVV+PfoYk9NuLjA9iym3DjcLFYwSvh6f8gLOjsPqdNbDR4DnQhMT88ju44BFJ9sSpIW3nxVlZBb+gjd3b3FCQsoRu9TZWTFTl7KxI/AGND1R+rVS8FmPTTFSt6o0z54otlOkolxW08g2ZPQklHqM+N0X9jqq1hGWPJuxaX3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712120112; c=relaxed/simple;
	bh=vazJuyjxoofb9Ekbi6HE7j4yNVxw4yDdMhz8fsrfbD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y/1sGcelgOy/ThiTJT7CUTbyd9a4e3nviZPDGPkdDa1mGatqR1QfzU5pU8sVopUFbJJMO0JxhBwgEZY5Fgu1HN9Ibn0vz/0xWRb4H88Jyj8sA/I1asC/lxxqAK9fqVe5GlZa/DcIUuWHQGJJ1ufb5U0a/VbTpEME3tL8qF6NQ30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aqEy1tPI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC5EBC433F1;
	Wed,  3 Apr 2024 04:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712120111;
	bh=vazJuyjxoofb9Ekbi6HE7j4yNVxw4yDdMhz8fsrfbD8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aqEy1tPISGkUi+taHmCJF0UGi7x/IGRDep1+clsJP8SKVYwED8SnpttONe7u6OEZ9
	 x4QXAg5cGX/ldD1Tdlt+RhfaZOR1ocC16gaBuJYwpKjTSTNdeZVXisv5E1gpXFvT+g
	 odZY3JDuQSAVhLkhB3wJgYsfn4dpgZdBUP3SHtdE=
Date: Wed, 3 Apr 2024 06:55:08 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Alexey Gladkov <legion@kernel.org>
Cc: Jiri Slaby <jirislaby@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	kbd@lists.linux.dev, linux-api@vger.kernel.org,
	linux-fbdev@vger.kernel.org, linux-serial@vger.kernel.org,
	Helge Deller <deller@gmx.de>
Subject: Re: [PATCH v4 2/3] VT: Add KDFONTINFO ioctl
Message-ID: <2024040306-unleash-scrubbed-1c2b@gregkh>
References: <74ca50e0-61b1-4d4c-85dd-a5d920548c04@kernel.org>
 <cover.1712080158.git.legion@kernel.org>
 <7cd32f988a147d7617742c9e074c753de0c6bc1f.1712080158.git.legion@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7cd32f988a147d7617742c9e074c753de0c6bc1f.1712080158.git.legion@kernel.org>

On Tue, Apr 02, 2024 at 07:50:45PM +0200, Alexey Gladkov wrote:
> +struct console_font_info {
> +	unsigned int min_width, min_height;	/* minimal font size */
> +	unsigned int max_width, max_height;	/* maximum font size */
> +	unsigned int flags;			/* KD_FONT_INFO_FLAG_* */
> +};

As Jiri said, this will not work for an ioctl structure at all, sorry.
Please read the kernel documentation about how to write a new ioctl for
how to do this correctly (hint, you can not use 'unsigned int' in a
structure that crosses the kernel/user boundry for new ioctls.)

thanks,

greg k-h

