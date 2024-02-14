Return-Path: <linux-kernel+bounces-65754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E4685512C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 19:02:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1C8029137B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACFF612E1F8;
	Wed, 14 Feb 2024 17:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M4i2Q0Xi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF78B12DDB9;
	Wed, 14 Feb 2024 17:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707933488; cv=none; b=LPtbhyaXCZvfk400V2++M8VYNrML2Zw7ZSO0U/VX2yLCCJNyqUmpfP+DhlxzRt7yQYiB9k/aZafxtdBCUkBd7X90bazXDA46+KcuY2V11rik2F2Tk04Arhp83CeNzjrlfDpZ34utD0OojTOFktoJkoyA4NnNsswMmRfBeB2PnrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707933488; c=relaxed/simple;
	bh=sLNZ/NFnZZwzLk8k0mE6Ia0nxw25NgDOMktTDhoHscs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ElsO3C9aZt7whvxqn05n2EKy+L+bwxTBy5PcixdrMF0gxEralm/wsNmLDBCqA8UZV21ROvvrmwb6B3RiaVZOWLYmmaDeX5inXAzXtqeveOYJOg+wkdpXs1+D4D1ds5p77jTalEYHhK+Y24IO0Bzrmr7UCfS6ueIabus5kOFeqQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M4i2Q0Xi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8B48C43141;
	Wed, 14 Feb 2024 17:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707933487;
	bh=sLNZ/NFnZZwzLk8k0mE6Ia0nxw25NgDOMktTDhoHscs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M4i2Q0XiqrI/OFAWhylvoVRwI+3oxv0jh8JFtYeoVTnRbtr5rskXlTxbNCi8Xfr3H
	 oB4PeneOfJJHDok04Dir1dOzq4QS5AhyYvEpBJKM0Ool4wO3FaSrapJFtll9xIGCCd
	 nbB+FThpWpqZge2j7xYe1lmDjm+g68ugTIIw4RNsasEz+ANR/cAOATEBNrU2vgJcwk
	 NA/p69gJwltrIw4jlNfXbnD2gu1wyCYeNchAEAVsy7Kw9A/0XrxHgyEyYEVr4idFDI
	 tkvw752wPtSpKhdJg+eVYE5qn/a3S6Go4P2O5tU01pyGw2jiQZPTJ4ZPTNwakLYx2d
	 RTWljBHaH4mSA==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] arm64: deconfig: enable Goodix Berlin SPI touchscreen driver as module
Date: Wed, 14 Feb 2024 11:57:35 -0600
Message-ID: <170793345829.27225.7630789789345289123.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240203-topic-sm8x50-upstream-goodix-spi-defconfig-v1-1-b69ed85ddd05@linaro.org>
References: <20240203-topic-sm8x50-upstream-goodix-spi-defconfig-v1-1-b69ed85ddd05@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Sat, 03 Feb 2024 21:20:17 +0100, Neil Armstrong wrote:
> enable Goodix Berlin SPI driver as module since used on the
> Qualcomm SM8550 QRD and SM8650 QRD platforms.
> 
> 

Applied, thanks!

[1/1] arm64: deconfig: enable Goodix Berlin SPI touchscreen driver as module
      commit: 95af34a4c25c2e5429bf76643cdab9c2d3cde6e3

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

