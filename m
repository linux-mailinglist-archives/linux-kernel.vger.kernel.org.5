Return-Path: <linux-kernel+bounces-151499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7869B8AAFA7
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 15:46:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08A7D281285
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 13:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B9312AAE9;
	Fri, 19 Apr 2024 13:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E3RkQHWo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86F2128362
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 13:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713534388; cv=none; b=qOVk+LTKPxQwwW9MvoXFQEEQkfgQc/A6VXv+vB7IpxmCz9QZ0f1BUH5L6Hcq/dDuq1Ax/bkRmATK9S6wNG5rTlZBRZKrCZfu8TttE6FsZfBBukZ5RKYft0qaOqP6HxJoa8qTeNLPF7w8mEVjnl7Wpjt6/Dh+j6mOj1ztd1KAFmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713534388; c=relaxed/simple;
	bh=IIobhHUtL7mSB1j+t6phkQQiJOzWxuT9Dms0sEqWn5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CRFnkA/eyul+7Cdq58ykAy/LaxfPEqCEiNhHQijsLQEWv4nSlU4d0fZ9635Am/NIpjrABSr/Din59pMz08mDOj+xeJP1ACyaNRZsNl+jcHyjWv16yZuXeJ5131MVR9DCabiPnIbzVkvmsjzfdnuijyTyqXlscUBruXsLcZB4J64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E3RkQHWo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37629C072AA;
	Fri, 19 Apr 2024 13:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713534388;
	bh=IIobhHUtL7mSB1j+t6phkQQiJOzWxuT9Dms0sEqWn5M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E3RkQHWoTDStBtjx8pchuzIBK4cJDNYoLKozdbM+iinmlSCy2OqCoQaufYhY+397X
	 zyAsI1h4o9IrcV9XHvTKIlhemY9bo1gYZZhPOUzNDwzCiuEIzvm4U+WfpPL02mP6Uq
	 UlFyAHIJwaDtdxvCcQYfiOGBe5ZQzootTuE0BFcGrZfkcqudJnrbnCtf7OpGKg3Jvk
	 l1X2joBtU/vdlZ1rCTS3XZ0crAfp7slXiLhScc3f5JoQBtKAkHCTrh5tpozTk6LjC3
	 67Za75AChJcsQEQ5x64BYL6NoDbSl600rnYRifJ4mcnZNBwv4eHb6Lhg7o9yDPQvhf
	 kh++k1Ehx2VQw==
Date: Fri, 19 Apr 2024 14:46:23 +0100
From: Will Deacon <will@kernel.org>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
	Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/sysreg: Update ID_AA64MMFR2_EL1 register
Message-ID: <20240419134623.GE3148@willie-the-truck>
References: <20240419021325.2880384-1-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240419021325.2880384-1-anshuman.khandual@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Fri, Apr 19, 2024 at 07:43:25AM +0530, Anshuman Khandual wrote:
> This updates ID_AA64MMFR2_EL1.VARange register fields as per the definition
> based on DDI0601 2024-03.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
> This applies on v6.9-rc4
> 
>  arch/arm64/tools/sysreg | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
> index a4c1dd4741a4..6d7213dcbeb5 100644
> --- a/arch/arm64/tools/sysreg
> +++ b/arch/arm64/tools/sysreg
> @@ -1739,6 +1739,7 @@ EndEnum
>  UnsignedEnum	19:16	VARange
>  	0b0000	48
>  	0b0001	52
> +	0b0010	56

Is anybody using this? I'm not sure there's a lot of value in adding
these fields one-by-one for the sake of completeness.

Will

