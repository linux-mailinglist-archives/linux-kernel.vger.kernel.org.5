Return-Path: <linux-kernel+bounces-136813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51ACB89D88F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 13:53:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 021F81F23DE8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 11:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 336E712BEBB;
	Tue,  9 Apr 2024 11:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="NTPcbofB"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED4012AAD0;
	Tue,  9 Apr 2024 11:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712663587; cv=none; b=YArsq3dkCjA4L8fvLis6ZXr+Zdr6jrLquvweGJmDNzDamvIJCYzIUkKp/pgDwG19sfHbD+orwmYKyRL9cVSQndjZwvoZuGku0XLFiDyf1uM0r6TQbLCC0oWl1eA7PCHjYaR8/RXOq+Ln0JaVwlhs1rllIA5hE3dlWX0BcxRqVT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712663587; c=relaxed/simple;
	bh=uFtB/lSFtsJF9yk9iDLSRuCwagX/ZJnnVfsrEr8ZsXU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tHtsgA7Lc7lJB5MdkTaKP5BpLfGXhDjcIiefnrtHn8/A91Zr2oNu44Ij3tYrAPqWdmlLKFiZ4PyR+BQdWtPY3qVGnxcEKVcj3ok/xbOVhGPeez7s//SOLobcOSlBYOA137mqnHsPx79gdxIL1/vkWIVXDrAB7VXwgED5DBha/sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=NTPcbofB; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Received: from [192.168.68.112] (ppp118-210-182-70.adl-adc-lon-bras34.tpg.internode.on.net [118.210.182.70])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 6D6E72012B;
	Tue,  9 Apr 2024 19:53:01 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1712663583;
	bh=uFtB/lSFtsJF9yk9iDLSRuCwagX/ZJnnVfsrEr8ZsXU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=NTPcbofBd9m/9hOn+Z9Bbo9pjqBPAKGNnyTT2yNWOmCgmIADn5G3XCAFCJPIRF0EZ
	 wn3wJbQ2YDXaggC3yhum2A2+giKMYEreMFZ3IQ+EVaw38aecyEs4RVQU77UWpU0433
	 kP+VfZQ6pmC7XW6Li7H4vFIM0uUQo4mfNRi+M5e6wkdqFInWncdaMCwDAE4350u379
	 J29QgMlWXGnOgaNgRot38jEKMSleP8E7quRZUxvMe8W0yvq0jNmkAioSicj5FHWzo5
	 FQ9Qh9QojP2CJJKGlV0YDTMzuIBb/t7BTpQ2LwTs6Sc1ZHS5ShlxlFAzPltO94hZpX
	 lCVopsqSOhjJg==
Message-ID: <4adaae76f71c0f1f84ae10de68ce9837f1057463.camel@codeconstruct.com.au>
Subject: Re: [PATCH 5/9] dt-bindings: rtc: rtc-aspeed: move to trivial-rtc
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>, Vladimir
 Zapolskiy <vz@mleia.com>, Joel Stanley <joel@jms.id.au>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-stm32@st-md-mailman.stormreply.com
Date: Tue, 09 Apr 2024 21:23:00 +0930
In-Reply-To: <20240408-rtc_dtschema-v1-5-c447542fc362@gmail.com>
References: <20240408-rtc_dtschema-v1-0-c447542fc362@gmail.com>
	 <20240408-rtc_dtschema-v1-5-c447542fc362@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-04-08 at 17:53 +0200, Javier Carrasco wrote:
> The RTCs documented in this binding require a compatible, a reg
> and a single interrupt, which make them suitable for a direct
> conversion into trivial-rtc.
>=20
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>

Reviewed-by: Andrew Jeffery <andrew@codeconstruct.com.au>

Thanks,

Andrew

