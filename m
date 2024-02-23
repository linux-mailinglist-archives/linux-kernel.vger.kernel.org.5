Return-Path: <linux-kernel+bounces-78135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE55A860F5D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 11:32:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 165AB1C21750
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 10:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC469629E1;
	Fri, 23 Feb 2024 10:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YImAY2HX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10BCB627FB;
	Fri, 23 Feb 2024 10:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708684294; cv=none; b=qb2MKDZ2jfV4g34afSWhx75kUly3dUD7SgZ6HCKA2o/2W+iEiz45obsmo25R42O+sfXa7vYxjwvDzYpRyx0BOphfX6Fk/6tX9cE7tJKMmJSZmAKBb5E7+saSqp0YMrVbSJlG8zrBIR0k70t+9r6E6FTFvRPXccmG5HHmTTkzdbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708684294; c=relaxed/simple;
	bh=Isj6oxDZzzhj8McCO/BxOwu1TEWC/M4PG4ck8O7L4jQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=A1JSDF7gpT7eA0k6+lOwF3A3o2wSWB52yyU8s4UuqyRFjAUGbvr74KZwsEvhCbi8htPzqEjRjMGz5EC0XPwXbJ/60pMIGRwsBSwyELw/9+sYGehXA4j3fgsMHCI1NHpCEPYI+4VtNRxxYbJcFi0E7+/Vaiop7wkgWH9TBDOCPjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YImAY2HX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83AE3C433C7;
	Fri, 23 Feb 2024 10:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708684293;
	bh=Isj6oxDZzzhj8McCO/BxOwu1TEWC/M4PG4ck8O7L4jQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=YImAY2HXCi+Nzd19jarLSWyhfCTswyDHXWUgsKXn6VGJlF8qBoj5J1gBLv8ZmOfyN
	 smT1282HwhPJ3mvEaBigscC+ft+rm7xpbNRFHQxIIKEMvFPnGxnYLuzKQT9lUp3dg5
	 lEZBXpKEJOS8rtk6i7kfFh7s2LpcaR4n2oGa+GF3smTAYNm8c5YRGsyjhp2uS1SMfF
	 tvJvmAq5f26YgejWUbQY6Q/F4IlsvLEDZi5cbTjET/pPZkdzg9AsavDGuawgSU7gVq
	 YXgQqDRuQRRNpEnYVDPd++UQ8hOC+AY596xAXUUpf7qO8UyXfAVcWWdhpiIIBwJqa2
	 ra+A9nqIsgsPQ==
From: Lee Jones <lee@kernel.org>
To: linux-kernel@vger.kernel.org, Aren Moynihan <aren@peacevolution.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, 
 Jean-Jacques Hiblot <jjhiblot@traphandler.com>, 
 Chen-Yu Tsai <wens@csie.org>, Ondrej Jirman <megi@xff.cz>, 
 linux-sunxi@lists.linux.dev, Pavel Machek <pavel@ucw.cz>, 
 linux-arm-kernel@lists.infradead.org, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, linux-leds@vger.kernel.org, 
 Conor Dooley <conor+dt@kernel.org>, Miles Alan <m@milesalan.com>, 
 Samuel Holland <samuel@sholland.org>
In-Reply-To: <20240206185400.596979-1-aren@peacevolution.org>
References: <20240206185400.596979-1-aren@peacevolution.org>
Subject: Re: (subset) [PATCH v2 1/4] leds: rgb: leds-group-multicolor:
 allow leds to stay on in suspend
Message-Id: <170868429025.1582603.10651778411484887304.b4-ty@kernel.org>
Date: Fri, 23 Feb 2024 10:31:30 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.4

On Tue, 06 Feb 2024 13:13:17 -0500, Aren Moynihan wrote:
> If none of the managed leds enable LED_CORE_SUSPENDRESUME, then we
> shouldn't need to set it here. This makes it possible to use multicolor
> groups with gpio leds that enable retain-state-suspended in the device
> tree.
> 
> 

Applied, thanks!

[1/4] leds: rgb: leds-group-multicolor: allow leds to stay on in suspend
      commit: 68552911e71d59e62dd5e50e9ac56ebfc32f0c71

--
Lee Jones [李琼斯]


