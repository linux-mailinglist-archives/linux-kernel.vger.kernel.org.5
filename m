Return-Path: <linux-kernel+bounces-138079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DFD0189EC36
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 09:36:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 968F91F22787
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 07:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA12913D2A3;
	Wed, 10 Apr 2024 07:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fPK06r4z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0906413D271;
	Wed, 10 Apr 2024 07:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712734530; cv=none; b=JYCgDz91roZsGxezJxRbXq7ktHZZKa4RbW44lJRsUzs40y1RprVRDdKqLdPJEHqhs0Mmj4NrI65+k1KqQTG5bWB+VSLc+odYx0r26BY1qx0CoHYogemvkuLSNSnf71H/TspJUzL5IvDsfe7Ag5RGiZrNfbl3W10Au9dZp7EX7Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712734530; c=relaxed/simple;
	bh=kCkkiF5yrr+gn+ciI6XRvINyLsbhBKsQldNRPr4eq1s=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=swNgMClEngypuSPQbE5/wpoN7v2tsc74sTBZRYEpWnsKEJ5n2r97fBj/idbSHHDuZvPW7kcatrq4zUNgNvLSlzJCRWb9jPgNLKLeXHrqzij5DogrSoajNhFpU2xd5AcfgNsuNA/W8QyqiRteElB2kf5nzsR9lev2ayPZDI/dEyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fPK06r4z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F15FCC433F1;
	Wed, 10 Apr 2024 07:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712734529;
	bh=kCkkiF5yrr+gn+ciI6XRvINyLsbhBKsQldNRPr4eq1s=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=fPK06r4zwjSyBezAFEPb1KyEBqf4DFFi2rsL/lyCbZxd0SuwOttSgcA4GrX2gGyr1
	 pvS3wknZro8bBMIgJCl4MjiVHLcGjNBmubP4zC+Mr70euV0a6MX8nrej15wrFwY8lV
	 3824Vap+psAnfeJ3cKhAWoI9mhJWaEGY/+0HnuhQOBmeKOt9slUKiTVWqhCCUEK6lI
	 /MoZG469eE6NoABE7MpMhiFZ3AwRa6vcvqP//qlxLfdgUXfEP9KEztfKE2OXiKMqaC
	 RA89ESKcsKpjyQ6MLW3J3zaRLnx1AQxZplXk1yVYWAny8ItztyifRkPYgES2UQIbD2
	 EQZRVnG0M7Arw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [next] wifi: brcmfmac: Fix spelling mistake "ivalid" -> "invalid"
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240401215402.1348565-1-colin.i.king@gmail.com>
References: <20240401215402.1348565-1-colin.i.king@gmail.com>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Arend van Spriel <arend.vanspriel@broadcom.com>,
 linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev,
 brcm80211-dev-list.pdl@broadcom.com, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171273452595.3435108.1008576509386429084.kvalo@kernel.org>
Date: Wed, 10 Apr 2024 07:35:27 +0000 (UTC)

Colin Ian King <colin.i.king@gmail.com> wrote:

> There are spelling mistakes in bphy_err() messages. Fix them.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Patch applied to wireless-next.git, thanks.

d26a0a66f929 wifi: brcmfmac: Fix spelling mistake "ivalid" -> "invalid"

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240401215402.1348565-1-colin.i.king@gmail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


