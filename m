Return-Path: <linux-kernel+bounces-49014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EE8B8464C6
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 01:03:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91CA41C23C08
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 00:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF7A415AB;
	Fri,  2 Feb 2024 00:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ELiKg/sM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0216105;
	Fri,  2 Feb 2024 00:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706832218; cv=none; b=C/JIsv6LUT05kIW8shxJHaAmM6rXrCXeFV41GBnQJDAaqXgu7RfWys/pnia1XpCsA7j5u+GyjrJUz4FDZ0zTSs9X01FBd8KzeNl4ZzS6II3W/WG7f88q1qja919iNfw+Jr5Lin26Uj1BAet5+j4408JHcCONs+8VIxXQsNY9PnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706832218; c=relaxed/simple;
	bh=jRRF9WD0Ih34oFyn8QC1/CQx0uQoczFXftdu1/ViRb4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pRhuhU1ccUQjrMOHBkANABsfcBsiTmJy0sadE5rD7bp7x4TmJXfr87WJMggu1hjaCxAOI/K4d+Ae3ZoVOU3+vaZzqsujCtV3nlHgyOjmqXfQqPF4+CWKPWSgas7ErfbI2qZmcNvR35KTnV3U5gTu4ykty4CtF1FcTBcoUxxTY74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ELiKg/sM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62FDEC433F1;
	Fri,  2 Feb 2024 00:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706832217;
	bh=jRRF9WD0Ih34oFyn8QC1/CQx0uQoczFXftdu1/ViRb4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ELiKg/sM9oMYqNibGG/5LYhmgT0jM5x2oYprQxJqLmZyTZ2nRwppEdaTmQfAN69F0
	 FgMCPdgBl39xnkRFNfkD64XX7idIYesPJH9e0LCtaYn0l7kT03k02+Gvip2XS/ZUc5
	 vUohXNz4xvFOSgO2k2Mg4i6M4jctvhxOwyeyyuKfNbpCBtxMPpMfGsXJztnC4dgyCM
	 PL2bGc116RDtZuavthS2bkDIucZg3tpOSBmkVqCoFYfCu4xbo2EIVfIvMPFxJuwE9Y
	 VeVDtCneZvqEHmvu9QGRV+aYZPgoA4POxen9VfDyV2AjLlp1kHEvHSfHJIjLOKvkix
	 kvy5Qtuf65rSQ==
From: Bjorn Andersson <andersson@kernel.org>
To: lee@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	agross@kernel.org,
	Anjelique Melendez <quic_amelende@quicinc.com>
Cc: konrad.dybcio@linaro.org,
	linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-pwm@vger.kernel.org
Subject: Re: [PATCH 0/2] Add QCOM PBS driver
Date: Thu,  1 Feb 2024 18:03:34 -0600
Message-ID: <170683221107.260225.17408986886128551623.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240201204421.16992-2-quic_amelende@quicinc.com>
References: <20240201204421.16992-2-quic_amelende@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 01 Feb 2024 12:44:20 -0800, Anjelique Melendez wrote:
> Add the Qualcomm PBS (Programmable Boot Sequencer) driver. The QCOM PBS
> driver supports configuring software PBS trigger events through PBS RAM
> on Qualcomm Technologies, Inc (QTI) PMICs.
> 
> QCOM PBS driver is needed to support LUT PPG. This is a new series to
> separate PBS patches from the applied LUT PPG patch. Original comments
> can be found here:
> https://lore.kernel.org/all/20231221185838.28440-1-quic_amelende@quicinc.com/T/#m7ab7af4c59c6e1019721d01cb3696cb5ed708bda
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: soc: qcom: Add qcom,pbs bindings
      commit: 641fde51bdb26c09ea8cdbd82084e93bd88d1fcb
[2/2] soc: qcom: add QCOM PBS driver
      commit: 5b2dd77be1d85ac3a8be3749f5605bf0830e2998

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

