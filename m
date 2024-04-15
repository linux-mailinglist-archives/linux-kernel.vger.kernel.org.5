Return-Path: <linux-kernel+bounces-144427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E02B68A4650
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 02:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1897F1C2146F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 00:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC7D81FA1;
	Mon, 15 Apr 2024 00:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="giUT0sXr"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223CF193;
	Mon, 15 Apr 2024 00:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713140365; cv=none; b=I6LIDAiuEtRHUt+V8yE7q3Tjy5knPZedncNIS1oKge/T0x18NPLX+kj4L0nfCszuGR6jWtlHh+jzZvWmIpyRPMAUd+WeR+JmiABaE5222c6k68DzjXcKIFOqxhXLbAhclI6qx6iXMKf495EdMBXcMz01B18j2OzMD3tvKn+rBg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713140365; c=relaxed/simple;
	bh=fn0cP6jHQy9x0E71RjlI6piVigamd0rjnbvWW/k3m8c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ru9kLuWLIiFrH5vVtSl4e0aNMJ+gXJQT6gMmlk0in4/GvKh55MOYodFvLJZNKQHnG0GBrj5kOCGePTkNyragTuPPW8L6vbnyWsVDgDKtCnP3f8EJiv2bXLLtix4fYuTG5vKJ4fvgMvrPvv4DJATBLMGqWnwW4SI5X7vHk2IgDmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=giUT0sXr; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Received: from [192.168.68.112] (ppp14-2-127-66.adl-apt-pir-bras32.tpg.internode.on.net [14.2.127.66])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 0901020178;
	Mon, 15 Apr 2024 08:09:23 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1713139768;
	bh=fn0cP6jHQy9x0E71RjlI6piVigamd0rjnbvWW/k3m8c=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=giUT0sXrneLxTzQYgCq5jqn57d27IX2/GFoKfYX+JCY8+ofHGvxXcFgdIfpxcmJTn
	 jUmOlCOv3LHdaojgs/5Mzh0YddGrpC/RI8UKg9WasG4onjtXOCgZeJ0JmvkuX7kyBT
	 qz8a8dKkJZTsgtx0O8IXrmztq4QkGmza6igXPyoAJXvC2xE+8+q0QINGwDdgm7rHbw
	 7PxzbgURR818zIPA/v+KFKWEdMy5Lf2/1JBBHWdmvgiAszW21rCh/k5WAW0DihhNrC
	 po1vlz/3HZjNlDp4ySUp8tF886a4EpMd+c9olDGwtPDCt3+Zehl2h+zvYTqRJR6pt7
	 maoIywYca5U8A==
Message-ID: <82fcd7a4532df119f82ea55208f592460ba5358e.camel@codeconstruct.com.au>
Subject: Re: [PATCH v3 2/4] dt-bindings: rtc: convert trivial devices into
 dtschema
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>, Vladimir
 Zapolskiy <vz@mleia.com>, Joel Stanley <joel@jms.id.au>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-stm32@st-md-mailman.stormreply.com, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Mon, 15 Apr 2024 09:39:22 +0930
In-Reply-To: <20240413-rtc_dtschema-v3-2-eff368bcc471@gmail.com>
References: <20240413-rtc_dtschema-v3-0-eff368bcc471@gmail.com>
	 <20240413-rtc_dtschema-v3-2-eff368bcc471@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2024-04-13 at 22:22 +0200, Javier Carrasco wrote:
> These RTCs meet the requirements for a direct conversion into
> trivial-rtc:
>=20
> - google,goldfish-rtc
> - maxim,ds1742
> - lpc32xx-rtc
> - orion-rtc
> - rtc-aspeed
> - spear-rtc
> - via,vt8500-rtc
>=20
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Andrew Jeffery <andrew@codeconstruct.com.au>
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>

We have trailers above but then there's more commit message content
below. Looks like what's below should be trimmed out (bad squash)?
Maybe the trimming could be done as its applied?

>=20
> dt-bindings: rtc: lpc32xx-rtc: convert to dtschema
>=20
> Convert existing binding to dtschema to support validation.
>=20
> Add the undocumented 'clocks' property.
>=20
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>

Andrew

