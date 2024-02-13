Return-Path: <linux-kernel+bounces-63798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4689C85348D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 16:26:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7414D1C22BB2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF245DF29;
	Tue, 13 Feb 2024 15:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ntbnK60A"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD2022066;
	Tue, 13 Feb 2024 15:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707837952; cv=none; b=cttg1jNB7DA7ByiCj/E1WQTQFmrOI/J71tijR0cpqkaIQxCwmjOgdsL2TAgxjjKX86K+ThYHixb35UHGEvueHR130gCxX0Zl52/4nEjmBHhyCdGAjGy7pgR/h6eMkOU9plRL57Qk6IDhi1QvwFXgVPU2n/ZkH01oTj6zm2Ea2Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707837952; c=relaxed/simple;
	bh=qpzDUE/WnqOWRwlD7R38lMAxQ4FjMR1jKtXHDzKvwvc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ruV4TGIb08BXDmXmuapO+0F7BxpvdD+xoshPAR5rIx262HZcTFLDdJyZvFjKfPKu28meN6wNK9ylSG9iZidxHJyTMecThPvYSAPGnYkI6rh8pPiz30qmBR8cMxNDufBiwDDxKtVD4t4YWmB7Vd22gxq3xu8Eke19FJ7Bj7yclm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ntbnK60A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5077C433C7;
	Tue, 13 Feb 2024 15:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707837952;
	bh=qpzDUE/WnqOWRwlD7R38lMAxQ4FjMR1jKtXHDzKvwvc=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=ntbnK60Ax4peARXCPzagCcjzTuMAisSQBwieoZZzpUFvY3gj3YQdSdNVxbrB/fQas
	 5U5SJdhwsrqqB4VmQOOmOAypOGxPYC71V7EopjlO53mRGCWvaOaJoX4nRunytPwTja
	 3gRseXS1HpH4tAlUIg04wxoWQ7ALCrFIj44R42NQNiCNgShuZywokcNDOaKoSFFrSM
	 u4gaoUTzCFno+MZ1qcNbWjc0KGsy8ZIQ/ubfrdYXWI9fjlxImx1fJj7LDKFKQZlxot
	 jIWzn7gKJmRX9LdmgYs3MPbraMWM0CEEF4FQHa7BpUcIW0jnae02Y+GEp9jopL6ac3
	 Rgq7M2DZQ40xw==
Date: Tue, 13 Feb 2024 16:25:52 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
cc: djogorchock@gmail.com, benjamin.tissoires@redhat.com, 
    linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
    Abaci Robot <abaci@linux.alibaba.com>, 
    Ryan McClelland <rymcclel@gmail.com>
Subject: Re: [PATCH] HID: nintendo: Remove some unused functions
In-Reply-To: <20240126075445.15495-1-jiapeng.chong@linux.alibaba.com>
Message-ID: <nycvar.YFH.7.76.2402131625090.21798@cbobk.fhfr.pm>
References: <20240126075445.15495-1-jiapeng.chong@linux.alibaba.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 26 Jan 2024, Jiapeng Chong wrote:

> These functions are defined in the hid-nintendo.c file, but not called
> elsewhere, so delete these unused functions.
> 
> drivers/hid/hid-nintendo.c:757:20: warning: unused function 'joycon_type_has_left_controls'.
> drivers/hid/hid-nintendo.c:763:20: warning: unused function 'joycon_type_has_right_controls'.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=8060
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

No idea why those were added, CCing Ryan, who added those in 94f18bb1994. 
I've added a Fixes: tag and applied, thanks.

> ---
>  drivers/hid/hid-nintendo.c | 12 ------------
>  1 file changed, 12 deletions(-)
> 
> diff --git a/drivers/hid/hid-nintendo.c b/drivers/hid/hid-nintendo.c
> index 7ce6be0a8dee..ab5953fc2436 100644
> --- a/drivers/hid/hid-nintendo.c
> +++ b/drivers/hid/hid-nintendo.c
> @@ -754,18 +754,6 @@ static inline bool joycon_type_is_right_nescon(struct joycon_ctlr *ctlr)
>  	return ctlr->ctlr_type == JOYCON_CTLR_TYPE_NESR;
>  }
>  
> -static inline bool joycon_type_has_left_controls(struct joycon_ctlr *ctlr)
> -{
> -	return joycon_type_is_left_joycon(ctlr) ||
> -	       joycon_type_is_procon(ctlr);
> -}
> -
> -static inline bool joycon_type_has_right_controls(struct joycon_ctlr *ctlr)
> -{
> -	return joycon_type_is_right_joycon(ctlr) ||
> -	       joycon_type_is_procon(ctlr);
> -}
> -
>  static inline bool joycon_type_is_any_joycon(struct joycon_ctlr *ctlr)
>  {
>  	return joycon_type_is_left_joycon(ctlr) ||
> -- 
> 2.20.1.7.g153144c
> 

-- 
Jiri Kosina
SUSE Labs


