Return-Path: <linux-kernel+bounces-132149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D0D2899048
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 23:27:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DED121F21E83
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 21:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D357513D505;
	Thu,  4 Apr 2024 21:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RWrALn8C"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2277F13D2B1;
	Thu,  4 Apr 2024 21:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712265820; cv=none; b=fpoqDho2660+T2akgJVFoOA3vVlxM7MQ8uYpVPVaWnxgNzlhYr9ytTtP0sC5zF7E2UNlNFek+SrtdWZRY0YUYhc8xU++5AkZXUdoXFEjpld1WbqoRqigkPtpZDHJoUWpIsb6shteuucQyOl+mPzxk5kBL6JVnrvpY4hJB3CBstI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712265820; c=relaxed/simple;
	bh=Oidh6B9bbP2Pc5RZRraXn5UQ9FQ/xwkOwxjLS2hH8Yc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R08SuX1Of8bQ0oS7T7NYYI0E6atJ4K/8RF7Z7/Qwnj8EvUeYoYWsChKFqnhbgjUte6uN7SEs0kmIpMiSQImLgmYXZwrb7rEes3x2kTjQ6DcjaX2/BdQi/XuvAFc/9gHzoFR7Mnonmzif1JPCEQgDuGeTrUSYMgnCSUxVggkF4dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RWrALn8C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5836FC433C7;
	Thu,  4 Apr 2024 21:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712265819;
	bh=Oidh6B9bbP2Pc5RZRraXn5UQ9FQ/xwkOwxjLS2hH8Yc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RWrALn8CedLpjk176Jk/8n7eIfwQ40nJzRLMLHKwXhR4fJu6eMOEPlf7ltUrdSGvv
	 wUsnyUHWFk2XHaKuWQOMMYZEQHSbaXgmKbysr5Vyrzah2wzpJioCh/3QFzhjkqJgWn
	 u8IYhsB+8/f5M9U/k/oIWxEPUsRvVV4XbMUQcpFU2610MdThFIIyiRQ1INqQin5KXN
	 eOLC1zWwnB8kAtHGRHsPuKIKAnNiHL55Jf+trUmAGQY5HPOhKx/5w8cNuoMiKy0Kx+
	 YgaFDByQFUHi97vh7OLpI82RDVYBHC6iNdkbXHOUmKpR8AtUR8k4LcY9NrkFjTAy5o
	 iqjk80qsw3wsQ==
From: Bjorn Andersson <andersson@kernel.org>
To: cros-qcom-dts-watchers@chromium.org,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Bjorn Andersson <quic_bjorande@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Douglas Anderson <dianders@chromium.org>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
Subject: Re: (subset) [PATCH v2 0/6] arm64: dts: qcom: qcs6490-rb3gen2: Enable two displays
Date: Thu,  4 Apr 2024 16:23:05 -0500
Message-ID: <171226578688.615813.575478189424711884.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240326-rb3gen2-dp-connector-v2-0-a9f1bc32ecaf@quicinc.com>
References: <20240326-rb3gen2-dp-connector-v2-0-a9f1bc32ecaf@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 26 Mar 2024 19:04:17 -0700, Bjorn Andersson wrote:
> RB3Gen2 is capable of producing DisplayPort output on a dedicated
> mini-DP connector and USB Type-C.
> 
> Utilize Abel's work for DP vs eDP selection to allow configuring both
> controllers in DP-mode, then enable the two output paths.
> 
> Tested by driving fbcon to 4k@60 + 4k@30 concurrently.
> 
> [...]

Applied, thanks!

[6/6] arm64: defconfig: Enable sc7280 display and gpu clock controllers
      commit: a97b6c42a7b823c429fac562a02d291b47b98d7e

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

