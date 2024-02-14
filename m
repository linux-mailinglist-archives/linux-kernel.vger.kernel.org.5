Return-Path: <linux-kernel+bounces-64862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9F78543EA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 09:16:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D98C1F26E82
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 08:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34ABC125BB;
	Wed, 14 Feb 2024 08:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AUs0nQgt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72171125A2;
	Wed, 14 Feb 2024 08:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707898579; cv=none; b=nCXWWbbGTD6m6DBETpCyOoKkPQzEl6n1XFaZH8rHjzwzkAFc7AWZBBxGqQ+36Hqek1WcSooQ3Jpcw197nakhYGVKV4JjTvWUOoklL24KNSQvXG+pzcDneUPTLNIPMpbpNts/I3/r/ASNbRYGEh6i9F4F7ZuYViCx781jY6FnHFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707898579; c=relaxed/simple;
	bh=EQK4OqWRKFvuntJVf1ZtMiax/Oe88+7UKWuKRY4WF2k=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=CrwrmH++OXT48ups5pphI+shK4iOWY3tOV/ZGIagPs9mjoP/emJ2T0Yh7Bum+5GcTdM0Kf/rGbrIqJgwWf2bPy3iEe9kfhQPDMZk9doPvv8crKwU8TmBXc64ee5J4orw3403KU3AKhjFoZe5ls2xiCgXV5aqVhcM6pNixL4JQT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AUs0nQgt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3D1CC433F1;
	Wed, 14 Feb 2024 08:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707898578;
	bh=EQK4OqWRKFvuntJVf1ZtMiax/Oe88+7UKWuKRY4WF2k=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=AUs0nQgtHSN9dvY/h7QmCyO1wOB3l35YIBobYwWNo20zKPHESuG74MVzok3coHH9H
	 1GJ3gOa+JheLNqArU2euPFa7+G8XAHR10JF5Z7TpfIObYZuTbs7QpkoQfOCnf33l8Y
	 lIbu1Qw6wd2d05O+4ounzv87erq9AiHyMlNm8DJBbEK0g0shQxdjEPeSFjDohHAOkv
	 +Dm2rIyPmEoLpvAzAs2uQvgqQ5BFClhBIeKwhrzVZL00OE1KwAb33eMv507zeg0ulf
	 zexM/R25P2RPlzvf8HvJk9j2gfhRSZw7yzek+mgm9jxdyZhBCi4dL+mJMXMA/f+uhi
	 OI0KsJGriXHzA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH][next] carl9170: Remove redundant assignment to pointer
 super
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240207171524.2458418-1-colin.i.king@gmail.com>
References: <20240207171524.2458418-1-colin.i.king@gmail.com>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Christian Lamparter <chunkeey@googlemail.com>,
 linux-wireless@vger.kernel.org, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170789857574.3088943.8807931927830576356.kvalo@kernel.org>
Date: Wed, 14 Feb 2024 08:16:17 +0000 (UTC)

Colin Ian King <colin.i.king@gmail.com> wrote:

> The pointer super is being assigned a value that is not being read, it
> is being re-assigned later. The assignment is redundant and can be
> removed.
> 
> Cleans up clang scan warning:
> 
> drivers/net/wireless/ath/carl9170/tx.c:192:34: warning: Value stored to
> 'super' during its initialization is never read [deadcode.DeadStores]
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> Acked-by: Christian Lamparter <chunkeey@gmail.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

b53adefc884c wifi: carl9170: Remove redundant assignment to pointer super

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240207171524.2458418-1-colin.i.king@gmail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


