Return-Path: <linux-kernel+bounces-106944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD3687F5CE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 03:53:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74F141F217C8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 02:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6189680050;
	Tue, 19 Mar 2024 02:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YQNkPu1q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18677C081;
	Tue, 19 Mar 2024 02:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710816553; cv=none; b=mQIbE4LmyCAt/9dvyCEjuxxbcWxWUc20qXwjuHXodI6H/ekL7lBxPQ8+z0NfMFlYs8DBbRFSmeHkHsU8/8ku7wv+PfxyEaNLPp0/y1AzcsXCZ26qu7mS6itnKzF5m2SKCcImM4JlAz4baP/4IeyrWY2Aa0N+ID6+FjBSGqkb29k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710816553; c=relaxed/simple;
	bh=bSoSY6e13V4D8ibnGrrdnIenwv/P+RnDcwR+fU6ad3A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cq1ae43pC8OMn7aeDymXs+r1mWphPt08pG4V0aR6FaZvCOhYsCE4mdzYhstH/P54V8xA04xnh041s3Ms/pbIQ+110D6dKC5TqfRWHjajBrAy/yBnsQAiHqk6lcC6pjXwtJDVKkpWzkVsvLCjLBjDYl02yXPUQ/l6shnZfGRHCsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YQNkPu1q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC376C433F1;
	Tue, 19 Mar 2024 02:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710816553;
	bh=bSoSY6e13V4D8ibnGrrdnIenwv/P+RnDcwR+fU6ad3A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YQNkPu1qNaD/xg3ytqnFZEt7p8Ohw/vlkwO6aqE3qrD9UXo5GbJwat6BE/Pm6c3h7
	 btMXjX1XgpBHR3qigdcnqIQMl9xx9APMU8srPrtCntN9so82Ig1CXlFsARwzhwSoyR
	 G9H1IMuTJLtR4K7EnamawktQ2OjnZAmjCNXuSD1lcw6JXo/gTaVBYILcaNg0Iz6oCf
	 h/y4MMEr+wm8yTWQmUS94QeEcRydBLCwTiZtDAwDOwuMvs1JZ0Vn8IWZ9z0GUaG10v
	 ZWgJH97XvRz/YYeEnD1qdh/UgMvtaAy9p04TeLp0O9J5h9rds62CYfJcpPemK9iNqp
	 h47qtLOE1ndow==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <quic_bjorande@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: qcs6490-rb3gen2: Name the regulators
Date: Mon, 18 Mar 2024 21:48:43 -0500
Message-ID: <171081652642.198276.13237735078804683087.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240227-rb3gen2-regulator-names-v1-1-63ceb845dcc8@quicinc.com>
References: <20240227-rb3gen2-regulator-names-v1-1-63ceb845dcc8@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 27 Feb 2024 09:39:54 -0800, Bjorn Andersson wrote:
> Without explicitly specifying names for the regualtors they are named
> based on the DeviceTree node name. This results in multiple regulators
> with the same name, making debug prints and regulator_summary inpossible
> to reason about.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: qcs6490-rb3gen2: Name the regulators
      commit: 6e995a1b53444d09f7707f4f79b752213343b05c

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

