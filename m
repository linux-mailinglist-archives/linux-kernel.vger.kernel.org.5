Return-Path: <linux-kernel+bounces-51710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62D32848E80
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 15:38:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 947C51C21831
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 14:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 849B41EA7C;
	Sun,  4 Feb 2024 14:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eAuohSvd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C5F1DFF9;
	Sun,  4 Feb 2024 14:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707057491; cv=none; b=oy03UEJywJSU2qEVnJhs1LwfA3lTEcpXpy8tPJ8z9MmsW4Uu9DS8lJTEk6EDZhPXcyeWt3u8zLmj+Jc6NhVGkBs5I5Pjfkdip1guF/oGtgAGzLw3OOQTgzqccGlKbKz/qdrGl6yx/90vFVCDoTueKGtUKdF/c6yO4gJtfTf4EHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707057491; c=relaxed/simple;
	bh=flo1bTc5gzTLBv5FznMDPqVG0mHKrGqSp5h1FCjduXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p5gKds2I0a0eOWn8gECobvYVG992AahyzkC0uCf4ys0G1H0imRQ41Z1XOK62S+X6liFaYDjigQWCPW1NmpBKQvbxNQHdTQREMXCGfEA7COCdJBLV56Sgb2IXb83MHtF9Bob17keaay2ZoQg7BKyq4SsP+uzOh4BOJZo22xZ0Iqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eAuohSvd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22AD7C433C7;
	Sun,  4 Feb 2024 14:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707057491;
	bh=flo1bTc5gzTLBv5FznMDPqVG0mHKrGqSp5h1FCjduXc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eAuohSvd7jTAwXsdDAhjVDj6qV+smJcEcp3yCRmJ/T8WWlf8KkmH+6QrIhhg/GUwm
	 Vy593AOqlmjBv4szHI5tskpF86Mr0YGjWJv2tnw3KPTUsuCUMNDCTmLrE0CUKnrI3l
	 CQ9l13QFk/8pJVwNsIerDKR46/QywhITCe6ySQOY=
Date: Sun, 4 Feb 2024 06:38:10 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86: mce: make mce_subsys const
Message-ID: <2024020405-thickness-drainable-586a@gregkh>
References: <20240204-bus_cleanup-x86-v1-1-4e7171be88e8@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240204-bus_cleanup-x86-v1-1-4e7171be88e8@marliere.net>

On Sun, Feb 04, 2024 at 11:32:29AM -0300, Ricardo B. Marliere wrote:
> Now that the driver core can properly handle constant struct bus_type,
> move the mce_subsys variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
> ---
>  arch/x86/kernel/cpu/mce/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

