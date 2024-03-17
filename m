Return-Path: <linux-kernel+bounces-105467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B17087DE71
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 17:27:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E46D9B21142
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 16:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CFEE1CD29;
	Sun, 17 Mar 2024 16:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KlBHeJEr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4441CAB7;
	Sun, 17 Mar 2024 16:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710692845; cv=none; b=eBKMFZNpzbXXhdRYS0fJjFcufj8SAaCrLbR4Qvb/2HC9yBhN1XexNOoRBfSzmQWfAnJQBN4P6lbsQl7hcqVXnkjEDp/t/Hk/t0VbQTpOnxhwiReMIM+MCoRTXT4J5+UQPXODMTUAECC0QFpcljmvp8VNbtABUlcbgRHRyatFX14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710692845; c=relaxed/simple;
	bh=J6UtGI5bJeJCYfzWsrAHw9nY2Blhqb2ZvPfQpf1DE3E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f1dNWZ80y9ZbQwgAmWhZ+L5/GggS/6eb2qlSPjd/Dapk76ApiR3fEuZmTLx0a2CA6V02HuVjYJCwmInfgqGwSU3rCBMUfK0QgS4KSz5+P33GJ2nYOVfJz0giiPCqgdyXTB5TMLDrLg8IC2zLvou7edeeOaemeBPaW9Mmrsa/twA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KlBHeJEr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF1BEC433F1;
	Sun, 17 Mar 2024 16:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710692845;
	bh=J6UtGI5bJeJCYfzWsrAHw9nY2Blhqb2ZvPfQpf1DE3E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KlBHeJErrrTNeBvoKkLogXoYyLonHZWhi87D8MUz1npLSq7F6Rup2lw0JoHAV1WGg
	 kJb6at8jNZ6Hf6xNsnBK7IAGEJTUuONNStsbisDb6ZXUr/92cFDzbk3z/G0RBXCqyX
	 Xrq8x9EXsmwYuBmrFFVOXkfiVDNRFuH+fbvd5SHRDk4CrSkmjIHxXKaJBQ8Q2mKV9X
	 Wx8NsumtVdCnxWVxGHmEn3JibFFm3Dm32IfyDJw3qCDUCDjvJRDMGlZT2Rhx8DR3Dv
	 BQvHVLfEncPXMN42DJ83OMoYxiOOVJJqM4XXw9uUSUxUkcW8udw1dgunePZJQ1wstn
	 0Jv/QwTI2jG+Q==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Abel Vesa <abel.vesa@linaro.org>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] soc: qcom: Add X1E80100 platform and SMB2360 PMIC
Date: Sun, 17 Mar 2024 11:27:16 -0500
Message-ID: <171069283522.134123.14650965425548964366.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240223-x1e80100-socinfo-v1-0-be581ca60f27@linaro.org>
References: <20240223-x1e80100-socinfo-v1-0-be581ca60f27@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 23 Feb 2024 16:37:54 +0200, Abel Vesa wrote:
> This patchset adds the entry for the new X1E80100 SoC and one of the
> PMICs it uses, the SMB2360. Rest of the PMICs are already added.
> 
> 

Applied, thanks!

[1/3] dt-bindings: arm: qcom,ids: Add SoC ID for X1E80100
      commit: 734364d0ddee6c145705bac89400266c972efc0b
[2/3] soc: qcom: socinfo: Add X1E80100 SoC ID table entry
      commit: e876303c6f18da4c649d97f6d488ee0a850ad384
[3/3] soc: qcom: socinfo: Add SMB2360 PMIC
      commit: e025171d1ab1edf286c102f7adecafd51c3a84c3

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

