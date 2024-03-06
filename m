Return-Path: <linux-kernel+bounces-94517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C5268740EF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 20:57:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F1521C22592
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 19:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED429140E47;
	Wed,  6 Mar 2024 19:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iH0uVJxK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC7313BAD1;
	Wed,  6 Mar 2024 19:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709755042; cv=none; b=FE2qy2HtVceMf086WIKiSiVEJx7xKdgD0MXeV8a/9z2nPtNOloY0hCGsISUE8zdMHjxQ8HLIHy0Jlv4J6r+MdOPcfAcEltQFcWp8d8E6NRgEexlIGNXQibEd+U5HOorzE4bQDyI/2pLZ2ulTqZ5Ep2vLJ/VFsDOEgNNAp8XMtZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709755042; c=relaxed/simple;
	bh=FrZM9/NpMZO0H7AxedaNNRXVQwK+EczmRjOtbnNzbCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WLRHtsO+uBy8979+UFrv0sGuRyJeb07uBG6DL5RJiLCf7dGWP9kS6Bm+/A+9pgXXYl4mlkGfg2+U0OVB/eSI6vggwgD3QS0xLKfB07QwidkW1aszT0XRJ/8vIIOlVwv1TsJ7vFevxDGZ0nyryVfgmwPFW4XFhotfw51S3uIQ/+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iH0uVJxK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78DF3C433C7;
	Wed,  6 Mar 2024 19:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709755041;
	bh=FrZM9/NpMZO0H7AxedaNNRXVQwK+EczmRjOtbnNzbCo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iH0uVJxK2l/proJ8NcdS3CqjBdIc9tnlErFAew8xomn7JMK8RJemzOHCR3qKmlR83
	 BwvJRRHcdjPXVg0+rL0pNJscF3p3thL5ntwUPt3aIl6LdIwn0rBwuJ6cNaX/EPZxPJ
	 NiqH3a1NgCaEk6V6VNSPLYQFgPcNNdkWEBaPW0rX+YGeqS7n1G1UNZrft+XUP7eCE6
	 gzZnjkZ1KbuoQqq0QKL6aAU4IEY17UrLp5DPiY9Dpw81H8z+T8k7KOjrNwaFfrHM8J
	 gvHx07BCQVoq/P3X7TOwQjFA0Q8P6O6nCu0hehprvJt1jG+F6r5G2gnjYL+RHmlyA9
	 WdOJ2p7UmSVxw==
Date: Wed, 6 Mar 2024 19:57:18 +0000
From: Simon Horman <horms@kernel.org>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Richard Cochran <richardcochran@gmail.com>,
	Yangbo Lu <yangbo.lu@nxp.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] ptp: make ptp_class constant
Message-ID: <20240306195718.GF281974@kernel.org>
References: <20240305-ptp-v1-1-ed253eb33c20@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240305-ptp-v1-1-ed253eb33c20@marliere.net>

On Tue, Mar 05, 2024 at 05:11:27PM -0300, Ricardo B. Marliere wrote:
> Since commit 43a7206b0963 ("driver core: class: make class_register() take
> a const *"), the driver core allows for struct class to be in read-only
> memory, so move the ptp_class structure to be declared at build time
> placing it into read-only memory, instead of having to be dynamically
> allocated at boot time.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

Reviewed-by: Simon Horman <horms@kernel.org>


