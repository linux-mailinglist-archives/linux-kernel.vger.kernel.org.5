Return-Path: <linux-kernel+bounces-47085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B4C98448F0
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 21:32:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E9301C2348B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 20:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 913A440C09;
	Wed, 31 Jan 2024 20:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AO5Ew1RO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49CA3F8F6;
	Wed, 31 Jan 2024 20:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706732992; cv=none; b=R4VPty/DwVE//8JHEH8In4IlF3u/VmLaZp4C3dEFwQprpZoSBLFunRwkMO0+kgNmAYG0FxyBuy/HemcvH6Hobrnrjin1FEROSGqyltMgaUVle5YzIa0ocPnH9mfZeUBCE9HwahRl8uViRgzshGj0ZEGdOvDES34JpufmB5FPHLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706732992; c=relaxed/simple;
	bh=+oIaKj0uu+ADRh2s+OddhjF3NwLApuM4GIEj8UPzt4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E/QQwhOASUr2yfclImTMVeqpICP87lbmyaP+7tbRHTRvdNBkCTfaIbS/Y39rYu1a1fCvgGouvpse6FqXFtt+bd3VAPg1AvjUm+Kd7q+Ljh5OtHO8QE6x4aJsbeR1icTehayF6ICpiL6tP/AOo6clT5niSA/HDaKtnsjXK3PrGDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AO5Ew1RO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18E58C433C7;
	Wed, 31 Jan 2024 20:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706732992;
	bh=+oIaKj0uu+ADRh2s+OddhjF3NwLApuM4GIEj8UPzt4Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AO5Ew1RONycTRKELWM95CdNeWthAG4j0CjgWBVUByOfqFF1qlFrCD1Th4M++9dkfG
	 r6V1ysJc98sd+VcQyyvdsS92UXEAWzaBYEXRIlcqo9wY/D+1dmYSxaIPVBl51Cf4W2
	 9pBtEyZkYeYPfXouUm73RQp0DfDL+Sc+k9XdhSJ1ygsAB+jA4/e6QJhNwqnvNzme+5
	 buXkxIKOMLidPDaPCvIuQtyV1I8D68NMbS+lA4DSUK5xvfx845A+CjAnrknbzUAlVQ
	 YzLDbcqg8X3E7oB7qjFsTARNYPKxChE2FAqbRR4vNyqNkWuT1viYU3ToJL/tLPohmb
	 Pi852MJEuYXdQ==
Date: Wed, 31 Jan 2024 14:29:50 -0600
From: Rob Herring <robh@kernel.org>
To: "Christian A. Ehrhardt" <lk@c--e.de>
Cc: Rob Herring <robh+dt@kernel.org>, kernel test robot <lkp@intel.com>,
	Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] of: unittest: Fix compile in the non-dynamic case
Message-ID: <170673298869.2247741.13347851675269431650.robh@kernel.org>
References: <20240129192556.403271-1-lk@c--e.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240129192556.403271-1-lk@c--e.de>


On Mon, 29 Jan 2024 20:25:56 +0100, Christian A. Ehrhardt wrote:
> If CONFIG_OF_KOBJ is not set, a device_node does not contain a
> kobj and attempts to access the embedded kobj via kref_read break
> the compile.
> 
> Replace affected kref_read calls with a macro that reads the
> refcount if it exists and returns 1 if there is no embedded kobj.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202401291740.VP219WIz-lkp@intel.com/
> Fixes: 4dde83569832 ("of: Fix double free in of_parse_phandle_with_args_map")
> Signed-off-by: Christian A. Ehrhardt <lk@c--e.de>
> ---
>  drivers/of/unittest.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 

Applied, thanks!


