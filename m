Return-Path: <linux-kernel+bounces-2714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D6CD8160E6
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 18:25:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9FC11F2299B
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 17:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04FE04CB52;
	Sun, 17 Dec 2023 17:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YusXwokC"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4541A4CB32;
	Sun, 17 Dec 2023 17:21:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBCE7C433C8;
	Sun, 17 Dec 2023 17:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702833713;
	bh=8N3P5nYe7wXCoqXxo98OZAZtfqGTeIMLsSiomVlGjP4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YusXwokCqi/jVflsk+obcw8ntr0+E/IL24iW+t2XMlaPQeivpW2snFpflUCGjJFf6
	 pWUvWjPSQdxjwSTPeuEoy3tXsGEmKT8YV2fFd2oxw4jb+QoXbN2GFCxo1oTvuT5h8L
	 ja9ZT3x7DkhQ8k8N0UEM1JT37V30qbzYMPrD1kMkbIl6KfnM0PS7qxpfLg4zPDaQrO
	 ghGJ//TNJ2TORJlYbBUcOLVvGW+434n91lhLgq44gEl49e1KxJ7VQgZ2teEVEsX4Nu
	 k6D+DTaMTlAqkQuWV1T97eaQuMgSzqbBBDpLZ9Tb70lKhypi0A6QcR0SV2ZFU/rZEW
	 JZikVQpqI9MdA==
From: Bjorn Andersson <andersson@kernel.org>
To: Andy Gross <agross@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Georgi Djakov <djakov@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
	linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH 0/2] Enable interconnect on SM6115
Date: Sun, 17 Dec 2023 11:21:08 -0600
Message-ID: <170283349423.66089.10057591496955925021.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231209-topic-6115iccdt-v1-0-f62da62b7276@linaro.org>
References: <20231209-topic-6115iccdt-v1-0-f62da62b7276@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 11 Dec 2023 10:23:57 +0100, Konrad Dybcio wrote:
> The SM6115 interconnect driver has been merged now. Add nodes required
> to make use of it.
> 
> Patch 1 for icc, patch 2 for qcom.
> 
> Likely depends on patch 3/ (qcm2290 BWMON compatible) from [1].
> 
> [...]

Applied, thanks!

[2/2] arm64: dts: qcom: sm6115: Hook up interconnects
      commit: b3eaa47395b9d0fc593e7f8b8b0abb4c769ad30d

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

