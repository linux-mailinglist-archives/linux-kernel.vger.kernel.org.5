Return-Path: <linux-kernel+bounces-134694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1CCE89B550
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 03:38:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DC31B20C77
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 01:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B66184F;
	Mon,  8 Apr 2024 01:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jq0K+xA5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26757F8;
	Mon,  8 Apr 2024 01:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712540277; cv=none; b=a4LKCI96SDh3Vwz5UH6M8tc1B8TxebPme3x3+d1JicdwCCjjyEyBYeWV2WkLt8NgyCYxrZENYJ7OGZuGL5E6yjwFKPGodlzYmnqpV0y07ZPpHhbidBLBLUmxB5+gUInBfHiX14ulfZS+1euf4ENnVQqLpTy6gtLeV7sgPtGDh90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712540277; c=relaxed/simple;
	bh=CTbvq0sKKQGKSHO5/dYgut1mZBzzq4WlOukJJAWZBI0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=th6ARfGU7HZtvPk7KVRF6V/5ZZssefeSgy43ddB4WjpFX9gvjlnUTiVIU3JXfKc3zoDUucY2osbynwsQ8zf1xVg/Wyy6tEhcnfUAMDN9J7S9K+8c7yeagYfu5WMlACdAUwDtmLbtJdMkSH645a/4Xw3b9BVV616PTPe1CWZg3JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jq0K+xA5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBE47C433C7;
	Mon,  8 Apr 2024 01:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712540276;
	bh=CTbvq0sKKQGKSHO5/dYgut1mZBzzq4WlOukJJAWZBI0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jq0K+xA58t78vcp7A6F1f9FTDzwB4Px/KqlnJJPyVxGIg5vLlO4z9Tgo5v4z2k7kM
	 1sUYkErRxkbJ9s3OiIwNhgIwp5oOY0yySuAXHERN+Mj2fOki7n2XnYgK17jSGXLf0a
	 AFARyxTlVpRbzrgjt9SiFPPViJajPIdm315PiM1k1HYgIzIiqPzDmJYpiJioMvyzn8
	 XdYwfxmKU6zcK8JZW0BFXggxlhkr4wccxNe9LjvUenQdEozSFvC5oup+Jx/PRRLnim
	 pBfYir+4JzVo46P+W+Zgs4BTXLU5UQcN2ohZSBImWn7K1hV73eCkr9cPhf/geczzT1
	 zzRitxu1oOxFg==
From: Bjorn Andersson <andersson@kernel.org>
To: ~postmarketos/upstreaming@lists.sr.ht,
	phone-devel@vger.kernel.org,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Luca Weiss <luca@z3ntu.xyz>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Small fixes for MSM8974 SoC dtsi
Date: Sun,  7 Apr 2024 20:37:51 -0500
Message-ID: <171254026543.648389.2103303900440485360.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240318-msm8974-misc2-v1-0-f71668a2b8cd@z3ntu.xyz>
References: <20240318-msm8974-misc2-v1-0-f71668a2b8cd@z3ntu.xyz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 18 Mar 2024 10:24:40 +0100, Luca Weiss wrote:
> One fix for dt schema validation, one for the /chosen node.
> 
> 

Applied, thanks!

[1/2] ARM: dts: qcom: msm8974: Add @0 to memory node name
      commit: cad23ffd46e2205582f5a9e9014b3d78ec0256db
[2/2] ARM: dts: qcom: msm8974: Add empty chosen node
      commit: 7018981366d496db4b7d5f6a5c2673683d2b1639

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

