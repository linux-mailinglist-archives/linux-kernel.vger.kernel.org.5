Return-Path: <linux-kernel+bounces-166043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 411968B9526
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 09:20:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71EB31C20FE8
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 07:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AA84224F2;
	Thu,  2 May 2024 07:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kfOXBzm1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EAF71CD31;
	Thu,  2 May 2024 07:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714634421; cv=none; b=p4EF/QaTJMOvZIBAlh5knYPz4dlgY/NDtNlH8DPAz1Z5WxSF/p4gbKGKTzVuOuBeF8h7RxIvOGgMI2xIeHNhEaokuIUBB2DD3bM3eMqPCEDsnQwvNbKteE86mo/I1YRjlSIDw00M5Uj2fLO+JdJWP52cOdWm1RG7qByrgIhGenU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714634421; c=relaxed/simple;
	bh=rmi6yDiKY+uXbvXqTuAMlm4djrOSk3mD/x4+OI3EoyQ=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=enfqsA6MQCdShBF4XueS+JVqx4FuQH38QsIZ6hxnsuTvhjDngDttGoYhneWjkuRBXVIDdNWYE5TY3cmFx3LYahznTKhwhhqdadfJPpS5YKaNLioXtETZb2Z4bEL38PJcC1/uwwYDZctXkg46jmwlagGez1ZLeduY7Q4kpSuDojI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kfOXBzm1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 499C1C113CC;
	Thu,  2 May 2024 07:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714634420;
	bh=rmi6yDiKY+uXbvXqTuAMlm4djrOSk3mD/x4+OI3EoyQ=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=kfOXBzm12EeXozTfsx5PJPVf0pwieTDiPBP/ASVjUNhw4aa/xvvXrbZSnh624AkRL
	 2MpqjUJETo9jOQag/F9m3u0MzeGxt779RIncCBJ/DvUgOs5Ct9vVi0o6qCoHNxfpRO
	 2VAqeKo0Vg0nqLHU7s9JgF4V1AQFaBVA05s8II2HaZGwocv7ZLBBAmh23I8UnXDKVX
	 Y6rYHl7NVJXEjg+6mj3d1hY7AiYaeCSqVtOUsqvn45hZVXPCRuv8Jzthx9KFNAtdIv
	 EF16QSwr2RHB6AbdhotuP2zRu8AdCmVmaoazAcJaMXkSqwKhWh8mVXp9r9H3ypb3Sk
	 eAWX8U2C8iYog==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH wireless 1/2] wifi: qtnfmac: Move stats allocation to core
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240426093156.2002258-1-leitao@debian.org>
References: <20240426093156.2002258-1-leitao@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: Igor Mitsyanko <imitsyanko@quantenna.com>,
 Sergey Matyukevich <geomatsi@gmail.com>, linux-wireless@vger.kernel.org,
 kuba@kernel.org, Johannes Berg <johannes.berg@intel.com>,
 linux-kernel@vger.kernel.org (open list)
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171463441751.470469.18121247610025881237.kvalo@kernel.org>
Date: Thu,  2 May 2024 07:20:19 +0000 (UTC)

Breno Leitao <leitao@debian.org> wrote:

> With commit 34d21de99cea9 ("net: Move {l,t,d}stats allocation to core and
> convert veth & vrf"), stats allocation could be done on net core instead
> of this driver.
> 
> With this new approach, the driver doesn't have to bother with error
> handling (allocation failure checking, making sure free happens in the
> right spot, etc). This is core responsibility now.
> 
> Move qtnfmac driver to leverage the core allocation.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

2 patches applied to wireless-next.git, thanks.

3d1a6e573bb1 wifi: qtnfmac: Move stats allocation to core
8886b6d681f2 wifi: qtnfmac: Remove generic .ndo_get_stats64

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240426093156.2002258-1-leitao@debian.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


