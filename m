Return-Path: <linux-kernel+bounces-152631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C782A8AC1C2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 00:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67DF01F2104C
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 22:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1DDD4F5ED;
	Sun, 21 Apr 2024 22:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rbxxOC5i"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB8A4E1D2;
	Sun, 21 Apr 2024 22:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713738582; cv=none; b=LsdOSXW6UYEu0LbI+pAK7aqAeqogcvqljnYrkBQidfejgFfxyg1MWgruYYCuQy/rOTh0b4exREi1PjJZpXCZHRtI6SjSHX8Up172OaL72d0XlMLioVXOv92ahPqKlZXypFCnVQGmOSTlXYE2dCys1XR7nRYCEaD3zg12j0kR0SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713738582; c=relaxed/simple;
	bh=WNXUKUp4Z1Z4w9S4FOeV3NaC9057hk6P8mTsli1uujI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mH+3vWKFDfj6m8tkrwuW+GnI8LyHSJN0j1H3hQKKXLwgxj39YXUnx2XlhJGV9vbPSnUUNp1vGGjIBnew9luq7HEHUb4jX0IVyBk6uTkIDUVwiwTaexdKu3yE/xUjdQJRyHUxD4NAloW4h8r39EWQtpVcEcuQtrsF2k2q22dS9RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rbxxOC5i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6C10C113CE;
	Sun, 21 Apr 2024 22:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713738581;
	bh=WNXUKUp4Z1Z4w9S4FOeV3NaC9057hk6P8mTsli1uujI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=rbxxOC5iUgAQ+CwL53mdr7S/OmnduCaZkpHgpxwxRAZjj1+KnWtu9G4CqkE9sGW6l
	 51hsvJ/aM+ZjVfOWMJ0kU0eUKV4Au1LoHJopuSEOD2Bhbq83ZhNOMHwgkGj1xMwAE5
	 K4WrAKxw8psxKfSTQxboU9t4lINMCAQFQoq+6w6/ASxOblRAW+oVCKmbmpAJG6+xuk
	 T27h9Sya63lZWRPe9hEpj93MY4hj4eEgACVlulWuGzyf1TBT2JRjAPa7uApDoTC4nM
	 4aylp+ZgdsiWMnZiOB229WGHetJ2Vakd4fUi9g1Uobvklb59WVcqiRI4mIoWDNLIgY
	 UMAyJWdfSYwNg==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] arm64: dts: qcom: sdx75: add unit address to soc node
Date: Sun, 21 Apr 2024 17:29:16 -0500
Message-ID: <171373856758.1196479.4309128379689903924.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240325102924.26820-1-krzysztof.kozlowski@linaro.org>
References: <20240325102924.26820-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 25 Mar 2024 11:29:24 +0100, Krzysztof Kozlowski wrote:
> Soc node has ranges, thus it must have an unit address. This fixes W=1
> dtc warning:
> 
>   sdx75.dtsi:399.11-736.4: Warning (unit_address_vs_reg): /soc: node has a reg or ranges property, but no unit name
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sdx75: add unit address to soc node
      commit: 6754fecd3bdf82cbd6eedefeb0cdb7e86aac2208

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

