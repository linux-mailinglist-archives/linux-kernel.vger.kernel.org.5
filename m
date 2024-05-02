Return-Path: <linux-kernel+bounces-166696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E79368B9E46
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 18:12:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A39E928689E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 16:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD7215D5D1;
	Thu,  2 May 2024 16:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tt33j9UN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D1115B984;
	Thu,  2 May 2024 16:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714666334; cv=none; b=lW9n5x+7XOxBatbXViLI9DvFu7MkyEWXz7KMVNZb3IEyCXyVENI2Wglw4klaFu4BJr2OoyNuCFhvjVkmBxbLp+MQhJrCb+E2S5RUMT2by/2IJV5yEWgJIXAfjYaCJFLVOAq54WmD2YJWxvgywMJbEEmn1S8jSJLDNvEkSX6WGl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714666334; c=relaxed/simple;
	bh=fTdWNLWguxqx1+6cG3H0uL6VLl/ZYaZcqOAQFQE5u7o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=mky+Ry4Ua22/D+cxNE+WwHp/105yTE8JLB3ti5CebMtxV6+RHHiaOZmO4BYMp5HN8cJuEdtEhSwRWO6/EfEeGi3AgC+w89tgGGtz1SsTJIT476UhP6/w2pu+h82qAt45T7rouplzGxWskEoiGVi8kc8mx7mAPcmbgVh6CuaM9OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tt33j9UN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 157A9C113CC;
	Thu,  2 May 2024 16:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714666334;
	bh=fTdWNLWguxqx1+6cG3H0uL6VLl/ZYaZcqOAQFQE5u7o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Tt33j9UNaytVc/IkZzKn3kqACrEeVzjLs30io9rzvQPbk7NHF2iUuhp1D6sK9s2dQ
	 PJHi379tXC2+rnb6XdaiCX6CaVku1VJFTP9s9zN+3GZ2QizddZ6f7qn8pycw8GqbDt
	 OZpUKxQSvVByXUr0LDCIdeenmI5s5in2dk+27+wAt4HeyDg9R6GLAat2q/zC8J5/z4
	 EpyehNuKQm0cUyWu1wcMSQkLZvkKldcTPaxN9l0CsEoO+lvw/8kQWq4FvmMRb6qp1v
	 ERSPScgOJ/dnaQ/WW3HvBxWcrf8QZS+6NmURyodPBij7r07ClhtZzo0/+7rCffBI9q
	 bzIAWThw4wiag==
From: Lee Jones <lee@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Lee Jones <lee@kernel.org>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Luca Weiss <luca.weiss@fairphone.com>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
In-Reply-To: <20240412-pmi632-ppg-v2-1-8ac892b1bb61@fairphone.com>
References: <20240412-pmi632-ppg-v2-1-8ac892b1bb61@fairphone.com>
Subject: Re: (subset) [PATCH v2] dt-bindings: mfd: qcom,spmi-pmic: Add pbs
 to SPMI device types
Message-Id: <171466633082.1186272.3467645518364735829.b4-ty@kernel.org>
Date: Thu, 02 May 2024 17:12:10 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.4

On Fri, 12 Apr 2024 16:22:53 +0200, Luca Weiss wrote:
> Add the PBS (Programmable Boot Sequencer) to the list of devices.
> 
> 

Applied, thanks!

[1/1] dt-bindings: mfd: qcom,spmi-pmic: Add pbs to SPMI device types
      commit: a1f3b5edaf18b1c71a537032c4a6537bde2ad5e9

--
Lee Jones [李琼斯]


