Return-Path: <linux-kernel+bounces-158038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F5FA8B1A7B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 07:57:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2982A1F22DD0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 05:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5318444C68;
	Thu, 25 Apr 2024 05:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YAY7Zvxk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B11740849;
	Thu, 25 Apr 2024 05:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714024623; cv=none; b=DpzAj7ZB5F24+TADdQumKKFCcLmkQPYgu29kdcZnVej+0b9aay6cn4YhTHGsHT3mgdQR7kWJPtqNMumD52DEmhJmg/KSdg7Ij9TbzQ4l98BJwGXj1vCbIINcYnmXBTo10sSZeQjX8rCOeNp/ukScjzLsIVdx1MNGLULveYNMAMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714024623; c=relaxed/simple;
	bh=G4XtPW3jY3Xj7+1bRtRJS8FXcQOSnJLmCbUNts5ux6U=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=XuHvjo6S6NvdGDStxyRNqAT26tPolISsIWrTCdC43vjUa7trIm69PatWsRcp+DR4zzwYC/I4cdAWWJ9bDaRJX8+gmttHU4FDZ8MaXMxr4EaG/7hIWyrsSVAtjp+Owhc9xHORj4Q3p16+czyEaqQ6CGPB8Va7gPrndHjBUzCFtV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YAY7Zvxk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B808C113CC;
	Thu, 25 Apr 2024 05:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714024623;
	bh=G4XtPW3jY3Xj7+1bRtRJS8FXcQOSnJLmCbUNts5ux6U=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=YAY7Zvxk8S/WoU2wM0qBHK8T3M6ayHnC7ch5Nfcc0JAJ3Znsqi/6C13DTBM+qQhyt
	 8MuWoAD+uNwayyLVxPs+STFaeHiEyG/3GUAXl+NXW3IEIbUKXqg6+GB9kroDwBNgHz
	 MrJraNsVWM+dtS2ugTIq0qYOjYVT9o0CdX6w1GglNW3eLK+eSzlFX10Q6GVMsk9h7s
	 tVNRJfXBjTucwlYw0d5XsRKuwDRflCxkf6Fk47ltGiT9jACjVL0TMLpPEJvwoA4iKp
	 r/UJW7D2pmYSh5OOnu2X2BvMSptS6B0HeEJ2T2xyE5hkkJd+8UUuBq4C3v0S2xarDR
	 PW1NTEQMChOFQ==
From: Kalle Valo <kvalo@kernel.org>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: Breno Leitao <leitao@debian.org>,  "leit@meta.com" <leit@meta.com>,
  "open list:REALTEK WIRELESS DRIVER (rtw89)"
 <linux-wireless@vger.kernel.org>,  open list
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH wireless] wifi: rtw89: Un-embed dummy device
References: <20240424182351.3936556-1-leitao@debian.org>
	<f46ae94488d1468e9a9a669320e4cfb9@realtek.com>
Date: Thu, 25 Apr 2024 08:57:00 +0300
In-Reply-To: <f46ae94488d1468e9a9a669320e4cfb9@realtek.com> (Ping-Ke Shih's
	message of "Thu, 25 Apr 2024 05:52:54 +0000")
Message-ID: <87ttjqgf2r.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ping-Ke Shih <pkshih@realtek.com> writes:

> Breno Leitao <leitao@debian.org> wrote:
>> Embedding net_device into structures prohibits the usage of flexible
>> arrays in the net_device structure. For more details, see the discussion
>> at [1].
>> 
>> Un-embed the net_device from the private struct by converting it
>> into a pointer. Then use the leverage the new alloc_netdev_dummy()
>> helper to allocate and initialize dummy devices.
>> 
>> [1] https://lore.kernel.org/all/20240229225910.79e224cf@kernel.org/
>> 
>> Signed-off-by: Breno Leitao <leitao@debian.org>
>
> I think this patch should go via net-next tree, because wireless-next tree
> doesn't have patch of dummy devices yet.
>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

FWIW I sent the wireless-next pull request yesterday and once it pulled
we will fast forward wireless-next to latest net-next.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

