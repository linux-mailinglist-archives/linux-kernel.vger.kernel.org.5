Return-Path: <linux-kernel+bounces-130516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F06FD89792F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 21:49:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D7CAB27EC8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 19:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DEE51553A5;
	Wed,  3 Apr 2024 19:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b="joOpIze7";
	dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b="joOpIze7"
Received: from mail.mleia.com (mleia.com [178.79.152.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD571552FA;
	Wed,  3 Apr 2024 19:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.79.152.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712173711; cv=none; b=oqUVSGNlk6sn80DP4DlITnG/qv34yMxVdycBO7Nw8I7op9P5eLRyrldUd61nVL2V/16RvBIVHUgL22FLiX50O+abFUYfgpyy1Unv9x8WZspfhB6M4WMV4cOctM/1GOqgjSov/F1SVVwwxnm6TCLDU133QdPcT8PvvlqFyyXYBKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712173711; c=relaxed/simple;
	bh=YgTe41TFlt+02N95B2a0BKSnw+zW/yykrDi7+gadw4Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lV1IcV1n4p4iNHfxtWAk5hAcaXf2njz+DhY1iszP3jarS0kZMof85aeMcRJjZoHegSgw1ed2QT/yp1U9VFjVRAQBzqtmBuN8pryy+HmR+7if/SReTc8GFco7pgTIU5mKNxEn2mOBVtQjpKRWMN76xxLoz3xs7+vwx8mC9DsxbXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com; spf=none smtp.mailfrom=mleia.com; dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b=joOpIze7; dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b=joOpIze7; arc=none smtp.client-ip=178.79.152.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mleia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mleia.com; s=mail;
	t=1712173367; bh=YgTe41TFlt+02N95B2a0BKSnw+zW/yykrDi7+gadw4Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=joOpIze7hYPykHqFQpqhIwnodHNIiFwDFrkxh+z2rHAslc7iyqp6+/MNJV6/+jWwX
	 /yVIzkVhlPU2jeVF70X29QOi6AdeNacrZQrMHSi2EL8F4JbouH2vqQMfrLTaiDA+Rx
	 5YIaFzKysRKAtHsiPenSBdZ9IQeKFERuRK0m+dZMtp80nfYWBLW3527lJhSmKuXKmi
	 +S5kWuiZUWWirxWABEE2DeaXyNaAlm0aL21Npjijn+clZPp1SMK4l53//aqUIqJyBj
	 pHSvh5aIMC2amXQqKFTdKw0gndL2H7Ly83mTmkzt3CTALfVe/dK0aJ0T5UdrygC3Z8
	 h4wfEH1r0hDQA==
Received: from mail.mleia.com (localhost [127.0.0.1])
	by mail.mleia.com (Postfix) with ESMTP id 269AC464922;
	Wed,  3 Apr 2024 19:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mleia.com; s=mail;
	t=1712173367; bh=YgTe41TFlt+02N95B2a0BKSnw+zW/yykrDi7+gadw4Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=joOpIze7hYPykHqFQpqhIwnodHNIiFwDFrkxh+z2rHAslc7iyqp6+/MNJV6/+jWwX
	 /yVIzkVhlPU2jeVF70X29QOi6AdeNacrZQrMHSi2EL8F4JbouH2vqQMfrLTaiDA+Rx
	 5YIaFzKysRKAtHsiPenSBdZ9IQeKFERuRK0m+dZMtp80nfYWBLW3527lJhSmKuXKmi
	 +S5kWuiZUWWirxWABEE2DeaXyNaAlm0aL21Npjijn+clZPp1SMK4l53//aqUIqJyBj
	 pHSvh5aIMC2amXQqKFTdKw0gndL2H7Ly83mTmkzt3CTALfVe/dK0aJ0T5UdrygC3Z8
	 h4wfEH1r0hDQA==
Message-ID: <42ff72e4-e791-4b27-bf17-4f8a950264af@mleia.com>
Date: Wed, 3 Apr 2024 22:42:45 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: nxp: Remove an unused field in struct lpc18xx_pll
Content-Language: en-US
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <6cfb0e5251c3a59a156e70bcf6a0cc74aa764faa.1711985490.git.christophe.jaillet@wanadoo.fr>
From: Vladimir Zapolskiy <vz@mleia.com>
In-Reply-To: <6cfb0e5251c3a59a156e70bcf6a0cc74aa764faa.1711985490.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-49551924 
X-CRM114-CacheID: sfid-20240403_194247_182173_86A86778 
X-CRM114-Status: UNSURE (   5.38  )
X-CRM114-Notice: Please train this message. 

On 4/1/24 18:31, Christophe JAILLET wrote:
> In "struct lpc18xx_pll", the 'lock' field is unused.
> Remove it.
> 
> Found with cppcheck, unusedStructMember.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Thank you for the change!

Acked-by: Vladimir Zapolskiy <vz@mleia.com>

--
Best wishes,
Vladimir

