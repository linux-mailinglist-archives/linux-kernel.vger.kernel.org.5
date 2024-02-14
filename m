Return-Path: <linux-kernel+bounces-65749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87888855118
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 19:01:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 435902889C5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95AFB12C7E0;
	Wed, 14 Feb 2024 17:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="li1qgGYE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE6112C53F;
	Wed, 14 Feb 2024 17:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707933475; cv=none; b=lHrqUjPonFai3uCY/N5XpWkeGkvb6OV4so7nG/JvGLzXi54uJi1G9Qzs5NeTOktReZ447GjHsCBHzvEAkidxQowlALPH8+WwmwXL3kHiNHs8oUFenium6/Lx8GHn9x4k0UvJmrY7mlFiafdTbt4rf/nJygwYjw4z0PT/inyIwa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707933475; c=relaxed/simple;
	bh=7FJAObO9g6qfEDCLiDS+BIEYzc0XZFrZsJHpQ8CjSFI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=St91XqwYPCzFsR3UqVcumv0v8HnI9jROkDLIW2oM1OiHC0Wr7wLxUHqgRFSHm8n8flkT7C5MGUdF7cuon+TB4TA8zLwR0LnDVn+gHFSLsPjVLHmAq7W0GIOdCE4SsJBWlz6HJsU1zIEyyIYYHMEvNakAEeVwFVJ8HV3KgaDgdtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=li1qgGYE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A277CC433F1;
	Wed, 14 Feb 2024 17:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707933475;
	bh=7FJAObO9g6qfEDCLiDS+BIEYzc0XZFrZsJHpQ8CjSFI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=li1qgGYEhS74OLetjP6Ni1zWOGEcUlWotAkQoS7s/p+IcwlnHF4W66nJIrAGn3lys
	 IHEymTPjyT+4+eSbqLvxkAH0xQ/c+LihnWcfLykRXMhEXDp43KGbz14cKvRK0AbJDS
	 KNU3svF2B54qVN2TCOhex0VCanV/6+3DkWSpgALqc6LqWriKBej0yu5NrSL7AFfRAI
	 1V84GxzldP+hlBSygJpXjCMmbZKCLBmlRHRjChm/yu0ArmNDB1yxjhzWPX9DitRYUu
	 wbZeneRM85HLG07mdM6KsDzxFIyJsmN5iL1mbn9+ETM7qoSNC6BMMYr+4UG+hh54aC
	 rcpB15m2t45Ug==
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
Subject: Re: [PATCH 0/2] Bring up more CPU cores on MSM8226
Date: Wed, 14 Feb 2024 11:57:30 -0600
Message-ID: <170793345799.27225.242443065440216210.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231203-msm8226-cpu-v1-0-d18e83340b32@z3ntu.xyz>
References: <20231203-msm8226-cpu-v1-0-d18e83340b32@z3ntu.xyz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Sun, 03 Dec 2023 23:38:16 +0100, Luca Weiss wrote:
> Add some nodes to bring up SMP on msm8226 SoC. Another commit to fix the
> sorting of the nodes is also included since the ordering is currently a
> bit all over the place.
> 
> 

Applied, thanks!

[1/2] ARM: dts: qcom: msm8226: Sort and clean up nodes
      commit: 70d6c14f52ff14742d5260b825fd76d047166a75
[2/2] ARM: dts: qcom: msm8226: Add CPU and SAW/ACC nodes
      commit: 74851b7f180a0534f25c3d0b744a92b2e3cb6dd2

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

