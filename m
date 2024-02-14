Return-Path: <linux-kernel+bounces-65747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DAE61855183
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 19:07:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5F4BB298A6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA8F312BF2C;
	Wed, 14 Feb 2024 17:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gQLF7V0a"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D9412BF0A;
	Wed, 14 Feb 2024 17:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707933474; cv=none; b=E5JprxeDShEffm3r1ga+jZOLJnwPWsJNNl4CAUz5wrUozE5hlKYIGsb2sptF5b56eiOZ1ztMZSbsLfUaQ258fAyoTWOiw6Rs/XZcg8cGegR37H5Wr8s1nZwpamNJKyDXEc+A8yr1rjd62VCNMAQOQMTy4pIDdA8ah3XAEx5Ji0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707933474; c=relaxed/simple;
	bh=XnRJCSjnaVYVO7L7l+BXVnUtJbhkfmU4j3iIrBGra3E=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nGwR61FqReYHtVNiSSBx4MSchSUGmH0zlXr7LuBHxOgXhbboZwzhfmJuwSIqfg+U2UB7ZZKMok2UtogY6HvTcVqyCFDZ0Z9ExKmHtCrOJxbUUamLGeHJCB4k0Q5aoMxCQjfFMZzj6E7h7tTMnfwEBkfSVuFwaBBhyHZe8KNt5AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gQLF7V0a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2C6EC433F1;
	Wed, 14 Feb 2024 17:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707933473;
	bh=XnRJCSjnaVYVO7L7l+BXVnUtJbhkfmU4j3iIrBGra3E=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=gQLF7V0aDearWVQ+3aeDPLFATdC5FxJRaTeWMEDuAKOy97su1lyjGRkFpNn/eDEsy
	 3TW961Bf6XB9SwerP2uiX8LFzCyRxwc8rhBC5KnWjhrzuj98G1BCJ2PwU2y5rg7J2t
	 XPPKlpJV2BkrEZhk69xVSv/Ax7nTHzy+rL56Vqz1wheGyy36u0fz5ZbJzlLTxBVZim
	 AeQLIDPMIF4nc/NQQZOEV9vNzo08t9pYdFd5csoa7kzrZ9CTBbC5TsEEnPx2D7vTmK
	 2iX6gIMiga9OlW4wKalh4xJTSkEawVR5Vuf1Lev4dOS9Rt+yELDTuJEP7Vfnvpw9Xv
	 to3HFbi/f46Mw==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] arm64: dts: qcom: ssm7125-xiaomi: drop incorrect UFS phy max current
Date: Wed, 14 Feb 2024 11:57:28 -0600
Message-ID: <170793345825.27225.8107201907952050614.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240212150558.81896-1-krzysztof.kozlowski@linaro.org>
References: <20240212150558.81896-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 12 Feb 2024 16:05:58 +0100, Krzysztof Kozlowski wrote:
> Neither bindings nor UFS phy driver use properties like
> 'vdda-phy-max-microamp' and 'vdda-pll-max-microamp':
> 
>   sm7125-xiaomi-curtana.dtb: phy@1d87000: 'vdda-phy-max-microamp', 'vdda-pll-max-microamp' do not match any of the regexes: 'pinctrl-[0-9]+'
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: ssm7125-xiaomi: drop incorrect UFS phy max current
      commit: 1fe82781dfd5d00bd997e9eebfb363caed1360ee

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

