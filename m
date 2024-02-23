Return-Path: <linux-kernel+bounces-78613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45FAA8615E0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 16:32:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4FE42877DF
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24BC28287D;
	Fri, 23 Feb 2024 15:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=peacevolution.org header.i=@peacevolution.org header.b="CoCNqIXM"
Received: from a.peacevolution.org (a.peacevolution.org [206.189.193.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8846FD1;
	Fri, 23 Feb 2024 15:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.193.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708702360; cv=none; b=P/tszB+YSAVYV0Q786wMm6QgQkk91Iue2wQh4CfyR9/RhcNXCbZ37dkeaE14SgQvxGOGbvh0JMvPvLQY+MIMxTYO7+KmeLyc7fHKzgDxVSEBhjTFx0pwf1cySyeo4++cDcU0CrYf7r1KfTX+/GP/HXyP4iHl2TpDyIfdCfgW37s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708702360; c=relaxed/simple;
	bh=QwhJ/EhbFImaRF3xYH27wlph7G0Hv+gUoIttDJYn92g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rB67kS9OS6SChFk3PIG8ZLKHK0uVXvna7aGJ7TLvsVND8LPci2xiCkrSGHObZzulu3TmyMnJqsSQbEhsWDR7W6CpOlVd1uAj+6EspQhIOqn9CAS8KK/J0K0YIxUbMKOanMy+M4ZkybLtX5QPg+PY/AXEg11g61GOowbVtdHgz0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peacevolution.org; spf=pass smtp.mailfrom=peacevolution.org; dkim=pass (1024-bit key) header.d=peacevolution.org header.i=@peacevolution.org header.b=CoCNqIXM; arc=none smtp.client-ip=206.189.193.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peacevolution.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peacevolution.org
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
	by a.peacevolution.org (Postfix) with ESMTPA id 03147473D0;
	Fri, 23 Feb 2024 15:32:36 +0000 (UTC)
Date: Fri, 23 Feb 2024 10:32:34 -0500
From: Aren <aren@peacevolution.org>
To: Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, 
	Jean-Jacques Hiblot <jjhiblot@traphandler.com>, Chen-Yu Tsai <wens@csie.org>, Ondrej Jirman <megi@xff.cz>, 
	linux-sunxi@lists.linux.dev, Pavel Machek <pavel@ucw.cz>, 
	linux-arm-kernel@lists.infradead.org, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	linux-leds@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, Miles Alan <m@milesalan.com>, 
	Samuel Holland <samuel@sholland.org>
Subject: Re: (subset) [PATCH v2 1/4] leds: rgb: leds-group-multicolor: allow
 leds to stay on in suspend
Message-ID: <hjug4ilzxvtf7in64zw4jcjudzknqh2onvicd5cjuc3e47nl4w@3uiabmqehx5n>
References: <20240206185400.596979-1-aren@peacevolution.org>
 <170868429025.1582603.10651778411484887304.b4-ty@kernel.org>
 <20240223103537.GA1585387@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240223103537.GA1585387@google.com>
X-Spamd-Bar: /
Authentication-Results: auth=pass smtp.auth=aren@peacevolution.org smtp.mailfrom=aren@peacevolution.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=peacevolution.org;
	s=dkim; t=1708702357;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:content-transfer-encoding:in-reply-to:references;
	bh=bw29ITqhOc5CeCA/jH5jxWpEfOX2iQUtCJTOD5NXUhg=;
	b=CoCNqIXMagBCAcmjTHXGXkYAtAh0zjlljpz2ecGOWTzDEXfRdy9XzNeENx/jrVfOFS/3Uh
	Bh9wbkJxKqXrTaacPJkPRP6DnmA9E3X0/t9Dizc79YsRX84jJVg8KlnStpJ2ArEIZL8uq7
	siR4+baxF5E9ExTBYG/xrQJ6/pD4y9s=

On Fri, Feb 23, 2024 at 10:35:37AM +0000, Lee Jones wrote:
> On Fri, 23 Feb 2024, Lee Jones wrote:
> 
> > On Tue, 06 Feb 2024 13:13:17 -0500, Aren Moynihan wrote:
> > > If none of the managed leds enable LED_CORE_SUSPENDRESUME, then we
> > > shouldn't need to set it here. This makes it possible to use multicolor
> > > groups with gpio leds that enable retain-state-suspended in the device
> > > tree.
> > > 
> > > 
> > 
> > Applied, thanks!
> > 
> > [1/4] leds: rgb: leds-group-multicolor: allow leds to stay on in suspend
> >       commit: 68552911e71d59e62dd5e50e9ac56ebfc32f0c71
> 
> Note that I changed a bunch of grammatical issues.
> 
> led  => LED
> gpio => GPIO
> 
> Capitalised the first word of the comment, etc.

Awesome, thank you
 - Aren

> -- 
> Lee Jones [李琼斯]

