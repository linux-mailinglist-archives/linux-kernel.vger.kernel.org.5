Return-Path: <linux-kernel+bounces-89561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 180F086F210
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 20:18:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BEDBB22854
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 19:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F9CE3FE2C;
	Sat,  2 Mar 2024 19:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ri5Wpm/p"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842143FE24
	for <linux-kernel@vger.kernel.org>; Sat,  2 Mar 2024 19:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709407084; cv=none; b=svYkiVBb+IbCURNwHBYRBI1KfzEomwSolvGOqOobOBhgxue9iC1dY9scureMXMVXKOYmYFbOvGkBGcJWBziBjGV0eOYmiolaorlVSUZCXHwuhBp3Q4qr+WIUHtUQVpRAheQQ2ESnab9VrkqxDfjP4EUDnQkA0QaH8icWcSjPhIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709407084; c=relaxed/simple;
	bh=73tufg7F9PcvUWhSUKRUkd+MM0aMTwIJLsJKSCK5tSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uZhPcF8X66Wuamwa5m28a9YQ6cx9n96wX4ckhZX3PWJlUmnKjA6BtVNfy4S6j4SI1WcEBGsOdTNoSPBhD/Q1ULnYZtX5laclckArF1cQIrzCq42dTn666ACtT8Rj+2oTlGUAkVtd10TZoTaNb7HmG6a6GFbyzsW3jcRIQl1nALA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ri5Wpm/p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B2F1C433F1;
	Sat,  2 Mar 2024 19:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709407084;
	bh=73tufg7F9PcvUWhSUKRUkd+MM0aMTwIJLsJKSCK5tSg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ri5Wpm/pHTZN7Xup+8/q2ljNV/jQrQmyL3rZ37d/JvdR664ttCeEGxDtRSid7ac3J
	 15NKMVzcKPLxcEF22CZVPLr38xxpaFIv8CVo2b8Z4ErRrjmo6TGJkOdM0xUoO8GH/D
	 AOgfSvto5yBJMM+KB3F8FeK9hmt5zpqJwH/n5z1M=
Date: Sat, 2 Mar 2024 20:16:53 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [GIT PULL] w1: drivers for v6.9
Message-ID: <2024030246-overhead-happening-9e62@gregkh>
References: <20240227083942.37722-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240227083942.37722-1-krzysztof.kozlowski@linaro.org>

On Tue, Feb 27, 2024 at 09:39:42AM +0100, Krzysztof Kozlowski wrote:
> Hi,
> 
> On top of tty-next branch (from 6th of Feb).
> 
> Best regards,
> Krzysztof
> 
> 
> The following changes since commit 6cc3028f797a549f256d593867a769ab6a8265f2:
> 
>   tty: vt: decrypt magic constants in vc_is_control() (2024-02-06 14:37:39 +0000)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-w1.git tags/w1-drv-6.9

Pulled and pushed out, thanks.

greg k-h

