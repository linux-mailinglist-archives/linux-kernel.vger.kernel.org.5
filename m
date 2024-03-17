Return-Path: <linux-kernel+bounces-105470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F07687DE78
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 17:28:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF810282404
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 16:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A7041DFDE;
	Sun, 17 Mar 2024 16:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HsHdL1Ug"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87FC1DA21;
	Sun, 17 Mar 2024 16:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710692848; cv=none; b=f1n75o+M74k1uGkbiDdJa3BsMxYsaYicT83mjTmUhC/LZ/T1xmkmq1JZgt5yiNCTpSxr/S141BMlQER4+RGKKOtCdUt6Tv3wG4cyyof1fqA3g+6AB8i8gVdUtO4cWUIx8BBNVfbYU7BMZzY5wOY/5IryEHRFGHpMhv05QKW7auY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710692848; c=relaxed/simple;
	bh=S1u3ZkYo6oYzq/fn5x93M/7tPUrHxAvHHFoR2Qyqwl4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ErK5ZqTE1ks6xMkLIfp1KBBWzetzh0UjZvzOD8tmfIIKY5bgPVnb2pvSdZ522bt2vl0ZvRu5cIRNio8r0bRCcfhNfkqHeOKwcNd2gZyCcZWwaIyfzbij6TPc+8escvY3mHLgUsJVSy9aXuRHHlWWosGfgOL6cINYPnF49wKr8pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HsHdL1Ug; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CD9CC43394;
	Sun, 17 Mar 2024 16:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710692848;
	bh=S1u3ZkYo6oYzq/fn5x93M/7tPUrHxAvHHFoR2Qyqwl4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HsHdL1Ugp1j7rPByCruGs2qXZmpNydw9914nGiFP+bwlei6S7aqucm132YE3VL76Y
	 NK78M9EIe39RSKnAeR+0pmkMsjIG/UV5fVgNeAXKgkB+8sqrViwhmlP8GZTrNO/dmI
	 O2X1bSpNH/Ld3Cj5RScwpOM41X0qIaveZWnd+y3NokoptGPAs3/KjyH3Prh//NJl9e
	 jo59dV1hvw4TmBLjtxxZESftXIQ38P/wBtaYFddHBWeVQj8sOLY406vB/qCtOEmAXt
	 KbshozNywNFxAGCLVrATpfY2CGy4lC0fwD9f5brZF2tYeiVemgmI2oGjykDhKuL9YF
	 dUHoFLjE8yOWg==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Maulik Shah <quic_mkshah@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	quic_lsrao@quicinc.com
Subject: Re: (subset) [PATCH 0/2] Update init level for cmd-db, rpmh-rsc and psci cpuidle domains
Date: Sun, 17 Mar 2024 11:27:19 -0500
Message-ID: <171069283520.134123.11587509643696857617.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240217-init_level-v1-0-bde9e11f8317@quicinc.com>
References: <20240217-init_level-v1-0-bde9e11f8317@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Sat, 17 Feb 2024 19:27:06 +0530, Maulik Shah wrote:
> cmd-db and rpmh-rsc are used by clients like regulators, interconnects and
> clocks for resource voting. These clients are in core_initcall() while
> cmd-db and rpmh-rsc are in arch_initcall(). Update init level for these
> drivers also to core_initcall() to avoid unnecessary probe defer during
> boot up.
> 
> Similarly psci cpuidle psci power domains are used by rpmh-rsc driver and
> they are in subsys_initcall(). Update it to core_initcall().
> 
> [...]

Applied, thanks!

[1/2] soc: qcom: Update init level to core_initcall() for cmd-db and rpmh-rsc
      commit: 15ec7c641dd3a33f4d7b7c0cc59369d87edcec5c

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

