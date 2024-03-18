Return-Path: <linux-kernel+bounces-105703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB11F87E304
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 06:22:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 410002825B2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 05:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B69219E1;
	Mon, 18 Mar 2024 05:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="I5X9AZUi"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F8521350;
	Mon, 18 Mar 2024 05:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710739360; cv=none; b=WafksYlvMFKn2Ez672QesuNdGCdSmkphWSDJkr2HAxLq2g3zW9QfWrsV5ahY+llyt/KDjBpzUXtr8O3xPjnWklLD7mb+RxYURj6KLs5pYFPE1Hw/CmzEINPumDGlpuqMVEQ3jcH8Z6e8lN1+2+nUvirDj67MIMkvZF9GRLuYraU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710739360; c=relaxed/simple;
	bh=DgHkJtjU7wzGWC3uSqVvyW2ZRmMq2yZexPiOj9KVWkU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eKjWrMlQ4UQS4CnuwZifwTxaZKRbS1nUOVJHIcdUD4Wsd5j2x2/JwpZOuNJ8sLct4cSn+tszJzqVcvMKEeFeOI9O8EnjI7GTtSsx+kNmZ3FhfTHfx3ig9/JVC4RFoEFXQqwWZzAoO2Urw6YjPeRDP6gNDIwxisvXJaJnJ1EcPVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=I5X9AZUi; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Received: from [192.168.68.112] (ppp118-210-177-226.adl-adc-lon-bras34.tpg.internode.on.net [118.210.177.226])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 4FA0B20127;
	Mon, 18 Mar 2024 13:22:27 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1710739350;
	bh=kljGaswYbucYPBzo1dhSAlIuez+sBxmTUtphzAySq2g=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=I5X9AZUi/jcObcfcchlCNtFqnGAP0te+ANL7qRw31ZDtBMGHU/Nnq59TZoTHBtr5D
	 /XkVEUwo41QbmDkAJNKJlV0LlZru2ki0ua00RVKJi05r36SZVHoLGmuzt7WAPxDDTi
	 LKezi8SvtgAjmUtgq+tAGqwZWAdgVVYnKrje4THQQGmifN23Fj33QyaJeSvz1ckwtq
	 QTVyDHtshJfH0WW/OhnlIRPcS8q4Az/94S4ai1pmkVO2J5H/csNxWnMmHjh+ubhhGC
	 SAyitx2KSCH+y8SAPy5WATohqRNFAV1LIzsnPHyKUlmwpzcXCnGYJBxR5Or8cbi/2k
	 jXYBxos45l9aQ==
Message-ID: <25d9939b599cdd40cd47027a86bca63f0acc271f.camel@codeconstruct.com.au>
Subject: Re: [PATCH v6 00/22] Add i2c-mux and eeprom devices for Meta
 Yosemite 4
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>, patrick@stwcx.xyz
Cc: Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
 Joel Stanley <joel@jms.id.au>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,  linux-aspeed@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Date: Mon, 18 Mar 2024 15:52:24 +1030
In-Reply-To: <20240312061556.496605-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240312061556.496605-1-Delphine_CC_Chiu@wiwynn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hello,

On Tue, 2024-03-12 at 14:15 +0800, Delphine CC Chiu wrote:
> Changelog:
>   - v6
>     - Revise i2c duty-cycle for meeting 400khz spec

A quick spot-check suggests that my comments on v5 haven't been
addressed. I didn't receive any replies to those comments either.

Can you please either discuss or implement the suggestions before
sending the series again?

Andrew

>   - v5
>     - Support medusa board adc sensors
>     - support NIC eeprom

