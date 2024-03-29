Return-Path: <linux-kernel+bounces-125103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44CF8892027
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 16:18:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED13F1F286E4
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D94914A82;
	Fri, 29 Mar 2024 14:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="eWbYRLHL"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4091C0DC1;
	Fri, 29 Mar 2024 14:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711724387; cv=none; b=Oe66fWlg57b+OlF0rv7oWdMy5kFA2ySOVmQO5xtpJQ2jp+BEW3btzK+nwpouxxVJK3RpN1bgVxB866AMX0b9+n1utDLyLejmVhwQ2jk4B74IKQ2sVi7puieTZ1/IeDC6zmhuPnLqFZmQclpOzef3/D/F/b9LU5HYuF/jrselv8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711724387; c=relaxed/simple;
	bh=/cnZPytqdSf2fPiiQIi+nxR0VnEYwIU/ZwaQvIe58a8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aoBxEEnnisFt420+Nc+nlFuyZ6/W6lLWLqW9XCMmBSxmS5G8pkGtPw00IIa5Y8/08afqwE7RDbA+HtX39uRr8yT0RusOzx0qssv/LM2f7euCJqU6DYU8/+TYEY2EyP+CYeVV3yeMCZnQvzQIUD/vCp954evof18+f3AiBjsLo0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=eWbYRLHL; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B42721C0008;
	Fri, 29 Mar 2024 14:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1711724383;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xRLX1mOYv+/ZWVopFYct6o5hS3M6WhMcK4LW4QwDZPU=;
	b=eWbYRLHLuPtxt5wGda0VtJW/5ksJQrWTjaz/yqhEfo0SnG3JOIPBzSyfv2ntDm6jtUfYql
	kYLoa829e52ULwFroeqxH28LTT4qqi/OIIYPgPoFIschBy1kT8zoT+iBt5gMNTNgAS71zX
	pogyY5lbWxaSlgxw0jLmZ5Zy2kZF2bmPZDCADaJgQQ11XfMhkbRU51KYiA8UXV86MZCobW
	KTvey2LaSoK+hIMb2MDksTCsm/ZDmByh1vTdFt8FMfU9Ka93PuhYaYz6l1YlOb9XHQ9Esf
	PZfgwGDIaJqR1pPyac4fbFJNUjC08ukPWwet7HxI3RVnOt+r/FQvv9HbuDBv6g==
Date: Fri, 29 Mar 2024 15:59:42 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Baruch Siach <baruch@tkos.co.il>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v3 0/4] dt-bindings: rtc: convert multiple devices to
 dtschema
Message-ID: <171172436464.1832232.15920674758394192653.b4-ty@bootlin.com>
References: <20240326-rtc-yaml-v3-0-caa430ecace7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326-rtc-yaml-v3-0-caa430ecace7@gmail.com>
X-GND-Sasl: alexandre.belloni@bootlin.com

On Tue, 26 Mar 2024 14:03:22 +0100, Javier Carrasco wrote:
> This series converts the following existing bindings to dtschema:
> 
> - armada-380-rtc
> - alphascale,asm9260-rtc
> - digicolor-rtc (moved to trivial-rtc)
> - nxp,lpc1788-rtc
> 
> [...]

Applied, thanks!

[1/4] dt-bindings: rtc: armada-380-rtc: convert to dtschema
      https://git.kernel.org/abelloni/c/c3c50e7df39b
[2/4] dt-bindings: rtc: alphascale,asm9260-rtc: convert to dtschema
      https://git.kernel.org/abelloni/c/432008d2f766
[3/4] dt-bindings: rtc: digicolor-rtc: move to trivial-rtc
      https://git.kernel.org/abelloni/c/971e7303f472
[4/4] dt-bindings: rtc: nxp,lpc1788-rtc: convert to dtschema
      https://git.kernel.org/abelloni/c/7918a220d210

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

