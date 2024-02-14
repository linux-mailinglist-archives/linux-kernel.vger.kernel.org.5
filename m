Return-Path: <linux-kernel+bounces-65746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41360855110
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 19:00:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F32A2285E6F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4F7412BEBF;
	Wed, 14 Feb 2024 17:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Efnr/xFp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E749912BE94;
	Wed, 14 Feb 2024 17:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707933473; cv=none; b=BbvZzKqZV3q9PpRv0ywGSQ9XjoA13dKAwM38rZKd/GY0zT3lfMAA5CzzQU1ElfHekgn8NhuiwrSK5XVkv3so9ykz8H4VV3r/pQuuk4FPKSeo3h+EHVbAUaKTpJNwLZcW8O5PnzxW6Xn2a/zhocKvtfa9ZoNecSOMjyac0uwV44o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707933473; c=relaxed/simple;
	bh=znm+vwJIHyHu3Mjf8BULIVXA4cP7k8xRwROBUryZVl0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kWW3cFHZ2KkgQvxjR+npnLJk29S5OR+1UKXBGNMAakSmvmCU+9VLnaB5yt7TBlN0TFR9Xe9DzKUIRUUCUUxYE6YlwFb5JaCrxj340S5GPdUHSRYoVTDrFcK4/G0ks/jABqk7rVDjy4CcdttBdhUeNPezz3tXkQ/7aE/TIDaCDB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Efnr/xFp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25700C433C7;
	Wed, 14 Feb 2024 17:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707933472;
	bh=znm+vwJIHyHu3Mjf8BULIVXA4cP7k8xRwROBUryZVl0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Efnr/xFpaLwas3zJ92BfXErknoetOSUbgWicSXPaZnMEmyVVCC3CWTcrAPYpjSxWG
	 TL9sb/nFjmywhejKfbtwZGtsl3tWq+h7PIdk6J6Zo98lNOu1CZeOnWrUPdWYPKc7qt
	 e9++vQ5dFBnx0j+3LZcfjRXkXwH0wHYtort8xLmyChAyBVd6GNVXKTw3AfU4WVkzO1
	 5/dsSKlr3lXHrvtq/crWY72o9cQIeYZLAh7NUGbKq5tHG2N/aVo7KlERFb10maX4qq
	 CAHE6/8HLoKRbPHhCRGuAAHS7Oawge9ljRAz6e7tNSjpGnklLj8RhvOhlWW9aT+LNw
	 3F6D//Y7xrrfw==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] arm64: dts: qcom: sc8180x: describe all PCI MSI interrupts
Date: Wed, 14 Feb 2024 11:57:27 -0600
Message-ID: <170793345828.27225.3213652485553363830.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240205163123.81842-1-krzysztof.kozlowski@linaro.org>
References: <20240205163123.81842-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 05 Feb 2024 17:31:23 +0100, Krzysztof Kozlowski wrote:
> Each group of MSI interrupts is mapped to the separate host interrupt.
> Describe each of interrupts in the device tree for PCIe hosts.  This
> also corrects PCIe1 and PCIe2 first MSI interrupt.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sc8180x: describe all PCI MSI interrupts
      commit: 1587bb53c1b59deaa7fc32fd129fb9bb8fb04c3e

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

