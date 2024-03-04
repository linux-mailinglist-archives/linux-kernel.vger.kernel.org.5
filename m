Return-Path: <linux-kernel+bounces-91292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69FFC870C5E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 22:23:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C28B1C239AC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 21:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53C28200A9;
	Mon,  4 Mar 2024 21:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gyJKO6kl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E4EEED3;
	Mon,  4 Mar 2024 21:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709587430; cv=none; b=bacTK/eJG4cTnDrkIW9M+orAtbtN6yyXvJ22SuogzEbxe8LsW0Okw0L6bAXkeqJbBCS5Gq1AOvs0MsHfE05VAm2YbWcK7gHspkESaBpcFW1Yca1q3H3KFDKJ3tK4uSDtw7rhJZm1O1Pjy41hcyx71+nydjZRCD8+qzhjHU77cgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709587430; c=relaxed/simple;
	bh=Xma0zHQ+LNitZLyloUMLCtH9PdDg7Sn3sQbNyew6nrA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=orH1yUXb/lWaJJ/z7I9ite5y2FtCAJ8MeFe4RYg6bYRCT9+Wv32vTjpcZ4KcE8i2PhGVAmwdOgsfE+hWH/lYJEfVC9nyGqjfuHkU0wNzNXoCf+Jb3CXyUs5yZ7BKDGO2xeoD0q4XMovR4XpCzoC8kn4bIrtb74wgmRiKqLWc8ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gyJKO6kl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65FD2C433C7;
	Mon,  4 Mar 2024 21:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709587430;
	bh=Xma0zHQ+LNitZLyloUMLCtH9PdDg7Sn3sQbNyew6nrA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gyJKO6klpOm+nLT2D+jzTXO2dfuSt43tKltok6RX8I/pNlFUzjZKPBof2nC74e+2k
	 5CqmUX5FKikWZ3HfZLrrmUiTOWIkxthHQ+DZI8kh5Tv6HO/VrK3oSq7vhPgRdBlz2o
	 I/xGUGXMWNC194Y20D+FYULyoCnS560xH1bBhdRPLqkBU1ZAwMqsTYh0gLcbTw93/x
	 JX7M9n9Hrz9FRbSaDHuI/ti9Y420mmg+vc6Nm/bg40PAJMwN04hZkIQEP7+01zMb9/
	 j+L83gG7YJtNnMM2U7YV/Uf5MT+eomXzvlk8X+LSm1rCnk9X8Jr2RP6flSCkuNfust
	 /M/0M9khS9sMg==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Abel Vesa <abel.vesa@linaro.org>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 0/2] arm64: dts: qcom: Fix SPMI channels size for SM8550 and SM8650
Date: Mon,  4 Mar 2024 13:28:38 -0800
Message-ID: <170958768034.1828118.8833896666591244737.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240221-dts-qcom-sm8550-fix-spmi-chnls-size-v2-0-72b5efd9dc4f@linaro.org>
References: <20240221-dts-qcom-sm8550-fix-spmi-chnls-size-v2-0-72b5efd9dc4f@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 21 Feb 2024 15:04:24 +0200, Abel Vesa wrote:
> 


Applied, thanks!

[1/2] arm64: dts: qcom: sm8550: Fix SPMI channels size
      commit: 77dd1e50ffcba33c3195ae4fc78f354368ddacb2
[2/2] arm64: dts: qcom: sm8650: Fix SPMI channels size
      commit: a4f82b8045e3c7913266aa6ea1ee15752a062abd

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

