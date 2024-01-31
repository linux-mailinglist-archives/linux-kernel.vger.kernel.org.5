Return-Path: <linux-kernel+bounces-45966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CF04843872
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 09:04:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC5A5283894
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 08:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 662C657884;
	Wed, 31 Jan 2024 08:03:53 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6CA58135;
	Wed, 31 Jan 2024 08:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706688233; cv=none; b=muBOiFUAw4KTsA3X6K2hvzN0Zo+f5FL58qtvV7fQzShHXgeIm5b27Jj1ZKUkN01/OqlgTVnGUNKoij93AiNJ7Vcv5rAXTLtKYnoK3FJCJUa8byfeaiq1FD3wOQuLxiE9b2aa4if/mxB/jt+Ug38R+TnquRhtauGSXYWKdVevvYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706688233; c=relaxed/simple;
	bh=SLt6XU8pphgvYoB82n92VjDz497XNVauFggwxunEtzk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K+TNaIpFBb7tOX0mqIoJsUEK67UgmS6V/k3aLiIT+b5rl0dE45BmUddoJbpeN8+tVpKjCs66YTnNwZ5MHZxCjJbEYtpeLtd61xk5VOo3cyPyD44ocbojTkRbeksNb4bn2PCykMl+9bxegPz3HvFwwvE+M5TZN1VDyDATYElOiIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875af6.versanet.de ([83.135.90.246] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1rV5Yp-0002dS-MR; Wed, 31 Jan 2024 09:03:07 +0100
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Dang Huynh <danct12@riseup.net>, Manuel Traut <manut@mecka.net>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Sandy Huang <hjc@rock-chips.com>,
 Mark Yao <markyao0591@gmail.com>, Diederik de Haas <didi.debian@cknow.org>,
 Segfault <awarnecke002@hotmail.com>, Arnaud Ferraris <aferraris@debian.org>,
 Ondrej Jirman <megi@xff.cz>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v4 0/4] arm64: rockchip: Pine64 PineTab2 support
Date: Wed, 31 Jan 2024 09:03:05 +0100
Message-ID: <10956967.nitPUkWRp2@diego>
In-Reply-To: <ZblPtrW7suT3RRXc@mecka.net>
References:
 <20240127-pinetab2-v4-0-37aab1c39194@mecka.net>
 <6035442.lOV4Wx5bFT@melttower> <ZblPtrW7suT3RRXc@mecka.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Dienstag, 30. Januar 2024, 20:36:22 CET schrieb Manuel Traut:
> Hi Dang,
> 
> On Sat, Jan 27, 2024 at 06:35:50PM +0700, Dang Huynh wrote:
> > Hi Manuel,
> > 
> > Since the BOE patches have been accepted to next, you do not need to include 
> > it in this patch series.
> 
> sorry, I thought patches to LKML shall be against Linux master since the
> patches are still only in drm-next I considered to keep them in the queue.

normally if parts of the v(x-1) version of your series are already
applied somewhere you just mention that fact in the cover-letter
in the changelog, like "dropped display patches already applied to drm-misc"

Just to make sure, there is no need for a resend, I'll look at and pick
just the remaining patches :-)


Heiko



