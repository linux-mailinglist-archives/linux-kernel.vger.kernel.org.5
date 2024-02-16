Return-Path: <linux-kernel+bounces-69469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 581B08589F5
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 00:13:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A7B91C209EB
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 23:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AE8C14D442;
	Fri, 16 Feb 2024 23:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="erQl8OMN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B506C14D45C;
	Fri, 16 Feb 2024 23:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708125061; cv=none; b=RrgiuuyYZopPzwR4/u/Uv+1TOIk5Htzr+6ycL9N5OXWdETkSEQLWOM52QGuRkD1PpYm22CNIA0duwyMaK5yjD5SuERBZ13uTTet5dO66MiWqZExfoIQXyKZo/e3hKfSbNI8fhn0HWZAJvup1a2NbG9A4WzPd5XimqLnWp+FMwZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708125061; c=relaxed/simple;
	bh=gIziBhnCOH0gdSKSRoAMngeJ8bMoLOQRuYui7VfnOFM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BofdtHqpclGa68ps1dOzrcWm5ow2zhr4dGciKPV7gwZgACWryAfPrK8T/UKXuQsFndkydVmJ97IdW3EVzjaqPRVz2Q+vX/OIj5Cb4SSosOYedhedCST5ywsRvl1ws62YjoJw9n7oUkvMYnH+D8MrBfFJMadHQvB2ric6WFJxMfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=erQl8OMN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 078E5C433A6;
	Fri, 16 Feb 2024 23:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708125061;
	bh=gIziBhnCOH0gdSKSRoAMngeJ8bMoLOQRuYui7VfnOFM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=erQl8OMNpJq47YNwlWZ8turThyw/ZoiO91+tF5vxg4jLGSCUp+9QbMoQWhTTZhGqo
	 Dvouh5K+rCi1nyihcGSx5NbZpdC8UbOB1D6kJHpaXbSpzER/B8LWaUX3IbDGihac6G
	 zyOx6M44PVJgbPVjNt7Rh5e+iMfqYvhD5E2jSOnZTkRDOCGqtWk8iImS3hL3TfcVsV
	 gYojNUsh/F25vc6e8ngUDF0kRkytULPvNXFbTZ2urt2YeyQj5r93bE+cm+zzyNZWoM
	 RF3ydWw8xe9AuO9OFdk0EaOOL+86i41k3o0l53YwKfcgzjJAFjq2kY0QUeccTXgPJQ
	 U7CLQq8OUJOdw==
From: Bjorn Andersson <andersson@kernel.org>
To: cros-qcom-dts-watchers@chromium.org,
	agross@kernel.org,
	konrad.dybcio@linaro.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	Ankit Sharma <quic_anshar@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	quic_ashayj@quicinc.com,
	quic_atulpant@quicinc.com,
	quic_rgottimu@quicinc.com,
	quic_shashim@quicinc.com,
	quic_pkondeti@quicinc.com
Subject: Re: [PATCH v2] arm64: dts: qcom: sc7280: Add capacity and DPC properties
Date: Fri, 16 Feb 2024 17:10:43 -0600
Message-ID: <170812504028.18043.10515070084679933469.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231103105440.23904-1-quic_anshar@quicinc.com>
References: <20231103105440.23904-1-quic_anshar@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 03 Nov 2023 16:24:40 +0530, Ankit Sharma wrote:
> The "capacity-dmips-mhz" and "dynamic-power-coefficient" are
> used to build Energy Model which in turn is used by EAS to take
> placement decisions. So add it to SC7280 soc.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sc7280: Add capacity and DPC properties
      commit: 942bf463dec369172af81ad660d81d11bda88e39

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

