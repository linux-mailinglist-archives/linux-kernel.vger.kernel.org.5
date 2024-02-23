Return-Path: <linux-kernel+bounces-78777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F088618B3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:02:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 661DA1F25CA8
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48F91128397;
	Fri, 23 Feb 2024 17:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o+1xBZ+4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64DD7128815;
	Fri, 23 Feb 2024 17:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708707745; cv=none; b=NljWXrqEg53VKSaaGHf9e/mbxzd95o/tJOn1SgXOynHSnuYRRZ0TEt20TPM/fC0FZqB6fJx+PKJa3ysjRStUquMUpQxr14HguutUfY+g6D9oHBKV8tgX7Y1LJEPXdcB1vCPvyGC+eo0UiL1MRNpmsmVdtfqjW6l0WAaKqkCJOuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708707745; c=relaxed/simple;
	bh=2o5JTRd3DSLZEMCMjL2aEPBU20fNxBNrc7mjVBw+7kc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=tg+QMNmlMSb8G2DhJiHuWUU68XP6j9rUGlcGSyIdc+HaznXyFPIK9h4LGgbQpwVSo9TrWgeiHbv2EnHc1alkExjPdf19uhgFZJwbNwtcLxqOmKwuRckXUctwSl88PGqPsm9+CggLaW0yB6+yRw9HJMq4GwG30UrhHRAtQKvheNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o+1xBZ+4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6338FC433F1;
	Fri, 23 Feb 2024 17:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708707745;
	bh=2o5JTRd3DSLZEMCMjL2aEPBU20fNxBNrc7mjVBw+7kc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=o+1xBZ+4fsS6hVxXlzE4Esjcw5DWE+4AqLCXAV/E6hescN5VFBzaVp5Ml59UVr1Vj
	 NzMDNV2UJfA3il+FBx6bweSe4q5iNn+Y/+Okyy8D9oxMiQJFZ7ov+9NLXfrATx7QB+
	 XvZXB3wXhotzo91inun1fUnroamTPKzvz5IwEWq5UPGOpRldJMjPJc9i8upC/fq++8
	 FQlwge+dM5xQ14mVJVPiJ0s3ILgC5sJg1czRw6U13HxhT74bm8j+UbSL+41i/95ral
	 vu/+41W8+SF6cvkjkAKA2HG8euWXKsu98br8kgE2I8D8kcRd5Xk5bIIG9HoQYnHKY6
	 SlXDMhmaJSzog==
From: Lee Jones <lee@kernel.org>
To: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 Lee Jones <lee@kernel.org>, Daniel Thompson <daniel.thompson@linaro.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 "G.Shark Jeong" <gshark.jeong@gmail.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Maximilian Weigand <mweigand@mweigand.net>, Luca Weiss <luca@z3ntu.xyz>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 devicetree@vger.kernel.org
In-Reply-To: <20240220-lm3630a-fixups-v1-0-9ca62f7e4a33@z3ntu.xyz>
References: <20240220-lm3630a-fixups-v1-0-9ca62f7e4a33@z3ntu.xyz>
Subject: Re: (subset) [PATCH 0/4] Various fixes for the lm3630a backlight
 driver
Message-Id: <170870774114.1756675.11800657479764151316.b4-ty@kernel.org>
Date: Fri, 23 Feb 2024 17:02:21 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.4

On Tue, 20 Feb 2024 00:11:18 +0100, Luca Weiss wrote:
> On the MSM8974 Nexus 5 and OnePlus One phones (latter doesn't have
> display upstream) the display backlight was turning off whenever you
> would write a brightness to sysfs since a recent commit to the driver
> (kernel v6.5).
> 
>   backlight: lm3630a: Turn off both led strings when display is blank
> 
> [...]

Applied, thanks!

[1/4] backlight: lm3630a: Initialize backlight_properties on init
      commit: 4602c7615989e6e7052e317995a66014eb318082
[2/4] backlight: lm3630a: Don't set bl->props.brightness in get_brightness
      commit: ebb3b9a65b56e9b21841ab9a15b946407cd6b104
[3/4] backlight: lm3630a: Use backlight_get_brightness helper in update_status
      commit: 3c40590fafd4cc2447fb482a640c450e1a58ffa1

--
Lee Jones [李琼斯]


