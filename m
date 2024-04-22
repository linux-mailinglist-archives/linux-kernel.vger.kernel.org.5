Return-Path: <linux-kernel+bounces-153791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F4878AD336
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 19:16:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04A6F28467F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 17:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D43A153BDD;
	Mon, 22 Apr 2024 17:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hn3g3ROr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65194152182
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 17:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713806178; cv=none; b=HappH6rkDEAPPd6IYjs6H92Lsg04r1JqfW7uoa9+a9FPcSdvx5o9gu01pT4CRjP1QsHWZHd2LkHVY8Y+8D19DL0/9YyVvhrfKq+NhM/dyE6ZHLswU57acjV8RpWTmYM2++y80VEYdWbcgSfemAL3mLusUTiDJbGLZUs64kE+eOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713806178; c=relaxed/simple;
	bh=upqYMevvShbiM4jK6jZf1yOVEJML1m/sJOZrrU//yOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r016WQsx9nG1+zf/Tpo4TveowFVaF2YYRZGGU0/zrUiXggheanQlYJw6V/kOmz70GRRXh35ippPT08XQVL7KY6WTWLZM6qo064sDTAasYIw9q0/jgii2whHuuY8bZYFyjZzissIlIad5J3bmMQoqNlw4nAyGOrnAZDOkcD/u5Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hn3g3ROr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D286DC113CC;
	Mon, 22 Apr 2024 17:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713806178;
	bh=upqYMevvShbiM4jK6jZf1yOVEJML1m/sJOZrrU//yOk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hn3g3ROrSTD39ZFuVqMpFAMvkDBw7q3DNIZfrlBl8qVLFXucF5M5gZHJY8adS0+m7
	 n7qytG6hsBEhIPfU5wHQf3qJ5Q+KAYEc74S0vwR/R1YpblIowIVOzR9ApgKyCxGPsm
	 gexa0ky/7jyscYrP/rcNLY8LbnL99czYchez1HzyP4X8PGwkQTLA88JluZ3M2kwAIM
	 /RLIjbbQyBCoRzyB+pKZ5rlRU01OvYYzo/dTt7sNB1VsGZ5BQDFH+vCkm4LNiapba5
	 FUku3q/YRLma9/gIhPyUIITzmc/+Wh5TVQRefWoqz2n6M3wYjvLmSdO4uKm0XHQZXR
	 qMEb4dtUYqlNA==
Date: Mon, 22 Apr 2024 18:16:13 +0100
From: Will Deacon <will@kernel.org>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
	Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/sysreg: Update ID_AA64MMFR2_EL1 register
Message-ID: <20240422171613.GC6223@willie-the-truck>
References: <20240419021325.2880384-1-anshuman.khandual@arm.com>
 <20240419134623.GE3148@willie-the-truck>
 <49365864-0080-4ddd-b0cb-eef41c88b6a9@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49365864-0080-4ddd-b0cb-eef41c88b6a9@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Mon, Apr 22, 2024 at 08:38:40AM +0530, Anshuman Khandual wrote:
> 
> 
> On 4/19/24 19:16, Will Deacon wrote:
> > On Fri, Apr 19, 2024 at 07:43:25AM +0530, Anshuman Khandual wrote:
> >> This updates ID_AA64MMFR2_EL1.VARange register fields as per the definition
> >> based on DDI0601 2024-03.
> >>
> >> Cc: Catalin Marinas <catalin.marinas@arm.com>
> >> Cc: Will Deacon <will@kernel.org>
> >> Cc: Mark Brown <broonie@kernel.org>
> >> Cc: linux-arm-kernel@lists.infradead.org
> >> Cc: linux-kernel@vger.kernel.org
> >> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> >> ---
> >> This applies on v6.9-rc4
> >>
> >>  arch/arm64/tools/sysreg | 1 +
> >>  1 file changed, 1 insertion(+)
> >>
> >> diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
> >> index a4c1dd4741a4..6d7213dcbeb5 100644
> >> --- a/arch/arm64/tools/sysreg
> >> +++ b/arch/arm64/tools/sysreg
> >> @@ -1739,6 +1739,7 @@ EndEnum
> >>  UnsignedEnum	19:16	VARange
> >>  	0b0000	48
> >>  	0b0001	52
> >> +	0b0010	56
> > 
> > Is anybody using this? I'm not sure there's a lot of value in adding
> > these fields one-by-one for the sake of completeness.
> 
> This is not being used currently but will be required for upcoming
> features. I was under the impression that register fields (atleast
> for the ID registers) should be kept updated, with latest released
> spec ? Besides lately arch/arm64/tools/sysreg serves as very good
> reference for all necessary register fields.

Why? The linux headers aren't documenting the architecture.

Will

