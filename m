Return-Path: <linux-kernel+bounces-132146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E82899040
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 23:27:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DE551F25C4F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 21:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 751F413D263;
	Thu,  4 Apr 2024 21:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jNOWyWsT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D1613CC70;
	Thu,  4 Apr 2024 21:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712265816; cv=none; b=d4m1j/dwjVaxQyFdSCyDA1bloDl+xO95iBHJl2kk0j7o14+zU8PhLzfgDdPsmGah3KSizTM2Y99Mdy0TbDBgdnYCpQq7p35WpbQy1KcVJOXuosBXZ2aBNULS/r7KhFuYf6fMJIPuVFIdAjSiiHQUUUL/kFE/ObKx13bj1UH3tg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712265816; c=relaxed/simple;
	bh=EuY2fEtAmYS/idsBKcX6yrcz4W0A/OS/j6I6pmK7E3I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DX+wbnNkyEUYMl9O92ygV39tqzctwW46cQRkdo8KcQ6YjldumrUAliuCypKoky9EVu9KP7Q3k8M2ceYlL80rlQrIt26AY/gHxlnsDFv1NyAi5lHjupwFTDs2aYyiRCAR9yKj2T8UlkZTVV+hgHeZpIGYmvC8NhtjNG278R+uf28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jNOWyWsT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FF5FC433C7;
	Thu,  4 Apr 2024 21:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712265816;
	bh=EuY2fEtAmYS/idsBKcX6yrcz4W0A/OS/j6I6pmK7E3I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jNOWyWsTErDCGoA52QhRO6DAs7O2TbLsNIvaExVHnu1bwVvc9xCgDi7MiLaLyPBeJ
	 KEOUwGXiGHFISkDhQXRiaPA4DlZcK7ijruGeNLQwbc3BKTo7GaMaWJEoUysPJF7A7J
	 kTYq+MXt92q1Ne7DjDQtVQUuBrZEbtW8r+4ftEn3lppQ+c2cH93xO6//A1M8NXXrmd
	 hZuXMZwQprNSrrk0NPZzqocZhFcIGBIJ+d+a886IeNBJ7pg+QDhd8TWUMoQYkqsAtv
	 IayiGuv5W2OR1pLo57tVHqAaiSO5E8D1Qi46cRLTW/bDuih+6wvOZI3om1NVDJzo7C
	 jx3yOkSKi1rFg==
From: Bjorn Andersson <andersson@kernel.org>
To: ~postmarketos/upstreaming@lists.sr.ht,
	phone-devel@vger.kernel.org,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Luca Weiss <luca@z3ntu.xyz>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: (subset) [PATCH v2 0/3] Split sony-castor into shinano-common and add Sony Xperia Z3
Date: Thu,  4 Apr 2024 16:23:02 -0500
Message-ID: <171226578683.615813.15928381591573268207.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240314-shinano-common-v2-0-a0fce1c72c74@z3ntu.xyz>
References: <20240314-shinano-common-v2-0-a0fce1c72c74@z3ntu.xyz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 14 Mar 2024 19:56:21 +0100, Luca Weiss wrote:
> Prepare for adding sony-leo dts by splitting common parts into a
> separate dtsi file.
> 
> Then add the dts for Sony Xperia Z3.
> 
> Depends on:
> https://lore.kernel.org/linux-arm-msm/20240306-castor-changes-v1-0-2286eaf85fff@z3ntu.xyz/T/
> 
> [...]

Applied, thanks!

[1/3] ARM: dts: qcom: msm8974-sony-castor: Split into shinano-common
      commit: 53426f53eda5e4a17197a8bc7dd1045601db407e
[3/3] ARM: dts: qcom: Add Sony Xperia Z3 smartphone
      commit: 8d91a5a4a6f5aff714a14ac4a86931aa789655d8

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

