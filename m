Return-Path: <linux-kernel+bounces-55963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D2D84C421
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 05:53:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 736631C24412
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 04:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65E013BB55;
	Wed,  7 Feb 2024 04:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pE9RTMj5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A253E341BE;
	Wed,  7 Feb 2024 04:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707281241; cv=none; b=uXWcHv2oOJSSmAAN3X07r4MCSRYWrjd+ArgBHHANqagELqj+n9XCfs88w9mr/Qwb+pZI+GlVDUIqCQvP6UMp6HlK3hmOsz9ymOM81sZbd5BymaD9AlWgkCcruAT2oibAZCjluFpPMsmBFtB+NGX76W9AtfYSWAH04VYr8m1PfLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707281241; c=relaxed/simple;
	bh=KU7wXRVFt/qU6993hWRw8w/omnWwkF8V+uS6yGfDnMA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IY7bz3CpkPjXIE9O4IFJoEp5X4xysca6I2ZhwdLXIUUlCN63CfJGQhSSCovThgbTAtpHFsXxrd0ZEGgF3ISerUVLGmpLMF6KUuAV7vZ517a2/AwJkiH7NUHD77MgjXNOlmHI8gkLQUxI/fvyzCT1i//cS6TltNj06kBYbVuzg4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pE9RTMj5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8130FC43394;
	Wed,  7 Feb 2024 04:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707281241;
	bh=KU7wXRVFt/qU6993hWRw8w/omnWwkF8V+uS6yGfDnMA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pE9RTMj54n7yRva2lnR/XyYhdokl67GxREI2ZiNUTFCuOyYHPErjLzQeOi6VgqcaQ
	 65zP8XwyUqIuWaWvI/mM4p7r2OJ/MFv0n5qDVhl8F3VEun8UQZBAyax1LR5WgNXfD1
	 qc5jC8lh0XMFTjB1ZICZ6nHZ8F4i2m4W0VFMP+AzVm02gXvj5Jf/TrW9wnV8W+UPbI
	 +K1IJNibRh6t7vFmtp+BuSRv4ZUvwGJ2wyMBO3kclUPN1hpmQSVpnpHh4m4Sl2+v65
	 YRD12RYahwmPtmuU44tzHcrWKby85OS4B/L7QkuctH2FshrMyRPYt4zcs/hIHEWnNW
	 qa7hZhgeoH3wQ==
From: Bjorn Andersson <andersson@kernel.org>
To: agross@kernel.org,
	cros-qcom-dts-watchers@chromium.org,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	luca.weiss@fairphone.com,
	Maulik Shah <quic_mkshah@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	quic_lsrao@quicinc.com
Subject: Re: [PATCH v2] arm64: dts: qcom: sc7280: Update domain-idle-states for cluster sleep
Date: Tue,  6 Feb 2024 22:46:38 -0600
Message-ID: <170728117677.479358.8880415787094538495.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240109-qcm6490_cluster_sleep-v2-1-8f94f1ad188d@quicinc.com>
References: <20240109-qcm6490_cluster_sleep-v2-1-8f94f1ad188d@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 09 Jan 2024 21:28:52 +0530, Maulik Shah wrote:
> QCM6490 uses Trustzone as firmware whereas SC7280 uses arm trusted firmware.
> The PSCI suspend param and the number of domain-idle-states supported is
> different in Trustzone for cluster sleep.
> 
> Move the arm trusted firmware supported domain-idle-states in chrome specific
> sc7280-chrome-common.dtsi and add the Trustzone supported sleep states as default
> domain-idle-states in sc7280.dtsi
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: qcom: sc7280: Update domain-idle-states for cluster sleep
      commit: db5d137e81bcce6a2506c1d056e5834a53405a5e

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

