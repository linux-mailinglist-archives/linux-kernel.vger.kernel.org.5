Return-Path: <linux-kernel+bounces-55960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40B0684C418
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 05:52:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E60471F26D5F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 04:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0017D2E401;
	Wed,  7 Feb 2024 04:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C/yGEhIF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F02F2D052;
	Wed,  7 Feb 2024 04:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707281238; cv=none; b=oW6tzrWNKJI+Sg1WCLCQz8bMOgrYVKQHG+7xG4mJEvrkbTzc+3vy9INuvruJ3hvIz/ReO1ARK08VIsdlRPPu72gTgdnLsvmumh1fa8+SqijuYaVTmREAEpP/FnnzVtK1UoGLrckOUWkvOnf5WyaZPkcXFBZCGN60yp2VpIo8QiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707281238; c=relaxed/simple;
	bh=QeEtYoAax1/TXsms/+81G8Its5dIVGpUz73BnaWsU3I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EByuF9goN2N0bNr7ICciSZrOhzzIFMQoH9LlCA2/bJ0BNFHqTmiwZjTWzIKPQlP/I9hX3WmUqchxUOA6+HMt+c5BrzK+EajRtVnfn/mCjYFFZmg7beiXuEc7IIaHtI7l1OlAFmIpDVv73SXE+5Efza1oaC9dNc4aDRuLO9WEms0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C/yGEhIF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E1F9C433F1;
	Wed,  7 Feb 2024 04:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707281238;
	bh=QeEtYoAax1/TXsms/+81G8Its5dIVGpUz73BnaWsU3I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C/yGEhIFL550iJjZvGfM/BuMKD9LOFqz/lQmN0B0raO7j0t7j88JIPhMcJDgYzs9r
	 HbW0atgpmZBxolmcIpwS7KgrjIPOb/ksbpCO2+Fl19vQxdz/T3NlKEP3XXYywiy5Zr
	 76YsQBXNaE2JEPuI4MF5XMrPSG5xwUJ3VZ7mNyLMPt1OVEa8g82B9USndDL0xJ6cfv
	 fBg+ZAXkVpdZYRtRYAdm9wmvTG5bp5A2BHshOB4tXfmX9Wbd+uc6MnDDUD9KRUs0KF
	 2v5UOF8eM+dp7UU8iRRtzMknTDROflrh2TO0ccGjd/PWP4JIPpcFO6mo6uoOUx3VRk
	 LjOqxE/doz3mw==
From: Bjorn Andersson <andersson@kernel.org>
To: kernel@quicinc.com,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Fenglin Wu <quic_fenglinw@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	quic_collinsd@quicinc.com,
	Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 0/2] Add PM8010 regulators for sm8650 boards.
Date: Tue,  6 Feb 2024 22:46:35 -0600
Message-ID: <170728117662.479358.7960241052983200486.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240123-sm8650_pm8010_support-v2-0-52f517b20a1d@quicinc.com>
References: <20240123-sm8650_pm8010_support-v2-0-52f517b20a1d@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 23 Jan 2024 16:49:23 +0800, Fenglin Wu wrote:
> Add PM8010 RPMh regulators for sm8650-mtp and sm8650-qrd boards.
> 
> 

Applied, thanks!

[1/2] arm64: dts: qcom: sm8650-mtp: add PM8010 regulators
      commit: a2eb99176b102b8945de94dbd0d60b53a240fa6e
[2/2] arm64: dts: qcom: sm8650-qrd: add PM8010 regulators
      commit: 4a8efd8a02efd9837da06b3995141f66b2c0e8dd

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

