Return-Path: <linux-kernel+bounces-58032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E42C584E078
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 13:14:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0C04283555
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 12:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9AC371B48;
	Thu,  8 Feb 2024 12:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kvxcGrGP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022E171B30;
	Thu,  8 Feb 2024 12:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707394436; cv=none; b=tZtZYyjy9u1r5jdkM8+Sv8d0yFawwAkMUiMSZB4OeM37w2dtwyJ2st7e1DUN2yNQDgf45d1l8BsKLD/Kr9aWMKnTGEA/wE/1GX7SIhgFZzpsDyVLPBLfFogwyne+WSXznSc7gh1NpKJtWlLUg/5LhHnaKksBbv3s6peHRd4n/D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707394436; c=relaxed/simple;
	bh=MvlH4ndOdSzFUwm8GqHry7TYNDj279G1o15aCH4zOkA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Djr/dd1jwSwWVrAdb//mnYsTeP97yZ1dztaUsLb8xpRIwHEhkvDEmPoZxcGny9mT59Rve5JG241sRBlmh+fiftEXxF8EG8bUToGnEyGViybzilL0tVAEEBlhX+QJy+/adV7/ES+26HtpmKjrbH6ri5JZnh/fb7mxqwRq8IAw4Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kvxcGrGP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFCBCC433C7;
	Thu,  8 Feb 2024 12:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707394435;
	bh=MvlH4ndOdSzFUwm8GqHry7TYNDj279G1o15aCH4zOkA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=kvxcGrGPAHDxiZe0WrrziSYopGe/0VsWAgEupIYMX7sLnATKYvGNzjPxxJVJz8rE7
	 pjT2bHgHcIe9y7iHY3SerQzs2qBTx4iw/C81t0nuAEWIcZUC+XnE0BI2F391CO//mf
	 g0e9iKQJkMImxQ94APAbY0Ml4kSbTgQIDeU4kRi8chMtVkpaKUNZ0qMQb1xbXWihhe
	 RkDHhYNDGd1EuAp2hbDjXifLkvw69KhCAyGbFTdx1BRu9WnNesr2s6ssgx+lh8p12z
	 UXiMsbxViyQbcRkBBES+AXuOyCwS1Hc0KOrH1OVEy/C4K7SDSp4nFwbDy9rJ86oloj
	 vkgccAmOSvixw==
From: Lee Jones <lee@kernel.org>
To: Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>, 
 Marijn Suijten <marijn.suijten@somainline.org>
Cc: linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, phone-devel@vger.kernel.org, 
 Bjorn Andersson <andersson@kernel.org>, Johan Hovold <johan@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@somainline.org>, 
 Martin Botka <martin.botka@somainline.org>, 
 Jami Kettunen <jami.kettunen@somainline.org>, 
 ~postmarketos/upstreaming@lists.sr.ht, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>, 
 Bjorn Andersson <andersson@kernel.org>
In-Reply-To: <20240204-pm660l-lpg-v5-1-2f54d1a0894b@somainline.org>
References: <20240204-pm660l-lpg-v5-1-2f54d1a0894b@somainline.org>
Subject: Re: (subset) [PATCH v5] leds: qcom-lpg: Add PM660L configuration
 and compatible
Message-Id: <170739443256.968294.11874564929033098601.b4-ty@kernel.org>
Date: Thu, 08 Feb 2024 12:13:52 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.3

On Sun, 04 Feb 2024 18:24:20 +0100, Marijn Suijten wrote:
> Inherit PM660L PMIC LPG/triled block configuration from downstream
> drivers and DT sources, consisting of a triled block with automatic
> trickle charge control and source selection, three colored led channels
> belonging to the synchronized triled block and one loose PWM channel.
> 
> 

Applied, thanks!

[1/1] leds: qcom-lpg: Add PM660L configuration and compatible
      commit: 0e848bb4630e12099636fde050cadad33221045f

--
Lee Jones [李琼斯]


