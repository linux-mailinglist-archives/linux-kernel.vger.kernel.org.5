Return-Path: <linux-kernel+bounces-141352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 336878A1D23
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 20:03:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 636B71C23E28
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E9D1CAE7F;
	Thu, 11 Apr 2024 16:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SRw9gbg3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B911CAE62;
	Thu, 11 Apr 2024 16:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712854120; cv=none; b=DwxNgK7JCTBOJH+D78ifVNfManuj2CVtaXkcG1KzQoZZ+TtKldRPEFs0WB7/wj0JFQ5TrMw1P8Tti3haOly/1f8CpHPi5HVf+sxeFqTCsRWbToVRsvk/CP40uS2vB2SWq069pMMr52CQT8rhvq6E+8fiV8uPsZMss35Lr144WKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712854120; c=relaxed/simple;
	bh=LWlrTCJGqYKdS9PYJSR2H64H7PQGjxik5FHnH+YFRek=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=b4lghRai251c1Q5i7kqeWDYa1bgsyzRAOjWRGQx1PS6QEbpplD73QKvrN45NcfJtzPGANI8qYw60DPA6mRb8byAQU4I3wFcCJjlv+HEQzXNF+dWzjy2YVG1XENuAOedOEujy+bLXKySDXB9j3m9v038O0+j5obhvP12tYOkWsX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SRw9gbg3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11011C072AA;
	Thu, 11 Apr 2024 16:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712854120;
	bh=LWlrTCJGqYKdS9PYJSR2H64H7PQGjxik5FHnH+YFRek=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=SRw9gbg3ILr9SlXTXTQ+BUnw1oNfqMDP46YMiFKH2ywD5rU1P0dEI+ifC98brtzT3
	 sK/T8pTySfw5lZUKqDGe0eomeXbvOgcJM/BmFRtMyceO9GX3DEYpYSdTMuatLQPJxf
	 nLplnjGvyUcQBu8NuzBliq2HTBtzk1/Fcj/fZKzNGAXhRQHB2JVF12XTExdynCf9t8
	 iSd6+nVzTg9fkeIUENqsjt2GH2BlY0YH44BpSEAJyqvHQScjw5PfyNprZUfnH0d4xT
	 8scaN3SbJU5zDwE2FhccU4BjirKFtM2vAR5V2+KZcKZ+bIF59FTLnEtNBJBPHycIyy
	 /Ptqgg7AuvOGA==
From: Lee Jones <lee@kernel.org>
To: pavel@ucw.cz, lee@kernel.org, matthias.bgg@gmail.com, 
 angelogioacchino.delregno@collabora.com, ChiaEn Wu <chiaen_wu@richtek.com>
Cc: linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 peterwu.pub@gmail.com, cy_huang@richtek.com
In-Reply-To: <28FE6F1712799128000.chiaen_wu@richtek.com>
References: <28FE6F1712799128000.chiaen_wu@richtek.com>
Subject: Re: (subset) [PATCH] leds: mt6360: Fix the second LED can not
 enable torch mode by V4L2
Message-Id: <171285411780.2498946.3824215880975158305.b4-ty@kernel.org>
Date: Thu, 11 Apr 2024 17:48:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.4

On Tue, 09 Apr 2024 18:21:54 +0800, ChiaEn Wu wrote:
> V4L2 will disable strobe mode of the LED device when enable torch mode,
> but this logic will conflict with the "priv->fled_torch_used"
> in "mt6360_strobe_set()". So after enabling torch mode of the first
> LED, the second LED will not be able to enable torch mode correctly.
> 
> Therefore, at the beginning of "mt6360_strobe_set()", check whether the
> state of the upcoming change and the current LED device state are the
> same, so as to avoid the above problem.
> 
> [...]

Applied, thanks!

[1/1] leds: mt6360: Fix the second LED can not enable torch mode by V4L2
      commit: 0dcd0488a7a5b8762256b393a8bd0c21e5e4e0fb

--
Lee Jones [李琼斯]


