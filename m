Return-Path: <linux-kernel+bounces-78685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D3A8861730
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:12:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCAAE28C94A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 16:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D45FB84A36;
	Fri, 23 Feb 2024 16:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TgiNb3HX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FBA3405C7;
	Fri, 23 Feb 2024 16:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708704737; cv=none; b=L+oscrW1ajSMg12R3i5OfAe/MZXGDl1jHD+LbkBmNkAI4vXIaoaPSg8sdmgmskqHEyEW+sMwH1kI8xuCj3X5AoE5/oqmfVIK8tHFCquEex1bEgL4JZ0QgIfQSI3ssvOlPNzeO6hZkZEzpwWwkZKi8IDVXnv1dphA7+ORAOxG0Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708704737; c=relaxed/simple;
	bh=6Vdkn9yDLgHPAT50DJZjRibJ9yb91Gq41Nl29O4tsYQ=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=TAmQKKfpsq8zl7ar+RcSWLV5uhMpdfT56ufFG8GLWyFV/H3BFXDWmYvmddSAujBFyhnT+YZz0inB8HZ1zM0JvHIuZpO9YTNW3wtMOzXR1xU1anxHkl43HmseDdrxCYME72SYp8+WmFz+dqBa1O98FFG4FrOrtNpVqhr3CifF0xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TgiNb3HX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5631C433C7;
	Fri, 23 Feb 2024 16:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708704736;
	bh=6Vdkn9yDLgHPAT50DJZjRibJ9yb91Gq41Nl29O4tsYQ=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=TgiNb3HXtT5b1DGXjeswMUh4cOyr+uOIP2q2xbcHkQOtOBQIkEYWx86Uc737WvMDV
	 hsvsAO+P3TCTOW59TMa3a6rHFlVcDNLK5OEDoyFB0skqvC6Y9AS8QtR8LXaXLDhZGG
	 ACQJyzleCKGp3Pqf19/q4ORqxufsm0i4Pp8b6/jcDZinOLXYv7XBHKfkUVXVMFql2I
	 i3hT2GwpJVyBvw74+kuwK23LR6/wIMnFGVpLQha4pEeKuv392ew3ZLsbpsqCCEi+8P
	 ADVKn37HHzSI0W3UGKcOo99KrdP506ClR/MgJI95DoSbPMrktaGpIhoN3G+uPn9pW1
	 aXSY3cGzA/i5w==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
 conor+dt@kernel.org, bcousson@baylibre.com, tony@atomide.com, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-omap@vger.kernel.org, Andreas Kemnade <andreas@kemnade.info>
In-Reply-To: <20240217082007.3238948-1-andreas@kemnade.info>
References: <20240217082007.3238948-1-andreas@kemnade.info>
Subject: Re: (subset) [PATCH v4 0/5] mfd: twl: system-power-controller
Message-Id: <170870473441.1731639.3240676194817206962.b4-ty@kernel.org>
Date: Fri, 23 Feb 2024 16:12:14 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.4

On Sat, 17 Feb 2024 09:20:02 +0100, Andreas Kemnade wrote:
> Add system-power-controller property in the bindings and
> the corresponding implementation and use it where
> appropriate.
> Not all cases are hit yet, there has probably to be a
> separate series after going through with a brush.
> 
> Changes in v4:
> - fix spelling/grammar
> - drop twl4030 dts cleanup, it would need an IB
>   or be postponed till next release
> 
> [...]

Applied, thanks!

[1/5] dt-bindings: mfd: ti,twl: Document system-power-controller
      commit: 0c7cc7497f6f62a65037e94cf0d885ab0af3c0d3
[2/5] twl-core: add power off implementation for twl603x
      commit: ca9414a1d08756c8392f9219caee607e1b7bade1
[5/5] mfd: twl4030-power: accept standard property for power controller
      commit: 8ba560ec14267af1169e1f5407fbce514fd4f6f6

--
Lee Jones [李琼斯]


