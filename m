Return-Path: <linux-kernel+bounces-35376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A967838FF2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 14:30:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71C41B2C460
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 13:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B4855FDB9;
	Tue, 23 Jan 2024 13:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iqyKIT1k"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7204D5FDC6;
	Tue, 23 Jan 2024 13:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706015711; cv=none; b=Z7kWdMThmQGQRzswc5r7/pCS1o+TukAFOAzrSQT3hEN9L6g78Woz3mZBef02s5P4E3VUqfn50BhbNEryf4zS0l+DqNSvYXMEJDGhD5Aa3aqPGTG9WSmQJNubpq3SdvD1BHiC6L8JvbjKhxsVkhtDq8q2MakhLs8dog7tXXAwnyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706015711; c=relaxed/simple;
	bh=g36kRqAa0AgkhntszfW+Li1P753t4sRZLsilj77aicI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r8DoRGzz7wxVd/FJGyCpiICR8IBI4JlNfdr8+zJZ4QdK1A1YocCDD4hXExsUJGE9mEuBFsigYOOJkWj+R3bAC03ZuZL3U1bz9BunjRU938wH7vZ9aJmKcMJzgHXfTRGmDWGJBhtI1cnhIYGs/5d9hvGnH8w03R/m92Z4TLR91/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iqyKIT1k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7416FC43609;
	Tue, 23 Jan 2024 13:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706015710;
	bh=g36kRqAa0AgkhntszfW+Li1P753t4sRZLsilj77aicI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=iqyKIT1kfJYPMsJxo9qxT9J0nDYQzxvNmRvsQejyWuYop39MCb1vgQiMaQx8jvMBX
	 AFBPjG0+uswaMuVGpteF5Xl6HNCwp/d+A2WonyvMasNQlMRpfhwJDskEAxXF4uCpJA
	 +5SuEmWieVMdWTB4Ee7NAUE/NzPZuRAzZTEeUem4MX4bauZFqdirBJdb6EPWz+9b8A
	 V0C+wg6MAOet67uIcsTEsoDyvghUlWdbpNA0rijXvhFRq0rs7MBOsVnBHKs9CS1CMz
	 9mCskjhDEnctieBZa4je2CL+Z16NyDTbgn33FHW+1HHxeCFvyGeU8i9BtyhcI7H2yx
	 tYdIOc6ZLsqLw==
Message-ID: <5bfb2175-2470-469b-b3fa-9f14fae08536@kernel.org>
Date: Tue, 23 Jan 2024 07:15:07 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 65/82] nios2: Refactor intentional wrap-around test
Content-Language: en-US
To: Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org
Cc: Jann Horn <jannh@google.com>, Ley Foon Tan <ley.foon.tan@intel.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 linux-kernel@vger.kernel.org
References: <20240122235208.work.748-kees@kernel.org>
 <20240123002814.1396804-65-keescook@chromium.org>
From: Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <20240123002814.1396804-65-keescook@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/22/24 18:27, Kees Cook wrote:
> In an effort to separate intentional arithmetic wrap-around from
> unexpected wrap-around, we need to refactor places that depend on this
> kind of math. One of the most common code patterns of this is:
> 
> 	VAR + value < VAR
> 
> Notably, this is considered "undefined behavior" for signed and pointer
> types, which the kernel works around by using the -fno-strict-overflow
> option in the build[1] (which used to just be -fwrapv). Regardless, we
> want to get the kernel source to the position where we can meaningfully
> instrument arithmetic wrap-around conditions and catch them when they
> are unexpected, regardless of whether they are signed[2], unsigned[3],
> or pointer[4] types.
> 
> Refactor open-coded wrap-around addition test to use add_would_overflow().
> This paves the way to enabling the wrap-around sanitizers in the future.
> 
> Link: https://git.kernel.org/linus/68df3755e383e6fecf2354a67b08f92f18536594 [1]
> Link: https://github.com/KSPP/linux/issues/26 [2]
> Link: https://github.com/KSPP/linux/issues/27 [3]
> Link: https://github.com/KSPP/linux/issues/344 [4]
> Cc: Dinh Nguyen <dinguyen@kernel.org>
> Cc: Jann Horn <jannh@google.com>
> Cc: Ley Foon Tan <ley.foon.tan@intel.com>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>   arch/nios2/kernel/sys_nios2.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Dinh Nguyen <dinguyen@kernel.org>


