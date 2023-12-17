Return-Path: <linux-kernel+bounces-2797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A24816203
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 21:24:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A0981C2152F
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 20:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE830481C1;
	Sun, 17 Dec 2023 20:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NuZkwQcO"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1621C1E4BA;
	Sun, 17 Dec 2023 20:24:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CD8DC433C7;
	Sun, 17 Dec 2023 20:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702844668;
	bh=P1Kjc7K2MyJ8j3ZnIjzXX8i0JZ+vxbfZCDWN0y5rJRM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NuZkwQcOUJPiY4iN6sCn2ElJfWHdoNQxF1QE6fIjPmYu4/JqAhI4S0iAdpC/uY0F/
	 cU/rQS60qDPLG0XEv7twXFLeajrhq81YUszXIqOgJdiGO9OWoSg13KMVACRGixFFU5
	 Jy9ko5JB+lsxjqgckci/5nEOdoCyNe6PUphv48r/Czr/YfJgz+4ff9xe6t7kzRxBOE
	 hij1HHSwmG0ZLGDZ1h+kNAk8pwjSBg9xpRSgOtZfcSJPcM3lDnee0FqHvprsIhvCeR
	 JN9uo5OoDr1/RBQpzQ17YFhBHr2Hbh+54Up016ifZ9BDsnlx6e/bAyLVjJdBdC+8Ii
	 iTJh5EQC4B9tg==
From: Bjorn Andersson <andersson@kernel.org>
To: Andy Gross <agross@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	cros-qcom-dts-watchers@chromium.org,
	Luca Weiss <luca.weiss@fairphone.com>
Cc: ~postmarketos/upstreaming@lists.sr.ht,
	phone-devel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Rob Herring <robh@kernel.org>,
	=?UTF-8?q?Matti=20Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>,
	linux-arm-msm@vger.kernel.org,
	linux-remoteproc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v3 00/11] Remoteprocs (ADSP, CDSP, WPSS) for SC7280
Date: Sun, 17 Dec 2023 14:24:23 -0600
Message-ID: <170284466200.74678.13070746113150557099.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231208-sc7280-remoteprocs-v3-0-6aa394d33edf@fairphone.com>
References: <20231208-sc7280-remoteprocs-v3-0-6aa394d33edf@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 08 Dec 2023 16:07:56 +0100, Luca Weiss wrote:
> This series adds support for the ADSP, CDSP and WPSS remoteprocs found
> on SC7280. And finally enable them and WiFi on the QCM6490-based
> Fairphone 5 smartphone.
> 
> The first two patches are fixes for the MPSS to fix some dt validation
> issues. They're included in this series to avoid conflicts with the
> later patches and keep it simpler.
> 
> [...]

Applied, thanks!

[02/11] arm64: dts: qcom: sc7280: Remove unused second MPSS reg
        commit: 419618bd90f6b2c3adec87beb0d62adfcae619eb
[03/11] arm64: dts: qcom: sc7280: Rename reserved-memory nodes
        commit: 6615713c10c974d13a13297e95acd304e419dfba
[04/11] arm64: dts: qcom: sc7280*: move MPSS and WPSS memory to dtsi
        commit: 5037ca35ce42a962ea1b03895effd632a516b3b7

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

