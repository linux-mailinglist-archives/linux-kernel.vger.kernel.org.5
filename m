Return-Path: <linux-kernel+bounces-47616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72BDF845045
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 05:25:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 278741F2547E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 04:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 384153BB43;
	Thu,  1 Feb 2024 04:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="fQrSd4qc"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8763BB53;
	Thu,  1 Feb 2024 04:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706761487; cv=none; b=oQUkowmY8EK7/ouDL4rtsbeu187StIdDZxlLSyjl33HJ2vpmga7/26SMhNUoNM0giDRwSiXz5UciOBWpqPJafccpGrQjMliXG3FweW24d5q/G7jm/65CUfyeHtogZHhr4+LWMe/87ekBmza/00LZ9msn0QppxupYWB/ZeNrwxe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706761487; c=relaxed/simple;
	bh=U4sISEKt02jIu1Z70tHRx14a4uWJpHeazAZDZYIWDZ0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jTDlFzTV7aGdu1MT17nAOE9VepnVTZJOU4NIVH0oSArGB6VDwu+rCClvt39C8oPXh0u9gNwXSnQXF4SPYYwH25TpLrfUSgAnFRVvLXyttmhUfx5B6ubZjLtmVfM3GxSbsi+QvpeTjIXLK8Lm63AFMEUuxmCz/Mm1U7OFxOdhB9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=fQrSd4qc; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Received: from [192.168.68.112] (ppp14-2-76-194.adl-apt-pir-bras31.tpg.internode.on.net [14.2.76.194])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 196E3200EF;
	Thu,  1 Feb 2024 12:24:42 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1706761482;
	bh=U4sISEKt02jIu1Z70tHRx14a4uWJpHeazAZDZYIWDZ0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=fQrSd4qcCD1tjNXsDT3wL5kJC2lI0+MVKcom50SIcV2a+OCf8DeFwYpsOZRquNJ/3
	 85+CmQIuTwm1ep70RYPFxzPSR4QfCCHI7euRbtaooLRBp5txKgr35wVgwf0S5rmY9w
	 vcg9QsRjN5BxpkEmgLAKwOJzCbZIozrtE365pmd9mNMamDfIzWViEF2yA6LDrtHaBp
	 qq7j+kZmzJd+NE11FfMZjTCnWxKs/A3lNobxPbK/iNNCj8LliM/T0klNJKc1bsss4T
	 ajzL4TB26ZCReL3+hAWK3EABkO3h720Yml2WRF8baLsfocOV31xCBPMYblTt9g5CDT
	 CPi0CKrWqGpww==
Message-ID: <b6ebc334da1538034c61bbc1dcef5803ca29ae2e.camel@codeconstruct.com.au>
Subject: Re: [PATCH v5 06/21] ARM: dts: aspeed: yosemite4: Revise power
 sensor adm1281 for schematic change
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>, patrick@stwcx.xyz, Rob
 Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Joel Stanley <joel@jms.id.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date: Thu, 01 Feb 2024 14:54:41 +1030
In-Reply-To: <20240131084134.328307-7-Delphine_CC_Chiu@wiwynn.com>
References: <20240131084134.328307-1-Delphine_CC_Chiu@wiwynn.com>
	 <20240131084134.328307-7-Delphine_CC_Chiu@wiwynn.com>
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
> Revise power sensor adm1281 for yosemite4 schematic change
>=20
> Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>

I'm not enamoured by the lack of a description, but at least the
subject provides the motivation.

Reviewed-by: Andrew Jeffery <andrew@codeconstruct.com.au>

