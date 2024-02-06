Return-Path: <linux-kernel+bounces-55608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8152084BEE5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 21:48:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D869289C4A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 20:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 702521B944;
	Tue,  6 Feb 2024 20:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TgxoSG1r"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6041B940;
	Tue,  6 Feb 2024 20:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707252477; cv=none; b=kb+z4UmDujdt5sn4L9VNBjowQq0cJWmb8FFbC9u2MZFlsg0kxb0+k6dErF8pkWULprHa5gE993hRLKz/Fu8xodpfcc7zzfvDOkC4A8PI4nTGq8V7+vDybJNqlgVtLVZImsPqtqw4jClEHyqWn46N7GB9abitsBtVAxiYRUP5R44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707252477; c=relaxed/simple;
	bh=Jg40ieHbXF/G6oXsaLbvVU0RA1nGUVs4Ekk/gOizNXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pSnbXnZOYyws84JjFp+iw2WapqSUzZMOB8BcHVAHUwSvTq2hsF42/ffRtGxGkLwm6VJLH/9C1zytAyuv76qszVbpH3Y4bd8sRyMsfJ99Uy5hHdl+mr0Q9/ZTSklL3HjTZUrxcJ6qFQekdpee8PUelOabCW3aMG6rTfRMryiRmCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TgxoSG1r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC641C433C7;
	Tue,  6 Feb 2024 20:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707252477;
	bh=Jg40ieHbXF/G6oXsaLbvVU0RA1nGUVs4Ekk/gOizNXo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TgxoSG1rlBydXWxeJ1JjV9mDfKZnJN8y3+ZcCGIKOu4s/Wg9DNzHm+N+zFgJU/RTl
	 ehW98GWAFGh5qbEAyzotzkaON11uQuCSCXmht4xT7i9IFHWgpFEmi+6mcMoMOkdP78
	 7nJW20/X1hV6Unzu/mTEi2Xcbyq00gv4k1a0hKBulSAm9VActq8orpvGh+Kdu7qfcZ
	 fZsZShlKVgs35SnN3gdslTTqaNM1fsMkMRDFwMg19p6swMXdHQuErR9czEejdk7YT8
	 VreX++lZPWzTASAP0qSLh7aqBNwgjCdC/bZJHgGBL2aZLyiPcCbIb8dYbFXZ8QumgV
	 J/LTcRmIxbvTQ==
Date: Tue, 6 Feb 2024 20:46:22 +0000
From: Simon Horman <horms@kernel.org>
To: Amit Cohen <amcohen@nvidia.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, daniel@iogearbox.net, mlxsw@nvidia.com,
	Ido Schimmel <idosch@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Subject: Re: [PATCH net-next] net: Do not return value from
 init_dummy_netdev()
Message-ID: <20240206204622.GJ1104779@kernel.org>
References: <20240205103022.440946-1-amcohen@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240205103022.440946-1-amcohen@nvidia.com>

On Mon, Feb 05, 2024 at 12:30:22PM +0200, Amit Cohen wrote:
> init_dummy_netdev() always returns zero and all the callers do not check
> the returned value. Set the function to not return value, as it is not
> really used today.
> 
> Signed-off-by: Amit Cohen <amcohen@nvidia.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


