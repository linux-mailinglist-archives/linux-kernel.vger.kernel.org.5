Return-Path: <linux-kernel+bounces-2805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8250A816235
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 21:53:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2493B21211
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 20:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4A02482C3;
	Sun, 17 Dec 2023 20:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e7DURiy/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330D248CC0;
	Sun, 17 Dec 2023 20:52:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9852BC433C8;
	Sun, 17 Dec 2023 20:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702846378;
	bh=XnN89dq9R6U1naT/n9Kt7ry8jTpdJCDrRjlHDdMfS1E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e7DURiy/WzO4Lp96oorYcHdgguR9INkr6h8DV6F41J0R52aB6uC6rVZUqpHZdoiQC
	 3AfFPm3nKyMmTj7Qmy1h55yAkWtVo8y2ZC1Z0lhsj1UJqgLD/SRqW8RzFhv10NuCc0
	 0bj9BXPm48nBotKz4w9+GonpmRl4IulIdHFMhZfWWygdTU4YJ4TrhlMK3Agn/fjism
	 TOXHhnoT4qvfdfqiMGMozKKa3vj4O+bwtWTtjnojiTBDbR8U9uisWjel39T4gwAFII
	 MqX4YcrG9w97YE9/guaiwmHujlQOJBn/vhg9kpWr6wbHN6IkqePm2uOaL8UQepQi/J
	 HyupLcU99f/fg==
From: Bjorn Andersson <andersson@kernel.org>
To: Andy Gross <agross@kernel.org>,
	Georgi Djakov <djakov@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Maximilian Luz <luzmaximilian@gmail.com>,
	Gustave Monce <gustave.monce@outlook.com>
Subject: Re: (subset) [PATCH 0/6] SC8180X fixes
Date: Sun, 17 Dec 2023 14:52:55 -0600
Message-ID: <170284637112.76512.17093508259000450416.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231214-topic-sc8180_fixes-v1-0-421904863006@linaro.org>
References: <20231214-topic-sc8180_fixes-v1-0-421904863006@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 14 Dec 2023 19:13:37 +0100, Konrad Dybcio wrote:
> 8180 has quite a big of bugs, this series fixes some of them.
> clk_ignore_unused & d_ignore_unused are no longer necessary (at least
> as far as I could test, through remote console access..)
> 
> p1 for Georgi, rest for qcom
> 
> The keen-eyed among you (hi Krzysztof) will notice that there are no
> bindings updates, mostly because half of 8180x is undocumented.. I
> intend to help fix that up in a separate series, hopefully soon :)
> 
> [...]

Applied, thanks!

[2/6] arm64: dts: qcom: sc8180x: Add UFS GDSC
      commit: 2564209891a436f71c6c8a245d3b56cf4382d65d
[3/6] arm64: dts: qcom: sc8180x: Add missing MDP clocks
      commit: 4978dfde89b1f454c88bc5519dc996cc5b58d72e
[4/6] arm64: dts: qcom: sc8180x: Add interconnects to UFS
      commit: 384ea2aa2066d27c20257550ba91418401b91199
[5/6] arm64: dts: qcom: sc8180x: Describe the GIC redistributor
      commit: c879ee11791adf7e29d2fb615bf176504ed51465
[6/6] arm64: dts: qcom: sc8180x-primus: Allow UFS regulators load/mode setting
      commit: b7b9a6aa7aea2bcba2d35d65e4ce2913115485a3

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

