Return-Path: <linux-kernel+bounces-41501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC56783F2E0
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 03:17:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3413D2856CF
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 02:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D8D523A;
	Sun, 28 Jan 2024 02:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P89n96jw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE01B4691;
	Sun, 28 Jan 2024 02:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706408252; cv=none; b=JtHcNOCMzqQqd5ucd0TKu58ACIMDXBMvrLMLSX2Ph9JzboeIkb3Ssh6I3mJ0V8PjLVnULjVojxcSCnFi/8GlSggvIjGgpSrTSQknhaPEkl11Dnd9PRaAwTyAhZNRgR4cwlGouwHxdJOlpCojpMFN0NOssUPfrxxj4LmSgG32hNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706408252; c=relaxed/simple;
	bh=xxVp7NYpjNlldmGgdM8f60Ze4BjBtQBCCvdUz28StqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Glw+//p0XNB5aLhLJUJqiPqiylf8p4n3hlQ80r1Mruz1N2UP093IDaB8VU/4FQpfrEGK5ViW8IJrYDxu06+ZBIuGJm4yWK04TKQv/tRYWK+85UKvNqJIcmJMAvY1/IhoFbELb5I9QN/XDEBOT1M9708Wpz0A/9W3f7xDlMWqaCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P89n96jw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DE83C43399;
	Sun, 28 Jan 2024 02:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706408251;
	bh=xxVp7NYpjNlldmGgdM8f60Ze4BjBtQBCCvdUz28StqQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P89n96jwtrnxv8qvYqdzxrWB8EsTZcLJwHKl6FPng8yAqqssqSCisj+/yw+/k0z/e
	 ciqxEUaYGhFi14Z0aGItT55JFVimuWunla8k07NsCV+k4mE/CTilzRBRKyUbYqqFdY
	 0X7s1YIhITXvHvd+7QUBsoQ8qrwyEfvCGeUV0ojKvXKxiV169oXiv6xVIVeEacoCU+
	 ILC6mw6WRkU4oqbzwPUrdQ8D19A54Wp0dnpe2c0fHxqG+SeG2pIv7jwIV4E/C/jkQS
	 uk1NDCwX3mK0Ixg3BpbOO2RD03VbNEsGb60rU0IeLzNnachhQtwUZqZvgjB4rTpOKW
	 ICm/+DFEzYv8A==
From: Bjorn Andersson <andersson@kernel.org>
To: Georgi Djakov <djakov@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Rajendra Nayak <quic_rjendra@quicinc.com>,
	Sibi Sankar <quic_sibis@quicinc.com>,
	Abel Vesa <abel.vesa@linaro.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
	linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 0/4] X Elite fixups
Date: Sat, 27 Jan 2024 20:17:18 -0600
Message-ID: <170640822838.30820.7116145957430108100.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240102-topic-x1e_fixes-v1-0-70723e08d5f6@linaro.org>
References: <20240102-topic-x1e_fixes-v1-0-70723e08d5f6@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 02 Jan 2024 19:29:46 +0100, Konrad Dybcio wrote:
> Just a couple of "usual" fixups that slipped through introduction
> reviews..
> 
> p1-2 for icc
> p3-4 for qcom
> 
> 
> [...]

Applied, thanks!

[1/4] interconnect: qcom: x1e80100: Remove bogus per-RSC BCMs and nodes
      (no commit info)
[2/4] dt-bindings: interconnect: Remove bogus interconnect nodes
      (no commit info)
[3/4] arm64: dts: qcom: x1e80100: Add missing system-wide PSCI power domain
      commit: f33767e3cfa5d40d751340dce05d316b3a151041
[4/4] arm64: dts: qcom: x1e80100: Flush RSC sleep & wake votes
      commit: 7d62dbd1b3b22ef73ed5a13f416ee21ee61c450b

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

