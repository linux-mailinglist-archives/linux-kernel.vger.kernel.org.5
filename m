Return-Path: <linux-kernel+bounces-47656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E4CB8450D2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 06:38:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4988F289995
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 05:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3808C60DF6;
	Thu,  1 Feb 2024 05:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="PP/af9l9"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2584C384;
	Thu,  1 Feb 2024 05:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706765917; cv=none; b=rci3Q5ojKAK/pThM5S3CDWW3WIgWsVyJC8P2CQ2MbLByTE9cAM6r7VO7SXH3itrS223KwoUoR3FdpTaI3Kjr5mhBx/F8GO9vJf6z4zkidmknbAQlhLnZnkcIs+0ydTADeW1uAmfqUyhc1l+Otf2GQuhtfcctR/RHlJpPc56p4QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706765917; c=relaxed/simple;
	bh=Djpg8Xnc1IJVcbJPW8SjjmQo0regqTyJKFMwqv4OXbw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=thTuM90djav6FODwJ7gUChvjjttZjQnMageR/Vc9XMPPSChe5UrPXpsYQk1JhWaB6dT2Km/KRV4yFzOW9NZwqBZlFc+ZD+opUtVie1httnRZmBlS/XnUg3iAwWWrcsPZgPDDIkjzla/4pGDEJoJHcv1je3Sk2ixnU5rpbkmgtLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=PP/af9l9; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Received: from [192.168.68.112] (ppp14-2-76-194.adl-apt-pir-bras31.tpg.internode.on.net [14.2.76.194])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 576212017A;
	Thu,  1 Feb 2024 13:38:33 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1706765914;
	bh=Djpg8Xnc1IJVcbJPW8SjjmQo0regqTyJKFMwqv4OXbw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=PP/af9l9bFr2QNXvgnCn2BcsvEpY2qXdt6Np6mKIWRpCPFfZSJVb1ZKSg3nPurIKm
	 /850HSmfwdSAs4W1QpZF/IP+MGpXovTn02HVcofBCSfrDQOipiAC/7Ms58wuK+yep2
	 CF7C+pho5eRiVtFBM4kus9xaCLUgkYdlqXZab326U2Ygi5yampCxnC5awK6f5TbT2D
	 D2wJeyB9xpEZOAtvBdDt5xabe3+/N7thwwzU2cTtD6HthBpipa6Y22Fa1EqEHfpFwH
	 cbMwKVONimkQqh8qmPV87tMuAoOOatQfuLyDrcI2k3tj246AESQtrA/sJ4rWmrpjH8
	 PIYWeHmqG7A/A==
Message-ID: <614175735b8dc7e9426065fc433fb8e805a84734.camel@codeconstruct.com.au>
Subject: Re: [PATCH v5 12/21] ARM: dts: aspeed: yosemite4: Remove
 temperature sensor for yosemite4 schematic change
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>, patrick@stwcx.xyz, Rob
 Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Joel Stanley <joel@jms.id.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date: Thu, 01 Feb 2024 16:08:32 +1030
In-Reply-To: <20240131084134.328307-13-Delphine_CC_Chiu@wiwynn.com>
References: <20240131084134.328307-1-Delphine_CC_Chiu@wiwynn.com>
	 <20240131084134.328307-13-Delphine_CC_Chiu@wiwynn.com>
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
> Remove temperature sensor for yosemite4 schematic change

Presumably the schematics are versioned. Which version is the patch
moving the DTS from, and which is it moving the DTS to?

Andrew


