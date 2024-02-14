Return-Path: <linux-kernel+bounces-65755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21FE4855131
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 19:03:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0D5A291C54
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 495CE12839B;
	Wed, 14 Feb 2024 17:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oir38ZIT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA9512E1F3;
	Wed, 14 Feb 2024 17:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707933488; cv=none; b=NNkYVSh8yFmkNnsjjLulAXef0svRoY/ZPKcCEpv++ScKFW783KIYg85zE+/8NQOdzjPJvS3AksWi/GUBsExND3lnK6e/QbPs5nnewhzbWFY/53rqzbS57x38EkwpFCYdvXF29Na6BI7qfWQKyy9fYHwpT+iB6ylUuPS39LTOy7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707933488; c=relaxed/simple;
	bh=kVBd+BtpmJAzLk+pvXIPtTsiW8c8s/3lPu+YZRz4zAg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sTs6e/8WXhgXBr7pI23Sni1a35aNdcs9jnhdkPm5+uVnOB5Q3RqiIcxmzE2AARsre3fQJu6iIcZPElQuo6vrkDerDsQQVkEZwFX/YJ5qn8it/DcQ6xpnROX3ciga26Q/+rAxiJQn25tsr8X3sZv8pvgdaB/RaTiLLz4EJY7E02I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oir38ZIT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6DE2C433C7;
	Wed, 14 Feb 2024 17:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707933488;
	bh=kVBd+BtpmJAzLk+pvXIPtTsiW8c8s/3lPu+YZRz4zAg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oir38ZITyBXci6YfGr1zY33u5kKiIDlw2MEz0vXbP+t6jXTRr0MCOqX9U4U/JV/dL
	 O8rMbQmb7To1EDAtSG/WmSnt4E4gJaxKdKjmNR2NmFdiNY+FPE6WV3V0qHzcRYGX8I
	 jf5NrqKcw2DkX6wL8yXUb9G3tF3Bbcw6IDeVhQn30yLk4Q+YpJ5e0U0GXje9pFqHuB
	 Lmlpbl9sG69Iebl0sx9bpnEKaPETU3MkDVdU1322QHXxLTgtYd4FI1C8YWtokGACXK
	 15da2EiDkuztE0IG+u10B6bdo2axKLX5+/eI8NnfQZcGcrsNueM/52AGzrai3R7QBs
	 zzzhPvfxM2Lrw==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Johan Hovold <johan@kernel.org>,
	Bjorn Andersson <quic_bjorande@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] arm64: dts: qcom: sc8280xp: Make pmic thermal-zones report temperature
Date: Wed, 14 Feb 2024 11:57:36 -0600
Message-ID: <170793345800.27225.16430532154168719897.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240210-sc8280xp-pmic-thermal-v1-0-a1c215a17d10@quicinc.com>
References: <20240210-sc8280xp-pmic-thermal-v1-0-a1c215a17d10@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Sat, 10 Feb 2024 20:41:58 -0800, Bjorn Andersson wrote:
> The "pm8280-[12]-thermal" thermal zones always report 37C, fix this.
> 
> 

Applied, thanks!

[1/2] arm64: dts: qcom: sc8280xp-crd: Add PMIC die-temp vadc channels
      commit: 6cca740cf345e24fa6bdfeae9236bfb4c6f90c3b
[2/2] arm64: dts: qcom: sc8280xp-pmics: Define adc for temp-alarms
      commit: a36a566b5365ab96ed8cfc195478be77811c8708

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

