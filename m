Return-Path: <linux-kernel+bounces-65742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC78855105
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:59:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D2F41C29240
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 495AF12A153;
	Wed, 14 Feb 2024 17:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d5W1D8fS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C056129A8B;
	Wed, 14 Feb 2024 17:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707933469; cv=none; b=e3QecgWkPVB1r8GP1a8e9q9KVhuDLx8SZqqcZk8DosCk83aE0MmhtDySl63qK/4S7PeTS4DBWPF6TdYllsC7VelXXrbcnEPfn32o5/icWbLuuFnnzJiMmZl6k6ePcsnHE+EkdM3g17QkUajGFqNEPyHw1YSKYL9Ji65WCBHyHvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707933469; c=relaxed/simple;
	bh=FOjEdzCgA/Oe6qBuDOTJ6AhIHN0SgwjN1BIgpAvX4KM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NmcaK5oEVRByeP7LH38MVvehvE/z1og0vtRuE14epCbiEdS9ynS0bNqBkcKUddBs4yQgFnVEc36NfqvV2E8C+OYP/16TdXSszSXO8Z4nXHKEBgOzWPbG/R8/Lttph2DCKumjX0n4nDn1nKJrHYBUNZ1ysClA2UKktuBdqsJHuaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d5W1D8fS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C3A7C4166A;
	Wed, 14 Feb 2024 17:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707933469;
	bh=FOjEdzCgA/Oe6qBuDOTJ6AhIHN0SgwjN1BIgpAvX4KM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d5W1D8fSUpNx0qbURHoLd7bjmCuL2KpoBX4ftvXUoUCmCD9XtpACWOIt793Bp94bM
	 FMYE9ep5Rr2rhJ4ZfaSKapxNpb/3KhYVYnKtQBWUCjELSErbVf26dYjLES2ar0Ws/c
	 7GBmpCeUHwX5MueQKmMV5WFslswyGC2VhjSVm2xXfgUffagaDLqU/SUK/c8nm/92c7
	 7ExRNxHBx0rpj9A2TOvoq7J2gJWhPQvnL0QjwaJqry1OAxTA+X9MHJL8YUsXh++AHy
	 +BXoL9O8MoGuG0fepT3KsJydRNnk8hc3F5XLbcFVu4oFzgts9J5Rk7+gONe6IRqL6w
	 BabPHkQvYkucQ==
From: Bjorn Andersson <andersson@kernel.org>
To: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dylan Van Assche <me@dylanvanassche.be>,
	Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Connolly <caleb.connolly@linaro.org>
Subject: Re: [PATCH] arm64: dts: qcom: sdm845: Use the Low Power Island CX/MX for SLPI
Date: Wed, 14 Feb 2024 11:57:23 -0600
Message-ID: <170793345803.27225.18360969710584258678.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231220-topic-sdm845_slpi_lcxmx-v1-1-db7c72ef99ae@linaro.org>
References: <20231220-topic-sdm845_slpi_lcxmx-v1-1-db7c72ef99ae@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 20 Dec 2023 15:15:11 +0100, Konrad Dybcio wrote:
> The SLPI is powered by the Low Power Island power rails. Fix the incorrect
> assignment.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sdm845: Use the Low Power Island CX/MX for SLPI
      commit: 5dd227ccfb9568935bdaf82bc1893b36457dd4d3

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

