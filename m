Return-Path: <linux-kernel+bounces-65750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C975F8551AF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 19:11:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE0D8B2AF8E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06EE712CD84;
	Wed, 14 Feb 2024 17:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sxOSLqOw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4279212C7FA;
	Wed, 14 Feb 2024 17:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707933477; cv=none; b=iIEDQTm0mlo5bkc8NTxv5ntVk4uHsVJx2+ny+nxGpUodq4F3LyoV02Z+a9XKobHDv2KgdKYkIsBq/JtYgk8c+6gJm2Uppj3p1IG5Or8ckceyH9x+I0Hx5M8FrPqdKXoKlc9W+1LGQOEZrP6u9gbgpTC4nCf9DjgU6SEunzXQvUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707933477; c=relaxed/simple;
	bh=ztHqKVO67ahjwzOhEISO4kB/hyljoeY/aq5oxnrHiVg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hfeXEa3ASfyLC4i1KblITuV2EatCnxPIJYN4LFoJRnJyH88Th/dUe8HAwR+19motfAOjTjjt6NDpsx8bOQC83kjDW7dHNgVY+EASwdTXeY7cI9sqVcb9kts5oLhNQuUFO42WR6jz60FMlDHElgb5wigvnpwKgBFfLwa/JEGMWjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sxOSLqOw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB689C433B2;
	Wed, 14 Feb 2024 17:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707933476;
	bh=ztHqKVO67ahjwzOhEISO4kB/hyljoeY/aq5oxnrHiVg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sxOSLqOwHXnKF6hm2VyVI2C3NxKD615oHRegO8IVeLv33V75+YYT+UOolGW58Rhf8
	 Lyv2RcSmFSGbHVfOYFh/iIfq/2+wl/S+D6UkG3zHeMuNKQkmweF9QH5wl4qf6Xjfe5
	 rq5Xuo74c3PmV+HIHEAJPXT6/3PSh0sEkzLpoydTmmWDi4270O/HPfH4BWCwYDNqYS
	 EH3BG7p2o7VBmHVCReTMsdK68EmWqbecgK3lUoY55cyy+FDZDvAYq/DAWJGHvL5x3z
	 6h4vd2x7+XqStr0YmpgOhNBfu3Ezk2Ebhgdd3Ro7lIOZk/0sTgNlSUeN1dgf/mE6j/
	 vHloREw9u4Sog==
From: Bjorn Andersson <andersson@kernel.org>
To: ~postmarketos/upstreaming@lists.sr.ht,
	phone-devel@vger.kernel.org,
	Andy Gross <agross@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Luca Weiss <luca@z3ntu.xyz>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Matti=20Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>,
	Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
Subject: Re: (subset) [PATCH v2 0/3] Bring up more CPU cores on MSM8226
Date: Wed, 14 Feb 2024 11:57:31 -0600
Message-ID: <170793345827.27225.9097116410462673675.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240210-msm8226-cpu-v2-0-5d9cb4c35204@z3ntu.xyz>
References: <20240210-msm8226-cpu-v2-0-5d9cb4c35204@z3ntu.xyz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Sat, 10 Feb 2024 17:28:51 +0100, Luca Weiss wrote:
> Add some nodes to bring up SMP on msm8226 SoC. Another commit to fix the
> sorting of the nodes is also included since the ordering is currently a
> bit all over the place.
> 
> The bindings patch depends on the following series:
> https://lore.kernel.org/linux-arm-msm/20240102-saw2-spm-regulator-v7-0-0472ec237f49@linaro.org/
> 
> [...]

Applied, thanks!

[2/3] ARM: dts: qcom: msm8226: Sort and clean up nodes
      commit: 70d6c14f52ff14742d5260b825fd76d047166a75
[3/3] ARM: dts: qcom: msm8226: Add CPU and SAW/ACC nodes
      commit: 74851b7f180a0534f25c3d0b744a92b2e3cb6dd2

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

