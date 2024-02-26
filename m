Return-Path: <linux-kernel+bounces-80429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8215886685E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 03:54:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B2F628216B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 02:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 994DD17745;
	Mon, 26 Feb 2024 02:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sXc6TFAB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBCF815AC4
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 02:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708916056; cv=none; b=WqgHY+OGo6hg5puU1gWNYhtFIf3bja3F6V9PmVPpzrtnfq1kXh1t1+oxH5dcVe/RvgLU842Zm22kxsYCF7NSnQqhph5qyCN0Mw5M8bO5kP+6i90KiQT9eMglpXWRoDuOfZ02sNLMGpxH7osdtRjV4TPaB+ISll5BmQyvQ9fnl8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708916056; c=relaxed/simple;
	bh=uqxcv1Va4WIgsQzro43LND6LxWGMhmPZeu341iNFOa8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Rr/wm/7Kg4Fkx1RpH3hO7uW2CMScLB3T9dCyDtoZvvkWcpRRhBbVo7T7whbEJq8XvS09vmXueTbZUCehqx0D9tMnkMBuVR1XjxZ41Sm6cuKfrBhnrMnYSyN5vjinQm2JjaiX7REZyJYopHFdYN+71GCiuHPgBixazESSsTn+YTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sXc6TFAB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AC24C433F1;
	Mon, 26 Feb 2024 02:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708916056;
	bh=uqxcv1Va4WIgsQzro43LND6LxWGMhmPZeu341iNFOa8=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=sXc6TFABNucSw/Z7hyjlv9b2IW8lHpHGUYE7FLEayjRnwNVUq+IW1duME9NxJvHMA
	 KZ+sKpwWGQAAoM8GsnacYQ4gIwafG8fBV4OeAUlV1yrN/w9h7KEwoxyktQYxqD+1SQ
	 U084J6xfi5yyLeeyOqt5cSc3BK0eP9hxMxhoQ4a6Jiuyz/2PGq/OoaIEs6rw6quGiV
	 8h1w+K2cc/wetOP7+g3mJCWIyzRL+vaRX1CzETF96u8gBLPAfMG1rshcGwsaZPEg86
	 G2EBsvfZZpvgp8aa02AtIk9/GkdklPokmcGApLWsCOdk0Ilt2yllcJnpT80Vc1Rjug
	 SGn/Za+d8AMlQ==
Message-ID: <eb212e35-af60-44de-b843-748ad5fa8dac@kernel.org>
Date: Mon, 26 Feb 2024 10:54:12 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [f2fs-dev] [PATCH 3/5] f2fs: print zone status in string and some
 log
Content-Language: en-US
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
References: <20240223205535.307307-1-jaegeuk@kernel.org>
 <20240223205535.307307-3-jaegeuk@kernel.org>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240223205535.307307-3-jaegeuk@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/2/24 4:55, Jaegeuk Kim wrote:
> No functional change, but add some more logs.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

