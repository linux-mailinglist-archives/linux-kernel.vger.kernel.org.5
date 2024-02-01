Return-Path: <linux-kernel+bounces-48900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F328462FF
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 22:54:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A312B28C3D6
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 21:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67C2A46425;
	Thu,  1 Feb 2024 21:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fAlKm5uw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF4645016;
	Thu,  1 Feb 2024 21:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706824440; cv=none; b=naZFSPsl27DUX/s+wiK1N3/kW2+o9zx4KwlaT5RFfNLlG5q2Gmvd3lIu8/J7lJaAu334HUnx+l3LytjN0riKFJBv+N5dWlXx4cKkRkUATjc4eqPZkwsE0upAO5FJmbNNx8I+IVxoCLvX+UGlC1Si2uZnDIlz5Cn1RNAZeNqGxXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706824440; c=relaxed/simple;
	bh=UCVnGGP6dgSIA1bb1c3Zby+Z9IKSgvYCCBuMXuk74NY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k8RVoH4FbXdXxjbEQ1ZdOCre0SKQEPo/HFMdHqk9YAZM2sZAx8TMrL+rcHpXdGeCaiF2LtY8V+at5ybWOvWm1LaGD2EymTKMu+Udp74N4bO1jhE6Osd8PDOcgX4FMKuhtJYNroYdPohZwW/eEMHdDsSfIF118TlfHT1maxEZkpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fAlKm5uw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ACCEC43394;
	Thu,  1 Feb 2024 21:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706824440;
	bh=UCVnGGP6dgSIA1bb1c3Zby+Z9IKSgvYCCBuMXuk74NY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fAlKm5uwXM0goNtWqUUDx8JPMIEPb0crscbi5pwT/zMXrVzhfefxZ67WuruRJztVo
	 p5GbWbT6W3l+bpIF2ChXGaVTARPY1D1BT9Shs0MfB+PHEfwFyaatBxZ14eBCi2YXlN
	 NYHG+G12Gs0Z+SPs+rjCTG1QdySg0hRYhUsAeUNLogJBPA5HndLmLygt2G/ELIkwS/
	 ZErIlilQAGcp/2Hsz2eZXlu+C6HGRVSSOUDRogbXMCFi/JQGjSc8tdEBgecuGjn/KV
	 JPodJ2HXGjN167xvwrCqJxzp+YcVQqkj0jKmF0Zj1PVQa2gtUAVYeMYyoVaYpwGFFm
	 kGdcoKWqpaKVg==
From: Bjorn Andersson <andersson@kernel.org>
To: ~postmarketos/upstreaming@lists.sr.ht,
	phone-devel@vger.kernel.org,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Luca Weiss <luca@z3ntu.xyz>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: qcom: apq8026-lg-lenok: Add vibrator support
Date: Thu,  1 Feb 2024 15:53:50 -0600
Message-ID: <170682442873.248329.16640760772830725680.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240121-lenok-vibrator-v1-1-d4703ff92021@z3ntu.xyz>
References: <20240121-lenok-vibrator-v1-1-d4703ff92021@z3ntu.xyz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Sun, 21 Jan 2024 11:09:57 +0100, Luca Weiss wrote:
> This device has a vibrator attached to the CAMSS_GP0_CLK, use clk-pwm
> and pwm-vibrator to make the vibrator work.
> 
> 

Applied, thanks!

[1/1] ARM: dts: qcom: apq8026-lg-lenok: Add vibrator support
      commit: 4d679e3c29e3609962de43edddd51c8c1abda34e

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

