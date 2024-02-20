Return-Path: <linux-kernel+bounces-72531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D72EA85B4DA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 09:21:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68468B22741
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 08:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B2915C611;
	Tue, 20 Feb 2024 08:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sct0qFh2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461BC5C5FD;
	Tue, 20 Feb 2024 08:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708417235; cv=none; b=GpJcmvNccVvu87z/rac0+joJSqzQWq64v+cRqwG7BraX68dkaVOW6mtHdYIdFMsiciwQB93Kwe//6zv2tA4aIVWDnLfV9oZpcc5QvucdnRoCgczBOynfOp9n2WY2tSZ3O/ZXGmkbyk8fmKnFygDpZTkgx+Gu8Jz/dNn8nLm2zlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708417235; c=relaxed/simple;
	bh=juZHMPub+6tKnVZnQVFBOsW3YWxQA8WKPjGFSa0GHbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C6uvql8t9Lbv7bV6/qkNlz6eztLl+m05mXNUUMEJrdFh13JjyQFZQf9ecyO/9Amsoa25FOMYZnpvMBOTcg8uLoh9PxlFb9RVF0PyGl5vYwlVB9t2afMKm9e5y+9FF3RbiuR10vbhcyNe4A3L6wQG/akXpnVujdVjALoKc1dCxC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sct0qFh2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D58EEC43390;
	Tue, 20 Feb 2024 08:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708417234;
	bh=juZHMPub+6tKnVZnQVFBOsW3YWxQA8WKPjGFSa0GHbY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Sct0qFh2rWejdiEQbEC6tLRbe7HazW5qJNEyUtkts70T7v+WRZg61N8mgfmRki2wM
	 V9n+IqokA3A2LE6ONHEkz+pUJftPcUj5PjlIvEd7BRwT/UV5aZ1xEMwM52f+y8ODDU
	 AyKCc7jxszLRM1tElkMjQhLXY2hZ6HIhJW3pEny/ImLQoE3rwliv2lqTMTr2FzF5b2
	 W7DmNi2gP2iipx5YGrWC1mtiBRH7TWXECQAYpdwz4tEiyf9nc2YiA7q2Nvxoakm7fX
	 TFuQSJrxkOXvXtXXgBV2J0aKyc4rri/5YPf5nDWOAI+G39NbTHZD7q8J566jbIoieo
	 NpLLRjASlEg/w==
Date: Tue, 20 Feb 2024 08:20:26 +0000
From: Lee Jones <lee@kernel.org>
To: Dharma.B@microchip.com
Cc: krzysztof.kozlowski@linaro.org, sam@ravnborg.org, bbrezillon@kernel.org,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, Nicolas.Ferre@microchip.com,
	alexandre.belloni@bootlin.com, claudiu.beznea@tuxon.dev,
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
	linux-pwm@vger.kernel.org, Hari.PrasathGE@microchip.com,
	Manikandan.M@microchip.com, Conor.Dooley@microchip.com
Subject: Re: (subset) [linux][PATCH v6 3/3] dt-bindings: mfd: atmel,hlcdc:
 Convert to DT schema format
Message-ID: <20240220082026.GG10170@google.com>
References: <20240202001733.91455-1-dharma.b@microchip.com>
 <20240202001733.91455-4-dharma.b@microchip.com>
 <170738899221.920003.15342446791449663430.b4-ty@kernel.org>
 <cedecdb7-fe4a-42ea-9a11-faa82f84b57d@linaro.org>
 <ffd43756-b24e-4f19-be33-0e33047ad70c@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ffd43756-b24e-4f19-be33-0e33047ad70c@microchip.com>

On Tue, 20 Feb 2024, Dharma.B@microchip.com wrote:

> Hi Krzysztof,
> 
> On 12/02/24 3:53 pm, Krzysztof Kozlowski wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > 
> > On 08/02/2024 11:43, Lee Jones wrote:
> >> On Fri, 02 Feb 2024 05:47:33 +0530, Dharma Balasubiramani wrote:
> >>> Convert the atmel,hlcdc binding to DT schema format.
> >>>
> >>> Align clocks and clock-names properties to clearly indicate that the LCD
> >>> controller expects lvds_pll_clk when interfaced with the lvds display. This
> >>> alignment with the specific hardware requirements ensures accurate device tree
> >>> configuration for systems utilizing the HLCDC IP.
> >>>
> >>> [...]
> >>
> >> Applied, thanks!
> >>
> >> [3/3] dt-bindings: mfd: atmel,hlcdc: Convert to DT schema format
> >>        commit: cb946db1335b599ece363d33966bf653ed0fa58a
> >>
> > 
> > Next is still failing.
> > 
> > Dharma,
> > You must explain and clearly mark dependencies between patches.
> 
> I sincerely apologize for any confusion caused by the oversight. I have 
> organized the patches according to their dependencies in the patch 
> series, but unfortunately, I neglected to explicitly mention these 
> dependencies. I understand the importance of clear communication in our 
> collaborative efforts. Please feel free to provide guidance on how I can 
> assist you further in resolving this matter.

If this continues to be an issue, I can just remove the commit.

-- 
Lee Jones [李琼斯]

