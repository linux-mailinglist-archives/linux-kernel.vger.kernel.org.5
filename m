Return-Path: <linux-kernel+bounces-56673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B415B84CD6E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 15:57:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66EDB1F22E0F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 14:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F7877FBAF;
	Wed,  7 Feb 2024 14:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EfZIOFsb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850C776C8D;
	Wed,  7 Feb 2024 14:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707317785; cv=none; b=PTfr2pngVnP/WopzmjGKS+ZETKR/fNJqFl53x2/y7myqip6SgaOalyPLX+kxs2ae+hRimt6l50cUv5fOPJphE7nSw22WzqBYHnOi+V14OFG1XnMR6yOEXygJia3bNKa/3QzzSz4m1WRwm1dLJWC1IkZYGWzI8zjZaBY+XoFBjZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707317785; c=relaxed/simple;
	bh=nCxQ8fGvuEcmb7qfNQBjMnRhra6lyUgdE8qqI+GeNOE=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=XxaG9KRu7idb+5wKqwtPHlcKMh6j47OA8IPhL3dGcc3NGHi+j9PKlJgj05cHiAu2Waks9OLlSa1uS36lkiAzZm2S70F79ty1Ch++5XSIwxmx6Ii3Is2Uey4q74gslf57c7aOPpTZ9HL0j5XRlq2+E47WN8FqUyHvV8Z8/OeKtkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EfZIOFsb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2521EC433C7;
	Wed,  7 Feb 2024 14:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707317784;
	bh=nCxQ8fGvuEcmb7qfNQBjMnRhra6lyUgdE8qqI+GeNOE=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=EfZIOFsbNQM3dkm04/Qj0EZ243NsK9ajRBm2H+sB5OzsyUN3vEQGbDwa9uZSqeTEE
	 5lcSSmrbC1fbtfZPkKSWg/wBOGX6FpSUT8bQuVjHFV504oi1/pOInXJgvi1r6CxC2+
	 pyMsS4DAJ6599icKOl/tyHmpN3d1F0hHFSinMRK1oSoXzhg6KZB3YyjfnQC3oxqCWk
	 oRD2sL03j4bxIvU1rtzlXwbY2Vpw523rOqsLdVCICdyyKlfSVk4tNp80EvfqlAOtNp
	 d7tZMtmpWdgAGmHo+jo+2G//1pnIfsHzLQdUjIynAJOYoB7aavvW3fi4GQsPcqPez1
	 WiL4bNo+KjxaQ==
From: Kalle Valo <kvalo@kernel.org>
To: "Colin King (gmail)" <colin.i.king@gmail.com>
Cc: Felix Fietkau <nbd@nbd.name>,  Lorenzo Bianconi <lorenzo@kernel.org>,
  Ryder Lee <ryder.lee@mediatek.com>,  Shayne Chen
 <shayne.chen@mediatek.com>,  Sean Wang <sean.wang@mediatek.com>,  Matthias
 Brugger <matthias.bgg@gmail.com>,  AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>,
  linux-wireless@vger.kernel.org,  linux-mediatek@lists.infradead.org,
  kernel-janitors@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH][next] mt76: Remove redundant assignment to variable tidno
References: <20240207131113.2450297-1-colin.i.king@gmail.com>
	<87il30h03n.fsf@kernel.org>
	<13e2f96c-2434-4266-8a5e-25b267d1fb0e@gmail.com>
Date: Wed, 07 Feb 2024 16:56:20 +0200
In-Reply-To: <13e2f96c-2434-4266-8a5e-25b267d1fb0e@gmail.com> (Colin King's
	message of "Wed, 7 Feb 2024 14:53:51 +0000")
Message-ID: <87wmrgpbl7.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Colin King (gmail)" <colin.i.king@gmail.com> writes:

> On 07/02/2024 13:31, Kalle Valo wrote:
>> Colin Ian King <colin.i.king@gmail.com> writes:
>> 
>>> The variable tidno is being assigned a value that is not being read
>>> and is being re-assigned a new value a few statements later.
>>> The assignment is redundant and can be removed.
>>>
>>> Cleans up clang scan warning:
>>> drivers/net/wireless/mediatek/mt76/agg-rx.c:125:5: warning: Value stored
>>> to 'tidno' during its initialization is never read [deadcode.DeadStores]
>>>
>>> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
>> "wifi:" missing from title.
>> 
> does this require a V2?

Up to Felix, my guess is that he can add it during commit.


-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

