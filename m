Return-Path: <linux-kernel+bounces-119867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C40488CDE8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 21:09:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37D4B324182
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 357EE13D29B;
	Tue, 26 Mar 2024 20:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e9CSzPO9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753FB13CAA1;
	Tue, 26 Mar 2024 20:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711483732; cv=none; b=MyufjGwKDl/ZI1TorblVZjePdgSeDxiNB0dq51e50uL19WE2xt4LmcCGxcHbhXsgkAOYtlmMlwQ66R9RZScN5WFwb1HGE8y2CRkHAqPCqONIGxas/LH+g0sXWbtIXdelA4VfPO2IUS/OY/ffVq/fFq5al2xHIwNn5SGXmD1zIiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711483732; c=relaxed/simple;
	bh=UvvEXa7/u+TvEsP4ULFQtxhfQt+x828rllZrGgBiyAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qs4rRwQkp38/3KofaSDstxk3vucI4W6moFUIwqwTQZ16kZkXSkDA/HJ0UYV36fsUnfvTe2u6ggz1n8NQBwfCJLoU9kTsLdv9E1mx2BWFKv3MsvN64n2oaagyySUVylKKiazSrAu4wEkC2hR7z4blNWlazLd8V+Mkgp1vNPUj7tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e9CSzPO9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E3D9C43390;
	Tue, 26 Mar 2024 20:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711483732;
	bh=UvvEXa7/u+TvEsP4ULFQtxhfQt+x828rllZrGgBiyAw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e9CSzPO98RG06lCpIqFTyJDf6WolP5CwzaG/dgyiELf8YlZYhsbYYqt7v0hZy/zDI
	 LYPzl9TGgUHRpxTZoBJP3t+YshBkRKMsoVdcqgEfMyYPFTxAdU5Mm6ri/ipWUDx1XL
	 jKF3FeE+Wx7WtMepEPj5vH9nwC1oldmISpGv0yM84regA6B6cpP0KVwzFhKEsNxfND
	 Px/32TgtGPErlCtjy4687DrZCCJ+Y399niAMh9chreSTezD3NsKNlaqQdCtGSn+Hzw
	 RIQvP22sPhMP7UisuoFYwjtD/B/QTkGs6K7c87vwz0RBBQ2GtMjNA+zIiw3qH9zG8r
	 sC4ATgfPNtvDg==
Date: Tue, 26 Mar 2024 21:08:47 +0100
From: Andi Shyti <andi.shyti@kernel.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-i2c@vger.kernel.org, Eddie James <eajames@linux.ibm.com>, 
	openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 20/64] i2c: fsi: reword according to newest specification
Message-ID: <hvucbpsgihrbe4tgf4ksg4obz3rxitmyrdpl6zdh25pmok3uab@y6itjppsfbmd>
References: <20240322132619.6389-1-wsa+renesas@sang-engineering.com>
 <20240322132619.6389-21-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240322132619.6389-21-wsa+renesas@sang-engineering.com>

Hi Wolfram,

On Fri, Mar 22, 2024 at 02:25:13PM +0100, Wolfram Sang wrote:
> Match the wording of this driver wrt. the newest I2C v7, SMBus 3.2, I3C
> specifications and replace "master/slave" with more appropriate terms.
> They are also more specific because we distinguish now between a remote
> entity ("client") and a local one ("target").
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  drivers/i2c/busses/i2c-fsi.c | 56 ++++++++++++++++++------------------
>  1 file changed, 28 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-fsi.c b/drivers/i2c/busses/i2c-fsi.c
> index 10332693edf0..5eaf2c85a72c 100644
> --- a/drivers/i2c/busses/i2c-fsi.c
> +++ b/drivers/i2c/busses/i2c-fsi.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0+
>  /*
> - * FSI-attached I2C master algorithm
> + * FSI-attached I2C controller algorithm

As this change is all about renaming, I think we need to be a bit
more consistent in using either host or controller, at least
within the same driver.

In this driver you are using sometimes host and sometimes
controller.

Thanks,
Andi

