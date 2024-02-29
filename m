Return-Path: <linux-kernel+bounces-87591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 120D086D641
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 22:34:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C9F5B26C13
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 21:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A348F6D50B;
	Thu, 29 Feb 2024 21:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dYjHh8DY"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6E916FF2B;
	Thu, 29 Feb 2024 21:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709242442; cv=none; b=o7hbOL23dI14MfBjMhnwfycC7hFywwSOdYDAMqN/PpwvMQk8inYoNPTYMZIE0UmaXO7ECrZPO85aKuHgObfm72PGdH/k1XLCUhH5p96M6rz+qQ3GAc8sLOOr98Pdu+e+sFof5cEu/TZzSn4RN6ocM++oLTU0v9U2EVhe7Ng615M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709242442; c=relaxed/simple;
	bh=dofoDQd/cvr1cec7GTuxonUZBm+meCKy+uphH2X8IHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FdXmtm1DJ5mzwXkrZ/5AZYWnSbQX0RDsnL1mkSalQDdx1Craffiv6vupNtUunP1wceVA6Vfa4hdHpn9BvThQC6iTmuk9hSKyqrM7qdhYsM/24AltVZ3DHa3JkjF3g442sSGXHTol3/+gUlTq6tD8wa0bnfOsuSWU0lClnpQiVsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dYjHh8DY; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3F9D3240002;
	Thu, 29 Feb 2024 21:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709242429;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1uC45p+7yfD/FGTF6Mb901L2LMQYp2AR2orIm1bdqkc=;
	b=dYjHh8DY/bTUZnNGrxT0m8mJ22qKILDE9LgOzSEU1k6iWOcsvW+AYx1fHGtq89qzrqd3WV
	EnAkAo1HF9dJbYBqQdVCqGgU/TH+dvbaRs2eHiDwV0EjrlzRBTflJlDVLDAgAPsUVlKMCW
	N+gfhCKQTaWmv/1gW9sGIQriePdyFlKmVY4j4/VPBJSlGlCZLU5VLZ13xbSU5hWv0AEgTw
	yG6DF+96aAHcpFES1xJnqKkryLlma+SI+RECXhpIXa8A2alUcbssyVJZoN+3D6fC7OdJ9X
	3A73K1TtfjNSitOZFncx4j2E+RH/8IOa9qzEojE24666xvn2gah+nmcP0QgoKg==
Date: Thu, 29 Feb 2024 22:33:48 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-rtc@vger.kernel.org,
	Josua Mayer <josua@solid-run.com>
Cc: Yazan Shhady <yazan.shhady@solid-run.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v7] dt-bindings: rtc: abx80x: convert to yaml
Message-ID: <170924241589.1874607.16703295987554323192.b4-ty@bootlin.com>
References: <20240219-rtc-abracon-convert-bindings-v7-1-aca4fc3b8cec@solid-run.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240219-rtc-abracon-convert-bindings-v7-1-aca4fc3b8cec@solid-run.com>
X-GND-Sasl: alexandre.belloni@bootlin.com

On Mon, 19 Feb 2024 15:29:45 +0100, Josua Mayer wrote:
> Convert the abracon abx80x rtc text bindings to dt-schema format.
> 
> In addition to the text description reference generic interrupts
> properties and add an example.
> 
> 

Applied, thanks!

[1/1] dt-bindings: rtc: abx80x: convert to yaml
      https://git.kernel.org/abelloni/c/626e2b54645a

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

