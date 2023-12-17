Return-Path: <linux-kernel+bounces-2717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B14C8160EE
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 18:26:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 553BF281F8A
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 17:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE1A24E632;
	Sun, 17 Dec 2023 17:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cXtgNQnh"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188C84E1D5;
	Sun, 17 Dec 2023 17:21:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 377F7C433C8;
	Sun, 17 Dec 2023 17:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702833716;
	bh=3jB1OAj2fC/I9zwK4vJbuYebYVPXsF3XN1a6d6ipEek=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cXtgNQnhM8m0MmdktgUAlY3pxd8B3sl0sGeyFKrEt/ccZCR6I9kd9CAX+72guU5i6
	 sQXFXLqW83HazA5vJTywmb6ql+vLf/luBUBBH9ObqGbY8NZPoYLY7rujABWZfGDFmH
	 4VNcZN9wa7zW0+5Gjw7bVLZyc3yB3jmrqj2/4ujYwMa1l+vEBqmaDHZgPgu5kRM+jx
	 05Ni5K5BF2kmvS42v+8xDRCJ4hCw8zzE6wd+qAHV7ewWA6rSDW/vg9Mb4sq1oujqiD
	 +OC2Lj1ioTpvz25pm+eTJHHmjoR43Pd/UVmghucGDCJNUy/X1bOV5wGvVP4NkRAn4n
	 ZqwucovouwvIQ==
From: Bjorn Andersson <andersson@kernel.org>
To: Andy Gross <agross@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH] Revert "soc: qcom: stats: Add DDR sleep stats"
Date: Sun, 17 Dec 2023 11:21:11 -0600
Message-ID: <170283349403.66089.17185049148396961506.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231214-topic-undo_ddr_stats-v1-1-1fe32c258e56@linaro.org>
References: <20231214-topic-undo_ddr_stats-v1-1-1fe32c258e56@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 14 Dec 2023 13:25:15 +0100, Konrad Dybcio wrote:
> After recent reports ([1], [2]) of older platforms (particularly 8150 and
> 7180) breaking after DDR sleep stats introduction, revert the following:
> 
> Commit 73380e2573c3 ("soc: qcom: stats: fix 64-bit division")
> Commit e84e61bdb97c ("soc: qcom: stats: Add DDR sleep stats")
> 
> The feature itself is rather useful for debugging DRAM power management,
> however it looks like the shared RPMh stats data structures differ on
> previous SoCs.
> 
> [...]

Applied, thanks!

[1/1] Revert "soc: qcom: stats: Add DDR sleep stats"
      commit: a7dc6343519752eb6d86bfa78378a8af5da1f475

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

