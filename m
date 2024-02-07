Return-Path: <linux-kernel+bounces-55951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89B4C84C3F9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 05:49:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 469F2283B4A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 04:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2A6C20DD9;
	Wed,  7 Feb 2024 04:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YqPUpDoK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1313520B0C;
	Wed,  7 Feb 2024 04:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707281224; cv=none; b=tu1X3Kd/DObrC/zxY9bj1eH2fWKbbS0ywWAuTPGmLoUxlqH07HzKvlMwq+JI1wisSs2xSAkKj/EcxIlC24LF1aq3OUGOXnLP95491Go3dXrUeuo+mttG9TTa/fW5dBFm02CKINQthlMc0og6ZeFB4ktBcPp9bhETJHXQVUzM1R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707281224; c=relaxed/simple;
	bh=PM5oMQiqdkpeYqWmTrn/WQWW8ESFjrkt/V46s8JtBJg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ed+jOohifBhFFDLkLSNbSFuonb4lSKTNXqK952IbjL6xijRmEtVtWDi0GexAntiK6q+ZjM4efajvQFg1tWz82uUp/BFqqBtubOG81P6C55jKidxpNamcwatYpFmFJJkmWIT5Wtz7gfnaFb4Ou75CCOp/T/rZokZHfyU2dQ80vfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YqPUpDoK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A849FC43399;
	Wed,  7 Feb 2024 04:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707281223;
	bh=PM5oMQiqdkpeYqWmTrn/WQWW8ESFjrkt/V46s8JtBJg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YqPUpDoK3o2FXAj2rodltjtxIHtSMd3EksNVyAWprMCCu2+Q8EoxY0b/VQJvu0uNQ
	 BA+n2vH2APMsKkTDJfga4h0zvFQZ5v9eioOZN32gEGqX1J6b922w/qMstFxGTUJ18r
	 +vyc94F2FvXkHx3llvyjLgwWo7BkZp0Qyw8okZ+ZnPfII6/oLfnowOBBc/Hkkw4x4R
	 sU1L/h7WDl9nTdiX3wqxQEPT2qZ0RmbvIrfZdfnecpme6jTxh0mHca2H7d4QXvECxI
	 d8E4THOXWZr6cJs7xE1KUpEaYylMSUc/migjuFCSRdk1P0sHvLi9mUPxkbUYEeMvix
	 tBlc3hco93tDw==
From: Bjorn Andersson <andersson@kernel.org>
To: ~postmarketos/upstreaming@lists.sr.ht,
	phone-devel@vger.kernel.org,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vladimir Lypak <vladimir.lypak@gmail.com>,
	Luca Weiss <luca@z3ntu.xyz>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 0/2] Add GPU support to MSM8953 SoC
Date: Tue,  6 Feb 2024 22:46:26 -0600
Message-ID: <170728117686.479358.6339042115982358515.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240125-msm8953-gpu-v1-0-f6493a5951f3@z3ntu.xyz>
References: <20240125-msm8953-gpu-v1-0-f6493a5951f3@z3ntu.xyz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 25 Jan 2024 22:56:24 +0100, Luca Weiss wrote:
> Add the GPU IOMMU and GPU nodes to the msm8953 dtsi so GPU can work.
> 
> First of all, functionally this series looks fine, tested on
> sdm632-fairphone-fp3.
> 
> Secondly and the reason this is marked RFC for now is basically just dt
> bindings check fail, and some questions regarding IOMMU compatible.
> 
> [...]

Applied, thanks!

[1/2] arm64: dts: qcom: msm8953: Add GPU IOMMU
      commit: 1e48ad0d85f05fb4f383cba006525aa3f253472b
[2/2] arm64: dts: qcom: msm8953: Add GPU
      commit: 655815649fcd9bf80b21bcac071633ce80c358c0

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

