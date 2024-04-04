Return-Path: <linux-kernel+bounces-132148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F48F899045
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 23:27:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C53F21F26796
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 21:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB97A13C3E5;
	Thu,  4 Apr 2024 21:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="raPoidJt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B4D13D27C;
	Thu,  4 Apr 2024 21:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712265818; cv=none; b=TO6218BZd42V36PYkbdZ/6lcZ9eXSRsihjc9cmvO2x1OwemeBXYQANqBVlvwdMW+E0M0Pdp6atGqPQ1s6r7oDZ7JxD/GAsIrE++ksowfWNwyXI2uXelYp2Gf5GF/hsYa7lxOcxkHfM6hMnozXuSKiUVtMvSTZ+dIOoeGC/ElV08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712265818; c=relaxed/simple;
	bh=XjLROPNRWacLN+cGH6Oj4CPACQ5njTW+AZu0hRq+g1A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R64VWL/q7fvQb/IAkE+UWBayRAaaXVyLSNoGRwrtcs2cmn0M34DbcDoZmNj8qoB9cBHNwzMyiftlT/6J4uGEXiwl3lvxM+VFmX4tbKlMhGbWqeB3ehVOPp53m3BDS1BgDq9tf09K6XXoQSBTLLcLwA99EOPIxp+0cpRYMCB5e4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=raPoidJt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C8FBC43601;
	Thu,  4 Apr 2024 21:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712265818;
	bh=XjLROPNRWacLN+cGH6Oj4CPACQ5njTW+AZu0hRq+g1A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=raPoidJtpdvjMCuIoOdokOXBPgNadP9deo4JGkUWatrJLSrEpKK++nL8EpCdIsxGJ
	 cPZZ5ZPU3YwsNaFeDsJbR3A2iJ/gfZjDo5LWyae/v7+uR/kTtnivbSmm4iPtalHy84
	 y3XQTLxrc+r1sxVQw2j3gRDzP3+jj6eP4TSY+P3wWaMO3KwCZwyHoMnQkF+25eGMPQ
	 GOanN5J4fMBrmw2PBwcCkG4MAnNwgpIj2pfHqQzXpjW3WEfxonSf6u7qv1ZnpTnttm
	 pWCYapRaRS3hTy12lZgLrywdLiKK8Dxm8qaI/ZfC1+SUFA6KfA1LiZ17NXLR6Hy7Up
	 P/PMcvmC36egQ==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Andersson <quic_bjorande@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINER: Split Qualcomm SoC and linux-arm-msm entries
Date: Thu,  4 Apr 2024 16:23:04 -0500
Message-ID: <171226578690.615813.12760754306024161860.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240319-maintainer-qcom-split-v1-1-735d975af2c2@quicinc.com>
References: <20240319-maintainer-qcom-split-v1-1-735d975af2c2@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 19 Mar 2024 17:01:45 -0700, Bjorn Andersson wrote:
> The Qualcomm Support entry in MAINTAINERS has served the purpose of both
> defining the scope of the Qualcomm support, and to make Qualcomm-related
> patches show up on the linux-arm-msm mailing list.
> 
> While this continues to serve our needs, it occasionally do create
> confusion about the ownership.
> 
> [...]

Applied, thanks!

[1/1] MAINTAINER: Split Qualcomm SoC and linux-arm-msm entries
      commit: 8b90269ee6d7f8e714a1ba57a85444a67b9f0104

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

