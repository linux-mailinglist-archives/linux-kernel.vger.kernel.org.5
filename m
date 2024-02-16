Return-Path: <linux-kernel+bounces-69470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B728589F8
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 00:13:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 208C7285761
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 23:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A589E14F9C5;
	Fri, 16 Feb 2024 23:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B8cJoB0H"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C783F14E2EC;
	Fri, 16 Feb 2024 23:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708125062; cv=none; b=lKmPKUTSyhpxoGe+b344z4qrFMyZCbOcUtpfXrK4rzTGmLT7Tcw+W/4mgSdf6jt59Xl8CF3TUtMcx54C2duDxsOK3N9pC/rkW2B9qUqn9WePeFO5EsX+ASCC0MFYfn0HMtTz0plvGgfgolLn9WhuBlFYhrtXtFWLh1RZA+GqUZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708125062; c=relaxed/simple;
	bh=00j7RNSPlLKTfTzPlBlWb/YdlK8h3oh/hFAGEIK+RK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DEG026kSi8LBRQsrnA8o9iTybby2v2vN+LQkiX8svQg10Te5/ttvb/pm3t3Ne6M1Eqyr/9eY7cAP9JoTKyCPpS/AOjY9uS62rYFJZ5E+wppkXH7jWGxg0V7RzyvTWPlIOUrSOHm4LqxBN2ZI+ib5NGbIm1LQxcnwrjisEqTRmEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B8cJoB0H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E4CFC433B2;
	Fri, 16 Feb 2024 23:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708125062;
	bh=00j7RNSPlLKTfTzPlBlWb/YdlK8h3oh/hFAGEIK+RK4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B8cJoB0HyaDSHHJ/hWyFsxEO9ppbClqUCh8csEiASV/oox0gE6WdkH6TZj14KqHhu
	 Tq45GPiuvC9urSOeFepMfpDRV2qrSueI7HAMdlznNrdSso0f5Ys7+jEJdINIAHdU4i
	 UcZKKfOs3k+8aYUcRahA+Z4U8qf4W1+2uwS9dovSMIPM5TF2HTQ4AED5yLWUJ/csa2
	 hHMusMHMfHCPTbcwDjPXkdm2BiDc7DmP4Eedp2nYobbBmtzE8HqJzcwv2hzb4WZRAr
	 DsveSdUjJbLNtjq+jA7YCkmZpRSSulJkRhroBI1lKdoT07xM5Q6rfqG68xDTlE4TnH
	 Qg6IKEV/qB5AA==
From: Bjorn Andersson <andersson@kernel.org>
To: linux-kernel@vger.kernel.org,
	Raymond Hackley <raymondhackley@protonmail.com>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Stephan Gerhold <stephan@gerhold.net>,
	Nikita Travkin <nikita@trvn.ru>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	~postmarketos/upstreaming@lists.sr.ht,
	Joe Mason <buddyjojo06@outlook.com>
Subject: Re: [PATCH] arm64: dts: qcom: msm8916-samsung-fortuna/rossa: Add fuel gauge
Date: Fri, 16 Feb 2024 17:10:44 -0600
Message-ID: <170812504017.18043.18002824915451634876.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240216124639.24689-1-raymondhackley@protonmail.com>
References: <20240216124639.24689-1-raymondhackley@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 16 Feb 2024 12:46:50 +0000, Raymond Hackley wrote:
> Like the Samsung Galaxy A3/A5, the Grand Prime/Core Prime uses a
> Richtek RT5033 PMIC as battery fuel gauge, charger, flash LED and for some
> regulators.
> For now, only add the fuel gauge/battery device to the device tree, so we
> can check the remaining battery percentage.
> 
> The other RT5033 drivers need some more work first before they can be used
> properly.
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: qcom: msm8916-samsung-fortuna/rossa: Add fuel gauge
      commit: b61fbc595e2f44311b4e01c24ac425b79d29d2af

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

