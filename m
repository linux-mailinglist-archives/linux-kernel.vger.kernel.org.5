Return-Path: <linux-kernel+bounces-55955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5DCA84C408
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 05:51:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 237011C20D86
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 04:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CBE625603;
	Wed,  7 Feb 2024 04:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wgw+0RPT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB4E25577;
	Wed,  7 Feb 2024 04:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707281231; cv=none; b=C3u8Dj7acMxgobV9a8oupkV9kJz1Eg4vB+bD5CIWi44KEm1tPcvnBBcSAE1rx+BEHIDRcC1Eb6AOLyjByTq9N8JyLtMc4x55wazZechF7/hcT4lhhXTJv+noWpi9EC1VudKo2bPnTfga6huDDfCVREJHWg4SRWFhi6iiHRwkj9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707281231; c=relaxed/simple;
	bh=QL01vbVRUim1nFvROEDUld4JUE7NL70cNLQBc4Z7zrg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q8UaSkgEtzD3+Jg4CEoN0ZdjlwuWALs0mWSewwME7oB89qxiykTOFs0YMAmWikFgSjQkbjDklaevUScEyORwSGYZoyOXNE7eeF+QTOYi1w/mpbd3ITT0HnKxEOwQUk4uj/7uuTnfiTNhHO1eIMqWZFKOLfwZZwAbyUIqzDozbEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wgw+0RPT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13399C433F1;
	Wed,  7 Feb 2024 04:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707281231;
	bh=QL01vbVRUim1nFvROEDUld4JUE7NL70cNLQBc4Z7zrg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Wgw+0RPTkMthIJk5pLOCzmIyQykFa650QXwQunizeMc4sRBxMO6dOordZEiYy7HKP
	 6lE1FwJFjK1LOnq71dahkzpHMl/wZumIBBIzMIuo+sF8ZGgdvPpi1bLDkopkel7OEK
	 2o4p7RrFUkEB/S7xN4Rz4kjfJKgcl5V+Qk97Ds+UtRZuKhJK6Oy/z7mpWQvE0S9+qY
	 wjR5JXrdYoWbHwEynrvrtsbcDaS6eMBJCPwsR39HTUHQLW1mwAdDcLcDR1sIjCdoXi
	 6P2mEL81xfVb3+T7Exxbl4RuzmYX7YQTwltn5iMd7EG1hizouQNmMmZKC/zLp4aCKs
	 mT26NNxlghd5g==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marijn Suijten <marijn.suijten@somainline.org>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sdm630-nile: Enable and configure PM660L WLED
Date: Tue,  6 Feb 2024 22:46:30 -0600
Message-ID: <170728117676.479358.177364280841573012.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240204-sdm630-nile-wled-v1-1-9f5c4f8147f2@somainline.org>
References: <20240204-sdm630-nile-wled-v1-1-9f5c4f8147f2@somainline.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Sun, 04 Feb 2024 18:35:22 +0100, Marijn Suijten wrote:
> The board-specific (electrical) configuration was removed from PM660L in
> 90ba636e40cb ("arm64: dts: qcom: pm660l: Remove board-specific WLED
> configuration") as it is platform-dependent.  We reintroduce it here in
> the Nile board configuration (with a slightly lower current limit, as
> per downstream DT sources) and enable it for use in the dsi0 node.
> 
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: qcom: sdm630-nile: Enable and configure PM660L WLED
      commit: 749c47ad3383f344ab080ccb1905e10b2470d70f

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

