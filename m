Return-Path: <linux-kernel+bounces-55965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 736C984C42A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 05:53:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FD7B1F2234B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 04:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F93E3D552;
	Wed,  7 Feb 2024 04:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dcsfBkXi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01A13CF46;
	Wed,  7 Feb 2024 04:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707281245; cv=none; b=GD8pJDkYtYsR0nbzSVYLHwjHzaYoIs5pMzF8ESMioGLMqhvyUst0axbzbUdv5MKA96JXjSQdSgGbkpZbySLng8va2C22b1/ilpwHpHzQSOOhJIbJ56uNfSVfQnYSnZ0awfRqjgMbLSyMxgnr/QgT+12bNc+hiU8/+XmOn7I+qmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707281245; c=relaxed/simple;
	bh=2GAuJRwwh6BMsQz6HsPuru1jdYnJC9ddYZoTVxvrj+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PHrJd3V7rf1tIBYbArPllefRZe7sJf99TNXjlZg8BUYfz+b8GDZZ0ZvBKNCO4ah2CQm/mYA7ITJgNgBI3D/i1mc3olPO0yOpU663TQGMMFnvQ2yN8Zdge29jhRQxcqISwHPZDee0lfKnjU1wtF3x20HQEFbqqCNZzVxKou/s+vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dcsfBkXi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D19E5C433C7;
	Wed,  7 Feb 2024 04:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707281244;
	bh=2GAuJRwwh6BMsQz6HsPuru1jdYnJC9ddYZoTVxvrj+M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dcsfBkXiVWdyWnbw2gwoKwB0xHL6EIl9e47fiFtIoPJsjicoIM+ychwJHiBcuKAAq
	 MDsohCNJPTMOxoEtq1AIY6VtKP8IZ3HTXI5f4MW75E7pdEKT725oOBAEAbHXtExMTI
	 Rj1gTosTBXIMR/EuTSDGCHwJHCJORUQZBZVHSgXWBRQRs7+z2KF0rW05qQOWIFHhAj
	 n+5/NjbrKgQvT29IuJp+CjuODGVs/zqzk+4YugfnZ87TIL3Otl+EGg4BuGs/ZNEiBs
	 cW1gTjht7/QK1W64PWIDz4C7ZzRZ6+M5qArvqSdb/CLDDczBLvnv2Pgl8GzGGSuYSO
	 XVyu+6CM8UIeg==
From: Bjorn Andersson <andersson@kernel.org>
To: agross@kernel.org,
	konrad.dybcio@linaro.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vignesh Viswanathan <quic_viswanat@quicinc.com>
Cc: quic_varada@quicinc.com,
	quic_mdalam@quicinc.com
Subject: Re: [PATCH] arm64: dts: qcom: ipq9574: Enable Inline Crypto Engine for MMC
Date: Tue,  6 Feb 2024 22:46:41 -0600
Message-ID: <170728117672.479358.6337685113940733695.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231215095339.3055554-1-quic_viswanat@quicinc.com>
References: <20231215095339.3055554-1-quic_viswanat@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 15 Dec 2023 15:23:39 +0530, Vignesh Viswanathan wrote:
> Add Inline Crypto Engine reg and clocks in MMC node and enable CQE
> support as Inline Crypto Engine requires CQE to be enabled.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: ipq9574: Enable Inline Crypto Engine for MMC
      commit: 2ae5e34d93cfe5c46229274324e1b2d176a0b516

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

