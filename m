Return-Path: <linux-kernel+bounces-2718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2EA88160F1
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 18:26:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E0A4281B7F
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 17:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F4224EB21;
	Sun, 17 Dec 2023 17:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nRsl0kLt"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB954EB53;
	Sun, 17 Dec 2023 17:21:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A6D2C433C9;
	Sun, 17 Dec 2023 17:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702833718;
	bh=dOIViLxZMDjs20JQvpRvlEhn5M+B5/Qyt56y3cRULtE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nRsl0kLtCHTllI/3n86ZN3x/Cki2M9daoJJ5shClqLmdog/2/sHKpv+GSrK6ZnnsK
	 GE0K1EypaZp+kstmA5vp1IxFHP+gnAcpfbL6JPfjPD7b1hB+hawWzV0aME2eOlFIiD
	 OlMu7gCpwFqqsmQVZjr5rmSgQN/N9amzteCEf1SHGQ3emGaS/bVAwjAmj7K3Xj++Hp
	 S/76PsAG0ZqTZEp8sj2VpwqlB8eXE0EUjPmRXKPvzf18AJji1wUZLpxnY1lYCCZ0A5
	 wx//CUdVpRAXAHAOkIp9tfI1vhJJUPun9+ajsTYZB6YT4fv15JV74LLWlCK7XPmEOF
	 e9xxTmiJLMuNw==
From: Bjorn Andersson <andersson@kernel.org>
To: Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andy Gross <agross@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: (subset) [PATCH v2 0/6] SM8450 / SM8550 Adreno
Date: Sun, 17 Dec 2023 11:21:12 -0600
Message-ID: <170283349413.66089.744756231960843910.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231127-topic-a7xx_dt-v2-0-2a437588e563@linaro.org>
References: <20231127-topic-a7xx_dt-v2-0-2a437588e563@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 04 Dec 2023 13:55:19 +0100, Konrad Dybcio wrote:
> Following the merging of related bindings, driver and mesa changes, enable
> the GPU on both of these platforms.
> 
> P1 for Will/iommu, rest for qcom
> 
> 

Applied, thanks!

[2/6] arm64: dts: qcom: sm8450: Add GPU nodes
      commit: 9810647a043678638f3b98ab48ee030bc00c8270
[3/6] arm64: dts: qcom: sm8550: Add GPU nodes
      commit: ef19923ae103b527e6762a63024dc7f0b1055546
[4/6] arm64: dts: qcom: sm8550-qrd: Enable the A740 GPU
      commit: c9f785d7d546c3f38c2e0308fa91e27ae7ec3fda
[5/6] arm64: dts: qcom: sm8550-mtp: Enable the A740 GPU
      commit: e877f075a52c485742cfd170f5557fc49972979e
[6/6] arm64: dts: qcom: sm8450-hdk: Enable the A730 GPU
      commit: 0f6f5a220543d1239dc7fc04c9f8f8885fa05637

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

