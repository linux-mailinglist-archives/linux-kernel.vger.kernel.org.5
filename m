Return-Path: <linux-kernel+bounces-78140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0CCD860F73
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 11:35:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8103DB21FB0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 10:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7CE263104;
	Fri, 23 Feb 2024 10:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RWgHoCDs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E3A5C91B;
	Fri, 23 Feb 2024 10:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708684544; cv=none; b=EfcXe/XUijZ9TqWCtfXE8OYyIQ/wPGtpX+X6cxqbCXobG2bklsPM5w48pAZbSuW/pf3knIhX8E7xNSXdJQqjplQjefiu3od30V11CAYoWes1ArQpRsW4yqhBB30ZzF0yanWQ/hq3kO/1Y3OW6d7g+BThSjIaCdQ5vJzHB5oHEYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708684544; c=relaxed/simple;
	bh=ruwnsn/gjGehFv1nBJWx1lSoMV/uko91BIOgAziMm3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rlce9eXP0g2dSXDvuwxckbzomZTKc4stdqjVLcvPgRdvQX9yz6Ia7DynPhorn4iKPm3dU385kAILYYhEmhym//8lQREplJ6EfQ3Sy4oUmAFct+NUxq8WYQpM0OZRDFseb/ZpbGKTONxaIQWKc/i+vmmliw5y2fIFw1WZCZw7DQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RWgHoCDs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1C69C433F1;
	Fri, 23 Feb 2024 10:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708684543;
	bh=ruwnsn/gjGehFv1nBJWx1lSoMV/uko91BIOgAziMm3M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RWgHoCDsVInAwCNNN7dPCmlvFap+RO20ZKOlw5tytgf/6HhxKiXjXRWImhWH4zwH4
	 vzTPARKaSLya1nJMxTc3NfXVRQSgkd+uWgdiSeKp+i3IEsyAWavegkD2Nn0WFtefg0
	 KDoZGR/8YogeLYhEEJ98ZrF//2MX+GGKZ0y6LoazZzdZX2DXWHCoIXQD92qnARlSou
	 Hom7au3sqBTdrrTwXo30O7GOKJkb5SuteMP8x+N1GTlKwaoKpDfxcRESRuBSUtF3Ph
	 AuVlC3rc2dVnBYZp4TFtwnXgsSd1gY/lDdCp/yAg+zEVC/T1a+HfeRW8msjSLElkrz
	 TrAjAOo9vBIYg==
Date: Fri, 23 Feb 2024 10:35:37 +0000
From: Lee Jones <lee@kernel.org>
To: linux-kernel@vger.kernel.org, Aren Moynihan <aren@peacevolution.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
	Jean-Jacques Hiblot <jjhiblot@traphandler.com>,
	Chen-Yu Tsai <wens@csie.org>, Ondrej Jirman <megi@xff.cz>,
	linux-sunxi@lists.linux.dev, Pavel Machek <pavel@ucw.cz>,
	linux-arm-kernel@lists.infradead.org,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	linux-leds@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Miles Alan <m@milesalan.com>, Samuel Holland <samuel@sholland.org>
Subject: Re: (subset) [PATCH v2 1/4] leds: rgb: leds-group-multicolor: allow
 leds to stay on in suspend
Message-ID: <20240223103537.GA1585387@google.com>
References: <20240206185400.596979-1-aren@peacevolution.org>
 <170868429025.1582603.10651778411484887304.b4-ty@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <170868429025.1582603.10651778411484887304.b4-ty@kernel.org>

On Fri, 23 Feb 2024, Lee Jones wrote:

> On Tue, 06 Feb 2024 13:13:17 -0500, Aren Moynihan wrote:
> > If none of the managed leds enable LED_CORE_SUSPENDRESUME, then we
> > shouldn't need to set it here. This makes it possible to use multicolor
> > groups with gpio leds that enable retain-state-suspended in the device
> > tree.
> > 
> > 
> 
> Applied, thanks!
> 
> [1/4] leds: rgb: leds-group-multicolor: allow leds to stay on in suspend
>       commit: 68552911e71d59e62dd5e50e9ac56ebfc32f0c71

Note that I changed a bunch of grammatical issues.

led  => LED
gpio => GPIO

Capitalised the first word of the comment, etc.

-- 
Lee Jones [李琼斯]

