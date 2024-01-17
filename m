Return-Path: <linux-kernel+bounces-28436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9365B82FE7D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 02:42:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 944971C24378
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 01:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 830A51C0F;
	Wed, 17 Jan 2024 01:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JBPOpgk0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD20C5CB0;
	Wed, 17 Jan 2024 01:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705455748; cv=none; b=Tnw8M6eoqDtcbIA8GEqj+zsAV/H70NYV2QjViZhPNZPDfRIvSmTvU6nTgxWz2FYfRDBRlTAKXG2JSO/oMhBExBMxi4x4Yq6tHW3zJZzxOH+PS0FDkLYBZ1Sbtl8BBF7TkopQ2b+Hyc4bzii5oVFzcTF47Bs6b5dNcJqKslaOfM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705455748; c=relaxed/simple;
	bh=Pq4aRA0W4itpVCsymdgOiTvw6mZnYy+AClx9xhyJZlM=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding; b=Pn+yp1JMglIjSGIyH+Y1q4Ro94BH4O/daDrq6zaz8VtsQrUyMHkNm9b/HcJqzOKYNa9H96ljMgXdyKS6Qw9BiASrZnbA0oVhuCTAuUvDj6YxfGPszPXceXnvZ9EsKCgO8AEAh2+5/IWsWN5prBRxIJFVKo9jLZ9QEL+RW9rsT1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JBPOpgk0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 833B0C433C7;
	Wed, 17 Jan 2024 01:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705455748;
	bh=Pq4aRA0W4itpVCsymdgOiTvw6mZnYy+AClx9xhyJZlM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JBPOpgk0BWxOwvr6ZVWzGupd9XDbgRUCcxhVGx46qvTAXrjBpAE0vxyfuBurDWP0C
	 Etfork+C+AWf910qMoMn6dH9GTq8da2rYmc6urbFcGQzdimd1y1ymLEHehEBH9WX/7
	 avrhIh+nFqEFde6Oihk/2dB49k5yFolUXygsvsBLsbXq6WPH8baGbJ3i7Gizm3E9gE
	 pxO+CeFjxg6Rs2/P58igFtIpmfeBNbsdea3v/mVMDMjI0JzWLYkVz/rw7J/UC08svG
	 QCwXlEcEXyrO76uZj5j35gV74F9wGcfmTY6fpq+uYY/w68TMqQrA+n3q2hqc9rQYbM
	 v5zieJ8N8vRCg==
Date: Tue, 16 Jan 2024 17:42:26 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, Tobias Waldekranz
 <tobias@waldekranz.com>, Andrew Lunn <andrew@lunn.ch>, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 krzysztof.kozlowski@linaro.org, robh@kernel.org,
 u.kleine-koenig@pengutronix.de, netdev@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.7 043/108] net: mvmdio: Avoid excessive sleeps
 in polled mode
Message-ID: <20240116174226.52231f8f@kernel.org>
In-Reply-To: <20240116194225.250921-43-sashal@kernel.org>
References: <20240116194225.250921-1-sashal@kernel.org>
	<20240116194225.250921-43-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 16 Jan 2024 14:39:09 -0500 Sasha Levin wrote:
> Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>

Andrew and Tobias can override, but vote to drop this.
Timing changes can backfire easily on flaky HW.

