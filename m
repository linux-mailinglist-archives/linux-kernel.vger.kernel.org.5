Return-Path: <linux-kernel+bounces-51219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B7688487F7
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 18:40:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DADC11F23B39
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 17:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E143E5FB99;
	Sat,  3 Feb 2024 17:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rDk5oVcn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8A55F878;
	Sat,  3 Feb 2024 17:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706981994; cv=none; b=hekcgOcs7yOeNYRoT7ZjQWKP0Qjps60r9+mVYt0juWpq1xPA+sVbuTD1D8WDqjJV5IW1pEGVM+vhTLQoc0fIHRo1N99XnFR/rZUHmKvsOJUgeHWRDpzMjG7pTTGw3hX+EoxbooRqLaSkrXwL0xIHCX+LNvU92+Beo4q0/V9ooWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706981994; c=relaxed/simple;
	bh=C4rwQCuwZ0ALtP3yZ1AjuRQrYTKk5b7CcDiYhO4C6sg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jbmvd/h+TFVWa5rPNRy8jesRpwiInbAnffBW/EaAb9IgOsBeNlbe6x+kfroWpRRD4n0Igho2+JF99G4aSSzyVoMzCm/GHLm25qxklCkEBbMfSF398x0wWr66oDK1VSSGPxAg+F3l8CxCftzoOzdmDhCpWKB0C3rwc4XHP3xdhvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rDk5oVcn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC724C433F1;
	Sat,  3 Feb 2024 17:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706981993;
	bh=C4rwQCuwZ0ALtP3yZ1AjuRQrYTKk5b7CcDiYhO4C6sg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rDk5oVcn0pQj4eVOoGfK9SI4LLWU0XCgubxbpi5Q0n4SUmlWAu48Rs87YxBlwEjbX
	 2iNOOcOZLXjNPuucs/+8GN4qme6TKZDSFwEQYlsvPCfSx85ySk+gGNJBwJ/qiIX3hT
	 GmEMKz2Myw6misn2aIQqqifmL3ejxULnHeIM9pY4yzjL59b2YGqZutoqdUQhbCgcBU
	 KkG/7QZeKOI/VtxmKjw1WbX/G55BXSHQkrsIFcUSww8vQr5Joj+DK1ENWEjtOb1bA6
	 i+tv7OwlvqBO1ZqAIWXJz+Lo2Pwu69GHJBUJlxY/dLYZILZ/oCXONeNWbQhafpaNAg
	 RuMrlulfPUYTQ==
From: Bjorn Andersson <andersson@kernel.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sm6115: Fix missing interconnect-names
Date: Sat,  3 Feb 2024 11:39:50 -0600
Message-ID: <170698198801.334878.15067799196537155521.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240202-topic-6115_i2c-v1-1-ecfe06f5f2ef@linaro.org>
References: <20240202-topic-6115_i2c-v1-1-ecfe06f5f2ef@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 02 Feb 2024 00:29:58 +0100, Konrad Dybcio wrote:
> Commit b3eaa47395b9 ("arm64: dts: qcom: sm6115: Hook up interconnects")
> did indeed hook up interconnects, but apparently not interconnect-names
> on I2C1, making it return -EINVAL due to an error getting icc paths..
> 
> Fix it!
> 
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: qcom: sm6115: Fix missing interconnect-names
      commit: cb0bbdc4cc327ee91ba21ff744adbe07885db2b8

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

