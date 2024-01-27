Return-Path: <linux-kernel+bounces-41433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B49A83F0E0
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 23:37:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E1AF1C225FB
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 22:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0DBD450EE;
	Sat, 27 Jan 2024 22:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MdtmDuS7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4CB31A83;
	Sat, 27 Jan 2024 22:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706394896; cv=none; b=Vzu9sdIkPdUtuiIfZkv1nDqwuVuZMvyxs7km+WnJxTTwncAg5159ZvQY42a3ycQ/syHBZQSrQ0AWsAKjf6m6GyQijf4gyZvFpxD+i3/BeoyzwEECdyCyPDEAvsFVQUeTlmso90bb0E7E6dA5R04PfY0nEJtW3c/G3BAfbcezyi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706394896; c=relaxed/simple;
	bh=z1S+ggeUHAbtLoizQ10X0ljzZHAEnRhoHFyKTqQWIj8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HtqkTb/joEPYg0RvQcZO6LZxKAx5q7ZJhzB2imICW5b/6gPd+mj3U3t/OLBIlEyElzX+Of5vdfMtSw58Hbyrbe53QgBChjWtLQTT1aqxewkxlfvQXONDMYbsfSYOJrKEvHkdYl83MLnPuMfmfxTiRjC29m498+z7XOEwCyJvEio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MdtmDuS7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F4C7C433F1;
	Sat, 27 Jan 2024 22:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706394895;
	bh=z1S+ggeUHAbtLoizQ10X0ljzZHAEnRhoHFyKTqQWIj8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MdtmDuS79uhHLQa/X7mzuuqd/E9Wsb4F2pVkwGjgKOb/kG7g7XcpjUDFF8siPbT2U
	 Vsu1TicyiVSirgq2bx6fHMj2OChTK0D+zjAqYbIyvv+oGFurg1EF1eRf4U7z8Voqdh
	 nGxXqxRccGxkarXtmScb53H8wwL4eQoKqLt0tCghJ1nSWWsKK8q9xk0nM2Seg+0l0m
	 Ic0zzPTL+8ptFykDIrbSN1BmClsXfG+urHgnDXqA4ryhimmEunCWzUsVRBrJj2RN5V
	 E8TYDXxrm2PAt+iwhx8w7isddmZOgxiws11ll2WryRezSbHKIPIg9EuXZ9v18MvIS2
	 lFGkG6I1ktOsw==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Andersson <quic_bjorande@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] soc: qcom: aoss: Mark qmp_send() __printf()
Date: Sat, 27 Jan 2024 16:34:47 -0600
Message-ID: <170639487717.21016.4146198110218013923.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240119-aoss-printf-annotation-v1-1-27e2ceb8937a@quicinc.com>
References: <20240119-aoss-printf-annotation-v1-1-27e2ceb8937a@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 19 Jan 2024 09:13:37 -0800, Bjorn Andersson wrote:
> As reported by lkp, qmp_send() would benefit from a __printf() marker to
> allow the compiler to further validate the passed parameters, fix this.
> 
> 

Applied, thanks!

[1/1] soc: qcom: aoss: Mark qmp_send() __printf()
      commit: b65a3fa38dbb5c84f360a48f0d5da3aed0011964

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

