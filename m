Return-Path: <linux-kernel+bounces-152655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 927658AC220
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 01:34:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E30E6281165
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 23:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CCD745BEF;
	Sun, 21 Apr 2024 23:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rZrsKaRC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F223CF40
	for <linux-kernel@vger.kernel.org>; Sun, 21 Apr 2024 23:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713742436; cv=none; b=nK6qgiPQvlA4399c39QlFvhEsk/NjFbGCAnd20rF3cWSPir3FUB701pFId+vmCZ7xsNCE1lAXtPoEnfV3Q8kqG5v6NJAj0TSUrvi/hzKmg9RW3dk5f32NdiC6whR716yOIbXmNNZF9xHJpwvwpdepNJ1hTXKzxhRIal6gDHoxIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713742436; c=relaxed/simple;
	bh=mqavD4MXbXgiBmI5QpPkpW9QlaEuvlvKVaTU0MLkH4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uS5/ek0ba2a/rHO/b32KBvhh+cexJHUc3DB3jjbw/q2M1i8ckLMaOAADmgvHg9kxK+TaB3PZum1eUxaFyrcyFfx0ldb0L2v5OmsB2WNxzE9u8O2aBD0JeJqNPEDbF7nSFx5J0w/ROlXeY9U2kKZg+J8Q+v9lVDxi9YsSj4ZTly8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rZrsKaRC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4EA0C113CE;
	Sun, 21 Apr 2024 23:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713742436;
	bh=mqavD4MXbXgiBmI5QpPkpW9QlaEuvlvKVaTU0MLkH4w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rZrsKaRCJhM9U7WY6oZDXu8neqrZ9wT+6OBt6UCDLYWqon0VT97JDmSnD+1qkd16W
	 vvYKunmix4e0NtURng2yT0g5UF6FKKxX1Qj61HDfq+m5ZsYpBKbaKQSN1gas6Q196E
	 54qcD5mC7q8oZzkaDmA7dYHPGHmP4QlqkdVr+jA8m+ibNSzU9N4/N920PCLa9eqsC+
	 XC49Ls6GuMLXzORasnk7hxLtcjnEpqJS6lKsOYaDojVoNMnrppsSI0+PI2iwdbo9nU
	 J/8WaXKRrPvJzCIXNEOtA1PzTVT8mbL3qSqfdn+gShy1yXNAMAjYuEtgoxM0yhIOnZ
	 QDX4Wmgkcw+Rg==
From: Bjorn Andersson <andersson@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Johan Hovold <johan+linaro@kernel.org>
Cc: Bjorn Andersson <quic_bjorande@quicinc.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: defconfig: enable ext4 security labels
Date: Sun, 21 Apr 2024 18:33:53 -0500
Message-ID: <171374243114.1198983.15523219786774732212.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240411080328.9230-1-johan+linaro@kernel.org>
References: <20240411080328.9230-1-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 11 Apr 2024 10:03:28 +0200, Johan Hovold wrote:
> Enable ext4 security labels so that setcap works as expected.
> 
> 

Applied, thanks!

[1/1] arm64: defconfig: enable ext4 security labels
      commit: eff12fdfd208ebf35b82d6df72285508f85dcea8

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

