Return-Path: <linux-kernel+bounces-51211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D638487D0
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 18:07:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DA641F24E8E
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 17:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F7EF60270;
	Sat,  3 Feb 2024 17:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K2NQCcfy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873E45FF0C;
	Sat,  3 Feb 2024 17:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706979989; cv=none; b=VaF4dXsneWYQc7Lad3ucWtOUmdtlagQAqGjQcjCmVLAk332P6fpCDyDKkFv5jQU13l802RLVMZaf9VaYM0iyb05Qxh085acY9e+bdbhcxNBzCIaf7DrCiyFCgGe33vhcnahHqDrX+Hc03U97O8x1EBXGDUHRlZIfzUB7Y8SPdcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706979989; c=relaxed/simple;
	bh=jud49t3B2vhgSr3MgYVZahmzxCH/7/Nltr+alMXMO7k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QVOZOv518IFr6gd75g7h3+S6P8HK6SSaKcZ1N0xMk1CvgMjl6nDP1XtbSQz6EbuRCGlTJeRxP9TZsAQjQELEiQpzLkCD/gohNyl9LQ3W/rQX4dgALfFCHKXZgAoz/cDSkUkZABN3iH5Y+pY9Bfj08N/4kRzQAtfDASkVk7G693o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K2NQCcfy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A2DFC433A6;
	Sat,  3 Feb 2024 17:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706979989;
	bh=jud49t3B2vhgSr3MgYVZahmzxCH/7/Nltr+alMXMO7k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K2NQCcfysIwT2wpCxt4ksatHUgM7lGtVcOaUMUaXDXutr5z3Ia0K/VZr/a44F48Oy
	 ObU6Coi5hpaJlSnnDXHeNvTuNIlVsEl0RthxAmmf2gBAeU17L/Tk2gNGis0h0Cd56p
	 EW52aiKS/+MPZcVtW4TWzYcWRWeJQihqdZ80u3vDm2C+LRX0Z/ZP8Wp4CsZjlrIrB2
	 vL51KFTYWE3fG2Um3k2pWPLO5ZmjmASfBxly0oD+T86ED/i2gaf/FzFIQx61HClIqC
	 333wWyDTpnGu2I4C2Yn8ftz4jjm34WbmOSiU/8a8ODBFD4upUy4tKN86FIIfuleVsg
	 LgGm6sc2zLTlQ==
From: Bjorn Andersson <andersson@kernel.org>
To: Andy Gross <agross@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Hui Liu <quic_huliu@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v6] arm64: dts: qcom: qcm6490-idp: Add definition for three LEDs
Date: Sat,  3 Feb 2024 11:06:20 -0600
Message-ID: <170697997762.332807.8675534871152311647.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240126-lpg-v6-1-f879cecbce69@quicinc.com>
References: <20240126-lpg-v6-1-f879cecbce69@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 26 Jan 2024 10:56:52 +0800, Hui Liu wrote:
> Add definition for three LEDs to make sure they can
> be enabled base on QCOM LPG LED driver.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: qcm6490-idp: Add definition for three LEDs
      commit: 8385383cc2c2f7039ecc57864043112cdc7026c7

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

