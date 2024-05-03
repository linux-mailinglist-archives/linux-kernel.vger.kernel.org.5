Return-Path: <linux-kernel+bounces-168193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F3958BB4EF
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 22:35:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F2BCB2549E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 20:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37C1538DD8;
	Fri,  3 May 2024 20:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aRizKplO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F9F18EB0;
	Fri,  3 May 2024 20:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714768460; cv=none; b=rwS+Jedr14iljmT3JlaWa7p34uEJhsjpXsd4C3br4A9RSpecfPkvVv2D8K3beJLJdwVXE6vMcff//KYRGVSw6MiXrZdwUyJGsaD/jz0X8ePi3jzcJe3sI8faSeyfZGqy0uuZ9OgENiOVHU5dr9Bv6QdJcOjc3q/0xYETLoEUnMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714768460; c=relaxed/simple;
	bh=V31YieNAvnRHfjtM5CmyE7r8oMvtOlEeaaFGE9mSUWY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D6p3pG9LOYe7wv/E/nbMOwKvYJG+n/mEB5LA9smNUNO9Ccl7W11+HMI/YOFiwPyttuRSQE31/EKdJHBLacpMkImor/6jl/SBbCy4meU2cEi3AyNtyzMTKeqqBw3ALSh3TgNT9ASbtBv2hQEMUwNn5q/v+jNuF7mMHMPd8UDrDzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aRizKplO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AC49C116B1;
	Fri,  3 May 2024 20:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714768460;
	bh=V31YieNAvnRHfjtM5CmyE7r8oMvtOlEeaaFGE9mSUWY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=aRizKplOyfwG7IOiLK3zL4HESG08u2B2wWQPYSsvNkBioujB9UVzUc+yVF8XveUrE
	 TIfYAI291oLUnIQ9fNVqPqF2MYdD84gYFQ23jolWtduzJyKzWNwA6KbgdOMiF34HL/
	 Y+I8sLQHlnN9nb24aHKWCvO8qC6o4Qih2eizdSQ4Ib196XrmCcyTFnaB19HW0ZO4/Q
	 4T8ieE2PP0WqOfYfvvvPUppe+f8pFr0dQIDzBXkj7PNiRY9ax3Nifwhh47N7cm8ar9
	 nlTtgxIv/bRL8ldgEh4eFjJ0u6rRymGt5NDOAC6BJKAjBxJgpngI2tqTcfeaz/hcLz
	 hA2NazeGGJ7FA==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danila Tikhonov <danila@jiaxyga.com>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: (subset) [PATCH v2 1/2] arm64: dts: qcom: pm6150: correct Type-C compatible
Date: Fri,  3 May 2024 15:34:17 -0500
Message-ID: <171476845420.82394.12041853165837616623.b4-ty@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240330091311.6224-1-krzysztof.kozlowski@linaro.org>
References: <20240330091311.6224-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Sat, 30 Mar 2024 10:13:10 +0100, Krzysztof Kozlowski wrote:
> The first part of the compatible of Type-C node misses ending quote,
> thus we have one long compatible consisting of two compatible strings
> leading to dtbs_check warnings:
> 
>   sc7180-acer-aspire1.dtb: pmic@0: typec@1500:compatible: 'oneOf' conditional failed, one must be fixed
>   sc7180-acer-aspire1.dtb: typec@1500: compatible:0: 'qcom,pm6150-typec,\n qcom,pm8150b-typec' does not match '^[a-zA-Z0-9][a-zA-Z0-9,+\\-._/]+$'
> 
> [...]

Applied, thanks!

[2/2] arm64: dts: qcom: pm6150: correct USB VBUS regulator compatible
      commit: 0ea3e1d6f31d8aea72d0d0b53919c585a12a593b

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

