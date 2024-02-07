Return-Path: <linux-kernel+bounces-55954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65ED684C405
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 05:51:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA93AB2892E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 04:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 838D125558;
	Wed,  7 Feb 2024 04:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rESEzVQ0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8F324B57;
	Wed,  7 Feb 2024 04:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707281229; cv=none; b=UwtLfyprTvd96K3uMEsx5ZK2MoAhzu88CTPzxsYw3si6i5VhI45rrtPTy74FqgZsNtmbsah5UsLHAYzMt/yyoalTch9us6PoafaW9Qv59brcEGhJFsYKTARrVse8fmB3oii2T0Jjx5eXOpjGeQyYllQI7SM8DMBS2rE1YdzLNgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707281229; c=relaxed/simple;
	bh=rCQE15faXtZ2lzGZpXeB3PpENqCtR28s/XN6xK+Y35w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MSs4D5M1xdoipHMf4R3tVyfdRyTIQKwpfb1k7neb77z+rS96IXPAYDvjsCEFQCbrwwzK5RMzlOKQr7eo11CROHkVJyfc7bnAfFliyX2t6m0LfYOTIf8eMdlscHQyyjnkh0JHniUgXdFz8Y0FXzz9EKkCTX5hz2LnK4odc6Ev3UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rESEzVQ0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 395F9C433C7;
	Wed,  7 Feb 2024 04:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707281229;
	bh=rCQE15faXtZ2lzGZpXeB3PpENqCtR28s/XN6xK+Y35w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rESEzVQ0+WC+60VEl9uScgS8QgFEzdZp4dhx2QYLzB6DI6vX3a9ET4YRKllf272zy
	 A6pdigmrRVi0RRKceWN+788IhJXxe5HlHMdxhT2UpoJL4BD81IkdFc74jSLlVk2uhO
	 f6sPvPb9RnovbqH7++wLBdjCGvp9KLpkSaZy3tGvEGUIj0MC0Vti/ys8QTSpk2uYCy
	 TI1BYqLVldvNhwDKWt1au7WXSo5M542H44A038ryxBcta6EsP2Aa+L+3f/qurFod4R
	 xxjza+gTl5FyHB3aCM4nwmUyIuo+X6k/MruGKXxtk69oZwK1ovMGLH2MtlWjSmKMqb
	 1fwV2FukaETmg==
From: Bjorn Andersson <andersson@kernel.org>
To: Amit Kucheria <amitk@kernel.org>,
	Thara Gopinath <thara.gopinath@gmail.com>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mantas Pucka <mantas@8devices.com>
Cc: linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH 0/3] arm64: dts: qcom: ipq6018: support thermal sensors
Date: Tue,  6 Feb 2024 22:46:29 -0600
Message-ID: <170728117682.479358.4982062536293301053.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <1706173452-1017-1-git-send-email-mantas@8devices.com>
References: <1706173452-1017-1-git-send-email-mantas@8devices.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 25 Jan 2024 11:04:09 +0200, Mantas Pucka wrote:
> IPQ6018 have a thermal sensor HW that's compatible with existing
> qcom-tsens driver, so add dt-binding and enable it in devicei-tree.
> 
> Mantas Pucka (3):
>   dt-bindings: thermal: qcom-tsens: add IPQ6018 compatible
>   arm64: dts: qcom: ipq6018: add tsens node
>   arm64: dts: qcom: ipq6018: add thermal zones
> 
> [...]

Applied, thanks!

[2/3] arm64: dts: qcom: ipq6018: add tsens node
      commit: 0b17197055b528da22e9385200e61b847b499d48
[3/3] arm64: dts: qcom: ipq6018: add thermal zones
      commit: 8f053e5616352943e16966f195f5a7a161e6fe7d

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

