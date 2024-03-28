Return-Path: <linux-kernel+bounces-123462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68EC88908F9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 20:19:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 079C71F24C39
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 19:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EA44137C36;
	Thu, 28 Mar 2024 19:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jftcwO4r"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68CC4136E13;
	Thu, 28 Mar 2024 19:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711653535; cv=none; b=rlYhcpQeBOAdZSPUGJZgkaji4DhQCQXUx+rgwBNpnWGTI7x8VnqDwKXHXpiBT4C9T31Iey0D6mWuHoTh1mAi6SSlbl4v+8L7KVzcTcfOee/Euq8WPXopFIQBCKyVaAVrtn1ZiLegu5XyAV07zTLqnePG7Rov7TLg7XCe3259P+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711653535; c=relaxed/simple;
	bh=/2FwrcuxW2z/ha9sIbh7100tVXqzXgvk1gda2cIs5nE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=C6AmgatxdrLWufvbxdP9DKiYRBBm4zlu1vsmiU5NirrmYXubb7JNEwilC1ZrPWyDlAOu9jNmb+IZMIQsxXnKpja/jTrQlmNV9jE3rkTFEFHYRCZ8oDKSjk8Sn2O51zL3Izj3in2uH4CjHzzeHI4eW0qlfUdDISSa6RdIuwq3eOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jftcwO4r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 031CBC433C7;
	Thu, 28 Mar 2024 19:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711653535;
	bh=/2FwrcuxW2z/ha9sIbh7100tVXqzXgvk1gda2cIs5nE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=jftcwO4rh+t+5iSEKiw4//3BPGSDqE225ZiJLIkwXVLno6+pnx8oayEnKYBp2VDKu
	 W73Dws42e20irofCdvDtVM5PuDXBLb8j39L9gl3s5jXWXRuv2kJdCSp+gbQfT+79BM
	 zNxc6bnX7oV3oEW6ab2IXbNc41KAWVdaZ2N9rNoWvfcLX0UC8CU3PDo1M0g5ihzq1b
	 IyfKD06Wrz94YX+ODmpHaXVHObLIpByI2Umk/9D34gegd1FR8yzSb+fiYyexKu8CBK
	 8thgdmZNGyyldMX8uUJfw6Zt4iMv+H4drImBnvw6eCZAHUwiZQlq1ThUyuVYwM4aKK
	 n1J8ESUJsgGeg==
From: Vinod Koul <vkoul@kernel.org>
To: Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Johan Hovold <johan@kernel.org>, Abel Vesa <abel.vesa@linaro.org>
Cc: linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20240324-x1e80100-phy-edp-compatible-refactor-v5-0-a0db5f3150bc@linaro.org>
References: <20240324-x1e80100-phy-edp-compatible-refactor-v5-0-a0db5f3150bc@linaro.org>
Subject: Re: [PATCH RESEND v5 0/2] phy: qcom: edp: Allow eDP/DP configuring
 via set_mode op
Message-Id: <171165353052.152303.10328548451703763437.b4-ty@kernel.org>
Date: Fri, 29 Mar 2024 00:48:50 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Sun, 24 Mar 2024 20:50:16 +0200, Abel Vesa wrote:
> Until now, all platform that supported both eDP and DP had different
> compatibles for each mode. Using different compatibles for basically
> the same IP block but for a different configuration is bad way all
> around. There is a new compute platform from Qualcomm that supports
> both eDP and DP with the same PHY. So instead of following the old
> method, we should allow the submode to be configured via set_mode from
> the controller driver.
> 
> [...]

Applied, thanks!

[1/2] phy: Add Embedded DisplayPort and DisplayPort submodes
      commit: 368d67dab4cc4a3ffd39fbd062b2f5796cdbb37b
[2/2] phy: qcom: edp: Add set_mode op for configuring eDP/DP submode
      commit: 6078b8ce070cad3f9a8ecfce65d0f6d595494f02

Best regards,
-- 
~Vinod



