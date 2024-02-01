Return-Path: <linux-kernel+bounces-48899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BAB48462FC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 22:54:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3765328B746
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 21:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87CA14177B;
	Thu,  1 Feb 2024 21:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k2usIAUu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F984120F;
	Thu,  1 Feb 2024 21:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706824439; cv=none; b=IrW2nbOQbqFkYfYU9JxjBbtP4L4bXSKn7pc+k1GhIb/6nule1TX8ymc60pqxQ/WdPl81+LUUOLg/lRqtKl2l0DkHg6/+e8s0a9r4xpzxQ1iCQfCWj0/5thCQKOsIWwzpN7cyiiEOT8WY2iyDpPnmA0w3R/qnSY5Ahd3QWSlHBEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706824439; c=relaxed/simple;
	bh=/5hsI/aieNefVFKENq+yf/xRdfw3lwpSgjpPZyHNB1w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kWykb82qZhtwflaiR2dB1MeLa9q+STB2ckGI+IoIYLJQu1rExE0xHmpWJQNEbBt5evD74nkCEV4FSU7orLGJpbV+ubHXLLsQsyQbmnRkZeIJbWHqucgz6GocrG5VrO2agpqRtS9phwiV6jFmTxmfwqfxLFgVlnpgNogT6g+PBTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k2usIAUu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74E64C43390;
	Thu,  1 Feb 2024 21:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706824439;
	bh=/5hsI/aieNefVFKENq+yf/xRdfw3lwpSgjpPZyHNB1w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k2usIAUuNXEJghy41WbjkZpyIQH3tF8lRikk9ZsfFOHAuNfnPz0xrYZlOfN9SGAF7
	 cPBXi+bzCKLAoxdhJ0Efv5mdCp9za8TH962eKU+vpZ9I8s47bNkSs/PX26ZziXfILv
	 F+uSiYBP+PXSxVIfFtP49VkKe3sKXLij0sBcQ1DxVMy5ghdk2xnwTHwQ1AEnMJ6+WK
	 AMRx2w+0uBPkyvQ2hpCADr44N21ZvzXQjI8ggVWV3ZPSudUUgwq0c+TkGclDkjoa5y
	 j+zEJIByaIRuIpSX3ak+RL2HuA3AsCmCZOWW0dgb5kFkeu6YlXNgF4YobRPAokCsoI
	 PQNAsqWd2nZLA==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Rudraksha Gupta <guptarud@gmail.com>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: qcom: msm8960: expressatt: Add gpio-keys
Date: Thu,  1 Feb 2024 15:53:49 -0600
Message-ID: <170682442872.248329.11924880934017435944.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240120-expressatt-gpio-keys-v1-1-4da7e37440b1@gmail.com>
References: <20240120-expressatt-gpio-keys-v1-1-4da7e37440b1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Sat, 20 Jan 2024 00:45:23 -0800, Rudraksha Gupta wrote:
> Adds volume up, volume down, and home keys to expressatt
> 
> 

Applied, thanks!

[1/1] ARM: dts: qcom: msm8960: expressatt: Add gpio-keys
      commit: 8d90980509f25fecc7ff085e1723e4d8dede4ade

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

