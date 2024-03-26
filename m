Return-Path: <linux-kernel+bounces-119214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3405A88C5C1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:50:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D41D61F622AA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 14:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 363BA13C8EE;
	Tue, 26 Mar 2024 14:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aqQzgcLL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B5C13C819;
	Tue, 26 Mar 2024 14:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711464593; cv=none; b=fY0koFWY5bkXZ458I4zbdcZfzeEt8R2zo2SbDZtBeh4YFxxVrE8KTd2m8AigWIvOkTiAs1TRrWZXxFdEVTwMW26bIUPvK7OOIYCqd9HUEr4Qnbapg2nDiqI2xGqeHz8uQbsTLmCur86VsfU6Ce/+vkTG9a4fIUeQ67IZtCEDOeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711464593; c=relaxed/simple;
	bh=ASjwD7pJp1QVPdIY4VaqbkU4p3lWLNQhHSEK1Mb6Lq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gO1Idqe8SMikuRogbx5FQEWat/GMgFBr4/m+DGX6Hw12LR8tUKkfFVeg1vXtihNSgklrS+QfwJYSzCgGu1faXI4vb3HZ6dER4OiZcK7aghbO/zNcp/lUqcyk1L+fCVdtM42haowotQ9Od3RgxTZtZl/y2RF4Kswlp/+yYC1mnxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aqQzgcLL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06885C433C7;
	Tue, 26 Mar 2024 14:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711464593;
	bh=ASjwD7pJp1QVPdIY4VaqbkU4p3lWLNQhHSEK1Mb6Lq8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aqQzgcLL7LriJUPU7Yh/2d+4i6zlMg8hXgq61RPx4TPmVPv3xYYNjdOyYgwRMaB2k
	 r0ovk40QhDtJsrGOOL1Ic85pouWcMAJDgYmzZW7okzlmr93rkIvSw31iD5JE2y+Xte
	 ZBcVyEaWkldrOerHY3ziPriLLpnf7uPga7Sk1bOkPGFpbj+p3aEraYeDfhyjbtvXcT
	 OxGi7jiaKD1eefxYV9nPKei5XIDFcHYJAhNNbxWdqHR3Qa5Mj6dU7X2F5gMyHDD0Fp
	 yVmsyXug6tBhNLuEuVt9wiVtBij++7wQlKRHNqF0N6HkZvbgdkhQb4NGA8wgImHwe2
	 2XYezfyuKWwpQ==
Date: Tue, 26 Mar 2024 14:49:48 +0000
From: Simon Horman <horms@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Ariel Elior <aelior@marvell.com>, Manish Chopra <manishc@marvell.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] qed: Drop useless pci_params.pm_cap
Message-ID: <20240326144948.GC403975@kernel.org>
References: <20240325224931.1462051-1-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325224931.1462051-1-helgaas@kernel.org>

On Mon, Mar 25, 2024 at 05:49:31PM -0500, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> qed_init_pci() used pci_params.pm_cap only to cache the pci_dev.pm_cap.
> Drop the cache and use pci_dev.pm_cap directly.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Reviewed-by: Simon Horman <horms@kernel.org>


