Return-Path: <linux-kernel+bounces-106945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDABB87F5D1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 03:53:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D84B1F22127
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 02:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F66F80618;
	Tue, 19 Mar 2024 02:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B0ICEEM3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2D28005B;
	Tue, 19 Mar 2024 02:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710816554; cv=none; b=YlJwuL2XzAHhtvVFZLe70aQyAvqe/tkzisPQER/7UBH2j1RbaM2jAn7lX9U8wLcsFu7Z/XLgiIB+iMmq6kScGb2J9W4lnwUcdPs+ds/7FdhWtRTsLE0u+eORGLUegWrPvTFNJPEVZCwXy70ASFkGt6OMuSHkU0ml/PH1bwKcS9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710816554; c=relaxed/simple;
	bh=2tFuWnCqJ1f9F16g0fJd1rgcXieGZrc4i3FbwJsi6LA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WiaCQTfVpjj9kmNQ65N7Gu1nXvMiNhCmBjjVb4Cbb+DrxO7PIRVzBw/Ly5W8lm4kezb0TlBMLr3OEAblAPakRIZFlHpZhr7BgQo/bEWzpd2uwBj6q4O+MiUzHO2Hgh7z/9eiQVUB5+7E3190oJPl+QofSqkjYauYbdmImpuMGbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B0ICEEM3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1ED5C433C7;
	Tue, 19 Mar 2024 02:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710816554;
	bh=2tFuWnCqJ1f9F16g0fJd1rgcXieGZrc4i3FbwJsi6LA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B0ICEEM3rAYmrXTV8kDrLfX+ra2TRo2zGqwPUXB324rdEnMbFnpHYMOPoRev2B1x+
	 +wdmLTJ9iQV5FD0c8Ccf3Ij6Lf6VVR8Psn75ao8feAtw3ZR3/tjA06VWxrj67x0WDy
	 /ZniF9a0RSFQM2QCRCz4CksbSCj04gTu+RFhBnzMCdqVWvcwjGNNkJ/OB3Pku7pxYA
	 7dtAtpNwofNf7Y+TJxq4U89OMnkeg+Y3Oh7GOhqWR1O5+yZd9A/oxj5jJfZyyZeqoj
	 1ESBUpOuuPbs+F/7ZgSM8NUfshg3dWk0KPFJkupDsg7BHulhRBcKZu5pJDK4tLeiPP
	 RiMmFL+1VY8HQ==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Elliot Berman <quic_eberman@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Patrick Daly <quic_pdaly@quicinc.com>
Subject: Re: [PATCH] arm64: dts: qcom: sm8650: Add missing reserved memory for chipinfo
Date: Mon, 18 Mar 2024 21:48:44 -0500
Message-ID: <171081652657.198276.11190224591325228423.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240304-sm8650-missing-chipinfo-region-v1-1-8a0b41dd8308@quicinc.com>
References: <20240304-sm8650-missing-chipinfo-region-v1-1-8a0b41dd8308@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 04 Mar 2024 14:41:15 -0800, Elliot Berman wrote:
> Add missing reserved memory for chipinfo region.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sm8650: Add missing reserved memory for chipinfo
      commit: 9b1e891179cacd12aa77d27a2c00b75fdbef4823

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

