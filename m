Return-Path: <linux-kernel+bounces-106937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B59487F5B4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 03:51:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1EC4282BFE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 02:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FC6D7EEED;
	Tue, 19 Mar 2024 02:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gUqfCbee"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2A57E787;
	Tue, 19 Mar 2024 02:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710816544; cv=none; b=QHWga5WWRBhtYYODgGzoA+9W6aFpRkTjkrFAi//p0hO/LGL9KI1JxrtMpHK4NxHzDf/temxGKycoziXykNVwSc5PXIW2wae2ysu/OMNL+mCoyQrV8bbKbptfflVszERi/nCiMhOIQjgSSP3HnggDYpB8BxSJAWeruiLNEOsceLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710816544; c=relaxed/simple;
	bh=gpRF+lJdfbTnPjeClOUxk7+YW9eJwo4yAdza7kXiIl8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lo10LwUB+JEwI6148leW0fskZFpTbVI6AGXg/qiM5E7yKIHwqcBWbe2yznGecvaiQEvRzAVD6b3DTFDBa3Ctel52cT6goBb/Bmo5Sde0w34hL5QMSmOZpm5ry9XH0TYnKDkJLzx65s5wguHZWLvtXFpb4ny0v7K/U2angIJfGRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gUqfCbee; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60DA1C43390;
	Tue, 19 Mar 2024 02:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710816544;
	bh=gpRF+lJdfbTnPjeClOUxk7+YW9eJwo4yAdza7kXiIl8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gUqfCbeeblMxHRtmeMjrvgx+Ig8cEOSSNFIEr19h0gEWCEu0YqFeD18ElzXwz/Off
	 x75VOVi6kF/uQan03bAb3z/ZacI/TMV7DJO3Vh7utAWDcXDIk0nytx12gD5ZbfAMYJ
	 5j/tEwxcoUpK0vn3JpFuMyC1m6h49WPnliFkKfY2waJcgO/xdDOYDoY5G8m6r9pgD1
	 HWHZvyzPSGW8/HwvckwRIz40wVLOvx7SjmIk5zjCV0YUy97p3o8W8yu5buvypqZ5p0
	 wPImEzfuM5xodoZ+CnpXmZBu7hT4bbIWFRCL4UZUpf4stkOmtfEn9rmBfRIZLWNbYu
	 6BCpRU3XeOPhA==
From: Bjorn Andersson <andersson@kernel.org>
To: cros-qcom-dts-watchers@chromium.org,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Luca Weiss <luca.weiss@fairphone.com>
Cc: ~postmarketos/upstreaming@lists.sr.ht,
	phone-devel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: Fix type of "wdog" IRQs for remoteprocs
Date: Mon, 18 Mar 2024 21:48:35 -0500
Message-ID: <171081652634.198276.15349436224492922065.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240219-remoteproc-irqs-v1-1-c5aeb02334bd@fairphone.com>
References: <20240219-remoteproc-irqs-v1-1-c5aeb02334bd@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 19 Feb 2024 15:33:27 +0100, Luca Weiss wrote:
> The code in qcom_q6v5_init() requests the "wdog" IRQ as
> IRQF_TRIGGER_RISING. If dt defines the interrupt type as LEVEL_HIGH then
> the driver will have issues getting the IRQ again after probe deferral
> with an error like:
> 
>   irq: type mismatch, failed to map hwirq-14 for interrupt-controller@b220000!
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: qcom: Fix type of "wdog" IRQs for remoteprocs
      commit: dd6943ef8edde3c6b8aee06cb142c9a41086e3b3

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

