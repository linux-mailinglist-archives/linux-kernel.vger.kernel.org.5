Return-Path: <linux-kernel+bounces-69465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E428589E8
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 00:12:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F84528C812
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 23:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F7F314AD26;
	Fri, 16 Feb 2024 23:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FjHHbriM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA1614A0BF;
	Fri, 16 Feb 2024 23:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708125055; cv=none; b=OUf7JxYLGvosYybT3V3apytUC8zMA6O5gzCEeAgwKSjMA2brBBLKEPA0d/T/LSdRAhy94JpCu6bjL2NpBBME6X4NyDq7GhiicEMN+oY54HgVoxkUWdHevMzDhOrGNyAhSazw/Pv3ocMHsC3ww96YR1IqoObxHL2Wg2rZ7Z7/w2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708125055; c=relaxed/simple;
	bh=3S6Gor2cI1J3OQWlYvurX5Wd/zKPK8Z1Tom1uT2JEdY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AnKYlcT2ojMCfcUlE5rgShIJSmZu5mzwfodxUSXkdWKafekqRp79jb5v1G92ZS74bWMPkcnxVyTGKIlWiJ42lUH3OyHQOKV3rTe1Fwlg41n36xYivBuIfWo+w4wtUyrvfeVrja4xxrXm6CuwIotC8zHgLSpfJwFzJ7lp7E/btfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FjHHbriM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17249C43330;
	Fri, 16 Feb 2024 23:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708125055;
	bh=3S6Gor2cI1J3OQWlYvurX5Wd/zKPK8Z1Tom1uT2JEdY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FjHHbriMOy+A42hkGyarJpL4TZxBlFigXhjEZJuXQ+bG+1rJq6rb1pBqreo/2OonN
	 ijezijmxIfb4aBbiT4SOa/Qlwc1jmBusoUhkJYVNhYjX/AkghgXsxPZn1t8kRsv3re
	 82WosQUxes1qTtnnQ0adY0apOwF9QWbktv8DxT4jpQ/r8ZabEhlNvRXlCA+RI9yWZ7
	 0XfmrSOBQ+x2jH3UOP8PajKmhqwke2ylvWVJYCI7a1RqJ3UZNNDdGCVgVr4u7kuL9p
	 QEppAMm40xkxSmvszlC8800wOZEX8MIHkgQ+GEz7KeL/InqUFyzlDPXZZjBm5H/sMJ
	 k+7NylCqRR6rw==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Luca Weiss <luca.weiss@fairphone.com>
Cc: ~postmarketos/upstreaming@lists.sr.ht,
	phone-devel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sm6350: Add interconnect for MDSS
Date: Fri, 16 Feb 2024 17:10:39 -0600
Message-ID: <170812504016.18043.4978031153669987798.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240216-sm6350-interconnect-v1-1-9d55667c06ca@fairphone.com>
References: <20240216-sm6350-interconnect-v1-1-9d55667c06ca@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 16 Feb 2024 14:11:20 +0100, Luca Weiss wrote:
> Add the definition for the interconnect used in the display subsystem.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sm6350: Add interconnect for MDSS
      commit: fc48bb313513d140026e4d0c441f290ab9c08577

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

