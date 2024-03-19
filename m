Return-Path: <linux-kernel+bounces-106938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B662A87F5B7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 03:51:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF0971C218F9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 02:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 305C97EF13;
	Tue, 19 Mar 2024 02:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z/ttxKfZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F007EEEC;
	Tue, 19 Mar 2024 02:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710816545; cv=none; b=ZWTE1SpvyVKIcUjnb3GK++7r/ijTx7jW9Bg6SiHBrVk+FwPVaUeLVzA8BLazAleh6cWY/jMERMwZ/nh01NAcirjeOsl5AzITz/kbG3LLvCGvsw2PnVPROag6vXRovVPkMv154Ve41hwT0GI8zE0y0FakVnhjz2BAaz3bfadsN9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710816545; c=relaxed/simple;
	bh=B2kyutrzbbnP5KHbTkS1VDLfUIMOWksSjQj/V1flxe4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wnfdno2Vsi9/lNTK+LOB5OEWbkNN9Vyekuir1ZVN2u2yK36zKJG/6yzeV82KOZ5+wopWhw5328QcdTimOPSZwTbn+ahVCPGZ7N2M+5f9FY1zN6RjxJfrRzAT3C3syA3eQ5jLdC3eOjPcuwhJb8hyizO75Ilx6MWLXCdIHTeD7Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z/ttxKfZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78C5AC433F1;
	Tue, 19 Mar 2024 02:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710816545;
	bh=B2kyutrzbbnP5KHbTkS1VDLfUIMOWksSjQj/V1flxe4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z/ttxKfZjS3D/OtiLfd0e0Ipthqlo9joCGm4Gto4RXuFtj7EB14vctzRq/qQQK5Tv
	 f94K2Nt8hZhOGO706tfShKp4MlGNBPd0hM7TZDZZHbf84BXRmo4CFR6NHah0I6CB7N
	 bd3chf9MBjRpNN6Y8QGaxvSXL3nDU6R6UZWqK89LpxmWp32ku9fFqVUcRRIVYgMmJx
	 zqfVGEaW5CurfAAxdRlZruLx4jwbQ7wQpuv8ZVolOszN/fS50xVEVNVbno44v0sR6d
	 UDCD4B8tHn/Lp3L5sqUenOlq0khFCOwSutWktcjDNom9MFRaST94TCpBTPn1n7ZVFj
	 K7skDu21Kf9+w==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Luca Weiss <luca.weiss@fairphone.com>
Cc: ~postmarketos/upstreaming@lists.sr.ht,
	phone-devel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sdm632-fairphone-fp3: enable USB-C port handling
Date: Mon, 18 Mar 2024 21:48:36 -0500
Message-ID: <171081652652.198276.11479550211099892596.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240220-fp3-typec-v1-1-1930cad81139@fairphone.com>
References: <20240220-fp3-typec-v1-1-1930cad81139@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 20 Feb 2024 13:01:22 +0100, Luca Weiss wrote:
> Add the definition for the USB-C connector found on this phone and hook
> up the relevant bits. This enables USB role switching.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sdm632-fairphone-fp3: enable USB-C port handling
      commit: 90053b1574f8cff3a3b53accc496246ad2e0aec3

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

