Return-Path: <linux-kernel+bounces-57693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFCCE84DC66
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 10:08:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69C521F22566
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 09:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3C5D67C51;
	Thu,  8 Feb 2024 09:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dxXLSDMS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC056A8DF;
	Thu,  8 Feb 2024 09:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707383279; cv=none; b=k4EnTnTyrQ8/4PQVKD3ZIUUPLGFN2smJ844wxxADc2FZ6TAAgvP5nALluUeh17N1rlIs+CHg6gGs3OhTWJxdHLDfet/NVPOAVkGOKIxQvpl5u2C3JZUhteYJLfk2KUfZUu/2kKW9QZUr4bYveN8USsvFueEhgw0MGGw0SK8aOOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707383279; c=relaxed/simple;
	bh=PzMI5VfF7zoxDNzc653C7bj1L2+r3jxz2zIfDvGgv88=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dfHg9JGL4i82mQFwtBDYyVAKMU3KI7suvrhfXxj7iJQYsUuERYns+QOK1jYlUD1RegXP7pAyxozQQjVJYmPXgAq0Vbeh/hsiYtl8C+NKPVokQShbDUd39sUmQT8scSnEXddp0WSFGGzNn3EyR3kcbNYz8vSmEvnqQs0Hko+qawM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dxXLSDMS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50B7FC433C7;
	Thu,  8 Feb 2024 09:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707383278;
	bh=PzMI5VfF7zoxDNzc653C7bj1L2+r3jxz2zIfDvGgv88=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dxXLSDMS6K2LDtTY4jNHTAx17Kw7LQdNqTWVjbtxyOAhO+KfAoUWZ06XAaVEvNDkh
	 T/MipHeg246BhcQIXV7FOm/2CEpf9p10+zVLONkPyDgbtSg7zCA+8Fs5IYU8LsId0y
	 x4b126lgFBSb/6IxLbdhBv/kNjDQ4H2lUkxuAnqc/shLKZ0rDAxH0dPpgdSHHj6I1W
	 eX6cFT8CpqvhWne/kB+RavOt7y9jW6spbQMZ1u1KSnEeIilVVfWWtAnMRxqyE8Fdiv
	 BsKRMgcZcKm65wNOGilzf/Lq1mXzaL5kf6x1mz5NuFMkl2WTl60nEykpczBDqS1sbo
	 EROEPHXaYmT6Q==
Message-ID: <478be18c-a242-4004-b45d-8aaf7505588f@kernel.org>
Date: Thu, 8 Feb 2024 10:07:54 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: MediaTek for-next: Replace matthias.bgg tree with mediatek
To: Stephen Rothwell <sfr@canb.auug.org.au>,
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: Linux Next Mailing List <linux-next@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <00a81be6-7dd7-4959-b1dc-eb94022bf0e5@kernel.org>
 <20240207090505.515d8977@canb.auug.org.au>
 <9e20a488-870f-4ff4-bfea-195a3f62b92e@gmail.com>
 <20240208070222.3a916478@canb.auug.org.au>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@kernel.org>
Content-Language: en-US
In-Reply-To: <20240208070222.3a916478@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 07/02/24 21:02, Stephen Rothwell ha scritto:
> Hi Matthias,
> 
> On Wed, 7 Feb 2024 16:08:22 +0000 Matthias Brugger <matthias.bgg@gmail.com> wrote:
>>
>> Please add Angelo to the contact list.
> 
> Done
> 
> For Angelo's benefit:
> 
> Thanks for adding your subsystem tree as a participant of linux-next.  As
> you may know, this is not a judgement of your code.  The purpose of
> linux-next is for integration testing and to lower the impact of
> conflicts between subsystems in the next merge window.
> 
> You will need to ensure that the patches/commits in your tree/series have
> been:
>       * submitted under GPL v2 (or later) and include the Contributor's
>          Signed-off-by,
>       * posted to the relevant mailing list,
>       * reviewed by you (or another maintainer of your subsystem tree),
>       * successfully unit tested, and
>       * destined for the current or next Linux merge window.
> 
> Basically, this should be just what you would send to Linus (or ask him
> to fetch).  It is allowed to be rebased if you deem it necessary.
> 

Thank you, Stephen!

Cheers,
Angelo

