Return-Path: <linux-kernel+bounces-57878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3748284DE86
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 11:43:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E60E2285435
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 10:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 307F06E2CA;
	Thu,  8 Feb 2024 10:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tjRY9w2O"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C811DFF2;
	Thu,  8 Feb 2024 10:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707388997; cv=none; b=Paa4r1RmpvzyuA1xqTuRJ0llBGUt+9OX24oY6jt5kdrBkXXfrqBXzNIY0SvraED5aK6/PLTXTJQcvuQR59JKRmCtSHSiEVRT0zRTN3zRF6RBqxc6TVKa4mbN93LBEbp0a0tcInpH3hQryW0Q16hfSRMGx2mXV2WcaYzbdP8svV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707388997; c=relaxed/simple;
	bh=KfIx2dvD9Jx16XIaLbt5IT05wsfzW5ISA44UElE5OiE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=nxAU6LWyI0njYHR6sHFe8j+nbPQcNTui2W1Q7GPdGKrnX1q6CBq+dg5RoZ4t4Sq+YJRBkokhWgz31vl82UM76R4bJfWesiROIlZ5yfjeNwdrSD+sIQGUwVGzYgg386oUg7ZysREqxGy83aydfuC6KnIDWLhR9SkYwg2EQ8MkBjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tjRY9w2O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75C8CC433F1;
	Thu,  8 Feb 2024 10:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707388997;
	bh=KfIx2dvD9Jx16XIaLbt5IT05wsfzW5ISA44UElE5OiE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=tjRY9w2OHQSTLts+RsI6TC0+oV3wVGZBD22CKaiW5JBl++0CGspdttW57gtTtfzJl
	 kpDOu1cAitbOgRgLfkG8Pi3MniPIarNzVujgwmJtpUB6wm082Txijk4aVFKxv8Q81R
	 aglazxU80ynmPCso9AQoyow1pId1abJkrgMA5Rb5jJ6Ky7s9KmfiHRTz6/JBDnvW7q
	 SzX6xghjqAeyMFQqFmwaX05eruWUgL+yoq076ElXhPpnOWegbzWL1O3blyqZFI3STz
	 ulyVk0FUzz1JMeeDtFgVIl4qt9rJajxVORZ1rL0nC6Pwb/y9cbFX/ARrlCq6Hnqe2C
	 BO/573b7JcOkQ==
From: Lee Jones <lee@kernel.org>
To: sam@ravnborg.org, bbrezillon@kernel.org, 
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
 airlied@gmail.com, daniel@ffwll.ch, robh+dt@kernel.org, 
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
 nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, 
 claudiu.beznea@tuxon.dev, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, lee@kernel.org, thierry.reding@gmail.com, 
 u.kleine-koenig@pengutronix.de, linux-pwm@vger.kernel.org, 
 Dharma Balasubiramani <dharma.b@microchip.com>
Cc: hari.prasathge@microchip.com, manikandan.m@microchip.com, 
 Conor Dooley <conor.dooley@microchip.com>
In-Reply-To: <20240202001733.91455-4-dharma.b@microchip.com>
References: <20240202001733.91455-1-dharma.b@microchip.com>
 <20240202001733.91455-4-dharma.b@microchip.com>
Subject: Re: (subset) [linux][PATCH v6 3/3] dt-bindings: mfd: atmel,hlcdc:
 Convert to DT schema format
Message-Id: <170738899221.920003.15342446791449663430.b4-ty@kernel.org>
Date: Thu, 08 Feb 2024 10:43:12 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.3

On Fri, 02 Feb 2024 05:47:33 +0530, Dharma Balasubiramani wrote:
> Convert the atmel,hlcdc binding to DT schema format.
> 
> Align clocks and clock-names properties to clearly indicate that the LCD
> controller expects lvds_pll_clk when interfaced with the lvds display. This
> alignment with the specific hardware requirements ensures accurate device tree
> configuration for systems utilizing the HLCDC IP.
> 
> [...]

Applied, thanks!

[3/3] dt-bindings: mfd: atmel,hlcdc: Convert to DT schema format
      commit: cb946db1335b599ece363d33966bf653ed0fa58a

--
Lee Jones [李琼斯]


