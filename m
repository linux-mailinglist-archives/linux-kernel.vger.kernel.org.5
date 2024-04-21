Return-Path: <linux-kernel+bounces-152635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF7108AC1D0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 00:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E18C41C20935
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 22:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 666D44644C;
	Sun, 21 Apr 2024 22:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fu393zYN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A198D51036;
	Sun, 21 Apr 2024 22:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713738587; cv=none; b=SSlCl6FW2Yu7sH1uOSvb4vDTXqbV5Qmr81oQ/b5BCURyGnbB1V0I0MlYE6/OL7R3GBOGF7Nd14liLELKx9P4XpGEpbL3cOWKNFs7GYIJ71eTE47MrnXk7fGDsMcN2osFflJ6J3WfF+347CAMzUJvwoz/ZB2WhIcuX5EOyl7avSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713738587; c=relaxed/simple;
	bh=omGgj0SqxyU550lB3Bak55zJmedSwzsqqZXAHkDE5Xk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s/c542zdCM/UlBmHDYJFgrGWGtjWd+t0uukatDXTP+DtXMl4fis2xwEJtrOdW2co/zCNGzN44VJhb2/B7SkczEAThBwYp2bfJ3XR5vjozS7NqzJT/LcOmd70y2XOWWBYeXB8ZO2GFuqTeE4utuUECcP5gEELfDo6JEPsi3Z6efE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fu393zYN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3A6DC113CE;
	Sun, 21 Apr 2024 22:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713738587;
	bh=omGgj0SqxyU550lB3Bak55zJmedSwzsqqZXAHkDE5Xk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Fu393zYNv/Tyv+ki/D7wPR5s2SuKt/jcvjdEIrCX/rNOGyMeyUUXO/QBpLdWRuCqd
	 kR0yAJTmvA133PscuabQeh1SRUvSQrMrNkoqsG5zzdHyt7JivRS/8fjrX+4TaX+Smq
	 a5EDnvUB+AhlQfnPHfDIbXLWiCkhMnD5ZfnX1J5OAd6jirGlXOtjmoo//AGNkNAJKz
	 hZP0wrL4BsqWyGS4KNZQoNgiQMj42mm53GuAIgoP2sMUSOFfBLSbUHN2+glb6+Zs6C
	 nqgygRyfFuNdzO6JKbSGhkVzxXa9irsK1OfUR4m/fW0emCFxjE4IsLxsO4slDffCiJ
	 xVtiJHYUz0obA==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sm8650: remove useless enablement of mdss_mdp
Date: Sun, 21 Apr 2024 17:29:21 -0500
Message-ID: <171373856759.1196479.540569291544584327.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240325-topic-sm8x50-upstream-leave-mdss-enabled-by-default-v1-1-f1b380132075@linaro.org>
References: <20240325-topic-sm8x50-upstream-leave-mdss-enabled-by-default-v1-1-f1b380132075@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 25 Mar 2024 09:34:33 +0100, Neil Armstrong wrote:
> The MDP/DPU device is not disabled by default, so there is not point in
> enabling it in the board DTS file.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sm8650: remove useless enablement of mdss_mdp
      commit: 6aeeb9456943ce166211231f72e8723731ad116b

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

