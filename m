Return-Path: <linux-kernel+bounces-32430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86467835BBB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 08:36:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B7AB28424D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 07:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A29B316435;
	Mon, 22 Jan 2024 07:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VcOR1R2y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBDD10A16;
	Mon, 22 Jan 2024 07:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705908973; cv=none; b=IdT0o5/4gLR6rGrhEE6MJkHg9gycOXzAQd8EdVeBmbzJU6vuHdRPlePz0d47Ldyc6zbEihLzNnmWo/+ajLXlekQyTx2CDIWsyVrMKZSV7g8iIo18WLCsr4ueHTjdXX5OXrddFdXu9DC+bf7s6ewGerLoMLFAj0eHGz6gaWC0+6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705908973; c=relaxed/simple;
	bh=SrTp3PRpdblpdcnQdNS+rwPFtdOvVuJC8W/HbbUn+nk=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=Whv9S2UGL+yhG5U9VESnuRdEx5hD0/pQ2Rrj8oA2AEO6TQ5CB0HFIU7qYAiv9K+7Bmg8vdW39yLO9b4y8q4dHiTRosUUskIIyN/KQE1E+SkAkw96MTFaBaGFgB7u4y5YBBW/QMtY/zZC9LOgdSMIW/J3VZ57zFaM2UeLarIbWpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VcOR1R2y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AA07C433C7;
	Mon, 22 Jan 2024 07:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705908972;
	bh=SrTp3PRpdblpdcnQdNS+rwPFtdOvVuJC8W/HbbUn+nk=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=VcOR1R2y6rJWJCNmM6ZDa6R8IR9TayybDUsbDEdtDackdY0aDMnEZWvm7Znu621To
	 7RNBVFztI8H93etVqGE7lUzCBERKj8ZeOMJSmhHPGkZ+kcDUpHbTxYfVa7aaHYOcor
	 4ybqqi6S5shb0D8pchutI6dDi/A6jvtjPtEvs4JV4pYWST1y+1JmuZzShnOEg3C65g
	 ER2sZi7xIF9O+GXc/hAJ4wpluVIw3+UvhzlEFSbblGSNWsyjb7ML3YJ0bx8+9v2lfb
	 IaDmPalmLKHe782zFgjR3aHG0eG0Bh++VbRHcvemFyfTN9M/Yo2vB1YHqet5Gja9lH
	 22Kgyo1EGsieA==
From: Kalle Valo <kvalo@kernel.org>
To: ath11k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,  regressions@lists.linux.dev,
  linux-kernel@vger.kernel.org
Subject: Re: [regression] ath11k broken in v6.7
References: <874jfjiolh.fsf@kernel.org> <87frytg7b8.fsf@kernel.org>
	<878r4lg3t8.fsf@kernel.org>
Date: Mon, 22 Jan 2024 09:36:08 +0200
In-Reply-To: <878r4lg3t8.fsf@kernel.org> (Kalle Valo's message of "Fri, 19 Jan
	2024 09:50:11 +0200")
Message-ID: <87jzo13jmf.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kalle Valo <kvalo@kernel.org> writes:

> Kalle Valo <kvalo@kernel.org> writes:
>
>> Kalle Valo <kvalo@kernel.org> writes:
>>
>>> Just trying to make everyone aware because I suspect this will affect
>>> quite a few people: ath11k is crashing during suspend on v6.7 due to a
>>> mac80211 patch, more info:
>>>
>>> https://bugzilla.kernel.org/show_bug.cgi?id=218364
>>>
>>> Proposed fix:
>>>
>>> https://patchwork.kernel.org/project/linux-wireless/patch/20240111170629.1257217-1-benjamin@sipsolutions.net/
>>
>> The fix is now applied:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git/commit/?id=556857aa1d0855aba02b1c63bc52b91ec63fc2cc
>>
>> I'll try to use regzbot for the first time, let's see how it goes:
>>
>> #regzbot introduced: 0a3d898ee9a8 ^
>
> Forgot to include the bug report:
>
> #regzbot link: https://bugzilla.kernel.org/show_bug.cgi?id=218364

#regzbot fix: 556857aa1d0855aba02b1c63bc52b91ec63fc2cc

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

