Return-Path: <linux-kernel+bounces-134669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A84AA89B4AB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 01:47:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 633F72817E8
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 23:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B59B445943;
	Sun,  7 Apr 2024 23:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X5mtmvi8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EADDD446D3;
	Sun,  7 Apr 2024 23:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712533611; cv=none; b=ZLGNq33/4BZeWeBHldwi1G+C1x32yaqSsRiTD02VDqJUxTggazGYU4dGL7mIwk83RU2i7O8cb/tJBz7aRKoQnyErk3P1yHz20jn/K6XqAgGBavUdKpjwReMoWPQKlZKv3kE0vxjyF3msnpR8nbAbOfPhUZnk/LFYdv5xvsIemEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712533611; c=relaxed/simple;
	bh=P+OunsRxmPow7mnjnbhNCSULHtX+QKprpv8k/fKlJkc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mrMFUPh3wJztM42WZxq8eweB3qJeZoOzENAirzCqTpKRGW8PBqKTrpQ7O0LnNW5MASV3CMGCwiRPXpNvILrgkyO9E4lcjkuNlZQ5msHHzQr/PFD64QhrIczWzOggwaJeJeUlF4AovfWaKDXr3HHsR7U2ageQZ7cHpTlXxWPea9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X5mtmvi8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CEDCC433F1;
	Sun,  7 Apr 2024 23:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712533610;
	bh=P+OunsRxmPow7mnjnbhNCSULHtX+QKprpv8k/fKlJkc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X5mtmvi8tSG2KQEhFYa0jlYBE8HknG/5hgWPYQWYaPPkcXzwCnpAVuSUH2ZQOTqKA
	 fT7fy/cCBaVuucVOTXNIHDytoNtfVUDlTPko5AK3hinSxomPzxr6L23V3Uj9/eLPFF
	 OKSqPK8ptsShZden9yMexeHBaDUlqih0pwTtFgMLmGFXpbbhfyK7YwHQEiWazITIAU
	 mOn1UfMgeIaX/a+lzT/6Al3J6Wkz+N/8xDL/HjJq1JD+U/5LeZ+TaXQLqt7GyGAcfJ
	 wUp6OqYAZYfVuxZ05M6CtWQj1cS/vWYTpKzKWMScxZt9cpRXoAjm4l+P4J4fdV6pf6
	 kCk7omAoS/Wrw==
Date: Sun, 7 Apr 2024 19:46:50 -0400
From: Sasha Levin <sashal@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Sam Ravnborg <sam@ravnborg.org>, davem@davemloft.net,
	andreas@gaisler.com, masahiroy@kernel.org, nicolas@fjasle.eu,
	guoren@kernel.org, rmk+kernel@armlinux.org.uk,
	sparclinux@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.8 69/98] sparc: vdso: Disable UBSAN
 instrumentation
Message-ID: <ZhMwahvAWzOeq40a@sashalap>
References: <20240329123919.3087149-1-sashal@kernel.org>
 <20240329123919.3087149-69-sashal@kernel.org>
 <202403291904.05D45FDD2@keescook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <202403291904.05D45FDD2@keescook>

On Fri, Mar 29, 2024 at 07:05:37PM -0700, Kees Cook wrote:
>On Fri, Mar 29, 2024 at 08:37:40AM -0400, Sasha Levin wrote:
>> From: Kees Cook <keescook@chromium.org>
>>
>> [ Upstream commit d4be85d068b4418c341f79b654399f7f0891069a ]
>>
>> The UBSAN instrumentation cannot work in the vDSO since it is executing
>> in userspace, so disable it in the Makefile. Fixes the build failures
>> such as:
>>
>> arch/sparc/vdso/vclock_gettime.c:217: undefined reference to `__ubsan_handle_shift_out_of_bounds'
>>
>> Acked-by: Sam Ravnborg <sam@ravnborg.org>
>> Link: https://lore.kernel.org/all/20240224073617.GA2959352@ravnborg.org
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>
>This is harmless to backport, but doesn't do anything. (The UBSAN
>changes needing this are only in Linus's tree.)

I'll drop this and the rest of the ubsan commits you've pointed out,
thanks!

-- 
Thanks,
Sasha

