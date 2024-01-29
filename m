Return-Path: <linux-kernel+bounces-42379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D1C5840088
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 09:44:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 812901C22ECA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 08:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9114D54FB8;
	Mon, 29 Jan 2024 08:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rong.moe header.i=i@rong.moe header.b="DXxE1CBh"
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACD154FA8;
	Mon, 29 Jan 2024 08:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706517626; cv=pass; b=mEXbsk34aif+sTr6TcWOGDb4WZkW3UMRrB+N/iEctVl68gTH4gp5Wmay/UPpj+GYFwzFc2N61b9tiw0K1Evxa/sqaAGsD1V2tXXvPkRBhbI2W+FD4yQccfHaUSpks4V0Mi49ax4FZELPLkDdwKjCGrX/LU25L2k8U2QHIWY0Z2c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706517626; c=relaxed/simple;
	bh=t9sIY05pCRq8hUQ7qfGavTMxoTFFcUrKXiXggNwnA30=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uuexOtDvSUJlReir3EsfhzSJRyG6M2gZTMa4cwl7uvNG54OXGbdGfoTDX/fOf0luKsNTBtOKtLZMzCCyNRCf9QETCMod+D8FkG+Ai49Ze5PxOVYOIBqnAzdTwBOjbZxdy+CpOl5gfwF9HhSAFcFoDIK8k/JmIW86HYxEeRLTJt8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rong.moe; spf=pass smtp.mailfrom=rong.moe; dkim=pass (1024-bit key) header.d=rong.moe header.i=i@rong.moe header.b=DXxE1CBh; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Delivered-To: uwu@icenowy.me
ARC-Seal: i=1; a=rsa-sha256; t=1706517619; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Lw8ZG0VUrGMa0V39ymB6Z2QZexcVUepY5pmuL1X7yPYXFWZfyb78dtb3FQriZo7/YoHiVSx68FR8zWwp7/UXCu+L/vebDIT+2+vCmMLHcVPgGo88jHdCWNGTkEQoSEttGZQKbp6V9hdvnC6/eqDS9cIIsCqsj2ClR7gb9eyTkDM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1706517619; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=t9sIY05pCRq8hUQ7qfGavTMxoTFFcUrKXiXggNwnA30=; 
	b=cz1mEdRXDu4vzKhhWI27EY0Yo//+Z+q5Jwahn/a/8ky0IQEWFtlNGzgI0hIa4IxRzHs+FproPj/YRUqcoTDgzU0lD0+XSyB8mnBkkyc9HsIqdJahoK3Tdmb9aVnrtHOy0KPNqkFRK1B1ap9s1pAZceX8QfDUwEUwqA/584YPJbs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1706517619;
	s=zmail; d=rong.moe; i=i@rong.moe;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=t9sIY05pCRq8hUQ7qfGavTMxoTFFcUrKXiXggNwnA30=;
	b=DXxE1CBhSS+Ii028GqJ5Auz5j5yv7i+PfpMClrgFkhoinCT1wqFp7uFJfKiyaRFi
	iP9RVLqi5PbEaZfEtVD32sXYR/Ffpgb6UMzhbOBMBZ0Ts3jzTlOT4gwwHsoR1KwA1Zq
	dMVlOWZAslqOmn3EDKoaekxyAI3wY8Uq6YNy8swQ=
Received: from [192.168.8.238] (149.248.38.156 [149.248.38.156]) by mx.zohomail.com
	with SMTPS id 1706517616557896.7006883737887; Mon, 29 Jan 2024 00:40:16 -0800 (PST)
Message-ID: <456b4faf8d2e06423bf66ebe1ff1462230354a84.camel@rong.moe>
Subject: Re: [PATCH v2 3/4] dt-bindings: arm: qcom: Add Samsung Galaxy S5
 China (kltechn)
From: Rong Zhang <i@rong.moe>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Bjorn Andersson
 <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, Rob
 Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>,  Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Icenowy Zheng <uwu@icenowy.me>
Date: Mon, 29 Jan 2024 16:40:09 +0800
In-Reply-To: <780e32ce-809a-4ce5-87ec-10f8d6248d31@linaro.org>
References: <20240127172155.63624-1-i@rong.moe>
	 <20240127172155.63624-4-i@rong.moe>
	 <780e32ce-809a-4ce5-87ec-10f8d6248d31@linaro.org>
Autocrypt: addr=i@rong.moe; prefer-encrypt=mutual;
 keydata=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
	cMTsfqztU+orM
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3-1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ZohoMailClient: External

On Mon, 2024-01-29 at 09:20 +0100, Krzysztof Kozlowski wrote:
> On 27/01/2024 18:21, Rong Zhang wrote:
> > Document Samsung Galaxy S5 China (kltechn) as a klte variant based on
> > msm8974pro. Also including "samsung,klte" in the compatible chain as
> > kltechn works fine with the klte DTB except for LEDs and WiFi missing.
> >=20
> > Signed-off-by: Rong Zhang <i@rong.moe>
> > ---
>=20
> This is a friendly reminder during the review process.
>=20
> It looks like you received a tag and forgot to add it.
>=20
> If you do not know the process, here is a short explanation:
> Please add Acked-by/Reviewed-by/Tested-by tags when posting new
> versions, under or above your Signed-off-by tag. Tag is "received", when
> provided in a message replied to you on the mailing list. Tools like b4
> can help here. However, there's no need to repost patches *only* to add
> the tags. The upstream maintainer will do that for tags received on the
> version they apply.
>=20
> https://elixir.bootlin.com/linux/v6.5-rc3/source/Documentation/process/su=
bmitting-patches.rst#L577

Sorry for forgetting that. I will check more precisely the next time.

> If a tag was not added on purpose, please state why and what changed.

I meant not to add your Acked-by because the dt-binding has changed
into a different form to make it consistent with the kltechn DTS. I
should have stated it but hopefully it's not too late to ask if the new
dt-binding is still eligible to receive your ACK.


Thanks,
Rong

