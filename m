Return-Path: <linux-kernel+bounces-2729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 879F0816113
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 18:29:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43C192823F4
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 17:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCD5C57891;
	Sun, 17 Dec 2023 17:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b/XdfQqF"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B45546B98;
	Sun, 17 Dec 2023 17:22:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9E05C433C8;
	Sun, 17 Dec 2023 17:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702833731;
	bh=gIqbfRhldmUwBVCw2B3DS7Z5oisI0VnRWz6i47Wpq98=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b/XdfQqFDtClcBlQfkCtgLzRzCvyHexvnVnI+zjbfFk6D4NzaCU0hKzM2on+s4Vu4
	 tS1iCS3fcUIA5tPIr8a20/jMJpgFi9flmpdPBjul/64hAvllt2QtNIMGjLyWjq8dLf
	 yftyJmeLM4eB+OQcELVGljXgQUViz4wZcUzsCr4rQHCx7BEnNbi/sJqHdu/EU+GKmy
	 pQK5V4I4wAIvmY2MpVkaf6+ff/uNn5EiUe/lE1KP+NpCyClc24BpWiwmcVW4ZP0FsS
	 HhrNB0cFfgq7NU/TjeXCf33ZyXjOGI+WhYNVjj20by1Rfwb8c8wc74FMCWtK1MJfSv
	 N3MV32H4f1vzA==
From: Bjorn Andersson <andersson@kernel.org>
To: Andy Gross <agross@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mao Jinlong <quic_jinlmao@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tingwei Zhang <quic_tingweiz@quicinc.com>,
	Yuanfang Zhang <quic_yuanfang@quicinc.com>,
	Tao Zhang <quic_taozha@quicinc.com>
Subject: Re: (subset) [PATCH v4 0/4] arm64: dts: qcom: Fix the warnings from coresight bindings
Date: Sun, 17 Dec 2023 11:21:23 -0600
Message-ID: <170283349421.66089.8882831110072317371.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231210072633.4243-1-quic_jinlmao@quicinc.com>
References: <20231210072633.4243-1-quic_jinlmao@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Sat, 09 Dec 2023 23:26:27 -0800, Mao Jinlong wrote:
> Fix all warnings in Qualcomm boards coming from Coresight bindings.
> 
> There are warnings below after running dtbs_check. The patches are
> to fix them for Qcom boards.
> 
> funnel@3023000: 'in-ports' is a required property
> 
> [...]

Applied, thanks!

[2/4] arm64: dts: qcom: msm8996: Fix 'in-ports' is a required property
      commit: 9a6fc510a6a3ec150cb7450aec1e5f257e6fc77b
[3/4] arm64: dts: qcom: msm8998: Fix 'out-ports' is a required property
      commit: ae5ee3562a2519214b12228545e88a203dd68bbd
[4/4] arm64: dts: qcom: Fix coresight warnings in in-ports and out-ports
      commit: bdb6339fd46b8702ea7411b0b414587b86a40562

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

