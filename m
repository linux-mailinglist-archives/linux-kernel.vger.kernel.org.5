Return-Path: <linux-kernel+bounces-92316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C71DA871E58
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 12:55:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6282E1F249EA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 11:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C28235A4C7;
	Tue,  5 Mar 2024 11:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qtK+R73T"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2285813A;
	Tue,  5 Mar 2024 11:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709639726; cv=none; b=ZaAEILo5qJAdBXTjn+ulWiBSfJzEtLiUhESu9bpzHMZhflq4geFcIhDOizpKL2KfKLczJv1isJrkobQ3Lu8H6Kogs/tShoYt8Z9y8JvAg031wCZaGlRcqvQwkXbKnkfkR4HEJN3XRD8Nt+SABKReIipM1W6F3SvIp69Zgb37sGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709639726; c=relaxed/simple;
	bh=sMHVr2Ep0Y2KzS1jz7zvR1ubIJe6rQPJ3fIdf4+xAj8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=SL4UhNIAHNCo/1YqwlQ58PA+UXlh5kijUm6gb0lVz02sPLPohkfORhDyCJZRLhTvLx8oN/Hv7CiTVepD0dQvle7o0Zb6SPsSJ2mjKCOtOoYSVrc31KMiJrJ/Tqk9kXeM+Zq02xbAJfK7QPVYm9Tq8d9b2QbsQ0wB6BiYVY0w1Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qtK+R73T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39925C43394;
	Tue,  5 Mar 2024 11:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709639725;
	bh=sMHVr2Ep0Y2KzS1jz7zvR1ubIJe6rQPJ3fIdf4+xAj8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=qtK+R73To59j2hDGfUzgkXb2wWzSu9HVnG3NcdkfNKXkQ4HgY65LxGiTpU52pEwqE
	 3YiKHlMx4ATy9XyJ9+56SwXTPRri4AcQ6DpnjF3+X+5ZUJPZ8iUGiTlOTx6CGgmEK9
	 hJrP+pg5/LL5tIT/3+HHoY55WpXjzgkr5fZzZIeGVqLGioWrm3n/3nonwfC1L7b/gt
	 GF8QcALsB9X4GBl+e1f2Imjnzb2EsaFXK/YBbC3RkgtKhT9iqSlCCH1UdzrRMLU2LT
	 +wqyJfKNbBnu3v4kMcV+wLAFG2V22YcRwORvECh9RG+lDD8kA/bgTdAdBNfOAQ8D/h
	 BbuCZ0AeCVAKw==
From: Lee Jones <lee@kernel.org>
To: Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, ChiaEn Wu <chiaen_wu@richtek.com>, 
 Jean-Jacques Hiblot <jjhiblot@traphandler.com>, 
 ChiYuan Huang <cy_huang@richtek.com>, 
 Lukas Bulwahn <lukas.bulwahn@gmail.com>, 
 =?utf-8?q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>, 
 Abdel Alkuor <alkuor@gmail.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Jacek Anaszewski <jacek.anaszewski@gmail.com>, 
 Alice Chen <alice_chen@richtek.com>, linux-leds@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240305042049.1533279-1-alkuor@gmail.com>
References: <20240305042049.1533279-1-alkuor@gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: leds: Add NCP5623 multi-LED
 Controller
Message-Id: <170963972195.120208.5303865559153011204.b4-ty@kernel.org>
Date: Tue, 05 Mar 2024 11:55:21 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.4

On Mon, 04 Mar 2024 23:20:28 -0500, Abdel Alkuor wrote:
> NCP5623 is DC-DC multi-LED controller which can be used for RGB
> illumination or backlight LCD display.
> 
> 

Applied, thanks!

[1/2] dt-bindings: leds: Add NCP5623 multi-LED Controller
      commit: 1d81703a2e41fe95531b1408e0f836d5623f5b45
[2/2] leds: Add NCP5623 multi-led driver
      commit: 535a2262514d7d4016411707c9f8ac106062615f

--
Lee Jones [李琼斯]


