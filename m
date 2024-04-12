Return-Path: <linux-kernel+bounces-141792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B5C58A237B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 03:55:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC575287EDE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 01:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E8FD299;
	Fri, 12 Apr 2024 01:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F4qUY9DS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62D917583;
	Fri, 12 Apr 2024 01:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712886919; cv=none; b=JSTgDlLbOO5NakJ35EtXm0prODC32zRJLNFUJalhA3DVzQ15OM7VEZGmLh5J27dUXPEj2dHNsdEiNXteSa78/Tydc/qPlc7ojvilfH++PwynkHWqVqLN42mMXyfJRqqPwvAc04riFUXnytNWeMCStHKjcxRiLB7m7nIVd0+W9JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712886919; c=relaxed/simple;
	bh=W2wfHHl5eQfxsGy9XPPEQ/hafANAsKw1RxAzJY0DEuE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QeNXxcpIA9/+Hd8j4RKEb1Pdja2XNxk1X4MCMjJ/YwnnbgBPcQm0oe9X6UxWVikAjQfv7vXeR5J1G27fi7iyR8YvuRU5ZB56nv+O8y64uiR1P35KRTJCHIW6cwRiDX4wwdF3QGX61ancjk6/XeWFyBjyo1jA2+/5XMC/MfnGFrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F4qUY9DS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D769BC072AA;
	Fri, 12 Apr 2024 01:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712886919;
	bh=W2wfHHl5eQfxsGy9XPPEQ/hafANAsKw1RxAzJY0DEuE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=F4qUY9DS/UIxVMYEdDu1w4k5RvnyGQvFjhPQtQ6ohJxvY5ZEB9KvAJxZ941XUYuop
	 kP+8n9W0pwSIhgzFIR8H/b73Pwe7IrmfusP5pBZ7NHyu7Pdav0VbMDs4D65d2qSoa6
	 NwPfFSwYg6XjsDF7ksb+YEkIo6jniFqvqgEg108zPsbKiDM8QP7cE8jvTnwvlZNnAO
	 LPnm7GUTVhXgyq1WgHrGmekyWhSv7ab/S3sDlKN6khnRkfz4jD/UxH4pgC//rlIUIF
	 LPMm2pGMXbf+oSYVCzzzI5QaSoEYDm2IJuLwSnizkUhTXVLgROtdUlpjJa69l+qx7I
	 BmSlqnr0tJhXg==
Date: Thu, 11 Apr 2024 18:55:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Lee Jones <lee@kernel.org>, Min Li <lnimi@hotmail.com>
Cc: richardcochran@gmail.com, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, Min Li <min.li.xe@renesas.com>
Subject: Re: [PATCH net-next v2 1/1] ptp: 82p33: move register definitions
 out of ptp folder
Message-ID: <20240411185517.153a7dff@kernel.org>
In-Reply-To: <20240411163240.GI2399047@google.com>
References: <LV3P220MB12026EB15790ABE932799E53A0062@LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM>
	<20240411163240.GI2399047@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 11 Apr 2024 17:32:40 +0100 Lee Jones wrote:
> > From: Min Li <min.li.xe@renesas.com>
> > 
> > Relocate idt82p33 register definitions so that other multi-functional
> > devices can access those definitions.

What I was asking for was to mention the other drivers which will make
use of the header _in the future_.

Really, it'd be best if the patch was part of a patchset which adds
a driver that needs it...

> > Signed-off-by: Min Li <min.li.xe@renesas.com>
> > ---
> > Submit to net-next and add driver name suggested by Jakub
> > 
> >  drivers/ptp/ptp_idt82p33.h       | 27 -----------------------
> >  include/linux/mfd/idt82p33_reg.h | 38 +++++++++++++++++++++++++++++---  
> 
> Why does this need to go into net-next?

No preference here, FWIW

