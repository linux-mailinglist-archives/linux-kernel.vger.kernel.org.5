Return-Path: <linux-kernel+bounces-51163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA96F84873D
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 16:57:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBF461C22AF6
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 15:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C723C5F55E;
	Sat,  3 Feb 2024 15:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mR3C3w+T"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C354554674;
	Sat,  3 Feb 2024 15:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706975849; cv=none; b=frEgUQLRF8JM8YtKWl0V7MxlybWlB2X0ALClGKrmFD5YekDPg+fiDg7cZG00krdBcR7TpKqSDtQEzEJ+hLaNRNNUOI1SUruL7+a4Wo/gOA5mFQ/2zF2o+zrlXvVjca86Pt3wL5IOyLmBT3FVFyppxw9L7fCQmMTV+be/uPnwGcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706975849; c=relaxed/simple;
	bh=BHcg/pyr2bxuPy4onVRUXGc1geuuTaQXdkQvJ0lueS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XEHXvmwIbkaNpKMwYy8wvBsaFyOaPs6oTb20RL7D8Qb8wMUO6vIs1yoQ8Bj1V5Tk/LNKv13pRs9LfLPISV5fLd89pCfk2qFu+3DzN1DtwfJ9LbxL6huJrydA/90kHzJZYawPoqRRsKp1TFjVBdlCVt2R0XrRq2WJ/p9INaXwfHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mR3C3w+T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B7B7C43390;
	Sat,  3 Feb 2024 15:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706975848;
	bh=BHcg/pyr2bxuPy4onVRUXGc1geuuTaQXdkQvJ0lueS0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mR3C3w+T0ij2fYGzN1DsdzK1kdv/p9H4gDhEfCh6Gr0NEu26YQFQ+tFmXGIqV3/eL
	 SKUCf0EEgV8AZPvv+ayQLFZ1c80MOgrKRNJ7N1tLpip0Ix/KoAkNaOVfsraOKyQ3Ir
	 5HbjnXfYipTYzII3lBqNOtS4md756eIc0J1/JS1I=
Date: Sat, 3 Feb 2024 06:46:11 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ronald Warsow <rwarsow@gmx.de>
Cc: stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.7 000/353] 6.7.4-rc1 review
Message-ID: <2024020343-handiness-nanometer-ae7d@gregkh>
References: <295b099e-3b60-416f-a28c-6d58bb5564bb@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <295b099e-3b60-416f-a28c-6d58bb5564bb@gmx.de>

On Sat, Feb 03, 2024 at 02:39:41PM +0100, Ronald Warsow wrote:
> Hi Greg
> 
> Kernel does *NOT* boot here on x86_64 (Intel Rocket Lake: i5-11400) and
> Fedora 39
> 
> just after grub the box is dead; not pingable, etc ...
> 
> 
> Thanks
> 
> Tested-by: Ronald Warsow <rwarsow@gmx.de>

I guess just not tested successfully :(

I'll look into all of these errors in a bit..


