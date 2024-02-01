Return-Path: <linux-kernel+bounces-47651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FFBA8450BF
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 06:34:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE078283575
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 05:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B5FE5F868;
	Thu,  1 Feb 2024 05:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="ccD/OFyn"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1465F851;
	Thu,  1 Feb 2024 05:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706765677; cv=none; b=T/Yv0doOCtP+oVuU0/NAw547z5qB+YpTxP85wMedczda1c5kpVOmBl7IFefKOqZhMkD150gaKiDDBWGz7LkfHS/LbdZNibBufo+TfF8cdQKR8pvf8MW5wrgoqQSAg1q5fYeKeNGSIHeeXyLP+bibNTYumu5yS/wygKaB5VDZ1a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706765677; c=relaxed/simple;
	bh=ocGDRaiFfAcxWe/yg/LxwtwAGEIOkFi3bEQi3m4ok1M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KxAi8NO4fKGcSbqRYmOI1KiEGW/MQBSsAhYiOfr36XL/MShH359YHUh4NULFMqrKC/7qPaVGofXW3vegBAm+OcE+6Ao0F8TsGoHanAh7X+aobSrQICKBXIXSNYkQs09lrq4h5N+ltXQrYa2eS9G6wo22wwGqI947hYAdAF1wZmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=ccD/OFyn; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Received: from [192.168.68.112] (ppp14-2-76-194.adl-apt-pir-bras31.tpg.internode.on.net [14.2.76.194])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id D92B22017A;
	Thu,  1 Feb 2024 13:34:30 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1706765673;
	bh=ocGDRaiFfAcxWe/yg/LxwtwAGEIOkFi3bEQi3m4ok1M=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ccD/OFyniLLOYzZT/FmroG2zvSOPbXFZXOEl84HF8/2s/P8PFZ4fSVsE3QufR7eFn
	 Oj2fPg68qp0s27uOXKXEbZ/c+LEOlWs3l+SyyN14jRL/3XLQz+h3mkx9oY445YqvGT
	 maaLAinFoxY6sWaFk7qtEoiKO4rIL45gHuGC95DU/FrgKWgBgVA3ZwNgejikutI6E2
	 KSvOuoAN9WTHnZwirsKaoYLEiDXq0IfIeuo8iShM9LpNpkBpNKcXeM2XfchhecKiG3
	 iqK3nDAJt1b9TTRajLv7AZoYbtYoEVIaHo/cKZp/w0LoBG9hKBp9kfjUawCPm43CGh
	 Hv8cKvsSFHkCg==
Message-ID: <e089430c47df55b57e65e5952fdfde8ab80891b3.camel@codeconstruct.com.au>
Subject: Re: [PATCH v5 04/21] ARM: dts: aspeed: yosemite4: Enable watchdog2
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>, patrick@stwcx.xyz, Rob
 Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Joel Stanley <joel@jms.id.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date: Thu, 01 Feb 2024 16:04:30 +1030
In-Reply-To: <20240131084134.328307-5-Delphine_CC_Chiu@wiwynn.com>
References: <20240131084134.328307-1-Delphine_CC_Chiu@wiwynn.com>
	 <20240131084134.328307-5-Delphine_CC_Chiu@wiwynn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-01-31 at 16:41 +0800, Delphine CC Chiu wrote:
> enable watchdog2 setting

Maybe "Enable watchdog2 for SoC reboot" at least?

Andrew

