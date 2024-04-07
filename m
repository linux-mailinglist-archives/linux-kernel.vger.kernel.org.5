Return-Path: <linux-kernel+bounces-134217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 955E089AF1B
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 09:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6AEE1C21C1F
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 07:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F390D12B7D;
	Sun,  7 Apr 2024 07:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m1IQ398S"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435F311C92;
	Sun,  7 Apr 2024 07:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712474488; cv=none; b=WueGSM6kGvT5lO6XYHh8G/30pKMfqHOcVC+S8M1VuEOuPY3bWMqy6wnzYzoQRO5Jf4jftEkPaARrKsJsILftYrAtAYrVJYu61qjGypfO34pSuJ0CEiAI2VoS5K0Kea2CjvDB0dT26bb4qLY1YbXE42dkXRdFgRVgLmfT7cNY49I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712474488; c=relaxed/simple;
	bh=N68XWJ5tqs+R4Sb4kX5+JuesEzf3EgGkVGBZSU+ql8I=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=juRoYPw1Y3KTViynqbQtlO5NlpE3uhDLuxQZFzYQlTWnvV3UlpIBHo+Pq6wgP/Kb+q+WECzM7GASpmBENW5r6HZcNm/wvChNC8q3BBwqqJsDsLfTAo2IVwVMQ/MzXrcRJl3Dtwbbxo3rDF5LMtWFVCqJ76zZjTmM7R5LY0BQ75A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m1IQ398S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23DABC43399;
	Sun,  7 Apr 2024 07:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712474487;
	bh=N68XWJ5tqs+R4Sb4kX5+JuesEzf3EgGkVGBZSU+ql8I=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=m1IQ398SDjpO7GlcginkHlwEEKzAU6UkjNe+d9WDjSpIgyfZJU3NSyrSjOOLtHnOR
	 Ou2BKKHyMTcfcLwJeJyulf+IvIlBAAx3qllJ09FGyEUL96vuW9u/s8q8dY8Ba3HMaY
	 22YGstPkEBoLIUeahMv+/eCwT1qsNjXoiTxl2aJmc3ndb/yRP8wXpDD4plEIv+V2Bk
	 fH6blNNZgeyzLiVbziNsoMvqi/RFo3u/yUxOH4N3HS6PlHCP9gaQITUfffCuz6AKlQ
	 3/A4NJ3DsfZIOG8KdaUfyVFYwRZO+peaMWlHKYnBFyKQAWKWvjBRpA95UIiDcHE4XD
	 ZYNjQbq/8s8Ug==
From: Vinod Koul <vkoul@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Sricharan Ramabadhran <quic_srichara@quicinc.com>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Gabor Juhos <j4g8y7@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240406-phy-qcom-m31-regulator-fix-v2-1-c8e9795bc071@gmail.com>
References: <20240406-phy-qcom-m31-regulator-fix-v2-1-c8e9795bc071@gmail.com>
Subject: Re: [PATCH v2] phy: qcom: m31: match requested regulator name with
 dt schema
Message-Id: <171247448471.375090.8975261455779796119.b4-ty@kernel.org>
Date: Sun, 07 Apr 2024 12:51:24 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Sat, 06 Apr 2024 15:37:09 +0200, Gabor Juhos wrote:
> According to the 'qcom,ipq5332-usb-hsphy.yaml' schema, the 5V
> supply regulator must be defined via the 'vdd-supply' property.
> The driver however requests for the 'vdda-phy' regulator which
> results in the following message when the driver is probed on
> a IPQ5018 based board with a device tree matching to the schema:
> 
>   qcom-m31usb-phy 5b000.phy: supply vdda-phy not found, using dummy regulator
>   qcom-m31usb-phy 5b000.phy: Registered M31 USB phy
> 
> [...]

Applied, thanks!

[1/1] phy: qcom: m31: match requested regulator name with dt schema
      commit: 47b3e2f3914ae5e8d9025d65ae5cffcbb54bc9c3

Best regards,
-- 
~Vinod



