Return-Path: <linux-kernel+bounces-41852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A72883F8AB
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 18:47:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CE0AB21FCA
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 17:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 323B241C7A;
	Sun, 28 Jan 2024 17:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="slSma//7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5143C6BF;
	Sun, 28 Jan 2024 17:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706463965; cv=none; b=um7Sy8XAOD3fAcJb/SorNAzMcoLButogDOmHvMNdrWfM6JZc8fuadGzja896RnCHWBW1IyYccpTjMBJ8O0GbeAL/tof8X63mMk0Mi8TTW/gz1IZbyl6EmE9u0MHTy+Gl12osti7nb9DN63Mxi+phnpZ7r9LYuuloej45swvYdog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706463965; c=relaxed/simple;
	bh=EV19VrrZHhrxfgwarC/+WKMB5dIJvRCZIaE7fgtslTw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PZWuKsXE9w/dZs36HfCz+eX6iTScTVK8CcMpnrYn9iW4PJ90pLm49EsD/r5vbvlBZ0JLJWMRfyBsOsY7wpduaaJ0GMPWWUn3ujvXinLd1H856X8hUU1hmtLEqTqN9WlIw6uaFbqckAwDlhcS3bCr45VLphxMGc0KlqNvYLx1Q+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=slSma//7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD85EC433C7;
	Sun, 28 Jan 2024 17:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706463964;
	bh=EV19VrrZHhrxfgwarC/+WKMB5dIJvRCZIaE7fgtslTw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=slSma//7krs2pOOnkV/1oGNwehb0DTW6oBbSkg8vE4kBxT0UVEWa6W0xGy/5NmsTg
	 Re5epWvEmNSWHs49NK0Y1kXth0lJo2EFAOQ6RX4wMfpYDCGdkY2DzjXcEZWn3dCheH
	 ORB7T0+pb/i0dgM/4/zbZuLOrL1mun1GriAOSsNmtTaEbWDVuy+dd8hL/rqUMWY+gV
	 Zkn4odEAI3mAoHIurPombNfaCgUP84/qRzabGc8x9RcFv1P6pmfQ6JOAL5B19KQbUy
	 FBRMV+JsmIZsPCNtrDs28cb4KNfYZd5hDKFBvj7O/YDL2ngT+/mGkhY98NrUIBXWL/
	 kW0MBmsaVyOhg==
From: Bjorn Andersson <andersson@kernel.org>
To: cros-qcom-dts-watchers@chromium.org,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Om Prakash Singh <quic_omprsing@quicinc.com>,
	Stephan Gerhold <stephan.gerhold@kernkonzept.com>,
	Luca Weiss <luca.weiss@fairphone.com>
Cc: ~postmarketos/upstreaming@lists.sr.ht,
	phone-devel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sc7280: Add static properties to cryptobam
Date: Sun, 28 Jan 2024 11:45:47 -0600
Message-ID: <170646395041.64610.5652455532159098141.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231229-sc7280-cryptobam-fixup-v1-1-bd8f68589b80@fairphone.com>
References: <20231229-sc7280-cryptobam-fixup-v1-1-bd8f68589b80@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 29 Dec 2023 09:51:37 +0100, Luca Weiss wrote:
> When the properties num-channels & qcom,num-ees are not specified, the
> driver tries to read the values from registers, but this read fails and
> resets the device if the interconnect from the qcom,qce node is not
> already active when that happens.
> 
> Add the static properties to not touch any registers during probe, the
> rest of the time when the BAM is used by QCE then the interconnect will
> be active already.
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: qcom: sc7280: Add static properties to cryptobam
      commit: 521cb01e12750fe290a3819cfe9334c8ac0d1fb0

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

