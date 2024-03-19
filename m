Return-Path: <linux-kernel+bounces-106933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E5587F5A6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 03:50:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09FE4282649
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 02:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F1E7D41B;
	Tue, 19 Mar 2024 02:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S65rYnlI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3777D3F6;
	Tue, 19 Mar 2024 02:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710816539; cv=none; b=AHQ9Q5JOdES8EGFb74I8Yn7X9FPq0Uj5EMwszuYgGBHzH1pLR1BUwT6QO0FBJEX8M/R9Fp4OW61XFfadotxu8/caLsi79TBQejJ9Poh0a0fhlHVpyzMwqZqQUF/OxVuV2dU6Hq7nMfpNBqKArEoRE09jUpd/lEnjw/znBnh69dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710816539; c=relaxed/simple;
	bh=QbsWdkaA7doDhiXtFDLGNyqR8oJjEDcaVdFcENRuaM0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NoruoWWaBfBedeKAqDImt8kDK2k/ccpUjCD2XmY7Jmg1GSdlKft8Cx2rIvbIwCd1bBpJGwKnazmmLIoAtDELxrrcJL704PAhEUZ/oWCyc2BqOmxISu+KMab66uW7eSoF4k/KygvfIShHCxehQ62lXW93DadqqA8zU1nXyuZcWAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S65rYnlI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A625EC433A6;
	Tue, 19 Mar 2024 02:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710816539;
	bh=QbsWdkaA7doDhiXtFDLGNyqR8oJjEDcaVdFcENRuaM0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S65rYnlI9cyylCKvOgD8DUFOZmiPwJ5duWKnvGtHlMmDzOhR+xpQsCiSg/wMjCPWZ
	 Xpfcjn/kzvmbQ2wDbi9rILhENFh2e0KmBltXg0uIni+UpM6RPyCVqdKRO1pxeEH/B5
	 y7pq/pn2/HJLw93UNaslq4kl3elg8T4QmhlVDxL7dKNXWzAe6ZAR/1yyHCDkoRzKrr
	 pQXgy/nwU8Wj9FexQZOpNrIDzZsHqR01MDx6/mACtUlE1OXoet+DOh/KxGtzuUpooh
	 z9VHs+aCpQvRRycrm7IXDkohJ0eUjsuS/+gSPZfb1GG5zvZS8rOunHcf14aFe+SaLc
	 q/bTCyU4BPgpA==
From: Bjorn Andersson <andersson@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>
Subject: Re: (subset) [PATCH 0/4] Random 8280 bits
Date: Mon, 18 Mar 2024 21:48:31 -0500
Message-ID: <171081652638.198276.5909457654235942611.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240307-topic-8280_nodes-v1-0-4eba20e08902@linaro.org>
References: <20240307-topic-8280_nodes-v1-0-4eba20e08902@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 07 Mar 2024 21:25:53 +0100, Konrad Dybcio wrote:
> As the series title and patch titles say
> 
> p1 for Srini/nvmem, rest for qcom
> 
> 

Applied, thanks!

[2/4] arm64: dts: qcom: sc8280xp: Add QFPROM node
      commit: dc6cb3854c44de4c7ac9fd173208f5d19ed5d882
[3/4] arm64: dts: qcom: sc8280xp: Add PS_HOLD restart
      commit: 865ff2e6f5daf4ea822120c873f4ba43eb2d8db7
[4/4] arm64: dts: qcom: sc8280xp: Describe TCSR download mode register
      commit: 27ef06ebd289992ad4469632b440cd0b072be562

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

