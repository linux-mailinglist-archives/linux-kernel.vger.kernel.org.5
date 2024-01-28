Return-Path: <linux-kernel+bounces-41858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10AAB83F8BB
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 18:48:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C04D428421E
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 17:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25F724D58E;
	Sun, 28 Jan 2024 17:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bFCV7gFW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6467E4CE13;
	Sun, 28 Jan 2024 17:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706463971; cv=none; b=U6fFtf/lHwbti4cNaIhUF5+Tj1H/qVg67XF/uZdqwpxO7STTuvPGSCxPfo4i/7YH1w9CAno8IFVpKy5JpK1FG4WqP1rLDhiWDv8WIoGKVJgasDq2rcZ+HhdhMAkd3x15LB8HZMQh8LDO5KmWpoRdmO7+Jn/hWxqAOAMCUIlW1ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706463971; c=relaxed/simple;
	bh=Qy9pX/xMxl5aQ+IVqAgyddGLNa0mQU6nTpN/RKv77s0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bj22KBuyxDTufa6Xcr4ruCJfMIFz49JzcpZEyt3fPFF720uexpR3QuDs1Qre6qu+eLQ2bYaOR/vid7lY7Td4UjaEf+cMEPDjHpvIghRfzfI7UR8Vdyw7nvCWNxXPyjfmXI2bQlwg/6ihWgCb/OJaZLsBatkxysff/k3Qpfe8sV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bFCV7gFW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 259ADC433F1;
	Sun, 28 Jan 2024 17:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706463970;
	bh=Qy9pX/xMxl5aQ+IVqAgyddGLNa0mQU6nTpN/RKv77s0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bFCV7gFWJeO8y6F0mkvmgurgF0GDMtF+PZ7Hbl/8yQzUy5CnOgwdxUxKaymVT3vSo
	 IPhSt1l41q3newrsZ3/OcHD3HxJ0ESE3gYWLnfnVNtWn2ygAB6dN/w2scRRxDjoAAY
	 dn5YF1DXf9K8rRy1P2efJ2uo1ZuQssF0rm3FjKmsTgMwDeGpSVya9WC1cZsPJh9tQo
	 1CHUdi44N3Km2a6rQvwWuA/t3sy66PLW64tBv1Q9BPnt8Gwnxr7rKywzflrfUoAVG7
	 oMnTRG5z8L+alqybglhzvG2PexwHrNCfQySmE5PmOhx5OsZem3Jrvoq3vmjTlxVUID
	 EUugyBnW6TcNQ==
From: Bjorn Andersson <andersson@kernel.org>
To: konrad.dybcio@linaro.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	dmitry.baryshkov@linaro.org,
	Tengfei Fan <quic_tengfan@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@quicinc.com
Subject: Re: (subset) [PATCH v4 0/6] arm64: qcom: add AIM300 AIoT board support
Date: Sun, 28 Jan 2024 11:45:53 -0600
Message-ID: <170646395046.64610.18292159117967930553.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240119100621.11788-1-quic_tengfan@quicinc.com>
References: <20240119100621.11788-1-quic_tengfan@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 19 Jan 2024 18:06:15 +0800, Tengfei Fan wrote:
> Add AIM300 AIoT support along with usb, ufs, regulators, serial, PCIe,
> sound card and PMIC functions.
> AIM300 Series is a highly optimized family of modules designed to
> support AIoT applications. The module is mounted onto Qualcomm AIoT
> carrier board to support verification, evaluation and development. It
> integrates QCS8550 SoC, UFS and PMIC chip etc.
> 
> [...]

Applied, thanks!

[2/6] dt-bindings: arm: qcom,ids: add SoC ID for QCM8550 and QCS8550
      commit: 3019d8f7eacdd2d14502f0fa5c3e4267da8409a3
[3/6] soc: qcom: socinfo: add SoC Info support for QCM8550 and QCS8550 platform
      commit: d7f3a3691e3c133c637fa381cdc91e7d1af9c5d7

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

