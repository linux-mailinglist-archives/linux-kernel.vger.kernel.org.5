Return-Path: <linux-kernel+bounces-2708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E780A8160D2
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 18:23:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 245111C212A7
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 17:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20576495FE;
	Sun, 17 Dec 2023 17:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IwqdoBlw"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B65495CC;
	Sun, 17 Dec 2023 17:21:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06EACC433C9;
	Sun, 17 Dec 2023 17:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702833705;
	bh=JS5fsSyYxb41z9OC7PCvwR7WwAOT7QbqUpZNinJrl1E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IwqdoBlwb5u3f3Ula7+3Rtb7jIo43TRwu2aKwOb/d6VhplJNlQgMGxNQsskwwYI0u
	 /+yurCwi6O92PNHWfhGAum5AKsQRM5TrMgv/HmkXYNmPURtmFyH3UzlRcE9uEZgOpb
	 cDgCk8BJ+1fNxDrqBwDiLVHLUBn610kxSvIPonxszDZL/6uNIr7Hzvzz8ldv88pNg0
	 QU/hUDr5inyKVsApPG8rWGDyMZDWbaTT2CAxhCjrnqvFxIAzlMNKZ2w7ajW8cCklKX
	 e/B+5iJcIb8QrY8wGT9cBspoI4a3PHpBTJ99LPbOMbrg0eT6t/TaXScqTVMpEaBEjq
	 tn7jlwF+RnqKw==
From: Bjorn Andersson <andersson@kernel.org>
To: Douglas Anderson <dianders@chromium.org>
Cc: Stephen Boyd <swboyd@chromium.org>,
	Andy Gross <agross@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Hsin-Yi Wang <hsinyi@chromium.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	cros-qcom-dts-watchers@chromium.org,
	devicetree@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sc7180: Switch pompom to the generic edp-panel
Date: Sun, 17 Dec 2023 11:21:00 -0600
Message-ID: <170283349429.66089.14411062816518839925.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231213163501.1.I8c20f926d15c9ddc12e423e07df1e89db1105d93@changeid>
References: <20231213163501.1.I8c20f926d15c9ddc12e423e07df1e89db1105d93@changeid>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 13 Dec 2023 16:35:02 -0800, Douglas Anderson wrote:
> Pompom has several sources for its panel. Let's switch it to the
> generic edp-panel compatible string to account for this.
> 
> This fixes a problem where the panel wouldn't come up on some pompon
> devices after commit fb3f43d50d9b ("drm/panel-edp: Avoid adding
> multiple preferred modes"). Specifically, some models of pompom have a
> 1920x1080 panel which is _very_ different than the 1366x768 panel
> specified in the dts. Before the recent panel-edp fix on Linux things
> kinda/sorta worked because the panel-edp driver would include both the
> hardcoded and probed mode, AKA:
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: qcom: sc7180: Switch pompom to the generic edp-panel
      commit: 97d1926892955c109e412d2359dc32691eec95ce

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

