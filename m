Return-Path: <linux-kernel+bounces-41427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D7383F0CB
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 23:35:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEDE2281266
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 22:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7470A22F17;
	Sat, 27 Jan 2024 22:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ftL6qVLK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE00021A12;
	Sat, 27 Jan 2024 22:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706394872; cv=none; b=uf8bg/uV/0SAYoN5C6iiosQFIu9rakWBa2sjM39w3wsJYKsK6XU+tQ/vl1+hEgsNyuWtmcnFUHQXp6kc+YR/CsojWcO4gRtgU605MDJhUU0uHQh3q7onYvDpIn/xMCV4hfm2bL2iYESa/rGEAaS+e776oejXfIaGoabnsDPOK38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706394872; c=relaxed/simple;
	bh=0hd1nt6NIxg/b2E4PHB4vjQG+308/SLzKzQkU9id3mI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t4KSZE+vmJgI7z55kbevKQycGAPb/wQ6Y5/9DcCt/6KDXBYmUNNuYK3cQg6PwlTixJh2NbjpGzbnuxJqeHWSLXfR4j19cEkrRrOvgFHNMdK40H/CnoLGfBlgNrdxKyuPkp2wAEzujEH6kyP4qsdJuVFrWTqpRGi1g/eSSgdFwOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ftL6qVLK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96920C43601;
	Sat, 27 Jan 2024 22:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706394872;
	bh=0hd1nt6NIxg/b2E4PHB4vjQG+308/SLzKzQkU9id3mI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ftL6qVLKuRLxvoU8sibnI+EnFXNzV6GPmKtMqEz9b7jMJbGZkUFrKpnAMEsUCDYWQ
	 njksCy+pS4aI97oh/FQLcBa8q5FiigrI/uDdQNk0awxzMwhOh+ID/Di75nx8EalGRP
	 eSS0syulIbRf3nchVNriyDpIuZYioB5RajMJxtlpc1XgcE8sp6S2q6qCguB78DsVz1
	 bCFnlK9kbs2HYZ1p6ECiEmHdEgJb01aVY5DZQ+mPY6NOfVlLK/J56J2tjDDeMunSCD
	 njwgBUlnKOukCdibc7v56V03KU4vtrBIKUk/Uu9t+zHvd4WHBgulvHSSMyp665hWr4
	 sAbEsbZHtScHg==
From: Bjorn Andersson <andersson@kernel.org>
To: cros-qcom-dts-watchers@chromium.org,
	Andy Gross <agross@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Prasad Malisetty <pmaliset@codeaurora.org>,
	Stephen Boyd <swboyd@chromium.org>,
	Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	quic_vbadigan@quicinc.com,
	quic_ramkri@quicinc.com,
	quic_nitegupt@quicinc.com,
	quic_skananth@quicinc.com,
	quic_parass@quicinc.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sc7280: Add additional MSI interrupts
Date: Sat, 27 Jan 2024 16:34:23 -0600
Message-ID: <170639483105.20773.383926255672968908.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231218-additional_msi-v1-1-de6917392684@quicinc.com>
References: <20231218-additional_msi-v1-1-de6917392684@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 18 Dec 2023 19:32:36 +0530, Krishna chaitanya chundru wrote:
> Current MSI's mapping doesn't have all the vectors. This platform
> supports 8 vectors each vector supports 32 MSI's, so total MSI's
> supported is 256.
> 
> Add all the MSI groups supported for this PCIe instance in this platform.
> 
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: qcom: sc7280: Add additional MSI interrupts
      commit: b8ba66b40da3230a8675cb5dd5c2dea5bce24d62

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

