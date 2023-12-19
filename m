Return-Path: <linux-kernel+bounces-5874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D99578190D4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 20:34:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17A841C24F57
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 19:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EBDF39AF0;
	Tue, 19 Dec 2023 19:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vLwJz8/0"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30851BDED;
	Tue, 19 Dec 2023 19:33:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3BCDC433CC;
	Tue, 19 Dec 2023 19:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703014422;
	bh=u4gRXJuDMJaRu8ic0Hfo6mXwNpFOW/YpFNOAfjZDe28=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vLwJz8/0HWxl+i6J6TdhFYrP6uQC4LvPTDtVGnh8N0AoMkF7Fl7nnelGJbGBPRRKm
	 Y2dpYQs48MP3C0PfIGlPri1vSla4iEtvdyrCvX+4x+MsWjZ4pCwT27cJFyxlP2KYaG
	 GrwHvXFNsvHjtay5J31Y9rXEOEZ1tUU1JNDXRtKULUc+W7oZvfNPn6d1aOswHUtB9x
	 ddatu0IKCbSncEfFUhdSEDYOcgmlIx02LsHhWyjTi8TE7Is/UFCsAjbEpvzHLafDK1
	 X6t6N5oFZp1BRDVfrx4JvJj9wVsAmlkElwSYLCxeVOJZ6anQWrTY8QjDHZ7n3sT7tQ
	 bIuIj3t3mQn2Q==
From: Bjorn Andersson <andersson@kernel.org>
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Andy Gross <agross@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] arm64: dts: qcom: fix USB wakeup interrupts again (pt 2)
Date: Tue, 19 Dec 2023 13:33:29 -0600
Message-ID: <170301441244.365364.4993470498119720679.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231214074319.11023-1-johan+linaro@kernel.org>
References: <20231214074319.11023-1-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 14 Dec 2023 08:43:16 +0100, Johan Hovold wrote:
> The USB DP/DM HS PHY interrupts need to be provided by the PDC interrupt
> controller in order to be able to wake the system up from low-power
> states and to be able to detect disconnect events, which requires
> triggering on falling edges.
> 
> A recent commit updated the trigger type but failed to change the
> interrupt provider as required. This leads to the current Linux driver
> failing to probe instead of printing an error during suspend and USB
> wakeup not working as intended.
> 
> [...]

Applied, thanks!

[1/3] arm64: dts: qcom: sdm670: fix USB DP/DM HS PHY interrupts
      commit: c42d12ea105f67b0f137f1e52d5c59d13fe12b1f
[2/3] arm64: dts: qcom: sdm670: fix USB SS wakeup
      commit: 047b2edc35b8db22354b4fba37818b548fc18896
[3/3] arm64: dts: qcom: sc8180x: fix USB SS wakeup
      commit: 0afa885d42d05d30161ab8eab1ebacd993edb82b

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

