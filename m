Return-Path: <linux-kernel+bounces-41875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA7983F915
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 19:14:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A050B22144
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 18:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE10F3BB3B;
	Sun, 28 Jan 2024 18:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f2eo+Ny0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321D931A9D;
	Sun, 28 Jan 2024 18:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706465642; cv=none; b=Kp12Zr90RSMJPNWLxOrOhL3NnfrydJtHCcZEL5Pu8YhoJREmMKGA9C2IeJHtbU6raTiNBH9Ri+DqEc8LcrSaIZHF0OrTR4nw9keoIAvgv2ILXCY96I86p6KKQUFM+WquE+f8vSPbR3ueI1HwRjD4QO80Js5terZ7SeiB3ILitC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706465642; c=relaxed/simple;
	bh=/dl/P1ipEarojSrDRxnOzQCeUyRhDHVokkam1jS6qCU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZG9y/6qXbxfWDY+QznwkxX6RXHwj4uuDC3qoUSO54SaP/5xqI0YJI5QL850nE2dt4ZHmkyZ1IrlIixLkhsv259q2zCeT7Wnwl1gO0iJ12RcsUKVKF74kuwqofOBxgO4M/syOfPwu09BwxCiPDXnjXr3qPpwJTv/H5G5BtZO2N7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f2eo+Ny0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60AE3C4166D;
	Sun, 28 Jan 2024 18:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706465641;
	bh=/dl/P1ipEarojSrDRxnOzQCeUyRhDHVokkam1jS6qCU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f2eo+Ny0IttL94YunBQntLZrRigoQ4VfjAUM00I+iRn5zKhrTVTF+bfZ6CBWOrRcJ
	 /Y3QNrz6ovDmohTDvDGaVDZm6d6yJIOUd31lEMgKgT5nv2XkwBLIecldCe7oWADWBo
	 rjpqwOzWgs/3nt2IAkchIFgC7HMxY+TUHcbpGnt59jr4Br9icJNRK04U6mxn3jJ1jI
	 SvJkMwmgufy0MEC5Rvj+gGZPmdFxGsZJWv6+2hTNW2OSCzP5ynW12O0KkZlrWt8nDK
	 C1rRlOXQnSiM6wGyYO2qCGH3YMNKhNA9/VOmg+BmnQcwbS/vT6OhWZilANQwBL3uTe
	 O38gok0zQuY2g==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Taniya Das <quic_tdas@quicinc.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Ajit Pandey <quic_ajipan@quicinc.com>,
	Imran Shaik <quic_imrashai@quicinc.com>,
	Jagadeesh Kona <quic_jkona@quicinc.com>
Subject: Re: [PATCH v2 0/3] clk: qcom: Add dfs support for QUPv3 RCGs on SM8150
Date: Sun, 28 Jan 2024 12:13:53 -0600
Message-ID: <170646562752.66688.15730501105778918521.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240111-sm8150-dfs-support-v2-0-6edb44c83d3b@quicinc.com>
References: <20240111-sm8150-dfs-support-v2-0-6edb44c83d3b@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 11 Jan 2024 12:02:27 +0530, Satya Priya Kakitapalli wrote:
> Add dfs support and missing resets for SM8150 global clock
> controller.
> 
> 

Applied, thanks!

[1/3] clk: qcom: gcc-sm8150: Register QUPv3 RCGs for DFS on SM8150
      commit: 2ff787e34174e72a435a79003e5358c962384c3b
[2/3] dt-bindings: clock: qcom,gcc-sm8150: Add gcc video resets for sm8150
      commit: 4b3dbd706a6181f19ba63f9265e6f996f01aa76d
[3/3] clk: qcom: gcc-sm8150: Add gcc video resets for sm8150
      commit: c8bf3e08c62533430a83d96d31d34c781483283c

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

