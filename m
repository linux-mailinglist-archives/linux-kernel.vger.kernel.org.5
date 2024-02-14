Return-Path: <linux-kernel+bounces-65739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E358550FC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:58:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CEB11F215DC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0E961292EB;
	Wed, 14 Feb 2024 17:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cP1IkrtS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22EC3128804;
	Wed, 14 Feb 2024 17:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707933467; cv=none; b=raX7YMBDYa6FuKLipfiIm8UgL323zJeBKH9INf/rG9MtHRAd5/t7pIJxN7Y3uvNYiqG4GySxFKQ8Xa5RE0Cgpm9LIOYR4l3gDYdla8XnLOYcN7PFf8ao/Rm/o9jUDgJINdyIOZE0I5fm2UEJ+3kuY4P1fosy8dxfSoW0vUb8tiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707933467; c=relaxed/simple;
	bh=jHQyAtk+n7f8D2fSMf+yAfUum8YxNu1gvdkzioXdQis=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cqRL/KzXg6eUy/Dsl8j4PJvAZgtNL8t5k/K6qz8+NBfKEYVnqQsg50kwqchlRNyYwzPAL3C9spJAg0BHaolzaXEOXgnf+IArWuhs1pWIi02turio6vR6xKJIYQmIp+Hx8XR/j8ix+QAYau3h62UuOblMVaNqcytCL/Px3E0YENo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cP1IkrtS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 151C9C433F1;
	Wed, 14 Feb 2024 17:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707933466;
	bh=jHQyAtk+n7f8D2fSMf+yAfUum8YxNu1gvdkzioXdQis=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cP1IkrtSmoLoY84o9LL+1nnxffZgfypp8mIs8sCPy6G8iGoMzOW9Ik88BZylIWOgm
	 o4NYdVKkzPzVV0rpY9mvZ6vFlJWRr8qkxDa/vUSfrkevJEogKKdTeqJguflna4sla7
	 dcQHiq4O42PxTgii9fcF1LQdeNzbTA8Sf50siBoiNJpXXG4+p/eX9YAHsgTx9TXljK
	 at9/Qkvp6wh5q4L/0TqD6VqkgEn9Suhbkuv2EICUCQGDaFyedR2weVz9hgdRUX/+1D
	 3QTuh1eoko5S6FLBfa70uhGT3geR2vN6TZduOK7PbEpWjpWOubtmRDDs/JGVADTrP9
	 B1XBaQrQq2YRA==
From: Bjorn Andersson <andersson@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Abel Vesa <abel.vesa@linaro.org>
Cc: linux-arm-msm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: defconfig: Enable X1E80100 multimedia clock controllers configs
Date: Wed, 14 Feb 2024 11:57:20 -0600
Message-ID: <170793345828.27225.16242770102119393725.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240208-x1e80100-configs-v1-1-9e027bee5209@linaro.org>
References: <20240208-x1e80100-configs-v1-1-9e027bee5209@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 08 Feb 2024 15:19:00 +0200, Abel Vesa wrote:
> Enable as modules the CAM, GPU, DISP and TCSR clock controllers for
> Qualcomm X1E80100 platform.
> 
> 

Applied, thanks!

[1/1] arm64: defconfig: Enable X1E80100 multimedia clock controllers configs
      commit: 1734e725ef512c1f9def3febc5920ef43decbe93

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

