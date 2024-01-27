Return-Path: <linux-kernel+bounces-40952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF8FF83E8BA
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 01:48:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E46F1F2255F
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 00:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7EBB5395;
	Sat, 27 Jan 2024 00:48:18 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7851E635;
	Sat, 27 Jan 2024 00:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706316498; cv=none; b=mZauLnkkcmJ5kPBXtXVtgmIBfQnVzUhbc4DWgkHTNP9We+XXRwce+2Up840bwCk8pb9gco6Nn8vEgujj9JbqzrwHwddBGa5FeNkmQf2w/y3YLE/DsIvrcqHItvbcgL9dpOj7bDnIoiqda+yzfZW38N+AWsDRFghjk3JmN9/SKoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706316498; c=relaxed/simple;
	bh=EboBIDIuZlvvgNYx/X+iZDyLYLDd3SQh3LNMCegjTF0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=uiEt+jEa3DpHGhodDHNJYfTdWtsNbSAYJrrik+XVAMuyw4tYh2lf37Q5RlpigY+ixieFkvdChFXPokqY3xQRI3BouhL5YwCw6jUp4Ug9KWPWzqOmu1reHpeih5wje6vlAEI//C/QLqGpKISNXYZU28xWgtNqEGOhECa4uOkJEpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4F7EC433C7;
	Sat, 27 Jan 2024 00:48:17 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id 8B796106A754; Sat, 27 Jan 2024 01:48:14 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, 
 Johan Hovold <johan+linaro@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Xilin Wu <wuxilin123@gmail.com>, 
 linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240123160053.18331-1-johan+linaro@kernel.org>
References: <20240123160053.18331-1-johan+linaro@kernel.org>
Subject: Re: [PATCH] Revert "power: supply: qcom_battmgr: Register the
 power supplies after PDR is up"
Message-Id: <170631649454.848866.1713665101799637125.b4-ty@collabora.com>
Date: Sat, 27 Jan 2024 01:48:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4


On Tue, 23 Jan 2024 17:00:53 +0100, Johan Hovold wrote:
> This reverts commit b43f7ddc2b7a5a90447d96cb4d3c6d142dd4a810.
> 
> The offending commit deferred power-supply class device registration
> until the service-started notification is received.
> 
> This triggers a NULL pointer dereference during boot of the Lenovo
> ThinkPad X13s and SC8280XP CRD as battery status notifications can be
> received before the service-start notification:
> 
> [...]

Applied, thanks!

[1/1] Revert "power: supply: qcom_battmgr: Register the power supplies after PDR is up"
      commit: d0266d7ab1618482d58015d67a5220e590333298

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


