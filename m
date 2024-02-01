Return-Path: <linux-kernel+bounces-48897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 03FE58462F2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 22:54:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 561CFB26EE1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 21:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A9423FB2A;
	Thu,  1 Feb 2024 21:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GWEis91f"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E073F8C2;
	Thu,  1 Feb 2024 21:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706824435; cv=none; b=YzK4eE6iUYj/b5iwDQZS8d23vlujrlh98I0ToxFQNmU5th5pqzcHMO7WqSET/BNMZ6fscUm44KkIhmnfMJfRvOgIJiQdzEaoQ46dXuvw/zglFbbeh2WgglO0EImnIq5t8zIIuZVzoSBQeTPPbY4qFlV9WmvE46BYwlnH0Ek8J9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706824435; c=relaxed/simple;
	bh=2vZczUJK/qBsEWDeHPvaKkgiUoBrjJWf8n5/K5trsvc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HP+/JB6evP5mpqaIeAi4nDCFYSIqfjIACQCT3DrKG1yKxoRu7niRJ6uVzi+N0veBQwNuLqQA+2bYY3Y1JPCFHxskQj9Cases6mjBoIwWNrwZlbs89zSXVHSv2T3up7RJuLyQdHh8+LA/11a+evLrowjD0le3aL68K7412GG0cCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GWEis91f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AC24C433C7;
	Thu,  1 Feb 2024 21:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706824434;
	bh=2vZczUJK/qBsEWDeHPvaKkgiUoBrjJWf8n5/K5trsvc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GWEis91fzn/FldQE1HfhUfddoEgQLvTDriDydc6vkR4Tlcg9+hPHEX/dECXEKx2wP
	 rxWEqn1itwGQZakI61p5IBIoPXAEegoHmcpsZrli83383mKY6wbn/SFyEOVlKpdKhq
	 IInLj1Le3QcsQg17WDiqgs4roH0M2TSK6nnFsFKtqIVK7vd/mN9NqYiU9oG8xSPfJJ
	 sbmVqOQ+gKEmXjsuNR02qlccWYXM/111bD7Zhz/1S4EHXuL702nYtE4P7oV9Q/r00x
	 l2uon4mizAnv/9HqYEGVqgkRvlc+iGQYo5fDWpJnJDWjiMC6uqc6aYFLBoyaIO+omO
	 ouOfrZYrzP2iQ==
From: Bjorn Andersson <andersson@kernel.org>
To: Robert Foss <rfoss@kernel.org>,
	Todor Tomov <todor.too@gmail.com>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: linux-media@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: (subset) [PATCH v4 0/4] arm64: dts: qcom: sc8280xp: Add CAMSS core dtsi support
Date: Thu,  1 Feb 2024 15:53:46 -0600
Message-ID: <170682442871.248329.6520770475610263295.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240111-linux-next-24-01-02-sc8280xp-camss-core-dtsi-v4-0-cdd5c57ff1dc@linaro.org>
References: <20240111-linux-next-24-01-02-sc8280xp-camss-core-dtsi-v4-0-cdd5c57ff1dc@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 11 Jan 2024 17:15:53 +0000, Bryan O'Donoghue wrote:
> This series adds the yaml, CAMSS and CCI dts definitions for the sc8280xp.
> 
> 4 x CCI master busses
> 4 x VFE
> 4 x VFE Lite
> 4 x CSID
> 4 x CSIPHY
> 
> [...]

Applied, thanks!

[3/4] arm64: dts: qcom: sc8280xp: camss: Add CCI definitions
      commit: 7cfa2e758bf4d56e0db5587a88db01ee6fffa259
[4/4] arm64: dts: qcom: sc8280xp: camss: Add CAMSS block definition
      commit: 5994dd60753ea2f41ae5a2ce872ae0a633eeaffd

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

