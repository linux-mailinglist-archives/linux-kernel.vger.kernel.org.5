Return-Path: <linux-kernel+bounces-85495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 514A386B6A0
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 19:01:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E25501F22410
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 18:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3187A79B88;
	Wed, 28 Feb 2024 18:01:12 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFFDB79B6D
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 18:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709143271; cv=none; b=M7FyFqC3+adQWypdi4F4288aUL6EM94xeoWPi5C9hpBYgxUwlzq0RnuphdblYp/9ML82D2fkhGRML/jzgSmAdSm5ozx6Y0wKVQYE/HlJetXEhy68Fkm/OhHaUHR5Ws9q395059YDm28R4I4sxI9ECq1jFHF1BNEh4OyWFc1/akA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709143271; c=relaxed/simple;
	bh=slBzMzDZtC00isUw2RUoejzgODJS/C8f31eU2npygdk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bIiGuK/JuJfC7D9mUfYBDXJo/am3fm8EKmUI1T+eJRr+4PNS6HpoAqAGV6us2e8Zdmo4mWD2huZ6+3SV7ofcMX0zp8jrFL/kgUPnecKgfkIKnh9Czb/7hgaRULcW3gIQJdfRGkeELR7Qt1W473LqZtJoBlgatMiY/JHbKEyQ9as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1998C433C7;
	Wed, 28 Feb 2024 18:01:08 +0000 (UTC)
Date: Wed, 28 Feb 2024 18:01:06 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Seongsu Park <sgsu.park@samsung.com>
Cc: will@kernel.org, anshuman.khandual@arm.com, ardb@kernel.org,
	maz@kernel.org, joey.gouly@arm.com, quic_neeraju@quicinc.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Leem ChaeHoon <infinite.run@gmail.com>,
	Hyongwu Kim <browoo777@gmail.com>,
	Gyeonggeon Choi <gychoi@student.42seoul.kr>,
	Soomin Cho <to.soomin@gmail.com>, Daero Lee <skseofh@gmail.com>,
	kmasta <kmasta.study@gmail.com>
Subject: Re: [PATCH] arm64: head: Remove the instructions that get the
 virtual offset in __relocate_kernel
Message-ID: <Zd904gtGFPgTLCe5@arm.com>
References: <CGME20240226040238epcas1p189fc1471befb73603d75aab855ae37ac@epcas1p1.samsung.com>
 <20240226040224.611039-1-sgsu.park@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240226040224.611039-1-sgsu.park@samsung.com>

On Mon, Feb 26, 2024 at 01:02:24PM +0900, Seongsu Park wrote:
> diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
> index cab7f91949d8..90db196f7c19 100644
> --- a/arch/arm64/kernel/head.S
> +++ b/arch/arm64/kernel/head.S
> @@ -787,8 +787,6 @@ SYM_FUNC_START_LOCAL(__relocate_kernel)
>  	 */
>  	adr_l	x9, __rela_start
>  	adr_l	x10, __rela_end
> -	mov_q	x11, KIMAGE_VADDR		// default virtual offset
> -	add	x11, x11, x23			// actual virtual offset
>  
>  0:	cmp	x9, x10
>  	b.hs	1f

This code has been removed by commit 734958ef0b54 ("arm64: head: move
relocation handling to C code") in linux-next, so the patch is no longer
needed.

Thanks.

-- 
Catalin

