Return-Path: <linux-kernel+bounces-60459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18999850536
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 17:31:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A54E81F22969
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 16:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 330505C60C;
	Sat, 10 Feb 2024 16:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b="izGw1yWs"
Received: from ahti.lucaweiss.eu (ahti.lucaweiss.eu [128.199.32.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136C941C87;
	Sat, 10 Feb 2024 16:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.199.32.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707582672; cv=none; b=ZCZAlhf5j3xC8t/HOIegj+BZ4sW4GhTazsq8VQWTMu8E+U+ZObmfPgj0ZRD4fcDlvlkKGpyxGiiz+J5RIo+sLVhacFb5RUFnOIS3kmKLOHO0KXi1vAuK3wBOWp0oKAk3jizc+oqCLKqB5Id3FSmM5fzYaT9zSWuVvstbYfdVnyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707582672; c=relaxed/simple;
	bh=IncA1VMrA6tuD7GF+f2a0bUCatFt+ciCkgzzDC3uVAY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VjVw86NtiTQ9Y2TZP8PMllTa0UA/nq18FUktozKrFJuf6iaGZ+EvYdRj7i3titMzYtdSWl9Uff9fxkBOQmeQeWMrFcE8X+BtssRXFUbtGlJKStwlR5W6K17NTcV9XnlHYygrlVUAG2HGY1aS+6z0ZNOncdGf7qI6KBQeq8w+G+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz; spf=pass smtp.mailfrom=z3ntu.xyz; dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b=izGw1yWs; arc=none smtp.client-ip=128.199.32.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=z3ntu.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=s1;
	t=1707582669; bh=IncA1VMrA6tuD7GF+f2a0bUCatFt+ciCkgzzDC3uVAY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=izGw1yWsOH2QZrQIZAsJDTMJIuBMNJt7Bpeaeh/XfhUhXMYA/jNUZkRkT+SiQhM+I
	 uCysQg6CG68EvsyzlsNnAEYxdwvRwcbdZpULod9Q0r5tABYn/N4GlnGgJb4bs8QpyO
	 xR5OqOhzewQdDmcKz16rByI2OUbRMl3KCGk2ujWA=
From: Luca Weiss <luca@z3ntu.xyz>
To: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Stephan Gerhold <stephan@gerhold.net>,
 Matti =?ISO-8859-1?Q?Lehtim=E4ki?= <matti.lehtimaki@gmail.com>,
 Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject:
 Re: [PATCH 2/3] pmdomain: qcom: rpmpd: Add MSM8974+PM8841 power domains
Date: Sat, 10 Feb 2024 17:31:08 +0100
Message-ID: <2171119.irdbgypaU6@z3ntu.xyz>
In-Reply-To: <18ae7906-5089-42b3-a511-6e301f116e06@linaro.org>
References:
 <20240210-msm8974-rpmpd-v1-0-de9355e6842a@z3ntu.xyz>
 <20240210-msm8974-rpmpd-v1-2-de9355e6842a@z3ntu.xyz>
 <18ae7906-5089-42b3-a511-6e301f116e06@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Samstag, 10. Februar 2024 15:19:54 CET Konrad Dybcio wrote:
> On 2/10/24 15:12, Luca Weiss wrote:
> > Add the power domains CX & GFX found on devices with MSM8974 and PM8841.
> > 
> > Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> > ---
> 
> [...]
> 
> > +static struct rpmpd gfx_s4b_corner_ao;
> > +static struct rpmpd gfx_s4b_corner = {
> > +	.pd = { .name = "gfx", },
> > +	.peer = &gfx_s4b_corner_ao,
> > +	.res_type = RPMPD_SMPB,
> > +	.res_id = 4,
> > +	.key = KEY_CORNER,
> > +};
> > +
> > +static struct rpmpd gfx_s4b_corner_ao = {
> > +	.pd = { .name = "gfx_ao", },
> > +	.peer = &gfx_s4b_corner,
> > +	.active_only = true,
> > +	.res_type = RPMPD_SMPB,
> > +	.res_id = 4,
> > +	.key = KEY_CORNER,
> > +};
> 
> I don't see a s4b_ao downstream.. Though it's very unfortunate we
> didn't choose to add power-domain-cells or sth and set the bucket
> through that..

Right, overlooked that. Will drop gfx_ao for both this and the other patch.

Regards
Luca

> 
> Konrad





