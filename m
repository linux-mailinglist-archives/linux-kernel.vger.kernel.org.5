Return-Path: <linux-kernel+bounces-141770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 279428A2335
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 03:28:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA0261F22FAB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 01:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1D4710A0D;
	Fri, 12 Apr 2024 01:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e5raXPwn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12310DDA5;
	Fri, 12 Apr 2024 01:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712885250; cv=none; b=EFpXw/xasJEy7wj291vwVjmdmExg6UNyz6NQxkrSkXR8ufEkEUNWOOFHuuqsCP7zcQnBtMFz38In1rlFGTiPSnSG6itYNebcsR4nPDHnK73ZolnHfKzit/VBQPpgCUyLaf8x2SSz52BIjPUF9bVB+7XUq2eYpr/P9ey5aePiCz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712885250; c=relaxed/simple;
	bh=5ViWQZ7ou49Yi5Tnf91RIZvSahqJo/+6GhHKRmpt2Y4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mINsxBAy9AU7qKxXDCK9n2V4OMbozrysigaEDWMKB2FSoCVDn6Awp47XdmLskWeeQ8Z4cv5aGb/lHVaFhekzlzYca6EWBgImRz8BTG6YjZMW8JPFs7rzzu1iFJ+6gc+bNuE1B8EidYks2JILUT12JGG7vlJ0CA+BDiIrvRDl5iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e5raXPwn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC9B5C4AF0C;
	Fri, 12 Apr 2024 01:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712885249;
	bh=5ViWQZ7ou49Yi5Tnf91RIZvSahqJo/+6GhHKRmpt2Y4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e5raXPwnOradGJVdlQR6W2+MajpJeqIokJo/5RBLUhJ8myP+u+zKz5ve9QEivkDLQ
	 4CWGiWADSDFBzlAgt+mWXp4f70J7WVC2gywwDkBLLB/WIXHj2dTZwXm7wU2nH7hdPs
	 NM/5urLYvf6uUxiLBaleu/9l5lgSM3PXmT0vUyV2N3iPURZrHBPG2ef0/xsTWnLEny
	 14f0SdtDTfxOVFTBPp8uz5XHz+DXuls6Xe9SkWDp25slx4QHgE+6XaL27pO0bTSto+
	 VPIvHQmVsIneQJFROXgHXKtLAi0EFbMJ0DfwruhV4+Ubyt3HaJGLcaYjYSu+pZiFFC
	 vXYwRwCN8wEBw==
From: Bjorn Andersson <andersson@kernel.org>
To: ~postmarketos/upstreaming@lists.sr.ht,
	phone-devel@vger.kernel.org,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Luca Weiss <luca@z3ntu.xyz>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: qcom: msm8974-sony-shinano: Enable vibrator
Date: Thu, 11 Apr 2024 20:27:23 -0500
Message-ID: <171288524178.749915.2229709720158856709.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240406-shinano-vib-v1-1-fdd02af39d56@z3ntu.xyz>
References: <20240406-shinano-vib-v1-1-fdd02af39d56@z3ntu.xyz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Sat, 06 Apr 2024 17:27:20 +0200, Luca Weiss wrote:
> Enable the vibrator connected to PM8941 found on the Sony shinano
> platform.
> 
> 

Applied, thanks!

[1/1] ARM: dts: qcom: msm8974-sony-shinano: Enable vibrator
      commit: 5c94b0b906436aad74e559195007afdd328211f4

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

