Return-Path: <linux-kernel+bounces-69463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97BB88589E2
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 00:11:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 431981F252C6
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 23:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DA7C14A4C0;
	Fri, 16 Feb 2024 23:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J6u+KcAj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD8539856;
	Fri, 16 Feb 2024 23:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708125052; cv=none; b=tPf2UOV7rz/7BNyTs+S13BA7Byal2jaynsiT35xxI3GuhmBriGYlqElUaBxmDwIjc7j6Jw1pyqZOIeHg5O93dOn2T3bZaewI5jii9MfzrFdIBdHOWyNYHR97opswpTogDQ3MwfBg7J+GXirHCoVQCSiu1lUjvikTVewU/EmK22U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708125052; c=relaxed/simple;
	bh=JUGSRD3rDk0UjCIEiP93HgNR4Op20XxL9d8nDPwBv/0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bFArRGLSL8279aIBkZModZFq+/FtY6hFIKWhSMzFjCVHND3W+A+ZX97iu1ojDl0Y3E1mq0GQSsX75fSwHK4i+DmF/F8k9uebT1jWrXuQykcVw4HCTlzG9l0MliAHOEnUo5dfhYoe3SkN6zMP4dAr1iH6qW+lof9+juWXSxxIMbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J6u+KcAj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3561CC4166D;
	Fri, 16 Feb 2024 23:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708125052;
	bh=JUGSRD3rDk0UjCIEiP93HgNR4Op20XxL9d8nDPwBv/0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=J6u+KcAjGVuWFQJGSqc02GtUpAXsEvfTLznJKUVYBOXciMEiqfSuvo9CCkm/+cDRh
	 1L9n0DYkBE0OHHhVQ+PJQaxkdxGwailhYxKRqUaqQwjUIHGf/6F+qDppTrnFVwpnCQ
	 1oZtBfk1OojCyMK/mS2ZXV9+50wfP3UFjZE8JFm/K78jvE9FCMkKTI1Nv9ni3XKHdd
	 NvAX5CRBW1t5nQ26sEr6cPCxcLv25poGNQvT++Xdm616QxtHa3n8LaBgN2lQYmrI38
	 dQnjqXAVzdxV43UIC6GN318oilf4Unyvzygrw/Uj5PCIJXyEekpgEHLjfI/y8kZtYW
	 622lgCVG5vHVQ==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Bhupesh Sharma <bhupesh.sharma@linaro.org>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: (subset) [PATCH 1/2] arm64: dts: qcom: sdm845-db845c: correct PCIe wake-gpios
Date: Fri, 16 Feb 2024 17:10:37 -0600
Message-ID: <170812504024.18043.16466655341911725987.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240108131216.53867-1-krzysztof.kozlowski@linaro.org>
References: <20240108131216.53867-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 08 Jan 2024 14:12:15 +0100, Krzysztof Kozlowski wrote:
> Bindings allow a "wake", not "enable", GPIO.  Schematics also use WAKE
> name for the pin:
> 
>   sdm845-db845c.dtb: pcie@1c00000: Unevaluated properties are not allowed ('enable-gpio' was unexpected)
> 
> 

Applied, thanks!

[1/2] arm64: dts: qcom: sdm845-db845c: correct PCIe wake-gpios
      commit: 584a327c5cffc36369b2a8953d9448826240f1ac
[2/2] arm64: dts: qcom: sm8150: correct PCIe wake-gpios
      commit: 7c38989d0f7a35c83e7c4781271d42662903fa8d

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

